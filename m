Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69EAC48BC4
	for <u-boot@archiver.kernel.org>; Sun, 18 Feb 2024 21:21:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA5888573F;
	Sun, 18 Feb 2024 22:20:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CcGb/LM+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7311C87EBA; Sun, 18 Feb 2024 22:20:25 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4BFB87ED5
 for <u-boot@lists.denx.de>; Sun, 18 Feb 2024 22:20:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mr.bossman075@gmail.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7838af983c1so284952685a.3
 for <u-boot@lists.denx.de>; Sun, 18 Feb 2024 13:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708291202; x=1708896002; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0rHDbDnJDi8lKyXYdUQ/riYq+T7/HidOroC5aqiO0GA=;
 b=CcGb/LM+zrG8KPkp9QIzLqPacg5zwvhz6vkerzqzY5Ixo5wBPzP4WIzU01zXeXkHNZ
 5PhB6F+kkvQUe3SlXiOXh6acDMewrUcRfdaW0u0gx5MRcPg4cN0q2Mcc8b3kIpRvCEdF
 ByXQFVZjrdLDcoo6TfyjfsQlnQDIzUJ5ZsIJvzQxDQwP0VYQff9wp5gOWD3obhzg/4P4
 29fienOwv8Ot+uDLMera+N9kGkIb4IS4LR/Y8nTUV8YZv5oYCIU10N3fQ6RsMgmQFe5p
 LoeYnX533r5f0QVHCiRB9mbmPeyjEBrfSTJ1yoNgq3YZOq0SRbmZY6U90GJdfV6SQ+5n
 GGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708291202; x=1708896002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0rHDbDnJDi8lKyXYdUQ/riYq+T7/HidOroC5aqiO0GA=;
 b=iXpUOK1w1e5JOSlQrACs7H1T9Lv0oFT+F7lYFKzc6r6NfdjQM6TvlKZ4fj1RUbLWzF
 2Tw6qNR4L/K/4ODLvBdDFqDW3CVSeLDOQ+ryCnnqcYYn429LSVhfjnxtwK0flgG6/6KX
 rOkrVhgOJIpvRNquzVomBW/lINwCJtqJTOud+vc9eIqZbR896XvlzTIx5znm1AJKwgdH
 Jm7/S+oM8cjvxLYsBpOfkqHdSNIlLdw4OS+Wtvkh52e+RlhdgAv2NUC6LirnY6RteFOv
 aPbzpJ1GJkj+U8G7993rG04EuxcNQCnKfwgDOW1KS9GZ9Y5gW3/Wc2OJEsOYU550g2M9
 +85Q==
X-Gm-Message-State: AOJu0YzoxmnMd8E7F2Umj65PaVy+9PU315QCvuSOgw6hwGxAfDXMGu3+
 xV6YKIx8zUV3kfl1GHdzLTIXWzPD4nB8a1b/8uki6v2vJJMv57H2KCYGE68qMI8=
X-Google-Smtp-Source: AGHT+IEhADFbOjwJnuLIA5NXsvCIjHZ/XrLxeeHN3QTGHbU/ul/hdHHhY0EnM0TxOuZUVK94bO9UTA==
X-Received: by 2002:a37:e319:0:b0:787:3fa9:8d5f with SMTP id
 y25-20020a37e319000000b007873fa98d5fmr9444019qki.35.1708291202046; 
 Sun, 18 Feb 2024 13:20:02 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab
 (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
 by smtp.gmail.com with ESMTPSA id
 o15-20020a05620a110f00b00785b02c5784sm1863219qkk.86.2024.02.18.13.20.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Feb 2024 13:20:01 -0800 (PST)
From: Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To: u-boot@lists.denx.de
Cc: Jesse Taube <Mr.Bossman075@gmail.com>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 3/3] imx: imxrt1050-evk: Add documentation for SPI boot
Date: Sun, 18 Feb 2024 16:19:58 -0500
Message-ID: <20240218211958.2849847-3-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240218211958.2849847-1-Mr.Bossman075@gmail.com>
References: <20240218211958.2849847-1-Mr.Bossman075@gmail.com>
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

