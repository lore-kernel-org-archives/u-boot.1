Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94711C44514
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 10:43:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 394A384DE0;
	Fri, 17 Jul 2026 12:43:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Fo9YoSRy";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RzELgNJ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EA1C84DF8; Fri, 17 Jul 2026 12:43:18 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47D2F84DDE
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 12:43:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HAQfAS2235614; Fri, 17 Jul 2026 05:43:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=Di2kmZPm1NEsy7+kZn1echLNVsiW/p0rvn7OGNswr
 48=; b=Fo9YoSRyJgbhVLmwnhWANCqBDdtZzKvDQfkAWNG+ZhMI15Ffqk6+y8viQ
 hP0L0yNR9c84JyXHQVQMksITib8NX5hkYJhQ8mtyapLipM3UqjETQLi8HI5iqx6V
 j4GUfoLnAgCslyem9R8kBsGrEfFWuV+E2lJ0duwXgnJ6PmlLWsT8D4FNlPcBIpT/
 fHyvOkzfo0lGKzLxLSAFeBDERx1l5MNUQS1dUaMvD6NHGKCOjbfGBdjQGZpjfpGV
 3PLF02v2N7yqQ/ngFXGE8MMHJh3fvyZJzqVw6rEwxZU8xw0S9MHx8bKQM7bjinLC
 BOeqDzjQC7KCc1imt8wKdexrh/qyQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ff1p6wcg7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 05:43:10 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ll7ZxltMb67d7pLgadSqnz1wJIH/t7kQ+/6mOgnsy326tehNO2Rp/XtUJ7rCILZYe8EL32V4BwbozGmeuDHbYRv/iYm8j0e+nuywNl821bHUu8tQterulGRcRWviuMP3hJirEGE+JxBd6VH/urSSNF3kcvC8RQ4Ng0fE3A5+c4nNgwf5bqrGkUt6n+FFaeODGETKGGyexK1nDDzTmfARbJCCjdcKY+TIsN7aBaD6XR4By63K/ln59K5mK8uKhFuQfGm6VZBGQaZ6iNNCh62NLpxiQbbQ3HRfLJ1xPcemnPjFvBWT9GaavtXUi+Nfx/537PaCB3GtCdwF6NwIaxM8qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Di2kmZPm1NEsy7+kZn1echLNVsiW/p0rvn7OGNswr48=;
 b=bsBzHk+mXaa4VvezIMHC0FroB281CcU8yfgeDRT/CWaNh+ArevIc22Tn2W8oDYKhWr7/CNYhWEu9fXVsRm2RO8TPrM/0UKTWwAYbCF7DljtnvyEvhFKf+3rsA2t2CuHXPKhtiOu+BBS7pGgAJP2Y5SmED744DyqXL3qpCf3WsT3Es/RAEF0cE9fH6M4mzk8vkOm9h1ePkEUFyNBpwwRqOayT0R0pCRx/TU6AXsYq94rVxwDidllgWQczypk2HqNrrTT3hR4sjQbNvIdVeCBoqURBJiVs72FGVqyoWLTpiZjS2sud4CZaYU+4mSclUFM4p7WNbkL80kkJpFVAmM4pGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Di2kmZPm1NEsy7+kZn1echLNVsiW/p0rvn7OGNswr48=;
 b=RzELgNJ55qqNwdhnnZeAps+lGeflevHgh6zZ1M4k+nom/OqlZKl3b6bip55XXEnvsSKQVE61/LyndY+cGeTdeyCWJG6rKhq3p4kSIgRGg0PCtLl4e6KUqNmxM5TqmjHHXGdNzNY6hjAUfH4XxB/0Qa+uYRCoN2b4rPS7iyLZiS0=
Received: from PH7P220CA0143.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::25)
 by BLAPR10MB5124.namprd10.prod.outlook.com (2603:10b6:208:325::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Fri, 17 Jul
 2026 10:43:04 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:510:327:cafe::33) by PH7P220CA0143.outlook.office365.com
 (2603:10b6:510:327::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 10:43:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 10:43:03 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 05:43:03 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 05:43:00 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 05:43:00 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HAgx9c3617372;
 Fri, 17 Jul 2026 05:42:59 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Fri, 17 Jul 2026 16:12:52 +0530
Subject: [PATCH 1/2] arm: dts: k3-am625: add template for tiboot3.bin
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260717-k3_binman_refactor-v1-1-4089220b4fd4@ti.com>
References: <20260717-k3_binman_refactor-v1-0-4089220b4fd4@ti.com>
In-Reply-To: <20260717-k3_binman_refactor-v1-0-4089220b4fd4@ti.com>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Nishanth Menon <nm@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Wadim Egorov <w.egorov@phytec.de>, "Francesco
 Dolcini" <francesco.dolcini@toradex.com>, Aristo Chen
 <aristo.chen@canonical.com>, Suhaas Joshi <s-joshi@ti.com>, Bryan Brattlof
 <bb@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Ernest Van Hoecke
 <ernest.vanhoecke@toradex.com>, Sparsh Kumar <sparsh-kumar@ti.com>, "Anshul
 Dalal" <anshuld@ti.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784284977; l=19341;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=kBOfkPLwj7nujAE37WGbjnvXBUyIOCTmAwMankroxOY=;
 b=SyQjhRvFGxLkljd69laF310mfweTHLu/EcXlWcoxzzwNPnQJgbgfSI7GyP0sj6ZwVQ+kUUKn0
 LSmZ5RAP37fAUqEYR4VNNa7BVNJjcvHTL6sZu1aV5bX+w7q1KidGlX9
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|BLAPR10MB5124:EE_
X-MS-Office365-Filtering-Correlation-Id: 19f559e2-4382-44d0-2700-08dee3f02e2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|22082099003|13003099007|10067099003|3023799007|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: sq0xTbQRprgNkzWZBJQKdAPPfDMVqTFaFU8cJJrtqfV2/ppSlGfo0wGqAiUbk0ZisUnqT8Bl6TIYtxPrI+LLho+Y3xIxrMV5ztNjrszxEzR3xoxxI04J1ipIPyAJcmdlU2siFG5dvd/+0i+ou+hNJF12X+6ZI1xPK9ETOjH6VvDMO8qzIAmM/cTi3VUcHrSmtXuvDBI0h7xoP32FJecOPqPEh1TZc0oer4koDlLVAftdKx3jPxjEF0oZLxxQpZsKiOCgm00txhCnaFkPf+F3+ie6EMdl7txao2d5O5G3OCJDU37RhHT2pB7iKThUNYswXCKRE5BpNwhgQtSVMPkqRky5Er03A8O6j/R6N/pLYco5VO3BGdITELWjGQ0fgVmcrc6okv34bXx+/4wBjgGXjPR1Zw9l0sW8kL/INU/nroigtsKbl44dORqlrAby24rYSFmnrcWYTx1Dv7AwXcIW281X563MjY0gaPpoUXxBKlihlcgXguhYkBtdUGnjOxYOYITPIDjzyS7mUBtrnLdfHMXD0P+UA9T2ZjqfCvHfKKcYIcXhMG3Xiv0RzLmGWqyVV6h491wxktQxBIyy2XZR7okPvAwGjtCzwbjOPseaekBSwCVKzf2NnVOBU5Jwu9RyJWcu3anYG44K+QLz3unMlw==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(22082099003)(13003099007)(10067099003)(3023799007)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 08jM89Pf6Pm31pp5kD0ViBwzGyZqERzV45a9JsdbLm3NYAL15A75uAqbHuQH1wokA3R3iscz54Cwq3rgsxEguUPz/LYD4DtA5FZ74p8CzaqUz3uAqAHlnOjE7lRLIEYCO0Zzs28IXomV7ryCj6vB4bOrU8U9BW0UUCRzb7k4hhKQPtUpRH16FbBYMiYTIAcNN9QhMOXM7mc2jMk1uLilrclNTKl1G0EHabctdIEB8VNgsXSLL5/95gNZjDqQeQWcOamxkFhrfWMI9ToSQQ5LQPpdxiFfBb4sYrlFoUU9ATzZ/5os291FrJj1CI2ke0HgRE6TYr+VvGcQNFm5Osi1Q+vlj4n3A9qwff9w/FsS51PTaV7LV0n9h2PIuOCTKJyd3ikiBGENSFjxiHhCboPQHJUF8uTpelmrsWuJxV2utyHVpV/3eLw/pBe9RGKPSQ8I
X-Exchange-RoutingPolicyChecked: UT1E4cC8G34xdMpIEIgWGBuXGHQ3sEuVxYaG9zta1re7wbX0wTcZ4hiYHfgqRPG6Zelya5Ooyr0Iwlyacgjj83uThdD2yQTU07HLFjMgIO/FtZ67437FiTLcj/USPpO1dvB/y2S601nDVydac6ZZfanODd5u3ELfGgmBxZTShACsvgnSy+3oFm4etzlfTJ9BpI/Wv7h3Srd6Co3jV8VmBh9hKtbtZYB6XqCjZ4JvTCgckUDP23Q8ZFwekMF18//wYs44kNHohPBl6ERlQhXIG68/mL709cJQ3ncosrn5ZT7E1h2l8Vk7RLNnfaGWGJOe4Yf7QGoh9g9Z7fmXxnl66g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 10:43:03.8668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f559e2-4382-44d0-2700-08dee3f02e2d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5124
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEwNyBTYWx0ZWRfX37Nld9WNHh4U
 gqGv8AdpBzzPU9Vl+cpADrmh/qhtX2crb1WHlmFZ65VUzjO+bLa7WMM/qvULn4cmFSGzOy3ISA8
 SKyskS9s6fvONL/H+M6OzWw0pRh6Oz1ixNG09Ps1FYnFGQDq3uRrqSwizCVqcisvIkdd1R/p1k0
 aGs+3AcKOxjKm0HaA6aQHYjJT3jBLBNUijEcK7yQMvC28zAoheqNcjsEa5R1+YT0CrX2doeQyiS
 ullbcYl/6tpj4IpUF4/cgqvCFmN6kQqzyMUhBkLu/lKVYmVvsjKniaCnlTakYHt3pbpOqfkFTFI
 wOa6+hfYFm/IBejQwir2RbT/+AfV76CsQQ7EiO2B1A8XV0/Ei3wuosV14BAqGydCaS4y/eDXMpO
 6dTeMs5dfbE5d1Eb7R30/MRxsKzfLtZHavoHw2P3xz+ezHF2/NLkKy/ywHquHoN1alkJXGkbC3w
 E9RtS0W5QeOBuCUl+Lw==
X-Proofpoint-ORIG-GUID: paM0Re6QPDAuZ4VRejJH9q-d5wkshhd7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEwNyBTYWx0ZWRfX+ZYpoNLjY5h3
 e1j49Ve4/jzqWfJFsN/LCNd33XkU0tcpQlvYW05gJlGOYz4Tb/uiRBEacfX5wclPWHudZeXKmji
 fHjIqayT8w7q4DqeDHKLRfc1wC3xCv4=
X-Authority-Analysis: v=2.4 cv=IOoyzAvG c=1 sm=1 tr=0 ts=6a5a073e cx=c_pps
 a=nW48Ug7pZPQFPw+wtOhQwg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8
 a=fGhLjsSNAAAA:8 a=WPIBqCUo9H82EmqKrd4A:9 a=QEXdDO2ut3YA:10
 a=LYKFdyShAPKLkGq8p7WX:22
X-Proofpoint-GUID: paM0Re6QPDAuZ4VRejJH9q-d5wkshhd7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170107
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

Currently we are duplicating binman nodes responsible for building
tiboot3.bin binaries across boards that use TI's AM625 SoC.

This patch adds a SoC level k3-am625-binman.dtsi with templates for the
commonly used tiboot3 variants (i.e hs, hs-fs and gp) which can be
inserted by the corresponding board's dtsi to promote reuse.

No functional change is intended from this patch.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi      |   2 +-
 arch/arm/dts/k3-am625-binman.dtsi                 | 123 ++++++++++++++++++++++
 arch/arm/dts/k3-am625-phycore-som-binman.dtsi     | 116 +-------------------
 arch/arm/dts/k3-am625-r5-beagleplay.dts           |  33 +-----
 arch/arm/dts/k3-am625-sk-binman.dtsi              | 117 +-------------------
 arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi | 116 +-------------------
 6 files changed, 137 insertions(+), 370 deletions(-)

diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
index 2a4f0e453652..78d69499314e 100644
--- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
@@ -6,7 +6,7 @@
  * Copyright (C) 2022-2023 Robert Nelson, BeagleBoard.org Foundation
  */
 
-#include "k3-binman.dtsi"
+#include "k3-am625-binman.dtsi"
 
 / {
 	/* Keep the LEDs on by default to indicate life */
diff --git a/arch/arm/dts/k3-am625-binman.dtsi b/arch/arm/dts/k3-am625-binman.dtsi
new file mode 100644
index 000000000000..bb0af78d220a
--- /dev/null
+++ b/arch/arm/dts/k3-am625-binman.dtsi
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include "k3-binman.dtsi"
+
+&binman {
+	tiboot3_am625_hs_template: template-tiboot3-hs {
+		ti-secure-rom {
+			content = <&u_boot_spl>, <&ti_fs_enc>, <&combined_tifs_cfg>,
+				  <&combined_dm_cfg>, <&sysfw_inner_cert>;
+			combined;
+			dm-data;
+			sysfw-inner-cert;
+			keyfile = "custMpk.pem";
+			sw-rev = <1>;
+			content-sbl = <&u_boot_spl>;
+			content-sysfw = <&ti_fs_enc>;
+			content-sysfw-data = <&combined_tifs_cfg>;
+			content-sysfw-inner-cert = <&sysfw_inner_cert>;
+			content-dm-data = <&combined_dm_cfg>;
+			load = <CONFIG_SPL_TEXT_BASE>;
+			load-sysfw = <0x40000>;
+			load-sysfw-data = <0x67000>;
+			load-dm-data = <0x43c3a800>;
+		};
+		u_boot_spl: u-boot-spl {
+			no-expanded;
+		};
+		ti_fs_enc: ti-fs-enc.bin {
+			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-enc.bin";
+			type = "blob-ext";
+		};
+		combined_tifs_cfg: combined-tifs-cfg.bin {
+			filename = "combined-tifs-cfg.bin";
+			type = "blob-ext";
+		};
+		sysfw_inner_cert: sysfw-inner-cert {
+			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-cert.bin";
+			type = "blob-ext";
+		};
+		combined_dm_cfg: combined-dm-cfg.bin {
+			filename = "combined-dm-cfg.bin";
+			type = "blob-ext";
+		};
+	};
+
+	tiboot3_am625_hs_fs_template: template-tiboot3-hs-fs {
+		symlink = "tiboot3.bin";
+		ti-secure-rom {
+			content = <&u_boot_spl_fs>, <&ti_fs_enc_fs>, <&combined_tifs_cfg_fs>,
+				  <&combined_dm_cfg_fs>, <&sysfw_inner_cert_fs>;
+			combined;
+			dm-data;
+			sysfw-inner-cert;
+			keyfile = "custMpk.pem";
+			sw-rev = <1>;
+			content-sbl = <&u_boot_spl_fs>;
+			content-sysfw = <&ti_fs_enc_fs>;
+			content-sysfw-data = <&combined_tifs_cfg_fs>;
+			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
+			content-dm-data = <&combined_dm_cfg_fs>;
+			load = <CONFIG_SPL_TEXT_BASE>;
+			load-sysfw = <0x40000>;
+			load-sysfw-data = <0x67000>;
+			load-dm-data = <0x43c3a800>;
+		};
+		u_boot_spl_fs: u-boot-spl {
+			no-expanded;
+		};
+		ti_fs_enc_fs: ti-fs-enc.bin {
+			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-enc.bin";
+			type = "blob-ext";
+		};
+		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
+			filename = "combined-tifs-cfg.bin";
+			type = "blob-ext";
+		};
+		sysfw_inner_cert_fs: sysfw-inner-cert {
+			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-cert.bin";
+			type = "blob-ext";
+		};
+		combined_dm_cfg_fs: combined-dm-cfg.bin {
+			filename = "combined-dm-cfg.bin";
+			type = "blob-ext";
+		};
+	};
+
+	tiboot3_am625_gp_template: template-tiboot3-gp {
+		ti-secure-rom {
+			content = <&u_boot_spl_unsigned>, <&ti_fs_gp>,
+				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
+			combined;
+			dm-data;
+			content-sbl = <&u_boot_spl_unsigned>;
+			load = <CONFIG_SPL_TEXT_BASE>;
+			content-sysfw = <&ti_fs_gp>;
+			load-sysfw = <0x40000>;
+			content-sysfw-data = <&combined_tifs_cfg_gp>;
+			load-sysfw-data = <0x67000>;
+			content-dm-data = <&combined_dm_cfg_gp>;
+			load-dm-data = <0x43c3a800>;
+			sw-rev = <1>;
+			keyfile = "ti-degenerate-key.pem";
+		};
+		u_boot_spl_unsigned: u-boot-spl {
+			no-expanded;
+		};
+		ti_fs_gp: ti-fs-gp.bin {
+			filename = "ti-sysfw/ti-fs-firmware-am62x-gp.bin";
+			type = "blob-ext";
+		};
+		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
+			filename = "combined-tifs-cfg.bin";
+			type = "blob-ext";
+		};
+		combined_dm_cfg_gp: combined-dm-cfg-gp.bin {
+			filename = "combined-dm-cfg.bin";
+			type = "blob-ext";
+		};
+	};
+};
diff --git a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
index 6d57a5d9ffa8..d09bdf29a95d 100644
--- a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
@@ -6,7 +6,7 @@
  * Author: Wadim Egorov <w.egorov@phytec.de>
  */
 
-#include "k3-binman.dtsi"
+#include "k3-am625-binman.dtsi"
 
 #ifdef CONFIG_TARGET_PHYCORE_AM62X_R5
 
@@ -17,124 +17,16 @@
 &binman {
 	tiboot3-am62x-hs-phycore-som.bin {
 		filename = "tiboot3-am62x-hs-phycore-som.bin";
-		ti-secure-rom {
-			content = <&u_boot_spl>, <&ti_fs_enc>, <&combined_tifs_cfg>,
-				<&combined_dm_cfg>, <&sysfw_inner_cert>;
-			combined;
-			dm-data;
-			sysfw-inner-cert;
-			keyfile = "custMpk.pem";
-			sw-rev = <1>;
-			content-sbl = <&u_boot_spl>;
-			content-sysfw = <&ti_fs_enc>;
-			content-sysfw-data = <&combined_tifs_cfg>;
-			content-sysfw-inner-cert = <&sysfw_inner_cert>;
-			content-dm-data = <&combined_dm_cfg>;
-			load = <CONFIG_SPL_TEXT_BASE>;
-			load-sysfw = <0x40000>;
-			load-sysfw-data = <0x67000>;
-			load-dm-data = <0x43c3a800>;
-		};
-		u_boot_spl: u-boot-spl {
-			no-expanded;
-		};
-		ti_fs_enc: ti-fs-enc.bin {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-enc.bin";
-			type = "blob-ext";
-		};
-		combined_tifs_cfg: combined-tifs-cfg.bin {
-			filename = "combined-tifs-cfg.bin";
-			type = "blob-ext";
-		};
-		sysfw_inner_cert: sysfw-inner-cert {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-cert.bin";
-			type = "blob-ext";
-		};
-		combined_dm_cfg: combined-dm-cfg.bin {
-			filename = "combined-dm-cfg.bin";
-			type = "blob-ext";
-		};
+		insert-template = <&tiboot3_am625_hs_template>;
 	};
-};
-
-&binman {
 	tiboot3-am62x-hs-fs-phycore-som.bin {
 		filename = "tiboot3-am62x-hs-fs-phycore-som.bin";
 		symlink = "tiboot3.bin";
-		ti-secure-rom {
-			content = <&u_boot_spl_fs>, <&ti_fs_enc_fs>, <&combined_tifs_cfg_fs>,
-				<&combined_dm_cfg_fs>, <&sysfw_inner_cert_fs>;
-			combined;
-			dm-data;
-			sysfw-inner-cert;
-			keyfile = "custMpk.pem";
-			sw-rev = <1>;
-			content-sbl = <&u_boot_spl_fs>;
-			content-sysfw = <&ti_fs_enc_fs>;
-			content-sysfw-data = <&combined_tifs_cfg_fs>;
-			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
-			content-dm-data = <&combined_dm_cfg_fs>;
-			load = <CONFIG_SPL_TEXT_BASE>;
-			load-sysfw = <0x40000>;
-			load-sysfw-data = <0x67000>;
-			load-dm-data = <0x43c3a800>;
-		};
-		u_boot_spl_fs: u-boot-spl {
-			no-expanded;
-		};
-		ti_fs_enc_fs: ti-fs-enc.bin {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-enc.bin";
-			type = "blob-ext";
-		};
-		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
-			filename = "combined-tifs-cfg.bin";
-			type = "blob-ext";
-		};
-		sysfw_inner_cert_fs: sysfw-inner-cert {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-cert.bin";
-			type = "blob-ext";
-		};
-		combined_dm_cfg_fs: combined-dm-cfg.bin {
-			filename = "combined-dm-cfg.bin";
-			type = "blob-ext";
-		};
+		insert-template = <&tiboot3_am625_hs_fs_template>;
 	};
-};
-
-&binman {
 	tiboot3-am62x-gp-phycore-som.bin {
 		filename = "tiboot3-am62x-gp-phycore-som.bin";
-		ti-secure-rom {
-			content = <&u_boot_spl_unsigned>, <&ti_fs_gp>,
-				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
-			combined;
-			dm-data;
-			content-sbl = <&u_boot_spl_unsigned>;
-			load = <CONFIG_SPL_TEXT_BASE>;
-			content-sysfw = <&ti_fs_gp>;
-			load-sysfw = <0x40000>;
-			content-sysfw-data = <&combined_tifs_cfg_gp>;
-			load-sysfw-data = <0x67000>;
-			content-dm-data = <&combined_dm_cfg_gp>;
-			load-dm-data = <0x43c3a800>;
-			sw-rev = <1>;
-			keyfile = "ti-degenerate-key.pem";
-		};
-		u_boot_spl_unsigned: u-boot-spl {
-			no-expanded;
-		};
-		ti_fs_gp: ti-fs-gp.bin {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-gp.bin";
-			type = "blob-ext";
-		};
-		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
-			filename = "combined-tifs-cfg.bin";
-			type = "blob-ext";
-		};
-		combined_dm_cfg_gp: combined-dm-cfg-gp.bin {
-			filename = "combined-dm-cfg.bin";
-			type = "blob-ext";
-		};
+		insert-template = <&tiboot3_am625_gp_template>;
 	};
 };
 
diff --git a/arch/arm/dts/k3-am625-r5-beagleplay.dts b/arch/arm/dts/k3-am625-r5-beagleplay.dts
index fb0b83b83f1b..0e8c74c0291d 100644
--- a/arch/arm/dts/k3-am625-r5-beagleplay.dts
+++ b/arch/arm/dts/k3-am625-r5-beagleplay.dts
@@ -33,38 +33,7 @@
 	tiboot3-am62x-gp-evm.bin {
 		filename = "tiboot3-am62x-gp-evm.bin";
 		symlink = "tiboot3.bin";
-		ti-secure-rom {
-			content = <&u_boot_spl_unsigned>, <&ti_fs_gp>,
-				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
-			combined;
-			dm-data;
-			content-sbl = <&u_boot_spl_unsigned>;
-			load = <0x43c00000>;
-			content-sysfw = <&ti_fs_gp>;
-			load-sysfw = <0x40000>;
-			content-sysfw-data = <&combined_tifs_cfg_gp>;
-			load-sysfw-data = <0x67000>;
-			content-dm-data = <&combined_dm_cfg_gp>;
-			load-dm-data = <0x43c3a800>;
-			sw-rev = <1>;
-			keyfile = "ti-degenerate-key.pem";
-		};
-		u_boot_spl_unsigned: u-boot-spl {
-			no-expanded;
-		};
-		ti_fs_gp: ti-fs-gp.bin {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-gp.bin";
-			type = "blob-ext";
-		};
-		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
-			filename = "combined-tifs-cfg.bin";
-			type = "blob-ext";
-		};
-		combined_dm_cfg_gp: combined-dm-cfg-gp.bin {
-			filename = "combined-dm-cfg.bin";
-			type = "blob-ext";
-		};
-
+		insert-template = <&tiboot3_am625_gp_template>;
 	};
 };
 
diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
index 1717621a8500..9ac0c36f8645 100644
--- a/arch/arm/dts/k3-am625-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
@@ -3,7 +3,7 @@
  * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
  */
 
-#include "k3-binman.dtsi"
+#include "k3-am625-binman.dtsi"
 
 #ifdef CONFIG_TARGET_AM625_R5_EVM
 
@@ -14,125 +14,16 @@
 &binman {
 	tiboot3-am62x-hs-evm.bin {
 		filename = "tiboot3-am62x-hs-evm.bin";
-		ti-secure-rom {
-			content = <&u_boot_spl>, <&ti_fs_enc>, <&combined_tifs_cfg>,
-				<&combined_dm_cfg>, <&sysfw_inner_cert>;
-			combined;
-			dm-data;
-			sysfw-inner-cert;
-			keyfile = "custMpk.pem";
-			sw-rev = <1>;
-			content-sbl = <&u_boot_spl>;
-			content-sysfw = <&ti_fs_enc>;
-			content-sysfw-data = <&combined_tifs_cfg>;
-			content-sysfw-inner-cert = <&sysfw_inner_cert>;
-			content-dm-data = <&combined_dm_cfg>;
-			load = <CONFIG_SPL_TEXT_BASE>;
-			load-sysfw = <0x40000>;
-			load-sysfw-data = <0x67000>;
-			load-dm-data = <0x43c3a800>;
-		};
-		u_boot_spl: u-boot-spl {
-			no-expanded;
-		};
-		ti_fs_enc: ti-fs-enc.bin {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-enc.bin";
-			type = "blob-ext";
-		};
-		combined_tifs_cfg: combined-tifs-cfg.bin {
-			filename = "combined-tifs-cfg.bin";
-			type = "blob-ext";
-		};
-		sysfw_inner_cert: sysfw-inner-cert {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-cert.bin";
-			type = "blob-ext";
-		};
-		combined_dm_cfg: combined-dm-cfg.bin {
-			filename = "combined-dm-cfg.bin";
-			type = "blob-ext";
-		};
+		insert-template = <&tiboot3_am625_hs_template>;
 	};
-};
-
-&binman {
 	tiboot3-am62x-hs-fs-evm.bin {
 		filename = "tiboot3-am62x-hs-fs-evm.bin";
 		symlink = "tiboot3.bin";
-		ti-secure-rom {
-			content = <&u_boot_spl_fs>, <&ti_fs_enc_fs>, <&combined_tifs_cfg_fs>,
-				<&combined_dm_cfg_fs>, <&sysfw_inner_cert_fs>;
-			combined;
-			dm-data;
-			sysfw-inner-cert;
-			keyfile = "custMpk.pem";
-			sw-rev = <1>;
-			content-sbl = <&u_boot_spl_fs>;
-			content-sysfw = <&ti_fs_enc_fs>;
-			content-sysfw-data = <&combined_tifs_cfg_fs>;
-			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
-			content-dm-data = <&combined_dm_cfg_fs>;
-			load = <CONFIG_SPL_TEXT_BASE>;
-			load-sysfw = <0x40000>;
-			load-sysfw-data = <0x67000>;
-			load-dm-data = <0x43c3a800>;
-		};
-		u_boot_spl_fs: u-boot-spl {
-			no-expanded;
-		};
-		ti_fs_enc_fs: ti-fs-enc.bin {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-enc.bin";
-			type = "blob-ext";
-		};
-		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
-			filename = "combined-tifs-cfg.bin";
-			type = "blob-ext";
-		};
-		sysfw_inner_cert_fs: sysfw-inner-cert {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-cert.bin";
-			type = "blob-ext";
-		};
-		combined_dm_cfg_fs: combined-dm-cfg.bin {
-			filename = "combined-dm-cfg.bin";
-			type = "blob-ext";
-		};
+		insert-template = <&tiboot3_am625_hs_fs_template>;
 	};
-};
-
-&binman {
 	tiboot3-am62x-gp-evm.bin {
 		filename = "tiboot3-am62x-gp-evm.bin";
-		ti-secure-rom {
-			content = <&u_boot_spl_unsigned>, <&ti_fs_gp>,
-				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
-			combined;
-			dm-data;
-			content-sbl = <&u_boot_spl_unsigned>;
-			load = <CONFIG_SPL_TEXT_BASE>;
-			content-sysfw = <&ti_fs_gp>;
-			load-sysfw = <0x40000>;
-			content-sysfw-data = <&combined_tifs_cfg_gp>;
-			load-sysfw-data = <0x67000>;
-			content-dm-data = <&combined_dm_cfg_gp>;
-			load-dm-data = <0x43c3a800>;
-			sw-rev = <1>;
-			keyfile = "ti-degenerate-key.pem";
-		};
-		u_boot_spl_unsigned: u-boot-spl {
-			no-expanded;
-		};
-		ti_fs_gp: ti-fs-gp.bin {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-gp.bin";
-			type = "blob-ext";
-		};
-		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
-			filename = "combined-tifs-cfg.bin";
-			type = "blob-ext";
-		};
-		combined_dm_cfg_gp: combined-dm-cfg-gp.bin {
-			filename = "combined-dm-cfg.bin";
-			type = "blob-ext";
-		};
-
+		insert-template = <&tiboot3_am625_gp_template>;
 	};
 };
 
diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
index 35b7f8b256e9..c57780d876d6 100644
--- a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
+++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
@@ -3,7 +3,7 @@
  * Copyright 2023 Toradex
  */
 
-#include "k3-binman.dtsi"
+#include "k3-am625-binman.dtsi"
 
 #ifdef CONFIG_TARGET_VERDIN_AM62_R5
 
@@ -14,124 +14,16 @@
 &binman {
 	tiboot3-am62x-hs-verdin.bin {
 		filename = "tiboot3-am62x-hs-verdin.bin";
-		ti-secure-rom {
-			content = <&u_boot_spl>, <&ti_fs_enc>, <&combined_tifs_cfg>,
-				<&combined_dm_cfg>, <&sysfw_inner_cert>;
-			combined;
-			dm-data;
-			sysfw-inner-cert;
-			keyfile = "custMpk.pem";
-			sw-rev = <1>;
-			content-sbl = <&u_boot_spl>;
-			content-sysfw = <&ti_fs_enc>;
-			content-sysfw-data = <&combined_tifs_cfg>;
-			content-sysfw-inner-cert = <&sysfw_inner_cert>;
-			content-dm-data = <&combined_dm_cfg>;
-			load = <CONFIG_SPL_TEXT_BASE>;
-			load-sysfw = <0x40000>;
-			load-sysfw-data = <0x67000>;
-			load-dm-data = <0x43c3a800>;
-		};
-		u_boot_spl: u-boot-spl {
-			no-expanded;
-		};
-		ti_fs_enc: ti-fs-enc.bin {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-enc.bin";
-			type = "blob-ext";
-		};
-		combined_tifs_cfg: combined-tifs-cfg.bin {
-			filename = "combined-tifs-cfg.bin";
-			type = "blob-ext";
-		};
-		sysfw_inner_cert: sysfw-inner-cert {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-cert.bin";
-			type = "blob-ext";
-		};
-		combined_dm_cfg: combined-dm-cfg.bin {
-			filename = "combined-dm-cfg.bin";
-			type = "blob-ext";
-		};
+		insert-template = <&tiboot3_am625_hs_template>;
 	};
-};
-
-&binman {
 	tiboot3-am62x-hs-fs-verdin.bin {
 		filename = "tiboot3-am62x-hs-fs-verdin.bin";
 		symlink = "tiboot3.bin";
-		ti-secure-rom {
-			content = <&u_boot_spl_fs>, <&ti_fs_enc_fs>, <&combined_tifs_cfg_fs>,
-				<&combined_dm_cfg_fs>, <&sysfw_inner_cert_fs>;
-			combined;
-			dm-data;
-			sysfw-inner-cert;
-			keyfile = "custMpk.pem";
-			sw-rev = <1>;
-			content-sbl = <&u_boot_spl_fs>;
-			content-sysfw = <&ti_fs_enc_fs>;
-			content-sysfw-data = <&combined_tifs_cfg_fs>;
-			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
-			content-dm-data = <&combined_dm_cfg_fs>;
-			load = <CONFIG_SPL_TEXT_BASE>;
-			load-sysfw = <0x40000>;
-			load-sysfw-data = <0x67000>;
-			load-dm-data = <0x43c3a800>;
-		};
-		u_boot_spl_fs: u-boot-spl {
-			no-expanded;
-		};
-		ti_fs_enc_fs: ti-fs-enc.bin {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-enc.bin";
-			type = "blob-ext";
-		};
-		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
-			filename = "combined-tifs-cfg.bin";
-			type = "blob-ext";
-		};
-		sysfw_inner_cert_fs: sysfw-inner-cert {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-cert.bin";
-			type = "blob-ext";
-		};
-		combined_dm_cfg_fs: combined-dm-cfg.bin {
-			filename = "combined-dm-cfg.bin";
-			type = "blob-ext";
-		};
+		insert-template = <&tiboot3_am625_hs_fs_template>;
 	};
-};
-
-&binman {
 	tiboot3-am62x-gp-verdin.bin {
 		filename = "tiboot3-am62x-gp-verdin.bin";
-		ti-secure-rom {
-			content = <&u_boot_spl_unsigned>, <&ti_fs_gp>,
-				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
-			combined;
-			dm-data;
-			content-sbl = <&u_boot_spl_unsigned>;
-			load = <CONFIG_SPL_TEXT_BASE>;
-			content-sysfw = <&ti_fs_gp>;
-			load-sysfw = <0x40000>;
-			content-sysfw-data = <&combined_tifs_cfg_gp>;
-			load-sysfw-data = <0x67000>;
-			content-dm-data = <&combined_dm_cfg_gp>;
-			load-dm-data = <0x43c3a800>;
-			sw-rev = <1>;
-			keyfile = "ti-degenerate-key.pem";
-		};
-		u_boot_spl_unsigned: u-boot-spl {
-			no-expanded;
-		};
-		ti_fs_gp: ti-fs-gp.bin {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-gp.bin";
-			type = "blob-ext";
-		};
-		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
-			filename = "combined-tifs-cfg.bin";
-			type = "blob-ext";
-		};
-		combined_dm_cfg_gp: combined-dm-cfg-gp.bin {
-			filename = "combined-dm-cfg.bin";
-			type = "blob-ext";
-		};
+		insert-template = <&tiboot3_am625_gp_template>;
 	};
 };
 

-- 
2.55.0

