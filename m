Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C893FC4828D
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 16:40:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2177187BAE;
	Tue,  6 Feb 2024 17:40:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XctHPARa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFA878646E; Tue,  6 Feb 2024 17:40:15 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3215587CB7
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 17:40:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mr.bossman075@gmail.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-783f0995029so342803085a.1
 for <u-boot@lists.denx.de>; Tue, 06 Feb 2024 08:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707237610; x=1707842410; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0LNI6YSCwLe69Wc69kXBxkhAaKl2IJjiD9x/WvVmCUY=;
 b=XctHPARaNoU7/UKCbS/Upvkn+VF8SIVubmjwlUKxEefEEqOiX5a4mE3nwbfG1M/+uE
 odxfNFS01eIk51LihguZeKOYtiFyovEYClWvwAkf14PXLBJOIIbdBYsDmHx9qfQEz40j
 Wi10elSPiNnKQXdaDDYqm4toiYU3MoVCPrGHxYfmLby4YioCHaPAYhrU5R2nsCEq+0Gp
 I2vXdla5t5syonqrYoLsOvM8cbBePCpnwCN5weg0h27GajusuuxXZ/Ldx7YnnDpleP7B
 stAkqtCdwsdHeqEndFw56N/7KLaXW1O1lOmSz6EbqvBLtjVc75KlZUbP8esL68uCfa6b
 BcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707237610; x=1707842410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0LNI6YSCwLe69Wc69kXBxkhAaKl2IJjiD9x/WvVmCUY=;
 b=UUQjdeX8NAUXlLNUv98YgPcfiKJHOMwgzGSthNHz4oD9VMufwuVQU7N8RT/trgAGkh
 4abh6Yj2iW2mzwoZp8PTs6b/gGXsr32VkyZlS+COBn6X0vfUootz1S58RS33XONMKjPU
 tL+caJXG29QQg5cjkRfBQbZeaqMrdzU9ddvzUkHhnRrHoohk443UaxBvevLhY4qmD+ch
 mN2fxgdBW2U72rQtx8pNalZuZBp5I0iuQEZ1XKj6CwZ/xusqSGlj9Xd0aJjPLs5trr9W
 4F4f1AyOy+3K9TGmQb4ru7Ju2uiXKF/ZMBHKmSVAdk7hiqP+g4454NPdl855z0nTm0wo
 O5TA==
X-Gm-Message-State: AOJu0YxKpCfzTAOxz97wgEM/JvDJvYFhe5/SIxGf0K7R519+A55nZDX/
 wAvA3HHZB3mt90kU8Xz58Ce36jdAkAxQzOIlsBYCRNIzk4cNj7a9130e5On6yYI=
X-Google-Smtp-Source: AGHT+IE5sej+cz5uHmCet2mt1g/k2HZgD6ngXuwpbNyPjiPI2d2hBEZ8CR4t3SvgmQaEnaVqsZveNg==
X-Received: by 2002:a05:6214:519b:b0:68c:74cb:9932 with SMTP id
 kl27-20020a056214519b00b0068c74cb9932mr3423873qvb.11.1707237610679; 
 Tue, 06 Feb 2024 08:40:10 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCW2mvH6ni1swab43aXcgC8zopKSV6mk1G9vox6gVhR2UtczNYLap9sBgYAVhUWIC9Uj62wOeSiD6MCv0YHGyBFeNNOewWZJvCKeUiuPS8kRH68iWbx+JkhshV4vu2HAzhqB5rh1M2tzlr3I7sA9AGxhsn4IduRRG0oHVRSqBiI1YJBkJRFffdMc8WhxDD51BklKYYsp9yuRwjF/3S+7SdNI9VmNO+LDwZkyuhVaqutxOmR0
Received: from jesse-desktop.jtp-bos.lab
 (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
 by smtp.gmail.com with ESMTPSA id
 mv7-20020a056214338700b0068cb07d2a80sm918147qvb.37.2024.02.06.08.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 08:40:10 -0800 (PST)
From: Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To: u-boot@lists.denx.de
Cc: Jesse Taube <Mr.Bossman075@gmail.com>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 2/2] imx: imxrt1050-evk: Add documentation for SPI boot
Date: Tue,  6 Feb 2024 11:40:08 -0500
Message-ID: <20240206164008.1620933-2-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206164008.1620933-1-Mr.Bossman075@gmail.com>
References: <20240206164008.1620933-1-Mr.Bossman075@gmail.com>
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

