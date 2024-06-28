Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979ACC2BBCA
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 08:34:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 139C68857C;
	Fri, 28 Jun 2024 10:34:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kV1wpPXE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07A5888581; Fri, 28 Jun 2024 10:34:19 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C779E8825E
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 10:34:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ebe6495aedso3201551fa.0
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 01:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719563656; x=1720168456; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZI0XrNdzBlvmYL93KmYHyynRSCi1x2gjGLwnfloHtis=;
 b=kV1wpPXE5p5fxR1fEe99LF2SxsvNqy0RrldyNOqpCuIg3+Yl7E4Sv/kDrVK/Q2ZQw4
 1sN/9eWew6YfWhPS0+o1bIzQDRrboRPo0hWxzsqwM3fXLFwOthjnwHeXQSyMK47oU7vL
 cLmloB5tJQxoPH2xuQ1JLZ5Kma4DiByeKbAUPbGVlTAbvTm091U21Bmqzr7E4cc9sWc9
 f2xvARmo3orsin2uBSBaD2BvLfOEvaKQ2R8LZFPIl2Tc+Sz7GGz1OdJ++4UTnbUD5l7T
 3l0r2EvnBPDjn/WKQwEbkHjf9QPbHTHmnekfEpLTv4P+LXxdB/IxS9++BDjyWEs+5XX5
 qwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719563656; x=1720168456;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZI0XrNdzBlvmYL93KmYHyynRSCi1x2gjGLwnfloHtis=;
 b=nuy5KpXsyIAgLHj0Fj6LpB57rx8WBZ8S51EI+tCaRuzL7pNl8RrtwiQCk+UUqX9VO4
 C6L5f0+ZMpfeqy6GczqVBPdPVfZS8g3o6/x2QGo8U0s27wipsXUbBVUm8HVfCtkZdPr0
 +IdmrWIEC94gZAptz14E6KwipnufrladffltddH+nApqwPoA6FRal2ceFb9bV3rpEbIQ
 utV9/Ims+DBskflHdsWQGEimkkwqvl3jwRCWSeaz7Zi5XRli0TbsA7UfnltqLzL8rBhC
 DhxILzuzRSZaGWlWb3saDkKIyKe2n+lnH/O92t5EniQFB0zFKpS3AwB3lBrytHzxTrH5
 RMfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzxOVFJ+kn8tJ/c8QMtTHvbvb4m7iuI+7uZcUW3GV6C0lkBwIHYvxFxALnj9bUyfkeZQ79GcxLOPn9aTnokTKYgUw2cw==
X-Gm-Message-State: AOJu0YwotzbQHAS19CeEfwkpKPF4JbUTBF/FDN/XvfMYkiJLKWpXcmvx
 39d+TiCH7xh10pyp+tiU8nKkISXJgAEZmsH3KKFlUvVBSXNPQD/yt84VDA==
X-Google-Smtp-Source: AGHT+IEyJKEZFreILMUw+8Zi8Pn5QBn2OdIyZvUQoMHzIKp/8AhCJzt26m67xkVGCG8Qce1kAOjlCg==
X-Received: by 2002:a2e:9213:0:b0:2ec:53a9:2036 with SMTP id
 38308e7fff4ca-2ec5b2f0491mr103923801fa.37.1719563655736; 
 Fri, 28 Jun 2024 01:34:15 -0700 (PDT)
Received: from moskalets-nb.avp.ru ([2a00:1fa0:48e3:f865:bc1e:8502:f048:8db9])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2ee516803c4sm2196491fa.93.2024.06.28.01.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 01:34:15 -0700 (PDT)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: trini@konsulko.com,
	u-boot@lists.denx.de
Cc: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>,
 Maxim Moskalets <maximmosk4@gmail.com>
Subject: [PATCH] cmd: add resize for FDT in bootelf
Date: Fri, 28 Jun 2024 11:34:11 +0300
Message-Id: <20240628083411.19843-1-Maxim.Moskalets@kaspersky.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

In some FDTs, there is not enough free memory to add nodes, so this
operation fails.

Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
---
 cmd/elf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/cmd/elf.c b/cmd/elf.c
index 32b7462f92..673c6c3051 100644
--- a/cmd/elf.c
+++ b/cmd/elf.c
@@ -68,6 +68,8 @@ int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		log_debug("Setting up FDT at 0x%08lx ...\n", fdt_addr);
 		flush();
 
+		fdt_set_totalsize((void *)fdt_addr,
+				fdt_totalsize(fdt_addr) + CONFIG_SYS_FDT_PAD);
 		if (image_setup_libfdt(&img, (void *)fdt_addr, NULL))
 			return 1;
 	}
-- 
2.39.2

