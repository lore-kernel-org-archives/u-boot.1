Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC006C4451C
	for <u-boot@archiver.kernel.org>; Sat, 18 Jul 2026 15:04:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DB3484A4A;
	Sat, 18 Jul 2026 17:03:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="btQmXz0w";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rrzWikbZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A042838D7; Sat, 18 Jul 2026 01:24:11 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71DB184105
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 01:24:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66HNFfPE2064323;
 Fri, 17 Jul 2026 18:23:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=YfADi9nk1mRi8xlZS3x1Y+O+sw4NtgsTYpz0uf5Xa
 tc=; b=btQmXz0w4/iWFPSZSO138uK94W5LO9VVBgUbIoFbmsOfSZjfztvqZgtuv
 TAX46ksbaOyGoMWWnIAdIe6u3Xgwwrr/XUHbFpvWOPmMqiBvC05iSbNAGm7+hm1s
 Tz3JBCmeuyJDqcqY0Nx+e5kwKMIWZ+PhMmCWYKGqehO4+djmhphXcyM7sTB++cAQ
 xKud5jwEpkxYHQzR4wohgYQ78anVfs1HZUmeR9xINNVygCN/Iy5VL63hbTicsu73
 MPwAUaNuxSdr5uc3GTBwfOz+Bno0QGy7KGl0dLo41gphax5WuWim2sUbEmh8HZs4
 xdTW5bfn4iXqma8FKzdrbZVBVSXIg==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011055.outbound.protection.outlook.com [52.101.52.55])
 by m0384305.ppops.net (PPS) with ESMTPS id 4ffgsmcsq8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 18:23:49 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dd4pmXFi3w2UgeEFgLUnL8W8Iw1vd0bVZzWUCfS93apEeFhYDoMYAWlU8OK+qZBzZrSTSdEoVPBF4s7uqNbhhGf9BjlBK30zMMAVtuLNI54g9Sc5rXvsC/8qQxCa8o2IBypRyCVX95E+dMMQt0GB8FQN1gSt+No22JYax7p1DkH6f86nXB4nhk4nay086SsKnfrHpHIxGXtUlFXceLdn0qMYtDIvlKHRQEGeJcjiWeUFWFfkJJVRYaF84KcUizVL4Kw4237WNd3Mf6X1y7g7pzdc9eux1wWFyUfStzHYaiLfdDmVTsq7NM6RD/qLpSEBxFQfUuax1XApt3ZDXQiAHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfADi9nk1mRi8xlZS3x1Y+O+sw4NtgsTYpz0uf5Xatc=;
 b=zOGF8S1qsjRo3BUXF2izy710UUe+Rg3JObnLpDXaxquV3dwOZLzcxqBvEZH4G/nmmvl5+A9afnm/JwfK4FiU4scBjNxakKL+OUD41ZpNDdysCLyN1qEoRIjrD7K+AIVnMD18mQ1I+yPcuEr7mb4ZFkK6kBoDjfafwvaj4S1GCsCLXm0142HaSqo5+9oDcAR4DlhcaUFP7FedIWmWCH+g82U9tpgJurqJGmbUivUbbNVx0502mRU44K/Zp7PDtvSn2k3P5UtAMAM4IQYF7LvgmjWJBsNvPfYnlB+pnqjvfmSXWJnvZtRywToa0dGmMHiHrIU5rJsuaUGHVHvwESR8OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfADi9nk1mRi8xlZS3x1Y+O+sw4NtgsTYpz0uf5Xatc=;
 b=rrzWikbZTD5IGl/2wwgD4ehQeDiEyoV0M21HPAICMEbU0nzYbyisVtIweKUm5cRtIUopXdsyinzTc8KDZ61xhyHm6dB1/oHo8jtLEH6J8rB+ddyvL6e5pTUq9qSc/TetgPGV5x9YU67YJNA+CfQfc0MpxSKNIcvP4pDeIyDLlys=
Received: from MW4P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::10)
 by CY5PR10MB6165.namprd10.prod.outlook.com (2603:10b6:930:33::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 23:23:43 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:303:115:cafe::48) by MW4P220CA0005.outlook.office365.com
 (2603:10b6:303:115::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 23:23:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 23:23:41 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 18:23:34 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 18:23:34 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 18:23:34 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HNNX7l745787;
 Fri, 17 Jul 2026 18:23:33 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Fri, 17 Jul 2026 18:23:35 -0500
Subject: [PATCH 05/11] arm: mach-k3: Add initial am62lx SoC support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260717-am62lx-v1-5-b9830633afb8@ti.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|CY5PR10MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: 99771df0-261a-4be9-6b6b-08dee45a7085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|7416014|376014|82310400026|1800799024|13003099007|6133799003|56012099006|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /3hbkbYoG6mmvOnBRZKXEgir0xl0aDbXJRaz/efZjJq+K6hnm1lziwHfdDsHyPc/4AlGLlHCvVYD6LAoSHbBf4Mv6G1EAbJ+L3PBxCWXNvP2ZzDrzeRFql77cl4ocnLMZm6ULHJwiESYE6RUAc1PKJ/iPGgEoKIwg2UCT2ByQ47wUUBdrfS9/R4LhjOXAMGC65LGxBufpyLB/uKkjdcz4ZOF3sJXMInpIQ8yAoosSVgW0cnWFRvLvUb/URjBjMLFHWNvOi+bRLuJq+ECL46P2gIqIFvzxFYwHlPwvjp/iXZOpvb7dni+oJzjHQjEEXYmrmLamfjJ6frwIAB+zCjvHl0GCPOkxBSS21fzUMoco3ry1RB4PiJxZ0beQptzlKnXlmMTXPev2geYyBbiB/06YwMKmHpdRjdVvzRj/KYhnsYV9OFaHC75j93q23yxhCnMaEgaXWASxdpNwDyT8+3GkHQ0ODr1r6EMd4DSpzKsApijm+ZHHp3PlQo/cEJvWn99daVXDW+RsTs9EqLFw4i+cdwOQLkPTnvPXcd7clf6cfY0t5nglxqyC6T8RziJJJUYkthmttAbSRdtQH0kjZLa5SttwxBNEFmPSKytlNyazBXgvWdAuTvfIZDKBBwm5EFj0qolQxbzGa1BRXSUnO9myw==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(7416014)(376014)(82310400026)(1800799024)(13003099007)(6133799003)(56012099006)(10067099003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hCzhxAAngjhcJkpZpZH+NldlrErUpKW/W7yI424h2wU0o0J9oTu923kXBiuBcoBAfUGPxYe15LsUgMJpas9pgUZ9ZuE09e9uO2dmMPdlAkQG3L+gTyLLyuNvNz3a0VAXX4ONVZ0URTc08Fl99WAH5bHfj6D9FL0t6klVduLINOkkf1C6B6ZGXsCeQqb0HUxdx+dZiCvTYakXBb6Y1UWsXyNo6R3WjhbjEZ5+hbNab+xubyGqO9cBpsqyHpo5PcDb+Bhi9upYTnRxati+6QIK4dcLyCx4sT4kViUh5n0+tNuhjNaicZHxe2f2d7XyaFcbPiOicjGWc+baWRZzLJlDIdFA4ZNLmmZyrueFROY6osspe0SddMpuyZX/MQfSb27l15Bly2jPNuIKI3707sRAx0a1cYHeK095mqOl2PkmWikN2hqXLRYlL5origxQNrry
X-Exchange-RoutingPolicyChecked: PKwVHuZYTG8yQ38j+OUzywUCc4nQ9SRQ9nscG7LueLUV414yglrOVLD68Ys9WhyF6zxuiQ3/SbQ1AZ/5ryTb2SRJCFlOvMFzvpSMCVioRHezSN/DzhWj7cbXUU/eQ0aMdVMkFLBcAVKEk2g6cJYE1KL8sNYLfiywtIojoGpplKmMg6/zImNHDNzZr4lxir29LvOmGr4Tf1pNHmVc5+G1FkrvMw9l7mgsJH0lFIFu0eZOrbMbfK3B7jaNWFv+nVELUE1rmoGHPq+MpOnXEunvumILHbffdAFw1uRl5lgdxm+r5+e5D1P273mPmC/j1X+h006Go/N1dvIg49Lulab7YQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 23:23:41.8276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99771df0-261a-4be9-6b6b-08dee45a7085
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6165
X-Proofpoint-GUID: e38NNMIY50Tln6z3Qwkjjmolzd6fRh_8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDI0MSBTYWx0ZWRfXz8cqHbo8onqY
 a3QGDNY1e5CrW2cbHwQQLpKNHhND+btLtV1t0rTjsWnbJhAEL3NjP8CT+ooyZAiYYgQMYe6u695
 Md3DTT6oY2q7aHI8LixwT4L83rUjGKBFKcbmQBG3+cFjfOM2wondWRG0VC6Mq+mdSxuOIbb3ACP
 lN0A5HQdRfoUrG8z3ueknmYDiTX5byNyNlfZYJuipsUaHgnAPlMb1w+9Q55Uv9nO2s0PzldkWJ7
 rDrb/I5Yre4i7GGPhJcq9sdhL4IsPRnv47xoPxxlcQhHLVW60ZWNvXVZDy3B/7oCySH6j9Bsvz0
 0+iWGX+QxFgi5VGNZhkpq4DVV/U0SnmwfpvQr3wGrwux+k1OwRynncxhO6GUBFfKzl5JFPJfAjT
 hZuUmzFPrxIYL4fuZpG/b+IGKafg0ddOPpcIfNqsJnrGEEBil3KFYQ8cYmYPNtT4CxFhpqkX2Lh
 0lcNyByeXN5gl+hp3zQ==
X-Authority-Analysis: v=2.4 cv=GJ841ONK c=1 sm=1 tr=0 ts=6a5ab985 cx=c_pps
 a=8eAlC+B4wJl04ff18yArKA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=VCD-tvVv1Yg_-E4SfhsA:9
 a=RsZ6VNeSSzfZIya8:21 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: e38NNMIY50Tln6z3Qwkjjmolzd6fRh_8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDI0MSBTYWx0ZWRfXxw1ocLTubS+e
 +nQefoJI93nE/LhV1fkkpDDayTV0D9ig5i8fAPUPiPWmqOqbKlPTus/RODhFd4nEeFPbx0LEpi8
 r3cGMBZ6tgoHDbW58uOQ5VSg4W/Az3g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
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

Add initial mach-k3 files needed to support boards based on the AM62L
family of SoCs

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/mach-k3/Kconfig                       |  13 +-
 arch/arm/mach-k3/Makefile                      |   2 +
 arch/arm/mach-k3/am62lx/Kconfig                |  23 ++
 arch/arm/mach-k3/am62lx/Makefile               |   7 +
 arch/arm/mach-k3/am62lx/am62l3_fdt.c           |  12 +
 arch/arm/mach-k3/am62lx/am62l3_init.c          |  58 ++++
 arch/arm/mach-k3/am62lx/boot.c                 |  82 +++++
 arch/arm/mach-k3/am62lx/schema.yaml            | 427 +++++++++++++++++++++++++
 arch/arm/mach-k3/include/mach/am62l_hardware.h |  48 +++
 arch/arm/mach-k3/include/mach/am62l_spl.h      |  41 +++
 arch/arm/mach-k3/include/mach/hardware.h       |   4 +
 arch/arm/mach-k3/include/mach/spl.h            |   4 +
 include/configs/am62l3_evm.h                   |  14 +
 13 files changed, 734 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index a32ed3a9683f..c9874fd57b8a 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -10,6 +10,15 @@ config SOC_K3_AM625
 config SOC_K3_AM62A7
 	bool "TI's K3 based AM62A7 SoC Family Support"
 
+config SOC_K3_AM62L3
+	bool "TI's K3 based AM62L3 SoC Family Support"
+	select CLK_SCMI
+	select SPL_CLK_SCMI
+	select SCMI_FIRMWARE
+	select SCMI_POWER_DOMAIN
+	select SPL_SCMI_POWER_DOMAIN
+	select SYSRESET_PSCI
+
 config SOC_K3_AM62P5
 	bool "TI's K3 based AM62P5 SoC Family Support"
 
@@ -84,6 +93,7 @@ config SYS_K3_BOOT_PARAM_TABLE_INDEX
 	default 0x43c3f290 if SOC_K3_AM625
 	default 0x43c3f290 if SOC_K3_AM62A7 && CPU_V7R
 	default 0x7000f290 if SOC_K3_AM62A7 && ARM64
+	default 0x43c4f290 if SOC_K3_AM62L3
 	default 0x43c4f290 if SOC_K3_AM62P5
 	default 0x43c7f290 if SOC_K3_J722S
 	help
@@ -124,7 +134,7 @@ config K3_EARLY_CONS_IDX
 
 config K3_ATF_LOAD_ADDR
 	hex "Load address of ATF image"
-	default 0x80000000 if (SOC_K3_AM625 || SOC_K3_AM62A7 || SOC_K3_AM62P5 || SOC_K3_J722S)
+	default 0x80000000 if (SOC_K3_AM625 || SOC_K3_AM62A7 || SOC_K3_AM62P5 || SOC_K3_J722S || SOC_K3_AM62L3)
 	default 0x70000000
 	help
 	  The load address for the ATF image. This value is used to build the
@@ -206,6 +216,7 @@ source "arch/arm/mach-k3/am65x/Kconfig"
 source "arch/arm/mach-k3/am64x/Kconfig"
 source "arch/arm/mach-k3/am62x/Kconfig"
 source "arch/arm/mach-k3/am62ax/Kconfig"
+source "arch/arm/mach-k3/am62lx/Kconfig"
 source "arch/arm/mach-k3/am62px/Kconfig"
 source "arch/arm/mach-k3/j721e/Kconfig"
 source "arch/arm/mach-k3/j7200/Kconfig"
diff --git a/arch/arm/mach-k3/Makefile b/arch/arm/mach-k3/Makefile
index b2fd5810b67c..66ae20143b6f 100644
--- a/arch/arm/mach-k3/Makefile
+++ b/arch/arm/mach-k3/Makefile
@@ -6,9 +6,11 @@
 obj-$(CONFIG_ARM64) += arm64/
 obj-$(CONFIG_CPU_V7R) += r5/
 obj-$(CONFIG_OF_LIBFDT) += common_fdt.o
+
 obj-y += common.o security.o k3-ddr.o
 obj-$(CONFIG_SOC_K3_AM62A7) += am62ax/
 obj-$(CONFIG_SOC_K3_AM62P5) += am62px/
+obj-$(CONFIG_SOC_K3_AM62L3) += am62lx/
 obj-$(CONFIG_SOC_K3_AM625) += am62x/
 obj-$(CONFIG_SOC_K3_AM642) += am64x/
 obj-$(CONFIG_SOC_K3_AM654) += am65x/
diff --git a/arch/arm/mach-k3/am62lx/Kconfig b/arch/arm/mach-k3/am62lx/Kconfig
new file mode 100644
index 000000000000..d9609a91993a
--- /dev/null
+++ b/arch/arm/mach-k3/am62lx/Kconfig
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+#
+
+if SOC_K3_AM62L3
+
+choice
+	prompt "TI K3 AM62Lx based boards"
+	optional
+
+config TARGET_AM62L3_EVM
+	bool "TI K3 based AM62L5 EVM"
+	select ARM64
+	select BINMAN
+	select OF_UPSTREAM
+	select OF_SYSTEM_SETUP
+
+endchoice
+
+source "board/ti/am62lx/Kconfig"
+
+endif
diff --git a/arch/arm/mach-k3/am62lx/Makefile b/arch/arm/mach-k3/am62lx/Makefile
new file mode 100644
index 000000000000..c97ffe27492f
--- /dev/null
+++ b/arch/arm/mach-k3/am62lx/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+#
+obj-$(CONFIG_OF_SYSTEM_SETUP) += am62l3_fdt.o
+obj-$(CONFIG_SPL_BUILD) += am62l3_init.o
+obj-y += boot.o
diff --git a/arch/arm/mach-k3/am62lx/am62l3_fdt.c b/arch/arm/mach-k3/am62lx/am62l3_fdt.c
new file mode 100644
index 000000000000..da8c2d18ba86
--- /dev/null
+++ b/arch/arm/mach-k3/am62lx/am62l3_fdt.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <asm/arch/k3-common-fdt.h>
+#include <fdt_support.h>
+
+int ft_system_setup(void *blob, struct bd_info *bd)
+{
+	return fdt_fixup_reserved(blob);
+}
diff --git a/arch/arm/mach-k3/am62lx/am62l3_init.c b/arch/arm/mach-k3/am62lx/am62l3_init.c
new file mode 100644
index 000000000000..ee2a50f808d0
--- /dev/null
+++ b/arch/arm/mach-k3/am62lx/am62l3_init.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AM62Lx: SoC specific initialization
+ *
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <asm/arch/hardware.h>
+#include <asm/io.h>
+#include <dm.h>
+#include <dm/uclass-internal.h>
+#include <hang.h>
+#include <spl.h>
+
+#include "../common.h"
+
+void board_init_f(ulong dummy)
+{
+	int ret;
+
+	ret = spl_early_init();
+	if (ret) {
+		debug("spl_early_init() failed: %d\n", ret);
+		hang();
+	}
+
+	preloader_console_init();
+	debug("am62lx_init: %s done\n", __func__);
+}
+
+u32 spl_boot_device(void)
+{
+	return get_boot_device();
+}
+
+u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
+{
+	u32 devstat = readl(CTRLMMR_MAIN_DEVSTAT);
+	u32 bootmode = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
+		MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
+	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
+		MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
+
+	switch (bootmode) {
+	case BOOT_DEVICE_EMMC:
+		if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
+			return MMCSD_MODE_EMMCBOOT;
+		if (IS_ENABLED(CONFIG_SPL_FS_FAT) || IS_ENABLED(CONFIG_SPL_FS_EXT4))
+			return MMCSD_MODE_FS;
+		return MMCSD_MODE_EMMCBOOT;
+	case BOOT_DEVICE_MMC:
+		if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
+			return MMCSD_MODE_RAW;
+	default:
+		return MMCSD_MODE_FS;
+	}
+}
+
diff --git a/arch/arm/mach-k3/am62lx/boot.c b/arch/arm/mach-k3/am62lx/boot.c
new file mode 100644
index 000000000000..a0d3387cb40d
--- /dev/null
+++ b/arch/arm/mach-k3/am62lx/boot.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <asm/io.h>
+#include <asm/arch/hardware.h>
+#include <asm/arch/am62l_spl.h>
+
+static u32 get_backup_bootmedia(u32 devstat)
+{
+	u32 bootmode = (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_MASK) >>
+				MAIN_DEVSTAT_BACKUP_BOOTMODE_SHIFT;
+	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK) >>
+				MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT;
+
+	switch (bootmode) {
+	case BACKUP_BOOT_DEVICE_UART:
+		return BOOT_DEVICE_UART;
+
+	case BACKUP_BOOT_DEVICE_MMC:
+		if (bootmode_cfg)
+			return BOOT_DEVICE_MMC2;
+		return BOOT_DEVICE_MMC1;
+
+	case BACKUP_BOOT_DEVICE_SPI:
+		return BOOT_DEVICE_SPI;
+
+	case BACKUP_BOOT_DEVICE_DFU:
+		if (bootmode_cfg & MAIN_DEVSTAT_BACKUP_USB_MODE_MASK)
+			return BOOT_DEVICE_USB;
+		return BOOT_DEVICE_DFU;
+	};
+
+	return BOOT_DEVICE_RAM;
+}
+
+static u32 get_primary_bootmedia(u32 devstat)
+{
+	u32 bootmode = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
+				MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
+	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
+				MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
+
+	switch (bootmode) {
+	case BOOT_DEVICE_XSPI_FAST:
+	case BOOT_DEVICE_XSPI:
+	case BOOT_DEVICE_OSPI:
+	case BOOT_DEVICE_QSPI:
+	case BOOT_DEVICE_SPI:
+		return BOOT_DEVICE_SPI;
+
+	case BOOT_DEVICE_EMMC:
+		return BOOT_DEVICE_MMC1;
+
+	case BOOT_DEVICE_SPI_NAND:
+		return BOOT_DEVICE_SPI_NAND;
+
+	case BOOT_DEVICE_MMC:
+		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK) >>
+				MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT)
+			return BOOT_DEVICE_MMC2;
+		return BOOT_DEVICE_MMC1;
+
+	case BOOT_DEVICE_DFU:
+		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK) >>
+		    MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT)
+			return BOOT_DEVICE_USB;
+		return BOOT_DEVICE_DFU;
+
+	case BOOT_DEVICE_NOBOOT:
+		return BOOT_DEVICE_RAM;
+	}
+
+	return bootmode;
+}
+
+u32 get_boot_device(void)
+{
+	u32 devstat = readl(CTRLMMR_MAIN_DEVSTAT);
+	u32 bootmode = *(u32 *)(K3_BOOT_PARAM_TABLE_INDEX_OCRAM);
+
+	if (bootmode == K3_PRIMARY_BOOTMODE)
+		return get_primary_bootmedia(devstat);
+	return get_backup_bootmedia(devstat);
+}
diff --git a/arch/arm/mach-k3/am62lx/schema.yaml b/arch/arm/mach-k3/am62lx/schema.yaml
new file mode 100644
index 000000000000..c1dcd9ced403
--- /dev/null
+++ b/arch/arm/mach-k3/am62lx/schema.yaml
@@ -0,0 +1,427 @@
+# SPDX-License-Identifier: GPL-2.0-only OR MIT
+#
+# Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Config schema for TI AM62L devices
+#
+
+---
+
+definitions:
+    u8:
+        type: integer
+        minimum: 0
+        maximum: 0xff
+    u16:
+        type: integer
+        minimum: 0
+        maximum: 0xffff
+    u32:
+        type: integer
+        minimum: 0
+        maximum: 0xffffffff
+
+
+
+type: object
+properties:
+    pm-cfg:
+        type: object
+        properties:
+            rev:
+                type: object
+                properties:
+                    boardcfg_abi_maj:
+                        $ref: "#/definitions/u8"
+                    boardcfg_abi_min:
+                        $ref: "#/definitions/u8"
+    board-cfg:
+        type: object
+        properties:
+            rev:
+                type: object
+                properties:
+                    boardcfg_abi_maj:
+                        $ref: "#/definitions/u8"
+                    boardcfg_abi_min:
+                        $ref: "#/definitions/u8"
+            control:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    main_isolation_enable:
+                        $ref: "#/definitions/u8"
+                    main_isolation_hostid:
+                        $ref: "#/definitions/u16"
+
+            bm_writer_cfg:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    allowed_host:
+                        $ref : "#/definitions/u8"
+
+            reserved:
+                type: array
+                minItems: 7
+                maxItems: 7
+                items:
+                    $ref: "#/definitions/u8"
+
+            debug_cfg:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    trace_dst_enables:
+                        $ref: "#/definitions/u16"
+                    trace_src_enables:
+                        $ref: "#/definitions/u16"
+
+    sec-cfg:
+        type: object
+        properties:
+            rev:
+                type: object
+                properties:
+                    boardcfg_abi_maj:
+                        $ref: "#/definitions/u8"
+                    boardcfg_abi_min:
+                        $ref: "#/definitions/u8"
+
+            processor_acl_list:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    proc_acl_entries:
+                        type: array
+                        minItems: 32
+                        maxItems: 32
+                        items:
+                            type: object
+                            properties:
+                                processor_id:
+                                    $ref: "#/definitions/u8"
+                                proc_access_master:
+                                    $ref: "#/definitions/u8"
+                                proc_access_secondary:
+                                    type: array
+                                    minItems: 3
+                                    maxItems: 3
+                                    items:
+                                        $ref: "#/definitions/u8"
+            host_hierarchy:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    host_hierarchy_entries:
+                        type: array
+                        minItems: 32
+                        maxItems: 32
+                        items:
+                            type: object
+                            properties:
+                                host_id:
+                                    $ref: "#/definitions/u8"
+                                supervisor_host_id:
+                                    $ref: "#/definitions/u8"
+
+            otp_config:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    otp_entry:
+                        type: array
+                        minItems: 32
+                        maxItems: 32
+                        items:
+                            type: object
+                            properties:
+                                host_id:
+                                    $ref: "#/definitions/u8"
+                                host_perms:
+                                    $ref: "#/definitions/u8"
+                    write_host_id:
+                        $ref: "#/definitions/u8"
+
+            dkek_config:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    allowed_hosts:
+                        type: array
+                        minItems: 4
+                        maxItems: 4
+                        items:
+                            $ref: "#/definitions/u8"
+                    allow_dkek_export_tisci:
+                        $ref: "#/definitions/u8"
+                    rsvd:
+                        type: array
+                        minItems: 3
+                        maxItems: 3
+                        items:
+                            $ref: "#/definitions/u8"
+
+            sa2ul_cfg:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    rsvd:
+                        type: array
+                        minItems: 2
+                        maxItems: 4
+                        items:
+                            $ref: "#/definitions/u8"
+                    enable_saul_psil_global_config_writes:
+                        $ref: "#/definitions/u8"
+                    auth_resource_owner:
+                        $ref: "#/definitions/u8"
+
+            sec_dbg_config:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    allow_jtag_unlock:
+                        $ref: "#/definitions/u8"
+                    allow_wildcard_unlock:
+                        $ref: "#/definitions/u8"
+                    allowed_debug_level_rsvd:
+                        $ref: "#/definitions/u8"
+                    rsvd:
+                        $ref: "#/definitions/u8"
+                    min_cert_rev:
+                        $ref: "#/definitions/u32"
+                    jtag_unlock_hosts:
+                        type: array
+                        minItems: 4
+                        maxItems: 4
+                        items:
+                            $ref: "#/definitions/u8"
+
+
+            sec_handover_cfg:
+                type: object
+                properties:
+                    subhdr:
+                        type: object
+                        properties:
+                            magic:
+                                $ref: "#/definitions/u16"
+                            size:
+                                $ref: "#/definitions/u16"
+                    handover_msg_sender:
+                        $ref: "#/definitions/u8"
+                    handover_to_host_id:
+                        $ref: "#/definitions/u8"
+                    rsvd:
+                        type: array
+                        minItems: 4
+                        maxItems: 4
+                        items:
+                            $ref: "#/definitions/u8"
+
+    rm-cfg:
+        type: object
+        properties:
+            rm_boardcfg:
+                type: object
+                properties:
+                    rev:
+                        type: object
+                        properties:
+                            boardcfg_abi_maj:
+                                $ref: "#/definitions/u8"
+                            boardcfg_abi_min:
+                                $ref: "#/definitions/u8"
+
+                    host_cfg:
+                        type: object
+                        properties:
+                            subhdr:
+                                type: object
+                                properties:
+                                    magic:
+                                        $ref: "#/definitions/u16"
+                                    size:
+                                        $ref: "#/definitions/u16"
+                            host_cfg_entries:
+                                type: array
+                                minItems: 0
+                                maxItems: 32
+                                items:
+                                    type: object
+                                    properties:
+                                        host_id:
+                                            $ref: "#/definitions/u8"
+                                        allowed_atype:
+                                            $ref: "#/definitions/u8"
+                                        allowed_qos:
+                                            $ref: "#/definitions/u16"
+                                        allowed_orderid:
+                                            $ref: "#/definitions/u32"
+                                        allowed_priority:
+                                            $ref: "#/definitions/u16"
+                                        allowed_sched_priority:
+                                            $ref: "#/definitions/u8"
+                    resasg:
+                        type: object
+                        properties:
+                            subhdr:
+                                type: object
+                                properties:
+                                    magic:
+                                        $ref: "#/definitions/u16"
+                                    size:
+                                        $ref: "#/definitions/u16"
+                            resasg_entries_size:
+                                        $ref: "#/definitions/u16"
+                            reserved:
+                                        $ref: "#/definitions/u16"
+
+            resasg_entries:
+                type: array
+                minItems: 0
+                maxItems: 468
+                items:
+                    type: object
+                    properties:
+                        start_resource:
+                            $ref: "#/definitions/u16"
+                        num_resource:
+                            $ref: "#/definitions/u16"
+                        type:
+                            $ref: "#/definitions/u16"
+                        host_id:
+                            $ref: "#/definitions/u8"
+                        reserved:
+                            $ref: "#/definitions/u8"
+
+    tifs-rm-cfg:
+        type: object
+        properties:
+            rm_boardcfg:
+                type: object
+                properties:
+                    rev:
+                        type: object
+                        properties:
+                            boardcfg_abi_maj:
+                                $ref: "#/definitions/u8"
+                            boardcfg_abi_min:
+                                $ref: "#/definitions/u8"
+
+                    host_cfg:
+                        type: object
+                        properties:
+                            subhdr:
+                                type: object
+                                properties:
+                                    magic:
+                                        $ref: "#/definitions/u16"
+                                    size:
+                                        $ref: "#/definitions/u16"
+                            host_cfg_entries:
+                                type: array
+                                minItems: 0
+                                maxItems: 32
+                                items:
+                                    type: object
+                                    properties:
+                                        host_id:
+                                            $ref: "#/definitions/u8"
+                                        allowed_atype:
+                                            $ref: "#/definitions/u8"
+                                        allowed_qos:
+                                            $ref: "#/definitions/u16"
+                                        allowed_orderid:
+                                            $ref: "#/definitions/u32"
+                                        allowed_priority:
+                                            $ref: "#/definitions/u16"
+                                        allowed_sched_priority:
+                                            $ref: "#/definitions/u8"
+                    resasg:
+                        type: object
+                        properties:
+                            subhdr:
+                                type: object
+                                properties:
+                                    magic:
+                                        $ref: "#/definitions/u16"
+                                    size:
+                                        $ref: "#/definitions/u16"
+                            resasg_entries_size:
+                                        $ref: "#/definitions/u16"
+                            reserved:
+                                        $ref: "#/definitions/u16"
+
+            resasg_entries:
+                type: array
+                minItems: 0
+                maxItems: 468
+                items:
+                    type: object
+                    properties:
+                        start_resource:
+                            $ref: "#/definitions/u16"
+                        num_resource:
+                            $ref: "#/definitions/u16"
+                        type:
+                            $ref: "#/definitions/u16"
+                        host_id:
+                            $ref: "#/definitions/u8"
+                        reserved:
+                            $ref: "#/definitions/u8"
diff --git a/arch/arm/mach-k3/include/mach/am62l_hardware.h b/arch/arm/mach-k3/include/mach/am62l_hardware.h
new file mode 100644
index 000000000000..7791511ff2a2
--- /dev/null
+++ b/arch/arm/mach-k3/include/mach/am62l_hardware.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * AM62Lx SoC definitions, structures etc.
+ *
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef __ASM_ARCH_AM62L_HARDWARE_H
+#define __ASM_ARCH_AM62L_HARDWARE_H
+
+#include <config.h>
+#ifndef __ASSEMBLY__
+#include <linux/bitops.h>
+#endif
+
+#define CTRL_MMR0_BASE				0x00100000
+#define WKUP_CTRL_MMR0_BASE			0x43000000
+#define WKUP_CTRL_MMR1_BASE			0x43010000
+
+#define CTRLMMR_MAIN_DEVSTAT			(WKUP_CTRL_MMR1_BASE + 0x30)
+#define MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK	GENMASK(6, 3)
+#define MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT	3
+#define MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK	GENMASK(9, 7)
+#define MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT	7
+#define MAIN_DEVSTAT_BACKUP_BOOTMODE_MASK	GENMASK(12, 10)
+#define MAIN_DEVSTAT_BACKUP_BOOTMODE_SHIFT	10
+#define MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK	BIT(13)
+#define MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT	13
+
+/* Primary Bootmode MMC Config macros */
+#define MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK	BIT(2)
+#define MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT	2
+#define MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK	BIT(0)
+#define MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_SHIFT	0
+
+/* Primary Bootmode USB Config macros */
+#define MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT	1
+#define MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK	BIT(1)
+
+/* Backup Bootmode USB Config macros */
+#define MAIN_DEVSTAT_BACKUP_USB_MODE_MASK	BIT(0)
+
+/* address boot rom leaves its boot structure */
+#define K3_BOOT_PARAM_TABLE_INDEX_OCRAM		0x70816e70
+
+static const u32 put_core_ids[] = {};
+
+#endif /* __ASM_ARCH_AM62L_HARDWARE_H */
diff --git a/arch/arm/mach-k3/include/mach/am62l_spl.h b/arch/arm/mach-k3/include/mach/am62l_spl.h
new file mode 100644
index 000000000000..52d702d179c6
--- /dev/null
+++ b/arch/arm/mach-k3/include/mach/am62l_spl.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef _ASM_ARCH_AM62L_SPL_H_
+#define _ASM_ARCH_AM62L_SPL_H_
+
+/* Primary BootMode devices */
+#define BOOT_DEVICE_SPI_NAND		0x00
+#define BOOT_DEVICE_RAM			0xFF
+#define BOOT_DEVICE_OSPI		0x01
+#define BOOT_DEVICE_QSPI		0x02
+#define BOOT_DEVICE_SPI			0x03
+#define BOOT_DEVICE_UART		0x07
+#define BOOT_DEVICE_MMC			0x08
+#define BOOT_DEVICE_EMMC		0x09
+#define BOOT_DEVICE_USB			0x0A
+#define BOOT_DEVICE_DFU			0x0A
+#define BOOT_DEVICE_GPMC_NAND		0x0B
+#define BOOT_DEVICE_XSPI_FAST		0x0D
+#define BOOT_DEVICE_XSPI		0x0E
+#define BOOT_DEVICE_NOBOOT		0x0F
+
+/* U-Boot used aliases */
+#define BOOT_DEVICE_MMC2		BOOT_DEVICE_MMC
+#define BOOT_DEVICE_MMC1		BOOT_DEVICE_EMMC
+/* Invalid Choices for the AM62Lx */
+#define BOOT_DEVICE_MMC2_2		0x1F
+#define BOOT_DEVICE_ETHERNET		0x1F
+
+/* Backup BootMode devices */
+#define BACKUP_BOOT_DEVICE_USB		0x01
+#define BACKUP_BOOT_DEVICE_DFU		0x01
+#define BACKUP_BOOT_DEVICE_UART		0x03
+#define BACKUP_BOOT_DEVICE_MMC		0x05
+#define BACKUP_BOOT_DEVICE_SPI		0x06
+
+#define K3_PRIMARY_BOOTMODE		0x0
+
+#endif /* _ASM_ARCH_AM62L_SPL_H_ */
diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index 6b86f6ed12e6..cbf43deaa3fc 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -16,6 +16,10 @@
 #include "am62a_hardware.h"
 #endif
 
+#ifdef CONFIG_SOC_K3_AM62L3
+#include "am62l_hardware.h"
+#endif
+
 #ifdef CONFIG_SOC_K3_AM62P5
 #include "am62p_hardware.h"
 #endif
diff --git a/arch/arm/mach-k3/include/mach/spl.h b/arch/arm/mach-k3/include/mach/spl.h
index a47441ae6a59..ff0b5d41b9f1 100644
--- a/arch/arm/mach-k3/include/mach/spl.h
+++ b/arch/arm/mach-k3/include/mach/spl.h
@@ -46,4 +46,8 @@
 #include "j722s_spl.h"
 #endif
 
+#ifdef CONFIG_SOC_K3_AM62L3
+#include "am62l_spl.h"
+#endif
+
 #endif /* _ASM_ARCH_SPL_H_ */
diff --git a/include/configs/am62l3_evm.h b/include/configs/am62l3_evm.h
new file mode 100644
index 000000000000..181d450daf10
--- /dev/null
+++ b/include/configs/am62l3_evm.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Configuration header file for K3 AM62L SoC family
+ *
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ */
+
+#ifndef __CONFIG_AM62L3_EVM_H
+#define __CONFIG_AM62L3_EVM_H
+
+#include <configs/ti_armv7_common.h>
+
+#endif /* __CONFIG_AM62L3_EVM_H */

-- 
2.54.0

