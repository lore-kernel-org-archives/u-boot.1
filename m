Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE877C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 13:43:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B2B5C40695;
	Mon, 27 Jul 2026 13:43:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bCQzSiQTFDzI; Mon, 27 Jul 2026 13:43:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7423C406F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785159835;
	bh=KSj/coi8aNWiP49gO31GThU1raXut+YvKLxtwN9PRpw=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Tyyn8tMrhDghZ6MH/9xFbkBBO22oildc3NV+n6xSNm+jvHScpWNRinaNtpIgWY0yO
	 rCjOMtnPXG9Po3P4UP1zMxvN7J0P0I8LkHA9n5UNCXSTCBdI1Nq6K1GfOs+PRaBvw1
	 Xeiy2CLb6e5rU9L+vRbrqPxbFBKRUQ/7lnC2t/6TyoiGSCLmUr+EDRJ7nJgNktiwoS
	 N4VDUEDRb6vuWwwkupfivalbhS57KFrXbmIe4Idnki6zihhbNkqewB7/Tks3TBWK5E
	 V9Ah+CcALxXZki4zisnFhV6FAUd28m718mDjk3vk1HO8+K4N+Joht+bOpqSzCUmDNb
	 qQpqNLvapnKUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7423C406F5;
	Mon, 27 Jul 2026 13:43:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C1CD139E
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 10:55:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AB64260692
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 10:55:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xjtYwmWsjC5V for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 10:55:30 +0000 (UTC)
X-Greylist: delayed 1435 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 27 Jul 2026 10:55:30 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 816C0605CB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 816C0605CB
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=g-praveen@ti.com;
 receiver=<UNKNOWN> 
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 816C0605CB
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 10:55:30 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66RAKIe92391914;
 Mon, 27 Jul 2026 05:31:34 -0500
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012023.outbound.protection.outlook.com [52.101.48.23])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fp4h58a7v-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 05:31:34 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEOm8RuADvZok0YLd9HSgz6ProAGGpAfrG0LVMxQFGb8/K9YXK+J3H6C3V65JrBpYoAG0nIvTPZABqJLMcjyIq5dLS419cQcCFr7wDT1bW9zqsdF/RvY9RFpF4dN9zdk4LfOHA1WBLggPLgiiZClffhTeL8ldNQvqEHK1mSRRZBAOvL+10ySc+pJcsCgPHoToTrZzYO29Iwa7YRKRztYcUddAgZ/o6qTenWom8aPNKwb2Knj9I7/sW4io3tf09gX/nBs/ZLIclLhpDGZkpoSJBAjCwQV60RfHQefihtoV5gGC7mgl6VonoSajN4q8Czfwq/UFv/4MSzagBp292a6Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSj/coi8aNWiP49gO31GThU1raXut+YvKLxtwN9PRpw=;
 b=Uj27WMnNTl99NqB0qmgbZZABQbxQ/9Y35J/j8DhmWL76UfCkw8Kx6/5fRmcE3FHMSgNLPb7t4OWxY10LxJ5Pp5uFyBFgNho8jzS5vfmux//RMFCC3/lU7IGU4ZoytRpdLqy4F3E3W4VE3SZYp2slDumuOUtDlPaGgzmOWbWKEcAlPIc7fMv1fwoFE42ZjglptR0HT+jhTb9Jsv4KEce5NAbA3dCoqs6ikBNEZ7ny8y6hz7UvuOAjB1tfgkW5IyT1ZEdH0J4DKephdo8G16IqWA4n0Qo8Ce0JbL58WspXtwfFx+XYYMTXyRpmOGqfJNz+0NcOzQonGk2ybYJ6diOaJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
Received: from SJ0PR05CA0056.namprd05.prod.outlook.com (2603:10b6:a03:33f::31)
 by CH0PR10MB5115.namprd10.prod.outlook.com (2603:10b6:610:c4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 10:31:30 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::26) by SJ0PR05CA0056.outlook.office365.com
 (2603:10b6:a03:33f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Mon,
 27 Jul 2026 10:31:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 10:31:28 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 27 Jul
 2026 05:31:25 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 27 Jul
 2026 05:31:25 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 27 Jul 2026 05:31:25 -0500
Received: from a0507176-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.53.154])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66RAVMZ8945932;
 Mon, 27 Jul 2026 05:31:23 -0500
From: Gokul Praveen <g-praveen@ti.com>
To: <trini@konsulko.com>, <u-kumar1@ti.com>, <n-francis@ti.com>,
 <u-boot@lists.u-boot-project.org>, <g-praveen@ti.com>
Subject: [PATCH] arm: mach-k3: j784s4: Add clk and power support for
 main_uart2 and main_uart3
Date: Mon, 27 Jul 2026 16:01:22 +0530
Message-ID: <20260727103122.95270-1-g-praveen@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|CH0PR10MB5115:EE_
X-MS-Office365-Filtering-Correlation-Id: b97dbaef-804a-4c73-d46d-08deebca37ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|376014|82310400026|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: VB4OuHjs2Ti6XJT2+Aya53DwK9fXyj/9LzprrcCH/XLvYVDLT6PBhczvKWvUUEx+exVfeUKBW5qQS1jxQINn75Y6mViaL9QvQBSG/Lep4PyzgQVZuFyX+XULHPh9uQofkLAsNP/JkzsT7XZ8koKLIATcHztGTvZejbn0f/2hi/YYXcnN5z+pg5gQKCnuVN6ESiytFkIGgW5gWAjylnIzsOIh51EA9g9wM5uegdIaevPj2AWZw1ViJ7PBGs7JNcQYr3v0zgWdiecZNeRUlHXRBxyPg55aFI60xoJSgWK/8hC1ojT34zPSUnol5pa7QuwfFuYongnV3m2jf0yfZAEAVSpam12GqhfltK/vpNOinUi1+bwL8PqalnCPkoE0Wo1Zv/HVT2Jbf4amOS9drv33uodGDcLV1O/WjvZnuaMejb7kC1CaxRX7c1H3Z2jrBDhKJEcKPTl8PgRjGJVPD2JycladPHPJjs0Vpd5lGkWoPmQuEWeaEawbArq7Z9O7DqCcS4vf5PEi0W1IFtp9W53rArPq5PzokPuFUR+FTQUSTE5aG6AekFa/R4+y7AbmbITRKzKJUYLcl7v/cA6OgyE/C3WGoHRwJYhOXUZk08SJbj7pQEXN4uVaHQ3iHuWwAkST9wOVufrTfoAX3/V11yXBi6Ch0poDzCGlEQb54488okxsnqkNToGsAP5Yg5u3hoaP
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZawV2vWOoLchO0gilH2jQfNxCT48x7UuAX8pU1ha0a/WSVsgzefdgMluxEp1zCZyEjb2GnSHot8oUg55+irapNKwp72QqmOEt9ihNzTHvpqc3E6MhEbzLcdUwJli+tpb2k0gdE/OsN6wqxfdkLAywufyBCjlM4pE9ZB1riprctIf6ey9AtDxtNMU8oS1te0CTgxsI68tAPOJKbRc+gLAFIy9dVdPLs7pUF2t8K82VIMJpEkMTj/OYz+Np/cZZHgWnXo6hYlJY6+RBXdqEONr5kaMHjXGOCsM4AZ6n+c6qzq7pIIeRyy0vLcLrMGlQrhPeUav119gXXyM6uBVCkxaQugYlObwt0R4CZ2sePRuKxGTwHa8j8T8f11Cls0oE4A1ZqeIUpbvHtp6eu/K9nKpIqvoG64MQzNgRDDNprS2p4XS+ufrSmrFvjllKvcm8BcI
X-Exchange-RoutingPolicyChecked: X9pNHM3q4CMkZH620YwNK+pdunuCsOTwlUV5ZSBxpFxFuLi6WFVJTDb4828JvwIojGf8/ZNsDNSVm2K/31FEKJjUmpPmSE0Hw1B/hXRMdMt2gIjHlOtZ1mrD9bn1IcqMv15BZ7QhtaQNHa9XgJOqf3O3d5kA6PFXZ947R7C5nkTFPLAJJtGgjgY2FnwLev25tJuGXybAqyOKvgFnNg6XK82/OMVBwd6FQ/VM1bDI2JiTGHWtceUcpJvpnNgm6p06CitBTrOYPY7oefCIGqCakKdcQERFjSHPVea/As07B701Q0strLfMRHqMBxW0GsUod+AT5RUkdmCptGUmUFzQuw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 10:31:28.3838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b97dbaef-804a-4c73-d46d-08deebca37ca
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5115
X-Authority-Analysis: v=2.4 cv=M7p97Sws c=1 sm=1 tr=0 ts=6a673386 cx=c_pps
 a=WV97qI32orZZISq0e28SMA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=VYyEl-X9wEYJDNsMKlAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEwMiBTYWx0ZWRfX61EeDbCNsxjf
 0f5jbUgIdnM/2FgqBdJeSQLWkweyffkt8bzRjgwF7E7HVWidDcqE4TK+956pEs7J8EbvVBkOkOa
 uoFFxfvblbxZR1qH8hVQ+0kZ2ls1oEY=
X-Proofpoint-ORIG-GUID: 5mW_byanEPQLUXN7Vie4gRKnW4JxVVP3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEwMiBTYWx0ZWRfX2goa/Xrmd0NC
 /Yt+dj3tu7SY0a/sJD0mkV/TS+0xccSeeWgT/rdsMu1m/MwZptHnKV6p9B3MX3vo9xAxxTK7nTo
 dNx/u+BzEAPKpG7vW5zlfYq4dc+E8/agZYcnEQQ2M05pPwp9FJTJqQhMpvQIVuEKHPEFWFkLXvh
 lWlqest1enWtuV+yRkSGtNZ/UXXg0PghQpZV9RLXrjDFnBCZ2TEKhzbWUWBiYD/l1Ud+y+jaR0G
 N+gz2sQD7MM471g8ze3fzQrA6/09RMDHQJfRhI/q3ZcQBNO6sXwscQYv/ehMfxUYkpyno61m9AX
 D6YPge6e5UTQPqXs96GskOeiKy82fc9SWm6EodMG4rImBL188cSsWlRqXhGuLmzVrMgOXFoHwmG
 byoQyUW3MRoT3a2YuUGUNGZRP016Us0aQKYj6enoGCMcWK0BnKxEseOa29bYJmGKrX1iaMelc4s
 BTIRfAqxJjBp/2jJXnQ==
X-Proofpoint-GUID: 5mW_byanEPQLUXN7Vie4gRKnW4JxVVP3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1011 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270102
X-Mailman-Approved-At: Mon, 27 Jul 2026 13:43:55 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=KSj/coi8aNWiP
 49gO31GThU1raXut+YvKLxtwN9PRpw=; b=cCB6LlMx7VC17o1JaFJa2vR+tTK0f
 HO1/qAR5DXFjne19AFNpVOkQZPZCZU0ig2+ETwWXWnzypbTA1HAY6xggP0RdElKK
 J4ING6U48fLcxGhh62RcUQ/+WvBuwx8BnEkItBQ9a5aIG8ARIwQo4dJ00v5yr2ms
 cBCfOEe76/XjIIIKnKdjkPn3gyxddimfTRz26erXz37D29ZjbvAmsXbmmCOpH2Wx
 DyZnNAg3vpFklUJE/INeeZZmgelStY392yyfLmSLpYIQ/X8L4t4/baJPoYXQPOUR
 Cd7Q+yVwxdbJ3iEfk2TIi1MHrHp75qdFaXPJBrkROX02h6eoQGStQWQWw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSj/coi8aNWiP49gO31GThU1raXut+YvKLxtwN9PRpw=;
 b=t1YSiT7A0lBthGeTWlgGqBHa1cnfZACnJGKvz7GnQqleAzSnEAXrokqTSx0Jx/+kHhlletohJ+5C2EyOSrCdNeDs9bFqfYv/aeEIUrC9+XPfcE3ijaNElfxEKIFPS02wH4DR5zXEOVGMlCpHaH3u10fnFeLFla5suQTMTEiI2O0=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=cCB6LlMx; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=t1YSiT7A
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

From: Gokul <g-praveen@ti.com>

Enable main_uart2 and main_uart3 for console log functionality.

Add clk and device data for main_uart2 and main_uart3
which can be used by main_uart driver to configure clocks and PSC.

Signed-off-by: Gokul <g-praveen@ti.com>
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
---
 arch/arm/mach-k3/r5/j784s4/clk-data.c |  6 +++++
 arch/arm/mach-k3/r5/j784s4/dev-data.c | 33 +++++++++++++++------------
 2 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-k3/r5/j784s4/clk-data.c b/arch/arm/mach-k3/r5/j784s4/clk-data.c
index 228b424d3f2..7deae563841 100644
--- a/arch/arm/mach-k3/r5/j784s4/clk-data.c
+++ b/arch/arm/mach-k3/r5/j784s4/clk-data.c
@@ -414,6 +414,8 @@ static const struct clk_data clk_list[] = {
 	CLK_MUX("pcien_cpts_rclk_mux_out1", pcien_cpts_rclk_mux_out1_parents, 16, 0x108084, 0, 4, 0),
 	CLK_MUX("serdes0_core_refclk_out0", serdes0_core_refclk_out0_parents, 4, 0x108400, 0, 2, 0),
 	CLK_DIV_DEFFREQ("usart_programmable_clock_divider_out0", "hsdiv4_16fft_main_1_hsdivout0_clk", 0x1081c0, 0, 2, 0, 0, 48000000),
+	CLK_DIV("usart_programmable_clock_divider_out2", "hsdiv4_16fft_main_1_hsdivout0_clk", 0x1081c8, 0, 2, 0, 0),
+	CLK_DIV("usart_programmable_clock_divider_out3", "hsdiv4_16fft_main_1_hsdivout0_clk", 0x1081cc, 0, 2, 0, 0),
 	CLK_DIV("usart_programmable_clock_divider_out5", "hsdiv4_16fft_main_1_hsdivout0_clk", 0x1081d4, 0, 2, 0, 0),
 	CLK_DIV("usart_programmable_clock_divider_out8", "hsdiv4_16fft_main_1_hsdivout0_clk", 0x1081e0, 0, 2, 0, 0),
 	CLK_DIV("k3_pll_ctrl_wrap_main_0_chip_div24_clk_clk", "k3_pll_ctrl_wrap_main_0_sysclkout_clk", 0x41011c, 0, 5, 0, 0),
@@ -604,6 +606,10 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(333, 41, "wiz16b8m4ct3_main_0_ip2_ln3_txfclk"),
 	DEV_CLK(333, 42, "wiz16b8m4ct3_main_0_ip2_ln3_txmclk"),
 	DEV_CLK(333, 43, "j7am_wakeup_16ff_wkup_0_wkup_rcosc_12p5m_clk"),
+	DEV_CLK(389, 0, "usart_programmable_clock_divider_out2"),
+	DEV_CLK(389, 3, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(390, 0, "usart_programmable_clock_divider_out3"),
+	DEV_CLK(390, 3, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(392, 0, "usart_programmable_clock_divider_out5"),
 	DEV_CLK(392, 3, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(395, 0, "usart_programmable_clock_divider_out8"),
diff --git a/arch/arm/mach-k3/r5/j784s4/dev-data.c b/arch/arm/mach-k3/r5/j784s4/dev-data.c
index 2bb1a88ab3b..2281da6a81f 100644
--- a/arch/arm/mach-k3/r5/j784s4/dev-data.c
+++ b/arch/arm/mach-k3/r5/j784s4/dev-data.c
@@ -47,13 +47,14 @@ static struct ti_lpsc soc_lpsc_list[] = {
 	[15] = PSC_LPSC(25, &soc_psc_list[2], &soc_pd_list[2], &soc_lpsc_list[5]),
 	[16] = PSC_LPSC(29, &soc_psc_list[2], &soc_pd_list[2], &soc_lpsc_list[5]),
 	[17] = PSC_LPSC(43, &soc_psc_list[2], &soc_pd_list[3], NULL),
-	[18] = PSC_LPSC(45, &soc_psc_list[2], &soc_pd_list[3], NULL),
-	[19] = PSC_LPSC(64, &soc_psc_list[2], &soc_pd_list[4], NULL),
-	[20] = PSC_LPSC(78, &soc_psc_list[2], &soc_pd_list[5], NULL),
-	[21] = PSC_LPSC(80, &soc_psc_list[2], &soc_pd_list[6], &soc_lpsc_list[20]),
-	[22] = PSC_LPSC(81, &soc_psc_list[2], &soc_pd_list[7], &soc_lpsc_list[20]),
-	[23] = PSC_LPSC(120, &soc_psc_list[2], &soc_pd_list[8], &soc_lpsc_list[24]),
-	[24] = PSC_LPSC(121, &soc_psc_list[2], &soc_pd_list[8], NULL),
+	[18] = PSC_LPSC(44, &soc_psc_list[2], &soc_pd_list[3], NULL),
+	[19] = PSC_LPSC(45, &soc_psc_list[2], &soc_pd_list[3], NULL),
+	[20] = PSC_LPSC(64, &soc_psc_list[2], &soc_pd_list[4], NULL),
+	[21] = PSC_LPSC(78, &soc_psc_list[2], &soc_pd_list[5], NULL),
+	[22] = PSC_LPSC(80, &soc_psc_list[2], &soc_pd_list[6], &soc_lpsc_list[21]),
+	[23] = PSC_LPSC(81, &soc_psc_list[2], &soc_pd_list[7], &soc_lpsc_list[21]),
+	[24] = PSC_LPSC(120, &soc_psc_list[2], &soc_pd_list[8], &soc_lpsc_list[25]),
+	[25] = PSC_LPSC(121, &soc_psc_list[2], &soc_pd_list[8], NULL),
 };
 
 static struct ti_dev soc_dev_list[] = {
@@ -83,14 +84,16 @@ static struct ti_dev soc_dev_list[] = {
 	PSC_DEV(140, &soc_lpsc_list[15]),
 	PSC_DEV(333, &soc_lpsc_list[16]),
 	PSC_DEV(146, &soc_lpsc_list[17]),
-	PSC_DEV(392, &soc_lpsc_list[18]),
-	PSC_DEV(395, &soc_lpsc_list[18]),
-	PSC_DEV(404, &soc_lpsc_list[19]),
-	PSC_DEV(198, &soc_lpsc_list[20]),
-	PSC_DEV(202, &soc_lpsc_list[21]),
-	PSC_DEV(203, &soc_lpsc_list[22]),
-	PSC_DEV(133, &soc_lpsc_list[23]),
-	PSC_DEV(193, &soc_lpsc_list[24]),
+	PSC_DEV(389, &soc_lpsc_list[18]),
+	PSC_DEV(390, &soc_lpsc_list[18]),
+	PSC_DEV(392, &soc_lpsc_list[19]),
+	PSC_DEV(395, &soc_lpsc_list[19]),
+	PSC_DEV(404, &soc_lpsc_list[20]),
+	PSC_DEV(198, &soc_lpsc_list[21]),
+	PSC_DEV(202, &soc_lpsc_list[22]),
+	PSC_DEV(203, &soc_lpsc_list[23]),
+	PSC_DEV(133, &soc_lpsc_list[24]),
+	PSC_DEV(193, &soc_lpsc_list[25]),
 };
 
 const struct ti_k3_pd_platdata j784s4_pd_platdata = {
-- 
2.34.1

