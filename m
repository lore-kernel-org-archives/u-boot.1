Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2751DCD4F3D
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 19:11:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50B0A84837;
	Thu, 21 May 2026 21:11:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="k3X478hD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2702F84825; Thu, 21 May 2026 19:50:54 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazolkn190120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d200::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D8CC846FA
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 19:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Klqql41HzTjAe9oWCJm8CGoILzrNTQMOU96rOitqvCXtrp0NkbNo8LSQ5lVYriL12JSzZk9M62fXotTyOTfvWF2gK2jrO5WIfwDFgirC4374fqv18UcA0g1WJUn3cLWuAAkNKiM8p2/vceUIHrixN7eObYZ0X1rNPbnikzkX2PbcVUEisCYZCb2IBMiBbOV4NQjxSzmO31gX0ZtCdhxGLp1qrA0n8bLfLgYJKwOzLYm6syk4yLrd+RkSYDOFVeczTDBz+T7Eq6P/3BOyrti3DeOCL4IWczMRmU+Z5DHRI2v79YCI9HV8Q+Hc1y+apRqGWlhmrs/XFP4UIalCX5A1ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+ZPHPhVOJtervpJOAHbJUGCOwr2Dc8/O9pj1tqkp54=;
 b=pzPzFGVZBtu7Fyrfs9h4ODFpj+iobGjLwL5mTBdNyblq98hnsGmXeEobbHn8v/9dSf376xhDSBp3PE/j4DNvXKPzaJ4clolPXu8HNLRVOTX3SEJdUohUM0mI/VFGLVYmiUoglbS5GXBS9Ihhtf1ghqsqfckiBs2TSFsnoSxzbMRYPRdzLM5RAc2yc2XcJMNBDZ670B+cm69QdXRnAaqVLi+PrSchM748MTA3qYH0Aw1VNoTV3yT37Q4rnVsJ5sHSoQvrItaV/02uxdO5ys2mm8Kb3vRH4cfEw0o3WgCHwlQU0Bc4X2JVZ6IxOueRQV6giqTMwrq/PTzoD+F2lJQWNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+ZPHPhVOJtervpJOAHbJUGCOwr2Dc8/O9pj1tqkp54=;
 b=k3X478hDFXRg7cRg6adwQINHong/XOJ8GfQ+WUELkqycy6vMqPOSe4MjGBemaVy6STysvsjQLdnSBdAOqMb17LLeC4i7z3xtsRMvWOsIYfXql4uV1Tm4HTwu7Y4pCQczBWdnKH1HIDXJQB7WwgZ9YOz8YGeQSEQztv/H5J9rH8cjR47oYUTSMVXygi/q31Uye1YGzGt4woFlUbBzozeFRCuA34GC5k0+fF69jJteEQ/hEMwIM7Mzt0B0TCVCasR7+ypqB9ELpaZyQl1jyvKPBnvuSRCVxlBBEkzd+49jkTKuEGzkZuxxOtBWE0VJ6hOWbXUmZ3chO+x8xgaBlomZdw==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 FRWP194MB2865.EURP194.PROD.OUTLOOK.COM (2603:10a6:d10:188::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Thu, 21 May 2026 17:50:50 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90%3]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 17:50:50 +0000
Message-ID: <BESP194MB280511C6E8C0E257362BD50ADA0E2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Thu, 21 May 2026 19:50:48 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] drivers: gpio: Fix dev_read_addr error check
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0271.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:373::13) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <5e2b5b34-bf3f-40f1-a5f3-a56b8f4440b7@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|FRWP194MB2865:EE_
X-MS-Office365-Filtering-Correlation-Id: d4a5b20e-bac3-4132-d8b5-08deb7617f11
X-MS-Exchange-SLBlob-MailProps: WaIXnCbdHrNUHEYKyaIg10gAWKced6rzKhrwSiOOEoHnMbkEMCTT+ZjzBmthSEUN9ubSis0EKIDiighZj8v6jdl7etxjTv3/Ead1ULFpv6TUOex+JS9S8IebWfQtynJutXPeQ5TCk15uL1m52RarLaewIPDtYUsyIcHWdz5lnopOUcyqzGIu39nVDIqIk8c05e0TjS4baRwDHlUh8qthg834fB/LMX/FLTqjXGPIoy16R0iA73GXQHEcPWj/RF9SMbp7sbJWxfl8vB5qx/hhUAi+6PZ+iZDIu6ghmVS02ZlSHabGrgxvZjBDWMqJK6Wn+tJrhygKVabGfp3utDhWUwWwdQu7R3SdQDqUzWebH8RNWez4oG4aK8t9iqRbOcocVJfqKDpjRltetsXeudZveb6nj9ayur2PI1n0768A0lv8nh2HTuzSVsH1FJezxyNxVVjZYv5bKOVD1vUkG7NvT56lJzrCrRy0I+2dPQahwAIHhEaeM/goDdW9p9waHPsEU8Q4cnrCLRR8EWvCnksorpYCHTwGOYjLDT3FAf0Z750z8+Ndp0j8g4PQ1iPaal0Ejl7+dpDI6aeza7xW1vzW1tc3yb3iWcaDR4sdx9qZxKdjpYXDP2NqoXyPT6DENp9Lg4LW6wJYiuAk4V8P/L2QUCr3Bq89lTo4g/F5x/P+2opFiV634PcQjSrnx3R4G85flWIPA1/450qURwGIMdNHMC7UdgEj6T8mDenw/B6W+jOoq+Ar3QPYShcsMj77x8ZqSBENelV+Chg=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|5062599005|6090799003|5072599009|15080799012|51005399006|19110799012|8060799015|37011999003|41001999006|12121999013|23021999003|55001999006|24021099003|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFNHNWk4MldFMzVYT0NMRXJTTXU5RVcyUW84cXhoK2Z2QmY0dFd4cUs4U2Vn?=
 =?utf-8?B?RUw2aWxDLzU5SEtGSjM2YmNRdDJLTE9kdC80a2FxaGVJS2xuL21NV3ZVMGdP?=
 =?utf-8?B?NFBhUDlPejlNb3lkUWN1MjZXUkZ5UXZBZFJDWElsc28rcDNkRXVQTmFBSXNj?=
 =?utf-8?B?VzhmVGRaVWlNNlArb1FtdllDVEJEVnlxS1JPQ3dhM3JHK3Z2TTFYOHZjUnBt?=
 =?utf-8?B?bitpTlBoeDV0Q29wb0l1VStsaVIvQlRlRStLdHIrcTBJTmJlZ2M3WUNJUEZm?=
 =?utf-8?B?SmRQQVBPeXowSjhXRVllcnpjd3ZGZm1lU2g2cWlEUXRkbng5V0dmS1Y5RGh3?=
 =?utf-8?B?SkFhR2lXVEMzVEdMaTFCRjB5RXRoQXhtT1Vic3VSakJDcE12NzVXOUhJeHB0?=
 =?utf-8?B?TjExT0VpQ1h3amVJZ1pRTGxyN2VpQW5FR2RZajBZWUozNXBIK3ljSkdZUkhy?=
 =?utf-8?B?RjRka3FXSVF1ejM3QmxuV0pRRTRWY1VUditMK0R5V1NCc0FhdUJvbGpRdHFS?=
 =?utf-8?B?N3RLU1N4NmdCN3BrRnExbFo2M0NvZ2kza3dSRitXRmNpT0ZrMGxKNFh1dTRj?=
 =?utf-8?B?QXk4eWJ1bStFalExVXZ0bHBkK1BqamVwbjFwY3VlQnY2QU1wdkt4QmpxaFpT?=
 =?utf-8?B?QkNJRTVaQkJpTjNzb0tQblR5dmZpME1CNGV2YXQrVUtYWnZiWEhQemk1ZnF3?=
 =?utf-8?B?cHB1Z2NXeTJxa1hGckZybzBzcjRYNUNlUDFNaWc4b0gwZmloQzMraDNRRUt6?=
 =?utf-8?B?WnBQQ2Q4UnpVRlY1dVArWHFpdVVzQktydENZTjJUVmNIZ2R6S2NWcGFVZTV3?=
 =?utf-8?B?U1RRT1R0dFYrWUs5RkRCUFF3S0k2a3U1cEVydEtwKzk1eUpKT3pnQXJxNlhh?=
 =?utf-8?B?cisraXdTUzlTU0lJRXBBN1JjeE55UkxsMDBUTkJaU0dkdWNhamcwS1REQXFK?=
 =?utf-8?B?ZnEvN2tvUjhzdEpWYkFGR1lXQXBxVEZxOCt5Z05hZnZoendEenZYSHpKUnpw?=
 =?utf-8?B?VGVtblVMTVBqL0txeGZsQmhDZndmK0Q0TDlYU2V1QWNoNlRNbm5nalQ1Mith?=
 =?utf-8?B?MiszcTRYczdYaDB6d2tiL3Q0d1c0REZqUkVpT0ZraTBHZ0k0aDA5NWRpWFdQ?=
 =?utf-8?B?SERjZmQvUm5CZzRiZXByZ0ZrK0o0bWF6eHlqMkd0QUFxYmY1bC9KL2RYbEd3?=
 =?utf-8?B?ZWJ5d3Z2Mmt0QUdaelUwSEVNRVRqQWdqVkk5WDhxTWtPWWFKUTNCYXlsd2Zs?=
 =?utf-8?B?aUhOa3gvS09FRjFmY2JQTWRHb2dVZlZjRUtiL3JBV3U4UmhuanoyYnRub0Z5?=
 =?utf-8?B?ek5oWDJhd1Foc05MSHdWNnBYME1lRkJKVDJ2Um1KN3VFRStVcUxvRDc0Lyty?=
 =?utf-8?B?YWRRaHJUYXVnTE43ekh6eHFVNHJjV1pSVzFVNVd3NEd6MDF5Z1ZReXhFRExH?=
 =?utf-8?B?ZWsxK2NMR0V6ejF3VENUdFF4Qno1c1NUdmpuNTlyQ0ppY3kwWE1yNi9JbUt3?=
 =?utf-8?Q?7lfCWY9krUCm9P0IsIIdM8PmQAV?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGpoVjI4QU9MT0IzdiszR0dLYS9ET2kwTTZjODE4RER4R09PeE5QSE9zR05T?=
 =?utf-8?B?aEFFRjJRbUNMSklQMGR2WGJERm5QbFVPM3pvWm5xSDF1ZzlYaUlOVVJzdGFK?=
 =?utf-8?B?YTIzcG53Z3U5bzBrekhIeVpYZVNkenRxQUFZWlFWTTNXQUtNcTR1SVpHZ1VS?=
 =?utf-8?B?NEw0OEtFeXJubnVqT2dHUjZ0VzNES2dITjRWbFFEeHNlai9NWGZQSXIxbFVz?=
 =?utf-8?B?MytWN3VuNzRQaWJ0Q2Z1VHdUQ08wNVNUVkdvREk1amFZaVRadFhUcGVrWmdH?=
 =?utf-8?B?QkprRktnTlJqaXlRUW5iUGF6TXNZUnBYM3NVaTVkMWg3V3dTR0VKUGxBcm9B?=
 =?utf-8?B?RkpaRzFsZ1JEd3BTbmtHbWxCTi9rNGhKOXRwUTNLUnFJSld5OVVDdDZDQW5p?=
 =?utf-8?B?WkNML0t1S2hneE1Rc2VZM1hFNytsQzhtY2QxaGNrb1QveUxtNTlXelBCQjNK?=
 =?utf-8?B?Y0NzT3crMmRFNGFXMHZxd3pVYnFSQkpzb0lnU1lJZktiSzl2bHN6emdqOVZt?=
 =?utf-8?B?OXU5NjhsY3FzV2NURjNkUmwzeUFYQXlPaXNYYW5XbGVpSksxV1MyRSt6NEZE?=
 =?utf-8?B?ZTB1K1MzOGQrRnlBc1hQSTEvV242YlVyM2Frbmplc0haUEFLdFlYSWZwZGxk?=
 =?utf-8?B?UmFZOXJGeTVFNHFYN0ZRMXZNMGFiWTlXRGIwUktuQ0RneCtSbmRqZVg0OTlm?=
 =?utf-8?B?VjlZaFN2RHBMTXhoUWgxTkx6eW9qVFdEWmlUSmVNK29YTzZqN2daWG5kenN1?=
 =?utf-8?B?Nm5nSnVYeW5naWxUemw0dCs5VjNuWXdQalN2RFBxeUVlUjJENzBidEFoNlNO?=
 =?utf-8?B?MVNHU3Y4OWFsWVZGVGFIeEQ1VlZqek9mMkYreXRvejdFT2hPUDVGcndkYTE4?=
 =?utf-8?B?M3lYWkJpMVlkNWltMjloZnpDNUdVZ2ZzUnFrN1dEVEdGTDhDMk5VUjErUVM3?=
 =?utf-8?B?Q1VjWGNEaWVQdndZWDJUV3ZoVVdMZllHYytqcmxoVmVXTjBMbndOR2hrcWI4?=
 =?utf-8?B?MFFweEluRTdrTFMrbTZod0hnT2RQWEdnVmNCb3N6ZHhMMGI4YklxMnVtdUE5?=
 =?utf-8?B?dDRzbVdXcEc5Q1BNTkFKRVNqdElZa0d6TFJ2Uy9tU2N2Nm1KUU9sT2dLbGUr?=
 =?utf-8?B?VUtjUE4xeStLVVVoVm5nOFJ2anhFL3lyT3I5WDc2bXdTY3AyV09tbFBSQWdu?=
 =?utf-8?B?RU1tSUpoc3FYVDJhS014by9pcit5YU02OHlwdHBIVmkvQ2JjVUl3ZUhNUlBH?=
 =?utf-8?B?RFh1V2RnUm5IRjc1bDlZZGZxSUNvREV3WHVlb3dTS1pxV3NBRDVPZ2FDVzNB?=
 =?utf-8?B?ZjV4OGlJRW8rRUYrcHNkWVd5Y0lrUlFFaHZtdlV3NTNqNDh3TDluT1A5OGxD?=
 =?utf-8?B?WmFyM1Mra3krYi83eVFleXlvZElzVVJ2a25YeGRCOXYyTGFNZHpYckNwU1p5?=
 =?utf-8?B?Q1I5SnROWWE4OURteGhhT24rVDhFcTVpc2dpSSttYVRNY3lYQUdXTHhReFFV?=
 =?utf-8?B?aWJZc1loeE9LcnJRcGpsY0hYMy90UjJDbDZPenE0K3RCUmh1SUJkRlZrY2lx?=
 =?utf-8?B?M1FvRHFZbWZlS2xqb1pBZ3J6aWplNmoxcVZQMnZRVmVsclZvWDJLcUIzK2Vk?=
 =?utf-8?B?QWRMWHptbnBVUW5jb3Z4eVFvUm1PU2V2b3J1RkV6dUVUTVY5aFlxaGpXbThT?=
 =?utf-8?B?Ny8xY2wwT1NVNW9raER0SHpJQkc0SDNBTDhCMTJ4ZHROMTRNaXJIL0lYTVZX?=
 =?utf-8?B?NHk4ZE43SXkrTTdsYWRNQmhHaDczYjNYWTBqS1lsQVpWZ21tN3ZmL2MyeUpD?=
 =?utf-8?B?TFIzMzNkWVljRGpkMlhMRmM5cHRhdFh4VEZ6WVZ4RE56dy94UUorNmY3QnFZ?=
 =?utf-8?Q?FtNp9XIaArFdk?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a5b20e-bac3-4132-d8b5-08deb7617f11
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 17:50:50.7786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWP194MB2865
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
 drivers/gpio/gpio-fxl6408.c | 2 +-
 drivers/gpio/pca953x_gpio.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-fxl6408.c b/drivers/gpio/gpio-fxl6408.c
index c8d2dff5f7b..180799139b3 100644
--- a/drivers/gpio/gpio-fxl6408.c
+++ b/drivers/gpio/gpio-fxl6408.c
@@ -273,7 +273,7 @@ static int fxl6408_probe(struct udevice *dev)
 	u32 val32;
 
 	addr = dev_read_addr(dev);
-	if (addr == 0)
+	if (addr == FDT_ADDR_T_NONE)
 		return -EINVAL;
 
 	info->addr = addr;
diff --git a/drivers/gpio/pca953x_gpio.c b/drivers/gpio/pca953x_gpio.c
index 523ca8473a8..965a5fcf30b 100644
--- a/drivers/gpio/pca953x_gpio.c
+++ b/drivers/gpio/pca953x_gpio.c
@@ -312,7 +312,7 @@ static int pca953x_probe(struct udevice *dev)
 	u8 val[MAX_BANK];
 
 	addr = dev_read_addr(dev);
-	if (addr == 0)
+	if (addr == FDT_ADDR_T_NONE)
 		return -ENODEV;
 
 	info->addr = addr;
-- 
2.43.0

