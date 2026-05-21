Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB7DCD5BB1
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 13:12:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22E7B844CF;
	Thu, 21 May 2026 15:12:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="UxWisrcL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 692448460E; Thu, 21 May 2026 15:05:52 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazolkn190130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 620DA805D7
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 15:05:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxN3ZFtgFkWzpzjZfRWLqEcoWvxbYIcxeXv6CY3FY0PuCPYO9FR1ngdKYzyl9IubTLkGJV50ANAJh288QOd1xfS5ezwKjuGz9CeO8Cl1Iefv4QGm+4adlxfO8cEOpHaKw+yjbNCna3sXKsDiYTDOQ/PsTGbosOycHU+cOu8YPS/ADFNhFGvZhALuhdnmTFdo7EbCaRHK4qkeFaEP0svtpvk+XFq6IMRL5tQRBCDMFh7YgHSqp+t+IkiAT8a4IEdEk2xnYHDuiI03YU2AILOLV52X7LSf2Fh/DF9j1RSZSs5kb8H6Whs2+atRMs3UOMvxy9rzrMBN7SbV+ODDMCQDww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOUwkXmBGCl5Ilpo4+Li9BuNEAuW/bzgtTlCOnTNMKA=;
 b=cUwFu5nqnNtrtgFwGOfMqrQl+fXgjyjVYporLIDgdx/upIQPkAuh+o5VKSDW601WMVeytJ/3EWmo4vZQPy7m/alLRp3y7KYKyuPmL+JK3tEs883cJnYSRr4dpLAc3P+p0A6tuWQEX4moX5d7vio3JpalOV+SFRLBCdu1lKaaVGumGSP/R3VHejdZ1pIL0g0WFBgCBRgpK5y5sh2UEvlepkIYdEoDCYlbit5k+r+7AKX852JRHniP8jhNgkqVqdOMGy285ic3QHjuXdKR3ckdVn0WKPPKuw5NwPQzQJ+1VDIDeknQdTB26eXKdLrh1/+70nSPPfMp2NJbaBTgDFWc9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOUwkXmBGCl5Ilpo4+Li9BuNEAuW/bzgtTlCOnTNMKA=;
 b=UxWisrcLn7vEnPT4mUEx9zZn+x7MNaXT8FqVf5xSb1koHSvLWodgWnuBDIVHZneev6wbyFTlbdiDDwMXDHhDB1bA9AzDBT47JSsFn9D5C5nMJ4tFezxLRjERd4YYzZRph5d0D3WVn9CIGK5977+oH58qtk002QL6Fu0ttlQgm6c4vudA2DGuw1EUIRnZesmtlKa7VQvDl7feYj0tiw1owSwdSDR4MLWpDMmEe1pnB5b+Yi3ypgrQJUlvUp5+TLVOHZ/Qa+d/NBcUgnOF1OfkfF8bpfkXWBs7OwlQbNrfWrOMByzG+WhXWaLkRLemNdOrQyXk4bBytJwiAS/+wX2LwQ==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 AS2P194MB2123.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:643::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Thu, 21 May 2026 13:05:48 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90%3]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 13:05:47 +0000
Message-ID: <BESP194MB280513B376D54A815F3FD507DA0E2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Thu, 21 May 2026 15:05:44 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] arm64: versal2: Fix buffer overflow in soc_name_decode
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0255.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:371::11) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <2d1bc779-ae87-472c-8de5-f6c4f9072eb3@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|AS2P194MB2123:EE_
X-MS-Office365-Filtering-Correlation-Id: fc59235d-df47-4b60-68c6-08deb739ac6f
X-MS-Exchange-SLBlob-MailProps: 9IecXKUgicCYiNQ16Cvk16DmsQFvMA17WOYwRy69bymxtchaKWqa6CpjwWMqoAo33gQRseIe/b5tEPUlNUvBMJHzq58sn5Cv94ngNDoIom9LBpDYDewZOkqporQv6GjN1xsUTLZXJLaf4d4SvrQKggSei/Wi/4Q6RJIAYwppfdmPUmwCebL/APfIfbOPk57Wa1LABsAMd2ossOhmFP812a+fZB7OuWQWRz43OfTqB8YcmcP4Q910XMz6hUH1CaY5NPtrTm1Zb/BhyvdAy63Av0/honeSACHfpmGwBytWR15U6tY3HUTCVIA3qjfDkyggXPd8w/LTJxEEuv/w8XUKbkrLutCWSz81oLZS2jl7FSVtwUz5O3J7ge3YmQU4SRV7dYwaHQeReImkaaGB3bMivC8F9wXcUbb3RhAOLsODP7wDvcrh56+3rXVZaQikwbLKKwqdQtyJgC94gRnNJMFrlxDq1LpuM2r0LQnCvMVqcwwZNidyCwa4ahCOgA/71d281J7oXnihKFrvNSeBhtR1sSfWYana2grBfzeA8jYgLE5SsNRnvhr2zE5GT3ohIpwAZFBj1b+wMUF/wn9RpWDUJoFqWmMmwgW2+s5vA7Xu6SvvRiHfOWHaZmGiTxry047jirW0bdCXK+Sm3VMf1VFHI4RFNL4fD9rcVXlur+3Q8JFbnDMGfQNgS5SkJDKsBj+37JayT4h4O21q/RK3LQ5rq7Jt46NS8NRvy1goO1CyPze4SECLmYyW+Q==
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|5072599009|37011999003|24021099003|55001999006|8060799015|5062599005|19110799012|41001999006|6090799003|15080799012|23021999003|52005399003|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UTRIMk9WOCthT09NbERFdmY5SDUrb3F5ZFl5ZkJrN3ZJc1JYRlVMb3pURWQ5?=
 =?utf-8?B?QWI0eTc0NlVXZllkc2pTVG1aa3g1QzMrK2FDM1U4Vy9weG1YYWFvblAwUXhw?=
 =?utf-8?B?UkthTDJvNGMyYXBIQXhpQTFnY1lwQ2hpY1NNYlRXZU1vcU5GTWx2UE9Oenh5?=
 =?utf-8?B?MHhqWEFMOHZLdUF1QnhlVzByWVYxN0FlRzZGclJ3Tng2Qk5oa0NMdTN6THEw?=
 =?utf-8?B?cEdScEE1ZEFzcFVGT1JLTk1rL3o5ZmMzc0RXY05NNW9HNXpLTFR1UTd0Mzl3?=
 =?utf-8?B?RmtFMVZoS1lqL3ZNV3NORlpCNG5WUUI0K3VLREdIWHFhR1dWRFU1WDhaaktp?=
 =?utf-8?B?UUxLUmdiZTdjak1IdDdqVDVPOUN5ZFZwMWlTUUM3WGUrNGNCOGJmenVzSFd0?=
 =?utf-8?B?MlJnRVRKdEFMR01RNHo4MU9Ibm41bi9oa0dtcmZ4REpDZk5sWHJHa3dzVjZt?=
 =?utf-8?B?R0diVlRIalB2WWtFUEhRWW4zZ3hsSWtOMnA3eUhaeWo1cHlUTlRWc2tzZXZH?=
 =?utf-8?B?b245YU52bktsdVE1QndacHlVVlZoTFFYR1V4RXVaNi92Z2lqdmo4UkZNQUph?=
 =?utf-8?B?bndlaE5WTWNTcDc4ZXY3NXdlKy8yWW0wLzlnZXZ4bFFWa25jWmdicUFyQWdJ?=
 =?utf-8?B?ZHdGWE52RGNUUjBCSUU3UHJTelo0cFpJc0JINGdaZjg3eG1kQXZLWDhYMnNa?=
 =?utf-8?B?MjJkRnhjU2phNDhrRWFYekgrSGl2Vnlad2gxUWRDRnMyaWpQOVBiYlpieHBR?=
 =?utf-8?B?S3psVks5cWlnbWFIY3JSUEY2NmR1bk5ueFEzQUl3eHp5K2FvNnhqZi85eFlX?=
 =?utf-8?B?ZnNDNVdRNWlZblVsdTJNbnpRUU9ZaEt5Ny83U015MnpwSGdDSUg3VHZTYkV4?=
 =?utf-8?B?d09qb2J4S0QweCt2SWgwbkhWa0FocTFGZStDaytpUE5BeG9jSWVwSnFxK2dB?=
 =?utf-8?B?RUVqN2ZXUVk3bUc5Z1pseGpJVUdza1pVcnhxRllGZ25obDYxMzRHeStIaE8v?=
 =?utf-8?B?RHFEcUVVZ29oNEVGWWMzWTBtdWdBUEd1NTk3cXQrMUF4SkdsbGVxdVg1dW1D?=
 =?utf-8?B?SEhuaTllRnB1alVjSlByeGJMUEx0SmI0WVRyVENwQmtXM1BVUU4vNmN5elFT?=
 =?utf-8?B?NXIxeVROQ3N3eDM1SlJNWkpZaEtMV3p2Ty85K04rTjJyTUpBTnBROGZXUU5w?=
 =?utf-8?B?WGtUYzk1Yk5ObVJDcjRSYmxFa2JOY2NFdW9xdHh2YU9paG5hL1YxTm50Slpi?=
 =?utf-8?B?elRhMEpsNW9UaC9iNlgvNW5DUjJWT2NtMGV3SGNmbTlRS0xpKzMrU2JORzNN?=
 =?utf-8?B?bVpFbmt0WmtvZlZ2WGZSZmNWZU5waGN2ODVrSCs2UlQzQk0wVVI4alRmc2ZT?=
 =?utf-8?B?UTdyTXpGbjBKR3BZWHVRdHpTZEgxYiswZVJVbFBEbUtwSmcyczVIUlh3dEVt?=
 =?utf-8?B?c2I2eEV2eEpKeVA3MTh3bm9WWlR1bDJkeEg5ZDlnPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTVsem11djVBNW9UVDlueHFQa1dWSTkzS0lJekNPMFo1eUs1OWZYbURMRFZO?=
 =?utf-8?B?c25QSHlPenB5dmZNOWJ6d0tzTVViTU9BbXpjOTBvVDIxU0cxRk9GUlRpb3lW?=
 =?utf-8?B?dEJldDlNVVR4VDZ6eGFZT2labUNCc0dqOXVveklsWmI0SzlIUFdkcmJaWGw1?=
 =?utf-8?B?cjZZKzk0VlB3VE11WGxGMzNHb1BaZy9lZWo3dElnUStBMnIvUzI2U2hPUTZC?=
 =?utf-8?B?Ynl6OXhTWHBuQXIxQkV1Q2MwNE1YeUhOd05QN3oxSGp0WWFCQmtuTURFRE5J?=
 =?utf-8?B?SWs5MFB0clE1aWZPYm9oZUszSnYrVC9BcDNzVXA5SEpZekg4Y0hUN2MvdXNx?=
 =?utf-8?B?a0V0TTl6MkIyczZqNkQ0UzlUOUpnajNTTVNFQ29hUVloeUJyZklsb0pRV2JT?=
 =?utf-8?B?SlFURWhYdkJ6YnB4MEV0dkkvWnNoSWd2Yk1nMlptRDh3R1hTWnNOZGFpT2py?=
 =?utf-8?B?T3FrcFBOaEhGNmMrRUJuV1drbXJSTGJiSlF4dENkZ0NUYThYZERTMWw5WGR1?=
 =?utf-8?B?bFZhVEM0aSt2ZTZ2VU9jdlNnTlFDdnlKTnZiR3pHLy9wTnFMSGVlSE44UFJG?=
 =?utf-8?B?dEo3ai81YzZuRUsrN3pBVkordVNxS3RkRC9TbjRpTHlaMVhwRGUvWGtaMkd0?=
 =?utf-8?B?Tmh0UUdQbTBiaW1mbGRTb0d3WWZ4aWhtL2ROT284TUlNckROVDhOR0lvbS9O?=
 =?utf-8?B?WlFROGxNdjdtK2tuaktiSTFkYWdvL3M5NVRWODV5Q1lTcU41ZnNYZlhUMzlo?=
 =?utf-8?B?UkFkdmh4STZMbGsyTWJTWVBtNHBKY2xQcjZSQXhrSWVISThIbUJVbFhHU0Vv?=
 =?utf-8?B?UEllcTFBS29wY08yUk5yRVBBL1R1cWtvbEFqOFVuZG9BRGZDZkRNdHRxSEFR?=
 =?utf-8?B?MSs4WlRQdytkMUc1SnhzMHNxbkdKRTJxUW9hME94TlE5em0zMmFCMG1DdStU?=
 =?utf-8?B?R0ZyK25SZVpmbk90RWFQcGVwTC9DMW93WFhSbjZYeEFVV2JrdlVHKzlFS1dF?=
 =?utf-8?B?cGJEMTIydDlKMFF6MEhPbW5TUm1oS2prWTJEK3g2OHlBTzJNQXNKc2JMeXNu?=
 =?utf-8?B?RXV1eG9oYjJ0UGN4YVNTY3o5Zi9ZRWJGbVgrdlZQMzk3TzlVNE5SS0N6M01i?=
 =?utf-8?B?Sy8yM1ZxQzRBY29MMTJaNSt0ak4rTHIyL0o1RVpDTlFlZHV1cDNNYUpURmZK?=
 =?utf-8?B?K2VDem40WEdDOEgxSEE1YWFkejUxTHI5VFJ5SVZzNnBBUnRuS0Y0NlBKMkhl?=
 =?utf-8?B?V0hVT0lHRXV0cDJlbTZRVE1FTWVCK3hXbTIxb0NtaGVvUlBCN2laYVo4YmpZ?=
 =?utf-8?B?UGU1ZTJrejRRdHV6UjB6eklGazBtQnZmK2xoS3ZidTBrRVpBbkFrOHJ6Vk1y?=
 =?utf-8?B?K0ZOdjdkdmJtK1BMbThMYldRT3BkQ1VBM2pKQzNLTlRtUHJxVmd2YVQwd25i?=
 =?utf-8?B?OUV4RGtEWVZ0MTU2RlpLcEVBMGtpbnFyZGhwZEJjY25UdENLaGJJb3pIeGJk?=
 =?utf-8?B?QzJvR3RNRm9MZGlQVmplakNIMlBqSFczcUhoSnVkUWVwZjBQdXJzOEYrb1BS?=
 =?utf-8?B?cW1XWEhKTFZDcGIrSHplVWN6b2l0MVpPUUcrczkvZXE0K2FBYkIrZkFLSXhi?=
 =?utf-8?B?RmdaOWNBTWd4ZVlPK09CRmFPeVR5V2xWb3FzUFU0eG1IZ2pOK0Q3QVNUeFJv?=
 =?utf-8?B?dGNQalNQRkYvQzVpdG4rTlhPeWNWU2ovQmU5UUhTQ3A4NVpWSEVPYkNWa0tU?=
 =?utf-8?B?MDMyZG4rb2p6VVBwQmhSLzVhWUZlaXJINVNsWlY3bXpWbXZpMkN2NFBOUi8y?=
 =?utf-8?B?b3lkWWNFVkdIMytMVCtpckFtWk9Oa1dPVkRWMWJQbkhqSjdBZisyYUo1YnN2?=
 =?utf-8?Q?e8LE1xgu68niS?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: fc59235d-df47-4b60-68c6-08deb739ac6f
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 13:05:47.1419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P194MB2123
X-Mailman-Approved-At: Thu, 21 May 2026 15:12:42 +0200
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

The size of name buffer was not computed correctly.
The suffix format is "--rel.-el" (9 chars instead of 6),
and the longest platform name is "emu-mmd" (7 chars instead of 4).
Fix comment and name size.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 board/amd/versal2/board.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/board/amd/versal2/board.c b/board/amd/versal2/board.c
index d94c1494d53..81daba1c5ef 100644
--- a/board/amd/versal2/board.c
+++ b/board/amd/versal2/board.c
@@ -81,12 +81,13 @@ char *soc_name_decode(void)
 	}
 
 	/*
-	 * --rev. are 6 chars
-	 * max platform name is qemu which is 4 chars
+	 * --rev.-el are 9 chars
+	 * max platform name is emu-mmd which is 7 chars
 	 * platform version number are 1+1
-	 * Plus 1 char for \n
+	 * el is 1 char
+	 * Plus 1 char for NULL byte
 	 */
-	name = calloc(1, strlen(CONFIG_SYS_BOARD) + 13);
+	name = calloc(1, strlen(CONFIG_SYS_BOARD) + 20);
 	if (!name)
 		return NULL;
 
-- 
2.43.0
