Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B367C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 21:45:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C946F83AAE;
	Thu, 10 Apr 2025 23:45:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="f58bciz+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02A1283AC6; Thu, 10 Apr 2025 23:45:25 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 263E483AAE
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 23:45:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=c990=W5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1744321520;
 bh=43xk1h00MB0n+VwPdBg8W8k8ZikFpC9n1WAGEDILQa0=;
 b=f58bciz+IwUBF8QTlPIPNrwKsFvjzPv2wXrZ551M3ZT0aPUQTP481iwU30Xl+1Aa1r6UFY4fk
 e0frHJ+imqT0pU7NDmZq57Y1jG36poTj5YfiXr2Q6BLjrSGI78lAoGbtE5Y+Llzg2ih/tw0R9Oa
 ttRjXUJpaWUShWrIEDFkoVPY67Sxi2ESUwrARLhGy3/lC663xqqMnH3kcTaimuWR58oZwmPN/o4
 XpUiZFeR1bdy5mt2eQIvJhoiH1AuFUrsyi4oZhj6lhb5gD3S5jh2ctW370BO4Y0ZgTSqD9zhTHl
 vog4Olj0U8U+eLN2s6QlSF3zTLBbe8aqyW/VcSeZk90w==
X-Forward-Email-ID: 67f83be90ebe9f861dbcc30a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki <naoki@radxa.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v5 0/7] rockchip: binman: Use a template for FIT and other
 improvements
Date: Thu, 10 Apr 2025 21:44:49 +0000
Message-ID: <20250410214506.3575404-1-jonas@kwiboo.se>
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

This series split out generic Rockchip binman image related commits from
Simons "VBE serial part H: Implement VBE on Rockchip RK3399" [1] series.

These are generic binman image patches fixing an existing issue [2][3]
and that other series [4] already depends on.

They are being split out to ease continued work for other U-Boot
developers as the main parts of the VBE series have not yet been tested
using the mainline U-Boot tree, so cannot yet be seen as ready.

Changes in v5:
- Rename ARCH to FIT_ARCH and COMP to FIT_UBOOT_COMP
- Merge change to use template in spi image with addition of template
- Reorder patches: fixes, none functional changes, functional changes
- Drop two patches related to skip-at-start and fdtmap
- Update commit messages
- Collect r-b tags

Changes in v4:
- Patch 1-7 matches corresponding patch in Simons series, possible with
  minor updates in commit messages.
- Patch 8 drops changes to defconfig-files.
- Patch 9 adds support for using crc32 as checksum algo.
- Patch 10 adds a default value for SPL_PAD_TO.

This series holds off on any defconfig changes to let it be handled by
next "configs: Resync with savedefconfig". Changing SPL_PAD_TO to be
storage media relative has also been held off and is something that can
be picked up in a series for a future release after this has landed in a
release.

See [5] for a copy of this series on top of patch 1-2 from [3]. This
series does not depend on those two patches, but are related for a full
cleanup of use of u-boot.itb in Rockchip binman images.

[1] https://lore.kernel.org/u-boot/20250328153522.3555472-1-sjg@chromium.org/
[2] https://lore.kernel.org/u-boot/20250129132529.807031-3-naoki@radxa.com/
[3] https://lore.kernel.org/u-boot/20250220-has_rom-u-boot-rockchip-spi-bin-v2-3-d1768ee87808@cherry.de/
[4] https://lore.kernel.org/u-boot/20250405153832.1427549-1-jonas@kwiboo.se/
[5] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/binman-v5

Jonas Karlman (2):
  rockchip: Add SPL_PAD_TO Kconfig default value
  rockchip: binman: Support use of crc32 hash for FIT images

Simon Glass (5):
  rockchip: binman: Correct the OS prop for U-Boot
  rockchip: binman: Factor out arch and compression
  rockchip: binman: Create a template for the FIT
  rockchip: binman: Un-indent the FIT template
  rockchip: binman: Include a compatible string in each configuration

 arch/arm/dts/rockchip-u-boot.dtsi | 293 ++++++++++++++++--------------
 common/spl/Kconfig                |   1 +
 2 files changed, 159 insertions(+), 135 deletions(-)

-- 
2.49.0

