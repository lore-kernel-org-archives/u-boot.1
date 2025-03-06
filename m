Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB0DC282EC
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 00:29:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A5ED81782;
	Thu,  6 Mar 2025 01:27:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ESfGD2TZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2773B8164E; Thu,  6 Mar 2025 01:27:01 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8CCD80E94
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 01:26:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-855184b6473so7591139f.2
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 16:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741220816; x=1741825616; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O47n6fwpzQuNDca3EQzRK+0K6Gb/JL+fBkYRzRUdMME=;
 b=ESfGD2TZH/TL3YtXU4h9Ykkh7Dz4Yi4VW4RvwjO9tAubLrSstQki/7XzwTyCdAcK7/
 cvRpp78jFJE0EtZ4k0VYGwqTcbP6DINEUiX1uz9ZwuTVMJ8FRZkoNyLYGo+YrHxNH3HF
 fXaOX+7FRsFtFo52YfDfag7NTN4UKX7e3l1Jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741220816; x=1741825616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O47n6fwpzQuNDca3EQzRK+0K6Gb/JL+fBkYRzRUdMME=;
 b=h5N9xsC5Ra4nWu6mwqHvU6TY/eNIjEiWTvYr7SKpAe2J/3J4dNWQDgBf6BKm7zbTki
 DqVVteoTbBRoPOkz5PuuY533kOTi1/fgpuwpnVloLp3V/LOZN3TKeqpZgZGqbjX8Bpww
 VEc2lRFgdS4xWxVVSxmxUVO38dogiZJGg3GT9QN3GXxbMTqWB+dmJcbZlg2pK+0O2oe2
 XbcZwPY43iA6/U0amIso97WqomNkLVSP2Ya37bx/3S4l6zJpNiFr6vKaelfSRowfHWen
 yXSrzwmPYzUDHRzncE4K2Mlt7ZULvUVqedrd4RJ3RntfVTUO+P4+SK3YQzqlkUWXBQZ5
 N8Ew==
X-Gm-Message-State: AOJu0Ywj06/cSADgMbwdiVGRhY4RwEH3jF6cLtTjF+X148WDlZjXuL4E
 wg9AeVl2+KZV4p8/jkgyxoChnLg5jM0+/3mUhNqgkuUDb9wnI6Kr3FVzgYUUNHcNVPEh0EaEXhk
 =
X-Gm-Gg: ASbGncu5GL9aPcHG8LtIgre9QkIMw5SJYMENV0n39JLkw9cuVvnuTdL3tEjPyIpnxyz
 YlL9+y+R7UWaYmkZdF633ImKS6peGWMVVQ4T7gKSLlSBlqfFBA5+8KNe/PGzUYCtVDHm+817fWw
 Ez0GVQ+xNJHhzSAV3E7VQ4xfeBgGhwR2z+7oMpHgXZDgUt4gpPFzWGOIxYhB7N+E0vRiCArvdY7
 +KtJqr+8Fd39Cg9PynkU8x+nSQyFyYosN3q+YfrRVvjVTYKQbstxYlhluxDAxVMxqatbmTs09b7
 +kibrxnEInVNyt7xbg2pxplIck3A/NrVXosNMNJdPdIphOMrtRAuIuP9ORjnodghS8SJNj2mfs4
 lqT18eQ==
X-Google-Smtp-Source: AGHT+IFRLuNkLcit4v/D7wQ59tSfOUsJRaN9JB2e7aPsrAxm6fRhbIzE/wb3rHaeXtNgpU5pf7P/OQ==
X-Received: by 2002:a05:6602:3a82:b0:85a:ee90:5d8b with SMTP id
 ca18e2360f4ac-85affb4f7bdmr632092539f.8.1741220816512; 
 Wed, 05 Mar 2025 16:26:56 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85b11986869sm1106239f.1.2025.03.05.16.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 16:26:55 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>
Subject: [PATCH v5 12/29] boot: Pass just the FDT argument to
 label_process_fdt()
Date: Wed,  5 Mar 2025 17:25:06 -0700
Message-ID: <20250306002533.2380866-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306002533.2380866-1-sjg@chromium.org>
References: <20250306002533.2380866-1-sjg@chromium.org>
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
2.43.0

