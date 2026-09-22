Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF31C982FF
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 08:46:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E18D40791;
	Tue, 22 Sep 2026 08:46:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WXW1cyerOj-v; Tue, 22 Sep 2026 08:46:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A602B40778
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790066806;
	b=ZT64OHoyt4yBIW5McDv9Ggl4f7BK6zXFV8DEgObbuXa0lv51o5fpLFQNKMX6m8Apgkvf
	 2C0uYDCVBkFlLw8dKoLYAL7EhGSebQHTIBS5seMrisgNUe823DHMON1YoXdq+FML1CeUK
	 S/Dy9j7ljRl36coOKVqyRvLfXfW6EieCx2o2wY1dZEfxp2B5KyMPEY0t3NrJX7A7ZQvbl
	 0PRwoP3zD73V2LazQ4J4KHE24wu8C1tWxlDsHSeN8XeSNUAJHscfbIw5DYTXJ7dvqs/KT
	 LiZ1EvPjSaKIwu1BskAFvdtGOAFVZ9UfkGIGMgFf2vtPoTjd4TB0ubJksFT3NvYT//A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790066806;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
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
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PVIynApzWeSJMZ6xF2tQP83+R+aQGwUR/RPBOGiCqBM=;
	b=igGkIPiqhxJ6feZSjqI4DqKyJD3wqUQLdtKfEBYvhE5RReFz6vD+PoG0Bvt+v3Pmst6r
	 HDGl4b9kKWVOLKHeJB21h8BeqjPZP6SYEYwxsqvl/Qu68N/0h1YXqcu4hw7RniSN+pUyf
	 buGCCIr7tkuYbhOGGzI5f6YQy0mK8dCJlmTM6ZclclVc3urdTHfwJSKCcRQQvCANr+uFg
	 QXxSv/0mBOJmAIQ5ywkYeoqe42agJXvH3ujj+uS4i5Hkle+vG0LXlQ3mSJYuFbSoaH+nW
	 PQYdh2t6ESVdKr0cU25ylIBEXaWKX1vG5y/ERVn/hB8GGTC+PJMVtjYVgfds8A+jKqA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790066806;
	bh=PVIynApzWeSJMZ6xF2tQP83+R+aQGwUR/RPBOGiCqBM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CPGXOxcdQV7Fya8YOHJz1PShcXEmreZnsGyVeejaJvob8vQsJtMECPigS4jkfw1nj
	 sRbD7Rw/jsfXs1q36Ffz8PFkBEkLSH7Akz2E4mA6T2Yuns4eJNKEMKYjWMzvvXk7dH
	 LXsEoR2p8n9C09zQQk65po0rUrn07x99e7yTO4KMO9Uj57zEqXh1VmYlpoNBrzvwmT
	 fCrY9pH80GkTbi7qI8NFibzdWgMEP2Mp1i0RDzJ9uwJlktk+fQw9mV3mMErBgDBA3q
	 YaNaFYdtbR/7n8hFJFYANQKiCm+N+Kiv/NNImQMN8lJ2Ioq0eXa0ZzgsW+v7bw/uNK
	 un6hC/HeQnQ4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A602B40778;
	Tue, 22 Sep 2026 08:46:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DAAF0194
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 08:46:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C0B85606CF
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 08:46:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ArZLnKBM-Cqb for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 08:46:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7832360657
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790066803;
 b=VwmQSJkVKbTn5WQrgmWSj/bl6Dfg0kXkA8B5fA9MdrA0ZFuLz4uDaPAjIK4qX8Ce+jxQ
 E4IG/2QpPKGjEsiNA2etEEFdmfsr8eZsoIdD0Jh5V36PHv/daCs24NrTqu0rz/cJtsXh8
 A466rVXTJV5xyNSGJ6nR9ZEs0V26TgGIbmuDCs1EY4wNl7or0xgAukMaII1cVjAR9O1nw
 fobv2/7dOmFahUWCc3snm48nPza7fOd4RraTahlKXtrHXItjENnv1lLfg5Jfnn0CUr8Rw
 HkY6oEGPpRWEOijJK3BPVRvfuP8e5kGhmb6PklpIM0Yo/UQUed0OK4N823zfR9nPDPA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790066803;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
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
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=PVIynApzWeSJMZ6xF2tQP83+R+aQGwUR/RPBOGiCqBM=;
 b=bC8BUntob6sxje7Y0bQU8JR+jZ9R0vmy8Ygxr5cB7FvPGCshCxTHWaHvM7NhLX3e73aw
 Bwe3GlAOMkCpAeTtBASuUuoSTrTHvrCQxMt1ahB0TBQIPMs5mdldF4VcYi5uzPs31Zfp0
 WbKCHKsNKYSJQBNQ0obx9go573a4Zte5aSn3rUM2ld52lfTWDNJVjSk/3weGDrnK9MPjV
 rVo9mcoYC6QLFKKO9pZHDoUUuUDhq+6kYF1hgmZ251nOaeGYhhiYkLJFl6iOenGRPks5N
 w2a/srk/t09V8PMd+4DxYxw2yfy5E4DRdl+iXOm4iNXvcx/qF6kwpFkyQfz/aYvXLJQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=cbOIKQuf; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b="m/+q3DUK"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=b-padhi@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=cbOIKQuf; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=m/+q3DUK
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7832360657
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 08:46:43 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68M8irPs3143633;
 Tue, 22 Sep 2026 03:46:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=PVIynApzWeSJMZ6xF2tQP83+R+aQGwUR/RPBOGiCq
 BM=; b=cbOIKQufPkCU1V598K86ozMTUYVLdmM6GyCNaWSBsESxLOA9DVhbmHur/
 KR97HAxrRR8beErP313LtNs3cB4uXE4oOVmsMWjrO7Miwgft38X1l31FPOtJVz6h
 KnvxadDV6vAuxJjUtf6QcGPP5uVe+nlY8p3+9Nb06nxk3u7H52rorFvOtuQcmEee
 /ELFTrcZPes4Pkhj/alKIub1lIz0XNZ+brfPxyE7zqwjoEXjF9LLzOC96OYqL3Tv
 GnsCSDsk4SIDGeT/SL4VWBKmvSy3I9vSCorj2IDs/XZpbc4t3t84uXG+2b28x9s6
 W+RzMDyyb4I9t5pNTC7d0xaRNGszA==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010071.outbound.protection.outlook.com
 [40.93.198.71])
 by m0384305.ppops.net (PPS) with ESMTPS id 4gupea00a7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 03:46:40 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGYRY57YBYyMVADcPEFI2yMhaOidQ7eBY1dM1ZHKsG9BrNdexIoNVeTFzi0f8kLRx9jYGNopSkkAgMYbcRH/RZ0Dbk+IrJdvAhVgVP5ymjTOXYRDT6XD8gvLxh4Q9XdRQQxZvOl2UVlpYC51OQFkFrI1VKQ0NYYqkQh3oBuZeKnP5a0pzJ4fjTHnaPaFZJjAspEcnFShYAHNJu+cOEZdIIA1BpuQLj0ycnnPY1j9H1BWsQjnfU/9jc+Ch0zyXVHMoDo3yH/SDq/Qcfwti8SsmbVu3jKiOVpvuszNX+7GMkckjcA2IEjtJOSOQg12LMBnW7ioxEo2w9snJwuPK+S+CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVIynApzWeSJMZ6xF2tQP83+R+aQGwUR/RPBOGiCqBM=;
 b=GIQLkZnXmrNGjDHoJFW6u6W40FPhkdtmYIGiqm0V8MVkFjcJqCBSQBfozmJH5XPVKlizmkKGxGO1Z5LzrSJKDYKpqCZ0v0geogEWxRu+ZnKfmJ1QubfpZ8JGLAXWIiUEzCkBhdk8MrDAcgapTZTsNM7NfwOuS0d59Zc8MWs2fdq6DixUTo4UC8WsmdXZKboGYUFuZ6ApkF4o6advzjfm3seLAyh3RUNLSf2yPeV3f3Es2JGFMEg9vq8y1ulljsdz2r6ek1cmTUcKxVYqrFyFujirmgm6yfCdRtDLNmxRjzB3A24b5ZK3H2pz2Hexf/HgMtXvS53NnZc/xtrPyDfLVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVIynApzWeSJMZ6xF2tQP83+R+aQGwUR/RPBOGiCqBM=;
 b=m/+q3DUKiFioHcNZK2H24+5C2ymP9Hy9qguBxBNSy5Xw+0GSOTMLuL5gzXUDcmLuIDPdusoKYJncdC2X+fPL5/8oy2JwH+ZdJdw85hDGjyIPYg2LiJ7/+xnTRU60oG2E8VKBIdKHByvjOiOQPo9puY3x/W2FEWIjN2B+9M0U6Ak=
Received: from BN9PR03CA0858.namprd03.prod.outlook.com (2603:10b6:408:13d::23)
 by PH7PR10MB7035.namprd10.prod.outlook.com (2603:10b6:510:275::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 08:46:36 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:408:13d:cafe::9) by BN9PR03CA0858.outlook.office365.com
 (2603:10b6:408:13d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Tue,
 22 Sep 2026 08:46:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 08:46:35 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 22 Sep
 2026 03:45:59 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 22 Sep
 2026 03:45:59 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 22 Sep 2026 03:45:59 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 68M8jaFO3813357; Tue, 22 Sep 2026 03:45:56 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.u-boot-project.org>
Subject: [PATCH v7 5/7] remoteproc: k3-hsm: Introduce a remoteproc driver for
 K3 HSM core
Date: Tue, 22 Sep 2026 14:15:34 +0530
Message-ID: <20260922084536.2477291-6-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922084536.2477291-1-b-padhi@ti.com>
References: <20260922084536.2477291-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|PH7PR10MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d3d609-a567-4960-f163-08df1886024b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|13003099007|3023799007|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: XjRabFeEv+zXD3vFyKe20tf5FEw9SGG8F43EuNKC4kYc5JnrXEODJZvkbRbrVTNVZolwvGrsO8codWCI5h03Pb5nH6dAo4sE73ND5pi6VbaD0qyCVjjL4g2ThPCSDPhYk1d5gr0t0xe8qb0WRceqZu07Hfkwfu0kb9s5a1jR9wDJPT6w0ZafLaDJrNlFb72BTDzrRSKbbg8yBDPlZNyrUYfY4Xxv9BU0ajN7WhGBj9pNi5kjdMITiSsus1YltygANE0d3dQ6CjTTZdBWPjmgzGd/Bo+d8E0IOB/skNOJe3NMkv2NHjP2Ji74O0ia6lp6Z1nbYmdRjHOXa2W+eWpwpa3YAdOUhUkiG12QWGTxykDndoydjRVumHq3tFIxVhZsBXtOFAXI0Ojj/1zvLK5LpRNQitnMZ/OrhkeE4PPQAmGs0qTc+8UmF+o5uCOpkLK5EtGO+db2JNfHSg9trMO0azQOuOQV2JLrdmAIEKGfNXmtr2gVdFo2d6jK30ErLKy5nvxIvuhvfHxgGoU/4SGzrdyVWhlTbyaH15SlpXYa5yuvYc2qXjL19kKr1QgVKxhTFW4wlKtV2y00UtjPZCRjAuY+IaNtvVtljGa7DVn6JbENj2A48P2r+ZoP9E0Kl0iFH9iCRv4G/IeIwLMN5QpSVA==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(13003099007)(3023799007)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WbI/51roS1/WK0jaOGJvg/BrkwR5ZXx6uYDIZLs7dmSKCvAonohuUJiB1avhFtKeNQ4304GjEz1F91uFHCC1dcWXARJbf9iONTJNQNfyF1N2D0uNDQN5BPgbRy/vRk9FpUrW5DxsY/7nnwEd2Cyx3nlvMItI1zm/QD9EfLRy2Q2cECE0560BnsJBSszEEI4wjpeLCVRlZ4umfnwOuafK9Kb+2e1HXbZeXtl3KuVCJPAI3+OINkNxfxFdKM6oqGaiSPl2zKLkR/gmnCrpY6LtOr1a4XFP9wfqWcnoDoPDI83PfGFqNgtMgwGSujiiNJQ/1gn2wQVsySh0ViZ8EG+ey5WaRR/wcx1VVFS58+0WECNaL1QXdM/uJNTsH0lOthwXSYQk+Qr+MHVZpVRCbt9+llIo14sggMAp9pkwYX9yFBEvH7S1bjk/j5DUI5nbgpba
X-Exchange-RoutingPolicyChecked: o2e6lSqyYF9OIku0k3jj2gN6qNEHPUB9WqnOAS1bAXshs54HZt6DsE0p0s/YXU0hz4ndSGhbbKg/p7BlX6G7Lc3pXrl/OvQRApHrBjzzU4FsnTXss5eYteFZcxeoQAgJaWMn/Mz7wMxC2RATS9qsbPGMCmllsCVUwgHbYN9QEELWkLnva1yZ1adxbM61hmDYn3ov4ZZDR4EFo5gvR+eF0W9OMbzFTMjfv+tVrbtX3pYc8VWae3Npjlgt2U5308dKDagq5qu6c1FRdhhXPD0GRZ7xhxDV8X4i+MtR0JuIdiWkxC3av36KzQtU43bvrn+g1gWVm5aLwJ+87jpZfIW00A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 08:46:35.1839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d3d609-a567-4960-f163-08df1886024b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7035
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDEyNCBTYWx0ZWRfX7WZqzDNYWvXj
 ZWP25KM0sz0kKW7FtelsptYJMgVvKzf1OsoJ5zIAbvEbSR/n5q0C0/sApHbmTt3dFye3xbbozd6
 y37ZeAsf6OyWw//5iHM7CtnMZsxmznC3qS22MiK5Kt70NNL05y/K1nM427OMnJi8VyUl5QBEbxJ
 ARE3a7NaKqjHiKC6BzJBI1D84kpt299ZOQGfZIzDMJj8AkB8Q77JrCYo38XizkBN93FYh7YJ8Al
 AsrXgbvJDD09mKfalzrnYETn4TbWHJ/kwwZBkHTbYIhaLMVHBij4mS12FYjTOlAH4fIRHCJOf52
 7rhuR6RG5GesVJW6xMCj9Gr6fbPRGrcW4OPH5msR2SM5mP+XGYlDvGhzMeLhwEPEbDz0Ab5vJc3
 ysYwAlbScloNJOtkZsj+K7s2vyjQwwJyGTJbvc/V7sKF7q7VztmIxVVFw0uDQlymmnbG+1lWN1X
 15JkLcu3oKTghr3XN0A==
X-Proofpoint-ORIG-GUID: 9sxAySup9yYZeSVsRi_TqNHpkx_SIpGt
X-Proofpoint-GUID: 9sxAySup9yYZeSVsRi_TqNHpkx_SIpGt
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDEyNCBTYWx0ZWRfX4zBaEpsXRBmm
 vs+0b5/if98j/ThqmtSAQo1bTaMCw7Jwety/0FOd5t6Idfhb11ylOe52oEVzJxXK/HBSqP6WdKe
 bDlMnzOk8lEri52iYChKFZEEPmfDNMU=
X-Authority-Analysis: v=2.4 cv=Mdz5KJ/f c=1 sm=1 tr=0 ts=6ab24070 cx=c_pps
 a=4uekZJdLSFpbpqOwIdQ1dA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=voM4FWlXAAAA:8 a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8
 a=7Uu7czuuXSSy5kTXNsoA:9 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609220124
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

Some K3 SoCs like J721S2, J784S4, J722S, AM62X and AM62PX have a HSM
(High Security Module) M4F core in the Wakeup Voltage Domain which could
be used to run secure services like Authentication. Boot flow for HSM M4
core is different than the general purpose M4F cores, and is as below:

1. Request control of HSM M4F remote processor.
2. Assert Reset on the HSM M4F remote processor.
3. For HS devices, Request Secure Entity to Authenticate and Load HSM
   firmware into core's internal SRAM memory region. For GP devices,
   load the unsigned firmware manually.
4. Deassert Reset on the HSM M4F remote processor.
5. Release control of HSM M4F remote processor.

Add a new remoteproc driver to support this boot flow for HSM M4F core.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
---
v7: Changelog:
1. Carried R/B tag from Udit.

Link to v6:
https://patchwork.ozlabs.org/project/uboot/patch/20260831083347.1168880-6-b-padhi@ti.com/

v6: Changelog:
1. Add a call to ti_secure_image_check_binary() to strip off the
   certificate for GP firmware. (needed after rebasing to main)

Link to v5:
https://lore.kernel.org/all/20260720080114.775206-7-b-padhi@ti.com/

v5: Changelog:
1. Use get_device_type() to detect device type (GP, HS-FS, HS-SE).
2. Avoid typecasting at certain places.
3. Check buffer size before doing memcpy() for overruns.
4. Add R/B tag.

Link to v4:
https://lore.kernel.org/all/20260425033742.1519298-11-b-padhi@ti.com/

v4: Changelog:
1. None

Link to v3:
https://lore.kernel.org/all/20251231173621.1069988-10-b-padhi@ti.com/

v3: Changelog:
1. New patch. Add a dedicated remoteproc driver to boot HSM core.

 MAINTAINERS                          |   1 +
 drivers/remoteproc/Kconfig           |  10 +
 drivers/remoteproc/Makefile          |   1 +
 drivers/remoteproc/ti_k3_hsm_rproc.c | 268 +++++++++++++++++++++++++++
 4 files changed, 280 insertions(+)
 create mode 100644 drivers/remoteproc/ti_k3_hsm_rproc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index eb4209bdea6..ee28d9f3418 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -755,6 +755,7 @@ F:	drivers/phy/ti-pipe3-phy.c
 F:	drivers/ram/k3*
 F:	drivers/ram/k3*/
 F:	drivers/remoteproc/ipu_rproc.c
+F:	drivers/remoteproc/ti_k3_hsm_rproc.c
 F:	drivers/remoteproc/k3_system_controller.c
 F:	drivers/remoteproc/pruc_rpoc.c
 F:	drivers/remoteproc/ti*
diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 7f9e35283f9..f1e586584f3 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -108,6 +108,16 @@ config REMOTEPROC_TI_K3_M4F
 	  on various TI K3 family of SoCs through the remote processor
 	  framework.
 
+config REMOTEPROC_TI_K3_HSM_M4F
+	bool "TI K3 HSM M4F remoteproc support"
+	select REMOTEPROC
+	depends on ARCH_K3
+	depends on TI_SCI_PROTOCOL
+	help
+	  Say y here to support TI's HSM M4F remote processor subsystems
+	  on various TI K3 family of SoCs through the remote processor
+	  framework.
+
 config REMOTEPROC_TI_K3_R5F
 	bool "TI K3 R5F remoteproc support"
 	select REMOTEPROC
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index 250915d0de4..5f2127fcb05 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_REMOTEPROC_STM32_COPRO) += stm32_copro.o
 obj-$(CONFIG_REMOTEPROC_TI_K3_ARM64) += ti_k3_arm64_rproc.o
 obj-$(CONFIG_REMOTEPROC_TI_K3_DSP) += ti_k3_dsp_rproc.o
 obj-$(CONFIG_REMOTEPROC_TI_K3_M4F) += ti_k3_m4_rproc.o
+obj-$(CONFIG_REMOTEPROC_TI_K3_HSM_M4F) += ti_k3_hsm_rproc.o
 obj-$(CONFIG_REMOTEPROC_TI_K3_R5F) += ti_k3_r5f_rproc.o
 obj-$(CONFIG_REMOTEPROC_TI_POWER) += ti_power_proc.o
 obj-$(CONFIG_REMOTEPROC_TI_PRU) += pru_rproc.o
diff --git a/drivers/remoteproc/ti_k3_hsm_rproc.c b/drivers/remoteproc/ti_k3_hsm_rproc.c
new file mode 100644
index 00000000000..70240ab4aaf
--- /dev/null
+++ b/drivers/remoteproc/ti_k3_hsm_rproc.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Texas Instruments' K3 HSM M4 Remoteproc driver
+ *
+ * Copyright (C) 2026 Texas Instruments Incorporated - http://www.ti.com/
+ *	Beleswar Padhi <b-padhi@ti.com>
+ */
+
+#include <cpu_func.h>
+#include <dm.h>
+#include <log.h>
+#include <malloc.h>
+#include <remoteproc.h>
+#include <errno.h>
+#include <asm/io.h>
+#include <dm/device_compat.h>
+#include <linux/err.h>
+#include <linux/sizes.h>
+#include <linux/soc/ti/ti_sci_protocol.h>
+#include "ti_sci_proc.h"
+#include <mach/security.h>
+#include "../../arch/arm/mach-k3/common.h"
+
+#define PROC_BOOT_CTRL_RESET_FLAG_HSM_M4 0x00000001
+
+/**
+ * struct k3_hsm_mem - internal memory structure
+ * @cpu_addr: MPU virtual address of the memory region
+ * @bus_addr: Bus address used to access the memory region
+ * @dev_addr: Device address from remoteproc view
+ * @size: Size of the memory region
+ */
+struct k3_hsm_mem {
+	void __iomem *cpu_addr;
+	phys_addr_t bus_addr;
+	phys_addr_t dev_addr;
+	size_t size;
+};
+
+/**
+ * struct k3_hsm_mem_data - memory definitions for hsm remote core
+ * @name: name for this memory entry
+ * @dev_addr: device address for the memory entry
+ */
+struct k3_hsm_mem_data {
+	const char *name;
+	const u32 dev_addr;
+};
+
+/**
+ * struct k3_hsm_privdata - Structure representing Remote processor data.
+ * @tsp:		Pointer to TISCI proc control handle
+ * @mem:		Array of available memories
+ * @num_mems:		Number of available memories
+ * @total_sram_size:	Total size of available memories
+ */
+struct k3_hsm_privdata {
+	struct ti_sci_proc tsp;
+	struct k3_hsm_mem *mem;
+	int num_mems;
+	size_t total_sram_size;
+};
+
+/**
+ * k3_hsm_load() - Load up the Remote processor image
+ * @dev:	rproc device pointer
+ * @addr:	Address at which image is available
+ * @size:	size of the image
+ *
+ * Return: 0 if all goes good, else appropriate error message.
+ */
+static int k3_hsm_load(struct udevice *dev, ulong addr, ulong size)
+{
+	struct k3_hsm_privdata *hsm = dev_get_priv(dev);
+	void *image_addr = (void *)addr;
+	size_t image_size = size;
+	int ret;
+
+	ret = ti_sci_proc_request(&hsm->tsp);
+	if (ret)
+		return ret;
+
+	ret = ti_sci_proc_set_control(&hsm->tsp,
+				      PROC_BOOT_CTRL_RESET_FLAG_HSM_M4, 0);
+	if (ret)
+		goto proc_release;
+
+	ti_secure_image_check_binary(&image_addr, &image_size);
+	ti_secure_image_post_process(&image_addr, &image_size);
+
+	if (get_device_type() == K3_DEVICE_TYPE_GP) {
+		/* Ensure firmware fits within total HSM SRAM bounds */
+		if (size > hsm->total_sram_size) {
+			dev_err(dev, "Firmware size (%lu) exceeds total SRAM size (%zu)\n",
+				size, hsm->total_sram_size);
+			ret = -EINVAL;
+			goto proc_release;
+		}
+
+		debug("Loading HSM GP binary into SRAM0_0\n");
+		memcpy((void *)hsm->mem[0].cpu_addr, image_addr, size);
+		flush_dcache_range((unsigned long)hsm->mem[0].cpu_addr,
+				   (unsigned long)(hsm->mem[0].cpu_addr + size));
+	}
+
+proc_release:
+	ti_sci_proc_release(&hsm->tsp);
+	return ret;
+}
+
+/**
+ * k3_hsm_start() - Start the remote processor
+ * @dev:	rproc device pointer
+ *
+ * Return: 0 if all went ok, else return appropriate error
+ */
+static int k3_hsm_start(struct udevice *dev)
+{
+	struct k3_hsm_privdata *hsm = dev_get_priv(dev);
+	int ret;
+
+	ret = ti_sci_proc_request(&hsm->tsp);
+	if (ret)
+		return ret;
+
+	ret = ti_sci_proc_set_control(&hsm->tsp, 0,
+				      PROC_BOOT_CTRL_RESET_FLAG_HSM_M4);
+
+	ti_sci_proc_release(&hsm->tsp);
+
+	return ret;
+}
+
+static int k3_hsm_stop(struct udevice *dev)
+{
+	struct k3_hsm_privdata *hsm = dev_get_priv(dev);
+	int ret;
+
+	ret = ti_sci_proc_request(&hsm->tsp);
+	if (ret)
+		return ret;
+
+	ret = ti_sci_proc_set_control(&hsm->tsp,
+				      PROC_BOOT_CTRL_RESET_FLAG_HSM_M4, 0);
+
+	ti_sci_proc_release(&hsm->tsp);
+
+	return ret;
+}
+
+static const struct dm_rproc_ops k3_hsm_ops = {
+	.load = k3_hsm_load,
+	.start = k3_hsm_start,
+	.stop = k3_hsm_stop,
+};
+
+static int ti_sci_proc_of_to_priv(struct udevice *dev, struct ti_sci_proc *tsp)
+{
+	u32 ids[2];
+	int ret;
+
+	tsp->sci = ti_sci_get_by_phandle(dev, "ti,sci");
+	if (IS_ERR(tsp->sci)) {
+		dev_err(dev, "ti_sci get failed: %ld\n", PTR_ERR(tsp->sci));
+		return PTR_ERR(tsp->sci);
+	}
+
+	ret = dev_read_u32_array(dev, "ti,sci-proc-ids", ids, 2);
+	if (ret) {
+		dev_err(dev, "Proc IDs not populated %d\n", ret);
+		return ret;
+	}
+
+	tsp->ops = &tsp->sci->ops.proc_ops;
+	tsp->proc_id = ids[0];
+	tsp->host_id = ids[1];
+	tsp->dev_id = dev_read_u32_default(dev, "ti,sci-dev-id",
+					   TI_SCI_RESOURCE_NULL);
+	if (tsp->dev_id == TI_SCI_RESOURCE_NULL) {
+		dev_err(dev, "Device ID not populated\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static const struct k3_hsm_mem_data hsm_mems[] = {
+	{ .name = "sram0_0", .dev_addr = 0x0 },
+	{ .name = "sram0_1", .dev_addr = 0x20000 },
+	{ .name = "sram1",   .dev_addr = 0x30000 },
+};
+
+static int k3_hsm_of_get_memories(struct udevice *dev)
+{
+	struct k3_hsm_privdata *hsm = dev_get_priv(dev);
+	int i;
+
+	hsm->num_mems = ARRAY_SIZE(hsm_mems);
+	hsm->mem = calloc(hsm->num_mems, sizeof(*hsm->mem));
+	if (!hsm->mem)
+		return -ENOMEM;
+
+	for (i = 0; i < hsm->num_mems; i++) {
+		hsm->mem[i].bus_addr = dev_read_addr_size_name(dev,
+							       hsm_mems[i].name,
+							       (fdt_addr_t *)&hsm->mem[i].size);
+		if (hsm->mem[i].bus_addr == FDT_ADDR_T_NONE) {
+			dev_err(dev, "%s bus address not found\n",
+				hsm_mems[i].name);
+			return -EINVAL;
+		}
+		hsm->mem[i].cpu_addr = map_physmem(hsm->mem[i].bus_addr,
+						   hsm->mem[i].size,
+						   MAP_NOCACHE);
+		hsm->mem[i].dev_addr = hsm_mems[i].dev_addr;
+		hsm->total_sram_size += hsm->mem[i].size;
+	}
+
+	return 0;
+}
+
+/**
+ * k3_hsm_probe() - Basic probe
+ * @dev:	corresponding k3 remote processor device
+ *
+ * Return: 0 if all goes good, else appropriate error message.
+ */
+static int k3_hsm_probe(struct udevice *dev)
+{
+	struct k3_hsm_privdata *hsm;
+	int ret;
+
+	hsm = dev_get_priv(dev);
+
+	ret = ti_sci_proc_of_to_priv(dev, &hsm->tsp);
+	if (ret)
+		return ret;
+
+	ret = k3_hsm_of_get_memories(dev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int k3_hsm_remove(struct udevice *dev)
+{
+	struct k3_hsm_privdata *hsm = dev_get_priv(dev);
+
+	free(hsm->mem);
+
+	return 0;
+}
+
+static const struct udevice_id k3_hsm_ids[] = {
+	{ .compatible = "ti,hsm-m4fss" },
+	{}
+};
+
+U_BOOT_DRIVER(k3_hsm) = {
+	.name = "k3_hsm",
+	.of_match = k3_hsm_ids,
+	.id = UCLASS_REMOTEPROC,
+	.ops = &k3_hsm_ops,
+	.probe = k3_hsm_probe,
+	.remove = k3_hsm_remove,
+	.priv_auto = sizeof(struct k3_hsm_privdata),
+};
-- 
2.34.1

