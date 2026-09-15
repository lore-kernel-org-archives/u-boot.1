Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CCAC88E53
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 05:42:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 69EA680C4E;
	Tue, 15 Sep 2026 05:42:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XQ7yJVlNf4vY; Tue, 15 Sep 2026 05:42:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 618FD80C46
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789450925;
	b=mEeuatv8SQ/98kbEHoHFk61ZzUxgnc30U7eohmeMedmoqrKJlsGu47T1Yi46kWOyUT+4
	 z+bAuhKXaPF6lMvT8m4EyTMW4ya8Y7DwDgF6EZyUyBeCUlkryxrv79/2XFiIK6+QXluk8
	 KOZQjdT3LV6UHGyl947ngqR0SRN5SnSVqiputPFr8lzf7VqoAwfHjOK7TDu7HnIxKaRFS
	 +Z/dZtKrOO+pwX3/Kcv1MoLKRUchs+X7qGy787ONc7W/D74cXTEsnV/85bSxxOO6kCVul
	 yfkm72xqSiK9eKT96HuXbQjwfLP34/WSlmRNayw0HBU72WvjrFIGGVjnIm6CEImIkEQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789450925;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:CC:In-Reply-To:References:
	 Date:Message-ID:X-Mailer:X-Developer-Signature:X-Developer-Key:
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TJh6loCWeRkUH16AI1U/fp5lsYrBjkReaO/M/x82y+A=;
	b=OZYuQhZiVqA9pUrW3xtAxcbg80AMQYYue8k1Jf0mcTfDL/iflWwjOTqP1LO31LtE+HaI
	 XQ4PPT55gvlQNMPrEHCh69F30wx8iB+AUhk90G7xwn2q6oL637maaUIX8o/SASKKOX8R3
	 PLGehxoW0UTRT2BagjSacIzNYzCHOTLfZ5A9kq1VKdE0ZwX+LLUK1YkU/86j6HgG9PJMk
	 s7WLqydI+a0X5sTb+COsqAZWVnYcDIKwmLIoepgtbxSLdQSc8jhrfpxyLrUPn0s2onzg5
	 2RM2sbLbR+B0R6I17Qk3mdVab1dgkwEBhu2JC/u6r9HFWg9wRRwYC+uq4Tr4NZWNnSA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789450925;
	bh=TJh6loCWeRkUH16AI1U/fp5lsYrBjkReaO/M/x82y+A=;
	h=Subject:From:To:CC:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V9WlivAIFCns7mVEj00otZuTZ43JMYvDOs4wFM7N6l9ZXLnFT7TaPsl99hA5b7zrz
	 y5zLfQpnPeu5U9M60WcrrvHbKV9y75JZ6+Yq4okal7BNKhaqRe4k7IZHkG8H37AQSn
	 n78QsWhgixbFP6gLwq2+T15PCrSC2qg4JJb4JQKA/79ojSGI8NbXx7l8YDnU43Hfra
	 q/Gm6Z8rVJOHA57UFrgFBDDiwNnOVDbEhSHvul7nR2zZBa4alF/9htcNGBDtkSZTHO
	 wCgkLKY8UHyZPrkmQWKB2XAUFj1k8l0L5DsbXgY1ujjKuLp9wYzlSPJdOzXyLfDeDG
	 yDBBmt8RdWJEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 618FD80C46;
	Tue, 15 Sep 2026 05:42:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D0AB5493
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 05:42:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C271440523
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 05:42:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NRGwOFTSo9NJ for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 05:42:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 677CD4051F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789450920;
 b=i5z9ZfjbGLZ0+H4XnEzX3IjukjAL0brcHg56I9QiLD+JU1rCWtpWZBnk4aakBKs7I03E
 oO3Ehbo//E4mhL5FupfTGIRAkK1BrPH1xnpm0yukmQEX74IOHAwwFIe9exmhUgExQeQj8
 nYE8VnifMp4UUdwtTcF9Q+zgBEkfJefZ5QfJkOF//lnxcSaKiWOW57+d//j4ABjvFn9Ng
 PMClXc1jncKTKGurDYqVWx4wrSKsscBB4jJyEj15Sc3GmaNyspP1DWxNPiPONH61gurTg
 usmFEcFBkyrYK7O1dLilL5KSvKv6ulN5aOlMzHWKPlbxzSWoH9Aj+qgie2iQl10U5mw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789450920;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Subject:From:To:CC:In-Reply-To:
 References:Date:Message-ID:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=TJh6loCWeRkUH16AI1U/fp5lsYrBjkReaO/M/x82y+A=;
 b=oeI0Mr1lG+U1O7oLZlKZHXxQIXrJTqmA3dlouzf7yRRER3uLr19xphCd1GCSPANp0U7q
 gkeTCr6ON7HL8edM0x05UQEriOZMsewzBj62o2moDzxp/EcfQOEDNoTLU9CKtymdDOvX/
 4PqZLnyPIZtkF6YUqW4pkrlltdIIU2tia9OqUMZxccv0+V4aZDeYYjXlePWhUjfomTlqQ
 xF2FNas8yp8FYWsjMT1yIBAoXvXyyjCBfOsSIL1UEd9jXjqwFtzxY3ezRknIZTQfKGtlu
 nrZURsuh8S4DovOWaYscdgJCAr6nmu/P3Q1MzJtgY4rYVoblkXNDctGBX9GSMLe0log==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=TqGkoKdR; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=uWr2x32y; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=anshuld@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=TqGkoKdR; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=uWr2x32y
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 677CD4051F
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 05:42:00 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68F2m0rZ3069813;
 Tue, 15 Sep 2026 00:41:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=TJh6loCWeRkUH16AI1U/fp5lsYrBjkReaO/M/x82y
 +A=; b=TqGkoKdRrVAARvu1owD+82B+0eYCMvOxC0jYss2jDvGplG5rZej56a3or
 Vr7/qgafGwujQtWAoh2g1vP0JpZIeob7t6wqijJaNv08i7q8CiEPkoxscm8Azh6H
 LzrplsaHQa4XGkmxOcrBXHhnNSl+dI6wFVTVzHtIP4jtLcPgY7sdwZxfkpCxTGen
 8NJ8EzYTR343h0xk3r+ujgecw61YJRNISI7hfwciYX7rxa9xtKPsxPLG4wkvZEUO
 Ma3VZQeP3XeEaOznAVaVUUTA83EtamyJfLyqXUIQGSAtZNVU4yUPRruFOhQBJHec
 LE09FlRQfbOwLvTDUJBlAQVc3Ug1w==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012034.outbound.protection.outlook.com
 [40.93.195.34])
 by m0380145.ppops.net (PPS) with ESMTPS id 4gppxsjvjr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2026 00:41:58 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jfc0uLdR88pz9D5IkU3OyK/Zpi3pApwcmBbWPl7Wk2lM0ctSiR+Bi6KASV5ZK/QxENnvwKSWNMq4oT2RPMQdtluhv4geYFFn/MPmI9SaLJIYDoAhfbwCtRzFB+Ri5NLum4llhgt1QjE6uekUWtOR+2IQy0Qm65o418MyYNpXJ01eTtkLz/2ZczdmmKZlIB8Bpk6+fhxjEaDKI9atAcozp+c1/RrCxQbyGDPnBHRhmHMLT3aqFHc7awZZCyuNgl+xdG1z4tnFzUbyQ1/OUC+ZdW8v16YUkyRAq2mWBBCTxDWAozzjCpNq2Gb71tQeGRXSBvNptSqgLlSutohNZLLSKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJh6loCWeRkUH16AI1U/fp5lsYrBjkReaO/M/x82y+A=;
 b=A+mhCIV2uHbS690M//i4BLIvPMDdBLP7VNxsxnmraDVWRtNO0zw5BDzGxLfJ2XGVusD35a5rYGgMA6YEXAzaTdPmF1LQBTg3J7rUg30bZNeRI58JrQLiAwdlD5djVR1vRbStn8SyTgIz4zTEwgTkQTrBvlJBbotUcpgJfM0KmJ7Nce2+YphNXJMUGTafxnK8FK1gF3+xzhRjedE/zumGEdFuccAPOgoompU8hHyGa++Ip6EKra4nleG6jEAy/xa3Xz6IpUZcWs4SPznP/r8MfX+Z1wPqjj9cnYtIcRS995Lo5koF3Pyvd21DsBNLNkAbrN5p7kzgu/V+01Uml5ew0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJh6loCWeRkUH16AI1U/fp5lsYrBjkReaO/M/x82y+A=;
 b=uWr2x32yJz97Ko7sowNgRpF5EEIYwRojAhSmJv671eO8AZRRH13UNpRJehtgbnpEODVQ8UnlVv9zYFX600548E2kn9J2XVYsZnBHdwUJ3oz6W2O1HL2b8NS4c1Ee05OEJHggRGueo3TdA56ZmyELW2O0SW+coIWiHmEYIU8k1AU=
Received: from SJ0PR03CA0014.namprd03.prod.outlook.com (2603:10b6:a03:33a::19)
 by IA1PR10MB7312.namprd10.prod.outlook.com (2603:10b6:208:3fc::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Tue, 15 Sep
 2026 05:41:52 +0000
Received: from MWH0EPF000C618F.namprd02.prod.outlook.com
 (2603:10b6:a03:33a:cafe::3f) by SJ0PR03CA0014.outlook.office365.com
 (2603:10b6:a03:33a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Tue,
 15 Sep 2026 05:41:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MWH0EPF000C618F.mail.protection.outlook.com (10.167.249.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 05:41:50 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 00:41:10 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 00:41:10 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 15 Sep 2026 00:41:10 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68F5f8D93582309;
 Tue, 15 Sep 2026 00:41:09 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] doc: board: ti: am64x: add missing debugging section
From: Anshul Dalal <anshuld@ti.com>
To: Bryan Brattlof <bb@ti.com>
CC: <u-boot@lists.u-boot-project.org>, Tom Rini <trini@konsulko.com>, "Apurva
 Nandan" <a-nandan@ti.com>, Anshul Dalal <anshuld@ti.com>, Chintan Vankar
 <c-vankar@ti.com>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 "Marek Vasut" <marek.vasut+renesas@mailbox.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Udit Kumar <u-kumar1@ti.com>, Hrushikesh Salunke
 <h-salunke@ti.com>
In-Reply-To: <20260901-openocd-tcl-fixes-v1-1-bbde8ddfe425@ti.com>
References: <20260901-openocd-tcl-fixes-v1-0-bbde8ddfe425@ti.com>
 <20260901-openocd-tcl-fixes-v1-1-bbde8ddfe425@ti.com>
Date: Tue, 15 Sep 2026 11:11:06 +0530
Message-ID: <178945086697.1987229.4447931325980814042.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789450868; l=1795;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=nqqrzxDHDnH7FTDZ92K0rtuKYdu5QQ8D8KUYjouSHCE=;
 b=n2Z9dAe1K3wS9dh1VALDhVQ2MA11SpHbnbmk6mZJ16YX5k1MwrGLCWGWsRxoJuGQ5i5eOp/Be
 4F1RP/npqulBac4QEKJwBFXhl7bkpWEzGfB+g/FvEPQQZPGyDOzAPRP
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618F:EE_|IA1PR10MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: 620d8e75-0037-424b-6558-08df12ec0a73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|13003099007|3023799007|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: HN7snQ5rumsLQH4e6FCpV8vEecZSgArphp4V6ChOFI1gvxUP10R7ZLJYjr9D/3jSdV+fsDsdRkpkVB/M+tlBHB6HcxZ1SnkEuk8FTfgWKHVR1pON++r4O0C1Nfd/DDjNt2vDprzNgNeVkd7s7rjNCC72LrcYg6+tmkGHRFordGSyYpW/Hne/AAtRbbFc/MFRbyA+HHT3cSCE6NEBoe5tcxIC8R1Xq2j1bvvm0HBo8eHt39XDafCSiEVJNbmdnSoXX9E1hGLdYahenZ5uKosIrLrIp8ofI0C2vISaDk9Z50xGBpu6vZyuvg8ttkUy6TLaEgMphpK9DsQ8X6lS0bFmZROwqqc1h04U83pHpjBjawR4Zaf0G0fjybRzSTky03hshd2kV0aSgGGDaoRmUYknaTuh2NlxvVLhTufzn9wNvJYh8WNSyINeh6Dw+AeU4VKxMfNyQc0p555lG1aR3uimaou4N9feKU38W5EnN4zGt+fBpuzhcMgHL+Z7j+0PZYjJ+efKz3E/0naher9ztBlKeJmdF0tu3fJ8ODjEgvcwKNy08YqFLSZ/0wK8mNIelRijg0wkn+XbcTy/n/+b4XG7n61U/yu58fTesUtuzYdJCGdf7pAaKRsTZGDhg3624VKHFTsWqs57v5co1ZbWYpxr+8+1h5HOYZATFIYjVwbvjOFtcFpL5OkupyLO199YP7DNg7TmBhIRlzaH4HB734vnUA==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(13003099007)(3023799007)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EThrQy0KjQbAehSg8EvUnLsPze6l3luLxgxkKD+c/biACGJYOrFKoJChk5yHyrX6v663oW41Tmu5GnLewVw1ivNLKDZTYk+9yFeb4qvCH8R7q53HLRFS3w7F5sFsE2fHR8SGzxz/nIe/RMXWQXIqn73KPCI1/OdOu2p0F+LOi22vp2hbli13i0K6gD3OSGj/Dl4b0u63WZm619m//SkC8Ejuxf16V1ChsKNjIlSpl0sKm3ltVhk4iA7TZyzoOR0blI2p6xkX4eR9KecebDciJtdDmU4Pz4L2TjqUZ7UTeAw4EizsmiPWJ4AEuR50KT9M5GZ+uZkLuXJ+uQodCkccLtOqUR0yaHoox+7eQIS++zMcYslicHRmLkPxi40InbG4OQ+BJRHLS0bp9MuUzN2atx/L0AtUtMauO2/Uz2m5tmp/MQUDrxEwibpuiriH0ClF
X-Exchange-RoutingPolicyChecked: DLG/oSzXgDz3v/rAuNzYZPdEGSvStHFueTVJHkeFFmcTbQJxoU9TB4Ztr4DBIhh9S5PZEKU2zIhef3n0mrvfPc66j6pZLRfiiZ4/l+RKyiEq2RybcHUtUDi+kc0Bj0CzdD1USh+89crxcGLZ1sJZoYG3RIQqC6br7qjipN2OpZUobM5zHpBC1wfjzugjfi8l8RVtzAsKE9nD8An9/1Oe8qHAuOksiP5LAODeByIZmkFcWT9n+5RiGb2K6pbEwOr/s5LfH969wz87HORNRCH4enwGgx3vQiEmN3KajZLVqYdJG9fAKk7Dd2oRY7xk1dzN/qjMWmGnEj7XUPFqPRqdpA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 05:41:50.5547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 620d8e75-0037-424b-6558-08df12ec0a73
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7312
X-Proofpoint-GUID: 5fgr4w4EN0VSwkGq8DFm0_7mwbdVjxyb
X-Proofpoint-ORIG-GUID: 5fgr4w4EN0VSwkGq8DFm0_7mwbdVjxyb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDA3OSBTYWx0ZWRfX3FOAitDYM9u0
 hAFpbQ4UdzdadjPG/IZw6juGGK/17eSs/07sSOvhEpo4keuJqxz3hlDWSfk1sjGyvHPKZlJeMop
 mEh6mnrMp+z9o/hXUMBZdAoLhtazrzGSBKiDmPbUxpilHTUercfQbRYghKdEPHvj3G5i1/5p27Z
 76csE6Iop345Ot/W3k+OzcTmspgJvNe+4eBmPuXYRja0S8FPmjZ/9aoOJ0X0GySdKHS6Nu9wtzp
 i/nU2GunJI8IcPuT0a1iKei8MNMii0o3Aanhwu/YjkUrHqq2EIpCIxUXWV1ygpt6oTkZMQd6b0m
 rPxoJfco2D4UTLdwVHyY0Cj/oaCMY8K9teOyK8B6X0AAbVb22AgYHAYtBn9KEUwdyoyKmqZZprb
 CYYAaI7pImqsCiE7y8wNWkWMPFdxoV+d9MUbYujVffw6iYCP5aZ8YLliZNG8yBo/NyGouVvNT2g
 PXr0jncn8bZck2Hapbw==
X-Authority-Analysis: v=2.4 cv=bYP+w+PB c=1 sm=1 tr=0 ts=6aa8daa6 cx=c_pps
 a=WlJYEohHt+uacJFhuK6UDg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=NEAV23lmAAAA:8
 a=ebCe-MjkWcUA55TQJw0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDA3OSBTYWx0ZWRfX5bkAhJb2GN4b
 B6PABML5RtcanONHBUTdp9UP6h7o/HvdGOdw4E9FGUe0HgpQSaqXsMowU8fUqmQavYp+hIAcCEv
 kAWLE/elAD3iWdmfXb7ADAvioMvraQc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_01,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150079
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

# Add your code comments below. There is no need to trim or delete
# any existing content -- just insert your comments under the relevant
# lines of code. Lines starting with "> " are quoted diff context and
# lines starting with "| " are comments from other reviewers.
# The final email will be reformatted automatically to include only
# the sections that have your comments.
#
> The OpenOCD debugging section is missing for the AM64-EVM. Add it to the
> board's documentation page.
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
>
> diff --git a/doc/board/ti/am64x_evm.rst b/doc/board/ti/am64x_evm.rst
> index 65c4c456528c..2e7d8f0549b1 100644
> --- a/doc/board/ti/am64x_evm.rst
> +++ b/doc/board/ti/am64x_evm.rst
> @@ -227,3 +227,27 @@ https://www.ti.com/lit/pdf/spruim2 under the `Boot Mode Pins` section.
>  
>    For SW2 and SW3, the switch state in the "ON" position = 1.
>    Boot bits on SK is reversed bits to the bootmode signals
> +
> +Debugging U-Boot
> +----------------
> +
> +See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
> +detailed setup information.
> +
> +.. warning::
> +
> +   **OpenOCD support after**: v0.12.0
> +
> +   Until the next stable release of OpenOCD is available in your development
> +   environment's distribution, it might be necessary to build OpenOCD `from the
> +   source <https://github.com/openocd-org/openocd>`_.
> +
> +.. include::  k3.rst
> +    :start-after: .. k3_rst_include_start_openocd_connect_XDS110
> +    :end-before: .. k3_rst_include_end_openocd_connect_XDS110
> +
> +To start OpenOCD and connect to the board
> +
> +.. prompt:: bash
> +
> +   openocd -f board/ti/am642evm.cfg

Reviewed-by: Anshul Dalal <anshuld@ti.com>

-- 
Anshul Dalal <anshuld@ti.com>
