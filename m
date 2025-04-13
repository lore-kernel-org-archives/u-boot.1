Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BE5C3601E
	for <u-boot@archiver.kernel.org>; Sun, 13 Apr 2025 20:00:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4B5782163;
	Sun, 13 Apr 2025 22:00:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="BH8Sgr+R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF2FF82A96; Sun, 13 Apr 2025 22:00:04 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C39F38215F
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 22:00:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b5c5=XA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1744574400;
 bh=VWLWC4vEAqCdugcZ2UxUAb7AK3g7ifTRQg3fhjMUfes=;
 b=BH8Sgr+ROUUFipzy8eS3VgqNqMuTdSaXg4+cxGKY7JNnkfIHkUT4QxtARWG+nfmhvXakdeKTw
 lDdhf3nLDGBwSr7ZAqlTJjmfVWTXG3PYDHSbVoEkm5ojCStUZazZpW2j+1fmMv/kvtEyRNYty7o
 XiWngrYvjrslJ1vIzAuNlWPfvWbfW2Kck1Jbl5xsd+TvRKxuPuFsAzeBHbpg7blc4pyduAeZ5Ur
 DfUc138Sks8hLPvnENSnHDQLWOgdaa7PjKY/tk8wemZqNkaOiTyKtwJ9YDEpkXOfdXXz3jZbqWE
 w8nrgVP+FMFK5B1xvysumnhDBKe1cdZVCnNhTssJVq9g==
X-Forward-Email-ID: 67fc17ba6900761fb151627c
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
Subject: [PATCH v6 0/7] rockchip: binman: Use a template for FIT and other
 improvements
Date: Sun, 13 Apr 2025 19:59:32 +0000
Message-ID: <20250413195949.432730-1-jonas@kwiboo.se>
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

Changes in v6:
- Drop use of HAS_FIT_HASH
- Collect r-b tags

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
[5] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/binman-v6

Jonas Karlman (2):
  rockchip: Add SPL_PAD_TO Kconfig default value
  rockchip: binman: Support use of crc32 hash for FIT images

Simon Glass (5):
  rockchip: binman: Correct the OS prop for U-Boot
  rockchip: binman: Factor out arch and compression
  rockchip: binman: Create a template for the FIT
  rockchip: binman: Un-indent the FIT template
  rockchip: binman: Include a compatible string in each configuration

 arch/arm/dts/rockchip-u-boot.dtsi | 291 ++++++++++++++++--------------
 common/spl/Kconfig                |   1 +
 2 files changed, 157 insertions(+), 135 deletions(-)

-- 
2.49.0

