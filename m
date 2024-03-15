Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C5D9C54E58
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 21:57:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 452FA88065;
	Fri, 15 Mar 2024 22:57:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TwlVKEhA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44E1F88065; Fri, 15 Mar 2024 22:57:46 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B09DA88001
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 22:57:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hiagofranco@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1dc3b4b9b62so17875225ad.1
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 14:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710539859; x=1711144659; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HmdmAPazb1vPtKnEvNXoa5oEfOhKVrd3czLdFii9fSo=;
 b=TwlVKEhAmNJ1qJimC+xFk47jtc0pyjjMOXxhVS+4tlz0JKnGrfL+HQpFT7MAvnPW/K
 yqogohPC43fwpMicmX1DUEeIvXXDBQw0NkMqF4WBmVIVNiOR7s7dFeKUtk/9Azk+ttDX
 YOJYavn40NpftyiZrIEPOzbu0Q+JAGxK+xa0t22tAbbqz+I+Ha2VkSQohY+tRUtHR5Wq
 PlOTpsXaxR49LiGnxITdxTF7CkBSquuObbdBCgrcRiehF4oUEsXUjAbxJJFU2JBMfj4a
 M13hqtqC1e6pZophNxDZrDrynAaKJw78CIw5zxqTyE/9Rf6phMPSv3GKBtRNSsXrUUQc
 sv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710539859; x=1711144659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HmdmAPazb1vPtKnEvNXoa5oEfOhKVrd3czLdFii9fSo=;
 b=ZoLFoP3NCVAz8dH+RI4g6z7G6WoStoJSS+eCwNHNjlidAZS1YHYbk0az8tzdn9D59R
 22bb8a3LK6uciw+IazXsgK7omYLXcEYTDT/KPpAVTKBJ/TbifUnpq0+hsZobo3Nd6lVq
 bnIql/fCgDJSnfGwtWTuCvlx15IeDiPQAVGT7mI8O/zgHG+7GA4X9Xhnlfv38NYVHnJY
 tLtmIOEGIcUOzBZVZ9yLOb/lDdyMbtRQQQWKMOwu2rzcxWYJVA6YgCAPMC4JCrYxAdU+
 tGpA+CkTFPTJyMVAQQLmYFvyhU7dSGVInMEFUdIZXVM0ocTx3JsA0gkr5NZH60i6KetZ
 On+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoi+c91envHSotB4p8doCbvusaUsY6bPossK9je5MXR7ybcSsQy6cFvIqSpuAXFSjPpZKLNjxjfBXlGWYKM/Y8BXDaoQ==
X-Gm-Message-State: AOJu0YxBY0t1qJew1lmggxYuTpLK2I5cZFkP22gDwa8TvL8MnoLq2r4n
 GvSOiFcdBWe+t7RyBOz638Eur7wfOTAGQu868gMv9q7LAIRIMp5A
X-Google-Smtp-Source: AGHT+IGW8Nv59zBiMsUNdK/iRa1rdPTYs0wLANdviqLljcrXk7cdc/qr9waRs6JllA7hDq4OSeNHbQ==
X-Received: by 2002:a17:902:f68b:b0:1db:cf64:7331 with SMTP id
 l11-20020a170902f68b00b001dbcf647331mr14114565plg.13.1710539859212; 
 Fri, 15 Mar 2024 14:57:39 -0700 (PDT)
Received: from frhdebian.. ([2804:1b3:6602:ff36:f144:8c19:ce75:7f2f])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a170902dacd00b001dcfc68e7desm4353315plx.75.2024.03.15.14.57.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 14:57:38 -0700 (PDT)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de, Francesco Dolcini <francesco@dolcini.it>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v2 1/2] doc: board: colibri-imx8x: Update and improve
 documentation
Date: Fri, 15 Mar 2024 18:56:56 -0300
Message-Id: <20240315215657.160967-2-hiagofranco@gmail.com>
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

Update and improve the building documentation of Colibri iMX8X.
The following changes were made:
- imx-atf repository changed to nxp-imx GitHub.
- imx-atf branch updated to 'lf_v2.6'.
- imx-seco updated to version 5.8.7.
- nxp-imx mfgtools link updated to GitHub releases.
- General writing improvements.

Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2:
  - Add Reviewed-by: Francesco Dolcini 
---
 doc/board/toradex/colibri-imx8x.rst | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/doc/board/toradex/colibri-imx8x.rst b/doc/board/toradex/colibri-imx8x.rst
index 9e61d98c6b1f..378b259abd05 100644
--- a/doc/board/toradex/colibri-imx8x.rst
+++ b/doc/board/toradex/colibri-imx8x.rst
@@ -20,26 +20,35 @@ Quick Start
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
 
-    $ git clone -b toradex_imx_5.4.70_2.3.0 http://git.toradex.com/cgit/imx-atf.git/
     $ make PLAT=imx8qx bl31 -C imx-atf
 
 Get scfw_tcm.bin and ahab-container.img
 ---------------------------------------
 
+Download imx-seco firmware and extract it:
+
 .. code-block:: bash
 
-    $ wget https://github.com/toradex/i.MX-System-Controller-Firmware/raw/master/src/scfw_export_mx8qx_b0/build_mx8qx_b0/mx8qx-colibri-scfw-tcm.bin
-    $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/imx-seco-3.8.1.bin
-    $ sh imx-seco-3.8.1.bin --auto-accept
+    $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/imx-seco-5.8.7.bin
+    $ sh imx-seco-5.8.7.bin --auto-accept
 
 Copy the following firmware to the U-Boot folder:
 
 .. code-block:: bash
 
-    $ cp imx-atf/build/imx8qx/release/bl31.bin .
-    $ cp imx-seco-3.8.1/firmware/seco/mx8qxc0-ahab-container.img mx8qx-ahab-container.img
+    $ wget https://github.com/toradex/i.MX-System-Controller-Firmware/raw/master/src/scfw_export_mx8qx_b0/build_mx8qx_b0/mx8qx-colibri-scfw-tcm.bin
+    $ cp ../imx-atf/build/imx8qx/release/bl31.bin .
+    $ cp ../imx-seco-5.8.7/firmware/seco/mx8qxc0-ahab-container.img mx8qx-ahab-container.img
 
 Build U-Boot
 ------------
@@ -54,7 +63,7 @@ Load the U-Boot Binary Using UUU
 
 Get the latest version of the universal update utility (uuu) aka ``mfgtools 3.0``:
 
-https://community.nxp.com/external-link.jspa?url=https%3A%2F%2Fgithub.com%2FNXPmicro%2Fmfgtools%2Freleases
+https://github.com/nxp-imx/mfgtools/releases
 
 Put the module into USB recovery aka serial downloader mode, connect the USB
 device to your host and execute ``uuu``:
-- 
2.39.2

