Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD1CC282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 23:42:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 546C18141E;
	Wed, 19 Mar 2025 00:42:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cNeXTTIZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DF098129F; Wed, 19 Mar 2025 00:42:41 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5022981026
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 00:42:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-476a304a8edso58152281cf.3
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 16:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742341357; x=1742946157; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vQkA8kRYf5znaP5NuvQZtMjmQFljxPkbrUtxA8A+aWc=;
 b=cNeXTTIZ9mPWMxEEJ+7uldR4MWO62MzvoXwHNaqHm9XOcSugfvXABzcIK078+u4ZrN
 THXL4Seuvn4k3XoDnIUIJWdv9PWHHsY222Xa/WTVuCvjLN8XlFW6Pl6W3ozo2lQdIk2v
 pey/KeBkE7aM/zvXMPalNjLU+BPmQ4zbumxHzhxkn8RPp/QGSncI2bw97SHGsdeLaTNO
 B24NVQmS+/kFZbFHu5NptvvPSGl7iNqfeY31eHpzXXaAcIKWMYfy67Q/Fuiq4D7rDW4H
 qvjk8slkGS2/D36PukiXBaLR5Znup1HAg7XfkcyZVyUAxZJTwHopNq30x+LPdIieWvM/
 k/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742341357; x=1742946157;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vQkA8kRYf5znaP5NuvQZtMjmQFljxPkbrUtxA8A+aWc=;
 b=txM8PAGzJGxKn+Sb+e5WL/pZmdKP83xp4ojXCVIKRo2S3yZXbkqLyjl9rCuc+y1Ohv
 4+zSh/iTAYlxa/0liv2LPAfpXX/rygZgOYHG3vhg2o/EThVJudQNpYHmWZpyZ71BlEMm
 jZlTRhLbdw8toZi3xDxJx3WpDUfzcUB8uMHhJXBOkZGrVIj3nOcNenTzsGZnCBaiQXp0
 nUqdPe29Z6rV+54PBdACmIxEP9RNRsgLpbk/6AvS0UWddAM7n3/86Ua+0B+eefygNFCU
 cb8eELfNFJfjCaLsJi3X8C105+qYEbBeEm3bQ8lNnT534p1HzmPsI6KaKr1SO7gasGHw
 IXmg==
X-Gm-Message-State: AOJu0YxY3crfxUlTXnlD7Kl6yuYkGsCicCBTneVacXpkfJ/715kZ3DjP
 WHyZ6xps/tyr3YxdelbyJqA6VTbGHFBQzyFsny9Rjpmnq3N+mSn+MG2HhA==
X-Gm-Gg: ASbGnct5I5DXZytjsqa/6b+IDEqkmN+e5iIXDUmnMZ5GCtXYn19QZXebODaGASCfOdf
 IHwtUvgufrIa+50DaSTbBt+6AGWPVnjBHD3aJ2JwV9c49RyTLNbh+oK2T3sDrBS8VL45PyYwmLV
 tGnUW8H7I10czOVf7R25B7btjyVXU25C1R/ezsC4eVBEUiqO3D/LNXaE7//stOx05YepfyBYdTu
 Xpt6iw4ZONkkplEkUsTfzMOWqw19sp3HB8c/YVQNcuMOS3/S3yeD3FrlIe6n+88ViJOCK6n5QeA
 KpdY9BIsZ9A7bIe6eRfNtssTFQpx78MJhc4/MEIpM3yDss+YdqrBPw9BRLYlOS17V/uPh/KWW6S
 IKwIgkVqiPx2J2MzHtQM=
X-Google-Smtp-Source: AGHT+IHgFk/5MDfp5yv0J2NRTuv2cVg5sPcUqdY09GfkHDozwDjFpzWyVGhA/KiA+CFRCg6xgMPKYg==
X-Received: by 2002:a05:622a:1c05:b0:476:fcf9:229d with SMTP id
 d75a77b69052e-477081c7d44mr12667191cf.0.1742341357560; 
 Tue, 18 Mar 2025 16:42:37 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb82c1b7sm72518261cf.74.2025.03.18.16.42.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 16:42:37 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 00/10] clk: imx: Use Clock framework to register UART clocks
Date: Tue, 18 Mar 2025 18:38:28 -0500
Message-ID: <20250318233849.587520-1-aford173@gmail.com>
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
enabled.  Even when the driver model enumerates the UART, the driver model
doesn't always reflect the proper clock state, because these clocks are not
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

