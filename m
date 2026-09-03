Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD29C624D6
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 12:51:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 76DC640AE8;
	Thu,  3 Sep 2026 12:51:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RIsjtAJYGvL5; Thu,  3 Sep 2026 12:51:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7ABAD40B09
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788439867;
	b=VA8CybqweFArmQkg/JaaaV7wgAkC5l1xtaKvRGYvldoGk7PDTHFVC9ZmBAfywfdgmvO1
	 I3TgFwq6QaOx9OscrOn3elPW6YGk+lFY9dDWQ2m4yNIND5IOPCOpw4CJpgMKsMHRLkPy1
	 DxFSelf64FtGKQ0MTItykwTOjUSojMR05uj+Ei72rymXbjlhXszuI2hFDf3UepH29+hRS
	 GM5o/Qzxs4Q1hSQIxi+tOzYhm5cvU2KjvybPJmPayJPqoAGOZ6jMBaZEcgsOTQOzdNYqs
	 /USAZQEY8/DeYYPadPIZbqkaEK4akHIOD3wVgpSU+B7llmcy73wYRshvksF1V7hbfSQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788439867;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
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
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=u3/PBd3RvIWm/JedNtfPmn1k7Q4pf6KVC79pVh8eMCw=;
	b=QE9c7wZChMAV9degjy21IEdpCf3tOWkYVfz5N9ze8H6PMNhRHmz+q1uqpynkQAL4k9pz
	 QCnVuysPn+1wGjUs0u1dCAAtOBbWkxW7DLTr0pY3eN4WhypIB7DEdGvI53+qN1/az3cTX
	 YwTSOjvWI3C1z1jsSdlRw4L9TEuOoXxWAXlorI6oQ9fAWADYcW9F2ZI4eUGzQROM/pk+f
	 zmcE9M8hEJeZiPmfmWk1wJ1b6/WoIRdDxMQyavCq2gLmXzdQ6FpXyYIK+VmIUbj6iF08T
	 0SieaewlakEc/18UrL6+uL5wHhIscBj9+rXlWURU3NJ++h4BjFNAE2x7mBcuVtEmJew==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788439867;
	bh=u3/PBd3RvIWm/JedNtfPmn1k7Q4pf6KVC79pVh8eMCw=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QxEp/S4bqkmXYZJ3c+lL+/w5auU+6537hBxu0iqCeC6NVmVT0EiX0aTeN55Zmx0hJ
	 4u2K6NsJxTUd5jHMw7zs2gymwDiyQzeB1yWJc/SDJFGQ6+R6bwzDYTCSlUhbTSBJgl
	 KLwoqRjp+E3yHGvN47blrgD4KyqLX86cHUtXD+riHTVY97vL/ZwomCvKomHmsVba67
	 sp+/fam1ChT0OqIE9BEN08Kauf0FPOqbvVAuSac8ox1kKNd+jKZHqo8BpN0j50cyox
	 y4vfZevEmk/yv0OL3zFJLUcJIG5t/4JNR4iWIXVaOXZnZgBsUqId5AnJ3ILfaDRHS+
	 7jiqA1SLAlWeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7ABAD40B09;
	Thu,  3 Sep 2026 12:51:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E7A2E265
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 07:28:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D648540084
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 07:28:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JeygvzmRKJQf for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 07:28:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D7F8D4002B
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788420504;
 b=jRjEsSYG7tcbmL1KB/2Mwbghui9b9aawDV5QSiYbeKEHxBD2VzvmfFhxwn2URHAri89K
 HIBeR4R6d2UM+4iFQ3d8ysV5OpXW+UvwWLWc3uJQLuCSIlsvhLkjpJIeQTslYRSBFQZlg
 naW7nXM/W7jvMGZ92rS68X/Oswu8pD8uaNM7Qk7htiFYuok3vCSEFfAEGsw7csUP0qg+U
 /Iaxb+r9B4nAIBgkXBMrvSVmj0CznXZI8kvzV+3esZx9nal4neVKCCED6/XSTC6nkmwRo
 7yC7/VFXKOsLvnJuDyQ3+iKeDfsLo0awg+oBHCOEw90eTeqmFLBUnW6YrFl36Zcvuvg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788420504;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=u3/PBd3RvIWm/JedNtfPmn1k7Q4pf6KVC79pVh8eMCw=;
 b=nObdRBsO3Xt21CWRK8WpWum6zPXSbErn6JOLxIhvTuikQioFBcv3YlnMXwYDFlDwmJsP
 k31TKieICLxpGUo1ITG/1tsrFJ08AWUzR1yI98bUnh5oc8gYlQ3b+2vfrDXdVhq/7e6IR
 JKHlEUS7cAyouYEtS/HXj7ABJthVa3sooYIs4uQawrwzwKl3eWeDMdFM7U5BcdnmzAw6e
 zfw5MBHjKiqURtgJYCaS2F9WrdyFFZaavmNJFrdptjeoJv6xPdwEb0/KAQ6D4BL4Xb/q6
 yIFuD8njT11UQHE8+LWxlbYn901XsRqfMZQzDI3OxfCCf6rwROCJ794n6pnQnBl78OQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=aqYT1GlU; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b="aK/YBZjy"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=g-praveen@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=aqYT1GlU; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=aK/YBZjy
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D7F8D4002B
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 07:28:23 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6835jQ5a137314;
 Thu, 3 Sep 2026 02:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=u3/PBd3RvIWm/
 JedNtfPmn1k7Q4pf6KVC79pVh8eMCw=; b=aqYT1GlUW6Rt5Q0vVuNeZmP+PdVod
 iyD79wPiEoNYV9YMExjbG99XV0ZFpefBEWXiUfE7COCK4c4OExaNSRELVxdBV2jr
 5t5hDPypU8hal8BBWiSPyEsFAxxmX4WMdt/TlBzcrMX8oGgotspbTMU+m1fx3KFu
 H3UE//qehni/KqepKiMwo58sHYhbuDRHUxszkTYCKMU1MWi2mNLX5QqldmyyT/MO
 uPyauCZtYa1X2Ot7SbpzW1G45uZB7abS7/fxZs34108WpVVkwjxVNwaj3CdiaWZW
 HBVZWxQXUVaFBI3qREcNmmWbuHWi/rfWKs/pf+6GNvq3WPJ7LSARb7keg==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11010063.outbound.protection.outlook.com [52.101.85.63])
 by m0380145.ppops.net (PPS) with ESMTPS id 4gewt8j49b-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 02:28:17 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IKRbqHlAnZgjxzVrvwmg/dOH6jcIO0ak/CkeGRAe34G5jyUuAX/jk7zXVCJV5TwFlfWxcWBq4bj8FUheIQGpxl4WkM6HfNkwBrw8ZmM410JOpMFj3N6gE6U859BZcwDA7zOWAVUmdQF7YJYiE2xmb2Fox5pn355iiyeHnvVbXPf+iGSEs5FdSvTDLH1jDhs7pizyNoslXVQODz8aywRvBys7Xx/YX8OYvQn6zYeHtIiT76Pg8qtBPrWQ7EYdYNdjlloNdPWjyFwiPuAqKCTFUp6M2iRLnZ4Tx5ZXBTyTnXQKeNEbZiMClZ0/blPhOBglhXE22WXKCdWBOCvwKilSfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3/PBd3RvIWm/JedNtfPmn1k7Q4pf6KVC79pVh8eMCw=;
 b=Le+nZqHzZS3U2/v1ryVC4dsiURGEXHhALWIxEZRAxV+f5BKBXxD+D/aO4Tg/glEuJCYRR0AF7PWdZqC3cJNDpXajvjYUkDMILprs8IwDAFoAYYTia2N8Ty/SrC5PnouMl3m6wVku1s2IV+73BaFWtBp+fO0BLxyGED9/RHaJw5IvfALBCj+vVQ50llfSA8IXRphj9Hfnhq9KB0Isn9HzzIgMHvDJvU268elxKLhA3yPXatlrhsrWzraLfpmEj4abFoOK4nyXcces+GABCI55s+V9NOGmCPdXQN6xDHlgv2OaqtIE90pWQQcGtHKDocehjcukmpv52GtuGbryuBE41A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3/PBd3RvIWm/JedNtfPmn1k7Q4pf6KVC79pVh8eMCw=;
 b=aK/YBZjyOA4QTKk1YDYI1EV9uJFJxgohnBZvkverMFCD/91cwpWBgi0xKq7m3EsEGn057FAbWd3wmDqNfw6TYnEhS9HXsqCbbR+G4frRPgO4KLx3w4u0sERydmafwmL/iMSfBmzMGXcHMyh23lI9cf1HR1ivBLOLz6FILtDo8R0=
Received: from BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::15)
 by IA6PR10MB997610.namprd10.prod.outlook.com (2603:10b6:208:5dd::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 07:28:15 +0000
Received: from SJ1PEPF000037A8.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::a0) by BY1P220CA0004.outlook.office365.com
 (2603:10b6:a03:59d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Thu, 3
 Sep 2026 07:28:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF000037A8.mail.protection.outlook.com (10.167.244.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 3 Sep 2026 07:28:14 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 02:28:13 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 02:28:13 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 02:28:13 -0500
Received: from a0507176-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.51.66])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6837SBAQ1110504;
 Thu, 3 Sep 2026 02:28:12 -0500
From: Gokul Praveen <g-praveen@ti.com>
To: <trini@konsulko.com>, <g-praveen@ti.com>, <n-francis@ti.com>,
 <u-boot@lists.u-boot-project.org>
Subject: [PATCH v4 0/3] A-core no-SPL Boot Support
Date: Thu, 3 Sep 2026 12:58:02 +0530
Message-ID: <20260903072805.31010-1-g-praveen@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A8:EE_|IA6PR10MB997610:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a99612c-5404-4e36-defa-08df098cea9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|18002099003|13003099007|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: DjdpW5S+nqBwkMKmGxy5shX9pIgf138nHs45cGgt7VDba5HPtnAY99TDyOHuOIvtoaRK4AiOR2AXL0NkbhqzyirsfDF+TjdmbSdGNFrWtSnGbjkDyfFdD0w57BrURR3/r8WgT7OG8XhqQwDKPTfCXH48Cr0sSzgcVVUaYTJ1ibyKZBeUCU7bgtcRdxuPbdTnxNCkQUYy4qxiDLhA8LPeHg6LpO4Guwl89xPV7nstJzGgOTOCgRJRYRwkw7wGHhzno89wIUCGYsNnxqlUTE/28Y86KQitRHsmfrFseG7soBT4UwlPJ67cbh12xI8IT++kSWcTT14xVEUTP/jYdM3PnptxZ+EC19Xbguf8IL21qo6H1uv4lmMcfC4cBbFRN1klHxScQKU4Vl3gI44gEfXYG21KALaCF6zrKcC4mAWN3hlkg/xPqk6UT0uUDuHbbyYzuF9H3WdnzkK4Alzk7AHOKHsqal1NRh4SrNC+NTx84eXE4+QlppttVeYudvfgEBMZqb9Y1EgMbfXYU403iYB8kp2cfxgsMHVjzup0emync/S0YCSARVasHT8/uXOSp5yT4sp/oJRdR8ol5vI5+9xladUNXuh9FQrCG2hZERd4dgeJUbHUkvffO6cZcPbRyc0M16E4hiE3PTpywUz3bee9SQzXuDyo9xsOSecQsdZd6lBe4QxcZVTGA+QsVps2M+uETQF20LWehyLqMY2G24pvtQ==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(13003099007)(56012099006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: p0FsBec8jIzP6ZZdiHw9IJQ6g3ea8RDJM+xdpBLIcuh5B1uH6jPbbmoN2Xq4pQ4t/3BM+2sK7vtI9xZv23kXcrNFIr6DmQEDokHJfF2MV1RwMUofO34RZsf5xQThGmXEWKYNVjt/5HHzZIH5muykc4oksvPQ8rgGVyRSm+6vkjaygjpKJIi1otGizWW9eop0Fj5Qfw3sABCBlIpE0WeTNnXHWbDzvDgZPT2HRpVWV+HeWg0amwBYxsBoDUyI6f8hPl8VQWcSOT7d2briE0KTgdz92raW2DBDGIARtDyBSKJNsIPZut61KgYErtCi1pkFp87FLuOSCo0ovJKL/s2/KJjnhn0FcuGNtmUbtLyc0hu3TxpUBMIG0V5LZ+QPZOSBNOizNhNMpeAvbNhkLfbku48Tl58XC4lL1kpM6AwWlcWOrFIwkrXWx4qww6WMvoL4
X-Exchange-RoutingPolicyChecked: t55t/iEfj/k2OFzbAKTLSUhH18gf0KF8iV2egYeBFdY0IfohrhZC0XhaLJ2kzW8nLoagCQmofnq4+lWdN9AnxvOPC9mL4Whog4FB3Lc5tPmTs4Jt/wJzGLh9VkYn1dLVOK9sUObXxzqsQAvpwabVA4hRWXzRNd7fSOI8kKQmfUxdG8LHbk7WVi4MiwClebgnab1g2LHhXNClXtNUqpHKOWDsxGiUldqlxWj2jBi4/V+aBkpNuCa66c31k0e19FpAozlWdAqi/yf2fcT48LW2xLyjAJdGFqwMW7Qh+bL2xDNaq2ob91Ja9EkW33w1g92Yr38cm4VjtMUt51NYIPLqBA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 07:28:14.4898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a99612c-5404-4e36-defa-08df098cea9e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR10MB997610
X-Authority-Analysis: v=2.4 cv=de+wG3Xe c=1 sm=1 tr=0 ts=6a992191 cx=c_pps
 a=mOz+rD6hbbSUvRiPFvEd3g==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=NEAV23lmAAAA:8
 a=p9Qil_NK8ove1bU19KQA:9
X-Proofpoint-ORIG-GUID: O5cDrpyH1wRkYPMCgX7NhCyS6nM3FABk
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA2NSBTYWx0ZWRfX6A/jpiLz++vw
 BQOaa2WZvar6SOc4WJWtB9t8JOGcCUr6tKeuiR/YN5RpBWP/jFK7dRJH7mU3o9d2hLTXutj3qsT
 z/hoIdpfGWwh0BBFU1T/x+wlMrf7+j8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA2NSBTYWx0ZWRfXyBRLuK5hvLUY
 KrWP0kZ9Oaqw8vpsVo2GydAJQWqdUfsil6a7NZA7AcCKg1cj7GqFAPKELTBFgsb/mr8e7qfhnaQ
 uBGneSfE9irAKb4GdySQI1fukFHR7B7dIZ1cubUUBE98TG7ovO6rzg/YRlYAg8d0rQRIM3oS81C
 Qb/wwRA//WsbATSSgAN+1JT35OcAeP4HGufLubjXEsGMseBE241P/T2a7erd/TjN1M3hDSAha5x
 GcvA7atImYdu2BQdV5oHKh5XlzxjCzPpgzETJwjtdGBrsnPBKW8KmcvbrbH7jXV6/zBLMxli9XM
 hiBDZLM/IbKe85Uq4pmEmzgrlgPH99l7PJNA1ZQ9CmgJYc1+zHX1NvcVGTQCX0oA0l+N3jnEDve
 sSqx7En+tUEhRjMyN9e6wNH5DPfOBqSRIr9aPOA5e74OIaCUvkIScKsM9wseCttcHEGmRUZBtdd
 gXucDA0ilyJWf+V/e9g==
X-Proofpoint-GUID: O5cDrpyH1wRkYPMCgX7NhCyS6nM3FABk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030065
X-Mailman-Approved-At: Thu, 03 Sep 2026 12:50:58 +0000
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

A-Core no-SPL Mode is a boot approach that bypasses
the A Core SPL while retaining U-Boot in the boot flow.
This mode provides faster boot times compared to normal boot
while maintaining U-Boot's flexibility for kernel loading
and system configuration.

v4<==> v3
==========
* Updated a small info in the Documentation.
* Updated the MAINTAINERS entry for the A-core no-SPL Boot mode config 
* fragments.
* Link to v3: https://lore.kernel.org/all/20260819101910.39192-1-g-praveen@ti.com/

v3<==> v2
===========
* Updated the naming convention used from "no-spl" to "A-core no-spl" to
* make it more specific and clear.
* Link to v2: https://lore.kernel.org/all/20260818115322.101705-1-g-praveen@ti.com/

v2<==> v1
===========
* Updated the naming convention used from "semi-falcon" to "no-spl".
* Link to v1: https://lore.kernel.org/all/20260814102153.44487-1-g-praveen@ti.com/

Boot logs link :
https://gist.github.com/GokulPraveen2001/fef407a482e2dad30272006de557627c

Gokul Praveen (3):
  configs: add A-core no-SPL mode fragment for k3 devices
  arm: k3-binman: add tinospl.bin for direct U-Boot boot
  doc: ti: document A Core no-SPL boot mode for J784S4 EVM

 Makefile                               |   2 +-
 arch/arm/dts/k3-binman.dtsi            |  47 ++++++++
 arch/arm/dts/k3-j784s4-binman.dtsi     |  65 +++++++++++
 arch/arm/dts/k3-j784s4-evm-u-boot.dtsi |  14 +++
 board/ti/j784s4/MAINTAINERS            |   2 +
 configs/k3_a72_nospl.config            |   1 +
 configs/k3_r5_nospl.config             |   1 +
 doc/board/ti/j784s4_evm.rst            | 143 +++++++++++++++++++++++++
 8 files changed, 274 insertions(+), 1 deletion(-)
 create mode 100644 configs/k3_a72_nospl.config
 create mode 100644 configs/k3_r5_nospl.config

-- 
2.34.1

