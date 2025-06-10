Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E86C5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 09:57:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F360782B70;
	Tue, 10 Jun 2025 11:56:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="tB0VRzkO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 678658070C; Tue, 10 Jun 2025 11:56:50 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6719F82B33
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 11:56:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHaAXbzN/dWIc1ynX5LpyBvOxPP2tlMsL77tu7mu4+CeSHH21AKbhA5buPndzKwmc0t4IXhVwbMzNGfSGAPfHCXMQGH9QnDVYTSTRxG+0XOusdk2pPYCLlg6uENqAj5T03NvClolwuOwl1JkdlsKrPnKjZBCv0JVIAWJHlXxayDOSlOL3HxuXFpMsTkc4QDTyM25r5pW/5IkTo8EXbFtbdQ/X625pGzA7WRta2aFNz3RPX4WB7yg93kBRYx79ElXktjDLLol5Rp0ugyb2wm6h7zYltUk93XX6c0xAxgywj2XXmm/075ujXDZJmXRIANoAc4J+QHUwIRVdDzaDRkJRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUfHkK8HlO/O6OceAKmSzcx6QbCc6qZI/kC8/ncT18U=;
 b=KEe2/2jUi5Gci5uy6QmQD8Xih+N9eSM1wC9/9JmGDsjfq+UOP2ct2EXoHP1Jz6napvT8m1/RLryuFxj39xqe0o30Ca+tS4KgaAJpb4S9kSBYnvSweh7RBY4TkZgH4DyTsQg6O1cLA/iL66WRSGEdZ6LB3kOH8sLqhygwlRDKObTWvcZOwKP89F/JTNgK+Clf08BTa0WLUK+6gsOdsmlr0xf56C2Cns5gV2GkU1kdMj5CM4bg3aaNLidFs4xJZMlWKCUW3rw0Z4MIGKsOuJrJRZQmIxpzHeq3i30KdMMPZs7mEDRNaKw+e0RBIKYpdMuF6B3xBDTwaCu0Org0sMUXvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUfHkK8HlO/O6OceAKmSzcx6QbCc6qZI/kC8/ncT18U=;
 b=tB0VRzkOcVSY9+FfE33pKKA4UfIlFFQj/n0jjbPhvolQzDRoac0tYNBN7c8h0tta4zCVEbDw0BV6LPXTtzowIhGG/mj++uKeLaSii1q1Faug6MH4uFBxy/fEHqEoFEDGZd0dS6tqCP6PWLwUBwanRe7kgfcj1V+WYEm5dKEsXdsK1mR6jgMhqPRTdjQ6h6Xfd0aa1dk+4gASwp9qqBGGALWSEMk7Xw/6SfJLKL+Nwzpe6VbOXaOlsOySrPMMrDW7dEMDek1B77Hi2iW0GWSUF5uZITkHTyvg0QibTBzO9AP4FltDTG+c3rOW3zTy8HGT2Lqle2Kr+9vNbURKkfjbzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GVXPR08MB11183.eurprd08.prod.outlook.com (2603:10a6:150:1fc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Tue, 10 Jun
 2025 09:56:44 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Tue, 10 Jun 2025
 09:56:43 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Edwards <cfsworks@gmail.com>,
 Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 3/3] common/spl: improve error handling in spl_fit
Date: Tue, 10 Jun 2025 12:56:32 +0300
Message-ID: <20250610095632.1085431-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250610095632.1085431-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250610045054.1038235-1-mikhail.kshevetskiy@iopsys.eu>
 <20250610095632.1085431-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0010.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:272::9) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GVXPR08MB11183:EE_
X-MS-Office365-Filtering-Correlation-Id: 22372a80-73ef-459e-0833-08dda8051a58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aQUOBGsJU6JELtAlxiWATObYzMrQfSrj1DqSF/eyhMSMuKERbimjmyBW5n2l?=
 =?us-ascii?Q?C6XJma+3etSFTtm+prpNNvCKxV5hWmsK75CG7i/D4DbBGvhn0POKAxXdHu7L?=
 =?us-ascii?Q?fxwvq2x98opJsGF0wjbAYP0rxrf9U5od8bvJJ9M9EW0Ne6m/yOSwHQhwXWON?=
 =?us-ascii?Q?lv1NueogLRAqaaaINtR1pCWY0v4MV0GArnwBPLz7H+fX/U5QATyRc5JG/af+?=
 =?us-ascii?Q?1BRiSqAnhgKMKPad/ee0WfT63Gs9B1va++aTeoh2X5NT0gwBzGQ3MI+Rbf4G?=
 =?us-ascii?Q?Yuy5bM2XxXCZCDRZUM00IEeRtjMSHkM/Q/MpqtSs+pYT/KWF38XOQHTC9pXS?=
 =?us-ascii?Q?lfmNscpx2lMP+bdwa9EqL3wn90xiC9Mqz5Bq+nPNjMGeqbV+UFfcRn4wV3Dq?=
 =?us-ascii?Q?3ItDZHfnEov5Zv0pyA/3Bw94ZyNpBvca2Mfx319g7mOQg4UxoO/hQYx5YECZ?=
 =?us-ascii?Q?Oc0hHc05kL5RZn3tyCnCb/nWVCgXLzXIrnj+Z/UQV5OI/MPhTdbhadqLKV2J?=
 =?us-ascii?Q?U0V6a0p1sXg7kXsObU1tpGuVF/tgo3kyE9CM6VZYFpNeowa/XlYRCp4sbppt?=
 =?us-ascii?Q?71+EfOWhH6OaAV9jM8rG0HK2pyFctc9pWrfFPqSo1LUbJwblmsYg5r7lB0ds?=
 =?us-ascii?Q?NrnWv8xUGeeFNBNTmnoV9RhA+UhFPUk1h1Dkg1SStg0qtBsy0U2N49jOJ1aK?=
 =?us-ascii?Q?j/K/X0YLOIWYiQMg3Y6dO8wosHZMuJIoXi1dgbsqu0IQSvlkfYrn2bk1sH5J?=
 =?us-ascii?Q?wdXZALLeGksneZKJR0DjGtY1tVn5SgUsZzkJynmcHrz72wjdBg/++C3SjH8o?=
 =?us-ascii?Q?kEya8ZJxaiW446P/micH76/LS/uEp8XEnVu6yRLEaEwbCmtbbqXEUwyIQr24?=
 =?us-ascii?Q?xjxn3kZzNiLwiqqQUazWkhOk/+Y9GI+/eC5gSj3O+8vXMN7+hbDWEVSq7/tN?=
 =?us-ascii?Q?Yem53MkqFZ4p/rTZjG00gm6jQxPje20anFyZWCD6unB6LL2n6Ob9kOR+wwV4?=
 =?us-ascii?Q?JTmfPoOdNcOpElYn6kxXXtkgf7u81789jUC6aF2CDHlcigsMFgvDbqWCnHf7?=
 =?us-ascii?Q?LVBf8qzHJ48+/zPwRhIMWRovji6G9fQ0K+1Ashsvmcudabmtr9GkLzPAnFUs?=
 =?us-ascii?Q?+Q0AQONillXzAgdsWYMi2gtkgmTJd/hz4dZoRKm3zlDVJUrNZA9F0KXFrJ0B?=
 =?us-ascii?Q?kLgHy1bDvPOjpJ/zT0gFkC764jttGk4Wwq2mkNt8JaKWFlSnkeoXvIxhHx5d?=
 =?us-ascii?Q?Eh6jJdOiMspH589xRJtcZ+rHlfYrioMGRitVFZRLWsqPirNWg6VkhMWwUE02?=
 =?us-ascii?Q?I9EW7WPw5whgjEG1GlIpXxU4TNgkajgg+22Az9KyWlqK3nBT5mNH/J9/FAS/?=
 =?us-ascii?Q?uN4N34ssplfk2XjEqlzlqoFkunnKcvGykp2Rvz7VqerKnVG8gD+1Re0kmD9E?=
 =?us-ascii?Q?ddcUXJ6eFL9146arq50Z9/+lz5dp3PWpFwgO8X83dj8PAdGZcLLZEQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SWUWClmjnVzBhq2NICDoRj8N0+gfwhdrFyk1bhoAlVFCELUCKtAyg6lAfl/2?=
 =?us-ascii?Q?plzRASzhLmQPwgWE9ApS5HA8VKqL0pjDG9D44p1hmf2AgJfFCXBPataFaWmp?=
 =?us-ascii?Q?da5fFLLqjp0kOWfGAN8RPn/s4rrazVv3cYWnXqmT4qESg34VNv/ZVS+b7sIu?=
 =?us-ascii?Q?bcNUVAthLB3MBCLwrSgNBKC1mElYJyXpiEGxZxOew+tNbLiPtRm4TYLTTsXu?=
 =?us-ascii?Q?Yk/EF/6eQPBwSy8njC9b4DYzwndTHONhTORXA7c9voh7jBxL0RxRIdG1KUlP?=
 =?us-ascii?Q?z5pQr3a3X6qGyyqwYJbE270RUlPuveD4R7wYDBuB2vaS23r2RK/4V0gxaJuy?=
 =?us-ascii?Q?Ehcd8AiUWgOE7aTTS2xlA6Qqcn52+r2jq0awlveabVYQdAdogWa4781N2ZAi?=
 =?us-ascii?Q?+J/VwPcT+waAol26JmKQOy4B6WrjF0ugo6zzia4q1PqLMpDyS4WdV9sU1Ypj?=
 =?us-ascii?Q?2M/phIDuC8krvEgaXMdq6lPHvAXf0RFM2yN++kTwaQk5k5Wzajv1kh62tPJw?=
 =?us-ascii?Q?9dCLTCDRzIE2/ITMLG7smdjjfMQNfC9FwOWg6IQqCTunbo1G0+v0Fd+blDgh?=
 =?us-ascii?Q?9Lg6bZAAJ6KAFjmpFKmQEIcn1N2d8CnY797DHb1R1oWphB1ZWKpM/id5p84S?=
 =?us-ascii?Q?BdLKQGAhewDwHlXs+8Ynhy4BWTthW6x5m9PauioE7a6W+GqB4/AFpnrBDKOf?=
 =?us-ascii?Q?XyhtwCzOUFJq7Sw+Emobk0Y+cIml6rQkSVtudTJ7Aul1EnPhj/BkjXTKXTCC?=
 =?us-ascii?Q?CMW9DYLhK+KhRpEfDQvsJepl1TfEdoxbaFbYzV8MDY7UX+sLRKWNNCHrzBzc?=
 =?us-ascii?Q?p4rDeoUX2jiJuQ1v8AK2vmQcbZKxeQmqlXO4rEdH9n9T4eg/aJ13R8o+Httu?=
 =?us-ascii?Q?WLR9hY4ydqhjfyedyKKsXDW/tBpihZsl3rt2Jvz6w120ZlArYBSyciBPTqL0?=
 =?us-ascii?Q?dQxjZPF22MC6I/O4PTc/HKFScUBUG4zeOqedTYDkrCH0zoiZ7nS4k4O9B1Iz?=
 =?us-ascii?Q?8bLS7AdOQ0B5EbWk9Tmh37qiC8Z+GXerlvuphQM5ZeB5eRnviJbqpUzuCAtl?=
 =?us-ascii?Q?a37934paZ8ulsi/E9wET+s4sXkNR0z9vieZTzHHa3r/dMOB6AyJIUSCPcF+A?=
 =?us-ascii?Q?BPoXpPpOc1f+o24WhdfKey050DhqoIVNR/m3Otf/vJano4YS5Hm0eHIyAOsT?=
 =?us-ascii?Q?Eyohs+IjjeOQ18R0OuscYEByhaejunFM5+BKuxC5u0NX4kKAIlWGqlsRkbB5?=
 =?us-ascii?Q?yb4qO++BCvKI+1Z7tdtVEtIzzXjmw36SAHCfYCwZLmaCwWvQ0p73VDPeGo+W?=
 =?us-ascii?Q?yh9K9tu046UdDXZ7n/pMNnz98ciCWjGJX0gEYFl/TOQwAJjfitBAwE+TcPb7?=
 =?us-ascii?Q?Jgcw3HOj3f82uLUp4GVddVMTURrDZmtdPpVV31pNtof8NOlmBlYSe3TC8Kqu?=
 =?us-ascii?Q?zp1zTAYrKnOnP0PMUmHBvIj8g+SxWINtZN1Y4YhP2TyQL2knwyN+ZgcMnACi?=
 =?us-ascii?Q?TGf7XxRSQ9WNFVBl0yQqT6atvTCWPyXlIWaDv/6Z3BsAYCf13qaULFnO1als?=
 =?us-ascii?Q?IfyI1N2ILUouGhyka/tCmXncxu2d0wFv5HmFjyS0brpJpyTwInMuZclx1v5Q?=
 =?us-ascii?Q?rnjBcE71lYWeK7dlTS5VnbA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 22372a80-73ef-459e-0833-08dda8051a58
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 09:56:42.8953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NyPLVRssPGrjw060magxbaErHePlgfqZsgAy69QgEsdkplnMS7y0g5c23c6Imf/mbUjAAzwaUM0vhoLQszq9++k7Owp1ZKld1CNynK7mKLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11183
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

This fix a possible NULL pointer dereference.

There is also a risk of memory leaking within the same portion of code.
The leak will happen if loaded image is bad or damaged. In this case
u-boot-spl will try booting from the other available media. Unfortunately
resources allocated for previous boot media will NOT be freed.

We can't fix that issue as the memory allocation mechanism used here
is unknown. It can be different kinds of malloc() or something else.

To somewhat reduce memory consumption, one can try to reuse previously
allocated memory as it's done in board_spl_fit_buffer_addr() from
test/image/spl_load.c.

The corresponding comment was put to the code as well.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/spl_fit.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 321954a1547..b3824af475f 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -703,13 +703,51 @@ static int spl_simple_fit_read(struct spl_fit_info *ctx,
 	 */
 	size = get_aligned_image_size(info, size, 0);
 	buf = board_spl_fit_buffer_addr(size, size, 1);
+	if (!buf) {
+		/*
+		 * We assume that none of the board will ever use 0x0 as a
+		 * valid load address. Theoretically some board could use it,
+		 * but this is extremely unlikely.
+		 */
+		return -EIO;
+	}
 
 	count = info->read(info, offset, size, buf);
+	if (!count) {
+		/*
+		 * FIT could not be read. This means we should free the
+		 * memory allocated by board_spl_fit_buffer_addr().
+		 * Unfortunately, we don't know what memory allocation
+		 * mechanism was used:
+		 *   - For the SPL_SYS_MALLOC_SIMPLE case nothing could
+		 *     be done. The memory just could not be freed.
+		 *   - For statically allocated memory buffer we can try
+		 *     to reuse previously allocated memory (example:
+		 *     board_spl_fit_buffer_addr() function from the
+		 *     file test/image/spl_load.c).
+		 *   - For normall malloc() -- memory leak can't be easily
+		 *     avoided. To somehow reduce memory consumption the
+		 *     next calls of board_spl_fit_buffer_addr() could
+		 *     reallocate previously allocated buffer and use
+		 *     them again. This is somethat similar to the approach
+		 *     used for statically allocated buffer.
+		 *
+		 * Please note:
+		 *   - FIT images with data placed outside of the FIT
+		 *     structure will cause small memory leak (several
+		 *     kilobytes),
+		 *   - FIT images with data placed inside to the FIT
+		 *     structure may cause huge memory leak (up to
+		 *     several megabytes). Do NOT use such images!
+		 */
+		return -EIO;
+	}
+
 	ctx->fit = buf;
 	debug("fit read offset %lx, size=%lu, dst=%p, count=%lu\n",
 	      offset, size, buf, count);
 
-	return (count == 0) ? -EIO : 0;
+	return 0;
 }
 
 static int spl_simple_fit_parse(struct spl_fit_info *ctx)
-- 
2.47.2

