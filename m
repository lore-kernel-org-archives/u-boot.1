Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D56C55162
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 21:55:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 640D380F0D;
	Thu, 30 Jul 2026 21:55:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gsn-Cs8Af5hi; Thu, 30 Jul 2026 21:55:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1A39680E81
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785448507;
	bh=XIdo+oCYcZLNRXR+W9CvX/ZqtiFry8i57phKTjDnLYI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H8A6k+zIS3GwYLbLp8hqPL+kGigMNktMO+vpKlxdY9dRp/XQVS/HRgDLI4DDgroTk
	 49dchnPqvqwvCl/9xlsbC/kuzfNwuFaVf+AT+/vDqlfQZbaK+DiB5i3TeLKjEa92Ky
	 7tzv1kTfZvuycmFaE11Qpm4qJZVaRp1MiBxIGueZhKSHkjmVn9oUQU+p4M7mg8lNEP
	 3m9RjplCoed8sBzJvFmYyEHUurUzH0JTExiGN8ZXoztaAavQqVy3dmaVZB1j9CqlF9
	 jxvvM6lP9vI/tmtkuFaZCC3EAQG8YFBNEzwo8fYZr0j8epyYYdSUFDPhGq7ND/PkKM
	 MgdWTGdixgJnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A39680E81;
	Thu, 30 Jul 2026 21:55:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A5D1469
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 21:55:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8B3D640A60
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 21:55:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id akHfY2WrMlot for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 21:55:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=rs@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E983140A55
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E983140A55
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E983140A55
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 21:55:03 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66ULUUb72272137;
 Thu, 30 Jul 2026 16:54:54 -0500
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010046.outbound.protection.outlook.com [52.101.201.46])
 by m0380145.ppops.net (PPS) with ESMTPS id 4frekc042y-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 16:54:54 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHkdoMcX3kTrsMg0+0LkTPkKl6AHkg+RV9hrkliSjZLdx/1ry2KigjwrAFC06AAWjCM7VdcVGecRusDxW/M8v7xU5ITBKtJJAh/CryCv0lRrK16bbn9e1vFULs/kuPLiyGGXegJtrF6Pewq5I5IZKYOSUqEKEigJ8zGpx32c52ZKwP6krM5ieNmC0nCFzZvlLhpYdt/bnKy/MBYAdLi7hCpMsJszEEkU3lKD9bfuz9L81fLIWlU7Ru7UzkrrsgLqhRJwVW4XYgxzgNmR/4LF9rGJQamYqM5/Svl7U3cAuBAszZ6WgY+t2N116fa/Q5ah79l8L1GJ4bYu/tmWxlU9VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIdo+oCYcZLNRXR+W9CvX/ZqtiFry8i57phKTjDnLYI=;
 b=U4c7euPycBOO57md5ZAcJd5f1vl9huuUH2PLjfu54xrFHM6MelDdwmlROsiBk4SeWoxL1YHCcpfx7roMdHgpZEv5bSH5KyQJSWZxIrQj2RHegiWpFCn++unmHFt1j4wELToe35ROJVLi/q5NNV5wkuRIsGwPbvFt76YKvrVsx/6Rc4eR3GtrCOQbRLt3k1tZNC1pFdWO8JsqkuaqOM5zHnVqZOYo1ML6YB2JZqLCF+W3Vih7xbef5p9QWXk1rZva1VJCwcU3v6IFUEOz+nWDP03kidoyOU9H+inyHHH6vP8xxqjlHgC4rqcBX1MwLfDgJpmB4XL+NGdxAfYUBq0VIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
Received: from CH2PR08CA0005.namprd08.prod.outlook.com (2603:10b6:610:5a::15)
 by SN4PR10MB5559.namprd10.prod.outlook.com (2603:10b6:806:202::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 21:54:50 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::1) by CH2PR08CA0005.outlook.office365.com
 (2603:10b6:610:5a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.14 via Frontend Transport; Thu,
 30 Jul 2026 21:54:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 21:54:49 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 30 Jul
 2026 16:54:49 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 30 Jul
 2026 16:54:48 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 30 Jul 2026 16:54:48 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66ULsmCp3487016;
 Thu, 30 Jul 2026 16:54:48 -0500
From: <rs@ti.com>
To: Anshul Dalal <anshuld@ti.com>, <robertcnelson@gmail.com>,
 <ayush@beagleboard.org>, <Erik.Welsh@octavosystems.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.u-boot-project.org>
Subject: [PATCHv5 1/3] arm: mach-k3: am62: add &main_uart6 to clock and pwr
 tree
Date: Thu, 30 Jul 2026 16:53:18 -0500
Message-ID: <20260730215319.965327-3-rs@ti.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730215319.965327-2-rs@ti.com>
References: <20260730215319.965327-2-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|SN4PR10MB5559:EE_
X-MS-Office365-Filtering-Correlation-Id: f6388978-4495-4c27-e5a2-08deee852d99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|13003099007|10067099003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: m3KCOj98s8pxPqmB/c4O5Us/1YZ/X+SzLuUF/cen4ijPK/uPEi4DJCy78UQJ2JE2egSEM6Rmc1ghXyELd9MYB6ytUmASJeze7l1g8C/m/xjWSG7kwrQtLAa+NQA45MbwBltgXB/gO8fCwXt7XY5lLI2xwr60l4Ht/5UXBUKh72B41M/SZu5xKVUaY4MlP39ybh68XdHPPDUDDJhgZwbjySRYp5fokM68TOnX+R9q/Xx4nvHr8qvsMK8kEGAiXa784wfTepXzNghjwU+cN9tkHmYwTLR+xzKCbz3ebuG4VJJAnnDcxASBLt6Fiyo3c71Kehdkw56ktqsXQRcuk6hitse/Uff2LWNaWktDxqv3CXV2sqDY0H89QXE3fCOdgth+52D9NrgerrBIUjfSxEBHqxzY7Wd3P5CWdBiIrb7Ci8C+TLN6URQmF05mco4aad+QV6xnKDMaHXwhhCCFNX6Q9FyioPRPfzyKZCpF6JUETs8qM56Ay+ZjIKJ7wpP17PVLsudVaRUVVRIDP1jGdSVP25slciX8x0sCnWxS43nDKAPYlPEI2gimrOQ2RJ8ZheAa+SMs/snRS/ibQHWay+nhQLcRpFcbgQ/gn8w3/vPtaDbHl3OAx5uKt1KCF8umT4GQFLVIgZEK/XoSZhGEhCToig==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(13003099007)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: g93TN8RWK2Jgl472QCn9kKwBsbVKac7m80hLWkSmQYSNN+aZ5CgDUx/eujdGyM6vJjWiGDVjLm6gIuAJP2ePHHqDmYSIiLKAmL7wjeHIFi8jP/voC6Vlv6+HouwnZ1fWm+5PQ2ZdbfsjPyrnwJMqsmkNd8DvAG8l9MvZWbQ/FjmmPW7V1HhSXRmnFyHKXQ6kdc15W1E26c++WxBqijmtXBBNMCQlwFX/l2az4r9ErEKuaAKM6bqDyOHNBtJBHbyFViMbEUCJ11R4emnh0/XCAtZRykeKDDnnKpt6485EXdllOlVf4ZWndDoSb/cTTJsmqNrSRd9+CIoFz0C009TZUm2Y8Oyn2iCuTWwCkqXUHtbHSnCWCfKyv7R/b6ZQPqvHrYVyh6LVxFizWCpXuepSd9KBDmGQWXjbkWkRuiWXLK5G1Dr9gCV00ZDmwxILRnIV
X-Exchange-RoutingPolicyChecked: p8lM7zth75otitPn5WoO1tj+wJ8wzjrEpp7Yv5CE31sBW2kjsQI3hU8HycD1+m8SgntJ2zUdjiGM6HpyV3qqABRQ4sv4nKPqxRWQMaLfYY16JcXWwlup/JyMY1CktTd0CtTJwk+6EP8sTXTJCymZ5JlpPw+/rI1IMXXhHp0+YP4sPEgHqS3CuuoYde4oG5SLuWloQziylfk2Rw2RGNfc+Vesqj5qVrUs50xoJ6mWq5NNVhfKgyyKNfJ+6Ukj5HHjt6DRpil5p9UreN2IqMu9pokvnPGB9ojsRvelemT5mCYRMa8u8bsM2xTpw8grx8KskWHugmscYs51daZ2O6wUwA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 21:54:49.5337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6388978-4495-4c27-e5a2-08deee852d99
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5559
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE1NyBTYWx0ZWRfXyYaHuEAPzcxr
 uq7D9LWi+iUjakvav7ag5igVG58emhr2adMpWoj07p6Mh4xL9DGrxyCN0SrbOaTXMTGljbHtSdL
 DNUjdGU7ch7MH5W1hd6FUAgPPyVagNLOCngKfTfO2BjMXdFI/plbrK9c0miRn9b3ZIyF2HYWQwc
 UphovUqVPrKgPeNjSGa8PStuvxzm2IJhmamMXk55dcGpEEr6xLQnAvIhNmG7n6iP5jutDaD8rIi
 yUXvznEsw3pC7tLL1SfREjmVLI84KWMpNRKnskAmOGNKCxpPgUe1ZKw+i2GlsemBMSrTmFJeIJB
 iCPhYd7IIpuNdpi1MSDX3k3oHNv5H14RY83RB/lg8cYVC7RC9gdVYLVHKec1J8xIxowFAnW5cIv
 1DuYZkZ//A6/tqMD7wVKC/X1VefTaZXhwUJfdWui+ZYCSYx9zYnM+ZdJrEUgavrCHa6ImP3/+BA
 +tRN49Nj3K39KOlREIQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE1NyBTYWx0ZWRfX9roit1OoupGc
 CwtC0zWMg4Y5mKpv7yXP8rAzusWwGBZMzujTej2yMI8wJq7dCoIXZsXcY7fJdQsGj79iwcZ9urL
 mAC35JdJUXyUADeltl8RJtiGGlkLo58=
X-Authority-Analysis: v=2.4 cv=Z+Lc2nRA c=1 sm=1 tr=0 ts=6a6bc82e cx=c_pps
 a=Sm015RFco05wDkMfClhrzg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=WtDTEybOK8mIDu76bVQA:9
X-Proofpoint-GUID: TvJChOAnHDjfeHM3emZ1lVc2W0Bhxqmb
X-Proofpoint-ORIG-GUID: TvJChOAnHDjfeHM3emZ1lVc2W0Bhxqmb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300157
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=XIdo+oCYcZLNRXR+W9CvX/ZqtiFry8i57phKTjDnL
 YI=; b=hLYSoH5im9JNVcESijnLHSfwH8bNzzYuIuKG9lj9BaU/Y+39O/wrxc8qm
 qHeCQE3wDKFEDT1B/2USc2cviCRu8q1WYpwin/bkgOQqlA1hLHEkWCUAZaL/6NRN
 enbT3yQlIQ7nHSkxSkXfm0O7TdQ/t9KoRQ0xrrVxoZebGa7JDbCVHZorHa2TqgNq
 Saprw61Uryn8AgM5zNtmND13gH6PF+BG9gB+0kcCrrISY1Tlq9wVs9+gozVnjzF5
 TLG/D44Pri+2acFB1tdKwlLJHptu8QH5aNqYjtAO5MPzCvUV11V6J/PzSoPKwxi2
 snJTG2ekePrI7VU96KHpovRpZDO1A==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIdo+oCYcZLNRXR+W9CvX/ZqtiFry8i57phKTjDnLYI=;
 b=wuTA7txfWoHR9UQ239VcE5XF5HIIcBg8t+LVHoG1vfvzIx3UG3+vJ7HmJb1R8svOVY2SlqcdV27Dy3PTCSWTFnJDTQFgjpjdbpWn4DcYgNBeGxSYjsn1tfILejKDpVHW+lKnslBIWGQT+LVnzxM6Q7RmC+ibHOl5G0s2U8u6TFk=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=hLYSoH5i; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=wuTA7txf
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

From: Bryan Brattlof <bb@ti.com>

The pocketbeagle2 uses the main_uart6 as the debug console. To get debug
console prints at the R5 SPL stage, add the &main_uart6 to the R5 clk
and dev data so we can configure the uart as early as possible during
the bootup of the pocketbeagle2

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/mach-k3/r5/am62x/clk-data.c | 19 +++++++++++++++----
 arch/arm/mach-k3/r5/am62x/dev-data.c |  5 +++--
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-k3/r5/am62x/clk-data.c b/arch/arm/mach-k3/r5/am62x/clk-data.c
index d7bfed0e031c..05cced0b313b 100644
--- a/arch/arm/mach-k3/r5/am62x/clk-data.c
+++ b/arch/arm/mach-k3/r5/am62x/clk-data.c
@@ -3,9 +3,9 @@
  * AM62X specific clock platform data
  *
  * This file is auto generated. Please do not hand edit and report any issues
- * to Dave Gerlach <d-gerlach@ti.com>.
+ * to Bryan Brattlof <bb@ti.com>.
  *
- * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2025 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <linux/clk-provider.h>
@@ -125,6 +125,11 @@ static const char * const main_usart0_fclk_sel_out0_parents[] = {
 	"hsdiv4_16fft_main_1_hsdivout1_clk",
 };
 
+static const char * const main_usart6_fclk_sel_out0_parents[] = {
+	"usart_programmable_clock_divider_out6",
+	"hsdiv4_16fft_main_1_hsdivout1_clk",
+};
+
 static const struct clk_data clk_list[] = {
 	CLK_FIXED_RATE("osc_26_mhz", 26000000, 0),
 	CLK_FIXED_RATE("osc_25_mhz", 25000000, 0),
@@ -210,9 +215,11 @@ static const struct clk_data clk_list[] = {
 	CLK_MUX("main_gtcclk_sel_out0", main_gtcclk_sel_out0_parents, 8, 0x43008030, 0, 3, 0),
 	CLK_MUX("main_ospi_ref_clk_sel_out0", main_ospi_ref_clk_sel_out0_parents, 2, 0x108500, 0, 1, 0),
 	CLK_DIV_DEFFREQ("usart_programmable_clock_divider_out0", "hsdiv4_16fft_main_1_hsdivout0_clk", 0x108240, 0, 2, 0, 0, 48000000),
+	CLK_DIV_DEFFREQ("usart_programmable_clock_divider_out6", "hsdiv4_16fft_main_1_hsdivout0_clk", 0x108258, 0, 2, 0, 0, 48000000),
 	CLK_MUX("wkup_clkout_sel_out0", wkup_clkout_sel_out0_parents, 8, 0x43008020, 0, 3, 0),
 	CLK_MUX("wkup_clksel_out0", wkup_clksel_out0_parents, 2, 0x43008010, 0, 1, 0),
 	CLK_MUX("main_usart0_fclk_sel_out0", main_usart0_fclk_sel_out0_parents, 2, 0x108280, 0, 1, 0),
+	CLK_MUX("main_usart6_fclk_sel_out0", main_usart6_fclk_sel_out0_parents, 2, 0x108298, 0, 1, 0),
 	CLK_DIV("hsdiv4_16fft_mcu_0_hsdivout1_clk", "pllfracf_ssmod_16fft_mcu_0_foutvcop_clk", 0x4040084, 0, 7, 0, 0),
 	CLK_FIXED_RATE("mshsi2c_wkup_0_porscl", 0, 0),
 	CLK_DIV("sam62_pll_ctrl_wrap_main_0_chip_div24_clk_clk", "sam62_pll_ctrl_wrap_main_0_sysclkout_clk", 0x41011c, 0, 5, 0, 0),
@@ -336,6 +343,10 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(157, 164, "clk_32k_rc_sel_out0"),
 	DEV_CLK(157, 165, "gluelogic_rcosc_clkout"),
 	DEV_CLK(157, 166, "gluelogic_hfosc0_clkout"),
+	DEV_CLK(158, 0, "main_usart6_fclk_sel_out0"),
+	DEV_CLK(158, 1, "usart_programmable_clock_divider_out6"),
+	DEV_CLK(158, 2, "hsdiv4_16fft_main_1_hsdivout1_clk"),
+	DEV_CLK(158, 5, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(161, 0, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(161, 1, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(161, 2, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
@@ -361,7 +372,7 @@ static const struct dev_clk soc_dev_clk_data[] = {
 
 const struct ti_k3_clk_platdata am62x_clk_platdata = {
 	.clk_list = clk_list,
-	.clk_list_cnt = 90,
+	.clk_list_cnt = 92,
 	.soc_dev_clk_data = soc_dev_clk_data,
-	.soc_dev_clk_data_cnt = 137,
+	.soc_dev_clk_data_cnt = 140,
 };
diff --git a/arch/arm/mach-k3/r5/am62x/dev-data.c b/arch/arm/mach-k3/r5/am62x/dev-data.c
index 59c95df2a887..ea1e76a8a758 100644
--- a/arch/arm/mach-k3/r5/am62x/dev-data.c
+++ b/arch/arm/mach-k3/r5/am62x/dev-data.c
@@ -3,9 +3,9 @@
  * AM62X specific device platform data
  *
  * This file is auto generated. Please do not hand edit and report any issues
- * to Dave Gerlach <d-gerlach@ti.com>.
+ * to Bryan Brattlof <bb@ti.com>.
  *
- * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2025 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include "k3-dev.h"
@@ -61,6 +61,7 @@ static struct ti_dev soc_dev_list[] = {
 	PSC_DEV(36, &soc_lpsc_list[11]),
 	PSC_DEV(102, &soc_lpsc_list[11]),
 	PSC_DEV(146, &soc_lpsc_list[11]),
+	PSC_DEV(158, &soc_lpsc_list[11]),
 	PSC_DEV(13, &soc_lpsc_list[12]),
 	PSC_DEV(166, &soc_lpsc_list[13]),
 	PSC_DEV(135, &soc_lpsc_list[14]),
-- 
2.55.0

