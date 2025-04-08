Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 752E4C369A1
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 22:12:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B823D82E31;
	Wed,  9 Apr 2025 00:12:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="BbJCWO77";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C8FE801BE; Wed,  9 Apr 2025 00:12:09 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A12F82E31
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 00:12:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=6bf1=W3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1744150322;
 bh=k6kpVSHtmUh1YISVkY9JiubM87vDQx1PGPUCekhf/kA=;
 b=BbJCWO7732hNAEljSonvbRjCYoFWQ2Y8NO/fGfFYBwJnyZ7XCGAalPnirhyAK+IZ3W6nvH2aU
 2C7zzVqxSmvNc0m6xWxDXlIKp/J2ZJj1JB4AoO6SC0n+eokTpm1Szo02f3opXSRq/HVdTfXoO3O
 VoSmjcoL+iD1tgbtSH1Bzxf3Ph+FhFztm8anGVF/4DeZFYIEMpjeDJG7vB100HM1NeIyQYiGXdu
 2tUAqh0SKhkRGSeuMd9UFvD9jnVyXbZzsurfaijR+Xzzp0XubsXuwcilm5+SSb1Q+EHLAVSfvjT
 Gd7+FI1DaJxhP/xRZskPfWzO6wdGi7mHSDnSuXaRL1Fg==
X-Forward-Email-ID: 67f59f2c9e1b52744186ac6d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/4] rockchip: Update rng compatible for RK356x and RK3588
Date: Tue,  8 Apr 2025 22:11:41 +0000
Message-ID: <20250408221151.2762853-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
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

This series adds support for and updates the random generator compatible
used for RK356x and RK3588.

The RK356x rng node is already part of dts/upstream so the rng node in
u-boot.dtsi is removed, and because it is not enabled for rk3566 it gets
enabled in u-boot.dtsi to restore its use in U-Boot.

The RK3588 rng node is added into dts/upstream DT by picking a commit
from devicetree-rebasing v6.15-rc1-dts and the rng node in u-boot.dtsi
is removed.

Changes in v2:
- Split rng driver and DT change into separate patches for RK356x
- Pick RK3588 rng node commit from devicetree-rebasing v6.15-rc1-dts

Jonas Karlman (3):
  rng: rockchip_rng: Add compatible for RK3568
  rockchip: rk356x: Remove rng node from u-boot.dtsi
  rng: rockchip_rng: Update compatible for RK3588

Nicolas Frattaroli (1):
  arm64: dts: rockchip: Add rng node to RK3588

 arch/arm/dts/rk356x-u-boot.dtsi                  | 9 ++++-----
 arch/arm/dts/rk3588s-u-boot.dtsi                 | 5 -----
 drivers/rng/rockchip_rng.c                       | 6 +++++-
 dts/upstream/src/arm64/rockchip/rk3588-base.dtsi | 8 ++++++++
 4 files changed, 17 insertions(+), 11 deletions(-)

-- 
2.49.0

