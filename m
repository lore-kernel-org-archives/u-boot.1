Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC7EC4451C
	for <u-boot@archiver.kernel.org>; Sat, 18 Jul 2026 15:04:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A56B084A29;
	Sat, 18 Jul 2026 17:03:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UwiWcX2I";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OqIJdxoL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D945838D7; Sat, 18 Jul 2026 01:24:02 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D62A380398
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 01:23:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66HNFtLt3762709;
 Fri, 17 Jul 2026 18:23:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=h4ipBvwzuZHWqSAeFooCFUEmQQC3sztniZjrsObyq
 YQ=; b=UwiWcX2Ik7sM7xZf0D2Uf/5w2wb0P9WnCjno2a6tCnqJV8/o0LGkG0bzZ
 pUN3wbXRCZs39X6hs+9H5lrtNOY9SJGHevg2LcnJSLevnGInLhUVud4eKHEd2dao
 fgPZDLF02XzmfXRzQKYHVprn/XjtUlsBI4D1o9S9yCYWN+6F4hYrruGP7Pa1jlKV
 9DjOm4A/RXRfVoRX0dTuK5Ar7Tyn9caWfEO6Mu5LyBiuo03ePmVnyjd65a0nm6yj
 KxC2pYUlrvA1ReZqBlfAHPC0pXtAuxjgjLAkHOKovS334itKJzOjb7AvSfz0oK5j
 Yw4tZr062NdcQioVkURIsgMR88Mmw==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010057.outbound.protection.outlook.com [52.101.61.57])
 by m0380145.ppops.net (PPS) with ESMTPS id 4ffks33ttd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 18:23:38 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQxafm7jYwNSV/z/qL3x3T9Xjl3IA8pfGg2sRqG+dSVMdVkx+8inwhtcefWzy2F3RY4orsbNd5znDgh01/7dI+Mdu8f2UswIbJVreGu0lJBAWip+x7qLTS0Jj1GTlny4Du5MdDXYS2jN1FXSciobRfHFjzinuYQJ1J2WWLQJTRm6F8sgV9nmTSoUCGYZDPNfE2eLh3HTVANxW+mXAv/Fe17e25jeH11ffI9vf/veny8pIcWA3incBlZiunH2POJ/XNLfYP1sMJsoHQI9yJ5z7wuk3qePXU46t+K6z5KYR4YLa284CfGhfi7sB2plqZTIU+whgDJkEwY4i+DDSM+dlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4ipBvwzuZHWqSAeFooCFUEmQQC3sztniZjrsObyqYQ=;
 b=UUOeaSRkOtbHDb+J3xdG3m4TXTl+VnELAvDp0TyQnwMj3yF8EbRi+u3VriBFxcD/BcwdcqD6L0wM50rWX3qhGIjqpsda55ZlLZBGwQTd99NmXF2F5a6HajOLO92fhTX/H7JhqN3ydeYiBNrXkYe/DSxGdQUNNiB1XYJdPsXTIolEYUogo7nTgCJHXxZeTG1fiJapD2+qVcEBf5lLWCIqQZQ8k2xs3edQdETgXgfY4ldOw73VChQHiRY8Hv5mUlLvUWy7bt0HJAQcJ1faId+k6DLYTyaJAFFsGnpPy00Py4yIepnAUQnCSUeRrdI0tbHBUDdCtNH+Kf+9O9V4OWzT3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4ipBvwzuZHWqSAeFooCFUEmQQC3sztniZjrsObyqYQ=;
 b=OqIJdxoL1/aILdAdUQPkfV8rQopu/h27t1N+RAGaZW8lN2ikhPb1Qm4x18Wkh74yrlxokbcyWC3jn5WNK4wHN1qFOsJRk+B2plQC+7C6yfWBaY0p5Dw1vCGtoUTJX+rxzZDdpESzNPtUqDmsp8alLyejG+K7do40SQMURFkpj/4=
Received: from MN0PR04CA0007.namprd04.prod.outlook.com (2603:10b6:208:52d::12)
 by CH3PR10MB7744.namprd10.prod.outlook.com (2603:10b6:610:1ba::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Fri, 17 Jul
 2026 23:23:34 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:52d:cafe::89) by MN0PR04CA0007.outlook.office365.com
 (2603:10b6:208:52d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 23:23:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 23:23:34 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 18:23:33 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 18:23:33 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 18:23:34 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HNNXFo745776;
 Fri, 17 Jul 2026 18:23:33 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Fri, 17 Jul 2026 18:23:34 -0500
Subject: [PATCH 04/11] boot/Kconfig: disable fit post processing for AM62L
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260717-am62lx-v1-4-b9830633afb8@ti.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|CH3PR10MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: 040cfdeb-3e35-4ab9-3982-08dee45a6c1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|7416014|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: hN7DUmrc47cCmncIfA9zmlsF0gR8t05Dit1KPX2yxG/Zwa5Z1se6rWlTKGQH2cNJsOFx1Mbe8B5SRlWs70p6J7AqpzZ3Ncjl4lFjN96UQwRaVv+E848SRcz4/kS19rjIor9t9G8Ppar3aICL6JhihCyoDCUcQTS5Vt+Y6xzbm9gPo/ueYbqAYC9K9LX+VWmVT0aXpNDMKt2PwFwrqqKGyuPAuC1lMNYj9oLD0UyIuV4gZWKwWWXK5EkY/no7/a2O3Y0mF5Q63hGUedyUmZd+jgksa1gzWprYPmcafyOsgIE2G6BPdxeyO3HjzgIR7Uq/2O7mP1DNvBUREHz+ogP6HNZBaePMW7daVC5VK7e9N2vklLDTFj8DgvPTg2LfSTIO1K5Fwz9s9qOqa/4qnUKYORq/BWx3t6kll2SiHX1bhcgycjbbKUWlRLtjx5ZGDSXFGvRlF0pVGgsJ19z1xK52r2kQQ9Gcr6L94EQx8HRSLakYXz0BI/6BbQexKt5ZpTtVPbtoTJjRycX5l5H5TGTx+uP5okNlH7mjnWpM9+A2BiMEH0EmKdg0sZJtEcBbnsMrsBjDwn866K5J84a2J8LqtSZzCfCtQj0CM2WsDlSUFjppFVls86+7YurclBax7jlG3gpfbcwN+jW4W2poB8Jbgfjwwu34jM8nwlI3wrLv/L42TdDcRo1qbN5MxgHSSHYUB9sjMEghb7wPSOVxX4P4hw==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(7416014)(18002099003)(22082099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CYwRdTT4VRqgJNBryScGI7n5gUuYdGvV1v9raIc12oxbRvblIinUbgtS8h925YbzeuzG+5LpTm9FyaUvVk9KRyk2mJUIV7eU44wjheKoMpBn93hDLNvnt6n99R5891SlO4lIK4JNOcgWXx25SL68SOtFRyjv1J9Qfd9/hblEdqF1cAsZ1tyhEd8zjDHF5uCOuPmaErOxDYxjXEbZtEI85OFW0gkRaz7si7YfhJFOdyG3geeP4PW9ekvoFbHBSGLygyXpBistnlHfMP4byEOzuBjiueLXXDBzHEe6Zj/J7NvPsl6PDyIVUUAM1WSIxIaJKBB3bcoo6agbQfUi+uqa6ViM22xgXuu2ZTOlxTPzDpBuA2qf8ppBEAZC0EonbZgjvlP+urESrbNexhCBXujewqY1xBQ3TP5tXotZmAQn6a8T8C/0YDisiTVqeLJ2P2Ky
X-Exchange-RoutingPolicyChecked: okXF6A0gCHoELzfX3XUnSgnIaSpHtHgaxyL2cNZhqxtwZSSL5NgQr8WUit+nqT1XIvzFhNSVCx1dqeB0LplC5SmXxuHN1F2FtefLr7RFrt+AUanRmB2LWZorqOJMQBgBFLNSbsnUEEkSzyE7cu8CAXwCbkAm9BpM0WGQf++Nix0iPxyVGNWn1NtT2ueE2ELfyR6HEsjuA2WziL31ztuMdrjrRlLgf/ChdlsomqnKQdRRIO8u/kWKk6wZkQiVn7caCdHpB6dQFdhniT2TERvXv3hX0VQkf+p9nb5ZlfUYD/QJL+y2FFxnDZIWY5Ls7DOuzTB51Igj5VKWAdG+Gb8pHg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 23:23:34.4030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 040cfdeb-3e35-4ab9-3982-08dee45a6c1d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7744
X-Authority-Analysis: v=2.4 cv=e9Y2j6p/ c=1 sm=1 tr=0 ts=6a5ab97a cx=c_pps
 a=b4Rf/daEBCJdqA7qdazqbw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8
 a=22Z8trJi2V0NGen_QEsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDI0MSBTYWx0ZWRfXyovcPuM8DsAg
 LOgeOYx4xIL6YyTFYF2YAT/BGGU7xIPdPdCIKRnO2K9OQl5FUPUmN3pdcVzkeP2yxVRbv+YkPeZ
 MpvGSuN/scxoEeE0m50kPq8ObpVA5MgbI20kHr4WZYztUXK+xozjzIzBUw++fSUk1QngIw3CNJW
 CIZU1EpXE3XcSCb5K1fSmG/ex7bk8AEW54rDsoxazbn1dapbhxatjyu0L+2AYzfpbsO5Hz0UXCv
 yt47eSYQ28jXV3Fgjx0DpbiItZTTzZSTi7GT6Qlhc/kWNJkdxGVqBP6tKMrxsRThNRwotRB6ADW
 QuKWzUqW0h4KuA9klKscweWgalFge16uPjCk1Rx6Z0vfKYEXMZu+zOno4czTOSiTi7WOUbsJWhQ
 vjqQanz6FhGW/KJH1RSg9ZW7wLs+yqBXnphxwaNbsq+NSbu087Oa8SRoQHSNe1/Wj245HgW+aZS
 yP3zaa3xf9Q0ab4Rulw==
X-Proofpoint-GUID: 5EMhJzoUEvcwMgCXQN_CL6tODJeJVu50
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDI0MSBTYWx0ZWRfX0TAl/Qs9WT0c
 iEA/ablUw07nhpD284jyqAGPn4q6zNsh11JeSoddGHjtg1yFvqX0rCD3SIuQdvc48/mBiROt/70
 ZWDajTwRDJYehqqwVaV7jOTsj91WWKQ=
X-Proofpoint-ORIG-GUID: 5EMhJzoUEvcwMgCXQN_CL6tODJeJVu50
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 suspectscore=0 phishscore=0
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

The AM62L family of SoCs utilize a 2 stage ROM boot which uses x509
certificates for booting securely. There is no need for processing of a
fitImage. Disable it for the AM62L SoC family.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 boot/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 8e468c561765..585718aeeb84 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -333,7 +333,7 @@ config SPL_LOAD_FIT_FULL
 config SPL_FIT_IMAGE_POST_PROCESS
 	bool "Enable post-processing of FIT artifacts after loading by the SPL"
 	depends on SPL_LOAD_FIT
-	default y if TI_SECURE_DEVICE
+	default y if (TI_SECURE_DEVICE && !SOC_K3_AM62L3)
 	help
 	  Allows doing any sort of manipulation to blobs after they got extracted
 	  from the U-Boot FIT image like stripping off headers or modifying the

-- 
2.54.0

