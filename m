Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B102E6F092
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 22:21:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F83D88E78;
	Fri,  1 Nov 2024 23:21:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="jkdhTUlh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB5DF88FBB; Fri,  1 Nov 2024 23:21:54 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5234988C05
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 23:21:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=178a=R5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1730499704;
 bh=+GiP5vUUTp1OGJpE5iWlHcwXU94NofBONV59OOlDN1s=;
 b=jkdhTUlhhtneXY6uXiFT7CL3n4asqfHWjrkpG9bzEg2zKVCDHL8bCafY46g+k2RKpg7Ju23ou
 SHd/xW1r0xpGBUukuq9J3Nkdb2jMUCQEJIabqPxl8ShKeJiKnfw3nbhqZTh0WKnH9HQs2A63Nk+
 fd1eZjlJ8Z8jMv7w0FyC0Sja3ykDyIi976C3GxA6Ymg+pm1wjjXENwwXsyHf/NPVN7SiWlj4lei
 68SGqCjIKOZ2m+69NzxJETx6kWj7EI/IAVz063rZo+V+ET/8CU+YBPOxP90cvVzQq5u0O8MPwjr
 jcUTLsfmPU+e4ILoxeZCJrHMd3n7LnKtUsffhCQCTWmw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Sergey Bostandzhyan <jin@mediatomb.cc>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/2] board: rockchip: Add FriendlyElec NanoPi R2S Plus
Date: Fri,  1 Nov 2024 22:21:28 +0000
Message-ID: <20241101222135.3220074-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 67255474354c15e0314d0eeb
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

This series add support for the RK3328 based FriendlyElec NanoPi R2S Plus.

Features tested on a NanoPi R2S Plus 2309:
- SD-card boot
- eMMC boot
- Ethernet
- USB gadget
- USB host

Jonas Karlman (1):
  board: rockchip: Add FriendlyElec NanoPi R2S Plus

Sergey Bostandzhyan (1):
  arm64: dts: rockchip: Add DTS for FriendlyARM NanoPi R2S Plus

 .../dts/rk3328-nanopi-r2s-plus-u-boot.dtsi    |   3 +
 board/rockchip/evb_rk3328/MAINTAINERS         |   6 +
 configs/nanopi-r2s-plus-rk3328_defconfig      | 108 ++++++++++++++++++
 doc/board/rockchip/rockchip.rst               |   1 +
 .../arm64/rockchip/rk3328-nanopi-r2s-plus.dts |  32 ++++++
 5 files changed, 150 insertions(+)
 create mode 100644 arch/arm/dts/rk3328-nanopi-r2s-plus-u-boot.dtsi
 create mode 100644 configs/nanopi-r2s-plus-rk3328_defconfig
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3328-nanopi-r2s-plus.dts

-- 
2.46.2

