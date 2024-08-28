Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B3EC54746
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 01:48:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1648C88C17;
	Wed, 28 Aug 2024 03:46:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ilz3Oh0p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC23488AAA; Wed, 28 Aug 2024 03:46:02 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCF3E88B31
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 03:46:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-81f8f0197abso305920939f.2
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 18:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724809559; x=1725414359; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sP2s6+e0LUe0vByLBxItEG3z9qzzi2BBFrJiey821G8=;
 b=Ilz3Oh0pimOOKgnxkb2hf3C575+3sPfBQYKMcMyiNvkb2tQEJ515O1Me4F5hjYzbqi
 RuLTTt9zXNDNCyeheqFK3CF2kdGeOAF4x74RK96RhT3MuXb+5XD9D6bof9Gze0XKWpJw
 uFN8MOUWrWNaaPDeY6P91EIhrGPUc67E4DLpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724809559; x=1725414359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sP2s6+e0LUe0vByLBxItEG3z9qzzi2BBFrJiey821G8=;
 b=HhG2q9hDvwtl8myvCxYoWMFWVXvzhVYpq3cZtd4reGzDkdzax6peHgXFlw9sDeehia
 n4gPq3azNf7rMWZG5k/tjnU7j5EAqdJJQL8epevxwk7L7g8tzjdAnc4IHP24ByjeLl0D
 9jCyaBcidpqpKzGg6OXVej2D176xLTUaa7rHBsTi1Gp2D5iKojC2KUgukbxFqO403Pws
 5XImWfDKdRpYfE8joqmYT6k6KH3RhYpAvYK5QKGI86D3xVT/u2YLFgV4IXk4ERIwfUPt
 eyd5pHaj59XgpGbhpIDQmhNZyjn20FpPtMFxR/rAQ+PT6ef3ofu5TtJpJaWPHYILDk9g
 IIXQ==
X-Gm-Message-State: AOJu0YwHfbRYhIgNi6QbqolDPgWRoX41WKQQkG+ajdMutwpU2Ny3qt1k
 DWc6l2APNKzSaYF4gK0vBzFswk/k9J+n6PIqp1orMQLC7aepdWsmkUvAwxbIQMuGrDY5tLw3jTs
 =
X-Google-Smtp-Source: AGHT+IHCOM7Kc10tw/6ZISUJlZ9PXVnMdZi8ZRJHbvJ+dLjzjun1yppyo8SCrQeZcRgRf+yRnBjv4g==
X-Received: by 2002:a6b:770e:0:b0:7f6:2819:b099 with SMTP id
 ca18e2360f4ac-82a0417e024mr59299339f.16.1724809559308; 
 Tue, 27 Aug 2024 18:45:59 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f5ca7csm2898342173.63.2024.08.27.18.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 18:45:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Dragan Simic <dsimic@manjaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 14/18] mmc: Log the error when init fails
Date: Tue, 27 Aug 2024 19:45:33 -0600
Message-Id: <20240828014538.3322013-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828014538.3322013-1-sjg@chromium.org>
References: <20240828014538.3322013-1-sjg@chromium.org>
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

Add an error-return log to the call in mmc_init_device()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/mmc/mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 9644aa7aa43..eece4784288 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -3153,7 +3153,7 @@ int mmc_init_device(int num)
 	if (uclass_get_device_by_seq(UCLASS_MMC, num, &dev)) {
 		ret = uclass_get_device(UCLASS_MMC, num, &dev);
 		if (ret)
-			return ret;
+			return log_msg_ret("ini", ret);
 	}
 
 	m = mmc_get_mmc_dev(dev);
-- 
2.34.1

