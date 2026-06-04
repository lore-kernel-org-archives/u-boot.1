Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9287FCD6E6D
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 15:31:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33C5A84968;
	Thu,  4 Jun 2026 17:31:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="57ar5hyb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60E7A84968; Thu,  4 Jun 2026 17:31:24 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66507844CF
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 17:31:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-45fd45e596cso463246f8f.1
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 08:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1780587082; x=1781191882; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DUFHbThJ+PReTQE71rT7toxqZfox1eG+RX4Wm86g1b0=;
 b=57ar5hybfn73yoDKJbK5/VOkTMH4rZXe1MkTWyVtdXpqHMhU+IQp0vVUw6zHqXmvSM
 1GUmyGFfzoaDpNYt/Sis5dmW2Sqqg2D/emvLdhKbttpUr9nq/9crnOAfBX67nywg84M9
 s7q2yg4TzuyR/66HNku/sZSvgyLzc6sRC54hdrlj/RMEXhMDjGkcqrc/wFvODT2Vyx6e
 fPCupuTGs7lFd6gUj05Rg8dVCMBJoDNM9Aq/O0h0SKyWFrZzMB0FjqShEQGEH4Fe87rj
 ZKyekmO6gNSh1/we4FOmdJdHkxXEIBIhTX6ToCA9mxo3AsgO0v4lqTQVdiEFBdg8e9xG
 v4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780587082; x=1781191882;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DUFHbThJ+PReTQE71rT7toxqZfox1eG+RX4Wm86g1b0=;
 b=SQtjiur1z1KH73M4fAfg6Wa5sTAfZEdHRIV5VCqKXJGlgpXpmMqLYpTQfr5ZY8djoZ
 DkOdsTKO6JenmtlSSjtRn6JE0Edl6MfLsG6tP2/MVy1opXbA+FTRR6Rg+H2rcycCkBhr
 ZJWPcH3g4Ry3NypJxaH/YezKQG09cosc8jqTWYBm0Kk271rtRZzDqQQ/ugAem/auNkR/
 TlVbkKWmngsO5bfbMwhuOEl6FvF7/zjQ1o+ouU55LfHLkqAYKr3ALsCt9lVp0NOrMgfv
 j0hqA93ZlcRN4tMQ7QISHdiqHShJfO1JCeWYLqlD+6arefvGqj+lMrRcyR6zONSO8eFJ
 fyjA==
X-Gm-Message-State: AOJu0Yw0nc683XaLGOvPVsqxQ6qWarVo3SMmvULu3w01ur54I3PmP/bN
 GIGpKXHaziWRgAIUd5YFyXbBm+P+Tpwzci3mtlO/oaUw7TelnC+/jTRMRbY1MAhEwps=
X-Gm-Gg: Acq92OFXR5IKgo9un+uaITwvR2JUOCnKhGGTg3vByQ011+0wL7rVbRCKODuFIO1CvlV
 4XDTSre56P5PnhH4eOPzFYfHaLJ63lUACy5SI78xp3+sbyFuI33mgY7lPQlstx8NzWi03YRgmPB
 n3rCeGjxyJoFdvH/h2i4GnEjy2o8Pd1Sf1FBDrMyXsSiKhSSg2dw/OSWWRkrHENQFzydepBo6Ri
 OOnob33CaIFSWQ0LxIfXH8vCI7wVISZSZda5JdozwC6gdO06gG7bUjcllSQcDnN6iihzh5EvSQ4
 UfczrIkfotJ9MkJ8K81V2dxEta+eV98yKxV6Q/mrjqcrVLgArT7rhuynXVu89oMXlesrHQGEAZg
 mfKMFgDrVDjzaSPlidu+B9ouhUdMpfuRAhHrSt7CVe2aqnPvjla6l9OazbblQ2a49pEHvBL736x
 lZeN1QmRwb7MGLhoWad4rzeowMWjxAgb3Gjur4bCjShSXpRpnscDiMZs3ez4OtuA==
X-Received: by 2002:a5d:649c:0:b0:45e:eea1:f1e9 with SMTP id
 ffacd0b85a97d-460217a7001mr9893050f8f.11.1780587081813; 
 Thu, 04 Jun 2026 08:31:21 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.92.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f351ac0sm28284932f8f.27.2026.06.04.08.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 08:31:21 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 04 Jun 2026 19:31:08 +0400
Subject: [PATCH 3/7] pxe_utils: extract per-entry key parsing into
 parse_label_keys()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-bls-v1-3-4ce6d1ee4711@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3083; i=alchark@flipper.net;
 h=from:subject:message-id; bh=jnru2Y25TOeV4hI94+dFQoXhFHOrT1TA6Jvs9YqxY6E=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQpzrL7f6LpksaMX+9e/vJcE/a1f6Xcf2Y1ienMepvEL
 wdXMviwdkxkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkY6xjpGDFycAjDVE5oZ/vsUdbBPOjGj6YCkrG7+EhuNZ2eufzrxP0F378c7GYUBe88z/E9mSt+
 5v+saW6P0yqP2zD+arGdd4HW4w3Kns+Hk/AVm/xkA
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

Split the body of parse_label() into a standalone parse_label_keys()
helper that walks key/value lines and populates a pre-existing
struct pxe_label. parse_label() becomes a thin wrapper that creates
the label, reads its name, attaches it to the menu, and delegates.

This is a pure refactor: the new helper contains the original loop
verbatim, with the local variable declarations moved to its scope.
No call sites or behaviour change.

A subsequent change will export this helper so callers parsing
formats that lack a 'label' header (notably Boot Loader Specification
type #2 entries) can populate a label directly from a file body
without duplicating the parser.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 boot/pxe_utils.c | 58 ++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 21 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index c45c9d0cd012..420cee307baf 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -1288,34 +1288,20 @@ static int parse_label_kernel(char **c, struct pxe_label *label)
 }
 
 /*
- * Parses a label and adds it to the list of labels for a menu.
- *
- * A label ends when we either get to the end of a file, or
- * get some input we otherwise don't have a handler defined
- * for.
+ * Parse the body of a label: the sequence of key/value lines that follow
+ * the 'label NAME' header. Stops at end-of-file or at a token that doesn't
+ * belong inside a label (which is pushed back so the caller can handle it).
  *
+ * Returns 1 on success, < 0 on error.
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
@@ -1397,6 +1383,36 @@ static int parse_label(char **c, struct pxe_menu *cfg)
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
2.53.0

