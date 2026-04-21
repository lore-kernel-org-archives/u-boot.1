Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86755F8FA6E
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 12:38:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEECB84348;
	Tue, 21 Apr 2026 14:37:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hqR0BUHU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F31F583FFA; Tue, 21 Apr 2026 10:37:12 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCD358441A
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 10:37:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j-keerthy@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IwkicW5DjsgeBNoz9rkBkmudKFG3qdef4IVgE2fKIuAaEtSHsgGiLFH8RBoAk6TgoiXBsltXfFnzZA9x3AE1Idn16y5/5GidyVqxBGobc8eU/v759wEGVJTfdDB5yz9NkAGS+zNJ2OGKB/jxWM0Ybdfs/yg1q9kkl6qpZXhIOGUhTvvj5qeqEOoQ5IbDuguPCW41n+fpf8jWHipXKs3nK1NqEylNVZJvXMUqmEKzjqUA/7Zq4tyXp68j0y9FkDv7oSo1KsqIDthMD/htO8GRcCXtLXst1t7hLFbFDlJH3d6EQhu5cTNDE/SLiUFvichXZS9PpmxkNduGHWEobfNUiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4WgQXV7Zoe5eQOWIdg3YGsvisdjdj4m31N1dbDcF/8=;
 b=QpptYC8RWmLLbHxpbTsniuSn/GY93GI9ZW61jKs1Hi1z2HVDch9RsIXBRNw7s+d4esiE1FCoXzKILiABVO7taQk0bAZ9gPV3teggT/TLpoiyfU7Er1QBGIt007sH9bY2LnuFGJZMP+KdpO3/FmFErHoN5324Nsvy2qxnImskWT+8lD+1/Hj7kafGqOjHcXeamcpcePN19g+OLrlhXabZme2+HysUIQnqFHPj2fLZehjU2V8HUo5+tA4WEjpdJS3JvEPa4wg0VrM5XovUsI2f3aQyZ3WznEdhkbR9HmONi7aoDU02C++GL5vEDXu9cja0NsI5dkwaRFbRMGyKmjIr8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4WgQXV7Zoe5eQOWIdg3YGsvisdjdj4m31N1dbDcF/8=;
 b=hqR0BUHUy6cRUhzCtsXgo1s6ARcmEQ0QQBFj5aD/8Ics53srSHsScLZT0VZDCNkilIGBnBMYq91+atoJof5L6PGuJJnfLNWjwSeD1QLMjAYb58yGusY4Uc8URJpD87ztNCVisfESPa6lLCrshsy8pHamgC6VxoJQRCLYRbKcxDA=
Received: from SJ0PR13CA0078.namprd13.prod.outlook.com (2603:10b6:a03:2c4::23)
 by CO1PR10MB4530.namprd10.prod.outlook.com (2603:10b6:303:90::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Tue, 21 Apr
 2026 08:37:06 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::15) by SJ0PR13CA0078.outlook.office365.com
 (2603:10b6:a03:2c4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.15 via Frontend Transport; Tue,
 21 Apr 2026 08:37:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Tue, 21 Apr 2026 08:37:04 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Apr
 2026 03:36:47 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Apr
 2026 03:36:47 -0500
Received: from DFLE200.ent.ti.com ([fe80::196a:77c6:79dd:9856]) by
 DFLE200.ent.ti.com ([fe80::196a:77c6:79dd:9856%12]) with mapi id
 15.02.2562.020; Tue, 21 Apr 2026 03:36:47 -0500
From: "J, KEERTHY" <j-keerthy@ti.com>
To: "Francis, Neha" <n-francis@ti.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 "peng.fan@nxp.com" <peng.fan@nxp.com>
CC: "Fujiwara, Takuma" <t-fujiwara1@ti.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "Kumar, Udit" <u-kumar1@ti.com>, "Gujulan Elango,
 Hari Prasath" <gehariprasath@ti.com>
Subject: RE: [PATCH v2] power: regulator: tps65941: Enable FPWM bits
Thread-Topic: [PATCH v2] power: regulator: tps65941: Enable FPWM bits
Thread-Index: AQHc0WfmVlic62VhiES0QT20pL5gs7XpMMQQ
Date: Tue, 21 Apr 2026 08:36:47 +0000
Message-ID: <258e3c7ea96443feaf33ade5ef072c3b@ti.com>
References: <20260421082145.824453-1-n-francis@ti.com>
In-Reply-To: <20260421082145.824453-1-n-francis@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.24.18.107]
x-c2processedorg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|CO1PR10MB4530:EE_
X-MS-Office365-Filtering-Correlation-Id: 97be47f4-2785-49cd-6904-08de9f812a83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: B53tez34LiJo/kQ+P+bD4BxT9SelR+5ShcMnAcObh62/vBmHqObUJApZRcwfdVyAt8Y5xIiwS/6ZaC1ppbXlPRdExuhiMTqhmGCDyqofabiPm0vE6adck4M7ETNwo+SS0cQ7AmrXBUEINcz3Nv57UwslvUW8GapLGFzkkoUFc2slnx+fu3mrtNuNB9lIliulO17F4CXdgQeJDlqcprnpiMhsXe2ex86z1Fq11uzzkmr+kJRl5sz64iyuuy7NyOxfl7P+jV8IzaSjBGjn82twPt0Dj5A8oFx7k4R8ldO3x29OW5RLtCk1WxQoRugMpsJ4QnKfnvXDnu0cb9Cay5E3t3lwm+FHnxEg+3+fp7ARWLagyJQaPoSPUFVXCzSG45oDSRicvEln0RYh78X6UIuWHTJB1rQWU+O1jkk4WMFkqSgDemit4Cs35P192xsxK08pEVegrAi+4dlkT8JIVbnBcU8iUGjvgsa7fwYf/qPAgVYZUkFjzEl85eVA7/KwG+FbXmTiMJ1RZtRp7+tjDSdsdYmd6U20RVXTurvvOF6Sin4jmqhmGt5qTaGJh2j1/y13O9ehS1I6ZpyLjt7Hjp0BKRZhu4Os12mcfI5vU9UbfDrQkPySamgG0FyR00RxjH9OR+oFY1zfVZ6UdyYmHWnRIzGZ8UEnE1TPVYI+FvpfuizuTWZEJSg8eyv23ohNBqcZcj1ndtHeOkWHp7evnLcYkOkoUXdRm9GJ0+QNDGLtMok=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mDJpU//qAmCV6oFYm387tpG+IDNaTJtHFNwR7opP1ULGM0YKfSbIg3D8uBK+G4s1PVQo2NePYxj+DU8WJ3zYYMsvVheNnyqJ6BEA+sxuPdfpnKE8uSDvrk0vHK5ThxZwBvKzU2KjX/QlKo2VSUsgvea1GSvbhOPHnkbPYBxxa4X7fWsPQ/UZUj2dOhrXdAaJwQn7Gjq3VS4d9jF4i2iHfi0xzArRtq1T5gfWMk1zMwYUKTkYZMce6f6UPboyOgXZoXXw+DO5mq7j/L8554pfAUHaakXy5qhJXG3xg755+xYEXTzoBlEL9KNDd+cHCHrYXiAQG67MtzqAp/i7EX/RRAJNxS7d9/IL8UFLp3svKa17R7kwrDz26d6CMOpef7ac0I8iyaVGWOG3XZzXYYj+QrscAc/9FU6KCY473d0zsyM9ljQrnwU5KtW55+N/3g0U
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 08:37:04.4586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97be47f4-2785-49cd-6904-08de9f812a83
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4530
X-Mailman-Approved-At: Tue, 21 Apr 2026 14:37:42 +0200
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



-----Original Message-----
From: Francis, Neha <n-francis@ti.com>=20
Sent: Tuesday, April 21, 2026 1:52 PM
To: trini@konsulko.com; jh80.chung@samsung.com; peng.fan@nxp.com
Cc: J, KEERTHY <j-keerthy@ti.com>; Fujiwara, Takuma <t-fujiwara1@ti.com>; u=
-boot@lists.denx.de; Kumar, Udit <u-kumar1@ti.com>; Gujulan Elango, Hari Pr=
asath <gehariprasath@ti.com>; Francis, Neha <n-francis@ti.com>
Subject: [PATCH v2] power: regulator: tps65941: Enable FPWM bits

Depending on the phase selection (single or multi), the FPWM bits configure=
d forces the regulator to operate in PWM mode. In case of multi-phase selec=
tion, the FPWM_MP bits enforce the regulator to also operate in multi-phase=
. This fixes correct multi-phase operation.

While at this, correct incorrect macro alignment as well.

> FWIW Reviewed-by: Keerthy <j-keerthy@ti.com>

Fixes: 065a452ae6a1 ("power: regulator: tps65941: add regulator support")
Link: https://www.ti.com/lit/ds/symlink/tps6594-q1.pdf
Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Takuma Fujiwara <t-fujiwara1@ti.com>
Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
Changes since v1:
https://lore.kernel.org/u-boot/20260129072857.1437272-1-n-francis@ti.com/
- alignment correction
- used existing macros instead of 12, 123 etc.

Tested on J721S2-EVM (same as v1, no logical changes)

https://gist.github.com/nehamalcom/a74fb2a3b59421d0e04693c7d244fdb4

Before the patch, the kernel TPS6594 regulator driver would warn about over=
current on a buck, this was due to incorrect multi-phase configuration.
This patch resolves it.

 drivers/power/regulator/tps65941_regulator.c | 15 ++++++++++++---
 include/power/tps65941.h                     |  4 +++-
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/power/regulator/tps65941_regulator.c b/drivers/power/r=
egulator/tps65941_regulator.c
index 2561d6f4c6c..209968b5718 100644
--- a/drivers/power/regulator/tps65941_regulator.c
+++ b/drivers/power/regulator/tps65941_regulator.c
@@ -63,13 +63,14 @@ static inline int tps65941_get_chip_id(struct udevice *=
dev)
=20
 static int tps65941_buck_enable(struct udevice *dev, int op, bool *enable)=
  {
-	int ret;
+	int ret, idx;
 	unsigned int adr;
 	struct dm_regulator_uclass_plat *uc_pdata;
=20
 	uc_pdata =3D dev_get_uclass_plat(dev);
 	adr =3D uc_pdata->ctrl_reg;
=20
+	idx =3D dev->driver_data;
 	ret =3D pmic_reg_read(dev->parent, adr);
 	if (ret < 0)
 		return ret;
@@ -84,10 +85,18 @@ static int tps65941_buck_enable(struct udevice *dev, in=
t op, bool *enable)
=20
 		return 0;
 	} else if (op =3D=3D PMIC_OP_SET) {
-		if (*enable)
+		if (*enable) {
 			ret |=3D TPS65941_BUCK_MODE_MASK;
-		else
+			/* Enable FPWM */
+			ret |=3D TPS65941_BUCK_FPWM_MASK;
+			/* If Multiphase enable FPWM_MP */
+			if (idx =3D=3D TPS65941_BUCK_ID_12 ||
+			    idx =3D=3D TPS65941_BUCK_ID_123 ||
+			    idx =3D=3D TPS65941_BUCK_ID_1234)
+				ret |=3D TPS65941_BUCK_FPWM_MP_MASK;
+		} else {
 			ret &=3D ~TPS65941_BUCK_MODE_MASK;
+		}
 		ret =3D pmic_reg_write(dev->parent, adr, ret);
 		if (ret)
 			return ret;
diff --git a/include/power/tps65941.h b/include/power/tps65941.h index a026=
ec56958..78e48a15972 100644
--- a/include/power/tps65941.h
+++ b/include/power/tps65941.h
@@ -19,7 +19,9 @@
 #define TPS65941_BUCK_VOLT_MASK		0xFF
 #define TPS65941_BUCK_VOLT_MAX_HEX	0xFF
 #define TPS65941_BUCK_VOLT_MAX		3340000
-#define TPS65941_BUCK_MODE_MASK		0x1
+#define TPS65941_BUCK_MODE_MASK	0x1
+#define TPS65941_BUCK_FPWM_MASK	0x2
+#define TPS65941_BUCK_FPWM_MP_MASK	0x4
=20
 #define TPS65941_LDO_VOLT_MASK		0x7E
 #define TPS65941_LDO_VOLT_MAX_HEX	0x3A
--
2.34.1

