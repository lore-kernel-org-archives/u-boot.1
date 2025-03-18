Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E11C28B28
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 15:21:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C84CF8129F;
	Tue, 18 Mar 2025 16:21:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kMRevEgU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0B2981BC5; Tue, 18 Mar 2025 16:21:18 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19726800B6
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 16:21:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so35365365e9.3
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 08:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742311275; x=1742916075; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xuCAFBOCVNBjWCx5r/pothP1vXIfT0fAnbmeoaDvLow=;
 b=kMRevEgUzdorDCl5yVsvPaGvuemTuzECZQG4YKLaIJf6fID9Dg6Oose+U/hBQJLriW
 VSDFpg3T4B9qXLHQhjxACnTiYVwJvSDszFFLTtxWpdtZSkGnSxLslb/hlSSCj8R1h5aD
 zMdcIX0cJaI/Xo5/1sl6CeAX02rFWn0DeoBmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742311275; x=1742916075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xuCAFBOCVNBjWCx5r/pothP1vXIfT0fAnbmeoaDvLow=;
 b=TwuKO4St7yOLQohodZ26WzIwCilpkBa/JmrdP0p+1ZWZq8pPRRjcj9Bw9H/UnBtX8b
 g0N+g8eWRU3Cmwa+y+BVU7QLzg8gycjtEDaZKfnWjQSUJHP8gFZHPdkXLbNI6l5Fg0tx
 l/UNBgyfGdr1rIhYYrHXZOQ2cQcTUWBOwFJVbrfZ5ZDrW/nKFUh15YLtRX8oy3g9HPef
 WIhVpUgGmm8vy5uMcuEUiVh6bawS+sRNIhlcCz0IBUGr42rTEr9FMIP9RsKELHzspv0x
 KYYcTfdy+OoCeObIldhB+2Yr+fGUVXiSUmmp56Kn4cP3+yVaVaYYCZGXxAw8D3F7wJzw
 gnEw==
X-Gm-Message-State: AOJu0Yy+EudPbr9mywOLcUcW0u7NW4J/wGmL3q6sN5ODLSho6a/+jXZD
 09YF9GiSALpu3hJIoBDlMciLJ37/znTBHJuiBlvkK/UpowArBeW3mpNGrOZgbL6A+jMG8tzpwLG
 shIev
X-Gm-Gg: ASbGncvYrdRfZVle/VzaeyYxkiiiB03CU41T4iwgEbak8XKxiS6nKPRwSjWuuYX07Hr
 DrW8iqZgMtPMCSIUOInYPHSOm8GEWgxIZEOjJvG1wuMZhpScExb2Ka+m9M3xkHgJDweQZBHc1f9
 L+KyffXoi+qkZ+gaKYA+gdDXDzj+Z6g1We5bluaHR9DRiC3Lk4T9xFXaM9gq9RXFDUpgWf7ZCwe
 ELcecN2tX6mwvfsePImcHpXJb7JUxlv8UYU4b32tgKkizvSktz+LB78Baoka87lAl0oSZwIwD7X
 niWlONc77ZuDrJkNlfIDxh6n4UuiSxJfpnU3Lbk0Yw==
X-Google-Smtp-Source: AGHT+IH87/9A+NiSONPNfK8vXiXQqrgFCnIXo9651XK36SnfpVQwIFsHbELYHPLAIcDXU5kgEieOcg==
X-Received: by 2002:a05:600c:354a:b0:43c:fee3:2bce with SMTP id
 5b1f17b1804b1-43d3b9f70b5mr28403285e9.26.1742311275022; 
 Tue, 18 Mar 2025 08:21:15 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe60d37sm136962225e9.27.2025.03.18.08.21.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 08:21:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 4/7] membuf: Include stdbool
Date: Tue, 18 Mar 2025 16:20:45 +0100
Message-ID: <20250318152059.1464369-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318152059.1464369-1-sjg@chromium.org>
References: <20250318152059.1464369-1-sjg@chromium.org>
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

This uses a bool type so include the required header.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/membuf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/membuf.h b/include/membuf.h
index 17616d5577e..636ed703ee7 100644
--- a/include/membuf.h
+++ b/include/membuf.h
@@ -9,6 +9,8 @@
 #ifndef _membuf_H
 #define _membuf_H
 
+#include <stdbool.h>
+
 /**
  * @struct membuf: holds the state of a membuff - it is used for input and
  * output buffers. The buffer extends from @start to (@start + @size - 1).
-- 
2.43.0

