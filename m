Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD32C021B8
	for <u-boot@archiver.kernel.org>; Sat,  1 Mar 2025 13:47:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F270810F4;
	Sat,  1 Mar 2025 14:47:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="NFPTE+x3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A7EC810F6; Sat,  1 Mar 2025 14:47:48 +0100 (CET)
Received: from mail-m15581.qiye.163.com (mail-m15581.qiye.163.com
 [101.71.155.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 601FD810ED
 for <u-boot@lists.denx.de>; Sat,  1 Mar 2025 14:47:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from localhost.localdomain (unknown [121.204.19.252])
 by smtp.qiye.163.com (Hmail) with ESMTP id c98fa867;
 Sat, 1 Mar 2025 21:47:39 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: Pull request: u-boot-rockchip-20250301
Date: Sat,  1 Mar 2025 21:47:38 +0800
Message-Id: <20250301134738.2429349-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTk5OVkNMSx9NQh1DTRoaS1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUlOSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0
 tVSkJLS1kG
X-HM-Tid: 0a9551f66d9203afkunmc98fa867
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MzI6Qzo4HDIUEVYYNjA*Mh80
 DCgKCShVSlVKTE9LQ0hNQ05CQ0JCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKSUpVSUtPVUpCVUlOSVlXWQgBWUFKTUlCNwY+
DKIM-Signature: a=rsa-sha256;
 b=NFPTE+x34/vxKCVp6IaAsBSf87v1i2qFshl6SuB0aWW10PGYymgqYNZkHsAsqfQKbT9QO6bHfpeTYlb5rMxbS2IHOWrW+36+dEOBx40/4l/KDJjyQ/WOYpmKAyxxmMEft25NoAu16L7/7u237mMF0hTvU0D9rDBk7CaWBHkG0mk=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=7M8A4XfgOZPdRqwr+3AAKJHz4CR0a5/3Af37Wc4mbWk=;
 h=date:mime-version:subject:message-id:from;
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

Hi Tom,

Please pull the fixes for rockchip platform:
- Fix SD-Card boot on rk3308-rock-s0 v1.1;
- Fix crash on nanopi-r4s seconde usb port;
- Disable undeeded PCI config for nanopi-r3s-rk3566
- Correct usage of IS_ENABLED()

CI:
https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/24898

Thanks,
- Kever

The following changes since commit b78f8677cde8b1dde31b66f5b780f2e9b62fba7f:

  arch: arm: dts: k3-am642-phycore-som-binman: Add custMpk to overlays (2025-02-27 08:07:38 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-20250301

for you to fetch changes up to a390c485756cf2b352ee781a94e47dafc7b9b2c8:

  rockchip: nanopi-r3s-rk3566: disable unneeded CONFIG_NVME_PCI (2025-02-28 19:21:17 +0800)

----------------------------------------------------------------
Jonas Karlman (1):
      rockchip: rk3308-rock-s0: Fix SD-card boot on v1.1 hw revision

Justin Klaassen (1):
      rockchip: nanopi-r4s: Enable second usb port and fix crash

Tianling Shen (1):
      rockchip: nanopi-r3s-rk3566: disable unneeded CONFIG_NVME_PCI

Tom Rini (1):
      clk: rockchip: Correct usage of IS_ENABLED() macro

 arch/arm/dts/rk3308-rock-s0-u-boot.dtsi    | 12 ++++++++++++
 arch/arm/dts/rk3399-nanopi-r4s-u-boot.dtsi |  5 +++++
 configs/nanopi-r3s-rk3566_defconfig        |  1 -
 configs/rock-s0-rk3308_defconfig           |  2 ++
 drivers/clk/rockchip/clk_rk3568.c          |  4 ++--
 drivers/clk/rockchip/clk_rk3588.c          |  4 ++--
 6 files changed, 23 insertions(+), 5 deletions(-)
