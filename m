Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8978ECF58E7
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 08:14:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E1568944E;
	Fri, 20 Sep 2024 10:13:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l3hz5jdN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8577989439; Fri, 20 Sep 2024 10:13:33 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 886758940F
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:13:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c42e7adbddso2178008a12.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 01:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726820008; x=1727424808; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3TThT2ku9dh0XGAXrDsdzEXlzK8cu0L4jeKTpKeP1dY=;
 b=l3hz5jdN3rmAatGGxyFeOUUaARGHX3euUBo3B5849tPaBT9xsCPV7ANLOpeErqQ2Dx
 i1uTArJDHBfYzRPs41KN9HOZ9ZGLM/SnGRWbuHNZxfnFb/60HqEEubBNjstxVeeMIGbY
 gWe221kGuMO6cdXXQ4sw32JGT7pV+OG5ABTDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726820008; x=1727424808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3TThT2ku9dh0XGAXrDsdzEXlzK8cu0L4jeKTpKeP1dY=;
 b=C2biJEOqIfSdwqmODF3aIlDUUM4nENp79n0RWgZXAzgcCGKdDvujpXSo2dzlYjy/rR
 MFVmCif/m/YC01tp3BtZkmKav/MHuekFY5Ctp6K93xGCDo0zRxnzQADMPPtbPSjPMqgI
 G8Tts2VSb6+bcQRV6lq+CJYQAD7KiNDD6WLm5o2T9EKhgvrp1XjlVf8OPJAsfHCsslNm
 iDe0YYbvg5J4RPZSgCtwq7ENoS5xtHIL7bLzRfmc04/GSYwyBmspAtkf+kZ2FeVQXdxm
 CWQVOiaAlRgOPsAnIGlXAacs6jl0hzUu5C3zEOZzKXZo2Tm2JaOmzTU7+aXWxLIswyvo
 dvAA==
X-Gm-Message-State: AOJu0YyQesdjTXNnDCxFjs7fgi7Oqvk1qoTBY0jzHFrIicBMF3NSTpB0
 +mWpQQx6MImCwAGZETCg9Ycr94IqABtUqdkhVCKqTRoOEwHWx8ZigXik+UPuSoC1/ZInJbPAGxM
 qtzHe
X-Google-Smtp-Source: AGHT+IEV3o5+faGmsa+QiGKd3x9hAE+cGczDwiMaDQqC4Y0Aq6nO83LNo0aVYzrIKr0UZBDyXB16Gg==
X-Received: by 2002:a05:6402:50cf:b0:5c3:d16d:d1a8 with SMTP id
 4fb4d7f45d1cf-5c464a7ee0dmr1197240a12.34.1726820007502; 
 Fri, 20 Sep 2024 01:13:27 -0700 (PDT)
Received: from chromium.org ([83.68.141.146]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bc88cf7sm6804447a12.90.2024.09.20.01.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 01:13:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 05/18] malloc: Show amount of used space when memory runs
 out
Date: Fri, 20 Sep 2024 10:12:44 +0200
Message-ID: <20240920081309.140426-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920081309.140426-1-sjg@chromium.org>
References: <20240920081309.140426-1-sjg@chromium.org>
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

Show a bit more information when malloc() space is exhausted and
debugging is enabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add field names into the message

 common/malloc_simple.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/malloc_simple.c b/common/malloc_simple.c
index 5a8ec538f8f..f0f90a095bd 100644
--- a/common/malloc_simple.c
+++ b/common/malloc_simple.c
@@ -26,7 +26,8 @@ static void *alloc_simple(size_t bytes, int align)
 	log_debug("size=%lx, ptr=%lx, limit=%x: ", (ulong)bytes, new_ptr,
 		  gd->malloc_limit);
 	if (new_ptr > gd->malloc_limit) {
-		log_err("alloc space exhausted\n");
+		log_err("alloc space exhausted ptr %lx limit %x\n", new_ptr,
+			gd->malloc_limit);
 		return NULL;
 	}
 
-- 
2.43.0

