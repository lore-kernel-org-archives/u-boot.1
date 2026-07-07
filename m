Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D08C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 10:59:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7627784994;
	Tue,  7 Jul 2026 12:59:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="FxHP3SP1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 787CC80087; Tue,  7 Jul 2026 12:59:00 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 625CA84994
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 12:58:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSutk3iT3uLAyoNcYr88CmXzbeIuv37ccFhghYFL91R5AsGVyQZluZ60yLP0BEpjxb/sze55LtpNhT3hyuq2qUi/cWO9uwKNd6e8LAvQJe6gbKUUyyO5txN4sBts5r5rwF4R8UbM7qK4cOV7Kua1fq92hsmCtXN4CvOWmR+8+Mx1f0QTD64D+gFli5GTiv3koq5bihA4wrDD0D7P8OUQ1qw9LuXUsqfvc2go+UUAIMeAUkYlG9SJpMuiDn5v0ZscWfwXz3bQIm3akmttAVc0q/kCj+JV+ipedmBwKOGOjJ+D2w79AMNKyKpxSsY7njbIkdsgGA00yPfzM1dJ5DApMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIApzGoUVUiIgQ5ijKClYeVLlZqZp2n0tx+m0wCkLZQ=;
 b=sdC3f0+wPQCXloTmUQ4IhPC5jPW6lOuqG9ao0s+PPBxaP8u+Ikdd3dzh2hC+2RVyHykWq1XfQxejeQJvMatJhNugUrJ3mMuBID8wjJgsLTEeXlmhU4q25f/z4IfrUDbcWVcUpmwTJJIvwRXvz4Y2ro8JX2sLnD/2crHRYbbpwG51LTNTltlZ3P9Xi1hdLKQaOZGpgJgX71peyFti8KW/rl48/Bmro8zNx2THLkZv4OtgyCjDmgLyli5chJ6d+1owFYHB8Pt1z+zChLfnOep4JMlQMHmvR4GMti2Hh9gH9I3R27MplsA/0jF6vZStCM9lylOU93daDJBf/7DJrvrjQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIApzGoUVUiIgQ5ijKClYeVLlZqZp2n0tx+m0wCkLZQ=;
 b=FxHP3SP1VZzgzVGiqc2XsHvrkdjgzmZ4i6iLPzEZBQ3tBBWygjAXO/i4iqhRLN0HgtzXRHlY2lv0I6D3JJnaflMdpk1EIteo8jIyhq7/2CEI/hv3BiK9QWr18GTmlnY9M08N0PMqI1xTK6FHfGGkJ75qm0qyDFGkYqKovWjUyf0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 10:58:54 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 10:58:54 +0000
Message-ID: <5433d0d4-437c-48f0-a584-ca6f5da317ce@cherry.de>
Date: Tue, 7 Jul 2026 12:58:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: rockchip: Align OTP nodes for RK3528/RK356x
 with Linux v7.1
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de
References: <20260707100918.3057718-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260707100918.3057718-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0079.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:349::15) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|AM9PR04MB8793:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ffd3f2-a83b-4b55-9c34-08dedc16bc31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: e/TAZorXN7xSfyiUgShpy33khRpk3fa5F98EYEfuF6ttjYM5AO2FRifSRk7Jtk+k1oPJBN/8mTGE9NFr7DWj+esLg5zARZOPZN0MlURzdGcm3aMM8o72pF7/cQkg/3zrpcFFmlFnI/th7YOJrILrYlBAKxcDA6Jsugxtl1iihNDAHBXgQYD1H7DpavtQF0P9P2Ke6Sybgy2s3hcjkNUwRLsGlgXkDeGXnySkY53izFIyUIkVBzb6qqFJVjNfWm7TfmZAw5CoxstRP2q1Gt+MJj7fCJeJHpHVD948bGLnAsn3GgYUIZA1x6GmWonWo3Gl3MuIO+2TQshFxwS1qNz7R6zu3nTldOO5HnuBC294wnRChaeYkYoU/lCWg32JEQDbeBFTGiX3WkD4EnQ5aev6K06kmD0ae8BnJpvC9cyKz/5f09b9X5NWKuysL55ApG7B+hit3K85NgulVX62xke9RhiVl/IcQ1jkllI8q5ohxUdZT5ppwGeWi5QKJMmTYjNi3gA+50CJXIAy85umqjkPGGumLNdxyCi23FONP14nJY8li4DKiXEHj7VUzQrT/ay2KPR4ATpXdPn+qQYy9ivl//pQRfZDoc2ElpS0GuKXHjZ13vdTGECTgNJfRoivBl/+Lsgco6BMK1qc6Lq7PkXOhqM45Ab91oyZ268FuGxLmu8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2hOSjVXc2thTm5CbUgvM25WTnN5aStacDNlWktmcWd6b0N3OE9oN214aWU1?=
 =?utf-8?B?Rys5TVNtQXJXYkZob21jOG1IS1pLVFBXRXp6aWJWRnp2b3JPbDlhSWdKTVM3?=
 =?utf-8?B?NXpqZ3dIVmJLY1JpRVFoNmpvMFplTmlacVQ2V2RZMTdsV2lRQVUreE1BTTBI?=
 =?utf-8?B?azNZRE1aY2J3ckF5WlVEUGtQS2NFWFdjUDBuaXhId3pmbCtLVTBqWmZWK3Nn?=
 =?utf-8?B?eWw5QVdHbWtvOGRxRmxEa2hzYlBEbW1OS0FVc3J1RmIvZmtzYUg1S0tyTlV5?=
 =?utf-8?B?aFZPOTRXVVpZV1IwWUJqTEU4VFRqWXBXbktrcmtGaldmZ2d6VTNtL2k1Y2Rt?=
 =?utf-8?B?VWxLZ3k1UUVZUkh3UU9JeDVBZ0tJOEs3ekdwcTFlNktjcDhCNm5sYTZ5WVVE?=
 =?utf-8?B?WTRVR2dlS21NYVJ2L2ZiZkxGQjRRZ2tPUDZVcjI2SGwvci9LTUJ6d21FdWc1?=
 =?utf-8?B?ZzlvMHBIQ1dldUtDYmQxQWt3RzgvWWpiRmZ0NW5BNWJ5SXpKbWZMdGYxbkMv?=
 =?utf-8?B?dmlOcmQwd09zVTdRNFhlN05WRUlnZFBXV2hMTFJ1VTZDaGpoZEQwVnVMM3NE?=
 =?utf-8?B?MG0yaDNVZHhrNzY4SVNBdVZyQVhtQmNjeVBORjV1cytvMk4zQi9tc3Q1Y1BL?=
 =?utf-8?B?VEVMQlZ3Q0tzbEhBWTBPbStBT1FQYU5wcVZNcXpCWWJ6T3lha1ZndGt5SGtt?=
 =?utf-8?B?emFsN0dWbFlZUGNUWUdOKzg3eXR5N2N2QVJhRTVSQXp3Zk9oUHBOejNXUmE2?=
 =?utf-8?B?ZmFQMUJwSVNmek8xSUZhbjErZmZvYXB5RkRVSjNvRi8yQWkyVC9oNFBJeGZv?=
 =?utf-8?B?NWNpZXVNVGR2RWZDQmxZSWNuWVdNK2Frb0FYK1pScWtPMnBvaUs2eWl3bVRO?=
 =?utf-8?B?TFU0RmZncXVlQllXekxtS0s0TkZNWVpEckZIN3ZMUFV6RXVsMkJ2eSsxTmta?=
 =?utf-8?B?cWNjSzk3OExwWnhMd25qL2hnN3BEYURWanpiTWRybU8yNjlQRG5pYitJM2FW?=
 =?utf-8?B?ZmVOSmlabWVnSkd2YzdhaE9aaUJnZ3hhN3AvdlB4ejRyS3Q5MkFmVG1zN3du?=
 =?utf-8?B?bkE4ME14TkJiQWpDakQxMDY0TnFHZ3UrTzZUOFYzQ2FIeWdqY0lVdkRQeERK?=
 =?utf-8?B?KzhyWUNTbU8ra0JkTlVpclpEbmdnNkZGWU8ySXJka2Z4a2t1UjBkQllBdWs5?=
 =?utf-8?B?SHNIbzFpTjR6SXBsQUhvb1NOQk9OR0xlbXYwbzlLQjkrOGR0cXluSGt1T3JC?=
 =?utf-8?B?MkNCdFkvdktGUXppNjBZVXRoOWhobEdqaFdidHZGOVU1OU9yR2Flc013ZWV3?=
 =?utf-8?B?RXVuT0RTN3pVNEp3cDJ5OFBXd3JiTVJLdXNXNzU5NGhPRkdlYzdyQUI3MmN5?=
 =?utf-8?B?TWQrWGtMbzZsaC8ya29TdDZzZVU3dUtJVmE3cXZyRlVsdkpzZXlPYWlKWTFQ?=
 =?utf-8?B?MTZRRnNXd3lySHBGQ3I5MU1LMGVjbEd6YmpVaTNaOWJkSkgxTzQrWmpva2dr?=
 =?utf-8?B?aDg5UVVZYVF6RVRVOHV5NHRVQ0xnMHVHbFpueGRLUVhtZkVYNU9mRHRaSXlp?=
 =?utf-8?B?L3JqVG05b2QyTitMajRGMU5XSkFGRGVnZkFMeFdFSFJ3cGhUYVh4SzZFRmZS?=
 =?utf-8?B?UGU2d1ljL2w3d05HMENOenBLaWUybXlmU0tHVUN4aGVPa1FsM0MvTW9qRG40?=
 =?utf-8?B?TTFyYTJ5ZDNqcFNpMEJqS0ZpbExSNDNnNkYvYkIvM0NlWlVNRW5HY0Izc1F5?=
 =?utf-8?B?cE9qajdveUhJeGlLdFJQZTNRam9oTUVheVhoVHQybllDWFdMWVNYOTdudHRD?=
 =?utf-8?B?VWhYNjdkdTVuUDVUMGp3QWdiV1Z4V0RwcWJUY2ZLWVhPTUw4aGgycU14ZSsv?=
 =?utf-8?B?bG9qVk5iUVZNbXFKZ3czTXRWRUFCSXNldERwT3FyNTAwY043OTlhSXJxNWs3?=
 =?utf-8?B?SjBxdWZ6OE1zMkNLSHg2WnFoZXlRNmdJNnRNamhkcUd6dFN3bVpFMEl2bVJp?=
 =?utf-8?B?ZHdpajdzbTJIeU4zNHNBREFrRHUvdnRLandnOC9zN0hDaWVLZ2NTcmx2dW04?=
 =?utf-8?B?bzdQUmVGNC9sUkp4eDJxNnNwaUtVcHQzWFRROXZmMVNzVzlSOS95azE4Nk1v?=
 =?utf-8?B?OTI1S2IrSGRNRndvcnB4bmVCSFhuTmkwS3VhNEVMdjlJQ3FMRThDc0dQcmxO?=
 =?utf-8?B?SHFISjc3K1czZVU4dEdZWjBYR3JBdERLb1BRL0FhZDc4eHh2RVJnbXlKdWFR?=
 =?utf-8?B?RFNhUnVHeUxpbzRKS2NZWWhDZmlhdmJTS1VJTUYrUFFRRC9zZHVDVld6Zit4?=
 =?utf-8?B?eEZDTTlvRVVSRThIcWsweHJLL0x1cEVDNUozN2xNV3JOdm1tSzNaUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ffd3f2-a83b-4b55-9c34-08dedc16bc31
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 10:58:54.0924 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4A3gSUBAB0ht4xPu7RgLJt4P5ogGTBIk8V/+VQ2rg2X7+IOgxy7crfZ+ETNB+ZvI++ChYzJ0LPzDhKPynen8LGVwKnCjwNsaJd0VG8FINd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8793
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

Hi Jonas,

On 7/7/26 12:09 PM, Jonas Karlman wrote:
> The <soc>-u-boot.dtsi OTP nodes for RK3528/RK356x use different names
> compared to the OTP nodes that was merged in Linux v7.1. This causes
> build issues when dts/upstream pulls in updated DTs, i.e.:
> 
>    ERROR (duplicate_label): /soc/nvmem@ffce0000: Duplicate label 'otp'
>                             on /soc/nvmem@ffce0000 and /soc/efuse@ffce0000
> 
>    ERROR (duplicate_label): /nvmem@fe38c000: Duplicate label 'otp'
>                             on /nvmem@fe38c000 and /efuse@fe38c000
> 
> Align the OTP node names in <soc>-u-boot.dtsi with the node names used
> in upstream Linux v7.1 to avoid build issues when latest DTs are synced.
> 
> Also drop the unused RK356x id@a subnode as it has moved under a
> nvmem-layout node in the merged upstream DT.
> 

I guess this is fine because our driver isn't actually making use of 
those subnodes as far as I could tell.

I was wondering why we even keep those nodes in since they are now part 
of dts/upstream but actually they aren't yet and this patch allows to 
not depend on 7.1-dts being pulled in U-Boot AND allows to build once 
it's pulled. I'm assuming we can remove those nodes right after the 
7.1-dts tag is merged, right?

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
