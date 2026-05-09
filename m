Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A26CD37B2
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 01:42:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B1CF84A4A;
	Sun, 10 May 2026 03:41:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="R2ZPDqcw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 008E984B04; Sat,  9 May 2026 21:20:25 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazolkn190110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3F2084AFD
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 21:20:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JC1IyhUwq7x4W/cYnFcOcOXAOjJzNLvKBIme+v3pAEq7GjvN1XXBIAyiMxshI8280NSMhK3sZ6n1uCzeGWeFlE9LiosPaxlNiHa9p47WKr4gLJyc057402SG3XBXOvm7x55JUmWlk4m8ZlSmT5cgNmnv5qVQhUhlFCVO0+nNJOEztaZyZjjQ6spJOFywl/qtXPOFdWWdA+txZ1KfLWhh6YURjSVBgwkh1vBK4aY0CEyYwbiTCxL2Rf2ahu/kNi2Zk3X8HzBoXiprptIN38ZiEkOTXAuJz2cDH4RjLwgs2b5sTQBGIvbo33Av3NKltFrmZ7/ZbBdBRPcpVqqHnNb5iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1n/yxMaCdTeXetk+j1cBbHoQbp3D6VuPdrJHz1MPbo=;
 b=spPHnDOH1Qd4H0Pjp6SFPfiPrJx9yn4/vCbkcEKCBg2ej4N/Ag6pJhdzWzy7bAx1hhUUF5gcCiW9gvxzvXe2U2tIJsF2JGz0kWuVy7Zs7/f7pny/x1sn+TKBJ7P+uVuCfENX9vVGj6eNPkcSCXOfBscm+/bytcI9YeOoc/5rTjAp2FGZxgQRZbBdf7zZ8Lj73temLxfiDT7nDsBIHoyUEHZlmDAz8kNZdmiNgUlvE57mJD9j06PRSqDWM9qFxk70tGB8msr5Cjxf+K2zft1r1ooMXW657mfXpj2AgbyA2jpWtFGs4gGy38kT60TH359xmRp4v9OncgELi8LxJsirtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1n/yxMaCdTeXetk+j1cBbHoQbp3D6VuPdrJHz1MPbo=;
 b=R2ZPDqcwY+LkCbOd7FCyrxyiVNd9l0cDxHQ6O2gA0NVFja9hYhyAWYNEXV8QPft7cy5c7BvIOZ1lGW9VECT+329G76bjaaL/wV0BsNMT0X2akBDvOnOddTCswKt+NgC84g4vKgPi+IXE46ySuXgrCUYva5mzHHmDkfSq3/lam6a8IXFPJMVPO4QoXUMHiAuXmZtqyJmazgdspCERtf9wT2jyp/gJnkpfPcjIAWpAkIMy2bH2zNy7MPHb6znbDjm1tSeNZpl1AwNRN9eDfGv7hC/Tui04RjaBNOKzY3FGwPQrR6JzBobumxN5Uh/JIok3rcTwhSJiAi+Bk+T73pDYfw==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 AS2P194MB1981.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:558::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.21; Sat, 9 May 2026 19:20:20 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90%3]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 19:20:20 +0000
Message-ID: <BESP194MB2805CEAAF2A88AA555C9DF57DA3A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Sat, 9 May 2026 21:20:18 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Tom Rini <trini@konsulko.com>, Ashish Kumar <Ashish.Kumar@nxp.com>
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] board: nxp: Fix OOB read in ft_board_setup
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P191CA0014.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:54::19) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <10b1f183-d965-449c-bbd8-0c58d73d3f67@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|AS2P194MB1981:EE_
X-MS-Office365-Filtering-Correlation-Id: 46d7013f-1a08-4c36-fb12-08deae0002cc
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799012|37011999003|23021999003|8060799015|16041099003|24021099003|15080799012|5062599005|5072599009|6090799003|53005399003|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?blR0MkdJR3JOYVRvK2t5SjRKTTNjQWZRVTlsR3o3S3g3WGdIU3ptRmZKZUtm?=
 =?utf-8?B?eWE0dmZYV2d6S1hITGExNFFuNjNxY25qUHdveVJxUDgxWFAzc0R1T0Q5VEtB?=
 =?utf-8?B?V3FWOWc0cVNVWTRPVVJwN3Q1aERSZFA3UGd0WkxhN2hUVTRmV1BibEVXUENJ?=
 =?utf-8?B?dm5UdTREVGZoTnpKU2taSzd3Z0VIcGRVM0FYbCtGckthUlRXR0cvc1RJamFv?=
 =?utf-8?B?L0R6L1UyalR6WDZqMmV2ZWMyYnlyRE9TbG01R3VjWllwVDlVaTg3bmlUVHdi?=
 =?utf-8?B?Nk0wNDFCQ3J5REloWkJMaVNIY3QrN0k3T2VYczFZM3d0N0UzeXpmT1Y0aVd1?=
 =?utf-8?B?WlJkeHBjcUM0ZFY2bmtGVlJKKzY3ODcvZEFrTVYvU2ZabU9GSmRuL05rcW9L?=
 =?utf-8?B?QmJrK3BvUllreEpmdEt4U0I1Q2pMWHR0eXlGNWl4MDRTdTlMMTgybHFFVjQ0?=
 =?utf-8?B?dlhLbmxaQVRFL3JBdGVYZEFxaFptTnhKZkUwZ2tTbzB1MUpmYWlRTTB3Nk41?=
 =?utf-8?B?bEpHWElBaWRkd2l0QVZtYS9JYWszVFU4dWVkYUc5MEtzOGJTWlM4eXNSdExO?=
 =?utf-8?B?T3NrM2Z0dDVBN3JtY1o1SGNmbkRBT2lmM1BoTnhXS1dxZks1MGc4dEhDRUY2?=
 =?utf-8?B?SmtqTjZERm1UZDdlY2lGWFFibi94S2hHZ2cyaXFud055V3UvK1ZzN3lsbDJ0?=
 =?utf-8?B?cTIwODZjSlBaYXc2QWpQeDcyMlA0ZVAyczkwS0I5U0QwTU8reUlNazhRZUVy?=
 =?utf-8?B?SFBDaHgyWjcrRURGaTlSWGpTOGF3VDBaMml4SVEyTXdZaUlEbzg3OU1uRmVz?=
 =?utf-8?B?T0J2d24rMURzTkQrbExSdXZUc1BZaTlDcmlrRlVrd3o1dVhLUjRURVNoTUxo?=
 =?utf-8?B?SHBNeG82clU4d3dwYmVVaS9NQWFxSEZ5bE9yT0I4V0E3dkc1NDA3SWo1eTB4?=
 =?utf-8?B?TVJtSnBERXRFVlI4cVY2R3BEdE1QNVdnWFNqNkN5ZWQrVHU0allZSEdaL0lO?=
 =?utf-8?B?ZHNHMG8yaUg0bmJoTnllUVppTkg2d2VGWksxbWVIWW9iQkg2a2gzVmQ2S0d5?=
 =?utf-8?B?VUZtUlJncEMrN3loNVcwcGwyQnBnWGxtRzdZUE8wdEtOOExlUzNpVVZnYXkv?=
 =?utf-8?B?K3pnNXJTdXJLdmNHajVyMDVHMmZ3aEhFcVhnUE9DMURkSzRHSmNGRm1MU1hL?=
 =?utf-8?B?RWcrajI5dzlkUkx0ZGh6T05lMEx1ckFQZC9ENEw5NkJkdmdjU3hkRkRBUHlW?=
 =?utf-8?B?UTYvY1JXaFFYTEw4eEgvdXd3YjFuU2IzYTR2ajFwUHJKKzJYKy9zM2xJdGNu?=
 =?utf-8?B?bHlPc3l5V0MrTVlKN1kxVStmMFFERjljbDZkaFk4SkJsU3RWaWJUTFhZbDFm?=
 =?utf-8?B?K2dPdUo3b1FuQUVaM2lLWGRJR2x2VFRLeUptMHgzQjkrc0VacGlFY2duY2xt?=
 =?utf-8?Q?Mnk3uaEH?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHZOY2M1Y0JlYWl0UDhtaXdOMnlMQzdLR0x1Q0oyR1JUZVNsMzR5b2JCeXlo?=
 =?utf-8?B?eTdvUndNanFNeHFiR0RWSjE5MUFETzgzVGxSelFLMkE5WnhFRXo3VVF1UnJB?=
 =?utf-8?B?UC9BU2llNGFJYUM2OU0vSHNtcFNIdkVQRFByNW9yVnlmQVVUTnVua3hzZnZR?=
 =?utf-8?B?Sm1YbzQrYzdSeUtMTmJ0OFo2Yytpc1JBMkJVT0Z3YjB3ZC9UVUkyMktwZDh2?=
 =?utf-8?B?elQ2TjNMYUR5NzNuSE9UMnZsK3Jqb0dnbmN1ZDJyWFFvTkFGK1IwczBCV0d3?=
 =?utf-8?B?dXJac1h6YVNrMDNudVVWL2crSDhJUDk1T1Q5V21CUVQzSkN3c2tHRTNxWUFF?=
 =?utf-8?B?aWUrbGE1YUtYb1BmQlorN3gyYmhzWWsrbW42a3lTRXZuKzJsSzFZYjhnQWdJ?=
 =?utf-8?B?Z1BhSXRUUXVYMXlId1hqNExDeDhLWWcydm9yMVAxMVdPdWw2NGdiaTdqdlhZ?=
 =?utf-8?B?bkJycGgxaUR0V0IyUHBHZ0hERG0rMWQzcHNxZDN5NTZZQVhqYUp0ZlFXTFpj?=
 =?utf-8?B?NXU2aGVadU9yNTJrdkZjSG4xdHBOZndTSld3Y2RYaWprOWJpajZYRmdkOGVy?=
 =?utf-8?B?SkxhOGMzbE9hYWhyZHZVRnczNmRFWHVUSHBTVGoyUTVqbVJOS0RSTnZjTWhv?=
 =?utf-8?B?UmFjU2ZnMEhqTjM0dE52SnZKMElod082WGtBNkhzUWlXUUljc0YwS3FBMWZw?=
 =?utf-8?B?eS9tTWJsTlVVNFNvZEZOajFDcXltWHkwaVFQdjBqYjhyM2lUOUFlZnlLTm01?=
 =?utf-8?B?NVdkU2ZXSmMrZFAxNHl6VWU5NmN0MElTcFRsT25BMFFiWWFWSVV4d3RSczZC?=
 =?utf-8?B?V0tRbDA2cWZJSUxrM1lsSFZkMVNtMVRycVdsUGRKZ00wNFZqQnZlcDdYbm9G?=
 =?utf-8?B?V0lEWjRQUS9Belpzb1R6bEQvRFRvbkRIVXZJenZSUEg3cUk5QjZqOUZ6Vzhw?=
 =?utf-8?B?REVJcCtzZW9KTkp4Szd5ejI1Yi8xVEpJWTNBc0w1T2ZOMTNFZjZHWXRzWFdG?=
 =?utf-8?B?YkpxVGVOaGN2WDR4Ukh1NGtiU3F6Wkc3U21obnVUTGE0V1VodElUVU4xNXM3?=
 =?utf-8?B?a2FwUEFBNzRMNmpnMklJUVRIRXZMaEJNekowUjh6ZkZ0Rlp3WGx0dnNFUmZ6?=
 =?utf-8?B?bWJVTUdvaE1wcS91M2dOTThtSCsvQjl0ZGRwMFBSbmFRdURDSytaZTBxTHk4?=
 =?utf-8?B?d3Nzd0o1WGhPM2NKcFN2MDJmWFptNFd1KzZNRm8xVVp2b1luN3dDSnFJWUNU?=
 =?utf-8?B?L2FlU1UwS0FGV2NDWTdUTUI2ZFlremRFQWdtOWdmaFNBUzNZbVNCQ29NNi9k?=
 =?utf-8?B?WGtVYk1rSjdJdm1DTS9WY1FMRmYrZkVGYkg5MDRhMUVycVFOcGczWmNWRlF5?=
 =?utf-8?B?UUlTTjZ5ZVBtTnBkU1JEenV0SkFZTFdvcjR4aEpHZkJhVThKU0xQUC9MeGE3?=
 =?utf-8?B?L2hqam9MaHR4Q3RkRCt5cXRVWm5lL2VTdHZlODQ5TXROVkJFajM4c21hRlli?=
 =?utf-8?B?MEc4SGU5Uk52SU9NNEdCNEFuN1hiNW1YaVZaVlNkV1VFWmFVOXhLM00vaFpC?=
 =?utf-8?B?SEtnQUZHODhQVFlJOUd0VGY3WnNnaVRkQ253bWZQWW5xN2VwMC8rM0VHSWw1?=
 =?utf-8?B?NmlOcDRNdUloWVZhYmNWSmlmay9qa3lvbmNFV1Q2d2duajNaTGtJMXpJTE11?=
 =?utf-8?B?Uk1objhQejlBcVNRb2daek5aQmdGYTBrNTNnd0Q2M0JwZmhqdXBqZFdjSFhh?=
 =?utf-8?B?b0NTTk9WdkZEakVkTUNnZ29YUkIvN3J5MC9pQmVIdHdnMkJ0TmpNb3ZDRWlE?=
 =?utf-8?B?eWJGQzhtNWRWcDBidXBHYm5UZXpHV1Z6UkdlZDBpN1pSYVRkR0ZPeTl0dHIv?=
 =?utf-8?Q?So/TKVk8zrmq4?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d7013f-1a08-4c36-fb12-08deae0002cc
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 19:20:20.5038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P194MB1981
X-Mailman-Approved-At: Sun, 10 May 2026 03:41:44 +0200
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

base and size arrays can both contain up to total_memory_banks
elements.
This commit fixes the for loop condition to ensure that it does
not attempt to read past the end of both arrays.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 board/nxp/ls1088a/ls1088a.c       | 2 +-
 board/nxp/ls2080ardb/ls2080ardb.c | 2 +-
 board/nxp/lx2160a/lx2160a.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/board/nxp/ls1088a/ls1088a.c b/board/nxp/ls1088a/ls1088a.c
index 51ec055be63..5783dd8a403 100644
--- a/board/nxp/ls1088a/ls1088a.c
+++ b/board/nxp/ls1088a/ls1088a.c
@@ -974,7 +974,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 #endif
 
 	if (mc_memory_base != 0) {
-		for (i = 0; i <= total_memory_banks; i++) {
+		for (i = 0; i < total_memory_banks; i++) {
 			if (base[i] == 0 && size[i] == 0) {
 				base[i] = mc_memory_base;
 				size[i] = mc_memory_size;
diff --git a/board/nxp/ls2080ardb/ls2080ardb.c b/board/nxp/ls2080ardb/ls2080ardb.c
index 6f824f57c47..d08598d1c62 100644
--- a/board/nxp/ls2080ardb/ls2080ardb.c
+++ b/board/nxp/ls2080ardb/ls2080ardb.c
@@ -503,7 +503,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 #endif
 
 	if (mc_memory_base != 0) {
-		for (i = 0; i <= total_memory_banks; i++) {
+		for (i = 0; i < total_memory_banks; i++) {
 			if (base[i] == 0 && size[i] == 0) {
 				base[i] = mc_memory_base;
 				size[i] = mc_memory_size;
diff --git a/board/nxp/lx2160a/lx2160a.c b/board/nxp/lx2160a/lx2160a.c
index 341f82ce724..d34865de8c2 100644
--- a/board/nxp/lx2160a/lx2160a.c
+++ b/board/nxp/lx2160a/lx2160a.c
@@ -818,7 +818,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 #endif
 
 	if (mc_memory_base != 0) {
-		for (i = 0; i <= total_memory_banks; i++) {
+		for (i = 0; i < total_memory_banks; i++) {
 			if (base[i] == 0 && size[i] == 0) {
 				base[i] = mc_memory_base;
 				size[i] = mc_memory_size;
-- 
2.43.0
