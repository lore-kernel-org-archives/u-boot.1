Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EF6C61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 08:41:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D1E480F26;
	Thu,  3 Sep 2026 08:41:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VmJIMWimG1u5; Thu,  3 Sep 2026 08:41:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9137280F1D
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788424908;
	b=aZYMlGyfrJqgJQVs5kUwKpazcz+hBtBT/uMIWifQ2+NZB4NG+AEVRCm5MM6PEElXk3kn
	 yaWOQjahwtWfiTmF3Vmi0lAxvICn2pUK3sBYUeFB594yWSSBFBZl/sWQ5z7Qq6d/o+99K
	 w2v5NRS3/KmQ20OeT0GwwNO2HZ1QuY7hne4zyBwyRFKbZE+Z6V9QKolwHp95HRDzpeEDy
	 /EHCRoYmzlJykud/0MGBE7hloDhv0n0I4/Nuscsysk3nPwomPCip3gzvJgiiDfHB2HaAu
	 z7YtjT0hwZQoPKmHVm2BUedlBQKPKICpZyMVqcRgCzOQk8kCmXD9X3wg8jSBFzXlbwg==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788424908;
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
	bh=OPRptA3EcwrBTSUENgIK2UvXU6kapwt0aam8W1cNw0w=;
	b=GpM3OMtD6JxxIjwmTFtLeOTeM4U82Qrn6cIkkUHv6xItqlVUYMw1VtQerGmv+QElRHm4
	 XCNkL98iFTO0fdT4WtKq2TkcE+7qw4sNegqBrCmU0UQ+eZ3YWPzI63CPj/NBGWcyba5cC
	 EPgopLiimU4jqq7OVfounM3dGhUZGGNTx6FCtSM4GsuFF30T3J+5HnU/lI4YhbuevUH8m
	 BlEneSGr9BRvro/yrKb5z9CxVTB9NQGKC14LEbonv+Bj7QBXBnJm4SuMopQaugcr2vQqq
	 DHVYx0h1MBicitHpdSi7DKvG/eRYF/Wf5dtdyQvKrtLtiR1qqQ3TmMM6nKft6bFiEyw==
ARC-Authentication-Results: i=4; smtp1.osuosl.org; dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=ojKJ7MsA;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=ojKJ7MsA;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788424908;
	bh=OPRptA3EcwrBTSUENgIK2UvXU6kapwt0aam8W1cNw0w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mNQCB8F9o+2tEIFZmrqnARXK8qg68+2A3LM2fNwUujzlmgXeXBzAKlBZQiVIjcPRI
	 J9xheaKYH0fzvWuHTlVyPVZ/aWWUGGKEaejElFimGF37DHsFTvFDtVieKFTTdLq0uX
	 IZRgeR4Hkw8Aw4p37tK8Aku91TniNzpUG+pCeXkKk2Nn8WL49Hv5uugyaqIpKWjmtR
	 vabXhvzMyST+S/Rrwx+tX1pzySQBIs4xn6hjOHipI+T8meS8vQBzl8vvhpQ04BzTOl
	 4vA+J4uzrXfP2QPIAXFJeBbdvvmg+b2jtIgVMLyvtSf7c1RJminzFr8LFbtZ+rSiET
	 BDyPYwlnlc/NQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9137280F1D;
	Thu,  3 Sep 2026 08:41:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 950E322F
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:41:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7A4B980F1D
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:41:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PPBdVN8Rus-q for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 08:41:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4638A80F1B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c20a::7"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788424905;
 b=Faeg3kKeR+LZnKBdJsfq1q3mwzRIoKpmKDj/QLIWlJS7Rzf0h+hfHHgjIpxJ8oWrvYtw
 DB9dzd3ldPXusc1NQ2chqeXuWttEeg4HDASEzpvCj/zIATXgvD2QkqVNf8CzrXTjLXpYE
 nLMChpv/ILsjs9ulKPUl7bBsv8v6H0CQ7OWyM0TS0o+qr749jhHeRlEcRj87j7VSYvw/Q
 IQPGY0DWNq55olBX7JAgcKaNk3ddDlGipfxBKGBwAbwU374n59oDrhYoV2F4JJKu0Ne2e
 HY7j8wDwtFJxMUjB4X1SMEw4f9Ygty2n6mVU+nYu27RHIKFF83lyDWtBWt9Ro+ASo1A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788424905;
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
 bh=OPRptA3EcwrBTSUENgIK2UvXU6kapwt0aam8W1cNw0w=;
 b=j2ATNbZxtwdW3f8P7GoEgmfOseGSynjcHG3yzW/syj9a1Eq9rshJ/hZfgQ1bhWSx0a4J
 yBsBsuorT4RzRC43cFw7+Mk91l7wf+eV4571of0ZZ13/n3FmCxei1a1FgQSVAoazEIy66
 P6Q3UHpM8HxMxyW8nkf6JYyZ8QeN+hF61genHJ//bTGspzdsfwnLzpr9jGWHZCqrdn4yv
 36PZvhw2G7A+/zowNLtAc/zj1I0IzbqcStbrJXXFk43CBrd/BHbacu5HD5DKUdCCdn5R9
 rrWSTT+iIxDDwE27FK6FZraMIggga5BGRNyoyZjJe0rYDUdkGa7JGWq1i8k4k4sTrsQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=ojKJ7MsA; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=ojKJ7MsA; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=ojKJ7MsA; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=ojKJ7MsA
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4638A80F1B
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:41:43 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=BOBSbZ4No7weZb/Ty1JoDCqLV71SOcYM7SmB4rmsRR2vaaNmo6VJ9J7F2c24ZzJ71mFg+YtVHZhaHh8sg+/71lZG7dIskznyvgouC4tuddATQfMIV+jfIqbuyHRK5ebJx7EKTVOZlV/fIWmr74vmZoQsrQcfQeKRkuv5wzmXEpbUnmX1yFIb7GuFNatbUApBhKeX3ckJA+OMwmRNhfyRWPjCOiLAuLrgtuEjOnmv3ne7apf8YHQSyMeDV0uJWeOFB+3r1wAA2skqj7IMCMFemeLEaR0ZxGOlgJim7Dejt9asU31Lpxukbeuigft2j6nxnDDc8mugzafa3MnFfN8PgA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPRptA3EcwrBTSUENgIK2UvXU6kapwt0aam8W1cNw0w=;
 b=i0oD2oUlkNhT0Us1Q2dEnbmCQ55UAsdcCc/aGY+ovX2f9ELMbXEXA8PW++J51U51A5nNDXqNRSOX4VIWao6MWol3KOuUByvs1qQS6bQFfAOjoG1ll4H5ajciZt/NW+i26LPk+9zuzk5kp1h/Dvrn7Pv9MY4/yHVkdeBO/xRogjYwPIsYvF0kbYhpRFK+SHp2bjC0YbsRzm6mvhHTqdPpPHG/SLBgHxEkyQVGqvgnutYKA0aciY74dqT64zjGCNqwFY5UieJ1cvd5AylnRsQ1vyWlF871GejrLUOUHpH1Y82iMF05G9WvjV+DDCLdSlgxeZLTzOivH6cDJ2KbQTlD1Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPRptA3EcwrBTSUENgIK2UvXU6kapwt0aam8W1cNw0w=;
 b=ojKJ7MsAtaXKLjnG9L0eahmnQc9DzYPIOFbhhhymDRA47lWNZITZQZxDzDEnHy0Hz+TII9vdTQMHtiT59GZg1Lc6e+JEh5dYKwDPC5VwX3ma9GlGBl5liILMHWdWa5TlKvAJbHX0N9b5Vz2QTl86Y4RE0me7kB3IhhT2R3mBg6Q=
Received: from AS4PR09CA0004.eurprd09.prod.outlook.com (2603:10a6:20b:5e0::10)
 by MRWPR08MB11828.eurprd08.prod.outlook.com (2603:10a6:501:9a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 08:41:38 +0000
Received: from AM3PEPF00009B9F.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e0:cafe::89) by AS4PR09CA0004.outlook.office365.com
 (2603:10a6:20b:5e0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Thu, 3
 Sep 2026 08:41:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF00009B9F.mail.protection.outlook.com (10.167.16.24) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Thu, 3 Sep 2026 08:41:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilGkibecOmNcKyOcoNhJS62iDf0g/3uww30GjrrbEMOHHGcr8Wp7h8oDhKyI+FvAQeALfAVBRyfwr1PNmKg7mNya9jg5G1ltCjGZ9gptdpkPL8x8Cfrrx8m5OUD93FkfMMPTXvFnHhey+gcU+sN9JAP3fLKF7bXDA4Ja+IltoZvZCx/uA6PUzVT8PLlmZZ4qML7j2HxG6SxdpH2bSIdWaNWnUcghWXrc+DSjztj6QpttRs97VzoJY4StY+kKnhtiRu3D4PJFpslonxATjRF/0yFvpsZglp+7v4GDOGCnYm1QWKEG5wJYNW5fit2IEtUJoS9YwC9Nl45tdQNXHRyUUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPRptA3EcwrBTSUENgIK2UvXU6kapwt0aam8W1cNw0w=;
 b=aW2ZHDIQRg/cHS9Is7DKo2jMkWzdTFckuWkwKKHn23EOxxQwAiFbKrv4Zwkl2zr+PRBJ69+uKgOg0/4rB2LTxvDGUaRnCEWeGzCr/eH+EU5k9A9XMu+d8kSPAanwvvA0MCpQCMXvXiYVf8enXUa1BqZgdvHadZdnNWjSXiU/ol2CqMudxCNVRw4z/tC+qnJZ54A7vdRXraQBzoIL8ER3qNwvkYBsxX/nYv8iR4qYB9XlTxIaoPiJliXY51tZcyy8UrmQ9/mAPx7qFD1vFPCo0NhNlRKJX0LvX7k6iuTIxHwJLQtLCoJTZYgq8Hv4dFoUin9KwA8OtDs5ZOtThFRsUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPRptA3EcwrBTSUENgIK2UvXU6kapwt0aam8W1cNw0w=;
 b=ojKJ7MsAtaXKLjnG9L0eahmnQc9DzYPIOFbhhhymDRA47lWNZITZQZxDzDEnHy0Hz+TII9vdTQMHtiT59GZg1Lc6e+JEh5dYKwDPC5VwX3ma9GlGBl5liILMHWdWa5TlKvAJbHX0N9b5Vz2QTl86Y4RE0me7kB3IhhT2R3mBg6Q=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PAWPR08MB9968.eurprd08.prod.outlook.com
 (2603:10a6:102:35b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 08:41:01 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 08:41:01 +0000
Message-ID: <1d6b6901-ad3b-4c34-b2e7-b2d483876a0f@arm.com>
Date: Thu, 3 Sep 2026 10:41:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: sandbox: support raw Ethernet with lwIP
To: James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 David Lechner <dlechner@baylibre.com>, nd <nd@arm.com>
References: <20260825-submit-lwip-sandbox-raw-v1-v1-1-f9558fb4f6d1@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260825-submit-lwip-sandbox-raw-v1-v1-1-f9558fb4f6d1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0443.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::16) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PAWPR08MB9968:EE_|AM3PEPF00009B9F:EE_|MRWPR08MB11828:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a0ed7e-a1d8-48eb-e69f-08df09972a93
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|3023799007|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: dWmyB2jM7AvkBY4ec49O+4zm/jmydLpdCxFJ10CbXq0MLy6Di+p+Gvywvr6ENhe7BP/56HH2+5qSYEB29BPu3mGC4S/JZYXzLdZlsT5C7a29u5MTRPfhYftDvPNMM/miBrWezlaHtEL2aZXGSkhCslOvWjqYXhuHwpflcIL7a9Wu8HGXs4dcC79w7HqoacAsJFHRdKgoXY2oIHAOpEGnlSQzDtagXT/GuAvgGywmxDq23RGsQVLtSg+s80+VL2jICpA9GJzY0ckVdm8JCmO2nsGAH85N9HpPV0yOyoDnrU5kPwBjCq/D357HlzQMBTze7ouD3lDD5mnpn0vnJH88ljw9WVmV8hzQBFTYU0gzmRF21JRkAggF6i3p+ehcn4MYgYBo0IVwUYGQw84CPSnXWI8xNQa+HiPlBQJUj9BxA9N1I2b0eagvomRk53uoM+u1h3lJss+sMmI7CPb/VFcoiuHEWEM7CWEo42H58XoOdU8d5mtF0FCy7IwtLUmC9YhDr/z+Eap+PldMeh4BlQxEUby8Ls7wCxCoTrQcF0k3wx8tcqm5KXRFc9Py8qRaAM4LI+y+/iJI7nhRwe2X9uX82z+iwH2juzUDql6AK/V8LmiFZ0Ie71tB8VL3fYMgrFLtBXsuhix/O6CvnwUwr+1VoWcf7SUBru9j4eSkcRznmeE=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: JgIoPNU0EFvjPFU5SojEQLNyHhCghovNm+amIzuAM2lQeED5x09OcnqPYcyxh6onG2Yb0oFAWRgayYJevBQPfEEWnViHeF/wdOJ6g8jZVORNMGKKqU6nMVdaykYnQ+SGjRFTo2XzwVOsoocT7uJv2uNeEWuqoLaNAp0WCvN8wDEi2EylxKcGw+fkFQZN1CV3REkSR+4UW8bzIbgng3Jc/ZGHUlHXoMDLwCzyhmPF2/0m9uUBPkomaTs8uqDFn5LxNsG1Pg0UTOdDdbJyB17tmIUtb/nhjCHdEnLFvsdwIsLEwd7jjboAwUYCAXZvvk66woTLQbKaJIBtZbEXTNOIfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9968
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF00009B9F.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 79296811-9f34-4339-cc28-08df0997153e
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|14060799003|1800799024|36860700016|35042699022|23010399003|376014|10067099003|56012099006|11063799006|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bpZjk7Qnd1/OZch4+G87tgdHq04l3zx7r8uwh93pHmsZ5beUDTP9QAbt8aPne1QvmXA7hg0hyzWt6ooK/fu24Y3NTKRnp8GBroCQJB9zNva3/mCA+dW3JOMRaqEpUjpFY7C33XjPIh98uqqR3UmV9HfIbrjQ9HroFaYDJk6VD0tuxQCGgL966r/QvKSvuqe6hqrZGDMKLz+9ZIy0Yx5iS3zGP4wJECW1r9770R54PEH3q35LlMZ5pAK1SJd2D2eiUhG2OOnqg69HTH+Iqh+OHlMx53fuYULKmA00Sbv3rOb2sIHn1ud+9Ubp2leepvNyIe7XeFjQtenEJz7gzjbUsY72Mgr7KUBJyprzK0OlHY0ZaIdM/+wNqcwUm1WL8btCuq2/3o6QdzNCaAYCdTnb6Ixqu+w+pnxap4TbTxwM5/f8Zyu0Fe7dYmDaz24O1AVPktiNEwpZ/2XdRIFVM5dNcKdvL9MdBZh6pVbvyISCXcRWHNeHoIvmJcRflIq5aPhNWMzNTDFA8unDwrHgx89EbFWGOk9BwirOFLUEigvFR5qTf18xFu7x5+hzBdrlsLXrmhLPEKOIpbS/ePbhddAqauIe+QW7wUnOyAabk9Lc/eaohTiQzaFg470eQy6CdKsNZ+ySCP+3AFudYogalyzD5ad5DFrpVQDlP4wUHU9irng=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(14060799003)(1800799024)(36860700016)(35042699022)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(6133799003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: N7l1nV2Yo3RMAllyVL2aoNxibUj6Qn63xWJhbXSIdK0vq//SB78mL8P7WBARycCrL1x/2RqPU/8ZYk5kozf5+qg4H0GXyOh4XMjfCl8obSBv6eyx3cXneEp//5V90cYRrfBKvCxD2bGGX0l9FkCE647pQ/QWLAgcCKjoafcJt3/4y9acW+XhyYMUGHUxK/hL/TayVZmsNsVnZmEnl0qWV0ya26N9Oa5+EwzB8HxMaEm/sAY3IbnZlbC4PvtHEJhQ35DsqnEqy8DmF4O5sJeAmvXysDoxLvO0b7pHy8j3PSWgeRRSpEzOm5yFS6eGi/avScHjo36vAahx0OpbUQcSzHQxPS79FK4xu/2DQpSSpJGTsaBfR54bpaEjkU9JIYMCVWSWtGjyULUeDVmT+3U2KYqpJPD+zIQQNWFZKq/MOMfQP4hCWyHH9bwpY0p/0nnd
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 08:41:36.7889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a0ed7e-a1d8-48eb-e69f-08df09972a93
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR08MB11828
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

On 25/08/2026 22:14, James Hilliard wrote:
> ETH_SANDBOX_RAW is restricted to NET_LEGACY despite operating through
> the common Ethernet driver API.
> 
> Make the localhost shim stack-neutral: define the ARP layout locally,
> populate lwIP's per-device ipaddr environment variable, and retain the
> legacy address state when that stack is selected.
> 
> Linux loopback can expose UDP checksum-offload seeds through raw sockets
> without the metadata needed to validate them. Normalize these to the valid
> IPv4 no-checksum form. Only update the dummy UDP bind for UDP output so
> lwIP-generated ICMP packets cannot disturb it.
> 
> This enables both real-interface and localhost raw Ethernet with lwIP.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  arch/sandbox/cpu/eth-raw-os.c | 83 +++++++++++++++++++++++++++++--------------
>  drivers/net/Kconfig           |  2 +-
>  drivers/net/sandbox-raw.c     | 49 +++++++++++++++++--------
>  include/net-legacy.h          |  6 ++++
>  include/net-lwip.h            |  5 +++
>  5 files changed, 103 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/sandbox/cpu/eth-raw-os.c b/arch/sandbox/cpu/eth-raw-os.c
> index 39ea3b3f012..c9c3a561a76 100644
> --- a/arch/sandbox/cpu/eth-raw-os.c
> +++ b/arch/sandbox/cpu/eth-raw-os.c
> @@ -208,7 +208,6 @@ int sandbox_eth_raw_os_send(void *packet, int length,
>  			    struct eth_sandbox_raw_priv *priv)
>  {
>  	int retval;
> -	struct udphdr *udph = packet + sizeof(struct iphdr);
>  
>  	if (priv->sd < 0 || !priv->device)
>  		return -EINVAL;
> @@ -226,38 +225,50 @@ int sandbox_eth_raw_os_send(void *packet, int length,
>  	 * stack from sending that ICMP message claiming that the port has no
>  	 * bound socket.
>  	 */
> -	if (priv->local && (priv->local_bind_sd == -1 ||
> -			    priv->local_bind_udp_port != udph->source)) {
> +	if (priv->local && length >= sizeof(struct iphdr)) {
>  		struct iphdr *iph = packet;
> -		struct sockaddr_in addr;
> +		unsigned int iphdr_len = iph->ihl * 4;
> +		struct udphdr *udph;
>  
> -		if (priv->local_bind_sd != -1)
> -			os_close(priv->local_bind_sd);
> +		if (iph->protocol != IPPROTO_UDP ||
> +		    iphdr_len < sizeof(*iph) ||
> +		    length < iphdr_len + sizeof(*udph))
> +			goto send;
>  
> -		/* A normal UDP socket is required to bind */
> -		priv->local_bind_sd = socket(AF_INET, SOCK_DGRAM, 0);
> -		if (priv->local_bind_sd < 0) {
> -			printf("Failed to open bind sd: %d %s\n", errno,
> -			       strerror(errno));
> -			return -errno;
> +		udph = packet + iphdr_len;

This would not work if the packet is fragmented, which can happen since
U-Boot’s lwIP configuration has IP_FRAG enabled in lib/lwip/u-boot/lwipopts.h.

So I believe the above test should be:

if (iph->protocol != IPPROTO_UDP ||
    (ntohs(iph->frag_off) & IP_OFFMASK) ||
    iphdr_len < sizeof(*iph) ||
    length < iphdr_len + sizeof(*udph))
	goto send;

> +		if (priv->local_bind_sd == -1 ||
> +		    priv->local_bind_udp_port != udph->source) {
> +			struct sockaddr_in addr = {};
> +
> +			if (priv->local_bind_sd != -1)
> +				os_close(priv->local_bind_sd);
> +
> +			/* A normal UDP socket is required to bind */
> +			priv->local_bind_sd = socket(AF_INET, SOCK_DGRAM, 0);
> +			if (priv->local_bind_sd < 0) {
> +				printf("Failed to open bind sd: %d %s\n", errno,
> +				       strerror(errno));
> +				return -errno;
> +			}
> +			priv->local_bind_udp_port = udph->source;
> +
> +			/**
> +			 * Bind the UDP port that we intend to use as our source port
> +			 * so that the kernel will not send an ICMP port unreachable
> +			 * message to the server
> +			 */
> +			addr.sin_family = AF_INET;
> +			addr.sin_port = udph->source;
> +			addr.sin_addr.s_addr = iph->saddr;
> +			retval = bind(priv->local_bind_sd,
> +				      (struct sockaddr *)&addr, sizeof(addr));
> +			if (retval < 0)
> +				printf("Failed to bind: %d %s\n", errno,
> +				       strerror(errno));
>  		}
> -		priv->local_bind_udp_port = udph->source;
> -
> -		/**
> -		 * Bind the UDP port that we intend to use as our source port
> -		 * so that the kernel will not send an ICMP port unreachable
> -		 * message to the server
> -		 */
> -		addr.sin_family = AF_INET;
> -		addr.sin_port = udph->source;
> -		addr.sin_addr.s_addr = iph->saddr;
> -		retval = bind(priv->local_bind_sd, (struct sockaddr *)&addr,
> -			      sizeof(addr));
> -		if (retval < 0)
> -			printf("Failed to bind: %d %s\n", errno,
> -			       strerror(errno));
>  	}
>  
> +send:
>  	retval = sendto(priv->sd, packet, length, 0,
>  			(struct sockaddr *)priv->device,
>  			sizeof(struct sockaddr_ll));
> @@ -283,6 +294,24 @@ int sandbox_eth_raw_os_recv(void *packet, int *length,
>  			  (socklen_t *)&saddr_size);
>  	*length = 0;
>  	if (retval >= 0) {
> +		if (priv->local && retval >= sizeof(struct iphdr)) {
> +			struct iphdr *iph = packet;
> +			unsigned int iphdr_len = iph->ihl * 4;
> +
> +			if (iph->protocol == IPPROTO_UDP &&
> +			    iphdr_len >= sizeof(*iph) &&
> +			    retval >= iphdr_len + sizeof(struct udphdr)) {
> +				struct udphdr *udph = packet + iphdr_len;
> +
> +				/*
> +				 * Loopback packets can retain a checksum-offload seed
> +				 * which a raw socket cannot validate without skb metadata.
> +				 * An IPv4 UDP checksum of zero explicitly disables the
> +				 * checksum, so present that portable form to U-Boot.
> +				 */
> +				udph->check = 0;
> +			}
> +		}
>  		*length = retval;
>  		return 0;
>  	}
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index faa08e9ebba..c057504cf66 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -366,7 +366,7 @@ config ETH_SANDBOX
>  
>  config ETH_SANDBOX_RAW
>  	depends on SANDBOX
> -	depends on NET_LEGACY
> +	depends on NET
>  	default y
>  	bool "Sandbox: Bridge to Linux Raw Sockets"
>  	help
> diff --git a/drivers/net/sandbox-raw.c b/drivers/net/sandbox-raw.c
> index c3d40f0b59e..c57893c48ce 100644
> --- a/drivers/net/sandbox-raw.c
> +++ b/drivers/net/sandbox-raw.c
> @@ -13,6 +13,21 @@
>  #include <malloc.h>
>  #include <net.h>
>  
> +#define ARP_PROTOCOL_ADDR_LEN	4
> +#define ARP_OP_REPLY		2
> +
> +struct sb_arp_hdr {
> +	u16 hrd;
> +	u16 pro;
> +	u8 hln;
> +	u8 pln;
> +	u16 op;
> +	u8 sha[ARP_HLEN];
> +	struct in_addr spa;
> +	u8 tha[ARP_HLEN];
> +	struct in_addr tpa;
> +} __packed;
> +
>  static int reply_arp;
>  static struct in_addr arp_ip;
>  
> @@ -20,6 +35,8 @@ static int sb_eth_raw_start(struct udevice *dev)
>  {
>  	struct eth_sandbox_raw_priv *priv = dev_get_priv(dev);
>  	struct eth_pdata *pdata = dev_get_plat(dev);
> +	char ipaddr[sizeof("ipaddr99")];
> +	int idx = dev_seq(dev);
>  	int ret;
>  
>  	debug("eth_sandbox_raw: Start\n");
> @@ -27,9 +44,13 @@ static int sb_eth_raw_start(struct udevice *dev)
>  	ret = sandbox_eth_raw_os_start(priv, pdata->enetaddr);
>  	if (priv->local) {
>  		env_set("ipaddr", "127.0.0.1");
> +		if (IS_ENABLED(CONFIG_NET_LWIP) && idx > 0 && idx <= 99) {
> +			snprintf(ipaddr, sizeof(ipaddr), "ipaddr%d", idx);
> +			env_set(ipaddr, "127.0.0.1");
> +		}

Not sure it matters, but when idx > 0 we should not overwrite "ipaddr" I
think.

[...]

Thanks,
-- 
Jerome
