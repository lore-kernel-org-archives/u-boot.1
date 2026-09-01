Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 829A4C624D0
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 19:44:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1BFE1407A8;
	Tue,  1 Sep 2026 19:44:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pqt6guJiuDNS; Tue,  1 Sep 2026 19:44:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788291887;
	bh=v5zv2Vtm1xI/7gdCoKAngviD3H0EZFUHYrMklIKosfk=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S+HSJ40Y3XOnvz1jkNn9PT2c/UNcKAE4SGfo7nUBUEAQCD5m2Nh4CiZ6DRPScfX3Q
	 jRVQyP7aTUkcDtjEqTqy6XfmWXMd4UAb2NKDFFnl1Y0p99wx7W5twuv7ciEct9cjeJ
	 iYqHKYfxccEAcs/eH1m6XirP2ubxjR7t52/UO0q1cX9+LzsciHWSf+kYwdVlvkHt+i
	 TXhHpzto4ljxY6LjVAsiUec7dFF3iequAhB1vfDepRPfNqYptoHPhgIcLzmlQPBfKY
	 LYgGQIppOHvDoqVbz+GF+C1pFBsNyA/ri80L3oR2YaUr+cmYO5JynLEj3aWhIrkj1t
	 UO1mB77iz4b6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 227CE407B2;
	Tue,  1 Sep 2026 19:44:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C4EAC3AF
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 19:44:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B6B3D407B2
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 19:44:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5_mUKtVy5WJ9 for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 19:44:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=pOEEuaPR; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=puUt+dMq
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7485B407A8
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 19:44:43 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681HeNoW309549; Tue, 1 Sep 2026 14:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=v5zv2Vtm1xI/7gdCoKAngviD3H0EZFUHYrMklIKos
 fk=; b=pOEEuaPRlKHcF82YBAAMs0jQU592ofC9Zm4R3N7SXzMGaXD6sn/4MqwsB
 H3fnfhJEb03121YMtF/g5tBuEOBxWiYAQLO36D0oKMkZQV1VNLpAbItAJTY2I4DY
 tLK2zujAGhpViUkqfv0fRyqruzYhBZl3l/Uw9fT+Sn8WPrP/MtMrMpHY3i3TJoPV
 ghFMsgfwKAtlQFju+Cein2aURi61KrwTv6XZ8Dbsa7F2OXpMnbRSYRn3tWSQOKTf
 2XFONMn/4WqyUOE1Id6x0/fBcb2WrrJU//NE/5yNYkEr4xzZarFHfuK6Mpi4Nf3j
 wHnLFs12NVFs69P5eAFVtKcXQ0SKA==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gdngv67y5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 01 Sep 2026 14:44:42 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=opFEQtFkrKi4NjBBCiJhI6NNzPoyzy1KEakIXNAlbQiltvQSBI7Licsuu8xUrI+MnfZK6Qnorqo73ORpHEMAPugCaQaVUuetRObcA2o7B0QCNKSG0pVsuONemoC5bWQR9wdL9VzZ3DZHn+Ee+y5td1WFVON67jpOC4MIoeSXcIVCy8pwJgN3bE0jp6oCulO28xd6XR1/WBY/kU6ICG1MdUMTNH+HrFcMQs/mhdE8qdIJunaV2O7tEW7MerHda5eNhs3vM8u4l8VAWA5DRBbeFJbEcvWzY1iScwZdSwBLZ+ti1NchaQLgVF7es7yc/Mcxfmr/fw//AzkyEZUnPvzB/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5zv2Vtm1xI/7gdCoKAngviD3H0EZFUHYrMklIKosfk=;
 b=DxfvojaB5T3uCx9IO3OhJhD5N1W+qXKRwTzYJP0Pqu6Fz24eeGBtezTbXuJUbLu+tCJxX/4DHd1Z7LxSOVbn8dWARqLSFqQPY6geoSWe7Ju31j0gpBiV25oyrgIa/ER5k6jJFKbnUBavbqMwrMAWsN5vC+TuMbF2pBvKgdoVWCdiXSm0QmCblhMH45tmOX7yGh9FjBrODgv77+h/ofBq2FK8YSZwN8c1tf8ooQwe+4T4bLasKs54RA5/IcgPcmr8/vka5DgH5VQGEKiw8eZW+ShLR/MTD/W8QbotfNVqY30flLvK7i61PmxLN0zYvGwas7ooLj0OnX8y5T6qAdurgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5zv2Vtm1xI/7gdCoKAngviD3H0EZFUHYrMklIKosfk=;
 b=puUt+dMqMreNJeRUTBq8nsrp5zvaS9CzSs+ei+gx3YwfcGLL1Hxe46mbYv24YyZFukHaJ616JFOUeDklCMlFFU3Zp7QUBM/boVmW3kTBllSiFc9B+yM8N4heooWJvGG0VZJxr2av5/eemFVIF+0kcKoCpMiCvBAEq4Vi9ApbLhM=
Received: from BN9PR03CA0328.namprd03.prod.outlook.com (2603:10b6:408:112::33)
 by CY8PR10MB6561.namprd10.prod.outlook.com (2603:10b6:930:5b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 19:44:37 +0000
Received: from BN7PEPF000000A8.namprd05.prod.outlook.com
 (2603:10b6:408:112:cafe::50) by BN9PR03CA0328.outlook.office365.com
 (2603:10b6:408:112::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 19:44:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN7PEPF000000A8.mail.protection.outlook.com (10.167.245.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 19:44:37 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 1 Sep
 2026 14:44:19 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 1 Sep
 2026 14:44:19 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 1 Sep 2026 14:44:19 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 681JiJhB3398460;
 Tue, 1 Sep 2026 14:44:19 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Tue, 1 Sep 2026 14:44:19 -0500
Subject: [PATCH 2/2] doc: board: ti: correct path to tcl scripts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260901-openocd-tcl-fixes-v1-2-bbde8ddfe425@ti.com>
References: <20260901-openocd-tcl-fixes-v1-0-bbde8ddfe425@ti.com>
In-Reply-To: <20260901-openocd-tcl-fixes-v1-0-bbde8ddfe425@ti.com>
To: <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Apurva Nandan <a-nandan@ti.com>, "Anshul
 Dalal" <anshuld@ti.com>, Chintan Vankar <c-vankar@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, "Bryan Brattlof" <bb@ti.com>
X-Mailer: b4 0.15.2
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A8:EE_|CY8PR10MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: 568f7ba7-ba2d-405f-6a11-08df086174ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|6133799003|22082099003|18002099003|13003099007|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: gV3ylX1UzdHYoUbb0xb57IbZmfW8R7kYCRGkhv/aTJ7cXeu1VYXnF/KgJJISYtIclSKAbn3pFVzTQQBqy2cFfNUii0yHdfPnDPGdDjlZ4O87/vhBAno/516YErV3g1SHOrNzrTvK8I03wvGIiCxg1ApDVOKuoDlfgZ1h9KnSs5gJU8u9vIs0mOSUQ9PnIcMUp/VKVd7jxZcq3dJGPFDjxGgkmbd2CAc4q0Wi/2Bv9RrkcmLOw5RgWmgsWcjchm27a8eadr5UPSW1q5a208sn8c99eZnHbtrn0p1uPVho9Ei4QeXUOal4LmQ07AmmG9Ol4C8cyIfZWW0OlPXLVqqek/MXTVKfQNti4IzQ9l6DODmXHG/2cUms3YAFPs4BQbBIqQIC3exQJDfuaKzhU59VikltzG9+NuwTwk/YJ+gzb7VM5zF8Z++2WqrRbZoI1nciuslPbYROS/Jy0yN9QJWwQ7u3UEwiFC/8O0298KEvEahtrreZZU1Gi0ZvQM/G6FbcpgjGNI/+/SNxec3HFzvfgZJRq2x9Wj+d/yoLW+rTgB496nRxCiDqKM1yoMUsNNCJx/ODGZ223VdmC+9wOGLh5pzVIR60g/ywxZ0cEpTDK+68Q9Zg9HtP+7Lz7Znpw4L4BpSVvujGWADhjU2DWTAi0n6FAcSRvsT9N5T50SPdck5sgKCjzyxaK8N8S8LJQfUR5Eevzk9WZ5QRyZs7hLcsbg==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(6133799003)(22082099003)(18002099003)(13003099007)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kUabC0mB2vtWPYkfXf0+R6Mi5HwfxFy2X6Y9pKhjJJ34AanQULEYet3mgs0CUUS84LN0FkSGlWIOsOAZD4kfTxPpsljXfVt48UmRp5x+bNy3fgPinsFuyc36whAy9KgRn0iMh74O9IK86d1vIl6Zb+9aAyTFOMOWN8SFWPXzItLllKadzPzLvi1M9tUI1/S5zzEFgSYp2gFfOr2gszwWraVJX0VGj4DcadQTsWxdrpXmRlFciaM5bd9LQKC3FtRO/Bapt0EYkTbjLEyd4effwz67q4xWf8R+AXqfHuNCViQGsfDcU5Rsb5LH1HWsWje5ZSdOUpRpb+hPSVRXlIGNQPef/pePbSrYK/TsFMQTgOkGBE/MOKpZIwxhkjcUJSrsXFesPEeqoZ6N6WY+mDdDTAH8ltNIrrqKQbFc2Wn6tLvV3xEksTCp6XutVSp+eyl8
X-Exchange-RoutingPolicyChecked: Pfq8RGc4C/GUXmTlwPSfjcGtUFdwKVfAVmLCDogHCJgV0mf3tRe7uvwFht0BYkLeuMTDe78sQUbtN2swSyyd8/QlZyboicYZTsk/+OWuA56ovXqYEpyNO/hx6iMVhcSWz/IpV9KkkxGiXN1yVIdw0+8S0LjJRmF60Tq6Yu3FE1g4hFUWYj92Rqct9A8p9EJtoCbnh1DAcumFSVkyqqlHcgZk8gIYiZ/Q7tmLlCdtV0Rnt5CNJCo7o/w6kU5EhvGNo8sVteTPiLdKxAj3KSKvw9j6IJZ5hEmemMR4WMB9dUUL2uhsHkGmpMi9Qfvb8MrxM3ZwqPZjJ6+euIRI78VGJg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 19:44:37.3244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 568f7ba7-ba2d-405f-6a11-08df086174ce
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF000000A8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6561
X-Proofpoint-GUID: x6On16bmIh8Fs-TlstIxMQ6xyur8sKZu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE3MyBTYWx0ZWRfX2yj6MBvZZNyH
 iRnrfI8esG43pAze3Ufv1xiCItf26D7KTVYay8gM+3i+AJMrtBsRdAd/1JJdcU0GYP2gRCm7P8r
 +48idMQCGz6RDob6X+faiPNpYyg8G0XgAA/4Cwi82tkyw/zRUq4MhaH6T5xKdFOJpjoHC8iJy5j
 IaaFpKjMzMNd6vhKUGXMbnkx5eS3/l8Dur/Vra80cjXJ2Fa4CyvJrQSC97gE7DQOG23cp1ZPyvj
 +eT8RlzV6HzoQy7S01rzbqeumiQkgMQ3oPtVXiAKYVG2cAdOcW4KRqx0b5hE3Pnv3cH85fN8Ayt
 QMP+cfMMX1AJLEConFqs0Y0+h2ys2iUmGXLJwjOFwZxX0dPLNAoLw8JIQ8SIRlXohs+xLFTLoAu
 fcq7p14R0wqJBNFWlXScX9Nbk4wnJITftRcy9tFKQPeYLqODwnC9nDx3Ak8dnEFyPSIAlMFlnnB
 2/MiK1pFdporO/s7fFw==
X-Proofpoint-ORIG-GUID: x6On16bmIh8Fs-TlstIxMQ6xyur8sKZu
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE3MyBTYWx0ZWRfX6exhPR4Z/J/d
 lHkVIeEx9dtkn1jRoSHYftOWeZrMAyR8lwOq6XJPKurODnSrYyJh8YveC7FJNYk17MwzfjIBysY
 uCky+lx/TfwP29OJqm4w9bmH2KO7uNs=
X-Authority-Analysis: v=2.4 cv=I9JVgtgg c=1 sm=1 tr=0 ts=6a972b2a cx=c_pps
 a=XC7dmRpti89zb13hwgmGPw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=NEAV23lmAAAA:8
 a=sozttTNsAAAA:8 a=5vvVIb2TkaJkLzvN80cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010173
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

OpenOCD has reorganised the tcl scripts for TI's reference boards into a
ti/ subdirectory. Update their paths to the new locations.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 doc/board/ti/am6254atl_sk.rst |  2 +-
 doc/board/ti/am62ax_sk.rst    |  2 +-
 doc/board/ti/am62dx_evm.rst   | 11 ++++++-----
 doc/board/ti/am62px_sk.rst    | 12 +++++-------
 doc/board/ti/am62x_sk.rst     |  2 +-
 doc/board/ti/am65x_evm.rst    |  2 +-
 doc/board/ti/j7200_evm.rst    |  2 +-
 doc/board/ti/j721e_evm.rst    |  2 +-
 doc/board/ti/j722s_evm.rst    |  2 +-
 doc/board/ti/j784s4_evm.rst   |  2 +-
 10 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/doc/board/ti/am6254atl_sk.rst b/doc/board/ti/am6254atl_sk.rst
index 18a3520b39c7..0df058aee157 100644
--- a/doc/board/ti/am6254atl_sk.rst
+++ b/doc/board/ti/am6254atl_sk.rst
@@ -305,4 +305,4 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash $
 
-  openocd -f board/ti_am625evm.cfg
+   openocd -f board/ti/am625evm.cfg
diff --git a/doc/board/ti/am62ax_sk.rst b/doc/board/ti/am62ax_sk.rst
index 3453ed339e7f..b04bfc991ea0 100644
--- a/doc/board/ti/am62ax_sk.rst
+++ b/doc/board/ti/am62ax_sk.rst
@@ -435,4 +435,4 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash
 
-  openocd -f board/ti_am62a7evm.cfg
+   openocd -f board/ti/am62a7evm.cfg
diff --git a/doc/board/ti/am62dx_evm.rst b/doc/board/ti/am62dx_evm.rst
index 0d12e3ec1476..88071b3e69d9 100644
--- a/doc/board/ti/am62dx_evm.rst
+++ b/doc/board/ti/am62dx_evm.rst
@@ -237,10 +237,6 @@ detailed setup information.
 
 .. warning::
 
-  **AM62A**: OpenOCD support since August 2023 (git master)
-
-  **AM62D**: Uses AM62A configuration (compatible due to same core architecture)
-
   Until the next stable release of OpenOCD is available in your development
   environment's distribution, it might be necessary to build OpenOCD `from the
   source <https://github.com/openocd-org/openocd>`_.
@@ -253,4 +249,9 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash
 
-  openocd -f board/ti/am62a7evm.cfg
+   openocd -f board/ti/am62a7evm.cfg
+
+.. note::
+
+   The AM62D-EVM uses the same tcl configuration as the AM62A-SK due to
+   same core architecture.
diff --git a/doc/board/ti/am62px_sk.rst b/doc/board/ti/am62px_sk.rst
index 44dae4afc870..72de78d5f869 100644
--- a/doc/board/ti/am62px_sk.rst
+++ b/doc/board/ti/am62px_sk.rst
@@ -331,13 +331,11 @@ detailed setup information.
 
 .. warning::
 
-  **OpenOCD support after**: v0.12.0
+   **OpenOCD support after**: v0.12.0
 
-  While support for the entire K3 generation including the am62xxx
-  extended family was added before v0.12.0, the tcl scripts for the
-  am62px have been accepted and will be available in the next release of
-  OpenOCD. It may be necessary to build OpenOCD from source depending on
-  the version your distribution has packaged.
+   Until the next stable release of OpenOCD is available in your development
+   environment's distribution, it might be necessary to build OpenOCD `from the
+   source <https://github.com/openocd-org/openocd>`_.
 
 .. include::  k3.rst
     :start-after: .. k3_rst_include_start_openocd_connect_XDS110
@@ -347,4 +345,4 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash
 
-  openocd -f board/ti_am62pevm.cfg
+   openocd -f board/ti/am62pevm.cfg
diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
index ef9425035cb8..2e4923f7a7a1 100644
--- a/doc/board/ti/am62x_sk.rst
+++ b/doc/board/ti/am62x_sk.rst
@@ -867,4 +867,4 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash $
 
-  openocd -f board/ti_am625evm.cfg
+   openocd -f board/ti/am625evm.cfg
diff --git a/doc/board/ti/am65x_evm.rst b/doc/board/ti/am65x_evm.rst
index 73ceef2e531c..5f75c01ec65a 100644
--- a/doc/board/ti/am65x_evm.rst
+++ b/doc/board/ti/am65x_evm.rst
@@ -321,4 +321,4 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash $
 
-  openocd -f board/ti_am654evm.cfg
+   openocd -f board/ti/am654evm.cfg
diff --git a/doc/board/ti/j7200_evm.rst b/doc/board/ti/j7200_evm.rst
index 4fd2aff83547..e5c29c2bbb7b 100644
--- a/doc/board/ti/j7200_evm.rst
+++ b/doc/board/ti/j7200_evm.rst
@@ -232,4 +232,4 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash $
 
-  openocd -f board/ti_j7200evm.cfg
+   openocd -f board/ti/j7200evm.cfg
diff --git a/doc/board/ti/j721e_evm.rst b/doc/board/ti/j721e_evm.rst
index 41c8d4c72a8d..c3f3736e625a 100644
--- a/doc/board/ti/j721e_evm.rst
+++ b/doc/board/ti/j721e_evm.rst
@@ -261,4 +261,4 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash $
 
-  openocd -f board/ti_j721eevm.cfg
+   openocd -f board/ti/j721evm.cfg
diff --git a/doc/board/ti/j722s_evm.rst b/doc/board/ti/j722s_evm.rst
index 4b5cf0275940..3d11271613c7 100644
--- a/doc/board/ti/j722s_evm.rst
+++ b/doc/board/ti/j722s_evm.rst
@@ -255,4 +255,4 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash
 
-  openocd -f board/ti_j722sevm.cfg
+   openocd -f board/ti/j722sevm.cfg
diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
index ec82228ab908..54b4b6031f0c 100644
--- a/doc/board/ti/j784s4_evm.rst
+++ b/doc/board/ti/j784s4_evm.rst
@@ -663,4 +663,4 @@ following.
 
 .. prompt:: bash
 
-  openocd -f board/ti_j784s4evm.cfg
+   openocd -f board/ti/j784s4evm.cfg

-- 
2.54.0

