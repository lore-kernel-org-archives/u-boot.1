Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35BCDCE79A9
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 02:06:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33E3086BA0;
	Wed, 20 Sep 2023 04:06:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GZs0J4SX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F1D786B20; Wed, 20 Sep 2023 04:06:06 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A861B86B7A
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 04:06:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-79277cfc73bso243227939f.1
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 19:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695175562; x=1695780362; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kb8QLZ68SymXDLY2P+VOxLU5nCH0Ih5KM0v1kMXvMJc=;
 b=GZs0J4SXuJBxiDm5K3k8niSHbeg7Vv2ZPFI6muGA2BtO/751sKA5zRAVnUBueb7rBN
 Gtv24hpcX+iZqo3UWUG5AyD7MB+QVhuTXs+5TsaJyNP/zfSxerfqbk+UG6wrmXKOROfS
 BFG9o68e6klMLDqGjT4vbPkXFqi6Fc2CQDJzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695175562; x=1695780362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kb8QLZ68SymXDLY2P+VOxLU5nCH0Ih5KM0v1kMXvMJc=;
 b=bC5npUoJbIM7Y4eOHC2/UigHysoqWhG6LoEnpN0lrdJA60c9tQj0lVcHOgSf2V6DTs
 CbDjqkO1uQ7i2teEDfh9LN7rvvtuVU1IKUXJkjHHkReCB6j0WbKo+amfm5TWWgLrpCK7
 YUZRQAP7LxKABP1s4d2PZdSkpyPChRPmDOo7U0s0GnVj1qQ5vnIE8QWm3hbMW6b3+cDl
 GAs/WjkTNb1hKUaNlHyPiZe2NH+V50rUOp4tfxXJInkF0xDEPPKpNHCjoOpiay5zkzt6
 xoL3UUi00++l5VPoqAGJWN9c8GSORVTxqzEx9Tdfz2TRd4nFxP1Vje2DADyFX1eIjk9e
 S6vw==
X-Gm-Message-State: AOJu0YyAJS2dF/H6X3Dyh28FyTzssXL4vnTPzx5QYNaLPcH50UbIhzgo
 O+vj3PGum7ML4Njr0eR7twifzcUos8M6YSUU0JQ=
X-Google-Smtp-Source: AGHT+IG05qGdnmFNyAqwMBJamuAUj6nR8lCDBcjORAWI8Dqn42EBRbJAUsfWSbQ0yGRY7Le/phBOhw==
X-Received: by 2002:a05:6e02:e11:b0:34f:fdbd:244a with SMTP id
 a17-20020a056e020e1100b0034ffdbd244amr1316119ilk.32.1695175562338; 
 Tue, 19 Sep 2023 19:06:02 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 h6-20020a02c726000000b0042b3a328ee0sm3820576jao.166.2023.09.19.19.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 19:06:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH 2/2] dm: core: Adjust dump-sorting to get stats only when
 needed
Date: Tue, 19 Sep 2023 20:05:48 -0600
Message-ID: <20230920020558.1373955-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230920020558.1373955-1-sjg@chromium.org>
References: <20230920020558.1373955-1-sjg@chromium.org>
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

If we are not sorting the tree we don't need to get the stats. Adjust the
code to avoid the wasted time.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/core/dump.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/core/dump.c b/drivers/core/dump.c
index 3e77832a3a00..bf95c0f52379 100644
--- a/drivers/core/dump.c
+++ b/drivers/core/dump.c
@@ -91,14 +91,14 @@ void dm_dump_tree(bool sort)
 
 	root = dm_root();
 	if (root) {
-		int dev_count, uclasses;
 		struct udevice **devs = NULL;
 
-		dm_get_stats(&dev_count, &uclasses);
-
 		printf(" Class     Index  Probed  Driver                Name\n");
 		printf("-----------------------------------------------------------\n");
 		if (sort) {
+			int dev_count, uclasses;
+
+			dm_get_stats(&dev_count, &uclasses);
 			devs = calloc(dev_count, sizeof(struct udevice *));
 			if (!devs) {
 				printf("(out of memory)\n");
-- 
2.42.0.459.ge4e396fd5e-goog

