Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DE2F94CBB
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 02:31:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 571F883936;
	Wed, 22 Apr 2026 04:31:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L9al/XU3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACA91840D8; Wed, 22 Apr 2026 04:31:42 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B95F8352B
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 04:31:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-50e63771d91so28776481cf.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 19:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776825099; x=1777429899; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=72V43/6I50FrMbUfeORs6+trlQRH06niP+WrFi6EYgw=;
 b=L9al/XU38Zo+OmIQhTzNC/MgFdQ4NhAr6r8mEJhT56e+5zmbcfJdzj6mGNGI+l0VbK
 5q/uwvvCRtGIgpo5aK7j+Z76XBJV8aJ6hK7BXuqfrN7UOnh05+nxeZ0r8YbrAbhuADpo
 z2jzHheF9XW5Y4Ys7QGCMkoKEQYYPyNWgkNpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776825099; x=1777429899;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=72V43/6I50FrMbUfeORs6+trlQRH06niP+WrFi6EYgw=;
 b=AgSkJ2iKP76/P06N0yBMKy9++LrtA1RElMyDtBI+F5eHLeSrAiJQBuEky4UQ0wUo12
 rfvR43BFA9E7lXlPcIOPWg3tXRU8RORemdmWmbhF48VI9Tzwt8il20fzfxTqW8B7Sy58
 2Miu7ZRCPvKPVnprH62SLUNa5Xith3bW8Kwu+79axVp7PbmvIaecASEkrgzzm9djPB1I
 hKhyAsfAMDgrF8+/A8+SbZQo+kYIwSWsYuYPUk02hORYvOPdQOfutAJlpsLeBoq2ltmn
 5bjMMu1GNvbYtnh+u7oL8rqsufuTS1D9EGPeQ6VVkN2o27GI9iIjKfN164l6axuoGwJQ
 oM3Q==
X-Gm-Message-State: AOJu0Yye205KYIPnfOvHmzpzFnxq3FKmNSsfGjN8iMeesr7KTqpBdcjH
 SOOFCQ9vwGK9DRSIPVbejPOUep1+rEbyrWozOtcyLlFa7uPiLzwCpdfDB2Ula4zyUVmymHugiSR
 EIYaIpQ==
X-Gm-Gg: AeBDievuYKt7HsL8WX+WVhsJMWlLunjJp4n6lwoY2U+YNRTTvmQjJRZT15wRZ53cPis
 X3q1prmJc8Kp1uX1hVUorPloMbcf7/kHBoI9uPKqmfuND9TAKabW1j14wAbAJVmjHGYesKjbupe
 uEh4UIY328douyr8EVi+xGnsXRqsuZYNh3XYUJCbvA8i/1KZIkb1ny6ZkLMG6/rKbTeqvru2C/L
 B/oNPILe5VHncHW/1cGdwzDoFi5aD+/aTJCoFYszwohpJRL3jhb2Wb6meYU/J4g3Oz/c/A8KFyo
 gjOBki6uHH3GjqnW+C8QPCs6lcoOUDsqB/zkI0wyZl3q00lMX0RiURiI2qqEL5p06fOJn1KIPgo
 Ha0X/7s21upHPU/SYfDEptNUPMdY7MRo/4KoKmNSDsribpAehbyOMPVqUPEvcMB0JrvZCcbTbpS
 GQOIrtHLQ9Db+7/bQVn/izc7V6mvKn
X-Received: by 2002:a05:622a:1f99:b0:509:23ee:b9a5 with SMTP id
 d75a77b69052e-50e368372e2mr310893001cf.5.1776825098608; 
 Tue, 21 Apr 2026 19:31:38 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e39495192sm126614081cf.27.2026.04.21.19.31.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 19:31:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut@mailbox.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] fdtgrep: Add option to reserve free space in the output FDT
Date: Tue, 21 Apr 2026 20:31:23 -0600
Message-ID: <20260422023131.2813748-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

When producing a DTB from fdtgrep, there is no way to reserve extra
space so that more nodes/properties can be added at runtime without
growing totalsize first.

Add a -B/--pad option that appends a caller-specified number of free
bytes after the strings section and grows totalsize accordingly. The
padding is applied after fdt_pack(), so it is not reclaimed when -r is
used.

Suggested-by: Marek Vasut <marek.vasut@mailbox.org>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/btool/fdtgrep.py |  3 ++-
 tools/fdtgrep.c               | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/tools/binman/btool/fdtgrep.py b/tools/binman/btool/fdtgrep.py
index 446b2f4144b..7b393241878 100644
--- a/tools/binman/btool/fdtgrep.py
+++ b/tools/binman/btool/fdtgrep.py
@@ -16,9 +16,10 @@ Output formats are:
 	dtb - device tree blob (sets -Hmt automatically)
 	bin - device tree fragment (may not be a valid .dtb)
 
-Options: -[haAc:b:C:defg:G:HIlLmn:N:o:O:p:P:rRsStTvhV]
+Options: -[haAB:c:b:C:defg:G:HIlLmn:N:o:O:p:P:rRsStTvhV]
   -a, --show-address                 Display address
   -A, --colour                       Show all nodes/tags, colour those that match
+  -B, --pad <arg>                    Append free space to the output FDT, for later growth
   -b, --include-node-with-prop <arg> Include contains containing property
   -c, --include-compat <arg>         Compatible nodes to include in grep
   -C, --exclude-compat <arg>         Compatible nodes to exclude in grep
diff --git a/tools/fdtgrep.c b/tools/fdtgrep.c
index b4c041070f5..83e3d0b9314 100644
--- a/tools/fdtgrep.c
+++ b/tools/fdtgrep.c
@@ -64,6 +64,7 @@ struct display_info {
 	int types_exc;		/* Mask of types that we exclude (FDT_IS...) */
 	int invert;		/* Invert polarity of match */
 	int props_up;		/* Imply properties up to supernodes */
+	int pad;		/* Free bytes to append after the strings section */
 	struct value_node *value_head;	/* List of values to match */
 	const char *output_fname;	/* Output filename */
 	FILE *fout;		/* File to write dts/dtb output */
@@ -913,6 +914,27 @@ static int do_fdtgrep(struct display_info *disp, const char *filename)
 			size = fdt_totalsize(fdt);
 		}
 
+		if (disp->pad) {
+			int new_size = fdt_totalsize(fdt) + disp->pad;
+			void *new_fdt = realloc(fdt, new_size);
+
+			if (!new_fdt) {
+				fprintf(stderr, "Out_of_memory\n");
+				ret = -1;
+				goto err;
+			}
+			fdt = new_fdt;
+			ret = fdt_open_into(fdt, fdt, new_size);
+			if (ret < 0) {
+				fprintf(stderr,
+					"Failed to expand FDT: %s\n",
+					fdt_strerror(ret));
+				goto err;
+			}
+			memset((char *)fdt + size, '\0', new_size - size);
+			size = new_size;
+		}
+
 		if ((size_t)size != fwrite(fdt, 1, size, disp->fout)) {
 			fprintf(stderr, "Write failure, %d bytes\n", size);
 			free(fdt);
@@ -965,11 +987,12 @@ static const char usage_synopsis[] =
 	case '?': usage("unknown option");
 
 static const char usage_short_opts[] =
-		"haAc:b:C:defg:G:HIlLmn:N:o:O:p:P:rRsStTuv"
+		"haAB:c:b:C:defg:G:HIlLmn:N:o:O:p:P:rRsStTuv"
 		USAGE_COMMON_SHORT_OPTS;
 static const struct option usage_long_opts[] = {
 	{"show-address",	no_argument, NULL, 'a'},
 	{"colour",		no_argument, NULL, 'A'},
+	{"pad",			a_argument, NULL, 'B'},
 	{"include-node-with-prop", a_argument, NULL, 'b'},
 	{"include-compat",	a_argument, NULL, 'c'},
 	{"exclude-compat",	a_argument, NULL, 'C'},
@@ -1002,6 +1025,7 @@ static const struct option usage_long_opts[] = {
 static const char * const usage_opts_help[] = {
 	"Display address",
 	"Show all nodes/tags, colour those that match",
+	"Append free space to the output FDT, for later growth",
 	"Include contains containing property",
 	"Compatible nodes to include in grep",
 	"Compatible nodes to exclude in grep",
@@ -1132,6 +1156,11 @@ static void scan_args(struct display_info *disp, int argc, char *argv[])
 		case 'A':
 			disp->all = 1;
 			break;
+		case 'B':
+			disp->pad = atoi(optarg);
+			if (disp->pad < 0)
+				usage("Padding must be non-negative");
+			break;
 		case 'b':
 			type = FDT_NODE_HAS_PROP;
 			break;
---
base-commit: 052988aa29bfd506d7ce207fbb3f5374a5dbecbb
branch: fdtgrep

-- 
2.43.0

