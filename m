Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38770D70DEB
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 19:15:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44B2889D14;
	Thu, 28 Nov 2024 20:13:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="imlypdre";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7775D89D49; Thu, 28 Nov 2024 20:13:28 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A83FA89D66
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 20:13:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3ea5e405870so502128b6e.3
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 11:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732821204; x=1733426004; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RnJSlIJpuk8EN2VfQxIapsJKBzZQUWFiFmoTrqIAL/E=;
 b=imlypdre2Bk0dFrveraF6tvsXGYXIoIpL6OekFFyJcscZxZnCcUgyhT9/vLjgMFWE1
 hwRvCKX5q9g/Exkx4u70lM8BvUuxWfA2iyRnNxbyLJ535P5yRxYCuYqCuXRY3QKENlIp
 /Kk6Ry2vOox7H/V7MoCcyhzhvvpPole20ztn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732821204; x=1733426004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RnJSlIJpuk8EN2VfQxIapsJKBzZQUWFiFmoTrqIAL/E=;
 b=I0P14kBTun3oebJWgWDc/RN7w/oqa4wDikWrn8h3k3s5NQ9nVj2uIUswa+4pduhz6S
 k/NWQ66AErC62QKSffdUbx/qv/S4xOI6XiuRBw2owGUsHEIigrbmRPqu1UXa9raCKdhe
 BBTGBvuyEvpkhBWDakgPLUnoJRgdZ3byUCum0QWcrie6rzR4pHecXi3Oo2G6FYMb6c41
 1oPJe1UrbgNn2RI71XW6BOf5gtJy8rWKxeQxltbdpfoH7hyizo+ON7UzY1inRsFBbLIB
 ul8POhNJvVoyPZr/wVO609NjN0KBkmXkVXFvjZq+dwul/gHOuu7hnlA/YxkVyDyhtvq8
 9tjw==
X-Gm-Message-State: AOJu0Yzau3hXI5dT5REmpXlSRseRTS5Fj4RVWpSWRhncEh2ZjiMJ8Nn5
 vFujjkriMIv9Lh4jZEros3+g4SbakyD4Xw5FC28ttWNZ+vsGju+kpir5Lceuwv11p/B7FkHa2lU
 =
X-Gm-Gg: ASbGncs7eDpTJru4bsv1sqwcTmD5hYyNMTZou2nSEkFm3xxBJLFNpo6gJsG2/Bxf5bM
 ieDI+fcZzlxZ4RpPTQBlDCbARAF0k32H0ZNKvivaoCwRRZq06Y8ajC9f7+ZOjU4o6yZZMCKTzky
 DPrd6iin8MDvWOLhB/ILC6vJXho//gaLR9YAYBsx9xn4c6iZc4MaQ73xMSNB/3Ib01oxto7StoS
 YiEjBeczlP8Yh+ggqZXAWhkJEfx+BZmS6WA8aPO2tTg+w==
X-Google-Smtp-Source: AGHT+IEORh3jk1FAunqOEigYjQFYo/YtvwIkDniWzQtsDxBU1zhCwwBsXRfOijWqqI2ZhvjDX14+5Q==
X-Received: by 2002:a05:6808:2018:b0:3ea:6149:d6dd with SMTP id
 5614622812f47-3ea6dbe0753mr8642263b6e.12.1732821203892; 
 Thu, 28 Nov 2024 11:13:23 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725d873esm429521a34.54.2024.11.28.11.13.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 11:13:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 14/28] efi_loader: Avoid assigning desc in
 efi_mem_carve_out()
Date: Thu, 28 Nov 2024 12:12:30 -0700
Message-Id: <20241128191244.900006-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128191244.900006-1-sjg@chromium.org>
References: <20241128191244.900006-1-sjg@chromium.org>
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

Rather than assigning desc and then changing two fields, assign all four
fields, for clarity.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 83f2e32b9a4..b51bb367899 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -268,9 +268,10 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
 	newmap = calloc(1, sizeof(*newmap));
 	if (!newmap)
 		return EFI_CARVE_OUT_OF_RESOURCES;
-	newmap->desc = map->desc;
+	newmap->desc.type = map->desc.type;
 	newmap->desc.physical_start = carve_start;
 	newmap->desc.num_pages = (map_end - carve_start) >> EFI_PAGE_SHIFT;
+	newmap->desc.attribute = map->desc.attribute;
 	/* Insert before current entry (descending address order) */
 	list_add_tail(&newmap->link, &map->link);
 
-- 
2.34.1

