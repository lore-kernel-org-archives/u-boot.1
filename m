Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78167CD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 15:29:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E32B184915;
	Wed,  6 May 2026 17:29:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="FDGT9fp9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8894849AE; Wed,  6 May 2026 17:29:09 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D93D48490D
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 17:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkjAw1WPiPCNOKJ70EkRBL/vbRa3H5jJ7OVGXi7xHNt4XlZWRqkh9F8oSUi2uP0F24G2+6MGQawZ/mGBRARr3vT+xtmoblzLe1V0o+5zlsOC+OmwgHf0jjMA919fPgqtlvzy2Y1ATpnqdsRUeKkjDE4COskOzsJ5ds8BWXHydlVvZtpr7Xl/zNvY5h6qN4xD988d5kB0ijWXJhsAgSo44b1rEWMyMJi0+yaoqABdNBBsWWeb84kejAL2CjgCYQ4bnoPu42Fo4lwVjFYekXzFoQQOcMVR/QWVGXX6B70jGHAFddKaKJE+fDq8oNauH9WPax6xPhl05tRjeFioTkl+ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MSP+g2yIY5g4RNEdXxKFlTR9EGW7o+Bj6Y6QiF+TYQ=;
 b=pMeVe9VnWCJzjlRndf7vhnA/SOAofEQgUF35ra01HdZBvgeg4crGUrdxtqtVrrYJFJCXhusJfmFNWkBi9glpXHZgdKwTLJEn3LpXOX/dbnpO5fwYcxRRYWUhxrS3T00rrGTd5o5DF8xUsUCGJYlCu466Ob5keAtKATmD7TXn0Yl+gRErdcaCne3OMD7ZtsycCAJ+oBEpMkIaEAsFnt8AHa1cSQsF67KwOcrpMyjpSMMs8dCb+NG+5Oe4/fgSwVy0RsgfX4coU7zV6JT/Sa9cMIRGsb3Zb/1B3KlrziLd5h/ydsdJ+yd86g7JjdlYd6qke5CuRDRW6H7dwpVwovA0GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MSP+g2yIY5g4RNEdXxKFlTR9EGW7o+Bj6Y6QiF+TYQ=;
 b=FDGT9fp9R+SrYxQaS+s/tz7Dg/AkUndTbj2guz724Djo2RJLR8/4EiRzQWocYVuI/xZHhP/2l0vO/P4XbDAL6JGbPLWy40mUXrGpMN8E1EiMuG5zPzKrOsTjqQ7yWSviBJY+z9cQoICx/WrNP0GIQQqW3fpY/7QYMvZI1tBU4TlltSeEQvFUmbFDQwn5vBUbU1LQ75aL7ygB2TG5O4BlgppN/lbo1LTzviXHHpeIB1HMeS7569LfJzROocdWAtpxLSLg+e5dznWumk6vRJ0HfTxTJ12z3jPZ/XBIcdpOGxIeEwXtsH0fBSsO0wFvz6b8GEYAZ15Wjdk3K6psQPqj2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by GV1PR10MB6539.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 15:29:04 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%7]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 15:29:04 +0000
Message-ID: <79f3438d-a6d9-48a8-8cdf-01dde7b5e2b1@siemens.com>
Date: Wed, 6 May 2026 17:29:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] qemu: overlay signature nodes
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
References: <20260430122629.606153-1-ludwig.nussel@siemens.com>
 <20260430142602.v2.1.5f8ce2dc2b00328d29e64be2684b10d9f52c6a7b@changeid>
 <CAFLszTiTCsLgdAasexCb5Gv1zkdAo6m47D2MEgYxqwpkfAZoNA@mail.gmail.com>
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <CAFLszTiTCsLgdAasexCb5Gv1zkdAo6m47D2MEgYxqwpkfAZoNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0417.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::8) To DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5019:EE_|GV1PR10MB6539:EE_
X-MS-Office365-Filtering-Correlation-Id: 76302e5b-5dc7-4942-5b4d-08deab8434f3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: NrOgOBPVyuYJ4E36qHMnUwGawKiqdYTKJre5tvT/FjyODx+AikjoZ8CS/Y23hTev3iADXu0k/xPiMyBWi7AH8m8frL3x+it0ybsFJ0uDUEhBruND72pxa85e6Upbb8EDNAqsmsBm4+v2KcF515e9nVW9z1+t++BaCHj9HeMSTS8fYWZvswqZDn3ZQ9jkJwkpRocOiFIrO0I7l9wIEv2mRoFnT5FWhAVfQDQ9yvnwIe3Jcyn1E+1K43ZcPfm0yVNADlFGZ+qdrHil6UV90KpiHkDka1VHMBYcWKacPwf9wYOdeSkp4oyHqXXliyGicIezSFaqEwY1lnxSfSER7k3UpYmpp8ySRFMxhnLSB4w0apjAe/ckwDEgxlQfFxOqVwNhPqNf0scYIpJzhha9rgQPV11SeGDZ6Af4UT3BT3qL+glco4rJvBU3TCtObaA1QiK4MRD1EpF4pGIs10RnQE7ROSoE+6w33Ax3fPAdFEYkfBWSPhin0iMfMe4Gm1EV0mXcoqmjkBJWO3kGZCSXssiPKOReftgP0MrUFvBlJrC0hQ12I1HbDYdLI3TdU2hr9gI2/H9XmS9bo4nv18X4+CY5ecMP13SLEHtyWYET9UxjQ8BpwSTu8mQx5kskQi4Une4wRDkci5GvxmJHEXDRfBBDEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDFpcGZBYUFIdlZtNU5BYTFobk1jS2pua05TQUFQLzRyQm1BbnRZdTFheG9a?=
 =?utf-8?B?dzJQeUk1YTRFd1F3RnFpNWlIOVFQMnpXMThpOC9JUHF4eEV4TGxIOEwzcjJV?=
 =?utf-8?B?cXR6YytLNmdzakJlbE9DUWdtSlFrMXhaZUNNOVVUMzAvZFU3K3AwY25OdGlD?=
 =?utf-8?B?a0pSWnBTZlo1U2VtSXBXSkFaTUtHa29kODFFajlmQ1lybW5ycG5VejliN2R1?=
 =?utf-8?B?OEU4L0VvWjZYaFNhUUxPR2xCbEpkeUNDM1U0TSt3SmdDdWkxYzJySE12NTF6?=
 =?utf-8?B?N1IxSW5jUXU5ckJYMWs0Y3J2RUlrSGE0Y0pSSmhGSmwrbEtjWXhrQUVneFRT?=
 =?utf-8?B?VmdadnpuM25pVUJwU2EvdzJhbFB6OE9wK2MwVmorK1Fla3FVd0RYM2lybE13?=
 =?utf-8?B?RWVNanRZcFNYUnVkRklZK3RmQTE0azM0dHI1QVp2TnJDbE9pVDhkQmY1SDVE?=
 =?utf-8?B?MXVFZ2JmZG52REJyS0NjOXE2SVF5c2Exb1h5ZnZjc3ZrY1Z4Vm1IdHM4UVQ0?=
 =?utf-8?B?QzhhY1E2Mjkwd05sS0xkVmNOdm56VmFPbjFlMGM5Q25HcnE2RldCSG83WHBJ?=
 =?utf-8?B?VHRoY1YyU0hjQWdOUldSaWxPdi91QTZlaEc2V0RSTXZ1VTVqN056LzJsWFRB?=
 =?utf-8?B?NWZKaVVkd05ZeEFXTlRqcFBUam1BYktSQnY5MDZjRm1RZEtUSHNneElTenFh?=
 =?utf-8?B?SE5YUmwzZlAvU1dXQVEvKytQL3JxM2d6YVV0QXlaVHIwMHNXdlFNTFJYSm5w?=
 =?utf-8?B?VDRiM09VOExEamprbS9sdmVKVHg4TmsybGVFcUMzRE1pdkJDVFVmM3JHem0z?=
 =?utf-8?B?WndLLzZzd3dJa0RPUWlGcFpDWGwzeldLYzlkeFh0UkVYV3ZZcmJaMWhPZzkw?=
 =?utf-8?B?ZG9WQTQ2NFFyUjh3T3NEOWZLN1JXbE5MaVZYdEh1djlGR3JQN2JSZDRpRXZI?=
 =?utf-8?B?cUpkdWpFS05jdzVpNis1TktKNzBsS2NYWWRjcWxEN2l0SEVxbkxzcUNobysv?=
 =?utf-8?B?TnFlakI4V1pjSlo3V3FhenZ6ZTd4dkNybm1zZFhNd2ZrcEV4MXhGVzRsQ015?=
 =?utf-8?B?UkdQUVVYK2kzU05CbTFoNlZFMzFzOFBJMTdDQzdQN1R5b3o5TXVZS05TV2xz?=
 =?utf-8?B?Rzc1NUlkdUd0ckNlNlNZcStEU0UyS3d1M0xnRGdKRnFNc3dIcEZyTURwNXg2?=
 =?utf-8?B?K25GWW5yOTNJT2Zxa3F5RFZ3bG5qakV2QlM0cUd1My9ra1J0N3gxMGdYenhy?=
 =?utf-8?B?Ky9BdXVocTBPS0FVbXRmVVV3MVhSdE03QVhGaGJxUkczZGUyMzFHcFVjSmsv?=
 =?utf-8?B?b1JnZkc4QjNaTktIY3YzZ0IwVmNXUzBCWk1UV2NzZ2RHV3NvdXlZcU9JMVFY?=
 =?utf-8?B?NHpleGF5UHF3OFRUbXZzcGdJem53WVduVjA0R1k1NTB6UG5LaVFPL2QrdElV?=
 =?utf-8?B?SEpoM0ZTMDFEMFBPUk82b1RyU1ZFSG0yUFRzN2Vtb3FZUFdyeG5hMnl5Ui85?=
 =?utf-8?B?ZDM2REpNUURIMlFBU2hsYjRoMjYwTFpRVWs0Zk9PR2NPY0N0NTdnTi9aSWJP?=
 =?utf-8?B?NmZ2QStDcVBub3pSYysrMm5KM21NUFJrOEhYcGdpQ3hwK2NrNUNxS1BzYnNQ?=
 =?utf-8?B?VVRmYmx1azlIcHRmTGtxQ0pvZTliSUs1bTZjY01qSmx3RzBCMlhlZCtYTUdT?=
 =?utf-8?B?M2E0cDBic0tDR3oyZndnQm0zMFBhMGthRHZmaHY3RTNIbWVQaXpEZGtSTkJp?=
 =?utf-8?B?RDcwQjZuMGx1RFgvOUF5Zkt4VHd4Q3FhNmY2YnJueXluNE56Y0hUWnloc0Zp?=
 =?utf-8?B?eStGME1YbDZGYWFLNFUzTWtCUGRPanQzdXdPUU1Yc1lrc0hZTXA0WXZ3TDlG?=
 =?utf-8?B?bU1zRktvZGE4NHh1aFkrVTI4SUtFZGdLZjhnTUNmUkNYTVdFZmhHeFZsUUFY?=
 =?utf-8?B?NjJHTU15WFZhWlM4blZnVHF6TlUzcDZqWUtySlFaNXZIWXZBZG9oYXAvSCtU?=
 =?utf-8?B?ait1Rm1zVjhFekpOcm9HRFo0RER3a24yRXdkZGJZUVF2OS9jVHJvSDNiQzRB?=
 =?utf-8?B?TDI5QWt2Y2pGc3AvZEVNTjFBSWt3ZXN4TnZadWQzQUZXa3EyRks5b2NNemts?=
 =?utf-8?B?ZDc5SlIxYk54ZEdma1N1SSttd0pxUVlXTHYxcUVDYng4WVIvOUF6NzBKU3BC?=
 =?utf-8?B?RFZJNUQ5REwreWFOeGEzVmk2V0daUVdjNnYwSllYVWJkL2hpV0VtYUgxcTJx?=
 =?utf-8?B?T20wYzEyVVVDREcxNnN6eEZ6RWRhM2c0SnI0K2pCUFU5SnlOUXlLNGtZSWhQ?=
 =?utf-8?B?KzY1eUNPQ2VSeEhJQmxxaTBqemlxbGtLOExrMlFGbmFNT0NVZDh4QT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76302e5b-5dc7-4942-5b4d-08deab8434f3
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 15:29:04.7172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hqHZD9FG3RhevzaqefnxSdbomBJfCNwgMdVZl07fwaiiDNnufHxuzIyHEVenoarDGt7/M247hAiLyXDR02yALbkpN+ekxB0RySj/kvQKXNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6539
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

On 5/4/26 14:26, Simon Glass wrote:
> On 2026-04-30T12:25:59, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>> qemu: overlay signature nodes
>> [...]
>> diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
>> @@ -147,7 +147,38 @@ int dram_init_banksize(void)
>>   int board_fdt_blob_setup(void **fdtp)
>>   {
>>        /* QEMU loads a generated DTB for us at the start of RAM. */
>> -     *fdtp = (void *)CFG_SYS_SDRAM_BASE;
>> +     void *qemu_fdt = (void *)CFG_SYS_SDRAM_BASE;
>> +     int ret;
>> +
>> +     if (!*fdtp)
>> +             goto out;
> 
> This runs the opposite direction to qemu-sbsa, which uses the U-Boot
> DT as the base and overlays the QEMU DT onto it (see
> fdtdec_board_setup() in board/emulation/qemu-sbsa/qemu-sbsa.c). Done
> this way, any node in U-Boot's built-in DT that shares a name with a
> QEMU node (/cpus, /memory, /chosen, ...) will have its properties
> merged into QEMU's, potentially clobbering the hardware description.
> If this is correct, please explain in the commit message why the merge
> runs in this direction.

IIUC the FDT patching happens before relocation. QEMU starts u-boot from 
a ROM at address 0 so writing to the embedded DT does not work. QEMU's 
provided DT is at a writable RAM location so patching that one works.

I don't know which direction makes more sense really. If you say merging 
QEMU's DT into U-Boot's is better then board_fix_fdt() could be used for 
the merging I guess. Looks like that could work with
CONFIG_OF_INITIAL_DTB_READONLY and CONFIG_OF_BOARD_FIXUP set.

cu
Ludwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com
