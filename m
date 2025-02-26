Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DD1C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 21:05:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90E7581109;
	Wed, 26 Feb 2025 22:05:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="fjC8zCxK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77984810F6; Wed, 26 Feb 2025 22:05:18 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2070d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::70d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 677A280FF2
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 22:05:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZQw5akS6ypNdGFUU8vT9PL7p9jGXd4ue9HuLPV5auTnfTJryl7LFcOIufJ9MX6jMBE5IP62NMf2r2gaLOO8KgiLWRsC6yJvm/aGeRL+YjXNR35BC7GkHgsLeE85ZV++c9P39Zm5/58EAYqklL9eTOt4u30xthtaD1AdZrgG9h48h6Nqm+FdxT0mmhkY3dhUNkIRk8qvs06XrgGOuxQHwJzMpiACAvUmfZNbzmOcSNCzmbfDWV7aXRpqS4RoRIYEhA0L66yB3y4QoS+UfZhZQfNVbg5989vNxus4Kt2BWxb9gQsn8KhxMeQ0yUy7I193Ki5Qgj7oW5vB+w67/YOFmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWVXEpSJOzVWuey+nUtvuYy8frrQISVfo0wi3LZ8NLo=;
 b=fjJsuvbC8K4MyJpaKDZkWTxWsNLyRsqS/GIND6/C/GvtUOa6A4Ji9GsfEsYgMdCDmkDTaP8SjVNPxRFFhBMI7j8y3eIs+iMbH/YAwYEcnjsuIv+5+hG8QIrPDUz9wMk33PjseexZjQU26IrwyJJp8z9Zvl/PLw71ewnNna1q5vBgMfNFjxJ6TSjMmjxgbsR148sFqOCFoAHYWoeYfEpgFm27Gr+Ur7RYFojlCt4XC/shQWtzURNf+9rjrX9csCT2Kqk84wmUJ7Slv1HQGuv28Q1RaBhKYXNvsydS65rNIESXYByIeMUkr9HQ7nzkBEnNRE6eAu9BtLuPLBXl/bz6og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWVXEpSJOzVWuey+nUtvuYy8frrQISVfo0wi3LZ8NLo=;
 b=fjC8zCxKrqR5bVMP1FS+RuT6TOQ+VjoVVS5+E2CttlesGSnjwJeXoh63//6npgdgfmmVUD5/qihCoI1UF966OiFHzaMjbpGmsyMjrCxQCmOKcAyc4c5jgaT4hiKsS9zkSHw3o4uK4L8ge7M4yMuEEqQCGFvtVzphboOPV94Vuez1Ftg/YDHAgJ2fQnEvolYJC2V/E2DnBkWXFNVwoOoTnyXQ7rqG4o7E6Qy2g4t5ZpKi0fO648pHV1I2Kr2Pm3gU/3KsUw92nCGK1U2l616ouUW9uMfzL7jQi+lyeZ2D/vDw3NkXRTcOYnE/rYjvta+FS4+brBXsMzDZI9WJvwWT2g==
Received: from DU2P251CA0026.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::28)
 by AM9P195MB1379.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:3a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 21:05:12 +0000
Received: from DB5PEPF00014B91.eurprd02.prod.outlook.com
 (2603:10a6:10:230:cafe::91) by DU2P251CA0026.outlook.office365.com
 (2603:10a6:10:230::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.19 via Frontend Transport; Wed,
 26 Feb 2025 21:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB5PEPF00014B91.mail.protection.outlook.com (10.167.8.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 21:05:12 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 26 Feb
 2025 22:05:11 +0100
Received: from llp-anderweit.fritz.box (172.25.39.133) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 26 Feb
 2025 22:05:10 +0100
From: Leonard Anderweit <l.anderweit@phytec.de>
To: <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, Leonard Anderweit
 <l.anderweit@phytec.de>, Marek Vasut <marex@denx.de>, Tim Harvey
 <tharvey@gateworks.com>, <upstream@lists.phytec.de>
Subject: [PATCH v2 3/3] binman: cst: Build from source
Date: Wed, 26 Feb 2025 22:05:01 +0100
Message-ID: <20250226210501.72794-3-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226210501.72794-1-l.anderweit@phytec.de>
References: <20250226210501.72794-1-l.anderweit@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.133]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B91:EE_|AM9P195MB1379:EE_
X-MS-Office365-Filtering-Correlation-Id: 09a5a277-5681-4639-3fc8-08dd56a942d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zL42+huyOcDQeR+SNdE9X+36TomeQwEgIsE4Gw4RedTRFeqB4fO4tZhaEli8?=
 =?us-ascii?Q?imS2cNmJ6n3Fr84xq47TXPRTKOAUyUTR3s6En5Zcuz9raruUCE/4A/8cKXVI?=
 =?us-ascii?Q?4njnaTrWp0iQ1Hq13AQ0IVouwtg9lchffK8kbjfLePP7VCkoOKWXci6E1s3a?=
 =?us-ascii?Q?YHRzh1sUTJbc7KXVbAZb3mk9t70E6rvw7qvBxRC+bzebmJjK435UN+FpTsiJ?=
 =?us-ascii?Q?jNX17GHqrHkGy1l9GQSJv1i+h5HU7sNdPpaJKSK6iVorqEywId3ndHtidsR8?=
 =?us-ascii?Q?MlBPDGxu5uS6kHwP8unRj8XTknJcMkO1nYvfq3iyTtb8LEW/YU6PVVTQawrw?=
 =?us-ascii?Q?zJ5pGst0SZB+K9UC7khA015BjPh2/b9rqvK5/M1stEXW/DVT7v8KLxY5qzOd?=
 =?us-ascii?Q?j1Ed6eC+4ZQN6Y/kUg+0ezGDJtc1TOys6Erg9cRFpqKP8KgSO7wGkuKS+Md6?=
 =?us-ascii?Q?Acfyf8rcUQE2Rs3tNIvOcBglg10oq1fdkv4IzyCNHOIM8HaluHrflNCutM9d?=
 =?us-ascii?Q?q27od4xEm6bRsiFgCyQE3GSrglzWdxBBojTt9objSry3EClhCopsv17/iJnX?=
 =?us-ascii?Q?ki2MY06XWT4TpDNT6AeGFp4gXGFEmOAF69bYFeIMzHD3jtKAR4LXXlWWXtUW?=
 =?us-ascii?Q?NMmN4791+ULOFLPCQJu8owpWAJsHEYGrpUHy0qfHm+GyErFBezdB6uRIbfIO?=
 =?us-ascii?Q?xDlcF/ZzD5LPJJ5hnPVMRWVIiRgVR6F+B5nomyPWHXfr5zvAdhnpBTPINefy?=
 =?us-ascii?Q?09t34wRGjXTqICfuE7blmaPkkxFGGHrLomYWAS3X5VA019WSmEpfopjo2jJy?=
 =?us-ascii?Q?DXBt4llboGjf5yFkXefLXD/nYQaTN/H0uzrNN82Ir+1KDd1os8tPOW+ZC/O5?=
 =?us-ascii?Q?KSRLr2jIp7ySb9dOCNWSRNoWnh7zq+oIGKrlSYYEo5Ojqg9D99f1AxW2Gpr8?=
 =?us-ascii?Q?AxezJV1wyObm6A1h7UpXZLgKTZ5gAenMTkOA82Pay1q4krchSMHqHE5knqcl?=
 =?us-ascii?Q?tnzfabdaEFv26+8EFk6r5e31Oe9Ys/gzCusUC2T9VYZzGvmWuWNJiScfxjJh?=
 =?us-ascii?Q?/D2gz5vmmjvdTU5I9gMk9HGP4ScZWWunO8I2vIms9zs0eXIEC13ojZCs0x5w?=
 =?us-ascii?Q?CefsGRmTEKeYExFgHDZZNoyGGHBOvJhfHtO8blv+IdhFtyTOrvCckfAR+fmX?=
 =?us-ascii?Q?1NRQbv35VFAM6NA1iuXFy37cefVLKVPrlaYQdp1GYSwpjMyi+TEimO5itT5u?=
 =?us-ascii?Q?BX54PE+t2VQlsbsuY3vf9x2BZpDMU8s5jdcmztjhV/jjTBh7tXz3uwxMbqWB?=
 =?us-ascii?Q?OWXmYLXyTIgkrvPxfoU9J6ZUUUlelQg6eb46Hm5u3xEfae+8pTQz6w9qWhdJ?=
 =?us-ascii?Q?4ZGMiNR4PeJhv6Ao5lfesKs14n+SWGtwdiehLeuWz53PgoLeXYGNaoWHv6mH?=
 =?us-ascii?Q?2ZhtxKVI8hE=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 21:05:12.6521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a5a277-5681-4639-3fc8-08dd56a942d4
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B91.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB1379
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

Build the imx code singing tool from source instead of relying on the
distro to provide the tool.
Use the debian/unstable branch because the default branch is outdated.
The binary is supposed to be build with docker, work around that by selecting
the correct Makefile directly.
Also append the description and add a link to documentation.

Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
---
v2: add documentation
---
 tools/binman/bintools.rst |  8 ++++++++
 tools/binman/btool/cst.py | 37 +++++++++++++++++++++----------------
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/tools/binman/bintools.rst b/tools/binman/bintools.rst
index cd05ad8cb26d..9f6cab544a5e 100644
--- a/tools/binman/bintools.rst
+++ b/tools/binman/bintools.rst
@@ -52,6 +52,14 @@ Bintool: cst: Image generation for U-Boot
 This bintool supports running `cst` with some basic parameters as
 needed by binman.
 
+cst (imx code signing tool) is used for sigining bootloader binaries for
+various i.MX SoCs.
+
+See `Code Signing Tool Users Guide`_ for more information.
+
+.. _`Code Signing Tool Users Guide`:
+    https://community.nxp.com/pwmxy87654/attachments/pwmxy87654/imx-processors/202591/1/CST_UG.pdf
+
 
 
 Bintool: fdt_add_pubkey: Add public key to control dtb (spl or u-boot proper)
diff --git a/tools/binman/btool/cst.py b/tools/binman/btool/cst.py
index 30e78bdbbd9d..8a3981adc890 100644
--- a/tools/binman/btool/cst.py
+++ b/tools/binman/btool/cst.py
@@ -12,6 +12,14 @@ class Bintoolcst(bintool.Bintool):
 
     This bintool supports running `cst` with some basic parameters as
     needed by binman.
+
+    cst (imx code signing tool) is used for sigining bootloader binaries for
+    various i.MX SoCs.
+
+    See `Code Signing Tool Users Guide`_ for more information.
+
+    .. _`Code Signing Tool Users Guide`:
+        https://community.nxp.com/pwmxy87654/attachments/pwmxy87654/imx-processors/202591/1/CST_UG.pdf
     """
     def __init__(self, name):
         super().__init__(name, 'Sign NXP i.MX image')
@@ -29,20 +37,17 @@ class Bintoolcst(bintool.Bintool):
         return self.run_cmd(*args)
 
     def fetch(self, method):
-        """Fetch handler for cst
-
-        This installs cst using the apt utility.
-
-        Args:
-            method (FETCH_...): Method to use
-
-        Returns:
-            True if the file was fetched and now installed, None if a method
-            other than FETCH_BIN was requested
-
-        Raises:
-            Valuerror: Fetching could not be completed
-        """
-        if method != bintool.FETCH_BIN:
+        """Build cst from git"""
+        if method != bintool.FETCH_BUILD:
             return None
-        return self.apt_install('imx-code-signing-tool')
+
+        from platform import architecture
+        arch = 'linux64' if architecture()[0] == '64bit' else 'linux32'
+        result = self.build_from_git(
+            'https://gitlab.apertis.org/pkg/imx-code-signing-tool',
+            ['all'],
+            f'code/obj.{arch}/cst',
+            flags=[f'OSTYPE={arch}', 'ENCRYPTION=yes'],
+            git_branch='debian/unstable',
+            make_path=f'code/obj.{arch}/')
+        return result
-- 
2.34.1

