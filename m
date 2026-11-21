Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9B1606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 12:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MPjLPwaO;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=dOVW1hi/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AEC4140515;
	Sat, 21 Nov 2026 12:35:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lSfxmppCkHq5; Sat, 21 Nov 2026 12:35:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9DC404067A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795264501;
	b=ZlEUlaE/LBqh+hDzqVR1mjoVdj6tA6PG+RhTLcpvWUp1jg/6HwWsTuK/gKd+92KWw+E5
	 mlnEeibELgRdX7xt9VkIJTeO5FyQTV0eDjSoHsnc4xDJnNqb5iOSq2Qhtao2tPf7JqNZA
	 7uOzUNe1FX21bBPHJ2VTD2pBNUqyFdvdI0v7K0SB4tC+hSsgzsdb4hVJ3tSwV80MDdqo0
	 fZAUcZdYNO1FNSEo2XgOy4/tWoPODh4j+86M6CisFPpOMxMK7LbCnItxJymFQUGfK0qqf
	 6NZ4sFfEpqCI0vocqx1wGL7mzx6syYmY26tg/H4e1JnVIPED8co0BKIDL+oz9gBCM8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795264501;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JPZ9oA/B+Gz0ryClkoT7lE/q3Keva2mmd38vgmGbTwA=;
	b=lkti/zqvpJcjpDSLVKSSAXnfdvRzeE2CnVrkrcRCO50UKRwfTW+1laikHZycT6dVQiK+
	 +5Jp9QNvQWJPYYUNie2zIxpjY35mQxUIAZzWTY/t5k570mvigoFhmLZCVCm0n/3xRn2i1
	 6IwSAqB7uKHBX1CsPeuJldSxnOjUiJaXPl5x73w2I8CbLdLvCE6K7nxt422FmBm1dbP52
	 v8IrPYrtuZLbFbnmEHlVPdZWoZFGHGb3RDXjp2x4brevEWjPppViwN61aN4RLvHpSG+6x
	 5pg6GPE2GSLtupVa5Tfts7q9mCFRsfeQsQxMRBBEQvjH2OJcj0RHFngqxhpLPwJfuQQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795264501;
	bh=JPZ9oA/B+Gz0ryClkoT7lE/q3Keva2mmd38vgmGbTwA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MPjLPwaOexbsXkc1vrUMOjYDBH0Ezv7xCp4aBYrelzj09oBwnlTlkq+RwqzNhbmUq
	 KVaOG/T8u4Np7V6JcgYyxZ/qsClT7pAw9G7Z1COZxPnhjxNef7IS+fcEfr9nSvsK93
	 t6OWq1Ycy3raRMG1k9lz0BCu2BH/VktM0fFHTvxWBrJ2K/lQImSHqmDjPn517RrPCy
	 0uBkA44dgojlpamnIydnvMPitu47KafLXgp85BVk5L/kr+ne69cuYaNDK4lYNv0eGl
	 0r99I2BMrbNxJ5pSiugijDdbbi0VjJMKVjGlLrx4YjWFe+QC+Xw9LD6dP9GgU2gKT+
	 nDf5+DY05x2wg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9DC404067A;
	Sat, 21 Nov 2026 12:35:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A20D759
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7005940070
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F2kzSdd_e979 for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 12:34:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C7AD740012
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=dOVW1hi/
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C7AD740012
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:34:58 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4a68190a2a7so1524147f8f.1
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 04:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795264496; x=1795869296;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JPZ9oA/B+Gz0ryClkoT7lE/q3Keva2mmd38vgmGbTwA=;
 b=dOVW1hi/s/3CWjbkTU6o0oyFgFy/GuJmFeqtIHIGg51otIj/orOVxFRlTf2LkomDZK
 PG5Kuy59gVCLClra+ishSWzjsnY8FifbriksG/j6uFbfvKtAFeN7EtSabmGY/Cy4Tnaq
 t+KeLfSaJsg2IiL0Jd9UFHXQJBpsfHLqTzSAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795264496; x=1795869296;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JPZ9oA/B+Gz0ryClkoT7lE/q3Keva2mmd38vgmGbTwA=;
 b=mj2RaSFcbTcaoH9QZqWF8PURLrrP1JB0Tlpigvmz46hv0WQB/kg0GXBWv0+XwmLIk3
 s68gNp6PfkaXCpwaSPgMbd/MZ/m4v7eFGRjehgd3KVK4wni7rjMv1rBfXZalPa2vSI5O
 FxCfKJBOFs4ZjgppAKrW6qbyJAdsyi7Fek/NKz1QWm7SS6BKFTQrHiCfg/49tYZNdOfG
 Op8t6QoX3UlQP1xhavaUekO6wLbCV7Q+tUbRTdz64I/vLwCJMvX0A8AuHFeC6BLc5z8U
 2i0LIUoBO74U+QhehcYPtKX+PRlJEydRPlLkoe16fgQiUV4UJ/ioVY9f210VsibI9oo8
 OxLw==
X-Gm-Message-State: APuU4Z8RcZ872xqHRxjKbqsk0fcIOJEkTXDbDpOMSpedBnH5PoMCLLZw
 E8ecY+PUcpTEiIxcje+3ekv/p6KFfQx82rk48EcNJcbgNmZUybvanb65Zum5elg9DNUxojkfTXG
 +WqtH
X-Gm-Gg: AZFdTZdIxbF7KSPbdgy5lVig9rojE/Evqeyp2uqcLkHMIPblpla441GeS8UIqpo+v8T
 4024ktKcDb0TjxYLrzWLq5f0Fuv6RxdW4KC54446Ge7JJPKkYNaVfnVGUFwQ/clmfHv2ut3ccXU
 TuciaXjznXA8E72ZdmPQVAOiFEkyYzNSK/N0Pye3RmU0Y6/jUh+gGU25EqKAoVE68bgrAH9EbMd
 /yo06d0gEj8xVCgrN26rebQjmJQIcKTnla87oOzByKLkEzisC+isq45sY7hp902+hoytcKn+Ulj
 YujCwx6SGmgpDc9fKN7zWmLHgXWj+mZPyBH02Tew6MsAmWbskA6ttczF0rb7AVuEQ8ytMbM45fo
 oFzOyha9MKrLkypUy4UD0nihBycWN3tIdFPYiTmajrAXl5LGAhdF2Xa7Q9us4ZjYXMW5EFajxTH
 u1eF0bLewRpcklxkihvav27v3YAdEHZIfKkbNWNRLN7BDSU6ss+cUZ0TAJcVgkmZ+ij57V2GSTL
 57KJyB/OGiHaZHzsGP+Esko5DXC/+Prlep7+i+TY7cmqH1a48m8GUxqFHpSdQHiBYpscmeGjL4c
 xnnU0Ij6wKns8FAu2SM+sGRG4x8poYWgT1RsWbqX+w4GXs12IOvNIeb6bodsnjvuSD4jc3Cvx5a
 zSnCnyIDB4C/n3oOfJGJ3Lq8zyVEKzGDq2iaiqeNr526ySHiIYn65vuW5ziFvyiIGZvvgzmjaVk
 qmQst6pKl2noI3ubzf94p3Quv39A==
X-Received: by 2002:a5d:64c8:0:b0:4a6:c5f4:cdf7 with SMTP id
 ffacd0b85a97d-4abaa976b7fmr11469286f8f.5.1795264496266; 
 Sat, 21 Nov 2026 04:34:56 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm11720564f8f.8.2026.11.21.04.34.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 04:34:55 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heiko Schocher <hs@nabladev.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Brian Ruley <brian.ruley@gehealthcare.com>,
 David Lechner <dlechner@baylibre.com>, Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Johan Jonker <jbx6244@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Marco Felsch <m.felsch@pengutronix.de>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Minkyu Kang <mk7.kang@samsung.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Vinod Koul <vkoul@kernel.org>, Ye Li <ye.li@nxp.com>,
 u-boot-amlogic@groups.io
Subject: [PATCH v2 00/25] Support display (and even more) on the BSH SMM
 S2/PRO boards
Date: Sat, 21 Nov 2026 13:33:50 +0100
Message-ID: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series was created out of the need to support simple-framebuffer
for BSH boards SMM_S2 and SMM_S2PRO. To achieve this goal, it was
necessary to develop additional code and/or drivers for all the required
components (i. e. clock, power domain, video, etc.). This series has a
Linux counterpart that will also be submitted upstream as soon as
possible.

Sorry for the long time it took to send this v2. Compared to v1, the
series is rebased on top of the clock reparenting rework that came out
of the discussion with Miquel [1], the board-specific PLL enabling is
replaced by a generic handling of the critical clocks in the clock
framework, the patches already merged have been dropped, and the
i.MX8MP media block control is left to the imx8mp-mediamix driver.

Tested on the BSH SMM S2 PRO.

[1] https://lore.kernel.org/all/20240910101344.110633-1-miquel.raynal@bootlin.com/

Changes in v2:
- Add patch, replacing "clk: imx8mn: Mark IMX8MN_SYS_PLL2 and
  IMX8MN_SYS_PLL3 as enabled" with a generic solution
- Reword subject and commit message to describe the change
- Fix the coding style of the new clocks
- Add patch
- Rebase on top of the parent enabling now done by clk_set_parent()
- Read the flags from the private clock
- Add CLK_SET_RATE_UNGATE support
- Treat an error pointer returned by clk_get_parent() as no parent
- Reword subject and commit message
- Fix build error
- Drop i.MX8MP support, already provided by the imx8mp-mediamix driver
- Let the power domain uclass count the domain references
- Check the domains allocation
- Reword subject and commit message
- Look up a device as a bridge before looking it up as a DSI host
- Reword commit message
- Add patch, split from "video: Update mxsfb video drivers for
  iMX8MM/iMX8MN display"
- Add patch, split from "video: Update mxsfb video drivers for
  iMX8MM/iMX8MN display"
- Move the coding style fix and the DE polarity change to separate
  patches
- Bind the DSI host to the DSIM node and drop the
  "samsung,sec-mipi-dsi" compatible
- Fix typo in a comment
- Drop the dsi-host node
- Add commit message
- Drop the custom boot-on properties added to the Linux device tree
- Drop the #if guard around smm_s2_setup_simplefb()
- Fix the style of a comment

Dario Binacchi (9):
  clk: ccf: enable the critical clocks when they are registered
  clk: clk-uclass: fix parent reference counting in clk_set_parent()
  video: mxsfb: add missing space after if
  boot: fdt_simplefb: add a debug message
  video: mxsfb: support simple frame-buffer
  video: bridge: samsung: support simple frame-buffer
  imx8mn_bsh_smm_s2/pro: support simple frame-buffer
  imx8mn_bsh_smm_s2/pro: enable simple frame-buffer
  imx8mn_bsh_smm_s2/pro: add splash screen with BSH logo

Michael Trimarchi (16):
  clk: imx8mn: register the main_axi, noc and gic clocks as critical
  clk: implement CLK_OPS_PARENT_ENABLE and CLK_SET_RATE_UNGATE
  clk: imx8mn: add video clocks support
  power: domain: add i.MX8MM/i.MX8MN display block control driver
  video: Add video link framework
  video: bridge: Add check_timing interface
  video: dsi_host: add disable host interface
  video: mxsfb: set the DE polarity from the display timings
  video: Update mxsfb video drivers for iMX8MM/iMX8MN display
  video: Enable DM_UC_FLAG_SEQ_ALIAS for display and bridge
  phy: dphy: add support to calculate the timing based on hs_clk_rate
  phy: dphy: Correct lpx parameter and its derivatives(ta_{get,go,sure})
  phy: dphy: Correct clk_pre parameter
  video: bridge: Add Samsung DSIM bridge
  video: Add Synaptics R63353 panel driver
  imx8mn_bsh_smm_s2/pro: Enable display on reference design

 .../dts/imx8mn-bsh-smm-s2-u-boot-common.dtsi  |   16 +
 board/bsh/imx8mn_smm_s2/imx8mn_smm_s2.c       |   72 +
 boot/fdt_simplefb.c                           |    2 +
 common/stdio.c                                |    4 +
 configs/imx8mn_bsh_smm_s2_defconfig           |   21 +
 configs/imx8mn_bsh_smm_s2pro_defconfig        |   21 +
 drivers/clk/clk-uclass.c                      |   70 +-
 drivers/clk/clk.c                             |   15 +
 drivers/clk/imx/clk-imx8mn.c                  |  105 ++
 drivers/phy/meson-axg-mipi-dphy.c             |    2 +-
 drivers/phy/phy-core-mipi-dphy.c              |   36 +-
 drivers/power/domain/Kconfig                  |    7 +
 drivers/power/domain/Makefile                 |    1 +
 drivers/power/domain/imx8m-blk-ctrl.c         |  355 ++++
 drivers/power/domain/imx8m-power-domain.c     |  166 +-
 drivers/video/Kconfig                         |   14 +
 drivers/video/Makefile                        |    2 +
 drivers/video/bridge/Kconfig                  |   13 +
 drivers/video/bridge/Makefile                 |    1 +
 drivers/video/bridge/samsung-dsi-host.c       | 1570 +++++++++++++++++
 drivers/video/bridge/samsung-dsim.c           |  165 ++
 drivers/video/bridge/samsung-dsim.h           |   20 +
 drivers/video/bridge/video-bridge-uclass.c    |   11 +
 drivers/video/display-uclass.c                |    1 +
 drivers/video/dsi-host-uclass.c               |   10 +
 drivers/video/mxsfb.c                         |  142 +-
 drivers/video/synaptics-r63353.c              |  228 +++
 drivers/video/video_link.c                    |  448 +++++
 include/configs/imx8mn_bsh_smm_s2.h           |    1 +
 include/configs/imx8mn_bsh_smm_s2_common.h    |    4 +
 include/configs/imx8mn_bsh_smm_s2pro.h        |    1 +
 include/dsi_host.h                            |    8 +
 include/linux/clk-provider.h                  |   12 +-
 include/phy-mipi-dphy.h                       |    3 +
 include/video_bridge.h                        |   20 +
 include/video_link.h                          |   19 +
 tools/logos/bsh.bmp                           |  Bin 0 -> 10644 bytes
 37 files changed, 3521 insertions(+), 65 deletions(-)
 create mode 100644 drivers/power/domain/imx8m-blk-ctrl.c
 create mode 100644 drivers/video/bridge/samsung-dsi-host.c
 create mode 100644 drivers/video/bridge/samsung-dsim.c
 create mode 100644 drivers/video/bridge/samsung-dsim.h
 create mode 100644 drivers/video/synaptics-r63353.c
 create mode 100644 drivers/video/video_link.c
 create mode 100644 include/video_link.h
 create mode 100644 tools/logos/bsh.bmp

---
base-commit: c1958b5f6cce03956d309ce422b5d9f819955d4a
branch: bsh-smm-s2-display

-- 
2.43.0

