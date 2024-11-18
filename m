Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D76D4920C
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 10:58:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67FDC89438;
	Mon, 18 Nov 2024 11:57:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Nz3bm8+H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2615489438; Mon, 18 Nov 2024 11:57:31 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C484689468
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 11:57:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AIAvR4p001741;
 Mon, 18 Nov 2024 04:57:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1731927447;
 bh=cYPhfFWcfljL84jy2QEhvW0ylu1RIfcr2OyzWjGMvcI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Nz3bm8+HtF5urQm+GZxeRNT20P6arxHrDX+RAh4VRXKpqPqQmuD0Dpjz1OnLm0YqW
 LM0GYEpw5T0Ty/4b6yIXFAdCm0c8vPzSaHh3ydthV/tv1UU5oLJl/wXmXj3eJUp2on
 pshTIH5Zkr4f8KS9UOEiOyExGV5kktXQgGkkeH9U=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AIAvRiJ012960
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 18 Nov 2024 04:57:27 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Nov 2024 04:57:26 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Nov 2024 04:57:26 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AIAvETV051199;
 Mon, 18 Nov 2024 04:57:24 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <m-chawdhry@ti.com>, <b-padhi@ti.com>
CC: <sabiya.d@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 4/5] configs: j784s4_evm_r5_defconfig: Enable AVS
Date: Mon, 18 Nov 2024 16:27:13 +0530
Message-ID: <20241118105714.1973573-5-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241118105714.1973573-1-n-francis@ti.com>
References: <20241118105714.1973573-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Enable AVS support on J784S4 along with regulator.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 configs/j784s4_evm_r5_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/j784s4_evm_r5_defconfig b/configs/j784s4_evm_r5_defconfig
index 0b5441fa023..0a55f75bbe5 100644
--- a/configs/j784s4_evm_r5_defconfig
+++ b/configs/j784s4_evm_r5_defconfig
@@ -145,3 +145,7 @@ CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
 CONFIG_PANIC_HANG=y
 CONFIG_LIB_RATIONAL=y
 CONFIG_SPL_LIB_RATIONAL=y
+CONFIG_K3_AVS0=y
+CONFIG_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR_TPS6287X=y
-- 
2.34.1

