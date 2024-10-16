Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A13D2069A
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 06:00:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8CA388BB2;
	Wed, 16 Oct 2024 08:00:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wku0gzFC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 881D488B8F; Wed, 16 Oct 2024 08:00:20 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A44988BBE
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 08:00:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wnDI/pPI5QzCPXEiou9vKswCcl2Asqw+OUTKim01Jh0Ek+Q3vOdoExjJOI8FO3NDaUx4UdRLuC3QM3L9573pKJjWcXHgl/RQUQB2hPBhR0j6uuKxsVpPeUdrZNi3OylyffHxN26X7EFSnkPVeOmAvy+7SSfKwZmfmrRIgyQXYFYOD/xCljJq3wQCmpfQ72hObqfGSgztj6OKiBCAdDpW1Aj+5JutdrQP5689oNfORkJ1YTNXmYoociblpq1W6tD7eAneSxT/u42rs5m59JKdogowtk8DSkg/1E9kIa4F/yaReyKKX8KBb7c0NF0bEoKLGjxmvs6WD/8vDEX/D7Wx8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKzwxwF5u+mo/L73mPjNwqKII38LrWn4wn57btaC0zI=;
 b=A+bpK1dEEN0FsL4k9hnKDQSeq2FH+TIhgPdm5M29Xc2kI6Yb1uMo5aRZUs1m7LM3HE1QDNk0fxRwK6m6n1tWaOxTIVX5XMp1COMTDqwoCHvsPfMznq7jks7qLXrEvgF+Uv97Txr002anFMLauBFLcdv47r1n60NUC2bSEWFLue46DlX7rOXr5Lc9viItq83N/wKiBQM8vusAmdqwU/fUIpPt8r4uO8kO6n+U9/zeEBw6lwKQ7NV6TrOm7S0nwSvi0UWrOBaVYYg7QJsJ5QCC7dDr6bqAaeAipm1aGQ51MA24xf/hijSDJzsMRwGvxwaXjTDtQ7KXGgG1T/Uas6/q8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKzwxwF5u+mo/L73mPjNwqKII38LrWn4wn57btaC0zI=;
 b=Wku0gzFCPQHXLUcghMgldkYAQHqIEpiakJX26a0wNtARsDtZMLx65cSCQjn1k2jOdKtxOJXbsq+CFpcK98hSLjr/xYhz3sqwXewEOSCN7TQF5/gHYZKN+cNu4KR/EP3HRu/+sMRFQeyPESAjAFQRuOPXO2cc2bXtUmdZkSbyJUU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB8187.namprd12.prod.outlook.com (2603:10b6:610:125::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 06:00:09 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 06:00:08 +0000
Message-ID: <6e7f9046-2e7f-479a-80e1-59e7b20c48f7@amd.com>
Date: Wed, 16 Oct 2024 07:59:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binman: Add option for pointing to external description
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, git@xilinx.com,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <fbed0251437b61a2f7a85596d7403b5b9c8237c1.1728306322.git.michal.simek@amd.com>
 <CAFLszTiBHjqc-xeqsC51hFUed8bigv8+WsC9hUnv_tEC2RahcQ@mail.gmail.com>
 <d2a8f534-a983-4092-8fc2-ce45b54de476@amd.com>
 <CAFLszTjYOoNcMc7MTA-RdR_mKwM+8t=yKRpuYZSfqOvVBA1_PA@mail.gmail.com>
 <a0077320-9c92-44ec-9614-3de1fc1d36a6@amd.com>
 <CAFLszTjt6rrHUzg=evPS5-FyvMrZ1DocwyVc9x1Pq2K9XMokCg@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAFLszTjt6rrHUzg=evPS5-FyvMrZ1DocwyVc9x1Pq2K9XMokCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0190.namprd04.prod.outlook.com
 (2603:10b6:408:e9::15) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: cb5c774e-a185-4b5b-48f5-08dceda7ca30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXZiVWxxM2MwMC9CRXpnN0lnYzk5Q0xpR1JVcWd1LzNYdUxCRlhpQ0U5YUl2?=
 =?utf-8?B?Q3VXSG9HMGM1YUVUYVcwK29pM3hETUlMS0tVdDR6UEhkc2g1bE0xRFgyQWYy?=
 =?utf-8?B?amo0djNVRWZMOHMvRnNqYTM4L3NGNGJ5K05xVHR5ZTl3TzVFYzNONElBUUsr?=
 =?utf-8?B?Si9hN2pSWnZManEwdWNBVVFaK3drempGWE1GUXdTM3hLQWpwNURhNWVaSy9E?=
 =?utf-8?B?M0E1cU9VdzVMWGFrdm5oUjd6WkVVbUlUQUFuRFVUYWE1U0ZGdzBHL1hEd0pG?=
 =?utf-8?B?Z1hMTXAydGR1VmxtUWs1TjVGT21aWktRNXRLRFR5NSs1emZmUDdIdWNONTJS?=
 =?utf-8?B?VWFVaG85K1lPVGgvWFVIWiswWnZtT2luUnBMM2VCVkZHZTYvcU9iOG5SSHQ1?=
 =?utf-8?B?WGU1cWJjYTB4elNpYmN3SDloZ01idUVvYWI3WjhDLzJuUG9PS1AwajVnY3B3?=
 =?utf-8?B?Z3ljSHNiQ0J4aTZjcGZBdHpBWnRuaGZUSUNxb0dEbWxjY1h1T0lsUXNQWmVT?=
 =?utf-8?B?eHJEUklDSUlRT3ZRbjRUd216ek0rcWYvdGdtUzhBelg3L0pkcERPWE12MExl?=
 =?utf-8?B?OUoxN3RtYUo0V0wxY2dUQmhDRmFVYXJITzZaUG1ZMlFTbHBtNEZleE1vSjRE?=
 =?utf-8?B?YmRCMEUxVXI4QlUyQkRwMWR0TytOeFJMU1JxSGlYcnNBN01FRllOeE5TU2tC?=
 =?utf-8?B?K0lSTzRKMS8zbVNsMmtydnpocDcxaDl0Nk5oRjE4K25QcjNXVzBkeUVQc2RF?=
 =?utf-8?B?RmtlU1VXUjdzUmI1L1BIMFJoeGsvcGUvQ2owZTR2TmNxMEFrb09tdTNyM0hL?=
 =?utf-8?B?bHNDckxoQ3lyV3FaelBKaFdjck56VFh4WmNzSTQyS2tiQ0NZUkM0QWtaYTln?=
 =?utf-8?B?TmQ0aVBjTGlKbG1MUjZDdEFxUDhHcmdGbkRCL2NlNUhvR3V2NFIwOHprY0dS?=
 =?utf-8?B?RmZLWUt2eHN1M1YrTXFTV2t4M1FMdzJkWWdtckJaa1JtRThmNG9vU1o2Z0xV?=
 =?utf-8?B?dVlycDhQYysxZjdlMDV6eVVia3pnWmlEVWJJVHVlNENQTGNZeDRhcVd2L3RG?=
 =?utf-8?B?WVlLMEJZeG9qYUdZZDhKRnI0NDFTRUlrSjNmQWtVTjhQTnd6SXhUWk12eWpY?=
 =?utf-8?B?UmhScStoelBUZ1N0cnBOTnZQT2M0TFZ4b010QlZ3b2E2VzRybFN4WmRFQUJG?=
 =?utf-8?B?OXg0ajYzNWwzei9vclIxNlNyS256SkZSR3ZFVnphMDU5c3R3dHpVK0UzL2da?=
 =?utf-8?B?WS83a29EM0ZZcXEzWW5GUE1USi9SOGN5QzZGdG90ZUJ6VGdxSnVOQWZhMmtV?=
 =?utf-8?B?Qms2U0hxWUJvYWRUb2RwV2NwSzhDYjN2OHVqN2h5N2psMm9XSnJzTjFkYVFU?=
 =?utf-8?B?b2YzNlVPYTNKYW5lV0dZcm5FdUdWZXp0SnZHK0xqcGtvaFJHRG1lTU9HQ3o5?=
 =?utf-8?B?L1Fhbm00V2ZCZXJNRWZDekhDQVFZandINERHdFFKYmtSdGRGM0xmbzVFcVJN?=
 =?utf-8?B?Sk80S2pSTUJJakdjdUl6dTV6dU9PWm1HSndBK1BpSW5PblZUTjlzalN3MkNR?=
 =?utf-8?B?azVtZm5EY0xCU3VjK0dXSHp5clRjSm1oQXBzMXBRMzJHMVdLZ3Y2UzRNcmZO?=
 =?utf-8?B?NmpjK25GVmFnNHhXTCtjUUlvUDd0MGtFdnhlM0QzNVp5MDhwSHdxSENrUnlQ?=
 =?utf-8?B?SG9uNU9RM1JiY3pvcWIzeitGUTRJdEt0c3R2Q3RhSkFKWUIzanNFNXlRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVFTVWhRT0JTS05lbWZxNFFCV2Y2cGZxQzdKSTRMRzFaWE0vK1JlUzRwVEhV?=
 =?utf-8?B?Y2xraTJEVktRK0dLVTVRNUJxRFRETXBadHBwZUNVV1dnT3pTOVpnVUI1VHJv?=
 =?utf-8?B?TzE3ellWdllvbTlSNDdlVVFOZVVxRHM4S2k0Z1ZzY0gvQlR1OU0wSzhTMGxo?=
 =?utf-8?B?VEJHa2FUQTcvdGswOVlyYlVZMC9kbFg0eFdlSFl6NnA3bEZhd0hCUHNHbkF0?=
 =?utf-8?B?WWxSUWozc1pwRloydnNHUjE1ZDJNRllibjdOb0w3NTRMa1AvWGs1SzNWdyty?=
 =?utf-8?B?RC8vYURLUVZuTXYwZ1hIWndrUmV4K2N5N3V3aGpIWjIwbnlXL0IzV0o5QnYw?=
 =?utf-8?B?RklWQ3k4UVBQaE5xcE9JMzl6UFo3MVNQSVg1K2IwQU9rZThlT0hYc1h6TVRX?=
 =?utf-8?B?WHlFT3lCVWZHdmhkQXBUOVlvcm02OFhRN05HOXJkNGRMUXJLbVNZR2FKc2Y3?=
 =?utf-8?B?OVNjWExTQ09teU1JWExMYzA2TWhKQlBDNGxQVHdYaVNtYXRsRkpHRWJWSXFx?=
 =?utf-8?B?a21qanFpQ004emRobjRRb2JURTluM3NaenRiUHordFdtaklPU01kRnFjZVJ6?=
 =?utf-8?B?VFRNL2t5dUNLSmgybmVMZzZWRHp6WDZISGhtOXpZcWQvSy9ZeXppV2srVWZO?=
 =?utf-8?B?Uk5raE50anc0cDcyNTdaOUtkZ3RlcHNKRmpIVGVTL25tdnpPaXpKOUFnRlg5?=
 =?utf-8?B?bm0wUlZDVkQrVnJiSjVnbDV1SzVxbEJhZ2dBV0R6dXNzVElFb2NtM2JlS1ZM?=
 =?utf-8?B?c2RGR2ZqOGx1c0p5YjQrTkNKdTE3ZEs2N2tLTXdUdThNNzA3ckFXMFA0VXhB?=
 =?utf-8?B?dVJUZG96bnFwNzI0NFlUTWFGMzVCRWloS2kxUmtDOTRnRE4yclozTi9BSjJh?=
 =?utf-8?B?YTF6NGk2S204OHhsaU1pYm40TmhEaXo4cW4ra2RDbkxkbTJWeHRzRCtuNDhN?=
 =?utf-8?B?VGFJTFNVYU4zdU92OVhkcUpUMHRONS9la3gxYm5hYWR1cWp1OWpyeEJLcXBP?=
 =?utf-8?B?N3JzK1JLR1NTckc1ZW14aVd4bjhQVFM3QW1pODZxeUhKSGFHOUZsSnl3Ym9q?=
 =?utf-8?B?Zjk1OEd0ZmhRZDRFK1k2Z1hHTkhPMUpqQ2l5UnkyejlOVDVmdS9rRWg0Q0dT?=
 =?utf-8?B?eEhLeGRZdmNpZGZKblRKSmc3eU1OaU50cnB6S2JKVDNOamtiSHNBRzlvaTBS?=
 =?utf-8?B?eHdVOWtHa1p6T1dlSEdWbDQyeHE3dE5Pc2dKWUpSRWhFSCtiSDU5ZVVjNXQ4?=
 =?utf-8?B?bXpMOVV6VVBYelYzY3BqZjh0TFd6NkZWM0JZTlVjb1VENmpTZ1Jydml1RldG?=
 =?utf-8?B?ZmgzUTdvQnJDS2ZSancvV0JvRTJnRGpHS2t1ckhscG84ZUNRZEQ2ZHNsM1FO?=
 =?utf-8?B?ZTZBTmphZEYzVVNQZU41NVR0VktvWDdPWG1MZk9zTzNVNzVGN3ZUN2tKTktT?=
 =?utf-8?B?ZVp4MXJkMFU1bE9XRjVCazd0Slp5N1RVV1QrclVpUXg2SGpwRmhUNHpjVXV2?=
 =?utf-8?B?MmpoRTV5bDlITE5yT2lKcDdVTktPSHZ6RXA4U2hDTTRvYTA2MDBZUzhPaHNk?=
 =?utf-8?B?K0I1Vk1OekppblNJVCtHcVNxeW1wdmE3SkQrSnord2wvUk5scXRkdW5hSEZM?=
 =?utf-8?B?NjZlcHFWcElUeXZiME03K1Jjc01SclJtZ0l1UDZvK1FQUGV3MXlIZWdFMHA5?=
 =?utf-8?B?Qk1TUE5vTnF1dlRTemM2VWY0UXJxRGozTTFYUnpLcjl3a2dueWtaZko5M3Qr?=
 =?utf-8?B?dkVLTGVUcHovM0Q2ZmpzSXZqMEZwVFF4TXhzVXkrVDZjQXJ0RHhiMExRYUh5?=
 =?utf-8?B?M25zR05pdHdiVmxnTjhYay92NThoZVV4SzV4V3lXN0gzeXhaMFpaUDhnQkhZ?=
 =?utf-8?B?dCtzSDlOT0tMNGEzeGZ3bkFKbHNJWEV4V0Y1VitvMStJSzgwbjJ6REkwM0RM?=
 =?utf-8?B?bHUxemMrTUxEME1aWE01VWlrKzE3S3VDa2tPMDBJcTVkTEFTZEY3NU92QTFl?=
 =?utf-8?B?M2wvUVJYNG1HZEYvaTIvNTdYTXRvRFg0R2tZRVBYOGpETUNJN0VLMTdnK3dV?=
 =?utf-8?B?NjBZK1VMc21DRGc5cmFRVkZLRXBCWkdSL3BKbnMrQzA3UW0vWk4zUDhFL1RG?=
 =?utf-8?Q?N2u0B/OCCaAWtZi5//mS8DC8q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5c774e-a185-4b5b-48f5-08dceda7ca30
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 06:00:08.8634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SbIH1o3drj0QqX6OxO+OZU+VoXdKOPcoffBz/ZTZk1l5x8GVyRvesnNX4RVWPWUN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8187
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

Hi Simon,

On 10/15/24 14:48, Simon Glass wrote:
> Hi Michal,
> 
> On Thu, 10 Oct 2024 at 07:03, Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 10/9/24 23:14, Simon Glass wrote:
>>> Hi Michal,
>>>
>>> On Wed, 9 Oct 2024 at 07:21, Michal Simek <michal.simek@amd.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 10/9/24 03:55, Simon Glass wrote:
>>>>> Hi Michal,
>>>>>
>>>>> On Mon, 7 Oct 2024 at 07:05, Michal Simek <michal.simek@amd.com> wrote:
>>>>>>
>>>>>> Adding binman node with target images description can be unwanted feature
>>>>>> but as of today there is no way to disable it.
>>>>>> Also on size constrained systems it is not useful to add binman description
>>>>>> to DTB.
>>>>>> Introduce BINMAN_EXTERNAL_DTB Kconfig symbol which allows separate DTB for
>>>>>> target from DTB for binman itself.
>>>>>>
>>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>>> ---
>>>>>>
>>>>>>     Makefile    |  2 +-
>>>>>>     lib/Kconfig | 10 ++++++++++
>>>>>>     2 files changed, 11 insertions(+), 1 deletion(-)
>>>>>>
>>>>>
>>>>> Doesn't this defeat one of the purposes of Binman, i.e. to document
>>>>> images? We do want the .dts to include the image description. What
>>>>> sort of problem is this causing?
>>>>
>>>> We have two boot flows.
>>>> The first one (default one) is using Xilinx FSBL for SOM initialization with fit
>>>> image (DTBS) + u-boot.elf + tfa.
>>>>
>>>> The second one is using U-Boot SPL instead of FSBL. This flow is used by
>>>> buildroot for example.
>>>>
>>>> In perfect world I should describe both of these flows. I sent description for
>>>> the second as RFC here.
>>>> https://lore.kernel.org/r/de1b8dbabd5ab7f20d7aac217ec4f5074d39f1da.1728462767.git.michal.simek@amd.com
>>>
>>> OK I'll take a look.
>>>
>>>>
>>>> but it is also reasonable to describe the first flow but I really don't want
>>>> both descriptions ends up in the target image.
>>>
>>> Why not? Knowing what is in the firmware is one of the goals of Binman.
>>
>> If this is single binary composition with clear layout then likely fine.
>> In our case where we target evaluation boards which can boot out of different
>> boot devices it will be more confusing.
>> For these I want to generated all images also for testing purpose not only
>> images which you will burn to qspi.
>>
>>>>
>>>> The second part is if you look at RFC and how fit-dtb.blob is composed. It is
>>>> one DTB + DTBS which are composed from overlays.
>>>>
>>>> xilinx_zynqmp_kria_defconfig has
>>>> CONFIG_DEFAULT_DEVICE_TREE="zynqmp-smk-k26-revA"
>>>>
>>>> That's why binman node should go to this DTB but because other images are
>>>> composed with overlays binman node is spread to all DTBs inside FIT image.
>>>>
>>>> It means one binman description is in fit-dtb.blob 14 times which is far from
>>>> ideal.
>>>
>>> Yes, but I think what you are saying is that U-Boot doesn't need the
>>> description, so you don't need it to appear in the dtbs in the FIT. Is
>>> that right?
>>
>> Yes.
>> I know that there is a code around it but as of now I don't want to use any of
>> this feature.
>>
>>> If so, then I think we should add a way to remove it, in Binman,
>>> perhaps with a property in the top-level binman image.
>>
>> Works for me but keep in your mind that for SOM this should be removed from all
>> combinations and for me it is easier not to add that description there instead
>> of adding it and removing it.
> 
> OK, I think you are saying that the description is repeated in each
> .dtb since each is built by U-Boot's build system and then they are
> added to the FIT.

yep

> 
> But what is to stop people from not bothering to fill in the binman
> description in U-Boot? I worry that vendors will have instructions
> like 'build U-Boot with the in-tree devicetree, which has no binman
> node, but pass this option to use this other file (not in mainline,
> just our special vendor branch), just for Binman's use',
> 
> Where do you plan to keep this other file?

In u-boot repo of course. And all configurations which makes sense.
And pretty much if vendors wants to hide it they can no matter of this patch.
I understand your concern but vendors can do it today.

Thanks,
Michal

