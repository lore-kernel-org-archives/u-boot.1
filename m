Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4BEC47258
	for <u-boot@archiver.kernel.org>; Sun, 28 Jan 2024 21:43:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BC4687B4D;
	Sun, 28 Jan 2024 22:43:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jhDhXuia";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 016D687A0E; Sun, 28 Jan 2024 22:43:43 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B311087B4D
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 22:43:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mr.bossman075@gmail.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-68c420bf6e1so9827836d6.2
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 13:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706478218; x=1707083018; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QLKwNgaxKMRI/cadOo2mEnW0RzNIdW5wOiZqD9DcP44=;
 b=jhDhXuiabp7xHUPj5R/alnv3TFL0FIYakHEWFsWdOeV5+DVCpX6NOzfym5uQ7v9/Vw
 5CvXtNgcl1Ru/hJqxcSfvPVjb9bQwINL1d8ShyI6xOEFepomxRbd5DuMtb0gMNEajPti
 +EAtAr5s2OfMKW8DkgAD5UOAjK24t/OLBJp0JUk5ZUddPzUDPwnvdu4ZGEJOAHzYqYjO
 4QzlUNRg9wcsIRUQb1Z/Evkr6bYpOmeKlfFc4UvVzOAhDei5Fcc8Bnq3QfKDNZDw0/M6
 ImRyzIygdHl+ELrniAQnqq8sRBzpClEpYcvoIYygzVV8OIeCOMM+FZxeRVx3gDskXo++
 qPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706478218; x=1707083018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QLKwNgaxKMRI/cadOo2mEnW0RzNIdW5wOiZqD9DcP44=;
 b=Yt9IR61ds2m89SoLibfO5fcD09FMKzsQd+WD1/+nr7NVVlXr0l13bkdZrLR0XYv/s7
 SporNn6xmEzHBApRQWfRwhCrb0LAm9Ao15LnQ3aRI8h6zxQuQvSRykoOmokdenNAqz8H
 mck0UVM00yWlOW90hM8dSOepzTsDzb6eiwQgg9PFV2kKD2Asbv5U41D5Gc2xdXnRfl0f
 /ukqwXo63P7Bzr7mtmDcWm6/LlkALQZgt1dKPzU9AuvgkbTYtmhjWDjZbc/gupJmVsHr
 mQwRPqzILJUM3gRgZ1b/z+ABFMwrAmI64yAL4CyIdhvFPnzuom9L76TbAs5UtDplts79
 RDMg==
X-Gm-Message-State: AOJu0YzGcSlaxB7NQikYN8r/NMKXjqK/ts+KgtR6iZthefJQ/SEuT8pp
 Y4ZzjjPdMdsQAaurldjdgQ6tciQIzvWhvjrZgUCRAnYmD3RTlfYjWHO8hPaBGWo=
X-Google-Smtp-Source: AGHT+IFPtettCa6Gayio7ex7/tm8lWD3mT9IOhwQzROZcnkGO4VXTEZK4KUmQPLQB601BX5U9zguTQ==
X-Received: by 2002:ad4:5dc2:0:b0:685:bd10:75dc with SMTP id
 m2-20020ad45dc2000000b00685bd1075dcmr7599059qvh.0.1706478218071; 
 Sun, 28 Jan 2024 13:43:38 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab
 (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
 by smtp.gmail.com with ESMTPSA id
 kf4-20020a056214524400b006837a012417sm2768347qvb.51.2024.01.28.13.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jan 2024 13:43:37 -0800 (PST)
From: Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To: u-boot@lists.denx.de
Cc: Jesse Taube <Mr.Bossman075@gmail.com>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v1 2/2] imx: imxrt1050-evk: Add documentation for SPI boot
Date: Sun, 28 Jan 2024 16:43:35 -0500
Message-ID: <20240128214335.120280-2-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128214335.120280-1-Mr.Bossman075@gmail.com>
References: <20240128214335.120280-1-Mr.Bossman075@gmail.com>
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

Adds documentation for SPI boot.

Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
 doc/board/nxp/imxrt1050-evk.rst | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/doc/board/nxp/imxrt1050-evk.rst b/doc/board/nxp/imxrt1050-evk.rst
index c1fb48f0cd..aca5071181 100644
--- a/doc/board/nxp/imxrt1050-evk.rst
+++ b/doc/board/nxp/imxrt1050-evk.rst
@@ -39,3 +39,32 @@ switch label numbers reference).
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
+   $ make imxrt1050-evk_spi_defconfig
+   $ make
+
+This will generate SPL, uboot.img, fspi_header.bin, and the final image (flash.bin).
+
+To boot from SPI flash on other boards you may need to change the flash header config,
+that is specific to your flash chip, in Kconfig.
+The flash config is 4K in size and is documented on page 217 of the imxrt1050RM.
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

