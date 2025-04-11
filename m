Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3453C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 08:13:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F3CC83F6D;
	Fri, 11 Apr 2025 10:13:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VXd2sOR+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C06D883F6D; Fri, 11 Apr 2025 10:13:34 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B661F82B16
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 10:13:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1hsJZm+anT4OVvou0hPQbQqPkctTPmmhAT8j3qvb8C1Ts9e0wA7AKCFfbcAyNXx1gaubGKkeBQ8aY4Zu+Qgd34eRHal0pSBQHpgAFSkVOoCvA8HBUx4Bf+9FAFLdwDmjX3TysAgYJNCS+/GxRTqzmqotAWPr9xadYpEJu+QjHJFzR7IFV+kd30v8efx0z29XptTcauYXxsn0ALTUTYtOhHupuBaTIysL3W4+os2RzwcTzennDABGYjnjGgU8MDQzCaibidnmugyCTS9yN4aEJS7WeXBI+g3FzBMAQFJ0/W8gUae/1as6PGylRTuNg6AdvpbAv8uhC44L4Q/epQmhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLxeX9S2ggy5waap/X4l7fSy4452bM1e4VXJU4B25pg=;
 b=em9cKxPK6qbcWCHcHxYEe0wp1sM4SBTYjub204YW8HpHNUaX+i9uhmsWyAb2iQdvKjFsgVS4IQ8FsYtab+UsDpIJliE9us+1D+t0d8UxImUpom+6RyommzIaoZOhmmeQzhCZn/uTrW/vTbjhBbfdz9VjsaltRUwj5UYgh5vR3UTN/hBv1d7g6YSv/3G9AzTIR58QfUXbTsVpfEgwMq1aJL0hscioOrlu87V0NbImqBc8KeOZE+SbJI7XwFVWubIb75lh2aCL//e5xewGbtLPqXU6MEnVLFbl2NV3n95yMb69/aiWpMVOfYeKBtaqQRoFPIluBxw07gXDJFq1aZEuJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLxeX9S2ggy5waap/X4l7fSy4452bM1e4VXJU4B25pg=;
 b=VXd2sOR+qwFqQCBvvJgfGO9tSLZ+B5YfoiBAHYleHRG8MMtsFyh0Xau6pFjZ4Wk+6hXjmZ3rMegJmAO4MSbyiJtehhQQEQiOIYX2pQ1h0wL+yNDGmxEonI3pWuPzrducFrsepLoD9BC1vUmal7Oeff27M0CtPXPsbD3rCqEKD1spsC9W1rQ067bta2SMXXhNr8LjJRbcHzLF7sM1FX8jtEDNfXgcwrn38MaJZWgGL4lW7spLRCN0hwxUjACEIbpl3BR/B5P1k6h5bkQkwfEIiWwKr54O+rOV5PbjJ4kRs4NevVsC1ceurN/BXzdd8+0TJ/QI2CtSYgzNPpEkTXUSAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA4PR04MB7967.eurprd04.prod.outlook.com (2603:10a6:102:b8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Fri, 11 Apr
 2025 08:13:31 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8632.024; Fri, 11 Apr 2025
 08:13:31 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: marex@denx.de, trini@konsulko.com, festevam@gmail.com, lukma@denx.de,
 seanga2@gmail.com, sjg@chromium.org, sbabic@denx.de,
 alpernebiyasak@gmail.com, alice.guo@nxp.com
Cc: u-boot@lists.denx.de, viorel.suman@nxp.com, ye.li@nxp.com,
 ranjani.vaidyanathan@nxp.com, peng.fan@nxp.com, frank.li@nxp.com,
 ji.luo@nxp.com, jindong.yue@nxp.com, Anton.Gres@ifm.com
Subject: [PATCH v9 15/20] binman: add a new entry type for packing DDR PHY
 firmware images
Date: Fri, 11 Apr 2025 16:06:58 +0800
Message-ID: <20250411080707.602371-16-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411080707.602371-1-alice.guo@oss.nxp.com>
References: <20250411080707.602371-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA4PR04MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: 723247e2-5bd0-459e-c4f7-08dd78d0bebc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k50zzHa72vzytinp8W16RWDC6tLA+r231/GVYj7ooOS2zwlI0BCOVtvSeHAb?=
 =?us-ascii?Q?oyt8x2PKoyOKhOhtkTcvp05dDVEzRguP6ABVeVEHrbOVCbvSN7Yo7zId91FF?=
 =?us-ascii?Q?Z8bvlw32LRi6U0uthvOyA0FP2WagoMec0igpFidY74hVWs0NMo6WPMz7Une3?=
 =?us-ascii?Q?J27IkfUVcDTcU0MLsfSbAoWIFj6ro0z+yMmJoE7C/8yfSKVfTeLNRA5XM79l?=
 =?us-ascii?Q?4zESCy0V7eB4IJz0m/r2HC2IS3aBadTGp7cWuSh1mQo0qVjYbxMbcMdqTzZW?=
 =?us-ascii?Q?yJW3JX5Ka2wxctAHuq9YRbUClh66IpwC5F9vUouoKfmJmnvWvFAWzpYp9zry?=
 =?us-ascii?Q?oeCWwGQgWCIjbkIg49TFuTD1XsFPk19TgNaeBjOJac5CnW3AtMJCXbIc5XCo?=
 =?us-ascii?Q?CeREK/0QlgGO6cyIVj72tCTGUdecbGG3ZZbnertgsjiX2a/deY7fK32VODGt?=
 =?us-ascii?Q?BShcBPMS8zVgejTI/7oPLlnP02f5oZUiUfRDR/FZsVDYw+Y5xI3Causmj11J?=
 =?us-ascii?Q?iVqLq9BC2X0kwmhSC6F32ipStcLgqKDsUh00mHTYdeqRTU4e+NpRj2VMAgCG?=
 =?us-ascii?Q?Zm9BR5/c00Jby1aKtkZbNaEv+BX9SNYgoNAhhdJXPl5VRcNDUrZd/tWmIHed?=
 =?us-ascii?Q?iYQTt69i+E6YJzxNmOkHBnJIKHb7N5YpeI71sy18LqiwKaNoCWZQ6OQQY18K?=
 =?us-ascii?Q?l8Xq34bhNXPkOVdO75BbR8RQbiaVrLPVynYJmWskmmLjoBYkm+K7+5aTr8+y?=
 =?us-ascii?Q?gn+EVHVaiP7a4fgGxjtrSfpvJbCWCNcOQKFKkL1dZvcIQRG/mEx7anncnIj4?=
 =?us-ascii?Q?vBGWmaxJ0wcuVz5gfs+y+d8QMB7S33bROapKGFhOoTkKD6jb6uWHcWj9lewz?=
 =?us-ascii?Q?1jujXGYCGgX649bhvpjxTlSknsLC6j3+El6M3jI0ZGqPBPJ/UCU6J2JurU0O?=
 =?us-ascii?Q?Gc3+4IvyfypR5t4l4h0rfj7Po7Syo+PZGBIORG2iwS7eqSAvG5v9/ajHuD5J?=
 =?us-ascii?Q?UFaACwV3hxEl8ak7x2vpc9nOOjtYBjdsRILvciqEPHRHqKlbhoiv1yePpjxI?=
 =?us-ascii?Q?FeEZ3WdMPjNLH7JNwfFsMHzuMB09GZJ/CLILx5bSEz8BhNUhMq+xmkEurffE?=
 =?us-ascii?Q?gWn4PpKQArigj6mh8AQ8wa6/DF8yJWfWtYWeRwc8C0bnLh4PT7csK5Y0fK3D?=
 =?us-ascii?Q?eCuEem43MhVLMYKf/o0aCE6zrp6F0d9O6q/l0yP/I7q7uY2+gEvZlVB18pvd?=
 =?us-ascii?Q?gUFpIeDkxLFhf0Xuwto+Y13K2lPKkMJkkkDUWhfdi7m23qLW8466r6mUR+R3?=
 =?us-ascii?Q?CPv10h06FrDVPEjTEMutnIjNWJmf/rlfQzEcDQW0+gbS84ocYlDrhDapyECU?=
 =?us-ascii?Q?cA/ndsePUj/efZ87uYqaUFbpy06qL1v+4IaWGoy8ewVnJKh8i1fWiainV4vY?=
 =?us-ascii?Q?QxtovsznVle2ASw2zgm+8F0sTXmn4Ub1QmQNTZ9sv4XFlo43wbw9sA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1fAzZfiGLYrjQyq7lTdX6khdlbBE+i/uDvoHmQUsWv4ds5SpiMm6SYN5jK2D?=
 =?us-ascii?Q?H5ksMI/23VdG4MZkcbd7V8W80XHKkmOa4E2Knc6EMuZHYM8wBw8L4J+rHYZQ?=
 =?us-ascii?Q?MifVIsQRVyrU89cUsfHxMEL433Gi3eIH2SK5ABXmJCQKP//khsClxOJw6jpb?=
 =?us-ascii?Q?g8GsLphlhLG8zxf65myqp1L+EpFxmEzsbF+gQeDphtemJx0s1lFYX4keZ/GN?=
 =?us-ascii?Q?dAdq/HjReVGAJfaQZTSlsjv8tfgB+j+gQYh49YzHAGEID8nqYEEkuODtfsKV?=
 =?us-ascii?Q?Ko+xRZ5dxZJgdSps+5ex4enexRlvEvDIYi/Jg0uwG+14p1xIieRICFmvFzRE?=
 =?us-ascii?Q?59ADEYUKEIHYMXOwZ5jvsUiny69C2kMYhnnDabOSCrpGt1vCwwYNe48huBJs?=
 =?us-ascii?Q?k2kQrZKMF2YrjpZtF9HSt0ewkHomCvnmk8pnbSOhEgcDvcMaZmahpHJx6beI?=
 =?us-ascii?Q?VV+E2g2K8U3d0Kr9BH8GpbE4Yi3yZG9ZaqzZVB/uaWEisFUsGHKTWvITquzd?=
 =?us-ascii?Q?gHM/0/SOZOyM6W1jPjmbBM1t5fmGDUHuX4fCBs8Z8ZlPE5Ay1F15m7B7Ncia?=
 =?us-ascii?Q?HfwxkQizLcc2gdowMEuLjg8c2eaoDMJ6vRoQJyfDBbkMRUZitZojYJq1GHQS?=
 =?us-ascii?Q?uCcLE1O28d/wH5TFjjOtR14QGucI0n1QkJ9YG17ecPtD8ErZ/LPiWuhvfqD2?=
 =?us-ascii?Q?jR0RhZB6r5XqCBmHU7BHQHxd+m6R8uBa5zfHnZd3vmLmOqa/3OVBtsBAKAgB?=
 =?us-ascii?Q?5szDaFuNxhdTS3xe3coLSi/Mz258SwUOMPlUou0fKrzR50D8WYlrEXmWFTN1?=
 =?us-ascii?Q?dTTHgDyYgKefefiGzK6W6rnVu+EH/SeqsrXKPEMcMfXSVgAD4LGKEBISIVAN?=
 =?us-ascii?Q?WWEf7UNT6ImdF2dpnM7FOrB+QUsvWUrRr7E/VSPnNnnfICCbPWM9b/OBMwDg?=
 =?us-ascii?Q?kza21CmH3zFyI6x4JpmpFf+KJtrzP/nfAKIAr5uURNRqGD/JDln6oxlL+z39?=
 =?us-ascii?Q?rzwviMiaVhscFORWh3PQy/ePOU4UCZ1eXgxv6NkfyvrGESOoZvUoJcqCWtxW?=
 =?us-ascii?Q?FoqVVbzMv84etQseAISYQUHA/qg2frXALBGaT3H8URbFJcNcqZJ6lSJNZkTm?=
 =?us-ascii?Q?78n5cf1IEbRvvyZJEj6S8ThKqK9bIqAvBV4jDM0V+jEJSM+kvTrHCl7JlxGs?=
 =?us-ascii?Q?Piqhb0WeVg9B6+TGokwpTO1SwV8COUsteOnyyYMAq4L8cMs5c5J345cq6QEw?=
 =?us-ascii?Q?qQbB6lZ4+jjS7TuHyt/hNFkAM51s/vUADqfIameqXmjfOoZr3qzcYZD28x7T?=
 =?us-ascii?Q?d/F9c94nqC46p1JMumI/+bKGttvW+8u6AUaUccIQzy4pqVurecP5S+WNtOEe?=
 =?us-ascii?Q?GXa0frPE8MtmCXvMfUm1bMIXIuXG3QLoPoOKVO0KwoGGkofpYesOxz/qOURj?=
 =?us-ascii?Q?/P3ZwoUpBgWPFzr1tscahbJ2Fy9rYHYXZwpM1hQdaBcT6d6qy4At+hOSOD7X?=
 =?us-ascii?Q?CloZlCJsYK5J4RuNUTbN9V3YEQ2vD7q26cZAhLPx4glGq0xthn8ujd2hzpin?=
 =?us-ascii?Q?DaD4p/aoc5Ddo/MWxPYP5hf6ljqGBoXpz8ERD2hv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 723247e2-5bd0-459e-c4f7-08dd78d0bebc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:13:30.9310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6rYTzGqut8k6snnj/FbXBWC5uvWCWg0cXTdGyMH3vI/p0uLvys6M3a0gnvWu2cQhDBaDTmfOwXeE3swZ7pu8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7967
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

From: Alice Guo <alice.guo@nxp.com>

i.MX95 needs to combine DDR PHY firmware images and their byte counts
together, so add a new entry type nxp-header-ddrfw for this requirement.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 tools/binman/entries.rst                  | 10 ++++++++
 tools/binman/etype/nxp_header_ddrfw.py    | 29 +++++++++++++++++++++++
 tools/binman/ftest.py                     | 11 +++++++++
 tools/binman/test/346_nxp_ddrfw_imx95.dts | 24 +++++++++++++++++++
 4 files changed, 74 insertions(+)
 create mode 100644 tools/binman/etype/nxp_header_ddrfw.py
 create mode 100644 tools/binman/test/346_nxp_ddrfw_imx95.dts

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index 780e9817fb6..4f05aa0a323 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -1663,6 +1663,16 @@ Properties / Entry arguments:
 
 
 
+.. _etype_nxp_header_ddrfw:
+
+Entry: nxp-header-ddrfw: add a header to DDR PHY firmware images
+----------------------------------------------------------------
+
+This entry is used to combine DDR PHY firmware images and their byte counts
+together. See imx95_evk.rst for how to get DDR PHY Firmware Images.
+
+
+
 .. _etype_opensbi:
 
 Entry: opensbi: RISC-V OpenSBI fw_dynamic blob
diff --git a/tools/binman/etype/nxp_header_ddrfw.py b/tools/binman/etype/nxp_header_ddrfw.py
new file mode 100644
index 00000000000..655699e6ffa
--- /dev/null
+++ b/tools/binman/etype/nxp_header_ddrfw.py
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2025 NXP
+
+from binman.etype.section import Entry_section
+
+class Entry_nxp_header_ddrfw(Entry_section):
+    """Add a header to DDR PHY firmware images
+
+    This entry is used for i.MX95 to combine DDR PHY firmware images and their
+    byte counts together.
+
+    See imx95_evk.rst for how to get DDR PHY Firmware Images.
+    """
+
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node)
+
+    def BuildSectionData(self, required):
+        section_data = bytearray()
+        header_data = bytearray()
+
+        for entry in self._entries.values():
+            entry_data = entry.GetData(required)
+
+            section_data += entry_data
+            header_data += entry.contents_size.to_bytes(4, 'little')
+
+        return header_data + section_data
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 948fcc02259..d6209de873b 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -104,6 +104,8 @@ PRE_LOAD_VERSION      = 0x11223344.to_bytes(4, 'big')
 PRE_LOAD_HDR_SIZE     = 0x00001000.to_bytes(4, 'big')
 TI_BOARD_CONFIG_DATA  = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
 TI_UNSECURE_DATA      = b'unsecuredata'
+IMX_LPDDR_IMEM_DATA   = b'qwertyuiop1234567890'
+IMX_LPDDR_DMEM_DATA   = b'asdfghjklzxcvbnm'
 
 # Subdirectory of the input dir to use to put test FDTs
 TEST_FDT_SUBDIR       = 'fdts'
@@ -202,6 +204,8 @@ class TestFunctional(unittest.TestCase):
         TestFunctional._MakeInputFile('fsp_m.bin', FSP_M_DATA)
         TestFunctional._MakeInputFile('fsp_s.bin', FSP_S_DATA)
         TestFunctional._MakeInputFile('fsp_t.bin', FSP_T_DATA)
+        TestFunctional._MakeInputFile('lpddr5_imem.bin', IMX_LPDDR_IMEM_DATA)
+        TestFunctional._MakeInputFile('lpddr5_dmem.bin', IMX_LPDDR_DMEM_DATA)
 
         cls._elf_testdir = os.path.join(cls._indir, 'elftest')
         elf_test.BuildElfTestFiles(cls._elf_testdir)
@@ -7845,6 +7849,13 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test that binman can produce an iMX8 image"""
         self._DoTestFile('339_nxp_imx8.dts')
 
+    def testNxpHeaderDdrfw(self):
+        """Test that binman can add a header to DDR PHY firmware images"""
+        data = self._DoReadFile('346_nxp_ddrfw_imx95.dts')
+        self.assertEqual(len(IMX_LPDDR_IMEM_DATA).to_bytes(4, 'little') +
+                         len(IMX_LPDDR_DMEM_DATA).to_bytes(4, 'little') +
+                         IMX_LPDDR_IMEM_DATA + IMX_LPDDR_DMEM_DATA, data)
+
     def testFitSignSimple(self):
         """Test that image with FIT and signature nodes can be signed"""
         if not elf.ELF_TOOLS:
diff --git a/tools/binman/test/346_nxp_ddrfw_imx95.dts b/tools/binman/test/346_nxp_ddrfw_imx95.dts
new file mode 100644
index 00000000000..889f6f29860
--- /dev/null
+++ b/tools/binman/test/346_nxp_ddrfw_imx95.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		imx-lpddr {
+			type = "nxp-header-ddrfw";
+
+			imx-lpddr-imem {
+				filename = "lpddr5_imem.bin";
+				type = "blob-ext";
+			};
+
+			imx-lpddr-dmem {
+				filename = "lpddr5_dmem.bin";
+				type = "blob-ext";
+			};
+		};
+	};
+};
-- 
2.43.0

