Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474FBE77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 12:36:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 286DF80602;
	Fri, 10 Jan 2025 13:36:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="J5zJsbf4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F6A180691; Fri, 10 Jan 2025 13:35:59 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20727.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::727])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13F4D80613
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 13:35:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljEw4dlge+Bklge4KCctIteLALCU/HGNedvfhf2wlrQY7dBVUcNAJWKZi0y7h4VdXGbdGB4OZLIXnek82GvFw9ZOUt00TpKRrEjiULsbNdrC8n3/XJ2iGoN61P/sQzVzjyVI2p1U0UhJsJ/jTwBo5cVTKHT+l4UHtSyZ4CxZnBGpvH0/uaR5YL34p0KtaNj6j9qjrT4WUcIXCC9lEGf1cJGdP9gIerbcdwMVSswf5HRsmHKWNva4tBMA3LnyutyjATi6dMjV2x+z7tZ4ufwbswsm9+TO8vOX+chs4rwJ6HykkbbuSzQBxxVUbty6hGArUNczlAzi92T16A7yfh1FwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItWda/hRuzvY88p5BkXwtRDvKC++Hm3/zXDVqESS7p8=;
 b=Q49jByiPfZL5jtINHvZDgM0bcGZk9o0cywQx41W4w1kVbvMcGZaqx+AAlfoOsE6dm84lY1laiOCPpy9uVIxjwUr2C+OppDXEdR4p2kF2UKogMg99e5MzKT5Y4cjxICIt0R9YjFDXtKTsiDLJ2Tq5UZBAyzPCqHA83gg9+19e7gAY8LOk4Y9WKiA8cskjtjZiyCzvvPWmUYs58h17A2Q6fa8GupScNvazEwQSOPQ0r5SOdB9iAUhsMytp2xJe98GK0SxkHjg0MaYKeQ8RMzqyNVMON/tP7iAJfLb/FrKAsQaIEuHwNDT8UyEISYVZawj/nmjyGvF/vHu8XHX5pirZ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=gateworks.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItWda/hRuzvY88p5BkXwtRDvKC++Hm3/zXDVqESS7p8=;
 b=J5zJsbf4tA5FT9dtFm4kGsEz/KvvyEw201xvg09ixbLJ1pqBBkB/rY5rFRrFyMMRnm7znalpW5j8hDhhJeA5e7Sw4tdpj8QKqxpYRrkAfSRdQZTv80DCB63IKSQn00XM+8taaFamEFow1/7eB+GaALR/BqTKSOkwVAZ8KCpfQe4ldN1Py+nhm1B9qzxElt4xFFMbICu4pG2AkoFHvatkZk/TuY8l3VgPkJ8psp1xuz6sfpFyoXfDZfY6wh50WyaQwMFqZt6g5IOO8sdm96fALkf+2UDZbQzZMkXvdgCVqUqW1t6LHnJqLBUz+uLvNaUQBitTShtv9VAmoS3oCP2wVw==
Received: from PA7P264CA0142.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:377::10)
 by AM9P195MB1121.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:3a0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.14; Fri, 10 Jan
 2025 12:35:54 +0000
Received: from AM4PEPF00027A65.eurprd04.prod.outlook.com
 (2603:10a6:102:377:cafe::89) by PA7P264CA0142.outlook.office365.com
 (2603:10a6:102:377::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.13 via Frontend Transport; Fri,
 10 Jan 2025 12:35:53 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM4PEPF00027A65.mail.protection.outlook.com (10.167.16.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Fri, 10 Jan 2025 12:35:53 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 10 Jan
 2025 13:35:50 +0100
Received: from lws-moog.phytec.de (172.25.32.31) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 10 Jan
 2025 13:35:50 +0100
From: Yannic Moog <y.moog@phytec.de>
Date: Fri, 10 Jan 2025 13:35:36 +0100
Subject: [PATCH v3 4/6] phycore-imx8mm_defconfig: add optee load address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250110-phytec_imx8m_optee-v3-4-6c39dab15592@phytec.de>
References: <20250110-phytec_imx8m_optee-v3-0-6c39dab15592@phytec.de>
In-Reply-To: <20250110-phytec_imx8m_optee-v3-0-6c39dab15592@phytec.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP
 i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
CC: Tim Harvey <tharvey@gateworks.com>, Manuel Traut <manut@mecka.net>,
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>,
 Yashwanth Varakala <y.varakala@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.1
X-Originating-IP: [172.25.32.31]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A65:EE_|AM9P195MB1121:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b29b261-ea10-4805-bc01-08dd317352d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TDBCcVllNXp5OGFpdkxEcnZyTnd0cURhTWxwZHpxOVFWTE5tV1hEQ2l2NC9B?=
 =?utf-8?B?U2F3ckp5TGt4RnZqZFIrSm1nNXNMN3oyOGpjRHkvaHczNExDaWNHWnJZeENr?=
 =?utf-8?B?bjI2S21IbHFwOFdhNXNkRUg3TE5weE1Kb21VczlUSFp6eGNCNzgyMWsxZElt?=
 =?utf-8?B?RTFuMURYbFkwR0VUelc1bDdVdENVL1ZyL1F0b3hCWXluWi84SUdMZm51Um1X?=
 =?utf-8?B?dVZPYURGVUs2N212TXNud1Vhc01kdGFqa1UxMDNMam9UbTI5bjYyT0VtQms4?=
 =?utf-8?B?ZEVzUmg5UWxDWFBuVkJEM3RkM0FwY05Cd0lldU9zNHVHdHlhVmlmR1c5bDd4?=
 =?utf-8?B?aDEvNzVDUEdYbmJMcVNaNWxTNGNJd0lqaHZ1Z1hnMi9BNWY1ckx4Y3dOZlRh?=
 =?utf-8?B?Mkx2UGtZT2tPNG1ndkRTWGFuemhxRG14Z3pzUlVUbDl0bVk4TDJtTTlHUko0?=
 =?utf-8?B?N2l5QXdVelozY3FRazdaUTVmOGhnek14dDQ4dTlFUUtDeGsvSGp0YWN4S2xm?=
 =?utf-8?B?dlZDTzNoZXY2Qi9PQjFVMTIxRlRTeWtvY0xuU2dzeWRkeUoyemQyYXFENFgv?=
 =?utf-8?B?aExMVUkyWXNVM3d0NlNBMEhIZ0NXQlZpUEJyd1JiZmNoUzZxTWkyQjBjNE9q?=
 =?utf-8?B?VG9mVGRqNk9MSWo0T3AzbEdKYS9mbVdwb0pReWRLTnpxMklTSmhxY01FTjcz?=
 =?utf-8?B?YzhBV1ZUNSs4NW44dDl3M0x0MndWRWRSTzdUSUhvSTZxU0d0VzRiYW5INURa?=
 =?utf-8?B?dkFrYk1aNEFCamt6Y1FqVmZEQ3FITm9KaHlVK2l4RW1uV2FTcmdzdmJhZW01?=
 =?utf-8?B?aUVrcGxydFE3aHN6N1g2WFBxeVBVZEhrdHEwbXo2WUJpdk5iVG9ROEhxRDhk?=
 =?utf-8?B?cnQvV0xuUElxcmgvZENNRW5tTXoxb0lEN2tCQVFFUmVnek1Dd3JSS2VCVTZh?=
 =?utf-8?B?dTNDaTZGbE9nelpKU0FzbFFNMzN2OFV6OHk5KzVwNmVaSkxnc2NkVWxVam42?=
 =?utf-8?B?M29FakhnUkI2a0lnQitieHhhNzVjcUt2YzJINERwcDhPMTNET29SanVwMXhv?=
 =?utf-8?B?cXVQcitJVWFEZEdFR2VqWVJ5bGlVUnZPNmQ0RFZtLzdTb3Q1bzZCa3czak1m?=
 =?utf-8?B?VkNPN2FUMlFWdEF5UmJzQkNaUUtqSVc5alQ3UHd1b1lIazd3alplWWFYMDgy?=
 =?utf-8?B?c2c3NTFnRUdmM3NWYy9oeS9tQ2dsVWhLa0RFTUdYZFA1WjRQSmxQZkRHT0c4?=
 =?utf-8?B?amV1dnJzMnRFdU1OTWtrbkFZMlFqSUdObjdSQlRiMVdUeWRFYllPQ05yaklE?=
 =?utf-8?B?UHNMOWpSR05SVFpiVWQ1akQvSytvYUkrTGZITzNTdzB2d0ozWk9qWktwZUJu?=
 =?utf-8?B?d1R3NHE2UnZYZXRzWGRMREU1ZHExdjRpTFJLQVF2anhGQ2EvaWxJSUtsYVNz?=
 =?utf-8?B?QWhHVHZlM3ExaXlSOGRjK1M2YlprS0tweFBNUm8rZ3o4Y3l4bE8rZmlReTdK?=
 =?utf-8?B?d2s1V2JIRXR3eWRGVHp1eTZ4MzJJa2UwVUxrZU11d2dxQ0x0eWhzdUZ2b2VW?=
 =?utf-8?B?VHlOTGFFbDdSZ1NLVUFqakFZblhsZVE1WWdOTjRQMUhCZ3FSalR0alRSQ3NO?=
 =?utf-8?B?d0g3bldpQWhoWjVXSHh5ajlaMEIvSm13MmVwNkhVRjhRam5JcHNCUUF3Skcx?=
 =?utf-8?B?SjdvYUN2bUlSdkhzaW8vVGZNYjd5VVpiWEplWm5UbndzRXBlRWsyeEpiV1Y2?=
 =?utf-8?B?cUMvQmNRWGdHV0NUUEEzMGswclpHWmZIRWdMdVgzNE5rNTJCZE5hUlB2SklX?=
 =?utf-8?B?eitWelowV090SkJ5ZnlIaVJtRGRaNWFEWnd5WTRnT2VSNnZMQlIyTy9RaStI?=
 =?utf-8?B?MStPV0ROeDBlRnNYOHc3SENqMVhPdk5rQWYxRUc3SDRMUW0zU3ZhTjNXWFg2?=
 =?utf-8?B?QU9oLytubDg5cHJKOVhZT2NpeVZvbXB3NUJaRkNQa01CaDFRUEw5ejBxQjVT?=
 =?utf-8?Q?pBDy9TVLQkI8iUIVrERbOqXVQPXZWI=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 12:35:53.6773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b29b261-ea10-4805-bc01-08dd317352d3
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A65.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB1121
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
index 3f4336837e9..5a3e8162799 100644
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

