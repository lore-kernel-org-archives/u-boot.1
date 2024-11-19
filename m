Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFB8D4415C
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:23:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B844895FD;
	Tue, 19 Nov 2024 14:20:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AOukeZdJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0852B8954F; Tue, 19 Nov 2024 14:20:08 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D843D895F7
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:20:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a77c066a15so1994685ab.3
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022404; x=1732627204; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LeWWlT6nmYsBBRhKTAx//K9wzJhrWPBya0XpXcD73uA=;
 b=AOukeZdJLbJ6MPihk3GaSfcDvnZny/aasOVSaIITRIlve0+hNqVnmac6glBWN5ZDNe
 7eQx+mkzbKMRGQ4JcBzja30LCdKCNoiQdZLwraj/SuvkI1++fBITtjtDPbkVYmI84YDf
 ZTO/lJ7SO3SsmXXDL6dQh5IuWdC+g5y0hY1ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022404; x=1732627204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LeWWlT6nmYsBBRhKTAx//K9wzJhrWPBya0XpXcD73uA=;
 b=IWmWWmWpF44dBbnEHJgqDc7JM36xvRKAfLFIpnoDoDOmtKwQCdDInKR3iA60TSNvjT
 ra5q9StMaP2ry/5hA3LqxAu9ZJU/kbrAodMkB+RcFyKGoAfvXgOapBJuiSmWC4sMQeOD
 xFPNDXzhm1Z7QgQzHR3izWhPZJ/wGv21d8odsdVPlnbqy8KcKG+1Vk/0UMWZIQxryieT
 rdF3+3NRAWEgeJ3EnNXg1MJD+TJeQ25seohWhYj1a2S7lWF+cc/8tK4AqQiCTGP3wdvW
 A1/hWlIxf0i9XJCjbo1X7mHEv0EWodDn54mEaLJnMjESVXLMlsy6H5+SkCkMF080UbV1
 xESQ==
X-Gm-Message-State: AOJu0Yz4iGd0my2sw6i1q2aURrtWLvXsDJL/xYPSviYHRW3t9B0EhZ67
 7iw9viEIk6rGFRLGOIVEO/FsUM/JI6dQvtkiglUO+W/7sEPtFWf5eLcaYErWIyFqMTO+Dy5kVZs
 =
X-Google-Smtp-Source: AGHT+IEV0ZLXYd0S3d9OcFwr+YhvOEFWfGdR9HDrQdfdD3ggjX+ZtFJ9+cMbVURSEkBbHSFcgypNAw==
X-Received: by 2002:a05:6e02:19cf:b0:3a7:77ff:24c0 with SMTP id
 e9e14a558f8ab-3a777ff25d3mr33178625ab.18.1732022404093; 
 Tue, 19 Nov 2024 05:20:04 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.20.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:20:02 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 27/39] pxe: Allow skipping the boot
Date: Tue, 19 Nov 2024 06:18:32 -0700
Message-Id: <20241119131844.4078144-28-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119131844.4078144-1-sjg@chromium.org>
References: <20241119131844.4078144-1-sjg@chromium.org>
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

Provide a way to skip booting the OS and just return. This will allow
bootstd to read out useful information.

Add debugging to help figure out the flow.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/pxe_utils.c    | 12 ++++++++++--
 include/pxe_utils.h |  4 +++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index b811406102b..7106e532e03 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -788,6 +788,9 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 		printf("append: %s\n", finalbootargs);
 	}
 
+	if (ctx->no_boot)
+		return 0;
+
 	label_run_boot(ctx, label, kernel_addr, initrd_addr_str,
 		       initrd_filesize, initrd_str);
 	/* ignore the error value since we are going to fail anyway */
@@ -1572,11 +1575,15 @@ static void boot_unattempted_labels(struct pxe_context *ctx,
 	struct list_head *pos;
 	struct pxe_label *label;
 
+	log_debug("Booting unattempted labels\n");
 	list_for_each(pos, &cfg->labels) {
 		label = list_entry(pos, struct pxe_label, list);
 
-		if (!label->attempted)
-			label_boot(ctx, label);
+		if (!label->attempted) {
+			log_debug("attempt: %s\n", label->name);
+			if (!label_boot(ctx, label))
+				return;
+		}
 	}
 }
 
@@ -1627,6 +1634,7 @@ void handle_pxe_menu(struct pxe_context *ctx, struct pxe_menu *cfg)
 
 	if (err == 1) {
 		err = label_boot(ctx, choice);
+		log_debug("label_boot() returns %d\n", err);
 		if (!err)
 			return;
 	} else if (err != -ENOENT) {
diff --git a/include/pxe_utils.h b/include/pxe_utils.h
index e8e03430a81..beadd221475 100644
--- a/include/pxe_utils.h
+++ b/include/pxe_utils.h
@@ -109,7 +109,8 @@ typedef int (*pxe_getfile_func)(struct pxe_context *ctx, const char *file_path,
  * @use_ipv6: TRUE : use IPv6 addressing, FALSE : use IPv4 addressing
  * @use_fallback: TRUE : use "fallback" option as default, FALSE : use
  *	"default" option as default
- * @bflow: Bootflow being booted, or NULL if none
+ * @no_boot: Stop show of actually booting and just return
+ * @bflow: Bootflow being booted, or NULL if none (must be valid if @no_boot)
  */
 struct pxe_context {
 	/**
@@ -130,6 +131,7 @@ struct pxe_context {
 	ulong pxe_file_size;
 	bool use_ipv6;
 	bool use_fallback;
+	bool no_boot;
 	struct bootflow *bflow;
 };
 
-- 
2.34.1

