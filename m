Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08849CE7A8C
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 20:41:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9E6A86B72;
	Sun, 24 Sep 2023 22:40:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gzmBjtSt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92FF586B74; Sun, 24 Sep 2023 22:40:30 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08BE386ADC
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 22:40:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7927f24140eso188868839f.2
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 13:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695588026; x=1696192826; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=79Mt9ESqnQA8HZ9a2haIPzcuaFbBi8s9GryWwYDPA1c=;
 b=gzmBjtSta/AZ7ZCJ1z8cAbEFGbsxpg8B550RlVnxUsmNT0r/jnEghah7V52xea/YrV
 hYQN4E8j+/0aR9sc3WNHLHuwvO7W/8vJ9wVt/W0i9Gz7c1xh4fOZFEQ/0a/B2NJZTaeu
 KwLDNAYiE6+SIDJhrWLkX4p7qtSjc3CIvZeD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695588026; x=1696192826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=79Mt9ESqnQA8HZ9a2haIPzcuaFbBi8s9GryWwYDPA1c=;
 b=Xm+uMXSmdZ0AKY66Uko0h6KBQ0Re+9KDzHNcas9Wk/H4dkFJBakALo2WoCMLzX6Mbn
 tYznEG76nRIBETyT96uJ7z9YPUp96QrSZ0cBC+C04gHcBZD9TmTuDnTiEJZW6+f/8ts4
 h2FYnHo+1jQApwB4UdPunEBR9LCjAA97BCw02fnS5acy+ssW4VIcPj5XPW9tJJ77rydv
 JzBkPQclsa8OZdxSe/XTmvEJ/leaaLesU4iPWjwZ6HIIGRTIRak5biyKNMFyg6M91XNY
 R5W+Zl2nKrKTW+HfBFRGKfcUVGsKoKEvKgsHBBr7WsUJf/rDowveqRo0Y9DH7jnyFzqD
 AHLg==
X-Gm-Message-State: AOJu0Yxb/5rqb/fg5q+mxBkOC0ApcyYwOxV8ZMJVVI1IvOEzhgBsvbmK
 Qw1W1oFaZlnsY0SRsfHTAeFpbn5XDzx/sldmTng=
X-Google-Smtp-Source: AGHT+IHVkLIvDhOLEfKdNIeNCa7fu/V8mEnYRKTobdqUB8c7uDElo0CTqlPmIV7cmRGpUuXvCKgvOg==
X-Received: by 2002:a6b:6a06:0:b0:783:63d6:4cb with SMTP id
 x6-20020a6b6a06000000b0078363d604cbmr5955614iog.14.1695588026646; 
 Sun, 24 Sep 2023 13:40:26 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 m11-20020a02cdcb000000b0043a1b74a0e3sm2311705jap.90.2023.09.24.13.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 13:40:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Tom Warren <twarren@nvidia.com>
Subject: [PATCH 07/25] tegra: Change #ifdef for nop
Date: Sun, 24 Sep 2023 14:39:25 -0600
Message-ID: <20230924203953.1829820-8-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924203953.1829820-1-sjg@chromium.org>
References: <20230924203953.1829820-1-sjg@chromium.org>
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

This code is normally compiled for Tegra, but sandbox can also compile
it. We should not use UNIT_TEST as a synonym for SANDBOX, since it is
possible to disable UNIT_TEST for sandbox.

Correct the condition.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/k210/pll.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/k210/pll.h b/include/k210/pll.h
index fd16a89cb203..6dd60b2eb4fc 100644
--- a/include/k210/pll.h
+++ b/include/k210/pll.h
@@ -13,7 +13,7 @@ struct k210_pll_config {
 	u8 od;
 };
 
-#ifdef CONFIG_UNIT_TEST
+#ifdef CONFIG_SANDBOX
 TEST_STATIC int k210_pll_calc_config(u32 rate, u32 rate_in,
 				     struct k210_pll_config *best);
 #ifndef nop
-- 
2.42.0.515.g380fc7ccd1-goog

