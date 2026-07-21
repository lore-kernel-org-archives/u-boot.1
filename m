Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103F3C4452B
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 18:09:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 738F7608D6;
	Tue, 21 Jul 2026 18:09:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OnY4PON0MWhl; Tue, 21 Jul 2026 18:09:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 92843608B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784657355;
	bh=Np7h6dzd5PuDTkQadxjsAmhlmyYZO2dz0o3xkhYkN/8=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=UDK3EzAwEY0HE9gmZoJrUehHQkRwXbLsckHtX6UV7SbRH004k5L4vN9HZNM5k2Hf0
	 xFfHFwI3IkOPERJFuP3lZa3/AlyKe3jMotHEJS94mIzf9+81CHl6iaHUiJlPVkopd2
	 v1VcBlpaMYK/CoaLjbpzN44AYVceHZBvRGjecx/V1ZWSzSusOo4qIKMW/dQ9F7LeSj
	 W7qeH1PV6BWqsgVnYxorf8N7S+Tx7y1KjQxyxTp7MUiVc0EI60oQfKmjCt282nS5lZ
	 9b4iZT76FF+vI2mfK1hd7MywqBjOYOSzLQqhtNSjwEsi7kbgY8za42xonQ2nZ78dG2
	 fmQ22/JPYyoog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 92843608B2;
	Tue, 21 Jul 2026 18:09:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 92CC142A
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:06:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8505540275
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:06:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9RQ_DWKyOSTf for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 16:06:50 +0000 (UTC)
X-Greylist: delayed 2135 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 21 Jul 2026 16:06:50 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3853340071
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3853340071
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3853340071
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:06:50 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66LDjLV81017937;
 Tue, 21 Jul 2026 10:30:53 -0500
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012027.outbound.protection.outlook.com
 [40.93.195.27])
 by m0380145.ppops.net (PPS) with ESMTPS id 4fj077kvax-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 10:30:53 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbomVFrCicKyCdlwPmPgSSMTynVUq5COsmmZptwKeNAyYOg8osNpMCHmh+jIqU6vEDvW1FwThIaITO5qdf6MrVo6/lE8pGpM7C36zRqsU7EVvQp1M0mppv42OCMSKJQhlriwHFgJ55qwQ4vA1BdNx+m68ZXCj+ECz4cPRZXFvk8E6m3J8HA1/b+G+j3CCi9PgwIJboKA8MZchBfbMmrNoMhuShtck03hZn/kdh7qH8R9d7NdGGZ7v0riax0cRwqjiHEZh/B5fXhxMZniLByitD+eqq3a+lYavdGFnCjJyVDYU7F4IxwzeSJXUNSyDmseE16iDUOmqN8YCNX1KM1FmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Np7h6dzd5PuDTkQadxjsAmhlmyYZO2dz0o3xkhYkN/8=;
 b=dvNPb259/NIJgkZRCkcXj0cmmAKlwO1IjNmjLeLIySDddNEB+XntVsYg52QAGXY/wJRAXvyjeQYiIE/1HyFej/mxFXdHI8VKr26m4e5RP0MnCUdjc2joO544PM6kNoz58hJ8Sg2JEHjLRaMY4mI4qE8+MiMZhkJlJP1lp4zSltMKfzU/tusZ3Bee1IiiUipJ3BOcGyQ/09nD6vzVKRmxGznc88/ZJ74zDkYWcRbsTMqUyuc2yq7T7xXjj9XfO4J8nk68pefqfkrahPvDVgTZOVNR8wbXPd1tnxc1dr1fcJoB9sXKuxuIBBaGvk2vEukDtgawrXpfTU3GFOFXSkA+xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from MW4PR03CA0206.namprd03.prod.outlook.com (2603:10b6:303:b8::31)
 by PH0PR10MB5795.namprd10.prod.outlook.com (2603:10b6:510:ff::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 15:30:49 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:303:b8:cafe::29) by MW4PR03CA0206.outlook.office365.com
 (2603:10b6:303:b8::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 15:30:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 15:30:49 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 10:30:23 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 10:30:22 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 21 Jul 2026 10:30:22 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66LFUMVh1031845;
 Tue, 21 Jul 2026 10:30:22 -0500
Date: Tue, 21 Jul 2026 10:30:25 -0500
Subject: [PATCH v2 10/11] doc: board: ti: correct path to tcl scripts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260721-am62lx-v2-10-33ff580c267d@ti.com>
References: <20260721-am62lx-v2-0-33ff580c267d@ti.com>
In-Reply-To: <20260721-am62lx-v2-0-33ff580c267d@ti.com>
To: <u-boot@lists.denx.de>, <u-boot@lists.u-boot-project.org>
CC: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Alice Guo
 <alice.guo@nxp.com>, Anshul Dalal <anshuld@ti.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrew Davis <afd@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, "Kory Maincent
 (TI.com)" <kory.maincent@bootlin.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Daniel Golle <daniel@makrotopia.org>, "Rasmus
 Villemoes" <rv@rasmusvillemoes.dk>, Vignesh Raghavendra <vigneshr@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Dhruva Gole <d-gole@ti.com>,
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Paresh Bhagat <p-bhagat@ti.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 George McCollister <george.mccollister@konsulko.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 "Swamil Jain" <s-jain1@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Shiva Tripathi <s-tripathi1@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, "Aristo Chen" <aristo.chen@canonical.com>,
 Johan Jonker <jbx6244@gmail.com>, "Apurva Nandan" <a-nandan@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Hrushikesh Salunke
 <h-salunke@ti.com>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.16-dev-d5d98
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|PH0PR10MB5795:EE_
X-MS-Office365-Filtering-Correlation-Id: 851f1bea-c836-4502-c1c6-08dee73d0b09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|82310400026|36860700016|23010399003|18002099003|22082099003|56012099006|10067099003|13003099007|6133799003;
X-Microsoft-Antispam-Message-Info: rSsUOyxYO03XP1sWNi9y4g+Gk1FVMi+z4x2PEFRZNe4EDjodVYMvqRLFFTkE+ktWNUYBCbmkOnSC77fjfcqm7Blq3qEFuUYUPnKrAipdLtINyx0h1mh6NEIXLDcMIXKdpngdYjrc697gwEi0cYGyiB2BpKJPiGlrnRU5vmDml/Bkxh+cq8s0LYSDQ7s9zoDmVz7jDfuGABIuVpofCse012umOHWalmfwnOrWbUPQeyJFPXNzr2hq6EyiogUecyzEWw51P61prnn2JN3IwkjepTM/H+Mzu6WPL2nD0T5cWPZze3hWA2qO2B0xu4nfa/S9uLMU0p4fEUseOUwHM9t06SCPK3xqur3fZnQFbNAZdRePO3aY3CgJ2s2mTuc/S330zoyQkdBxDO9q9Wo7OeRapUA8fRJVRbU+s8E6yDpV8Q0nxjyGoLx18TWU5jpvIES2RuZqjOTIIUABPYSkHnY8Dm2FlOYpwugs+Y+Jd5O3GH5f6x/rrp9Q1qPQBJphZjopXlBxiHtQJCwGy6YnhV8TGkFSOi9ndGOddjii5kOx4/nKNUSFR/pNxlnI03UtKfZQRQaTEEHpo/uLkZMQ0TLsq38xZL1/TK0aYgz3a+g1Tk1M0C1N7SppQX7x+JkC80GNQBWXefBCajS/AccwABI9XH0pjjV8R0E69gEsDwZXDk5FsEr6rm4rmPYEh+pYQZKw11oZrlFB3gxrAsFBR3zqjA==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700016)(23010399003)(18002099003)(22082099003)(56012099006)(10067099003)(13003099007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MOPNDKUM3Ou1aUeggU/7IkYDRj0GSLKLy5G1lmDeDsTkkL+qY7FGGimUeC1q57/pJ5IyaNz5I8iKWA42p9v24tILM0QpX+TLsdFCyMk8ViqtVSXF9Osv3r+HDUugr1GyztW71TPjxK1TTZBpdYlnJkpmjU6DXiQYcnVs97dvKP9jzEHuaQmNEBM43JbdhJ+qdRkb2Ree1ujMIpnKfGcnyHmQzsGw0rCTWlIxh4Jm2UQM0ceD71Gl8c0g8/I3V1OWIXzux2QNSynf77GCF4dRMnxVcOLnh2frKdxhl1zlobZpKvJQWnrIYokDrG19ZCcemDN4YKZ5QLOis8csFqfWlJm05kqXAU/CtxNeG0lV/QBvaETkmYWE5Py/HSaX19ZQM61wZq9RBseHqebn+wJfmjJ6eijErCRwGRk7CYnvww/6qpxiEScv6HRv+/khDx4e
X-Exchange-RoutingPolicyChecked: K+e54kfrAH3awN205wU09+w8aB9BH9epugoS1DGEKyzRUtSFRLOyY+Cgf9QgeBRN9E6f9FMky3b3UZy9DuQYM8CVV9JtiPsR0PkBoAwtLXhPH5tQIwVqtYBX/139ak/gIxuRuCymup737/wl5bV1DY+jr7NCbTHCL5Dbwc9vRqdEYMtDXB/qu7GsSWc6AHNEJak2pvsqcwerSodJuVHnNidrl9EJTjw0G6pd7D/DXwT2ZuAiZun8IBhLu9Gat38YEuhXUPLhVVLv6W2n47nHkj8NWcis2MA4BSoI47gcIPs3/SgT3vwqd/z0jrGPMIuFB+RVOKCnAH7AsWxd5MWyaw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 15:30:49.6062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 851f1bea-c836-4502-c1c6-08dee73d0b09
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5795
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE2NCBTYWx0ZWRfX69XrI0vf9cWb
 GZZCpTM8StmC+BPu1kB0OgIyBG7sLoX87A+KoicQfg/2UO9l2UFtJKBOArMzjvQlCfDMcvdCuyc
 m31pt4+/AdaUVhuCrHK9jATCpG4pTkpA3CDKFnsRSmWH9IV4ZBVlR9wBxF4Nv201ibAxTNRateJ
 /40Tks96HT2xdB80MchAayRjHtd7p2GuLD8q1uux13zjJ+yqojzfhJMCIupQu8n5VVOdw0FbH3u
 cvcPBIxPGATlZ8XYKeK6YQBNN2zaN95qsDKaqA5vpCbY0JAVkSWSfG/hAoR5pAtQmwUE0wW73La
 g7WBb7HuYTN/wKmQv3b2aTYaPMph+B1yvAftH6ENgZwSYCV2qSA1aGrBB2ChYG2O99Y5D6Mtlrj
 oCBiFRDEHEWpWwXg+1l5YhtrAZgJ8tGMYMvyvG86UDoeywNPkYpzogEb6ncD4WGn89L2kHCWDrt
 my2+jpLo1c2q7L8RloA==
X-Proofpoint-ORIG-GUID: 6sFXw71j96bKUFDzEeL1n7tJBwjP9XST
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE2NCBTYWx0ZWRfX9BiC9mkY9dNf
 bRC+8HlY4MXQJ6rSc4+MA3pFTTrJpGmvpsSsp5TEx7oU13hLW1UgxM6pCdMZrK5oWyKeFeoYaWD
 0F4n7x1AC34AuVVq9/mObElnDyzVqec=
X-Authority-Analysis: v=2.4 cv=KabidwYD c=1 sm=1 tr=0 ts=6a5f90ad cx=c_pps
 a=0pMqp0B7/3h4ah4p3fuJNw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=NEAV23lmAAAA:8
 a=sozttTNsAAAA:8 a=3XqsQiwtXmu4FjQEjo0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 6sFXw71j96bKUFDzEeL1n7tJBwjP9XST
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210164
X-Mailman-Approved-At: Tue, 21 Jul 2026 18:09:10 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=Np7h6dzd5PuDTkQadxjsAmhlmyYZO2dz0o3xkhYkN
 /8=; b=IBl7YO92pWDY6l0T04ZArDkmR9ftEbCufwDYZ+ZK6HQq8i3HVFtyhDP7E
 0Irat1jKqf313jFK6+RjKNdQnLPWBYhmpfbppSZ6HV/kWvmlUmN5ONyitIiMZuvh
 dOE76uNfBPhKx4N/oibV4Oc4UoRSYjG6CiqDbRC7ft3bYMVLhngFRFRqc5+/EoV/
 5pVjR2YYT9YIYQ21jwRPh+Kx2mfBN+hbLUqeSo7vEikPTUPKWrj6KY31571ylZAl
 /djfpv4q9q/VL9hJBOFIkHfjD/SFTOU6bamdxywbb0rb4eaXQ2mq5mD4lpGy31r+
 BSqbM9/mMF3wLLJObY5iPgPbbz9cQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Np7h6dzd5PuDTkQadxjsAmhlmyYZO2dz0o3xkhYkN/8=;
 b=a5LqZnE5RX5bhYyYom+PCCOAOzleE+5CTyoe975Cs2AyZtHy9wk1tvxdyFByF8lvj7SH83Cc+8n3S+cjZZ0Yj28MCnHbld3kZ/8VjncgNUkJLKIWxlxMb36IcGvBgyiSFduVPMNIjrT4ViereGZB+6uHBL2WHChJ3Jah0lBfzt0=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=IBl7YO92; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=a5LqZnE5
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
From: Bryan Brattlof via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Bryan Brattlof <bb@ti.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

OpenOCD has moved where it has placed the tcl scripts for TI's reference
boards. Update their paths to the new locations

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 doc/board/ti/am6254atl_sk.rst | 10 +---------
 doc/board/ti/am62ax_sk.rst    | 10 +---------
 doc/board/ti/am62dx_evm.rst   | 17 ++++++-----------
 doc/board/ti/am62px_sk.rst    | 12 +-----------
 doc/board/ti/am62x_sk.rst     |  9 +--------
 doc/board/ti/am64x_evm.rst    | 17 +++++++++++++++++
 doc/board/ti/am65x_evm.rst    | 10 +---------
 doc/board/ti/j7200_evm.rst    | 10 +---------
 doc/board/ti/j721e_evm.rst    | 10 +---------
 doc/board/ti/j722s_evm.rst    | 12 +-----------
 doc/board/ti/j784s4_evm.rst   | 10 +---------
 11 files changed, 32 insertions(+), 95 deletions(-)

diff --git a/doc/board/ti/am6254atl_sk.rst b/doc/board/ti/am6254atl_sk.rst
index 18a3520b39c7..7f919b10a8d7 100644
--- a/doc/board/ti/am6254atl_sk.rst
+++ b/doc/board/ti/am6254atl_sk.rst
@@ -289,14 +289,6 @@ Debugging U-Boot
 See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
 detailed setup information.
 
-.. warning::
-
-  **OpenOCD support since**: v0.12.0
-
-  If the default package version of OpenOCD in your development
-  environment's distribution needs to be updated, it might be necessary to
-  build OpenOCD from the source.
-
 .. include::  k3.rst
     :start-after: .. k3_rst_include_start_openocd_connect_XDS110
     :end-before: .. k3_rst_include_end_openocd_connect_XDS110
@@ -305,4 +297,4 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash $
 
-  openocd -f board/ti_am625evm.cfg
+   openocd -f board/ti/am625evm.cfg
diff --git a/doc/board/ti/am62ax_sk.rst b/doc/board/ti/am62ax_sk.rst
index 6f3432f7895c..2b338569aad6 100644
--- a/doc/board/ti/am62ax_sk.rst
+++ b/doc/board/ti/am62ax_sk.rst
@@ -224,14 +224,6 @@ Debugging U-Boot
 See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
 detailed setup information.
 
-.. warning::
-
-  **OpenOCD support since**: August 2023 (git master)
-
-  Until the next stable release of OpenOCD is available in your development
-  environment's distribution, it might be necessary to build OpenOCD `from the
-  source <https://github.com/openocd-org/openocd>`_.
-
 .. include::  k3.rst
     :start-after: .. k3_rst_include_start_openocd_connect_XDS110
     :end-before: .. k3_rst_include_end_openocd_connect_XDS110
@@ -240,4 +232,4 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash
 
-  openocd -f board/ti_am62a7evm.cfg
+   openocd -f board/ti/am62a7evm.cfg
diff --git a/doc/board/ti/am62dx_evm.rst b/doc/board/ti/am62dx_evm.rst
index 0d12e3ec1476..28f62914b3bc 100644
--- a/doc/board/ti/am62dx_evm.rst
+++ b/doc/board/ti/am62dx_evm.rst
@@ -235,16 +235,6 @@ Debugging U-Boot
 See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
 detailed setup information.
 
-.. warning::
-
-  **AM62A**: OpenOCD support since August 2023 (git master)
-
-  **AM62D**: Uses AM62A configuration (compatible due to same core architecture)
-
-  Until the next stable release of OpenOCD is available in your development
-  environment's distribution, it might be necessary to build OpenOCD `from the
-  source <https://github.com/openocd-org/openocd>`_.
-
 .. include::  k3.rst
     :start-after: .. k3_rst_include_start_openocd_connect_XDS110
     :end-before: .. k3_rst_include_end_openocd_connect_XDS110
@@ -253,4 +243,9 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash
 
-  openocd -f board/ti/am62a7evm.cfg
+   openocd -f board/ti/am62a7evm.cfg
+
+.. note::
+
+   The AM62D-EVM uses the same tcl configuration as the AM62A-SK due to
+   same core architecture.
diff --git a/doc/board/ti/am62px_sk.rst b/doc/board/ti/am62px_sk.rst
index 44dae4afc870..d2696282033c 100644
--- a/doc/board/ti/am62px_sk.rst
+++ b/doc/board/ti/am62px_sk.rst
@@ -329,16 +329,6 @@ Debugging U-Boot
 See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
 detailed setup information.
 
-.. warning::
-
-  **OpenOCD support after**: v0.12.0
-
-  While support for the entire K3 generation including the am62xxx
-  extended family was added before v0.12.0, the tcl scripts for the
-  am62px have been accepted and will be available in the next release of
-  OpenOCD. It may be necessary to build OpenOCD from source depending on
-  the version your distribution has packaged.
-
 .. include::  k3.rst
     :start-after: .. k3_rst_include_start_openocd_connect_XDS110
     :end-before: .. k3_rst_include_end_openocd_connect_XDS110
@@ -347,4 +337,4 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash
 
-  openocd -f board/ti_am62pevm.cfg
+   openocd -f board/ti/am62pevm.cfg
diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
index ef9425035cb8..ab5dee1ac775 100644
--- a/doc/board/ti/am62x_sk.rst
+++ b/doc/board/ti/am62x_sk.rst
@@ -851,13 +851,6 @@ Debugging U-Boot
 See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
 detailed setup information.
 
-.. warning::
-
-  **OpenOCD support since**: v0.12.0
-
-  If the default package version of OpenOCD in your development
-  environment's distribution needs to be updated, it might be necessary to
-  build OpenOCD from the source.
 
 .. include::  k3.rst
     :start-after: .. k3_rst_include_start_openocd_connect_XDS110
@@ -867,4 +860,4 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash $
 
-  openocd -f board/ti_am625evm.cfg
+   openocd -f board/ti/am625evm.cfg
diff --git a/doc/board/ti/am64x_evm.rst b/doc/board/ti/am64x_evm.rst
index 65c4c456528c..dbbdfe0e8036 100644
--- a/doc/board/ti/am64x_evm.rst
+++ b/doc/board/ti/am64x_evm.rst
@@ -227,3 +227,20 @@ https://www.ti.com/lit/pdf/spruim2 under the `Boot Mode Pins` section.
 
   For SW2 and SW3, the switch state in the "ON" position = 1.
   Boot bits on SK is reversed bits to the bootmode signals
+
+
+Debugging U-Boot
+----------------
+
+See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
+detailed setup information.
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_openocd_connect_XDS110
+    :end-before: .. k3_rst_include_end_openocd_connect_XDS110
+
+To start OpenOCD and connect to the board
+
+.. prompt:: bash
+
+   openocd -f board/ti/am642evm.cfg
diff --git a/doc/board/ti/am65x_evm.rst b/doc/board/ti/am65x_evm.rst
index 60b08ceebf0f..12fa955d2bf5 100644
--- a/doc/board/ti/am65x_evm.rst
+++ b/doc/board/ti/am65x_evm.rst
@@ -305,14 +305,6 @@ Debugging U-Boot
 See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
 detailed setup information.
 
-.. warning::
-
-  **OpenOCD support since**: v0.12.0
-
-  If the default package version of OpenOCD in your development
-  environment's distribution needs to be updated, it might be necessary to
-  build OpenOCD from the source.
-
 .. include::  k3.rst
     :start-after: .. k3_rst_include_start_openocd_connect_XDS110
     :end-before: .. k3_rst_include_end_openocd_connect_XDS110
@@ -321,4 +313,4 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash $
 
-  openocd -f board/ti_am654evm.cfg
+   openocd -f board/ti/am654evm.cfg
diff --git a/doc/board/ti/j7200_evm.rst b/doc/board/ti/j7200_evm.rst
index 4fd2aff83547..74bce4b465d7 100644
--- a/doc/board/ti/j7200_evm.rst
+++ b/doc/board/ti/j7200_evm.rst
@@ -216,14 +216,6 @@ Debugging U-Boot
 See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
 detailed setup information.
 
-.. warning::
-
-  **OpenOCD support since**: v0.12.0
-
-  If the default package version of OpenOCD in your development
-  environment's distribution needs to be updated, it might be necessary to
-  build OpenOCD from the source.
-
 .. include::  k3.rst
     :start-after: .. k3_rst_include_start_openocd_connect_XDS110
     :end-before: .. k3_rst_include_end_openocd_connect_XDS110
@@ -232,4 +224,4 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash $
 
-  openocd -f board/ti_j7200evm.cfg
+  openocd -f board/ti/j7200evm.cfg
diff --git a/doc/board/ti/j721e_evm.rst b/doc/board/ti/j721e_evm.rst
index 41c8d4c72a8d..1302e080d8a8 100644
--- a/doc/board/ti/j721e_evm.rst
+++ b/doc/board/ti/j721e_evm.rst
@@ -245,14 +245,6 @@ Debugging U-Boot
 See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
 detailed setup information.
 
-.. warning::
-
-  **OpenOCD support since**: v0.12.0
-
-  If the default package version of OpenOCD in your development
-  environment's distribution needs to be updated, it might be necessary to
-  build OpenOCD from the source.
-
 .. include::  ../ti/k3.rst
     :start-after: .. k3_rst_include_start_openocd_connect_XDS110
     :end-before: .. k3_rst_include_end_openocd_connect_XDS110
@@ -261,4 +253,4 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash $
 
-  openocd -f board/ti_j721eevm.cfg
+   openocd -f board/ti/j721evm.cfg
diff --git a/doc/board/ti/j722s_evm.rst b/doc/board/ti/j722s_evm.rst
index 4b5cf0275940..5a4ae11a2eb6 100644
--- a/doc/board/ti/j722s_evm.rst
+++ b/doc/board/ti/j722s_evm.rst
@@ -237,16 +237,6 @@ Debugging U-Boot
 See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
 detailed setup information.
 
-.. warning::
-
-  **OpenOCD support after**: v0.12.0
-
-  While support for the entire K3 generation including the am62xxx
-  extended family was added before v0.12.0, the tcl scripts for the
-  am62px have been accepted and will be available in the next release of
-  OpenOCD. It may be necessary to build OpenOCD from source depending on
-  the version your distribution has packaged.
-
 .. include::  k3.rst
     :start-after: .. k3_rst_include_start_openocd_connect_XDS110
     :end-before: .. k3_rst_include_end_openocd_connect_XDS110
@@ -255,4 +245,4 @@ To start OpenOCD and connect to the board
 
 .. prompt:: bash
 
-  openocd -f board/ti_j722sevm.cfg
+   openocd -f board/ti/j722sevm.cfg
diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
index ec82228ab908..48decd8d3d64 100644
--- a/doc/board/ti/j784s4_evm.rst
+++ b/doc/board/ti/j784s4_evm.rst
@@ -643,14 +643,6 @@ Debugging U-Boot
 See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
 detailed setup information.
 
-.. warning::
-
-  **OpenOCD support since**: September 2023 (git master)
-
-  Until the next stable release of OpenOCD is available in your development
-  environment's distribution, it might be necessary to build OpenOCD `from the
-  source <https://github.com/openocd-org/openocd>`_.
-
 Debugging U-Boot on J784S4-EVM and AM69-SK
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
@@ -663,4 +655,4 @@ following.
 
 .. prompt:: bash
 
-  openocd -f board/ti_j784s4evm.cfg
+  openocd -f board/ti/j784s4evm.cfg

-- 
2.54.0

