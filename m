Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4580E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 10:20:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E953680104;
	Fri, 13 Dec 2024 11:20:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="IMb9yuH4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F24378010E; Fri, 13 Dec 2024 11:20:42 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20707.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::707])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B42E9800DF
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 11:20:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpN2G9Q59hnTsFtQL0VF6TzJ1bjAIqtFo+D9DWVVRLfCML2oS1Y27JRmlXcnrjBz0/WD2lqeJ2Th4EBCa8xMbBmIvdT/Vh2H7eU/Tlk/PZLcYl/i8Wq32ZyFJho0wBFB/0guxTig3+sm4vP9k1p8fFZs9HgAkly0zFeVobbJHC2/ueqB9FfDAIGdIvBF/tWCcbfZ3Yi7iW0TNBw5jHkSlnrfXIe2YoSG+wfkQEg+PJeNABWcgT+n9tfH+Uxqv8BI90kta/ovYPSZnbGPfcmJucDTmMEfqyvmMev5dvJrfTbbBARSdCmzlIojrsIfP1m40GFdg98GlHWEOQgehg7UDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YWskOtGOy7svTLLoC2XD6Zk0+AW1b5g2z62d4gvUNA=;
 b=IX0AyVan2Eg8qKOQrZFgUshiq6rP1yKtn5wSrVwdotkzz+2cjz5vYcDfx/e2BX4tyuMPZt9V+vWwt2whwzu7CfwTKJHBr7eieJ2DGPJN6OgS1Ufk0LQNWKe0ozKmQuOnjblf4FuXt0O4veH7Branz9qzNCrF/lA9ag+0BG7B99WFw+/P5im3DVfpz9uttW/NYsU3smFSLXP5fKAyMqCgFq4WqVrtvNym9dabzh9UoiJ3NvphDfxVmNC6h2RdHNSUwY4jJU/cTHkSiAJP1uBWWKPeD5l1TYUFXs75FEZfPyA6toiM22Cd+CMqv90LzjOY4Mu++gPe6ZhzNHnRvgeU8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YWskOtGOy7svTLLoC2XD6Zk0+AW1b5g2z62d4gvUNA=;
 b=IMb9yuH4gJou8hLRZKct//fBuM0pLY2FSXXIZSpFZXwFHZ66QMrhoFtS1P972OJ8wiY87QtDtQkNRaTnojNZkE/agY98lVXwt667R66nvJskhvCUaHo56oIVy9A3oRqzWpALRUyF6x896qEzJUtEzGJ9tF8EdgAr+tHKa0QqU0KOhrr4YUmuuEM6rfvM+ab2d5MjNcf8HoBwK19xp2GvOZBp/FEGHVivfn1fsJLGGhNPCY3B2hj9KelkHihDhUTjo8kdgdpPyZt5QIAdPIeFEjgMQQtlFHW4WlmM/MgYTtV1Mdo3O+5+o7jbqv9XADUJIwLfSvGHifsiPHflQSg7DQ==
Received: from AM5PR0301CA0022.eurprd03.prod.outlook.com
 (2603:10a6:206:14::35) by GV1P195MB1876.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:150:9f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 10:20:35 +0000
Received: from AMS1EPF00000044.eurprd04.prod.outlook.com
 (2603:10a6:206:14:cafe::f7) by AM5PR0301CA0022.outlook.office365.com
 (2603:10a6:206:14::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Fri,
 13 Dec 2024 10:20:35 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS1EPF00000044.mail.protection.outlook.com (10.167.16.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 10:20:35 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 13 Dec
 2024 11:20:35 +0100
Received: from llp-anderweit.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 13 Dec
 2024 11:20:34 +0100
From: Leonard Anderweit <l.anderweit@phytec.de>
To: <u-boot@lists.denx.de>
CC: <xypron.glpk@gmx.de>, <ilias.apalodimas@linaro.org>, <trini@konsulko.com>
Subject: [PATCH] doc: cosmetic: fwu_updates: Fix formatting
Date: Fri, 13 Dec 2024 11:20:24 +0100
Message-ID: <20241213102024.174888-1-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000044:EE_|GV1P195MB1876:EE_
X-MS-Office365-Filtering-Correlation-Id: e2b06c83-87da-4ada-789a-08dd1b5fc86e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fYg64H7HQaVwBB9VoeMdChEol0nrhgvJRsVIsMIqqhXNJ2GTY9yqFEouckVu?=
 =?us-ascii?Q?fVDf5xPUaQ3lykpkdddaCUMFO1VW9pgq6IVzSVoXBc3m4xac23S5661wD3xi?=
 =?us-ascii?Q?WqFMpCBSvu4Bf2czy/Qc7gFTfx0dGCen8PqL2EkWQSU9R/ZvQ/6r49SRuBmK?=
 =?us-ascii?Q?ecPBnpHiXUSRQoSh/8c7vyJZQHJE4WRvsoynuK13uEJw7+8j+IgSaX7qnWHD?=
 =?us-ascii?Q?NJoLz3oeBxLAzXVQYhvYltcJqWOEkS504tlHDQPA7Dsnxck9iv/BfZDKVgP7?=
 =?us-ascii?Q?DU9/k0PkB11AUN75Gk+JdFB3dMThqaT+yHouSl/oseaR5jdya8grTY58lS53?=
 =?us-ascii?Q?iVEO+w6qk8C7SfgC7PchSnoprEdsSecT/hcR5D5l67mbDT/y+JmkG8wYol8Y?=
 =?us-ascii?Q?gg8/52gkGutyWGxVlc2p4gD7S9D3mafSDZiLliyKfWPntwMHUcdcIE5AWMaE?=
 =?us-ascii?Q?vxr5xdu7wM27dxuvFfkUVd/Zp0ZDybKd73vKF+SkFJ0AeOOoFi1iz5koetZO?=
 =?us-ascii?Q?2jnU7MfJLnwcdy0s9RfYlk1f2yxbWkrp5HsmNxCr4G23zZnzO+QDLrQLpjro?=
 =?us-ascii?Q?kQ7g56hU/avgN2UDswEYqgUhzjD44QDtrrXJmyA+tflaaA5sLQlcoNB6eDHn?=
 =?us-ascii?Q?E/v6FE2J/FnI3fdFbEe5ob8gzDAXnDpSezZ0MF63dKm9iWc+4xP2FaiTMsQu?=
 =?us-ascii?Q?8zcEKJWASFZzcHqhGiwLxtjP5vwGFyLsP2QBf/+Vbu7aqE7rClcAtlJQAvq3?=
 =?us-ascii?Q?jfVkqykWyTsdHe5XFukQZbgW0Ro1diYHA3cZ4Hept/Xuq4RUqcUu+LNA3EJ9?=
 =?us-ascii?Q?HCOpt4lqVc3DUmjC3Y1Hjy0QCnxc2H5oiviocPVZB7zhBommqgVeYSA/c90U?=
 =?us-ascii?Q?YqzweEoLfh868YiYx1IB+V1FVud9kNT0MuBvMyaVwIXEwrhp3/fSwOzyZwnp?=
 =?us-ascii?Q?r7+yyFZvGCed+j6zUWvoeqHZVBOmZHBTmhDsyiGnZHdWho3Y5wZOtj2Iavg4?=
 =?us-ascii?Q?JGZcT0s37RNojG8d8ieEco1tE6H/LPWbeLppqet1jry0qgipzfZyv/2qVHeN?=
 =?us-ascii?Q?GHRD4cZiD/nRY9OcX8wdnKTW4vL6+czMfRj7lMOZgei2i6p7zg9tJ7mU2pzD?=
 =?us-ascii?Q?20I70wvBjL0M1ipU0iGsieOMt71id+slEyqTIiuTH6I2MnSF5qdG/F7Mcs3o?=
 =?us-ascii?Q?PttYbCmU+j6ag1nrby3XtADEcEjUcO+zSJwT+eW7nO/KJxszDLq9xdAacuHN?=
 =?us-ascii?Q?44Or4boILmMDNQqkeq6E2LFkclNzdK60qxe31c/h8s1QM0iYT+sKbzrueJAa?=
 =?us-ascii?Q?O5tL4ANquTii4U7maRmFPcnGv7vuQyfmFhYAGy0UkFzS1GVY5LmvgJhLiL6X?=
 =?us-ascii?Q?fQQsQMjQudKoacr03POct0qpUoSv9GuhZBYYipzO2xbJ/w+PPcJtOF3YuTd7?=
 =?us-ascii?Q?FiMcnP0tR9tu9LGXDWewdcRKgWn5gGBE?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 10:20:35.4535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b06c83-87da-4ada-789a-08dd1b5fc86e
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB1876
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

Remove one of the double colon so ..code-block is used for formatting.

Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
---
 doc/develop/uefi/fwu_updates.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/develop/uefi/fwu_updates.rst b/doc/develop/uefi/fwu_updates.rst
index 51e8a28efe15..847135814590 100644
--- a/doc/develop/uefi/fwu_updates.rst
+++ b/doc/develop/uefi/fwu_updates.rst
@@ -170,7 +170,7 @@ build the tool, enable::
 
     CONFIG_TOOLS_MKEFICAPSULE=y
 
-Run the following commands to generate the accept/revert capsules::
+Run the following commands to generate the accept/revert capsules:
 
 .. code-block:: bash
 
@@ -180,7 +180,7 @@ Run the following commands to generate the accept/revert capsules::
       <capsule_file_name>
 
 Some examples of using the mkeficapsule tool for generation of the
-empty capsule would be::
+empty capsule would be:
 
 .. code-block:: bash
 
-- 
2.34.1

