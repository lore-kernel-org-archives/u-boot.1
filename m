Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1395C88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 09:04:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 79411407AF;
	Thu, 17 Sep 2026 09:04:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NNXHOQEtkOsV; Thu, 17 Sep 2026 09:04:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A363D4079D
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789635877;
	b=SclE55TZwze6egyUceuNBbBy8rSz6CSU1QopZLSmEJkJNw2AOyZmf9yXtHSz7F5CB6Et
	 +Aqf492kRP9THsUPvk9XlPScIOqst4lum0vBj+yX5p845G4r9P3yroAyErJsDip2AFWpY
	 Wc6zXTw6f6G692NesfkWnVW9HMlIrZ6zeBzYsp7h6i9eX7P+Ie/UvNh4rxbfs2gf5nPCU
	 CcTn4cTB+R53kvAev0p7I3XSv9Ibi6jbAkKMpMR4ulC7PD0FlHyznIJSVeGf0LezkJPZA
	 nmRgBg3BELLRHwKLElRn0SJbASwsLJGkmE2pju3vm2NGL8m2u0SmKXSXaU+zHVFLf4w==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789635877;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
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
	bh=DzBmU7ehENx5PlU6ShR7EwX2vDGfkXXm3Te9X35o6GI=;
	b=XBKYmoTVaoEBRrS/DYlPIh635V6DgR/bubJDloFfgJM0nZJXc5H5Y6O0bQBNXBXuLYst
	 j4Ih2ifhNlE8qE1kLSo5t2S5+gG44JZ6aaLcGK/ymJgA/ANH1FAVhLlKPz5FBVnxfSNjE
	 2gudu5vJ7aYX9kf2HmJ8qXkCwCaT4J2FjFv2SS3ZBoq/1F7TtoXTh9rFzgNGJQQZornYL
	 PF4u6dcLNM8Y93+xCu5EGtjXF4rMQykK9L8rFYws7n5MdNdU4YTBU7Gq7cYVdzsX/x+/2
	 Fs2aceXWa4d8ovNnnqa3OHgjLZghFIlX5tEZedwk/LLeApIFllOg+B4UCVwnHE3sNBw==
ARC-Authentication-Results: i=4; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789635877;
	bh=DzBmU7ehENx5PlU6ShR7EwX2vDGfkXXm3Te9X35o6GI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ul2LV+fokA2UQ5noVosX4QOQN0Da9ijG7S8Nvhf+aaUCfN9WAI+t/khIleDIJ5rkR
	 ToELTrRhfoBIAK3z5zce9vATgNDPysdJbQLgZ7TGR3SnU0vXqgb4Bc162LgG8xdHJh
	 vGNcPxpjuwv1jtVZpp2mcZ1uknyA+tMqwbhomBUukYg+Upf2zq4cb9rWOMm/W5g8S6
	 tcaFftPIQHiW2108pHjD9Te4+LVvwwpAFRKDQmiDC9IL06foA13itGGW3exnnHwRCC
	 pQZy2YUkuexxL1OFDHQgNkZKmMuy4SRCVbomxaLOwYUX16IbWRHgEV5ks4t7KOWdEb
	 W+8Yr4AWinq6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A363D4079D;
	Thu, 17 Sep 2026 09:04:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D33B362
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:04:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 02E2780EFD
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:04:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LIBVD2f45rvV for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 09:04:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8DC6480EF6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c20f::7"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789635875;
 b=Grco6AyTfpbIrCJlCqLJ78rEW6WRBRxk87M9t887+uu5aIrxln/6trwRx9nEW5caOyZL
 RK0EdfcYLVcA0NwC87miw6IIr3R6JpWsFezBUhSfX27jr01MqEHOvQLnxQMXsKyIhrGju
 VB9ozVgFwgQzCmnF0p/HSlrdOegjwl0R+zhkN/ICzPn003iRLiHO+8aFKKwYrgQVI44U9
 DsF106w8M8jt4l/e2rm6IIcV/yO6oR8InQjrpAad5BN1cnzs7YcSRPImxMpECMbxl5JZZ
 WNvDnFy7bu8cU88EoIW16sCNXMsOftjivozGxXlE17wULdG77s9jY/OF7krZmwQw+5Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789635875;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
 DKIM-Signature:Authentication-Results-Original:Received:Received:
 Message-ID:Date:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
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
 bh=DzBmU7ehENx5PlU6ShR7EwX2vDGfkXXm3Te9X35o6GI=;
 b=Z6x84+JzWj2mkSNGEGBFMPtQ50dwiuObsgp8MLUc97XtBu+fzurReYhE9BtMrh0+XXBB
 1nauFDEtKgdGgme2ybxV0LopK/5wc7u5/7kIE2wF0ThDG2SkehwlKbjiHLT2w2KV9yOrN
 XWAD/7enwySRN73NciJonlSroc9BaHHq86jmsRUmkK2LSj8PeaNf1FYrkJxQwL8XKDUeH
 bQuGh4IQS7TmQ0+Dyfn4xz2hwR8F8Amb5Lr6nmov7EVX+/wQy47PmkybKCaFb+Q4TEWpO
 7NY3u937qkgUJd+Ef+yhSrf9E4YsonmT2QZSdAaU1XrjYuquyIxIWvWzeCzF0rVoBOg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=c5j7u11+; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=c5j7u11+; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=c5j7u11+; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=c5j7u11+
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8DC6480EF6
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:04:32 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=aIS7jB7MyWvpgSVKreSvQQS+KH9ZH05en1ruwU6I84HBzrijNFc5jNIwFT4QjUSBn2bqWPXFufiHVGnN4LjM3TIH7t0ow6C8uXq56zTMO/DMEFTbejN1DDrzV5kdqFz52M4n/I3uzwUacqQESuqnXo9wuNVlFxvk6Tgkg6+pQCEfGuiyXNWqIpoze18DZKHYpuDirk9h/VDAcPVOa1l1ky+W+6rThI5CfTY3+myT/kLcGsU5q/O00IErIZwKzW9uSItuxrFO9snxp9kW3yUHwAPG/kpSrCbTbPe8hFyDxoaQGX8lataUSy0oXBpPr1N617iB9x+ScXXauZjpB41vcw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzBmU7ehENx5PlU6ShR7EwX2vDGfkXXm3Te9X35o6GI=;
 b=AvpLEP85fFee5DkGxUAiNHYBh/AgEeaYtKrfeyW0HlMt2db48sM8djUeiJiJGwxv4zD5jMbiUyZ4JcvGci0dxnhP6BkobrNmyk0Eas6AekkXpIkH2TImdl7+ex9gBric+SXnpDNKSh92JMtRloj0STiA0d/Vv78HYLXBdwJvqhln7GKvZ4aLTwrWIJ81sALf1NiSvsYd7gJnx6NujR6dNHLaXbKDQFT8wWZQT3ZE1pyaLccdQ3CVnquxYEUL4QWTMF297GOf/IDJ8kJ61PSVo8wCGYZyyO+yaBcL2rQcFGdgxGWzlXlD+uUlOMLEdGdp3FkPTO1tPhjMA2/UKYD3cg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.microsoft.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzBmU7ehENx5PlU6ShR7EwX2vDGfkXXm3Te9X35o6GI=;
 b=c5j7u11+uM2x78zLGteb77c8+bOrhwVe4I7+rfRAblV56x39b6vouscrKMM4okGO3dmlJpsd8edUPXCDRMIpksDUy5mx54PZ8XUF/BCsLwM0rZoHGYLCWw6sa47szsQVRF8TRLL7fJgNkrFaLU9jb77Ol6fEYSJ3VoYmmuU7f9I=
Received: from VI1PR0102CA0051.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::28) by PAWPR08MB9567.eurprd08.prod.outlook.com
 (2603:10a6:102:2f1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Thu, 17 Sep
 2026 09:04:25 +0000
Received: from MI3PEPF0000848B.eurprd02.prod.outlook.com
 (2603:10a6:803:0:cafe::f4) by VI1PR0102CA0051.outlook.office365.com
 (2603:10a6:803::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 09:04:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF0000848B.mail.protection.outlook.com (10.167.240.138) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 17 Sep 2026 09:04:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EaqkymQ9CRoovaK7SRceO0yHeQOrweQJJj6xswsRY2gAaw0cfw2KzCeGZp3lfrqNht4QtZTk/QtP/koC104Mox72ybXH19Q0Tp0JKL7OkT0j7/wzeuSy6W8913ljz7a0aPHIh6s/1TqSgJhCfJ95j5YWVjB0uqc8K11M/a76+3TVYzDHLAmOyxXT4nchTBfacPnGhx4rwqRW6zVXr/y30eU5cA2N/i18RfuZUFckvBOFA17RvX1r+YgqzPF36PMYIWRcfFNIlhIkELyd1qlnKjA1PjzmSxmgubLxVQAXW1V7+CgY+4nyB6adwS5lwuTBcmUb8X+YEO0hBOYpQ3lnHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzBmU7ehENx5PlU6ShR7EwX2vDGfkXXm3Te9X35o6GI=;
 b=FvGsiVQo24TH/zFe6Fd3YJ/0IvlzmqoyisEM0xFzK+VBhXB519WCkepyhrBKvo78RPOJQOK6ABe8xRrk4pvH4zhHjrEYESN3t1jTqXKwX1VJwQfArbNAybFzJAb4Fm4lGKwEtaoL7EsECRmhobCkQSh2jCsi0yrxT3jwuynol4k0TEJrRnXfBvR/FlB3rxqk/EpdkQYw0C2le4SU/mcoE395q5JuV99IglcbRA0trWmdeiZVrECN9QSerb5bFJvV57J4lQb3F8EUbVF4o9lBtFZyr6kPvFeV4ud5zaOiZvnXrxzc08cAp7/+4X3bs9ABRlJHgztiIseAGrV01y2GMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzBmU7ehENx5PlU6ShR7EwX2vDGfkXXm3Te9X35o6GI=;
 b=c5j7u11+uM2x78zLGteb77c8+bOrhwVe4I7+rfRAblV56x39b6vouscrKMM4okGO3dmlJpsd8edUPXCDRMIpksDUy5mx54PZ8XUF/BCsLwM0rZoHGYLCWw6sa47szsQVRF8TRLL7fJgNkrFaLU9jb77Ol6fEYSJ3VoYmmuU7f9I=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DB9PR08MB9946.eurprd08.prod.outlook.com
 (2603:10a6:10:3d2::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Thu, 17 Sep
 2026 09:03:49 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0451.004; Thu, 17 Sep 2026
 09:03:48 +0000
Message-ID: <2ad7b171-9f9b-4615-bfae-4acfead28b4a@arm.com>
Date: Thu, 17 Sep 2026 11:03:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] net: nfs: add bounds checks on memcpy into
 stack-allocated rpc_pkt
To: Sriram Sriram <sriramsriram@linux.microsoft.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Drew Kluemke <ankluemk@microsoft.com>,
 Daniel Munic <v-dmunic@microsoft.com>, nd <nd@arm.com>
References: <20260909192016.217183-1-sriramsriram@linux.microsoft.com>
 <20260915205210.260404-1-sriramsriram@linux.microsoft.com>
 <20260915205210.260404-2-sriramsriram@linux.microsoft.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260915205210.260404-2-sriramsriram@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0021.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::8) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DB9PR08MB9946:EE_|MI3PEPF0000848B:EE_|PAWPR08MB9567:EE_
X-MS-Office365-Filtering-Correlation-Id: d7524e86-e821-48c0-dc77-08df149aaa9e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: hURjb4/kQPZXyE8F3WnH92yBDmFRIFIrQbV9pV+Nc1umv/uWLm1ILylyCrI6fQug64zIjvapnlcEo6N4DQPp++wJ7Bh1mH181LUE8iH5dFfF4Hlr3oRxXFjbUGlgDpE3gTDCgP6wJDyHN0FsiS/DOJrb8off6B4KDQHTYp6LhoLlYQGxlnOmDoLkBEf4RhiBvmV9He4Mgt+XWAPRzRj1j/0H3YgkMhwlazj5jSxk6LCs2jzDjejiaq/AV0kSd0i0Ds9FEzl+GlfqtJUT46oJUaeP9eC8OtTsxOqR7ftSYHxVOEsHf6+EumdfCEaBFbXb1mzINfO62ojRqH3NWMigNRJzcYQDFax60M7VQpmZP6BtjFeNg/NasKp9Nq43hwWsMVq02OduzvHffmSLYH6XrtCVs+DrCNZ9HGcElBMDa+7aZYgclJNrD9JpXSsmcbmf1jrfjrsf66MoiApOUvnP+M1l+h1J1soXRkUmfBaoIdXkEv5CVhG8kUNflCxP/8cgXvITrdQIhPXZKfFc/QQdthzpxerEDt7akxM0bbxUSqR+RHM+INjYeC8qrRe24Z4oRUto/xRl3uhuqE8Dqai2Dt0V2WWgi3g1fteQ8KvNeTNJDAS5nLbFtbImMMN+jbLD5txQhjEHNvE0JJCcq/kA+YQeKSHSAfoQU3e/MFOKSXY=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: vlRO/bwP2wIS8cRtOzrZxKh7OKnGnbXSwuORcUKv3tU02b53X2v64wD/ZZMQXfKXQjPpYMsBcEtGr0vTNWOHO8nR6IxDVvEE9wBC329DbtKDoqufsKDlMp59FKULuMEoO3mi4j30GsUmG+qlJjfVh4kyRIGFHFj5aFEz3qMQ2J9izpEIspzgV8OkLqNZ5nCM0VUVYfQVZMZoa22rR3mQg22k3e5yvD5RhqLT0ySJpePXeoFBBCZLyjrm2xAO9DCQ0gsxfPdrUJj4K3OOkxx48YE5qV++CfGDmo9uYZpqKbQP7c8s05lv8e135/4BSNuiJOZJ98bWJPUj8C+m+k8bAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9946
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF0000848B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b5a3a939-2371-4f96-e2f5-08df149a963f
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|14060799003|23010399003|1800799024|35042699022|376014|10067099003|4143699003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: rJ19UeZict8uP4ba0nNQPQ1Ibee218oM+5iPAXb+6oERgBYp25L7IMsIzcgzd0FywAexsAj9X4nmWLQvO+BSGhiNWY1FA1C39hzP0r0cczIOFePKNeWoLKZWdybUR2GNsQIwuH29G9KGGKP1rhaQIk+P3dWFRZ+sHVHbcmSId1JkfAhKkOXYgInpzE60uj0wQHDcXnVUdnq6srZ905RxehwsywzuxO5FLYpSwZiM+iDTk1kKp51Sm+cbRaL6I7CApV1HfC9zqzHT/XV2hO7EzOcI87D0dhvJ7CPnz3aFCzZqqwk/hLk693Ue3k045KZrHWZ/hewpIfLjeMZEv8T1SQ/3lzcPzlN7jNJH3LUP1kxUEfeLqNrdcZeO8dakWECMOgn5oXouEW8yB2zyIQxJ+6g8B3TLi7xwUmko6e9JT3dvEY4bZtYyy+L4rG+xStn052Aa+pnrfBwhrIXpAJWvIFWDWApXvPDtjyCytqdjMVuq0I52Mr2OPJ8CRmAF/OW+P4XQZP/QPPImE0fbqt4+Q8pYO4jpG9gjgPPis4LQdxt8GUoeoa9I+dIZXUGYgIt4TIpIUIVm92hM0HVxTsasC+xEt8esHvZXPueI/x8919xpcDZ1y8iqy2/G8A7QkVAmJ/M03fpfSIssttZ73ZpL/sw1ehYYSu31JvJJHy2UxD3BXG4rPL7l1CSxzW0S+q4jZgLsxQpvp2WVPhkqhN13rg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(14060799003)(23010399003)(1800799024)(35042699022)(376014)(10067099003)(4143699003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RcUw6jDgMvrmlp0pCklVtMrnQV617xMBBz9pRFfvaHwjBtwEw+xKyuSDdgDCm6w8jLuSjZvVNdLhZDqK0bz/Kr7o4P7nSs6P25CpzzgBcyhF55Dkfrn4GRe267Er+JkO/qTpqGqVrjbsGfa4eeS28GftXqn4IRCEBWg12iPOJIy7fbJFkaLpJ8+32jxFzF12B0MubdEjUfIthn6wQWo+Y7Ff1EJ0nkeVPGfYWUnkpOqy5rA34P9rtQ33N+dKzstUduVFzs84CQTbY8L7KK12zEWblzjjNoXLwhRw2AytULyW/jvkLWM7CwdNrZA17xHuHKUwxW5XqwpZhLenhXoVMU1VaqpkPiJGZ7qiFLTSJbl262fHJAEq0T2EWiBINTPOqtT08TA6nimDihC2CZWi+06svyqXytT8ZpIUo56SKbFXxRvBhXqFQl+djo59QX4u
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:04:22.8236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7524e86-e821-48c0-dc77-08df149aaa9e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000848B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9567
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

On 15/09/2026 22:52, Sriram Sriram wrote:
> From: Drew Kluemke <ankluemk@microsoft.com>
> 
> Multiple NFS reply handlers (rpc_lookup_reply, nfs_mount_reply,
> nfs_umountall_reply, nfs_lookup_reply, nfs_readlink_reply) copy network
> data into a stack-allocated struct rpc_t without verifying that the UDP
> payload length fits within the buffer. A malicious or malformed NFS
> server response with len > sizeof(rpc_pkt) overwrites the stack frame.
> 
> Add a bounds check before each memcpy to drop oversized packets.
> 
> Signed-off-by: Drew Kluemke <ankluemk@microsoft.com>
> Signed-off-by: Sriram Sriram <sriramsriram@linux.microsoft.com>
> ---
> Changes in v2:
>  - No change, rebased onto current master.
> 
>  net/nfs-common.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/net/nfs-common.c b/net/nfs-common.c
> index 637fcfd9bb8..226e3fe5798 100644
> --- a/net/nfs-common.c
> +++ b/net/nfs-common.c
> @@ -503,6 +503,8 @@ static int rpc_lookup_reply(int prog, uchar *pkt, unsigned int len)
>  {
>  	struct rpc_t rpc_pkt;
>  
> +	if (len > sizeof(rpc_pkt.u.data))
> +		return -NFS_RPC_DROP;
>  	memcpy(&rpc_pkt.u.data[0], pkt, len);
>  
>  	if (ntohl(rpc_pkt.u.reply.id) > rpc_id)
> @@ -532,6 +534,8 @@ static int nfs_mount_reply(uchar *pkt, unsigned int len)
>  	struct rpc_t rpc_pkt;
>  	int ret;
>  
> +	if (len > sizeof(rpc_pkt.u.data))
> +		return -NFS_RPC_DROP;
>  	memcpy(&rpc_pkt.u.data[0], pkt, len);
>  
>  	if (ntohl(rpc_pkt.u.reply.id) > rpc_id)
> @@ -561,6 +565,8 @@ static int nfs_umountall_reply(uchar *pkt, unsigned int len)
>  {
>  	struct rpc_t rpc_pkt;
>  
> +	if (len > sizeof(rpc_pkt.u.data))
> +		return -NFS_RPC_DROP;
>  	memcpy(&rpc_pkt.u.data[0], pkt, len);
>  
>  	if (ntohl(rpc_pkt.u.reply.id) > rpc_id)
> @@ -584,6 +590,8 @@ static int nfs_lookup_reply(uchar *pkt, unsigned int len)
>  	struct rpc_t rpc_pkt;
>  	int ret;
>  
> +	if (len > sizeof(rpc_pkt.u.data))
> +		return -NFS_RPC_DROP;
>  	memcpy(&rpc_pkt.u.data[0], pkt, len);
>  
>  	if (ntohl(rpc_pkt.u.reply.id) > rpc_id)
> @@ -645,6 +653,8 @@ static int nfs_readlink_reply(uchar *pkt, unsigned int len)
>  	int rlen;
>  	int nfsv3_data_offset = 0;
>  
> +	if (len > sizeof(rpc_pkt))
> +		return -NFS_RPC_DROP;
>  	memcpy((unsigned char *)&rpc_pkt, pkt, len);
>  
>  	if (ntohl(rpc_pkt.u.reply.id) > rpc_id)

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Thanks,
-- 
Jerome
