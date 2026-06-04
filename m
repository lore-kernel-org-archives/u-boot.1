Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1D5CD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 15:31:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 737C384964;
	Thu,  4 Jun 2026 17:31:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="zb6MRK/D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 444AE844CF; Thu,  4 Jun 2026 17:31:27 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3876C84970
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 17:31:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4905529b933so9155275e9.0
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 08:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1780587085; x=1781191885; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=36oMtMfvMduntzKvu5Hwalr8uipNXTr21IqiwZ+XZpQ=;
 b=zb6MRK/DzNNtaqZ4ljtNcScPgWCprLu6u43mfd1oOA+kFbiKfqo7ffpTm1Y9AhWdY9
 InuZ4MNk9Iu3NPT2OweROjUM0H0XJJYLVfnkECH+3jQIEmQPj+SRBIZ8idGWVOPmemHa
 hLhJOCChhD3f5rFEb8ngoINAZIsxnOXEiC1JnpmWBl2ZmSDr3EMcCP29DUnZ1c+C6YBR
 Bjyz3BLyfeAGYUoocpZptAN/Vl/lap6/S1++7c5mwGFupWds8vM77BLnnqSmS4JylIF9
 RpinQ4QmDqPeLn4OX0Oe+fIVs7o+RXzNc+NGMUEDMHQVtJFYNjME0CUMBJgHbdjoXbJ2
 M1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780587085; x=1781191885;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=36oMtMfvMduntzKvu5Hwalr8uipNXTr21IqiwZ+XZpQ=;
 b=AVc6htSpygzQp55PwhdI0ljmPZJ6xBILL/MeBMj3jVbpDiLQO2nCv0G2mL7XvrfGe8
 4Ue2PsabTLX2gTDxnlHKL/X6eeeuWJiXxx30/oweokUv/AV3sSkaMbd24zcBtx4tqtBP
 x8OZnXyqAv29gSy9PKrYBF9PbM2A1tSifGsGdOGpVp3JzxEZeVgcQN3T66oeCpMZsDoF
 vdBkGb3HyUeJ1iOg3mWj5fe9BDlM5UR8/OVEljMOccBSkwsW+CKZ5emgn3hHYQEnRqmr
 x+2yaOWcqFj3k43UF7fFkGEZEu3pVnQ3HyGmno6kxP3XFvh2KlAuRRgShbVaED1CzUbd
 kQeA==
X-Gm-Message-State: AOJu0Yx3knwMHb5UH85/u+k3sx2giYo7hCrtwyhXsMoriBsVEvOybMeJ
 ZoeQEpqHZTl+/3UkTzje4v5AG393+rwLq21YDMqIXaGMOnD4ER6EGGX5NA4vJGE1K0A=
X-Gm-Gg: Acq92OFAL/lWTfNrFIea6LdNYuy4Baqo2qF1JO/h+jydeiJSK4vOakkkGI4doNl+MRV
 iak9Zsg0QhKGci3mnI0Q+g62F3PllK0WR0Ys6fqYuOeE0xyjYxPKOgyHFMIBZhQBBfzf6dWsJUz
 TTc1bWYCk1tEhNqSJh/GBqA1wTM39y0z0alzXx4V502ZBU/DueS4+y2L6UiSBOcs/ql/j0YqJko
 zoXWOhIUQljzhWARg7qRT0f1V3CrlhWoAmp8aRKonnVQmrU2VB2uOOruwARszhSdaAoT1TSyPTx
 2M8aZp+1m0lMjXtunihG9bMdst7PkqlKtzm6dDuFwcYo4bXHFqaMTFdg5HTFSO7k3HueQgSnb89
 0EjRaXJCR9ozfmn+da87fe/+OFbro4VLzeg50v2ESo4VFNiDrkytiR7h2r5XAGLPHQxO83xw/cf
 I9gaJ7FyTZPtJVrwCRa+NVR+tjNFoKjqkojJVcScCTjjWSceOhCyQ=
X-Received: by 2002:a05:600c:4ecf:b0:490:be41:87c6 with SMTP id
 5b1f17b1804b1-490be418aadmr54378985e9.10.1780587084477; 
 Thu, 04 Jun 2026 08:31:24 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.92.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f351ac0sm28284932f8f.27.2026.06.04.08.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 08:31:24 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 04 Jun 2026 19:31:09 +0400
Subject: [PATCH 4/7] pxe_utils: export per-entry label helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-bls-v1-4-4ce6d1ee4711@flipper.net>
References: <20260604-bls-v1-0-4ce6d1ee4711@flipper.net>
In-Reply-To: <20260604-bls-v1-0-4ce6d1ee4711@flipper.net>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Simon Glass <sjg@chromium.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Martin Schwan <m.schwan@phytec.de>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5951; i=alchark@flipper.net;
 h=from:subject:message-id; bh=Z/4c8P1qm2MMrgwe9Dzy698/s4sWNeG5rRW5pQJUnmk=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQpzrLfHlb0LPQOy/6TQdsVVmhdPfU57YbBc89npZsWf
 L3/9BR7RcdEFgYxLgZLMUWWud+W2E414pu1y8PjK8wcViaQIdIiDQxAwMLAl5uYV2qkY6Rnqm2o
 Z2ikY6xjxMDFKQBTfTqLkeHW/Pss31Nl7kxcNm3G7+vOew+8vZ2e2BWwNPpdqNr1tqUujAwzOlX
 l/ep/f/Krnj9Lt2jFuTcHwh3entBb+Nl3YvGh7igWAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

Drop the static qualifier from label_create(), label_destroy(),
parse_label_keys() and label_boot(), and declare them in
<pxe_utils.h> to make them reusable.

The intended consumer is a Boot Loader Specification bootmeth, where
each on-disk file under loader/entries/ is a single entry with no
'label' header and no menu to traverse: the bootmeth derives the
label name from the filename, hands the file body to
parse_label_keys(), and invokes label_boot() directly.

No behaviour change: the implementations are unchanged and existing
in-tree callers in pxe_utils.c continue to use them as before.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 boot/pxe_utils.c    | 37 ++++-------------------------------
 include/pxe_utils.h | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 33 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 420cee307baf..6dad3045f9d4 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -218,15 +218,7 @@ static int get_relfile_envaddr(struct pxe_context *ctx, const char *file_path,
 	return get_relfile(ctx, file_path, file_addr, type, filesizep);
 }
 
-/**
- * label_create() - crate a new PXE label
- *
- * Allocates memory for and initializes a pxe_label. This uses malloc, so the
- * result must be free()'d to reclaim the memory.
- *
- * Returns a pointer to the label, or NULL if out of memory
- */
-static struct pxe_label *label_create(void)
+struct pxe_label *label_create(void)
 {
 	struct pxe_label *label;
 
@@ -239,20 +231,7 @@ static struct pxe_label *label_create(void)
 	return label;
 }
 
-/**
- * label_destroy() - free the memory used by a pxe_label
- *
- * This frees @label itself as well as memory used by its name,
- * kernel, config, append, initrd, fdt, fdtdir and fdtoverlay members, if
- * they're non-NULL.
- *
- * So - be sure to only use dynamically allocated memory for the members of
- * the pxe_label struct, unless you want to clean it up first. These are
- * currently only created by the pxe file parsing code.
- *
- * @label: Label to free
- */
-static void label_destroy(struct pxe_label *label)
+void label_destroy(struct pxe_label *label)
 {
 	free(label->name);
 	free(label->kernel_label);
@@ -542,7 +521,7 @@ cleanup:
  * Returns does not return on success, otherwise returns 0 if a localboot
  *	label was processed, or 1 on error
  */
-static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
+int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 {
 	char *bootm_argv[] = { "bootm", NULL, NULL, NULL, NULL };
 	char *zboot_argv[] = { "zboot", NULL, "0", NULL, NULL };
@@ -1287,15 +1266,7 @@ static int parse_label_kernel(char **c, struct pxe_label *label)
 	return 1;
 }
 
-/*
- * Parse the body of a label: the sequence of key/value lines that follow
- * the 'label NAME' header. Stops at end-of-file or at a token that doesn't
- * belong inside a label (which is pushed back so the caller can handle it).
- *
- * Returns 1 on success, < 0 on error.
- */
-static int parse_label_keys(char **c, struct pxe_menu *cfg,
-			    struct pxe_label *label)
+int parse_label_keys(char **c, struct pxe_menu *cfg, struct pxe_label *label)
 {
 	struct token t;
 	char *s;
diff --git a/include/pxe_utils.h b/include/pxe_utils.h
index 0378f2889f7b..e639e59e5dc8 100644
--- a/include/pxe_utils.h
+++ b/include/pxe_utils.h
@@ -202,6 +202,62 @@ void handle_pxe_menu(struct pxe_context *ctx, struct pxe_menu *cfg);
  */
 struct pxe_menu *parse_pxefile(struct pxe_context *ctx, ulong menucfg);
 
+/**
+ * label_create() - Allocate and zero-initialise a struct pxe_label
+ *
+ * The result must be freed with label_destroy().
+ *
+ * Return: pointer to the new label, or NULL if out of memory
+ */
+struct pxe_label *label_create(void);
+
+/**
+ * label_destroy() - Free a struct pxe_label and its string members
+ *
+ * Frees @label as well as memory used by its name, kernel, config, append,
+ * initrd, fdt, fdtdir and fdtoverlays members, if they are non-NULL. All
+ * such members must therefore reference malloc()'d memory.
+ *
+ * @label: Label to free
+ */
+void label_destroy(struct pxe_label *label);
+
+/**
+ * parse_label_keys() - Parse the body of a label
+ *
+ * Walks the sequence of key/value lines that follow a 'label NAME' header,
+ * populating @label. Stops at end-of-file or at a token that does not
+ * belong inside a label (which is pushed back so the caller can handle it).
+ *
+ * This is exported so that callers handling formats which lack a 'label'
+ * header (e.g. Boot Loader Specification type #2 entry files) can populate
+ * a pre-created label directly from a file body.
+ *
+ * @c: Pointer to the cursor into the file being parsed; updated on return
+ * @cfg: Menu the label belongs to (used for 'menu default' bookkeeping)
+ * @label: Label to populate; must already be allocated and (when called for
+ *	a file that has a 'label' header) attached to @cfg->labels
+ * Return: 1 on success, < 0 on error
+ */
+int parse_label_keys(char **c, struct pxe_menu *cfg, struct pxe_label *label);
+
+/**
+ * label_boot() - Boot according to the contents of a single pxe_label
+ *
+ * On success this function does not return; on failure it returns to
+ * let the caller try a different label or surface an error.
+ *
+ * The kernel is staged at $kernel_addr_r, an optional initrd at
+ * $ramdisk_addr_r, and an optional FDT at $fdt_addr_r. If the label
+ * has an 'append' string it overwrites $bootargs.
+ *
+ * @ctx: PXE context
+ * @label: Label to boot
+ * Return: does not return on success; 0 if a 'localboot' label was
+ *	processed; 1 on error
+ */
+int label_boot(struct pxe_context *ctx, struct pxe_label *label);
+
 /**
  * format_mac_pxe() - Convert a MAC address to PXE format
  *

-- 
2.53.0

