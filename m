Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11721E8782D
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 13:37:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A58B584222;
	Tue,  3 Feb 2026 14:35:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="diD5CuvX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 277DF84105; Tue,  3 Feb 2026 14:09:11 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4975A840B1
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 14:09:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 1732226526;
 Tue,  3 Feb 2026 14:09:09 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dNPtbzOmdQqi; Tue,  3 Feb 2026 14:09:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1770124148; bh=hFR+irIxuVix9DFEGi/rXSBh5okIian2ZafiBI4Exe4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=diD5CuvXqh1f1+9Uy7q3KQTi4xBTNlM3bzdB8eUh+ZpgBwqk66ETcJLSwmDcmpqsW
 gAGbEozFumGO1dWTkULsDsHkq2QIVXxf5BXnQjornsD1XN3hR6RQxVihYCyoxmMSc3
 K1uGL9QzoXS3h+AmgGCGseHtkIBgWlC09tEoSIDRzW7Evqbc2cdarjIdEAeQNV9iwI
 wmOPIdnoET7FW5M+DCQNzc0QsioQvmuErIhSNQXb94QgCy/ONbbNIsd2UyB2TuFYVI
 bDwl8HyqInDw5xLzWuUG3aPfUtFkPAbJEKJ2DxTrq+pEbW2sTM3U6jbw9bfVndTrp2
 i+XAoMgouOrQA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Tue, 03 Feb 2026 18:38:45 +0530
Subject: [PATCH 07/11] doc: board: samsung: exynos-mobile: use
 u-boot-nodtb.bin for packaging process
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-exynos-mobile-external-dtb-v1-7-a16a0e57991c@disroot.org>
References: <20260203-exynos-mobile-external-dtb-v1-0-a16a0e57991c@disroot.org>
In-Reply-To: <20260203-exynos-mobile-external-dtb-v1-0-a16a0e57991c@disroot.org>
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

U-Boot for this board is programmed to use the external DTB if an
internal device tree is not available. This makes it safe to build boot
images using the non-DTB U-Boot binary, while taking up less space.
Reflect this change in documentation.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 doc/board/samsung/exynos-mobile/exynos7870.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/board/samsung/exynos-mobile/exynos7870.rst b/doc/board/samsung/exynos-mobile/exynos7870.rst
index bbd857580b8..37562e272b4 100644
--- a/doc/board/samsung/exynos-mobile/exynos7870.rst
+++ b/doc/board/samsung/exynos-mobile/exynos7870.rst
@@ -53,7 +53,7 @@ Finally, use ``mkbootimg`` by osm0sis [3]_ to generate the boot image:
 .. prompt:: bash $
 
 	mkbootimg -o u-boot.img \
-		--kernel	.output/u-boot.bin \
+		--kernel	.output/u-boot-nodtb.bin \
 		--dt		stub-dt.img
 
 Offsets are not provided to ``mkbootimg`` as S-BOOT ignores them.

-- 
2.52.0

