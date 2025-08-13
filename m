Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB50C87FCF
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 11:55:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C00183599;
	Wed, 13 Aug 2025 13:55:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="dnbw7vqE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CBDA831C5; Wed, 13 Aug 2025 13:55:01 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2072a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::72a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE5FD831C5
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 13:54:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HXg5WAYhqqCG1MAKh6j1KJ0WoQizJfbqXJyBXXBC7HF8rP+OgAHKzVKoyqkjyux70GcHoMAyHfaT/7tI3DiDFFJzcLpe6CMtDkvB260PJ+cu5KLLMeY2vNs+P4tOyazXTWNAP/Ifi1IuJd9yMMQN+d3TxdtLhCJCwPALM6gIjhmHHbJ/UpLKcqRqEnTo0VulLnC7Cn9jzZRGqTzi4QX9XkI4ZCyiPAX+ao2toSF+zhCL8abnlxvhQ668u9im3TuRVWz/wvnvONcyCy4VCislbngYOs7Xfz5HS7W4c0tUm2vf6ehs9d0EnFhx7BeYtmNPlgET/rW5vWX/txoTF3T3rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smKTO2v63fWToNcSatV2Wme1FraoSMH/J9XwMAZscO0=;
 b=Ba/yF6WGyhvRSCxcIqgz4TB64NTw5ZyT8E6q+qSk0F2uYEYClR3VnJiLWgd4U031Ma99FpTR+pC18dsGi5OFk5+YGiKCH3X1421I4O/ITnVDtrSCzoaS5L/8ZcDfHB4IA5wZsWXy+eSwQDkDP2Ef0aewcDzNqi+sIIXVdmGtZ4cIBTCf2s3voffcw/ty4Rdt5goTdYfhLdB1OCn+Pn1VzmmaMwFnxJ3hwN/X/Fc+6dz1sF63tegsrxddP3fMecOnqIaFjO1HN68qhTvJc2EAAe6SSu1cNUsYJLyMsHP6h7DYyij2Ktt+W6z+6fre9pylr9CzsszAvlhs1x1cd+GeXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smKTO2v63fWToNcSatV2Wme1FraoSMH/J9XwMAZscO0=;
 b=dnbw7vqEQskpowlFbjCSc2Gpka+O9/t7NcoQtvKKgrBG4qR79VeUTZL5BgxySLlEZPSphoeC38zXEA+l6Z3j7esmxBxF/MXXBosb7En47h78x9Nn6jx9E5yDti9eYe6VCTE21dHMO2qhGO0TBw35a3IY7BwAb/whcT6tp8dp35KdzdRuv4Xt3K+liXMbxx6d4kt2VDNPlVVS9oOncSU5ytZX4zO3kC+OO3pfbv0gfGdjwXIy44VSSgnGuo3gJoswFooDIiUFA3mn9eysvCghL1sO5Z29S7AfIKxYM/n1x61nViKHnq3D9lV1yGw6jCNyv5gTlwTubWdXIw3a24zBEw==
Received: from AM8P189CA0005.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::10)
 by VI1P195MB0704.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:15c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Wed, 13 Aug
 2025 11:54:56 +0000
Received: from AM2PEPF0001C710.eurprd05.prod.outlook.com
 (2603:10a6:20b:218:cafe::f5) by AM8P189CA0005.outlook.office365.com
 (2603:10a6:20b:218::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 11:54:56 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM2PEPF0001C710.mail.protection.outlook.com (10.167.16.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 11:54:55 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 13 Aug
 2025 13:54:55 +0200
Received: from lws-schwan.phytec.de (172.25.32.54) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 13 Aug
 2025 13:54:55 +0200
From: Martin Schwan <m.schwan@phytec.de>
Subject: [PATCH 0/4] bootstd: rauc: Fix segfault when scanning device with
 unsupported layout
Date: Wed, 13 Aug 2025 13:54:04 +0200
Message-ID: <20250813-wip-bootmeth-rauc-priv-free-v1-0-1ef928169469@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANx8nGgC/x3MOwqAMAwA0KtIZgO1UileRRxqjZpBW1J/IN7d4
 viW90AiYUrQFg8InZw4bBlVWYBf3DYT8pgNWmmjbFXjxRGHEPaV9gXFHR6j8ImTEKFurPZNbYx
 TFvIQhSa+/73r3/cD0zrGp20AAAA=
X-Change-ID: 20250813-wip-bootmeth-rauc-priv-free-2682c6355a08
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Wadim Egorov <w.egorov@phytec.de>
X-Mailer: b4 0.14.2
X-Originating-IP: [172.25.32.54]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C710:EE_|VI1P195MB0704:EE_
X-MS-Office365-Filtering-Correlation-Id: 49fdcc9e-e419-450a-dc9a-08ddda60389d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnpRZDE2NVFueW9CSDBUZlNoVWQzcTJsdk84OXFRQ1ZjWURaU2JjMXNpem56?=
 =?utf-8?B?UmVQa0s1aUErMWpDTnh2TndpbWRpcmQyb3hMTnZ1TjJtK29NWS9uaU5KazU2?=
 =?utf-8?B?VzRack1LdzJnVnV3bzlJaU5RZXF6dURtdTFaa3pveHo0VDk0NUJDZUo3RWtw?=
 =?utf-8?B?dG9CdFdLU3JlSFhDUXhBUHFmS0NsNWlMTE4zSUZYektvZzlxMWEyME9GQUJw?=
 =?utf-8?B?dkY4LzVkNit6UndKRk5CeGtpMERoY0FKQzRCaFpUb3hWTTdjSEt2NzRKWmtv?=
 =?utf-8?B?NVVZdDBjQTFadmdiMWhweFVQZ3VQMXl3bFpTa3pBcVdHSjdwdHdKNUI0QXpR?=
 =?utf-8?B?d1d5b2tuTjFoMGJUcmtQa2RaUEVuK1c3RlA4TVRNc25WU3pNa3RjRGdwZnRR?=
 =?utf-8?B?aXVhNFNxeTBVZ0tmRW9rOUk4ZkwwVkQ4RVJ2T3RYdG1heGlOK1BTTmVZaDM0?=
 =?utf-8?B?b2YrVEtSMTIwenZxTnVqRUlOTWZvV2xIcTYxR2FCZGdUaWR4aWJDMTF1T281?=
 =?utf-8?B?bVZkc3hCam5hUVdqbHUzb21vM3FKUitqNFQwWm5GeGJINmVkUHA0NzM0QW1o?=
 =?utf-8?B?bXdmYy9WeFFiUk93eEpZVDU4NWJ3U3RucFBjWnBWc2NRUC9hU1VrcUZGbzV1?=
 =?utf-8?B?bmZQRlQwcERZeGF4NHluSjE5bFlxd0ZXQ3lBcTN1ODRQOE5OakF5anFOU0Fh?=
 =?utf-8?B?eWFjRk5Vd1A1d1NwRTZIZmk4SmdxNWlzQkdVbmNnMVhtbnJPZnlLSnRGZHpl?=
 =?utf-8?B?MUxBNzZYVVNaNzJOUmVxN2c0L1QvQTNrS2Zpa045R0lGTnpuOVc4TitnZWZx?=
 =?utf-8?B?cEhJOSs2Y1p6U0N6d0VIc0wyTFRTTHJLUGVTb3VCc3REcHQ4NW5vaXM4T1pw?=
 =?utf-8?B?N3lybEl5cVJMbmhEOVZ1YU5VV3FQbm9lWENKTzd6TXZ0MzNwT0NXcHV4WGJs?=
 =?utf-8?B?V2lNeXd3Q3lFcjhxUVpnTWVHbmh1U3A2aXlneS93MHV4a2JzUUliQXBDMWp6?=
 =?utf-8?B?MHZrYjJvQTBjcUlRNW1FY3BJU1JDRzdUOWNCKzc4VFREalY3R2tWTVhYUDhP?=
 =?utf-8?B?dFVCcDVFK0s5YVhDd3g5bkNQNTVsV2dEd0gyQmtRalo3aHFWdmtKbXM2bC91?=
 =?utf-8?B?THpaUFhzQlhLdHlHd1VNbHcwYU1KM1ByZzdKN0FLSjZVNy83QTFhSTUxUVNP?=
 =?utf-8?B?NXRGSGFOS1Z1eFVzNnhLQ0IzVVkyL1RoRnBlRnMwRXl2MlIrbjlQMGh5Z2pL?=
 =?utf-8?B?bVlDMnBYRGcrcnUySWlSMmMzYmlOcWpjSklmY1U5cUgySXNsVWE0cWZHOEdo?=
 =?utf-8?B?UTVzcTRqdDI4cXRXRXNMMlE2MHl1NU0ydlpwWjJpY3l2Y2plemU4dnVKU0Vj?=
 =?utf-8?B?TmwxQnYyUjNQVG13YnRqSHM1bVpIbVdSSFk4S3o0bEJRT3B3TUtmOGpCQkIy?=
 =?utf-8?B?YjZENVVpZEFzdFFna1JqanlJK0JGL21WSEtneTRkS2RQZVUvcHNTNnhzZHFo?=
 =?utf-8?B?SEUrUGF4MzVLZlBuM2NMM0tqOUtPcEhzSWhLbVZ3Rm5NL0lyTkJGVmpvaDlS?=
 =?utf-8?B?aWxDVFg5OExpS29LNkdtb1NRVjNxemVaWWd3UmZCYlRFaTE5cUJBZElsSjF4?=
 =?utf-8?B?SVJkYTA0NDNBRmV0NlFsVElXUTA5dThZd2FVUjMxMmlLbkZWM1RJd1R1US94?=
 =?utf-8?B?ZEVpaXZySUsyTFloVzUzczdHMEtyM2ZaREM2L0RiTzZodWNQcFF6QUg5c1ZX?=
 =?utf-8?B?bndTTDlEUnorM2I5a1JrcmNQVmtFTFRvNGJpejNxWldmTEdmV2pCQzFobmhR?=
 =?utf-8?B?TUd6a0NiaVN2ZG5saWlZcCtJcGxVdFRURzFrek1xcGZuQ2lNSTk3UlpLWlo1?=
 =?utf-8?B?dkVpRlZTdC9jNitITDVhZDJXa0x3QkdkRTZEZzVTUXlkVUV3Y1d6bUZGbjl4?=
 =?utf-8?B?VkRpM3c3RzU5bVQ5dlF6Z0wybFRNTlJ4a1ByN1ZJTk5sRW1oM0VKbVdGQitV?=
 =?utf-8?B?UjZWMjNtdm1jQllnYjVwcFhQUjljSzAwbjRTTGFZL0R4RW1HektnSDE4RG5P?=
 =?utf-8?Q?4unfDs?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 11:54:55.7635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49fdcc9e-e419-450a-dc9a-08ddda60389d
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C710.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P195MB0704
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

This series fixes a segfault, that would occur at the end of scanning a
device, which does not contain the required partition layout scheme for
a RAUC system.

With this series, a "bootflow scan" should now correctly scan the
specified devices with boot method "rauc" without crashing on invalid
partition schemes.

Regards,
Martin

Signed-off-by: Martin Schwan <m.schwan@phytec.de>
---
Martin Schwan (4):
      bootstd: rauc: Fix segfault when cleaning up slots
      bootstd: rauc: Don't null bootflow->bootmeth_priv
      bootstd: rauc: Move freeing private struct to its own function
      bootstd: rauc: Free private data when booting

 boot/bootmeth_rauc.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)
---
base-commit: acfacf452441d0a659e3afbd55fd6061aa17e647
change-id: 20250813-wip-bootmeth-rauc-priv-free-2682c6355a08

Best regards,
-- 
Martin Schwan <m.schwan@phytec.de>

