Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3806FC79F89
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 08:48:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D27B880BBD;
	Mon,  7 Sep 2026 08:48:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pwSMgGxzzFud; Mon,  7 Sep 2026 08:48:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org ED00180A56
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788770927;
	b=qHCQRa5g9QOPp8HHYltFabRxS3YJnusQWtu06a0NGNaiMrjMpECVyalrerWN7GvS6T5/
	 6PIo92ZLmmInWWmvCvE4ut+noTH50PdH8X/zWQwtxZaaVdMp8O4/GOGEGShea4LGRBuwO
	 eEvyMvpblPZmtjIaFYdJe4sGb5zTUzU62FWshnZAkcQUv3lS3Ow4Q+vUuayfE8qOnb3Rc
	 aC66FWM5yge4oROWW/ZKuKGuh1CZimwqz91/yPQtTeONdMFfvAWCMH8j4MO/m7xodNwRm
	 FYsQlRrVVifPiSHYu98fU1iQcvEIcn8iftj55B9Am1CaCCMIDAHtQb2J7mSkLeSp5Hw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788770927;
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
	bh=nOtpnkjSOk74peizrXkG8di9BpmyGrNYgvLobs087uM=;
	b=qw+SXfILa66gFjBsRkaRDOBvOBwAC+XdifTQUbT75x0Tx7qaEI/1Su0eZDPLmPLmHD8H
	 LzcSwVKPR64GVFYMT/Hp/GiogIyFApYsc1Nql+I+KrppHfaI9/cCiBO4QWTiPAIkw3b3z
	 VewzKSFZ3VYusBt0wOYq3MA2QQGSXqRPFtPvaAwK60udDolumqR91QeRggMDnM6Wae9GV
	 DVPJmI8W5Y01C32r30i5r593arvgt2iuSiTWFb78PvIpI0goFA36MGqrYuR0zBv69iRna
	 xg3QZmdXAwPBqW4+yVT/l+ZM5yEYJRS7QlQirlS2+PLaehqhuvdWPhhhv37lD0yjtgw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788770927;
	bh=nOtpnkjSOk74peizrXkG8di9BpmyGrNYgvLobs087uM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cRnU9eBal918ypy6RORCefeiGCt0mFLIDju6qFzQzma5N0zTKO3/UZ2rT1sKUHvxx
	 H/PFMtVQL9iVa61+yZozJU/WSf1Bt5u/YAK6NeuXfd5BiH0kdCOjOjingOueB/m9nb
	 ZHVc+CWp3SkLhrj/LFRXt8GmAu4IpqVGMj46sR6nIuysjCb8Rr59iNhRG8o1PzQKZu
	 We7SCrLSHaYNTvh/N9ywZSKKV7puHy+nb3BIoG3i4pF0PXz1tKBqooakAH8k9tfVP3
	 UOnJ8ncO1ph2oDrYXOlZLY8M3+sAwu71QEqL7oSi3QWb+cKQdR4rFLGwYNB+9tG7o6
	 tBHLvcZjJToeg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED00180A56;
	Mon,  7 Sep 2026 08:48:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2DED372C
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:48:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1FB4060634
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:48:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ikE6NsmBHKoJ for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 08:48:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0A46A605DF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788770925;
 b=T6pCqygnrIVE6WGoBEYMqWKxoCca3uKeQjJ70gxmsq6q7Nuo91wm2kENPmB7acUKOpcg
 pUPFkG8CqQX+QKtS7HHPcLxUnevSochiceCuHT3OaTYAmXmt+ILx1YxKEQVxEHaXe1ACv
 cQHDy6+on35APGB8OxRieTXy1GRUw/jk4UOrW7ijlT/LAODMT34klNQjNlzf4Z0D78keJ
 H8L+N5nS1yJWH9R4YBKv2foIQqq6Yy5NyeREOhnaeQqXqvVljXk+ponrCsvqZnNYWiDzF
 JZeLvLKAVF1mdCuRGahtEcrw2I5AN22nOQwX4Irl/WjkOQ2LuSM5G7RYoH5JO5N3nxw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788770925;
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
 bh=nOtpnkjSOk74peizrXkG8di9BpmyGrNYgvLobs087uM=;
 b=ECNv52xUQS3MGPbOBJTWMKWtK9tmWwaYJq3jv18mM4aOWvsRZtWZH0tM+s9pWYpNkB/w
 drS60S+XqAXniumGOSR52wL2Vg2G4My5PLOdhYArsuigMGk2Z+A7jTQEQ/8Zjhjswystb
 ikUu2N/7IPmmAYyEhZb33+GHUOfEuMgm7PiZCGJhJTu0jV1+qyKPbVEKy3Omnfg1/BNcf
 tgm0DmkPrc/EiA5f0ESoJrzWIoyRo2UDwMnU3CMpgVwBjbfr8eAs52NCft5mOxtYA7kvH
 ptfdxTa3LWzE7NWNgLEj46phXOVlRVK5rtbclUBZ9/BYMNsoxNQROEkLfCam86vAq/Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=j86mYpCd; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=NbaP6A6P; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=j86mYpCd; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=NbaP6A6P
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0A46A605DF
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:48:44 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687766jr2795816; Mon, 7 Sep 2026 03:48:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=nOtpnkjSOk74peizrXkG8di9BpmyGrNYgvLobs087
 uM=; b=j86mYpCdd03/nzgyFfRfTpErzn+LbzH7uTbEps3gmkLhzF0RdcVjj5IXd
 tGFViFOEZYJJkzzmz+m7uAdyhI0C5bVYfzRK5yYiIwByFQrVH+Gra+0rAy67gW/l
 iq2VG+un73Id7ZKPDKYjVXqsIrF1WOOxEVfe/eJn+yY8bcMlC4qSWqrlV49ZjG7W
 PYvxeNBZF+9l3Q9zrGp3rz+xu6esdC2xZw0NReK0X7Nd5CjkAfwgJ+Ena/JnQOmM
 ZqnmgxotFsRWor7ZYPFq7tRzfA8P/1zhqTKMYii6h6nXkLs2ZJ/+n5gct1CrBNIb
 oOrf/hW2OwUUu12ERxlYSJ9BmBy9g==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011001.outbound.protection.outlook.com [52.101.52.1])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gh2f6cy90-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 07 Sep 2026 03:48:39 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcDWfd9znEw8oWOwaZ2WKH52oHbpo5d1KVdfOkaOhOI042AshKgII/hGW+f8Q5N3wKP4oZZhrewNY55iPuyuA48EWBLrhAsH0XfD5hoHv0CO8STfr927gO6FeGqblPI6OIdk2katicFB5XJ6JTqNmxoopx4JMupLW3k4vqabMno0rusjli35atNF+Kma6XKyG9f+7T1dKGBVnuVVaVyS/DPMGsUs5hpI5uu+5ZVFdGKSHT0boAd8Gvb3dHFVfSNxRI2Ci9t/jXyFA8f2PRSWMwGxJ2U8n5NKPo6QUFghVbQ6725VfWZqhONrFysVoiv4GwGWmWm8ivHYGCmRM54eqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOtpnkjSOk74peizrXkG8di9BpmyGrNYgvLobs087uM=;
 b=lC+21g62Q3FjMpCcZlA8JwNMNalAH70rg3nPqXW4EwCyZV47Nv3pGZkzSbl7Hwc3xy0Nh8YEunl+Ke53B6kOHmBfKJaziwjb022T83UPYr26IXVfJk2NXkuULN0alJBZohoufP5sum2HQY/szA8KR2HCj8f/JnsvDl+uc1fnYt+JpNDlYLbpxgrJ2nhLWqOG8/Ed/SMu/1p5NsdnyWTRQzxrXiCxkMKj7sP+GS5A4S2Z2qH60k4dQSbVkeErj+X69LcKZUFRUG+DZUNqh/GcpVZFIXi/0iwBmEMzic/Fluabl0fYDHvox9l4djupA+YYVWxMQ8VVea3mBlllqR9V/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOtpnkjSOk74peizrXkG8di9BpmyGrNYgvLobs087uM=;
 b=NbaP6A6PzSbZRENvGumf05ciDUHDVIVWM72WIyJy495c+34ffGd1qAxomVjDzSJxsg4FfKV5IjcDE3XZBgUXLXc6gIZo94L/Y7IJSQctu4N6lhXTYc6HxC4ImG5wUYnlXCz3IRHxMCwiMqB1zREocKtlCNiKOXZgp/INSVgg97s=
Received: from SJ0PR05CA0143.namprd05.prod.outlook.com (2603:10b6:a03:33d::28)
 by IA0PR10MB6748.namprd10.prod.outlook.com (2603:10b6:208:43c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Mon, 7 Sep 2026
 08:48:37 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::a7) by SJ0PR05CA0143.outlook.office365.com
 (2603:10b6:a03:33d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.4 via Frontend Transport; Mon, 7
 Sep 2026 08:48:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 08:48:35 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 03:47:51 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 03:47:51 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 7 Sep 2026 03:47:51 -0500
Received: from [172.24.21.163] (lt5cg60819vj.dhcp.ti.com [172.24.21.163])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6878lkLA191709;
 Mon, 7 Sep 2026 03:47:47 -0500
Message-ID: <44d1b3e7-1093-4949-aef4-ca5f5cad736e@ti.com>
Date: Mon, 7 Sep 2026 14:17:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/21] arm: mach-k3: Update pm-boardcfg for all k3
 platforms
To: "Richard Genoud (TI)" <richard.genoud@bootlin.com>, Tom Rini
 <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>, "Andrew F .
 Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof
 <bb@ti.com>, Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, "Francis, Neha" <n-francis@ti.com>
CC: Markus Schneider-Pargmann <msp@baylibre.com>, Kendall Willis
 <k-willis@ti.com>, Abhash Kumar <a-kumar2@ti.com>, Thomas Richard
 <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 <u-boot@lists.u-boot-project.org>, <u-kumar1@ti.com>
References: <20260828135730.1565643-1-richard.genoud@bootlin.com>
 <20260828135730.1565643-20-richard.genoud@bootlin.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260828135730.1565643-20-richard.genoud@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|IA0PR10MB6748:EE_
X-MS-Office365-Filtering-Correlation-Id: 726fbcfe-e3b9-4886-2147-08df0cbcce11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|10067099003|6133799003|3023799007|22082099003|18002099003|56012099006|4143699003|921020;
X-Microsoft-Antispam-Message-Info: 3Kv3IxXZNH7pL8Li8WKxhfS+8zcTVEVDOTofEkBz3+bcQo0ZeEx0NXmiiSxqFixqzalUV7eeRJS69G1Iy2Ox5zwIqB8c8q4LLulzuuu0vB1Q4kr6WSg+PtQSHV8ppBKJHiKt2bHYjQfHEf8hQPojlSZw4XCkrmQ544CCq3yxdyBT6AYE9NQh442bX4m3k3o8OtWS9gOM6PYwCT020d+2r6c3D+6kvPz8Jn241sR/p+KejNdpAM8BVv7Kz5CCa2bbZt3H4H9jDyXQm822zeJk1r+XW2Bn2q72Wm2P5sXrUKedItTbYXTgHqBys72H9fDmi/qJ+XS27OtbZjXsnYvRbwxNSMoOF3Dt4jLIov8P9PFTXptFrTX98z0SlrHI3A3EiOV5RaY2e3A4RSkBPQXnMWyPg2aGG+o7nHs7RtkocbFpRmXmNv1Mr/XAFLaIsgdSArn7M1s1t+VGSjrrvLLnL4NodeQ51s6VLxq+y/bJao6dB8vcKQo5fh+sXe0RY1l3gZKi3utMjFZzcdUljNUC8nWj5/QDnMKTPtUvQv4qN8eljrOlxD51Wet6fUFkJAZu1kHFVQjDMdGp53VDMHqfPvFBSWBYsVSLK360eRI2fOy+IbgaHEzB5Lv0D2EhS1YTy/Jpa34M+T/eAH/SWNd/9kCnmsKhwO7Iv6w5KSVAbc0GdauD22qOu7aVMPTizhI/O1UNfAwJ3crFJGY7vHla/Nv4VMvDSv7H9kS56gbTNkFSetg23BPvlOBmiAqtkcWL
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(56012099006)(4143699003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Wtih4GCIrm8CoKCHgdC1WcomRjfsRzSJ+UuKfgXbCNFJepJecKPB/CEol/t6cnwlwIsIOvEbbPlap9hLRrMcCc24XP0AE6D3hakW1PnAJB5u5gmoBPFvYPLrV0k6ZKjdc/xQSr3lfAoluEXgs7H2exHczjjpT3tXsyJjh7pHItkZdR6Hyji0gTI4N6x38U/aWhAQhSSVGhfMMeP1+E3CrsfpKmk7WOHNB40bao9fkUoDGDcvj1FvOH4uD5XoqXZ1VopVFzQvcvQed0FxQnx6rDshp05EkJy1I8L/GMqa+W/P4dloKEQkb58XjkKyLHhrII+7lWPihhRkySa4Adur5AZN91PICYMYGGSpeyiS8Vr4jgJjbZ5ljfjuIJde8hBtJLPuHpRDct2yzSWlxSUhvJCTfYeI+JQvRmPpfG0e+PJ7r8DoGfMzl72A/DVAono9
X-Exchange-RoutingPolicyChecked: dytZSG1lnmXPZtM7XDaSo/zplpFNh2BJiyWdNnmvFeK91TCrASrST8ZASW2ZE+G/aQWGMX0qnY7TJjms6y0nuM4T9sI4Yk6gRTYu3dG8FmKOPZbBZYPx1n9mdZUw2keqbIKXBakmfapsg8qohBCURzGV8D8g0LL/AAtvkW23cV3hbGPbdG+vGZlOKcF3FJf4zfUb0HZJDwty0wxCCCZBLXxKn5HSWOtNzG8oRsNsh4G13620GdHzZZ6GUy3VKn8GkwR4p+1OHK0ixJeW83FUXeLsblnSKw7UE4xqRtVjZP/FjGAR4Y22jImENWJ6jry3GiPcUvCQGV4OAzSjOZM/ag==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 08:48:35.9175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 726fbcfe-e3b9-4886-2147-08df0cbcce11
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6748
X-Proofpoint-GUID: dhvIA0VNRdtJxWMenu-lXveD8XoZloe6
X-Authority-Analysis: v=2.4 cv=Wqkb99fv c=1 sm=1 tr=0 ts=6a9e7a68 cx=c_pps
 a=v9d8l4VwGb/BX2RVr192eg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=P-IC7800AAAA:8
 a=CD318WkhgMDSzU0o0PUA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: dhvIA0VNRdtJxWMenu-lXveD8XoZloe6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA5NSBTYWx0ZWRfX4Io5yKM6EG1I
 QxgwfY4qAVAxPSBTAdNE3CBplkOrzd+TWBK8xtAXJblo8AZhG9OYl2rTt96wMudK7vO3xAnRpzm
 DUTDbxRn+zGXZhPVLLfy73VoH9LfW0gLKVq/xObg0h7vGvlzb2oKRyW7C6RocuFyIcSYhLHAZXB
 gZ8B06h5bwosjIY2ROlmbFawfHJFDBtokSHa763AeLvqbTrqSm6Cx1vl7jdxCtE0lEa7gvPWwR7
 T1CQAUcUwNG3k+70fzl3tcJGkFazgPW2axKGDSS4L2OFswcHZoZ5gmQe8V+5/n+xhFtRsoyPa9k
 +qfYd7xvOtbbmOXn9AjlGINGuCmOZs9QBWnEpKoDGF6UNiieynGHnnMTWSJEGIxkVYQzWyag6jD
 ph9fhzIKjQR7naOtPg5MuRqKARY56qqi9xFgEdymR12tQsrMKmEk/prl5V5VO7xi7obuhU3vpBd
 r+gpWo+4uwKT0LWNNEQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA5NSBTYWx0ZWRfX9kKr2Ei0yrnX
 YEQiuBBSRJA+VW9OoE1XP18V6iayxWvlFRuCB0MOPJXgOg3G8wI33zA+glomFlFd5yMmHH10awI
 /4FDdqmIMWvHyge9Ad+uCkkNQGptqn4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070095
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
> Update the pm-cfg and schema to a new version. The new pm-boardcfg has the
> following substructures
> 
> - lpm_cfg : Low Power Mode configuration
> - pll_cfg : PLL configuration
> - dev_cfg : Device Power configuration
> - rsvd_pmic_cfg : Reserved PMIC configuration
> - rsvd_cfg : Reserved configuration containing the size for the flexible
>     array appended at the end of pm-boardcfg
> 
> The ABI revision for pm-cfg is also changed from 0:1 to 1:1
> 
> Modify the pm-cfg for am62ax, am62dx, am62px, am62x, am64x, am65x,
> j721s2, j722s to change the hierarchy from "pm-cfg -> rev" to
> "pm-cfg -> pm-boardcfg -> rev".
> 
> This change only adds a new 'pm-boardcfg' property as a parent of the
> 'rev' property, this does not affect the generated pm-cfg binary.
> 
> Add u64 type in schema and update the boardcfg script to deal with u64
> types.
> 
> Signed-off-by: Abhash Kumar Jha <a-kumar2@ti.com>
> Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
> Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
> ---
>  [..]>          if type(val) == int:
>              br = val.to_bytes(size, byteorder='little')

Acked-by: Udit Kumar <u-kumar1@ti.com>


