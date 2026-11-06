Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9BF606A330
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 18:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Onyt7jZC;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=T9Jkt8Y8;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=T9Jkt8Y8
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 480864091C;
	Fri,  6 Nov 2026 18:07:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T2-J-x7U85ne; Fri,  6 Nov 2026 18:07:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 683254092A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793988448;
	b=sXGqirE4iH86raO4gYVktnl4+SWqDDDgLlpS3uqni81ZKPmoA8Y3r7L7M4Qxca9aJ9oG
	 EpggKWvT39g+azpQ/ofETjkjOewEhiV7i3Aa5DethAAQdr92ZL6glu5iNPCWokNJu2DSx
	 3TkDGyQ4aI9L7oNFmopEg5wZIMIVQuHTLi6zoML5LW3MEkl5uob/yQUWwxxs3b25CaEPv
	 X1ufdqTKb88H6V+hJHHzo7kXwF9+CPOgN+1/2rtY2QqV0DzJRLjQNAjMF6DqN9XJqt8ga
	 XLc+arGPk73NhfHRQiAzm1jZxtu8jJPHL4TM0N0tfX/VKrx8IWWZM4C419lNmU3+oRw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793988448;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:From:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 x-checkrecipientrouted:NoDisclaimer:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Wv7/4+s11MO1qOtZ0LrO7sDCLOLdp0AyQGfjb/KFGpw=;
	b=GbA39lm0jT7LBeaUp21qrZKZgixg35XCBpxwGk5UGHQ5FRPR1hwROka7lVGPjJhzcdJk
	 vV2yti4I6x6LCLTvLlmP9ERzLxjfK0c1ikiez2pnz9rlKgM8Q7PsZKeGbdPQ/xeNZPd/f
	 7EXcc4qM8JcTv5DmmNRtquP/LDGGHCQ8uRKsidcb+/txZnt7s8q03CZ4Il4l63AkKWxSi
	 mmLrdhDLjciHF2a3xrscEJFe1hrpraa/aVgDKOCXav4sO9kc7pb0KIulNxc0494m3SXcd
	 5iIfh2VRC5E3BbqlvIDqzL89nQRyQRyBrwOpEd1VZ5Vd1YcPq7Xv8uOH9evaJYyjNxA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=T9Jkt8Y8;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=T9Jkt8Y8;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793988448;
	bh=Wv7/4+s11MO1qOtZ0LrO7sDCLOLdp0AyQGfjb/KFGpw=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Onyt7jZCKCvltAgbYpPT6+Qk8YkNRsnPgWkFOqLsYlUIZ2FGy0W2jfFrrLXXjR23h
	 x0xHT40A8VOPT57uZvgEY3+esLC578jM9lUJzn3qhciXa6Y7w+vS+TzkZtFunnDflq
	 GcCCRsVnt+iU29h2O0NRB8M7+mtJYj2fv8yMaSiZmoA9zTlh0FjhWjtndO1nd7w7U5
	 r+AEdHPtAZyGJItgDxGFZIK7MLRCsmmAQUjazizVDQV2a1Cg14wkAPcKt8+qiP8nlz
	 IMIj2wNI0cRJc6cx+Ht9pJ4VAOI4xWh6aS2o4Lp2A19kH7B0+5ASbsE/gGKPDy1rbT
	 iJrwK0U+rk7zA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 683254092A;
	Fri,  6 Nov 2026 18:07:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B8F8A2AC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:07:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AA4C64092A
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:07:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mOfcSx4IkOkO for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 18:07:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1D97B4091C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=T9Jkt8Y8; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=T9Jkt8Y8
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1D97B4091C
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wv7/4+s11MO1qOtZ0LrO7sDCLOLdp0AyQGfjb/KFGpw=;
 b=T9Jkt8Y8QrnH/xxGLs2oheoDUl2NbGtHZAQfHNd+fOqMymFcWnkOl6h8wHmqcgiu+PC9qdBYx4Ytir52tM6aJW1Ipw/NyPAZStFiA9I+Y60xZmm2SmwtRVaGnuPZW1Am0s0lQmOL7GGZc0W4qMwWQXqFhGSc+nainN9wHnlvKas=
Received: from AM0P190CA0024.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::34)
 by DU5PR08MB10736.eurprd08.prod.outlook.com (2603:10a6:10:522::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 18:07:18 +0000
Received: from DB1PEPF000509F7.eurprd02.prod.outlook.com
 (2603:10a6:208:190:cafe::4b) by AM0P190CA0024.outlook.office365.com
 (2603:10a6:208:190::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 18:07:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F7.mail.protection.outlook.com (10.167.242.153) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 6 Nov 2026 18:07:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wv7/4+s11MO1qOtZ0LrO7sDCLOLdp0AyQGfjb/KFGpw=;
 b=T9Jkt8Y8QrnH/xxGLs2oheoDUl2NbGtHZAQfHNd+fOqMymFcWnkOl6h8wHmqcgiu+PC9qdBYx4Ytir52tM6aJW1Ipw/NyPAZStFiA9I+Y60xZmm2SmwtRVaGnuPZW1Am0s0lQmOL7GGZc0W4qMwWQXqFhGSc+nainN9wHnlvKas=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by GV2PR08MB532009.eurprd08.prod.outlook.com
 (2603:10a6:150:37e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 18:06:44 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 18:06:44 +0000
Message-ID: <f4f230f1-e082-4425-8e32-d4cc77ffea59@arm.com>
Date: Fri, 6 Nov 2026 19:06:43 +0100
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH v1] boot: pxe: support booting PE/COFF EFI applications
To: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
Cc: trini@konsulko.com, alchark@flipper.net, sjg@chromium.org,
 suraj.hanumantkakade@amd.com, u-boot@lists.u-boot-project.org,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, nd@arm.com
References: <20261104163835.1254033-1-sumit.dhami@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104163835.1254033-1-sumit.dhami@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0049.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::9) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|GV2PR08MB532009:EE_|DB1PEPF000509F7:EE_|DU5PR08MB10736:EE_
X-MS-Office365-Filtering-Correlation-Id: 366f8120-e550-49ae-26bb-08df3c30cafa
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|22082099003|6133799003|18002099003|10067099003|56012099006|11063799006|261028144727099003|261022105027099003|261022075727099003|261021123027099003|261026140227099003|261009223027099003|261021121427099003|261022115727099003|261102123227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info-Original: VeVKnX5+AL7oz9UJC3G6VzTV9z1CzAKyRGQlDgPL6dPV0T9lJVbOsysxv1fj4Hye/Tu00Ueq0xc+mkBV50nIMm95NHXKpv+QUO4UPnBRhOihBHvafF/bfwsYaozj+IKYbnPNUQFjAIHBFNFO6uUUqRCcb2OFNpCunl8MoD4ZAavT6yM70ClzFwwBfyj+yHxGkVrI7uPXUqf7RGiGOuxPsDtpUOWlB4NxLZ0BJ3Eg29KsSNIfVURyKrRdR2yULrvrCvATYv89VRT/x12fZiPLBy5UNHka60QQpS86acIXvk/3lIkapSaEA3E4rnHlNKD7i/K+w58V4wma5j88R5r8hdi/OVPFcUMewedXLWDFmm36eMuRMfy7jEjP+yh7LWrhQrikk3iT5ryYM7a9PaoU+ylcnvI8sz/RIRV0BN1bxzxywHjK9SrwgyRa3IjpZbPiDg+hIgnlg9jStgflkBEu9V17a6+BlC0giXTycn7rcWt/VonyAoK/Xm8EqOiVgdSV5RY/5n9O3enAPGaWsGNVFT3iF57cmVmra8QkDvFvJeLpwtkDTnmcB5Gp7v9sbhDhLOWaBfDUNzrx5/sp3A8LdnL2Qt6MeY2gyzy9Q0otonxNBQM9Ee6cZNH+RYrR6G/+
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(22082099003)(6133799003)(18002099003)(10067099003)(56012099006)(11063799006)(261028144727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261026140227099003)(261009223027099003)(261021121427099003)(261022115727099003)(261102123227099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: ECQgdbmf/L6e6qBRwmZdsSjQxImAasg1BcmvNYmNAH0BRJpaZ8rHpOnO43cMAop4WISgDPFg16rg8jbMpJgAg60a2XBo2ivSlbS5fTRUZNDzI9LyhNIpatUvHmjMvmJk4akm1BySC8ekY/Ca8cOymx6t4C+SGX8inkzpw6NOZrqKO4w3rspKI4B8PdG6P9dTXrFd5jr4ETNXlXQNyp0rBOUS+6hsU72MsvJf2HTYiQDzaQB6sO7ZOjMOWgCGR1PMzU+iM3weAk5jOD55Op8ffb+VLg4xCKrp5jkVIa0c7nOmx1TvT31Q1fYedBWgeJvntEwWVdHT4BQlpPihnCKkZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB532009
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 104ba21d-9922-4414-78b8-08df3c30b775
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|14060799003|23010399003|1800799024|35042699022|6133799003|10067099003|22082099003|18002099003|56012099006|11063799006|261009223027099003|261028144727099003|261021123027099003|261022105027099003|261026121527099003|261022115727099003|261021121427099003|261102123227099003|261026140227099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: X8/811mRLvtfwJnJxusXPT9uN+0fMmlAM0acHltxsNAaGD0t5+Jvt5ZwN9AoJDHM8MjibflYbzjA23H+MZVw1r4ujUYIMuAzVbgwimEbRVd3hP02bFblPohyB/doQrtswCsb+fIPXUqvJxQqMgdeY1fXQBXdeS5BmE5/9AjqCsJEEelMZb/PQJ2pv/l696qR0sSQh5Oe7UwoB0rHljRlpX9zoKDOuRnkumGO5k6kZvLHeq9H/65qYkCeveR0dxGpX+grvXCk+Ct6Anw/XTgEh31fhL9WDTX2W4FduKDgkRxohHTw0k39I2QZio6FWoaxv1XZRwIVLIBgR9k9UJDJ6uJjA2aXUV2YW2/j/x07EdibXcANmLtNTmY7MguJ+OBZ3P39N5AXuaLVwRq421yxN/Rhzg25uk5bvzU/KXaikFg/lpYQ7sNNKP1brFE+mMWw3crIX5H/B7BKj4qS2kURalpfYAMaLXYOWznV8Y7l1T5IvjZrVjhsHkleJZq5//VeaShMN+U8lrM9dAECL7jBDAwoFkHCFpaMitqd12i1kRaZqPLXacWUEN1aGGAIc4Z6ant8htR4vAQVe9gPZKMMJhXM7GduLqgIVT/TNN4nkZtnykgfjdYFWM4h4AdEyVmrV+MujsI17d/zQQ2VlKpTZWoyl8t5dPcVvod3Krc09ww=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(14060799003)(23010399003)(1800799024)(35042699022)(6133799003)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(261009223027099003)(261028144727099003)(261021123027099003)(261022105027099003)(261026121527099003)(261022115727099003)(261021121427099003)(261102123227099003)(261026140227099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yrEvrD+nu3+kbU7YepDz34jY5l60hFAxnFfAgb6ikdmgH6/zJuP4br0L/QvwYBRz2KjSdY0t7oYZ7qNhVTH21l+lJJ2MxiBtTrKbM3jeA7Q7cZr9PqUKEHToU13pMXBQCTPJkCWmTJ63dy1b91VB4MwduAnq+jRucpVVQiocBbUBiLH9EnxgFppBq0aXgBvFwhSWs1gDbwX1Z8Hy866R/qNahuUCh8HiVwF0I56YpbMyv6ywwqFaIj1vEpVJR4BKxzWpheEYHy6wUD7ddCReE9xNU+e9seY0+J2iuEEoYYtkYSLvyOoD5aFTGzVOnxc23MjLaD83+G8LRbU4w/dN7E1srsQt9ZxEJfiDm40aGa5Xl8glZf/8YOMNzBsL05hrCRXbWiLx8yty82fqwtWGxxGA3l56WCoA4QAiUvV+8cMJn54MakToqcLyvyOHW8ZW
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 18:07:17.0398 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 366f8120-e550-49ae-26bb-08df3c30cafa
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10736
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>
> PXE assumes that a downloaded image is a Linux Image, uImage, or FIT
> image and dispatches it through bootm, booti, or bootz. However, PXE
> may download an EFI stub kernel or another UEFI application in PE/COFF
> format. These images contain a DOS/PE header instead of the ARM64
> Image magic, so genimg_get_format() reports them as invalid. The
> legacy bootm/booti/bootz path then fails with "Bad Linux ARM64 Image
> magic!".
>
> Detect PE/COFF images downloaded by PXE and execute them with
> efi_binary_run(). Track the downloaded image size so it can be
> validated, and pass the selected device tree blob to the EFI
> application.
>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
> ---
>  boot/pxe_utils.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)

Applied to u-boot-net branch for-main [1], thanks!

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-main

[1/1] boot: pxe: support booting PE/COFF EFI applications
      commit: e0b7e1d9c06fa33657838dda6a93a696b0c90fa9

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>
