Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F8BC36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 18:00:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F32480EEF;
	Mon, 24 Mar 2025 19:00:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="AJ01PAWB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28102811AC; Mon, 24 Mar 2025 19:00:55 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4590580548
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 19:00:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so2523007f8f.0
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 11:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1742839251; x=1743444051;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wvZkbdIVJrvV3lWjV8CcOLAFsC9LTMIZ/snWkKCGynU=;
 b=AJ01PAWBHgtp3l3wHJ0exKCzQHySAUFw1DwU3BmC4GPDqwbCJUKKET89wfhoN420sM
 46HVjP9ouIVkBK31H7jqBhosqHGyMI/wV2HGQbbgYBHzPZIIr5Q59V/2HfFfVIGKm2h5
 DT90+eXxPB5MVgZhfHqClNFH1qP0BJjrla30k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742839251; x=1743444051;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wvZkbdIVJrvV3lWjV8CcOLAFsC9LTMIZ/snWkKCGynU=;
 b=WmmVrjDwfg0/Ti0ZuYvjPjU+qsqgfgShrX1hEU2F1QK0y8dBH31p2GeAhesKDaWn20
 mMlNI8EcZkl8WsUshp5+PUxireAr+i+lN1pd9NdXJJyQvdn8OlxfFXSZ6Gd41KljKy8y
 Nyo98x8qIZTGFYLjlbQNcQf1Mc2ZKgZtayfuWBnI87YFmSQA+YLzeM5J3ute7miYh/XU
 KYXou6FoJ09JCFTwEmkTQZsedhrtTTmS5l6T6Fk82MhgwGlrUo9Hj9dGI3eD+t2BkJXb
 qZm9Ncdeu+fyj7/mixK9JS1HUoKV42QiTk+c0LDv8gHkjVoqcJtYKyvCMT+LNl8j5gP3
 Fr+A==
X-Gm-Message-State: AOJu0YzXgOXIIFK5DdhmRlgIyGAgnt7p3SXYHNBECXlnu+xskNKhc5pV
 hzusqauigh3JJLQYD85A2JOJ/PPnIQH6ULX8PNaYIevs+rccmkWSJdQgYymChQ2xZc2yjTHEvz9
 v
X-Gm-Gg: ASbGncuk+iEYzQsNriYtIXD5Px9c+Qce7QQjnPs+4UrJ7nIf/ITNgBv5Yq75lkIW2UD
 YDou2V8PV1KmLitWQUZj2vcIY5+DXnb+PoDvw7Lc/wsQSJoF8lr98FdqNDXka0zQTab2wdz6HLT
 dhwUT19ACzLvjl/aP7ZoiBKRyb/O4hEqvVZ6/KfUVeSYPd6p7tfGv0xmqojalhgDDFEjB4zBLwX
 NdAHPxZoxa9HPAPQdAYpo+RFfqiF+NmLjV4sDDjxA9I5IY+LQaVJYHPcjc9IJ4NzC8zTfcGJXgz
 yVFfpqXch2+ufFIrJSYKbBFJCoyDS1KIfoc95INZ/VLflJfYy8Avtu9nSv0RGncQBxyZnwcKta3
 aIaIqpFZzRh8V/6Dd9ufSNKfGS7fIi+xlIjK1b7/qjJuiiA==
X-Google-Smtp-Source: AGHT+IFE3sqzz3pMNpS8wslP0hPUlHnZYsoJH7+sxSVP27VDeaqlw1/+1/CPE862u8GRrWPxmIGTuw==
X-Received: by 2002:a05:6000:1f8f:b0:391:43ff:8ca8 with SMTP id
 ffacd0b85a97d-3997f91e0d1mr12339564f8f.26.1742839251080; 
 Mon, 24 Mar 2025 11:00:51 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2.196.41.220])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f556a4sm178289285e9.22.2025.03.24.11.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 11:00:50 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Andre Przywara <andre.przywara@arm.com>,
 Anton Bambura <jenneron@protonmail.com>, Fabio Estevam <festevam@denx.de>,
 Jonas Karlman <jonas@kwiboo.se>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>,
 Vikas Manocha <vikas.manocha@st.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 0/6] Support NT35510 panel controller on stm32f769i-disco board
Date: Mon, 24 Mar 2025 19:00:24 +0100
Message-ID: <20250324180047.1571378-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
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

The series, inspired by some of my patches already merged into Linux,
adds support for the Novatek NT35510 panel on the stm32f769i-disco
board. Indeed, the MB1166 board comes in different hardware revisions.
The MB1166-A09 is utilizing a NT35510 panel controller while prior
versions are utilizing an OTM8009a controller.


Dario Binacchi (6):
  ARM: dts: stm32: add DSI support on stm32f769
  ARM: dts: stm32: rename mmc_vcard to vcc-3v3 on stm32f769-disco
  ARM: dts: stm32: add display support on stm32f769-disco
  ARM: dts: add stm32f769-disco-mb1166-reva09
  video: support FRIDA FRD400B25025-A-CTK
  board: stm32f769-disco: support FRD400B25025-A-CTK display

 arch/arm/dts/Makefile                         |    1 +
 .../stm32f769-disco-mb1166-reva09-u-boot.dtsi |    6 +
 .../arm/dts/stm32f769-disco-mb1166-reva09.dts |   13 +
 arch/arm/dts/stm32f769-disco-u-boot.dtsi      |   53 +-
 arch/arm/dts/stm32f769-disco.dts              |   66 +-
 arch/arm/dts/stm32f769.dtsi                   |   20 +
 configs/stm32f769-disco_defconfig             |    2 +
 configs/stm32f769-disco_spl_defconfig         |    2 +
 drivers/video/Kconfig                         |    7 +
 drivers/video/Makefile                        |    1 +
 drivers/video/novatek-nt35510.c               | 1253 +++++++++++++++++
 11 files changed, 1374 insertions(+), 50 deletions(-)
 create mode 100644 arch/arm/dts/stm32f769-disco-mb1166-reva09-u-boot.dtsi
 create mode 100644 arch/arm/dts/stm32f769-disco-mb1166-reva09.dts
 create mode 100644 arch/arm/dts/stm32f769.dtsi
 create mode 100644 drivers/video/novatek-nt35510.c

-- 
2.43.0

