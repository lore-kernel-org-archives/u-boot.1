Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3C3C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 10:35:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7664A80ECD;
	Wed, 29 Jan 2025 11:35:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="HSTldmFB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF2A380EEF; Wed, 29 Jan 2025 11:35:07 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2070d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::70d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A57AD80885
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 11:35:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIkdIMkWK3tZvd3L2g6lbfQEozh0D/bgIrgdPLA1IPdJYdR4YNQ1DvGJoBpEliNfnCIw21ivQmkoPuQUsGchl12x6SX8y+titjbMIs7KhhZWT2pTppBUtld6P1pw6H9hCAd26X5h7irA9UB0f7jAP5DKkVGouYqrSoJmC4PNEcbGweYOhhI9SHWFa7VuqNFMR18GURYDePBTrh5eRC9fIAy9Uv2wrlOCKsQzkGniDYvxayBmdauwDzaW/rYhXylFE9ypQUjcf8wQgNXs6TZAAGDBF4kR+0n7fYECbnloJ2zGEN34azKyrosbgk4Du63+UJcUWUlWKDROQNb2I/EsVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oqv2SzAuebP+thEgxr4vCTCcVNNixH8xw0J6Qnd0RJw=;
 b=Ip/zio3W6HArsl3Mf0wVPfN59iXH5TnLSPvMga3cs83a2uif+cer+GRIBiAseDrwLRF2l2lWm15AcHHjEZSC6Kutsk17JLww7J120KFQ9NbQlsSiEf+EBUZaTXcZqPp0TTf6uJiDOc93esng3SkFx7vt5I2Mk8yvy2Brx2BX80HdFSiEXGccucKIswXL1ujuoKF7483DGrXz9yc2XIN6ujXfOS4Z4R0qS3Oj5FELyHq/t0JIdnM3bqfFbUy8pqWevkZ1vK5rFyhqSpuSOnzPLMTfbyuIu9BsxAlYyE7aWrtuHaXmZzcdCG5cTuEQkMynbtC+qve+EyWIwfuBpQZ04Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=ni.com smtp.mailfrom=phytec.de; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine header.from=phytec.de; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oqv2SzAuebP+thEgxr4vCTCcVNNixH8xw0J6Qnd0RJw=;
 b=HSTldmFBHfMlF0nF3GxsJHKiS+Tgk1MVy3ua7xIGl0AkzidmFQHHqXoyZNPiQk/e8rFhj7r7lvTo639xUvdoSBMqlA1B0dEU/HIDdTVcR1Cdje/1UCEedvR79GPldGnN9nz3GXmmwry+XxM6quENlXTd2C4PgQ1UpnLDsBAStvfPSij+G6tE1jl/50f/VU8OZP2LKY+y8HICphU9qTgbLVQ4EqNkF4RthnDRTuDEw3HPx1fal1tRCeJ96/BqGWvprZE26GxYbtLYk7MP9Il86M2y8vn8LdaA52HmO1Iv3XbgVyVthL9v59/n1hdafYYZ5cYnQm+ZiK0Tn09b6cnL2Q==
Received: from AM7PR04CA0015.eurprd04.prod.outlook.com (2603:10a6:20b:110::25)
 by AM9P195MB1332.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:38a::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 10:35:01 +0000
Received: from AMS0EPF0000019E.eurprd05.prod.outlook.com
 (2603:10a6:20b:110:cafe::2f) by AM7PR04CA0015.outlook.office365.com
 (2603:10a6:20b:110::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.23 via Frontend Transport; Wed,
 29 Jan 2025 10:35:01 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF0000019E.mail.protection.outlook.com (10.167.16.250) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 10:35:01 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 29 Jan
 2025 11:35:01 +0100
Received: from ls-radium.phytec (172.25.39.17) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 29 Jan
 2025 11:34:59 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <joe.hershberger@ni.com>, <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <w.egorov@phytec.de>, <nmorrisson@phytec.com>, <upstream@lists.phytec.de>, 
 Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH] include: env: phytec: Add optargs to K3 files
Date: Wed, 29 Jan 2025 02:34:44 -0800
Message-ID: <20250129103444.3463044-1-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019E:EE_|AM9P195MB1332:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c5e2dd0-39e1-42ff-bc8b-08dd40509615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f0txN6R+GcgUeSztu36a77xOHretDBYg01s/yH6c52lVIxq0DHkG8Yy5FHwN?=
 =?us-ascii?Q?+q12R4uR3yMXugvpzLekszdGrdmL7KU5q8nPX0MJUSd0wPM4u7LKvHRZ6MpB?=
 =?us-ascii?Q?m+HMvnjQu/z2yFM2UXj51Rg2bZn7/7WztVlE+DJZqxOuSxnpqIIiI+GsSUOi?=
 =?us-ascii?Q?pDxE/Gb9fdHCQfTMcnRrmq6B4UVytkMz6sUamsmDchWq2jdrqVqBMBnbzFQO?=
 =?us-ascii?Q?6tTLn+pfJhSbYa/w0F3KU64EbpV3RfdyadN4ThPTngcrjitBe6148rZI4Yrj?=
 =?us-ascii?Q?uJJ4fWoEeV6n2xm1A2y4nbCc5uTVnh3dDTjmdRKyZ5laOd9KP34UFe75vUAR?=
 =?us-ascii?Q?GBZwT7FNZXJd8zeM8i/D32y8+92fvw0FJcVublxm5RvMpnCtie9cIo29Digf?=
 =?us-ascii?Q?L4T04undXwGuYlycZhH23MO14J+Pxl7Is6qf7nBHhpDgJGbIJfEv6xC86S7b?=
 =?us-ascii?Q?zYiC1z3bLlNGOIqHalpaiG8BDzpOutQTLN5wttsMEIZPXjVdhXMFDcwz25+t?=
 =?us-ascii?Q?NGayXrWASwMdK5IF4kBeFwWENvftVq6vK+wy6FST2YMrwQ+86RF9Tm/BjmkZ?=
 =?us-ascii?Q?COXRPlp/+WD3vYKVGWgiYolH3n2aE2DfVGjLWqpaHix3xU47eLhoMIzMYbww?=
 =?us-ascii?Q?WsPq8OpHaO6gmD1VgxMDSoQExdZU34QsDeFOdd6qYQz8wr7hKjmUivx14Ts8?=
 =?us-ascii?Q?IyVMQJZD80wh5EJV0Qu5nLSF3ngB52uQuH9RSkHGdxO9YBTFNuOmd3EOipDr?=
 =?us-ascii?Q?5fNX1dMuL5bmRXbq/niHIwlrm83sVMSy9VoNZQ2p+7lqmN29YU3mffzcMt4O?=
 =?us-ascii?Q?LyGgHK8ReSPgyH0CmFpCsVHnjOmfSVv3aVnZNRLPYS+wZaSv65jsYUKU5zHJ?=
 =?us-ascii?Q?ypRrHIX26RzWOyy1t6zEracpQ8hzQl4GWh946yN8Fpc5a+hDcogAPTRde8VJ?=
 =?us-ascii?Q?ZD4lAci9xqrdJn0BnLDiNZKom9qYIlcqdw5VKKC/QsrElos4RNdPC0DM79Dw?=
 =?us-ascii?Q?jvtxYIY2yC0lupYIHXJA+dD6ayzFqed28BHGd8j5X/pEKEzH0stXGjeMyxmF?=
 =?us-ascii?Q?PQw7+SwUgtgNlzRKQcA1vewsQ/h7VkPlKBevGxP/J26SnmeT0pKHL8ZIg6Iy?=
 =?us-ascii?Q?QTVegGB/UQ0w+TeiZxz/qvqcNuVOUJp2Eb2bQ1xBOT480Fz13xcQurb1dVBx?=
 =?us-ascii?Q?od7Y7k6iz7kg59kvZmnWDyQNhs9J5/4cqH1bmiKdwDUZ03fCnsKTy3DnjKmF?=
 =?us-ascii?Q?oVUAy1lDeRMO5SqtYv6tF8aX4nUJC4G2uA7hpkny4dwWnoztQuJ3T6Klob6n?=
 =?us-ascii?Q?ZfoBaodJnjaPC+HzN0X1+IPohTE31kmYQncIyWyfn9U4mop48fhLw23Gv5Hs?=
 =?us-ascii?Q?U1IHz7Cad8dW4HJWPClVJMtc5KBSoUKYoHddoR4Gct6VPpzMsnzXI6dy+mtm?=
 =?us-ascii?Q?HY7GLejOYdbTV9BS56+KjE2jJXLXjfZIcFReAD/jdcaY9vUvZeoYANxjDCTm?=
 =?us-ascii?Q?fXdPrNQI8l7fpuE=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 10:35:01.5734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5e2dd0-39e1-42ff-bc8b-08dd40509615
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB1332
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

From: Nathan Morrisson <nmorrisson@phytec.com>

Add the optargs variable so that we can set optional arguments while
booting.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 include/env/phytec/k3_mmc.env | 1 +
 include/env/phytec/k3_net.env | 2 +-
 include/env/phytec/k3_spi.env | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/env/phytec/k3_mmc.env b/include/env/phytec/k3_mmc.env
index ad8d3a8b764..3f67e312f65 100644
--- a/include/env/phytec/k3_mmc.env
+++ b/include/env/phytec/k3_mmc.env
@@ -11,6 +11,7 @@
 
 mmcargs=setenv bootargs console=${console} earlycon=${earlycon}
 	root=/dev/mmcblk${mmcdev}p${mmcroot} ${raucargs} rootwait rw
+	${optargs}
 mmcloadimage=load mmc ${mmcdev}:${mmcpart} ${kernel_addr_r} Image
 mmcloadfdt=load mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
 mmcboot=if test ${doraucboot} = 1; then run raucinit; fi;
diff --git a/include/env/phytec/k3_net.env b/include/env/phytec/k3_net.env
index 377e406688d..8ad1cb7b0c2 100644
--- a/include/env/phytec/k3_net.env
+++ b/include/env/phytec/k3_net.env
@@ -9,7 +9,7 @@
 #include <env/phytec/overlays.env>
 
 netargs=setenv bootargs console=${console} root=/dev/nfs ip=dhcp rw
-	nfsroot=${serverip}:${nfsroot},vers=4,tcp
+	nfsroot=${serverip}:${nfsroot},vers=4,tcp ${optargs}
 netloadimage=${net_fetch_cmd} ${kernel_addr_r} ${serverip}:/Image
 netloadfdt=${net_fetch_cmd} ${fdt_addr_r} ${serverip}:/${fdtfile}
 netboot=run netargs;
diff --git a/include/env/phytec/k3_spi.env b/include/env/phytec/k3_spi.env
index 97d3a157058..8e9cfce3b4c 100644
--- a/include/env/phytec/k3_spi.env
+++ b/include/env/phytec/k3_spi.env
@@ -6,7 +6,7 @@
 
 /* Logic for TI K3 based SoCs to boot from an OSPI/QSPI NOR flash. */
 
-spiargs=setenv bootargs console=${console} earlycon=${earlycon}
+spiargs=setenv bootargs console=${console} earlycon=${earlycon} ${optargs}
 spiloadimage=sf read ${kernel_addr_r} ${spi_image_addr} ${size_kern}
 spiloadfdt=sf read ${fdt_addr_r} ${spi_fdt_addr} ${size_fdt}
 spiloadramdisk=sf read ${ramdisk_addr_r} ${spi_ramdisk_addr} ${size_fs}
-- 
2.25.1

