Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD92C6FD1F
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 18:12:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E190E88113;
	Thu, 21 Mar 2024 19:12:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="JpJaMR52";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 401BB86564; Thu, 21 Mar 2024 19:12:19 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 516EB880FE
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 19:12:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B3B5E3FB77
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 18:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1711044733;
 bh=aZKynsL6AfsQ/qs706SNOMV0aAt7KafLpPOogyrwxjQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=JpJaMR52CecEqCN8z1oI1WbbhKy5H1QizO2h+6708BMi4TJob9JArgFcniyWZWYW2
 0cD94h6XR00iVc4yzC8Oz5uOaT+Jt7v9gXc2TE97mji8+c3bVQI8AH0gs2z5I7CwAs
 IuDwW1coC7YtSXic9+CWhBGDIqkOAFR6mzJuIEivOnhaoD4Ggr+x+mAtOfZgtKggfi
 A4Q17pydFLLK472xaJkAshNPhUkinlkLLguSPsvv2J3+smhRMYbuwSHkaEv/gjk9Gq
 XyUCgc6Qa7TLVeN0UZ467+POWeKK0LTEHMnUaYhGSqm9RXjOthKl1TeCLXSDm6qbks
 OZq9C8hO3Fb8w==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40d62d3ae0cso8428085e9.2
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 11:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711044733; x=1711649533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aZKynsL6AfsQ/qs706SNOMV0aAt7KafLpPOogyrwxjQ=;
 b=VFByNgcLVwwdIfFEjluxZ41CIwMJSjLMsZvuMz+BNXAxuavX4OV/6S3RzXDWit+i5C
 Y4RBxxmIf691jAPq6+KzYYBtNSIwYNGTiofzeiaDKHgAoxJrbbS90Kt8TzZU/kXkRsMh
 bRLJQkk96qdxXqzIpvFq/cNTZO4Ol3xb45ogCxAXDcfQJ6QU5L6jTw1qjRDVBP2nSYie
 //uB2kwxpAGmqwb84ti0CspPclIKqLLeIiDfclNt++WKZCKZeozMZhlWRo5RGS4UFqtO
 M7rIxv3zskHnzRHl5HZFucoZYQx5c8KkGvOtR8PlzYBeX9lIu/ROM69Orw2D7cyY+nt4
 d5sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiAaP0LCJgdE4rY2dEZ8I3CmorRuzqIsaDRGhAuWXHkRTOaVN7ECXcpwq7GVqbT+Nu0AK1eaB29dpxmuPuGVTPR1OqUw==
X-Gm-Message-State: AOJu0YzdgMJn0qDfetKqFdONJJWUkc4d0mCZR7fk8JWmjoq49y/Joexg
 EArn7d9AU3vACmIUapIjeER2CjQXdI6FWyrYU5MxyHhK9AEnMWwHZD9O69MRtHWd/f+s53OV9mm
 8QiFNFVLYMHrH1yrugXL4vxqE/hafeKXa8ThP6uc0aMC953tjQO0uvJma+S54M5g7eWQ=
X-Received: by 2002:a1c:7708:0:b0:414:5cec:a9dd with SMTP id
 t8-20020a1c7708000000b004145ceca9ddmr2706937wmi.38.1711044733403; 
 Thu, 21 Mar 2024 11:12:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6Yarh7UB/dXHINbRp7WVXH2YtEkcOyItn7L4Sir9IOFHKo3QVg3qOM0/rGmXOWyzO2xwfiA==
X-Received: by 2002:a1c:7708:0:b0:414:5cec:a9dd with SMTP id
 t8-20020a1c7708000000b004145ceca9ddmr2706916wmi.38.1711044733031; 
 Thu, 21 Mar 2024 11:12:13 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 hg10-20020a05600c538a00b004147743bd0dsm1469420wmb.38.2024.03.21.11.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 11:12:12 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Cc: Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Chanho Park <chanho61.park@samsung.com>,
 Shiji Yang <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/6] riscv: do not set default fdt for VisionFive 2
Date: Thu, 21 Mar 2024 19:11:44 +0100
Message-ID: <20240321181149.177356-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240321181149.177356-1-heinrich.schuchardt@canonical.com>
References: <20240321181149.177356-1-heinrich.schuchardt@canonical.com>
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

Currently in set_fdtfile() we set the value of environment variable fdtfile
unconditionally. The implies that a value in the environment will be
ignored.

With the patch environment variable fdtfile will only be set if it does not
yet exist. This requires that CONFIG_DEFAULT_FDT_FILE is not set.

Now the user can either set and save fdtfile interactively or in the U-Boot
configuration to overrule the device-tree name chosen based on the
hardware in set_fdtfile().

Reported-by: E Shattow <lucent@gmail.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	new patch
---
 .../visionfive2/starfive_visionfive2.c         |  4 ++++
 configs/starfive_visionfive2_defconfig         |  1 -
 doc/board/starfive/visionfive2.rst             | 18 ++++++++++++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
index 78e118d5a05..76439179fa7 100644
--- a/board/starfive/visionfive2/starfive_visionfive2.c
+++ b/board/starfive/visionfive2/starfive_visionfive2.c
@@ -49,6 +49,10 @@ static void set_fdtfile(void)
 	u8 version;
 	const char *fdtfile;
 
+	fdtfile = env_get("fdtfile");
+	if (fdtfile)
+		return;
+
 	version = get_pcb_revision_from_eeprom();
 	switch (version) {
 	case 'a':
diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 7a3f1d4dbdf..fa80d489f5e 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -40,7 +40,6 @@ CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 debug rootwait earlycon=sbi"
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="nvme scan; usb start; setenv fdt_addr ${fdtcontroladdr}; fdt addr ${fdtcontroladdr};"
-CONFIG_DEFAULT_FDT_FILE="starfive/jh7110-starfive-visionfive-2.dtb"
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
 CONFIG_DISPLAY_CPUINFO=y
diff --git a/doc/board/starfive/visionfive2.rst b/doc/board/starfive/visionfive2.rst
index abda8ac21bc..2e04c02dca5 100644
--- a/doc/board/starfive/visionfive2.rst
+++ b/doc/board/starfive/visionfive2.rst
@@ -71,6 +71,24 @@ Program the SD card
 This will generate the U-Boot SPL image (spl/u-boot-spl.bin.normal.out) as well
 as the FIT image (u-boot.itb) with OpenSBI and U-Boot.
 
+Device-tree selection
+~~~~~~~~~~~~~~~~~~~~~
+
+Depending on the board version U-Boot set variable $fdtfile to either
+starfive/jh7110-starfive-visionfive-2-v1.2a.dtb or
+starfive/jh7110-starfive-visionfive-2-v1.3b.dtb.
+
+To overrule this selection the variable can be set manually and saved in the
+environment
+
+::
+
+    setenv fdtfile my_device-tree.dtb
+    env save
+
+or the configuration variable CONFIG_DEFAULT_FDT_FILE can be used to set to
+provide a default value.
+
 Flashing
 ~~~~~~~~
 
-- 
2.43.0

