Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA44C6FA8F
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 18:06:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53584865A4;
	Wed, 30 Aug 2023 20:06:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RVYP/rFH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E02E986547; Wed, 30 Aug 2023 20:05:58 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B56E186558
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:05:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7927f241772so2088039f.1
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 11:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693418745; x=1694023545; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mjFlZfR7H0ZoL5MP1aGze/5d0GXtkVxvWQXdZeNEIgM=;
 b=RVYP/rFHdv1WEzxVP0OC9dGlLD00DpMU/UcYF7NqpQHKhcsvysSkZnl4lWndZ0Yvcg
 BBz90XqYkHb40VxCUmBafFOGO7mB/KvS0gWUdQDc/oO+YdnvmKAotSzvMlFU8ORjjy4Q
 rPnzrifBW89LHmoEzG9mz4RiMeH6q1OYwpyxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693418745; x=1694023545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mjFlZfR7H0ZoL5MP1aGze/5d0GXtkVxvWQXdZeNEIgM=;
 b=f2jMziNmFgHBFQbFlCSK04Y+NSHOrh8+WbseydZMbqHxwsAzG9YZdCo43j5aMf2c0n
 odJcSDoKKYuysI0e0ey+hDaLsjFue3vmNZqyHULe2wiJqool9UGMdB5SUUml5YmswcW+
 QDs9xgcs3GJxVRgibSmTwdIhWga3x5Jr+4PYCv74m85wzPul+MXvPMo3gEOrTxRD33U2
 T/4FeJ6FqcxQfMbr4yALsTxmJtWx+9QQEHAnWa1J3USXvO5L2cAhOMNYslf9AEiJohF+
 k9tsv4Ff7jxJuZ+1Aor4lCJAg50vLuLDMb6nd3hJn4EGG6szPvrRj6pgfjLv3p0rslnZ
 IQ6w==
X-Gm-Message-State: AOJu0Yx5FTvPr8H71reITUcIKOF4C4BNdfXsrqx62ao86jE4oAoKYpVH
 MSlTqyVaYvKf9nLG7qgyf3UIxIu1zXUVmbWm0do=
X-Google-Smtp-Source: AGHT+IHrzVF66Vc/IVjFe8YM3mFkg1W++7iGU7gb3SNDEfal1s9ahoJNiCRVT5N1YqqgOhLphNcdqw==
X-Received: by 2002:a05:6602:1813:b0:783:60f7:ade9 with SMTP id
 t19-20020a056602181300b0078360f7ade9mr3436876ioh.5.1693418745346; 
 Wed, 30 Aug 2023 11:05:45 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 dk54-20020a0566384bf600b0042bbd3e49b9sm4002224jab.24.2023.08.30.11.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 11:05:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>
Subject: [PATCH 09/32] spl: Avoid an #ifdef when printing gd->malloc_ptr
Date: Wed, 30 Aug 2023 12:04:40 -0600
Message-ID: <20230830180524.315916-10-sjg@chromium.org>
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

Use an accessor in the header file to avoid this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/spl/spl.c                  | 9 +++++----
 include/asm-generic/global_data.h | 7 +++++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index f0a90c280da..f5cef81000c 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -876,10 +876,11 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
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
index 8fc205ded1a..edf9ff6823f 100644
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
2.42.0.rc2.253.gd59a3bf2b4-goog

