Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4FDC9830D
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 10:40:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 55004606DC;
	Fri, 25 Sep 2026 10:40:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kmbah1RgKBOJ; Fri, 25 Sep 2026 10:40:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 443D760B65
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790332835;
	b=Rw3F/M34I9IRViFKabGOdhjkVauf3YVgum4JNpZ6tbOoeOi2p0lzIJhbll0XeMHgPEYO
	 FpODs2ld7IkLGwbtEGRbcbQAN11DjjRrAZL5dmB+earK+i8YifmI15TzCGYH4BMu+7NUx
	 zQ6fxaA3vpELEZohQUkkScxFP7/LbZWSDGRRBUDalFZg7OMAIRkrIsCVTTtQD8raup/fi
	 YoaGXAh7o/wSpNiGhcf1v9ra4LH1elOUI0VKro0QaWdB1fdhNBAXGXUgpVlCMxXT2VIXG
	 cwP/+AlpRsdti/2hgj2jIbKb7HEeaU+F0kVgi/C2qWSUIR8bzzP3ESKMneV5WBpWBcQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790332835;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:CC:
	 Subject:To:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
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
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=evEVxp83DCq7hHWueIpz1wG9JxLfBBpaPf2jJqSb93I=;
	b=WgQzSPN0pCZ6+/B6IMVHh+YKIJmOB7IvvijVBTqLZZ83YyAVVKo4lIx07YAnIJRA/dFe
	 wDNvDNn8ADAv3/4DUCy7+MDEFpy/OoqxmjHRfypJk9aRobtN0rIN7smRyJRISf2sqAUR8
	 yxdQPyYOVwzMBkWmzTSkZ62tROvHEYlroYdI6KX4s4k0LJd8mg4CZUtGa7sTEpDyfWpPH
	 Pe9oHJ0Tf0Zt/GM+9GQfsKol4flHWemneNTA4IJqp3NDes4AqRhYXGNplX5Abw5HbLK5P
	 Kh3v6jO8kat39ppcUShhyHTZRPc8EeaXxNas1K17E4JXEAA+Vr5KgbFZd1MsmWR6n6A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790332835;
	bh=evEVxp83DCq7hHWueIpz1wG9JxLfBBpaPf2jJqSb93I=;
	h=Date:CC:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QU8CiOM21nKH1jDuPGh/4a/+ZzAD2fQyofL+5ppGsWuCf3GoRnACVyQvwpGUlOA6k
	 ozYUSHfjIOfpMQ7VEHPtXrRL2ddPmOgZdpGc0j1eKK9JCvCPHx9lHDsHDHA+hlBPCv
	 VPvKX2jWHUhcTFWCS3rakXIwE+Ayvq2kzBpI+B/MYidciVjIIt3/a5fK1c/t+sKp1G
	 TiuUTfLd5VVtoY4E1s96zC8v/odPPrg9KwIRlOYfHFEGOQdNXk+PWYQVl1CSmyvNd3
	 2Db+txEpSJ+YpCuR3LOwAacxXsouna0dGwsuMzwjQsgZzU5buDCC8Pw4eKi2dZkySj
	 KjRmjralTfUfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 443D760B65;
	Fri, 25 Sep 2026 10:40:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F46B3D8
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 10:40:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 44AFC8128E
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 10:40:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gxRyLmErU_-J for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 10:40:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1F4D58128C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790332833;
 b=gEMTnxdbgBSf3uO2XCc2bh36nwcx2yjpoOc6mEvBNmjpoVhzQ1zSmYlsP6/mFH+FNGQC
 4XMJ3Pb/zbK4ZWYQKUzh/0ShXDRkqJCad5Tv8a4+NVwlB9DKEp0zHFZiSeZfwSefmbwHg
 y4UUvlvaGXIfNH7CpYGR2jk9Deops2YzMhgv+o79nleYIFc+N7xJXGEoUaKkrl+lBpfvR
 Z41/LvqzJuEuTPlK0bAZkiCZwiZu0GrupacnWAQCYbmiry8KUsPcq+/+FdEcp9bOdWcb+
 9cegTH9PFbnGm2GtlO2/FlDYrf0CSi/Osc/U1M4EzhGogBw5+OFUEo/3locn+ptSOGw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790332833;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:CC:Subject:To:References:Content-Language:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=evEVxp83DCq7hHWueIpz1wG9JxLfBBpaPf2jJqSb93I=;
 b=hkmrB18UvulXXFTh+1sjgKu0Nl6a0vGHlpuDjCE4pzMUbi3v6UUSVdn7hxu9Mofdyrtn
 puyusMy3rOShHeJe5ENQTL/BOg2dJ3fLossoNqmo1aU6G+8gvnEojb9Pk2GqnHC51P//O
 YBZ4khl9Io47onElKqwg5+sGfJ9KVHmgZY/FNJ+FZOwR0uYwY/wBJp8od2zyCtHPDNjBW
 nn/TJhD6x0FIo7eq8J6iGZUW6zocxdSd+U5iuaz8jcHhyK0Tum4RbDB7SQb4DopYeoS9E
 wwaTTBzEnp1V3HMyTQSemeF9SgjVLASgrI4yld+VEuJmp4R+A7zHxpAyDfCNEdWcJ3A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=D77mQzQ6; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=VJXKtPqW; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=s-vadapalli@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=D77mQzQ6; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=VJXKtPqW
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1F4D58128C
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 10:40:31 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68P5JG3W2451562;
 Fri, 25 Sep 2026 05:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=evEVxp83DCq7hHWueIpz1wG9JxLfBBpaPf2jJqSb9
 3I=; b=D77mQzQ65ZSOb7Xd163Z9HB+2Gr1bcQEbb0RUDPd+eQuoZQVUrVecv3JZ
 EIM0UVOJambkMv8XXX98Vjw4XQ+1RGSHINQGCHZnkMxgdzklOGjky3VLN3fodmew
 aytTmGBn17iv+LXV64EuS8smT8jpd0KEmizyI8vCW9TGI2g+LdozXNGUZIWFD/tn
 AMNIa7hl4DQDPC/1FvI80V0JLQXNheDlN7Xe+rZSxzvx4K1jdsZ6u6LiBY39JyHq
 0Cb/Gc8EKZFS3FdInmR6SgF3QLrH4E3XVqP5pnKVX4PFq4kkTKtutBpRSWRmXrow
 AY/R75N6kMPGbbEWztnYPiesueCCQ==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012065.outbound.protection.outlook.com
 [40.93.195.65])
 by m0384305.ppops.net (PPS) with ESMTPS id 4gwjq49f20-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 05:39:59 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pe8XUJBhjcYEFdNWEHDnrnFx9FpW+gtWAzCl3ECr1ldgajj2WnmAB/CJtJq2QTSXT+z77GwzjwQ04L0YSW6ltMcSgeXCRyTSrvxGMRetV2zyGROiNX2CHjqtQ1ChM0UhpSVuXYVPjCAjFeuM6Mf0qZvx953tJCbZzrpSeapvTGetZlBtr/JS+PLateCvaZh4AyHUG8E3Hy8zwqfk6uUhuXqIIBWFQzHsElrDMLnfNzGpC5WZDwEthFA5xEdGMttMUzpuf9K5nLxurGgQoSeLDG8R5T4wIR0xNulAdl4LWmvRUFJuIZGP9kl0Hs9EBdSFYC/ZR0lOGPLWAurJArbPXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evEVxp83DCq7hHWueIpz1wG9JxLfBBpaPf2jJqSb93I=;
 b=o5aCUgZFbTS8mVT4Ss79VLvZpvBQS6PWQOqoxJo9Fsng5xY4BGyaXIG1o+IvRXKgY7H/Xgm1DMJQGKRhPLLXSKgajn3EEfuetgBYOsqyzOQn/sBy0mS3vgB0yr1Xc6EmwOlU9/16WK5y6DsABy12QMVULNKbuQxvgVZtXvkm+9p/xvdvKxdpfKIMtbwwWPDZPyARruNUdwTdZ9QgypApOid1mQbdCO+jgJvau9IYC3h+NYUVh/m2J1JvwvyZO3kiomTx/OqSNVv7rVXW1K3Fg0dl81bR1g/NNWcfwNE8aCtOIJ5BARaXDxp4VOcyfgQkf2hgNEM7hYZgM+vzr8ajrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=amd.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evEVxp83DCq7hHWueIpz1wG9JxLfBBpaPf2jJqSb93I=;
 b=VJXKtPqWyAEpCTtPio/BB57URcqL+RIVvBPRurSq0W4kn3nZC1Ctf6Y/1XrMuVwWX15AJ6Hy7q1z02AW5YgmZ/0oLiiQ/zoxNiwl/UJ64mxl8bmnr2SkpQE+ApPrOLRF8pa1pRFq4shTM0kwbkJXSbwvvWdBUmtYlV1XyHqSaQ4=
Received: from BN9PR03CA0557.namprd03.prod.outlook.com (2603:10b6:408:138::22)
 by MN7PR10MB808797.namprd10.prod.outlook.com (2603:10b6:208:639::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Fri, 25 Sep
 2026 10:39:57 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::54) by BN9PR03CA0557.outlook.office365.com
 (2603:10b6:408:138::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Fri, 25
 Sep 2026 10:39:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 10:39:57 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 05:39:44 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 05:39:44 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 25 Sep 2026 05:39:44 -0500
Received: from [10.24.68.238] (uhda0492258.dhcp.ti.com [10.24.68.238])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68PAdd4k2608487;
 Fri, 25 Sep 2026 05:39:40 -0500
Message-ID: <4ca2f00c-9083-4d0e-be76-1465042849ae@ti.com>
Date: Fri, 25 Sep 2026 16:09:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: Anshul Dalal <anshuld@ti.com>, <u-boot@lists.u-boot-project.org>,
 <marek.vasut@mailbox.org>, <trini@konsulko.com>,
 <ilias.apalodimas@linaro.org>, <michal.simek@amd.com>, <lukma@denx.de>,
 <alchark@flipper.net>, <jerome.forissier@arm.com>,
 <dlechner@baylibre.com>, <sjg@chromium.org>,
 <Thinh.Nguyen@synopsys.com>, <mkorpershoek@kernel.org>,
 <love.kumar@amd.com>, <c-vankar@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v9 00/26] usb: dwc3: part 2, make the resynced code work
To: Anders Roxell <anders.roxell@linaro.org>
References: <20260916123826.517181-1-anders.roxell@linaro.org>
 <178964898806.1279633.17593305863869822172.b4-review@b4>
 <arZF61eAp54rQyrT@monster>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <arZF61eAp54rQyrT@monster>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|MN7PR10MB808797:EE_
X-MS-Office365-Filtering-Correlation-Id: 862b158a-1bb2-4f31-224b-08df1af157c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|7416014|23010399003|10067099003|56012099006|22082099003|4143699003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: 8AbE+qGVwSzKZfZPmV9Pf64ku0BgnRlePKMR+rq+oP3FUyIxPzL6qL6rZXTramZGYlhnQNYhn1BfWSKtzKbLtu78z2Q3X48FTWdHoqsRWjrboekDm/6LxCumurhpP1Dpjy326Pr6VaCR7PdQ6RSoitGrXsOZB8ih+AhxriigBGoKlCOrsOKuSVp8VJ7vfxBaCaq4JCKC8ZuqxRxRNh/P4D6YLfIRU5Sf7Vu8zDimKaX72jpcNt6jbnzG02n/OBhYKb1Ch8NT+SQwuhJfg0PkR0DrVTAFhl5+7ehnJplCI9N6D0/b8jnAbArOm5Gtz058E0y8GdgLx3xquzji9NaJuZ6iEnNdFSKS4s3bNb2SNrmIzMjYWIcyBhNmLc2o20QIpBUFJyWxX2s6NVREEn+HrZE9A1WVLyZOU7WLyh3rwP7BvbHXyq6vkmAMWtwFyaead/7rkEdqEdEc/uKFH2gUDGhv8NSlVlH2OBqwsVihCKGiiaLwCuZbmhgZjwv2XB6s3J5pFA1mDi7ijGhOB6h7oFDPr+5u8JBlJwnVz1z4b5DeYtlkpEa2539bU7mYWaO+fuPu8dP2Q7MTphRQM6FZ3TuQPYunrAzH9uIPWJpA636NVmw4S7AlCl4LpOF4h/gONbcIdaxrnMR1pJKhyF5lAQ==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(7416014)(23010399003)(10067099003)(56012099006)(22082099003)(4143699003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4+CvxCxqZN3xPExX0ib+KpQ0louyopIqBfGNDU4xmTi4GFXUfeHbOpx3sDmqDVBbzL0mOMNuT1pYLHJBKtwzgvt9hueUfKSrVy6b2pa0FfORLdASYwaR/KOD7XSkDwfkjSVgLHYcuYIGYC1orRqm995NEACKXTNgHlH13QjRmWTwVKQO3UC0URVoPiuuY3w0N3laROcXysIi9bHOVm4hNwP3RKbxWAT1fU6bl6LGR4hBPnpZIc0Yg8rHt8MxwtOgZkxBM7erOp/lNWNppvtPkHCi4z39e1MvlHsnzkAuq/izjkQQhpfZcFiNsmHuNYxQS+1Z++Y+mYDUfhUgFOi0SUUxTDnhJaMNlu9cYRvD6r6JPmr6P1wXrstXQv8kZYurs3P/TpGUkJ8xW/LpZQrA7K8hNj8ZMUfUyvJ+8hp192vodwDpEDOUrnhJdAfgT1CH
X-Exchange-RoutingPolicyChecked: y7BQtCSwVYyUq6HTNlQ5QwL4rgzvF3dfTFtnozGG037FvGV/Pf+80Ay1C8lwXKJpwS+NDEY8KsEFL3CU2m18ubyrtRirjAPNp9yVLYg0VteselrbJktNCC30xqvdvODwWcnZW89A9F9mfWPVccHQJo4ou9WnBSQAzdpZNjdqubhT8tXLJpUWWScrjZmvj4qT1fecInU2z/asEi3g4OWrUyzNOPR4LeVUkA4wAfMo37dT/sXsQFb3gB03cSRayhb2mndCmF4TEsS8oCpCbAmuCCVuuvFyjrqrLk8ScTvaaNu3OP6AuPvVwo2/RL5M7l+pI4AtTNgW6fnDDMPaZSCQZw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 10:39:57.0704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 862b158a-1bb2-4f31-224b-08df1af157c6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN7PR10MB808797
X-Authority-Analysis: v=2.4 cv=H+pOUOYi c=1 sm=1 tr=0 ts=6ab64f7f cx=c_pps
 a=oAmyFwY4cP9Ja8EDt9RnJg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=voM4FWlXAAAA:8
 a=sozttTNsAAAA:8 a=NEAV23lmAAAA:8 a=KKAkSRfTAAAA:8 a=H7G8cGjwIaRzgSUexx0A:9
 a=QEXdDO2ut3YA:10 a=IC2XNlieTeVoXbcui8wp:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: MC8PiIr64Dh2kovkIbVW8aqewkXw88GB
X-Proofpoint-ORIG-GUID: MC8PiIr64Dh2kovkIbVW8aqewkXw88GB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA0MiBTYWx0ZWRfX8n7YTDzOZ+r2
 m2THS3BPal3x6sP29LS5r0KiAnSHYTGD4HvB65NT+0sYlSOWnKUH1DcTpkN9RHqPtJDUuLr67pG
 wxQukLFmwLpxTlXaAW/RCLLCWUfOhPs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA0MiBTYWx0ZWRfX6/EPgFaXixQl
 4ns/zyNNDLosFJaHY+O/+OaEo2qIdIBlwXNff9/MvUjX91wYvDH1cp5lH9v0iua3soNS+E2RMlW
 Dflfxsw1yBD8a6qSU5CrBJjRwWshtf9DH6pOFfyqFhIBy+P5QKxTMGcXli3KA6ALPzVDxk6k1lf
 hG6OCJfTQwBVTvqtKRf1IKFR1Z15hFbBEhmL6D1egYXHDlG1zaXINIIcSXje6DuckdaYDgeLI56
 nP/+mz2bDP4XFrLiMig/hWzU1PAdqniw7GBbl1w+9VIpiEKf0EJSSCxEsMVqqJve+pxdKtzhCZ0
 NSnrMNYQkueaJvbUt/Sm6i0SlXUEKd3XE5xYP3FkXaMrl9CVfTqOO5lrgQKvzVKH1FJdWTH0Fcn
 9A0UCGW9wYQim1/7NR3kuiwj82Lfo+mjS2yXleFW8tSA8c/fmtQDVsLJgxcSZv12rusE/ZVGXG/
 vMPgq5oEH4ELpqRJwXA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250042
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

On 9/25/26 3:29 PM, Anders Roxell wrote:
> On 2026-09-17 18:13, Anshul Dalal wrote:
>> On Wed, 16 Sep 2026 14:38:00 +0200, Anders Roxell <anders.roxell@linaro.org> wrote:
>>> [...]
>>> ums. Love tested v7 on AMD/Xilinx boards. The rest is build tested only.
>>>
>>> One thing is still open. Anshul sees a single "unknown endpoint event 0"
>>> line on AM62p during enumeration. It is there with and without the cache
>>> patch, and the transfers work anyway. I do not see it on X15, and we do
>>> not know yet if it is older than this series.
>>
>> The transfers work regardless, if it helps the issue seems to be in the ep0.c
>> file.
>>
>> CC + Chintan, Siddharth
> 
> Hi Anshul,
> 
> Thanks. That is what I would expect. If the whole event word is 0 it
> decodes as endpoint 0 with event 0, and then it ends up in the default
> case in dwc3_ep0_interrupt(). So it does not tell us where the 0 comes
> from yet.
> 
> I think my two questions from the earlier mail [1] got lost:
> 
> 1. Do you see it on plain mainline, without my patches? If it is there
>     too then the resync did not cause it, and it can be fixed on its own.
>     If mainline is clean then I broke it, and then it has to be fixed in
>     this series.
> 
> 2. Can you print the raw word and send me what it says? If it is
>     00000000 we read an empty slot. If other bits are set it is a real
>     event, and we decode it wrong.
> 
>    --- a/drivers/usb/dwc3/gadget.c
>    +++ b/drivers/usb/dwc3/gadget.c
>    @@ static void dwc3_process_event_entry(struct dwc3 *dwc,
>     		const union dwc3_event *event)
>     {
>    +	printf("evt raw %08x\n", event->raw);
>    +
>     	if (!event->type.is_devspec)
> 
> Chintan, Siddharth, if one of you has an AM62p or a BeaglePlay, the
> answer to 1. is the one I need most.

When I had first enabled USB DFU Boot on AM62P, I had tested it and had 
included the logs as well.

Patch series is at:
https://patchwork.ozlabs.org/project/uboot/cover/20241217131658.2920799-1-s-vadapalli@ti.com/

Test Logs are at:
https://gist.github.com/Siddharth-Vadapalli-at-TI/50198ee3348c2db73e0dbd3a14cb0f8b

I didn't see "unknown endpoint event 0" at that point, so this series seems 
to introduce a regression.

Regards,
Siddharth.
