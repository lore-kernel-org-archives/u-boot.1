Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA61C5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 08:17:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC9EF811E3;
	Fri,  7 Aug 2026 08:17:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZbTMUDueVBfy; Fri,  7 Aug 2026 08:17:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0545C811D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786090671;
	bh=dpKfiQnoIcFLLd+BTB2OGsETEXDGe5uXBrKcqntVFEc=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sd+7kK1+8MJxssEMdbLX4t7f5gyVN3ddEez41n48PXuSQAx7/QmnwQ+wxhZgd1wcc
	 Q1en4Nq5dqIvdEsnCcR7K5oUfXyp2vnDvYv2a0u0keD6N1MzARSWbz3TY6SVzOzcFD
	 fVBE7hqxUmSR3NE0vCdtiRBs59Qmdz7pZAy711mCCH600zyWrdErSx9Xft+dtGFsPS
	 a9z1Hk+AjFeePCZGM7chKut74UfVfAzss7QFc0ntrYKq1EeFNxKqF1lqL4i0RXYXeU
	 9T0q+VktUlt8JqrwiqB/sEvX4qBRHens/CxiZk/PoZ+DD+qLIGDBUw+ghcbKLduGXK
	 mUKry4VZhaaMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0545C811D3;
	Fri,  7 Aug 2026 08:17:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 671A4397
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 08:17:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4D57D608BF
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 08:17:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YgNwGTctmuKd for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 08:17:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6B50D60690
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6B50D60690
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6B50D60690
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 08:17:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B84Y5OwQljAz4CenMDZ8eS8FQuoeHr/PPRbgpAyFTN8FMGcPheR0q86bsPTnAvYUArhkKa1nXLLAiwgPLlttXLQzUtKSr8wNR6YjtkcpMH9czKwq1uC2akJCSUQpWoGqM5gajl0E0XeSnAbwZCf3lqiWkBcny8QY+RyxVM0HxBsqzlriIv4amj2yCUao+w6maIdcuwyTO38q5phgW0lDZHaxUyivyrTjB3vN2ALVlV6/o5Nn3QwD5BYGndAR+b0wpFZtGgji89enh81IXeFWdClpM/SiZZJ2QarV3cYL3crOyx699UtC+CzHV7PVJs1mBlGlVuUtgDpr/TGRT9q1kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpKfiQnoIcFLLd+BTB2OGsETEXDGe5uXBrKcqntVFEc=;
 b=eNOMz2lJYwAHNGkiTWBi2gC2KDe+Thwf9BCzeQqXDA/fAEt5j49fREksYJC9pG84bhQbnB4idILQUuTfKccY42zX75D5i8va3rbAl4AX/caMbj9VbTvV+lHePc66ks9rgHy8/qOMZg3WloZ7N/5RuqOseEn8LpLhvIU/kgvddd52TO3rWobAiI42GjfgawU9NYc+JEs56Heu60kCZ6pqxI6HsZoa0avqE8W0gofLGNrb/DjJv4OCu7mDQF2/aTLvdgH/fB8/t3xiVaQKu75aXlzdaU0K79e4rMD9kM4IqdjhNrU0DZSeTN288MCJ1dPvUK3YoPYGQgyQ8W+0torpdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by GVXPR04MB10083.eurprd04.prod.outlook.com (2603:10a6:150:1b6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Fri, 7 Aug
 2026 08:17:37 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0292.019; Fri, 7 Aug 2026
 08:17:37 +0000
Message-ID: <28db4bd9-e915-4af6-9b3c-b2743baf9a09@cherry.de>
Date: Fri, 7 Aug 2026 10:17:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] include: linux: Import hw_bitfield.h from Linux
 v6.18
From: Quentin Schulz <quentin.schulz@cherry.de>
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
References: <20260803184314.2240153-1-jonas@kwiboo.se>
 <20260803184314.2240153-2-jonas@kwiboo.se>
 <5af6d8cb-64cd-43be-ab99-3a8daaaf7ca7@cherry.de>
Content-Language: en-US
In-Reply-To: <5af6d8cb-64cd-43be-ab99-3a8daaaf7ca7@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0217.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::38) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|GVXPR04MB10083:EE_
X-MS-Office365-Filtering-Correlation-Id: b8b54dd0-8753-44cf-0036-08def45c576c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10070799003|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: GJGUEn0/+HFwP4uKuAyKetUFloNRODttptvhkbpQ1WqnvUi+VxhBxxFANQ2f+oDx46dSIH9Zl5ynEIRQj2pjwti7/DVAGGfOIwHSwz92V+Itj3RAOijKmOJcvhdZ8r7995tkHiKIcVmdKpmKP9IsLZvLQrUS5FcRTZCIE620hTbhPXCuxAP47yfbN+8iUWJEMK3K13o00ha9aiAvb2CWsN4u7QdD+1kTkdHODfflUObDGVKuzefg98jX3UwWVVpMw1ixR7okjk5Nq47hFwrkgax4MdSIFSJ4vYnzREHV7J78Y7hVygluxt9f+7Hm+sAkigH0hK+eT6snkcE+w3s/nzuqYaCk6qvxSbrjtUfiNnsKyqcPKEjgfmj28fzgubHVabyrCJoQYnMH14CINU+wEuPx2gNrAshjc7MyopIdvPyj2zlx6nzwtug7h3k1JHPZThC+6Ed0oTkfInM+06RtW7MqAWFOR6aMaLRhAcd0skMv8FRyRxrrfT05TSlkT38/MadM96kGmM/50QeyilpoR2ldPAwU9mTu/HUkw4Ms+agltMDxiI1/PIwIXP4GxcBIN+nZD8MRCBgRt5Eugsm+xfQB555/c6W8a6fibUb7TWDURhz13/NNIrRBby0CDyy4CDd9+IUlpxRmXnJEOs3MzUz1y6QqTQtLh2eL8yzIjvQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10070799003)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDlwN1pRM2lSeTRrdVl0QWR1SHpZaW13dlpmdFpsNUhEVmxSdWVHWVJQQ3RG?=
 =?utf-8?B?ZkpkNmtaWW4zN3dvc3Yvdko3VXBEdE1rc2dzazU5S1FOb1Z6Qjc5Sncwekxt?=
 =?utf-8?B?dUpCcG9MaVAycEtlNUE3REtIUG02OFZVanBCa2J3Z25WblBzSitXWG05YXFY?=
 =?utf-8?B?WlJNRFgzR04waVd4ZHNweHNXRjR2NGh0SXB3S0RMY01qNXdEQVgrZXNSUCtr?=
 =?utf-8?B?RHowMldmQUdDeVVlZUM3S3BaZEdtN2Z2TzIySnBRbE1BT1B5Q0VCZ3VvMGdT?=
 =?utf-8?B?Sm5sWFlrK1RUV2Y5bk5pOW42SzFXbGxrRWZ0eEJSK1l6WDcwR2dJZ05Vakdn?=
 =?utf-8?B?WEt2amd2NEllb2lnVzRCVkFlVytmMHhwNlZMVUIvejlja3JRY1NxTmFyY1h1?=
 =?utf-8?B?cTRNNFQwYU5UbjRKRUJEMDVIOFl6QjZQYmo4R211aFdEY0dEZTJvR1pFSk5W?=
 =?utf-8?B?ZUczOW51SHNEVEdsc2llWTZ4SG1zeUdlUmJpeWNnRTdlUlNSM2NXMVVEdWtF?=
 =?utf-8?B?MzNxREpGWEcveHhUMU9Kd2ltNEVKRCtuUnBhT05oVkJBNGorUEpOSW9TZW9B?=
 =?utf-8?B?MVowaVJWUWw1QXhaWTNJbHkxdk5NSC9nZ2VUSm05MXNVeDJONzdaYktiQ1JS?=
 =?utf-8?B?azdhSC9MVkVsUWpsT1Z0QXAvSzR2TFRmZWhmNHFqNXpkblBkMFV1a0tVMUxQ?=
 =?utf-8?B?VHhaTzhzQThVcVlzbFVuSEQyQ2E2dDNUa21lblNtTVRHK1B6azYrVnZ1bzF3?=
 =?utf-8?B?bDhKWUZGVVQrcVAzcjRYbkhMMVNvaFdqdlovcExxem1TMTIvdERDZWpvWXVo?=
 =?utf-8?B?ejV1aldYVGMzRkxHaVhyRDVEYTI2cjkydXBJNCs3THBFKzRjZFk0bkxHeWtU?=
 =?utf-8?B?UFRZOVNCT1FMMml4UzFxZk9ZalNhZktHUDlXTVBET3Q3OXk0U0pvU0Yrblll?=
 =?utf-8?B?SkVZVFBPdmZMTWREUTlkOEkyb05rT0xhMys0VEw1Q0ZGYlZhYWZzM2d0Y2FB?=
 =?utf-8?B?OWRPN09UMVdvUFB0blJ6bytjQTZFZWF2SmJLUWdOd0pzN1doL0V3WWM1QlhT?=
 =?utf-8?B?bmFFUTJvWTNINWJsUTA3RnFuTzhnYUtxM0RjSHBwZnNGZXZQb3NkZTZwOHBT?=
 =?utf-8?B?TGxSUkt6NWVCdFRoMjBDQlFJRHRQZDZDWGs1d3IyMVB2ZHR1MnZqaldkSmVk?=
 =?utf-8?B?ekswZjRzNFFINFk2ZlBKd0lCYjE3cHQwc3AvbkJIQ21YS0JMODIrOEc1YTlu?=
 =?utf-8?B?RG1qYWJTODdVNGdLR1k3MWhvTTNWd1lvRnBuMWdmbkpBSEp4bDRwZmU4eVBB?=
 =?utf-8?B?WVo3OG9FbWpyTVlaaUN2bE16SDZPTmtZM29pSFFsN1IvV0NINnVJSG1jTFRy?=
 =?utf-8?B?OWF5bjlSSHVyaHFzb3kzM05jN2tFOVdacGNJSURvT1RNTG9TRUpjcm5iUnhL?=
 =?utf-8?B?czlESTRlaUhzNGxUMkV3VkJ3MWd3RVlnRTZRTWFRd2Q0VldRbVhSS0wrL0sr?=
 =?utf-8?B?RG1RRXArTXRpaFEvU09EMDZjWnNURUYzdUpxK1NZanlkMjVIdGFQN1VQV2wy?=
 =?utf-8?B?R2V0WW1JbEIzRk01d1hSOHptVGxLVVQyU1RKZ01aRkk5N3I3Mzl6T1B3OUFv?=
 =?utf-8?B?dmI2NUx1NVZFcHRqaisrWW9jOVNpdjVOWXFMVE02NHdkbW5LUzBwN016YTFw?=
 =?utf-8?B?MlFHaFhHc0NTbFNGZ2hvK09VZHpFTkFJYklMK3ZNZFdwbjRPK3VTTnlkM1JP?=
 =?utf-8?B?SFcyaU0wZzJuNzhnNnZjU212ZndPdEZ6RG9aZm0ybmZTY3FoYnFsTzc0QXp0?=
 =?utf-8?B?cEJzajh1UCtraVFBYlJUUWFEOEE5dWE4ZE11cmdHNG1iNXQvSG1mdW5mdmQx?=
 =?utf-8?B?ZTlUMnNmVEtpS1RTYU5yWll3SklHSjkrM1MyekpiM2ozUGQya2pLREp4dm4w?=
 =?utf-8?B?UEJEZVJYNWQ0VlhTVzE0Z0VBMFZwZmtsVFdRSXg5RlRTR05uRXZEVE05ci9r?=
 =?utf-8?B?akQxa29NdDBzMWpSZU5zazJMLzIyRDVILzhTNXQ1YzlOTitMNkFjWEdwK29k?=
 =?utf-8?B?eXpjK0lMTXZwaUVBMVhETm43OFU5Y1VlYXZsbHQxTitGVzE5M1pPeGxPam1s?=
 =?utf-8?B?YThNNTJjQ0xJcXhpclR2dXpYOVUyeW5yS09nMlJVSTl0TVJLSW1tNmhZclg3?=
 =?utf-8?B?SGUyMU9IZnpqMzVua3pwd2gzV3l5NFBNZTR6TDFHWnpqUWdEc3c4NlpDZHBD?=
 =?utf-8?B?QlFTdHBMWHJ3eU80MUFDTEtwSTdyQXBQaW15QUlyT3llcC9wWU9JaHo0TFBk?=
 =?utf-8?B?ekZKZjJlVjFCVVRzM0x6Nnc1dVJWaDZ2cFhRdnNxZTU2b3NkclZtVmZ1RUw0?=
 =?utf-8?Q?bcJ7tkh739mIwBHGLpfnHCLzL0gCqx7ba01vroAen3A6f?=
X-MS-Exchange-AntiSpam-MessageData-1: m62d5lZMoW27Dej5KyzL2ShVq3J8S/UASTQ=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b54dd0-8753-44cf-0036-08def45c576c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 08:17:37.5267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LAehPxReX7aNbR80gUNHBkQZp8r5TxIrrJNXNguqlkuNZCrz4iz1XU/v9JpAK99q1T70DG5rWPLgYlrgTBUAQ6eiQdd3vRi6Xfk+UZfcM80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10083
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpKfiQnoIcFLLd+BTB2OGsETEXDGe5uXBrKcqntVFEc=;
 b=V36quxbfkxbdPkq1GaJuYSCHnUnQsHmDdL0v20bK/GP1ET6mJFviHof9KnFR8duH46tGTppGtnuM++jWJJPrjaSaQeY0DrlQFT/vAkNmQ0KbegvxMp8x9MqDnpgovYHPxqctujZrBk4uxa6omEXhNwFFfSdFR5FVDZJ4i0Kl9fo=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=V36quxbf
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/7/26 10:14 AM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 8/3/26 8:43 PM, Jonas Karlman wrote:
>> Hardware of various vendors, but very notably Rockchip, often uses
>> 32-bit registers where the upper 16-bit half of the register is a
>> write-enable mask for the lower half.
>>
>> Add hw_bitfield.h with two macros: FIELD_PREP_WM16, and
>> FIELD_PREP_WM16_CONST. The latter is a version that can be used in
>> initializers, like FIELD_PREP_CONST.
>>
>> Import hw_bitfield.h from Linux commit 21368fcbb124 ("bitmap: introduce
>> hardware-specific bitfield operations"), first introduced in v6.18-rc1.
>>
>> This contains two changes compared to the Linux version:
>> - include of linux/limit.h was dropped
>> - use of const_true() in FIELD_PREP_WM16_CONST() was dropped
>>
> 
> Acked-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> The content in this patch is as described in the commit log.
> 
> I'm wondering whether we should try to get include/linux/limit.h (and 
> include/vdso/limit.h) in. Also wondering if we could also get 
> const_true() in somehow.
> 
> No changes made to this file in Linux kernel since v6.18-rc1, so could 
> as well have said it's taken from 7.2-rc6 (which also means no missed 
> fixes).
> 
> I'll wait on Tom's Reviewed-by before merging this though since it's not 
> a straight import from the Linux kernel. I'm targeting the next branch 
> for this.
> 

Read patch 2 again and you convinced me that this should rather go in 
main, so will wait for Tom's R-b and target one of the 2026.10-rcX.

Sorry for the noise.

Cheers,
Quentin
