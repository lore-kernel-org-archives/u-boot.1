Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8825EC61DC4
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 16:34:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5CD6340636;
	Wed, 26 Aug 2026 16:34:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5bshIzZJXRRy; Wed, 26 Aug 2026 16:34:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787762084;
	bh=n6VlGgFhuSnVFJFsAxUKDRPfaBlfpjpeQ+KAyrJJvQI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mFE4AnSEij1j7SLZf6AcdFajFW833El8ZcQkm59xAFNkt0p2HfHuzxxGYQB6bSbg2
	 dPq+D6oQEuPbZYRK9i2HnUhIAlPEqbO/I2vqrnyqKmU4Lkmi1GnuiHw4+vmhzkIWRu
	 M4M8iyXIJPaoByiAlxCJEiTc9aWXnUDKNDnnVKSOG/O+Rvy9U3Lejtyl0X38pmuDY/
	 YtmMeS7Uj/n0JiK2gXBMBpTM7XIpFaFb0OAhhCPY7GZz6plSwwdLk1m6bYD1Nbp9XA
	 y19RGB8x94adv6PmBV/RIiOh+0TNU4RJh5LeGNHExfvj1npypcp5Yt2MWvYPEI/ltJ
	 h/HHnK2YTAHNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 29F3440575;
	Wed, 26 Aug 2026 16:34:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 95BB5323
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:34:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 87A3E60758
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:34:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 939cdGhgBFJh for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 16:34:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=y/w8C0pL
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 61E0E6073D
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:34:40 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c2531f453eeso61283866b.3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787762079; x=1788366879;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n6VlGgFhuSnVFJFsAxUKDRPfaBlfpjpeQ+KAyrJJvQI=;
 b=y/w8C0pLNTkKbk4v/ce8LvTo1QPrSPKSWmjxljJVafU3gVdwWGJ965HyFnjYKyhxB0
 +liGrDJ47hkFK6IxT1eHjGiyWLiqkB6jUGts/+J9SV4bu+1bVMVdu91SnnkACfKUdUG1
 2obRPNL/R8CZklpADCy8zN6ef/hLJMQIvklmjId6VuodIKFOksovV1Lq9lfQeCC31VAI
 E53zWqCYy27gA4hGzEMYeeK8YRthc48CEKlv5Cyxv89ajzvIiFUyIQQi09t/hulFe2Zs
 yHPXJdwlWB869LWkGYnZ+PiPoOed/AW1ZvxgmNNSGIiCMpdf61qAgkZBdZOxEIgSjbKR
 hh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762079; x=1788366879;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n6VlGgFhuSnVFJFsAxUKDRPfaBlfpjpeQ+KAyrJJvQI=;
 b=U3Wr1m82wueanz6D2ls4T/99mWOSp/ta0p14SfJQpY34fuIuXildbnIeLLP+V6psXr
 R9Rmw3hDNqgSypGF37e5t+2la1Tptv3VlxthGXaLyDDgceb2+8HD4qkrrNM94ZjvpeXd
 kZyCUEq+5TGYs9FpZXvda0QUa7mrH0amOUOhq4A0WOKRvEuB2OIyfjTgeyHSoM8r06rl
 E/qSWLi1HgepBtRQPx7DL/s7tBULxIOG2//2CCy+p1k5AP2O9c+7SygDYKaQoUTVClCC
 7JTE03SrCP3KxBCQqnQLYKfYLGQ5PPt5Ad8FcHr2xKxq5uhtdhTi/YROE2uh/l9KsSdN
 5MTw==
X-Gm-Message-State: AFuF++kieYen9YDVSxTGZrq3GxrtePw1aiJ9YHj/4Q7VIzabnrUF+boc
 sW2CJUggq1iZLaHkpMicWDwJo6ilSslaOVNB/buxa/H5QBACNIOTO1TQNWlKK5E0XFc=
X-Gm-Gg: AR+sD10Xt3kPpHIbbeNQybWRezGwBXjHB0ZEYCJTIKMo9dvI4O0l5uTmjJs3Zj0tXNI
 2M7ZzUkRxmhxrtaJJSHwfjzjfO80K7a5J+tqbRuoun/C8qBEXvO1caF/+xHOJhgIeCH8aAZ1E67
 UILFim9BMybaN8SCDNfSgXjDqy2LNKH9Mqlhjjk6RZiGCl2oqzsiUNyMSn31L0ZrbcJIN8M/5YF
 xtZM6B2Ue9hncSzweYggnop5EpxVJdNNwb6EHbMrgWCbQKz1JX4qDATIb2JyF7amVYSK9CDL/E+
 j1j4n6nMOqjh6fDmeDJdDXlnFK6p1cPdzrkp9Uko2gOhx4IPBkyakpJQb3x/+hPRMxdEtl0fZJT
 SQFYrQiCTTJ9vu9+q7f56IpJ7dnsQHMBRk8fA30YYuoEEtplSFVSsqJkTh8ExQU8+sZb2+20lV+
 DMdMrFwphY4PlPhc1IDVmcWexeALzk0N4gooAEBZLajh5RWqNnmdP33+PATUYBIDIYO+/lqwajF
 BBF0BEVV++mW1RvQHy74eNRMswOgQhEYNv9XcsrEg==
X-Received: by 2002:a17:907:6093:b0:c08:417e:3696 with SMTP id
 a640c23a62f3a-c250c318ec5mr946204266b.20.1787762078943; 
 Wed, 26 Aug 2026 09:34:38 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-94.alshamil.net.ae.
 [86.98.192.94]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a704e55sm544907666b.21.2026.08.26.09.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:34:38 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 26 Aug 2026 20:33:57 +0400
Subject: [PATCH v2 05/13] pxe_utils: export per-entry label helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-bls-v2-5-17df3c9548ba@flipper.net>
References: <20260826-bls-v2-0-17df3c9548ba@flipper.net>
In-Reply-To: <20260826-bls-v2-0-17df3c9548ba@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>, Denis Mukhin <dmukhin@ford.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6305; i=alchark@flipper.net;
 h=from:subject:message-id; bh=liqPlOJlqvCPya6p4HSjgGWxrvFGQENfIsN06UpvccY=;
 b=kA0DAAoWsqLYjxBZ1KUByyZiAGqPFY2gKEMQajB1Y0Je/Ud9trQYlgfVvJl52B4qQc1UZs64x
 IiRBAAWCgA5FiEEnfakPZUyDpq6SEj1sqLYjxBZ1KUFAmqPFY0bFIAAAAAABAAObWFudTIsMi41
 KzEuMTIsMywyAAoJELKi2I8QWdSlRp4A/iJCY5eDP87MY87M0oyXCgkc+11dEsC+maVEZL9rPnA
 YAQCmWKYKPJRjFs3Cz4rqt42TDakg+g55ma5QoNa9xiEhCw==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

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
 boot/pxe_utils.c    | 43 ++++------------------------------------
 include/pxe_utils.h | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 39 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 25159bbc36f8..00e0453458a3 100644
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
@@ -1287,21 +1266,7 @@ static int parse_label_kernel(char **c, struct pxe_label *label)
 	return 1;
 }
 
-/**
- * parse_label_keys() - Parse the body of a label
- *
- * Walks the sequence of key/value lines that follow a 'label NAME' header,
- * populating @label. Stops at end-of-file or at a token that does not
- * belong inside a label (which is pushed back so the caller can handle it).
- *
- * @c: Pointer to the cursor into the file being parsed; updated on return
- * @cfg: Menu the label belongs to (used for 'menu default' bookkeeping)
- * @label: Label to populate; must already be allocated and (when called for
- *	a file that has a 'label' header) attached to @cfg->labels
- * Return: 1 on success, < 0 on error
- */
-static int parse_label_keys(char **c, struct pxe_menu *cfg,
-			    struct pxe_label *label)
+int parse_label_keys(char **c, struct pxe_menu *cfg, struct pxe_label *label)
 {
 	struct token t;
 	char *s;
diff --git a/include/pxe_utils.h b/include/pxe_utils.h
index 0378f2889f7b..fe6ecd971229 100644
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
+ * header (e.g. Boot Loader Specification type #1 entry files) can populate
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
2.54.0

