Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95187C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 17 Dec 2023 16:37:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B4FF87CAD;
	Sun, 17 Dec 2023 17:36:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Av55ueTL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B51EF87C98; Sun, 17 Dec 2023 17:36:40 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47B3487C8E
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 17:36:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7b6fa79b547so212062539f.1
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 08:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702830996; x=1703435796; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aSji9lga/g86N/zZmNG8LEajSIT+V1z8OlioLjNnseo=;
 b=Av55ueTLdwbB56wwOGocvsxIgJdZIBjdeXY8Eo49qgca8T0B8EG9JtsfDXirM66Ae4
 KjwmQUamJKEZRkpoNN6+Vw3YlxUKcYZkvsJA9JhwovQ+lklxhhL3iBko4VPSg0vjbYcy
 QOGq1PO56HKed5slqwUVf2cf3Nmw8T2nvBmMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702830996; x=1703435796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aSji9lga/g86N/zZmNG8LEajSIT+V1z8OlioLjNnseo=;
 b=FGZ6U8vN9l/yEydtErnnbJerOdd3mRI3T85LN68JrT8pOioRfzyVuyJzVK25p+dGAH
 kXkrKJ98ftnCuMta0XNM6AopOx6J3YJ1CfLkH/z1S1z0Xrslk/XOtVlH2sxx9QUPWl3m
 1DVmWlBIHuXuZBesPQEnHd9QqNk9prsPH8nVnUlV65Sxp5w1Jtd/e/TcsDTJzTGSAa2R
 sUr/VTOYLTyfXf7/iNv2+utTryHC4mE3Ld+24DQ2cgTcntSlZGUvxXPJv4rvH+aJcYCU
 75eXdmvUEggMj3+sDAX5ORLf61Yr19Kjy7HO0rvS6P14CiR7KBF7kN+whKajj5NFtfoW
 dHsg==
X-Gm-Message-State: AOJu0YwCXivA5hGszrUQGB24LpYeOHyDhjHKvxDNrsa5YYShWjIbxFZ6
 Kgpa9swaSDJ8xd9icR7n0x6fRgQcoJ6mEGFzRozexw==
X-Google-Smtp-Source: AGHT+IF1pSU1xd1ezbSVY0mQLy8SjmILvv5TJj/gs+o6YbBOFInZf5PJcveWjkVkt0lPNiiXqk5YSg==
X-Received: by 2002:a05:6602:328c:b0:7b7:c3c0:c7a8 with SMTP id
 d12-20020a056602328c00b007b7c3c0c7a8mr3057352ioz.13.1702830995794; 
 Sun, 17 Dec 2023 08:36:35 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 ei10-20020a05663829aa00b00466917fbfc4sm4925770jab.71.2023.12.17.08.36.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 08:36:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 02/10] fdtgrep: Tidy up a few type warnings and comments
Date: Sun, 17 Dec 2023 09:36:15 -0700
Message-ID: <20231217163627.2339802-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231217163627.2339802-1-sjg@chromium.org>
References: <20231217163627.2339802-1-sjg@chromium.org>
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

Align the code with the upstream version at fdt-tools which had a few
tweaks before being applied.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/fdtgrep.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/fdtgrep.c b/tools/fdtgrep.c
index 7eabcab4399d..f5493aaed3d8 100644
--- a/tools/fdtgrep.c
+++ b/tools/fdtgrep.c
@@ -375,8 +375,9 @@ static int display_fdt_by_regions(struct display_info *disp, const void *blob,
 		const char *str;
 		int str_base = fdt_off_dt_strings(blob);
 
-		for (offset = 0; offset < fdt_size_dt_strings(blob);
-				offset += strlen(str) + 1) {
+		for (offset = 0;
+		     offset < (int)fdt_size_dt_strings(blob);
+		     offset += strlen(str) + 1) {
 			str = fdt_string(blob, offset);
 			int len = strlen(str) + 1;
 			int show;
@@ -431,7 +432,7 @@ static int dump_fdt_regions(struct display_info *disp, const void *blob,
 {
 	struct fdt_header *fdt;
 	int size, struct_start;
-	int ptr;
+	unsigned int ptr;
 	int i;
 
 	/* Set up a basic header (even if we don't actually write it) */
@@ -683,10 +684,10 @@ static int fdtgrep_find_regions(const void *fdt,
 			return new_count;
 		} else if (new_count <= max_regions) {
 			/*
-			* The alias regions will now be at the end of the list.
-			* Sort the regions by offset to get things into the
-			* right order
-			*/
+			 * The alias regions will now be at the end of the list.
+			 * Sort the regions by offset to get things into the
+			 * right order
+			 */
 			count = new_count;
 			qsort(region, count, sizeof(struct fdt_region),
 			      h_cmp_region);
@@ -880,7 +881,7 @@ static int do_fdtgrep(struct display_info *disp, const char *filename)
 			size = fdt_totalsize(fdt);
 		}
 
-		if (size != fwrite(fdt, 1, size, disp->fout)) {
+		if ((size_t)size != fwrite(fdt, 1, size, disp->fout)) {
 			fprintf(stderr, "Write failure, %d bytes\n", size);
 			free(fdt);
 			ret = 1;
@@ -934,7 +935,7 @@ static const char usage_synopsis[] =
 static const char usage_short_opts[] =
 		"haAc:b:C:defg:G:HIlLmn:N:o:O:p:P:rRsStTv"
 		USAGE_COMMON_SHORT_OPTS;
-static struct option const usage_long_opts[] = {
+static const struct option usage_long_opts[] = {
 	{"show-address",	no_argument, NULL, 'a'},
 	{"colour",		no_argument, NULL, 'A'},
 	{"include-node-with-prop", a_argument, NULL, 'b'},
-- 
2.43.0.472.g3155946c3a-goog

