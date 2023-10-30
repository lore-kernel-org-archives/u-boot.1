Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC5CC4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 17:22:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17D29879DA;
	Mon, 30 Oct 2023 18:22:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dg6z88nN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AABE68725E; Mon, 30 Oct 2023 18:22:51 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1ACE8879DA
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 18:22:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1cc3bb32b5dso16068735ad.3
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 10:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698686565; x=1699291365; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t028Ex1cuKHPwgwhPanSyfhSs4o+7za7KsoKDo9XVfc=;
 b=Dg6z88nNPKNyHIEtGnc3RpPnwavUI4JuWip5FX6EHzlVN2W6Umo2HZ6qj63xpcAaqo
 uzjYnvml1yMDrRc95x6E2Ylw+tFwjvMuH7foIksTKomxHTCNFWPnnZnxVpuD5/7jTzBC
 44Gc2cYEocAYeWFf2E6eo+Qh1dXaITEC52ZwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698686565; x=1699291365;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t028Ex1cuKHPwgwhPanSyfhSs4o+7za7KsoKDo9XVfc=;
 b=iH3FdGtsDOhNmGfOBiHH0OGA1HIJcNjTifHTORfe+h50ReIZXc2i8aCmA4MsA7+vxt
 BZ0OXFARD9PE2pEMgQr/AivlsWLMeC6BJt83RIHyH3Lspqo/p/RCGWQL3zq8+DLOIR3S
 ntdQ5zon82yDzw0oEt8r3Y2KtXC3cGtQ7Cg9TnHi39NZCIcWiEcfPCRIUyB47t+viIOK
 LAIxnhxbaBUWyBb+8Z6LrqzVpZc4AARziGfJKw9RcPXpe1Op6JkF2j1T0n92UoE++aO7
 k52LspCN1RvhhIsrkOc/FkZGdu5rIzfBx0rTa7JameYPV6qgWOPwDpO9wlQj7gZebKoM
 Altw==
X-Gm-Message-State: AOJu0YxsKgSTNk4tKDGIk7gWJtRmcCHkw+1+REB6XZRk0yZXHUnHrl4a
 FbvbJJv8lNfZNaut3rbukZ62SvgDMrvtz0aW9+b0PvYN
X-Google-Smtp-Source: AGHT+IEcYsMgF2i9kCUu+q91ukmoMnPYlQq41Nbg0sKQwXLACXvs5O5bl/URrdiNpZyLszfO8oSllw==
X-Received: by 2002:a17:902:da86:b0:1cc:4091:264f with SMTP id
 j6-20020a170902da8600b001cc4091264fmr6342915plx.14.1698686565254; 
 Mon, 30 Oct 2023 10:22:45 -0700 (PDT)
Received: from sjg1.united_club.lax.united.com
 ([2607:fb91:ac3:c7a8:5fcd:fc58:388:b3e1])
 by smtp.gmail.com with ESMTPSA id
 c5-20020a170902724500b001c46d04d001sm6535073pll.87.2023.10.30.10.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 10:22:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH] buildman: Support upstream branch name containing /
Date: Mon, 30 Oct 2023 10:22:30 -0700
Message-ID: <20231030172234.867888-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
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

Buildman assumes that branch names do not have a slash in them, since
slash is used to delimit remotes, etc. This means that a branch called
'WIP/tryme' in remote dm ends up being 'tryme'.

Adjust the logic a little, to try to accommodate this.

For now, no tests are added for this behaviour.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/gitutil.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/patman/gitutil.py b/tools/patman/gitutil.py
index b0a12f2e8c06..10ea5ff39f5c 100644
--- a/tools/patman/gitutil.py
+++ b/tools/patman/gitutil.py
@@ -147,8 +147,9 @@ def get_upstream(git_dir, branch):
     if remote == '.':
         return merge, None
     elif remote and merge:
-        leaf = merge.split('/')[-1]
-        return '%s/%s' % (remote, leaf), None
+        # Drop the initial refs/heads from merge
+        leaf = merge.split('/', maxsplit=2)[2:]
+        return '%s/%s' % (remote, '/'.join(leaf)), None
     else:
         raise ValueError("Cannot determine upstream branch for branch "
                          "'%s' remote='%s', merge='%s'"
-- 
2.42.0.820.g83a721a137-goog

