Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF6CCD54B5
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 11:37:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D687686B3F;
	Tue, 19 Sep 2023 13:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="hlY/CLPn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 243EC807BC; Tue, 19 Sep 2023 13:37:19 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on070c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::70c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50C3486AE8
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 13:37:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1bDcfefacZgmak40Ug+FXUq4VLmycymH2YZPXbx9u0A80KAS6xxd8a9AvLoPkPBuvTQuPZ5o/zopiaU/NyySFt2HY5WJ45AsNUxGMeDU9lcJCicc4gBwRQFPYpd1n7F194lTUVBbqGaMQrBZZ3y1kTYQu4CfMQL3UWhISIATVGf7dWJXdZciqdtGHk7WQztudTKUVBnW+yF9wdWx+xeYQtd/Cu1TtgY4gHokutU80Qxh09yEQpwp6ZmyCizRem72e3BOXSODy86X3/zLK/oobEJuUGsfuk7VL3vK63BYNlrvBUO1/L8NpW6Pk+kXnk33coVHgDYgDiYSPe027UOtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXlk1FeHUZN9NGeBsaOEOTVbGLYfRu4NhN+uSmfCtD8=;
 b=cF23xpiS0SoWnanI50IIoDAjqfagUCKaLDP/P+cp2VW6lfCZ+NJ5YrzXrcnYMVfvN6gku2KdH+UhcTe0m0BTtBs9mv+AhKhVUd1BYfDjoehBLJf4lauOdbcMYpmsr/y+4ZFueLyefMYI/NU2U+k8gwyEjIPKom21Cj+RAPNDLM8ZtcIdnVqs1eislK7fhcUwqwnoLc86ugUo/rJ45BkjeTD6UJa0tldmKmfUwJtUCHIZVVTqMbrdIHp7KupuFKdDqXrGJ4HgyKZycij/lyFWhEIUw5WQjW2LBqJwHG8w5MinqBqz9iZ3pU6fCZ3rZM/2PmhnAipq4O7nnICoTkCjEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXlk1FeHUZN9NGeBsaOEOTVbGLYfRu4NhN+uSmfCtD8=;
 b=hlY/CLPnfc3gsTKUxyO0BPbnhz2IzFcFgG4K3d+tYYcQ7SMOJpfYK/vhLNaem915LyNOnuB4v3GnLuWujCrjhZjYDgBFJfBEAUss5xH+WXZ8DTfPbBnUH9EYt9zC8Ozlyh5vowdBq+TXilFR8+TniIXaWCzVaGlctWe787KTcqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AM0PR10MB3683.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 11:37:15 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 11:37:15 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 1/4] mkimage: also honour -B even without external data
Date: Tue, 19 Sep 2023 13:37:02 +0200
Message-Id: <20230919113705.109639-2-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
References: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0074.eurprd04.prod.outlook.com
 (2603:10a6:208:be::15) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AM0PR10MB3683:EE_
X-MS-Office365-Filtering-Correlation-Id: 8de19e29-e499-4541-0d1a-08dbb904c5e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dag6+DMQZ0cn9T4mM1xtc0z2BEVp2X3s/StkzUxZel5bKWnVNVhevhaymgPSGCbPhuCLmQ/pjKUTYWWoKZLicj2wFfkzwt6+WBzrpb/LSRtMlrV5ij0HsyN9YajQDTepAs2Qeww4juIuKUzIGRhPPxg7TT+ckW//exZ+pedxsdJ76eSwgiErgXsA80tvj1VSIvDbJxmaghPb7lqf4GzZDwd8Mtp2m0Z9XaeQSPw6rmZ241U8UalC2oWWAibp6o5/l3sZpVAafZzii6VY9fbYmqNjUIx57ua7L4rWPZutnA6Q82WS3kF5zTgg99PGP1N+rIWkkl9JF+RWW0VCoLp2z0jv1Tbk594/kFa1UJIuwHcCFaoviKO+tAyNmHKdWh5MAtsjgvXQgp4ia1/uy9j8kbm6gspf2Fg4G/DyJEL9QYAuD3bpfeHoeAlkwyIsIN4SXKHvJLYXHoHSYrXVQ89fOUqI6pxR97aOw4Rkbo21KX0GmCXKL0GVxxiBSGFSHur2UpkAAk6p3axlI17P/vUKGpnCpHb5pQPvSV8ZT37qyazb5CwZHWMnY+gLLeId1epY+3zLXTdxOK+HUt6wjXiG2/568e/dKaMUIHaexzms9fXhZhnjEokV5/ZiAdCV2d5i
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(39850400004)(136003)(366004)(186009)(1800799009)(451199024)(2906002)(5660300002)(83380400001)(6512007)(107886003)(26005)(1076003)(2616005)(41300700001)(316002)(6916009)(66476007)(54906003)(8936002)(8676002)(66556008)(4326008)(44832011)(66946007)(6486002)(8976002)(6666004)(52116002)(478600001)(6506007)(86362001)(36756003)(38100700002)(38350700002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g73oyui43lz3q3cts6h1eH6th0tXew9InBECnbflXQwvnjIILwECRZZDDvKV?=
 =?us-ascii?Q?PJjqIn3G7PlKEX8PwuaTSyio0uAOc/j976Rpc4gY2nRQN9GI9XGZccPEYQme?=
 =?us-ascii?Q?8n9tyA0Jrx4Ey3X39Mw/UR8+2nm/lLfFVf5Mel+Lf71ir/h4gmPPxa9/Cuh6?=
 =?us-ascii?Q?ZuQnvdLR8jocknxhiTc5uXKNa1j0YuyC/gIrtY1PKmOUoWK6iRrhCUaoB7dh?=
 =?us-ascii?Q?vh1kgGBGUJx8wMWGwWPH+9LC68kgkCKv2kiosvQVJX8rlORRc7nBDGsMclJu?=
 =?us-ascii?Q?YE/7/hyH/PFjVCP3CMt2kxl5YjAk25OFEfC/Vmxb8e/HgxufaWVxd0HSLwAT?=
 =?us-ascii?Q?hwc5pNdDMba2sUtpLSsXwBdLbyiQUbTsCsR3KNOJptcgzCuSwCtPXCSSNKTN?=
 =?us-ascii?Q?uCGyDMDIM4CecH38ITdVqDLSXyB58EprgfkzUI5hAIP93kMK1qchRdtSRe9/?=
 =?us-ascii?Q?rTgvYmLe7DkFQVZ8/FrptYBC63FdHzcjg+G9j6vMiJK0QaWJhYE3opkQ4rjC?=
 =?us-ascii?Q?Z2rR9sKmSp0QapHN3EdcR7bH02y2fNFYKUHARHllJ+KBKoCB/Tia+v2aLY5P?=
 =?us-ascii?Q?pd4lFcjOWyvj3Cl6qjOQjCFhPM76AYhmQwhWHG8RLIl9ajbk6YqUjb8vM/qy?=
 =?us-ascii?Q?LP6+cHck5PoC7sbocg5zfxtvnTmZmbq4QEmlcFX35XAoLO9D2povg6WEJJbM?=
 =?us-ascii?Q?Z/aOWYm4fscNPqpzQ/ehZeA3cgw+3DqvnAtWK4vOwg4neW8aUWwQJnwgja2C?=
 =?us-ascii?Q?MoCKDKvY321TtvevA5POKGCdOjVadwv+69x/edkrXzPDIJbM1WWSJxZCOguv?=
 =?us-ascii?Q?tHlXya+2jlYHPAMjpSBXDbtuHDK91HB6XnvsmFbP7Qy06nNNipEnmYM7oC7O?=
 =?us-ascii?Q?QuVzQC5WPSrmF/jawXhAszMAodYQ36VJFA7ZBI0T3t8yfzxNWog33X9C6MQS?=
 =?us-ascii?Q?oAtBJriwSS/1V2xfn5y4Wxqm8L/iMjp46QqRADy2/VKBHUpb9tuQsXV6MrFf?=
 =?us-ascii?Q?CS2SwAPQZkqCY1Po9UmNJB6gNuv+566ZQVWXlxvhujPEwQErw1vaw6N8iYIr?=
 =?us-ascii?Q?zMMKhxHoX5dukarBKu73VR2gVdDYP7UJmwWazhFuOddMhaJ0B6EMdxBnsuf2?=
 =?us-ascii?Q?XC9MKn3YrgLkOmPyYhs5o76h9CIGFPUGOZPyC5HAvIV/XRra44JKZ6dfMt7o?=
 =?us-ascii?Q?RCsO5M32N2KtHu4IerFRR/uKA4N//9Q3wbppCUSwj1tRO2fD0i5g0vdMkoYG?=
 =?us-ascii?Q?v41oAk0OcBx3CAIKit+fosnC3bM/GbxDzVcUe6LW7Ysjz90o0eJz0cYeA3FU?=
 =?us-ascii?Q?nXj9vsWzntadHVODUu8EOby+thzurZpmqwZNdWDcT0GQrMKVDBSWcAX4RLDH?=
 =?us-ascii?Q?s/2AqUs/o59bNPOETm5+madIbHB2+Ub6GsY8WEDRJUSHHc+m+wl6jKQ82DnO?=
 =?us-ascii?Q?wyOh2g45gEO5ashv8bCp/d08GkLzClNdLNZUIdy+k7Pv31KD0gJ7jOdW3P6P?=
 =?us-ascii?Q?KfhRfW8YQS4N1r/RgGU6U9aQMrcvFmnle1McMa8QRlGMukbvz1NXTJtZW70l?=
 =?us-ascii?Q?6DepMlWGq98E0oeBitXQ40a08qhDV2/Hh0GeHi9fdWpHIXOb2PXhGrOOlmEZ?=
 =?us-ascii?Q?ww=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de19e29-e499-4541-0d1a-08dbb904c5e6
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 11:37:15.5416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OcMJMDn8XawDlBqk+wRk0paUdRpIXLiKCXmgOVT7A4wLPaVbGUnYBevZYZmEOiZbUsIJGmbAucKV3vYbcyFcW6Tajp6AmxEmKyx9sqiNz1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3683
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

In some cases, using the "external data" feature is impossible or
undesirable, but one may still want (or need) the FIT image to have a
certain alignment. Also, given the current 'mkimage -h' output,

  -B => align size in hex for FIT structure and header

it is quite unexpected for -B to be effectively ignored without -E.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 tools/fit_image.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index 9fe69ea0d9..2f5b25098a 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -712,6 +712,42 @@ err:
 	return ret;
 }
 
+/**
+ * fit_align() - Ensure FIT image has certain alignment
+ *
+ * This takes a normal FIT file (with embedded data) and increases its
+ * size so that it is a multiple of params->bl_len.
+ */
+static int fit_align(struct image_tool_params *params, const char *fname)
+{
+	int fit_size, new_size;
+	int fd;
+	struct stat sbuf;
+	void *fdt;
+	int ret = 0;
+	int align_size;
+
+	align_size = params->bl_len;
+	fd = mmap_fdt(params->cmdname, fname, 0, &fdt, &sbuf, false, false);
+	if (fd < 0)
+		return -EIO;
+
+	fit_size = fdt_totalsize(fdt);
+	new_size = ALIGN(fit_size, align_size);
+	fdt_set_totalsize(fdt, new_size);
+	debug("Size extended from from %x to %x\n", fit_size, new_size);
+	munmap(fdt, sbuf.st_size);
+
+	if (ftruncate(fd, new_size)) {
+		debug("%s: Failed to truncate file: %s\n", __func__,
+		      strerror(errno));
+		ret = -EIO;
+	}
+
+	close(fd);
+	return ret;
+}
+
 /**
  * fit_handle_file - main FIT file processing function
  *
@@ -817,6 +853,10 @@ static int fit_handle_file(struct image_tool_params *params)
 		ret = fit_extract_data(params, tmpfile);
 		if (ret)
 			goto err_system;
+	} else if (params->bl_len) {
+		ret = fit_align(params, tmpfile);
+		if (ret)
+			goto err_system;
 	}
 
 	if (rename (tmpfile, params->imagefile) == -1) {
-- 
2.37.2

