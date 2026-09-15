Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C125FC88E7B
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 10:46:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 78A9A80C79;
	Tue, 15 Sep 2026 10:46:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id npLLxR6OLabO; Tue, 15 Sep 2026 10:46:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7A84280C94
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789469169;
	b=A5B1U1gE8qPjOzjy4w5k1TtwFokqikErA8Tc8NtE2S3fprWz8rwPrk4K+BKtwurZh4m6
	 3oGTZgkGg8G3K2+9zs4kis9B0X41p6vx1s+LX32JI3bM/+/J6YJprtoK3cbUXoYzGOSAR
	 9gchHwS1FZAUK8mro0mtnShlCC/ahjLsEPGjfpV0umVGso99IZjSqc1bWv4t2rEDWx0Gp
	 T6o4HHTNSWezssDEOs/5HpRdBEeqycRR3qbdiAzeOYkO0JAsA7Am11F3OZe1bFgWbl/jT
	 /A97Vu8fpmvmH2KVYAnyUBtGlE4/gRAupiB5M1sgAwZq3l6hrr5Wts3IG2MCQ1kBisA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789469169;
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
	bh=C9ZghgvqedVhGIXqef/LUX+ZlNa3Yg5dt3BWeN9qitU=;
	b=rqqYIDkR786DZmSu+uo0FtPkEshrU6GPCeUTxAelo5N5EpWnnV8NMbcGRGvVDSs79orV
	 5N4YoQS9B1MuRMwhNAgDJ+0IiutnGpS19uDtA6cdeft3deZjoMP3vJjFDnaAOpsANV3dg
	 idyGHu4VsQANPt6x3YbwqHXcQjy4Dg77c9/MkmfpdxsL8jkZ61BxgqaDtQ+hMMblk7tBH
	 0b/390uqONieS4/OeTeVSfz96NjWJD+5JkglkkukHgY3dk2CDj+8mqsdASUCJgOzP43DL
	 8PqdADePNulCl2+nzHWYhQ8mhgzv2zac1lrCMbpfYohi3YsIHL5Ps7iMX9QpAYH1ibQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=klf7cF9+;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789469169;
	bh=C9ZghgvqedVhGIXqef/LUX+ZlNa3Yg5dt3BWeN9qitU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cLc3eGalVTFw/zIVpGrgqHHh+7DzuS7c+PSh5Qr3M2DkOEfrZKeQKQh5NJZ2iqX3O
	 yUyxkmRneF1mhGw5gnli/exTth8kIycTxUUurc2dZcik+MQlGoz7JbyOc+uKmatrZY
	 SWsdZ7s1LgP+jsmSkW+Bcy6AOXODuy0jrI20tFKuXS7zBpze+ZvfhyTAtjMkDFBt7Z
	 kA3PooVenhEvvebRqpRw7DnNswU3LDWIMAjYKRGu3yu35G2kRkGiD8i8e3MdEQN/Za
	 F415nLNBr4xH3blEsl8T4opZb6a2fS0UJiiWNbpQZe9IrMJrn+nZVK49glXrEqoCcb
	 9HIUI0CU2ntGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A84280C94;
	Tue, 15 Sep 2026 10:46:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 52337EB
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 10:46:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3791B80C94
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 10:46:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cqLncPv4j3yO for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 10:46:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0F2A480C79
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789469167;
 b=WU2lyNW6S9/zzymfgktai57z0R7yJHWlZ3/0MbSvF+YbHRfnN4dS9S2pUVCXg8eZT38F
 ViEr2fdOt73c4Wpe1xwDU72kfQsJLLX/oIJFKdJXMo3g9F6ijSyQ5lhak9Ho2e+ipsRga
 OUFqawP+y13wxyH/aH+3UggG1WIBiyDCw5CQeaLy594w0S2HIN2HncX/SOjMZjHyI1shH
 8iRGcq3qWgl/m+NNz0MczWhsuxejCJx3qqpoIDDiQgmCnzebFlnK4kMI+mrOjpRGhMPC9
 BMKNIpk/R159kDzUBHRNd8mj2o9fIM5tXRrcgx4hhkIjy4/RDJxk+HYDLu1q9Ojz31g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789469167;
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
 bh=C9ZghgvqedVhGIXqef/LUX+ZlNa3Yg5dt3BWeN9qitU=;
 b=qbFYWALTLpHUebK4esQPLjIG+al9ej2xlNOG1LPpC1Bh5SquRjuIKgRcj30S8IssUnzU
 LSdj+JSWfHOkkRnk9O1M3NKKAQzRh/IE/FwGb2asM6dmyn3j0NskYVRM1pRlXQfeNmWGE
 KMT0sI6bdjuQMjxdb4TOnW9GeLPpKaKx4GBGcqm6wNKG1xv5ZpffN2vw/L70dNxugiHO+
 TH3ze7xlLRyDgPH82MO6o0GVOQqDgC/XCoIvxjBHqT1lkaIhbsr3LgtEAMQ00MqninxVH
 d0FznY54OnBH8EpjNuFjizBsnQmUjhWyUnwTs4hLG5FQjaSmkiGTjgT0zKcpBDcLjhg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=klf7cF9+; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=klf7cF9+
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0F2A480C79
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 10:46:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CNciJtOF5fE2knStlzZ1QbJ7udWIfKMLNBSRy1ZOKVokbWuFKTp5bF7jUJt6RSYFg7sSy7YC2T6FmIerz3B+K+j77nmQaaUMun8L8GWjsqOtz9fqw7pf/a0Je1GfFTDmh0Qju6qq311VoTA9a0i2Q58QBqtoiYOvc3ct1kHu/z5uVLtafNp+lm9r1z4dwCo2c2qSeCBSjT33sl9hKtm0XogGKDfsuQ8kZKzEasflRYMSkPPNj6i/6qED/OfPv3cgB6cJtpDftppbF/a+CCZtE16d6p3/dOjSMCqcJJsvsptn1z0ilPCUggFit7CTxzudP8RJ3Xgg5L45f1/Pr24Akw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9ZghgvqedVhGIXqef/LUX+ZlNa3Yg5dt3BWeN9qitU=;
 b=OI2KSeXz4okTMwmvvDFMdJQwCYxW47sXAe6IlhdKEtH6C9G+nrvt5WQDwhWWfWQLQgB09d77WvPmRxPMnlmruTbumuNZ9ppTwYfS77Xo438V62PFEU1oRfhpGbSa2VkIJ/+jXpUymBqlwkZPL0i3UtCy+BuXx4a8LWXPlWt/qJ1TKyfHyOslMqxJdvm87V0Hsspcju8tWIjIPlqeQOyrT9tjso69AeND1lwHlbZ3tP6UnwUEofaC+DUHt/BZeoDGuiCtaHTjWgRFPYn6SkFPPJoDj0JF8soW2P05tMBAutRLbT4VMA0fURsy3tvFkgxY0MmlGuTLIxE2hTn4KHcQSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9ZghgvqedVhGIXqef/LUX+ZlNa3Yg5dt3BWeN9qitU=;
 b=klf7cF9+eGk2/2J5CSUu9gBYwICOcqeM/GTCOwL3xDlsXz9q2UnEN/eS0uj+zMHHx+cH3T8uktI792rrRTAvmMe+v/tsNZhy6BnaRO9SrLoJBgbm+jBCKkUxXe/sBZB/zwxnWYLAqq954X1muxyfNpVrBPzcMSFsM6gvEkb13rU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AM0PR04MB11878.eurprd04.prod.outlook.com (2603:10a6:20b:6fb::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.13; Tue, 15 Sep
 2026 10:46:00 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%4]) with mapi id 15.21.0406.012; Tue, 15 Sep 2026
 10:46:00 +0000
Message-ID: <5e93aa6e-69b1-419d-bc1a-92b0644e2314@cherry.de>
Date: Tue, 15 Sep 2026 12:45:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] rockchip: rk3506: Update ENV_MEM_LAYOUT_SETTINGS
To: Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
References: <20260803190946.2259514-1-jonas@kwiboo.se>
 <20260803190946.2259514-3-jonas@kwiboo.se>
 <574bc6fa-8469-417c-9418-023d1bd0eb29@0leil.net>
 <363bae8f-de1b-4e74-b6f9-de35efc7e119@kwiboo.se>
 <19ba2ba9-57d9-40a5-b75b-69f3a63261d7@0leil.net>
 <20260824165538.GJ523975@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260824165538.GJ523975@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0073.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:352::11) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AM0PR04MB11878:EE_
X-MS-Office365-Filtering-Correlation-Id: 91eee61d-7412-48b8-eaf5-08df1316880d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|56012099006|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: AS5in6jmxCtO7sLO3AULtuj5slr97A8Ze0vKtlN7D9SXLlkZAhz7clfg7yHhTehvyryePrUSBJL0kjq4VmovZDGma9bxcHmly3e7kzt3+LNze3JWj9M99lbZ5VyW2CUN87Rm7Kv4VYv/1gMNb0K1Q87w3+qE+oclvEEnUvj8tA8K+g4da7M3TScrZjMwWS6vY+WRvO6enZqQCofv7tL3bU/cFEERWa2rll0QhrL3dtzFq6Q0cQLUzIKI/nmxrH5kzSpprDZ98zyBfn9DbFP75sSYN1+pQewMTAnFApbiS1NRTV9+Err6rY/Q3VEPCMs5H5Xl+ZhkAaglxqXZu+jYabMpojR8FyZr7zzb8XOxo4PsJ/TSn335eoH8trd9Zovu7XxGH1Q7sBiSQuO/qv2wPKl8qafyP5efI5fON/OkLKKTmkA0I9ve7O1eQdUhqchiyBK4OaNSdkKYlZqMQLF8tPaSpr9kGBiGKrB1ieNbVlNZ7rwRbzt70drZawDIMjA7J4m9j29EOyjC3Cs0G0WfeA73cqeYMhpBZCMhkHYVVF0D5roUvathE4gcTKOun6owTxF3Bh6CVwWDFe+VEcxzJT/IJFi0jCIDXWNOifqDc3bDBZOW8Nqdjbj2yEKJkX3h
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUFoWU9RUm9uUFh0UkVGaVFnL3BJZFN0NkU3WDIrV3BBSTYrSkEvWmtaNG1C?=
 =?utf-8?B?WVRiU3lJWnVFOENjNmRtWGFtUUFMZU1nNC9tNWtuNDJJS3RzUVVVYVBXSmNo?=
 =?utf-8?B?VXhaMmpFcmVnYnZVR0grR0RZTHhUUU5Vbnl5b0RJTlRPaGRZV3hibW9paC9K?=
 =?utf-8?B?S1d2bU9UVHBFRlJWNU1QdW1PUkFrS2xLSll6YXUvRE5Va2h1QjdHaEJaTnJl?=
 =?utf-8?B?UlpoSm44UktCTTlrdW02eXh0UDRLWm1ucEhIbThrQWVKL2ZZUWFQdWsyZU50?=
 =?utf-8?B?UGtNenJSTjRLOGlVYXlpMjNnNDYyQytBNmtpZmVYdlA2V0xOSHA1S3RtaWtS?=
 =?utf-8?B?T1ZSSmx5bVNxV3dtN1l6aWFQeW9uaHQ4cWw1WDRseTV2SDNxYlV3bHFxYmVN?=
 =?utf-8?B?enVKVEZxdU1WZHJ0dXBpZjBrTHdVWXVNZVIxSE00SXZwMzhLL0g4b1dZSEpq?=
 =?utf-8?B?MEEzNVdSRHo0Z250d2ljS0RvNUJaeFRMYmZOQ1BnNXFTVmx0WGNLUWl3UzVF?=
 =?utf-8?B?dmtEeG96TlBhTE5JWi9ocUkvVldaa2hzWUVqelEvZ0JCTWoxQkVieURCTVJm?=
 =?utf-8?B?TUZIaGdFUk5wSENKcWN1azJsU0g4eGpxVHFFdTlUcUZLSUF6eWIxL1pnK2RG?=
 =?utf-8?B?M0xPRVE2QkU4REs1S3ZxbVRBS0ZHWUlFMFU2OHp1YTkxZ3ZFQzFNTXJrK2ZQ?=
 =?utf-8?B?RWErazN0Y1NzVkp6TTBiRTBBaklxYWJzMmlhL1cwd2Y0QW4wZ1NETjdUWjlx?=
 =?utf-8?B?NVI5QWFORGhpQVBMQ0FZSG5VcTRNT0FRamFMV3Y4Ly9pRU9VVEFHSzJIOFBP?=
 =?utf-8?B?WWJQd21CYXBWV1JJL3kxTG04TW5lSUdBcitKZ21hQ09DQWdrYUpPYXprRmJy?=
 =?utf-8?B?cVNlMUxNUDJiUVQ5SDZURjdFSDBvNkFOL000b3h4cGxsbjNaZWszVzlKU1BL?=
 =?utf-8?B?dlJXRkdCWWwrbG5yNk5maWcySnQzejB2YTdnektzSmZoMVF2Ym5OQW9yNnMy?=
 =?utf-8?B?eG1yR0o1azYzQmZzeDJtTU93anRjMFpyR0Jaa3dnLzBoTWNIbnpleXRUcmJB?=
 =?utf-8?B?WUNUcjZDWUxPUWRoSjU1V0k0bU1FcXlUN08vdkxkcmphM3J1SW5rS0dzSXR1?=
 =?utf-8?B?NU94Zk1RblM2R3JEZEQrRTZzNXZKNWt2aVNhbUs1MWV2OVJ6V0xPN253THQx?=
 =?utf-8?B?VkJKMWJKZFpJaUhsVVlKWUpOYjFESGxTN3B3eVpkWGFtUGtZSFdwbXl5TmpU?=
 =?utf-8?B?RU9WcGNCQUoydTJ1ekNlZ0xnOHdwYmtxdFl3RW43MUFjbCtTMXQ2VEoxME1k?=
 =?utf-8?B?ZWNxZ0dDaHlNTGRMRlBCd3RmNk9VY3N5LzJBOGlRZHg3SEZ1eWQwUUdDVDFm?=
 =?utf-8?B?SkVmSGhDZzFSczlCSnY3N293aVBsOWNIODJUdmE1WkZHL0duSW9nYU03aXZa?=
 =?utf-8?B?ZVZWcGtQaVdOclh0OEdPVWdWc2lSZTJmNkdPd2Jpa3VlcUZxcUtSaGxHTUc5?=
 =?utf-8?B?eHVsTE9zSlEwc2V1ZjdTcmZoS2h4SU8vWjFuUHFCRHlZSVBPb3JWQ3Z1d2tU?=
 =?utf-8?B?bGVnMDlvUnlyRTYxQnVUa2hUR3NWN2pueERvRkUwNi9mdkN5V3hIUmtldy9D?=
 =?utf-8?B?T1dHYVdSc2kxNzUxT0ZyNEtNYUs2VFlKMG9Eb2VKNXNDZ3RJWjlPTmt3bW1Q?=
 =?utf-8?B?bG9RMk5Oa2pqMHE5MHNiSW9ZV3d4dFJiS0lYRlBxZDVkSUZ6LzJwN3h0bXpw?=
 =?utf-8?B?bVhXei9GeGxkcnFKZ2ZTRFEzLzNkSlczTWM3TUJQWXZzemwxN1Ria1llYkZJ?=
 =?utf-8?B?ZThlNDEyWUUvZk1zSzNxdnRTNWorRnJIV3hWcGRIZnhvVFl4R2xoelEwckNl?=
 =?utf-8?B?c3A3Qk85NFhvbXJnZVhVdFB1dS9CVjhjM0RKY1JUWWxSNE1HTmxKQmhsTStV?=
 =?utf-8?B?UTdueEdrbERDYWF6WVU5YnNiclo2dzdSNlJNNVdLcWNWQ1kxT3RGWDI2LzhI?=
 =?utf-8?B?WEZMdVpaZVB2Z2ZxWkcxN3pidUpOTE1ZakNEQ0JzK3JmL2RDNGtBdmpxd25V?=
 =?utf-8?B?SXdja0FSSzZqMlFwK1M3VldrZ0EzVC9DejBaWTJtbXEvSDZKdXpoUnpYeUVa?=
 =?utf-8?B?dGNSVXFlcDVLdEljRHhjRDA5VXdsbUM3SmlyMFpBeDVqdDhuekNERW14bmF0?=
 =?utf-8?B?eTUvYXhVenVMeUppMDRVTC9teHEyS1lrSlFqWjJjTTFEQmtMWURrRFRrYVNs?=
 =?utf-8?B?UzkyaUR4RmVOWjFNY1hmKzBCR2dLWmJHS0V4dEpiV1Qremo0UU1CLzQwQUtR?=
 =?utf-8?B?R3E0MGljMjRhRWtVNEtOdXpOakkwTUFROU8vN1pES3VMbFNLSkc4dz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 91eee61d-7412-48b8-eaf5-08df1316880d
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 10:46:00.4715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JbNAI4lH9xSdTfoJw3wwjcqmKzuAOLLiyjkclskEsVeQWr/OWG+RCOLeIfUimNtrgM4nbZVHvD+dIXKlZgMj1emeyIEEitbF6vceVRM8Mcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11878
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

Hi Tom,

On 8/24/26 6:55 PM, Tom Rini wrote:
> On Mon, Aug 24, 2026 at 04:31:29PM +0200, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 8/13/26 11:09 AM, Jonas Karlman wrote:
>>> Hi Quentin,
>>>
>>> On 8/12/2026 11:49 AM, Quentin Schulz wrote:
>>>> Hi Jonas,
>>>>
>>>> On 8/3/26 9:09 PM, Jonas Karlman wrote:
>>>>> The RK3506G1 has 64 MiB integrated DDR2, the RK3506G2 has 128 MiB
>>>>> integrated DDR3 and the RK3506B support external memory up to 1 GiB.
>>>>>
>>>>> Current memory layout cause issues using compressed kernels or ramdisk
>>>>> due to the default load addresses being used.
>>>>>
>>>>
>>>> RK3506 is an Aarch32 SoC, and Linux kernels on that architecture are
>>>> self-decompressing, U-Boot doesn't do anything with compressed kernels.
>>>> You can see that kernel_comp_addr_r is only ever used in cmd/booti.c
>>>> which depends on ARM64 to be actually built.
>>>>
>>>> I simply recommend getting rid of this variable as it's quite
>>>> misleading. All other Aarch32 Rockchip SoCs we support don't seem to be
>>>> setting this variable, so no additional cleanup to do.
>>>> Same for kernel_comp_size.
>>>
>>> Thanks for looking deeper, I will drop these two in v2.
>>>
>>>>
>>>>> Change the default load addresses to also work on SoC variants with
>>>>> limited memory, keep all default addresses in the 0-64 MiB range.
>>>>>
>>>>> 			 old		 new
>>>>>      scriptaddr		5 MiB		2 MiB
>>>>>      pxefile_addr_r	6 MiB		1 MiB
>>>>>      kernel_addr_r		32.5 MiB	8 MiB
>>>>>      kernel_comp_addr_r	128 MiB		48 MiB
>>>>>      fdt_addr_r		30.5 MiB	4 MiB
>>>>>      fdtoverlay_addr_r	31.5 MiB	6 MiB
>>>>>      ramdisk_addr_r	96 MiB		48 MiB
>>>>
>>>> That leaves less than 18MiB for an initramfs (don't forget U-Boot proper
>>>> is located at the end of the DRAM as far as I remember), which is very
>>>> little.
>>>>
>>>> Do we really need 2MiB for the DTB and DTBO? 1MiB ought to be enough for
>>>> the DTB and I'm sure less than 1MiB ought to be enough per overlay
>>>> (overlay are loaded and applied one after the other). This should free
>>>> an additional 2MiB for either the kernel or initramfs.
>>>
>>> Agree, I thought I had seen DTB may need to use a 4 MiB aligned address,
>>> e.g. for RISC-V, but ARM seem to only need it to be any 64-bit aligned
>>> address.
>>>
>>
>> 8-byte alignment is required by the Device Tree spec, c.f. https://devicetree-specification.readthedocs.io/en/latest/chapter5-flattened-format.html#alignment
>>
>>>>
>>>> The multi_v5_defconfig and multi_v7_defconfig zImage kernels as built by
>>>> KernelCI are respectively 7.5 and 11.6MiB as of yesterday, c.f.
>>>> https://dashboard.kernelci.org/build/maestro%3A6a7b3f4762f33761c0aedc06
>>>> https://dashboard.kernelci.org/build/maestro%3A6a7b3f6562f33761c0aedc2f
>>>> So maybe we can reserve a bit less than 40MiB for the kernel? But maybe
>>>> kernel_addr_r is also used for FIT images which may be much bigger than
>>>> the size of the kernel alone? The load/entry properties are required for
>>>> images of type kernel according to the FIT spec so that part isn't
>>>> something we need to deal with.
>>>
>>> My local Rockchip ARMv7 kernel without loadable module support is now
>>> around 26M for Image and 9.9M for zImage, it used to be just below 32M
>>> for Image when I also enabled more debugging options and partial support
>>> for other SoCs. So support for up to 32M uncompressed would be nice :-)
>>>
>>
>> What's the benefit of using an uncompressed image in your workflow?
>>
>>> I have made some minor adjustments, see below, that seem to work to boot
>>> into a minimal initramfs busybox rootfs in my lab.
>>>
>>> Looking closer at ARM kernel booting, I can see that during
>>> decompression the kernel will be decompressed to close to start of DRAM,
>>> and if the compressed and decompressed images overlaps the compressed
>>> image will be copied to end of the target uncompressed image before it
>>> continues.
>>>
>>
>> See
>> https://people.kernel.org/linusw/how-the-arm32-linux-kernel-decompresses.
>> "Close to start of DRAM" depends on TEXT_OFFSET of the kernel I think.
>>
>>> U-Boot also tries to move ramdisk and FDT to end of memory to reduce the
>>> chance of the kernel decompression to overwrite FDT or ramdisk.
>>>
>>
>> Unless initrd_high and fdt_high are set I believe?
> 
> And setting those in your default environment in tree gets me very
> cranky because it often ends up breaking users in unexpected ways (for
> example, yes, you put things in non-overlapping correctly aligned
> places, but some other user that just picked up the board didn't know
> and loaded some FIT image and ... now it blows up. And this is based on
> history of that happening).
> 

It was not a suggestion for people to use it, just to make sure I 
understood cases in which they aren't moved around. I vaguely remember 
those variables from 10y ago on Allwinner when somehow this fixed 
stuff/made things worse, so I am just simply aware of those variables :)

Cheers,
Quentin

