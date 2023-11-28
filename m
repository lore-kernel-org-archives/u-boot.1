Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8449C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 07:20:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03B4B87540;
	Tue, 28 Nov 2023 08:20:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xary/264";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC7A787669; Tue, 28 Nov 2023 08:20:26 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79D60875F3
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 08:20:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AS7KJiN028202;
 Tue, 28 Nov 2023 01:20:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701156019;
 bh=HF707DhH7sv6Yag6b2/Tep6plrpyjkzlbVq2xpuLv34=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=xary/264BMvUC9X9UE9RdnJ0NqWnkZhFtFoFQh/RJNfA2fcEd6lkcKQfEDjXUGbXB
 p/Hnx6N5o6JeUNHiAaRveQeakOQNdb8by1gunO92eBt+yqr5Zhsgzy1rulW/ZgvEVh
 m6blnC3Lj/h3zq5xF/pz3IOAl+x0bg/6SSwc2Cdc=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AS7KJGu066878
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 28 Nov 2023 01:20:19 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 Nov 2023 01:20:19 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 Nov 2023 01:20:19 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AS7KEsF002840;
 Tue, 28 Nov 2023 01:20:17 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <m-chawdhry@ti.com>
CC: <u-boot@lists.denx.de>, <rogerq@kernel.org>, <n-francis@ti.com>,
 <u-kumar1@ti.com>
Subject: [PATCH 1/2] board: ti: j721s2: j721s2.env: Add explicit boot_targets
Date: Tue, 28 Nov 2023 12:50:12 +0530
Message-ID: <20231128072013.440465-2-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128072013.440465-1-n-francis@ti.com>
References: <20231128072013.440465-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Add explicit boot_targets to indicate the specific boot sequence to
follow.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 board/ti/j721s2/j721s2.env | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/ti/j721s2/j721s2.env b/board/ti/j721s2/j721s2.env
index 64e3d9da85..e76cafe9ae 100644
--- a/board/ti/j721s2/j721s2.env
+++ b/board/ti/j721s2/j721s2.env
@@ -21,6 +21,7 @@ args_all=setenv optargs earlycon=ns16550a,mmio32,0x02880000
 	${mtdparts}
 run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
 
+boot_targets=mmc1 mmc0 usb pxe dhcp
 boot=mmc
 mmcdev=1
 bootpart=1:2
-- 
2.34.1

