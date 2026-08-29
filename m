Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5F9C61DD9
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 14:35:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B77F60841;
	Sat, 29 Aug 2026 14:35:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2AwfrIgh0zHa; Sat, 29 Aug 2026 14:35:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788014100;
	bh=LSPoNPh9vhtr1QBSChpLLQQ4pGowAZQLSPK7N5mqmEk=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QV3iudDI03jFceuWWwxcGKdLuSbveE98zQz/KrhMmUtRQTxAro5bvOlM3JYHrwdgo
	 43YKAzbdxdIepAtoJmmGC3WYPcifUWsX4bpWI7FZntcwHdW0belIbrz+9B49ZkLk8C
	 0CdqGnHR47trErheO7F6BVZ7MMPqV++NhaNlq8E9hkOpdKJE7/9UTnIIUiQxOylard
	 3SZT4WgxV1RVBKSQ2jcmbf7Skd2tBc0c9rWWVXzmyGHlES1U3z3M5Dt2lHIsBd0mJk
	 nzNIR2c2fi0uItHCNm3dUp3Zwgay0dVSjRnftS+5/uSSuWUjtxRE3n4CI4Zf7cE1sU
	 SKH3a2xQDv7QA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 28BCE6066A;
	Sat, 29 Aug 2026 14:35:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7ADA214F
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6F84260720
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uuEaG_MX-CRT for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 14:34:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=jJWLpIhC; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=iqOXfRDD
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C8B776085E
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:54 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67TDxo5p4097404; Sat, 29 Aug 2026 09:34:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=LSPoNPh9vhtr1QBSChpLLQQ4pGowAZQLSPK7N5mqm
 Ek=; b=jJWLpIhC3bGPrQbtIb6I9Bnf4/Pw8qLU6onLLIkLuutXQm8Uzn7CbVBts
 Z4OOqh4JFIWGPSOpGSlvqASxmdX+1n/ETVqhPrwHC0dz0o4mR1Md7wmF/bEC0tNN
 fdUlOn7e/bbTzbVavmMuAsfdGm6CZOBHXmETRIk00DBFnCA0i5bqfxCRcdM0kd3W
 IbXH3TAEjbn3i8ALf4oAca/lZki3157eo0HWwA38YGGWgoSlb6v62NsgP+4PEF0K
 fGpAzbMDQRHJIVR4urT7TkSzCxhiXB5N5PcVAI1YTpMi1JZ5YypF2XC9EW+MqL+g
 RWfLatM1tXbeVqaV6pT3nrUQx/ozA==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010037.outbound.protection.outlook.com [52.101.56.37])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gbqr29rxs-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 29 Aug 2026 09:34:53 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwBouOPSQo0crE0sMKD1/d82f7e0rBVKwaF03UVzEWJ+0wsxZkQ6W/yF2HxZwuyGG8GTIh+bs5n36pSsLYarEF1Ld2qmqgnpAiz/4prZ+Rp2FoPVonDPz7gp+3um57CB+h0GREJd0fJVGQmSXeo6Q4vzUAQbWoBDpfSX36dOGkMC0z9mycgYf5aPptDPnLaA5So9uy605CcEINrBtR0dV/75lDXvbgh+GbvzSLdOSoLGClLNi9avJjn6Wzf3SA15aUbrbzeFVuivlMhdsycadymqdIwC228X8Y15F+dGMPsyjwUFalgswg6Ji6X4Ir6ig9mgQSlVXfdcIy+kGjkADQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSPoNPh9vhtr1QBSChpLLQQ4pGowAZQLSPK7N5mqmEk=;
 b=K00BueY0oR7PtMlSm0MbhrLbykGjZrp71uug+2S95mEtd3GrSkvMyn9d9k/thPPTFE8/pbHDceuh4d4VGB0hbETMexA+tLOrTwZkGiWkJ3GkzG478+gaSPpQx45tOfWZSge8kNULSfqJMMm2IrkNzpEH2C4UlsUgRTfD4WbIsQDsYMMD0l9eQTg9yCiv9Exi5YzLQKtYrL/ZtjyLpbGKTc4jjAc0DZfLw7fwusf4inafAGqj3yM3+vcm6YIMXzuWOy7J3IB1/lNZid9rE/fvoK/wy+FCWVOo+I1aAaJn8YnCM4uUs/NRDL/JAdOlhE5kGnPhD5HGzdRYmyfKSaqJrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSPoNPh9vhtr1QBSChpLLQQ4pGowAZQLSPK7N5mqmEk=;
 b=iqOXfRDD/M9HFZdeHK6baSHTddEKS52fz7AJyRWEyB9UzwyoJCHPWQQbNd9hTQZ7IIZWHRccHikxYrLAzxfJKOmXwdOY/UG28aTSGejVpfzBNdhhBHsLXB+oWhJ8zzOHLkQMIVenaFbldGIjGV0PAc+7POi1wtflXNndtiFOoio=
Received: from BN9PR03CA0251.namprd03.prod.outlook.com (2603:10b6:408:ff::16)
 by MW4PR10MB5776.namprd10.prod.outlook.com (2603:10b6:303:180::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.9; Sat, 29 Aug
 2026 14:34:49 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:ff:cafe::3) by BN9PR03CA0251.outlook.office365.com
 (2603:10b6:408:ff::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.12 via Frontend Transport; Sat,
 29 Aug 2026 14:34:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sat, 29 Aug 2026 14:34:46 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 29 Aug
 2026 09:34:24 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 29 Aug
 2026 09:34:24 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sat, 29 Aug 2026 09:34:24 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67TEYO7v530328;
 Sat, 29 Aug 2026 09:34:24 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Sat, 29 Aug 2026 09:34:27 -0500
Subject: [PATCH 09/14] board: ti: am62dx: update MAINTAINERS entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260829-maintainer-fixes-v1-9-e4e03971e14c@ti.com>
References: <20260829-maintainer-fixes-v1-0-e4e03971e14c@ti.com>
In-Reply-To: <20260829-maintainer-fixes-v1-0-e4e03971e14c@ti.com>
To: <u-boot@lists.u-boot-project.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 "Bryan Brattlof" <bb@ti.com>
X-Mailer: b4 0.15.2
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|MW4PR10MB5776:EE_
X-MS-Office365-Filtering-Correlation-Id: 516b64da-a57e-484c-feac-08df05daacb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: Bq6GIj5/zUe/5dORnaDWWhxldo+65WhVxQDupPvdeFjpW4oLcwf1uZ03zjwgV76Teyo0n5jaLLbhBlhje0bS2xWHT8GdmbQ9Zyg6K5IRbm6AuxGfUbr5XvnSf8njN+2JJrrfbWQ0BRgBPPFBOqYpHgh/++cbjZkIS6/QVn/u30Jfpv7Zj9sm3JPrDrUtbKa9Tvk8ezuz41sNt6hIBooLdEiCjcrd8Tf4OflQQHEcYHK1uGucX52eoFOkn3mYJSxPuKg68z0dz4LKi9ensffSNCzOJInvtqyo2bs9VwjM4XEswVhjyJ1t334av9j9vD9OAuUGPnrqHiAXcjhzV4qV2/Zib38u2ilhERMoj7q4bcCld4pA7aCwGXyHj8iGCDo7JRFr2SWie2MrpXhWCrnWxdiJkXYrRIW6BRX46fHD+JaSQREEVdb70VUVt0/iMmIFKApX0GymOAofWacFBscIChQ+0AW/zXIMZU1AuMt+aR1iu70nJp4dllkiGWwnsxkRrxsUXcjsQ80em2rOeteQxSDmX2HWOuL9FLomznu6iH5H2vmt+49tKZTjhN0+AN9PK4NbCyb95+3c78zD1sRKYoeeOWBfpizZoq/c5QdBYRVPS3UPkPc3SGOtawyCs0MEzeZtpVhlyLezK5/73CyQkOOeRg7DTcClzVLfqa3a9hoZJiWOMroAQkdZjrtiDzdzGpX3/1cJfU3Jytm8t+FhIw==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dkumI8QQBwcA1YxyqqvPVKd0UorrUAT5JlVk8I9M5F9JshsCP3Y8GXkMHUReFcPvecZhNEmmz3CWYF45+cGty1r+xYPvI/IeQmIv99taj6bwaqXgLKFJxbKxaFP0PHXUMUrCQS9H6FjHH0cNB/GDdvU0aKlbi5DTX7VLesOxnv5FXXlhpVCSRP8qw6HA4yXxDo/FHnxj4PME+fWE6N9a9yERqoHow0cAyw2tAFH7+zdqv2daVe0JYC3lUXoe2gY2InLjHRnQrLcthAf8lsc+HNtjNm7ZS64/Wd2rnOFc4bWS5RwJZezEtxbXr/9s3CwrV8ZK6DFjNawTfymlD9kYagyfNOJE/Isye4LZpyvORMGqyoUuVNUOsb97KTWh6hKwBV0Un+rSGgJjbhjBqe6frIkRHCG4JSfRhvA5WhGGDbC3KRg6CLrPEx9gXd2srUJ0
X-Exchange-RoutingPolicyChecked: eVrTBycOdNuV8XIFXsXmq25CxjQuRkwlWixRao6uUxcUGqbtG+eBpYv3W33d4mX0dVefngIDFIu6mWpvv0vMvqlPD8HlzItCDgJyav6AnFGF5QBmo8Ex0fXXfL+DRBkzq0jR72O8p8ynNeS3G8cpMrxr7HcRD9IDF76OXsZ5YMzBJgvjz+sb5nlB77TvPq3prSaEUA0aKfG3DGY/wVkRI12NtDx+Pg/6ZoBa87ykizkTC8wyKejL6fCEjb+1xpuKHX1+MH8J/euJT2FSqKtvQ3QAImPC+Hmwmb1ynOZfmYYDVN6heYLCzhGSIRnYLebSmAwsQS4qdJ2xg2tktM7hiw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 14:34:46.7005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 516b64da-a57e-484c-feac-08df05daacb0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5776
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDEyNiBTYWx0ZWRfX9EazN86lPRXk
 oQd8dQssrtLx0QMehxIDoNaXYrcRESpySSUd98/BbSTy4UCfKRF9G6m6KXaRrEPfOOGuHgJmZuK
 0uMIIv4EzxOiXO317FrWqOUF2U64Y9s=
X-Authority-Analysis: v=2.4 cv=KqJ9H2WN c=1 sm=1 tr=0 ts=6a92ee0d cx=c_pps
 a=+7NNu1siU3MXiwb9s73WHg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=Ztodjql3jSbGbsMq8XwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: fu0f0uIJKrPwb6oNK2mufUf3lTFoa5zr
X-Proofpoint-ORIG-GUID: fu0f0uIJKrPwb6oNK2mufUf3lTFoa5zr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDEyNiBTYWx0ZWRfXyhmpy2N0UIXc
 bwsRGSW0F9+zOGPc6cSeGntTauEFMBaBuhvxgtCo98QYKBFQnTjtptD+NCfyfAVv7YZHNBjT38n
 epWoqScDEpliO11ZxPOhG3dqipz6J6ndefNE9p4BHjXhmWvzwQ+I9Fr9LWYuA0btNt1LqOhp5e4
 0iwlcCoAqGNlf9/8ZiR4nbrI9XkdY3z/PDRiF7uCXpwrj2XGpm8FEyXKxe3+QhaT8Wa1r56tVTO
 TFBXSr1HlShCyUH1aJzfDiP9Nk0Eeg9zicWdG7v8DwlaXl12rKkRf8PRVJZwQV4f0oRNgyxVW+y
 cZbG8sEjocaistTcWCH+wf18hpIAzmqs/rmS/XezKrxykSLFRfqgTRafI53G2TnPdlKYeRrkA3S
 m6AwFbWnYgzx3G1I8IfubVi8Muj/MDFCUFEDYVvZgdj2JoHKgskQpgMJ4MT05OsJ8Y1GsyN88y5
 mbp89l7giz9xaJWAjPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-29_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608290126
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

There are some files the AM62D-EVM board depends on not claimed in the
MAINTAINERS file. Add them.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 board/ti/am62dx/MAINTAINERS | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/board/ti/am62dx/MAINTAINERS b/board/ti/am62dx/MAINTAINERS
index 71469dad34a2..a9089b07a09e 100644
--- a/board/ti/am62dx/MAINTAINERS
+++ b/board/ti/am62dx/MAINTAINERS
@@ -2,7 +2,18 @@ AUDIO-AM62D-EVM BOARD
 M:	Vignesh Raghavendra <vigneshr@ti.com>
 M:	Bryan Brattlof <bb@ti.com>
 S:	Maintained
+F:	arch/arm/dts/k3-am62d-ddr-1866mhz-32bit.dtsi
+F:	arch/arm/dts/k3-am62d-evm-binman.dtsi
+F:	arch/arm/dts/k3-am62d2-evm-u-boot.dtsi
+F:	arch/arm/dts/k3-am62d2-r5-evm.dts
+F:	arch/arm/dts/k3-am62d2-r5.dtsi
 F:	board/ti/am62dx/
 F:	configs/am62dx_evm_a53_defconfig
 F:	configs/am62dx_evm_r5_defconfig
-F:	include/configs/am62a7_evm.h
+F:	configs/am62x_a53_android.config
+F:	configs/am62x_a53_usbdfu.config
+F:	configs/am62x_a53_usbmsc.config
+F:	configs/am62x_r5_usbdfu.config
+F:	configs/am62x_r5_usbmsc.config
+F:	doc/board/ti/am62dx_evm.rst
+F:	include/configs/am62ax_evm.h

-- 
2.54.0

