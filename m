Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A4FE909D3
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 16:39:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B25C683CD3;
	Tue, 17 Feb 2026 17:39:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="iQ1SUAMp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4484A83DFF; Tue, 17 Feb 2026 17:39:20 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E90E283CB9
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 17:39:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E0144110AD2; Tue, 17 Feb 2026 17:39:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1771346356; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=VxfMO/DXf7/VviiE9uV+HVfTGTnkrAXaMhrjvUgldzQ=;
 b=iQ1SUAMpiIXg5RZVAlLz151COggWoUJmEuwENQoqKHO17V/6pnk7lbd7551+IRajgFsgi9
 a4knKQq6YUssyW+AlorXbZ8/FDudABC6D6GsWi6V/ZkLER+sc4GK77uIXOQaRq7vqBNxj6
 tZlLtUh81nUSZNvda5vd7ogQNQJEpOcBwYWWuU6AdfvC3+YjPSOMso7upal7OgFDr1PCZt
 QlJeUi09tRwY5SgxXMrFExAitVl3rGWCtLgoNGc/R/2m3TQ0/MSpw6ifxvfNu1VD0F+r7g
 8yEQX0m6reMgK0n2vkgvTNTQUXS3a5MrwpMdgmTcU+rbyuHoiLjzO4t880zHNw==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@oss.nxp.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Heiko Schocher <hs@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Lukas Stockmann <lukas.stockmann@siemens.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Walter Schweizer <walter.schweizer@siemens.com>
Subject: [PATCH v3 02/11] siemens: capricorn: set max-frequency for usdhc1
Date: Tue, 17 Feb 2026 17:39:02 +0100
Message-Id: <20260217163911.31878-3-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260217163911.31878-1-hs@nabladev.com>
References: <20260217163911.31878-1-hs@nabladev.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Adrian Freihofer <adrian.freihofer@siemens.com>

This is required since

commit aebb523a2381 ("mmc: mmc-uclass: Use max-frequency from device tree with default handling")

and the related patches of the same series.

The error observed without this change is:
  Autobooting in 3 seconds, press "<Esc><Esc>" to stop
  EXT_CSD[179], PARTITION_CONFIG:
  BOOT_ACK: 0x0
  BOOT_PARTITION_ENABLE: 0x1 (boot0)
  PARTITION_ACCESS: 0x0 (user)
  Loading from eMMC ...fit

  U-Boot SPL 2026.01-4238dcfcbfe (Jan 09 2026 - 08:19:45 +0000)

For this example it's the following commands which does no longer work
for larger images:

  ext4load mmc 0:1 0x88000000 boot/fitImage

On latest master branch the problematic commit gets reverted with

commit c4f5b1d4b037 ("Revert "mmc: mmc-uclass: Use max-frequency from device tree with default handling"")

but for v2026.01 this fix is still required. Maybe it's anyway a good
idea to have this property set explicitly.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
Signed-off-by: Heiko Schocher <hs@nabladev.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>

---

(no changes since v2)

Changes in v2:
Added Reviewed-by from Peng

 arch/arm/dts/imx8-capricorn.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/imx8-capricorn.dtsi b/arch/arm/dts/imx8-capricorn.dtsi
index 38d36fafbe0..fab7ef95166 100644
--- a/arch/arm/dts/imx8-capricorn.dtsi
+++ b/arch/arm/dts/imx8-capricorn.dtsi
@@ -125,6 +125,7 @@
 &usdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc1>;
+	max-frequency = <52000000>;
 	clock-frequency=<52000000>;
 	no-1-8-v;
 	bus-width = <8>;
-- 
2.20.1

