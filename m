Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C7DCD0408
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 21:15:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B2F283A24;
	Mon,  5 Jan 2026 22:15:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="a9DTYJ86";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26E66839DE; Mon,  5 Jan 2026 21:26:21 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazolkn190130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00867839A5
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 21:26:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xLgN4jTPgYQxE7V3eEut72ynbHJGp+Z427INI8s6KJK5hpgzXUq0cvcGsMxd/OpxMdCllNQxSaomFSMnrUgacqX8XjhNmRw0TrNf1X7uTC1DzoUs2waO3JFipgTtZxH5fzdjs3FY9P5d7gCQlrW6Ro5yKt2Lqwu6EcvRXd8f/1ptA51POGGr3LT41/FN204Mm9auWneqRZkwzlp9ym9M8tQMBHq06S/0w8CDavfEj1dkYmgehshTyaWkmz0AnobjH4UbO72Crrjrqt8PfA83v16tCvyVD6lkbuI6VenYZzJZCpfzObmHNTyG6OV3FThjs6GbMUYSdj9hxwSIlneL5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAcWNKARR9niYPZSoJ7dQ3q8mqClQYr+sAMr4bxMm5Y=;
 b=jtKgLYJABkn/W1MN+xd6QV4yeU+kvv1sKxZ7z4m8Qu1v+hHbobS+5nsWqqzmIPxTGPYUfvsWLcBScGNx2ksRr22UC8WBbFW9nxNS/HXrNweTIkoymVRau8+tBhAio0f1BAe5vEEOQN5BOa0FWwkfk/Xfnc6CqyJN8jltq/CpJTqWvjFUqNr3Y8GdouhYCqzvRw+xkJSaSn0j1NVh9xbh9kL4jnUZZDLZRMBqpkqB3HgHPb+kTgAC1NW96xerqsm7Qlw/ibzxUrS0ZaucrnMiJ9a3jwvmyjbvuxkRkLaux197OSZdQ9Q1qcxBYWSIXMlzIMV+ZWfxTrXIakOt4V32tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAcWNKARR9niYPZSoJ7dQ3q8mqClQYr+sAMr4bxMm5Y=;
 b=a9DTYJ86/9oiH16/2flsgQi85M1NSx7PJCGVw7P8Wn+xUI9n6ROhXajOdYtL3cvF9kXTEvF/1VPFniQEPyX+pRsxwEYRFQtH9//b87yqF5abfalNcwTg2enJ6iAkNi2LhIr94OYBBqRVbQPFG0W2eEsoB0QmmA441rWdXtkNQMTP7v845IqJl3Gi5b2jIzwQW8dZn9FgF1J1a9SVPg2QKwmmQ7NRHFkDlIiqwcWvSI0UNfF+3SdELzxWIy4pEddGzIihbGcSaP2K96tCbBs5sy+Pl7ekX0ZHq1d1glC8Fq98x3FHr5GMJF+VFpjgWyN+tjv3iTbwFnAHj2qvcq7ofw==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 GV1P194MB2292.EURP194.PROD.OUTLOOK.COM (2603:10a6:150:1c5::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4; Mon, 5 Jan 2026 20:26:17 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58%6]) with mapi id 15.20.9478.005; Mon, 5 Jan 2026
 20:26:17 +0000
Message-ID: <BESP194MB28050FDFC3929BDBF71ED475DA86A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Mon, 5 Jan 2026 21:26:14 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Francois Berder <fberder@outlook.fr>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] bootstd: rauc: Free memory during error handling
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3PR09CA0010.eurprd09.prod.outlook.com
 (2603:10a6:102:b7::15) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <5e1c015f-0567-437a-969e-4a144264df70@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|GV1P194MB2292:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d6c898e-1960-4ee4-5781-08de4c98ae01
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|5062599005|8060799015|461199028|6090799003|51005399006|19110799012|41001999006|15080799012|23021999003|5072599009|3412199025|440099028|40105399003|11031999003|12091999003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2JRZlJDUDlzb1RtVy9lK3FabWRQemJJM1YyZHltSWZ1MEpCcWMwMld1eGRy?=
 =?utf-8?B?SWh1YUpjQVBvR2pwWlNuSXBUeWpiYUtPcUpBclR6NUdRZFQ1N1MxR1IrOXF2?=
 =?utf-8?B?aS92bUdQMWJnQlZqNkFEMWc3SUJmbkZpdWRDWkdsVWhYbERlN3ZzdUhoa0V2?=
 =?utf-8?B?VGtBd1YyVytySncyeEE3R1o3dXJTeEFnUEd0SmdWQXJvc1BBSnRMU3Vmd1hr?=
 =?utf-8?B?QjEvUHpMOXBFdXpLQ3Y0MERyUnE0Qm5jeHFxRjR4dEY5M2puZWV1ZTBudlRS?=
 =?utf-8?B?YW5GKzVzTlFYWHNpUkJYK2lzOGI4TFpEbWJXSGFUaXlWSjVzdG9xU1dmU0tH?=
 =?utf-8?B?RHJCdE5GZU1SejJjSTJwbzFWanlsS0JjMkNpL0YrTVFKL2p1ZWtvTmpkbmY2?=
 =?utf-8?B?aUJJODdxRTZ3aFgycnM1TDdiMktZVzcrV3h0WGovVVhYTWcwVVFpNE9xcGx6?=
 =?utf-8?B?M2ZzcTRibmFWcy9lNnN4RlFPMUFaY2dQSVBWd043dThuSVVISVF1TXFMemgw?=
 =?utf-8?B?SDN2RmZ4eWZaUnhORzZpR3N6bHVyWmZOLyszNXFtaXVBZmhDVnRJK2x3V1h2?=
 =?utf-8?B?SHBqS05jems0b3puUmdrQ20xZmZwb0lCZStjb2Z0RDdrejZsUGxkeklqWjh1?=
 =?utf-8?B?Y1FUTVVXejYwcFhlVERnK2dWY242L3FNeDYzTjZmWnNsRERJdjA4dkFaOEpJ?=
 =?utf-8?B?eTVjU0MxM2VEOWRoTFRXRDErUjVNMEdpYitsQk40QlhMeSs1Szd0eWpweXkz?=
 =?utf-8?B?MjJNRGRzYzgrNkZEYzlGVTFYWmY0R25Oa2ZPRmRLc3BhdC9YNXRNU2NlVUww?=
 =?utf-8?B?SCtuTGI4bzlUNDBvc1VBU0pEaGR3Q1NsdURLVUpUUTd1VWloWDN3YVpmTUFL?=
 =?utf-8?B?Qy9iQ2s0cjFyMnFsMGxET1R5VWFMVDlOUGxveDhFUW1xZWx0a1gyOVNLMlVR?=
 =?utf-8?B?eCs5bnMycFFzVnV3U1lVWEZsc3NQVDZIdDJtWUJlYXZ5YnVpQmJ2eWhQajJq?=
 =?utf-8?B?N3JIV3AzZ0tCNzNpaE5ndkJHdUIxQjN2QzBSU041ajdPOVVUbzJXQkozc0xZ?=
 =?utf-8?B?N1hpdDBMYlBIdlNVUDViejh4aGlmS1QrRnRpeWNGOEtUeWw4TnVDY1JIZkxU?=
 =?utf-8?B?ZXZieVpsUERJNjlHWFY0MXBvMDJCMlA3VkUxRytIdkk0aFNrREZaVmhQazJH?=
 =?utf-8?B?dDkzSTJDUDdNT1pqdEVUdEM1aEhCUW1rejJYYXpFcHkxWnBrOVE5VGpWb1k2?=
 =?utf-8?B?cXlYRWZIVHlQeEczUVFLWUdJelhHeDlja3hOSUd4SGZITThGeGVqVGNUcVYz?=
 =?utf-8?B?blp4aXFoa2dESHgzY0dySXowRmJRdEJHS2YvaDR6WnJtV1BUMG51ZG1nQTla?=
 =?utf-8?B?WkhINVZKRHJwd2VqZGVLek1VSHBsN2NaaFAzQ0d3QmtIOGJlU0hmbTA4K2dQ?=
 =?utf-8?B?Ui94M3ZtSXY5SmE0dmZzSEZsT1pCdU1vVnIyQzBjcWdZbllkbDZOZWpIdDh4?=
 =?utf-8?B?MVJ4cWYyWWM5VG5TTWVuTFpiSG9Sc1ZaMDQvcWI1R3VxRUMvV1d3dWxPZ3Ru?=
 =?utf-8?B?SzdCcDE4b3pUZkRuelNXa0pPYjBHRGZaNXpYTnVva3NtWnkxVklOZDlEQWlM?=
 =?utf-8?B?VlJqMkRnMm1LVWpwK2tYMi94WW0rbzJtN3pKTUY0Wno2T2VwZEZyZ0ZJUG9C?=
 =?utf-8?B?clVSelZEM1ByWnhvZWxxRTZmWUJCa2lhc3NwSUhBK05mQ3FoanVtcm5XdUxD?=
 =?utf-8?B?N1ZoS1pyM2gyemtuVEFtYnIwdGZQd0p1T1VPTk1CUEZRQUdaamtjYVJJbkoy?=
 =?utf-8?B?YkwxdHV2LzhCTGdWWVVUdz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVJBS2ZWZWk2b0ZtSlhSelhQMVhZeUlrWUdCcFdUdjhtUVdCZFFJT0gwaE14?=
 =?utf-8?B?MTdDb1NkZlpkNTZXSzQ5WTNjVTFJMCtzMkR0MmdlK2E2YUZmVEtrSW83eHcz?=
 =?utf-8?B?Yjhxb2diZGhudEYyWkJ1WWRUQ0JaTnd4Z2U3bE1jQzdhMDlmVk1adzVxdmdL?=
 =?utf-8?B?V2ZGOUJTaUlFVHQvcjVCRWNqenhvSUhhUjJENWNTaEdLc3krbitiS3hNRXgy?=
 =?utf-8?B?UWptYlZBd3dINWVwckM4eUJ1ZU5HRTV5WWhxNHZJM1liUnpmcWlFazZUbGN6?=
 =?utf-8?B?MHIxNGYrWmpiZFFGaTBrTElxcTFrUUo3S1h6WjJxcWx3WVlXUTB4S2lXeDk2?=
 =?utf-8?B?MDRtOUNkUUhTcGRweEJOdGNmZnRYci93cTdPNEFIZEt1MVd3S0kwUW5Fa0hz?=
 =?utf-8?B?SDExb0VGdU5zaHp4QmtJY2NBaVdtUTlqdThnVjJFVXFnN2FNeGtjUWthaUxQ?=
 =?utf-8?B?dWZQd1ovcEJEUiswdU9HS0pHS2pxd29VbTlOZHhndkRtMlVhdUVWTU1QeGVW?=
 =?utf-8?B?SVM3bTRJRGtTT3lDa3FZQzBjSjRJdnRDc0hocVpCVWxBcjkyQUlmdTVJNVV1?=
 =?utf-8?B?Y2RNb3ZaSjJrZkppSGxOTEorMVhMbVdOWWdtc3YvZmthdjh3T0VnbVdwdjN2?=
 =?utf-8?B?UXk5Qmx5L3JyUkVldWhuSlk4TGJqYUd2cTZtbXJvbUxFc0gvRllOaVlJTENp?=
 =?utf-8?B?emNlMHdvQ3RNVkxCK3UvM0ZmWHpDSnRMNXlvamN5eXRyelRXK25TTTdRV2da?=
 =?utf-8?B?NGZyZlRGSlFGK0tzRnhYbUxTdFRxcmpHa2ExMlZCYTVVS05DeHBmMUNXTG81?=
 =?utf-8?B?MEFqd1d0bVY3TnVIWk9ocGN4RHhkN3B0bThlRjNNZmVqQkVnR1BEN3VzUEFr?=
 =?utf-8?B?OHo2bnJQNU5tMzZhMEFIZmVGUVBwazBETGU2L2V3QWt0bFVuK3dKMUU4N1Ju?=
 =?utf-8?B?SlQvZGVKRnlXY3E2S0ZVU3RGSjF2ZGJjdjFybDlzVE1wK3ZxZDhhUCtBd2ZC?=
 =?utf-8?B?K0VCbmtvR3ZpbVFneTBwOUhRY1pPQVlqNFI4bDdKRHlvaXpoMGRsVE9CbUdZ?=
 =?utf-8?B?dmZLb0FNcGczUE1UQi9zd3BEWVB2YjdLNjhYb0dXMTdUZGxKQWhNaE80MTJ3?=
 =?utf-8?B?ek9TVmQvRGN6SFMrVWtZSjI1cEhRTTNmeSs3dDZTYWFIL1luK1pDUkVlMlJ2?=
 =?utf-8?B?Q24xUFlRaGtHTS8xeElGWFJJWDEyazRkV29vOU1peThjZXBaZ0xacEZ5RXVl?=
 =?utf-8?B?RnN3QmRjRnA3QVYyYkZQMmNSazR2ZVNRNEJYdlBSbkFtZSt2ZGM0R1ZLTnlM?=
 =?utf-8?B?cko2ekdyblZYMHc0WFNmUzRqcnlHdndvVUNjbExuOTZDeEh5WmhCWGZsdGxz?=
 =?utf-8?B?TmdTUlNOaDJQdERRZzBpSVZOWFpMQ0djVVdLTG15Um53NU5sTWY1OWpUcVJw?=
 =?utf-8?B?SkJhdzBFbjU0clRCSmNZSHNidUR1ay83eVRwdldmK25KZVVZQjNqS1VaSEFu?=
 =?utf-8?B?Sko2TTdIS0JVQkZ4cW55MU93NXgyWDNpS0p4aXM1V1BwT29zUzF5WHRKVDB2?=
 =?utf-8?B?eDdXMUJZUXc3bE92ZGtKMmFOenVpVjRZOUVpbnpGd3ZveWJIdERJNXR4NTZB?=
 =?utf-8?B?NU1hZmlocXdNY2lBRDZtME1xTUoxQ2RNdTA5VjkwclQ5KzJ5Wmx6TXlCNDRY?=
 =?utf-8?B?RmFyc3pXTTVOYmxScVNJRUFUdEZWUFJ0amhxMWk0R3hCSUlWM0RwVmtUSW1J?=
 =?utf-8?B?Nm9GSVZ0K1IrZDdXOVJTV3NsM0laekFmb3hhNGhObHduVjFDUDVlWHNnYTg2?=
 =?utf-8?B?VU1LdHNieWU5NXB4RUp6bXFCZi9JMFF4QXZCQlBGRG8vNnlibFNoYkcvU2Jw?=
 =?utf-8?Q?NU9a3tyVRb91Y?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-e7640.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6c898e-1960-4ee4-5781-08de4c98ae01
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 20:26:17.6549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P194MB2292
X-Mailman-Approved-At: Mon, 05 Jan 2026 22:15:13 +0100
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

While reading bootflow, memory was not released if an
error occurred.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 boot/bootmeth_rauc.c | 51 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
index 833715e1395..432d170e006 100644
--- a/boot/bootmeth_rauc.c
+++ b/boot/bootmeth_rauc.c
@@ -139,12 +139,12 @@ static int distro_rauc_scan_parts(struct bootflow *bflow)
 
 static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 {
-	struct distro_rauc_priv *priv;
-	int ret;
+	struct distro_rauc_priv *priv = NULL;
+	int ret = 0;
 	char *slot;
 	int i;
-	char *partitions;
-	char *boot_order;
+	char *partitions = NULL;
+	char *boot_order = NULL;
 	const char *default_boot_order;
 	const char **default_boot_order_list;
 	char *boot_order_copy;
@@ -176,10 +176,22 @@ static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow
 	if (!priv)
 		return log_msg_ret("buf", -ENOMEM);
 	priv->slots = calloc(1, sizeof(struct distro_rauc_slot));
+	if (!priv->slots) {
+		free(priv);
+		return log_msg_ret("buf", -ENOMEM);
+	}
 
 	/* Copy default boot_order, so we can leave the original unmodified */
 	boot_order_copy = strdup(default_boot_order);
+	if (!boot_order_copy) {
+		ret = log_msg_ret("buf", -ENOMEM);
+		goto rauc_read_bootflow_err;
+	}
 	partitions = strdup(CONFIG_BOOTMETH_RAUC_PARTITIONS);
+	if (!partitions) {
+		ret = log_msg_ret("buf", -ENOMEM);
+		goto rauc_read_bootflow_err;
+	}
 
 	for (i = 1;
 	     (parts = strsep(&partitions, " ")) &&
@@ -189,13 +201,26 @@ static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow
 		struct distro_rauc_slot **new_slots;
 
 		s = calloc(1, sizeof(struct distro_rauc_slot));
+		if (!s) {
+			ret = log_msg_ret("buf", -ENOMEM);
+			goto rauc_read_bootflow_err;
+		}
 		s->name = strdup(slot);
+		if (!s->name) {
+			free(s);
+			ret = log_msg_ret("buf", -ENOMEM);
+			goto rauc_read_bootflow_err;
+		}
 		s->boot_part = simple_strtoul(strsep(&parts, ","), NULL, 10);
 		s->root_part = simple_strtoul(strsep(&parts, ","), NULL, 10);
 		new_slots = realloc(priv->slots, (i + 1) *
 				    sizeof(struct distro_rauc_slot));
-		if (!new_slots)
-			return log_msg_ret("buf", -ENOMEM);
+		if (!new_slots) {
+			free(s->name);
+			free(s);
+			ret = log_msg_ret("buf", -ENOMEM);
+			goto rauc_read_bootflow_err;
+		}
 		priv->slots = new_slots;
 		priv->slots[i - 1] = s;
 		priv->slots[i] = NULL;
@@ -204,15 +229,19 @@ static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow
 	bflow->bootmeth_priv = priv;
 
 	ret = distro_rauc_scan_parts(bflow);
-	if (ret < 0) {
-		distro_rauc_priv_free(priv);
-		free(boot_order_copy);
-		return ret;
-	}
+	if (ret < 0)
+		goto rauc_read_bootflow_err;
 
 	bflow->state = BOOTFLOWST_READY;
 
 	return 0;
+
+rauc_read_bootflow_err:
+	distro_rauc_priv_free(priv);
+	free(boot_order_copy);
+	free(partitions);
+
+	return ret;
 }
 
 static int distro_rauc_read_file(struct udevice *dev, struct bootflow *bflow,
-- 
2.43.0

