Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFFBF327BE
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 07:56:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 059DF843C1;
	Tue, 21 Apr 2026 09:55:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="jLJKwMkt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52C20843AF; Tue, 21 Apr 2026 09:55:16 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95D0484348
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 09:55:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJfm7JOlAVrqPUSuNiuZAqWUxvOZOcrDX/gj9RkSDC1+q95UNdCaQWYBVKO0Hwo5tIqn+mRyGl+qLqthBjWGuWedz38Gj20Gm5XN5F5KnMCheyHhLWFSghz8yxWqYz6L5Gu1oBOhTWPSyv6Hunrc+xCRwbEvDwWAptgFR7nmoGObKV9katVndAhSm9c11vOQGjxh1eBE42BvMzBiFIdfw/AWiREwFAcnZUkASVRqsBrqdTTbfKhieBsINaX/Jv2orLEBytbI6AVvi0eNxGQNPzKVfpq6+oihjz5K/Rk7xDnaIR4ZqwFVpqb3t8DzBGzkTZrta6y9wDZXn6k8uxhvTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/keIx7z1F0B1drgwEm6OixQNe4eXUt15QKTDn9F6hk=;
 b=edyuAdP/9niFMaMdIdj6BZhOTvspb5DiUt3qjKJT9BUlepPsSIJNHpWA5i9FPi9dkPL7294ruvjuouHo15EcocuM3KlNJFHNahoiTaJAW6EK6PE+gaO2QHgbYG7JdYL/IK/AEYlHj/Qxy5vPkU0QUqqSRJ9OBBSIx7d6eAjEy3NPM3Djy5ZTHgEHVE2C1Kb6g7VIfktYL7ruNKXMJ5CoTXpxdW/XhHvc0inDgQMBCw7z9vPs4gT3yw8awK7sA8RLsfSCHKFf4iPY4irGToAHOpY150X36OE+pYC78GqBhUHFsX1Xvjy25+4+WUT5kBXMzaZoyeh8xf0moTsauI70oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/keIx7z1F0B1drgwEm6OixQNe4eXUt15QKTDn9F6hk=;
 b=jLJKwMktFYJimJGWo+bMEsyNAP0xEhJCh5+ny30crdp9Sspg0ZB8gu/x5LyLp/JV/Jdg+A/0Ub9fCGuYp3FxGeaI31AOVYcx8/VKEBim1T91I6DMQM9AvPvicn6cdff/sJQpcU+w7GX39lH0szm3ZCTXGYAB8UuoF+fkdWQCMbo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU0PR10MB5995.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Tue, 21 Apr
 2026 07:55:07 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 07:55:07 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 9/9] test: lib: add test of memdup_nul()
Date: Tue, 21 Apr 2026 09:54:39 +0200
Message-ID: <20260421075439.16696-10-ravi@prevas.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421075439.16696-1-ravi@prevas.dk>
References: <20260421075439.16696-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF0005F67A.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::3b7) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU0PR10MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: 82d7328b-90b3-4fae-70ee-08de9f7b4df4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: X4ZlggQqqLw+KjgZ0h+RDDxtB9Ez4AJeyqthv8gkKo7V90wKfw7v9uYLy8VpLC1veBNp+r3uxe8DFzA8sikvtmm6FQVIlTp6TYKZ3sqvCm+8z04WshgIdY26G1IuxDLrcpU8VodTmBXOlGAwivd4zKiOAAuhxLb7A7l04ePBVFY6xxQr2BX5jeLa8pkmWvYFh9FF5ylNFfw2kJ1NHN47pCI89TXy266ULOIkOuvg7E1IwDv/RZDy0A5F7KO7AmODXpKR5Wow3Chq0OHYEL3AfZzrnRGTA2vjpF7fTtYQRdMjd2/GhHJgdADApSi136a19/T/BZhRo9CMK4tXf/IvFi6k2YX2cHEaonPmzdzLD9endHw8E3JuAV2QQ009MU107uB5hvPkSEK3UsBHLM43NteM960KKfveoaO6rFvEcPID6JG0tnPkKeKU0OUSDEEbDHsj1ZllipeDKseJkGEsNUPlKRN3un+CTl3a+rRxwkH/mgUNB8px8rI+ybM5cs7XU2xMB1EYoisaxPO2G3G2uScQlyWfFuzAut6UReBQaC9H35TJoIhraN2bjgqk5aPtPRgQLeiyQevQ8JYl/2FiQMlbPwbIxt2YaO9DOsC8ntPgp3+3FvAalhJ8qhx56bVUcstcqxdyRarhSNNiuPG6DJmTxCrJwx2gsaFgp/OJSlFn9SvbwORbIXp8LIBYppZTRWrE005Wok7MkSsN+QceHm7qAjmJ3aohJ3q7t36it0RoAO2Om/g+MipTaw5HGejQwcynh1fp2wl4LPcRaszdDZ5qtgBUXxQiFgT4+7J60Qo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xQeBh45N7rpxcH+UYmMZOKZj9Dl6EmrQ+eRpZLrWB/eyVsoS5NCigr9xi6h8?=
 =?us-ascii?Q?BiD9CL4UALVhwJidFbbWi7+fiUctJ/fHun5WYgr2Ch4cg7b5+bDjqmfDdFru?=
 =?us-ascii?Q?43Cc0L3TzuWjzjcyp6ttA0hgq3ojf7sbCXCA7YBPOPxPDyapxiq+BT9Aq+8x?=
 =?us-ascii?Q?qWr6rZpMUz2V2MwWS7CFTHH4E0rQ+paTzDlmOP3aX+v8+x0AA6DGP7Jm5PBr?=
 =?us-ascii?Q?FyhZHy0qjfca2t756Dibxr+1xqsCD1vk3NeD9qpaKndCC8YfgRQE9Gd2jbd4?=
 =?us-ascii?Q?A2VASCgdoO5wsf8d8gRu3RWJ5+zMtQCp6KX4eTotutL/vJHBFv2RZPtwnP49?=
 =?us-ascii?Q?GCsBqC49RP1V91n7bkuX1QbvGKsJW0rWgSVvqcR04IHsl2yFyhAo5MyJS5wN?=
 =?us-ascii?Q?WuY1i8nRrhdd6NJ0zEyDs+HZbtmjATtZmC/QkrdzUA2ZZvRR+jIu/CMsgvR5?=
 =?us-ascii?Q?Y8ErVVKV5IT355orAe7L+WpnZyx7kvSc1vXiN13EW110weAIYhHlru0v4eaL?=
 =?us-ascii?Q?KUx7MT3F9sRh83dTed7GpbF8E6I7aqzV7/CTpjfKC7gJiuqWqsUzBw4nbmrB?=
 =?us-ascii?Q?Kg+ERAMcvE3uCzkezCeMKaJfYxnkqOVaZIzVtFQZTo4ziVsqL5mmuAwrbCJu?=
 =?us-ascii?Q?LGslnA6ABPA3D3nHfpQ274mmaKbKkXvOiqUCBEGI5xlCw1sq3eAWjuXlbMAL?=
 =?us-ascii?Q?ySs9kfC6Ib1cgr9YA5c9O2FFCgzH4Lly2UPYYT+LtP1WT9kzaha2Wd2Fj9uc?=
 =?us-ascii?Q?TzWI6hbkQYgxeDCS/TZd3f4LTVTyxTSxydodcpGGd1BXexvD9WWJl59Xn9ys?=
 =?us-ascii?Q?T8bfe9qpgha1dpDvqhz9Jc3H16wlu4uLx3ETgeUXjOr0JmNukLxBUYVSKB5+?=
 =?us-ascii?Q?+M7xrzGdZDzO8vr4EZ5GuZVLImTJso62tpzAzT7GJjKw4W4t23AyUlUfU9Bs?=
 =?us-ascii?Q?yHd6RHhy7+69ixoSN/S7CGEvKa7LEFw+ZX2SnrTLv8zO8ROZW5awA6CldJZ5?=
 =?us-ascii?Q?QjQrMo30/7pdClKg2PJ547g/IbPebSPOvFFGXrwvsCaLWTdZXPYbJBkCKQV0?=
 =?us-ascii?Q?PVaNJPb2lq9M47XMscqgD5Yq70qLE118eUgd6yztbyUZH2yJ82A5jTY22VDs?=
 =?us-ascii?Q?xNeuwydl+GdPGQvELNp8rv2oOn0N1nM3fvA30rwfJGmHcpb+KnXYk+VGmfzX?=
 =?us-ascii?Q?JpltYy/ghLpBaMC7fIrtTzNSg4EDgUbeG5+z0uRjEvR9NSsy2QvGOApGshK/?=
 =?us-ascii?Q?jWRyWCrSKYwOe3fWLCMb3cJpG7q1u2Cet9UM4sy9y8UXrc9lJAWRvj1TT7NA?=
 =?us-ascii?Q?B+UehsUQ58JUGRD767W935fC8i125UPtCvRl/iaVTJMF8r1uwQVizZLz0Dyx?=
 =?us-ascii?Q?jw65RUyGkoKE9ntT4bR+BbPZ9K6dXCpLAG15vwwDdeETg6LI2DBkW4x70KrH?=
 =?us-ascii?Q?Eete7A8dyImdOcqNQFQW53b9Eh5jra5ijrpyUKrrPYmSucuVpcsXvlmTTGXT?=
 =?us-ascii?Q?hq+8B8/UG/Gh7kCNhDiaOtm26efKHURWr6Mr9Is4JYf1LQ3VxSfH7WRna18q?=
 =?us-ascii?Q?LbPpFv60eGrcAMn/XG4gVpc1IgsI1wLcM4JKnPTZZuqtuyTqbJUD4558nvTy?=
 =?us-ascii?Q?qrKBg7ZZDNsjraYWTX0pv3nZjl4z+s45lsc9dWB8t3EUjwtnBxvgW0kQCMJN?=
 =?us-ascii?Q?63joJohaE5VSKc5mGr7tLBnPdxFZ31K+A73vc5bOs9d4b5Gki4OwNcBA/Gzi?=
 =?us-ascii?Q?bWReJr8BJkrrBj/losD/MnKiXIGcju4=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d7328b-90b3-4fae-70ee-08de9f7b4df4
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 07:55:07.2147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4yex/LPHYK6NwOphaQyfkBOtNw4oByd/lzMh9kAcYHntL+CycOd+RYlJ4A/e1AunZ+f8ctZaWzvaMbNE/MnRBcW5ZhwNmjymK9rT57VPylw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5995
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

Add a very basic test of the new memdup_nul() helper.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 test/lib/string.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/test/lib/string.c b/test/lib/string.c
index f56c2e4c946..db6f28dbfdf 100644
--- a/test/lib/string.c
+++ b/test/lib/string.c
@@ -223,6 +223,40 @@ static int lib_memdup(struct unit_test_state *uts)
 }
 LIB_TEST(lib_memdup, 0);
 
+/** lib_memdup_nul() - unit test for memdup_nul() */
+static int lib_memdup_nul(struct unit_test_state *uts)
+{
+	char buf[BUFLEN];
+	size_t len;
+	char *p, *q;
+
+	/* Zero size should return a buffer containing a single nul byte */
+	p = memdup_nul(NULL, 0);
+	ut_assertnonnull(p);
+	ut_assert(p[0] == '\0');
+	free(p);
+
+	p = memdup_nul(buf, 0);
+	ut_assertnonnull(p);
+	ut_assert(p[0] == '\0');
+	free(p);
+
+	strcpy(buf, TEST_STR);
+	len = sizeof(TEST_STR);
+	p = memdup_nul(buf, len);
+	ut_asserteq_mem(p, buf, len);
+	ut_assert(p[len] == '\0');
+
+	q = memdup_nul(p, len);
+	ut_asserteq_mem(q, buf, len);
+	ut_assert(q[len] == '\0');
+	free(q);
+	free(p);
+
+	return 0;
+}
+LIB_TEST(lib_memdup_nul, 0);
+
 /** lib_strnstr() - unit test for strnstr() */
 static int lib_strnstr(struct unit_test_state *uts)
 {
-- 
2.53.0

