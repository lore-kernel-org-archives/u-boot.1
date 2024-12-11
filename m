Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEC8E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 22:25:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 686E3801DD;
	Wed, 11 Dec 2024 23:25:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Yikivdqc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A63D80209; Wed, 11 Dec 2024 23:25:53 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A01D380192
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 23:25:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+j.ne.posteo.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id DC0265C67D9;
 Wed, 11 Dec 2024 22:25:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27C31C4CEDE;
 Wed, 11 Dec 2024 22:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733955949;
 bh=8LH42Hjv4WC6htds/2CkcroW24r5VhkNkyg/jfGnbUo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=YikivdqcIor+w93jUC9J6u0A8FYKQol3GXr10GdF+086txTWuK3/iL7tegWMb9RpE
 YswLIrgOkhTfSpEr1WnYLRjvhoMcIx3bhY7V+byx+gJ+Hk11N7w6Ut7JsadFmyC3t8
 CDvp0SJynruTvHOt+A8meNNFUQzuk11YRNr8XGVAz0mXpoG/mQ8SvGhhZ0zVLRHSLU
 zinCNKlYgPwFIW97+E/SM8bN7jxD6mm/thGWvGXf5lyAz9yeeuANzT2k4iqden4QS/
 qZh+EutbNp44R7+ak5aRlyfEdyQC4O24HYgJnkxOBBA0gcYuaMG3O7adyJ3Pd4EF4o
 20BYipvirdffg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 14984E77182;
 Wed, 11 Dec 2024 22:25:49 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>
Date: Wed, 11 Dec 2024 23:25:25 +0100
Subject: [PATCH v2 1/3] cmd: ufetch: Fix type mismatch on 32-bit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241211-ufetch-v2-1-2b5432ffaeb1@posteo.net>
References: <20241211-ufetch-v2-0-2b5432ffaeb1@posteo.net>
In-Reply-To: <20241211-ufetch-v2-0-2b5432ffaeb1@posteo.net>
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733955947; l=1467;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=ukV5W4viTNXoPORPuKkJ7XwZABI+SL1DgnUObgjPNLI=;
 b=gfPor0h6dE/stpIj5+SQMuDzFmZy673j+Z6SWBXLNkGbC4FB4EogVCVQNWi0eaoIQ+Jhm5gMG
 Z1I6UaAxtfQCxPx3tO1QZSGHsFNVBNcYlhX12XQ/JgxSFTgotJr7AKV
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
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
Reply-To: j.ne@posteo.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: "J. Neuschäfer" <j.ne@posteo.net>

On 32-bit architectures, LAST_LINE (_LAST_LINE - 1UL) is 64 bits long,
but size_t (from ARRAY_SIZE(...)) is 32 bits. This results in a warning
because the max() macro expects the same type on both sides:

cmd/ufetch.c: In function ‘do_ufetch’:
include/linux/kernel.h:179:24: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
  179 |         (void) (&_max1 == &_max2);              \
      |                        ^~
cmd/ufetch.c:92:25: note: in expansion of macro ‘max’
   92 |         int num_lines = max(LAST_LINE + 1, ARRAY_SIZE(logo_lines));
      |                         ^~~

Fix this by casting LAST_LINE to size_t.

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---

v2:
- Add Caleb's R-b
---
 cmd/ufetch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/ufetch.c b/cmd/ufetch.c
index 0b825d7e8c75f3b18933d3e3f77e5f40f2c7b658..5f3ef847b268dc384271fc6774720e5fd2337157 100644
--- a/cmd/ufetch.c
+++ b/cmd/ufetch.c
@@ -89,7 +89,7 @@ enum output_lines {
 static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
 		     char *const argv[])
 {
-	int num_lines = max(LAST_LINE + 1, ARRAY_SIZE(logo_lines));
+	int num_lines = max((size_t)LAST_LINE + 1, ARRAY_SIZE(logo_lines));
 	const char *model, *compatible;
 	char *ipaddr;
 	int n_cmds, n_cpus = 0, ret, compatlen;

-- 
2.45.2


