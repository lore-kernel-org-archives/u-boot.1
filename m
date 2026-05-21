Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7D7CD5BAC
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 19:11:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FC058486B;
	Thu, 21 May 2026 21:11:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="TXnMgz+Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D53B84825; Thu, 21 May 2026 19:52:44 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazolkn190130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d20a::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BED3846FA
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 19:52:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mo7oaylrvG6Q8JijjuO8PAt0Qn4np3DxtiK38Xsay3TbCG3/h815Gxy6yjMK8aF3YRjg8PPlseFf49a4rmyTRGVwPAbm6XkE++AB+VYPdYn/A/1nGCRb9EpUDA/kJ2NM/aNSI1JBe9moKDMSeTbSW5Prjm3I376urySqLXcnhkw1Tct0QbHjyyYxXP1TSmgB0zNYWIV4pX71eqh1HL5faCwQeoo6j5ep5jLgyukkHh5zu+3huY2mg/WE2q+7nou40Qtlt6UL3GFBNsZfEpYvsTQgU5XEhBHPlhr2a0vvxBC4r/P4199XaDmut5a6qKoZKpwMed4BJV8ZNtEqYG204A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qClQpgo+o3+93F3CPsUCnTCLjwRztwMq4l8YFoKVkLs=;
 b=cuJy0dswEfK1s6IlvjfzA3DRjE3YBSQwFAMv+du+7fxBjC+Biyja9gkBnndK3xxCb+Da8IKPYiVHE3WBJcxkyzlS0ZvGY6AHFjbuuLHWm5hQf8kNRt5mVkOQOhd0szZ4Ub0DujLHhhRuCfrOvnQrE3HhGfHCunJYCJ1c+WROCIuPuDZ/zLoeh31Sw4E7PiBzwULx6dZCoozlxLNMkC7Gf7IQiO8wJW4I6CuSv/NXPf7foKDseKtGHt7C/aXdF4lFx4KvFGCrXa/l6Ki5d3UCX4GfiB4Fjb7/fHKoyTNTaV0eOixnoR4t77zLbQx+6SLq1MzxEW2MqBiejj99ugrJUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qClQpgo+o3+93F3CPsUCnTCLjwRztwMq4l8YFoKVkLs=;
 b=TXnMgz+QOyoEkOQOvyTe+r3YypZHBAJEm2vS9tuks+2lkyUEQ+WPgzZ9jYdA8UggwkplVlm8ne0/XOXd5ALdq/6XXapByRMnq1rFxSAaj8kC8j3Om8kx2vjJOMYNlvQacxtcw+h9T9iV2+UUqSIwUrXG0jZRrRkm3m4hCJQwha2fGk85oyZG73w9/IlSLIPuxFjiUWHyDedhtY7UjBsMM+4scrQBC86nX/hQtCmzmyou9tygDIDJZKSegcgY8XIhOIgJ/B5eSzWXchK2TLsitzy7wi2ynXrfmEs1BvIV8uXijkWOvqC+ljbTGFhMXngJylDsh/nEh1opxMlP0oSbpA==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 PA2P194MB2268.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:423::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Thu, 21 May 2026 17:52:41 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90%3]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 17:52:41 +0000
Message-ID: <BESP194MB280584A431D400DDB6A9E2E2DA0E2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Thu, 21 May 2026 19:52:39 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>,
 Tom Rini <trini@konsulko.com>
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] drivers: serial: Fix dev_read_addr error check
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0277.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:373::9) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <25d916b4-13bd-41ba-8907-bc2a198f083f@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|PA2P194MB2268:EE_
X-MS-Office365-Filtering-Correlation-Id: 924bf622-3c88-48d5-3fed-08deb761c122
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|37011999003|6090799003|5062599005|24021099003|55001999006|41001999006|8060799015|5072599009|19110799012|23021999003|15080799012|52005399003|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHZ6VXpRcmtxVmYxYjBhVjFRQ2lJR0pJbzgrM2hWZFI5Y3JEMEhNWjA5Zks5?=
 =?utf-8?B?TnZpbXAyU0xPOHlMYlBUNVdwUzdBQW5WK3IybWFEamI5S29WazFicG5LS1F4?=
 =?utf-8?B?Q3doK3hIQy9JU25WNVB6a0MzSzhsSmxPNlF1V0U2VFFkWVlRSEg3bE9yNVM5?=
 =?utf-8?B?SVM0VGljd1l2bnQwRjBISVJyUUpuN3ZBWFJkbGFZUFM3MWRhZ2FVSDgrZE5R?=
 =?utf-8?B?UWgxYktsUXN0ZkEzL3llYTRkZFllNWpGM0RWWGRwbXJ5WlFseXVKWCtkU1E3?=
 =?utf-8?B?SmUrWjFwOWtTeVQvcXRjSmYxTGYzVmd3TkJRZlRJaDZSQmN2eTNTS0lQZ1Ba?=
 =?utf-8?B?ZmxpQUtXYVBGSWYyTjBBdmd2RnlFbUhrcFhpZm4vTUhyNUNWNVN3M1BUZm93?=
 =?utf-8?B?Zm44SjFoSU5kcEhoUnRCSlNFV29CSC9XVkFjSy9Xc0xldE5UTlA4SE1VVFBS?=
 =?utf-8?B?MkxqbzFIRTdtN2FlSXZMS01CZ3VQNHBESU5oMml5ZG4zTFV4UWhDWVpYQUNC?=
 =?utf-8?B?ODMrWG5KQWJVamxXdkZsODdFQ0tDMFFudE5sUWJ6djk5eXQvMVJoN0FmcUU4?=
 =?utf-8?B?SVI3TFNPWnJxZVE3bkRVbkxleTA4WndhcGdvWnV5clVDSi9kakdBQ055OVdj?=
 =?utf-8?B?WE5QZDk4R3RZOG5xS0R2WitJU2hocnZLck9DdGhWY1UzQTlWQmhudlpmaW40?=
 =?utf-8?B?NUZXa3BNbmxwKzBuZC9sT25henJwaUV5cytWaHYzL0JBL1l1NG0zbXRZUitk?=
 =?utf-8?B?UkdUbGdxWjFtd24rODl5Q291TU5GWFJlRUlHOXltbC9LOWcxeCtKNFJ1eHN5?=
 =?utf-8?B?STQ3VUhaeG9ZZmlZU2RkS3NyZXlUNmxwVnNWMUVVWTkzcCszQnVzeFN6WXA2?=
 =?utf-8?B?bHY4OElhVjRhT1Evd2xzQ2pNd2l4WnFjZGhoUkJrOEh4RFJvMFpHR3RVRFFa?=
 =?utf-8?B?eWY5aEZaMnhQRHg1L1N1akc4TjNlSDVqNU5NQ1pKU3h2cDNURTZiUUtOZVRN?=
 =?utf-8?B?Q1ZoR0pQM2Q0dUlHekJ2bU12cGJ2eUN2c1hNVm5WWnB5Yk81YjY1Q0t1MVdK?=
 =?utf-8?B?U1JjZm96QlZYQzZodm5NSVhDaEYrR3ZvV29QVnB1NXZ1MVR1QWtacWdXcHNT?=
 =?utf-8?B?ZlJKdDVXT1BWMFZDZjhjYTZvOFNzb3NLMStNR3lrS0RIbitaM1p2YjJ5UW9K?=
 =?utf-8?B?S1RhanhKZW40RW00ejhmT2E0KzdPdHJZTnNQS2E3bUNEanpUR05jTzlPTVVh?=
 =?utf-8?B?aHA0NXJuRlkwaTNHUktncmN3TlMxYnBHNnF4MkVGbWMxNHpJYndoWlA2QVh5?=
 =?utf-8?B?YUdZZjdqNkU1dFpudCtkOUhSUldFSmN4ZUR6a3YwQUxQL0kwTjZ5ejBOZHhj?=
 =?utf-8?B?d0xtbldSWUJpZVQ2VzgraHlJR0RlR3hpOEZyNUswZXVIWENsT09CNHd2MGZy?=
 =?utf-8?B?M212Z0hRUldQajg5T0poM3hlNzc3MlR4TitXdy9nPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUN6clN4REx1SjVlOWYzaUhEdm5YaFd5ckQxbVhHYUtJcWpaL3JvU2Qxb0ZX?=
 =?utf-8?B?alNXL3hVdGhIdWlMRFBhL3o3Y3BaVXhrV0NSWjM5SGtXYmZTMldsZm5rT1BN?=
 =?utf-8?B?ZElqVm43K0FHTjdLcHUzU1VQc0cyM0dvQ0wvaVVqSTZFcVY0ZkJxWllCQldx?=
 =?utf-8?B?UHJnYjIzQklHOW9IcmFXaFJiTEhDQlBlbFlyZmNTUktqSVA4eVV0WFVEa1Ja?=
 =?utf-8?B?Y2pzZUlaNkQzOHlxcmhtQUlPOXZQZXVJUnJVdzBWVnpEZXVTWmxCN2ZYNWZp?=
 =?utf-8?B?ZWRuMi81RXoyS3BaWVM2U0FYWmc4UkVCY05uUUFEWmhnUHU2bkIwYlZBdmh2?=
 =?utf-8?B?R1VyZjNwSDlrelJuTG11Q05sdlFXV1Zsb2FvNUp6Z0tvRFMyVXovcHBUSlcx?=
 =?utf-8?B?L0EwdTk3b1YyRElUWXBQSFBaQk91eDNkQ2kvNEw2TnVUMmVUVVg4dG5HYjZn?=
 =?utf-8?B?VEdRV1Jua0EyM3NIMzZBdTkrbnJ6N25IN2w1M3FiYnZNZWV4V0lXbnZDQ2VS?=
 =?utf-8?B?UjU4S1hVMkZkSkJsL051SUhQZWJLZC9JNmpJZjF2c1RBbXVVSUxBUnUvRkxL?=
 =?utf-8?B?dWhoWDB4ZGF6bE41MHNSeDhDcG5XVVgzR1dhUnZsS3VLelgrQURpMW9pT0lK?=
 =?utf-8?B?S2sweG5VS3Zzb1BmUVZrTG81RDBkOWNvYUNXS3pOOG9qREtXdE9ETDNoYjl6?=
 =?utf-8?B?RDc3bWpKVDVSakxGVHMxcFZiT1FocDVHMEJCQXhidFpNcUh0c3FVYlpzeHov?=
 =?utf-8?B?aVZrcWp1UGVpS0JBRXp6UG5IUGJoK2h4ZnRGSk95alh0OFZHZmhGOG1wcUhj?=
 =?utf-8?B?dUhnU1hMN2FuYk1xVUNKS0RqVFNMcXRSUlVsVnN6TzljeGo5WURFWXE1MUc0?=
 =?utf-8?B?anoyaUhTNDYrRmtiZEtkWHVjZXdDOFdZVDZoRHRYOGpaNjBDcWlsWGlNK2lL?=
 =?utf-8?B?T0V5WWZYZXdRU29QTXBHV0NTR1lCVUkrVUlySlRoaldIcXFhZHF1SzhIWVJa?=
 =?utf-8?B?L3ZkRHhEVnRXWDN2dUI2OUNiTUpEeGRlYjVnSkhSaHJnNVczYUs3bEN6SGJj?=
 =?utf-8?B?dGFNSTU5emhybGp4UGVpTlphRUw4QUhiQmFpaE1OZ25DOENGcVI1NjBRY1pH?=
 =?utf-8?B?SHY5M0haRHFEdlJuQUh5NG5iWEFnN0FaNWZ4dmcxNFdOTUNCVElYTVErMHov?=
 =?utf-8?B?RUMzOUlrNWdGeWhSNWthTUtpcnpqNDAyQnU4Q0ZPZ2JWYXBBTVQxNnhQdFNK?=
 =?utf-8?B?N0o5Y2VVLzV3WEtYQkdLZDlTS0g4NHI1UDYwa3c0S2JzNnFGNTZydmt0Yjhr?=
 =?utf-8?B?djBHRnVzQVFwN050UmtqeXBTcmFRNCt5bTRnQ2NuVW9ObjZnTW15ZENpb3dQ?=
 =?utf-8?B?dVNrVitWMG4rcGowd3gvRXlKVDlaR3VlQ3NIQUJDdmRVTk1ISE1BVzZ3WkZn?=
 =?utf-8?B?WTlJbHdIUjBDcTVxNUtYRDg2dW5vWEl2N3lKYmZYS1Rua3F3dW03OW5aNmYz?=
 =?utf-8?B?bVF6SjRxRHR5Um1YY29NZzFUUi9PZlY4bU8rZEF4dUVzVnB6NWhJcTVNWGlj?=
 =?utf-8?B?aVM4M2lmOFhDcWRmU25qSXhVOUhmM1pzd0hWR3Y2bHYrazZkaW9kOFVNZGkv?=
 =?utf-8?B?NmFrSTFmakdOT1lDWVRWbitUTXhLbXB2SHNnc0Y2MUZOWlZQcmd5QUUwRVRN?=
 =?utf-8?B?Vk9WMys1WEF5L29PMXRCcHp3ckdYWkhHOFVjalcxbWpCWlFtSmZxSUM1MmpM?=
 =?utf-8?B?bnBJQVJwOUpLZ3REeXBkWStSTTJub2pHeUpnVmw1ajhGTTcwVDBhNmtNUzF6?=
 =?utf-8?B?ZHZEVGNXL2hmZU9LRHlsSGsrZGZZTUhvUmFoTnRZWG9ISnplNTBIVmJjWUlG?=
 =?utf-8?Q?bJTtbmwQJt6Dp?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 924bf622-3c88-48d5-3fed-08deb761c122
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 17:52:41.5211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2P194MB2268
X-Mailman-Approved-At: Thu, 21 May 2026 21:11:12 +0200
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

dev_read_addr returns FDT_ADDR_T_NONE (-1) in case of error
and not 0.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 drivers/serial/serial_sh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/serial/serial_sh.c b/drivers/serial/serial_sh.c
index bc205234e24..7debff6cb3a 100644
--- a/drivers/serial/serial_sh.c
+++ b/drivers/serial/serial_sh.c
@@ -257,7 +257,7 @@ static int sh_serial_of_to_plat(struct udevice *dev)
 	int ret;
 
 	addr = dev_read_addr(dev);
-	if (!addr)
+	if (addr == FDT_ADDR_T_NONE)
 		return -EINVAL;
 
 	plat->base = addr;
-- 
2.43.0
