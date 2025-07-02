Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC256C8303C
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 07:39:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F73381FEE;
	Wed,  2 Jul 2025 09:39:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ckufo2xl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A583C82103; Wed,  2 Jul 2025 09:39:43 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::616])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 934A481E13
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 09:39:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6R7XFZiJSsOh3dxVYSsH6tnT+i1rWUdeo2kznfNTwNeXdAqUV2bYxnzfNNC/r3YU6aDvzyYMMdztnZULhJjq3GSaG7ahWtlFJ/Li8fTDRtp9mu13OG7pxgwMmXe9zcnLWOTdSKvdumTS9AnM671gHiMKt4IbynGWdVYZWOvcxqxHbUDH6BqsJRx68E7ctNGPeVqoWd11cNVDpXXhj83su0yEvvqKZ3JEgU1eAu2166xmnWJafor/9uzMemkH2/twyqHuDi2yHFDFpBOQjGN5E0sM+FqlQdHQlXbpAj35g5gXrY0lfnLoFQe1lpUDUXbZEGrA1O5nzAaTpxC6yZ6Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Wv+VKMUD8ZbASlXlHJjzoFfJagD8DlaErMXpgUd/3Y=;
 b=S1bnXB60cfLDV5NxyuPG9CiIu88K0Bv17uroxI5Zbh6kggoNXYvfYOT16wB9xFsgZgwtAcm2xNNCbNOE3aiVhUaoce/ggf2FnljYdj8Jr6WLNdLLdtxlyjMklBagYTozjKfyrvy8z0qoHiRPw/I3v2rhQJg/uZiGIZ0DDtc/RMitjBcC+C8h5B3KHED687KirEDl8UnLGuQf0mEoZ4XqpbjwKOMcgiGl6zGuQe40BG6sJh7DQMI6iklpOaQ2CqYkYMxHB1NPTiTbxW7xGo5RWJdmAnqEnBXMIJAUnO2XNv/Lt71rdMacSQRuGxBkIxodkG2PEo/NbHNAx3EEZHEPaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Wv+VKMUD8ZbASlXlHJjzoFfJagD8DlaErMXpgUd/3Y=;
 b=Ckufo2xlHQfNZoL6Hk//UBjatBiKScwKHaOPsJTN7ip2m+3NP5gjvUXvKu9HfP310sF6ftPKim43VE9nh4CxkX1YVCeF0VwbjV1O3/jyoxbaOja6DCDXzgX9jXlix3tyJk/bpNKGxsSAUCY5CBlr2IdkbazMZDhy5sBZcaAchSM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH2PR12MB4135.namprd12.prod.outlook.com (2603:10b6:610:7c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 07:39:35 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 07:39:34 +0000
Message-ID: <27a43a27-2b87-4d56-92e8-23bd92f9cce5@amd.com>
Date: Wed, 2 Jul 2025 09:39:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: zynq_sdhci: Add emmc hardware reset
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, git@amd.com
References: <20250701040915.530912-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250701040915.530912-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0230.eurprd07.prod.outlook.com
 (2603:10a6:802:58::33) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH2PR12MB4135:EE_
X-MS-Office365-Filtering-Correlation-Id: 9db5015f-78f8-411c-eebb-08ddb93b96fe
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0lTb2ZsVDJwYndmd2Ribnh4WS82V0xxTjU0WHZkaEJUWWJyMCtIWEMzdnJv?=
 =?utf-8?B?T3IwazY5YmxWbkRqdDk1aFM5em95NWVjajAxb3M0TnRNYmo1RWNCSU81d0pM?=
 =?utf-8?B?UUdkaDdxRWE0TDl6S3BsZVc3SC9obEZ6ZE1pejJUQmR3R09jNUVsWk1HTzdS?=
 =?utf-8?B?WU9EV29kZzNJYnp2dmhWRGNEd0NNQXBUQlV6bW5FVjErMWFTRkUrTER0aVRK?=
 =?utf-8?B?OUpIbE9CNlFzR0R2Unh0VHRhd1czYURHRCtoUXkvSUpFeGVVRm1SenE3eUZY?=
 =?utf-8?B?czVHanVRcmpIVkV5enJHY2xHaHhrK3J5cFVvd0NNNStLZkVSKzIxVXlGcHE3?=
 =?utf-8?B?VnZMNHpraGxmbC9YbkhVdVlyYkhON3hZQ3dSbDVCUWtKckVFK3V4LzR0THg3?=
 =?utf-8?B?NzVYUUlwREJza0NNTHQrS1ZSMjJ2U1Nxd24vUXlPajlOaTlIbnkxY2o1aFJn?=
 =?utf-8?B?MFkrNS95VXhCdDh1TGlCMDc0SEJObGhkZGRUWndTcTI5ZFAvcXJoRFBvU0dW?=
 =?utf-8?B?K1p5dXd3M0ZyU1Y4aVBsQzFsVmZkREFrVi93ZHJkQUNSQzBMUHJHdW5weVRL?=
 =?utf-8?B?QThOV0JhUWtnUUpaNCt4NDZWTU5Fa2J2V2NtMzJ4NnFETUo5SWxMYklxYVhk?=
 =?utf-8?B?aHlEQXRZUHpXcG5OOEtLak84MFliWFNnVFZ5aW12RytKL3Fpem4wdjNqdndD?=
 =?utf-8?B?ODYyQkRBRmNSWmQzUEluM1YvV01JUkdNcC9iekZPMHJxNXA5R0UrNm1CUmlH?=
 =?utf-8?B?S0ZneDdtaEVQdkxjS1ZsV2FReTh5Tk1UVGZ6b0RVaUVWa0M4UDhlN3I1Vkh2?=
 =?utf-8?B?V2tKYStXTVZ1eklNd3VpRC9rdkZqOGd0d2liWDRzWDVEa2kxUEJsK2psUis4?=
 =?utf-8?B?QnY4anRBaUJtTDZMRVBtMkFYdjJhemdEVmpzcE9oU3VjZmNORzZ0WFEvamlZ?=
 =?utf-8?B?c3hZUG4ySzA4dGszVzAydC95RnlxbXlKNGFtektVeU9TOUVnenNZZHVZQVZh?=
 =?utf-8?B?NTV0VE1DTERxbTBFS2JpY3BwOVJpY1k0bWhkZVZpOEVmVkFLN29icWZ5azdz?=
 =?utf-8?B?cVFLVUc1enQxTGRxeHdXOGkrWjhneXZKTldrQ0xBdjFtRHk2K0F3U0F2Y2ty?=
 =?utf-8?B?VkM4bWpFZ2pVZmJZZVJZUkErb3JhaVUwVG5iQm50WmQ1dmFtSlkzbTg2NURW?=
 =?utf-8?B?Y29XRSttbnBXNEx5T01nMjZnT3BIb0dPbEJtS0xNYzJqRk5QbXl0NUlhYUw4?=
 =?utf-8?B?TGgxVzl5MTVBM0s2L3BPN01EdU5BNnVRM05GVHZqaERDMklpaGFHeEphRTZM?=
 =?utf-8?B?TDB2d1VIeU5IL21kNnhBbFdPSFhiM0MwTVNYMHFPZDAvVW5tR09WY29nM0sx?=
 =?utf-8?B?enlBK1YzeXkzNE9XNTNVdFlWb2dSK2ovTzRkeW5JeE1ldnpoazVtdW1vOGh3?=
 =?utf-8?B?VFJwR0xIWUo0WE5JK1FrOS9jbmpheHBib05xSmE4cituQ0M2YVU1V2hZVG9u?=
 =?utf-8?B?Y3FZdmVDZ1lqZmhDLzhEMXJDWTNQVFRFZCs2R3YvQXpvNy9TYjFncEJwdUxK?=
 =?utf-8?B?S2cvSHBoYUVwaE03YWFPRTVvL2RtcmV2Sk10UHFPSExIejhVRk1SOE1KcjRC?=
 =?utf-8?B?cVplcUZ6S3N6RVoxZVFBRlhBWVFjb2F4RzJ5cEwyelZZbnR0WVdQK2ZJZDdP?=
 =?utf-8?B?QlZUdjNyTEtCNHBHRlUveVBwVEJkSk56anhqclJLM1MreTNmZENHVndRY2l5?=
 =?utf-8?B?Qy9uek5NaTFVTE1DMmlLWU1UMXJKNHVoQ211SzdOeWdiejhqdHMvRVd3Qy9E?=
 =?utf-8?B?V2M0eDhkNlhwSnhVMmNMSTlmU1RrdFFsK0lPeEZnSzl4VGthYnNQMG55Rjhp?=
 =?utf-8?B?RmtFd1NUcUl3aWVTVTFteks3OVR0NGxTQ1E2VzlCdTErZ3dnMmd6Z0NnOWN2?=
 =?utf-8?Q?VMxA8H5d0FQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2VUV1BnNzVKaHBsa3F6ZG1Sam9Zc0FzdlBqb1paK3E3VU84QWsvRHptdzBx?=
 =?utf-8?B?ZkdrdU9wNmYwUlcrUlR0SHNTSkRuUUVLUUlPTG9pbDVNb0dQa1dJZDR2VWRS?=
 =?utf-8?B?UVB5VmJsYitvSWxrUXBPWDZPWTh2bG9lLzJ1WEtFY1FRc0V4RWh4aTJHa2U2?=
 =?utf-8?B?b0dPcHZlVmtFQWNDWGpXTCs4L1RhZW1laHFRUm1sdXlwSXdMYUxVUG82U1Rz?=
 =?utf-8?B?VytsdGFnNHV0VVZ5b2hIeHJ1OFdMc3Z0dnNGeVEzZzJ1UisrVmNVWkJhZ2dM?=
 =?utf-8?B?TTJsWUg2UVVFQjBnTGtEY3NEdGpUVS9pbWZEZGd5RGtiemFyQUIyK1Z5ZjZm?=
 =?utf-8?B?UjJpNWhyUStmdGNuWlM0d3RqUThna3Y1ZUdxZnFONllpVjBuK3NRWlZ2YU5W?=
 =?utf-8?B?SjJzYVF4ZW1WeTJDdGRmbTRqNWFlbXk1NmVzZ0RDallpOW1oWUl3NU90MFBm?=
 =?utf-8?B?M2Z0YnlLdHFqc3Z2WHo0eXdIeWo3Q1J6dUx3VXI0UVkrVWZsWlJIRStGTnV5?=
 =?utf-8?B?TlpPVFpuZVE1YXhhb1M4N2FaRUx4Y2dOUnFIRTdtOHhqRFhYRUFIYVNLRCs1?=
 =?utf-8?B?WXRobHFTMTI4RDlrbjFwV001YkJ2NjhGdVVVRm4yOXlxSithMnZPdlpUYVF2?=
 =?utf-8?B?aWhkVS9RODYxVzd0OE9mT29vV25Sa1h4NGt4YXlaSStRVjFVWnZ2bDdaMy9H?=
 =?utf-8?B?RFVKcmRGUVBDNytOd0lETW9yRmIxNWk4Z1dBTmxUbGNOb3RNN2k3ejU2eDhS?=
 =?utf-8?B?akFzUEc5RERwRUZNTVExeVJTMWRSdVhBZmxBMjBZQnJjalFEN052N1FLZmE4?=
 =?utf-8?B?aFZodGhwckNIcjVtTzM1ZWw3WkZnSUd2SDFMQll6VHB2d3B6YWQ3MjQ4VDNS?=
 =?utf-8?B?Sm5DcHFvN0FDclJsdHZVcXlXVzJZZDFyN0NpejJ5NUVHa3JZZ3dqWVArbXBW?=
 =?utf-8?B?ZGlpZnJOaS9GeDRMZXdOR1QrSnBULytCbzdYQUgwS3o0dHFRTCtlNDA0QnBN?=
 =?utf-8?B?UEV3WlRHc09Kb25sQ3p0bjN4eUN1SXVWZ1lvZHNNMzYvazJyWU4zMFJqT2dE?=
 =?utf-8?B?cHQvSDBQaC9NOTArK1ZIZEE1eHR3cG9oQnQ3WGcyRkFXc1grK0g1ektaeFZF?=
 =?utf-8?B?alNIRTczRTh3dDIvNDVUT2hsYmFHS0xGUVFXc3hMQjZhcmJyYUJrMXZCcWJv?=
 =?utf-8?B?RTdJejlnSUJFSzZ3cWt4OWFlQkxkaXBYUlVtZjR1RmdoTlF6NFlhNjQzRVhJ?=
 =?utf-8?B?azdJS1Ftd1cvUEIzU0tEalR3cStLcHBWRVVESUVwWmplRjB3c0NwUDJzRHdp?=
 =?utf-8?B?Q1lkdlJkaEtCRTMvQnJjREpvbmtLTVl1cTdtdE5lYm9DRmZnTXcyKzdPNXFC?=
 =?utf-8?B?VDBZNHBveGdUeUNIQWt3bFVHQzBxZ1ZQQzU3TU5tbTNXUWQ1Yms5VVh5akVJ?=
 =?utf-8?B?ajdTamIxeTI0SFJUSEhMZ09qNWh4YWFPRVJsVk9OTWVGdUE1Y1VQVzgwczZ5?=
 =?utf-8?B?ZldNTFA3NDUrRHZyNUlHZkN1SlRyZUtiQ2c3NU1aNk83ck94ODRxaUU1eEUx?=
 =?utf-8?B?azZGUGJXRFMvbTVkUW9CVGJlc1Q0OVhDNERLSzBHWFdOMWtMbjd5ZjNqTHlt?=
 =?utf-8?B?UmlNL1hJNEVLTjVrTlM5VUg3ZE85UmJMT0VHem40Y2hQM3JRRG5RMEdwSnZG?=
 =?utf-8?B?NFYycmNseEw4TGZqdmhsMzB1bSttaWtUVzdYT2JNZnR4dXZzZUJmTXhDRHhr?=
 =?utf-8?B?aXd4eWI0WWJ5MWlvN2RhL08zVFVtZnlkdzRZaDVMMUh4V2NyMzZ6bkRQb2l4?=
 =?utf-8?B?UjFVeGw3eEhyMUJGU2dqblFPcHNxS0ttVWdwYlZ3TXlQb2lFRlZYc3M3V0xM?=
 =?utf-8?B?NVpOd0I0bW0rY0YvR0FCNFEzV00rNTFJRlhvQXhIT1c3ZU12ZEQySFVIKy93?=
 =?utf-8?B?QWk2QU9GMS9IQTBmaHlLOVVvUCtHeVhQYU9xdVdMQzEvZldzb1VvYU5KYWNO?=
 =?utf-8?B?UjNSb2t6SHR6ZG9RQjh0SXYvaWYycFIrSXdiZDBIZnBKeXNVaHo0ZHN1RE5H?=
 =?utf-8?B?ZHJaTUdRcXRpbE53WTZia2Y5eFVabDIyZGJHVjN2MFZaakovRU9TdkJyVWts?=
 =?utf-8?Q?SW5UvKzOGf9O0NJibrARj240e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db5015f-78f8-411c-eebb-08ddb93b96fe
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 07:39:34.6569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mg4GKuzrKM65EKL0XTvg2Ky5k6QxWi0oRvu94wuZnJgvGvTMCKIpjUF9+5w9qV0c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4135
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



On 7/1/25 06:09, Venkatesh Yadav Abbarapu wrote:
> Add support for emmc hardware reset for the emmc card, trigger this
> hardware reset at the end of arasan_sdhci_probe() function.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/mmc/zynq_sdhci.c | 25 ++++++++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/zynq_sdhci.c b/drivers/mmc/zynq_sdhci.c
> index 4d1f92931a3..f99d464a467 100644
> --- a/drivers/mmc/zynq_sdhci.c
> +++ b/drivers/mmc/zynq_sdhci.c
> @@ -85,6 +85,8 @@
>   #define VERSAL_NET_EMMC_ICLK_PHASE_DDR52_DLL		146
>   #define VERSAL_NET_PHY_CTRL_STRB90_STRB180_VAL		0X77
>   
> +#define SDHCI_HW_RST_EN			BIT(4)
> +
>   struct arasan_sdhci_clk_data {
>   	int clk_phase_in[MMC_TIMING_MMC_HS400 + 1];
>   	int clk_phase_out[MMC_TIMING_MMC_HS400 + 1];
> @@ -1101,6 +1103,21 @@ static int sdhci_zynqmp_set_dynamic_config(struct arasan_sdhci_priv *priv,
>   }
>   #endif
>   
> +static void sdhci_arasan_hw_reset(struct sdhci_host *host)
> +{
> +	u8 reg;
> +
> +	reg = sdhci_readb(host, SDHCI_POWER_CONTROL);
> +	reg |= SDHCI_HW_RST_EN;
> +	sdhci_writeb(host, reg, SDHCI_POWER_CONTROL);
> +	/* As per eMMC spec, minimum 1us is required but give it 2us for good measure */
> +	udelay(2);
> +	reg &= ~SDHCI_HW_RST_EN;
> +	sdhci_writeb(host, reg, SDHCI_POWER_CONTROL);
> +	/* As per eMMC spec, minimum 200us is required but give it 300us for good measure */
> +	udelay(300);
> +}
> +
>   static int arasan_sdhci_probe(struct udevice *dev)
>   {
>   	struct arasan_sdhci_plat *plat = dev_get_plat(dev);
> @@ -1221,7 +1238,13 @@ static int arasan_sdhci_probe(struct udevice *dev)
>   		}
>   	}
>   
> -	return sdhci_probe(dev);
> +	ret = sdhci_probe(dev);
> +	if (ret)
> +		return ret;
> +
> +	sdhci_arasan_hw_reset(host);

This is called unconditionally also for SDs. Shouldn't this be called only for 
EMMC as description suggests?

Thanks,
Michal
