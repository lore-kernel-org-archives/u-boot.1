Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4184DC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:28:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5510D876E0;
	Mon,  4 Dec 2023 01:27:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d4bCSvEj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 777A4875BD; Mon,  4 Dec 2023 01:27:35 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69F34877BF
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:27:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d0aaa979f0so1016235ad.0
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649650; x=1702254450; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=euF+RcUntEjaUTCXVbIO8CoJbI1F9ya1VrW3wg3PCpg=;
 b=d4bCSvEjbjOcPgQWk2Kb77lUMTI2cXAEacKjr/2hGsqEMWSCulhXpvvETzrhbXDxc0
 zci3rJb0ACaHUnW1gjzpEUn8nHAqv59WwkTNgVo00arUBKVYBqd/Xi0UnDbhzVxeI6bZ
 jMqOV/kVutzzTPXJv6JCBYpwhNT+zxd7vHhb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649650; x=1702254450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=euF+RcUntEjaUTCXVbIO8CoJbI1F9ya1VrW3wg3PCpg=;
 b=lF3x0lTvatezxjwyOjh3wYxXumwbbynGj0bVt875VAxK39lOcoN1gZk6YsknOvDNoV
 DLns9uCZEUbUe+gbAbHVFn4ol27+fzx/RtHDnMv03fbM17WInwPyVRXfdgrq+6a7lu3U
 9U90cc93hihd/hQ6uIaMccywTsYsWedAyOnYkZIm12uNdlHDoq5KIY00i8GLUxbWqBAl
 xvZluUPsqgOB9dAltPhUczhX+BsKb2iIbiMuo1QD1NeSWC3vHgRU/3MQXPvluAyqJe+b
 45VlO54gVTGavuHnEARNwJP/NrW25lwV0h8xMfob72UNVb/NOJ9T2essGmXM9CxTG1Fp
 nQGw==
X-Gm-Message-State: AOJu0Yy/BxMPKAf3XOsY7nlzK382KHAC+qHX5wZ6yLxXrf2E4ve2AOrA
 sOBZ5vxS8Gd5iGfbI4Zzf/NTMyq9KtZa3HCi+qn8AQ==
X-Google-Smtp-Source: AGHT+IEfkJAK0ibsUElF+j7VmJysPwndTq+xuUXR/aRlqhyg7fgvBtxwlKMoUyfePnDcpSlt7HCdMA==
X-Received: by 2002:a17:902:e80e:b0:1d0:6ffd:adfd with SMTP id
 u14-20020a170902e80e00b001d06ffdadfdmr1002312plg.100.1701649650641; 
 Sun, 03 Dec 2023 16:27:30 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a170902904500b001cfb971edfasm7097227plz.205.2023.12.03.16.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:27:30 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Marek Vasut <marex@denx.de>
Subject: [PATCH 07/18] mips: Add a reset_cpu() function
Date: Sun,  3 Dec 2023 17:26:23 -0700
Message-ID: <20231203172622.7.I2c0bbce52ecf7ce9458c481fbd12b6029e5ebd27@changeid>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204002642.895926-1-sjg@chromium.org>
References: <20231204002642.895926-1-sjg@chromium.org>
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

The current do_reset() is called from a command context. Add a function
which can be used from anywhere, as is done on ARM.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/mips/cpu/cpu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/mips/cpu/cpu.c b/arch/mips/cpu/cpu.c
index acfc9dc43f17..443465047715 100644
--- a/arch/mips/cpu/cpu.c
+++ b/arch/mips/cpu/cpu.c
@@ -4,6 +4,7 @@
  * Wolfgang Denk, DENX Software Engineering, <wd@denx.de>
  */
 
+#include <cpu_func.h>
 #include <command.h>
 #include <init.h>
 #include <linux/compiler.h>
@@ -20,9 +21,14 @@ void __weak _machine_restart(void)
 		/* NOP */;
 }
 
-int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+void reset_cpu(void)
 {
 	_machine_restart();
+}
+
+int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	reset_cpu();
 
 	return 0;
 }
-- 
2.43.0.rc2.451.g8631bc7472-goog

