Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C30C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:37:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A206D81FEE;
	Fri, 28 Mar 2025 16:36:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BzXNqy/I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ECDA81EC0; Fri, 28 Mar 2025 16:36:07 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67DA181E6C
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:36:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-855bd88ee2cso62006839f.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743176163; x=1743780963; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RDrff88bBl3XAwARKk10vpOEHIRePYZ1Df3A9cnqj1Q=;
 b=BzXNqy/Inno4ye+Jn2cZn6nzci5BOWqajj7OakVRhHNJ+7chwu+cvBSJRmRaZ38xU1
 EIu/o6N365y0KyccwJqLTgbWI5DSIahcQRld1jnapVpJKA6T/JP4X8TOtvkz+u5pTyX+
 EV7whyYfRJDLWbMMmsaX61U+6RFtWSZ2FhraU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743176163; x=1743780963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RDrff88bBl3XAwARKk10vpOEHIRePYZ1Df3A9cnqj1Q=;
 b=A0FHIqNZC0AyA3yctuZm488beAK1n29VBeyNhuE4u9Gjztuoo/4+HLvkGKSQz47+X3
 W/CBeYJVle+m5BQAGqdb9cdfP9g+rGZx0VAjA2alSHGzcD9VqTi73VS+X7aT92bnNBox
 7UAN/Lgw+gFYND70yjwLj3rRKMclNjIRFsJTCBTzKA3N5fBfaKOrSUvkf/FQQ5r8lwjR
 F7+I7UsKpzxEclN/71C8n5cmiFnk2nlhEnt2bbSjsCr0dxAnOYPTOEPKigSst0YyswU7
 9MPggw9YZtHrb6evjKJzeQ7l74xa6Q+5uMOt9EYRsOng35UmZ3hCWjlqGDYqzWWyphzY
 O0Lw==
X-Gm-Message-State: AOJu0YxwW7xmp1mTBQpk82CH9rDtIKgVF/DiYD9vrWITWILqz9GPSvJU
 oNzmuyJCNn08MtXgY2K9/qvR6s8LRO6ZbsIsz0Som5ABoZFihzbTlfTF/Wg9KSu2GDEkzNweYbE
 =
X-Gm-Gg: ASbGnctUfNkT6O/Wf9Xb4b2D9J+H2fPNeBXYx98Veahj3a7+AMYBEibmpByTYaDD/9T
 vzBRr7mTeySyHEDEGz+ZNEKPqPRYBzqCD94iv+rqO5o2kKWV98FSxyt4HnT+sKohLR2B+P2XjL8
 ZvWN8JyBUiquPWU1tNk4DP8fDqD76zW7YbmzpaRfDZNIeq9Xa6oIxh8BvZxZfkbgnhm7ZjjGnoj
 SfeRbsyEhOaA9+kJyu4ka0PauqZzbLKNgNpLMX51c9i9LHOBSE7Jcz/rih3TZ7479tNXBpfg4hc
 2d0AHSHkrdDVTgfb0xiGhym8E6sfcuoTNp011HtPvpFYJWJxwTD4pvqgBu12eWfA7iH7hlk6Kcp
 9jPEOCA==
X-Google-Smtp-Source: AGHT+IHGpGYy/bLLcEe25ma9N4+hOxf2F3+CfVHhbiYltqz0krbaQlWSxtYagaIT085vlZAMDIOhHw==
X-Received: by 2002:a05:6602:7505:b0:85b:4940:65ab with SMTP id
 ca18e2360f4ac-85e82081f48mr1009344739f.5.1743176163254; 
 Fri, 28 Mar 2025 08:36:03 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f4648714b4sm484922173.87.2025.03.28.08.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:36:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v3 11/31] rockchip: dts: Specify the phase in the image
Date: Fri, 28 Mar 2025 09:34:51 -0600
Message-ID: <20250328153522.3555472-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328153522.3555472-1-sjg@chromium.org>
References: <20250328153522.3555472-1-sjg@chromium.org>
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

Add 'u-boot' as the phase for the images intended for use with U-Boot
proper.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/dts/rockchip-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index fb304540787..465f54b8b09 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -52,6 +52,7 @@
 				compression = COMP;
 				load = <CONFIG_TEXT_BASE>;
 				entry = <CONFIG_TEXT_BASE>;
+				phase = "u-boot";
 				u-boot-nodtb {
 					compress = COMP;
 				};
@@ -70,6 +71,7 @@
 				arch = ARCH;
 				os = "arm-trusted-firmware";
 				compression = "none";
+				phase = "u-boot";
 				fit,load;
 				fit,entry;
 				fit,data;
@@ -89,6 +91,7 @@
 				arch = ARCH;
 				os = "tee";
 				compression = "none";
+				phase = "u-boot";
 				fit,load;
 				fit,entry;
 				fit,data;
@@ -111,6 +114,7 @@
 				compression = "none";
 				load = <(CFG_SYS_SDRAM_BASE + 0x8400000)>;
 				entry = <(CFG_SYS_SDRAM_BASE + 0x8400000)>;
+				phase = "u-boot";
 
 				tee-os {
 				};
-- 
2.43.0

