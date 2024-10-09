Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11ABCEDD90
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 13:16:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3905A891F2;
	Wed,  9 Oct 2024 15:16:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Ab9L6J88";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B23CD8921C; Wed,  9 Oct 2024 15:16:15 +0200 (CEST)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [IPv6:2a01:4f8:201:9162::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C4528919E
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 15:16:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martyn.welch@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1728479773;
 bh=YCGi8+wmxBDtT1bdIrNRLyiiZVGVsTLJ8pgwzoj3/zU=;
 h=From:To:Cc:Subject:Date:From;
 b=Ab9L6J88EBviCStQPWELl5NHKFvv5+W6esafBtdDYcC94LzjIOTwn+RRavHwLg3aV
 zwY9SxxQafu6CrWKjOOghpZLfNyTFT7CpHrcN23a03/+VWp5pyK2D/WhhYmYDIykgH
 31IxlYxBWdC7s/ic1xUrEW1EHLFLlxz7h9mvMaTw3L1RxdstPMm0iqf87aP7ajzB0t
 QwQ3wuSw6MgoMalPaq8G4hX+rEKTMuWn3RicAO4heryDTwkaSDfrR7W7IYOv2Q5NWu
 PW0SwC7kMHivjuYyNeUqlEMLbWEKENFflILwUufkyWxX0fIdoUOje/pDJaewPalLD9
 19lA18cMe86Uw==
Received: from pan.lan (unknown [IPv6:2a00:23c6:c32f:9100::16d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: martyn)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id F1DFA17E35F5;
 Wed,  9 Oct 2024 15:16:12 +0200 (CEST)
From: Martyn Welch <martyn.welch@collabora.com>
To: Tom Rini <trini@konsulko.com>
Cc: Martyn Welch <martyn.welch@collabora.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: [PATCH v2 1/4] boot: pxe_utils: Add fallback support
Date: Wed,  9 Oct 2024 14:15:38 +0100
Message-ID: <20241009131548.929439-1-martyn.welch@collabora.com>
X-Mailer: git-send-email 2.45.2
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

When configured correctly, we can detect when boot fails after the boot
process has been handed over to the kernel through the use of U-Boot's
bootcount support. In some instances, such as when we are performing
atomic updates via a system such as OSTree, it is desirable to provide a
fallback option so that we can return to a previous (hopefully working)
state.

Add a "fallback" option to the supported extlinux configuration options
that points to a label like "default" so that we can utilise this in
later commits.

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changes since v1:
 - None

 boot/pxe_utils.c    | 15 +++++++++++++++
 doc/README.pxe      |  5 +++++
 include/pxe_utils.h |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 4e27842b08..a80119c9a3 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -781,6 +781,7 @@ enum token_type {
 	T_IPAPPEND,
 	T_BACKGROUND,
 	T_KASLRSEED,
+	T_FALLBACK,
 	T_INVALID
 };
 
@@ -814,6 +815,7 @@ static const struct token keywords[] = {
 	{"ipappend", T_IPAPPEND,},
 	{"background", T_BACKGROUND,},
 	{"kaslrseed", T_KASLRSEED,},
+	{"fallback", T_FALLBACK,},
 	{NULL, T_INVALID}
 };
 
@@ -1356,6 +1358,18 @@ static int parse_pxefile_top(struct pxe_context *ctx, char *p, unsigned long bas
 
 			break;
 
+		case T_FALLBACK:
+			err = parse_sliteral(&p, &label_name);
+
+			if (label_name) {
+				if (cfg->fallback_label)
+					free(cfg->fallback_label);
+
+				cfg->fallback_label = label_name;
+			}
+
+			break;
+
 		case T_INCLUDE:
 			err = handle_include(ctx, &p,
 					     base + ALIGN(strlen(b), 4), cfg,
@@ -1395,6 +1409,7 @@ void destroy_pxe_menu(struct pxe_menu *cfg)
 
 	free(cfg->title);
 	free(cfg->default_label);
+	free(cfg->fallback_label);
 
 	list_for_each_safe(pos, n, &cfg->labels) {
 		label = list_entry(pos, struct pxe_label, list);
diff --git a/doc/README.pxe b/doc/README.pxe
index 172201093d..af2e64a577 100644
--- a/doc/README.pxe
+++ b/doc/README.pxe
@@ -120,6 +120,11 @@ Unrecognized commands are ignored.
 default <label>	    - the label named here is treated as the default and is
 		      the first label 'pxe boot' attempts to boot.
 
+fallback <label>    - the label named here is treated as a fallback option that
+		      may be attempted should it be detected that booting of
+		      the default has failed to complete, for example via
+		      U-Boot's boot count limit functionality.
+
 menu title <string> - sets a title for the menu of labels being displayed.
 
 menu include <path> - use tftp to retrieve the pxe file at <path>, which
diff --git a/include/pxe_utils.h b/include/pxe_utils.h
index 9f19593048..a408fb7f13 100644
--- a/include/pxe_utils.h
+++ b/include/pxe_utils.h
@@ -62,6 +62,7 @@ struct pxe_label {
  *
  * title - the name of the menu as given by a 'menu title' line.
  * default_label - the name of the default label, if any.
+ * fallback_label - the name of the fallback label, if any.
  * bmp - the bmp file name which is displayed in background
  * timeout - time in tenths of a second to wait for a user key-press before
  *           booting the default label.
@@ -73,6 +74,7 @@ struct pxe_label {
 struct pxe_menu {
 	char *title;
 	char *default_label;
+	char *fallback_label;
 	char *bmp;
 	int timeout;
 	int prompt;
-- 
2.45.2

