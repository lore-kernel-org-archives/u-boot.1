Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A726CD493C
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:58:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 908DB86D86;
	Thu, 21 Sep 2023 03:58:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kj/wK1f5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7917586D92; Thu, 21 Sep 2023 03:58:00 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6689186C10
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:57:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7955636f500so19967839f.1
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695261472; x=1695866272; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5QcbAD2DcA1kyWT7zyiskBkdTt2QYZXZXwDv0EmXg6A=;
 b=kj/wK1f5HrTr0ChAx/k1Sg70E53GFBgJjU5EsIuu6iHv41THO6gX0zt/ZBD2ZbwQ+M
 beXR24zd6LOXHrfOGWhKijRaOVlR/1jIsKGPxn8AMzV3kT2BJOiPQJ7Zn5BC2R4RR4Vn
 KIdmxzueKEV6KnDgKT8pb2rrSR+JTTP8B/tDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695261472; x=1695866272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5QcbAD2DcA1kyWT7zyiskBkdTt2QYZXZXwDv0EmXg6A=;
 b=L8UTKW0VeVpyX/Lk6dL5Pw4stBJMWY45t1sy6aVVgQIzmZCAyqbdfHhdgqkgNGeduu
 J7TeMVGHGW0lgasybYzutQoYPdMbcoLUi2f7eP/cUZD5VuJ+9TQbNnYTU9pXKDAqbmKq
 /scFS6alG/DxdmhGbd+Bco0yOb9K3MqdorhFu33o9L4SBLnPH75eGfFRFXM1O0bscxhX
 OtQRUstzwjA7UWdi2FfGTBHI1WIjrk4+JOMpRpCgjBnOw2acEfQBSor+TBh3Aj8ysUEu
 8LX4Otbt5kOCevka1dtl6VN8zpCrzN7RAJCw7tj2xAE+pLpsajqR32xx4nI55LtAfzk6
 qWgw==
X-Gm-Message-State: AOJu0YwVcsoBXj6YsxLcEAf09hirq6jTVZ0tDB9783aR568xGhNcba9E
 11F1euWq2bpm+hzHt86kAW/U2FU6UjtaDdM2o9E=
X-Google-Smtp-Source: AGHT+IEQ3uaybxpwd7C86x5jYDrbU6Gzl5eto6sE9PEOgwsJB8lrsMq2nltZ6FSXHvj0zCr3AJhlEg==
X-Received: by 2002:a05:6e02:1b06:b0:349:36e1:10fb with SMTP id
 i6-20020a056e021b0600b0034936e110fbmr5452666ilv.18.1695261471965; 
 Wed, 20 Sep 2023 18:57:51 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 y4-20020a02c004000000b00437c3a7b49dsm85317jai.156.2023.09.20.18.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 18:57:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Nikhil M Jain <n-jain1@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>
Subject: [PATCH v2 09/32] spl: Avoid an #ifdef when printing gd->malloc_ptr
Date: Wed, 20 Sep 2023 19:56:58 -0600
Message-ID: <20230921015730.1511373-10-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230921015730.1511373-1-sjg@chromium.org>
References: <20230921015730.1511373-1-sjg@chromium.org>
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

Use an accessor in the header file to avoid this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Use the same condition for both pieces to avoid possible problems

 common/spl/spl.c                  | 9 +++++----
 include/asm-generic/global_data.h | 7 +++++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 8511c66d7394..5f57b51ca2d1 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -864,10 +864,11 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	} else {
 		debug("Unsupported OS image.. Jumping nevertheless..\n");
 	}
-#if CONFIG_VAL(SYS_MALLOC_F_LEN) && !defined(CONFIG_SPL_SYS_MALLOC_SIZE)
-	debug("SPL malloc() used 0x%lx bytes (%ld KB)\n", gd->malloc_ptr,
-	      gd->malloc_ptr / 1024);
-#endif
+	if (IS_ENABLED(CONFIG_SYS_MALLOC_F) &&
+	    !IS_ENABLED(CONFIG_SPL_SYS_MALLOC_SIZE))
+		debug("SPL malloc() used 0x%lx bytes (%ld KB)\n",
+		      gd_malloc_ptr(), gd_malloc_ptr() / 1024);
+
 	bootstage_mark_name(get_bootstage_id(false), "end phase");
 #ifdef CONFIG_BOOTSTAGE_STASH
 	ret = bootstage_stash((void *)CONFIG_BOOTSTAGE_STASH_ADDR,
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 8fc205ded1a3..edf9ff6823f2 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -573,6 +573,13 @@ static_assert(sizeof(struct global_data) == GD_SIZE);
 #define gd_malloc_start()	0
 #define gd_set_malloc_start(val)
 #endif
+
+#if CONFIG_VAL(SYS_MALLOC_F_LEN)
+#define gd_malloc_ptr()		gd->malloc_ptr
+#else
+#define gd_malloc_ptr()		0L
+#endif
+
 /**
  * enum gd_flags - global data flags
  *
-- 
2.42.0.515.g380fc7ccd1-goog

