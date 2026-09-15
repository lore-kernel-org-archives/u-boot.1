Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B6AC88E53
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 09:12:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C526A80865;
	Tue, 15 Sep 2026 09:12:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rMgr8WwwdpJO; Tue, 15 Sep 2026 09:12:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 162C580889
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789463573;
	b=sIvh6N/gnJaKwBgF3BNIz5ni8R1ozFhVChYh7adBWuYfd5f5wVic8zhbehRFIfBp4B+r
	 mP4huuLUSksdtTl1/1ICBeSLGC7hUNEgmEA+PPl6gCAK2BdVGnIoitkkdZWpkN7ejkY8q
	 2e5ukrgOfKOeP6s7GYO/V87zz85jaK8wO73oajLRmp0zUfpJDE3JwIyUK51XjJ25/okdx
	 +IurDeoFsXPSmfNacfK/OrHrDT6OzLUKjcP06A0VkHc8ZW7Hpt4oyaojr022khmsyJZSF
	 Vr8JG6234f62oetDmPGKeNKvdA+4IJlMnq3DGkyMecRAUj+E4hz577QDjDBj9sdTkDA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789463573;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=C+ZUKyiL30NAZWCKUdUtymYFSwqxfc2CBuEHoNOklMc=;
	b=MgstrXS52E/cp5bnATCUL0mYDB+21PX1LPWPQwK+kjuRxdgPeiCk4S+WmWT2TFBj1WRP
	 NpLecqSViULDrjsthK1OHVBy80iayWHiQKzCIWggHy5J5caTZhZxKT1hKJ19NiNFFAYNX
	 u6+lnuEQJG/ivhtdfsQCBFEBrag9M+us3RCYyqIRFSs4A+Y+vutOCKdQkcmlMBuxydnFb
	 mw1B2Zc/+tWlFCBd5OA/21zWI1im6bFhe+iK0ACobsOYjNmcV0VJ0GSkX/qkT0LkK9TSB
	 tDjhTeBmx+uE5vVMveRcbiOlXvZaagg5MC5nOlP49VQlkkoeFMBL7C3OwSp1Y+1xb6w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b="Zx/x4apf";
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789463573;
	bh=C+ZUKyiL30NAZWCKUdUtymYFSwqxfc2CBuEHoNOklMc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VVms+w5IE557YQtQteoSdElQ3sZAdVh+cT86kveZURIr5WlCVh2amkIfltrKzb9qA
	 saoEIMlsWPGR739WDDMLwoJzWkrtrrGUmgR0V8qKDQcIfL0XBBIXt82f8dhnlbeJ+b
	 5/S8n8t1o/bMIxa8hy5dnF8inSsW8oiNCKka3RU4JTkDQdizPGi/hUIxQQMmENzWdK
	 4mfc6mh7J5kUWek29TcOL5zOQw2d0MrYFsZYS/by4LFP5YiVSxXSm5aIWdlIkNhbw/
	 qN1V+7WBi0j2GutOZxnywyIo0xEjhV0Jdf/4FolH1edyNjYxn3RtbaZXjnnS67+OeH
	 PQ052yMDFPvZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 162C580889;
	Tue, 15 Sep 2026 09:12:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A5EC2259
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 09:12:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8F84F80865
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 09:12:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sKI7JI1OzZGt for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 09:12:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8DCCF805D6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789463570;
 b=iBWfPCm36Xrs0n7wMrAuuYS70CPokvohbPAazFdUHoW17Yhr59rjQiow6HbVTcwmg5Jy
 8aIC2ZLeiXGRyeGD1l/tPwOYx7HlcmECfwsCkHyswbzwOLlBhLNw9KTW+aO+8SskUW1Ew
 9KkfAlspftDYxc96+DywRrNkHv4q8W8L0p7GZMs/KXVeOAdDO2hPDqpVxx8uoFjiWJIHF
 wE6ndBU4KsTHB28jj5wqTq+oRE/A04arYor5eUWMFazVuwWN4NmBTElZ7DUANRFFzcD7Y
 6CkMhi9Hg1eyjpIjpBMxKW4AR8BGL5SG14aikpTUnNMuAlvItkwdPi4Y5AuwePav1Xg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789463570;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=C+ZUKyiL30NAZWCKUdUtymYFSwqxfc2CBuEHoNOklMc=;
 b=jA9Q5NNLiCjx7vY0XQxfYQMMZ+VJ3/9q6El5kRhkfnVvul4yuMzjJlctcCEvb15bWSE6
 gTdBGEfAIhJtocxeD+DX0u3xx2Jyel6Pgbz1//L0La7jWq0Stygxzal+p2KCFMIOMJw+4
 BFgFDTCgD9XAb4HKqQI1sKq82rcI9Zd3l5gkbLFdfsfXAlUH71uiYWTFqIR2HwOvLAg2p
 fTC5/vTtnPslD9ymhRqCU5m6E+L8KnV6cwXUtWCZI2rDnuRayOeBZD8BVnL2R2/R+3vXs
 /IgioPP8RDLv8jLma7s5ThGsFoEEYym6C64wXc2YCGJCKpk/CjqABouCrmAv2WGFRgw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b="Zx/x4apf"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Zx/x4apf
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8DCCF805D6
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 09:12:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yy9cAMF+HsK041py0QemEzNYqU/0cjpXh3PMkuRC73R7uMhySyLI8+r+IqRnbONk+Mp6fiQaqcc6l5VUdsUtL8amMEtzyHnPopGwJZCtti7T12kGPaeKd5ZpsKqL2a/5dxl5gEGKLEgUiQQJIy4gx0jPVpWXNw8Ln1HxhbEUJEhov/4fVSsIt8MCMpZCAI+qJvtIoSIs5FPigZf2NNv0MrTIb1ArxW83KTzmI1vRmpUFUbWcd7DF5z7VfIklCbGil2RiEqGKMCk0mApc/mLItSo50iBaYL+T22Rl3YR43CWmgEZEbbm3f9qcIk72YmMlc5RgdE1p1xLwkDA+6V95rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+ZUKyiL30NAZWCKUdUtymYFSwqxfc2CBuEHoNOklMc=;
 b=MY8KCFPuqLnVj6/XBvJpHVessvvI3U6UiHamXd9DWD3oXlybRA1Hjanuvb8I8RpcITuKyVdkh9JknCAFqz7L7V6nobxuLl+K4Tiuq1hj7/5v1ZVipI1xgJwOLeNi+92iWmpeOhiy1EIiempGAStn2uV0NV4l7xdJ9dBsiLkZMK3nolfOO0GK7WXy2kzSdMnRQQwx6RACvsIs14UxlaiAwNUTQNQQRm+FxyVqLurCwLryaYCUUlwGXTuqU4hg/+KaaSzBHrb/xmqbUE8WCGh6053UYWf0IE0Pv71LQusd65Fae1wJ4nWQlE1IEVfgXA8QC1VP8E6h3oLELwAWkN7hFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+ZUKyiL30NAZWCKUdUtymYFSwqxfc2CBuEHoNOklMc=;
 b=Zx/x4apf5sid4TpVenn47FsOiZtxbaRg1+S64jCJTj3iL6Ilm5vChankNj03KoBV31h59OmdIF10XNj+VuKYjAconyjXqKcmSKiib2jcvR/hImlPjoTL6j7SQkOW6aqd7HCNY5QZ7x8kE96SaxAjfz7R9UC4utuhlsLRhoVFm9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PA4PR04MB7981.eurprd04.prod.outlook.com (2603:10a6:102:c0::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 09:12:43 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%4]) with mapi id 15.21.0406.012; Tue, 15 Sep 2026
 09:12:43 +0000
Message-ID: <0342dabe-d9d6-4218-a403-698c4159ea4d@cherry.de>
Date: Tue, 15 Sep 2026 11:12:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fastboot: fix the RK3328 buffer-address default
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, u-boot@lists.u-boot-project.org
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20260904131951.44451-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260904131951.44451-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0054.eurprd04.prod.outlook.com
 (2603:10a6:802:2::25) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PA4PR04MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: d42afd13-c8a0-49d3-76ca-08df13097fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|3023799007|10067099003|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 64mL7LVK3mQcEAbV8/zW/aO/GQtgATBcow79tTeSVIvzv9OGIk8Zpuz2LNPe2tlampstRPjLzm30oSrRn1JpYTxbSldwVjS+1oINGBc1T24YqZBGpWCR2ARnZfi+YP1hahrCymkJDd0r668EfcMCNqKJVNjGlXHsAoJb0Nf99DrhNmF27vN9ihkBKDmD6qqTC0wZQeFQUGHSr+7sTL5oHjwhaondiVdkE39XZRYihodN2HNVnC8tyoDAlUMGTCyW5uUnfomHFNfqcLpTquIDk1XMU1rkM95lFpoIY1pnCaEG2pha81ejgX25im5TkpuevUKtCINavUQruQZw+XJJkWM2W6lMJAM+yAg+Krbh35sb07+imQ83b+3fmXHdNwVtRWJUiCT4O5C4ioXtxnM1H8PeAhNxeTiqGoE/5iv1Qt/1WQSfL2Z4gvqU3TN0ZHAfdntjvrAd+LfsreAelzd2cMknJUINakhG0+EZW8ZHDhA3Qd2tPIWkL1R++K2uI3P0BaYpXfgjAWvl6Wz/i2ru8EvSW1N2WvTBRhL0SV8GJxj5oGtd+JwTKR3AdKOxSPeube4d4MyfF2lnTi25WUenBqVOdFHeOE1XUOpVp7k1xFO0inuPyojxeCq8icwHixcXAWJU9F61OmOVqQBc4VXybcgOjz4N+5FbcJatHzJs7wg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(3023799007)(10067099003)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjMzQnZQcmZKTEJqU3F3M0RUSExGdlV6L2thMXV3ME0vUTVvSkIrR2ZaUkVF?=
 =?utf-8?B?RFBVNm9mYlducTM2WEc5S29zU0Rab2VnUEYzWUpnbzlTS0xWaEVYZG5MSUdi?=
 =?utf-8?B?UTl0K0pDM3FhbUZSblMrUDRwZ3JYT29oMDdrTDBZYTVMenp3YUFLakFhcC9l?=
 =?utf-8?B?SlZTQktyYlhwV050WSs5ei9lSjloS1UwVThRRCswc0p6U3NIbERrTXRQRTB6?=
 =?utf-8?B?L2dCTWVhdFdKdnZUS3I4RnpMdlZNNkNsN2JDbmptRjdLcm9wTDVYU0paaWQ3?=
 =?utf-8?B?alY2VkxoMHBCY2x6RFNRTDhnSVh1ZGpyUzZXYkh5cERubkV5eEozY3luN1hm?=
 =?utf-8?B?UEQzek5BMTJIZlBzaXcxU09DZjNXcWJSbnRUaVFVQU9MNkpCTDJIU282eHcz?=
 =?utf-8?B?VlllOStMQ245em4vRjAvWlBLQ0VFai83enFiL3JscnYvSU5PZFpjVlJlWDQ1?=
 =?utf-8?B?K2RJR3luU2dxQUZqZU5INzNxUEZTZnIrWG9hdUE0NDdjaVlhVHRPTXJSanlB?=
 =?utf-8?B?WWh0bzZ3MVV5YVh0d3JnMlZRb21Nc3ZCQi9ySmdCeG51bFYxNXYxNEVJSGZE?=
 =?utf-8?B?MjQ3dWlGOWd5Y0FxcG05Y1dzeFVaKzI4em5Pd3V0NWdqa3o5dDNtUnlwUjNr?=
 =?utf-8?B?OVNBZnhpSi9kSkU4b3VUWThmdUF4aFRKcDM5UGJxR3VjRFVWSDVjamtXaUtO?=
 =?utf-8?B?Nyt5SXB2RC9xdEZoZmx3ZnlJSVhOaXN2TTNwUzhXTkZpbnhtL0JwKzdmMkhq?=
 =?utf-8?B?VVJyZnllNTZGRXZzNWRHN1BYQk0zZFFIZnpLYmxNcEhXY2gzaiswMXQ5NDJ1?=
 =?utf-8?B?TVRkS1lnVWhiQzBZMERxRW5vemNqbEJpV09lbzJZdTNRZTE1MGZYVytHRmRh?=
 =?utf-8?B?clJYZDNIcjJzeThEZ1R1a2d0TVpZektQS2EzN3AyaFhQU09JQ01tMWJXU0Qx?=
 =?utf-8?B?Vk5YRmFla2ZnZDB3djlyN3FkMGU0VGVxdzZoamJXcmJqUjlWRFAzek9GQXUy?=
 =?utf-8?B?Q2MreXpCc0FRV2l6SDE2ODcvcHZyQnV5MldSTmhhSzl2UUFrZ2w1UXRRcGFJ?=
 =?utf-8?B?eHptdEt0QW54aDByb2RuV3R2WjBpb201dElUMjFFYlJrRERuOXNHVG85ZFhH?=
 =?utf-8?B?aFhDbXd1ci9sbkF0MDhwNE1JMUpjMmlXak9oM1FaNTRUSmcxTUJPTHRHcUp6?=
 =?utf-8?B?Rm96V203K2x4K2hYME1kTEw4aWJYdDRUNDdvbU5RUUhYUitvREtNTGNHM2ZV?=
 =?utf-8?B?R2R5bW8wMjY1VEw3M1RqVGw4ZHlGZm9hc21pZFFrWVptV01nYzEyWkUvMWZG?=
 =?utf-8?B?VGNsUjJkbmxuUHZXM1dRWUJkMzdPK0lHTmgxblRxS2MydjNEaVY5WU5uWEZB?=
 =?utf-8?B?WWwvY1VTbHgvUTgrQmJHdWEyK2tFYVNXcmNUcTAybVBsOHNNUVFLNEU1czBW?=
 =?utf-8?B?TGcrWmc2aEtQN3J6dlBuL2dvUW40UXZ6dzdaOG9IMi9GUjZaUkRsSEVua1dm?=
 =?utf-8?B?WVNOeFBFZDNROGpLSkdqdmhJRkh4N2NLZ2VnZmtJaWpIU09rWWtrV2hDeG1y?=
 =?utf-8?B?Tk1ua3B0VjhWc0svYlJ3VVViSzF5VTVuY1lvY1d6MnFvWCtFcWlxanRkRFlQ?=
 =?utf-8?B?WWRWSkczL2RGMmRKaWpnMDNiQTBNbVFzRFQxNjdsdEJVUnQxL1h5ZDRtVFI2?=
 =?utf-8?B?Qm5MR0dBdEFQeEtOMkZ2OUF2MWp0QmZBZFh0QVRhcE1tZ1o0VWdyVXQwVFdu?=
 =?utf-8?B?Y2ZSQjVaYlN5QU1Ecmg4WUtHSjBONzIrOVFBNXZUQ29vaVZKdTBvN3JnREt0?=
 =?utf-8?B?MlRwRW00bmIwbDM4UmdUa2M5MzUrRWVWVHNDRWExaGYvd2VnSGtzVURXYkJJ?=
 =?utf-8?B?VzhrWFQ4U3lpTHdlQ3hnVitPTyt0TWdoOGxrdm8xeGhYSWp5M2ZxYlhKTWVj?=
 =?utf-8?B?L3pQb2RPdW41ZzR3MWdYUnBLcnNHdzFMMjZ6M0dwZGVMOE94Z3BZaVpNbEVC?=
 =?utf-8?B?YTNBOWh2RTVsTS9VWjVpdjBlay9lajE3cTdBcUQwZFJUYW9RS3VVT1VYSkJr?=
 =?utf-8?B?VXM0NWhocDgrcDgxSmw4aldWemwrbXFPeVdkWEwxVlpsSnJVcGVwUk14TkV5?=
 =?utf-8?B?encyVzFUZ2lnRll2OVkrMzJMTDMvMkN3eEUzSTZPQ05TUXNFaVpMMEI3Y29Y?=
 =?utf-8?B?dFR6V29ld3NKb2w4UGhBZVJoajV2Zk9NYzk4WVdmWGFwUkFaV0g1ZWVBVmdh?=
 =?utf-8?B?bWN1SDJiU1NiTkNSQmFDdkxpVGordGg2eDFHYmdHd1lzWFFHNnJKMDBPanpw?=
 =?utf-8?B?UE1zaGpDd1VEWkNkOGhOS3ZONWFZZUdHZTYyTGtTUHJJNkVBZFh0UT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d42afd13-c8a0-49d3-76ca-08df13097fc0
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 09:12:43.1347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LuLvjqH4DeySesqicPQH+RDZ17nIfyL5aEW0e/mZ8+Yr9tJny89hHhsLAgwRGFmmno8fvD9R0tnvVdU1JZzxNFAo6nAbjsVPPUlkrQdSPVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7981
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

Hi Pengpeng Hou,

On 9/4/26 3:19 PM, Pengpeng Hou wrote:
> The default fastboot buffer address tests ROCKCHIP_RK3329, but U-Boot has
> no such SoC symbol. The supported SoC is ROCKCHIP_RK3328.
> 
> Use the existing RK3328 symbol so custom RK3328 configurations that do
> not override FASTBOOT_BUF_ADDR receive the intended Rockchip default.
> Existing in-tree RK3328 defconfigs that set the address explicitly are
> unchanged.
> 
> Fixes: 48f6232e5897 ("Kconfig: Migrate all of cmd/fastboot/Kconfig to defconfigs")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
