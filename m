Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FBB6D2F7D1
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 11:10:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B927E84033;
	Fri,  5 Dec 2025 12:10:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="FWJ8O5k4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3DAB841EE; Fri,  5 Dec 2025 12:10:49 +0100 (CET)
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC09F841BC
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 12:10:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=primoz.fiser@norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YhTIai/cy0fQd/mZy2GWsBUClQAin8GC6ZnvORNqlTk=; b=FWJ8O5k4q/6MtHp1hTeKjNwyE/
 y0KR9g3j9COgSsmQ/5gBCy/wZL0Sc2oViT7Pb2YeJUCI3F8xQm/GURlahdFHSh+Z4szZhT01+ALKy
 LQVXC7ULPsHzXvMyTm8NW66drA6LSW+t76UIRZqy7K50BmHRa75Mg+tWmugf5AnPLSt68JWYgjIHW
 lZ4eVgfeamZvGkYU4uGlzMFEyxxyypKM1phDVlQbyuAjPom2aluQ4BshsAo1oCdEU8bCQoOt0YWkl
 CAUj0Xy2LEIE0CZNYIMjZS9KcdvoAE5t14maM8o8M9CVr4xXyhPMkyeYll0ayqy3Q2HmYf6hMb0yt
 niCPpKmw==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:53200
 helo=localhost.localdomain)
 by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98.2) (envelope-from <primoz.fiser@norik.com>)
 id 1vRTi5-000000046RH-37jX; Fri, 05 Dec 2025 12:10:45 +0100
From: Primoz Fiser <primoz.fiser@norik.com>
To: Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 uboot-imx@nxp.com, Tom Rini <trini@konsulko.com>,
 Benjamin Hahn <B.Hahn@phytec.de>
Cc: u-boot@lists.denx.de,
	upstream@lists.phytec.de
Subject: [PATCH v2 3/3] board: phytec: phycore-imx93: env: Add required uuu
 variables
Date: Fri,  5 Dec 2025 12:10:44 +0100
Message-Id: <20251205111044.3195322-3-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251205111044.3195322-1-primoz.fiser@norik.com>
References: <20251205111044.3195322-1-primoz.fiser@norik.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cp2.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

Add variable 'emmc_dev' and 'sd_dev' required for NXP uuu flash scripts.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
Changes in v2:                                                                  
- no changes                                   
                                                                                   
Link to v1: https://lore.kernel.org/all/20251204080744.3868067-3-primoz.fiser@norik.com/

 board/phytec/phycore_imx93/phycore_imx93.env | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/phytec/phycore_imx93/phycore_imx93.env b/board/phytec/phycore_imx93/phycore_imx93.env
index 4a5e5bfaee38..4e89c4ae26cb 100644
--- a/board/phytec/phycore_imx93/phycore_imx93.env
+++ b/board/phytec/phycore_imx93/phycore_imx93.env
@@ -2,6 +2,7 @@
 
 boot_script_dhcp=net_boot_fit.scr.uimg
 console=ttyLP0
+emmc_dev=0  /* This is needed by built-in uuu flash scripts */
 fdt_addr_r=0x90000000
 fdtfile=CONFIG_DEFAULT_FDT_FILE
 fdtoverlay_addr_r=0x900c0000
@@ -10,3 +11,4 @@ kernel_addr_r=0x88000000
 nfsroot=/srv/nfs
 prepare_mcore=setenv optargs "${optargs} clk-imx93.mcore_booted"
 scriptaddr=0x83500000
+sd_dev=1    /* This is needed by built-in uuu flash scripts */
-- 
2.34.1

