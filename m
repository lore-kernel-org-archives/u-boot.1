Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80ED0D16271
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 13:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6041788FD6;
	Mon, 14 Oct 2024 15:57:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="O5ezTxCW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 907528902A; Mon, 14 Oct 2024 15:57:56 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::61c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99D4488FC8
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:57:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jrv7cp8gLP729BelgHL8ieC1r7ujTNK6T1ci057dx2IkCWYe7yHULFjSubQmi4juHCRvTFt4Fi7uB+EdYqQNnk0+6uvlFLjavgO1AlU0TzyU+20GeZkCvwmZjqh8K8gfXubG6IS+XA1oB2zaloEYTYKnUTIGRpqtaOxjt2L5SKuJJ2L37OhArPe8ruRG5dOXDD1SfNEtJrHnJCMYE5Wdoo4bkea0T4b63cMVkYp9iKDTYqdgpjI/cwBK1NvDfQ48gPdwXHTS2g7Gr1rkOMS6mcZWeeK54oZS/k3kmg1cXCdKIo3TEkl+86mjfU6xVmcpmznxeYEabSyhCPMzpvLEwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q71xUA8LgoCxvmqVhXsBJiWUAuOpIfX5hkcCmuemTyU=;
 b=wmvNGgDYgIvo7NKvLiaNkGViGNv0//X+EinZFhtIsXcfCZbjXgWtj4/2ZlsSvZd6D0MOUyAV84Y+kfytA0RJNO1/96Gce1FACpzdkfVeaaYzZnHYU8LfvSWxYQXPqsBfeb2iLhzL7A4pNGdg3IXQPD3+vVVRGd+PgaZo/t/ynXhPzpXFC957t9I/z+ctNimLQzDwMksDrSNhMXhGGT3+qb1T/FPAhbNNORyUiH9KxDDLVktrBHfnbvO/a+KFW9kytOcYrVdkNtszZSA9ftulHXKyRXluctiLh+rxrik+h0FHm5LEDT/uBzs7kONiJ5+kif2fobyrttllozqhDFX0tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q71xUA8LgoCxvmqVhXsBJiWUAuOpIfX5hkcCmuemTyU=;
 b=O5ezTxCW5RZ2V5RChXiLgWnlV2FMIV0Ei0RGq524FuKuorD4nWFhjy7jZZB8LrXpFOsVd630NdMTg9DwFePiAvD+DkJs17o5iWoefHbnyF99SJ4yGNLOVWr/VIjxZIVay0In9RW/DEYc+gi6fUtUHl+anBrnD7gGEWvNjLEv3ZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA4PR04MB7952.eurprd04.prod.outlook.com (2603:10a6:102:b8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 13:57:51 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 13:57:51 +0000
Message-ID: <0163e4b4-7f81-4474-abd3-389e6edc57cb@cherry.de>
Date: Mon, 14 Oct 2024 15:57:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] board: rockchip: Add Hardkernel ODROID-M1S
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241003194101.328231-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241003194101.328231-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::9) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA4PR04MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: 8acb093a-4076-4f74-e8dc-08dcec583177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RzZxOFhCYzBWTGhPZlRmYzI1RThKdGYvaUVZVUY1Nm9md1VGdXlXbUhyZERX?=
 =?utf-8?B?WXZIMzM4WFM2Z0tta3VmQkovblhxOUpIWktWMG1iUGFrV1NyekY3Tit1ekFr?=
 =?utf-8?B?RHI0TE1wcnpwYnQzNHN4ZENNRjE3ZFBrMXZDZFVnd1dKMVUzeWdvNlo4c0hH?=
 =?utf-8?B?YWdjVEFDWjY4NExxQ1duRlVXN3VvZFc1ODdHSHpIY0htbnBRR3Q0Z0lKN2JF?=
 =?utf-8?B?TXFxeEpSOHB2OG9wOWxEeUFyQk5VbENjRXg1UWd3MnZhMUlMNjlJaFAzSERa?=
 =?utf-8?B?WHlHNlZEMzlnYjcvOUhCcnRuT2hJd3lJbFRxM0lmSWs2MzhBNTQ4WUROUVA1?=
 =?utf-8?B?bURBcVI4Zk1FOTBMbEVrTWFxTVZHZjNEVjJ4akFWY01aSXJWbmdmZnFZUXdQ?=
 =?utf-8?B?c0ZrS0RKRjNVUGF4Z21Yd2Fwb0FDSlFuekkrenpMTkhKcWNJYkIyTEFPV0Rr?=
 =?utf-8?B?MjlNcTNNSFlaVTEvVk9RZEoyVXRMVUhpU0xzbTd0WlRNeGlRaGxDZFFqNFY0?=
 =?utf-8?B?UUNPQWtzU2hKd0F1V0hibkViOUVWNDJYcUM5NmtCY1V6MzRFdjFCbUVDOEwv?=
 =?utf-8?B?VHZzdzZ4T1hDRTNGU1hFYnBwNjN0bFVhdE9zbW1SU09CTVBrdmhza0VGVmtl?=
 =?utf-8?B?MkhqWlFwRXB2V3IrQmw1UFBxMzZnV1BSWkNsM0ZpSVZUU3kweXNpVElIaHkx?=
 =?utf-8?B?YXZXYzU1Y1djbmgyZkQ0cEVmbkRwOWo2K0F6SW1pNXQ0VDQrMmVNZDhTYXhq?=
 =?utf-8?B?Z280SjZDcm1TNkFQOFU5ZXJiZEkxdnlGMlUrZjRlWDBGaGg2V0srOWlSczcv?=
 =?utf-8?B?aXJNeXZMVmR2bjg2Q01DRnFXa2YrZFZYOFltczcydzZ5YzRHZmtwSEliSE0x?=
 =?utf-8?B?TVBPczk0OGFxUXlsTm9GTHB1MjFWM1QwRXhldVdCUktqVng0VUlZanhSYTVW?=
 =?utf-8?B?cU9BU0J2R2M0Um1UaFlsZ0FVMUM2ZjZzQmNwcVVGRWx1RkIrZWtITHppdGFL?=
 =?utf-8?B?ZHNGZGpaQ2ZUOTB4NHN1andRSkJoRmVsOEhZOFlDd1g5MHE2YVNCcmV5U1FV?=
 =?utf-8?B?QlRZRkFYUVpMUUJrQnhHTEdwN1YxRXAzZnRua2p4NUFSNlhlczZCbGY5T05s?=
 =?utf-8?B?c1RGelBPVTZoMitETFQzV2o4NEwzVHd1c3RQd2VuV3RMay9uaXZEb3BZd0V2?=
 =?utf-8?B?cUk2YzU2cVVBa01hTndoZDZYTHhscXM5WXBjYWJ6SHFYVE9ZUStYUy8zblFr?=
 =?utf-8?B?UlViZVJmMG8xcVJ2TVBDNjBFVk41TGR2b2UvanJBRE1oSGZDemxpekoyc0Np?=
 =?utf-8?B?MmlmbldLTFdVRzRDUjJPMU9CTHZyWGIySC9CUllWdGM1a0oxZWU2UE5wRE45?=
 =?utf-8?B?V2Z6T3ZVOVIzeHVPUmZzN25jRDZaaTIvOHBwbjFiczkvZ09jYmlpZS9uU3VT?=
 =?utf-8?B?elhPUlEzTW8yV1V5M1dxT2JML2ZrSFRGdHB6L1Y3VzRxUUlkMTdhbTM4NFht?=
 =?utf-8?B?dTJVdlQzL2FWblo0TnJXYnh6T2EzZURVOUVLY2xONXAyeFpMZkZhM1oyczBW?=
 =?utf-8?B?SnhyQUhXdnNhUXpCVXlLWWFIMno4bE42ZUM0WXpkeXc0SlI0OEphUWJIYmFs?=
 =?utf-8?B?bkxoTVA1Z2Q5SkpQVitUaGR5bGZIek1zOFJqN0xVUTkvcDFDQVpXbGozbGJS?=
 =?utf-8?B?MGIxekU4cFVsdlRCNlhTRHE0WXo3Rytud0NqbnZZZVgyRDU5RjBqOHR3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVNtNFVXSW9JOTNuMGREc2dISkRONXFyR2ZPaHFGUnowOGdocEZjM1lTazlT?=
 =?utf-8?B?SEVPR0V0ZHZmTnRIV0pGcjNMejRxM3lnTnEwREtVQzZ4Q2FuVXAyM3dkK0Zt?=
 =?utf-8?B?SmI2aXlUQXc5L3NjQnFOTWloYkVQbXlRMkRLK3E2eGxiclZqTXlOdDVQQmM1?=
 =?utf-8?B?WFVtQldOSDZOZ3FLRndPb3FYQ1E2Um1tQ1RES2M1bDY0Sk1FNmNEdm00MDYx?=
 =?utf-8?B?NWQ2dlNVSjZONFgzRW5zVkNqQUpsa2QvS3VKWmZWVlFad0lJU09mOGYvTlBj?=
 =?utf-8?B?MHlCVTNzSUZzK0s2Zk9lK3dMTTZXeVZlNE8ra2QzSGRTVEN3MFhtM0JpSHg5?=
 =?utf-8?B?N2t5OEgrZzRldXNnVjc3SUlhdGh6Z2JUZG9pYlRtSGxwN2dycGRiaitzRWVS?=
 =?utf-8?B?ZC8wMTNjbE9GV1hKb2hXRzFSdFpiWStTUU1YTG1WV1B3dVpTSkFuL0ZNNVh3?=
 =?utf-8?B?eDVlVEdzVDdCbDdmMDRYSDVPNGpMRkVoRG9xTEZidXREelg0LzNZMGlnTXlz?=
 =?utf-8?B?ZmpDODVnR3ptSDRnK2M4ejZqZ05XQ29LeDNkV3JIbzNua3c0WVhDSDI2NDB0?=
 =?utf-8?B?SlRZUWRHRm5DK3pQRHk3azRsSVlnMkJkSTBSMzVGTjdiS1FkdXNULzJUY2t4?=
 =?utf-8?B?eWUrQzYzcGlpQVREdFZhNDRoR09udnBoZm9RZUxISU1OSU1LVmtIUGJucU9m?=
 =?utf-8?B?M0xUZ2ErRjZjZVRZSDFVYzR6bkx6blpmL0ZTOTdSSGQyU2JVL2tNNGQ2d0ZH?=
 =?utf-8?B?azRVYVhKWlBoQXpCQXBxMWNWVFdldm1zTGxnQzd5RzFtbDEwUzEyZU83ZEh1?=
 =?utf-8?B?cnR0aW5pcWlWaDRuU2FvV0NqdDhoRjI2Z2V6NFNOeDNEaTRpNkwxNDZyOGJS?=
 =?utf-8?B?azcyVWx2a2ZRQVpoNmFSNFF5RjArKzMxdVpQNi91K0V1aDFMK2hOOWJPUGlm?=
 =?utf-8?B?TjBCblg4M1ErSEEwOGdBeEFmTUliSUd1empoYzhLcDNkTjdiNDhiNmozaTJj?=
 =?utf-8?B?aWQ5WWNycmFtQXJ2dFdYNWpHSnFPTVdSV2ZYSW5pak9LTTh5V0c3OFZBemZl?=
 =?utf-8?B?eDZ0VEdOK2pRSUZZdVAzdDZDM1BHd3hzTFA1MHRKdnVvUHZVakdyRS9HTVQ0?=
 =?utf-8?B?eExVbFJUSGtBR1Z1c0N1MGlLc0ZwNVUvTjh1RzY3TDVHQ3RQQmFkSDFUcUpj?=
 =?utf-8?B?VldSdHlpRWtYNm8vU3plREcxYlJ6cUQzU016K0RYbi9EVkFselJERzV0Ykxx?=
 =?utf-8?B?QlRhS3JBZFNWVm5OTmpLTTRsenVIcDlvTDdOMWhPRDlWWWRLTTliZjhqNDA5?=
 =?utf-8?B?NVVSUm5hclQ3ZmRZZitzWWlnV0NSSGZQeTBHb1U1M3JLa2kyZ2NxYkdKSGNR?=
 =?utf-8?B?eFF2UlNuWURJTk5VbzdObS8rSXFkTm1SUFh4TFV1SVc3VFVwQ1pYL3ZhcVMz?=
 =?utf-8?B?NEZnbUpwenJxTEV0Ylo0ZVdNRXRET25nTTgzbTZ6UG8xTXlYRTV6UUNmVTc5?=
 =?utf-8?B?N09mNld5ZzZQMkg3Z0hxR0NLa1k0N25PeFFOR2RzMkVNVjk4OE9WTjhYMG1y?=
 =?utf-8?B?clFBU0hkcmpDS0JuU1RGUkxEcEppZXBKVXMrK2U1MjRYSlNQVWFCcTd0cVRw?=
 =?utf-8?B?dXVBT3NYVlV5cEN1dVZWQVBSN1NjZDNZTEFlWnhMSXFQcHlRUGFFS1ZHa1F4?=
 =?utf-8?B?eElpUGxtamlxTjJTNi93NE81eXVFVlRYRDg2OUhRSDJvc2tuNzd6U0RGcWFT?=
 =?utf-8?B?U2FtRzBmVWVjS3VtclFZTFFOOGFldjJvVTFKV1hycXd6eGZqU0Nxdk5xR3Rk?=
 =?utf-8?B?YklFN3owY2FqL3RVdUtVWllzbnZBRGxpQ1M4THJnMGd5dHhpMTdNd24rQnFk?=
 =?utf-8?B?YW8zOGpwaFJzTk9uMHBJUGVsRjRxaFFmM2tMdVduQlc3S2xqNkFINkZHS0RW?=
 =?utf-8?B?eS8vaE1ZekNabTRqTkdRT0Q1QUp6bS9tMUJSODhUekNvcjIzTDZkQzBRb3Nh?=
 =?utf-8?B?NDZmVWJXeXZRZDRLVXhhWUhrcEFYY3VNMUM4U3UvT0l1R1JZVVN2eUVsdnFY?=
 =?utf-8?B?R3d3VURmcS85UjJWRUhUSkdsRVR4SlJERVJCSWpaenlCUFU0Z2d3YXAvYWlL?=
 =?utf-8?B?bFJuUkhBWm5sa3loUkZmMkRvUm5id04wZVZTQnM1T28xMkt5MzFZdSs2dHZr?=
 =?utf-8?B?eUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8acb093a-4076-4f74-e8dc-08dcec583177
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 13:57:51.2405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MN53JBpgUoTJs7YI2RGKcqKfV1i1oi6HhZzLvm2n2QTncCWpVE3BHtdyd589zBdwuOGCzwDcwiifWFudrNHmWjx8NkC7PCrsHDKZIUC3U8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7952
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

Hi Jonas,

On 10/3/24 9:40 PM, Jonas Karlman wrote:
> This series add support for the RK3566 based Hardkernel ODROID-M1S and
> also correct the board compatible used for Hardkernel ODROID-M1.
> 
> Features tested on a ODROID-M1S 8GB rev1.0 20230906:
> - SD-card boot
> - eMMC boot
> - Ethernet
> - PCIe/NVMe
> - USB gadget
> - USB host
> 
> Jonas Karlman (3):
>    arm64: dts: rockchip: Correct vendor prefix for Hardkernel ODROID-M1
>    arm64: dts: rockchip: Add Hardkernel ODROID-M1S
>    board: rockchip: Add Hardkernel ODROID-M1S
> 

Looks good to me,

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
