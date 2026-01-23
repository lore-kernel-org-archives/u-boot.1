Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA70DD778AC
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 18:25:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A0BE83AEE;
	Fri, 23 Jan 2026 19:25:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="bTtSPSIP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C95CC83B0B; Fri, 23 Jan 2026 19:11:56 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 451D883AEE
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 19:11:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id EABBE27963;
 Fri, 23 Jan 2026 19:11:53 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9kclEAInnSaL; Fri, 23 Jan 2026 19:11:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1769191913; bh=2HSoDkO6/xDJbeRWtJumkHK4Mx7+XZFsLzmgSdcW4GU=;
 h=From:Date:Subject:To:Cc;
 b=bTtSPSIP/6kIYdRuI7k6n9GjiUe6MxAQ1kgI7i7aYhDZ+t1xPNHZOFQLyr/M4g20v
 HUSZqMVh4jCjsMEW9gcukGs5uCYs+tmk0LMhlP4ir3bPy/y0ix5VswOvOb8e1IlMcS
 IQmXhKBVsh0mhsVa+NZAmLVVSMSLCNpLpNSishF5wOJj2Qk2Qm29sqsfdkICOUfmQJ
 TTyapmyyCqGT2mnP81GHT0HFYgTl9rVAGdyvhdImg1zeM6dY+WS/LOZvwPdRQ39f+v
 T4i4D9Wc8Uu2mZUjhdMjNOLCQwGXsekOn9edxcRoNUlLUIaqQ5ZU2nUd+ELCy2ACGW
 3pZrA4ncdDkxQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 23 Jan 2026 23:41:41 +0530
Subject: [PATCH] dts: add exynos arm64 vendor support for
 OF_UPSTREAM_BUILD_VENDOR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-dts-exynos-vendor-v1-1-479e72170257@disroot.org>
X-B4-Tracking: v=1; b=H4sIANy5c2kC/x3MMQqAMAxA0atIZgNNC4peRRyqjZqllUZEEe9uc
 XzD/w8oZ2GFvnog8ykqKRZQXcG8+bgySigGa2xjyDoMhyJfd0yKJ8eQMprOe2odTTQzlG7PvMj
 1P4fxfT8M1A3rYwAAAA==
X-Change-ID: 20260123-dts-exynos-vendor-09aa1731b1ce
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Mailman-Approved-At: Fri, 23 Jan 2026 19:25:41 +0100
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

Set OF_UPSTREAM_BUILD_VENDOR to build all devicetrees in "exynos/" for
Exynos-based 64-bit ARM platforms (32-bit ARM uses "samsung/").

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 dts/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dts/Kconfig b/dts/Kconfig
index 870f75ad3ec..e0f6f03a343 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -124,6 +124,7 @@ config OF_UPSTREAM_VENDOR
 	default "marvell" if ARCH_MVEBU || ARCH_KIRKWOOD
 	default "xilinx" if ARCH_VERSAL || ARCH_ZYNQ
 	default "nvidia" if ARCH_TEGRA
+	default "exynos" if ARCH_EXYNOS && ARCH_ARM64
 	help
 	  Select the vendor to build all devicetree files for.
 

---
base-commit: 6cdd7597a2fbfc1572c1b0af23d3daf1cefa2de7
change-id: 20260123-dts-exynos-vendor-09aa1731b1ce

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>

