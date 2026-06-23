Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72A8CDB470
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 07:29:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19E88849CE;
	Tue, 23 Jun 2026 09:29:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ney7O4np";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="A3lJsKeR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBC73849D1; Tue, 23 Jun 2026 09:29:42 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F4D7849C5
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 09:29:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65N6coDh787018;
 Tue, 23 Jun 2026 02:29:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=7PH2RFeaZgYYzelEI81hdMT5gKosaZB1z1ldNH6Q0
 hY=; b=Ney7O4np1gGs8L35H0ZSA/hKLzF+zctxsk4LIWXAilDL8wYJAUXqsndvz
 MPEIVXUapv+JuoFI5ERurwdhrjOFQ1IWRlz7MT5Z6DlcDK44L7c+w+JfGndQiDNM
 Hgpi3DarqBTWiDuW5QeX3w8gI5UuGnY+0elKeuESZ4Y0CDUwsoSUr9K9ebXTIKkf
 yrqbG23TpvFq+NDJv9SWoTdXQ/gFqDwmgNoX3ppwPfJGo6awPnKIrZh1Hta3y7fy
 R/W9K83GUPO9FznhNWDyx2PkPWZf/fb8nTzd5vx78T62SKQxj4Qz+7oOjLIBJ8HU
 0U8h5MLDRxh0zBWM3mlacZtZtZZHA==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010000.outbound.protection.outlook.com
 [40.93.198.0])
 by m0380145.ppops.net (PPS) with ESMTPS id 4eyma1rg2n-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 02:29:27 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EC0fAx7ouCtnr5yoktNDI3xRjI4DlPh7Dw0wsLuOu/ps5qfMTqbB7HeFgwtnCOgWVVMmE3rz7AkD/caTqY+y+7Sc0pvNLw4/HVOlZsUdW7qb+5v7AJ01Gyfi05s+CDXbD5Hh/w+WhH9Np2lvhf5fF9e2JnCUtDclCYgbHusfnjU294klRa6xrLVSPzxH8gFEKbsw8udjl2GG2exAhytCw6MQcfa0dhZBQqPhI5bwGfHO5Bu9dxEzXACSDiZV+tj9Ejw/Bp3sZGd6Hp4PV10XJXSt5k6lg7NP8xtQMp71pMYRBwbbOxLEBYNZvATOYOsBv3Foebkb79fvXc6l0aAmww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PH2RFeaZgYYzelEI81hdMT5gKosaZB1z1ldNH6Q0hY=;
 b=lwWSOlaRwr5OOzY5MF7hkNnym+z7W6tpQEnwyDzLQI1z5yHOEtF6PPmOsEb+d77jDZP6JbeRhymGo0wgRR3MUN/gtieHkOJyWX2/v37Gs/NP/bry784+jnPfbmffvpBbfWUbQWuZ1HpCm1UJ6bifWuVwZiKmQ8RUq6OYAUeOykUOS87EWHGc/ERTHMdPdxdrOVl+NptHt0NoSWoac+UVieGABmwFUH14cd6QZbXn6z64qX3X9nDdhDJ5+STeXbsg67AsoHR5OZH8jwheQMR1dKyTQ3rIgPvBp2/vJgBqwvzADd3MPiQTV0zLeAD2eQVSNaTCCwy1uM4NLnkR73LHtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PH2RFeaZgYYzelEI81hdMT5gKosaZB1z1ldNH6Q0hY=;
 b=A3lJsKeRS5JSQxmqQlig1fuFXyduQTYjjo7Jhqcf5ct+OREE13O7cFQt998rfb750DcGdkoWfQtHi+01aI0Z1ny/vHekM66Uw/1ispelJ72qOobNAIhc9cCMHenjkLwUGBFHgxqhr9Q4GCfGETDg3FhP2ymZJoT2/YweFAVQrUc=
Received: from CH5PR03CA0011.namprd03.prod.outlook.com (2603:10b6:610:1f1::23)
 by PH7PR10MB6377.namprd10.prod.outlook.com (2603:10b6:510:1a7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 07:29:25 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::2a) by CH5PR03CA0011.outlook.office365.com
 (2603:10b6:610:1f1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Tue,
 23 Jun 2026 07:29:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 07:29:24 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 23 Jun
 2026 02:29:13 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 23 Jun
 2026 02:29:13 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 23 Jun 2026 02:29:13 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65N7TChV1752565;
 Tue, 23 Jun 2026 02:29:13 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 23 Jun 2026 12:59:12 +0530
Message-ID: <DJG933DITHOO.G8ER04I2UPWX@ti.com>
From: Anshul Dalal <anshuld@ti.com>
To: Aristo Chen <aristo.chen@canonical.com>, Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, "Neha Malcom
 Francis" <n-francis@ti.com>, Sparsh Kumar <sparsh-kumar@ti.com>, "Suhaas
 Joshi" <s-joshi@ti.com>, Andrew Davis <afd@ti.com>, Paresh Bhagat
 <p-bhagat@ti.com>, Dhruva Gole <d-gole@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Beleswar Padhi <b-padhi@ti.com>, Moteen Shah
 <m-shah@ti.com>, Chintan Vankar <c-vankar@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Udit Kumar <u-kumar1@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Sam Protsenko <semen.protsenko@linaro.org>, "Vishal
 Mahaveer" <vishalm@ti.com>, Peng Fan <peng.fan@nxp.com>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Andreas Dannenberg <dannenberg@ti.com>,
 "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH v1 1/4] arm: k3: select tifsstub via
 board_fit_config_name_match
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260528132746.719699-1-aristo.chen@canonical.com>
 <20260528132746.719699-2-aristo.chen@canonical.com>
 <178219548553.1317404.18395162615291306038.b4-review@b4>
 <CAA=k7=k2Xunx4pGujZTfK9kQmtFkDdJG0o29BkNxHdSbA=uguw@mail.gmail.com>
In-Reply-To: <CAA=k7=k2Xunx4pGujZTfK9kQmtFkDdJG0o29BkNxHdSbA=uguw@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|PH7PR10MB6377:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a66f8ad-0c82-4972-bc1b-08ded0f926b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|7416014|23010399003|36860700016|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: x3zvnycYjWFZB1kvybjoSAy3pAMsUyVAzipg3g8HSdelD+H939wF0Df2JFq9NyjuTNLj89Zwgbvssug/TqqWBAf48xHUcJrOiAi1OSGKnEbE/SGmdd74fYp5Ljc8gxk8/SPb571FWYaTVqsF8kbcyOir298pgMrrgh+Xj3Modmkv4XcdhOACzG04JKHwiGjTec3JLPjLEwWKMxQDJ29+47JoIJcesZs/O61IxDWp4FacgG5HZNZnAhDBE/q36UjfeBtd8VBFVJEheh3wAGA4MhDtZuQOXI2JyYP2eJsOvf+qM533mYNLEYmBMWBmkPlrNkubY3F3KXcgFnXKdMUnyTvrIR0biBspS/JuWKpzTyY1G1ZgE/IUoQAN5aK0bEG3UTUx44VNGoG8HnZ49gYN72Z0snMxRrcc7luyVxiU2euHYFlp7noRp66m/hZHHqJs93z5a7VnX81ooLx7f1cUYgF8whurPl6DoQQFdWYmhaHnM1CCj83xH6UaqiWl2dNbHE1RkVdQOSph1BluVaQzuWk43aAUslQbJ9L1PuttugNN3baVGckTrRvBztb/qC8dUbJCpswx+S7/lpQWfWGZ7sdLxszW/LFD1aiq108N4qVdX5bRR71E9OExLoQl0WVn+O6UojPc5zH7QgbzYnEdPlCFRreMkSAoVpRTX1UYqg4fYYKLukfGmszAkJUHXrnWbiDt7fI98d7Myb1GiNMdZA==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(23010399003)(36860700016)(18002099003)(22082099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6co8j+eaO7t93Rfdy7PlKTJn1f+eSzVcMX7BRTLtuIwaRgKhnQsUnd+9WzbXpXxbc1+tf/faKMrlvlXoQlHbrh8tT+bYie9gF9G0A1hSeC2WXrXqssGHakbMe7sFdFhTYLSw6D1p2umlm2t8eYBaPR7mlEX+X6Fny8sw8OBO2M+ViVBdAvf4DnvU6pFMJUqui5LXZjpBUvwtiZEp/wgTwlLU1fGNhNYpn2S9lwj9jPui6vX3Gs1zN9kuUaiJ5Da7PQ+mOTS0X4DSmV8UFP2oPmeV37zyQoXu/hRVjQ/BmqpFnXZLYnn3MXds325GmRlPSpk5ohJnu9MtXewMkvdw7bCLl9KYMzTQzLZjbpH5xOpQSKwNGqp+urQLSd8F3iz9IqbvWNIrfg2kd9VUEeEsPTzpZsnMfXTVRXpjRwZxt90cv0unnbz1f2RCcj3IS72R
X-Exchange-RoutingPolicyChecked: Ux26fJ987F0JPCCRCvOipM5B/9EnPwrrgkVRxOhkCYQoUD95Cv2chjF2ocKpNQpXIMj9ebmeSEEOy6Bv2FFC08i98LCkjevYqkaJe/8EwSWUgNkTd2FWUa0V7nyzAE15+XWjECDnfoLHhQfU9tuy4qYAyEfq8xa01VsOmdV4h454AQLV+hRvcOdyzGKV+MvIWf3VpjJbtFSqPaIAMqjZO6KMgUDAWkqJmy7ztKxJl/klq/T/gqlBud1rXhSwSqKv6T2lkp0YUW+OFuAYObCk2dqcklnaywAy4jUA1etOnd5xGfvmyHrw0yvMcCQRfjC8tj/lG7ziJMRFB2DT919x0w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 07:29:24.6892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a66f8ad-0c82-4972-bc1b-08ded0f926b1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6377
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA1OSBTYWx0ZWRfX7zkhISwvAuVA
 kgMlhuQzxyOSVsh+imASCQm0oVOd/1UXYx5S4PjhCfsYN3uOrwLrkDRTzsfGXXWHldGWqU5XgOx
 JMDipTXXuhQSLu2q3K/QYjD9yOblwfc=
X-Proofpoint-ORIG-GUID: MIZ2T2jnfMC5PI9UpbNIgFI9Wmg0vrXT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA1OSBTYWx0ZWRfX5IBdh82WeCln
 bz0Z06pCnuriwPjSqZ2c/Me/4EG3SPAM3yRNKXnc54Phx5wonwvBy+ZJRrfQSlFwwV0kGrNDOuS
 U4Sru8YNdo9zgcpr3XFv7loVJXTUN8BPI3jvlncWntG3fpFoSgIsqzLE6CTs6hvx3mVJ/VK8JJN
 QgtKKHN7i83NFs8zspRHZ0jqH/Lohews5IMZTrG2RzfL1iHKs/tB/PlrIai4Y7Dkirdsni65yRF
 n2V5CidQokEQ53dZ7JolfitoJCDWXJRMe7wEUNxa+GsYrnwTBy8En4AEiPl+Mz5LFxMpV1097Cc
 2qzG4GSHlVoDIiJ8MW9BzNRnlhA/UdndyG0y7WvoD8mqi+yyfkj40hxPBpfSnqSyisEXiUzFluP
 UbgJJYyUb6UKKXTuD+J+jHOusuifaqmsRxQwg0jMWgVvbV5XbdzYWVjNmiLnXJ+FeEa0CyBqHOa
 fm1esd+nZ2ZWSiY+4Tw==
X-Proofpoint-GUID: MIZ2T2jnfMC5PI9UpbNIgFI9Wmg0vrXT
X-Authority-Analysis: v=2.4 cv=WoYb99fv c=1 sm=1 tr=0 ts=6a3a35d7 cx=c_pps
 a=1KNXh0H2uH8UbroYoe6UKA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8
 a=EIf2IwQ_LD8tCyo1VOQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230059
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

On Tue Jun 23, 2026 at 12:31 PM IST, Aristo Chen wrote:
> On Tue, Jun 23, 2026 at 2:18=E2=80=AFPM Anshul Dalal <anshuld@ti.com> wro=
te:

[snip]

>> > diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
>> > index 466ad22f895..37ff98d8992 100644
>> > --- a/arch/arm/mach-k3/common.h
>> > +++ b/arch/arm/mach-k3/common.h
>> > @@ -55,7 +46,6 @@ const struct k3_speed_grade_map *k3_get_speed_grade_=
map(void);
>> >  void k3_fix_rproc_clock(const char *path);
>> >  void mmr_unlock(uintptr_t base, u32 partition);
>> >  bool is_rom_loaded_sysfw(struct rom_extended_boot_data *data);
>> > -enum k3_device_type get_device_type(void);
>>
>> Why the move of this function from common.h to hardware.h? This header s=
hould be
>> accessible to all of K3 anyways.
>
> If I understand correctly, arch/arm/mach-k3/common.h is currently
> mach-k3-internal. It is not in the include search path for board
> files; it is pulled in by .c files inside mach-k3/ via relative
> includes (#include "common.h" or #include "../common.h").
>
> Board files like board/ti/am62x/evm.c include the K3 SoC header via
> <asm/arch/hardware.h>, which maps to
> arch/arm/mach-k3/include/mach/hardware.h. They have no direct path to
> arch/arm/mach-k3/common.h today.
>
> For the board_fit_config_name_match() wrappers in this patch to call
> get_device_type(), the declaration needs to live somewhere boards can
> reach. The two options I considered were:
>
>   1. Move enum k3_device_type and get_device_type() to hardware.h
> (what this patch does). Touches two files.
>
>   2. Relocate common.h into arch/arm/mach-k3/include/mach/ to make it
> public, then update every relative include inside mach-k3/. Touches
> every mach-k3/ source file.
>
> I went with (1) as the smaller change. Happy to revisit if you would
> prefer (2), but it felt out of scope for this series.
>

I can take a jab at refactoring things at a later point. But for the
time being, what you have done with option #1 is alright.
