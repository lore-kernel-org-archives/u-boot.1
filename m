Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F84C43602
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 16:00:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79D0A8497A;
	Wed,  8 Jul 2026 18:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="XM80RgfW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDC8584994; Wed,  8 Jul 2026 18:00:49 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A32688496E
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 18:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rSKsKtHO8cJ/xVnVlAcVna6irX+bNKDbo1h5FG/qDBxY6e4zRnOTnPQOB/jgygdK3Kjn0sqj0F4NGHrUjvvpDqmOsQJE3Fhimt+W8htsDlcQKq5E8j8jJLAy3f+YAYVUdTpeYzBU8OkQyD+3AmswA0v7GYYXF0HHC+AhWRUSJHhrVZ9CGeBn+w0GGNi5acuGi8/5z89+AtCyUHvRvLtMSHcv/bSfud4AdVOgiolGi3CvMzmk+3I+5FWP4Deio7oW//nS6drKZWXQL2qr9dxDLVMoYe5hrx3K1nZqYWCaVEmFcpcE233xI2ybl/kKm96ovdFqMXtwzDgRW/7B4vscZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFSk0Qe3NjUhCy6zigDCP035FT53UG+MvT58/NgdW0w=;
 b=w/t6ezxSn5GVJx8rdAKWO0YrFrm1BUB5sdCzVdoHuJJeheHwV776skRhCYZExDITs8/Z82u0rrURfwNer0d4siGg+CW02wyJJ19MnNUZ1nsNShoANGzCFWiWf1gE9KT3OQzJ6H4wwH+3v0WbtG2Vn1ZDlluAP+kn7dgwLMY5ILZ4XBVbp88DErPoojYfaScg2NieBWxGDUc4zRwReF7ro+TC1cW3AXXL2kZFrbP4g2p3AhTQEYjmdcsQs306Vmlh2EyVNRRv6gjABEHyT92CjJi1bdwn1jvE2y7K4Hu0oOqpMCN3FFhvrkiOfa5y9xLgOriQ+v1D5juhZgHlHTanOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFSk0Qe3NjUhCy6zigDCP035FT53UG+MvT58/NgdW0w=;
 b=XM80RgfWSZ5+Ux1hYRJN4MbNchZkC2Jo145e6QJs8gWX28YuwMMzII/qdu1VwWP2Imc/asfD2H7pqnurB5x4ln3IMscFy75tUIsd9NBWkYd6Mw3u4GXYuDfrUL1Ts8o7jB6gxJ9GWMd6Q+cAkMSfc1I+3erSjrV3io2Oztro6Js=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by VI0PR04MB12664.eurprd04.prod.outlook.com (2603:10a6:800:345::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 16:00:44 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 16:00:44 +0000
Message-ID: <b6336f00-4c3f-4cde-9702-353bf9a0f7fd@cherry.de>
Date: Wed, 8 Jul 2026 18:00:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: led: reject unknown LED state instead of silently
 returning success
To: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <ifny32czr2jodibz3wyerwqfjzbepdkt3tfhvgw5qp6ymm736m@kmqqewswdxqq>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <ifny32czr2jodibz3wyerwqfjzbepdkt3tfhvgw5qp6ymm736m@kmqqewswdxqq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0046.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::15) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|VI0PR04MB12664:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a8b0fc9-46f3-40ca-49be-08dedd0a113b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: 679NA5ooOJXyHjxDmlgTE3hyqzFNfRj8l5Sto7L3S+P1OT54RWWK3jHb7c/xaMdHfeheCk6N4dNZ1DewptaYjOYIRKO6tMBeW7PPm/0ALQ5NdNtMeIWyDnxPV6wwKK0PrXr/fSQPH7mwnmXa4JgxNdEnwW+xaWK/PirpDEuPCEaH5KgLPjl3vlc5gWJZq4UhGoCh6k6CNzvPOHXKLFbyRBbeVOXysixPpocD+NNyIoGZ/AQZtGzJVuh9BGDJYwMor0zLvTLn7EPYNtY0J86rWgoZ9Pm+FHVIuub/KSPq4cl66HUTu88hgdVXkie14mWOcxDV2F0OHvSLrJSFtgaPPpfISzAAdqOtexaHqAILiia5xLARTntfm4/msWvLczlA5lG0CQXmis8n9KfbQmHRtyNp+90biibIHmU5QIF/t6G8GhsVxr0rTUFShl0Tr3onKdZ4U6B3BfbrX6Ea2dOTWtTzH8r9rGpJL4JOWKY+nRL9UoSgqaTvSQewd8/1mYxBxfJZVkHKVRvTZVMhGH1HyylUd66Y2EXdiZl2jNCiNyaO35GJ23HYWUNf92bzPIfu4vXApFaSW4sK7UycLBIUjS1DvTelmdp+a0a5hOAJwFcpLna4995nKeTE4/Nar/ZTq5L9J3wuyWLJ0y5ay102fk2/mtRDWnlX52z9gW9rmUM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z01UemQzWHp2YnRIVldoZlR6L0k0dUNXWUdaUHVHMGpEaDZvb0M2VDRBb24y?=
 =?utf-8?B?bVVDZGtrZDhJK2NDMzJHLytreWllaTd0K3A0ci91WUdmVWhqMzc4VEJTdUx0?=
 =?utf-8?B?MTFMWng1Qm1hN1M4dUI1TTV4RTF1SVdxZVgvbzNJWXl6eS9TRWpyeEFrSlY4?=
 =?utf-8?B?MU1JZnJaVytkOEkyRVpXVzV0UjAxQnVMYzVyMURuWCtrTDloRGY4Qks2bzU5?=
 =?utf-8?B?MENOeEdkV1BiREJLYVc0QlUxT0d5YStndlFkSzFxWHZQUFJHU0lWZVZ0RU8z?=
 =?utf-8?B?a3o0bWJVbGdrdGlxUnlqSjB6TWM0VDF0V01ldGFTNUFoMjVqS0tQa3R3MW5m?=
 =?utf-8?B?VnFsczh5OUlRUkNYcWpaWXZIUzQwV3Jmc2tTcnRJSTJyVnNrL0xac1A3SW9l?=
 =?utf-8?B?c0M5RTVrYll4OFN3T0hwc0sya2ZtRE1mQXAydWpCbFFDeTM5aWl1V3pDM1Ja?=
 =?utf-8?B?aEhUU2gvN3VPdFBzVzRRaW9jSmQzdmk5Y2NqVFN1R1U2OGpkb1R6NkFWczQy?=
 =?utf-8?B?SkFXaWdiLzhZNmVWTis5aTA1MHUxSDBoL09yUUs5SUxlbnR1WHZlRytITENx?=
 =?utf-8?B?UkpsWUgxNjkyQVVmZGQ1bEtMWFlXUWV1Y2J0dVpkNDZDOElFRkEyRFBDRXdh?=
 =?utf-8?B?STdPKzZJSmdwNEFQc1ltd0xnMGJDNkQ0NzRmZXJqUTk2dDN4VlZRaS9BY0JJ?=
 =?utf-8?B?L0Z5WlZkTytMNzBJb1ZvcEsvR21OeW41bjB3K3JnMkFKMUtvQUdKckR2QS9r?=
 =?utf-8?B?cFdHeEYzQXc5MVhXRUxCeVl6L0NnQUppU000bkF6U1RIQTBhTWx4UXBjNUY3?=
 =?utf-8?B?c0srVWFjOUo5a1R3MU5tb1ZqanhGYUs5L2Rnd2Q2eVpTcFJGQm9RWG9Relli?=
 =?utf-8?B?ZkdzaHVYMjd6NDdyakxZNnJnMzk0RkJDcXB4RnphMm9sS1dtbEsvN2wrZ2oz?=
 =?utf-8?B?aG14VHNnWkJhY3RGYXNMZ2dOd3lNdlhQU3AzZlRDRi9aTzNKSHhCUGFrWmxP?=
 =?utf-8?B?MlFFamo4WDAxVGVnalZPQk5VZmlQak94OVdoTTdoRXJyeFQ0UTUwTENZb2c2?=
 =?utf-8?B?d1Z1eWY2TEdpUmlheTZ2TnNFalF1Nkk0bWM3MXBzVTA2anBCcmZnNVZHQWZQ?=
 =?utf-8?B?MkIxRVc0U2dqQlRGNkJGZDBoZVdaU0JocmtONGM1aHhra2NwajlnL1drSzgr?=
 =?utf-8?B?RDhJTFNDY3hDR1EzSjlnU0J1R1RNSkYyZXJvMWJaOHF1a2NIeWRVdmVzNnpq?=
 =?utf-8?B?QnFYRk9YbzhBd3RMUjJTVkZNdzVRaE1OQUlBdHdLbjhiWk9uMW5YYnBNbDRQ?=
 =?utf-8?B?WXZjdUk3UTA0MjRzbDdRYklpM29uSDlZQ29yZysycjZQcGhPTDVYTWZTSmMv?=
 =?utf-8?B?WnBQYWR6WmMvd0o3cmtZOS9WSW9jZDNrT25rTWFqUllwVzFxUVZTYkJFR2o1?=
 =?utf-8?B?QzBKTFFpTWNqZlNNVHJTY2JOVGNzM0lqMWRIQ1NUYVRyeXpTbTlLYVZKcW5m?=
 =?utf-8?B?UHNDZll0ZkgwUGEyNXJKamo0NTdiODZ1ZHZ4WnFVS1ExaW9mL3Y4WHF1QlRx?=
 =?utf-8?B?aXB4d0NNWjBRekJPWUpyQ0x2eWZwTG9Ra1ozN0xtWDdxYWZ2SkVoSldzS3Ba?=
 =?utf-8?B?UVB5czBFSktXZzQvYnNLY2pZQzJ4MTdFQzJHaXA3RlRHbzNzbkE4d0YvbFF0?=
 =?utf-8?B?UXNMaStXakQzN3JRWFViOWZxeEgrRnRhNEtleHliUVZXallOL0dDbkIrOHV3?=
 =?utf-8?B?cXZaZVcyc0VmTVJDcVlPandaRHFBUkYvdUhNa1IwcVJDc3pTWlg3YitxSW93?=
 =?utf-8?B?YUJWUVIyMEtiM1hrNHhRZFRrUGNFeDl6LzhUWjhxY3JNZmY5RXlyYnMyejJT?=
 =?utf-8?B?NCtnTkFYaHQxeUlKcG14R0EvTFV4SFdCWktyNWx5YityeVlEUTJEa2lvZVU4?=
 =?utf-8?B?VjRJODhpOGNxcWJUT3kvdEVTUTdJUmtLOGlDcDQ5Y1lNL2c2MmNFcjFWbmxq?=
 =?utf-8?B?cWh6UUxZQUt3K3c2dkZva2NuckR2bkRKTUFGSW0wNTRqdThEVThkU1hLTWN3?=
 =?utf-8?B?VXdXdGVReTBQRUpIbklUU0ExRzVGQUo4QzVkMmxpQVZYUVVnWHg4SlJ3cm8v?=
 =?utf-8?B?ZjB5QTBQc05kaTZiTzh5eXlHTyt6RW55SzJGaE1Vd25Ub1cwTUVleTdiMTkz?=
 =?utf-8?B?THora0hDOVFjQm9Yd1NaVkNBOEF1UFZ2SFNYcEJNUWdCK293OTFibHZRL0lD?=
 =?utf-8?B?SE5QY0RXMmZ3Q0FreW1saUJLOHN6RC9yUGdQVFY1dW56TEN5ajA5d3ZKUExC?=
 =?utf-8?B?VXZOOWtTY2dJL1FNN2VpYU44QnZkZ3Zrbm91WlVpSFErZVgvSVZZQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8b0fc9-46f3-40ca-49be-08dedd0a113b
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 16:00:44.3522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bH7GdFYswf0dx5eLNCol6+bvzI+hubljB2wMxv5xSbkhSONr+7fAE8V8f6Q1QrsKf/AjtkhJFXrCMnObm+xmFzLZXnzr2QoGxH/h6Mt+1kg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12664
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

Hi Naveen,

On 7/8/26 4:32 PM, Naveen Kumar Chaudhary wrote:
> get_led_cmd() searches state_label[] for a matching name and returns
> -1 on no match, but its declared return type is enum led_state_t.
> All enumerators of that enum are non-negative, so the compiler is
> free to pick an unsigned underlying type (and does so with
> -fshort-enums, which several U-Boot targets enable). In that case
> -1 is reinterpreted as a large positive value and any subsequent
> comparison against -1 silently misbehaves.
> 
> In do_led() the returned value is stored into an enum led_state_t
> and dispatched through a switch that has no default arm and no case
> for the sentinel. When the user supplies an unknown state name the
> switch falls through, ret was already set to 0 by led_get_by_label(),
> and the command reports success without doing anything.
> 
> Return LEDST_COUNT from get_led_cmd() on no match. LEDST_COUNT is
> already a valid enumerator, so this avoids all questions about the
> enum's underlying representation. In do_led(), when a state argument
> was actually supplied (argc > 2) and the lookup produced LEDST_COUNT,
> reject it with a diagnostic and CMD_RET_USAGE; the existing
> LEDST_COUNT switch arm continues to handle the "no state argument"
> case where it means "show current state".
> 

That looks correct to me, but I think get_led_cmd() is overengineered 
and actually still flawed. Indeed, we iterate up to LEDST_COUNT-1 times 
on the state_label[] array, but nothing guarantees the array is that big 
(it is right now) so we could theoretically have out-of-bounds access in 
the future. It also isn't handling the case when there's no matching 
string at a given index (e.g. holes in the array or padding at the end 
due to the last element in the array not being LEDST_COUNT-1), where 
state_label[i] would be NULL and strncmp doesn't seem to be handling 
that case (it isn't in lib/string.c for example).

I think the answer is to instead get rid of this and drastically simplify.

Remove get_led_cmd() and state_label[] and do something like the 
following in do_led() (NOT TESTED):

"""
diff --git a/cmd/led.c b/cmd/led.c
index 296c07b3b38b..d1fc9dc8cdbd 100644
--- a/cmd/led.c
+++ b/cmd/led.c
@@ -9,27 +9,6 @@
  #include <led.h>
  #include <dm/uclass-internal.h>

-#define LED_TOGGLE LEDST_COUNT
-
-static const char *const state_label[] = {
-	[LEDST_OFF]	= "off",
-	[LEDST_ON]	= "on",
-	[LEDST_TOGGLE]	= "toggle",
-	[LEDST_BLINK]	= "blink",
-};
-
-enum led_state_t get_led_cmd(char *var)
-{
-	int i;
-
-	for (i = 0; i < LEDST_COUNT; i++) {
-		if (!strncmp(var, state_label[i], strlen(var)))
-			return i;
-	}
-
-	return -1;
-}
-
  static int show_led_state(struct udevice *dev)
  {
  	int ret;
@@ -83,12 +62,24 @@ int do_led(struct cmd_tbl *cmdtp, int flag, int 
argc, char *const argv[])
  	if (strncmp(led_label, "list", 4) == 0)
  		return list_leds();

-	cmd = argc > 2 ? get_led_cmd(argv[2]) : LEDST_COUNT;
-	if (cmd == LEDST_BLINK) {
+	if (argc == 2) {
+		cmd = LEDST_COUNT;
+	} else if (!strncmp(argv[2], "off", strlen(argv[2]))) {
+		cmd = LEDST_OFF;
+	} else if (!strncmp(argv[2], "on", strlen(argv[2]))) {
+		cmd = LEDST_ON;
+	} else if (!strncmp(argv[2], "toggle", strlen(argv[2]))) {
+		cmd = LEDST_TOGGLE;
+	} else if (!strncmp(argv[2], "blink", strlen(argv[2]))) {
  		if (argc < 4)
  			return CMD_RET_USAGE;
+
+		cmd = LEDST_BLINK;
  		freq_ms = dectoul(argv[3], NULL);
+	} else {
+		return CMD_RET_USAGE;
  	}
+
  	ret = led_get_by_label(led_label, &dev);
  	if (ret) {
  		printf("LED '%s' not found (err=%d)\n", led_label, ret);
"""

What do you think?

I wouldn't necessarily add a printf for when the user mistypes, just 
return CMD_RET_USAGE where we list what's possible. If you really want 
to keep it at least replace "state" with "operation" as it's something 
we do on the LED not its state (e.g. one can request "toggle" which 
definitely isn't a state).

Please also add
Fixes: ffe2052d6e8a ("dm: led: Add a new 'led' command")

to your commit log also as that's the commit introducing the error.

Cheers,
Quentin

> Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
> ---
>   cmd/led.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/cmd/led.c b/cmd/led.c
> index 296c07b3b38..d547276e480 100644
> --- a/cmd/led.c
> +++ b/cmd/led.c
> @@ -27,7 +27,7 @@ enum led_state_t get_led_cmd(char *var)
>   			return i;
>   	}
>   
> -	return -1;
> +	return LEDST_COUNT;
>   }
>   
>   static int show_led_state(struct udevice *dev)
> @@ -84,6 +84,10 @@ int do_led(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>   		return list_leds();
>   
>   	cmd = argc > 2 ? get_led_cmd(argv[2]) : LEDST_COUNT;
> +	if (argc > 2 && cmd == LEDST_COUNT) {
> +		printf("Unknown LED state '%s'\n", argv[2]);
> +		return CMD_RET_USAGE;
> +	}
>   	if (cmd == LEDST_BLINK) {
>   		if (argc < 4)
>   			return CMD_RET_USAGE;

