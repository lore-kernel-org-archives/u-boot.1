Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379ACCD6E6D
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 15:31:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B171984957;
	Thu,  4 Jun 2026 17:31:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="Gy5z9J2g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C1A084946; Thu,  4 Jun 2026 17:31:19 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55FB6844CF
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 17:31:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-45ef6565cfdso511899f8f.0
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 08:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1780587077; x=1781191877; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9DPcWQ3bTA20oheUZeDhci5nZojGkw/H6rBWg1GgL8Q=;
 b=Gy5z9J2g1zlFxngcJ1/KSFpZWGtnzw7zZqwV5tn4mWRjhosAi8xwRwbkDGitf+Vg5/
 zxKfW15D/oHbYjFqRHdlSGll4N1cpwepz1u6Ag+L7xuBG9rCDey7azXip04Dm5tzF7cX
 +fsFsx6WJlPSNDcLS/IkMd1ZPxTLCHWXESyzU7Ri4U1wCcsHMY/k/otmQLAWfn2KYYRw
 s6Uw60oC4oEyyL+xGdasMKnY255zY+H9Hh+2APYd3f+p/2OT/J7rFr6tJ1k9wCIygeHx
 4zOiGeRgXIKqXSmI8/rOp+tYjs/uKWX5IBy6EQ9CQPwsZMYjsoZXZjjVdCnC3rL2dnBn
 qK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780587077; x=1781191877;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9DPcWQ3bTA20oheUZeDhci5nZojGkw/H6rBWg1GgL8Q=;
 b=YfQZJZobzFEXdUFRvbUh0W7H9OM/7Xao03wEmvSr4qJEN3e42Qbrni6/LvkqRWJC9m
 m+wEBy7eWtwS3qO1/pz8otWfgXoxwLiJYoSEV87Hlo7X0fyR7w2XiqQHqqSSvPZMW/3U
 XQ7tIsTIAVuvAg23GScFtgPUpuG99BN2VeGVhVvh/W9j5pYOecgIEKubAUKQzmLKENH5
 3PiiI99f1NaYyMEa7S/3MLWrHbXuhShva4XisifyVL14BP9icZt8sfBHkA+ZHfxunFDu
 Lk1OQGn+MjbgCVgYhZku8Kaijlwnvfhai8mqjFZ9L8GsfNUhjb1GmhrDAtK49SGm9nW6
 VF5g==
X-Gm-Message-State: AOJu0YyGeAXLxxQWcn0OI58HmVrvLbuXUHeM8ot1Af0r2X5+veoImX3M
 JoupzzRjU66guwLNW+0xxV0oQ54YUjhHupolnikwAh4fccyy+zeubklnu5/lNBzqNuI=
X-Gm-Gg: Acq92OGH4uK132g/42q2DLPNDirsxAAdgG3cSpojR+8xRXeFy1K0LYtDoYWCMu223oa
 jkYXMmGnl6mNeNGNXgHWT6tQ0wqcrkD6xPYccFmGgIQ2RbEiGPvgadOduP92p+YyzXS3c5wQ6F4
 I5ctHcqR6zMWeQecEYbYEsEw6JbHXkUZSyqHZLh76JRC3liiMkWIZ6rxjanlgvvH/kkDMzB7HfD
 aWy77bIyzCo8t91UwWV1/5oyheNgSLaFirddzwJbRc3q/XRlexBJCwYhoui4t3kg8ABtzVcK/8a
 6QWFEhEf0PDsfdzGKa5lDMprJEg5DnbIMjsKcNzuYiFPCxsVYelD0pOKsPjKmEh/nqC3d9l2Zqf
 XuvWt//mrken7nYWhyxM28/0IOISbQVdvGtt0Y19OdwtxLIomkPZf3sR03wgSSZPGoZNxwRbBsW
 VE+iVZnt9xaGpBr+MqcqSw+eSbv/mDeDD6QpqmRmVRTlRX2DawTZf5miBqbSWihA==
X-Received: by 2002:a05:6000:18ab:b0:460:e00:121d with SMTP id
 ffacd0b85a97d-460217d04cfmr12009235f8f.14.1780587076712; 
 Thu, 04 Jun 2026 08:31:16 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.92.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f351ac0sm28284932f8f.27.2026.06.04.08.31.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 08:31:16 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 04 Jun 2026 19:31:06 +0400
Subject: [PATCH 1/7] pxe_utils: fix W=1 kernel-doc warnings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-bls-v1-1-4ce6d1ee4711@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2547; i=alchark@flipper.net;
 h=from:subject:message-id; bh=M0fqVJXPuFEdexnOtSQwlxo2dFnGWISdUXLCVc49vUU=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQpzrIzUPxu8rf53gffWtOZopHX5i9cOuvIvz8GsX2HE
 n13S9eydExkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkY6xjpGDFycAjDVvdcZGY79N0nXv+np1iiz6Zv69ZmGHjs/8Qt62yzp1ejR4NmyfyIjw7VFakY
 /DKx7Ujzrv/RHff/Xtubm825Frm03akSNtNw+cQEA
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

Add the missing parameter and enum value descriptions reported by
scripts/kernel-doc when building with W=1:

  - get_relfile():           document @type
  - get_pxelinux_path():     document @pxefile_addr_r
  - enum lex_state:          document L_NORMAL, L_KEYWORD, L_SLITERAL
  - get_token():             document @t and @state

No functional change.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 boot/pxe_utils.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 419ab1f1b0ef..774d5f43c036 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -95,6 +95,7 @@ int format_mac_pxe(char *outbuf, size_t outbuf_len)
  * @ctx: PXE context
  * @file_path: File path to read (relative to the PXE file)
  * @file_addr: Address to load file to
+ * @type: Image type used to record the loaded file in the bootflow
  * @filesizep: If not NULL, returns the file size in bytes
  * Returns 1 for success, or < 0 on error
  */
@@ -162,6 +163,7 @@ int get_pxe_file(struct pxe_context *ctx, const char *file_path,
  *
  * @ctx: PXE context
  * @file: Filename to process (relative to pxelinux.cfg/)
+ * @pxefile_addr_r: Address to load the file to
  * Returns 1 for success, -ENAMETOOLONG if the resulting path is too long.
  *	or other value < 0 on other error
  */
@@ -914,6 +916,13 @@ static const struct token keywords[] = {
  * Since pxe(linux) files don't have a token to identify the start of a
  * literal, we have to keep track of when we're in a state where a literal is
  * expected vs when we're in a state a keyword is expected.
+ *
+ * @L_NORMAL: Outside any specific lexical context; whitespace is skipped
+ *	and the next non-blank token determines what is read
+ * @L_KEYWORD: A keyword is expected; the next word is matched against the
+ *	keyword table and tagged with the matching token type
+ * @L_SLITERAL: A string literal is expected; characters are read up to the
+ *	end of the line
  */
 enum lex_state {
 	L_NORMAL = 0,
@@ -1018,6 +1027,9 @@ static void get_keyword(struct token *t)
  *
  * @p: Points to a pointer to the current position in the input being processed.
  *	Updated to point at the first character after the current token
+ * @t: Token to populate with the type and value of what was read
+ * @state: Current lexer state, controlling whether a keyword or a string
+ *	literal is expected next
  */
 static void get_token(char **p, struct token *t, enum lex_state state)
 {

-- 
2.53.0

