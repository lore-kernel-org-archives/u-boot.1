Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE34FCDB483
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 17:02:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B2E086F45;
	Tue, 17 Oct 2023 19:02:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="XFPzDrYz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BD9786F48; Tue, 17 Oct 2023 19:02:49 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88C0686EE7
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 19:02:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=165c=GA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1697562143;
 bh=bKHDELQKEwdPFtDvycp1PUmFtEINxgcE0xkf8aAFmAs=;
 b=XFPzDrYzPPi8fhAJEnTpLVF74AwgE6mNleyk28LmPiYtCvzGwKzIGSQFynhveW8yCBp+nfIG0
 oaIrni7xrB3riNMsdEPmcARFF8SxKZ+efECV7Hgos6dpQ49SibA2m3PblgR4IvI+C0BkiQVRZpv
 niBhuXQwUSR5fFjwYrtkpT/JFlLyGqqcHTxr2MJgh8U6tqWAdWTv0BPIk83bvaSyvAUBXOpDoiQ
 QgIJSKemooPhBuHQiEZGw7hfzWZcgTygG/Q6QOS8MpgvVQWM3gtq+nYeTNI2CWTEuK5sceY9X8g
 7UqMnQ/nNYlRvj86NZNrBHYha+Xagok7/1T+wLxei1iw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Eugen Hristev
 <eugen.hristev@collabora.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/4] rockchip: rk3588: Sync pcie and usb3 nodes from linux
Date: Tue, 17 Oct 2023 17:02:07 +0000
Message-ID: <20231017170216.1627789-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 652ebe1d7b04e7479c18eaa4
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

This series sync rk3588 device tree nodes from latest mainline linux
maintainer tree and also update usb3 nodes with latest submitted patches.

Patch 1 sync latest device tree from latest linux maintainer tree to
move pcie and spi flash nodes away from -u-boot.dtsi files.

Patch 2 enable usb 2.0 support on rk3588-rock-5a.

Patch 3 fully enable pcie and ahci/sata support on rk3588-rock-5b.

Patch 4 sync usb3 nodes with latest pending patches in order to drop
use of rockchip,rk3399-dwc3 compatible.

Changes in v2:
- Sync device tree from linux v6.7-rockchip-dts64-1 tag
- Add patch to enable usb 2.0 support on rk3588-rock-5a
- Use rockchip,rk3568-dwc3 compatible so that dwc3-generic driver change
  can be submitted in a separate series
- Collect r-b tags

Jonas Karlman (4):
  rockchip: rk3588: Sync device tree from v6.7-rockchip-dts64-1 tag
  rockchip: rk3588-rock-5a: Enable support for USB 2.0 ports
  rockchip: rk3588-rock-5b: Enable support for PCIe SATA cards
  rockchip: rk3588-rock-5b: Sync USB3 nodes from mainline linux patches

 arch/arm/dts/rk3588-evb1-v10-u-boot.dtsi |  11 +-
 arch/arm/dts/rk3588-evb1-v10.dts         | 136 +++++++++++++++
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi  | 204 +++++------------------
 arch/arm/dts/rk3588-rock-5b.dts          | 145 ++++++++++++++++
 arch/arm/dts/rk3588-u-boot.dtsi          |  40 ++---
 arch/arm/dts/rk3588s-pinctrl.dtsi        |  44 +++++
 arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi |   4 -
 arch/arm/dts/rk3588s-u-boot.dtsi         |  78 +++++----
 arch/arm/dts/rk3588s.dtsi                |  24 +++
 configs/rock5a-rk3588s_defconfig         |  16 +-
 configs/rock5b-rk3588_defconfig          |   7 +-
 11 files changed, 467 insertions(+), 242 deletions(-)

-- 
2.42.0

