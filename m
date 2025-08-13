Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD240CA0EE4
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 09:44:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56CFE83303;
	Wed, 13 Aug 2025 11:44:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="PK2z6ywo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6768A83390; Wed, 13 Aug 2025 11:44:15 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2070f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::70f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9C93832FE
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 11:44:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZLZRR0L48lXTd5XiEyOEMOtdpizCll94+QwQ7y9V50NxZa9uKSUvith0KW0tGaEgfFSO17OeMu7dg8YioVcDPE50L2/pZwzPe5RDMPsIZBZfZbl1xg1+6z5MECviLwvTeUlehK67MTM2fM6YO4n3fksmIMPNMI2ZPd9RBb0J5/PyDEuYcwSjZK2vcKBegzgqR45XUrrbtun1P/07nJSKb9DyMPYPgvSlcAbr+mNsRhV7/uAsDyb34xWoL4OC+GHsRsLn1KJ4RXTXxm3faVPQxSd2SesKczv5GBEc0hY1Mue/oMlmbI/ITO82z5pTahKrAdcrGPsINTrrq06ikf8LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0BjGj4GgGKROKMDSKdsMb7UtxJUe1fV7/7dLwuwlmI=;
 b=dVb0zl9bS5u6EIE/dXCzZltsljTUabKJ/YzV2wTynoi7xdVc7IEIK+DkgY69axtmuErPpIxw8e045E8G9fGlr/OsDFi96OooyAr3KDZVlkZkZgyqeQiq5b8753yvhQPy5TQin4sZhV3isecniP07N91okpvfPt+vPEk14SDwcem3hw8REwISbc7XxdTlluQbv1FzVrw3opR3AN5Ja3tMMfPfDc/mTvyP8crqFCMWMVKVRS2Q4jLL03Hba8X6aBZIVTZj5bfyJwBt4N9smY31pVn7YCfQYI5mIclCHsRw9UYX4agENTtDlmuMLUQZgghsBpB+MzuByeaKIefvnDITSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0BjGj4GgGKROKMDSKdsMb7UtxJUe1fV7/7dLwuwlmI=;
 b=PK2z6ywoFkaD+Vn1na/3Ez+sZmA48pVJKxm9zjeLR2RUXA8eFqBCxqDw4hS/6RbQmA0r9RbjWIvScmEnQp4PvUk0Ysh3VMP8f/Y7M7Up8fmGeXF157RktgwDSXIBFungv2wQovBjoYHarHeEUMzbKv99ajkpNTiMUm2+V/jDZfrPtxPOz4SbMRlV449KZDustEWFpZSNn2ng0FTQj3bX4hKScjXtyhtIMmXzd/mbLWJmyyFbwgNFQMcNyC6ZZGpgecXCa1t8Sd5VYEnQX1PR5J37v219ueb8i7g8tty8qZrdfjAN35E1RuqmM4FVSietfb7H7dtuEsiwsv5/8LL1Lw==
Received: from DU2P250CA0019.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::24)
 by DU7PPF294BA3B80.EURP195.PROD.OUTLOOK.COM (2603:10a6:18:3::bcb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 09:44:07 +0000
Received: from DU2PEPF00028D0F.eurprd03.prod.outlook.com
 (2603:10a6:10:231:cafe::f7) by DU2P250CA0019.outlook.office365.com
 (2603:10a6:10:231::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 09:44:07 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF00028D0F.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 09:44:07 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 13 Aug
 2025 11:44:03 +0200
Received: from llp-moog.phytec.de (172.25.32.60) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 13 Aug
 2025 11:44:03 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Wed, 13 Aug 2025 11:43:33 +0200
Subject: [PATCH 2/2] doc: phytec: update imx8m docs for optee builds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250813-imx8m-optee-enable-v1-2-bbff23f047e5@phytec.de>
References: <20250813-imx8m-optee-enable-v1-0-bbff23f047e5@phytec.de>
In-Reply-To: <20250813-imx8m-optee-enable-v1-0-bbff23f047e5@phytec.de>
To: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, "Teresa
 Remmet" <t.remmet@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <b.hahn@phytec.de>, Yashwanth Varakala <y.varakala@phytec.de>, Jan Remmet
 <j.remmet@phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755078243; l=9613;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=ApstLj4OPvbFDCeEPEGducldGTIkLREVg3nbHE4wAXo=;
 b=5ZJTmbzuYRd9rjwEBOcO7jx6BIO5gOBU1QAaLvl6a8HPT4T1ixL7z3TNY3FwGTnzJSnyZqrsp
 Vjm+PLlUdQ1DQ1NEM+EBUaSswHoW3coH/iS2YJdxiWiZsfyEgs1u/g1
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.60]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0F:EE_|DU7PPF294BA3B80:EE_
X-MS-Office365-Filtering-Correlation-Id: 50490e9d-8534-4c52-82d0-08ddda4df277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RjRJQU9BSlJ6ODhXM3ZzVTVHQ1Z1T3VIQVFlM0RDWGxlcW1VZ1V5cS9JeFNn?=
 =?utf-8?B?TUQybnpVRnZ1UVRaUEowSkkrRFNDMjVXL29TYXRTV1lwTExXVEZDS3BNZi9a?=
 =?utf-8?B?MU45OWlLMlhuSG1rL083Mmp1d284dHR0dU5xcXNKMWJqV2NXdEFPaTFWeVlT?=
 =?utf-8?B?cmIxc3RmZ1p4cE5IYkhhNUZiOTYwTXpQV2xveFNqWUhOUzk4N3ZqS3R0WmxK?=
 =?utf-8?B?ZS9VV0RUTjE1TGthU09OSnpCRlI2OXFqTjJDOHBnRlY2aUFxYXpFb1JuTThx?=
 =?utf-8?B?VkF6M0JSUmg2TCt0OE9iOXo3UjQxRyt5LzE4a0xJK1JEK0RmbHF6SktqRjh1?=
 =?utf-8?B?dDZmVVB1VTBZaU5Fb25udExBdlpmdHZ3MVozK1JraW0vSnJTL0NLOXJvaWxa?=
 =?utf-8?B?ZDEzM2VBaXpCZzZqaWUrSmZGS3dXZ2ErTmtKbjNtS29jS3pRQkNaR1BmWENJ?=
 =?utf-8?B?ZTZWOTlEeFUvR1l5U0F3VWF0SkFrbk53ZkdFOXRaWjhQN1pJaWp6eDBSbFR5?=
 =?utf-8?B?UHByR1IzN0d5aTh0VWlaRXYvSE5GbCsrL3phaEJvdVFDTDl0U1FWUEExbDhl?=
 =?utf-8?B?NWhYenBBUkhVVDZwT09qczJxbmUrcnlGeURvSVlaUEhobklXcEFxSi9vQm9D?=
 =?utf-8?B?VGZZZEk5V085V08xOHFXSmtQakg2RWc1U2hxRGxiVU0wT0ZRT3VXLytUY3NB?=
 =?utf-8?B?THlMSzJsdnRqOUNCbWlsT01sUWtSV29ZT0ZWOStDOSthODZ4bUhNeGxQVVVs?=
 =?utf-8?B?cnhRMHFRbDJqSlZJbjRBQ3VOOENyRHJUdVBVNDZQMjFjMklFa0ZJV0pjSjZC?=
 =?utf-8?B?YmhhNmhDbjJDN0xEK2dxUTZPcnRvQnkzYTFSaGN3VWxQc2NMSEVEcUZMTFBI?=
 =?utf-8?B?SUNmQk1nUkdiUEdnU0VVQ0dXRjF3MTlobkpmck5hMWhBT1lMWGRFeHlKdWMr?=
 =?utf-8?B?TjZ2THNoZjk4dmRwK2tSVVdJVjM1OGthQ2VmRFdUZWtZOVJJcmRWYzBRdGt3?=
 =?utf-8?B?VkVrVGJSVU4vbUZtemJ5aGZUM1k5eHlEU3V2cEFtTm16NVBVNG1OSjJQaUUr?=
 =?utf-8?B?OGpON1Q2Z0t4WG9RcTRzYzBrV3ZDSFpMSFZhM2h5b29oTTJTUW56c1kyRGJi?=
 =?utf-8?B?d2hYZzk3SzYwU0o0c3ZMVElPaGZUNHFJaDlsdUNTZHB0NGZ1cXBSZG5SamtZ?=
 =?utf-8?B?dHlEeS8zRmFrQW5DTmRFNlZoa00wQnkzbkdIcWlNd0RBaHFWYXVxTVFyNDQw?=
 =?utf-8?B?UTE4V3A2dzRIWUk3NzhKZ0hkY0RIUFZWSWpidCtBSzBvU0NybGg4QTcweVR6?=
 =?utf-8?B?VzVIMmxrQVNrbUUzSjB6dFoyelR2bkJCamFqZHY0aEZraVgvQ2JjTmZYUW5Y?=
 =?utf-8?B?dm11STV1YzNCNlZkall6UW8vd0RHVzdKSnIvV2tGTlVpNUJCOExld3RGY2Fm?=
 =?utf-8?B?cWFLOXFaVXJxSFhWTEllYnZ3d3haZ2hydkRuWkdaUnNWbXF2aEVLZUM5bWlP?=
 =?utf-8?B?TEFVVzZWYVF2RExpZGFwaFRDWEpkaEVnR0lFQU5yaWRwQ25sa05zRHh5WnJ4?=
 =?utf-8?B?dGIxNUczYWdPeXFvc1FMbk5HOGpEMUw3d3hYNlQ0OXN0TmlHNS9VcG1remZZ?=
 =?utf-8?B?eGtLcWtneHp0ODl4MFdPRm9RUGZ0cDFvb0I4RTFJRHl4clQwRklGTkFhZlVz?=
 =?utf-8?B?aDNzVFpvKzN3cmtoWnZnd1dYSjR2eFFzcnJtakk3YmpCcHdnZzJieG9CYVo1?=
 =?utf-8?B?ZkxpNDNPdldvNTBNemZrOC9HRVZFY0MyeGtaUm9DSTcyK21nVEtEQUF1MWph?=
 =?utf-8?B?M00wclVNdnhSU1ZraUxNckV5RDNydEVzZjNON2t2TFhHUEczWjVvVDBLamNB?=
 =?utf-8?B?ZG1KWFd6OWx6bU41alJvVnNtTktNVDZUeWxNdUxWUFhFQkdQeTBaYW1SbUoy?=
 =?utf-8?B?UzZTT3duR1M3bEx4NXhkbVNFakx3bFlkSkI0OUJZTi9oY0Z3c3B3MkQwc2JX?=
 =?utf-8?B?WEJ1WW1wNUdLRDh6ZE1CdnFJYzBaVkIybDcvcTlMUUpjTTllaHhPaHZKNjJE?=
 =?utf-8?B?Yko0RzdmeldaVnc5b3p5UGhkRnFHVVV2MmNXUT09?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 09:44:07.1049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50490e9d-8534-4c52-82d0-08ddda4df277
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PPF294BA3B80
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

OP-TEE configs are enabled by default, change the doc to no longer
declare OP-TEE as optional.
Further, phycore-imx8mm and imx8mm-phygate-tauri-l use different build
instructions, so dissolve the common file for building OP-TEE.
While at it, introduce style changes where export commands are no longer
used.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 board/phytec/phycore_imx8mm/MAINTAINERS     |  1 -
 doc/board/phytec/imx8mm-optee-build.rsti    | 14 ----------
 doc/board/phytec/imx8mm-phygate-tauri-l.rst | 42 ++++++++++++++++++----------
 doc/board/phytec/phycore-imx8mm.rst         | 43 +++++++++++++++++++----------
 doc/board/phytec/phycore-imx8mp.rst         | 32 +++++++++++----------
 5 files changed, 74 insertions(+), 58 deletions(-)

diff --git a/board/phytec/phycore_imx8mm/MAINTAINERS b/board/phytec/phycore_imx8mm/MAINTAINERS
index 7631e1cb331b608335620d0db49104459f673d1d..58c5e2d0af9fe404a5995fecc96cdbaa5845f979 100644
--- a/board/phytec/phycore_imx8mm/MAINTAINERS
+++ b/board/phytec/phycore_imx8mm/MAINTAINERS
@@ -9,6 +9,5 @@ F:	configs/imx8mm-phygate-tauri-l_defconfig
 F:      configs/phycore-imx8mm_defconfig
 F:	doc/board/phytec/imx8mm-phygate-tauri-l.rst
 F:	doc/board/phytec/index.rst
-F:	doc/board/phytec/imx8mm-optee-build.rsti
 F:	doc/board/phytec/phycore_imx8mm.rst
 F:      include/configs/phycore_imx8mm.h
diff --git a/doc/board/phytec/imx8mm-optee-build.rsti b/doc/board/phytec/imx8mm-optee-build.rsti
deleted file mode 100644
index c83de5cc7cf4a0229cbd89f4c7d2bfd8448cb735..0000000000000000000000000000000000000000
--- a/doc/board/phytec/imx8mm-optee-build.rsti
+++ /dev/null
@@ -1,14 +0,0 @@
-Build the OP-TEE binary (optional)
-----------------------------------
-
-.. code-block:: bash
-
-   $ git clone https://github.com/OP-TEE/optee_os.git
-   $ cd optee_os
-   $ make CFG_TEE_BENCHMARK=n \
-     CROSS_COMPILE=aarch64-linux-gnu- \
-     O=out/arm \
-     PLATFORM=imx-mx8mmevk \
-     CFG_TZDRAM_START=0x56000000 \
-     CFG_DDR_SIZE=0x80000000 \
-     CFG_UART_BASE=UART3_BASE
diff --git a/doc/board/phytec/imx8mm-phygate-tauri-l.rst b/doc/board/phytec/imx8mm-phygate-tauri-l.rst
index 0d9e1024f8c5300e91a3a4c18b2babd5853a0824..f82020d87305f65f19eeff1ea78ff013962de820 100644
--- a/doc/board/phytec/imx8mm-phygate-tauri-l.rst
+++ b/doc/board/phytec/imx8mm-phygate-tauri-l.rst
@@ -9,7 +9,7 @@ Quick Start
 -----------
 
 - Build the ARM Trusted firmware binary
-- Build the OP-TEE binary (optional)
+- Build the OP-TEE binary
 - Get ddr firmware
 - Build U-Boot
 - Boot
@@ -21,23 +21,36 @@ Build the ARM Trusted firmware binary
 
    $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
    $ cd trusted-firmware-a
-   $ export CROSS_COMPILE=aarch64-linux-gnu-
-   $ export IMX_BOOT_UART_BASE=0x30880000
-   $ # with optee
-   $ make PLAT=imx8mm BL32_BASE=0x56000000 SPD=opteed bl31
-   $ # without optee
-   $ make PLAT=imx8mm bl31
+   $ make PLAT=imx8mm \
+     CROSS_COMPILE=aarch64-linux-gnu- \
+     IMX_BOOT_UART_BASE=0x30880000 \
+     BL32_BASE=0xbe000000 \
+     SPD=opteed \
+     bl31
 
-.. include:: imx8mm-optee-build.rsti
+Build the OP-TEE binary
+-----------------------
+
+.. code-block:: bash
+
+   $ git clone https://github.com/OP-TEE/optee_os.git
+   $ cd optee_os
+   $ make CFG_TEE_BENCHMARK=n \
+     CROSS_COMPILE=aarch64-linux-gnu- \
+     O=out/arm \
+     PLATFORM=imx-mx8mmevk \
+     CFG_TZDRAM_START=0xbe000000 \
+     CFG_DDR_SIZE=0x80000000 \
+     CFG_UART_BASE=UART3_BASE
 
 Get the ddr firmware
 --------------------
 
 .. code-block:: bash
 
-   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.23.bin
-   $ chmod +x firmware-imx-8.23.bin
-   $ ./firmware-imx-8.23.bin
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.28-994fa14.bin
+   $ chmod +x firmware-imx-8.28-994fa14.bin
+   $ ./firmware-imx-8.28-994fa14.bin
 
 Build U-Boot for SD card
 ------------------------
@@ -49,15 +62,16 @@ Copy binaries
 
    $ cp <TF-A dir>/build/imx8mm/release/bl31.bin .
    $ cp <OP-TEE dir>/out/arm/core/tee-raw.bin tee.bin
-   $ cp firmware-imx-8.23/firmware/ddr/synopsys/lpddr4*.bin .
+   $ cp firmware-imx-8.28-994fa14/firmware/ddr/synopsys/lpddr4*.bin .
 
 Build U-Boot
 ^^^^^^^^^^^^
 
 .. code-block:: bash
 
-   $ make imx8mm-phygate-tauri-l_defconfig
-   $ make flash.bin
+   $ make CROSS_COMPILE=aarch64-linux-gnu- \
+          imx8mm-phygate-tauri-l_defconfig \
+          flash.bin
 
 Flash SD card
 ^^^^^^^^^^^^^
diff --git a/doc/board/phytec/phycore-imx8mm.rst b/doc/board/phytec/phycore-imx8mm.rst
index 08f5949e02d8d2bfba71867d93c2b3ed8fdc67e2..dfe7816f0883882720f18f144fca92d70d4ffe05 100644
--- a/doc/board/phytec/phycore-imx8mm.rst
+++ b/doc/board/phytec/phycore-imx8mm.rst
@@ -9,7 +9,7 @@ Quick Start
 -----------
 
 - Build the ARM Trusted firmware binary
-- Build the OP-TEE binary (optional)
+- Build the OP-TEE binary
 - Get ddr firmware
 - Build U-Boot
 - Boot
@@ -21,23 +21,36 @@ Build the ARM Trusted firmware binary
 
    $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
    $ cd trusted-firmware-a
-   $ export CROSS_COMPILE=aarch64-linux-gnu-
-   $ export IMX_BOOT_UART_BASE=0x30880000
-   $ # with optee
-   $ make PLAT=imx8mm BL32_BASE=0x56000000 SPD=opteed bl31
-   $ # without optee
-   $ make PLAT=imx8mm bl31
+   $ make PLAT=imx8mm \
+     CROSS_COMPILE=aarch64-linux-gnu- \
+     IMX_BOOT_UART_BASE=0x30880000 \
+     BL32_BASE=0x7e000000 \
+     SPD=opteed \
+     bl31
 
-.. include:: imx8mm-optee-build.rsti
+Build the OP-TEE binary
+-----------------------
+
+.. code-block:: bash
+
+   $ git clone https://github.com/OP-TEE/optee_os.git
+   $ cd optee_os
+   $ make CFG_TEE_BENCHMARK=n \
+     CROSS_COMPILE=aarch64-linux-gnu- \
+     O=out/arm \
+     PLATFORM=imx-mx8mmevk \
+     CFG_TZDRAM_START=0x7e000000 \
+     CFG_DDR_SIZE=0x40000000 \
+     CFG_UART_BASE=UART3_BASE
 
 Get the ddr firmware
 --------------------
 
 .. code-block:: bash
 
-   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.19.bin
-   $ chmod +x firmware-imx-8.19.bin
-   $ ./firmware-imx-8.19.bin
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.28-994fa14.bin
+   $ chmod +x firmware-imx-8.28-994fa14.bin
+   $ ./firmware-imx-8.28-994fa14.bin
 
 Build U-Boot for SD card
 ------------------------
@@ -48,15 +61,17 @@ Copy binaries
 .. code-block:: bash
 
    $ cp <TF-A dir>/build/imx8mm/release/bl31.bin .
-   $ cp firmware-imx-8.19/firmware/ddr/synopsys/lpddr4*.bin .
+   $ cp <OP-TEE dir>/out/arm/core/tee-raw.bin tee.bin
+   $ cp firmware-imx-8.28-994fa14/firmware/ddr/synopsys/lpddr4*.bin .
 
 Build U-Boot
 ^^^^^^^^^^^^
 
 .. code-block:: bash
 
-   $ make phycore-imx8mm_defconfig
-   $ make flash.bin
+   $ make CROSS_COMPILE=aarch64-linux-gnu- \
+          phycore-imx8mm_defconfig \
+          flash.bin
 
 Flash SD card
 ^^^^^^^^^^^^^
diff --git a/doc/board/phytec/phycore-imx8mp.rst b/doc/board/phytec/phycore-imx8mp.rst
index 50be99126537a2dc5323bd49c1513b196182c5f3..313321340d4473f73975d7ed22ddb8fef88c9491 100644
--- a/doc/board/phytec/phycore-imx8mp.rst
+++ b/doc/board/phytec/phycore-imx8mp.rst
@@ -3,13 +3,13 @@
 phyCORE-i.MX 8M Plus
 ====================
 
-The phyCORE-i.MX 8M Plus with 2GB of main memory is supported.
+The phyCORE-i.MX 8M Plus with 1,2,4GB of main memory is supported.
 
 Quick Start
 -----------
 
 - Build the ARM Trusted firmware binary
-- Build the OP-TEE binary (optional)
+- Build the OP-TEE binary
 - Get ddr firmware
 - Build U-Boot
 - Boot
@@ -21,12 +21,12 @@ Build the ARM Trusted firmware binary
 
    $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
    $ cd trusted-firmware-a
-   $ export CROSS_COMPILE=aarch64-linux-gnu-
-   $ export IMX_BOOT_UART_BASE=0x30860000
-   $ # with optee
-   $ make PLAT=imx8mp SPD=opteed bl31
-   $ # without optee
-   $ make PLAT=imx8mp bl31
+   $ make PLAT=imx8mp \
+     CROSS_COMPILE=aarch64-linux-gnu- \
+     IMX_BOOT_UART_BASE=0x30860000 \
+     BL32_BASE=0x7e000000 \
+     SPD=opteed \
+     bl31
 
 Build the OP-TEE binary (optional)
 ----------------------------------
@@ -39,16 +39,17 @@ Build the OP-TEE binary (optional)
      CROSS_COMPILE=aarch64-linux-gnu- \
      O=out/arm \
      PLATFORM=imx-mx8mp_phyboard_pollux \
-     CFG_TZDRAM_START=0x56000000
+     CFG_TZDRAM_START=0x7e000000 \
+     CFG_DDR_SIZE=0x40000000
 
 Get the ddr firmware
 --------------------
 
 .. code-block:: bash
 
-   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.19.bin
-   $ chmod +x firmware-imx-8.19.bin
-   $ ./firmware-imx-8.19.bin
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.28-994fa14.bin
+   $ chmod +x firmware-imx-8.28-994fa14.bin
+   $ ./firmware-imx-8.28-994fa14.bin
 
 Build U-Boot for SD card
 ------------------------
@@ -60,15 +61,16 @@ Copy binaries
 
    $ cp <TF-A dir>/build/imx8mp/release/bl31.bin .
    $ cp <OP-TEE dir>/out/arm/core/tee-raw.bin tee.bin
-   $ cp firmware-imx-8.19/firmware/ddr/synopsys/lpddr4*.bin .
+   $ cp firmware-imx-8.28-994fa14/firmware/ddr/synopsys/lpddr4*.bin .
 
 Build U-Boot
 ^^^^^^^^^^^^
 
 .. code-block:: bash
 
-   $ make phycore-imx8mp_defconfig
-   $ make flash.bin
+   $ make CROSS_COMPILE=aarch64-linux-gnu- \
+          phycore-imx8mp_defconfig \
+          flash.bin
 
 Flash SD card
 ^^^^^^^^^^^^^

-- 
2.43.0

