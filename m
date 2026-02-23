Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F49EC1120
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 18:47:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6463083D8A;
	Mon, 23 Feb 2026 19:47:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="PsA1CwVy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2512783D2E; Mon, 23 Feb 2026 19:39:21 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32BD183935
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 19:39:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id AA10127DA9;
 Mon, 23 Feb 2026 19:39:15 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3p5pFhxD32uG; Mon, 23 Feb 2026 19:39:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1771871955; bh=plwon9+9ZLg4SJdpq7gDRi+Sg06tAS8fbHMGTga0eHs=;
 h=From:Subject:Date:To:Cc;
 b=PsA1CwVyK5iPCrZLCpZujjU03hoOjNnzMV5isD/wqeYewxc+cUalgsp9cA+CYabsR
 tJTK9U5bWmJ4EG9AHBlMgrdbB10PXzqEkPZ7kXqtrmwp2UfNdsBX27iMue75YhVrQj
 AP8Xta15jzrZo4fhKOZDKxxzrneXaal9kc5xzY+QYFhtFFJXwTxilmZ2hwiphyRDUw
 KLFddfZ5Yd6jvgBZ+8S57FgWijY/LLub1yyoy/6CV93l5Y+iD6p4nZpt8K5UXrtgY7
 ByN63pqKBKvuV+nNivQh5222CuHy4zcRQGHz8U3aRQv4LUoQFARQMNO+Qe+wtXcyur
 3+kW4+CgjOabg==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH 0/2] Exynos Mobile DFU and blkmap additions
Date: Tue, 24 Feb 2026 00:09:08 +0530
Message-Id: <20260224-exynos-blkmap-dfu-v1-0-cfe615b68c88@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMyenGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIyNj3dSKyrz8Yt2knOzcxALdlLRSXSMTkySzNBMLc3MLYyWgvoKi1LT
 MCrCZ0bG1tQCeL9mpYwAAAA==
X-Change-ID: 20260223-exynos-blkmap-dfu-244b6f487783
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Mailman-Approved-At: Mon, 23 Feb 2026 19:47:22 +0100
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

This must go through u-boot-samsung. Would be nice to get this accepted
in this cycle itself.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Kaustabh Chakraborty (2):
      board: samsung: exynos-mobile: use blkmap for booting from userdata subpartitions
      board: samsung: exynos-mobile: add EFI capsule update support

 board/samsung/exynos-mobile/exynos-mobile.c   | 69 +++++++++++++++++++++++++++
 board/samsung/exynos-mobile/exynos-mobile.env |  5 ++
 configs/exynos-mobile_defconfig               | 10 +++-
 3 files changed, 83 insertions(+), 1 deletion(-)
---
base-commit: 11198fa347390eb449c2a0939f5f00cf510fe285
change-id: 20260223-exynos-blkmap-dfu-244b6f487783

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>

