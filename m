Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF47C02193
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 21:39:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26652801BE;
	Tue,  4 Feb 2025 22:39:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="VX41eDJ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1395B80562; Tue,  4 Feb 2025 22:39:06 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71CE9800B3
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 22:39:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9c73=U4=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1738705140;
 bh=3k+BfwpWWFIYSNEuQ415QnOf7Y91yn6cW6bP0x5tMeY=;
 b=VX41eDJ7GpfsgHg8Ah1brX7oxJlXPrcPL3gedltTwIP2/3Dth3e1w3FRT9VbMfXjxZwoYvuor
 m3tzJjQHz0aXnSCE5JDXM5rIrtDLuc7kQF0Rm0CKGKlpBk9JVE2++nVPWW3XUbnah8x80+NZFah
 Fb8D6omWoGOD0x2gXifHdflhyaQ3/1s+WonzsxfKLG3ymkzN8WpvYQo4YjEZZUaMDkOQaDxiNfC
 BzQgkoI5QUWV1FB0dbo8xgeTCrcldsRhN8NaCxVEmUz+QSNrl7viP7iOMWumdUJZSzPZC6wg6I7
 8txwzF41sVaRBZ0lnA5S6UTFndkYEhog/EqAx9uGXgLQ==
X-Forward-Email-ID: 67a288ee19fd69f834661b63
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
Subject: [PATCH v3 0/2] rockchip: rk3308-rock-s0: Fix SD-card boot on v1.1 hw
 revision
Date: Tue,  4 Feb 2025 21:38:42 +0000
Message-ID: <20250204213848.885712-1-jonas@kwiboo.se>
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

Radxa ROCK S0 HW revision prior to v1.2 must pull GPIO4_D6 low to boot
from sdmmc.

This series pick a device tree fix that has landed in Linux v6.14-rc1,
include required nodes in SPL and enable required Kconfig options to
fix the sdmmc boot issue on HW revision v1.1 boards.

Changes in v3:
- Pick device tree changes from devicetree-rebasing v6.14-rc1-dts
- Drop sdmmc_2030 and vcc_sd nodes from board u-boot.dtsi

Changes in v2:
- Rebased to fix clean apply on master
- Collect r-b tags

Jonas Karlman (2):
  arm64: dts: rockchip: Fix sdmmc access on rk3308-rock-s0 v1.1 boards
  rockchip: rk3308-rock-s0: Fix SD-card boot on v1.1 hw revision

 arch/arm/dts/rk3308-rock-s0-u-boot.dtsi       | 12 +++++++++
 configs/rock-s0-rk3308_defconfig              |  2 ++
 .../src/arm64/rockchip/rk3308-rock-s0.dts     | 25 ++++++++++++++++++-
 3 files changed, 38 insertions(+), 1 deletion(-)

-- 
2.48.1

