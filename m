Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B17CDE009
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 19:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19ADA847C8;
	Thu, 25 Jun 2026 21:32:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BGzI+apb";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="o5hMDZJu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DD9584942; Thu, 25 Jun 2026 21:31:58 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE5588407E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 21:31:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65PHiPtQ3933246; Thu, 25 Jun 2026 14:31:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=1Ft6LENgDpQVIvaEIum+iJZRV4BRFis2oiIMKEI8h
 R0=; b=BGzI+apbZlMAhFciMrly8fksuYEBWh2g3igP/SINucvLfQINHmOjqtgxX
 jxBkESA6idzPdFaKQIplY+lUyuiINuPBMB1o4uMasCbcGNRPuYlNWTCR/2xe4cPM
 Z0OrYT/aWHgWAi8XDESEx34A2yst5BkDgLVkxmrGvdUaZPFx9gThZeloFeCEoiIS
 x6/AgtcOUu+gk5Res+ovaOfoOfhTAY/ieuKo/7ZvvkZYQPppQy/VtfAjM3T/1dB3
 +YJw7iFf4QUhksKrJB6UfzgWH2SXViYYKJ8EkrM159xF0sdd14zrRWLi9692v/w/
 2dke/jWU44CSrnn9hvc1U6FKfvzHw==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010047.outbound.protection.outlook.com [52.101.201.47])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f13a0u2vk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2026 14:31:04 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXT8kyPj61SSakEJ0SAMEfMYQ8aPPRGXAcOOHDwKfx+WA8GuA2zJ+8dx0hFnf3igE39bHz2siwreBhBhmcBKnsaVBS1HeZ+uk49UZPEKO3qdWJsuf5nP6VNHJ7T0FQUX6dnWgI+/8gj6nPiIVxH1/ckjNfzq4oc3XobjaH3D6HznqdO7yVqQZ1MZCKacwbSHoiZpDx6Q1uRwWicvDKU3GB5aQh0prMDteY62osgyLJdKN742Osh/f6rqJFzvXS9TZQCkozIxsPpAg3U/8ou1GBxIwoJIqlbMGKqjkxABwtxWO5F3fJiYE4VCqSOjTYHSP4ZZhEvWrpSz+NHo4YcV9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Ft6LENgDpQVIvaEIum+iJZRV4BRFis2oiIMKEI8hR0=;
 b=uSlctaPmMHXdcZg7CdKKdRIuWvnDsl4j6PaKBqiyGuGchysW6uzu+SQ76XH2kqj5DYDFsa3a+5ye+qvEZYBdyVpdeSguTV2Qy5iHnkXRg6H9FdLmewtPv3alUIoG6/WjPaRbeDGHT5OO9Cgqab3Y8Uj3GkzC7FOiDMf9+pURkqNQoHYr02aYYhLDtp5P81p+qA4WyPpM89gbnx44EKkxEV/qunE0+BBaIyGZyYg/q1GNTQoEJO11k8TJ4MF1n1ERw3GQ+MXbegbpQjYoMb40u65ABasG6KQA51Cf5uuaFY7l3ERp6L9fJI5ndeQHag3UVl0SAk4Co6zj6GD8aHtSww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ft6LENgDpQVIvaEIum+iJZRV4BRFis2oiIMKEI8hR0=;
 b=o5hMDZJudwy7R3GIGu8Az/zLiK4qXg6mSvvfPTDb5emSDi+PyC+WeeNs2lTPnOYdWKut6FyZo953oXlUP5Dim7GOBy8g/sNrK3kdr81IlMqsJua3ypQibyvaxKKuVS6rMatv2QdjeKaWzbud0sszAff5ZzFucu3CNQaGutVaKm8=
Received: from CH2PR07CA0045.namprd07.prod.outlook.com (2603:10b6:610:5b::19)
 by CH3PR10MB6788.namprd10.prod.outlook.com (2603:10b6:610:14b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 25 Jun
 2026 19:31:02 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::36) by CH2PR07CA0045.outlook.office365.com
 (2603:10b6:610:5b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 19:31:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 19:31:00 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 25 Jun
 2026 14:30:58 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 25 Jun
 2026 14:30:58 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 25 Jun 2026 14:30:58 -0500
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65PJUiL33439767;
 Thu, 25 Jun 2026 14:30:45 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] treewide: Kconfig: use bool instead of tristate
From: Neha Malcom Francis <n-francis@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini
 <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Heiko Schocher
 <hs@nabladev.com>, Dinesh <dinesh.maniyam@altera.com>, Peng Fan
 <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, Neha Malcom Francis
 <n-francis@ti.com>, Marek Vasut <marex@denx.de>, Sebastian Reichel
 <sebastian.reichel@collabora.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, Simon Glass
 <sjg@chromium.org>, Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 "Nick Hu" <nick.hu@sifive.com>, Jimmy Ho <jimmy.ho@sifive.com>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peter Korsgaard <peter@korsgaard.com>, Casey Connolly
 <casey.connolly@linaro.org>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, Jonathan Stroud
 <jonathan.stroud@amd.com>, Padmarao Begari <padmarao.begari@amd.com>,
 "Mateus Lima Alves" <mateuslima.ti@gmail.com>, Jamie Gibbons
 <jamie.gibbons@microchip.com>, Daniel Palmer <daniel@thingy.jp>, "Angelo
 Dureghello" <angelo@kernel-space.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Lucien.Jheng <lucienzx159@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Beiyan Yun <root@infi.wang>, Weijie Gao
 <weijie.gao@mediatek.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 "Romain Gantois" <romain.gantois@bootlin.com>,
 Alice Guo <alice.guo@nxp.com>, "Tien
 Fong Chee" <tien.fong.chee@altera.com>, Ralph Siemsen
 <ralph.siemsen@linaro.org>, Boon Khai Ng <boon.khai.ng@altera.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Igor Belwon
 <igor.belwon@mentallysanemainliners.org>,
 Alexey Charkov <alchark@gmail.com>, Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Yegor Yefremov <yegorslists@googlemail.com>
In-Reply-To: <20260625-tristate_fix-v1-1-95e16153d752@ti.com>
References: <20260625-tristate_fix-v1-1-95e16153d752@ti.com>
Date: Fri, 26 Jun 2026 01:00:40 +0530
Message-ID: <178241584091.237007.2298812456813070394.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782415845; l=227;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=ln7EEOsoNPeFixadr9R2GyXP+pxxk9+jLPuzrEzxPMI=;
 b=Y/36Ybupqpxfx/CMghCizOc/JJBOLMCZHFYdlCIRaYMfIAPFeli50nmphTBZls8nt+ZUr7HEk
 idzibCySmSyC9ORIpsDBd+L04yefulNocpBBtJwVhiLWz9HsDuMGMo9
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|CH3PR10MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: 9312cd5b-81c7-479f-2b4f-08ded2f049d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|376014|7416014|36860700016|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: YuEu+eclVvdc1MW9N81kORPout0uxrpdrNRYNMZOQr3JLuHR+B8D9+UGhz+vIhlDIDZvWRGs2ZwpBt8GJq5f+kpCu/G+B0urjEbF4EPgo67bOLlSWnKtgpUBuKfH1KQlpliQ7X6h0d/hbxL0sO0n6uLg0gG1nRDRxwLU4xd6CEaJMJ/V96KizqfL1nwmRU4ySm8ZwKbSCYS/2FYcJ4M7lAB8HvRrDySb355dHaUPmPwMCw17gF3xjD+drA2hBA70GUDcbYeCMHgWHM6trKhOFPqOkBhwOC6f0KeBnbHbjaI/iF9L3MZAIxRrfZ8xYmlZoKWKOF27kYtDA50A83veqG2wqWcPxN6iFRUYR+LPfhRycTdErY6i/MBDxFyMazTsHMJLXVRHyhvgOp6kk0ucN5JENff06NAqtgVPVqZ5p48RF7XXWa5gSRm1u0S9bKv8Ws5k2QASeLZEqU9UwKG0oDndFMVR24ASV5IbYrShQDMH5d7uCi2gb9Bwk3ACdMbDIMI14s33LXM9zGxNXPHOUsXI+Xk0PWPw7seI2BcO0P+uTsf1kGmXRlUfJ/oIvZ5TKEF1JHyG56moNZ6fJ0rU3M3FfyWAN6aWBvvpE+VjjoeEFiAi2jYEg54udcp/378CtjyX6sGlLUorbymyFhT9nV4QCpSrQzpQg9fRddfaeHQvM3Omujx9urXPxTZJtGrvnfSIO/oQ5do0gJJkB6qrIg==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(7416014)(36860700016)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UdfSGT1dsqh9W9cS6Js/Y+m5sNxERP9WUiyzSSHT2KFlgHGkQo6tPdlf3thIHy4vi0Ckz/QzuuwRi/F0isJFRgkzlUkATv6rjDb0Re3+hBLybvmhyh2gC8TfncG0UYRC9eAjorYnc2ZGO6HZUdsZmZEdyiNA253MTBllxHG6sfeP6U0pjrYYr3dx5PGapXoUURGHgmQQg9c2wkOVw25655HORXlYyQkc857LSjqX2V5/Ki8A/zxxmbNsGSnJm6U4Yl/dZDqq7nGJ3T1fS3XpmTXHbxrVV5LQQr0cHseejBJvJYB9tM/I1sWkaFFkBmLBD/ZxMAp3kSCy3MWvgQ9yBuX6JBHkkHmy630J2aQcCBHRbwu+g5HBgyDJth4Yl7AiWeGmL8TSDTZmTdw2qSqi3IAlnukTooO+CeuKqK3fGNGxmjheRNkJ3cG4r6QKUIXD
X-Exchange-RoutingPolicyChecked: PuiC4NhHsBI8JEpkwef5EbdK7pj0kIBGdLyuGvXt8v4WPJ97Lx3dHt/ZXhYqRlY7ZWPRdKxwQKOSghFh9hQTD4qdGcjm0O0TdiXi4CM21wHr3qjpFZFbQ9wmYLIQjWu6AcZxfwAnE+5F2URJ8B3WMol8B+OdgemD6r2xp1olVu1ac6/AVsaffzwLO6OIS4Na/X/aC+U5wFRdmQP6rs6IAzaXI2h+FI2RTB6yY6UAevzq6LH3KRMe/kq+CGvsmrHtu6PPcvZeyGhOm3cnz+bouR+nhnC4gehKXPL0I0dV4cRtOIEqAP9BVQD3S9udd74dY2jA33A5ddGpFbGzyPqC5A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 19:31:00.5167 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9312cd5b-81c7-479f-2b4f-08ded2f049d3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6788
X-Authority-Analysis: v=2.4 cv=WrAb99fv c=1 sm=1 tr=0 ts=6a3d81f8 cx=c_pps
 a=6zE/HbjXcl5L3wBq6eN3xQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=yblAwbMv61PgL-ab2ksA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 0OgQbwQw7Sxt5PpUiMsqYz7ScpIscnKA
X-Proofpoint-GUID: 0OgQbwQw7Sxt5PpUiMsqYz7ScpIscnKA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDE2OCBTYWx0ZWRfXxU8HOTSOxCwn
 zw0b+nDQiME4VNOZhGl+InzDVLQI7/f3rrqi1FNWvdVKgS535RnNu0QPu7kOX7wRRvQL1SVSJaq
 baOgaoo/cQwdAHzzg9e0G7fBZQPi+Uo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDE2OCBTYWx0ZWRfX/oLw5mFuuq0x
 AwsU21uso+B72a+H6/7B9InP55Erui139VCz35yEysfT/lgR9TJxO8OONx1YMdLvxBFCPkES5+B
 N3gXjqZTEZzj1b6yDp5B3yGwc+rZf3E8Bq0xv3v07z7oFD30f7yD2zq57XEu1TnY53QGI7eT0FZ
 52bIbro7i/2YY8rkXcThRTh/6Q33rDuWSZC7vJnicgolqzhq2uOtl0ZizAnAzpTapm2eIX74N4g
 tDu4E3sJbumw1htbTxZvb13fNcSgoVwMT+rvZJZBHOV8eX7hTiHKPvq4WdoInwOnWLh9y2PMN18
 xCRJCR/+LR0lxlVQR/XT0Tr5xnkFZyw3RU7tCELpVfVw1tlTzGyd7XpIDjR6TK/OJ7/D+FRwd8f
 gXD6xccK3mnHXgtt2uXa1648BshujhWy1p6TE844kzyagPK83LPcvBflBN/YSnP6VwIzj2m9CEO
 S/S+7ay1WQ5ZHzna9nQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1011 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250168
X-Mailman-Approved-At: Thu, 25 Jun 2026 21:32:05 +0200
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

On Thu, 25 Jun 2026 08:47:06 +0530, Anshul Dalal <anshuld@ti.com> wrote:
> treewide: Kconfig: use bool instead of tristate

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Neha Malcom Francis <n-francis@ti.com>
