Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A881BC8303C
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 13:23:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E667D8334D;
	Tue,  8 Jul 2025 15:23:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tq-group.com header.i=@tq-group.com header.b="Wb9MsEU2";
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="K4rUR4vW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51C6E8319F; Tue,  8 Jul 2025 10:41:42 +0200 (CEST)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 536B483145
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 10:41:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.stein@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1751964100; x=1783500100;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ZrqGFpxvbBfkD4e8oUXQxLZh4VywkqTGreIkUJd1xi4=;
 b=Wb9MsEU2eU/nXGyvIKhs1OFwxXn72Fal62IogZui7d6NTaW6h+8pULr9
 XUup3CjVTQ0KxrONZqGBNs1zM+CeEtlwdS7fw8GXDfssqfSCndauXpe1+
 NdwtAZNcxulgDpqgvCp5DclxCwcey225VCp3joKHZYEauaGS36sAf+n1t
 s8cqy/AIRIlRoB7tqBOvRnxggWBIFiZ8ZpxUUYrBBBWr2jjSGeXYmoLYr
 7f48KNv6dtO28fIj0zNi/QBSU+7ik5bcI6f+cmCyF5uRiK8ts20HWuLgw
 tDkOCxo4rfXScosCyKKO58Kml7Kcgbeqp7QLr7lycHYPbXlgAey7OwWwu A==;
X-CSE-ConnectionGUID: d970YXc0SVimsH9AHdRHmw==
X-CSE-MsgGUID: F5iaIY4cQJOML5TZnklAJQ==
X-IronPort-AV: E=Sophos;i="6.16,296,1744063200"; d="scan'208";a="45081411"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
 by mx1.tq-group.com with ESMTP; 08 Jul 2025 10:41:39 +0200
X-CheckPoint: {686CD9C3-1E-B791C630-E7A1546C}
X-MAIL-CPID: 44FBC6768287F42F7BD15CE9D71338B8_2
X-Control-Analysis: str=0001.0A006377.686CD9D2.0012, ss=1, re=0.000, recu=0.000,
 reip=0.000, cl=1, cld=1, fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A1E9416357E; Tue,  8 Jul 2025 10:41:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
 s=dkim; t=1751964095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZrqGFpxvbBfkD4e8oUXQxLZh4VywkqTGreIkUJd1xi4=;
 b=K4rUR4vWZGmceqbCQ7QHSNFsP9U7hhgMOejmM7EsF4Lq1WxFXDi/GGGsgeCeee/+Twsdse
 y7172GR4bAilhb1uvz4icDUbP19QyjtvhS8nNu/nTOtJtsJwImrb3Gvpt9ASOcFDpsmn2/
 zktoVlEoImaSM13mslp/GBgNpCp7CO60EBT3js/ZOLKrrrOwe9BYKwP82tcHt1la6iGKGD
 umvnccVyFTuOBthFn8V5hggw9tyjdkzurOLOL37wwOmckzihwV0LVGY2XFSO/BaJRqi5BY
 JY4g1WeW/PitVVG74w4UZ2F62ZmNLc/BlaXo6udPOLwOb6XARVjPo9piNLk3cA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	u-boot@lists.denx.de
Subject: [PATCH 1/1] arm: imx: imx8m: soc: Fix i.MX8M Nano GPU paths
Date: Tue,  8 Jul 2025 10:41:24 +0200
Message-ID: <20250708084127.659728-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Tue, 08 Jul 2025 15:23:43 +0200
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

The SoC node is called 'soc@0', even on NXP branch 6.6-fslc. This fixes
the boot on i.MX8M Nano DualLite, as there is no GPU.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/mach-imx/imx8m/soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index 3cdb71a2528..1fe083ae94f 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -1151,7 +1151,7 @@ int disable_gpu_nodes(void *blob)
 {
 	static const char * const nodes_path_8mn[] = {
 		"/gpu@38000000",
-		"/soc@/gpu@38000000"
+		"/soc@0/gpu@38000000"
 	};
 
 	static const char * const nodes_path_8mp[] = {
-- 
2.43.0

