Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA25AC5B552
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 19:46:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EADBA82B95;
	Mon,  9 Jun 2025 21:46:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="3Fipo3LR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12A2082B33; Mon,  9 Jun 2025 21:46:17 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09F1C8007D
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 21:46:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FjofbxM1S2hzP6nZ0Spp4YzVrgPgMNIy7iW6pd1HLIDqrdir2Fc0ufrdnw/uQeqF5QAz21c7/1tMGyUxC12yyvrMxj/dq7Z6Er+ex4ekH13Eo77Hh6+im0Gr5BG2cIAw/zTskouzz+JzQabqGzqPiOe8+IZE+vIsrPqrs9lRvO8702mmq5x1u1eoKMBj37hJ6F9zVFTWhPECgv0htcYn8EHBe4EXQOqhrgReh6pBdIMchw3jL8M1+mXG6GwVueF+6nP7ie/gXlLSGA/LixTzGFmSInUZu0wvNJT3B870Wj70Iio9zDZAm2wDh0wVn6P/3DlcCdGRdsuJNuXLjUCTJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcLGCiwZCRk2wdlBoxQbH2x8d2NLkrlk6mlpqQhcY2E=;
 b=g0M5QiA3bZS6NgC3+fh8G5Zqoxe4tBSRmwr7k6ipa54JzBa9M0fC4Z0n8+I/D3dalkm8e4vzUyys0hBwQoR7UnRezII66ZqN6UPwgJoPyncDLgX3u3YFBSQ3Xvj7lxrXa4AQA/gupXxd5AFDpr4ssiBRxxcwZ1lwsPK3v+xeNJ2nlNommsM4EIf4mOLx/aPVM5QrxDPvX6VNfP9eC0k5/hBI8noO8V+oJVNzjh4gqb5Bhxqo8C6wEtf4iOd0K1w+z1ICp8dgmh1KofXFeyXtu4tCG1IMlzuw/Z8SHrI3Stp1GNp2cbCDl7ueWd4i6Sjo3Ofyhk2kVJDsMMkR4M4Juw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcLGCiwZCRk2wdlBoxQbH2x8d2NLkrlk6mlpqQhcY2E=;
 b=3Fipo3LRRHZswWtI0XGKgnUOe7zYO1ntaWncJUvt62swdmDPdWdE91FQsp9bq8NxECrfgPiBwjY8s1Vxq1OXOXZefe8ArIRdZdUl1Ey8MHi6AL4jKFszXpP3RyszwyNh6LN3pVxNUoQM9ZpXPGEc2meJ57fPSP4Ba0DZQfq4V5aSIYwVq3/7ZUA9t1eoGJPMChdBQUiBo4v4sSaT5jA09YoYRPF3T4ksBIEpcuyb9wuqrPj+lLCu3nB9q4Dxf5hYyyi8Wq3lonUcuLTkunTSp+Glt0vzIw+0yOUrjqhMd0sGGtHpJOTnMxFJmClV3m0g3cx58zRYpdxl+34V10OYyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6047.eurprd08.prod.outlook.com (2603:10a6:102:e3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Mon, 9 Jun
 2025 19:46:11 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Mon, 9 Jun 2025
 19:46:11 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Edwards <cfsworks@gmail.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 3/3] common/spl: improve error handling in spl_fit
Date: Mon,  9 Jun 2025 22:46:01 +0300
Message-ID: <20250609194601.987979-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250609194601.987979-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250609164841.GU1382132@bill-the-cat>
 <20250609194601.987979-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0045.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::18) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: 87412754-e503-4e95-1390-08dda78e4956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3nyzZ8BHEptubs407cdoZ84HNkU6HFne3VkamUMBBMpW2faRMBklqTymsQSv?=
 =?us-ascii?Q?HRUzSCdX7EppNK6xQW6MrNE/A7ZqXQAqCZuPHEihV5hnK5FU9EZefMQQMHGV?=
 =?us-ascii?Q?7aFQINfJhnZtAI1IqkaAsh3B34ZbblBiorZHRSWYMPyIejMjzIfhwi+EZClH?=
 =?us-ascii?Q?+z0NW5Y95tPH8MGz1aGRaqFrqp8ZUlz/my2quW5dVs5t3u9VXkpx/ysMU23j?=
 =?us-ascii?Q?CI/FBG3hckJ1gDsVp1X911IHwKzq/4kJ30u+731CgWlpyUOTK3GO2OblUxxr?=
 =?us-ascii?Q?35ACMzHk7DBsm3T5QIvcjnlIMiRclCzG2tw+6z+xS4fB+5BPbn3FyViuK7cz?=
 =?us-ascii?Q?+PZQVPP/aySgacLxzRWipT86bHfHaiJLF5ELHgOGNqUXztXgHLg9ENZ4j42N?=
 =?us-ascii?Q?i9yPkqFbreC6g5zo+ZM7xczZDaj8/ECJAbnpmCQ3H3bsar4ty48HA+qVWAQ+?=
 =?us-ascii?Q?6Nh4Rkc8zApyd5XLM7fT+HXD4fGNVy/uRFGRYeq33TKUcZYgn6a7hbHs7o12?=
 =?us-ascii?Q?HTPMIj0yXvYQVOxuLtdbzCXkknSOZq9qHpcpgl6GvfZgKx4cY/6gYK77FYZd?=
 =?us-ascii?Q?JQxxNHA9k71qBhznt54/aLFfwGJlpQYkQ0Fl8WG9kaASivLsASSoDJa36TLX?=
 =?us-ascii?Q?Z/GXL0nEapABMHK1ovm7g9D/e/2pdE/exNVyJZCdFhDKtWV+ij6oSSFAXwkU?=
 =?us-ascii?Q?aaNPqspOTozC49oMIt2I63d+DdD6wSDDNFOF33B670dov/wBFVjhS++ikfLF?=
 =?us-ascii?Q?JSLaKZn8sd67Fxy6/hWDPXiQiSUy61jDyuMbpKDN1MKFpvfcZCUgjrs7hUbF?=
 =?us-ascii?Q?CVDf1A4OUhnlqJyIistdQc9Iit5Jt1yENt8kkddbzltCsq+E9ZTUS65vrHyE?=
 =?us-ascii?Q?MaA6aPDB7C6bF5htWWNV/4LbGpUHfqq9GWIk/qJiHgNTimMni0F+F417RhbL?=
 =?us-ascii?Q?/O7Fla4Ti9vwhIkMEBV32Zcvn/mJIB+DuzIGxkSdT3yVKsu3hokT9atNQctf?=
 =?us-ascii?Q?yUa31Nqj11VNqfvQNsps1FEoSTe51Dv6AiEhd8mAjdiYEJflFvnTQm4N52ji?=
 =?us-ascii?Q?z/bKFUQCVSattQ2qY1CI5XcaIbqSn832bBLwD4ORhVWATPKbGvH89iRS2IsW?=
 =?us-ascii?Q?o0L0oIF2Crx+0MmD7iLG5U1u1tmitCQ0fRjntjZ9L+oQKG1nMXbEO28v6RHy?=
 =?us-ascii?Q?yX/Drp4rEnmfAeqR+fSvGs5oXa8WEGx0uCNIkRtZKMkldKcWzlpuCguznaUG?=
 =?us-ascii?Q?enIOhsiAJIwpkYp7nki9jJZO8U7GV8tccmWJsIVCfIOs6veCXqe0+lZ4luTb?=
 =?us-ascii?Q?jWpzXEsbgQfdyS70jc+1KpZepKflnqCRF1wvc/+seeVILlscfdh4Jzo1MFJp?=
 =?us-ascii?Q?vNtV4/AK8C/ILOCqHiYszMxqbH98/NLfGlUQ6dzvPyoJleQR7zEoFn1t9Drw?=
 =?us-ascii?Q?d2IbfODWLXFO7cpekg3QJNNSbbTWPGFwVy7udh+TvxfPZjrGgHgGGA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3MRFYSnS+nvQ9Em6K/40JsBuVjTSkDR8eJpVKEBkGBU26rTT69igrL7uUR/c?=
 =?us-ascii?Q?achT0PkqMuIocY6ADWj5UdOt6IkxYu3FXZzH6nXTIMJJdc3sTiQMwnTrjRPH?=
 =?us-ascii?Q?xIFXdn1V1usjhPO/re27B0YftCb9+nBY8baz+DosOHav12PYPBMxqdPm0ziw?=
 =?us-ascii?Q?sVMxso29OGozclVqGh0lP4eraxuaynk1fO7pPkKydrmzxrYnbxNFXy5DXIFq?=
 =?us-ascii?Q?C5yMxkOY8HFX7gdoNyg7mvzhJ4icasn1IpEXou9/VhiaPa4ZDT3vgAok41aS?=
 =?us-ascii?Q?fwrTwmK4R8ZYoRQNFhkKAXGUlhJ1rcymfFgmjxl/zFefWZhXhPMrX+lOnXM+?=
 =?us-ascii?Q?H3VgWFTIEcSySBCxZlliv+Fw8NNx4a/GcE4jcneHJB145Brzj05belcNp+VZ?=
 =?us-ascii?Q?VICAJGWzJIC5LsygKUUIIQh0hua5n0LEVAM/di/qlyxIKqn8WMcHcmj25I0o?=
 =?us-ascii?Q?McbraR6/SZcIbx88NGrTFgMrfigsUFujiBRQJ3WXbjUsKv4nN2Z3KONlCxtT?=
 =?us-ascii?Q?7KEnNg3lepbAiMPhBXST4l7ttoanvC+5My1m6RzI4kDOmUS4Cl4p5r/xBKTO?=
 =?us-ascii?Q?rwmfDcrCvpcvScpImInfP/bJp63jDr9Y7HMjXkkQHfxUx9ZXllxh57/mPSSb?=
 =?us-ascii?Q?nqXkQvdg8aI9ob8Z5z93FvbOUgVQ5QRp+r13LKBhQ51/StJLzQJ+7RZQloIB?=
 =?us-ascii?Q?BHtctULMMHHETBAgiHn6NQufRNtmNf71tmZYJXXcqYnUQDARMlXKHKghVPiw?=
 =?us-ascii?Q?6ry5M2L7veoztX7J4XuDIxfOPXvlZAMcsCi+50ec0IwLG34WqlZecH2K8DN4?=
 =?us-ascii?Q?/+pcoemXXt0hzRxnMxkOsKmuZ+ayqnFhS3UlNWOtj/0W8n9sWwTf54wBp7VR?=
 =?us-ascii?Q?6KJ1x9s0D/EzPPGriraJusmXrMMPJNJ87r8C1mh1ToaUyXqDpYfo02qN9PSP?=
 =?us-ascii?Q?D2l3h0tD8UyEmA7I0dY3tjint3SwX5yV4w5Hm6p+GH0O0yb3Y+PQwG4mP0XQ?=
 =?us-ascii?Q?yShU6i0hCnFcmcvfoalV8kcfoMaXRrBtsXenDxRYhvdkkoZ2r7Gbxeaz/qfU?=
 =?us-ascii?Q?makMpF7pRx5n6NdqFob53X8xFzxeMc5a7TZ/WzMckl/zPTqdokbv+GVFpv6v?=
 =?us-ascii?Q?ggE7ol1DsxuXzt8cGVDB5wWvYNJDKjGAddvrp20uTbRhQ4rSfXiCCAMmVZkv?=
 =?us-ascii?Q?pQ1RgftuK9c8XX4Fx46+YYPrFD5FGEwOnoHzd+8qPH2/4yl54F2M43Cn6zBh?=
 =?us-ascii?Q?FAypxaW7p5FWDC+I8Ak3KrWq4mHvCSDfsKy29iiQrg1y8uFfpgdDZPd8pUBC?=
 =?us-ascii?Q?m8Hd5nSThzleYxXWa4l+6dpsFwM8cQ8cWOTcLKsaU5rOzcaFsnmjuABeaWD/?=
 =?us-ascii?Q?S8d5uuPdyv3BUoaW/gdNhuR/jqj+6JGV2d7H9LsvrfJGgGfYACsrTk4BwR4i?=
 =?us-ascii?Q?GwWbU4ickk5uQN7t+q7DDqnNp8G+9FV6Cyy/eMm2emDdzbZn2KCrF2To3Mwm?=
 =?us-ascii?Q?doLyJv/2FoGG/oS/D0fp5k47BkkDDPcw5hb0DbNkAolRV8P6weJmMWoX+MWC?=
 =?us-ascii?Q?Ish6YYQJ7yV5tx1cC03aJBP6QLbAGsohD81HeJUJLXR3bPwsp9VGeYf55rho?=
 =?us-ascii?Q?GpCaIwsS/uznVMPcMUSijJM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 87412754-e503-4e95-1390-08dda78e4956
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 19:46:11.5836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0yz3OSuwfKQYhPSfgNfqA50cb/7Bzjv5mtJayCOXdSz0cYdVISdIntZ7UOyDlk6tAtJrbKr+nl4PhV63tTBSoMEvylQBb4FZ6fu4/wnTnbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6047
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
---
 common/spl/spl_fit.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 321954a1547..3a7d753edcf 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -703,13 +703,46 @@ static int spl_simple_fit_read(struct spl_fit_info *ctx,
 	 */
 	size = get_aligned_image_size(info, size, 0);
 	buf = board_spl_fit_buffer_addr(size, size, 1);
+	if (!buf) {
+		/*
+		 * We assume that non of the board will ever use 0x0 as a
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
+		 *   - For normall malloc() -- the memory will be lost!
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

