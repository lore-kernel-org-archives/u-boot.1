Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E91DF3D334
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 17:07:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AAEC83FA6;
	Thu,  5 Mar 2026 18:07:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="eCuX2unZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCAC383FB2; Thu,  5 Mar 2026 18:07:54 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F7F283F2D
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 18:07:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1X26NjFi/OLpfOKnTAede6WWAzBEt4ehTCIdudhnh2fsoYuZv8MB7FDON991bBVqVHOdgpm2bkU1HESmyKuCdIs5mPJazUwHnYgZVQNU2T17i27Twe1x/WKvW7I+4/0Qz7LhrhxDv2zU4szsfjQ6Q/rZ6JDJscKTQUZrJ2w+k47T/+UUvMuTTptKc8OwZCpo+Faypqo+NxbmxuxGmGiCNCq3goQuuAcA+Kn7w6K0hrQ2crFXHiH/CRhZsI+Ttd/VglGgS9s8QkIjr9T1wTntx5Q0MksDdyTFYJ6bzsmN2iIvoLNTDo2rK0VUvIbtYftFIbA5xOJuXBoVN99fDgm5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ca8HGugvce0XBc5r2eTPnXB00bnaJThXy+G0lFPx5m0=;
 b=iWZZOYsIyo9OCGVQHK7NgoWvMZvmFV/RTPaSjDLyaYkCYZQjV14Xjz7HAUcRuN2WjCX14cy1gM4ZIJ31ACvLClDnNAesNfCxCPq0DGz9b5Nbw8UwINq4VwaIcJNkh0o176nEB4YLd6YrKIjuGSJFMbvSA0SVdH2PzoiwNmNzGF/5nBxjP4hTSeYF/LiOqSeH+EV2qbt9QbJ0wRreNVqiU8tkbFbIbGDM01NxRLEzwIK5RUi/dfaEgxEu/xayRR2/xzlGoJfm9J+Iiz1knN4nUPxdG3Xk+nVVahQxItyjByHW8deOKZ4fQN0tXru31+EaZOgNWB7ypYc5Zdgiej77iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ca8HGugvce0XBc5r2eTPnXB00bnaJThXy+G0lFPx5m0=;
 b=eCuX2unZCT7cU2TwY2uspCYZYW95n68fab0RFg9IMZ1Y+/9PN+w+jzgGHBf3vIzW+zDENwk2zsI6BzlXdPEvXBdLl6wLdhLbBcJYc5atRRMP+Es6aH3JGK++3tl+t26vb/EOgSmisz/mrWZGzv5Ywg253Rd3G9PzS0Q1v1sovco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI0PR04MB11483.eurprd04.prod.outlook.com (2603:10a6:800:2cb::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 17:07:49 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 17:07:49 +0000
Message-ID: <dcc67fda-e3df-4461-83f8-507b25a6c4fc@cherry.de>
Date: Thu, 5 Mar 2026 18:06:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] image-fit: Fix mismatched parameter type in comment
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20260304075100.3637609-1-hayashi.kunihiko@socionext.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260304075100.3637609-1-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0176.eurprd09.prod.outlook.com
 (2603:10a6:800:120::30) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI0PR04MB11483:EE_
X-MS-Office365-Filtering-Correlation-Id: d6f8f0df-b314-4611-2e06-08de7ad9ba7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info: qHIS1cgGrcmBKr6oXySe8O2MC/3nnUojzqPIFd/9y7FVYLwLHYZ6PCnS9FQSHmsgbrptDsJC7RtUZRJrf6O7nyFAZJIHJN9y9ekzDzgWg0pktGldv4JJzN8WG+dtKTSBV82myMl3Pe/6T/I7aiyIHYQkr7tISHPe0x/5CYriwDzFDsVo1uMqtH+qmJbXPaDicIoozIvc9yZloOB1zs0MzuT8sfvKE4dFJLFl+b/HvVaMYQeLFh8wq7s6hu4qByN21i5+444yzOtNlzfmDwZO7e9M3Dl+ACnnKL6QPVxMWihrf5NAqC1VGnS1Qhk8Y3aDQxvkR3HOsu+Pka7o8bA3uXWccAcOgS3bhyxmcEKHyS+0ISQfNPLXpMpl/nOMJsB+jrTFfXLQVqMoqQWXT+DNvGjQpu/P/84UW33Ftg2zgmLj9RJLbRi+qpjw+jD8J0GDPfuURZzpjG8jPiuM/qM9nvoSVq3JbEitog8wMJR4ahBqhZ+Vxk9Pi338WqdsKP0RrplRR2Yw/5VaMowJxxVDz0hGJxlPtgl2wGfgkT1c/2amp0HCl7XBPaOdW6Pv2rDmJrO9Ww/ziZoAIWBwjMGU2rykd0SiO0I4zfFjz3fK+PYGhGl+TtsIY9B86UopNCz9NB9qbwE/tQBFvCDm3vYLfBAaT3OZ9CE9r8q96GYvsLLm7w3PGUH2cgmRXpjUSza0NBIRS37bJtMSA5aJifHEhhsNx9JYEDx9Q8WBYQtwXGY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejkyQ3FDeDhNMUY4cUNLcEp5cFZCZHhlbUtFeVdYaW5iVkZUN1JHYXFVamlE?=
 =?utf-8?B?ejM2dWxwMDdsOGlpWkxadE01RVA2U2dDRy9NRi9DK1VJbDM4dDJ5eERrU3Bq?=
 =?utf-8?B?Qi90MnNHVVFIaU5pQkxxenlXMUdNTWUrUmRqMXJBWTFSczlDTGdxV3kxRWFI?=
 =?utf-8?B?Q0w4NjVtbXl3V1U4YWlRV0ZsbDJST0orSEZzV3AzVWEySytidHdyTmZLSjRJ?=
 =?utf-8?B?cjZ6Q0pjbjVJUE1uWXYrTFE1aFRERUNSWXpNUlFTcWo3a2s0cS9ZQ2FjTjFI?=
 =?utf-8?B?MHFvWWcvKzBFenpsNUNmQ1ZueitvU3BKZTlNMU9WT2YwQndmWUNQalFaVThF?=
 =?utf-8?B?VlNkcWtuaUN3clZKc012RjNVWTNEUkJLdDN4NVVBQnYvSklDR3BidXlWbW5y?=
 =?utf-8?B?R2Q4Y255UGxmN2E4VElqTkZIcmhMVTNJcDQvS3hlN1FxUGhxVXdlZVBaMTBV?=
 =?utf-8?B?WEVtckZ4cEV5Z2lFTGxoNEppclFqRXlUOC9Ld1hKUVc1T3JCUGV0c2NrQVgx?=
 =?utf-8?B?c1ZxNDJENkdvN05KL2Vaa09VZUY3eEU5bHozYjJFS05iUDFMNzl6c0s1UGZX?=
 =?utf-8?B?V3BQL2cyRllMT05DTS9RMmdSM2pFcnBFTGMzQ0FQYzVxc3k1YnFJKzhEZC9a?=
 =?utf-8?B?NEJQSTZKZ1ZsZmIrcm5uSkxMR203TzFZMkNGRzhpQW1VL3FWYnMzQVo4em9U?=
 =?utf-8?B?YTNwVHNDYlVuK05tMFQ1L2VrZmdHZUZZalBtUHJobGM0dXM4Z0d1djViSHZT?=
 =?utf-8?B?MWpoWHRvSjFaTm9vcVZtVUErZ3ZOdERsZm9sMU14NXZpZlB6bjZpbGxkVDRz?=
 =?utf-8?B?aTQ3c2Vjb3ptZjEyWnBFSXRIbkhEaFRrVHVjSW5NVE4zYnZBd084dVNUN2Rj?=
 =?utf-8?B?UE1FamluYkdNOElFcjZhaVBWNnBFblRITHdWTVB3V0IzcDh2Q0ZSYlJIenV3?=
 =?utf-8?B?U05yTmdpYjMwaDRJM2lPVzI5S3oxQjZkbmdscEJVbXoybEoxNnIxMHl3Nktt?=
 =?utf-8?B?S1dnbGxYZm13dFZCamswSEZrbkJSQmN0M2ZjTjgzRnJJd0JvTG5RNWVxY291?=
 =?utf-8?B?OHpKY1hsdUpCVytEVkJQZXBXa25CRkpDTnBkQWZWT2ZhaFVIY3FVaGNTREl5?=
 =?utf-8?B?eDZYMDJ0NkNENnVjY0VmZWpQVmRwWkdPOUNWdzBGZzdFR2M1aGdBR1RWakhl?=
 =?utf-8?B?aFRXYTZBMjFaVlROMTczSzJDanNqeG11ck9aY0pPb1k0ZjJYUFlsckNzMEd2?=
 =?utf-8?B?bTIzZFlLSWlaY2hiTmdCamlEdXJodGlNRk1EY2NpL2gzUWRFS3BEQVdLNHpi?=
 =?utf-8?B?dWN3VW1SNG9rc1R4WE03VUhVVml0T2lYUGpOVWFUS3hTVWhlVTI1QjBhRWVo?=
 =?utf-8?B?TVJuWGk3aWlIQjNtREo2TW1PRFNjNlhFdGlKYXozd3Y3MklYNkc2LytqQjZC?=
 =?utf-8?B?V1M1cEVJeDNadHdxK0JKK3J1eTJLa0RyM2lkN0FhVmJEdUhTbzdpNjUvL3RR?=
 =?utf-8?B?S0xlc2lTQWlnOWpQNjlRSmF4aGozVVhOZFRLclJWcmlzSzRlVGRnbFp5TlNl?=
 =?utf-8?B?cGxZSXkvbkxrV0wyOEpKMGpwVzMrUmp3aXg5ZThsMWRhMFFBZVoxS3NwZzZI?=
 =?utf-8?B?dlJiOTRhYkNJTEtXU291SmtFcm15ekg0UlFCMmoxZmxFRFN6cjdxZWlRN0ZL?=
 =?utf-8?B?anZscFBQaC85bkVxT3o1OFFwczBDYVhPVzRNL2hXZk5KUG5BRThwOVRxQTJV?=
 =?utf-8?B?dUNnZm1EQ3ZrKzVsalhaQW9PZTFTSkt2cjQ1UHRxWTNZQmpXa0E4WE5HR0Jj?=
 =?utf-8?B?Z0MwNW95UzVrbmVmRnFqYjd2YlFYK2QvZ0hJVXFXNGtmRHVBVFpqbkZlWXps?=
 =?utf-8?B?NjRsSWVIdzJKOXYzRE9VMWM1ZFp4T29rZ3RqdzVTaFpPMG92b0Y0VnZnaTZz?=
 =?utf-8?B?ZlV6SWdjV29HMVF1czF2MnlZbGdPUjFseFFDUUNQYkM4RkZqTlpaR3VmQjBk?=
 =?utf-8?B?NkZJdVlzOW8wK2p6cTZjV29tazlNaWx5eWpqaXNLNHhZSjdKUWVCNk4rRjJ0?=
 =?utf-8?B?anJXdWliVkRYYkQ4UDFUT3F0UGc4Q0l0V2luZ3JvWjk2QkJpc0wzVUdjTWl1?=
 =?utf-8?B?SURvSjFjQUJ0WVZnRkxPM0VOaVBwTVY5Z1V1UGtyM2orZGVaMmZRVnQwMXU2?=
 =?utf-8?B?RzJDMGRlaUNEZU5QODFaOUR0WmRScjJwWGFsU3NtOENBbURmeThCczBQWmFF?=
 =?utf-8?B?YnJkbUhSS0Jra3hVUUxzRWR5ekRnaTRNZVNSc2xhcC90MFpXRjg0Lys4bGVp?=
 =?utf-8?B?SzZ0dk5oOUt3V2V5UFBzNWhVeXlabVIyYXFUalRPK3pzWml2SUJ1UGZmNDNI?=
 =?utf-8?Q?cWFUoVNqqZZG5Nzb6lhDekbJxePpwqaY+DiKV?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f8f0df-b314-4611-2e06-08de7ad9ba7c
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 17:07:48.9438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lswGIdtj2n4mvZeRTsXb5p3zNSYMfeobWxca3JXLvmQCpPsLCevqutp72utilf/9qrZkl39/v1uwkd0sHSEd6PXdT9Ok1EFoKB0mrSWz4xE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11483
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

Hi Kunihiko,

On 3/4/26 8:51 AM, Kunihiko Hayashi wrote:
> The functions use 'ulong', however, the comments said 'uint32_t'.
> Update the comments to match the prototype.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
