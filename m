Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8424C369D9
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 12:59:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FEB188BFC;
	Wed, 25 Sep 2024 14:58:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Zg7e/pYF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B76288B11; Wed, 25 Sep 2024 14:58:08 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A48C88C71
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 14:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c275491c61so8823065a12.0
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 05:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727269080; x=1727873880; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/J2esudR4XFs7f5ZZYZAowJodzY5QF+rtnrSagTG408=;
 b=Zg7e/pYFRioDZhO3nnd/FDYqmETSrHPEqnSKbo0VShGHyFoQoab5oic4RIu+dxpifS
 fWMURpLOdJbDhcdEs+TZ3+L6xdc5xvRFkY11zCd5CAjmqkcCrVZfQtuiFjZ8zC3qMg+R
 D0ydbysRrfmpUHtAJTAljkvhgdL0TwGevyw/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727269080; x=1727873880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/J2esudR4XFs7f5ZZYZAowJodzY5QF+rtnrSagTG408=;
 b=oLafU4Xwo4bEcRkwzAarxf5Ori1JoZRL24MEAW6NdBVsG6i0bQZC2kprYhh/vncQyB
 +zpa9kP1bh3iiZmEdzo0RXLU0QNh8rZn3KYGgq7UejO2gEuiDI3Su7CnvwK+1kZxLvDZ
 JODBbAladURsFcGV4ggMatLoq4ej2k2xef20n1qUEhnph3GlJC5ZoZ+w9Sa/AKqPgiin
 a+irP7UcLouEpBNGmrlt5DEIazHX1CUMKh3wwpz628T4lf/TZkjlUBLTrB2CUkGbGcM7
 TkzX577PB7AEpZb7Xt84bPgQOjttyr3uhTqQ3GvMDSfD7gm8H2fFdAJig7DoUi1dY4Mf
 zQ3Q==
X-Gm-Message-State: AOJu0Yywfx2PzoE46IpDtqR7IE+3QiPjP1ZS2Ah/Alacy14jru+AUjZZ
 fHRPH8NH5w9eTGFIY+Qf75afUFFQSmC5DF6+dWbD5HEDgn1b1CaH4z6ZfoHafpQiSZU4qreIAsh
 1/w==
X-Google-Smtp-Source: AGHT+IFSm9D2n0HCSswA+s73iG1tyoyMEYRRymHJpPMQs7eZ67ab/ORMZ6SUiA+B/kIEpWRm03B68w==
X-Received: by 2002:a17:907:944e:b0:a86:96f5:fa81 with SMTP id
 a640c23a62f3a-a93a03e32c5mr272007866b.32.1727269080578; 
 Wed, 25 Sep 2024 05:58:00 -0700 (PDT)
Received: from chromium.org ([82.132.187.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93930f7889sm209209766b.179.2024.09.25.05.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 05:58:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>, Kever Yang <kever.yang@rock-chips.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>
Subject: [PATCH 08/19] spl: Add a type for the jumper function
Date: Wed, 25 Sep 2024 14:55:34 +0200
Message-ID: <20240925125622.197915-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925125622.197915-1-sjg@chromium.org>
References: <20240925125622.197915-1-sjg@chromium.org>
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

This function will be used by the relocating jumper too, so add a
typedef to the header file to avoid mismatches.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/spl/spl.c | 3 +--
 include/spl.h    | 3 +++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 75938aa63cc..52f7900b431 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -672,8 +672,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 		BOOT_DEVICE_NONE,
 		BOOT_DEVICE_NONE,
 	};
-	typedef void __noreturn (*jump_to_image_t)(struct spl_image_info *);
-	jump_to_image_t jump_to_image = &jump_to_image_no_args;
+	spl_jump_to_image_t jump_to_image = &jump_to_image_no_args;
 	struct spl_image_info spl_image;
 	int ret, os;
 
diff --git a/include/spl.h b/include/spl.h
index 113d50152a1..f73e5f5209c 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -274,6 +274,9 @@ struct spl_image_info {
 #endif
 };
 
+/* function to jump to an image from SPL */
+typedef void __noreturn (*spl_jump_to_image_t)(struct spl_image_info *);
+
 static inline void *spl_image_fdt_addr(struct spl_image_info *info)
 {
 #if CONFIG_IS_ENABLED(LOAD_FIT) || CONFIG_IS_ENABLED(LOAD_FIT_FULL)
-- 
2.43.0

