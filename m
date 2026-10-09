Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB20CA9EBD
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 17:06:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 092C640953;
	Fri,  9 Oct 2026 17:06:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vteA779v112d; Fri,  9 Oct 2026 17:06:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4E0FB40923
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791565615;
	b=W1l7pz03KnDay4JjHdsRucTY6q6nA17iBHAq5rl5TC15y92ikW4gN2NEqxrqIJ3wbHf5
	 8affdTmn0qSwYyA5mbYuuo+OMVAotQIs7EX1s2lMFc9V+KPV1sPmmMiKGgPTMseiQcefY
	 I7C4xsIwyHNRVCIicyAKVqr+QwFrkm++09TvlbDfE/v/3HSzwYB27x+77q6lXnnyNaU+w
	 ALIdL3dRltlC4chgqd/PIyA2hHE/ZIVVpa4dLk4VhfLJOeu6pkigUd/cpaZ/0OXIKqzDi
	 bCYTXbU8vZMW/b85cIvQWp4oO1K2Qv8BdgYLxATeA1LTolhUj660WoiMqd4D5UXSqKQ==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791565615;
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
	bh=aisqtoka1SAyU3xM63aC8QEi1jlPL0Vx86+WrdF2G8A=;
	b=ICQZsDeePcqfKJ6cJsqbvXze7UokJ0lloDOH0vikqsVLCwsOpdMb+2pQsg/adLZo9HsO
	 qtGSTF8ysNJByP/FlTwIrSkPGV4wGKagAdFn/9ozCOc6pl2Bp/TySjnL3JH/LAOSXv0NN
	 hSMZVNv6acguZ3TNQLewz25ebsH+OvBP6ZiclGjHKi58q3HOX99xrioN7eGc0zD2wtqwl
	 DbdUKJyD90Fdg3no36qBGJUqjThPM+TTY0linF2t1k/uGCItiGiO0WUaJITm5PqkNAZJW
	 0Jb5xyvMzCa6w4FHzo12Nvj3Ipt+zPD12aVZawU/xx1K6V8eujbCPUSU4+ttz5viE5Q==
ARC-Authentication-Results: i=4; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791565615;
	bh=aisqtoka1SAyU3xM63aC8QEi1jlPL0Vx86+WrdF2G8A=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XuKjWibgC0j1ZF4J4e5m80CHbkIIf0KEQbO0LftMX2Y/x+9xZe7Xu5sD45zDOSjgX
	 +6nNS3olekWRQUhcTBAr+f06EGYGpgTa7hO2smPrpfF0iEnKTWEfP4Ba5wjIQ5ptbI
	 nQLp4ykY+sjas+8GkDJOx8Mm8XNB0b35GwGbgn1Igfrx2zAxvRZlQ8U56ejkp6p/n6
	 MtPi+eI0jQqFErqU6MMZ4ewCHz9vP/8BHYqwAF5/XzulIr5v8PoUaBw8FiNW82WkwQ
	 UPNqenxjdumGiD2xo/jfX7x+XEs+jtSF/otCcMr4Um/2TVfhXul9UECrRIkEhclEGL
	 sfqQaa60Ho2Sw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4E0FB40923;
	Fri,  9 Oct 2026 17:06:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6991594E
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:06:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 501FF400FD
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:06:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HWNk0WvyqOXv for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 17:06:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6F57940050
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c20f::7"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791565610;
 b=kMadm3OfCntwKH791kxCsgwssE5CbXA+VoDqQ8I5a4eZaaNrm7tSMilEIpSyukEKmPNw
 VFWB41u8fe7ROvhSJA+7YvQe0W/7St/FZvstkCOnGUfnB6/QpB7iuRqbiaJ1HdzeORZ/F
 fxGGaEyu9o2YM7pKh9Ddbmjeb24DB0L+4L6K+KP2Ug43Kza70N3wyQwJnfvVhmKkI/JZY
 NvG5ly1I4JTOEiHNZIRlONFHLnex6NOltV6VG32uU/RsxBMvMBfIlavNC5HlatKOW0v9w
 X69nAj/0yehiTMtJ4bGdgsCLO8CuGQkP3asUtudiFSopWL8tD6qFQWgy3c0940Y4iJA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791565610;
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
 bh=aisqtoka1SAyU3xM63aC8QEi1jlPL0Vx86+WrdF2G8A=;
 b=ptYpTrTdqkSqEUbeDAZPbzUCZI16X9AqbSkIlc7Cijqd5XsOEsy8VCt1mXPqkagFGPTR
 PBpcCoXymwKgOCQaPdemYqHsj3XjA4dxw0qWDHb1AqA5fdp7o/is/pTMca+GTAi21ZdhV
 Adn4lu4i7fq55ye0sx4xy8VlU7SkSx/R5pvaDS6BySRx/IlTpmipgYR4dpKKdIaT6ikpq
 I+MqmJhtJSMsk91pQI/nQVKRQioH47FFw6EhbBmscmC9ggzu1RrJscvr2np3T3mhoY3et
 VRtr5saqo3mb/SZQck+JCTBvgSS36z73DkP40R9rGrgWDfft4dVcda1LZtDKegIyehA==
ARC-Authentication-Results: i=3; smtp2.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=XsaskL8s; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=XsaskL8s; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=XsaskL8s; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=XsaskL8s
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6F57940050
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:06:50 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=TgGrZi9drhXWCujX7MK8ADbbWd5PqNq4Che8TqcySHhMqNXj0tlGJI1RR94y82YziJZmglRWyXA54EiKaKTPWvStwiepas6FuUuHUUleyInd5LfZgTrIPOk0oVErPz5KkbG3v3qGGbmwAUbDoGAfaq5XYn0XMOFfJTCp4gB7+p4SzUg9GZ3GaN6jwMm1SOa1q9EdQzEGEL4GhoqQx6YtU9WI5JXf97Ax0Bx9ExkxzZ2MVfM9ICpQVTGwKztBSArNE5mtMgR2/a9/qpditLEjTN8P+xUEvn597nXOuWuPOjQfqHnJOyMIFVlvvogOKPuzWG0O38GeUf7h0eJdkFmzFQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aisqtoka1SAyU3xM63aC8QEi1jlPL0Vx86+WrdF2G8A=;
 b=i1Wz9Geo9GNm6/T4FomzbsxLEffnOiCJSEVsTDxsqHNf/PL1iUvrNSJQmSMQ+tCfSJuSjpvWLNAAXBqlCnHuIg0dITrIT8W2e+dgCQqYLsdKKjg/mzrHNl7F31YrNaK9R6o8mOlgj4Edx7na/TcCckdbOPWfUp9mVb3kRJW3K2yZrkqJC0xS3JGfB6iLxqjskYneHAg8RH1+0YtRX/bab7rt/xxfgekddp9XJBnTrZhmmO7bebv0IF75w/HWIhV361j44XGkdD0VqnuCPGxbgDt4PK0mwKkK8IyqiPB/Lo2QbaHyR9VtkhHiUqPMOn6+oLmsNQBhkw5N12FU9gJoXA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aisqtoka1SAyU3xM63aC8QEi1jlPL0Vx86+WrdF2G8A=;
 b=XsaskL8swrxVhlH7iiLk2zBfoydIcv9bcr2DgH2gS07H8Ij2bFT4eVJLZJxaJ8qHdPegB6G1t21gVDmocugpBGGSeWgWp8b64DXvuigBKEQYgfNof6L3RNEX4G/Dbm4wkWWL/iqXpPLvJLtRwHk4YbGWIhMXmQPX6IcqJIrHEPY=
Received: from DU2PR04CA0154.eurprd04.prod.outlook.com (2603:10a6:10:2b0::9)
 by AS8PR08MB7816.eurprd08.prod.outlook.com (2603:10a6:20b:52e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 17:06:41 +0000
Received: from DB1PEPF000509E9.eurprd03.prod.outlook.com
 (2603:10a6:10:2b0:cafe::1f) by DU2PR04CA0154.outlook.office365.com
 (2603:10a6:10:2b0::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 17:06:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E9.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Fri, 9 Oct 2026 17:06:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyM8QpUy/hIkW3vripGmBS4auHIp7c4FskQHa620u7D/6i1wx9stkhWvw6nbxHwkA2rKlY91FQpgDgEew/eHgdoRjGqOa15xlYNGZRmH7O7aIxl1i+bt++pmjK68Ddc2V0lLukTea1NCQ7ftSouUZ/p2kXne7zC9cyWniS1b3b8nNme0HcAozX2Dmp6H7dPCvxUnYGKWj+YSXX4opFPPoIapqCG1QjEs76S+rdwOfZfWuJAymMqmfx8CDjbxpBiZv04DtWMYikcaBb2IJoV9vrKH8LGOOxoxWW/l8Ijg9AnVf5bosGN+FAYa6Cu8nfBbD9n4uG8aYhhFIlG72wr8cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aisqtoka1SAyU3xM63aC8QEi1jlPL0Vx86+WrdF2G8A=;
 b=ay2wjfa2MFfEdtEH5fzxzaGR1YnjAY/d0/XlV2+JJ9AWmTw0X0aFhHMdEUonkFhN1Q/YSyjrBwN+xz3iSGlLAKca2FlB6CGRP+vQ2xCr1hzifQp5O+TD+cUyLME2B2HxhjcD36Dv/y6FOiQ7+A2dCtVj98CHaDZf98GE7lVTzIWYZGH75gPb7pkqYnfUGPHzZWbRMI0fs3mfdcciU/rREebVwBCKYXyvI2uHipSSL48ffag26J1Rbolnc0WIAt2pQs56UAHSMZNcDcAycnbnoZkvvj6+SxbMGKIIXeYbiTF0g4VXZFkM+8Vkg+UgBp2DwhkcKCIAJ1x7alkJTguMYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aisqtoka1SAyU3xM63aC8QEi1jlPL0Vx86+WrdF2G8A=;
 b=XsaskL8swrxVhlH7iiLk2zBfoydIcv9bcr2DgH2gS07H8Ij2bFT4eVJLZJxaJ8qHdPegB6G1t21gVDmocugpBGGSeWgWp8b64DXvuigBKEQYgfNof6L3RNEX4G/Dbm4wkWWL/iqXpPLvJLtRwHk4YbGWIhMXmQPX6IcqJIrHEPY=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by GV2PR08MB075028.eurprd08.prod.outlook.com
 (2603:10a6:150:381::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.5; Fri, 9 Oct 2026
 17:06:06 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 17:06:06 +0000
Message-ID: <224685ba-ac9c-46ab-af7f-1a20cdb07c31@arm.com>
Date: Fri, 9 Oct 2026 19:06:04 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH] net: e1000: use all RX descriptors
To: Tom Rini <trini@konsulko.com>, Vitaliy Sochnev <sochnev.v.74@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 u-boot@lists.u-boot-project.org, nd <nd@arm.com>
References: <20260928213011.290839-1-sochnev.v.74@gmail.com>
Content-Language: en-US
In-Reply-To: <20260928213011.290839-1-sochnev.v.74@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0142.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::16) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|GV2PR08MB075028:EE_|DB1PEPF000509E9:EE_|AS8PR08MB7816:EE_
X-MS-Office365-Filtering-Correlation-Id: 53c8d6a1-ba82-4c85-ee27-08df2627afde
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info-Original: HdHpQwGt4w6Flx/gwF0Eg4Pto2EfIbFZDS2PhRuh+hCmRnu9A/x7EELfmKUPXnSjKccrSngHN4T3gAVWDcXWBWUjjw8D3vuByxkkvoElpYH6dgrE7Y6yzMH6nvhikYZKDwdQkI6mvPx1OR55Em7ErOBrncRZdPygtfb15lCetS80swuL5gChZ5tkzt9H251a6mOpNI4PowzYnNP7QHA4PlNdlEevqtMviMiKBPAkjKa6iokjOpfOx72RRbXRJK0dXgFmn5LR1n79wCFSbwiHoYEGR8+WjfIn6D5u764nEP7WBO1nQvkyLnZfGtSyybAS4SRUmJyL0eLtuknGxJgM7PNnQ1BDEUwRQXh2fXECOMPFfVV2gvKFyYWV1uCuF25E3+EpL2wLzKE2ykLWFVlUv5l62zge+Ca84rNZfNCA1blvYy6rwg8LXRWe98oL0FMVt9m3tHiFjYAW0wOOdQxIY4Eu1OkiAZhlINdy0ajSlYkWkV3ogM7gOppQLK/NzPeZsSAJnXftq+BbnKdyCekycqcWmKpZ6SRa9g2ggj+R0fUOXeXrUND97bYaEzn+8neML9NPpAu8auY6wC4Zmk47QO2eh6zVHhLyyOCNUjlhInr72SelMkbb97agQeu2nFGzS//M6F9HtWfcjcM0IOzZvryEIKfLLWIUZyWHUbGIzxI=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: KfAjA+EjT+Q6AJj6YqDHdOqUXBL07Kusd974xhI0UQzVWlGeRcw3gYUWgSWRYEH8/oaN/k8Z5SaUrkeO7TBCo7XTbfe+WmtsDkjqw/4eKjML4eFl00nBCsnYq9lwSLcSO//shPjs/5NrKaE07GO2USLq86A+HuihvxPB93HprE9DLkyGU82Hls1qiOklqGhB/btAD+jKLB/J0HCJQZlxVkIc7PXxqDnZXLH9fcISgR03NMNS0jkadvMBOro5rRB78z19AWXrIVOJCDvNoj3JvNEf3kdsBMWIU1wqEjl+0Um0NX+4ciVuQJHCBzlFg8oG20lMNk29emgxWmmaqFXssQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB075028
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 741090d1-b97e-423f-61e5-08df26279b0c
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|14060799003|1800799024|36860700016|23010399003|376014|35042699022|18002099003|22082099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: oMp6lN2NfFTfG+ty+GS5M/3TCBFECIfhWii+UR3JOWsr75jrDOABv6Xn7/eTbnIYZT/ss5Mu+/vX1usHMqD4pj4zGr7T0MUMY1XRg0HWAz0xX9m1tI2IlP23btFE+UFjtV3oudoHHn05/shn/9CGBzFU+oc2G18RjRrYVteL0rrfXUyFcS0KFrx0jeJ+1YRCPElEuv2ifR2XR06xv0SXFAHFj6O5zB+s7IQC7XM1TtWw9PT2GXKbS1NxQNZ+gqnUsum3FD+q4NNeMstTIXDn5+vJqhwO3DIGq87wy9VUjkNyWS9BQm5XWiCXVbyQxlHsYkcU3FzRz4CFr/IalSU/NgQtt0Lcxqm7GpxDiwPd3NguHB+5ExnpmK6xTbJ0jTnMZi9BeHX+k5ZrJfIADLZy1wDN2npETFlA3QB6YL0s8s2FhtFcQm/Qfh7qtBN3GCKTKev8W49+bE0h6Xlkb357ivwcOMRPaxFShy0wUfFdz6ANrPtTgrMSKzBOdosIYEtRsKHLRKk3TrhYKDxtC0o/TFBvKU8w5vT8RO+Qq/i/Nja9bkZa1Qx/zUqeND05ABURDt1v6kaEnD7ESkyP6GdeHHyDnqCGAiMpK2d918PPZGDGtwgubMGvdkwGB4DQTH5E2hUhz3BQdsl7Cj/hoRpxmxVJqKzpme2qhKmoFyOwSedDCghTjD0RQUW4SMuyPhka1qN0xFDRm1iNOQEwrxNG5A==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(14060799003)(1800799024)(36860700016)(23010399003)(376014)(35042699022)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +Dqa3xaeOvc6m0X7WvP2dWITUEnh0ZQSIee6Vvr+RZOFSOzTNKKkyk1iAlYVy7V3uq2JvVtCys6UQ4jcKLcCtYvmJCipIA1OZ51U/kc1HgDRvoXK1Wbe+MfDlw0/4u6YyAbkAUet16FqZMWMNmUOcHoJCywyRT1Bl3QWNWKEdzZqttRZbE4yyeDprs6lJyb3DqsglN6aNhR2TnJDepQBJU8NESFu8Ckdtp1osvxkcHrpY0WIyK29JCRrNcbemJMQNvNaiMfCuQQB5jAbimuvkA+Ts6DGHRfpQ9JO1edBN2RBQkSYSCzMiUMFh27KHI91OSwNkM807EyQCGO7Y4p7N3k9UepCQ0XZh2u/AZIxoJldNPXCWoQpfYX7YqnO0Zzuuz80LSLYWLDAszKivavHfayBiBV/KsgJnmtU9pEy9Q327vKNKp8azDD13J/ApfdK
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 17:06:40.5105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c8d6a1-ba82-4c85-ee27-08df2627afde
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7816
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

On Tue, 29 Sep 2026 00:30:11 +0300, Vitaliy Sochnev wrote:
> The driver hands one RX descriptor at a time to the hardware and points
> every descriptor at the same buffer, so the ring holds a single frame.
> The legacy stack mostly copes, but lwIP opens a TCP window and the peer
> sends segments back to back. On QEMU with e1000, lwIP wget of 1 MB
> takes about 300 s; virtio-net transfers 20 MiB in under a second.
> 
> Give each descriptor its own buffer and keep the ring filled. The ring
> grows to 16 descriptors. Descriptors are handed back one cache line at
> a time, with one line held back, so that flushing a descriptor never
> overwrites a neighbour the hardware has written back meanwhile on
> platforms without coherent DMA.
> 
> [...]

Applied to u-boot-net branch for-next, thanks!

[1/1] net: e1000: use all RX descriptors
      commit: 1041a519902041ea727fee0be6c3453341dfc86f

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>

