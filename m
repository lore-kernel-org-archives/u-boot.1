Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3C6C55822
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 19:08:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5773C406D5;
	Tue,  4 Aug 2026 19:08:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lEWVidpjOr3R; Tue,  4 Aug 2026 19:08:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C46DF405EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785870518;
	bh=zsl2whUm2OT97vi/FzXxlKW9rXRDw46Y0tXXqJIvtA0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XmhWFyx+tGVW9heR7aiY9hCES/ZNrlBGnWT1MAUCag9QV8F5to3H1qGrxDSMRTjgq
	 pvvV8+QmxCa+NtrsTSnBFIbUQxQI23hHsc0hJunDxqrDkr6S3l0I7ypOBPBsrado3L
	 jFL/ZNPc9+eMTvZEtynSwR+BWYPR+YZ1oXX48CoyPL9mFh3f8Qwaaaav1Cb3OUtl6A
	 ZABwvQ5Uqt/WkUwG5rYtTEbpP7L2kaMy03KHMJUFqh1vrgrHUJ5eU9KSEuB4RgrF61
	 1KQB7vjZQyaCdClawAQx5KGH4zlZ4Qj1klZ00Eo2H0F3XczQkl8sBbyDYsNwKiKwxs
	 h3BdsZQo4mFcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C46DF405EE;
	Tue,  4 Aug 2026 19:08:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2EBE6288
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 19:08:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2316E401CA
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 19:08:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WFpkGO3yrGhJ for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 19:08:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E771D401A3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E771D401A3
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E771D401A3
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 19:08:35 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 674J4b5d3408948;
 Tue, 4 Aug 2026 14:08:29 -0500
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010024.outbound.protection.outlook.com [52.101.61.24])
 by m0380145.ppops.net (PPS) with ESMTPS id 4fud49c7fa-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 14:08:28 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0PsYLsmhA5YMuNHqVGEIvqwHEiglYmozFRc8vYMBkvCDcosJls8r+wJ2vRkRdgFe3QScfGSPOTRMCUJClegMUthRUnbxtrRebFro5lRS/ePhOfrKjQwIoa6yTmN2nTn3Jd7koknekLCzxJesrotNkX3t3OfTX9w1jCpYu6M0TcpIUiVNouKFS72ZVuB2TRmH/2fz4GtccoSOIExpzTBzstJWvhECzDFviOzPBLzeb+daDB7Pp5GzZD2GamUhb5fmpbdFZBSDG0+9ZJY08A73RbIc4rQ5UbrGOzpD7Y0P8nK0g47BUADx17lU2S8q6mCxZs0D+0xH635385dTSdzUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsl2whUm2OT97vi/FzXxlKW9rXRDw46Y0tXXqJIvtA0=;
 b=C6lV+rucsTbUceTs8V4Jk5X05YN/nYoMOpeuHMRgPhZQm0DQr6Fk0AjzOBleD7SeKzGkfDbbjKLFOlPWFjseaIkcn518nanQD7RdRAWRGPZN1GN5SUHfzhpKeMM/uCKji46JsTveZFaJ7AVw8QFVOF9GlfPCZ2ePEw+YDDVDfOT+g03UpwuDY5ug2POV1to6N2ofZIOwnsLL+c04Hw6nleY69KrTas9q2hV0QCzeaUyt/lhMeSFvrH+lX8KXDsT3r7GorrMbP8VsXOLlvnzLlw0aI4y9UcQm+oLLeUec/8wEMcBe9Zc7V2P1GqITt6cH8cG1jdNQ3YmybfrBcs3+lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=mailbox.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from SJ0PR13CA0087.namprd13.prod.outlook.com (2603:10b6:a03:2c4::32)
 by PH7PR10MB6036.namprd10.prod.outlook.com (2603:10b6:510:1fc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 19:08:23 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::95) by SJ0PR13CA0087.outlook.office365.com
 (2603:10b6:a03:2c4::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.13 via Frontend Transport; Tue, 4
 Aug 2026 19:08:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 19:08:22 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 14:08:22 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 14:08:22 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 4 Aug 2026 14:08:22 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 674J8MQM768748;
 Tue, 4 Aug 2026 14:08:22 -0500
Date: Tue, 4 Aug 2026 14:08:22 -0500
From: Bryan Brattlof <bb@ti.com>
To: Andrew Davis <afd@ti.com>
CC: <u-boot@lists.u-boot-project.org>, Peng Fan <peng.fan@nxp.com>, Tom Rini
 <trini@konsulko.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aristo Chen <aristo.chen@canonical.com>, Udit Kumar <u-kumar1@ti.com>,
 "Daniel Golle" <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>,
 "Vignesh Raghavendra" <vigneshr@ti.com>,
 Paresh Bhagat <p-bhagat@ti.com>, Swamil Jain <s-jain1@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Shiva
 Tripathi <s-tripathi1@ti.com>, Apurva Nandan <a-nandan@ti.com>, Chintan
 Vankar <c-vankar@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 "Marek Vasut" <marek.vasut+renesas@mailbox.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Hrushikesh Salunke <h-salunke@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>
Subject: Re: [PATCH v3 10/11] doc: board: ti: correct path to tcl scripts
Message-ID: <20260804190822.75opogfv25ugtpky@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260803-am62lx-v3-0-b4f4302b09b4@ti.com>
 <20260803-am62lx-v3-10-b4f4302b09b4@ti.com>
 <032b1ec4-9175-496c-b3b4-f46e06bd3065@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <032b1ec4-9175-496c-b3b4-f46e06bd3065@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|PH7PR10MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f8a4950-1893-4784-d924-08def25bc128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|36860700016|23010399003|1800799024|13003099007|6133799003|22082099003|18002099003|56012099006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: 8qpD3ri8p2gLe0ZlOqu1Sfx/h0t35FKKT+IochrIWqKrOKI8A0L5kij8njxSt2eTXuOESgLbnIuTxxByBqRnTnL0A+1oxlcOpiUFZEeJ6c3CpltIdk25sr0mYzsG2N6w33FCaGKiWaHS0p86/vd5TueQXsZZfO/7hBrHpjEkE0RuTHYCY4xJ3r4thfZhZfWcVDe12YTGg/SosspPmvEcLvUgOm3H3aiweArz2Xah8evw246ArfDRuICcjvRHY48TWcx/NTKkPfS4fv07P6Xd6+nArRENogquTqG5NMS811knUkhf02OOWj5FafzAwBAYd85KxAYV8bG1naep8lpMuIttPIAb3gRKuBVsN5E+1CVcNVd2tkf4t4/XXULXGJwSOlnSJJxF07Cpuxmn8bx1RVxTyGmhjZ7KlRuueR7W9pIQ7XQPU73eW3xmJ+nEYbC+atGCMuL7OSqc00jUEtHFOF/FkibOA/FnWeaZMnoyAWkBDDmtjSIc7fl0YV/0FV/hNg8TmzkTA+7airicPNHC2JcRgTtQI/XqRXiZkQTI/whf8WmFkJpbrRpiobfCHrkl8YCS9WeR9EoksMFkOv3TSEnLc2FES0ORUYUdKSWyo0ktFLP2TdXVcxcK2z3RCIqDfJhX9JUE1UTmdLHqgUL7hxPcA7YUn1xhr1ocGxA7FvtN1/YjOLoMnJOrbI6+BaUKC6yPKBfRscq/Y+eSOPa0zw==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(23010399003)(1800799024)(13003099007)(6133799003)(22082099003)(18002099003)(56012099006)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XkT9PR3BAxIaHBVpeinZJfawZweQ9WmV5WPMuxHN/yQ6qu7RQyUY4Qd8oYMaikNO7mBaVnmk3td4vEx6YXpV36gmJqEwN6S8fy8WBtehQKHDpBuxQboXD4Ra/F4WsMIvCwd59Duq7/5LLjsI/WNmoKeeBvjhoVIR0JB5vqCjzhjKO2vDcOPIpUo2aGXb5dKdReFStWpV2WUL8unegsNOhTyZBJUVe0kFMxaXGZSmJOvzhZCiEdw3jnfj0T2OtuPbJB5ONCFaUUr8CDy9jvMpP1aOZaEHaRmQ9Z6HZ8SN6jphLdkxJC0p6LON+dFzHwoILE2HcO72eDNIFHvd7F7cc45SMAbsi/AJ3Slpr0R0VhBEsx0a1kNMWoufwnZWc/4+bjxju6PPomKP6yL7MgilG8nJxPGlSROH4H4dCjtzulj4v6/JVf00/mM31gmOnB/A
X-Exchange-RoutingPolicyChecked: cPULZrKNNxyY0zIErbmoMgzQMRhawdF9VmyilHHcHKpCDNQvbTbG0E7DOCGfs96uXPNxDKdXbhZMi5YDKZsGsy+KTRsAmHt4XoK1QQ35BUMMKDigt8PW3p8WYDfZpfUmhmVZFspD6+0hDNmXQFKvFnvxbHcu5TrG/mCGFmQYOe3CvPv17jFVhYV9jS6eFCPpVZsx55TYwLujf+G5jMuxmrefYhI4LeQcfC6ewOYsfS5uJ4u4udCFZFqL85P03wQyKqgY5DgfEuvE+lyLUYFRg6Vfe2fTgIK7ELCBBPWO0HCc/DkhjgfbHaBsvUm9PE9NuTuPp5bDvOHkG6VCwdnryg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 19:08:22.8443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8a4950-1893-4784-d924-08def25bc128
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6036
X-Proofpoint-GUID: myhkFHCphCbd-J6DmqhlxKwVAdW7I430
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE1NCBTYWx0ZWRfX3wpATC9wdkq5
 1Fm2GiQh3W+hrnu3usUqbE06Hins8/RTHNdvu2gbKg2g3Pri2KSNE93rgKgi2q9gH+9GSK+kXx8
 P61IVkT1F7FN45PB78CFX+/605oj83nhyiQmgim0O2pClc7eACyF4sRUEWSp+bb+mcmFEIx8DA9
 GKK9Fpfe4D7vm4nhCZXD1aCGqs9D1OBQ5ZlyJx49DSMXiXZx4R5p5wfQBcfH6+Ajalk+WLi+tV1
 Fb4uu/Y7aOlatwKNixQH2DhhE3YvWIUudXrTh1C6h0GulQjmvwL3w/JDlNnpx2Fa4HSRDcWAsp7
 HcHQ4Pq+l+zy88Tox+kWwMFCxpmSbglemkl4CQF6lkWgeuByy0t9zNPwUU/UDKaepAU6g6orwr5
 /mDUP5Rs5IYguU5hrx9/77A/S9FGB5kZxm62AnT0VHnr9SzFE4AXLCMYqLN4oDcF1QFRQATBYIU
 ouj+5ixREhLT+V5CmBQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE1NCBTYWx0ZWRfX+wfsUGiE5cSU
 dtF/9Sy0EL47AaO1EzCiiv77eFX8CgVZ+iyqWwyBaOJA0qzunhn0NPXOOXdcIMOvjiy1eOwHR/b
 74iTkqT+ROVVUyOhhLcJv7MTqGex9Ck=
X-Authority-Analysis: v=2.4 cv=XKMAjwhE c=1 sm=1 tr=0 ts=6a7238ac cx=c_pps
 a=FzHw5hv2FvkecWl+Aalm1A==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=NEAV23lmAAAA:8 a=5RB7imNMd8vOeTzvGlIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: myhkFHCphCbd-J6DmqhlxKwVAdW7I430
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040154
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint-05-2026; bh=zsl2whUm2OT97vi
 /FzXxlKW9rXRDw46Y0tXXqJIvtA0=; b=hkMSQF4VvgSt3/bNKoYp92reOoiv8DA
 xvEud1WF0LOZtIILDUM2BnTDSiJ4CYXErBKTNgxrh4HTogjPzD1Jkgek8+DJUj9g
 j1u/yCh/QeFAh278+GvUV7VuTkmBSVvAZ3qv1Y8B7i6xBURn/ndagIeOTV+klTRs
 pIAAnnsxen7PoB7m1ZVZ9Fg/c034x4jMoo8BLLs8jbHICtqkdqsXNSsF/a9qcq3a
 1kQmpIwgV5Dy4DxBTZj/oUyJQgV4iKfbY6b+deLdEn7cQ5SofxCSpP5HsFNU4INV
 l93IgfmZcrh9sl1yg4e3uNmTvsvN1MfIeiKbwJmB58qxXqd+0Gx4vwg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsl2whUm2OT97vi/FzXxlKW9rXRDw46Y0tXXqJIvtA0=;
 b=GDafgaxgvUqFtxJp/GExsV7EmR+nqR+rxsMKIatBbMJaIeWellPx1RX7jCCQlR5Gk6SiPKg39EHalITT7xMwrfiRRZCRs4wTqOulbebR5tf1mfRwhEqWLxjmqKlnAXmRGmJ2Jbb7fwavC7GESKvSG8SMWodMqNgKhssrENuNz5E=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=hkMSQF4V; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=GDafgaxg
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

On August  4, 2026 thus sayeth Andrew Davis:
> On 8/3/26 7:09 PM, Bryan Brattlof wrote:
> > OpenOCD has moved where it has placed the tcl scripts for TI's reference
> > boards. Update their paths to the new locations.
> > 
> > Tested-by: Anshul Dalal <anshuld@ti.com>
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > ---
> > Changes in v3:
> > - Kept warning about which versions of OpenOCD have the tcl scripts
> > - Link to v2: https://lore.kernel.org/r/20260721-am62lx-v2-0-33ff580c267d@ti.com
> > ---
> >   doc/board/ti/am6254atl_sk.rst |  2 +-
> >   doc/board/ti/am62ax_sk.rst    |  2 +-
> >   doc/board/ti/am62dx_evm.rst   | 11 ++++++-----
> >   doc/board/ti/am62px_sk.rst    | 12 +++++-------
> >   doc/board/ti/am62x_sk.rst     |  2 +-
> >   doc/board/ti/am64x_evm.rst    | 24 ++++++++++++++++++++++++
> >   doc/board/ti/am65x_evm.rst    |  2 +-
> >   doc/board/ti/j7200_evm.rst    |  2 +-
> >   doc/board/ti/j721e_evm.rst    |  2 +-
> >   doc/board/ti/j722s_evm.rst    |  2 +-
> >   doc/board/ti/j784s4_evm.rst   |  2 +-
> >   11 files changed, 43 insertions(+), 20 deletions(-)
> > 
> > diff --git a/doc/board/ti/am6254atl_sk.rst b/doc/board/ti/am6254atl_sk.rst
> > index 18a3520b39c7..0df058aee157 100644
> > --- a/doc/board/ti/am6254atl_sk.rst
> > +++ b/doc/board/ti/am6254atl_sk.rst
> > @@ -305,4 +305,4 @@ To start OpenOCD and connect to the board
> >   .. prompt:: bash $
> > -  openocd -f board/ti_am625evm.cfg
> > +   openocd -f board/ti/am625evm.cfg
> > diff --git a/doc/board/ti/am62ax_sk.rst b/doc/board/ti/am62ax_sk.rst
> > index 3453ed339e7f..b04bfc991ea0 100644
> > --- a/doc/board/ti/am62ax_sk.rst
> > +++ b/doc/board/ti/am62ax_sk.rst
> > @@ -435,4 +435,4 @@ To start OpenOCD and connect to the board
> >   .. prompt:: bash
> > -  openocd -f board/ti_am62a7evm.cfg
> > +   openocd -f board/ti/am62a7evm.cfg
> > diff --git a/doc/board/ti/am62dx_evm.rst b/doc/board/ti/am62dx_evm.rst
> > index 0d12e3ec1476..88071b3e69d9 100644
> > --- a/doc/board/ti/am62dx_evm.rst
> > +++ b/doc/board/ti/am62dx_evm.rst
> > @@ -237,10 +237,6 @@ detailed setup information.
> >   .. warning::
> > -  **AM62A**: OpenOCD support since August 2023 (git master)
> > -
> > -  **AM62D**: Uses AM62A configuration (compatible due to same core architecture)
> > -
> >     Until the next stable release of OpenOCD is available in your development
> >     environment's distribution, it might be necessary to build OpenOCD `from the
> >     source <https://github.com/openocd-org/openocd>`_.
> > @@ -253,4 +249,9 @@ To start OpenOCD and connect to the board
> >   .. prompt:: bash
> > -  openocd -f board/ti/am62a7evm.cfg
> > +   openocd -f board/ti/am62a7evm.cfg
> > +
> > +.. note::
> > +
> > +   The AM62D-EVM uses the same tcl configuration as the AM62A-SK due to
> > +   same core architecture.
> > diff --git a/doc/board/ti/am62px_sk.rst b/doc/board/ti/am62px_sk.rst
> > index 44dae4afc870..9d8b5ebf38fb 100644
> > --- a/doc/board/ti/am62px_sk.rst
> > +++ b/doc/board/ti/am62px_sk.rst
> > @@ -331,13 +331,11 @@ detailed setup information.
> >   .. warning::
> > -  **OpenOCD support after**: v0.12.0
> > +   **OpenOCD support after**: v0.12.0
> > -  While support for the entire K3 generation including the am62xxx
> > -  extended family was added before v0.12.0, the tcl scripts for the
> > -  am62px have been accepted and will be available in the next release of
> > -  OpenOCD. It may be necessary to build OpenOCD from source depending on
> > -  the version your distribution has packaged.
> > +   Until the next stable release of OpenOCD is available in your development
> > +   environment's distribution, it might be necissary to build OpenOCD `from the
> 
> s/necissary/necessary
> 

Nice

> Otherwise everything else looks good,
> 
> Acked-by: Andrew Davis <afd@ti.com>

~Bryan
