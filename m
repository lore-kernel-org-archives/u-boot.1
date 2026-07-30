Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C229C55162
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 21:55:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D0DCF60A94;
	Thu, 30 Jul 2026 21:55:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U3pqJyogd4r1; Thu, 30 Jul 2026 21:55:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 43B7B608AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785448510;
	bh=o3VIEGm51FV78cRFtY0/N8TNvi2OYoKTVidxiJDesTQ=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FMcoUAO+foV4QsUTIUvyeKmRwDEZElJCrcfFj1aEKsRF4ptvorxOT4DyXk0KTnWaS
	 dBJEsCN7QOuskV4UKjRSlgVsaxTqTi9NeOzum32oYPHXO4WbdPAn4qOXvPTV7HTcI3
	 CF70D4H/pbNom5yPU1Bd15WNFOZs44QfOSGZ74JX0t1bBFUoo1UrOP7EHn1rwO5U1A
	 xYSoGFaCSk7HkFAvbCYyMazW5k+VlBL1i7g1b51HjeaysIIMQxMzAdspzQ6SQdVeOH
	 pHeWrgA+R3U/z33ymdk/46vgj5Vsnaxe30UYJLxjIjOmP41YGdXw4OKjjOarfi/HCy
	 m0VSPQy0DswgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43B7B608AA;
	Thu, 30 Jul 2026 21:55:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9046A218
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 21:55:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 762B340101
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 21:55:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v7ht52r2uJe6 for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 21:55:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=rs@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C169E4008B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C169E4008B
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C169E4008B
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 21:55:05 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66UL0vWo3684036;
 Thu, 30 Jul 2026 16:54:58 -0500
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010059.outbound.protection.outlook.com [52.101.56.59])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fre5g0acs-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 16:54:57 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBoZOuXhvKnyQ9WO9T2INaT7fB6XLBxXuXKrZOFB0aVjZyemrAPxskqyaPSZscjbUSXPQO3R9iJifFI1ppr/8/qFcc+izGbED5IRfTX+8N6DRQN0Z0oRjwnjISgYihnX8ZFadyuKi7HBPQ5ru5M63DreoOn2cMaajLmGtg5MyCa6CVSzWo5OU84edWYvWIau5Jf5hR3CS7VB1CuUZxe1rotUT7lOQXT/XskMxyFII3sD7sTXfDUfTu5zk9YFhHpUpP/sJOfikvjWAeSoeHjIWzK04+5cZUJJmt7vzEAN79l/qXwXvUGKtlQWpvrDejIFjg49y101eSic6tfnDIp0DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3VIEGm51FV78cRFtY0/N8TNvi2OYoKTVidxiJDesTQ=;
 b=ileZ39mkDJ58iHVo6+MCJc1F5gC8paB+w8WzRzCHNH9DsVoOhxf5K8SJ/tKCsvzdF9MmfPFQffWT0CCA7bRCBMJFrkV3noJ3y1xi8NXGwwfKZF71VXKKLEiMMTFa/Ml/LI7yPmvz+1kU5/JvdmzOyXBOfDLoXYi/REDrfhuyrVbkcgtAF7yUcvWeC4XswnoEqqVuhZvDnIwsb3NttmB5oKqcNhW0oJBrJFLBPKItRZ/7Mkf/LOsRgoyZLnVpNPQPhqUbB3za7L1oDI26+BoPyXwzcH+C5LVoWh3gBR72kdZSvXK71DrGljGU4jGIeCyKX134E/wFxrUHv97xcm8MGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
Received: from DS7PR03CA0155.namprd03.prod.outlook.com (2603:10b6:5:3b2::10)
 by DS0PR10MB8150.namprd10.prod.outlook.com (2603:10b6:8:203::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 21:54:54 +0000
Received: from DS2PEPF000061C2.namprd02.prod.outlook.com
 (2603:10b6:5:3b2:cafe::91) by DS7PR03CA0155.outlook.office365.com
 (2603:10b6:5:3b2::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Thu,
 30 Jul 2026 21:54:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS2PEPF000061C2.mail.protection.outlook.com (10.167.23.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 21:54:53 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 30 Jul
 2026 16:54:49 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 30 Jul
 2026 16:54:48 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 30 Jul 2026 16:54:48 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66ULsmCo3487016;
 Thu, 30 Jul 2026 16:54:48 -0500
From: <rs@ti.com>
To: Anshul Dalal <anshuld@ti.com>, <robertcnelson@gmail.com>,
 <ayush@beagleboard.org>, <Erik.Welsh@octavosystems.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.u-boot-project.org>
Subject: [PATCHv5 0/3] k3-am62-pocketbeagle2: add board and variant support
Date: Thu, 30 Jul 2026 16:53:17 -0500
Message-ID: <20260730215319.965327-2-rs@ti.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C2:EE_|DS0PR10MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: cd7d0bb6-a60d-47b3-4575-08deee853002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|10067099003|56012099006|3023799007|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: o2N+JZ4o/6l3RWlMRhtgSRIUYCCI+OB8OYjxGKr6lZnH87wlbZT/nLYevNuoVjbodm8DyPv9I8bA/N4jcNYad/uXspe7DNJ2nfoifSuPaNo+lijSjPQAqdGc4Y4yTqu7m6rhnFVVA3a1aOSJeSJbwJZ+3Ycxzfi+Mdv0HJ8peQ5lUsf6Jw1Ls/KQvCF0IJpndxMEZ5qMfCwG7obcPyQTJmuSyB6aIEzVIRsPKcz7Xjhc8cpRsRVVof3daxT5iIK0hSDZ4c/6yvq1c/I7QIQQDBA1/P78G/Mb6vcrN6uodHzRI416vNFrdIaGhwBDfZib2UrPwgUdVg/8L1veOi66emfZnDdmEEwSF6S1mH21CmRfQPGgWVMieqwJASDin4JtwsgwAVry7t3bcnmVyAQQl8hu6Ec8LB4hff58y1IL7Hz7ZG8DuvI3pmdJYxrsbKkHGyfEhpH3WdSGFEqatunY30XVKl2LA5+Sh+kWWA3ZcncUneOhwevoMnHmiKolaEBSX8rmciXVKztUK1LDPUcNWL045YtNchB4US1JlnQ/r6xEqGwGney98WJR8lhNUtnCYYZN8r/e74W5GioWKXAj3Jt1cicgRSYcBbyvRtmFQINkqNJiISiyarv+g4LFB90g6MS3YBwL0jr5Sjq9T4Bs5OiP4oqfvvCXSwRoMoiDprA7xzNEdxOHwCdBjM9hk0pKYH1PIU6RY5/xbt4JFk8Org==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(10067099003)(56012099006)(3023799007)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M6xijAb5j7hRNClPDmfQ0t3CimcpjsugYQx2gTL7Sd9yXGg+Dep3jViKITNukhjFcTDpfc6yfexrkfWZXED/j+xhMDOdtwWt9vtYQbHpJpjLdPJQ5TI4fBcxJtFNQ0IVyb7DWzq5iBRigaNi0h9TfRCZy0iPm0V+5SNRnu/L9KQzfMaEzYgSP6f31rS96WZ8rXxFjnsmx3yYBsr8F7wLGXBQsEcDZtDNFiByv04Ny23nPEth3q0cYL/9pBE30qPlB+oytYr+1fiepDlZu/7ZQQYiKe2CtJBVxIkOeOkc1QRWIypScbURiWz55RKRXP0A78PxooAw0C7mISjhTInSNzVC48u3pIAdfyaYZpYJOYHvFwElBXyVfsQnDOw8291yM6YRIUhMayBO0jEZfO/L0HKYnRbkVbJVYUsPOKAcx0KJmkh1WC5MVy23x05NVdY+
X-Exchange-RoutingPolicyChecked: J/VrXOnYUb+n4TI9fuLXi9hU2UPRRxcc3i7KFgtuwYKWHfIYolpiYdLn/5C3zw93ElnOVuBznGHVQKuky2Vmd3VPeOxJx7f6N+XbDY468wKhpebyvtu1Z/nApRZ1h/99ucVNnL3xFeFbShvavw4qXYc5/RyGRFZmkePEu2ApXDnV6pDIJPPjKcKgPMfzWOe1cGBR3epP488DzEK7la1pKni//U+OMyP4vxn3x8WmUTKAKkZy4+fDaHivN/xT4oJvMevnRQ+fhp++NQF8wvhysmVMVDmgEJsFbayIoGHaCAJCHgbltNL1BeAyvux25N5+EKHELawB3mMjqUvAkhi6lw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 21:54:53.5638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd7d0bb6-a60d-47b3-4575-08deee853002
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8150
X-Authority-Analysis: v=2.4 cv=PcrPQChd c=1 sm=1 tr=0 ts=6a6bc831 cx=c_pps
 a=V2btASzwI3AgjbPAPCrjFw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=NEAV23lmAAAA:8 a=fGhLjsSNAAAA:8
 a=p-9UOXJPfmAuPFXLY40A:9 a=LYKFdyShAPKLkGq8p7WX:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE1NyBTYWx0ZWRfXzsoyHwxJbX0P
 E5YzJ8ctQExubJtP19le3uzo9gcCn3fYsckwZNT9S60zqKkjgTmoVnDFEddLSW4FfEiQMKYbBBH
 c2zKv+Le3HDcfSHLuCr+MaeeSR4xYFQ=
X-Proofpoint-ORIG-GUID: TkqJf9k_znXHGDsKiwoLbYdBKK3CMY7z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE1NyBTYWx0ZWRfX0Rn746PT3Uff
 UPuwwbeUiCXXht49uJEVMJorUgc8TpqKSM0SEy7FpnIYQlBrehn0c00AkOi5XAFrHYN0fD+FjDF
 g0gmD0IeKIleHp2w6qmTJHWsIC9lofLl8jpFU6eQpN7KLKm3OoLfkNN2AZNzJEFarn/V38sjc8m
 OgFuTIjZNKcMwlMmmimA+bsFWKv0gJvfzwInoSjUfTYMHwKUYWcyv639/K/9hky0ilaBZ7b/EWT
 q89giZ5ZDjs6LMXwM9WJD2V0DVei27Tg4c6EIoo3KxZQGr8SbQ2H6B8mbos8nV38X0DHwRAcLd2
 rDgIgl9+3QlNAmYQ1GWlnkS5q1mMfSLDwUXWjGYOWHbwFvTPCgpL/t6+11vWlllAEXBlqtNXkxq
 TwNjOM19JsatxJ1KJM5uLKR1pRyT2cJjUtjV9NwCBUaDLlrUmpLu+F+F7F5tEVSM950JuWkuLRt
 YxCeJSyDn7NZ18GfyeQ==
X-Proofpoint-GUID: TkqJf9k_znXHGDsKiwoLbYdBKK3CMY7z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300157
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=o3VIEGm51FV78
 cRFtY0/N8TNvi2OYoKTVidxiJDesTQ=; b=ZQMrNklGBZ+62+ZqOBP15BcbaMQ+o
 CUqUa2/h7+wqIUt23Uq+eRrZAlTtiZVrJNAx68YJv34t5KbjH9GXqImJoP3KW4BD
 5ryRMkrnRRzzDsaLzikTu3NUCwKhN6cuA3526pfn9TU1hDgXh4FStygYVRCDxLNg
 Xnx2/QzEdB0Zf6aYxx/VufG2h2MgrSeUWXzO3nRAfAewZottQ6FVGVi06QniCMyn
 7gT6VjpBynSv8sNe98vrPB3j+XCwRusVXMG0/dNehc4riqHgR0GbdNifCfDVNdkV
 pcHf9h1WOK0/9L+FUutK2nSvtUE9GSIRvnQqDyDJsrdg45447poR9eqSA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3VIEGm51FV78cRFtY0/N8TNvi2OYoKTVidxiJDesTQ=;
 b=J2qlqYg3tWA3KRGWS4rRV7VlcvJO3xkABTmtMie6298Ym3VNESp+Hehgmvf9c8HusvCCtKCrwvaE/X3De/Lq7t5KMobMCEwNtKR5aU5RjRDfWkY1iUgSHCI1Ma5H6+zSsfIAoEl5jr2zVnpX4xw+SzYtYXHMjGIHMsF23m2S+lI=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=ZQMrNklG; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=J2qlqYg3
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

From: Randolph Sapp <rs@ti.com>

Resubmitting with a synced rm-cfg.yaml and tuned diff parameters. We desperately
need to add documentation about how the rm-cfg.yaml is generated here. And the
beagleplay needs to get it's rm-cfg resynced with am62x at some point.

Since it's been decided internally to follow along with what Zephyr is doing and
make a completely separate device tree for the 1GB + eMMC Industrial board, I'm
resubmitting v3 with the variant support patch dropped. We will circle back to
enable the Industrial part once the dt has been accepted kernel side.

See the following link for more information regarding that decision:
https://lore.kernel.org/u-boot/DJLTHZL0ERIG.JV1UL67GFIVJ@ti.com/

Add initial board support for the PocketBeagle 2 from BeagleBoard.org. This is
based on the current official series from Robert Nelson [1] and work from Bryan
Brattlof [2].

Now that the various memory issues have been resolved we can clearly see at
runtime that there's an issue with the current device. One of our reservations
overlaps with the u-boot stack. To get around this we'll need to change the
relocation address to something we know will not collide.

[1] https://github.com/beagleboard/u-boot/tree/v2026.01-am62-pocketbeagle2
[2] https://github.com/bryanbrattlof/beagleboot/tree/b4/pb2i

Bryan Brattlof (1):
  arm: mach-k3: am62: add &main_uart6 to clock and pwr tree

Randolph Sapp (2):
  k3-am62-pocketbeagle2: add initial board support
  k3-am62-pocketbeagle2: add support for efi capsules

 arch/arm/dts/Makefile                         |   1 +
 ...> k3-am62-pocketbeagle2-ddr4-1600MTs.dtsi} |  92 ++---
 .../arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi | 336 ++++++++++++++++++
 arch/arm/dts/k3-am62-r5-pocketbeagle2.dts     |  35 ++
 arch/arm/mach-k3/am62x/Kconfig                |   1 +
 arch/arm/mach-k3/r5/am62x/clk-data.c          |  19 +-
 arch/arm/mach-k3/r5/am62x/dev-data.c          |   5 +-
 board/beagle/pocketbeagle2/Kconfig            |  60 ++++
 board/beagle/pocketbeagle2/MAINTAINERS        |  10 +
 board/beagle/pocketbeagle2/Makefile           |   9 +
 .../board-cfg.yaml                            |   0
 .../{beagleplay => pocketbeagle2}/pm-cfg.yaml |   0
 board/beagle/pocketbeagle2/pocketbeagle2.c    |  84 +++++
 board/beagle/pocketbeagle2/pocketbeagle2.env  |  26 ++
 .../pocketbeagle2}/rm-cfg.yaml                |   0
 .../sec-cfg.yaml                              |   0
 ...onfig => am62_pocketbeagle2_a53_defconfig} |  25 +-
 ...config => am62_pocketbeagle2_r5_defconfig} |  11 +-
 doc/board/beagle/am62_pocketbeagle2.rst       | 279 +++++++++++++++
 doc/board/beagle/index.rst                    |   1 +
 include/configs/pocketbeagle2.h               |  39 ++
 21 files changed, 966 insertions(+), 67 deletions(-)
 copy arch/arm/dts/{k3-am62x-sk-ddr4-1600MTs.dtsi => k3-am62-pocketbeagle2-ddr4-1600MTs.dtsi} (97%)
 create mode 100644 arch/arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi
 create mode 100644 arch/arm/dts/k3-am62-r5-pocketbeagle2.dts
 create mode 100644 board/beagle/pocketbeagle2/Kconfig
 create mode 100644 board/beagle/pocketbeagle2/MAINTAINERS
 create mode 100644 board/beagle/pocketbeagle2/Makefile
 copy board/beagle/{beagleplay => pocketbeagle2}/board-cfg.yaml (100%)
 copy board/beagle/{beagleplay => pocketbeagle2}/pm-cfg.yaml (100%)
 create mode 100644 board/beagle/pocketbeagle2/pocketbeagle2.c
 create mode 100644 board/beagle/pocketbeagle2/pocketbeagle2.env
 copy board/{ti/am62x => beagle/pocketbeagle2}/rm-cfg.yaml (100%)
 copy board/beagle/{beagleplay => pocketbeagle2}/sec-cfg.yaml (100%)
 copy configs/{am62x_beagleplay_a53_defconfig => am62_pocketbeagle2_a53_defconfig} (88%)
 copy configs/{am62x_beagleplay_r5_defconfig => am62_pocketbeagle2_r5_defconfig} (89%)
 create mode 100644 doc/board/beagle/am62_pocketbeagle2.rst
 create mode 100644 include/configs/pocketbeagle2.h

-- 
2.55.0

