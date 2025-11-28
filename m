Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29B6D116F1
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 16:40:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6627083C28;
	Fri, 28 Nov 2025 17:39:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="AglbXILr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3141283B8B; Fri, 28 Nov 2025 17:39:12 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D42B983B9D
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 17:39:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yA8Qvj8A3Ca0Hg2sjIOT5T2HOIQXeEjyRvCLnMuoiT4OjL5AJkS4WFhRkRWHm8opi3/QNlfPvWgHtD1CmETaQrFi+KrQmwG9xTv4LAbPMVnxTzp580RzeECI35vcDWn+oaxN86CxbJv5Mh+kdC5/3bJlvtET/r+lGCv/2HFCVD7zGi/i+AsNjMv8+AovISYUwYbh+3TB0leLQ17vWoIXwYhmtdTaiI+P3/2WMkSiNmUjTjOY2YNnOcpJsmrxfPDP/HtCHSONZrC4pe2UxKrzJ+2WK3uvoq109xaG/SDGObAY1qfOUA0JjGWrcRONwZHWFfwkqkWB02p49IzMc5MLtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJPzvUG0lSl6VQr1q4mZZVMG9XI0KJPdh89LyihYOsM=;
 b=Ve8/ZaABrW6N/XDsOnwPfXk17VwbQATSqIjWvIVqJ1qcianV48Ql0BcNLs6e0tKvtrxColk0t+ox+WkiRre7hLbeii4bBgW5GgSb1KxGWP2q/xDML0uwthVmFls8ob6RJ8M2+qmP+AKGiYtwdLeokW3uSkg38LGJfZKnPp1SMZpsIZt5PtVtVXbnF2MeNPD9ZgD8Wq22wS1Jl62AUlQuA9Bcq2zZi7vd9IYjQpziPP0hcnzPM5HXvnInodYfRqeubZll31S+zZQVP/CZxyijwr7TSoIQ8Fi/ahOeIUBbpZcoffjZpJ1lzQCk2zf7qwhv+u/WKT+if4LotkRgjLyCqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=mailbox.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJPzvUG0lSl6VQr1q4mZZVMG9XI0KJPdh89LyihYOsM=;
 b=AglbXILrvcRCjucroB+R+QxhDbqAFr1CCWUjvR0CJvL+wadFPCttI4JN1EwPsK+fWg3IWcebl2GrO7Ys8YWWVuKpLAjMB0uJFbQ+1+wtQwuS41+dB+AfWxC0J2LXbbKKsA+qmryMobQxzdEw1To1jVKnEmlYYnHwGYntLLlsb/UMhjhND7uD7JAOSwIwDSlPhxjaBSKQPviA61efLoZ9XWxqTUzT2jUVw++HVE9kjuzAQRgvOIqN8TpFu0B97G8/31aBOsDiCKHff7WOFtxFuhZcjzn0R5oJ5u6L7QgdEdBoFt2G3tRLyUxKa9lS8WOt+G5/ojSHpkaoIBIfuqQW2g==
Received: from CWLP123CA0258.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19e::11)
 by GV2P195MB2013.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:79::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.16; Fri, 28 Nov
 2025 16:39:02 +0000
Received: from AMS0EPF000001B0.eurprd05.prod.outlook.com
 (2603:10a6:400:19e:cafe::d4) by CWLP123CA0258.outlook.office365.com
 (2603:10a6:400:19e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.16 via Frontend Transport; Fri,
 28 Nov 2025 16:38:40 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AMS0EPF000001B0.mail.protection.outlook.com (10.167.16.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 28 Nov 2025 16:39:02 +0000
Received: from [192.168.2.141] (172.25.39.126) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 28 Nov
 2025 17:39:00 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Fri, 28 Nov 2025 17:38:45 +0100
Subject: [PATCH v2 5/6] phytec: use fdtoverlay_addr_r
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251128-wip-bhahn-imx8_cleanup_env-v2-5-93ebfd1591c7@phytec.de>
References: <20251128-wip-bhahn-imx8_cleanup_env-v2-0-93ebfd1591c7@phytec.de>
In-Reply-To: <20251128-wip-bhahn-imx8_cleanup_env-v2-0-93ebfd1591c7@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, NXP i.MX U-Boot Team
 <uboot-imx@nxp.com>
CC: Teresa Remmet <t.remmet@phytec.de>, Tom Rini <trini@konsulko.com>, "Peng
 Fan" <peng.fan@nxp.com>, Leonard Anderweit <l.anderweit@phytec.de>, "Marek
 Vasut" <marek.vasut+renesas@mailbox.org>, Martin Schwan <m.schwan@phytec.de>, 
 Yannic Moog <y.moog@phytec.de>, Simon Glass <sjg@chromium.org>, Yunus Bas
 <y.bas@phytec.de>, Stefano Babic <sbabic@nabladev.com>, Fabio Estevam
 <festevam@gmail.com>, Benjamin Hahn <B.Hahn@phytec.de>
X-Mailer: b4 0.14.3-dev-2ce6c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764347939; l=1562;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=AwmAzCKPCUTQbZOWqWS5WrEkIZcfAcAgqr0cuK3P5ls=;
 b=h+fqMR+TQ1zghZa9aQFdljL2SBSoGa6I++TO6+wJjHzuisYjL8pP6GkS2tx6YCwsBKZGjmcu9
 pQNTtMmSz91AdtW+H2MEiBp8YH7yQJhYNjXGE84mCxHqtkJAVDRFI2i
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.39.126]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B0:EE_|GV2P195MB2013:EE_
X-MS-Office365-Filtering-Correlation-Id: f3345496-ee76-480a-3b0d-08de2e9ca337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THRWblZBYlFOZlNLTjBwV1NWK25ySmtNd2VTSExLK0tzK0hGeHlBR3lBc09y?=
 =?utf-8?B?MHQ2bXNFZjFWMG1xbEdaNlJzQXVESjFQbjRDOWdjZ1ZCdi9rK0kwOWpiQWwy?=
 =?utf-8?B?S2hBdHNPUUVHSmR3SEFuMWpUWHpWcklSOHErbEk1d0oyYS9pZFg5TmRzR1Uz?=
 =?utf-8?B?eHZWRmFMTHNITngxOXdoeGtJaS9ENVI5YTcyWDNmTUNoaDJINzY1U3EvbVZk?=
 =?utf-8?B?cnlSemtlUW4xS1lLSktCU0FVNEplS25PbG9lVGZaNzNNTldrRjJIcTVyMFUv?=
 =?utf-8?B?T09KOUFpTmt0ZW1iWUZZY0ljeGt2YTIwa0hLOTVYVmhOZ1JTam9LSU1LVkRM?=
 =?utf-8?B?NUtYNW1NamdoWWdjTGxRZ3FRWFZWdGFzeXFydXowT3c4N3BkZGZQMXAxczB4?=
 =?utf-8?B?U2VnZGVMNXdXQ1J5V1Zoa1h2M2pFTmhRV09mbGxDUUdlMThsUyszRFAyT2NG?=
 =?utf-8?B?MGlJYUl4OS80VkpjTDliblMybXlqQTZTMm1RbSs4UU1FZC95WXAyL05SbVlH?=
 =?utf-8?B?R2tROXlmMTV2eVFOT0ljS0lVdm03Rkl1RVY5THMzb1EzK3gzbG40SXRFLzQz?=
 =?utf-8?B?SlVtRkhyTmwxdjBIalZmMVBERFBNRVdoR09Qa2JwWndCS3RoOXNjcjU5czNr?=
 =?utf-8?B?M1RxRVRQOW9CbGJlOG51UTVpTzRNaHhZcEJ6K2lubmhDNU5UMzh3bkFwMjhS?=
 =?utf-8?B?KytnelZ6WnpXa092a1JPcE5HUENkOW8yQkNlRnVPaCtKQkR5Sm1aR1VkREUw?=
 =?utf-8?B?a1hxdWtBOGxnRGNkT0JwQWhOcHNGWGJXWU9KRCtrbUdzQjRNekEzUVlHblNL?=
 =?utf-8?B?S3luRUlzcGZUaWlabE82NGlHRVl0ayttSlhuNDUzcEE4eEtsVS9aVE1NUTho?=
 =?utf-8?B?a21PdVE0Z3BiOTh4SWhaaHErWVhXOUhjcmxnZk9makVVN1J3Zmdpc3kybG1E?=
 =?utf-8?B?dklMYWJ4ZmRLTG5TTzRBN0FGTXMvNFJUb0VQOWYvTFp4R29aaWlkSWlHY2tx?=
 =?utf-8?B?Z1hHYTZvdFBvRjNHb2pqazNJY3ZyUjJGeGpSWVFWcnhNQlVBYURHcG1uWWJR?=
 =?utf-8?B?SU05VXZ6Rm1CZFgwWWlxa0VtVlJHQzQ2L3JtQU5WSXlmMWc0K1N5cEd0aVFk?=
 =?utf-8?B?R2l2T1N1STVLeFVEOUZDUjVIRFF3SEIrSjlubmNBdnhHcW5tc3FwMXpOS21q?=
 =?utf-8?B?WlYrSVZYcjFWYXFta1VGdXhhR1pLWWNOcHJjUlQ4UzBPcGlNOTJtaUlGZFh1?=
 =?utf-8?B?UHg4Wk93cW15eFhJOWZYNVZFY2tmazBPalBiWHYxN211YjFKb09ndEQ4MTlk?=
 =?utf-8?B?S3dOWDBnT056RmM2ZXBKZXlJeGFVckZzR0hVZjhxSmU4d0hmdnhmenB0djZB?=
 =?utf-8?B?NG9YK003bGR6VERQRzVpSkE5Ri8zZHM0d0puWkV5c3BqRjRuZjZiNkRkL2VZ?=
 =?utf-8?B?cTVweW50QnJ4emkwSWFVQ3pMWTBmaTRycWp1aGpFa0RPTC9oY0M4bDJOcUF1?=
 =?utf-8?B?VW85eFhTOXVZWlZCT1V3bGFLYnZ6MmplVmZETnF4T2paMVdReEp6L09RQ0xE?=
 =?utf-8?B?SkNHMmhiSVVwMG50aFUvLzBIMUtrd2FORXFCbXM2RXBGZjQ3UDg3ZGp1Smpj?=
 =?utf-8?B?L2wwVUhLZkk3cnIxK2FWNU93aEVIM3VvQ1c1VGEzSGdwbjJKMDZGOUV6empn?=
 =?utf-8?B?Y2svUkJDa3VXdmwvZUNYSTRFdGJWVUFtTWthSlZJRXU5YmFxZy9ZMEtMT0xY?=
 =?utf-8?B?dmVPSTg2VU5VN2F1d0YvUXVlNnk0Z1NsdHRMUDl2S2xRbW05aEVJcEtHTVJL?=
 =?utf-8?B?Y0JJdDM0d0krVUNnaTB3OWx5OWtiMlVldnVKZDFseGNDZXQ0bHhEQ1ZUY0NK?=
 =?utf-8?B?WnBrcHIrSm9RL280OTByR3U4K2V5Zng2MW5EdVVqaDdSZjZ0Y0hqNUswdW1s?=
 =?utf-8?B?WmtvSXpYanRDYUVJd3l5V0FCT3FnNW5KaHhSczMwQmN4NTExd1RsOHFUTnk0?=
 =?utf-8?B?ZW9OcFo3NDFXUmJtSHRSNElTZ1VrTStjcGlwQVJZM1Jrb0pmRVg4V0lMcHZs?=
 =?utf-8?B?ZFBjemttR2tFRmNYb0pkTHRQSTF2aTFjM2tnalhhTWEwSUYzakhldDQ3Ukhv?=
 =?utf-8?Q?9tYg=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 16:39:02.0874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3345496-ee76-480a-3b0d-08de2e9ca337
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P195MB2013
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

fdtoverlay_addr_r is the correct variable name according to standardboot
documentation and already used for phycore_imx8mp.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
 board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env | 2 +-
 board/phytec/phycore_imx8mm/phycore_imx8mm.env       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env b/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env
index 5fe49e2a375b..b9f0b2fb8ccc 100644
--- a/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env
+++ b/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env
@@ -3,7 +3,7 @@ console=ttymxc3,CONFIG_BAUDRATE
 emmc_dev=2  /* This is needed by built-in uuu flash scripts */
 fdtfile=CONFIG_DEFAULT_FDT_FILE
 fdt_addr_r=0x40480000
-fdt_overlay_addr_r=0x404a0000
+fdtoverlay_addr_r=0x404a0000
 kernel_addr_r=0x40a00000
 kernel_comp_addr_r=0x43a00000
 kernel_comp_size=0x1e00000
diff --git a/board/phytec/phycore_imx8mm/phycore_imx8mm.env b/board/phytec/phycore_imx8mm/phycore_imx8mm.env
index bb444d182939..4bf017a20baf 100644
--- a/board/phytec/phycore_imx8mm/phycore_imx8mm.env
+++ b/board/phytec/phycore_imx8mm/phycore_imx8mm.env
@@ -3,7 +3,7 @@ console=ttymxc2,CONFIG_BAUDRATE
 emmc_dev=2  /* This is needed by built-in uuu flash scripts */
 fdtfile=CONFIG_DEFAULT_FDT_FILE
 fdt_addr_r=0x40480000
-fdt_overlay_addr_r=0x404a0000
+fdtoverlay_addr_r=0x404a0000
 kernel_addr_r=0x40a00000
 kernel_comp_addr_r=0x43a00000
 kernel_comp_size=0x1e00000

-- 
2.43.0

