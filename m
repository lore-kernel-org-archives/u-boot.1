Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16783E93802
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 20:00:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E34E841D5;
	Sun, 12 Apr 2026 22:00:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="JYKbfdH1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76F298352B; Sun, 12 Apr 2026 22:00:00 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8369F83B99
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 21:59:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZagRbLxdetFX80/ix6oNU6eUmjr3CfpFc41k4OPRSNKU7l0stNtuWOnu/aXHSC191ULN1U6d6ncpyTAy1gMxMVB4Rii0v2Ie2tsEkp9v3GHM9hwNg0in3NaQk1/nRmzde+wDG5GI9ytREpZ+Zr/rkK1FCcVxetJ1C1yqRHNxz2qah7m7WZdnXNb0HD3upY7TQkCsfI4MciEtd2IzWOz7BFtEqmyrUzPSOl7ckRXfGrcL7WPEcbwxm8h1ZGZd5RG5/bPUCnj72RVC61ikKHGn4pyTUr5buMXTS4aZVzEMwF1vMMOrZcdiBTnNwk/AbSgRCSLDGCRt/zQdMvwAOM9ceA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dlONrw6VjS9Puu9H/zzos6H8bqYo7hyhz5qfBP2IRY=;
 b=nYDg4qYaIXO/o/rbFYVedhXstgnGYD7eYveRPQQArOETa8dBrksFkAOZdjP4bQxWVlYPzPdmfnDBV0bNpPs6lf8ZUEBwhhC8//0MJPtvgWVtCvMOVpSYLc3poKhzz7L8MCGUfWnLoIYBtn2zqYCIsWioF2VjqEU16gyP+rzPayyxMCTTle3bKDD+cRZebKkKsTS8ohBUgMXtCvy7hU2PnOrMFn9BsqPGSBvhoNK7FLUT7LomHz3WVqA6IVkkUYwRBlvh+LRwuwHrncUPcM8kHkh0mri1zJMHBFNOmlA62omJdiW2CmRWyb+ciSV+QqjEVazlzKIoF8cCbw9tG9JCXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dlONrw6VjS9Puu9H/zzos6H8bqYo7hyhz5qfBP2IRY=;
 b=JYKbfdH1uChziW1fGiSGm874RxI7a6d8h78sIjxGkzYThuxD4h4TWA1jR67zYFSrbRlGCfvXO/DB6cHncWJEl/mpfW/hDrRCn0upuoEvKH9BoXGpTqVEOsjrPoQNUiuuWbD5gHFj/5RX8/RYRYJVBC0CimzUQhaU7scEomIZavg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV2PR10MB9930.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:341::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Sun, 12 Apr
 2026 19:59:55 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9769.046; Sun, 12 Apr 2026
 19:59:55 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 1/8] string: fix prototype of memdup()
Date: Sun, 12 Apr 2026 21:59:40 +0200
Message-ID: <20260412195947.1982729-2-ravi@prevas.dk>
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
X-MS-Office365-Filtering-Correlation-Id: 4da5de80-df46-4001-fe43-08de98ce1109
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5+35oNfNnUg66zwhdC4YzOG56xXZoJSjpblG4P3X4MlkH3nhwkA9W5Z0PpZJY0VPUIXEFMmPIVaZRb8Or+I8OC0Z9u+KJ3x6SfX3K0wOljL309/MuPXz0WWycaOmbPximsDQAaHvILDXjFGacdDVoC06ji6+STlczCflE+nwjO/i3cIGwF6z4kJHXNnwvPzP78s/yDIuWXSSVhVET6BMCsg/WeZkysQ3X3HLjWUUzFQA8PqhwjEipz0exX747A0fpUVCK9xg9rtgJISr/X4aBwHu6qlMP+Sz0K9phn6YyMlif2Hfx7nWN6s2ScV9Ljb7miy/GvN7Rgs0SedCr5GphLaebZ9eQ54+joMniL/pVn2tQ5rRVuF1JqDPQ8XbZnzJljdrq724DXbQ6SdqDmtLr6v5bwDJF4vRkdd4pfFiK+GMS8rpC3NDdm6UrRCbLGetdl7kyHJ/K5lYz5akqOEdXDcZbhdIeQNQyNiXlisWzNM9zlqFOcpTRfTeH+UPtyLweaRb5NVT2Gqx4/I99sT/Btage6z1MSpigG0hQpZFzHLMELyQthwkR9CjEoHln1e6Y1Z3gIvrH5nlDCKRgQKvpak+++XrEgT/1tcX1HgDDzg32lFLQVm6LHKNmXza2G1vL9OG12qdIcmhV3DkoZikTcE2zm0vOggZ0HLzopJDF6biRxNJ4mSC3bW6qg6KKOoP84vec81+ZV8LdkUcTYTac00oXBHuMXZydTcwPUZbueLZbo55wrRtQTt4voHT7CWHPOt/0Q0/K750f0oKn5jSQnd6VFRGRiiRFiihJ2SiU8E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UDzeYLlNz23ncO4N14FaTOLr6v3MQ8OElq9fFslR+VnqAHLyFDYXg25B6bk+?=
 =?us-ascii?Q?fB/shg24qVGxGoF05aDmOdjjigOx0uDK7VW9821Y3lqt7HERyVIn1VX9uMGN?=
 =?us-ascii?Q?gYiQVPCbWFq3qqB8Pg5iAFCiMyLiYOLNSZhrIhQbC4pb0FUMrYuN/Mvv5VHO?=
 =?us-ascii?Q?T0aZimcJYf+yDYjlqeZtHuS7JphTRiRBgnyojQJRNtULrgTCrNshfrViIQKK?=
 =?us-ascii?Q?GMjfpe9KiZjU8b89mNtBxzs/vJmRoP1xq18Ak0zZ5C71OhyfA9WG9ydxHVKs?=
 =?us-ascii?Q?kp1w7g2t+MQJXkt1mQnW4sUUvZLRt1jWfTw80D6Xlq604oVqUIAwaGB9ZpcK?=
 =?us-ascii?Q?YGhR4kNgdJMjjn7WWzO3ZV5rE0HLfdXj5ozURa+6f3PBMOYz0Gk7LKlpVOtQ?=
 =?us-ascii?Q?EAzMtImzVDfgLYmEfkYDh2yrGk64Xd2OAQqJ1+TEB9jspK6De340cp/xuWjo?=
 =?us-ascii?Q?DQ7t+Cc14aw/7uctW3ghJgmCGYCcvkzdQeiz8RCvkQZoXfv3ai8LXGpYonhy?=
 =?us-ascii?Q?5grznfsQXUQL8p3IE3iux4hT+ZLNwT/Y2k9Xnlz8T9D+sJCxemIGeWnCdbrI?=
 =?us-ascii?Q?N96NZzT13nVih+EdfBUmLfvoSkqhYMfcuctD1dSWOMEKkIt6xGgMB77JOj73?=
 =?us-ascii?Q?kVyRMX+Sl6/xESa/kPrHskr0H/dy3SbNAKcblTv24ylBBUsQ9kvGABL+1l6t?=
 =?us-ascii?Q?eOWc+i7d6wsNaWZAyvaw5apivA3eiRBKyxBlZfP5eQPNnfXbfNrqu8mgLp1i?=
 =?us-ascii?Q?py8HuY7mLqEYUn3oaVh6giI1t7TEp4A6dKaVcICYXs9RO/2lcAfGh8BzU7k1?=
 =?us-ascii?Q?2KiKrPpksDKC6DfPHHNINnqWIL9KGlfsqJsYJXzO0hcqoUB8LaNZttf3rCG0?=
 =?us-ascii?Q?OptoiHAGFuPu/mqjfSXzARcSVKl/Rg1v2eB3It1UqOa+gEE2vRnAzKfesAMB?=
 =?us-ascii?Q?QTVsslq3u+YO72Wmx84RUaTQcJt7GK8FF3i0eAwKaE0JW6BmLpx9pAbt0pOj?=
 =?us-ascii?Q?QTiJFesiIZGlQahMvJ7WwX8AFbPQpuPm6nzcg/2P4XvHMAJAIL2gDvRaxHid?=
 =?us-ascii?Q?4upxOkaNOhqahg9DlYrZzq6haMU+b3u9cqis3kbU78Xzh7tXL1RKj8LZxzEu?=
 =?us-ascii?Q?5R0SFtgGmX+QStJR+e8Fjjn55TPvhJU6IiJ7tMsQEWTajhZjCGmJ4feZXcxa?=
 =?us-ascii?Q?6RjXZWrRQuADCSOj5rImVmvKHTOinLBDvUqif9gv76vr5LiE5EFzlw/aGdwX?=
 =?us-ascii?Q?HCXb1thjGQDPugEFEjtoz+jyccHjFG2YN/FX5ATCu6FWJ2+LiYGBQJ9org6l?=
 =?us-ascii?Q?tZhvfWBtm+0JJNxPeU6FUPqU4uMed2trlgxU7UaK+zkhuhMQiypMkNPQujG+?=
 =?us-ascii?Q?+yCoDAFoH8qqcVEN8vS2GV0IGgj2SOjaUI0sIMztme/ZKzjZZjh6dpEciUY/?=
 =?us-ascii?Q?mTGhrAJZs+wa6ar56ZXG113wP1ELRmz2BkgFkVdvQtvv+ibSiCKeeII9OSCl?=
 =?us-ascii?Q?qTaCEaZDoe/yuGJPH1fZSQMAcYOljaFNlxcUQgjuHgdsgc3n5jToU8SNVWDl?=
 =?us-ascii?Q?1/r5hstsSr5AGc9vl0aVXsh48PNNgcGR8EGD3fTDiT46yRTuCWFX7ABysx4u?=
 =?us-ascii?Q?o9/WOO9ZIhpp1hn3gC+a9X82mTusHIyrMXleUGzb2jRWUc/FH8JDeMSluOQ1?=
 =?us-ascii?Q?CH/0N/vbd2Ch7yMgWHR7FYVWE6sIskocLa4S91MwoC817AsgMuL9Dlz4nQLZ?=
 =?us-ascii?Q?PP2BIDs+MlMAHtejJYA6f1lQySNsNec=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da5de80-df46-4001-fe43-08de98ce1109
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2026 19:59:55.0826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6UaZsm/ftBCCGZDdaRvcHn2PomSBAIpNWbAk3wKWxn7Z96CDKhFgzXWCBdZ+K+x/5gPbsxVcjk2G6OLJ4G0i03LLenHb7HqZ2AaEjL0l4nw=
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

It doesn't make sense to restrict memdup() to only return char*
pointers, especially when it is already defined to accept void*. This
makes it uglier to use to e.g. duplicate a struct.

Make it return void*, just as kmemdup() does in the kernel (and which
our kmemdup() in fact also does).

While in here, make a small optimization: memcpy() is defined to
return the destination register, so we write this in a way that the
compiler may do a tail call.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 include/linux/string.h | 2 +-
 lib/string.c           | 8 +++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index d943fcce690..9e47fe01c16 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -142,7 +142,7 @@ void *memchr_inv(const void *, int, size_t);
  *	memory is available
  *
  */
-char *memdup(const void *src, size_t len);
+void *memdup(const void *src, size_t len);
 
 unsigned long ustrtoul(const char *cp, char **endp, unsigned int base);
 unsigned long long ustrtoull(const char *cp, char **endp, unsigned int base);
diff --git a/lib/string.c b/lib/string.c
index d56f88d4a84..c2813e0f854 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -667,17 +667,15 @@ void * memscan(void * addr, int c, size_t size)
 }
 #endif
 
-char *memdup(const void *src, size_t len)
+void *memdup(const void *src, size_t len)
 {
-	char *p;
+	void *p;
 
 	p = malloc(len);
 	if (!p)
 		return NULL;
 
-	memcpy(p, src, len);
-
-	return p;
+	return memcpy(p, src, len);
 }
 
 #ifndef __HAVE_ARCH_STRNSTR
-- 
2.53.0

