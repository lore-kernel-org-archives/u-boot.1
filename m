Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDADCE7A8A
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 19:28:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 613EB86BC4;
	Sun, 24 Sep 2023 21:26:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lfUvZdl3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 189D886B68; Sun, 24 Sep 2023 21:26:16 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1041286B1D
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 21:26:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3512740906dso8309155ab.0
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 12:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695583563; x=1696188363; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fJXQH5PcKtXZ+jmyCwDQKabj+ZWLtGSQX9padBuJFhE=;
 b=lfUvZdl3T07KVFGpwSPmTS3MO4G6dT7LZHCpCldbh0Ppmumqq6RFVInvuOaOdOiaDu
 gXBYAV+Fynf03QtPAcY+DV5W4LytKJHKEKlUNkLokDlqclbuYUH26hG953ONiakC88mF
 e55jTfSBYZc6TOtzGGwqXgsAHWMHfCza8cerI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695583563; x=1696188363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fJXQH5PcKtXZ+jmyCwDQKabj+ZWLtGSQX9padBuJFhE=;
 b=dDEieG3kOmEOSIVCHMZfkV/4hQxvaqcYfsM0g9P+Xvgmc3QN8+NvLAv18nnePHf8mC
 wVLnnppWKOVvsx4WPk94W6Z8GK+A/zKQW6qtmVVcvTiUwqkvad8igaSih2/Nnwt8t37x
 3MdpX9IEiVPNOtBZctIh7bOBnt78Iedw9+36XXCADhcuiCJmi8HZztKOCjN6eJJ83hUl
 7DnvEZ8pJEQds8QkcirSjSPm9e7ItIE/ROaM9+fp0gRFKgPQIgWQ9q1j3TJTakw+IEo5
 Iv17ArLTcP9v5IliErIsIeaVpnG2DQKA9+DtyG2WLtfofXG9fK3ekVpQTh5g8UM+A+GY
 Jzdw==
X-Gm-Message-State: AOJu0Yz5RsMLKZeft+VB9PC/rsuOSw8vEaySFJbc+bc/1Fk8UqEruGUC
 XA8c0DTm7IQvi68cRoTv9PyY5FYw4szmDV6cYxw=
X-Google-Smtp-Source: AGHT+IEpPZw5e5YYLnurXKk9DuXfnvVih/QR6bVpnaqhql+a4Dx9onC4vdTHvoBDEv77sifRgZjtqQ==
X-Received: by 2002:a05:6e02:1c22:b0:349:77c7:2ab6 with SMTP id
 m2-20020a056e021c2200b0034977c72ab6mr7621567ilh.2.1695583563678; 
 Sun, 24 Sep 2023 12:26:03 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 do25-20020a0566384c9900b0043a11ec6517sm2321702jab.171.2023.09.24.12.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 12:26:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v3 16/38] spl: Remove #ifdefs with BOOTSTAGE
Date: Sun, 24 Sep 2023 13:25:01 -0600
Message-ID: <20230924192536.1812799-17-sjg@chromium.org>
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

This feature has some helpers in its header file so that its functions
resolve to nothing when the feature is disabled. Add a few more and use
these to simplify the code.

With this there are no more #ifdefs in board_init_r()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/spl.c    | 15 +++------------
 include/bootstage.h | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 2c36caa856fa..e8044b821635 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -542,17 +542,11 @@ static int spl_common_init(bool setup_malloc)
 		      ret);
 		return ret;
 	}
-#ifdef CONFIG_BOOTSTAGE_STASH
 	if (!u_boot_first_phase()) {
-		const void *stash = map_sysmem(CONFIG_BOOTSTAGE_STASH_ADDR,
-					       CONFIG_BOOTSTAGE_STASH_SIZE);
-
-		ret = bootstage_unstash(stash, CONFIG_BOOTSTAGE_STASH_SIZE);
+		ret = bootstage_unstash_default();
 		if (ret)
-			debug("%s: Failed to unstash bootstage: ret=%d\n",
-			      __func__, ret);
+			log_debug("Failed to unstash bootstage: ret=%d\n", ret);
 	}
-#endif /* CONFIG_BOOTSTAGE_STASH */
 	bootstage_mark_name(get_bootstage_id(true),
 			    spl_phase_name(spl_phase()));
 #if CONFIG_IS_ENABLED(LOG)
@@ -870,12 +864,9 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 		      gd_malloc_ptr(), gd_malloc_ptr() / 1024);
 
 	bootstage_mark_name(get_bootstage_id(false), "end phase");
-#ifdef CONFIG_BOOTSTAGE_STASH
-	ret = bootstage_stash((void *)CONFIG_BOOTSTAGE_STASH_ADDR,
-			      CONFIG_BOOTSTAGE_STASH_SIZE);
+	ret = bootstage_stash_default();
 	if (ret)
 		debug("Failed to stash bootstage: err=%d\n", ret);
-#endif
 
 	if (IS_ENABLED(CONFIG_SPL_VIDEO_REMOVE)) {
 		struct udevice *dev;
diff --git a/include/bootstage.h b/include/bootstage.h
index 685939ccffc0..38388afc259b 100644
--- a/include/bootstage.h
+++ b/include/bootstage.h
@@ -244,6 +244,8 @@ void show_boot_progress(int val);
 
 #ifdef ENABLE_BOOTSTAGE
 
+#include <mapmem.h>
+
 /* This is the full bootstage implementation */
 
 /**
@@ -364,6 +366,20 @@ int bootstage_stash(void *base, int size);
  */
 int bootstage_unstash(const void *base, int size);
 
+static inline int bootstage_stash_default(void)
+{
+	return bootstage_stash(map_sysmem(CONFIG_BOOTSTAGE_STASH_ADDR, 0),
+			       CONFIG_BOOTSTAGE_STASH_SIZE);
+}
+
+static inline int bootstage_unstash_default(void)
+{
+	const void *stash = map_sysmem(CONFIG_BOOTSTAGE_STASH_ADDR,
+				       CONFIG_BOOTSTAGE_STASH_SIZE);
+
+	return bootstage_unstash(stash, CONFIG_BOOTSTAGE_STASH_SIZE);
+}
+
 /**
  * bootstage_get_size() - Get the size of the bootstage data
  *
@@ -440,6 +456,16 @@ static inline int bootstage_unstash(const void *base, int size)
 	return 0;	/* Pretend to succeed */
 }
 
+static inline int bootstage_stash_default(void)
+{
+	return 0;	/* Pretend to succeed */
+}
+
+static inline int bootstage_unstash_default(void)
+{
+	return 0;	/* Pretend to succeed */
+}
+
 static inline int bootstage_get_size(void)
 {
 	return 0;
-- 
2.42.0.515.g380fc7ccd1-goog

