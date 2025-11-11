Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336F3CCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 13:10:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5797583FB6;
	Tue, 11 Nov 2025 14:08:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="ICiFQVDp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AF7383F69; Tue, 11 Nov 2025 11:37:41 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazolkn190110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CE1483EC9
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 11:37:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZmDyom5NSJ8dBwVZPwzC1IuCV3KiRfnvAzDjbfn6xJIOgxyM2hyDUsjE8faWCKfAu3X6vI/PQaKherDQRwWXjKf4qkbWGf4/XH/xAfch7AN6XhNDPiOEvFgXlZOmSBZLbL++u8S6SnSu3AhWJsUUhfC3lnbrERlGl3L1fMPwka/azc+ysorSSXM7aUNMy24X/t5bYsJ4W6gVC4p1ML4M2je0ezkf9Ka/0TuUp4ZAvLH0YqrfwlkbFvJA1/7scYDvwIO9ye9rrAPBitEvPYMNc02v2pjsRWaqgGSfylyVVmIYoXs9lMvO/RzazRd82Dyc6hShu37rnkLo9M8+IWWLsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWLLLlFjcjwC/zEr3vuY8YX8dBL5RVo74+JBtTUTB1o=;
 b=Mq1LvYKgLEb9GGcwAkYMXHl0raY0f1zPjI4d/61Ub/0KDqHhseXZRyKBGMv1eqDthBKoKqT/bNYED9nTnIDmp1+7vH8R288vqcxbInyxut6Fjqc/64OM8b93lsz7R+zkKZYHSdPaks0Epo9/CdUsF27UwxsjlUyrJ6K2EO3yO4HY1BaAreXmKd/gLZAaoxVUl7fa/7lZF+WL3SfT916wjnBpCr2z6p2pPFcTTUdSZ6LR8XiJUZFPCl3ZDVUfRlXXRT9VU2uU0zoipslkB9VeRKwxxhL4TvTB8/V44PJK5sBWCy67bgxJr4N7aOg/LO5xW0GD52XH7SdWSD5DGzOlEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWLLLlFjcjwC/zEr3vuY8YX8dBL5RVo74+JBtTUTB1o=;
 b=ICiFQVDpeoLErxPLBguYylRig/HHK0MAoDiBMBE8Rjur5lCLbsAhDemmmHD0UgOFkz8fJ97Sdub/y1JWDTIzcakXRgJAeIlty0Gp+8GOWPOcj3UAPY4omKsEM7sPgn5JJ5VwSFXneOgVRNI6J/libCFmpr+sWESmLstFDv1uyALPwOXNu48B0w4XYw/AmPrKEpHnugo6yNyEZ/5NGXNNriaMaFYIjpqhrjEUv7Ww11tXSRMYVU500RYufyRI5JVOZQjRqJvCCL1OZm+qS0o1lXrIk5vhIpsziK4oZRXRq1YDFU7SyoeihM3RBiWgw50/Y3p4WmMSTZWCu5ce/8vIgA==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 MRWP194MB2921.EURP194.PROD.OUTLOOK.COM (2603:10a6:501:9b::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.16; Tue, 11 Nov 2025 10:37:38 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58%6]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 10:37:38 +0000
Message-ID: <BESP194MB2805EAEA32CBD02FF8F2E7BFDACFA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Tue, 11 Nov 2025 11:37:35 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] upl: Fix buf array size
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0254.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:371::15) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <1513c796-38ab-443b-8a52-a45431d59213@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|MRWP194MB2921:EE_
X-MS-Office365-Filtering-Correlation-Id: 45ecc671-dfb0-41eb-8e6a-08de210e5574
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|5072599009|6090799003|461199028|5062599005|8060799015|23021999003|19110799012|15080799012|440099028|3412199025|40105399003|52005399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGZ6MnVTRXVxUHhpcTgzWCtCTzJmczc2eFdKT0x5VDlaNWhaVGZwdTJvdm9q?=
 =?utf-8?B?REZubExoQWhqZm1sMTdwV01WNWlkR2FqTWpIZnMyYmxmcUNyZWFGMnBGdzhw?=
 =?utf-8?B?MWJQYk9NY3FIb1BNWnlQNTNmRWcyQi83M3pyYjE0dXJnY2FoSVRiU3llZmhG?=
 =?utf-8?B?TmNjeGN0YkVOODJnTEhnMEswREdhc28ydldOTDZua3VpOFpRUjV3ZWxQcTJI?=
 =?utf-8?B?M0VvUForZ2w1Z1ZBUzdrSkdJYTJENnhwVDJ3NFZ5b1E2dzZCam9Ia2FWdGV6?=
 =?utf-8?B?TzA3NHJkd2dpVUNDZzgxRWs3Y2tEWm53Q214L01OcUoyRFAzUVNoYzZRMkV5?=
 =?utf-8?B?R2VsS1pXMUprUUV3OU9yMEo4OENkTTVMaFFuRFNlS2M0MS9mRGtJYnNWMEVK?=
 =?utf-8?B?RllIZHUrdG1iYWdZWk90bS9UYkF3YlF0WVRjRHV1bkQ4OTZOc1VIVmhqYkxO?=
 =?utf-8?B?Y3RNcml6dzVha3A0NmU4c2k2NkZZVkppRFU4TWhEUnBqVXBUTzNaQkdIUjB1?=
 =?utf-8?B?dkRFbnRHc1Fvc2dOaTN3UkRWd2ZjNjg3bVQ0MkM4THBwRkF5VnNuN2EvSVlk?=
 =?utf-8?B?ak93NUZqNG1GTUFFalEvOHB6aThjblROakRhMlhJTWo1bFhRb3VuVWdrRjVD?=
 =?utf-8?B?VEE0UjFLUmtiS1RkZktsMTUwaVJuTURKc05MVjJRNi9wSmxqSFlDRW0yeTk1?=
 =?utf-8?B?cGtUUzRjakpzMjJrZzdnTXhlS2VlMWVZQ1FQWU45UXp3SnV5MnlBOG0wVThr?=
 =?utf-8?B?SnpPL0ZodDdRUHBycE95aDZSa0xKcXRXN3VaM1RCVmZhSENqdVNLalBPcFVL?=
 =?utf-8?B?c1F2OHdiQmt0cUJlNkFFejMwY0MzK1ZiSytCSS90QnRWeklsZ0RuYWNuMHc4?=
 =?utf-8?B?NCs5UW5rbDF6VTZBblhtczdoUkllSUMwL3JaYm5UUnhaTFRDMFk4SGlqVjZE?=
 =?utf-8?B?ZkxvVG5HSkJNT3ZFZFc2NGJBT0djbkJQY09uZitYL3g3V1NwWjY5ZGlpSVNT?=
 =?utf-8?B?dnlwM0JVanR1TWhqY1V1TTY2L0Z4L2IxS1k1SXNEV1ZLRUFER01tY0paWS9Z?=
 =?utf-8?B?cno4NlprMXl4U0NJZkMyQWphM2IyZWJtN1AvTDE1aTdjS0drSmVaaWoyd0Er?=
 =?utf-8?B?V3VoYmJFTTErOUNtMFdzU1orUEU3dm5PSjZ0enlrR255OWZQdmlPcUZaY3lX?=
 =?utf-8?B?WnRzR2FPdDFLRElSbzczRnVMaDhETjcvTm5TSGtUZEh6YnlpTXQwZTFZbUxz?=
 =?utf-8?B?RytwakJmZjhoSmdWNmJKaFFqaVFlKzFZYVNPNnFaakluRU0rbDFmb3lBOVZU?=
 =?utf-8?B?Z1BtZ1VhanRQbEh4aUY2YmpwKzFQUlN4Z0x0OW1zRGpoTExwaHNuZlBOdUZY?=
 =?utf-8?B?MEJpTGFhQXpiY3F6OFBMdlVTOTN3dGZXQVVad2Y4c29uamFtTTlmVzBTbTFn?=
 =?utf-8?B?RU9PSXAweFFaNXFGRlRmTlBhWFVBbmlnNHFCaXVRSjdLa1ZZS2JtclFuVUJ3?=
 =?utf-8?B?K2NzS3Nxci9GZ1dzeGRUdXJDK0VPNW5BdVllOURBdTJ1djM4UnljRWpMQTg5?=
 =?utf-8?B?cnE4aXFQa09wcnZwdjNYaFdwOFRSL3hzVEZzY1BDZ24rSE5WbVhMTkFnM1NH?=
 =?utf-8?Q?Z51VS6450fN5AVqScceHFySfEcqTJmhMbEEuQle8nEX4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzFwcEdPeVhtRExTbzRUN0ZUWTJLNHk5eGJhckFpelJ1YVkxUXV3QnFYRGQ3?=
 =?utf-8?B?VHRHaitXS2YvYnU4WlZZNFJ1bG1RMXV4QUlnamhWQUswTlUwcnBOL1hEbkRB?=
 =?utf-8?B?RU5QOHlDTUVKdkJJL05vTTRKZ3IzNnZKZ2tRLzlZNjR1eTZtdVJweUtqYjJw?=
 =?utf-8?B?RWZWMm5BRnlWWlZkdktxQzRRUmoxYXNFS0pQdVhYQ2JtNFlxZlpvdHUxWFBX?=
 =?utf-8?B?bmpFRGwrVG9SRW5DcVN3L3Y1V3hLMFVnRHlFVjlud2JsbUF1ejFQVUpPNnBz?=
 =?utf-8?B?WFA5dU9OU2VCMm1BS3R3cVpsODJFaWRkQWQzWDl2ZjdNdkFyQjQ3S0R1bXFS?=
 =?utf-8?B?bG1MUzZFeVlUamlMcWV5VVBFdytNZ1hRdjhndEdmRlNsc3Y1bUFDV3Nqai9u?=
 =?utf-8?B?YVl6elJUNTBXdk1WYVIvREtJYXZEQWMyMUFBejV0bGN3NHd0UlFveUtKVG1X?=
 =?utf-8?B?TVBSZXVZb1NNTmE3a1J6aGxuZFR6dDg3c1pnVHAra2JjdGZIRkl0ZWNMVUlQ?=
 =?utf-8?B?QWxlTlBtS001ZERXSFZBYTFqNWtqaXV1YUFHRytLVmFHOVlZNnh2YTUzdm4y?=
 =?utf-8?B?dXNDUVBodmJSdFB6N01BbmdFSnlPSm55NDlSQVVtUGtSVUtNMEpOazJLZExU?=
 =?utf-8?B?Wmk0cnhPR1lGRmdNc1k4eGdGQnFVQi9zbzdPdDBCeHQ2NFg5aXRWTnhLeE9J?=
 =?utf-8?B?S053QkoyejVJTHRlU09WZkx3aDl5TVd6ZU5WZU16dWlIRE11OEs3Skx0QnAr?=
 =?utf-8?B?czYrdmVLYlN3YWlrQWxLUjNMTFkrMVhaMlRaKzdPZnlMN3YvVHpad1JraWJ6?=
 =?utf-8?B?NHZKZ2dmMGV5MXdkcmF4TDZEdXlOSmlLWC8vU2dhN1UxUXdvWkRSQzBvbHdC?=
 =?utf-8?B?SHhrZC9DV1ZaSlB4elhXTlJFSDVxV1FaWW9zejVtR0dXV3YyYTFTU3UyamxD?=
 =?utf-8?B?Qmg2TUh1M2pSSEJDR1dhZEhhbW95Rit2ODc1SkRWeFBtTWIva251VmdqT3lO?=
 =?utf-8?B?TkhSZElncVVxSVg4ckcvcERZN0NVelVNeWY4R1F0U0tVcktpZFE3Q3JIaHlh?=
 =?utf-8?B?U2d2OVpHdU5CK25DYjNnL1lWR3hmaHVFUXRnOTZGMzZYZ0EwU3VPWGtySjcw?=
 =?utf-8?B?TVFobll6cFpYejc3dzFNYnhEWEErWG16c3NoTmJDUjd3NWYrN1lVTDNseFY3?=
 =?utf-8?B?RXpRQmozOWpuOFIrNmh1em1nTmIyeTVIYkZ6UCtWTHdZOTVjWjNLUkwyVEdL?=
 =?utf-8?B?dnl6ajNjWTZXdFkxejhWeUs0T3N3ZWZVTmViaEVmc0hPZ3hqMVhMK1BSbVFm?=
 =?utf-8?B?RUFRRmE0RjVwRDh4UXR2SUp0LzlkRmd5Ulc4akxzVWlDQ0tlTWdURmFRL21T?=
 =?utf-8?B?eXRqNXgwbW9QYm4vMDU2aWgzaTRaK3NFcHlUM2MxSWc4RWtHYVVEdDRYRklN?=
 =?utf-8?B?bVZsSUJ2cEQreVZjTkNKVFJxeEZ6cEZQeStHL04xVlNHYmhleW54NnBpcG1m?=
 =?utf-8?B?OWM4YWhZZmVXay91dzMyNUllWEovanZ6RkpRQzVDTG9iYTNXOXgzTjlXQzN5?=
 =?utf-8?B?VWdDVmc4NUVYVldsbnl6azFsejlWQ1VDMjNXS2ZXUVlvM0RPMExqbk5KRmdy?=
 =?utf-8?Q?X3njhxvIC0kMwLnwjNI5qn8l7NuMKW9k2Qgd6J2M+y9g=3D?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-9bdce.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ecc671-dfb0-41eb-8e6a-08de210e5574
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 10:37:38.2117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWP194MB2921
X-Mailman-Approved-At: Tue, 11 Nov 2025 14:08:29 +0100
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

Size of array buf was incorrect due to sizeof returning the
size of an integer (typically 32 bits) instead of a u64 type
(64 bits). Hence, buf array was shorter than expected.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 boot/upl_write.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/boot/upl_write.c b/boot/upl_write.c
index 7d637c15ba0..4185e59becf 100644
--- a/boot/upl_write.c
+++ b/boot/upl_write.c
@@ -301,7 +301,7 @@ static int add_upl_memory(const struct upl *upl, ofnode root)
 	for (i = 0; i < upl->mem.count; i++) {
 		const struct upl_mem *mem = alist_get(&upl->mem, i,
 						      struct upl_mem);
-		char buf[mem->region.count * sizeof(64) * 2];
+		char buf[mem->region.count * sizeof(u64) * 2];
 		const struct memregion *first;
 		char name[26];
 		int ret, len;
@@ -354,7 +354,7 @@ static int add_upl_memmap(const struct upl *upl, ofnode root)
 	for (i = 0; i < upl->memmap.count; i++) {
 		const struct upl_memmap *memmap = alist_get(&upl->memmap, i,
 							struct upl_memmap);
-		char buf[memmap->region.count * sizeof(64) * 2];
+		char buf[memmap->region.count * sizeof(u64) * 2];
 		const struct memregion *first;
 		char name[26];
 		int ret, len;
@@ -411,7 +411,7 @@ static int add_upl_memres(const struct upl *upl, ofnode root,
 	for (i = 0; i < upl->memres.count; i++) {
 		const struct upl_memres *memres = alist_get(&upl->memres, i,
 							struct upl_memres);
-		char buf[memres->region.count * sizeof(64) * 2];
+		char buf[memres->region.count * sizeof(u64) * 2];
 		const struct memregion *first;
 		char name[26];
 		int ret, len;
-- 
2.43.0


