Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE52CCD4851
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 07:20:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ED648341A;
	Wed, 13 May 2026 09:19:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="FwnPgaLa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2892C8056B; Wed, 13 May 2026 09:19:23 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8FD784198
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 09:19:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qr7Oe57WaFrT4PkWL03fKltXRavSXv/b/mqg0LX42xaXu3alHE5NxaxQaZFzXgzQ6SpQacmeP8ewlxjBeeV0stC+AL/PTE9311SAeK0R/Hx/GS19lCye7jR6OXI0GzseIvISwy/Gl6buhlPIjrYyz3OBAkmRYIUBLFiEEjT5gpyNHp4pN1KRmhcVkVemJmUeU7o7sAGRxv3zvtixM66DYfjByNR5Gvw7zaHHLuMOscB6/CHM5EYUR2bb/lzOMg6Te1vLGjwik2hMAewPr6eUvPbKZ8WBxy3dQO8pJkQ5ts8pMFh3RvnAMpsiHC1vaIB4CRG25XSQKEdDkhDNJwLSHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79MYO86EKPPs1dhoxYMGT55lak8oMrm8B55T0yCpU/Q=;
 b=DzZo23w7+GvYddImkeEeRlSwYMKqj00FUSrWijQnSLCjHFnmCk5AU3V4hW9H4I1VShyyjMbOKfQmH3lhn1SEUImA1/CjuKrrGEbQMf+/WlT/WDnX7m2jKk1CwoQJnT8RVYTfMD2+Zm9teXeqLh6z5Gl89z6+Cxb1gMvL6SE/iFlqzE9MB1Kq/b9SgfLY7xb6ttMJhCZJuHhAglNVzW+X1SuyklqBquuCLltwBNXFIkBHQ+2Y2FmTq3jn5+okS/tqEWsQTwdXWK4YTRXybDhKswRK3ScjR0m56VI6vuh9Vudn5dZyx9s0mMwc0vhp8JfOWKwftRxk4MnvFPJeWIPLNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79MYO86EKPPs1dhoxYMGT55lak8oMrm8B55T0yCpU/Q=;
 b=FwnPgaLa9A2hR1VOWTcbwplmmFgoqYjD3dFQhkaANcBzg2ACNnUVWdhtyWDo/cRBijVkW8lA2qEtvAJWJqfyANblQkJ/kVyUQeX7rJLVZPrs/mrR3mvXZqKq4sEQVIS7kps53gEAB7DEz1ouGF0UHRdCacFgxkjhPAVuhnnqKT/6+Aqemsy13VdkQx0EHeoZgQhVMM069Pne/upEen3vWC9IY3KQtiYscwZ3xVGSbdz4+jj5tSAK/1UORJxCCv1aSofzl5NS3GQ+zhgPirkkWUm7+hwA7HsjAFkNiOx9EwFCShojZDgay7sdpCeWhPd/a3akRI57jJKNvl+6lfQA1Q==
Received: from AS4P189CA0052.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:659::21)
 by PAXP195MB1168.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:199::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 07:19:17 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:659:cafe::42) by AS4P189CA0052.outlook.office365.com
 (2603:10a6:20b:659::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.17 via Frontend Transport; Wed, 13
 May 2026 07:19:17 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 07:19:17 +0000
Received: from phytec.de (172.25.0.51) by Postix.phytec.de (172.25.0.11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 09:19:14 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <d.haller@phytec.de>, <peng.fan@nxp.com>,
 <jh80.chung@samsung.com>, <m.schwan@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 7/7] doc: board: phytec: Document DDR size override Kconfigs
Date: Wed, 13 May 2026 09:19:05 +0200
Message-ID: <20260513071905.83522-8-w.egorov@phytec.de>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|PAXP195MB1168:EE_
X-MS-Office365-Filtering-Correlation-Id: 836101fa-a06f-402a-9214-08deb0bff195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: dpqRZ7lircSTGkkygHQjjiBSIk/oVU26w1MTRrZKqAIUPZdZdVwU6p4AHZirbh69aKW1g2dLaqE1BGxVZGYqkXjkEi4382TZWNTjQpzyooMMHneBs52kJTi/pQWFqpXo9BMeVOPzy/07VoYRh35ZfxA6Mce79PlFtPyaP51c4dUCzmh3hVpGt2smQJ50E1BU/XSdYOn57NrYlZmB8oKL53Ua856XrfcwKhrQYNCmcMWNLSi4Hj6w14XIdrtGuX+6kqxM20vJlS6fTM5ouz8NF3de+Dnn33uAmA/jrdopgj7fnxiD6AwMnl4eL2hmIdjfi4XoPJzlc9cwahRyxu9G2g1aO+D9iAptBSYQfHZkaRUqZhk87nW8erJvWs/i3jm4mMbaTJhlIw8AGVoxspO5mBy8qIkQypZyxP1015nOfrXQHkZiQhoJXnyo88lGXv1YJ1JtdpA5dcC1WGc1t5iNrAnvVxgoOwN6RMxcuSK+lBbnxuV0UhFv10aWMdu9arvFlcBq29ih+15u2uM+/ZpjVIKBXtcIWk8Jh7LPUz/Fo32pLnk65NWU2AzyKHtT2GUoRHbrD6KZxfrpPM4bxJJ0C7/UfCKUmfGREzH5Ws2Frfz+OMwZnVVyyeFe7onVOaDDqvbzwcDUMitHhixK3p7kpP0x0XhC3MQ1SSfd/fsl6QNFdc9CQN1uFCfUH8Ln7TUG2b2UvtoVQ3+MA4/gceGbdDHoFvX6XglMXVyOjq27rlw=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(11063799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: s/lSHL/RC5+7lUfe8LE9wuJXZA4hKiaWpRSRCOM/zWbiHSnGveNXrwi0Vt7MN4lTT0hFfHqY23tPODa4Mv+r6DUCuRi9XFT0p8kmadKnjmEZDl0zj5fwwqFHgaP11mddcy/k0KfcWo7Gh9dIPhhlcAPRphJePrjjQItrgDBeeGtbPgcX/nLWfcFriGo6bGp+C/IRxoMHHYD97kzTvHSe/s7pW2Y6O+1viqGSpET1Kyu+i4EJaF35bmCGwTlW8wWLtYe/gcYTQtutrA6pbHiGh2xb7eYlrqQRz8D+1E3oDd0xFrXodaa56H6wjNzoCcEhWUv66NbZUMD/Mg2DBNKr+46aFLdQY00DK9poLFkXJYCM3wY1dRl2bcCJ6c8NMZKiIg4JEfK4g7EE8h0s9nPPLtQyRQ9w1jtuZm/5h7gWiYML/Tz8Tgkpo1Nuo767nRT3
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 07:19:17.1068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 836101fa-a06f-402a-9214-08deb0bff195
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1168
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

The phyCORE-AM62x and phyCORE-AM64x R5 SPL detects the populated DDR
size from the SoM EEPROM and falls back to 2 GB if detection fails. For
boards without a populated EEPROM or if no detection needed, the detection
can be bypassed via CONFIG_PHYCORE_AM6{2,4}X_RAM_SIZE_FIX and one of
the CONFIG_PHYCORE_AM6{2,4}X_RAM_SIZE_<size> choices.

Add a "DDR RAM Size" section to both board docs describing this
behaviour and listing the available size options (1/2/4 GB for AM62x,
1/2 GB for AM64x).

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 doc/board/phytec/phycore-am62x.rst | 19 +++++++++++++++++++
 doc/board/phytec/phycore-am64x.rst | 18 ++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/doc/board/phytec/phycore-am62x.rst b/doc/board/phytec/phycore-am62x.rst
index f5a0d51240a..5349ba429d4 100644
--- a/doc/board/phytec/phycore-am62x.rst
+++ b/doc/board/phytec/phycore-am62x.rst
@@ -177,6 +177,25 @@ Boot switches should be changed with power off.
      - 11001010
      - 00100000
 
+DDR RAM Size
+------------
+
+By default, the R5 SPL detects the populated DDR size by reading the SoM
+EEPROM and configures the DDR controller and the U-Boot device-tree memory
+node accordingly. The phyCORE-AM62x is available with 1 GB, 2 GB, or 4 GB of
+DDR. If the EEPROM cannot be read or is invalid, the SPL falls back to a
+2 GB configuration.
+
+EEPROM-based detection can be bypassed by enabling
+`CONFIG_PHYCORE_AM62X_RAM_SIZE_FIX` in the R5 defconfig and selecting one of:
+
+* `CONFIG_PHYCORE_AM62X_RAM_SIZE_1GB`
+* `CONFIG_PHYCORE_AM62X_RAM_SIZE_2GB`
+* `CONFIG_PHYCORE_AM62X_RAM_SIZE_4GB`
+
+This is mainly useful if no detection is needed or for boards without a
+populated SoM EEPROM.
+
 .. include:: k3-common.rst
 
 Further Information
diff --git a/doc/board/phytec/phycore-am64x.rst b/doc/board/phytec/phycore-am64x.rst
index c6677f6a440..20887d443a9 100644
--- a/doc/board/phytec/phycore-am64x.rst
+++ b/doc/board/phytec/phycore-am64x.rst
@@ -175,6 +175,24 @@ Boot switches should be changed with power off.
      - 11011100
      - 00000000
 
+DDR RAM Size
+------------
+
+By default, the R5 SPL detects the populated DDR size by reading the SoM
+EEPROM and configures the DDR controller and the U-Boot device-tree memory
+node accordingly. The phyCORE-AM64x is available with 1 GB or 2 GB of DDR.
+If the EEPROM cannot be read or is invalid, the SPL falls back to a 2 GB
+configuration.
+
+EEPROM-based detection can be bypassed by enabling
+`CONFIG_PHYCORE_AM64X_RAM_SIZE_FIX` in the R5 defconfig and selecting one of:
+
+* `CONFIG_PHYCORE_AM64X_RAM_SIZE_1GB`
+* `CONFIG_PHYCORE_AM64X_RAM_SIZE_2GB`
+
+This is mainly useful if no detection is needed or for boards without a
+populated SoM EEPROM.
+
 .. include:: k3-common.rst
 
 Further Information
-- 
2.48.1

