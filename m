Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0C9C3ABBF
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 14:16:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C40B82AA4;
	Tue,  6 May 2025 16:15:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Kq3GgSn7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1453482AA4; Tue,  6 May 2025 16:15:30 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::621])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD08182A4D
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 16:15:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvNmprTUvIg/hEakCrQv9TThiZH7XCFjQ9j0q/9cSaIGHjwh6QAwtQ3cFEUj48pS8iYQ2LjQsYMIygMQtuzZPcJz1DaKg83pXFHqZcE9A23Y7/NE4xJiJOZKWP9kHLSJTsOXmVjDcSk0h63ZjTgiGEZsdZ8ra5PuZrzdzVOoYSPIFJGalNQtP9fwmTF+1mAIwhnZZ9dCXYxZ50qjCRRqYHxo1ti+mmoFG5ItXrHguHbcnJB/Hdch4wuun/UQAdVeAagpULx0OlKWjMZqW1tLBHiHCdqjHr6KcGz7+hVMFunrA9xkPCQBWmudh+iZjlFSJmYLqi0I0AdbSjBARQ1Uuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIrsET06Dap8CBcRszHCoeUBi+Ti0qTPBJq8rGtLx8c=;
 b=CBFWkMWjkQctMY+sUxXD1iS/qMHxh/s+GTiwS+bnwLGIyn95aCLGn9UDla/O1RR6xVjVLceAa2/b0C5JmGxl+fkuUKfNavTAr6rdn8LvukSJoMlraLB/tz/lXyutU4fJ95jmBfujarofnN0QTWPGE2iqdts+XcNEr+7/EUuuOpNLuZpwbzOMB+OktYA5zufBKG0Yqe5PaaKw9lhF0SiXJE8bLY0V+bHn5jEcw4hAqRsqlTVhcU5pB5DufreSOswJ2O/vfL1o4JLAbpME4sTRZKQQ9vf6zILtGoog9zs2ZEcJRWcTtastbujU58OwYV07oPZt9OblOug2m7PGEl4OMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIrsET06Dap8CBcRszHCoeUBi+Ti0qTPBJq8rGtLx8c=;
 b=Kq3GgSn7np38TM0MFjZgLTClqK31SnzAqbMSU/0NTJuYAqmMhNGeea+Ep4lfhuHEASMFDgTNDv8Tf+oL5VXiq49uJ6wJWlTWlJZMt8K1vdUXNAJS+751kFaGOF/SDTGtsDYdO7Q/Rv+CnSAtM5Ao3WnluGH7RvsU8O4Shg3/6EI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ca::21)
 by DU0PR10MB7237.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:44b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Tue, 6 May
 2025 14:15:26 +0000
Received: from DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bb5b:4bac:5471:b769]) by DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bb5b:4bac:5471:b769%4]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 14:15:26 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 07/11] slre: refactor is_any_but()
Date: Tue,  6 May 2025 16:10:31 +0200
Message-ID: <20250506141035.385756-8-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506141035.385756-1-ravi@prevas.dk>
References: <20250506141035.385756-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0096.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::31) To DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB8248:EE_|DU0PR10MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: ad8bbf20-a60d-4cc2-5cc9-08dd8ca87285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zdnVpWS+tFScQf0q84xY4orsFoDM1o21IeVdaXBUERdUXbvoRrRUfuvDSCFg?=
 =?us-ascii?Q?tkNzHa+hpKqcGEKNQO7C55jRksQg3AIdCXNkXwLSv6yt5UZoAB9jx4GsxkNx?=
 =?us-ascii?Q?PnTs4oqNv+eGhmvjCh7w4pR5/Ml9Tkkm6tMneEMc3wXwdqIpub8o04Nry3e4?=
 =?us-ascii?Q?JJaL9RKJI6rW7wda/oxS1sozFqQptjpN8n+mnyFjn5OQCgiV+GZBepW0GbIe?=
 =?us-ascii?Q?95TdiCrR6BcJiQ2S+15gfODvIZdbOyTd/vkuZgXV/x57a7eqUubScUdTGOL3?=
 =?us-ascii?Q?Gg/Asr4x0UcYlh0Uijfa2i/yug16aC60wyJJ4r8FtwMBo64ZCF62QEVfqBws?=
 =?us-ascii?Q?0yQuF2yWxiq3CwQAn7eVWJQwaive4jQvSd9P97OTiVdEWZg15GIDNlA+ZtNG?=
 =?us-ascii?Q?RBHm6UxB3J/n/ZGhOwVnNn61iaT5SRDG61B76a1b623k8mGZ9LVYg/e/Osuw?=
 =?us-ascii?Q?aX98sRG0B1sm5lyP+xoEyJxF/hxOtS8NoRDqRHz6KGJDAMVnwxL7mrNotDRe?=
 =?us-ascii?Q?6N1JHGNjg7plQ93zKRAMPZcA5tgrHO5e1sG0MtO+2WL0gh4s2ruaWXgwpRPX?=
 =?us-ascii?Q?WmQhCUrfmHNzJN6PYlvw3Qy7WHAKtRkqNJPUAsZe5Ys2cQkEXZ2SYAdaKCm4?=
 =?us-ascii?Q?ikJskCZ+4/YeGEyyImXtQj81xPdrUFHe8Lqlgz8Hv71wYnMPib4DXrkVuEB7?=
 =?us-ascii?Q?6JktISufpChLQYvnjvceUv3TMT1BzwFWnK5DoOBWUecDJ5/RQXOmb/6HJ5OZ?=
 =?us-ascii?Q?S+boAPWTY7CW5wRK8cclc9zx0jNsRkjFrp/WLoiqwHKuYTROUjXKaq9BfSUf?=
 =?us-ascii?Q?gDmI61HDScvM6a6RodU5S0p3JMHnN+JbQN0bp5PYvhKkca+TMEPoMqjUvvxI?=
 =?us-ascii?Q?6TftLXA9rHC5d3RC1lFVvqozA3uQRdAyKryKZ8naYNYk1xC4lmDUXxXaAN9S?=
 =?us-ascii?Q?Mtb5drORLUd5kQuSQ8gE9P9OqVQUw7gQIVW20SR5pOPOUnDbKAvT+yUccBCP?=
 =?us-ascii?Q?BVsYPuAzD5CkO4FEbe4Y+l4mL0fX5gCu4wLRXPioYxbzScQP7R1oT1cX7AU0?=
 =?us-ascii?Q?dBxkl5040rrlRLgowAaM//Omuna/a2R+FjimbNpoCMfNtmV5az+AU8136Dpi?=
 =?us-ascii?Q?qaR4MkNujhvhtrl7y2pGgzIQhQIX9EJGjN+yTp4bSSBLdcSojtGvcY88CSnO?=
 =?us-ascii?Q?Zv1ln/MvX0z84bbYlvUz8GHWyst604H5kjhjUAltNiUbTrLWF5xftYS1W6PB?=
 =?us-ascii?Q?LLT68Tb8QBFrx2mrLx1FwdtAAGB82C93Bfe5gBa5md+pzktwXoY/KVS+ZhrF?=
 =?us-ascii?Q?Oz8fCH4XicJmSgoIJcTBz5/Qag6PS/jcW7dXgzu2d4eufxx87LC2wTVHexRP?=
 =?us-ascii?Q?haWhzxtCw7eGEupwCOAIgWcswZVVSbnEO0yKNO5Q1dkVsEjNNwK+6xBM+/Hg?=
 =?us-ascii?Q?Pg1MchSzH6HqoI+zyzjXkyV0QzCBMUTo31oUg2uSJb/f6CAoR8FQGQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MmT1t8Z0CCiObvAXZ0LCE8adu+dNPC89V80ZRdQFqGyCfMz8LsjT+lyMRmbr?=
 =?us-ascii?Q?CflglVuPL+7W02IzX9oFqVlIZzNEPNlPZ1ic9KGha6cxG6r6QdX1sGckJWhb?=
 =?us-ascii?Q?ZMXblSAfmSxTHohyDvTkq3vHYSG8AvNqdd6APm11T62/o1wFnRyujlj78iIT?=
 =?us-ascii?Q?6bupf+3x4a+140Zsax8On+9zPNabuJ5kCbR+T8pYgQqN1c5GxYTSPtt0X+Q8?=
 =?us-ascii?Q?ptCsz6cvgHUjsqF8QOFgVkxmGeswRa/FWk3EoFF5k6JK4RcY8hDw59bdMeix?=
 =?us-ascii?Q?UlqaPQYVka8faDywBRC+dm7oIoBMcxjW+/ZaDmEbo92BRPcStSm1eLVuwFu7?=
 =?us-ascii?Q?B9qIZeUVSvITkBYlDbQzOETx/lbPkFhveO/nUMhkq/CBJQjDkvsYyu+lzEV1?=
 =?us-ascii?Q?3QBCg7MtKm6sc93SGAOY3j2F2diWCT9zuW3ZO2RHJNxx8TLib5UHrFoys+/R?=
 =?us-ascii?Q?WnndABswr1XPAzKx+sbXeSnUKnETR/zBq/DRPPcvfZzmx3D0DfjKY6skp3LX?=
 =?us-ascii?Q?rtLczF3uIZIljrsTQBIz3rSSuio6gTKpJuQZSaIU7XB7/26V09/jgILBT/Ql?=
 =?us-ascii?Q?ARvmbq+AW2HGWt2ocFQL15+Rwba5Y/ofpOJr/idQdo1SxcW85RH6zICulh2I?=
 =?us-ascii?Q?BJQyLPtLtBlUyU+va16zve3sPaBO0YwlzcP+iuLu+p+ngxG17ilolvFJa8I/?=
 =?us-ascii?Q?EYA4+Gz8u4K355iTKJVP8I6EGcYeZgASTHwbN1OnJn2AcXlYD0qkuvi92SbV?=
 =?us-ascii?Q?Kv3BkDV9u8WgxMx7KupsSsaIgh9llXtcZLGVRYuc7N9r84zlyncC8tGTAUQi?=
 =?us-ascii?Q?ds1B8Fj2KM+RyA4gpiDOfehOxr8TjLOGtic2JSCMYRSuCidBnQenC8t11e0Q?=
 =?us-ascii?Q?YRRD3fF2tgjvUWImCUlCmjhtLg9JK83QEXaRO5dmMKaRB+DDmAXuMmrEagKJ?=
 =?us-ascii?Q?QwobFO+9ci+GR2vyXN3P3qwsErK98GxE3kSIh9z3eWGMr82En6WS34YM/+Pk?=
 =?us-ascii?Q?6iRZ5/9cUcY/jEsy227DSn68Lny5xjXOl06niv8sFfXswopN1GsVIdIRPtVx?=
 =?us-ascii?Q?dBnhvxXR823nPuShazGuB4IYBjKgxTqlkXWkW324jZ81hQuPUgvdZNaYPQiv?=
 =?us-ascii?Q?703Z+TP8eEYytyztfz8+Jd3A2/Qu5vItBCGO9JlV4X6u6b/mccaM92/WuGke?=
 =?us-ascii?Q?uYRcYi42YNpXae7gU6WRFXasbCdFkPxNfGS3Qdjoq+xHPkfNg51ynBUM3mLv?=
 =?us-ascii?Q?BXFXRAD6fyHTRLMhoouq7EPCbksfe9eeOuquCDtSKZwzzoWrI00lJkbp/fIn?=
 =?us-ascii?Q?IsAEkpYutN+AebvIqZ1tJyLv+y5lRWu/wzvlSd7rRb4DEBVLTuCAW66G9Gop?=
 =?us-ascii?Q?6yUf0Rk+WjNkEG20b8HATYC3Gi72HPq0mi7Aj7OKPX8nCcIT6UhjhS43fNq6?=
 =?us-ascii?Q?a2E8LCQWKqJSWjKtWUEouraeP4ZutYqbbz3RMunofXoZA772E/7FsM0jq9LM?=
 =?us-ascii?Q?YIt8SVi7iKth+f5FxKsCa3hxU14p/DWEYttTVG2ypc/LDPzbgokPYXTNRRuk?=
 =?us-ascii?Q?V0k8IoN3y0jtQZy+pUPWdOE+X5mDl/YuQutXJtEsRHnW29nhsgwWx6tL1W3p?=
 =?us-ascii?Q?FQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8bbf20-a60d-4cc2-5cc9-08dd8ca87285
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 14:15:26.1375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /mS8RRTUrwVuPEj6upIFt2e1JrD3C+c3/ZevBemwH1fDxbsDeZghQs5YPA0YYI4Nsa3/t6Nsir5o/PS8fiSYweYPJCLDugtDjGfYKLrtaXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7237
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

As preparation for fixing the handling of backslash-escapes used
inside a character class, refactor is_any_but() to be defined in terms
of is_any_of() so we don't have to repeat the same logic in two places.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 lib/slre.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/lib/slre.c b/lib/slre.c
index 4f455400d3a..5cb0d3ec7fa 100644
--- a/lib/slre.c
+++ b/lib/slre.c
@@ -484,17 +484,14 @@ is_any_of(const unsigned char *p, int len, const char *s, int *ofs)
 static int
 is_any_but(const unsigned char *p, int len, const char *s, int *ofs)
 {
-	int	i, ch;
-
-	ch = s[*ofs];
+	int	dummy = *ofs;
 
-	for (i = 0; i < len; i++) {
-		if (p[i] == ch)
-			return 0;
+	if (is_any_of(p, len, s, &dummy)) {
+		return 0;
+	} else {
+		(*ofs)++;
+		return 1;
 	}
-
-	(*ofs)++;
-	return 1;
 }
 
 static int
-- 
2.49.0

