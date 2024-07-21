Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3F3C3DA5D
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 15:28:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45F4188315;
	Sun, 21 Jul 2024 17:26:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ccMLCfFT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C54A0882B7; Sun, 21 Jul 2024 17:26:50 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0F6B87B8D
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 17:26:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3686b554cfcso1457602f8f.1
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 08:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721575608; x=1722180408; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rzd/tgKw3U4nnCuTmybuY2hn9Pea92hD50jy03Xtyqg=;
 b=ccMLCfFT8EadwWpP1KNCq82bBQeWN7IbMPiHqbv5inTIjTgIXJ0pluPjSXSNKvcEmO
 cSYQsWZibIox4oTRnXp2/7QnE8qlW6ODSfLqrjE6+5Zd9TtOWd97TyJY0ohP1tbya3xi
 0jKx7y8qtxpCkQCPetoFkBUYNElGzTFHdfkjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721575608; x=1722180408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rzd/tgKw3U4nnCuTmybuY2hn9Pea92hD50jy03Xtyqg=;
 b=Boo+CXTBSig4baFNDKKI2s1r81d/RRgE6ABWdINFKxQVmbg24LXv1++3P/8HaoIWLA
 YIfem7CU2fuLZT1oiv1i87U6FWUmD1kH9vrLcuRWy3FY6yjp3qlEiiCL4tVm1N2CpKPi
 K2CBMD/nQdewySPuKGJqDqV0wIrikijhU7ZYjSuB1eb69RAPDFccxWUZb8bC8Foy6ax7
 W9WpJohkNVRDx4KmWWK4N2UvdKr3DF/jRF6w3aCNOIApAAVfAGVqpmoGpZb61jeI+OpE
 z/Np/sNrA0bxYrYxrER2tJRgbbRGTl+xTQUh1dYmoC3weJ4j0Iq9C934RDgdCvanCupT
 mxew==
X-Gm-Message-State: AOJu0YzasuYLRxSGpfVBnlxthr9Fl7q+SpmJdUibCtV8ONiYGBP9CpGf
 00c2UNvazfJWMOaytP/ekR4xtEe3nvVPuVP2YGjYPI/kN62RGrIPrHE93TI4QBI9QXrQjMrTadg
 =
X-Google-Smtp-Source: AGHT+IEOAMVmpGK8uqPYEs+Y6uaC7xlnzI+6sPSxOLRwvFxjN5ef2QDNuS/5WJDS8efRk38A8umWSg==
X-Received: by 2002:a5d:5043:0:b0:367:8a9e:6bed with SMTP id
 ffacd0b85a97d-369bbcb9f70mr2866696f8f.61.1721575608199; 
 Sun, 21 Jul 2024 08:26:48 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427e5803bb0sm8702255e9.45.2024.07.21.08.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 08:26:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 14/14] blk: Correct comment for
 blk_get_devnum_by_uclass_idname()
Date: Sun, 21 Jul 2024 16:25:59 +0100
Message-Id: <20240721152600.3212917-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721152600.3212917-1-sjg@chromium.org>
References: <20240721152600.3212917-1-sjg@chromium.org>
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
---

(no changes since v1)

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

