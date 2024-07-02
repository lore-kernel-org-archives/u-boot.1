Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD76C2BD09
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 01:15:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B1CF886C3;
	Tue,  2 Jul 2024 03:14:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0tUHQslT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF377886B1; Tue,  2 Jul 2024 03:14:57 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D24D884C3
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 03:14:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Sam.Povilus@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NilhKtp21D4r6/OK5ySpFwWiRUh+QovhII856pgx2xGWlv+clKhB+2fZPDcevRnipz16xw8fqM39Z3/sR6UKX7k8i6EoKnJS42js6iO/8q7l52o4QTuRXx/a+lxj/z0I+dEaI/yypmkSBH30E8qJFz3eQ6TC/jiW4OlmL9cTpzk4MCuhtOvxu2t3SX/6+2BC3DWfWkJLjjKxHStkIEeJHrMvmvpg4uvxG1DZW64ZH9/d3iGSI7IIiaeCimO/qdfrtWerFdwCdOIV+jiqj9A5eHWNPwIqCL0IyrC7dM3fDF4HngMOTOjlK+lgcAepMut51fKO/Y7bNHzp+JYQKR3Idg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eKHCTIHl4m67jyRmeGIEglHxPhe8XwafzznzqkUKzk=;
 b=d2EpHlOfjbtG7jAS1qZ18SCEGqbc/N3drrKO0qSh4Ox1LitaRG6/giY4vLXEDmbFSKs7ftaBSnDjc1EG3EEilV/FWEcyj2xId041yH8B+vVRB+F7jbZbBz92vDQA28RJ3vRigqMtY3Hgvo3fFPsHqMKuiY4VwVCzR3TKMqAuCG7aMS1XKcKAaQjvKuZA3E1w5Hj/7LA0TEXv68W+51gz9LPj5nclOBW5gMXYOIHPEHvGJU9N+qSxYIO1vM5IQiL5wY+DBFVH64WNNY57BppVuU2d0oWCzt3sm7WwMCXAAT/IeCqP3wheYG/Ov0zECr4CMyifgzINf3ReA1AgCEdqSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=konsulko.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eKHCTIHl4m67jyRmeGIEglHxPhe8XwafzznzqkUKzk=;
 b=0tUHQslTs/imHNAyKBF3FS+q6YtzZ+TtOdUi1+pMaYMYXjYLBdIz55QPn8AiqmBnsbkRI7f6OgFg6xiiLeaYbjh1dJdlZEwO91RYrdkyImpZMkjJMqF5t9mVTOolG7wTNO1aKJkODKSQArirYM+u6feqL1Wq42cBifCLDy6NccM=
Received: from DM6PR02CA0130.namprd02.prod.outlook.com (2603:10b6:5:1b4::32)
 by SA1PR12MB6870.namprd12.prod.outlook.com (2603:10b6:806:25e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Tue, 2 Jul
 2024 01:14:50 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:5:1b4:cafe::28) by DM6PR02CA0130.outlook.office365.com
 (2603:10b6:5:1b4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33 via Frontend
 Transport; Tue, 2 Jul 2024 01:14:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Tue, 2 Jul 2024 01:14:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Jul
 2024 20:14:47 -0500
Received: from xcoapps69.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 1 Jul 2024 20:14:46 -0500
From: Sam Povilus <sam.povilus@amd.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <xypron.glpk@gmx.de>,
 <u-boot@lists.denx.de>
CC: <sam.povilus@amd.com>, <git@amd.com>
Subject: [RFC v2 1/2] doc: Remove FIT documentation that is elsewhere
Date: Mon, 1 Jul 2024 19:14:39 -0600
Message-ID: <20240702011440.2888308-2-sam.povilus@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702011440.2888308-1-sam.povilus@amd.com>
References: <20240702011440.2888308-1-sam.povilus@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: sam.povilus@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|SA1PR12MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb2c4e5-0dbd-4c1e-cbd3-08dc9a345f1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGlVcXduY01DbkYwc1NFVU9jZGN6U1lWcEpweVE5Q09kbHlPbHV6cm9oQmY1?=
 =?utf-8?B?Qk1xT2F3cXowRmJocmhPRkt1TjB0MitOdnRuUzVHY2pJK3VPVkVhTThHT1lI?=
 =?utf-8?B?M0FSc3lOWnQybU1yRzVLZU1ONjhiZG5NTmQxcVdwYXFzcjdyY2ZBaVo2Y2o2?=
 =?utf-8?B?akdTRGRSK2g3UVAva2hxY2VwTjd4WG5Fa2E0QWZnTm1FU2NaNnFpeWt3Unhy?=
 =?utf-8?B?MCtldlFnL3ZhWlRIVzdENVE4TEFyQzJ1dy83a0ppaWpMbjVvYi9NUlBQYWdk?=
 =?utf-8?B?RS9WRVZ3eGRFYjAvMWk3ZDNIdENqRzVVM2JtclZqL0xBelBzNWpwSXFvemc4?=
 =?utf-8?B?aXlTV0pzUUJEZlg3OVdjSC8wSVN1ZVRwbFRaS1dyckRNZm1kY2FOWFBhclJa?=
 =?utf-8?B?bjNrV2w3SSsxT2NsZ1pMM2NTTmFxOVBQeDhmVGFEUTdWUmJrdEZrZDRIS2Y4?=
 =?utf-8?B?NlFKb1hqYnBGZ2l1c0dNeTUzOTZHNm9nQTVycHhmRWJncy9JUENyeEdQNFdO?=
 =?utf-8?B?WUkzWm5Mei9xZWRoNVNXTnVXTS9DSVlzYXFJbjBzanBOU2laTUxqVEpGN2JY?=
 =?utf-8?B?OE5sNWZKd3IzTVY5UlRaRENqS015WE5Ca0Flc2JQNktnNmFreUx6eHUydmFm?=
 =?utf-8?B?MXV5L2h6ak8xV0orQ3o3VmhXOXpGVVRSTVNsUllTMmFDSFVDUnpoSEl0V1Jh?=
 =?utf-8?B?bHVUVVdRL0E0RjVjdkJtY20wdHpLc0NDU0tPTktpNTExVlNWekRuaHFGNFdL?=
 =?utf-8?B?QlNhZVZFT2swa2JkUnUyQllzT2FjL29UUUhsUVRsVkZyVzZuWGFIaW9pbGM4?=
 =?utf-8?B?OWpXZVd2Qk1ZVkZ5NmlVWHpkVUxBSVNqT0htMnRkZmdIWU05MVUrUVZiNlk4?=
 =?utf-8?B?dlpRTGNKTU9IbW0wdEJaaGdYSkIvL0d3dFdwa05ZdjJIRyszUWpva1VJQ2RZ?=
 =?utf-8?B?VEZWcWhwbysxY1kxRm1kOTNzM0xNeUVwQ1BiZGpKYVVpRTBJTmNlWGJGa0F5?=
 =?utf-8?B?YjFveS82aGhQYzFpNGlYcGx3NTlCejliNXRLUWppSEN2V043Umdwa2VMbWd6?=
 =?utf-8?B?eS83S1FpZ3dRcS9uSSt5dGZSNFpLZ0xnNVFnNjk1b0ZaOGYwU2N0aGZ6dG5D?=
 =?utf-8?B?S20ydGJHWlFrUlo4bzVxRDhBY1N0QUhKQ1oxalJXWmtUUlFUVmlzc0c5QTFQ?=
 =?utf-8?B?YXZXOHdJcGJuWWdKWDRoUENwNndxTmpiVGVtQTRyNVlERVZwTVl2dktuS3FK?=
 =?utf-8?B?YVJ5anZlZnlYYjVUN3FxV09TYTR5blRQN0JKckZhRU5xZTlzS0EzYzhjYjVs?=
 =?utf-8?B?TlUwSFM2SWhobGpVZDVtZjFJYUNQVXdGTmJTaWVTNWQ5b1FLbFQreGQvV091?=
 =?utf-8?B?UmJTZlZiWEhkTVhucTJvZkJmdU1tSXNsMHJTbFp1TW1lTHkzWjFuSUhhVDVF?=
 =?utf-8?B?dU1VdUdqUTdGamtlL2kyOUt4cW1CWXJyM3ZzcDBEZHd5bldVK1dRc3JlOEUw?=
 =?utf-8?B?bnJlNDJGRXlzelFEbWRodElRaTBUNUpIaEhlaGpjU29kOEdqWkdFay9KeSsy?=
 =?utf-8?B?Y0VpbVhMbkRkOVJuNnJBejZOekJjR0w5SzlsU2RGWHh0Yk9LUGZhT3VXbHc2?=
 =?utf-8?B?bDkxVFpLSHFVNkJIOElhMXdWSkYrVHBXZlplSVpBS3ZnWVppN0RTZ0VnbW5F?=
 =?utf-8?B?amttM1I4b3l0RCtINTN1WmFwNTZtWkNRcm83SEV6KzdVL3JTUjd2OHpJQlNX?=
 =?utf-8?B?eDU3SUlMUzNYekNTdjFZQVpGS3VwbWo5Z3hLZGU4ekNqb09rMVgvQ3lQR3ND?=
 =?utf-8?B?Sy9LeU9mL3J6NEhwNXlMdGpZSnhUUTUvU1d6bytheGdoT20zWldZdk9CVWVL?=
 =?utf-8?Q?vWn+IoSGXudyY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 01:14:50.3620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb2c4e5-0dbd-4c1e-cbd3-08dc9a345f1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6870
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

FIT documentation is now a separate project, instead of having a
duplicate, we should point at the other project.

Signed-off-by: Sam Povilus <sam.povilus@amd.com>
---
 doc/usage/fit/index.rst              |   5 +-
 doc/usage/fit/source_file_format.rst | 682 +--------------------------
 2 files changed, 5 insertions(+), 682 deletions(-)

diff --git a/doc/usage/fit/index.rst b/doc/usage/fit/index.rst
index bd25bd30b2..af2e481212 100644
--- a/doc/usage/fit/index.rst
+++ b/doc/usage/fit/index.rst
@@ -4,13 +4,12 @@ Flat Image Tree (FIT)
 =====================
 
 U-Boot uses Flat Image Tree (FIT) as a standard file format for packaging
-images that it it reads and boots. Documentation about FIT is available at
-doc/uImage.FIT
+images that it it reads and boots. Documentation about FIT is available in 
+`the Flattened Image Tree project <https://fitspec.osfw.foundation/>`_.
 
 .. toctree::
     :maxdepth: 1
 
-    source_file_format
     howto
     x86-fit-boot
     signature
diff --git a/doc/usage/fit/source_file_format.rst b/doc/usage/fit/source_file_format.rst
index b2b1e42bd7..0c44329a82 100644
--- a/doc/usage/fit/source_file_format.rst
+++ b/doc/usage/fit/source_file_format.rst
@@ -3,682 +3,6 @@
 Flattened Image Tree (FIT) Format
 =================================
 
-Introduction
-------------
-
-The number of elements playing a role in the kernel booting process has
-increased over time and now typically includes the devicetree, kernel image and
-possibly a ramdisk image. Generally, all must be placed in the system memory and
-booted together.
-
-For firmware images a similar process has taken place, with various binaries
-loaded at different addresses, such as ARM's ATF, OpenSBI, FPGA and U-Boot
-itself.
-
-FIT provides a flexible and extensible format to deal with this complexity. It
-provides support for multiple components. It also supports multiple
-configurations, so that the same FIT can be used to boot multiple boards, with
-some components in common (e.g. kernel) and some specific to that board (e.g.
-devicetree).
-
-Terminology
-~~~~~~~~~~~
-
-This document defines FIT by providing FDT (Flat Device Tree) bindings. These
-describe the final form of the FIT at the moment when it is used. The user
-perspective may be simpler, as some of the properties (like timestamps and
-hashes) are filled in automatically by the U-Boot mkimage tool.
-
-To avoid confusion with the kernel FDT the following naming convention is used:
-
-FIT
-    Flattened Image Tree
-
-FIT is formally a flattened devicetree (in the libfdt meaning), which conforms
-to bindings defined in this document.
-
-.its
-    image tree source
-
-.itb
-    flattened image tree blob
-
-Image-building procedure
-~~~~~~~~~~~~~~~~~~~~~~~~
-
-The following picture shows how the FIT is prepared. Input consists of
-image source file (.its) and a set of data files. Image is created with the
-help of standard U-Boot mkimage tool which in turn uses dtc (device tree
-compiler) to produce image tree blob (.itb). The resulting .itb file is the
-actual binary of a new FIT::
-
-    tqm5200.its
-    +
-    vmlinux.bin.gz     mkimage + dtc               xfer to target
-    eldk-4.2-ramdisk  --------------> tqm5200.itb --------------> boot
-    tqm5200.dtb                          /|\
-                                          |
-                                     'new FIT'
-
-Steps:
-
-#. Create .its file, automatically filled-in properties are omitted
-
-#. Call mkimage tool on a .its file
-
-#. mkimage calls dtc to create .itb image and assures that
-   missing properties are added
-
-#. .itb (new FIT) is uploaded onto the target and used therein
-
-
-Unique identifiers
-~~~~~~~~~~~~~~~~~~
-
-To identify FIT sub-nodes representing images, hashes, configurations (which
-are defined in the following sections), the "unit name" of the given sub-node
-is used as it's identifier as it assures uniqueness without additional
-checking required.
-
-
-External data
-~~~~~~~~~~~~~
-
-FIT is normally built initially with image data in the 'data' property of each
-image node. It is also possible for this data to reside outside the FIT itself.
-This allows the 'FDT' part of the FIT to be quite small, so that it can be
-loaded and scanned without loading a large amount of data. Then when an image is
-needed it can be loaded from an external source.
-
-External FITs use 'data-offset' or 'data-position' instead of 'data'.
-
-The mkimage tool can convert a FIT to use external data using the `-E` argument,
-optionally using `-p` to specific a fixed position.
-
-It is often desirable to align each image to a block size or cache-line size
-(e.g. 512 bytes), so that there is no need to copy it to an aligned address when
-reading the image data. The mkimage tool provides a `-B` argument to support
-this.
-
-Root-node properties
---------------------
-
-The root node of the FIT should have the following layout::
-
-    / o image-tree
-        |- description = "image description"
-        |- timestamp = <12399321>
-        |- #address-cells = <1>
-        |
-        o images
-        | |
-        | o image-1 {...}
-        | o image-2 {...}
-        | ...
-        |
-        o configurations
-          |- default = "conf-1"
-          |
-          o conf-1 {...}
-          o conf-2 {...}
-          ...
-
-Optional property
-~~~~~~~~~~~~~~~~~
-
-description
-    Textual description of the FIT
-
-Mandatory property
-~~~~~~~~~~~~~~~~~~
-
-timestamp
-    Last image modification time being counted in seconds since
-    1970-01-01 00:00:00 - to be automatically calculated by mkimage tool.
-
-Conditionally mandatory property
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-#address-cells
-    Number of 32bit cells required to represent entry and
-    load addresses supplied within sub-image nodes. May be omitted when no
-    entry or load addresses are used.
-
-Mandatory nodes
-~~~~~~~~~~~~~~~
-
-images
-    This node contains a set of sub-nodes, each of them representing
-    single component sub-image (like kernel, ramdisk, etc.). At least one
-    sub-image is required.
-
-configurations
-    Contains a set of available configuration nodes and
-    defines a default configuration.
-
-
-'/images' node
---------------
-
-This node is a container node for component sub-image nodes. Each sub-node of
-the '/images' node should have the following layout::
-
-    o image-1
-        |- description = "component sub-image description"
-        |- data = /incbin/("path/to/data/file.bin")
-        |- type = "sub-image type name"
-        |- arch = "ARCH name"
-        |- os = "OS name"
-        |- compression = "compression name"
-        |- load = <00000000>
-        |- entry = <00000000>
-        |
-        o hash-1 {...}
-        o hash-2 {...}
-        ...
-
-Mandatory properties
-~~~~~~~~~~~~~~~~~~~~
-
-description
-    Textual description of the component sub-image
-
-type
-    Name of component sub-image type. Supported types are:
-
-    ====================  ==================
-    Sub-image type        Meaning
-    ====================  ==================
-    invalid               Invalid Image
-    aisimage              Davinci AIS image
-    atmelimage            ATMEL ROM-Boot Image
-    copro                 Coprocessor Image}
-    fdt_legacy            legacy Image with Flat Device Tree
-    filesystem            Filesystem Image
-    firmware              Firmware
-    firmware_ivt          Firmware with HABv4 IVT }
-    flat_dt               Flat Device Tree
-    fpga                  FPGA Image }
-    gpimage               TI Keystone SPL Image
-    imx8image             NXP i.MX8 Boot Image
-    imx8mimage            NXP i.MX8M Boot Image
-    imximage              Freescale i.MX Boot Image
-    kernel                Kernel Image
-    kernel_noload         Kernel Image (no loading done)
-    kwbimage              Kirkwood Boot Image
-    lpc32xximage          LPC32XX Boot Image
-    mtk_image             MediaTek BootROM loadable Image }
-    multi                 Multi-File Image
-    mxsimage              Freescale MXS Boot Image
-    omapimage             TI OMAP SPL With GP CH
-    pblimage              Freescale PBL Boot Image
-    pmmc                  TI Power Management Micro-Controller Firmware
-    ramdisk               RAMDisk Image
-    rkimage               Rockchip Boot Image }
-    rksd                  Rockchip SD Boot Image }
-    rkspi                 Rockchip SPI Boot Image }
-    script                Script
-    socfpgaimage          Altera SoCFPGA CV/AV preloader
-    socfpgaimage_v1       Altera SoCFPGA A10 preloader
-    spkgimage             Renesas SPKG Image }
-    standalone            Standalone Program
-    stm32image            STMicroelectronics STM32 Image }
-    sunxi_egon            Allwinner eGON Boot Image }
-    sunxi_toc0            Allwinner TOC0 Boot Image }
-    tee                   Trusted Execution Environment Image
-    ublimage              Davinci UBL image
-    vybridimage           Vybrid Boot Image
-    x86_setup             x86 setup.bin
-    zynqimage             Xilinx Zynq Boot Image }
-    zynqmpbif             Xilinx ZynqMP Boot Image (bif) }
-    zynqmpimage           Xilinx ZynqMP Boot Image }
-    ====================  ==================
-
-compression
-    Compression used by included data. If no compression is used, the
-    compression property should be set to "none". If the data is compressed but
-    it should not be uncompressed by the loader (e.g. compressed ramdisk), this
-    should also be set to "none".
-
-    Supported compression types are:
-
-    ====================  ==================
-    Compression type      Meaning
-    ====================  ==================
-    none                  uncompressed
-    bzip2                 bzip2 compressed
-    gzip                  gzip compressed
-    lz4                   lz4 compressed
-    lzma                  lzma compressed
-    lzo                   lzo compressed
-    zstd                  zstd compressed
-    ====================  ==================
-
-data-size
-    size of the data in bytes
-
-
-Conditionally mandatory property
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-data
-    Path to the external file which contains this node's binary data. Within
-    the FIT this is the contents of the file. This is mandatory unless
-    external data is used.
-
-data-offset
-    Offset of the data in a separate image store. The image store is placed
-    immediately after the last byte of the device tree binary, aligned to a
-    4-byte boundary. This is mandatory if external data is used, with an offset.
-
-data-position
-    Machine address at which the data is to be found. This is a fixed address
-    not relative to the loading of the FIT. This is mandatory if external data
-    used with a fixed address.
-
-os
-    OS name, mandatory for types "kernel". Valid OS names are:
-
-    ====================  ==================
-    OS name               Meaning
-    ====================  ==================
-    invalid               Invalid OS
-    4_4bsd                4_4BSD
-    arm-trusted-firmware  ARM Trusted Firmware
-    dell                  Dell
-    efi                   EFI Firmware
-    esix                  Esix
-    freebsd               FreeBSD
-    integrity             INTEGRITY
-    irix                  Irix
-    linux                 Linux
-    ncr                   NCR
-    netbsd                NetBSD
-    openbsd               OpenBSD
-    openrtos              OpenRTOS
-    opensbi               RISC-V OpenSBI
-    ose                   Enea OSE
-    plan9                 Plan 9
-    psos                  pSOS
-    qnx                   QNX
-    rtems                 RTEMS
-    sco                   SCO
-    solaris               Solaris
-    svr4                  SVR4
-    tee                   Trusted Execution Environment
-    u-boot                U-Boot
-    vxworks               VxWorks
-    ====================  ==================
-
-arch
-    Architecture name, mandatory for types: "standalone", "kernel",
-    "firmware", "ramdisk" and "fdt". Valid architecture names are:
-
-    ====================  ==================
-    Architecture type     Meaning
-    ====================  ==================
-    invalid               Invalid ARCH
-    alpha                 Alpha
-    arc                   ARC
-    arm64                 AArch64
-    arm                   ARM
-    avr32                 AVR32
-    blackfin              Blackfin
-    ia64                  IA64
-    m68k                  M68K
-    microblaze            MicroBlaze
-    mips64                MIPS 64 Bit
-    mips                  MIPS
-    nds32                 NDS32
-    nios2                 NIOS II
-    or1k                  OpenRISC 1000
-    powerpc               PowerPC
-    ppc                   PowerPC
-    riscv                 RISC-V
-    s390                  IBM S390
-    sandbox               Sandbox
-    sh                    SuperH
-    sparc64               SPARC 64 Bit
-    sparc                 SPARC
-    x86_64                AMD x86_64
-    x86                   Intel x86
-    xtensa                Xtensa
-    ====================  ==================
-
-entry
-    entry point address, address size is determined by
-    '#address-cells' property of the root node.
-    Mandatory for types: "firmware", and "kernel".
-
-load
-    load address, address size is determined by '#address-cells'
-    property of the root node.
-    Mandatory for types: "firmware", and "kernel".
-
-compatible
-    compatible method for loading image.
-    Mandatory for types: "fpga", and images that do not specify a load address.
-    Supported compatible methods:
-
-    ==========================  =========================================
-    Compatible string           Meaning
-    ==========================  =========================================
-    u-boot,fpga-legacy          Generic fpga loading routine.
-    u-boot,zynqmp-fpga-ddrauth  Signed non-encrypted FPGA bitstream for
-                                Xilinx Zynq UltraScale+ (ZymqMP) device.
-    u-boot,zynqmp-fpga-enc      Encrypted FPGA bitstream for Xilinx Zynq
-                                UltraScale+ (ZynqMP) device.
-    ==========================  =========================================
-
-phase
-    U-Boot phase for which the image is intended.
-
-    "spl"
-        image is an SPL image
-
-    "u-boot"
-        image is a U-Boot image
-
-Optional nodes:
-
-hash-1
-    Each hash sub-node represents separate hash or checksum
-    calculated for node's data according to specified algorithm.
-
-signature-1
-    Each signature sub-node represents separate signature
-    calculated for node's data according to specified algorithm.
-
-
-Hash nodes
-----------
-
-::
-
-    o hash-1
-        |- algo = "hash or checksum algorithm name"
-        |- value = [hash or checksum value]
-
-Mandatory properties
-~~~~~~~~~~~~~~~~~~~~
-
-algo
-    Algorithm name. Supported algoriths and their value sizes are:
-
-    ==================== ============ =========================================
-    Sub-image type       Size (bytes) Meaning
-    ==================== ============ =========================================
-    crc16-ccitt          2            Cyclic Redundancy Check 16-bit
-                                      (Consultative Committee for International
-                                      Telegraphy and Telephony)
-    crc32                4            Cyclic Redundancy Check 32-bit
-    md5                  16           Message Digest 5 (MD5)
-    sha1                 20           Secure Hash Algorithm 1 (SHA1)
-    sha256               32           Secure Hash Algorithm 2 (SHA256)
-    sha384               48           Secure Hash Algorithm 2 (SHA384)
-    sha512               64           Secure Hash Algorithm 2 (SHA512)
-    ==================== ============ =========================================
-
-value
-    Actual checksum or hash value.
-
-Image-signature nodes
----------------------
-
-::
-
-    o signature-1
-        |- algo = "algorithm name"
-        |- key-name-hint = "key name"
-        |- value = [hash or checksum value]
-
-
-Mandatory properties
-~~~~~~~~~~~~~~~~~~~~
-
-_`FIT Algorithm`:
-
-algo
-    Algorithm name. Supported algoriths and their value sizes are shown below.
-    Note that the hash is specified separately from the signing algorithm, so
-    it is possible to mix and match any SHA algorithm with any signing
-    algorithm. The size of the signature relates to the signing algorithm, not
-    the hash, since it is the hash that is signed.
-
-    ==================== ============ =========================================
-    Sub-image type       Size (bytes) Meaning
-    ==================== ============ =========================================
-    sha1,rsa2048         256          SHA1 hash signed with 2048-bit
-                                      Rivest–Shamir–Adleman algorithm
-    sha1,rsa3072         384          SHA1 hash signed with 2048-bit RSA
-    sha1,rsa4096         512          SHA1 hash signed with 2048-bit RSA
-    sha1,ecdsa256        32           SHA1 hash signed with 256-bit  Elliptic
-                                      Curve Digital Signature Algorithm
-    sha256,...
-    sha384,...
-    sha512,...
-    ==================== ============ =========================================
-
-key-name-hint
-    Name of key to use for signing. The keys will normally be in
-    a single directory (parameter -k to mkimage). For a given key <name>, its
-    private key is stored in <name>.key and the certificate is stored in
-    <name>.crt.
-
-sign-images
-    A list of images to sign, each being a property of the conf
-    node that contains then. The default is "kernel,fdt" which means that these
-    two images will be looked up in the config and signed if present. This is
-    used by mkimage to determine which images to sign.
-
-The following properies are added as part of signing, and are mandatory:
-
-value
-    Actual signature value. This is added by mkimage.
-
-hashed-nodes
-    A list of nodes which were hashed by the signer. Each is
-    a string - the full path to node. A typical value might be::
-
-	hashed-nodes = "/", "/configurations/conf-1", "/images/kernel",
-	    "/images/kernel/hash-1", "/images/fdt-1",
-	    "/images/fdt-1/hash-1";
-
-hashed-strings
-    The start and size of the string region of the FIT that was hashed. The
-    start is normally 0, indicating the first byte of the string table. The size
-    indicates the number of bytes hashed as part of signing.
-
-The following properies are added as part of signing, and are optional:
-
-timestamp
-    Time when image was signed (standard Unix time_t format)
-
-signer-name
-    Name of the signer (e.g. "mkimage")
-
-signer-version
-    Version string of the signer (e.g. "2013.01")
-
-comment
-    Additional information about the signer or image
-
-padding
-    The padding algorithm, it may be pkcs-1.5 or pss,
-    if no value is provided we assume pkcs-1.5
-
-
-'/configurations' node
-----------------------
-
-The 'configurations' node creates convenient, labeled boot configurations,
-which combine together kernel images with their ramdisks and fdt blobs.
-
-The 'configurations' node has the following structure::
-
-    o configurations
-        |- default = "default configuration sub-node unit name"
-        |
-        o config-1 {...}
-        o config-2 {...}
-        ...
-
-
-Optional property
-~~~~~~~~~~~~~~~~~
-
-default
-    Selects one of the configuration sub-nodes as a default configuration.
-
-Mandatory nodes
-~~~~~~~~~~~~~~~
-
-configuration-sub-node-unit-name
-    At least one of the configuration sub-nodes is required.
-
-Optional nodes
-~~~~~~~~~~~~~~
-
-signature-1
-    Each signature sub-node represents separate signature
-    calculated for the configuration according to specified algorithm.
-
-
-Configuration nodes
--------------------
-
-Each configuration has the following structure::
-
-    o config-1
-        |- description = "configuration description"
-        |- kernel = "kernel sub-node unit name"
-        |- fdt = "fdt sub-node unit-name" [, "fdt overlay sub-node unit-name", ...]
-        |- loadables = "loadables sub-node unit-name"
-        |- script = "
-        |- compatible = "vendor,board-style device tree compatible string"
-        o signature-1 {...}
-
-Mandatory properties
-~~~~~~~~~~~~~~~~~~~~
-
-description
-    Textual configuration description.
-
-kernel or firmware
-    Unit name of the corresponding kernel or firmware
-    (u-boot, op-tee, etc) image. If both "kernel" and "firmware" are specified,
-    control is passed to the firmware image.
-
-Optional properties
-~~~~~~~~~~~~~~~~~~~
-
-fdt
-    Unit name of the corresponding fdt blob (component image node of a
-    "fdt type"). Additional fdt overlay nodes can be supplied which signify
-    that the resulting device tree blob is generated by the first base fdt
-    blob with all subsequent overlays applied.
-
-fpga
-    Unit name of the corresponding fpga bitstream blob
-    (component image node of a "fpga type").
-
-loadables
-    Unit name containing a list of additional binaries to be
-    loaded at their given locations.  "loadables" is a comma-separated list
-    of strings. U-Boot will load each binary at its given start-address and
-    may optionally invoke additional post-processing steps on this binary based
-    on its component image node type.
-
-script
-    The image to use when loading a U-Boot script (for use with the
-    source command).
-
-compatible
-    The root compatible string of the U-Boot device tree that
-    this configuration shall automatically match when CONFIG_FIT_BEST_MATCH is
-    enabled. If this property is not provided, the compatible string will be
-    extracted from the fdt blob instead. This is only possible if the fdt is
-    not compressed, so images with compressed fdts that want to use compatible
-    string matching must always provide this property.
-
-The FDT blob is required to properly boot FDT based kernel, so the minimal
-configuration for 2.6 FDT kernel is (kernel, fdt) pair.
-
-Older, 2.4 kernel and 2.6 non-FDT kernel do not use FDT blob, in such cases
-'struct bd_info' must be passed instead of FDT blob, thus fdt property *must
-not* be specified in a configuration node.
-
-Configuration-signature nodes
------------------------------
-
-::
-
-    o signature-1
-        |- algo = "algorithm name"
-        |- key-name-hint = "key name"
-        |- sign-images = "path1", "path2";
-        |- value = [hash or checksum value]
-        |- hashed-strings = <0 len>
-
-
-Mandatory properties
-~~~~~~~~~~~~~~~~~~~~
-
-algo
-    See `FIT Algorithm`_.
-
-key-name-hint
-    Name of key to use for signing. The keys will normally be in
-    a single directory (parameter -k to mkimage). For a given key <name>, its
-    private key is stored in <name>.key and the certificate is stored in
-    <name>.crt.
-
-The following properies are added as part of signing, and are mandatory:
-
-value
-    Actual signature value. This is added by mkimage.
-
-The following properies are added as part of signing, and are optional:
-
-timestamp
-    Time when image was signed (standard Unix time_t format)
-
-signer-name
-    Name of the signer (e.g. "mkimage")
-
-signer-version
-    Version string of the signer (e.g. "2013.01")
-
-comment
-    Additional information about the signer or image
-
-padding
-    The padding algorithm, it may be pkcs-1.5 or pss,
-    if no value is provided we assume pkcs-1.5
-
-
-
-Examples
---------
-
-Some example files are available here, showing various scenarios
-
-.. toctree::
-    :maxdepth: 1
-
-    kernel
-    kernel_fdt
-    kernel_fdts_compressed
-    multi
-    multi_spl
-    multi-with-fpga
-    multi-with-loadables
-    sec_firmware_ppa
-    sign-configs
-    sign-images
-    uefi
-    update3
-    update_uboot
-
-.. sectionauthor:: Marian Balakowicz <m8@semihalf.com>
-.. sectionauthor:: External data additions, 25/1/16 Simon Glass <sjg@chromium.org>
+FIT format documentation has been moved to 
+`a separate project <https://fitspec.osfw.foundation/>`_. Updates to the 
+format/specification should be submitted there. 
\ No newline at end of file
-- 
2.34.1

