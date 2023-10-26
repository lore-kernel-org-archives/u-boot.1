Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA461C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 07:33:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5DEA87B29;
	Thu, 26 Oct 2023 09:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F2C487B2B; Thu, 26 Oct 2023 09:32:42 +0200 (CEST)
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C95AB87B1C
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 09:32:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel@ziswiler.com
Received: from toolbox.int.toradex.com ([213.66.31.70]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0M4oTz-1rhgQ70fDJ-00z1Pt; Thu, 26 Oct 2023 09:32:30 +0200
From: Marcel Ziswiler <marcel@ziswiler.com>
To: u-boot@lists.denx.de
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Stefano Babic <sbabic@denx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v1 2/2] imx: spl_imx_romapi: fix emmc fast boot mode case
Date: Thu, 26 Oct 2023 09:32:20 +0200
Message-Id: <20231026073220.244387-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231026073220.244387-1-marcel@ziswiler.com>
References: <20231026073220.244387-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cDXio57xbY+FdW/uzdJYRpnoGB4hnMmkF/DTRDYyMRpGf5MWLHc
 cWCXdkHBOxx6XjNHo4ohkb72O8sXoLXfcuPGxZcurKW8nS4wV++drihTcpaO2fY2tOWcT4n
 ysgxlLio888NCVS2I/EA6fZNpHJL/f/Je/2mxBC2FCgsQISqOI83jIYoMyn9Ufck0uUQ/V1
 aIdPdTYhJLfc1+06Gb06g==
UI-OutboundReport: notjunk:1;M01:P0:hLwH6LOLEhs=;nLhX8znm+fQCFQBXywizmlOmJMZ
 n03aLvR/nQj8pKgQZ/GI0z4aLUq9mrBIXFekLl2nlAfOmWVxpslPSScvkxnxpSGNgLIJb6Uk5
 asw2P5lD0e5MFa8wRnc7LiNoP0GrZx4BDxgClvCguTJsNHXmKKrD4zAnU1UKatIYJFEzaD6mu
 eMtjBE5badn2igqMt2jjqJX7o9qUsSLVdMeBwf1Iev+es+r4Qv1r2+bEwZng/Nha7quJX77mM
 Ls1mTUldva8Dq+XBGs7K5c8ptGPn2ROzzRjoyzxExx7K2XX54WsL5akzFPayBTaH8kn/4X9Zw
 NZaHXWJ2Dw9sq7AT+9FQHHnQTqUArungC1COZcPGEJln2F7dG3vDBZbIEkQnMCTZ6D8j152mf
 TP2aRXk2pt6p4u9DQFskgRlGeZ6qUK9QbZHmyZ9960w3wiGDUfNtUQLs6Oc9wX+PRp6xB2JCL
 idYTP5ftaI+aLOlB/2cmEi65HoYIsF4hF+OUv27msb/qo5iTAIG0MDn14qjzMF3KkusSXafQQ
 0mecYWoWNN1JR0ySMsUbNfOKetSuNEPRjXtP848CF6cGHP9yD8Kba+NYxST7Pm+pxEnyYk1Zh
 HpfY+I9p+G2r2XsgX9Jf7ttx7Gm5aKuHMfXBK9KFtXZh12vGA76XgpLYk5mfQaIS9QEKiClmv
 yflqymM8X4IJP1geylXLcjE1G4+Y9103PBjhT/uZ4Yyyzqkdi3GO57mccW+dC3wznEj6Mnopi
 1+AxApuASvehHys4878tVmG9hT/GIcqPE2KQqKwyiwDDG3ZHucChCCdDhvtYALHGkFnPa51xg
 32BuvTVlUnQJ9r8h4zThGFmmXha+1Hl3C133/YhNdXEnRLiicpftzlY+0d/IgZZjs5yykY79A
 +rbzabFrIeZF0Hg==
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

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

This fixes a regression in the eMMC fast boot mode case where the buffer
was missing 464 bytes.

The code figures out how many bytes must at least be fetched to honor
the current read, rounds that up to the ss->pagesize [which is a no-op
in the USB download case because that has ->pagesize==1], fetches that
many bytes, but then recorded the original upper bound as the new end of
the valid data. However, this did not take into account the rounding up
to the ss->pagesize. Fix this by recording the actual bytes downloaded.

Fixes: 4b4472438f5a ("imx: spl_imx_romapi: avoid tricky use of spl_load_simple_fit() to get full FIT size")
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/mach-imx/spl_imx_romapi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/spl_imx_romapi.c b/arch/arm/mach-imx/spl_imx_romapi.c
index cb220869b50..5eb5a3d3c4a 100644
--- a/arch/arm/mach-imx/spl_imx_romapi.c
+++ b/arch/arm/mach-imx/spl_imx_romapi.c
@@ -162,7 +162,7 @@ static ulong spl_romapi_read_stream(struct spl_load_info *load, ulong sector,
 			return 0;
 		}
 
-		ss->end = end;
+		ss->end += bytes;
 	}
 
 	memcpy(buf, (void *)(sector), count);
-- 
2.36.1

