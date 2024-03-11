Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE640C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 13:05:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED54987D50;
	Mon, 11 Mar 2024 14:05:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ao7weXW+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D64D587DD5; Mon, 11 Mar 2024 14:05:31 +0100 (CET)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5986D87D35
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 14:05:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e693adc8a2so92382b3a.1
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 06:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710162328; x=1710767128; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0Qxjd8mzm/6AO87A5m4P+bjXnjxr1VnpMFXIT3TgGCQ=;
 b=Ao7weXW+HT2P3zhPx3Cb0VqHPi9fCxpGMfZxf5nMJPbORmsjqQH5c/jDMoo5Bxig5l
 iv8fqN6TJkfps0KeoTFhs7nWMbg/52Doh1mWFE0CE2yX21WhlE1I2pwdQQCRRXDRzmv3
 pQIyhNnQjUHg25MAdLxChHQSHPG2dSwy4vFgaXBKyF5udFEWH2FTGnd8eFjhXE6mIM6q
 8zKT/NXeir9ac0L1emYW5siAUk6QImk7bubVvgz3H6erlskGqAr1TR7QaSBnUKOrUCdf
 lJLdakHdvcSkBzUT0Qjy3tJlqv8NUTEPchq5De9m8W7C6400UL6RV8mpeYyKMK5fhhxw
 jtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710162328; x=1710767128;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0Qxjd8mzm/6AO87A5m4P+bjXnjxr1VnpMFXIT3TgGCQ=;
 b=Xu0r74Yv5xv9YcCQ1DvIEO5NXI1dpCYkcxwAn9tdtZhwIEaMZ99DhsCdgH4vWne87R
 x7BGGUUG2Cy2D8BNSDw0vgJnuTSEmzSQKPuUl70UpgyoT0p/xgRruWCRYrMwtETqC24B
 DVLc5c2nsXHgyw7qChjPUAvfmfF6x5NcDrWi8jax/nNIOADU7iLdRjJoVtkYZi4bsU1C
 LBYxoPw3W3ckBJCI5X8sHOmbX/WwLoGCoDQXTNLUgNd3PmOyaylVwfZZ23BBH5XYnOp1
 EdNTEWi/NeUsHkAl9T+lXGxDHz7ERbO3r+iTUNs8DtkijNjnI+cMFvGspibI67whkZ5f
 nBmw==
X-Gm-Message-State: AOJu0YwUJn78ic2pmW9wFu71a3c2N7TxoBzjfbfdwuKTOBH5lIsf+/Vt
 PUzxhWxnxfJPxurhnYm8ymB937t35wj5cj0QkoSM571ppGWD+nlgmY+/6ZsZ
X-Google-Smtp-Source: AGHT+IEKUqSz53hF7M35jhxL+17zzjcs8acv/DboTJkSlpuWbRNHHO0KBg5CiwEhxJhdAnwfvBaU9g==
X-Received: by 2002:a05:6a00:2384:b0:6e6:13ec:7170 with SMTP id
 f4-20020a056a00238400b006e613ec7170mr8876691pfc.0.1710162327672; 
 Mon, 11 Mar 2024 06:05:27 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:83b4:3a91:6574:10ae])
 by smtp.gmail.com with ESMTPSA id
 x18-20020aa784d2000000b006e571bef670sm4323218pfn.70.2024.03.11.06.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 06:05:27 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20240311
Date: Mon, 11 Mar 2024 10:05:24 -0300
Message-Id: <20240311130524.2353972-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Hi Tom,

Please pull from u-boot-imx, thanks.

The following changes since commit 0981f8900f2b1f45a3f282b704012b5374fdd7a6:

  Merge https://source.denx.de/u-boot/custodians/u-boot-usb (2024-03-09 11:29:48 -0500)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20240311

for you to fetch changes up to 4484c7b3c38dcb21244a882d0b81d141db1ed162:

  arm: dts: imx8mp-beacon-kit: Resync DTS with Linux 6.8 (2024-03-11 08:43:42 -0300)

u-boot-imx-master-20240311
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/19896

- Use TF-A on imx8mp_beacon to fix boot regression.
- Use latest 6.8 dts for imx8mp_beacon.
- Fix the RAM initialization for phycore_imx8mp PCL-070 rev 1.
- Describe the 0087 i.mx8m mini product variant in tdx-cfg-block.
----------------------------------------------------------------
Adam Ford (2):
      configs: imx8mp_beacon: Fall back to using TF-A
      arm: dts: imx8mp-beacon-kit: Resync DTS with Linux 6.8

Benjamin Hahn (2):
      board: phytec: common: phytec_som_detection: Add phytec_get_som_type
      board: phycore_imx8mp: Use 2GHz RAM timings for PCL-070 from pcb_rev 1

Joao Paulo Goncalves (1):
      toradex: tdx-cfg-block: add 0087 i.mx8m mini product variant

 arch/arm/dts/imx8mp-beacon-kit-u-boot.dtsi |  11 ++
 arch/arm/dts/imx8mp-beacon-kit.dts         | 245 ++++++++++++++++++++++++++++-
 arch/arm/dts/imx8mp-beacon-som.dtsi        |  71 +++++++++
 board/phytec/common/phytec_som_detection.c |  10 ++
 board/phytec/common/phytec_som_detection.h |   8 +
 board/phytec/phycore_imx8mp/spl.c          |   6 +-
 board/toradex/common/tdx-cfg-block.c       |   1 +
 board/toradex/common/tdx-cfg-block.h       |   1 +
 configs/imx8mp_beacon_defconfig            |   7 -
 9 files changed, 345 insertions(+), 15 deletions(-)
