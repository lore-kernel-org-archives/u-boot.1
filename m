Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D02C0218F
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 07:27:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 670F8800CF;
	Tue,  4 Feb 2025 08:27:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="anwcoyXT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18989801FD; Tue,  4 Feb 2025 08:27:30 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E603800C1
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 08:27:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8daa=U3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1738654045;
 bh=h85v5lU/A/EFTdLAJHV8sJuA9qDAEpgeWfprR1nN/1A=;
 b=anwcoyXTr3jxSjMkk5qdjQD0iIW5s9OKfUvZ3egFe4Z9H6PjWbVSF3hIoieTjf3ybdTD2TkO2
 +7rSrXOIDHgUOA67sWNV7Ta/FjBXG1m82CdS7yMA9LYNMtjQRPDCd1ZULH/XWzkoTgfcqLouDc7
 TKwxw5Ei6YhsFfHJBqmJZGtNVYUe53c00oY6t87OLYSOFXDTxP6zUe0O/fKFT4noGtbYpufliji
 b6WKauR7wyxbx5NuOXYpCeQbvSeZW2dJCJsMTtVg01HkW13FnsGtTYXd4ucC+vzwm8Hc1GZ9tb+
 q/S4c8NPGTskeWu0Vv5hYFln90cmg301SjBq5xfCYEIw==
X-Forward-Email-ID: 67a1c157745e96f5a388c5d5
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/2] rockchip: Add minimal generic RK3328 and RK3399 boards
Date: Tue,  4 Feb 2025 07:27:03 +0000
Message-ID: <20250204072710.468610-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
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

This series adds minimal generic board targets for RK3328 and RK3399,
like existing minimal generic boards for RK3566/RK3568, RK3588S/RK3588,
pending RK3528 [1] and upcoming RK3576 targets.

These generic boards can be used to boot into U-Boot and/or Linux on
most boards that follow reference board design with the use of Rockchip
TPL blobs. E.g. to use USB OTG with rockusb or ums to access eMMC,
SD-card or SPI flash storage.

I have tested several of the different RK3328 and RK3399 boards I have,
and boards can boot into U-Boot regardless of DRAM type with latest ddr
init blobs.

This series depends on the series "rockchip: ROCKCHIP_COMMON_STACK_ADDR
improvements" [2] for a clean apply.

[1] https://patchwork.ozlabs.org/patch/2038159/
[2] https://patchwork.ozlabs.org/cover/2039040/

Jonas Karlman (2):
  board: rockchip: Add minimal generic RK3328 board
  board: rockchip: Add minimal generic RK3399 board

 arch/arm/dts/rk3328-generic-u-boot.dtsi | 39 +++++++++++
 arch/arm/dts/rk3328-generic.dts         | 76 +++++++++++++++++++++
 arch/arm/dts/rk3399-generic-u-boot.dtsi | 10 +++
 arch/arm/dts/rk3399-generic.dts         | 83 +++++++++++++++++++++++
 arch/arm/mach-rockchip/Kconfig          |  2 +-
 board/rockchip/evb_rk3328/MAINTAINERS   |  6 ++
 board/rockchip/evb_rk3399/MAINTAINERS   |  6 ++
 configs/generic-rk3328_defconfig        | 90 +++++++++++++++++++++++++
 configs/generic-rk3399_defconfig        | 76 +++++++++++++++++++++
 doc/board/rockchip/rockchip.rst         |  2 +
 10 files changed, 389 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/rk3328-generic-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3328-generic.dts
 create mode 100644 arch/arm/dts/rk3399-generic-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3399-generic.dts
 create mode 100644 configs/generic-rk3328_defconfig
 create mode 100644 configs/generic-rk3399_defconfig

-- 
2.48.1

