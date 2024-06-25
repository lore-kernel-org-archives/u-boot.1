Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F654C2BBCA
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 12:41:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5A07884F1;
	Tue, 25 Jun 2024 14:41:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ai+UVqod";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDBE78848D; Tue, 25 Jun 2024 09:19:54 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF67E884AC
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 09:19:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSHUREfHvCFweGhabWG3DOsDeHjzfBVPWK577cC/Sqvq77jXPg1XH0BmkAlXAfJHrRIRbCHUrz5hv1hgePFUVxzR2M172Vq7DxwZHPgFPkaoy+/dUvQp00tXP4H5Sq6qAJVJUrrrvTOJXROBWzTmm2OpiXQFayhBgHkY07gVv6ccjC3E0CkGyBqezNRVD+7K//Ncx9aChSy0FpaMt60pVp4ALP2Xhs3dRlI5B7ONOdYDh91v274U4J2dn5zLwvBCnlFdpbIVB4uZei2tBx1mqblw8oOVMfqm1SmbWLlBridMztYza8Q+hTN0BxRFLKfc8f8PUOg7fyGBnMXUzUmuQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIjUQEJAEQUWiKqcEy3Zt6Jwk8p+wTqg+GFBhN48SXQ=;
 b=MF9osmk+E162Hm0+W+h2iKKuHo/VDoo5HaD2lHEnLaO1hX25DB0aI/7tYL2b4lUh9Cub2uvgNVrgizey5ojOTExvNgebOk8Fpu1CFWZdBiL1pWZdhwqNmmajvqT6zFzZfTMIJO8/cUwsCUA0igLNwjCjWST3gH4TjbddAJ/qosfN1m9jqHUJZepl0Y3il66Rua0wZVAXsJ2fzSQfQYwT36BvW2ver49mam+zog75bp3cGWIoX21rBmvBq++uDzxQ14Ri2ry5JwI78d3Veri82TbEkA+SecstRNuTc3EQN94jEYtsC1M1n51AmqXJRT31PBi5uFlwhYJkodSR2DJuOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIjUQEJAEQUWiKqcEy3Zt6Jwk8p+wTqg+GFBhN48SXQ=;
 b=ai+UVqodg7DRkbhB+dpzij1VfObN76SyVOpL+qJRnWnxCmNatxzVIxK5SEdBGaSmO9tbSYpe1JmNvjzc2cogHs/e53F1slQuWZFfFgwvRkktyZnw0VoA7vwm7zT3kzvdGMB85Vc0eT7V8pgRTbH/vsqL+wbkg8LEnlDLZslxYAY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by VI1PR04MB9857.eurprd04.prod.outlook.com (2603:10a6:800:1d4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 07:19:50 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.7698.020; Tue, 25 Jun 2024
 07:19:50 +0000
Message-ID: <74947062-1cce-443a-9fe9-b5538304205c@oss.nxp.com>
Date: Tue, 25 Jun 2024 15:19:35 +0800
User-Agent: Mozilla Thunderbird
From: Ye Li <ye.li@oss.nxp.com>
Subject: Re: [PATCH] imx: hab: Make imx_hab_is_enabled dependent on
 FIELD_RETURN
To: Fabio Estevam <festevam@gmail.com>,
 Paul Geurts <paul.geurts@prodrive-technologies.com>
Cc: sbabic@denx.de, uboot-imx@nxp.com, trini@konsulko.com, peng.fan@nxp.com,
 ye.li@nxp.com, eduard@lionizers.com, marex@denx.de, fedor.ross@ifm.com,
 rasmus.villemoes@prevas.dk, xypron.glpk@gmx.de, elena.popa@nxp.com,
 tharvey@gateworks.com, sjg@chromium.org, vitor.soares@toradex.com,
 u-boot@lists.denx.de, martijn.de.gouw@prodrive-technologies.com
References: <20240621130626.729666-1-paul.geurts@prodrive-technologies.com>
 <CAOMZO5D69WsyoKzccHNxmfc3mWpQkNOd0-Nii+KypXa4j0qahA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAOMZO5D69WsyoKzccHNxmfc3mWpQkNOd0-Nii+KypXa4j0qahA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0213.jpnprd01.prod.outlook.com
 (2603:1096:404:29::33) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|VI1PR04MB9857:EE_
X-MS-Office365-Filtering-Correlation-Id: 487ab318-fba5-4a12-0e44-08dc94e73375
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|7416011|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1hJaU1kQkxydHBvejNuMTU3TWpTUStNbWtsdGxHaXFvWVI3ZHl6ZHllZmdM?=
 =?utf-8?B?TFZ6aTB2ZVFseGV1WVcvWFZ2eUYrMFJhcmd5ZjFFTjRxZjVvajNMSG92eTlT?=
 =?utf-8?B?RG1PdWg4bkltZWJSVzV2dGpITFFNenlRcjZZZS9OWDBOdmlpKzMvSTRtenll?=
 =?utf-8?B?cE16VFVQREQybHB5WUxyTENETUkzUzB0U3NjdmJnOEVFbTVEay9RM1NDY3Bq?=
 =?utf-8?B?Q0xSL3BoM2ZiaHR3dWtTclovaHFKZ1RDcU9CNUNPbysvVFNvNDhJb1N3NkNM?=
 =?utf-8?B?Y2tQS243VXd1dkZRQ29WaW05ZTVNMWx2a1QxMDlNbHJLbHpXVmNDR0wrQTNK?=
 =?utf-8?B?T3p5cHNMaXBqVlI0MUVhdTZkMEJEVGZKQ2doWXJ0M3FZNjlUVVJHR3dDOUxC?=
 =?utf-8?B?Sm5pNm5EZldVYzB0SnhKTG9zMjJha2hPcVZXQ2JzeENBM2p6YVU4STFFWnFT?=
 =?utf-8?B?SjZHRU9ZZFVQU3FnV3dITW1iSE81QzRGb2pqait0Wit5QlhJdExyUVYwQmlX?=
 =?utf-8?B?YUpUTWZQY2t1Z3BnYkhQQXFxSzFwanJ0VTRxVXY1QlAzVEFtME1kVFdrMjZZ?=
 =?utf-8?B?WUgxTGlKcVdFYyswcE9pTTB3b3dqRnF1dGRtUm82a3piaFg4dEoxRUpOUXZK?=
 =?utf-8?B?T2NlT0svY1NsRVFmS0Y3ZitpMnhpbmQ1MU9aTkl0cUlzb0hpam4veVFYR25B?=
 =?utf-8?B?VDBkMDVrb2hhWnNXQnU0V2g3L0FNcnhmb0lUZE44bmo1Q1pBZGRhTWord1gy?=
 =?utf-8?B?a3FvWFFweWcxNTIwekgvVWQ3UGJOZW01MWpScFRBb05SSnFPYjZQdFN5bGFE?=
 =?utf-8?B?enoyMzA5TE0vSGpHVDZncW1GeC8xTkRXTjNrQVVJbUw1UEIvcWJjWDNCbHc2?=
 =?utf-8?B?SzgxWnRyUDNnc05tSXRCelNsU3haNFpxUkFsb3l2RU8xcGhDRlR4VzdKOWlt?=
 =?utf-8?B?OWVGOHJ0eDR0UnhVNHhZSldLeFNDYURhNlgzTnNNcTJPWmxvTGRVQTlzSE5V?=
 =?utf-8?B?N1pkVFVqQ3JnMlJpQmkzaFdnYnBVQ21ZOXE5cmhqeVV6ZEdKK0R3Z1VXSnJw?=
 =?utf-8?B?MjRoTmk0N2pPWkJzSWdiTVRTUkVJYTdMakVEOHNxNFc3M0FENWVNRGZ4K0ZJ?=
 =?utf-8?B?Mm01M2tNTkxJb2F0SmxJMXQ5VTg4MmpGQnRjL3FUTjNIY20vVGh2WDVNbzFL?=
 =?utf-8?B?a0tqYWoyV2FIakpDRGxJcEZDdStSWEkzTU5ObVQrZjBseDBveW9XYTE2d0Za?=
 =?utf-8?B?bllpY003TTdiaVBFaDRhM0FtWktXWXovdkMzQnZuODMyT2JZdVJaRjNxTHBr?=
 =?utf-8?B?TkkyRjZ0eS9taTg4TWpCZG5XL2E1bmxTQ2hEc3pSUXcreXUvZWZ4ZmplRU5s?=
 =?utf-8?B?SFhBYmQ1VDdLTFA4RGpDNi92M2x3a0ptNDdRMmgxOVB1QjZ6d3ljNy91cVlD?=
 =?utf-8?B?U0lvV0JwMjJiS3RFRnMzRVVVYXdSRXdQWTM3enNyQ0lhbDNUUjJxUjBXMVJz?=
 =?utf-8?B?WklKVVp2dlVxWUVBTTVZTVdoL3VON1NReThCN0NSVUZTcGNFZmkvall6QUk2?=
 =?utf-8?B?dFRhbnNhcHhEMG9DY3RMdzFxRm9pQVdBalJqRURRWHdNNlVKWGhxVkZsMHcv?=
 =?utf-8?B?RitEY1FrNlcrRXRETXRlQTRFdkRPUjNVbTZTSFJrK0w0WDJHRjlGK3E5OU9P?=
 =?utf-8?B?MWJQbFhqemh2V0g2YmJDc21idGw2ek5xMFZmY090STcrNHIxaGJHY2Nlc09t?=
 =?utf-8?Q?JNH/95AG2RNR7Xxg8+hymKJdPl6kmBTKb2GeFFO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(376011)(7416011)(366013); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M00yZ2grY295Z2FFYjVUNy9mUS9zTVM1S0x2OEpUSElsWUpLSnVwNmNZRnN6?=
 =?utf-8?B?OWVtUVRpL251bHMzY05UNVlRVG5WNytFWlc3Y1F1UDBWdXgwa082WlJHODdy?=
 =?utf-8?B?VWFOZm9lV2ZEWE1ZR3d3cFBNVndDYjdIQWFGUVhGVHB3ZUwrb3owSk9KUEcv?=
 =?utf-8?B?N1hJaG4xdlViVmZ4ZXVyKzRWalo0VmwzeUx5S1JvSXEyQTlCVFEzSEhqNmIv?=
 =?utf-8?B?R3FCOUVQZEh4dXpwSnZZQlBzZ1FhWC9Na3lDdm5zazlOa3BZOHpNSUlkSEx6?=
 =?utf-8?B?N2RDQ2pZZ0dEcG5Rei9icThpRjd2YTBWZDZiNXBPWmd2L2FEMW5PNkw1alhl?=
 =?utf-8?B?NXBFWjRvWFFUL3lWSHI5bFR1TnFjYXRtL0xMaUZvWXRUOWFRS0l1Sm00M3Fx?=
 =?utf-8?B?dFZkMTJiRFpxWlZuTnhOWnYvOWx0SnlqNlc0eUZDK2ZaSVNyM2NuZXpUSzZm?=
 =?utf-8?B?VDJpNldabDR5ekJFNGhaL1diUXFIR0JUMzVIM3pKN0Jud1FYSVVwbDZwdCtL?=
 =?utf-8?B?LzZscGNGNENRTjZRcVAvamNJZDZScnpmOWdTTXVmVDMrS0dFdFpGZkxxYkE1?=
 =?utf-8?B?VVlZL2hJMjM2VWhCbWF1R1k4eTN1eElzRjBSYUtLQXFPNGtwblNVZmliZlNh?=
 =?utf-8?B?VlZ0eWE2L0hNSy9tNkNrSzV5WG5SeHVZUGlFbjRiRVk0c3JJZGZ3Mmx2WHBW?=
 =?utf-8?B?aXBUM2xWV2F2bm03THkrNkdxaU5JYkRmaVRpSlRpajc2S2p1ZzFBd1Bpc2p6?=
 =?utf-8?B?Nm5XVkpjalZmSyszOTF3Y3ZkS0lnUlA3dERCbnJZODZmZ2Fpd0xWM2ZPRGl5?=
 =?utf-8?B?emdua1N6YzBxY2syVld0elNHd2xBQ0t6QXVtWmtOMmJkZU1idFg3RHo0ZFBt?=
 =?utf-8?B?N2E5OEJFMWNwUHRVS2ZUU25TN29rN0puU3RqNGNyZTA1M21SZmVkTjltSVhE?=
 =?utf-8?B?VDJKd1NYbXBSMzc2VGNoUk94SmFpajllWjdHc1VYUjdWV2hSMVBIdTUzRmxS?=
 =?utf-8?B?OE05aFRhempLMGthU3FaZHJhY21qMjFsOXhSMDhwOFpoVzJoVFlFcFlqTTBy?=
 =?utf-8?B?Sno3Z2tOODJkVjZDVUdJWjA5OWpmYnBNaUIzNDN5NjBEcE5FK2RDZUlhd2No?=
 =?utf-8?B?RFdLZUtFZHd0eElhcTFJQUNkUUxDTzZYMVM3ajl3dEQ0eDM5eElOa0lyTEFN?=
 =?utf-8?B?T28zblRPZTU1clFnbWFvOHFqcTRwd3M5MUFRTGhRK0gzS2trYk5pcHc3RStP?=
 =?utf-8?B?Q3N2bm1lUzNWbUZib2RybGxKZFEzcEY0TFVDKytHNWMwdm4zbnNOcVpCMS9k?=
 =?utf-8?B?cHlMQjBiZkE4REZaYmFyUTlnbHRSRXROYjZzUU95RUJvNlYxYWdQRU15UEc1?=
 =?utf-8?B?WXc0WWR1VUxHVEw1bmN6MDFaSEI1OWg3RHZEdE9rcUVWVkRydFBxMGxLVnB5?=
 =?utf-8?B?NVA3akRldzlSY1JuTW9Cdnk4aFJELzZwaTZKRlNRNXk1bWFaaGJxNytnb2hE?=
 =?utf-8?B?TFZ3M2ZtSHhWQ0JNb3oreFRlMlBGd1dteEpENUVZRDIxcUZ2NnZYQjVTeU50?=
 =?utf-8?B?QlpwcGpoc2d6cms5MlQxaVYrS21Yb2hia09FZ09tc3RLMmxPdlViVlpBZC9W?=
 =?utf-8?B?dnVsV1dvbVFwcUpwSlJWeFJkbktQRDdzdDFteGU5aHFLbFZLMWRuV2N0aXNQ?=
 =?utf-8?B?YitMWUlwOEFwYlN1ZmFkanU1OXJTNG12V3A0cy9oQU9jaTY4R3JjRlh6cjBa?=
 =?utf-8?B?RjQ3VmpwdHQvazJUVDU4QkY1VTZmRFprbmdtckk5bUNzRE9maWtOYm9XRStG?=
 =?utf-8?B?MnN1cG4wTGpkTTJJNndRdG52NVhhUFN4Zm5lTDVzTE9NekNWMVRueEE3STRB?=
 =?utf-8?B?YkNWNUpZNzlodFg3eEpvR0RGUCtEV2MvN0ZQWThsZHNodXIzTWN3dzdsRGJR?=
 =?utf-8?B?Z1FuZDc5aG9ZbGpwS0hzaURlT09PTkl0N0Q4U1RCcnBqTkhnU2JXTXFkdXdL?=
 =?utf-8?B?TFdZZzdJb2w2UDZsSGlWSnNPRVA0ODVQMWNtOWZiWDliWjJVcHRBbSsyVWh6?=
 =?utf-8?B?eFlGOFBrRjN0ZURXVzZZSGp2eld4aXVrN2VsSHJramhlSmQvK1doZmdVaFAr?=
 =?utf-8?Q?JThT3td5TqdUhvdxNj9k8nZTY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 487ab318-fba5-4a12-0e44-08dc94e73375
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 07:19:50.5001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G36q1XoAIy3jMW0AGQx0noRHa2T6giDVuMiw5XtmMcP2DE4FNuaKU4kG4Ny57gEq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9857
X-Mailman-Approved-At: Tue, 25 Jun 2024 14:41:07 +0200
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

Hi Paul,

On 6/24/2024 8:09 PM, Fabio Estevam wrote:

> Hi Paul,
>
> On Fri, Jun 21, 2024 at 10:06 AM Paul Geurts
> <paul.geurts@prodrive-technologies.com>  wrote:
>
>> -struct imx_sec_config_fuse_t {
>> +struct imx_fuse_t {
> Please make the struct renaming a separate patch.
>
> Peng Fan, Ye Li,
>
> Could you please help review this patch?
>
> Thanks

Can you take a look iMX8MP FIELD_RETURN fuse, I think it does not have 1 
bit but 8 bits which requires to burn a sequence. Only when the bits 
sequence is matched, the field return can work.  So checking the bit 0 
is not enough.

Fuses for other platforms look ok.


Best regards,

Ye Li




