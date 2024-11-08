Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD383D64074
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 18:19:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4CA18901D;
	Fri,  8 Nov 2024 19:19:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="bAoIaEKS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDA388920C; Fri,  8 Nov 2024 19:19:50 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2070f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::70f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E08D188E0A
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 19:19:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPzDf8VVR8K4zESghnVJwN842gVhq9eGyOH8fAgVdSXsDu8ghq4VCZ/ypzKzmIg5SNAUPfN5MMHqperNXWmqKyemRnol4/Sat6F9Yjl137mNKfU+9t/lwTZRGA5tz0E7EgLykpoi4xNLviLmLNYQuaF4CMw3rO7f5hTec6POEMjHI5LuqXaIvE9R7p6NSNnJ6dKIM1x5JAtQ0KQ3YiR8Jpe19WoRo97YdUxr1K63zaJLFnUNC9QgNYHVy6lmS5BuSPUeCkOj7aWwFKJWz0/jSO1jEINEj5wsHMzT5HpqAcyXf83zP0b5h+cDCm7KDuBx3f29TKzR9lzNVjq/b0VLUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GM8WIpYw4TM92h7FkKV9FrdLL+JX9h9iRdzBREfDOM=;
 b=WiS87KImEwuT1EIgIipdmTGENfXM2HttDnjRBCkz3spxoSTT0lm9biHfuXBiuvsO7vE0V5/WMOOgkuMPwmgfscGrQirEB6TdrP44PhgTSAsf4SGcYTOfHtn7FiwrykUJHpwOm7T68ZRGNcHGOCcJ99hHLtZbs+KvExB5Vsb47AVMKbwOvXnVYnwk+ZgdMCLqWXHJg2b6IO9NA+eapqKBhtTiCtr2+/9ayKqo0PyYqX90eiyuy8TKxrfyywk75/gU98+FOzNbDBFsjYC0hQEUQqXhoe5nTVLb45jRelZi/1b83KqFK0mrx+BPmmpX/O9wTirrUs05I3A1k6WufnPbNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GM8WIpYw4TM92h7FkKV9FrdLL+JX9h9iRdzBREfDOM=;
 b=bAoIaEKSE/6Id+5s5UaZkyCBW+6OMyIcY56tHsrBWjFm6NJSN8gNqVNEOlGXXQ1BMjA8KL2ryIcaS6eC9YCsAfnFwOBzP/5AZEytlBK6N911mM8/akflOleDRiYkoB/9p9JstShsaPlyAt/Y1hlC2rv+3b00YRk22Z4lT0xINk0=
Received: from DU2PR04CA0239.eurprd04.prod.outlook.com (2603:10a6:10:2b1::34)
 by PA1P195MB2560.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:44d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 18:19:46 +0000
Received: from DB3PEPF0000885F.eurprd02.prod.outlook.com
 (2603:10a6:10:2b1:cafe::20) by DU2PR04CA0239.outlook.office365.com
 (2603:10a6:10:2b1::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21 via Frontend
 Transport; Fri, 8 Nov 2024 18:19:46 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB3PEPF0000885F.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 18:19:44 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 8 Nov 2024
 19:19:43 +0100
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 8 Nov 2024
 19:19:42 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <d-gole@ti.com>, <upstream@lists.phytec.de>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: [PATCH 2/2] board: phytec: common: k3: Expose product infos to Linux
Date: Fri, 8 Nov 2024 10:19:14 -0800
Message-ID: <20241108181914.3358114-2-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241108181914.3358114-1-d.schultz@phytec.de>
References: <20241108181914.3358114-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885F:EE_|PA1P195MB2560:EE_
X-MS-Office365-Filtering-Correlation-Id: 736702ff-efd6-4668-47da-08dd0021ebac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lBu7yMhvy+jonxjGl7dlr3dfTbkTtV0pdWly0x3cADoYQRx5RNO8Y4K0h7X0?=
 =?us-ascii?Q?qYUdfQ9ZjqMadximvesyjpIfP4GaB9xLMxycLpgKUTmwo9HV3gYa+AuWJAbh?=
 =?us-ascii?Q?+Lq8lovPk1Gj1IwEwRAp8pXqJQUczvqJ4ZmcfobUPm1gyCdZ1aEIwswbPXAt?=
 =?us-ascii?Q?13FZ4Vwxh9XaPjmdNZAKBLBVA29LM/x/9GfH7hg80A/lTK6FFUSupiivrHKx?=
 =?us-ascii?Q?odOpB1pV+Kmgdl2hQ0d2gMWW47XLepq+5+GAxGfXRqL2K9465OpVUffpAcNI?=
 =?us-ascii?Q?QatCWUtdrwcgDY1HKi00YPwcmY8ZWnNSvkWhmjNN9fQt5AywaMYAm6JoFVU2?=
 =?us-ascii?Q?FkE7ffkciWsMUtm+27DzDrgSKnP5bHs5iTSzXZcBccgmbljcYOHc3phimPdw?=
 =?us-ascii?Q?T1GFqlY8wN8Lb4hekvXV1q61h1Pn51yThQ72urUGXWrtParNRcV/ma/DBfrt?=
 =?us-ascii?Q?SFQTJaKbNflQV1FIsGzGAjcSILFcz+J3+IHMCpsMMhDufNkDiw8yOIyeoUxs?=
 =?us-ascii?Q?nr7XwJAH4/ZkEjjFafN37MAIsNkEdQocJ/wht0g5qIXgUEDKNZKtPQG/sVji?=
 =?us-ascii?Q?oZUa97Fp/bB85wMdB3HFqrPBNCWYeI1KjdZGSTjaaz1WuJfTeOST2HduRwbI?=
 =?us-ascii?Q?fhGH39j/pBM1JsZGE5PULJOl1S2EgCcU3DvmJ+Y2xUqbJuvz0dnjEaan5/4d?=
 =?us-ascii?Q?PwfeDk/eSOArvyB92MToplPzt0fw6go1UlWB4a+O7SCvCgA7rnTGyi9vgVkp?=
 =?us-ascii?Q?6lEuAnD7VymTPYNVRa4KZPr86xIoMg4tH9+WhfJf1rDXmlzh1MgH3mmijQi1?=
 =?us-ascii?Q?Y+cOb+dtLfzh34xQMaKCrWstfOo/noBa2NadJzPoNlx3UbNnKeP0Mwm/GJem?=
 =?us-ascii?Q?4EaYsto1mvofTVDxkcNm113jU016JwsRsRxjIoUb6mM6qdHuGqRBfzf8WvqS?=
 =?us-ascii?Q?tN2yeV1fTkr3xNpsStgaGHNWyJ0O4iD+gDErNBZeu1cCxDkkECGIy4UoEZQm?=
 =?us-ascii?Q?WcBVvgjllx+yryclvnWOgf60TW53vnkmykVUvA7w+IFvbLZ1xUOrFKt3VR9B?=
 =?us-ascii?Q?osFncDkZDzgjV19CZWwFEPGHULJZTnGr7ILCe6e7I+G/JD1e2cz3IyeHNkEV?=
 =?us-ascii?Q?cfoxdWlHenOgLU1cqxf2GjzPmUprjj0e5D90iPjWlvi/qAcUfOPeqEPm7o6n?=
 =?us-ascii?Q?+fZh9u3SrTz4gyCpj+NBCt6DEX40MRAIXThH8yV2e4X20q0Vr86/zZE1Go0B?=
 =?us-ascii?Q?ppHOrgfNDKWEoZ9E3LtB2gpvlo1Pq4CGqBqYyXyfTzsITps2G0eRTR2crq/t?=
 =?us-ascii?Q?vbAPxTsn2EEoImU6qWIpBIWBp4E/YoDDzIuGo8Rji7tPVOohRxDcPYAYSRgx?=
 =?us-ascii?Q?0AI7IxFqQ/ha6rXHTe0JFuCYtD8NXFxm8LBY36gMYGPRXm/CVQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 18:19:44.3710 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 736702ff-efd6-4668-47da-08dd0021ebac
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P195MB2560
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

Call 'phytec_ft_board_fixup' in the common K3 board code
to expose the product name and part number to Linux.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 board/phytec/common/k3/board.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/board/phytec/common/k3/board.c b/board/phytec/common/k3/board.c
index 3d7e090ccaa..14a10f34e53 100644
--- a/board/phytec/common/k3/board.c
+++ b/board/phytec/common/k3/board.c
@@ -99,8 +99,22 @@ int board_late_init(void)
 #if IS_ENABLED(CONFIG_OF_LIBFDT) && IS_ENABLED(CONFIG_OF_BOARD_SETUP)
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
+	struct phytec_eeprom_data data;
+	int ret;
+
 	fdt_copy_fixed_partitions(blob);
 
+	ret = phytec_eeprom_data_setup(&data, 0, EEPROM_ADDR);
+	if (ret || !data.valid)
+		return 0;
+
+	ret = phytec_ft_board_fixup(&data, blob, bd);
+	if (ret) {
+		pr_err("%s: Failed to add PHYTEC information to fdt.\n",
+		       __func__);
+		return 0;
+	}
+
 	return 0;
 }
 #endif
-- 
2.25.1

