Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B953C5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 11:59:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E88C40C2D;
	Fri, 14 Aug 2026 11:59:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P8NUCrmNZ9mF; Fri, 14 Aug 2026 11:59:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E4D8040A11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786708787;
	bh=+gSU0llCc/fpa4Q4HCLRr/J70+bUTnzXZ7tEdigMBiQ=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SRYTG0ApA6BViHw++juToVAdsvHMINmJMsQzXxJfRbZh04kRdeZEXEHkPnrNphMSY
	 8CRMyKXQ0PVeVLTwW4iPRiBGx0OsMx3vlk4VNqNtLiVA7kGMgykYfcPI8lbnStYywz
	 iQY4VF3V/cClg+GtM0Yb7tuFhwZFL+0gYtndOfq+Si+geIOIKnwtoQxyrb8PxomgdP
	 mOPXAZGTcWtNgOsd/kKFSbeFhGNJt7uPgANFdaChtdy5V1se95kn2VQ8JoZz+jv0uD
	 1A3GNmPLDftSAroATYH51r8ui+VMj/7PvjksRBmnMS3LQT/JgDxaMp+cfz6dwbQLW8
	 r5xaEJ9jLjvzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E4D8040A11;
	Fri, 14 Aug 2026 11:59:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5339C361
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:59:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 38F63607A6
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:59:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id soDZX-vkoVOs for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 11:59:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=n-francis@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 31121607A0
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 31121607A0
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=S37XgZnM; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=T7VSR9pk
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 31121607A0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:59:43 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67EAf5wg1104508; Fri, 14 Aug 2026 06:59:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=+gSU0llCc/fpa4Q4HCLRr/J70+bUTnzXZ7tEdigMB
 iQ=; b=S37XgZnMNZLyZjW5AxoOX3/47/ddtuQvRD2HbIR6y2+g1/lj5S5FKBGu4
 DJkoYLxlJNZRtIVu56zJH1kFQu651pnv0Jf/2NbywD6aRMX9MbNSqYSFK/nNtnfS
 cvA5r8Vr8+PKoO39cZqULfutOVDtSM8SoBL4XuINDnZROZoqLMf+9eFpr/On2xm5
 RT/7PmMzno5DU2ZaUMeb4WPfspkHDpffe9ozofgEjniQmZ99IdBI3+JxWy+vfhu6
 FGLEzf5rEK0KrCEB1gA9A7xRmGnAn3DS8BuS21AJNsUqOWs600oAM5750TQsflA1
 jHylbGfo+zlwHApOpAD/IB6WTeZ4w==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011015.outbound.protection.outlook.com [52.101.52.15])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g1x2eha9p-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 06:59:42 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUmtVTlnNVn0RoHZzUOxIWkEt+kvvMjDPqgYKCVVZKhhrLzKXYOWaF3VzD0c8JD/51cJYN0BXlZ1SykSSYQjVY/Ut7WHbVCyTyeNoJMXcpT6uyg/MvR1d/PNiDIiXEkkET/QBb2aegr7GnMYoFXGXHkatJX3q/NUsQs70D5Lv66TbLys2VSAvV3x1Rxellw1YeuqtPo6SuBrP0Wd7dDfdLkqpPndvJC9OTjVMvEW6AwzkrBMnBv83s2OMnxV1QPACpYsr3SCXQe4Rvp/d13YM/7d+g9TZGE9EOeno/GNCZSrosfpAxeN6sRQlSYRryD1H8VLQjLvbiWQ/ZDPHSf/ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+gSU0llCc/fpa4Q4HCLRr/J70+bUTnzXZ7tEdigMBiQ=;
 b=QwxI61ePml8GdxSgC5C99mHmUMCB2h92uP4im8/dxglpZwx0L7o+RTPyasMDr0crFNg5i/sX3g/ZzpAi+Zd4Grg2xqkqpc9XO4lG3KCiGzolTP3oLu3+KYBwmnvxifZvX56RmN4sHmdl6CkqMzUcW1NFwT++kUE5EY7YhdyE878SugUPEKt3Wkh09p29qOzyRG5yOkZTfzY+YTUXCCm1Af+GWL7uw9vvVe/69tYSr7Mxe4kXGaddAoacZD6WWo84fiA8C0UuLQzRcXLRhj1NIC2iMu+Q3B5vp79SpOKW2TcrpNBeRaL7NNc2FHp9Kn8wQgixSzUpaNHcyKv1WNWhww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+gSU0llCc/fpa4Q4HCLRr/J70+bUTnzXZ7tEdigMBiQ=;
 b=T7VSR9pkF53fZi1vi0svrvoYrVHff9Je+pSWjJemg1hBmWoeM36xSiMPiJsZGNSNb9Y4NhaiwZvPt7nfLEn8Y2iUmo6sbY2EqqE0HUFIlhcnxy2U/qQD1tZeAEKr1ZwsrGwaroYUasXxftab0UwA930Axz2U4mpLWvKjt3BaGCA=
Received: from CH5PR04CA0018.namprd04.prod.outlook.com (2603:10b6:610:1f4::29)
 by MW4PR10MB5881.namprd10.prod.outlook.com (2603:10b6:303:18e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 11:59:38 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::6e) by CH5PR04CA0018.outlook.office365.com
 (2603:10b6:610:1f4::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 11:59:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 11:59:37 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 06:59:31 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 06:59:31 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 06:59:30 -0500
Received: from [10.249.132.191] ([10.249.132.191])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67EBxSWT2689397;
 Fri, 14 Aug 2026 06:59:29 -0500
Message-ID: <47a6d904-f9e1-48a8-8c47-836542094975@ti.com>
Date: Fri, 14 Aug 2026 17:29:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] configs: add semi-falcon mode fragment for k3 devices
To: Gokul Praveen <g-praveen@ti.com>, <trini@konsulko.com>, <a-nandan@ti.com>, 
 <u-boot@lists.u-boot-project.org>
References: <20260814102153.44487-1-g-praveen@ti.com>
 <20260814102153.44487-2-g-praveen@ti.com>
Content-Language: en-US
From: "Francis, Neha" <n-francis@ti.com>
In-Reply-To: <20260814102153.44487-2-g-praveen@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|MW4PR10MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: 039aab29-c311-450c-a1d6-08def9fb83ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|56012099006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ksCK/9qnBxKeQTmNHztrWdKRmgg+6HEL/NXEeXqmeFPUSOI63VoLQtTzZ/ewee9W8rcGTGDLj1fHU1SEAUlL7cSxV+5In411mlrFDq7/2FvQ8oNivGqmctf6iVhv+48vhPovt6Vrg2in/uHN3gvDSEbNs3kqWGP1Jcgfj6YCDjarZom3aco5nsbC74NpsH3oKqkV/DslA9rgodMc7uEBvBvgiymRwdwsQeINR2z5ZYrV+cce4ZWdfWn7Xm5gyjgRCMc0rTBTej+3Gz2GzY5tSVrDzRf/95Wax9oyYEqCg+bJkb0wTrI4D8GVP3WXFb4korME5FvA/M4PS2YOeW/Vle3NIcYJZpOiIk2YhW7j4XHlGNz0IN2BCdt6O3szlvVHwydpsyck7sclV79yQVkeCxRwKrX0OMA1T6DHk8lV6t6zQV7oWwi60Js0lALaTblDQqnURbzfsjScPslLkfwsUgHoIku4U2HRgRghB32NUFCpnkNhPHaAuMOLy/ZehoUnPxBYleMz8BAhEQtP59wLV4NMEvxGRAjdQ+FDH0gn7GyHbgGSbQJQVvuKey9mQR8pLSLmrAqSzGP1vO9J0rUK3xuyDIAfSsoazo+P9kffWuraHBQUjPKdx033Oqg+8PSXWMc91z7yy3CH7O+XGECH25rETEsL0wFRdrawZTt4CXz3BTAGYAkci/CK+rvu5t0x3ZrNeD890s1PBP3/uPmdLQ==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KNZR5RNTLI8nsP7vR7lT2xeok13SxHSkXrW24AarAbchl2D4KzlkW0doUNMoHilOsgeX8AhMkCPCCwSlh7JFrAtpobNGvMvaUDApk4NrLnuKznGTlIVyqLckomPP9ZBF8ovU14YnsPRVZvyUY2eoJiSjF790uzO+rblOy3csAz/6dkFFBknFcWbIhYRLfQeWMNhPi4OfxEI6KKfEmkcuixSN9LP5JZTwAuU0hUXRruXsR3wjYa1LEdOXk/Gm3kSetIZJjlhdKMahIrpJHnQNZUI4Tis0Oa3HUTvuWY4q6QhNBKMRaGbsJuEnpL5S4l47NWRu6BOVGbgmxv8cv7Q6tPst5a9fhHc9AQAmx0DGd+pb1pIXK2J5GPsosHGUcsBDP5aQrRdHaoRNyItPzlkldG3LcbKIdg8VpJNyrkqiPVCX+/iQfOfLTea+rMtUn+Wa
X-Exchange-RoutingPolicyChecked: IE69VkT7ol8V1cLeTOjfRg2rNJABYvd/IG+nul1RQKD3ThiBBfZiSlEBjxrYCfD/7Lrk4dsOGW5DFDukUcbjBbwEoWE9NcdXTM+mQrAM+vk5tiHq4LEO++MmGr2I9gBA8uEBr74Fgvo5p4RvRJ1RJsJ4JyqBkr127jhl2nnuDm+QbeJ6LfGqJJdTVz5vPIF4J/xH3XBdWrs+e1DxJQUUkE03e3fcgussQ3OZDtWBZawhVgAWwlFZsh2/SQ/9L27vZHbBc5tTQiJrMExJmUiGry3cxrKYgBCtExw1hv7TDBIaAK2BNzIdeLyZV3w2680GjqZIBIe+uRo2xL196Yb9Ow==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 11:59:37.7802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 039aab29-c311-450c-a1d6-08def9fb83ee
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5881
X-Proofpoint-GUID: hIGPMovNMXsix7uZllPlP5t41UEl6wiC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA5MSBTYWx0ZWRfX693a1NDz9col
 HSQ9zx+oGwf72PoZ/iyR9DKejtwaF3XWNvC3Ld4hCzWCeSHS7pqOON8ZepGhuoSb2AlZwoYKmKd
 U1rKXKQQ3fmM1LrJUfBp+8L0rEAbZfW0oET2YDPNDCDLStAx7vGk8SXwHUi9OKFJ6Q0slLh4mZw
 CzTzjJmHZjAYnkzZ/7K2jutfc0NV1GkQXN96/nL+rcTQu+z8bYu9QIR4TmwhMV8coRZ/hwHz1sn
 HF+UOgpyfA7+8PjWOPNi1SaQCBE94FDi1VptHlcMKEAUFYEKbNnRk3eq3BLKHfmZz9MRrFEDVl8
 TYXR4vX/OIGbFU4U04x9KMrfAkrysKjwiDvqBcdUHCcTvjruwXqzFcJAEcnMMviiCGhDjjuair3
 dCvK4PP7P93B8fJO4gnoWu7kxaxGL3WWMWtWEUT3RpT3SHq5NfVJ6gtHZX6wEXkKOwavZ9vQlXP
 /Ev5pYsM5QH5f9qWKng==
X-Authority-Analysis: v=2.4 cv=GYcnWwXL c=1 sm=1 tr=0 ts=6a7f032e cx=c_pps
 a=33ZETTsaPBFHggYVnTYjDg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8
 a=Jx8VRUFH-caccIuq9qMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA5MSBTYWx0ZWRfXyLK/+MyQXjNa
 Hz/oMtQPoU4NJR+SrkFL9HEfi4qAqMLgcTIJliJqozhjkdgnrXxyiqhddewP73S9uSi19oCdhgv
 19Z3+LWDuHdRC66PmGUtJyqgWKFvxIY=
X-Proofpoint-ORIG-GUID: hIGPMovNMXsix7uZllPlP5t41UEl6wiC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140091
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

Hi Gokul

On 8/14/2026 3:51 PM, Gokul Praveen wrote:
> This fragment enables semi-falcon mode for K3 platforms by
> modifying the file to be loaded by R5 SPL and updating the
> UBOOT proper load address to A Core SPL load address so that

Slightly confusing wording, but understood.

> R5 SPL can load UBOOT from that address as A Core SPL is not
> present in semi-falcon mode.
> 
> Signed-off-by: Gokul Praveen <g-praveen@ti.com>
> ---
>  configs/k3_a72_semifalcon.config | 1 +
>  configs/k3_r5_semifalcon.config  | 1 +
>  2 files changed, 2 insertions(+)
>  create mode 100644 configs/k3_a72_semifalcon.config
>  create mode 100644 configs/k3_r5_semifalcon.config
> 
> diff --git a/configs/k3_a72_semifalcon.config b/configs/k3_a72_semifalcon.config
> new file mode 100644
> index 00000000000..7522acab950
> --- /dev/null
> +++ b/configs/k3_a72_semifalcon.config
> @@ -0,0 +1 @@
> +CONFIG_TEXT_BASE=0x80080000
> diff --git a/configs/k3_r5_semifalcon.config b/configs/k3_r5_semifalcon.config
> new file mode 100644
> index 00000000000..0217ebc81a8
> --- /dev/null
> +++ b/configs/k3_r5_semifalcon.config
> @@ -0,0 +1 @@
> +CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="tisemifalcon.bin"

Reviewed-by Neha Malcom Francis <n-francis@ti.com

-- 
Thanking You
Neha Malcom Francis

