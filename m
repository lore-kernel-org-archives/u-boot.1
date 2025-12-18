Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5412FD6ACF1
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 12:15:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2EF383E13;
	Thu, 18 Dec 2025 13:13:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="UHGHt3Wj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77CA583C6C; Thu, 18 Dec 2025 07:48:57 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazolkn190100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d200::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C7D983C28
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 07:48:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1b++BqxedhUqL7boMil5atOLkamL0Dq4GD1bQ7+jMSt6LxY6POWt7QO99+vzyVUE9O/Nnu3w6eAClIRvVszUqabUXlRn9NWtumTvR6k2MoZtqc3KqIz+nu+RwijCRYRgJenJtoz9IPL9uCMsO514aNge8Iko7+lnV6g5nnmcPsX3gJm1OeYvP4a+yKE2IbbaNCDvcb5kExYPh3SbqBPljC/YrN9lSkkuQr4FSAzE6UYw+tN48kr2MUP8iutfsFWD/33C26Y/PjLRR44Sqy8cjREXYXfK9geFXbs9dj3VhHnIAhNkbPqCsl0I/7ay4sNMasSLm12g0qqN6ykTuJ37A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtdvC1ZeHYx3xw8/+16HyDp9CA7j2PBID019bJcp9q0=;
 b=mBI8JGOiviTsvp0WGIcDF2zD6xaqs5pF1sMzY0tT8jGGihAb33GLBReiGQFZrClgPDmMCLHSd0b9waRs24Zjy2Os5OhZRu5fQoFE+GsWleTwn7lHqfbEoTDju6FlnGRK+XyoRtJo06sTkNFxAtGYjxTHakaLt0LXgBU4yXpVEmU0bXeaKZWrmXfVNx9QQtcHKIyC1balyFa2T7sb0f8b2KcaHufc5sRS6DmWfGKhMCWCE6T0SuRTWy4+k2qMcZXsLS7AfbHQbBCQ1ZSZ6elSkTiwzT/m4gx9wn3Ip+zh12lABeQId7bRZuBieXJqeVjXa7WtPzu4D3HqeB8SscP73g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtdvC1ZeHYx3xw8/+16HyDp9CA7j2PBID019bJcp9q0=;
 b=UHGHt3WjbaQR7b2rOVDKHaUVwTJihzk2Vx0q4efNqpaNXYkdqLZZUwl7E6QrZWxK7SCM0SUeAOQEVjzQm0U3cHSJNnK4omZ32eaQI0Oc/fmEcVtFUp+YoPfPOGG7wqathEfDq+w1AoFVKlc5jD5InwCp5ZKP6TEYLWWPZvuvgBLYlChREjb5tY18R8TFFQkoBNMnvdAM450e5EFYApd9AJl8wuDotHtg7DVwAIugjNmgiBbLrT7H805JZhx0Z1qWbWgQbrg6J3JwLS4g4o8elNXOaE2x5mCDDa1eKi1+u1CTyaPGWmWTCQX7x3HL1hTpAyh2GpOfTSf0gaCCUZgdIw==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 PR3P194MB0587.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:36::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6; Thu, 18 Dec 2025 06:48:54 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58%6]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 06:48:54 +0000
Message-ID: <BESP194MB28058E0F0D6E468ED7661716DAA8A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Thu, 18 Dec 2025 07:48:51 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] cmd: onenand: Fix handling error path in onenand_block_test
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0046.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cb::17) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <3ca5c0ea-2bbf-4342-a1b9-7acf7c7ae63e@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|PR3P194MB0587:EE_
X-MS-Office365-Filtering-Correlation-Id: a5df986f-5794-49b0-549b-08de3e018255
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|5062599005|461199028|5072599009|6090799003|51005399006|8060799015|41001999006|19110799012|23021999003|15080799012|3412199025|440099028|40105399003|12091999003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3VvN2ZyNkwraUhpdDkrd1NoNThjNFg5MG5jSnV0MU04NDE4eHpjVEY1ZW91?=
 =?utf-8?B?YmpYOERvMmZIZWtESWk4eHdrQ1ZxVzZZd1VzbytydVhEWm92Q2hFREwwckVK?=
 =?utf-8?B?akdXeTRIaHpVckk2Nm92RldsWm03MThnckdpTS9BN3pQZlNIbTdmbVpibHVu?=
 =?utf-8?B?Vi8zL2FCeWhPaE52ZG0xMkxtdXMyL1plV29nbGh1UC9TSXNuQUx3OXI5Uytv?=
 =?utf-8?B?V3FJYnJhZjc2dUp5bWM1UHRqZzIwZU43MjBieGlZdkxKTHNwOEk1WXJYOUJo?=
 =?utf-8?B?TkVxaWExTHVFUEdhbURpY0ZvaE1sS1d1VWhLUVBrSFRhSlJURFNKOFNsRTB1?=
 =?utf-8?B?WDhpRmVOSlBaYzhKci9uTU5GSU9kUC9FSDM2dERXR1VGekttSXBhS3VXY1lR?=
 =?utf-8?B?OGUyeTB2cG9CaUhZQVZvRDNaL0gwMSsyOTc1WmhIakQzclJlV1lqOEx3VDZX?=
 =?utf-8?B?RXNVUWNjSlpUNnZ3RU1CbWNkVXVDZTlWbXhObXpkb0k4ekliRUhQNXExSVQ0?=
 =?utf-8?B?WjdVQ3lCaENZUnJYemZ3Um1zUWxZYUlwUzA4ckJsK01TellLWjZmVllueEc5?=
 =?utf-8?B?UnpJZUdFWkQ2dnlJdzQzZE5yMHd6MTd3bUlTVTN5Rm8vYzhJZUxMZkxoNFJi?=
 =?utf-8?B?TjV3MjEra1duakhuTm5sMXZuTkUrd2crdHIrdC9DeUZSTUtta0VyS2FWcFVG?=
 =?utf-8?B?MFpGTCtsbXBSclNJaXFEd2g5SWxuWFNGZjJuRm5HQmd6TjJDRHFNalZzR3Ax?=
 =?utf-8?B?MGNpTlFNTzZpTndmTmFzL1VpTGZYOFJxd3FWTCt0TUIyVFh5emZIYmNBWUlV?=
 =?utf-8?B?d2Q2QlRPdnpVWmNWUFNaWkJweW1Bb0pQdkJtRGUvYTU2akZHQ2RzYTRsWkpS?=
 =?utf-8?B?V2txQUtwWVNJOGd3U2ZDKzBzREJkK2E2TkFyRE5OL0NWYWJhVjQwWWJyTnJn?=
 =?utf-8?B?MFZFWWZldHNjdDVhbDNiQmlwRG1xSk53NXdkUmsvaTlsZEREZFIxd284dUJ5?=
 =?utf-8?B?SmlXU0hMYjkvSVh5WlUrTkhJOE0vZDVncFE0ejk4Z2VyUGVmalQ2ZXR6OE1G?=
 =?utf-8?B?MVBkanZJTnZXckUyMjg2Rmk2aW9lY3h2c0tkckR3MmplMTVHSXhORDdXQm4r?=
 =?utf-8?B?Vzhrc2I5bnlmTXFsMDR0YngyenMwd3VjSFhGcnRVbjRzNm5rdkJWR2w3NUhG?=
 =?utf-8?B?Yy9VdkJlTUdMSmI1ekc0dkE0N1JlR1JnM0FSdHRGZ24rOE1CRVE1R2VCSFRa?=
 =?utf-8?B?a2FQeU42UUZyS3RONGxkQWJGTjhKRVh6R3FaN1N5MFE5Uy81b3ZrQk1wOURE?=
 =?utf-8?B?SDhBU1VUZTdNNE1wY2xNUVJ5MTJkSTI0d1FCRE9KS1JPcmdtMjFtY1lObWZ5?=
 =?utf-8?B?clB0MEtPc05TbG8rMGxrUTZ0aXovRWVzMHZ1c2hPVXhWRHhaSGh1UE1LbGk1?=
 =?utf-8?B?UTlhK1RzdjdPTWJyWkdzNk8wZVgweFFvVHRFdjlCZzlsTHRScXQyemFncWhQ?=
 =?utf-8?B?b0ZwTDNndE8ya0M5YmtoZHNsRkxOWDVyUWlmVWNqSUdqZUdINXBJNEl6S0pD?=
 =?utf-8?B?TjNxN1RQV1VUaGFiOTBCOUpSK1AzVG5ZcDZCdUQ2blN6YVdYK2R2T2xVWGJ4?=
 =?utf-8?B?RTk3UE9qZ3AwdCtQcGMxVWttUjdwWHorYXNySTh3M0pscURQdzlpRENtRHBp?=
 =?utf-8?B?SmFqMzVsWVAvck1KKzJmNC8xYmhObFRpYVBQektWWEI4RWtHTkRrdERweGNi?=
 =?utf-8?Q?MGiAArtBhEVmBslXog=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVRlTXE2TWlTME9Cald0YzR2eUE4ZEhYRGJsbXF2UTNaNWJseC9wUzBHUExQ?=
 =?utf-8?B?S21Ga2RXQjBqamRqMlN5cnNWRDdJUHJXazZFTkpmSDlqUWtOZDRJZ2l5TG9X?=
 =?utf-8?B?TzNrWVdrMEpRRkxkQXVaOUwyQ0FGQTZaN2xjNjhVa3M4c0duanIvSnU4Slg2?=
 =?utf-8?B?VkxaUm1rRm5nUllNLzdMSFRXVUNBbzBreGFTTkNaTnNJSElxd2J4MjR5V1NP?=
 =?utf-8?B?aFpqbXRMWHhBUTJ3blNLeHJsN2dFd2xrUnk4c3dDUU1CZWl3WXJBQldOK1NS?=
 =?utf-8?B?MXRuT0t4TmFvc2RnSWdwUGVMcnBpVlNCQWpBYTMwQ1dTNmxETW1xdWFmMjgv?=
 =?utf-8?B?aUx6UERhbjAwR3pMMUlrdWVtY0hwUXRaaHE0ZXlsdzNWNVpHL2NEY0NuQVFN?=
 =?utf-8?B?dVFpeXdTSXl0SGIvZ0tjaTUrTWhkM052dk12c3dTZzBHbW4yaXdoL3pxQjZm?=
 =?utf-8?B?bXZFcjhwK2syaGlnejBIanhQb2dsU1NKRzJVOUoyMFYzSGhVaXp3dEg2c01E?=
 =?utf-8?B?V0VXUGdJUUE2N1JGRHZ5RUdSdXN5MENvOVQ4ZlB0SmlqenNyWDdkNXVoRFNK?=
 =?utf-8?B?MFBmdUJoM3RUR1Y4TkhFd0k1a3EvMDZtU1I5SGRSeVhoaXlZL3RUSTVFTVBy?=
 =?utf-8?B?VDBXYjdrSWZreUN1OEFNT3dpZU1mY0RWRjlGRjhuMXdhVk9kclFCNXlQcWlI?=
 =?utf-8?B?cnNKekk2d011NHVDSDFEOUR4bExUUExLSHRDQTJIZTBGUTQ1S2tEek16SFVp?=
 =?utf-8?B?TlR5SjdtUWp0NndrdGRvaGszanFzYWNwUm5halYwWCs3VUJLNVNLb01FeWlz?=
 =?utf-8?B?Z2ZSTTNSU2hOV2FLYjFUUlRQeFcxMFFvSHFsRW5nVldxTis1RzVUMzg3WWpE?=
 =?utf-8?B?OUcxZG5PSG96RklyNy9zK3FmYTFYRzE3M1Via1FQbGJzZWxadVBOdVg5YTBm?=
 =?utf-8?B?OU0vRlRUNDg3NHBuUC9GU2x5WXY0VnAyMnJhZnc3TW44QlFIYUVpbDVqdEVC?=
 =?utf-8?B?eFpqako2cnpiSmU2eWoxN0RIOXNiR2ZkR3d1cmRPZzdkZ1BjVnQxckplbEVN?=
 =?utf-8?B?bHZRUzFwMmVvZHhmeStnWVVkN2djd3RrR3UyQkNnZzhXaE1GcVBYSDdwRFN2?=
 =?utf-8?B?L090c2ZGTHc3OEFpcDAxTjlXeG9JNXAyVGdmMkhUSmhJeTUxYTBsNEdtL3lz?=
 =?utf-8?B?dHdMZGFOcHkxN20vRXgrZ0ZnNmR2NUEvZHppNFUrY05Fc1BEYjFDUlk3MFo3?=
 =?utf-8?B?T0xlTno4WkZyNWZXdWk0QWpFS2hSODlFcVNQT3FTN3h0RWU2MkxmWi8rTlJF?=
 =?utf-8?B?bG5Md21JMGhJMVdjcWlLRlN1VkhjcTZ1RzdkRGY0WnBkK2UwZkJzZ3JwRXFo?=
 =?utf-8?B?b0pZSzVYelA1SWJRN1liNHB3TzhZWm9UeWNwaVBqYldLcmsyeGgzYVJkT1l1?=
 =?utf-8?B?UktBRFdpNk1TRWl2ZXlWVDBTZ3JoQlBMT3pleWxpQzFNUnFjcXMyelBGSHVq?=
 =?utf-8?B?SVFxeGg3SHRIR3lnaUNGR09xUDBTeU9nU0c2cy9sYVJ1aDRnT1pnRDBvdUdj?=
 =?utf-8?B?Z3YyNzRjdzZzY1lnTGdUcm9lN3FFU1ZrT0lBUzlEbTVLUGpXSEIyTTJJRUVs?=
 =?utf-8?Q?sMq6D91BCCqIJa1GBEjcwsffs4j/LM+KruVOyB4N2ptY=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-e7640.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a5df986f-5794-49b0-549b-08de3e018255
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 06:48:54.2190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P194MB0587
X-Mailman-Approved-At: Thu, 18 Dec 2025 13:13:57 +0100
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

If memory allocation for verify_buf fails, then one
needs to make sure that memory allocated for buf is
released.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 cmd/onenand.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/onenand.c b/cmd/onenand.c
index 6e808ce3fce..90f4f52f4af 100644
--- a/cmd/onenand.c
+++ b/cmd/onenand.c
@@ -236,6 +236,7 @@ static int onenand_block_test(u32 start, u32 size)
 
 	verify_buf = malloc(blocksize);
 	if (!verify_buf) {
+		free(buf);
 		printf("Not enough malloc space available!\n");
 		return -1;
 	}
-- 
2.43.0

