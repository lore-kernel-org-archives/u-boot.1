Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DC8C4451B
	for <u-boot@archiver.kernel.org>; Sat, 18 Jul 2026 15:03:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F413C8467B;
	Sat, 18 Jul 2026 17:03:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dvZi43jU";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="u1un39zN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C64984659; Sat, 18 Jul 2026 01:23:59 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AD3780398
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 01:23:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66HNFusW3762712;
 Fri, 17 Jul 2026 18:23:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=fN4expUUvJf4ylKWnBNl47oXVtZ5ih1PlMOd2a8nu
 64=; b=dvZi43jUstpfx/G7O/MB/XMcvngXeK4+SQH9Qo3JKpHBY2mRP/wCkXLDD
 lX2F0xP3XnPJYAUFKtY1vUVnIdf0X8Cl+CR5fV3UdNMiW2uu+fNXXkT6OKz+q8EC
 6ZDvhXD6FI9Medm0A+rRtYkUz2tNKmlqJj4rL8bmR70WNGult3xgllM8lkAXJPtX
 qoB2J3XNsc2Aax4p8xjkTwYsoSSR6Fxo81SCMVZY2GOIPkr62ENUGwAzXepKFk4O
 LixkcYUL7MEp/iDO6uhYvBq/OoKWrgbCnRvk/A49RWzls/FN27Rjlfn400PqPPXX
 FMn9sxYJB+zZBLPQc8lGn+I48+LQQ==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010051.outbound.protection.outlook.com [52.101.46.51])
 by m0380145.ppops.net (PPS) with ESMTPS id 4ffks33ttc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 18:23:38 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQ3w0968d6gxy6ou9Y9xbzugUA3yiM6gBIP6A23Uo//uoGh6sKbUoNq2+efKFV67D38/mToWbw79ArFChSCnBfVWRq5jIIgkieY5Q0Cryke2hhjv9XXYQgtjOX4s9nJB0zjEnRtbFT6M20DaS+N/fR2lC+QEmnZhAhtpNRZ7UuHif4GqN0QLudCv71hh3UES3pU7o9zQhUVgc3GLFQneGfNuldeksldXCYCDNIyVyGahZVGI6ytUzvvOfIkxysGT4sls53ZJkD0kAqJQF2FjRmd2koJO6Acudb1rj36mnyw1NboWQ9dibaSAWBY1byxxX7O6tG7wGg4LBN2pHXehwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fN4expUUvJf4ylKWnBNl47oXVtZ5ih1PlMOd2a8nu64=;
 b=b49nSE8Oou5YDnMzqAe3LmAd8nrBlQOvJP03qwJ0XPxcl/LuoEI/31DFTpDn4KHsx0UI9vCFrd1IrEbschyFqq8YP/Oed1SIGWHXybmEw8aPDmmyqlV+yy5CpMiPuUodjW7rWRWMw5AXv52eQQ/zf746MTWcA0u29N7BgaUmnymKm8v2aYg99SQkg2x7I1GY8BuEvtMmn/rTmD0Y380qyIY7vSauqlw/p5m5sgCuN/kqoG2uj7/R+zmpj+J5sgiyWNkbEUVdX9IPsdsHgagog+VR4/ao/Tfe96kJPKh3+vmPL6wUw+/dFx5B/tQyIlQJWeHXna74b5iOd+ySHdtbRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fN4expUUvJf4ylKWnBNl47oXVtZ5ih1PlMOd2a8nu64=;
 b=u1un39zNTEm+x3NxTHvttmnl7IJ4ZaoTQkvg9oDqlUyJew59MyWQLaoWBAMYoLMDUvwUYjqGROgXQIkrWUEt1YBqSv9IYSqBG+nVrQSfoyPtC+P5mfCCdxCzi6dF88JR0NpDVkRZ6bOLvL5YZ9nWDiVAznoIO2gYF9+ZSSrHuAw=
Received: from SN7PR04CA0204.namprd04.prod.outlook.com (2603:10b6:806:126::29)
 by PH7PR10MB5853.namprd10.prod.outlook.com (2603:10b6:510:126::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Fri, 17 Jul
 2026 23:23:34 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:126:cafe::3) by SN7PR04CA0204.outlook.office365.com
 (2603:10b6:806:126::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 23:23:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 23:23:33 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 18:23:33 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 18:23:33 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 18:23:33 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HNNXHq745730;
 Fri, 17 Jul 2026 18:23:33 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Fri, 17 Jul 2026 18:23:31 -0500
Subject: [PATCH 01/11] firmware: scmi: switch to dev_ofnode during bind
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260717-am62lx-v1-1-b9830633afb8@ti.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|PH7PR10MB5853:EE_
X-MS-Office365-Filtering-Correlation-Id: 463d35c4-406b-4475-cf66-08dee45a6bd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|82310400026|36860700016|10067099003|3023799007|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /87yuvX9UhTBcNuntVZMXkUEdPp8GohdwKP/tj5zKvoYqlfweCEqiy+eKGsuJC582l6bNs/IxHuzwzTwu8gqH5c8YMHG6NiJ5TN2RQeiCi+qp2ijVM1ehT7u7lfNPk2OVsvoyA2ykApSn7EzDX+D910vh3FjRvZULaN5q0Bs2w5X13Lp6jS98dEaz4T7or3GG5UDDzI71cQXeBkKCHNB1oK4yYr7Pq9A9VoH+S/VE+zjDL0FcbBBEq5c8cFO8h6QEjRyeoAz45XEK9Xquss4Eo8hO/Sz+er7kZznvZ9XaFsffcuIwsd4D//cQg6hqd2WrFl4juaG/V5GwNlY/++A29XeDVSxACuHAOS08iFUCP5xxmydGVPMFOnfCOzXbN9rqUz6qfHMTLckxmebuW65egF+vHdZ7tpn2WwjAab4xjTGhXQIQPB3I0wgE/siWDiwk/x7iFHqBshTq+WfLGoyaPeEL243ILaGw9ijAGz9HxyM+KUL6sa13YNms5uhRmQr4QDEB2xdL/fAVJwMsh+tehX+2M9hL5r4tsURaCmojF//qoP4chOA60B/XIW9L7BP7v+Yu238eHhLr6OMJVV4SS3gHqMX/AIiCCigvp397sjelO8Oo+MfDWiwd9pfsLPlKDEdoInJoly9vd4lIElNArMfCdZShzwz7drtHsvO/SP5U9/hvAUD5Mm/qAKxHOLeFJkWrrCaXFYkE7YcvdlB+g==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(82310400026)(36860700016)(10067099003)(3023799007)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Irh7W4hOZDJ8XqAHxXbVsR81Zftyc4DDmkPGM7eCKt0bntzt4Ck7dHVWPjASKQmVxqR7KGD0ePB1slf+OY54nRI0AmCf4ylWE+JJlycvFZ1T7UBUSSX/eevNcpZJoF0LTxNOE3lpoJkoPUC7xe35aHvpLFg3qdvSM2P1QyThUtkaLNbON+CmlysgmcJ3sDRgfVIAC+j4TQapl26vn/9fLD12DF0fHatWgV+Pr/UvBub63RyZypCpOTHZuw9v+5f/W0X++X5sWpNbb7nbq1B08t7fQG0aMEN6xx/w8mgYrjUSsBFh0SK9wnBAPE/dgpGLabBkM1/Lw6yEhs2zTlvL5fX7LqztO3XPExvKHtExqB7HHfBTF10JmBG+6+VwLvLpiuNPY36sISaJ6iS5O+LmG39CHGXpn1Nq4llrNYCD4CTDsI8yVnUoKKJ/VE9C6EZ/
X-Exchange-RoutingPolicyChecked: jiz2zqzr8lIxg5wcn99unSH+WvGo7xgEAJXwUaGrKFdmO/AT5K9sx7hGJIFdq10yXyvwcgBWpoEewHckaGaRDeVdr/sdKFpEmbQnhOQD3hZ6YycOJPatg8BHivsQKvIzfubBlJvVxJ0M0kkU3CjShStYMRQ5vYRg/P4PLw+W2uvn9vc684hqrwSOWGzhl0NltIXjYlzIt/k0bL4h4A4nXw0LJQR9pvQWU086TFEjn0R9HB4XIatjL8ZAvwm179uE3lHWO3OcBeqP/lXzLh1/ELBC9ua7kxb+tt0sOPOxn9a+BcgK/4ATpkZut5YwCt+fQYpnojUsAvlcS/x1nQ5CEQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 23:23:33.9530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 463d35c4-406b-4475-cf66-08dee45a6bd0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5853
X-Authority-Analysis: v=2.4 cv=e9Y2j6p/ c=1 sm=1 tr=0 ts=6a5ab97a cx=c_pps
 a=6wX/tLcgNF/HagpTIcwFsg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8
 a=Tbir3cbcft87DSTUyVQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDI0MSBTYWx0ZWRfX+BoLQqBKB2ex
 CYsV4mzR0TW0RHMEoLv6FbcRk60+MvxhJW5qlapkziMMiuscc+608N55pQzNEWbfCGpc1FSnC1J
 z+YdnKsJ8+jSOM58hWq2kMeH/rXquUcPe7L80tOLfmqJ/tPPXgUkd9mkKgR8yFl6zew9pX8nPlO
 Qrp864rx3m3Nh4efTsOzqxgps4bM0iOPzpXU0vjMtBM/jgCIHuqEapWhYwXpJOF9SOUlFuj8f5O
 Uo4t/6JNj/8/u9CL6fO7W9Of7CVq/s4chBc3YBjVAkuaW4HmdFSveEeuSlOSS2dOoCxWNaDFHkl
 0LMyl1Cq2rHjS9v41Mr8+YQSkHoeIujjYN62wxEBrhs6T7Pc0Uf5FQ+7Ot60P69vYzktss7dKwU
 0IjuqXjPdmjcaJygYrEL0/aqgBS3dI3gb6qoSt91RhVgR7ddIOOCLbHzvy3aP24XsU+Hyz/gnKs
 KEYhkEdl43hz8n8sbiQ==
X-Proofpoint-GUID: j46sCKuq4eoKcipDmEGqmHUV9ftwqbtY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDI0MSBTYWx0ZWRfX3Vcz7QXr3m7K
 Ii3b9+pdLYccwgZM9YtSR6dXstLxIv91wFlJTn4JCJ+w84iuhnfj9tIMXH5k3Fgms84diu23vAk
 ulAqmUtGTGSzxww4iq9jGcy4t0IQ5JM=
X-Proofpoint-ORIG-GUID: j46sCKuq4eoKcipDmEGqmHUV9ftwqbtY
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

From: Anshul Dalal <anshuld@ti.com>

When using ofnode_null() the node offset passed to the FDT API will be
-1 which is invalid and breaks probe. Switch to dev_ofnode()

Signed-off-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 drivers/firmware/scmi/scmi_agent-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index cd458a7f4588..65c1ddad2b57 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -437,7 +437,7 @@ static int scmi_bind_protocols(struct udevice *dev)
 	/* initialize the device from device tree */
 	drv = DM_DRIVER_GET(scmi_base_drv);
 	name = "scmi-base.0";
-	ret = device_bind(dev, drv, name, NULL, ofnode_null(), &proto);
+	ret = device_bind(dev, drv, name, NULL, dev_ofnode(dev), &proto);
 	if (ret) {
 		dev_err(dev, "failed to bind base protocol\n");
 		return ret;

-- 
2.54.0

