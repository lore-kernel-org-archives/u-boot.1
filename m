Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE66C54E67
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 21:58:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A293088075;
	Fri, 15 Mar 2024 22:57:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Av5fokU4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5197F88001; Fri, 15 Mar 2024 22:57:47 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9D9D87F6F
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 22:57:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hiagofranco@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1dd9568fc51so23365855ad.2
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 14:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710539861; x=1711144661; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oGMZvFybD4a6xG8aIa76yDFwmXwF5WWY8LaO/YpuN9Y=;
 b=Av5fokU4jjH92qYxD/5Nn847Y3R0v0HAGjav/DSbOE/Os3NvHwmmkn+doPbVIuI3ug
 E9/KALplCTZp3iOe2I3rxFBMD+bgGiWPn0pZkv5NiP/BwOAeqlAR6O3o6zU+Qv1WyOd3
 0z3eGnOOgj8AKHV9aXXLsJFPlfR330+CO/+O4MEVUHmg/43CvZh32+fZDIXORsuhTne6
 z5t5x1zhM8Hn5hpnwBz7iHhicvOcC5+CRFR46z/p/b1omfOzBASU4FwbjB9UcZHiwZdF
 6jeKGrFHZxwSp79CkByWF2re2WUUy2Fv+b7LylW2eWLEQVam4DhFsdzahosG3G3BsFPP
 ktDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710539861; x=1711144661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oGMZvFybD4a6xG8aIa76yDFwmXwF5WWY8LaO/YpuN9Y=;
 b=Rf8pySCPLm+wo2RlaiKZPooetE/NaGgJRzDCUdtdbMf/MLgCIhR6e9/kFZbSAZWWye
 QK8TVCCeXpL4ICp0/puU/imkuomNPOq1FsOWcv/X696dwCl3FFusNgvE2nRFB9uh2IHC
 lJHhC+IQVjRSMrUTc8Jzwql0Q8n+LHOS/29w7BDzEnmzXURG0HtlMQk9eXHTmjQE1H7E
 Rnm6g0JQzDBvU6MnpLOp96gZRfD/1Snga1zW3d1FxXUtn+vmxUINzFDm61MT4WUI4RmK
 +rNdHg+T998wWRqBnaB9bh4IviF9Vl/KZy1DLYesUG67Q2fQHhtr1SPuWU/uwomvFPNe
 lC0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlRMRejhO1/OP9L+Eq1H0YfEoazuOiijNbDYpSy83fvoNZLHZM5LauB0Yp30mJ2VwYpxB4X01XQ5MjmBe5QhXQjA93iw==
X-Gm-Message-State: AOJu0YwMqbxFoqgekwMgvRY3tTqCP6spflqHJ4rd5rI82HKsExXIfPxP
 DLvXF9lgWgDCD+3yvRi9gVZdc+QZEq5ouh+ZFMnJLn0igkKorKaU
X-Google-Smtp-Source: AGHT+IEzYsbzBXASqPLXVzon+O3sQOSEsB6ZwG//37p32sfHbIUrP8zacdN/a36IC4xHNCphCbF5iQ==
X-Received: by 2002:a17:903:192:b0:1de:f765:cc6e with SMTP id
 z18-20020a170903019200b001def765cc6emr2319178plg.47.1710539861331; 
 Fri, 15 Mar 2024 14:57:41 -0700 (PDT)
Received: from frhdebian.. ([2804:1b3:6602:ff36:f144:8c19:ce75:7f2f])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a170902dacd00b001dcfc68e7desm4353315plx.75.2024.03.15.14.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 14:57:41 -0700 (PDT)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de, Francesco Dolcini <francesco@dolcini.it>,
 Hiago De Franco <hiago.franco@toradex.com>
Subject: [PATCH v2 2/2] doc: board: apalis-imx8: Update and improve
 documentation
Date: Fri, 15 Mar 2024 18:56:57 -0300
Message-Id: <20240315215657.160967-3-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240315215657.160967-1-hiagofranco@gmail.com>
References: <20240315215657.160967-1-hiagofranco@gmail.com>
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

From: Hiago De Franco <hiago.franco@toradex.com>

Update and improve the building documentation of Apalis iMX8.
The following changes were made:
- imx-atf repository changed to nxp-imx GitHub.
- imx-atf branch updated to 'lf_v2.6'.
- imx-seco updated to version 5.8.7.
- nxp-imx mfgtools link updated to GitHub releases.
- General writing improvements.

Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
v2:
  - Add this patch for apalis-imx8.rst, updating its instructions as it
    was done with colibri-imx8x.rst.
---
 doc/board/toradex/apalis-imx8.rst | 32 +++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/doc/board/toradex/apalis-imx8.rst b/doc/board/toradex/apalis-imx8.rst
index ffc4c7d222a8..069d86ccd8ca 100644
--- a/doc/board/toradex/apalis-imx8.rst
+++ b/doc/board/toradex/apalis-imx8.rst
@@ -20,36 +20,36 @@ Quick Start
 Get and Build the ARM Trusted Firmware
 --------------------------------------
 
+Download the imx-atf repository:
+
+.. code-block:: bash
+
+    $ git clone -b lf_v2.6 https://github.com/nxp-imx/imx-atf.git
+
+Compile it with an aarch64 toolchain:
+
 .. code-block:: bash
 
-    $ git clone -b imx_4.14.78_1.0.0_ga https://github.com/nxp-imx/imx-atf
     $ cd imx-atf/
     $ make PLAT=imx8qm bl31
 
 Get scfw_tcm.bin and ahab-container.img
 ---------------------------------------
 
-.. code-block:: bash
-
-    $ wget https://github.com/toradex/meta-fsl-bsp-release/blob/toradex-sumo-4.14.78-1.0.0_ga-bringup/imx/meta-bsp/recipes-
-      bsp/imx-sc-firmware/files/mx8qm-apalis-scfw-tcm.bin?raw=true
-    $ mv mx8qm-apalis-scfw-tcm.bin\?raw\=true mx8qm-apalis-scfw-tcm.bin
-    $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.0.bin
-    $ chmod +x firmware-imx-8.0.bin
-    $ ./firmware-imx-8.0.bin
-
-Copy the following binaries to the U-Boot folder:
+Download imx-seco firmware and extract it:
 
 .. code-block:: bash
 
-    $ cp imx-atf/build/imx8qm/release/bl31.bin .
-    $ cp u-boot/u-boot.bin .
+    $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/imx-seco-5.8.7.bin
+    $ sh imx-seco-5.8.7.bin --auto-accept
 
-Copy the following firmware to the U-Boot folder:
+Copy the following binaries to the U-Boot folder:
 
 .. code-block:: bash
 
-    $ cp firmware-imx-8.0/firmware/seco/ahab-container.img .
+    $ wget https://github.com/toradex/i.MX-System-Controller-Firmware/raw/master/src/scfw_export_mx8qm_b0/build_mx8qm_b0/mx8qm-apalis-scfw-tcm.bin
+    $ cp ../imx-atf/build/imx8qm/release/bl31.bin .
+    $ cp ../imx-seco-5.8.7/firmware/seco/mx8qmb0-ahab-container.img mx8qm-ahab-container.img
 
 Build U-Boot
 ------------
@@ -64,7 +64,7 @@ Load the U-Boot Binary Using UUU
 
 Get the latest version of the universal update utility (uuu) aka ``mfgtools 3.0``:
 
-https://community.nxp.com/external-link.jspa?url=https%3A%2F%2Fgithub.com%2FNXPmicro%2Fmfgtools%2Freleases
+https://github.com/nxp-imx/mfgtools/releases
 
 Put the module into USB recovery aka serial downloader mode, connect the USB
 device to your host and execute ``uuu``:
-- 
2.39.2

