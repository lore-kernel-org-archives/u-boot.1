Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C205AC02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 10:01:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44A8A80283;
	Thu, 16 Jan 2025 11:01:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="WXVIoS4v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95F30806DD; Thu, 16 Jan 2025 11:01:07 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21486801B0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 11:01:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOsI0L/fxYpQsCCjFxEtKxlG/8hqeYHO7VR2/eZt++OYbJcFDSISU4vRRWBvLTjzogpaEFUd2H1Ijz0Xq842yiEsbfQ8T5QcB5DafZ7gbM8tMhsfQ7FImQz3CeEYH/gNbDNrucjNz7xFab0fMT1fi4TM40Wkb7pVD1SBuRDIdo8e5FDoimqFcEMxBMiqbll1iYj25hFrBsy2x7YKbMYNvfCare8rk5fNWHfhFbXK4vel1jedy0vYjZ3O27XJ1pcGMWdWizDeEqb/BlZHQa3UOR3vovf4TL0GpC3qApIX2zipEwPkyQH4VeXw3GDbbTE+5zqlCzUqreQX/wouJvn0Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnZ7f+hJvAz32/LrFFQo+LemvBh53H34DIR9zREIBDg=;
 b=HD7WVb+uVAVnBPBSKxClmgQrfk9XBukWjQhVnaIRiWDiB58FiFfZ2rYPcpd0vp3+9ub8QRCgBdd4xBuLCZKMWRq79EihQZolguESqCDlN9RLlyVG4LayKXfpr1t6f/+q3BOJKeGeG+kjFRbLukpTYExt/A7EkVg1syEQw9K5dJVVNrSs4N+jpdKkJWxWAsWoUa2FHJk8OBy9YfJdlU1XHhc24d9q2tsFKjMY8Guy+h5OBrzU+phdaUFtYcrN8jZ/sxEIvi9WzuR0FgZLMV54aZc4hQFf9omUgqynJYSvdCTxsj5cdYvQoELgjrQfMlUnlFTId9zmY1FU1K+zrwW8Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnZ7f+hJvAz32/LrFFQo+LemvBh53H34DIR9zREIBDg=;
 b=WXVIoS4vE0fh3CcxQfAUXdEKaWo1vSE5Kad6lZgoNIzuiSHI6ismGnVJlMiu2Z6VXQbzwZxawz1F/qMqIZnUO/NJXN8eBZ2Gmqi7gC4uBkS95vizZ4RTQzlaJGkys0nLxXEvx8Azimc0rdHO8Gc6ehkaWOsbB1XAwHgNWHLX5c0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB8PR04MB7177.eurprd04.prod.outlook.com (2603:10a6:10:127::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 10:01:03 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Thu, 16 Jan 2025
 10:01:03 +0000
Message-ID: <ae46a9f9-ce4a-436e-84dd-2ae50497981d@cherry.de>
Date: Thu, 16 Jan 2025 11:01:02 +0100
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkje+8miBbUEFUQ0hdIGxpbmtlcl9saXN0czogVXBkYXRl?=
 =?UTF-8?Q?_the_alignment_using_CONFIG=5FLINKER=5FLIST=5FALIGN?=
To: =?UTF-8?B?6buE5Yip5Lqa?= <1425075683@qq.com>, u-boot <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <tencent_9739C1044069984893BE3E6D3DB783BB6C08@qq.com>
 <3d51107a-4761-4de8-9bae-a462c2a8e890@cherry.de>
 <tencent_B912404198CB93E73E013D2783596C4DC108@qq.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <tencent_B912404198CB93E73E013D2783596C4DC108@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::13) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB8PR04MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ddeb93a-95b3-4458-b187-08dd3614afa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3NmR2VPN0tpZ2IxZVV0dFd4YWlpaUhHQkd1RnB6TFRIN0NnZ0NSeGJxRkx0?=
 =?utf-8?B?UGw4cHpsTHhEaTBJWHEwOFZTemo3MHRDNE5VWU1yQlcra1Y3bkExcnBqR09n?=
 =?utf-8?B?elFDVk1MUlorT1hXVEt6bFNCbUlGQWk1aWlCcFlYUEZOV29EZTVLcWNwUWZn?=
 =?utf-8?B?TUp0cmpOU1FMSUdza2RtVFpvL0tReXlUd3czQnZjQmFoMVpTRTA2ODQwQlVy?=
 =?utf-8?B?eGRCY25ZV24rRjRZMFVxMi9ZTmRVUDVCVGFuRjZteTZEWkdXTUI4Vk40a0Qv?=
 =?utf-8?B?R2FjWGJWaEplVEdKTS8wY255ZHpFcTJVcnFmK0VSd3ZuMFkyZzdEOGZ4SHNW?=
 =?utf-8?B?endFT2VXa1Z0MVdtamwzWTlESlNqcHhQQjhJeG8vSFdDTXRwbWVJT2RTTExH?=
 =?utf-8?B?US8yOU56N0o5VXV1aGEveS81Vi8vRTV4R0hYbFZvb3BmSExzc3Q1N2VhTDBy?=
 =?utf-8?B?Mk1uSFUxazUzQ1dPTVlheWhDWkx4YmtKQ3lCMWRVdElBSW90SVhxdStjODFp?=
 =?utf-8?B?MTB1RHJPVzB3Zzh3aDNuU1Rqa2dYRENrZTgrdEtKZVdzMkticE43bHhuQWxR?=
 =?utf-8?B?MndFU0NhUHIxaTVIUEEyZUZlNS9yZjNrU25YcktOelNTVUlYVDZObE42bEty?=
 =?utf-8?B?bHA4ckh4MG9pbXB5MXNjc1NXNU9tcDU4NUYyVnpPVEVKelVhMVBDRGZ4ajBH?=
 =?utf-8?B?b29wTVFKZjRjQjA0ZDgvZmFGbG9BSDFUK1NKakFURkJZWTVERzZLNUJhSTZX?=
 =?utf-8?B?eWdLeUFIUzdVY21waWdRWXlLVGxaMnBFZjgyellTVy9vb3lJaUtNNkNIRTRZ?=
 =?utf-8?B?WFFLVG1GWWExNFY4Wk51K2JmdlMvakd2QVIyZEcrWW9uMHdHdmliQWpZTXNY?=
 =?utf-8?B?WUpzVjhVcTJ3aXIwS0tpQXVTMTNrUjA0T0JtbFZzMWtWT2pIQzMrbUlMTUha?=
 =?utf-8?B?MHJ1UGY2bkFqK1pVMFNKb2Z4OU41VTBldUxvNGhyY0sxZ0Q0WmNJb1BjREs4?=
 =?utf-8?B?S3NIcS94dVE3NHBaYklwdzZzTWRrSFRmWmQ4a2hHcjJXWTBydXpxTjVxeVpD?=
 =?utf-8?B?eHJsUTlFbmZ5MmtlK2gwYTFnOHJZdnBPN3MxYzZzZ2FTS3ZjazFUMXUzTE0z?=
 =?utf-8?B?Z3pGd3pwMVJ3NE1vSkxEZjArRTVJZVB6L3hHWktGVjNSRWdxd3JFKzdqdjJJ?=
 =?utf-8?B?bGJvOVVHM0oxcHlHcmRyVisxTS9oczNQdjVqMlNFZW4vOTJrUy90dU9wRmVn?=
 =?utf-8?B?TGh3QjB2eXU4K0FvRU5HVHhkWUZJUkF5RDg4NTFGN1ZSQVYzdCtSMEZGZ0xR?=
 =?utf-8?B?dTJqMVJWOU1WWDRxTGZoUHk0cG9nMGN0SEFMTVRmNGRFaE5wcEx0NmppZ2RT?=
 =?utf-8?B?djFSY3BPVXZxaDcrak1yemJabmJKZ2RnRDVZVHZHNjg5SHN5Tmg3N2VTN2h2?=
 =?utf-8?B?dDBXVFVFcE1lQTFKZXdTWHpIL2FXUGFBYTVHblYrYWhxUjdiMUtOYzR5K2NH?=
 =?utf-8?B?TmkwVldkd1ZRUkIzU1dsWlZzY3JKRnlTUEVJZmVHcWdCZTJHUnpHSk1NYWwz?=
 =?utf-8?B?VDF5ZzBhTzR3RVl0Sitlb1NPM0p2c3N6ZEVmUTRPZ2lLM3U0aXRoeWN5bXk1?=
 =?utf-8?B?NWNrMHBFNXQ0YnhDTUV1N3lxUVc5NUdab0JrbWRyem9PMUxzRW54SFYrM3ZL?=
 =?utf-8?B?QTNHeGhUd25DN1dvNjluRTZoV3JuS01NUS9aV0FvejBCQ1AvSDBhK01RYkNH?=
 =?utf-8?Q?KGA2saC//zQ04b3s9FhMyKAzxlBxDoGcB6haxAD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b015UmtlNDBXanMwQWtEbEs5MjdURkZyOUhhMkxkVndBVGRBNlNmVUxNR05W?=
 =?utf-8?B?RGY4YkRQVnlWbEVVNVZVM2NYUndYWWZGc1YrTUFKY3NmZWRwWEQwSnhxMzVW?=
 =?utf-8?B?WFRlOHR6c00vVTAxeTFrSzlHc2w0akhETm5WbVFOMm9Rc1VvVEJxNEVNMGFo?=
 =?utf-8?B?YzRBVWtTQm1VcG0wTjQxSkVUWTBDUFhuanZoVHpVRklSdHV3NGprd1pVUUlY?=
 =?utf-8?B?eit5ekcyRkd5ZmI3dkdtb3V6NmZTT0dHKzRWMWNQVzlKMEh3QVdFc25LdnJj?=
 =?utf-8?B?d1M4N08zT0pDS09OQ3FuUDZocEI3L0laMnNsbDI0bEd6N3VHZFlrMzE2MXha?=
 =?utf-8?B?dStVQWlQbzRDU1NLWlFZb21PbGY1UjV3djIvcDNWU3JRcGhzK3daVDJjSURQ?=
 =?utf-8?B?Z1RBUk54U2VnVGJNQ3IzeDdkSWhFRFNDU0lFL1d3VHJWVXdWVzRIUElOQTJQ?=
 =?utf-8?B?WE5QWmFZZXhCS0ZxVVBtdjhWSGl0dW5LT3lrM2x1TDlaeE94bFBBQ3NUQytI?=
 =?utf-8?B?d2R4Ulp0TUw0bjVoMW5LVUlXL0haSzZYWTA5emxyMU9JaXVlTnRxWHlIV0JU?=
 =?utf-8?B?eXRxTWlESDNkNUwxMHEwZFlNaGVvQmUxZ090VGtnL3dEemkwNVpUc1cxTk9R?=
 =?utf-8?B?ek82OGErbGhwZHQzVUNVSGdQdmRUVFZIOElEVk1NaVlzVC9yWTR6MTFkRHJO?=
 =?utf-8?B?RU81YzVlVXJKYzZ0RW4rcHFndExoWWtCcDhsMmR6SXAwd3FwSDhReEQ5eDhw?=
 =?utf-8?B?a0FEc2sxRU54ZTZWd1k3TkRwRkgyUHJTWEMvaHJKS3BJUWUzQUVyUHgvejJ5?=
 =?utf-8?B?bFA1TlBvVTE1Zkw0NjdvUnVhL0tkdkFFMEJLZnQ4YXNtWXhuVnAyeXBVeVhP?=
 =?utf-8?B?L3oxNWUrZFNVYmpFYTFCMHEzQjBrcVY2U2NWcFBTcWR3eU13ZUE0b3FnMXpK?=
 =?utf-8?B?YjVWTklyMmo5T2orQXI3NUI0SDdBWDhxaUFZazBtUWZ6NVc0L0hvUThZSHJw?=
 =?utf-8?B?TUFyUDhIRXlKNkg1czRpRnZuUXMwUHhRdWFXY0M0RDBCSmxiVTByREFWQ3Uy?=
 =?utf-8?B?d1R4M3htMXBhRkR3OEFtUmJQN0pCTEZRaG8xbFo3eXF1dDEvZC9rOXFtLzRZ?=
 =?utf-8?B?SjM2VHBEQVVsM2hEOFlxVTNSYmVuaGcvS3l6WTdWZnR2TDFRZnZYNUF5WnFT?=
 =?utf-8?B?TEtFczd2SEJRV2xoeHB3QlR1cU1qb0NxblNydDlxNW9iRnRXUGVNZzhKZU9E?=
 =?utf-8?B?THRNOXp2RWtuaGNjdnFtMXZpbnM3Tk0zRXNrTzJVQXZZZUFOQklZMjlqeEor?=
 =?utf-8?B?QWdBbUwvZ0tId0V3NWVwTmlJUmdUeDIyL0F5aC9hNzM0Wm9xM3pibS9EdDZX?=
 =?utf-8?B?V3lXaHZWVW11TXVHcUw3YndaVVZoVnR6U2JrOFBmRGlvbjg0dk5Hemp5d3l4?=
 =?utf-8?B?YWxvU2syLy8rMWJsdTZMOUM1QTdkSmlTNmtyZEhmK1hHRkFjdzltQkRGTEdx?=
 =?utf-8?B?TTZvcmVIMitDSTE4NVBnT3BldjdKVEVuQVIxUnREdjVrK2VzREQ5azV1Q0hl?=
 =?utf-8?B?Ym1yLzRJN2IwaWNaV3VIN0hSdC9zWXdMTWVGWFdZRldKN2kxOTRVWXI3QTd0?=
 =?utf-8?B?VWtvVWlzWVNsZXF3SnpOUkxtaTVEbGMyMjN0OG1leUs4L3U2dERlREdBN05t?=
 =?utf-8?B?N3duYXRUaHhSL2NYWVZjU2FQbkZaaFY2TUQ3UkJsV2FPTVBqT0l6bWlNNVlN?=
 =?utf-8?B?aitLdVRnRlJtbGUxWHV1YnJ4OTQ4MDFBVnpYZDJJSVVSM3JqbDZpRTN1WURU?=
 =?utf-8?B?UVlWdC95Q0dmNERxdkJIZEpiYWV2TXBvdjlrYm4vS1MyVER6RzhNdnA1aVNM?=
 =?utf-8?B?Tm9qd1ZnWWFncHRucnlCSkV5ZHI0SjZQTzNZaklsRHpLa2drMXlCY1JYMGQx?=
 =?utf-8?B?eGtWTE5WNUlqZ3gycFlScHpkcWZvdlp0eGs3TXQ4VnplQVZFMzlyVGpGT3FX?=
 =?utf-8?B?ZUQyUVhxTTQ5ME02QVg1N01HbjZtSVIrMHJYdmhZMnc3LzBzTWNBdDI2Ylgw?=
 =?utf-8?B?c2ZVSFdra3ltWTEvNHZTSEJYUXhZZnY4WVZEU1dtaHF1OWtJUXppbUEyNDNX?=
 =?utf-8?B?V2h1VVV3a1lkTTdZMkxPb3lwT0EyY3d1YWdIWFgrYVJ1Q2J3Z3VtN1BEUEs0?=
 =?utf-8?B?U1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ddeb93a-95b3-4458-b187-08dd3614afa0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 10:01:03.1752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UA9JhgBWB+P2Morytklf7FAb9y++OC/PYDawpbz81z7lB7mv8OokLqip5YMNdqSHZWsvB2JK/Eabn95N2MLevFqg6hzGF6Z9IqIawET0QUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7177
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

Hi,

On 1/16/25 1:24 AM, 黄利亚 wrote:
> Sorry for the confusion and disruption.&nbsp;
> I haven't submitted patches this way before,&nbsp;
> and my English is not very good.&nbsp;
> I was conducted according to the steps&nbsp;
> in the https://docs.u-boot.org/en/latest/develop/patman.html operation.
> 

The patch is fine, it is properly formatted and sent correctly so that 
is okay.

In the documentation[1], you can read:

"""
Tested-by / Reviewed-by / Acked-by

     These indicate that someone has tested/reviewed/acked your patch. 
When you get this reply on the mailing list, you can add this tag to the 
relevant commit and the script will include it when you send out the 
next version. If ‘Tested-by:’ is set to yourself, it will be removed. No 
one will believe you.
"""

Specifically: "when you get this reply on the mailing list". Since you 
didn't send the patch on the mailing list before (as this is the first 
version), you didn't get a reply on the mailing list yet so you cannot 
add "Reviewed-by: " from Simon (yet). If Simon gives his Reviewed-by 
publicly on the mailing list and if someone else requests a change, you 
will need to send a second version (v2) of your patch, then you need to 
add "Reviewed-by:" from Simon.

Did you add the Reviewed-by from Simon manually in the commit log? Did 
patman add it automatically? It would be nice for us to know if it's a 
bug in the tooling we use so we can fix it.

If you added the tag manually, what was your intent? Did you want to 
specifically request Simon to review your patch? If this is what you 
wanted, you can use "Cc: " instead.

For what it's worth, I personally use `b4` now (but I have never used 
patman before so I don't know how what would be best for your workflow). 
You can have a look there: 
https://b4.docs.kernel.org/en/latest/contributor/overview.html#what-s-the-b4-contributor-workflow.

[1] https://docs.u-boot.org/en/latest/develop/patman.html#how-to-add-tags

> 
> Can you tell me what else I need to do?&nbsp;
> What I know so far is :
> 1. I should use another email address;&nbsp;

The email address is okay, but you are not allowed to put
Reviewed-by: <person>
in the commit log if <person> didn't actually **publicly** told you in a 
mail on the mailing list. For example,

https://lore.kernel.org/u-boot/20241220222612.1757884-1-trini@konsulko.com/T/#me93a6e7f1307c05e355fa8405eaa18713026a544 
is the first version (v1) of a patch.
See there's no Reviewed-by tag in the commit log.

Then, Heinrich answers with
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
c.f. 
https://lore.kernel.org/u-boot/20241220222612.1757884-1-trini@konsulko.com/T/#m76d346553039e8c6e1bdadc3c635ad4dcedf67f1

Then you can see in the second version of the patch, here
https://lore.kernel.org/u-boot/20241220222612.1757884-1-trini@konsulko.com/T/#m496f7d8af192cd92da1f0fe0783de39e65f99d8f
that the Reviewed-by tag from Heinrich is added in the commit log.

This is okay, because Heinrich publicly said they reviewed Tom's patch 
by sending a mail with "Reviewed-by: Heinrich Schuchardt 
<xypron.glpk@gmx.de>" in it.

> 2. Seems like i shouldn't send patches directly to this list?
> &nbsp;And it's only submitted to the reviewer for review and then submitted by the reviewer?
> 

You did almost everything correctly! The only change you need to do is 
remove the "Reviewed-by:" lines from the commit log in your first 
version. The rest is perfectly ok with the normal process!

Let me know if you want me to rephrase or clarify something.

Cheers,
Quentin
