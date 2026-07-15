Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA281C44507
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 09:25:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60D5984B7F;
	Wed, 15 Jul 2026 11:25:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="KS6vwp3m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AB3E84B86; Wed, 15 Jul 2026 11:25:40 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E53C84B55
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 11:25:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VSr/vOmCCUSCqkH0r1qv2C5ANt850lUMReJkvYEITSpOekwQ+STnqlMVQKq0PSj0/1rlRZKqpPxOm/4PQtXqZuwBy9rokReNd4KhV2hO4ar6ECEWpogMYCh3Q/ZZ8V6vP+cE4Bj+aupOq7H4Xi8z84FIGv40vNNYqVO2rvddzI+Bxoc4vFVR0/m+4dl4awYbd/WvdOR5Gwo3NOT2M0qZFGeiJzvAFiSb85Ga37HZPQ5TdDlqVKCs1SnXDvCUB7KzCNqrYYyQ0v69zS+FYnQbbGVgcj+8nN4utdzcZSb8H5LZ5eAG3zD5rsOmRXA04FG1OWDroRZyrbtP8IHxXYrVvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lp5jD3lncY/1JwN1nmsZXdLtUSp7vqp+zox0EXH6/zw=;
 b=Tl5QrXLsVVxqe1Gsg4ua/aeEVkzpVBROQpq/YX/4jlKJ/sYmVmGJ3eMucf6+3SNC2dpwMxOk6HAEAuYgZiSZEf2XBKNc/7ZEG8JLUP+6FE0jAYHmBXsivwp+sE6SeFQLPF28bsnBp5YHMSFkFZF/OIuaZtXMiSRNBohWyOemdsC/yUGXdzYT1zXQcAlMg9b7yNAShks1uGgdJD1x5Fk1JxN7LxRqHox5fiHgLOT9VJAsXTh7HEeMEsCmKhB+kw67AmVmwTOuaxP4g6r4/ZN8C7RQX47o8wj8tmjAHl6a+ceND/5YkXA+nz1FnbDy9V+Pn/62tibVfhRYxSWYPptq2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lp5jD3lncY/1JwN1nmsZXdLtUSp7vqp+zox0EXH6/zw=;
 b=KS6vwp3muNC+D0Rbp0ZOM1qQnMbrA51Q1prn3PQShcUz8ErqSqrRR0DXwM7ZlcHTDPZs0qognXVcz9d9z+0+g61yShj1qTr3ylq5dafcLIwLfgXrGcLpYm2EEawnUig3w0gTLsKN5vWoYKKXz3kH6W/sbRcPRKHoLJWqhVctPh4+RNF/6P6BvAwxVDVnTEfMtNOqqAiVyZv+8pO+vzYGumpQJWiLb/0cONAbuqhbQlAqm6sNAZaCmcQ1fTnDtZuxG9KbeVeJHFdGxRdqy02JcXTlzMiLRv0CDfi7heRhNMuWp9kVtHBWqHSNMGbsQVvJ6uaWV06EMZVX6kisWStuKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by CO1PR03MB5763.namprd03.prod.outlook.com (2603:10b6:303:9a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Wed, 15 Jul
 2026 09:25:35 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%4]) with mapi id 15.21.0202.014; Wed, 15 Jul 2026
 09:25:34 +0000
Message-ID: <3b8f1bed-fc7f-4270-9e8a-5cb4aecffb2e@altera.com>
Date: Wed, 15 Jul 2026 17:25:25 +0800
User-Agent: Mozilla Thunderbird
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
Subject: Re: [PATCH] configs: socfpga_arria10_defconfig: Enable
 CONFIG_CMD_FPGA_LOADMK
To: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>, u-boot@lists.denx.de
Cc: Dinh Nguyen <dinguyen@kernel.org>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>
References: <20260507005210.30014-1-dinesh.maniyam@altera.com>
Content-Language: en-US
In-Reply-To: <20260507005210.30014-1-dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:196::16) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|CO1PR03MB5763:EE_
X-MS-Office365-Filtering-Correlation-Id: e2cc338c-0fc2-4477-25e4-08dee25305ff
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|11063799006|55112099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZmXrbBTsm0TJap99uGSwWvLNdi6WCq9imCH1H/IC36wZxHI2NS1dQx5mFoksLVqipu3lEMzJ+Zm52UVd/mMXdkM0tk9mwNHlsvt0YdBZDVuDkSMBrzuRGXz/wHF3vrlsj5K+rIeyKckCemOLokvHvfAsjSATL+PmHRWrK8++wuHEpZWH6zPZLqcx96ggKzR5nsJT21AuhFi6y5w4Y1lNg5DcL/KtqbpePEghxZCMEzYGc39P97zAzPLwwk1ZJw32l2/oh4RQB7L9LKOfp5MY6ge4ZNg/KI6p2GeGM6FIC1Ywa7nkHhPVIBvJiZwCUbMT9SqRN2ll/U7mJRvQe56ZGFw0wkWV91W8zShUB7QlYtya7tJBeAgPTqNLjVJg8HGl7VTs53XEi5AjehUm7MaOBGHqW505WPTX5zfL21+97UxC5Lhck//Ndj16Msa6cBMUGtKtPisWpsu0qWHiGo7hMreLxRPUB5rNoN9y3EpsT6p8uY0rpgpECesznCD0DCGV2asKPuSYlYjTfHyWjha0BFl4sw6CA+k9qJJJhzME/1pqQS4UQecmuVLPmlQntFC73Q7QdfUN4piUjN9AFN6mJDh5LlpubsO+Md5stZVMevq8AM3guZAkvXB/d0bVN/PitTDtWl6LcwtU5AIydDZsA3bDV+m5RLou4Td+6TxWN0g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(55112099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFYxaDVwRzlMWTJsSGtYdWsyZ1RMZk1ZUVg0VkhQWmxqSVR6ZERRdWMxRHdF?=
 =?utf-8?B?WDd6Q1NpRlNWUmFJQXJPYk5raTNsL29NSkdJakVSNjZVOXVtNE5nSy9aTkZS?=
 =?utf-8?B?b2lsQTRwOFBrUXlQWGR6Q2xPSUNpU1ZicjFZbldmTUFKam1ZZzdQNFp3OEov?=
 =?utf-8?B?eXJ6U2ljLzFuVzhxM0hIRm91cERvVFZlbTB3TkpGblRWQ1JJYmJtQVFqdzlQ?=
 =?utf-8?B?MkovMGl6UlRsbVAzRHVHU3puNFZvTHdBdTUvZHZuTytCd0hFc1h1Tzg5cUxZ?=
 =?utf-8?B?czdHV3lNcEpBU2h5R0RSVy9SMnJNWHd4VGIyeE9BY0U0Sm5jclBOYkozbFV5?=
 =?utf-8?B?MmlFa3FGa21hWWEzN0FDaUt5RlJPd0daQ3FqZm1sQzM5bVQzQlVRTFEwaUFj?=
 =?utf-8?B?S0IvNWNZelBMSjlYclFKZ0hYM05WYnVVdnJGdURZMUZEQnFxbDBHamdGU1Zx?=
 =?utf-8?B?NHUwUmxzSnk3NjRkVGtpWTBVQlBLZEJMUDNVVU5ZZVA2T0d1a2Z3ei9LaEFY?=
 =?utf-8?B?LzRmSy95c0NnVWZFeFErZCtSVXJqbFIxaE5RR09iTm1WU3ZTaktFOVhteFRM?=
 =?utf-8?B?K3p3d3hYSW1hT2VydTRTbmhOYkdMRDNtZzhqZi9FV2lJUjVTTUMrdnFiWHRF?=
 =?utf-8?B?YlNGTUtYVit5QUdSa2pSMUNHdlhNVmZQZE1FN3VpY05QOWtWa21RbUV4TWkv?=
 =?utf-8?B?THhwWlJ0ejR1ZHkveEkwUmMrQmNSd0VnMWJkbUZJVGVHY1p3YUVBeVJtVXEz?=
 =?utf-8?B?TUU5UnFmVnhZZjlyc0Z6S1BiWHFKS3JRaU1LVnhlOTVEU2RVb1NpV0ZoU24w?=
 =?utf-8?B?bnFUZkZEVktjVU9wWnFTUFFKd2ozYzRUWVdCbmN2K0JWeHVMbDl0aUQxcWla?=
 =?utf-8?B?aXhxRjJYZWJZbVZNYW84VjJ0eHJ3a3FhU240U0w1U1o0OFo3ZGludm5tK1dh?=
 =?utf-8?B?TXhUa2l5NmdDTXloT1RtdHZOMjBhT21sMmlIMHdROFRtQTFqdXd0NXF5Z245?=
 =?utf-8?B?UGNyNzY2UWg1YTEwSTZ5V0tBeE5kV1NxMzFZMmo1cWpoYnZaU3J0Sjl3UjQw?=
 =?utf-8?B?OUVZMkh0NlNYNm95WTJlM1pUYzQ1NHUxR3BUSVlUc2JFYnZJUlVHb2NFTXRr?=
 =?utf-8?B?NHBjQzIxQWlTazlXcVFxc3VEVVc0VzR0SENkREtKckxaTU5oRUpsN1lEdDBP?=
 =?utf-8?B?U0tJNGFvQ3o5SVVMOCtKNG1QcXBDRjh1RlF0Y01Kd2h1QjdMZEVMOXhvbFZ4?=
 =?utf-8?B?TnExRXROMFNtb1U1T3B4dG10TStkVW9yYldqREhxNEdZaG9aVm1VdUVTUnpU?=
 =?utf-8?B?UE12WmJIZDF0Uy8rMVA0VVFkZUV6RDlQSzhXb0YrL0ljK1pwZklzY041WDBE?=
 =?utf-8?B?cnQ0YVlYelUxZ0djeDlYVFRHaml5SklxR3dseGN6Q1pzNEswQnF2eFcwSmRr?=
 =?utf-8?B?Y3JhSkpYczdPWUNOaFpyTDBCV29BdTc3V05DY2t1WTJETExrUXNxV2R3SUtS?=
 =?utf-8?B?aHhYaWsrSVBSdEMzbCt1d2FKRTdoR1A3TXpnY0NxRURjdTV0eWRBb3hwSU8w?=
 =?utf-8?B?U2daY2o1Zk1zTzBrb08zaEZLWmIydDVXR1Z5ejRNREZnVm56ZVo5WGNzN1k2?=
 =?utf-8?B?LzEyaW1XeG5QRUt4Znd5TDJDSWF5MHAra3czZFQ2SW1aVDFDYkFBSnhlajZ2?=
 =?utf-8?B?czkyYzliNFdSNFFuL3A1VGplWWtCbDZPdkdRTEVjbVI2aCtpKzdzSmc1d21y?=
 =?utf-8?B?czg4a0d4Y1BPbExoOGt2Y2NqbFJTOWg2bTZaR2hKejNWOTlMY0F3T0lCY1NW?=
 =?utf-8?B?MGJKVVlSTzFGUERocmFhVkVxTHBpaGxnZ1lqOFNGK3B3YnM5MURkSDdoWjYy?=
 =?utf-8?B?SkJuNUx1TnlFYUFyZG1RcHZMT2I5Z0dmSkJISkw5ZHNlN0JScE9DS3UyOXFz?=
 =?utf-8?B?TEE0NlpEVHdpZExnaGZUVTEwOUl2aWNRa2kxNXRaOGMxWEhWbUVJU1hDVmJq?=
 =?utf-8?B?ODA5SFdObDhzQXdpRDlxTVhzNW9jcmJVaTNWYXBvVm9KVXVsVjc3ZnVzU3VC?=
 =?utf-8?B?ODJLUVduRGlJK1RLeHhIdnBXbHQ0b215c25FZWl1TkRLMCtQYjBIVFpzTi9z?=
 =?utf-8?B?ak9ESjdjOUlSaU0vMnBseUJEa25EcGVubjVPSzc2eXIzNTMvc25sUnAxTldE?=
 =?utf-8?B?R2xGWlRiRDZPRGFVdEdkbDlXSHpqRDVaN2hwbkg1eFNldjhpa2lXaDdEZFlV?=
 =?utf-8?B?Y092N1B6NHZ4bWQzb0tWWGhZanI2S2ZUVysvUW5GZjlYMHFFYzlhaW9EUHAx?=
 =?utf-8?B?cDFLM3BhVERmem9idkNBY3NIY0JvaDZvcEZUTlplU2FjNmpPb2JuNm4zN1Ru?=
 =?utf-8?Q?RuZWSZEy0PxigDqU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2cc338c-0fc2-4477-25e4-08dee25305ff
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 09:25:34.8332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: npmd2vupy8DHWClsLCDc08Z2Oe3JUnAcI9oFInwdUZWrgWhpxdj+Fi3nSZXXW8XkJOXBTE6ZofzlsR6USGfmrQVrrszlmIA93eYXoqPTDu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5763
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

Hi Dinesh,

On Thu, 07 May 2026 08:52:10 +0800, dinesh.maniyam@altera.com wrote:
> Enable the "fpga loadmk" command on the Arria 10 SoC Development Kit
> defconfig so that users can program the FPGA core bitstream from a
> FIT image already loaded into DDR.
>
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> ---
>  configs/socfpga_arria10_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configs/socfpga_arria10_defconfig b/configs/socfpga_arria10_defconfig
> index b32f40ae408..3e3689dbec3 100644
> --- a/configs/socfpga_arria10_defconfig
> +++ b/configs/socfpga_arria10_defconfig
> @@ -40,6 +40,7 @@ CONFIG_SPL_FPGA=y
>  CONFIG_SYS_MAXARGS=32
>  CONFIG_CMD_ASKENV=y
>  CONFIG_CMD_GREPENV=y
> +CONFIG_CMD_FPGA_LOADMK=y
>  CONFIG_CMD_GPIO=y
>  CONFIG_CMD_MMC=y
>  CONFIG_CMD_USB=y
> -- 
> 2.43.7

Looks good to me. Thanks.

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
