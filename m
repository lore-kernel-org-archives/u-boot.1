Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3C5C3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:25:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A8A8888D3;
	Sat, 13 Jul 2024 15:21:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Do74nH9w";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XGyQcWL1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC54F888C7; Sat, 13 Jul 2024 15:21:38 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E47FC88872
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WLpyS5Ddqz9sTd;
 Sat, 13 Jul 2024 15:21:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=11PGt5JXK8/tYQIURDRCq69u0jz4qZVowGZw+sajkGI=;
 b=Do74nH9w27Yklvz2jujXqTBVuoI9SQdCq5hw9G8Em7YgIi0821yZ7lyxjo5HcOMIBD/atZ
 KqyxOJNy6wbOr1ut57fhUBfgfPoVkLGjRRDjkK2dAD6fi5aB4OE/6AahXG9g+mqmBp2vrg
 rqeiZeIMeXJa6EkdHQV9Vn8MjeF7EJIZ7pQP45sxhtMZIdqTlMYq0QbIFfacYB+yX1BOJc
 MfMPlq37DPIvOlhpWOdbsAcw+EcPVQxK3GIGbImYsGn5x8Ytn78IUonSL0jWXA29Bj1wQc
 FSu58g64cPm424mgJLbYqNc6BNzcVw26ofvLDntC64wj4sOMqH9G7sRMco9big==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=11PGt5JXK8/tYQIURDRCq69u0jz4qZVowGZw+sajkGI=;
 b=XGyQcWL1afA1f7E12hBCjnk+sHVTkZIzLHsCLUGFVHTCzbPGQRIIg53Ds8dUoJuM4JveaU
 7wp3QM81tOK6lF0Dnf/i5Dfyw1jhIEDidyS3cb7B8xtAu05oZtEaaI3VgV7h4WX7MXQ1D/
 k2lfzak1b2h91BfjJkwj9/V3D4FZeYAMNwNKv0AvqeV455WQHjSB3deoOvQeAtVKx6qZ1x
 BNmV2cCqkWglhwTfTBbqbTM56p4XYUHSuOD2Yxrdk2kNnLRY7VreFGw/JCy3xVuvNF9hwb
 9f1q61tLJFLjj5vX1gG6nlfxxpC3m784LQOSMLNAk1APHX1g50nCCEqxntn8Yg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 28/45] env: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:19 +0200
Message-ID: <20240713132021.57650-28-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2a163d0ebbd71a7fb7d
X-MBO-RS-META: qt71bfownszwkwomhoseycupndoqbxo7
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 env/common.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/env/common.c b/env/common.c
index d8c276dddfd..8d47d726059 100644
--- a/env/common.c
+++ b/env/common.c
@@ -394,7 +394,6 @@ void env_set_default(const char *s, int flags)
 	gd->flags |= GD_FLG_ENV_DEFAULT;
 }
 
-
 /* [re]set individual variables to their value in the default environment */
 int env_set_default_vars(int nvars, char * const vars[], int flags)
 {
@@ -588,7 +587,6 @@ int env_complete(char *var, int maxv, char *cmdv[], int bufsz, char *buf,
 	found = 0;
 	cmdv[0] = NULL;
 
-
 	while ((idx = hmatch_r(var, idx, &match, &env_htab))) {
 		int vallen = strlen(match->key) + 1;
 
-- 
2.43.0

