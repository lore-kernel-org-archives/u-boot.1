Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DE7CA6012
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 09:57:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6122F4056F;
	Fri,  9 Oct 2026 09:57:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6DUja9-O90Cw; Fri,  9 Oct 2026 09:57:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 892DC40535
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791539862;
	b=DmjeZBTFS7zP5Y92fd2IvA4ndKiKJa6rGZZ7uPYDCkcuSR3fSyQqYKU8baL5yeB+LiUc
	 ajy4xcdWCfQQ4+RO2tGSPjjyjRxxKcm3aFk9wP1iZMbcZEQoyN07WV2JODVoD67KpdQgy
	 gTRxiOXKe5WEfU3ajrVty4cAc1I5atRE2rzceim3TRxRLlsnnU/j7VG5+Q55LSGXGqDiW
	 m5tgkQpdfjVCNMgOISDFvd9hGt0OBjnkqjWIlByLRrG5iGADT7bzk9+6Mxpc2IaqEVPfW
	 nrC2D4bGpkmfPpLNhzt3m+gqLxXnOxE7JWj2VO21eQjMTYuaLHHoXr55zEvEb1OW6+g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791539862;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
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
	bh=CqpQ/XUekBbo3xYvPlkm6BzDBZ63uRIANzU1YVyHjEI=;
	b=s7IDwmfE0dLJBdKT4HXwkEjmuTOxiybpTyvrRcpNB1AiLyKpyOm9i4CW5T/qnQlycKQd
	 MfjgbtHP9A578VZgqVrqEDRI1bFBOEzk4RbOF7gepggKN9xjRpYsSRheyb7Jsbv3Kfoea
	 gFqtry8rex94PcUwZFIjVfV2pyrvsVQmvlmQe2oexhDaVLs5OOKSyivVtoPV/f3pqTQXa
	 la/s6ShE4pg5xfmI7YP4OccHO964WKR5RrRBaHyJa18dnL4ycR6NySVQSic8MzBp0IkkC
	 JYuAJj7ISO3nDfhde0Iil+9gdpd+4w8LqknOy+DwcC/SqR9ZEL8t5K/IeO2oNjvhC8A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791539862;
	bh=CqpQ/XUekBbo3xYvPlkm6BzDBZ63uRIANzU1YVyHjEI=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xAnUBZCkDRFXz2sBgVjukYdDFM5nJI4S2SSuYDdD0y0PnWPZm20R0/jFMi5hONezD
	 TK7GoL/MhGlNocQRwjpL17/zDApHQIUmsFMAJSNfeF2zd7XCQRHXBHxnQHN+8/CWxm
	 jsmeuGRBQk1Jj13mxMkovvKilZCzTiIRZ4bPLN72ArF2FtSHbQuSTIBSKZAnon/uzi
	 4GlzvJuZSy19wgFJa7EUX/PrvOMm0s0g1MdA6e0UA4/wnytbWrsD5hfPL6nxc2/vQg
	 bWh4wLPxOnjJzrbxegeXOBMarUx+u4c/VhmotRKBC9VFiBNhVnjU3UQOVd/wXYnm7n
	 PQK2IioZerhtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 892DC40535;
	Fri,  9 Oct 2026 09:57:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 335FA184
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 09:57:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2519E606F3
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 09:57:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id car-Y7KQXGNV for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 09:57:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 53B69607B2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791539859;
 b=DytyivvG8yGHVbwKlzRh/I1Ax9Nq6rf6UvE8Nae9JbwwLfVOX+s7JwYh4QkbN1a7siDQ
 ua1JEWB5G+jk/wc/FM3YM05hSK2zAkBH3srjY9s41D2BgYwCKeKSmFShsGRloDfNTqO4/
 X9EImZHtZsYAeOZnr5KaU5ZmCKSGS8BQuqWg5m+kq7fTlRN9pnDeDTAU1SXOh7G2xt4iP
 wkZtJ2c0bH5SkkFjI4ffoEfZc5eC3vNm4petN8grYq//3sz4kgsv4zqB2FiG8Fp80vuQU
 C3oHDsXsNpXkmbTpLkeTtzSu9rDOHZKQQjXgP3Avwzm9gW/WXdSL/Mgp/qLjtwZs7LA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791539859;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:From:Subject:To:Cc:References:Content-Language:In-Reply-To:
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
 bh=CqpQ/XUekBbo3xYvPlkm6BzDBZ63uRIANzU1YVyHjEI=;
 b=jroBMvWmgQWjB1LjpzIdM0yEhVTZGOj37LMdMBi+r21rtlrboTkhDPzL+DP8Mqd7Rv+G
 IACuwpzoRJHzLujshWbvC+3x2XeSmGq10fCpk5c/IKwfN+KJKcC0EpiQd+Y8pzkNArMPu
 uxcK7EJtXTrKKGYX0ibibWplYOxH/vJ4kGb7O6QRelE+O0jeoKgU/IIyjTz7CUWT4kAT5
 pU3p67oC6kXOE/h9qjObJzVNZTnxepeIx4eJmmOjazEO6dagvJufUUt6CIlKadX7l4rqA
 nkE6pk3p3WIeRbB4pClzoqA9ZHcEeW3LBmO6iuFcnMjd89vqdJAMdpSo6l51flSDowg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=N44BqDln; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=N44BqDln
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 53B69607B2
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 09:57:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWtibai33ifwzNJu75M/BTK8BHrUKgCJ9+bn5XcSmiwzTUONLD0EUmh2zhByq5fvCN76R37k3PTUdarctK9TZoV181iPfvUuJpIZqa98N49v+3ZU7bBoMzVgbd+I9/WuK44qup+VRiryRXWCFXiFDw78GQPsLqqMgDC2LI+k6PQ15VqTsy3oF3pZWVbr3JTDQ36CGuHGkOviZlf2LGTEXIW1z6dotWpj3mlPPTfULAfHNj5D16aE1zbbi39zIq+HKs+p0LyMe74NJZroJWxPpOXvQ8YdvlPo93rzrCyVmguQIeuBDsKWEZzIby0l2JiOl5p5ukQHNW/zv0exXk3UFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqpQ/XUekBbo3xYvPlkm6BzDBZ63uRIANzU1YVyHjEI=;
 b=p6cEyxKLHAZeOQVy56MPifJVJfH/FeM6VPy8d9AntxJguSRlC3HeojDlE3bS0/sJz3Dzp100EugafNQbKVHQsQ2VKeZwzCv3BvMj8VDtXV2uJ2eyYfv/qLd+PqgHyjtfmoT5Kp/nH9KtIVqTJOivOjKw/ORDaTMitGURgRbEQdfgro3O+bCo9PcvXGP3wAWI6wc202hojYbSppWuNeOiioPud1XMixtt8lh/zCoGjdGV4S1Kjq1viM9u7Iyc9mrvcVA+cbWtuPj/5MlmpyCZ8ibujdqQ6W+pVKxKd/ozgt4ajCSuAd7y3PBVTd4JHbn2CQa0JAOXhRyd5P0BPQC2xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqpQ/XUekBbo3xYvPlkm6BzDBZ63uRIANzU1YVyHjEI=;
 b=N44BqDlnGMT3bNrLgYAwN65j4dAkQLSxYPAjai/vLR6euj0+Zl2c76gmT7tJCYcwuhIQIwewX3aAVrOIXT0xT5LIk3/548YY3oQW06BF5qVhf4Zim3WHGM9vcsE5+4Voemh1ZVKQdn78b/tOzWLL5gZh9DQTwCAkgeRu2BoCBhs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by GV2PR04MB11589.eurprd04.prod.outlook.com (2603:10a6:150:2b1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 09:57:34 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 09:57:34 +0000
Message-ID: <95949879-ea0f-4edd-9689-8aa27dbd721e@cherry.de>
Date: Fri, 9 Oct 2026 10:34:32 +0200
User-Agent: Mozilla Thunderbird
From: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 02/10] rockchip: rk3588: Use fixed CRU base address
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
References: <20260804214442.2592597-1-jonas@kwiboo.se>
 <20260804214442.2592597-3-jonas@kwiboo.se>
Content-Language: en-US
In-Reply-To: <20260804214442.2592597-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0027.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2df::19) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|GV2PR04MB11589:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ae85106-ed26-4fac-32ba-08df25ebbdbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|22082099003|18002099003|10067099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 6BX4N7iDlGobCOC/oOpNEjg3w6DDg/c2Fw+MN8By56W7oZ+HGvBEy0peQ/pr8TMRXK3ll4iU7QQuvEIt8r8w3A8e22G4PP8iLg1bpdO6p+G2Iu3Jmwev5CWeUZIaWg77ZO9KceboFd7pe52k413IW6ZVS6134BOTNQWie7T2mUQB7DKSfY5yTtP/AM2/y1472scLW14+tLaRH6nvFwJICHqVH/td1EZsY+uhxKEoAftyyMNDntrdGkbKYpbGu33efIDFCNg+QGB94mKBmtPRDbnTjhrKuA+lVpwAz10z8nFDsZyfgzL0fxaCEHSX1nTMGUczj8qBREL/xd0h/MIM9aDunwhNTV55s2ieB1PKm/w7Lr8pb2vAd2RMxyUqfUReGMaIkqqRWM9SBypkKdS0yagy/n/rLvkBY1dmqPJyBX+386A4l/yb6SbST+vee/uN+Y6TcU670R3hjuKSox92QIaySFJ6ldYwLMnyFcIVv3HATrpMesikqrFp9hlEEWfAbizQzgjTkRPk8B8YJiabPkJp+gtKA36y9p/iGmLdHmqLwlka+6iBgfhUt9IcBcPgL9kD+7k07cavNBV9k/+Pas0LE2t75WBjv39jvAJqS+VXALO6EnAoX0cOpv10UrBhksuhZXIEw1SRVJWBdb5JaXUUmp85WfqPQGGr9dT5ep8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGxmb2dCNjRBaDVUMGVxaHF2Tm45b21RRXoxRXJ1bjd6OUwrNndndWwxNEFU?=
 =?utf-8?B?clBoUkRQSDdTWnJhTk4wclQ4QlFiTzM0U1FxYWQ2VTNlRmJqZVJVNW1ueFpX?=
 =?utf-8?B?VUNyZXJoRmZqdm54SGJPNFRWNldNUVRadVVQaS9qMVNPQVA4a09tYVpLTkc4?=
 =?utf-8?B?T2JUQXg1SlEwbGwzb1pFTjlrd21IeE9oa2pIS1krUUlnVlFjVUNpUndHdjVR?=
 =?utf-8?B?TWhoTm45Y0hIdVM1dW80UXRUTWNlVDl6dGNBM04xMHpES0ZKTzNwL1VuNEVm?=
 =?utf-8?B?R3lKY1hwU2dqbGRVTFE4c2NBWFJ3MWZUTDJyTFhiMGVqVTZhd1ZaZmsyS1hI?=
 =?utf-8?B?aHM4UkdvMk9NTmJzckxWQ2tRWk5sVjRZZlc1bTJ5ZWJmWGJEMW5CMkhrVU85?=
 =?utf-8?B?KzU3b2JBTHNRcGZTMGViQzZpSVRPcnNReTJPcFBmLytCMmF1ZXkrQjZTay9p?=
 =?utf-8?B?eVlVUlBHOThtTEdISTRnSTM4VGpzUmgwNXJjVkUyM2tWNHlYV0pTcDdVUHJY?=
 =?utf-8?B?ZVZid01xVFI1cUZjMzlndFFrWkJ2c3VLNnRXdnM4N2JZUlduUzI5bWQ5MjZp?=
 =?utf-8?B?SzdXOWl0aUdSanVMd0I3RjU1NHRWVzByNU43Y2VZVjdGLy9MOERqdVdoTnY0?=
 =?utf-8?B?czNtWVpSZmc2YzhzSzJRK21QT25MczNjdms5SkhYOFVLU2FYTE5oT0IyaUpt?=
 =?utf-8?B?TUNzV09ualF2czhQVmVVWUpUUEdwODNQV3RRaTJlVmhncWkyM1lmc1FyRXYy?=
 =?utf-8?B?WVMvWEJKdGhwT1N6N3RDQy9WWkw3N3hxZWcwK0F5YmJFTXltemcyUGZLR2Zj?=
 =?utf-8?B?Q2VnRVJJWXB0TytRMEc2ZzZ5SjRWbXhMa1hhRnFPSHpEZU9jVU1CTjN6SW5w?=
 =?utf-8?B?MDNHVUViVUxXTllacy9HWGFkV0RWbVhUV1pKVHBYZXhFVTEwV0tDRzdlOTQ0?=
 =?utf-8?B?OGhWZWdOYkMvQ2tuM25CY1BMRFEzTU1kVFdkTi9uTWF0U3RScCtqb0RXL1c1?=
 =?utf-8?B?eTJ3MkFqTXFVdnRrNjFmbm9rb3dsRURXaHdoUG81c3hVcG8zVXJ6ZkZ4Zk5z?=
 =?utf-8?B?bSt2Y2p1OWhnUUJYV2lxM2xNR2poQUhYN3kzV2ZaRGhqQTc0Y0NmdlRkUG5V?=
 =?utf-8?B?MU9UWnpZcmsxQm5qTmNOSmFZdGMxQW4yOWQ0VE5jNVRtYk9mUkk0SUU1OFA5?=
 =?utf-8?B?RDFLV013VWNyN0o1VGVtbHF0NnZBT2o4eFpuZll6SUFkWmhCUjM1RDFuQjYz?=
 =?utf-8?B?eXBzOURETE1vWVNXMnl6eHZXRlNtdGlLWWFQRjk0YWNRN1RJTERkRHY5MlJw?=
 =?utf-8?B?aHpYQ3dpUk9oWEFWbVYxRmp2OE1yQjNUTXVHQ21WdzlVbGxYN0V1b21wK0Ju?=
 =?utf-8?B?dTFyR0R1aEtzSGlQVkhmNHh6Z3VOZG9TZGE4ODR3VXJnOVlmNDhQNG5pWWRa?=
 =?utf-8?B?cUtWcUx2WnZBUVMrckdEdFdMemhIdFN4aytaRStGS3REbHVHTWFhdWRneCth?=
 =?utf-8?B?bDRMOHZtRVVZYXlzdzJsbUprWXhnaXkwQVFiN1QybGN0dklQNEFSMzZ0ZkV5?=
 =?utf-8?B?SFl1QXlqUitzSm5qS1ljeUtRWUo5VllRMXhiVVdIaTBPZEtqNUJiZHpLdHZJ?=
 =?utf-8?B?TmF5M1I4WG1RSmpiQkNVbzg1bkJwR29Pc1JyRnMzN3RpMHBKQWhHa3JmVkxT?=
 =?utf-8?B?NVowRTJzYk9rQW1KMzF3VFgxN1lUQjR3ZzY5dFllRUxjRm1HZ0FMR2EvVzR4?=
 =?utf-8?B?ek16WmhiYmRMK2t0L095QkdxT1N6a05Pdk5xY2VkaDhIbHFKTFB0VlVrYUg3?=
 =?utf-8?B?bitFcTFHdGlkYjNJOWRZWHBZMERtcUFkelVhVHFXTU01NW80WmJoZzg0VDlD?=
 =?utf-8?B?YU5XNzJiZFNvRUxscWxiaHQwdVF0Q1RpL0N3V2EydU9KTXVaWXNGUTkvYjln?=
 =?utf-8?B?STN1a2ZzcUUyZTJkd3BacXowRXRuRm05WEwrL3ZyeGtwcDRNRFVPNmZqRnBU?=
 =?utf-8?B?bUdGTGFOSzZ4WHc0OU51Z2twT0tPMWFENHpjK0pLam1FMk5GdjJSWjBXRnlx?=
 =?utf-8?B?dnRvY1ByK0xtMHkxR2VPMC84RFp5ODhnejBTa200bXErQVhLdFR1ZDEzZzZx?=
 =?utf-8?B?eEROTGFidkFBZ1BWWlBFa1pkd3plK1VMWC9jZjFmRTNGQnZRZ0p1ZHFYbVpQ?=
 =?utf-8?B?bU1jU3hFdjlYVDJWZGxYamZHRWt6Wi9PUVdudzhPR2ZpK3BCUVFPVUwxR3Rz?=
 =?utf-8?B?cmtaSFozS1pua25JVUY1cDVpcUxoT3hZM0NpZ3lsdlYrTksyQXgrcnY2YkFt?=
 =?utf-8?B?MVpvSSs1WFV0ZTl4ZHpqeVZEWDB2V1BySW1aWEVwTkpubWFSK1FxZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae85106-ed26-4fac-32ba-08df25ebbdbb
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 09:57:34.2664 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lSPC0+6YaEDAvP5h5ZKE4Ne5RKVIeQh3fRQCSIYM18bBlMi11psX8rMiZ6Eotzuta5E1vXhU1VsyJIIPxazZIX2qrek120TknqiU+zywcHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11589
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

Hi Jonas,

On 8/4/26 11:44 PM, Jonas Karlman wrote:
> The rockchip_get_cru() helper is used by the sysreset_rockchip to get
> the SoC specific CRU base address. The helper may trigger a full clock
> driver probe to get the fixed CRU base address from the clock driver
> private data, something that can take several ms.
> 

OK, but isn't probing the clock driver actually making sure the 
assigned-clocks, assigned-clock-parents and assigned-clock-rates 
properties are respected? There's *some* side effect. Considering the 
current user of that function, they aren't doing anything with clocks so 
I guess this is fine on that side. But I'm getting a bit worried, is 
there anything actually probing the clock controller driver if we don't 
have this anymore? I guess it's fine right now because we only have an 
SPL for RK35xx and thus have a Device Tree, but what happens when we 
have an open TPL?

> Change to return the fixed RK3588 specific CRU base address directly to
> simplify and remove the unneeded complexity of using runtime lookup in
> SoC specific code.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   arch/arm/mach-rockchip/rk3588/clk_rk3588.c | 15 +--------------
>   1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/arch/arm/mach-rockchip/rk3588/clk_rk3588.c b/arch/arm/mach-rockchip/rk3588/clk_rk3588.c
> index 250ec423bd24..9b112e45f1de 100644
> --- a/arch/arm/mach-rockchip/rk3588/clk_rk3588.c
> +++ b/arch/arm/mach-rockchip/rk3588/clk_rk3588.c
> @@ -4,10 +4,7 @@
>    */
>   
>   #include <dm.h>
> -#include <syscon.h>
> -#include <asm/arch-rockchip/clock.h>
>   #include <asm/arch-rockchip/cru_rk3588.h>
> -#include <linux/err.h>
>   
>   int rockchip_get_clk(struct udevice **devp)
>   {

There's no user of that function anymore after this patch, so just 
squash the patch removing it later in this series with this patch here.

Thanks!
Quentin
