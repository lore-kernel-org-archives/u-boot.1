Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F80C3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 21:24:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29C2F829E4;
	Thu,  8 May 2025 23:24:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=krotti42.com header.i=@krotti42.com header.b="Ew+ztVfA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBBD0829E7; Thu,  8 May 2025 23:24:02 +0200 (CEST)
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch
 [109.224.244.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E573F82952
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 23:24:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johannes@krotti42.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krotti42.com;
 s=protonmail; t=1746739440; x=1746998640;
 bh=wCMmLfgel+SpoQYF6N9vgFwy8VTenEwPPhRdF+5LhsQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=Ew+ztVfA1C0jS/NcyS/Soq/DLtikO4ffsgJz1s4Hjbv9ctjomW+NkunHI/P+Ly7mM
 EyYDeA2f5lfycdvqGImYplkR7JbpgRUJ7BKJqE44GaH+Ze8oTwedwZNyzpHK/1hHDr
 8imcCANnIrnCSlsIBI+62L8FuQ0MyLzRXUM6OozPckQx9Pd6kB5FNRxu+IceApho1X
 WaoBmn0Kq0vkRP0kqhd6/5zCk43e8a+MX3yGEn5P29eWvnyGnRXtg+fh+ol5a76n9C
 AcVRCllhqRNFxweWsV3uE0kGGC3AD/LOdweiJPvhH0d7ck2qkoOxjJI2tW+tdHfkjA
 FL4w5o4r/7fzw==
Date: Thu, 08 May 2025 21:23:53 +0000
To: u-boot@lists.denx.de
From: Johannes Krottmayer <johannes@krotti42.com>
Cc: Johannes Krottmayer <johannes@krotti42.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 02/10] arm: mach-stm32: stm32h7: add initial Makefile
Message-ID: <20250508212058.640483-3-johannes@krotti42.com>
In-Reply-To: <611b339e-a9fe-4cc1-b2fc-617d844a86ac@krotti42.com>
References: <611b339e-a9fe-4cc1-b2fc-617d844a86ac@krotti42.com>
Feedback-ID: 88021767:user:proton
X-Pm-Message-ID: de30f71d170cdbe6b02d628961fd7c6ab1e6937f
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Add initial Makefile for the STM32H7 series:

Currently it includes only one additional assembly source file
which is required for the STM32H747I-DISCO board.

Signed-off-by: Johannes Krottmayer <johannes@krotti42.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/mach-stm32/stm32h7/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 arch/arm/mach-stm32/stm32h7/Makefile

diff --git a/arch/arm/mach-stm32/stm32h7/Makefile b/arch/arm/mach-stm32/stm=
32h7/Makefile
new file mode 100644
index 00000000000..a70d4b445db
--- /dev/null
+++ b/arch/arm/mach-stm32/stm32h7/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# (C) Copyright 2025
+# Johannes Krottmayer <johannes@krotti42.com>
+
+obj-y +=3D lowlevel.o
--=20
2.39.5


