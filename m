Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC9BC4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 19:29:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AAF9980EAF;
	Tue, 21 Jul 2026 19:29:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fNg2bwuoO9Io; Tue, 21 Jul 2026 19:29:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 98D2280AA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784662176;
	bh=fqk+XygHutitTb8nvV04LK71sFr7IR5NSoBRKbZAd/k=;
	h=Date:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=qiiYss9yUAia0GsnxLD4AqoAV5xTKWQbuqEZWtZMkeewKmVPgxQHzOhdcL5mfMToL
	 Vz4Fc1QUb+5TesP+b2H+VTbpk8tqSy1f2XWxOgxTQqEzOxb+JRK/aZoTqlAx98l5Te
	 izbuvcn9F8Zw4VJMilYiIOFjLlcaHz+GBcm3gPwBVzHQcrz7cn+z9a3wcUA8KS1YCh
	 qWwmMLSOejCRMYOI7GBm+HgBw/p7dBZOtVxQcFOGNR3+0AC3Eac0WtNKKrf1oiSR1N
	 VU60Ik065ICMG71izuf1ugvEpQVjuEEpNGtgD3yiwS+B41De+1GT2VZYGsft36kY3k
	 KIS3jqIETlDRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98D2280AA9;
	Tue, 21 Jul 2026 19:29:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2246C42A
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 19:21:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 135BD40015
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 19:21:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wZJICKQ3rwvj for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 19:21:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D7CCC400B5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D7CCC400B5
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D7CCC400B5
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 19:21:06 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66LH62pW1424521;
 Tue, 21 Jul 2026 14:20:49 -0500
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
 by m0380145.ppops.net (PPS) with ESMTPS id 4fj077nat8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 14:20:48 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhKS8tuVUV7jejJauB+qHwTI3mLgEbhDvA9C4WyPgEJFVKnGWNGNfkM80LZk4JFi7ZMCn6iQ6cjJKHfHhL9aupBENXMMIwtQWtsxA9uAANnQvSLZbZW4EE/t5UYMUOZXdGR6si2KUbN8w8x9qnWJyFOuxoeQ/hJpAXUATvdGSAlI8zyqP4/HBFW6BoFZS4rroC3gOVa5GOHFMYq6cRssxe25GIMS+nmECX0wMv8mxoFkqu98dZlCK1RiNE/YBCgQcTWneTGQJV4JFW3M3OIxvXN5Hc97O5ZMdnKJQvtazLxuB7YUxK2aXB0xTWV0JGa/g0vtL1MVNSoVWc3UxH1MnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqk+XygHutitTb8nvV04LK71sFr7IR5NSoBRKbZAd/k=;
 b=R1oDr2Csirh/UFiikdbeSYeTPrIxln9MzYJVSC3yYyQRD3OCZv+iOciNZ1UudCQg9nyzWSY30wAKtkj8GBfbYxndimigE61OaPQf7ompx4xYUzZ85rOxFudzBehbRL9qXGvuCJiYl1bZuyITXNY68soziQkCsV3JxHcc9hR4LLh9BPKswCSFmfKWumKuV2ks0EAsJBstiDcj06/bCpn2md5Gd+yKwbhuDbn5bZ+QbWuOUwFrCs9dCa+FwsrbRQN3BjC6PjHhg8IXYg08+DaEp1jAliQJseAciBZ2VSR0jK+vx4jrxEvJHncTcOpZF9vQuyObuws4N4JRsOZT5dCI3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from BY1P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::9)
 by PH8PR10MB6549.namprd10.prod.outlook.com (2603:10b6:510:227::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 19:20:41 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::5) by BY1P220CA0014.outlook.office365.com
 (2603:10b6:a03:59d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 19:20:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 19:20:40 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 14:20:23 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 14:20:16 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 21 Jul 2026 14:20:16 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66LJKG331430783;
 Tue, 21 Jul 2026 14:20:16 -0500
Date: Tue, 21 Jul 2026 14:20:16 -0500
To: Andrew Davis <afd@ti.com>
CC: <u-boot@lists.denx.de>, <u-boot@lists.u-boot-project.org>, Peng Fan
 <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Alice Guo
 <alice.guo@nxp.com>, Anshul Dalal <anshuld@ti.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Udit Kumar <u-kumar1@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, "Kory Maincent (TI.com)"
 <kory.maincent@bootlin.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Daniel Golle <daniel@makrotopia.org>, Rasmus Villemoes
 <rv@rasmusvillemoes.dk>, Vignesh Raghavendra <vigneshr@ti.com>, "Manorit
 Chawdhry" <m-chawdhry@ti.com>, Dhruva Gole <d-gole@ti.com>,
 =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Paresh Bhagat <p-bhagat@ti.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 George McCollister <george.mccollister@konsulko.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 "Swamil Jain" <s-jain1@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Shiva Tripathi <s-tripathi1@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, "Aristo Chen" <aristo.chen@canonical.com>,
 Johan Jonker <jbx6244@gmail.com>, "Apurva Nandan" <a-nandan@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Hrushikesh Salunke
 <h-salunke@ti.com>
Subject: Re: [PATCH v2 06/11] board: ti: am62lx: add initial board files
Message-ID: <20260721192016.2dxar3mrnk3jyoz7@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260721-am62lx-v2-0-33ff580c267d@ti.com>
 <20260721-am62lx-v2-6-33ff580c267d@ti.com>
 <a1d1189d-9a52-4cd5-8c44-b5317c74845d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <a1d1189d-9a52-4cd5-8c44-b5317c74845d@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|PH8PR10MB6549:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ced22a3-a3ec-467a-6c4e-08dee75d26c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|7416014|13003099007|18002099003|22082099003|3023799007|6133799003|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: U862IptPPXH9+vIsjFzmV9ZgXK8P01ZJvvrTtaW9jhq34vc95/VDFUlY+/Ni3qh+FqyU5+AM/ht7xcL6v8GDvpkKKaoWyVsl6KU3aCBIb6PHNcWQOsrb+lCQwb2JiJJyaDVH7gXb7LAo24a4zj6avENTkNmFwu6L3IH98vP7hpENFPz8SkFXRHK9MGKnN7HSJiJlvoAjlquLcLFe0VRB/gICraPy5sj3sDZu6NpA6R1U2yVFCX9OO0k/ivpiy0NbVylgAbMQ5XI7vtsXW1FEwh6yet2uJMX9pXK9ux/faikNrd0xQdvWyqCoS0dpxy61dNrsdJVDdIOtRx3PKG34cj4qyJ9EhoikG6SaiFaatjD3mwEB+OW0l1kFeYjmKlPwkxLga0RePygz9wISLvRUz0a3Ftc5EGPheCywCftSLvkDVoNAUxA5WUYQsPbhmj/1zrb0MMZDIdpE89Ylvl26jJtjjBSFM+Zm6MxTlOLIwM/WlXP/t2XPiTCKjxa2Rrtw19fcEq1ZswFNzcBus/qMyYgB2B7h+BxB8L6kSW5eyzJmQPngCdu6hCtNMHdSR6NU4zlvKaU28k8I890T6JN9WWKEeQrtmx4Fme+gciFQ/BZv2QY8466xRgtQ3kN+3o4cSmhrS2Dfhm+7V0tX17MhkA==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(7416014)(13003099007)(18002099003)(22082099003)(3023799007)(6133799003)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ICNhZdM/WoSLSdfA+jDxuiY9YuwMJdPTxaNNY2B9arRf2wdLqFZy05HCz6w6bkYK7sj0DlM4ggjYDBWU/T3v0Zyfa59OuzgGmzQIWKlnh/ywH5/l6bbZIIJFQN2/pei6Bq08aO/QPSSCgfa20e7RXuiCNBZCbjLSMTjg6sSWM6/7RUFR6z4iTeddY2iLcEGbZZKbgvVfxueERCGOZg63Fd2vBZrVj7I+0E0WboyVtmG2prY29PwBbQAbNiEpgOfwqri9wxqm4YjHPsH0toit4LhVs2teq1xKTPYEn2xoppdkT/YzxAQki9Q5sXkHX1nt10yKHIEy78hBjrj3oZ4Vghn74FxIRE2a6a9yaEsNYaRlhelTiiy1fEx7ENR6V95vVdRt8cu45ubL7rsSScZD2CghmoZ427aPqfXPGGUuXJoq9JMUjWvjtL0bI9stpU9L
X-Exchange-RoutingPolicyChecked: kudrdi7iAgSl8wZFUk48Pl4pdIAg4SWRp5/d7H55NBCN7fRisK6IF0+cL8YFXmmLUepyu8o42jZM17+W5CysFRKPShzjBL7wQ1iOUe7mWnDoBGWCIrWWbuLCzTH221UZruf9nRwv2dgvCJNGyCCELJknwn4KbHWq/o3Bep6ULtysV8x5REzUVzfCxv71gPte2Duf2dD9at82j0BG0wYTF5pcgRLBwlkaEqsc93pF/ojzu91BRax1Js0E04Zg0lUi3vLM88zZOdquzPVPFs6CvKQ8M6x9PY6pQJb6IwtPV2oQaphJnpc5ApjRWu6m6HHtunM54uCr5euq+KfHLUYUag==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 19:20:40.0486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ced22a3-a3ec-467a-6c4e-08dee75d26c8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6549
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDIwMyBTYWx0ZWRfXwO1olgaL2VsJ
 P4fYTkuVndTREPdTpXG/ctnWgzXDOI0J7svMUD6LpGuxxE1FedZ/gosr3fioJv41lX/zbEqN7+K
 9myx4CBjEkCH+pH1zx6+rz0Al4jo1elgPVSGsVS7PGDwMentyYnNwSpcPPRjvxF9klPE+oG0BCm
 8CmbRMijWbPbcjxjmmE1MBCm01056qs9DYQMinelXbF/8XCSwZ+WSkLhGeC7R6lmSFhFlit1mCJ
 f63bPrad8KQthJeNJmXHwouF8iErYYJ0JIZ4rRaJhi2JcsGs/xztMrDU4OGg1kjmO02X8f5hfy8
 tDTwX4ZJj5k+XF/SYjG+0nNcZw9FFGaqO3nsm4jT5pFviuZ1qXu7d1a3/zo9Imcdv/y2qPjKrEc
 a1ww4DeIUZ+MKYDSHyYj0lhF08zo8BrJbaYPCZqFhm4T2gxsTi56CWr1MLIXjfs1owT+Md1Cpzy
 9PBldn8KtCgMce9DVnA==
X-Proofpoint-ORIG-GUID: jF31zqXC7B0YWdwUXS85owSYIGxiyrno
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDIwMyBTYWx0ZWRfX+lrLfrnb3QAB
 AshmAb6PhZpG9ItU5hXUSBQ2GDBkg57bCS706B9OC8RTfUgH84bSAaN90+S1n9rrTFdtSLJFwcS
 2AnVfKN62GU8y/CV2n9e08rtWHmc/tI=
X-Authority-Analysis: v=2.4 cv=KabidwYD c=1 sm=1 tr=0 ts=6a5fc690 cx=c_pps
 a=R7TnPQtMnhj+722GCxzAsw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=k-42gJp3AAAA:8
 a=fbNgDIr74PUGaIyunaoA:9 a=QEXdDO2ut3YA:10 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-GUID: jF31zqXC7B0YWdwUXS85owSYIGxiyrno
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210203
X-Mailman-Approved-At: Tue, 21 Jul 2026 19:29:33 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint-05-2026; bh=fqk+XygHutitTb8
 nvV04LK71sFr7IR5NSoBRKbZAd/k=; b=fLRIcRBTZuYwE4XicAzy5DuwzGGtQFR
 V8BWFAIrzVh2sM49wb4V99CzC9xpzEENUD67Go1tzvDO9YXTq+NbYUAoykX4V8ea
 71tAF8SxHg6/nkLOLUUWdJgKv+kyHRP/Tc3acEv/OAxnnckVR4If+4Yacybr1N7c
 hAv/M9KS7014ZKbOjT6x2t/1a3CAYwPSzU+15msJr/sCC7C89RjW7hMbMCBa1DT+
 tsSaolINBSctdiQ7hdv+r9QGE52JynTSh4ca49jBfqA2I7JkIan+gvgrpUuR75Le
 LVZO1o9MHwZ/VHZLCA0AIpChB90fDLeHIRRBFjbi5HnoYNUNO1T22Wg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqk+XygHutitTb8nvV04LK71sFr7IR5NSoBRKbZAd/k=;
 b=k7knvMQ+1uUR2J/P2VWcoFqi/M/NFmI+z00QWS7VZHsOxTbsaBrFMSRya2IueRK9eOyT1hP7rdMFXgE8niUHVq3pI6LseygoAZa29KKMtYdLXQMXjFzBMhK85QvBNyaSIn0zda5PksnItA9VoRm1FcakqbSE8MAen0IWBvTwJUw=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=fLRIcRBT; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=k7knvMQ+
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

On July 21, 2026 thus sayeth Andrew Davis:
> On 7/21/26 10:30 AM, Bryan Brattlof wrote:
> > Add the initial board files to support the AM62L3-SK reference boards
> > for basic boot via SD and MMC
> > 
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > ---
> >   board/ti/am62lx/Kconfig        |  19 +++
> >   board/ti/am62lx/MAINTAINERS    |   8 +
> >   board/ti/am62lx/Makefile       |   7 +
> >   board/ti/am62lx/am62lx.env     |   8 +
> >   board/ti/am62lx/board-cfg.yaml |  32 ++++
> >   board/ti/am62lx/evm.c          |  19 +++
> >   board/ti/am62lx/sec-cfg.yaml   | 380 +++++++++++++++++++++++++++++++++++++++++
> >   7 files changed, 473 insertions(+)
> > 
> > diff --git a/board/ti/am62lx/Kconfig b/board/ti/am62lx/Kconfig
> > new file mode 100644
> > index 000000000000..2ee6d0221178
> > --- /dev/null
> > +++ b/board/ti/am62lx/Kconfig
> > @@ -0,0 +1,19 @@
> > +# SPDX-License-Identifier: GPL-2.0+
> > +#
> > +# Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
> > +#
> > +
> > +if TARGET_AM62L3_EVM
> > +
> > +config SYS_BOARD
> > +	default "am62lx"
> > +
> > +config SYS_VENDOR
> > +	default "ti"
> > +
> > +config SYS_CONFIG_NAME
> > +	default "am62l3_evm"
> > +
> > +source "board/ti/common/Kconfig"
> > +
> > +endif
> > diff --git a/board/ti/am62lx/MAINTAINERS b/board/ti/am62lx/MAINTAINERS
> > new file mode 100644
> > index 000000000000..e945689a7f17
> > --- /dev/null
> > +++ b/board/ti/am62lx/MAINTAINERS
> > @@ -0,0 +1,8 @@
> > +AM62Lx BOARD
> > +M:	Vignesh Raghavendra <vigneshr@ti.com>
> > +M:	Bryan Brattlof <bb@ti.com>
> > +M:	Tom Rini <trini@konsulko.com>
> > +S:	Maintained
> > +F:	board/ti/am62lx/
> > +F:	include/configs/am62l3_evm.h
> > +F:	configs/am62lx_evm_defconfig
> > diff --git a/board/ti/am62lx/Makefile b/board/ti/am62lx/Makefile
> > new file mode 100644
> > index 000000000000..ac5f5e7e807a
> > --- /dev/null
> > +++ b/board/ti/am62lx/Makefile
> > @@ -0,0 +1,7 @@
> > +#
> > +# Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
> > +#
> > +# SPDX-License-Identifier:     GPL-2.0+
> > +#
> > +
> > +obj-y	+= evm.o
> > diff --git a/board/ti/am62lx/am62lx.env b/board/ti/am62lx/am62lx.env
> > new file mode 100644
> > index 000000000000..0dd86db400ee
> > --- /dev/null
> > +++ b/board/ti/am62lx/am62lx.env
> > @@ -0,0 +1,8 @@
> > +kernel_addr_r=0x82000000
> > +fdt_addr_r=0x88000000
> > +fdtoverlay_addr_r=0x89000000
> > +ramdisk_addr_r=0x88080000
> > +pxefile_addr_r=0x80100000
> > +
> > +dfu_alt_info_ram=
> > +	u-boot.img ram 0x83000000 0x400000
> > diff --git a/board/ti/am62lx/board-cfg.yaml b/board/ti/am62lx/board-cfg.yaml
> > new file mode 100644
> > index 000000000000..ae4b0e503bd1
> > --- /dev/null
> > +++ b/board/ti/am62lx/board-cfg.yaml
> > @@ -0,0 +1,32 @@
> > +# SPDX-License-Identifier: GPL-2.0+
> > +# Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
> > +#
> > +# Board configuration for the emulated AM62Lx
> 
> Emulated? I think we are past the pre-sil stage here :)
> 

Haha nice. Yeah I'll fix that up.

~Bryan
