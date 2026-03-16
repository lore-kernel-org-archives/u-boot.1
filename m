Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6DDF013C5
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 08:05:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02DBE83F9A;
	Mon, 16 Mar 2026 09:05:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uRdsY0vw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04BB083DA6; Mon, 16 Mar 2026 09:05:06 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39FA783DA6
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 09:05:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npuMea9KvaO/fi+Qq/6EHwllkNWBdnR/jRFM9grPWbJb3o2XlQsJe37/37ToTIFtTQBCUeRYnRDk3yr0OGnSihW7U6mV2PGcj0SKtiL4Lzxn1Z9lOlbYMgzA53ieIcmyTUOKssGrvNVlNslFY+284GiR5vImhXikmZZzXf8lqX8xnuoQ3J8gOA/mwGili47dlKFsNzNz5vMvzX9MZzcXX3d3SwyTd9Wr/XPgvpWE/pa+5HOxYGrld7+DXIiFnAHltbAIGLF3Lxr3w62hW7mfOKwgOl4DOQ36JPM8muPwzNfgASkYCHeMZAm8EHjU5W1yWEq7mUvhGrE8wSk5T+qkgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZXK6XS2jE7uc0Xb/kneLBZl1l/GXDkpqFi0vCm0dCI=;
 b=qkX8nbrALEEvEhR2ytSqQqhA9/Oi++Tc9doQ1psH3jWmPcjndVGj5h1a7xZk1QABpfaCnyKt6/zpXK6jub88hngsMHnvxtCeunRf212o3r6BKwBj+E5ZrUbwBOxwJb2p/bzVWVTDogEkTwqp+2nbecsfwUt9as7xDdB/G7xgSd/qNC5B/Vlvid0tgAUO+ETgacTZwGwhCws/4d/ZI0DQSyMEesfiNtgt9H+DhGglEY7BZq4DkKFXrk+occrYcPlr+n0WNwZh28fM7R+isnhayJjgm8RlKiJt/G+cWBz7HQsCBeVnCyXQZ6jCsm0Ga5EcfO8gDNuXQGJKpQ62uacHkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZXK6XS2jE7uc0Xb/kneLBZl1l/GXDkpqFi0vCm0dCI=;
 b=uRdsY0vwKjS8jaY2Y48iEC6/ruILy0fw+hZ4mHQwXHu17L7Mp0A6Ay+aXuM+NgAwvlE7QvpRDUcukjYhoOiBLscjDxAvzfT2XfPzfk/aQqWI570QY7H89+NvxI7usBRrqRb7mPoBqB/8XtXRRIe89onpUl7AZBBjDVWLdFg4+mYVETCyDjhMAlhOTFizU6dgh0P+O+yxfLERWKGCOPwmRgBScFcL9uyYZzLgL7MEk4n+olRr67a0apBXj0GCamVUeXGX6OAowg1jg+Ms0NuQn2z1DfZ+/VEcTtbhbIxIYLFrzGxk0US+ZZeF69fO6WH+JQmNjUlUPwY41W4nn7OQKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV4PR04MB11901.eurprd04.prod.outlook.com
 (2603:10a6:150:2eb::21) by GV1PR04MB10128.eurprd04.prod.outlook.com
 (2603:10a6:150:1af::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Mon, 16 Mar
 2026 08:04:32 +0000
Received: from GV4PR04MB11901.eurprd04.prod.outlook.com
 ([fe80::601d:ca21:9592:9a12]) by GV4PR04MB11901.eurprd04.prod.outlook.com
 ([fe80::601d:ca21:9592:9a12%4]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 08:05:00 +0000
From: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>
To: uboot-imx@nxp.com,
	u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, simona.toaca@nxp.com, ye.li@nxp.com,
 viorel.suman@nxp.com, ping.bai@nxp.com, marex@nabladev.com,
 sebastien.szymanski@armadeus.com, ravi@prevas.dk,
 joao.goncalves@toradex.com, ji.luo@nxp.com, tharvey@gateworks.com,
 qijian.guo@nxp.com
Subject: [PATCH v2 5/5] doc: board: nxp: Add Quickboot documentation
Date: Mon, 16 Mar 2026 10:15:56 +0200
Message-ID: <be6b07edb38e4e0dc86e65f8bac7b6b3b0e29d01.1773648510.git.simona.toaca@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773648510.git.simona.toaca@nxp.com>
References: <cover.1773648510.git.simona.toaca@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0193.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::17) To GV4PR04MB11901.eurprd04.prod.outlook.com
 (2603:10a6:150:2eb::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV4PR04MB11901:EE_|GV1PR04MB10128:EE_
X-MS-Office365-Filtering-Correlation-Id: d872d0eb-8c85-474b-2d6d-08de8332b8c2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Cg1i4ybqC9ldPatlYdiwsfY41AjcDXIT3kDNWytN8Iz/zy0JpbDssPiwqdLI8Rlxd5tU7sT4Jq6eHNHn6XtqsuQ6VBWJIUoY4o6vJ8PpnaCyqf1/A17REqVU4fzGkG3yPh/y/ou33znnwG4zUO4VfQ3/xZF1PoTkNbkzLM/k+QtaoynlurC5b4IO12RezBl/0iYRc9NeiTG4hF00GTJGJ/iLEWQcqcSVn7SMyLE3KhjoA6u1j9hHNvHQD4KF0YuqatWfUbxPAXEADda+O6ptrGs+QHNJdE2Xr6P6LMpg5E3LGOXR8DJsctcJPgNx2EJHY+O2RTLioT+N5UsdUoWQpyBPK8pj/EskyysZM0J+5mOc9v15uC125+k8JXWgt9bxBm0JFyQVNfiGEVCsU3qS/v4FBfxdJB8Z32tsRlBsPgWy/Y4kCJ1PXhf9du5tq39sGkeyvh3Liy3/bZkVnkzbha8tGdiEE2/CI63vONftL5gEXSsU6RBWBcYTXWEJnPpWbM0kgipcTWipOZ7lrfyOHhoVZdFALYo5tXCJsCOpdfummwksakJLinv+mFojfq9emneP3nPAWW0P/eUkFgtrfOUwN1tN8m4iQkW5Wnh0XrPEkW6+B1Iyn40EMWcbWrhcDxQwNfLvMfD4+LY7lpCqHAs2nE4xBpn2IoX7AdILFMhFZ1wpLrH3PkFNh5COzbS/Ykk+6RVGg87vH/neNRHnn6PLTHzbLtoe8UD6Z/MqiHk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV4PR04MB11901.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1A2riiOpplVu4n00jP9d6Nj1QVUr8HCCjCUPqZdVVyFxADFGhrxFqV9g2hF0?=
 =?us-ascii?Q?NkLcOF+0fuD2ehJc8vXFy7okYoMOKvqXotnYQYoyGRrJgtoLITXgLreFrabQ?=
 =?us-ascii?Q?0/X+w922JNF3dQ2jW8GKdq2ZJ9x2PYxCJqyFvzjzmQvW9rhpD3UYZVQ6ThA+?=
 =?us-ascii?Q?TEvhXjSDqfjDWNFf8U1BASyLO0zqowEON3gvC/q95yVrKCBOsYZ73G9N1wqz?=
 =?us-ascii?Q?yS02/8QzyG6nBsawowlkBmbEj2dmuyHWfCcdJZgE1SurStyEXhyO5autUKmT?=
 =?us-ascii?Q?lMF/7+dzSMUofs0nG5rSVsbzeV5206IP2r1EKOowJsnpA1DCzxxI7r8MiASU?=
 =?us-ascii?Q?ldDCyC2FEmBCzwh/th2Pgc+4CWX41fNXMKtvk+8XhCLKNW1KxeWQreA3F4si?=
 =?us-ascii?Q?0K6+q8FgdqXkDGZrjASpIXvB6QottIa/sybW64ksRxzU1wWzsqcVv5jHlUMx?=
 =?us-ascii?Q?T0FQv08UBiFpbGtQ5Z+EN3Qw9gnzBsZJ424VzCaKqA1tuRNFz77TolRTcylA?=
 =?us-ascii?Q?9d32daY+IAmfu9cG11Nzkz+vooFcCuhYK93kOfZlSBYPGZXkNe5Kkg/6WswS?=
 =?us-ascii?Q?ZIbsYOv9tJvNFceMnVguJqwP42IEyaeVe1CFbewSpwihiIwH4lgdSEa9hmBD?=
 =?us-ascii?Q?fEvkQFSV/YYZ+NqRzDHpqFJh9dHY3CNrL4bY+ybLSq5pYe5MeJEr0VmTHZsw?=
 =?us-ascii?Q?+H4D2+XdtxO6PJmZauRYs9DQDD01PNvCQZfRjy7CsWj0e60s5HqiZKS8CUpE?=
 =?us-ascii?Q?JfnFz6EDPItUK010SrrcAbO0Gv60cHsXyYsYEH1GFfnQjChQ6BvgviNIe8kt?=
 =?us-ascii?Q?bCzK/dbIHt2xvuiJ6a64mcL1krXoSmYc8NuwicLA1TnnC5MXfD4Lk9HrHSIW?=
 =?us-ascii?Q?xFn9cAD1s8LBkP1VRIYQFxoKVVS09qabpuVFgpqNvZCQ/7noXqEDIoALXSLR?=
 =?us-ascii?Q?rdGijVYrupk7ez1HEUWgFmLX90rbiDBhE81J8slGD1VxwzhxdMLBesFadUCW?=
 =?us-ascii?Q?Stc8AFTjpA0xvkhmdjXWuIldwBGojF9BpxyLAOaFTTDBlBj5sk1IK12GnX/A?=
 =?us-ascii?Q?hxN+MwMX/yVYV/LQZaqnVewTUQ58V1spWVc0ikTaRjeP+kkQGPHYXxX5NXrL?=
 =?us-ascii?Q?NbfCAwM82iT+vOmPoT5Uoiz4X8ODXUNXNwipIQXu727fHak0QDysV8dS2Bkz?=
 =?us-ascii?Q?Je94FRwF+/U6QcGDF/f4huYQD4Yjuwzim3mbMOj25qdC1JmTmE2MvZAWqWr/?=
 =?us-ascii?Q?BzCTecMavop60AjEDYJIfzDOwPgJmvnEEnmn8ef1fWa2B7/QRVSf8unpI9+J?=
 =?us-ascii?Q?pDlUwVhx8mW7kOJSbJG9+C4NrABcou8B0jUu8WfNYBxbAqZosK/MgjcM10Rg?=
 =?us-ascii?Q?y6Moix5IOaNG9Bayd8kmkMjS4fPqVLdXPfXnOMg+4nrGbDdQdJkZjgDTVSo6?=
 =?us-ascii?Q?cu9lohESD5tk9TXmR85vA2QPc2qvv0HOF+kHL34CRNWRlaEoyugrswMXMI2k?=
 =?us-ascii?Q?kX1JoAOwjbk2JpRnfcUiYChkRVQsUppBj/YM3XCzbxV7Xh791rBcZ0dnpiND?=
 =?us-ascii?Q?GfxIiqIAwjSfBrRQlRyDq6a9KDadONJLEg5l6urSaOCJBsgQy4ZKaEGUJQqh?=
 =?us-ascii?Q?CTniAilcYYutnztQznw8DqBgLKDE2HKvqep6mRwZm+cb18nhKI7rocxiE8St?=
 =?us-ascii?Q?tytvZ9sWB+pjqc/w1Qflzk9xrMnaBCGKpyQTh0e4VKnR0t3Bk5z+aLKLXid/?=
 =?us-ascii?Q?ihDSITstUA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d872d0eb-8c85-474b-2d6d-08de8332b8c2
X-MS-Exchange-CrossTenant-AuthSource: GV4PR04MB11901.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 08:05:00.6600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VzZW2DWvZXyYnui1PCeHZbFbDOQ6gOxHSzMsyCTP5/sLNz1AdQ6i6MZFp8wBKorGkI1uN6gibLSvzqEW4w8BwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10128
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

From: Simona Toaca <simona.toaca@nxp.com>

Add instructions on how to use U-Boot to save
DDR training data to NVM and explain the saving
process.

Signed-off-by: Simona Toaca <simona.toaca@nxp.com>
---
 doc/board/nxp/index.rst |  1 +
 doc/board/nxp/qb.rst    | 49 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100644 doc/board/nxp/qb.rst

diff --git a/doc/board/nxp/index.rst b/doc/board/nxp/index.rst
index 01d3468a47d..7e3e5e29880 100644
--- a/doc/board/nxp/index.rst
+++ b/doc/board/nxp/index.rst
@@ -29,3 +29,4 @@ NXP Semiconductors
    mx6ullevk
    rproc
    psb
+   qb
diff --git a/doc/board/nxp/qb.rst b/doc/board/nxp/qb.rst
new file mode 100644
index 00000000000..5a1e913ea11
--- /dev/null
+++ b/doc/board/nxp/qb.rst
@@ -0,0 +1,49 @@
+.. SPDX-License-Identifier: GPL-2.0+
+   Copyright 2026 NXP
+
+DDR QuickBoot flow
+------------------
+
+Some NXP boards (which use OEI - iMX943, iMX95, etc.) support saving DDR
+training data (collected by OEI during Training flow) from volatile
+to non-volatile memory, which is then available to OEI at next cold reboot.
+OEI uses the saved data to run Quickboot flow and avoid training the DDR again.
+This significantly reduces the boot time.
+
+U-Boot provides no authentication for qb data, only its integrity
+is verified via the CRC32. The authentication is done in OEI. With
+the exception of iMX95 A0/A1, which use CRC32 as well for verifying
+the data, the rest of the boards use ELE to verify the MAC stored
+in the ddrphy_qb_state structure.
+
+If the quickboot data in memory is not valid (CRC32 check fails),
+U-Boot does not save it to NVM. So, if OEI runs Quickboot flow -> no
+data is written to volatile memory -> invalid data -> no saving happens
+(qb save fails during qb check).
+
+After successful saving, U-Boot clears the data in volatile memory so
+that qb check fails at next reboot and the NVM isn't accessed again.
+
+There are 2 ways to save this data (both can be enabled):
+
+1. automatically, in SPL (by enabling CONFIG_SPL_IMX_QB)
+
+- this will save the data on the current boot device (e.g. SD)
+- other configs specific to the boot device need to be enabled (CONFIG_SPL_MMC_WRITE for saving to eMMC/SD)
+- use for: automating qb save / saving qb data if using Falcon mode (skipping U-Boot proper)
+
+2. using qb command in U-Boot console (by enabling CONFIG_CMD_IMX_QB)
+
+- supports saving on the current boot device, or on another, specified device.
+- if flashing via uuu, the command can be added in an uuu script (boot device needs to be specified)
+- use for: saving the qb data during flashing / controlling the NVM to save to
+
+::
+
+        # To save/erase on current boot device
+        => qb save/erase
+
+        # To save/erase on other boot device
+        => qb save/erase mmc 0 # eMMC
+        => qb save/erase mmc 1 # SD
+        => qb save/erase spi   # NOR SPI
-- 
2.43.0

