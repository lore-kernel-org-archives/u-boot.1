Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61025C02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 12:16:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA2F0800C2;
	Wed, 15 Jan 2025 13:16:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="hCADN117";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55D3580214; Wed, 15 Jan 2025 13:16:40 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F197780040
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 13:16:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJ2gzXTtO9iXXHFz72pTX2ezrEtgOVHhM7IECYFpFs5nFxlEsjzUr7dgsbUZ9fRo8f0DwFolKJrnZrpTXdovyme63Cuns3h4zkwM8bYJSJ32BbQ1p1Oe3euxwxvoYheJCXhZervTPnq9JQLxasGNoyJZ/Z7nyc3pPwrtolX5iec4F3/RdY6/yD9CNBgVDjnrUhMQapA3IvheOy6Xu/dnUtYJlHFGaMNG1d6q6ijTUszKXqw9UcWn/uiQKTBQ18cNTKFfYhf1o2ZDiy61I6qElThE7AvaadDAkzG7hv3tiVIVZq0Q0sbi6WSBf8alLgpmbhFEaaXFf1Y9TCXLpAnLSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2a/ghRpyCPkF9EGb17IZZgHTyzNT0km90yP5MGwg7U=;
 b=LelEqDETH8woAzY/9wa022ycAqGUfstwpF6oEu9SqaZZmqRM+yPtSA/VyIc/IZsYF4Hg14p20TKdjmltXYxEusM1elxiqcJfSdm9qFLOLsuGCUgIRnZsX18tp3XjywsAeZNroOpau/AeSzTwj2PSbu0QFlbrK5xWimCdmayl3WjibY9OE8BYE2+Dhje1fqwwIoiW40z2y/ehhlpCjS/frWpGdGfDovi48fAOg0R2ugJ2LrV0HqCBetaFVoDEhcAx+vhvSXEJ1D4OVOBUvRH0kZVCCCcsKYYf4SLLBrp5AGEnSwm8iXhM4LVVxEdBXVBuHQXEO7i+ZNe40XCy2HY4JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2a/ghRpyCPkF9EGb17IZZgHTyzNT0km90yP5MGwg7U=;
 b=hCADN117jU8cEiA0S1FM3GEp1RMTrk5XA+1W2h1N+KhqK6IOeu/JRw+fkh8b6K2cUikoPY9YY2qY4AUT1p2w6i82Z/lcYkA/XX9cD55Wam9Ipz4ykFCgdF4f85hwN27OcwhjBMiJ4Jn1+B650uR27z0ftHy4a4MMX9VCNKd4uqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB10442.eurprd04.prod.outlook.com (2603:10a6:102:44a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 12:16:36 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Wed, 15 Jan 2025
 12:16:36 +0000
Message-ID: <1b0d38ab-28be-47f7-a41a-cf6e36c953bb@cherry.de>
Date: Wed, 15 Jan 2025 13:16:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: Remove redundant loading of image copy start
 offset.Because the beginning is already computed
To: 1425075683@qq.com, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, Tom Rini <trini@konsulko.com>
References: <tencent_CCE8303926957C427AAE06F9D91282458109@qq.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <tencent_CCE8303926957C427AAE06F9D91282458109@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR04CA0127.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::25) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB10442:EE_
X-MS-Office365-Filtering-Correlation-Id: e131f22a-4f9a-4e4c-4d55-08dd355e74cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VG5XQWFoOTZpVUZaZXRYRXNWSDlDN1hnRno0Q01LcGczanpqSXViNWJLc09Q?=
 =?utf-8?B?WU1UcHpMNmZLV1IyYWdvYkwvQVN2NWxJQk1tLzR0VFZrM0pSSnVTZURZQXFn?=
 =?utf-8?B?aW1RMll0QnhOWTdyOFpaS2kvRDd2d0N6MWZIb2NRVzVmd25GcjJadlFmazln?=
 =?utf-8?B?UkZwQTUxMWgrRi9wRVFZRGNuMGliYVI2OFhxWjBSMVJFdCs2cUNraUc3cFBa?=
 =?utf-8?B?NTBXTWthTVRJdzY0KzYyNWFZVWNPS2VBMnhCZ2NnOWFTcDZaME5hNytNYjND?=
 =?utf-8?B?SmozRXVHVlh2clQzNnBmTUlWamJWanljR1hmREM1M0ZvWXQwODRjQmhQNFVG?=
 =?utf-8?B?MHR4Z0tKZWZaRUhRVDhNd1h4VkJSNEhsWWNnMGIvdHpqbTF1SlZ2SVdiZHlt?=
 =?utf-8?B?cks4eTljdlNhL2NoRGVmU1ljOTJVZ0wzWUo1REd4TTRZTkFvZ1NGK1k5d1U3?=
 =?utf-8?B?TWRQUENpN3YvYUpGTm9sTTNESUtvN0h3ajNBVTJFOHVoTk9HTWYzRG9ZSGls?=
 =?utf-8?B?cDNyRGw3L3RaVit6Zk9iZHh5Ri9rVVRxNEhKMlhiMEhVMTU1WkQzaVdBaXlN?=
 =?utf-8?B?QWUzZzhjMjc0WmZjeWVDZ0xsbUZ0UEx4NVgxRFVzK1BnSmxXNFNObTN5eUxP?=
 =?utf-8?B?VUZTQ3FmMU8rc1l6WWw1aURab0VrWkJjUVd3Zk9PbkZCYWdqdS9sNjZNYjFM?=
 =?utf-8?B?Ync5cFRWL2ZaeXFRYjArMlZrWFdKbmpIV1FTbENhYjlSN2dmNm8raS85UTh1?=
 =?utf-8?B?ajZFMHREWHJNV2ZNMkhoRzRIeTdUdytxempKQVFrZmRqcThwUEw3dnBJblI2?=
 =?utf-8?B?UjVFcWcySWJidkVxODV6M0d3YjNYN0ZGeW1wL09NUWhNU2Vrd3ZBUFN4UGI3?=
 =?utf-8?B?QXJjUXgwKzBqTzg2UUltRVlyNy83MGZ1YXUvdDFFMnZvRmZIMytDM3M3R2dp?=
 =?utf-8?B?VytKcFpEUnhVK25zdGdVTlU4di9Tc3B2SG9FdzJjVEJuK3Zwd0lwUjEvOXI3?=
 =?utf-8?B?VWZMMjMwK21xcDE1dmZ0SGdzYXRUSjZ6ckN5cUVlS0FhdCswaDA3SDZ5YUZk?=
 =?utf-8?B?NitaVVhHMHJWd2VaRTRvdUMxbWp2eitzMFhnZDk3RXArRXhnSWJGUVNEOE9T?=
 =?utf-8?B?VVFPNVU4OWMrUnpMVTJPaitUbGpDUkdzNlpVdnJHK2l1d0hscTM5RkEvS0hz?=
 =?utf-8?B?dnlVYkl1ckZCN2dyREtNTFoxMG80NjRaQTZ0bWFUWFYzR0RhNyt6Y0tSNGdp?=
 =?utf-8?B?WkZlbzVUNHdDcTZmelV0SDVyNUJoTkdCMERUMy9WYkY2d0lUYlBkTHg5ZVAz?=
 =?utf-8?B?M0hEajJHWGozcW91eER3L0hZZlE0eHJ1a3prcXJ0eGNyOG1hczBzRDlSVDkw?=
 =?utf-8?B?NkhOTHR1eHZWVkJVU2hEb0lmYnNOWXMxK21DNFFEVE9RMUJZOTBWYjNCS0JO?=
 =?utf-8?B?TkczREg3ZjVoZDR3cGZ4dkprZllJcjlURnYxN0pLK3FuZjhmL1IyL2J4OVpI?=
 =?utf-8?B?L05IaFN3YXJ0T1JMV0JtSVpKb2E4ME5yMW5vWVFRdVA2Zlh2VThHRGhWbXJt?=
 =?utf-8?B?OUVST0h5dG1CaFRzdWZyQzVZUWllWGZBNjNuMFBGL0NmWFNoZGJWeXYxOVg5?=
 =?utf-8?B?WUUvZTJUVUM3V1NCN3FnNkUvam9NSDNlYnpJSzB2bHp2cEhRT3c5NzVJelNV?=
 =?utf-8?B?NTJENUIzbEVwSVVna1FpcHJCUnU3a2YxcFZhSnVPcVN1TWlneXJnVlUrY1FZ?=
 =?utf-8?B?K3BSSllyeUtWZVpoRGlMV0lyUmhYYUdYRGQ0WjQ1SmVEMFQyZUJPeFVtemd4?=
 =?utf-8?B?U0ZLMERyMWxDck9ETE0yWlY4a0VGQ3J3eHBld1F6MHpqQ1lsbkUxUTNIL04x?=
 =?utf-8?Q?LONCo8RBIGKtF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGptMUdTcVFUeDRLRngranhkblRlcXdMVHEvd1ZIOXpWSzNCYy9nTCthU1ZT?=
 =?utf-8?B?TnhpV25CTEFGZDAwU1BKekgrNDZtNVFWU3d1cXk3QlNEZ2lWUkxUOVZtRTk1?=
 =?utf-8?B?cVZKQ0x4OHdQcmM1SWFWb3BTR1Ezby90RWsrTThOYm1LTDFyOGRZRkJXMTIx?=
 =?utf-8?B?eEFCSzRrSkd4QnMvbGNFeWZ0OHVkQm44VmJ0ZDQwZ21hbUNrajRlMXBwNnhT?=
 =?utf-8?B?eFI5ajIyZk95RUQydFNVcnBFb2l5Z0lrT1BCQU1UMGNFTTg3K2ZiRURrMk10?=
 =?utf-8?B?OW9meDhCTnFhMTR1YlU4SUE3Qm8rZFdGcmlEd3VIeHpTRTJEVGN6TjJzYUxx?=
 =?utf-8?B?YmZYQXB5S1g1Kzdud2JRUnU0aU91RWN1cm4yMHA5RVQzYjhtQk1kWHRVeVg4?=
 =?utf-8?B?eHczTHdWWFB0S3QyTHBUYjdKZzFWSXYvcjlDdGVaN1hkWXFMcFpZaXVSSitM?=
 =?utf-8?B?emUrYnkrMy9LZTlLVDFhVkZVbG1ZdnpkaUNwYVhKazRUT1JLaE8wZmlkYk9q?=
 =?utf-8?B?WThCSXo3dURCNmRQb1NsbWFpeXdjWnVvM3BxN1p6YTVQaXRXbnNGdlUyMGZ1?=
 =?utf-8?B?ckFSUUgwS1A1TSt0VVc2RDVjK3g0aTNJYURXN2I3WmxPeVkrRlRYRnFSWWFv?=
 =?utf-8?B?a2g3WnkrSTUrRFhiRW9wSi9kRVphWDFDTmtRQVBtMm5HUkluclQ0MUIzeDMw?=
 =?utf-8?B?aU9Kbm1DUEpHVjZnTldPWExzOVRjQ0VEUU5LT1ZvQkZEdmJXSUpNU2FCbVcz?=
 =?utf-8?B?NFRva01mZjNrSHQ3S3IrRFF2dmxzR1FxYTZiOTF3aUZmbXQ0NjhZazgyd1Zv?=
 =?utf-8?B?U2tpVStzQzgydWJaU2k3d3hQQWpLcUF5dlluTHBnM25CWTE1SXZFTzcrZkgz?=
 =?utf-8?B?eEtTNTB0cElzcTU3QjlDdWVYTDl5dXYvM2ZEckJuREV5OFo4YjdtMzVnbDVq?=
 =?utf-8?B?a2Q0RUl5cXdNdmNCVFA3RzlwaWhaTk5meENENmU5SHFJdUcyTG4xUnZMMUtC?=
 =?utf-8?B?NFdNZHNmeXczZWJvOGltNDY1eURKd3dQUHJibmk3OHFKUUtBMHlaNEJIMUlI?=
 =?utf-8?B?RE1vOUtUNkFLbXlJa3FzeVpZdkpkeWRyY2svWXBUZ1MzQURzNGdjWURNUTFx?=
 =?utf-8?B?eUtWcWEwbnhlanNZQlJWSmx2TWhDSWFaWU5MWDBzRDZnNEwxSHJ0MXd4T20r?=
 =?utf-8?B?SnlqMzRMRmZmQU0rWElYdmNSckQ0QXlEbW5RZCttdVh5ZW9lU2pNVVlkOWFC?=
 =?utf-8?B?V2RJNlRPK25DQWwwcDI5SGhYVGNjVEJPRlV4M3UyMUg5VnR5S280OFNHcy96?=
 =?utf-8?B?MnJYT3VwRXU3elFJRitNdWhhdzdTU3B3UjMvUm9SQlVIcWk1c2FZZUJFS3Nn?=
 =?utf-8?B?aUZ1OEZUV1VWOUJsbHVQaENQUGQ3VVc0OWM5ZTVrckMvTWN2ZTYwVDhPaElU?=
 =?utf-8?B?cnlza3M2VmozNjVlcEhBZkM2TnEvaUZLVFE1L01CcTNRemVma2xSMy9BK1hu?=
 =?utf-8?B?cGFacnV4N0QydEtab29TMWNmby84WHpPNy8xK2lTaEVNNTVNbDltWnhjL0ZF?=
 =?utf-8?B?WkJ4TGJGWDN6S0FKMldTUk5ZR0N2cmFPUHM0TkFMMGZXa2twRVdMSnppYlF1?=
 =?utf-8?B?OXVvTmkzNzZ1TEJjVHdxNnRKT25Qb0tBRlBrUjN4SlpRT1VpY2ZLcWxpTDBx?=
 =?utf-8?B?bS9uVHBJUlVxYWVzYjVUZHAzQ3pNY0lvVEVCYVZ3RzdVY2p0Mm5WcjhVOTNQ?=
 =?utf-8?B?dk82L1ZQWStSVlZzaHZ6ZS9uUmNUdytFQjB5WkNkc0s1eUFuODBkbys4Vyth?=
 =?utf-8?B?U3dSbEJPVDZzdEdBeC9meS9VRmxNVktTZEdvNE85dnJBOHVDM2VWcm9hd0dC?=
 =?utf-8?B?QlRSc2xCNVBobVhwT2lzMURKdGZPRTdmYnBKUlJpNzUzY21YQWwwcHZGQWNK?=
 =?utf-8?B?SXlaUGpvRllSWjBlZ0hBQUhuZjk5em5RRzl6bFVPZHU2eDdWaXo2aEpITWtj?=
 =?utf-8?B?cXhHZlZjeXdxUnpSUk94RG9pQVNiN2N1TzZsWVNxQkpXNUJRQWJhVGFvL1J3?=
 =?utf-8?B?T2I1ZUFYSGRET3VFSGpLSWJQOC9TQnlQVkV0WEw2VU91N0xqWldLYjQ0Mi9r?=
 =?utf-8?B?S3pueWRmZ04xVzlUNkVBNFZKcVBYRVoyVkx0Y2Rock5QNXltTXc3M2cyTzhm?=
 =?utf-8?Q?mZDHT3TjWA32xEC0PftyqdA=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e131f22a-4f9a-4e4c-4d55-08dd355e74cf
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 12:16:36.1986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ixKoanuiPlyk18CqfB1sJ3k3acLcPBjgAocIeXMSrhVx1Tq4T0HyBR5mQhKL+6RgGJx42OZ+xtRhS816IR/nTBJILKxyh1NpzCdT2us61MM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10442
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

Hi Liya,

On 1/15/25 2:56 AM, 1425075683@qq.com wrote:
> [You don't often get email from 1425075683@qq.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Liya Huang <1425075683@qq.com>
> 

Please have some commit log in there justifying the change. There seems 
to be some issues with the commit title so probably part of it should be 
in the commit log rather than in the title (one needs an empty line 
between the commit title and the start of the commit log when editing 
the commit "description" with a text editor).

> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Pali Rohár <pali@kernel.org>

Same remark as for your other patch 
(https://lore.kernel.org/u-boot/3d51107a-4761-4de8-9bae-a462c2a8e890@cherry.de/), 
pasting here what I said there:

"""
This... is odd. I don't see an earlier version of that patch and your
name/mail only returns two patches on the U-Boot mailing list. I believe
Reviewed-by needs to be publicly given on the ML as they are a proof of
review by the mentioned person and is usually a trust mark for
maintainers to merge code. Here it may have been added without Simon's
consent. Now imagine Simon is not answering for a few days/weeks, the
maintainer could still believe Simon went through a proper review and
merge that patch taking that into account while no review may actually
have been conducted. This is making me uncomfortable.

[...]

I'm not saying review wasn't done properly, but its acknowledgment
should be made public by the mentioned person instead of being put into
the v1.

Have I missed an earlier version or discussion maybe?
"""

Even odder is that Pali has explicitly requested to not be receiving any 
mail from the U-Boot project anymore, c.f. 
https://lore.kernel.org/u-boot/20231106090908.7938-1-xypron.glpk@gmx.de/. 
That doesn't exclude him for doing reviews of course but that is still 
odd. I'm explicitly keeping him in Cc here as I am not sure this went 
through the proper review process and he may not want his name put in 
there acknowledging something he might not have done.

Cheers,
Quentin
