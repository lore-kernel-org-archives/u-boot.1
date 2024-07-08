Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F68C3DA42
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 15:39:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE40388754;
	Mon,  8 Jul 2024 17:39:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PRpTd/CZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D249887B9; Mon,  8 Jul 2024 17:39:55 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06D3288715
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 17:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Sam.Povilus@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJaQRgJphxaqNkcaw4aIT0QbWOPqwfgKXk4xcpMAAVSpv5cXc99zvatOzjE8xgO3Mo0qq3TuRXASHH95ngA5Ji4gk7Womz8nm0kaojc5CqpSCDpMlE1BF38wHQB5IR+qib5CFb5GzF/kIOIcPoAPS6DcCfYDBzznm8MTyEYhpKNn25TsA9Ur/SXtEb4pRoN+FQkUXODAIpgPnlscaIGc0K8yMEi8+6Yi0pvJxoXunTYUnn3lydeLcf6ZjgjRg5Fdd90xIz695rszrmC5/zeXmRJrAeUKKTTGmZyUB+AqNbb1HZlgUklkkEYui3zFjnk+/+LXokN1+q7TPdNI4QrN7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eKHCTIHl4m67jyRmeGIEglHxPhe8XwafzznzqkUKzk=;
 b=Grh6IjAC/yUtdkZOdEcmc4jECBnGtmqesnhuPM6li3Z1prQ2yjwqTFgHSy01NkkHMKb+6GuLCuJs0HK5ffI/+mxQSKOldo6aACpeTOAtYZMS9VXfQW8MqrkVfxzEW4Tf42ih8JFMX7bZDXlIQVUejkBDSD5wVn0rfz9mvHYmktJSljzOeQraSDgn2Rg39DuoKxrnXxmNRjHMIsyYuYJxhweVzlwbk0qaJuVARJLNUcZeaRDMqyFGtapf74nrEvnrLtOeK6qBlU60xAQFapNi79y905assvT4rz4HzQWck2faWN48zEPWo03bWDBaXL1jT42kWSVfQSU0VTl2l0svDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=konsulko.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eKHCTIHl4m67jyRmeGIEglHxPhe8XwafzznzqkUKzk=;
 b=PRpTd/CZNWTJgKbcgIx0jZUKvkw413rFyFF9vq2mv4gUZPAw8cCz6HmfnKZj0DeCf+svk7UQ25ZNe93Is9mKEVDUyr7qFjpZ6sh1uHeddW4DmvDo1xt+QMka99z9mh001RUfBvUkoz8JEF4pWiGa9f49g2FA5L50ago6ObQl2Vo=
Received: from DM6PR08CA0031.namprd08.prod.outlook.com (2603:10b6:5:80::44) by
 DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.35; Mon, 8 Jul 2024 15:39:48 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:5:80:cafe::53) by DM6PR08CA0031.outlook.office365.com
 (2603:10b6:5:80::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Mon, 8 Jul 2024 15:39:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 15:39:47 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 10:39:46 -0500
Received: from xcoapps69.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 8 Jul 2024 10:39:46 -0500
From: Sam Povilus <sam.povilus@amd.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <xypron.glpk@gmx.de>,
 <u-boot@lists.denx.de>
CC: <sam.povilus@amd.com>, <git@amd.com>
Subject: [RFC v3 1/2] doc: Remove FIT documentation that is elsewhere
Date: Mon, 8 Jul 2024 09:39:40 -0600
Message-ID: <20240708153941.1045588-2-sam.povilus@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240708153941.1045588-1-sam.povilus@amd.com>
References: <20240708153941.1045588-1-sam.povilus@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: sam.povilus@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|DM6PR12MB4337:EE_
X-MS-Office365-Filtering-Correlation-Id: ce1c9f61-8336-4f67-f057-08dc9f643312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Si9GT0tPRmZIdGdSZjk0YzF6b0dqYXViU0ZpVXU4VGNhVEZlUGR5V2hHbzJI?=
 =?utf-8?B?N1piaDVaSzhHSFRtRDdteURWOEljeG9LNDlwbE5nYkFkc0JkUDR2eUdnWVMx?=
 =?utf-8?B?SlZtdTNjYTFhZnBZOVh2OEROaEU1VHFTRGViVUxqUjNHSXdNRldnc0NoLzNR?=
 =?utf-8?B?anZITmMrY3JhS1hLdXNFZjRsMG5nUHRGSFVLcEtUSTg4UHhqVWREOVFOSVVo?=
 =?utf-8?B?bTlxb1VmZVZYM0JWdmFjdUpqQjBJbXRzNWVVLzJhRzV6U3ltU2hzRGY2M0J2?=
 =?utf-8?B?cVl6U3JNa3pETERBc0p0TktOSmFxWkVpVHZtWFA1ZGJ1OHVrTmFTY1RnTVhR?=
 =?utf-8?B?cUc3Y2wxaWtkdVFVdE5SOGNzMllqMVRFVUp3cU8xck12eHh4U3gxZ3Jubjl5?=
 =?utf-8?B?djJrK2hBNkhDVURlelBVNVJJNmJzeVNFd3NVMXF0OFdqSnk4ZjBNVXlraHo2?=
 =?utf-8?B?SkFJVVh1d3BzTXpXQWNsTXRSajRORFk2eFZkMks5NUk1bVd0aVI1TmV6WkZB?=
 =?utf-8?B?VXRMeFpwUFdPeXFudENUSUhWR2RBMUg4Z3dkRnYwZUtQdWFvWFVCNVlQL1BW?=
 =?utf-8?B?MFNXWk5jQm1pVDg1bFgxOEFwVXlLdCtpaERoQy9LeWFlZlNMZlUrTnQxaVk1?=
 =?utf-8?B?TzQyY3lXY3drZi96RkpIenF6cjgweis2TWlZQkJ4dlV0cXFvYXVjSlUra2NG?=
 =?utf-8?B?Z1ViMW0rOHg3dTZxMkRseWxqdFpRbGU2YXZ3M0tRV3o3Q1FqdDRFclpFeHR5?=
 =?utf-8?B?cnByMkdUOVdMc2FWa3ZhamtxR3R3UGZGZjZEdFNRbmlhK3M0WFFGRWh4cnYv?=
 =?utf-8?B?ckFycTlQczhQbVA0ZlRvZVhjYy9nbzhvWVE3SVlKVHROTFBveXVmdmgwSmd6?=
 =?utf-8?B?cDJOckFxZjB1OTRiUG1tSUhYWElXcmsxaFREbUltM3IxY1RURGVmVUcwdnlN?=
 =?utf-8?B?blNUQXd2U2tsR2E3bjNBc1ZsRU8rbmtkVnd0bFJMTE03L2xjL0FGZWpta0NM?=
 =?utf-8?B?ZlovZjBBWmtSOHZLVXluNXM1OWx2Z3BNWTZCenZybWtDeHQxeGRXS1Q5UUs3?=
 =?utf-8?B?bDV6UXBuQmx1ODN1TmNERU1ZUHNEWStWSzFIbjNYYzdDOGZUSGE0NXM2elhS?=
 =?utf-8?B?VUI2Z2w1ZWdkMElNQmlURFl2TEF1YmVBbERPVVY5USszdVViYTF5ZjRRdWUy?=
 =?utf-8?B?YWlxWGlZSWVMOTJITUlSVFlmcElLYUE1b3A2YTl2TEc4RnBSOVkxMDZkRUtB?=
 =?utf-8?B?R3YySUtFNkkzMEc5V3NlNUFtRUhyNm1uVTQxT2lLNEs5UU1BU01rRnZ0a0lQ?=
 =?utf-8?B?VGVYUDZCWEdDbm1ncEZIaVJ1ZHRwY1lBcXM4bkhsdHlHMmtFWERCaHlwMGlz?=
 =?utf-8?B?MERkYUJyTEN5WjJyeTRQcWQrY2JiQnZDaTlyTElTZEZyWkFvVlVYN0RUL1RN?=
 =?utf-8?B?V1BoZERZWlNLTjZqRVVPblkzbkE2UXNiTDJxL21obXpLcEU3QnNBOGhpelNC?=
 =?utf-8?B?T25FTE5aTG10QmZwb3BoaDVnQkZzMmxSU2dzMkpQeFFtSmg4ZTY0eTlTY3V3?=
 =?utf-8?B?WVp1YTFrWFVUdy9DUUpMNnFXUE4rWjJCL2JMT1hBN1BTeHJXQjdjNHZEWXZW?=
 =?utf-8?B?SHl6TjhNRVR2M1JMdW9IYVgzYksvV0lER0cwd0ozTEZTU0F2SUtCZ0NDeWNN?=
 =?utf-8?B?VDZ5MjlWOEQ5Z1ZPRzZLaVdaNmpHdytGTzZzNGFPTHpveGttOHNOSXJGbXBx?=
 =?utf-8?B?OU1qd2JyVTh2Wm4zOVBidFdaMXlkNUkzem1nODJUN2laZVMyaXMwZWRFbDFv?=
 =?utf-8?B?U2IwL1ZHd0w3dHFwNnBnYktFbE5kNC9hL1ZOZlJTQlNGZDNaRktvRTNBUysw?=
 =?utf-8?Q?t5PR+L66JcKi3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 15:39:47.9380 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce1c9f61-8336-4f67-f057-08dc9f643312
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337
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

