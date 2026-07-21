Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A46FC4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 18:09:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 38CE7409A5;
	Tue, 21 Jul 2026 18:09:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mWJysQ8MnEDL; Tue, 21 Jul 2026 18:09:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 673684099F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784657354;
	bh=fN4expUUvJf4ylKWnBNl47oXVtZ5ih1PlMOd2a8nu64=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=dSwCnRr902s59f+54hq2/jvJOMBWefc7JuklMrDYq4f97THI/uM/oquVzwX0U41dl
	 cDF8V7N7lra8p0mbbaewWEk1dSkmfzlg2hXS+RYEhPR6lx70yCy4ajNmCBsNVkuChW
	 KtQb1M2mm+x7ET1EOceP13Sc/1DMtQeE4Lbx/SVQuZIABo9KP/bSZ5zfrnIZncbZP1
	 XWqkvHUHpA8Q8OElQ1w0j0nQEgbBlYfZ5tyKM9kIeSfl+hoZ5IS/A8pXw5Zn+7k2lU
	 VDv99EmyAosFweFntxa+gC/NLcLvqTag/S8zx/iaNw+OkdJ3UxZiK6L59S1zEqGba3
	 bv/1A0ligTqgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 673684099F;
	Tue, 21 Jul 2026 18:09:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 63E14109F
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:02:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 49D7640167
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:02:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id efzzZySzbS7o for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 16:02:03 +0000 (UTC)
X-Greylist: delayed 1845 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 21 Jul 2026 16:02:02 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1ED5340071
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1ED5340071
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1ED5340071
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:02:02 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LDjaA8997816; Tue, 21 Jul 2026 10:30:51 -0500
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012005.outbound.protection.outlook.com
 [40.93.195.5])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fj7q91kke-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 10:30:51 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHC12YqZUxlQ7byaYolFNBggF8Nrn3YHRry5jYi/njx7a0gbrqVFbWWRHK4O4hh5tRY9PYsg0vt/N6V3KpDPwix4ogGN86AxQoQ+CSm2YA17/AKw3zbwGwslSjUzkw5hiTyFTUxPJVwZbSSbkXLCUJxCO7zegpSO6EFEQk7LOYwq3xeZrBtAzcWqtSmYsJG8nsLQP7WkN4QRkwhOAY45jvat/qfnvjGy4JU1arYUBLy/p3GmvrDFGlRT32XBc5eJXw51rvHWcjn3bkXL6ppsAGJm/tgkg+OCFE8yZoJuGG0bkRss4+/aSDt3tiTLWoNZpVA4MJ9GlV7oA4ZDm/ytIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fN4expUUvJf4ylKWnBNl47oXVtZ5ih1PlMOd2a8nu64=;
 b=p3GVXSWHZGlJHYO/Wgfy1WZoCdvwFTN9oaQhz+s/64W0p/p6UiuMdsUONEUl5GFHQmkTt09DaGQriPF+8/u9VYReSjC+E9JRAAusb5BkaJGPuQj2onBXQlssIn5dtJAIA0U6bcLh2ti7cJUG+k3yGZtsxCyCo97+OYHLcVGL1hEfpTxoCeSvXPmuSsJCPYv86tl63uv9FUTbEy51jBjqqtvgKHVcKGTpIY6nEPgznaUTWn0cHjDfM6lkyfE3aDpMTEIG8yGCvl5D3lfUj2wOyVYb65FP4t8rbqDqQrZ9Mz46j9HFEVvxjKyb170c76b0lJ/+gTcixtXjf/4E+Q9L5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from MW4PR03CA0184.namprd03.prod.outlook.com (2603:10b6:303:b8::9)
 by PH7PR10MB7852.namprd10.prod.outlook.com (2603:10b6:510:2fe::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 15:30:49 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:303:b8:cafe::89) by MW4PR03CA0184.outlook.office365.com
 (2603:10b6:303:b8::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.18 via Frontend Transport; Tue,
 21 Jul 2026 15:30:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 15:30:48 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 10:30:22 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 10:30:22 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 21 Jul 2026 10:30:22 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66LFUMrn1031809;
 Tue, 21 Jul 2026 10:30:22 -0500
Date: Tue, 21 Jul 2026 10:30:16 -0500
Subject: [PATCH v2 01/11] firmware: scmi: switch to dev_ofnode during bind
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260721-am62lx-v2-1-33ff580c267d@ti.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|PH7PR10MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: c8597e37-dcf8-4bda-8885-08dee73d0a7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|7416014|23010399003|376014|22082099003|18002099003|3023799007|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: wFJ6ZpDDVlfJoNeSI64Bbgps1GvwxTD9U3liYLCydGrJQhgA71xMZvUY1hvRQCCXG2ECgnQNYzLTr+VQXrWKbC/pLa1M0Tfg/ZjQzMeK39aNmrQ456FSLvhCRlN6+2utzj2H3DS6FXWCcZF6wt14eA3m0J+tqNOqtdNg/U6vkdMOfPCsQcT1uZgqA5XUm5Vm3UpuHgbhghdz36fziXHeGlxt/T+dVnvBdnh/fqnf644ZVtbmiHJbi3d7EPYlzaWxxqL1NzAiBq81VJPsyZfdwBaAH4nw2dLRlBG1geRTRLdDvQkf68PLYXBrKIoo7h/Smwt22A1a5WGikKC4/aKuxTCInonvEvVAeF3BAL7pOKsH9IIJpsIogSAt9oyWq1GnIJiuLofGWuYROLub9wlXhuJptQGy0LX/+++8itaFHVYxsgW+e54EsEnnMM3YyLgbSX0U5mieedYFAFaKri2ZYI8cSs9qnWk63QKl2ckr24XhrkPYTLMcMCvLgfjHIuOX/fsqXdjeIIJGjnVO6+cl2rXoQTyhfJkD8m+3agFVFtyBHsWda1BM4rzSyi2GAprW4JL60iNeO+XgD8bVqTOIenVjfx+sV1y2p6LLv3mlQKnddDXL41SXdEql+XaFtbboVN1/4tW5BxI6bXHC1YBO0wKfKHul6SODDIknDfo03CZG/bIWb/a0TXywHBg1hI01KNxF2Ggeh1Ds3L57+1nq7Q==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(23010399003)(376014)(22082099003)(18002099003)(3023799007)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Vf/0r8g/Zgn6fKJEURDS81Pzuetd6RYyG55P4Dgk2bB5k3pYs7vHLG5lNbhscIOMFPsjdlEvzWRtWuEu8xRZ+PskzledmnJWcw8DDUU5k+gH7dCkD1W54MNGJvWRNHLjnsybT1F8MFGfGd88i71aGkN7cOPoyTbN8ax7Cer9/Y9hco5QyvSsfEXuZxHCc9D1zhmgarlYvcDfpN93u+Lb91c0yMRP1n/LgECWB/G7N6XCicgsFb+HPxI2HfYYYelm7lnsgOhB8Jrp3uGuG+H1Tz7TL+mike0ng5DEcfm9fhrjUEfuP6OtM5dzqqfssF0Y96/SSc8nQ5EgtIqHzTKLBl+KwgOgRifkclNJSIQEQWFGFmRC/Fu+1UcJ1omFK1MbFPaUECtUGckV76ltK90kiVJq2ZP1cAJcmBWzlXvB9SNmpAm3daNtBvQcndW439qA
X-Exchange-RoutingPolicyChecked: psAbexQEM1o7Hhhn7LNNpfXHN3n5Q/YZAAAl0XAlht2+qcmlb4mCSRot98KU6vs0XNvdZiBJ7Xp3YOQepHcUdPM1DB5b9Rv16m6iZaSD8OE1oleGucC3TxqP4zPLzlJmAGqLbv8lwnK2HX0Ck+kin1mKrGGNzvPdzslF/GR8reip7ZiWxK+ttvM07Qu6o111JGUYIl3LaX7rtramuCV/YzuHmbCb1SM+2ZYKiNmcs1YyLvJRuQkduX+KOUQquUJWvVFtLh0RoruJWv6gq1+kxti6MjPI118XEsjieHjMjG+ZMlYgE7ORq6i9fwJWCfnGQwxOdTUxxCTYoYfaNv/3Ew==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 15:30:48.6831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8597e37-dcf8-4bda-8885-08dee73d0a7c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7852
X-Proofpoint-GUID: vMBUe9uZBrqKpgM7UPEWxRdw6j63Tl32
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE2NCBTYWx0ZWRfX5IyhGiQ7Ok/7
 J1mf+hBlqrJW5+lO45XbYFUAZWjRdyIWUL5EWtBx3Fl7zjsSAnlVc0BxMoRyMMxWoNYCFT3algD
 GXCUhMqhjREVzRnqRnJOqI0iu5/DKZU=
X-Authority-Analysis: v=2.4 cv=CsmPtH4D c=1 sm=1 tr=0 ts=6a5f90ab cx=c_pps
 a=Wms0yhV2hyGqr6ZNmSx9tw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=Tbir3cbcft87DSTUyVQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: vMBUe9uZBrqKpgM7UPEWxRdw6j63Tl32
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE2NCBTYWx0ZWRfX06Kplt8hp9mG
 XNynOqNCWcm29m8Ramo1nPVHFHP6gczczumy1/gDBb6Ax2VIHL9CWL4M1+YFqZFREt/5sUqdJJc
 yDtPKkGBL8tBKs1uTWlLgquOW4jrnRGkTulQOHnGt/LK79ELh8Gd07lcxdRkky3cNuJAKjtJN9d
 9N6p4iFsIBqSboYv+sz7fnXJCjHw8a4qH7nl6Cm5aoLHNe/j1Ko7+TBEf8eZQ4noWKYL+Eoiq0Q
 aW+zugkCINMlTamaeF4+/uAeKxro6tt+CSWfA6qUmnwo6iiFzRE4xQxhJmM82sG2R8keSiwCoVQ
 OTZlc9rdzZiuaHmwmaU57Kjva2uhO+1oFgIhVcZj7PpRjOUTJrbImN+X4b5Sl60ZInwg0SRQQXH
 hoIH7DGrNPK4bEWx6T4fUmt//505Sny9gGqGhxrevRr/wu1YXUEHelIGTt6FCjjMeCY2aPRA3Jh
 8uIj0xefZ7q+IlJeSSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210164
X-Mailman-Approved-At: Tue, 21 Jul 2026 18:09:10 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=fN4expUUvJf4ylKWnBNl47oXVtZ5ih1PlMOd2a8nu
 64=; b=HVejWSTQw1WIMEavNql+cUyuQy6wSsuoKQ8JEh7BmnyzKxPv8JLm4EQn/
 HFUnLOXBNIuP38cOhnIvquj+z0mm1onD0Xk9c7l5Whs8+KHClnnMzopfZ26ofImG
 ELQDsFbLhUByjGwbT1wxPRF2ocpXHGknpbTU2T6VAr4bBSwVZ13ECTHQo/NpzUyT
 933LhXyRFmeSabCa5xcs93xFJyQvbxSfpxrwbiJPvJxfT9wCZMExH0s1pwVtzFbe
 GHKa/246X5apF+Nqg5Ufi2zTOM0ewunvWpLuLFXg6JIkBbs5y8ZnRdxxKKb4hgmK
 7b2Cx5TE0s8zjYxfg8ftz0mcBnlfQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fN4expUUvJf4ylKWnBNl47oXVtZ5ih1PlMOd2a8nu64=;
 b=Xn9p/nQCTkP0imCr/xZcZR5IH0lKH/o/RoMOVMnjXHrTL23Al/FMbLa7D78raB9HnseX8qUFaF2xbNxb0Xf4SLlv4zudYy06nF8FqCsPRR4Opv9qjuvNs4i5ISY4sZT4OUDMZuS7Ytl5GYopbieTHcul/M/FdZhK+JLB3G8K1n0=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=HVejWSTQ; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=Xn9p/nQC
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

From: Anshul Dalal <anshuld@ti.com>

When using ofnode_null() the node offset passed to the FDT API will be
-1 which is invalid and breaks probe. Switch to dev_ofnode()

Signed-off-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 drivers/firmware/scmi/scmi_agent-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index cd458a7f4588..65c1ddad2b57 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -437,7 +437,7 @@ static int scmi_bind_protocols(struct udevice *dev)
 	/* initialize the device from device tree */
 	drv = DM_DRIVER_GET(scmi_base_drv);
 	name = "scmi-base.0";
-	ret = device_bind(dev, drv, name, NULL, ofnode_null(), &proto);
+	ret = device_bind(dev, drv, name, NULL, dev_ofnode(dev), &proto);
 	if (ret) {
 		dev_err(dev, "failed to bind base protocol\n");
 		return ret;

-- 
2.54.0

