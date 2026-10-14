Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7116CC6B1F
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 09:18:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 05EDB60818;
	Wed, 14 Oct 2026 09:18:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nl3JQUKfgrGS; Wed, 14 Oct 2026 09:18:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3CC5A607ED
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791969519;
	b=pNSQCs4ENL7CxBL30aHTVh1oMH40ZtKUolnKxizWPYsEgFPswZW5UDRMSayjpggpUsrM
	 BXA6ZFWAdU0jjYAwmZHojKlv0SME0zkb0t3FukX8CBj1n7YP5HzFJQK9rrfTSjVEbxpDM
	 yhIiLwiDkfcSht6XCdcE6O3iZ4c8EQYkdnGuUQlBMK+O4t9DGM3RohuR6fq++cZ4ydP2g
	 pBGm3bGgpXDaFAWmMk7kwmTIGmuzniXrhTGNT0l6ScaTVAW1ybyuheHZvpDY9cZxGP828
	 hziq2vv0OwJX9tJ/TTcYYJC+4plGYDxUY/kHLgjh8IY5iGuNzgK/ytQnRbdmQ+w1aMg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791969519;
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
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Ha7Ip7AxHRv2fEjq7aZMLUVgPzdbmkCK6AeBrh2VnVk=;
	b=J/1ArSNRh+ajDTnzjvWyoPpHfKuBWpnD+BGZDFY4S0MBOyjHmWr4dumeXnqSwrVDPiB+
	 GzTQ6VstkMoFoon0GiL8fi6W19NhFhLrX1FG7yS3Kait7STK5m4otgw13XKZGyu+2gIon
	 GnX9hATgWXYha8DERzyrntGm6wQcHm4hWmYQGwp25j0p5fh74bQOdmaIzmzS+ht7SqhjS
	 MIRQ7joCwXrOddWTPyIcS38VqQul7UHVUJ5dF+wNOzu4Q5bE/uhln2Wvn28e/Jff4ZK1x
	 N+/49+J68tJ1FyyVyzReEAUGDOHARDO+Y4r3tJ5na+t+BX01IP6PziIeOgF2bT2ulPQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b="MCI/zwtc";
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791969519;
	bh=Ha7Ip7AxHRv2fEjq7aZMLUVgPzdbmkCK6AeBrh2VnVk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bvWZ5+B52Tg5DV53EsNirDDvzLtMuUN7mDVg3IiVJw41ELphpzogTMaPzsfoehm5X
	 8MExs5Ab+yPUT1VKplhqLbJOg57D0x7uccNOnISAS/ChBpNoMJCm86i4KqE28NCQV6
	 WL1BnEwdTspwC8+kV0lHmGvVakexgZ4/PYDks/+yOnkO9ZqHsVk+ADeBwv9aoM8bVC
	 1ghVRxqd6DgJdJekIkXAwQYkXGYe3gpJiaWYgdJHXm1G9bOWS995EAVnZ/ECk/BVxj
	 vBJOvaTVvwCxqdvFhQc+dsfmCyix9UpKD3ajaLbwU9gSYOmn6IvDnRZNxnZjhe/6Gl
	 tTgZXj47mS13w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3CC5A607ED;
	Wed, 14 Oct 2026 09:18:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CF9B4255
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 09:18:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C120C607ED
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 09:18:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lz980u-MBL7Y for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 09:18:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 332786076B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791969517;
 b=k7w5Eh575vBEnJPTDalRZXk9x7/1K4FR2H85+CbqCyMyY58C4wJUWCEWimwUpGMZksvT
 bKt+EzlijmrJveToj0TzRPWJoTShZH8Tj5Sk1K3bxkxa4Q+dY8fj7IjIfQD5CZ436VNf3
 hc8Glq0futLI+d73BlyvlIOS9QOTjOGGVKEmcQ78XuVJwUX2lASf4aVcqmlTNFHqJkBsZ
 colQMsiAnxPxyVdtvieMHeyWlaj6WlTEYk/MKqU7AYlqC9WpAPKrlN1P0LbizxLuJJxHq
 MXKeGC2kiUqQ43OvMcoudnW1BJ5GmiVCOyDjHvztI0byu87bQ3zuFJ5UrjUKvnON5JA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791969517;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:
 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=Ha7Ip7AxHRv2fEjq7aZMLUVgPzdbmkCK6AeBrh2VnVk=;
 b=P7/WYjSIMZPKghYnH3HZvxq3hPWXMlavxwNysWJXJnTMJX6dHGBPXtnfLO6DwjPs5NF9
 HH/YC2zrDhj12lQ20Y5A76hSzWkhIUm/GFDYTrXUhizNp4S81cfACAg3eDrz3Mq7AJslo
 GHjUo6Frj1Z/y9x4+2Kf7eME9nQCI9/tqNuNmilbPLJoQPBFtEJTtX3+EQoK85zAafnqv
 fF9/+X3TWxbKexI2eseNz2BpC2C7oAiW63iY9rmrgBLKUpXDdj14k3YL9XG5pMz7ulC40
 UrRTj/QKClioGkiRImgQSVNGehxQAJtlNA0+mpbGX3dvjE/89P5tD2dHemvyf7UTkRg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b="MCI/zwtc"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=MCI/zwtc
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 332786076B
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 09:18:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbP22xRrC+tIQaRuZdlUpuikFKCco+pwYeLiqU/bRVWK+XDKu9aB7LsIrWTbLfhjvbOopsP47tGGJ3UQbPcxPuM9abGNZ7atQtVl9Uhnr0m1YsRPSfmYUn1izh301KB8sExGgg9aGx0/TfM43kC8ZUquPknlXsHFw6s6cyVtEoQKim0TrUicVdZ/cs/cJdmZMmX5t7vxsgsFKNQl8HRMgq22OPgo6IO4FxjA35JOElZUMqCwPlJend2mVq07Nsm8GaLRDiCazNi6t2nIQoswaPIRHR3K+c8OOXikTsqlXx6p9DWPvxjn2FN4JDFKfw2o0lk0YhGzEVQPE6SC1Zh2Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ha7Ip7AxHRv2fEjq7aZMLUVgPzdbmkCK6AeBrh2VnVk=;
 b=fyM7hpdWG577T6UUydWd5DexZOIJydZzFvk5SmEIUcicedGDsXbS97mEyLJdh8ObyQrfc8NXDUmnFIl8DsjgaEwXQ68zByRQY1HRuqIn4Erm4Tcgnm0j1834G0iyYC/m9NODZfyLpzoplqAlMdSdPX+OmdmYy1MVfXVCJ1ziP6SrO110qLlb3IWra9Md5sa4tJz1g2lqB6FhfGO5Xn2EhHYnsN3qbqm623z8o1LykfBWi8QmoFxRqDAQLNdguoq7v12b7QwxPbvC78F2Ae1dbw6x6EDYtnW2kKq3CiAYSsTp0TLrhYg6HGWBwIB8chPTNERCMWvFK3w6yOHXsW9Q3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ha7Ip7AxHRv2fEjq7aZMLUVgPzdbmkCK6AeBrh2VnVk=;
 b=MCI/zwtc37N+j37VxttQuG/ovQwt4KUeqni+rmpPae6gI+9ZIHqGql6wjhbTtnj+SZ67SW+FJsKmLl8pPSZJy7ySz4wonsQN0p4cy4+5nhjPYe/nuN0N7aUlGUiHnQTAYeqRGGeXb7mVnV4eai23mDFwwz0Ms54qz2L+6aVSj8A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS8PR04MB8088.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 09:18:29 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 09:18:28 +0000
Message-ID: <51336e3a-690f-447b-b045-61ae6ee5fd96@cherry.de>
Date: Wed, 14 Oct 2026 11:18:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm: rockchip: rv1126: Remove useless TPL_LDSCRIPT
 default
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Johan Jonker <jbx6244@gmail.com>
References: <20261002-config-v1-0-11bb20983682@gmail.com>
 <20261002-config-v1-1-11bb20983682@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261002-config-v1-1-11bb20983682@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::6) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS8PR04MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: a82ecf46-b0b0-4bb9-4327-08df29d41bc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|10070799003|366016|376014|261009223027099003|10067099003|3023799007|4143699003|11063799006|5023799004|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /ICdFrbztSKoCTuJ/wKmF0S2S/K532g5veOGJH9f4cM7tsCnKcirK2lL31nyDODGeY5iJPwGS2OaotbLoh1aJdIGXL/LEA/iHFuGmMlLabRN50AJllrwtEdkE/ktv/K/fhA75gsJapsS6NeBPgRNwpq+T//LtL3UNf2aYd6GivH/pa1urf4uVGYCwnp0rMURw63w2UIIxyYDtTXn3TEQ1U5qsUwhIAhyRAcMCaXMwmlwL/F3As4FX7+R/YXLTWq9s+OWkz+lVVIuxP6x1DIU3gKJX8lFes6N6fwc9WCBJ42/ftUyHQjosEJp33tfw58DrnRa8TdGv/4946DaWSwtK3CudWIBpduSAUZBE6RaLNXbAe+o00VAPDM7zyB7AzOI2YVMI/bhovWOJwNs0Oe4x6D/LhWU4StvivVe0+1sUZG+dxH+6fCiqGFaMqD+p4l6VRG3NRYVVQRdWOzXnRs/myVUuCLnRLfIL5s/PLwTjdjBkGe4A4gwaQUvBTjYWR8Rz5Rg6b7KPwCWIUX9y0Zxez7CL7YkK6ZQSTs3SYpdumHEAXNT5AQ79vdZbBhRXES/Qp68+wVzZ1vn6U40QvhHa/M2yF8nWazfDWKQMhM13+g+GC7eoWiuNC5f+LiQXW5HnVF0u0fzCwoMaXaBEPqYheExoq0wJhhrju8TH+xCA44=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(10070799003)(366016)(376014)(261009223027099003)(10067099003)(3023799007)(4143699003)(11063799006)(5023799004)(6133799003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0NtdVNsT2Fxa1ZEY2JqSU5HUzdFdDNLWUp6ekFTd3VaaXJVNDdtV3dsM2Yr?=
 =?utf-8?B?cG9oamRxTzczK1h2dHV2N1Y3TzhJWnVzUG9VZG55aGRqdmdpQXd4UzQrYUls?=
 =?utf-8?B?SW81TnJqK2RoU29JL1ZCRDF3Z1d5NjZhejJFYmJCRnlzZndGNmhCSGtqS01m?=
 =?utf-8?B?TDlWbWppM2RDdzR3WVo1Y2dZRWJGVUdQdHBlbTk0ZDVDY1VIODhHd2hkdkdP?=
 =?utf-8?B?d0srNXJJZk1ST004N2ZNMU9BN2hEd0NEYlo4V1UrOGZESWkxUGVTRzN3ZmtY?=
 =?utf-8?B?bkxhOUdjUkFETXJxTDNxbExqb0lCaEVYOC9EZ1FQUFM3d3pvb3BoaHQ0elAy?=
 =?utf-8?B?SnBiVUdZeVc2VDZrZzVYdzRoTW9CUDA0d3p2cThIdlZNQXpUUkFmYnpscURK?=
 =?utf-8?B?S05lTzRURVRhRU1KdkNuUW1PTjJBeTVsR1ZOZ0YyNS9CMGVjdFJwWVRtQXdT?=
 =?utf-8?B?Mlp1ZVNnQUk1YjU1RXVYenpSQVNzMjNrTkJZTTlkb2lrR09ET3RhRWtwL29x?=
 =?utf-8?B?N2I0ZGVxYW5PK2ErM2ttcE5ESjZlNlh5cTVVUDB0Tmlnc0VGL1BkMzdFUmRX?=
 =?utf-8?B?NmhIdHNVV2hnRTBvVWVYaUpKb1lYL1FNMVpCRUJwY3VLRVgxck1zQ29rdmlh?=
 =?utf-8?B?Z3BFK3AvNlR3OTNMbWFTaGFpUlY5L1hyaVF6M2ZicTl3cG9rNDRFNWxBSVR6?=
 =?utf-8?B?VUlST0R4c244Q2VQeUxYdDhEVGltOXF4aENIUUpKUDJxZ0EzYTVod2loQXRk?=
 =?utf-8?B?MVNJeFRVNUM2UkQ1T0pIZ1FHdkJQclc3RUxGdm41ZU1hRDRBcjF5RVpzS09n?=
 =?utf-8?B?dWNlckFtV2Nxa2ltdGRndG44ZElUaUQyVStweElueTloSXN1OXpZbUlWekQ5?=
 =?utf-8?B?WGl0UTZ0OTRDZW05VFZvOFpTeG00T1V1N2NBMlBnT0xxZlJQZ2Z6TFlLV1E1?=
 =?utf-8?B?bU85OFFBY2RCWkV6bytsNHJDcWpNWkFXc2JUT1V2QkkvaWZ1N2FDWkZqMDhj?=
 =?utf-8?B?NGtoSzRnaVlpZlE4NkZkamtqeGFGdmhvVWY2aERKVGtaREZyK3FnVGhyY015?=
 =?utf-8?B?NnBEYkppdGlrSXRVeTBGOStpU05vQkZ4VlNYQ0FYSHFPU2VEcnk5V1k5M0cw?=
 =?utf-8?B?ak5nMG1qNFV3eTJzd2NSQUdtREFoY3dNZ2xiSzdsOUFYeEttWHFXR0MxNVpn?=
 =?utf-8?B?cktEajJJSmUzR1RjMmhSUmdwNGM2b1packNtT3lOZTI5UVdMK3gxbEFIY0Zt?=
 =?utf-8?B?WGR2aWxoTFdzZjY0T3J6RjQ3RjNhYlczQWhwYjAxOU1ocUg0YTg0YkZqalBW?=
 =?utf-8?B?QnVQQUVLWGRPdmpuZExGeHdKbDhtNkVXbVBpRlZ6ZkFjZzNSbFg3WGJUMmRP?=
 =?utf-8?B?Z0FrM1grWndFTGlmWk9Ja1RlYklkL1lpcjlvS2dMUW1wZXlBVjUydmx4RjFQ?=
 =?utf-8?B?SDQ4K091d2tzS3IwVDZtUHFkb1JVbDNyekZBK2w5OFZyekhqbUlrWC9WZkdJ?=
 =?utf-8?B?MEM1MjF0WmpDN0ZEcFQzWUZCVTQ3VjZ6d2syWVI4NGRnK2ZYT1NmSlg4K1M5?=
 =?utf-8?B?UUxqRENxY3MrZ0xhYnFhUFAweVFEQUM4WDI5NWRkdU1RMHI5bFQ5TzlwT0pI?=
 =?utf-8?B?OTAvdU1SeW85QnM1SkZMVXRBa1ZrQ29DMWF4RmM0ckRDTFB5T1kybnJPandn?=
 =?utf-8?B?UFdKekM3Y0ExZmtBd1ZvelJDN0VsQnVPMHJqaU5VdFJFNk00M3c4bnZBUVFm?=
 =?utf-8?B?MS9XSDhteXY2cjhLSnk2S2c1RnphcnFMQVRzcnVEdEVpWGY0alVURktVdWM5?=
 =?utf-8?B?T3B1L1lRSmZVTDE0T1hWRlJtaTVrOStLaWhMNzVkRUNxVXdKd2lWaUJteVk5?=
 =?utf-8?B?S2s4cW1lKzJ1NlZLNDIrcythV0RRZm9pWXl6ZDFva3BEK1VOZktHTE5VTTVJ?=
 =?utf-8?B?UEVqK1BrM1NnRTU5QjN3c1loVyt0bnJ5Vk1SUG1Mc2N4UFVnMldzQmRhZzFJ?=
 =?utf-8?B?UjlDdHhvWFZrOVh2M08xYlZhTG5aRW1PV3EyZm40N2haWnF4ekR3YmQvK3dP?=
 =?utf-8?B?MlhjaXJ0M0J3V3c1YlRUV0JLTG4yNUVQcHhZOE92Zkl1T3VEQVN4c1JySDBk?=
 =?utf-8?B?SDQ4VDhjY3loR0pSQ2tZRXIxOUIxMWlQZHRoZUoyMVBZK3RrR2FaZDV5cExr?=
 =?utf-8?B?TW51RWZCemRLQmhtZlJxR2VFdHU3MkNpdVZFa0RhYmFQTjRlYzBMeU5tMXJS?=
 =?utf-8?B?K1ZnSUgyQ1NsU0lPS3pEUjNKbTNnbEpoWXFUdWNITS9LU2xLUmJPR00rRnEz?=
 =?utf-8?B?cGQ3Smw0VEVOTXl0NndLdkxrdmoyVW44bXlISGs0VHIweGJVQk9xaEhzdm1Y?=
 =?utf-8?Q?JabobETOV20yqTrS/ZxeQs8VT8QxSw9wcSoKVhTnA00PG?=
X-MS-Exchange-AntiSpam-MessageData-1: v3FFBnkJSnw2Pw==
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a82ecf46-b0b0-4bb9-4327-08df29d41bc5
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 09:18:28.7371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDXOdaW3VcVAmGklhn6yq402Wi4sbaBwSRAq678T9zlgCHShh77nWHqmNXG4Jo2vXet1HGEu9KYu38yEcSKomyB1NkL38GesriD1Yzk7GzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8088
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

Hi Massimo,

On 10/2/26 6:35 PM, Massimo Pegorer wrote:
> The arch/arm/mach-rockchip/u-boot-tpl.lds linker script file does not
> exist. Therefore, in the end, scripts/Makefile.xpl logic fallbacks on
> using the arch common linker script: arch/$(ARCH)/cpu/u-boot-spl.lds.
> This is also the default value of TPL_LDSCRIPT option common definition
> in common/spl/Kconfig, thus dropping this RV1126 specific definition
> simplifies the configuration and has no side effect on binary outputs.
> 
> The RV1126 Kconfig file with TPL_LDSCRIPT definition has been added by
> ffb191e458c ("arm: rockchip: Add RV1126 arch core support") just a few
> days after 957848882c8 ("rk32xx: Use standard TPL linker script") that
> removed the arch/arm/mach-rockchip/u-boot-tpl.lds linker script file.
> The commit date of the second follows the author date of the first: I
> suppose this caused the inconsistency.
> 

The CONFIG_[ST]PL_TEXT_BASE symbol wasn't used in 
arch/arm/cpu/u-boot-spl.lds so the undef was unnecessary. 
CONFIG_[ST]PL_MAX_SIZE is handled by scripts/Makefile.xpl and set as 
IMAGE_MAX_SIZE in the linker scripts. I also printed the value of 
LDSCRIPT in scripts/Makefile.xpl, it is the same before and after this 
patch, therefore:

Fixes: ffb191e458c ("arm: rockchip: Add RV1126 arch core support")
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
