Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0DACE7B13
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 15:02:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A286184105;
	Fri, 14 Nov 2025 16:02:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bl0VopAe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF24A84127; Fri, 14 Nov 2025 16:02:44 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62B8183F54
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 16:02:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZP4P8UiuqLfXnUALIdiN/PoQw1CQHNLDZatDjToBw+1eyp2UEDf2LN8G0oFSWYszWblsjAJhwOQr3bAr/L/vZBOzIyiqusHwnD11txF6BNOj5MMGcbA4qB1YiGRLlixWt48E8MB4Z8VRfbWn3fzKi+aPIIjm6ORY08Pqj6DPvrdyS0U17JxAS6w84qRdUDHHot74B1UmwP36XwQ4rnkm62kuWXzSkvdssATkZ/vZLvzHnXWJnSUcPIvPeveD/av3qdK7+bKrpJQTPeL57JDdiNTF+NECorg7J7dnYB/RSwPq3ncEYlCpUaMQMWnWiLJGSrZDH4OMboqkWw5tnZRFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sy3AvojDR+JFC4NronUdAvRE3uflfn1QGyf3qffjrH0=;
 b=k88oymO7IymTRIFlsi8QePlOOElnx8+EXu4WF+uSx3uTbTR/Cfk9HOK5hiSXvHEB7Oe24puDwqasjgvOzqfnAKn6mkZq7xPlEDWV8PPlpWXoNpax4V6qxcP/MPMtJw3nV4Utft0wyu/LBknhZFNJ6ux7UIu0iyvgfnInRqVVJSmkH0/pai/4+kHjLLvaDA/rUi3gsPMp+QeUQx2VFK5ABwluynhBm6D6cCNfdLXS3/2xor5JhHhTWsLGM4oPC6Cb/TektWaL03fnZaeQ1qnnQ2gCAESVZAIrbjby5Vr8A0jMHbo08KyqgPpnUcJMx0hkBFLz1JiDynUYG/5OuaoeGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sy3AvojDR+JFC4NronUdAvRE3uflfn1QGyf3qffjrH0=;
 b=bl0VopAeNylw/3EEwOhdN+O6vfJIZGD8CfHGtIaOiXKrhBTm+NFXPv2Y7fv98LrFsxLRYmrSHE0I2nSGO9Os1U1FmfFATmCXd+W6ZdoFJzcJU8edw6eJqmalJdNGbCj9uBhKnJAXY+mBfbAa1u8yc9A8l4gcTBz/mV2JWjlbkTQ=
Received: from SJ0PR03CA0201.namprd03.prod.outlook.com (2603:10b6:a03:2ef::26)
 by PH7PR10MB5879.namprd10.prod.outlook.com (2603:10b6:510:130::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 15:02:38 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::b8) by SJ0PR03CA0201.outlook.office365.com
 (2603:10b6:a03:2ef::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Fri,
 14 Nov 2025 15:02:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 15:02:38 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 09:02:31 -0600
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 09:02:30 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 14 Nov 2025 09:02:30 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AEF2ReM2204877;
 Fri, 14 Nov 2025 09:02:28 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <jh80.chung@samsung.com>, <peng.fan@nxp.com>,
 <u-kumar1@ti.com>, <afd@ti.com>, <m-chawdhry@ti.com>, <t-kristo@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2] power: domain: ti: fix ti_pd_get() to return after
 verifying transition
Date: Fri, 14 Nov 2025 20:32:41 +0530
Message-ID: <20251114150243.96429-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|PH7PR10MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b259f25-224b-4141-8ed5-08de238eda23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9R0LlkFFsdOlVpt0HKwQypV9G8cZOO+8SoxsoyFrxzGNCg+mdqxTA9MRvvt9?=
 =?us-ascii?Q?og4dJLjFAhUBVcjWHvMo05Js5YfKELyndyUJFNJI87Fkf6Y2pHTa347ncVRr?=
 =?us-ascii?Q?hYAQ9O436E8bMgz/CaHAvT/UjrRgy1PRXECtBsjQQtfnghWrycQXXymzBXsj?=
 =?us-ascii?Q?zZyJUGbla8UrYcDsoLcAM6NNQpXOcSTilb0bBM3oujhSDd2HXYUKS86swP5M?=
 =?us-ascii?Q?CxogOZ7CzQ29WmSvgd5AF7IZXbnNEGZt6PDfT1K5bgRBT4JBo/9eochanTjk?=
 =?us-ascii?Q?YIUkwbpiRmdUiD1sqLwLknhDkq3GG1sw0NfF5WvWaLn34nNzWn8mvWvPXwoz?=
 =?us-ascii?Q?Xw+xblhQEbSYlD4JBKDX7oqzGiJu20roHhxAVWU4B8xS32ZrPBVnsu7WufvO?=
 =?us-ascii?Q?GB7YDmVnQ7OFvvtG386jKYm/IBxDowP1znRvWVViN6uq9CGew8bVgM20eTx1?=
 =?us-ascii?Q?3fm/qStdJfJsQstF8R5cbM6rqL15AQ5Sbxcj231ZBqo+B2U1u5g0OxJgH1AT?=
 =?us-ascii?Q?6UXFQU8nX7A2T79+paePEU8qu0A/MZTJuHx7oTQM3l/k4C4gjuTiwWf2HAGx?=
 =?us-ascii?Q?J4ARj3BxG89IkTjBSdE2GA7/BXxO4+JjcZMnFsDhByifZ49tJ0dk6RlLZAv4?=
 =?us-ascii?Q?AaSBU8LtZOH8IVBtMb10gQX9/W0rQvLJ+m+oG7Nuf6wEZud3bQKp2K5ZZMq3?=
 =?us-ascii?Q?KqE81HWFszor8GU4+UPVj2ViMhMly1w9NlYoIGkYqmkXwfYuTcjmyVeCSHSG?=
 =?us-ascii?Q?whYjnJAQzcOTOpDtgYvsOU1d9jpy4hnOGDI4o7UbDGva2HB+ggetAL4gcUBF?=
 =?us-ascii?Q?JArL1RXb8zTXByQtUg9hwyherPpLrbml/kO+lANhmj+zINYX9lhjNBrFbXb3?=
 =?us-ascii?Q?rTifENgotdghMrzhhW1Uh+qE7QKAoQcYgnjz91EbgdxyIJiosdDIw5T6vB4V?=
 =?us-ascii?Q?KZb+tkFu36EwOL+DtA7SLYo6i/pom4wRKSLH7SWlxApk0ZJHg9SjwDHwUBiv?=
 =?us-ascii?Q?sDJd9/Da5mZhfRVURkVOV9UlQlj0esp94SA9cLM1kU/yy6nrpUA3oQyrAziR?=
 =?us-ascii?Q?8VOYoBbaTcq14SIutBXcAPyO9BRBaz2asoRoo58BT+lqlTgkA2wkg5aFF5xU?=
 =?us-ascii?Q?yqw9Kwv3XEZH3IsMficHKk2TKwDBlDwaspGgH9/kLC4GgiQK6UBHLMTdEIG2?=
 =?us-ascii?Q?JMTqR+YSU5cC6dPMz7WeH/txwbze6xdUIOiF3DiG6jbh07OmEDQu+siAdof7?=
 =?us-ascii?Q?75EoJ897v5K9R5/D6/ru9k6pY6i/wowcS/beJ4dx/8UjTsoKkk+nyWbqc/IX?=
 =?us-ascii?Q?/9cbIilDTMVvNynLlNegE3ncaonE3MZ7Yw3skM98NY/1a5VmQ3h3joFqzts7?=
 =?us-ascii?Q?zQs9Xyhzk8OQjcs+CnPxQmit9wHZHsHtl8/PhDpPtfG/pDi8dSmqBbBFTK5V?=
 =?us-ascii?Q?Q5wqT4d8YVEvnbbYXu3YD+klFUnd7qTC+/Sv48iUlqKYMQ3tu0u+wmsCeOeH?=
 =?us-ascii?Q?A9gyU/Y2SC6OK02YKduxIGv1wkMDtTZqVmQqRkATzoRo/yeZHpVkvRvtzEOQ?=
 =?us-ascii?Q?k98d1aI0rXswjrlTakA=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 15:02:38.4536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b259f25-224b-4141-8ed5-08de238eda23
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5879
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

The helper function "ti_pd_get()" is responsible for powering on a
domain if it is powered off. In the current implementation, if a power
domain is determined to be powered off - no prior users and the PDCTL
register indicates that the user desired state is OFF, then powering on
the domain constitutes setting 'PDCTL_STATE_ON' field of the PDCTL
register.

While the current implementation indeed requests the power domain to be
transition to the ON state, the helper function "ti_pd_get()" doesn't
verify that the power domain has 'transitioned' to the ON state before
returning to its caller. As a result, it is possible that the device(s)
belonging to the power domain may be accessed before it is truly powered
on, leading to a bus abort.

Fix this by waiting for the power domain to transition to the ON state
by using "ti_pd_wait()" before returning from "ti_pd_get()".

Fixes: 144464bd2c67 ("power: domain: Introduce driver for raw TI K3 PDs")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
6c2f2d9aa63 Merge branch 'master' of git://source.denx.de/u-boot-usb
of the master branch of Mainline U-Boot.

v1 of this patch is at:
https://lore.kernel.org/r/20251114114611.57032-1-s-vadapalli@ti.com/
Changes since v1:
- Replaced the following:
	+	ret = ti_pd_wait(psc_pd);
	+	if (ret)
	+		return ret;
	+
		return 0;
  with:
  	return ti_pd_wait(psc_pd);
- Updated the last paragraph of commit message by mentioning
  "ti_pd_wait()".

Regards,
Siddharth.

 drivers/power/domain/ti-power-domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/domain/ti-power-domain.c b/drivers/power/domain/ti-power-domain.c
index c3519307340..09d9e1b3159 100644
--- a/drivers/power/domain/ti-power-domain.c
+++ b/drivers/power/domain/ti-power-domain.c
@@ -227,7 +227,7 @@ static int ti_pd_get(struct ti_pd *pd)
 
 	pd_write(pdctl, pd, PSC_PDCTL);
 
-	return 0;
+	return ti_pd_wait(psc_pd);
 }
 
 static int ti_pd_put(struct ti_pd *pd)
-- 
2.51.1

