Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4A7C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 08:33:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E665F86F9E;
	Mon,  6 Nov 2023 09:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vg8N1n1F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED04B86F42; Mon,  6 Nov 2023 09:32:57 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9177486BD4
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 09:32:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9db6cf8309cso586128166b.0
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 00:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699259573; x=1699864373; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zPVUl7JX/T/PjePDhDNnstgAouauUqe52RaB3sANmVg=;
 b=Vg8N1n1FIEW+8A7/58u5barotlZxzLcTngT33xD7aMIK5hijJSl6Hp7Q/CaDQWnVRg
 41g5QRtilfVXZCWz8pzTdix7EF+sYlwSnFEgs8bq0wS411Un/jeiUpWoa+bzcaclquIs
 bxVyt/BYDVLrNtu6qTFIOiTxZKrzaJNl4xqL3JWtLre+EnZs6dVhxwT8zextluPbcVi3
 jIB4OH99w/cP01+kwt+zqEptxc8mxaVc4OdeTS51YOY1nBNlyOQBrG2001yVSrNRXhAC
 U5JGpMHAcev6OQaflZnDHRgntaNhxUS3x8aRmiqJb5HevoXgAbgX3cEupg0P1jkSYB4R
 921g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699259573; x=1699864373;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zPVUl7JX/T/PjePDhDNnstgAouauUqe52RaB3sANmVg=;
 b=pUt9A96hmVQPy83qD52WaeFIzEte8YUkAm8E5ugpanVrNrDZT2Q/GUpcu/pdN86tbc
 0kGgxvj4UCnOD5MjtKs8UxkpGZeG32oL2/GI2WLDd8MB+QhM+bRU7aM5nsZKO1/QpBM7
 R84bO4C88xzIX+up230+1b/6D8K8/jjF71MB8VxYqwE3V/sBFYQzgu8a978PO+yWZdmX
 E8ETQnkW7tz3NqK8TpG2Yrzv+8NKu/5hn/Sx782RgqB5JMNUdc5X4dFesW01Nw0Elurd
 +R3uCyXV3Z0Rw/uD4CdxgvduOu+v9nvNll34jKjBtGxbNFIVv4QHN5Hoyl6W7MV0vNPT
 RPbw==
X-Gm-Message-State: AOJu0Yx8CJTArvR6Vb8A4Ebuc62DcEV+8GXHgjwMqwFtsC7wSdclSeeH
 g4IaP+BKSwmSsAk4nMDxZ3Xy8MJm/1g=
X-Google-Smtp-Source: AGHT+IGiQleseIUBE/lZmcCLxP0MIu0qCU6hKm2I7wQebiad2XkBZsbAu6iPR4i/hmF7PrlUXGRizQ==
X-Received: by 2002:a17:906:db01:b0:9b2:babb:5fe9 with SMTP id
 xj1-20020a170906db0100b009b2babb5fe9mr12732748ejb.23.1699259572431; 
 Mon, 06 Nov 2023 00:32:52 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 t21-20020a170906269500b009a1a653770bsm3799715ejc.87.2023.11.06.00.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 00:32:52 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/5] Convert recently merged T30 boards to use DM PMIC
Date: Mon,  6 Nov 2023 10:32:24 +0200
Message-Id: <20231106083229.256322-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Since the proposed PMIC patches have been accepted, I see the need
to convert boards which I maintain to use DM drivers instead of board hacks.

Svyatoslav Ryhel (5):
  board: lg-x3: convert LG Optimus 4X and Vu to use DM PMIC
  board: endeavoru: convert HTC One X to use DM PMIC
  board: transformer-t30: convert ASUS Transformers to use DM PMIC
  board: grouper: convert ASUS Google Nexus 7 (2012) to use DM PMIC
  ARM: dts: tegra30: enable USB PHY node on some devices

 arch/arm/dts/tegra30-asus-grouper-common.dtsi |   7 +
 .../dts/tegra30-asus-nexus7-grouper-E1565.dts |   1 +
 .../dts/tegra30-asus-nexus7-grouper-PM269.dts |   1 +
 .../dts/tegra30-asus-nexus7-tilapia-E1565.dts |   1 +
 arch/arm/dts/tegra30-asus-p1801-t.dts         |  17 ++
 arch/arm/dts/tegra30-asus-tf600t.dts          |  15 ++
 arch/arm/dts/tegra30-asus-transformer.dtsi    |   9 +
 arch/arm/dts/tegra30-htc-endeavoru.dts        |   8 +
 arch/arm/dts/tegra30-lg-x3.dtsi               |   9 +
 board/asus/grouper/Kconfig                    |   8 -
 board/asus/grouper/Makefile                   |   4 +-
 .../asus/grouper/configs/grouper_E1565.config |   6 +-
 .../asus/grouper/configs/grouper_PM269.config |   6 +-
 board/asus/grouper/configs/tilapia.config     |   6 +-
 board/asus/grouper/grouper-spl-max.c          |   2 +-
 board/asus/grouper/grouper-spl-ti.c           |   2 +-
 board/asus/grouper/grouper.c                  | 154 +-----------------
 board/asus/transformer-t30/Kconfig            |  10 --
 .../transformer-t30/configs/tf600t.config     |   2 +-
 .../transformer-t30/transformer-t30-spl.c     |   2 +-
 board/asus/transformer-t30/transformer-t30.c  | 121 +-------------
 board/htc/endeavoru/endeavoru-spl.c           |   2 +-
 board/htc/endeavoru/endeavoru.c               |  72 +-------
 board/lg/x3-t30/x3-t30-spl.c                  |   2 +-
 board/lg/x3-t30/x3-t30.c                      |  97 +----------
 configs/endeavoru_defconfig                   |   4 +
 configs/grouper_common_defconfig              |   1 +
 configs/transformer_t30_defconfig             |   5 +
 configs/x3_t30_defconfig                      |   4 +
 29 files changed, 128 insertions(+), 450 deletions(-)

-- 
2.40.1

