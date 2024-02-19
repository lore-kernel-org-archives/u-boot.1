Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F21AC48BC3
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 23:01:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D82F87F68;
	Tue, 20 Feb 2024 00:01:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FPjJNyjZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2056C87F63; Tue, 20 Feb 2024 00:01:15 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C07A87F67
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 00:01:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mr.bossman075@gmail.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7875adf71b1so144724685a.0
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 15:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708383664; x=1708988464; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FTQLcHAemI5fhAhxzh+j1XrzRYCE077BQt4bEVJLMOk=;
 b=FPjJNyjZN+aOIYF0hhuHHXspgdeOjhNCR87/hf1SEklwVnIQxsq5C7vQnwo23lskhk
 2Cnl6X+285UBALIjPNbxu/Q5AXeMKPnUGiE8+ijs3qvANX5xuDVjBJnEqS9nbfl4L1yv
 9VPopUL7lUYFIS+rp9o7perSqvXCEZN9YZa9eDZzBvlwrEKODWfK/3afoo1/trzskc/u
 vnyGEw0G11mmUC7xmuIyAeHEYxPVFjxyGM+ma01+hBG0iqbxJMo+jw+yXR3ybT05y+6k
 oDXBENFnKOb2OHWdKDWQJTZ6FLOYuaB4b64SlcIEG1gVGDAs67rzkzNfepai4JQpuyks
 ticw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708383664; x=1708988464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FTQLcHAemI5fhAhxzh+j1XrzRYCE077BQt4bEVJLMOk=;
 b=kQA4quhF2isV9ZaFq5dkdstVDjjisj5JXTdLNTmCO7z/Fdd5b52dELJQcV3FkdmcOO
 O8ZajmHZJkrV5ESurhVblm2xj05JQDMobSXP2+JxRXzxIZkoWHCdmagheu0WHAytBCU/
 Rwq6FCzJ5jdgJz4PJuQBaQnlY200ogjmubCK6aWlUD9OKtHVy9nDIt2UktnRvy2BbDeV
 ZpcexqkIyfKjucn5BtGx3pvQ4KywPYZZI8RJUIAm4rQal97X2yidO/t39GRo+mp/7kjj
 /S1gFEGeajUeKuSbftNzNsoQb9BEyWB9xPCzEQVKI/fZpqOAO/ZiOnYhggz0u8PetPhh
 BBCg==
X-Gm-Message-State: AOJu0YxdGMRNni72lhFX1egqLvva1dSFZ0W75RKQvfg3MukoxhmfO3bp
 3jqHWgQG4L+co7sChM9L7oom4FCeYGp406lo2lrCZ1G1sU8jhwtU6wMp92qzwHk=
X-Google-Smtp-Source: AGHT+IGrMkKNVTa7XtIYshVMLFCYAg4S+EfRI0OTrSAbkjpb/RpOhXkKKS2aY5SoMrYTforyxlDQoA==
X-Received: by 2002:a37:c206:0:b0:787:30b1:a385 with SMTP id
 i6-20020a37c206000000b0078730b1a385mr22925925qkm.38.1708383663805; 
 Mon, 19 Feb 2024 15:01:03 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab
 (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
 by smtp.gmail.com with ESMTPSA id
 bl40-20020a05620a1aa800b007874e7d907dsm2613044qkb.50.2024.02.19.15.01.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 15:01:03 -0800 (PST)
From: Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To: u-boot@lists.denx.de
Cc: Jesse Taube <Mr.Bossman075@gmail.com>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 2/2] imx: imxrt1050-evk: Add documentation for SPI boot
Date: Mon, 19 Feb 2024 18:01:00 -0500
Message-ID: <20240219230100.2980309-2-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240219230100.2980309-1-Mr.Bossman075@gmail.com>
References: <20240219230100.2980309-1-Mr.Bossman075@gmail.com>
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

Add documentation for SPI boot.

Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
V1 -> V2:
 - Change s/Adds/Add
 - Change imxrt1050-evk_spi to fspi
 - Fix spelling and grammar
 - Mention the SPI NOR flash part number
V2 -> V3:
 - No changes
V3 -> V4:
 - No changes
---
 doc/board/nxp/imxrt1050-evk.rst | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/doc/board/nxp/imxrt1050-evk.rst b/doc/board/nxp/imxrt1050-evk.rst
index c1fb48f0cd..e0cafe1035 100644
--- a/doc/board/nxp/imxrt1050-evk.rst
+++ b/doc/board/nxp/imxrt1050-evk.rst
@@ -39,3 +39,33 @@ switch label numbers reference).
   The USB console connector is the one close the ethernet connector
 
 - Insert the micro SD card in the board, power it up and U-Boot messages should come up.
+
+
+How to use U-Boot with SPI flash on NXP i.MXRT1050 EVK
+------------------------------------------------------
+
+- Build U-Boot for i.MXRT1050 EVK:
+
+.. code-block:: bash
+
+   $ make mrproper
+   $ make imxrt1050-evk_fspi_defconfig
+   $ make
+
+This will generate SPL, uboot.img, fspi_header.bin, and the final image (flash.bin).
+
+To boot from SPI flash on other boards, you may need to change the flash header config,
+which is specific to your flash chip, in Kconfig.
+The flash config is 4K in size and is documented on page 217 of the imxrt1050 RM.
+The default flash chip on the i.MXRT1050 EVK is the S26KS512SDPBHI02 HYPERFLASH.
+
+- Jumper settings::
+
+   SW7: 0 1 1 0
+
+where 0 means bottom position and 1 means top position (from the
+switch label numbers reference).
+
+- Connect the USB cable between the EVK and the PC for the console.
+
+- Use either JTAG or SWD to write `flash.bin` to the NOR. I used Mcuexpresso IDE's GUI flash tool.
-- 
2.43.0

