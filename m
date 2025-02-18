Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F50C021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 12:11:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E031A80BA8;
	Tue, 18 Feb 2025 13:11:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BAZ0H8PK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15D8880BA8; Tue, 18 Feb 2025 13:11:06 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::60b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0022A807C0
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 13:11:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9MwvE/0MPmS/CMVzcSmpx2YYrR+etDUwyiNPRw2yAxOdva3gn4drGCK5IULQaRbeJoHd4G/O/2YnmCaEyPGhnSN8LquCC07nJCdYi4WVXo5QKGoXowAl+URpAKCHPOB2RQYCI2xMS//3T666W5M3lLTGTKhER7VvXzQFTMSZfBvA7eb+PinrzvY3b4Sg/tvF6mm6zIzFC2cMJ/N1I79xlxI36ek0ilhfEZdRzl+EJRAN3d/4rwUufvZrgDQQkNu8jM9yfiEuH+bfQbrLfaKbTLM5etIUEnlykcn1WTL9+p8B3HIIrzLvtbx3OKNKq0MWiwjkbWCazXKbG+tWKBirQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2lxnW7ivPMs14GlOUp6MDlFHcLUcKCxrNWlopdROpg=;
 b=waVnSGv9ZZcD1oydWPrVxrlVdEc16HoWMr5d1574lz8h5H8TcqN5/adSBZMOyQ3lF0Pw8cLmAph9KIHcaiR2mwtMEi9SsKw4/hNmQgis4XJsKWEdq3tf6tRubUND9pE/a+vJ5KeYvoYM44axIxafMe4vT5Vw+gDWTbN5QJsePP38Cl9a1ZbmFzVY/JqxPKXwUuFfi5NsYFfjdvd+NqtxLW6COlYg95CTW1yWOxzWzwpVWVA7+wQpqBto2j0fBwcWuMc9u11VDb1St8ek7/iGsskiRe7RPZYxb+yd5lTuHntK79zsIcKoOSeWgDBzORdBqef8y87/gQvCHC4kCOKVpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2lxnW7ivPMs14GlOUp6MDlFHcLUcKCxrNWlopdROpg=;
 b=BAZ0H8PKUIA8gtSXz+jv42WNaweQt78BOZBuAm3CCYU1cOfTaIys75RzKQOkVo4NFp+HEAu2U/j0dniNUDhx1qAhBq2DEypwbIT7OyxPEGVZwSp4xjzYlzvFSpjOIgC+yPQkxjozqGXsaGcY2H/Y3VIeQmLqbXiaYtkfF+roGtTN9RcsoWb9KlHijDdut5zN3CXIMvyWlM49k92BrhXtcfFW/3y5R/aCCpTzIb8kq8TlR5S/fHViydVlQLs+n63w/gbfqmcafudby4Qix6QteX2GIR5XPOMLBHV5r8Xa/7cscIYyoZW7rR5pOsB5+aZWpLIE71CfwjiPsPzeHwT/SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DBBPR04MB7690.eurprd04.prod.outlook.com (2603:10a6:10:200::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 12:11:02 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 12:11:02 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: trini@konsulko.com, sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 alpernebiyasak@gmail.com, marex@denx.de
Cc: u-boot@lists.denx.de,
	tharvey@gateworks.com
Subject: [PATCH v5 15/20] binman: add a new entry type for packing DDR PHY
 firmware images
Date: Tue, 18 Feb 2025 20:05:52 +0800
Message-ID: <20250218120559.451678-16-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218120559.451678-1-alice.guo@oss.nxp.com>
References: <20250218120559.451678-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DBBPR04MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: ae7a4fe7-9be6-4ea1-c480-08dd50154fec
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BnZVXLpXM5cajZveZPiaq0QExXlMCe1vDKflTNFV5D7iuenaxa+CY3u00yYu?=
 =?us-ascii?Q?IE8Rz9FtSp4logPg2+o74Zg124HJ+5mLYSgCn1uyTosgI5GJZFxO0qt01eGG?=
 =?us-ascii?Q?dsB5VrbBtP8WJf3HLRtFUph2eowZ7IHkjHSy+/1qpLGNzq2pArxVk1OqswtK?=
 =?us-ascii?Q?Rn4WOABD6+CWyUQovr21XZk0GUXytSmqoDZaaYnTtQ9H5Ee/wmbUZDHu3rWk?=
 =?us-ascii?Q?dBhQcdpc8+FrKYNy9rk5T/5ENPC46ztdgk9adI15xqLXvCnFQ990ev5YLHaL?=
 =?us-ascii?Q?h6tdCcx0Paq4+09LFXFKbEuK24GUCHj/yoRNTr46jLBMai4ppSao3YpgY6kf?=
 =?us-ascii?Q?eNbS1RMQoU/QBkYO7DgRGNaWSo3PXzBIrdOWAKT62KTgLRn+5fBFh/jRF/WO?=
 =?us-ascii?Q?mLns5K5eC4qU4DZ/F1ch07siObCtdvrlih3nQhduByU5guwEHZskFudPsjS2?=
 =?us-ascii?Q?3WzQRqAwhUFwCVlb0oEUCHKLRE1GApzNScTpkvDx7XTllCQ06Ob6Dg2oJnR1?=
 =?us-ascii?Q?29/5OmQoWb5A2kCoAlAIL6lHTUlElPKH+ZNwMDvRBa16Xdx+DzjTbQrS6Dp+?=
 =?us-ascii?Q?mNQUedVdI44Uu2baN7dywKRszdiLPhqCRFR82anI463XcOqm3ewj9R216z5O?=
 =?us-ascii?Q?loq8fb0yfcXJtqwx4S9aCog7W4uUKusOfUEeVZzxv0U8sR0WpCxn1ne72fIf?=
 =?us-ascii?Q?OGWJAgqM7sz7+ZtoufAlQFYDazHejs8xUdd7HqNylg1JqdR1slPsEKuSu11G?=
 =?us-ascii?Q?7CVfkwpbKq2wK79I8LtN2t83z5anBavwDfJKDQ1db9Ryo7Wn1X0sfrV2p1qG?=
 =?us-ascii?Q?ROBrSvMKS/JQdOUNQAbbBLJAKrl2F0r6mtkSIFbuMl/LqXyCW2rOkY24sS8g?=
 =?us-ascii?Q?1YpnhfmzMdois/feg7xnjnzzuGvppaFgXqIp4mNGGkJ7Ep4UEnij5uqaFlBs?=
 =?us-ascii?Q?pTG+spLcsQsQCNS+4JbktJD6pDokwgsrEVq0e7LbAf6oDgWMIgHv+SMqAWVq?=
 =?us-ascii?Q?NAQnK4hh6fUJitn85Bi0KA4h+oPFUvln21xFnCgXW+1rkYGXgRB1cg28qCyh?=
 =?us-ascii?Q?rGmi+kFbivPlV/F5pzr6m8aflFN3qEVgC2KOl0zBsPNBa6SBHHNjzOp6Llix?=
 =?us-ascii?Q?vvwjqfzMWNuQBrhl2JZCv3+bJPA+uRcuzHMDbn9zKKOyIcbDGKA3hLMDJfmu?=
 =?us-ascii?Q?RFg41P0XtoAY6e/HtMPzY7I64ICQvqH6BRFRkJToTvm8zNFxsSDomt5TeJri?=
 =?us-ascii?Q?5rHa7HIApZf9eMiqWaqTZ+mwBFiWTplIEkaUPRtrj2jglcPolNYVg7AGU9P8?=
 =?us-ascii?Q?k0SR45UkuECvbo6eRSY0GxmfcovaTd8of9bfcxaMaVqX3h12ElQ/BgJ/Lqnw?=
 =?us-ascii?Q?wIXDrh2b9h4z1Hno9HsjY3T7jausP5cUfQrPf1mnNo5goFANhp2BRgj0sd/r?=
 =?us-ascii?Q?H6+nlYjQdyQFcqAYiESW9CCprI3nn3us?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1ne+Z6NhRcyHfedWFCs/P4LJI5fFvPSrwLXgWm6U8XFu+dSk7VbjZxVCnai4?=
 =?us-ascii?Q?K0xhUjQXnlp5TKfq8NihOx0l6J3O/6B0N+v4to6f9gayW4UdFLyZksDQcnui?=
 =?us-ascii?Q?dDfGkIJkvOpIPmTjEIcj78x1mxzBBEP2e5w9UAus7MvrcuvDvq8+fNZOXafU?=
 =?us-ascii?Q?NVrR7Gl75E+ztBzLS97CfmGtyVgQGYSZEoxoAytYOw4l2BNjChReCSeRAayD?=
 =?us-ascii?Q?Km7DtsKDWo8zOcr6fBdrij59or43MMmBomIDv/fDXPPGTTOficp8teVtRlMa?=
 =?us-ascii?Q?1/mWllML45e939vlVlYSa7NtnuBqOW3R+XlJXzHDFBA00dydzD1gxWikrB/d?=
 =?us-ascii?Q?J44tNdLouTN/MBkPrZVZVo7FRu2GfrOgNY6f4vBdyALb45R0C10Eif57qAIy?=
 =?us-ascii?Q?WVOryoeZI0HWzhF3e6cpZhUrTWZEqHs5yadRGeqwXlZ7xcWSIu3QjtT43O3Y?=
 =?us-ascii?Q?ukET3YYEkKWe41omSH4NwF967C9F6cNXLJA6mIDAL5pGss+AwhqlwfRh2Hdn?=
 =?us-ascii?Q?g97kUwFF5L4o6bRcuWSdrOFswylVCIhsqjdgHeZ36pheTCqU5LTogpmVmSX6?=
 =?us-ascii?Q?GUlxL5mD5/QrR0lqHP8ukVXxEZM2sa5MC/zH19BWwMRZOmTRrccPJ5AL7boC?=
 =?us-ascii?Q?gtg/eUE5cz+9wvgoZ0nvmfl+67qIy5LhHCXOSZb2ERmN4jeQ7ZNKnbxXUtfP?=
 =?us-ascii?Q?Hg6K/QZxhtUHPs+jKFu6sKaR6gYkeBI6dYY8ek+g1/RVGnhy2S6iqSmrDhjn?=
 =?us-ascii?Q?hOxN4KUNHTBg6t9dOkUgdlcukq5v9KcRinzMOg3qPxea85JLHVshMB1YM4fT?=
 =?us-ascii?Q?CD0Tsd8Y5oJQH5h2sS0ypHpRLvwl+gGBnkO11GSAcHZW8ZDvz/rcfYgcrK8Y?=
 =?us-ascii?Q?TAa4oK1qnYF31TYaT81V6CwttZHmzUHlKKiQHWtrRqDTvkm3wEXjxU7ePXT1?=
 =?us-ascii?Q?m1cPqFAXnnZgywQHSa/2sHWZRSBKAQ8InRIZ0eJuEBRjeVtDY4xWOyilF3CP?=
 =?us-ascii?Q?KVSWq2nfejEedAc8xh5sIQBaKXA/tfVaPSwsxYoOYW4G6Xs0sZcP3owE6tr+?=
 =?us-ascii?Q?gtdbZtAKQDNc0iDuJr01jgZerBzXA5ZcEuB9NHvAJ5Sn/Lnvvw568YAgKyRV?=
 =?us-ascii?Q?8koqRcAGqaFMtAN9AeYhU5n/TGQ+r0MTqmCaBTNThoNKiPDWbpMYgckWjQTV?=
 =?us-ascii?Q?2Z/aVZ02SzD7hSxPlSFxhna+QMw5W6DgBG2CHeTZnjAcnkyA4hJRcVTXzAA6?=
 =?us-ascii?Q?v9PKzptQZjcK9/sQR7/pgmwWY+44aLCV4C714hbuXQkWNfhWL9jQQRKKR/6w?=
 =?us-ascii?Q?W893ToTJFNg6yK1dFXWVQE5QxrOk6f91GlTATsoYJYwbQsc5DFUhIoNtth2Z?=
 =?us-ascii?Q?7IAo9XmxPngsZNsO62hVtiuxHMP0XIk2VC0lO2XWrdDbqTHGy/MNN1BW5Kr8?=
 =?us-ascii?Q?Fmswz/H8pe46YBRLLeADtAlYuDoQgp0gdv/gUI2drwecmGhj3jvKL7XSvsBO?=
 =?us-ascii?Q?MAfB+XUryp0p4otEAix7eyzqKndDQvsNKoWt28uN4MiV/yXSwgw65zhnzBNs?=
 =?us-ascii?Q?ZqCbp3ilaDia9zwqQEXI1VNFAp6i7Ic4D/5W+lTQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7a4fe7-9be6-4ea1-c480-08dd50154fec
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 12:11:02.4382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ViI+3m0xppVCyqHb2eNMnEkmJt4NrVobjoFgIKKB/dhBoER8SZeaG0thCkFFs+IJ1nmTGC9b+6ODxkqqiuGgVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7690
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
 tools/binman/entries.rst                  | 10 +++++++
 tools/binman/etype/nxp_header_ddrfw.py    | 32 +++++++++++++++++++++++
 tools/binman/ftest.py                     | 11 ++++++++
 tools/binman/test/346_nxp_ddrfw_imx95.dts | 24 +++++++++++++++++
 4 files changed, 77 insertions(+)
 create mode 100644 tools/binman/etype/nxp_header_ddrfw.py
 create mode 100644 tools/binman/test/346_nxp_ddrfw_imx95.dts

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index 780e9817fb6..6da3f0b9046 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -1663,6 +1663,16 @@ Properties / Entry arguments:
 
 
 
+.. _etype_nxp_header_ddrfw:
+
+Entry: nxp-header-ddrfw: add a header to DDR PHY firmware images
+---------------------------------------------------
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
index 00000000000..80e0611df60
--- /dev/null
+++ b/tools/binman/etype/nxp_header_ddrfw.py
@@ -0,0 +1,32 @@
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
+            if not required and entry_data is None:
+                return None
+
+            section_data += entry_data
+            header_data += entry.contents_size.to_bytes(4, 'little')
+
+        return header_data + section_data
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index a553ca9e564..62acc1d885c 100644
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
@@ -7826,6 +7830,13 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
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

