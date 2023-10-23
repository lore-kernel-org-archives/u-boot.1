Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C2ECDB474
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 07:52:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B776B87884;
	Mon, 23 Oct 2023 09:52:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jzzSS/bt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC69A87892; Mon, 23 Oct 2023 09:52:56 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A44E187816
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 09:52:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c9de3f66e5so16133375ad.3
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 00:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698047573; x=1698652373; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fWXlRaSaJdJsMe8T/+enEElesIWQg87E8tbjWmz3QdY=;
 b=jzzSS/btqRKW+tOqPq4bFRNd8k8gbBvGV3mPBSsemF3eWZt/6zkN2rFJolBuB7wEwW
 PwtA1qBsgTMsaB6YExvPe5sl6U1e8W8I0vm/lBpbxxkPrrvuzLq00ETVvMJX2y6+uV56
 j4qhPnnudW1dFODXMPiNvANc+62OgBKyuXBpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698047573; x=1698652373;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fWXlRaSaJdJsMe8T/+enEElesIWQg87E8tbjWmz3QdY=;
 b=pwTlHQKDmACWHUi6gaMVVtut/1MbQ4mxnIiqmgVM5VKNv74NC1gbxi/i3+7wSR5d8T
 j64kMfHyr/u43JsYVtOa0idE5bSZ+/5ZUZ16IKDfrsDYHM+QVXTn1BVn/ZxbTQ3nWFCb
 p2U/lfBkaF7NXrR+JFksv6Evjq5Su8RcDXvo52j6B/k7Y49gj3SqXSeAD+thg8Jdkglj
 H7prjTiYvaP0IGqDkAX1Ebd2TEq2nFKURmsh7cYuYJrjAEu8WUSSy66n8ZI8GFWmdutG
 ImwHloMG+CfIzn7R/MZPKKOPztsatD0qTq5JBDaDhWw3xIy+mAfDS+OTUH/5kooZvupV
 l+oQ==
X-Gm-Message-State: AOJu0YxE1tBDgVZUM3NrhsLy3Oq5YxK9m8QjapFtvK5w9IGBI1Zwd0AL
 jW5rVULh+7vNQwYzzyWC/OYTEsQbstcbDY7R+Oa10Q==
X-Google-Smtp-Source: AGHT+IFQJQ78eSHOf9AfbBc1xpsXYBTFZHDITTS3XhNLHd8bWQk4gF4xdFtjmfG80yjkteAYHBq3dA==
X-Received: by 2002:a17:903:2092:b0:1c0:aca0:8c44 with SMTP id
 d18-20020a170903209200b001c0aca08c44mr5426724plc.19.1698047572750; 
 Mon, 23 Oct 2023 00:52:52 -0700 (PDT)
Received: from sjg1.roam.corp.google.com ([202.144.206.130])
 by smtp.gmail.com with ESMTPSA id
 e6-20020a170902d38600b001c62c9d7289sm5409437pld.104.2023.10.23.00.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 00:52:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH] buildman: Include symbols in the read-only data section
Date: Mon, 23 Oct 2023 00:52:43 -0700
Message-ID: <20231023005242.1.I573d6fb6587a8fbba2ae3783a42c4587ed6572d4@changeid>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
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

When symbols switch between the inited data section and the read-only
data section their visbility changes, at present, with the -B option.

This is confusing, since adding 'const' to a variable declaration can
make it look like a significant improvement in bloat. But in fact
nothing has changed.

Add 'r' to the list of symbols types that are recorded, to correct this
problem. Add a constant to make it easier to find this code next time.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/buildman/builder.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/buildman/builder.py b/tools/buildman/builder.py
index 5305477c5be6..3e42c987d1cd 100644
--- a/tools/buildman/builder.py
+++ b/tools/buildman/builder.py
@@ -35,6 +35,10 @@ from u_boot_pylib.terminal import tprint
 # which indicates that BREAK_ME has an empty default
 RE_NO_DEFAULT = re.compile(b'\((\w+)\) \[] \(NEW\)')
 
+# Symbol types which appear in the bloat feature (-B). Others are silently
+# dropped when reading in the 'nm' output
+NM_SYMBOL_TYPES = 'tTdDbBr'
+
 """
 Theory of Operation
 
@@ -693,7 +697,7 @@ class Builder:
             parts = line.split()
             if line and len(parts) == 3:
                     size, type, name = line.split()
-                    if type in 'tTdDbB':
+                    if type in NM_SYMBOL_TYPES:
                         # function names begin with '.' on 64-bit powerpc
                         if '.' in name[1:]:
                             name = 'static.' + name.split('.')[0]
-- 
2.42.0.655.g421f12c284-goog

