Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562DDC61DC4
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 16:34:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 194024065B;
	Wed, 26 Aug 2026 16:34:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KzHyiVQXQhLc; Wed, 26 Aug 2026 16:34:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787762087;
	bh=YOlKhsa3D5qJ0hoC8HaGZ4plDvssavwjzWLq8XRMBzE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uG7zCHyxsVtZfS26/UUE7BwVXqPVxkvUgDCgJ7512yFyBgY+3Y7hXhyiehTMk/qi4
	 t0369be0CjhFZ1BRqkZfn0TKvqFiAJTPgmZJDJpeD1w57tUs8XNSFFM19+96zpB74p
	 wfxd9rYYc/hvKH1VuAezRxYdxF9hFQW6GIlmr2tMTLzNaGLZg/rHKjlqrzjBVcft8k
	 h/A6wGf1jYdZLlKOSsFUCpnuEdxmhdpLfmBvOr1UuT49WLNaPHik+L1/wu0Id4vCj3
	 UiF3Sq/jteMdTMcNPOsJIWGzRjh1/6NVDlm5r2c91JWn3ay80TOlr3zbntooF38Dz4
	 M94C3OM5eSUsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34C41406A3;
	Wed, 26 Aug 2026 16:34:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 73E203874
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:34:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 661286073D
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:34:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id txSXdgg5Hl3G for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 16:34:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=DTjdpUHb
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5C05060758
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:34:44 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c253358b121so38970466b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787762082; x=1788366882;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YOlKhsa3D5qJ0hoC8HaGZ4plDvssavwjzWLq8XRMBzE=;
 b=DTjdpUHbSQCyX4bwRMzrHjpvGQHeSym0HTHiXjemwdLynum3jRCEfTgWxqI7xE5nkm
 1asbs6KheIZjNwA+OSv5Yxh46uALgEVs2VfZM9LLeLApAJvRWQ6JcKi7yS6gEtMYfRLq
 OABjrPVfotYOUD0bdVjdHiH0zX58A4Ua6LyWl2ShfxGhJSa85NClcqUSEm52k80YCgek
 xjaKtOeRPJHLlzskX2BkuyDPqy4n0OPcBvQogPoL/xvZ22xo9RZfyCNwLH7yuvx0DZr9
 mujviLGjv1M+uHTYeKaAKqKJBSfd380+NIFPk9ZV38klorOYhkNEI3dZzunBFfxiRTHx
 WelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762082; x=1788366882;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YOlKhsa3D5qJ0hoC8HaGZ4plDvssavwjzWLq8XRMBzE=;
 b=XQsAd3/hcDHVUOJETKaMWztFKAb4xK/+ACAYTis1N0V/Dww1WMY+OMZvXBhqhHG1Kl
 TAse73c4Kf3Xe9eGMZqsHJUPZ9FANx+zwf/N1hnuhADQKPWND9tH/cJL3kl31pEVcX5p
 GqFE6EzJdG8zyYQxo+zQl2rD4/QCDuFQlMhUSvoVZ9JWE4KiWzJE7btD9dUjl36Lc2HD
 x+FUVmDpLHUC9YTsDaazqkk47yNVDHScZrVrtxDwCsh+G7TP5UCGH7TZRZsVIgbP5ezQ
 s3l4Nf5RsGd4Y4Yy/N9n5XD0NGDUgg2n4GO4pco/mdgwT6dGW2nH65zOTrExH5d+2Vd8
 BQ9Q==
X-Gm-Message-State: AFuF++kYdia0tOQMH2MiyaVhJEP4rms5VcsKf+5u8hI1mei+vFeRPB5b
 Rm3nuwWfJnQArH0GNXq3/skEeu1H6YJzK+pvVSDqKRkCGVZBKtqWjOJ12VqNSRLnmx8=
X-Gm-Gg: AR+sD13bB7Tqg8omaPwML+T30qI6p1cmDVj1U9pbue23Dvu/xShP1nMOeVENV3cp4qw
 EOJN/ON9a4I+W89HF0Vg92Y4ppTiMGL49Y1KlpA1RI4WnieTRxQDQdGfHrEXotveA3zjcrChV1e
 DRDfFxOTsQwBkEgT3Z9SkurZ9t0Req6XF04MLVMw9dymrRqOsmFZSY86FBzr9mjoBr9BekOAxUy
 RmSn9NYyyZ07FDYP18qAI12gop0DaAkC1wxVlq2QsE6Gnfa9wbSxeOAoRc3VLd218vnAHXAbws9
 zurGulHwmPvh7n3H4ZbB4yRwdQkF5s7a2fT+MhhcjzREk+vuLiyE8ZhYLppWjV0YMBNQ7AICz5L
 ibmum1CZlgiT54d/VwWq0Bdk0AyR7VbMEtsN2HH6uEapJ5HakGwz0EBtuEaTUzG9xLPWQQNXnwL
 XZANOIH2Yn0cZxTMUkk/wVIQ5dDRzJFL1AFWd3sKsSfMVoTmvsygp198EqfG3TYvt///WLh5YnY
 J5B8UgnkcnOKK2A5vGiOUgQRL5GCkDKjZpwKJyHOA==
X-Received: by 2002:a17:907:e1d3:10b0:c25:2e93:289e with SMTP id
 a640c23a62f3a-c252e93300amr383068166b.16.1787762081780; 
 Wed, 26 Aug 2026 09:34:41 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-94.alshamil.net.ae.
 [86.98.192.94]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a704e55sm544907666b.21.2026.08.26.09.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:34:41 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 26 Aug 2026 20:33:58 +0400
Subject: [PATCH v2 06/13] pxe_utils: optionally ignore unknown keys in
 parse_label_keys()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-bls-v2-6-17df3c9548ba@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3970; i=alchark@flipper.net;
 h=from:subject:message-id; bh=C6ZgnbPf/4WSRnsW8/CKXchudVCZ6LOvNBkgkLxktDY=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT1i/ZeEkzLeXzcwu/thER7/tIppt83py5Z+bBOsOjem
 3rXG1dkOiayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZjqgh6G/xnPufZ/O7r26KZZLB8dnIMC56wQSorcb59s9lFaftZpRjOG/7ndz45
 ti7IW+sQy6WKG5dLg939nTnpgdFEw4dRUeyY2b34A
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

The parser currently treats any keyword it does not recognise inside a
label body as the end of that label, pushing the token back so the
caller can dispatch it as menu-level input. That is correct for
extlinux/pxelinux, where the only thing legitimately following a label
body is another 'label' (or a top-level 'menu ...') line.

Other formats that share enough syntax to reuse this parser have
different rules. The Boot Loader Specification, in particular, lists a
number of entry-level keys (title, version, sort-key, machine-id,
architecture, ...) that this parser knows nothing about, and the spec
explicitly requires implementations to silently ignore unrecognised
keys rather than treat them as a structural boundary.

Add an ignore_unknown flag to parse_label_keys(): when set, the default
switch case consumes the rest of the offending line via eol_or_eof()
and continues parsing instead of returning. The existing extlinux
caller passes false and so is unaffected.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 boot/pxe_utils.c    | 29 +++++++++++++++++++++++++++--
 include/pxe_utils.h |  8 +++++++-
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 00e0453458a3..994da42f7cd2 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -1266,7 +1266,8 @@ static int parse_label_kernel(char **c, struct pxe_label *label)
 	return 1;
 }
 
-int parse_label_keys(char **c, struct pxe_menu *cfg, struct pxe_label *label)
+int parse_label_keys(char **c, struct pxe_menu *cfg, struct pxe_label *label,
+		     bool ignore_unknown)
 {
 	struct token t;
 	char *s;
@@ -1339,7 +1340,31 @@ int parse_label_keys(char **c, struct pxe_menu *cfg, struct pxe_label *label)
 		case T_EOL:
 			break;
 
+		case T_EOF:
+			if (ignore_unknown) {
+				/*
+				 * BLS-style callers parse a standalone label
+				 * body, so there is no outer context to push
+				 * T_EOF back into. Stop cleanly here.
+				 */
+				return 1;
+			}
+			/*
+			 * For pxelinux/extlinux, fall through so the default
+			 * case pushes T_EOF back for the top-level parser.
+			 */
+			fallthrough;
 		default:
+			if (ignore_unknown) {
+				/*
+				 * Skip the rest of the line and keep going.
+				 * Used for formats like the Boot Loader
+				 * Specification, where the spec mandates that
+				 * unknown keys must be silently ignored.
+				 */
+				eol_or_eof(c);
+				break;
+			}
 			/*
 			 * put the token back! we don't want it - it's the end
 			 * of a label and whatever token this is, it's
@@ -1381,7 +1406,7 @@ static int parse_label(char **c, struct pxe_menu *cfg)
 
 	list_add_tail(&label->list, &cfg->labels);
 
-	return parse_label_keys(c, cfg, label);
+	return parse_label_keys(c, cfg, label, false);
 }
 
 /*
diff --git a/include/pxe_utils.h b/include/pxe_utils.h
index fe6ecd971229..0a27d830869b 100644
--- a/include/pxe_utils.h
+++ b/include/pxe_utils.h
@@ -237,9 +237,15 @@ void label_destroy(struct pxe_label *label);
  * @cfg: Menu the label belongs to (used for 'menu default' bookkeeping)
  * @label: Label to populate; must already be allocated and (when called for
  *	a file that has a 'label' header) attached to @cfg->labels
+ * @ignore_unknown: If true, silently skip unknown keys (and consume the
+ *	rest of their lines) instead of stopping. This matches the Boot
+ *	Loader Specification's requirement that unknown keys be ignored.
+ *	If false (extlinux/pxelinux behaviour), an unknown token is pushed
+ *	back so the caller can treat it as the start of the next label.
  * Return: 1 on success, < 0 on error
  */
-int parse_label_keys(char **c, struct pxe_menu *cfg, struct pxe_label *label);
+int parse_label_keys(char **c, struct pxe_menu *cfg, struct pxe_label *label,
+		     bool ignore_unknown);
 
 /**
  * label_boot() - Boot according to the contents of a single pxe_label

-- 
2.54.0

