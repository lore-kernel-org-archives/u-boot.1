Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87B8CA0EEB
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 14:25:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDB69809A5;
	Tue, 19 Aug 2025 16:25:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="Jxl8KPiP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1213B80FA1; Tue, 19 Aug 2025 16:25:41 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 848E8802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 16:25:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJTBPMpwL+hGMGs5ujmX75AUY1dh8UMiQiDYDHbLgH4/puRAJE+1I/lyyjDDRmG7126xvHk/Lg66nHo6Jmg/kqnsnxBdWmF9gUGcCxjKhIz4LAi0CdlJsTNVLkuT2BPsP86kr3ih5p+cqlsgJT3eUBAfgQYouk86SCqsEkan9ZNhtC4OzuMOTen8TiWKpxhb+CIQZNEpxX/k9ZB8uo+DNoWDkmAlnczaRkbyonw6/0q1EIPUTzPxpcmU138mTIYMUI/FIOEgywvum/XZuqb32PUFJb4AaE57qjFCjlsH1nVPoGrVmzfwgVrqdxmCp2nkSZsryaWVUOH6OVhUIBGcmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2PjVCx/WST5+vnPq5KR8x1bBaYfR5r9D57fDx5GnFQ=;
 b=yHCs70a0Qihc0JkOVwtuO3BmLo+oiHIt7ILCUq6rdlg5XjX8jaGluyzwnbZ+OBQRn2sRJXT3nYc9ZHh6h/OgEeK+p6IqKPRn+vSdhvTBnuUDmCvEz4tc9OYOHk1gPv8o7ZImMcHNEhYEGIiw+bm0liuSYtIVbTeGSAfq65/lGpVMTTmqGWicy33Hvp+7sL+mUTnUF4aQH3NLCn1FajPGL/7k72YxgCOiGd6GUs8AY8Ml/BdPznqxCsdn2y4UiimeA3mNYTADE1NbTwA152LONbtOkmpiYxz15EbwM4e9U3PpkHN1aFOmHYq9xFd1S3l9cdv/1bQhBVNTh0ShiSALZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2PjVCx/WST5+vnPq5KR8x1bBaYfR5r9D57fDx5GnFQ=;
 b=Jxl8KPiPr4MCWPJmjbvSivYAzhJsTAqZL3s1Okz5aeTUNJacIjHRc4VBTlWwnXauILKQAQpg9S3wH92t9Foqv7+v7iMZviYhiMbj68Q8IXrZqHxo9R8d2ATpERXOG5ZPcHE1HbdyXQxtslIRCc3kO1shqt+Df2M2oUsDY7fPgQ48nn1vhzNx682SGrClSTWsvoDG5neUw+KlmGAco6feoabnYk69y80NjOrnuXWfytf04NfYGvRfVaMrBQyfyY7j3UhR8D2DQ64c5w7DySbz1jMpiJwpDE390ihG68mb86vhwOmOA7YmCPo29WZG+8vMXNGNEP75/t//sp0rQFulRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by PR3PR10MB3916.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:48::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Tue, 19 Aug
 2025 14:25:36 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Tue, 19 Aug 2025
 14:25:36 +0000
Message-ID: <09692d56-f5f9-4f3c-a086-b6513cca748d@kontron.de>
Date: Tue, 19 Aug 2025 16:25:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 19/21] mtd: spinand: propagate spinand_wait() errors
 from spinand_write_page()
From: Frieder Schrempf <frieder.schrempf@kontron.de>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Gabor Juhos <j4g8y7@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>
References: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-20-mikhail.kshevetskiy@iopsys.eu>
 <d4e3714d-d687-427d-8136-5388694603ec@kontron.de>
 <8b7bcbd2-4c66-4e2d-b169-c79eb7081f2b@iopsys.eu>
 <d2f236a3-b3dc-4949-bd3b-4020a4ba108d@kontron.de>
 <d7db7457-12e4-4dd8-84a5-581095833add@iopsys.eu>
 <7b167416-41d2-4ab9-9786-bd9a98358922@kontron.de>
Content-Language: en-US, de-DE
In-Reply-To: <7b167416-41d2-4ab9-9786-bd9a98358922@kontron.de>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: FR0P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::17) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|PR3PR10MB3916:EE_
X-MS-Office365-Filtering-Correlation-Id: e369aa73-a4f9-42b8-7183-08dddf2c43ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHRLSnE5TmNuZGhlaGR6cDBlRE0wNGFzZG9EY3ZGaVF6RDY5R24zdk84eDE4?=
 =?utf-8?B?N1locitjcHB6alZaZGJ2bTNhc29CSTBlNXh5UmxvZmpjSXdyZ2RxL2FBa0hO?=
 =?utf-8?B?VW9WTWFRUFNJOGdxMG1ncVh1SVZFUnRMZ1d6dUM2bmUrVzRoUHVEZ0xkVDRt?=
 =?utf-8?B?b0VwTTNSdm9oa3J6Q0o1Qnl0K2hUdVdCSmZkOFY4ckU3T284OVhMQy9xcGNO?=
 =?utf-8?B?M2VZekFuV0ozRlpFM1JzcVRHSEpNUEVNUS9HRFE3dkd5UWlxTnQ0bmVOYlhy?=
 =?utf-8?B?OTRoTys1UmlTZDdzS1FjL255dFk5NHRMSFJGQzNXZCtDY3RQT1dxOTgvQ0VX?=
 =?utf-8?B?bWdsaTAvcHlQQStIa0dxL05sVk9hVG45dVNURjYxUUM4bG5Xam1zRWdUWFNV?=
 =?utf-8?B?NkdmQTI4ZFJaV1MwdlNST0J2MG1ZcDVLak9hT2FkZm1iRzFqR3BBVktnTHhK?=
 =?utf-8?B?SXBSZ0NXRmZmNzRvRzVuZnBGVld1dmR3SFlrMGg4SXVmVHE1bm01WkFxL2dI?=
 =?utf-8?B?WCtOYjYzeTU5TGVaTW44Q05zS3dEdGV0dmxVSTQvQ0k2R1V4QTJwcEdFaTMy?=
 =?utf-8?B?SDZGaW9iY2RGS21Ycm9xUjV4K1hqaklMZm5OZjJxRzA1Z2wySGZIWUM3b1Vs?=
 =?utf-8?B?eEJNSTNvalZBQldud21DTDB6VjdRWC9Hb1hVOFVwcFJHRTQ1dTJJRFJGMFZG?=
 =?utf-8?B?WGc3R2hlcWt5cjNkSWZHck5DNTkwckxjNWRVN3FPUzNIc1FTM2RDVHN6bnNq?=
 =?utf-8?B?ZkFNMXFLVW5zbytrRFVQa1NYTmRWS2JEdkFRWjZkc2ljVTgzL0UxZG5Ickgv?=
 =?utf-8?B?WWN4R3BKNmdrQ01KTVE5Y2srUjBGanF2aXRnYkFlTTB3RFFWZ29yWVQ3ZFFu?=
 =?utf-8?B?UFJNRUQ2LzhtMFh0TGVENWpLL1VITVlmR1Rqb0ZzOTBQYUlNajFvZTYwcGdG?=
 =?utf-8?B?aTJuQTRmUXRkNE1aaENXR010VURtenNhR0l5U3kvcm5RNnNneWo0NzFZb2s0?=
 =?utf-8?B?Tk10bFRaazY5Z1BTRFovS0o5UWxLZ2dJOFpQQjF2TkRBMUYvYWJRSXVoU2hs?=
 =?utf-8?B?R013bjZOaDc3bEhWWncvVldWVGNROCtwSDV3MjFVQ1BzSGZCQllPY1ZUQUM2?=
 =?utf-8?B?WFBhQzk0OC9KaWtyeW10UDN2K1Fpa0REU1E4ckZwb1RnZEUybkw4d0V4OVpK?=
 =?utf-8?B?M0VzV2R4R2JTdlM3VFp5U0p2UE5Rb0ExUysyRk5zREhSU1pFQ3l4TUVRMG03?=
 =?utf-8?B?ZW1WaHl2MkhKazhPWkxXSDdGT2RSQlU5bldtNzhTRC9OSXIyek1acGEwU2cv?=
 =?utf-8?B?cGZBOHdoWHRkNGxQaFpYcjhxQXRnQUM0NUVlRitqVi9OZ1E0QTRuc2oxZXdW?=
 =?utf-8?B?eWV5d0RxVjZxMjlJYW9mUW1vTi93MHpHMGJqcDNVdHVteVpickNmQjk3MkdN?=
 =?utf-8?B?SEVPTDVYL1M2TVJwRk5pSVpNWlk4R1BBMjRiSkRFTEVPS3kzMlI2S0s5QkZP?=
 =?utf-8?B?enFPSVppQTRXNGk5NEhPQXpEZkZzL0FySi9WeDNrT2htYWFLOER3U3BUcG5v?=
 =?utf-8?B?Ykx6UWFmUVJrM0xSb2JxUm1jSXRQTWdwaDdrSXpmWlhOTUlQWitCTm96T3Jq?=
 =?utf-8?B?bnU3WEVrU1czd2VKVEdJK0xOSUdyTWNnbEYwVFd4a3gvZC9Ud3FYNzk3dG85?=
 =?utf-8?B?OEdhUnpnZ3pudzM1TXRDSmFiOVlURUdUUEJyOHQxMXQ2akZpVEdWSm8wQys0?=
 =?utf-8?B?djFsVWU2azRMS2txUzdsK2kwbTVKK3Y0UDdoaXVrTHgvLzAvWG1vYm1UOFdq?=
 =?utf-8?B?NmZ1aFBMSlNKbmE3MUdtcGk2eUpVL0ErbVhsZGowWWl1aFpTTElGb0dseE5n?=
 =?utf-8?B?RlM2cXpzN21rOWhFeVlQdXQ3YWMzVEVCZTl1QzFwdnVNL09SZ1o2OGd2SXBX?=
 =?utf-8?B?dksvTlBleE92K0szTXNGRUdRVm1UNXp5Z0FFMkZ2OGtxNnl4aXVUdFF1U00y?=
 =?utf-8?B?Z09sL2hmMDh3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3Y2Q296L0tNdzcyTzZXYk5QZFo0ZCtiNTVFa1IweTE5OExNWHFHMjdrN09Q?=
 =?utf-8?B?ODF5RjhVV3l3ZDc1WGlmRlcydDkwMDhHVURja2tTczNPQ0RyaWU3WTJnOE1S?=
 =?utf-8?B?ditpWGFGWUk4RTVLZjNGY1llYlNCdjBQSHlrRUsrOW9vVWNyeWZPWjFGNUlR?=
 =?utf-8?B?SENlOEE4UkkybEI2NG51WStwNmRMUHk0ZHVKdFBtdk5WUjRWd0ZwcEtMOFdH?=
 =?utf-8?B?cmpFSFRvSHY3NDY1eEpieHZVa0x4YzBIT1h0TWgrSEVMMmM5ZTB4aE4wcFJZ?=
 =?utf-8?B?bjVSSFp3Wi9Kci9jYUpteCtwWnBqL0cxUkc5ZkJ2V0cxUERlWUVHKzJELzRQ?=
 =?utf-8?B?UzB3QnlPNVFyTytHV29XQS8ySzFqUERzTFZpTDB0Q25uQnNPMnA4SHlYbUxr?=
 =?utf-8?B?RElVa0RyQUxseU1CSEt0SThpak5vVmphdDlJMndlTkpqSkdiZkl2NzUyclpy?=
 =?utf-8?B?VEs5WHMrL0h0bnk2RXpLRzh2ZE1vSCtxZHdvV0FMRStyYzFjU3c4cDgyYjR5?=
 =?utf-8?B?Y2ZMdkpmcHZxUE15RmlpRkpIUzVLa29MNlBxMERVbHQzNXVrcHVaaG1tdVlI?=
 =?utf-8?B?ZU5aNTJBdUFqT2g2SlFkY0dKM2s4Yy9naE1PUXJaNGdoQ1djOXVvcFVtY0Nn?=
 =?utf-8?B?OGFaZlNTRVBmd2JLSjNWUXV2K2J1UFk4S09UZWRFbSsza1d0MGRjNW9BaFBw?=
 =?utf-8?B?aXY3YzVEY1llSmtXbm5jWWFNVG1Ic2dobGRHUHhMNUxvNGllV09UOGRYTmN6?=
 =?utf-8?B?aElOck41L25sV1hwSjUzeHFoRXdpOVFOVXZwcm1DcW1vZFZOQTMwWEpyalNK?=
 =?utf-8?B?LzBGR2J4VGxhcndFcFZWL1pxNWthUlJmREttY2ZLSTEwcG00ejJXR0E0Tmw1?=
 =?utf-8?B?bkpMeXNERFJ1YTFiUCszZHUxek1VMDZiSzZZbnlsS3NVdzhmM3oxVEZBYXFs?=
 =?utf-8?B?OVI0MFhYcVlwQ0RCYTNvZEVuajFqOVU3aTRyZ1JwZ1N2c1JtcDhHNGllYkMz?=
 =?utf-8?B?anNKY1JUTDhBK0NFTjUzV0lmaU82UEo2TTMyakxPNFVLOHFkQkVrdDRDQVEw?=
 =?utf-8?B?UXRid0ZKdHVqY0tDQ3YwckxSMTd5enpyYmhuY1hTUVhpYnFEa0dDaUpUU3pR?=
 =?utf-8?B?MkZlcFVWVG5vMjdFSkJoNnlQSkpLc2hqNlIzWmYvb1BtUGh3b3NEdGczc2lK?=
 =?utf-8?B?RjFraVZLSnRPa2JqQ0tKaU5QbGhTM2dGS3J1cUQrcXdBRWxiNk5CcWRsRnBO?=
 =?utf-8?B?blphOS9QcndZckp0YVZXWnEvMm44RmY0ODVZOUIvLzhRRTBQbVlQOGlxVFhO?=
 =?utf-8?B?YlJBR05TNVpuUjFUNDROMDl0WTJmYktRY016Y1huR2x2MzNZUHp0b2hMd3lD?=
 =?utf-8?B?YmsyV29TejNMR1V5NU5mYzhXMWZBRDMwS25Idm5nM0YxU0p4QmNjZ2xIajQr?=
 =?utf-8?B?dkJYVTc1dlFxMmlZdEplR0Zkc2VPN1FMbXY0YkU0VDJENCtrVW5SeFR6WUtw?=
 =?utf-8?B?WXhvZ3NuK0Vhd09oZlNEK0lYUmMwMHcyRXVEN3RYcG55NkZPcGFLTEROR2l6?=
 =?utf-8?B?Yndlb1hLcGZOSmtaRzk4clJJbFV4SEJKSzAyMzZKcGVFb0UwOTBaR3pTVC9L?=
 =?utf-8?B?eTJoTDlEYmVxT05UZVZ0Q21STm5MSUhaa0JkWmRrWTRMdkVLUkkrU0tBN3Zm?=
 =?utf-8?B?bGFEZ2VibGRISWk5VjlQb2U4Y2hyckhpVktqNzZVdHVkWkt2S0dnSmRpbVFL?=
 =?utf-8?B?bGxCZ3dUS3ZHL2NTN0VSQUtKVFNORm9iaEZGL004S3JkdTIwQXVBZVQvTnZO?=
 =?utf-8?B?dzJ4VXBYblgwVWQrQTlubE51am1VSm9xT3BjdmJxa1NHemFUL2hUTjViMm9x?=
 =?utf-8?B?cG5Vb0hJMUdLMkRROUxqajdWdGQ0d0xFcy9LN1l4ZHpDcWkzcU5yc0NHYW5D?=
 =?utf-8?B?QmJ1RlJad2F6cGs2ZkFiUGpkODd0Qy9FL0tZREhCWDM0YkY5a2EwaVdsZUtN?=
 =?utf-8?B?eERuOUtWRHpuQ00wWTY1dWVVTkpuTFVhYTNFSGRkcDlvNGJDQURCNUFhNm9T?=
 =?utf-8?B?U1czL3E0U0pVc3Z1aThobmppM3ZRcG5ZQWFiV3ZIZ1poWEUrV3FLRTlXcFlR?=
 =?utf-8?B?REF0NGs0WDlvUE1EdC9wcjJTT01IdW1oVjdQbTd5SkMvUVhjOEtZbnhjMXFX?=
 =?utf-8?B?SUE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e369aa73-a4f9-42b8-7183-08dddf2c43ae
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 14:25:36.6221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGmRoBSYfw80vj+f5CzzRD3PDIaX5BzExp3MtINAM0HoPT9qxymPNSKXQxdZgUrcSsbm5Is+P1Eud7suD0uXGMQ43FUx4C2jSGvwos+XUA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3916
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

Am 19.08.25 um 12:59 schrieb Frieder Schrempf:
> Am 19.08.25 um 12:47 schrieb Mikhail Kshevetskiy:
>>
>> On 19.08.2025 13:42, Frieder Schrempf wrote:
>>> Am 19.08.25 um 12:34 schrieb Mikhail Kshevetskiy:
>>>> On 19.08.2025 10:26, Frieder Schrempf wrote:
>>>>> Am 18.08.25 um 12:06 schrieb Mikhail Kshevetskiy:
>>>>>> From: Gabor Juhos <j4g8y7@gmail.com>
>>>>>>
>>>>>> Since commit 3d1f08b032dc ("mtd: spinand: Use the external ECC engine
>>>>>> logic") the spinand_write_page() function ignores the errors returned
>>>>>> by spinand_wait(). Change the code to propagate those up to the stack
>>>>>> as it was done before the offending change.
>>>>>>
>>>>>> This is a port of linux commit
>>>>>> 091d9e35b85b ("mtd: spinand: propagate spinand_wait() errors from spinand_write_page()")
>>>>>>
>>>>>> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
>>>>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>>>>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port
>>>>> This seems to be a fix for a change that was introduced in patch 10 of
>>>>> this series. We should avoid introducing regressions and fixing them in
>>>>> a later patch to preserve bisectability.
>>>> Hm, this a bit contradict with removing fixes for continuous mode. In
>>>> linux, continuous mode makes some flashes (mostly macronix) almost
>>>> unusable on some platforms.
>>> Sorry, I don't understand how this is related to the continuous mode
>>> fixes. I'm just asking to squash patch 19 of this series into patch 10
>>> so the changes of patch 19 are included in patch 10 in order to make
>>> this a single consistent change.
>> you write: We should avoid introducing regressions and fixing them in a
>> later patch to preserve bisectability.
>> Continuous mode introduce regressions (see:
>> https://lkml.org/lkml/2025/8/14/349). My patches fixes this regressions,
> 
> Thanks, now I got it. By syncing with the current mainline Linux, we
> also introduce the same regressions that are currently existing in
> Linux, yes.
> 
> But that's a different topic than introducing a regression in the
> patchset and fixing it later in the same patchset.
> 
> The first problem should IMHO be solved like this:
> 
> 1. Fix regresssions in Linux
> 2. Port fixes to U-Boot
> 
> If we want to avoid introducing the regressions from Linux, we should
> delay the merging of this patchset until the Kernel is fixed.

I just asked Miquel about the fixes on the kernel side. He thinks they
are good with his review commits for v1 addressed. But he didn't review
the v2 so far.

So if you don't want to wait, you can also add the patches back here
now. Or just wait a bit and then do another sync.
