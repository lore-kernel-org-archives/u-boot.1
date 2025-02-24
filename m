Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008CCC021B3
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 05:57:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AAB980FD8;
	Mon, 24 Feb 2025 06:56:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VlhIhQ7M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B63F380F96; Mon, 24 Feb 2025 06:56:19 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40CF080F56
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 06:56:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-220dc3831e3so76791425ad.0
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 21:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740376576; x=1740981376; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G22WyyWlEl9X+rXePXGHeOz7PbNzVdpzCOXwNKj1IBw=;
 b=VlhIhQ7MACEvvnQ34A+TEKyNcVlTk8Vjfd+xKmfj4XzphMK2PWIpD1yTxXwLwC+Itn
 YVbLCH/8LzT8U2IIAJQttlLc4c+UDJxq7KP+TzJOz04+x7127yuDuFvga7iSPXDmhYSJ
 JozhXKgyOQ4rUYdhQAihcRBnrPJRGELk+eactypPGW1UCJlaNXkMnu/c6rqBG5AHOmRo
 N/ScpKyfGDDWpBuDU7bQ8C4Lb4fvjw43B2wKIjL+wZFhkJdN1VGXDhlj4PTqGhhWIuVD
 0ClfUw5yY8WL2h57fXtvxJB+UMONo0ZQzIgUnMhcH6yRXpG0Fl9T8LdsGRMURqJuQavm
 F4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740376576; x=1740981376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G22WyyWlEl9X+rXePXGHeOz7PbNzVdpzCOXwNKj1IBw=;
 b=elfWItLWPeHPOYEc/5EF9OiGNmTVEJEtvdQBgA6wp445qEVMx8krX9BbbNT4NJuT1t
 9vuHrCU0Dpy/1pAK8rh/BFxBXyYq92esl2PHIEW2nN/YZNOfmyoLJCGDHkZj3GhN2+PA
 eFofcWqYhbZ+mbJN9Ak6mGaAvc0psONonNrvAF3EVZutlVMQmq2ZTkDBN3iMhOx8Ytxq
 sTfIZt4r4hdffvFDMrYdprSjn+ipb0QRHAUQnLuDndjZWT+iev5yWcV7yfUJ8jMVrUgI
 G7SRViXCMrlXfhYpcorJwq4Ic7cW1k7Tc/JmjbGn87g7S9yn8wolXuGj+ovYRYbFyhEz
 d3jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpI5tPOPYV1hLcRJoGYvIyURLq4MobcErhlcvk+WTBehCuTROFBdU5Tvo1U97wlF962emv7uY=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7Jx1Bma0ZdaAI18WpMO8JoWd8tNqf4hpc+A29Y9Ria8P4+EgD
 76QRlJlujljnXuJz/Z08bpdAfwttHc8+OGa0LTneQfKgAcaCHOnR8tqpXOmEcto=
X-Gm-Gg: ASbGnctgsurqIhVBIPPOXYckfu7PteyRjiXsuT0xJvhv3YaxZVS71F4xHm7eowRWVuE
 0kVRYtBzcyMuLlFym4Ft7c5ycUG1MvE2InhgaYf0D5vAG95QgZTMDg3CBdndgS499N1ZNwB2Wp7
 doFboLZ8hwFFI4AEE139/RWU8jPmrX44odGqVg2CgJVZT5owYnmQ6Sn//d1JNK/AJmC8ar+uUCD
 3/6og1csraz2iun4n5N/j3OLq7m/J6uERBvL1eaAnHHtoLS9GwVX1WfKz1VlaQpo7YZfmV0rRRc
 nXX9WC+26Yf8ypv8mi7PLE+IrZFz4exNSKmMVw==
X-Google-Smtp-Source: AGHT+IHqGcdZJuolz/l/49aSAuGqQ9pGYxuidNbHFIiTeNxNZlsGAimT6MS1yyShOBglDiZxs1TTAA==
X-Received: by 2002:a05:6a00:8219:b0:72a:83ec:b1cb with SMTP id
 d2e1a72fcca58-73413f844bamr23767252b3a.0.1740376575708; 
 Sun, 23 Feb 2025 21:56:15 -0800 (PST)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:26ad:d46b:d078:4cca])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7327e17440esm13511692b3a.76.2025.02.23.21.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 21:56:15 -0800 (PST)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 13/17] makefile: Add `norelro` linker option
Date: Sun, 23 Feb 2025 21:55:20 -0800
Message-ID: <20250224055524.1334929-14-CFSworks@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250224055524.1334929-1-CFSworks@gmail.com>
References: <20250224055524.1334929-1-CFSworks@gmail.com>
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

RELRO is an instruction to a dynamic loader to make a memory range
read-only after relocations are applied, for added security. Some
linkers (e.g. LLD) require that all sections covered by the RELRO are
contiguous, so that only a single RELRO is needed. U-Boot at present
neither satisfies this requirement (e.g. x86_64 linker script currently
puts .dynamic too far from .got) nor preserves the RELRO when converting
away from ELF, therefore add `-z norelro` to global linker options.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 87b07d8989a..c869b5c55fa 100644
--- a/Makefile
+++ b/Makefile
@@ -820,6 +820,7 @@ KBUILD_AFLAGS += $(KAFLAGS)
 KBUILD_CFLAGS += $(KCFLAGS)
 
 KBUILD_LDFLAGS  += -z noexecstack
+KBUILD_LDFLAGS  += -z norelro
 KBUILD_LDFLAGS  += $(call ld-option,--no-warn-rwx-segments)
 
 KBUILD_HOSTCFLAGS += $(if $(CONFIG_TOOLS_DEBUG),-g)
-- 
2.45.2

