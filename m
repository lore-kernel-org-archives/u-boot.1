Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7092C25B7C
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 08:37:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3937988268;
	Mon, 27 May 2024 10:37:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="PGk8E3Hs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52BF1881A2; Mon, 27 May 2024 10:37:50 +0200 (CEST)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0721.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::721])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FB5788261
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 10:37:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaZk0y7HIA5aFrtWRHL45chxGTeBL54g9Nerbe0sily+rc5HS+H33ghrL7pmDG9GD9MXp8h4o+2kbzZGeM1QsNkg8UdGGZ736DrTcKzlUFqMB7bNUqX0mbzPQmOlp/JusxxhJ35u03vAsXfJvvVuTIZgRnciliuKPJkQ3V6CdrtaJm8yCvKS0A/3Jl+EB2DX7F5gdsicJirgFRkregh4/EeU/5UJ4Q8RxqVIr9yB+7FYINHhFROYdyycqSO1xWKsShf4yR8DT+Rp5LScTZT2VGGWXx2TVdrMQjHXYRRMob/fN2sINmiGWy+ABprmKq8o/+cVeXxxZLEUjoDSExCaZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSXjGqwh7QmSyMRzCyj2nrP2ac3idvWzTsC1u2KUj8s=;
 b=MhQoDkM2NAeJM+dhlGd2oH3eUGwA6M4u23TjvUY4Z4HMWXL5SYji6NjtqqfVeajtWT6y7k7WGJ2kB5HPRWJYPhaHe+UWIr14PI6qWlr+W4wPV6JtfnCmDHTtISRxOalxngaDttqcBi/5D9UIrGFulRmO8YDev9rb+vMEI6FLR6ddFBk0wYDqX0PlqGSikQT36W4baW7lcZXRsvNh8EeosTpiOoMUQOkfNyA952xlfc5cuayaWk8K8moiv5fgl8K8KgJ1HrngEjLS3vN54TsiiefCrAYw90l34+fSXvf7oUyxBMzJWQS2Z3RSFaPoeExUC1YQZjV6X3W2zlGfTkmoog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSXjGqwh7QmSyMRzCyj2nrP2ac3idvWzTsC1u2KUj8s=;
 b=PGk8E3HsS5uhXp6lI2Op/f9O/hdf0N85srhgq/yciTJ8qm4kEcfX2ZKmofp3zP0/6eX5BgKUsPjVAD991fbhVV4VeIdTk1pplt9egWF4QJwS7ZkSFDBEZk/A8ffZPiOZ/s13tfWYQvtqIhcP2Ton8b54zl7vmU6Tg5EfT1C2NKM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com (2603:10a6:803:128::25)
 by DB8PR04MB6841.eurprd04.prod.outlook.com (2603:10a6:10:116::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Mon, 27 May
 2024 08:37:45 +0000
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31]) by VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31%6]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 08:37:45 +0000
Message-ID: <8b652748-00d2-4052-9516-c9a0b3825870@cherry.de>
Date: Mon, 27 May 2024 10:37:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: Fix spl-boot-order for
 edgeble-ncm6b
To: Jagan Teki <jagan@edgeble.ai>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Anand Moon <anand@edgeble.ai>, u-boot@lists.denx.de
References: <20240527063915.6205-1-jagan@edgeble.ai>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240527063915.6205-1-jagan@edgeble.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0038.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::8) To VE1PR04MB6589.eurprd04.prod.outlook.com
 (2603:10a6:803:128::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6589:EE_|DB8PR04MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: ab9530a8-2e5e-40ba-e0e1-08dc7e284814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d05ORGorUGx6alphMjBDRmtZMWl1N0QrLytxbW95czl6c1VPd0FlUXhkYlZl?=
 =?utf-8?B?V3ZTN3NJNVZKLzRYYWJqbXNLQnhoTG04YysyQXpnSXF6OGd0Qy93VlZYd0sy?=
 =?utf-8?B?Tm45ZkVZQndNRDk2VTFSM082WFJSemJiT2FQcjlJVm8vSEVuOUZzajJ0R1RG?=
 =?utf-8?B?RURlajdiNXZaWDkwaE4xM3Jia2hGWjB0VVFFRlJibm5DU0tHYkR0dEdXUXNr?=
 =?utf-8?B?WnZkam1qUjVwLzBHSzNFcUNpS0g2Rkp3K25RakxYWVRsL1pRbWROcWlNWkho?=
 =?utf-8?B?L284K2dYc3hEWVc3c1UyOE9IZDdLbXp3cEcxdmVZbkZRM3p3Y2pwWFZHelJB?=
 =?utf-8?B?Z3FhVVVpWXN3RkpZV0RjYVo3YXVIZVJyQ2JrTFlibWs1cUQ0QzRNcU1DNTlW?=
 =?utf-8?B?bTRqSUlGN1Ivcy9tNFlyK28zWkxtZS9mZEtrbEk3WGkvc0h5NWFLNHJkcm4x?=
 =?utf-8?B?SkljR0x4K2xuWGFiWUE2QzJWU2Viano4eXRhVjFXbW5KWE1JQ3RqQnBvNlZ4?=
 =?utf-8?B?L2Y1ZnNwOXVxOVNXeVBmRGcrZS95VjRJbUZHeWx1QmJMdEpYbysyamZmZUY3?=
 =?utf-8?B?RjdNdCtCV2J1K1k2eWhlbnJ3U1UwSC9mQmhZSjB5VHlCYnVwY2E5U0xGWSt5?=
 =?utf-8?B?SHVIbXdsRlNuSWlYSEFOWU9NKzlvRjA1MU1ramxHTllqQkVRUHRLZlRzVXNG?=
 =?utf-8?B?TmVvNDFmZE1kK08zMllsYUZFWTVTM3psRXkvNk84cjJPaFdJNXU4QjNMQjVo?=
 =?utf-8?B?ZUZUL2U0d2hlcHJrclE3ZEpsUUtRZXo1YWExSEVaMUdiTnh0UjhmMkE0MXhX?=
 =?utf-8?B?YjBHdXFKQWU5RW03SXFIT2tpZSt4OTBoeGZqZVdYRVgyYTBremVBbkZpeTJx?=
 =?utf-8?B?YXNvajNxdjF0Wm0vaGF2U1BsQUtieGxVV0cxNkpHT2dwdlJMQk1sZUdhMEVx?=
 =?utf-8?B?SmN1Z29QbHVXbStFOVlMdllMeUM3TlF4TERtOFltcWVMNFdxQ210Y1h0WnZy?=
 =?utf-8?B?WVY0dGJKNW5XcUozK3h4VExta1VHVFNRNmhLYVVPMDd1UGNLd3hPRy9kWXhU?=
 =?utf-8?B?eXpqankrdDk1MEVJUzQ2UHVZMFdnUmZtMDBvR2JNU28rOEJrMWZxY1JqeUlS?=
 =?utf-8?B?aC9DV1FsUU1CUHA1bkRGYlFoLzVhUXkwUDRXejIvL2NOYTFpaklKT21YV1E2?=
 =?utf-8?B?WEtpeUROdGhTTFRPMnJUYzg5ZGFoRFRXd3Njb2pkRTlwQ3RGWlhCYVpoWEVp?=
 =?utf-8?B?M3p6SU01Nms2V3MwYTlnN2trL1FFZnVvMDNISjB0aUVEZEVXeGN3ZDQyMWQ4?=
 =?utf-8?B?OXVmeFl2K3pXc25aKzFkWGxpdDJzaGNmZ0RUM09pMEVHb1lYalhMeGNYSTBO?=
 =?utf-8?B?K3NiSHNtVlZnMkNmUlRDNVlGNXVOZ2E2YkttbmhWbEs0WGFCcEdJalg3S2Vp?=
 =?utf-8?B?N1lPZ1ZlUUh1WndmUXpwSlFtaDU5ZGVlZzR4SGRBZkFZaG8yYjBUeEpsRHRt?=
 =?utf-8?B?Y2daM2ZOQ3dRUGF3UkR4dTc5Yi8vZ2wzZ1BobzE5Rklqdk4rV3R2NHM5T08r?=
 =?utf-8?B?NmJpWlAzNlZqMzJMa3hWbWxDbkhJN2lMeWN5UVdqZzlQcmpNMjI1T1V1ck5F?=
 =?utf-8?B?YmcvVDVuSzZlYUtWNVNrZ1dZaERLcmMwejBPS2I5UVh4L1dBMEdFenNzZ2Js?=
 =?utf-8?B?VHlyeUhYUTVDWDhhT3BWc0lDMUo0SmZRZlVZeEJyZklFa3l2bCtZVG5nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR04MB6589.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGlJbkwrOXN1RWV1VTNaWHJJOXVsbUs3QnFRK3F3OEhnN3d4amoxeFJZU0VG?=
 =?utf-8?B?eHVpaWZEa295bllDc0VzaVh0VU5FNC82YXA2eTNJMTZMaWVkRWpRM1dIVHhZ?=
 =?utf-8?B?UTNMYXFRTTErL1FDdDlCd3NGazhNZ2wramhiNHFLMHFqeFFzMXN1eVpER1hu?=
 =?utf-8?B?QXVKWXppaHAyaktudERoQXExN3UyeXdnanBxNW9TTzF6TkRKQXFoMlFDRlZM?=
 =?utf-8?B?eGtwNkQ2K2dUVnpTUi9yaE9VNk84L1ZqMGlzeEhJb2VBTVZXcFBRbURQekt0?=
 =?utf-8?B?VnZMaDRHZlpNVUc1Z1RSaGw5OXYwc2pLaUJXSFZEMFhkNmlHY2NqTDhWUGc1?=
 =?utf-8?B?R2M1aitrVTc2aEhWbXZUOGJkb1lLY25qQVhWcTAwZkl1OGtFSE5YQ2RGT0k3?=
 =?utf-8?B?OWVLVVh1NVlhSWNrb1RQMlEvZzJaak5teVJ6Y0R6dmF0QTFjUVBhVVFBeGVx?=
 =?utf-8?B?ZHg5djlUWmRVN2ZUZ3BUdnN5Vk5sUUFJV2NHcGVOcE1mWTU0dFEvdXprcEcy?=
 =?utf-8?B?Nk5weGpBQXlmRktxMVRLSXI4a3RIZStCUDR1SS9OSUZQQ1krUjBHKzBXWmIr?=
 =?utf-8?B?aGxmWVk2Y1Nxb1c0RXdwaGgyMXBoWC96aTNWVGhVQXdwbVVVWVM2aUdxcmJm?=
 =?utf-8?B?QXAvQmRVTisrWmFrTVJZZWUydVZURHRUK01mU1pwM1pTVk9sUVFZaGY5ZjhC?=
 =?utf-8?B?dnh2L1dPdFdJUE1RUjQvd2pmNWRpeGo1ZmlpK1JiUGR0RW9weTRINGxPd25Y?=
 =?utf-8?B?TzNkY1U4Uk1kc29zSk50MzV3YitZbXFuWmpoT0F4eVh6WVB3c2RQV1RXWklz?=
 =?utf-8?B?MnhtenBLVWpiSGFCaFJCRTJCZHFUd1pqbEZlNDgyTXN1czZvdTA4TVBjSzhv?=
 =?utf-8?B?Zk01S0RueE9oRkwvb2lxZ3lvbG4vYVFwZ1BMdWRDL1J3STRyZnoraXFsb0FN?=
 =?utf-8?B?dE9SZ0tpODVjem9qWHVQRWM5THJEL1pEbjdoRERQZ1lRV1p2NlEzb2E3QXRM?=
 =?utf-8?B?Ui9ud0twNGlCQ2JoWC9nUG03QjhKUkU1SW4xR2F0Rm1pbmZVYnlRK0VTY2lx?=
 =?utf-8?B?WitLYjkxRTdWMlVhdlZBMGh5K2dObFFGK3FwcFFxQVpFRUQrVG9SODViZlBB?=
 =?utf-8?B?YUxadkIvMnFIeDNRcnozNjdtdDBVdXFBNlQwVXNtVUdqczJRR3lYVDBpM0JJ?=
 =?utf-8?B?L2JTSmVIekZUOE8zZGNQTXh4RHdJMU5oL0RnVVAyck16N2JHMzNJYkc0SlBz?=
 =?utf-8?B?Z1pmSkgzay83a3hqRm01elU2TEp5SkxPOS95TlhBWXl1bkJxSDJjTHpyajFI?=
 =?utf-8?B?dGViUE5lRnQvaEhLUlV0ZENYL25aRDh3c3VQSmVSdE0yRkdRWElmblZCeVh0?=
 =?utf-8?B?dHIvZUpUWE5wd3h1Rm9iMDJyVW5Cc0h0UUduL0xpbVpaN0NEdWRHZCs5VU0r?=
 =?utf-8?B?eC9wWC9aSm5HSk4za0M1MytRanduZEV0STNTRGp4d0RFY0tYUWFFYWVvbUpO?=
 =?utf-8?B?c1BnczFrcVVIZ2tOWm01SWV1VmZya2lXSnpiVUxtcmw2cWlTbFJyc1A5Z1My?=
 =?utf-8?B?M2x5cVhLN3U0b2haOVdIbUNrV0VkMWZhUmhLUk8xODNBTHJQVmpmckhGS3Fr?=
 =?utf-8?B?YkdPR0VtUUMvenRtWnRyWmFkazhtSzVqVmt4YlFQa0E3a3BCSEN2ZldFcUJ1?=
 =?utf-8?B?dmp2T0ltQjlWS1FVUG5wNmphWlBUYU5GWVhPa3h5RXk4OE1jWXdNOFlsYzFq?=
 =?utf-8?B?aHdiMitxbU12dTFJY0JoWjFIcjBaZHV1Sk8xYXprR1JiaHhlZXl4UXQ0Q0Nj?=
 =?utf-8?B?L2NaS0dTL2x4cUpUVTN0UmFTOUZwdGxHV2Y5Q0lLd1c3QjgzNkFjUG1NSDZ4?=
 =?utf-8?B?QzlEYnlIeVdYRFBUOVpUZVpNOVFTY25rSVFBdWJ6ajhxMlRka2JWK2ZOS1dF?=
 =?utf-8?B?TmRvVjVzTXF5T3kyUkc5ZWdSZERsMlRHYkJrelZTMVpUcko1U1JnV25ORitN?=
 =?utf-8?B?ZlZ2M0xyaXQ5Y2pIbXFHcGtrMXBTbW9tK1JzdE5ZTk1SRzVHOHRLMzRVY1Qx?=
 =?utf-8?B?SWs4eVBrbmE2alJ2OHFYVktpUEg4Vjk2cnFheHhjc3M3VUdlTDdWbUZMaWpt?=
 =?utf-8?B?QlhyZVpWSE9RRGV0VzVFMzhrc2tGdkZuODhld3RYVEU2K2hoZENmYWlZeXpl?=
 =?utf-8?B?VWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9530a8-2e5e-40ba-e0e1-08dc7e284814
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6589.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 08:37:45.5641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hEMPTGfbFCuHmxlqq0IJ9TA50TPnSGOSnMkrNttkRvle/prgcIHXzpgfDdrRJhZ+y46zyz3rFQXJtcDapM6UsfeS5veleFMllJrz+2QidvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6841
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

Hi Jagan,

On 5/27/24 8:39 AM, Jagan Teki wrote:
> Edgeble NCM6B SoM has built-in eMMC so make sdhci has first boot
> priority.
> 
> Fix it for NCM6A, NCM6B SoM.
> 
> Signed-off-by: Jagan Teki <jagan@edgeble.ai>
> ---
>   arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi |  6 +-----
>   arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi | 11 ++++++-----
>   2 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi b/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
> index dd0058262b..88f3f7eee2 100644
> --- a/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
> @@ -6,12 +6,8 @@
>   #include "rk3588-u-boot.dtsi"
>   
>   / {
> -	aliases {
> -		mmc0 = &sdmmc;
> -	};
> -
>   	chosen {
> -		u-boot,spl-boot-order = &sdmmc;
> +		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
>   	};
>   };
>   
> diff --git a/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi b/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
> index a45b3f5e86..289578803e 100644
> --- a/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
> @@ -6,11 +6,12 @@
>   #include "rk3588j-u-boot.dtsi"
>   
>   / {
> -	aliases {
> -		mmc0 = &sdmmc;
> -	};
> -
>   	chosen {
> -		u-boot,spl-boot-order = &sdmmc;
> +		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
>   	};
>   };
> +
> +&sdmmc {
> +	bus-width = <4>;
> +	status = "okay";
> +};

The sdmmc parts are already part of 
dts/upstream/src/arm64/rockchip/rk3588-edgeble-neu6b-io.dts, are you 
sure this is actually needed?

Cheers,
Quentin
