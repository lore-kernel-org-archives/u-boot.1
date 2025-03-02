Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE729C282C6
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 16:54:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FEF480F70;
	Sun,  2 Mar 2025 17:53:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bAFTwLa3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3492811B2; Sun,  2 Mar 2025 17:53:56 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3F39807B1
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 17:53:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-85ad83ba141so27380739f.2
 for <u-boot@lists.denx.de>; Sun, 02 Mar 2025 08:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740934378; x=1741539178; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VOxCz7ZTxXZzhtr1MG2KYsCF6SHx+yLZSWLss5XXXy8=;
 b=bAFTwLa3Qjq8WL/oRL3tkDTAmRffAxrUuWQILRmrWcpYP960wDm6mZS9WTMXlGjoPx
 +aXM1ABTO9e3MWNecE1SF7F0b4BodOqZTokYaT9s2s1LUf59vTIeNbMpnzcu/hrj98/8
 ubnKN3GR4/muOzGg8f8s3hlAq8XfVN58CylIEuAqGznaYtjyirWBEKxu2x+AQa1qMRBj
 ok+/6H2yLMZ2CWf8StSmyradodKGL5/9FDO39fvtX4Ctifg3A+zKo4XqBzfl1SVzXgJE
 IK3nNwzcXAyibiUkUYo3Bxyvnpf5AscM1eOE/6/elQvScy0NL9oRhQsoHtNaUXDNa4G2
 vpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740934378; x=1741539178;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VOxCz7ZTxXZzhtr1MG2KYsCF6SHx+yLZSWLss5XXXy8=;
 b=sN/6dP7vz/mIQgk//iCEnendayLzEAGZVfk4m/fcY5TwmhF/n8L1mlT450v44QMXfF
 4D1Vi7s4IOm0IRqlGiRUkHENd0Qfkv7uEuryne9zs6T7qKpW2YhpqBqTFReTtzQfm4VJ
 snPdreTwZoyPw0qdhrtWui5vBgEf/hAZ/gfNwOhxiayppZGHetKyNd81MNUt0JnppTSJ
 PJNBW23Uj/RAhd0cS2DojW4cpGJvbLtTkvngg4u+Q7BhM1BowzNYjTiW67NEgeXTnlIf
 nfNlpmBQgvfMidInsa6mCJ38shdYsy+eSbpAAuOxlMEoGo0mTOuUPwNqlN5cbxRZiixT
 hLEA==
X-Gm-Message-State: AOJu0Yy+TE2YJ0KkBtOye7GYzFxQBkPy1+zQK9duKZ+vtF58J3vrPtVT
 cPCZOVmjHv3NGe1xxirSOBMRrMTrO/cBeBB9J5IHTqPgzRptUyNUCAYCiQ==
X-Gm-Gg: ASbGncs4DH+GRFHyx34TAYtGRryEW/85zXn6pQPAhxw9wn5Ava5AgiVvBNGUSqp5Khi
 eEM1ARbkk4KIyaW+balGcUNtQCvCoxTCncTLX+SYmQp3wYFihyi7oNoqFPZCkE128rAxLyXfHgQ
 hxvhFbzMwOcrneY7eThZZW2eJIEfRME8Ahvr/IMeofV1aIvK5sV7mZRDY0KopvcYAp7eXSfHeEs
 LJ9N9uQmPWwsYNvmi9pZ1unjcWata7UFcycm7VehDjZmSQi2VpVURUrjnq5BQ7XM3RhP8zRDlnL
 ZJ/ahyzKdxo1ieXE8gC3kNL5+nWlox+1TchpzRiD4YVYsho38Bff5WdDytypmqRJUouiNlOTsY7
 HXC6PbfqrKfT27T14i7A=
X-Google-Smtp-Source: AGHT+IGPayaH/HK1Ed3TQEufLVLOZ4V39i6dn99BCE1UrHjfL1FapEfEY+tc8yatHUrQProEpdPPHQ==
X-Received: by 2002:a05:6602:2dd5:b0:855:b1bb:1bd4 with SMTP id
 ca18e2360f4ac-85881ef7eb8mr1037810339f.1.1740934378253; 
 Sun, 02 Mar 2025 08:52:58 -0800 (PST)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f07e1310bbsm982714173.9.2025.03.02.08.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Mar 2025 08:52:57 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Tim Harvey <tharvey@gateworks.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 00/10] clk: imx: Use Clock frameworkt to register UART clocks
Date: Sun,  2 Mar 2025 10:52:27 -0600
Message-ID: <20250302165249.267992-1-aford173@gmail.com>
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

Currenty, most peripherals enable/disable their respecive clocks using
the clock framework, but serial ports various imx platsforms do not.  Some
of the newer NXP SoC's register the UART clocks, but they are not necessarily
associated the to serial_mxc driver, so these clocks need to be manually
enabled, and even when the driver model enumerates the UART, the driver model
doesn't always reflect the proper clock state beacause these clocks are not
controlled by the serial driver.

This series does a few things:

Register the missing UART clocks on imx6, 8mm, 8mn,
fixes a build dependency on CCF_FRAMEWORK on imx8mp in SPL,
bulk enables the UART clocks from the serial_mxc driver,
and finally, removes the manual references to enabling the
UART clocks on Beacon EmbeddedWorks imx8mm, imx8mn, and imx8mp
development kits.

I don't have access to an imx6 board right now, nor do I have imx9 or
imxrt boards, so I can't verify regressions on those platforms.

For users who want to try this series and remove the manual UART calls,
make sure the SoC clock driver is enabled in SPL and OF_SPL_REMOVE_PROPS
should not remove the clocks or clock names.

With this series both "clk dump" and "dm tree" show the UART clocks are
registred and the one clocking the console UART is enabled and running.

Adam Ford (10):
  clk: imx6q: Properly handle imx6qp ESPI clk_sels
  clk: imx6q: Register UART clocks
  clk: imx8mm: register UART clocks
  clk: imx8mn: register UART clocks
  serial: mxc: Support bulk enabling clocks
  board: beacon: imx8mm: Let clock system enable UART clock
  board: beacon: imx8mn: Let clock system enable UART clock
  clk: imx: select SPL_CLK_COMPOSITE_CCF when SPL_CLK_IMX8MP
  configs: imx8mp_beacon: Select SPL_CLK_IMX8MP
  board: beacon: imx8mp: Let clock system enable UART clock

 board/beacon/imx8mm/spl.c             |  6 +----
 board/beacon/imx8mn/spl.c             |  2 --
 board/beacon/imx8mp/spl.c             |  2 --
 configs/imx8mp_beacon_defconfig       |  1 +
 drivers/clk/imx/Kconfig               |  1 +
 drivers/clk/imx/clk-imx6q.c           | 34 ++++++++++++++++++++++++---
 drivers/clk/imx/clk-imx8mm.c          | 34 +++++++++++++++++++++++++++
 drivers/clk/imx/clk-imx8mn.c          | 32 +++++++++++++++++++++++++
 drivers/serial/serial_mxc.c           | 11 +++++++++
 include/dm/platform_data/serial_mxc.h |  1 +
 10 files changed, 112 insertions(+), 12 deletions(-)

-- 
2.45.2

