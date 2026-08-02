Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67974C55162
	for <u-boot@archiver.kernel.org>; Sun,  2 Aug 2026 13:28:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 337AE60774;
	Sun,  2 Aug 2026 13:27:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LNoIq6lElmbf; Sun,  2 Aug 2026 13:27:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E5DF26075D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785677275;
	bh=JpFnowP9LL8zWuo3To+9C9xtbLX5dAixe7ZCcU61dZ0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iFLjfCX+od6lFrz11rQt+Azvyy61o64qtEb91zicj/wZYfN2FSr7Ry4pnfkAD04LB
	 85DpXHJAKE2mwTKe8XLFrByp+Ml1JD0Nbf/UFOikoVeVStoRt3Jo/3QvtAHxCTwMcj
	 FhVoEv7pst3SeAtc/wmYD/cS3bLtusd+zOyE7m8wqQ9yqv1Vf+3Zu1Si2f88sq1enU
	 MtgPd+oon74I1cqjeuXJ8Z0Hq0pEkXltpCu3AGo1s6cuYFQKaYGXWtucaO4xr/XLSD
	 svyCNOJmHZPQAxXFUiIXGAF3zfzzIvBDWxbH0yRXqqY42rcSAXG3gyIZfDPEqyGOrt
	 XjqPOO4t1WkSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E5DF26075D;
	Sun,  2 Aug 2026 13:27:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 59342194
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 12:11:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4AB0F80CDE
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 12:11:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TWLPzcmbgc_5 for <u-boot@lists.u-boot-project.org>;
 Sun,  2 Aug 2026 12:11:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1302B80CDA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1302B80CDA
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1302B80CDA
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 12:11:45 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 672B9Qjl2160324;
 Sun, 2 Aug 2026 07:11:05 -0500
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012058.outbound.protection.outlook.com
 [40.107.200.58])
 by m0384305.ppops.net (PPS) with ESMTPS id 4ft2rn0cc7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 02 Aug 2026 07:11:04 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QasWBoqKfZvkGD8kr0ilnh2uewI9gKY3BCcBkJtfig/XlIVJESA+aZyCEOHSNEnLl+HMn1j0qX95GWfzZN2w/TbGdmg+3p2ITre7bbZ/jyZc7thNoa3LvC2434gLWShWawVb1ctGDa7/OSiExY8ydDL7I9k6YgZFzL55VWa2fZcfewJdOUZ3FsFWGSGvw5oDOl/4qPwmuzguF31C1xVpncM4clVGfXrC73ogj0t3Ll/YLP3Xc8NNhDAOBTuduq4yP37eCVgQvEqkAAhIvBp39DgwPwRIIMmoxN08nKeyIiMzsi1pl3s+SnP/7Swo04bl/BSZOXaFyx3Ii6ceUmnZOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpFnowP9LL8zWuo3To+9C9xtbLX5dAixe7ZCcU61dZ0=;
 b=dYTe3YgRvIyVsHt/LjIWp1mIC5a2Q9QuYTr0Mt64+WJi5wWkux+0K05pMGTdSHK08XP7iFbwZ2UiVi39nHKQDIVFnV5NV8WPYUxZTqwNI6Rqn4w1IwxlCInFowhlJmgxonzvgSZohFAmpL7AcqSVrYCWFBfu0uNadda0Ya5jBjNGXK6PR6jPnFjuxDFQsJTszkt7T3M38GNDJ5m0TQlqD6+DYEoTdEDQMTtJT0K9BeH8V8sfk6CypKHHMdQ97MrFBynYgWr4Zmt9D2rVGEsw4RujnLxA8sxrKkdtufbbUCzwP3qzIAN4dV+7jUewOER6b9rwh/J/HTwAbYVXKYnFsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::13)
 by IA0PR10MB7668.namprd10.prod.outlook.com (2603:10b6:208:492::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 12:10:59 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::7b) by BY1P220CA0007.outlook.office365.com
 (2603:10b6:a03:59d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.17 via Frontend Transport; Sun, 2
 Aug 2026 12:10:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Sun, 2 Aug 2026 12:10:57 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sun, 2 Aug
 2026 07:10:56 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sun, 2 Aug
 2026 07:10:56 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Sun, 2 Aug 2026 07:10:56 -0500
Received: from [10.249.135.178] ([10.249.135.178])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 672CAgWX646498;
 Sun, 2 Aug 2026 07:10:43 -0500
Message-ID: <f14de499-cb19-4675-98b1-16971712ee3d@ti.com>
Date: Sun, 2 Aug 2026 17:40:41 +0530
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
 <1ef87c1d-4188-48e6-b67b-205364bbe39b@ti.com>
 <CANp-EDZON_QjoF+Y_E099TNxY-DGMH+sZYVtHTwe3mX14C6meQ@mail.gmail.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <CANp-EDZON_QjoF+Y_E099TNxY-DGMH+sZYVtHTwe3mX14C6meQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|IA0PR10MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: 587aa5ed-a8c9-4a0b-58a0-08def08f1c44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700016|23010399003|1800799024|82310400026|6133799003|56012099006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sPW10keNc9C1xawRpdKJFtTalYBpdmexfxSr6N3FxYclxCBtOsMMot+VEm/ZrKyovNVTg3lwNuR0oantmB/h8e0ldeBxoiFf9s5NDDeq3FzYh9l+ZugoSwdnISLRMk/c6KGskF6xrLw5mVrlo5mqFNLVfMMpGEbxqs4sQGBLj1OxeRPrxiWYGPuWQP998ULaJwKr621Fl0wsZZS7LjGH9nqrsMD45SAZ/BwG1yQh37CkAXfhz4aD2h06L/GES6YAPp9I+wUsNq323sdymzv89i7kST6ebTJOR3nxEagJ5VzfDBKzGVrYrD/5ZXyQ002VomQ/mexN/RRQhPaNobZfJntJWit8VDRvTvhcla/evlcXWCRQg+ukiowBUdVjntUPD6jJg7NXA0oChTsXnauYHOj3oWs5EriA1I32OeNqCtRTogm/ZCwryE26lwOmCp8chqDgOKmY/k2Lygwi0MjUtlYqIk9D8aAqQw6eDAYcYRTQ1FKEEpOKIi+4F4BDL9xIhflXfDs7JTg5m1fVUsNoCap+BsKjPemRYki3IQ8h6tYseG5yZocnCTYOo7Uf/UG7e7W9SxOfXKSY0gbzyG8PMVPjJbWjcQuf3tYe5gDz4732Jf8p/bdVkUms9atTUni4GQUQi5z2S2tNyAzn31FVn/u/sIbUUOTO3zGQvVjXGdNU1Tlt1kvkFYvT9cAvE+gPjdUaJBmOqWzjg97WQtc6WQ==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(6133799003)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0AZqGTGn7J6zRmV9msCV01fMglFh9HINNt/dHoWXyaNjgCEvAGv0xpMJSE1MZjn91UqmrwBcPXNw2KB7yD1ywRlP+VfqLCssvYt6JhCUjb6K2Lv9L3Y3Xc/uK2DEHU6t9tIKhoP5bAA2oR3jmcJdLUyHKE0EfrliqvxeuyvZ4ZciN5MvmvpTCl/Ee6dtE6j2hhcX3tqZT/98CkXoUqvgVGr4yKUiJnpdeU9ySKtj6+Uii2mgww5sFoCN78G4WYcoL43XvoEZBHxU5zjZ0Fc2lQZWdnq7kLtLQ9aQhtEOVjQLljWd5mLe0pnJO7LpJfFFKuZeIVHXyr8E/s6mYcSJ2w1x+G+x+yewxIMRahnqk7X2Xgj82ftjqWD1/ZBSU32oOaSQgQawR3O1DTLePzR5bjZFFwykiHAV7W+oKtRyn6TmsgJ9+bbn7fdIcT0lqUqu
X-Exchange-RoutingPolicyChecked: SFueo4W7/nnmf0m9F7Ts6i2ZikaJoTR3zLOJkJbhsT+g3hAvxqUyVh7ivTkrBzNokoEAiQQacyhvKR1PfBEThx0NGP9CTIr9smut8qdtO2hVD+XDE0sJhQli5V10Q3hf/6sfTIdZjZO4KHgqkfLZymNjtuCCjrWNaUDduPyh3pCVQuTBe/ArLXFmp1HuDtRV8FmkccWAe4bUKXrrXaf7AiPnEvu+ynYFbf9HNSZgOtmHji9MoU+nemXj7MBrDd2mEvnVu5DV14gL9i3G5Rbk2Jhq+zsMje8Cs7tiybEk4hl3l+cUCl1KiDMwSp9JC3GcHmHAZQxV6Q+DaYdrJQ4eeA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 12:10:57.7523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 587aa5ed-a8c9-4a0b-58a0-08def08f1c44
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7668
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDEwNiBTYWx0ZWRfXz7ag5mCAs57j
 emrRPRttAbSaGMP8SIURz/KW7FAVpn4bFrii5mvl5MgEHKE/o2ar1Es+PQNANYHKKsrs2UPFELp
 A6hHU/+rDlTrTReFAtupvwljlZWMtDk=
X-Proofpoint-GUID: 1kP3WQ4YLDhJZFWPxEc97dPT-FImwXZr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDEwNiBTYWx0ZWRfXyXSHyA7wyds8
 Sem8aR6Cjha315QUTGc7m0PnsaizsIV6uUWOqWWDZ+J9bapV2vEDPkSoFdSPgSDb7SVxhCOc5Ul
 P5Fcr8Ak3WRbxyCY1vnCame8dH7bS5HjBlyfoVYgwxMZY+kPxn2/FxiANzEWyIp7B7kVLIF+y/y
 wdIYq/tIuP/HTEnGtrUtgab2uPxHRC/6Tz/Ih+5RKrhLnDk4CeiukYq6dK9U1ADDpJG+M+rGZ8m
 59v2S3YGJQEVh4kEnSc4oR7WSNjvJNR3mw/Ks9Z1kfFHc95GrEWOMb7Rga71kyod+lP/jF+Y6pS
 GyrgU1kQ30J+mpqlb/A2aM1N8mDofBn6ZQv0ynUr3peijowt457eP08dDLaQ/2Tkt++YavmIE/b
 EV8aSPldAvVSlJhjpTgh0Hk8y9D9sljtlsB+VATueB5CfgHvnSxXAyfwdBslvMvGxW89CKaLZv9
 CJP5MW8RrrRiDsWNN4A==
X-Proofpoint-ORIG-GUID: 1kP3WQ4YLDhJZFWPxEc97dPT-FImwXZr
X-Authority-Analysis: v=2.4 cv=W5sIkxWk c=1 sm=1 tr=0 ts=6a6f33d8 cx=c_pps
 a=UC1wTn8whqDYkpYF2DSMwg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=r2wLHLo874UMCz6ZVU4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608020106
X-Mailman-Approved-At: Sun, 02 Aug 2026 13:27:38 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=JpFnowP9LL8zWuo3To+9C9xtbLX5dAixe7ZCcU61d
 Z0=; b=ESN/8qvMzxFAVigH8edK5xizjBEGjt5ekOAUw2lP5XQURwpeJRwhmXPqG
 BeDRNFtsrVQ5v9QvAszVlbsY5zKIMlcNHttEAybbmlqvIXfklb5pqfnNRCVfJew0
 8wmBC5z2eveQnEbfsfrzqx/cOW39PkQ5khKRFQK7s4S33B9nglnUeJ8n4HkMw807
 SYCPpkAvZydpZeY9wRVympnttWMP07aETHpdIrExVhq3DtmYud9Pu55bPkUe68hK
 6f/HWVfon9JFCa91LKEDfyLaGO+NgrVZtrcFNyDlN7Bvz5nsasQ3k55T5vGY6WXL
 4OYyh0ajNxIA6OFBH/fB3X8G8nKEg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpFnowP9LL8zWuo3To+9C9xtbLX5dAixe7ZCcU61dZ0=;
 b=NWWkr4RAfTSAwnMHK8ADk7SdPNGHBmoPDNcL+mRbACHjyPASLCpX1zbWr3XgXBkNfua1uOF/Rsf3SS41uF2lHRDmJQquMNxZ3yE/J94LyNawB+Mzu/20jTcGmGSrEVspZ2VQ783/vIKv2INiPheWEvEmBOZsEALQIk2bgRauWJE=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=ESN/8qvM; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=NWWkr4RA
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



On 8/2/2026 4:27 AM, Ralph Siemsen wrote:
> On Sat, Aug 1, 2026 at 11:33 AM Kumar, Udit <u-kumar1@ti.com> wrote:
>>
>> Could you share your compiler details
>>
>> My compiler reports warning (gcc version 11.3.1 20220712)
>>
>> ../drivers/spi/cadence_qspi_apb.c:334:13: warning:
>> ‘cadence_qspi_apb_write_protect_enable’ defined but not used
>> [-Wunused-function]
>>   334 | static void cadence_qspi_apb_write_protect_enable(void *reg_base)
> 
> I'm using arm-none-eabi-gcc (15:13.2.rel1-2) 13.2.1 20231009.
> 
> I would also expect a warning, but none appears. Even when I change
> the "caller" to
> 
>     if (0)
>         cadence_qspi_apb_write_protect_disable(priv->regbase);
> 
> there is no warning. However if I remove those two "caller" lines
> completely, then I get the warning:
> 
>     drivers/spi/cadence_qspi_apb.c:334:13: warning:
> 'cadence_qspi_apb_write_protect_disable' defined but not used
> [-Wunused-function]
> 
> I'm compiling with CONFIG_CC_OPTIMIZE_FOR_SIZE and #
> CONFIG_OPTIMIZE_INLINING is not set (eg. the default values).
> 
> Either way, I am happy to add back an #ifdef around the function definitions.
> 

#ifdef will leads to checkpatch warning.
I suggest using __maybe_unused option for these two functions.


> Regards,
> Ralph

