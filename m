Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75953C02198
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 03:23:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5322480F12;
	Sat, 15 Feb 2025 04:23:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VKSkWNJd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7042680F0B; Sat, 15 Feb 2025 04:23:27 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 101CF80EE5
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:23:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-854a68f5a9cso214122639f.0
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 19:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739589803; x=1740194603; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kf8ylOqXl7b1+wgxiJRAoemFpGeDbA7ml1e9ftAQ2ck=;
 b=VKSkWNJdJMHPjolXMeGarNP3aHQc3zb03iY9B7psurw0RFgxBifCSe6mx23GnYZKrE
 nyr4INSHhbvmx3e9WhlNIh+RbI1sVJkvIv5o2sxGB5RClewAENHAlmbiXXeRh3Eu01BE
 TiQFxsLVNUfTqMZK/sE3mMWoeIWsXS+ATgKW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739589803; x=1740194603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kf8ylOqXl7b1+wgxiJRAoemFpGeDbA7ml1e9ftAQ2ck=;
 b=gHJIMUsvsc2A9c4KuMyZ+0wvq1YeBqc2jdnZC+8CpmKRxbTtICVYWnFyuTslme9n1l
 pTZTaTwtexZELS28lWGblUkQmZqN4oTn9JSvcC8BbkIOLdzCSojW022nEA3Qk7WM4z0N
 IkInzBeWoBFTb3pl2jU/HR8FMycxLF71QLhHZtyw6bxCcxtM080sMfHadmXbZCX0cEiH
 BbikSXNMlz0XzP0+qivn5cQeREHt5fABSLv7LNZHV04CvF7USv0UW5e46ec97FPTQj14
 0ZaFaKqZJ/yVaIbaNFjHp7UChgRaU/s+sp2nCPZVjjUKQp2GZwkkijj+jBk9ArhAgPDn
 ca8w==
X-Gm-Message-State: AOJu0YyfAJUHL2SdC0O1nH7Cfl5ACLewQi3T8wlNqsO+1F/ZunNTbpV2
 MqY3SBwmwPR6Jbvx1ORRYNtKvsV//iZjLwBxKCCAniR9lK850uEA8rYd6fUBhZDzGCzDc0mNe4o
 =
X-Gm-Gg: ASbGncsvMKOsRpn4af+Z2C6mgzPjvlw4dcyFNkxFSiZKAM78f5JSnZIMHUWaUUnvF1V
 x9LH+5S3zQTZv+wPkNpxk77cOJonlfOTQh3++Dh93V0pJPJl9ejtO3cVj+xzNj/Dms4lYxS5zfp
 LOArsncvalM0C2A+Ao+KFU3znaIEHrJnafjEwVZdRJe/Vv+Pd0UzMkOydCbI5EH0EW3V0Uy3061
 dGL+nooaZw+YJvyiHICrCYuuRDv7LD+C7SWi2cIHNpA/Y/JVYPgPIODlmOMKrVFfEoyAnQbR9vo
 6Q/5UrhpvT2DApYqtyzDO2dZ/RpMfpbuQjS+JzrG+qipp+ZgF8Zx
X-Google-Smtp-Source: AGHT+IHuhCd/iQY4e21ES96p2+W167GtZ21Abt+NecMQGA//TF+8dmtf3JwJSEaVLSEZY+JrUbxL2w==
X-Received: by 2002:a05:6602:6d0b:b0:855:7707:807f with SMTP id
 ca18e2360f4ac-8557a134f89mr166875039f.10.1739589802861; 
 Fri, 14 Feb 2025 19:23:22 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed2819d0f5sm1087697173.67.2025.02.14.19.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 19:23:20 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v4 06/29] efi: Allow board/efi Kconfig to be used outside x86
Date: Fri, 14 Feb 2025 20:22:27 -0700
Message-ID: <20250215032254.4121030-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215032254.4121030-1-sjg@chromium.org>
References: <20250215032254.4121030-1-sjg@chromium.org>
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

So far only x86 supports the EFI app. ARM is going the same way, so
allow these options to be enabled for 64-bit ARM too.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v2)

Changes in v2:
- Drop the word 'Sadly'
- Mention '64-bit ARM' here, rather than just 'ARM'

 arch/Kconfig      | 2 ++
 arch/x86/Kconfig  | 1 -
 board/efi/Kconfig | 4 ++--
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 6258788f53f..493c827d74d 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -544,6 +544,8 @@ source "arch/Kconfig.nxp"
 
 endif
 
+source "board/efi/Kconfig"
+
 source "board/keymile/Kconfig"
 
 choice
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 23a1e21b29e..80396a3a2d5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -100,7 +100,6 @@ source "board/advantech/Kconfig"
 source "board/congatec/Kconfig"
 source "board/coreboot/Kconfig"
 source "board/dfi/Kconfig"
-source "board/efi/Kconfig"
 source "board/emulation/Kconfig"
 source "board/google/Kconfig"
 source "board/intel/Kconfig"
diff --git a/board/efi/Kconfig b/board/efi/Kconfig
index 9027ca8482c..7545f808585 100644
--- a/board/efi/Kconfig
+++ b/board/efi/Kconfig
@@ -1,5 +1,7 @@
 if VENDOR_EFI
 
+if X86
+
 choice
 	prompt "Mainboard model"
 	optional
@@ -33,8 +35,6 @@ config TARGET_EFI_X86_PAYLOAD
 
 endchoice
 
-if X86
-
 source "board/efi/efi-x86_app/Kconfig"
 source "board/efi/efi-x86_payload/Kconfig"
 
-- 
2.43.0

