Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2774BC27C4F
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 11:55:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B81C883D9;
	Wed, 26 Jun 2024 13:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZGrUYWT+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E69A886EB5; Wed, 26 Jun 2024 13:55:37 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7489883D9
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 13:55:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxIzkjifZ9ZTurf7xyE8xLAOearuf6NMYyVvlHK6lnhgdHMRgSr9MuKg3sP8yaNeHL+fFZcC+WJenUSib0GqVC4Vi0cvicrMYxNEjAsA6FhvSuJRIYEC3oc6t9JVnaMhDlRfTS0H9DslRS8YsF70q44uWl8LomACr26vc9MIoFg2EvXOqYH5CgJqN3j4vcQkf/sRzHY1PkmSWVd1FBHzhK0R4vLtcMNzYkGXhKPcXJ8OExwX8dZlWV1xWQrKg02/q7ccXUi6Zyc/ZdXAdSdteoHjSmc2Z0do2toEmq+COdg7RTMWDagbaKlFKfi/x7CBjXzHSfXHdXpUaoU4UE1ovw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/LmbTo50nkxpP2/mzU0CA4q8ZG+yKpCyZXx8FOx9o4=;
 b=P9fUsnTpUMiQEeNsRe1DofIskNkfiEusQMFU0eKDvdJDhRMrGU3v+2xHhKuSQbNw2y8eAoAUNM7uJG3tpTnrNVpSJGg2uPFxLRimFNFD4ix0ekaGnoFh74sdKLA4vQnIZLS7mtsxLuz84Xz06ktVKNFAWMXT2CzrAYMxt9kmXF3qCltsgF/FgzVc5J04GVcdLUJP4bhjzxy945F1JxQtO9WhI13n935hwm4Nqn+R9T89tDEyHdWshpmmkumrbvvTpiJYIf2obA1gAGyddAB+RnoKAw7/ytDFNBeJ3ZA/Y+1u7lCshp4+nGTgJeM5zb6eFSKK8Xx4rOW+Ly+O+AgqOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/LmbTo50nkxpP2/mzU0CA4q8ZG+yKpCyZXx8FOx9o4=;
 b=ZGrUYWT+sxzj46xaJhmboB0sB5vSXu01KPAN8bCpWI56pzh5k0+/F1L3h2BTqhCcfoQfZf37BNvB89Sezl7V2NrZONkF2xv3wfDkv/hGR/qV6omuDWfdiHnsG1plsEkXb+hSVBsbjxK6HHzcInA4BcdQrfmkp0j7WuNkZt6WlxE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by DBAPR04MB7271.eurprd04.prod.outlook.com (2603:10a6:10:1a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 11:55:32 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 11:55:32 +0000
Message-ID: <a9ebece9-4ab6-4bca-bebe-985e0bf95278@oss.nxp.com>
Date: Wed, 26 Jun 2024 19:55:20 +0800
User-Agent: Mozilla Thunderbird
From: Ye Li <ye.li@oss.nxp.com>
Subject: Re: [PATCH] imx: hab: Make imx_hab_is_enabled dependent on
 FIELD_RETURN
To: Paul Geurts <paul.geurts@prodrive-technologies.com>, festevam@gmail.com
Cc: sbabic@denx.de, uboot-imx@nxp.com, trini@konsulko.com, peng.fan@nxp.com,
 eduard@lionizers.com, marex@denx.de, fedor.ross@ifm.com,
 rasmus.villemoes@prevas.dk, xypron.glpk@gmx.de, elena.popa@nxp.com,
 tharvey@gateworks.com, sjg@chromium.org, vitor.soares@toradex.com,
 u-boot@lists.denx.de, martijn.de.gouw@prodrive-technologies.com
References: <74947062-1cce-443a-9fe9-b5538304205c@oss.nxp.com>
 <20240626071732.1249998-1-paul.geurts@prodrive-technologies.com>
Content-Language: en-US
In-Reply-To: <20240626071732.1249998-1-paul.geurts@prodrive-technologies.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16)
 To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|DBAPR04MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b4db0b-1b56-4806-f321-08dc95d6e0e6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|7416012|1800799022;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWhtT29NWGY0ZUdzc0ZFeUk1L3NQWSswRTU5TzhEQ25UN0MzeHhhRGhoQThr?=
 =?utf-8?B?TktPYk1pV2hTSm1GdXYxamhxNUNEWHFGU3BOVEtkMnZOSW13OWs3WEs1TExV?=
 =?utf-8?B?NmNIclZMSThWVVdlTjNoU21mdi9JbmRFOEs3eE1XOVJod1plRjMzS1R3NWR6?=
 =?utf-8?B?MFA2dVNHU0d6aWFlUi9WMVp4aGFHMEFxVHJvTGYxcWllOUhhZXNsRzdpczBn?=
 =?utf-8?B?TWpmc3BWOTd2R1NoZUFjTjEwZEpsVjhPT25pWnRFZ1lOK2NMSHdub3ZtUXJT?=
 =?utf-8?B?R0IwZk42Q1pRQ0dxU25ROGg2UUJ5aGVIbEZlajZaN0p4bW9memo2NDZqNGFP?=
 =?utf-8?B?RFc4cDl4ZzlNNVB1MjdlWTRxQnRnbU9nQUdmcHZEOTB5S1hKbmg5dHFOSmZn?=
 =?utf-8?B?UVlSaG9PMEcxbjJYY2pXZnN2dS9HbG5UdmlzQzFRWjYrd2o1eWIyL082Z3l0?=
 =?utf-8?B?TVJKQURFN2huMHhrcDJBZGxCQ01lbHprcGY0NDZ1blRLVjhKcjVLdllwSHR6?=
 =?utf-8?B?c0NuTi9KM1puOGNuSzZUdzZ1SjNkQ0RXa3ljNk1kaFJJVlpPazVBbmJmVXVF?=
 =?utf-8?B?WWx5engzRXBNcjR0OHU5QmcvY0lBZ0hycjRwVzhFODRIR2tkU2Q3WWFwWUUz?=
 =?utf-8?B?MEtWVWlIUjh5aVpINHdwSEJzb1g1eHc5WGdIZ0Jmc212bGkydzJiSGxNa01I?=
 =?utf-8?B?YzZjWEVOL2twTGxaTGZaa2ZkcFovQTdXL3dSOEM5dHpoaFFPVDVyT1VYMEtW?=
 =?utf-8?B?UFAvV1RSRzhhckE1b0I2bmpKT3dnd003eENKQXhWV29qZEk0SlIrL2lJZHZM?=
 =?utf-8?B?Yk1pcXVtT3JoUXloSjNRTGJPdDJOY3RGSE9lQkpqeXpkd0I3c3dVZ3o5UWg0?=
 =?utf-8?B?eGtmT3A3T3V1aFlxNzBsenpSQVhKc2ovWGZjVks0enlDV1Rvbkk3OUExd3kr?=
 =?utf-8?B?ajFTbHJGVlVMYkJBQlQrTnRJVFhBZDRCVFR4QldsWmlWcmE2c2tsMlFqS0E3?=
 =?utf-8?B?L0JON2NrNkZ0ZlF3S254NmYwMnpILzdHY0xidThCL1c0VnViSTgwNU5GVmtv?=
 =?utf-8?B?WFhTa0xnYVFnMCs0VXdteWJoNkJPTEh2cVB1b3BYRllSQWxxS1BVdTZacE5H?=
 =?utf-8?B?dVo2dGZJb2xVUUhybUNWek93VG5qM1F6QVBSOWgrd09wY3ViZnFaSGxYdmxG?=
 =?utf-8?B?L2RlcTM0M01LbXB3ZDVCUHFIRitHSnhmOTJza1ExUG5vY1Q4aUpRU1Y2TkY2?=
 =?utf-8?B?QnVCUnhnYThWdWVFbER4SUx0ajhzbVI0ZlNuSzM0OEd5VzlpUDByTzJIb0g2?=
 =?utf-8?B?V2JOYm1ZUjgyNk9raUNvaS9JZjYzaVF0VFpsYmF1ME9aU0pLUUhHSjZZMDdR?=
 =?utf-8?B?ZHZ1WFlZOCtXUS9uaWg4OTJHZVNoRC9ibTJYallLbWdmSDYvamdsK1JFNWV2?=
 =?utf-8?B?MFo5NVBCTm1WRzhZdnpEOXdXdzNOMDY4M0o3SGIxK1k2eFVuUnFZRVBnWmhJ?=
 =?utf-8?B?QzEyNzFUcHgwRWhJMmlYUm9mNzI3VWJQZnU3VWlINmUrRzZOS1N4SlVuNTY4?=
 =?utf-8?B?OC80WkwwRkpmaEhQRFZhTlcyNitJNzlNUEJzQ1hpeXZDSFJ0WE1UbjJZR051?=
 =?utf-8?B?VlVhd0Qvekw1UWo4dURzU292NDBxeW05b3N5YUt1Zm5rV3cyRmk1MTBCMmdE?=
 =?utf-8?B?UmpVMkszTHRjU0htT21UdzkwcjJIZTJ1UVVkOGZCMktpV1dYV0I5bHAvcUxX?=
 =?utf-8?Q?WBVFgjl1TqjEw+VPQ/k0WwPbRvkShQaAv/WX5YX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230038)(366014)(376012)(7416012)(1800799022); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmdnSTZqRXFnNDcycjlJbFhuTUtZSmR2UVFDN2tEUG9La3lDNHFlOVp4YW1K?=
 =?utf-8?B?V2dsdDRhZy9ZQzBiWWt4QkZROUV5cWo5REZxVi9vMlV5c1pLODFQd2QyY3cw?=
 =?utf-8?B?U09MSHhKcE1QVVhCUkxpb0YrYklGTkQ3VGJjdWlhT2tnV2JnVUowYnZxRlFJ?=
 =?utf-8?B?Q1pjQlJVYVhwTVBtamxtRTZtdTdsT1RVd3lsWkV2UTZTaG9OYXRrS0VhNk1G?=
 =?utf-8?B?QXpHeE1lZW54NjNnZ3VYSm1WWk9CYXpPN2s0MStjNlJrWWhIT2ZDclZDWngz?=
 =?utf-8?B?MzRxOXBYRXhNNFJNSGdDWTRqMlZXNnNxdThpZ0pPK0huNTVZdFoveU9NSDJM?=
 =?utf-8?B?alBpTHVTLzVoOVM4Q0JFTm1LKzh2QkFYMXFobjd0Qi9ITzM4djFzanVKTGZj?=
 =?utf-8?B?NSs4U3h1V2NxUlY2dGw1MGtFaUFuTGxnSDZyQlRSMTdqZUg4RXo2bTJzcnU2?=
 =?utf-8?B?dCtneVNSR3R5T1lMdGdwVnFWYUJ1a2gvYnNYMm91Y3pVOUVCSHRqblBJZnVu?=
 =?utf-8?B?Y1JudW52NE9tL1dwQVR2UXBVd0d2bzZlT2N4TjZsMk1lNHEyUkowWUJpK1Aw?=
 =?utf-8?B?N3Y5dzkrR1puNm9sclhhZEQyVGc2QXh3TmVSS1Bwc2FLSjlzQjlkaFZCZ0Np?=
 =?utf-8?B?RkdjdHQwY0VKNmg0OGpuSlk3VzFQbHlBZVZ2cDhSdU9ONUZqS05PYVhkSXlD?=
 =?utf-8?B?enFDRG5rVmpVUmdFa2R4Mm5hSnVsZWNSc2VmMzc5WU02eUx6aUZMQ2VMOCsv?=
 =?utf-8?B?aFh6b04xZW5YMzRZU1RHdzFkNEtKdjNUVW90Nm1wR3hRUzhqZm9iR3R3VFJ6?=
 =?utf-8?B?cm9FWlRHUnRWTjN4TjNZdUMxWEJCa0x0ZDlOVWc5K1VOV2t4L203bW52RmJW?=
 =?utf-8?B?NXBLeHhVaC9tWHZOeHBHVUI4ay9YYmYwMGpEd05lZE1nRGFrMTBEV0kxbWhw?=
 =?utf-8?B?dFFoRUdzRURmdStZVTNwbTFiZmE4dlJtR3hUakltLzRLUzVmejlTUG9nYlR4?=
 =?utf-8?B?NWt1bXNJaDZwMkZDWk11TTl6YU5jWmk5NEdOL3cvOWh2Qnl4VGg5UmFDaVZB?=
 =?utf-8?B?bTd2aGtrWWZaSVB4dFFEaTdmYkJNVmo3Y1R2ZFdpdHNuRmw0cHRPSVZENGFu?=
 =?utf-8?B?SFA4VHpKa3lzYmlZYlpCMUU3OU9YUW9TVTVuTEVxYUp1QVhXN1YrNzk3dlNR?=
 =?utf-8?B?cEF6STlzSWpmbERaL3p2c0tSUFh5ck45VGlEYU1VQzdCTGo3SFcweTZnUWVr?=
 =?utf-8?B?Zy85di9oV21nbEtydkJxdGJ0Rkc2bXhZV0drSUFCM2h6QmR2Nmc2WGcxeStR?=
 =?utf-8?B?Qnp4U2V6eHNuam5oZEgyU0oyMVBZallMaVZ1SklKV2RkL3BkdVBrcUM4elhv?=
 =?utf-8?B?UlFkZmtHeU1NSU84QWE2SnYwa29UV21oMXRYOTVhZmxqbVRPM2tLSHdFWDZr?=
 =?utf-8?B?SWpVc0llRlRvaGJaOG5WazJ1R294VHBEcnF3WlZLZEtYZllreHZrY1N1OEk1?=
 =?utf-8?B?UEtnclp6cDJmVFRUS0QxZ3pER3ZCTWN2bFBaUkg5bUZjd2wxTTROSUZVQXhm?=
 =?utf-8?B?Tkpwb1BtTEF5bHJzUnRqOXpDdlpZd2tQaHJvVEIzMFcrajk4dkxEWXBKRkRR?=
 =?utf-8?B?MW9MaHY4dk5LTE5EdlYwS1hJSTFOM29tby85MlU2QVVPR3VOQXMrcnpLd0dJ?=
 =?utf-8?B?czVaNTBQZmNYV2RrVzJUUjRHUmxSTXZJcmppOWRGeCsrREttaVRKVDBPcHFw?=
 =?utf-8?B?eFNLZldDWTgxZUx5NFArdVA4K1g2WDFSWW04ZGdnNFQ2eFlyeTAvNlpoWUJk?=
 =?utf-8?B?K2phQ3M1a2xBTUpHOERqcWh6eXFnSUFmbVM2dEpnUzBxbWF5VGtweWdBcDBL?=
 =?utf-8?B?NmpMdS8yNlowS1VRRnVNc3BZVW9haU11WGs4R05mK05raVhzb0JSVnRQei9s?=
 =?utf-8?B?d29xZFdXbmUxT1gwTXFQeG15dGNqekNSQ0s2alloUnJ1bm54cEtRYUxqQml6?=
 =?utf-8?B?V2s4V2ZRMHBTVjJtM1M2VUxiWnRpdnF1YUlwdmZVZkMvNzRGUllGNEREbG5p?=
 =?utf-8?B?bTJqU04wSlFJVnQ0WkEzbFhJcnlSNTRMeXJTL242VDFkY1lrZW8vVWFoUFJW?=
 =?utf-8?Q?ez8wakSf48218WhXn6kzxS8kw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b4db0b-1b56-4806-f321-08dc95d6e0e6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 11:55:32.7147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GzWmYfjuatPThiu75VtoX7ZkZNt0Kc4pFpDAhIAENfrdpfI221YDINw/WGVESqsX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7271
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

Hi Paul,

On 6/26/2024 3:17 PM, Paul Geurts wrote:
> Hi,
> Thanks for the feedback.
>
>> Hi Paul,
>>
>> On 6/24/2024 8:09 PM, Fabio Estevam wrote:
>>
>>> Hi Paul,
>>>
>>> On Fri, Jun 21, 2024 at 10:06 AM Paul Geurts
>>> <paul.geurts@prodrive-technologies.com>  wrote:
>>>
>>>> -struct imx_sec_config_fuse_t {
>>>> +struct imx_fuse_t {
>>> Please make the struct renaming a separate patch.
>>>
>>> Peng Fan, Ye Li,
>>>
>>> Could you please help review this patch?
>>>
>>> Thanks
>> Can you take a look iMX8MP FIELD_RETURN fuse, I think it does not have 1 bit but 8 bits which requires to burn a sequence. Only when the bits sequence is matched, the field return can work.  So checking the bit 0 is not enough.
> Are you sure about that? The security reference manual (IMX8MPSRM) says in Table 5-5
> that the FIELD_RETURN fuse is located on fuse 0x630[0], which is a single bit. Also,
> the "Chip Security Lifecycle" section (2.15.1) says the following:
>
> FEILD RETURN (SEC_CONFIG[1] fuse = 1 and FIELD_RETURN fuse = 1)
>
> Are you maybe confusing the FIELD_RETURN fuse with the FIELD_RETURN_LOCK sticky bit?
> clearing the lock bit _is_ quite the procedure, but it is unrelated to U-Boot, as
> this is done by ROM code through CSF.
>
> I tested this on an i.MX8M Plus and it seems to work fine.

I know the steps for field return.  What I mean is the FIELD_RETURN 
fuse.  It is true that security RM mentions it as you quote. But from 
8MP fuse map and ROM codes,  I get different things.

FIELD_RETURN 8-bit code.
FIELD_RETURN = 0, is non-field return mode, functional/secure mode.
FIELD_RETURN = Matching Sequence, device is in field_return mode
FIELD_RETURN != Matching Sequence, device asserts security violation


However, I'm not sure how is it implemented in HAB. Since you have 
tested 8M plus, can you confirm the closed part is successfully 
converted to field return and can boot without signing?


Best regards,

Ye Li

>> Fuses for other platforms look ok.
>>
>>
>> Best regards,
>>
>> Ye Li
