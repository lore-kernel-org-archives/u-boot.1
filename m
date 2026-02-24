Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF28EF3C99F
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 15:49:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DF8583642;
	Tue, 24 Feb 2026 16:49:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="DbI/68J7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87F9883981; Tue, 24 Feb 2026 16:37:48 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 767B382BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 16:37:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 489FD26975;
 Tue, 24 Feb 2026 16:37:46 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1xc_HzjnkeIy; Tue, 24 Feb 2026 16:37:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1771947438; bh=bMQmHAK3jtDI8aPMXWLv9hNDO/QGZRSHv4QveGlYtAU=;
 h=From:Subject:Date:To:Cc;
 b=DbI/68J74icIFh9JHixaUWo/tqbphvWMuOv14Sf0i2hJIlA07/pTLuv/9K2lRF6l8
 vXCygj3GJWxGme35DabmQecS8gZ/b5siLIv95IN73GA5fqRtP2nl4t+F/p7jjCq0Bv
 uFqkYoFoKMLXCOYlimzPKUakjeV5o5n89JzibvWpREMdi1borPm/YSkiqouyhZj7yu
 R2ryOcROeWbckM9kKuuQH+S4UcZ3M61hbUWgQA7HQYB1UGqtK7auljhAeqyyP/D7rN
 LkGBbOAECa/plXFgpTGsQOUVtTXrcPM48nZo7yhfi0Gy43ZoVYVjFAMckChtkLjmTZ
 vjtXiyJOKmPOg==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH v2 0/3] Exynos Mobile DFU and blkmap additions
Date: Tue, 24 Feb 2026 21:07:08 +0530
Message-Id: <20260224-exynos-blkmap-dfu-v2-0-742cb9f27842@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKTFnWkC/22NQQ6CMBBFr0Jm7ZhSamlceQ/DAugUJiolLRII4
 e5WEncu30v++xtECkwRrtkGgWaO7IcE8pRB29dDR8g2MUghtZCyQFrWwUdsno9XPaJ1b5RKNdo
 pU5amgLQbAzlejua9StxznHxYj4s5/9pfTf2pzTkKbB3p/NJo0xpzsxyD99PZhw6qfd8/jtBLj
 7QAAAA=
X-Change-ID: 20260223-exynos-blkmap-dfu-244b6f487783
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Mailman-Approved-At: Tue, 24 Feb 2026 16:49:06 +0100
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

This series has two additions for support for blkmap and capsule updates
via DFU. The blkmap support is due to booting from sub-partitions from the
userdata partition.

The series also has a patch which fixes U-Boot builds from failing due
to the lack of a default fallback device tree.

This must go through u-boot-samsung. Would be nice to get this accepted
in this cycle itself.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Changes in v2:
- add patch which reintroduces DEFAULT_DEVICE_TREE option
- Link to v1: https://lore.kernel.org/r/20260224-exynos-blkmap-dfu-v1-0-cfe615b68c88@disroot.org

---
Kaustabh Chakraborty (3):
      board: samsung: exynos-mobile: use blkmap for booting from userdata subpartitions
      board: samsung: exynos-mobile: add EFI capsule update support
      configs: exynos-mobile: add DEFAULT_DEVICE_TREE option

 board/samsung/exynos-mobile/exynos-mobile.c   | 69 +++++++++++++++++++++++++++
 board/samsung/exynos-mobile/exynos-mobile.env |  5 ++
 configs/exynos-mobile_defconfig               | 11 ++++-
 3 files changed, 84 insertions(+), 1 deletion(-)
---
base-commit: 11198fa347390eb449c2a0939f5f00cf510fe285
change-id: 20260223-exynos-blkmap-dfu-244b6f487783

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>

