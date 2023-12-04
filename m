Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BFAC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:37:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34FD3878F7;
	Mon,  4 Dec 2023 01:33:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iMcKDMKN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1FAF878E5; Mon,  4 Dec 2023 01:33:13 +0100 (CET)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B65E5878F3
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:33:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6ce3534bf44so764737b3a.1
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649989; x=1702254789; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NmMfwlaZtRapICHWeuQEbPfBMBaFiOiIwa3hk84Hhvw=;
 b=iMcKDMKNjNkg4QfUcrMISAYNqbQL7qDYynmzPUiaIBBH1LfsqwFfxxHqPf54vgoBl0
 EsSYlOSwATYrqQ3AVWTJm2OAUKzaoZkCypBqvu5MoN7K714oDY23pNPZMnUTALG57Od+
 RJY9iehXiz7V0a76bLVP/9DgH79E2lnBQUFcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649989; x=1702254789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NmMfwlaZtRapICHWeuQEbPfBMBaFiOiIwa3hk84Hhvw=;
 b=RitKE0SFcPqMWwea1xct1iFXNHGoOkkIe4UiYD4dUmR090ByABn6E17/WTCZvLJE1h
 4tQMBUwNBQxKJ0zwQAP/T1Hv0EcGr04oaFuisDIr+9ENckrYWa6VUo93bHr/SVaHi2Hy
 jVuRU6ZZ3/IUUWAVMEKMR0ogXb4rSyikKjWt6ucUt7Ubfjl23iWwEGk2vp3KiykZHDLw
 Ydl4RraFm21aWXBrNkS12h+iAnOaFP0w3CCMbEkRgjjrBH2ujJKDyEOOghhAL2K8wfyw
 gtsP4fdU+gOSW+TqFsEp6TU7vAtHR/jhGIsTjXxXr5txw347IAHtASPoROiaLgtK3QW/
 a8hA==
X-Gm-Message-State: AOJu0Yz/oNNXIIYLl0lHKdbFVYZ2z0cRcoRC1pvUMScgH5WI3tockvzQ
 NW42LJgqPxVso9NPp+EQL3b06n+r6W56YggJc1mrNw==
X-Google-Smtp-Source: AGHT+IEDvR9W5kO07lNIu9nVOjA2lFPIJusYSMf8AEAFR6XDzK4EcGEcOBGehCPnlJiTfcKQK2gIzg==
X-Received: by 2002:a05:6a21:78a3:b0:18c:3ea9:b85d with SMTP id
 bf35-20020a056a2178a300b0018c3ea9b85dmr3998965pzc.11.1701649989008; 
 Sun, 03 Dec 2023 16:33:09 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 x13-20020aa79a4d000000b006cb9f436232sm6337525pfj.114.2023.12.03.16.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:33:08 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Manuel Traut <manuel.traut@mt.com>, Marek Vasut <marex@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peter Hoyes <peter.hoyes@arm.com>
Subject: [PATCH 11/14] pxe: Move calculation of FDT file into a function
Date: Sun,  3 Dec 2023 17:31:35 -0700
Message-ID: <20231204003144.899097-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204003144.899097-1-sjg@chromium.org>
References: <20231204003144.899097-1-sjg@chromium.org>
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
2.43.0.rc2.451.g8631bc7472-goog

