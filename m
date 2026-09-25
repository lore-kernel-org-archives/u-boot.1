Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1804CC98325
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 16:17:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BDF6C60D8F;
	Fri, 25 Sep 2026 16:17:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0D_gOkAygQS8; Fri, 25 Sep 2026 16:17:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 04E3760626
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790353065;
	b=qhcnC8AySrqgUtMhGHZzNLPQFTaWbIZlMAEiT4sZYTw/4hm7ROcthIuJjHmiXz42kBDj
	 yAbZfslb8rcybRsiC3X6/WKuWlHN0oaHXWXAIVMrQgDwypE13EybgyCFXJ8vHtC2oWO/I
	 n73tRHneeGtJ11Gp+N9mKPtmKkcArYKT8cBJePGyiqSuo19yX9Yd6o0jLQT10i0k7k/gN
	 Cg0iAlx0bhMkpWV1kHnFAMNZOUIS5/A0e9XFc+ta2RoUtqCf5w3iD+cm6nb5waNdpBXga
	 Bkho+ZArasV+agh3ubc4F8K5nUiCE0h+LNY9soyH7lbYfsDu/wABmWUVoDK05b6Vzxg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790353065;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
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
	bh=bkhlfWUl5DOxFQ7J5IgAwFwGMyEqZyZSq5kjb/iWIss=;
	b=IBpAPulqmjtEndT73oCjN7tPUSMEHBgITegkBXLmx/88DzcMIl2zL6Qzv2ZNmbBmjwpf
	 irdZ0VfTAm7XLQCI40fSX+GUvx1CjvhGPabIXTrsW7zIDo9lWCuv2fYPdg7ABcjd/Pc6Y
	 eTn+uN40rvmwLIwQ5P6bnQqCZAWMPIMRrPLJq5mnGKzxNMKmy/UJaFnelY/EjRT38L1ut
	 t6XzNHSeiPZXgrYLZnb3n92iJkMTJHzfB+rhgcU09ZDcsW/TvJAYcI/EUDC8sqND1lBjl
	 7HjvrFk28D63AGCJesds3100BWzmPyOIlZ7neSPVRJlHzrQBpPKjlEmtIwgDadVOt7w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790353065;
	bh=bkhlfWUl5DOxFQ7J5IgAwFwGMyEqZyZSq5kjb/iWIss=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LfTI+YJl6M7zmBnXDek8kqo2Uz6f1+FXQkMQ091luLBCkXeshUBtvAp4GnGlchquQ
	 xa/YWUJhUvcohJmR9W0YI9mx7LvAPzsMKZ8JNWFUKSfWiIzCSKuZTB4iEOPJaqrH/5
	 E36HM5RoUf1VH6l76VBYrl9Rat8e7xsH/kztDaehhXySiAmaqkpagMPrrMJXUJmahU
	 5bbunRIZUGU8zKlLE/XyOcuRdtBwG/Y/9dAKoT8Ex5r5zR/eCW7jFjjSXojGg0cgUz
	 V54KTIBBsCtSRWUZunOIN6B2Dg3bM0Mc9Bz+uL4iW4pVEmIbQJjpvFgIVhk9+Hgdej
	 ToQCLNiRHawkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 04E3760626;
	Fri, 25 Sep 2026 16:17:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 26AAB2F5
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 16:17:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1835F809F6
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 16:17:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cqcl4zaTgaTq for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 16:17:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E5F3F809AD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790353062;
 b=i4o5s6eJVceuoHcdMK/7a0W2jQAuVKTt3IZ9V2oFZnbia5VpBf5ViLz2z3fmL071di3p
 UUrDMIm/UJKjqd5dgyXKkMtn7DRnEEHs9z7o2PJxsrrl7gMYug4l9sLrmwa2uiI0cLAUh
 EzldL7XffBBd+IFYA0O8UsinTsL74/MH75X5aDdY/oKk8SZuWfShMHoSqMmY6qJKPlal1
 CB9a6PxaHp5wSktmCTImyeFiCPxDjrpv6xaDlwrrdw7M8bkHGxk5pCpOd5++VPUPJESkv
 3na5C3TzAkefOE2T/znM9cN/SQAWpZWHknskOj04UlgV/LFQgzvmHzUCIxddDEpdOHg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790353062;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
 References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
 X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
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
 bh=bkhlfWUl5DOxFQ7J5IgAwFwGMyEqZyZSq5kjb/iWIss=;
 b=H9ljBX1I0i+HGocIEDzx36OtBr/hw1v3/zHl4ZUoyF5ye8Rm7SgogqKrweyLMCo4b7uB
 oPfY8TDi/mrYDJpEI6cy6h49TCeSz3sLy63/3SV5/3F3ANXiK+lNwbtV5PpI126LNcw2d
 NBbySy9OuWgAahBlutKlJiHfLnsCV0NCPTWjyON0RmmgJtf4mEUfP7Y0I+R3RAsg/0N4f
 5iEfPnJXDCAlOZohVBvDBC9PEqBDrpIpL0DQn+9u5yBeYWtk9tZ1BXP0sMonPxfYAZdy9
 tHPe4xJplaukUUvbhjvt2iIDYsOI2JufimUl+BgtuZBRaHb49CNsCkdedRVyVJ6m/Vw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=foss.st.com; 
 dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=FPhbO2Gm; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=FPhbO2Gm
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E5F3F809AD
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 16:17:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfQI4e4WiM0FpDjxRqrNC4lLTm7JSKHgYzCfjMDU634u2diUGbhh1wGtYm+WEGAyTZEaDhSJElf7xnxVzNXEsnroSpuc/WofiQUmJJD7fPSI21nzOJl/GzBHTOAMXyCNMN2wbFRZgQIPNd2NEWuw8qDh//HKDZN6tzvtxjFXHU7wv2AFAYThAGy/Jz7As465OzvEVxG/828feFN0aZyy+9D8r1LVPofZ/6hhcTpAH9T17d2/G2PJ8744/EBOJGCTGL5mxCDvywQeXCc4Hvyu4/V17DoD4fM3Jxm308hjDEeFAGK/WnoT+fgFPgfaPz5r3nDtKW6qIHAlwnnGZe180w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkhlfWUl5DOxFQ7J5IgAwFwGMyEqZyZSq5kjb/iWIss=;
 b=bxWCpPNKzC6EWVw300X+SewUKMFL7oVVoi7OpgTDX65RKuBZG5JajtIKAqnUo2hHEeCeIP0+4OGX+9ER3y769cwb/NThLmXjonIUkcaYxTIETVZiSA0+xPR7y8R7k3OV9pMtq08+2pUimywO1gG7lIQPvCbetlONoXbnFLQiYMHgQJZ2AbbQSsoQTY/LxQIxTblUagBxsrnROXciIAbGXGuFbUPzw9vc53Rq11epx0OcfKi9uq90qIA1QgVIfOlxLCc9iywp382XpRAn0s0vKeMrbMGD3LtlHxL0/trvhbJDV+ypCEoaf317ApK0dOZPiQS6C2YB4Zq0ljMP6OjZuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkhlfWUl5DOxFQ7J5IgAwFwGMyEqZyZSq5kjb/iWIss=;
 b=FPhbO2GmGKgzv+ws+8rOtXUep0BfHdc9zV9RkHPX2P/xtvGEesLrvsSummJIHF18znezx7u5lQnPCg/7Scb7MtawOs84yHvSUppOruRnJNuz/ZTyLQy/6Vp/elZANDErjnrpNLNedS/beot4UCZF7JRvhVo6mW6bVQZGewlZPbOfJzubsMRGeSkDWhz/aw2yRik9TfoLUhIsP8js0J9XP8KGPdh/z3eJSqF4E4p3nwIcuv85gsTUO1yLAXmp3MOLg2xby+DXXP0ndmf4dtiYuJVnP2J5734WIFJ8BQe1MB2n/8bP3B+Aq6BRA055Wib8qzl/+7mc+H2LUxEeOJnlQg==
Received: from PAZP264CA0128.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f8::9)
 by DU0PR10MB6605.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:406::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 16:17:34 +0000
Received: from MI3PEPF00008550.eurprd05.prod.outlook.com
 (2603:10a6:102:1f8:cafe::16) by PAZP264CA0128.outlook.office365.com
 (2603:10a6:102:1f8::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 16:17:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MI3PEPF00008550.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 16:17:33 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 25 Sep
 2026 18:24:02 +0200
Received: from [10.252.19.218] (10.252.19.218) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 25 Sep
 2026 18:17:32 +0200
Message-ID: <c5c115c6-dc8e-484c-a802-673b46be8174@foss.st.com>
Date: Fri, 25 Sep 2026 18:17:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: f_mass_storage: Optimize CTRL-C
 responsiveness
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.u-boot-project.org>
CC: Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, "Tom
 Rini" <trini@konsulko.com>
References: <20260917-ums_increase_ctrl-c_responsiveness-v1-1-95305f044ec2@foss.st.com>
 <d5d00e93-e803-44e8-9f20-915e324395c1@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <d5d00e93-e803-44e8-9f20-915e324395c1@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.19.218]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008550:EE_|DU0PR10MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b258d92-ebf7-435d-2610-08df1b2081b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: tTXQSuLTiqQ+WTFmqw1WWJhJCUaRpJSmeuUiHnxwvbNlUlsHVNutN38onJ4XWmh6KitO8gNFkNQtbeph8tEVCdzpZJ7VgVsYQ1rrPI7Cv2JyWd3xsupxF8LSKyPuSj9Rxx+Y20lcv2w1TXuzOFPAvwZdC6cA/7x2SsBQRnPfyhL024kw724hYRullHzHsnZzd2/EGfHwOeibhaV1vpMNNT2//cuejpYmzQ+YGRBlhcKi4e/ejKDaQdDh3SHO02PwINOFZ7d5TCM9zi5m9nAd5c1FUhHb5X4c08mk5uG+mey16fcwDq6OFCEPyHIE8KFw6wIRVdRdUUlrqAEVTea23fxJJuxuf4gVSXMZDiqZ2UG6irzTQt//OcktfcWWAt5yt5ljQH+aYCdG+4hn5UVvjShBSdLhnj+WGVzCQ0wwQwCy0lSS8NfxSZtINcculPQq790sNHjF6ZtSsLOdTJ2gNBy8qSpJ+rIDp6371E6EswMBMigCiTqDZKaYh81YJ8F13Y/a6CBhTMkg18mnBQrq+S8SO9u7ZsJnKhYtlpmLwkWMREjptjKOc6bEM/dMO5NzSzU8BtBO5S32b1SVRBy5pIahZ5DZFlUQGSB+CrX9QWbQXKJOtx3sGgH3FyE9a6rzLxwIZ7Iwfigt5P321JIpw1bssyKVqEQRvg9fdeXBHTlxDOwysmRoH4zT4URO0Xlro35/PezKlJAT9CQ6MAnltw==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: L0KEK+89D+hqid9ipspK7KWrH8GihA9m7SULfdtR4a6/SlXp+L38tplxfJWRTxnWrLeJYhe5WvDTmx6Cjx73YlsczH4eZlMXGYkIX8BdTBLM/Kf3UcrX6ohJBaUH+h3rtpKoouYAv42nbtJVSRHuSGJd6u3OQvpeNErkWt6DVZttISf5WahnrMpxswgPp46hLjSU1CH1zDM/5oAITs2tdwuu+CYDVKHT0S8T6gpcgj23NXgKP5NHX0gVzvPsOgUHmVA3s+Ww/TWWUjFsquHtYZpKOxQTiqlT1L8yD78u83UCcA0do+5vltOL66XvM8ugO7oaOCNcttAGD/5f3uhD/znburLB+oDlNKXW2GToqCOkTd9bTJBePjkHXrtaXhuWteHrL99pmlOlId+J0GkHIMGDENsfuqXLcDJRHFXE89ECpuAlWIu5FXQRkyyOIERv
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 16:17:33.7787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b258d92-ebf7-435d-2610-08df1b2081b0
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008550.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6605
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



On 9/17/26 16:26, Marek Vasut wrote:
> On 9/17/26 10:58 AM, Patrice Chotard wrote:
>> On STM32MP157C-DK2, when aborting the command "ums" using CTRL-C
>> it may take a while to get the control back on the console,
>> sometimes around 1 second.
>>
>> By removing the if (k == 10) test, it increases the CTRL+C responsiveness.
>>
>> Tested on STM32MP157C-DK board.
> I still have two questions:
> 
> First, do you have actual timing figures here -- how long did it take from one ctrl_c() invocation to the next ctrl_c() invocation. Use e.g. get_timer_us() to time this.
> 
> Second, does this increase in break condition checking impact throughput of the UMS ?

Hi Marek

Time between 2 ctrl_c() invocation is around 100us, way to fast in my opinion.

UMS throughput is slightly impacted :
before : 7.35 MB/s
after : 7.17 MB/s

A better balance can be obtained with the following update :

static int sleep_thread(struct fsg_common *common)
 {
 	int	rc = 0;
-	int i = 0, k = 0;
+	int i = 0;
 
 	/* Wait until a signal arrives or we are woken up */
 	for (;;) {
 		if (common->thread_wakeup_needed)
 			break;
 
 		if (++i == 20000) {
 			busy_indicator();
 			i = 0;
-			k++;
-		}
 
-		if (k == 10) {
 			/* Handle START-STOP UNIT */
 			if (common->eject)
 				return -EPIPE;
 
 			/* Handle CTRL+C */
 			if (ctrlc())
 				return -EPIPE;
 
 			/* Check cable connection */
 			if (!g_dnl_board_usb_cable_connected())
 				return -EIO;
-
-			k = 0;
 		}
 		schedule();
 		dm_usb_gadget_handle_interrupts(udcdev);
 	}

Time between 2 ctrl_c() invocation is around 28ms.
UMS throughput is not impacted (still around 7.35 MB/s)

I will send a v2.

Patrice
