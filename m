Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A3D3F3C991
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 15:38:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AC6B83E76;
	Tue, 24 Feb 2026 16:37:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="mJspjRON";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B728683DAE; Tue, 24 Feb 2026 16:37:31 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB71883642
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 16:37:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id B588426F8F;
 Tue, 24 Feb 2026 16:37:29 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pZjkct8fipQg; Tue, 24 Feb 2026 16:37:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1771947449; bh=W0u1KjTHBBH4OFi3n5ho+AViTFO41fLEy7+ilzMpyrs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=mJspjRONpacXulum7WIJ7pe+9U3hVg3luKVZcikHZ9IvkwU46GUHKmPk5nleO7Ips
 eovE6kmkJ2LMEuVDD3qOdnmi6pcxM3WA0M1pdKlrY0d7Sh/s7fT7cDvi2aDrr1P0ES
 Gkvwv8+cYZWVMF40n5c3X/4b1ACnt5ilJs2ngpJwPSRNli482ZkupqFKti5+hUKZ5O
 qu0m5xlH5fnLe6DpIXFGZs1L9PATzQkcmX75jW3tF5owEpSd8LwhOE8hhyBoHhWLre
 vDt0Nv3h1gmQbskmDo5tpHeri4bt3ZAaIFsDYt7bY0qb8QnG2URfk6kfGo8SFJDyib
 QB5jysEbKknog==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Tue, 24 Feb 2026 21:07:11 +0530
Subject: [PATCH v2 3/3] configs: exynos-mobile: add DEFAULT_DEVICE_TREE option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-exynos-blkmap-dfu-v2-3-742cb9f27842@disroot.org>
References: <20260224-exynos-blkmap-dfu-v2-0-742cb9f27842@disroot.org>
In-Reply-To: <20260224-exynos-blkmap-dfu-v2-0-742cb9f27842@disroot.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Mailman-Approved-At: Tue, 24 Feb 2026 16:37:49 +0100
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

Add a default fallback device tree in order to allow a successful build
without mentioning the DEVICE_TREE= make flag.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 configs/exynos-mobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/exynos-mobile_defconfig b/configs/exynos-mobile_defconfig
index 9a4b6a52362..bff4e6c6fb7 100644
--- a/configs/exynos-mobile_defconfig
+++ b/configs/exynos-mobile_defconfig
@@ -7,6 +7,7 @@ CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MALLOC_F_LEN=0x16000
 CONFIG_TARGET_EXYNOS_MOBILE=y
 CONFIG_NR_DRAM_BANKS=3
+CONFIG_DEFAULT_DEVICE_TREE="exynos/exynos7870-a2corelte"
 CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_SYS_LOAD_ADDR=0x80000000
 CONFIG_ARMV8_CNTFRQ_BROKEN=y

-- 
2.52.0

