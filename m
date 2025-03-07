Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64913C282DE
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 13:08:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DFCB81276;
	Fri,  7 Mar 2025 14:08:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ezV8LNjO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B632808A2; Fri,  7 Mar 2025 11:35:07 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2425080017
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 11:35:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ernestvanhoecke@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac256f4b3ecso91678666b.0
 for <u-boot@lists.denx.de>; Fri, 07 Mar 2025 02:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741343704; x=1741948504; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g495x7yZM3zxNseQPKJAvCI70j/A8AjKBI45sJrMq3Q=;
 b=ezV8LNjOLrbsqhkje6HOqxL0yF3lMdabs0D6CWZ3yZZf+DYxarnFhITXfsoDWakpZm
 uzs2U5hTADonQNoTAtqn1dR1XKBFEhTT9b+6IQMRn1GMlRRdow3rd5rYIFXOO20LPSNn
 MH8cvSR/+aJmWAxxI1H9ZUNbraWAFe0SpLW+wd1pOkEQlo0Ql6pl7Kgad3lIras5EqDo
 3QoJE9x0OyJ2wmGg1D/fnS/ml2s+tmy4r+HiDnF8xKSCb3Ok5GjSEWxVxp9kj1J+ZGpl
 bE+mADcvtXPe53ddBco1S3N1wOi2g9X8p0Q+ls8mnNPj62XQExH+LtRwNLv6Kgr0BmFN
 dlqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741343704; x=1741948504;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g495x7yZM3zxNseQPKJAvCI70j/A8AjKBI45sJrMq3Q=;
 b=dYFfes0PKYDehkcZl46bGlQAeBv0jei/efEGC7btGjG6+VrjX5pReqoYa/b76STq28
 ZvKyErsBYctUHdvzhrCyeBhl8YU/PI8uxsfXBNnoWWmV2alWVi08r+tY8Y0XmAKCcdKd
 LI1U2ZdkfFD4tWe1EmNw3Di80HPnX06/6b4eQgx7RtuwHHoXstgSuO5C42rTKpNmlNIu
 iQ53kYiZQFs8mPJYB9mypW8L/hwwkpNKd+hLuWyAFzUGblNnKgg8knq2o10HMZobTnnr
 w/rvvPp3p7oQDZlouX/uainoHUD/MATLow2a/9gFCEqJE2ckkRf5Izb/PdJ6Lih5mwW8
 ukmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEWMhyOVonQeH2rnilUV5yPjct7OfSdoXOx7LIsCiGArVL1bRxt75UdUtWHrDmdHIwNa9ZObc=@lists.denx.de
X-Gm-Message-State: AOJu0YzurSE/53GMHD9D0KGs43qmkvXOZoWH8OZNA4PpERIJxsof/Pxa
 0pHg20dq4MWPcHhL3wAWzzv6gWfwbWcgUTwXYFoiEIt4TSG97oP/
X-Gm-Gg: ASbGncvty+MjXaqRirPtFndDdE730UhWn0H3yq1vueDQ3kPN1LRhFjCtORMEQARzUiI
 vsLlZDLpBE97uBnkIoXPekppeNNGlfFk13Zx9QJYKhBUbRU2N0UqICftJYHX6niUWQ3a1EEEPE2
 7f7lODg4HiThyofpyxET+06SAIs5HIvtd06LBIGFLuAkQAJQuQSnze9BlNpoRxPP/c3+JAEbGwj
 plFn+a/fTURowfCX2NMqOG0KmS4L9SSoUPn92VNQOpr8+MeCnb9btV6EYlpObynFaAynMG/bVwz
 G5VJRjXOR7k5Tq7K37PCfxz6Eme6yA5oFtZhcbAkQplMKXbCQZxJVGNG+RgwM4rgDxC9hNv4+HL
 cRlUbDozJLQQS6HPJa+52Lj8=
X-Google-Smtp-Source: AGHT+IHJtrqxhbcEdLP/S2xDZSv2Lmk4UYU/c/cq9n6we1b8X+xZkTo/QO8bNVBhuMFJAhOwYWtraw==
X-Received: by 2002:a17:907:a193:b0:ac1:eeba:f88 with SMTP id
 a640c23a62f3a-ac24e98dcdamr299112566b.11.1741343704303; 
 Fri, 07 Mar 2025 02:35:04 -0800 (PST)
Received: from ernest.corp.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac23988b403sm254867166b.129.2025.03.07.02.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 02:35:03 -0800 (PST)
From: ernestvanhoecke@gmail.com
X-Google-Original-From: ernest.vanhoecke@toradex.com
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de, Parth Pancholi <parth.pancholi@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 0/2] Support Apalis/Colibri imx6 v1.2
Date: Fri,  7 Mar 2025 11:34:12 +0100
Message-ID: <20250307103454.32661-1-ernest.vanhoecke@toradex.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 07 Mar 2025 14:08:51 +0100
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

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

Apalis/Colibri iMX6 V1.2 will replace the STMPE811 ADC/Touch controller
which is EOL by the TLA2024 ADC and AD7879 touch controller.
To support this new version, we detect the presence of either the
STMPE811 or TLA2024 during boot and set a new environment variable named
"variant". This will allow us to select the correct DT easily.

"variant" environment variable behaviour:
- Empty or absent for all versions below v1.2 (STMPE811)
- "-v1.2" for all versions starting from v1.2 (TLA2024 + AD7879)

This behaviour is then used by the PREBOOT logic:
preboot=test -n ${fdtfile} || setenv fdtfile imx6q-apalis${variant}-${fdt_board}.dtb

v2: Fixed the "From" field
v1: https://lore.kernel.org/u-boot/20250228095317.621037-1-ernest.vanhoecke@toradex.com/

Ernest Van Hoecke (2):
  board: toradex: apalis/colibri imx6: Detect new v1.2 SoM variant
  toradex: apalis/colibri imx6: Select correct DTB for SoM v1.2+

 board/toradex/apalis_imx6/apalis_imx6.c   | 31 +++++++++++++++++++++++
 board/toradex/colibri_imx6/colibri_imx6.c | 31 +++++++++++++++++++++++
 configs/apalis_imx6_defconfig             |  2 +-
 configs/colibri_imx6_defconfig            |  2 +-
 4 files changed, 64 insertions(+), 2 deletions(-)

-- 
2.43.0

