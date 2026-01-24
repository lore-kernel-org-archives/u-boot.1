Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE300D715EE
	for <u-boot@archiver.kernel.org>; Sat, 24 Jan 2026 18:33:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AD6983BFE;
	Sat, 24 Jan 2026 19:33:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="ipbRbP8p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AE7483BC8; Sat, 24 Jan 2026 17:58:37 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C09583AEE
 for <u-boot@lists.denx.de>; Sat, 24 Jan 2026 17:58:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id DC291276D1;
 Sat, 24 Jan 2026 17:58:33 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VdPzCBPBZT_J; Sat, 24 Jan 2026 17:58:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1769273913; bh=LoOzy4o0YsfqTqi7i3cUK17EQayEbeBkrhgvRvZIezg=;
 h=From:Date:Subject:To:Cc;
 b=ipbRbP8ppXAnIGSJgz7FeV/yFhLH/AEEsR83xFqqBEr4Zopc6QOr3sLBVbfcwODee
 aN5Z9RVRzB3wgYXNQetDnRwTsRPY3CPsBbT821nrMXuAgWcH1rqU+9DqA0g6U56Ns8
 Ab9kY7NUfnTQG7NVI9AXPEOoSCa8qIFfKqtg6kVTuXlr57kEdxCok0ZFz/TyhMndDw
 eXpepWKJDscMibcyR6gbU2FVIeg38gvq1KNfkmdtPZHIzdJTt/gIeqP7+eeGTDQyBZ
 U85gMQCiGZa1ii2X+jvPoF/M3Ahrv9c9GcrLEt9U4fIJeZgHLBeEFz6i0f/AS9ReNn
 huWek7akxJDVg==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Sat, 24 Jan 2026 22:28:24 +0530
Subject: [PATCH v2] dts: add Exynos vendor support for OF_UPSTREAM_VENDOR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260124-dts-exynos-vendor-v2-1-89eb2866d43a@disroot.org>
X-B4-Tracking: v=1; b=H4sIAC/6dGkC/32NQQ6CMBBFr0Jm7ZhOURtceQ/DAukI3XTMlDQQ0
 rtbOYDL95L//g6JNXCCe7ODcg4pSKxgTw2M8xAnxuArgzX2Zsi26JeEvG5REmaOXhRNNwzkWnr
 RyFB3H+V3WI/ms688h7SIbsdFpp/9V8uEhBfXsbPkjL26hw9JRZaz6AR9KeULugHROLQAAAA=
X-Change-ID: 20260123-dts-exynos-vendor-09aa1731b1ce
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Mailman-Approved-At: Sat, 24 Jan 2026 19:33:45 +0100
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

When building Exynos boards, configure OF_UPSTREAM_VENDOR to build all
device trees in:
 - "samsung/" for 32-bit ARM platforms.
 - "exynos/" for 64-bit ARM platforms.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Changes in v2:
- s/ARCH_ARM64/ARM64 (Tom Rini)
- add target for 32-bit Exynos devices as well (Tom Rini)
- Link to v1: https://lore.kernel.org/r/20260123-dts-exynos-vendor-v1-1-479e72170257@disroot.org
---
 dts/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/dts/Kconfig b/dts/Kconfig
index 870f75ad3ec..af8d30b45ab 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -124,6 +124,8 @@ config OF_UPSTREAM_VENDOR
 	default "marvell" if ARCH_MVEBU || ARCH_KIRKWOOD
 	default "xilinx" if ARCH_VERSAL || ARCH_ZYNQ
 	default "nvidia" if ARCH_TEGRA
+	default "samsung" if ARCH_EXYNOS && 32BIT
+	default "exynos" if ARCH_EXYNOS && ARM64
 	help
 	  Select the vendor to build all devicetree files for.
 

---
base-commit: 6cdd7597a2fbfc1572c1b0af23d3daf1cefa2de7
change-id: 20260123-dts-exynos-vendor-09aa1731b1ce

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>

