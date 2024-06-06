Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B98C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 15:35:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA3EF881A1;
	Thu,  6 Jun 2024 17:35:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="VCAn9ABF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C22F8817C; Thu,  6 Jun 2024 17:35:04 +0200 (CEST)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2602::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A851F88274
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 17:35:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bauOnJHSLzwSfJSABrAmetWc3SP8GmBEqJb8lNLOGbUKkQ287AdTy3vugO0wFJByq8qjeHyTXP3QzKa1IaxcUdMGQir2xZo6ZdYRxxu4L/1hQLE0VNOjibXed5Dv+X4Ma0ew8Us4tPBTzcEb428dUINXI/lx8N/ek9Lnf/BqPa4VA/skrWYor8GFckiDC8S4q8Bwi+GI7aPF7RrbD7yqZTCczfrnXC1PpKWG6R0P3eyu1KPKUv3xpg43oHU1i09I+YzHzjXvsyP7+rNpi/N/eYkTg8Mn8uJjo4+cJeIW1YXQ8erSSxPRgRMDcqfAugy5ZDgDNc/mAVQTvQltp0VTxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPXCkJed6K5F3VPjYvADUDltV3l8ZWvHzkIEj31pf/U=;
 b=Vtfqf4riElYTr9IiALuGUFVq/HeFToZmiDPDxc5ubVOuhJHe9Qeo4nn1cgd2MoDy8nQ6gg3ZPuDITM2LJlGhoQSNcso/i9bQ4jFiz47FCrPurnpXHbqm6uyjRNPFl63zWz3D20qsmUl7Z7KdWGRMBl8dIjKLvHDhNpzMra6PK/WI+1FPihRveN/5Hd5ABKun/jhpjNfawiNJtFWyBrMVFhUE8kHdureZFosLaPUIoKC3pYj54fs9KLlQJiCnR5u7KND+G3RCatgrF+x84D7Le113dfPs5RvFZPL2eGo4ukdjgfVtQBVreHjbkx2hrWkQDzKz/vM7prdcCj5MTjE2iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPXCkJed6K5F3VPjYvADUDltV3l8ZWvHzkIEj31pf/U=;
 b=VCAn9ABFr9sA6++e74+e+6fL9/TW4vzSGtUEYnEAVCvHjLbA8lKG/Deh63cHpE/NZMAMcA2h/gwPm0nHHDlyqW5rQcgU/C9DlSGBI96bSWsNs+v3vbTRZHRYg0EqCWWj82BXkwLSsm7ijshUp0f3uNXsHIK5/Vts8WCtpBwPM3M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by DB8PR04MB7033.eurprd04.prod.outlook.com (2603:10a6:10:125::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 15:34:58 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 15:34:58 +0000
Message-ID: <a9b83883-f429-46c7-a2d8-0be187ad3be4@cherry.de>
Date: Thu, 6 Jun 2024 17:34:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] drivers: bootcount: Add support for FAT filesystem
To: Vasileios Amoiridis <vassilisamir@gmail.com>, trini@konsulko.com,
 hs@denx.de, pro@denx.de
Cc: vasileios.amoiridis@cern.ch, u-boot@lists.denx.de
References: <20240605181041.68317-1-vassilisamir@gmail.com>
 <20240605181041.68317-2-vassilisamir@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240605181041.68317-2-vassilisamir@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0023.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::7) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|DB8PR04MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: c1ac3a0f-49c7-428e-382f-08dc863e3903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWtIeUY2UlFYTmdSUk0zTS9wMEl6RVplUHBWM1A2ZFluT0IrZC9jU1R2TFVG?=
 =?utf-8?B?bjlvMGpybGlZWEw1VXhOWElJc0tmSWU3YjlWTEpkdEdUUUsrcmVlOGF0a01N?=
 =?utf-8?B?OTRHd1QzNmNEV1RhNjF6WU01eWZoeXlZL2c1UGdiVUIrSzBZbU9GbnhjSC9W?=
 =?utf-8?B?TmFtTzF6NENEZkE4V3RVc1hhUk1ETElIRndGU3NkNkQycVNaZjFYbWpPRWRJ?=
 =?utf-8?B?UmdiWlFZV2l2eGpBVUdCZ1g4aUlZcGJHajZRNFNLdVRBVVZhMjRaQ2RQK1BT?=
 =?utf-8?B?eDU0cllxcEVHQlliYnhBbHg3RFU4d1dTa1lKZm94SktueXhDNkZ2WGFGdmRU?=
 =?utf-8?B?TzdoRTlpS1Byd2N6S1ptb1BraGVFU2JsTlB6UDMyK3hmeHorTjVOZ2FhUDZi?=
 =?utf-8?B?WFN4czdPM0Jmb3pLeHcvL3RXL1NlWDMzWEV0SUk4Qkh0Njh2ZHNRUFMxSDlw?=
 =?utf-8?B?YUNBTnl5cndWUnVmOWN4cXFQa3pSUW4rK2kxckc5bDV2emlhRXV0a1FpVU40?=
 =?utf-8?B?ZEJCdXozRTVDbHRoVlNBdjdZQVBvZWpYbERTZXNqM3BZbWwvRTdSeFY1S0g5?=
 =?utf-8?B?clY0MDhYb0xuQlhmamVvQUplT1EzVjBuNWRrM3NkK3gyeVc3aitpazg2QkN5?=
 =?utf-8?B?ZnVETWJhckIzZTBmTGJrK0Yxbjh6cjJ3RXZ6VHVER3lOc0VlKzl0V21aNmVl?=
 =?utf-8?B?eVllRDNhMEgxdUNUaC9VSWVNK3pSdGUzb1NKaXRNQlR1NnhaMnpMQ1VrdUdJ?=
 =?utf-8?B?Sk5LcmRPVFhidUgwaGh6bnpUQ2MvbXlJSFRzQ21JeGt4OWJqVi9pUkI1U1RO?=
 =?utf-8?B?cnJUSUlXN0Y4WjZ0eG9iSElZSkI4elFTZSszNFFBemcyYWJ6VnFpbEpYL2FO?=
 =?utf-8?B?cURnTnVBS3FYR3hOTGJ3aFk0eTJRNnNzek1BY1ZiNDE2UE1odElUdjhQdTBF?=
 =?utf-8?B?WlNKTUxRaEZ0Z1k0RlMwK0xIMGJnc3hYY3I5a1JYTytqUXQ0a3lFcXBUdU5o?=
 =?utf-8?B?QnRnWmY0SEJGRHNaSUVGd2RjUjNDbS9qWTFVOTdjVnJaQ1dkMFZhQk1XTGFm?=
 =?utf-8?B?ckVNS1MyNzg3aXdHd1Y0V21WTm0wNU1CYWUwTkQxOTVZWlJIUk9DTllXcDBZ?=
 =?utf-8?B?NUF1cVh3WFRCQndBYVI2bnlweEZrQUM2bi9rWjJHbnVqTlVFalFzV1dvWUJ2?=
 =?utf-8?B?ZkpscXQwSzgxVWZoSGtvZ3lzSTUyTFpPMk9hUUVSS3E2SngrcWJVWEZpcEFj?=
 =?utf-8?B?eWlsWjBMcytXY3d5RnBXN1NOMm9qVi9xRUVlOGpxc0Evdm1OQVhoNTVBcUlV?=
 =?utf-8?B?T3d3MjQ0S2o4VloxZlFvN3lTSHhWcnRSRjllNytUSjZiOWFJQzZ5UkRqSXM0?=
 =?utf-8?B?RDh2cTY3dUkwOW5PZzZqbXVvN0tCQnVMVlg3d0lJSzkwT1RRNEVETW1YMUhN?=
 =?utf-8?B?M29QMWZyK3NWQS9EQmNzSW5BRWlXSlhSV2VJL2ZiSzNQTEhsZVVTQnZZa1Jj?=
 =?utf-8?B?TkNKWXYyVXdDWk41YUVldVlUalJQV1IrdEZuVHdIZXE1KzB6MXZLOEZiYmJo?=
 =?utf-8?B?Ukc5VURLYldxc3dRdkNYREFFb1E3ZTEwU0RGYVVSb1lIVXljNERnQUY1Mjkw?=
 =?utf-8?B?RDNmRE5zUGd5VDZJaFRkM21Rbzhya1hzeWtSZEVxamZvcWZtaHdFdlQrMzFp?=
 =?utf-8?B?NUl0cGxUSlVqZjRsT1FLb2ovMkp1Nm0wUThyVmJneGRURFdBSVJXS0svcXFl?=
 =?utf-8?Q?3Q1tVyQMkn6pAFQfmL8FkphgrcTAiwdQ1EanuSc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnBHMERyREg5cmN1S1pnTDFXOXZCQ0MyNkdEVHFycGJSRVN5SG5rZ3JPeWpX?=
 =?utf-8?B?bkljWjVwbkxEVHcvdEFIWXNRV05VUkFidXlmMzdKVlhQbU9sWDhsNEIvdnB5?=
 =?utf-8?B?TUJXMDlMR0RDM25PSmdqZURmS2pFYmdXYkVZUWZNZVE2TFVDVVBxUERDbGo2?=
 =?utf-8?B?TnYxdmE3clRMOFVSVkJ6bDhKMVFqeExnY3FjSHJEd0d2S2djQkZobVNXemdJ?=
 =?utf-8?B?aEFOc2orUENBT2k5SHJ2dkRhZTlyZ3ExS29vdGVmL2RFNXB3bW4yTkZ3UEQ4?=
 =?utf-8?B?RmFJVTRCMm1rekM2YW9zNDVlcDZDMENnSUpaek9ockpyMmZqTVlnd3picHVX?=
 =?utf-8?B?VHN6bUw5dnhyVHcrZlhQZjVrdVRnQi9mekJPc3VFWlBaaDVKL1FjOHFqeHZm?=
 =?utf-8?B?ZUFucGRTTGxsUmFFdnJrdjcwK0puWkNzTUlhektnTVRYQjFrUVYweXlZN0xx?=
 =?utf-8?B?N3lGK0J2SzhCMFNKbVZLQmFpZkpaR3h3VkU0b0pWc3Y5b2NoSFNFSmtvUzRt?=
 =?utf-8?B?KzNNRVI4V2FDNTlhNEo0WXBqeDZhOUE3aW1sS0lhQ2FHdlNlcWxESGt3cEJX?=
 =?utf-8?B?eEdqQTNiaUh6N1d1elVHVENCT0p5OWt4L3ZNeEZiOGFUKy9yYWZPclMrK2R5?=
 =?utf-8?B?ckxYR1YvV2FlVFRhcFBGenhaYTNvMFRxRytiU1JmY0J3cjNXL0FMZGY1azJW?=
 =?utf-8?B?RGpaUTUrTUg5WUU2MGJOV1ZMa21GV1REM2QxOW1TbjYweGNTQU00MitDZ0sx?=
 =?utf-8?B?M2lUUDYzdXkwWmkxRWxzU0Z0V0VqN0FtSkU4MlhqS1l5ZVRFeTJQUTYwWE5n?=
 =?utf-8?B?eUZSNTNtU0Qza2FsY0dIalJqY05LanRHYUh0dEN1V1F5SWRMNzAwb2tvQ2lx?=
 =?utf-8?B?Y1ZYZThDaXpDbHBLTlBwdldJZEFqSG14QkFVRWVlRW5GSWk3YnQrSkJhZURE?=
 =?utf-8?B?R0tVKzdacUFibFZvOVRRMDRmMTdYa1YxWXRHczFqTC9JT2NDdmFkaERCK0Fu?=
 =?utf-8?B?TGdJZ1VzVGVpMEljZTdjclQvSlpnTlk0a01qcWZxSE05VFNnZTN0NHc1V2xm?=
 =?utf-8?B?L2RSemJWTU1HWFphV1lHQzdtV1E3TWVVc1pzaHdudjN0Zk5zckVaakZzK09E?=
 =?utf-8?B?TkV3aDBaVTJSeUE2MGdESTB2K1pBN0RjVG4rcGpjcDdiazdIcm5TUHNqRkF2?=
 =?utf-8?B?RHVlZjhyT2svNjJ1ZDE1UGxUdHp2QVdHdVFITkpsSzhGT2FaaWM1aktXQmU3?=
 =?utf-8?B?NnEvWFR5aUMrSHh6ODRUdmlLcmFjZ2ZtQ3dabDdkckRqalo0OHNXYzBVVmFD?=
 =?utf-8?B?djZIZ2NNUC8xdzcrU0E4VWtwdkpFZVFaUjZlUEJXeEplRHZ5eU5HMGZpNi92?=
 =?utf-8?B?SDBZakdINkplN3lBTUZWYTJyRzFta0hON1A3anJITFhlSzdJanhXNmd4Vzlv?=
 =?utf-8?B?Wmo5dnBYaXNUUmZ6ZVFySmNWYTNzem4xazlIdFJyZGFBTGx3Yy9LejA0NjBH?=
 =?utf-8?B?bndxamdOY21meFNnZmpUNXAzY21taXVzbmVYRTFtZ0NWYm9lRDBYWEJyL2FP?=
 =?utf-8?B?cHdVN2FWVndjZldWWlRBVDV2WjZPZXRrVUF4L1ZjU3RGWCtJdHVrOEwrcCtG?=
 =?utf-8?B?YXFkYmlrVVBXNjVNYU5aNlZxeTJ6SzFhdjEySWJNWTk5SFUxRTdTQndVNUFQ?=
 =?utf-8?B?WkpELzBLL0puMVdWcjQvdnNtOFFWNWpVQkVQT2JmQmR1dkpMMkwxL1NNc0l4?=
 =?utf-8?B?ck9FcUdWYjk5R1VESGpTckJORGQrWUR0N0dzbVl6SEkxdnpsSy8zZE0yNXE3?=
 =?utf-8?B?YkkvZ29jSDN5ekxobHY4U2xnRVF6ZXYrdW1pd2tNcndXMUxsYTFyMHFXdGdF?=
 =?utf-8?B?L1c4clByeGZNYnhNdFFWc1Z3bEVZcGp4Z3RxK2tjUnBuZGZWWCtsL1o0YTJG?=
 =?utf-8?B?YlBydTAyNVdqc0tjcFN3YW9RNFh6YnRDSkdzQ0duOGdBU2VMaDZxaE5JcFps?=
 =?utf-8?B?OGdGSjVMRTlzT29lWDNrRHZRMGNTTnZWd3dkamYyK2FZaDd2MmFsUGd6T3JD?=
 =?utf-8?B?ekU4YTdnMGIrMTU4SkhSdVk0bzJ6R3JmRlhmeUkxOE1MNGtNMWVnYkMvRnoz?=
 =?utf-8?B?Qjd2YUtvZk1nR2JVY1Z4Uy9LbUFaTW1IQTFtVkdYMUFOdFNjeDRGVnQrSHAz?=
 =?utf-8?Q?+u+/A2EBd0kuxsOsri4RPRU=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ac3a0f-49c7-428e-382f-08dc863e3903
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 15:34:58.7597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sEUOYlzeMIQXT9ONEjvKq68LYnMSzzI0Czlb+u4Cwg23mrX1qP2fV/NmoSPHhKC1Ve/ujuHIICDOpU92Odds9f+slMCFtZjWzdluUXp/+MY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7033
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

Hi Vasileios,

On 6/5/24 8:10 PM, Vasileios Amoiridis wrote:
> [You don't often get email from vassilisamir@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
> 
> Add support to save boot count variable in a file in a FAT filesystem.
> 
> Signed-off-by: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
> ---
>   doc/README.bootcount              | 12 ++++----
>   drivers/bootcount/Kconfig         | 49 +++++++++++++++++++++++--------
>   drivers/bootcount/Makefile        |  2 +-
>   drivers/bootcount/bootcount_ext.c | 18 ++++++++----
>   4 files changed, 56 insertions(+), 25 deletions(-)
> 
> diff --git a/doc/README.bootcount b/doc/README.bootcount
> index f6c5f82f98..cce66d4d70 100644
> --- a/doc/README.bootcount
> +++ b/doc/README.bootcount
> @@ -23,15 +23,17 @@ It is the responsibility of some application code (typically a Linux
>   application) to reset the variable "bootcount" to 0 when the system booted
>   successfully, thus allowing for more boot cycles.
> 
> -CONFIG_BOOTCOUNT_EXT
> +CONFIG_BOOTCOUNT_FS
>   --------------------
> 
> -This adds support for maintaining boot count in a file on an EXT filesystem.
> +This adds support for maintaining boot count in a file on a filesystem.
> +Supported filesystems are FAT and EXT.
> +
>   The file to use is defined by:
> 
> -CONFIG_SYS_BOOTCOUNT_EXT_INTERFACE
> -CONFIG_SYS_BOOTCOUNT_EXT_DEVPART
> -CONFIG_SYS_BOOTCOUNT_EXT_NAME
> +CONFIG_SYS_BOOTCOUNT_FS_INTERFACE
> +CONFIG_SYS_BOOTCOUNT_FS_DEVPART
> +CONFIG_SYS_BOOTCOUNT_FS_NAME
> 
>   The format of the file is:
> 
> diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
> index 3c56253b1e..a39a7556bb 100644
> --- a/drivers/bootcount/Kconfig
> +++ b/drivers/bootcount/Kconfig
> @@ -25,10 +25,9 @@ config BOOTCOUNT_GENERIC
>              Set to the address where the bootcount and bootcount magic
>              will be stored.
> 
> -config BOOTCOUNT_EXT
> -       bool "Boot counter on EXT filesystem"
> -       depends on FS_EXT4
> -       select EXT4_WRITE
> +config BOOTCOUNT_FS
> +       bool "Boot counter on filesystem"
> +       depends on FS_EXT4 || FS_FAT
>          help
>            Add support for maintaining boot count in a file on an EXT
>            filesystem.
> @@ -177,6 +176,30 @@ config BOOTCOUNT_BOOTLIMIT
>            counter being cleared.
>            If set to 0, do not set a boot limit in the environment.
> 
> +if BOOTCOUNT_FS
> +choice
> +       prompt "Filesystem type"
> +       default BOOTCOUNT_EXT
> +
> +config BOOTCOUNT_EXT
> +       bool "Boot counter on EXT filesystem"
> +       depends on FS_EXT4
> +       select EXT4_WRITE
> +       help
> +         Add support for maintaining boot count in a file on an EXT
> +         filesystem.
> +
> +config BOOTCOUNT_FAT
> +       bool "Boot counter on FAT filesystem"
> +       depends on FS_FAT
> +       select FAT_WRITE
> +       help
> +         Add support for maintaining boot count in a file on a FAT
> +         filesystem.
> +
> +endchoice
> +endif
> +
>   config SYS_BOOTCOUNT_SINGLEWORD
>          bool "Use single word to pack boot count and magic value"
>          depends on BOOTCOUNT_GENERIC
> @@ -184,26 +207,26 @@ config SYS_BOOTCOUNT_SINGLEWORD
>            This option enables packing boot count magic value and boot count
>            into single word (32 bits).
> 
> -config SYS_BOOTCOUNT_EXT_INTERFACE
> +config SYS_BOOTCOUNT_FS_INTERFACE
>          string "Interface on which to find boot counter EXT filesystem"
>          default "mmc"
> -       depends on BOOTCOUNT_EXT
> +       depends on BOOTCOUNT_FS
>          help
>            Set the interface to use when locating the filesystem to use for the
>            boot counter.
> 
> -config SYS_BOOTCOUNT_EXT_DEVPART
> +config SYS_BOOTCOUNT_FS_DEVPART
>          string "Partition of the boot counter EXT filesystem"
>          default "0:1"
> -       depends on BOOTCOUNT_EXT
> +       depends on BOOTCOUNT_FS
>          help
>            Set the partition to use when locating the filesystem to use for the
>            boot counter.
> 
> -config SYS_BOOTCOUNT_EXT_NAME
> +config SYS_BOOTCOUNT_FS_NAME
>          string "Path and filename of the EXT filesystem based boot counter"
>          default "/boot/failures"
> -       depends on BOOTCOUNT_EXT
> +       depends on BOOTCOUNT_FS
>          help
>            Set the filename and path of the file used to store the boot counter.
> 
> @@ -211,18 +234,18 @@ config SYS_BOOTCOUNT_ADDR
>          hex "RAM address used for reading and writing the boot counter"
>          default 0x44E3E000 if BOOTCOUNT_AM33XX || BOOTCOUNT_AM33XX_NVMEM
>          default 0xE0115FF8 if ARCH_LS1043A || ARCH_LS1021A
> -       depends on BOOTCOUNT_AM33XX || BOOTCOUNT_GENERIC || BOOTCOUNT_EXT || \
> +       depends on BOOTCOUNT_AM33XX || BOOTCOUNT_GENERIC || BOOTCOUNT_FS || \
>                     BOOTCOUNT_AM33XX_NVMEM
>          help
>            Set the address used for reading and writing the boot counter.
> 
>   config SYS_BOOTCOUNT_MAGIC
>          hex "Magic value for the boot counter"
> -       default 0xB001C041 if BOOTCOUNT_GENERIC || BOOTCOUNT_EXT || \
> +       default 0xB001C041 if BOOTCOUNT_GENERIC || BOOTCOUNT_FS || \
>                                BOOTCOUNT_AM33XX || BOOTCOUNT_ENV || \
>                                BOOTCOUNT_RAM || BOOTCOUNT_AT91 || DM_BOOTCOUNT
>          default 0xB0 if BOOTCOUNT_AM33XX_NVMEM
> -       depends on BOOTCOUNT_GENERIC || BOOTCOUNT_EXT || \
> +       depends on BOOTCOUNT_GENERIC || BOOTCOUNT_FS || \
>                     BOOTCOUNT_AM33XX || BOOTCOUNT_ENV || \
>                     BOOTCOUNT_RAM || BOOTCOUNT_AT91 || DM_BOOTCOUNT || \
>                     BOOTCOUNT_AM33XX_NVMEM
> diff --git a/drivers/bootcount/Makefile b/drivers/bootcount/Makefile
> index e7771f5b36..c0427434d7 100644
> --- a/drivers/bootcount/Makefile
> +++ b/drivers/bootcount/Makefile
> @@ -6,7 +6,7 @@ obj-$(CONFIG_BOOTCOUNT_AT91)    += bootcount_at91.o
>   obj-$(CONFIG_BOOTCOUNT_AM33XX) += bootcount_davinci.o
>   obj-$(CONFIG_BOOTCOUNT_RAM)    += bootcount_ram.o
>   obj-$(CONFIG_BOOTCOUNT_ENV)    += bootcount_env.o
> -obj-$(CONFIG_BOOTCOUNT_EXT)    += bootcount_ext.o
> +obj-$(CONFIG_BOOTCOUNT_FS)     += bootcount_ext.o
>   obj-$(CONFIG_BOOTCOUNT_AM33XX_NVMEM)   += bootcount_nvmem.o
> 
>   obj-$(CONFIG_DM_BOOTCOUNT)      += bootcount-uclass.o
> diff --git a/drivers/bootcount/bootcount_ext.c b/drivers/bootcount/bootcount_ext.c
> index 9639e638e9..660bea2db2 100644
> --- a/drivers/bootcount/bootcount_ext.c
> +++ b/drivers/bootcount/bootcount_ext.c
> @@ -19,14 +19,20 @@ typedef struct {
> 
>   static u8 upgrade_available = 1;
> 
> +#ifdef BOOTCOUNT_EXT
> +static u8 bootcount_fstype = FS_TYPE_EXT;
> +#else
> +static u8 bootcount_fstype = FS_TYPE_FAT;
> +#endif
> +

I know nothing about filesystems, but I was wondering if we couldn't 
just use FS_TYPE_ANY here? Do we really need to specify which FS_TYPE to 
use? Are there some limitations, etc.?

Cheers,
Quentin
