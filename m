Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB49606A339
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jFXb9ib/;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MKqO3xO2
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44B22816DA;
	Fri, 20 Nov 2026 13:21:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tJiBv9jiLWvA; Fri, 20 Nov 2026 13:21:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5C49B81703
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795180890;
	b=FNyal8od38ZPc+pWZ3HRbhcds25NT8pfEqaos4LG8yGVNQy01NYaG3NWewY2gRHWlCqZ
	 o4Fikz/eggNUcJ8TMNypsVIduqYbf5NkUuK/w3HhI5RoiEfWaaikuK/M+dDEvEBGTx9JL
	 ov0DZHlvTFqi+SHxRZmp1zXlRtjzTYktDv+ExiEObttJrbNPrYcoME7IZhZbeP9KGmFRK
	 BS13dJfdHQ0zKPuKnWID3BDVQAXuefJQ02xdhKic9rBGVO+rC9aLeYZO6Y41EcLHAAwe+
	 s7/CfG43QhzLlsMTeUPeUnHi6mw8+oxdoTSLvpMbfBKl0QZwKd0nEgso3NWAtP6Gv1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795180890;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qDBOSvmG6qD+G++wFzJopKi4w+smDdU/STB5H3PulqU=;
	b=emVWsY7IUzVb17xTuFxHYH2zL22x/HfOHFz62WwjA+ArzGpAxGl2MbQaM1Sut8zQw63L
	 MJCM+keH2F62zxHnjDh9ccX3/Q+IErtgdvQ5RMWCouArbop7XfJX2zWyBjBeAHKgjsQYi
	 97Exy32AFbaFvUyHvj2Yap4hyjAzNRZM58aDfoGnOd1ovHJCXOj98l9K0PZJ2b32+zbCO
	 /8hBxf80okIx23JpX3wUwJg3PU7FwQBLTdjfxgXJMbb4h3jjbMjeEQkItPiMa06SEXV3h
	 /eMbbuvveyZvI9kAdJUBx3XyuuoMACK5Y4b9fYHQKrqB9UHu7Y9wC/Rblitu0zdHukw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795180890;
	bh=qDBOSvmG6qD+G++wFzJopKi4w+smDdU/STB5H3PulqU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jFXb9ib/elpkpOWGTNRDJXlwSMY68tJytshASoJeS81wNXwMtD5dh1Jb1FNMXZ5FG
	 N5BhHkA89RmnbQPrI9UVen7xB+jn+tcYG8fmj+8ZHSaheNDbcLtJ7dsXfTtsOBDAxr
	 eX0ChTYzcGRKX6wYrWXeDX/hb0ggeZaX6SpSaCjhMktOKwXIhigsnUJNMazMIu+lDX
	 P/6MLKs1bniuE6pwsqsXmyIyHmeLLTyy9e1z+sfCnN8yXdlrM7ckbJD0KudpANs6k1
	 li7fFc4Y3wOLBOPEXOgmbJ+NgmyKg6e4Y+rDDg4YTGfbC5HmN1QadPhpapRSyNDpAX
	 dIC2D3INkyRbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C49B81703;
	Fri, 20 Nov 2026 13:21:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 34F2F70B
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 11:10:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 24FF840A25
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 11:10:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ts3lxcrypta8 for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 11:10:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org F2C8F4016D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=MKqO3xO2
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F2C8F4016D
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 11:10:40 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4bb666304fdso17423625e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 03:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795173038; x=1795777838;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qDBOSvmG6qD+G++wFzJopKi4w+smDdU/STB5H3PulqU=;
 b=MKqO3xO2ZP6g+pwnMQjV3cq2PDUNZDbvNFlz7vV/G2jLX1vW/0icA9Pdr7+HK/X1g9
 Uynuj2D8UXredRaLWXzw1Q2ldjyesH7dOHYdp6uBzkROVk/5mG/XUMjnEsp81Favoxpv
 ueGQNPDYlUtdNHmdSI+1QmT7jB/d0rfk7JbkANiLsPOOvJHixLzCXJliRLeX18aPysEP
 /i+xwaMUR9YFaqdkb/lNAMbR9ZcWGdTn+SeyOopGMMs1xkjvj9hkV1EAe0ktVrYUdsqL
 RHjbr/aI254bzV+Doql2Goe7LRE/8Zo6ZmsvMMDtZ1X7A6AHPRbOegPoXUX1kK3zUGB1
 pqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795173038; x=1795777838;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qDBOSvmG6qD+G++wFzJopKi4w+smDdU/STB5H3PulqU=;
 b=D2opM8VKgFNN+mZ5xyXFmXVzkw2fz2Z3nCbdke3ZEoTGmyW5AWiJFZ2GrRCygxAROT
 Nk/VPBl6xbmCqyD54JPIx+Bx7uSJCQGsE97z8aqSxR3DnSvpvKWnZG140GL8I9FR5GY7
 1n4jFFekKQUvwLY3jrBQOlnOtqa+8d0+ikK2blwA6kBLq4HwtjwJRO/5cG516ErNq0tp
 mHWgDRdouEeqItgeNTqY+1mBJ3xDTChYiRP7UwalI6CNLFJ9+EkRuO5YRk+c34Js+mPK
 f0UVqC9OavyH5ZqoeU20skvlJYmgw3WfaxD9tqz6HjGzRPPZ1FmYzwKyU9RIxls98RT2
 UgtQ==
X-Gm-Message-State: APuU4Z+G6pMIReNSrye7ku9c0ZldvnqGlqkFujiWQyyqVU1QufUpg05Z
 7R3g22n3ZmM1dNjk40nmGPhOYTSS3QuHbBDsMnJijL/oINUVJZRD5mb4
X-Gm-Gg: AYBFou0Y+jGoTNtpJBKdiZiYbnKND7XKY6dyIVX3ZHOgGSj2BUGlKu5Y2HgMEhf5Vah
 d2ErWkAQYPzsi37rL0VfAeiy2pPyy6dimKXZ4xTMITU05/BIXwwcgx+IPF5cn9br9V5kt/OPF/O
 6S6z4ULg/X3nTyA/iTN1rRiIJM5wvRuJOF3GhpHdZfkHhy1jBpU9UmH3t6InDkQ/D8hUPCGQCB1
 PnEZuPJP3VmrOUw+tYQb0Qy/6o/deJTnltWPTEaosO8q4GEwEaGiS7Q6lAWkfTPSKz42Zevzc1+
 dxuGo50i/vqDueS88FI0IPsk2hu/GzXqG1rjQNFFkJoGpcahfs276cJNlkS69K5z5lAEtTuYx/A
 0x45UlyGniKUCHs0V8ODCZfl+UQUmLJnk71zwPSxxdnfVBF/9oESOtsRlvM5kAPCRRsGjwoVrps
 N5F/9wOI4/Nqs5FCH+a8ianWKDxNKPDyOK1hPIZiK9Fw/VRuIaWsf6l4OgxNmddAd22njeNu2bN
 rR6pyd0N4TDbCXI6oZ/3nZkwzfkj809k0pARtI4DPQR64m6uDlzY3qyuqnGjr40vvv1MTgof3hi
 8vHOxmk8ZexDAEwa3dchs8k=
X-Received: by 2002:a05:600d:600b:b0:4a2:18c4:61a5 with SMTP id
 5b1f17b1804b1-4bb887fb6e7mr59259275e9.6.1795173038431; 
 Fri, 20 Nov 2026 03:10:38 -0800 (PST)
Received: from eichest-laptop.toradex.int ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884865a2sm79108005e9.3.2026.11.20.03.10.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 03:10:37 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com, sbabic@nabladev.com,
 festevam@gmail.com, uboot-imx@nxp.com, francesco.dolcini@toradex.com,
 lukma@nabladev.com, dlechner@baylibre.com, msp@baylibre.com,
 stefan.eichenberger@toradex.com, Max.Merchel@ew.tq-group.com,
 nora.schiffer@ew.tq-group.com, primoz.fiser@norik.com, jbx6244@gmail.com,
 aford173@gmail.com, cniedermaier@dh-electronics.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 0/7] colibri-imx6ull: fix the Ethernet PHY detection
Date: Fri, 20 Nov 2026 12:10:06 +0100
Message-ID: <20261120111037.110741-1-eichest@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Nov 2026 13:21:18 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since commit a5d990854f2c ("regulator: fixed: fix regulator-fixed-clock")
the regulator-fixed-clock driver gets its clock in a probe hook, so it
can no longer probe without CONFIG_CLK. On the Colibri iMX6ULL the
Ethernet PHY supply is such a regulator. Its 150ms startup delay is
skipped, and the first FEC probe does not find the PHY.

This series fixes the problem by moving the board to the clock framework
(CONFIG_CLK_IMX6UL). The i.MX6UL clock driver could not yet drive the
FEC, so most of the series makes the ENET clocks usable:

- Patch 1 fixes the ENET gate, which pointed at the uart3 gate. It is a
  standalone fix and can be applied on its own.
- Patches 2 and 3 fix the PLLv3 ENET PLL: wait for lock after power up,
  and stop setting and clearing bit 13. That bit is an output gate, which
  the SoC drivers already model as a separate clock. Patch 3 also affects
  i.MX6Q/DL, where every PLL6 consumer goes through the pll6_enet gate
  on that bit.
- Patch 4 adds the ENET clock tree to the i.MX6UL driver: the PLL6
  bypass, the reference dividers with their 125M gates, the GPR1
  reference clock selectors, the PTP clock and the AHB gate.

The rest prepares and switches the board:

- Patch 5 removes the static serial_mxc device. It duplicates the
  device tree instance and cannot get its clocks once CCF is enabled.
- Patch 6 moves the Colibri iMX6ULL device trees to OF_UPSTREAM.
- Patch 7 enables the clock framework. With it, the hand-rolled FEC clock
  setup is no longer needed. setup_gpmi_nand() has to go as well, because
  it now overwrites the ENFC parent chosen by the CCM driver and breaks
  NAND. SYS_MALLOC_F_LEN is raised for the pre-relocation CCM probe.

A note on patch 4: U-Boot has no clock type for the IOMUXC GPR muxes, so
the ENETn_CLK_SEL selectors are plain muxes on the GPR1 register, and the
ENET2_TX_CLK direction bit stays in board code. A follow-up could add a
syscon-based GPR mux clock like the one in Linux. That would also remove
the remaining board code.

On the Colibri iMX6ULL, Ethernet now finds the PHY on the first probe.

The series was tested on the following modules:
- Colibri iMX6ULL
- Colibri iMX6ULL eMMC
- Colibri iMX6
- Apalis iMX6

Francesco Dolcini (4):
  clk: imx: imx6ul: fix the enet clock gate register
  board: toradex: colibri-imx6ull: drop the static serial device
  arm: dts: imx6ull-colibri: migrate to OF_UPSTREAM
  board: toradex: colibri-imx6ull: enable the clock framework

Stefan Eichenberger (3):
  clk: imx: pllv3: wait for the ENET PLL to lock
  clk: imx: pllv3: do not touch the ENET output gate
  clk: imx: imx6ul: add the enet clock tree

 arch/arm/dts/Makefile                         |   2 -
 arch/arm/dts/imx6ull-colibri-emmc-eval-v3.dts |  17 -
 .../arm/dts/imx6ull-colibri-emmc-nonwifi.dtsi | 187 -----
 .../dts/imx6ull-colibri-eval-v3-u-boot.dtsi   |   6 +
 arch/arm/dts/imx6ull-colibri-eval-v3.dts      |  14 -
 arch/arm/dts/imx6ull-colibri-eval-v3.dtsi     | 121 ---
 arch/arm/dts/imx6ull-colibri-nonwifi.dtsi     | 161 ----
 arch/arm/dts/imx6ull-colibri.dtsi             | 748 ------------------
 arch/arm/mach-imx/mx6/Kconfig                 |   1 +
 board/toradex/colibri-imx6ull/MAINTAINERS     |   8 +-
 .../toradex/colibri-imx6ull/colibri-imx6ull.c |  45 +-
 configs/colibri-imx6ull-emmc_defconfig        |   4 +-
 configs/colibri-imx6ull_defconfig             |   4 +-
 drivers/clk/imx/clk-imx6ul.c                  |  81 +-
 drivers/clk/imx/clk-pllv3.c                   |  21 +-
 15 files changed, 116 insertions(+), 1304 deletions(-)
 delete mode 100644 arch/arm/dts/imx6ull-colibri-emmc-eval-v3.dts
 delete mode 100644 arch/arm/dts/imx6ull-colibri-emmc-nonwifi.dtsi
 delete mode 100644 arch/arm/dts/imx6ull-colibri-eval-v3.dts
 delete mode 100644 arch/arm/dts/imx6ull-colibri-eval-v3.dtsi
 delete mode 100644 arch/arm/dts/imx6ull-colibri-nonwifi.dtsi
 delete mode 100644 arch/arm/dts/imx6ull-colibri.dtsi

-- 
2.56.1

