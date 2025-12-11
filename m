Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525A6D41C01
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 08:06:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF8FD83C7B;
	Thu, 11 Dec 2025 09:05:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DD+S3340";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E98E083BFE; Thu, 11 Dec 2025 09:05:50 +0100 (CET)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 211BA8389A
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 09:05:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-644715aad1aso825383d50.0
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 00:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765440345; x=1766045145; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xT1PkRZkPoSY/05kWilZPcaAy03rBdQEs8MCVxtguD4=;
 b=DD+S3340YGkamkqQnMG30Tr5RmgcC9W8SUDfA/Az9jWh+srHBGNZEsf/JRoYHsZb/r
 za+7ksYRFZ0xCGf71ndl8DtV+HEhyg5M1GSlNqcmer4VPGCr49BbyjQgAtvcoQOXhYeU
 pDlFw0gLi8975cNpJ2Qfn0/cEqCa2n7WGJk7RTCI8w0gFpuS6q4wLLvLpJ0yNZ8RjLuW
 c9HHIWjqldYz7GrhEN/Ugj7Ufh89yugagjTTNk2ZFWTxyowKcsIo6fruTUcv22Zfhn6Z
 FyQHeH47+0799/ICwNL4ztN14GHti0tFuzAwEXUN/blPLN12gnxX/qHheYlQkjqH+tNz
 U6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765440345; x=1766045145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xT1PkRZkPoSY/05kWilZPcaAy03rBdQEs8MCVxtguD4=;
 b=eEf3ewphI+0Nnd4YeHOZClusEBuxbXn1FT3XIpQ0olTdiD4yBoJu6/vsd6znQFm51u
 OgFmZPzKlcXC7JUDg7NA0cQr/4iPDmd3CTvFXFsqgSzL7UUO8rBoPxMB2Dw7gJ03gUOX
 Ey5V6/T1JTG/+MfrmddV9utXnyYQJpiYgayusC8WRPY6QKmcvKBV8bhBPuhssAT5Xhfv
 mftUc1pFc2Uw5vXTeFYOwVTrR8vrGYhHmqVjVz1kcQ209LNAf0FDvcS9qZdR2IhlBFZo
 YYPKsc04SY6SeR7vmvJo26HnXIUvYmra6qDzqZeb+z7HoIg644upyabvlHJ8RT4sKDLI
 odRQ==
X-Gm-Message-State: AOJu0Yx4A1aFARSYmYlBM1WuhAW8i2uHlVHM7oKVbfL5Yu9CV6p9MY/Q
 c+pw56tfTdFm+pO3gABxyHHtVd764UET3JZ2PTBYvgNKxvdHwRbL99txVGhf
X-Gm-Gg: AY/fxX7lyTd8vVFIC/s1b5NAqH68f38z7UUjnW7sdp2K30mTJlVWflh4/8hCf0It9/W
 MceQzOEfLneNrN896VKutG5qwHAzN0whi1S3gjwSMjtvYRvl2EoH/eDd11Sb+pGa5j+Do+O3t5Z
 n0w5fjofQhMivWxBs2Jnzesb++WNvDF0xdcsgN8H3F6lT7t8vIXOSxUUZ+XKB4nrsBoo3ELkohz
 F74yrCuydWFDWtIA14uFCHn9sF8QgT5Pw4eyzBAIHgHYk/iRjFGWuZJ+SYHnnSg2uGLHOrogiqm
 4VYB2nYRf6NIq6XSgTAG18lWmznHyz1qFYn79j6ju7OYgylY30s3SDkxD20fKfhoEuSpl43tuHj
 XVU6FBXEM9l0iWyAqeyGzf9mH+WWLiCqYf9+YmHxjrhOD9xdKM1CQQ3XF+izhCiT7q1x4hu9Noy
 ivmqjk23xQdqSEvANWA+rKhxkNDA==
X-Google-Smtp-Source: AGHT+IHbv0YY0s5q6Xx2lK7lLoX7zVX3TQGGQ3/CXratpmIKz1+Rbt4XfXXILpr0shrFn5dfyA3PFw==
X-Received: by 2002:a05:690e:1918:b0:63f:b985:66b5 with SMTP id
 956f58d0204a3-6447a774aafmr875449d50.6.1765440345504; 
 Thu, 11 Dec 2025 00:05:45 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78d69d83a85sm7256657b3.28.2025.12.11.00.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 00:05:44 -0800 (PST)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com, Utsav Agarwal <utsav.agarwal@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Tom Rini <trini@konsulko.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Subject: [PATCH 01/12] mach-sc5xx: Introduce Kconfig symbols for image
 addresses
Date: Thu, 11 Dec 2025 03:03:52 -0500
Message-ID: <20251211080414.5363-2-malysagreg@gmail.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251211080414.5363-1-malysagreg@gmail.com>
References: <20251211080414.5363-1-malysagreg@gmail.com>
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

From: Utsav Agarwal <utsav.agarwal@analog.com>

Add Kconfig symbols to parameterize the SPI flash layout used in a
default-ish configuration. This adds more flexibility to the default ADI
environment, enabling customers with boards based on but not identical
to an ezkit to reuse more of the infrastructure. Furthermore it allows
for yocto (the expected default) or binman (to be introduced in this
series) to configure or use the flash layout based on a single
definition of all of the parameters when creating an image.

Signed-off-by: Greg Malysa <malysagreg@gmail.com>
Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>

---

(no changes since v1)


---
 arch/arm/mach-sc5xx/Kconfig | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/mach-sc5xx/Kconfig b/arch/arm/mach-sc5xx/Kconfig
index 30444f04fc4..70c7e5e0631 100644
--- a/arch/arm/mach-sc5xx/Kconfig
+++ b/arch/arm/mach-sc5xx/Kconfig
@@ -117,6 +117,36 @@ endchoice
 
 endif
 
+config SC5XX_UBOOT_SPL_OFFSET
+	hex "SPL offset"
+	default 0x0
+	help
+	  The default offset where the SPL is located.
+
+config SC5XX_UBOOT_OFFSET
+	hex "U-Boot offset"
+	default 0x40000
+	help
+	  The default offset where u-boot is located.
+
+config SC5XX_FITIMAGE_OFFSET
+	hex "FitImage offset"
+	default 0x1a0000
+	help
+	  The default offset where the fitImage is located.
+
+config SC5XX_ROOTFS_OFFSET
+	hex "RootFS offset"
+	default 0x102000
+	help
+	  The default offset where the rootfs is located.
+
+config SC5XX_LOADADDR
+	hex "Load address"
+	default 0x90000000
+	help
+	  The default load address for u-boot.
+
 config ADI_IMAGE
 	string "ADI fitImage type"
 	help
-- 
2.49.1

