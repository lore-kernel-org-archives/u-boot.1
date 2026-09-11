Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392F3C88E50
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 13:17:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2B59808FC;
	Fri, 11 Sep 2026 13:17:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k-nPsFQMRUzy; Fri, 11 Sep 2026 13:17:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2444B809BD
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789132674;
	b=jxWc+z2KISB7+NvjqMAAgxGGVR5TpX1iz+Zsn5+SVzv4F5ob7r88jbW4WfJAJBldYzA5
	 MQQUGavbHu7P2b8sH2XByrJWi1RrRMgbff0w1p2bTJRZa/gYtXMiZxVETviNKRDKMATxg
	 ZlS+uorAA7xoJ60lsQMqZJniH+XWg7XZ827kUnly3KW/HXR4T1aL3RlCczwZNnjis0Hyu
	 Up3l9LEIr7wP+qh8liWMgoKtGHhLlqqwah2JWvlmmB/UucHFW3l7KM2gZFfvHoic+BZfT
	 kDh/8HIyVNSX0hmeMOA18LdfQfL3h4pXMzmlInb1TTReIl5ISO9a4Q0+PeffXY80IlQ==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789132674;
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
	bh=oZEkpTM+cIihJF2/Dfe6drRutsyAnsdmACivkQCNgPU=;
	b=KwiwGWZ9q2IGftUMMCkmR+k16hx99LLkVAygZskSJkLa+BeE16IcVz8dTOz2BlSKHJ3o
	 BpjPnZrYWmMKrJ0C1qUa1ttMMAg2XTzTvdJg8X0iqAYJWopYr5dQbAnP3C5cc6q2TwZUq
	 fTjz9PPRkO0UaYHnzz8lfud3qEMmpniExsg0eM+KDN1vNPSsa1WqRDnV2t85gMQC6yGxg
	 3UZ7fiLTUDyOG5XzOgHObaCU7lYax6DaOVIMGKPZ+w/v0wlE2+5pskoswgFgb++7+nP1N
	 SD7acIWpzsp06LDAB9jO31VrmQfxaQtcJbf8NklCGy7AsWnvVCwKpmXH5X5hvbLqnpw==
ARC-Authentication-Results: i=4; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789132674;
	bh=oZEkpTM+cIihJF2/Dfe6drRutsyAnsdmACivkQCNgPU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=leO8t2Qxcnh5ZgYJkUar9kowkOZaJyYX8hEFa2NT6YyHH37AJgRMxLLi3y5/koVrD
	 YOixUB4zbnlLY3tSqffkobskP876hbyBPe4ZDBF2/50L3zShe7g8hiKUXSDE8uXwmS
	 RCsPzMQiQr+LJ9qmyl5CZrFyeHqlkZ8S4b54zLQrgfy+Fnn0E4+9WO9h4yGSxd31ri
	 EZVaTRegZujeNUtZqT7SMJoxxMsRSQ8O1Tigc5L1p8nqqNAWHtjyJi9WpFG3djtlbh
	 N8GIliC3tlgV5HrsNfKHrxTIQDgSG274GZcUt8kWxN0ivcnxCg2RDftmUeZGucmfw6
	 IL/7ADoM21tWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2444B809BD;
	Fri, 11 Sep 2026 13:17:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BC7312E3
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:17:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AE424401DA
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:17:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z7yWSlxcLqKW for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 13:17:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 989E04006B
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c20a::7"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789132672;
 b=Dxom0If8dElj+ZDeTw6fNI8PTL9cTvWIQ2QmleTvxWJQNurY/IgK/kcPVZXpgc0kEJTN
 b69dY/jU9eaU1j42lmc9t1FGMffgkS6u+HsVSkT4SWWHGMiS+g4jnljq+BQbj5yYb+3tv
 HGEqO/LojvVA5nuBrsigZAOauCQOmnb5ilsOR9HLN7oR8zB9blGeTBn/85PkkdK6V/SP3
 C/kOjJyapODYx2Q91l2YXhTKGTOH1isLl6pydWfTf13+VwjNn+pYg2FB6jKich6L+USLa
 7D5UOeejRsM3x0O1f0rN4eWBe/omCg9dfvf2u+gm3+GTRjUI5htcZm/Uxx7JMLuG7FQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789132672;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
 DKIM-Signature:Authentication-Results-Original:Received:Received:
 Message-ID:Date:User-Agent:From:Subject:To:Cc:References:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:x-checkrecipientrouted:
 NoDisclaimer:X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam-Untrusted:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=oZEkpTM+cIihJF2/Dfe6drRutsyAnsdmACivkQCNgPU=;
 b=GP44UNJKQQFyxPQR2Di5UdVM3QL35FrGx7B1kcAN9RJ6uo09D7ivVUQUCI6jB81i5ejF
 Y5H9R4g2pjzHOg+R97AHnU1ECdhfODrJemujT2vIlT4Ql3xRgy2pOR14+IJfrvKBm5cBZ
 jibMy5vq06t5Al+Nz5db1dDbRtl4Jq7VtrbqTGMbQ//W4yudbF4odM+hshFx9s/UuDgoz
 TFKaTlxX9J1nUaqs93yYtNyMk/mpz/+yZ2hXcyxG7s6u4xyBBC1mY/bsNd/ELnUTFZXEs
 ZNjSb/saz4OR68/7ygmBrmIhFK+RTa5vjri7za+evNUoIBX7W7E4pIbmUWe70glhF1w==
ARC-Authentication-Results: i=3; smtp2.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=AfkJe3J4; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=AfkJe3J4; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=AfkJe3J4; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=AfkJe3J4
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 989E04006B
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:17:50 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=tDNycyMQMw26CDFtqkin7Df69dRxVgdp1HzND92UrLX5ILqpWO8H8CX7zvuN7vwTesjNyLhs7v0q14i6sE7vkFVR5k6IjI+q3jm5loqvitEJgzubGQBHn9Utu4UxhEUaXQP1t93kZNW8YRtGVIYoCrUf/QUTi+47El8CGx2Srp0eXgEXI45OyY4c8xq06GKdWBc5D7sw1vYfSqJo8AJp2QS/+aqH20HZ4tO5raT4QI4JOkQRDw1NwIEIhS7nIzo1EUZXglvLAmgXM/PrSOJY0kCByvY2Sv8Z8F+3U7cyfzqmydFx3QU7yzRcFNSaKJBnrr01HjqpI2qEu2ceElb2BQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZEkpTM+cIihJF2/Dfe6drRutsyAnsdmACivkQCNgPU=;
 b=yzLWJ4bUaTitbuDuCADZ3d7gHBTcEJQArR2vDoxjG0OffODr9357NYisxvveT3k8RxAZM/6mjuNx3FY5VEwXydQvdtbelRRuPr5AIXjDiE/BaT7nqdZahSenF2Phf39eak7EwwOWXrtcDcZbgWjJqFVc2XclV8mCnq3UHc6JA6WzBlyxD6rD7ZfeTKPwL9kd/8gW59dMtclEghO0t5GofonkqacWebHFs96TUXm6POr3wSh5AXuEWaZYDBklJRVv0eaYFdx/p3mBtPWmVTg/8WknVDSi4U2GX5WIsNc+OS+IercjxDQHRZwXoLq21QvnxUhMS+FNa5ug+vLWA9EiXw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZEkpTM+cIihJF2/Dfe6drRutsyAnsdmACivkQCNgPU=;
 b=AfkJe3J45gQzc8orIEsEq47eL4JR0b/dcgz8ac/bsB0DJoIrIMxh5xPVQcfFGbqwUtcNyohYeGrj6ntyu7JmHvGqDsyUha25hRhsPPEHWrOmlGaTImXGmuwV1muDWF5vCk20zWw4WfyZ9yVmVarmgiqD3CWexB4EamnjW6u2KE0=
Received: from MI3PEPF00007547.ITAP293.PROD.OUTLOOK.COM (2603:10a6:298:1::4d7)
 by MI9PR08MB023630.eurprd08.prod.outlook.com (2603:10a6:290:84::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 11 Sep
 2026 13:17:45 +0000
Received: from MI3PEPF00008554.eurprd05.prod.outlook.com (2603:10a6:298:1::88)
 by MI3PEPF00007547.outlook.office365.com (2603:10a6:298:1::4d7) with
 Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id
 15.21.382.12 via Frontend Transport; Fri, 11 Sep 2026 13:17:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008554.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 13:17:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nm0QPX2swU00rjogoCUqQgtcYqhW0tlI++APXq/o/49uzKJ91BbF8YyXJRayyJqwtpP4jhYZR3jzxepYJRD2/J+Wx+msiLAMOWyAsVqA1luIjfvluP4BGfZCnos6cac3FuU9ogBw8Rk774Ril6SJuLwdKCrMWUveZ7Uusj9iffT0cghoKFLxPJ8vQvGuVtNWYwfVz6PZyDAjRm6Yw1nUnMbEaW1/go4PHF3GO4hEuHjlA2SrN63mqAgkoKQG/3r0Puc0COxcNEY2n+W4e4t4GRnbRlIJLKnsGqbuWzNul0+tB0tk/jOTjQxMgPILxyyEkGMpSCWKu+Il8fY+YRy5fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZEkpTM+cIihJF2/Dfe6drRutsyAnsdmACivkQCNgPU=;
 b=Ps98R+mtPyHszZApgxtdOQg9tcGd929fV/v9zuuQHG9XM0w3Pip9HLg+7HWuyY1otdIh0jQkalUYC4Y/ErZM7SDZPBGCDR/OwWQmsm32wgJGtjDipLqddupXkycb7nEecg+C60TfsqRpuyYMu1H413wQr8wFYxnwh4vBR6XBiymAzB1OFVifU54VnC0sdK1BLmLCMY3chPiL43yNhFxxbsB/dBMNxRWRuIXppCDZ/xKNyFhhSQAjkA6uOw8eEyN95NRkBE0IJ45252FVUEG8Hpcr1xqfZbRzBhdTk7MqThkxiYaIuuUriWnKjZKyOXkTmLUZAtDiCtL2ePMsWCfEUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZEkpTM+cIihJF2/Dfe6drRutsyAnsdmACivkQCNgPU=;
 b=AfkJe3J45gQzc8orIEsEq47eL4JR0b/dcgz8ac/bsB0DJoIrIMxh5xPVQcfFGbqwUtcNyohYeGrj6ntyu7JmHvGqDsyUha25hRhsPPEHWrOmlGaTImXGmuwV1muDWF5vCk20zWw4WfyZ9yVmVarmgiqD3CWexB4EamnjW6u2KE0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS2PR08MB9224.eurprd08.prod.outlook.com
 (2603:10a6:20b:59c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 11 Sep
 2026 13:17:03 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0406.005; Fri, 11 Sep 2026
 13:17:03 +0000
Message-ID: <1ccccb6f-31c8-47cb-bf5a-38f6bae870a4@arm.com>
Date: Fri, 11 Sep 2026 15:17:02 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH] net: airoha: fix PCS calibration retry limit
To: Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.u-boot-project.org, Li Xiao <cincinnatust@163.com>
Cc: Tom Rini <trini@konsulko.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Li Xiao <Li.Xiao@airoha.com>, nd <nd@arm.com>
References: <20260818-fix-airoha-pcs-calibration-retry-v1-1-5963d388c1ad@airoha.com>
Content-Language: en-US
In-Reply-To: <20260818-fix-airoha-pcs-calibration-retry-v1-1-5963d388c1ad@airoha.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::15) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS2PR08MB9224:EE_|MI3PEPF00008554:EE_|MI9PR08MB023630:EE_
X-MS-Office365-Filtering-Correlation-Id: 0036f649-e229-40ec-0c3d-08df100710d4
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|56012099006|5023799004|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: Se5oY48WFW0IfpKlMTJcd0Nyau6U22SCkMtdLxGGqoCEiQJSKgswcUWGsrNFMPWrqjmAb+X+EQbVhIQ939c4Pc8Pxm7/Qo3LaF9JrgEgcIDdYgOfmBsAN9o5gbTvw/0so6oMag5G5P/Og6dyG/36iSt7p+9vm6hCMOBKcGSWLZlcPq3n46LTEj+QnN6JCML7s2k8d7fWb0zkMqgcW2aPkJQ3XZQMsG6PLa5pgwkGowuGWX0Lh5aTC8CvBsTkag0sjJbAZMrRuiYXsiQJJB/4pi8uHWOsPApOOfup+VmK7DhGnt07KGy6VZChbo6+r51KJeCGRh127McM1Urn0oLMHFeqqU9qYz78lE3aZOISPmxsSk8Ynux7nyjeVxq8VeoE2hf2rpq9tBvGkMfX9pDWmXSRN4uA1exGMvg7LiPV8uEvVFPQBBvjtWVmyRw7Au6sJRLG1twM3jhrIhQHLTmDvGRQd62+RoLJRBJHDfDhEeKwNGf0PAM5Hp6gqjeBTuYNWkt2fkLSHjjGxsexI+LkUGy+jCsZwlojZZB9uQG+VeyrAbdXMSaiu/piAXJ0P+QPacUgPCVPa4Pm36kSuY6Cpg1M4ODSaA0xcbZSmt0xPCkPthRDehx2vNA1peYWAMY6IZPhn+QONSwROGDTFZdAmMfnLzJb+hsMHgJHQnuDX/4=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(5023799004)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: Nq0nBvT42ZtNRR0XqmHGGx9oNyZT+QymbsaAaU3A5kghzP5iLfMFzmOpGIxI3Fjw21qFEtsLvEPiO8DeYELuwBYMxKToZlr1ddqZUbOybHvXtnNQsy+Dj5CV8fOhvV012N6QalRovE3AkUiCZ4k7s5fznSV8WLUsALv2ckp+uxJ5I3mMTnRM28FqLt5eD5W2C5Vl0ERE18I6XSZp9NLkwI4vtpyOQ5s8hq/3yFJ7ygfpGm2ODR1bJWLDmIOH04vCwFl43HFD8fg7zwacbYBPCJR6PNrNhF9q03wMBcDMXPBorDJFlgkTs74Mt4B9TIZVWUhqgrSz12ndvWlbyorGcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9224
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008554.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9cde4cab-d72b-4fd6-9beb-08df1006f856
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|36860700016|14060799003|23010399003|376014|1800799024|82310400026|10067099003|56012099006|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: YxMyeoBmc1BIjW0pItPYi1ifa8DhbEDVweTHb/2o8bqduOFpVP4lW+E11bwZKErTtKU6PhKGVBwl0VWkSO8izowiQA3PzSar4OrNCl5gylC+0bXZzEQ6h2FsiHPtYHAepGlAzf/W+lcnt61MOOQ1JLL+wKPUrF0ZVXGD60TuWIMZxLhSkMkNQD+SXXXOJwBc/pXG8fmWhFT5pfxX9dAZk+6Qn4NxBQUzKIaMUJiK52IMdniD78Cy57F3HONQmxdaDAL3t+YgpcVvIhBF0dAatUp3HHxILV/1wdJ8K2RZ+xO1c40noS1YgW6arBGFoI1RWJ2HPaYcZlILhLMyaz9SQCj/wwVrT95JYo3nb5X3Afci1rOPkU+CZDBazC9NHR2h7qslGJSW82OGHkiV9DDb4XZkmeuxLZgB9FTGyqXB3Pw8ujdRQzNZFpzsy5GiXIIDHX0Z/czrXpKN2mwahrXeKQY5Pn15F30vnNRe5TXIyqk6FOr7HhLo2dPn2z6acx+AQQPSpt+Q3QxLQOrMHgijIWaM0Lmm5lX/JCG0agLFvZuJQfAJs6Zms/wgKr66phPiWgS+p/LJ4Nx0bmNRP7aLxdj3UAHleyMzHS3zsyRzmxQBiNS2FVrBfb0oMWbD7yTYlGwrmc9iYMpF462Dzexe2NZEUp8IZaqpXNYI8YQLVL6ku5cZYMMUBjcVM9UIM+MWQUMeecQEjOD7HEbWernJSA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(36860700016)(14060799003)(23010399003)(376014)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q0JXfnRZltqrBCRfE3XRB0zxwyKsk9D4kQlXsjlUn2fKBbpRpzVZd8c0WJ8PEx45DbH9m9eKPBn+QJyi8UxirlT7WxwFfSbiAQKF0gqBp1Q4NizMBFzE2zYNe8G6E0yf2kKSQMDncTFn5/5r102pWE2W7WVLNHe0WYscsR8N9QL/egjXNUHqC1vC1MC8RvnOHvYZaHGHDMcdh4/4fA1ibmeS1nWO6HtMK33yQOxiKkt98rUfihA7XfGCTqbNM03kZMAvv63WWCIFFlCHbaJ19XJ43vJi/Eyij7f7KlIRbBizIHPjBQx07uI/+g11Wcnikd7Yd8c4MXShh0CR4TL94fL3HO0YbXsB3of6BXEXh4FzvtHOuTpP1UVhiCALqUgY2ADNmnfX/b+zkAZiOvXGtB+OmdCD/toTYQzBidwg1dF0eLuxYig7M2sn14ey1BOs
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 13:17:44.1397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0036f649-e229-40ec-0c3d-08df100710d4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008554.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR08MB023630
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

On Tue, 18 Aug 2026 16:20:10 +0800, Li Xiao wrote:
> The calibration retry counter starts at zero and is incremented after
> the limit check. Using a strict greater-than comparison therefore allows
> one more retry than AIROHA_PCS_MAX_CALIBRATION_TRY specifies.
> 
> Use a greater-than-or-equal comparison so the function stops after the
> configured number of retries.
> 
> [...]

Applied to u-boot-net branch for-main, thanks!

[1/1] net: airoha: fix PCS calibration retry limit
      commit: 70d4ce22fdaabe1cc39aeaa9c87c1ba2515a4a55

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>

