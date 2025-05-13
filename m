Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A50C3ABC3
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 08:42:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F26C82AAA;
	Tue, 13 May 2025 10:40:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="H4SYOXg/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B98782AAA; Tue, 13 May 2025 10:40:54 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5438082AA3
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 10:40:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fuGYGCfiXPqho1xbJngpEoMWgqsBM4lvpehPmoSY9I0L41oR49uBk6R2/86JmXgSDy7/tymcUtCKbFfACTfo4QyzEA4ThOSWUrMFa4Y9rM7mKL1a6qLx2ry79qKoYNJkYCRbrUeDbdrX/35gpGM+dl3UMPTYEdKEXRVU2lN2MM7YVLnSudEQHeQ6DetHpSSXbeUv6NgR0gHgZJHy5r4AKW2koEGobKIHdYlZmea3beT52GAnntphaIAS1STn1T0FkB20tvYa9OsBFVI6zLcjHXBERGerDRY5i2oG9AIyjcYXgJbKOm4yhWA3eBPpb+OZ/T8QtHDslFTh7i8sR0xG+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpLE+/J7jMlpkSV2zZPJPqs44R7xOfcYDZQWCgRfwcs=;
 b=PxXbTK3uDuacnqbDQqJ7ImD4AAw5sdnNws8tPLYBev0pONwnSnc7GE0MXJzfDzFF5de6s+VSAebALs/L/VivEtRFlF8w67c0Awny4g4bazAxQjJPxvVMYWrFnL7UBePRbS3iL02XrEIwmi5/9V3AjbmvvUCrv1EtsshVemHdNBEPL7SPtsorHLVYKdebBVMD5RdS5XmUAhk8514z8A9T6cyMU50NkLoBYZmUroejtLjLnwgLKfUeoDAta8K6sC/R0nhmLCSr3eT9hm+d3a4l8gcN4lJBLbsXtbuF3xog901ODKNRJVxYyyZFbuiCQ5kMqj1048EvYCR9p2qFOWPTqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpLE+/J7jMlpkSV2zZPJPqs44R7xOfcYDZQWCgRfwcs=;
 b=H4SYOXg/C/G9453eY300A/eSxUYDqPS0EdDu7rJ4YocZ73d0tOY1O2R3m3kQ5HP56LqrDmc2F1PK8de21IJovdtzD+Wtf+lpkoO8MnwlnpQkBWD6iH32WMnuBnWBKJpY8nxFmqb3yvZ8nC/eytDGEMGzD4ONwDuIrDkWqv54QHs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by VI1PR10MB3693.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:131::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 08:40:48 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 08:40:48 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 08/12] slre: fix matching of escape sequence used inside
 character class
Date: Tue, 13 May 2025 10:40:30 +0200
Message-ID: <20250513084034.654865-9-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513084034.654865-1-ravi@prevas.dk>
References: <20250513084034.654865-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0051.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::35) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|VI1PR10MB3693:EE_
X-MS-Office365-Filtering-Correlation-Id: 046f1a94-34d2-423b-a7c6-08dd91f9dbe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rdfNGrB3PfjbvOJk+fxE9mAYN55r4xPjMVGivQW5GwFLj5N47wNWQO82MxcN?=
 =?us-ascii?Q?v5UC3EqlITbmb+HQkxHvjFUc0DKXl0/d9BHviiScoZaL/H4uVUqWGajTUZ9w?=
 =?us-ascii?Q?oCpbNwMg3MHcknPclXnclWJCy/+sVxroWAR9Y8VNciN9cceFFwFo9E1EvUdN?=
 =?us-ascii?Q?MK91clrnOuSEKHJAybcGNtBLOy3OIuqwRgn5dm+ICRwwtZHf69Mlt9r7ER09?=
 =?us-ascii?Q?QhzXf9nLm/fnWgy2DDyz3F8NMBo1pQKRdr1bWxgr9LL+BlFQu3OyMcVXTzw0?=
 =?us-ascii?Q?Ywq6wQC27CWsAhlL1FXAChZFPfKt3LtRtckoxXZcVeLC0w8A/qKfn+eEMpyy?=
 =?us-ascii?Q?kZjHA94l5dZeWdyNpOb+8JX1AncZ/igXuLskpKUr2ppcf7L4KEl4J3wVDdpU?=
 =?us-ascii?Q?6LvU2rup493uZF2ZQ2V7G7PJVu/BMrIZ9mn/lpWimir/5y+FjNzrc095pyh4?=
 =?us-ascii?Q?yYqVgA3u/LMJNfI0F8d/kyK6CitU/Ht2mG1t5K4iM9uKzYbMBPENjZMfxlxf?=
 =?us-ascii?Q?HUe6D8YkCWY5TRKEuHGl2Gi4hQJ3ibCmipkHC3RDYjWCo48CK++47b7AGfJe?=
 =?us-ascii?Q?Txf24Hex5sPIztFE5sVb5X6UQwuIoKQZIGn+GiziLojJGWjVYaewRjHPiU1L?=
 =?us-ascii?Q?lJIar+sYDlmJ3r0/c1hoifaXh768Mi8xClg5odxE2Jhb0KujGJuTu8VU3/CY?=
 =?us-ascii?Q?rmCGTSx8gKi9ftSB+92NycnRJllNpCEAOopXg8DnQaPOJZli1iRGiAFv3UDW?=
 =?us-ascii?Q?nRTblT09ckthQRzVRvhoouzjRwqCJon4pZBUzlY0Z8+J+ab3y+ixN9aa2Iig?=
 =?us-ascii?Q?a69//Q6kdYWvdd409wzCP3QIAXMmlZk+3gESw2kwtPjeYLAF4v2w6ASZVZqS?=
 =?us-ascii?Q?C9NM7FmUvJT3+HN+3vfA3qFm9rIeHjrJe4inrKFlxZ6mwsHJYdnCfePCfbip?=
 =?us-ascii?Q?Um+Zk1g9JYmKgF6/gnsWmbV0P29H5TjuQ3BGtp77G/LtU13KSwf7VNuj8bzQ?=
 =?us-ascii?Q?Qov0aMOEM5rti6GYksRIfvbOWcNxSdFPLb5SMpjRG2j0nMl38ePiVaxcoAN9?=
 =?us-ascii?Q?/y+JHlUFmMnH1sS0IuHMlowJjXa/UUr65jIsmQbZiLNfrfyZYp3ia1i7w7Sw?=
 =?us-ascii?Q?f29CSNcFAI4zBEN9o7rbAF2pePgYcpSGuwR1POpPqsciN1e6rdTA2qsEvBCA?=
 =?us-ascii?Q?/zSDedqvBU5PR+RTy3JrHETjAvH/AibMY5jHJsuwCb0GpD9KGPNP8Jj2ny0r?=
 =?us-ascii?Q?FmVYNqSfUo7qR+Y8t/VDv70laApL1tH9j+rw1qqJq+qedV4mzgu3Hdf7iQLw?=
 =?us-ascii?Q?wTZnL9Ofe1inacRNv9pZ1PYw7t1NsFPqZKrcfhFaAVab1KhGAQYUzR8iyKzL?=
 =?us-ascii?Q?U5Ixko/MwPapbUWpaI/bMmDwsMPoRwq6lnVM4WXqPleCcN+Jb9r4WQlpwx5O?=
 =?us-ascii?Q?zAxt6BPfsk/eRkYLgIQ+b7+6O5tIgm67WW9X6PqlEQk3O3X4qWv98A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dXFWBIjkReZeODiD6SnjnNy/W8uuf1EwvpDfC5oewX9vnDDsbNbiMuOhkcoj?=
 =?us-ascii?Q?7p8l/pVv7euLcPMYvEwkn7ZoVHk2hAShCuwRXgSS6QIb387FI08eaD/uqcfO?=
 =?us-ascii?Q?Kb3ZhRait+gfQp8mHBKaQUdvw5IDykOEWoa0B6yZZ9J4Mpt01APm+lYaSjKr?=
 =?us-ascii?Q?OAbQI3Rp9nfNnzpmgNSNZ6hX85ywAZkUKlMu4kBatKj+6MC9RHFKq9DOikA4?=
 =?us-ascii?Q?MTihEl2ShBzKMGSqBN4YjzHJZo6oyR1t4Gg+By5S7BT8V6VxzO19be4XzbqS?=
 =?us-ascii?Q?A8eoWZ20XpEtpEusGLtpn4KLO6pUGvH55U2swP85OTVUVQhR5WgIJFSshZHN?=
 =?us-ascii?Q?8aaREoqk38hpJvS1ZmAVqqd7u3gwj31VUDMXCYhq42EqaFxDfx+pr1ejl8II?=
 =?us-ascii?Q?HNgHimlHtMS+g4FLlKgnsZRZFtRStYYtfXsYJMRpdlNby3VuU6AFBF3fg6Mi?=
 =?us-ascii?Q?aWpaaBvyME9QKdQu7nZBja4uIH7SDF3w9NOuZ5x2ho4o1rxHisUd5rEVOxAa?=
 =?us-ascii?Q?krkA27L/itP6/Sn7NLHVzO4DMqTola52GyjkhpC7LekU3RTMO3Nb8RbKWUpw?=
 =?us-ascii?Q?VpqLXlMfduxAVLoKPBbxGCYDOfkH2VTvdWrbdfQJ+dEyqlZ4KXMhZl+9A7sx?=
 =?us-ascii?Q?fBMl6hLxrwo3amIq7MFrScbMGkEiDmOzytUfGq0419eDVMZjerCKL/T/SWHz?=
 =?us-ascii?Q?MuMKYTFyCK3r5sKqX/dqCKfVfEHtfFMHQ1vEjM8+IJYyFnyFzDYOSbxTOjSk?=
 =?us-ascii?Q?1ehxwukyBZLwDl1CAjqJ0+Z282T9Q6WPfWvt52ycZTCwC1wcE/mpZWE6ASX+?=
 =?us-ascii?Q?Hp2zeq+u/ziWSPjP3GXSLOGxJc+fFyPktikIjwRq0Wr/0hKgfzfnBVB1sXtV?=
 =?us-ascii?Q?l0G9/QmSfsUUmQiFPpZzTTX+VEBm0EGGQo21wxEw9Z8fCR+EX6eoMSUhWLxT?=
 =?us-ascii?Q?2DbqifnmIMsD3Q/mYJ2A1PuAC3gR8MdQeRdsLWcqouv6D41eleAinnfRGtHx?=
 =?us-ascii?Q?xl7GibJK7up69aZRbYaR3XN3JHzlP+czva9WURLDnPoZtSBkPL+BijzYLJoy?=
 =?us-ascii?Q?3omB4NOMfcivhCiE3lYHa+BuB2XKxFZVzuN+MJg208lKd7+uobxTGf6oJP+C?=
 =?us-ascii?Q?FFmnwqg8VH+24fnT/BYgEBV4WGORzZXcCHlmaljHAAy7ppkpFQzdhFkzDkpL?=
 =?us-ascii?Q?SWVBXkJpZ0Hm08hfaqnU9h3/KXYBSLhLB6Iiwwgvx1zzHHsFMLLuyjDEnsUp?=
 =?us-ascii?Q?/LGlBf5oUvHYWG6MXLZn2MlicXzAeni18/M5k+CBw+Rf+0PHRpuvAq4MHyC3?=
 =?us-ascii?Q?2OF+XmaeSpEgq8pwMXLuP+69j9wzjfF+3ugsqPc4/bkU92QCcPHHo+lQTnNT?=
 =?us-ascii?Q?Af+BdlYa5dEO9MmqeObEYiBsvxDmwv/qz2pvIBYS1mPfReSF9AzH+WdSR4xv?=
 =?us-ascii?Q?xuCFo0PU4DbicCCLEw12hrF8YosTfE49eaWIpzjxA7iqFEjp829nFILs2o6U?=
 =?us-ascii?Q?44+2+ww0PjO71oPxNZ3JC9h/xODo6W9wtFLf1RWlMudNnwV8W9anaXwwsX6P?=
 =?us-ascii?Q?qKYnQcQ4EFhmA9pRFZcfoE3EPXKq6Gtl/Mc7TavRSpBIV5ohkjKzF4h2wzt0?=
 =?us-ascii?Q?4Q=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 046f1a94-34d2-423b-a7c6-08dd91f9dbe0
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 08:40:47.9700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sp4bPlcQvNS0kSaP3+5Uu7/8B9Ls8T7pvL7/Hi6Ye/ZJn6pzw9xZzjWcHmhAcH5Qbzdp6L7l1o+fZOXhDKa3vRQE3d9r1JjGPEAutltB3ak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3693
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

At the compile stage, the anyof() function clearly intends to handle escape
sequences like \d (for digits) inside square brackets, since the logic
emits a 0 byte followed by the code representing the character
class (NONSPACE, SPACE or DIGIT).

However, this is not handled in the corresponding match helper
is_any_of(); it just naively loops over all the bytes in the ->data
array emitted by anyof() and compares those directly to the current
character. For example, this means that the string "\x11" (containing
the single character with value 17) is matched by the regex "[#%\d]",
because DIGIT happens to be 17.

Fix that by recognizing a zero byte as indicating something special
and act accordingly. In order not to repeat the "increment *ofs and
return 1" in all places, put those two lines after a new match: label.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 lib/slre.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/lib/slre.c b/lib/slre.c
index 5cb0d3ec7fa..87dfde720e9 100644
--- a/lib/slre.c
+++ b/lib/slre.c
@@ -472,13 +472,33 @@ is_any_of(const unsigned char *p, int len, const char *s, int *ofs)
 
 	ch = s[*ofs];
 
-	for (i = 0; i < len; i++)
-		if (p[i] == ch) {
-			(*ofs)++;
-			return 1;
+	for (i = 0; i < len; i++) {
+		if (p[i] == '\0') {
+			switch (p[++i]) {
+			case NONSPACE:
+				if (!isspace(ch))
+					goto match;
+				break;
+			case SPACE:
+				if (isspace(ch))
+					goto match;
+				break;
+			case DIGIT:
+				if (isdigit(ch))
+					goto match;
+				break;
+			}
+			continue;
 		}
+		if (p[i] == ch)
+			goto match;
+	}
 
 	return 0;
+
+match:
+	(*ofs)++;
+	return 1;
 }
 
 static int
-- 
2.49.0

