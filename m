Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6120EC83F15
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 18:09:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DBA9865A0;
	Wed, 30 Aug 2023 20:06:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TzwPFgvg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 232178652F; Wed, 30 Aug 2023 20:06:19 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43A02865A2
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:06:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-34deab8010dso91085ab.3
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 11:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693418759; x=1694023559; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K67sAl5Odn/HaNL2GTyk2qXS8EFoiuRALgPI6jzn0Hw=;
 b=TzwPFgvgNwbKILasNh6Jspwgm4vDKKMXHMqNBzWXidmCFfZxoXbPDbedL4gCq7psD1
 K/9/eCRfDHEC0oXVrxsF2s04E04K5KutgMxgqlEXgdWZpqsS4iZE3nJjnwz8NJNGePAd
 rXRkHubO8496Q8GADPTZhrhkrPTPXhOdpciXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693418759; x=1694023559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K67sAl5Odn/HaNL2GTyk2qXS8EFoiuRALgPI6jzn0Hw=;
 b=XpHyRycsLXg2Nup422rD7x8LklLN2+/Fm5sxcX3pr0bFuqu/gSIwplTeDgfX7ebC7t
 YbX0xg1VHQ1NCTK1iJcRBKXhPxbZe2xofwa2nI9SE5jshopicnOU9yK/efPLXbOqvEtT
 osHaTawEC8LIH5Pb5gOJT/eNLQqJbk0mwYVXJA0I3VTQjAWUlolHkiS5tA7WX7XjTJs8
 OYEN7/uOFfR4f0SafafdHB/tHobTRqkCa7/So0RiTsMAzDxc21GDOWPxfKfohaXhe7fi
 FUWu6+KM39xS1nF/5qAVCI6Dhi/mxhRjnMZTGfRJozfHhlWJSNubIIuo4hX/XbaCCMZD
 q18w==
X-Gm-Message-State: AOJu0YwSscN8uiaqRB8/K7mWaUc58h2iZHHHvA5PtCawCiyvzrqEbgB0
 4jPekTwMlTYEvQhPKaRtLsr4HH/FQeK1Ft2KfYQ=
X-Google-Smtp-Source: AGHT+IE1/eQVH32PIdLk8xxspBEUpJ4j/nESHkVN3XPeBInlkyIE19dVXYAqb1BB7gaqVkcaYOapbA==
X-Received: by 2002:a92:cc0d:0:b0:34a:c4ae:1937 with SMTP id
 s13-20020a92cc0d000000b0034ac4ae1937mr3166169ilp.13.1693418758915; 
 Wed, 30 Aug 2023 11:05:58 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 dk54-20020a0566384bf600b0042bbd3e49b9sm4002224jab.24.2023.08.30.11.05.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 11:05:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH 24/32] dm: core: Add tests for oftree_path()
Date: Wed, 30 Aug 2023 12:04:55 -0600
Message-ID: <20230830180524.315916-25-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230830180524.315916-1-sjg@chromium.org>
References: <20230830180524.315916-1-sjg@chromium.org>
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

 test/dm/ofnode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index 5e63efdfa89..af3aa1e2ec5 100644
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
2.42.0.rc2.253.gd59a3bf2b4-goog

