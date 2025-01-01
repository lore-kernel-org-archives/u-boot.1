Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18973E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:17:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 942A680703;
	Wed,  1 Jan 2025 23:17:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bALJyZkq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7992F806FE; Wed,  1 Jan 2025 23:17:06 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E5A080391
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:17:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2165cb60719so147907175ad.0
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769822; x=1736374622; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HwBii+Iam1PhibZ+vJtxCE8eHwGwzeZqfd3Kvr3BqOA=;
 b=bALJyZkqjqM7KBdhfIlHG+YRHfawKqV7AZTjE4dZyd1GgJ1+IXWHqzSBIlCQvw/MLe
 tq8wxR5D1svkIIEnJHEdqlmuu5CXHLvijHQpXQ3curO/K7Tb4OERL7fhDo+fpxJ/pGNa
 st4WwTeYexRNUquAN1fpf/6FdFNkItRy/6iOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769822; x=1736374622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HwBii+Iam1PhibZ+vJtxCE8eHwGwzeZqfd3Kvr3BqOA=;
 b=Y6Y+gWrighhkTJsJlCMcFdyuby2KfKoo+G52L2oH9DBu5oFCX2vEZJkTSGRpId4/FH
 CgEvlK5OOYPhDqCW8vKo7h0WeUNAFhnMGKIQhL6hzNBGfDojp1+QiUrnba7lFgx6x6Zs
 +JmIcRE/CR4mULUB5zlDHjb1BObnYzoWRS+MQ7ZVDO7WGnzCnl6QqwltuhgbqpYXz8TR
 Kikm5AtIGKsi5xUDz/di3L8JxKTMfhOZU+awFp5EEgZD0hqT5mRIU7GPHYrZSf85cGFt
 giLhylZcWTOiO0h6AzCYGOAmx+xIK4k5H0KYwm8yReNQ1H8EsJuafmjLNTJZSuEaONiu
 Nnhw==
X-Gm-Message-State: AOJu0YxXIqtqnJndHoTN1rmpXjvwC99cKfIsLLpnJDRH+L7aaG57UjEE
 g+vY4JsrWH7l/Thw2oCCCggZpn4CDAMmPXUqvn1lxLaiTDEajEKd4FHihDkdQN2j6/KFEUhaZks
 =
X-Gm-Gg: ASbGncsgFfgyZ4t0m6bpEoexx56YT5AY/wVHaUnO906LQu86eJ9aQdnqFP94Zzb3+kn
 49fwswUEz0I0c39arLQ1Tnto9JKelSvR8U+bwxJKTOfKfCXfp85VOPzjIvHSAkjjcsCXeLrxC/q
 2OVgSMlKndO91n7/JOKIwQ+N62XyUyrILwurcfdCf1tqIw70aGr7rN1VwvKe7D3UUfTwmK/U908
 tIu9MweHq0LT7DXMFqbQ+Evwx7Jcw6CgyeMZMTdsFOiG02KavKUZRE=
X-Google-Smtp-Source: AGHT+IFMZRkbo45xlTA+jcVXCKOMfKgKjgwgt0D2nqUSGc8a48RgKmEXw4E7PbNkq5FVxQX3lzNYjQ==
X-Received: by 2002:a05:6a21:9989:b0:1e1:a8e1:b104 with SMTP id
 adf61e73a8af0-1e5e081d68amr67173502637.45.1735769822175; 
 Wed, 01 Jan 2025 14:17:02 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:17:01 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 39/67] upl: Update upl_add_graphics() to return framebuffer
Date: Thu,  2 Jan 2025 11:09:25 +1300
Message-ID: <20250101221003.1944600-40-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

The framebuffer address and size will be needed for the reserved-memory
section, so return them to the caller.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/upl_common.c    | 4 +++-
 common/spl/spl_upl.c | 3 ++-
 include/upl.h        | 7 ++++++-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/boot/upl_common.c b/boot/upl_common.c
index a0ed5568854..01301049341 100644
--- a/boot/upl_common.c
+++ b/boot/upl_common.c
@@ -87,7 +87,7 @@ int upl_add_serial(struct upl_serial *ser)
 	return 0;
 }
 
-int upl_add_graphics(struct upl_graphics *gra)
+int upl_add_graphics(struct upl_graphics *gra, ulong *basep, ulong *sizep)
 {
 	struct video_uc_plat *plat;
 	struct video_priv *priv;
@@ -101,6 +101,8 @@ int upl_add_graphics(struct upl_graphics *gra)
 	plat = dev_get_uclass_plat(dev);
 	region.base = plat->base;
 	region.size = plat->size;
+	*basep = plat->base;
+	*sizep = plat->size;
 	if (!alist_add(&gra->reg, region))
 		return log_msg_ret("reg", -ENOMEM);
 
diff --git a/common/spl/spl_upl.c b/common/spl/spl_upl.c
index 32c8ea62ef3..a78ae75e56c 100644
--- a/common/spl/spl_upl.c
+++ b/common/spl/spl_upl.c
@@ -54,6 +54,7 @@ int _upl_add_image(int node, ulong load_addr, ulong size, const char *desc)
 int spl_write_upl_handoff(void)
 {
 	struct upl *upl = &s_upl;
+	ulong addr, size;
 	struct abuf buf;
 	ofnode root;
 	void *ptr;
@@ -66,7 +67,7 @@ int spl_write_upl_handoff(void)
 	ret = upl_add_serial(&upl->serial);
 	if (ret)
 		return log_msg_ret("ser", ret);
-	ret = upl_add_graphics(&upl->graphics);
+	ret = upl_add_graphics(&upl->graphics, &addr, &size);
 	if (ret && ret != -ENOENT)
 		return log_msg_ret("gra", ret);
 
diff --git a/include/upl.h b/include/upl.h
index e415130d44f..edd333f648a 100644
--- a/include/upl.h
+++ b/include/upl.h
@@ -226,6 +226,8 @@ enum upl_graphics_format {
 };
 
 /**
+ * struct upl_graphics - Information about graphics display
+ *
  * @reg: List of base address and size of registers (struct memregion)
  * @width: Width of display in pixels
  * @height: Height of display in pixels
@@ -385,9 +387,12 @@ int upl_add_serial(struct upl_serial *ser);
  *
  * Writes details about the current video device to the UPL struct
  *
+ * @gra: Struct to fill in
+ * @basep: Returns base address of framebuffer
+ * @sizep: Returns size of framebuffer
  * Return: 0 if OK, -ve on error
  */
-int upl_add_graphics(struct upl_graphics *gra);
+int upl_add_graphics(struct upl_graphics *gra, ulong *basep, ulong *sizep);
 
 /** upl_init() - Set up a UPL struct */
 void upl_init(struct upl *upl);
-- 
2.43.0

