Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D447CC3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 09:12:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 212F5887CE;
	Fri, 19 Jul 2024 11:12:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="R9nD0HUX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C92E88B55; Fri, 19 Jul 2024 11:12:29 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20724.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::724])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFA3A884AC
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 11:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAV1y0rFSPQuAPDtGC9y7o6WKGY/8Rv5TZhHxoMrogVcrViPF8eC5PuQSGoiv3fGUpIpslZIcN+8nUioylH2MdsCqFx5ZWIIQ2/m7VH+j/K/AI6j/6lgU+fZ4baUu/aqQXMBnJpBqdUj9HYrX8v9C9JqD49t7oYpkVi6MwpnTuOC14SOm75fPv3/iVNLPChWTJJaxWtJntkKePKBnGd/qnt1G6kElbp+cUQPtvxYNhpClUcpX6hyWPFTXq8n6NTeTax9Hd/jHhY5/EHiTd3iJ5Pkq/SC1MPkohPaumAzxn7XptTtIVvvmBLtEpV3n7bMA5Ng2aYTwFHnJdbaX22XgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BTe/ZWeqTHEx90txr3Fb+Lvu3QnO5dk4oCsYeoxOao=;
 b=Ar253LWzEslDInPyDJDQt+eYata0K0eZti1AQz8P5Y50Lcn0oHET5ESbi6zwmp/EutHo4OYjFcshjepAyavh72T6XXlmge56HS8LhKcqDNuON4e7JTWIcbJAuQJsNvbMvLvgJ2kP7p7hCK1d30HggioQD3nLUWhseQ00nyJgWvbbXrmIcyDgLmW6QxyDLK7hmvqr4UMiscWs4LtNh43tdvF2PKrR8PrviyWYb7xIuJ4eW8/EUeRt1slepzX7JGG2x+v2FH8vTuis4AOhUPhSqPBro9HPHNMkVr04uSFoiJY5WZRgw92F4oM0vQDbZx+ViTeWjKBZ/t+00exybnYLaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BTe/ZWeqTHEx90txr3Fb+Lvu3QnO5dk4oCsYeoxOao=;
 b=R9nD0HUXClWG+OxOA0XxaA51cDkapw1xEYMbecOvD/R/tJNTYLTDG5gFSdzmcl8g6pI80Yqjgp/ctPGhIwR6HFcrfzmrc/T3RckgQeq7sOKy/IyVVuJOClhuHqeG9RXtU+i2Qx2wBN2ZCQyNSftmrhorNW4h6A5yP7uwyQ58dg7ZEsDMPrFVDnw0BroI1OlWWBFgKujom9keNIC8FqtBsxsChYzSNzbz2eG1n3e14Lto9uRCZ2Tkqz7lzXuuIDcyUicoWJDnxUfEvkqg3DeUa+9a92wlkiik2X27bupBi85ndXHRzLUNqPPsnujT8+NUAX8msM02aVVuAOCfolsQUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS1PR08MB7402.eurprd08.prod.outlook.com (2603:10a6:20b:4c6::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Fri, 19 Jul
 2024 09:12:25 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7784.016; Fri, 19 Jul 2024
 09:12:24 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v6 0/3] led: implement software blinking
Date: Fri, 19 Jul 2024 13:12:10 +0400
Message-Id: <20240719091213.3757300-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0029.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::20) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS1PR08MB7402:EE_
X-MS-Office365-Filtering-Correlation-Id: a175e18e-685c-4134-95da-08dca7d2e745
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kWrNbfWqh1iRwv4FH7qkHy9HFnLz6M98hV5hynZTrHyNsujqfpa4xgi08tNc?=
 =?us-ascii?Q?PxVTNnVU9rkBr6ZJ1VItZLSauf0S+AZslEBW40jmUkdj6MAUOmvePHi+aZI9?=
 =?us-ascii?Q?AoJgUInBtO0q1miZPdhbh8fqBfXbT1YX9IcORmeye3/L4kVRnJKmP2/9ZTR+?=
 =?us-ascii?Q?n4sco3buxi/GYM4xLQL0bbGXIGjqnDp/fdXUZbfcdbsKnjQR9gUznQPnTY2H?=
 =?us-ascii?Q?FZZBnTP1bOFMNrjr8Z59p+U2RCgDa+lbJXkdpVuxnr6JZGeHeIsJUk12nbOU?=
 =?us-ascii?Q?ncZ0s4rigweWESOusz6BL4+qhOU5OmaTZWSmpSt29tDeJdZGYMn0z7FGCfUm?=
 =?us-ascii?Q?GEIObXDSchEVbaJTkX/Tf/6PEIlvxkocRhl3rDuCs/poaEaGPo8JFMV51Gkq?=
 =?us-ascii?Q?wHInknRv4mGGEKAngHQ0QmEfy8F9ex5bkG7q8Su+Qemwa+/Uh5yMV8E2Ftoo?=
 =?us-ascii?Q?k64T/sHO3J6wchi9bDCQeEfVu1WoSVicQcam6mR/O9GpClxBcEZA0ZX64xcH?=
 =?us-ascii?Q?fyBLxZb503Ofanstc/rvHMBKLPfLxSRey/zLi8bPViCg2fakGvHVFf4JynYs?=
 =?us-ascii?Q?fTYNivbCbZGbtGp4IE8uHR6FW8G3+fg0U5Dta3ihr9Nm3ajWycx0nJ4H4cLv?=
 =?us-ascii?Q?yceOsp26Koe3XwVCBgSW1u56etj7G499vXIprpTMYKy4KUBguU9AbZxgzHrP?=
 =?us-ascii?Q?Y34kRp6sYiQO7kdY0FewQkjy1AbGUn8OL/4ZXqQ5+3EG6nQE+IL5MPbGIgu/?=
 =?us-ascii?Q?A+hjabCA14RjwXt42BcsJCQmUteBta/nj+IusQPX4X/UdQWy6FHR2WKEbp3O?=
 =?us-ascii?Q?n9tl5cph92gASBlk0VWifS8RVMVkgdwXjDyGpLIHiymHJL/+8KN6jbeNwbNn?=
 =?us-ascii?Q?mKTvKzS49HeLjR95I5tVjaj5DawhacUK2dxQbrOUCPaF6rD1Q6NaUsNYCpPr?=
 =?us-ascii?Q?SLnD+OG5y1PrAC4mVBIjyUiAQ03pul1bvSPiarPRisa61fxxfkFPA9awZJfD?=
 =?us-ascii?Q?lCXZlBe/Mt3e1t/FiY0CoKeqfg3UmW1Ib39/v1e6n/uGC1DATPjwBjhUptjD?=
 =?us-ascii?Q?IqMOUbzw5wVS3OgbZJNyn678yFOC4vjztQ+gwZXop/wozu+PZsEymAZEAX1I?=
 =?us-ascii?Q?n8tEH8gdu/6/v59yks1LzZMflKq9CI172QczCAk7vjb17GgStUDhlpieipIg?=
 =?us-ascii?Q?MA5rTYU4hB7vFm1oSj+fyhvNxNqnl+278UcCQ0YnUigiM0l2uevxbgD3wPIx?=
 =?us-ascii?Q?0QKInxLyoyqzmYDJHMbCLZpHoopd9wesuZoWjrg0DLbBU/DzvReSh4KsFIRF?=
 =?us-ascii?Q?0WDUxKlEiZC9g0cCTqL1qttzaq5NmYDwlRi7F+ygM3/BKY8EHuZz16CeOX+U?=
 =?us-ascii?Q?72ZeMBqX5ZUHnYBfCadhZs3sx9hq+fVLuo3LwKcQ1URzrUnfDg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rEQlSDdD00gehdoCEWCCHdO/rsWQeDWnldb3il2BZKUN4EcetD0+aEN44kJt?=
 =?us-ascii?Q?FK4tC7NPG6IgzUDp/vkDwYw6l9tLA/lb7CRq3VSupI0HjcmmnmvQP8u3RF/j?=
 =?us-ascii?Q?CR0A7T2Jx0JdR3wBJ2zjROPwGSZbIgiNn/0oWupB+r4ovlUpEPZf5Mdc3m2z?=
 =?us-ascii?Q?yA9LydQGLBxiTTnbv0jRR4vtNA6Gpr+WTTUn1g+sNOhYsXiMaRuVNdHYw/15?=
 =?us-ascii?Q?90WiiNogjfdVPK/4idXcKzcvrb7fuKltuH2q11B0RuYfniQaUrJkPFPF7dbx?=
 =?us-ascii?Q?k1VIAY29v7wFpAlslTDfpnDqKAUVSkwiyeqPr0uv6URuXBdwJiZuyen+ofO5?=
 =?us-ascii?Q?/bG0wmyGle7Q9O0O9nTEw2OpQRMP/GxraHX14bNDbOCoRRh8TKW7c+dhy/ut?=
 =?us-ascii?Q?EDoWUKZuRbvYwoZKcbvgVroAeB1Fu4Gb0jjTw5tH+3rJIXOGzSWQcU2msDsx?=
 =?us-ascii?Q?S+reaiwiXhO0WuHUFtrc7zb/GqT1OI0vRlKtk60Fg3cfQAUE8wStFqNuirzo?=
 =?us-ascii?Q?+I4GlQ4V0+Q2qOu2L7eHc0t88c7pbzF9qyMpEGmZTpx38x987gJcJVJGvLsu?=
 =?us-ascii?Q?y5FFRE9R1mxEmdWqv01WHqdplF0fHXE+/+H+/Ek5hSqipNt0tkyhRgWNPOw3?=
 =?us-ascii?Q?AGzXs+SWLfJGNbEtfvJ9/eAOvSsH4p051O8hiadUaaa989AfM8e0PVEgD3c6?=
 =?us-ascii?Q?rqudvXWs8rJMF2sA+eO30SIfVtApqHxrrgDZmzJLTJ8brOhISTmfTEyVCrIo?=
 =?us-ascii?Q?Z2fShjvYowxC9K3Pkxax+sXQzyUjwj+9xGh/NueY9qFLrMcWqu2ur+qwvrLd?=
 =?us-ascii?Q?/vvSxkyNmMhm53939ZltnAtB8Eshf9fOlMUx3vKcyYNHdszO7KStQ/k1B7Ao?=
 =?us-ascii?Q?6CZ/8Xz1VRjukIHJgq54HBJ33HzxeKzRIYdO/vprMzDUVm2FAhI97e8BclxC?=
 =?us-ascii?Q?LJuFDL7JOMQOB67+vCmuogwFM93H/Xy1AaDhss0dzsPPajT1Q8GWF5juHjdi?=
 =?us-ascii?Q?ZglxYVnRZtxaLNT0+IZHL5tHBQmsV9b1vBIDdk6vAscLcGHphN1JmZs5OfqT?=
 =?us-ascii?Q?LoW91bP9uwST24dLpCR3Ak43etstJKRQ2VSx6Uiwd41TaAavG7ZRjb+LqI3Z?=
 =?us-ascii?Q?yQ2TLzRzIn6EuecqBou6TGZdGWHFCCvAIXkvXVpgtf5cPxWfhHTA3943vqF+?=
 =?us-ascii?Q?FJD6bLEPM2XgplynOGFXpNwlhi6PKxfO2tshITEA6ZCiR+qjXGrH3a/fYf3O?=
 =?us-ascii?Q?6Ew1pLWl9yJs1bwZlAbNE03t6DDTLrwbem+Q2RtWGFnPjObG7Hwc8fvG55Ec?=
 =?us-ascii?Q?7oI4f3LcCqRA/BcJSoXSzjsabhPYuXEM2l1nF3Z9qMjTlowkt+waPEslEta7?=
 =?us-ascii?Q?wGm9pAkSEMqz5cUKR1O799nraboexj+iaDk08+GEcdHtk77e/Ti8svWroXLR?=
 =?us-ascii?Q?06Qka8FgJBUHi3UrYr+iDk9KUoiqrRv39GjnzeZzUE/73ZTP37Ur24ecw4+X?=
 =?us-ascii?Q?nkWCTQrBMSrfmw9XKeUwVgfQGfyh/iChNggpeZNza1mXjQ6k5oaUtECJLFiC?=
 =?us-ascii?Q?4IkxWQZDnX3xP57cKzN2QPquKstAkaQHdCP/1lJHJSBaqtQZgFThon53DNhs?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a175e18e-685c-4134-95da-08dca7d2e745
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 09:12:24.8617 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ljRiexg1Sa41cmrtKXP96gB0vo4U4oLIfOS6/6+7G8vji9mupc2oVe1PHvjWnY8IVdIs4zSeOSCTD+QhlNdYtSvSkAHj1Iz0QVGCTHQZpqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7402
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

v2 changes:
 * Drop sw_blink_state structure, move its necessary fields to
   led_uc_plat structure.
 * Add cyclic_info pointer to led_uc_plat structure. This
   simplify code a lot.
 * Remove cyclic function search logic. Not needed anymore.
 * Fix blinking period. It was twice large.
 * Other cleanups.

v3 changes:
 * Adapt code to recent cyclic function changes
 * Move software blinking functions to separate file
 * Other small changes

v4 changes:
 * Refactoring of led_set_period() function

v5 changes
 * Fix compilation if CONFIG_LED_BLINK is not defined

v6 changes:
 * Enable LEDST_BLINK state unconditionally.
 * Function led_set_period() becomes available when CONFIG_LED_BLINK
   is disabled. This makes led code simpler.
 * Software blinking requires about 100 bytes of data for a led. It's
   not a good idea to allocate so much memory for each supported led.
   Change the code to allocate blinking data only for required leds.

Michael Polyntsov (2):
  led: Implement software led blinking
  led: Add dts property to specify blinking of the led

Mikhail Kshevetskiy (1):
  led: enable LEDST_BLINK state unconditionally

 cmd/led.c                  |   8 ---
 drivers/led/Kconfig        |  16 ++++-
 drivers/led/Makefile       |   1 +
 drivers/led/led-uclass.c   |  51 ++++++++++++----
 drivers/led/led_sw_blink.c | 117 +++++++++++++++++++++++++++++++++++++
 include/led.h              |  24 +++++++-
 6 files changed, 196 insertions(+), 21 deletions(-)
 create mode 100644 drivers/led/led_sw_blink.c

-- 
2.39.2

