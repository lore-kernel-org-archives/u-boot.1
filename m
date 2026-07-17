Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8184C4451B
	for <u-boot@archiver.kernel.org>; Sat, 18 Jul 2026 15:04:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5751D849EB;
	Sat, 18 Jul 2026 17:03:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="P8tiaCa7";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dUfLFgPD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F41BE844F6; Sat, 18 Jul 2026 01:24:07 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37F8483FF5
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 01:24:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HNG0rq3731150; Fri, 17 Jul 2026 18:23:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=La6CFNCr0fMXbVQmDlapy/a8RN4Cxn5bSEhxefx+P
 kI=; b=P8tiaCa7lL58ADNm782gs8mXcmAD2wP8TCn7b6f7r/MsmAGOAtyJauheu
 LTFkW0AvoFTpC3HSuo9TkcL0BB7QPMT3asSGioVctZfjQAjL44L2QovMs6oNIOXg
 jnsvO1PFy4sr9ycQ0GXF8ZXLRELlHuKmNKjTDddfA4eku+15K9Jmh1anvlaQkY8Q
 K2BLWnBQfHrcUoNqRmmXSwonLek5Zu6cgTkkOnJcArcnrda0EZjG3vNM4tU4efbv
 qNyzmBqASDb4txVQXipMbZ23p1BXT4HZ55Mst9OsHidj1EX1RDpqPkLo3bWO/P00
 aKWIX9kUNvCVzTYoJXLVneFyCbOGg==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011049.outbound.protection.outlook.com [40.107.208.49])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ffkc3m34q-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 18:23:49 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9A6Ce1zrlMVsNUjpisSaDPAWadKsfn/c36zpMTpUZdPuAwjA/lcGQg1TxO3TEDmXhf2LbWBoFbMipj5zfevlUI0b87yNDAp9ql39MbNielEMBvDP7nqAEmKXeJ+MCiefIELuSSqHmfPtLPsgiAc+PXp72Hauvab57h/5JqO3A4P8+L3IKXgHkgt/znY34hrcric5UVHy5yHhaLdTEj8XUCTqn12uUwEzmnfQeqQLBMf3EuzkUdYpgIyMoGznxFzlzn21PN853bNb4bMjsLVDmxjPk4BKv1sJMqal5/H6o/Qzt0KrE+dK+BUgASfHttZfhC4li31UuZXjyVNTxJ8sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=La6CFNCr0fMXbVQmDlapy/a8RN4Cxn5bSEhxefx+PkI=;
 b=jFVzPwOjum4dc6THWT1UGP9PFnVwfUFzm1PHURCra89gQNutUyTmsIN/+uAaMJvcspwNYFIv3LxrjFRbRF8BIIr04kmPyJki6GPuMwkOG6tVANBmlqS9EhNrqhjYGawDa37LLbplDdVm+mQBJpZJCXfxvX2Uu9ZJKI2jbKTCkSKdsClyGhn6dZB+1H5XZJjQ1TfP1HZkC0mlD8auKdILIzlZbZA74HMAAEvC1WZ66aiELTWidkoHddbevaIQrkDa7j4jlgVbh9BZ0HQWLxk/7zX6Wp2heSVWLRjbu3Ratgar23sVIg9PCJeiDmIBw8ANKQqlsCSC3HF1pLEl9RKg8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=La6CFNCr0fMXbVQmDlapy/a8RN4Cxn5bSEhxefx+PkI=;
 b=dUfLFgPDj1rVgqC5rNJ9s+ZiYN7usXQ4HuWn/3JAmWjBdHjYIDDCZx/LK5hBXgJBqUiYIieiqn3+bJrLG/i4kfBVXTJcVrCrUBpRknUQrK599Utx49m0F/H1zN8U9hf+fcgO/VAE1nR1H18/J6YyCFgzyW6FxGOfGGYoxEbrAeY=
Received: from MW4P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::22)
 by SA1PR10MB997582.namprd10.prod.outlook.com (2603:10b6:806:4b4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Fri, 17 Jul
 2026 23:23:45 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:303:115:cafe::8e) by MW4P220CA0017.outlook.office365.com
 (2603:10b6:303:115::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 23:23:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 23:23:43 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 18:23:34 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 18:23:34 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 18:23:34 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HNNXNB150115;
 Fri, 17 Jul 2026 18:23:33 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Fri, 17 Jul 2026 18:23:36 -0500
Subject: [PATCH 06/11] board: ti: am62lx: add initial board files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260717-am62lx-v1-6-b9830633afb8@ti.com>
References: <20260717-am62lx-v1-0-b9830633afb8@ti.com>
In-Reply-To: <20260717-am62lx-v1-0-b9830633afb8@ti.com>
To: <u-boot@lists.denx.de>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|SA1PR10MB997582:EE_
X-MS-Office365-Filtering-Correlation-Id: b02e5160-388f-4630-ea73-08dee45a71a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|7416014|3023799007|6133799003|56012099006|18002099003|22082099003|10067099003|13003099007;
X-Microsoft-Antispam-Message-Info: 5ehLJVKZCj1dqJXNcHLAtn3UbCJslguTik2TbtxerCYppfhzg433Mz67rH5GHbYwFaSL0FVLz9Mb/66QsXyGCGcntzgIAnjK8Yljwac3Ss3SRHbmQfuX27LEyzv21ZPOq414ivaEP8/n76nL5nwnBG33UwpzTf48yAZIXYVvMpfQUMxlG+kUzWvAsU5z695YVo6mgqwfdXY497L9EaxZfEHcGLjm5EJTYM+ZtpHeLfrEkFB4r4NLdhSXLu0eaNBW6ZWWObReH6iKgtgDT9SDw9HZjd+EVAkSKNg26U8LEhe9i0dbHGDj6q80iE2JF5Um6rmHFlxdipCtv4SzBrJ0Ob4HNFC2WLJAfAo4d5/GLdaL0W8VHRFPKp/6kZJyxQrCjjeG0ky93EB+nFeGwSFKIHfE2G4S0WviCk/AEiAhWHINS5P1+hXP8RboXy9y3WT/olU7P1jg706YpuFP73nGmri4QbjhfvaVrNtDhl1FopewKLArPHNwlc4seu5W2ZtR+G4sLH7I+5LAg70pYFlO/dts0FgYyqPxVmdS1e+YQnoAdwGlocT031q6xq8roNOjOPHcuyRVspyxT/bBQ33zQGm5uurveodJUP0q5NeLrHLIU66fEBjYBSW0Qgz0mqzg9f+f7flqYTIl9ZNgWu5bSA==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(7416014)(3023799007)(6133799003)(56012099006)(18002099003)(22082099003)(10067099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Tn9k+VzWR01Df798VHHwnoYZoM6E641qVq7ybBk582wPFav7gj+ulEbmApQeXOUYZdo998dFunuYIA9Sz83BuYZJnoBFhjbSpHjZ4PYvXSTbp/hVFzPsnrSN+d3pxA6dbgstlSHAAF+IN9VshGVdngzWKVxeh2012nQ0JlaxpiTSuFAH08ifxjwXk3sZqILLtWCdSehlLWKqojcqjGFNi57oK5pKeQycdrNACo/cV6I6nmShHMn+rAv4jFGa1e7qt0eq1rVtmVLkNURsE6QojkkvRA7aJqQWnWZ+NwQhdHbxSP/EeiQBSyUesavPkTRSdd0RQiVkyNZB3Rj6t/PLZD5uLw0KeOSn75rLEn2OtQxXQUfLga0lWzfZIkybjXAGII/RNNcKQ/aahMEmaNUwj4lj6dyjOBnfYJAUBBddXECOIbT5MfEASi9LX/W5mdQ2
X-Exchange-RoutingPolicyChecked: DFqAOQkdhQ7d7yBj50LyMx+zlo3Y1u4nH8DCE/o2An7mU+W2LNZtA9xqR8KI3XJ6G+JcclQyY3ChL15kP+sG0xfYXxS+bMtDu5tYxeh0eAGFi124dbwqF4dbTh0CAVu/QW6kNzbb2F2w6CeXniAlcvZK+D3rIr83LzE1r4ix2CKosL11adn5wToAi43yAUbWgPtYvlETXSl5Odg1L19ArMFTA0slZcacA/2QAyFJrjT2wMufi/VU9nuWaySExDKz4PWieUtTHAolmNONy3SQTQjmPhSklbtcobr0TrbwY42pgxpL7IcfMu9yhuqowEQynKrZO4Zk4mYpFVg6e8FtBQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 23:23:43.6978 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b02e5160-388f-4630-ea73-08dee45a71a8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997582
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDI0MSBTYWx0ZWRfXzMumAUzwHVdc
 zPjrk4LHffAss+VH0Tr2wNwQqT4ak8BesYNNshkn7djlCZcSOU6+ALvoUdweVh6Kce+WCSuof5r
 OCl+BfvCak2zVAt4QxLl9HbjQr2meLk=
X-Proofpoint-GUID: DfpX1jBTwKUEvxn5Z3JzOfiCzT6pnjN5
X-Authority-Analysis: v=2.4 cv=M7F97Sws c=1 sm=1 tr=0 ts=6a5ab985 cx=c_pps
 a=9TxNVFKjsEmGPsTOmRxrqw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=k-42gJp3AAAA:8
 a=PIOz4nRI_0vEO2-WwqMA:9 a=QEXdDO2ut3YA:10 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-ORIG-GUID: DfpX1jBTwKUEvxn5Z3JzOfiCzT6pnjN5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDI0MSBTYWx0ZWRfXx3SpFOONaWU3
 stJ7I8icUPlR1SVLTNv+ZLApcI46oZqPFM9HgtsvkQaKZUaiZhHYY/aM3Z/ddA4I9Pt4u6YAZag
 tOavAxlef+kW+lZkQPpmWC9mPxGz8t6VWgdOFofe5DzeGy1ftJcwsKhHsNsnSMH12w+/3B3fHjz
 HANOBa4k1XIBI0uQbRQAr7uPAJ5NJCjI1FyiUJdB7JiXcVXeClMxHHbttoyDVPtbW8h0y0YHE/8
 hACOFgX16UbZjkRlZ9mSP3jYEPTBUJDCd7jcCeZC4SHV0yuyKaAMo//XEp7VNc6+SL6aoLJmrDV
 NK9LT3tkLG5jNLK6dxLppOlWz1Ryx95bOCFdtx1iWJyf/PzOq+RiECYb7YXZZoueTaAEqJQf1LG
 MwUeUMEW2iKtJQimtyB/iObTtXOOi/Bbelzr1iKy4X37Omjd0kx42yFYFoQLYWhafV/DYDj57WU
 nxWm+AERmSWSGajNVNA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170241
X-Mailman-Approved-At: Sat, 18 Jul 2026 17:03:16 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Add the initial board files to support the AM62L3-SK reference boards
for basic boot via SD and MMC

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 board/ti/am62lx/Kconfig        |  19 +++
 board/ti/am62lx/MAINTAINERS    |   8 +
 board/ti/am62lx/Makefile       |   7 +
 board/ti/am62lx/am62lx.env     |   8 +
 board/ti/am62lx/board-cfg.yaml |  32 ++++
 board/ti/am62lx/evm.c          |  19 +++
 board/ti/am62lx/sec-cfg.yaml   | 380 +++++++++++++++++++++++++++++++++++++++++
 7 files changed, 473 insertions(+)

diff --git a/board/ti/am62lx/Kconfig b/board/ti/am62lx/Kconfig
new file mode 100644
index 000000000000..2ee6d0221178
--- /dev/null
+++ b/board/ti/am62lx/Kconfig
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+#
+
+if TARGET_AM62L3_EVM
+
+config SYS_BOARD
+	default "am62lx"
+
+config SYS_VENDOR
+	default "ti"
+
+config SYS_CONFIG_NAME
+	default "am62l3_evm"
+
+source "board/ti/common/Kconfig"
+
+endif
diff --git a/board/ti/am62lx/MAINTAINERS b/board/ti/am62lx/MAINTAINERS
new file mode 100644
index 000000000000..e945689a7f17
--- /dev/null
+++ b/board/ti/am62lx/MAINTAINERS
@@ -0,0 +1,8 @@
+AM62Lx BOARD
+M:	Vignesh Raghavendra <vigneshr@ti.com>
+M:	Bryan Brattlof <bb@ti.com>
+M:	Tom Rini <trini@konsulko.com>
+S:	Maintained
+F:	board/ti/am62lx/
+F:	include/configs/am62l3_evm.h
+F:	configs/am62lx_evm_defconfig
diff --git a/board/ti/am62lx/Makefile b/board/ti/am62lx/Makefile
new file mode 100644
index 000000000000..ac5f5e7e807a
--- /dev/null
+++ b/board/ti/am62lx/Makefile
@@ -0,0 +1,7 @@
+#
+# Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+#
+# SPDX-License-Identifier:     GPL-2.0+
+#
+
+obj-y	+= evm.o
diff --git a/board/ti/am62lx/am62lx.env b/board/ti/am62lx/am62lx.env
new file mode 100644
index 000000000000..0dd86db400ee
--- /dev/null
+++ b/board/ti/am62lx/am62lx.env
@@ -0,0 +1,8 @@
+kernel_addr_r=0x82000000
+fdt_addr_r=0x88000000
+fdtoverlay_addr_r=0x89000000
+ramdisk_addr_r=0x88080000
+pxefile_addr_r=0x80100000
+
+dfu_alt_info_ram=
+	u-boot.img ram 0x83000000 0x400000
diff --git a/board/ti/am62lx/board-cfg.yaml b/board/ti/am62lx/board-cfg.yaml
new file mode 100644
index 000000000000..ae4b0e503bd1
--- /dev/null
+++ b/board/ti/am62lx/board-cfg.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Board configuration for the emulated AM62Lx
+#
+---
+board-cfg:
+  rev:
+    boardcfg_abi_maj: 0x0
+    boardcfg_abi_min: 0x1
+
+  control:
+    subhdr:
+      magic: 0xC1D3
+      size: 7
+    main_isolation_enable: 0x5A
+    main_isolation_hostid: 0x2
+
+  bm_writer_cfg:
+    subhdr:
+      magic: 0x7D8A
+      size: 5
+    allowed_host: 10
+
+  reserved: [0, 0, 0, 0, 0, 0, 0]
+
+  debug_cfg:
+    subhdr:
+      magic: 0x020C
+      size: 8
+    trace_dst_enables: 0x00
+    trace_src_enables: 0x00
diff --git a/board/ti/am62lx/evm.c b/board/ti/am62lx/evm.c
new file mode 100644
index 000000000000..cafafb8ede87
--- /dev/null
+++ b/board/ti/am62lx/evm.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Board specific initialization for AM62Lx platforms
+ *
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ */
+
+#include <asm/arch/hardware.h>
+#include <asm/io.h>
+#include <dm/uclass.h>
+#include <env.h>
+#include <fdt_support.h>
+#include <spl.h>
+
+int board_init(void)
+{
+	return 0;
+}
diff --git a/board/ti/am62lx/sec-cfg.yaml b/board/ti/am62lx/sec-cfg.yaml
new file mode 100644
index 000000000000..044e8cb09dd7
--- /dev/null
+++ b/board/ti/am62lx/sec-cfg.yaml
@@ -0,0 +1,380 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Security management configuration for AM62Lx
+#
+---
+
+sec-cfg:
+    rev:
+        boardcfg_abi_maj: 0x0
+        boardcfg_abi_min: 0x1
+
+    processor_acl_list:
+        subhdr:
+            magic: 0xF1EA
+            size: 164
+
+        proc_acl_entries:
+            -  # 1
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 2
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 3
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 4
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 5
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 6
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 7
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 8
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 9
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 10
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 11
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 12
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 13
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 14
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 15
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 16
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 17
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 18
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 19
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 20
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 21
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 22
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 23
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 24
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 25
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 26
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 27
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 28
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 29
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 30
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 31
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 32
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+    host_hierarchy:
+        subhdr:
+            magic: 0x8D27
+            size: 68
+        host_hierarchy_entries:
+            -  # 1
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 2
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 3
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 4
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 5
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 6
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 7
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 8
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 9
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 10
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 11
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 12
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 13
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 14
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 15
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 16
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 17
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 18
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 19
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 20
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 21
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 22
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 23
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 24
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 25
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 26
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 27
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 28
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 29
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 30
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 31
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 32
+                host_id: 0
+                supervisor_host_id: 0
+    otp_config:
+        subhdr:
+            magic: 0x4081
+            size: 69
+        otp_entry:
+            -  # 1
+                host_id: 10
+                host_perms: 2
+            -  # 2
+                host_id: 10
+                host_perms: 2
+            -  # 3
+                host_id: 10
+                host_perms: 2
+            -  # 4
+                host_id: 10
+                host_perms: 2
+            -  # 5
+                host_id: 10
+                host_perms: 2
+            -  # 6
+                host_id: 10
+                host_perms: 2
+            -  # 7
+                host_id: 10
+                host_perms: 2
+            -  # 8
+                host_id: 10
+                host_perms: 2
+            -  # 9
+                host_id: 10
+                host_perms: 2
+            -  # 10
+                host_id: 10
+                host_perms: 2
+            -  # 11
+                host_id: 10
+                host_perms: 2
+            -  # 12
+                host_id: 10
+                host_perms: 2
+            -  # 13
+                host_id: 10
+                host_perms: 2
+            -  # 14
+                host_id: 10
+                host_perms: 2
+            -  # 15
+                host_id: 10
+                host_perms: 2
+            -  # 16
+                host_id: 10
+                host_perms: 2
+            -  # 17
+                host_id: 10
+                host_perms: 2
+            -  # 18
+                host_id: 10
+                host_perms: 2
+            -  # 19
+                host_id: 10
+                host_perms: 2
+            -  # 20
+                host_id: 10
+                host_perms: 2
+            -  # 21
+                host_id: 10
+                host_perms: 2
+            -  # 22
+                host_id: 10
+                host_perms: 2
+            -  # 23
+                host_id: 10
+                host_perms: 2
+            -  # 24
+                host_id: 10
+                host_perms: 2
+            -  # 25
+                host_id: 10
+                host_perms: 2
+            -  # 26
+                host_id: 10
+                host_perms: 2
+            -  # 27
+                host_id: 10
+                host_perms: 2
+            -  # 28
+                host_id: 10
+                host_perms: 2
+            -  # 29
+                host_id: 10
+                host_perms: 2
+            -  # 30
+                host_id: 10
+                host_perms: 2
+            -  # 31
+                host_id: 10
+                host_perms: 2
+            -  # 32
+                host_id: 10
+                host_perms: 2
+        write_host_id: 10
+    dkek_config:
+        subhdr:
+            magic: 0x5170
+            size: 12
+        allowed_hosts: [128, 0, 0, 0]
+        allow_dkek_export_tisci: 0x5A
+        rsvd: [0, 0, 0]
+    sa2ul_cfg:
+        subhdr:
+            magic: 0x0
+            size: 0
+        auth_resource_owner: 0
+        enable_saul_psil_global_config_writes: 0x0
+        rsvd: [0, 0]
+    sec_dbg_config:
+        subhdr:
+            magic: 0x42AF
+            size: 16
+        allow_jtag_unlock: 0x5A
+        allow_wildcard_unlock: 0x5A
+        allowed_debug_level_rsvd: 0
+        rsvd: 0
+        min_cert_rev: 0x0
+        jtag_unlock_hosts: [0, 0, 0, 0]
+    sec_handover_cfg:
+        subhdr:
+            magic: 0x0
+            size: 10
+        handover_msg_sender: 0
+        handover_to_host_id: 0
+        rsvd: [0, 0, 0, 0]

-- 
2.54.0

