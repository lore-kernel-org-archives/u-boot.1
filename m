Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3223DC982F1
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 08:47:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0640D80DD3;
	Tue, 22 Sep 2026 08:47:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YMxTsl2gOY8z; Tue, 22 Sep 2026 08:47:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E207F80E21
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790066820;
	b=hEPOLiJvSKGA3H6nuQfANgpG8LtT/N0VTEgN3i7lK2ktYjJk/eMDjKxvBFeNR7aYIsyC
	 Kk60gO7w2sIgA567m0x1/JX8vaClicvHGcfF6joPj5TYvB9bONnmXNP0G5lW6QvrXGqjT
	 PacYz0mb+N3Jv3N8DLR3HDPhxqPX4f8Y90GcvyohHOvLEYJi6njVO994zDmHBfEOvo6U+
	 DIVcXIFQp0Xvd69GEsO9XKmxtdiTdCgFvGbyB8CCDHpkXMlvkUTn1mKotLfgsgds9ZGpd
	 MfUJufyDZ7pTGX5guvy4CSl5ywscvXSYG5xBkjGAfY2zBCNr4z930xC4RRoPXN73/Yg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790066820;
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
	bh=D/np2C/wRwRcSHnVqrDo56VCwyGMzdY+2Om8JaFJRiE=;
	b=EGviZxH5/chXRw+tVm/m3ITRikKm52f5vE3z7vk+Sj4F7+aOqBM8tqXU5bbOoSQ+Da6b
	 7VajqxPtYHi19odS/hsWTjsTqSvuHaHrjKhk6JD1KwSxQU3IQD2gIdy0dkNdPEFlgJ+GT
	 5R+2fuHuBa+Y0ioFGqZS9IsDh+B5Qp1SHfCfhx7dLhMX+hGryqqngj+EX0k5lSpyWKC7p
	 3DfT5WXnaJUUz+fekWSVc9NswqKtp1A+6VwELtR2VZe6SUQVCPFBCuB5TDN0i+sKjLsxp
	 0qx1CxoUH/Tp1NQzhiVQtxhpAif3/bUB4+1xzCiDhMBLu9SRaHD7v4KOim2TSF+L9LA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=mSPEldLp;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=selector1 header.b="KCa1ya1/";
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790066820;
	bh=D/np2C/wRwRcSHnVqrDo56VCwyGMzdY+2Om8JaFJRiE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mb+X9oj6aCRLYdVzV4HhQeVm5YLRq0DR/f4+cEhJJjhhY20xZBc04p3VYFa8YHcR6
	 DxV9znagVG6+PRDwVb5cuOxPRT2nloyVm06Ee8SitWXbG9SHGSJcKl4azbHG/6OCBZ
	 XzGvRz+e+gqyi/iVkkhQTmgNOID3Ya9HwbVQoQvOr5Wp/UVU4a7DxsoRqQoKoetG7H
	 duRnc5D9erHlqRRUS/+7N3TGT4Wr0W1gHrEdx5bW7HZQcz0F8ActBonVtCaZMYV5Vs
	 eKY8IDjskz8wpROiRi8ALDeHyNq/i4hKLVNAj/XT4fsmch6NHyv1G2ra4g+5bbrNnW
	 wsVSPlEDeUMaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E207F80E21;
	Tue, 22 Sep 2026 08:46:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 707EF472
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 08:46:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 55EF380DD3
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 08:46:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tx7r2Y9cqd7G for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 08:46:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3092080E21
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790066817;
 b=eZL3OZ+kVYBu4ZpGEYxqk6uVAjNpJxsE3B6S/ObbtlW6hXfRlr5yXYvVw5427JIsWsdz
 J83WGlfxW8iHDgpSEi8mLnem1K8yEjp++rUdM9PVASFCaXD22Ej7NfblRhRlZb0RBFgT9
 RlG7iPy7sYL3tnzzOo+5BSLx/KMXdsDO3oNtK0teo0AmZlST2hbF3Ty8xiAXXdu5ku8av
 IWKbGcIMtb3pMks4lidmoVg87EYrmx8tI2nO4FkIrBDzhRkzL993l6qm5TcoW5Inzk6Or
 FYi7gIWvMfU0oqXZxCpAAADhJZbDy62/GbifX7Lf1cRgmgzYWUNv89baOlHp8lb6dGQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790066817;
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
 bh=D/np2C/wRwRcSHnVqrDo56VCwyGMzdY+2Om8JaFJRiE=;
 b=LOFr5BJBVFL8WKkAb80zvPFE34LeAGWza95t+/Vm1F4psenVTfPjAHcczbgtSD0RFUo5
 pdQepGTId+SaYzQRznH4soGXmxVnVeB914F2/0ay16laBy2ywuPtOWWJaWhMkg3/nvK1b
 ZKoDt5MHtWrWPTYCL8ZmrfWfgNA37HMLv0la1wnl+sc5n8qtS4H846vlfdAP8tYZIOLLJ
 rgpNjBMeAsUqmyPnRH5cyEL68U8OdqpUh93S5U55HqEG23aa90YhXVAQirHB1+7Wa6kG1
 OGt5+h3csweV04JTt6pMU4oK3n8n3UPHCIzYY7UVaQ0RJtvwbcJCRKZ0QZehMz1tCJw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=mSPEldLp; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b="KCa1ya1/"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=b-padhi@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=mSPEldLp; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=KCa1ya1/
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3092080E21
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 08:46:56 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68M8inIm3143538;
 Tue, 22 Sep 2026 03:46:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=D/np2C/wRwRcSHnVqrDo56VCwyGMzdY+2Om8JaFJR
 iE=; b=mSPEldLp4Yud9qVNMQiyNO2LIPI0YStkQPu7jp4bzjCLoliJ24uy7aJUo
 7AYZjy6RpKT1We3Vi9Au0AQsEoGsz6TMeTfh6g4xUeI8BIdqzBVZ8UzKnFIVu3Fv
 mPGjLq1gQ3lHaUAmIa0D1iqouJAcWY61GIVz71VJ0XRnQE/WAL0xOWQQmbZB5laZ
 gY2tx47HL3naHeyzM3Kn3oVNeCryHDSiwi7K0AzS5Ysif6xS9Q5uFof+tRDK7Bze
 ftAJEGUMJhjrSffX1j16CZsl/mYitMTpWx2z4EGwffmENLfEcizEjblUTqN+5Am2
 +bIOinRUup6BnW5Q2NTvAJgaIZSiA==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010048.outbound.protection.outlook.com [52.101.201.48])
 by m0384305.ppops.net (PPS) with ESMTPS id 4gupea00bf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 03:46:53 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJKDQo+YiPBLkTaffXtAJlBXZRmXlfHH/+GFWaD0jUkgQ+rVZqvpenqamO7QtImHoxONrrp410UzMGqlcVa8AP069NxdUHWgusjVFz8nRO2iRxZNYNmSaXiSNmGy5SPH/8/9bzt/O0vmuTRUge/gXUHKcH9zSOApIyE2YJS2rUOgmRmyG0GO+gyOf7TfFI7JpODpJjSXkULzAQ5MMLxz1cMemWppMyiiud1IWsgOKzVU0V2zuBGpqGww8cBcFVNpXKBP0ZAqD9AQoQB461034r9fVQGdP/r2B8Jqivkd8aIJdkNhh7CarP3nPTYKQ4uO9oVa+0AKZD9OuRlHRB9wQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/np2C/wRwRcSHnVqrDo56VCwyGMzdY+2Om8JaFJRiE=;
 b=L8O/R1anok+l6Cet7rpMn84KAMMugvmB4EsBJVK5+PLatSZXchT71DmoCNAG67L1GNRFwbxV+R+9SJrjXY3QNkzBdQBG8dsh7J34q4qQ1wfXmMTUfwq5zPPYjoij7otWMNsoDyn2OWKjKPowE0yOahwuJfT3jDi1bHDPPrMQe4WJFMlpYgXOm3c+EGhMvCeiYe1Rl5v0rvHTvOeCxbxfGjWG1rVI4zpXSsd+sGtDEKxhF99X9lteslv8kvfuI4lF5zF3ZEDo0CLF4T+Unr46Sb88YLH4N8S6EERJ1/XenGhfLvi2Euc9ndQhvvhn+UaegUfq9cZcytxzzHZSw3ZNBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/np2C/wRwRcSHnVqrDo56VCwyGMzdY+2Om8JaFJRiE=;
 b=KCa1ya1/JbvyDCDGTfcJMoJZJl7bB8Cz0qjt4YRUytPfwMOYzX73I8yguapu7BfxHb/v7kwhxcp3nzSijW7sQVQ4QVgKJMiAS9Cyox2RjliGYqfkkJjkGTSemyjnXb9vIeoMWRPurB5bddpES0PwuSjsgkA6x+WDrHxNYfqca/M=
Received: from CH5P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::12)
 by IA0PR10MB7546.namprd10.prod.outlook.com (2603:10b6:208:483::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Tue, 22 Sep
 2026 08:46:49 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::3f) by CH5P220CA0008.outlook.office365.com
 (2603:10b6:610:1ef::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.13 via Frontend Transport; Tue,
 22 Sep 2026 08:46:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 08:46:48 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 22 Sep
 2026 03:46:07 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 22 Sep
 2026 03:46:07 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 22 Sep 2026 03:46:07 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 68M8jaFQ3813357; Tue, 22 Sep 2026 03:46:03 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.u-boot-project.org>
Subject: [PATCH v7 7/7] doc: board: ti: k3: Add section for HSM M4F core
 loading
Date: Tue, 22 Sep 2026 14:15:36 +0530
Message-ID: <20260922084536.2477291-8-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922084536.2477291-1-b-padhi@ti.com>
References: <20260922084536.2477291-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|IA0PR10MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: 134cd277-f200-47e9-6058-08df18860a45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|13003099007|3023799007|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9CuIZYAZSezFeaZXDL9YjveUDlX8bz1kTNZwLEqpIXEiDjf6c3UaFENhX3CZxUVaRYtc5TQX9nVkq+zk6KlMAiyakcatzh8PTCGeeEwJst48HJJqK7i3kuu319lu9a9Hy14BNTN+z+nYofsW7srzPjFGz2GhQN7wY52u6zJgoP7jN9IU13pSNOZZmWAo1AT5dddxuQ1nsBN0gp0Y+Tq4Ttj475X+LplSQN0kedLNEHgHCvOB4Jeo4b6J1Yf1arJY5Of8Mk4eyrDF77xr0e8UcLHSfXRUc7En9oeI9/XRRsGkJRD4x7plVnbu6UWJGs32KKE+r/PyVhSDsgBY6pwLOL7kSHAOUIStjtHBSxNnsfUdxR5+neRcqk6AoeQ2fAehFA5I/QNu/lB+DSnYcMvGvZ2pFxs4fvWDkrJP6KhAoheIToNG4gx58gtF7jC0+vyjh1akCf8otnX6rkoGSijGT/3xaLbiBlSeHUHw9bUHHQHA7w1N6PVu1K4lSNqsY5S/bVK743+rjNu6/Zj7dGmJt5K7Lxcf85XBt3jubPI7H5HfvuV7znTewQaV2Y69ANlWrab9Sn9AcIhQkcKW9ZB+SkrKg5Rr8GswZJdHTqDo1aA3mCHGD7mE7EKaYQrEmYEbPBtyZrD+Hxf0RnrQuZlV7w==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(13003099007)(3023799007)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LLJ2vlt+gfnWKdUme/u8aOEcMLTFVr0N4Gjs9mQYjqEnqDbrXbZgZqgqmTEsKxX5lVSahfrH+c0QaBR7/gVRo6DVzrsnuLbkKWTCIiyPFxb3lAFGL099fldsKrAt0aRnYG/a8HofL2gRMf3+YilNJHLE7Cx0wv9IqHfM3dqpVKEGGiYqk6VeSHt0OvNNx4JP+VjXJ9HudDkBg2OoImlPhUWubrMo+H+GdTQVcDaeeFvOf4GieFHdJxNWAnWID4QzVhwCGCLsECBdxxmhXUc/sX6iwbbORk4zlRE0fwOw41ZQSa5/x50tpA22IZtUxLkatClIdKBiJ2BYSNRz7oIyS00DjSUuqG3DQArMHtQ9E6fIFc1K/XeoUkGwvO3/Qofb3DbytkfwSM82vQz+mc06n+/B+4BOqAkH5P7VDSxAZqlJy2b9HnTHhUjwKJS7AQA2
X-Exchange-RoutingPolicyChecked: lnBIRWOATa0wqFoxS0aR2+iySAHSb4097UiAZqifiHMqSCEzpgWNV+xyAWPrpsrEs7Rk64LezwqY7QxGODawyRTi1dONcKpPHDS8SwJdshgzqzLf4eZc1MBYNWRtDi65alFI9r2FxRkodtNIuEn9DP2b3OT9KHwtM/Sgit+bj8xqHVDHp2M19+VDONwmpgilbMeqzR0/iwqcxjdAzhO5ZUi78SSBgJ5DGXL2nwmrXG9SU4V/3vxsFx2hkyjJZH1Gwn2w93tGSI+xIVHKzQZZfinLXZ1jzuighDxJJqz9lW21c4NPJOIFLKJxF32yAqbM4DjfmuwGL5kZhRTciXjeNQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 08:46:48.5711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 134cd277-f200-47e9-6058-08df18860a45
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7546
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDEyNCBTYWx0ZWRfXwO1bRZG59bR9
 QeCk6o9nmMOO9LHloOhKXs2laQDATqAlgog9gTvleEO9zRfMiCrZZv2NJ4Yx44VASeyMTJ5RdW9
 TkcRMOdxJ95UgyIvt/Oz3bLEoUb3YWZNljdLUMGAgqxkrR6UZw9GqbUQFpmVkM8EjrAkMpxOE1G
 weVc4BihkP0OFrtrrZoPZ7kCFDLiRcBhAmsOJrG2Lx1JIzFpNIyET5bCFKhLgPX/ZSJb8cXjqnC
 4Le0YPTCm3DBbBpAdOUZa8eCZhFhFKxjrSFgJMjsHrBNcxLJgT12OXh1LbIy0CxIViN/1gLw5hn
 yHRTRVx1vs+l2r4obRtDTTF1rLSGVIZQyPwL1b4+4rAQsSbqVch9zZXETFHjG+Ujj8/vQ7pQCcL
 J39zgZdQfde2q9Oa4s+OY+obFVvMbFsoyA6ekKHGZCqkt/JMYA5X33mwAqQDkOOswZeqwz9b9+/
 YoKyT+JfHO+jqaa37tg==
X-Proofpoint-ORIG-GUID: 5g4egDCdKcLZL3ubTRY4hZQHIdFGO-ag
X-Proofpoint-GUID: 5g4egDCdKcLZL3ubTRY4hZQHIdFGO-ag
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDEyNCBTYWx0ZWRfX+HrCvP180mtV
 /Ggc1TW5cq38HDfm3M5G+hmA+dIQjhTTTrMASKfecOTCErw0jR8Sjf5xkgc05aJZDXV3+898OH4
 M1lmZWdzlGP9dwIxptjs627TEcOp1y0=
X-Authority-Analysis: v=2.4 cv=Mdz5KJ/f c=1 sm=1 tr=0 ts=6ab2407d cx=c_pps
 a=FHNT3LFbDro5wzOX4rYsGQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=voM4FWlXAAAA:8 a=sozttTNsAAAA:8 a=NEAV23lmAAAA:8 a=xyjKfQhMXZlMLvdiQTQA:9
 a=IC2XNlieTeVoXbcui8wp:22
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

Add a concise section for loading and booting the HSM M4F core in TI K3
SoCs like J721S2, J742S2 and J784S4.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
---
v7: Changelog:
1. Included the HSM doc in the applicable board specific files.
2. Carried R/B tag from Udit.

Link to v6:
https://patchwork.ozlabs.org/project/uboot/patch/20260831083347.1168880-8-b-padhi@ti.com/

v6: Changelog:
1. New patch. Adds documentation for loading and booting the TI K3 HSM
   M4F remote processor.

 doc/board/ti/j721s2_evm.rst |   7 ++
 doc/board/ti/j784s4_evm.rst |   7 ++
 doc/board/ti/k3.rst         | 136 ++++++++++++++++++++++++++++++++++++
 3 files changed, 150 insertions(+)

diff --git a/doc/board/ti/j721s2_evm.rst b/doc/board/ti/j721s2_evm.rst
index 21683b90b1a..db932447e63 100644
--- a/doc/board/ti/j721s2_evm.rst
+++ b/doc/board/ti/j721s2_evm.rst
@@ -281,6 +281,13 @@ https://www.ti.com/lit/pdf/spruj68 under the `Bootmode Settings` section.
 
 For SW1, the switch state in the "ON" position = 1.
 
+HSM M4F Loading
+----------------
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_hsm_m4f_loading
+    :end-before: .. k3_rst_include_end_hsm_m4f_loading
+
 Debugging U-Boot
 ----------------
 
diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
index 54b4b6031f0..179d157206d 100644
--- a/doc/board/ti/j784s4_evm.rst
+++ b/doc/board/ti/j784s4_evm.rst
@@ -637,6 +637,13 @@ to the J784S4 endpoint:
 This program copies the boot image to the PCIe endpoint's memory region and
 writes the necessary control words to signal image transfer completion.
 
+HSM M4F Loading
+----------------
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_hsm_m4f_loading
+    :end-before: .. k3_rst_include_end_hsm_m4f_loading
+
 Debugging U-Boot
 ----------------
 
diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index d3ecaf59909..c14d9762490 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -755,6 +755,142 @@ resorts to enabling for the entire DDR region:
     bootph-all;
   };
 
+HSM M4F Loading
+----------------
+
+.. k3_rst_include_start_hsm_m4f_loading
+
+Some K3 SoCs like J721S2, J742S2 and J784S4 have a High Security Module
+(HSM) M4F core in the Wakeup Voltage Domain. The HSM M4 core is loaded at
+R5 SPL stage. Boot flow for HSM M4 core is different than the general
+purpose M4F cores, and is described as below:
+
+1) Request control of HSM M4F remote processor.
+2) Assert Reset on the HSM M4F remote processor.
+3) Load firmware into HSM M4F core's SRAM memory region.
+
+   * For HS devices, request TIFS to authenticate and load the firmware.
+   * For GP devices, load the firmware manually into HSM SRAM.
+
+4) Deassert Reset on the HSM M4F remote processor.
+5) Release control of HSM M4F remote processor.
+
+This User Guide documents how to enable HSM core loading.
+
+How to enable HSM M4F Loading
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+By default, only the HSM demo firmware for HS-SE device type is packed in
+`tispl.bin` FIT image. See the "How to build U-Boot with custom HSM
+firmware" section below to change the default firmware for other device
+types.
+
+R5 SPL supports loading of HSM M4 core for all device types, i.e., HS-SE,
+HS-FS, GP. However, this feature is disabled by default. To enable HSM
+loading, set the ``CONFIG_K3_HSM_FW`` and
+``CONFIG_REMOTEPROC_TI_K3_HSM_M4F`` configs in both
+`<soc>_evm_r5_defconfig` and `<soc>_evm_a72_defconfig` files.
+
+For example, to enable HSM loading on J721S2 device, make the following
+changes:
+
+.. code-block:: diff
+
+  diff --git a/configs/j721s2_evm_r5_defconfig b/configs/j721s2_evm_r5_defconfig
+  index 806c97792f6..ebe100c2278 100644
+  --- a/configs/j721s2_evm_r5_defconfig
+  +++ b/configs/j721s2_evm_r5_defconfig
+  @@ -187,3 +187,4 @@ CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
+   CONFIG_PANIC_HANG=y
+   CONFIG_LIB_RATIONAL=y
+   CONFIG_SPL_LIB_RATIONAL=y
+  +CONFIG_K3_HSM_FW=y
+  +CONFIG_REMOTEPROC_TI_K3_HSM_M4F=y
+  diff --git a/configs/j721s2_evm_a72_defconfig b/configs/j721s2_evm_a72_defconfig
+  index 6db41cb457e..a07e6d63270 100644
+  --- a/configs/j721s2_evm_a72_defconfig
+  +++ b/configs/j721s2_evm_a72_defconfig
+  @@ -198,3 +198,4 @@ CONFIG_UFS=y
+   CONFIG_CADENCE_UFS=y
+   CONFIG_TI_J721E_UFS=y
+   CONFIG_TI_COMMON_CMD_OPTIONS=y
+  +CONFIG_K3_HSM_FW=y
+  +CONFIG_REMOTEPROC_TI_K3_HSM_M4F=y
+
+Proceed to build U-Boot (`tiboot3.bin` and `tispl.bin`). One can verify if
+the HSM binary is packed inside `tispl.bin` FIT image by using following
+command:
+
+.. prompt:: bash $
+
+  mkimage -l <output directory>/a72/tispl.bin
+
+.. code-block:: console
+
+  <...>
+  Image 2 (hsm)
+   Description:  HSM binary
+   Created:      Thu Mar 20 13:26:16 2025
+   Type:         Standalone Program
+   Compression:  uncompressed
+   Data Size:    132694 Bytes = 129.58 KiB = 0.13 MiB
+   Architecture: Unknown Architecture
+   Load Address: 0x82000000
+   Entry point:  0x82000000
+  <...>
+
+The HSM core loading can be verified by checking for the following log at
+R5 SPL stage: 'Successfully loaded and started HSM core'.
+
+.. code-block:: console
+
+  U-Boot SPL 2025.01-00391-ga7a25e886202-dirty (Mar 20 2025 - 11:04:05 +0530)
+  SYSFW ABI: 4.0 (firmware rev 0x000b '11.0.9--v11.00.09+ (Fancy Rat)')
+  Initialized 4 DRAM controllers
+  SPL initial stack usage: 13456 bytes
+  Trying to boot from MMC2
+  Authentication passed
+  Authentication passed
+  Authentication passed
+  Loading Environment from nowhere... OK
+  Successfully loaded and started HSM core
+  Authentication passed
+  Authentication passed
+  Starting ATF on ARM64 core...
+
+How to build U-Boot with custom HSM firmware
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+To pack the firmware for any other device type, one can update the path in
+the SoC binman template to point to the custom binary and re-build U-Boot
+images (`tispl.bin`).
+
+`arch/arm/dts/k3-<soc>-binman.dtsi`
+
+.. code-block:: dts
+
+  hsm {
+     hsm: blob-ext {
+        filename = <path_to_custom_binary>;
+     };
+  };
+
+For example, To pack the HSM demo firmware for J784S4 HS-FS device type,
+make following changes to `arch/arm/dts/k3-j784s4-binman.dtsi`
+
+.. code-block:: dts
+
+  hsm {
+     hsm: blob-ext {
+        filename = "ti-hsm/hsm-demo-firmware-j784s4-hs-fs.bin";
+     };
+  };
+
+A list of all HSM demo firmwares can be found in `ti-linux-firmware
+<https://github.com/TexasInstruments/ti-linux-firmware>`_ repository.
+
+.. k3_rst_include_end_hsm_m4f_loading
+
 .. _k3_rst_refer_openocd:
 
 Common Debugging environment - OpenOCD
-- 
2.34.1

