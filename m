Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240DCE7E638
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:21:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAB6786E92;
	Tue, 26 Sep 2023 16:16:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PqtxrcbX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16D3C86E24; Tue, 26 Sep 2023 16:16:03 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F34886E27
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:15:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-79f989480e0so272191839f.3
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737756; x=1696342556; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uEWCGBRjswkiM944lEOstW+kzsaSSKRcVK15+m62t18=;
 b=PqtxrcbXri4dDY+KvTwGhOfs+xs67p0fEvQlCre3lZ7lHmGFv1NjhRFACIhV5DiPrR
 oA1LAsNqZeXSYXi96fgO0Wfc6SuFNvUjhnUeo0FsqoOLnk0mNTCIldZ9WrCPoFWw3WsF
 fjo7li6AImPmPeGQ/N95iOXbv98fmhE/0KvhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737756; x=1696342556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uEWCGBRjswkiM944lEOstW+kzsaSSKRcVK15+m62t18=;
 b=MkbZfNa/gYuhU7Ya/utFRcxF/b7XulGlkHGYnYEGNHn/4RJyJKLUpjfylvsNQAhU6e
 SxiHoXc9L+eka16re3YGNa09ESPp04HNuEWq07s1gUyKnr6kz4f2iEJk7b3T11Ryb6g5
 CSVZ9ERVBxr0ibm//FsJ+5AQDPKv35CH6EjZsGv5dCsyfIDpBCvWkcehWuuH4DiO5MaM
 I0Y7ciw8rwYkY+zfXmP5k4zUo2ojoH81kWwmyEgKCjg4KYa0dzRM3YBax4wscW1IUFmu
 VCY1JRDhyNlWO2vZHYJatsxf+jBsXqJTJgGpmUk0h8BgN4WAHm0XHsHz0Eh2zz+Lb/EO
 vhNw==
X-Gm-Message-State: AOJu0YyHZeNt0rZPFtVNYpjEjoyNnAoRv8TmCo304nOvTqV/57BvnzxC
 uXekKbszVibNzyGuVitlHo3t/rKM+9Ehun5Vdqs=
X-Google-Smtp-Source: AGHT+IGXE/4hQfRsO77kW+qWeW5mNwMi7VTl10BbTBMYL8yfT1wvX//udoI9b2xmEt+0Yt1ULinzOg==
X-Received: by 2002:a5e:9419:0:b0:792:70c2:9db1 with SMTP id
 q25-20020a5e9419000000b0079270c29db1mr10578677ioj.1.1695737756209; 
 Tue, 26 Sep 2023 07:15:56 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:15:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v4 32/44] dm: core: Add tests for oftree_path()
Date: Tue, 26 Sep 2023 08:14:46 -0600
Message-ID: <20230926141514.2101787-33-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230926141514.2101787-1-sjg@chromium.org>
References: <20230926141514.2101787-1-sjg@chromium.org>
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
index e078a9755a83..a5bc43aea4e7 100644
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

