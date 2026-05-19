Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18D5CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 23:34:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3931284922;
	Wed, 20 May 2026 01:33:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FDYd97Df";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1847F848F3; Wed, 20 May 2026 01:33:08 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE71F848DC
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 01:33:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-4042fe53946so1608787fac.3
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 16:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779233584; x=1779838384; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yeuu92MMfNhhUFPPEfHsnpLpJh+5wWv20tTzYU6Eb64=;
 b=FDYd97DfXfcLBcfCC9YWcCsxy5PZrlu1oBqm577757gd9CdplxPpBiCu+17HrQe0Dn
 Rglhf7yEfwfyQs3VYlTtml0muc8UAE04aw1nH2nexfjIz5edXpu4PTW2oD1Z7+Mg4My3
 x53SfRRJHbP9OI8B4YSqMfYFI5bcnszb4A9e0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779233584; x=1779838384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yeuu92MMfNhhUFPPEfHsnpLpJh+5wWv20tTzYU6Eb64=;
 b=Tb1Qe81UgJ0XSN8HKPJ/3abFezuUc6dIyj6KiTQOy3wsCvOM5PLDVBHlXt1vqS8gHY
 G1ILeCr81/iAWDBskOB6M8otfqikn9czMdpar0ADwC87Mpojg5H/lAECyygc4NXT0TSL
 w0Awe6HdQ2WZH3GjjZo0c9AqYr2Ii1/ZcdBVCS0ku9lVafX1Dp7MC7G5V63237f4Pw01
 PaQj3kM2AkHEMu/uG/K2w6tNWesnXhR8HjRWoRfPmxiFowymuTeX8CqYuTj6o+3ojx8q
 TqnX5zoIrQIPSACvGlpHtx6iOEgYVoVUmjvnGC7ubo9LXptGbzsv1xfhIxxsLZTCwudy
 F1uA==
X-Gm-Message-State: AOJu0YyQpBU0MIsHwSK++jHmmUK33+5Bl5gSpd/rAFV+aBSrJJKHjdZy
 owzPSWU5lXD/ibIa4pSHa0gi8Cs1f55cG7kYyLXUsKQTkW1KblYZzAdSh8ylZB5qgDS87qs4lxP
 GhkvHuCT2
X-Gm-Gg: Acq92OGtrT+5flRBmHQzXFMMnzdrF/7bxnjDUz3StreUzE3dXSUFUMfW+DeCugZJdDA
 Tf2DuSE6ejBJ1e+sGH/QBOMNoDbIIb5f9ynGPJ/SwJAaPpFJrJgl4OyjEdz13POgpP4Jjlxiahd
 TaeLLJEzyh98ettd5e3sFQ0qs/rqDK315DGFKGb2PHRBnipQgIq/bT8NDbzR1dtJ0b3hIzMHRGX
 nzdW+KtT0qre2A8gr93ZzpCXmmxBIzm6p5b4/CeqpTUa+qXhw4N1zBtTS0ayPs4YksdbEkQI22e
 UGh1QSVUonHfkOiFSuTILL1kqCCueaJ5xW8/ST9JDJpgv74pCsJ3Vbn/qIzxpu/YnNKCCIpmFZe
 sQ35kMDTmo+PG1OykkvfWiqLrVqaJdF3THzttihjqso9lpQX4Z/aJXm9FCG4qD+BuyK+J6OxrGR
 60kFXs7DW938rAVBnWbKi+ZEVIk1/n
X-Received: by 2002:a05:6820:1f11:b0:67e:244a:7dd5 with SMTP id
 006d021491bc7-69c9bfd1998mr13334316eaf.51.1779233584636; 
 Tue, 19 May 2026 16:33:04 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d04911744sm7983725eaf.12.2026.05.19.16.33.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 16:33:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [RFC PATCH v2 15/17] lib: getopt: Hoist the arg_index==1 guard
Date: Tue, 19 May 2026 17:31:41 -0600
Message-ID: <20260519233207.2765755-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519233207.2765755-1-sjg@chromium.org>
References: <20260519233207.2765755-1-sjg@chromium.org>
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

The '--' termination test, the non-option bubble loop and the
'out of options' check are all guarded by gs->arg_index == 1: they
make sense only when we are at the start of a fresh argv[] element.
The current code repeats the guard on each one.

Pull the three out under a single 'if (gs->arg_index == 1)' so the
condition is evaluated once per outer-loop iteration. No functional
change; the compiler produces fewer compare-and-branch sequences.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/getopt.c | 55 ++++++++++++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/lib/getopt.c b/lib/getopt.c
index b3ad6968f8d..d2ccefc616e 100644
--- a/lib/getopt.c
+++ b/lib/getopt.c
@@ -44,38 +44,39 @@ int getopt(struct getopt_state *gs, const char *optstring)
 		log_debug("arg_index: %d index: %d nonopts: %d\n",
 			  gs->arg_index, gs->index, gs->nonopts);
 
-		/* `--` indicates the end of options */
-		if (gs->arg_index == 1 && gs->index < argc &&
-		    !strcmp(argv[gs->index], "--")) {
-			gs->index++;
-			return -1;
-		}
-
-		/*
-		 * Permute non-options to the end so we can keep scanning
-		 * for options past them. In '+' mode (POSIX), stop at the
-		 * first non-option instead.
-		 */
-		while (gs->arg_index == 1 &&
-		       gs->index + gs->nonopts < argc) {
+		if (gs->arg_index == 1) {
 			char *cur = argv[gs->index];
-			int i;
 
-			if (*cur == '-')
-				break;
-			if (stop_nonopt)
+			/* `--` indicates the end of options */
+			if (gs->index < argc && !strcmp(cur, "--")) {
+				gs->index++;
+				return -1;
+			}
+
+			/*
+			 * Permute non-options to the end so we can keep
+			 * scanning for options past them. In '+' mode
+			 * (POSIX), stop at the first non-option instead.
+			 */
+			while (gs->index + gs->nonopts < argc) {
+				int i;
+
+				if (*cur == '-')
+					break;
+				if (stop_nonopt)
+					return -1;
+
+				gs->nonopts++;
+				for (i = gs->index; i + 1 < argc; i++)
+					argv[i] = argv[i + 1];
+				argv[argc - 1] = cur;
+				cur = argv[gs->index];
+			}
+
+			if (gs->index + gs->nonopts >= argc)
 				return -1;
-
-			gs->nonopts++;
-			for (i = gs->index; i + 1 < argc; i++)
-				argv[i] = argv[i + 1];
-			argv[argc - 1] = cur;
 		}
 
-		/* Out of options to scan */
-		if (gs->index + gs->nonopts >= argc)
-			return -1;
-
 		/* We have found an option */
 		curopt = argv[gs->index][gs->arg_index];
 		if (curopt)
-- 
2.43.0

