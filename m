Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D58BE77166
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:48:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1CC1896A5;
	Wed,  4 Dec 2024 00:46:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AZJu6+r6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F24F589686; Wed,  4 Dec 2024 00:46:47 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFA1D896A5
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:46:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-841837213b1so430335239f.1
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269604; x=1733874404; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ze9Dvt2bKqftKJfhqMb0dV2ed/94BZjckOFVhk80tm4=;
 b=AZJu6+r6W+SqnaiEWj3AlAyAJqlXKcYOo9fs4FCPqzA6s+/CBY3n5WSs19hN2wl2n4
 rf5uh3gs0ECEgj4jJ0/mAluXWgGDj6cbKUQQrsQFANENTX+NCJD4JaJ0ZRnZNPR+EXyr
 aUjG9v89EgRi7cHUKhMYbWbaUNow7Ekc70xss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269604; x=1733874404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ze9Dvt2bKqftKJfhqMb0dV2ed/94BZjckOFVhk80tm4=;
 b=nSYJ4Uf9o1GIB7/d6WP7xDL3eBECL1rSXvqREngAXnXw/rUGzDbMWEFpu6CZFKMF4M
 ksmi3CbsI2vJLHfbKCx0nDwufyT1FJ/9qlYZcs9Rs6n+57k20jHHaF7+3M3vkfmEkLza
 6WbGWy8NDeZ76H/flFWUp8+7ZZuqm2Gv8hg4gaBJfh8SKQMw2sAYt1YSvS3dW1lGiGZE
 NqaRUpRA35SpWF/v+o/mY0ugk0u5ufuLeBk5E8BqbRpeeNje3CQVRsYoWfLsD3sl13Ua
 hDijSkZq7EgvNeYhnA3Km7VmAljZjWiYZTd6f/qNuhPnveP8/YIk2OqOHgZACUKnk5jp
 +wlg==
X-Gm-Message-State: AOJu0YxjTTMoOSjkMKQiwN6FkDZGiAXUROF7MxmF6iaMHFLwbQvPHs7K
 oX228akqPI0Q1z/ZFGxthGXDnOtP1jeyHGXbJjAVYw81KyjUUeRvhrFImNYw702Gjt85nfBNeDw
 =
X-Gm-Gg: ASbGncsAru9mz+bBDm/5lE56EvNt5oKv4+/M/+A6xnaLjUuI5SRCbu6xtdfC0sxAg5K
 I2+jeOLjlCd7dnThA9JiaypaX8tFH7KKszH0rGIQRA980hKDaHDUs9EdU7Okx1+05FIQ+hlTGrW
 /eypxf1Pb5KN/FdrKyKBVdPvPSZyANeFW1UxQ+ljwsOWDVn9BXA5yrxp4+Y0xyOIz9DnKdoRiCm
 ZPL87BABCV03neUaXeJ4AWlZCfLOAOb3Bo1puM+tm+N9U1yQd4wjwYrRSgSz4/r2LGvTMzdzh2P
 swOKey+dnvg=
X-Google-Smtp-Source: AGHT+IF9rQSPR9zYpe2eXG4cqntBsrqSiZOv7fYW13B7053GMg79RnMqr5ksTqWt8tOOXKED6a8ZNw==
X-Received: by 2002:a05:6602:2b84:b0:83a:872f:4b98 with SMTP id
 ca18e2360f4ac-8446293c43cmr303042339f.2.1733269604008; 
 Tue, 03 Dec 2024 15:46:44 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.46.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:46:42 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v2 12/41] boot: Pass just the FDT argument to
 label_process_fdt()
Date: Tue,  3 Dec 2024 16:45:30 -0700
Message-Id: <20241203234559.2938192-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203234559.2938192-1-sjg@chromium.org>
References: <20241203234559.2938192-1-sjg@chromium.org>
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

Since this function only adjusts one element of the bootm command, pass
just that. This will make it easier to refactor things to remove the
bootm command.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v1)

 boot/pxe_utils.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index a14b4eb54c2..2ada5c4aaac 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -438,7 +438,7 @@ skip_overlay:
  * @ctx: PXE context
  * @label: Label to process
  * @kernel_addr: String containing kernel address
- * @bootm_argv: bootm arguments to fill in (this only adjusts @bootm_argv[3])
+ * @fdt_argp: bootm argument to fill in, for FDT
  * Return: 0 if OK, -ENOMEM if out of memory, -ENOENT if FDT file could not be
  *	loaded
  *
@@ -461,13 +461,13 @@ skip_overlay:
  * Scenario 4: fdt blob is not available.
  */
 static int label_process_fdt(struct pxe_context *ctx, struct pxe_label *label,
-			     char *kernel_addr, char *bootm_argv[])
+			     char *kernel_addr, char **fdt_argp)
 {
 	/* For FIT, the label can be identical to kernel one */
 	if (label->fdt && !strcmp(label->kernel_label, label->fdt)) {
-		bootm_argv[3] = kernel_addr;
+		*fdt_argp = kernel_addr;
 	/* if fdt label is defined then get fdt from server */
-	} else if (bootm_argv[3]) {
+	} else if (*fdt_argp) {
 		char *fdtfile = NULL;
 		char *fdtfilefree = NULL;
 
@@ -538,7 +538,7 @@ static int label_process_fdt(struct pxe_context *ctx, struct pxe_label *label,
 
 			free(fdtfilefree);
 			if (err < 0) {
-				bootm_argv[3] = NULL;
+				*fdt_argp = NULL;
 
 				if (label->fdt) {
 					printf("Skipping %s for failure retrieving FDT\n",
@@ -560,7 +560,7 @@ static int label_process_fdt(struct pxe_context *ctx, struct pxe_label *label,
 				label_boot_fdtoverlay(ctx, label);
 #endif
 		} else {
-			bootm_argv[3] = NULL;
+			*fdt_argp = NULL;
 		}
 	}
 
@@ -594,7 +594,7 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 
 	bootm_argv[3] = env_get("fdt_addr_r");
 
-	ret = label_process_fdt(ctx, label, kernel_addr, bootm_argv);
+	ret = label_process_fdt(ctx, label, kernel_addr, &bootm_argv[3]);
 	if (ret)
 		return ret;
 
-- 
2.34.1

