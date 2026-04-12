Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B04E93802
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 20:00:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E501839D5;
	Sun, 12 Apr 2026 22:00:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="SaEfmNI8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3157084119; Sun, 12 Apr 2026 22:00:07 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4B2C84198
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 22:00:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ECMG4URG4XCK/6XCytngSHL3UpA4uDSn4PC1hAdP9depa2fiXBQhr6GRtBBmwtlrHsjvlGTK1EbFaGMxOPn6IYSDYFyutKRe6cY9NKTCEOJMvvKahHBay31RlXZw3vKwhTABSgsyNF4bE3T8R6Wtb9nRoPbxpb6EjPI1f8NBiv/ODUwttIjPVhivkkXPypJnYhbukhdQ8U7baqjkZnJg5NcfHGR02wGOWBBFxrPQMbAnIZon+T/rW3sgfEH4lmWWgYsoTamTJ9ZyT018r8c7wugU95Mj+lrJvJQ1uUvgX6oJFdiTB16ZSlyb0zf2Vs7802F3BUxUf5IaAgZfTNhM6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ToY/RaAjwtEJBhuqtdza2H3OOSxUl8+GTX2LF0BGtQ=;
 b=MurtHF4Fu7HdGVgY0Zq3wBRt2gPzMEiJ8etsEASBGoC0JD6z3OvrK1Nl5LI9nFfNcGfYOXI46pQmy4BrPTiSAVmDKllCxZAlQdTdAEYy5zNC0d/AM+8pOd/BObkpH0FdTjxo/IOktNfsZdq6p7Ci2gv6bVS90z1xYD/WoiFuDUcCyYAAdDF/1KAUETUvl3ZCSasa+RTlTtd1bwin+ZoyR5FBjRM2rVDDYwJqY3Dc5Z1N/KOTtnU9Xl1SxF28jr9JavTZN54/8WTjoZ6ZgvvPSDAsY0nMmqvH+waME++a7b/U2tOG/U6KSIusbjPpKewUlIe+0VfmMsgSg4qTEi85/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ToY/RaAjwtEJBhuqtdza2H3OOSxUl8+GTX2LF0BGtQ=;
 b=SaEfmNI8awcXhPxAI/wG4LbB744jHoMwLydvUcAKFpw9gUXMuM17R2iuPDNgtummP9xTZUHDc6bPCzdSmbTyXHtWNDKEAbMaIkgqGllFF/EsiP0KB3VIWMOEO/474pUUvSEFvpH5sy7VE3LPxLtot9L3v+zdRPKa6bfBKn/uYzE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV2PR10MB9930.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:341::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Sun, 12 Apr
 2026 20:00:01 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9769.046; Sun, 12 Apr 2026
 20:00:01 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 6/8] lib/hashtable.c: use memdup_nul() in himport_r
Date: Sun, 12 Apr 2026 21:59:45 +0200
Message-ID: <20260412195947.1982729-7-ravi@prevas.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412195947.1982729-1-ravi@prevas.dk>
References: <20260412195947.1982729-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPAP307CA0005.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:3::13) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV2PR10MB9930:EE_
X-MS-Office365-Filtering-Correlation-Id: 2059ba55-b4c0-4e22-eef5-08de98ce14bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: ycLnAV6Q2DalEOq1pnlGC+Bv1mCE4dBzAP9cuCN/7+ihytGm0Ochsl4lhaelF3TE+MhK+97N3LDH4YySCdMQnPXE3+oAGvmUi7uDMytcGPHAigDogwJ1suL2FOMJyzJJUBXqj7PaBAe1WulyVsdzjIUUE+Uv7VaabvuMLMo2RMTDpiAFPrK+JMBtg9Yhj/oIajprsv1l54fLcLoLskmSWZYCJ+ckNhQqBI/dGA/JzVygf4AEqgY7BB2y0yuQ+mrUJrv3jurbD7StsLX99g7NcDMCuS2OeSH13CMrD3Z7yMQX3/5MyWWteQEhngoKrX1BRYLESmaOrSnOyj91IsQXfKwjzLJ3gqvxnt/fpGHxPxQT/4vU0hgBNq3WfvpgKq63TJxYSvMd3HPd/b5EkniCsk1Jiz0colU/TlZZHCXIn0TQiTB79kpkkvt0YysUbNVOGBxz5L+rrwCoTOKqHZ8Vp1yivfTpFuh6X3ljl3aPSffJ5w0UADsRoHjzWsDgvwBwr5jtjLEp/UDbrHXnpqyYqAPVmdOE0p14nBvHdBcIW7/P9wCxlcMAzFX6FDoBPcWuCtVfa2lTqDAl/LVe+dzU3Nj6bYQyMjusWjN11ldc9N1Pdcq/Pn+EP+E/mSiQYCFxdoqmj7dlQzVwyiVJhHZuHwAZHF+iaUuUFrZNzBpUj2ErxPVeBlWhVc8kf59Lyxh1GecsL4whDgcnv/LLC+zqqkKfczoZAHjCkwyxeDpo2DX8E10ASHdVlCwoHR6+jVkQ8INnqg6Ak2jQix8Iw7CwQ0s8z2n4cKWTutrL1vCqkSc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vWYLO68IXlCfFwxLQ0j+Uc5Dlf/aqrQ/Xowo8vvzEvRRH+u91uT/j5XYMIG0?=
 =?us-ascii?Q?etvjbLzsAZt11vAAil2rf1T2+/X4i2OmXStS5Y/AFPtW3JXNQfv3i/TdDbOs?=
 =?us-ascii?Q?ZE+AMfQpfvsUWxtBp/q+zY3JYR3np/YbuGP7MYIAbKL/Bv3tdtS4Lp6Xynnu?=
 =?us-ascii?Q?qxel8omN40Yr9PEYQ72Gj6tn//B3tiphbrv0feEAirgpUa+g716yb0ve6NmR?=
 =?us-ascii?Q?Hfokpou33kVujEiTLjBEbxpSIEaTv9AvOF5nSgkq1n7Q0qQYiFevFlN6xHyX?=
 =?us-ascii?Q?9Q4QqpEfY2KGoNK1TN0h1sCen3VGBuAHYHO0NJObhUI5H+zcZ3gj2EE9Cai/?=
 =?us-ascii?Q?Ub816ciAnrIK6bGTH6IIGQJDpGTTQemUcFGyqGpWkFmnyKJnawM8P8gK6KdZ?=
 =?us-ascii?Q?1SG3zTB/9Una1kP5M215H+xIC3GrSzjBpQxQmwzYGCNN64/bdOStd0sPXvYR?=
 =?us-ascii?Q?p6FljqsHEukVsD0nDBnF4uEcoZFLIKndG81/te8Sg2I+9+mtJeQDMZVAWbEZ?=
 =?us-ascii?Q?oRCzJY4np1Y9RLA3uJSUTToVHKtwK84wZfTSxkqcxu8ZKkKATWIx55XBPL29?=
 =?us-ascii?Q?5BU1Niuxw/BgWBvD5WLgSDEDf/GUltk8WgflBhk/Ut9zZsoM0aefwREGnndd?=
 =?us-ascii?Q?maGOiyp4qBb80Z1nkDAnnw+KYBny/hpFpqmBaRmitm41qEWBqr5VDTC8Idrv?=
 =?us-ascii?Q?rs6775CgG+WW84gncn4sKY1it8oMArw8EFvLXbhFGflD8OcTMLZhtGoTRgV2?=
 =?us-ascii?Q?oXG1CrXONs36AhyFn0ffScsOJErcC8hSHCB81asjupqYCGce7A800hpnwkNC?=
 =?us-ascii?Q?ek3TSoG9nNE+NOzWOyzw0eJKNMFEGG+bpQ1tZ2dtFUjxibF3Oh7bN5i0v81b?=
 =?us-ascii?Q?ean5DewzVU6K1vZMUOv9ej3HPBamOFpTok5l8NoKqa7oTgvp0iy2LA8kzQax?=
 =?us-ascii?Q?p8S5AV9yWqx8hyZ6zzz+hQtrZ7nIbpF8aAq2T3hfiaZoikryu+DROOIQHCVp?=
 =?us-ascii?Q?pzDFDra5rS683J6RcBx74YZvcIScqq78lr55kYfnBMsFzQPDDmiKEmL32kYd?=
 =?us-ascii?Q?7Tr6193ZTR0R65a3tKsBCWFDHVHshVn2Vf/yxivf51HtpQcPsHHs3S7itSHO?=
 =?us-ascii?Q?SCqM353N+iR/rBu4C8F4jsrw9fdPaHaZZ7HnzqPk2KI+4C0hHo7N5BY0SgUH?=
 =?us-ascii?Q?w5girRob1T45izbWw1qdp0c4P0bcTBcNy4R0JDzQy6dH5iI/weDI1tkTufIU?=
 =?us-ascii?Q?GEf0cJqNx5BGh+RnWu7rGdKbJDj67h0VSRvTRm0gnCjY+dJFa6EUtw4PHNDw?=
 =?us-ascii?Q?6p/m1C1vdSDOgTw7uZ7W9l99kSiAT7eWIhUnoH3i1VvSp7iBC3n7BIB3UuWb?=
 =?us-ascii?Q?hPtN4x5IDJyqEGufJVyIW96arz0NEyvQwjngvQlgmed6EdyO5nVHQPT0XIub?=
 =?us-ascii?Q?R10cyb/B+CijrrLBj9wSBp5xhNeXpkfbRd5eREMJ58ZeENYJsSJdDVsJYY8p?=
 =?us-ascii?Q?UuA2Ri0QSIaWC6PYWnkboNu5qUf3ZifpPHsqPqps1lzaAfz/0DPIrcawlVqt?=
 =?us-ascii?Q?wLLGyCtgiPGoAri2Rn9P0RbSD1h17QgEAIbdMWk0VEu5KyP+l4Ewr0xWsbAK?=
 =?us-ascii?Q?P8vZyW7CldjVN1rAT3HMNOBT6wjB0TNyQxss15lILwWyGQwPJearrOd4gzHx?=
 =?us-ascii?Q?hPRZ9U0LzI76i6YOhLunUFw9GVi+YpakemFBbTbrGecd6LioRxkNK3ULpK6G?=
 =?us-ascii?Q?4ReUhqhqpNexBCdkAnGvIiIcNbSl9bc=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 2059ba55-b4c0-4e22-eef5-08de98ce14bf
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2026 20:00:01.2603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5r1R9qQkBHWuK61LM1220qrwdDOO03gyXW9xMxkCALM3V7Pwk7dOmKolPlF9Aho+Xa8VzVhZD1m34GWWr/eMBqbGFEXE9F+h3jTN/qDRRcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB9930
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

We have memdup_nul() for exactly this pattern of duplicating a block
of memory and ensuring there's a nul byte after the copy.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 lib/hashtable.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/hashtable.c b/lib/hashtable.c
index 75c263b5053..f96a8e686f6 100644
--- a/lib/hashtable.c
+++ b/lib/hashtable.c
@@ -821,13 +821,12 @@ int himport_r(struct hsearch_data *htab,
 	}
 
 	/* we allocate new space to make sure we can write to the array */
-	if ((data = malloc(size + 1)) == NULL) {
-		debug("himport_r: can't malloc %lu bytes\n", (ulong)size + 1);
+	data = memdup_nul(env, size);
+	if (data == NULL) {
+		debug("himport_r: can't duplicate env block\n");
 		__set_errno(ENOMEM);
 		return 0;
 	}
-	memcpy(data, env, size);
-	data[size] = '\0';
 	dp = data;
 
 	/* make a local copy of the list of variables */
-- 
2.53.0

