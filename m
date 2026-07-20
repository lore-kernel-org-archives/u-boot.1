Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECACC44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 20:50:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8921B6070C;
	Mon, 20 Jul 2026 20:50:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TYPc8jIueYCb; Mon, 20 Jul 2026 20:50:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E53EB60711
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784580609;
	bh=iwXjRqJOOVpQCIGsrYT/c4pkCcAuU6zbqbNUnIixMGo=;
	h=To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=KA7QmzL4WQISfDA8rFF5GDrz9UAELXRqe9BstAiWwrEiLKFUAmcxES1oiOHKUx7XL
	 Fw7e7HKvRSxKlR8T+Okl0FyjVmStinG6UQiPBJhq2IcHjug37lGRgaSjs2rwYv9tV9
	 Rnl8qDl5S6tzeN93gH7p6cQ0BiUMA8mj9CUrCyOj++HZGythvGg4uLlDOba2MByeIy
	 67O4bxvd9/AF2GyIyhGliSXOaeJ6wI6zkar/ca1qSPuJwFszv/T3sG3bivNVkofW3O
	 STSHCTrusRMoZnYagmwgIWt0IFyfMEck3Vd4plKHdRopfH0uiwYTSHiKqkhgT9o/uC
	 NyMWynN4MqJQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E53EB60711;
	Mon, 20 Jul 2026 20:50:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DCD51142
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 20:50:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0F3D060711
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 20:50:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zD5Fk-nsDRwJ for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 20:50:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=rs@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D99616070C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D99616070C
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D99616070C
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 20:50:04 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66KJQDd71099086;
 Mon, 20 Jul 2026 15:17:45 -0500
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fhk0y3chm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 15:17:45 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EdxhOJxOyqPbbxavtQmbJerjyrBAZwv2gbjoo0f1J+RAXgcXB/Q3haVZ0nr4l57EPK1DEYaHtIBPidQqYa1aBDeAxJhyYcRu/O55vlmzDS5ia1xCn5Ci7EJ6aJmsQX1wsVQEWhKrD8H8969ge5NoKbXZ2+vrsqV7b8aj1V/7JIkuX32lWbFv+2LrQ1rkyB0Igc0jI/b56X8Ajvm18R5X35Wg6Kg4N+qlaueGznmtvZJ73Ri8CDYiOPXPLtzD35hdn2suyJkcdVHil6JYgE6Io+/GTPEa6mxBS8/DkmDQFJ8xtDHjvhhpC1de4WKErupRwlhfh30r+0j9GrUxDnGSDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwXjRqJOOVpQCIGsrYT/c4pkCcAuU6zbqbNUnIixMGo=;
 b=hlbY1L7dp+hB1K4IQRberEOYpyUksPXuOsH7BPLp+a+Xdvy/PCKBpln+oshU4nI9NXA1pPta6femPFulXWtNGGIq9F4dABnLE629vCfRHqImWZtmmCRhjJBymftvjZgb5X3O716Zzf9tIi9YoqO5CzRGeRFyRyKkAgLAhX3q5/IZJ975oljRozm6WMKtftNo5oHIfQeAyTu+Ft599WBtMUIVhaciC9abfPoFcbiG6vWrrE3Z1fD2NLHdHWgFXgnDEb1fgKGxz1Damnlm2NV00GVgVfkud4Ex+52H9D6oYIPMAbo6SRYZ4p8WrKzQVaFmjRPvxnLSr+sc7mCCEDB8lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
Received: from BN1PR13CA0028.namprd13.prod.outlook.com (2603:10b6:408:e2::33)
 by BLAPR10MB5124.namprd10.prod.outlook.com (2603:10b6:208:325::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 20:17:38 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:408:e2:cafe::46) by BN1PR13CA0028.outlook.office365.com
 (2603:10b6:408:e2::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Mon,
 20 Jul 2026 20:17:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.0 via Frontend Transport; Mon, 20 Jul 2026 20:17:37 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 20 Jul
 2026 15:17:09 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 20 Jul
 2026 15:17:09 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 20 Jul 2026 15:17:09 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66KKH96I3202983;
 Mon, 20 Jul 2026 15:17:09 -0500
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.u-boot-project.org>
Subject: [PATCHv4 2/3] k3-am62-pocketbeagle2: add initial board support
Date: Mon, 20 Jul 2026 15:16:18 -0500
Message-ID: <20260720201618.3863938-4-rs@ti.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720201618.3863938-2-rs@ti.com>
References: <20260720201618.3863938-2-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|BLAPR10MB5124:EE_
X-MS-Office365-Filtering-Correlation-Id: efb818b9-5e76-4084-5312-08dee69bf131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|13003099007|921020|6133799003|10067099003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: yKSwdKfo4qgg/d7liboLBvzqBzsygx5vxdvMQO65e1AEhSifm8HrxAQlWxkOZrnEKyFLMDffT2epBU2i+x92Yig/+cfvEH0w2JexSxGfgwf2T04n300THEVO3gEdrk0QnwKy1BffH+zuMb+4DX3QKM+r2h6VWWZXK5z4+60tVnJcteXthvBgBtTKGlsvihECmXzMUao/revoxjC+VwQ+hbg7OjQZ9bdQR8xtyastjnUFmV2gLltktw0MMtFYHTAt8/1HUK+FdTeuSsYxD2iYnRLxtLpba90qfTXBLC0h6XnU+Z7sP/cbi3j6gBHHUyTOMCVV0kU17P33qkHfjAn4zLILZq9nDb0FekMbpTfa8flQqJ3XtQg8wrR2WtkUP1JdSErM0/4zGAW/nKRkM2D9hqNhRTRVe2F1jZga4G4m9OC9RvJOlF/+XJKtmbgd7iQaXCSv3TdBv7+6KEeN4b30Tj4LpAxGJSJD4BXT8d9LyBE7t+WzCuxfWMMEaXkIBWnFWbEyzbDh8VrQWa5mwIYYGjdFdvgG1/RTs7iAoKARNTYxSQtPpj9Ci5YBBbCrcDmRolPyAqC58UE5mafyRSfh4NvAdzjVfIZma9dhOOTs15l/b1FSeSBJVTRtoldFtyVZdt0QA9YHzELwONHhIaawWSgcJZw9kNoMjgBfkxGDqFO/dA/3I8cCCQJpIi0z73tR
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(13003099007)(921020)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: t6AORoulpStxLxeb7lBGnAe3zFfbKNum38PLHMtyZ66oLMkrohoVy4Iap+N7402y+ep75rwZFdi4tAfQT9lYslgeO9yGzp5+fZFHPqRR/60yYGkkKOS1f05yEhOIWx7NH17BNm128ThM80y/PpEGr7Xo759BHGl9A+YFAKANt5g4WxSr9jyUWqQ9l+2tScu1Fd2dVKC+zAtlfGsmeQRYNS6FnpHJAoD42Le6sBxkwe32UwmMYC4DJSwWf6ETKRzL83NJqTj9aTmhOiQ4WxWwT+jtDyNSGQmMzR7w2ANrw+dtpF/7H22056W6ICYUeHDOysjd4KlD1kgUTyxhrfJn/Rz1c7NvEU3UWTfZRTH/rVWIpq5BrE+0xx66dDTiEaW/g1yQJpAwZfFqYqGn+POk/wkNO5yh8yIeo33+Xbq9pE8AgpyyB/1g+oW9lL3Blwcd
X-Exchange-RoutingPolicyChecked: mRlKrkR8nMBrmzuFba3DTWqhAl6DP1Mu1orbXl3OFmYNXnu5HnJQPPAeMH+VBBJb/ee8RyC/HuJBk4lq0YJ3GX+h5eUFBtYFDTPz7ifpTpdcRnVGRIR4n8DWZNMBA++F2wksC8UZDR7UIYPDznDJdxuctbYsnf1Bx4X8/rs0Wpaax5O8smZGJOFwEh/V04JIWE8rdy7ZzB48/0jGD/j90NSNUvYOyLUzCQEL3pSTkUuN0Js0X+9FAZgoUW4DDpG1F9Q7FJ3UgQzg5eZcTe9d9OmwtkRXLyOuRS2aSmOmtu+rnpmJGNOkFxYVYnzh3SELmYO3U1fMsm6VjMnzDARDCw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 20:17:37.2828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efb818b9-5e76-4084-5312-08dee69bf131
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5124
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIyMSBTYWx0ZWRfX1IpoAVf2qyUB
 J4/7MSjcqPD10dbDrqMXDudOzU/7e+hvXLRv+7z4AvK/vF7Qp0JwsKs6w0mYOQFyzFS311We2Fh
 JjRRfpdjdSoeVwo4KbpTkrWpYJ93L/sqqph5dcqCnbfyC4IK8zDhyYgePIBPZAtfHRa91s2uLnS
 48Ly95eULPwvAHbzubho0zG8jd6rzfUEQ+jf8O+WaDwh896QfYq5fJs3EPKHE5KFDL2xkXsRTgk
 ZBFKffNZ+iwy0cWNRNhsQXL5fiYb8uQ+ItK5byXh5SXHaX+d03MM/NBdM2XeiuzLdbCtYaLjC/V
 I/pinw5o9pXvBgxmlZqmKOVSMcAeg3am83LIitO0rvtxx/5+m51NvhwERyShyL/eid80L9ohdko
 TT4c35VitfybbyYFGTol7X63NwOyfwU4IDnGEoikrcC8Ll6soV/szXFb1c2IszcfYPKhxv2FrOz
 +/aa0oYfNHwMh+SRecQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIyMSBTYWx0ZWRfXw09TeCwJeyQr
 QhB6hLQkUeFEyBrRRThQr3pNwr82zmZDCpyqgGDmCLwpzp+JMpBqZh9msjjJpA8naqytXKW57Fj
 ZPCXCUQW/xLQLK8UlgkYqgqnTUGTdpo=
X-Proofpoint-ORIG-GUID: tCcwFPc4vPWUR18cFRosEhx5gYVNzHzX
X-Proofpoint-GUID: tCcwFPc4vPWUR18cFRosEhx5gYVNzHzX
X-Authority-Analysis: v=2.4 cv=J8KaKgnS c=1 sm=1 tr=0 ts=6a5e8269 cx=c_pps
 a=w9jTARCbdo3hRO6w7Rsibg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=lLZmtIKjAAAA:8 a=fGhLjsSNAAAA:8 a=xVOUUHzFAAAA:8
 a=Xu_aML22AAAA:8 a=-Hh7AOtFAAAA:8 a=P_npcX-5AAAA:8 a=H6WxVz_VAAAA:8
 a=gDy_HrBUAAAA:8 a=pGLkceISAAAA:8 a=k-42gJp3AAAA:8 a=VGfogEpqwgMVr7Nd1rgA:9
 a=_uzCxg_ASKWMSo-A:21 a=q5Nj8NTjyn2D8kUwajRn:22 a=LYKFdyShAPKLkGq8p7WX:22
 a=BFkDlhTjP3qpOTzr41qL:22 a=o_LaMfWX3WolavuFUIfu:22 a=MAQyDH-hdSxjqfOHZXT9:22
 a=jMANWmVHNjNFLZSzJ4yp:22 a=ejRDv7XJuw7nbi7PrmUL:22 a=D-VuSo3WVVYS0uspT_Bm:22
 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 bulkscore=0 priorityscore=1501 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200221
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=iwXjRqJOOVpQCIGsrYT/c4pkCcAuU6zbqbNUnIixM
 Go=; b=ofTdZ6ZtM9Idp1eWRUP1i2UA928QEYZPxr8dO+mjtgMl+6aSTHLmTSry5
 8fICejvHxyvBhp7ejZxr+IIYL6olV4j0mHDV5HngJaB3zuK9/Pq32eEJtYRK5juC
 wAbxv1vfsZ2sApNFBN18XNXxeIx71ztUx3NeierkHRFqN7reFzLjmbslRhLEC4AI
 Nx02UeOyNaWBdJ2uDYAhjfLKhYrDLNPY+1fRKg4m6Fq8jHFoFg6fifGQbN/10GJh
 Y0qJdtqKR/tMqZUzJisJjxeX76GF7GOJaQigfvvRSlkvNdSxy4/INqtGiOyVST4s
 RU+okqmaqGkvsz8zplsJIfk9nhRPw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwXjRqJOOVpQCIGsrYT/c4pkCcAuU6zbqbNUnIixMGo=;
 b=VSF69A1hCF2/dcJPM/QDbY0laSTFIEZFjxTZuPMrI51VdZYJI0yga+AXzntwUjBht1tCuXT6+xywW7IbsJuSmxq5sSBM8nkaNJgyiq+qBsaeseTUvPQVov9aKrZRJ2bVFqnideHIs29i3QatBrLA8u5fjHDHpR3ifeA9PWqOMGQ=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=ofTdZ6Zt; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=VSF69A1h
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
From: Randolph Sapp via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: rs@ti.com
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Randolph Sapp <rs@ti.com>

Add initial board support for the PocketBeagle 2, based on Robert Nelson
and Bryan Brattlof's work. Unify all debug consoles to main_uart6. Use
DDR config v10.32 from our sysconfig tool [1] for Kingston's memory [2],
(4Gb Desnity with a CL of 11 and CWL of 9). Add support for the
SPL_TEXT_BASE config parameter. Ensure all files have a summary and SPDX
identifier.

Also, use board_get_usable_ram_top() to fixup our relocaddr since
otherwise the u-boot stack reservation will collide with the
wkup_r5fss0_core0_memory_region.

[1] https://dev.ti.com/sysconfig
[2] https://mm.digikey.com/Volume0/opasdata/d220001/medias/docus/6465/D2516AN9EXGXN-TU.pdf

Signed-off-by: Randolph Sapp <rs@ti.com>
---
v3:
	- Use board_get_usable_ram_top
---
 arch/arm/dts/Makefile                         |   1 +
 ...> k3-am62-pocketbeagle2-ddr4-1600MTs.dtsi} |  92 +++---
 ...dtsi => k3-am62-pocketbeagle2-u-boot.dtsi} | 160 ++++++----
 arch/arm/dts/k3-am62-r5-pocketbeagle2.dts     |  35 +++
 arch/arm/mach-k3/am62x/Kconfig                |   1 +
 board/beagle/pocketbeagle2/Kconfig            |  60 ++++
 board/beagle/pocketbeagle2/MAINTAINERS        |  10 +
 board/beagle/pocketbeagle2/Makefile           |   9 +
 .../board-cfg.yaml                            |   0
 .../{beagleplay => pocketbeagle2}/pm-cfg.yaml |   0
 board/beagle/pocketbeagle2/pocketbeagle2.c    |  58 ++++
 .../pocketbeagle2/pocketbeagle2.env}          |  20 +-
 .../pocketbeagle2}/rm-cfg.yaml                |   4 +-
 .../sec-cfg.yaml                              |   0
 ...onfig => am62_pocketbeagle2_a53_defconfig} |  24 +-
 ...config => am62_pocketbeagle2_r5_defconfig} |  11 +-
 doc/board/beagle/am62_pocketbeagle2.rst       | 279 ++++++++++++++++++
 doc/board/beagle/index.rst                    |   1 +
 .../configs/{beagley_ai.h => pocketbeagle2.h} |   8 +-
 19 files changed, 636 insertions(+), 137 deletions(-)
 copy arch/arm/dts/{k3-am62x-sk-ddr4-1600MTs.dtsi => k3-am62-pocketbeagle2-ddr4-1600MTs.dtsi} (97%)
 copy arch/arm/dts/{k3-am67a-beagley-ai-u-boot.dtsi => k3-am62-pocketbeagle2-u-boot.dtsi} (53%)
 create mode 100644 arch/arm/dts/k3-am62-r5-pocketbeagle2.dts
 create mode 100644 board/beagle/pocketbeagle2/Kconfig
 create mode 100644 board/beagle/pocketbeagle2/MAINTAINERS
 create mode 100644 board/beagle/pocketbeagle2/Makefile
 copy board/beagle/{beagleplay => pocketbeagle2}/board-cfg.yaml (100%)
 copy board/beagle/{beagleplay => pocketbeagle2}/pm-cfg.yaml (100%)
 create mode 100644 board/beagle/pocketbeagle2/pocketbeagle2.c
 copy board/{ti/am62x/am62x.env => beagle/pocketbeagle2/pocketbeagle2.env} (64%)
 copy board/{phytec/phycore_am62x => beagle/pocketbeagle2}/rm-cfg.yaml (99%)
 copy board/beagle/{beagleplay => pocketbeagle2}/sec-cfg.yaml (100%)
 copy configs/{am62x_beagleplay_a53_defconfig => am62_pocketbeagle2_a53_defconfig} (87%)
 copy configs/{am62x_beagleplay_r5_defconfig => am62_pocketbeagle2_r5_defconfig} (89%)
 create mode 100644 doc/board/beagle/am62_pocketbeagle2.rst
 copy include/configs/{beagley_ai.h => pocketbeagle2.h} (57%)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 25234697e6ae..d93346b8eb92 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1054,6 +1054,7 @@ dtb-$(CONFIG_SOC_K3_AM642) += k3-am642-r5-evm.dtb \
 			      k3-am642-r5-phycore-som-2gb.dtb
 
 dtb-$(CONFIG_SOC_K3_AM625) += k3-am625-r5-sk.dtb \
+			      k3-am62-r5-pocketbeagle2.dtb \
 			      k3-am625-r5-beagleplay.dtb \
 			      k3-am625-verdin-r5.dtb \
 			      k3-am625-r5-phycore-som-2gb.dtb
diff --git a/arch/arm/dts/k3-am62x-sk-ddr4-1600MTs.dtsi b/arch/arm/dts/k3-am62-pocketbeagle2-ddr4-1600MTs.dtsi
similarity index 97%
copy from arch/arm/dts/k3-am62x-sk-ddr4-1600MTs.dtsi
copy to arch/arm/dts/k3-am62-pocketbeagle2-ddr4-1600MTs.dtsi
index 4afa68a67394..455a55f2c0d8 100644
--- a/arch/arm/dts/k3-am62x-sk-ddr4-1600MTs.dtsi
+++ b/arch/arm/dts/k3-am62-pocketbeagle2-ddr4-1600MTs.dtsi
@@ -2,20 +2,22 @@
 /*
  * This file was generated with the
  * AM623/AM625 SysConfig DDR Configuration Tool for AM64x, AM625, AM623, AM62Ax, AM62Px, AM62Dx, AM62Lx v0.10.32
- * Fri Jan 30 2026 13:45:31 GMT+0530 (India Standard Time)
+ * Mon Jan 26 2026 10:31:36 GMT-0600 (Central Standard Time)
  * DDR Type: DDR4
  * Frequency = 800MHz (1600MTs)
- * Density: 16Gb
+ * Density: 4Gb
  * Number of Ranks: 1
 */
 
+
 #define DDRSS_PLL_FHS_CNT 6
 #define DDRSS_PLL_FREQUENCY_1 400000000
 #define DDRSS_PLL_FREQUENCY_2 400000000
-#define DDRSS_SDRAM_IDX 15
+#define DDRSS_SDRAM_IDX 13
 #define DDRSS_REGION_IDX 16
 #define DDRSS_TOOL_VERSION "0.10.32"
 
+
 #define DDRSS_CTL_0_DATA 0x00000A00
 #define DDRSS_CTL_1_DATA 0x00000000
 #define DDRSS_CTL_2_DATA 0x00000000
@@ -54,11 +56,11 @@
 #define DDRSS_CTL_35_DATA 0x00000000
 #define DDRSS_CTL_36_DATA 0x00000000
 #define DDRSS_CTL_37_DATA 0x00000000
-#define DDRSS_CTL_38_DATA 0x0000091C
+#define DDRSS_CTL_38_DATA 0x00000916
 #define DDRSS_CTL_39_DATA 0x18181818
-#define DDRSS_CTL_40_DATA 0x0000091C
+#define DDRSS_CTL_40_DATA 0x00000916
 #define DDRSS_CTL_41_DATA 0x18181818
-#define DDRSS_CTL_42_DATA 0x0000091C
+#define DDRSS_CTL_42_DATA 0x00000916
 #define DDRSS_CTL_43_DATA 0x18181818
 #define DDRSS_CTL_44_DATA 0x05050404
 #define DDRSS_CTL_45_DATA 0x00002706
@@ -220,22 +222,22 @@
 #define DDRSS_CTL_201_DATA 0x00000000
 #define DDRSS_CTL_202_DATA 0x00000000
 #define DDRSS_CTL_203_DATA 0x00000000
-#define DDRSS_CTL_204_DATA 0x00042400
+#define DDRSS_CTL_204_DATA 0x00041000
 #define DDRSS_CTL_205_DATA 0x00000301
 #define DDRSS_CTL_206_DATA 0x00000000
-#define DDRSS_CTL_207_DATA 0x00000424
+#define DDRSS_CTL_207_DATA 0x00000410
 #define DDRSS_CTL_208_DATA 0x00000301
 #define DDRSS_CTL_209_DATA 0x00000000
-#define DDRSS_CTL_210_DATA 0x00000424
+#define DDRSS_CTL_210_DATA 0x00000410
 #define DDRSS_CTL_211_DATA 0x00000301
 #define DDRSS_CTL_212_DATA 0x00000000
-#define DDRSS_CTL_213_DATA 0x00000424
+#define DDRSS_CTL_213_DATA 0x00000410
 #define DDRSS_CTL_214_DATA 0x00000301
 #define DDRSS_CTL_215_DATA 0x00000000
-#define DDRSS_CTL_216_DATA 0x00000424
+#define DDRSS_CTL_216_DATA 0x00000410
 #define DDRSS_CTL_217_DATA 0x00000301
 #define DDRSS_CTL_218_DATA 0x00000000
-#define DDRSS_CTL_219_DATA 0x00000424
+#define DDRSS_CTL_219_DATA 0x00000410
 #define DDRSS_CTL_220_DATA 0x00000301
 #define DDRSS_CTL_221_DATA 0x00000000
 #define DDRSS_CTL_222_DATA 0x00000000
@@ -333,8 +335,8 @@
 #define DDRSS_CTL_314_DATA 0x00000000
 #define DDRSS_CTL_315_DATA 0x00000100
 #define DDRSS_CTL_316_DATA 0x01010000
-#define DDRSS_CTL_317_DATA 0x00000000
-#define DDRSS_CTL_318_DATA 0x3FFF0000
+#define DDRSS_CTL_317_DATA 0x00000202
+#define DDRSS_CTL_318_DATA 0x0FFF0000
 #define DDRSS_CTL_319_DATA 0x000FFF00
 #define DDRSS_CTL_320_DATA 0xFFFFFFFF
 #define DDRSS_CTL_321_DATA 0x00FFFF00
@@ -391,8 +393,8 @@
 #define DDRSS_CTL_372_DATA 0x06060806
 #define DDRSS_CTL_373_DATA 0x00010101
 #define DDRSS_CTL_374_DATA 0x02000000
-#define DDRSS_CTL_375_DATA 0x05020101
-#define DDRSS_CTL_376_DATA 0x00000505
+#define DDRSS_CTL_375_DATA 0x02020101
+#define DDRSS_CTL_376_DATA 0x00000202
 #define DDRSS_CTL_377_DATA 0x02020200
 #define DDRSS_CTL_378_DATA 0x02020202
 #define DDRSS_CTL_379_DATA 0x02020202
@@ -408,7 +410,7 @@
 #define DDRSS_CTL_389_DATA 0x00000200
 #define DDRSS_CTL_390_DATA 0x0000DB60
 #define DDRSS_CTL_391_DATA 0x0001E780
-#define DDRSS_CTL_392_DATA 0x080D0302
+#define DDRSS_CTL_392_DATA 0x050A0302
 #define DDRSS_CTL_393_DATA 0x001E0506
 #define DDRSS_CTL_394_DATA 0x000030C0
 #define DDRSS_CTL_395_DATA 0x00000200
@@ -417,7 +419,7 @@
 #define DDRSS_CTL_398_DATA 0x00000200
 #define DDRSS_CTL_399_DATA 0x0000DB60
 #define DDRSS_CTL_400_DATA 0x0001E780
-#define DDRSS_CTL_401_DATA 0x080D0302
+#define DDRSS_CTL_401_DATA 0x050A0302
 #define DDRSS_CTL_402_DATA 0x001E0506
 #define DDRSS_CTL_403_DATA 0x000030C0
 #define DDRSS_CTL_404_DATA 0x00000200
@@ -426,7 +428,7 @@
 #define DDRSS_CTL_407_DATA 0x00000200
 #define DDRSS_CTL_408_DATA 0x0000DB60
 #define DDRSS_CTL_409_DATA 0x0001E780
-#define DDRSS_CTL_410_DATA 0x080D0302
+#define DDRSS_CTL_410_DATA 0x050A0302
 #define DDRSS_CTL_411_DATA 0x00000506
 #define DDRSS_CTL_412_DATA 0x00000000
 #define DDRSS_CTL_413_DATA 0x0302000A
@@ -516,7 +518,7 @@
 #define DDRSS_PI_74_DATA 0x00000000
 #define DDRSS_PI_75_DATA 0x00000005
 #define DDRSS_PI_76_DATA 0x01000000
-#define DDRSS_PI_77_DATA 0x04000100
+#define DDRSS_PI_77_DATA 0x04020100
 #define DDRSS_PI_78_DATA 0x00020000
 #define DDRSS_PI_79_DATA 0x00010002
 #define DDRSS_PI_80_DATA 0x00000001
@@ -606,14 +608,14 @@
 #define DDRSS_PI_164_DATA 0x00007800
 #define DDRSS_PI_165_DATA 0x00780078
 #define DDRSS_PI_166_DATA 0x00141414
-#define DDRSS_PI_167_DATA 0x00000036
-#define DDRSS_PI_168_DATA 0x00000036
-#define DDRSS_PI_169_DATA 0x00040036
+#define DDRSS_PI_167_DATA 0x00000033
+#define DDRSS_PI_168_DATA 0x00000033
+#define DDRSS_PI_169_DATA 0x00040033
 #define DDRSS_PI_170_DATA 0x04000400
 #define DDRSS_PI_171_DATA 0xC8000009
-#define DDRSS_PI_172_DATA 0x0000091C
-#define DDRSS_PI_173_DATA 0x00091CC8
-#define DDRSS_PI_174_DATA 0x001CC800
+#define DDRSS_PI_172_DATA 0x00000916
+#define DDRSS_PI_173_DATA 0x000916C8
+#define DDRSS_PI_174_DATA 0x0016C800
 #define DDRSS_PI_175_DATA 0x00000118
 #define DDRSS_PI_176_DATA 0x00001860
 #define DDRSS_PI_177_DATA 0x00000118
@@ -626,14 +628,14 @@
 #define DDRSS_PI_184_DATA 0x01080108
 #define DDRSS_PI_185_DATA 0x00000108
 #define DDRSS_PI_186_DATA 0x00000000
-#define DDRSS_PI_187_DATA 0x05000000
-#define DDRSS_PI_188_DATA 0x01010505
+#define DDRSS_PI_187_DATA 0x02000000
+#define DDRSS_PI_188_DATA 0x01010202
 #define DDRSS_PI_189_DATA 0x01010101
 #define DDRSS_PI_190_DATA 0x00181818
 #define DDRSS_PI_191_DATA 0x00000000
 #define DDRSS_PI_192_DATA 0x00000000
-#define DDRSS_PI_193_DATA 0x09000000
-#define DDRSS_PI_194_DATA 0x06060909
+#define DDRSS_PI_193_DATA 0x06000000
+#define DDRSS_PI_194_DATA 0x06060606
 #define DDRSS_PI_195_DATA 0x03030306
 #define DDRSS_PI_196_DATA 0x00000000
 #define DDRSS_PI_197_DATA 0x00000000
@@ -661,15 +663,15 @@
 #define DDRSS_PI_219_DATA 0x001600C8
 #define DDRSS_PI_220_DATA 0x010100C8
 #define DDRSS_PI_221_DATA 0x00001701
-#define DDRSS_PI_222_DATA 0x1F0F0053
-#define DDRSS_PI_223_DATA 0x05000001
-#define DDRSS_PI_224_DATA 0x00170A09
-#define DDRSS_PI_225_DATA 0x1F0F0053
-#define DDRSS_PI_226_DATA 0x05000001
-#define DDRSS_PI_227_DATA 0x00170A09
-#define DDRSS_PI_228_DATA 0x1F0F0053
-#define DDRSS_PI_229_DATA 0x05000001
-#define DDRSS_PI_230_DATA 0x00010A09
+#define DDRSS_PI_222_DATA 0x1F0F0050
+#define DDRSS_PI_223_DATA 0x02000001
+#define DDRSS_PI_224_DATA 0x00170A06
+#define DDRSS_PI_225_DATA 0x1F0F0050
+#define DDRSS_PI_226_DATA 0x02000001
+#define DDRSS_PI_227_DATA 0x00170A06
+#define DDRSS_PI_228_DATA 0x1F0F0050
+#define DDRSS_PI_229_DATA 0x02000001
+#define DDRSS_PI_230_DATA 0x00010A06
 #define DDRSS_PI_231_DATA 0x0C0B0700
 #define DDRSS_PI_232_DATA 0x000D0605
 #define DDRSS_PI_233_DATA 0x0000C570
@@ -736,7 +738,7 @@
 #define DDRSS_PI_294_DATA 0x01000000
 #define DDRSS_PI_295_DATA 0x00020201
 #define DDRSS_PI_296_DATA 0x00000000
-#define DDRSS_PI_297_DATA 0x00000424
+#define DDRSS_PI_297_DATA 0x00000410
 #define DDRSS_PI_298_DATA 0x00000301
 #define DDRSS_PI_299_DATA 0x00000000
 #define DDRSS_PI_300_DATA 0x00000000
@@ -744,7 +746,7 @@
 #define DDRSS_PI_302_DATA 0x00001400
 #define DDRSS_PI_303_DATA 0x00000493
 #define DDRSS_PI_304_DATA 0x00000000
-#define DDRSS_PI_305_DATA 0x00000424
+#define DDRSS_PI_305_DATA 0x00000410
 #define DDRSS_PI_306_DATA 0x00000301
 #define DDRSS_PI_307_DATA 0x00000000
 #define DDRSS_PI_308_DATA 0x00000000
@@ -752,7 +754,7 @@
 #define DDRSS_PI_310_DATA 0x00001400
 #define DDRSS_PI_311_DATA 0x00000493
 #define DDRSS_PI_312_DATA 0x00000000
-#define DDRSS_PI_313_DATA 0x00000424
+#define DDRSS_PI_313_DATA 0x00000410
 #define DDRSS_PI_314_DATA 0x00000301
 #define DDRSS_PI_315_DATA 0x00000000
 #define DDRSS_PI_316_DATA 0x00000000
@@ -760,7 +762,7 @@
 #define DDRSS_PI_318_DATA 0x00001400
 #define DDRSS_PI_319_DATA 0x00000493
 #define DDRSS_PI_320_DATA 0x00000000
-#define DDRSS_PI_321_DATA 0x00000424
+#define DDRSS_PI_321_DATA 0x00000410
 #define DDRSS_PI_322_DATA 0x00000301
 #define DDRSS_PI_323_DATA 0x00000000
 #define DDRSS_PI_324_DATA 0x00000000
@@ -768,7 +770,7 @@
 #define DDRSS_PI_326_DATA 0x00001400
 #define DDRSS_PI_327_DATA 0x00000493
 #define DDRSS_PI_328_DATA 0x00000000
-#define DDRSS_PI_329_DATA 0x00000424
+#define DDRSS_PI_329_DATA 0x00000410
 #define DDRSS_PI_330_DATA 0x00000301
 #define DDRSS_PI_331_DATA 0x00000000
 #define DDRSS_PI_332_DATA 0x00000000
@@ -776,7 +778,7 @@
 #define DDRSS_PI_334_DATA 0x00001400
 #define DDRSS_PI_335_DATA 0x00000493
 #define DDRSS_PI_336_DATA 0x00000000
-#define DDRSS_PI_337_DATA 0x00000424
+#define DDRSS_PI_337_DATA 0x00000410
 #define DDRSS_PI_338_DATA 0x00000301
 #define DDRSS_PI_339_DATA 0x00000000
 #define DDRSS_PI_340_DATA 0x00000000
diff --git a/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi b/arch/arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi
similarity index 53%
copy from arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
copy to arch/arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi
index 0e810e7f492d..452161115318 100644
--- a/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
+++ b/arch/arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi
@@ -1,20 +1,53 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Common AM67A BeagleY-AI dts file for SPLs
+ * AM625 PocketBeagle 2 dts file for SPLs
+ * https://www.beagleboard.org/boards/pocketbeagle-2
  *
- * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
- * Copyright (C) 2024 Robert Nelson, BeagleBoard.org Foundation
+ * Copyright (C) 2024-2025 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2024-2025 Robert Nelson, BeagleBoard.org Foundation
  */
 
 #include "k3-binman.dtsi"
 
 / {
-	chosen {
-		stdout-path = "serial2:115200n8";
-		tick-timer = &main_timer0;
+	/* Keep the LEDs on by default to indicate life */
+	leds {
+		led-1 {
+			label = "led-1";
+			default-state = "on";
+		};
+
+		led-2 {
+			label = "led-2";
+			default-state = "on";
+		};
+
+		led-3 {
+			label = "led-3";
+			default-state = "on";
+		};
+
+		led-4 {
+			label = "led-4";
+			default-state = "on";
+		};
 	};
 };
 
+&main_bcdma {
+	reg = <0x00 0x485c0100 0x00 0x100>,
+	      <0x00 0x4c000000 0x00 0x20000>,
+	      <0x00 0x4a820000 0x00 0x20000>,
+	      <0x00 0x4aa40000 0x00 0x20000>,
+	      <0x00 0x4bc00000 0x00 0x100000>,
+	      <0x00 0x48600000 0x00 0x8000>,
+	      <0x00 0x484a4000 0x00 0x2000>,
+	      <0x00 0x484c2000 0x00 0x2000>;
+	reg-names = "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt",
+		    "cfg", "tchan", "rchan";
+	bootph-all;
+};
+
 &main_pktdma {
 	reg = <0x00 0x485c0000 0x00 0x100>,
 	      <0x00 0x4a800000 0x00 0x20000>,
@@ -24,44 +57,32 @@
 	      <0x00 0x484a0000 0x00 0x4000>,
 	      <0x00 0x484c0000 0x00 0x2000>,
 	      <0x00 0x48430000 0x00 0x4000>;
-	reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt",
-		    "cfg", "tchan", "rchan", "rflow";
-};
-
-&dmsc {
-	bootph-pre-ram;
-	k3_sysreset: sysreset-controller {
-		compatible = "ti,sci-sysreset";
-		bootph-pre-ram;
-	};
-};
-
-&usbss0 {
-	bootph-pre-ram;
+	reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt", "cfg",
+		    "tchan", "rchan", "rflow";
+	bootph-all;
 };
 
-&usb0 {
-	dr_mode = "peripheral";
-	bootph-pre-ram;
+&cpsw3g {
+	status = "disabled";
 };
 
-&usbss1 {
+&cpsw_port1 {
 	status = "disabled";
 };
 
-&usb1 {
+&cpsw_port2 {
 	status = "disabled";
 };
 
-&main_gpio1 {
+&main_uart6_pins_default {
 	bootph-all;
 };
 
-#if IS_ENABLED(CONFIG_TARGET_J722S_R5_BEAGLEY_AI)
+#if IS_ENABLED(CONFIG_TARGET_AM62X_R5_POCKETBEAGLE2)
 
 &binman {
-	tiboot3-j722s-hs-evm.bin {
-		filename = "tiboot3-j722s-hs-evm.bin";
+	tiboot3-am62x-hs-evm.bin {
+		filename = "tiboot3-am62x-hs-evm.bin";
 		ti-secure-rom {
 			content = <&u_boot_spl>, <&ti_fs_enc>, <&combined_tifs_cfg>,
 				  <&combined_dm_cfg>, <&sysfw_inner_cert>;
@@ -78,7 +99,7 @@
 			load = <CONFIG_SPL_TEXT_BASE>;
 			load-sysfw = <0x40000>;
 			load-sysfw-data = <0x67000>;
-			load-dm-data = <0x43c7a800>;
+			load-dm-data = <0x43c3a800>;
 		};
 
 		u_boot_spl: u-boot-spl {
@@ -86,8 +107,9 @@
 		};
 
 		ti_fs_enc: ti-fs-enc.bin {
-			filename = "ti-sysfw/ti-fs-firmware-j722s-hs-enc.bin";
+			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-enc.bin";
 			type = "blob-ext";
+			optional;
 		};
 
 		combined_tifs_cfg: combined-tifs-cfg.bin {
@@ -96,8 +118,9 @@
 		};
 
 		sysfw_inner_cert: sysfw-inner-cert {
-			filename = "ti-sysfw/ti-fs-firmware-j722s-hs-cert.bin";
+			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-cert.bin";
 			type = "blob-ext";
+			optional;
 		};
 
 		combined_dm_cfg: combined-dm-cfg.bin {
@@ -108,8 +131,8 @@
 };
 
 &binman {
-	tiboot3-j722s-hs-fs-evm.bin {
-		filename = "tiboot3-j722s-hs-fs-evm.bin";
+	tiboot3-am62x-hs-fs-evm.bin {
+		filename = "tiboot3-am62x-hs-fs-evm.bin";
 		symlink = "tiboot3.bin";
 
 		ti-secure-rom {
@@ -128,7 +151,7 @@
 			load = <CONFIG_SPL_TEXT_BASE>;
 			load-sysfw = <0x40000>;
 			load-sysfw-data = <0x67000>;
-			load-dm-data = <0x43c7a800>;
+			load-dm-data = <0x43c3a800>;
 		};
 
 		u_boot_spl_fs: u-boot-spl {
@@ -136,8 +159,9 @@
 		};
 
 		ti_fs_enc_fs: ti-fs-enc.bin {
-			filename = "ti-sysfw/ti-fs-firmware-j722s-hs-fs-enc.bin";
+			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-enc.bin";
 			type = "blob-ext";
+			optional;
 		};
 
 		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
@@ -146,8 +170,9 @@
 		};
 
 		sysfw_inner_cert_fs: sysfw-inner-cert {
-			filename = "ti-sysfw/ti-fs-firmware-j722s-hs-fs-cert.bin";
+			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-cert.bin";
 			type = "blob-ext";
+			optional;
 		};
 
 		combined_dm_cfg_fs: combined-dm-cfg.bin {
@@ -156,12 +181,9 @@
 		};
 	};
 };
-#endif /* CONFIG_TARGET_J722S_R5_BEAGLEY_AI */
+#endif /* CONFIG_TARGET_AM62X_R5_POCKETBEAGLE2 */
 
-#if IS_ENABLED(CONFIG_TARGET_J722S_A53_BEAGLEY_AI)
-
-#define SPL_BEAGLEY_AI_DTB "spl/dts/ti/k3-am67a-beagley-ai.dtb"
-#define BEAGLEY_AI_DTB "u-boot.dtb"
+#if IS_ENABLED(CONFIG_TARGET_AM62X_A53_POCKETBEAGLE2)
 
 &binman {
 	ti-spl {
@@ -169,6 +191,32 @@
 
 		fit {
 			images {
+				atf {
+					description = "ARM Trusted Firmware";
+					type = "firmware";
+					arch = "arm64";
+					compression = "none";
+					os = "arm-trusted-firmware";
+					load = <CONFIG_K3_ATF_LOAD_ADDR>;
+					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
+					atf-bl31 {
+						filename = "bl31.bin";
+					};
+				};
+
+				tee {
+					description = "OP-TEE";
+					type = "tee";
+					arch = "arm64";
+					compression = "none";
+					os = "tee";
+					load = <CONFIG_K3_OPTEE_LOAD_ADDR>;
+					entry = <CONFIG_K3_OPTEE_LOAD_ADDR>;
+					tee-os {
+						filename = "tee-raw.bin";
+					};
+				};
+
 				dm {
 					ti-secure {
 						content = <&dm>;
@@ -176,34 +224,33 @@
 					};
 
 					dm: ti-dm {
-						filename = "ti-dm/j722s/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+						optional;
 					};
 				};
 
 				fdt-0 {
-					description = "k3-am67a-beagley-ai";
+					description = "k3-am62-pocketbeagle2";
 					type = "flat_dt";
 					arch = "arm";
 					compression = "none";
 
 					ti-secure {
-						content = <&spl_beagley_ai_dtb>;
+						content = <&spl_pocketbeagle2_dtb>;
 						keyfile = "custMpk.pem";
 					};
 
-					spl_beagley_ai_dtb: blob-ext {
-						filename = "spl/dts/ti/k3-am67a-beagley-ai.dtb";
+					spl_pocketbeagle2_dtb: blob-ext {
+						filename = "spl/dts/ti/k3-am62-pocketbeagle2.dtb";
 					};
-
 				};
-
 			};
 
 			configurations {
 				default = "conf-0";
 
 				conf-0 {
-					description = "k3-am67a-beagley-ai";
+					description = "k3-am62-pocketbeagle2";
 					firmware = "atf";
 					loadables = "tee", "dm", "spl";
 					fdt = "fdt-0";
@@ -220,21 +267,21 @@
 		fit {
 			images {
 				uboot {
-					description = "U-Boot for BeagleY-AI";
+					description = "U-Boot for PocketBeagle 2";
 				};
 
 				fdt-0 {
-					description = "k3-am67a-beagley-ai";
+					description = "k3-am62-pocketbeagle2";
 					type = "flat_dt";
 					arch = "arm";
 					compression = "none";
 
 					ti-secure {
-						content = <&beagley_ai_dtb>;
+						content = <&pocketbeagle2_dtb>;
 						keyfile = "custMpk.pem";
 					};
 
-					beagley_ai_dtb: blob-ext {
+					pocketbeagle2_dtb: blob-ext {
 						filename = "u-boot.dtb";
 					};
 
@@ -248,14 +295,13 @@
 				default = "conf-0";
 
 				conf-0 {
-					description = "k3-k3-am67a-beagley-ai";
+					description = "k3-am62-pocketbeagle2";
 					firmware = "uboot";
 					loadables = "uboot";
 					fdt = "fdt-0";
 				};
-
 			};
 		};
 	};
 };
-#endif /* CONFIG_TARGET_J722S_A53_BEAGLEY_AI */
+#endif /* CONFIG_TARGET_AM62X_A53_POCKETBEAGLE2 */
diff --git a/arch/arm/dts/k3-am62-r5-pocketbeagle2.dts b/arch/arm/dts/k3-am62-r5-pocketbeagle2.dts
new file mode 100644
index 000000000000..4489a559287b
--- /dev/null
+++ b/arch/arm/dts/k3-am62-r5-pocketbeagle2.dts
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * AM625 PocketBeagle 2 dts file for R5 SPL
+ * https://www.beagleboard.org/boards/pocketbeagle-2
+ *
+ * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2022-2023 Robert Nelson, BeagleBoard.org Foundation
+ */
+
+#include "k3-am62-pocketbeagle2.dts"
+#include "k3-am62-pocketbeagle2-ddr4-1600MTs.dtsi"
+#include "k3-am62-ddr.dtsi"
+
+#include "k3-am62-pocketbeagle2-u-boot.dtsi"
+#include "k3-am625-r5.dtsi"
+
+/ {
+	aliases {
+		serial1 = &main_uart1;
+		serial2 = &main_uart6;
+		serial3 = &main_uart3;
+		serial4 = &main_uart4;
+		serial5 = &main_uart5;
+		serial6 = &main_uart2;
+		serial7 = &main_uart0;
+	};
+};
+
+&main_pktdma {
+	ti,sci = <&dm_tifs>;
+};
+
+&main_bcdma {
+	ti,sci = <&dm_tifs>;
+};
diff --git a/arch/arm/mach-k3/am62x/Kconfig b/arch/arm/mach-k3/am62x/Kconfig
index f7ad52db7d8d..87470248aa15 100644
--- a/arch/arm/mach-k3/am62x/Kconfig
+++ b/arch/arm/mach-k3/am62x/Kconfig
@@ -69,6 +69,7 @@ config TARGET_VERDIN_AM62_R5
 endchoice
 
 source "board/beagle/beagleplay/Kconfig"
+source "board/beagle/pocketbeagle2/Kconfig"
 source "board/phytec/phycore_am62x/Kconfig"
 source "board/ti/am62x/Kconfig"
 source "board/toradex/verdin-am62/Kconfig"
diff --git a/board/beagle/pocketbeagle2/Kconfig b/board/beagle/pocketbeagle2/Kconfig
new file mode 100644
index 000000000000..e957b8e8377e
--- /dev/null
+++ b/board/beagle/pocketbeagle2/Kconfig
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+#
+
+choice
+	prompt "BeagleBoard.org AM62X based PocketBeagle 2 board"
+	optional
+
+config TARGET_AM62X_A53_POCKETBEAGLE2
+	bool "BeagleBoard.org AM62X PocketBeagle 2 running on A53"
+	select ARM64
+	select BINMAN
+	select OF_SYSTEM_SETUP
+
+config TARGET_AM62X_R5_POCKETBEAGLE2
+	bool "BeagleBoard.org AM62X PocketBeagle 2 running on R5"
+	select CPU_V7R
+	select SYS_THUMB_BUILD
+	select K3_LOAD_SYSFW
+	select RAM
+	select SPL_RAM
+	select K3_DDRSS
+	select BINMAN
+	imply SYS_K3_SPL_ATF
+
+endchoice
+
+if TARGET_AM62X_A53_POCKETBEAGLE2
+
+config SYS_BOARD
+	default "pocketbeagle2"
+
+config SYS_VENDOR
+	default "beagle"
+
+config SYS_CONFIG_NAME
+	default "pocketbeagle2"
+
+source "board/ti/common/Kconfig"
+
+endif
+
+if TARGET_AM62X_R5_POCKETBEAGLE2
+
+config SYS_BOARD
+	default "pocketbeagle2"
+
+config SYS_VENDOR
+	default "beagle"
+
+config SYS_CONFIG_NAME
+	default "pocketbeagle2"
+
+config SPL_LDSCRIPT
+	default "arch/arm/mach-omap2/u-boot-spl.lds"
+
+source "board/ti/common/Kconfig"
+
+endif
diff --git a/board/beagle/pocketbeagle2/MAINTAINERS b/board/beagle/pocketbeagle2/MAINTAINERS
new file mode 100644
index 000000000000..79bdd59af7e7
--- /dev/null
+++ b/board/beagle/pocketbeagle2/MAINTAINERS
@@ -0,0 +1,10 @@
+POCKETBEAGLE2 BOARD
+M:	Nishanth Menon <nm@ti.com>
+M:	Robert Nelson <robertcnelson@gmail.com>
+M:	Tom Rini <trini@konsulko.com>
+S:	Maintained
+N:	pocketbeagle2
+F:	board/beagle/pocketbeagle2/
+F:	include/configs/pocketbeagle2.h
+F:	configs/am62_pocketbeagle2_a53_defconfig
+F:	configs/am62_pocketbeagle2_r5_defconfig
diff --git a/board/beagle/pocketbeagle2/Makefile b/board/beagle/pocketbeagle2/Makefile
new file mode 100644
index 000000000000..3d42c160716e
--- /dev/null
+++ b/board/beagle/pocketbeagle2/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Makefile for AM625 PocketBeagle 2
+# https://www.beagleboard.org/boards/pocketbeagle-2
+#
+# Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+#
+
+obj-y += pocketbeagle2.o
diff --git a/board/beagle/beagleplay/board-cfg.yaml b/board/beagle/pocketbeagle2/board-cfg.yaml
similarity index 100%
copy from board/beagle/beagleplay/board-cfg.yaml
copy to board/beagle/pocketbeagle2/board-cfg.yaml
diff --git a/board/beagle/beagleplay/pm-cfg.yaml b/board/beagle/pocketbeagle2/pm-cfg.yaml
similarity index 100%
copy from board/beagle/beagleplay/pm-cfg.yaml
copy to board/beagle/pocketbeagle2/pm-cfg.yaml
diff --git a/board/beagle/pocketbeagle2/pocketbeagle2.c b/board/beagle/pocketbeagle2/pocketbeagle2.c
new file mode 100644
index 000000000000..291a1c6c3db7
--- /dev/null
+++ b/board/beagle/pocketbeagle2/pocketbeagle2.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Board specific initialization for AM625 PocketBeagle 2
+ * https://www.beagleboard.org/boards/pocketbeagle-2
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2025 Robert Nelson, BeagleBoard.org Foundation
+ */
+
+#include <env.h>
+#include <fdt_support.h>
+#include <spl.h>
+
+#include <asm/arch/hardware.h>
+#include <asm/arch/k3-ddr.h>
+#include <asm/io.h>
+#include <dm/uclass.h>
+#include <linux/sizes.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+int dram_init_banksize(void)
+{
+	return fdtdec_setup_memory_banksize();
+}
+
+/*
+ * The U-Boot stack can collide with some dt reservations in the 512MB
+ * configuration. Because of this, we need to relocate to just below our dt
+ * reservations. The magic number below corresponds to the lowest value from
+ * the block of conflicting reservations in the current device tree.
+ */
+phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
+{
+	if (gd->ram_size == SZ_512M)
+		return 0x9c800000;
+
+	return gd->ram_top;
+}
+
+#if IS_ENABLED(CONFIG_BOARD_LATE_INIT)
+int board_late_init(void)
+{
+	char fdtfile[50];
+
+	snprintf(fdtfile, sizeof(fdtfile), "%s.dtb",
+		 CONFIG_DEFAULT_DEVICE_TREE);
+
+	env_set("fdtfile", fdtfile);
+
+	return 0;
+}
+#endif /* CONFIG_BOARD_LATE_INIT */
diff --git a/board/ti/am62x/am62x.env b/board/beagle/pocketbeagle2/pocketbeagle2.env
similarity index 64%
copy from board/ti/am62x/am62x.env
copy to board/beagle/pocketbeagle2/pocketbeagle2.env
index 60b5fd5e6ca7..816f365083e7 100644
--- a/board/ti/am62x/am62x.env
+++ b/board/beagle/pocketbeagle2/pocketbeagle2.env
@@ -10,23 +10,17 @@ rproc_fw_binaries= 0 /lib/firmware/am62-mcu-m4f0_0-fw
 
 name_kern=Image
 console=ttyS2,115200n8
-args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02800000
-	${mtdparts}
+args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02860000
 run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
+set_led_state_fail_load= led led-1 off; led led-2 on;
+	led led-3 off; led led-4 on
+set_led_state_start_load=led led-1 on; led led-2 off;
+	led led-3 on; led led-4 off
 
-boot_targets=mmc1 mmc0 usb pxe dhcp
+boot_targets=mmc1
 boot=mmc
 mmcdev=1
 bootpart=1:2
 bootdir=/boot
+bootmeths=script extlinux efi pxe
 rd_spec=-
-
-splashfile=ti_logo_414x97_32bpp.bmp.gz
-splashimage=0x80200000
-splashpos=m,m
-splashsource=sf
-
-#if CONFIG_BOOTMETH_ANDROID
-#include <env/ti/android.env>
-adtb_idx=0
-#endif
\ No newline at end of file
diff --git a/board/phytec/phycore_am62x/rm-cfg.yaml b/board/beagle/pocketbeagle2/rm-cfg.yaml
similarity index 99%
copy from board/phytec/phycore_am62x/rm-cfg.yaml
copy to board/beagle/pocketbeagle2/rm-cfg.yaml
index f800fb28a692..26d99b03b800 100644
--- a/board/phytec/phycore_am62x/rm-cfg.yaml
+++ b/board/beagle/pocketbeagle2/rm-cfg.yaml
@@ -525,7 +525,7 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 168
-            num_resource: 7
+            num_resource: 8
             type: 1802
             host_id: 30
             reserved: 0
@@ -555,7 +555,7 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 909
-            num_resource: 625
+            num_resource: 626
             type: 1805
             host_id: 128
             reserved: 0
diff --git a/board/beagle/beagleplay/sec-cfg.yaml b/board/beagle/pocketbeagle2/sec-cfg.yaml
similarity index 100%
copy from board/beagle/beagleplay/sec-cfg.yaml
copy to board/beagle/pocketbeagle2/sec-cfg.yaml
diff --git a/configs/am62x_beagleplay_a53_defconfig b/configs/am62_pocketbeagle2_a53_defconfig
similarity index 87%
copy from configs/am62x_beagleplay_a53_defconfig
copy to configs/am62_pocketbeagle2_a53_defconfig
index c9bc7cd8d398..8964cb3b1955 100644
--- a/configs/am62x_beagleplay_a53_defconfig
+++ b/configs/am62_pocketbeagle2_a53_defconfig
@@ -6,18 +6,23 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_SOC_K3_AM625=y
-CONFIG_TARGET_AM625_A53_BEAGLEPLAY=y
+CONFIG_TARGET_AM62X_A53_POCKETBEAGLE2=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80b80000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x82b00000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am625-beagleplay"
+CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am62-pocketbeagle2"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
-CONFIG_SPL_STACK_R_ADDR=0x82000000
+CONFIG_TEXT_BASE=0x82f80000
+CONFIG_SPL_TEXT_BASE=0x82000000
+CONFIG_SPL_STACK_R_ADDR=0x83f80000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x80c80000
+CONFIG_K3_OPTEE_LOAD_ADDR=0x80080000
+CONFIG_SPL_BSS_START_ADDR=0x82c00000
+CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x82f80000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_STACK_R=y
 CONFIG_SPL_SIZE_LIMIT=0x40000
@@ -44,8 +49,6 @@ CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_MAILBOX=y
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_YMODEM_SUPPORT=y
-CONFIG_CMD_BOOTEFI_SELFTEST=y
-CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPIO_READ=y
 CONFIG_CMD_I2C=y
@@ -53,6 +56,7 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_CACHE=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_UPSTREAM=y
@@ -90,10 +94,6 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_SPL_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_AM654=y
-CONFIG_PHY_REALTEK=y
-CONFIG_PHY_TI=y
-CONFIG_DM_ETH_PHY=y
-CONFIG_TI_AM65_CPSW_NUSS=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
@@ -120,7 +120,5 @@ CONFIG_SYSRESET_TI_SCI=y
 CONFIG_EXT4_WRITE=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
 CONFIG_LZO=y
-CONFIG_EFI_SET_TIME=y
 
-#include <configs/k3_efi_capsule.config>
 #include <configs/am62x_a53_usbdfu.config>
diff --git a/configs/am62x_beagleplay_r5_defconfig b/configs/am62_pocketbeagle2_r5_defconfig
similarity index 89%
copy from configs/am62x_beagleplay_r5_defconfig
copy to configs/am62_pocketbeagle2_r5_defconfig
index 08b2c38b80de..90e577e8ce16 100644
--- a/configs/am62x_beagleplay_r5_defconfig
+++ b/configs/am62_pocketbeagle2_r5_defconfig
@@ -3,15 +3,16 @@ CONFIG_ARCH_K3=y
 CONFIG_SYS_MALLOC_LEN=0x08000000
 CONFIG_SYS_MALLOC_F_LEN=0x9000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_SOC_K3_AM625=y
-CONFIG_TARGET_AM625_R5_BEAGLEPLAY=y
+CONFIG_TARGET_AM62X_R5_POCKETBEAGLE2=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x43c3a7f0
 CONFIG_ENV_SIZE=0x20000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
-CONFIG_DEFAULT_DEVICE_TREE="k3-am625-r5-beagleplay"
+CONFIG_DEFAULT_DEVICE_TREE="k3-am62-r5-pocketbeagle2"
 CONFIG_DM_RESET=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x7000
 CONFIG_SPL_MMC=y
@@ -34,7 +35,6 @@ CONFIG_SPL_SIZE_LIMIT_SUBTRACT_MALLOC=y
 CONFIG_SPL_MAX_SIZE=0x3B000
 CONFIG_SPL_PAD_TO=0x0
 CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
-CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SEPARATE_BSS=y
 CONFIG_SPL_SYS_MALLOC=y
@@ -62,6 +62,8 @@ CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_REGMAP=y
+CONFIG_SPL_REGMAP=y
 CONFIG_SPL_OF_TRANSLATE=y
 CONFIG_CLK=y
 CONFIG_SPL_CLK=y
@@ -97,3 +99,6 @@ CONFIG_SPL_TIMER=y
 CONFIG_OMAP_TIMER=y
 CONFIG_LIB_RATIONAL=y
 CONFIG_SPL_LIB_RATIONAL=y
+CONFIG_K3_OPTEE_LOAD_ADDR=0x80080000
+CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x82000000
diff --git a/doc/board/beagle/am62_pocketbeagle2.rst b/doc/board/beagle/am62_pocketbeagle2.rst
new file mode 100644
index 000000000000..4ee8aa57e497
--- /dev/null
+++ b/doc/board/beagle/am62_pocketbeagle2.rst
@@ -0,0 +1,279 @@
+.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+.. sectionauthor:: Randolph Sapp <rs@ti.com>
+
+AM62 Beagleboard.org PocketBeagle 2
+===================================
+
+Introduction:
+-------------
+
+BeagleBoard.org PocketBeagle 2 is an easy to use, affordable open source
+hardware single board computer based on the Texas Instruments AM625
+SoC.
+
+Further information can be found at:
+
+* Product Page: https://www.beagleboard.org/boards/pocketbeagle-2
+* Hardware documentation: https://openbeagle.org/pocketbeagle/pocketbeagle-2
+
+Boot Flow:
+----------
+Below is the pictorial representation of boot flow:
+
+.. image:: ../ti/img/boot_diagram_am62.svg
+   :alt: Boot flow diagram
+
+On this platform, 'TI Foundational Security' (TIFS) functions as the security
+enclave master while 'Device Manager' (DM), also known as the 'TISCI server' in
+"TI terminology", offers all the essential services. The A53 or M4F (Aux core)
+sends requests to TIFS/DM to accomplish these services, as illustrated in the
+diagram above.
+
+Sources:
+--------
+.. include::  ../ti/k3.rst
+   :start-after: .. k3_rst_include_start_boot_sources
+   :end-before: .. k3_rst_include_end_boot_sources
+
+.. include::  ../ti/k3.rst
+   :start-after: .. k3_rst_include_start_boot_firmwares
+   :end-before: .. k3_rst_include_end_tifsstub
+
+Build procedure:
+----------------
+
+#. Setup the environment variables:
+
+   .. include::  ../ti/k3.rst
+      :start-after: .. k3_rst_include_start_common_env_vars_desc
+      :end-before: .. k3_rst_include_end_common_env_vars_desc
+
+   .. include::  ../ti/k3.rst
+      :start-after: .. k3_rst_include_start_board_env_vars_desc
+      :end-before: .. k3_rst_include_end_board_env_vars_desc
+
+#. Set the variables corresponding to this platform:
+
+   .. include::  ../ti/k3.rst
+      :start-after: .. k3_rst_include_start_common_env_vars_defn
+      :end-before: .. k3_rst_include_end_common_env_vars_defn
+
+   .. prompt:: bash $
+
+      export UBOOT_CFG_CORTEXR=am62_pocketbeagle2_r5_defconfig
+      export UBOOT_CFG_CORTEXA=am62_pocketbeagle2_a53_defconfig
+      export TFA_BOARD=lite
+      export TFA_EXTRA_ARGS="PRELOADED_BL33_BASE=0x82000000 BL32_BASE=0x80080000"
+      export OPTEE_PLATFORM=k3-am62x
+      export OPTEE_EXTRA_ARGS="CFG_TZDRAM_START=0x80080000"
+
+   .. include::  ../ti/am62x_sk.rst
+      :start-after: .. am62x_evm_rst_include_start_build_steps
+      :end-before: .. am62x_evm_rst_include_end_build_steps
+
+Target Images
+-------------
+Copy these images to an SD card and boot:
+
+   * :file:`tiboot3.bin` from Cortex-R5 build.
+   * :file:`tispl.bin` and :file:`u-boot.img` from Cortex-A build
+
+Image formats
+-------------
+
+- :file:`tiboot3.bin`
+
+  .. image:: ../ti/img/multi_cert_tiboot3.bin.svg
+     :alt: tiboot3.bin image format
+
+- :file:`tispl.bin`
+
+  .. image:: ../ti/img/tifsstub_dm_tispl.bin.svg
+     :alt: tispl.bin image format
+
+Additional hardware for U-Boot development
+------------------------------------------
+
+* A Serial Console is critical for U-Boot development on the PocketBeagle 2. See
+  `PocketBeagle 2 serial console documentation`__.
+* uSD is the default, and a SD/MMC reader will be needed.
+* (optionally) JTAG is useful when working with very early stages of boot.
+
+.. __: https://docs.beagleboard.org/boards/pocketbeagle-2/03-design-and-specifications.html#serial-debug-port
+
+Default storage options
+-----------------------
+
+There is only one storage media option for the PocketBeagle 2, by default:
+
+* SD/MMC card interface
+
+Flash to uSD card
+-----------------
+
+If you choose to  hand format your own bootable uSD card, be
+aware that it can be difficult. The following information
+may be helpful, but remember that it is only sometimes
+reliable, and partition options can cause issues. These
+can potentially help:
+
+* https://git.ti.com/cgit/arago-project/tisdk-setup-scripts/tree/create-sdcard.sh
+* https://elinux.org/Beagleboard:Expanding_File_System_Partition_On_A_microSD
+
+The simplest option is to start with a standard distribution
+image like those in `BeagleBoard.org Distros Page
+<https://www.beagleboard.org/distros>`_ and download a disk image for
+PocketBeagle 2. Pick a 16GB+ uSD card to be on the safer side.
+
+With an SD/MMC Card reader and `Balena Etcher
+<https://etcher.balena.io/>`_, having a functional setup in minutes is
+a trivial matter, and it works on almost all host operating systems.
+
+Updating U-Boot is a matter of copying the :file:`tiboot3.bin`,
+:file:`tispl.bin` and :file:`u-boot.img` to the "BOOT" partition of the uSD
+card. Remember to sync and unmount (or Eject - depending on the Operating
+System) the uSD card prior to physically removing from SD card reader.
+
+Also see following section on switch setting used for booting using
+uSD card.
+
+.. note::
+
+   If you are frequently working with uSD cards, you might find the
+   following useful:
+
+   * `USB-SD-Mux <https://www.linux-automation.com/en/products/usb-sd-mux.html>`_
+   * `SD-Wire <https://wiki.tizen.org/SDWire>`_
+
+LED patterns during boot
+------------------------
+
+.. list-table:: USR LED status indication
+   :widths: 16 16
+   :header-rows: 1
+
+   * - USR LEDs (1234)
+     - Indicates
+
+   * - 0000
+     - Boot failure or R5 image not started up
+
+   * - 1111
+     - A53 SPL/U-boot has started up
+
+   * - 1010
+     - OS boot process has been initiated
+
+   * - 0101
+     - OS boot process failed and drops to U-Boot shell
+
+.. note::
+
+   In the table above, 0 indicates LED switched off and 1 indicates LED
+   switched ON.
+
+.. warning::
+
+   If the "red" power LED is not glowing, the system power supply is not
+   functional. Please refer to the `PocketBeagle 2 documentation
+   <https://docs.beagleboard.org/boards/pocketbeagle-2/>`_ for further
+   information.
+
+A53 SPL DDR Memory Layout
+-------------------------
+
+.. include::  ../ti/am62x_sk.rst
+   :start-after: .. am62x_evm_rst_include_start_ddr_mem_layout
+   :end-before: .. am62x_evm_rst_include_end_ddr_mem_layout
+
+Switch Setting for Boot Mode
+----------------------------
+
+The boot time option is configured via "USR" button on the board. See the
+`PocketBeagle 2 Schematics
+<https://git.beagleboard.org/pocketbeagle/pocketbeagle-2/-/blob/main/pocketbeagle2_sch.pdf>`_
+and the `PocketBeagle 2 documentation on Boot Modes
+<https://docs.beagleboard.org/boards/pocketbeagle-2/03-design-and-specifications.html#boot-modes>`_
+for details.
+
+.. list-table:: Boot Modes
+   :widths: 16 16 16
+   :header-rows: 1
+
+   * - USR Button Status
+     - Primary Boot
+     - Secondary Boot
+
+   * - Not Pressed
+     - uSD
+     - USB Device Firmware Upgrade (DFU) mode
+
+   * - Pressed
+     - uSD
+     - UART
+
+To switch boot modes, hold the "USR" button while powering on the device with a
+USB type C power supply. Release the button when the red power LED lights up.
+
+DFU based boot
+--------------
+
+To boot the board over DFU, ensure there is no SD card inserted with a
+bootloader. After power-on the build artifacts needs to be uploaded one by one
+with a tool like dfu-util.
+
+.. include::  ../ti/am62x_sk.rst
+   :start-after: .. am62x_evm_rst_include_start_dfu_boot
+   :end-before: .. am62x_evm_rst_include_end_dfu_boot
+
+Debugging U-Boot
+----------------
+
+See :ref:`Common Debugging environment - OpenOCD <k3_rst_refer_openocd>`: for
+detailed setup and debugging information.
+
+.. warning::
+
+   **OpenOCD support since**: v0.12.0
+
+   If the default package version of OpenOCD in your development
+   environment's distribution needs to be updated, it might be necessary to
+   build OpenOCD from the source.
+
+.. include::  ../ti/k3.rst
+   :start-after: .. k3_rst_include_start_openocd_connect_tag_connect
+   :end-before: .. k3_rst_include_end_openocd_connect_tag_connect
+
+.. include::  ../ti/k3.rst
+   :start-after: .. k3_rst_include_start_openocd_cfg_external_intro
+   :end-before: .. k3_rst_include_end_openocd_cfg_external_intro
+
+For example, with the PocketBeagle 2 (AM62X platform), the
+:file:`openocd_connect.cfg` would look like:
+
+.. code-block:: tcl
+
+   # TUMPA example:
+   # http://www.tiaowiki.com/w/TIAO_USB_Multi_Protocol_Adapter_User's_Manual
+   source [find interface/ftdi/tumpa.cfg]
+
+   transport select jtag
+
+   # default JTAG configuration has only SRST and no TRST
+   reset_config srst_only srst_push_pull
+
+   # delay after SRST goes inactive
+   adapter srst delay 20
+
+   if { ![info exists SOC] } {
+     # Set the SoC of interest
+     set SOC am625
+   }
+
+   source [find target/ti_k3.cfg]
+
+   ftdi tdo_sample_edge falling
+
+   # Speeds for FT2232H are in multiples of 2, and 32MHz is tops
+   # max speed we seem to achieve is ~20MHz.. so we pick 16MHz
+   adapter speed 16000
diff --git a/doc/board/beagle/index.rst b/doc/board/beagle/index.rst
index e33d39fc677f..8bf099ae7be7 100644
--- a/doc/board/beagle/index.rst
+++ b/doc/board/beagle/index.rst
@@ -10,6 +10,7 @@ ARM based boards
 .. toctree::
    :maxdepth: 2
 
+   am62_pocketbeagle2
    am62x_beagleplay
    am67a_beagley_ai.rst
    j721e_beagleboneai64
diff --git a/include/configs/beagley_ai.h b/include/configs/pocketbeagle2.h
similarity index 57%
copy from include/configs/beagley_ai.h
copy to include/configs/pocketbeagle2.h
index a7072a094c58..dd6956aa8b90 100644
--- a/include/configs/beagley_ai.h
+++ b/include/configs/pocketbeagle2.h
@@ -1,14 +1,14 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Configuration header file for BeagleY-AI
+ * Configuration header file for PocketBeagle 2
  *
  * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
  */
 
-#ifndef __CONFIG_BEAGLEY_AI_H
-#define __CONFIG_BEAGLEY_AI_H
+#ifndef __CONFIG_POCKETBEAGLE2_H
+#define __CONFIG_POCKETBEAGLE2_H
 
 /* Now for the remaining common defines */
 #include <configs/ti_armv7_common.h>
 
-#endif /* __CONFIG_BEAGLEY_AI_H */
+#endif /* __CONFIG_POCKETBEAGLE2_H */
-- 
2.55.0

