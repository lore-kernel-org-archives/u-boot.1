Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 404D0C0219E
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 03:47:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB1B380821;
	Tue, 11 Feb 2025 04:47:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="plRN9qOO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5170380824; Tue, 11 Feb 2025 04:47:43 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20720.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::720])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A103803CC
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 04:47:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/Ie6OGlFrX1oM4e1FGgwV3s2zEXfmgAcskrMpaf+QmyStB7tVYKgE4Vz98RtgIU8lLbc+1cOn9o1F6sng8hVErl5KmpGIuD5lxhR+fBQ2QeCswPRKRzNbnAMeI1FVvO2rTY3jwNHFvb46hS1eonvSBhuSQdXz/BlgFql9fZzqPyHPls/qfY8dtCjyy/3f0rElV2Cjc3h351xySP9zfTTboTCVC7lOsD+jlDtjQua7s8gjWHK717TER5A3gQARYfxGqAQGVKXEhcG1s/yyJ29+u0GuoSJ2Y+TXVVgzTsBxv+ri3K+ORanwNUFWkiur5/5wbCJx/zUqXTv9D7RFwc8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keiU6EQ8vANqr4/nFhMNeUHPwl58xXV3Oysi1tDq+LA=;
 b=B7+LR3lgUpItshFw4RPnxyfv36PXnKUHpzBXopSdWuzCOFb3tnzNpmEhVVEmniq/MTdIHc0k7IL3YEpHl0PlMJkd//VB8OIO+i+iZVos5xX97NHVcNJotR85mBCIsoBQ/thOIjW6qViTYwYn43tK4M5/jtt9mFKjGog7spb6iRajzorzKBCAYVBxjyCivb0aWM8k3kCs9AYs/vVJqbM4MeIO/YgXDBTSoJyS8mBwtcS/e8/4YOlOTlFvr9SwqSFnB49PZdq4rGWnOi+A5+rwOYzl+fWoZU1RURsnN5xwvTEHrqSIXbTFy9RIeyrZb9a1U1m00IfLAPW9uuujq9OlaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keiU6EQ8vANqr4/nFhMNeUHPwl58xXV3Oysi1tDq+LA=;
 b=plRN9qOOXPi0bEeM7WSOgSoDnYU+cUiURNfh56xFfIyEYrDNQdFUNQfMYEqfa7S98xo1pzn/RhV8zFw99TzcniH/EK0CjPkgsN201+5EL8qIAWU3JO5KblbBOruz/Kh3DxSox1aKc/XBtCBCrUtMaaBFZ65XuX/0uWGiuU7jBljU7f/u9h8WS9lCrncDwV6m79eBicpEsk/2MWlI9Ey0Kq26AiW1536tiSv8evKO4pyZLrZEa1TzVx741vwMidBGMTaZWcmA4yDZ1mpsAFRIdjTmvTeZP8gDZYGkF3BK+ELcg9CBhzyjl8qQEtFTRRDiin946eHNWjVpQvT+N94WUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by DB9P195MB1779.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:39b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 11 Feb
 2025 03:47:40 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%6]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 03:47:40 +0000
Message-ID: <cdf90ed4-3d6c-4280-9641-bbeb6a85a4a8@phytec.de>
Date: Tue, 11 Feb 2025 10:47:34 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] board: Phytec: phycore_am62x: Increase size for Image
 in SPI
To: Daniel Schultz <d.schultz@phytec.de>, trini@konsulko.com,
 u-boot@lists.denx.de
Cc: upstream@lists.phytec.de
References: <20250210152548.1263498-1-d.schultz@phytec.de>
 <20250210152548.1263498-4-d.schultz@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250210152548.1263498-4-d.schultz@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:820:c::10) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|DB9P195MB1779:EE_
X-MS-Office365-Filtering-Correlation-Id: 48f573ba-eaa6-463d-d4a8-08dd4a4ed4ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zy82ZnNwY2pRMTNOMTNvTGRqOUx4ZkhLM2pTbnNmYzZVT0V2WmRqU3Btb0tS?=
 =?utf-8?B?TFdCcm5Ba1B6bWpDNWZta0UwUENNWFdNSTRGZEtLQThRUFh3aEVFU0d6dFhI?=
 =?utf-8?B?SHEveDA1NFFmSE1aRnBlNk1ma2QwQ2c5RldOR0dXN2RvZUJtTU5GbVp6L211?=
 =?utf-8?B?VHpCZXlINXAzL2RiTjE2K2RlUjNVSlZyMUFVeUZDbXBWRzU3Mzh0TnR4b3lU?=
 =?utf-8?B?U3liWlJOMllSZG5WTTUrNUFUcTdzaGVVMkpDS0ZkSkVIR0pWT0ZjNm1vNFNv?=
 =?utf-8?B?c3NNbG1LQW16Vm8wd2N4R3RyVzNHYzZyd3hlT0NSbFFuQ0wvak5jWXQvOHht?=
 =?utf-8?B?dlhMMjJTRE9EaEllaU5rbk43Ry9hMEdxWllBQSsvS1gwd1pLd2FTVjJSVTBC?=
 =?utf-8?B?dVV5UFYvSnpUZWhXd05LQmFIVU9LSmV3Qmt1b1VxOFE2NHBsQSt3Y3ltSXdm?=
 =?utf-8?B?U0Q2L3BtSnh1U2tMY0VwTnRNaGFzKzR0Q2FkOENrblpXTUhINityZlVsL0JR?=
 =?utf-8?B?T2dYY3hwbzJrV0dYSklvMW9NTHJJUXUwMmN5RXRYVnpIOWhxSlhRbU5lR3Fj?=
 =?utf-8?B?OWoySmFvZjNUWEU1WWV0QnB0RXJ0ZFl5cklkaGJDNFlDMjlxeEx1QVNHWHFK?=
 =?utf-8?B?KzN2UVFZN3JlcEVhWnozb2crSTM3Yjlwckx4Ti9mdkRQNmJtNzR5VTlSdVJC?=
 =?utf-8?B?SkxiTnA1MGpUWW9IUjRhQWZqR01mZHc1WEoxdm9TblpjR3h6YUVKZHE5K2V6?=
 =?utf-8?B?WlI2dEUyQWZlaGdxRkZMK05yUFBqcGNJQ2hsTlNCZnZXVjlCTE5IRlVtV1hE?=
 =?utf-8?B?UWVqU0poU2xVd2tMNnJOd2NaNFI0SkdSbUl4L0ZDV1p0VkxoUnZ1V08weWZr?=
 =?utf-8?B?dTJ6QkhLeUVEVVNOQVJOamxTazQvOS9ZaHdqU2NGdnNMWDRMV1lNbWMzQWNY?=
 =?utf-8?B?UVV4Wm44SEdMUkNMZFo4dkNVdVF1MzR6U2Z0ZzY0Nkc0Sm03OFluTC8rR0Nu?=
 =?utf-8?B?RUdpMHdIcUFwRmI2aUMwNkJKK0pBTGlVb2c5TDRUcE1NR25ZWEtQYmNQdVBV?=
 =?utf-8?B?RER2R244SG9NTFhhejdxMVJ0OWdpd0FuTCs2cVNydmxIV1hXclVQemgxa1dQ?=
 =?utf-8?B?RERJYldPWlhoTlJkWUdiV1FXNk1ML2dRcFZFcHRvZzlZZFVUb0xKSlNMdkd6?=
 =?utf-8?B?eEd3Ty9zS3N3ckYrRkdnRkdrMEZEUGwyODlSVG9QaGJiV1pDY2VOY1ZlTWxS?=
 =?utf-8?B?OTlXMGZzZkRnSXFNSktMVmlzQU9TdmVpSzVJWG4zQk1TVjF0dXZndmFqTkdS?=
 =?utf-8?B?TFJ3RklpL291cG1SMGxiejUrWFVCRE1FMHc3VndlUjYwSjQ1WUVBamlncDg2?=
 =?utf-8?B?SVdneXg0cHg2WmJqcXJyb1ppK0RzM2Y4dWdGQjZHa01wSFlSaEV6M01zeFNR?=
 =?utf-8?B?c29CVm1YRTRSQWlEZUNWTFF5RWJGL1NKTm9MdzYwZ3hxZFBGRzdSQURUL2xT?=
 =?utf-8?B?Qm1rWS94TzdONSsvUllnUVFOS1UvQkptVTRDbUFnM0VyT2YzbXNSSXVuQkUr?=
 =?utf-8?B?MGRYL3gzREgrNFlYSXZJREcwYTIzcVVsYWlYdVBWTTZEVEtlWmJmSlhidHhC?=
 =?utf-8?B?amk4VEtiSVVWRnNHb1QybzlEY1Mvc281ZUtTdUVFeXA2VVJYOCtQaU90aHZI?=
 =?utf-8?B?cmZmK1dPTHNncFFQd1Y1ZTd0d3FDMUJJSmIwdDBFYkxpakRXZm5pVHRaKzdu?=
 =?utf-8?B?akNYRHN6OWpwYUFxbnhvZlhub1pHeDgwZHlzVW5HL2xTbWYvKzZvMzFDN1U4?=
 =?utf-8?B?c29ybDk5ME1za2xSM3lBVHRoZXJDKzQrWGloWU5EbVc1TVd1QjJGRVY3SWQ1?=
 =?utf-8?Q?5TaizwWwdA6/7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmVHSHdRY3o2Ry9QNkhIZFpKa0gzUWp0YlZkQTlsU0tDT3NEb3hqbERQWEhY?=
 =?utf-8?B?L1QxZWVxUGgraERhbHRQeHFYeDhpd2x6c210TjV0aWhyNWowN0dSUE1JSUw2?=
 =?utf-8?B?eXNuTUY5Ti9Pcm1XeW5PVjkwWXg2T25aczhyZ09iQTYzTzVCS1NpaFNQVHJG?=
 =?utf-8?B?SXZFQzV0MU0zdjVrRGliNzZnN1FlU2pPUnVEcWFFUFcwN3VBUVAvYzIxZkxL?=
 =?utf-8?B?NDBwdEpYVVYrTUNVcTNVZlVWNjNBZzY2NWVaMW9saVJ5ZXJSZDQ4M2h6OHRu?=
 =?utf-8?B?V0FYMXd5VXRZcXc1NjM2a1Y2MWY0ekJpa1d3YzZ1UlJ4VE50LzhWWGhvVGRt?=
 =?utf-8?B?aFU4S2luZWFqelptcWZSeEZLU3BYa0V1WWloSGppbmhhZXJiTTk1T05zaWJz?=
 =?utf-8?B?RExnSXlGcVJSSWg0Q3drdVJqbmFVTC85c25qZ2RZK1RtQjlCaEZ5V2pxRnhW?=
 =?utf-8?B?WTArb1luZE5wNndXWlBlQUo1WmJTUlFpRTJ0TzJsWkdaSmI0aUNUbGpMWldH?=
 =?utf-8?B?YWt5UTJabENqeXRPL2pRSUVJbTM0NDltYmhHUE9WSHNOTXJDUW5VQU9MRlJW?=
 =?utf-8?B?ejJkYWdQMkVWVW5ZanA3Vm9mYTZWYmcvYXpSZThxZmtNVHB1cVNUU3ZYVGtE?=
 =?utf-8?B?TWpxRVJuVVVHSW44dFYxU1A5blJIbjhETjU3WDhLUFU2SUlFMDVEYnlmcEtm?=
 =?utf-8?B?RTVqbEtRN0VaNnp4dFJ4MnBzYytMSkZGdVBGcVRIcU9CVEwzcFJhLy9sVnlW?=
 =?utf-8?B?dGY1UGRrczQwQisya2l6bDhScS96TWFxMGNVY1NMVUJNbFZOUUtVMkNFSmZM?=
 =?utf-8?B?a0Urd25kanZEYXJGR0NMQUZnUGN3dmtmZVNKZFVpYVBvZ3ZJczRUU1d0cC9X?=
 =?utf-8?B?RURITWlETmVSWThURS95SU5sYmZZcmJzZXRBODZ1NFVzUTRhYXJheWpxZmdh?=
 =?utf-8?B?VldYWUJ4Z0FZVUpvR1pXNXVDekpGUDRvUnFrNWVxQTBLRU5aUU55VFZidjZx?=
 =?utf-8?B?VGIvNWJkQXJ0MnRySVBXS0diclM2L2prZWRTZFIxQStZM3gzY3dIQlNWUTRu?=
 =?utf-8?B?TFZvNHlkdVdNbFphd1VSelY4T2xDZWJsOUszZGxEcit2bXVlaHV6aVk2Qzh4?=
 =?utf-8?B?UnA0OVc2Uy9zY3ZkOGJkUE1QVkEyQ2MrQkM2UTkrekpzMlFjaDFtZG4rNTBD?=
 =?utf-8?B?Q0tWRm5OMG9RbmhHNHMxVm1mSkR0UTJVUG4xU1JEbXVEVnQ5RGd6bWhoNXR2?=
 =?utf-8?B?WGMrcXo0MUFGZGpPWFJZSmdiUk90amd0bHVSSjZORmszVXJiYnZzUVNBM1pn?=
 =?utf-8?B?ZDRhYVJaL2dQeTAwWi9SRFBwZWVZdGNqZFF6SENDdzB0eGlEVUhYeWtJZjVZ?=
 =?utf-8?B?WjlUUExDUEdZNmpGUnBDSlJUTWZDTldyMVpVVVpyanUwWFV1b1J4N3VOVlB1?=
 =?utf-8?B?MUtoKytGdTQ3YVplOUwwV1hQaUhMd3dFTGhpYkM1NmtJdkZFdzlESlhGblFT?=
 =?utf-8?B?aG9NcUw2OVZSSFFEajBtOXUxOFFkOEQwcjdNSDVIaVZKblVjc2lyUWZTS29n?=
 =?utf-8?B?U054b25kcGxCaEVQcDZ6a3JQbnJFMWdWelJza2loVFplY0k3WkxXSkt5MWFl?=
 =?utf-8?B?YldvY25OOE1leWFkRVdUbjlhdzA4eXpTZTJqbXVEL0pEamsyc01kbWVwSno1?=
 =?utf-8?B?Z0pKNEVSQUlSU2pKdWlPcGdMQUJKRU9URUl1WUVjYUxuSUlNS2xsanJsNGZz?=
 =?utf-8?B?VUxXYnFwdldobG5ucmNFMXVVWElsVjRtN3c2UTVoa3ZXcmcxd2E0QzlTalNB?=
 =?utf-8?B?eDk4OWJNRENvcFFTMEFUakVmWUZ1b1h3cm45WlVmNkJ2NnlnckdtQ3ZBUzdn?=
 =?utf-8?B?alVvb2t6NzIzZ0x4elBPOE42RHFoUFlhWGwxc3FpR05OblFnNzhMelJWRlhv?=
 =?utf-8?B?eGpaYitXQTJxeVNXbVBzcHFGSnRKaHdmc2JCa01IczN6UHBheGZGZ3hiNWdO?=
 =?utf-8?B?SU12UDRrVFBFZi93TDFEREZoZWFlREFlampJSk9MOTF3ckwxSkcvb043bVd5?=
 =?utf-8?B?ZG1nTkZLOVFOdmN0VVU0K2JZdXVQNnppQnVxRzhzK2R0eTU1cGkyQnplMVM4?=
 =?utf-8?Q?9YXmKc1vIVD7HWN4Pc/Wejcnq?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f573ba-eaa6-463d-d4a8-08dd4a4ed4ea
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 03:47:39.9323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nVi3eZ1/GHMeJGjcZEFajbhQaUnougYOiYwMyrTN5D4BJl4pO4Me9ZoKxbVOe1+JsLrmpMY0rdGxhN8RWsMHLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1779
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

Am 10.02.25 um 22:25 schrieb Daniel Schultz:
> Increase the maximum Image size from 23 MB to 26 MB by moving the
> initramfs start address up. This gives us a bigger ranger to
> provide kernel images which are not stripped down too much.
> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> ---
>   board/phytec/phycore_am62x/phycore_am62x.env | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/board/phytec/phycore_am62x/phycore_am62x.env b/board/phytec/phycore_am62x/phycore_am62x.env
> index 711ca3040c4..024f38ebba3 100644
> --- a/board/phytec/phycore_am62x/phycore_am62x.env
> +++ b/board/phytec/phycore_am62x/phycore_am62x.env
> @@ -22,4 +22,4 @@ get_cmd=tftp
>   
>   spi_fdt_addr=0x700000
>   spi_image_addr=0x800000
> -spi_ramdisk_addr=0x1e00000
> +spi_ramdisk_addr=0x2200000

