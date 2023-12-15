Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3913C4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 04:21:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F23A87B18;
	Fri, 15 Dec 2023 05:19:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c9UCn8NR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE8C287BA7; Fri, 15 Dec 2023 05:19:43 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A08C87B79
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 05:19:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3b88f2a37deso266225b6e.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 20:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702613978; x=1703218778; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WIbZmCXOZLgmplNmlBvUxOGwDMxnSW80GyhqEZ3rHso=;
 b=c9UCn8NR0YK9F8OhEuFeqYn8nWhrUt1mbj3JgIXyNiTgYrZlrvf1t1LJtN5TrQrl2t
 dXKSOUCfvHIeqxij0iEIkha8Ln03tM4hLcAwlnZar6ZYUkGDRBhC4s14yAyyTJafUSYP
 DUSacwE6UCif+JioRKRVoH2Gj0Rcv2QfCMCOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702613978; x=1703218778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WIbZmCXOZLgmplNmlBvUxOGwDMxnSW80GyhqEZ3rHso=;
 b=wVUNs9d2r4zHQbGDlNBM8tBkeg4JU2CA0ypEehVNuaDRP7vKA9Ne6tYqihALqNzBVs
 ksCaDqLW0KmCuiJOnvGBa2yI6jFLe4RkX8JHONd1E29rSdOHFuxF6rjmMfX0FnqvTjGP
 wcR0/+6VqIj0cEu2Zy6Yfhl1XgYvpCi3j1j4CYQ/Fph4uYIhP2SWOHMdCFnCJP3XdvpQ
 7E255mE4S2Dt3hRkuSgHqcsntpfRaW9DxvHB5GC1zES2gNQ66vFWeDEupXSmgBKPDHmj
 /SP+fE9jndJmVnjQt4REcJZpidfRimSizCFT8AY8yQdL3RmF1V/ab+gP64cc/N8uwqV/
 lNhw==
X-Gm-Message-State: AOJu0YysVRhlzdzsJ9v9Wj1Qhi12siXNxO6f7wWCPD/l+gfBP+AiJE13
 eUN9XYPlEZZEtIXdsezo6npxL1PkzQaHv38I4GHm+Q==
X-Google-Smtp-Source: AGHT+IHAC255qas0YPJkI2+cbSsw/kN0kGBBmLrBUD6RBkmTHljszWNgXUY0zuiRSGkXYP0vfSHNRQ==
X-Received: by 2002:a05:6808:1401:b0:3b8:b063:5053 with SMTP id
 w1-20020a056808140100b003b8b0635053mr14594310oiv.84.1702613978656; 
 Thu, 14 Dec 2023 20:19:38 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 be15-20020a056808218f00b003b898ffd8fcsm3601492oib.50.2023.12.14.20.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 20:19:38 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Marek Vasut <marex@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Edmond <seanedmond@microsoft.com>,
 Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>
Subject: [PATCH v2 13/16] pxe: Move calculation of FDT file into a function
Date: Thu, 14 Dec 2023 21:19:11 -0700
Message-ID: <20231215041919.2197788-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231215041919.2197788-1-sjg@chromium.org>
References: <20231215041919.2197788-1-sjg@chromium.org>
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

This code undertakes a separate task from the main logic of
label_run_boot() so move it into its own function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/pxe_utils.c | 112 +++++++++++++++++++++++++++--------------------
 1 file changed, 64 insertions(+), 48 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index a6aee68bb797..a34f4410e07e 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -469,6 +469,68 @@ skip_overlay:
 }
 #endif
 
+/**
+ * calc_fdt_fname() - Figure out the filename to use for the FDT
+ *
+ * Determine the path to the FDT filename, based on the "fdtfile" environment
+ * variable. Use <soc>-<board>.dtb as a fallback
+ *
+ * @fdtdir: Directory to use for the FDT file
+ * Return: allocated filename (including directory), or NULL if out of memory
+ */
+static char *calc_fdt_fname(const char *fdtdir)
+{
+	char *fdtfile;
+	char *f1, *f2, *f3, *f4, *slash;
+	int len;
+
+	f1 = env_get("fdtfile");
+	if (f1) {
+		f2 = "";
+		f3 = "";
+		f4 = "";
+	} else {
+		/*
+		 * For complex cases where this code doesn't generate the
+		 * correct filename, the board code should set $fdtfile during
+		 * early boot, or the boot scripts should set $fdtfile before
+		 * invoking "pxe" or "sysboot".
+		 */
+		f1 = env_get("soc");
+		f2 = "-";
+		f3 = env_get("board");
+		f4 = ".dtb";
+		if (!f1) {
+			f1 = "";
+			f2 = "";
+		}
+		if (!f3) {
+			f2 = "";
+			f3 = "";
+		}
+	}
+
+	len = strlen(fdtdir);
+	if (!len)
+		slash = "./";
+	else if (fdtdir[len - 1] != '/')
+		slash = "/";
+	else
+		slash = "";
+
+	len = strlen(fdtdir) + strlen(slash) + strlen(f1) + strlen(f2) +
+		strlen(f3) + strlen(f4) + 1;
+	fdtfile = malloc(len);
+	if (!fdtfile) {
+		printf("malloc fail (FDT filename)\n");
+		return NULL;
+	}
+
+	snprintf(fdtfile, len, "%s%s%s%s%s%s", fdtdir, slash, f1, f2, f3, f4);
+
+	return fdtfile;
+}
+
 /**
  * label_run_boot() - Run the correct boot procedure
  *
@@ -525,55 +587,9 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 		if (label->fdt) {
 			fdtfile = label->fdt;
 		} else if (label->fdtdir) {
-			char *f1, *f2, *f3, *f4, *slash;
-			int len;
-
-			f1 = env_get("fdtfile");
-			if (f1) {
-				f2 = "";
-				f3 = "";
-				f4 = "";
-			} else {
-				/*
-				 * For complex cases where this code doesn't
-				 * generate the correct filename, the board
-				 * code should set $fdtfile during early boot,
-				 * or the boot scripts should set $fdtfile
-				 * before invoking "pxe" or "sysboot".
-				 */
-				f1 = env_get("soc");
-				f2 = "-";
-				f3 = env_get("board");
-				f4 = ".dtb";
-				if (!f1) {
-					f1 = "";
-					f2 = "";
-				}
-				if (!f3) {
-					f2 = "";
-					f3 = "";
-				}
-			}
-
-			len = strlen(label->fdtdir);
-			if (!len)
-				slash = "./";
-			else if (label->fdtdir[len - 1] != '/')
-				slash = "/";
-			else
-				slash = "";
-
-			len = strlen(label->fdtdir) + strlen(slash) +
-				strlen(f1) + strlen(f2) + strlen(f3) +
-				strlen(f4) + 1;
-			fdtfilefree = malloc(len);
-			if (!fdtfilefree) {
-				printf("malloc fail (FDT filename)\n");
+			fdtfilefree = calc_fdt_fname(label->fdtdir);
+			if (!fdtfilefree)
 				return -ENOMEM;
-			}
-
-			snprintf(fdtfilefree, len, "%s%s%s%s%s%s",
-				 label->fdtdir, slash, f1, f2, f3, f4);
 			fdtfile = fdtfilefree;
 		}
 
-- 
2.43.0.472.g3155946c3a-goog

