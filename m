Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49DEC79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 08:02:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7441540585;
	Mon,  7 Sep 2026 08:02:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7QQ2adpYE7lB; Mon,  7 Sep 2026 08:02:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3E33C4053A
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788768167;
	b=S9fSG5hjP9oCrqZRW+kZrk7e2cPYyQxctsE+QcshStAovykALJ61v5Gij49tUDj+4mdT
	 67Dvgcoui1W2SHqzk6q9GYQ5YZcqgAelcJ/5MdWwRnb1x6iM+155Q5JCZshfyoZZtBtax
	 cPLX4bAdUga8twNK/3moCxrcWQop09idqgW3tuXcWPN9QWYxJEXwxmNeZTzzaxKY1NKV7
	 YCIZe7Guclc7SnPQmTfCDmiwWCYzHoNiddU+1nWhd3HFnIPvvFEyYhoJuvX0pUG1PnooV
	 niXvXgiwntcZWzTYv5Re5Q9sVLgN1xfDo1JkP24UrDoNXQeJ5/U36yZW7QJ7VIcL6zA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788768167;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cF3HgHh6SmVwSEYlvYCu/grcqQwkR4CbRO90i3TnIrU=;
	b=jHfzMToHhq4ANAPENhUn8mNccq84uOqn4qT4sY7bs+r/LH4qOs/lY/xvAfzdBdeZO447
	 RZrSHpWCnMIBA8HnS26HYNTBkRhTIL/WWlNEs7ksEH0ogPhS3gji5ZDy3JGzs3agLpiLB
	 N1zzlW7H6tWsqWscfl2bF4s3rSJd/cyKkltid82ZsNcivIzeYAM/GoxtYoG1bzJGUR+4I
	 xAkZnmidi4p0HwOZFR4FNyVu/0Ktj/xpI2QOt/JRRhgPvrcetbUxaXPomb6LeNLBFpTpk
	 19iBkYevkLOoo7w8HD9gYpNCGUFBWISX+3SpctKj4U/YduXPoucEiR6wPDw7ekXY0HA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=d9cArXtz;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=selector1 header.b=CRWXXSEU;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788768167;
	bh=cF3HgHh6SmVwSEYlvYCu/grcqQwkR4CbRO90i3TnIrU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i9OiNW6xwhj2R7uOypyXS99LbmE3JEyj+DOD/qWcgM6LzVXz6MzYEU4qtjXTY+bnU
	 mWNuE7lSTQJliOyqObYi8e45zyXRIDbNi/KuLi5NOMmSVhB5R4xaxFwJOmVFlmN07M
	 O/Fe9StpQ6dgtNhhsUa0pfaRw1y8XvYdOStLpY3KQALaTlAKjGLNeWSf2k0kx7h22P
	 Z1Xi4JmSsaq5rnawgAdjU570RMGuZN+JznZ1efAHdfX5gZJ3KtJt5c0mcXn+p+o1ui
	 WjD14cxDM2zfKpJ5m/45TmV5xI+Q0AsrqSDpyJe/KH0p0rAtkalEWqznTZ1YHc6zKc
	 wZ+XibxPv/gHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3E33C4053A;
	Mon,  7 Sep 2026 08:02:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D669970
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:02:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A2C040534
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:02:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y8RMXZK4-v4Q for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 08:02:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org ED317404EF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788768165;
 b=ShB8XExmPUuOOEqckS7C0ZfcpPRmUTxN5XTRhj6qLEpFFXfN1rwN58JJ8l+3qupGLpm/
 aknV7U9mlhZy+uW1U4tKi8PDnHkVPHu1Np52YrRE+vDJDzzDor4rH+6GB6j5mrNMDRiuC
 yrZFE3d+aeL1IllzpWq0s3aAyLLp1B9m906KetGw/tBjgeHjWjLjXGeYxk+m0hV4GZBYs
 XfAYX6zLAx5hP9VJvpPMmoo2eDbvoFX1OaFKR3yU75sUhHxoqJKjDqz0woE8uRXd5kQTH
 3lY/rAd6tpGu0wduTVLrH5LMq74BMWH46P6gLVX51BSUbrQUuJK8pUbXmlInNfaeXlQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788768165;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=cF3HgHh6SmVwSEYlvYCu/grcqQwkR4CbRO90i3TnIrU=;
 b=J9srIAosBDUWOpHyy6DPqvGHQOk1zC2Ifv/0FAQmhRmHGQc/xaoPXPqAP+8xuQW0x/gA
 EUMcWV8OBkfQvR6jzLacBn5TQCKx3A2/EZVc/BAxQ7AnAQ1XEBkF3w0glQwHGJHLKPWV/
 cWbk6fyIJUeITBXxRg7Ie9R+y5YdTd/Z5nx5hAhJt6hCrEcXQ0KTZdr959vC3/pyawOnc
 zwsHRCluImPpx9fos5NeWO/HkdrkAzBcMN8ZLgx1Io1sDNQDJDTdpUloCKCcPha5TJgqy
 +pY3xblyv7COBH/TnQXcwvJHL950+/HaO2aEw3WXH4Pj+MLsJ1xJiIJlFmJoDWy44Qg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=d9cArXtz; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=CRWXXSEU; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=d9cArXtz; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=CRWXXSEU
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ED317404EF
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:02:44 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687766oG2795824; Mon, 7 Sep 2026 03:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=cF3HgHh6SmVwSEYlvYCu/grcqQwkR4CbRO90i3TnI
 rU=; b=d9cArXtzJ5ewBZl6clr7bYi1Sig9hBUlJKWsE5cjp/+cTfhTTyXAzqEB6
 y6W/oP+OfzYD/ZcRGtL5Eg6Z/SoF1rU7JtAR3p/a6CyTOHJKkz1+TFQipvK5yVvr
 RTofVjw8vAJnpgftSYriwKQz7gnzLPbRn5NZU4jeJENDLOcAshzxzRKogzG3X0mT
 LUmthyZswX8NGvN+Lxdsm//YJb9MjZE3PQ7ZLf4/rOOJRQRsTVIcVBmHv+u1Gg6K
 XJK4Rl0/U0eUFJ9jI1mFa0VkvXDYSK1dSAc2HGeXWWVPzE8hNBCpdlJpHmPVvHrG
 yl/4E4ECKn9lyvs47gd6d5xizpvJg==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010029.outbound.protection.outlook.com
 [40.93.198.29])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gh2f6cq8m-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 07 Sep 2026 03:02:40 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yy26qZroWx1RDlBFFDha34nLh/kr9GOY1qoiyPQ9YT3eYK3jQ/W30lAs+2p0yWnkaZ5lOSH7NwEjry2N7PvbGC4EEzIw6xaZdckCsjOYF8R3Tp2vOoJeKYL2rPEnVgUVwe1hjMW/iu9CrarXJL0QgdbPPf6DyEHo5N0Bk1XJc5FftqsnvhndtF0NqfkLjjsAZEcXMSvYxOcCz6fdXcHgMRpmAmzPGH1rRlUDOZC9lgLF1FMLgBLxEXFOhleYoRgCcE6KUZmrZY1Ir8sukQd2b3kT7oM+osGF3SBwdujJNEfK8n4C9jy5sXs+0VyDPwCueKCw1Ll0ZhZQvYX+kF8Vvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cF3HgHh6SmVwSEYlvYCu/grcqQwkR4CbRO90i3TnIrU=;
 b=O65uDD0ampDI6Soj8eZFpgQCzgYV3Cvdian8fDNWDeVJx2Dq7oPSk7mm+QEuhBXDB+Kwz0tqePkOtiM5fgHytdpaizP+HAQGdVT/iF/WgVhR8/mZ+54GPjawwpY6Q2hSeTlbop56w56aVqFnBw2ZLTfKIk8Ph9l9tSV0wOLraEcwaDZuDn4oVHc45TRZY5X0CwqgVxBK/+zwpksNvgkU/fsTbVJWILEG6a/AGHA9D3B9n77cr8l/7BPN/rBnojKIZWCEwZJofk5o/SjyUZ7hQJf6C8GqmoFu/DuR9fjJOgFgZgRv1RrMUNy9lzBXYiKGiZ4mh2j0fJNU/RJf4t4Ljg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cF3HgHh6SmVwSEYlvYCu/grcqQwkR4CbRO90i3TnIrU=;
 b=CRWXXSEU15kzOs5KOpBSwhzlKLB/I5w2M22yhMU1vq4DIrTpqKxg9gngWQCh7xastpMyAmKR+w7saQRobYx1p2xbQBOfDBRdAqI0xuCp243RgEtAlJQ7LOJzL3x9t1TWbA3MFADs9OKvxTJqJSdwd4WUSqtICpcG7S2eZoqDa7o=
Received: from BYAPR21CA0022.namprd21.prod.outlook.com (2603:10b6:a03:114::32)
 by IA6PR10MB997609.namprd10.prod.outlook.com (2603:10b6:208:5dd::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Mon, 7 Sep 2026
 08:02:37 +0000
Received: from BY1PEPF00026965.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::6c) by BYAPR21CA0022.outlook.office365.com
 (2603:10b6:a03:114::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.3 via Frontend Transport; Mon, 7
 Sep 2026 08:02:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BY1PEPF00026965.mail.protection.outlook.com (10.167.244.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 08:02:35 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 03:01:55 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 03:01:55 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 7 Sep 2026 03:01:55 -0500
Received: from [172.24.21.163] (lt5cg60819vj.dhcp.ti.com [172.24.21.163])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68781oK2119130;
 Mon, 7 Sep 2026 03:01:51 -0500
Message-ID: <697b0b50-c23d-4584-8372-36cebd6a05a5@ti.com>
Date: Mon, 7 Sep 2026 13:31:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/21] board: mach-k3: r5: common: enable GTC after
 core_resume
To: "Richard Genoud (TI)" <richard.genoud@bootlin.com>, Tom Rini
 <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>, "Andrew F .
 Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof
 <bb@ti.com>, Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>
CC: Markus Schneider-Pargmann <msp@baylibre.com>, Kendall Willis
 <k-willis@ti.com>, Abhash Kumar <a-kumar2@ti.com>, Thomas Richard
 <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 <u-boot@lists.u-boot-project.org>, <u-kumar1@ti.com>
References: <20260828135730.1565643-1-richard.genoud@bootlin.com>
 <20260828135730.1565643-9-richard.genoud@bootlin.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260828135730.1565643-9-richard.genoud@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026965:EE_|IA6PR10MB997609:EE_
X-MS-Office365-Filtering-Correlation-Id: 277322c7-ddc2-46f7-0540-08df0cb660b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|3023799007|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: eTa7kxI5m/ISVbElrOttLU4VE9hinSDPVr9dvJOr8WJ37HwkUqlpAsXDd05qqlsisVIurkjM266h5DP9sxSQ9uA/a7QT0GPtCjK1r99VvWdIVIqftUU5oL53U6rCqiuYzNLDRcciTgSkmoDV83kybsVLo5AJB3pLlt6wbWm6lbET9nzAuZ9Xy3RlCifNgM/lZKzu2TneyQOujQOLB4IQGFj80eIGrQP7MGUisYUVmdIt1WauUAxs6hx0ZPBtMeLUl+pfEuoqgA9P+ZxDJD21BvR2teRTe+dCgIfx163QFAcYRU9o0pIKGQQkbPKLwkYY5UwsjQyjhjPp7PsRbX1lANftmBpPIaFIevvSSfq7crQTiOrL7ht04no7FlmFCZ+HYF1LR/DrR0/+QICMSpkhEbCqV8nufNqsoEUNQGf9XcV9ecTMKJ6YmlOeKqamMF8cxQ/UTmiHI5ijjqOhkuadlnWoXBZuIu3qtl/nmT2oNIYrn4cWPQ+3tQxLvsflIMDtn2CgioJinx25c4Srf480/C6mjWhjIfwmHQ3H65LY7VgVhMkuF012q/1RkVl4cr7SJDs5Pn2njdaqrWKRXosZ8h6Fs8qf/cZ6lzrsYIt0VkiEsV7W3MF2Z51yelwekYymXq767gP9ysgZ/5WnaFJOgrq2jrh9uYG9ClONuQeIR8/3f8SuqBdu72Cu5A4ngcFWb8ixLWC601P+ez6W7kFmmg==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(3023799007)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z12ixnmK3qXm7dsAqrqErhVUHhx7z3KYK4sraSUFxY4334zSblcNDhOkV2Y+QKJJVgZaK/hgzfrqVKU67FANHU9MQNnPQbuhet6qWDs5PnqkoRAy4ZT+vhJFkR/RDSFYvcUeiEW+lPwhDl9u6OvLS4nRS48/6DFrJF097KBNvWw6zkJG/aGLw+R4ZZbHPg97iGQ+BIVcoKHwTO5lVnMLtyDyy6zu2RqxDjQpfyg3CahbOHJwt3lGbq6Vi0PoQuuafHp7oMj1rCbRBHvCRukX6KvwfG8Al1iRfwYTH6Nrx6bH7io1mJbYLfMEHjXMffhfK2M46NO4UAWuXVUNdnLEU8DR5BWpYxTM42H+FepJMFUKDqBlwlsqyfwoo2paQLMm2fU3QqT8rpzpV7JlzvftlxQqR1eG7vSdKmQ68gXVuTkS5FzEzNaK8puamhVgUNzt
X-Exchange-RoutingPolicyChecked: L9TYpQIVWXRRw0GbbXEE9x5cCbAIPwoaHSHITZfyrQdm7uaM1vTk2oQVbus6yIda5m1Iopz2PYYfqfTDlnWFX61aOFLRZpyqodx7y1t7/25SW0drwbGEuw4jDu8JXB2BdU8fnFe59Gk/uxwegRVx+uMI4I2J/cXAKMcKTHBaXcac7qocqad+DQ6MbCaFf16KSLTUhPGv7YKerdVDtTdm5sNv5u3CD2rEFUnk0cEAV5yVf+ai7VsnMaAU96jq0xhxshb1Tp5Nnfkc/Y/MKCl/WSMHia47Ooqmm3z0nAIhdMGmi1ADqgJ6vgDM/L9XHA+qoe4kff16u6LlR2iC1pf0WQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 08:02:35.4379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 277322c7-ddc2-46f7-0540-08df0cb660b0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF00026965.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR10MB997609
X-Proofpoint-GUID: eDOVdplywpPBaXrR9knBpNal5JEbLal1
X-Authority-Analysis: v=2.4 cv=Wqkb99fv c=1 sm=1 tr=0 ts=6a9e6fa0 cx=c_pps
 a=KMP5/9L46olBb+slh8+hsQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=P-IC7800AAAA:8
 a=mu82vndFfAE4zgBli0gA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: eDOVdplywpPBaXrR9knBpNal5JEbLal1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA4NiBTYWx0ZWRfXyHFhIkz34Qqo
 5l33eg3mk5BNhPIb8R6vVaO/Rr9E+5DY6x8N6YiI0ZXGJwKc9cvYfDBiPD9uRZhZwAcsxYfAiJD
 Hai7aF8K2EGlRT/dQHfmg8Uw2XBPZkcOagP7gOjSVXEF03osKoWoHOIU4j88IqDq5dpF60kTZK2
 Xsc1Tbg4bRnhIYU42ec5Rlz8cMxUnqNQYfSRn/FdYWjpbur+6haE4NnwFuRxXCzndJZSpk2rsVZ
 H9KP9lNqnGZa8XhPwi+hJjmOOVyrthbqxPaLJ6lOmxzp9ufVaOqS70Gy8MabGRHw63YJXP16V4F
 0wFLaZnTISQMYOvpXvBnTyTCFkzmrVAfyTl401lic22LJp0gRBiPMIXQpk+kBzqhnprqK8mFT1R
 7aPHerDEm1sxH4FWv7dsLYcHYEcL99O6q2KyFeko3V6hxKaYvkwuxuMJoI1ew8TG1xd2M4rcuN1
 /YGLOAJBsDL5Nqj1KZA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA4NiBTYWx0ZWRfX1K+Rt0MoRFTu
 CgB+qcFzg2Cqt6PxJHagtgwtW3Phabt4XF9PH3cwsB2Ipj3RQlqBYs9zicEX9uStpXURN5DSqqk
 3+qC5ta8RkBrRUSL1GSSoriXPruqKQ8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070086
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



On 8/28/2026 7:27 PM, Richard Genoud (TI) wrote:
> From: Abhash Kumar Jha <a-kumar2@ti.com>
> 
> The GTC counter values are restored in the resume sequence by TIFS as
> part of the core_resume API. Enable GTC counter after it is restored.
> 
> Also add a check to make sure that rproc_load only enables the GTC counter
> in the case of a cold boot.
> 
> Signed-off-by: Abhash Kumar Jha <a-kumar2@ti.com>
> Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
> Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
> ---
>  arch/arm/mach-k3/r5/lpm-common.c       | 11 +++++++++++
>  drivers/remoteproc/ti_k3_arm64_rproc.c | 10 ++++++++--
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-k3/r5/lpm-common.c b/arch/arm/mach-k3/r5/lpm-common.c
> index ab39ea0cd67d..4f515b51fd40 100644
> --- a/arch/arm/mach-k3/r5/lpm-common.c
> +++ b/arch/arm/mach-k3/r5/lpm-common.c
> @@ -311,6 +311,7 @@ static void resume_rproc_f(void)
>  {
>  	struct power_domain rproc_pwrdmn;
>  	struct udevice *dev;
> +	void *gtc_base;
>  	int ret;
>  
>  	ret = uclass_get_device_by_seq(UCLASS_REMOTEPROC, 1, &dev);
> @@ -321,6 +322,16 @@ static void resume_rproc_f(void)
>  	if (ret)
>  		panic("power_domain_get_rproc() failed: %d\n", ret);
>  
> +	gtc_base = dev_read_addr_ptr(dev);
> +	if (!gtc_base)
> +		panic("Get GTC address failed\n");
> +
> +#define GTC_CNTCR_REG	0x0
> +#define GTC_CNTR_EN	0x3
> +
> +	/* GTC counter values have been restored by TIFS, so enable the counter */
> +	writel(GTC_CNTR_EN, gtc_base + GTC_CNTCR_REG);
> +
>  	ret = power_domain_on(&rproc_pwrdmn);
>  	if (ret)
>  		panic("power_domain_on failed: %d\n", ret);
> diff --git a/drivers/remoteproc/ti_k3_arm64_rproc.c b/drivers/remoteproc/ti_k3_arm64_rproc.c
> index 403c6bed2e8c..9b8a6b7dc53a 100644
> --- a/drivers/remoteproc/ti_k3_arm64_rproc.c
> +++ b/drivers/remoteproc/ti_k3_arm64_rproc.c
> @@ -17,6 +17,7 @@
>  #include <dm/device_compat.h>
>  #include <linux/err.h>
>  #include <linux/soc/ti/ti_sci_protocol.h>
> +#include <mach/hardware.h>
>  #include "ti_sci_proc.h"
>  
>  #define INVALID_ID	0xff
> @@ -78,8 +79,13 @@ static int k3_arm64_load(struct udevice *dev, ulong addr, ulong size)
>  	/* Store the clock frequency down for GTC users to pick  up */
>  	writel((u32)gtc_rate, rproc->gtc_base + GTC_CNTFID0_REG);
>  
> -	/* Enable the timer before starting remote core */
> -	writel(GTC_CNTR_EN, rproc->gtc_base + GTC_CNTCR_REG);
> +	if (!j7xx_board_is_resuming()) {
> +		/*
> +		 * In case of a fresh boot, enable the timer before
> +		 * starting the remote core.
> +		 */
> +		writel(GTC_CNTR_EN, rproc->gtc_base + GTC_CNTCR_REG);
> +	}
>  
>  	/*
>  	 * Setting the right clock frequency would have taken care by

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


