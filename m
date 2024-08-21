Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67E4C52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:21:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 463AA88E2B;
	Wed, 21 Aug 2024 18:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AZgPbgbo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA48388E2A; Wed, 21 Aug 2024 18:19:47 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 211C088BF9
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:19:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-70cb1b959a6so2683291a34.3
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257184; x=1724861984; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VpzfZyiejuKVQDqSAJWSodsjwxF4NtJljc4OffauubI=;
 b=AZgPbgbofU1chvsd29WHG9VWo0ij12svKpK1j4ljdN55PI29HtAENO27jFWGpJ+YRi
 AMyv6cbDmKHrC25RIAjUngD6bAZQlS3Htni7TjcWkchzM507nc1XrmfKBj2K5PZXjdwR
 Zmyx06DUQ8ITfBSBjDFoW7QFGPNekvKK5RfNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257184; x=1724861984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VpzfZyiejuKVQDqSAJWSodsjwxF4NtJljc4OffauubI=;
 b=jx3lNIwIGodvGbdJaN91WEgNzUtOcOaFcy/lHARLZw292OFvI0+ITt0e10yMll5kLr
 0IeDKaJUXj1Oat8ilaIZiVwZW4Fd72gP5XWwhG1ZOsHhEw6Cap1dt2rsZe4a2InNphMC
 HTn+W+Bj9L4ZQgWtiiAQqk1yY9Vu7RIa79sMglseAe72Ji6wl8cNwF0uc1r/oqre1j1p
 E2l/swpexDkCFDkPYS5FxurV7MsS5YAmPxa8rZXJE+7jN8NQztKLAdj3RfKOWmpS1pcL
 znQUJNgGMGoDRKCpYnUfV3utibLla/OnCAUV4hbMLkCzwSMh3sdpe+6IIilShbzu+Ztr
 rXdw==
X-Gm-Message-State: AOJu0YxEeHi26GDG5MF+JJ8LAxy6i2yDDWVD2joOBGFCMrhfnXQ+yYoy
 MOWkTc16tnEkj+ekWenAVQRwSSJwcuFCKjSx0NsB0KmBbQ4vrbfSvV5ndj4flrmJp7QK37ecn/I
 =
X-Google-Smtp-Source: AGHT+IGm3t318OELXMlQ/VkWinZk7UDvvWN6onlDZq8PEBasFQLn1oyS74TjK289xJUUBHf5RbohNQ==
X-Received: by 2002:a05:6830:2708:b0:709:420f:3c68 with SMTP id
 46e09a7af769-70df8714f46mr3005791a34.13.1724257183734; 
 Wed, 21 Aug 2024 09:19:43 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.19.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:19:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 09/35] video: Avoid setting global_data fb_base from SPL
 handoff
Date: Wed, 21 Aug 2024 10:19:01 -0600
Message-Id: <20240821161927.695717-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821161927.695717-1-sjg@chromium.org>
References: <20240821161927.695717-1-sjg@chromium.org>
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

This field is not used, so don't set it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/video/video-uclass.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index e358a7949e0..ef780a6730c 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -224,7 +224,6 @@ int video_reserve_from_bloblist(struct video_handoff *ho)
 		return -ENOENT;
 
 	gd->video_bottom = ho->fb;
-	gd->fb_base = ho->fb;
 	gd->video_top = ho->fb + ho->size;
 	debug("%s: Reserving %lx bytes at %08x as per bloblist received\n",
 	      __func__, (unsigned long)ho->size, (u32)ho->fb);
-- 
2.34.1

