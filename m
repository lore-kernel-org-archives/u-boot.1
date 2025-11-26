Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE04ED10F23
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 11:44:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C6ED83DEC;
	Wed, 26 Nov 2025 12:44:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="leRTcD2a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BC9F83E4C; Wed, 26 Nov 2025 12:44:36 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5EC2833C6
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 12:44:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iglH+7/+LXc4kS0T9F3UajDJ7D1kJMuP/ehyVIkVirAIDN8y51jLPt/ERbpuayu0jeBvqdwv+eOpH8GD3uM0c1364UuD671eiDrG+IFh5hdmrabd1CO75hjHChEm2UOvcEiWXiY1cwqtxYk8G1y54tghpIedNKXh+lFSH8Va0WwqrheTbxKyFGQeQnIYHtTurpWCJRFcS5/h4ZOpKCzfO3OGImNGttup+xZng0sakdA3PA5jlVbAU+RAek6r6U1a0A76Qdc4R+D80HQTRsS4WymnpFmOlHjVVk6pnZm3KVvYgMUgW44UpE59A0qZxaVgdgAXt33vyK8H5xltecVsRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXdTufwtbnaOw+HHBvgZNWnUuOcmdc9vV39bdGd5A5A=;
 b=nEVzomydPp5mCrxQr0HFyA6ug0vpCKOdcuVbxBUc72R2gDL9RvhYcDwuYF7wA8wSU/YsuDErv3HnjU7OHwrQ/vCEMywkgXuym6G76pPIjlW6GqcB6a0pZhhEJy5KYybA5YjE/6pqPi04aASYuVpuYHmfCBXSJIzyn1llVmb3ZYku/4usY6FhQlooINAuzdELW12pKfjxj4w7Pgq9/J/aW3y5FZF5THjeZMGHEW66nJMWFX6JMTKiRasgZt9eanzqJ0StSNxSIM9P/7IKilc5rSUZ/IISVw5bqAmv1RksjGqXLjugS7em6fsFGoUQ9TDz5zTa+dZS2jLPoHMGKGFhnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXdTufwtbnaOw+HHBvgZNWnUuOcmdc9vV39bdGd5A5A=;
 b=leRTcD2a2bk2Zls2oqBVNQfEZdYUHf6Uy1iRaMB7/oUbvczL6aWcbmvSk2sF7xAIC4B0FpUHIcnOEFTlGskf0CjkJSG8Fw+rdynYyHMbe9g9nlciqJfVFwAwUBc0QX/xMAy3w0snRDfUoW6Si2B+MgBbBByiQKB31vbL3h/auKc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DB9PR04MB9401.eurprd04.prod.outlook.com (2603:10a6:10:36b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 11:44:29 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 11:44:29 +0000
Message-ID: <6b2751af-783b-40d4-b205-5859b7eaa0d2@cherry.de>
Date: Wed, 26 Nov 2025 12:44:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] tools: binman: fit: add tests for signing with an
 OpenSSL engine
To: Simon Glass <sjg@chromium.org>, Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Aristo Chen <jj251510319013@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>,
 Anton Moryakov <ant.v.moryakov@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Bryan Brattlof <bb@ti.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 Peter Robinson <pbrobinson@gmail.com>, Eddie Kovsky <ekovsky@redhat.com>,
 Kever Yang <kever.yang@rock-chips.com>, Yannic Moog <y.moog@phytec.de>
References: <20251121-binman-engine-v3-0-b80180aaa783@cherry.de>
 <20251121-binman-engine-v3-4-b80180aaa783@cherry.de>
 <CAFLszThxhLBEm731QjvB-wbOGryGBfh1_09NeWNy13nLwqZW4A@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszThxhLBEm731QjvB-wbOGryGBfh1_09NeWNy13nLwqZW4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0235.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8c::10) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DB9PR04MB9401:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d45362e-ed31-42ee-19e1-08de2ce12852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MzJpUURZQjRwYWhQdHhKVjM3MXVjVVEwTFZUbkRkSGpma2M5eGJkb094K0ph?=
 =?utf-8?B?VndSQ3hOWDZpY0RKNE0vNHJHaFE2TzhpanB2Vm9JNG41Z05IVFJSZ2pCVTNl?=
 =?utf-8?B?Z2tjTUtmRUZ3cnNqWkNjREQ5WXlSRkU0Zjl5T1Fqc0dYY29aczZlUzFrUm9Q?=
 =?utf-8?B?UWJLb3ZUM3hhbVBjRlVXS08vR1BSaGlsV05Qekl6cHVZQlptU042ZG1YNmFI?=
 =?utf-8?B?ZkR5aFA0SmlWazRyQlptMGNubmw0bTVxYTlvYThpZkpVQTJBazFxSzUwaGxl?=
 =?utf-8?B?YTlMUzQvWTV2NVBlV1dEOCt5U0FRbjBOSHlJZjI0Qkk1TXJOYU5JSlQ3YTBm?=
 =?utf-8?B?ZVo2c3lVMDBhUWhvdy9lcFRqRXd2cUlPRDhuQlV2TEcwYUxkVjZzZWpzZXVP?=
 =?utf-8?B?eWJxZWRCQjZkNzQrdUEvZGI0WFBYOVlsbzVpODJhK1QyTlNiQm82MDVMRGF4?=
 =?utf-8?B?Y0hHQzdlV25FNzJSRFlMM2hEdDk1d2owcWRUZENUblB6QVhEdkNxZmhkZXN1?=
 =?utf-8?B?ZkVITkdxY2VHc1REVk81cTJ1N04wc1JVd1p3R0MwbWtEU2gxbzBXZXY5cTJ0?=
 =?utf-8?B?blJQSG5RWE4rSERhV0RkYTVnQjdtT3hoYnV3cXBPSXd0SmxIbGxUNWhZb2x6?=
 =?utf-8?B?bnBzbzJXZFZ2bEFodUh1Sm5STE5uOFBoNHdPMllyR2N4UDlSRHhRVXJyaGEy?=
 =?utf-8?B?Zml2dWZRRjZDL05iOW4zWkZEN3Z4dzZ3WWVpVFNacGZobmhhZjY0VUdDYmRr?=
 =?utf-8?B?Vnl0WndYQ0laQ3Zoa1R6Q2FlQUxobExnc3NQczJkc0NEWDlyWWR1bGR4ZDcy?=
 =?utf-8?B?SnVFVENJM3ZWZlZmZTkzRStPdmJDTzMwVCszOXViVkNKaDdVY05iNVcwcUhK?=
 =?utf-8?B?dzRqUFpCaGVmSllOdmdoZnlCTkhRRFpQRUtVVkNaWjhYUXpRZ3NPeGh5V0gr?=
 =?utf-8?B?RE13WjQzZ2VlUnp2RUU5eVVUSHZnSml1RTRPdDZsWVFuOHB5WnFXeTFzeFdH?=
 =?utf-8?B?QS9ONC9yRnVxOVNESjFXNUl2THAybUVPNTcrNTIvaWlUYVRwL05peHNLTGpl?=
 =?utf-8?B?Wjk0WWNRMEh0YXpJSnU1SmFUS2lKY3p3djJQSjljU1pBVm1qUis1Z3Fuem82?=
 =?utf-8?B?cm1idEZmaEIzUEVrNkdNbmJWbVBQdXRDRFhZTS96WVFVRjNiZ1FGR1g5STdN?=
 =?utf-8?B?bEIwK2lXRFhJbys5aDNvNGE5NVE0R1VyTEp6MXVBT0gwaStZczgyWUFxUXhs?=
 =?utf-8?B?TFhxWk9MSFJhb2ErUVMvT2FKajZ2V2NvaUM4UDhyR1NCS29VK1g2MUNiSUsw?=
 =?utf-8?B?SGF4VWhZMzFxMVd1bWpYamt6N0FMRDA2ZERBYnFvUkd0ZWE3djRmUnAwaGYr?=
 =?utf-8?B?ZEs0SVpEVENUTlRDZXp4dXN5dGNqanBGMk8zNVZrNHdTZUNJRGJNVGNEMG1R?=
 =?utf-8?B?RjVBM3huanpna0EvYllUL0JwUE91ckVJalpIQ3F6clM4bE5TMXVsODJ2ZjIz?=
 =?utf-8?B?UnNLdWNOVVJYQ2xNY05abzZ0OE10QmZ0ZDNpdkZ2TDhkaUxXZUN1S2M5VUp1?=
 =?utf-8?B?K1NiQVBocUNlWWlhbmtZV2g3YklvMDhMeUZwNWp1aG96ZkNNS1pkcEVaaURV?=
 =?utf-8?B?T1pVbjFVdjA2SjdGY25NTWRTOGtoa1ViWEhycHN4Rnhia3lsTmJXWnNxR2Jx?=
 =?utf-8?B?QU9FWWtNWFM1eG9VcjJTNDhiVkRVQ3JLZlFHTnVsS3U2U0VabzVDa1ljM3N4?=
 =?utf-8?B?S3kvY2IyUFVIYThCUUk2RGo4NkdnelpqMjlDUGc2YW4vckxpZlVqblZzTHV2?=
 =?utf-8?B?NzhFdjFRZk9xaGpiZm45eUEzVzU1cXRCWWpoNXFrb1ZzdWJ6cnR3TVMyQkpW?=
 =?utf-8?B?YUtJbW1pRnJtOXdzM1QwSjM4N0c1YTU1M0hnYzd3VWhpT2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0JrNXpCeWRjL2FwamxZc2RxUDROYi9IS2RJMVNUTTFsandvaTFNa3RVRVZw?=
 =?utf-8?B?R2g2NDQ1UEk0NVJTakxHQXQ5WC9KTEFKem9wMU0yZFFrakxyY0JiYWQ0aU80?=
 =?utf-8?B?bmFJYkRtVTdscnY3VTVSaDNJZHM4SU5tc2VqZVVYUkpaMmRmK2pJR2FUODBt?=
 =?utf-8?B?L0dDVVVnRWtFV3M1eUhObE9RNGE1V0kvbTZhT0E4TUt3K2tkTkc0am44VWQv?=
 =?utf-8?B?ditBT1M2TU9WNGxrVEdGVFFQY0h1UEhZVXN5VXR2N2NqM3diTDJtZW5lOGhy?=
 =?utf-8?B?QmxIcmdLVDJaUHdTU2xkU3ZXS0JvN1JocUdnOFF5RVY3SVJQN0JERTFPR1d1?=
 =?utf-8?B?enc5Z1JkRlVmUHA5TDg3bWJLOWo3ZTFhQlJsd2YzaDJuMExzRVFkK1hhQ2J0?=
 =?utf-8?B?VkNGaFc2WGxsZ2c1ckFBNFp4RVlBc2NnNnQ3THQzOTJaZkc1MHhpYStPRk1D?=
 =?utf-8?B?eFVvVmFuVVE0SmFKQ1I2czFtbmorb3ZQeUVsaCtRbTVuVllmOVBmbE5ieDNi?=
 =?utf-8?B?dm83VFJ6b1JuMHNnaktZUERRY3kyUXNhaUNqS1pSUkhMQ2xoanlLZkxRVWM3?=
 =?utf-8?B?WkFXcjNLTUtHWHV6bUlwTGFyVjVYYmxOOWpVV1UrYlczaFBmL09yUG5kbWpp?=
 =?utf-8?B?ZjdVUklUMTBIcTJ5aDNWU0t2YmRUV1QwMTRXZHY3S1NnWk0rcElpT2U5eHFG?=
 =?utf-8?B?RHVYLzVXaHFKZUJSSExYVTBwTU5JZ09uR3ZsOUZ1Y1hOTlJnbHpBNnIvRXF6?=
 =?utf-8?B?VVN6RzR6MHdlZ0lxRnhRYmdzcU1NcytmdFZCQzBzbHhwRGRJYUQxTlVjS0FM?=
 =?utf-8?B?UFNPeU0renlzNG90RmxlTFpwZW1wQnlTR1pJWXJkZXB3czBIUXFZL1hRTUM0?=
 =?utf-8?B?MEMyM25XdUlUT3M0YS9jV0kyQU11QlFORmxyU0dEZ0QwVkJFY1VHNW1sYTlN?=
 =?utf-8?B?ZmFGOXk3TFA0MGlTUitCbzU1MzcxSGlyQkd6NndnWjBXTmdCNEp4TlBxM09I?=
 =?utf-8?B?L296a0FvcktKczhHM0xvTzFSVmtJcVdaS1FCU2sxOTM3Q3BHTmYxcHF4MWNJ?=
 =?utf-8?B?cDVUeDRydFBMNVBYTEwyQlRaQ1I3MG1SMGJSVnIyR1pXREUxTXQxWDVYOG12?=
 =?utf-8?B?QUlabVNBaFhxMHQvN282S0c3RG52TzFnZ3B2b0JtSklvMkt2Sm5QNnMreHBS?=
 =?utf-8?B?OUFRenI4SWMxbW9CeHVLenVEOXIxbFdkZnVIdWVxcWQwMmI0SHRKK3ViOWRn?=
 =?utf-8?B?S2hjM3hpOVJBYkpTcDl2VklCUjI4bnBLNlIwRHl2aktFMzdNVlc5ZXA4R2RK?=
 =?utf-8?B?UmNXa21DbmdWbzBNN0tmcDJuaFR3c0ppYmNGQTI4UC9aaTBUakFNcEFuZjJJ?=
 =?utf-8?B?U0Zac3B1VWJVSFJhMHVhTStLUG9CUnBGTE5sSnJqbmpuRm5PQkZZKzN0VVJF?=
 =?utf-8?B?NlVVM094OGg4blJlK0p4cnF4TUJCRjRoZGg1YjNlNUZaZXh3blg2Z3FBZmg5?=
 =?utf-8?B?ekduSWtoVHdCQTQ4TFk0dUgvaXZ4cjNPSkFjQk9sdjVrZTZjQWx6VXdvbjVR?=
 =?utf-8?B?a1A4SEprdytRa0V5MURXV2pZY25iRmlpbUUrMnFOclBhOFVhVEJFRzRJNXlv?=
 =?utf-8?B?MW1oSTNSTDhmZmhHZlJUbkcxS3E3dEo1bDd0UVErR0hqYStzeGM4WURtWW5E?=
 =?utf-8?B?RlJBd3JyelRkVlc2MXpxcVc5cEZLOXppQlQ0a1RtUitlQUxQQ2JEYzlNclY2?=
 =?utf-8?B?WEtWeElKSXlLYWcyZCtpY0JSWDY3SjJKNHBwYVpNbzRQNnhMZ3Fsekd0WEtV?=
 =?utf-8?B?OE9qeXlDaE42VG1lQldBeWQ2TjErMlBoWEpNWU1Rc1VCS1FzRGhqRlpqS2sz?=
 =?utf-8?B?My9hRWpXWW14ekQwLzhXcHlkU0Q2d00yWEdocWY3VFZDVzdjalJlL1pjV21L?=
 =?utf-8?B?ZkNxMGZIM25PSTF3Y3U3Kzg0OTJ5ejJwaTFlell2Y1JDUWt2T2NOdW9oWHpN?=
 =?utf-8?B?YlBubnQrczZYYjMwUERlbXcvNWpORWtZd0V3V3E1WEowWkdwazFYaEduc0hr?=
 =?utf-8?B?c0k2UWxucUZNT2gxTE1zcmtFY0cwTERvYkFzQXRITzNRY2xNODIvWUVtc00w?=
 =?utf-8?B?dW5ERnhLbGFYMzhYMXl6dnNCMjQvdWMyMzFBSS8wZUIxY2YzdnRXeVdYWWFK?=
 =?utf-8?B?d3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d45362e-ed31-42ee-19e1-08de2ce12852
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 11:44:28.9828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +c5br/MVjg+7VuxlGXdkgI1HRG4dC1j7/IZ8/rjAwidX2wrM06AtuclTqp8vxI2zEocj39kYK9IjlElOaGK8fwr1q/uCa32fUFAs4+k7n8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9401
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

Hi Simon,

On 11/25/25 11:15 PM, Simon Glass wrote:
> Hi Quentin,
> 
> On Fri, 21 Nov 2025 at 10:15, Quentin Schulz <foss+uboot@0leil.net> wrote:
>>
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> This adds a test that signs a FIT and verifies the signature with
>> fit_check_sign.
>>
>> OpenSSL engines are typically for signing with external HW so it's not
>> that straight-forward to simulate.
>>
>> For a simple RSA OpenSSL engine, a dummy engine with a hardcoded RSA
>> 4096 private key is made available. It can be selected by setting the
>> OpenSSL engine argument to dummy-rsa-engine. This can only be done if
>> the engine is detected by OpenSSL, which works by setting the
>> OPENSSL_ENGINES environment variable. I have no clue if dummy-rsa-engine
>> is properly implementing what is expected from an RSA engine, but it
>> seems to be enough for testing.
>>
>> For a simple PKCS11 engine, SoftHSMv2 is used, which allows to do PKCS11
>> without specific hardware. The keypairs and tokens are generated on the
>> fly. The "prod" token is generated with a different PIN (1234 instead of
>> 1111) to also test MKIMAGE_SIGN_PIN env variable while we're at it.
>>
>> Binman will not mess with the local SoftHSMv2 setup as it will only use
>> tokens from a per-test temporary directory enforced via the temporary
>> configuration file set via SOFTHSM2_CONF env variable in the tests. The
>> files created in the input dir should NOT be named the same as it is
>> shared between all tests in the same process (which is all tests when
>> running binman with -P 1 or with -T).
>>
>> Once signed, it's checked with fit_check_sign with the associated
>> certificate.
>>
>> Finally, a new softhsm2_util bintool is added so that we can initialize
>> the token and import keypairs. On Debian, the package also brings
>> libsofthsm2 which is required for OpenSSL to interact with SoftHSMv2. It
>> is not the only package required though, as it also needs p11-kit and
>> libengine-pkcs11-openssl (the latter bringing the former). We can detect
>> if it's properly installed by running openssl engine dynamic -c pkcs11.
>> If that fails, we simply skip the test.
>> The package is installed in the CI container by default.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>>   tools/binman/btool/softhsm2_util.py                |  21 ++
>>   tools/binman/ftest.py                              | 223 +++++++++++++++++++++
>>   tools/binman/test/340_dummy-rsa4096.crt            |  31 +++
>>   tools/binman/test/340_fit_signature_engine.dts     |  99 +++++++++
>>   .../test/340_fit_signature_engine_encrypt.dts      | 100 +++++++++
>>   .../test/340_fit_signature_engine_pkcs11.dts       |  99 +++++++++
>>   .../340_fit_signature_engine_pkcs11_object.dts     | 100 +++++++++
>>   tools/binman/test/340_openssl.conf                 |  10 +
>>   tools/binman/test/340_softhsm2.conf                |  16 ++
>>   tools/binman/test/Makefile                         |   6 +-
>>   tools/binman/test/dummy-rsa-engine.c               | 149 ++++++++++++++
>>   11 files changed, 853 insertions(+), 1 deletion(-)
> 
> Not sure of the changes from last time, but I assume the test coverage
> is finished.
> 

They are listed in the cover letter in the Changes section.

$ b4 diff -v 2 3 -- 
https://lore.kernel.org/u-boot/20251121-binman-engine-v3-0-b80180aaa783@cherry.de/T/\#t

will show you the git-range-diff between both versions for a given commit.

Yes, both the tests (parallel by default) and test coverage (single 
thread/process) pass now. You can verify this for yourself by fetching 
the code with

$ b4 shazam 
https://lore.kernel.org/u-boot/20251121-binman-engine-v3-0-b80180aaa783@cherry.de/T/\#t

and follow the instructions from the .gitlab-ci.yml file in the job 
named "Run binman, buildman, dtoc, Kconfig and patman testsuites" up 
till "./tools/binman/binman ${TOOLPATH} test -T" from within the CI 
container. e.g.

podman run -it --rm --userns=keep-id -w $PWD -v $PWD:$PWD --pull always 
docker.io/trini/u-boot-gitlab-ci-runner:noble-20251001-14Nov2025

> Not important, but I think instead of:
> 
> +            self.assertIsNotNone(signature)
> 
> we typically do: self.assertTrue(signature)
> 
> and for:
> 
> +            self.assertIsNotNone(signature.props.get('value'))
> 
> self.assertIn('value', signature.props)
> 

Both copied from testFitSignSimple() which uses self.assertIsNotNone(). 
I like having the "shared" code implemented the same way so that if 
there's an issue in one test we can hopefully easily spot the same error 
in others and fix them in one go. It's also seldom used on nodes in 
tools/binman/ftest.py, 3 out of the 29 times it appears in the file. 
self.assertIsNotNone() is used on nodes 17 out of the 26 times it 
appears in the file.

Cheers,
Quentin
