Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3C9CD4F3D
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 21:28:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5862C848C5;
	Fri, 22 May 2026 23:28:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="DI1N4/I9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FE64848BF; Fri, 22 May 2026 23:28:07 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFE70846DF
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 23:28:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WozZnRk5b53S/AMcjlk5HTAlpVwL6SdeFBK5Z8qFhtlH/ef0FXuSU+oAfdOfHG7XfZyPm3PrOShB3t37XGpBY5WIOhOPbtO8TnNN61JalOB5U3iWsrN/e/8PsVlNt+MS37uwH68wRV96kqqH8XqC6Rp3pVfUMv/ISsFqedaR7DyBsTAbOw0HzukH07KpP6zZHDc+uLo3EZhHSVWeOsqIZe9+JPT++n9v1Gwv7HmT/iKV+L6eIVb+qWXCjqSqMiw3AcS0u7WbSxRXJKAg5qN4v8UXFggETPUXddVADrLY1pODkOI+AvfssjoDwXMNxmd2sov9/XCZX+ervRnlFHWloA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVYsms93OSeugbicWR4K4CVIrd3r0gon4DMupCTpgSk=;
 b=aL3xSTkL/1BJSircKPKN7zyLShkztCp6AI+w+ddasTuFB2hF0odaVQdwVlYGUJSPF2InV3suNxZDSbUGEoh72I7Ur/nVqrsdSPjDyyYrMTFykTI/7QzK6W8ShGYVanlBkym6G7dgbp41mNSKQTgwy9UwtegjpFqtQWbYMGRuIF3vUpk60G1nM9fP5lAdKFUUuV9/IttevsXQuzh1IDibpC7sc+mTZezswoOjZR/zEMvgphLVYH8sW0evKJb68rDtksQF6IbxC6IqmtItQS0LvMzT5Z1JctZlMkb/uhVst+QDU8GUc2RqG21PVi8rCq45ZlDdp/aoNriJrUuERPRysA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVYsms93OSeugbicWR4K4CVIrd3r0gon4DMupCTpgSk=;
 b=DI1N4/I9kI/4aeiLdyxCSdJAFfGvfJu+w2mkhl9oD+hUQ7WpLr5QYQ+eVPRKg5mN/xzerAijpBYC1XwadYXssBQtSwtGbsxj/qXYh6GWM2cCsZTx/zvGxAQ35WBrP6WxABQbf/a9DdPUK9sqrfOs/Z+oKOUSEUKEadVpBoStm+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU0PR10MB5385.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:340::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 21:28:01 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 21:28:01 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [RFC PATCH 0/9] linker list sanity checking
Date: Fri, 22 May 2026 23:27:47 +0200
Message-ID: <20260522212756.3169222-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0394.eurprd06.prod.outlook.com
 (2603:10a6:20b:461::27) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU0PR10MB5385:EE_
X-MS-Office365-Filtering-Correlation-Id: aa96eb90-ab04-4ae3-db08-08deb8490027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|6133799003|11063799006|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: E3JfbItLR7EjPjf5zEy9RhV5uWxdIwOmKuQ4Ymp6PxVSu+sCmr1tpGvk6I7a2eE3esVhxX1nsyPdWQd+UtHShqWynRMGNl13MQp+UFhZnluvzXEpJNhFjwF55UwerL09hbfctwU+gtyvTOgB+h2rXP45YLI1witHYP3HtWWp3dSGKhdG8eD/PM9qDaV04eaDPQ8ZOmvuVig2Ltz6iRufyTttcriOtRyI8/MsWpZ+BvrrkVe9UqTebx3lLUBDfEVCQ6ER6AtUL9WEX8kyIqsl14tah3O63O2PFOToBf6PdN2gr7x6Fd8VQogBETzqEgFo8fSTcI9RvXyFfhj74F2tKBRkvi8p/C9GetBDvg21Z7z7YO1hEvSgfF9bySI+x+L4yCt+Kzx5uoAxYc66du42jSIOw1Orr3IDkCgdP/ioE7rc8KP22CsAZPEpcKcrm/4abI1T5Lq32aKMtBIL3Gv7wFiVdvKOvJtPro4ycYRUUr4d1hu5ox54fymUo+oyz7FOqI2h22x1xfa/ZMGWSbTwFsQRDTPII+21iFuMf3icbhzdUJdPVpvvHdrzXjs1OayPq6wiEXV+Bh5hphAQIJI4mygsFcNoE6lU9JhnHRLO3KlblkEeCPQc7fyLWMC+ubxJAu8XYCV65VxtjO9YX80s9aOIZ/gZ4o3/FiprRmgH50LldQCrm8UYKgA07ITW4xzw5ivBQvQnCHX09uMgoBoQ1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(6133799003)(11063799006)(56012099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RwbBIJ2QIpPXQ3bH7onxKVl+niAXjpR5NG0wxc0/LLt3fxisTFBxf2GjYNPg?=
 =?us-ascii?Q?LWSD4pv1vhqmUEN3eUZDUFUE1WPwWRAVVJgDSX2kSUqUo2mkMv16PDaahOAZ?=
 =?us-ascii?Q?xoOknM4eb33tZ1KS3GPSM0RFK46DG0I4vG0X49eJD2MVMCJIovTdE6k46phX?=
 =?us-ascii?Q?4BtN4SSkfoIL/U5wMmJ9ejQm4JXm2QHSmJkpGfV/XhxyzeJ8AmCt1DB416Jw?=
 =?us-ascii?Q?jp6ygDNR0bGObQ29kB8nmZ+Yg8AHEoZSoVY6WGP+6BaF/cQrLAnxLdI/cPsM?=
 =?us-ascii?Q?WXlZXBN0WS2AP3lLRf/sqA+RiuQeOItJr7CNXHcu6B+pUp2TW9Sd9Zm0h+1g?=
 =?us-ascii?Q?yZFIzchubcagCDpNt6fJJeIBW13e+lNruJbLjaMrN61u0e3jBDXaOWepFsZq?=
 =?us-ascii?Q?mMgQkNErgNV1LvcNVWWSQhLQwVp7t3s3x+xkxyvIMEa+XSRGkWk1HBaquc9i?=
 =?us-ascii?Q?vA5jW2mQqSvL2+K2SI4w/I//QCwuaIPA04q4wtyIbWBpOzXVMHdVoe0lJlxS?=
 =?us-ascii?Q?w3lzCknsp55ElMc5cl2k8E3FAtFtbUxGOk5Rq+/sMMUIUqMAy075THbETU90?=
 =?us-ascii?Q?NRArrwPvtoouvV+RrzGT4h3EFC8h0LmehdwzqnmymXpA2Q1wTXKdkgYbsIVD?=
 =?us-ascii?Q?XkEqq+z6XJ5ok6rYB922j0XHy+5TGw4u4aZKKZC9AeFP1ixEJYRAqhv94zm1?=
 =?us-ascii?Q?zieexPvIqRPQgAG4Ruo+KDJwN+VeZgUHGxBxZcV12raVqm9/UkZJSXgwfcuP?=
 =?us-ascii?Q?RY4bKnOYIk+bEaqprEuKGYU9+I3IPP/mqeNuCDt2+uz7Hmx7M7s2XAZ44s6r?=
 =?us-ascii?Q?4DDpa3WvWc+a9YWpV/cYDq6v+XNDZAVV4yFUDDWJ7wLddpAKuvxYBQrFlAa1?=
 =?us-ascii?Q?oH1U/PAxyDvH8YQZW+sQBr2my7y2clw9RVY6O3noH6pI4ars93xFp3Q44VGY?=
 =?us-ascii?Q?HoU4qI6PPCEXS1AG6jj9zzzGbs9qffu3LEB0BNxy+/uXGV72T9v2fX5wWKxZ?=
 =?us-ascii?Q?uOVGcIi7PkFLAb1CoElR80BRznDMDK/t9vv13QZzND9ISNPd2bG/nuyBQqDe?=
 =?us-ascii?Q?i+8/eka4sVQk+kWFzs8pM7aSsH0kjFdBopxkL8y+TB6LfqhutvJ33ICd9/mG?=
 =?us-ascii?Q?1YxZzzL4LIlGzVX2SkbICy7Em/fzBe72SrTdPRMR4XDq547hfVf/axxgBKmp?=
 =?us-ascii?Q?RMkDV8ap29S8ks+LNtYXJsfPBVB6yDvnF000su04pC+qZ9D6uYQnYPkxLcWu?=
 =?us-ascii?Q?XsNDOGaWojltSvJkOIttacKVa52puVRxp1rlPstBL0wvCqvf3k1HbCtf7UPh?=
 =?us-ascii?Q?H/gGoq/+yox1frGa2JGeo7LvKcanI4jS6Tg8SiUOqj0U5ogP3pSXJXQczmO7?=
 =?us-ascii?Q?ifLm9jyDwx3f8IftbBLRO9vw4Eqcy7lnix3MazK+Bt2Vw1QC0B1ppVpglhEN?=
 =?us-ascii?Q?uVoTiGn2PvQ99bOFbHl/wUs5WtU01Q1aG76sT+gHIeDOGpRoK2XcblPoV8s0?=
 =?us-ascii?Q?5iZcQG0u/Pu6XqXroEuOr12nVuIkkafN62KFWjQTNnH0sg4CtKM76mxuGPWy?=
 =?us-ascii?Q?lYqE021kxiMyBRN9FrMPaqjRTareGucSPUFZZS3mfNBqZtQebi5C+JhVjUBR?=
 =?us-ascii?Q?ykOJa2xLstn2l8wyqGnw3KTxsKXPnYhh5lu1IRpRD0q6pNJDSiog9FkHTDcS?=
 =?us-ascii?Q?vN0Gh/yjv9sSDrF0n+lApllymFrt64SBmPsrkePxjXxtENU3khwOZB+uYVeH?=
 =?us-ascii?Q?DI57IkZNMDf9kIofwQzF9cv13YdR5q0=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: aa96eb90-ab04-4ae3-db08-08deb8490027
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 21:28:01.0137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZNtyY+QP0isXju5YhTrAcihOKDpjUKYcZRk09IeRbloeqIVYh1iFCWY22MxFESVKfTq8WadrT18VSUhMO7gSmtkc8jbj2W8K+x2crgRZCM=
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

Tom's recent linker list patches [*] prompted me to revisit something I've
been brewing on for a while. It is probably not really ready for
inclusion, but it should be good enough for playing around with.

I've included Tom's three patches for completeness and to avoid
trivial conflicts. Aside from those, I think that patches 4-7 might
already be suitable for -next.

[*] https://lore.kernel.org/u-boot/20260520001234.1555120-1-trini@konsulko.com/

Rasmus Villemoes (6):
  linker_lists.h: add ll_*_name() helper macros
  linker_lists.h: drop _2 from section and symbol name prefix
  linker_lists.rst: update documentation
  test: avoid use of special characters in ELF section names
  linker_lists.h: emit lots of meta-data for debugging and sanity
    checking
  tools: add linker-lists.py parser/checker script

Tom Rini (3):
  sandbox: Drop special link order treatment of start.o and sdl.o
  linker_lists: Do not set "unused" attribute
  event: Remove obsolete comment and __used attributes

 arch/sandbox/Makefile     |   9 --
 arch/sandbox/cpu/Makefile |   5 +-
 doc/api/linker_lists.rst  |  54 ++++-----
 include/event.h           |  35 +-----
 include/linker_lists.h    |  78 ++++++++++---
 include/test/test.h       |  15 ++-
 test/cmd_ut.c             |   4 +-
 tools/linker-lists.py     | 234 ++++++++++++++++++++++++++++++++++++++
 8 files changed, 332 insertions(+), 102 deletions(-)
 create mode 100755 tools/linker-lists.py

-- 
2.54.0

