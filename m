Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB67DC25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 08:30:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F0FA87B35;
	Mon, 27 May 2024 10:30:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kgH00aSo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5946288250; Mon, 27 May 2024 10:30:55 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::617])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C7C787B35
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 10:30:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bO8ziRWECV9pwSEVX8gS4o+axJT+91Bs8rYKp9AUidFVxczS57N7NqLjmdNChetYblkX4vkDwG7MbJYBTyChDoInqvq/5MpDNExM7yd8J6paZQL+lcz8ISgQkR9sHl85bqoPKqoh7lzGaV6pYv0LdQbmfoAjDBq6cg3q9KJX6Mis6dnNYlWc3UxhmPDUjq4Su6BEKBmu1AV8oktRUY8dIlezivoWUMoJDKCOb4RDOfU5lPC8ptMsY49wxr5WH1dTdry9OWwmqpwPpKLI6UQr6tIS8Uf0LBXvArOH514aOnP3T8sVPEKHOxv//4WdEOfOqwrHQQ2GD0lMwTP4+o1tpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQ9mWup5JO2qOi4RdIOpE41CzxMZUMbmsC28T8+0Qv4=;
 b=c2XCTTm8tq1MnaEqGX+rJb3mjYlR/BigNK+aZcPdV8SUwXoy59SC9C2HxtFSS4gpuEZFzsqvOqUFa85lqtWpGV7QNBnZjmQ3nUXLJgDjeGFpei4H/cCj6y108iA6/J8vrI3izrIlNed4UhWuDaHMo18Ar96BeTb1ihB0OfKDAZWHSz5mOOw7q5TxpkCG6VcwM9i1/nAe4r5UADJKvUn3/wrVSrI58d2G2ixSC/sF3TgvjlRsWTdBR7nZwUpchKcXkgmPsFHNvHC1X5bUR2tndrxEM9UAJ3W6gNOEqYDCq1zSScxKEZN4Jel407+qaUCAeIy3qD3IhzQjHuzxrclatg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQ9mWup5JO2qOi4RdIOpE41CzxMZUMbmsC28T8+0Qv4=;
 b=kgH00aSoer59czzckiQIBUtl0a51Va7rV4xlGTIisUjWD0ThHitBie9bbe9+SDUhZxR87t4ZxCvLc2odRCFMRRx+s+wk6hs+hTiOIIPctVGxiFUSsrDNRxVdTEGZDVEGjmak/otuBKmDbFLXRXEcQs+nZaJoHiMPtVqlaMOuQy8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB6483.namprd12.prod.outlook.com (2603:10b6:208:3a8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 08:30:49 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.7611.016; Mon, 27 May 2024
 08:30:49 +0000
Message-ID: <4d428c50-1396-4f6b-a9dc-0f3cc925ab4e@amd.com>
Date: Mon, 27 May 2024 10:30:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] fdt: automatically add /chosen/kaslr-seed if DM_RNG is
 enabled
To: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Marek Vasut <marex@denx.de>,
 Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar <gajjar04akash@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>
References: <20240525200249.3904352-1-tharvey@gateworks.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240525200249.3904352-1-tharvey@gateworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0089.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::42) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c99d05-82d6-4833-fbca-08dc7e275002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUNwVDlxWkRCbDdMRU1Lcit6QmlheDZSanBMbHFnOFpCS2c0TmFjNFg4a3M2?=
 =?utf-8?B?dXlRUmpnYUlQaVN1RnVidWd4MmNTYlQzbGJIK0hFYW1IU29uTFovdUFKd0JB?=
 =?utf-8?B?bXZkcnhzSDJQaCtJaTYyRENsa3JaZ0lhZGxyRlpGWHR5QW84dHdVckdmZ2hn?=
 =?utf-8?B?Zmx5dkp1dVBqOGprdDRJV2h1Zjh1ZWFTVWdZS3VhNTBwVmgvSm9NOEs5Y3lL?=
 =?utf-8?B?SDMwSlM3S0dzL1NJSUJUd2JxMEViT3EzbXFFeEZKVTcycFdCMUozZXdHREFO?=
 =?utf-8?B?TGFzSGYyOCtQaisrZG5jZk8rci9Ea3VSbDhWemdjWm9Id2RveXpwZTRoT0VO?=
 =?utf-8?B?TG56RDkxWkZ4Z3VKKytlTmZ1Y0pSak1neXlCRHVFU09GN0dIRVRJY0JoNk95?=
 =?utf-8?B?VEsveGpCRUN2c0VES1ZmS2hFLzIxamJXNjFJV2RUcWNhOXpJN0lBOEdRa1RB?=
 =?utf-8?B?Z2tYUS9wMGsxQm9BQzhMRTRFT3RxSmdDdWliTkgrRThXM1BNVHdGM2dNWlo3?=
 =?utf-8?B?b092Z1ZUMmlCeEpKWiswVUM4NEEvc0NXQ01SL29GaThNWlZxWVFCNE5WT2N6?=
 =?utf-8?B?YnMrMDgrYmwwUzdlNlVtVTJqMjFKVDQyRm5JUXNVRkNDSTlQaDZiUkZjZHVq?=
 =?utf-8?B?bFZWazNWNkhORFlUdWdLRFlOUjRWSElablZ6RFdCVE5EZlRkOUtkUU04NVNJ?=
 =?utf-8?B?Q2tETXh3OFYyd255UXZRWmZkTTdHSXBqbitHRkdnZy91cHVDTWNiZ2x0dEJO?=
 =?utf-8?B?eG5hZDlGeTgxZVdLUFQ4Yzh2VHh1NXdDYm9iT1FuM3NoNXoxRnBqcjBsbmRz?=
 =?utf-8?B?b1J4VzN2bUdGbk10bXZqZUhPTmtrRWY3Y2FNVnNEdURVU3k1M0hrYkw2MVNR?=
 =?utf-8?B?aVhQUnAvQllpZkpIZi9JUUpzS0E3MkprNWUvb1cvdjVLRW5GSEhuMmQ4Z3Br?=
 =?utf-8?B?M2J1U1g2ZmtieUZyeWhrTVJERVBRSnNQL0VqRUZUUlhMUkQ3SVppR2RQLzB4?=
 =?utf-8?B?aDhNaldQTnJwVHV3QS8rQXVqVEoxVFpPNEF5RXNrdkI5dXVKdlRtbVJ1NmFx?=
 =?utf-8?B?czdVMXN3VUtWNXlYeVYycGlOWExESFM3SnMxUi9uZ05aOXFmY0JFcTNqOWRu?=
 =?utf-8?B?dVVvditJNGw3NlF4emZsd08vUTR5T2hYTExTUG9vbzVpVElDSjRrVUJodER5?=
 =?utf-8?B?dk1ERmF3dVV2YVMxVjBXa1FGRm94SXhmSmdTVjR2ZUZUWXBKb2kwYTByUmVO?=
 =?utf-8?B?VDZvQ0VkY2ZPaE5uUUw5eVpQRGpUbGcvL3Bha1BHSzM4SG5PWmxNQVF2UUtE?=
 =?utf-8?B?Y0xESjlsN09Jd1BXOVM4a0hhWDR2NzdaN1R1Y0QycHhVcXNCTUtNTk9yN3FW?=
 =?utf-8?B?cHk5eTNDNk1yZVpBMWxxcWNLN0t4MHNNUC9VdjVuc015QkdvdUJEUWY5V0g0?=
 =?utf-8?B?NlI2TGxKQmduems1VGFTbFJmODM0OUVENE16eklQNU4rMkdpRE0xZ3lMem15?=
 =?utf-8?B?YncydndLSjQwTmVCMWJvRkpzeklXWDNDR1JLV0NGNWEwR2lheHNqQU1HRk1R?=
 =?utf-8?B?cXVyVGJLSVMybko2d3c5TzhuTk1iY3FQYTVvVVQ4TGJMOVhxK3VtSXlwL1ZS?=
 =?utf-8?B?NTN6K0gvNXpPV0wyM1hlbjdFWXRaeHlHWTVWUG9DVWkxdnJvR2VackJVZTNy?=
 =?utf-8?B?bmN2MHgxdnVScjgreUVBWGxleCtkK2FhdGR1aTZBV3JrRlR1cGlpUGNnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2l6YnFSa3hFb0lFYWJrZHFJVTZzWFBYaDZMdTFMNkJJRmJ5Z3J4ZDU3TzlO?=
 =?utf-8?B?cUdEam9QM25PWWt3YUF5VEk0NWlyUkhPbFBLQlFvS0JuTy92OW85YWZXUE96?=
 =?utf-8?B?dDRqeDBBL3dNT25OSzlqOUwrUXFuT2hFUFN1SWlwbTdjRnlmNTFwbGF3UDls?=
 =?utf-8?B?enZSSHpYcDFNR2lYdmJLSWJYMFJQQTUxcW5DSFhEL3NlZ2JwanhRdU9pQ2Rw?=
 =?utf-8?B?ZHVYRTNWZ0Z2N01CVTBHU0lUb1hXZGVaWUVlSkNHemVOZ2Eva3BWQWtKcVpv?=
 =?utf-8?B?V09sOUdwM1lkQUtadTBFbmp4aW5yajQvOWMybjZMOXhkU1F2WU0vbndCTTBE?=
 =?utf-8?B?VS9DeXJOVFE5eGEwRlBXNkl4ODZ5bEpmSkxBOFlYR3pZMnhOcitiYkNFVExz?=
 =?utf-8?B?djJuVWpTSjVqOUlUOTQ1aDNRNnpOQVdYanhsYVdobFJoVWZqTDZWTEI3OS9q?=
 =?utf-8?B?SHFpcFUxbitVZXdCMndDclpkc1hDUkdwTWJJUEpkbjNoeXp5WXFwalNpdmVK?=
 =?utf-8?B?dGlwNUtqTFR5c3JLelY0UVF6SVJ5YXZsYVhrRkpXTFZtUVNQbEwzSUFqOTdu?=
 =?utf-8?B?R21wTFFNRUE5bG9sd25sSG9yRS9ZcE1kU1UyOTczRTNmcjFMTEFVSENSOGdW?=
 =?utf-8?B?c0hranc1eU8yNzhpQmxnRFlmekJPK3VHeXkyTmwvV2ErdHpkM2FFOGp1MnRJ?=
 =?utf-8?B?amFtRERKK2pZa05XZVczcDVubkN5WXVSM1lmVlIxYW9FR3ZhRThVaXJNTHN6?=
 =?utf-8?B?WlVVMTAwTW83dXNpdDBQMWM3cGh5cWVUb01OUlRwTXM4VjVRMW9BK1ZBemp5?=
 =?utf-8?B?WVRUK1dteTFlMDNJbW9wYzFhbERhaHoyQ3RVc1R5MUNVbkFjUFM4Qmw4WTVr?=
 =?utf-8?B?YUdOZUdjMnZ6ZDVOcTZ4LzZ0TjNocnBxb1Z3YWdGS1p5MnUya2wyQVRxcEdW?=
 =?utf-8?B?WUpNbjRvSFBiaEZiZmxNb1A2ZUhkU29QeEx6K0s0YlhCN0JxeGJkd0JCSThX?=
 =?utf-8?B?SjRQRWpTajBEUjN3M0w4Qkp5MUZlMEJaR3ZMeXVHTzlRWG1lZWRZVHQ0MVhE?=
 =?utf-8?B?blVuRU5xT1ZpRVcxb29hKzZyRTNIWVJzL1diaC8yQzRWZXFibGJTQkMyQ1RH?=
 =?utf-8?B?YldBaUt5R1JCSlo2bmtHQjRqUmx1OFBZK3FjRis1cVRHZGwyR0FuQXdQbC90?=
 =?utf-8?B?UWFvSnQ4MG1tcUtRSEFRdTlhSFBqVGMwT0cxSG96NS9Ld05DSVRyNGdSWVc2?=
 =?utf-8?B?dFRnVVNvS002a0ZnV3A4ZkJiNmtFa21SeFdjQTBXZWdOWjdKUDk5eE5IN2Ew?=
 =?utf-8?B?OXg4dEZ4SGZwb29iTmVlN0NSbHdUdCtUeUhDSGUvMEEyekNVTzNCaVVYWjZt?=
 =?utf-8?B?WkhhaStURENxN0RqQ3U1OEM2MDRuU3BMQ1M0OWI5RTVhd2ZPNktTKzgxM0dj?=
 =?utf-8?B?dkRqaEJma1FRSnFwakRQdlpNUWpJaDZ5NkJ1SWh5bFdQYUNabnJpRy9adERi?=
 =?utf-8?B?NThoZ25TZ2lJUmpJM0ViZGFrR21yeGFKVGN5K05FN1piWDJLbDF5T0Y5WmRi?=
 =?utf-8?B?b3RJWTR6OHNFZ1QyeWc2VGxUaS9SdTN3M0wyb1BMYS9FRHh0SkFUZmFmeFdi?=
 =?utf-8?B?RStwMmthTHluZEFVNkpRM2xvUGhxcEQyYldwTjBzUm90bGJoMG9QcmptWk81?=
 =?utf-8?B?b2ZXY3RmbzlwSXRYYjRlVEp3VUIrNGhaY1lQcFhHRTM0dmVBVWViaUowNjlr?=
 =?utf-8?B?a0NvdmMrRkh5M2hGMEdnQVpLZ3M4bWdkRkRrVmtuYVNFeHk4dGF2ZFdkY2VO?=
 =?utf-8?B?dTRoZVhaTGJ6MXZIMDdNclBsdXNaRDNHUlluOThHREdWM0FReUN4ZVpQT0x2?=
 =?utf-8?B?SVQ4NFpKQ3RNZm1nTEYxMCtYNW5EalhsZUFFdlpGSXVGNlE1by9YMFhWT1Fu?=
 =?utf-8?B?ajhmVTRWN1gyT21OcWlxMXpkOElWN2U4cW9IdU1Bc0FPbzcrZWdBMC9aMWtU?=
 =?utf-8?B?SGJnUXFIZ2NSRi9xY1NLaUV3MXZYN0JFQXNtcEhlVkM0NXBVaGFWRkFnWXI3?=
 =?utf-8?B?aTZpcm1XY1pYZFg4K2JCS3VVZlpMdU5KTmZSZVVBUm11dldyVlFaUUNvWXZU?=
 =?utf-8?Q?ct5gm3m7D8+1TQ4SxHpWjEKay?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c99d05-82d6-4833-fbca-08dc7e275002
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 08:30:49.1880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLOmw8elilMbc+jn557xOhACqqGJk/MxRAS7RoqkQuF3aPgcTR0j2S9J7JXfI6GF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6483
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



On 5/25/24 22:02, Tim Harvey wrote:
> If RANDOMIZE_BASE is enabled in the Linux kernel instructing it to
> randomize the virtual address at which the kernel image is loaded, it
> expects entropy to be provided by the bootloader by populating
> /chosen/kaslr-seed with a 64-bit value from source of entropy at boot.
> 
> If we have DM_RNG enabled populate this value automatically when
> fdt_chosen is called. We skip this if ARMV8_SEC_FIRMWARE_SUPPORT
> is enabled as it's implementation uses a different source of entropy
> that is not yet implemented as DM_RNG. We also skip this if
> MEASURED_BOOT is enabled as in that case any modifications to the
> dt will cause measured boot to fail (although there are many other
> places the dt is altered).
> 
> As this fdt node is added elsewhere create a library function and
> use it to deduplicate code. We will provide a parameter to specify the
> index of the rng device as well as a boolean to overwrite if present.
> 
> For our automatic injection, we will use the first rng device and
> not overwrite if already present with a non-zero value (which may
> have been populated by an earlier boot stage). This way if a board
> specific ft_board_setup() function wants to customize this behavior
> it can call fdt_kaslrseed with a rng device index of its choosing and
> set overwrite true.
> 
> Note that the kalsrseed command (CMD_KASLRSEED) is likely pointless now
> but left in place in case boot scripts exist that rely on this command
> existing and returning success. An informational message is printed to
> alert users of this command that it is likely no longer needed.
> 
> Note that the Kernel's EFI STUB only relies on EFI_RNG_PROTOCOL for
> randomization and completely ignores the kaslr-seed for its own
> randomness needs (i.e the randomization of the physical placement of
> the kernel). It gets weeded out from the DTB that gets handed over via
> efi_install_fdt() as it would also mess up the measured boot DTB TPM
> measurements as well.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Andy Yan <andy.yan@rock-chips.com>
> Cc: Akash Gajjar <gajjar04akash@gmail.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Devarsh Thakkar <devarsht@ti.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Chris Morgan <macromorgan@hotmail.com>
> ---
> v4:
>   - add missing /n to notice in kaslrseed cmd
>   - combine ints in declaration
>   - remove unused vars from board/xilinx/common/board.c ft_board_setup
> v3:
>   - skip if CONFIG_MEASURED_BOOT
>   - fix skip for CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT
>   - pass in rng index and bool to specify overwrite
>   - remove duplicate error strings printed outside of fdt_kaslrseed
>   - added note to commit log about how EFI STUB weeds out kalsr-seed
> v2:
>   - fix typo in commit msg
>   - use stack for seed to avoid unecessary malloc/free
>   - move to a library function and deduplicate code by using it
>     elsewhere
> ---
>   board/xilinx/common/board.c | 40 ------------------------------
>   boot/fdt_support.c          |  6 +++++
>   boot/pxe_utils.c            | 35 ++------------------------
>   cmd/kaslrseed.c             | 45 +++++-----------------------------
>   include/kaslrseed.h         | 19 ++++++++++++++
>   lib/Makefile                |  1 +
>   lib/kaslrseed.c             | 49 +++++++++++++++++++++++++++++++++++++
>   7 files changed, 83 insertions(+), 112 deletions(-)
>   create mode 100644 include/kaslrseed.h
>   create mode 100644 lib/kaslrseed.c
> 
> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> index 30a81376ac41..0b43407b9e94 100644
> --- a/board/xilinx/common/board.c
> +++ b/board/xilinx/common/board.c
> @@ -701,11 +701,6 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>   #define MAX_RAND_SIZE 8
>   int ft_board_setup(void *blob, struct bd_info *bd)
>   {
> -	size_t n = MAX_RAND_SIZE;
> -	struct udevice *dev;
> -	u8 buf[MAX_RAND_SIZE];
> -	int nodeoffset, ret;
> -
>   	static const struct node_info nodes[] = {
>   		{ "arm,pl353-nand-r2p1", MTD_DEV_TYPE_NAND, },
>   	};
> @@ -713,41 +708,6 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>   	if (IS_ENABLED(CONFIG_FDT_FIXUP_PARTITIONS) && IS_ENABLED(CONFIG_NAND_ZYNQ))
>   		fdt_fixup_mtdparts(blob, nodes, ARRAY_SIZE(nodes));
>   
> -	if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> -		debug("No RNG device\n");
> -		return 0;
> -	}
> -
> -	if (dm_rng_read(dev, buf, n)) {
> -		debug("Reading RNG failed\n");
> -		return 0;
> -	}
> -
> -	if (!blob) {
> -		debug("No FDT memory address configured. Please configure\n"
> -		      "the FDT address via \"fdt addr <address>\" command.\n"
> -		      "Aborting!\n");
> -		return 0;
> -	}
> -
> -	ret = fdt_check_header(blob);
> -	if (ret < 0) {
> -		debug("fdt_chosen: %s\n", fdt_strerror(ret));
> -		return ret;
> -	}
> -
> -	nodeoffset = fdt_find_or_add_subnode(blob, 0, "chosen");
> -	if (nodeoffset < 0) {
> -		debug("Reading chosen node failed\n");
> -		return nodeoffset;
> -	}
> -
> -	ret = fdt_setprop(blob, nodeoffset, "kaslr-seed", buf, sizeof(buf));
> -	if (ret < 0) {
> -		debug("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(ret));
> -		return ret;
> -	}
> -
>   	return 0;
>   }
>   #endif
> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> index 874ca4d6f5af..b64cdd34825a 100644
> --- a/boot/fdt_support.c
> +++ b/boot/fdt_support.c
> @@ -8,6 +8,7 @@
>   
>   #include <abuf.h>
>   #include <env.h>
> +#include <kaslrseed.h>
>   #include <log.h>
>   #include <mapmem.h>
>   #include <net.h>
> @@ -300,6 +301,11 @@ int fdt_chosen(void *fdt)
>   	if (nodeoffset < 0)
>   		return nodeoffset;
>   
> +	if (IS_ENABLED(CONFIG_DM_RNG) &&
> +	    !IS_ENABLED(CONFIG_MEASURED_BOOT) &&
> +	    !IS_ENABLED(CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT))
> +		fdt_kaslrseed(fdt, 0, false);
> +
>   	if (IS_ENABLED(CONFIG_BOARD_RNG_SEED) && !board_rng_seed(&buf)) {
>   		err = fdt_setprop(fdt, nodeoffset, "rng-seed",
>   				  abuf_data(&buf), abuf_size(&buf));
> diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
> index 4b22bb6f525a..35d5b9ed3ecc 100644
> --- a/boot/pxe_utils.c
> +++ b/boot/pxe_utils.c
> @@ -8,6 +8,7 @@
>   #include <dm.h>
>   #include <env.h>
>   #include <image.h>
> +#include <kaslrseed.h>
>   #include <log.h>
>   #include <malloc.h>
>   #include <mapmem.h>
> @@ -323,10 +324,6 @@ static void label_boot_kaslrseed(void)
>   #if CONFIG_IS_ENABLED(DM_RNG)
>   	ulong fdt_addr;
>   	struct fdt_header *working_fdt;
> -	size_t n = 0x8;
> -	struct udevice *dev;
> -	u64 *buf;
> -	int nodeoffset;
>   	int err;
>   
>   	/* Get the main fdt and map it */
> @@ -342,35 +339,7 @@ static void label_boot_kaslrseed(void)
>   	if (err <= 0)
>   		return;
>   
> -	if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> -		printf("No RNG device\n");
> -		return;
> -	}
> -
> -	nodeoffset = fdt_find_or_add_subnode(working_fdt, 0, "chosen");
> -	if (nodeoffset < 0) {
> -		printf("Reading chosen node failed\n");
> -		return;
> -	}
> -
> -	buf = malloc(n);
> -	if (!buf) {
> -		printf("Out of memory\n");
> -		return;
> -	}
> -
> -	if (dm_rng_read(dev, buf, n)) {
> -		printf("Reading RNG failed\n");
> -		goto err;
> -	}
> -
> -	err = fdt_setprop(working_fdt, nodeoffset, "kaslr-seed", buf, sizeof(buf));
> -	if (err < 0) {
> -		printf("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(err));
> -		goto err;
> -	}
> -err:
> -	free(buf);
> +	fdt_kaslrseed(working_fdt, 0, true);
>   #endif
>   	return;
>   }
> diff --git a/cmd/kaslrseed.c b/cmd/kaslrseed.c
> index e0d3c7fe7489..ebe4058d7ac6 100644
> --- a/cmd/kaslrseed.c
> +++ b/cmd/kaslrseed.c
> @@ -9,33 +9,16 @@
>   #include <command.h>
>   #include <dm.h>
>   #include <hexdump.h>
> +#include <kaslrseed.h>
>   #include <malloc.h>
>   #include <rng.h>
>   #include <fdt_support.h>
>   
>   static int do_kaslr_seed(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>   {
> -	size_t n = 0x8;
> -	struct udevice *dev;
> -	u64 *buf;
> -	int nodeoffset;
> -	int ret = CMD_RET_SUCCESS;
> +	int err;
>   
> -	if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> -		printf("No RNG device\n");
> -		return CMD_RET_FAILURE;
> -	}
> -
> -	buf = malloc(n);
> -	if (!buf) {
> -		printf("Out of memory\n");
> -		return CMD_RET_FAILURE;
> -	}
> -
> -	if (dm_rng_read(dev, buf, n)) {
> -		printf("Reading RNG failed\n");
> -		return CMD_RET_FAILURE;
> -	}
> +	printf("Notice: a /chosen/kaslr-seed is automatically added to the device-tree when booted via booti/bootm/bootz therefore using this command is likely no longer needed\n");
>   
>   	if (!working_fdt) {
>   		printf("No FDT memory address configured. Please configure\n"
> @@ -44,27 +27,11 @@ static int do_kaslr_seed(struct cmd_tbl *cmdtp, int flag, int argc, char *const
>   		return CMD_RET_FAILURE;
>   	}
>   
> -	ret = fdt_check_header(working_fdt);
> -	if (ret < 0) {
> -		printf("fdt_chosen: %s\n", fdt_strerror(ret));
> +	err = fdt_kaslrseed(working_fdt, 0, true);
> +	if (err < 0)
>   		return CMD_RET_FAILURE;
> -	}
> -
> -	nodeoffset = fdt_find_or_add_subnode(working_fdt, 0, "chosen");
> -	if (nodeoffset < 0) {
> -		printf("Reading chosen node failed\n");
> -		return CMD_RET_FAILURE;
> -	}
> -
> -	ret = fdt_setprop(working_fdt, nodeoffset, "kaslr-seed", buf, sizeof(buf));
> -	if (ret < 0) {
> -		printf("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(ret));
> -		return CMD_RET_FAILURE;
> -	}
> -
> -	free(buf);
>   
> -	return ret;
> +	return CMD_RET_SUCCESS;

You should consider to use standard function here.
return cmd_process_error(cmdtp, err);

Anyway looks good to me.
Acked-by: Michal Simek <michal.simek@amd.com>
Tested-by: Michal Simek <michal.simek@amd.com> # ZynqMP Kria

Thanks,
Michal
