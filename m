Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B97C55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 11:13:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C12B60627;
	Tue,  4 Aug 2026 11:13:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VCDIuxsW8HEg; Tue,  4 Aug 2026 11:13:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 525E860670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785841988;
	bh=XNrFZOxjF+mF5/O7qDMtWwZgJxhxIplvLKK/fOaS01I=;
	h=Date:Subject:From:To:CC:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Uo9Ld+lMqX3Q+dVPx5akXICaZTnA6y/C1OpTjHNmmE6bfaA5E7Fue47AOsG0NIRYi
	 q3jT+5gGDY3L06Uc5KJhenkgOTalMYalcjlRxDrmrPnm48N4JwsJ+aUs/N8SRlZeyX
	 ehaPfketn1GAWne3DcBxtaGZPxwIGMpMKkBcdACiwOBD0pyqRHraFahPvQyHNJGxwL
	 X2c0u/barDNFEUpvQYpbWtLHDCM4y8HbhTgcROaZWt5Q3fYNxnwKGIwFs+cscszGti
	 LtUoETFm8e4DieW+lT5Hh9B6wEoPVojl51AH5F3DYSBT/Ykm8IxFZ8C018/VDlW2ai
	 3SlgzsIqc2h4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 525E860670;
	Tue,  4 Aug 2026 11:13:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 21C8B26C
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 11:13:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 138DA406EC
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 11:13:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mj4uyaibufQo for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 11:13:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=anshuld@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2AC2B40688
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2AC2B40688
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2AC2B40688
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 11:13:04 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67493Z2q2193169;
 Tue, 4 Aug 2026 06:12:55 -0500
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010044.outbound.protection.outlook.com [52.101.46.44])
 by m0380145.ppops.net (PPS) with ESMTPS id 4fud498mvg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 06:12:55 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VSTaIftwhflQK8zak6/cZ3J9Qx5B6bsq/IwyqanSuln87GMNucrzLrC/gn6nDT538rlg6UrCTrM5+xJ8p69KK73JagRPJvsPM9K8KXO89fhOu22QiiSv6tmJB79c50Dv1LdZ/a7K8/DciRc6WEfXdK9Mv1Hz6e+iW2x/ojT7dKcjnRgYOuRSL9ZW6CecbPkfa3d9eSTiLVVXu7VTJnKunwnmWjDWIqrMhZTkD4T7Efjxx//bPxn30YMPTprfKC92PHgH5WP4rWmrKynOCPXNJzXcE2xXqt3/5azYwMRF6bT6CkxKaohO0UZ/7gJ7TR3wg6zseLA2rS9wzB6OIO3iXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNrFZOxjF+mF5/O7qDMtWwZgJxhxIplvLKK/fOaS01I=;
 b=C8JLY3aKmFrdNPo+rRebNui3nz1bkiUbFkAcKdnm9sRuqRBoStp3UcFHNqNc+N50S6P1ph18QSQJX+iNZWC9tTGpJdhyZggoT2loLBVfKg1hr1HbFEjv4yQGpX8CERy19WIPfD6XSa2k0CTkXYROjxqoYmoT+pnNI6R4ELETj9ohZush0cNLw1/6LBUx2oSk2FrZVrQ6z2HbMWDaJbMmS9u2OLJ30Ww16VBIuTfPa0l6G2ToXiOUqVK0GWKtDPcf8yL+kGZ6Ri+aJoacRVTP2jwzafEpwhmJrEzHTFE50MJNO4ah8mdwD7MlNs/6ZDwL3vBPKBh8yui7mWIDkrB1Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=mailbox.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from BY1P220CA0039.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::7)
 by DM3PPFCD1365510.namprd10.prod.outlook.com (2603:10b6:f:fc00::c4e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 11:12:52 +0000
Received: from CO1PEPF00012E7D.namprd03.prod.outlook.com
 (2603:10b6:a03:59e:cafe::ab) by BY1P220CA0039.outlook.office365.com
 (2603:10b6:a03:59e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Tue, 4
 Aug 2026 11:12:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF00012E7D.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 11:12:49 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 06:12:49 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 06:12:49 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 4 Aug 2026 06:12:49 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 674BCk7h120600;
 Tue, 4 Aug 2026 06:12:46 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 4 Aug 2026 16:42:45 +0530
Message-ID: <DKG455BMPCLC.199BSNMXHFTG5@ti.com>
Subject: Re: [PATCH v3 05/11] arm: mach-k3: Add initial am62lx SoC support
From: Anshul Dalal <anshuld@ti.com>
To: Bryan Brattlof <bb@ti.com>, <u-boot@lists.u-boot-project.org>
CC: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, "Dan
 Carpenter" <dan.carpenter@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, "Simon Glass" <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, Aristo Chen
 <aristo.chen@canonical.com>, Udit Kumar <u-kumar1@ti.com>, Andrew Davis
 <afd@ti.com>, Daniel Golle <daniel@makrotopia.org>, Johan Jonker
 <jbx6244@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>, Paresh Bhagat
 <p-bhagat@ti.com>, Swamil Jain <s-jain1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Shiva Tripathi <s-tripathi1@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Chintan Vankar <c-vankar@ti.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260803-am62lx-v3-0-b4f4302b09b4@ti.com>
 <20260803-am62lx-v3-5-b4f4302b09b4@ti.com>
In-Reply-To: <20260803-am62lx-v3-5-b4f4302b09b4@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7D:EE_|DM3PPFCD1365510:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c88fa2-7097-4cea-6bf1-08def2195226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|7416014|376014|23010399003|1800799024|56012099006|10067099003|4143699003|3023799007|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: fzZaLixh/vXVmB9i7k98D0xZfCxMP58YEcjoPAGwj5uERVNkO7rKpBEVE7ftRIdrEN/4ABAbfDwNhTbd0GaY5dpWFpEshUtnWw81CJLEadk0QcYI3+hDRizFceNrJuZN592yXFkUjaiGnKv9MXxYxh0evBueX9aN5cKLsTPWqaeVb8x1qxtfykqnobfFL/zqvoelFl9GeEnCkybGviyrVnmDcH6nfW9Ih5mgyToJwtJbwkMG6rpslv09irmRbU56fEDKv3ExJxOCfHFheVVglOMvZIgH0fsPq5lDsW9cig4inzayQUKJiEXTQh472GmAEqqom11SSHZaJOPStwX4ZiMmXK7ShTTGcHlbP8yHf4xVVwC20QHIyf/b8igpSYZEoZw0THfG6mgytYqBG8gpyGGjG7MqdeFcp0d7CLQFmtWbKG9JkoQvFNtrBJrb/XQifSxE9vzZ9QcMnpCJhJmaHU8a2yBik0UWnv6wc39yDyMWDvz1I7PmA9UjiKxLOoV4QL48SaeWo6d6H9LxTBdFNaWMAF/d42SppfYNdHcQsd3cU67rzF5NQ4yXMWLMHTMIyZrD9X+kBRwwH6osxWwkMhaeFD60E4QQYz77mJQMH7lzOdfNvRYJrT/Anun/mzZ+gC2FqCPr7F/gAU4K5PdX2w==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(23010399003)(1800799024)(56012099006)(10067099003)(4143699003)(3023799007)(22082099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rwTh73z4OsPAj4NHVbMq6xLkDPs7fR3FQ9z8RXr2TKOxCaEUKDE+GKmsQlorUnpEqsTtOj5BTFVmSRXGa9/1MRtrPcqITzOGLV/keACsS530c8ICA7vi8/emooJynkA2DHztyUuVejPTC4W77VLkAd+3dwxnOjOTSItdQoqaVhAPjgC6DuCHta9b9DRxc7bEeEek1oNgG3IDVQLkTlAObgyrXAw2wdorLrqYVw28lAbXrPtlyHPWu5hlUTN97w8VkLJQcm/3PSCZAB3Ik78hLpz1LU5H2fSrd+C7WyGhyAy8cMWwiNaRko3regZbVWwnETMWdgHeKDT1rVmASlIHRf/ultITQraHVXK5nwtKHLfWZTldJff69XIezIZFdbe1PHZgnpxPK1CrnW7py2xDAh0rQrUPN2/B4FBdn8DujCb9wl9wDwvCwbLISxERQ9FF
X-Exchange-RoutingPolicyChecked: e43wow9LZoz7esn38HonOgL9qAjvBogld+4wt0s//nSt/2IybpJWnS+AgMSjQxuh6GU2tgMxIK7U8Jld2A+KIo63CFY12y0E7dT1eunZKQcpotAKGCNWCm954l912dhRvz/IXRY94vT24pYVVpd/Vre68f8kt+4h+A5xRnn6qRXMufIVf5YIncmKseZLo1bHARaX6T9w9g9nJKw/fBqxY7qwp+q4HU14kEhWmueGKcF8uRlZGjnL9Kcan79qfqZJWLOOk9uPC5GGp6RuvmlalzgnlEZZR7M6/DYoCHoKC1iIsHG13IimqX8lT7+vQxPd9L89rsSwJB7N1MhnGbN6DA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 11:12:49.8214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c88fa2-7097-4cea-6bf1-08def2195226
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E7D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFCD1365510
X-Proofpoint-GUID: USx0MF3qntYsUpb0wNPh5Uv4dZaJRhUk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA4OSBTYWx0ZWRfX9AKJ7okBwVPg
 ROra5b4EpPraVAEHeugE7+tWThhWKPPRIfgkxhH4QObHB7OAh9Douhh94+7wJkSI3FdavKQB6hw
 2NRfvzVfJEzvRV/Jq/fc5SwOVygbyTwqGvTpDSh2IlO3BlBd7hzOYSyipo3mcNZVWLxC8O86j1s
 5g0DSsyzUJeEFMHrAY5TV3XtJjh9OXsXr3pPltsOVUUANThG1QwAeRZG6LCQKQz6filgDXKYgqv
 ERCsfuWcOZ0MNnqSnkcZYqtJpaTHCPhw9mWeA0jWXbJNM3xc+VAlJxXN13J9c9r9JGg7s34KqiY
 7+p8fZVwohb3bq5x7f+f4+UkXj9dQGxi9tmqn2pv9KPGwLYWKtiiRZxKieTCkXX7DUG5SsgNMYm
 qM8t4QAASsmS6TqGtfOmv3XFWmtivSGM5j7ZT6EFc3D9fFrFsZfZbkbe8qjPPXmFoAYnQuJhg/G
 QAHkCcUxhSM3kHoqABA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA4OSBTYWx0ZWRfX/J07v1IjbxYh
 ZVXJSd9E9D1Gv+qSM7U+TC3hLEW9kAaT//Sx9OQEYT3qvydxjwjFYgVO3bzn9OjyC/6tnTXbhhR
 u7k6hRNu2Pmfy/DZvlQTA2ieW2qsjZ8=
X-Authority-Analysis: v=2.4 cv=XKMAjwhE c=1 sm=1 tr=0 ts=6a71c937 cx=c_pps
 a=feJg8xcwi6yo0k/5NfVkgw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8
 a=xhRrR7PU-sUHIRCGDmYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: USx0MF3qntYsUpb0wNPh5Uv4dZaJRhUk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040089
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=XNrFZOxjF+mF5/O7qDMtWwZgJxhxIplvLKK/fOaS0
 1I=; b=XetGqEPvW2Jc43WiAAeVRT7Dt7yWZmoXSfWRPLkqDNUJUdrxAeW+6qrBN
 mm/DKYIxLAUD+jbf99mjYsaereKZj1nQntzwIUx2XKHnnot+0zMi8NC9b/GgoDEK
 W1KlGDca4/jAoU9nJEdEz9EwwYcibcxkA4K/0gOfQhtQr2KAL0cjUiZrJtOXP9ru
 Ge0Ti5seAuTRNw2iZxVYqWtGPjh3g6IzRriDTUOzgcAbHx2fdRpT2Vtfa0Ew3OZa
 546p6rAQJSr+sMIrBlYSWjGfiRCnAbQGnQg7AQRUGF4yzFcaz0po+Srpvt/xnuHX
 Gh9z3EfBG2AfqxcmHHiFpUuZ4cPXg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNrFZOxjF+mF5/O7qDMtWwZgJxhxIplvLKK/fOaS01I=;
 b=Q5pAFgYEIx0e86WbErbggPiIXmufSLvWt/Lye35qLRvAJOkjZFCdvf1cot+8lqMwdkcA+KPfAtjEcs8kiu81v5KE1yCUez40etwjy1SJ7IvRlqZ/IPqjnSzmRtTVMW3w3aAmxyRFlN/Kk+2hqM62W8EfHMVJjqRtNirJPzvqc4I=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=XetGqEPv; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=Q5pAFgYE
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

On Tue Aug 4, 2026 at 5:39 AM IST, Bryan Brattlof wrote:
> Add initial mach-k3 files needed to support boards based on the AM62L
> family of SoCs
>
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---

[snip]

> diff --git a/arch/arm/mach-k3/include/mach/am62l_hardware.h b/arch/arm/ma=
ch-k3/include/mach/am62l_hardware.h
> new file mode 100644
> index 000000000000..7791511ff2a2
> --- /dev/null
> +++ b/arch/arm/mach-k3/include/mach/am62l_hardware.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * AM62Lx SoC definitions, structures etc.
> + *
> + * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.co=
m/
> + */
> +
> +#ifndef __ASM_ARCH_AM62L_HARDWARE_H
> +#define __ASM_ARCH_AM62L_HARDWARE_H
> +
> +#include <config.h>
> +#ifndef __ASSEMBLY__
> +#include <linux/bitops.h>
> +#endif
> +
> +#define CTRL_MMR0_BASE				0x00100000
> +#define WKUP_CTRL_MMR0_BASE			0x43000000
> +#define WKUP_CTRL_MMR1_BASE			0x43010000
> +
> +#define CTRLMMR_MAIN_DEVSTAT			(WKUP_CTRL_MMR1_BASE + 0x30)
> +#define MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK	GENMASK(6, 3)
> +#define MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT	3
> +#define MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK	GENMASK(9, 7)
> +#define MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT	7
> +#define MAIN_DEVSTAT_BACKUP_BOOTMODE_MASK	GENMASK(12, 10)
> +#define MAIN_DEVSTAT_BACKUP_BOOTMODE_SHIFT	10
> +#define MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK	BIT(13)
> +#define MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT	13
> +
> +/* Primary Bootmode MMC Config macros */
> +#define MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK	BIT(2)
> +#define MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT	2
> +#define MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK	BIT(0)
> +#define MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_SHIFT	0
> +
> +/* Primary Bootmode USB Config macros */
> +#define MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT	1
> +#define MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK	BIT(1)
> +
> +/* Backup Bootmode USB Config macros */
> +#define MAIN_DEVSTAT_BACKUP_USB_MODE_MASK	BIT(0)
> +
> +/* address boot rom leaves its boot structure */
> +#define K3_BOOT_PARAM_TABLE_INDEX_OCRAM		0x70816e70
> +
> +static const u32 put_core_ids[] =3D {};

I have some issues with the use of put_core_ids here but looks like it
requires a more involved refactor of mach-k3 common code. I can take up
that cleanup once this is merged.

Reviewed-by: Anshul Dalal <anshuld@ti.com>
