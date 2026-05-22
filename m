Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74FD5CD4F3D
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 21:29:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21865848C6;
	Fri, 22 May 2026 23:28:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="DOnwp77z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9609848BF; Fri, 22 May 2026 23:28:12 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAA07848C0
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 23:28:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMPY4UGMffovIl91ruijjc8Kq+GnLkssLtC5cpSvqv5t+5Ey+72f4dGKwQuThBu+94l2LIy1qcCqss0S3VVBXKuK6d/qd0xEVaGrCGclP/RARWFqLs2t3D2aeer4EfoMW1LzmV1sCpOq0rnC+1xjFanuwT7e1JkLzFNiObOyZYbENqIS5ylsZEJ0zF0J4thmIKcLtfxWt5BZRk7CR2L+vD9QCfA33PJrovb9luJpb69SlY4Lfg05YF4zQSe/xkuoUzFK16AfmFIKjogkUJk5tHer9DGi9Acs0I8fUO8EbkxYmQ38tqqavCcqhuGvvL64eKmKynxUP+qlyEF6ta2fNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/REN0tN4GfI0Qe6y0mR3swKk+VsUmEpw8LgDCvyppg=;
 b=Qm0/WTpjo71Pt44x0sScloEYwNKfEis1ds6vu0WpD0amieefEVxdiTdmkT+9MhTyyk+/BaaUkb9m+CbOk+iaaeJPVFVhO+QQwfcCbW0Ue6ifEZ1/pXFueMLxCpXV7UO1zzmSzSPtkbZeRUONpIuq/0cMbdzJWf6RkpKJqYB1tzwJyWIvKHexLjp3F2+UEWUTHHNPex0Wf7mr5SIQwxXW6SO28msQCgasdK4BhameSICN5eWuiDU9mRF0UzLT/3JmsZILyiam2Bnf5eTj6QQUu+/HdsiGS0vRUvIAo1dvrTfnHIcVAAsIt17BHPHhXPrqCV2OOSABYKY11/q+I8mb6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/REN0tN4GfI0Qe6y0mR3swKk+VsUmEpw8LgDCvyppg=;
 b=DOnwp77zYgojXY7YnhV243Wi0U4rxedm2aKFE0WZ+y1NtE3cT8j2f+1Hu0nYvgphhdRkeQaHrildZPY2qY6byBaW2sDi3VqAXTp4CuiljlucnAQTNaBgi0ZNArqdPhziCjkPurkyUUUjREbCtZaByaGhWNj5W/HZOyYyG1WApDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU0PR10MB5385.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:340::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 21:28:07 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 21:28:07 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [RFC PATCH 6/9] linker_lists.rst: update documentation
Date: Fri, 22 May 2026 23:27:53 +0200
Message-ID: <20260522212756.3169222-7-ravi@prevas.dk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522212756.3169222-1-ravi@prevas.dk>
References: <20260522212756.3169222-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8P189CA0010.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:31f::9) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU0PR10MB5385:EE_
X-MS-Office365-Filtering-Correlation-Id: d654c7aa-0e37-4284-b564-08deb849044a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|3023799007|11063799006|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: RZXYQiqDAFbTtBfmEdxaoecWvi+4uUEsKPii/vliMET7C/kP5bJSOtTrfdI9LE4hhfFwW47jp2u6u2dwLteK0QJFKGR++YBoYa/K5SYT0RpN/Dp8V3DAtKVgwF52YndiAGKDAloTk9JVh3qoJD+cCbEr0kRHtzhdjCL83hC5e/LWdcYcbmdIfG6pK+6LKuKfxuzpmH2xSTwTdLEKd5TFOZbHSVw21YEHpsfqORp1K1Y84xNoYtkbPjAWpkGE8XWbzOwtoa1b4WmQ85nAg1F9cIOQEmte00MTpHx1Krbh7kLE2nZWmr+yEvl7BhBvkSFOEEfGq57zBUAf44a47AeZdoi+zrBm9An8Ak2sobzcrP2Yx0gtiTnHzSdg0R32IAxt45JUzbXOesA17scCtPMWvIs/fF4ucfBYwvwbH9D7bP/GbEgMkb2dHGOfa57PvH1r3bOoIy/dM1iOk6+9rgxA7TAzk+gB6wSE7vPEPD6/KyuKtI7I+zSmyKrhX/wZBQiJYKaKb20vhyQt1ssuW5RW12yfZAQ2jqRtW7ms+MnOvtQZ+TdA7zgWTdKsMrtvIINdF1zJHROjo53vjjgnnKllyHbLkT4tuZOjy+WRXwajfOQsa3QxgPs+mSvZXmUmxYhBf4XuT4WHDQ5ApogDr4bhKD6E2zVf4CWeJfYz6BrCFyoQkw98PYaKfYBgJX//B1VGB6uOBN40Z1DzidmVzXuxc2IC/IDY+VVROwl/e6yOS95rhJGVTq9y8oG0TLglbRag
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(3023799007)(11063799006)(56012099003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U/1HPhjcmoCsQQPNS92Hf1LuBdWvE8LSXOxgPglLP7Er6R8VvnKdxCZlZzh0?=
 =?us-ascii?Q?jM0Pt/DGu0f25ssjwjTBOr6nc+mBUiKVXLidhRVVVkdRl7hjZ3Srt5A6jjYN?=
 =?us-ascii?Q?RpZbB8nOZ0DBSQgxpShlTcqxLrGK6BXe6tibfpdr3YY8Kidjp7LgmjoeOSr1?=
 =?us-ascii?Q?WfdkOh1L5Qf9Xat11yNL7P+Z6YWMKALmjgofgtS+hs1RsCVlhnn+X8QHzmvJ?=
 =?us-ascii?Q?RFvBG6mtuHEehK/JSXbrPXDvpEDYzWoSggNtY7G2/CfXSQmL/c5JqgZRBkzB?=
 =?us-ascii?Q?s60vF/PP1XaRkNPH+bhxwDZGBBA/UbmRESWzMc7cfsy8SISfxZKSz5nlxMai?=
 =?us-ascii?Q?ikSNeHBP1l0EgJoFf40rxLRCvd3rJdbF10KtoVsQDrTvq5IL+fozSBaqKBCY?=
 =?us-ascii?Q?CrigtfU41MLdDAqF8myPhmwOG7sI+0ukQwgI5VP3Gn36G+ATL3QhRAfzAekR?=
 =?us-ascii?Q?OuWZdSQTYen2OL/NgzV29CRyZrbrnCKRw0CEK7mPTOQ3TCQTmfp21cXEwHuD?=
 =?us-ascii?Q?P38pKK1h14viahh2R7ZXQX4p+pguBrfBSp2Lc1ZStkySmjed0FTCJgNyoCTk?=
 =?us-ascii?Q?Q+7LSH9unfpUFPOGdo0WE36wE0Le76Wr//pGlBjquxTggcbpbcQoDpGos8FY?=
 =?us-ascii?Q?EPbjJ9Z863+gY7xkB1dY3Mm38gqBdyr8GpTzyniGYZY/V+Ue2rzggaMD5WgH?=
 =?us-ascii?Q?5L+RKVOk6kzNjeR0way3rwue7dkJYj3MEuvE8WxjDw/V3dUppAKKUGrqis4I?=
 =?us-ascii?Q?xLknBOiOkDmpstmP8fECj5538szTEZTR+NsJTJDQwm5odhBf4sC5eYrXySQv?=
 =?us-ascii?Q?Ev3BqrS3MhTfmFCC0zXIPDKA8Rb7QNGukeb20ZUfcUI98SShBWDf9BcfeMDc?=
 =?us-ascii?Q?xyuWV6JIOlk91lSpeJrwL14CW8ELzeTIcZbgITcg9J1ogN18nCS9cQeYJKcR?=
 =?us-ascii?Q?rlnr4sOYTvqcwm5xJUF7bG7SCwVjjfk6bRvXonNqM7k5SWrvce44PgDVbVrr?=
 =?us-ascii?Q?rsURGjgn5N/0Y0+jFkxxcEEKRJotNWrvVSshDt7WqifHWScIgrWtKY6lzIrS?=
 =?us-ascii?Q?4Blw0zz0GA8AqwRjCmOBJVeNOWfaYDbkvZVzFbCv/dMTyoZktsougJ5FTyI3?=
 =?us-ascii?Q?BaxgSOzXyhokZR8vkqzskjrfdryiRc/nPCLtA4InC+LuhwF0RttkqnJeBIqe?=
 =?us-ascii?Q?9SoeAs++Voa0v2nKYgK48WR1t8rHBpVowa6+p55yVtJZvCOIS1Nm57XrOLPQ?=
 =?us-ascii?Q?otMIFq7hBuMW6IH/fefDm28LDX19HS9xcxBx9ZPQ5YFBFvpiepbhdEyBKRyi?=
 =?us-ascii?Q?mi8T6qfHkBS/0pNqjU/+71y+10UGYub52tghegRDjoqi/PH17kQd0Uk1RjC4?=
 =?us-ascii?Q?ieLLDV+rpF0rmZEsGb8Nvbk1VHCqmsgyIu+97ms6iRwm9J83Rsivkxb368Ln?=
 =?us-ascii?Q?70qxz9FPQB3k0v3HkQDPVt9lQWn0oHdlIkLFtfpasCxb9NX5bQDwJ/xCb1+N?=
 =?us-ascii?Q?TkEDIBnl6IcgNqF2xdyIqT/NiUjCiIytchBJ8YL9iMcYg3cjgrGm/cjlw8Ni?=
 =?us-ascii?Q?YCL/Z+BotoIFZS6FGJAkLY0dIntyvodbd070qSwPWHgbUOAwdZawECfFYXsI?=
 =?us-ascii?Q?yHb1vj6VdmYal4/VtOStNErw/uTPis9+f4ZUlxAtkbrYaVBaNq+LOzrmfwR7?=
 =?us-ascii?Q?R7TxrKQ9SEQ4HzheiwBMogchG9fHd/H2Xe65wyQofalNoJ3a03lrAiMopn+j?=
 =?us-ascii?Q?8XuAMotSdZ+jlLZF86BnwZDnH0GTQWI=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: d654c7aa-0e37-4284-b564-08deb849044a
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 21:28:07.8296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZ/zuviHf15r6bQKgqQqqoTZBmc4kILVLRWXKJokL4mdNeVt6jUry8bvg6yHPNWPbSUwM4zBtWUlrp/YykXv+R3hHXQAQJGCGMdmKJHjpiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5385
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

Remove the initial _2 component in the examples in order to match what
linker_lists.h now does. This also makes the

  Note the two '_2_' constant components in the names

easier to grok, as there is now only one such component.

Remove the whole "Start and end symbols for the whole of the linker
lists area can be defined as" paragraph, since that can no longer be
done like that, and the (never used) macros doing it were removed in
e2138cf1e60 ("linker_lists.h: drop never used ll_start, ll_end
macros").

Leave the occurrences in the "Alignment issues" subsection alone for
now. They are verbatim copies from a u-boot.map file, and it would not
be right to edit that long after the fact, when we cannot easily
reproduce a u-boot.map exhibiting this phenomenon.

Part of the purpose of this series is to get a better handle on
alignment issues once and for all, so hopefully we can simply remove
the whole subsection in a not too distant future.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 doc/api/linker_lists.rst | 54 +++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 31 deletions(-)

diff --git a/doc/api/linker_lists.rst b/doc/api/linker_lists.rst
index 9e6849d5e75..3f7a982c518 100644
--- a/doc/api/linker_lists.rst
+++ b/doc/api/linker_lists.rst
@@ -13,13 +13,13 @@ then the corresponding input section name is
 
 ::
 
-  __u_boot_list_ + 2_ + @_list + _2_ + @_entry
+  __u_boot_list_ + @_list + _2_ + @_entry
 
 and the C variable name is
 
 ::
 
-  _u_boot_list + _2_ + @_list + _2_ + @_entry
+  _u_boot_list + @_list + _2_ + @_entry
 
 This ensures uniqueness for both input section and C variable name.
 
@@ -30,7 +30,7 @@ to as
 
 ::
 
-  %u_boot_list_ + 2_ + @_list + _2_ + @_entry
+  %u_boot_list_ + @_list + _2_ + @_entry
 
 Entry variables need never be referred to directly.
 
@@ -46,16 +46,8 @@ Start and end symbols for a list can generally be defined as
 
 ::
 
-  %u_boot_list_2_ + @_list + _1_...
-  %u_boot_list_2_ + @_list + _3_...
-
-Start and end symbols for the whole of the linker lists area can be
-defined as
-
-::
-
-  %u_boot_list_1_...
-  %u_boot_list_3_...
+  %u_boot_list_ + @_list + _1_...
+  %u_boot_list_ + @_list + _3_...
 
 Here is an example of the sorted sections which result from a list
 "array" made up of three entries : "first", "second" and "third",
@@ -63,11 +55,11 @@ iterated at least once.
 
 ::
 
-  __u_boot_list_2_array_1
-  __u_boot_list_2_array_2_first
-  __u_boot_list_2_array_2_second
-  __u_boot_list_2_array_2_third
-  __u_boot_list_2_array_3
+  __u_boot_list_array_1
+  __u_boot_list_array_2_first
+  __u_boot_list_array_2_second
+  __u_boot_list_array_2_third
+  __u_boot_list_array_3
 
 If lists must be divided into sublists (e.g. for iterating only on
 part of a list), one can simply give the list a name of the form
@@ -82,19 +74,19 @@ defined for the whole list and each sub-list:
 
 ::
 
-  %u_boot_list_2_drivers_1
-  %u_boot_list_2_drivers_2_i2c_1
-  %u_boot_list_2_drivers_2_i2c_2_first
-  %u_boot_list_2_drivers_2_i2c_2_first
-  %u_boot_list_2_drivers_2_i2c_2_second
-  %u_boot_list_2_drivers_2_i2c_2_third
-  %u_boot_list_2_drivers_2_i2c_3
-  %u_boot_list_2_drivers_2_pci_1
-  %u_boot_list_2_drivers_2_pci_2_first
-  %u_boot_list_2_drivers_2_pci_2_second
-  %u_boot_list_2_drivers_2_pci_2_third
-  %u_boot_list_2_drivers_2_pci_3
-  %u_boot_list_2_drivers_3
+  %u_boot_list_drivers_1
+  %u_boot_list_drivers_2_i2c_1
+  %u_boot_list_drivers_2_i2c_2_first
+  %u_boot_list_drivers_2_i2c_2_first
+  %u_boot_list_drivers_2_i2c_2_second
+  %u_boot_list_drivers_2_i2c_2_third
+  %u_boot_list_drivers_2_i2c_3
+  %u_boot_list_drivers_2_pci_1
+  %u_boot_list_drivers_2_pci_2_first
+  %u_boot_list_drivers_2_pci_2_second
+  %u_boot_list_drivers_2_pci_2_third
+  %u_boot_list_drivers_2_pci_3
+  %u_boot_list_drivers_3
 
 Alignment issues
 ----------------
-- 
2.54.0

