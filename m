Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BD4CE7A8C
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 19:27:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8502686B29;
	Sun, 24 Sep 2023 21:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Wwx+EI2a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B01886BBE; Sun, 24 Sep 2023 21:26:14 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 208CA86B5E
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 21:26:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-351208d0d6cso10534345ab.1
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 12:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695583562; x=1696188362; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mitZQpcs1Cii52O+06Upwy9qIOcZBlbAPCXyCQte5jI=;
 b=Wwx+EI2a1D8zME7dFX5s/jSAlyazLUmycUka5BxzAc+lUAHcyL8cmnN/kOFM0dnfej
 yOq5eWh7Emsa9ZT5ah6yhma6PP7nAzqhxt2YGJo6ZIgMBr9M2e3YJe/MmmmkEoLNw0cS
 kKUuCJYif80E3RbFRcV1nCdjBenE0zeRRL6b4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695583562; x=1696188362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mitZQpcs1Cii52O+06Upwy9qIOcZBlbAPCXyCQte5jI=;
 b=hxj8Ei9GqH0HJAKeIxYGwDSpuio2z1D3fTCqEeg6SyaBtFj0u1oP1iyq/m81N7AeCl
 3r80HtqF+2+x9SPqwx3kt621poAR+7OzoeUK2RLNqNLIeJVIS5yBg+aZRhhDj+E416nS
 EDTPxVMyj0coew5mP70/jsWc7z9gO4/Q2C5y2+Ux7xCbfdCsQsj6wgGQJfE3YGeQbkIb
 x8b/fCSKwSRW2u5vmZ/Qyay5t5pU7c46UJNCTt9yDyTmM6KtANv0djVV5xnmj3lZKc9Z
 ViyrwjU3wiUD9a3bk3r74Lhjk5H9N6yeLtZ0rq2cnPTqiwwWxo0IN+5qmKGCbkJpqAZ2
 V2VQ==
X-Gm-Message-State: AOJu0YxyKfDOr6AHEU3pLre50i04W1OutvhW6iHKuZYpIDjXVvGrcRHi
 ruZkgeGZVPz3QAXBZYySPebo0H5wOlrB5eN3e/0=
X-Google-Smtp-Source: AGHT+IEkXvHDBRwKPVO0VehhpNiio0mjbt/YW9bO2PnT9AfnAFivArMnfRV30MwLar5ZulTO+jkBvQ==
X-Received: by 2002:a92:b0f:0:b0:34f:ce12:a3c2 with SMTP id
 b15-20020a920b0f000000b0034fce12a3c2mr5935696ilf.25.1695583562775; 
 Sun, 24 Sep 2023 12:26:02 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 do25-20020a0566384c9900b0043a11ec6517sm2321702jab.171.2023.09.24.12.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 12:26:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Nikhil M Jain <n-jain1@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>,
 Troy Kisky <troykiskyboundary@gmail.com>
Subject: [PATCH v3 15/38] spl: Avoid an #ifdef when printing gd->malloc_ptr
Date: Sun, 24 Sep 2023 13:25:00 -0600
Message-ID: <20230924192536.1812799-16-sjg@chromium.org>
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

Use an accessor in the header file to avoid this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Rebase on the new patch

Changes in v2:
- Use the same condition for both pieces to avoid possible problems

 common/spl/spl.c                  | 9 +++++----
 include/asm-generic/global_data.h | 6 ++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 8967a140041b..2c36caa856fa 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -864,10 +864,11 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	} else {
 		debug("Unsupported OS image.. Jumping nevertheless..\n");
 	}
-#if CONFIG_IS_ENABLED(SYS_MALLOC_F) && !defined(CONFIG_SPL_SYS_MALLOC_SIZE)
-	debug("SPL malloc() used 0x%lx bytes (%ld KB)\n", gd->malloc_ptr,
-	      gd->malloc_ptr / 1024);
-#endif
+	if (CONFIG_IS_ENABLED(SYS_MALLOC_F) &&
+	    !IS_ENABLED(CONFIG_SPL_SYS_MALLOC_SIZE))
+		debug("SPL malloc() used 0x%lx bytes (%ld KB)\n",
+		      gd_malloc_ptr(), gd_malloc_ptr() / 1024);
+
 	bootstage_mark_name(get_bootstage_id(false), "end phase");
 #ifdef CONFIG_BOOTSTAGE_STASH
 	ret = bootstage_stash((void *)CONFIG_BOOTSTAGE_STASH_ADDR,
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index f8fc87f1e46e..937fb12516c1 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -588,6 +588,12 @@ static_assert(sizeof(struct global_data) == GD_SIZE);
 #define gd_set_pci_ram_top(val)
 #endif
 
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

