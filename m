Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CE7C88E4D
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 13:19:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8ACE0808FC;
	Fri, 11 Sep 2026 13:19:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c2m7XxD1F1rK; Fri, 11 Sep 2026 13:19:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B479580F1D
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789132748;
	b=KW9fdWarQsD+rtLXFHk3VzZn2leWx+b2VBUWC8f3y+iRxu9d2wsn85O5Wd8K56iLLoRf
	 8q0JZjosoxJk64rgOZnhOznqLIcNSQRpb1fxAhCSSeDefmFR1kpmGSBi3hFOJTA7FoHTn
	 EhnLyJRecjCMUT2W8MI2rwDIgIQuosWkGk3QblnpP+phHsJJE8IfAQOimSftOWheCif5e
	 mybC7e+/pwlBVCQ/WOurXdAym/926XGJyQEUkfQfrWlJBSfgWw4jLYcyOorFLnC8S96HK
	 +JaTgpHScP5IlrSfhIEcU6D6daJ+FUyt8/+Nm7uAUx0BFz9OQ3X4KsVORJAiy4atu7w==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789132748;
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
	bh=GL2VN2MIqy8mfKem2KUVGDobTgFgAZ1/oPzTrsmQ2GQ=;
	b=Vulzf0OVIcfwGMUtIo2t31GbSDSkKwbe0RlC7qoBCYXE0T9OG4pTdVO+cZTn0+GFcgcl
	 Q8lwNc5JhfFEyjDhKm8wog1TYLaYkb+lH83spNiW5g5jonigR8wQf1SWipBpRS0AQjnhq
	 Ck5GIzn7QNC+fXLcCTyuCpHLW/v31EPeR3CvObSTFiCZomtCkXAWKy8gVn4rMMotrOIKO
	 NWGRmS8mOeA0/nd+sqMo7TZ6B1EWvG5P/wBXXpT7sUE+VZ4c84xTaALry7vlyZe1e6BGx
	 q8vyOHJmE9p9A9t2r1UHtd1a2fiIRKpYfx2WGHzGrZRT1XmfTqGqP2jnnnW52SDzjtQ==
ARC-Authentication-Results: i=4; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789132748;
	bh=GL2VN2MIqy8mfKem2KUVGDobTgFgAZ1/oPzTrsmQ2GQ=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mEIkJSHlEy/aN0qsfHEVClNh/Lstjumb6JEfEDERGUU7tyXbt94wOdbBEHFxeWDIQ
	 5dL2e8zbFlqyRjWEubetU4CMtmUSx+GRNT8wQEZCMcruJbnPPfkIJnY7QbGy912XpU
	 naCszFB8zQejwHwSlCNJOqZN08ZeUP2FsqUOnrxkrybo/WItxS6FZpwDkkro2NncAo
	 lgI9N6mbIMJTJdrsXydDZ9ldNZmP6xanxoCq6tsXeQk4s8KeniMGormXjeFie1YHUS
	 cy1QQ9k4pDFU7F0THO9XC04+2RAob57nu1KPduRXBsNBl9BRCJmyUxCvkNwhKddjqN
	 U8/sbIn+tGrhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B479580F1D;
	Fri, 11 Sep 2026 13:19:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F3D22E3
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:19:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 411B140818
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:19:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cOeVtYNIImMM for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 13:19:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 362E84080A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c200::1"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789132746;
 b=PxESbsGFK7DzlotK97o9NeSAmjlxAapyk+z5Nns+yUHyFVX2UIJYhfM4oJPwDHasVLgd
 +K4cpV8fz5dtMtdhXOynifKSjdC2QTGP4zrRBcgDTaLrMiVZv3ebOLUq97M2Cd+8Bztkd
 yUN+ZttyYi1yC7A9kOcTT0/Kg/b3c2uFvaFn3npMN5eeqCi3AUU9aj2lG6l4k+k7ii+U9
 G81qPwzw/AJ2Fa5LJBKGesSo/T7W79JbrSa0mJD60dLdLlII68gF8n0+TBeTRAYnxTNfN
 lptLyphT1QFhb+fae8fm+1C4S3s/7kxGCsFvRJ3vC/4NP6P+X7EM5gxDUHsWVpLBwwA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789132746;
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
 bh=GL2VN2MIqy8mfKem2KUVGDobTgFgAZ1/oPzTrsmQ2GQ=;
 b=R4oadJgMexIfY+VgPRgw3Hj2n6D8jBP2tC0NW1KF24mL8C7Ktsb8S+o2QLGyOIrc5PQc
 /3uWmV0SWe3uW7+N1hEqfkG4z1kG/41NFQObIma1QZAQuuPE2JD0wTzIw3Wtw8OBTKiuI
 2o/iO+3Uh68zhbsevrjwWPT0pW3TkAfaCvdfHCGzag0Rq9otHSH/wuUEVXRggNcrU+aHq
 aOL3hBvDz+cxiEG5uB3OD/FU5AuZHvEeqUp505OhyGyvxaTE4A+lboL4LaJSGSgbJPqjD
 +7LVQ6AymLDDkNXowKol74mjZ0eBzRiO4SiZaLRqqfXxi+nM20aAi9ZTYra11dja44w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=D5GFsZOS; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=D5GFsZOS; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=D5GFsZOS; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=D5GFsZOS
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 362E84080A
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:19:04 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=XuZaBDOgNpQL2oBXgihC9C7urulISisScB6reR2EB2BgCZ2icCRpEcuBGb6mglMSkF72+Ner1Mu6rHYaqlUt5siiVoetPG1IoerzDdqG4gKGAspRKR9fz7UfjW1jM0PMVtsZAWvlhWbWwvb7WMFUzZMJ5Z4puYosPBjlYlq8axuPV8N4j7ElO9ddzAZzplojV+AytOxeXz5H67CcKJrkYFinEpilhJFRpnuG3V703b6c9+O/cwamCLS7PIkSPdJORzxiTxqlpbdKP7IQ2FoEHZShfCIQmfut+RVcMnbHo+12NFqhWcGSi4OC7AfuFhF+72aBhGUEbQxIC/x1cS4B/g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GL2VN2MIqy8mfKem2KUVGDobTgFgAZ1/oPzTrsmQ2GQ=;
 b=OerrwqssNFoexVPtIFVfy0uN9w12cKnjyXEbg/4h4hxqjOwBH+sjUoAznD4TfCjUXGWP8Pos7tkGGj2SpB6D/5SIGfB0xgN30GItvQ0EUY5wt6VQZt47OL815yvfk79WlUE21m2etUNCA9XZAlET84lgcFMPHZrad+1PmAkYPes+HoatsROtWD5WmfJnKiKTFX+qnBtPDt1EpUEI2VpWZ7y52ENpoiIrE9/RHpOt+LZtcFK2lZHNQiC1xcM04yxCxAggcf4O0VpD7rTuH22ra3F2bBFIXV4Z/9zDd03VJyjb6E2vsgiPbIV3wg8ZO2fV8JIqZwGVu9OiYCeoLP0LMA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=arm.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=arm.com; dkim=pass (signature was verified) header.d=arm.com;
 arc=pass (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com]
 dkim=[1,1,header.d=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GL2VN2MIqy8mfKem2KUVGDobTgFgAZ1/oPzTrsmQ2GQ=;
 b=D5GFsZOScpM7LWj1/KJa6gU8MUZMfhv/R6CyaeqxgXFHgG2oyZs2hmJ4TZrEDakSzRaZNtfOffM+tjOjB4LDrWTFb4rnO5/2y5uEQXjiIGv5OiKH/rTeu54aUj6+5mVg2V1R+FLzR3wkK/wkqb+4Vu9ytnFUo+le6Qx/eRnXW1Y=
Received: from VI1PR07CA0288.eurprd07.prod.outlook.com (2603:10a6:800:130::16)
 by BR0PR08MB276679.eurprd08.prod.outlook.com (2603:10a6:2c8:32::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Fri, 11 Sep
 2026 13:18:58 +0000
Received: from ZR1PEPF0000E6AD.eurprd05.prod.outlook.com
 (2603:10a6:800:130:cafe::5e) by VI1PR07CA0288.outlook.office365.com
 (2603:10a6:800:130::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.6 via Frontend Transport; Fri, 11
 Sep 2026 13:18:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 ZR1PEPF0000E6AD.mail.protection.outlook.com (10.167.241.84) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 13:18:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFjgT12IjGbLdRugm0r31mzInSqfPT7/MGN1ICnWbJrJ+EZ31LX9IYJ1HQviH7Qsmz0xxX6MjmxOBrCL1ezXgmY0wnq7utWqPzGeiCdIyLSImjcYY9IKxc2Zi6ueVh6C7R+Lhsv3WwJr/v1qdonzwIcpANTGELA7Fqizqla+I7VynaI4C6bRdNxUXMlqwegbKgpeF0GKZqO+uHOu1R9/C2SqUG5jmTAY/VCwitkZzpkQfQ91VGrhni+Y6yjuEdZnT1Mb60XkkNoOMRTEECkjHxuD6ByR349n/aE1OoAtv5z1PLGai4v2s4tNMT5Oe2wgoCaM46Ya2tBtZ5sVNIdZLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GL2VN2MIqy8mfKem2KUVGDobTgFgAZ1/oPzTrsmQ2GQ=;
 b=u24N+pmEAgAzY88xaZLeFeSN+0EeBusFQg+Cwv+D80Ub3wLWNeGHgYN47QQZTwcMFb5f+WUzdgg2EDSx8PkJdhqb0dosVBBcpKACyKbm6752cFa++jU1ZPvhIj12mj0wF+K/CSFxSLUAdeJhCw0wsHSR5/YZ22vz1oQ/R5aA9uKYk4ZpTuOG2dxBIyADvWvzVfJZHdpFdmSVshPHBPNc4k9ZqR1OOXFPky5GobYaZ2hMte8qMYmxDQkRYEaCRY6Cxj1JW70PWx5XUFIxLQEznhElKCuP2ClDt0atygVfQ5GmnU3X+4iek0RFGmmBhzI/9aUCMKNDxnKxb9NiQ3/PaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GL2VN2MIqy8mfKem2KUVGDobTgFgAZ1/oPzTrsmQ2GQ=;
 b=D5GFsZOScpM7LWj1/KJa6gU8MUZMfhv/R6CyaeqxgXFHgG2oyZs2hmJ4TZrEDakSzRaZNtfOffM+tjOjB4LDrWTFb4rnO5/2y5uEQXjiIGv5OiKH/rTeu54aUj6+5mVg2V1R+FLzR3wkK/wkqb+4Vu9ytnFUo+le6Qx/eRnXW1Y=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PA6PR08MB11584.eurprd08.prod.outlook.com
 (2603:10a6:102:524::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 11 Sep
 2026 13:18:24 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0406.005; Fri, 11 Sep 2026
 13:18:24 +0000
Message-ID: <28326a1c-2964-48e3-8b93-d327c85bc612@arm.com>
Date: Fri, 11 Sep 2026 15:18:23 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH v2 00/10] net: share the lwIP runtime and support
 netconsole
To: u-boot@lists.u-boot-project.org, Sughosh Ganu <sughosh.ganu@arm.com>,
 James Hilliard <james.hilliard1@gmail.com>
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
In-Reply-To: <20260901-submit-lwip-runtime-netconsole-v1-v2-0-3e3d95627cf9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0047.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::16) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PA6PR08MB11584:EE_|ZR1PEPF0000E6AD:EE_|BR0PR08MB276679:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f6d95fc-c662-42ed-9787-08df10073c82
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|23010399003|22082099003|18002099003|3023799007|56012099006|11063799006|10067099003|41080700001;
X-Microsoft-Antispam-Message-Info-Original: 9Bn+lPznQ8Fob/xdPI1PgUT26hf0jESc7eEwtOQQto086lGav2atLdfTD6e+0AE9BHEVPsR7czkzz3+gIE8y7CCCIhyFsgVeeHfAIr1TBI466o4kpdvAlEW+kyzqwW6XGWC3C2mWbtAulOFKzROwonYkaZ/LJK3G2u1wT3n2iyv/9rlrPcpO5Rwc8H0df1dPIHIm92Ysv8je5htOykRSBXuLntXaf/w6OTDEVcdZG9TxuVvYJOx34XO2VDqV+i0RtcY+yXi3xaIyoS348GB4ELB1EGRcO0tzYtqwQxYHrjuFIlGHDGauXAzYDjQ3AdhCCWm9iCU9zBZvph9N5oTIpg5WRNsZxdhPiNX4pflbhs2gEZ0Qw0gRyCLt6Qd5+AwUSyziR530WOdpqh68AmKM6nf+eVO7+ACZpzGttx38FVSAPggay25kBgsnk2Os8/ZaIYGeL7O2MptEPUuv9jbWdS6/4NaYoWaX8l1JJduY19mBc8Z38Eyd8xV0tjOeXdUjAYuWW7NTQMKhe41em3sov7vyil3qQ36O1AYuaAjJbhdZ3YZNIvs+Yu3MKXN9wbZLoydI+5Y2vhSsCaerBi+AHbsWiwO9qUPn1DxQJ9pxFSYlqaFjBV5YNbzG3iHL7HHZYO2hSz+9/gp1/9rOSaHPbAC5NmrEEM11dSTcTP2e0NZuJttDJWz9MWC9ZfuoTBp0NFTWG2EpHFvLX7RGvm86lSFT+ZmXLy10PWok/kwfNDc=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(10067099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: XsmjLG80B36u42OtGZaVBGMerobHfDPzhYlCFV672Q/byOkEX/w81wDi6VSBbme0uzZ+WNIU4OvkGbRfGUmN5alJnk15AEy5vFSvHlrphW3qH4VeAYwt9oSTJZ0wESb7NRpIougcywjpwaOtwqL8NPK+kJ0uvNVcrMtetIhCsd3Vpfcr8HgHQznjs9sXf0wZ/W6RvYzbduvA9boFB7/UntTLWxXbgqeLjUj5hhnida5lzF7gcfHX52iYPHkO5vsY20kuxwiy7+ti5t5wJjicLB9plk/kuQd0rbH1bHAhLoPE+fxkN/fNCcQcWSaD4nf2QBKv77POEm3XlW+koeiSDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB11584
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: ZR1PEPF0000E6AD.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a435ccda-f18e-4dfb-b5b3-08df10072895
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|14060799003|1800799024|82310400026|376014|35042699022|36860700016|7416014|10067099003|3023799007|18002099003|22082099003|11063799006|56012099006|41080700001;
X-Microsoft-Antispam-Message-Info: qJZGfBEp6JdDUnLFPe/fFAi5r3zLJhX6/92eVPE/fbLnWzOlvpAutszo6d974SF/aoZjHBB0UlLz9zMdcSd5+mQHhmPIPcbVkcYgRhGiWWW8m7RP/688DwDDDRdbbV7EW+3YxEqbjjgEB4Z7R6XT1H5bOND0a/mBZsqE7zr7cjjvje3GiZkktw/k8mppztrEqyniPVM2+dJ7hT1DXEmwt6qPN3F1amSXR8dHxhO85XyTaEAJgDQqx23sBnHfalTl9eV5Lq9+8OxHJuUzPmE667AlEUISiKPAb4HT5Ed95uLjmQ1fmX1iTY4+evmraUl5Sr6vYi0fWu633ZuSzjl8Gjdw18lc7aBsydxQwJtEH3q4XOlLYbLcmRPfGy5ldouU4Hq2Is9YMEvx7WrHzSTthx4qSeC5+ccgWr3jK2QRdIC2wgSlej2ff1E4PJe1s1d6oAkGhdkTZI51kP1+PG5bnaxG2hTAB7lyTiBqieUPmAVJiGvgpdTTAedslOmVcAsUIKx4Z27eE1IYWiHoG3/BL9fBIuJEeZSBy2OpDiOA7lnzJx5x9n9h5tGibStcQabHD2Hek81vyclS5jlFZ4dXFQbWV5B7slHRgQ0AY2VhG7FQ2cYkptpLP4jqGiD0AKlxBZYKpHJENfbiNnnBkdMjukM5zLhreojIuoIqpa2kCDz26mXeeWRV78rdHmUrSHhTRkSdhwfE2vsgMJ1g0jt3n/wy4D6JTFQz/N7gYxCu7aTldv9N9HDiTACNdAY8VgMw
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(14060799003)(1800799024)(82310400026)(376014)(35042699022)(36860700016)(7416014)(10067099003)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CRwJnJ2oYP7nShi2QXZRYyme/BJkEPaFRXgLX3QGf97I56qJt+hrWghjHHEwOLkkz3I5wmXlVxd1taQLEJELtBfzg8+9U3ZlcfmgpWEmc0s9CWvuJGE32K+qy4w5eoqnAyKLoGqBtIxS8RE6Rg4h35V5vDxrqywOxFn0Pweq+appOymsXY+Z0C/XAHp0AJAcLpUzpaTMe438hbbrsXKDWbTK2356IxMba9wBxX8RlJNj/Qv1Jkup0jBqr8apqp43j1lB4Vyd6QdHCn+MwsY0L0pTztMxxN/HNts/QmumH0cc7y7AqIbtPckbuMtlwStKLTJ0ge40Apad23lJMEi5TVIyFK8gpdNaKvTY7XjHBOTYmC/9+SyNw11fW3TaCipEba9E55zqfB2iKfacGbu5qg7YOqZT/mlYbmfeXTtKjMfcvwsmClB8TbYf76PQI8vR
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 13:18:57.4433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6d95fc-c662-42ed-9787-08df10073c82
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000E6AD.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR08MB276679
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

On Tue, 01 Sep 2026 11:08:54 -0600, James Hilliard wrote:
> lwIP commands currently create and remove the stack's only network
> interface for each operation. That model cannot support a persistent
> client: starting another command replaces its interface, and either
> client can stop Ethernet while the other still owns callbacks and PCBs.
> 
> First correct wget's existing receive-error path to return ERR_ABRT after
> it aborts and frees the TCP PCB.
> 
> [...]

Applied to u-boot-net branch for-main, thanks!

[01/10] net: lwip: return ERR_ABRT after aborting wget receive
        commit: 2f70f7c47d030f6e8d8960b725796e45a3915861
[02/10] net: split netconsole transport from stdio frontend
        commit: 6c0aebd461ac94988de4add5f2bcd498c911224c
[03/10] net: netconsole: use unsigned port numbers
        commit: bcace2c606c6d8221f4b0f02d5ea2a14ec95a95f
[04/10] net: netconsole: cache environment settings
        commit: 747a0df405deb14cab6c02be7c4493cd61d623c0
[05/10] net: lwip: allow DNS callbacks to be canceled
        commit: e1d4eb289f82a6438ac26992c5c037bee66b0fc0
[06/10] net: lwip: add an HTTP client abort operation
        commit: cc4309d0e4fcbacd7ed924d1fcfe61469a34622e
[07/10] net: lwip: allow DHCP to stop without releasing its lease
        commit: 64edae73598573bf155a5d0272d0be6b105cee3f
[08/10] net: lwip: share one network runtime between clients
        commit: 13743b71c7ac38f5797da255290beec4e262b5c0
[09/10] test: dm: cover the shared lwIP runtime
        commit: d91b7ed95315863cb68db071044dd6b6ada881e3
[10/10] net: netconsole: add an lwIP transport
        commit: 8e9f06c299ab84beff7b8232893aecffbb7e0905

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>

