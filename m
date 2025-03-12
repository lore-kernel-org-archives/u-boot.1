Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A921CC282EC
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 00:31:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D515980FB9;
	Wed, 12 Mar 2025 01:31:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N3abdKTZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB48A80FB9; Wed, 12 Mar 2025 01:31:46 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7498D80756
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 01:31:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7c54f67db99so33546485a.1
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 17:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741739502; x=1742344302; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Bz7HdlTq3YXQ+asNanFSG+xnTTXB2a2jkl14004cS3M=;
 b=N3abdKTZuG9N7zzy34Rmmvw+txD3JOGNEgMm9jeshFlcsNgXHoddwPuXN2wIPESm/8
 vXTjFeZ+aLfWpYDMdHGNtkfM/jWjtl8SbyifBqng+eV+pdCy9wpALGlTzfQDBnI24HhY
 fzdPv4e7ZF0JPdJEgqXaKF+AOBVvhRR0px2WKpeq57/ijZR3OFACFmHjTkEA9UZE/101
 j5vtYGHkcoiICg8xxWjPDhQpyYCm/LPtmk9CROWHgP7XtrCBMxx6syhY0fM+PiOaZ1S/
 hvKWCUPPuneT3DRLDBw5B+ZELasUZASaBzsQH0SZU7KX2cIgif+sILr0FuCuLmWx8J2e
 bQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741739502; x=1742344302;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bz7HdlTq3YXQ+asNanFSG+xnTTXB2a2jkl14004cS3M=;
 b=VBEDzSaJVdaK7MSG5nHInCms+Suoj7XWSchB27rU0cwzHnkRYWxV9mrskddDaYuJTB
 ewE2wSkXCAMAdyXmvnNrJnMnqBWgLbFMmYxmJ8arysvMSXLJwDyP1S0o77CPGNDybg1F
 JjJS3BwxrA5+SVOXSDt2aNYeFbkiT1Bx57GcZSfnHLUWMTe4zEekyBreIsiOdpGtO7rZ
 cfnSt/vWU707ywjuR6jyFQQvdDbuUNQCay/FlNlmgvT4000AXoXivQwQEred0rHR+cS3
 izvI9EuYUTvIhPtf67hcqk3J3DXSp8fHL8B67RqPJ+QmZFMVjgELwy3UBh2//WOdC7d5
 oWzg==
X-Gm-Message-State: AOJu0YwIAARwufU/mLRiHIgRrFMXEvmsooygeJjIrn3FgXNLGg8b8cyq
 /coM0oA5thvRqorPcz15aSw+Y+lbooIngTg8rIujKNMon5Fi1hcn/dNjVg==
X-Gm-Gg: ASbGncsERxHbOJnyQb03fK1qIEQRDnUapdisg7g1nAidBJtGCez9DSIqzZAUo0dzYDM
 lL3TuI1N0DzG/mtz32oYC9lx5FafNMc/C6qQvWQRPgOTyQFS1I6uajJ2UMH+Du09jPAkIpNyoWM
 f5c7BxR0MtlWFflY+EKxKIHmI6Gx4XGOX1Fzgv8q/BLRo2RYwo2dODpaOCWxou+/O7Sm+pqIj/g
 4qtn8RtH5fwd18xqE+6U11ZOgx/P3u0NrDEwsi+FxU8aHMHziXK0X6mJ0ZmPCy37lS/ePBo199A
 NJYCx5vR6Lu+Bf8sbga/qdIlXD+qMQRSkhfK0k5UAC+KzJDg+SZKLMOeoZ0Q/p/gjzVsy5pdo9P
 NTl5ofD1MlJDyy+iLI7E=
X-Google-Smtp-Source: AGHT+IGOoH1IpkXlJzyix9UtHSedMIXgs2cMmBeOaUE6ySCXReCyc++BwE2OIGkseg2ptpLkT3Yuyg==
X-Received: by 2002:a05:620a:43aa:b0:7b6:d273:9b4f with SMTP id
 af79cd13be357-7c55eecfd18mr873565785a.11.1741739502539; 
 Tue, 11 Mar 2025 17:31:42 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f715b798sm78025286d6.80.2025.03.11.17.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 17:31:41 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 00/10] clk: imx: Use Clock frameworkt to register UART clocks
Date: Tue, 11 Mar 2025 19:30:20 -0500
Message-ID: <20250312003041.110023-1-aford173@gmail.com>
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

---
V2: Fix name of "ECSPI" and elimiate helper function, and fix build error.


-- 
2.45.2

