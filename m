Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BFAC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 09:23:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68E8D84A49;
	Mon, 13 Jul 2026 11:23:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="i2/ZHWvk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 980A584A51; Mon, 13 Jul 2026 11:23:37 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84C0284A48
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 11:23:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpI1ikOe9XYXYxzy7CZ7T2zDgqER1NzN8Y3BYqYuCPS0Olid6IeEb0sRsEOrV6B9YrWGpA+a+DtFf8KhmVkj0COrH1/nV7uz42hTgJ8wIuCkMfzMGnZUSBPBNq98gOpIdWWPf74r3pDbSDLCQ0M0SlhhnbffO2aH171gf8IlOFtMyEXSC1jihUSsrS2bQ75yf+quoPfDlb0OTYabAMo9JD9Huw9/2iOEJFM21LvQKf5Q0WkXtDS+5bTxXlAfeHdkvJTRtPh0Z1K6DLUrMW+Y8M1xrHuSqujhcJXUqyDcFk8IXS3v7xfd5syKtDK6VM3FG92u6rtN+wJiZyzcDSy9VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BED5bMUQPr+fhD7s+LPiHAEuYChSbs8FL9mrX8NsJX0=;
 b=UCkzqbAbbhTYGnPXPzd6jj3oMn2ccQkz9KP5TjOFx132HgPIVmNC/LdBkLHABdYfyDzTsnkqb3Z+ZJFB6buKBrT/RAZK+1uIVliw95fAqPqKAGJdPakXN0+GDrlN4qngjjnWDGvV8sXUxz0avHfxR7rkOii9hKIK+MLviD2Dxkg3Xds448e44uNPzAX+chgPYj6o27N84Y3E1U9JPvr16/QJC8pnhtfIT2JH1RlpfEIDcd/kTh3IwQ2R4yLCRGhOE1hKHOtL9qvsgv2m32MCSzTyRiUCeRuAAdY+Mbr325ezdOF7njUydkqfDextNvmxGPJTsgHClF+1gmFCDyBFXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BED5bMUQPr+fhD7s+LPiHAEuYChSbs8FL9mrX8NsJX0=;
 b=i2/ZHWvkbSDdC6jyqNJeopo9JfNcMDecCzwZm2OHBZtjT5lcTLCuIOht+gEbKfF5Xgo+FOrd/T9aDXutCkHnel5TtiKrQW96zcYwI7GXBSauYIMqJTJiksk0Vlqp1rGe1GVXow6bSfW/sOmjlHBUMeaAdqqyxH+BtAgVR5pnK6qHLn9cModcIuP8ALJkNpHcXk5PDFgz1KMAT2V/5RZJ87LDA/9dGmtS99i9dmRhGGDRP93utmlel2RuDyNrsdpDrewjr/f32eNm68OCQlh6/oD8JabhYjslaZfs+Gcn3Ul8Jz3Ap6dm7DUnx1+eFEDZDiFUv2lVd66qgO/tk3op1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CH4PR03MB7772.namprd03.prod.outlook.com (2603:10b6:610:236::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Mon, 13 Jul
 2026 09:23:31 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0202.018; Mon, 13 Jul 2026
 09:23:31 +0000
Message-ID: <9c5de5ae-0491-4ff3-b9e7-685c53bec837@altera.com>
Date: Mon, 13 Jul 2026 14:53:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] mmc: sdhci: fix align_buffer memory leak on
 re-initialization
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Jens Wiklander <jenswi@kernel.org>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Yanir Levin <yanir.levin@tandemg.com>, Eran Moshe
 <emoshe@gsitechnology.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Tanmay Kathpalia <tanmay.kathpalia@gmail.com>,
 Jimmy Durand Wesolowski <jimmy.wesolowski@mobileye.com>,
 Iulian Banaga <iulianeugen.banaga@mobileye.com>, Peng Fan <peng.fan@nxp.com>
References: <20260712-mmc-fix-v1-0-99a1136bbe54@nxp.com>
 <20260712-mmc-fix-v1-3-99a1136bbe54@nxp.com>
 <b86a6dff-b055-490c-88c0-bb320b97fddb@altera.com>
 <alSlDBuE1fMQwZ1g@shlinux89>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <alSlDBuE1fMQwZ1g@shlinux89>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0117.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::20) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|CH4PR03MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e8d3f74-a3a3-4f7f-b4ec-08dee0c067ca
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|7416014|6133799003|56012099006|11063799006|4143699003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: +tnjx6O/3BdXtOc+rcvaGfbmjI7CCmL3ZrcMaxvI19jmtm8LcrRqfZsJB1TQ6Cur475cM+/eKmRVXwXGr1QZ/fDA6NpY0kqCWJh2krrPiUnSZWlRNxF1f5w9vOybtD1PSeXKkpV3lYQI+QmTUScJBtI7tDi3oFTjRFNGzJE2AqtdX2LEoVpUAnET6hevxdJp9zrSSSWTE7bGuknoG5y5SL3cyTast6CbwMnjvQk9A5diVFZ52mwaNRbGyd1MtnBUFOL9e4z8I6kJgSVoCojFeZuJ8hyXBRZHaTIFjaKvpIvVIUB0T0fpBodDhQgIMPuuxCrVrU8+OJTDIeeI4CoQNsJqS7MO4mgFVrU0lqaARYzuw90AOD9RPRzDXx5eM57Mkw6KSW+g6y2hj+f22f/Y660wR4p81zRGdjjtwFqz1i6a/6VjerC2jrAt4Xt3vsQgPWNYvbwAyf+MlGfnBegFubqMO94EOZUkgS8q7KDKZb0lIRzaxbCvx2wukb1O3Z1UqwdxHGA6F4uRMVhyAt6x8QBANYLADfR3lcehqQ6BJ7LCOk5AeGqsiwFdAhIk9up0a2oxptaO/Wqxk0NQl3NXNSTPq7CD0fbKtQLEtNxuazxjMVA0yZASS7EgIXg7a+FlT+1QREghzUrF6N4b2C5ECkkAed9U+FzwoYUwrHpjN/I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(7416014)(6133799003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnZwbGtvamJSTUxvZEtGSXRTRkN1SEwrS0haaDJqZEFrdTRtRWdORDdKY1FU?=
 =?utf-8?B?VGV1dTFVRUkycnJpSjloWSswQ2FkSkJ6T2d2d3V3cGllRU9FeVQ4eXBpWjJG?=
 =?utf-8?B?bENpMG9NK2wzUjRRSnYxOU9RSEF4bEwzSXJwZHhsUGhCUVlBRk52L3M1WGRY?=
 =?utf-8?B?MkJZYmlCQ0V0RVR6VWZpVjFmd3dnTXl1QW5CZkNITHRlajBEYVRiUEVjVDRS?=
 =?utf-8?B?L3Z3M0Y1Z0VXQVZZK3JZZVQ4aUJpVHVncnUxM05KNENpVWJ2aEs4alI5SERP?=
 =?utf-8?B?S054TDZpSzdmYTRIaDIwU3JEMGg1SmJnRVQrYzhBeFV3NkxOaVBsMG1EZlQ0?=
 =?utf-8?B?WU5aYkJzeXlCSGNTbC81ZHFMTDZoMHJlZUpjc1BRVjFhTWZFbFBjbDhhWnF5?=
 =?utf-8?B?QU44dTA5RGxjQnlkNTZJQ1pkWGpDZjEyRTZKaWk1V1FKaVRyQWkyWTMyMUVV?=
 =?utf-8?B?dnZtdDFYOGQ4M2NrOXFFaW90OXFZRHhlODRiYjB0Nm5nWXovMnlIRTV0K3B5?=
 =?utf-8?B?eFNsTytEeWNYdStlbittM09ZWUluNkxuZXBFdC9pM3ZjZ2w4ZmtSdFlxSXJL?=
 =?utf-8?B?ajE5Y1A3blBaTXNGaHNpQVdlc3VHTzk3NytxelFIWElNbENadDB6eXFKL2hD?=
 =?utf-8?B?c3RKRnJCU0Z6aDVQZ2M4bTFNTEFITFU0akhnK1Y4WkxtK1VnOE53WWgycUx0?=
 =?utf-8?B?ZjNHZ3hOdFkzajJtemdta3NCOS9LS0N1ckdlQUZPb0U1Wk91SWIvNnBVK2Vx?=
 =?utf-8?B?bExkd0M1ZGYzQ2FnVWViVVNFT2dkR1pWQU0zRWVvYnNvbW5mVHU2N0hEL2p5?=
 =?utf-8?B?amp4RWcvT2FCWWpvNGhUL2RzcjArd3VuVHVjeEVLUHpvMnk3UThERDFVU29E?=
 =?utf-8?B?bEpoZmxYVC9RSkQzMC8rZGhDbUxSSEszbEh5NC9JSCtadmNHZWhkNmcwRWZB?=
 =?utf-8?B?TUJuTTZxTDR4Tlkxc3JtSHlKTUpCQkhwMEdQMmFZYW4wcFNLZWljSmZlUGZE?=
 =?utf-8?B?VktIaWozaDB1bm5WMDhxSG45V1JPV0Y1RnRadTJkUFg4SXp1STBadTZSUktn?=
 =?utf-8?B?VlhSMzhweTdnVUNZZUgzM1BDSGhrNytkL3ZxcmJHeG1EaWtBT1pPMVhYaUp2?=
 =?utf-8?B?TU82UVpNblNqNTd3RHdkbXZYWU9uQk5KL0pQaWgwUzBXaG5lV0hZYUYvUkZT?=
 =?utf-8?B?MXhKWXJuWXdEVHFQMEZpQko5NGV4Zkw2RXRmTXQ2VHlQd1R5UzdpUU1kL2Vl?=
 =?utf-8?B?TGxIWmJCMURWZlV5MWFuYzlKRkV3ZnV5Y0JVaDcxSEx5bzJrUDRlbGUvOThH?=
 =?utf-8?B?UGt3a05zR0xDMER4RjN2RmNyZHpsczZHZ3p0T205UHVxejRJNFFqb0hNY3BG?=
 =?utf-8?B?eGdSek52QlpBQ1ZLL0lpeGlGZC9BaVNIbG1iZjlvSGZIYXM5alpnSnhlWE5x?=
 =?utf-8?B?RXA5YzFCSzdiRC9yY09JWVFDWHhXUVFNUmFmMDN1NE5FZDlNemJacUpkc2JC?=
 =?utf-8?B?azRkd1NmWWJqTGhxQ0p2bVVwcHlQWHJNUzJVck50end1OEVmZG9uU0plb3Nh?=
 =?utf-8?B?MVpOOWo0d0NIek42VTE4N05uWVUxNjZWMWdxYno4dEFvMlk4U29qL3F4WmFL?=
 =?utf-8?B?Mit0dFBENW9LeGJJcndFU3VoZnVTaUx4d1ZaSFMwUmxrZUFqWU5LOTBBUE15?=
 =?utf-8?B?TTRzT1RxVXRYUEpaeTlZYXl1TzdrZ1ZsYkM5V20vNTVqaExlU1dqdUVUWUls?=
 =?utf-8?B?YWZMZ3FjT1ZWd0cyVkZwdDJ3V1VkMXdpYlM1TFlLYjlPQ3lXc3doNDNJVS9H?=
 =?utf-8?B?UExaNjc2NHhjSXFYcE5IWVhXRGo5bCtHcWErSFgxTGlEMWd0czVDY01aUzdH?=
 =?utf-8?B?TDFmdE9ic2dhbVhMTWFJQTdzWU11WU1ySExzTVEzTUc4ckVndm1tVXRRUGtN?=
 =?utf-8?B?d09Rb1EwVXlSMmxRUGV1UTA5cjlOcFRQVDExODQ3NnlEVENNZ3d3Um0wUk5t?=
 =?utf-8?B?ZjhJaXlXVStmamRkUXFva0hWOGsveVZmeUVZYnRmcVAyZHJYS1Y5dXQvTVlC?=
 =?utf-8?B?RVU2RDlBL01vRTBQa2ZHU2VCWGZFVFp1OVlleUI0K2duKzgvcnIwajhmcjd4?=
 =?utf-8?B?S3Q0ejZJY2tDcnpscVZmcUN3SWNZZ2FIOEhUNUVqejRxU0cxSE80NkdLam5j?=
 =?utf-8?B?eCtmcjhoSTZ6bksxWWo2T0RpWmgvRm5MVVgxaXk3aXp1OGtMa1RrT0NGS3lG?=
 =?utf-8?B?VjdRUWZLaHhheWJNVEJQUi82Qytkc3hwaktsTkVZTHRoK25SUlozWDFUd0M4?=
 =?utf-8?B?aTlpZ09VS0ppVzlkVmZESUJCWEhCbkVuUENmd1VHSmk3dEFxRG5mN0t4aitk?=
 =?utf-8?Q?Kof5d7J6GWI728Nk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8d3f74-a3a3-4f7f-b4ec-08dee0c067ca
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 09:23:31.6470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cUe0dCmIxQwvLGA5E6A/gz1cRGGIOB2ieC9gzfkOV22L5kEhErHVWPH3wORFWA6H+b64k67QrNKn+n2gPOxqMMq1OJgM1vZExqWm2ZX2Mt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7772
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

Hi Peng,

On 7/13/2026 2:12 PM, Peng Fan wrote:
> Hi Tanmay,
>
> On Mon, Jul 13, 2026 at 12:20:10AM +0530, Kathpalia, Tanmay wrote:
>> On 7/12/2026 6:37 PM, Peng Fan (OSS) wrote:
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> sdhci_init() allocates a 512KB aligned bounce buffer for controllers
>>> with SDHCI_QUIRK_32BIT_DMA_ADDR. In the non-DM code path, sdhci_init()
>>> is registered as ops->init and called on every mmc_init(). Each call
>>> allocates a new buffer without checking or freeing the previous one,
>>> leaking 512KB per re-initialization.
>>>
>>> Fix by guarding the allocation with !host->align_buffer so it only
>>> allocates on the first call.
>>>
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> This should be R-b or A-b. I will use R-b if no objections.
>

Yes, R-b is fine.
