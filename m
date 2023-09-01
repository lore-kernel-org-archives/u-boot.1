Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24AD3CA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 07:02:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E18E8679F;
	Fri,  1 Sep 2023 09:02:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IhGKmAsB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C4D986759; Fri,  1 Sep 2023 09:02:38 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41C9986564
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 09:02:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38172XqI002841;
 Fri, 1 Sep 2023 02:02:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693551753;
 bh=35t/XYISjb7Kb/xcLf6snEQtZD9dzJmufp5d9HKvfMU=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=IhGKmAsB9JkcopCCpm2HHFE0wH3cT9wxW89VBkORILW66Gq5yDgyp7wDidMM2YsFq
 WTJ0KKMugD1k2OkdIowpvaFZJFELRX5gbELpShj8x5S8IBeqfrCIsXvxonVf3FPnan
 NSxQ+zGUaGvkd6nhS0kUZZ7JWljhg9XnnpSCEih0=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38172X54002261
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 1 Sep 2023 02:02:33 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Sep 2023 02:02:32 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Sep 2023 02:02:33 -0500
Received: from [127.0.1.1] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38172OvH061729;
 Fri, 1 Sep 2023 02:02:29 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Fri, 1 Sep 2023 12:32:23 +0530
Subject: [PATCH v3 1/6] configs: j721s2_evm_r5_defconfig: Increase malloc
 pool size in DRAM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230816-b4-upstream-j721s2-r5-pinmux-v3-1-fd6602912536@ti.com>
References: <20230816-b4-upstream-j721s2-r5-pinmux-v3-0-fd6602912536@ti.com>
In-Reply-To: <20230816-b4-upstream-j721s2-r5-pinmux-v3-0-fd6602912536@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Andrew Davis <afd@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Nikhil M Jain <n-jain1@ti.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693551744; l=928;
 i=m-chawdhry@ti.com; s=20230324; h=from:subject:message-id;
 bh=vbSNyBR1McEv9slsl/Jk0+b3vtr26oKM5At23kLMZCU=;
 b=LbM2R6BaemgL+BQJO458p/p+aXFAllyn36UCNx2M6VYTEYsym9kbrmlLQXsmRSIlhhBQozcrt
 BFAmt0B9f0YCJLVRhk5tlUpiz5G7P7CT8vO24Pzce6zVXFyT22faor2
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=Z51yAzxWCcDqKRLHiDBrUxIdXbB21R89ms8xgECdiak=
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

From: Udit Kumar <u-kumar1@ti.com>

The malloc capacity in DRAM at R5 SPL is set to 1MB which isn't
sufficient to load the new tispl.bin to
enable loading of tispl.bin the size is increased by 256KB to 1.25MB.

Cc: Nikhil M Jain <n-jain1@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
Reviewed-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 configs/j721s2_evm_r5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/j721s2_evm_r5_defconfig b/configs/j721s2_evm_r5_defconfig
index 1e66ac23d05b..e2b83b337809 100644
--- a/configs/j721s2_evm_r5_defconfig
+++ b/configs/j721s2_evm_r5_defconfig
@@ -42,6 +42,7 @@ CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_STACK_R=y
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x140000
 CONFIG_SPL_SEPARATE_BSS=y
 CONFIG_SYS_SPL_MALLOC=y
 CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y

-- 
2.41.0

