Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96551C5AC67
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 08:14:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 252D980A88;
	Thu, 13 Aug 2026 08:14:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C_OR86W6h88h; Thu, 13 Aug 2026 08:14:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7FE7080A4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786608872;
	bh=r0fcoJ3VljY0ocjG2TR7CdmerzsCa4xGYPME13j6HdQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oNFrvFHUxYXcmNAq0uy0Cy+1tDnm4m3RKt9PYTqM0pX//LxLuF9OiViX67NgOSwbb
	 bGuHN9+WupuZN+yG27Khl+5y6dBMbIBeUkA6yU7Gtu0fVAHdCPOfOGj5VyWSKsGvUE
	 wf82+oYJwRmxIcyNYVPgBadWp+3pf83Zz1x2Br55dBQKuvcENtLJv/yvOODzI01SKM
	 SlSt9c9EKz7MsfVSHIkWL0m+z7Ysc1LtHNMTULjG5mDehKeS44L8rZsbDi9UgAwkgQ
	 MF2LvCkBkju4m84Rva0Nu0KwcNGCFwrzQ+mkS2g5B87GqI7GoUzmOJ/8zEB4iln7sw
	 4abyDgW7QGbrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7FE7080A4A;
	Thu, 13 Aug 2026 08:14:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9518B109
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 08:14:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 862D3608F1
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 08:14:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VyrLcGlZJtrh for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 08:14:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6AC3F6084E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6AC3F6084E
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6AC3F6084E
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 08:14:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wogxncYr0y+16yCFKPEtZKCVL8QpYO0PYgdEEwXj+/jFsNSdhNGYJYyPx6TWHDH3FLHfCO295tPjKia4itkNVon7Zf6wLxdbhmKubgYDc+MkxBwFEuqwWlP1QrQEhbuICbWiNgmpet9YvGeLeVnROC5/3Q1U7LLKK9159zg4mgGrYblIyA8OvhhVQU3SxeEmO6Gx96WiVIg1x+7/aMjEfbGUl7hAg+xu/jZYg5Zk8F0s60HY3yM5LcALrfaI5GFsz++EebZMmX9995y4fXZn8lnDbyWFVV5kq20sWXdCrWzZ79PmPEFoMY3xki7Q9mhOkhPx2wllT67Ul8vR+r7SXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0fcoJ3VljY0ocjG2TR7CdmerzsCa4xGYPME13j6HdQ=;
 b=e4AGCCfDuXdJAJMi5ttWz3CS1elhX+cT37j0c+b9eaw7gwi+PHpbFlThes+QfsQt/YVy7UfJKhrMDMk9H9JVflD6xQMEqlZjNW+CoDGKobiwTVohrfvDWbWzM3IRUWk+jIJmBiCmb7KNdjKJk8nyoSu9lH9+FVPg66jKKqvOI9BdBqjIE1hak6ZVYBXiqukHYgqR4X5oe5QV7OFMS4EIJU41K/l/Qk+NrnQX3jvrYFIO35Wrdh4lsoRUG4GABrCkTtencHmys2r1E2W1BXKju9FNtWKeyBL2wT+CWbJFlUvrp1K6wqhwFhUJZnSYK4tALlNUmZgqJ/CpCNEjn0ME0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DU2PR04MB8504.eurprd04.prod.outlook.com (2603:10a6:10:2d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 08:14:25 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.21.0315.008; Thu, 13 Aug 2026
 08:14:25 +0000
Message-ID: <15291ceb-2fa8-44df-b95a-f4420a51ab66@cherry.de>
Date: Thu, 13 Aug 2026 10:14:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] adc: rockchip-saradc: Add driver data for RK3506
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
References: <20260803190946.2259514-1-jonas@kwiboo.se>
 <20260803190946.2259514-4-jonas@kwiboo.se>
 <ca0eef0e-4e4e-49f9-82bc-d498d54ddd3c@0leil.net>
 <64823d5b-2e70-47b0-b071-82651e7b1968@kwiboo.se>
 <c613cf1a-9fa7-4f9f-abdc-b3130d18e9c4@0leil.net>
 <ede92cc8-2f36-470b-8e7a-bdb04f723b03@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <ede92cc8-2f36-470b-8e7a-bdb04f723b03@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P192CA0025.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::30) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DU2PR04MB8504:EE_
X-MS-Office365-Filtering-Correlation-Id: e0b9230e-2096-4eb2-2c80-08def912e311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|10070799003|366016|1800799024|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: aMe/g40Any9tIl16cLWpEq9OZrUSDw3Ap3HRzLWcl0mYI95QcECsr8u3RHBqFEPHr6RjAJk/TOx57YuWyH6L/Ee7eWlDeWtv7v3dLEzPCLf1RVxLLvzYadgBTspYS0JTOaYL+Pk0yKj3IaUcJVebgZM7okUh0Kl1fEVNgkoNRr4Y/mE1ARBB0gF7GLNe/w7Nb3WLBlc3vFhX29Synila6IBss+7IJtGAUJ5/IxvQXrgWT8FQoGY6KiLtsB64GnnKjm6K5mpZn75V9BT7/VvywzwVdqaeFlimZDwJRGHMtw3YAfQ4xkvHQKuRVn9j24NO/AoSHcSU6ee8dn6VpPpVmHOi1y8DKhIY1jk+GggD5S9ALeaizSnw/5qgeCpa2Oz/Iv/mRgBwp6+mfI/JaBqWXm5P9JuekjSyp7fdpSun9XjM4zWIB4M1wPJbUztN6t8LQToiiuI2TSP3lTk83rHff9iMy2TEh2JwFTvqNrnHk5Krw5v6tCXxzi0JbysPNdqFy95fV0AULSuQ7CpdTBGqild3GPTxfU8Ht7VWkgcwrO/xXOa44RICS47fwxAY5CGc9Rq/0AHJWIy2YdT+yE3a1KDZ8c3zLQ5v4ebTtMt1jUS83Hzfh0E3r05NqlYA6N+X6QXMRy3/xk+FF1fqtLcsFJfJmn3VttjsjJRI8ym/FHU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(10070799003)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkEzTU1oQUZhZ00zV0ZoS0JOT08xa2EvMUdmS0lmcmxjSjUreDY4UkVZVHVM?=
 =?utf-8?B?QWp4WG1nVFM3ZXp1bkRzekIvQzZ0am1lNm5QNm5vMDEzd1R5UmRKeE56SHpY?=
 =?utf-8?B?dmc1QXFNRGprRWtFNDZzMVNUQlNxSGlmNFZMM29BL0NRMFBmOHk2MFhKazVN?=
 =?utf-8?B?Vkl4dExnMTFhWHNQRTZFeXl5TEpCMElkc3VZUUNWWmpXTERMK1dNeEx1R0xj?=
 =?utf-8?B?eTg3a25IWmsvQzE1bXp0d2l4aWt4RFdETFY2RU8vOHpBOUhCUlJOUmJ0Yk0z?=
 =?utf-8?B?aTl5Zm5INDRWYmY0dlhLR2ExbWFHaXRZTmEwT0t1U1lFZFl5Rk9MeHd6QTZ5?=
 =?utf-8?B?MGlmR09XYkJ4S3pMbDVKMVZ6MzBGMm50ckRkNEF5WWdpR2VzbzY1UjAvUVJz?=
 =?utf-8?B?MnEwUllsMlZOR2hWZ3BYTmFVU2tudFZBd21XaDdzdUZ3bmE2SG4vb09oRXA5?=
 =?utf-8?B?cklQRXlrWEZJTGR4Q2ZKU09IeW1aSjh0Z05oRElzeVJoVDREN1NnVm5kaUdr?=
 =?utf-8?B?NThGUlJGUFlLWHlGY2VsUGc3OXlkM2EvS05ZVUlWcEhldWowZ0gzcjdXVFp6?=
 =?utf-8?B?S0oyM0FBa0hsZG5pZlpMa0t0Q0tFSTVGYkFpbGU4M2VYVEpjTE8xM3dQM0d0?=
 =?utf-8?B?VVI1bDVWWDVZSkx0Z3hCNWF3em9OT0RmTFVVK3REM3dPL0FmclNQMWgraGMw?=
 =?utf-8?B?cVVQMzNOTHVSYjJnYWVDMUFpendaZE1Ub0Jqa0x6d1V4bCs1M0p1OWNPZFpM?=
 =?utf-8?B?c1NxUUdkWnE5b1NaRnVUTGtyZ0pZY2ZlZ0RHRlE2UFIwSXJBNy9mSUl3TFNM?=
 =?utf-8?B?UU5qcDE1VHl1Y3BicjN3L0M3U0Z4a05VVHVvN2s3QTlMYnhCeFZ3R1lWaTBK?=
 =?utf-8?B?YWJUTU14aDREakdOMWt2ZHdGN3FwUlh6SUNaNS9tT2drZlBRdE8ybDNJZnFJ?=
 =?utf-8?B?QldxLzFWQlZhZS9sRUo3blUxcW5leStaeDBMMGFUdHMxNjQ2RllyODFacUhx?=
 =?utf-8?B?TFYrS2dYaW9BYittb2RYWlJ4K2lKdEROWDVHblU4ell0cTc5RU5XS3YwZjZL?=
 =?utf-8?B?bVczUmZCa2w5VFpMUWU0ZnFLcTcxMTBvSnNOU3FRZjJOL29QcVVDb1ovemox?=
 =?utf-8?B?cGQ3WkswZEdPN0xIYU5hODZsZGY5dDAwMVo5TUd4Y0ltRWNSU0NCZTJmWFRZ?=
 =?utf-8?B?Q2x1V0NOaklFVGlVUFNjY1FzV2xMV1JMdy8wTXpQM3crOHArbFMxRlVucXY2?=
 =?utf-8?B?T1ZkRTZsdUkxYkt2Y0xjMkF1b1ZZcGFGOTZPOEJkNXY1clVQRE5ISDBBa0pW?=
 =?utf-8?B?N1pJTjdJSkJiNHdpN2FvVkxkcVJ0TnQwRWNyTE5FMEF6Q2xJdVl6SzF5WGhL?=
 =?utf-8?B?bkZNU2lIVXFhbXJWREYyaGxwWHI3L0V3dkh0WW9ST1A3bEsxU0tOcHgrSTZH?=
 =?utf-8?B?L0ZzRmMvdW9sQi9CUEVRbXZyTXI4a2d0TGsxMVAvYjB0YkN4V0tYMTlhNVZV?=
 =?utf-8?B?NUQ0WVNSUk1TVTNtUEViWGgxTG00UFVsd1B3bW5NSjFDTW55UG9xNFlKRXNU?=
 =?utf-8?B?cWVtWnpFNDZ4ZnpLcmVBSWorRzBYS3RUSU1aMkVRdExWR245Y3JNRnorMkNL?=
 =?utf-8?B?RHM4N1NJWjYwdnFON21sNWJ3bUlteEZTR2hPZW9DbDZpSE9UV0psalJLY29p?=
 =?utf-8?B?Rk5KWnc5ODc4SlVoZGgraXpnSDVvQjNmeHFwQ1dwdW5QVTExTHg5MDd3YWNO?=
 =?utf-8?B?TFVZVVNkR21XUFBPMGt1bWNnZ1gzZzhrUW9qajd2YzkrcGNjYjdGM05rZ0pu?=
 =?utf-8?B?RllqbE4zS0xsYVVMSTgrbE9JQUkrSDhjb2l1YThOU2dIRUhIRDVYTVhzZXZK?=
 =?utf-8?B?UGp1TDB0OFdMUG5uVnp4RGpWRzZabEJFUWhmV0w1bVpKQUc1VHZFL2JKaWxq?=
 =?utf-8?B?c3N3SmRMdi9qbmE5QkRYZitEN1ArYjI0WUdNeUEzS3A4ZENBLzJLTWJGNVZ0?=
 =?utf-8?B?NlNhUXlpMFRUQUEvcXMzL25BVE83NEdseTZYYStyNklGQVpwVnRIcmN1cTVG?=
 =?utf-8?B?VEx1eTkzb20reTRlbUVhK1g5YlYzUG9COVBzQThXOHNPYjFid1Y0dk5BaHZj?=
 =?utf-8?B?RWhTY25LZEk5QU5xNSs5eHhCdVFNRDFUaU5EMmlEaXdvZFZ6MlFtWjc1dmxp?=
 =?utf-8?B?VGJpSm1aQWlKUWEvbEVTYVA1VmZiNFcvQTd5YkRpQkZpblpOOHF3VDFTMjMx?=
 =?utf-8?B?TDEwN0FkZ0xueFRRQ0NBVUVUMmpKZzRpSHg1WjE3RHNvNjk1QmtRWU4vRlhR?=
 =?utf-8?B?NkNwSVlxRXRNNEx3ZkRVa0V4bjFFMUJYVzVRbEdSRXhmUVMxdENId0o4T0g1?=
 =?utf-8?Q?1+zx7VsIlUDBKmAa0rxRR/MdE5P1xu4BNGXlVA1CC+V80?=
X-MS-Exchange-AntiSpam-MessageData-1: jEGqudN9xdu1oA==
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b9230e-2096-4eb2-2c80-08def912e311
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 08:14:24.9687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9V2LvMPS2gbt5OkETM5ez84i7s46OZ8x6BwiUmDwcOKkHYt0VExOb/JekXKwv1QUTQqx40Y/pCRuWTzReD1w6PLZRM+9qRrksz6jLAHvbsY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8504
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0fcoJ3VljY0ocjG2TR7CdmerzsCa4xGYPME13j6HdQ=;
 b=kRbu9maTuX2pmh3Q0loyc8c/qWcAtGN2LJytKziPcsXO/Gg+MoT9pyp+2BgpBt8gd0E9UpdKggmzcQWnEPhUwHM6pK1s3g2uBSNgchyUy9GfylgZm33DBOEbYAISOkDCrcZ63TQzjrS1q9J6GJ/dljMW+226ldZpkzwQ2dIaFXE=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=kRbu9maT
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

Hi Jonas,

On 8/12/26 7:08 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 8/12/2026 6:48 PM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 8/12/26 6:20 PM, Jonas Karlman wrote:
>>> Hi Quentin,
>>>
>>> On 8/12/2026 12:33 PM, Quentin Schulz wrote:
>>>> Hi Jonas,
>>>>
>>>> On 8/3/26 9:09 PM, Jonas Karlman wrote:
>>>>> Current rockchip,rk3528-saradc fallback instruct the driver to use a
>>>>
>>>> There is no rk3506 DTSI available either in Linux kernel or U-Boot, so
>>>> this fallback technically doesn't even exist and we don't have an issue
>>>> (yet). Just say that none of the the v2 SARADC data match what the
>>>> RK3506 can do (due to the divider and parent clocks not being able to
>>>> achieve the requested 1MHz). Please simply rename the commit title to
>>>> reflect you're adding support for the SARADC found on the RK3506.
>>>
>>> Sure, I will update the commit message in a v2.
>>>
>>> The rk3528 fallback mentioned was in reference to the dt-bindings:
>>>
>>>         - items:
>>>             - const: rockchip,rk3506-saradc
>>>             - const: rockchip,rk3528-saradc
>>>
>>
>> Ha! Completely missed that, thanks the clarification.
>>
>>>>
>>>>> 1 GHz clock rate. However, the CLK_SARADC used on RK3506 can only be
>>>>> configured to use a 32 KHz, 400 KHz or 1.5-24 GHz rate.
>>>>>
>>>> This is quite misleading. The parent clocks are 32KHz, 400KHz or 24MHz.
>>>> The divider is between 1 and 16.
>>>
>>> You are correct, I must have mixed up this clock with a different clock
>>> that had multiple parent options and the divider was for one of those
>>> parent options.
>>>
>>>>
>>>> This means that 1MHz is not achievable with the dividers and we need to
>>>> aim for something else. Please reword the commit log to reflect this.
>>>> I'm also not sure where people got 32KHz, 400KHz and 24MHz but it's
>>>> what's specified in the Linux kernel, so fine with me :)
>>>>
>>>>> Add driver data for rockchip,rk3506-saradc that request use of a 1.5 GHz
>>>>> clock rate, to avoid clock divider overflow in the RK3506 clock driver.
>>>>>
>>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>>> ---
>>>>>     drivers/adc/rockchip-saradc.c | 10 ++++++++++
>>>>>     1 file changed, 10 insertions(+)
>>>>>
>>>>> diff --git a/drivers/adc/rockchip-saradc.c b/drivers/adc/rockchip-saradc.c
>>>>> index 1515951403c9..50861b61eea4 100644
>>>>> --- a/drivers/adc/rockchip-saradc.c
>>>>> +++ b/drivers/adc/rockchip-saradc.c
>>>>> @@ -339,6 +339,14 @@ static const struct rockchip_saradc_data rk3399_saradc_data = {
>>>>>     	.stop = rockchip_saradc_stop_v1,
>>>>>     };
>>>>>     
>>>>> +static const struct rockchip_saradc_data rk3506_saradc_data = {
>>>>> +	.num_bits = 10,
>>>>
>>>> It has 12 bits according to the TRM.
>>>
>>> Hum, in the datasheet for RK3506J v1.2, RK3506B v1.4, RK3506G2 v1.5 and
>>> RK3506 TRM v1.1/v1.2 it lists 10-bit resolution.
>>>
>>
>> Well, I read the register description and it says 11:0. But the first
>> sentence in the SARADC section says "10-bit"... sooooo /me shrugs.
>> Ideally, we should check whether the ADC returns close to 1023 (10 bits)
>> or 4095 (12 bits) when it's fed 1.8V and then we would know for sure :)
> 
> I did a quick 'adc scan' test on my ArmSoM Forge1.
> 
> With '.num_bits = 10':
> 
>    => adc scan adc@ff4e8000
>    [00]: 1019, 1792961 uV
>    [01]: 1019, 1792961 uV
>    [02]: 0, 0 uV
>    [03]: 1011, 1778885 uV
> 
> And with '.num_bits = 12':
> 
>    => adc scan adc@ff4e8000
>    [00]: 1019, 447912 uV
>    [01]: 1019, 447912 uV
>    [02]: 0, 0 uV
>    [03]: 1011, 444395 uV
> 
> RK3506G_REF_V11_20241114 lists ADC 0-1023 in the SARADC_IN0_BOOT table,
> with 1023 for FSPI--SDMMC(eMMC/SD Card)--USB/SPI2APB.
> 
> So with this data I think 10-bit should be correct, without having to
> measure or apply 1.8v on an ADC pin.
> 

Yeah, that would be around 1.8V on channel 0.

Looknig at the schematics, you have a pull-up to VCC_1V8 so that checks 
out. Thanks for checking.

With the commit log fixed (misleading divider for only one parent, 
GHz->MHz, + add a small word that the fallback comes from the Device 
Tree binding):

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
