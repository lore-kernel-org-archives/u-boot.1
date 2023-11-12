Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1420EC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 15:29:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16BC48767B;
	Sun, 12 Nov 2023 16:28:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H7CCJmCR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FB8C87152; Sun, 12 Nov 2023 16:28:07 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36A5D871CF
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 16:28:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7ad1236c419so128873539f.0
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 07:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699802884; x=1700407684; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FepCTrpaT7u9j1QiGF/dCfz2kwAfAIpjz8QO/ESZlSI=;
 b=H7CCJmCR4nlfpVOGtkwfFGRidFCsjKg5v7OE6jmryikqtyy8vmqn/Au2dsmxNA7cHb
 kgDr3TQXd2NSZIe7prMLLodd0lj/5N3R+UUKKLOf0+O7byQ48qF//3pzBjtm5Kwqr4f4
 s6M64gmJtCuxaUz4mOrqemzyCNQZrxTK2IdgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699802884; x=1700407684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FepCTrpaT7u9j1QiGF/dCfz2kwAfAIpjz8QO/ESZlSI=;
 b=qwX+0i3sowTK/4OujkQ6uMsrzdv92DUkqtvRNGO2KnBXMFL573JU/dJzUkNWsdD1M5
 ewP5RDwLGHYYYsWkdaQbOc5wflDPmJoaUi68xyswrq9bgkY3JEiBgtZ3O+oPmV/07vlV
 IH+9wt5seQ9CpWvD5KXebo5MF5wSZBqRRNgjB4vRBP42V2vK/x/25VyUVlsKJlVLEdMQ
 Y368nk2c1k34z6efXekAq6yHsTYNJxo+SGbg0cv7DSZKEKhymp8B3tSEUU2Vmw6XUI7x
 oZpwRTWi5xUopiOiL2EMYNsrGbvSRZDbCX/o1GKlRc+ISDL1ItEwpoNR8Wvyq3GbcbY2
 GbFg==
X-Gm-Message-State: AOJu0YwFtO5BZXWilXJMWNRf12baul9CWqbZItdYAcV3PhWlVxaY3Vtz
 q8GlefI8OVOez5EaWa9+5JQu5qem5655vrkmNDVRIw==
X-Google-Smtp-Source: AGHT+IF3aoGtR7WuDpvbVZuw1tH2jm9WQohcSw86NJsWlmbQo/3J6QAq4DopHRMzIXXZKcTydtpgbg==
X-Received: by 2002:a05:6602:3711:b0:792:82f8:749d with SMTP id
 bh17-20020a056602371100b0079282f8749dmr6592608iob.10.1699802883778; 
 Sun, 12 Nov 2023 07:28:03 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 76-20020a6b144f000000b0079fdbe2be51sm1226241iou.2.2023.11.12.07.28.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 07:28:03 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Edmond <seanedmond@microsoft.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Jerry Van Baren <vanbaren@cideas.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH 6/7] fdt: Drop the confusing casts in lmb_free()
Date: Sun, 12 Nov 2023 08:27:49 -0700
Message-ID: <20231112152754.130399-7-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112152754.130399-1-sjg@chromium.org>
References: <20231112152754.130399-1-sjg@chromium.org>
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

Just use map_to_sysmem() instead of all the casting.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/image-fdt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index ac7dc055cc9c..3e889be9f2b6 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -685,8 +685,7 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob,
 
 	/* Delete the old LMB reservation */
 	if (lmb)
-		lmb_free(lmb, (phys_addr_t)(u32)(uintptr_t)blob,
-			 (phys_size_t)fdt_totalsize(blob));
+		lmb_free(lmb, map_to_sysmem(blob), fdt_totalsize(blob));
 
 	ret = fdt_shrink_to_minimum(blob, 0);
 	if (ret < 0)
@@ -695,7 +694,7 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob,
 
 	/* Create a new LMB reservation */
 	if (lmb)
-		lmb_reserve(lmb, (ulong)blob, of_size);
+		lmb_reserve(lmb, map_to_sysmem(blob), of_size);
 
 	if (!ft_verify_fdt(blob))
 		goto err;
-- 
2.42.0.869.gea05f2083d-goog

