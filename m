Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16E2CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 21:08:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 84BD780A87;
	Mon, 28 Sep 2026 21:08:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F1xY4DHkIk2R; Mon, 28 Sep 2026 21:08:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B1FBF80A4A
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790629726;
	b=nMH+4U0zdn8vKT4gVdOs9/qCsZG1hYrvtn9T2TZVcxQeNjYHD/Q8cdjGVoed2+3tLfk0
	 P/UR6bGk4ejqmxm1WF8RaEanaQlOJqN7He+vRgR4VCABOflvrYGbStMRFXjibxPVIGmj1
	 U73yirYdGrqLf3HseNEHJmVpvEWs9WkhlNqvbODIbKeHQ6nODU/S9Z7MlfbG3iJFUAI32
	 EtgtKNv6MTw/Airkj/J3BFlcwsJqUEHYH/z6a3hgQ1fBFPO9YAaSNhAoCvJxP3g7VniGs
	 x0Zd5VuBSHw/V4ySe1w9mObR1/fNYhDgjy/7HGaib3nep2sKN5ySA9/EDxAC9sOUwJg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790629726;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zxU+M7YEGXwq3QhDNS4K6s4hEURhd7YP0z2irrmFVt8=;
	b=C+97MzHxoUQi2Pvt/vCdTrr16Nmxb+7IfVByBF96cKPl4h4xICZd7dQcloJawzcFEpRZ
	 aLk/h/PmzydFBKNH6XIfApNbLYeKb8fx48tbxmjV8bEL9Oueo11OEq6RXjzhv4Dko4cmC
	 a5GITggxEtAiMxM5vky01iQj8qaPb6ypqtuZ4RNlVv5sYtqFMwe1P8CYtRqL9glJZRJZX
	 9MBTpCzWjmA5j4xxjednhUuxvyffBRmBxczU+kvqwQF89MJruL4zU6uezp36z2u53ISBy
	 pOGhHO91QB8FdwSoYeCa+xSTPZlEtPZXaNxIg4lzptyR1klh7/TpjpS7AGTlwr3p9Qg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=PSXYkgP6;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=fFl9NUX1;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790629726;
	bh=zxU+M7YEGXwq3QhDNS4K6s4hEURhd7YP0z2irrmFVt8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XDmb2Gps20qREcSegqYhw4+Lb0mrQpevM3QnUKemt0JDr1JIK2zptdL3xiWKd7eES
	 Q4qNnN4ejcX+reU3WFtWEFaQb+NmuDkpePObyAR38v1n6ugTsQMA/mNeHdy2jmlLkl
	 iDnh9a9jQ7z962G1uSDOeXZ3ggV2Mx3itzR5ResNq21nm60aGsxdQXQi81UrNUDmHv
	 K2rQtqAO8KJhAjWGYp9Rahoy7Zqc28fJpSMXhyfSF5povF0gLCgCLhB/GyKPOAAq0d
	 JwmrCmE6mcPoeyIF+07/NkBdT4bWWjku5DkJ+AygPt/6+Rn1suLchFtSIioOM2+NiY
	 tqUhN1/9VE5DQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1FBF80A4A;
	Mon, 28 Sep 2026 21:08:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1328A72
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 21:08:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ECC4E80A4A
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 21:08:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 56Ffq_BIQnpE for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 21:08:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 44A64809F8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790629724;
 b=VDHjXOsiOfItjrLwKdRdhw/gaCfxgHUTxd9HBqg0LhahPbQDf8egX1OPOYamsnT2LWo+
 D8ZVw8VHVabGkPsIhHza8em4GZUChlAGUcEfObTyRRr57kgueVBgXSQLNu4f0WfBP3Wq+
 hM/xs4vAO8t5PLz7uOTy3Rq5GHCbd9ASbtWhQc/tLbsQCXyPu8reXJg8HSocu67dJcD6R
 /IxOyn7h50FhGZ7Ns9yGok5hD+aTXWnjYZNpx5f5wTTEEhFbaLovcggKKWFLDLt2ftcZY
 64O6wQDoDR3jqsP9Y0CoTbwEmYCJWdWJWgDS0SppcnCicTS5BZokiIkCYeBo+hiby7Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790629724;
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=zxU+M7YEGXwq3QhDNS4K6s4hEURhd7YP0z2irrmFVt8=;
 b=ShKwdDGI72R0U24+uahokopJG5xdJFvHynCei0nqFaZYFJmyS5EHuoVVfR1VpNN3MHA9
 tQPL5XFcG4OkedbmUZWbv96Zm8lmWFhMwdJnt9C2WDEDDNOml91lkT8bMyKjSkdyGJaXG
 gi8+Q56gSt8iP+F85Gk1zaYyO+nkC50RKbqBUfuAh3xX+LPAeJLL4pmKgwucnZeleIwRA
 5aWBwtSFwpFR6/xvNR9wqoB/7VfdfUc0+PbMkeRZR0C1CgETe/1gumH6N41pIcuXM6Fxf
 2HARMw0hVUVN/ubN1+1ojcPFd8WeXmBE5OWC/buElHwISeM4QH51zciDIzVLbbJajNQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=PSXYkgP6; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=fFl9NUX1; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=c-vankar@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=PSXYkgP6; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=fFl9NUX1
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 44A64809F8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 21:08:42 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SJq8Lw2844922; Mon, 28 Sep 2026 16:08:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=zxU+M7YEGXwq3QhDNS4K6s4hEURhd7YP0z2irrmFV
 t8=; b=PSXYkgP65j+dHKwrLrXsEt/eTOFYoU0LlL0s1iNqNJ1YPRg5q8QdgdTYQ
 ggVitide7CMIuDfKvQw8YsUcE0r7Nf7qUtuwiVTqIruujwHR3O5XlyZ6DY9jcgaP
 O2x6EPUNsXOnoVLjVr73dUUBPudAcMkG6QblUefP4YO1bvVXjlLjvbzoLvxln7dq
 silkO1W06j4ZvprJ+PM1BiAbVMVRHYQ+lO/G+dBqfBeHpqCT6TJG1J6VlvIZ9XnY
 I9P6xF7nRISfKZViZzffPQuRN7q/dS9bsJqg5AxIGZP45iQaXJPBM0by0Je+GgEa
 gq6m74ckaT/To1Pm9yagdI+evSxQg==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012052.outbound.protection.outlook.com [52.101.43.52])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gxwe5s1kd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 16:08:40 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Evtxvk/5yqfs8H0KHlcE6d9jjcsJazKbCFLZcZ9ZwU+et062+1Lc+1ctkvs5cruw1QgtYUTim9Qed571CvOoQz18wAceDYW59i7lj8X6GeQRvGLqHk+VQofJwPcD34D7TP6k7bb2My3HWiRmqkKn4peXJI9i09Mqz4bJ1SCF2lweLdJHjk7tEki7XDO/DgiFTDyJ+obFS1UhHhP0Eid3FRx66HfkgN+fCTg9+wxzDWnYsnXoyqG7BIQUpOOtuX7r7HGZ2/XODs5zme+3k2qrJmXtuKpPYWVBwfrogQS/iWsh6QvrowuFIzo1XwnFPOrQN94ym4etFGCMWwOjm3nUQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxU+M7YEGXwq3QhDNS4K6s4hEURhd7YP0z2irrmFVt8=;
 b=iyfSdj7m/ccA1CRXXFSA0Q2Cg1DRBHJYVCfPwAYDh/VrPHqTVa9V8N/MrsbKOvpTBWuAT5a3VaByWfph87hUf7HNMZFZlb7U9EfbTDxoWz53ZIZ5NGYrs1tGGYK8XNAKVsg2Vx6NWJcwb50C2RDAYHRaC/Q7ITJhNUv8q9z9zrjq6YVsGAW6cZM6jGpncfLw5YSuLoh/R9oUNwQS0dYjqchMRfy8IAywpDMX9l2Qjd0c9ukoS9eWEjHXrT06//9TQMGE75p9KFBS3zme803yk2XdSQXdvGCtOXMPeIE/YUu6IRL7kCtN+agxjcwj9jHIPRzxMF7iXljA9PrUOpZyYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxU+M7YEGXwq3QhDNS4K6s4hEURhd7YP0z2irrmFVt8=;
 b=fFl9NUX1/dxZn6OQSoJUallgEDakvTEwH6uamP29ak9fXf/ngzJTMWcqfVnZ821MikX8tQ8aNG4zog8BKii8SdrCbY2MIsMLTUl2riu16FoQY8zdIMTldNHPX5jRo4t1d+EiFr4TSn8AzQUV10sgc8RZ2BHy4nEq+eprGCElXwk=
Received: from PH0PR07CA0120.namprd07.prod.outlook.com (2603:10b6:510:4::35)
 by SA1PR10MB997676.namprd10.prod.outlook.com (2603:10b6:806:4b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Mon, 28 Sep
 2026 21:08:38 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:510:4:cafe::1d) by PH0PR07CA0120.outlook.office365.com
 (2603:10b6:510:4::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 21:08:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 21:08:37 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 28 Sep
 2026 16:08:17 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 28 Sep
 2026 16:08:16 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 28 Sep 2026 16:08:16 -0500
Received: from [10.249.131.193] ([10.249.131.193])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68SL8E3R595829;
 Mon, 28 Sep 2026 16:08:15 -0500
Message-ID: <d33017f2-889d-4a4f-a7a3-2882aa0834b4@ti.com>
Date: Tue, 29 Sep 2026 02:38:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Enable NET_RANDOM_ETHADDR config options for
To: Tom Rini <trini@konsulko.com>
CC: Vignesh Raghanvendra <vigneshr@ti.com>, <danishanwar@ti.com>,
 <u-boot@lists.u-boot-project.org>
References: <20260925110758.843871-1-c-vankar@ti.com>
 <27a0c3d5-0537-45fe-856a-5f685c2f68d3@ti.com>
 <8a2e1e6e-28af-420a-8bf0-954d9bb6f9e8@ti.com>
 <20260928143549.GK858934@bill-the-cat>
Content-Language: en-US
From: "Vankar, Chintan" <c-vankar@ti.com>
In-Reply-To: <20260928143549.GK858934@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|SA1PR10MB997676:EE_
X-MS-Office365-Filtering-Correlation-Id: 31cb3c48-d783-4f7c-148d-08df1da4aa61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: BHCbMZtQo3jItj194LSxqV9Wes4nsCc+iTtS4x+8gc4mHKuE5pwDorz8mrYjD0F/au6VoVxIReq+03Y+25LEyGisK7hwslEBeo8HTLc6a4erNswqjtfz8uNNsMbgzwsJB3Lw206chDYZ3+YLRiZDcQll6AHxVRjGd9h3Zi7rUNEP89ZCRmExZPrTQSmUDYk+DsSwFh4FfawTkEsa3FmQ8V4nxGutA6YSNVaMN0n1P8HExJF0a8bDpfCKV2cE+nxm34ywD8PzLYYHBYHg68/KZNM+mMMLTjfjChxUibYUPvCDJ6nnidBvl6pRmVsuvJQvrLMCixfDoEtFweGuty+jTTxIbO6W0NDJpGMDhNOKm21gW3L8KpWn6qwfl9GvieGzYX9AmyQzbhR+0U4PQ44RZkb+KDlQYb4abNl/5NfxG0ZCWoclaH1A9rTDX2brZ9xPozOJ0WRoG6KQ1W3FokgEgDCU8Xc2tpYdexXVWqECFR3f9kq2pjPOjqLiE+05cOnuQSB7u/9xMLyh+OsT+V+fmIuSslKF2pVbtVSuGwB4pgWrlgdQ2juueUXY0JgdHBvhT+0vzaEKBeuj+UYKxLHDSiprYNU6nWfPHbTRq1khe5OhnUyzhaK3w1H4ZMz7q/njhQbFGlgTruOqPpatsF+ycBkCEun4nxK8N+hr6/NHsDptzPyKT770n46s6IQ4/ZKGCasNBJIwBRwXGeTqetsexw==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OUrSSrEcywM3o53J+iUEtJ5kDI4EHcJvPwNGsB1pNedSDu7uYkhHddACiqDkvR2HSvJfRxROIELinnvwIRpAgI9Amt10DWOcrukwk+Yzc4ouWLh42+lR/QsAvWAP25Rs/f44Q1NVVeMoxJ3F+mre4jJjg+RrCGDkUlP37AQ7ZhjRqfShHmDimH8mtPCXiFf8ha4Kd2YG5chf5XiJYRXVHW9ZyDGJvU6LL5F3qyTcnOeDpXuNYPxi1beUcT64A3syRhEgP9bY+izm3MKGUfrAE1VsBuQlt97WoVJVZOMu/eNP9iei7/IuQru9hy0Aq+oPJkQImfBdmM6wjWFoz9XRM8Y81tO+bv3tG6+soRdhDkgvdmurnd41aRdgegDTSaDWfu/G2OklunjllB1HdBPMQ5X3chn/hpnOCAwrldx4Cofenje+SzKmnhQgkYeqKo6Z
X-Exchange-RoutingPolicyChecked: 2eTWL1rmAkE+rDExFmUNg6cVMG7m/HtBUrOaIa0jRztSfr293cI2OmG5UPV+1Ghi4VcFn+GvJBbDrO33pNO2arltFP2O8cnakeD+hpLghrsWVxU+qRurol/hHHFhrHbz5+wTdUrYEjSLJyB05Kz0zlyMJuiJtPciImxtECYzmQavevWlGy0kYKviP4J2clBkiqYSTiN7onWyEu8zkzhFkEHtQUTXIE3xWEZpA1GU/pT419R+njEZPW5QihGtggmEbFdeJx/ViVEAae8pdCY8ya7IPo+fMfZepLHzCLVrGJUrgfqTgRkovZYQoBQH2RPJh3xcw+k/JmdWarv5TKKUIA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 21:08:37.8864 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31cb3c48-d783-4f7c-148d-08df1da4aa61
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997676
X-Authority-Analysis: v=2.4 cv=aeP0Dhot c=1 sm=1 tr=0 ts=6abad758 cx=c_pps
 a=PlHkPQd8QExaI989BnvVeQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=kOD6aK_6Dnz4Krociy8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA4NCBTYWx0ZWRfX2x6UARW8baCt
 2hNt1GAVrCSVFTztCtLe/sE1GXJXQDlo1KPyopmasbtz8Y2Abt16wGR3k8nvViXgIRyXi6ITXN3
 c/41QEDt2joydzIUM5upBb9QqWmX5wYsgURM8jjexm0FwZAFdt/0VFVzy8F7v1DRhh5CW0mN4XK
 sVrKdyY+MQc+5D9ivFS30d54HmvhFe7FS0k+DLks7IOE/FMTVLElRirnj9pnR4YgnHT7qMv+75G
 dF8DyDNWCFNNOyH2CgwSMUBx/8fUJo3uGwYJwOyulwsNS8EUBaQkYOqCQlUsMFva5h8jJllxKdu
 9S3KUbXFvBvsDAXz73uHwsZ/VnKjirdjuN8fG1z6p/gQuBa0sZ11btv01sTH9UoOCLdu9gI0Nzn
 Mkb1wlKYrFiyxkNKLMBIXNAskWZomJjOTZ0umR5ukdkbkRc3KTGvbqMFhPqVDkP6OM8tqH2lkhZ
 bk5Dwd3FvscdzIvDoDQ==
X-Proofpoint-ORIG-GUID: -ogODdbxM3nM97hX1ZE6VIg_zb0Ik-IN
X-Proofpoint-GUID: -ogODdbxM3nM97hX1ZE6VIg_zb0Ik-IN
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA4NCBTYWx0ZWRfX2pTixw7U+aXW
 kq9QGS2QROKqh0ccR5idrvhnSTH0WdNgy7JHj03WcgQa9jr9cK5YXjHmeUJfjAwbMc/90tixVpT
 khuCFn9bjytG1u1z7RRRnd74jjR+v5I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280084
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

Hello Tom, Vignesh,

On 9/28/2026 8:05 PM, Tom Rini wrote:
> On Mon, Sep 28, 2026 at 04:13:06PM +0530, Chintan Vankar wrote:
>> Hello Vignesh,
>>
>> On 25/09/26 21:19, Vignesh Raghanvendra wrote:
>>>
>>>
>>> On 25/09/26 4:37 pm, Chintan Vankar wrote:
>>>> SK-AM64 supports Ethernet boot, to get the MAC address during R5 and A53
>>>> stage enable NET_RANDOM_ETHADDR config options.
>>>>
>>>> This series is based on commit '9e002445cd0d' of origin/next branch of
>>>> u-boot.
>>>>
>>>
>>> Why not use the actual address allocated for the device via
>>> CTRLMMR_MAC_IDx registers? I guess thats what ROM uses for downloading
>>> the initial bootloader?
>>>
>>
>> The way to configure CTRLMMR MAC in AM64 for later stages is by configuring
>> "ti,syscon-efuse" property in CPSW port. We are using CPSW
>> port 2 for Ethernet boot, and "ti,syscon-efuse" is configured for cpsw
>> port 1. I believe we can't configure it for two ports simultaneously.
> 
> There's not enough MACs on fuses for all of the ethernet ports on the
> hardware? That would be an odd functional regression on TI parts to
> me...
> 

I forgot a crucial detail here, the first MAC address for Ethernet is
being parsed from "efuse", and all other MAC addresses can be populated
via EEPROM. I didn't take that into consideration. I will rework on this
and send v2.

Regards,
Chintan.
