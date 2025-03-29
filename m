Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40E5C36008
	for <u-boot@archiver.kernel.org>; Sat, 29 Mar 2025 15:07:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BEFB81E8C;
	Sat, 29 Mar 2025 16:06:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="yHcyaGhd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C800581E6C; Sat, 29 Mar 2025 16:06:50 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6E1A81E3E
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 16:06:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=1dca=WR=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1743260806; bh=5iyXKZ3U4lpExoAOELxbkkZuxD1MRGIVTnVi3v9ybt0=;
 b=yHcyaGhdwRlAk95TPlM6YvXMdItPmY4Iupg6SiX1Z8RUvbSkGFJGmZ7PGnZdXBvTl9UgYY42P
 JC9p1p7kQqCEBS+vRJLfI2Rvt1R8lN528cQUkxYlHNwZppdWjI1qfRTwJnmaHeZjwZm4ZIrMePs
 nvR7FgDbc10H53Ncj6muFJuskKcmDOGTE833nXB9/fAnNGrXKlWr3Q1zgx3pvr4gPUuZ9noqNrA
 /DPC/eUPVX1qzcz802GwCiBEszeQB4+Th5s8iBfBSxxP3O/+xRT+KjcT9lTh1lTNurZ29rHGsCm
 vGzbTPODqhhYWdh6ufEarajOwsxxR43T+PEx7MJDX7xg==
X-Forward-Email-ID: 67e80c8221787eb134711f1e
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki <naoki@radxa.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v4 03/10] rockchip: binman: Add an fdtmap
Date: Sat, 29 Mar 2025 15:06:06 +0000
Message-ID: <20250329150626.2879942-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250329150626.2879942-1-jonas@kwiboo.se>
References: <20250329150626.2879942-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Simon Glass <sjg@chromium.org>

Add an fdtmap so it is possible to look at the image with 'binman ls'.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v4:
- Split from "VBE serial part H: Implement VBE on Rockchip RK3399"

Changes in v3:
- Add blank lines before the node
---
 arch/arm/dts/rockchip-u-boot.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 2b01dc660562..8aea2e6f5713 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -170,6 +170,9 @@
 			offset = <CONFIG_SPL_PAD_TO>;
 		};
 #endif
+
+		fdtmap {
+		};
 	};
 
 #ifdef CONFIG_ROCKCHIP_SPI_IMAGE
@@ -203,6 +206,9 @@
 			/* Sync with u-boot,spl-payload-offset if present */
 			offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
 		};
+
+		fdtmap {
+		};
 	};
 #endif /* CONFIG_ROCKCHIP_SPI_IMAGE */
 };
-- 
2.49.0

