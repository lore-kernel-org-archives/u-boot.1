Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320A9CA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 23:47:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CBC3F80984;
	Mon, 12 Oct 2026 23:47:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MWBsRUYujh-x; Mon, 12 Oct 2026 23:47:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0DDAE80A87
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791848868;
	b=LOFd2WV+9vucLj/jASP7rwNIICaJsz6c20zpoQpqpVlL5jHT/9AQMDcKsTMloJRJvLCq
	 AbHgacloGl0D/VFBPQ0ARqzJC686xSV0YeZAQI+9wTrLAgH00/Jik6e+SVrFwy4usQS2o
	 4m2ioUp23deN10+EnQA0GbYaqM94CmlX/H6OqmT7RzYXX4fP06Tl0nr+PsjMBIqTEzba5
	 sIPPGmsO4w+ZzC2LD27+9hLSBHa4yVlDPdY04EnYlWWUlgqYdc/zUe/S/65RmmZQBbxyi
	 fW+CEOiLbUDZaqMrrOD6l72sVOz7eAc+d194q4BnhA4oF3sU8k0qUnlOSOct8QEuibA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791848868;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:CC:X-Mailer:X-EOPAttributedMessage:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vW/x+5zJ418z6UkSZiC30yACC5GZmow9JkWinEZJUMk=;
	b=s8vNXg8SpH989mSrrYyMX/quB5m0mbyHpgN9Vr523dFk/a9WFnv4/+s1p3OzCfwvEK8u
	 pIa41FCytI8oZnR6ZvLoIyr18KqD52En/VdcIGqgLHFkoQ/DUA8RBLevW8Q0P7XbMqw9d
	 PDnBxTnWn1O/7MK3nO8JxYjgPMIackLmlNR07AGlpkRV+lMa6HsR2g19Fw8pFggi6qNbd
	 HSsUTcBGDl+VdX4JQknsCowRJS4Kf0o7SJhkcguHaoBw9EflDx/nN1XzQn8tZv0EL/5o5
	 NSjEwpYZ1LE4jMiJs6AtkAnVGFdypLka1rQccBiJNRrQHFfCIbVN4juTTlQo9nOg8Lg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791848868;
	bh=vW/x+5zJ418z6UkSZiC30yACC5GZmow9JkWinEZJUMk=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UzoX/JPzLNEoXYk4/9UZ4Legiv1zfHFeORoxtBx+MzLOhGf9HMCECDjCBA5Dap1uh
	 7faCv41S3YlN0vrY+BJa8uNes1tvGOBkW0yZ2++vaf/oBmGBDJYjVqSay1eBMYKI00
	 swbxOqkCUN2IL6wlbHQpfE4QWgCsR515juleUUhccFujkRJ+VBzvvkJIhaWCwHb9cD
	 whhOnzdlcpKMgRFH2UfGORn7BOPcMmb3QhBmxZX2t/+HTtjkILWe/ffN5z6HnvOI/R
	 DIVPnEgjPGXuy7tSQO7h1k2bDzGQf+kN90P0dwgv1CuuPq1aA/z8XHVkVxme8o0y/n
	 sJ0pLZx1WXKkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DDAE80A87;
	Mon, 12 Oct 2026 23:47:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E0DD4DD
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 23:47:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8F710606F0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 23:47:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9vQCAx_uirik for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 23:47:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 53C75605CE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791848865;
 b=C3GTOE3O0diBydS5DYdaIjetauRiNWpF2way4bKPMntLtRE97wrg9EBrbwTAlq2W0/Pz
 LYcEl/KzDVFM3PeJLuXgDpN0/dv+TlCV/Mlir3iV2EU2c7xwnGQoHiaQbjVM4db+o4i5g
 6Sf9+qoGEsTASDSk/oUa1gUjQE0M3y7KkYCka4ypigS3LOc1R1mQOXReukqtG5x1AJbWw
 JZZmy1ctAURspGq/qsZJfy+yVlKQAotV7uqQ2M1S2aPIzhVOq/LEIHFwOA1NuBCab28hE
 wwE5VSXt4hE5IGel3OSCj0Nnk+OJV/uQu50EAWc0bs4R264LXDnc+bfhGXAoBfy9G3A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791848865;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
 References:In-Reply-To:To:CC:X-Mailer:X-EOPAttributedMessage:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=vW/x+5zJ418z6UkSZiC30yACC5GZmow9JkWinEZJUMk=;
 b=EeGcbzqN7C0e675GUUJogI0AH8MoMvprlZqcAdqLHBB9ySo2OyBEVzFyOjLKdZcWKOn5
 3CnS2IK0ijkT0GzCD+sJbEDOAH55+J9Bn3BHrTDWFrYfoUq7J75AyDnpsaEcVGlWPGCui
 Sn1wKx/i25YdzKOYi21dXmLePkQcBUf1g4Cwh+0XxjNRPBf8WVzKzoPlmgZnKzcd0ocwf
 din3eApOJU9hkYFEw3i+gO5OghC9Mc21cluq/LCi+JqcUvaktglwIxtCURplCgUmQG6le
 dPe9p+8GqB7KF9fR5uOSeFSUEOyT1IKYHfNcU7LMtxFOIA6fkiFNlzPWYKmgwoTVJFg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=ti.com;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=lh4Iygvu; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=IxOHVY3Y; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=lh4Iygvu; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=IxOHVY3Y
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 53C75605CE
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 23:47:44 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CKK0DQ3129085; Mon, 12 Oct 2026 18:47:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=vW/x+5zJ418z6UkSZiC30yACC5GZmow9JkWinEZJU
 Mk=; b=lh4IygvunFhO+rDpc04vh3mhL/hLYHvdAvVJeRhLeKMl+uwoK0rUmnoha
 yX+ojp1SLV8zCNhvjrzR7v/axrblEsku1rA0+hGHLDiKm+7sImPq9LFgXza7TfeP
 UDIigcLtfDMqmu8zMxvRkmTK+i+FxahhjFDmJaOL6KwVzjBofGfApkmjkuXGwzY6
 nRZN6b6GXr4UoTCL4RdcIXb0t67+Zoa7bUOHkc1BCYKplMsbUuxrZMrnIV8gJBHw
 1xE2yDJUn+sUyCmg2tUxWBCoDO8zvLClEnrX4LXGxY8ME+i8GU1NO4MrSc4P5tAX
 9CZNx51saYbwP19NbPJUOXJVJvFyQ==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11011040.outbound.protection.outlook.com [52.101.57.40])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h907nusyd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 12 Oct 2026 18:47:41 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qtzpudEy5d556WfSfrJ5ENcSPDhUcHZ8IcfL3d97lTgL4Yut8wa1Svnxqktw3WrfZLObSoflEgKDIP9KQzsBYJAFe3bCTb/p77MbwSO78c7O6wgRbB9CIYXc68qaTVlTNqIZ2l+RZxmz4T77WGOGyfcNL4CAHBRunpWjgM3YsQVAKX2jDj0dLgYIO01Skmk1L917IakBN8GL47N6fcaIQ0bmMnUybT0lsKjGpjfrgwzoAtG6KQd6vKBs6iA8G6nh9lgaDLyssTTB/d/npLeojufiK8tcctfVE8KSfDC+/ed8dF5fuQYsGIOM6EIJ5/Z6ot3+vo5CyAwX1d+WU1st9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vW/x+5zJ418z6UkSZiC30yACC5GZmow9JkWinEZJUMk=;
 b=KySiR0sySxeXg3220ZVEPdH0Lf5b+DTzc/52mvF5WG8w0YY/rnmzuX8lb2b4C1Lzknry0LG9/unpEKNSQalUhQaRLgDcVzMlc302G4v2/th11AZZiEBP9BhDC+njkpXsKNeRaS3Ys0JZRS6JRgOchgTHV5HZHxEqIycpDnIC5gPBrsixUQLzGDxIc3OPLnhgfW7Tjh9OhphO6vByb9A7+Dmo48FN1kWkQSzVBqdvTcLxNrc2+UODJqygfkU2P6kjRDKiAZTMs/lTrizBCPm8jmMoPo3SilAT8RiS0XIBsTweIdhUER00E2Hy/S1CV0pdlRQicfLO9WeRxSYHzfPzng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vW/x+5zJ418z6UkSZiC30yACC5GZmow9JkWinEZJUMk=;
 b=IxOHVY3YTQXMlbRgXu2LbdxWpMskGd44yZFlJNzEYVf88+1MPiqcFdV7DkefAccgAB/uGPRLnx8vPStVrh80/VtPUdeXzKu3Rl328afF5uHmyBfZ48pWtT3SVr491jQmQgYRURUmNCjpxYAQ69BcJv8MVZzW3031FDKE3oSV0Bo=
Received: from SJ0PR03CA0196.namprd03.prod.outlook.com (2603:10b6:a03:2ef::21)
 by PH0PR10MB5659.namprd10.prod.outlook.com (2603:10b6:510:fe::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.11; Mon, 12 Oct
 2026 23:47:38 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::4c) by SJ0PR03CA0196.outlook.office365.com
 (2603:10b6:a03:2ef::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 23:47:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 23:47:37 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 12 Oct
 2026 18:47:12 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 12 Oct
 2026 18:47:12 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 12 Oct 2026 18:47:12 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.75.137])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69CNlCrc3331271;
 Mon, 12 Oct 2026 18:47:12 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Mon, 12 Oct 2026 18:47:03 -0500
Subject: [PATCH 1/2] arm: mach-k3: am62a: remove dt nodes not backed by
 hardware
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261012-cutdowns-v1-1-ce9e745eb857@ti.com>
References: <20261012-cutdowns-v1-0-ce9e745eb857@ti.com>
In-Reply-To: <20261012-cutdowns-v1-0-ce9e745eb857@ti.com>
To: <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.15.2
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|PH0PR10MB5659:EE_
X-MS-Office365-Filtering-Correlation-Id: b6f987a9-699c-4a58-a233-08df28bb321f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|56012099006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: eHfg/etyByX15vYgwGdM6TdoG8NSZd76I1hNJDIwsY7Hcu4fAFEg1T7wcHaULIbQwEjqJbCn7+QqHBYS2WeVXCURZKBtaG8p8q3BRTln2uqrg/coFl/Jcify4lJRwtt2ZM4eyDfn7dQGmTu2IHYtCFskSaUesb/xnt+uxB6hL4YewvfLkNmzN0wfu3RGxZsK+XH9xHrsXBw/0NcyhHq1elWpqi+sOFZmCjTvYwG2FYGDKVVPRUAI3iqj4wNLPIfTdDed5KoYXRr6HC2ivdHeFo09Y0JKA1SwKtgwaYZkuVLlhO9/zW6mksNWdyGwJ+gvN+IcPk+Z/T3n9BIqvbhjf7NXi26RMOWy5gNsPJ75BKd78RIDJrv+CHeTpMLm6dp461yZhbtn0oQe/e3z28YMXtIQ//vBzFyw1OgJEnx5rtjFpaqsXkywrBWtPsYIArF12jZFukYAGbPkTiVOy3n/bJh6B0b+7OCzCMtnE+WlwPsLyCeW6qPobsFggyiUmHfBOcVFbxFfujKEE7ZBbVXkjBBk+qGpBG9ns+2RdStzi8g8QGN5z6utPmSsgs+fVoUKgPCDqVwdBM6/OqvYg5fQQrZoh+fIPXMR0g4I4KU1LoY0COwTG160Qm9AyImGh/gASEMeBxNs3bGfH4TggjuJeTaj4RqNq833z93X7p9L9d12XcnT8s/cnYov94qaoFYTP35seG31dHwPrlsupI7S/w==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GDB5qKHb0qQSmlSlXmx1MJwTqtzMYLINXPt+XbYz8cgQtktz+Li5eHU2G3FaKFvmUL8dEGsPdSLT/JOc8EC8/WA7ezSCecwtVDLCmzU7TOcTsYfFUf1jQ79nun+IVRIQWA5L2Mv5lL5HY7rlOhw2B+LzA9nSMP1kHGPGpvG+TYlDjadmGduG1d6dfx24A5bm5s3VvVq8Xca+zIDCERHkbTTVjWx6kPI6w0dLa3Bfu/1HjHJToQsHzx90caWxidbLZ3lO0ftd4XJ4BY7VeWK19Fl9RfdjKCEEdKsay/OSsGnRcLOXUsqZN9Eb8rOEVUtVfEIIyqGX1FuCslA/Kt+MbM+r7wNbhg3XuvsgUTQES464YPOZslLcUsBFemkMpcsiVLd8rBKqJ3iWeeO5lEkTsqP+gV4oCeNdF3k1AqhhnLcaevTQQwSRi9Xr59IA5e1n
X-Exchange-RoutingPolicyChecked: deHrh7O+H9O1kCCTmJBj0Q9UKlnJtbGOTOa1ZPampj3UpvnqHZ1WQ+BjuQZSKf9wLs3YYrEr31wuzRxEeGQaB/n4UnMgB/7Hp8coJbkegqVIArbC8nt1O4EwLCr8wxhdw7x9UAFuGAh43OOLc8gNqEoFmkdfWlTHq4FC1suk6rfWC/By3QjDt9++csnTxY1ab4oNeorxPVJ7aIeZ/IUmmUwenxC7GcJkn2tE+IrlyCbVda3f/sLevc7kzGadyl2voKpBl9YEX6q3XiYkW8Lkmygz0iQSR1E8yUFIWC0896bp6dz5U5V3/OD0svwedysEayP6JCFOuocLUAptIBhvMA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 23:47:37.3550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f987a9-699c-4a58-a233-08df28bb321f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5659
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA5NCBTYWx0ZWRfX6bi7V49ww2qx
 0pV1onjoC82CyhwgLfXNuydoQrCvDUaiKRS6DcFaUA8VXzqzzZPy9UZHnbiZ0QVol7ZGEHKR/D9
 yLoV9kKdpmati0B7WldYVups4+7bSl0=
X-Proofpoint-ORIG-GUID: CTUiEbLT44qiVFI8SqMYFcBcskKO6mac
X-Proofpoint-GUID: CTUiEbLT44qiVFI8SqMYFcBcskKO6mac
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA5NCBTYWx0ZWRfXw9tUHa6loLLs
 i62aRUuNaLSJc4YeMTK/HuLDYd2emwDSEapT5l6pMKvTrj0Rbywzkw0G2y0g9qBfdjz05vivtK6
 ajIm8L60h6f8rH+LbrFXnMp6BAPANqVpcMxaxaZnI4Jz/UsS3JkpFGAqCT4gRM6siqVDJnpoNwM
 M/qZmOtcaW5KUF1/tBMROKTTDTmUXN4s27rqd8naXO/zoji4Uu9wN/UulNR5C37av4OS1s9wsSV
 IF0eTKHXMq5FkIACw1v6qeDF1ryDY55JnmdcVwfLvlQ/izNstpL4pzGmU6Dt5nH2oy802rsZ5ah
 TJgUuv0scvbfKu2+ljfTzpg8THjy2Ix+h/fYryfXePrl/RA6rkM6BXceaE0fSxerwUGYPl2aklc
 DuGjFIrYCsk3RsGHu1rA0UBPEGzFqy+dN3SCJ/XRXkYPGazJK8CTE1KKqMXuvh664PQevHuqLER
 xAAuFRw40Ur9OgSgULw==
X-Authority-Analysis: v=2.4 cv=Aa0kjHXG c=1 sm=1 tr=0 ts=6acd719d cx=c_pps
 a=MmUQU4Mtsiu6HzSWf2FVsg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=FHRTbEJdxRDvK_7H4_MA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120094
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

Some versions of the AM62A processors have reduced CPU counts. To avoid
boot stalls while Linux tries to probe these missing CPUs use the
DEVICE_ID field in the JTAG_USER_ID register know if we need to remove
these CPUs from the DT before booting into Linux.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/mach-k3/am62ax/am62a7_fdt.c           | 23 +++++++++++++++++++++++
 arch/arm/mach-k3/include/mach/am62a_hardware.h | 10 ++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/arm/mach-k3/am62ax/am62a7_fdt.c b/arch/arm/mach-k3/am62ax/am62a7_fdt.c
index bdc1747fd75c..d9e0a7b65efd 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_fdt.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_fdt.c
@@ -7,7 +7,30 @@
 #include <asm/hardware.h>
 #include <fdt_support.h>
 
+static int fdt_fixup_a53_nodes(void *dt)
+{
+	int nr = k3_get_core_nr();
+	char path[32];
+
+	/* remove the fused out cpus */
+	for (; nr < 4; nr++) {
+		snprintf(path, sizeof(path), "/cpus/cpu@%d", nr);
+		fdt_del_node_path(dt, path);
+
+		/* remove the cpu from the cluster */
+		snprintf(path, sizeof(path), "/cpus/cpu-map/cluster0/core%d", nr);
+		fdt_del_node_path(dt, path);
+
+		/* remove the watchdog for the cpu */
+		snprintf(path, sizeof(path), "/bus@f0000/watchdog@e0%d0000", nr);
+		fdt_del_node_path(dt, path);
+	}
+
+	return 0;
+}
+
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
+	fdt_fixup_a53_nodes(blob);
 	return fdt_fixup_reserved(blob);
 }
diff --git a/arch/arm/mach-k3/include/mach/am62a_hardware.h b/arch/arm/mach-k3/include/mach/am62a_hardware.h
index 21bed6e2c6e3..23bfb3eda68a 100644
--- a/arch/arm/mach-k3/include/mach/am62a_hardware.h
+++ b/arch/arm/mach-k3/include/mach/am62a_hardware.h
@@ -20,6 +20,8 @@
 #define WKUP_CTRL_MMR0_BASE			0x43000000
 
 #define CTRLMMR_WKUP_JTAG_DEVICE_ID		(WKUP_CTRL_MMR0_BASE + 0x18)
+#define JTAG_DEV_CORE_NR_MASK			GENMASK(19, 18)
+#define JTAG_DEV_CORE_NR_SHIFT			18
 #define JTAG_DEV_SPEED_MASK			GENMASK(10, 6)
 #define JTAG_DEV_SPEED_SHIFT			6
 
@@ -99,3 +101,11 @@ static const u32 put_device_ids[] = {};
 static const u32 put_core_ids[] = {};
 
 #endif /* __ASM_ARCH_AM62A_HARDWARE_H */
+
+static inline int k3_get_core_nr(void)
+{
+	u32 devid = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
+	u8 nr = (devid & JTAG_DEV_CORE_NR_MASK) >> JTAG_DEV_CORE_NR_SHIFT;
+
+	return nr + 1;
+}

-- 
2.55.0

