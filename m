Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3465C61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 08:09:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 393D9608C6;
	Thu,  3 Sep 2026 08:09:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nbZz5BM2Akel; Thu,  3 Sep 2026 08:09:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0556D60869
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788422971;
	b=e/2kvRQh98gqL8XX/lKzGTpALEVtW21k7wwUh/rXlKsuPZHn0L1/P4O/d7K3Agno8JNr
	 1s+BuWkF8MqyYUoi79s3tOUvipVST5B3gmPdLdAOVIi5uAhXi5PTCEqRgS4dzANrvJXfB
	 a7eTYgnajENQFh336mDa65hE8PTI7G/W6/gxT5ViFZr1z5JPlDXEN204ls3nOmt8Cyajx
	 m22CbpfOWZHjaLZc1droCEyb1gXjwCGUbQ1ax0wTrPCU/IulbTvyt8UZI938y4ALcyEDb
	 aowhnHAxTkGaIsspmS3Sqef6sEoGQcvteivmmeSdXFmUUWkmvOzn4XSrXw3jpBwH5Yw==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788422971;
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
	bh=fUbMievdQV7RYyxDjk7XAA2RYsbgAwfYeFDcDqQhnoc=;
	b=qFBIzv4Zyt7PDbSdQUTMgyQMz/+nWsS26c5T3UWcLjWvQk/+1Tk0uRubxThTfiRFE7fM
	 qriBZlWUxa2ooxIDAlpKY4F2jY52qfTV0WblDEtjQmGLUk5r2UZO7zwmqSMHgBTEMVZKj
	 ewKT6UFJxH0ycXfJUGXAHGp8Pr3PY728yOMsk3X3dz8u7ZpI78+KciHYn3OgdTWHlAqqw
	 OUb6HvJVb2eMIdKOwPqKh+BfpB89csCFuILtLnnlcpSXlFem1/0uBiptno0h8Wlzv+SgD
	 NU4B2ES0afBg5xG+c9lZuP1WE0dFaykIW/4quKa8hFjg/9NvNwBLgfYTDY4giuTIl0Q==
ARC-Authentication-Results: i=4; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788422971;
	bh=fUbMievdQV7RYyxDjk7XAA2RYsbgAwfYeFDcDqQhnoc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i7/gRSoCTSnQY7AIqgeIr7njyYqalA1PfUVPmPdMq8Po8ART36bkswu67auiIM11M
	 X4eBPazuvHBniq5r8zMo9y1gLrMnfWXqqi61ocTgi71mW7jV74m/3j2mGN4ayrjER4
	 sQqwY19FqyY3vQo6tAZnuD4CJKalUaQyKUUfc/Rz5SgKAms7DkfT//vzq2ZWF7b6mp
	 RRKWpDw9teVKmWd+Qnqk2DRcFHsm7Ctvo/d56Yax18qmIJGY70XK3YxWcCY/qpa9Fz
	 nd0cqsmV+TCP33ba/CHyYdvCvhjaQoKhia73ROeUkcarXIaJvFDQi2rw98KGnoaue/
	 o3C2q/iR4Crfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0556D60869;
	Thu,  3 Sep 2026 08:09:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 830F2118
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:09:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6366240084
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:09:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nMoxf5IIX2jG for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 08:09:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org ABB494002B
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c20a::7"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788422968;
 b=aTy8xMXEj8VKZXIHPoxXy5gI1/jzfelyOkjzzczSdjoE62iM22JO9gwLLda4CjqOt795
 hKA22/pp2RHSocNnXf7ktV9xL0mq0djEx4TnKiiQbYUn+SqH6g2wHypGNSyPh8V/RPcvA
 BKzDIRgVXAxuDuHUaoSKy0VmO7lmkwThVGeulOtssuGm3VG3u5ZGm/zRIvK5RTnwxH+mR
 UwtDg6sWCnBshFkugtACzTYl1oCqLTRkbwQMNIxwISKMYa6pp/aRqUFaARO28qkJ31vue
 tjn/OvUEPxEb3toZ+DwZ1q4HFGgCA2EHRrnASM9gDH3jYt82maG+ZGU4gdSZzP1FJQg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788422968;
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
 bh=fUbMievdQV7RYyxDjk7XAA2RYsbgAwfYeFDcDqQhnoc=;
 b=kA/E0y9ZQd0M4gWOrrg0OHp1hF+4dq4+QLvjAjpURKHVrFuUsNvlu1sn7yGSHLd+ZF3Q
 aEUwR5XyWqvq6M4YAmzItMk/4blVv2AvpwMbm6iwFlU36efOmdF28DmHQUecCE10lA7F0
 z4eHxFb9IoAgjTaHm/aAA2fZPCrbgIr2waAHU+aABHTBfQ9toagn9k+Q6N15fBr0OF06E
 uHGOKwoSTN/vJNAvUDJGLacKlHgMAhF7aC2c5bhrYLCXLh59FQjDjcQcTs3/tW5yeC5RV
 uEuhjxzcsdK51rrwuzxbAMHMB0O5ZqyszYo4QaBhJJP3bn4bRPdbr9VKp2B8It2rFKw==
ARC-Authentication-Results: i=3; smtp2.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=Cg2sLFbj; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=Cg2sLFbj; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=Cg2sLFbj; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=Cg2sLFbj
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ABB494002B
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:09:25 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=f5/oSzp2Y8nhZWDTx3szNYdgSljy/F1PB9Bk+Qg4ipKfLG7nLTk4aj+Suu+HTlxP2HS5ANH9AcZEEbJx2YzyiDNr26yzKihvoc//hYVaoYD1T6LXhdx3LM4Cufnx1LChT2TRw4JHeBYEXKkW4ToZQc39b+E+EtRAFg+globKzU3HOFyiWpWqvwT6Nld4haHDFngjudW+sXykKXGk+PWVvpW500GKEoEt5O15p12iUJ8l1QmZuteBYGgBWRjQOenm/DvE1XOzraVQDqFRCi6PjLVYesECX+2nI82+KKP+vbkIA7W8Z33ASkYbnZau2e7Uw80teYzIVHz4M/Br8Xg6ig==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUbMievdQV7RYyxDjk7XAA2RYsbgAwfYeFDcDqQhnoc=;
 b=xd+JLCCSj4CDV33uzfLNamYn9V+bBQnbv97fbbhxceOGQduYFlVsytwWS6qwbHHTMde87LIrLpHijfxPW0KNb8zPV3bCOETLAzcmahl16pOaI/af4fPwabtt7FEjNZZ52gVcD2sxpByy89wxXFdvJ76fB1CxXagBQ4apQCXPhvUS0WaDV935UMM87aUryG59DRQlZiiWsCAp4385NU8JzpuUgJ0WBmPcP/OwLFUZJOtBtKjcLB21KDpS5jRjakuBp2OO2sN65/obEfr3aBrG06VOE7PwI3H14S4hDpsKT0ZZs4YSwh3EJHKHJ+LLjpZrv4QpkDl4WoVvhU64rqJWmg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUbMievdQV7RYyxDjk7XAA2RYsbgAwfYeFDcDqQhnoc=;
 b=Cg2sLFbj0FYqZ7WcoDPBGFYa/Icw0yKsY/QmsBuev034QySTGekpRxWJtCtHFnjqLDNeFn6Bco/tctWrCdaWnjZOmVG8837jCM4CmsGyLffK1i6iyfgx37oyKbof+HeJ4yoC+YZQR0vFhBp1fy+eZYZN40ELTkx2TTPTwzk18P4=
Received: from DU2PR04CA0220.eurprd04.prod.outlook.com (2603:10a6:10:2b1::15)
 by AM8PR08MB5843.eurprd08.prod.outlook.com (2603:10a6:20b:1df::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 08:09:14 +0000
Received: from DB3PEPF0000885C.eurprd02.prod.outlook.com
 (2603:10a6:10:2b1:cafe::12) by DU2PR04CA0220.outlook.office365.com
 (2603:10a6:10:2b1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Thu, 3
 Sep 2026 08:09:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF0000885C.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Thu, 3 Sep 2026 08:09:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gcn27OMrQu3b+Pbzb7XBo++BKBkYDZ3RuVA02VHdRwGDMinZVZfCt8PCxKf1SzQMPXEiiDSQOT7uJMRTOnhEDKpIzgFxdHLhSoKq28hlZjHuqfPq/D1QDCV0vihH0NFX+ZnsOe/w/Ui0d0x/sG/ibJRwPgeywgKvSMpCP7FLFUyaWIhlAdpJUnpqgCUvaeiBiRaRbEW2MMSXjbTi/PdpZjc0AiwU1h7nYJEBHqAk4alvywOJWcnxQce34mYYNIlEsMV3Pm1/Z7ApktU8BR4LnnQ+XDrNDlzL51CedNal/UT3y3Qd3DVm47SToDsnH4zI5G5EAwIzMRcXz0Et4r4X8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUbMievdQV7RYyxDjk7XAA2RYsbgAwfYeFDcDqQhnoc=;
 b=AxBjrX0eKLOagJ4UMZGN5eg7CF3KhbfMcdLIZsglnt5EZLyPoR1dgtZAjsuZtA+LxsQ/AHHcPeskwYKkp8kOYDT1cszSMZIV8n+3RhBT9XR1G+dh7DcdxEqlUO+ytWfuZJwJjF0O3k1vHVJqmeRWu9ZgUbXPpPNhj2YzzlsiDnKun7npMPeQd1bSAQYNnLsybvbi09sSTlHWORMR2JEYjn4Xp0uIRCozKS1LHYlw1nw9/NWH8tGxP5329GQ1i1drTDnz53eahZ63fOEVLcnfJb7qu0bwUotLNJvgLkYxc5H5arxJ22XkW7drZqyN9OGHLrRqOSRYYPtZ8ZCFjQe+5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUbMievdQV7RYyxDjk7XAA2RYsbgAwfYeFDcDqQhnoc=;
 b=Cg2sLFbj0FYqZ7WcoDPBGFYa/Icw0yKsY/QmsBuev034QySTGekpRxWJtCtHFnjqLDNeFn6Bco/tctWrCdaWnjZOmVG8837jCM4CmsGyLffK1i6iyfgx37oyKbof+HeJ4yoC+YZQR0vFhBp1fy+eZYZN40ELTkx2TTPTwzk18P4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DB8PR08MB5465.eurprd08.prod.outlook.com
 (2603:10a6:10:118::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 08:08:40 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 08:08:40 +0000
Message-ID: <36e18968-f8bc-40b5-886a-89c0690627d8@arm.com>
Date: Thu, 3 Sep 2026 10:08:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] net: share the lwIP runtime and support
 netconsole
To: James Hilliard <james.hilliard1@gmail.com>,
 u-boot@lists.u-boot-project.org, Sughosh Ganu <sughosh.ganu@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Naveen Kumar Chaudhary <naveen.osdev@gmail.com>,
 Luca Jones <ljones@t0.technology>, Weijie Gao <weijie.gao@mediatek.com>,
 Pranav Tilak <pranav.vinaytilak@amd.com>, Simon Glass <sjg@chromium.org>,
 Vincent Jardin <vjardin@free.fr>, Quentin Schulz <quentin.schulz@cherry.de>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, nd <nd@arm.com>
References: <20260901-submit-lwip-runtime-netconsole-v1-v2-0-3e3d95627cf9@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260901-submit-lwip-runtime-netconsole-v1-v2-0-3e3d95627cf9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0618.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::20) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DB8PR08MB5465:EE_|DB3PEPF0000885C:EE_|AM8PR08MB5843:EE_
X-MS-Office365-Filtering-Correlation-Id: 768474b6-0601-4a7b-a9be-08df0992a425
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|366016|11063799006|10067099003|18002099003|22082099003|6133799003|56012099006|3023799007|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info-Original: UuBQhc5pwgYTL+rtXr5Pzx8aeDRj1DnkSV/8l6SW7dUZzHVIbCszPptqcr6Jn7DziN3WiZ+m5oTMLYZSkYbOq0Z8SEqcpCzbPOTEJEepSxhOgknr/WOExcImSXmUcJDqfmuzZ4x3g38jiaUlDzehJJDQT14vs55MBPV/DIabQBR97bGUVzu1W+1iNI2CkzCyc2N5SY2/NAENei7fj0HtcmpA0KgOlVZtgp/iQ+USFKtis4HmKn9MD+tBZrvD5/M1yiEE1HROQ6WrS/IoG11OBDjDGKtvqcYkeoOnoVJsPwBWtRB0jXh8bqT2u6fzrNZ+vbEDQGHQQPlIYYf1b0/BrBYoVQKqe2Ih0h0mIRp20m4x+KwTDIOYrpVjcvyrCcf9nKLSLyPOHCeF/IW9hG8ZjwPETlg4NFRusrFDsuIhp6077I9Y0+/VUc0unsflz2eia1vzwiKjqT2DCmuzUQPOnW0AO2H/HTZPJSfCc6Pia223FVWL8ndhRDVVDrih/d6Fg5H9pwc6cKTOznpBkgkdPjA9oPPmlEJedL8LK16LXqBEHcKeJw982UXJhN6b2AmN2G1xW2QX32duQ6TFnwIHWF83yhRwZj0bsE5duLcMn9uMWmWabQAXr++WK0ziQMTLAgf15rJLFwFIuh6kTCdSWyNm2yxWwtnbYf8YE007o43Zg/qXXscTv0DvRJOHSzj03ql0ZnuqeZn7urGhk5M+VA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003)(56012099006)(3023799007)(15866825006)(41080700001);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: c/qfi7Yk5x/GI6rly5PaNnU0/iGeyDrVt2X9IdHi7Mrw19r7p2Pix+0NvvWvQCjeyAPCgZzJwQljx9+avl9Hu7GbvlPL8iZbZF4OmIPtxy8REO70/u6CiuQWYAaOFIeb27RnRMLeD+/5axBA62BQ9gzW9/4A0GOnd19uyYoPpsWCK18tKtBPXI/f84FkwzTfZ1lXJbX8Yjyefj8DXQVvLktn1NH+uvqoMNO7TZ+45HfVDAAV+qzu+fDMva9LGad0t3DL9jKQDNNseLKKTM5RsHEDzrAbsUVu52vX2C4XHO6HWTTI0qAeafSiOTs4Fl7K3TCWgDk0UcFBg5ov0uhV5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5465
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB3PEPF0000885C.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 76ed9904-3124-4067-6db8-08df0992908e
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|82310400026|1800799024|14060799003|7416014|376014|23010399003|36860700016|13003099007|6133799003|3023799007|10067099003|56012099006|11063799006|18002099003|22082099003|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info: SKndfVuxo4+DiRu6W1QfBoU8m1k1VBH931lzsSUO4cvn88hl24cnhIIp2jA+L3YtIGu1kbvlGwVFWZcWt11hpKEyB4LlRQd6SslrUjB/TZofKLDHo4N8Hq3TWtk0jPr6n3Wxuc81rlJY30Ubq2UEtElPlen+sfbgkNF0uZ7Oj+addUnWPF7ja2BOXsSvVVCKWT0Hv2LB/zxWnkBXGaYlCClpEbZ1f9MKJy0B2dmbxBbb3SlRz7djjtlVGYsfI1Xbek/PlHAczF21yrC+vfEV0wfVeFLNlJTWd8/glyu2O8yqsbgAX7ldi63e7tMzmpj2WG7gqn+lrNR6mZk/9lVr96ALac9BsPu0RdsQE+Jfd5lLzIIrGYEt35tBxxMkixpGScH3oQ1f1lRbsyMOjX8XGq7alFm3PFNTCKdQXdgfXuV+nQaWXbPSvn/nvOOdNmCcdCU5sA6PYRxxMVJXaHGInfxv0Sv+wL3l6AOWsyz7uiG47ROMozMHZ1X9bENZ5h/BFs7+8KMmeoLtKcV14GFyIFxoNbcpYM2Y1GQM75H/OYCU+B8OMQuEBR9HUcMr3rwOUXXeY/wzbxo+HkfmdAfgKSkxBpI/l+CUjCiZiEe8P4IhKeG5IqgWANfeSB13Qrigg/UBiSUI4DkaOv00c6K800Iapoqxl7l9yJVGwk9GB1fyt5So9x4E+hEeXUf4rmNqA3mYzdbNPn18iDFkuf7HJg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(82310400026)(1800799024)(14060799003)(7416014)(376014)(23010399003)(36860700016)(13003099007)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(15866825006)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jIjLv3LKehsEouidfeOv6Yo/5bkzTYT8zTu59ukBKWFugi/2hxj7LaQ7aTO60CDfhcQSGIBXdSDVedHw/tc1ztaWD/BxagIIEVyUS57dDHBau+76BCPBzw3V4ImB0NKuL65r/EpBD44EciYeNsfx3RHu0zn0IKoc/fR0j5+zo7ogYFpWbMVEGQVBxX50aIRFOtQmMTBM3/GZtqyNrT/S4B15dOcez5l20gc7ImNeU5LNhdp1PU/L197yGY3ikkse/pLkOztgP6uKx03dmn78YJbfS4+1qaF4ZKg2810tz15RQj4r+3AIbk4QxP3x+YBVn9eCST/nq6I1BrfRBM7NYhBX5fkKbtbsuowkuJurq5l1Uf4D4JNJFGdkYDd3eyYNpwuony4EocGs3l2VJ7llKl0MNTf0g+BG8ZgCoIgOvfRcqd6vpBpdTDAvbI06PBXA
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 08:09:13.2541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 768474b6-0601-4a7b-a9be-08df0992a425
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5843
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

Hi James,

On 01/09/2026 19:08, James Hilliard wrote:
> lwIP commands currently create and remove the stack's only network
> interface for each operation. That model cannot support a persistent
> client: starting another command replaces its interface, and either
> client can stop Ethernet while the other still owns callbacks and PCBs.
> 
> First correct wget's existing receive-error path to return ERR_ABRT after
> it aborts and frees the TCP PCB.
> 
> Introduce a reference-counted runtime which owns one Ethernet device and
> one lwIP netif. Clients retain their own protocol callbacks and PCBs,
> while one non-reentrant poll entry point services timers, scheduled work
> and every attached client. Clients declare whether the IPv4 configuration
> must remain stable. An address-less DHCP attachment can coexist only with
> flexible clients such as netconsole; environment addressing is restored
> when DHCP detaches.
> 
> Migrate the existing lwIP commands to the runtime, then add an lwIP
> netconsole transport. Netconsole remains attached while a foreground
> network command runs, and that command's polling services both protocols.
> 
> The runtime permits independent lwIP clients to attach their protocol
> state and share the poll loop without creating another netif or Ethernet
> owner.
> 
> Sharing the stack makes asynchronous teardown significant. Add DNS
> callback cancellation, HTTP client abort and DHCP stop-without-release
> operations so clients can detach without leaving callbacks or protocol
> state behind. The corresponding vendored lwIP changes are kept as
> separate patches for upstream submission.
> 
> Validation included:
> 
>   - sandbox W=1 builds and DM tests for runtime ownership, multiple UDP
>     PCBs, address handoff, callback cancellation, immediate abort of an
>     established HTTP connection, nested polling and netconsole
>     input/output;
>   - no-DNS, sandbox_spl, sandbox64_lwIP, qemu_arm64_lwIP and legacy-stack
>     builds; and
>   - H616 hardware tests of bidirectional netconsole, a TFTP download while
>     netconsole remained active, TFTP upload and HTTP wget, with matching
>     payload checksums and successful network use after netconsole detached.
> 
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> checkpatch reports expected diagnostics for patches 5-7 because vendored
> lwIP code follows upstream lwIP formatting. It also reports generic
> MAINTAINERS prompts for files already covered by drivers/net/ and test/dm/,
> and preprocessor guards required when optional APIs are not declared.
> 
> ---
> Changes in v2:
> - Add strict and flexible address modes so DHCP cannot disrupt active
>   protocol clients (suggested by Jerome Forissier)
> - Prevent environment refreshes from readdressing a strict client
> - Test both ownership-conflict directions and strict address stability
> - Link to v1: https://patch.msgid.link/20260825-submit-lwip-runtime-netconsole-v1-v1-0-0892966aa758@gmail.com
> 
> To: Jerome Forissier <jerome.forissier@arm.com>
> To: Sughosh Ganu <sughosh.ganu@arm.com>
> To: u-boot@lists.u-boot-project.org
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: James Hilliard <james.hilliard1@gmail.com>
> Cc: Julien Stephan <jstephan@baylibre.com>
> Cc: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
> Cc: Luca Jones <ljones@t0.technology>
> Cc: Weijie Gao <weijie.gao@mediatek.com>
> Cc: Pranav Tilak <pranav.vinaytilak@amd.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Vincent Jardin <vjardin@free.fr>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: "Lucien.Jheng" <lucienzx159@gmail.com>
> Cc: Mateusz Furdyna <mateusz.furdyna@nokia.com>
> 
> ---
> James Hilliard (10):
>       net: lwip: return ERR_ABRT after aborting wget receive
>       net: split netconsole transport from stdio frontend
>       net: netconsole: use unsigned port numbers
>       net: netconsole: cache environment settings
>       net: lwip: allow DNS callbacks to be canceled
>       net: lwip: add an HTTP client abort operation
>       net: lwip: allow DHCP to stop without releasing its lease
>       net: lwip: share one network runtime between clients
>       test: dm: cover the shared lwIP runtime
>       net: netconsole: add an lwIP transport
> 
>  cmd/lwip/ping.c                                   |  41 +--
>  cmd/lwip/sntp.c                                   |  19 +-
>  drivers/net/Makefile                              |   6 +-
>  drivers/net/netconsole-legacy.c                   | 156 +++++++++
>  drivers/net/netconsole-lwip.c                     | 200 ++++++++++++
>  drivers/net/netconsole.c                          | 201 +++---------
>  drivers/net/netconsole.h                          |  29 ++
>  include/net-lwip.h                                |  48 ++-
>  lib/lwip/lwip/src/apps/http/http_client.c         |  71 +++-
>  lib/lwip/lwip/src/apps/sntp/sntp.c                |   3 +
>  lib/lwip/lwip/src/core/dns.c                      |  26 ++
>  lib/lwip/lwip/src/core/ipv4/dhcp.c                |  39 ++-
>  lib/lwip/lwip/src/include/lwip/apps/http_client.h |   1 +
>  lib/lwip/lwip/src/include/lwip/dhcp.h             |   1 +
>  lib/lwip/lwip/src/include/lwip/dns.h              |   1 +
>  net/Kconfig                                       |  13 +-
>  net/lwip/dhcp.c                                   |  57 ++--
>  net/lwip/dns.c                                    |  24 +-
>  net/lwip/net-lwip.c                               | 270 +++++++++++++---
>  net/lwip/nfs.c                                    |  25 +-
>  net/lwip/tftp.c                                   |  54 ++--
>  net/lwip/wget.c                                   |  72 +++--
>  test/dm/Makefile                                  |   6 +
>  test/dm/lwip.c                                    | 375 ++++++++++++++++++++++
>  test/dm/netconsole.c                              | 344 ++++++++++++++++++++
>  25 files changed, 1697 insertions(+), 385 deletions(-)
> ---
> base-commit: 3f19667468fb93bcb5702d23aa057b72639e3ac8
> change-id: 20260825-submit-lwip-runtime-netconsole-v1-9c08ed87e0fe
> 
> Best regards,
> --  
> James Hilliard <james.hilliard1@gmail.com>

For the series:

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

I’ll apply this to for-next, likely tomorrow or on Monday. I’ve just moved house,
and the machine I use for U-Boot work isn’t connected to the Internet yet ;-)

Thanks,
-- 
Jerome
