Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CB0C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 14:27:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EE4887DF3;
	Tue, 30 Jan 2024 15:27:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=topic.nl header.i=@topic.nl header.b="ZbUrXWbb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC47B87E11; Tue, 30 Jan 2024 15:27:11 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4E418798B
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 15:27:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mike.looijmans@topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lA/mMBtMGcy4zggepvS5tYWz5gyeVp0qisSb0EVzkGY1iekkkEQvJbkNTl+3o3wQLDfZMzNcCEWlQzT+dj2EfX/3TrMacfEDkkgaaaD+FkFqLYtJlguRq9Rr1M/Sg772dNO0DoSHSi2GcUhvgPRcjCP/u2dB3fwaCP125aJfZ2eRpEA86w/GAAkGwSh5E1Ga0FzgI8wOROXq+cR9LIHyengM5qeWud9wvxrQlRGFzQi7x9EnN9SASNbqQfl4ClPz/vqI/BlJBWn0qzgKrOh6MfcHEEZ2d9txQBbEVMEAsicyHDZjjhcWDPV61Lyew2CHQY4h90xMxY4grsNiLzrS8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufVpOQefsdS6UJBO5XbJKVxdF+pEhYoNaYmH6ynOyIo=;
 b=HRPo11+1SPApKGmzZq8ZEkCc7MQCnxgCb/fA2os9PiB+0dTt1zNA0wbnR3UaGh3vF+hoPbKofJkc+GWuVUcKrfSkff0478z3VDVFVZZNC9ilHbYqyxNWpXdkz8gKF+LOgUoG2h6+SQV7VAVJ1dCDT3zykRQUFUQI6PX+PNBZR+o0MVFbRH/oQQD+e4VpkwnRGc9putjlIT+X6dT+Zr1jeA6q7wQ+ICBulNmJk+wpmv4JKXBS5D6fYs648NrS+BKCFyKQtxzz6yZuJBKc+Ur+ITD9fpbhTQ5+i46FYPhBuWQ5uA3PZNgMNY/hS3552az0McJSa8sR4pNzEt0cUaY7NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufVpOQefsdS6UJBO5XbJKVxdF+pEhYoNaYmH6ynOyIo=;
 b=ZbUrXWbbEiKeuXphppQ4iVHVXpuF4JYl9VI3kj3kot+60QGP0pBEl+poj3djzjNTQFDWcN7Sr/in8y7X7I7EzT/rBbxCIs4jAdbVnDR2o8Gp4sWfDPEdusWPKSU+c8GwocuObzO8RJyE4WZtC9oqfNNl6PTFK4I0M16ohqRJAECiR4l/xFuSrOQIbjkAT53pOx5aoqVK3YOc8EQx9jBI3NUZQXj4OlM7/W9aTdCQSTICDR7PXCgOgoRHrmWy9hdZC7Fo5P5q+rB24s7LwlUdWtOv0s9L90YxotxFEJvSceBstpoz2+NwPRtMlJ6IoIZf6p4z60jQk+UzJlnYsL4lYA==
Received: from AM6PR08CA0042.eurprd08.prod.outlook.com (2603:10a6:20b:c0::30)
 by DB9PR04MB8346.eurprd04.prod.outlook.com (2603:10a6:10:24d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.33; Tue, 30 Jan
 2024 14:27:07 +0000
Received: from AM3PEPF0000A795.eurprd04.prod.outlook.com
 (2603:10a6:20b:c0:cafe::73) by AM6PR08CA0042.outlook.office365.com
 (2603:10a6:20b:c0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32 via Frontend
 Transport; Tue, 30 Jan 2024 14:27:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 AM3PEPF0000A795.mail.protection.outlook.com (10.167.16.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 14:27:06 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (104.47.14.50) by
 westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Tue, 30 Jan 2024 14:27:05 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by PAXPR04MB8206.eurprd04.prod.outlook.com (2603:10a6:102:1cb::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 14:27:02 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd%6]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 14:27:02 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: Tom Rini <trini@konsulko.com>
CC: Mike Looijmans <mike.looijmans@topic.nl>,
 Mathew McBride <matt@traverse.com.au>, Peng Fan <peng.fan@nxp.com>,
 Shenlin Liang <liangshenlin@eswincomputing.com>, u-boot@lists.denx.de
Subject: [PATCH] fsl-layerscape/soc.c: do not destroy bootcmd environment
Date: Tue, 30 Jan 2024 15:26:56 +0100
Message-ID: <20240130142656.200683-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0125.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::30) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS8PR04MB8644:EE_|PAXPR04MB8206:EE_|AM3PEPF0000A795:EE_|DB9PR04MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: 08e32199-e337-431b-1746-08dc219f893d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ClSfkVSBMyhTwY8NSNx9mwpCSutGvJIJXEtmHKIjyadkv1dI9aIV3M6hwZ2xzCchqzF2JoVwFZ+oMRpI1hVu7IB2qiG4xxaodZX64ru2xCP7JRclMRGiYdlYQbzc+AAhos8PAybhkGaV2WY/cSLAMtruYtBAo/VmkMvXobiTisai18kF0DjqaZQla9pvHphszdT13GYsTKqsDjGzKdCHP+h+Pi4GMGMHEfuWGPZCGQLrq3XWGNTgNw55SwEMGxUTrp+6ZYXS/NjnPvlg608tPzX801IKrzU14OJcMoyXcfEQZHtnxj8sTOWXMkLZS6a+zq3FjOTBzCMYf1aaTzQIu/p68GEjRUVFwJ81XEsHrS5KNPUgen5wjTSAI6Ko8aMJggUs0Zby+oHP7Ufs32rmGV31wdSa72dWkS/QuFGTemOYDddW+TkqF8F3TfbQclSwRG/dPz5rMM5v9XEUAE2t3OaB23qNfaEp8tfcF2ZlEffpTsIGsIv2rMDUdFpHM8NB6kRGdKkp2ZIdGcl/oMCS6FZCBQrXgVSZcCekLg6sBZalksxgKZKsYix2wjTPsBUzxMwGqAnmdCm9h0LP6xOtnWVVnI4wm6kmrNE5bWy+FbRJB5GfSTiKyOrW7bwZo5reHaXrDEeDHZpeDsxL98oV4Q==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8PR04MB8644.eurprd04.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(366004)(396003)(39830400003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(26005)(8936002)(4326008)(44832011)(4744005)(2906002)(5660300002)(316002)(86362001)(66556008)(66476007)(54906003)(66946007)(6916009)(8676002)(38350700005)(36756003)(38100700002)(6486002)(52116002)(6506007)(6512007)(6666004)(478600001)(1076003)(2616005)(41300700001)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8206
X-CodeTwo-MessageID: a64bd403-3b9e-4c23-8d90-b7f5c2192a90.20240130142705@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.3f58dbb3-6e3c-43d9-9553-fe60808a43a3@emailsignatures365.codetwo.com>
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF0000A795.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: bfbb47ca-ba31-4180-d1b9-08dc219f86bd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OEpezIk3QVlbovRi7VcjxNzL/2GVJaDqIgrIPxONGVpPut9h+4n38QRsFLtFjQe6Wr8QJvHxfnAsv9w+i0O6/8UHNejcPDhhwlFXnefprDjEwxChx5mRfhftYYqrMnFlYJubFFQTLPgNlqAt6ArOrnQLIdaXcaIFym8zETPILGW5ehf5YzLfLJmZEq0/pYqUeVV85dffPNkBY8DFiXz1h8nfm/5tIn5RZJTUU83CuSTW0H2cGd71XwKEodoqwjgwxOlKAg0qG3mxhGmaE8KjceDFlPPh9QUu/3+2ZelfHObTiE162zj/Ogg7Kh//A/dHx3+IGvw3nY54UI/D2EPDkqIYJM3bYVNH0NkQpZMbBHrjcnppdjtLtcijKhWpF0Z53261H2hpnal2eqnLDp7sNiaUcVcydscslfMBQo9R89CMn1mI9p1zF+V8q68XrGmp9HHZWdOEeZovACgaAxkktCAuHhd7dnJP5rYAd34l6Rmi4i9NgDgst6q5I2tGmrPJ5w0lHu8BHDtWDZf3xMwuNfE3coVVSU3XlNf62qcvIqKwHZK2kjuQFWEJByIyix4juthb5ziM2XVUxfjK5jN3ebhZmlgnjqF8Sbk8bsWKacj+9Bk+Keg8B8JpnUO7qPV1aTEEio3vSc70oEg8/zZyZ+kYe2elyqj6gRQx296AbgEvtQSKFzs1j7PJRcvU911DstYaW5C7YSmOGvWDMCTLbYYzkn37n8yjdwhXkDTu9l0=
X-Forefront-Antispam-Report: CIP:20.93.157.195; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu11-emailsignatures-cloud.codetwo.com;
 PTR:westeu11-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230031)(4636009)(39830400003)(136003)(376002)(346002)(396003)(230922051799003)(82310400011)(64100799003)(1800799012)(451199024)(186009)(36840700001)(46966006)(40480700001)(15974865002)(356005)(86362001)(36756003)(70586007)(2906002)(7636003)(36860700001)(4326008)(7596003)(26005)(336012)(1076003)(47076005)(2616005)(6916009)(6512007)(6506007)(41300700001)(478600001)(6486002)(6666004)(70206006)(316002)(8936002)(54906003)(5660300002)(8676002)(44832011)(21314003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 14:27:06.5454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e32199-e337-431b-1746-08dc219f893d
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3; Ip=[20.93.157.195];
 Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8346
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

When an XXX_BOOTCOMMAND isn't defined, the result is that bootcmd is set
to some random memory content. Fix it so that the function does nothing
in that case and leaves the bootcmd environment unmodified.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

 arch/arm/cpu/armv8/fsl-layerscape/soc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/cpu/armv8/fsl-layerscape/soc.c b/arch/arm/cpu/armv8/f=
sl-layerscape/soc.c
index 3bfdc3f774..4c61d28c20 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/soc.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/soc.c
@@ -811,6 +811,8 @@ __weak int fsl_setenv_bootcmd(void)
 	enum boot_src src =3D get_boot_src();
 	char bootcmd_str[MAX_BOOTCMD_SIZE];
=20
+	bootcmd_str[0] =3D 0;
+
 	switch (src) {
 #ifdef IFC_NOR_BOOTCOMMAND
 	case BOOT_SOURCE_IFC_NOR:
@@ -859,6 +861,9 @@ __weak int fsl_setenv_bootcmd(void)
 		break;
 	}
=20
+	if (!bootcmd_str[0])
+		return 0;
+
 	ret =3D env_set("bootcmd", bootcmd_str);
 	if (ret) {
 		printf("Failed to set bootcmd: ret =3D %d\n", ret);
--=20
2.34.1


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topic.nl=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
