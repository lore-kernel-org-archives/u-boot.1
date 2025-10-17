Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9B7CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 13:51:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3549783829;
	Fri, 17 Oct 2025 15:51:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="mR8G/tec";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F0CB8382E; Fri, 17 Oct 2025 15:51:46 +0200 (CEST)
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazolkn190100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d406::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E50A083734
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 15:51:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yangshiji66@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XEwFduypKXSNqzGLZPqpUyVVQumGC7hjzuWrYMWsv9+22HiMFp5mPHxEE5cBlS78LF25Zng15X77jX97oheQYtO8Lrja045XWMOwaT3nXpm/qxU67UbKlQSz643DSQ+nG/xFlQpu0N8C8UY4Aqe3fuuTYiu0YWXdocsHUJKposjQgkwefa+l8WgkeqmBORVjFbqlVN8kEJ54IqQYKfZrFw82Tz6lWF+JuPNO3ZY8LfxXKe94ef54VcOKRJY3oaADIIIQ3/xaCw8EGwrH0LK2Bw7Ot3VI2CLGgxsobAx8K6uwN2GnBpc03pLSFnywoIJeIkof4kzcz0cjYOByTT20Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CJ7PUsS73zjDmkq53pYfPxgrZ/j5h9xNQRdNoICJ4k=;
 b=t3mvz74GcL7nT5B+7CNvTnwghoBKgBd8yuBTyE1KCxTNyVwJVQmf7jRZEJ/Jkm61UgIWxqHYkm5GWpiNQ58zKM14Yz+hEpXpHD+xEEZRU7d6zSwtIsSgTaW9htbTnx/DOk6Xcybsby+gjeAhLg3BCMuFAZ3Xycta5SWAUIJ1U1xVijnKM4wGkmrOxWhiaqfTLrqi7Fpdaedq1WJo+ZbSfNeyl0JgszLpx9wwJhl5azN8RaAJuLCMZMnyHeBVQOtyaQBqMrAPpG3/3pKuueFu0A2J9UaKWz+z8ltB4Izg91EgkR7zLvwSS8xaT2Qa60X8j1MLjpdHkSiUkC3QMbr3Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CJ7PUsS73zjDmkq53pYfPxgrZ/j5h9xNQRdNoICJ4k=;
 b=mR8G/tec5p7/PlRTQHRP6OKQRaqF682crSSaIXmSsd4sqP2ZxjBT4K258EZ9EFrRRezUA7Rh3PkwT1ePdFenqBWh2ueTwZgCMk55zsWy69PVkwBD49my6n3N2+cGeyXozm7RCJmf8xQxKGmhJWS3GHwdCJJqTbKve6aUvpHNAXRnH7rYlAivCaJ0miW2RjTI8wodYXmcYUlW8LPiW9uaWMtYRLvSIIXN0lZhwTLPeVuPbdIOxdZpX4dgFJA2IwBeW9uS6e44DXxqDpKDF2WPPvimErw3ax+0DtarvgmgmB2zqoX+L9ExHYVsgkHdZSR9fGG0X+fWzzpiVcN16x3oAg==
Received: from TY3PR01MB9998.jpnprd01.prod.outlook.com (2603:1096:400:1dd::7)
 by TY6PR01MB17463.jpnprd01.prod.outlook.com (2603:1096:405:35d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Fri, 17 Oct
 2025 13:51:40 +0000
Received: from TY3PR01MB9998.jpnprd01.prod.outlook.com
 ([fe80::69e0:e6db:5571:3ef8]) by TY3PR01MB9998.jpnprd01.prod.outlook.com
 ([fe80::69e0:e6db:5571:3ef8%6]) with mapi id 15.20.9253.005; Fri, 17 Oct 2025
 13:51:40 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Simon Glass <sjg@chromium.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH] mtd: add missing prototype for mtd_read_oob_bf()
Date: Fri, 17 Oct 2025 21:51:03 +0800
Message-ID: <TY3PR01MB99984611F9932D25552A33B6BCF6A@TY3PR01MB9998.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To TY3PR01MB9998.jpnprd01.prod.outlook.com
 (2603:1096:400:1dd::7)
X-Microsoft-Original-Message-ID: <20251017135103.4890-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB9998:EE_|TY6PR01MB17463:EE_
X-MS-Office365-Filtering-Correlation-Id: f287053d-2b0b-4eec-9184-08de0d844bdb
X-MS-Exchange-SLBlob-MailProps: 9IecXKUgicBJ8NNsyPoVvrHIv5xlNgd3e7ycHKOlVQGHyYuVKG/Xi9Ln+vxSUtNtbZLinw3OIjzSN4gaIg5G0G+KxoFjGnoWZyyB7rwN3CFTzQFGF9evKp6XTUQ3x06LJ8wgh4A2JskYNxv26ADbBskXTZw/rndf7zHClNnBzs7mV2kLY64EeE3fM4TvC/j7yxd3gaHQUn4hkkopwnVuH7vjqpjYmerlyn+Prf6xK9ND8Qt/ZdhDYOJcouzmtqmYkZQQSkf7H7Rd5915RSHTWiP/2v3v5Ac2Ln3PI7qxeBj79y9a63jIyY0ZbDgPJsW23tIYNdoyUSTB1ewrbNvn20aK7c8SltnY1r9e9QT6JOvSlt03Wp41RfLlile95y3mLm8Wsa03tatrO2R5x0g0nTQD2ohKJ1fXM/kkgxmo1I3zoouGAvLfWsrNLE4EWMxKITwRLq4eFoEqroB4gVY5tBCLiGjbMEdZ6/MJRQK/2Qq9Z0BA2+2tfeqenQAzoe5GaO0hbJUS4DmS629ksQgmk9Kjya75TvTDLfBN5aOVOo9+jIlKlMuK2LmbSSNWklTQ/Y//y13KajRYp1xNftcMLIgrH+NsG/Ok/i7i7qxuYQzAJMQ+VXlVyYkeZslXY/POHYLxjM05/9f4tXL/ZPwV59g7wnrqR5tydL+GnVxvHlp1BgzQdYSu0GTni9zRy2MN9FIBGFAoUYEJ5SQVD+t2PGNMHFZhklH03i0xvkUeQe/Z/kRuCTnlKg==
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|23021999003|5062599005|8060799015|19110799012|5072599009|21061999006|15080799012|53005399003|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jfiEvcPWYlnd3gJU1wsjYLcqmC5KQA+WKJQMrylFyUbxR2oRpOISFWsnXnXE?=
 =?us-ascii?Q?HD0BjdyH9N+zL7ql1h1cB/yxIh7gbOyRJrQgduh46NKVW2u1NqwfRwonSSs1?=
 =?us-ascii?Q?OOQ9TGFRzcbHjCpyvOD0h4lDak0BfzBxsahnvLZk7QeGhBpNibe2AG9YAvTF?=
 =?us-ascii?Q?pAzGcGschbE8PjXVEc/3IS+BB3Y2yCzy5l/mgrzLF1S1VxJuUx/vPoOfRH71?=
 =?us-ascii?Q?ZYSufixjde2St6jUdo5ET7N3Dh3pNZ0Em1R2ojT2PWCnazSIz0iDjHe+KtQR?=
 =?us-ascii?Q?U1wIjuMk+HdJr5PO1mxRsR0EfytZ1FmpvuW2YEUP1dDdHDRki6VjDmUM+UOm?=
 =?us-ascii?Q?LVkkTvFmKRf43uzcmbW3nvAR1mTfFrObH4LwPZuz9vx8TGP45MjkLT5x1igT?=
 =?us-ascii?Q?xmwuVkADSMLQSRYI39CKXY1xxfv8AXehmF6t2SELWuSHZBjNgQ9WQ+XZXUaq?=
 =?us-ascii?Q?DHLPg8xZ9zr/eYnjWdEqgDcHNR3OUhdGvGLaIxYM3QPZvakjT0nNs2KxrJ0F?=
 =?us-ascii?Q?klfc8M6xLUtI/EdvGM8MprKDk6ds4g9hxUhNz5YhMPBHxSVZWcFCo+C2pt09?=
 =?us-ascii?Q?06Bl9/qq1QPfAT4P9sAhvFYF/SOtHc3EtIHkXkKtZ32HwVE2Qq43eIxhgVMb?=
 =?us-ascii?Q?8mDcVBH9xuAv7E37d5a4mFydazdmE4i0GlzEjuw/x2PzfVOfOID66QLwxHfU?=
 =?us-ascii?Q?cTkBJQWJz72IGYxoj4DnzuBo0jcByC4UKGU3ZoInZtnMp5r01UsmjsV+VFiP?=
 =?us-ascii?Q?McABQL5vU8iopaMbX5RLg1OO6NmHuz43cGErbZ4xzrArp4epiXa5Fxlq6Qaq?=
 =?us-ascii?Q?e7vtOGrX02ltHXUNycBvXqNuhounm4hOpGHPaYzNDcirlSbpefVBZ/SDV/Kz?=
 =?us-ascii?Q?28DCfH0vIVorXBRuOEulFeuiTGL/BYJ0ZzHv5r9uBeG7TopSis6asP486jE8?=
 =?us-ascii?Q?boFKKl2TB2dG/UOjC0ZihQdhz+jSafPt7lB4v/I91IJa6BnNcECISILzUqkG?=
 =?us-ascii?Q?CudJgS/CwdWu2wf/EteuzD4xcEGWBNwoeJ8bl6T0NrNI49vb4sDGAEDgvWdV?=
 =?us-ascii?Q?JxtaTa+dxQ9wUC9oNGOThCHUK4IgT4brcf0YTygD6Lf2MHM0kKZxbZ+Ckj4E?=
 =?us-ascii?Q?aB3kUmQ5Jo7Q1gy5qY0EhqSapeHO4jpct/n7qeG/JQ0nkXf1sIxhQiTrIrwR?=
 =?us-ascii?Q?wiZFNdzYLVP8/pQKZeUC+VKU+nXVyn+EVu3b7d32Sq6pm4yYf5G5aYfRr8t2?=
 =?us-ascii?Q?DPtdpvSmo5aKmMiH0aa3r8qUea0IkiLujKLIWLH/+g=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KExYGVwGjj97YgX11w7WfXQnppXZm/N9uAHJP8PIYN7IzQQMnoZwk0nWAxhC?=
 =?us-ascii?Q?BH5hc76MuCwXSneaodb0DV0htFe0unWFNTSatSVQkYtt13i1loGyYrAaXFgf?=
 =?us-ascii?Q?s1scj3kPN9ATTt/K6zNqwHEytQJ7ex4Cp0U9UuT1OMjfb5JQZOQ5eTpEGG0H?=
 =?us-ascii?Q?/+HzWuqTJcWxbV2eZtg234SZmQg0kgCczS3WOTiEipCPLGGzYqit7p9IE8CB?=
 =?us-ascii?Q?7wU0vfWiJsjGgjaN8r8QNRjuvMyhxFByHqQn8tFrA32UDYrnF/4S2yP/t8YH?=
 =?us-ascii?Q?Vdj0GLTJG5H6lmDVC7k6p7TqUEFJ//7fNkDgdY8lnme3+Rohk9N0KfygZQDz?=
 =?us-ascii?Q?hG0Mvtakv4t8e0uKgjtPPqePAZc5GvQ/o8kNSNfFtoTd48LivYFyHiNkmHn0?=
 =?us-ascii?Q?ZZT/JBpvIUWSc20k2nkmT/iKnBOciOGCjJAgUckllKUzN5fWTW+6UlZhX3zF?=
 =?us-ascii?Q?+TGoL30dx651Udd5ojp7kkLO8t7ghQoR6ImHG48jDPCATUEweOW6znjZYnmO?=
 =?us-ascii?Q?m1YT7C+alMVjdkTIdnCflBmZc9Gbt+f8/7Db5ILZXnAsLQcdOC2JRaYiTQW5?=
 =?us-ascii?Q?e6Oy6zNoel4QGOg0CGItijY1Lz7N5QoLTO5ijVWo2WoDsYhvBWCEcpILkOmX?=
 =?us-ascii?Q?gipreZmRcgSBhOMHm4O8bN0Hwdn/VNilQo8LWI+x6v+w7k+aE+pMQrGB7Ee2?=
 =?us-ascii?Q?djikJdz29vmFsspelpKwj9YxSGLeLTbkh+xamoo0DAz/vRqt8o3roG3rtwcC?=
 =?us-ascii?Q?6hQHoPty9IJxWDXmSANUeUIC0esM6DFFcH2lOl8SrvMwZ/hYzXY4LLY6Zn3M?=
 =?us-ascii?Q?Aj2oDGXOnRP1MgIVT2fEeSLuNjy5+PuUHycbWdx33Upmw8VFEe+QhxHabsI2?=
 =?us-ascii?Q?TTlSMQgB7n/tt43Sj4qlSHoS/RhSmIc9ZzCSNN7nEPxiG5ySpZl8nx+AsT8C?=
 =?us-ascii?Q?kmgi+Fguu/KrF0FIKmj3kLF1gzcv6jk5wA1QCgzY6LdrLcWDhsou8E8WSrnG?=
 =?us-ascii?Q?zb/vBxJdv95iTJfq8nfpUulbKBU2QE/aCrHrkLCvMkd4809Z3kPAP82aQJed?=
 =?us-ascii?Q?7xia9bcaE8rbPsMHUO97YaF/5sJDtbS4Z2fTd4qvmKEOF0fKhyT/v61a9Ym1?=
 =?us-ascii?Q?sjZ+m/OQ5p4NUHG/+XJBJFOAfKhjmTPtHHIqyqIjWpPvrPtuOZf+iKrZZltX?=
 =?us-ascii?Q?t8K4bar7I7KIvqRTyHIZ/yh15fjmC2/lEBzagERnySBb+9S+Gbhsxz2MjMjF?=
 =?us-ascii?Q?ttO+0peDgmi199h8kOrr?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f287053d-2b0b-4eec-9184-08de0d844bdb
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB9998.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 13:51:39.6602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6PR01MB17463
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

This patch fixes the following build error:

cmd/nand.c: In function 'nand_watch_bf':
cmd/nand.c:248:23: error: implicit declaration of function 'mtd_read_oob_bf'; did you mean 'mtd_read_oob'? [-Wimplicit-function-declaration]
  248 |                 ret = mtd_read_oob_bf(mtd, addr, &ops);
      |                       ^~~~~~~~~~~~~~~
      |                       mtd_read_oob

Fixes: 1fac57720719 ("nand: Add a watch command")
Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 include/linux/mtd/mtd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 3ffcd40807d..1f97bc4fe11 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -438,6 +438,7 @@ static inline int mtd_bind(struct udevice *dev, struct mtd_info **mtd)
 #endif
 
 int mtd_read_oob(struct mtd_info *mtd, loff_t from, struct mtd_oob_ops *ops);
+int mtd_read_oob_bf(struct mtd_info *mtd, loff_t from, struct mtd_oob_ops *ops);
 int mtd_write_oob(struct mtd_info *mtd, loff_t to, struct mtd_oob_ops *ops);
 
 int mtd_get_fact_prot_info(struct mtd_info *mtd, size_t len, size_t *retlen,
-- 
2.50.0

