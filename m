Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D74DC3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 12:32:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 618B8888A7;
	Sun, 11 Aug 2024 14:29:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QN+CzXX4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91E6588842; Sun, 11 Aug 2024 14:29:49 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84BEC8884F
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 14:29:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-81f96ea9ff7so178483139f.3
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 05:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723379386; x=1723984186; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2WxjabOnhKA9kNLzK1GQo/Q7+nqFFbhd9O9lQKPoWvA=;
 b=QN+CzXX4KGYiDQAtNL19WxINjDSJ3T5e800EIxjbpmI+0ToRD5XS4cMV3GuvpIgoN2
 yhVtPtSLVSvF6XlTWoqsGR4jtT0pekQfbZSv8875wco2GVIN1j9zfSefpFEIxBcqtIX3
 6BAvxku6E+hyjdSx9xE6b5mR8ERYk4b+e8EJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723379386; x=1723984186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2WxjabOnhKA9kNLzK1GQo/Q7+nqFFbhd9O9lQKPoWvA=;
 b=PqTPEjCDBiPFfG+ZFnC9+TtzImeqKW/RZ5GtqdlXT562mnbnKlFPgL0wUfyGjyK0Q/
 QZyzh2SPZ4Jq/DxxBoyscnukAdbXz93wM1b/KXoitDXH0HyA9KKwFmKYmlc7hfEU1GdH
 LenYJdrEN3P1RUKwpguySd6vCU6kmz6si4locLJfe03SeAEerEqlNyq0nbEUsQS/lPXI
 04TZnlx9V+3ZRvhg2H/hGcfDbylAIaJJW2bA5a8RJydczu6V1NfBGndc3Mbd3GMzdfch
 Ifb3EhllE60oBjzM9Ncmb2mATfUke1hT+m/++K7Vn3rOa83D63k2Nxi7zmzv8j4Weal6
 f6Fg==
X-Gm-Message-State: AOJu0YwY8k9Z2sVvE5svyoY2NFi12TT+PFfD8W5rB+LuD+ig7dhAH2We
 f5ms/0M6ysTDgTLToba9ECsVBeCJ+cmU8v8/TyRz0O4udDbLKg3r6Ai8IiHZoEZ+r1HWn+XhIow
 =
X-Google-Smtp-Source: AGHT+IEs4+ADKqq35aVzaapoTylUGgX6wNfIZNe5Dijww+l+r/pyjXPMejXS5B1rIJMdYcMHi0X7TQ==
X-Received: by 2002:a05:6602:15d5:b0:81f:958d:f597 with SMTP id
 ca18e2360f4ac-8225ece1e97mr1033272639f.4.1723379386169; 
 Sun, 11 Aug 2024 05:29:46 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ca76940448sm1017935173.45.2024.08.11.05.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 05:29:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 15/15] blk: Correct comment for
 blk_get_devnum_by_uclass_idname()
Date: Sun, 11 Aug 2024 06:29:24 -0600
Message-Id: <20240811122924.4035982-16-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811122924.4035982-1-sjg@chromium.org>
References: <20240811122924.4035982-1-sjg@chromium.org>
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

Update the comment to match the function. Fix the indentation while we
are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

Changes in v3:
- Rebase to -next

 include/blk.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/blk.h b/include/blk.h
index 7c7cf7f2b10..1fc9a5b8471 100644
--- a/include/blk.h
+++ b/include/blk.h
@@ -650,7 +650,7 @@ struct blk_driver *blk_driver_lookup_type(int uclass_id);
 struct blk_desc *blk_get_devnum_by_uclass_id(enum uclass_id uclass_id, int devnum);
 
 /**
- * blk_get_devnum_by_uclass_id() - Get a block device by type name, and number
+ * blk_get_devnum_by_uclass_idname() - Get block device by type name and number
  *
  * This looks up the block device type based on @uclass_idname, then calls
  * blk_get_devnum_by_uclass_id().
@@ -660,7 +660,7 @@ struct blk_desc *blk_get_devnum_by_uclass_id(enum uclass_id uclass_id, int devnu
  * Return: point to block device descriptor, or NULL if not found
  */
 struct blk_desc *blk_get_devnum_by_uclass_idname(const char *uclass_idname,
-					    int devnum);
+						 int devnum);
 
 /**
  * blk_dselect_hwpart() - select a hardware partition
-- 
2.34.1

