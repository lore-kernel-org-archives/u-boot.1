Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989E0C0218D
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 18:46:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B11E080F10;
	Sun, 26 Jan 2025 19:44:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y44GahGE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CDC2810F1; Sun, 26 Jan 2025 19:44:31 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D6D980FCC
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 19:44:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-844e9b8b0b9so281293839f.0
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 10:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737917067; x=1738521867; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fnMStaSPdZNYCoqavIc6/85feHfNQ7ioZLa75quRLnM=;
 b=Y44GahGEwhU83ZWXWyk9N9yNh+AWBIzJCr+qoCYtYEWW0erPrQ3PbPWmDsyEtroD4E
 ChUsxEJnQX58xZROvkbvBe210NGQ/ujEJpKDV9lrlr74+18uHVWThknrAYghp9HwVylT
 eDl9DxKEMQ5TDr6G495sZI3q6CbkIWM1SZqn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737917067; x=1738521867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fnMStaSPdZNYCoqavIc6/85feHfNQ7ioZLa75quRLnM=;
 b=QEH2Xh4JMiWclCzT84AUWqo7eEYaMz3n61c3dNL9p19MkodECWkoqNtr49d2UXgLZY
 zkG9UoHWOonl/kAQW+v4gCgslnvGrsCgC6Dw7raH5P65+dDuihduC7/ZoVod9ZDvXgwX
 SAVkk4MbTBw7gx4/ypvPmeyeEC7cvstocnSm+OhNMHXlegDM0U6nBK7/natUUj69Vcm/
 8tsyOpSuS9Nem1w7sihyPqPQz6BSJ7c0Basfl5VuyFJWKVVKqg0wq++uT0wQnZ47jW/o
 fM3LzrBKdjTQlJdQI1xWsdp2ZhWND1v3RTClmesuwkgFjjOUJWNBpKgwtihPOgY/skWq
 4S/A==
X-Gm-Message-State: AOJu0Yy30jj4nxGYcI/x9UqYyQtE315mKlWuzRiWxdyQhenOBL0TbhPX
 VnAK5G3iM+QOH0rftCFsiLibMwnleNq0ux/DidoyVn4RX9qFe6gm6liwKa4efjDKrALU2w5Rz04
 =
X-Gm-Gg: ASbGnct96agcaKVw73E9SmmVBRZvxSeXLHZ09AvYZQqCf6Webq+sFO5KZbXG4+sxkkJ
 y3yP40QzaMbDvF9dFiCr4HxO0YBt4TuiuQNxV5c2cVb6QWdK9KGgX7HbvscRHYgZ00Up4yuR/9l
 tVOpm27Bio/EaHfkMlvgnV2d6Q1dip2g9AcXUtGd5lpj3nvf3rJlkeO1XhhDV3Tm5vQg9ImLQDi
 vZtrVCDJ/iE1gETnxpcjU/u1kCxhCQftwMBKCYSUqc/kcMLbNKLyn9hE93eEpkQf+NKmSAGAsy3
 wMjXlrTJntleI4uH26h0MYe0LZvHbHM9/cKEteMZoQ==
X-Google-Smtp-Source: AGHT+IEBMnN+w4Y7ucSudadAuR3771ZFw7UA41DotNjyfqnzMh0G8KbdRq/TngfluPQKGzrlmnQACA==
X-Received: by 2002:a05:6602:6b07:b0:843:f220:fa3d with SMTP id
 ca18e2360f4ac-851b624142emr3559866539f.7.1737917065748; 
 Sun, 26 Jan 2025 10:44:25 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ec1da317fesm2160641173.42.2025.01.26.10.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jan 2025 10:44:24 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 17/19] vbe: Tidy up a few comments
Date: Sun, 26 Jan 2025 11:43:27 -0700
Message-ID: <20250126184333.4058848-18-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250126184333.4058848-1-sjg@chromium.org>
References: <20250126184333.4058848-1-sjg@chromium.org>
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

Join the comment block for the fit_image_load() call back to where it
should be. Also fix a debug statement.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/vbe_common.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/boot/vbe_common.c b/boot/vbe_common.c
index 0d51fe762c3..009bbcd3e76 100644
--- a/boot/vbe_common.c
+++ b/boot/vbe_common.c
@@ -202,14 +202,6 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 	phase = IS_ENABLED(CONFIG_TPL_BUILD) ? IH_PHASE_NONE :
 		IS_ENABLED(CONFIG_VPL_BUILD) ? IH_PHASE_SPL : IH_PHASE_U_BOOT;
 
-	/*
-	 * Load the image from the FIT. We ignore any load-address information
-	 * so in practice this simply locates the image in the external-data
-	 * region and returns its address and size. Since we only loaded the FIT
-	 * itself, only a part of the image will be present, at best.
-	 */
-	fit_uname = NULL;
-	fit_uname_config = NULL;
 	log_debug("loading FIT\n");
 
 	if (xpl_phase() == PHASE_SPL && !IS_ENABLED(CONFIG_SANDBOX)) {
@@ -220,11 +212,19 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 		log_debug("doing SPL from %s blksz %lx log2blksz %x area_offset %lx + fdt_size %lx\n",
 			  blk->name, desc->blksz, desc->log2blksz, area_offset, ALIGN(size, 4));
 		ret = spl_load_simple_fit(image, &info, area_offset, buf);
-		log_debug("spl_load_abrec_fit() ret=%d\n", ret);
+		log_debug("spl_load_simple_fit() ret=%d\n", ret);
 
 		return ret;
 	}
 
+	/*
+	 * Load the image from the FIT. We ignore any load-address information
+	 * so in practice this simply locates the image in the external-data
+	 * region and returns its address and size. Since we only loaded the FIT
+	 * itself, only a part of the image will be present, at best.
+	 */
+	fit_uname = NULL;
+	fit_uname_config = NULL;
 	ret = fit_image_load(&images, addr, &fit_uname, &fit_uname_config,
 			     IH_ARCH_DEFAULT, image_ph(phase, IH_TYPE_FIRMWARE),
 			     BOOTSTAGE_ID_FIT_SPL_START, FIT_LOAD_IGNORED,
-- 
2.43.0

