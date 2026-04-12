Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0C9E93802
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 20:01:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AABB84206;
	Sun, 12 Apr 2026 22:00:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="SvFdpjrc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2390484198; Sun, 12 Apr 2026 22:00:08 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AFF083EC6
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 22:00:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WY66xGLD3eg7++R2r6exSOgDf+5AdKJoX349omQuFpBd2egfN7gplwMOjMqErWDV7q/PP/VjHy9xOY72IVqswiZVIqYY4MCvHJwkHfuJMfPEkPDfx+Gg9dUzTmg/M1ZfwkNBZsMcbFDLYf3KAkpy7GAWu1f/pusqK6PNbiW2Q0WFxotEeka+4QQqLUNDJggalGRaFLZbP+L5U1huYcVMN+cewyVTjw1uqf9tyX6EDHbNNor867LyAAUMlJtzTiRTjeyyUPnzJyL/BXcP9P14oq+esB5gNCm+21h7cg4MsJisAqpsaNBvMK93Mhw/Elmidvseb5gXDlUNHzZiLSU7cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXOC+UotCZduEDYkyfIVNnb/BulrkVIjiCvsKPX05H8=;
 b=hecDOZ5tfZPwxxgaB8drt05gyK7UyBH084Uy4+Yk3Ae/J+9Ec548Kvzr+ETNvjkf7DxcrQLZ8fGjVhJvSEJdn6GDzeAkmDT/JD4jfY7flwje13BX0ZSrx0Jxx+IKhUDEU3/6RBJfRfg7WUNUBwZUZeoXqDPik8Uu7JFaDEfG1Yt4L8Y2hABX4oyf6aW/KVUL1niYqA29xNZNbhOmvP579rGy2GOaxvgwt7EgqywsvRcDqn2EbTO/dkIObBYSjcfenVevnJg7+ndM2VJBB5K6R2uHiycz1bP7Xntb/W81J7P21t3sS82/EWHzRYIXCoRv+2ncV+SK5Yu4PdDDW08PBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXOC+UotCZduEDYkyfIVNnb/BulrkVIjiCvsKPX05H8=;
 b=SvFdpjrc5ixLBSvcEURkRDjjoiL/8OjA2vWzpctEMnzY0MBtTLvAtgCrHjIXGgmpALNN1Cf8+zgRYy72wJCWqJ8SbjeduTiIuA39cFAtPamdwkXzbCWUS2IE5tSbq3j4ydFIa/qh5m0R+g/wHqsnnQCTuxNwBfbXA7d6s1US6FA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV2PR10MB9930.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:341::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Sun, 12 Apr
 2026 20:00:00 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9769.046; Sun, 12 Apr 2026
 20:00:00 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 5/8] lib/string.c: implement strdup() and strndup() in terms
 of memdup_nul()
Date: Sun, 12 Apr 2026 21:59:44 +0200
Message-ID: <20260412195947.1982729-6-ravi@prevas.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412195947.1982729-1-ravi@prevas.dk>
References: <20260412195947.1982729-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPBP307CA0004.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:1::13) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV2PR10MB9930:EE_
X-MS-Office365-Filtering-Correlation-Id: 14d5155d-37a9-4470-1d4e-08de98ce1417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: tOtszktiJeuIoYeZjj9iY7WHW2QPOOZ5pbelv5iGImb/KlVYV8esWcg1FMbPvJVd+j8IsNLamO+NlWWOtjbKYGvJoeQZM9Zcf2M9+LS4rcITiptbR+bl7ygT1xW3rV65DXnDBj/Qkpn81taNGWeWyh3EmNvEFtb1Ltz6osmYPsyX14yMICKhJecBOD3HvKpFBre/7DbSqllY5s1zPrZKlK/vPyzFPw+M4Kww+cSYLGlQBfemaaFNKh95XvnkF+oCQJ4nYm0rU6pU0qLvsNVBQCs946KLDN38/5oYe8hofgYtkiGw/RYpkOKwFQE0JZbki7GsG5/uH/VH5/g/LfdxX3dVqpYx27GkEINNb+DLBW4KR5lkKxjhrya+6n/FmP5oTnbz64L+lTsy/ESFO2bCFH9wBLEzEbqgJQBjVZExjXDcbxbdhnI+2oAW2+xKH695sWHZ2Jwq4UPikiSfdC/uQB3JooyMk8g7EqODGkAz7aRVpwlXGWdQ4N/QORIKVQNBaklT9r6tgz1Jt3wTmhE4nynCK4Tmcujuo9r+5uCNXjBTl/GKReXEh4XiuNfHeqz9+uC4jo/7pfL3nkflPw82MilaTr5ynvhNPvd2X/vPUVPnI5XsVkVWRv65yesI75tKwcogukbeVEJt0eG+wjXkW5H+W75SBDshKLvnDFJszti3tn+ZUtYj+6sGF84f3q0GMjnfWuOnrOP1qkPFC249QOmQmWZLXewmXfhPjqVdopjiN6w4b2Oa2U9N5Tc82S/F0CKaJ40jU/Ugmm5Jy7gWUwmj/+Olzr4iDMZtgsslDaE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KOMMkeD/FT3X4twK0LWkOU5X3HqJ1kNDmRD4tCMbIkCgTgB52gC1VxwdkkaF?=
 =?us-ascii?Q?XH0DyAD4BvXPOrLgwf9ZWfy26q9gz7/9sFLApikEhBBoPmPreMR/FBr8RpcE?=
 =?us-ascii?Q?gkVSPb+02f61fADS/Rl1IDKcTGdIFrfWnoCRXFZSFHYo/JCRrD3g8uD2pBYE?=
 =?us-ascii?Q?xGqRnTdGqwWz8rdtQuAiC5ObDFQONfJ1ypDQ4TSziMLpWEfsi+LQO4UFVWfi?=
 =?us-ascii?Q?/VcLgxT62IJerKIs6sehkIDiprn70ztrJZvvqHWrC4xdTsC0z96W7CKjEwrA?=
 =?us-ascii?Q?P3I/RQByVQkuSEYPQ7GcN4ZN/TlbKaut2cuCQF1IVPrz2xDYcYZavv9WXT/4?=
 =?us-ascii?Q?3mWeeqrwscLR6uYBLZMEEQ+B6fb+3O0grSwRoWd4bmENnRVbaLJTnSDIwepx?=
 =?us-ascii?Q?rAtsn5+Gv7JlkQJrGjVqIv3Hptw8IFnnPtYZ0F1mO0chy2lypm30C+WQV0BY?=
 =?us-ascii?Q?U7Mlyv+HaBqL5LSuYp9wpK3Kea5Td4vNrVFve3zrHSEOY/iheSY/CYD8d/fJ?=
 =?us-ascii?Q?CJ7OCJeejzGJwF+XXH3XtX69gUqtXRRZKNrrSzAdGqOALmdNZQrKQ7h2uvhB?=
 =?us-ascii?Q?gQfK6pEfzwYLrpjUjJAfWpBtnhsXoORta+Y7gW/W7XhlZLIL/SFt46Zcm+pm?=
 =?us-ascii?Q?SkFmDUp0vlMDPS2v6DNMqM325atmv2WvwhHD6EiApZQdpOsHkfjh3+ShZPtB?=
 =?us-ascii?Q?bo9a5F4zDm8XOhq9tLRNuB51vuxUUBBQGPvfzJ9e6MIh756ZtsIJezlG8lOb?=
 =?us-ascii?Q?vN9baPmZuAcZDt8cXCL0eQfk391Utuxm6hu+bJauW20YUTVN4522ER2EmMYh?=
 =?us-ascii?Q?LeGv6aP9ICcbIOMlAEJDVUGM2Phvhg/75MtnO+pzrzlWeRT7Jjo1iNEsgGLI?=
 =?us-ascii?Q?gjkl9i7W3He2yfqAiM2cWYcQ7YgpZENxoVQH3r5Cs2Lj895uHXM4f08ILL+z?=
 =?us-ascii?Q?3L+oMHaqX1TKqT8bRJgqBwH/4HahEPW3b1nCeEgkwPjDZJo/pJYlHzb49SP+?=
 =?us-ascii?Q?ytLq64XTR+szwcv4lmWMB3UKygNTJ+T3Anh/Gs6xU+jK1tkCu6nD/6opFiVl?=
 =?us-ascii?Q?tq7pJthFqce2liv0Y365NKKrFgPi640BsyEW3zbeECd5E0nztF+nFQIJC0L7?=
 =?us-ascii?Q?DyZmC6U9IkW5+cfx6ASRsmvAeZJ2szz8wBzNvklQFQTtWhQf3M3WCnvPL4eg?=
 =?us-ascii?Q?YBowx/+YeYXEjX81Z/4Q+JUWKMxnRYtXycxeOVWfGQsBFXNtGhcm427rbmZg?=
 =?us-ascii?Q?SZVEbECfeZF0RKVJWYyMl9PCTdBS3nJMPFnmX9H6xXHG7sgkdgv/0MoQuX0M?=
 =?us-ascii?Q?SOFyjZsfNhYBeKoaD9yAaoOEKxys6DBi0B91OlBz/Qp3wx3Img0eHuKuu/rg?=
 =?us-ascii?Q?XdvID1D483FHNC7Fwx3LFYJBuyRiKftNaepaF0H/wUHVqNeUGidJYAuKKbIF?=
 =?us-ascii?Q?jT31umlGD27O8mCnY9ayLaLb1G4t7AcWoQBQG8qtIGkI9+f2IpNi3qtzNeR0?=
 =?us-ascii?Q?9qVO0X4dUJ42spYB44kzwsPkLrZE/DnMLryMJjDh0jTy03d2oxLADBVWPBlI?=
 =?us-ascii?Q?OErvSTsnC32AN+1HjY0fNXAPSpix8wV2leH7BrIoVoD5md7S6bmXE+2YGBrr?=
 =?us-ascii?Q?MuNf+Sm6tjMj1oggacXbNZtoMgihzx/kkiwXHvFvatzW8NcKLAb+n346+lwS?=
 =?us-ascii?Q?Z1yO1FODXydjZn6MWUOXJpP1iDnuToauAFqlopf1C1sY7NrNUi9ptHvDu1mg?=
 =?us-ascii?Q?7GMzGGi11G6GHWKPl5q5T2w8AW5g7Bw=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d5155d-37a9-4470-1d4e-08de98ce1417
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2026 20:00:00.1693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swRULQuGg104C/JO+Re/eM21+eC354LKJMPI9sMRgN4IZns5GMsTqEBbDWq/V5IJOeRN9FxwUM0RMQ6CtMOf/pYk37Ubnnh/p76EaubkSa4=
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

With the addition of memdup_nul(), strdup() and strndup() can be
implemented as one-liners.

While not required by POSIX or C, do keep the behaviour of gracefully
accepting a NULL source and simply return NULL.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 lib/string.c | 30 ++----------------------------
 1 file changed, 2 insertions(+), 28 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index 3923cce5561..5ccd1011ab5 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -360,38 +360,12 @@ void *memdup_nul(const void *src, size_t len)
 
 char * strdup(const char *s)
 {
-	char *new;
-
-	if ((s == NULL)	||
-	    ((new = malloc (strlen(s) + 1)) == NULL) ) {
-		return NULL;
-	}
-
-	strcpy (new, s);
-	return new;
+	return s ? memdup_nul(s, strlen(s)) : NULL;
 }
 
 char * strndup(const char *s, size_t n)
 {
-	size_t len;
-	char *new;
-
-	if (s == NULL)
-		return NULL;
-
-	len = strlen(s);
-
-	if (n < len)
-		len = n;
-
-	new = malloc(len + 1);
-	if (new == NULL)
-		return NULL;
-
-	strncpy(new, s, len);
-	new[len] = '\0';
-
-	return new;
+	return s ? memdup_nul(s, strnlen(s, n)) : NULL;
 }
 
 #ifndef __HAVE_ARCH_STRSPN
-- 
2.53.0

