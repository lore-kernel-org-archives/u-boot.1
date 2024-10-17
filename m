Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596FED2F7EF
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 06:37:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25CBB88EDD;
	Thu, 17 Oct 2024 08:37:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tBGCGlv+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45E3788EAE; Thu, 17 Oct 2024 08:37:42 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60E0E88B8F
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 08:37:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49H6baI2002472;
 Thu, 17 Oct 2024 01:37:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1729147056;
 bh=7RGCZYvxiVGVbgQnyTymS44wLrD0JhEF5H7KqX8GS8E=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=tBGCGlv+Z4d5uoM6+87tLTpXIuO4PINEVDc4hTi2IvLyUYMoxBrBJ956aOj9UFQ5s
 83dQLPe6F9ldEkchva27Wi0OOcO7i4rS8G5lYO0hm3MG/w+sLsUmxZ0s4dRCS/Xx4O
 FAcemQajNs7NdcLOsEHO/bPWSRgrEpOPwx8UTpaE=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49H6baKs095269;
 Thu, 17 Oct 2024 01:37:36 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Oct 2024 01:37:36 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Oct 2024 01:37:36 -0500
Received: from PSDKL-Workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [172.24.227.91])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49H6bFOV090460;
 Thu, 17 Oct 2024 01:37:34 -0500
From: Aniket Limaye <a-limaye@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>
CC: <u-kumar1@ti.com>, <reidt@ti.com>, <m-chawdhry@ti.com>, <nm@ti.com>,
 Aniket Limaye <a-limaye@ti.com>
Subject: [PATCH 2/6] misc: k3_avs: Add OPP_LOW voltage and frequency to vd_data
Date: Thu, 17 Oct 2024 11:59:09 +0530
Message-ID: <20241017062911.2241167-3-a-limaye@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017062911.2241167-1-a-limaye@ti.com>
References: <20241017062911.2241167-1-a-limaye@ti.com>
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

From: Reid Tonking <reidt@ti.com>

J7200 SOC supports OPP_LOW and OPP_NOM as two Operating Performance
Points as per (7.5 Operating Performance Points) section in the
Datasheet [0].
- A72SS/MSMC at 2 GHz/1GHz operation must use OPP_NOM.
- A72SS/MSMC at 1 GHz/500 MHz operation can use OPP_NOM or OPP_LOW
  voltage (though OPP_LOW voltage is recommended to reduce power
  consumption).

Add OPP_LOW frequency->voltage entry to vd_data.

The actual OPP voltage for the device is read from the efuse and
updated in k3_avs_probe().
OPP_NOM corresponds to OPP_1 and OPP_LOW to OPP_0 efuse register
fields, as described in the Datasheet [0]
The register offsets and fields are described in the TRM (5.2.6.1.5
WKUP_VTM_VD_OPPVID_j Register) [1].

[0]: https://www.ti.com/lit/gpn/dra821u (J7200 Datasheet)
[1]: https://www.ti.com/lit/pdf/spruiu1 (J7200 TRM)

Signed-off-by: Reid Tonking <reidt@ti.com>
Signed-off-by: Aniket Limaye <a-limaye@ti.com>
---
 drivers/misc/k3_avs.c | 4 ++++
 include/k3-avs.h      | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/misc/k3_avs.c b/drivers/misc/k3_avs.c
index 99a18a109b7..9d950d034a5 100644
--- a/drivers/misc/k3_avs.c
+++ b/drivers/misc/k3_avs.c
@@ -501,6 +501,10 @@ static struct vd_data j721e_vd_data[] = {
 		.dev_id = 202, /* J721E_DEV_A72SS0_CORE0 */
 		.clk_id = 2, /* ARM clock */
 		.opps = {
+			[AM6_OPP_LOW] = {
+				.volt = 0, /* voltage TBD after OPP fuse reading */
+				.freq = 1000000000,
+			},
 			[AM6_OPP_NOM] = {
 				.volt = 880000, /* TBD in DM */
 				.freq = 2000000000,
diff --git a/include/k3-avs.h b/include/k3-avs.h
index 1014d5d114d..f6f1031c9cc 100644
--- a/include/k3-avs.h
+++ b/include/k3-avs.h
@@ -20,6 +20,7 @@
 
 #define NUM_OPPS		4
 
+#define AM6_OPP_LOW		0
 #define AM6_OPP_NOM		1
 #define AM6_OPP_OD		2
 #define AM6_OPP_TURBO		3
-- 
2.34.1

