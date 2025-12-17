Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF39AD65C6C
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 15:35:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 208EC83B32;
	Wed, 17 Dec 2025 16:35:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="OyUPd7hX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FEB283B87; Wed, 17 Dec 2025 16:35:56 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DFE583AA0
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 16:35:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANkAASvEykom7OG9KcPllQZXHP1zcSVYUJKJhEKm9MX1hm750lZRJrwi+CDowhuyex6L6hHBEylDxP/oDCn+/smCG1Dzi3z30U3IeqzT2bW0rFqnfIRwJ91crqcEiJZndyUmtMvQSJ+hzRiUyFQulV04I1DcRmYEMpR+98QIWiwK26ztFrlLquljzWfaP2rsUczilRVFQa9JZykZNLZqpaTiNpDxEtS+ONdF18HFA0VC44XTY/FiLEfPFO/+eAxCF7u4ycyQ8qZK0fR4M9cGAz8NlvCwB46Zb32+GAlPYplZcn96coYyRouTxq2NqPH2FpkN2IeF/rJQoC0zvOskWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjnNXQqeWYGTC05VYUSf7ut39jGewgLfM6H9Kd4Yt2I=;
 b=UHOw8NurqVTaNRTXzn0H1K4R/NzVwkmiXS5+K4SGpAJKfrwv9ZbOrM5rfokQss85DtAjd4yhw7sAwBVpr8Wr7OpGa8/flgI1rWER3+wrNcMb2qmwExDnnE8eehndy1dUctf73uKU14VCThPxuuekItrwMNR5sB3lQehgjcT1fRTZjP1KphGdLH5dBynxPrOzjow6leBO8zBXoxeMLByDumNkCTerYCMYArH9cgHHOsZgxxK3H7k5fmFxz+D5VP0B7PIfby5Ed2I27MEqkZ7Qqn0I9gJd/VP21yyPsjNBYviAuniVxNZeR08BHiWNKpgpQHa/fUA/v48bfxX9/3zAiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjnNXQqeWYGTC05VYUSf7ut39jGewgLfM6H9Kd4Yt2I=;
 b=OyUPd7hXljfvAHoKPBwVL5wtbdwS8eNFoDOzQsBqwiJR/afHn7ydfMxiBm1NwB6weWOIYThxBfOJRkvbkYknHyLt6lOsKh/SwFHOWhgsTnFg5anmdZK6YS/sXx37CkQXFaR+TibvFT59Gn8GCAuD1d6L6DUIDomxB4cSqZlKpCM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DU2PR04MB8598.eurprd04.prod.outlook.com (2603:10a6:10:2d9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:35:52 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:35:51 +0000
Message-ID: <845dd05e-df50-45e4-9194-e2d519ab56ee@cherry.de>
Date: Wed, 17 Dec 2025 16:35:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: bdinfo: fix incorrect Kconfig options check for
 print_eth()
To: Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <foss+uboot@0leil.net>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de,
 Michal Simek <michal.simek@amd.com>
References: <20251217-bdinfo-lwip-v1-1-849cf060bf12@cherry.de>
 <20251217141727.GB303283@bill-the-cat>
 <11ade490-ba73-4553-812b-27e85b4d29d9@cherry.de>
 <20251217150415.GC303283@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251217150415.GC303283@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::17) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DU2PR04MB8598:EE_
X-MS-Office365-Filtering-Correlation-Id: dd506dad-54e6-4211-fbf8-08de3d81f5d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THpPTGtSYzgvaG5qSnJhTlJwSFZSRi9sRlF1LzBqdUcwdjIrTVJndW9KN3h6?=
 =?utf-8?B?MHdFTXpEUGxoR2k1WXE4ZTJqTVZISU95eHdHZUtFSmgveFRUUE1lSDdRQVlF?=
 =?utf-8?B?VkI2ZnFwVEpGc0R1aUxKRjB1SngrdE84NS8zN0pDYkw2MFBDMG8xTk5IbHlH?=
 =?utf-8?B?UWpqVHBiRVY5RWhMTG91MFRkZVpEeC8ybjRVNWEyei9mN0szT3p5UTJtOXpE?=
 =?utf-8?B?Y3JXVnVLKzRFNlhlUVRHTW5TNGRvZ0NybEwrOWFpQk81SnV6aGN6VnExL2Jw?=
 =?utf-8?B?U0dtRWp0MGhaUmVZTS9YZE5tNkU1c29Gb3VFYllKanByTjJCQXV4d1NpU2Q0?=
 =?utf-8?B?OWxkaEcybXRXd2hOdUY1QU85M21YVENwandWbGpJaHl2QVBuS212VHVZMmZO?=
 =?utf-8?B?eVdkNkNFVDNmdGpRWDZWWEZqWmdlTE5EdDNBRDk1dW5iUC9sMVVVRHpGYWxp?=
 =?utf-8?B?S1QxMnloclZrdGVXaVV6a29ZRkR0Q0haaEZOcGJOK3N6RDJ4WDdDNTVSNFBo?=
 =?utf-8?B?cFlUTklTWVl0Y3ZRQ3JwMFo4UUcvYUlRT0V6L0x1QnVoZ3lHeHRJMkxhbWVV?=
 =?utf-8?B?OVFDb1BBODNRY1ZMa2dsSG9IQjdmcXE1dGpScCtpRWJnb1ErdkFnd2pCQTVF?=
 =?utf-8?B?VmRHNzRKVlhGMFNvR1dUeGFQck0xUnlWMHcrYXhMakg2bHQycXNsSkZNbEJj?=
 =?utf-8?B?YlhOc1RVakFwSUE4dnRsQnNtNE52aVR2TlRDMXRHT3ozaGZjQitPTm9hMzBX?=
 =?utf-8?B?dmN2RkN2NTRYNDBkOTI5YkVQaFFBYklhdEphWXk4dVAyeHlsSXkxUk56VDJ4?=
 =?utf-8?B?NCtDWExqVmtVTXlHUnUxVzlBcVhBL3dvM256WDRyNCt2YXp3eFRqR21ucXdo?=
 =?utf-8?B?SUZtMEdabyt0TlZ1L3JwL3czUmJmeFNub0ppUE1FN3g4RFdWUk1hRnRkSlht?=
 =?utf-8?B?THpoVXdDb2RGRUEyaDVQNlk2QTA5TFJFNGxZUmZGK2lxbTVvM2hYVFRseGo1?=
 =?utf-8?B?bXphK0hIM0dzUDhvVkUwSHVDTWloWVFwdVhZNFNlWTJubVNrYXlEM3F2S2g0?=
 =?utf-8?B?ZDdNdklxS0NjenFsSFpEczdvaEZXYWFDOVpMRXk4NTBPNFpaUkNhaVZDMy9z?=
 =?utf-8?B?SUZDVTBqYXo2ZTJtOU5YWis0Y3NEak9jUGkzUUpZWnBmMHNQRFV0MjNNVzdL?=
 =?utf-8?B?M0pPancxYXdEdStuajBxZTlBWExZdTc3ditaRUxkcFprRkUrdFBZVUEzWjJp?=
 =?utf-8?B?ZHo0VnpjY3FTT1BVZklRdnFCY2xIQjdrZVkxaDE5Y21NaTdLS0hDbkoxMktH?=
 =?utf-8?B?NmcwMEVEWDJyTm1rQUdXUWEyWWFDZXVrOE5DOXg1Y0lSR1FJK1pPKzlablVk?=
 =?utf-8?B?NFNqcXlVNUdDUmxSS0ZaT1RiSDF0SmRSQ3BSZzVDcXF0cXFxcTVhbFdRVW9j?=
 =?utf-8?B?dDJvdnc4OFUvc2lOYjMrN1crdU9MK3RmYVpCNjM2ZWd0ZmFNRlYvejc0bC9o?=
 =?utf-8?B?amFVU1FJNmNWRE1Ga2FsM0RJd2RGYXV4R2dCUDlxa3BpOEUvZEgwSmJmQW1U?=
 =?utf-8?B?L2JucnhHR1Bva28xejAwQ05KRkZFbElGMVZQNWFmUDM4LzcyT3MvOC9aMXhY?=
 =?utf-8?B?Z0RvRTJiT1d0SE5xeG96OGt0TGE0VVloNGt6R2tzK2pwOFBqcmVmYjFHOFBT?=
 =?utf-8?B?TjJxbTBJSXFEK1REcE5oMm4yeEJLcGhLbFFQcEN1ak1lN1ZWQnFiMEVQMWtO?=
 =?utf-8?B?RWFaVWpWaGx5M0hVMDFSZGw0NU52dG9vcG1rWUx4ZENvNXI1YWtHa3RTNDNN?=
 =?utf-8?B?clplWFVoSlZzVFRzbDRMM3E4T3pjb3IvQmh3WkFzOXpuS01oR1R2YjhLTDlG?=
 =?utf-8?B?YmxyOHhpL3VOZzNQMGJEU3YxS1JPUURhUTd4bURYeEpZdmc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmRwWW8xOVdyZDUvRnhoUVJFc3dXY3ZZYmRZSmdiYnl6Q056OHowanZJM1Zn?=
 =?utf-8?B?OXhCd2tvNWc2anV1NGRNTmtKbGthbEFvZTlrMmVKNU8wbVY2bXFrdjM4ZmVN?=
 =?utf-8?B?aFkwUGptZGd3eFZwVGg1QStCSG85dVNzOTN6a2I0SDEySmVQZDRhQnYxc1V0?=
 =?utf-8?B?YVM4cUtTRUVXeHJqUTZ0OEEvWEZ6Wm5rKzFSVXhwRWM5NlA1cHgyZ2tQMm44?=
 =?utf-8?B?cmNONCtzL3R3Yko1Z3JtdE9MTUdWZHY4SkVRd3dVay95ejRNZ1AvTGk4QVhH?=
 =?utf-8?B?VkVkeXh3THZQTXBiNklHRDhNRGxhV05WbEhqVG9wTlFNRjVSWVR4UG5TTHov?=
 =?utf-8?B?bTZReFBPMkNvbVJkZVFTNHM1d3ZxM2crNjRacTk0RnNjTGtkZ0Fma1MvdUQ4?=
 =?utf-8?B?aHJibk9taTJ4UVNWQmdqa3FCRWgzQ2h5T2VSTlJ6b1RZRTdFS1UweHhOdVZa?=
 =?utf-8?B?YmMxeEpBY0FXRWp6Y3owUUFhaXRPRzViTzhZY0E0NWxMMEM0OEI1bkJVMVJ1?=
 =?utf-8?B?cHBFMVB0Z2J1OUEwTFlodXkzQndIUnJ4OHkySTFEY3NRZS9GN1ZZT2ZRcmUz?=
 =?utf-8?B?bWFVMVc2ZGY3aHdvL2lRaVhSblpWS2h4Y1U0anBjSlZ3bWpPUitNQ1UrWTFO?=
 =?utf-8?B?MExTeGhGaWlhdTVnSkM1VGFNVzdGeGtVd21ITjVpU2x2czhybG1sV1RXR1Nm?=
 =?utf-8?B?QzYxMi81SVQ0ZTZxL3l2QU41Q2t6R1YrbzEwTkQ4T0lKTGNWa1JRNmJaZXA3?=
 =?utf-8?B?Qk1aanZnUTVOQ3h2UThFK3BJak56a01lazhFVWgraGRVbTByY1NtSmZVdFhW?=
 =?utf-8?B?eWVkS2hFWm5BeDMvZklSeFNuNmdxdHUyZlV0M3hhTnErSnR1dkJYNFpzVEw3?=
 =?utf-8?B?Q1hpTnRlN09BUERCV3h6V2Z5YVBaWkxNRmNxRXQ1Z1ZmWUpjT1A5UkZIanVR?=
 =?utf-8?B?VVZLN1BrNUlDWVI5SURZamxnZmtpWXlVeWhaOGNMZmlvYnVCWVdmNHBNM0o0?=
 =?utf-8?B?RHJFcUIyWUxIcjJhSjNrL2JORi9DRkRWVWw4TDN3Lzd4MGdZckRmNTRucHM3?=
 =?utf-8?B?ZStsckJIaGhHMkh5RjNjdmdwdURRZHdKNEdQM01Xci93Zlp0dGh0bnBOcE0x?=
 =?utf-8?B?UGh5OGI2VjJpemZzWnNWRmswUURpVlI0Y2ZaaHNReEd2ZjRhMWFMdkJzbEhB?=
 =?utf-8?B?YkFVUm1ROGdQNE1mMUZ0djVyL2NvQVl4THZuSGY1Ti9nWDU1ODZ6V0hIQ1o0?=
 =?utf-8?B?UzVXVzVSWnRiN2ZRUEhWYVJJNTR5ZHFMaU1CQmlsbnBjcUsyRlhoVUdIVmxJ?=
 =?utf-8?B?TkV6WTVxQ0ZLN0dVTlprZSthYVlWSnlhTmMzcUluM1Y1T2dkWDJKYUpMbHpF?=
 =?utf-8?B?aFJ1WkFwckxIb21mOHJ2aWlZMlVidU40S0xzZUhGRWtWa3JxNko4MGV6MkJJ?=
 =?utf-8?B?c1RZUDIva3VGVkpscnp5dEVkSUhRQjFWU0hSd01YelcrMXlyMmpVM0pWYjZw?=
 =?utf-8?B?V044YkNkNFcrbnJvb1FzSmJqcnhrVkxXcjE5S01kcFlSZ2RNb0ZxY2h3V09C?=
 =?utf-8?B?YTJNSlFvTTZ6aDJ0Z2E2MUVaN0w3SUl4RkpGK0hOK2REK2ZPTzVEUktKN2Q4?=
 =?utf-8?B?WGJ4aTU4VmVodGpqTTFHR2pvS3BpZ3pkeUdKRDR2SlBhR0d2dTAyK0NacDFE?=
 =?utf-8?B?M3RObHdteDZiN2dIVTJMYno2U3J4aGRnVHc1ZzVvTVpnUFdDZnUybVdHV25J?=
 =?utf-8?B?Vmd0UDQvcXNhY3MxbWorWXMzamRuNHZSR3NPbW4rZWk5ckZUaXl3WjdMMlEv?=
 =?utf-8?B?emxDMjBYK0cxNS9YZURjNXVKa3BmV2lldXRLRWdNeTVqVU9PdFZrRVBva0tn?=
 =?utf-8?B?Z3I5WWpuT0xpSHptemFObmlKbllmaFhpR2Z4YTU4VktCVnJjUjZ4dG1kTmo2?=
 =?utf-8?B?SXNBcmNvR0NxaG1BZHBXZStkNG5WVU52eVJFYzhPNVhvZ1JmVW5uZEVwNHNI?=
 =?utf-8?B?VG1kWkRxdFBDb1lCSTdMODlXZXlHL0psd05wSmVFaG5XWVZ6TzU4RDlqbksy?=
 =?utf-8?B?MXYrbXArV3h0OWFzcjltOCtVOVVOS0U2NWJNTHhkZkxqN1FZaEZIUktQeVdy?=
 =?utf-8?B?eXhjL2YyRW1RODJhcjFMUkNZM0h1QVdZOFpyaVhUMGpUdHhCQ1NqT2lPcEFn?=
 =?utf-8?B?MkE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: dd506dad-54e6-4211-fbf8-08de3d81f5d2
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:35:51.9142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CK9VxZUy/jpbnVZJi8ajXkUHzkNXJcZsdwzIORgs9MOzMOJV29S15llogGVTUxCrI658VPYnNv5WiPtGuWEY4WX9q1/reUIheP/k3ZNlAbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8598
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

Hi Tom,

On 12/17/25 4:04 PM, Tom Rini wrote:
> On Wed, Dec 17, 2025 at 03:51:03PM +0100, Quentin Schulz wrote:
>> Hi Tom,
>>
>> On 12/17/25 3:17 PM, Tom Rini wrote:
>>> On Wed, Dec 17, 2025 at 03:01:10PM +0100, Quentin Schulz wrote:
>>>
>>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>>
>>>> CMD_NET_LWIP has never existed so it cannot be right. I'm guessing the
>>>> intent was to allow print_eth() to be called when NET_LWIP is defined
>>>> (NET means "legacy networking stack" as opposed to NET_LWIP which is the
>>>>    newest (and incompatible) stack). There probably was some mix-up
>>>> between CMD_NET and NET options.
>>>>
>>>> The dependency on CMD_NET seems unnecessary as it seems perfectly fine
>>>> to run bdinfo without CMD_NET (build and run tested). So let's instead
>>>> make the dependency on NET || NET_LWIP.
>>>>
>>>> Fixes: 95744d2527cb ("cmd: bdinfo: enable -e when CONFIG_CMD_NET_LWIP=y")
>>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>>> ---
>>>>    cmd/bdinfo.c | 6 +++---
>>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
>>>> index 20c8c97f0cd..09fe8067642 100644
>>>> --- a/cmd/bdinfo.c
>>>> +++ b/cmd/bdinfo.c
>>>> @@ -152,7 +152,7 @@ static int bdinfo_print_all(struct bd_info *bd)
>>>>    	bdinfo_print_num_l("relocaddr", gd->relocaddr);
>>>>    	bdinfo_print_num_l("reloc off", gd->reloc_off);
>>>>    	printf("%-12s= %u-bit\n", "Build", (uint)sizeof(void *) * 8);
>>>> -	if (IS_ENABLED(CONFIG_CMD_NET) || IS_ENABLED(CONFIG_CMD_NET_LWIP))
>>>> +	if (IS_ENABLED(CONFIG_NET) || IS_ENABLED(CONFIG_NET_LWIP))
>>>>    		print_eth();
>>>>    	bdinfo_print_num_l("fdt_blob", (ulong)map_to_sysmem(gd->fdt_blob));
>>>>    	if (IS_ENABLED(CONFIG_VIDEO))
>>>> @@ -193,8 +193,8 @@ int do_bdinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>>>    		case 'a':
>>>>    			return bdinfo_print_all(bd);
>>>>    		case 'e':
>>>> -			if (!IS_ENABLED(CONFIG_CMD_NET) &&
>>>> -			    !IS_ENABLED(CONFIG_CMD_NET_LWIP))
>>>> +			if (!IS_ENABLED(CONFIG_NET) &&
>>>> +			    !IS_ENABLED(CONFIG_NET_LWIP))
>>>>    				return CMD_RET_USAGE;
>>>>    			print_eth();
>>>>    			return CMD_RET_SUCCESS;
>>>
>>> It must also be the case that we never both build cmd/bdinfo.c and also
>>> have no network stack, otherwise we'd get a warning around print_eth
>>> being defined but unused. Can you guard that function too? It needs
>>
>> This doesn't happen though for some reason.
>>
>> make ringneck-px30_defconfig
>> make menuconfig # CMD_NET=n, NO_NET=y
>> make
>>
>> No warning or error (CMD_BDI=y and I've checked by adding #error whatever in
>> the file). eth-uclass.c which defines eth_get_dev_index() is not compiled in
>> (no eth-uclass.o in build/drivers/).
> 
> Hunh, ok...
> 

Compiler magic? /me shrugs

>>> eth_get_dev_index to exist which does require a network stack. Also,
>>> maybe we should be checking on the "no networking enabled" symbol? Or
>>
>> Yes we probably should but we do NET || NET_LWIP everywhere, so I believe
>> it's better to stay consistent for now.
> 
> Makes sense.
> 


Mmmmm... So CMD_NET is only selectable when NET || NET_LWIP today[1], so 
keeping only CMD_NET check is enough (removing CMD_NET_LWIP which anyway 
doesn't exist). But at the same time, there's nothing CMD_NET does that 
is required for this part of bdinfo to work, so I think going for NET || 
NET_LWIP still is better? What do you think?

[1] https://elixir.bootlin.com/u-boot/v2025.10/source/cmd/Kconfig#L1840

>>> no, because that would then conflict with the other series you're
>>> working on that you mentioned?
>>>
>>
>> In the upcoming series, I plan on having NET mean "there's a networking
>> stack available" and I'll replace all current NET || NET_LWIP with simply
>> NET (the "new" meaning for NET; the current NET will be renamed to
>> NET_LEGACY). It'll be based on this series, and I don't want to be making
>> this patch dependent on the huge changes in the upcoming series. I'm not
>> confident that upcoming series is necessarily worth merging or that it'll go
>> through and be merged. I'm at 198 files changed and the list of people
>> get_maintainer returns is 160 people... I still have my doubt on the
>> NET->NET_LEGACY rename and reusing NET for NET_LEGACY || NET_LWIP.
>>
>> I'm on PTO in ~24h for ~3 weeks and I'm torn on whether to send the series
>> (if it's ready) by then, feels a bit weird to drop a big changeset like that
>> and disappear for a while :)
> 
> Yes, lets see it when you're back from vacation, thanks and enjoy your
> PTO!
> 

Thanks, happy holidays and good luck for the 2026.01 release, hopefully 
everything goes smooth :)

Cheers,
Quentin
