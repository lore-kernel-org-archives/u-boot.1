Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D10ED5AE71
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 08:24:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D6F989207;
	Thu,  7 Nov 2024 09:24:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="wZogzi8f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BE2C89231; Thu,  7 Nov 2024 09:24:12 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20722.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::722])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78E548921F
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 09:24:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMY5uXx9a6wFS+Nnjkya76JxbEJvp0KofuRXhvDjyAWXW/6fo1ss35MzT5WCeoBgRlxBAGnPLGgxU9dN8G7cdveWd1ukap9sTgtWqvsSWLZzC9XjwwfHndL+WKbNsktw/8KXHK06mlfSQa6zjVZaL4pndxOVzf0veru4o5HEk548E5MHsJCBLzCitJ48Esgh/SG6xSkBOEnLqSnzZsl6jyaVzl33FfyAd+30KfeoHNXbIpRlnI5Ra05t/0acB9iIGlRa8Pp04XClUVd6b6LOf8/lkOV/R1dFVGX2Qv33st4UEiTqQBRkOV8vpPVUXzDtmWiMICN8+u9CltjEtu7uvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJqmMmrE/idH4lY30r4OJ6CnQxfw4fLIdoPHm6C8cLc=;
 b=U1eRzuYNbZV4po868cYEqL5KuoHFSYXeP8bmga46Q8oNnXkYKmMB4taPmCy6jR4VdD0X2WF37EO1tHps8pf+MPjQZoWK/zzW0F07m1shJTPEKLQbOdkqOOuZQjHS/WOfr3a4IexuNW7692Scuzje/G/UbuKeJhmVSAxD+PBsOTXda+EdbIPRxL520lKd1AK26ZsmlAb03LaRZ/TB0WQ3sdr+lS+mL9VCKeowzypeaq1AzfiSiLtQ7hd0/KzULRraemvnjexEx+y3OmgsKsZDzLg4sq6cmBLSWYE+8dF/6oF77EncoMm7Hbl8b2IsXc25j4aalZqNzh9M540hnJxNKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJqmMmrE/idH4lY30r4OJ6CnQxfw4fLIdoPHm6C8cLc=;
 b=wZogzi8f4+tl7zuDR7bx1o+jK+eDuzEeieC/v776QFHcxarUcc+tM5OIoXbYW3OLpXFQE9Z2l51iag/gSWMH/5zY1sd/vtYLi05zf/ZsCkk9bjbVnblC3m3T9vVRlokWEk4EMzVkVaEb7C7Bv/e3lJqmJoBu28KMKasrZ8ZgWVA=
Received: from DU7P250CA0004.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::19)
 by AM9P195MB0823.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 08:24:05 +0000
Received: from DU2PEPF0001E9C4.eurprd03.prod.outlook.com
 (2603:10a6:10:54f:cafe::2b) by DU7P250CA0004.outlook.office365.com
 (2603:10a6:10:54f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 08:24:05 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF0001E9C4.mail.protection.outlook.com (10.167.8.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 08:24:05 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 7 Nov 2024
 09:24:01 +0100
Received: from lws-moog.phytec.de (172.25.32.77) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 7 Nov 2024
 09:24:01 +0100
From: Yannic Moog <y.moog@phytec.de>
Date: Thu, 7 Nov 2024 09:23:31 +0100
Subject: [PATCH v2 4/6] phycore-imx8mm_defconfig: add optee load address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241107-phytec_imx8m_optee-v2-4-bbc3747a60e8@phytec.de>
References: <20241107-phytec_imx8m_optee-v2-0-bbc3747a60e8@phytec.de>
In-Reply-To: <20241107-phytec_imx8m_optee-v2-0-bbc3747a60e8@phytec.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP
 i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
CC: Tim Harvey <tharvey@gateworks.com>, Manuel Traut <manut@mecka.net>,
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>,
 Yashwanth Varakala <y.varakala@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.1
X-Originating-IP: [172.25.32.77]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C4:EE_|AM9P195MB0823:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ffe054-689f-46b3-92de-08dcff058b4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUIzVVhxRmFncHh0aTNiTEtvdGtoZnRZbEt0OHlOT3NIcE1vVUZSQTMyRGpn?=
 =?utf-8?B?RXpxY0JWOFQ4ejdmamFkdWwvQnV4L1JMNENmQi9LcnJUNEZGMkdleTFrY2VH?=
 =?utf-8?B?TndmZUxVRU1CbWtQUVE0YWJUdzVrZnQ3NDNJMmErazVZaUJmWDJUd0M3Y1pU?=
 =?utf-8?B?d29Id2NSSkFEM09VeUZ5VnM5bjkwY05GamxTcXRFRzZXRzBLcXBTdzQxVTNj?=
 =?utf-8?B?U2YzWTNoSjFDbVlKVXZOVEJwd2RJRVNRQklhR2hzalIraXltY3M0N0Q5NVNM?=
 =?utf-8?B?VmtZR3p6R3BBRmZVNVZhZXViWnN0eGhnZFhXRWVPNGN1azYwM1lGTk91TWhS?=
 =?utf-8?B?U2dyNEVhQ2tVNTRBUkxtaWVMN3BXU3E2TEc5b2hHZENtV2hWZzY0Q09sQ0JF?=
 =?utf-8?B?TWkxM0VGeHZkWU1kaURGU0xVSnRsUENxckkyeTdDUUI3RThyU3FMTkZIYmp4?=
 =?utf-8?B?WWZkS0VFOWlPZkg5S216RWdPMXEzTk4xSFBSTENoOHBmYm9zRk1xd0t0UjdU?=
 =?utf-8?B?NVRxc2ZsWUFBajlDS1psR0h4WmJRTnpDeUt0aGNUN0s3RkxSbUZWUUhZclNk?=
 =?utf-8?B?R1gvcnlmQXc5ZVozQTdQL1MvN1JveVpBN0p1Wi9BZ1dMUFlqVldWZWRwV0RJ?=
 =?utf-8?B?L2FPN1lpZTI2VllPY2NuVnM2Y0NnY1VaVVlkZWE2citIWkNzZVFFSk80Y2dx?=
 =?utf-8?B?UmtsTWs0R25sUWFSeno1TWE2UklLKzE3MVVBQ0E0NXdIS05IMjY3WjlYeHh5?=
 =?utf-8?B?QmpEV0M1N1QvM0VGcTdHdktZUGs2VVlpVU4zOUUydUd1clB0SzE0b0JEdlpU?=
 =?utf-8?B?TFpjUzdPL1F2V1pQM0o2dVp3N3Jia1RPaFR3Yk10Q1kzTXVrZ05weDhuUWdl?=
 =?utf-8?B?VHJwZVhkY3VKOUlEbElvYWU2aXpMTlphOVdzbXdUQUlhbncvMzF0aStoSkZy?=
 =?utf-8?B?Y1ZjUHpGQzBEdllFbXRFZ2hFc05FWVRlYkRJRDNKdkk2d1dGV2s4a3lpSGZH?=
 =?utf-8?B?eWJab295d3hoaWpVVnkralIwaFdmMnArOEdnSFJFcjhlK2hGdTlNOSt1QzVF?=
 =?utf-8?B?Tm9nbVUvQmxDTDV4UjRHbTlUZ01QUUxzeUc2bm9xNC9ZakRUdDJXbzcyaERy?=
 =?utf-8?B?RVlPS0Vsc2w3ZUdCQkxUaFZIdEFZcjBGd2tFVWdlZUdVWTdwdWVlVnVreTU2?=
 =?utf-8?B?ZmNpYVNJYkI0dTN1Z0NwQ2RIb2FpRWQ1QS8xYVRYckoycHlURUZER212a3Vm?=
 =?utf-8?B?TFhiNHVKMml0SUhid090c2hVU2JlS01RTFVXY3RwTWFVd3dONjk2Y20yMkxT?=
 =?utf-8?B?cVBSYnowWkQwUWRJQUw2NXd1VnluMVhuS1lBcVdHQy9seFNWOFkxTUZhdVJY?=
 =?utf-8?B?YjAycUQ5Q3RuRmpaNnpIL1prbUdERDRCNmtmSFExOCs1T3pVckdubXcvQUJZ?=
 =?utf-8?B?bGdlakdDRkswMHVNeVVLSzZlaGlLbTk4NmFIeFp1dnFYdXU0bk0rS3B3R05R?=
 =?utf-8?B?QjUra3BtRE9PWTFaalpGWVkzMVNVY3VaQzBad0dKTVBGRjljZnMxclVhVEdY?=
 =?utf-8?B?M0Npd3dlS3ZPMHdvS0kwM2lNK2Q1dGFQR2tGbE5UbUM5dlYvWGx6WVdFWlR3?=
 =?utf-8?B?TDVzQjBiMnpyRmVQWU1NRUpTaVRqMmpEdDBqaFF1amFpUGhCLzJFSFhVcVQ4?=
 =?utf-8?B?ZGZma1JzMWRnOFBpRWs1VzNCVEFwdDZSRmVpU0ZSZ0lmVVRnMTJSTUNpOUNv?=
 =?utf-8?B?MkdEVUQvQnlGelgzMzhCUUVsRjdMOExaeUNRS1A5MGV5RU95Zld1RkNIcWNp?=
 =?utf-8?B?cWdCQ29MdnVhRGptc3R5S05uTHF4aVl4WHdZRTJCRGZQaVFWL3BVZWl4UjhL?=
 =?utf-8?B?QzBiN2QrNXdIRGRFZnpTYjZlT0paaEtyd2NrVHAwdzI3M1E9PQ==?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 08:24:05.6048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ffe054-689f-46b3-92de-08dcff058b4b
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9C4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB0823
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

The phyCORE i.MX 8M Mini expects 0x56000000 address to load optee.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 configs/phycore-imx8mm_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/phycore-imx8mm_defconfig b/configs/phycore-imx8mm_defconfig
index 48a0c0b8b4e..240b5f75a98 100644
--- a/configs/phycore-imx8mm_defconfig
+++ b/configs/phycore-imx8mm_defconfig
@@ -5,6 +5,7 @@ CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_IMX8M_OPTEE_LOAD_ADDR=0x56000000
 CONFIG_SF_DEFAULT_SPEED=80000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x3C0000

-- 
2.43.0

