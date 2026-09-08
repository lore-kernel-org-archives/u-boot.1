Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F121C79F9E
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 05:15:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 50DFE60690;
	Tue,  8 Sep 2026 05:15:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6buIZ0qLa5oa; Tue,  8 Sep 2026 05:15:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D9F616068A
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788844505;
	b=WK1aUXfMUg4c62Bv3CJJfAq06lc/nOi1Jw+lkHK45mDSN8/FaJlbAbhsLq1emUb2c6QX
	 6YOZHKPhhn3XJCmW8Rsd2stHd4K4ZAK384NN3KdY7ydnAe6I7IvwRHZ1D+npq8/YtCjnf
	 ZNtahFxfLs6x2qbbeeLby6vkd1EZ90u+MQQ6e1LvPiO4f2vECas0TDcnM3Xmsj8k5wac5
	 vhgaEym8xKPu9jm0uBpBL2gDt7prOdoGTG/Nh9J5n4AXlaoE/HtKIquj8Jdd8fznY3o3O
	 d3NgAraCMR+87Hm3XkJDEVWKnyV2NSNdS/XMU8HKponqXEfe+JHxPpQ85dIWfXWGUMA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788844505;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VGU3DdBbGeGRf9skVqemWbH6sMC5qWl2d8Ez3f+NSek=;
	b=gufef7cAAn3JylFR8Xgd0Mw56/2ZqoULdpvqQa+IqRwoi7bFbTk4fL3GVhJ7RjTSqPlS
	 TQ//dp9kvgjbS5qFRCiLoGQRgIG5LvxZDP2QJrCcyxpDoZ2uOqf9xiFfnHwSY77VaP4SY
	 c939gfd14C6LteMcU8WI12ELV4F2jfyHYazyWxeTpHGqs0Rp+DAhIMMrP/cxwDCPVO39+
	 zR7tXbqIOyfDoa2cuVkA+kdjpyMC6dJKlnxuuJEHTp4XWwj6O7nnWTkFZk3/6/fu87JUd
	 aLflpNPof+6IBN4lnYmZXIgsbK4cVOjsmx3XB515ZTSgTNuQESqaTZ0Twip1L1HvpcA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788844505;
	bh=VGU3DdBbGeGRf9skVqemWbH6sMC5qWl2d8Ez3f+NSek=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dFhTL928411yVA5mRDjVg4QkOJ8nTrTzB2UQsp9nKF3+XnnM9Y/Ru3WvIZs4MDn8N
	 Zw0QID3DdZI8q0+fcXz9zarw+tP58JL9WfU3RGklHxfbPwVMBDcQyoS8yF8Gs8LB/d
	 oNUvhQMVtyVmQ7Sem1fFhtaU+oSj2bQevJkS4pWpcXg8NlpHxRMVjca0fbtJvcbH8N
	 lBHeuJW4G8615sRoVn7sMmBrKoAI0OjzstQK1Fz0J3Cj31Mf3Z3xBjAxzXDBs7t//I
	 JJKMlUY1jpXKGFPgVF/CoYOUz5RVhd0GhijwRQNcdQcgBjHx8DwYsIhofhbbPc+RE3
	 rfO62tB6OkQFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D9F616068A;
	Tue,  8 Sep 2026 05:15:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4CC62AEB
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 05:15:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4A128808A2
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 05:15:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h502GjQnkAMl for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 05:15:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 33A4980898
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788844501;
 b=dWP2ChxZNbCQb9vsD7f+x4eITIbN5yur9qs4bPv91QBc+b9uFVLb/wIIfALGv+UPm/lS
 Fx9u8HcDsqHh11yIIFj04tQFRFA4eDS+6AlAYgrc8v79ZFnB3pj7/kSWXmByHA7b7mb1n
 pxWt7RGOKyqJe5sNvSgX9XilHh/tCD6SoCo+ANFppBv3tnx+7quEio5744whaLd9uni6l
 wEpFvJIdp4wDhKa0+HHbZwlvmGwHRD9JWpxRHfcNVLNWjU1ieG5cVKAPN30FFLAPg7XEG
 oQRy6LfYCTWJXxXSZkdXEe1DwHfnFGjVcRy37fT9BPY+XbUgDW/LXxpSXU1JKxZd55A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788844501;
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=VGU3DdBbGeGRf9skVqemWbH6sMC5qWl2d8Ez3f+NSek=;
 b=Qygxr5jU9c34nZeI8+W8l1VV378ElHqXYvUnpwzzdNznv+jqDIn/vsCyzHjEC28zTIPU
 hmS+kaH3md7FxELWQJfubf9Oe2EwtgYk2MuPji985fPKSgF7Qp3YgV0Tm4XWlYN/tdbiV
 ktMbRsDryghGi1YkyYJbu0qmeUyWMsLxdesn0I+E9OxLg28geyNnj2+EO1KYhBNsFMKIR
 bZP/dNyX4NPhSYDfe5EumdPT27j0+r577QnYkNs+BeORhQBj6aDQcRwr5PBHsAopLAHGB
 kMBVOdRoNoLoJcmYuBzEVQhhPf1WpH6d+DoslllKDuJ3mnrYO3HJ1ox4jmsx7VILGAg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=Sjl9c8bT; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=R67BcqOs; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=s-vadapalli@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=Sjl9c8bT; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=R67BcqOs
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 33A4980898
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 05:14:59 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6881rZuI714305; Tue, 8 Sep 2026 00:14:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=VGU3DdBbGeGRf9skVqemWbH6sMC5qWl2d8Ez3f+NS
 ek=; b=Sjl9c8bTPDtFQ3jlDHnIDACeJzdURFV1c+tRtBKeo78dBSQXqa7zIFuvZ
 bWbFR2kUKZQtbAXGE+GHDal2vcvCvguScqyOKykY7cJug3SP6EpUdkAfEuSBvpnZ
 Jhz0K7kONKUs2zZT7wusOvtNNBAhBppLBEhy2yfx3UymfJuA3DzmlZnjUhARb+pz
 Nv6DFYdy2l3HrBavUzJElPA3Df4wdzGbJ3A8oVEbpH0CmkQDzju+V3zVuxOV7p+n
 AkkQXU0IQ66SGkVXRBBG1aXW1RHCTfUeaTkQXZv2EplZ4I8Fha6M2R4EpO16dcJE
 JXJwcKuM/IOB4BcT6vDcUqLfN9h5Q==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010059.outbound.protection.outlook.com
 [40.93.198.59])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gj93q8ss0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 00:14:57 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lagGl6/RdceSoQW3i6qyNGnK0mxzM3RnWxFSHoa3B7cgWSoj8lvQHxph6l8TyqlFqVRcJAKspioElKgXMP2Poj72Km9QvL8Sxq7u6MR5B4VWwHLhJNDYJRiAFNLW4qyTg/wjasIldYa02duBisKKM2255hNnQHao3LZBN3K7FSG3R/IK9eo4G5dZghEjCa915ZavRC5heCue7Kys3hhNJTw2PSGlBfwp5wfsQtLaEoTu+3rXy9tJqLoLHAsfGJ69nI1UGEiMqKHpSPBW63aiuV1ANXjMxogQRDdKajZvU/hX9vbkoYkXMi357u2IvPv2J3qDuvTyATqn4AObT0SPBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGU3DdBbGeGRf9skVqemWbH6sMC5qWl2d8Ez3f+NSek=;
 b=kyK+X3bsFKfQpTlsulkq8ybC/vUj78OSKI0S/0eexDCERF1qdUWccrVKQerg4/5JpKtqnFtn6g6llobVmEotwZh5Exi50Au12+GWhmG9/ggEjQ6yiHu8040JRFTbvKppYaQgilCwYI0yJbQ8voHSEd+a75qpAC5tink9QVX41VQIL+Wy5YSw+LuQL2yHsbcOhODDLIUuGLfvuy9ZjYm3WmmQUi0mYCJOhQ6t/P1T3G7hXrvvX6cL1heAsk4NjRnbtZDfl827Hj7cYtUIlAUSIoeO6sF1mikhQH5VPLD7oEKpa3fOpyr6Alq5PP/tA9Z7YwWpImYFB/nGNnGhTvEmeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGU3DdBbGeGRf9skVqemWbH6sMC5qWl2d8Ez3f+NSek=;
 b=R67BcqOswo9ZfAzMc64EpiKTowms+HXx3r13FLAesjJvoaziym0jspF5q+Q8QPJMBYLUlg5pcleODU7qCC8MZ+7gxji+B6is9hnfEVYy7GQShQJvX8o617tjI83tFfF+jX8A/FTpWHMIH1kdPBEnP4SJJK6t3msbYzkosq/8OyU=
Received: from BN1PR10CA0029.namprd10.prod.outlook.com (2603:10b6:408:e0::34)
 by IA1PR10MB7386.namprd10.prod.outlook.com (2603:10b6:208:42e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 05:14:56 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:e0:cafe::81) by BN1PR10CA0029.outlook.office365.com
 (2603:10b6:408:e0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 05:14:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 05:14:54 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 00:14:08 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 00:14:08 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 8 Sep 2026 00:14:08 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6885Dwd72811953;
 Tue, 8 Sep 2026 00:14:06 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>,
 <neil.armstrong@linaro.org>
CC: <u-boot@lists.u-boot-project.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2 3/7] pci: pcie_dw_ti: fetch reset-gpios from the
 device-tree and use it
Date: Tue, 8 Sep 2026 10:47:28 +0530
Message-ID: <20260908051741.868824-4-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260908051741.868824-1-s-vadapalli@ti.com>
References: <20260908051741.868824-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|IA1PR10MB7386:EE_
X-MS-Office365-Filtering-Correlation-Id: 8234297c-3456-4b1c-f975-08df0d681e47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: rX9Vj3aqQP7VWeeq+bdp/lZSAfN8e+SphuuPoLnV3vkxfmEv/usbymx8PAFrc9dp/L3wMy+wi7znkRu8WQxiJuqE4SVitLoBP3tFVM/iOy7gpvVI4MQYfHB8pCQapeCkQkpA/XwGMBrRbgEroU9tbwF5Q9+tpe9ieHLvzKQM7fEpcYDKSEoPGwUsyKc/0w6z9tqEGuHBjn4YyKoTDfFSWRdrmtSweiVA4AgEF2EZ8KMxFCEfVSOag3skGoP+cIiOQwC/ndDnylaXRt1T6nYg2xBrFNUyMSSnNKOC/kVhH3iE4AvwKujzWUH3YZipyfi6xcF/MyTxpxNMx5OkJjEIPZeZ012BzOy7pmI1uyb2lriuujvQMl4ocRdF6Nxt8+Jh0KkEKFUQwdKZufjWlBXg7M0SD1hhVAsxxzCnm9KP4BcRQs0cvO9PqYoS5H1xhJENFMpWCm1DCWIufcZsWvWW+MY0CasgyxH8nBzo3XhIf0FH/dgNq42yNU2c2mOXekBBW2dS4Kt8SggDZG+76rClTywLZjByhRwDIHgkAjo4K3jIhkPp37R6nMayqEa8LxIOpSqVjepVFv2u6a1t2eew7oCU8YHSBVX5JgHqY82MaYKUJEgUUJY+NHqCJ6+ggoGeXeE711u6vNGS0b3aLkz0jjHRW6CGYulmyssjn01qgZSTMoi26u9Q7sO6VKXd/jibpju6lH6u/QxM34VPqVm4EQ==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +VdtoT8R0RhZb9rvgguCZe19710abxx32vH0NJh7425CngG2m7KZIY8WbywF0K4QgKQRX3eq7CxGG9vbKak1F2m5Boodf/EM66go9+Hg37axqEtNMkEdWug//KvnPmNEz0w3fOK7FJSojcWRjcdKl624VesVpvvotFHGCssHJlgIm2RCYIxxvpCXwzHaaHGGofAT8BGJY+elL7YLiZV9Oqvp7oY8LpgqABJa/l03DwhtPJ0sU9J7Si4xUTet8iMIMzxbThOsdLC462beaQkJPm2QWreeU8492fIiRWir2D5Jfvx9k44FbbUxuDqOsyatueh+kA4nGIW82rePBSG4vRjPQ8YGDgIGomD37GNSTOf+VFU0legVXEQLHmn7Ate/r5BjELtBkZpfRnRH0msTyPsNYCCorOFJPcXaGw1mYvdic+0ny3lSw1FVkf8iapSZ
X-Exchange-RoutingPolicyChecked: 0OBUoFVad8m2Bl6COWLCUZ13RXenj9dmEV66GLQeZvLDu/UVduIvvnEMy4fW/LNLqB2Z54P1ISIF4ww5/iGkpBB8h4ops8dAW2wQaN4EANcGbm1dQSDD7nouwiP/EkMGRBoLbXp38MPNZz3qXJWo2Yjy5wJYe4C21vSZpsPVoXTkABX7ToaqFHZo4x0CPbdgVWlISIwf/bLzlZ1oFRxQWfnnj7jZci+gdBRduQZNNOpHWOoBADAyqeo6p2KeqhNtUJvE+dMFgR7Nnzx1l64X+iyh+KdahiS7fmmxMmzkH+A1xneflLESNiVlJyRd1NpHaF7k2pQbVwAaYNNdjOcfjw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 05:14:54.4494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8234297c-3456-4b1c-f975-08df0d681e47
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7386
X-Proofpoint-GUID: 3dK2lKfo2-cev17G7NqWwTlrARwh_4xt
X-Authority-Analysis: v=2.4 cv=FvQ1OWrq c=1 sm=1 tr=0 ts=6a9f99d1 cx=c_pps
 a=iByqbumfC+QZNsSPXlDUmw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=sozttTNsAAAA:8 a=Z8kan6jJZGmnBQBbOTAA:9
X-Proofpoint-ORIG-GUID: 3dK2lKfo2-cev17G7NqWwTlrARwh_4xt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA1NSBTYWx0ZWRfX5AZPTyJtheXu
 GdP3uvhP3Y3xrPTehtAsS2x3WQPc50MFxCSXvtaWhBxw7GNYnHowIjQx24dd3+5g5cLUa0k/Prj
 cMx9XUjsw7F0f9G+vg5x26qyX/VEL4h/bofdJFIh/aIH+egk6OY/Rh5iCFWYVTx3z8WYaMhRY0e
 h/M8+ZLAoVl91cmm6xjiz9GbomiI/MXpz2tvKlMI8XxMwXDq0Yhf+mJ6SV2rCndJRp2xNLPwLQi
 NKgVhrA/1wiEwHPMSxI3A6qEWDU/AMfKeptM490qJyiL5uQNSVzuwfAwexNBVCvXoITiYVQxaMq
 gQfQKvY4UfjMm0fXTCjh5WYpy4G7CJWWhPjAS/faC7O58MTYuExhLpuNYxuemWJQk98BA1d9IGu
 Ds+1s+lZdiE2EhMWXLegySyq/FOCPKDVyH4u7t1m6+pS1l+fMZZcl25TDPGkpmL0rlD4iJ+6uTj
 +JwSFUApCEqK6FYswOQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA1NSBTYWx0ZWRfX3DdvOv2yyD0V
 YTQU2Y6DMCoHgPzinhxX4OxxrBqxJwvo1iWVSOQCTFV79ajKmJUWqGflt7xc2HvMYYR7XYWLSJr
 PjbgIezglsXjwCLU+gA8cJvJMFpoSSI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_07,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609080055
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

The 'reset-gpios' property specified in the device-tree corresponds to
the PCI PERST# signal that is used to reset a PCI Endpoint. Since the
on-board circuitry may not reset the PCI Endpoint, fetch the 'reset-gpios'
device-tree property and toggle the GPIO line corresponding to the PERST#
signal to enable the PCI Endpoint. In the absence of the 'reset-gpios'
property in the device-tree, existing behavior is retained rather than
returning an error.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Polarity of the Reset GPIO pins has been fixed since the v1 patch.

 drivers/pci/pcie_dw_ti.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/pci/pcie_dw_ti.c b/drivers/pci/pcie_dw_ti.c
index fb39132f7c1..ac2045991c2 100644
--- a/drivers/pci/pcie_dw_ti.c
+++ b/drivers/pci/pcie_dw_ti.c
@@ -58,6 +58,7 @@ struct pcie_dw_ti {
 	/* Must be first member of the struct */
 	struct pcie_dw dw;
 	void *app_base;
+	struct gpio_desc rst_gpio;
 	u32 num_lanes;
 };
 
@@ -252,6 +253,17 @@ static int pcie_dw_ti_probe(struct udevice *dev)
 		return ret;
 	}
 
+	ret = gpio_request_by_name(dev, "reset-gpios", 0, &pci->rst_gpio,
+				   GPIOD_IS_OUT);
+	if (ret && ret != -ENOENT) {
+		dev_err(dev, "failed to get reset-gpios\n");
+		return ret;
+	}
+
+	/* Keep the reset-line asserted until the PCI Controller is ready */
+	if (dm_gpio_is_valid(&pci->rst_gpio))
+		dm_gpio_set_value(&pci->rst_gpio, 0);
+
 	ret = generic_phy_get_by_name(dev,  "pcie-phy0", &phy0);
 	if (ret) {
 		dev_err(dev, "Unable to get phy0");
@@ -281,6 +293,15 @@ static int pcie_dw_ti_probe(struct udevice *dev)
 
 	dw_pcie_link_set_max_link_width(&pci->dw, pci->num_lanes);
 
+	/*
+	 * The reset-gpio (PERST#) should be held deasserted for at-least 100 ms
+	 * before the link is brought up.
+	 */
+	if (dm_gpio_is_valid(&pci->rst_gpio)) {
+		dm_gpio_set_value(&pci->rst_gpio, 1);
+		mdelay(100);
+	}
+
 	if (!pcie_dw_ti_pcie_link_up(pci, LINK_SPEED_GEN_2)) {
 		printf("PCIE-%d: Link down\n", dev_seq(dev));
 		return -ENODEV;
-- 
2.51.1

