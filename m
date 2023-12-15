Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089F6C4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 04:20:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9723D87B22;
	Fri, 15 Dec 2023 05:19:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Um9pz5z6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20A9C87ACC; Fri, 15 Dec 2023 05:19:33 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2CA987AD1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 05:19:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3b9fd7b14cdso606235b6e.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 20:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702613969; x=1703218769; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iEgB7J6hsLrYRoaXWmBiq87MXmVGCUA5a+v4rnf7LGw=;
 b=Um9pz5z6rIOY2rs6c28Df73XDiJmCg7CYpcVfIXu/iw641saCDoC8zLKioJ4XGW9d5
 rtssIClYHhfAhohYhJNWC73Eo1720S+mmwwQx0GXFHXhFABYyhpKS7RAlodI4F7ulB9a
 euYx5PoSjYAJYYreo347D1dziaZQ4EsZuorww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702613969; x=1703218769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iEgB7J6hsLrYRoaXWmBiq87MXmVGCUA5a+v4rnf7LGw=;
 b=pqcVroB3fRnFePVhefmQA2uBlZ3TOcueY1ouwcwJndPPnx04J4rrOHIvrJL9IHo8xN
 p36l8SlEyCJMOq2NMsAxaewgx2UF3Yqk42OSBD7jRqWPGblNnWuNDmDW9ssqYjnEMJuA
 pm9pjFe52HC1gbSD82+KPnPOCKUjG6GwOhxtoDTepQQZWSVpSd00gUdtsviADQcFXnt1
 Zk+Sg7/h4Wc492L2e9bo2pvnHTLhONYnV6ksKZvsWDcfUACb+QSQnSzkeTetM10yycLe
 UwUnauROTgzv4Ms2ikX2ffSf9gfQikkrF4xX/F6uLL+L4k4Y00PX6/P2J54324criz2f
 8Kyw==
X-Gm-Message-State: AOJu0Yy34/3nd7JebLm5v/Hi5PAZS74EHjoj+TivJe73xvVJzY0+LadM
 w0ocMHtOjgpebANZu1/NScEJPDHHu33Cemce1HRJZg==
X-Google-Smtp-Source: AGHT+IE+1DAlbdjgflivd5fkk+/3wJskToGijZmSy29sUmZV1fAvwe3DkvlA94kRod0S5ezEV6sq0A==
X-Received: by 2002:a05:6808:2dc3:b0:3ba:940:bc32 with SMTP id
 gn3-20020a0568082dc300b003ba0940bc32mr4775192oib.39.1702613969291; 
 Thu, 14 Dec 2023 20:19:29 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 be15-20020a056808218f00b003b898ffd8fcsm3601492oib.50.2023.12.14.20.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 20:19:29 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng.cn@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH v2 03/16] bootm: Make OS booting dependent on BOOTM
Date: Thu, 14 Dec 2023 21:19:01 -0700
Message-ID: <20231215041919.2197788-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231215041919.2197788-1-sjg@chromium.org>
References: <20231215041919.2197788-1-sjg@chromium.org>
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

Booting an OS does not require the 'bootm' command, so change the
condition for these options.

Move them into boot/ so they don't depend on CMDLINE

Note that CMD_BOOTM_PRE_LOAD has been put directly into the bootm code
so will need some additional refactoring (and a test!) to allow it to
change over.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 boot/Kconfig | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 cmd/Kconfig  | 49 -------------------------------------------------
 2 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 8b32a51f7e7c..9fa8789bc2b1 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -689,6 +689,55 @@ config BOOTM
 	  This option should normally be enabled. It is used to implement the
 	  'bootm' command.
 
+config BOOTM_LINUX
+	bool "Support booting Linux OS images"
+	depends on BOOTM || CMD_BOOTZ || CMD_BOOTI
+	default y
+	help
+	  Support booting the Linux kernel directly via a command such as bootm
+	  or booti or bootz.
+
+config BOOTM_NETBSD
+	bool "Support booting NetBSD (non-EFI) loader images"
+	depends on BOOTM
+	default y
+	help
+	  Support booting NetBSD via the bootm command.
+
+config BOOTM_OPENRTOS
+	bool "Support booting OPENRTOS / FreeRTOS images"
+	depends on BOOTM
+	help
+	  Support booting OPENRTOS / FreeRTOS via the bootm command.
+
+config BOOTM_OSE
+	bool "Support booting Enea OSE images"
+	depends on (ARM && (ARM64 || CPU_V7A || CPU_V7R) || SANDBOX || PPC || X86)
+	depends on BOOTM
+	help
+	  Support booting Enea OSE images via the bootm command.
+
+config BOOTM_PLAN9
+	bool "Support booting Plan9 OS images"
+	depends on BOOTM
+	default y
+	help
+	  Support booting Plan9 images via the bootm command.
+
+config BOOTM_RTEMS
+	bool "Support booting RTEMS OS images"
+	depends on BOOTM
+	default y
+	help
+	  Support booting RTEMS images via the bootm command.
+
+config BOOTM_VXWORKS
+	bool "Support booting VxWorks OS images"
+	depends on BOOTM
+	default y
+	help
+	  Support booting VxWorks images via the bootm command.
+
 config ANDROID_BOOT_IMAGE
 	bool "Android Boot Images"
 	default y if FASTBOOT
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 2af66a66c1e1..116e53f972d0 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -291,48 +291,6 @@ config CMD_BOOTI
 	help
 	  Boot an AArch64 Linux Kernel image from memory.
 
-config BOOTM_LINUX
-	bool "Support booting Linux OS images"
-	depends on CMD_BOOTM || CMD_BOOTZ || CMD_BOOTI
-	default y
-	help
-	  Support booting the Linux kernel directly via a command such as bootm
-	  or booti or bootz.
-
-config BOOTM_NETBSD
-	bool "Support booting NetBSD (non-EFI) loader images"
-	depends on CMD_BOOTM
-	default y
-	help
-	  Support booting NetBSD via the bootm command.
-
-config BOOTM_OPENRTOS
-	bool "Support booting OPENRTOS / FreeRTOS images"
-	depends on CMD_BOOTM
-	help
-	  Support booting OPENRTOS / FreeRTOS via the bootm command.
-
-config BOOTM_OSE
-	bool "Support booting Enea OSE images"
-	depends on (ARM && (ARM64 || CPU_V7A || CPU_V7R) || SANDBOX || PPC || X86)
-	depends on CMD_BOOTM
-	help
-	  Support booting Enea OSE images via the bootm command.
-
-config BOOTM_PLAN9
-	bool "Support booting Plan9 OS images"
-	depends on CMD_BOOTM
-	default y
-	help
-	  Support booting Plan9 images via the bootm command.
-
-config BOOTM_RTEMS
-	bool "Support booting RTEMS OS images"
-	depends on CMD_BOOTM
-	default y
-	help
-	  Support booting RTEMS images via the bootm command.
-
 config CMD_SEAMA
 	bool "Support read SEAMA NAND images"
 	depends on MTD_RAW_NAND
@@ -349,13 +307,6 @@ config CMD_VBE
 	  is used to boot. Updating the parameters is not currently
 	  supported.
 
-config BOOTM_VXWORKS
-	bool "Support booting VxWorks OS images"
-	depends on CMD_BOOTM
-	default y
-	help
-	  Support booting VxWorks images via the bootm command.
-
 config CMD_BOOTEFI
 	bool "bootefi"
 	depends on EFI_LOADER
-- 
2.43.0.472.g3155946c3a-goog

