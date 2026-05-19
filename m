Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC9FCD4F54
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 23:34:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DBF584911;
	Wed, 20 May 2026 01:33:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cAZtpR7U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01638848E7; Wed, 20 May 2026 01:33:03 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCA468488F
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 01:32:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6949192b840so1083353eaf.3
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 16:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779233578; x=1779838378; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JQd6Uhk0WtTb27isTCdtMC67pLlMxjrPdLJVL4w2Gt4=;
 b=cAZtpR7UoZ2RPRY3PmwYUUMYXyuR1icyObt84eYHzkFg0vxi4VTGq+RY1fisBsWGjS
 xS3GwY+lxYimDlY2SKl6LlPkv2HmworNAle4ctsdgM2ikxiQBbmKKL9Edx9SpEfeRyax
 Ajsyl/KCugsE/ZwAeZAzgzTo1s5LTJMPwOfM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779233578; x=1779838378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JQd6Uhk0WtTb27isTCdtMC67pLlMxjrPdLJVL4w2Gt4=;
 b=ApxHPK5ulMUt8A2jzU0DdUAWbFgUSGDxPGSoHpjSfPRs94rvk+Px2638yuMfRctyRO
 Q8TT73n5HZWQHBmSpNMBOmWKsANO3Iei2RrgI2DLnqPNGzGVfiaegLGKqKpoygqS4cth
 rB9RMg8BCZyq7ROAaD7+pA4x3rmuIdKVGmDq4FRhgfzmKow3DyaiMhGqX4YzuPTzkUVU
 SDZtWAhF06/o9V+5GLvWvJemMXQDCicWXVxKbkivotgFaZYnnQV+PBT7h8hLtIrpZQtq
 qkDA94FAiE8GZ5VlUC+A3XBbzcY51+oZxL6r/t0AZqlxKdFO4yB6nfsxAroXI9b2qrdJ
 Kupg==
X-Gm-Message-State: AOJu0YyLQF94rYmgrMf8KNe1mgzQ6WYKieovfmfoNuYqmURJFx/au21v
 ujD/CuRN35DX4ISmwtrmAr/znFXmtJ58XmiX3uZU3poXzdqbs4CKiEenAq/JNsn66Xlqj34RXym
 hr8Kg5r9V
X-Gm-Gg: Acq92OH+FQeg2Aco9axkYeKGcvQj65L6e8puhocFY857rz5xFVLuLwEyK5x+rYxjJYi
 YkZQTbxX1FDefNlGIxnyaafOikbB72cTccGyYzv6iX6CH0Q+0u+eFXCkzgEPMRdzbENBcGErBtH
 uZMfgCzHyhTpGJOfAltLTFagyQEsnTGwi7Mf8OBwZ0t8KzUZpcGVlLrN1fgNw2fdyj91myUxT7l
 RxVh0OjVjNc/bAMfkkDFW8GJcTC66wDLYwk7gTCq6rOQ1hrgDhltOV28glujrrCxNbcqhkbIrcg
 /euF7MRZrr1H2KPDgPi8WuKG+sKiC0bFvdVVj6lVekKARpnw6PU4KPFJhgS+A5cL3Q0dxQEkX/8
 07krQqQyJdqtWviDShpy1UvizasW/yiD6jIzdbWhpMUDcM6Rz1tenKuQFepjSdaRZIEytmhxm3t
 2ZnORL/P793WoYBQA//w==
X-Received: by 2002:a05:6820:4b01:b0:692:6030:1189 with SMTP id
 006d021491bc7-69c9bfaefb2mr12355775eaf.45.1779233578687; 
 Tue, 19 May 2026 16:32:58 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d04911744sm7983725eaf.12.2026.05.19.16.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 16:32:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [RFC PATCH v2 12/17] lib: getopt: Tidy up two minor redundancies
Date: Tue, 19 May 2026 17:31:38 -0600
Message-ID: <20260519233207.2765755-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519233207.2765755-1-sjg@chromium.org>
References: <20260519233207.2765755-1-sjg@chromium.org>
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

memcpy() already copies argv[argc] (the NULL terminator), so the
explicit gs->args[argc] = NULL after it does nothing. Drop it.

In the optional-argument branch, '*(curoptp + 1)' is already known
to be ':' by the preceding check, so the first half of the &&
is dead. Use curoptp[2] == ':' directly.

No functional change.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/getopt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/getopt.c b/lib/getopt.c
index 126427bb4ad..0179ae4d5ea 100644
--- a/lib/getopt.c
+++ b/lib/getopt.c
@@ -22,7 +22,6 @@ void getopt_init_state(struct getopt_state *gs, int argc, char *const argv[])
 
 	gs->argc = argc;
 	memcpy(gs->argv, argv, (argc + 1) * sizeof(*gs->argv));
-	gs->argv[argc] = NULL;
 	gs->index = 1;
 	gs->arg_index = 1;
 	gs->nonopts = 0;
@@ -107,7 +106,7 @@ int __getopt(struct getopt_state *gs, const char *optstring, bool silent)
 		return curopt;
 	}
 
-	if (*(curoptp + 1) && *(curoptp + 2) == ':') {
+	if (curoptp[2] == ':') {
 		/* optional argument */
 		if (argv[gs->index][gs->arg_index + 1]) {
 			/* optional argument with directly following arg */
-- 
2.43.0

