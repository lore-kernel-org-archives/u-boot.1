Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC784F3D33E
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 17:27:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C45983FC0;
	Thu,  5 Mar 2026 18:26:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="roLGXFvw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F0AD83F75; Thu,  5 Mar 2026 17:40:11 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazolkn190110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 542FB80212
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 17:40:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/T8KRyQ68nBoMp15+fQulLWZIdOQ9oE1T/PEDox756gHUlWjLgCCzisXaUNEhQOo3R9NED1UZbsNeJmaSI5jV12PVDOkOQUj973dvYoCyYr9MOrOJww0BcRF/ZuZC0HubP68KuG+nhSBqiYdWXaYVr22IY8GLlVZmc1Aj6zYmSTA52rOHbSnZObg36EHvB1vPQS8FNzlxx6jT+mljxSOB5jytCJo8hQNXYqdqMTyuMILb+iT17jGA0rnLvw6VzHoJJsOhd+BSqRtGpcqP4/iox8MrzybuoCK4lScPCpoRCTZMIZ2YPz90Yiv3rHFvaVnNRPxgi3Xu/jvVKO7Uuy3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKtPqmBe3a6FMw+BjS1ZlRWFK5r6pmhpue+4gaDUvGc=;
 b=MZQVH0avKOXMH/k8yqxuq+zUsOwPMga57THJyRtqQr/Qhzh3HiiBANAdyXgdGDBzaRPrtxFXlK0IRkdL11J0uQhBtJvZZfL1kR8Fkv5ADn88uwb2sV4WE834rrhAQK/3IQWzmeo3qd2NMEZtCnkz+s776tYLoEXubfKwBA1PsBBAtZWDp/uVCpgfM2l3Zh8OQcevzwhwxDUes/mioxFoqDRzUDcE4WbFhmE6LeCQPQilWBWKz9j0caPZAeB6PsjsNAcGRGxugsLmn+M96JjfF6GbHXtr/t8DSu2/sIp/hMtMLE/XzPNc30IMAM+GMwozzc5iKH8oIdvGRCT4E6imIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKtPqmBe3a6FMw+BjS1ZlRWFK5r6pmhpue+4gaDUvGc=;
 b=roLGXFvwjfSxv79yP7ZxIJNqMKJy4iGbrpuXTUNYwUH7Rm0P6GQ1u3kzO2/j68FHRtQ6WrROT+IQR2fPTMFRaanKrwiDno7G9zT00exubIekZ7l83+Up6sZxZx4gmn5quhZvfbbKXXDEFzEW+LWyfdd5On5b/yjdzoh0uQSHyH1g26zLiqYdzeukG9paTQRZeDWe0cj1VeP5Yp39YeejFE3cHnYPeHQso8eHSnvhujG8uVLjTqXxIgdlf2mJ4Qcl3J5BOR3d93fkg5g9iyEfWMEqZicFKLMcO16wQgEnSBsKZZhNK8dAfDQSTkluLnyahxMTEEz7WoU9iPBVTa/Wug==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 GV2P194MB2419.EURP194.PROD.OUTLOOK.COM (2603:10a6:150:268::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.16; Thu, 5 Mar 2026 16:40:07 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90%5]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 16:40:07 +0000
Message-ID: <BESP194MB2805D33449ACC71126A97133DA7DA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Thu, 5 Mar 2026 17:40:05 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] liebherr: btt: Fix buffer overflow in
 board_fit_config_name_match
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0212.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:374::9) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <71096a6a-1cb5-4b29-913e-d56e79af2902@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|GV2P194MB2419:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b3dd41e-8655-46e6-4514-08de7ad5dc14
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799012|8060799015|15080799012|41001999006|37011999003|5072599009|5062599005|461199028|6090799003|23021999003|40105399003|52005399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ly9uSWRnMW5hR2tIakxnS1EzbmFtbzAvL3RXa1l2d1FGeWQ3emtpbVQ3ZkIx?=
 =?utf-8?B?VFlPejJvNmVUUkRlTFREYm1rY3Z4VFJwZ3M2bGdTcVZ0Tytaa1diTzc1alh2?=
 =?utf-8?B?clNuc3Z5TWZJcW9xR1B4WGFUT2x5aXVMakdHektadVBFVkgyZ1Zxa1IwTEhZ?=
 =?utf-8?B?allaMmw5c0NCSmFDK0IwQURNSldrOXJwQ3NMM3AyUkp3NjluZU12dzUyQUF1?=
 =?utf-8?B?SWM5TmJQVjFvbjRCQytQblYxa21mUG56RmJqRjJyeHhCODhpa0pOSTFqVkFr?=
 =?utf-8?B?RHFxcmpMaDNaVVh6TklKd3VCVVptQWwvQnM2NlNZWk8xaUQ0YXcvUXN0K0dh?=
 =?utf-8?B?SHF2M0hMZElxOGswQ2RsRGlXRUhxQkJFMUhRQlR5SkJIcmFZS2IrcHVEU3RN?=
 =?utf-8?B?Zk5hOHFKUU5lSStWVnAvdExjV29QT0UzZThJZ0E2ZkoxeGJ2QTFHSzJxZmly?=
 =?utf-8?B?ZU5xbWxjNGRCUHdoQnhML0tFdXdCU3V3Vi9qU1dIV2x5bU9NOVFjMEtBelRv?=
 =?utf-8?B?S1pGYjhTd0JHWHR2Y0s5M2J4VUZ2YTNVVHIxZlpuZi90ZXE2NCs3Qk52UHNj?=
 =?utf-8?B?WkFLQTdIaDBmSGRPRHFYL01kRWE3WFdGcUtvQTEwd0NxU0t1NEY4Smw3anhI?=
 =?utf-8?B?MG5NSTFTQVlDamJkbCtQZEtFWjkzR0pIekZBM1V5T0o2cUFVVHl6ZGc5RFEw?=
 =?utf-8?B?bWZVWmZoMVhTTDhZMGVSV2dXNzNYN3Z4eStxR3RoRFlaaC9FaTM5bk1RWUhU?=
 =?utf-8?B?TWtzT3FrcU4vaXlxKzEzWEZ4cUtOUWtJV1VrR0lrVnRCa1dmempBWnFKWFdN?=
 =?utf-8?B?SEpOaDVrSFo1QnF3UHhzZHpSN292ZXQwTVBvdGRYdGdPRldGZFRkdVZQOWdq?=
 =?utf-8?B?QkVWcXRVMmZmZzZIdmxwQkQ5U0htVkFmQ2xxQVBSNXZsQTVSQWI3em1WL1ZH?=
 =?utf-8?B?RzNFWkI3aTc2Skh5VENmUFFGUkdZZTVJZG42SVg2SEJYWTV5TUtpMWpqbTRE?=
 =?utf-8?B?Yk1mQklHbm1ONVpFblVCWWViS295TFd4TTJxa0RKUG52WkNDZUxOQlBRVGtP?=
 =?utf-8?B?alBKNkhlODBocmN0MnY0UjBQR3RZSTBJZEpOTExCblJneEQ5Uy81WmliV2xW?=
 =?utf-8?B?aHNZN0d5VHlmVHhKMWZVVVgrL0twWEpXVEFUeUk2WEs1Yk03NE9PWUpPV1pJ?=
 =?utf-8?B?c3FFbFliVHVMYmtyTElFNXZXWTF2VlJDQk5rY00zeS9VYTU5OVF3VzRMaGlR?=
 =?utf-8?B?dytrMUs3YkhPemh1SzF1WVFLTUk5QTlramVzMFhGUzdET0hmWkNtSTM3eUpH?=
 =?utf-8?B?Wm9NSnBLZDdhcjljM2dzUWtHcDdEQnM0ZzU3TUx6dldUQ3VkcUxZOTRaRGpk?=
 =?utf-8?B?eHNYS0Z2N0phTUE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU90STMwd3pydUp3d2dlNnRxU28rakc0VFNua0R3Q3VNendKSS9BSUlkczlp?=
 =?utf-8?B?S3hEejdYZndaSmVjbjY3U0FmVlpoZnI4VjVHK1NrZWorVkEzSUlhb1h6S0xh?=
 =?utf-8?B?Y0VCUG9ZdFFHb1ZIK2lMNU1leVB1Z3BwZUVLRXAwNG5uY2Zwa3pibVR3TC9W?=
 =?utf-8?B?M1FHU0QzVXRaR0RXS0RWWitzQnRlM2RzT0g0V1JDeGFzeThGeFlqcjl6OUhs?=
 =?utf-8?B?SVhHS0Z2OEFkbmluSmI2aHg2WjdkaDNFM0hMditFaWhiclRMZUl6bXRhRFND?=
 =?utf-8?B?REkxRkQ4dG1lOGRCbFBaUHdVdnpiOFJFRG5Uak5vYVRQRW1leHpOdFF1UU8x?=
 =?utf-8?B?ZXNCS3V2R1JvczdadTUyRzF0VDVydEdmQytLTmlOdnZEOGo5UVVmd2tvYXV2?=
 =?utf-8?B?ZGpleTRrMFhOQ1cvNVpzUXB3MENRU2tURXpKU0krWUtYNVNoeG1Kb2YzRFRl?=
 =?utf-8?B?UkNZQ0ZUbXFDWGVsWUpRT1A4dDRxM0tlcEgwVjFvbmhFQUxKRWQrWmxNNkFw?=
 =?utf-8?B?VDQrWVc2R2ZpbFRNTEtxeVRvTWpRT1FkMmJnVktMMm0zMy80NnRWb2RtQ0VU?=
 =?utf-8?B?Tk9UdlJvb3prSTh5MSs1ZnFmOHJiN1BUOHBBR21WV09DNms3ekNzRFlhemlP?=
 =?utf-8?B?L2F5amM0a0JpcWZJeWZEOVlreC81S3dYdW1ObitlR1RJSVkwTS9RV2YzdWZT?=
 =?utf-8?B?UDJ5bTI3VzQrWjM2SmpxdllTZmFyMXZzQ3dmLzBsenlQNGEyWFIxZk0vcnNE?=
 =?utf-8?B?QWZ0YnpDeWdPVm81YkZYM2dHZmJUR0FlT1RwTGVxNElGeGFFV3ZUYXoxRjht?=
 =?utf-8?B?QStwWWlSNmk5dU51eEpHSEVJdUNOcUFWYkVheExpUGo2T282MC9abG5FWDdC?=
 =?utf-8?B?TUtyRWQwYjUvMmkzRm9kMDNrWGZ3Z3RZcWFjVDBPWGx4U2VJMkdxREVFUktD?=
 =?utf-8?B?NU8xKzNXMVhXL3Jmc21HeFVUR0hBM1AwdlBLdUlacEptT1ZrMUI3dFpSZEU1?=
 =?utf-8?B?aHF0aDFFYzZJWC9XdkpkMW44ZnlpZGE1ZFVTTEY1bklWelhkSnVqM0dCNnM1?=
 =?utf-8?B?Q0p1L2gzaXFHMk1UUXcxL01mQWtVSjJKTHJtbW4zVEJnbGNsQ3VQVE53YlN4?=
 =?utf-8?B?dUVwNTVHdDFaQ25uY1NET2lKeG5LV2V2cW83RmEveUVWVXhwY0QzZEgvOGxV?=
 =?utf-8?B?bzFGYlhwSjFUdlFsSmM4SjZDOVVtbFhyMUZiL1R3SnZFYWMrRWRKeW51YzlJ?=
 =?utf-8?B?UTQzeEhCSE13WmdhZTZMSkM5bW5HU0toYWhFeFZEeDEvR01xOGNMek9zRUdE?=
 =?utf-8?B?VVFRV1A3ZmVuY2FpZ1YzQnFhajgycUg3TU5aTmR2U1h0UjJ6UkdmQjFrQ0ZL?=
 =?utf-8?B?SVhXckxjalZjVStYbDFEVUlMZ3dVb1pzOGZTWkFObDJNd2VOMFZoRlFZQ0pP?=
 =?utf-8?B?aUxXOGdDVlNiNEdyNnVWZ0ZVd0pxRmhYQktmM2hpeE1jcmQ4UEw4MUFCNTUv?=
 =?utf-8?B?dEFrd3lmK0grelk2eEJFZ1h4NmVLam5EZmY2eE9kNkxaWUQrU3ZoL2JQaWlD?=
 =?utf-8?B?TW9RaklhVVpzUVd5S0s2TnhuV21kWFVMRWZINlZpTlBueWFZaTJYbEZLZHRM?=
 =?utf-8?B?Ukt1d0RDcVZ6WGpSb3JiWkMybGFmUml4Mk1ubUxraUIzdHQrUmhNZXRJalpm?=
 =?utf-8?B?aWRsOUhvOEVtZ211djhFbFR6akR3Sk5oeHdBNnNQc0c3V3IzUG1xOTlIbU9o?=
 =?utf-8?B?bG1DS2Q0TUhNUVltajJQS3drcDdyWTNDSTFpTGVNeVZ6cmxuQ05NWDJGTjRM?=
 =?utf-8?B?bTBqTWh5cStGU3QvWHcwWThCK244aTFGVG5PY1ZyeXhMUTRvdWFnZXVQOXN6?=
 =?utf-8?Q?N462qv6YbbJ+n?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3dd41e-8655-46e6-4514-08de7ad5dc14
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 16:40:07.5634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P194MB2419
X-Mailman-Approved-At: Thu, 05 Mar 2026 18:26:35 +0100
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

The maximum length of the board name is not 11 characters
but 14: 11 bytes for the prefix + 3 bytes for the u8 + 1 NULL byte.
Hence, this commit increases the size of the name buffer variable
to 15. Also, this commit fixes the format specifier for the rev_id
variable.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 board/liebherr/btt/btt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/liebherr/btt/btt.c b/board/liebherr/btt/btt.c
index c4b6c37e495..dc683bd082a 100644
--- a/board/liebherr/btt/btt.c
+++ b/board/liebherr/btt/btt.c
@@ -393,9 +393,9 @@ int board_fdt_blob_setup(void **fdtp)
 int board_fit_config_name_match(const char *name)
 {
 	u8 rev_id = get_som_rev();
-	char board[12];
+	char board[15];
 
-	sprintf(board, "imx28-btt3-%d", rev_id);
+	sprintf(board, "imx28-btt3-%u", rev_id);
 
 	if (!strncmp(name, board, sizeof(board)))
 		return 0;
-- 
2.43.0

