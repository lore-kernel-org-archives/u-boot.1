Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DB6C369D9
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 12:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52A9588C98;
	Wed, 25 Sep 2024 14:57:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jDEbell+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ACC188BC2; Wed, 25 Sep 2024 14:57:58 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8577388B9F
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 14:57:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a8d56155f51so803129866b.2
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 05:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727269070; x=1727873870; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FWxi/uLbfaPg1MEi4HO89AIME2vpjFbMNr+8BWr6vxo=;
 b=jDEbell+nNoxO/ZxY891bDspcIIZYhM85yUSMfi9nd0s0pfXzV33DUpkVELScbirxI
 cdPSA5dE9MhxlOnK5afvnL3YyQSTRpH0EKKisMqWs730laVG5sL8jrSui4qv2JayKANJ
 p7upQH4/537PT/uukBhZzqDarAdCKkax1EQKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727269070; x=1727873870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FWxi/uLbfaPg1MEi4HO89AIME2vpjFbMNr+8BWr6vxo=;
 b=AOd6weK5fQxcbUO8haAkFCwGkJ0OktdEy3n4607F3WUoghVqXg+uB70GjedUGUL1/B
 /AmFF/TwH0U2JPDntRMNKcu1EteNzh1HWhp3s8XH/YZOUDrzt7oaLhQQFYUrzcj3Sr8R
 GnJVuKqNRH/zzsqKdOQpQRg4oxR5HRT7jN5T5+z2DJirgB8gPStVRpJJw1mTnW+BqK6+
 ZZTWu9UsNCn0vXZA3Xxwraoxj7hEhUZ9p9NwsvjMA2hOQi0Jt8DD+ZnQH5sL4AfjPfiK
 RJgUupYO+GpZS48Zu3TK1iXcJ8AnY+1Az6k52gR587se5zdKUqtT85vfYzqjUDUZKjsJ
 +eJQ==
X-Gm-Message-State: AOJu0YxO+zHw3xQYHjQf+Nj0WjAnpl4H3uFupktHZfykMAEB9rt+DYti
 faqtvHbCgx0+8GEEetikRryqXFW9NnLQ53VCdEN3g8VtkS38A4ZMi+HIaCUSZY1fWaMXtUoiEw5
 G7A==
X-Google-Smtp-Source: AGHT+IFyWyZzzIAr9Lmw2OFHoZeZKwixuJPuKRSzYfP0L3W+riNS4JkvTafls7VlXVRnzc0J4xmhkg==
X-Received: by 2002:a17:907:1b23:b0:a8d:2a46:606f with SMTP id
 a640c23a62f3a-a93a03f52f4mr259912166b.38.1727269069730; 
 Wed, 25 Sep 2024 05:57:49 -0700 (PDT)
Received: from chromium.org ([82.132.187.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93930f7889sm209209766b.179.2024.09.25.05.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 05:57:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>
Subject: [PATCH 02/19] spl: Provide a way of indicating the phase to load
Date: Wed, 25 Sep 2024 14:55:28 +0200
Message-ID: <20240925125622.197915-3-sjg@chromium.org>
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

Provide a field in struct spl_load_info to indicate the phase of the
image which should be loaded. This is needed by VBE, which can load
images in various phases.

Set the phase to none by default.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/spl.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/spl.h b/include/spl.h
index 1cfaa08ed6a..113d50152a1 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -14,6 +14,7 @@
 #include <asm/global_data.h>
 #include <asm/spl.h>
 #include <handoff.h>
+#include <image.h>
 #include <mmc.h>
 
 struct blk_desc;
@@ -304,6 +305,7 @@ typedef ulong (*spl_load_reader)(struct spl_load_info *load, ulong sector,
  * @read: Function to call to read from the device
  * @priv: Private data for the device
  * @bl_len: Block length for reading in bytes
+ * @phase: Image phase to load
  */
 struct spl_load_info {
 	spl_load_reader read;
@@ -311,6 +313,9 @@ struct spl_load_info {
 #if IS_ENABLED(CONFIG_SPL_LOAD_BLOCK)
 	u16 bl_len;
 #endif
+#if CONFIG_IS_ENABLED(BOOTMETH_VBE)
+	u8 phase;
+#endif
 };
 
 static inline int spl_get_bl_len(struct spl_load_info *info)
@@ -332,6 +337,23 @@ static inline void spl_set_bl_len(struct spl_load_info *info, int bl_len)
 #endif
 }
 
+static inline void spl_set_phase(struct spl_load_info *info,
+				 enum image_phase_t phase)
+{
+#if CONFIG_IS_ENABLED(BOOTMETH_VBE)
+	info->phase = phase;
+#endif
+}
+
+static inline enum image_phase_t spl_get_phase(struct spl_load_info *info)
+{
+#if CONFIG_IS_ENABLED(BOOTMETH_VBE)
+	return info->phase;
+#else
+	return IH_PHASE_NONE;
+#endif
+}
+
 /**
  * spl_load_init() - Set up a new spl_load_info structure
  */
@@ -342,6 +364,7 @@ static inline void spl_load_init(struct spl_load_info *load,
 	load->read = h_read;
 	load->priv = priv;
 	spl_set_bl_len(load, bl_len);
+	spl_set_phase(load, IH_PHASE_NONE);
 }
 
 /*
-- 
2.43.0

