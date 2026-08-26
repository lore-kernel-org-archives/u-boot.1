Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6BDC5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 16:34:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CCB2380B84;
	Wed, 26 Aug 2026 16:34:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EGGkdYuy3pio; Wed, 26 Aug 2026 16:34:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787762081;
	bh=wklKDseNcm6U0mw4SNAzAHNuTrwQj+uNHEuoIcrsGko=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NEiZSYM4Y8x2lnQHdLRI+9VKelxFHx+NOzGo5JYtt1SyqziaXr2T7FB74fghuZL30
	 UvBkWOw49HTNI6La1yQI8j5MlLCofiWSAGN/tD22A6rQdg99OnhVl6qX9Wil5Nn+j7
	 dh9x54zcJEkTQwqSSZsq6W7RUAp3C23AlE3q9mrkJUwpdorlAm/+n944f9bkfLppaE
	 FTcqYIHdA3XtyeeqOeGVAwq06uVfyRjCOv311y3p4oNojGrUegBeR89rPoCHTeWMy2
	 O3jyTH0Qcc17MNKYXZMoX2Ii7WPJGdiwySfjN+NDtOkX+BtMqKI0BFuaS0mCJSXyPL
	 IfV2ShbuORjdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F86580B49;
	Wed, 26 Aug 2026 16:34:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 94AC3323
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:34:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9201460758
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:34:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w4PI8KBn32Do for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 16:34:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=ckj3wxI6
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9759C6073D
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:34:38 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6a3e145e1bfso1749252a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787762076; x=1788366876;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wklKDseNcm6U0mw4SNAzAHNuTrwQj+uNHEuoIcrsGko=;
 b=ckj3wxI6+YxYl//oRJSu442+AoLiIcZTJj+AEyVVlh/xExiYUymIkkZGsyLpzsm4A1
 3avhyXmZU+FrZR/MG5Njzm+0pxqLnPDuHYGBU6Y1qsB4j/Ruo90zpWyn321wYTAdg/5j
 G895jOqM07rW2ovyFNBeVY7DF3Lsknx+i+dAKPlCHjXshSyZnJVbJVTetGrYKsQd/24L
 iI2GfM0WmgTTifg44HFACCv9RbmBAQepCwdC+TxzVhAIpQXmp+5g1NPJKGWquOOjOBpJ
 SyzSRPBo1Oyv1Um8raDo1W9p9gvyki5tD0H7WARKGf3ZmDlr7DL97MgSbhf0hKyefn2D
 T8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762076; x=1788366876;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wklKDseNcm6U0mw4SNAzAHNuTrwQj+uNHEuoIcrsGko=;
 b=I3jkeQfYjfw8uZtsq6V4vhcKBhVbUV8VXVMNjLLHpsg50HoU60ncp9WU8L1eIHnQ29
 atDpt0s6kWcgZRA7P/ws3Kgh4/igcLloOSIqPi+RdR9f/Ae2ywigFeKUx9u0e/ndoOzP
 QTkygoazyhijJSW5yDikMfBWXAFGujZt5AOlWRvh5RBTCt0LUSFDtllpR0KjkHZqn0vE
 DoWncX7rzsi9IiI1lzsWJ8bTpCxx92o9tqbHQVowFNQl9zw6zM3o4M6qVnjI+aC+PpxP
 RQNSJ5qCAlkRE0or51zOR5EVU1flymgwT76Le8UE1zChON74gacDAuDxbeS855THMrSP
 FssQ==
X-Gm-Message-State: AFuF++kIkEUEeLv6FnYqwzaKvCm8ryXGFbaXfjYgMz2nAAESnnvSNNGg
 FgxP2yQEvEDPfl/7IOa1UxEoaA4xG3/M/5EMiz3ORSBcO4n0UMHmCvwy7QPGDWBBeDU=
X-Gm-Gg: AR+sD12P1jk2AI6iomwGwT5tmkUzrdSF1hUuz+apGGBDIPOi20IcMDGgegcAdCI6QRW
 JFlEGzaot9Fp4RJPZJSWbJzjNhCzrqybbXmc4btxipNDD+w940bKZnNdeU1XA5O3I9XZ6H0qZh+
 tWpcBlxnR9Jf1OubSASGoWoqQUuRMFhdV2VwgH8IfietAzsdfzPf+nfpPvnZ/rbdZk79BFdUN5k
 x6thVBVQy1lQM+Wy383c7MiDVdb763zQc0N+B4kqJpv9nl15OyrHE9xtWoV5mXyMhSe9a0/KNgY
 Q15I4/4mR4Oct8nGG0Hz6h24EdYmg2Wqiy9R7airJJaa4eImPas9t/iQ1tra0yaob/k4P8wrGKl
 H3EzLwjWiBngjMKMEIhSSEX1GiCuhzULpfu57uy29jy6B4CkjSvpxxGN5cppcKDv4gCh50wZoen
 YY6rMmNU3YmtdEADYQ2FbZxM54nXb5vCV/BcKLvhmfn2pdiOln2GWCsPMudPbPnW00F4FroUjFi
 YuQQsUgZyZNxb1xMHOscxXyCnaXuZSGAAFiVkDjIQ==
X-Received: by 2002:a17:907:1907:b0:c20:23f8:99a5 with SMTP id
 a640c23a62f3a-c250c2e9dd9mr1036139366b.15.1787762076127; 
 Wed, 26 Aug 2026 09:34:36 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-94.alshamil.net.ae.
 [86.98.192.94]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a704e55sm544907666b.21.2026.08.26.09.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:34:35 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 26 Aug 2026 20:33:56 +0400
Subject: [PATCH v2 04/13] pxe_utils: extract per-entry key parsing into
 parse_label_keys()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-bls-v2-4-17df3c9548ba@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3445; i=alchark@flipper.net;
 h=from:subject:message-id; bh=1XghyOtxXXjd41xRPb3KlatU5SiExfWvbqf9pE1yxEA=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT1i/bqxkldPjg3asMc79KZ5jOYXnQuc/pz7+4iRgXza
 0/+9tx61zGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrpGOsYMXBxCsBUB2UwMkzuDzP8cdJ7kxm7SVVh7JvreT8ONkt0GkkHBrJNZPLnfsvIcOnIjSJ
 dWQHLyx0nnRkrmFiVZHwKGE/vfqjvz/RUyUCIHQA=
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

Split the body of parse_label() into a standalone parse_label_keys()
helper that walks key/value lines and populates a pre-existing
struct pxe_label. parse_label() becomes a thin wrapper that creates
the label, reads its name, attaches it to the menu, and delegates.

This is a pure refactor: the new helper contains the original loop
verbatim, with the local variable declarations moved to its scope.
No call sites or behaviour change.

A subsequent change will export this helper so callers parsing
formats that lack a 'label' header (notably Boot Loader Specification
type #1 entries) can populate a label directly from a file body
without duplicating the parser.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 boot/pxe_utils.c | 64 +++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 21 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 078eb2d0c244..25159bbc36f8 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -1287,35 +1287,27 @@ static int parse_label_kernel(char **c, struct pxe_label *label)
 	return 1;
 }
 
-/*
- * Parses a label and adds it to the list of labels for a menu.
+/**
+ * parse_label_keys() - Parse the body of a label
  *
- * A label ends when we either get to the end of a file, or
- * get some input we otherwise don't have a handler defined
- * for.
+ * Walks the sequence of key/value lines that follow a 'label NAME' header,
+ * populating @label. Stops at end-of-file or at a token that does not
+ * belong inside a label (which is pushed back so the caller can handle it).
  *
+ * @c: Pointer to the cursor into the file being parsed; updated on return
+ * @cfg: Menu the label belongs to (used for 'menu default' bookkeeping)
+ * @label: Label to populate; must already be allocated and (when called for
+ *	a file that has a 'label' header) attached to @cfg->labels
+ * Return: 1 on success, < 0 on error
  */
-static int parse_label(char **c, struct pxe_menu *cfg)
+static int parse_label_keys(char **c, struct pxe_menu *cfg,
+			    struct pxe_label *label)
 {
 	struct token t;
+	char *s;
 	int len;
-	char *s = *c;
-	struct pxe_label *label;
 	int err;
 
-	label = label_create();
-	if (!label)
-		return -ENOMEM;
-
-	err = parse_sliteral(c, &label->name);
-	if (err < 0) {
-		printf("Expected label name: %.*s\n", (int)(*c - s), s);
-		label_destroy(label);
-		return -EINVAL;
-	}
-
-	list_add_tail(&label->list, &cfg->labels);
-
 	while (1) {
 		s = *c;
 		get_token(c, &t, L_KEYWORD);
@@ -1397,6 +1389,36 @@ static int parse_label(char **c, struct pxe_menu *cfg)
 	}
 }
 
+/*
+ * Parses a label and adds it to the list of labels for a menu.
+ *
+ * A label ends when we either get to the end of a file, or
+ * get some input we otherwise don't have a handler defined
+ * for.
+ *
+ */
+static int parse_label(char **c, struct pxe_menu *cfg)
+{
+	char *s = *c;
+	struct pxe_label *label;
+	int err;
+
+	label = label_create();
+	if (!label)
+		return -ENOMEM;
+
+	err = parse_sliteral(c, &label->name);
+	if (err < 0) {
+		printf("Expected label name: %.*s\n", (int)(*c - s), s);
+		label_destroy(label);
+		return -EINVAL;
+	}
+
+	list_add_tail(&label->list, &cfg->labels);
+
+	return parse_label_keys(c, cfg, label);
+}
+
 /*
  * This 16 comes from the limit pxelinux imposes on nested includes.
  *

-- 
2.54.0

