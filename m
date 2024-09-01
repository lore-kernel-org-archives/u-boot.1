Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691C5C54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 22:31:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DAB188D00;
	Mon,  2 Sep 2024 00:27:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YX455FNv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5715588CF0; Mon,  2 Sep 2024 00:27:45 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 460CA88C6F
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 00:27:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-82a29c11e1cso96779139f.0
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 15:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725229662; x=1725834462; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NPAF2nLwjKC+d0g3i9v8MJHl+yMPd3SfKKRJ5ABrVC0=;
 b=YX455FNv7eO73aYUbqJWZ813qhcDWjKmz96UYIlOKs/4H+Zd1R0CQLDikaS1GJ8bWF
 2n0UdTdkisT7wY+scR2PNkeencF0FbemiC8nVicMKW560T+Nyc0yL6ZuIXlZUqnR55Ti
 DkZ33niEm7GZtFqR1o3YK6jfNJjLL/tLhtwzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725229662; x=1725834462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NPAF2nLwjKC+d0g3i9v8MJHl+yMPd3SfKKRJ5ABrVC0=;
 b=hJe+JebaWThLtMSGVpbOXd+GrMWkxGMoTnMVmDxfuV2bl57HTE2L9NXnwN3+qAlGhv
 YMqJxNhrv3hY4KI65pzsBHaHQZHtOr/sxcj9NHyuY+WddeOilzZR9bsGS5iLwwyPZ2xJ
 uD6sSF6tgqGog18Kt3JiEDSDdbKZU8aWF5nwKBgrisNn16N52LVZC5LPsfi6ZfDYhko+
 2xYfFOWcBztWMVzMvjnyOMjkoJ62Q+9jdewGTWG8uqZfVJWidvcKLsToO+62F2v7+qUo
 0PXV+7MmT4r5sPvUoCFg3RlmdVhmWublU4/7IrberrB1+mAV5HGTwQH96ZkBJOYQYLec
 /Tug==
X-Gm-Message-State: AOJu0YzMdarP1WnyEIjIOnMJdxPGjF7NujTSaVo0nT0hapre0jGAiv0c
 VRLTkeZ7D6bv+N2CfaKwgP2HGR36bYoSU3KhFILJRf0exOjcOwg4qUpnnzel5rDUsK/+sQv1EpY
 =
X-Google-Smtp-Source: AGHT+IFrJOQ8dlEBq/FLVXDUOmTxPStTjHizpCjv4BbbmRFnk3xa4jrlY4AWwEyU9ngtJX4nzCoiZQ==
X-Received: by 2002:a05:6602:14cb:b0:82a:268d:8333 with SMTP id
 ca18e2360f4ac-82a3429743dmr755633839f.10.1725229661732; 
 Sun, 01 Sep 2024 15:27:41 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ced2e17bb4sm1866981173.82.2024.09.01.15.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 15:27:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 1/8] blk: Make functions available unconditionally
Date: Sun,  1 Sep 2024 16:27:27 -0600
Message-Id: <20240901222734.462334-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901222734.462334-1-sjg@chromium.org>
References: <20240901222734.462334-1-sjg@chromium.org>
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
index 1fc9a5b8471..eef6c8629e8 100644
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

