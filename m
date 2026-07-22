Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5567CC44539
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 13:53:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C063780F2F;
	Wed, 22 Jul 2026 13:53:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oQbchpu5aDAx; Wed, 22 Jul 2026 13:53:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0315D80F24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784728425;
	bh=QH6kWALxc2DkoIoMTRKrOJzQfiXORxd8BhxAV1AtTl8=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=MJBB1JJGwOUoZGbuhZXIUuLqm+/FIgrdCqDI6tOoqpiVNKIrDDPg/jlx/Ur1ERph3
	 L0vf3+lJOxzPeyXlt//tRrYA4IPfkUvDuGfg2GKtymF1laniPgyiC/eAYmQqB/w/2J
	 v+0WhsQxaiXMMZto7ybc+DXUWpnPb75TJLZieL/2EG/8u7SHVvT6EpEgjROczasQnH
	 61RSAnU788uYKgdZIuDsNA5JPH64jfMo7L80sr9db32SS0rQ8e6xwjr96wlI3DFLcP
	 WE0qPZYfSjKnL+o6bBB5ia2OIlsi9xnu4K/1pBSIp1LA9+Thnd82ovZnacJWqB0y99
	 Z6IETsHPt3OdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0315D80F24;
	Wed, 22 Jul 2026 13:53:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C93A2E5
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 13:53:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0E32580F24
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 13:53:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8jvyARrgxPlM for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 13:53:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2021380F0B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2021380F0B
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2021380F0B
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 13:53:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=duk6NVnj1b657Tm8UhJwC3P6veiLiRiFFFUc8YHFrS5g46x8F9k2jRX15Dj8424/fD/Bi5vi88j+Ptn3OdF6uZtCQWWWACdr4Y8/mLtbzGiXivgs8NLajyMQo6/JaSzCWb5dUlJi1u0p8pux5djO2dJA4wdVGNHm7Bj2jFp5V6eIxyMfG9/ytB2rePmo1jVDf7O1cKunBosVz3ajZM6Now/jU0nFahLK11auRoC0i5FXjmEpuq52FjGzbiHFPW7jfRNG9ss7dXQcg7yGy4G6sXHlGnqjMj9GFpmKEU1zQ3HYICtMafvrJMRJLXz0mkp0mblx548CACe/Az67yM0GyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QH6kWALxc2DkoIoMTRKrOJzQfiXORxd8BhxAV1AtTl8=;
 b=sWZ7UZ6Fj6FvPMVLu4T6C+8v+r/7VzhLXix7X/umOtD8Lb6HKXYktJftSgFvLqLn5yYb4NcVueX6PXnH9Ch+UWYzbgAD7VrrCO5kqIvCJysnMlDaTovRlvZIBUWACL742xZiIbqSbOvOhtv423KBB7nnP7zofQmk2t2A9niBRpEDiCyE+Sm1r1pcIW2uamVf1uAx/z0EZ9rG7AmQ1Q8rUX5L9NlJYoiZ0QHQ/Op66plKYpfSK09BScutH2jV4DaUcaBvIOdKT978uX8wiP1cjPyetN1QdNLzThC9fxqI77RjaM/LyKjCiwhT8v9LRz9jRJXH2SR4zOKTiLtzTNjzBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by VI0PR04MB12638.eurprd04.prod.outlook.com (2603:10a6:800:342::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 13:53:38 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0223.017; Wed, 22 Jul 2026
 13:53:37 +0000
Message-ID: <1c18e3ff-a1af-4ea3-8850-ce41d52a1109@cherry.de>
Date: Wed, 22 Jul 2026 15:53:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] rockchip: rk3399: Remove ROC-PC regulator overrides
To: Fabio Estevam <festevam@gmail.com>
Cc: djw@t-chip.com.cn, sjg@chromium.org, kever.yang@rock-chips.com,
 u-boot@lists.u-boot-project.org, trini@konsulko.com,
 Fabio Estevam <festevam@nabladev.com>
References: <20260722013642.1011666-1-festevam@gmail.com>
 <20260722013642.1011666-2-festevam@gmail.com>
Content-Language: en-US
In-Reply-To: <20260722013642.1011666-2-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P190CA0014.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::24) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|VI0PR04MB12638:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f34bce-a1c4-4a85-56b1-08dee7f8a132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|3023799007|10067099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: BP8noPgNJ+Po8pfb16SSYa4WSPEu4Ha1ooE2vIqdH7err0JicT/HCeNZ7Qz7IBKK1YOqH3V78TNhat3F5sE8YE7lr1twkM7BQinWPQREm4BTyM4CW5i5AqfBfJA6Y6jBgSyvms8xn4ayDRyFtj0zGYObuRQkUJ0Os4zXWA2/hrjdJKwM0BBkoSJjPI+/gkn3nOtNGAjXj8ctbVkYme940KxUZCyoQAPZaW35B7fGpN8UE4GTvda/28tCzZcp/fSoerwCU2skHAVOGMEUFl0OEzwHz4dltML8wS4WkqXojgPiJFRXIBavj7SPdrmfpX84twJfNW8YijTodC4dXIX63aEYClFuHYO7XXxJLqrWOEmdxZFRJNAMd2yBJeVbFX12HX9wr65jWNyXYAQhY7c+7TXpNh4Xz8iTsa50tQho/ocYtFG8QaDCIcfF0+igg/Ypoo1j0Mnz6QYIQEGB/5GFo0FjSjbEFPuKQO+IyWaINPB7HkmVg/6rFisktVK1sP+TDj/cOaZ4yJ9SvbiT0fUmoqQIuZFZDr/M/2Rvet6uzWAgsWpG+V9jf/eV3hGkpLOGcXHc8cuipQgVsDtlitHInFwQ8lzJY2+thCU/Lz+MvlNY/yfZapUHd6bQ5QydEqCnWvWcXheNI+zpZowdyGvSfWpBQ2yYuBsluwatRtJemHg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(3023799007)(10067099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekZxdy9Nam1Td2hQNkluUjdFdmprZzdjZjArUlM0V3dkQTlrbytPTEE2R0Qv?=
 =?utf-8?B?VHcxZHF3SVRhZjRISi9aNnN3QWM5M2UvVkh6d0ZNNDluS3dWRTBTWWVGb3hC?=
 =?utf-8?B?SlI2UW95ZlhhK1UrNjhuYTBXRjNGd2JGcHRlQzRHWUhuTVg5OWMydHVqdVZz?=
 =?utf-8?B?bzlBK0JPQUxNVnhUQjBnT1FSS1VIeHhlUThzejMyT2VsV3B3WlNLWGhDZVQw?=
 =?utf-8?B?QUErNStMNnQ3WkZNL1NxWHpjaEV4SGs0THk5RVlBVGZSUkZQQUxYUWh3azdt?=
 =?utf-8?B?bE5vSmtHNk5lZnUrMnZ6cmpleVRtZkw2aTZKZjZLaFdqWHh2WGdXUDlsMHNB?=
 =?utf-8?B?YzhySEcwdGZvRm9LS3hIY3JmamhoazR4aHdJZFE2U2M1UWdwVmsxTWlrZWF1?=
 =?utf-8?B?SXl5S0hOUGcwbUxhMmFYbG9LMVZUSHVIZnZTcnc1eUdMZ2JlQ2NpNjNlUWE0?=
 =?utf-8?B?MHBMK0ZlT1Ira1lVZkpFU0QyZ3FMRjE0ZkNDaVVYRTFwLzdKbnE0Vk5EQ1pl?=
 =?utf-8?B?d1kzaFQ0WFpqRG9selVZa3hxa1hoYTlhUkNYNlM5T1hSOFhPMHhpcGJNQjBN?=
 =?utf-8?B?WCt3bXNnekhEUTNicFFDNTlQdmhoYmpRZEtydnZlWnB1RE5SdnRPbWtObUZG?=
 =?utf-8?B?WVZzN2pxZmJFNTlZck9HMG5iSWpsWk1UMHk1dEM2c1JQVkk3bDBONU93TEpS?=
 =?utf-8?B?bDFJd0tGY2Z6Q243dU11TDI2T2pqMnNCK1VEY3BZbVRmek5JbEQ3Z3dOZ1d0?=
 =?utf-8?B?YkpGdTdkekljZHVQd0pLWkdHVTFudExlMVhCZGZtUlJydkRxbnJRU2V6aHlF?=
 =?utf-8?B?UW1nT1hEWDJNL3lzZjVwUncxbVlTdldqeXc0L3d5Rjh5V29OOG1maEhEbnJL?=
 =?utf-8?B?QW82blZBRnloajVPck5Cdlc5d1IvamtZNDU1YkVrVHZEcmlKdlA0eUNjUURy?=
 =?utf-8?B?K01lQ0ZURjlPUjdLem41ek1PbUNDUEh6UnBrcDdYN1B5WFozR1hCT2NxZzRj?=
 =?utf-8?B?S3IrdkJldENuaXNqRmV0OGFTWlpGSnQxOHFBdUdrRG1NUW5UU1J3VWRsUnpS?=
 =?utf-8?B?SnNtVVZsVWxKVExvVFdlRmFzZk1NUTFuYzBnWGRGODhjK0t0SGU5WXF1bnNy?=
 =?utf-8?B?ZlVVWEJ2WDREbGhJWjVqc054Yy9acW52UlpTa1oyeVZ2MmRUQmt4aHMzVUZ6?=
 =?utf-8?B?R2NlU2FqYTJaOERyUW5uR3I2OUR6czhnK0lpR1ZGdFJUMHdncEpUZUhXNGJ4?=
 =?utf-8?B?M0l6eTRCbFcrdVczaGttTGZPQTlWZTlaZEJhdlVCeUo4Uk9OYy9ra2dWZ2Y2?=
 =?utf-8?B?UldJbHdrRHJ1SkdVMUFPbllPNmR6SnFPeEhmSEFIVEpnYmkvL1BTY3ljcmlX?=
 =?utf-8?B?alEvbTZqSnhCcHdCdnJMaGRPa2NQS0RHdkR2N2FQMERrU2pwcGVSY3NTQkNx?=
 =?utf-8?B?NVlxOE5ZS0xmcHI1OTJKRGkwb3JPTVZmd3I5TDNOV2VZVTVuc2JRVnh2RlFk?=
 =?utf-8?B?ZlJXK2Y2R1BIUDBJcEd1N0FmTUEzTjg0UytMOXpOL2kvZWVRVnFNSmtBbWJL?=
 =?utf-8?B?QnF2eVBuVnR2Q0c4djdzVXBQaldjR3UvaGtJLzBGMFZCWWhXczFRak5sNVRv?=
 =?utf-8?B?YkZyTEtHNnJDeG1waklNS3ltRlBzWjdGWTVCanYxMFRTalJWMU56T29kb3Vh?=
 =?utf-8?B?VGVkbitZWGtsTFlmM0g2aENuRkgvalcvTG9zMnpibUNLME45UEhLdlZNMjlp?=
 =?utf-8?B?WVF2b1RRTms0TFJGQytvRjJSUjN5cFpZUUxGUisxb3gzVXNmOTM3a3ZJUFhQ?=
 =?utf-8?B?OEdWMlZtZFVoRlBuMHhab0QxZ2Z5QXk1emNFR09CWTV6QzIrd2hnQ2RIOG42?=
 =?utf-8?B?N0RZOXR5NG9kY1ZXYTdOdWRzdk5tMWpTVW5zMDhUK2Ywa2o3VUdEWUlOR0I5?=
 =?utf-8?B?T29qd0d4QmduMlBOVlBTdlpoY1oxYmNuV21uT09JdVNvdWZXR2JQYVhvckhr?=
 =?utf-8?B?VXlyMEQyR05IeWIxTjM1UDdlbmErKzA3Z3ZaUEhIblg5Nmo1bVFONmxVSmJh?=
 =?utf-8?B?Y0pRWm5IRmt5VmszUGh2RzBqNFBtVm05UnhhQ2Z5RHFrVFBLdGZVaTFNUG43?=
 =?utf-8?B?VGNTeENHZGJQOXVPR2hCNGtUTHk5VngzeTBqRk96dGhFODhRRUdIazNHUHVS?=
 =?utf-8?B?UmxuZ01Fc2JuSDd2d0QyWnoxY1pSLzlNN0JCWWNhcjc0dlJzK0NqYTd1TFJN?=
 =?utf-8?B?Rk5heENwRE84RVBMQTFtNFlaTWZGeituQ3hJeTUvZ0xzamN2SWtyTTkra05B?=
 =?utf-8?B?Q3UxNGNObzJZdVcycEdUWVpoTkVvZVRnUHNHVFk1RTVET0FNSGpQZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f34bce-a1c4-4a85-56b1-08dee7f8a132
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 13:53:37.8282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LxRcZfszzfUpDzQn8JgIq7hFuSmQrux/jRb/aNCHglKig+Q6HkV4DVaDYEx7U7fBJ44j4gR7TTN9GmvTqJFEHAi3sFmWhzgtXvtg67KqIlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12638
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QH6kWALxc2DkoIoMTRKrOJzQfiXORxd8BhxAV1AtTl8=;
 b=bPcmEA/301roRYpsvdlirC3ZKGs6xnDPlTUhpPm1IPycPlTsoGeJZ71eZtlQZaX0ZEUJ4iDAFMV4BSfHuTGNPo8HQLfJsstHXfVaOHpA8pkkOb5y4XSBbxnZwictK1lL7nhXkqc/dG3S+DJ/tVPclPniWtlcURQES8drN/1A4nI=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=bPcmEA/3
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <quentin.schulz@cherry.de>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Fabio,

On 7/22/26 3:36 AM, Fabio Estevam via U-Boot wrote:
> From: Fabio Estevam <festevam@nabladev.com>
> 
> The upstream devicetree already describes dc_12v as the output of the
> MP8859 regulator and drives the USB hub reset through the vcc5v0_host
> regulator pinctrl state.
> 
> Remove the legacy fixed-regulator overrides and rely on the upstream
> regulator descriptions.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
