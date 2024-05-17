Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E604C25B78
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 08:35:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83D7E8848D;
	Fri, 17 May 2024 10:35:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="PkSFszSp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00B6E88490; Fri, 17 May 2024 10:35:52 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4F8488489
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 10:35:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=icfWyHmhd5ZtPrjeyKda2o9+fWcwLLgbSySU/J1zTxMX08WdMjHxNFxCbCeXzPvxz+uxBOvacNOjGBW7uxpq/FxvloARGoj1DapHKWbtZoeowwGy6lUvIsZZif8bLYTX7IJKafwy6c7+MrZh+B/v0KxGnrmOTAjquNxPaBh56NBwqMwhjsPlllaHGSXnaNPYWb0pZMGZB6eEc0BD2G6/KrneMW2IZzviY5VI6/AIgirQixrEsvjoLdkLCibWHnSA7mpqEx9JSMVt279Jw/XDWRAEIRwf5rksJH6JkRk5ZkuVIjxw11cCnsc32DC0HvrWJ5LQ/LTB4pR27+/azTpD+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1GQc2/U6x0sxun7mbijXxgSxE9ZH8I9j7RJpDndXZc=;
 b=gqhSMD51Gpy7o8Dez4z5FIrvH1fIFpVmHlnWCdLbHV9rJx8RZlArAPpL3B3CGPuhMg37rs0Atk6mOzUTW3T8OSXulNLM8/mUmBipQTsbx6LtEdBPbLCa8D1egztdm+NKaD9+gNsKPCqbVOOuK9HEpfUEIwOIVPZG24Z/Guzf1lQl8zYwJ3j64KMvlHJAu3EOmn4Qfq4PCqFK0bN1z/bGhafvt4COXjg0oP5EVEGS/wDx9Lka4T5ZIXW+dIe11Cqtopji1SuGKHbMr3zeVPJW2H6r6dvBDecbYwIVUiHB9DO/pH/xRHQmmm1+8EA/H0g98TcXFuZakIAzC1nxo8bCwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1GQc2/U6x0sxun7mbijXxgSxE9ZH8I9j7RJpDndXZc=;
 b=PkSFszSp6eqkMLmNPxQGxD6AXcGXyzWQFC4sPEauFefY68fyAg0TKcPQLegnbuqfq5vQKm9tKzlGLzDEu75m6IeDiiH9dnIPU60xHKpOixa3t7gcvhsADMqKciGG7ZIWJUb4JUzefnxRrpABLl9fgOjuM4uXNL7Z7a83PNzF6j8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com (2603:10a6:803:128::25)
 by PR3PR04MB7388.eurprd04.prod.outlook.com (2603:10a6:102:84::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Fri, 17 May
 2024 08:35:47 +0000
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31]) by VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31%6]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 08:35:47 +0000
Message-ID: <364fef96-5f0a-466d-99ad-6a4310f7c2f4@cherry.de>
Date: Fri, 17 May 2024 10:35:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] doc: process.rst: Document device tree resync rules
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20240516203416.928567-1-trini@konsulko.com>
 <20240516203416.928567-2-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240516203416.928567-2-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0046.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::15) To VE1PR04MB6589.eurprd04.prod.outlook.com
 (2603:10a6:803:128::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6589:EE_|PR3PR04MB7388:EE_
X-MS-Office365-Filtering-Correlation-Id: 246e5a29-4d0d-4ce1-0620-08dc764c596d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VnBlZy9FVFdGVFBNbnhyRzVTcitIcWhZOFFESU9vTk82RzRIR1pXdUswOCtW?=
 =?utf-8?B?djBDQVFGa1NZREhFcHErOGcxTFFvR1JrcTM0ZjBnZDVxK2VKTWRxSEhDbHhu?=
 =?utf-8?B?cTBzSnJ5NnlHRnlrSkFFT2Zuc3NiRGh0ZmRWT24wQjYzc3FwNmNrM3pNcnhn?=
 =?utf-8?B?ajBjM21UTmFYUEh3L095Sm1ONWhBRlgxai9YbHNNUnFxMWZ2VUJQYnJYMm84?=
 =?utf-8?B?SjhUVWRRcHZ2UkptNVEwN1prUEp3MHc1WWRVekdMU1AvYUh3NWE3aERoV3RW?=
 =?utf-8?B?cHJVNGxYQXRSMDFyRHVPMXc1WEl6YXhiYnF6MDNXd3lQNkhDa2U4djdKSE1C?=
 =?utf-8?B?MUNUVXlWT0tpSllUY2JXVUxZVWFaV2haVE81dXVKcjVCM3lMemhkTmV2SkpY?=
 =?utf-8?B?WkVjYnYzVXZxM3cxN1ZLNmhRd0pnU0VOL20wa2xPaEJoTi80UXJOMXZWdVJV?=
 =?utf-8?B?OG9LVEpHTTh6RC9XSmp4N21IZFZpSjhCdUY4b3dLMFlvamp2OEVTV0JOVWVo?=
 =?utf-8?B?by8vTHU5Z25oV09BSjJoSDU5QllKM3JzOE9hOHNQdHAyMWxnT3dSdldHUTgv?=
 =?utf-8?B?QTlNUUZSYW0xc2tnaVdMb2hJNzYvaHp1dFcyQTkxdTRwVVpXUVIxOVBYdTM4?=
 =?utf-8?B?Wk5xSnM2dk5kUEdiNFdFMWJNT1RvZFpIaEFNaXlBNWlFMW9XWkdOR2FyblRO?=
 =?utf-8?B?N2tSZ1NiUzVvUmRwd1N2bFhLM0hzdytIMHpIRU5iTEpOa1ArTGJKb3pzR2JF?=
 =?utf-8?B?V2dGUlJNU3RITHRDcnlUUWdCY1RtbE45ZzNMa2VyTVBBOHRDUGgxMDU0c0Jv?=
 =?utf-8?B?SEVlTEVSSHgxK1BxME1PRENvWCtuRi8yVUl0SFgzWWZlZXhvSXRicHBudFpX?=
 =?utf-8?B?Z0dZbkp5bmlJZlVsQ3AzNEtxU0hRczcrVnQxR0RjZUhEWmVQNXFKN1Z5cHND?=
 =?utf-8?B?ZkxnTFE3ZzFGNVZjY0JTUVFyYTBXejJmUEkrbU5SZGRWWUFKVUFmUXI0TnlP?=
 =?utf-8?B?RzNjVFJ1dUw5bFNBMDd0UmZEN1cyWXVZRXNkRGFZQmNCMUhNL1dxazZYVk9C?=
 =?utf-8?B?SFEvTUN5L1ZJaHQ4QjVuc2tNQXpzRHVoNytueXlSNTFwalJ1RzVlQ0ZlSkVq?=
 =?utf-8?B?cDM1c3g4b1pnME8valJiTElRS0VNelMydHJ3dWJJQjVGUlF1OXdnTnNDSVlj?=
 =?utf-8?B?Uis3dSs3WTA0N0R4dGIxK1o2RDU1SkRPekZ0TFRoNTJ2VWZQa25aNFZOS04r?=
 =?utf-8?B?WFBJWjJ6RnJzMmpTQ3hVK1g0ZDdNSHFRMXBTWCtWRTVXeGRCTUt0WHlsa2Jt?=
 =?utf-8?B?VFNvNlNOOFdWU0lEa3gydWhnNjN2NUNRZFhST3JGM1ZnaGlUclMvbFdzU2Yy?=
 =?utf-8?B?SDZxd3gwV0pxOWV1MUhQWUNBMGFSSk9sUjFQendiRHdUYzJ6OCtqRUUxNW5S?=
 =?utf-8?B?V2tXOTJ1N1g5REx0VG42MDRRVkhtZG1vWWNwK3lqVytEanhrYmdQT0RRd240?=
 =?utf-8?B?SlZPWmJpcjZ1WEFjTVZ1TnpEWUdCdFZlRkxrRjRKbnZjM3N0SUZOSDJ2ekdJ?=
 =?utf-8?B?V2pCSUF1MXNDemR1NXJaM0lDTmpRN3p5R08xeVplczhhWXZ0SC9PN1Z2R044?=
 =?utf-8?B?T3FMak0xVWVnVkhSZDhFMVJSNWdNRzdPVjEvNUNMcEp4TGVtMGtYZUQ4Z0o3?=
 =?utf-8?B?d0dVNm9wUHRoWVNZYjlTRXN4VG1XRHhWaXpZenh6R21IREF2dXJodzJ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR04MB6589.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkZUdUZ1VVFuS1loMEVJcWJaSCtJK1JETUdva2EyU1JpQzVKL005ZHlqbzN1?=
 =?utf-8?B?L28yb0lXekpib3NzYThuRWJKYXpZbjBFb2VSNDgwQTdrSU4wS0FHVTJCZUNF?=
 =?utf-8?B?Rmk4dnAzaElvVlE1NmZUSkZEclNHaDhiVHVCT0NWNmxLUCtqV3lNS3oxZnB4?=
 =?utf-8?B?bU1EL2FoMjBDS21xZDJVeWZlYWNnNVpYRnJDTjdmSmJiMElEdVBsVnlkN254?=
 =?utf-8?B?eCtzWGpJbld0bktvRjhXbFlHeEtvTEdVM1FMUERWSDI4SWlzM2lqS1Q5T2wy?=
 =?utf-8?B?MVZpUTAvVzU4WGFQdTZOVWI0RjFpcHN6WlpGbE5IWThPc3lxZVpMT296cmFZ?=
 =?utf-8?B?Sm9TWStucWxFNmEwcnZYSjlabkNoamJleG82cmc0UHlySy84bU5mU1JiRzBH?=
 =?utf-8?B?eVZUclpxUXBFUlpKdnZ5MkxqbnVEdzF5eGxnL00ydXF2UjRCb2NtbzlLNHpk?=
 =?utf-8?B?OVNubWQ0UEZVdFJObXpIWE4zV0VRVG42bXpEcnYzWHFreHc5a3NsWTk2SUZ6?=
 =?utf-8?B?QUpSaDdFL1liQ0EwTHNacVNCTGhya1o1L0NZTEF6N1NIT2RlWTVnK3VWeU5k?=
 =?utf-8?B?MS9oelVNZUprVEtWbXVnN25LS0w0QldaajB4YjVDUnRFZ1NCcENoWmdYQmJB?=
 =?utf-8?B?ZHcxOWtXSTl6bld3UTBEcHppT3NkenltQnp3R1BHTk5PcXRsRmM3RXNjQTEx?=
 =?utf-8?B?NmUveTZjNFVqSUpXelR3UlhkUzlhYjRWZlVlUmhiMmVNMVNhcXNRMkJ5UFp6?=
 =?utf-8?B?bWVzUHh2d0svbFBMZmFpZHRIbGJnUUJsdlZmY25xVjRsZ3haSHpYbmNMVStE?=
 =?utf-8?B?Z2tZb3VWSHZrRDdQTEpEQmp5K2hwMU92ZkRBZE8zZ3oyR0J0OWJid2drcnp1?=
 =?utf-8?B?K01FSzBneGVQVE9PYWlJM3FLbW9jamU2Yno3SDJEZ1dxQjlnUHhzYVhnSW9x?=
 =?utf-8?B?RnMwWmo4b2U1ZnE0NGlwVXVycDR0VGFDTkovYU5zRkJWT2g3ODFxQi9ZSEc1?=
 =?utf-8?B?SjZJMWhBNFh0cGFXUlNHMnZFL0Z1OC92aTE1SHhhVEJFME9laXlYVlgwKzVR?=
 =?utf-8?B?QlRUbFA4Q2Q4WHhWZ0pLTngyWGJtNDNQRjZkdE5Rb05BS2RuS0F2Ym9zZ1Ri?=
 =?utf-8?B?NThhNlhYd1hpWFVYS2ZpYXRhVkRjdXJRZnR3VlhldnFCS3Y3aXE4aGx3azMv?=
 =?utf-8?B?UjNhOTB1YTVVTWI3K1JMeTJqYi9lWGlrY3Z2RG5Wc201Tlg2UlA1cGxpY2N0?=
 =?utf-8?B?S0d2OEZkdTgyc2ZDcXJ3Nzd1bUhuNkhmL2o4V2JzWFRYRkc4WlZkVHdneEZ0?=
 =?utf-8?B?R1ViejRZTktMNUlUdlZzYjB3MnhlbWJ0SVByTW9RNmhxQkU1bGk1T3BLQnNh?=
 =?utf-8?B?aUg5Q1hBK1RacUNDOVIzeUNoOHpxZERVU1dEeDBKS3FmRkxsSDVoTnJYQTNI?=
 =?utf-8?B?QlBadktpOGFDdUVzVzRuNU5XQWdDRWV0NE43OGF6U0FOUkhoaGMvR3BlbStn?=
 =?utf-8?B?bG91eUNmSHFEMDFhNWpvdkMxaC9oRGVGRkRKU1NtNUJpUmhzTEg2NjJEM2Zs?=
 =?utf-8?B?ektlUnpqVGRTQ0hSU1BpWkdhWkVDWEs4QTR1OXNPWnBBSlZjd0pCU0ZYaC9y?=
 =?utf-8?B?Y2FYRzM3aU1GbjhzSjlCaWJndmlSL1VaZ3NvRm8wM29Yc25NNE9FTE43YnlF?=
 =?utf-8?B?QmFGNnQ0M3cxZ3d3MmQ3a2FXWDRYdFJjV2lMTm03NlcvYWpMVEM1MVd2cDd6?=
 =?utf-8?B?R21jWHZxb3RKUGJzbUlJVE1vY2dMYXdKNmFlWmRtdkFIN2hCdGVnMThnWVhI?=
 =?utf-8?B?UTVUcXphbXc2TzEra1FGUkFXd1lZNExVUGk4VUpnMTkxR0d2SHEyLy96U0FD?=
 =?utf-8?B?TzAvR2NSR3NHejFhTFJTdHR6UnJ4SEQ5MnhwamtDbDBEY1RIOW11M2h1aWFP?=
 =?utf-8?B?anArOXJNYUZhaC9MRHdDa21BeUV6Ukw0WXRwWVY0V1dDR0NaaklBSzk1dW1G?=
 =?utf-8?B?WmNzK2NucDBTem5HaHM5K0poWHczY3ZxblJKL1Q3N3F6eTk3NkN0SWU2YU44?=
 =?utf-8?B?VU5nMFkrWkxoSjIwVXl4MXBZUG04Nnk1TU45Skd1Skg4WkhFMDdGOTdkVklT?=
 =?utf-8?B?LzI4SEE2Q1JhaDFuaDFnbnFsbVdrRHdIVC9jK0NXQzBGeVlOSytkRFkycXRu?=
 =?utf-8?B?RHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 246e5a29-4d0d-4ce1-0620-08dc764c596d
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6589.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 08:35:47.1722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FIxUzxZUP/5pyJuQCQSTpfAJLpQKxC0fWQIUZSLOyv0R8+OK9XA/Anv+rHFz04JSKb5Nc8s6kCJDl6wEwkVulXEdpFEgb4CdVODBNEyNG5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7388
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

On 5/16/24 10:34 PM, Tom Rini wrote:
> Document the logic of when we do a full resync of the device trees used
> by OF_UPSTREAM as well as that cherry-picking is allowed as needed.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>   doc/develop/process.rst | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/doc/develop/process.rst b/doc/develop/process.rst
> index a66540a698c1..0542b3fc1245 100644
> --- a/doc/develop/process.rst
> +++ b/doc/develop/process.rst
> @@ -108,6 +108,19 @@ Differences to the Linux Development Process
>     In U-Boot, ``"-rc1"`` will only be released after all (or at least most of
>     the) patches that were submitted during the merge window have been applied.
>   
> +Resyncing of the device tree subtree
> +------------------------------------
> +
> +As explained in :doc:`devicetree/control` some platforms make use of device tree
> +files which come from a git subtree that mirrors the Linux Kernel sources
> +itself. For our purposes, we only track releases and not release candidates for
> +merging in our tree. These merges follow the normal merge window rules.
> +
> +In the case of specific changes, such as bug fixes or new platform support,
> +these can be "cherry-picked" and are subject to the normal merge rules. For
> +example, a bug fix can come in later in the window but a full re-sync only
> +happens within the merge window itself.
> +

Can we provide an example on how to cherry-pick those changes with a 
command line?

Additionally, in doc/develop/devicetree/control.rst we say:

"""
However, if `dts/upstream/` hasn't yet received devicetree source file 
for your newly added board support then you can add corresponding 
devicetree source file as `arch/<arch>/dts/<name>.dts`. To select that 
add `# CONFIG_OF_UPSTREAM is not set` and set 
`DEFAULT_DEVICE_TREE=<name>` when prompted by Kconfig.
"""

But now we have a second option, cherry-picking upstream changes 
instead, so I assume we should document it there as well (or 
cross-reference?).

Looks good to me otherwise, thanks for clarifying this new process.

Cheers,
Quentin
