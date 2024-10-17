Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E32D3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:30:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E3A989112;
	Fri, 18 Oct 2024 01:25:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="STHVVsD3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5107B8912C; Fri, 18 Oct 2024 01:25:40 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79EC18929D
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:25:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3a39f73a2c7so7136765ab.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207536; x=1729812336; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NPAF2nLwjKC+d0g3i9v8MJHl+yMPd3SfKKRJ5ABrVC0=;
 b=STHVVsD3lonZKL/1ahAYodJYyZw08AjoJRMXSq12Goy6geOXyZr2lzVj8kJqu95yBO
 HoiAdODnD4XzjXoYWz0+76aMUz6trvEs11KsJeWzYO6bo3qNqXFdGzUG5AUSaSXQrQtS
 c1neHXyPOeSCbFrEy7tX2VFTi3HPYScWZMlGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207536; x=1729812336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NPAF2nLwjKC+d0g3i9v8MJHl+yMPd3SfKKRJ5ABrVC0=;
 b=oO0Ef1T9iUkobxEGaI7gndblcsYRR40uc3+VFGWbAJCkCfy06FyCCa2mXY7JI2Wsxd
 3CbSFcS9gV+7uJYPJiQwCY32IXXjh57bamSQJQMOnlt4528knm/8eBW4AkbDJu8qOqvs
 xX70MeXWMRjXFe9edH4+PT9yXpP51gHbmUhvohz1b/As61grlKWOkwm3uCxZ9G/D8CdV
 /O9ghUCJIdPriotsCQ73VNe/la7/tFxOSFEQWIFqxYGseRd+QG1/jv1dSTEELhxOrcXB
 +DXMSKA86T/gHy/gefFwnD6OfdoDD/kc0mYp+m9x50ZkVoShiVjnPajRnaHAO++TqQJV
 x53Q==
X-Gm-Message-State: AOJu0YweIEIZ1u8UxYM29uUPth8HJGB8d2aoXdZ5bX1NcO3jXWEf8blu
 BLk2ga3+E2E27/HEIez30vJjcAj+GqKDFv6k6THa24E2azkbZt2CSo/UFk3NoIOG3zdtn1u4iEE
 =
X-Google-Smtp-Source: AGHT+IGAXTNbqXqMOOcPTifYQQAJoAtGgJibEl6+9xkJ0xEKDn6H/ZqISUpiskKkwizugNzRmSykUg==
X-Received: by 2002:a05:6e02:1a06:b0:3a3:b4ec:b3f0 with SMTP id
 e9e14a558f8ab-3a3f40aa86bmr5368465ab.17.1729207536018; 
 Thu, 17 Oct 2024 16:25:36 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b5ac9csm122057173.29.2024.10.17.16.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:25:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v4 1/8] blk: Make functions available unconditionally
Date: Thu, 17 Oct 2024 17:25:24 -0600
Message-Id: <20241017232531.726559-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017232531.726559-1-sjg@chromium.org>
References: <20241017232531.726559-1-sjg@chromium.org>
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

