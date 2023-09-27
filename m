Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8915E810CB
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 11:02:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D714486D9C;
	Wed, 27 Sep 2023 13:02:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="Q4aFi24N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06A0C86CC9; Wed, 27 Sep 2023 13:02:30 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24D9186DA7
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 13:02:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9Ah7VSjUk6aLUCx5aeNXjkoJ5Ayk/zFD5DefRHv5WmLbzWupBzQOBHb7ZVjoMWe3fql6Emyr1QZj2PA9nWPGtalxKi61eByiJNbwFWR0YgU2ZjOsP6kiO2ijMaAfRqo7ry57+B/wtlHUThMgm/Xo/QJZYsLVjUmH9Co8ywR3p9EnW5y7RVJ6wLvHjCUIXTIe/lWnhJSCLkkP871LE1YfDoLm4ZkUl2PYAg5dM0aM476X++EX5YHO2h1IXaHvtu2Nr2moDsZIcST9Q3LjN0qbREMAJz1G/H/417+PoiliEzbomEvvw2mDyKcbxJkaLMmglgAaEHmeKizKbAAAegGUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvejWlSH1t6qbrkV4yZCpDJkFUlll5lYp4z9YuOn9gw=;
 b=MjI0A6RrmpMSm8QLmDjuySLqRUGK5x/LAoV6VP+xalUM1LJjH4EW5cLcc5OO678v90yWUCM9T7IWjskVqTUcWVFP/DmLJOWT/NFw4Wd3FaimqGz1W3uG0sKyaCPNEdKCcLJug7INyixguLe7A3H+0EvyEyEgp8aXKqfYgCJseeBqD3MDhKLLVZZyl0wOURHh/peVtxAitRTMFa42znriOCMmYMHTXWp/+pah63QHusN9ClVQ9ba+yb57zRqxWjmRJzjDEQwnjq0cTah5c22O8mXaW3mZ6QODzuU73OyebGf6BVAzf3WNG7QRKWGkQqXX0J66Zo8Lp7m+aFUrKes3sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvejWlSH1t6qbrkV4yZCpDJkFUlll5lYp4z9YuOn9gw=;
 b=Q4aFi24NMZ9QPcOuuaziOeAcgz4EgJxTEqq0unYBtj/zbjsoDPxmzdlxAJZgs2XuDSHdBvkYUOLqAW0ZQg/0VPuv2eOoeru3w6c78YEK9aHUOGZqdGJf6Jd/ZQdBhUZDpWsSFCin8D9wnDTKoFuGPpkNRlGTCH8eg+MWtzySkHHK9u56ETtYHd082kIoFBmJDgsnj5UbV1RlqWnjI0rHrCxY/8VpMWwdHQ9QS2fVH5dVO0s7sfgqIuAc+g37rmjYhCZsLcDKKXCQRVZrI40Efh1R+4j5rm7QMuDIVybqckTPhvNzUxAN9OieCZXqv7DIowWTmCyjQmE84Uou/so9Ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7532.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:427::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 11:02:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 11:02:26 +0000
Message-ID: <89ee5123-751a-4565-bc9a-509f8bf7ac54@siemens.com>
Date: Wed, 27 Sep 2023 13:02:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] iot2050: rename overlay sources to .dtso
Content-Language: en-US
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@denx.de>, uboot-imx@nxp.com,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
References: <20230925080909.365098-1-rasmus.villemoes@prevas.dk>
 <20230925080909.365098-3-rasmus.villemoes@prevas.dk>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230925080909.365098-3-rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: e7671ac3-b60c-4f76-4f7e-08dbbf493bdf
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9yVlifnAqC4e+lgj/JuqX5+COIZ+iHzpZv7eQW2rO2okwn94YQjsSDhXCrN+uLDH6Yzci4UxH6QGwdE5UtDgAjdc54DCJm7oW+Bna8kUdazhk/WpzYyHWevyo+MspULuydZf4yjAR9SThCW/7d2yAMFWtuia92eSsiZkt1t63eBNWLFf170ACXAJC/LLIB5qPAxXsXPS9BVOGLnRnhWhdtlxwLrI5U1kK0vM1ys8JFNAOjwgtOKavlupaFJsBgEodLCX3tYKm2/0VY9BqT3JrMmdBP/jt4sV/zyLYSS+mIveKszDoKzcbP0aoqe/9FdwSc9xM/ezWPEy95a4VrW+orAIgpxWpBf+18rRGDi1PeWklskatBekbRqre8woogDf++EzRnP3NUxATthaxaspZeZi+Fjh9bg1/Dv1RWisFiujykti4LEXUNe77x72gOngm0MxTXaM0XLjwfTHNVLwm9HgYMHiDQnvZ/MSVxyzCbdEUSZ+7is2A38O2wbqcpr3mJ0KC+g+K6OKAow8A3IPZ6F/ADaNGtlV0S7GOEcdryERiw6OdY8452piiiNorDJygyONdrl1QKtyqhDhpAT2X2kZ4UVd82uVe9BWTcTA2hjsLijCYjTHBMDWOJ19xNJtSB2NLSIetyAbz/zlhymtKORtIEy6zu7JlHZ66TP0vEA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(366004)(396003)(346002)(136003)(230922051799003)(186009)(451199024)(1800799009)(41300700001)(316002)(66946007)(54906003)(31686004)(66476007)(66556008)(6512007)(8936002)(4326008)(8676002)(2906002)(44832011)(478600001)(26005)(6486002)(6506007)(5660300002)(38100700002)(53546011)(83380400001)(36756003)(2616005)(86362001)(82960400001)(31696002)(142923001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3hweEtvT2RpUzBsSVVYN2p4S3NsMTFmRExxamMyL2djTEdYeERPeUY0QnhS?=
 =?utf-8?B?VzJDKzkxMjA3eDZiM29NeS96SGhrcUViT3I5eEVpbTV2S2lJbWpMYTNjb1Vj?=
 =?utf-8?B?bVB2ZkIwY3lWK1QyWDcxWTFqeDJVYkVhUGZzeE9GY1VFaFdNdmthemQvc0Fu?=
 =?utf-8?B?WVJLNkZVMkpzam96WTVFV3V5cytkeHYrUmIzUDhvZ0Y0Z25RdDZGbVI4MHgz?=
 =?utf-8?B?MmpUbkhheUNBUjAwcEpFcDJuSWhJQ0d4Yy9tN3dqYkdFVHNnaFh6azIwYzFS?=
 =?utf-8?B?TnFuUEhpM3ZLM1c3dDY4dm95RUJLTjBkelFKVWhucWpKdVpRMVRRcWZ4ekdK?=
 =?utf-8?B?LzVDWWdRWkZ0QXorWExrT1YzNW1kM2xmc1VVa0lwTjVDY2dhOGdkUjdFWWRN?=
 =?utf-8?B?RjVwVlhVelBXcmZBNFZvWEhaeUZNaWd6WjNUUmhEREZxdlF0bmI0a0R6R0xu?=
 =?utf-8?B?THFsK0doSm1sSTk5S0lZYUtkZnhISlcrQXBwTUx4d3M5NUJyaldQaXhZWG1V?=
 =?utf-8?B?WmQwT2RBVVFUZmpkSTB2UXY4b01BZ2FhTGhyMkZ1U3FseVFnRmplVENaY3ZY?=
 =?utf-8?B?cXpBLzFwQnFnYXJxNjg3ZStqdXorZVhEUEVIZ21sNXpWaFFuTnFTQzZQMWFu?=
 =?utf-8?B?aGpIK0FETFhaNGVpajhVeDFSSjFxNGdEc1VSOS9QblkvZXVRRktadm9Mc3V2?=
 =?utf-8?B?OTh1WWZ5NklZeWN3Mm1IdHRPR0pWWFRaUmxuQ3RIVVFoRkY4eFd4SVZDdFIx?=
 =?utf-8?B?TlE0MVhodDl1dGtpOXphQlhXOG9rdnBwb1hJTE5ZQjdTL1dFV1BZTGttMjYz?=
 =?utf-8?B?NTlIME5ja2RVYkNBdFBBUjRjeW54Z2QrOUpNZFg2YlVYa0Y4V21SUC9GSTFs?=
 =?utf-8?B?MmdyMVFQbXo1Y21LUVdNMXhaMld3UTgrU1dWZ0E2ak9xSU15RE00Wi95M09p?=
 =?utf-8?B?a0dhMTM4Y0V0Sk1TY0NhdUJMUENnQ1dhQjZhZkxMbXZVUXRZUHoxU1dzZnYw?=
 =?utf-8?B?S2oxZ1BvTzZlc2t5U2JkZkdudmYvN2E0OTd3czc0dFZLREpPZFROSXBJV3Ux?=
 =?utf-8?B?UVdVMC9zWUJZTGhvQXZPSjN0bGlld0plZWpYMW9FODZjYTZhRmR0Yy85Mndr?=
 =?utf-8?B?d05URGUxVUZwTnFrdDg3L3RhTnR6aE9JT3RwYXhnVUYzVVdkb1Z0SHN5RG5v?=
 =?utf-8?B?a05qKzdZNGhjS1hTR29RUzBrRDhzMDhwSCtYd3ZvWnhtY1J2VWNId3dpK0wr?=
 =?utf-8?B?UHV3VW9RanY0OHZNL0hUNFcyWkR2ejhrSkEveUJJaDErNnhjZ3JZb3ROVDFj?=
 =?utf-8?B?VlNSQmcyY0dPc0pNRThyVVhmS1B6OGZCeEZGdjVHRmRhUjZpVVdBN2I0cXZS?=
 =?utf-8?B?cVVldXVsOS90eXF3dWNpRXhzaTRITGhxVjcxMFZRZVhQeUdKRTlKdkhONEVU?=
 =?utf-8?B?VWVMb2NFczU3bVNjbDQyUXNoYU13THJtUDREL2tXR1lHQkppUXF2ekhrbS8x?=
 =?utf-8?B?Skk5K3NEVlNDa3hFVW52MTBNRGw4RWlLd2dyOVNrWnAvNUdCV3k3Qkc0NzFI?=
 =?utf-8?B?T1Zic25VTGhwUXhRbGVEM2V3N0tNMHQwbW9KTWVjTXJQQzNuQnZ3ZUdvc3Bi?=
 =?utf-8?B?ekZFWGMvaEUxM0hnS2QrNkFXVXlnQnJ0dCtyTFFWZWNBbk9ucVFzRW5OdU4w?=
 =?utf-8?B?eGlsWVE5ZnhKV2FIZ0RjQS9xRWVBZG4wcFU3M2ZjdzVQUVIwUWs4d09HZ0Jr?=
 =?utf-8?B?R1Y4SFhwa0NmZjFUMXpHQlBSUjk0SkR0ZHpHdHFxV2lYb1BzQlZDTFQ5Umo3?=
 =?utf-8?B?dURFS3UvZEtnZ0Z1UXBRczFaWnp2Zkx1RjRpUlFoY2pBdS9tTzBEaG9kRWNl?=
 =?utf-8?B?VVB5U21jQXozdDFtMHg3VW1xcTNIT0VLNDJLZmV3UyttUStxTGFXUnptK0Rw?=
 =?utf-8?B?V2loblRzOVRsL3FRS0JKdUlTWnd2cERaV3VaankzOGVBbXZtYkRxWm5ya0Fx?=
 =?utf-8?B?WWQ0cmZGMVVrWWZSR0RmV0hQR045dm1ZdEhvNW4yUW5xVS8veW1EejVLTVpy?=
 =?utf-8?B?QmNiZ0MzWDB4YnRZeVJyMkNrRzJDaERwWnhBUEJKUGp5MjgwZ1FZaWY5MGVx?=
 =?utf-8?B?ejNLQVNpcktubFF0UUVPSDFkK1p3VFBCcnRtbVo3aHEvbk9mblNwZVB6NkhQ?=
 =?utf-8?B?RVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7671ac3-b60c-4f76-4f7e-08dbbf493bdf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 11:02:26.2348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dulLXBpBPdRsotPlTtEV/2SGWtekBGMqagJtfd5oPyM54+CZRIEXZq3y4xXrEW9qlO8gMSrVx67hsurGXmHesA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7532
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

On 25.09.23 10:09, Rasmus Villemoes wrote:
> Distinguish more clearly between source files meant for producing .dtb
> from those meant for producing .dtbo. No functional change, as we
> currently have rules for producing a foo.dtbo from either foo.dts or
> foo.dtso.
> 
> Note that in the linux tree, all device tree overlay sources have been
> renamed to .dtso, and the .dts->.dtbo rule is gone since v6.5 (commit
> 81d362732bac). So this is also a step towards staying closer to linux
> with respect to both Kbuild and device tree sources.
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  ... => k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay.dtso} | 0
>  ...y.dts => k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay.dtso} | 0
>  2 files changed, 0 insertions(+), 0 deletions(-)
>  rename arch/arm/dts/{k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay.dts => k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay.dtso} (100%)
>  rename arch/arm/dts/{k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay.dts => k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay.dtso} (100%)
> 
> diff --git a/arch/arm/dts/k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay.dts b/arch/arm/dts/k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay.dtso
> similarity index 100%
> rename from arch/arm/dts/k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay.dts
> rename to arch/arm/dts/k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay.dtso
> diff --git a/arch/arm/dts/k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay.dts b/arch/arm/dts/k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay.dtso
> similarity index 100%
> rename from arch/arm/dts/k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay.dts
> rename to arch/arm/dts/k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay.dtso

Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>

Jan

-- 
Siemens AG, Technology
Linux Expert Center

