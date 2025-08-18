Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E9ACA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 08:09:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B2358319C;
	Mon, 18 Aug 2025 10:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="qDu5MnvX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D9F1831D5; Mon, 18 Aug 2025 10:09:55 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A217830F6
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 10:09:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pS3I53MhUbREZcKh1kNtTRlnXDCn4pmRn5HUFoSObpBRkviRhUSGf6BeuaCZGa0rFkVBfDwovvJPXAIlmEx+sCrQwFDAwITHnoRITZ2DfC+q2G6eQsa6LTSKfBTEAWb1mTAJfPuv9M+1NBRVAkT7b3Cz8COR0wCFnZp/gQ++WKqKfEJjoTdo0SaiLJKHC3KW00dZzsO5IJOWIbg3ZesDHL9GlLIc3508lI9tjrUb4oeAAcb0oqt/Kgy0wY0CCpl1ZdPAOTqCl5a27gwWUHgT1ihffhVN3oX/IcmbcD3z7+4N+zvFTWRERdgg3y6eHdqUJHtwGsRYBWjRpUnWBeaq3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d22TAG1dEJqsADSU9xVPacE/Ov1MFEPpfT4/ViONtAY=;
 b=XkJ8nE7I6iem6wWbSSEtZfQ4y3VTQ05PjntGpvOTuQcUGQ6T+2JlCL6yRj2vc2b4cPoBu9tc7SXzVP5Fodm4m7GG+1dm42c7Mv4Q0euhhihtp4zvqgrWblp53hq5DhPwlqOQrGQDJqF/Tzgn3O1LAtiqQZYkqS9bnWczuTaXGWaVriAQL8RuJ7V8OdzVsJ9/8peK4CEQJWZ/2u0VfKFACaTLokjdqYAJczUmUuOs4ZqrZ96L+pqe/EwyHO3eI2BaNJvhqceTLY1rbX3JssGKQU0OVOByd7lYRne3DcGNlH/zYYXfc4Cv9XZHW/R7clKgVgqiatYHGPLHd84OXFmdDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d22TAG1dEJqsADSU9xVPacE/Ov1MFEPpfT4/ViONtAY=;
 b=qDu5MnvXYOssOUJcOU4DLM0m7dIxHAF+Z1rM6HMrt7WAorOhBrwyk8ghr25f/wx4mA5igpflDEM1UwBaapJ1JNoHXsgH+zlHSv2CLGXHho9DSWC/dHDurmmHpAzQYeivkbCr0Qv9mysB/EUxoslYjBBa0jaWRSc/K27pAvbxJTaesrxjhIwIyJdnIZpU68lAolu03V1mlut+pH7yq2NZoTu7ietUJ14JnvbRLYWcGFHFa7HU4LVhoqvZ3RPiqD55HXIVxU0FA7fU/+j9oRglq3RTIgBKOe5QJZFtjOFn8srscSFBezo/MvXVDaNEg6ustvOUY0FCJwstKcbhhZ73nQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AM9PR10MB4118.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ff::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 08:09:51 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Mon, 18 Aug 2025
 08:09:51 +0000
Message-ID: <27dc889f-cb81-45e3-99a1-948ed23979c4@kontron.de>
Date: Mon, 18 Aug 2025 10:09:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/21] mtd: spinand: Use the spi-mem dirmap API
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
References: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
 <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250813234314.3945708-3-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250813234314.3945708-3-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0367.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::11) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AM9PR10MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c4046a3-f944-44d9-ab1e-08ddde2e9ae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dms4dHBibFkwdmYzaWpuaWZvKzZjYXBiQys1TllLbXlibUVvdGt3UFM2L2E4?=
 =?utf-8?B?cER1SGZUM05yVEcwYVM3MU5KTWpXTm80TExwWlNuYko3NFgxMEtJaTdiVWpx?=
 =?utf-8?B?ekRQcmMzRUpPSWMydU0ycVdtcDh6NStsZFM5YVZ3WTJCSktwaFlJYTNxNmhZ?=
 =?utf-8?B?Um1qN3RJSDlIOGdTVStnaWE3dWtrTWlrRXlodkUrNnc5cER2SEdQeDU2RmN0?=
 =?utf-8?B?WXQxZFQvdm8yU0padVNaNmtpRElmUHYvYTFUcmxJd2hiMEFrWjJZeGZ5eVlR?=
 =?utf-8?B?dmMwWmRTNGxqQlE0NVlyd001dG55dlAxc3F5dEY2NzR4R3FxeE5BN1B3YTdo?=
 =?utf-8?B?SWVQcDBNME9HTjdTRkhsMHlpVUIyM0MwdXFVREtRWlFyUVhFd1NoUTNTRWN0?=
 =?utf-8?B?NzV4dWY0emphb3VnM1krRWFiTkt4WU54NWx6WWwvNlhNUUZZRWN5Z2pUSUFp?=
 =?utf-8?B?cVRuK1ViMkRseGYxa0lNTkwxajlzVU04WUQyMnR2Sks3akhUak0wQWh1cFA2?=
 =?utf-8?B?U0RYbFdRb1lpK0xJRHVuOHo4SnRPbmRWV29BTWZMU3ZOZ3pjR0dlek9PWFMx?=
 =?utf-8?B?MFd1dDRtYVJ3RTQzWEk0QlNlZnhsRWlycWc1L2ROa0RzYWNzc3hQTjcxamVn?=
 =?utf-8?B?NSt1YlU5RDMvUnp2R2FFb1V4cmROb1hHOEM4ZTlzaWhJdkM5TDRMdjVoRVFJ?=
 =?utf-8?B?Rkt5Q25iRTRGbGpDREJVTVhxaEZudHlrK1NJbUhSci9BdUhITGZSTFVzRXJt?=
 =?utf-8?B?YVNYTDZpaHI4Z0h0Y1FOUHI0cC9hMjB3QUxSNXluV3FDVGlWQWs2SWNPcmFF?=
 =?utf-8?B?d2xjdDlnVlB0Z0xMQ1Arb1BiZFQ2c3cyZFhNMmJaUXhVY2lHY2U2UjVpbTMw?=
 =?utf-8?B?Rjg2UXhZQ2RCa0J5Ukd5eXNSRzBDWFNmOG80WFlubjVXSjhwaVZ5c0JDTC9U?=
 =?utf-8?B?eS9nZy9kc3g1L1N3Z2cwNXpLV1pETFVSbXVFZExNR2piYm5RQXEzNFMzN0Ft?=
 =?utf-8?B?TkVpMThNNkVxd2ZDSzFxaWt4d2pBMFByYXpsS3dYT1Y0STBQQTQvcGdRaXZX?=
 =?utf-8?B?eGFvc2U4Uk5qQWtnMTR4UlhsV2d1bittWlQrTWpIZHlvUFk4L0pVYkErcEVO?=
 =?utf-8?B?S0VwT0FJS1VOakJRdGNPUU54TWJiaGxEUTdTcmdCUzdNMTNXaEJwbzNvMkFz?=
 =?utf-8?B?L051dHhzSXl4R2pOdFZHYzNudU9GT0FkVWdZSFlUUFpvM0VVOTgzL0VCenNX?=
 =?utf-8?B?M1pDY1lhK0xmb1gvaDg0c0kwajVleVBvNzVCWGV2Z0lFWlJHc3FoeG9vMjFC?=
 =?utf-8?B?WW1BN3dsbUlEYmlQUmdyRlV6NHpDVVpnU0dTckFOZTgvWUxQb1NMQXpVSVFQ?=
 =?utf-8?B?NndkVCtlZHp4MnBXelpvalNXSkNoZVFVUUM2NXMwTEovQ0NHcldIbklEblFD?=
 =?utf-8?B?TmI1UlJWR3J0d2lRSjRXKzJHSVkrRHRZMVRCNUptcUlPMDRqME9CMHRHWjJJ?=
 =?utf-8?B?S0Y2VHFtKytxYm1vMW9KczMzRFIxZFVvVlE3TEdBb3RYUG93NXBtVXBRWWFL?=
 =?utf-8?B?dkYyT283dW01Sk1BdzhQTW1hTzRGREpIQXRETkJFc2VBbC81Y2JrRVlkcE9R?=
 =?utf-8?B?MUx2RVlHN3pjblE0MktUZ3BEU0lqZjhFc2RhTXhLWXhGUXZQcldSWjJ6WjU0?=
 =?utf-8?B?ZUtZWGVFZkh1UDBRNEQzUDBGMkdNdjBDaTRGZ2lFTWl3d1JQQ1p3UUF3WGxq?=
 =?utf-8?B?SkhraXZhVVhtL1p5RTZMME9wUlZJWXZ1bkhBZGEwOUM4b0Ezd09zMWQwM1Vk?=
 =?utf-8?B?QWxia3BMRlNTTDc0VFhOZ2J3TWl4blRjbVh1L2FrWFF1K2ZmcElvUzNhK2Uz?=
 =?utf-8?B?TzltTVNBWUNSZkZoQlFLT1BUbW9NUS9KVjJLYnV4V0JEU0NCYXJRRWM3U2Zt?=
 =?utf-8?B?UVVDZ1AyVmgrZGwvL3I3a0tNOUtwSFg3NDNWRTlpNUZtRXVZVVRZMmV3UGJv?=
 =?utf-8?B?TTgrdE10d0xRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(921020)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0kwMGpzanJid3RURjRscEZoeGlJOE9SZnJuSnBRU2t0YVRua01XaG90aDd6?=
 =?utf-8?B?UTZQSEg2c3hiZExTcTZPaklnQzdML2dpc21xdXBEOWJMdDlLU2s4cXhrQ1pO?=
 =?utf-8?B?Qm9lTjd0aGFKVUdpMDgreFhOT3ljUUhsV0pRWVhPcFFVZU9EWU1xRElrYms0?=
 =?utf-8?B?TUVJVDYyK2FScnR0K1FibHVaaGY1d0RZOTl4cUpvanVlcTM1Y1RSMWkzRnpm?=
 =?utf-8?B?bUw2di83QWhCT1N5WTZhY0YrMkdMemxDYWZFVHpQanliRTUwMWo1bXZ6UjQ5?=
 =?utf-8?B?OTRxQkdjREMydTRhSFlodm81UzZIVVhGdWdpRlFlbThEM2puQ0FON0F4YUxD?=
 =?utf-8?B?bXkwZFFSTXhBSjhmcDhsRUViUXhJVE41QW1sQ3MxcWZ0akxISisyZ2h2WGVM?=
 =?utf-8?B?Y2xnQmdVMVBmS0NzdTl1dXZhd3pveXdJRWdkaGcwemluc3RUQ2hZNVZrYmpJ?=
 =?utf-8?B?V0xPRHU4UlBiZXZJM1RqWGh1NEdxYjg2QmZ2U0tQRy9OOTFWK0R3UjBqa0Zz?=
 =?utf-8?B?M1NXbm1nd04yUGVpTGxxSjdocHllT2lRTHo0K09VTlNZWElpNnpZNnRoVjRF?=
 =?utf-8?B?YktxNDAzUjNzYko0YmdwRENobHI4NmYwZHBadTlEVnhoSEszcGpNT3k2NlRV?=
 =?utf-8?B?RU1QM3VBd3ZwM2hlRUlhRTVxNXVKdGNxdlg3R01WTnR3UVhxbmNRWXNNNmhE?=
 =?utf-8?B?VEx3c2hEMVFaTFNNTDFUR0E5MkRSdEFZRkJjWmpkanN5MUV3MWs0bzd4RUhY?=
 =?utf-8?B?bElFeHJnampLYys4dTRubzFvRFgrSmE1SkVLTGg3Q09qRnM0WDIwL2pGYWdB?=
 =?utf-8?B?WXY1b0FTU1NHeDBKWUQ3ek1xRUs1Z2ljdjkxb2tZYjI0UEJ6YU9GZlFGRTdT?=
 =?utf-8?B?OGFpdEtycEw3ajFqdnVnM0FjeU45R2EwMGZ6eE9lNFV5TEFJTlB2OVJWcHl1?=
 =?utf-8?B?V3ZMdmJTWUM0VWtWNzBSZlZtb1NlTUt5NUtGOW8vUjRkUm5aRG5OdzN4dk8v?=
 =?utf-8?B?Yk1CRGZTTFJXcXRhWGRCeEkyTW8vZWdYN24vTmFHWlJOL3hxNms4RTU5Z25V?=
 =?utf-8?B?d25CZmhPWm5ReGF2MlFnUjNSZ0FINGJxc1JwTk5BMlMvcnViN0hBZVFqRVdx?=
 =?utf-8?B?OHM2bk8wajNiU25ZZHNoVWZPOG8yRVUxWENaRVFZbHVoczZydHRIZ0d0VGNl?=
 =?utf-8?B?eU5KR1ZBMGNyUVQrYzlOM3JqSHp2VDllK3lqOEx5L2dTdE9PSndZK29XWnFn?=
 =?utf-8?B?WmRvd3dNNlNaQ3JITlpCR2o3OHVrVmMrTGZLSzlVMUxCdmlkK1ZEQUpvbGdL?=
 =?utf-8?B?NDdnTlBubVFpMFk5Z2FUaktHcXNCQmhHUWZvbnRXaGhra2N1YlpKTnFNV1du?=
 =?utf-8?B?aTZyV1FsQ3VxQys1KzQ2NFpNYTV6cGRtbWxvU24vUWppZ3lrTU9ra3N5aGR0?=
 =?utf-8?B?MlhlRmVQTXBmMmpFUmJPSmpyeDdGTFBHbjB2bTI5QnpzWElDTFFNOUZMMldi?=
 =?utf-8?B?MklDS21EU0hsUnJ4VDVJS0xWYlduRUZ6Nm80T0V4ZERhbGtzVm4xUS9uS0xh?=
 =?utf-8?B?U3FOWkxGamMvZm9IcndHY2pCcCs4K1VBSE1udThFblRDcUZyamhFcGxZeFEw?=
 =?utf-8?B?R2haRmJNS2hvSXE2ZEczcmU3OVJWWHErRlNldkVTZU5TbU03U253NnJ1VCtD?=
 =?utf-8?B?UFpoaXhrV3RGaEx5OEJNV2hVNVk3ZDk0UjlCNURJSFk1RG10dXVEQmw4SUpI?=
 =?utf-8?B?cGZjMXdOdDl5SkoxbTZsVEVFaDMwYlNQekVaV1RhV0JjT2JPQUttZHdEK1d6?=
 =?utf-8?B?c2pBdmhiMHMvL0tjeHhMOWdvNVJkK01LSUFkcXlxWlVKWTFTTmZkaDZZK0pX?=
 =?utf-8?B?T2FVa1ZEYkpCSFExdHo4UkJkckNWaUdndTV5bkdjQ1c1RnJmTW1OOHhQeWZE?=
 =?utf-8?B?WThha0JuMHRQZVFtdENmLzdKQ1BiRi9UR0o4Zm9TeWhTWFJiVXliL2dGRG84?=
 =?utf-8?B?bE8yd3dyazY5WUNheThLKzVycGZxbGJDWGxSSW1TQ1c1czVtREZJTE1oSTI1?=
 =?utf-8?B?dENPYW5jNTdlQnQ4NCs0RmtwSXBDZE9ZNzVEaHZWNUVITzBqbEUvcW5JUmVP?=
 =?utf-8?B?Nk8vNFFmUTRGckxKNERoM2RUWGc4ZXBINUpWQ2lwQlJVRlZjRE55NjFGQVJn?=
 =?utf-8?B?akE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4046a3-f944-44d9-ab1e-08ddde2e9ae9
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 08:09:50.9514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5Og3s/AqfD7s41q5CTwshCLYmGIkOVALJ+9V4kdsZeCJGr59yOpAAIISpXUv4bw0DYfP3i5WYJJ9Xi5l3vVW+AU6skXq0laODdnrpy6sUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4118
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

Am 14.08.25 um 01:42 schrieb Mikhail Kshevetskiy:
> Make use of the spi-mem direct mapping API to let advanced controllers
> optimize read/write operations when they support direct mapping.
> 
> Based on a linux commit 981d1aa0697c ("mtd: spinand: Use the spi-mem dirmap API")
> created by Boris Brezillon <bbrezillon@kernel.org> with additional
> fixes taken from Linux 6.10.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
