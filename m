Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0213FCD4851
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 07:19:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E4F5836AC;
	Wed, 13 May 2026 09:19:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="SrLpnOl8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A3FB845E3; Wed, 13 May 2026 09:19:20 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F0F68056B
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 09:19:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5ZEVQSbbmr32izPm0/4Rb4Sr8NrLscBG1U2wtS85xM8Zswo/RxEQLEaQwqnesq0Zfc7uQJW+xQNm6n4hmaxe/W8z8qAR4AmB5XlH3kvcr5J2vjxNfTd/8yYc6iBCse8W6AmBK4foDXXqzFcjYsJnYEMK/7NLfc6RoS9btbz3uqqQdyX+kPV328HtnNMtl7aOhk7jcGMSukChTCRR7fgm3AgwoRIUo69a2RkfORKU/sAcAlgTe7PAB7nf4qvmzMVNIRGn+hvNTJYfm4B735ypwTSeyJvqumTZjs+8HUTDYV9e77yDsfQzOwZdYgTZDl+GSEXCboqCJf7PEGjNHowZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VAwFITfAo3G088FrBf5BxNUu1cwtfLwGl/CuKTI/KU=;
 b=plezgytVjIFL+LJef9UMOrFFJZjV8XUZfP2Pbm+kyms9s/Gvam6Z1aaJ6ohH+FHGHTAgDrlQeQvDLqtet0A8IQIoNLl0ADRRrKU0l4kHiJcujvB3VuUS1qPnYPFLdKzr0kdmKaeuI25TKxEWH5OFBszqJwex/nEAZZuEgIjr3OL3HH1+GCmhH8rnzuY89S8h4qAU1c4Pci8DQ1bvDpwfB8niCdnI0dsJtfT7Y5NSYxXJCQRE/ueTNFIdkbQoP6ZAFhxQI9CdUBfLnkH+TMcPzD5OhEkybgRcWoTuMggu8ZV2w/LX5dNy6aeHN600pViDj+vY36KeMK0+hM5lYLONgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VAwFITfAo3G088FrBf5BxNUu1cwtfLwGl/CuKTI/KU=;
 b=SrLpnOl8hROXVx4I2FZ7gerYtYbv5jl5lJB9+n3NVkgGzrbNGFE48ri6X+hEZbpV+eA9GDPkb1kTdQ+KfgKw09cEUySaU/uQ1btsrN5j750VoNWHZ34nfg5EZhkbm79BiLDKPUk+SN9Jq2zWvMjG/Lx0PS7IeUxLhbsEhEmbUBoDfNnCo0/TJj7b2eI1YGscSyvsYRIt4mQIH7YSkf2WsQvbEGLESw1VIQSiQJDwU2UZODEXJsHIc52A5ypzYdvh5pI5wbvg7ibo4hoehANx9BhhkKQFQZgVg1b+lZjSGLhSqzz/6+7UVbjHgbWwAVMX/cpbhMlbr41fuFaYb3JqlA==
Received: from AS4P189CA0059.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:659::29)
 by DB9P195MB1635.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:37f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 07:19:15 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:659:cafe::86) by AS4P189CA0059.outlook.office365.com
 (2603:10a6:20b:659::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Wed, 13
 May 2026 07:19:15 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 07:19:15 +0000
Received: from phytec.de (172.25.0.51) by Postix.phytec.de (172.25.0.11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 09:19:13 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <d.haller@phytec.de>, <peng.fan@nxp.com>,
 <jh80.chung@samsung.com>, <m.schwan@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 2/7] arm: dts: k3-am625-phycore-som-binman: Enable tifs-rm-cfg
Date: Wed, 13 May 2026 09:19:00 +0200
Message-ID: <20260513071905.83522-3-w.egorov@phytec.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513071905.83522-1-w.egorov@phytec.de>
References: <20260513071905.83522-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|DB9P195MB1635:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e766dad-e8c5-493b-429b-08deb0bff06f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|22082099003|3023799003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: luAqBi/IRHVeAH4xlkpvuu+qckywBD59qaqhKoCv5uGAlJjCsySu+jQKIZXomfhr3VJ2POZeZaqUkGqxzl4qTm2PTzgYDDs8Ca/IA3SwXT7VT0a2TzuFvUC/ZGXyYfI7Hc6eA/vhp5PQ772xDjJmJalPryvDrnHbeDkLVOmhP3Lfa8DxUS78fZ36ItlCCNuyMsdxquJj1Iu7NwqlLYmrX3qnnUpn8GBMmPKLhFk+GSqvvxUzyS7flnCEy1CRUodJE8PidydoYZTVFyDRZNmWttuc9ISelz6f4HrypY+kCKo+HwGi4egXVzd8hPGNCvxt9inLODKctlypTRRPrxSaEQ9oiZYhlupfjpkvAJh3dPeQWh1zDp/j+wTb5IUByIlievkUEZxDsFHjnb0MKHA/URcqRu7Xkq7kV1f6cZs7sIeg37H3Q1JB0jURZ1SZA2sUqPMDCgLc9M7azlyk2PIsp/AkJzwX9TGhmpodE2zzT80e2fHHIQsR/j20ZYJHm9Nlx/YH5UhNtJy+8I/CppC3kaNNemNEMAtAyik8BBoCSAE2tT3zy5I0MQCcCNpiOnr7mzOxLTDaRnY6OBNVRi83/CBwhHdwTg5DdAjBZQRmk+WM56o3kA7UnGJPiEXtD9FfRwth/1lfUcLTvedIxDtveuexATE11gC9V0Nv6AyjewezIFXfv7AQgVWRZrDEjDYwSzXqMpQXQe66AiYA/BTuyEbBItGhAYJQH6Tv3lFnZFE=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(3023799003)(56012099003)(11063799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dw0tJlYUC7R59RhxmOw9W2na/KKsUaEVF6DB8AuSvAaSWS+YRjPNDmJYlDEGBhalmIQRwVRII3Ewrmh3vk81GD0wCTqEIkXcOFlVeK+/9RuKANo+C2diLj6vggqiqepsaV+NhPj9BO7czM5NWHgEBRwUCwfFgtmeaxJNb10iSW+p/hr+AiNnGA7VXVqNn2wmJij5yRmP7SGiMrrIDoJRpj4htJ36yl4bQQiuCgbp0MH6eMJLQ9JCd6Xu/bJ8vBCUwrhhpfh8BUWEopoXgzJXjYjz5PvKal5ySOUvoYgy0hzlwP4RtZ+3zd/9v+XrJ72NxuwBTKY5SVLcTkXa9DOAxLrQGG1OVjPaqsDztbYxYygab/pPYO1OW6TB7tgllm8r7XK/ypLoMxTdWFw1uinOLeGgipKoc60NCBX0JiulZhLkg/S4ZP/mrbX3AV4WokZt
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 07:19:15.1785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e766dad-e8c5-493b-429b-08deb0bff06f
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1635
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

Add rcfg_yaml_tifs node override to use tifs-rm-cfg.yaml instead of
the default rm-cfg.yaml for the phyCORE-AM62x SoM.

This enables binman to include the tifs-rm-cfg.yaml configuration
when building tiboot3 images, bringing the phyCORE-AM62x SoM in line
with other K3 devices that already use tifs-rm-cfg.yaml.

This builds on the tifs-rm-cfg file added earlier in this series.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
index 5e777a1f305..0499c719396 100644
--- a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
@@ -9,6 +9,11 @@
 #include "k3-binman.dtsi"
 
 #ifdef CONFIG_TARGET_PHYCORE_AM62X_R5
+
+&rcfg_yaml_tifs {
+	config = "tifs-rm-cfg.yaml";
+};
+
 &binman {
 	tiboot3-am62x-hs-phycore-som.bin {
 		filename = "tiboot3-am62x-hs-phycore-som.bin";
-- 
2.48.1

