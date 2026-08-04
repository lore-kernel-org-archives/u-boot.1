Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04EC2C5518F
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 14:49:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3ADD5406DD;
	Tue,  4 Aug 2026 14:49:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JSe3P5NkdfQX; Tue,  4 Aug 2026 14:49:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 16E5F406A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785854997;
	bh=jaR8pp+4mKOp3mWoZYoK5/Z8u55OF1dQD13ZQYDCr/0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ys3ePzhmWXIZJxlD51VyDvAcmKjxJs9nE9wTIR/BIxF7erKi1YLnplZ/a6I7M8Z6/
	 XlvLm4jr8M6noLeP7wCiZpjNzE2e9gUvRIMWJO1Z0FTnjiDWv4QSvR36pAlSxRPtMy
	 0HdmwI1bksDqtSVkbRFXn+Xe9uT3lf5o5scs2v3d2mvua28wfKvI/oVqTeTNx9jZbU
	 pxXu7feZobK7AghzPYeHx02HftrMGtgxxucdWwTBaZfyMyhPj8xL7s6oC8XBKwrSdp
	 x5/VjpBvOpE6ZSYGU7jCSJJVo6tRZ/qzMLfIm5MXUwh78I6Y7Xxl78cZj8L2zcDhEG
	 LWaEpA0vKC6ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 16E5F406A5;
	Tue,  4 Aug 2026 14:49:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3861C350
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:49:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1E118406A5
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:49:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9poGSCnDY_tI for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 14:49:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=afd@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B5FE540514
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B5FE540514
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B5FE540514
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:49:53 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 674DSflJ2586630; Tue, 4 Aug 2026 09:49:48 -0500
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012044.outbound.protection.outlook.com [52.101.43.44])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fufc6sb1a-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 09:49:48 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVq3faCaDiVxetot/E5qhU2cPYQgscndIDH0lfqLEHhhpeyHK7RLmYnHAAfmYEQKp/TwsT36zGL3Bssp/hpKfxME4YBdXHHNTxpW8ML9xxHdTa4cUpQLTKiji0f4XNDfBYdF2eealENyBpxMsW9EQ7X6g7E3jzcn3b95Gyg6hcF5dkZ3eZmuoYU5QxOq9AmbefwW37L6OIxTwZpt2JCH5EFFSGnvmkwprPim4nQp3GkLspFEJcmBfn52sXW+qcpSvQPwmNsjspSYmMN+flNfmUtb4TjZK5B4asaRWIrnEV8OCPXb00X3ugDEH5iotG4kHe5ZCzmDeXOLR3gD5/OJRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaR8pp+4mKOp3mWoZYoK5/Z8u55OF1dQD13ZQYDCr/0=;
 b=BOlonVU0CbkgdJHgqMmyXctqC+nW8RfHmA7mP/TMLfI5+63PCuiT41JMamt3aPY5wMJQyel5sJ4LlCUHiIbfJFMbeW7HAiVvgIlz+VWBwOf/r+IAZtPwl65AOJ8fbufUOn9jEPYICFF08eaFU8loYBnoCIE3KGD+/IQ+7rojDXmpzOMK+zIwXPErQ+1eg38YV4wRCLRLlyUyjznHpWvbq4R09MoZ1++ONVfI6xJvJcVZHj8bFBZ2AnDWoPlZncj7LQ/dzsVioP3aBHdc/Zqu5IYDqARPmna8XsSs3XEHxqbNXlqaaLtst0QCkD/bUqRixyBNGJRT0//kflLvGO8a4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=mailbox.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from CH5P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::19)
 by CH3PR10MB7529.namprd10.prod.outlook.com (2603:10b6:610:154::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 14:49:39 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::54) by CH5P221CA0006.outlook.office365.com
 (2603:10b6:610:1f2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Tue, 4
 Aug 2026 14:49:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 14:49:38 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 09:49:10 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 09:49:08 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 4 Aug 2026 09:49:08 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 674En7Z33870985;
 Tue, 4 Aug 2026 09:49:07 -0500
Message-ID: <032b1ec4-9175-496c-b3b4-f46e06bd3065@ti.com>
Date: Tue, 4 Aug 2026 09:49:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/11] doc: board: ti: correct path to tcl scripts
To: Bryan Brattlof <bb@ti.com>, <u-boot@lists.u-boot-project.org>
CC: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Anshul Dalal <anshuld@ti.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Aristo Chen
 <aristo.chen@canonical.com>, Udit Kumar <u-kumar1@ti.com>, Daniel Golle
 <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>,
 Paresh Bhagat <p-bhagat@ti.com>, Swamil Jain <s-jain1@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Shiva Tripathi
 <s-tripathi1@ti.com>, Apurva Nandan <a-nandan@ti.com>, Chintan Vankar
 <c-vankar@ti.com>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 "Marek Vasut" <marek.vasut+renesas@mailbox.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Hrushikesh Salunke <h-salunke@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>
References: <20260803-am62lx-v3-0-b4f4302b09b4@ti.com>
 <20260803-am62lx-v3-10-b4f4302b09b4@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20260803-am62lx-v3-10-b4f4302b09b4@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|CH3PR10MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e6efce2-52d6-49c3-6ac2-08def2379bb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|23010399003|1800799024|36860700016|13003099007|6133799003|22082099003|18002099003|56012099006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: 6r70ueROg3Qowqcax5q1luTFWY9E+02LpN4MvaAAM2QoCpQ550hpjcrXuNLUHeVCaCHgF36xMrOLed0XgP9WYuPAYXiBb5lV2hHfalaAU1p5V6Y0qceM8uPPsMjcXtAQE79CsKTTDcm2tugMqEqs8SMIvMdZzKDf47Vks7bF2f7UTNBKVvuWBMlA8njhjMdUW9vhM0jshWlNEok2gVcYsg2i+WtJk3QmvbsYFHbcjuIJJAMHV2Hz9evuJerrWCyu2zjD2vffhGfTYRhxIHMfZkSns8mINLG45T0qFk+bltlcPwSxlmiupTkzbKTMcRWvAkQzWoWWvjZPoaAnn2/UTkEFJ1+ZmOQ93D5tPjPcz3pyAzziSKvftwxNtzW8Uhz3JzQEp6Eoco0Pf4ZctQS0cEj3KKgFKUUDGq3CQwn4pDp6VHSocuLJbzGou2ZNiyyPklJW0rsKhaEDjpZc1x1eG3CXS8AG1/VGoub4VL62SBVKbUF9wsocnW4aG/f4zy9WE1wVvnZ1x86C7/A9QtZH62yBXk9GS4mCvHKoMmQANnV4hjekXjrFj3sUbUGVpKgM2TsEZ8enr2T+qbb9ySJ86+kFb1u6aF7q4AoQS+/H3L52FBGWdeVaLhy+hsPYPQ0w7Veir4EY34eoLARq4dKVCb4Cts0bro7whaTLk8D5qog4QO6AXvcmMuiqGPUnKy6CTdO9cleCH0/VlffDFffq4g==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(23010399003)(1800799024)(36860700016)(13003099007)(6133799003)(22082099003)(18002099003)(56012099006)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2bFqrLN8tiOAJpx+H6XUVkqTESEvucdlCr3Naomh8RbTc4vgkpqkNZNL3X5OK/bYtjhGdwl3PehMG7fuVonHdhc9VxhX1emBXa+90ocG3hiA7Tgn2NtK661J2csFvgrFfckq80g8UHC2Kf1h3upQtY6tIUgMk8J+y9yXydAVfsdyKTN965uk7P8HT26OacBeGRzcnHHR3ZuRcbzlbBCtq+I3NPnbMIXVylkkTpyodMvokZAf4TFAGOFXH5lKj2nTb1P/+Ef52TbqjeXUIcvRsj1Pt5zhxyrcQ0K2qugWOQhw/2RnxtKfOAm2htBDtBOlt01VJ8NbY45yw2hdxcOxwFokwjgSUKd8WireEBci2aJYENOdkrEPg4pxPukJnZgDFKginlj4ncBod7l/wABTSKP2dUtI15fN3T4fQAmtoJO/VbxUCGkX8vS8373sxYuk
X-Exchange-RoutingPolicyChecked: iDKU6LrDkoKDDxyrYI7Qj35rJQb2POrrFpMqVpaZpRyjpA/ZG610AwFaJu0OtdLBSp/GGbYy+FL1aFMzqEUM6CRRdY7BTat9nbUtg0FjDJjuhZOtiCmtnnCt5pSBii04t77ZZeirpsqMR+KqTVYuI69mZu58N+2ncNaqBa+u8Bqe+4HqSwRtCW8HLGVNqkBBFC4P1Az5oqM7nnxlZyG8dNbkfKUiD3IltugfbKoOLcK1eqrCjHN9st9S5u7Ak4P+w27kNUZUW9i1L7tCwZkqtHg/2PIQSYN0l+alnxjlr1XoAXTUzPEAMFpNhy+7RecKc0XTnwE3J4gbMwwrOchDDg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 14:49:38.1620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6efce2-52d6-49c3-6ac2-08def2379bb5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7529
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDEyMCBTYWx0ZWRfX9i8ETvMNfJFg
 sU+v1bTNtrBfqRVOCU+Cjet3/ZOe2VWwls+irXc7y+zl7MdlDdoIywZPpPhAXibzBD0HGj98qwg
 pObt9Y2v6msDsWqc8RXitCq9FZ48tPJLJhHg7ehWTXE87f/EqyQKLD92a8Zdz4klrHNpRPmL0Cj
 3GeCERe8dbn8XjoX7VgfLXBw5mPTT7Yynm1gUPBWs1tsI4fLyQq6KjrS7/ew3qJFHpLwSqDoQl7
 lrHIqL3jdNfuL90Z7MKbdNAfFGIbPhQwaREYVG2wGhHSplHM2Lr21cT8svswBsKINrZN3z38K3W
 Ck36SbxGWT5LlK1hFNeXxWU1DAQ6YJTLMVJgtRd8Wtpcr19wNegEmkDBZj11Ngk+w7w55mKwpCL
 u7XHm70f7bDR0gAOuf0zhYo3k9w3UIcqWfoLjrOyTEi2KLStgKi98rCl362+GlpIcwSso06ktNd
 Gw+rCCzLv9K2J+/fOhg==
X-Proofpoint-GUID: dlgOYUZLrBRhazMTAYuRtJoay1fYQVKP
X-Proofpoint-ORIG-GUID: dlgOYUZLrBRhazMTAYuRtJoay1fYQVKP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDEyMCBTYWx0ZWRfX5xbaqEpzsjJd
 f6Uvpu5fqzaJ1biW79A7FvfcRz1hqMZFOSa1pld/MxWspvKSkcpSDzIladTJPBI/D23eWbe88GQ
 ebBbnlZFu8xaSbt5cxBDnZqQAibrLls=
X-Authority-Analysis: v=2.4 cv=Va3H+lp9 c=1 sm=1 tr=0 ts=6a71fc0c cx=c_pps
 a=JJOFz727VvkGy7wKLfv01w==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=NEAV23lmAAAA:8
 a=9IA2jfHM4RPrl91XRNcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0 spamscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040120
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=jaR8pp+4mKOp3mWoZYoK5/Z8u55OF1dQD13ZQYDCr
 /0=; b=AiljVcOuoWhUxqbL2LYd8T69xaiISC+Dx6DcYGgUZFWzt50BpKg1H5R1M
 4bGN5gTx8GzOdWL/Ww1nyN3HZ12AI3iIHFlY8AQ6jElUs/4RcW9WRCp0BArYbLAk
 fIVCjB/OnmpYv0K6fiJYrR8sUork8TLGbUcaJB9bum4G+/Ps6KteCDNLA3aBUyAk
 v6HAm4gruisO440N2c9S5umZs+raobplgaMmXuom8Rdi358gRUB8B21E9lR+3a3T
 PVf5PtNuDbcTMgR47ceFL+WwIs1HLHv05jDJncrSIuvT0osRUeNquq+wsqZh6ikW
 kP87F9mQ02NmRbgssEw+LI776yZ/g==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaR8pp+4mKOp3mWoZYoK5/Z8u55OF1dQD13ZQYDCr/0=;
 b=mLnaz9YOkSBofs0a63ExnvAW+OhvGjOjTvoRRw0eQdz5s6K88rl5bHxhfgPgnAIlpg8HG2CU6RF6Stsbyw7T5pcek6lwxrTmCUxNCTXclsUQZgV4+OPjBiWGmNFe7Ekg8XUootfBGVQFpRVn41EcIvWPOyUle/kwq8x1wOMlD8A=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=AiljVcOu; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=mLnaz9YO
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/3/26 7:09 PM, Bryan Brattlof wrote:
> OpenOCD has moved where it has placed the tcl scripts for TI's reference
> boards. Update their paths to the new locations.
> 
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
> Changes in v3:
> - Kept warning about which versions of OpenOCD have the tcl scripts
> - Link to v2: https://lore.kernel.org/r/20260721-am62lx-v2-0-33ff580c267d@ti.com
> ---
>   doc/board/ti/am6254atl_sk.rst |  2 +-
>   doc/board/ti/am62ax_sk.rst    |  2 +-
>   doc/board/ti/am62dx_evm.rst   | 11 ++++++-----
>   doc/board/ti/am62px_sk.rst    | 12 +++++-------
>   doc/board/ti/am62x_sk.rst     |  2 +-
>   doc/board/ti/am64x_evm.rst    | 24 ++++++++++++++++++++++++
>   doc/board/ti/am65x_evm.rst    |  2 +-
>   doc/board/ti/j7200_evm.rst    |  2 +-
>   doc/board/ti/j721e_evm.rst    |  2 +-
>   doc/board/ti/j722s_evm.rst    |  2 +-
>   doc/board/ti/j784s4_evm.rst   |  2 +-
>   11 files changed, 43 insertions(+), 20 deletions(-)
> 
> diff --git a/doc/board/ti/am6254atl_sk.rst b/doc/board/ti/am6254atl_sk.rst
> index 18a3520b39c7..0df058aee157 100644
> --- a/doc/board/ti/am6254atl_sk.rst
> +++ b/doc/board/ti/am6254atl_sk.rst
> @@ -305,4 +305,4 @@ To start OpenOCD and connect to the board
>   
>   .. prompt:: bash $
>   
> -  openocd -f board/ti_am625evm.cfg
> +   openocd -f board/ti/am625evm.cfg
> diff --git a/doc/board/ti/am62ax_sk.rst b/doc/board/ti/am62ax_sk.rst
> index 3453ed339e7f..b04bfc991ea0 100644
> --- a/doc/board/ti/am62ax_sk.rst
> +++ b/doc/board/ti/am62ax_sk.rst
> @@ -435,4 +435,4 @@ To start OpenOCD and connect to the board
>   
>   .. prompt:: bash
>   
> -  openocd -f board/ti_am62a7evm.cfg
> +   openocd -f board/ti/am62a7evm.cfg
> diff --git a/doc/board/ti/am62dx_evm.rst b/doc/board/ti/am62dx_evm.rst
> index 0d12e3ec1476..88071b3e69d9 100644
> --- a/doc/board/ti/am62dx_evm.rst
> +++ b/doc/board/ti/am62dx_evm.rst
> @@ -237,10 +237,6 @@ detailed setup information.
>   
>   .. warning::
>   
> -  **AM62A**: OpenOCD support since August 2023 (git master)
> -
> -  **AM62D**: Uses AM62A configuration (compatible due to same core architecture)
> -
>     Until the next stable release of OpenOCD is available in your development
>     environment's distribution, it might be necessary to build OpenOCD `from the
>     source <https://github.com/openocd-org/openocd>`_.
> @@ -253,4 +249,9 @@ To start OpenOCD and connect to the board
>   
>   .. prompt:: bash
>   
> -  openocd -f board/ti/am62a7evm.cfg
> +   openocd -f board/ti/am62a7evm.cfg
> +
> +.. note::
> +
> +   The AM62D-EVM uses the same tcl configuration as the AM62A-SK due to
> +   same core architecture.
> diff --git a/doc/board/ti/am62px_sk.rst b/doc/board/ti/am62px_sk.rst
> index 44dae4afc870..9d8b5ebf38fb 100644
> --- a/doc/board/ti/am62px_sk.rst
> +++ b/doc/board/ti/am62px_sk.rst
> @@ -331,13 +331,11 @@ detailed setup information.
>   
>   .. warning::
>   
> -  **OpenOCD support after**: v0.12.0
> +   **OpenOCD support after**: v0.12.0
>   
> -  While support for the entire K3 generation including the am62xxx
> -  extended family was added before v0.12.0, the tcl scripts for the
> -  am62px have been accepted and will be available in the next release of
> -  OpenOCD. It may be necessary to build OpenOCD from source depending on
> -  the version your distribution has packaged.
> +   Until the next stable release of OpenOCD is available in your development
> +   environment's distribution, it might be necissary to build OpenOCD `from the

s/necissary/necessary

Otherwise everything else looks good,

Acked-by: Andrew Davis <afd@ti.com>

> +   source <https://github.com/openocd-org/open ocd>`_.
>   
>   .. include::  k3.rst
>       :start-after: .. k3_rst_include_start_openocd_connect_XDS110
> @@ -347,4 +345,4 @@ To start OpenOCD and connect to the board
>   
>   .. prompt:: bash
>   
> -  openocd -f board/ti_am62pevm.cfg
> +   openocd -f board/ti/am62pevm.cfg
> diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
> index ef9425035cb8..2e4923f7a7a1 100644
> --- a/doc/board/ti/am62x_sk.rst
> +++ b/doc/board/ti/am62x_sk.rst
> @@ -867,4 +867,4 @@ To start OpenOCD and connect to the board
>   
>   .. prompt:: bash $
>   
> -  openocd -f board/ti_am625evm.cfg
> +   openocd -f board/ti/am625evm.cfg
> diff --git a/doc/board/ti/am64x_evm.rst b/doc/board/ti/am64x_evm.rst
> index 65c4c456528c..6f02a1eef883 100644
> --- a/doc/board/ti/am64x_evm.rst
> +++ b/doc/board/ti/am64x_evm.rst
> @@ -227,3 +227,27 @@ https://www.ti.com/lit/pdf/spruim2 under the `Boot Mode Pins` section.
>   
>     For SW2 and SW3, the switch state in the "ON" position = 1.
>     Boot bits on SK is reversed bits to the bootmode signals
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
> +   environment's distribution, it might be necissary to build OpenOCD `from the
> +   source <https://github.com/openocd-org/open ocd>`_.
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
> diff --git a/doc/board/ti/am65x_evm.rst b/doc/board/ti/am65x_evm.rst
> index 73ceef2e531c..5f75c01ec65a 100644
> --- a/doc/board/ti/am65x_evm.rst
> +++ b/doc/board/ti/am65x_evm.rst
> @@ -321,4 +321,4 @@ To start OpenOCD and connect to the board
>   
>   .. prompt:: bash $
>   
> -  openocd -f board/ti_am654evm.cfg
> +   openocd -f board/ti/am654evm.cfg
> diff --git a/doc/board/ti/j7200_evm.rst b/doc/board/ti/j7200_evm.rst
> index 4fd2aff83547..e5c29c2bbb7b 100644
> --- a/doc/board/ti/j7200_evm.rst
> +++ b/doc/board/ti/j7200_evm.rst
> @@ -232,4 +232,4 @@ To start OpenOCD and connect to the board
>   
>   .. prompt:: bash $
>   
> -  openocd -f board/ti_j7200evm.cfg
> +   openocd -f board/ti/j7200evm.cfg
> diff --git a/doc/board/ti/j721e_evm.rst b/doc/board/ti/j721e_evm.rst
> index 41c8d4c72a8d..c3f3736e625a 100644
> --- a/doc/board/ti/j721e_evm.rst
> +++ b/doc/board/ti/j721e_evm.rst
> @@ -261,4 +261,4 @@ To start OpenOCD and connect to the board
>   
>   .. prompt:: bash $
>   
> -  openocd -f board/ti_j721eevm.cfg
> +   openocd -f board/ti/j721evm.cfg
> diff --git a/doc/board/ti/j722s_evm.rst b/doc/board/ti/j722s_evm.rst
> index 4b5cf0275940..3d11271613c7 100644
> --- a/doc/board/ti/j722s_evm.rst
> +++ b/doc/board/ti/j722s_evm.rst
> @@ -255,4 +255,4 @@ To start OpenOCD and connect to the board
>   
>   .. prompt:: bash
>   
> -  openocd -f board/ti_j722sevm.cfg
> +   openocd -f board/ti/j722sevm.cfg
> diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
> index ec82228ab908..54b4b6031f0c 100644
> --- a/doc/board/ti/j784s4_evm.rst
> +++ b/doc/board/ti/j784s4_evm.rst
> @@ -663,4 +663,4 @@ following.
>   
>   .. prompt:: bash
>   
> -  openocd -f board/ti_j784s4evm.cfg
> +   openocd -f board/ti/j784s4evm.cfg
> 

