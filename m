Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06500C54E67
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 14:39:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F69C87D5E;
	Fri, 15 Mar 2024 15:39:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EOvQvgyD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B87787F73; Fri, 15 Mar 2024 15:39:56 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2CE387D12
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 15:39:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hiagofranco@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1ddc7e45c47so14776545ad.1
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 07:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710513591; x=1711118391; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wAq6s8ZlFzCeUN/Hkb2jSC+pauvxgpccd8WT9cdbNvg=;
 b=EOvQvgyDQchEICnwI8xNW8C9dUd+ueOf5FF4utduxdfn6yjHg5jUD3P2BOTe7mTqaj
 X1RrOty1lyFajOL6ikGu+UzNkszS2e2UkeS+4GNxGWkl2x88k4KjBSkXP2DUKtvuWlRk
 Ey87cnCLf6NCzafm3515D4+WdfXo8Uv7K7+55ZG76jD5I0idrlt6Gji8GdyofH2R8nuY
 0xjbJDSFkwWKwJn0/W6+2hD0RgZjskRo8/W7N+tH52GWan1wAUkVeYrI1Ci1OICKn8OA
 CGKB1WzI/Y+GrLFZK+HavSbAcnEksIZg0I8Qva7o01OLTH1NFFMykqi+CJ2h+0/FhSGh
 fZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710513591; x=1711118391;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wAq6s8ZlFzCeUN/Hkb2jSC+pauvxgpccd8WT9cdbNvg=;
 b=WdsEzBgnPt/3se6g60AKN2jgMBx73Iy2/VKFot+5BF5OfNhsBh4GZonJh9GA3AvIMw
 YSGsugOeNrQExw+Rg0nt9/PsYN65riNmfOYH2hUc1aDlkViDhsU2yZrdpTky4lsNNwNS
 ox0+uSBKy8hy92jBUSYqekpwWPPC2k2OBTGW68N4Z8zN1hwVhW2tZepwuvyuojfT2bI3
 KKl/RVKVvVLTRR5IBmbXh6XrMk/SxpOqRV/OGtEIeUwcVX/SYIXFchFFfzN5sB0HFbHU
 6JTwxjuDi1WwcBrz50l5IdNsLfAXgGEIKViclkOqhw45E8egioxss4AMceVR24GczBav
 Nhmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo/4czVz/zg0zT0LXC/T33+oQd+mesNc/1ehDiforJ7c/L+Hgj9Nk5aPDHhUdUAKE7W1bE4mz14rva+evmAt3ZBVYhQQ==
X-Gm-Message-State: AOJu0YzlQGAGlt/+Y9Y+8mA84n7WVomwRwOgUxVCIRLkvei4G2vvNnmJ
 bG6RBrJZE28nBS8p9AIlOYwaepHkOVcTd+mLPYE6ulzi3IofnQ12
X-Google-Smtp-Source: AGHT+IFctLUP46yTXP+pv551Nvyih9mQH03xlDQ0+l4gpFqFzPjbJexiT8f3HQglptEfUHr5F87+mg==
X-Received: by 2002:a17:903:2449:b0:1dc:d773:ac with SMTP id
 l9-20020a170903244900b001dcd77300acmr6422622pls.7.1710513590955; 
 Fri, 15 Mar 2024 07:39:50 -0700 (PDT)
Received: from frhdebian.. ([2804:1b3:6602:ff36:b599:add9:ba93:f462])
 by smtp.gmail.com with ESMTPSA id
 s14-20020a170902ea0e00b001dbac604e4dsm3894234plg.146.2024.03.15.07.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 07:39:50 -0700 (PDT)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de, Hiago De Franco <hiago.franco@toradex.com>
Subject: [PATCH v1] doc: board: colibri-imx8x: Update and improve documentation
Date: Fri, 15 Mar 2024 11:39:30 -0300
Message-Id: <20240315143930.29155-1-hiagofranco@gmail.com>
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

From: Hiago De Franco <hiago.franco@toradex.com>

Update and improve the building documentation of Colibri iMX8X.
The following changes were made:
- imx-atf repository changed to nxp-imx GitHub.
- imx-atf branch updated to 'lf_v2.6'.
- imx-seco updated to version 5.8.7.
- nxp-imx mfgtools link updated to GitHub releases.
- General writing improvements.

Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
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

