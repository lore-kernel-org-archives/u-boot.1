Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87887E8782A
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 13:36:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13A1B841D7;
	Tue,  3 Feb 2026 14:35:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="NMM7L29E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B5C884101; Tue,  3 Feb 2026 14:08:48 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0E1383FFA
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 14:08:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 674E426F6D;
 Tue,  3 Feb 2026 14:08:45 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UW4Mbx3uMvUj; Tue,  3 Feb 2026 14:08:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1770124124; bh=vED/1/9tPiHLu5gRSqdalNtN5IRbL+a5WUcqi7aqx+c=;
 h=From:Subject:Date:To:Cc;
 b=NMM7L29EOuZcWR3iT9VvC9ltkLliEzfdupTDmdRegRhbprOq/kjBAc2NaoHsGt0kQ
 8hOaAdbIokyYZGYmD4i5qPL952Nj8J/A8LTofODMfUR01Ph81kAWRY2S0G9YVCwpFW
 Ii+CcK0+LxGI29Mh0S3DWBqyoZXeUFe2T/0g38UpOf1l0PweOSVuW1szhAMDj7vhTo
 2YH4mwVnX1kH368byf/dY371ZdwNylww73ho7iN10fg4K15uKHydgiE5u3vze7C2qc
 zSNrp55y3dl73HGIwk41MK1RaurfnQ/mkR3JzrDx6Y47kcN1ueyNzGfKQurIGKByx6
 817n50yN5pPfw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH 00/11] Various Exynos mobile board enhancements
Date: Tue, 03 Feb 2026 18:38:38 +0530
Message-Id: <20260203-exynos-mobile-external-dtb-v1-0-a16a0e57991c@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFbzgWkC/x3MQQqDMBAF0KvIrB1IoyalVxEX2vzWAU1KIhIR7
 97g8m3eSQlRkOhVnRSxS5LgCx51Re959F+wuGLSShulVcPIhw+J1zDJgqIN0Y8Lu23i7ukaa1v
 TGQsqwS/iI/nO++G6/hVnfBhsAAAA
X-Change-ID: 20260203-exynos-mobile-external-dtb-58d37746567e
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Mailman-Approved-At: Tue, 03 Feb 2026 14:35:06 +0100
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

This series aims to redo the way the board file works - notably it now
tries to depend on the external device tree if an internal device tree
is not provided.

It also does away with MULTI_DTB_FIT-based device tree support and
instead goes for a 'one device tree per build' approach. The
implementation draws great inspiration from the qcom-phone board.
Instead, the device tree target is to mentioned during build time.

The patches are based on u-boot-samsung. It is thus expected that they
reach upstream via said custotian fork.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Kaustabh Chakraborty (11):
      board: samsung: exynos-mobile: simplify parsing RAM banks from device tree
      board: samsung: exynos-mobile: resolve env vars without board_info data
      board: samsung: exynos-mobile: disable MULTI_DTB_FIT support
      board: samsung: exynos-mobile: enable OF_BOARD support
      configs: exynos-mobile: remove DEFAULT_DEVICE_TREE and add OF_UPSTREAM_BUILD_VENDOR
      doc: board: samsung: exynos-mobile: add DEVICE_TREE make flag in build
      doc: board: samsung: exynos-mobile: use u-boot-nodtb.bin for packaging process
      ARM: dts: exynos7870-a2corelte: add properties to make S-BOOT happy
      ARM: dts: exynos7870-j6lte: add properties to make S-BOOT happy
      ARM: dts: exynos7870-on7xelte: add properties to make S-BOOT happy
      doc: board: samsung: exynos-mobile: remove requirement of stub device tree

 arch/arm/dts/exynos7870-a2corelte-u-boot.dtsi  |   5 +
 arch/arm/dts/exynos7870-j6lte-u-boot.dtsi      |  25 +++
 arch/arm/dts/exynos7870-on7xelte-u-boot.dtsi   |  20 ++
 board/samsung/exynos-mobile/exynos-mobile.c    | 276 ++++++++-----------------
 configs/exynos-mobile_defconfig                |   5 +-
 doc/board/samsung/exynos-mobile.rst            |   5 +-
 doc/board/samsung/exynos-mobile/exynos7870.rst |  42 +---
 7 files changed, 147 insertions(+), 231 deletions(-)
---
base-commit: 3f2ab427c13e4883cb5dddb4c54d3cedc0f93669
change-id: 20260203-exynos-mobile-external-dtb-58d37746567e

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>

