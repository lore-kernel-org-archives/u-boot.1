Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B01DCA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 13:29:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C381460665;
	Mon, 12 Oct 2026 13:29:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nSjY8RArLeUH; Mon, 12 Oct 2026 13:29:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 892CC60675
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791811762;
	b=i6j4OozoSR0OxN0gE5ud6X0J/8XzIAWnZmV+LRpBaXfuBg+kzGp+ysnnM5am5pJK1ac2
	 ICAsowTU1JekMUqoB6AY9CcumqpzPCCfmsen5PCAW4BEzPMn1VCs4G4VCAgfGmAhXjKl8
	 8cLibwPP3lxUwwokytVTbUsZydSxsSKrQ95KQi6p+MJi9n6yqafDwAro3p5+miagVFlDE
	 7ZEOaeODplw3+S1B3aVD/xhZ48hh6ryLja6VjIYQ6YGv5apVkTD/W15wh8AjGJEaT/Tng
	 ew9QHDxXHS0OGCjBC7xwvlz93SFixiGIR9vfvfjqjczfRQuZsQ2HSLShw/DAxqjmATw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791811762;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	bh=a0d5wDKZ4ttYj/xpg73vaHlVIKm/CvHrVlSzhgnDGcI=;
	b=U0dtMJd1Jd3esza1Oea/B9V+OrdkQXB6lebHHTSm1qpeo/eRYDHlrKCfzcL34EpJvOZw
	 iYKlbeZZdvUbg3XgXaEMckPpQv/ZDFxjjUZpfiLbKz/rFGBvRe2CBaE8XiqYwVIDkiwCI
	 YloNi5HMc4YBrclaJsBtXrGgKA9h7WpOzWNyhOSCnNgZglW4ktWQ5+kmKtLJ8dBedy7e/
	 9ab+qORXOl6yUihovY71sruPFGHYSM97T8Tf8LpQHXggb8lJ1nyH/I6tCldGLN5nPfsFw
	 v5dpwB1pmmIpexxiXBiiIadLl+YPSbzm4h8nQ92gJUa6ykWgGYum4fD2bh9mVZ7Agzg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791811762;
	bh=a0d5wDKZ4ttYj/xpg73vaHlVIKm/CvHrVlSzhgnDGcI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G65ysrO4L6hcA1A3P5z6Y3oaAcOyOcH2opvh/q9lm1CIVtutO50QFXy2BIAhuqGdp
	 srTiGLyWs5rFPgMyDWZGVJoZHWMlcPkqPIKlmBF+m4bVQ0wJqjXEXj4OWZa17EJYZV
	 1I5ZwhAsEQSjdvzCe0QJpE7999xSMA7bISSUU9ljt8DrT0TAgBEtNOAmiczJ/GnXIk
	 AXpBjlPsIizr3KFhjEhKeTd5eYOnWM0XM+VYspmG9BcpBsHOI+S6bLpy62YLx+knPG
	 JSLFEkF2dx4WXmHsQFF9yTVce1Ty9I5ByvCowNUb1FO6oWGw+1QHctg3o/wlO1vDQv
	 4+jZvukcraBeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 892CC60675;
	Mon, 12 Oct 2026 13:29:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C83C105
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:29:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A415401F1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:29:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lJ9rifEDoZ8n for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 13:29:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C9CB6401EF
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791811760;
 b=a+ZVhp33i8uOZgfcE4xrKO0yAFgvOo8MsupJmQeV9VVe+3Id8kf2i4S6iQaYBo+bbYSl
 dvXEOm4i4NKEX7yvFD2wkutcasyzJ7Q3v7pbV8RF+s5cbwkECMgPxdIu/qnrOzVsRlrGC
 KZOtbzqHCFqPLuug10rxOX+4WuQHb2EVNL/Jva9LDGupkH1GbvwdCS1ZVRCyuCqRwKAte
 UU0vN5ItCu0XspVHZUR/4W886ivb5X/P/9cFiXEye5d35zWuYsMncXYq4BimvbrVeCMR0
 aWe7MBha+t+WQ/JlAh0zB8vjsNOn7/si0Ye2aFQ2u7ezKO6pvjh7TZEirECJw5Hed+Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791811760;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
 bh=a0d5wDKZ4ttYj/xpg73vaHlVIKm/CvHrVlSzhgnDGcI=;
 b=hFSryBylWHV1y0KOouaQaXBMez+kEpQTS1JT81FD+41yik2vlypWDBN6KzDGEMxvKLhD
 kfin4cGsZi6XAU6hNN+UbDLbeBMK9smUSelHVGZwGlCgH4Gn/9rGn6+PEddEyrH9jITPh
 caN14qqIJfXSZIjSM0QlntcpMiMiNveMNr1AZ8bacdXVrPUmiNDnyplaDo54HlfHlvuBR
 eq/Dv4mu4hk402UfebyjDlc5xw718DFnXaelYt3eaCBqC0R5q0TnSt3WkbbCHb581IlKC
 rA88Y366gzUunCoAlzOUQ8VgbQY19M2DlomBUrIJN98ui19DRwIihKfk+vj4nDXhmOA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=tfB5SK4Q; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=ludwig.nussel@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=tfB5SK4Q
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C9CB6401EF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:29:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQX6ijEgMkXS/VvqmGOktWjle53OF82eHJfGHe04Aq7LrgJGr42OKV0gs+YdLKfnXuVW4l8de/6hCQMO4pZWedqXzp7TVe3Vpy6hNTm02pb9jWepYiQHFa2OA4WwTRQkdLGS5BER8zOrnJRbpqjRAkFejCZ+VKWtt4Gja1JHWwv4sikXwzQ0TsmrjfLpesLR1MU5IJw0QxiJSwxrVYnGHToTaf9t/VkU1uZN0AQRWSl+rGeXCuHga37GZJ9rcx4QRZs/1OUT+fLprFKUqMAXVaBCqDWUwHmOHv89kQuRcXoSRemQ01t65X5YNvaqITRc9QnXRRckFs7E9sXf+xuLbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0d5wDKZ4ttYj/xpg73vaHlVIKm/CvHrVlSzhgnDGcI=;
 b=yVSmceLhnhAaDO+ZhTjvJ1EPGnVprYcG4HHFKph/SsmOG4T8Xoxf3AwPS6KvtmnXNX+ocBGMB/ATUh/rw/qdpRLKWVMSYWlbkrrNoxduj+eS0GkzrkHz8Bwd+GlJRZCiJYWtL8pzX+Y6HNs54++E2Wbc97tNgpG/Rjc7Fxps78pWapJa5aF05kMPW3S2C4t9q+uz4bsnpRnl2HWaNWCdTQHWwcpByMXx95KJe3J5u3eCNsX9JZmuvjjFt1/qhLTxNnoGSpwrWxz6h01gjckVw6DANX/9E5VjDSydqU3od/gN99/82+pGb+ONqT+TEMj53OThSjO9vB94aiHNETI9wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0d5wDKZ4ttYj/xpg73vaHlVIKm/CvHrVlSzhgnDGcI=;
 b=tfB5SK4Q6FfPzJ+usBdyybCf0O+Q8qGbRI41obCMIhPIT//i4zAAvIG2e3deLyI0dj/muXnFCl2uj8aPlpx9XUTC3zR3BOovTCJxMd+c76vAvlheUKwgzWF4UuN7J9g0NTd6GBikJRmSktSPKFHD81kzPlVH4zxpmcEglYCD+A5klg8lpzphCCja99wPDdiZKbi63U7/RA1XzzpmkqIYKhkHy6aZAcj4vWSX924Wpkujo3kKO2FoFWWTh86LLoK7GpZOFHCwATWJI3KklE/jVZgtlxIoyucXY3hbOgOs6T00lng2hC/kuFjRNsgRpxX5U1WlRt0uiL9s5u4mSFmi+w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by PA2PR10MB8961.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:415::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 13:29:14 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%6]) with mapi id 15.21.0472.015; Mon, 12 Oct 2026
 13:29:14 +0000
Message-ID: <0ef4b0d7-b436-4afc-926a-d7eb942a9edb@siemens.com>
Date: Mon, 12 Oct 2026 15:29:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [0/2] image-fit-sig: close the image-signature fail-open gate
To: Simon Glass <sjg@chromium.org>, 0xiviel@gmail.com
Cc: u-boot@lists.u-boot-project.org
References: <20260925072741.1966573-1-0xiviel@gmail.com>
 <CAFLszTiXz5V5HhH2eVEVLp_JSMUetcdhCpFD21=5rauV34w_Pg@mail.gmail.com>
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <CAFLszTiXz5V5HhH2eVEVLp_JSMUetcdhCpFD21=5rauV34w_Pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0329.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::34) To DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5019:EE_|PA2PR10MB8961:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f88e483-e506-4443-8433-08df2864cec8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|4143699003|11063799006|55112099003|56012099006|22082099003|18002099003|6133799003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: mw6H4mDXC+vG0p1A02WXkEDh6UXSBEh2HzJcMGeLpqYHC/KXNly0ke59VHUR9bVRk0HFisaEihOq3KNjRvaTB3aH9HcYnliNc19N/n0DP7xGMEFAfoBLYqCE2d8kqeS0YWbZCCCkeddHDoHrESjS+qC4koVr3gpy+61iLkNobZPJTlzESFXXDWWzIiKvJsmvc3/bDa+lKFhUyFVZDiHj5D1QVuyumlJoXm4C8Do5w7JgY+JFXW40dmMm3LYMrj/oho1OwT9LxLkztseBal43qU9//BfIry3lv/b980NX1YzD1PNIqAhWs//QSDFLp9RtKmnIZhSGNVGC10YNQWkJ1x303HNFzZfmKhI/C2VaCMXUydc9gT6W2/N5KgcxmDP7qVb4UWDzFiX01y0/1s7W0SV8AVo0o46wUz/4m968azNo0YwddcaWnajJv6FK/zyF8Tsks/D2jFXGJZUhPKbds1+DGRkbBYjwN+h+n1cI1SIjpwdIuG7PEwp6o3rhGP7zov9MomsK0J3LVBNaMuOgYjX5qVEeK1t1QBwVAtbDCrNX2dc1hx+9dhYU6mIViTAaqAmXZT4cAOTRm4Iqg8Jrr2Gnf6y5DwKbPzF/mEd8Bgw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(11063799006)(55112099003)(56012099006)(22082099003)(18002099003)(6133799003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z29jTWQ4b04xeldMcll3T0ttSnByVUlITlI1a25NUHRLWU5VMzNkRlJnY1ZY?=
 =?utf-8?B?RVloNGFrYXJ5aGhUKzBQbkpUN21kVzc4NnY1cHVFUlQ4QXNwQXl2MlVtUDlC?=
 =?utf-8?B?MzdMeUp5OG5FV2ZES2ZPZ09xdHVialJTOHJkZmVHOERNME1DTDRQSkdVOEZo?=
 =?utf-8?B?bzQ3VlorQjMvNHd2eWZyYlhTU0laNzc0YmpNZDVRSXUzbSs0SG14QWlPM3F4?=
 =?utf-8?B?ZTJkZStFZWxYd3AwbjFiTnRmUHJnSUVyVUVmOG9pc0UxUmpIOW9qS1FZd0kr?=
 =?utf-8?B?a0tBNHBRYzNDYktYbVZ2dmU0b1hWazNnV0lKVVAzbDVha3Z0eE9VWWVveWRT?=
 =?utf-8?B?OWt2UUFYb2xpS3dLMnlaRHBuVFJHcTVBWFZzdW5Ob2NrUFBNbG56VmIrMGZz?=
 =?utf-8?B?cmowUlhxZHJ1ZGh6WThLakNEdGs2cE8xUHBxU3FGd0F3RmYzak4rRThqOEJo?=
 =?utf-8?B?MllZMzAvUWUvMkxhK3c3eHovWTJWTXhlYWJUcnFWRUpaU0hhcWY2MEorcXdP?=
 =?utf-8?B?WWVNMmtqa1dpK29VWFZ0eEpFMWdycmhHcVpTNjd4VzNCYzg3bGIzaWQrQWlq?=
 =?utf-8?B?Y0ZJcU9FQitsSTdZR1BLQTZvSFlOdkQvWjErSkErbUN6VFAvWXVEeitSQXpT?=
 =?utf-8?B?LzNyWVIwMGFFcWRYV2kwTnJoT1ZFdDdrY3ZNbW5rRi9qUXNRdzdhQ1dxS2wr?=
 =?utf-8?B?eVRxK0VwbVc5cWhtZGpiZ3ozYklVeG4rOUFnNVg4cXUxU2dDU3FZeEE3SC9J?=
 =?utf-8?B?bVVCVEZ0Nm5vaHU1WlgrTmFkcjYzeURzMUlHaTBUVHMvRzZVaDUzSi82UmRt?=
 =?utf-8?B?Ylpxdk11aU5QUnpNR2lnQmcySkF5K2pLbURYc1hFbWlBeEtxaFZEQzBMZHdx?=
 =?utf-8?B?OE5xMUNhaE9IbGRRZEw3Z0VVditEeG1aaStlTHRzeWE0OUk3L00wRXJEUGI1?=
 =?utf-8?B?ZWdoRDUrNzZJazljUFY4SW5NejJYaU9NNnJIQ1Y3N1V3T3RDMVArNVlMdkFn?=
 =?utf-8?B?a3BzN1B2ZnB3dTBEc0NuL1Q4aExBcE16Q0dBeis5NGhtc2JxREVxNjdNd1Nv?=
 =?utf-8?B?cHZJQ0RtdWc0aXlBU0l1RzBnWmJ0STlrKzZKekh3WndGS0FBNUR1YmFBWWMy?=
 =?utf-8?B?QjFCMWJ0ZWJGNDAzc3BRN2tUbmtZdkh3WFF6Q1I1VGZmUGFINDN4dzZ6OGty?=
 =?utf-8?B?bjNiSmp3N2xiSUZKeTZwWXpWL01yWVdRVUU5UEN0VVhDSnJydlVrb0Q5eDYw?=
 =?utf-8?B?MGVnU0J3NUc4b1JzdzEvems4SVdjakpRcnhQb3dGdC91NzZoM0lQaHhpaDNm?=
 =?utf-8?B?YzF6eVhsQVQzaHROalBGL2FUWDJsd1F1Ynp4SjE4TFA5MWdaVFdTU2x6Z0o5?=
 =?utf-8?B?eDlCcE5JNGkyTGdvbWRoeHlqdHlWSUg5YWgwakRvTHBZVDZxOGs3QTJWdEdi?=
 =?utf-8?B?cFFSdVZiZjhaUWFqZlk2RDE5dDM3SDNzUGFielEwVzFpbDNuRWtsdXJCWkRO?=
 =?utf-8?B?TVdZUXBkUzlucWFGeUtnL1RnUXJxK24zVURWcE1mUHFpUkk2d3QxQWFZL212?=
 =?utf-8?B?Q2hLczk3VnF5SUlWUHNzZmFGTWw4U1NPSFB3WmJlUVY0Y0pLcUNRb1hnNTBs?=
 =?utf-8?B?OFFtQmlGNWFvUkVyL2tkWGtDUVZYb1hpTDVDdXoyRU5TWEdjTzNIZnpaMWZX?=
 =?utf-8?B?YUlzdno1VWZjY3F3RTVJMkdzbjJycFZlbXF0YThWb1p2TnRKYUtZN3dYMEh1?=
 =?utf-8?B?SXB1dGdIY0FHMlZBTXFHUkxXbFAxbzFxRHZEOGxtS0ZyM1c1MEVQZlhVZGxv?=
 =?utf-8?B?R01tWWpGOVphbTIzcC9CQUk0SXBMZ1BWS293eEhwK0xvOGVqMGcyazQ3RitV?=
 =?utf-8?B?ZHk2cDltVGN5WktaN2VtVVNtL3haN2pXZXFYSis5alFHR0VZd09IL0xxNkdY?=
 =?utf-8?B?b0tqTGlXQ2MrWEk0em0vZkViVGxTWFFOTENTL3pWT3o4QlA3VmhkQkZGYXJu?=
 =?utf-8?B?aUJUZk15UW0vcnNoK1hGbzRIZTk5SkhGQ1VVTFlCN3J2SlJDbXhLOVkxSW5r?=
 =?utf-8?B?L0tzclpQbUw1YnZQMHhnei8zRnZ3UU5aTFBjL0hFczY1RlhZYzBVOUlDTlI1?=
 =?utf-8?B?aHV5a2hXSWs0cXRndTBWdi9tNHdNbmIxZ09OK1FQKzlBS0VNRkoyMTczcGVG?=
 =?utf-8?B?dC9pUGhrSmhzM21mQTN4K2tmbFZNLzhZamZVQ0VlZzlkeFIxMnVlUzgwZkov?=
 =?utf-8?B?LzdlenFXcVVPV3lMVjd4cnFGNmZHVTMwNVJ4T0p5c1l6QXJaRzAvbVFjd09M?=
 =?utf-8?B?cjdBV2JSUGpUSVEvd3lwWTFRQWZlaEE0UUpJWk40b3lBTTJsWkwvWXdGR2NQ?=
 =?utf-8?Q?gbGMpIEneFWdbR4k=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f88e483-e506-4443-8433-08df2864cec8
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 13:29:14.3241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzgnuTpyKtVSQbRGKSjTmqxpm0r7GvCRj1rUTJes5Y/P/LtxdHAnQhYjZUrLM42OoYSQ6UtUwbjDgjkrc8Ix40mrO9JI/G1aTOaW+Rl+RjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8961
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

On 10/1/26 18:14, Simon Glass wrote:
> On 2026-09-25T07:27:39, Eva Crystal <0xiviel@gmail.com> wrote:
> 
>> Ludwig Nussel's "Improve FIT signature handling" closes the same fail-open
>> condition on the configuration gate with FIT_REQUIRE_CONFIG_SIGS. It does
>> not touch the image gate, which has its own early return in a different
>> function. This series adds the matching option for that gate,
>> FIT_REQUIRE_IMAGE_SIGS, along with SPL_FIT_REQUIRE_IMAGE_SIGS, both
>> defaulting to n
> 
> This leaves two options (four, counting SPL) for what a board
> maintainer sees as one decision: 'this board requires signed FITs'. I
> cannot think of a sensible setup where one gate fails closed while the
> other stays open, so a board that enables only one is probably wrong
> without knowing it. Please can you work with Ludwig so that a single
> option controls both gates, perhaps his FIT_REQUIRE_CONFIG_SIGS
> renamed to something broader? The easiest way may be for this patch to
> go into his series. What do you think?

IIUC the config signature verification logic includes the image hashes 
and does run the image verification logic to check the hashes as well. 
So if we enforce config signatures, enforcing image signatures as well 
would be redundant and surprising.

So the code would have to enforce config signatures and disable checking 
image signatures when loading images via the config path. At the same 
time it has to enforce image signatures when loading images directly, 
without going through the config loading. (Or don't allow direct image 
loading when enforcing config signatures).

At this point I cannot put the effort to implement that extra logic 
though. I can remove the config sig enforcement stuff from my series if 
someone want's to do it though.

Not sure it makes sense to invest too much here anyway.
Time would be better spent on 
https://github.com/open-source-firmware/flat-image-tree/pull/44 to pave 
the way for whole-fit signing in a simpler way IMO.

cu
Ludwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com

