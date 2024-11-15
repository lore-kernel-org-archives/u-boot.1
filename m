Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087C8D68BDD
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 22:36:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDDA1896FF;
	Fri, 15 Nov 2024 23:35:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytec.com header.i=@phytec.com header.b="PFsZfj3W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16E0989247; Fri, 15 Nov 2024 20:51:33 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20708.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::708])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 225998933F
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 20:51:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ggiordano@phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JeN5WGaYRTbaD/djYZuQHieXVbC5snCA3KRzCX+7cHYagbUiWeYIPUg+TlYhWpn8jNA/PXOeiDJyj/BnomOCVgxh9Nydw04merVUsylt/WVevgEy7Cjwpa/pccL7zarry2gV2SsOlVBNsNeONqZXqp3NNP/fDIjs5BRLHLqppWTBCLwvQWBN6ja6mZmLkWfHLX1wIHOCQDnOj8aEPqLJOW3OTt0Bzh4J1Qjy5hbc4HkyRND6oWzaeGFSsSOaKi8+0wdPps72e55EMf7qAAhMur7kDhVS9kbFYx3RPyriau4bkTQliu3qlbFTRnNWiWcUzMQZUhQ7/KJQSxNrEVnkng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DR4FY0n4SaaGxGAt9xI0Sf/TNfo45m/uMv2Jpwcz8gE=;
 b=CayEqIhGam1YSIsi32yVYYRn1EBtubEpUyIGT5ksusoDyNjZHf8ebhohz5U6QfczkUXFyCiVs0EFEc+we1yXQnFkoYc8qQ9OBPdm4R5D6HEjXg/ME20UVYMK1BjvG5O86uK0ecvla4c1AoPM5tBLQMEWz0PT3IWjthlqWlGoUtpMmNF0LYEWp0QQu3RJikP7DaskzEJ5omHBmjAoMtN5Lm8G+S/Nk/gq2Ai+0E8vn8dpXs3Eo46FEFRNfOIluo+7beTX2Argf9JTh01Q/cPfgu/A010gA9q9//QINmRiINCkjjNQ6nIbV0JroCneYmPS11rbEaXEVlGvVZIJzKmc/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DR4FY0n4SaaGxGAt9xI0Sf/TNfo45m/uMv2Jpwcz8gE=;
 b=PFsZfj3W6MsohzgMuaurwH+GYxpXZsCCzopJxKNG6+ru4couYmhdO8ohP4e+o8PDIl/yGOiBMWpfPLZPB53lSvDtQt8rFSEEDTpHndKqWuK0R0eX1qJcyz5Zrld7e4bMXias7RXdG55NqKj4e/eOcTDGmKmwclc3L8se6ri+FHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com (2603:10b6:a03:537::8)
 by PH7PR22MB3118.namprd22.prod.outlook.com (2603:10b6:510:13e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 19:51:23 +0000
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d]) by SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d%5]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 19:51:23 +0000
From: Garrett Giordano <ggiordano@phytec.com>
To: trini@konsulko.com, w.egorov@phytec.de, t.remmet@phytec.de,
 sumit.garg@linaro.org, kever.yang@rock-chips.com, marex@denx.de,
 festevam@denx.de, jonas@kwiboo.se, Oliver.Gaskell@analog.com,
 aford173@gmail.com, prasad.kummari@amd.com, neil.armstrong@linaro.org,
 mibodhi@gmail.com, n-francis@ti.com, d-gole@ti.com, afd@ti.com,
 sjg@chromium.org, bb@ti.com, nm@ti.com, d.schultz@phytec.de,
 nmorrisson@phytec.com, francesco.dolcini@toradex.com, vishalm@ti.com,
 vigneshr@ti.com, y.moog@phytec.de, othacehe@gnu.org, m-chawdhry@ti.com,
 j-humphreys@ti.com, j-choudhary@ti.com
Cc: u-boot@lists.denx.de,
	upstream@lists.phytec.de
Subject: [PATCH 2/2] doc: board: phytec: Add phyCORE-AM62ax
Date: Fri, 15 Nov 2024 11:50:55 -0800
Message-Id: <20241115195055.3023365-3-ggiordano@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241115195055.3023365-1-ggiordano@phytec.com>
References: <20241115195055.3023365-1-ggiordano@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0105.namprd04.prod.outlook.com
 (2603:10b6:408:ec::20) To SJ2PR22MB4354.namprd22.prod.outlook.com
 (2603:10b6:a03:537::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR22MB4354:EE_|PH7PR22MB3118:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f90050d-9b8d-460d-133c-08dd05aee217
X-LD-Processed: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LdAPXvRbSFRC7NRLLdtp7pQqvLO9FgJ06OW2AOjw/klG2rebqfulLuGSO+gI?=
 =?us-ascii?Q?mKj3ANq/h+b6K63Mk1s7pmbTFNWYIEMhPkjxMUi+SezcFwxd2ctcrBgA7/jN?=
 =?us-ascii?Q?QyYyZpt519eDwaQEXHaHBETb1GiFz6f5vfPKcA61mypR2/NYp6qdGvYwXA5t?=
 =?us-ascii?Q?yEMPZsNXI0ooYBT1bsvfooxdzxtXbXhxlzTtg5XRqUrE3Az24VaJguZDiguN?=
 =?us-ascii?Q?VMZgf1SM6EATOza+ahYZmOFPfzL6M3BCImtgzp5ToxW646kTgssUKlQIXMng?=
 =?us-ascii?Q?atd4vg9wDhqetYdYmW/zXGfrMpcUZ7YZVsRrMShyQzej9Y0/EyFdwW9dwt85?=
 =?us-ascii?Q?QoIgLwZ0FAs3fs1eCNvhpyiosCPdPFwxy0uauxYbhL/ExvZmvoNjesr80lOW?=
 =?us-ascii?Q?Mqeu8pZT+ZhhffFqVmIr2JK4MHhM/sVXUiiLC5RnbSIFz7dM61gQIF3HIzkl?=
 =?us-ascii?Q?fp3uQp3jqmvTyw9bqmnvfLwfp0F29e+MTrmRdVrB+ChX8Y9ZMjneSJawqSsE?=
 =?us-ascii?Q?4GcdJzPz5C3DlTkPUdwga0K4R+V1F62F4ua3YsnGPQUI7aLHHm/2ahlAcQnb?=
 =?us-ascii?Q?27ykl9NLqR+WeMzNiyg8ZTKHWqSyWIBye6bC+uwhLAq7RiSMSZKCYQPhJIR9?=
 =?us-ascii?Q?R93zIB+iLSwduJpasFgGYbmc+uX4y5rpOMSX5ijiMteHfu4ge4SivX5CT75F?=
 =?us-ascii?Q?uBbHimifL6i8lIwOqgZDWrZ8CK5ZwGlXQ+7mh50vV35dJ4LmdTQPgFyOrswx?=
 =?us-ascii?Q?dc0ktFB8x+Ju35FC5Z04by6S9PPU8e7C41TicBqkTO09VZIPFulo//JhJ8PJ?=
 =?us-ascii?Q?h1jq978qoETWmOM+yGH/yIUpOz72GsErwLPcAPjHwhWxKBDioG1aCnGe6Ddf?=
 =?us-ascii?Q?PoSoPc6zFLaEn/TzVAJuT26bkcxP9Olhhupykx4UHFf/gzbTHv4kyRX1GQrM?=
 =?us-ascii?Q?EEMrXhPOC6q71MLNAaRIiU4wsudmnoy4ZnxXj1OCdOtH6B22fDyPGiPM2GuF?=
 =?us-ascii?Q?2oHcICRWq2J8YL8xTpgyfpDcjOJiMSSJldo8hUSFI3C9DrPOx3zwJa/AmQZ0?=
 =?us-ascii?Q?OkMbolB3HktFGiarloteqZPKWcr38oK/tPEHkTbYPy3qSVB9qVxejzMMbSV9?=
 =?us-ascii?Q?O8Wnoe/5VoMmA+Pvb834y8g6BHzM2jqbqWOPsejGJIu6F59oHZDgwkO5kji/?=
 =?us-ascii?Q?IxDESvFJ7nCe5YPkYp63xXKtTQRZnjH0HIyBpSTMVDMHfqmtcSCqBZaEBp9j?=
 =?us-ascii?Q?N1C//DIbMHj1lC5/lPT8N0xITofCr0EuaxMDsF8Fnn+l5zl/UzbeyUv9EIuV?=
 =?us-ascii?Q?9hgp0svG2vFtr1O+MpQd32d3xZHn9HbqWSK41lVfMUr135WRHRP0BaUdDat1?=
 =?us-ascii?Q?Va4o5ZKEuUorS2LsZkaNp0O0ytEDePVbQXk2ls9T3Z0WlMrhkA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR22MB4354.namprd22.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OGFND2IsCS2IRhWDbbJU9s5DWBkTk2M5ZQF2cYSX5r788Gkmup90gPa19NTm?=
 =?us-ascii?Q?JcWEf826mOX6eYkkzQyjhOE+0Myq6CR9jJyLsISDJMoznwoJLVVP3+WE7xwL?=
 =?us-ascii?Q?Txc50scNzB+EjPVGAwvonfw6W68Vd55D8cqm+KZB/JsRg68dNZ/rLvUKuUz7?=
 =?us-ascii?Q?HtJBJWLhkDThCBHB8z5Vlb/mBIYkm1S3k4r8WXPr5zd5yS4NkecbBL7HXdI5?=
 =?us-ascii?Q?+KBGOJjt/Qk+e7RBbxfKL4/6MO8O9GO6mgG8AJGqV6927iwNZKTC9KbVKZpw?=
 =?us-ascii?Q?eQAQM+AGg6gN+q5LBnqm0i57ATBS1pZlTvwU8hwZGsu6QREX2ho3Yc3SfZMT?=
 =?us-ascii?Q?VhDFiyF/2eNs4Qwfv6FKCpxRc1L1BdWBj0bIIR3CGSi3VYAr4ozy6g6LC7nn?=
 =?us-ascii?Q?n/84keLAMKiBrnobBXv5wCZvXmAl3YjSJhiIFPN9B4iOPTKhOJbpOOJLlIDI?=
 =?us-ascii?Q?pyPI46kZK9JdjvbEiwbiVsj6HnNptxKcveDqq9TqbpWDuUKZ+ZGyCtmvnr7f?=
 =?us-ascii?Q?QC2rZwn8T5yPbhzNjMzLBdNJ5IqfIKHvQk2OQ5ePFKaLOTx0CgVOCFPT+LB6?=
 =?us-ascii?Q?35Iw6K+yoNMCTbEjDt4ZfsoUvEvt09ttOX1Ivbu3UfQitab2BAvvODgm43zj?=
 =?us-ascii?Q?zse7Ir8rhSMivf3EOn/Rhu/q5u41OKcVzLnWmyDdqBNDPDzLfVPJ4K8Z/rBG?=
 =?us-ascii?Q?+4HWEqjqd6BXvEUBfsMCWWYFYbemmPHxkh9Y9UiQA7TByJTEhEf2U6lIYKa3?=
 =?us-ascii?Q?t7rkPBSWE5QmLCZcykWf4rd3Iu+26SBiwuYv6OBps8luy/2sGrp5xmIl+qtG?=
 =?us-ascii?Q?atKZ09LsARFRRV6PFvR+ql/bKzf5VwunmIOsH1wjdFqBPxHbKKi9kczh6mZz?=
 =?us-ascii?Q?ieYH9IUiahv67dhrI7YAoYVDzZWT3sihwpDGcwf3a8PI6FdDXB/+6++2bMKY?=
 =?us-ascii?Q?wRGBUCJh2JxdacgvGkMkUTGqkgN114ooxBeDxvT7MbRAYkTFYrnTOo90pHGg?=
 =?us-ascii?Q?iA81/e78Yw7pGgPxR75DHU4J13pwZ00b0YXGhjrBUGbY8zkg9h1j3ChjDUQ9?=
 =?us-ascii?Q?+35S+dKEeISOtGymOGVVv5KIoBwW30mruu0PCL27jhm7YkbkW556mrWEbRU4?=
 =?us-ascii?Q?J+mk/cGEw5Nkh/8iy2Mkeijlq8pTKoxZlPA20FZ6GQIWhHGkA4m5OgdewYMz?=
 =?us-ascii?Q?BVLB95mS2ckBKhawC/JjVUeEf9XxVTEmoMtoa1OMc1eg9142GYNrIhvYCwiw?=
 =?us-ascii?Q?n7sSKLei1GOAUEo2SjcGCflVSJm6W5FLcw4IscAHQV4cwvedjHG6Bz8RxpVT?=
 =?us-ascii?Q?QaNeBk+vYF5S1mDOwc+s1qb5YfV94qKCXH7E2TuuIT6qu1LOMnBOSVn9LkU/?=
 =?us-ascii?Q?JOqmgLx5N8ua6DjGDRO+YLVeZHD75OzLxTRTqChCuz+n1nxLH9DU/4xcKLBJ?=
 =?us-ascii?Q?Pj5r74NmAQL1pBXCSvEBHSP2JpcyimIhiYKJyfjal6vvwNj6D0ojVrXB0J/C?=
 =?us-ascii?Q?0nP2Yb9jKQ7GazbtsDjHH+ddXT7do8xEcGjTWlTS9awV/nHlj1AKm2rcWm9d?=
 =?us-ascii?Q?kmAxsqCPp5ZXKg19Vq0kO5lRqxrdfNTB52YNU0Yw?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f90050d-9b8d-460d-133c-08dd05aee217
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB4354.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 19:51:23.4433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RAVxkHACFZVNd853LMKon/nnNcqtlw+lUQSGc6OW0+GPJl/wfxIrZz5coE2l7mWXkXA+d36OsDaXXP6PjHScGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR22MB3118
X-Mailman-Approved-At: Fri, 15 Nov 2024 23:35:33 +0100
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

Add documentation for PHYTEC phyCORE-AM62ax SoM.

Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
---
 doc/board/phytec/index.rst          |   1 +
 doc/board/phytec/phycore-am62ax.rst | 161 ++++++++++++++++++++++++++++
 doc/board/ti/k3.rst                 |   1 +
 3 files changed, 163 insertions(+)
 create mode 100644 doc/board/phytec/phycore-am62ax.rst

diff --git a/doc/board/phytec/index.rst b/doc/board/phytec/index.rst
index 99848a9e958..697aec30512 100644
--- a/doc/board/phytec/index.rst
+++ b/doc/board/phytec/index.rst
@@ -9,6 +9,7 @@ PHYTEC
    imx8mm-phygate-tauri-l
    imx93-phyboard-segin
    phycore-am62x
+   phycore-am62ax
    phycore-am64x
    phycore-imx8mm
    phycore-imx8mp
diff --git a/doc/board/phytec/phycore-am62ax.rst b/doc/board/phytec/phycore-am62ax.rst
new file mode 100644
index 00000000000..baa26b5a7ce
--- /dev/null
+++ b/doc/board/phytec/phycore-am62ax.rst
@@ -0,0 +1,161 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. sectionauthor:: Garrett Giordano <ggiordano@phytec.com>
+
+phyCORE-AM62Ax
+=============
+
+The `phyCORE-AM62Ax <https://www.phytec.com/product/phycore-am62a>`_ is a
+SoM (System on Module) featuring TI's AM62Ax SoC. It can be used in combination
+with different carrier boards. This module can come with different sizes and
+models for DDR, eMMC, SPI NOR Flash and various SoCs from the AM62Ax family.
+
+A development Kit, called `phyBOARD-Lyra <https://www.phytec.com/product/phyboard-am62x>`_
+is used as a carrier board reference design around the AM62Ax SoM.
+
+Quickstart
+----------
+
+* Download sources and TI firmware blobs
+* Build Trusted Firmware-A
+* Build OP-TEE
+* Build U-Boot for the R5
+* Build U-Boot for the A53
+* Create bootable uSD Card
+* Boot
+
+Sources
+-------
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_boot_sources
+    :end-before: .. k3_rst_include_end_boot_sources
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_boot_firmwares
+    :end-before: .. k3_rst_include_end_tifsstub
+
+Build procedure
+---------------
+
+Setup the environment variables:
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_common_env_vars_desc
+    :end-before: .. k3_rst_include_end_common_env_vars_desc
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_board_env_vars_desc
+    :end-before: .. k3_rst_include_end_board_env_vars_desc
+
+Set the variables corresponding to this platform:
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_common_env_vars_defn
+    :end-before: .. k3_rst_include_end_common_env_vars_defn
+.. code-block:: bash
+
+ $ export UBOOT_CFG_CORTEXR=phycore_am62ax_r5_defconfig
+ $ export UBOOT_CFG_CORTEXA=phycore_am62ax_a53_defconfig
+ $ export TFA_BOARD=lite
+ $ # we dont use any extra TFA parameters
+ $ unset TFA_EXTRA_ARGS
+ $ export OPTEE_PLATFORM=k3-am62ax
+ $ # we dont use any extra OPTEE parameters
+ $ unset OPTEE_EXTRA_ARGS
+
+.. include::  ../ti/am62ax_sk.rst
+    :start-after: .. am62ax_evm_rst_include_start_build_steps
+    :end-before: .. am62ax_evm_rst_include_end_build_steps
+
+uSD Card creation
+-----------------
+
+Use fdisk to partition the uSD card. The layout should look similar to:
+
+.. code-block:: bash
+
+ $ sudo fdisk -l /dev/mmcblk0
+ Disk /dev/mmcblk0: 15 GB, 15913189376 bytes, 31080448 sectors
+ 242816 cylinders, 4 heads, 32 sectors/track
+ Units: sectors of 1 * 512 = 512 bytes
+
+ Device       Boot StartCHS    EndCHS        StartLBA     EndLBA    Sectors  Size Id Type
+ /dev/mmcblk0p1 *  128,0,1     1023,3,32        16384     278527     262144  128M  c Win95 FAT32 (LBA)
+ /dev/mmcblk0p2    1023,3,32   1023,3,32       278528    1693883    1415356  691M 83 Linux
+
+
+Once partitioned, the boot partition has to be formatted with a FAT filesystem.
+Assuming the uSD card is `/dev/mmcblk0`:
+
+.. code-block:: bash
+
+ $ mkfs.vfat /dev/mmcblk0p1
+
+To boot from a micro SD card on a HSFS device simply copy the following
+artifacts to the FAT partition:
+
+* tiboot3.bin from R5 build
+* tispl.bin from Cortex-A build
+* u-boot.img from Cortex-A build
+
+Boot
+----
+
+Put the uSD card in the slot on the board and apply power. Check the serial
+console for output.
+
+UART based boot
+---------------
+
+To boot the board via UART, set the switches to UART mode and connect to the
+micro USB port labeled as "Debug UART". After power-on the build artifacts
+needs to be uploaded one by one with a tool like sz.
+
+Example bash script sequence for running on a Linux host PC feeding all boot
+artifacts needed to the device. Assuming the host uses /dev/ttyUSB0 as
+the main domain serial port:
+
+.. prompt:: bash $
+
+  stty -F /dev/ttyUSB0 115200
+  sb --xmodem tiboot3.bin > /dev/ttyUSB0 < /dev/ttyUSB0
+  sb --ymodem tispl.bin > /dev/ttyUSB0 < /dev/ttyUSB0
+  sb --ymodem u-boot.img > /dev/ttyUSB0 < /dev/ttyUSB0
+
+Boot Modes
+----------
+
+The phyCORE-AM62x development kit supports booting from many different
+interfaces. By default, the development kit is set to boot from the micro-SD
+card. To change the boot device, DIP switches S5 and S6 can be used.
+Boot switches should be changed with power off.
+
+.. list-table:: Boot Modes
+   :widths: 16 16 16
+   :header-rows: 1
+
+   * - Switch Label
+     - SW5: 12345678
+     - SW6: 12345678
+
+   * - uSD
+     - 11000010
+     - 01000000
+
+   * - eMMC
+     - 11010010
+     - 00000000
+
+   * - OSPI
+     - 11010000
+     - 10000000
+
+   * - UART
+     - 11011100
+     - 00000000
+
+Further Information
+-------------------
+
+Please see :doc:`../ti/am62ax_sk` chapter for further AM62Ax SoC related documentation
+and https://docs.phytec.com/projects/yocto-phycore-am62ax/en/latest/ for vendor documentation.
diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index 5d01f487622..0deb4d768f9 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -46,6 +46,7 @@ K3 SoC based boards in other sections
 * :doc:`../beagle/am62x_beagleplay`
 * :doc:`../beagle/j721e_beagleboneai64`
 * :doc:`../phytec/phycore-am62x`
+* :doc:`../phytec/phycore-am62ax`
 * :doc:`../toradex/verdin-am62`
 
 Boot Flow Overview
-- 
2.25.1

