Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD08CCA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 14:29:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 65D8D8132B;
	Fri,  2 Oct 2026 14:29:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VRa98ZuK6pWw; Fri,  2 Oct 2026 14:29:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6EED98116F
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790951391;
	b=NIedjytY3KE/h8KvFZ/6DKu3zcDskz8d3UaRDL0KV025Cdi3shovACpvtf2qs4gjMGuH
	 e6gH8DUCYyD8RnJ0NUTVAbKaFus7o8c294z2pflU0POjUDhtOY68KTW9ian1NBsDd7fL2
	 4/7rje+EqY5Revt0GWyg8Uz1dm39hOS4LVUjIboxskwWRXdO5jANtblj3Jse6cpRCEEE1
	 5+tGgMphNStdQOukdtCfvPQcy9uEq2CBjC8RsDfhs/1bhGTHYHa7TTkEHC6bin3dvKU8Y
	 jV+iX3uGm+U6Qks/iCJHei0wX2Vum2OQ1v9t5zOHDrNgoiQk1godAVVwygHQUFpZckQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790951391;
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
	bh=78xy/UWAlHL2I2/IxKMgPjqhOQxrjsTtFAN6qFW4W3U=;
	b=ljjpNLnF2mMi1pRLjuFHmUXMu2OoVGs75mud229QfASxpMCNI6E5PetUFGLbp9k1nDy2
	 B7fsC0uYhKZgCWthlvHS8iraGDrsz34OYxeTOqAiee9y4jr7EFy/vLKD16D8L0Mqr8GCZ
	 /YLKMwz274r/Ft//EUmOZpmj6ca0nF5VzfmF9Fi0q37Yv+o7qlF87HWByq4WHwsa3qatc
	 bWyOfLM8Y44LWtc+tfDvHDxQb7oJ/RHSot+GZLwnvYcWq+9zWC/HTX0+GlJcN3o0JKtS9
	 /qNvVbIDAaEFtUY8DZvHgh6F1GnC9Qu8x8SDfuTqsOsmJzWCsFJEYW97Hth3uVimK/A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=MW4hCntv;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790951391;
	bh=78xy/UWAlHL2I2/IxKMgPjqhOQxrjsTtFAN6qFW4W3U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ROd8ZsGngwicPswsvduqyQfj6//WrOxT7Z0/RkHHvOKxsWdrs+fXLLJ3buXYIWyUo
	 0uQgUkb+V2W1hLhTI/E6SPbPesNZ4Ee+p2FLw9C4dephh8CtnbKucg+WjdaHCcsd9U
	 YdEDKdC6FSRL8r/Hi8xtaC4tyfRllhPRMhB/m9MKhxEvKZp2FmtftqOR0PKE+jClIt
	 SybWWeOQh4Np+Rx6+ZTdks3o4O1vfQfF8mKaSlZtIVyfUQCQO/I/uP6mSPtt6ze0sF
	 C9KocMjVQgMgDP8y/N4uGtjKQxuyL24NOtOHK7dbPHOkskG61mC4kVvuycZYIzEeuy
	 XBBXY8kTV2pDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6EED98116F;
	Fri,  2 Oct 2026 14:29:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 57E5A282
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:29:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 489CA8116F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:29:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t1oJTDoxckSd for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 14:29:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7989C81130
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790951389;
 b=jFndyg3WDVUyP0sZoqQzEkwUG8IhpDYLKgVcBN2pyg2OS5u176BjhALNoYghbriJF0JM
 VI59sOVkn6v/tr/Vc0omeSxHSqmcFJ4eaywGrEhUsejAvly7LsonZIv0PBQp59co7VPJi
 v+5FHoazpNJw77IxbkHCOiNyB+M7eYrlDXLdgfN1tHieIrsOszvAhvhiBY+EV0GkmOir2
 qDvRmFYeCYFwRV19s1x6bfTrJIJPcFncZVH40a3ApsoX2ZLhCUZhwAIBXeC7Qu62fp5yu
 4IwV6mbYygXlgh4PyuZSJvuPw+teddEAw3mh6rzfHcYeo4NcaD0aUa9uJwHObp9QLow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790951389;
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
 bh=78xy/UWAlHL2I2/IxKMgPjqhOQxrjsTtFAN6qFW4W3U=;
 b=FxRS684HrgsvrcXjI2kuxoVr3liNNijvMuBgp8UV4U+jN5lXaz4hVe/HjcA2jbLtwnFo
 sPmK0sY2G5JMqWs0TCdeCYnRSUR0D28nLGUc5Px9KYxTNlpQCDJ5s86K35/AjGkF97UXp
 WPFtNG4o4QkElRJXFo+LCZ9rCqqxMa82Qsw4tlZpHRAl8DeCpHmY2d7DY7rewfdF5/DdS
 Pc6c9e5yarrsvHx+flnK5yMtEipp4jgxsunh/YIDd5Ko5WcU4tLBFkLcgXtEP3P1D49EK
 0RZpX9UlY6Oez8o1K9EG1EYPXYBKBO8qh/iQIi1GHlS86AznlZGasQxsDV3hy3J2bJQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=MW4hCntv; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=MW4hCntv
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7989C81130
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:29:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNyS03mJHWkpZt2C2atCjHd+k6NA8u47cNEAAypTxWUFLQmiKWzgluRPch2JbuJrEO0CLW3HcO/L33BTREQLTmFzOjac+rvs4xxgISVKOwotaDsDZZ/4tWg50xspr3xyqgG+960xLLTlEaQvWgtd2TRvrv0vb/xi32Zd/kW3nqRZ0dENtaddGiuz9x+lDLr5sYkcycPRaLNYJdqOWafpXo5Z6NlZWeQeUxEvp5kK/O6iBAK7459crp2Rc7LAYbi1hqtdF7PHxdsVakW1LJ4Qh68lV041Gs72Dlhziw+3YoQ7s3V+phE7EgnJNttwy70zzhH85TscUUw9jXXCLqIAWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78xy/UWAlHL2I2/IxKMgPjqhOQxrjsTtFAN6qFW4W3U=;
 b=Bz8qqm7KE69lIIJD045MJKDaPLjn/6iJwAvU80/5+seRUWmdUgL6xs4QLOsB6ED1t4d5fA3EdoPk+/07eRKhD7c9rRGM9v+FKMkcSMQY+Snf9ovsW8oMBI7dlaDuc0050gGsTZ7VQgucR0Py55SS8mgr11R1+DwNbx69P0+QQ60d6fsNEklVvEKSQSE/5JvEgc79iBFPwIzk6iZ9t+cOCDH3r6BXsy1sjQaB0CgSzTw8m+xgEPr9QFImcIB5SQp/CpedExagYNQd2Q+Pi2U7ls3TIGQvvMwLA8NkqywPnhfzgkED/cCAJaC7aOq2/SN0H+GfasupOTfI3bs40RsLzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78xy/UWAlHL2I2/IxKMgPjqhOQxrjsTtFAN6qFW4W3U=;
 b=MW4hCntvmjwmAjPK0DBKxDU70u/f9H2d98i/BdEw01mr04+p54/MRwnE1Lz8Zq6Iy12LwYg1VmNvUnvNXG49LzPQ7ZhiqaBNuc0P82N8CIp23TgZHigOWR2Km2EU4IqfsFgt1F2V+Nhd+4FWoYJrwXDWj2NgCqvmzHlGI69bSB0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS8PR04MB7784.eurprd04.prod.outlook.com (2603:10a6:20b:2ae::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 2 Oct
 2026 14:29:44 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0451.022; Fri, 2 Oct 2026
 14:29:44 +0000
Message-ID: <65a6d93e-c34c-4363-bb8b-125476d91839@cherry.de>
Date: Fri, 2 Oct 2026 16:29:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: dts: rockchip: refactor items from Orange Pi
 5/b to prep for Pro
To: Dennis Gilmore <dennis@ausil.us>, u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Alexey Charkov <alchark@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20261002031334.3285687-1-dennis@ausil.us>
 <20261002031334.3285687-4-dennis@ausil.us>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261002031334.3285687-4-dennis@ausil.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0029.eurprd09.prod.outlook.com
 (2603:10a6:802:1::18) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS8PR04MB7784:EE_
X-MS-Office365-Filtering-Correlation-Id: 62913c59-2a94-4db8-f763-08df20919a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|5023799004|11063799006|4143699003|3023799007|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6twMK0J/e8+Oms+hW463YOqkNvg0CgMQU5F8RUtsy9mQW9nc90dQ+wpQhjvtnpHcgSANn1IHSFqKX9Ui+yzD/XDvF+FDX4OoxK36U2NB2xf5cSVwGEQPSvUL4MudJkE/bFVwZD6Ut1QPNJzEbbHpOr4a79SquMuhkrUpfvvZD+1aeeLbQr0XqTvg8wUJWjgT02DnbY3XrERtNhJXws93A4y58tDwWyOUSWG8oAGAz724CommPIkqyEb2GxMycR6nmj4t6YSRVp+bi1RV3SZPq+8MI3I3BSJ9XQ2K85vWCWmX7K0MMnJqGU9atsWE0TufPyrN+ZMDimVDai8NuvDKofKCg1pYBKfElcdVnAzynyfTTCaHpT6InFXIBMKLwsXTPbhe9yiTEtrmlT3py4KfVJYJImNjxrE7UacfZrm7yYX0r5q0jNcDwPlZGobd1vh8NWMDjVLikdiwk7lvgwMKIfGFLOeb6gWZN4tOdgyF+BP+tbvMGxKPhofgvi0f8DOdaKAm8xJVZfid8wUwCcksGOh1yTBsdfXosYKUaGqCccd75oA3dmQlDwT3MALYODeTydURgUvH0lpsn0IxL+UJzq8qaOZUVweMUOp5EQdNIej0oKDQNweEYlyFJ2h7gRg6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(5023799004)(11063799006)(4143699003)(3023799007)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEp0U3NkOUV2VUl4RGlJTk9HUksyQ0lncGs4WHVFYUcvdVBzWHJjbHpKNWZ4?=
 =?utf-8?B?bERtRVRDa0hOWFdtcno4aGRkQlJHTTIwalNsMVlNSkVQbjZyRU1YbWFORlhx?=
 =?utf-8?B?bHFFc3RGK3BEczVyaU9lVHV5MnVPckpHR05sb2lPME9hSy8rWU9USUdhc3JT?=
 =?utf-8?B?UzU2N0dZdzY1ZWJDNW5WMUVNZlR0aDc2K0RhaHF4c2pCZStGejZFOTNIbVlR?=
 =?utf-8?B?WHc1c0NxUGFvZnB3cWZ4MGg4UkFSSDRlQmdZQjV5TjlLbkdld0JmbFlHeTd4?=
 =?utf-8?B?K3M5OTR5dUM0Z2ZURUhRRkFzaHdWL2VzVmNWTnhHWTNJQU9JSEpFSWZGUldB?=
 =?utf-8?B?YmJZSGdsSDJQR21TWlV0OG9FY3lTVXVkdTl0UzVNZk5rWTFRdjQ2K3p6MDBm?=
 =?utf-8?B?ZjhHVG02ckt1QUdrN3hTWmVhSVZpZ25IMGsvaVUzVjRZdDNoYzJyQS9VMmFV?=
 =?utf-8?B?WFZkUWMwamZjamZkcjBlMGFpS1pVL0RCdEp1djd0NjRaUUowWWZxc2pCK01o?=
 =?utf-8?B?VVJzeEdTUW5lbVAzSGo4M091dFBKc01qMUlaM28zRGVBajRjdzlPQ2hjZ0xz?=
 =?utf-8?B?S2dWNThsZEh4U1JFZzBoQ1lCUEpWcXVJRXV0Q3k0VCtxUDduYnBpNTVYM09J?=
 =?utf-8?B?OXRrYzFJQXJhcjc1SUFUZ2JqUm16dmlsZ0ZGT29zZ3NpR1JkblRqaUVSckdF?=
 =?utf-8?B?YllRSjFPR29PU00xNVNuWGdYMGpmbWlRN3M0UmdmNS91T2dWcHFpM1Jab1Fk?=
 =?utf-8?B?ZWxXR1l1KzBaTmg5ZUVuOUc1NHQ4dGxuY01UcE0zYmxORURNSUM1eEVqY0kx?=
 =?utf-8?B?SjFJWXNQZ1BYT0IxdlRRdkFlOWpoemdYYkh6dDFiWmY2ZEpCcVlNVU9tSDFE?=
 =?utf-8?B?c3VoaEtBTkR2Y0kyc2dib2dNZVJSSlAvdENkVE03aUNoMzNPYkYvYnRLWVdG?=
 =?utf-8?B?UnAvUnJKR3ZnRkxRTmNOMjlBVTlxNTBiTGNCZGd6WmdoNjd3U2Z3ZExzY3h0?=
 =?utf-8?B?TXE3c0MvZVM0SWRaZjk3bVlFWnl6UkpIK0NZT0E5RXdTKzZOOHhkMzJRWVBw?=
 =?utf-8?B?RmlSSWFmUTdJK3NxWG0xY0ZJWHkyTFFPdzZVTkVjcStKLzFxcXF4NXg3Z0RK?=
 =?utf-8?B?UnpXbmhkTkQwUHRNemtnRWdadFlyYlJjVlEra1JaQ0s0WVVmWThleklocHI1?=
 =?utf-8?B?dURIVWlOSGlQQktXY2toL2N6Uk9TbjhxWEUrN01iY1E1MUVnRXNnYlZrWlJE?=
 =?utf-8?B?c096QUJrZHdsR2hrRlhyaDNJTUNOZk9RWWYvWTZUUnR3VXlJbTEzRXlhbVJ0?=
 =?utf-8?B?c1UvZzMyZlJUQmt5Q2daK1NkM2NQWklndjh5UVhrUjcvOTUxQTFNNWgzRFdT?=
 =?utf-8?B?VDJiZTFkYjExSjNkNlNmejQvdVJOeVcxM1dUQUVtU2kzOCtUUnFVNVRreS9V?=
 =?utf-8?B?OGRsQ3FGTDRSYTE2VGRvQkR4QXlBODFhWlRXWGxONVVtQ1g0aVBkeDMzVWhD?=
 =?utf-8?B?V294bTNMUVJramN5ZnhadVdQNnVyeGhSV0V4bkY1WXpUdm41Yko5UGh1RHV5?=
 =?utf-8?B?YlZIWXFVa1RFUDJWSFV5cytwZkQyWC8ycnpxU3Q0YlA4WUdRZ3RxbndUN0Fj?=
 =?utf-8?B?Z25uazVCUmVmaHdtdFFDRy9aZVM1eUdHQytKNjlZMGJ2UktyUXljd2Z2U2pO?=
 =?utf-8?B?bFhGY3cwMHhMbU5IVER2MUlqUU15OGRoWFdXVGlQUkRhWE1jWHVhS2trRElm?=
 =?utf-8?B?TVU5bjA4dUZZOGhucldlNTExUUsycWZFQ3hnUEVEQjZWTTBQbms1WWhVL1ZD?=
 =?utf-8?B?YjZ1NThPdEdoQUhhc0FuVldSTjMrRzl2bUhBWEVHdC9hbWJxd05RNVdYRkRr?=
 =?utf-8?B?NlJIbzhHUmx6Z1Fya3FGT3dNQm9BWjN2bFdWK3FrWWhpcEZnSkh6L2ZOOFow?=
 =?utf-8?B?anJ2eDByWkswZ29hVDFVWFJhWHIrTmR0OTNEb0RJZWxyMEtSZmtIdFFFWjRE?=
 =?utf-8?B?TUUwbDA1MjArWEZjMlFnR2pQVHUzK3dOc2loZ1RFM29IdC9PNEppTFB6N0Q4?=
 =?utf-8?B?cWhabkYvYUx2Y3FlQkhOVXNiSmE4Z0xsMEFsNktlNUh0T0JIZGxKN1FqYVV2?=
 =?utf-8?B?aDRxQzhZMTlRZWJPek5PS3JoUlVVNy9LV1RFS2NOMmc1K2s0Vi9xRDlEbE03?=
 =?utf-8?B?U0ZZUzR0cm84dEk1eVl0WTMxK2dxV2tYYjNzUU5xZXpnN2dhUGFSdEs4OWdy?=
 =?utf-8?B?bW9xNXNROEJmOGpGNkp5VHNKNXI0YVRaRW82U1YxZXppQk9BcEVYcGV2U1Fh?=
 =?utf-8?B?d0R2OWFDTGJidVdUbm1TYWMvTDBqUlM2R0JtZG1mL0QzMVoveWlOZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 62913c59-2a94-4db8-f763-08df20919a4c
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 14:29:44.2554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7cfZOtwoDx9IR1HiXt7BHzgh+6tI9k01jAE2KnOEHGvZ1FW5kPn6CVGT2Smu2VwoSmwpJw06c2LN3bLcX4+QuOhJXC+cCxiSKEcSlxkv9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7784
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

Hi Dennis,

On 10/2/26 5:13 AM, Dennis Gilmore wrote:
> The Orange Pi 5 Pro uses the same SoC and base as the Orange Pi 5 and
> Orange Pi 5B but has had sound, USB, and leds wired up differently. The
> 5 and 5B boards use gmac for ethernet where the Pro has a PCIe attached
> NIC.
> 
> Move the 5/5B-specific bits (analog-sound/es8388, FUSB302 Type-C,
> gmac1, pwm-leds, i2s1_8ch routing, USB role-switch plumbing) out of
> rk3588s-orangepi-5.dtsi into a new rk3588s-orangepi-5-5b.dtsi that is
> included by both 5 and 5B.
> 
> The RK806 PLDO1 and PLDO2 outputs are wired differently between the
> 5/5B and the Pro (PLDO1/PLDO2 are swapped), so label the PMIC node
> rk806 in the base dtsi, drop pldo-reg1/pldo-reg2 from it, and define
> them via a &rk806 regulators augmentation in rk3588s-orangepi-5-5b.dtsi.
> The Pro will supply its own mapping.
> 
> Signed-off-by: Dennis Gilmore <dennis@ausil.us>
> Reviewed-by: Alexey Charkov <alchark@gmail.com>
> Link: https://patch.msgid.link/20260511025352.106126-4-dennis@ausil.us
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> 
> [ upstream commit: b7a806c1c35eef2ddd8145e818427f285feb2413 ]
> 
> (cherry picked from commit 42705bdffa484c64ceec9b196156d62af36940f8)
> Signed-off-by: Dennis Gilmore <dennis@ausil.us>

Same remark as for the previous patch wrt line address in hunks (nothing 
for you to do).

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
