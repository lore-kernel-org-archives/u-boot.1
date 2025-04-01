Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE5FC36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 10:07:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F2E381703;
	Tue,  1 Apr 2025 12:07:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="BeT3ONcO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 365A581EC0; Tue,  1 Apr 2025 12:07:37 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A78A38006D
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 12:07:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3i++el9aQwnRl4Ir5CB6YnPNNWKEMNK4MFE3ICldVKvrv3iui339GQp+TTV3L2A13FYl0N//Y4kKHqe0xr4W8akHVPLo4CimBW9fXJlgtzddXWvyl/46X3lG33ec1N2sK8JYlzG0tu1QN2ppnhCF+XJ06kfg61rZSTU5FGmsIZ6gPObeM0FyNPlWeu9r7D85+QtlEpCYT2pBy6j3zfZ7AthA8klo+yoH6aWoPDvpZn0Np1xYRHpBbkYDEuVQKcL1yUpXtrSotHV0KN869Qa1TF/YTZHgaDZA+AkRBLxar4kThd4LpGj6vzF/jIUqDeciUw6Kz+CzEIp338N3XI2aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSAjFdnH5HjbPzDwP3t7HXN8SQnzUuocysFPqHBSFpQ=;
 b=glmC8MBZKWriHOFl65qsk2diWVC/Elz7ACI2J2Mj7QqJ09FlnylmhvBzbO6KFLwKyTGCy9dCMZfHLXV2nXNjcZWfMlpPuCzmENq+6VWNuofLMiQ0/M824bTkWXGGr/8U/tkf2LqSiWlkpgGD1TQVO1HT8HRojgNr8OSUCiuKHNftIq08wb3y378XTUplqv2c5D+PM8v2c7bfeV1XWEupMjsjex5auduEpjsTUeO8qvBbVmzvS2bFm/GfvDi9DSJZTdNuOghgMRxGOBzMaeZAb1pGalYNT+22TBp9oIoMtHj+HK7paPRj58ZkWIc8p7ZdLizk0vmwDI26CLNIG/Fd/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSAjFdnH5HjbPzDwP3t7HXN8SQnzUuocysFPqHBSFpQ=;
 b=BeT3ONcOnP40iVue2J4graGUbeO1zqXiA1dRUdpnGmAuI77tHzb0PFxuG/6OeuFpVPhekYdv1R10FWJ6lSK7ZKOdcsJBxYdss6p948x8yCUc1Jz6ZyAStOLpmONJHALOTwFLSWneoxuwtOLKfOo/M8XzeorCPbMPGu6pPQ8uJYA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM0PR04MB7010.eurprd04.prod.outlook.com (2603:10a6:208:199::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 10:07:32 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8534.052; Tue, 1 Apr 2025
 10:07:32 +0000
Message-ID: <9b5a0cd4-9e6b-43c5-a770-5fc1e90e82bc@cherry.de>
Date: Tue, 1 Apr 2025 12:07:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: build: docker: Fix code-block formatting
To: Leonard Anderweit <l.anderweit@phytec.de>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, upstream@lists.phytec.de
References: <20250401094952.8896-1-l.anderweit@phytec.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250401094952.8896-1-l.anderweit@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::13) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM0PR04MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: 613a91ca-0751-416f-7c04-08dd710504cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWMwTkhtTDlyczkxNkk2OUE5ZTNsdVNVby9LckltVnNoMUNqUjJoT3VsL2Q5?=
 =?utf-8?B?MklyYXJ4SGdFdDFUcG53WVhUcFZlUS9OTmM0VTZGSXFYRUpQbVEya04wanVz?=
 =?utf-8?B?TXQzWHMxMW9ocUM5eVBkVHhvelFXNk90bys2dzNYQisxM3dzTjN5RnpyWm5R?=
 =?utf-8?B?QXlwb0F2SVY4SVBkWFA4RnNpTHJoVTlqdGpTZjdDbTY0K0JhZnVtVGhEU0FZ?=
 =?utf-8?B?S2NXVzJOdXhSMnZYNHM4Tmgwc1Z2bHAxSGxLTjFhUGdVYndqT2tmZVFVZXFq?=
 =?utf-8?B?dDVFOWlDVFAyYWhKOWJoTUVrK2JFcUlOdVkvdXRpN1ZXSXF4NlFTckFBaGVC?=
 =?utf-8?B?VU9DMGdjdElMWURJQThST0EraDgxQVkxWEt0U1BvZ3ZkM0ZXM1d2dWdDWEMr?=
 =?utf-8?B?T0lXdTI3UmoxbFlCZ01tbTczL1p2M0VkN01qaEdjTDhWbG9sZFdkSjFHNGhs?=
 =?utf-8?B?U3pQRGZXSVF2ZEFMc3B4UGIvUk5sdHI5NzVjeVBGWEJUSmhFdDVNVVZqWlZH?=
 =?utf-8?B?aElUeFZ6UzJvMm1zNll0QnUxOHhTanlpV0tiN1Z2TmtqdCt1cEkzd1hQYWov?=
 =?utf-8?B?MGYvaWd5amEwVWY1bFJoUkZzNWI1OHcwWEVFYkRTeHVGSWFmWU1YRHFYTDFv?=
 =?utf-8?B?Z00rRXVpVXIxRnJPZW80UXdmS2JPMGxvWGFvZGZ0cWNSa1dlWDBXOEszZ2tH?=
 =?utf-8?B?TURESGNEUjAwM3NXTlRkV2RPckcyR3ZVc3F0R1BYVjlwcWd6N2tvY0dESUp2?=
 =?utf-8?B?a09hY3hkM3FzVXY0MVh0bTc3U2p2Q3FBd0dOa09TelFodk1oYWRFazF0TDQw?=
 =?utf-8?B?ajNIbnUwOURtZkdDSDhvYkpJcVpDRW5WZkl2c1drZzhIc2ZlY1h4bGNUSTNs?=
 =?utf-8?B?L1Zrd1hPczJGQXZmOE01NVpzTk1lYUM3UC82L1IrTERMbmJzUDJVcjk1L0VG?=
 =?utf-8?B?TWRhZWl0R0Y1blpLN2I5UXcxVlFkbjI0V2YrNWg0Znp0dWlxMldsRGdwMWw4?=
 =?utf-8?B?Y3pvZWJkelpmanhqUDlpSytRUjFQdjlibkVVTDMxV2drdnBsMnIrOFhwdUgy?=
 =?utf-8?B?YSsyTXpmUU9hbzJHZ0Q3ajlMMnkxRWpnb3NkSWVsNDhEZDVxcWtCUGdTYlNP?=
 =?utf-8?B?ZmlCdDNTdGZETENvMno1bTdXMUpSaE11TmlKcTI0QUZPV21lb2p3SGRJc0M4?=
 =?utf-8?B?RHVkQmZiOXA4ZStkOVYxY3NXSmE3dEZDeDliTWFEMVdSWlhBblM3ckZJYXVE?=
 =?utf-8?B?dDFlYmNlakgvUjFJRUx2YXNrMjF6Y3JMRFlPell4RWdWNEFaUEt1WXR3bmFS?=
 =?utf-8?B?MlNpZHdNRGlhQVR5bU9EV1U5RURwTER2YnQ0UmRqbUtZd3pzK0dkWTROUmxU?=
 =?utf-8?B?NU1ERFNqVXI0TGJIOUM1S1ZkNVAyRTRSdi9UTGk1eEFSamRKWW9ETDd1V0ZV?=
 =?utf-8?B?bTg0YkVLd2F3QTRtZXMrZS83TGtGanlJR2tuRktnUmpJWmViTkMvVkUvemRF?=
 =?utf-8?B?N3J0M1VaMm1tWnhTeUZwQ2Z6YjJIY05CVjVLUUgzOXo4ODIwTEkvVm11L05F?=
 =?utf-8?B?a2lxVkRaSE5Ba0NhSjRBNytSeFFzWGU3YjVXRHJSSWVLcHo1SVlna0kzNFpo?=
 =?utf-8?B?QUwzN2UwZlg2MnVVWWpRWFBjenJVbEF3NVR0c2RvVzZqRTBKNXN4anlZN0lh?=
 =?utf-8?B?M1dRODl2c2Y3OEQyTlUvQk0reitBcGtmYUk4UTJEK21hS01sditVKzlyZDJR?=
 =?utf-8?B?T2h1a2tpbUJmTUhzQ2x3cWhqVVprUXROcjZsYitSU01vekhndFZkT3ZUL2VX?=
 =?utf-8?B?QXFVVWJ5bWdicytLMGlRQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0xuL1NNYXg1NTdnbUtRRmRUbDhCbjRkVzgwREk5MkR0T1JtTlFwRnhkckVE?=
 =?utf-8?B?TUV4UE5sN0laTnBMUVRBWHZCSnFwKzJzbHFJUGJmVTRveWdDL3VwUVpzc05O?=
 =?utf-8?B?Q1k2NjJXajRBZUpaTUd3eG5ONldRdVZEblc2VHFYN2FONjJ4QXlrNE5EM21q?=
 =?utf-8?B?NkZjZjliVXp4SXA0VWptYis1Z09PdlNhdENCUS9UQ3M0RERTMytnT2RSTG9r?=
 =?utf-8?B?cE1CTUt3ckdkaWx3bU94N01qTVVCcmRqODRKQUY2KzVja0htVE4wYzdiNzJ6?=
 =?utf-8?B?aWNLRURoUDJ3Y2packRmdURBbTZhenJFN3VPY0xiWHVLTGc4bU9JSTBFWmpG?=
 =?utf-8?B?Zm84OWRBMENOZHBsZHlnZFgvSGtRWE5UMW1RYjBVckJXeGJ3UjJzWHFEUm0x?=
 =?utf-8?B?MWZnOHFMenkvbE0yV1lxRzR2MVdEUUFMU1RHVUdYQlZYaDdldXBaWmtZMFZS?=
 =?utf-8?B?ajQwV2dIWEViQW04T2FTaGhWUzI1Z2tJb3VRb0RSbFZDV1VucDVsaFVLUEVz?=
 =?utf-8?B?eUZmcEtINmFhL3JBL0pDb3pHR2FiNWIwMXE3a2JlWERSZW1pTC9kT2pJSTZL?=
 =?utf-8?B?c0xyZ0NVdGdPVnF2b053Vk9qREpzdENOY2tyV1lqdXBSZ1ppSFhWM1pSVGpM?=
 =?utf-8?B?dzZMZlhUWDlKblVTWU9WWmtmemlaVTBoOEIxeklYZHFOYWwzK0J5RzVQMytW?=
 =?utf-8?B?K3dGZFJCQ3FsbERpdUVMamkra3NYdnE5cDhGcWZPMmUxUGRVNHpDWjdrVmgx?=
 =?utf-8?B?LzkwQ0tXTXd1NTRNaFo0dEJZd1RDNk1NdlhtQWNEU1BNOFVQS3MrU2pEeEor?=
 =?utf-8?B?b3dRKzVXSmdnNWZ2TEphQ01qMzlhVk1uVlZNMnF1R0lDb2ZZSWI4MUxNdGJG?=
 =?utf-8?B?bTg0N2xNNDRJcGFzcWpxZGVKd2NvckVUdndtYW5OVU12NmJoNFAwa2E0YmNJ?=
 =?utf-8?B?K01QQVIxbXlXckJiYis1QkJ2akpWa1draTcwV1pJaGZLcC9LNFc3MExYcTdQ?=
 =?utf-8?B?bWQxUEtzY1o4UU9nR2hJdUsyWkN2Vkc2VHN4bzFrQndkT3NxTzduN09Deisw?=
 =?utf-8?B?V25EQTV4bTN3eVNjTE1vZ1dGVm5oSUpLeGliT0MyL3pZSWdSMEVsMW0xdVZq?=
 =?utf-8?B?alByTk45d3ZjUnVUVHNia1o2dW1QcGxMZ2grcGxCUFRsMGtPSm90aFBzOTIx?=
 =?utf-8?B?Unp6S1hqajVjbUlLdmZsS1FNQW44MEg1dEoyQjdPd3RaQW1PV1dYQ0hGeTlv?=
 =?utf-8?B?VmRFZHAycC9sR1l0RzhSR2J1N2VPTUZBWnhJVGFLNWh0c29FcE5RSWFhdm1H?=
 =?utf-8?B?K2czaFlBalk3WWcxeDlYQzVrdEVyaDQvQkVNSWhjU0crMkd5ZXBQa0V5VzlR?=
 =?utf-8?B?QmREODFGQS94UWkxMmQzOU1nMksxeWx2RWl0bEVES0ExR0h6RnMyRHJGa2Mr?=
 =?utf-8?B?dzE4NXd5N1pTdDFPLzB3bUhLWFdVZFNML3d3dU1tTEFLQVZDWVN4TjIraDBZ?=
 =?utf-8?B?a0lMazhUOVcrQnZ5S1RZaVhzVnp4RFdGeXp5UWNmSVl3d0dzZmdvZ3diMjJF?=
 =?utf-8?B?c2t0aXJQMlo1SmFyMlVnWlhkdFZWamRNbTBkK0RqdWpwKzh4TjJnNzhOckhB?=
 =?utf-8?B?SUJWeFAySHQvcWNuc3dPOWpPc1dYK0lCTCt3ZW9YWUtEOEFPOEJ4cFZLZjBY?=
 =?utf-8?B?dVhsTVFteCszV2JPY2x2ZzE5YW5mcWtOSlRJakdtTGxHN1dTdHh5R1g0enp4?=
 =?utf-8?B?OTV5ZVlaYlVHSk85dFVhUkdnMlR3ODdRbGMrMWw2OHJGQWJFR2dnRXVqbnU5?=
 =?utf-8?B?QUFIZFJBY2toelZTRVNPOUNxSnU2V2NzM3FINVdBTUZISERFWlN2TlRESkNw?=
 =?utf-8?B?UnpUMW84SnVPdG82SG0zZHJjaGRlZmdwUldOT0cvM3czYk9DODcxNFU4NjhX?=
 =?utf-8?B?b0xwNXBvaDQ0NlFNN1I2ZjFaUFdQWmxsNXI1V0VuM1VLYWtWaU9EN2xXS2hL?=
 =?utf-8?B?QUIwUmVLWFVUd2pCdmN2N2ZUaGZFOTU1OWQ1THV4ejM2Si9PT2EyQlFlMEtq?=
 =?utf-8?B?TmxqYnFaMmR0cTAyeTROK3hsa04rVkJBUHRqdERacXozczM4V0FORVRQNldo?=
 =?utf-8?B?UDI1Ty9RaTFDQStza1JPUE9CdzJtaUcwY2NqR0R4RTNVRkdONDJkT1hJdklB?=
 =?utf-8?B?akE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 613a91ca-0751-416f-7c04-08dd710504cf
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 10:07:32.7485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3yOUBVqxw2jvFI2o7GUTcHF5XvZ2DlZMLYauCOm35j9LbeJntjDSr84rQ7bCm4eUVYUsLk6hhvE4q38PPxlqTDEPTKi5jhsgS+QjTiHt6E4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7010
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

Hi Leonard,

On 4/1/25 11:49 AM, Leonard Anderweit wrote:
> Remove double : before code-block. While at it, use code-block for all

Why?

https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#literal-blocks 
is valid.

We could think about changing the default highlighting language to bash 
maybe, I don't know.

If you use ..code-block instead of :: for syntax highlighting, then say 
that in the commit log :)

Can be two commits though, one for fixing the :: following by a 
..code-block, and another one for switching the :: to ..code-block:: 
with syntax highlighting.

> bash commands.
> 
> Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
> ---
>   doc/build/docker.rst | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/doc/build/docker.rst b/doc/build/docker.rst
> index 01ed35050908..4974a98d4af5 100644
> --- a/doc/build/docker.rst
> +++ b/doc/build/docker.rst
> @@ -12,7 +12,9 @@ You will need a multi-platform container, otherwise this error is shown::
>       ERROR: Multi-platform build is not supported for the docker driver.
>       Switch to a different driver, or turn on the containerd image store, and try again.
>   
> -You can add a simple one with::
> +You can add a simple one with:
> +
> +.. code-block:: bash
>   
>       sudo docker buildx create --name multiarch --driver docker-container --use
>   
> @@ -20,7 +22,9 @@ This will result in a builder that will use QEMU for the non-native
>   architectures request in a build.  While both amd64 and arm64 happen in
>   parallel, the non-native part will take considerably longer as it must use QEMU
>   to emulate the foreign code.  An alternative, if you have accesss to reasonably
> -fast amd64 (i.e. 64-bit x86) and arm64 machines is::
> +fast amd64 (i.e. 64-bit x86) and arm64 machines is:
> +
> +.. code-block:: bash
>   
>       sudo docker buildx create --name multiarch-multinode --node localNode --bootstrap --use
>       sudo docker buildx create --name multiarch-multinode --append --node remoteNode --bootstrap ssh://user@host
> @@ -28,7 +32,7 @@ fast amd64 (i.e. 64-bit x86) and arm64 machines is::
>   And this will result in a builder named multiarch-multinode that will build
>   each platform natively on each node.
>   
> -To build the image yourself::
> +To build the image yourself:

This one change is fine though (or removing the next line).

>   
>   .. code-block:: bash
>   

Cheers,
Quentin
