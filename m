Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CEFDC6FA8F
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 18:07:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2473866AA;
	Wed, 30 Aug 2023 20:06:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mjuHuA+/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BC65865B0; Wed, 30 Aug 2023 20:06:02 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60DEA8653F
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:05:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-792965813e7so2082139f.2
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 11:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693418750; x=1694023550; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Yd/GWTtXbvSN+2WFZm1/X3sfWfEMCFEHTsyzmhE0G0=;
 b=mjuHuA+/mcPuQ5sTgGfWiXDqpTfU7jkJIjj6tGn3gBAjdsd/3LA3UOaWRGHzmJXpU7
 4kq49cpoZAb/17+bfJ1OzpYh4twS0JDs/Me7G5BSJtzP4hT1wlgnytumCOQguGy8jRkQ
 6COmlzlVFYUjLN7xtthVxSkluKgXpf+foW9Uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693418750; x=1694023550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Yd/GWTtXbvSN+2WFZm1/X3sfWfEMCFEHTsyzmhE0G0=;
 b=cIxyY0RKljVN0h+n07M9qqfNn2TfT4ip4d5W7865O/j78Yc7VI1w9yl4nZHW8UznFR
 4emX9WAcNj1eFyQRSzj3wXapJOgqawNH9wrbYE5DpaspPzXW7ly8GXtLCqbnx1DnbGxZ
 WOAOE8MCsAqFPonxawJSotLuKR3futsgmeHxTnMjoCE5Ta+rn1yBd8p6OtvtN8MOZpZZ
 ZVXAeJTaYt+rbo5a7V9DNrcFOPfrhdQq8DZROFGUwwILhnPrDygb2NMc4d282TfyQMW6
 wMw11ASkD4DUwSS4qXM7EMfMh6dueqK8eq3nLPeX8WogvFuNyLvKBd83bs5fyXc3xpCo
 oh2Q==
X-Gm-Message-State: AOJu0YzvHBVXhC1/asWcyy1mOOaWht2kg4AcMZx1Q72/C5UbCtdubJaC
 mefmBy9OWDP+Lk6ZtijprU4q5/76kYX4LumDoWk=
X-Google-Smtp-Source: AGHT+IGOAgYdq8J8t346xmc9W7sKaBjqJNv2ceoKMvdRbCxB25Zm6uvB/eWrKM+TettvGNpi7U5aYQ==
X-Received: by 2002:a6b:4f19:0:b0:792:792e:6619 with SMTP id
 d25-20020a6b4f19000000b00792792e6619mr3266649iob.2.1693418750071; 
 Wed, 30 Aug 2023 11:05:50 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 dk54-20020a0566384bf600b0042bbd3e49b9sm4002224jab.24.2023.08.30.11.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 11:05:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH 14/32] spl: Move bloblist writing until the image is known
Date: Wed, 30 Aug 2023 12:04:45 -0600
Message-ID: <20230830180524.315916-15-sjg@chromium.org>
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

The bloblist should not be finalised until the image is fully set up.
This allows any final handoff information to be included in the bloblist.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/spl/spl.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 8f87a27e61f..0a9fea4f22d 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -735,18 +735,6 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	}
 
 	spl_perform_fixups(&spl_image);
-	if (CONFIG_IS_ENABLED(HANDOFF)) {
-		ret = write_spl_handoff();
-		if (ret)
-			printf(SPL_TPL_PROMPT
-			       "SPL hand-off write failed (err=%d)\n", ret);
-	}
-	if (CONFIG_IS_ENABLED(BLOBLIST)) {
-		ret = bloblist_finish();
-		if (ret)
-			printf("Warning: Failed to finish bloblist (ret=%d)\n",
-			       ret);
-	}
 
 	os = spl_image.os;
 	if (os == IH_OS_U_BOOT) {
@@ -798,6 +786,18 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 				       dev->name, rc);
 		}
 	}
+	if (CONFIG_IS_ENABLED(HANDOFF)) {
+		ret = write_spl_handoff();
+		if (ret)
+			printf(SPL_TPL_PROMPT
+			       "SPL hand-off write failed (err=%d)\n", ret);
+	}
+	if (CONFIG_IS_ENABLED(BLOBLIST)) {
+		ret = bloblist_finish();
+		if (ret)
+			printf("Warning: Failed to finish bloblist (ret=%d)\n",
+			       ret);
+	}
 
 	spl_board_prepare_for_boot();
 	jump_to_image_no_args(&spl_image);
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

