Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3917C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 15:29:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BC1287731;
	Sun, 12 Nov 2023 16:28:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZmPelUMl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A80F187620; Sun, 12 Nov 2023 16:28:08 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 737D786E24
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 16:28:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-7a66ff282baso90739539f.0
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 07:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699802885; x=1700407685; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5uyNHDIkChIvhJ207GmTTnNe28HcRZ1FZLk/fpRg3y0=;
 b=ZmPelUMlSckGYn9+Jft9F8B6BEYSTW4VhKEiqyL+aCweOhtLqaHhqEpwyI7fXv+PCQ
 OCGeAy3ocmMjEuhajsGncPfUh20uxJcfqODx9uy/H+2Zv+EH5/qQCwz44lPUn5ZFtKP5
 qZDdrKrzs2tNQf4boK+3+qiOuDpFbI2QaVHSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699802885; x=1700407685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5uyNHDIkChIvhJ207GmTTnNe28HcRZ1FZLk/fpRg3y0=;
 b=r58HGM8gPT4g2laZfnews4J4yoijGInV7n6kZ7m2E/qGzatSGF92+mz4IT6xM3ySsT
 nn5eb3t5S3PVOB2zg8Hh6MphKwaPtJgR03PDmdxrgmGOa1fULK56/uO0KzdcAWzsDgfN
 0tUmacs0kjecj3Z5aByI5GwkUJwjvJriyNqgBEO6adYuklLWnOQ7XLIc4c2uKyGnguRZ
 KmRCa+eAKA0I3tFQ8OUlQYdQqIJuabigzPwDaLWl799js0gpPOVkX+xI7j7dOfrjI3nc
 k9+wKZhT84buEUiw5BRwYu4YX30PSaZVMu+pLhE4u7btYKFQis5jQme+7aquXXyswk2X
 5d+Q==
X-Gm-Message-State: AOJu0YyISYxVRhJIfp5SWj3a/1/SGhKpdbJrkJ6rfPZ6nWhCwBSARtjr
 8udaUlnnal/iPHEp4ntAZfgpoivb1mHSo/Cq1XbvoQ==
X-Google-Smtp-Source: AGHT+IEmpg++te2bYKH1LdM1s592RGa9K97Jk+xI2IxKZs9gHPYqpEo0+Uamg8kAsQzh36iozM9bww==
X-Received: by 2002:a6b:cd45:0:b0:7b0:1ff6:6759 with SMTP id
 d66-20020a6bcd45000000b007b01ff66759mr2625839iog.8.1699802885013; 
 Sun, 12 Nov 2023 07:28:05 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 76-20020a6b144f000000b0079fdbe2be51sm1226241iou.2.2023.11.12.07.28.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 07:28:04 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Edmond <seanedmond@microsoft.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Jerry Van Baren <vanbaren@cideas.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH 7/7] fdt: Move ft_verify_fdt() before the final fixups
Date: Sun, 12 Nov 2023 08:27:50 -0700
Message-ID: <20231112152754.130399-8-sjg@chromium.org>
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

Move this check before the FDT fixups so that we can use a livetree
after this point.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/image-fdt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index 3e889be9f2b6..c2b6c5338385 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -668,6 +668,10 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob,
 	if (fdt_initrd(blob, *initrd_start, *initrd_end))
 		goto err;
 
+	if (!ft_verify_fdt(blob))
+		goto err;
+
+	/* after here we are using a livetree */
 	if (!of_live_active() && CONFIG_IS_ENABLED(EVENT)) {
 		struct event_ft_fixup fixup;
 
@@ -696,9 +700,6 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob,
 	if (lmb)
 		lmb_reserve(lmb, map_to_sysmem(blob), of_size);
 
-	if (!ft_verify_fdt(blob))
-		goto err;
-
 #if defined(CONFIG_ARCH_KEYSTONE)
 	if (IS_ENABLED(CONFIG_OF_BOARD_SETUP))
 		ft_board_setup_ex(blob, gd->bd);
-- 
2.42.0.869.gea05f2083d-goog

