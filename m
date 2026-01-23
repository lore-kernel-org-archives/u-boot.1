Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EF4D72372
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 10:40:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3E9283B32;
	Fri, 23 Jan 2026 11:40:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wKQxhz5r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C71D83B5E; Fri, 23 Jan 2026 11:40:31 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCAE883B03
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 11:40:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQ2uAGWQ0VNlgZKxlngKGqQhRGdp56O7ANVmbcqG0gik8VwY4v7qaCE/3l1UeN6iXOOlC9tEfaQPR7d6g1swdr2UAefSQr4gE8hAsFlq+RV7i/AsA2k+MO6vcEqCHJxv2ulgTeshbJYy/dNLVYNk4MEfYsB9XKKhjDGkT9rNjJ+eA4MVwJDE+sNod8id6K19bpePyVzv0xkJ3QwkD57Hqq81UsLlpdmHqnGgvGTCtaf2ZDkFRzJ67gWdvltcFLWrbdMDqJBd+tCi5w/546Pq7rGXWvOoyFYzUKYgOLYwvGorGO2MsFjMi0jsnTJoBoC1FuFMVKrhkvRbWBlUhHG2vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lf4tOH54Y/55x2m7kUeiM6hyQ3z3RHcFk0h8rsveLFo=;
 b=wzl5Mqwv0/1nlyRlLlVHFCOiKQknke+OmXWWHwN2Y97lZPIjVbu9OFiwBhYBpN1S0adPAuTmw55vfffDaRmM26mj9DkECU0zKlU0uvAQUonq6IAwnSJ794yPGlfhPIrH6juV+xh0WaxuyAlP2sTBoJs8q8VT7uVnPDs+2VLBBfdRDQwcgkAFEMEbjnTEWkpaiYPK0TPt2UUAirr4IpuaSP4cRHQlfZQ6H7opi7uvy6HD9QE+nJLWuIwZTvu0z2s0REq6vjzgAKrQIRI9IwYOYJB6QiqzEsMiyj3wnX2yZxsJgM2r1lRcQE/d0pzOT5w5s6X+l+qqP5pP8eoIi5EsYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lf4tOH54Y/55x2m7kUeiM6hyQ3z3RHcFk0h8rsveLFo=;
 b=wKQxhz5rY4oOQWvHF1uiFHWZB7UNRlwDAEVydMizLiMkvg6pBaGGmv8RGwKRaLu9pU03BB7inpti1wYzbiHBhcXGDQ6XBBYrC3xb61RHTkN7aWLgmKMEkb2bki/r3IvOJrXUT1M3bfR9pzwFg7egTBLLWmuLv3mgCSeqSdD115U=
Received: from SJ0PR03CA0067.namprd03.prod.outlook.com (2603:10b6:a03:331::12)
 by DM3PR10MB7928.namprd10.prod.outlook.com (2603:10b6:0:44::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.11; Fri, 23 Jan 2026 10:40:22 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::48) by SJ0PR03CA0067.outlook.office365.com
 (2603:10b6:a03:331::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 10:40:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 10:40:21 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 23 Jan
 2026 04:40:21 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 23 Jan
 2026 04:40:21 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 23 Jan 2026 04:40:21 -0600
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60NAeJQr2198431;
 Fri, 23 Jan 2026 04:40:20 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 23 Jan 2026 16:10:19 +0530
Message-ID: <DFVWL63A8IDP.23PE1QNTXTMRU@ti.com>
CC: <ilias.apalodimas@linaro.org>, <malysagreg@gmail.com>,
 <sughosh.ganu@linaro.org>, <philip.molloy@analog.com>,
 <marek.vasut+renesas@mailbox.org>, <james.hilliard1@gmail.com>,
 <anshuld@ti.com>, <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <n-francis@ti.com>, <u-kumar1@ti.com>, <bb@ti.com>, <praneeth@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v3] mkimage: Default to 8-byte alignment for DTBs added
 via -b argument
From: Anshul Dalal <anshuld@ti.com>
To: Marek Vasut <marek.vasut@mailbox.org>, Beleswar Prasad Padhi
 <b-padhi@ti.com>, Tom Rini <trini@konsulko.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260122172247.2995437-1-b-padhi@ti.com>
 <20260122174546.GB3416603@bill-the-cat>
 <c05217b3-f753-4fd1-9582-921e2cfd3a0b@mailbox.org>
 <b65ad902-2d07-4948-8a1a-64f4d5825a08@ti.com>
 <1e1f2e09-bfb7-4c7d-abd6-25a79271f256@mailbox.org>
In-Reply-To: <1e1f2e09-bfb7-4c7d-abd6-25a79271f256@mailbox.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|DM3PR10MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: 1647bbfe-f060-4d68-1b38-08de5a6bcf69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RjhLa3RQUTNUTitDQkNvbkQ5ZWdTSjgzVG1IZDU4cG9MUTF5OGhMTjhrNlJZ?=
 =?utf-8?B?YldLTzlQa3lweEtFckM0ZXB0aG00dGNhZFZ0YXF4WTBHb1NLZnJHZDVXdVVm?=
 =?utf-8?B?UW1pY2xzcWlmTGorYnZLSHA4VFd1WWtoVGwyUUdXWktsM0xmTGlzUGxpM2Zr?=
 =?utf-8?B?aWxaVWN5enFQQkozTktTTW1FQnFMeENTNmV6MzRZMm5zL0pMWTloMVJGSFYw?=
 =?utf-8?B?b0R2YTdJcXYwUXBiaFA4emJMQjdDSElIUjVPSHJCenJ3YmQ0OU9xRnh6dnJ6?=
 =?utf-8?B?eDdYeVZIbWxObkUydlplTUJjWWZvb1JGNHVNU1NURFBVN0FsYTFpMmp4QTRs?=
 =?utf-8?B?ZXY4V3VzYzZpKzRYcHdwS2dsOVI1TlBXTlk2OTc3c3BXRFJwdDhuUmFmdVo4?=
 =?utf-8?B?R3FGcW1UTlYxUW1LU2tLTHJNK1BYcDdwTXN4UUR1R1F1SzMyV01tL1lkYnJs?=
 =?utf-8?B?MGtjMS9aU1ZrRWtaaTRTL3pNQUtvaWFwNGVieDJtaGlXRDVGUWVlRkZ1dzVS?=
 =?utf-8?B?UFBiYmF3VlMwczgwWk42dFpKT0lPeWEyT2g1RVBxZlBSTWgzclBnQUV1VVRl?=
 =?utf-8?B?U0lqM0ZSdTIvYm9wcEZYVjd1cjllK2NLbmVDR0toZVFmNjcyUUMrNlgwNUxB?=
 =?utf-8?B?MlVTY3lPb3ZtWWFXZENCRUZRRjNZNzdabSt3RVpXZkV4eE9MWjZxVDkzeUF5?=
 =?utf-8?B?WTJTcU4wMmhMczV3dTl2ZjhndUljZGFXRmczWVIzUURNdXkyY1JFVXpTbFhp?=
 =?utf-8?B?VDYwZFBYcUJzeGdDeDg5SUZIRzdtelJnbHBtZmpJQ3FnRXM2UFZkcDBKZWcy?=
 =?utf-8?B?aVlzbFBNTVNHWk1LRUx2UzhjM0g1dVlhT2JGUk56amJwYXkwcWtFV0ZEQjly?=
 =?utf-8?B?b1puRE1uSEQzNWhVUkVOczF1R1plMCtwZEdiSTJ2eE1ZNjRtalhrSTN1VTR1?=
 =?utf-8?B?cXR1Z3ZURnY0Qmc1Uk5reEhwSEpCUjBsaHBVdzZITStWVlFhRHRhRHRtT2I4?=
 =?utf-8?B?aUlyZXphZk91UTZLVmt2Sit2NHFTWTBraGd4MWpHckFVLytwSU5CSUJKdlU4?=
 =?utf-8?B?R2JvWEkwZ2UrZXRRVGY2MDQyLzFKMHloajRkSFZVR0UyS1RHREpwTzczL25k?=
 =?utf-8?B?U09qZWd5SUNRT2NVUDI2WlFLTEZ2VVBTTklXQmFPN2luTmt5dG1yaVZidHBa?=
 =?utf-8?B?cmFMYjUyaDhNbUNYaTRyZlZQUlVYMzdCenhKcGsyaktOeVUyZlo1RkxGOWRj?=
 =?utf-8?B?bnNlUDd6R3RhWVZ1Y0ZkMnkrQXlFbmtqaXp2Sk1vUDB4TGJZNXE4cEFnZG1N?=
 =?utf-8?B?cUVsMUpRS25BZFRCLzZwVHFpcTJKbmhNRVNrdEMxRHRyUEovb1pHMTRuQXkr?=
 =?utf-8?B?aVo1NXpKRUhCWm1UcDNBNVJjNm0wRW0zUDlyWjNjNzF5S3RMR21KbGxGYURn?=
 =?utf-8?B?K0Q0TE43b0pqMUpjeTM1S0dJeE5EMG44TDA2aHdIa1J2cHFEVXZwQjA4RUth?=
 =?utf-8?B?dXBkaG1EMUhYOUxORkVTaG5qYW5WeTE4NGxvMDR6NG1YUE1Eby9GVmFVeEF6?=
 =?utf-8?B?T2VwODJIU3JqaU5jVHBrTFBadzVxNkVPNG5HRDVuWkRadkhKcWt2M0I4QnNJ?=
 =?utf-8?B?TGJKZFRFMGhYMUFFWnlubXFOS2xBbzJWVzFWU1NaWk9ESnZtT0l6dmY2cE05?=
 =?utf-8?B?SDA0Sm4rZThuUExBVHNoblR0V2Q0Y1NqOXk2a3Y3S2d0L0NXbDdTaU9oOE5o?=
 =?utf-8?B?Ylc3RWxDMVpZb3YwNTRLWWprQnhDOTgzc1NSNXRoV1k0ZWYrMEhQbE1JWTdm?=
 =?utf-8?B?eHNqQVhjOXRpa253TUFXdFExUzFObkpmRFFKR1ZzZDJtdHM1USs0UnFMNVRZ?=
 =?utf-8?B?bVBDSVlzdWpHREZaRjBiT2Iwc2RPek5hUnVjMEtsMEpmc3UxRmdmcVFReFE5?=
 =?utf-8?B?cm51QVNaWkRkQ0hBeHdJMlNJTmdJRytncWNBNkZHTGxQUm9aQXZWNVJDcEw3?=
 =?utf-8?B?ODQwUHhPbXlsV1pXaE8wUTEzUWo2R2VaWFZpMVAySFFTbktjQ0xRaEFZK0RF?=
 =?utf-8?B?bGdRUjZGdUpmc3JpUmRqbURnNkE4RnhNQVpqdUx4OHo1V3YrMmhXMnlFVGxB?=
 =?utf-8?B?S1RDTWV6akJaSkYyYmRPN0FmZVNMTy91Mm81UTdVVnJZSmh4azNmM3FqSVVq?=
 =?utf-8?B?QWp4ZTFjdHdOWDdFNHZHNzRUVG9URzR2RC9MVnNNOGZjcVNLaVFPWDZkbWhG?=
 =?utf-8?B?c1kvUlQrTWx2YzcyQzFQYXdBWjd3PT0=?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:40:21.9591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1647bbfe-f060-4d68-1b38-08de5a6bcf69
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7928
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

Hi Marek,

On Fri Jan 23, 2026 at 3:57 PM IST, Marek Vasut wrote:
> On 1/23/26 4:32 AM, Beleswar Prasad Padhi wrote:
>>=20
>> On 23/01/26 00:33, Marek Vasut wrote:
>>> On 1/22/26 6:45 PM, Tom Rini wrote:
>>>> On Thu, Jan 22, 2026 at 10:52:47PM +0530, Beleswar Padhi wrote:
>>>>
>>>>> When CONFIG_SPL_MULTI_DTB_FIT is enabled, multiple device trees are
>>>>> packed inside the multidtb.fit FIT image. While the individual DTBs
>>>>> and the FIT image start address are 8-byte aligned, the DTBs embedded
>>>>> within the FIT image are not guaranteed to maintain 8-byte alignment.
>>>>>
>>>>> This misalignment causes -FDT_ERR_ALIGNMENT failure in
>>>>> setup_multi_dtb_fit() when locating the next available DTB within the
>>>>> FIT blob and setting gd->fdt_blob, because of the recent libfdt
>>>>> hardening since commit 0535e46d55d7 ("scripts/dtc: Update to upstream
>>>>> version v1.7.2-35-g52f07dcca47c")
>>>>>
>>>>> The mkimage tool already supports enforcing this alignment via the -B
>>>>> option, but users would have to specify it explicitly. This change
>>>>> makes 8-byte alignment the default when using -b.
>>>>>
>>>>> Reported-by: Anshul Dalal <anshuld@ti.com>
>>>>> Closes: https://lore.kernel.org/u-boot/DFJ950O0QM0D.380U0N16ZO19E@ti.=
com
>>>>> Fixes: 0535e46d55d7 ("scripts/dtc: Update to upstream version v1.7.2-=
35-g52f07dcca47c")
>>>>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>>>>
>>>> Tested-by: Tom Rini <trini@konsulko.com>
>>> Doesn't this enable 8-byte alignment for everything in case a DT is spe=
cified on mkimage command line ? That doesn't seem right ?
>>>
>>> If I do mkimage -f auto -b ...dtb ... , then I only want the DTB to be =
8-byte aligned, all the other blobs can be 4 byte aligned just fine .
>>=20
>>=20
>> All the mkimage flags are parsed at once and populated in the params
>> data structure in one shot in the code. There is no separation of code
>> specifically for generating a FIT for a DTB vs for anything else.
>
> That does not seem to be true ?
>
> $ git grep -p '\<bl_len\>' tools/
> tools/fit_image.c=3Dstatic int fit_extract_data(struct image_tool_params=
=20
> *params, const char *fname)
> tools/fit_image.c:      align_size =3D params->bl_len ? params->bl_len : =
4;
> ...
>
> So something like that may work ?
>
> "
> diff --git a/tools/fit_image.c b/tools/fit_image.c
> index 0306333141e..0c606ba4cc3 100644
> --- a/tools/fit_image.c
> +++ b/tools/fit_image.c
> @@ -642,9 +642,15 @@ static int fit_extract_data(struct=20
> image_tool_params *params, const char *fname)
>          for (node =3D fdt_first_subnode(fdt, images);
>               node >=3D 0;
>               node =3D fdt_next_subnode(fdt, node)) {
> -               const char *data;
> +               const char *data, *type;
>                  int len;
>
> +               if (align_size < 8) {
> +                       type =3D fdt_getprop(fdt, node, FIT_TYPE_PROP, &l=
en);
> +                       if (type && !strcmp(type, "flat_dt"))
> +                               align_size =3D 8;
> +               }
> +
>                  data =3D fdt_getprop(fdt, node, FIT_DATA_PROP, &len);
>                  if (!data)
>                          continue;
> "
>

I just ran a quick test with this diff and it seems to fix the issue for
us. If it's okay can we take the change as is.

Regards,
Anshul

>> We
>> would get the same result when using mkimage -f auto -b ...dtb... -B 0x8
>> I think we should be fine with this limitation for the usecases when
>> generating fitImage with mixed images. Unless you have some idea?
> What about the above ?

