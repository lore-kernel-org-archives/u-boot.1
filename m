Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7399CC3ABBF
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 14:16:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F57682AAF;
	Tue,  6 May 2025 16:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="MLxbMZuD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A459F82A36; Tue,  6 May 2025 16:15:22 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::60d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4983800C1
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 16:15:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mD3vdcJlrczjJac3Fx/Wy9PI5NG+4qEy3s+zHmWCN/nL9+DeGCP/AKbr5WD7aKZprea0XrXIiGIBqLc14w+H6Yj3PjyXcBejjTLgFjnV/0nQpPsw+lmnX397G5Ui3fp1Qrv50M16ExUJEjtwTgMF0qftgzZa/3AEIqjEjUeHWPbryL6engDmo5SeKSOWe2ZOf8KaNeJeOAOybp4DFUqXMTQ/MBn0hGELwyKRBeqhUyFVEXjTCRV+s1Y6zXGKd+t+hWIDFd3nxwTqWXyQ1+wBGfu/wZV3r7a2VkSH7JDJCht36u87PPb2ZKKm5Wq/GwB9vVwBak8XZ3jaGlQNq/heGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4l8XZ9iKfpE1Jb0yt/YsQsanE9MPdFCJQQyI/QcKYD4=;
 b=HqnD6qF/9dR/5t3zOoz/9MaELaq+4bzGQQPngs9Ff9NEcrDGlxFRi3YEdXk8HJr4ybUrwMLfZLMN9Ky+Ap4fJ9mVXj2n5czX0Pi0qockth4CXSG0SYyTSnSId+kkTpm2gLoibBVIgbSK+ejbnw4iV0Kqa0k+Z+9V2yZcE3pDWsBt3dBzGQmi9oMT5tdldMo4wQTYm282rgYAWNWISc3hZTnohwhJhDu/qT4TOmEpXa2KholuveS8sG0tOFNA7yL7AoCp7pw4RT21TJQrst3y2dTgeCsQjYj09XBXjVAfza5rE9AS2Q4+kaqGrMCt0DGJprVlYicVKLhslBR9ABdVcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4l8XZ9iKfpE1Jb0yt/YsQsanE9MPdFCJQQyI/QcKYD4=;
 b=MLxbMZuDptxUC0d4r6FjXv+8BlQvVLOyGMQeLdmRvU20fl3D0LD67f+qwhyZ9YMw2uRvfqL9GgqMaY+E9iIOAy5cvtO8KzijPIFFhHP+t6cgSWaxaBfUmshUKxuHvEzgEdBn5KIcnAx1+Z8A0qODDOv0xPPGD1BxR+SPPyudso4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ca::21)
 by DU0PR10MB7237.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:44b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Tue, 6 May
 2025 14:15:18 +0000
Received: from DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bb5b:4bac:5471:b769]) by DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bb5b:4bac:5471:b769%4]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 14:15:18 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 04/11] slre: drop wrong "anchored" optimization
Date: Tue,  6 May 2025 16:10:28 +0200
Message-ID: <20250506141035.385756-5-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506141035.385756-1-ravi@prevas.dk>
References: <20250506141035.385756-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0044.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::12) To DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB8248:EE_|DU0PR10MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: 31cc28d7-b028-45d4-cda6-08dd8ca86e13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AoNt6KkHpzp6X1v7ougliHyTzmn308ytITHKVyPhwWBYHOJk/vJ1nvWNwVSL?=
 =?us-ascii?Q?pm/50+qN01EpuZ7TtgQmxRw45BXPaGyGq0Bc8l5sCzRVm6fqjqhN67+kecnF?=
 =?us-ascii?Q?TYpuKawM/EGsOeOBd40UGCZ24HjPaoGcjc3w0azIxyOsg2/WulLUpr7v8BAc?=
 =?us-ascii?Q?AacW8wugeiwZc2hFYsCDR7WoVmRfKep6Mvv7GF+eW8QLduMajn0JRErMKP4f?=
 =?us-ascii?Q?ah1I68NxFndXs6laegTsG8OsIUZlqoA9ha+/dAbbqKltt43vddDW3H06Wt7a?=
 =?us-ascii?Q?Om4mhPp+WPdlBrgv1nW69w6m6pVtz4JGTg0xloMPFaXtF0wq/zIthU96vhu7?=
 =?us-ascii?Q?Mii5g5kb4dRTEqH+pXyz4CksLXUYeq9baenISpqhi6Q8+PzvdBj2ac7uUFcH?=
 =?us-ascii?Q?YgMTfciE3ZU81vhxP/GwfH+T/NSmAe9Z+Pa/GSlX2NvSiqgMrWr/gqAWiXqp?=
 =?us-ascii?Q?hQ7yDgSjr3xy9rhGfOoN6HJFZ1RbIqNcw0LOJg+0D6qtu6aA4U2uZGcdjrNk?=
 =?us-ascii?Q?cVdBqdqDBYRqOkyKWGYVUsvqGF+F4p4t3q1kXVfRhWGCNOF4aI2JTYNqjzup?=
 =?us-ascii?Q?iX9qkK3ETkRWA5VBGxtiwcZFHcBDey4+65eZm1LpNvb9zJT7qpKZsq/kVGfq?=
 =?us-ascii?Q?ClBRDTspPuEZtK/95vSF0j1zEP+USQbVLNbfdINGcZT27cqwOyelwHz0XOGZ?=
 =?us-ascii?Q?FWIf7pOM+oSZCizRXymiJrvciTrTkhVqNkVEpcAZPLKN72p1Xt0gcSzFBOd4?=
 =?us-ascii?Q?iuSU7qFj5qRs6izQjrtMZyNNj2qb8s6Z+JRu9L5RKoGj/QWNDTG9Qdo67DQL?=
 =?us-ascii?Q?ypz6pEfVuNDmGtz4s/nAfPKCFCQ/r9T7BvH3JDVXwtLwLjSanUJwP1XNbutf?=
 =?us-ascii?Q?eyYvT9EAfqWmq7KqvYbLG4wQUcbv3csEJ8vffpJwES2ZajN6EU+whhXxPDLt?=
 =?us-ascii?Q?0BAe6mXfFXtCc8gPMQWO9Sm4l+R+rW34aE2QhZjQR5XEfX3I4ZIc/20oHgwu?=
 =?us-ascii?Q?Q0kUi3qMPL+CE7/RnRb8RyTdhSIJsekx6rzoR63ck1CkqKeN90S+4Tq/zACF?=
 =?us-ascii?Q?Lm7H6T6W0ykpIOfTJZrMpj55AFBQMCHbsiLOVc9fTJjeuxWDwH37gJCrNumG?=
 =?us-ascii?Q?CYuIq9Zl12cWOwZN0LbtZNvZoi1c8X9gHvWzZ+pPC8LBOyRh/Mw1/lKaYBFX?=
 =?us-ascii?Q?DrH38lGWiWe7UbIwNCRJ+wpPoyV7ZF5Vum1T1zB96RjzJ0u7mpyKqa1e21eK?=
 =?us-ascii?Q?I+WHHOAGxUV/hLpUIDhZ+ZCQFe7WYGQ6qeZ9B+FbYNpNUC18SADyPXEykUXZ?=
 =?us-ascii?Q?ZKEkAqLgTj3B5YqEs/paFy1AbIDM7kWrwqb3Ck3UppAHYtw+a3tvgG5YXvet?=
 =?us-ascii?Q?w8YYQBp+c97ovsRlqC8uHHGkH4llO/qWd09PSd3le3b6ZecEfsNU1+BFd0YN?=
 =?us-ascii?Q?mhnoKYOcLHFglCkc3yZJYk+DGdlrgbV/+UMfa03+dayI3Xmi5u03mw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HjyfHK8LVi8ec3UQQGjwDYEJalXMezSu+F8fntXnBR0TAaCpi3H6dtqfODel?=
 =?us-ascii?Q?rwZgKTZsAM85PfHQZOHpoY7vj0eK1bL4lrsRR+jheO5nBzuP5sAK6STYxgDM?=
 =?us-ascii?Q?udnIBYFsJJuxb0sUqWZi9zfS5D29AE4l5Sre19qyCKWBZBIiIg2u4C0rEYI9?=
 =?us-ascii?Q?MXNDTePaSjnZvqAIkPPpW4OLR+d7GKzG4Blu9YAmSz4wYSs1AsdbUtf5TXd3?=
 =?us-ascii?Q?bacx3fCK6HtiO8e2hJTEtS3J+lZtl2kB1p8IkpBqMur0B7S2X9knfQWsDS++?=
 =?us-ascii?Q?qAsFdOnm65efvFHss3ZafhMjsJEnD6D4wk8YG7j296bLnLT6ExslzV3fbBDO?=
 =?us-ascii?Q?/jneSt3YO3lnadv9hGgUADKtCz8NIOf1B95/beq/BSgqDJ9TV4JcTnLhrqCB?=
 =?us-ascii?Q?sm9NU8xtYtwVCVjIf3rYuTvSgvAvGRNMw5wavhdAZetnUANE63GMQyerDUE1?=
 =?us-ascii?Q?h8IKiOukGqJ6NvvDR2lVk2T2sOeziQNoeOrT94JjDAL7J2TBOUDv80Y6lppj?=
 =?us-ascii?Q?pF0zrr+POprfn3HKeXTv6/QyA9fqv3izVeK8+rsba6s6I5bSX83A2PWRJSXi?=
 =?us-ascii?Q?KXXxyY8Taf8ZmSN6DKZbawWFciFSqG0S0hLY9ta9dczFsVdWBaR2EcN6tvad?=
 =?us-ascii?Q?ybnMD/SHJ3b8FWyyZACvJX9x5t5ttRruFVEkAHieSI56R9Xv1px58vjyKNI0?=
 =?us-ascii?Q?uF/RoEBtL73T7UNEeOcXDS2ZAHnxQ/Qa/QQFDaM01ljAKHLwdAK8ERN7g/rL?=
 =?us-ascii?Q?rrGxQa9qx8uBbECckqmkdkXFz1qDM6ADQRmhyKyPHqxPQO6FVrTFswV8c33h?=
 =?us-ascii?Q?GJ0+8+VePc8tcJ90fK5F1C8qnGJQWuO/zQj7wB9Gv4CnQH6RLFtYGJqF/GOy?=
 =?us-ascii?Q?+d4qj0B1ro5UMZQX9wL3jm14ZPQsM21MLkk6egV/HppxJJdGITPLTZBnw++n?=
 =?us-ascii?Q?QVTStd2fZOmvou8igLHsJWw9liN3Iin1MHLZxVjzXcYVTPEuP+3vmoWhOfBa?=
 =?us-ascii?Q?wPVHESsvTxxS8qKXr3zDGLIaltN0y3xadVjmh0v49b8mUNuYaf3Ax5cRAOUp?=
 =?us-ascii?Q?N77QCTRmP8RdPH4G9uWhAft3aWPYL46tkcLOb8naxnih/4QVyLArWUUOfC+o?=
 =?us-ascii?Q?jhK/3CGUFuivYZgZ0ZVm39BEmfI5zou9BALGWBlaN1QCYNYrWOVMP/IPP+hS?=
 =?us-ascii?Q?dMWly6z7vegayKebbyP4/GbYZ4048V4nHoN/P2EsxXHxUieksdkCggg2Dt2z?=
 =?us-ascii?Q?AT8QKinw4+dSfvPVi97w91yiQITVu0lE2w3ltL1BdnxQlIhPjc6Vtc9jEHsL?=
 =?us-ascii?Q?T91d3IiiVYswuXmNhVt/rZPGiQbFh8IK68s23vB7VLkY56HDrQzSBf4HgxvX?=
 =?us-ascii?Q?e3aNSmuQqtR4CJv8scF8Ao1cM4K3JdujVAGcZRl312D8uBECg6I7INlWqBsh?=
 =?us-ascii?Q?6ypDRO5xezzf7iqc3/Q9yzk7CRVgpUyQi9FOxbr8XCcknD5hr2kyv43mIU1G?=
 =?us-ascii?Q?nUr5bou9YOEVrgQD1rDobb4gAWG2wxLRTyC3QSr5JT13M9K+o/hsyPWQsA2f?=
 =?us-ascii?Q?1TP/kHtfxyRuDxc5XMGhLkqPt6y6ZNYf81tR3+neK10TvOBc5YDs52hT1cX1?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 31cc28d7-b028-45d4-cda6-08dd8ca86e13
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 14:15:18.7128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gs11ZwS0y3B3bVrWqVOH8T4ioCS9vGfiXZ8Keib/LOtSRr9QNQLqf6XYAkApjejTWb4kFXMgVFWhWP/GcAFDA5E1p565kt3daDQ/c3ZWNW8=
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

The regex '^a|b' means "does the string start with a, or does it have
a b anywhere", not "does the string start with a or b" (the latter
should be spelled '^[ab]' or '^(a|b)'). It should match exactly the
same strings as 'b|^a'. But the current implementation hard-codes an
assumption that when the regex starts with a ^, the whole regex must
match from the beginning, i.e. it only attempts at offset 0.

It really should be completely symmetrical to 'b|c$' ("does it have a
b anywhere or end with c?"), which is treated correctly.

Another quirk is that currently the regex 'x*$', which should match
all strings (because it just means "does the string end
with 0 or more x'es"), does not, because in the unanchored case we
never attempt to match at ofs==len. In the anchored case, '^x*$', this
works correctly and matches exactly strings (including the empty
string) consisting entirely of x'es.

Fix both of these issues by dropping all use of the slre->anchored
member and always test at all possible offsets. If the regex does have
a ^ somewhere (including after a | branch character), that is
correctly handled by the match engine by only matching when *ofs is 0.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 include/slre.h |  1 -
 lib/slre.c     | 13 +++----------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/include/slre.h b/include/slre.h
index 4b41a4b276f..af5b1302d9c 100644
--- a/include/slre.h
+++ b/include/slre.h
@@ -63,7 +63,6 @@ struct slre {
 	int		code_size;
 	int		data_size;
 	int		num_caps;	/* Number of bracket pairs	*/
-	int		anchored;	/* Must match from string start	*/
 	const char	*err_str;	/* Error string			*/
 };
 
diff --git a/lib/slre.c b/lib/slre.c
index 277a59a03a7..4f455400d3a 100644
--- a/lib/slre.c
+++ b/lib/slre.c
@@ -413,10 +413,7 @@ int
 slre_compile(struct slre *r, const char *re)
 {
 	r->err_str = NULL;
-	r->code_size = r->data_size = r->num_caps = r->anchored = 0;
-
-	if (*re == '^')
-		r->anchored++;
+	r->code_size = r->data_size = r->num_caps = 0;
 
 	emit(r, OPEN);	/* This will capture what matches full RE */
 	emit(r, 0);
@@ -650,13 +647,9 @@ slre_match(const struct slre *r, const char *buf, int len,
 {
 	int	i, ofs = 0, res = 0;
 
-	if (r->anchored) {
+	for (i = 0; i <= len && res == 0; i++) {
+		ofs = i;
 		res = match(r, 0, buf, len, &ofs, caps);
-	} else {
-		for (i = 0; i < len && res == 0; i++) {
-			ofs = i;
-			res = match(r, 0, buf, len, &ofs, caps);
-		}
 	}
 
 	return res;
-- 
2.49.0

