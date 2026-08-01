Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2FDC55173
	for <u-boot@archiver.kernel.org>; Sat,  1 Aug 2026 15:39:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0F8360714;
	Sat,  1 Aug 2026 15:39:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aHYhkxPPRGeD; Sat,  1 Aug 2026 15:39:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BA0D2606EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785598781;
	bh=hMSU0w6FT9GTasNJu6ZkBnptBYdlaCaIomubAOC5tt8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FROfKqt7e0ZUGXZt6D1ogQYkpRZQWmCAxmyWUXhAnBxyViKnpT2BJEn+5ajVVif9S
	 I/EZUwfmFl7qIBrekWEN9j2ZE/ekVl8098kx3qZehAX+0zyPC7cyndoQi2GubkBk8S
	 sFt2/+CBuCurpfCday2YiMiLpIFPoelJw02igqqKfXo40NRFJgDki2pErjwrVhY6mA
	 4gw2z8S9LVMFJhmPMSljMyTtspDqI2aogGndQFHyc5Z7L0ZvumJ53Pm6Q5VLXxvvzN
	 YY08fT7qsK2Xo+XFNcSzzbWKnWVbCHh4hv8WjxABADuBr0Br4JCKwLgAfdQycQnnfw
	 6ZWqtyFf5C7pQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA0D2606EB;
	Sat,  1 Aug 2026 15:39:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DBF171389
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 15:33:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CDAFB80DD4
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 15:33:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4o8Scq6wSPJZ for <u-boot@lists.u-boot-project.org>;
 Sat,  1 Aug 2026 15:33:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DDA6780D00
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DDA6780D00
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DDA6780D00
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 15:33:39 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 671CYN712676531;
 Sat, 1 Aug 2026 10:33:05 -0500
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010033.outbound.protection.outlook.com [52.101.61.33])
 by m0380145.ppops.net (PPS) with ESMTPS id 4fs8p6j03d-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 01 Aug 2026 10:33:05 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mN5z9P5sDJxodAo9AWyvqli+PVSoONG/UG+B+wrWdVatRem6M25UcUsKeBGaff0je88XVH6dq2qeMWAduW/reS2/uF2ZNTZ/e0sD3tU9DzRPeNMOP7zriQKTRr6bDHoMgl5YXuAkQQZoIHgZYmE8sL8mWXvY4phGDG60rfavsLbmmpJXMmlb0nxVF3JcMzp6NY/+56yzcRZyuJQXMlwr53MJ/Lsv05vqzzxbNlpLbmUGHLm7lm6Wz8YgeADV3b8ATRvijQOODJhloGK1hOxKkBHQMRYGlwHrFrdQRSXztD0SVHzkl/Zf3OiwHcvuX3twkn8etCEAYPpEMd30oi4/ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMSU0w6FT9GTasNJu6ZkBnptBYdlaCaIomubAOC5tt8=;
 b=AeroyW1b3O6g0Ag05Tt1CKzw/NxRoHp3UoHtBHZdgTFdPo/05MNvQ9EWkFvp1udpS8iFHzE4zjl46iGhBALbM24l6DyRGUOSGpq7DSKAAj55XQ/HmjCnbuupK0ST0DQ464jrPWl9THHrotmYqRJweUhQ1s5u5z1YhFiE6RT8Mv6h+1BDRDLfUY9DNrYAJ6VlFdLoX7ZVzeJWQtEVc4mp93umsk5aJfxEgKNRkFb8jlZ+hJ+jQn7ddRIg6Z8yFfIKi/WLK+Pi8yzSKvi4JtmqZOqY42Xep5RodtEFLAYRsmvzM2usFSnoDG3anDPK1zStrgnQR2Y/j6cb1qXyaH4zjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from CH0PR13CA0016.namprd13.prod.outlook.com (2603:10b6:610:b1::21)
 by SA3PR10MB7023.namprd10.prod.outlook.com (2603:10b6:806:313::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sat, 1 Aug
 2026 15:33:01 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::6f) by CH0PR13CA0016.outlook.office365.com
 (2603:10b6:610:b1::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.11 via Frontend Transport; Sat, 1
 Aug 2026 15:33:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Sat, 1 Aug 2026 15:33:00 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sat, 1 Aug
 2026 10:32:59 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sat, 1 Aug
 2026 10:32:59 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Sat, 1 Aug 2026 10:32:59 -0500
Received: from [10.249.135.178] ([10.249.135.178])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 671FWlAL2654141;
 Sat, 1 Aug 2026 10:32:48 -0500
Message-ID: <1ef87c1d-4188-48e6-b67b-205364bbe39b@ti.com>
Date: Sat, 1 Aug 2026 21:02:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/17] spi: cadence_qspi: Use APB write protection
To: Ralph Siemsen <ralph.siemsen@linaro.org>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 <u-boot@lists.u-boot-project.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, "Andrew
 Goodbody" <andrew.goodbody@linaro.org>, Senthil Nathan Thangaraj
 <senthilnathan.thangaraj@amd.com>, Abbarapu Venkatesh Yadav
 <venkyada@qti.qualcomm.com>, Padmarao Begari <padmarao.begari@amd.com>,
 "Naman Trivedi" <naman.trivedimanojbhai@amd.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Sean Anderson <sean.anderson@linux.dev>,
 "Boon Khai Ng" <boon.khai.ng@altera.com>, Ye Li <ye.li@nxp.com>, Alice Guo
 <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, "Jerome
 Forissier" <jerome.forissier@arm.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Peter Robinson <pbrobinson@gmail.com>, "Mikhail
 Kshevetskiy" <mikhail.kshevetskiy@iopsys.eu>, Robert Marko
 <robert.marko@sartura.hr>, Jim Liu <jim.t90615@gmail.com>, Ben Wolsieffer
 <ben.wolsieffer@hefring.com>, Stanley Chu <yschu@nuvoton.com>, Peng Fan
 <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Anshul Dalal <anshuld@ti.com>, David Lechner <dlechner@baylibre.com>,
 Daniel Palmer <daniel@thingy.jp>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Richard Genoud <richard.genoud@bootlin.com>, James Hilliard
 <james.hilliard1@gmail.com>, Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Hai Pham
 <hai.pham.ud@renesas.com>, Johan Jonker <jbx6244@gmail.com>, Simon Glass
 <sjg@chromium.org>, Julien Stephan <jstephan@baylibre.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, <u-kumar1@ti.com>
References: <20260731-rzn1-2026-07-v1-0-af2ce80db9d8@linaro.org>
 <20260731-rzn1-2026-07-v1-3-af2ce80db9d8@linaro.org>
 <800f6c85-7854-4b7e-9509-3006c3ca8b42@ti.com>
 <CANp-EDa+2Hdzg2nn9mcOupkLNPvAohnu_1UZ9AaysG_gvK==AA@mail.gmail.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <CANp-EDa+2Hdzg2nn9mcOupkLNPvAohnu_1UZ9AaysG_gvK==AA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|SA3PR10MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bce42d7-93b9-420b-98fe-08deefe22b55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|82310400026|1800799024|36860700016|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wxers9zseBvF4CAA1udKFRTrdAv6jaiENE11mx+BMG6MdsoPxcAIuIAYMuMnq8UxGkew/9vh2jkTXLrPn4UJT78e8L4Z7GcYamZwQZjiqny7iEkTeYMQ7P7rVVRhv9PD9cYHs2o6PtafJi3aUYQcARj4DSyI2YgeHxRf8NC2DX0Mg/OIZ+AFRvM4LWi3XjrAKxwI7As26GkrMOMGJa1vmKvz/b1sEt5dn/FgYAes89jYB2ESz8xxcF6UaSXRdLTjafyVRRK+aHiARJoGtRXLsa830Ni9voVFCY+Y3eUuBYE1KSJ8XNoKpqbSV3Ru6HdHlYPd7sNiN78DrP27sRLxAlYv0PvmLvwXltACaxpFO+qG8Q8ELEBuduDZBHkr15quVd1ZJ630FVa3JkzivRQ7Z6Fnmua3wkXDaQApZve4AO2Qlx4/kabSwoVhgOk+FqwGuBYNCQdNkDO53PuxlpXdrFUoQqLEdVOqFEPNwBaTyC7uDuEiu+coI1ydB1GsybZwVMqQ7mTZoqUphDzrp14/U3lrRYxWui2+nxOk+eZzeTynngjhlGcNhshOKwROMyv7c81RQv7eu25j2oaoCQ1vqLPr+8BWTDOyPbBiv8Z0T5sq6T1ITEtMbiT1qcIeQJ0j3cB2b2hZLMiARo2KFtziiea0vWAtvDgWCQYN02j8StaH3VEidloeIZA6m4q4nwFKvvXoFr3vGHNFqakff06P7Q==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(82310400026)(1800799024)(36860700016)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pE+QlqidR6CZTx7Mwx+8l3UAGp7Avse7WaoZbP5rz0Za4gam1v2D7+EX+uAXIH9v6mNBSLTY1RIdC/TCCwD4zHMUchBlPxvqNb7LxaRiI5uokJWIgWka2kWn2IMN6anl/R8guP50Z3NoT70Jpl5O5enKOArva3FsfZ8KhiBiH0GAjQPlzqiazge8uvGettfVw0HJnFDc3vgsGQkWpG2N9yFonAWACuxFsk80xLvwwVWqA4y4VAXbpIIQUwZlfLu2tJNx2R2pnunwrDW7Pu2MyaaJOMaYl+k4bmikoTuoB7HZ2cpmkXYpwjr1xsy+Q/64pkC8Ue4R6gs92udyoHIvNm1oMA79nhBgkm+VGvzg6eWCKSZGKuJ+pg3TpmBP7GLw1PgrRQd4vL8kk+v5Dq9aP7oo6X9bUke39C4LJAX9Qhn3dRleIkZe885gzRR+Q3d/
X-Exchange-RoutingPolicyChecked: L6xYl8fYVfLyTqRMYwFDlu5K26glt1ogDjyhzk4djdQ5/zUx0p7mqmonIcsbSCcoxQ2l6Kf96JBlDpgKYqiCjfURvNEAO5LyzR+fspGPBpjoOboPtgYYsqzB323AjqaBRliiOgdC7MW0C+QyWSz2dtryBDsFTNHofqEHEUp7Ubbm4CmasqjSaV1TE9eldO2mRA2ROh7RelIsNzkmPdsnx+04Hk9Zld7cw0J+oi99YfuzgzY0xsKgy68t1Rd+EIfJ8pNt7hR5gmlhYSDpc6dZC8c6yx0ocyJNbb50K+aoA4IOQUgR/YduaolAB+YBF/gEsOABFKQOa4CHPPTc0m9GOg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2026 15:33:00.1258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bce42d7-93b9-420b-98fe-08deefe22b55
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7023
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDEyNSBTYWx0ZWRfX/dngXsalVbDh
 KhQLAdRDmjVGvnqrBWaCom7L9XrmAe00Y2DghQLkhY9oxTAK+odrehBqVdU3ErmYAnJGzBhDWQc
 k6p8vOdMcBxbFeQOY0RjDnFQ/ES84mO0s2S4uINw7GbdQ150OPU/z8dv0XF2rfeU0eo80Neqpog
 bWxpPUpAqCR4YsWTO0GN8LE+yunj8vMYUjZdbcmVRcE2HpVlEPskqj/TvI3UXKwRkqIvbW9qPyC
 TqHLaSODoJgoh0QxoZPLykVm2/vkfOC5ppLP2LY8oGBEQdHa7QanNJG9apxqsRVI7hLq0QNpmor
 Fh28N35jsBYKHPX4N+wfpPNrSCPc86DQTFpDrScpREXJjXKax8nYk59gdKPn6ucCgWTsum4e5ND
 CVgbYeAR4/dy12kDpRe9iOZTV5nYpak1kT3qXXFSA4v/0/a85/2IIeSk0UQNDhSVz2UY5edyZ5U
 hklAnu5yjuM+OJ4v4zg==
X-Proofpoint-GUID: ygg8zmGRcWf3gf8nL2YkdykHDS_vC8Ta
X-Proofpoint-ORIG-GUID: ygg8zmGRcWf3gf8nL2YkdykHDS_vC8Ta
X-Authority-Analysis: v=2.4 cv=RZagzVtv c=1 sm=1 tr=0 ts=6a6e11b1 cx=c_pps
 a=hcnkadelB84e5vzkSSmvUA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=dRNk-zo0d_6vTrdGxaQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDEyNSBTYWx0ZWRfX8M/fLGv6OUS0
 LYWWVSSlWRtKoIiyJ5fE8GsrB64gmztC5367R/AESgfWjnf62VCAF8fyHSfcknr+l3vnp7VY6UZ
 fKHvINt9VA3CYJoKwmi4Fri4ThHrM6o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-01_01,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608010125
X-Mailman-Approved-At: Sat, 01 Aug 2026 15:39:40 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=hMSU0w6FT9GTasNJu6ZkBnptBYdlaCaIomubAOC5t
 t8=; b=VS4DacsCzt8nTSNIwc+x7aR/pVQ00tAx/RJ8dUG8NkIzqEBkPjcIDQXmN
 Ya58qyXZjJISOIuYuifGpjw8QYbNxVJ3HpYAn438dZJDVV2movr1sfxO1w2xBa4X
 RlVg5vcVrKUgCyQc+vXk2wwAfkBHzPmzo6L49fH3z0SKPKhosVnJe9TDmbCxq5/O
 P1iZL9zfudEBJVMom2ko3j/oN+VyKJwbh9jpvAaIZNrJHwcYRQf6W3opNwkpuA8s
 zz65rtlUF1q5AtPaEHMW6KvO1XNuBtoYhF0YFi+S7y1EbJen8EZ3Xkbd0uMUQ3Ug
 vx6EWNIYKNB4mF+gzqyJ1ugASzmRw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMSU0w6FT9GTasNJu6ZkBnptBYdlaCaIomubAOC5tt8=;
 b=wk5zsTsjmfToUNnMpp43cqOD3FazBVoSnBZcxHPMNrCnxw//PXqLhQhC+G+npC8woN6nURFwzaTsVBnnOh6mHhfwMob3p6sEp5pQVomRHNmXoaO6vGECfTTDSQyDBUjAQ/XeB8OFD7v84BEJ5uec8/carvKj/im88mTxMTym8RA=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=VS4DacsC; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=wk5zsTsj
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



On 8/1/2026 6:37 PM, Ralph Siemsen wrote:
> On Sat, Aug 1, 2026 at 3:24 AM Kumar, Udit <u-kumar1@ti.com> wrote:
>>
>> On 7/31/2026 10:03 PM, Ralph Siemsen wrote:
>>> Prevent random memory writes from corrupting flash memory.
>>
>> my suggestion will be check first, why stray write are happening
> 
> This is purely defensive, there are no known stray writes occurring.
> 
>>> +static void cadence_qspi_apb_write_protect_enable(void *reg_base)
>>> +{
>>> +     writel(CQSPI_REG_WRPROT_ENABLE,
>>> +            reg_base + CQSPI_REG_WRITE_PROTECT_CTRL);
>>> +}
>>> +
>>
>> I expect compilation warning on platform, which does not define
>> CONFIG_CADENCE_QSPI_WRITE_PROTECT
> 
> Originally I used #ifdef around this code, but checkpatch complained.
> I can add it back in.
> 
> Curiously, I do not see a warning (about unused function) when
> CONFIG_CADENCE_QSPI_WRITE_PROTECT is not defined.

Could you share your compiler details

My compiler reports warning (gcc version 11.3.1 20220712)

../drivers/spi/cadence_qspi_apb.c:334:13: warning:
‘cadence_qspi_apb_write_protect_enable’ defined but not used
[-Wunused-function]
  334 | static void cadence_qspi_apb_write_protect_enable(void *reg_base)






> Regards,
> Ralph

