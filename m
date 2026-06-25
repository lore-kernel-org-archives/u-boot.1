Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B60CCDE000
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 18:09:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67C348496E;
	Thu, 25 Jun 2026 20:09:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="NQBLiEuW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDD528496E; Thu, 25 Jun 2026 20:09:11 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DC1A84975
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 20:09:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srVJ20TzQgm+YKNgIK+fat6Nus/PVfLHJt5mwglqK1I3xBz0bE5+BgKAQBLvOWyqNOcKlRvQi+g2tvX9cncBw1pq8o09GoXxOqafQg0PHiDJvDSH0xENm3IfPU9/c483wnEPaM1FMOzg4k0dtkFcPxPcwvTIewjmVN3ijZ9KQTKXKYgmY9a6LDS0bEdQfsxQQi7tNf8dfdir8nQV9f8fcEwJ1KP6pHW4zHPIOiob+nTuEzi4vyyNBS7j0aqJqht2P/PjcZCoO6Wqeo6MC34vwAmT3ldk3tgBylYS/rUGqEThKo8giAw2wpDfP7Fm+w9JkoFIxfGWZRslPVz7KY4Byg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBri9RUWtzxwKdq0QNqHCU+vjjHxk5EHH364hm4mzx0=;
 b=HcU83DHbAjcVsmhWTBGgIgPyXiTQ3MyIKNjGhhrSqvoDevnrq2MaHkTclLIOX8UqiBcaZFKaxWfbtwQZ7fx8ldiDOmiiDFd4ma9e7T7kAxpyTAKOxX30Uk3cWdBsXfEJsrj9pi65yM1dTGN6/sSibZ2rftt8sRelNhvCSU4rm26U2xCU1iSHspff0DlDUqehYd2U6M83YBiGacqbq4XPVIZ9n+V9ZRhB3VHY5LlJ6NzQ+3F2e+VB8JGDhBAb/vAdWjd7/a4A2Qybcbdi7rHrJfPpnlm9JVUI6yoS6ttnXYZ7+g1bwA91Ef+fZaJ0vRAWug+kOVmo4024YH4An7Pqhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBri9RUWtzxwKdq0QNqHCU+vjjHxk5EHH364hm4mzx0=;
 b=NQBLiEuWlLIOgZFE4DDbDCHE2Y8H1Xnhmr8L4d8l7q7yC5pQKQQmWXF3YEHchcTSj38yUqeY8hVq5ViIk0cl8niJDMCIw/4akousYvWC01p6RfXc0fhEtwNz3kyKd8CwgQ51qrKvuLacg0mF0mGw2oXCdT8bUfeAdszAdgzPsOIiS8OY22rm9KVjVe7rfeUwLpyshcFsn+u3ThiGfHk4gKKMYR/cRUzoZ5yhPZSEJIw77vYDLT7H8pMUf109gVSJvnNnF9xYlBJWsHX4+HhdTs71D/4B/FWsDaGoWw1HNwC+hgA0B8Qn1S2uZL5mYQ1i+Fxt/kB6lcsA2IV+r9R4yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by LV3PR03MB7357.namprd03.prod.outlook.com (2603:10b6:408:195::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 18:08:58 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0139.018; Thu, 25 Jun 2026
 18:08:58 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinh Nguyen <dinguyen@kernel.org>, Tom Rini <trini@konsulko.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>
Subject: [PATCH 1/4] arm: dts: socfpga: Update Arria 10 SoCDK U-Boot handoff
 data
Date: Fri, 26 Jun 2026 02:08:23 +0800
Message-Id: <9054132ccb04f2ce13a4b079b60fd96f10d207ee.1782410782.git.dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1782410782.git.dinesh.maniyam@altera.com>
References: <cover.1782410782.git.dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0205.namprd05.prod.outlook.com
 (2603:10b6:a03:330::30) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|LV3PR03MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e5a615-5188-497a-6255-08ded2e4d38b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|56012099006|11063799006|6133799003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: DlAMjs7YXXclK1pqkLz8n8wjtbGRfzuinCFrtDvGsjue9lPxy2VSzQzlxZ506xD51RAnti5pYRxcT6xQiFy7vYMd6oh0pvsR+ttIldxYkWXEWyHeEBIaPwANFtzBDbajVScRfTyz1A5MOKWyOmW7eQr3/uvQ9vFH98GZ8QEo0NhBJZy4FB3gaxHWwShotjYS0IXhCglrU5pGmWi2nNCF4ImweiSenGmYtb7L4AlaBEtibtePp/D9I8blp3e3Cnwag+zMmqSYfVm911SZC3glX70R+/nS796U7dZClOqlOZneFh15FJM+gpS4RiMyeRvol2Rt2GV5mOxVgsxQ1tqTAq5oCUNNIDULLOpHAydXo3w4e/NwP3CW4m/aluJHO/FldexSU4VIuZMm73UIa9+vtoi8SVsxqzRKe03yqNPUWCKUDV9ILND1jjvK/0TLhA6JIx0o03d2Aop4unJ17A2TuxQE7WKUN+yxivFIX5P0HBVBvfYxqwgeBSHrujbrLG0RfR+9ZMLG6eAHjnY8/PjcY4AdeCUUR/miNu7zppAiLUAw4q15LBZs04YrqLQnqhYfE3XZQdNrGJKJ6VhD4k7la1z55dUJosp3JjPmYtOZ2om3aqiofgGi6clRBATvPf8Wp2di801DvntKgA/+eGUzerWzV2MAqdJs62FUGkVxV+s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rR8790keg93zK/Ysrzi6xtoKysTB3CZb7O/Om9if1rSqh2OXt4Nwv6bd+l/7?=
 =?us-ascii?Q?sEgjFpss1rhqkK9bdy0jlNT4YmT64q6RkSSSklXbpcnGAY7V/BKrMfXJbahX?=
 =?us-ascii?Q?O2yQTuQWy4xcVMza7PcZ1BfUgo02ZC3J4bgbhWld2vr8JLwtDCSok7SZC/Pa?=
 =?us-ascii?Q?iGp5hcTjm1Oitd06ydphhrfXHCIj30iKxzvmhLtP//DwBhSBeyx2I1KzIz8w?=
 =?us-ascii?Q?QxAtETFLAl1TmOAZQbSubk9cam2oSrUkyqGq6NUxpH9gi5HcAvsJBmnO4yy6?=
 =?us-ascii?Q?EobEbDBxkYyZ8o4IF35ZIhTLCXYezklU/qUEpDwdc5/lL0WRz+tZRM3xtepS?=
 =?us-ascii?Q?HSMYQQEuErG12TXy6Nc2w0JLWEn8pyEi1C51SMW5UbMs/TQdAJ9UgawD6XUI?=
 =?us-ascii?Q?4wOPe2z04tJSroJ7GK49ACJklKEqtA4w6qQ5oTqnPMmxC60yCEYu+87JIjDZ?=
 =?us-ascii?Q?zZnZDO6CsZa/L/BWLMNw+oPx5IJwbuDJA8JgHONBizdyzx5/HOsWgHs1NmUu?=
 =?us-ascii?Q?ptXV5SYev4y7U2ko5HF61129PiLnx27KncgUa/BTcXvC86HBOSA24t5SxEdV?=
 =?us-ascii?Q?3rOuMY6mWRP6d+oZ9sp/bbPyUoB6FuEfp7Dd9bRlsaAZSv3oC9jjcFMQTCn7?=
 =?us-ascii?Q?cxHBqwCE1vWFl4zgnBN5CZ9QrFcwfRImePiNEPWY28lwloAOC9hRT6shqi6D?=
 =?us-ascii?Q?Civs2Gk71egMrLHlwDYVq8iBMTnZuUN3cm+UgqQa75GdlkxDqTpZYMC0wmoN?=
 =?us-ascii?Q?+itdsZuDXAChtHgE9z2gwGEbt/X1EZxtPUWhjO3Y6auEHyIOkSfjPyNzJh1i?=
 =?us-ascii?Q?drm92pUqkDox4vdMJRykLPfOb5T9TD/ev0ObM6F/wWdYraPs0f4fwpuLz6AN?=
 =?us-ascii?Q?GekkD1ObHfspkftebiX5jkRHj3S9UOU/XrpiQlvH8cOkPmlZKbwfDJpoVBKR?=
 =?us-ascii?Q?X276zR5WpUCKizbFOWxILwoBJ5uUv3gIJiwmTQ5imNOkLdDchrWx7bJi9PA2?=
 =?us-ascii?Q?zElRH3nKlMvJyYdq/a+OPN45j9f76P2v7oQO1+R5kQGA/2dd+lO3uHcJ43wN?=
 =?us-ascii?Q?YFXnIqI8XhaLNqCozI6xPgsM+A3uHY3ix3cENt1ZtXz5ZmvzHWml5jn3j7NW?=
 =?us-ascii?Q?PNRMF4lr3yDG7eYLBt0TdonrokZM+LONGWx/jyH3gplzCMMf/wtvDrNb8YM8?=
 =?us-ascii?Q?x121XAmjCK02IC1pVFdTfMFa9d2qQDmNXX2kckXtz9MO0RYCJBCsL2g5UXHv?=
 =?us-ascii?Q?OzYgRTpJdii+CFrE0qyT3D7vVOcb2DdGZNkgR8mjPKPBG3Lii/sCcK0cD+ps?=
 =?us-ascii?Q?v159zHb77LgvHCnquek78VzHDpyKDertprP/mb0jlVbmea2pb5USEog/qfZb?=
 =?us-ascii?Q?n6E+YFV7O03ndK2rw9YN5n5TK3yybM3j+CkxfQD0chrLdjgLLWbyetodo+RI?=
 =?us-ascii?Q?2HRRgjReOb/RyPfnYFrfPfBGXU6eQZjfDm+BHVLfDJjzCE19ALKHOvZP+bCi?=
 =?us-ascii?Q?E07+DUNTPXAI3CWB3/OrTKV3bNzFci9gid+CDlTqk2ccOZJFRbE/8ZcTW/z3?=
 =?us-ascii?Q?gj5sslhnVpXaI+XvyCGxsw2fcF05HErsxWMlKk5wvK5IWDvu5RIKryPooCXf?=
 =?us-ascii?Q?tNa1MKxt2Ow8doekudN8XG4PlyMPy9jefIRBTJt3dyxZ5tLOkr7z563FJbEP?=
 =?us-ascii?Q?luWlFiEbfMoWMixfjlgzooDEbRLG485RaZhQBzbAjWUD6NJgI5o+eBcABAC7?=
 =?us-ascii?Q?SYDTG8HzMAohLnBeLlK1AZLugolCBCI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e5a615-5188-497a-6255-08ded2e4d38b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 18:08:58.3416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3LoSqCR40lSgpuechqBK//LxCV3j4XYtMwiZN0yX1FII6Hsm+S2qj6SsnVod59ps6rDSZnjXiwmtUEGcoJRNZ95HmtfGys+iWYa4ymT3VI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7357
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Update the U-Boot-only handoff data for the Arria 10 SoCDK platforms
and refresh the headers it generates.

Rename CONFIG_IO_* references to CFG_IO_* in the shared
arch/arm/dts/socfpga_arria10-handoff.dtsi consumer and in the two
existing Chameleon V3 handoff headers (270_3, 480_2) so that all
producers and consumers of the IO_* macros agree on the new
CFG_IO_* names. This also keeps the device tree compiler from
emitting "Unexpected 'CONFIG_IO_*'" lexical errors when building
the Arria 10 SoCDK and Chameleon V3 DTBs.

Update arch/arm/mach-socfpga/qts-filter-a10.sh so the generator
script emits CFG_IO_* macro names matching the consumer side.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/dts/socfpga_arria10-handoff.dtsi     |  36 +--
 ...ocfpga_arria10_chameleonv3_270_3_handoff.h | 250 +++++++-------
 ...ocfpga_arria10_chameleonv3_480_2_handoff.h | 250 +++++++-------
 .../socfpga_arria10_socdk_nand-u-boot.dtsi    |  42 +++
 .../dts/socfpga_arria10_socdk_nand_handoff.h  | 305 ++++++++++++++++++
 .../socfpga_arria10_socdk_qspi-u-boot.dtsi    |  48 +++
 .../dts/socfpga_arria10_socdk_qspi_handoff.h  | 305 ++++++++++++++++++
 .../dts/socfpga_arria10_socdk_sdmmc_handoff.h | 262 +++++++--------
 arch/arm/mach-socfpga/qts-filter-a10.sh       |  22 +-
 9 files changed, 1110 insertions(+), 410 deletions(-)
 create mode 100644 arch/arm/dts/socfpga_arria10_socdk_nand-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_arria10_socdk_nand_handoff.h
 create mode 100644 arch/arm/dts/socfpga_arria10_socdk_qspi-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_arria10_socdk_qspi_handoff.h

diff --git a/arch/arm/dts/socfpga_arria10-handoff.dtsi b/arch/arm/dts/socfpga_arria10-handoff.dtsi
index a3afb4d9df4..9405b15b4d5 100644
--- a/arch/arm/dts/socfpga_arria10-handoff.dtsi
+++ b/arch/arm/dts/socfpga_arria10-handoff.dtsi
@@ -189,24 +189,24 @@
 			pinctrl-single,register-width = <32>;
 			pinctrl-single,function-mask = <0x003f3f3f>;
 			pinctrl-single,pins =
-				<0x00000100 CONFIG_IO_BANK_VSEL>,
-				<0x00000104 CONFIG_IO_MACRO (CONFIG_IO_1)>,
-				<0x00000108 CONFIG_IO_MACRO (CONFIG_IO_2)>,
-				<0x0000010c CONFIG_IO_MACRO (CONFIG_IO_3)>,
-				<0x00000110 CONFIG_IO_MACRO (CONFIG_IO_4)>,
-				<0x00000114 CONFIG_IO_MACRO (CONFIG_IO_5)>,
-				<0x00000118 CONFIG_IO_MACRO (CONFIG_IO_6)>,
-				<0x0000011c CONFIG_IO_MACRO (CONFIG_IO_7)>,
-				<0x00000120 CONFIG_IO_MACRO (CONFIG_IO_8)>,
-				<0x00000124 CONFIG_IO_MACRO (CONFIG_IO_9)>,
-				<0x00000128 CONFIG_IO_MACRO (CONFIG_IO_10)>,
-				<0x0000012c CONFIG_IO_MACRO (CONFIG_IO_11)>,
-				<0x00000130 CONFIG_IO_MACRO (CONFIG_IO_12)>,
-				<0x00000134 CONFIG_IO_MACRO (CONFIG_IO_13)>,
-				<0x00000138 CONFIG_IO_MACRO (CONFIG_IO_14)>,
-				<0x0000013c CONFIG_IO_MACRO (CONFIG_IO_15)>,
-				<0x00000140 CONFIG_IO_MACRO (CONFIG_IO_16)>,
-				<0x00000144 CONFIG_IO_MACRO (CONFIG_IO_17)>;
+				<0x00000100 CFG_IO_BANK_VSEL>,
+				<0x00000104 CFG_IO_MACRO (CFG_IO_1)>,
+				<0x00000108 CFG_IO_MACRO (CFG_IO_2)>,
+				<0x0000010c CFG_IO_MACRO (CFG_IO_3)>,
+				<0x00000110 CFG_IO_MACRO (CFG_IO_4)>,
+				<0x00000114 CFG_IO_MACRO (CFG_IO_5)>,
+				<0x00000118 CFG_IO_MACRO (CFG_IO_6)>,
+				<0x0000011c CFG_IO_MACRO (CFG_IO_7)>,
+				<0x00000120 CFG_IO_MACRO (CFG_IO_8)>,
+				<0x00000124 CFG_IO_MACRO (CFG_IO_9)>,
+				<0x00000128 CFG_IO_MACRO (CFG_IO_10)>,
+				<0x0000012c CFG_IO_MACRO (CFG_IO_11)>,
+				<0x00000130 CFG_IO_MACRO (CFG_IO_12)>,
+				<0x00000134 CFG_IO_MACRO (CFG_IO_13)>,
+				<0x00000138 CFG_IO_MACRO (CFG_IO_14)>,
+				<0x0000013c CFG_IO_MACRO (CFG_IO_15)>,
+				<0x00000140 CFG_IO_MACRO (CFG_IO_16)>,
+				<0x00000144 CFG_IO_MACRO (CFG_IO_17)>;
 			bootph-all;
 		};
 
diff --git a/arch/arm/dts/socfpga_arria10_chameleonv3_270_3_handoff.h b/arch/arm/dts/socfpga_arria10_chameleonv3_270_3_handoff.h
index 9d8f4a0dd38..697c9a32a8c 100644
--- a/arch/arm/dts/socfpga_arria10_chameleonv3_270_3_handoff.h
+++ b/arch/arm/dts/socfpga_arria10_chameleonv3_270_3_handoff.h
@@ -76,127 +76,127 @@
 	(ALTERAGRP_NOCCLK_MAINCNT))
 
 /* Pin Mux Configuration */
-#define CONFIG_IO_10_INPUT_BUF_EN 1
-#define CONFIG_IO_10_PD_DRV_STRG 10
-#define CONFIG_IO_10_PD_SLW_RT 1
-#define CONFIG_IO_10_PU_DRV_STRG 8
-#define CONFIG_IO_10_PU_SLW_RT 1
-#define CONFIG_IO_10_RTRIM 1
-#define CONFIG_IO_10_WK_PU_EN 0
-#define CONFIG_IO_11_INPUT_BUF_EN 1
-#define CONFIG_IO_11_PD_DRV_STRG 10
-#define CONFIG_IO_11_PD_SLW_RT 1
-#define CONFIG_IO_11_PU_DRV_STRG 8
-#define CONFIG_IO_11_PU_SLW_RT 1
-#define CONFIG_IO_11_RTRIM 1
-#define CONFIG_IO_11_WK_PU_EN 0
-#define CONFIG_IO_12_INPUT_BUF_EN 0
-#define CONFIG_IO_12_PD_DRV_STRG 0
-#define CONFIG_IO_12_PD_SLW_RT 0
-#define CONFIG_IO_12_PU_DRV_STRG 0
-#define CONFIG_IO_12_PU_SLW_RT 0
-#define CONFIG_IO_12_RTRIM 1
-#define CONFIG_IO_12_WK_PU_EN 1
-#define CONFIG_IO_13_INPUT_BUF_EN 0
-#define CONFIG_IO_13_PD_DRV_STRG 0
-#define CONFIG_IO_13_PD_SLW_RT 0
-#define CONFIG_IO_13_PU_DRV_STRG 0
-#define CONFIG_IO_13_PU_SLW_RT 0
-#define CONFIG_IO_13_RTRIM 1
-#define CONFIG_IO_13_WK_PU_EN 1
-#define CONFIG_IO_14_INPUT_BUF_EN 0
-#define CONFIG_IO_14_PD_DRV_STRG 0
-#define CONFIG_IO_14_PD_SLW_RT 0
-#define CONFIG_IO_14_PU_DRV_STRG 0
-#define CONFIG_IO_14_PU_SLW_RT 0
-#define CONFIG_IO_14_RTRIM 1
-#define CONFIG_IO_14_WK_PU_EN 1
-#define CONFIG_IO_15_INPUT_BUF_EN 0
-#define CONFIG_IO_15_PD_DRV_STRG 0
-#define CONFIG_IO_15_PD_SLW_RT 0
-#define CONFIG_IO_15_PU_DRV_STRG 0
-#define CONFIG_IO_15_PU_SLW_RT 0
-#define CONFIG_IO_15_RTRIM 1
-#define CONFIG_IO_15_WK_PU_EN 1
-#define CONFIG_IO_16_INPUT_BUF_EN 0
-#define CONFIG_IO_16_PD_DRV_STRG 10
-#define CONFIG_IO_16_PD_SLW_RT 1
-#define CONFIG_IO_16_PU_DRV_STRG 8
-#define CONFIG_IO_16_PU_SLW_RT 1
-#define CONFIG_IO_16_RTRIM 1
-#define CONFIG_IO_16_WK_PU_EN 0
-#define CONFIG_IO_17_INPUT_BUF_EN 1
-#define CONFIG_IO_17_PD_DRV_STRG 10
-#define CONFIG_IO_17_PD_SLW_RT 1
-#define CONFIG_IO_17_PU_DRV_STRG 8
-#define CONFIG_IO_17_PU_SLW_RT 1
-#define CONFIG_IO_17_RTRIM 1
-#define CONFIG_IO_17_WK_PU_EN 0
-#define CONFIG_IO_1_INPUT_BUF_EN 1
-#define CONFIG_IO_1_PD_DRV_STRG 10
-#define CONFIG_IO_1_PD_SLW_RT 0
-#define CONFIG_IO_1_PU_DRV_STRG 8
-#define CONFIG_IO_1_PU_SLW_RT 0
-#define CONFIG_IO_1_RTRIM 1
-#define CONFIG_IO_1_WK_PU_EN 1
-#define CONFIG_IO_2_INPUT_BUF_EN 1
-#define CONFIG_IO_2_PD_DRV_STRG 10
-#define CONFIG_IO_2_PD_SLW_RT 0
-#define CONFIG_IO_2_PU_DRV_STRG 8
-#define CONFIG_IO_2_PU_SLW_RT 0
-#define CONFIG_IO_2_RTRIM 1
-#define CONFIG_IO_2_WK_PU_EN 1
-#define CONFIG_IO_3_INPUT_BUF_EN 1
-#define CONFIG_IO_3_PD_DRV_STRG 10
-#define CONFIG_IO_3_PD_SLW_RT 0
-#define CONFIG_IO_3_PU_DRV_STRG 8
-#define CONFIG_IO_3_PU_SLW_RT 0
-#define CONFIG_IO_3_RTRIM 1
-#define CONFIG_IO_3_WK_PU_EN 1
-#define CONFIG_IO_4_INPUT_BUF_EN 1
-#define CONFIG_IO_4_PD_DRV_STRG 10
-#define CONFIG_IO_4_PD_SLW_RT 1
-#define CONFIG_IO_4_PU_DRV_STRG 8
-#define CONFIG_IO_4_PU_SLW_RT 1
-#define CONFIG_IO_4_RTRIM 1
-#define CONFIG_IO_4_WK_PU_EN 0
-#define CONFIG_IO_5_INPUT_BUF_EN 1
-#define CONFIG_IO_5_PD_DRV_STRG 10
-#define CONFIG_IO_5_PD_SLW_RT 1
-#define CONFIG_IO_5_PU_DRV_STRG 8
-#define CONFIG_IO_5_PU_SLW_RT 1
-#define CONFIG_IO_5_RTRIM 1
-#define CONFIG_IO_5_WK_PU_EN 0
-#define CONFIG_IO_6_INPUT_BUF_EN 0
-#define CONFIG_IO_6_PD_DRV_STRG 10
-#define CONFIG_IO_6_PD_SLW_RT 1
-#define CONFIG_IO_6_PU_DRV_STRG 8
-#define CONFIG_IO_6_PU_SLW_RT 1
-#define CONFIG_IO_6_RTRIM 1
-#define CONFIG_IO_6_WK_PU_EN 0
-#define CONFIG_IO_7_INPUT_BUF_EN 1
-#define CONFIG_IO_7_PD_DRV_STRG 10
-#define CONFIG_IO_7_PD_SLW_RT 1
-#define CONFIG_IO_7_PU_DRV_STRG 8
-#define CONFIG_IO_7_PU_SLW_RT 1
-#define CONFIG_IO_7_RTRIM 1
-#define CONFIG_IO_7_WK_PU_EN 0
-#define CONFIG_IO_8_INPUT_BUF_EN 1
-#define CONFIG_IO_8_PD_DRV_STRG 10
-#define CONFIG_IO_8_PD_SLW_RT 1
-#define CONFIG_IO_8_PU_DRV_STRG 8
-#define CONFIG_IO_8_PU_SLW_RT 1
-#define CONFIG_IO_8_RTRIM 1
-#define CONFIG_IO_8_WK_PU_EN 0
-#define CONFIG_IO_9_INPUT_BUF_EN 1
-#define CONFIG_IO_9_PD_DRV_STRG 10
-#define CONFIG_IO_9_PD_SLW_RT 1
-#define CONFIG_IO_9_PU_DRV_STRG 8
-#define CONFIG_IO_9_PU_SLW_RT 1
-#define CONFIG_IO_9_RTRIM 1
-#define CONFIG_IO_9_WK_PU_EN 0
-#define CONFIG_IO_BANK_VOLTAGE_SEL_CLKRST_IO 1
-#define CONFIG_IO_BANK_VOLTAGE_SEL_PERI_IO 1
+#define CFG_IO_10_INPUT_BUF_EN 1
+#define CFG_IO_10_PD_DRV_STRG 10
+#define CFG_IO_10_PD_SLW_RT 1
+#define CFG_IO_10_PU_DRV_STRG 8
+#define CFG_IO_10_PU_SLW_RT 1
+#define CFG_IO_10_RTRIM 1
+#define CFG_IO_10_WK_PU_EN 0
+#define CFG_IO_11_INPUT_BUF_EN 1
+#define CFG_IO_11_PD_DRV_STRG 10
+#define CFG_IO_11_PD_SLW_RT 1
+#define CFG_IO_11_PU_DRV_STRG 8
+#define CFG_IO_11_PU_SLW_RT 1
+#define CFG_IO_11_RTRIM 1
+#define CFG_IO_11_WK_PU_EN 0
+#define CFG_IO_12_INPUT_BUF_EN 0
+#define CFG_IO_12_PD_DRV_STRG 0
+#define CFG_IO_12_PD_SLW_RT 0
+#define CFG_IO_12_PU_DRV_STRG 0
+#define CFG_IO_12_PU_SLW_RT 0
+#define CFG_IO_12_RTRIM 1
+#define CFG_IO_12_WK_PU_EN 1
+#define CFG_IO_13_INPUT_BUF_EN 0
+#define CFG_IO_13_PD_DRV_STRG 0
+#define CFG_IO_13_PD_SLW_RT 0
+#define CFG_IO_13_PU_DRV_STRG 0
+#define CFG_IO_13_PU_SLW_RT 0
+#define CFG_IO_13_RTRIM 1
+#define CFG_IO_13_WK_PU_EN 1
+#define CFG_IO_14_INPUT_BUF_EN 0
+#define CFG_IO_14_PD_DRV_STRG 0
+#define CFG_IO_14_PD_SLW_RT 0
+#define CFG_IO_14_PU_DRV_STRG 0
+#define CFG_IO_14_PU_SLW_RT 0
+#define CFG_IO_14_RTRIM 1
+#define CFG_IO_14_WK_PU_EN 1
+#define CFG_IO_15_INPUT_BUF_EN 0
+#define CFG_IO_15_PD_DRV_STRG 0
+#define CFG_IO_15_PD_SLW_RT 0
+#define CFG_IO_15_PU_DRV_STRG 0
+#define CFG_IO_15_PU_SLW_RT 0
+#define CFG_IO_15_RTRIM 1
+#define CFG_IO_15_WK_PU_EN 1
+#define CFG_IO_16_INPUT_BUF_EN 0
+#define CFG_IO_16_PD_DRV_STRG 10
+#define CFG_IO_16_PD_SLW_RT 1
+#define CFG_IO_16_PU_DRV_STRG 8
+#define CFG_IO_16_PU_SLW_RT 1
+#define CFG_IO_16_RTRIM 1
+#define CFG_IO_16_WK_PU_EN 0
+#define CFG_IO_17_INPUT_BUF_EN 1
+#define CFG_IO_17_PD_DRV_STRG 10
+#define CFG_IO_17_PD_SLW_RT 1
+#define CFG_IO_17_PU_DRV_STRG 8
+#define CFG_IO_17_PU_SLW_RT 1
+#define CFG_IO_17_RTRIM 1
+#define CFG_IO_17_WK_PU_EN 0
+#define CFG_IO_1_INPUT_BUF_EN 1
+#define CFG_IO_1_PD_DRV_STRG 10
+#define CFG_IO_1_PD_SLW_RT 0
+#define CFG_IO_1_PU_DRV_STRG 8
+#define CFG_IO_1_PU_SLW_RT 0
+#define CFG_IO_1_RTRIM 1
+#define CFG_IO_1_WK_PU_EN 1
+#define CFG_IO_2_INPUT_BUF_EN 1
+#define CFG_IO_2_PD_DRV_STRG 10
+#define CFG_IO_2_PD_SLW_RT 0
+#define CFG_IO_2_PU_DRV_STRG 8
+#define CFG_IO_2_PU_SLW_RT 0
+#define CFG_IO_2_RTRIM 1
+#define CFG_IO_2_WK_PU_EN 1
+#define CFG_IO_3_INPUT_BUF_EN 1
+#define CFG_IO_3_PD_DRV_STRG 10
+#define CFG_IO_3_PD_SLW_RT 0
+#define CFG_IO_3_PU_DRV_STRG 8
+#define CFG_IO_3_PU_SLW_RT 0
+#define CFG_IO_3_RTRIM 1
+#define CFG_IO_3_WK_PU_EN 1
+#define CFG_IO_4_INPUT_BUF_EN 1
+#define CFG_IO_4_PD_DRV_STRG 10
+#define CFG_IO_4_PD_SLW_RT 1
+#define CFG_IO_4_PU_DRV_STRG 8
+#define CFG_IO_4_PU_SLW_RT 1
+#define CFG_IO_4_RTRIM 1
+#define CFG_IO_4_WK_PU_EN 0
+#define CFG_IO_5_INPUT_BUF_EN 1
+#define CFG_IO_5_PD_DRV_STRG 10
+#define CFG_IO_5_PD_SLW_RT 1
+#define CFG_IO_5_PU_DRV_STRG 8
+#define CFG_IO_5_PU_SLW_RT 1
+#define CFG_IO_5_RTRIM 1
+#define CFG_IO_5_WK_PU_EN 0
+#define CFG_IO_6_INPUT_BUF_EN 0
+#define CFG_IO_6_PD_DRV_STRG 10
+#define CFG_IO_6_PD_SLW_RT 1
+#define CFG_IO_6_PU_DRV_STRG 8
+#define CFG_IO_6_PU_SLW_RT 1
+#define CFG_IO_6_RTRIM 1
+#define CFG_IO_6_WK_PU_EN 0
+#define CFG_IO_7_INPUT_BUF_EN 1
+#define CFG_IO_7_PD_DRV_STRG 10
+#define CFG_IO_7_PD_SLW_RT 1
+#define CFG_IO_7_PU_DRV_STRG 8
+#define CFG_IO_7_PU_SLW_RT 1
+#define CFG_IO_7_RTRIM 1
+#define CFG_IO_7_WK_PU_EN 0
+#define CFG_IO_8_INPUT_BUF_EN 1
+#define CFG_IO_8_PD_DRV_STRG 10
+#define CFG_IO_8_PD_SLW_RT 1
+#define CFG_IO_8_PU_DRV_STRG 8
+#define CFG_IO_8_PU_SLW_RT 1
+#define CFG_IO_8_RTRIM 1
+#define CFG_IO_8_WK_PU_EN 0
+#define CFG_IO_9_INPUT_BUF_EN 1
+#define CFG_IO_9_PD_DRV_STRG 10
+#define CFG_IO_9_PD_SLW_RT 1
+#define CFG_IO_9_PU_DRV_STRG 8
+#define CFG_IO_9_PU_SLW_RT 1
+#define CFG_IO_9_RTRIM 1
+#define CFG_IO_9_WK_PU_EN 0
+#define CFG_IO_BANK_VOLTAGE_SEL_CLKRST_IO 1
+#define CFG_IO_BANK_VOLTAGE_SEL_PERI_IO 1
 #define PINMUX_DEDICATED_IO_10_SEL 15
 #define PINMUX_DEDICATED_IO_11_SEL 15
 #define PINMUX_DEDICATED_IO_12_SEL 1
@@ -289,12 +289,12 @@
 #define LWH2F_AXI_MASTER 1
 
 /* Voltage Select for Config IO */
-#define CONFIG_IO_BANK_VSEL \
-	(((CONFIG_IO_BANK_VOLTAGE_SEL_CLKRST_IO & 0x3) << 8) | \
-	(CONFIG_IO_BANK_VOLTAGE_SEL_PERI_IO & 0x3))
+#define CFG_IO_BANK_VSEL \
+	(((CFG_IO_BANK_VOLTAGE_SEL_CLKRST_IO & 0x3) << 8) | \
+	(CFG_IO_BANK_VOLTAGE_SEL_PERI_IO & 0x3))
 
 /* Macro for Config IO bit mapping */
-#define CONFIG_IO_MACRO(NAME) (((NAME ## _RTRIM & 0xff) << 19) | \
+#define CFG_IO_MACRO(NAME) (((NAME ## _RTRIM & 0xff) << 19) | \
 	((NAME ## _INPUT_BUF_EN & 0x3) << 17) | \
 	((NAME ## _WK_PU_EN & 0x1) << 16) | \
 	((NAME ## _PU_SLW_RT & 0x1) << 13) | \
diff --git a/arch/arm/dts/socfpga_arria10_chameleonv3_480_2_handoff.h b/arch/arm/dts/socfpga_arria10_chameleonv3_480_2_handoff.h
index caaff604eb8..df032bf843d 100644
--- a/arch/arm/dts/socfpga_arria10_chameleonv3_480_2_handoff.h
+++ b/arch/arm/dts/socfpga_arria10_chameleonv3_480_2_handoff.h
@@ -76,127 +76,127 @@
 	(ALTERAGRP_NOCCLK_MAINCNT))
 
 /* Pin Mux Configuration */
-#define CONFIG_IO_10_INPUT_BUF_EN 1
-#define CONFIG_IO_10_PD_DRV_STRG 10
-#define CONFIG_IO_10_PD_SLW_RT 1
-#define CONFIG_IO_10_PU_DRV_STRG 8
-#define CONFIG_IO_10_PU_SLW_RT 1
-#define CONFIG_IO_10_RTRIM 1
-#define CONFIG_IO_10_WK_PU_EN 0
-#define CONFIG_IO_11_INPUT_BUF_EN 1
-#define CONFIG_IO_11_PD_DRV_STRG 10
-#define CONFIG_IO_11_PD_SLW_RT 1
-#define CONFIG_IO_11_PU_DRV_STRG 8
-#define CONFIG_IO_11_PU_SLW_RT 1
-#define CONFIG_IO_11_RTRIM 1
-#define CONFIG_IO_11_WK_PU_EN 0
-#define CONFIG_IO_12_INPUT_BUF_EN 0
-#define CONFIG_IO_12_PD_DRV_STRG 0
-#define CONFIG_IO_12_PD_SLW_RT 0
-#define CONFIG_IO_12_PU_DRV_STRG 0
-#define CONFIG_IO_12_PU_SLW_RT 0
-#define CONFIG_IO_12_RTRIM 1
-#define CONFIG_IO_12_WK_PU_EN 1
-#define CONFIG_IO_13_INPUT_BUF_EN 0
-#define CONFIG_IO_13_PD_DRV_STRG 0
-#define CONFIG_IO_13_PD_SLW_RT 0
-#define CONFIG_IO_13_PU_DRV_STRG 0
-#define CONFIG_IO_13_PU_SLW_RT 0
-#define CONFIG_IO_13_RTRIM 1
-#define CONFIG_IO_13_WK_PU_EN 1
-#define CONFIG_IO_14_INPUT_BUF_EN 0
-#define CONFIG_IO_14_PD_DRV_STRG 0
-#define CONFIG_IO_14_PD_SLW_RT 0
-#define CONFIG_IO_14_PU_DRV_STRG 0
-#define CONFIG_IO_14_PU_SLW_RT 0
-#define CONFIG_IO_14_RTRIM 1
-#define CONFIG_IO_14_WK_PU_EN 1
-#define CONFIG_IO_15_INPUT_BUF_EN 0
-#define CONFIG_IO_15_PD_DRV_STRG 0
-#define CONFIG_IO_15_PD_SLW_RT 0
-#define CONFIG_IO_15_PU_DRV_STRG 0
-#define CONFIG_IO_15_PU_SLW_RT 0
-#define CONFIG_IO_15_RTRIM 1
-#define CONFIG_IO_15_WK_PU_EN 1
-#define CONFIG_IO_16_INPUT_BUF_EN 0
-#define CONFIG_IO_16_PD_DRV_STRG 10
-#define CONFIG_IO_16_PD_SLW_RT 1
-#define CONFIG_IO_16_PU_DRV_STRG 8
-#define CONFIG_IO_16_PU_SLW_RT 1
-#define CONFIG_IO_16_RTRIM 1
-#define CONFIG_IO_16_WK_PU_EN 0
-#define CONFIG_IO_17_INPUT_BUF_EN 1
-#define CONFIG_IO_17_PD_DRV_STRG 10
-#define CONFIG_IO_17_PD_SLW_RT 1
-#define CONFIG_IO_17_PU_DRV_STRG 8
-#define CONFIG_IO_17_PU_SLW_RT 1
-#define CONFIG_IO_17_RTRIM 1
-#define CONFIG_IO_17_WK_PU_EN 0
-#define CONFIG_IO_1_INPUT_BUF_EN 1
-#define CONFIG_IO_1_PD_DRV_STRG 10
-#define CONFIG_IO_1_PD_SLW_RT 0
-#define CONFIG_IO_1_PU_DRV_STRG 8
-#define CONFIG_IO_1_PU_SLW_RT 0
-#define CONFIG_IO_1_RTRIM 1
-#define CONFIG_IO_1_WK_PU_EN 1
-#define CONFIG_IO_2_INPUT_BUF_EN 1
-#define CONFIG_IO_2_PD_DRV_STRG 10
-#define CONFIG_IO_2_PD_SLW_RT 0
-#define CONFIG_IO_2_PU_DRV_STRG 8
-#define CONFIG_IO_2_PU_SLW_RT 0
-#define CONFIG_IO_2_RTRIM 1
-#define CONFIG_IO_2_WK_PU_EN 1
-#define CONFIG_IO_3_INPUT_BUF_EN 1
-#define CONFIG_IO_3_PD_DRV_STRG 10
-#define CONFIG_IO_3_PD_SLW_RT 0
-#define CONFIG_IO_3_PU_DRV_STRG 8
-#define CONFIG_IO_3_PU_SLW_RT 0
-#define CONFIG_IO_3_RTRIM 1
-#define CONFIG_IO_3_WK_PU_EN 1
-#define CONFIG_IO_4_INPUT_BUF_EN 1
-#define CONFIG_IO_4_PD_DRV_STRG 10
-#define CONFIG_IO_4_PD_SLW_RT 1
-#define CONFIG_IO_4_PU_DRV_STRG 8
-#define CONFIG_IO_4_PU_SLW_RT 1
-#define CONFIG_IO_4_RTRIM 1
-#define CONFIG_IO_4_WK_PU_EN 0
-#define CONFIG_IO_5_INPUT_BUF_EN 1
-#define CONFIG_IO_5_PD_DRV_STRG 10
-#define CONFIG_IO_5_PD_SLW_RT 1
-#define CONFIG_IO_5_PU_DRV_STRG 8
-#define CONFIG_IO_5_PU_SLW_RT 1
-#define CONFIG_IO_5_RTRIM 1
-#define CONFIG_IO_5_WK_PU_EN 0
-#define CONFIG_IO_6_INPUT_BUF_EN 0
-#define CONFIG_IO_6_PD_DRV_STRG 10
-#define CONFIG_IO_6_PD_SLW_RT 1
-#define CONFIG_IO_6_PU_DRV_STRG 8
-#define CONFIG_IO_6_PU_SLW_RT 1
-#define CONFIG_IO_6_RTRIM 1
-#define CONFIG_IO_6_WK_PU_EN 0
-#define CONFIG_IO_7_INPUT_BUF_EN 1
-#define CONFIG_IO_7_PD_DRV_STRG 10
-#define CONFIG_IO_7_PD_SLW_RT 1
-#define CONFIG_IO_7_PU_DRV_STRG 8
-#define CONFIG_IO_7_PU_SLW_RT 1
-#define CONFIG_IO_7_RTRIM 1
-#define CONFIG_IO_7_WK_PU_EN 0
-#define CONFIG_IO_8_INPUT_BUF_EN 1
-#define CONFIG_IO_8_PD_DRV_STRG 10
-#define CONFIG_IO_8_PD_SLW_RT 1
-#define CONFIG_IO_8_PU_DRV_STRG 8
-#define CONFIG_IO_8_PU_SLW_RT 1
-#define CONFIG_IO_8_RTRIM 1
-#define CONFIG_IO_8_WK_PU_EN 0
-#define CONFIG_IO_9_INPUT_BUF_EN 1
-#define CONFIG_IO_9_PD_DRV_STRG 10
-#define CONFIG_IO_9_PD_SLW_RT 1
-#define CONFIG_IO_9_PU_DRV_STRG 8
-#define CONFIG_IO_9_PU_SLW_RT 1
-#define CONFIG_IO_9_RTRIM 1
-#define CONFIG_IO_9_WK_PU_EN 0
-#define CONFIG_IO_BANK_VOLTAGE_SEL_CLKRST_IO 1
-#define CONFIG_IO_BANK_VOLTAGE_SEL_PERI_IO 1
+#define CFG_IO_10_INPUT_BUF_EN 1
+#define CFG_IO_10_PD_DRV_STRG 10
+#define CFG_IO_10_PD_SLW_RT 1
+#define CFG_IO_10_PU_DRV_STRG 8
+#define CFG_IO_10_PU_SLW_RT 1
+#define CFG_IO_10_RTRIM 1
+#define CFG_IO_10_WK_PU_EN 0
+#define CFG_IO_11_INPUT_BUF_EN 1
+#define CFG_IO_11_PD_DRV_STRG 10
+#define CFG_IO_11_PD_SLW_RT 1
+#define CFG_IO_11_PU_DRV_STRG 8
+#define CFG_IO_11_PU_SLW_RT 1
+#define CFG_IO_11_RTRIM 1
+#define CFG_IO_11_WK_PU_EN 0
+#define CFG_IO_12_INPUT_BUF_EN 0
+#define CFG_IO_12_PD_DRV_STRG 0
+#define CFG_IO_12_PD_SLW_RT 0
+#define CFG_IO_12_PU_DRV_STRG 0
+#define CFG_IO_12_PU_SLW_RT 0
+#define CFG_IO_12_RTRIM 1
+#define CFG_IO_12_WK_PU_EN 1
+#define CFG_IO_13_INPUT_BUF_EN 0
+#define CFG_IO_13_PD_DRV_STRG 0
+#define CFG_IO_13_PD_SLW_RT 0
+#define CFG_IO_13_PU_DRV_STRG 0
+#define CFG_IO_13_PU_SLW_RT 0
+#define CFG_IO_13_RTRIM 1
+#define CFG_IO_13_WK_PU_EN 1
+#define CFG_IO_14_INPUT_BUF_EN 0
+#define CFG_IO_14_PD_DRV_STRG 0
+#define CFG_IO_14_PD_SLW_RT 0
+#define CFG_IO_14_PU_DRV_STRG 0
+#define CFG_IO_14_PU_SLW_RT 0
+#define CFG_IO_14_RTRIM 1
+#define CFG_IO_14_WK_PU_EN 1
+#define CFG_IO_15_INPUT_BUF_EN 0
+#define CFG_IO_15_PD_DRV_STRG 0
+#define CFG_IO_15_PD_SLW_RT 0
+#define CFG_IO_15_PU_DRV_STRG 0
+#define CFG_IO_15_PU_SLW_RT 0
+#define CFG_IO_15_RTRIM 1
+#define CFG_IO_15_WK_PU_EN 1
+#define CFG_IO_16_INPUT_BUF_EN 0
+#define CFG_IO_16_PD_DRV_STRG 10
+#define CFG_IO_16_PD_SLW_RT 1
+#define CFG_IO_16_PU_DRV_STRG 8
+#define CFG_IO_16_PU_SLW_RT 1
+#define CFG_IO_16_RTRIM 1
+#define CFG_IO_16_WK_PU_EN 0
+#define CFG_IO_17_INPUT_BUF_EN 1
+#define CFG_IO_17_PD_DRV_STRG 10
+#define CFG_IO_17_PD_SLW_RT 1
+#define CFG_IO_17_PU_DRV_STRG 8
+#define CFG_IO_17_PU_SLW_RT 1
+#define CFG_IO_17_RTRIM 1
+#define CFG_IO_17_WK_PU_EN 0
+#define CFG_IO_1_INPUT_BUF_EN 1
+#define CFG_IO_1_PD_DRV_STRG 10
+#define CFG_IO_1_PD_SLW_RT 0
+#define CFG_IO_1_PU_DRV_STRG 8
+#define CFG_IO_1_PU_SLW_RT 0
+#define CFG_IO_1_RTRIM 1
+#define CFG_IO_1_WK_PU_EN 1
+#define CFG_IO_2_INPUT_BUF_EN 1
+#define CFG_IO_2_PD_DRV_STRG 10
+#define CFG_IO_2_PD_SLW_RT 0
+#define CFG_IO_2_PU_DRV_STRG 8
+#define CFG_IO_2_PU_SLW_RT 0
+#define CFG_IO_2_RTRIM 1
+#define CFG_IO_2_WK_PU_EN 1
+#define CFG_IO_3_INPUT_BUF_EN 1
+#define CFG_IO_3_PD_DRV_STRG 10
+#define CFG_IO_3_PD_SLW_RT 0
+#define CFG_IO_3_PU_DRV_STRG 8
+#define CFG_IO_3_PU_SLW_RT 0
+#define CFG_IO_3_RTRIM 1
+#define CFG_IO_3_WK_PU_EN 1
+#define CFG_IO_4_INPUT_BUF_EN 1
+#define CFG_IO_4_PD_DRV_STRG 10
+#define CFG_IO_4_PD_SLW_RT 1
+#define CFG_IO_4_PU_DRV_STRG 8
+#define CFG_IO_4_PU_SLW_RT 1
+#define CFG_IO_4_RTRIM 1
+#define CFG_IO_4_WK_PU_EN 0
+#define CFG_IO_5_INPUT_BUF_EN 1
+#define CFG_IO_5_PD_DRV_STRG 10
+#define CFG_IO_5_PD_SLW_RT 1
+#define CFG_IO_5_PU_DRV_STRG 8
+#define CFG_IO_5_PU_SLW_RT 1
+#define CFG_IO_5_RTRIM 1
+#define CFG_IO_5_WK_PU_EN 0
+#define CFG_IO_6_INPUT_BUF_EN 0
+#define CFG_IO_6_PD_DRV_STRG 10
+#define CFG_IO_6_PD_SLW_RT 1
+#define CFG_IO_6_PU_DRV_STRG 8
+#define CFG_IO_6_PU_SLW_RT 1
+#define CFG_IO_6_RTRIM 1
+#define CFG_IO_6_WK_PU_EN 0
+#define CFG_IO_7_INPUT_BUF_EN 1
+#define CFG_IO_7_PD_DRV_STRG 10
+#define CFG_IO_7_PD_SLW_RT 1
+#define CFG_IO_7_PU_DRV_STRG 8
+#define CFG_IO_7_PU_SLW_RT 1
+#define CFG_IO_7_RTRIM 1
+#define CFG_IO_7_WK_PU_EN 0
+#define CFG_IO_8_INPUT_BUF_EN 1
+#define CFG_IO_8_PD_DRV_STRG 10
+#define CFG_IO_8_PD_SLW_RT 1
+#define CFG_IO_8_PU_DRV_STRG 8
+#define CFG_IO_8_PU_SLW_RT 1
+#define CFG_IO_8_RTRIM 1
+#define CFG_IO_8_WK_PU_EN 0
+#define CFG_IO_9_INPUT_BUF_EN 1
+#define CFG_IO_9_PD_DRV_STRG 10
+#define CFG_IO_9_PD_SLW_RT 1
+#define CFG_IO_9_PU_DRV_STRG 8
+#define CFG_IO_9_PU_SLW_RT 1
+#define CFG_IO_9_RTRIM 1
+#define CFG_IO_9_WK_PU_EN 0
+#define CFG_IO_BANK_VOLTAGE_SEL_CLKRST_IO 1
+#define CFG_IO_BANK_VOLTAGE_SEL_PERI_IO 1
 #define PINMUX_DEDICATED_IO_10_SEL 15
 #define PINMUX_DEDICATED_IO_11_SEL 15
 #define PINMUX_DEDICATED_IO_12_SEL 1
@@ -289,12 +289,12 @@
 #define LWH2F_AXI_MASTER 1
 
 /* Voltage Select for Config IO */
-#define CONFIG_IO_BANK_VSEL \
-	(((CONFIG_IO_BANK_VOLTAGE_SEL_CLKRST_IO & 0x3) << 8) | \
-	(CONFIG_IO_BANK_VOLTAGE_SEL_PERI_IO & 0x3))
+#define CFG_IO_BANK_VSEL \
+	(((CFG_IO_BANK_VOLTAGE_SEL_CLKRST_IO & 0x3) << 8) | \
+	(CFG_IO_BANK_VOLTAGE_SEL_PERI_IO & 0x3))
 
 /* Macro for Config IO bit mapping */
-#define CONFIG_IO_MACRO(NAME) (((NAME ## _RTRIM & 0xff) << 19) | \
+#define CFG_IO_MACRO(NAME) (((NAME ## _RTRIM & 0xff) << 19) | \
 	((NAME ## _INPUT_BUF_EN & 0x3) << 17) | \
 	((NAME ## _WK_PU_EN & 0x1) << 16) | \
 	((NAME ## _PU_SLW_RT & 0x1) << 13) | \
diff --git a/arch/arm/dts/socfpga_arria10_socdk_nand-u-boot.dtsi b/arch/arm/dts/socfpga_arria10_socdk_nand-u-boot.dtsi
new file mode 100644
index 00000000000..e716bec041e
--- /dev/null
+++ b/arch/arm/dts/socfpga_arria10_socdk_nand-u-boot.dtsi
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Altera Corporation
+ */
+
+#include "socfpga_arria10_socdk_nand_handoff.h"
+#include "socfpga_arria10-handoff.dtsi"
+#include "socfpga_arria10_handoff_u-boot.dtsi"
+#include "socfpga_arria10_socdk-u-boot.dtsi"
+
+/ {
+	fs_loader0: fs-loader {
+		bootph-all;
+		compatible = "u-boot,fs-loader";
+	};
+};
+
+&fpga_mgr {
+	bootph-all;
+	firmware-loader = <&fs_loader0>;
+	altr,bitstream = "300000";
+};
+
+&l4_mp_clk {
+	bootph-all;
+};
+
+&nand_x_clk {
+	bootph-all;
+};
+
+&nand_ecc_clk {
+	bootph-all;
+};
+
+&nand_clk {
+	bootph-all;
+};
+
+&nand {
+	bootph-all;
+};
diff --git a/arch/arm/dts/socfpga_arria10_socdk_nand_handoff.h b/arch/arm/dts/socfpga_arria10_socdk_nand_handoff.h
new file mode 100644
index 00000000000..308579b7fe3
--- /dev/null
+++ b/arch/arm/dts/socfpga_arria10_socdk_nand_handoff.h
@@ -0,0 +1,305 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Altera Arria 10 SoCFPGA configuration
+ */
+
+#ifndef __SOCFPGA_ARRIA10_CFG_H__
+#define __SOCFPGA_ARRIA10_CFG_H__
+
+/* Clocks */
+#define CB_INTOSC_LS_CLK_HZ 60000000
+#define EMAC0_CLK_HZ 250000000
+#define EMAC1_CLK_HZ 250000000
+#define EMAC2_CLK_HZ 250000000
+#define EOSC1_CLK_HZ 25000000
+#define F2H_FREE_CLK_HZ 200000000
+#define H2F_USER0_CLK_HZ 400000000
+#define H2F_USER1_CLK_HZ 400000000
+#define L3_MAIN_FREE_CLK_HZ 200000000
+#define SDMMC_CLK_HZ 200000000
+#define TPIU_CLK_HZ 100000000
+#define MAINPLLGRP_CNTR15CLK_CNT 900
+#define MAINPLLGRP_CNTR2CLK_CNT 900
+#define MAINPLLGRP_CNTR3CLK_CNT 900
+#define MAINPLLGRP_CNTR4CLK_CNT 900
+#define MAINPLLGRP_CNTR5CLK_CNT 900
+#define MAINPLLGRP_CNTR6CLK_CNT 900
+#define MAINPLLGRP_CNTR7CLK_CNT 900
+#define MAINPLLGRP_CNTR7CLK_SRC 0
+#define MAINPLLGRP_CNTR8CLK_CNT 900
+#define MAINPLLGRP_CNTR9CLK_CNT 900
+#define MAINPLLGRP_CNTR9CLK_SRC 0
+#define MAINPLLGRP_MPUCLK_CNT 0
+#define MAINPLLGRP_MPUCLK_SRC 0
+#define MAINPLLGRP_NOCCLK_CNT 0
+#define MAINPLLGRP_NOCCLK_SRC 0
+#define MAINPLLGRP_NOCDIV_CSATCLK 0
+#define MAINPLLGRP_NOCDIV_CSPDBGCLK 1
+#define MAINPLLGRP_NOCDIV_CSTRACECLK 1
+#define MAINPLLGRP_NOCDIV_L4MAINCLK 0
+#define MAINPLLGRP_NOCDIV_L4MPCLK 0
+#define MAINPLLGRP_NOCDIV_L4SPCLK 2
+#define MAINPLLGRP_VCO0_PSRC 0
+#define MAINPLLGRP_VCO1_DENOM 1
+#define MAINPLLGRP_VCO1_NUMER 191
+#define PERPLLGRP_CNTR2CLK_CNT 7
+#define PERPLLGRP_CNTR2CLK_SRC 1
+#define PERPLLGRP_CNTR3CLK_CNT 900
+#define PERPLLGRP_CNTR3CLK_SRC 1
+#define PERPLLGRP_CNTR4CLK_CNT 19
+#define PERPLLGRP_CNTR4CLK_SRC 1
+#define PERPLLGRP_CNTR5CLK_CNT 499
+#define PERPLLGRP_CNTR5CLK_SRC 1
+#define PERPLLGRP_CNTR6CLK_CNT 900
+#define PERPLLGRP_CNTR6CLK_SRC 1
+#define PERPLLGRP_CNTR7CLK_CNT 900
+#define PERPLLGRP_CNTR8CLK_CNT 900
+#define PERPLLGRP_CNTR8CLK_SRC 0
+#define PERPLLGRP_CNTR9CLK_CNT 900
+#define PERPLLGRP_EMACCTL_EMAC0SEL 0
+#define PERPLLGRP_EMACCTL_EMAC1SEL 0
+#define PERPLLGRP_EMACCTL_EMAC2SEL 0
+#define PERPLLGRP_GPIODIV_GPIODBCLK 32000
+#define PERPLLGRP_VCO0_PSRC 0
+#define PERPLLGRP_VCO1_DENOM 1
+#define PERPLLGRP_VCO1_NUMER 159
+#define CLKMGR_TESTIOCTRL_DEBUGCLKSEL 16
+#define CLKMGR_TESTIOCTRL_MAINCLKSEL 8
+#define CLKMGR_TESTIOCTRL_PERICLKSEL 8
+#define ALTERAGRP_MPUCLK_MAINCNT 1
+#define ALTERAGRP_MPUCLK_PERICNT 900
+#define ALTERAGRP_NOCCLK_MAINCNT 11
+#define ALTERAGRP_NOCCLK_PERICNT 900
+#define ALTERAGRP_MPUCLK ((ALTERAGRP_MPUCLK_PERICNT << 16) | \
+	(ALTERAGRP_MPUCLK_MAINCNT))
+#define ALTERAGRP_NOCCLK ((ALTERAGRP_NOCCLK_PERICNT << 16) | \
+	(ALTERAGRP_NOCCLK_MAINCNT))
+
+/* Pin Mux Configuration */
+#define CFG_IO_10_INPUT_BUF_EN 0
+#define CFG_IO_10_PD_DRV_STRG 10
+#define CFG_IO_10_PD_SLW_RT 1
+#define CFG_IO_10_PU_DRV_STRG 8
+#define CFG_IO_10_PU_SLW_RT 1
+#define CFG_IO_10_RTRIM 1
+#define CFG_IO_10_WK_PU_EN 0
+#define CFG_IO_11_INPUT_BUF_EN 0
+#define CFG_IO_11_PD_DRV_STRG 10
+#define CFG_IO_11_PD_SLW_RT 1
+#define CFG_IO_11_PU_DRV_STRG 8
+#define CFG_IO_11_PU_SLW_RT 1
+#define CFG_IO_11_RTRIM 1
+#define CFG_IO_11_WK_PU_EN 0
+#define CFG_IO_12_INPUT_BUF_EN 1
+#define CFG_IO_12_PD_DRV_STRG 10
+#define CFG_IO_12_PD_SLW_RT 1
+#define CFG_IO_12_PU_DRV_STRG 8
+#define CFG_IO_12_PU_SLW_RT 1
+#define CFG_IO_12_RTRIM 1
+#define CFG_IO_12_WK_PU_EN 0
+#define CFG_IO_13_INPUT_BUF_EN 0
+#define CFG_IO_13_PD_DRV_STRG 10
+#define CFG_IO_13_PD_SLW_RT 1
+#define CFG_IO_13_PU_DRV_STRG 8
+#define CFG_IO_13_PU_SLW_RT 1
+#define CFG_IO_13_RTRIM 1
+#define CFG_IO_13_WK_PU_EN 0
+#define CFG_IO_14_INPUT_BUF_EN 1
+#define CFG_IO_14_PD_DRV_STRG 10
+#define CFG_IO_14_PD_SLW_RT 1
+#define CFG_IO_14_PU_DRV_STRG 8
+#define CFG_IO_14_PU_SLW_RT 1
+#define CFG_IO_14_RTRIM 1
+#define CFG_IO_14_WK_PU_EN 0
+#define CFG_IO_15_INPUT_BUF_EN 1
+#define CFG_IO_15_PD_DRV_STRG 10
+#define CFG_IO_15_PD_SLW_RT 1
+#define CFG_IO_15_PU_DRV_STRG 8
+#define CFG_IO_15_PU_SLW_RT 1
+#define CFG_IO_15_RTRIM 1
+#define CFG_IO_15_WK_PU_EN 0
+#define CFG_IO_16_INPUT_BUF_EN 1
+#define CFG_IO_16_PD_DRV_STRG 10
+#define CFG_IO_16_PD_SLW_RT 1
+#define CFG_IO_16_PU_DRV_STRG 8
+#define CFG_IO_16_PU_SLW_RT 1
+#define CFG_IO_16_RTRIM 1
+#define CFG_IO_16_WK_PU_EN 0
+#define CFG_IO_17_INPUT_BUF_EN 1
+#define CFG_IO_17_PD_DRV_STRG 10
+#define CFG_IO_17_PD_SLW_RT 1
+#define CFG_IO_17_PU_DRV_STRG 8
+#define CFG_IO_17_PU_SLW_RT 1
+#define CFG_IO_17_RTRIM 1
+#define CFG_IO_17_WK_PU_EN 0
+#define CFG_IO_1_INPUT_BUF_EN 1
+#define CFG_IO_1_PD_DRV_STRG 10
+#define CFG_IO_1_PD_SLW_RT 0
+#define CFG_IO_1_PU_DRV_STRG 8
+#define CFG_IO_1_PU_SLW_RT 0
+#define CFG_IO_1_RTRIM 1
+#define CFG_IO_1_WK_PU_EN 1
+#define CFG_IO_2_INPUT_BUF_EN 1
+#define CFG_IO_2_PD_DRV_STRG 10
+#define CFG_IO_2_PD_SLW_RT 0
+#define CFG_IO_2_PU_DRV_STRG 8
+#define CFG_IO_2_PU_SLW_RT 0
+#define CFG_IO_2_RTRIM 1
+#define CFG_IO_2_WK_PU_EN 1
+#define CFG_IO_3_INPUT_BUF_EN 1
+#define CFG_IO_3_PD_DRV_STRG 10
+#define CFG_IO_3_PD_SLW_RT 0
+#define CFG_IO_3_PU_DRV_STRG 8
+#define CFG_IO_3_PU_SLW_RT 0
+#define CFG_IO_3_RTRIM 1
+#define CFG_IO_3_WK_PU_EN 1
+#define CFG_IO_4_INPUT_BUF_EN 1
+#define CFG_IO_4_PD_DRV_STRG 10
+#define CFG_IO_4_PD_SLW_RT 1
+#define CFG_IO_4_PU_DRV_STRG 8
+#define CFG_IO_4_PU_SLW_RT 1
+#define CFG_IO_4_RTRIM 1
+#define CFG_IO_4_WK_PU_EN 0
+#define CFG_IO_5_INPUT_BUF_EN 1
+#define CFG_IO_5_PD_DRV_STRG 10
+#define CFG_IO_5_PD_SLW_RT 1
+#define CFG_IO_5_PU_DRV_STRG 8
+#define CFG_IO_5_PU_SLW_RT 1
+#define CFG_IO_5_RTRIM 1
+#define CFG_IO_5_WK_PU_EN 0
+#define CFG_IO_6_INPUT_BUF_EN 0
+#define CFG_IO_6_PD_DRV_STRG 10
+#define CFG_IO_6_PD_SLW_RT 1
+#define CFG_IO_6_PU_DRV_STRG 8
+#define CFG_IO_6_PU_SLW_RT 1
+#define CFG_IO_6_RTRIM 1
+#define CFG_IO_6_WK_PU_EN 0
+#define CFG_IO_7_INPUT_BUF_EN 0
+#define CFG_IO_7_PD_DRV_STRG 10
+#define CFG_IO_7_PD_SLW_RT 1
+#define CFG_IO_7_PU_DRV_STRG 8
+#define CFG_IO_7_PU_SLW_RT 1
+#define CFG_IO_7_RTRIM 1
+#define CFG_IO_7_WK_PU_EN 0
+#define CFG_IO_8_INPUT_BUF_EN 1
+#define CFG_IO_8_PD_DRV_STRG 10
+#define CFG_IO_8_PD_SLW_RT 1
+#define CFG_IO_8_PU_DRV_STRG 8
+#define CFG_IO_8_PU_SLW_RT 1
+#define CFG_IO_8_RTRIM 1
+#define CFG_IO_8_WK_PU_EN 0
+#define CFG_IO_9_INPUT_BUF_EN 1
+#define CFG_IO_9_PD_DRV_STRG 10
+#define CFG_IO_9_PD_SLW_RT 1
+#define CFG_IO_9_PU_DRV_STRG 8
+#define CFG_IO_9_PU_SLW_RT 1
+#define CFG_IO_9_RTRIM 1
+#define CFG_IO_9_WK_PU_EN 0
+#define CFG_IO_BANK_VOLTAGE_SEL_CLKRST_IO 1
+#define CFG_IO_BANK_VOLTAGE_SEL_PERI_IO 1
+#define PINMUX_DEDICATED_IO_10_SEL 14
+#define PINMUX_DEDICATED_IO_11_SEL 14
+#define PINMUX_DEDICATED_IO_12_SEL 14
+#define PINMUX_DEDICATED_IO_13_SEL 14
+#define PINMUX_DEDICATED_IO_14_SEL 14
+#define PINMUX_DEDICATED_IO_15_SEL 14
+#define PINMUX_DEDICATED_IO_16_SEL 14
+#define PINMUX_DEDICATED_IO_17_SEL 14
+#define PINMUX_DEDICATED_IO_4_SEL 14
+#define PINMUX_DEDICATED_IO_5_SEL 14
+#define PINMUX_DEDICATED_IO_6_SEL 14
+#define PINMUX_DEDICATED_IO_7_SEL 14
+#define PINMUX_DEDICATED_IO_8_SEL 14
+#define PINMUX_DEDICATED_IO_9_SEL 14
+#define PINMUX_I2C0_USEFPGA_SEL 0
+#define PINMUX_I2C1_USEFPGA_SEL 0
+#define PINMUX_I2CEMAC0_USEFPGA_SEL 0
+#define PINMUX_I2CEMAC1_USEFPGA_SEL 0
+#define PINMUX_I2CEMAC2_USEFPGA_SEL 0
+#define PINMUX_NAND_USEFPGA_SEL 0
+#define PINMUX_PLL_CLOCK_OUT_USEFPGA_SEL 0
+#define PINMUX_QSPI_USEFPGA_SEL 0
+#define PINMUX_RGMII0_USEFPGA_SEL 0
+#define PINMUX_RGMII1_USEFPGA_SEL 0
+#define PINMUX_RGMII2_USEFPGA_SEL 0
+#define PINMUX_SDMMC_USEFPGA_SEL 0
+#define PINMUX_SHARED_IO_Q1_10_SEL 8
+#define PINMUX_SHARED_IO_Q1_11_SEL 8
+#define PINMUX_SHARED_IO_Q1_12_SEL 8
+#define PINMUX_SHARED_IO_Q1_1_SEL 8
+#define PINMUX_SHARED_IO_Q1_2_SEL 8
+#define PINMUX_SHARED_IO_Q1_3_SEL 8
+#define PINMUX_SHARED_IO_Q1_4_SEL 8
+#define PINMUX_SHARED_IO_Q1_5_SEL 8
+#define PINMUX_SHARED_IO_Q1_6_SEL 8
+#define PINMUX_SHARED_IO_Q1_7_SEL 8
+#define PINMUX_SHARED_IO_Q1_8_SEL 8
+#define PINMUX_SHARED_IO_Q1_9_SEL 8
+#define PINMUX_SHARED_IO_Q2_10_SEL 4
+#define PINMUX_SHARED_IO_Q2_11_SEL 4
+#define PINMUX_SHARED_IO_Q2_12_SEL 4
+#define PINMUX_SHARED_IO_Q2_1_SEL 4
+#define PINMUX_SHARED_IO_Q2_2_SEL 4
+#define PINMUX_SHARED_IO_Q2_3_SEL 4
+#define PINMUX_SHARED_IO_Q2_4_SEL 4
+#define PINMUX_SHARED_IO_Q2_5_SEL 4
+#define PINMUX_SHARED_IO_Q2_6_SEL 4
+#define PINMUX_SHARED_IO_Q2_7_SEL 4
+#define PINMUX_SHARED_IO_Q2_8_SEL 4
+#define PINMUX_SHARED_IO_Q2_9_SEL 4
+#define PINMUX_SHARED_IO_Q3_10_SEL 10
+#define PINMUX_SHARED_IO_Q3_11_SEL 1
+#define PINMUX_SHARED_IO_Q3_12_SEL 1
+#define PINMUX_SHARED_IO_Q3_1_SEL 3
+#define PINMUX_SHARED_IO_Q3_2_SEL 3
+#define PINMUX_SHARED_IO_Q3_3_SEL 3
+#define PINMUX_SHARED_IO_Q3_4_SEL 3
+#define PINMUX_SHARED_IO_Q3_5_SEL 3
+#define PINMUX_SHARED_IO_Q3_6_SEL 15
+#define PINMUX_SHARED_IO_Q3_7_SEL 13
+#define PINMUX_SHARED_IO_Q3_8_SEL 13
+#define PINMUX_SHARED_IO_Q3_9_SEL 10
+#define PINMUX_SHARED_IO_Q4_10_SEL 12
+#define PINMUX_SHARED_IO_Q4_11_SEL 12
+#define PINMUX_SHARED_IO_Q4_12_SEL 12
+#define PINMUX_SHARED_IO_Q4_1_SEL 0
+#define PINMUX_SHARED_IO_Q4_2_SEL 0
+#define PINMUX_SHARED_IO_Q4_3_SEL 15
+#define PINMUX_SHARED_IO_Q4_4_SEL 12
+#define PINMUX_SHARED_IO_Q4_5_SEL 15
+#define PINMUX_SHARED_IO_Q4_6_SEL 15
+#define PINMUX_SHARED_IO_Q4_7_SEL 10
+#define PINMUX_SHARED_IO_Q4_8_SEL 15
+#define PINMUX_SHARED_IO_Q4_9_SEL 12
+#define PINMUX_SPIM0_USEFPGA_SEL 0
+#define PINMUX_SPIM1_USEFPGA_SEL 0
+#define PINMUX_SPIS0_USEFPGA_SEL 0
+#define PINMUX_SPIS1_USEFPGA_SEL 0
+#define PINMUX_UART0_USEFPGA_SEL 0
+#define PINMUX_UART1_USEFPGA_SEL 0
+#define PINMUX_USB0_USEFPGA_SEL 0
+#define PINMUX_USB1_USEFPGA_SEL 0
+
+/* Bridge Configuration */
+#define F2H_AXI_SLAVE 1
+#define F2SDRAM0_AXI_SLAVE 1
+#define F2SDRAM1_AXI_SLAVE 0
+#define F2SDRAM2_AXI_SLAVE 1
+#define H2F_AXI_MASTER 1
+#define LWH2F_AXI_MASTER 1
+
+/* Voltage Select for CFG IO */
+#define CFG_IO_BANK_VSEL \
+	(((CFG_IO_BANK_VOLTAGE_SEL_CLKRST_IO & 0x3) << 8) | \
+	(CFG_IO_BANK_VOLTAGE_SEL_PERI_IO & 0x3))
+
+/* Macro for CFG IO bit mapping */
+#define CFG_IO_MACRO(NAME) (((NAME ## _RTRIM & 0xff) << 19) | \
+	((NAME ## _INPUT_BUF_EN & 0x3) << 17) | \
+	((NAME ## _WK_PU_EN & 0x1) << 16) | \
+	((NAME ## _PU_SLW_RT & 0x1) << 13) | \
+	((NAME ## _PU_DRV_STRG & 0xf) << 8) | \
+	((NAME ## _PD_SLW_RT & 0x1) << 5) | \
+	(NAME ## _PD_DRV_STRG & 0x1f))
+
+#endif /* __SOCFPGA_ARRIA10_CFG_H__ */
diff --git a/arch/arm/dts/socfpga_arria10_socdk_qspi-u-boot.dtsi b/arch/arm/dts/socfpga_arria10_socdk_qspi-u-boot.dtsi
new file mode 100644
index 00000000000..a38a0fd2411
--- /dev/null
+++ b/arch/arm/dts/socfpga_arria10_socdk_qspi-u-boot.dtsi
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0+ OR X11
+/*
+ * Copyright (C) 2022 Altera Corporation
+ *
+ *	These codes were based on handoffs
+ *	generated from both Qsys and Quartus.
+ */
+
+#include "socfpga_arria10_socdk_qspi_handoff.h"
+#include "socfpga_arria10-handoff.dtsi"
+#include "socfpga_arria10_handoff_u-boot.dtsi"
+#include "socfpga_arria10_socdk-u-boot.dtsi"
+
+/ {
+	aliases {
+		spi0 = &qspi;
+	};
+
+	fs_loader0: fs-loader {
+		bootph-all;
+		compatible = "u-boot,fs-loader";
+		sfconfig = <0 0 100000000 3>;
+	};
+};
+
+&fpga_mgr {
+	bootph-all;
+	firmware-loader = <&fs_loader0>;
+	altr,bitstream = "300000";
+};
+
+&l4_main_clk {
+	bootph-all;
+};
+
+&qspi_clk {
+	bootph-all;
+};
+
+&qspi {
+	bootph-all;
+
+	flash0: n25q00a@0 {
+		cdns,page-size = <256>;
+		cdns,block-size = <16>;
+		/delete-property/ cdns,read-delay;
+	};
+};
diff --git a/arch/arm/dts/socfpga_arria10_socdk_qspi_handoff.h b/arch/arm/dts/socfpga_arria10_socdk_qspi_handoff.h
new file mode 100644
index 00000000000..64af51cf26b
--- /dev/null
+++ b/arch/arm/dts/socfpga_arria10_socdk_qspi_handoff.h
@@ -0,0 +1,305 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Altera Arria 10 SoCFPGA configuration
+ */
+
+#ifndef __SOCFPGA_ARRIA10_CFG_H__
+#define __SOCFPGA_ARRIA10_CFG_H__
+
+/* Clocks */
+#define CB_INTOSC_LS_CLK_HZ 60000000
+#define EMAC0_CLK_HZ 250000000
+#define EMAC1_CLK_HZ 250000000
+#define EMAC2_CLK_HZ 250000000
+#define EOSC1_CLK_HZ 25000000
+#define F2H_FREE_CLK_HZ 200000000
+#define H2F_USER0_CLK_HZ 400000000
+#define H2F_USER1_CLK_HZ 400000000
+#define L3_MAIN_FREE_CLK_HZ 200000000
+#define SDMMC_CLK_HZ 200000000
+#define TPIU_CLK_HZ 100000000
+#define MAINPLLGRP_CNTR15CLK_CNT 900
+#define MAINPLLGRP_CNTR2CLK_CNT 900
+#define MAINPLLGRP_CNTR3CLK_CNT 900
+#define MAINPLLGRP_CNTR4CLK_CNT 900
+#define MAINPLLGRP_CNTR5CLK_CNT 900
+#define MAINPLLGRP_CNTR6CLK_CNT 900
+#define MAINPLLGRP_CNTR7CLK_CNT 900
+#define MAINPLLGRP_CNTR7CLK_SRC 0
+#define MAINPLLGRP_CNTR8CLK_CNT 900
+#define MAINPLLGRP_CNTR9CLK_CNT 900
+#define MAINPLLGRP_CNTR9CLK_SRC 0
+#define MAINPLLGRP_MPUCLK_CNT 0
+#define MAINPLLGRP_MPUCLK_SRC 0
+#define MAINPLLGRP_NOCCLK_CNT 0
+#define MAINPLLGRP_NOCCLK_SRC 0
+#define MAINPLLGRP_NOCDIV_CSATCLK 0
+#define MAINPLLGRP_NOCDIV_CSPDBGCLK 1
+#define MAINPLLGRP_NOCDIV_CSTRACECLK 1
+#define MAINPLLGRP_NOCDIV_L4MAINCLK 0
+#define MAINPLLGRP_NOCDIV_L4MPCLK 0
+#define MAINPLLGRP_NOCDIV_L4SPCLK 2
+#define MAINPLLGRP_VCO0_PSRC 0
+#define MAINPLLGRP_VCO1_DENOM 1
+#define MAINPLLGRP_VCO1_NUMER 191
+#define PERPLLGRP_CNTR2CLK_CNT 7
+#define PERPLLGRP_CNTR2CLK_SRC 1
+#define PERPLLGRP_CNTR3CLK_CNT 900
+#define PERPLLGRP_CNTR3CLK_SRC 1
+#define PERPLLGRP_CNTR4CLK_CNT 19
+#define PERPLLGRP_CNTR4CLK_SRC 1
+#define PERPLLGRP_CNTR5CLK_CNT 499
+#define PERPLLGRP_CNTR5CLK_SRC 1
+#define PERPLLGRP_CNTR6CLK_CNT 900
+#define PERPLLGRP_CNTR6CLK_SRC 1
+#define PERPLLGRP_CNTR7CLK_CNT 900
+#define PERPLLGRP_CNTR8CLK_CNT 900
+#define PERPLLGRP_CNTR8CLK_SRC 0
+#define PERPLLGRP_CNTR9CLK_CNT 900
+#define PERPLLGRP_EMACCTL_EMAC0SEL 0
+#define PERPLLGRP_EMACCTL_EMAC1SEL 0
+#define PERPLLGRP_EMACCTL_EMAC2SEL 0
+#define PERPLLGRP_GPIODIV_GPIODBCLK 32000
+#define PERPLLGRP_VCO0_PSRC 0
+#define PERPLLGRP_VCO1_DENOM 1
+#define PERPLLGRP_VCO1_NUMER 159
+#define CLKMGR_TESTIOCTRL_DEBUGCLKSEL 16
+#define CLKMGR_TESTIOCTRL_MAINCLKSEL 8
+#define CLKMGR_TESTIOCTRL_PERICLKSEL 8
+#define ALTERAGRP_MPUCLK_MAINCNT 1
+#define ALTERAGRP_MPUCLK_PERICNT 900
+#define ALTERAGRP_NOCCLK_MAINCNT 11
+#define ALTERAGRP_NOCCLK_PERICNT 900
+#define ALTERAGRP_MPUCLK ((ALTERAGRP_MPUCLK_PERICNT << 16) | \
+	(ALTERAGRP_MPUCLK_MAINCNT))
+#define ALTERAGRP_NOCCLK ((ALTERAGRP_NOCCLK_PERICNT << 16) | \
+	(ALTERAGRP_NOCCLK_MAINCNT))
+
+/* Pin Mux Configuration */
+#define CFG_IO_10_INPUT_BUF_EN 0
+#define CFG_IO_10_PD_DRV_STRG 0
+#define CFG_IO_10_PD_SLW_RT 0
+#define CFG_IO_10_PU_DRV_STRG 0
+#define CFG_IO_10_PU_SLW_RT 0
+#define CFG_IO_10_RTRIM 1
+#define CFG_IO_10_WK_PU_EN 1
+#define CFG_IO_11_INPUT_BUF_EN 0
+#define CFG_IO_11_PD_DRV_STRG 0
+#define CFG_IO_11_PD_SLW_RT 0
+#define CFG_IO_11_PU_DRV_STRG 0
+#define CFG_IO_11_PU_SLW_RT 0
+#define CFG_IO_11_RTRIM 1
+#define CFG_IO_11_WK_PU_EN 1
+#define CFG_IO_12_INPUT_BUF_EN 0
+#define CFG_IO_12_PD_DRV_STRG 0
+#define CFG_IO_12_PD_SLW_RT 0
+#define CFG_IO_12_PU_DRV_STRG 0
+#define CFG_IO_12_PU_SLW_RT 0
+#define CFG_IO_12_RTRIM 1
+#define CFG_IO_12_WK_PU_EN 1
+#define CFG_IO_13_INPUT_BUF_EN 0
+#define CFG_IO_13_PD_DRV_STRG 0
+#define CFG_IO_13_PD_SLW_RT 0
+#define CFG_IO_13_PU_DRV_STRG 0
+#define CFG_IO_13_PU_SLW_RT 0
+#define CFG_IO_13_RTRIM 1
+#define CFG_IO_13_WK_PU_EN 1
+#define CFG_IO_14_INPUT_BUF_EN 0
+#define CFG_IO_14_PD_DRV_STRG 0
+#define CFG_IO_14_PD_SLW_RT 0
+#define CFG_IO_14_PU_DRV_STRG 0
+#define CFG_IO_14_PU_SLW_RT 0
+#define CFG_IO_14_RTRIM 1
+#define CFG_IO_14_WK_PU_EN 1
+#define CFG_IO_15_INPUT_BUF_EN 0
+#define CFG_IO_15_PD_DRV_STRG 0
+#define CFG_IO_15_PD_SLW_RT 0
+#define CFG_IO_15_PU_DRV_STRG 0
+#define CFG_IO_15_PU_SLW_RT 0
+#define CFG_IO_15_RTRIM 1
+#define CFG_IO_15_WK_PU_EN 1
+#define CFG_IO_16_INPUT_BUF_EN 0
+#define CFG_IO_16_PD_DRV_STRG 10
+#define CFG_IO_16_PD_SLW_RT 1
+#define CFG_IO_16_PU_DRV_STRG 8
+#define CFG_IO_16_PU_SLW_RT 1
+#define CFG_IO_16_RTRIM 1
+#define CFG_IO_16_WK_PU_EN 0
+#define CFG_IO_17_INPUT_BUF_EN 1
+#define CFG_IO_17_PD_DRV_STRG 10
+#define CFG_IO_17_PD_SLW_RT 1
+#define CFG_IO_17_PU_DRV_STRG 8
+#define CFG_IO_17_PU_SLW_RT 1
+#define CFG_IO_17_RTRIM 1
+#define CFG_IO_17_WK_PU_EN 0
+#define CFG_IO_1_INPUT_BUF_EN 1
+#define CFG_IO_1_PD_DRV_STRG 10
+#define CFG_IO_1_PD_SLW_RT 0
+#define CFG_IO_1_PU_DRV_STRG 8
+#define CFG_IO_1_PU_SLW_RT 0
+#define CFG_IO_1_RTRIM 1
+#define CFG_IO_1_WK_PU_EN 1
+#define CFG_IO_2_INPUT_BUF_EN 1
+#define CFG_IO_2_PD_DRV_STRG 10
+#define CFG_IO_2_PD_SLW_RT 0
+#define CFG_IO_2_PU_DRV_STRG 8
+#define CFG_IO_2_PU_SLW_RT 0
+#define CFG_IO_2_RTRIM 1
+#define CFG_IO_2_WK_PU_EN 1
+#define CFG_IO_3_INPUT_BUF_EN 1
+#define CFG_IO_3_PD_DRV_STRG 10
+#define CFG_IO_3_PD_SLW_RT 0
+#define CFG_IO_3_PU_DRV_STRG 8
+#define CFG_IO_3_PU_SLW_RT 0
+#define CFG_IO_3_RTRIM 1
+#define CFG_IO_3_WK_PU_EN 1
+#define CFG_IO_4_INPUT_BUF_EN 0
+#define CFG_IO_4_PD_DRV_STRG 10
+#define CFG_IO_4_PD_SLW_RT 1
+#define CFG_IO_4_PU_DRV_STRG 8
+#define CFG_IO_4_PU_SLW_RT 1
+#define CFG_IO_4_RTRIM 1
+#define CFG_IO_4_WK_PU_EN 0
+#define CFG_IO_5_INPUT_BUF_EN 1
+#define CFG_IO_5_PD_DRV_STRG 10
+#define CFG_IO_5_PD_SLW_RT 1
+#define CFG_IO_5_PU_DRV_STRG 8
+#define CFG_IO_5_PU_SLW_RT 1
+#define CFG_IO_5_RTRIM 1
+#define CFG_IO_5_WK_PU_EN 0
+#define CFG_IO_6_INPUT_BUF_EN 0
+#define CFG_IO_6_PD_DRV_STRG 10
+#define CFG_IO_6_PD_SLW_RT 1
+#define CFG_IO_6_PU_DRV_STRG 8
+#define CFG_IO_6_PU_SLW_RT 1
+#define CFG_IO_6_RTRIM 1
+#define CFG_IO_6_WK_PU_EN 0
+#define CFG_IO_7_INPUT_BUF_EN 1
+#define CFG_IO_7_PD_DRV_STRG 10
+#define CFG_IO_7_PD_SLW_RT 1
+#define CFG_IO_7_PU_DRV_STRG 8
+#define CFG_IO_7_PU_SLW_RT 1
+#define CFG_IO_7_RTRIM 1
+#define CFG_IO_7_WK_PU_EN 0
+#define CFG_IO_8_INPUT_BUF_EN 1
+#define CFG_IO_8_PD_DRV_STRG 10
+#define CFG_IO_8_PD_SLW_RT 1
+#define CFG_IO_8_PU_DRV_STRG 8
+#define CFG_IO_8_PU_SLW_RT 1
+#define CFG_IO_8_RTRIM 1
+#define CFG_IO_8_WK_PU_EN 0
+#define CFG_IO_9_INPUT_BUF_EN 1
+#define CFG_IO_9_PD_DRV_STRG 10
+#define CFG_IO_9_PD_SLW_RT 1
+#define CFG_IO_9_PU_DRV_STRG 8
+#define CFG_IO_9_PU_SLW_RT 1
+#define CFG_IO_9_RTRIM 1
+#define CFG_IO_9_WK_PU_EN 0
+#define CFG_IO_BANK_VOLTAGE_SEL_CLKRST_IO 1
+#define CFG_IO_BANK_VOLTAGE_SEL_PERI_IO 1
+#define PINMUX_DEDICATED_IO_10_SEL 10
+#define PINMUX_DEDICATED_IO_11_SEL 10
+#define PINMUX_DEDICATED_IO_12_SEL 10
+#define PINMUX_DEDICATED_IO_13_SEL 10
+#define PINMUX_DEDICATED_IO_14_SEL 10
+#define PINMUX_DEDICATED_IO_15_SEL 10
+#define PINMUX_DEDICATED_IO_16_SEL 13
+#define PINMUX_DEDICATED_IO_17_SEL 13
+#define PINMUX_DEDICATED_IO_4_SEL 4
+#define PINMUX_DEDICATED_IO_5_SEL 4
+#define PINMUX_DEDICATED_IO_6_SEL 4
+#define PINMUX_DEDICATED_IO_7_SEL 4
+#define PINMUX_DEDICATED_IO_8_SEL 4
+#define PINMUX_DEDICATED_IO_9_SEL 4
+#define PINMUX_I2C0_USEFPGA_SEL 0
+#define PINMUX_I2C1_USEFPGA_SEL 0
+#define PINMUX_I2CEMAC0_USEFPGA_SEL 0
+#define PINMUX_I2CEMAC1_USEFPGA_SEL 0
+#define PINMUX_I2CEMAC2_USEFPGA_SEL 0
+#define PINMUX_NAND_USEFPGA_SEL 0
+#define PINMUX_PLL_CLOCK_OUT_USEFPGA_SEL 0
+#define PINMUX_QSPI_USEFPGA_SEL 0
+#define PINMUX_RGMII0_USEFPGA_SEL 0
+#define PINMUX_RGMII1_USEFPGA_SEL 0
+#define PINMUX_RGMII2_USEFPGA_SEL 0
+#define PINMUX_SDMMC_USEFPGA_SEL 0
+#define PINMUX_SHARED_IO_Q1_10_SEL 8
+#define PINMUX_SHARED_IO_Q1_11_SEL 8
+#define PINMUX_SHARED_IO_Q1_12_SEL 8
+#define PINMUX_SHARED_IO_Q1_1_SEL 8
+#define PINMUX_SHARED_IO_Q1_2_SEL 8
+#define PINMUX_SHARED_IO_Q1_3_SEL 8
+#define PINMUX_SHARED_IO_Q1_4_SEL 8
+#define PINMUX_SHARED_IO_Q1_5_SEL 8
+#define PINMUX_SHARED_IO_Q1_6_SEL 8
+#define PINMUX_SHARED_IO_Q1_7_SEL 8
+#define PINMUX_SHARED_IO_Q1_8_SEL 8
+#define PINMUX_SHARED_IO_Q1_9_SEL 8
+#define PINMUX_SHARED_IO_Q2_10_SEL 4
+#define PINMUX_SHARED_IO_Q2_11_SEL 4
+#define PINMUX_SHARED_IO_Q2_12_SEL 4
+#define PINMUX_SHARED_IO_Q2_1_SEL 4
+#define PINMUX_SHARED_IO_Q2_2_SEL 4
+#define PINMUX_SHARED_IO_Q2_3_SEL 4
+#define PINMUX_SHARED_IO_Q2_4_SEL 4
+#define PINMUX_SHARED_IO_Q2_5_SEL 4
+#define PINMUX_SHARED_IO_Q2_6_SEL 4
+#define PINMUX_SHARED_IO_Q2_7_SEL 4
+#define PINMUX_SHARED_IO_Q2_8_SEL 4
+#define PINMUX_SHARED_IO_Q2_9_SEL 4
+#define PINMUX_SHARED_IO_Q3_10_SEL 10
+#define PINMUX_SHARED_IO_Q3_11_SEL 1
+#define PINMUX_SHARED_IO_Q3_12_SEL 1
+#define PINMUX_SHARED_IO_Q3_1_SEL 3
+#define PINMUX_SHARED_IO_Q3_2_SEL 3
+#define PINMUX_SHARED_IO_Q3_3_SEL 3
+#define PINMUX_SHARED_IO_Q3_4_SEL 3
+#define PINMUX_SHARED_IO_Q3_5_SEL 3
+#define PINMUX_SHARED_IO_Q3_6_SEL 15
+#define PINMUX_SHARED_IO_Q3_7_SEL 10
+#define PINMUX_SHARED_IO_Q3_8_SEL 10
+#define PINMUX_SHARED_IO_Q3_9_SEL 10
+#define PINMUX_SHARED_IO_Q4_10_SEL 12
+#define PINMUX_SHARED_IO_Q4_11_SEL 12
+#define PINMUX_SHARED_IO_Q4_12_SEL 12
+#define PINMUX_SHARED_IO_Q4_1_SEL 0
+#define PINMUX_SHARED_IO_Q4_2_SEL 0
+#define PINMUX_SHARED_IO_Q4_3_SEL 15
+#define PINMUX_SHARED_IO_Q4_4_SEL 12
+#define PINMUX_SHARED_IO_Q4_5_SEL 15
+#define PINMUX_SHARED_IO_Q4_6_SEL 15
+#define PINMUX_SHARED_IO_Q4_7_SEL 10
+#define PINMUX_SHARED_IO_Q4_8_SEL 15
+#define PINMUX_SHARED_IO_Q4_9_SEL 12
+#define PINMUX_SPIM0_USEFPGA_SEL 0
+#define PINMUX_SPIM1_USEFPGA_SEL 0
+#define PINMUX_SPIS0_USEFPGA_SEL 0
+#define PINMUX_SPIS1_USEFPGA_SEL 0
+#define PINMUX_UART0_USEFPGA_SEL 0
+#define PINMUX_UART1_USEFPGA_SEL 0
+#define PINMUX_USB0_USEFPGA_SEL 0
+#define PINMUX_USB1_USEFPGA_SEL 0
+
+/* Bridge Configuration */
+#define F2H_AXI_SLAVE 1
+#define F2SDRAM0_AXI_SLAVE 1
+#define F2SDRAM1_AXI_SLAVE 0
+#define F2SDRAM2_AXI_SLAVE 1
+#define H2F_AXI_MASTER 1
+#define LWH2F_AXI_MASTER 1
+
+/* Voltage Select for CFG IO */
+#define CFG_IO_BANK_VSEL \
+	(((CFG_IO_BANK_VOLTAGE_SEL_CLKRST_IO & 0x3) << 8) | \
+	(CFG_IO_BANK_VOLTAGE_SEL_PERI_IO & 0x3))
+
+/* Macro for CFG IO bit mapping */
+#define CFG_IO_MACRO(NAME) (((NAME ## _RTRIM & 0xff) << 19) | \
+	((NAME ## _INPUT_BUF_EN & 0x3) << 17) | \
+	((NAME ## _WK_PU_EN & 0x1) << 16) | \
+	((NAME ## _PU_SLW_RT & 0x1) << 13) | \
+	((NAME ## _PU_DRV_STRG & 0xf) << 8) | \
+	((NAME ## _PD_SLW_RT & 0x1) << 5) | \
+	(NAME ## _PD_DRV_STRG & 0x1f))
+
+#endif /* __SOCFPGA_ARRIA10_CFG_H__ */
diff --git a/arch/arm/dts/socfpga_arria10_socdk_sdmmc_handoff.h b/arch/arm/dts/socfpga_arria10_socdk_sdmmc_handoff.h
index 4e3fe305787..56f7c648207 100644
--- a/arch/arm/dts/socfpga_arria10_socdk_sdmmc_handoff.h
+++ b/arch/arm/dts/socfpga_arria10_socdk_sdmmc_handoff.h
@@ -1,10 +1,10 @@
 // SPDX-License-Identifier: BSD-3-Clause
 /*
- * Intel Arria 10 SoCFPGA configuration
+ * Altera Arria 10 SoCFPGA configuration
  */
 
-#ifndef __SOCFPGA_ARRIA10_CONFIG_H__
-#define __SOCFPGA_ARRIA10_CONFIG_H__
+#ifndef __SOCFPGA_ARRIA10_CFG_H__
+#define __SOCFPGA_ARRIA10_CFG_H__
 
 /* Clocks */
 #define CB_INTOSC_LS_CLK_HZ 60000000
@@ -76,127 +76,127 @@
 	(ALTERAGRP_NOCCLK_MAINCNT))
 
 /* Pin Mux Configuration */
-#define CONFIG_IO_10_INPUT_BUF_EN 0
-#define CONFIG_IO_10_PD_DRV_STRG 0
-#define CONFIG_IO_10_PD_SLW_RT 0
-#define CONFIG_IO_10_PU_DRV_STRG 0
-#define CONFIG_IO_10_PU_SLW_RT 0
-#define CONFIG_IO_10_RTRIM 1
-#define CONFIG_IO_10_WK_PU_EN 1
-#define CONFIG_IO_11_INPUT_BUF_EN 0
-#define CONFIG_IO_11_PD_DRV_STRG 0
-#define CONFIG_IO_11_PD_SLW_RT 0
-#define CONFIG_IO_11_PU_DRV_STRG 0
-#define CONFIG_IO_11_PU_SLW_RT 0
-#define CONFIG_IO_11_RTRIM 1
-#define CONFIG_IO_11_WK_PU_EN 1
-#define CONFIG_IO_12_INPUT_BUF_EN 1
-#define CONFIG_IO_12_PD_DRV_STRG 10
-#define CONFIG_IO_12_PD_SLW_RT 1
-#define CONFIG_IO_12_PU_DRV_STRG 8
-#define CONFIG_IO_12_PU_SLW_RT 1
-#define CONFIG_IO_12_RTRIM 1
-#define CONFIG_IO_12_WK_PU_EN 1
-#define CONFIG_IO_13_INPUT_BUF_EN 1
-#define CONFIG_IO_13_PD_DRV_STRG 10
-#define CONFIG_IO_13_PD_SLW_RT 1
-#define CONFIG_IO_13_PU_DRV_STRG 8
-#define CONFIG_IO_13_PU_SLW_RT 1
-#define CONFIG_IO_13_RTRIM 1
-#define CONFIG_IO_13_WK_PU_EN 1
-#define CONFIG_IO_14_INPUT_BUF_EN 1
-#define CONFIG_IO_14_PD_DRV_STRG 10
-#define CONFIG_IO_14_PD_SLW_RT 1
-#define CONFIG_IO_14_PU_DRV_STRG 8
-#define CONFIG_IO_14_PU_SLW_RT 1
-#define CONFIG_IO_14_RTRIM 1
-#define CONFIG_IO_14_WK_PU_EN 1
-#define CONFIG_IO_15_INPUT_BUF_EN 1
-#define CONFIG_IO_15_PD_DRV_STRG 10
-#define CONFIG_IO_15_PD_SLW_RT 1
-#define CONFIG_IO_15_PU_DRV_STRG 8
-#define CONFIG_IO_15_PU_SLW_RT 1
-#define CONFIG_IO_15_RTRIM 1
-#define CONFIG_IO_15_WK_PU_EN 1
-#define CONFIG_IO_16_INPUT_BUF_EN 0
-#define CONFIG_IO_16_PD_DRV_STRG 10
-#define CONFIG_IO_16_PD_SLW_RT 1
-#define CONFIG_IO_16_PU_DRV_STRG 8
-#define CONFIG_IO_16_PU_SLW_RT 1
-#define CONFIG_IO_16_RTRIM 1
-#define CONFIG_IO_16_WK_PU_EN 0
-#define CONFIG_IO_17_INPUT_BUF_EN 1
-#define CONFIG_IO_17_PD_DRV_STRG 10
-#define CONFIG_IO_17_PD_SLW_RT 1
-#define CONFIG_IO_17_PU_DRV_STRG 8
-#define CONFIG_IO_17_PU_SLW_RT 1
-#define CONFIG_IO_17_RTRIM 1
-#define CONFIG_IO_17_WK_PU_EN 0
-#define CONFIG_IO_1_INPUT_BUF_EN 1
-#define CONFIG_IO_1_PD_DRV_STRG 10
-#define CONFIG_IO_1_PD_SLW_RT 0
-#define CONFIG_IO_1_PU_DRV_STRG 8
-#define CONFIG_IO_1_PU_SLW_RT 0
-#define CONFIG_IO_1_RTRIM 1
-#define CONFIG_IO_1_WK_PU_EN 1
-#define CONFIG_IO_2_INPUT_BUF_EN 1
-#define CONFIG_IO_2_PD_DRV_STRG 10
-#define CONFIG_IO_2_PD_SLW_RT 0
-#define CONFIG_IO_2_PU_DRV_STRG 8
-#define CONFIG_IO_2_PU_SLW_RT 0
-#define CONFIG_IO_2_RTRIM 1
-#define CONFIG_IO_2_WK_PU_EN 1
-#define CONFIG_IO_3_INPUT_BUF_EN 1
-#define CONFIG_IO_3_PD_DRV_STRG 10
-#define CONFIG_IO_3_PD_SLW_RT 0
-#define CONFIG_IO_3_PU_DRV_STRG 8
-#define CONFIG_IO_3_PU_SLW_RT 0
-#define CONFIG_IO_3_RTRIM 1
-#define CONFIG_IO_3_WK_PU_EN 1
-#define CONFIG_IO_4_INPUT_BUF_EN 1
-#define CONFIG_IO_4_PD_DRV_STRG 10
-#define CONFIG_IO_4_PD_SLW_RT 1
-#define CONFIG_IO_4_PU_DRV_STRG 8
-#define CONFIG_IO_4_PU_SLW_RT 1
-#define CONFIG_IO_4_RTRIM 1
-#define CONFIG_IO_4_WK_PU_EN 0
-#define CONFIG_IO_5_INPUT_BUF_EN 1
-#define CONFIG_IO_5_PD_DRV_STRG 10
-#define CONFIG_IO_5_PD_SLW_RT 1
-#define CONFIG_IO_5_PU_DRV_STRG 8
-#define CONFIG_IO_5_PU_SLW_RT 1
-#define CONFIG_IO_5_RTRIM 1
-#define CONFIG_IO_5_WK_PU_EN 0
-#define CONFIG_IO_6_INPUT_BUF_EN 0
-#define CONFIG_IO_6_PD_DRV_STRG 10
-#define CONFIG_IO_6_PD_SLW_RT 1
-#define CONFIG_IO_6_PU_DRV_STRG 8
-#define CONFIG_IO_6_PU_SLW_RT 1
-#define CONFIG_IO_6_RTRIM 1
-#define CONFIG_IO_6_WK_PU_EN 0
-#define CONFIG_IO_7_INPUT_BUF_EN 1
-#define CONFIG_IO_7_PD_DRV_STRG 10
-#define CONFIG_IO_7_PD_SLW_RT 1
-#define CONFIG_IO_7_PU_DRV_STRG 8
-#define CONFIG_IO_7_PU_SLW_RT 1
-#define CONFIG_IO_7_RTRIM 1
-#define CONFIG_IO_7_WK_PU_EN 0
-#define CONFIG_IO_8_INPUT_BUF_EN 1
-#define CONFIG_IO_8_PD_DRV_STRG 10
-#define CONFIG_IO_8_PD_SLW_RT 1
-#define CONFIG_IO_8_PU_DRV_STRG 8
-#define CONFIG_IO_8_PU_SLW_RT 1
-#define CONFIG_IO_8_RTRIM 1
-#define CONFIG_IO_8_WK_PU_EN 0
-#define CONFIG_IO_9_INPUT_BUF_EN 1
-#define CONFIG_IO_9_PD_DRV_STRG 10
-#define CONFIG_IO_9_PD_SLW_RT 1
-#define CONFIG_IO_9_PU_DRV_STRG 8
-#define CONFIG_IO_9_PU_SLW_RT 1
-#define CONFIG_IO_9_RTRIM 1
-#define CONFIG_IO_9_WK_PU_EN 0
-#define CONFIG_IO_BANK_VOLTAGE_SEL_CLKRST_IO 1
-#define CONFIG_IO_BANK_VOLTAGE_SEL_PERI_IO 1
+#define CFG_IO_10_INPUT_BUF_EN 0
+#define CFG_IO_10_PD_DRV_STRG 0
+#define CFG_IO_10_PD_SLW_RT 0
+#define CFG_IO_10_PU_DRV_STRG 0
+#define CFG_IO_10_PU_SLW_RT 0
+#define CFG_IO_10_RTRIM 1
+#define CFG_IO_10_WK_PU_EN 1
+#define CFG_IO_11_INPUT_BUF_EN 0
+#define CFG_IO_11_PD_DRV_STRG 0
+#define CFG_IO_11_PD_SLW_RT 0
+#define CFG_IO_11_PU_DRV_STRG 0
+#define CFG_IO_11_PU_SLW_RT 0
+#define CFG_IO_11_RTRIM 1
+#define CFG_IO_11_WK_PU_EN 1
+#define CFG_IO_12_INPUT_BUF_EN 1
+#define CFG_IO_12_PD_DRV_STRG 10
+#define CFG_IO_12_PD_SLW_RT 1
+#define CFG_IO_12_PU_DRV_STRG 8
+#define CFG_IO_12_PU_SLW_RT 1
+#define CFG_IO_12_RTRIM 1
+#define CFG_IO_12_WK_PU_EN 1
+#define CFG_IO_13_INPUT_BUF_EN 1
+#define CFG_IO_13_PD_DRV_STRG 10
+#define CFG_IO_13_PD_SLW_RT 1
+#define CFG_IO_13_PU_DRV_STRG 8
+#define CFG_IO_13_PU_SLW_RT 1
+#define CFG_IO_13_RTRIM 1
+#define CFG_IO_13_WK_PU_EN 1
+#define CFG_IO_14_INPUT_BUF_EN 1
+#define CFG_IO_14_PD_DRV_STRG 10
+#define CFG_IO_14_PD_SLW_RT 1
+#define CFG_IO_14_PU_DRV_STRG 8
+#define CFG_IO_14_PU_SLW_RT 1
+#define CFG_IO_14_RTRIM 1
+#define CFG_IO_14_WK_PU_EN 1
+#define CFG_IO_15_INPUT_BUF_EN 1
+#define CFG_IO_15_PD_DRV_STRG 10
+#define CFG_IO_15_PD_SLW_RT 1
+#define CFG_IO_15_PU_DRV_STRG 8
+#define CFG_IO_15_PU_SLW_RT 1
+#define CFG_IO_15_RTRIM 1
+#define CFG_IO_15_WK_PU_EN 1
+#define CFG_IO_16_INPUT_BUF_EN 0
+#define CFG_IO_16_PD_DRV_STRG 10
+#define CFG_IO_16_PD_SLW_RT 1
+#define CFG_IO_16_PU_DRV_STRG 8
+#define CFG_IO_16_PU_SLW_RT 1
+#define CFG_IO_16_RTRIM 1
+#define CFG_IO_16_WK_PU_EN 0
+#define CFG_IO_17_INPUT_BUF_EN 1
+#define CFG_IO_17_PD_DRV_STRG 10
+#define CFG_IO_17_PD_SLW_RT 1
+#define CFG_IO_17_PU_DRV_STRG 8
+#define CFG_IO_17_PU_SLW_RT 1
+#define CFG_IO_17_RTRIM 1
+#define CFG_IO_17_WK_PU_EN 0
+#define CFG_IO_1_INPUT_BUF_EN 1
+#define CFG_IO_1_PD_DRV_STRG 10
+#define CFG_IO_1_PD_SLW_RT 0
+#define CFG_IO_1_PU_DRV_STRG 8
+#define CFG_IO_1_PU_SLW_RT 0
+#define CFG_IO_1_RTRIM 1
+#define CFG_IO_1_WK_PU_EN 1
+#define CFG_IO_2_INPUT_BUF_EN 1
+#define CFG_IO_2_PD_DRV_STRG 10
+#define CFG_IO_2_PD_SLW_RT 0
+#define CFG_IO_2_PU_DRV_STRG 8
+#define CFG_IO_2_PU_SLW_RT 0
+#define CFG_IO_2_RTRIM 1
+#define CFG_IO_2_WK_PU_EN 1
+#define CFG_IO_3_INPUT_BUF_EN 1
+#define CFG_IO_3_PD_DRV_STRG 10
+#define CFG_IO_3_PD_SLW_RT 0
+#define CFG_IO_3_PU_DRV_STRG 8
+#define CFG_IO_3_PU_SLW_RT 0
+#define CFG_IO_3_RTRIM 1
+#define CFG_IO_3_WK_PU_EN 1
+#define CFG_IO_4_INPUT_BUF_EN 1
+#define CFG_IO_4_PD_DRV_STRG 10
+#define CFG_IO_4_PD_SLW_RT 1
+#define CFG_IO_4_PU_DRV_STRG 8
+#define CFG_IO_4_PU_SLW_RT 1
+#define CFG_IO_4_RTRIM 1
+#define CFG_IO_4_WK_PU_EN 0
+#define CFG_IO_5_INPUT_BUF_EN 1
+#define CFG_IO_5_PD_DRV_STRG 10
+#define CFG_IO_5_PD_SLW_RT 1
+#define CFG_IO_5_PU_DRV_STRG 8
+#define CFG_IO_5_PU_SLW_RT 1
+#define CFG_IO_5_RTRIM 1
+#define CFG_IO_5_WK_PU_EN 0
+#define CFG_IO_6_INPUT_BUF_EN 0
+#define CFG_IO_6_PD_DRV_STRG 10
+#define CFG_IO_6_PD_SLW_RT 1
+#define CFG_IO_6_PU_DRV_STRG 8
+#define CFG_IO_6_PU_SLW_RT 1
+#define CFG_IO_6_RTRIM 1
+#define CFG_IO_6_WK_PU_EN 0
+#define CFG_IO_7_INPUT_BUF_EN 1
+#define CFG_IO_7_PD_DRV_STRG 10
+#define CFG_IO_7_PD_SLW_RT 1
+#define CFG_IO_7_PU_DRV_STRG 8
+#define CFG_IO_7_PU_SLW_RT 1
+#define CFG_IO_7_RTRIM 1
+#define CFG_IO_7_WK_PU_EN 0
+#define CFG_IO_8_INPUT_BUF_EN 1
+#define CFG_IO_8_PD_DRV_STRG 10
+#define CFG_IO_8_PD_SLW_RT 1
+#define CFG_IO_8_PU_DRV_STRG 8
+#define CFG_IO_8_PU_SLW_RT 1
+#define CFG_IO_8_RTRIM 1
+#define CFG_IO_8_WK_PU_EN 0
+#define CFG_IO_9_INPUT_BUF_EN 1
+#define CFG_IO_9_PD_DRV_STRG 10
+#define CFG_IO_9_PD_SLW_RT 1
+#define CFG_IO_9_PU_DRV_STRG 8
+#define CFG_IO_9_PU_SLW_RT 1
+#define CFG_IO_9_RTRIM 1
+#define CFG_IO_9_WK_PU_EN 0
+#define CFG_IO_BANK_VOLTAGE_SEL_CLKRST_IO 1
+#define CFG_IO_BANK_VOLTAGE_SEL_PERI_IO 1
 #define PINMUX_DEDICATED_IO_10_SEL 10
 #define PINMUX_DEDICATED_IO_11_SEL 10
 #define PINMUX_DEDICATED_IO_12_SEL 8
@@ -288,13 +288,13 @@
 #define H2F_AXI_MASTER 1
 #define LWH2F_AXI_MASTER 1
 
-/* Voltage Select for Config IO */
-#define CONFIG_IO_BANK_VSEL \
-	(((CONFIG_IO_BANK_VOLTAGE_SEL_CLKRST_IO & 0x3) << 8) | \
-	(CONFIG_IO_BANK_VOLTAGE_SEL_PERI_IO & 0x3))
+/* Voltage Select for CFG IO */
+#define CFG_IO_BANK_VSEL \
+	(((CFG_IO_BANK_VOLTAGE_SEL_CLKRST_IO & 0x3) << 8) | \
+	(CFG_IO_BANK_VOLTAGE_SEL_PERI_IO & 0x3))
 
-/* Macro for Config IO bit mapping */
-#define CONFIG_IO_MACRO(NAME) (((NAME ## _RTRIM & 0xff) << 19) | \
+/* Macro for CFG IO bit mapping */
+#define CFG_IO_MACRO(NAME) (((NAME ## _RTRIM & 0xff) << 19) | \
 	((NAME ## _INPUT_BUF_EN & 0x3) << 17) | \
 	((NAME ## _WK_PU_EN & 0x1) << 16) | \
 	((NAME ## _PU_SLW_RT & 0x1) << 13) | \
@@ -302,4 +302,4 @@
 	((NAME ## _PD_SLW_RT & 0x1) << 5) | \
 	(NAME ## _PD_DRV_STRG & 0x1f))
 
-#endif /* __SOCFPGA_ARRIA10_CONFIG_H__ */
+#endif /* __SOCFPGA_ARRIA10_CFG_H__ */
diff --git a/arch/arm/mach-socfpga/qts-filter-a10.sh b/arch/arm/mach-socfpga/qts-filter-a10.sh
index ab16522add5..8819c2051a7 100755
--- a/arch/arm/mach-socfpga/qts-filter-a10.sh
+++ b/arch/arm/mach-socfpga/qts-filter-a10.sh
@@ -25,11 +25,11 @@ process_a10_hps_config() {
 	(cat << EOF
 // SPDX-License-Identifier: BSD-3-Clause
 /*
- * Intel Arria 10 SoCFPGA configuration
+ * Altera Arria 10 SoCFPGA configuration
  */
 
-#ifndef __SOCFPGA_ARRIA10_CONFIG_H__
-#define __SOCFPGA_ARRIA10_CONFIG_H__
+#ifndef __SOCFPGA_ARRIA10_CFG_H__
+#define __SOCFPGA_ARRIA10_CFG_H__
 
 EOF
 
@@ -84,7 +84,7 @@ EOF
 			sed 's/SHARED_3V_IO_GRP_//' |
 			sed 's/FPGA_INTERFACE_GRP_//' |
 			sed 's/DEDICATED_IO_GRP_//' |
-			sed 's/CONFIGURATION_DEDICATED/CONFIG/' |
+			sed 's/CONFIGURATION_DEDICATED/CFG/' |
 			sort
 
 	echo
@@ -98,14 +98,14 @@ EOF
 			sort
 
 	echo
-	echo "/* Voltage Select for Config IO */"
-	echo "#define CONFIG_IO_BANK_VSEL \\"
-	echo "	(((CONFIG_IO_BANK_VOLTAGE_SEL_CLKRST_IO & 0x3) << 8) | \\"
-	echo "	(CONFIG_IO_BANK_VOLTAGE_SEL_PERI_IO & 0x3))"
+	echo "/* Voltage Select for CFG IO */"
+	echo "#define CFG_IO_BANK_VSEL \\"
+	echo "	(((CFG_IO_BANK_VOLTAGE_SEL_CLKRST_IO & 0x3) << 8) | \\"
+	echo "	(CFG_IO_BANK_VOLTAGE_SEL_PERI_IO & 0x3))"
 
 	echo
-	echo "/* Macro for Config IO bit mapping */"
-	echo -n "#define CONFIG_IO_MACRO(NAME) "
+	echo "/* Macro for CFG IO bit mapping */"
+	echo -n "#define CFG_IO_MACRO(NAME) "
 	echo "(((NAME ## _RTRIM & 0xff) << 19) | \\"
 	echo "	((NAME ## _INPUT_BUF_EN & 0x3) << 17) | \\"
 	echo "	((NAME ## _WK_PU_EN & 0x1) << 16) | \\"
@@ -116,7 +116,7 @@ EOF
 
 	cat << EOF
 
-#endif /* __SOCFPGA_ARRIA10_CONFIG_H__ */
+#endif /* __SOCFPGA_ARRIA10_CFG_H__ */
 EOF
 	) > "${outfile}"
 }
-- 
2.43.7

