Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF54CD4938
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 02:01:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE55C86DF7;
	Thu, 21 Sep 2023 03:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XN0mOqcQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A99786DC6; Thu, 21 Sep 2023 03:58:22 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 663F286DC9
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:58:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-34f6ce577a4so1451985ab.3
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695261489; x=1695866289; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hjaubQO/fwulSBL9KO5+zKARWu2DFDFm6g9uJG/EBIg=;
 b=XN0mOqcQITYjwllVyUBvpoxEcGOjuxRq1RWeOircSHv1DflaxJ9JExl71kpEsCC17L
 F0dUtVnUruYVFs4Dx5v7xw1VwF7C8ds4cUjC78ZrFNdIk+zna5c2O9cJb19qRz3oEG9M
 7oS7LFJ3dVd+BiqLBFDSzWlyVY87n3JQ8ntMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695261489; x=1695866289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hjaubQO/fwulSBL9KO5+zKARWu2DFDFm6g9uJG/EBIg=;
 b=DXW6C7bRS2s8aJpzPHBPXOpkfAIzM0oNGvcJ1qywHPgdthB7fXNn2yuD/LhY/TCQ5D
 AMuph3oO4p4ZnzML19wdXkRFti5cN9fXN3SeFvXxQVdOu4DUWFdo3DrxCDulMx2AuHp2
 usviJoj58T2ADwyitFryRUCyGpMd7dQm0z7B6mfDRrL1C83gHqGICL7zmgSejbxRJYFO
 6eCjDeX5EhWUrIrtTgT0bsCxaIzhrs4SKqhRaZUTwcArWgXZsNU3V79Ek4jNaXfZN9Tj
 FXqbWytKVoHVT72xYeL32qWFIMhl0c6sRu2mY79ulrZL5i2rQKOi4Hhi8vV7BY8csm/H
 pnWw==
X-Gm-Message-State: AOJu0YxUTivRjk5b6HO7nCQ0N5I1S4AfNbhNtb3R1iNTm+VG4Qww1oLC
 n1UV9aimkXGDQhREsqtlnkjG4evpqyku50ZsXbI=
X-Google-Smtp-Source: AGHT+IFSSIG6P+PjpOXg+6JoJK/kkkcFz4/OT3pBbnbLMmxGmRnyNdo8VDSP9JFplyv8YWbMAdBUvA==
X-Received: by 2002:a92:c5a7:0:b0:348:fe3b:c8b with SMTP id
 r7-20020a92c5a7000000b00348fe3b0c8bmr4104263ilt.1.1695261489079; 
 Wed, 20 Sep 2023 18:58:09 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 y4-20020a02c004000000b00437c3a7b49dsm85317jai.156.2023.09.20.18.58.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 18:58:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v2 24/32] dm: core: Add tests for oftree_path()
Date: Wed, 20 Sep 2023 19:57:13 -0600
Message-ID: <20230921015730.1511373-25-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230921015730.1511373-1-sjg@chromium.org>
References: <20230921015730.1511373-1-sjg@chromium.org>
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

Add a few simple tests for getting the root node, since this is handled
as a special case in the implementation.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/dm/ofnode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index 5e63efdfa891..af3aa1e2ec51 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -228,6 +228,9 @@ static int dm_test_ofnode_read(struct unit_test_state *uts)
 	ofnode node;
 	int size;
 
+	node = oftree_path(oftree_default(), "/");
+	ut_assert(ofnode_valid(node));
+
 	node = ofnode_path("/a-test");
 	ut_assert(ofnode_valid(node));
 
@@ -256,6 +259,9 @@ static int dm_test_ofnode_read_ot(struct unit_test_state *uts)
 	ofnode node;
 	int size;
 
+	node = oftree_path(otree, "/");
+	ut_assert(ofnode_valid(node));
+
 	node = oftree_path(otree, "/node/subnode");
 	ut_assert(ofnode_valid(node));
 
-- 
2.42.0.515.g380fc7ccd1-goog

