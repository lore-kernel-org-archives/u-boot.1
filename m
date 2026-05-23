Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33B8CD5BAC
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 12:23:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F0458489F;
	Sat, 23 May 2026 14:23:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="pc7uMXp6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49D3F84886; Sat, 23 May 2026 14:23:17 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F74E8489F
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 14:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1BGWtfeWIQb99gAH5FIkLhJklYLBHB6c89Nk5dpT6dh2i9EhJtNx3MF0A3cjYxDRctRggyvT9v2reArQaeNPCbszTx0+lNloSs90S0L6JBPz/iRWgtLAqCQaAdtTzqEYq+QlWxqMnEdCaNqQnk5RuKiIgSmJ1am0bwmGlyU04uQ1l98I1+uAICkA444wd26uIQ1SCANkRd8MEZrdGUyoVGGTWXMkAaiqIdpal1JQvcslymdlz6NV6/K8lNKQPbxeB//SqKtpqJMf1vGbbhBqpEHiy6dLx8tYZWSx/Q0ZQys7G9HhC8xQqWqDoEij87nWnWB4zbUN0XDRyEydEUirQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zal1UM0jUdcfnNy/jhoAyD/07crbXVrv0KShTuIGrpY=;
 b=cL/oaJOTM0KPZsv7w9BO4DlZoRgta5Wur0O9O5bRtbB1MhOcFhU4PHUomJ3z0WeUWojTnXuNq8Qo9CedX1+knhO0cJrhjU11gQThOHp6XrcDpVmqcgHQ68Tz9Dj3ZQAa4UJJtpcA0rlaw4d3lUZFse5HJxEDEbBpJLWWmc0u6EZnda+SsdR029oeNnRLOnMueWaXq8i9+gTuiBi0Vv+h7Zxc9SQ0gGAETepTeM01MLsumY05vw/p1utn0wQIMK9QdkpqLxtZvvFqMVuiN8KVYDKDwL2FDI2zPsfovmKEVl4TjQVwYLiFQeoNmvN/lpx3rRyhNQKxGfOyjNupZJVFVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zal1UM0jUdcfnNy/jhoAyD/07crbXVrv0KShTuIGrpY=;
 b=pc7uMXp6QJBlgDoUWmxakl3qPPZBBx/fOfdBqiqGNUVgDoBYeaAhxfdW1/McaAoqCJNn3WEy4xI/VCRMmnezDLfpujfD/BKdh7z/IYuGTVxuVqtQ/rml4TiA2QVKhiNpZdLzFdy6DNyaJ9JpHR/QEHDf35JWTA0wRYDFXYDfIJSQx9jopCHECp5jjpWYsPQXodNNLzrPSLMvdiuMZMPkvufKRDGWUDCSirgmYHYuQoomu9eBI2LU5VFs413tmgq6iuGwk1JyXxtNw2epZK8wa1V4ftLbdfcixniwAqRFC2JveB7vlZ1k6NKjzEA3o9NXfH6A/0j8LLQqdN1MEZpywA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by GV4PR04MB11976.eurprd04.prod.outlook.com (2603:10a6:150:2e9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Sat, 23 May
 2026 12:23:13 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 12:23:13 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 23 May 2026 21:39:48 +0800
Subject: [PATCH 05/13] imx7ulp: cleanup get_imx_type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-imx-misc-v1-5-2898c9eca9f8@nxp.com>
References: <20260523-imx-misc-v1-0-2898c9eca9f8@nxp.com>
In-Reply-To: <20260523-imx-misc-v1-0-2898c9eca9f8@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5PR01CA0255.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:223::6) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|GV4PR04MB11976:EE_
X-MS-Office365-Filtering-Correlation-Id: ab24baca-b20f-4e8a-a9fc-08deb8c60f58
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|52116014|1800799024|18002099003|22082099003|56012099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info: TwaHaeFX2KekqIRl6UWxeK7DpvZj0IucRQBz0r3q7j5ZGA1rJ0CbqPXCfE0seVbhrmL5Qs5GzCffRQ3iitAUQbAg8XfOBXGA9Re89vbnRGRdeIR9pspYjdLphpO3W554CwxZwWVRP3FBlDDX/lBl6vaWvVBqit+0T5a/1G24A/oA66p98rXIjaBl9WA+N5m47kfGUt5j7Yqk5caO1RtbgddyxXoKzoJdCvln2lO0/7mfvzsOuNokS1SJSNviZj6y5s1qAWCqP/ls4Aw6JNl2r2pmizx9M4Ia5hSZmDRkUyw1Eepru0jrnuPvDcXlCw1cOQDCpJI0FhXT/ec9forJ2wPuIC1q4MW3UTGYdMh3oh35bP3Ly4CI2OjZd53+0SJmAkvLy2G2RuULYTmtCBg3MZ+U4pDp1jAcHuyRn4HWQxySdMILeinYvBqXkCilnL6kBNgJl/JknQw0Km46rRoswaJV7rXk/HrXWkH2iUsCLtzxVR1/8hkWLNjNoPYwtIkaq24vL6Pbrcj1EpApvyPv5r1ohSyoHRgwqNJ0iXToZFItYYa2612ofBdLlzmZGBSBxpe9v5exAydeeN89gwEWDWZO+pT81iJP1mvWMSO4u0GazGB6Qlf4bnQeEx/dHOGR3CKAJlE/VjReybktl4MQK/9/19Z3an1RS44wrJNtesQO7qWPy/YPjiGxBw4kLcv8Ti3Mn8Uk/1QMiowb28dZNQmVjuKpjjb3Jpk2i0HdMQOzGiuECcuaGvKELuJdw95N
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(18002099003)(22082099003)(56012099003)(38350700014)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW9yeU15aGVCMmdTcytxdVBEQUU5Vzl1UlpwaTc3QW96YmdzTGRBd1JlVzNP?=
 =?utf-8?B?a3d5Z2J0UXh0RFpuWTdCODdWbUw5ZEM2dFpWMk1FUWxKN1FJSWt3ZDRxU3Ar?=
 =?utf-8?B?YWgrdUFRWkQ3MnJGT0FHMFc3OXh5TmVwcnF0TU0rUXVjdngxdXQ3aDBaRk44?=
 =?utf-8?B?b05yOVRUUmthR0g5cC9UWHBXS0k4UHZJZ1VaUUJrQ3NCdmloYTFKYUtnUTNG?=
 =?utf-8?B?cU94RGxaV1ZmQW9ZbVBVdUFGemYyam03UkY1Umw4NkJRS2VIQmMybENBY1RN?=
 =?utf-8?B?TElNYmF3ckNGYlhWSmxGM2owUkNDVzlleE9WQmhpU2YyeXR4UEFjYXlaSWUz?=
 =?utf-8?B?UldiRWNlRHkrQ0xtOXZFY0dwOER5bVBucm92Mk5MVGZPVlZLeCsySHVPbXln?=
 =?utf-8?B?RHBYMXcwQzgzMUxJcFZycXduRGZGbi96aStBTVNtc01yd2k5T2RDS2ZpU2ZP?=
 =?utf-8?B?YnV0YjNobEdxdmJOZGd0NEJkTHFEN2xncVVLczEwRk9lZnRzbUhzT2NMOW5E?=
 =?utf-8?B?WEhhU0REQXVibHQ5aUdoWVQxYVFlclB0bWdqUVc3c3NScE9RaFVFTXZ3WDlu?=
 =?utf-8?B?YkM3Qmk5STJYYzRQMnB1K3JiclpZTVRzOUJjVXNVbTVUaGw0RnpRTXlQYmNK?=
 =?utf-8?B?L3RCaHNrVi93SHJtN1NDdVlsTFlnMnZRSGRjMnJmam5Qdm9DalhRMXg0Mi90?=
 =?utf-8?B?bHZqZk1SeWxINjhMN3J3bXVIOUluY3RNamVyQUg5RVVnbDc3em5KMzdwd3kr?=
 =?utf-8?B?aXFzbmQvVE9kZ2pxMTMxZEYzNHN4NXY1K1U3WjVJdTVYcFdIc2NaMVJvV0hw?=
 =?utf-8?B?WUJ0RDE0Wkl5V1RoeVFvNWtVeFduODhsTUFIWEszNFZLSTVlUzRRR2ErY2JX?=
 =?utf-8?B?MCtxSElOVjJ4VTNDWDlWNGtSME5pZnpmRDJkUTBabGtSQVN1SW0vUy9sVTg4?=
 =?utf-8?B?QUwwOERzMlQ3anN0YTRlS25abUxYckJ2SmtjR3RRTUJuaWxSeS9aU2JCTEE0?=
 =?utf-8?B?c1ZmZUxIQUJoZlJIVE9WS2xybnRCY3BkaHRsb0ZkRlZ2WWhaenhiOU5WaVdU?=
 =?utf-8?B?V3luL3IxNktIV1k1ck9ZQ1hzTnBuZGVEVGJLNnMvYTFyOUhPWDFZRWxEVHMy?=
 =?utf-8?B?K0Q4QjNMNzI0S2c5cmsvWmRLVTFTbGUyMUJMM09YTjU3OFViWkN5OVJEc0J6?=
 =?utf-8?B?RDBNa0U5elVKeTFkUVVVRUMyTnk2Y2hJbmJsNktQY0Q5TzNDQzJ1VkkyMGVO?=
 =?utf-8?B?cERUWWZvSkUwVXRFQ3JpTkFVU1EyYVpEdUtGK1FKSG9tdVU5V082OWhjMksr?=
 =?utf-8?B?UlhZV1B6QUxNTysvNHBnblNDRm5JRHY3bE1MbWZqNzJKRVhYaU5sWDREMjZ2?=
 =?utf-8?B?TEtMTFpwbnU2MW4yVFJWUU5Xa1hWNElLa3JYRHdyVS9CRVZiT1RZT2NqYURi?=
 =?utf-8?B?QzlLYzk1QXRURDNKY01OTWdvcm1RMkpGbUxLbnRjVjV3OEpkdWRGRy9VbUFm?=
 =?utf-8?B?UGVzVkQ1eHd5QWg0S0tUZi9CTWY4U0c2ZHhVVjVybDVDVk1XcFJLZ04xb0ty?=
 =?utf-8?B?RndIWUFqTy8xVFg5VEZXbzlJdUJSNCt2WERaMFZURFZYcXNNQzgvdERtV05D?=
 =?utf-8?B?blZGZE91SnNhOFpiQXR3V0RXaVpkUDdYVVV3TGliaXFMRWg3SXhmTWJ3Z1BV?=
 =?utf-8?B?RHJqRHFjWXpJTXZ0U09KUUNqMnkyRGNqTnFFVyt1OXd2NkJLVjc5YlJpbVZE?=
 =?utf-8?B?UjhFUFpaYXhkZFdySnl0bFkrMWRRU0xCSHdhY0w2TEUwaHpqcllGcmRjQjhh?=
 =?utf-8?B?Vm9mM25takVqdXEwaGtpL21UdHp2RFVPUTB2ZjFzTTZYUXlVL09uTTY3NXZV?=
 =?utf-8?B?ZDZ2MWk3bWdSL245bnFFdGJJZmQ0dlVGL2g3ckoycFZEUUQ5M3FxOWkwcG1Y?=
 =?utf-8?B?S3Q5WmdONUUwZFJYeUoybVIreVZqamJsZk5STkltU3lHNkhDTjQ2bHJFb3Y3?=
 =?utf-8?B?UWVza1FUNm1kWmNtVUQyVmJTaFZoeHJDUnNmZE5VK0ViKzdJUnZEeGRhYkZI?=
 =?utf-8?B?Z1htTmNvMXZXMlo0VkVuK1l4ZDEraFYzTWV6Qzc4cnk1L2djbEhMZERPVExC?=
 =?utf-8?B?L043UUw5YzBUS2xkQXZJazFlVUJGVUpVRTZtM3dNZEsxdVd5QUJMOUZxb3Ju?=
 =?utf-8?B?VFFyUHg1QkVhRm4vMHdEbDgrSGhsdTVQejFvb2hsYXV2Zmh6eGtuZnBJL0I1?=
 =?utf-8?B?ejJ6OUwxRlBoSHFvSngyMlpQM2FGb0xwWk41bnVscTd1RGtUMVpZZ1EzTXRS?=
 =?utf-8?B?aDluS0tEVkpGay9PM3VDVEIxRjdDYktGTVRBVGRvd0pkVTNtZGowQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab24baca-b20f-4e8a-a9fc-08deb8c60f58
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 12:23:13.4290 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kiLUe4w/vlA9pBFu1sEIdX7tCe49z29JA6/Uh90sro2SUNaRUzlC3SSFruZhO2phHFANI6Pz6M9jnDj3UylSDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11976
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

From: Peng Fan <peng.fan@nxp.com>

There is only one SoC and no external user of get_imx_type for i.MX7ULP,
so directly embed the string in print_cpuinfo and drop get_imx_type().

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/mx7ulp/soc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/mach-imx/mx7ulp/soc.c b/arch/arm/mach-imx/mx7ulp/soc.c
index 5306e76223f..a917f06cd6f 100644
--- a/arch/arm/mach-imx/mx7ulp/soc.c
+++ b/arch/arm/mach-imx/mx7ulp/soc.c
@@ -249,11 +249,6 @@ void reset_cpu(void)
 #endif
 
 #if defined(CONFIG_DISPLAY_CPUINFO)
-const char *get_imx_type(u32 imxtype)
-{
-	return "7ULP";
-}
-
 int print_cpuinfo(void)
 {
 	u32 cpurev;
@@ -261,8 +256,7 @@ int print_cpuinfo(void)
 
 	cpurev = get_cpu_rev();
 
-	printf("CPU:   Freescale i.MX%s rev%d.%d at %d MHz\n",
-	       get_imx_type((cpurev & 0xFF000) >> 12),
+	printf("CPU:   Freescale i.MX7ULP rev%d.%d at %d MHz\n",
 	       (cpurev & 0x000F0) >> 4, (cpurev & 0x0000F) >> 0,
 	       mxc_get_clock(MXC_ARM_CLK) / 1000000);
 

-- 
2.51.0

