Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D397BC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 05:00:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0211A81417;
	Wed,  5 Mar 2025 05:58:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="EI//cybj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DC9980F92; Wed,  5 Mar 2025 05:58:56 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20720.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::720])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92B5C810ED
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 05:58:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYWNXC6cd0cOCQEWXTP2W9K+0q9+kQWQg1sWj5ecR1JzfyaQZg6YbPh+lov7CgW6kmmxfA5OxK+MKsFXeJ26zy23vXe8692NdtmUuRjupUjOXhfwPYLjRJuVfrrEzm1ACMsQ41w9jtdxVB6TRkd6mwcWzK6COHONcAyGSbQ+qhogyGviPCynSUDg3y/+xZ6jec9z7s/f/4Lk3AP3ojxNl7IKXYqnTI8eGXAEI/5GfgxrG8vtWwvcQA0quuZ4yVQj6ihsIETBQo0q2cuZfNV9AwBZtICIN9DzekdHPtJLTglq6GhRuWgvoknjSYZ7c7GYKA1/+59070t+IlbX3Eivvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93QAt1EwcWmT8oxF6b/X0U0u+P/LA+NEMTWNzPCOBM4=;
 b=ro1FQY867guZVukkfa/RxjkfU1r9QKHglKIw8YKibuvgN6unzLsg/6aOFfqXxILd6P13i16pyO9Qyf9a+KVFu+rAFVooNYvqC+NXMceXPc40MSsvwAhTB8H/JetyAJNXlTbJynEM2GzKV1USQ8FJJAQ2Kzem7q7WkvDPQoj+RtbrqZZPQD0GQwE9aLP6NwAcrR2QnwiyTLtULQv1SePSzpen4d/gaELaa2Sm0KPUCtoFTW69cWdWn5w5wE23SXEQu5v0/TIn2EdVl7Mwp6ajfd6DSPLE7o8+H+LCi7t0GOqeT0jyPI1KpFXmuEJ93cjLUjjbqn/b106o2s9RwLmu4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93QAt1EwcWmT8oxF6b/X0U0u+P/LA+NEMTWNzPCOBM4=;
 b=EI//cybj85uW7uOYfY0op05xlsTr3qnnMmbLqO2+sO4421lgoCtUDVT838lObbTOxso27tTVjCflLvtokke3fazK9Wa16OnVxNGN+9555+rMGBpq4Di47NQbULkJxS296QfBLm/rIFKvmWHA4QcylN0IGND6gOzFr0XEaQd3UYnITMWRaSoovwlEgnY+5sLvYk9hnC7MVx4U55p5CjeHgYaRA4zANINpFvLvlW6PXj9XwOebHcWWUaj/6O6hPvOc3qGe6liGTOd+5t7sv6yimJaw7kS/SJK9bX6xqz8DrDpzDeBrmXTKmCymEkJ8rpG6mzkEN7lSNmlY8WYWyIKnDg==
Received: from CWLP265CA0269.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5c::17)
 by GVXP195MB2480.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:1b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Wed, 5 Mar
 2025 04:58:48 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:401:5c:cafe::bd) by CWLP265CA0269.outlook.office365.com
 (2603:10a6:401:5c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Wed,
 5 Mar 2025 04:58:48 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 04:58:47 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 05:58:47 +0100
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 05:58:47 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <joe.hershberger@ni.com>, <n-francis@ti.com>, <afd@ti.com>,
 <nmorrisson@phytec.com>, <d-gole@ti.com>
Subject: [PATCH 00/13] *** Various Improvements for phyCORE-AM62/A SoMs ***
Date: Wed, 5 Mar 2025 05:58:25 +0100
Message-ID: <20250305045838.3614661-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|GVXP195MB2480:EE_
X-MS-Office365-Filtering-Correlation-Id: 06431fc6-f7e1-44e5-7384-08dd5ba26a0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pLAF4WHYu0iSUxUHbs46Dtfs7TMGdin2yntY8snxS3il2KCg9cVhH6Jyl6Nd?=
 =?us-ascii?Q?JCRNu2TfR6NPhSesXNphi9cPTCPNmC+80mtYMVKGUjF4+icXfPfWyDhkYfDG?=
 =?us-ascii?Q?YQsfWrwTtM0tMISPxRiG6f32YKkbYU+Q9vy+HrwkRTx4ktOAGmheZp4SZy1w?=
 =?us-ascii?Q?h5CdxEqtX5k6Y1utzt4zxklBRq+oX6U6jPdkrg+lAUqax2S+iiZmI8HhbEDj?=
 =?us-ascii?Q?Xoa0SlFYKBrgvD/nUE0dM6YnzRrHpY7bRb9Mhek2sYzne5seD0g63L/6BHpy?=
 =?us-ascii?Q?MTYGErrIuixZFw4/Ve0u82lqjeGphkEmwBROX02k6zil4RwjBTaTg8dJXr19?=
 =?us-ascii?Q?jVz8xfXRaL9xwnm9QsWjkdYqcLxfD0CI9/3JKogToq9TpA9hWvWY/Z9vszHr?=
 =?us-ascii?Q?IpE2WJ0T4fak7ued93UuG2Q54/m+6AFB3CXm6HQ0vPhTHTIXSKeRxBVHDDNQ?=
 =?us-ascii?Q?wrySy4LE11RlsXq4kLIZcJyg7a+gXCEG9V8wsMwgVwxIjMZEy2c1228RZ3Dl?=
 =?us-ascii?Q?QXzvOlMSTBDhJsY9LB3zVBR1EsSnepdSOIRWxxdgqkGQcW0fi5jdo4SaHPfW?=
 =?us-ascii?Q?k8fdyJKgJ0QgN2BKNQDZkpMUt3TmJsPPobY/ihedhFlsQDz6HeQm89asiShb?=
 =?us-ascii?Q?BlH0guWM3vnAk9AkACxehXhecsEP1o0fhwzNdCLU/VVUJxCBOKIaeBzsFS95?=
 =?us-ascii?Q?30+lYX5uJs4etaFLcrIA5hKjo0A/lbFWDOb59Qrhfm1P2AXZnk6LrQtHqTe+?=
 =?us-ascii?Q?xuHip5AeuTm4dtHEA4ySZOJGH7z4f2Gl9LJXCCMYm0GvesHWJEwzCuZlf6kx?=
 =?us-ascii?Q?0Y9ACmBfPR1pR6RKo9naTwTecni2pmTuBZ8xdXtJAMsrBuznj3zaowdHBmpZ?=
 =?us-ascii?Q?Vk1kHyhVUNiaOFwb6HkAZmhmGJBQUlIm6aVzcHxUOgjvlc66wKPjSc88yAzF?=
 =?us-ascii?Q?RK+Ih8iizRnc8DKmFdnof+HXnmKudAauD6cgD2bp8aLFFgyU2ONPmYYVPgED?=
 =?us-ascii?Q?xJgKuwdtPWkaE6BGeKPKs72UkNQiMWxHF823TzD4HeRxSvzK29PWFCh3HhrA?=
 =?us-ascii?Q?/p6Qx1WuhphUKsrYqvdoVkSjIL2fC1pcZLXiH5XQ6E7w+RgVnV4auikTcKap?=
 =?us-ascii?Q?cxgoS/lucSGM+ZvmD5agPk8kkPJEawv2ETW7JTrUHGyBPpuP+Myc1KoH+EZ4?=
 =?us-ascii?Q?f/zDB7jJ4JBmobBfDpNgNZ37mVA72HJD+LGW9NtdD/ti00nsdOznH2R9U/Xa?=
 =?us-ascii?Q?HTTJMtUwkdg2nkzqqhjVzKOoS1ELg4G1A2OmsgQ6+rO8s6z1IdHRHtKonaXe?=
 =?us-ascii?Q?A0lmR+htpLFC1Ta4+jKoVeR0TBVmLQjCk7XNf2lKsTl5mnnB+3I4K9NCVc3k?=
 =?us-ascii?Q?zUQZokqOCXLCukOBTrmgcmpWu6PLMNLLHqnCFd/WjVS2l5ZDB4n6t6VLcPTI?=
 =?us-ascii?Q?VB0TDJ/+DbPXPMzCnuKENwZ26yXzJIu7z77DsIXjHENDP6WmJq4sCw=3D=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 04:58:47.7974 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06431fc6-f7e1-44e5-7384-08dd5ba26a0b
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP195MB2480
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

This patch series syncs the phyCORE-AM62Ax feature-wise with our other
K3-based SoMs by adding SoM overlay handling and capsule updates. It
also introduces support for USBDFU boot and includes various minor fixes.

Daniel Schultz (1):
  board: phytec: common: Add phyCORE-AM62Ax

Wadim Egorov (12):
  arm: dts: k3-am62a-phycore-som-binman: Provide capsule nodes
  include: configs: phycore-am62ax: Define capsule FW names
  configs: phycore_am62ax_a53_defconfig: Enable capsule update
  doc: phytec: k3: Add a common part for Environment and EFI Capsules
  configs: Add phycore_am62ax_r5_usbdfu_defconfig
  board: phytec: phycore_am62x: Use custom k3_dfu.env fragment
  board: phytec: phycore_am62ax: Add Network/SPI/DFU env variables
  arch: arm: dts: k3-am62a7-phyboard-lyra: Add missing boot phase tag
  arch: arm: dts: k3-am625-phyboard-lyra: Add missing boot phase tag
  board: phytec: common: k3: Make configure_capsule_updates() static
  arm: dts: k3-am62a-phycore-som-binman: Add SoM overlays
  configs: phycore_am62ax_a53_defconfig: Add SoM overlays to
    OF_OVERLAY_LIST

 .../k3-am625-phyboard-lyra-rdk-u-boot.dtsi    |   4 +
 arch/arm/dts/k3-am62a-phycore-som-binman.dtsi | 109 +++++++++++++++++-
 .../k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi   |   4 +
 board/phytec/common/Kconfig                   |  11 ++
 board/phytec/common/am6_som_detection.c       |   5 +
 board/phytec/common/am6_som_detection.h       |   1 +
 board/phytec/common/k3/board.c                |   2 +-
 board/phytec/phycore_am62ax/MAINTAINERS       |   1 +
 .../phytec/phycore_am62ax/phycore_am62ax.env  |  11 ++
 board/phytec/phycore_am62x/MAINTAINERS        |   1 +
 board/phytec/phycore_am62x/phycore_am62x.env  |   2 +-
 configs/phycore_am62ax_a53_defconfig          |  12 ++
 configs/phycore_am62ax_r5_usbdfu_defconfig    |   4 +
 doc/board/phytec/k3-common.rst                |  67 +++++++++++
 doc/board/phytec/phycore-am62ax.rst           |   2 +
 doc/board/phytec/phycore-am62x.rst            |   2 +
 doc/board/phytec/phycore-am64x.rst            |   2 +
 include/configs/phycore_am62ax.h              |   4 +
 include/env/phytec/k3_dfu.env                 |   3 +
 19 files changed, 242 insertions(+), 5 deletions(-)
 create mode 100644 configs/phycore_am62ax_r5_usbdfu_defconfig
 create mode 100644 doc/board/phytec/k3-common.rst
 create mode 100644 include/env/phytec/k3_dfu.env

-- 
2.34.1

