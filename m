Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBB6C36008
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 02:55:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAF5F80EEF;
	Tue, 25 Mar 2025 03:55:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FB8V7ear";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6F5A81951; Tue, 25 Mar 2025 03:55:08 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B39C80107
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 03:55:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4767e969b94so33896161cf.2
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 19:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742871304; x=1743476104; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AU+RpuCRCjTREnGjsCXqZe0mXmGYn0RZAEImMWRbpbg=;
 b=FB8V7ear/sJHxRZLe9GiCJ4WMIDPfkz46k+CmKP4sqo3iQbc/47+XX3WLdlvlwwAUC
 mo3cNOmJYZuM/tt72D+wccdDHzGoQR0YMO6MnIFwTRbSVEsYjFe9AV/rkM2R6Nx/q5c3
 cZj8lL4xP7g6bkDLHNb9/3tddz4qUONdODYqTUDkt2iaa0aHv4nrDUzkQ6mmx5kIkWm0
 Kpoxx3qtGz1bmjoMCxYY+7uOMsJ0FgiORQ1sfUMvbsYhV05Scjc+w/QaWshPdAxW7heB
 3dolfTqZGN/zckyKRqYAAqPz5NHtsIfSUeuNzUjiNZQieWdZZQiuZ2Rg4kAlphSgy9/C
 eWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742871304; x=1743476104;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AU+RpuCRCjTREnGjsCXqZe0mXmGYn0RZAEImMWRbpbg=;
 b=Sk5II0atE0wrQEFcjO5hl8TZs+oYls1m1ElgqOWQKdk2LB7Iwrd9jEtqSyXVpuRPvw
 oMJSm3f7QOfEPOvsD/hivXnOVbIegf2zhpD2U+De3JnxWwrHLVX5+TJB+pVIz+KlJS39
 NFVWcAEf9xytzgUerKKHb01N3JJHP11DMaWuXhrRnrGmosyWsw/KNKL+WRYDCYaeJj3Y
 mw4sBCXn7N1TovMxKVDN900im9Uk+vYRW72wtt46Byh52pmb+sQBOUv78XFfwQqGjch2
 Z7Fm9wQRS1dcNIynvHlaNgWtl9Z0qEnBzNW8B5EH1TXJ48y3Wv6Yp6q0y+CXM0TWm05S
 h9kQ==
X-Gm-Message-State: AOJu0Yzu4FcgjzFTRx4Qp0Xlry17IMgwtpECQE3PWpAathAoA9PJa8ez
 IeH4MfdUXcUrbqgMKrkxtgUhx8mQ1b0d4bvqMC7dDH/wask/3t9fHE2CBQ==
X-Gm-Gg: ASbGncvhCvkPYBnQ32J32V/m2TvmXJ02cDjnR/82CJ0DJPmShoUhq8NlbT3uIDgw8rI
 IaSxXVm6HoHTVMn754KpQb1SrMt2RV3r/mAQ00geXbj8pCYWl7TWZga6D2cmg+YfSFGwBRKzH0W
 f03XJvxMYxXIK/QeCRZ44Wi7tPEptV0t/kEyZ3UtvWrrntKSUmqYViNQFZlpGadOVMOfCHSpao8
 u/DN8oPcGztJ+VNEf4J3BdoJfS6pg7YDEQ+ZyhgiG2poeQEqfV114+Osk3cfBbAO123GFw2s5iu
 gEdlb6Gsx9wuIH946Xq4vw2OZYiH3hGknjAPpj7bKhtpjvmqzZDXIGr+qCx0pNqFupEHOj4Q/29
 JTI062DG2/dq2L84orR4=
X-Google-Smtp-Source: AGHT+IEA8T/ca5/dURw5UAMiUFbILUQ9yn0EiZlKP1TwV8ED/tJG43JtFT9pd2r2Uc3j+1XhL2TmsA==
X-Received: by 2002:a05:622a:a10:b0:476:832b:7ee1 with SMTP id
 d75a77b69052e-4771de4892bmr220254251cf.40.1742871304006; 
 Mon, 24 Mar 2025 19:55:04 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4771d176113sm54712021cf.17.2025.03.24.19.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 19:55:03 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, festevam@gmail.com, marek.vasut@mailbox.org,
 Adam Ford <aford173@gmail.com>, Stefano Babic <sbabic@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Yannic Moog <y.moog@phytec.de>,
 Teresa Remmet <t.remmet@phytec.de>, Gilles Talis <gilles.talis@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ye Li <ye.li@nxp.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Wadim Egorov <w.egorov@phytec.de>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH V4 0/7] Migrate IMX8, IMX8M and IMX9 to use imx8_cpu
Date: Mon, 24 Mar 2025 21:54:41 -0500
Message-ID: <20250325025452.950303-1-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
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

The imx8_cpu driver uses the driver model to represent the processor
cores in the dm tree as well as display the processor type and speed
on boot.  Currently, the imx8_cpu driver only displays the temperature
grade of the processor if the processor is IMX9, so in order to display
that info, the check in imx8_cpu is changed to check for IMX_TMU
and IMX_TMU is implied for IMX8, IMX8M and IMX9 SoC familes.  If
users want to fall back to the older method to display the SoC type
or remove the temperature grade information, they can.  Doing this
at the SoC family level reduces the number of duplicated config options
for each board, and was done at the request of the IMX U-Boot custodian.

V4:  Make IMX9 select CPU_IMX instead of imply since it appears to be
     required for all in the platform.
     Fixed some whitespace in imx8_cpu around the temperature grade message.
     Re-ordered some items in Kconfig to keep them alphabetical
     Added more CPU items to the list inside imx8_cpu to match what was done
     from arch/arm/mach-imx/cpu.c.
     
V3:  Added the imply IMX_TMU for the 8M family and added the imply for
     CPU and CPU_IMX to IMX8, IMX8M and IMX9 families.  CPU_IMX depends
     on CPU, so both have to be selected.

V2:  Changed the check in imx8_cpu to drop the IMX9 check and instead
     imply IMX_TMU in the IMX9 family
     
Adam Ford (7):
  imx: imx9: Imply IMX_TMU
  cpu: imx8_cpu: Expand get_imx_type_str list of supported CPUs
  imx: imx8m: Imply IMX_TMU
  cpu: imx8_cpu: Print Speed grade if IMX_TMU.
  imx: imx8m: Imply CPU_IMX by default
  imx: imx8: Imply CPU_IMX by default
  imx: imx9: Imply CPU_IMX by default

 arch/arm/mach-imx/imx8/Kconfig  |  2 ++
 arch/arm/mach-imx/imx8m/Kconfig |  3 ++
 arch/arm/mach-imx/imx9/Kconfig  |  3 ++
 drivers/cpu/imx8_cpu.c          | 54 ++++++++++++++++++++++++++++-----
 4 files changed, 54 insertions(+), 8 deletions(-)

-- 
2.45.2

