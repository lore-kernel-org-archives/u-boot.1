Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DEAD68B18
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 13:47:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47A888961F;
	Thu, 14 Nov 2024 14:47:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="gn8oDtJu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC8C9895FF; Thu, 14 Nov 2024 14:47:00 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2071f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::71f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADFF18961F
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 14:46:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Klvcs7zdVG8hiYDFXFYBRtsC14zn8aMYUp3BbbCkHSC4hMW8f1Ic1m9i+OJ/J1hm1647FrOAF7FdtIArlhyJ0fXcuzmOwF4PD5GuugyTKiLepoZls5x3WJpae842rwrYNATokXk3w7Wd8QO2XXjPX6NC+bUszTQhLYqCBUeP/8rh33bbYCf6zZUyoL7YaGyuWwU5ooMF9sIokg1bJ9ICiq3uMx0lNt4b/hJgTyOAs8HJTTlEgNLB4d6/Hq5veSz4xTCZ222tMZLn6gGmQ8ceZyMV3pdA9DpSrWGwbBzbLAHbNUgFSZj94gkeGvvmNCl2bEapJ9CigO6EsIM2GAdBqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yeWEl0O/bpdl5jWair3x93s9cnQlp4bKTOEcpG40E4=;
 b=vwqm6GoBl9tX+NEeKLRaAVPtZ+w0xOy6/qxykJQPcxLnPOetkRTNURhXcfOBvXrsh0ir4GfFRcHEUyr10oANxKl3RSSsX8yxImK+yowruaQ673+o6tJiFl3idCX7Yjr6GnmOzT8UJ7QbIt4535pnfBmiroCCjkfLxt22VF1mOBHVB2Qroy/gt4fNn7xWiWkacGDZHyyk1XNrtaMomHd8deyc4tSBIt5kjXGlTYWCicgDoS9BhP20jk8pUvyUoiBWrPlm6wa6y/LPOSmaZn4b6EPupfAl0RP1a1cUdKOFG7e4vgjkjo03wQQ60pSzcOfwtEZGCjjVCBiERGEeMgLOhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=nxp.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yeWEl0O/bpdl5jWair3x93s9cnQlp4bKTOEcpG40E4=;
 b=gn8oDtJuouahViAa2ScwUJHj8kxuBouR3c4xiphV41mfcy4THCPals8lQvK8SaXdQTxE6j0XRofBOODJWwN5oEyRAioiO1MyANrr1QKRO/+QaKVJ91hh8BXyrqWdsz8mh/s7EF8JoL1Ub+nVXZSSu2+TO9Haqh1DuZRyFxkUFT0=
Received: from AS4P192CA0032.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:658::15)
 by AS8P195MB1222.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:3c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 13:46:55 +0000
Received: from AM4PEPF00025F9B.EURPRD83.prod.outlook.com
 (2603:10a6:20b:658:cafe::ae) by AS4P192CA0032.outlook.office365.com
 (2603:10a6:20b:658::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Thu, 14 Nov 2024 13:46:55 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM4PEPF00025F9B.mail.protection.outlook.com (10.167.16.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.1 via Frontend Transport; Thu, 14 Nov 2024 13:46:54 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 14 Nov
 2024 14:46:54 +0100
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 14 Nov
 2024 14:46:53 +0100
Message-ID: <fa2b44ee-a717-4b98-ab08-c77c17255f77@phytec.de>
Date: Thu, 14 Nov 2024 14:46:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] board: phytec: imx93: Add phyCORE-i.MX 93 support
 for all SOM variants
To: Yannic Moog <Y.Moog@phytec.de>, Christoph Stoidner <C.Stoidner@phytec.de>
CC: "uboot-imx@nxp.com" <uboot-imx@nxp.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "festevam@gmail.com" <festevam@gmail.com>, Andrej Picej
 <andrej.picej@norik.com>, "sbabic@denx.de" <sbabic@denx.de>, PHYTEC Upstream
 <upstream@lists.phytec.de>, Primoz Fiser <primoz.fiser@norik.com>,
 "m.othacehe@gmail.com" <m.othacehe@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
References: <20241113160037.65679-1-c.stoidner@phytec.de>
 <20241113160037.65679-4-c.stoidner@phytec.de>
 <101fe07334f7d7b74c226c045bb175b1cbba7e43.camel@phytec.de>
 <2b1aec9b611a3106a4c59b53db2e84a697791f8d.camel@phytec.de>
 <c44edecde5ba3d006baaa0c58a45f1f6c5476260.camel@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <c44edecde5ba3d006baaa0c58a45f1f6c5476260.camel@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9B:EE_|AS8P195MB1222:EE_
X-MS-Office365-Filtering-Correlation-Id: 03361b00-b155-49b1-dac0-08dd04b2cd2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0Yxamh1UkZiYkM4N05EQVl5eFRJN3E2WDJyNCtpSjNMelQ0NUlkNzd3QVQ2?=
 =?utf-8?B?bGtsQlcvbHFnTnlMbzB3c25ZeTdUa1h6ak0vOHgzWE5WWXJUOFlSeW1oeENO?=
 =?utf-8?B?d282RVZMcWp2WnRiY1dsd1BmelZYQUZZRStSMmV0SFlMMkp4QzJaTGhuZVhj?=
 =?utf-8?B?WmtiaS95dFgxYlFYQWZmU3JCSnJmbmpDRHNWdlpXTThVenBoeXBrSjM1bm9a?=
 =?utf-8?B?dWJkR2VIMEU1Vm1DMEpkTHBJdU1hMHNDMDIxS21qc2Q0bHE0Qk5ycDJoUmZo?=
 =?utf-8?B?T0hDbHZ0NE96eDVmcHZhRHAwdE95ckRqMHVKN2p0a1E1clhXaktDWVJmVmxq?=
 =?utf-8?B?V3VOSzF2SU9Jd2JSQTZoMW1nUDNCTjJoc2M3Y1VHelpiUVVzaHhVbFAwclFh?=
 =?utf-8?B?bllqSXJYRjVBWkF0czNDQk9MM3RIYzVxQTNOWWVBWkFBKy9qTU54M0gzekxa?=
 =?utf-8?B?blgwcWZFM0ZoUUdNZk43Szk5SWxubkFobTRSa0t3cnJrUjBuelhXanVNb2x4?=
 =?utf-8?B?RFNGbk9mNXFNS1J4MW1oWGZHRk0xNC95Wmt2bkc5QjlJODN1eW1lWm50eEVD?=
 =?utf-8?B?ekZJaDFVbWxwajRYakVFZFlOdEYrT0ZpdVFiYTlDS0Z1d2FZQjZZeHVjbXB2?=
 =?utf-8?B?eGdZVDZvRVBKb3pwMlRIaGJrK2FHdGpTRFdiMFZNVnJSZ1VJdGtqTGh1YWtK?=
 =?utf-8?B?akF5cDMvK1RVbUtpL2dQRVBSOVhXQXZ6WmhwLy9rMG01RnRFOXVoVGdzQk1j?=
 =?utf-8?B?SEtMV0ZBaG1VdFZsaHhBL2JCZmcyalJTeVEvaWNOZ3RPblQxTHlucXY4RW1v?=
 =?utf-8?B?L2FCaGQxYWtyeDBRZ0xvNlhyZ2tWVjc0ZVlVRE9tRlNpYytqcHVOQ3hkYldT?=
 =?utf-8?B?UTZDUG82ekVwcVlrNXJaN1J4R1lwMWQwSzM4SWtjelUzajY5SXIvK2pmQlNY?=
 =?utf-8?B?ekJ5emIyTUFaY2VTNUlabnVMVHIzVERvTHR6amFYOGFsaVJXZFJTc3RGem1w?=
 =?utf-8?B?N1F0ZWpkdUxrdmpSZDY5dlBHZWJsdlUwVm9NQjdKUGRZN2lzc2RRbjIrbkd3?=
 =?utf-8?B?OVhJbHhrQVp6Vlk2UXpLSXQya1haNDFqV2JxL2pzY00wU1RuSG8zbmJYYmpi?=
 =?utf-8?B?azN1M2ZlY2F4QXoxTEdFTlplRXplNFowVndpcmtPUHJHRGt3a3RIUUE5Z05P?=
 =?utf-8?B?MCs5YWViSWxNMXp4WTgvc2dhcUt3czJPYW5vNTVZOUlOcFBTazVBbHZNSFRB?=
 =?utf-8?B?aUZCaEdmR1NOUlpTbjY1Y1JCQVdBUmRYQXNIRVlwelloenpEa2w1YXlmL2NS?=
 =?utf-8?B?MCtoNDFtUUYzLzdDZUJKVnVCdi9KcTFWdHhmWEhZY1lkaVorSXBZa2pvYlhQ?=
 =?utf-8?B?UDIxNG9OVHYrdVBRM3o0d3AxN24xM2FVaFcvSGhqQUxocEFBWG13WFl2dWhw?=
 =?utf-8?B?OWdXai9CMnRSV0NoZ3BrTEx6NnFhYmxRYXBzSUFmTmxqZUJuLzRYQi9ONS9G?=
 =?utf-8?B?TEV3Uk5KMXl5aTNhZXZnTTROVkF1eVprNk1ZRzZ6N2lMWDFpNHRLdnRaUlg2?=
 =?utf-8?B?aDZ4T1c0OUVqZVdzVVE3b0xQaUk1aHk0U0ZUQWp2cmcwTGVyU1pmUjA3cW81?=
 =?utf-8?B?YTRJUHI4RzJrcVRRdTk3QUV1NnlQMEFIN3Ruek9MQ3AxQklydXJWMEwzWVpm?=
 =?utf-8?B?NGI5Y05VdXlOMDBKTDB0bDVQWUNrQnB0TTJiWVFZa1NFdkZHa2NWRHRMcUZk?=
 =?utf-8?B?WDBpOFUxaUdnMkt4R3Yxd05oOXV1NGhxVkxZZmFocWRnMG8zcEF5Njg5dkUx?=
 =?utf-8?B?SC9XbGZSNGpnRFVmak9GeDVLZ1dtZlhEWkNRMEtPZWJVckMzSFNVTUlNdW52?=
 =?utf-8?B?YWQ5YzA3S2c2eXJnbkdmbk93WVpBK1V4dEg1aXMreEpDTkE9PQ==?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 13:46:54.9164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03361b00-b155-49b1-dac0-08dd04b2cd2f
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F9B.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1222
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


>>>> --- a/board/phytec/phycore_imx93/MAINTAINERS
>>>> +++ b/board/phytec/phycore_imx93/MAINTAINERS
>>>> @@ -9,5 +9,5 @@ F:      arch/arm/dts/imx93-phyboard-segin-u-
>>>> boot.dtsi
>>>>   F:      board/phytec/phycore_imx93/
>>>>   F:      board/phytec/common/imx93_som_detection.c
>>>>   F:      board/phytec/common/imx93_som_detection.h
>>>> -F:      configs/imx93-phyboard-segin_defconfig
>>>> +F:      configs/imx93-phycore_defconfig
>>>
>>> How will you handle this when/if you have another board?
>>
>> That imx93-phycore_defconfig has no more dependency to the carrier
>> board.
> 
> Not true,
> CONFIG_DEFAULT_DEVICE_TREE="imx93-phyboard-segin"
> It has a dependency to a board. That is why I am asking.

This approach has served us well for a while.

Most of our u-boot "boards" are designed from a SoM perspective. Also, 
customers typically use the initial carrier board as a reference, often 
following its interface configurations. So in most cases we are good to go.

I'm not sure why you want to bring this up again.
