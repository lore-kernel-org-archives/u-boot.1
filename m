Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C80C4451B
	for <u-boot@archiver.kernel.org>; Sat, 18 Jul 2026 15:04:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6658D84A0B;
	Sat, 18 Jul 2026 17:03:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kDtHxqgU";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ln2mKTN3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFBDD841F2; Sat, 18 Jul 2026 01:24:01 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DD3B84119
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 01:23:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HNGIkK3731461; Fri, 17 Jul 2026 18:23:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=Np7h6dzd5PuDTkQadxjsAmhlmyYZO2dz0o3xkhYkN
 /8=; b=kDtHxqgUztfpXvrPIYlhm1BcZguDlMoUQroSmB+3XPTjeIKf5JNpR9XIf
 d3twT6lNVhp7qzUAfGoFbBpwPcewaI9fZ4sTn9+ikqOxisHZbe5yaTQqTM4ROLX4
 qbjINRSGPndSIAeCoWTVNUS4P0MH9ovghXm2sJOIDYOTN/vKFqyP07X7T889E1Pb
 j1H+TWD1iGt+AnegeM92B5h1YD82wjxMe3PlS94LnyWFMyPOa97uJ/tyRigepd9r
 jZhVIPBjJ4RHENEqS9cqHom56UL5UPV4SYKqbNR/Cewr9KNw2/HzfyB9u7RI4zHH
 wE8Ztvf0Uyg7102p6smmMNSjQHcdg==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ffkc3m34h-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 18:23:45 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATGL/eyB82m7XrMu1nmCpXQNQgAjlroUix5Fxug5q2fgx5KbPDxVYiNAwRb06rJkQre5zjWTOfru4pskBeojj08LvI6ynAqg5RzKKonvk2sOKpiR0J9+5d+KDRN4O1vefLWR48FDSGQWwINIniGB9Wv5hh8HYmF8HxJ0KrWaVpiZJEBKx/GjFSWwGXbdrArfoF213blkGpb0J6JqR+z3IANJGfIXS7Qumb+b8MUZoi0FdOx8eZqY8nvuVZ5MitXdlSlTVgFhQ5rJ0rTBnagcbqsJmwwqVPvTDfuJud+84z4nEU0J/7sUBepMT0sgMWV3xoiTIU7aUospNKkFa7L6RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Np7h6dzd5PuDTkQadxjsAmhlmyYZO2dz0o3xkhYkN/8=;
 b=SzSgoFjhtW6D6Bp73qFEXJmHXtxvLqLeRBI4pdTKYatHy+ANZXET7U9bGScXh7LXRJ31dS2U0QvT8QRH9uUIww5hmVrMoAZ9l74U/MEGWviU+LlHueMWGFFeIsrx70TIN6eFF1MUDkKZaYXbLQ77J5BN+PyTrxQ0MhK8w/GXFbSD/Emcs4ZDINo/xAwgGm1676jg5o90NrQgA0m3CiLomMG5y+lV9weBIJPAsBpg1lDE+m1N/FjQ+bhhBJ21bHqyB1Pf3RenUtZ+0hdRDyXkMXUCI0RttrxJz4Q5691D4VSJCQ3C+BDgXmZY+Jbjclc2t6GUy0WwnNsa6mc97Zcqzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Np7h6dzd5PuDTkQadxjsAmhlmyYZO2dz0o3xkhYkN/8=;
 b=ln2mKTN3YclSf0UjaMEYA8742ks8ofO8kxclIsaXI/DDcU2yztsmOhmynvlTXjT58bgR4ZGm2NprXNfFPfEzPXtajQzdXuBsoWYGPweojNPc/fhZ1vlBIKO8qEfaEcNyOGdw0+4wt0ze4RzYISkzvEFcOoe5969Df6v3cZiz480=
Received: from MN0PR04CA0018.namprd04.prod.outlook.com (2603:10b6:208:52d::11)
 by SJ5PPF871418173.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::7b2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 23:23:40 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:52d:cafe::3f) by MN0PR04CA0018.outlook.office365.com
 (2603:10b6:208:52d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 23:23:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 23:23:35 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 18:23:34 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 18:23:34 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 18:23:34 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HNNYrF150159;
 Fri, 17 Jul 2026 18:23:34 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Fri, 17 Jul 2026 18:23:40 -0500
Subject: [PATCH 10/11] doc: board: ti: correct path to tcl scripts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260717-am62lx-v1-10-b9830633afb8@ti.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|SJ5PPF871418173:EE_
X-MS-Office365-Filtering-Correlation-Id: bbbee542-834e-476d-8dd9-08dee45a6cdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|7416014|23010399003|1800799024|6133799003|10067099003|22082099003|18002099003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info: yXv2CvDqVOE5GXsz3ND/1FjT6VBkPgs02CXRW2J0xsRubU+fsNb+YdwgtFs+yXXkAZWJX1og5DmHXURs5YMSKqPj/BRlUZnxt9e7O6L6ipl5oCE5Ie3zCuvYwDnC0FqEg76CF27LllBf1nGIwD/jGtukGned1vOXB+lgRBBApcRVAcNarf5cjpW5Q/Ok1/uZ4Vg7O/4QntuH+Rd7o/ZjNlreRwGba3gSme8pWQ5XjSwO1FhhnXclx0O7Jupk7ni+h2/rol62ICCdOQIJ0/tJ4d+iaeo+dF7wczRD9ZANmHNLq4S3UogqzY2XHb2lAZ7j3OPsPwloWlt+RO/o2fe4tq1cdlKg7/OcxztnWkcmD2QZjLvjZQmaKF+TnA1pjNxf88DctqV9jLfuGCc3r0he3z+OYanFFjwlDNX73yizOGBzms0QKaaM3ZSxtbwnOdaCpQQe9zjCRL2nT7mxNh3jQucMa+RUxqJXNzOEHSADKXr1E6FTOcfTEme9cCjm4qriAmCSrSwKqmxYYwC0LO3BYsxmc/EGsfL3AME1zGV2ddlxxielYevjXjWTFkkJIg7kWwjboLuJevttitEmVYo0kqh1cT1WC9fA0EX6YsxN05kjwf3Jh2jvGEo8uPanT1eoIBV/cXHqOVCxvFaKS4DhdLmDl03IcLWGvX2gAlwt6PpbwWVIhGOMxjfbnbFP14WDlVtDov7/uXLT6Gu5VetW6g==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(23010399003)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(56012099006)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HiQZ161X9lVpRpvQC7EAdUsx6olA5QJDIsxj+lIOUcON16x2a+gDov1tr7kBQSyvtJ7F1Fm5bfajt4+eusgqHApCPgAiVaPOdWjFnbRWNaT5Ig7QO+2csTYtDYxLqSI2d3GeTEhfi3WZuihaIJNidysmRqWY3Gper049q18lXnJ/eBtClXHVBIsZtpT92QY22A2R5km2SMdI1jS3SVaquwt7/KI5xjgvi69QdPrqlViqE0wzsHYCbaqi5TRKsRDI7QtWxgrdTHFVAtFFAGySBXJQCyT9CGPI/PUaEgqRGFaaD0CxqRA/OoP/Jccd3fk/+yy40jWCVUFNoronGlEbpjYvQCT1l7au63B9oq52zQGr5bTDfx8nK+k9KQAu6lOZRkJFjAK94wZr+zUXDjWefWTaLaptVJ4Sge/TPygmcwTfUcvIo50EQx+uFZQUoG4w
X-Exchange-RoutingPolicyChecked: nD07JsuZ68oXalmVkiYn3u9RgDZxWPQMU6q2EsiDNail6hEOUiU9AWogXAD8WSAwwxl8yonNMhzs3vHQBI8/HHs/MYyj3ogUXtHZan1BtnE9p6VX4yAArf8SCPrgcE+ztVK6sE8EOIPdpelpOHMlrH3IXQVR6YXbCVj3E/7Kfv2BgDr5LtgMiJHNG8xzTnXv1/4XXLafDTKI/d749nLJP5vETd4nSvXhus710sRD6SvpuH2gGC8rwrusXa19fQftQ4zu7lhbfMl0bgR2k5DVlDhnaojObajllvydldhoCTX9tXHYufLywNTNO3aexIhBdoPT+i/JApXE4wb/jtn/Wg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 23:23:35.6595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbbee542-834e-476d-8dd9-08dee45a6cdc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF871418173
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDI0MSBTYWx0ZWRfXx47OKR18t1+t
 a2rUDt2M5Ax0dlfSedPWIavEa14o3OVCWprSuJrLXFxsxUic+gL+xsBkTRRXK1XAhg/ut5rM21Q
 i2MHvttVg7xPW96LtDnxPCQkwnE3h1A=
X-Proofpoint-GUID: mGo5WNsZ4r_YFze5UdUNSL06fKsWADQi
X-Authority-Analysis: v=2.4 cv=M7F97Sws c=1 sm=1 tr=0 ts=6a5ab981 cx=c_pps
 a=fYaSdR3m0whpxnlOBVIaHQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=NEAV23lmAAAA:8
 a=sozttTNsAAAA:8 a=3XqsQiwtXmu4FjQEjo0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: mGo5WNsZ4r_YFze5UdUNSL06fKsWADQi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDI0MSBTYWx0ZWRfX5R3iFnC22hYr
 GH+Iuyhr6b9c3dfH0LmmlMANBWg/YoKMHOI0Bgo2NyfwPfHn78W8Yq8Llf3nkDJEVMr0YWoj8q8
 DDXuR0p1oaEw9zfFM/OUmLrHAaBoNDRKjz3cLmXXPWCPnnaAYhrKrCOht4dyH88Jm9FKxco8hFS
 0jIQZ5sBjwakCSr1Bz8H+KUnpKEtjlTOe2eMwR5sjOXq8w0T+IH7CkQ5eEkPAiFigMKx+x99f2r
 gHUrHBw/q6uRxw/WyDR+QgHAN5fqjCcXhTWmuShjiXCksGzHoLPeb39q51U19z2qqMFJH4v9UhH
 tzuilOjpVePTJuTwsLzZe24gYzB/3OQmTgFfS4vQxSkpm8dh/M/iJ7yHo/6f4JRgRBXPC0OfTYL
 3g9O6vademrJlsis0ldDlbfGQz2B5PdP3aJIO4hhP/CFZDQmqEYgqbNMDfzPdW842DVjDQOdy4s
 tOSQ6O9PLAxL1BSoWig==
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

