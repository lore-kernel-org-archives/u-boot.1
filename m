Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4847CE7A8C
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 19:28:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1493586BF4;
	Sun, 24 Sep 2023 21:26:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M40RLJT3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C46186B34; Sun, 24 Sep 2023 21:26:18 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B670386ACA
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 21:26:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-79f96f83270so152802339f.1
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 12:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695583567; x=1696188367; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YQa9pnbD3nCd36s3/jUF5qJpCKnMoZ9NJQsmh8d5MU8=;
 b=M40RLJT3+u2DHNNOEFhC5q72K+kZ2QVWJK13khCMYjLw488Kv/pY/8NUM3fjfznFSh
 1mk1lLYm616gfza/LHjwu2IV9FUnC6rwAs/EwPvI2AUEdx1lFY9o9uFkXvby7NdW1G0v
 w8YUlcwi3GKaXDRth7l4Ih98i7FfZe4ErCn50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695583567; x=1696188367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YQa9pnbD3nCd36s3/jUF5qJpCKnMoZ9NJQsmh8d5MU8=;
 b=g/bmnvWXrGOMJsiLhHMdC6nSXHk4G3xZuhEg570uc4sOXRujKrQ6RU5R1AD+GxO5oC
 6k5plRDrRqsKJkJa56kRwMk2T+cVyojDjBoi1/FvQZH4dYOO5xW8fpPYTa7Jy7x05MA4
 IuLuksd+pbrgJa6qqO/0hTxCSvBeDIXgSg9uxM7uVZ8XCZuhLtaCTlA9U/oKRzDjaNB+
 ixjRbnB6/xpvCznauuZWGeCkPHwoC2H8nqvE+yQqh0qvFzJmEkqZ/zAj01p2v+sJ8g9d
 Qqp8u6a+iKYUK4EV1F2JXT7RPLaxen/fBO5fqbbaogBGmPP6Mc6FebY22jXCgqrIAKJ6
 VjiQ==
X-Gm-Message-State: AOJu0YxDrADP/VJJVhkOE5aYh3bNvGScVSGSHJX+9UPyMIBA6ns+uct3
 PtEzJJO6KcjEwiaB5B6c0vU9SKeHW1jnWFjHYzY=
X-Google-Smtp-Source: AGHT+IHfq/saK+QNiKK7aicSqufHpNF5wlQikLUi/fnwRBpIGrfHdZqDJgtieQHrzA5CtAXCOkBuWA==
X-Received: by 2002:a05:6602:19d4:b0:792:9a3e:2dd with SMTP id
 ba20-20020a05660219d400b007929a3e02ddmr5759812iob.3.1695583567403; 
 Sun, 24 Sep 2023 12:26:07 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 do25-20020a0566384c9900b0043a11ec6517sm2321702jab.171.2023.09.24.12.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 12:26:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v3 20/38] spl: Move bloblist writing until the image is known
Date: Sun, 24 Sep 2023 13:25:05 -0600
Message-ID: <20230924192536.1812799-21-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924192536.1812799-1-sjg@chromium.org>
References: <20230924192536.1812799-1-sjg@chromium.org>
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

(no changes since v1)

 common/spl/spl.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index f3cbd6cef8a7..f7608f14e365 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -728,18 +728,6 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
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
@@ -786,6 +774,18 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
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
2.42.0.515.g380fc7ccd1-goog

