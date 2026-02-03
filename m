Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15A6E8782A
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 13:37:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6AB28422F;
	Tue,  3 Feb 2026 14:35:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="UIkl0bn+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30C7F8410B; Tue,  3 Feb 2026 14:09:14 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ADA383FFA
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 14:09:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 4E8BA2764F;
 Tue,  3 Feb 2026 14:09:06 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rzGaiLi2Zk8f; Tue,  3 Feb 2026 14:09:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1770124145; bh=wn1BtKQXXid8hWsFjLyX5sSqO3X6rLf4C1hnvQcBccc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=UIkl0bn+2zFkJVrTv88HrP3bnRBelDasGcXRp1GowzQzD1w6gAOOGNCYfwXJF/IOi
 pqDFQ1dF+dT3PxU0MY4pps5kw6aYMDGoTFOw4U9Z+RQdnsONzeK4av7PryplMNqPVx
 8OI3cd3ORQziqrdmA597pyFgNWbZhKofP02LTLcXJnxjZybiCNBe+l9MwCQjGPnfpV
 G7TQqr3QBrFtNIUmiw81wCmeIzLns4QDMinJkgjd2AnZVSXmDOHDzVlaD68ZG4eEau
 g43kbk5Vi2zs72WjY5qADkCuVfMFShMT3uqhj8ZSKY374UAs5BRb5TUwTDMxRxTip/
 8Jz0JP2XN/Q1Q==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Tue, 03 Feb 2026 18:38:44 +0530
Subject: [PATCH 06/11] doc: board: samsung: exynos-mobile: add DEVICE_TREE
 make flag in build
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-exynos-mobile-external-dtb-v1-6-a16a0e57991c@disroot.org>
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

Since there is only one internal device tree allowed in U-Boot, the
DEVICE_TREE flag is required for building images for various devices.
Document it in the build guide.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 doc/board/samsung/exynos-mobile.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/doc/board/samsung/exynos-mobile.rst b/doc/board/samsung/exynos-mobile.rst
index 37718af1fea..d0173b1f8cb 100644
--- a/doc/board/samsung/exynos-mobile.rst
+++ b/doc/board/samsung/exynos-mobile.rst
@@ -25,12 +25,13 @@ If a cross-compiler is required, install it and set it up like so:
 
 	export CROSS_COMPILE=aarch64-linux-gnu-
 
-Then, run the following commands to build U-Boot:
+Then, run the following commands to build U-Boot (replace ``<dtb>`` with the
+upstream DTB path for the target device):
 
 .. prompt:: bash $
 
 	make O=.output exynos-mobile_defconfig
-	make O=.output -j$(nproc)
+	make DEVICE_TREE=<dtb> O=.output -j$(nproc)
 
 If successful, the U-Boot binary will be present in ``.output/u-boot.bin``.
 

-- 
2.52.0

