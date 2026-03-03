Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0F1EC0466
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 09:18:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FFB983F80;
	Tue,  3 Mar 2026 10:18:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="eWHNBcvY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9A1A83F4D; Tue,  3 Mar 2026 08:59:49 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 491708063E
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 08:59:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyIe9K+CEvxNSYH9G5b8FLpzruL8TiJX/xKh8L+pSjYUki+OzUcbfcpveJZkIMG3WKyaZ4yBns9d2Z07+fx+9iEJXxqg0vD5R+DGiwPVVSaNzEOpBcgyJM4nLTdHOw2u/FbbyGS3H0jOXTNEv1bre7ApLcztHUnh/Ndt2j6Zvy/9kLjLfZiRxL1IUYQkkReyokn0IftAI5sCJLzS+h8auG1RQl/F5UlrrnqQITB10w92/P6Oi6E5y5VCu69ZkZDjkKwCmWN0XHKtE6F45b3tsn/BttCbLY64XBb27HLKnotYG8kREwlBxmi+f1VqmCcm8qQV+WLDqqLFqbPvqdCM0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AL+AMzhlEqANnuWBpNKXexwzYxzDH30n2b5F/vV3KaA=;
 b=JOqZpC8nKY6CVCHuC6GKRva4cvdcq2qiIDITKWWkYmxH4TbrWC16s4vW6v1mGSKuFNZPeqL7NL3WlYm4haU1jxpwKuz/ESZ3WVVBRtY5kf8vR+9mmqCa05+4afbvknKu8OiFnDJ2ZdYCq1lSYMDyR4vb+XpjScCYXrdIGHW6KjzeKaUsIsv4xJQf8DSSS2kyMgxpfkxDr2GWJRfEBV3Ak44LWUMrHJVyvFcNfqL1WP/D7eRuMWC1ZOpp9mu0MmPD1RTdlFZqx3IXip17hKzRLZh2rh+rIZaFYqd5LJxTZsi4Aao8tyHLuKBL/qLHXwFXUZ7JdmcK3qIotIEyyEgR7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AL+AMzhlEqANnuWBpNKXexwzYxzDH30n2b5F/vV3KaA=;
 b=eWHNBcvYDqzkk29KrxT8ALU5bDKb9BAy2XkESNk5nMp2LAIwJ9FDDZNsxVf2uBmppy1BeJvwFYN7swdZaXmvCU8suPU6Vfz436Z6iLXFhlvmDlgUIds53i1B92GVqso7e04nuxMv3ISiT8hyNqESJfjtMnWBGHPpVXEeY+bZPemTeaw/OOG6ehbEuBGppaYRCjjeK63StMnjItWov9PW9cWgHY8NifWTThVoGDKzRxK5pG0JK3OeRleBCxplBddqzGTVBWuTR/DoJlpF48n/e7h7u79q2mzYqA0NDz1dUID91hP/i9BR/eVXV2MUMEYKUb8k4JBhsjziIsqbILTVBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by BLAPR03MB5410.namprd03.prod.outlook.com (2603:10b6:208:29c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 07:59:44 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%7]) with mapi id 15.20.9654.015; Tue, 3 Mar 2026
 07:59:44 +0000
Message-ID: <a66c8ed7-0f88-4e1f-a212-30e39f675df2@altera.com>
Date: Tue, 3 Mar 2026 15:59:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] spi: designware: add support for bits-per-word DT
 binding
To: Tom Rini <trini@konsulko.com>
Cc: U-boot Openlist <u-boot@lists.denx.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20260227110434.5058-1-boon.khai.ng@altera.com>
 <20260227140756.GP1593142@bill-the-cat>
Content-Language: en-US
From: "Ng, Boon Khai" <boon.khai.ng@altera.com>
In-Reply-To: <20260227140756.GP1593142@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::8) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|BLAPR03MB5410:EE_
X-MS-Office365-Filtering-Correlation-Id: 683cb3f0-98b4-48db-8246-08de78fad49f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: ON8oEXiMtPSYQWhv23IAwurDeEX2PFs45C7QGgG20+B2S6gH8Cb+xLEoOX8clNxBnUXeAA9kFvQe/gkdFUJxbTuLnvmheqfo6ZYRgZR8/5fDO+4ZE3lObeSXSGD0OGNUtbyeNkR9r/l/+UZfObmUclCyL3WTKemTBDLVHl6S7bOgU0veFWDTvBohkb4Q5jy6wyES1NJOdrm8nS5aHm23vri+QlfHtkRnq2CVPgPLaoNeE9+aelaW0k2nIt5Y2AQG0XscwsPfSqFc9VJoTeYcP4L2SkeBKjMpxKQ9lSqRfp1mUqmhttXPYiZ3KMTNrfPDrOE0SjtcVofh74TzjSPfKumu0/KBH2m7moBGX6WcVN0fdDe9X3xasKYFm4m0ZAK4NlYtT0gFa9f0jHC1UCqtLJV3sybxRy8iNekmIEbgEwNBFgCpgbf/d+wixiuNkX4mM175Bii915jDtqoqBJPQNpFJknGMa7UJSqbViHQb65D2FMaL1IF7tONoG4IFVL3gnwZeiWAA7lnCfbkd/BOvj6lFO25C024wUfQjVKhibKLDSuogoqI2clzAX7P4doysEFC5H2MvP0/xq9g5NozCUQXdnJYPDibqx7ZWtEM/ydO3X/DcoSPXywnTtrwSXCf9xQyHCZ/7wv9RoSUFbEnrv+JzFu41jW46bcQU7boevyrEciDV2C4cT4yGFIdE7mAu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czcxeld4d2xETjV0dy83SlNvZmVESy9QODRrUzdnS2tEYk9Nck1Nd0hsQVFh?=
 =?utf-8?B?bmFEZDlIcjZBaFAyZnQ1MWNic3I1Tk96dnlKMStCSTFSdFFPa0lDTmpsN2Vu?=
 =?utf-8?B?bWUwNlRZWm4wWEcxQWI4aDNBdThONnIwc0ZNNnBROExNcHNyNmdrZVU1QVo2?=
 =?utf-8?B?eE51eGFCbGJoUkFSalpmdU8xMGlhMnpuSDM5NExJYitJLzRpT0dvRjJFbEtD?=
 =?utf-8?B?di9FdkQrOFFvWENFNm9lai9LVWJmOGRzc01KeS9sdExmMDkyMXZ2bnlMeHRm?=
 =?utf-8?B?ZkxEa0ZEdHU0QXc4NGpyS0w3LzMxbDlBaWNpZW5xdEwrS3BHSnVNNWJPc21I?=
 =?utf-8?B?VnZEMHhMZHBSZE4zbkNPTnAwNVdPRFlCUW1iYWhEUlhwdElDdmdVbVNzK1FL?=
 =?utf-8?B?ZkdLVVRJMnRNQW5Uam5VWmRCcWtEeDBlaUxhTlg0MjliZGhQSCtkS3VJK1Nr?=
 =?utf-8?B?YWV0NU1Zckdwa1R1NVhGL21SVGl2M2NIalRqaE4vK25BOUYvZ2F5MjIwc2pH?=
 =?utf-8?B?aGdVT2dja21GSUZxanFmUVB5ejlYMTNVTmxTUVhrcWs5TXl3UjZ2ZnhEbDYx?=
 =?utf-8?B?ZlhOM3NROURheE9TS1BzMmswVCthY00zQk5XRGFIa1Nja1dBTjhkeDArWlli?=
 =?utf-8?B?eUxyL2FOLys4MVRJZ05RRTNtSjdlQ0Q5R1Nxd0Q1RytIUm95MkRlUWRHb3Jj?=
 =?utf-8?B?eXh0NThVNkpacmJIMnNQTU5qaTB0dHBURGhMK3RIMnZDaXBtMUdMTENmRkpK?=
 =?utf-8?B?RGJaZzVnOGc5NlBPeEpRZFN5c2U4MXJjSEZMa3RJTCtzVEVlV2orblM1cWpn?=
 =?utf-8?B?K1lsSzBvVkhMZXRTSWpYZ1dLMHdDbERaUVJqQ1JYMVdxMWNsRWtUVGJHUWdD?=
 =?utf-8?B?NHJBM3dnS0E1OE9ocmxjM1hZWHd2MmtzTmNVVE1pY1pjZzZIVkhwRGR2VGxy?=
 =?utf-8?B?RWlMTlJ2ck9MdlNXZXBKL2Ewdi9SYUxZV0Vzd3B0R2VUQ29McWhBT3JVc0ow?=
 =?utf-8?B?RG9RL2pxUFJ5b1lubVFwUGtrQzdjVFZmVmpaVGZzUXVtY1Q5cHl3K0c0M2FU?=
 =?utf-8?B?Umgyd3RxYUorSWN1ZkxhZm1KOTkweEdMaDExakQxM2NSOHZQM2c3Z0Z3TjE2?=
 =?utf-8?B?a0JYQkdmSEpLZjN3RzRyUFdXTm1wQmlBYkU2dHM0dVp3dWd1QmhGUVVnb1Q5?=
 =?utf-8?B?UXBmeTdaUzB2Y2F2Z2p3ZkVSSlgyWlQxTjlVTnNLWFJqMnpMUDVDNXBzNmho?=
 =?utf-8?B?czd5am5lZ1QzTXNMV1liYUw3ZzhGKy9YSlZXVVdsMzAzbnZ3bGRaamJxcEcw?=
 =?utf-8?B?OW5zRVJOaGhPN1ZMT2lleU0rZ2gxZzMwN3ZnOU9wclJhZHA0cE5lek5CS1Fy?=
 =?utf-8?B?NE84elVQdUFUeUNXTEQ5TkM1UlhweWZjV05haEtyWHZ1NE82Z3ozYWhmN0xB?=
 =?utf-8?B?bkFNWjlkZzFEelJoVVFMZGt3V2M0YkhOcmtSN0VETDh4T3lVYURURWhxejdj?=
 =?utf-8?B?czE1NENpTDlLVnBBYkdkeXUzcHFWTWRuWDQ5b2oxQUhLUnBJQ2M3OFhQano3?=
 =?utf-8?B?Z3JHZlNKMWl4OEJudjhkNHBOUzA2dlVKOENtbmZFd1ZVUlpHcVBGd1VYT3pC?=
 =?utf-8?B?bTNVVmtLcmJLZFErN2xORWluYm14OVlVT0tkYVplNDdQRWNYTU15MEowUC9x?=
 =?utf-8?B?dyt3TFQwQXNSSGN0TWNUN21QdGZ5YlFyelR4dFI3NzYvWVE2cHNJTEVSYnBj?=
 =?utf-8?B?RFBGenBHYkZqTFQrUW1pdlkvbWVpMHI4SmFvTldXZE14ZWx3ZlFKQWdHWGpV?=
 =?utf-8?B?Mkp2UGZzTzBJKzhKeC9jTHNPU09WRjZGSzZDaWhPYklQbmpGWkc3TFpock95?=
 =?utf-8?B?SStWOXBZZmM0TytmSTFBWk5vZVNrUmdZTUwraTNTQ3kyc0FGbDFhYVhoWlFS?=
 =?utf-8?B?ZENIVDQ4azJBSlpibjBpTUU0YkhqNGdHZ1oxTjVldHJCQXNpOVJvSkQxMy9J?=
 =?utf-8?B?ZE5CQWlrS0tsVjJwS3JvS3ZIRDIweUxCSlA2MGQ0NzI0cXFhRGREYVVBNmR3?=
 =?utf-8?B?NjBrampGV3ozTkRLcm9ESmdncklCdlRpcDVtdGxYbDgwdFZxN1hxdmJzcnl6?=
 =?utf-8?B?RXdGS3ZNYlRHSmF3YXpZYzlPUXpqZDRDcGVvTU9ibm15dDlMSU51cFRNMlZB?=
 =?utf-8?B?Y3lMNFdiZWhrWitwVUtTVUwxNERRRmdXSzZpSXpuc2twWFJjYWl4a0ZQbDU3?=
 =?utf-8?B?REhMWGtHQnByemRaK2haNXFBOUFYV1FTd3ZadVV5L3dlOEJ0TmtMSjg5TDRW?=
 =?utf-8?B?WHJ4bU1lbklIdEZ5dUZrQkk4cDIzRTlhMHQza2Rzd3dVSFZEbWFpZjNwNHR5?=
 =?utf-8?Q?W9jwdx1yCysuPnck=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 683cb3f0-98b4-48db-8246-08de78fad49f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 07:59:44.3521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wGbSc0/kaGlZj90BLTEbAbrIqFKhaJMDAJro2AoIh19t/cNRxBOqCaC+x/k/bidaYn3K9mEMqkQEDF6uBQnfAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5410
X-Mailman-Approved-At: Tue, 03 Mar 2026 10:17:57 +0100
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

Hi Tom,

> I don't see this binding in v7.0-rc1, did I miss it? Thanks.
> 

This binding was not introduce in Linux. This is a per-requisite commit
to support the Agilex Smart NIC 60xx board 
https://www.silicom-usa.com/wp-content/uploads/2024/02/FPGA-SmartNIC-N6010-AgileX-Based.pdf

During the initialization stage, this board require a spi communication 
to configure the chip's PLL and also to check the chip's status.

and it require the specific spi bits-per-word=16 setting.

Can i add the binding at U-Boot?
https://github.com/u-boot/u-boot/blob/master/doc/device-tree-bindings/spi/snps%2Cdw-apb-ssi.txt

Regards
Boon Khai.

