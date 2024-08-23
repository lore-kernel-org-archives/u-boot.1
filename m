Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D6CC531DC
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 20:48:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60B7088B36;
	Fri, 23 Aug 2024 22:48:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DwqsOXYu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3D4388C53; Fri, 23 Aug 2024 22:48:42 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4CEA88915
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 22:48:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-39d22965434so11300215ab.0
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 13:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724446119; x=1725050919; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hc+1pDb3T997e3xWxn6N4GlwPK2NzA4NIJcJfzVUClY=;
 b=DwqsOXYuzrrCP+QDqrc1i9xEbTleqMIwaRUEWHFmywJ4SarZbxZg7GpQSIurYNLiIn
 8kjX4zk0iC9RZVTCA3JlLqKP9CBuaeHf0JTjx+L9X3wiQ9d5/K6CbtGC/ZSQxsjA8ZEZ
 xulRpwhL5ViKXF15nwVaG/rpnjK5Ld60EQWmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724446119; x=1725050919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hc+1pDb3T997e3xWxn6N4GlwPK2NzA4NIJcJfzVUClY=;
 b=XilVDKgmnoOrKWxg5byZNIRoZd20Lvj026cihoybAYFH+uyspE72LW4pVqQB2SLzr2
 Axdf7vZ1mCjgYIZXGgIc2FuCYuPPDYTq7hNXdNazMOXqkUxLZhMTPQGRfSKBhU28nhcU
 PFkPFmP6Piq3HYR+XiWgVsh8kLG89QFniJJdJEqWjV3Q4WwuBZz7Vln2MdAzJj8jMwnK
 2lYaXLs5kx1jczl3STZ5Yg6fLZwDIP4mCmQiEAgYOR9vnpra5/kyNWTdRQy+h9VFIgih
 afyuIV9JQMtsSJhrKIuoiD7G2U2v1u9o9AsSBVRYTMTEloP9Wjfy5nW0maGge790/SL8
 VB6Q==
X-Gm-Message-State: AOJu0YyTAoAVLDCvQU/1YzjwJhpRXaHIyEMRgxHUhwOgvkxurK5VaHbY
 n2BrxFo7Fu7QL+6bi/G13PWoi3AjjcygXPDaVcnZm/RAmGVqIPM+qirHBMYTBXYc+NHe2JN9Xg0
 =
X-Google-Smtp-Source: AGHT+IHRuG8EePTroxbWebgTuusMjwzbM/NwWzw0nk0yI98soT5oQdQaLVmn3Z6yyWWw0I4xFdpsrQ==
X-Received: by 2002:a05:6e02:152b:b0:39b:35d8:dc37 with SMTP id
 e9e14a558f8ab-39e3bf5175emr31997465ab.13.1724446119232; 
 Fri, 23 Aug 2024 13:48:39 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e67addsm15698375ab.4.2024.08.23.13.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 13:48:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng@tinylab.org>, Johan Jonker <jbx6244@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2 1/8] blk: Make functions available unconditionally
Date: Fri, 23 Aug 2024 14:48:17 -0600
Message-Id: <20240823204824.443631-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823204824.443631-1-sjg@chromium.org>
References: <20240823204824.443631-1-sjg@chromium.org>
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

Some boards still don't enable BLK but we want to be able to at least
compile the code which relies on this. For example, bootstd includes
calls to blk_...() functions, albeit with a check for BLK so that the
code is eliminated by the compiler.

Reduce the scope of the BLK #ifdef to help with this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/blk.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/blk.h b/include/blk.h
index 7c7cf7f2b10..a4aa7dd34df 100644
--- a/include/blk.h
+++ b/include/blk.h
@@ -197,7 +197,6 @@ static inline void blkcache_free(void) {}
 
 #endif
 
-#if CONFIG_IS_ENABLED(BLK)
 struct udevice;
 
 /* Operations on block devices */
@@ -278,6 +277,8 @@ struct blk_ops {
 #endif	/* CONFIG_BOUNCE_BUFFER */
 };
 
+#if CONFIG_IS_ENABLED(BLK)
+
 /*
  * These functions should take struct udevice instead of struct blk_desc,
  * but this is convenient for migration to driver model. Add a 'd' prefix
@@ -291,6 +292,8 @@ unsigned long blk_dwrite(struct blk_desc *block_dev, lbaint_t start,
 unsigned long blk_derase(struct blk_desc *block_dev, lbaint_t start,
 			 lbaint_t blkcnt);
 
+#endif /* BLK */
+
 /**
  * blk_read() - Read from a block device
  *
@@ -528,8 +531,10 @@ struct blk_desc *blk_get_by_device(struct udevice *dev);
  */
 int blk_get_desc(enum uclass_id uclass_id, int devnum, struct blk_desc **descp);
 
-#else
+#if !CONFIG_IS_ENABLED(BLK)
+
 #include <errno.h>
+
 /*
  * These functions should take struct udevice instead of struct blk_desc,
  * but this is convenient for migration to driver model. Add a 'd' prefix
-- 
2.34.1

