Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8153BC52D7C
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 13:58:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C80E988B70;
	Thu, 22 Aug 2024 15:55:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DjhEeXKg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB0CD88498; Thu, 22 Aug 2024 15:55:42 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99E0A88AA7
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 15:55:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-39d3c8bc608so3049185ab.0
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 06:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724334939; x=1724939739; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=To42jIVg3zXBUu1G3ZCzRZJWrJ+x+9yBpUHhFtFL9yc=;
 b=DjhEeXKgWGrbVFrZ3fDFReVd7cZof+Co/iDNdHvFtHYd16dxxcTj0H7cvUq8fDQW86
 ZqQtplDggJUIG1s28MpemhaLVWjJycZswLOAThdsDQFzruPfhV7QysenNE8S1oTlw6rf
 cJmCy0bvjM8jXnnm9w1PjLMR6nBaWEVC9NCMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724334939; x=1724939739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=To42jIVg3zXBUu1G3ZCzRZJWrJ+x+9yBpUHhFtFL9yc=;
 b=JeLaueOZu/QIDE7vQ7+/6UcqHeQKQwlnpOEQn2hrgL97XN1bb2Ml8KH2XB1lDMhLG7
 uPRJKOV13jNX7hJ8rW5JwGD7yD+UNplQSBGgNDsEyxjRfz1/ACBIHuSBeMfDx/MdE42/
 bcT1LvN5GWWVFG+ryrbpw2+212Q3FuisU73QqwVCr+UCRIB69aZQHSIXimsglgaHEbux
 qA8z6EbJdMHd9TbWNtG1NwBsipRKCtNpnsQFPXLmVd4pWZDt5Kf9FkcRteJCVdvrLbGN
 fnBuxQO1f6VQTPkCEwbfwQVh+rff2J8vq13rs87lVrSHKFbbV/1XGM0tWnhnsi4ecLS8
 oF5A==
X-Gm-Message-State: AOJu0Yz7a/TPemSVWH9ocvpyRduzANQzNuDX7YpK9jbCzASlmcBugQpR
 gctiy1SIp1hzRvLOcnyPkESqoEbZr8/yz6IhY55cc70yaQPs03k+5yn1fg/1HWO7E9/01KQnSso
 =
X-Google-Smtp-Source: AGHT+IGCt5OtwE8ZgA5+lbac5GAcYi/wgM9xC/2TseTgryl4+A7j27fyDvp+h4j007tUbSfuWpaFBQ==
X-Received: by 2002:a05:6e02:1a66:b0:39d:46f6:b92e with SMTP id
 e9e14a558f8ab-39d74b60d17mr23265985ab.11.1724334939199; 
 Thu, 22 Aug 2024 06:55:39 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e7c1eesm6692585ab.39.2024.08.22.06.55.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 06:55:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v4 14/14] blk: Correct comment for
 blk_get_devnum_by_uclass_idname()
Date: Thu, 22 Aug 2024 07:55:03 -0600
Message-Id: <20240822135503.2363706-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822135503.2363706-1-sjg@chromium.org>
References: <20240822135503.2363706-1-sjg@chromium.org>
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

Changes in v4:
- Drop defconfig-resync patch

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

