Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BED9CD5BD5
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 12:58:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4752884837;
	Wed, 27 May 2026 14:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=binarly.io header.i=@binarly.io header.b="dXvYxY+k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA0928341A; Wed, 27 May 2026 13:25:24 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 962DD803C6
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 13:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anton@binarly.io
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-516d0db9372so49158671cf.2
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 04:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1779881121; x=1780485921; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y12FDt0B/XoRtZ5eCT5Jo1RyqGvbeGUCpSwH4gZtHGk=;
 b=dXvYxY+kR/qsSfp9DwHxCpd/IY/DDrwfSsJfbyPmHEUIsYGcyHxJz8kqy8GpgHiXH1
 QBg+fTBwq5bpWrbm6JYqvgVOwXngEnNAxjXI12RtYQbQrGQQnr+9f7uvApwe8t6K/Qis
 av/zKUNHgY8GWAQo2xZyFh9Ox+R/HxU/tHIir+m3QqiJKqSH7LlOaoHACgsLCPXh1JMY
 xoONz/qNI+BaCP6Qs8+C4Rldv09TxNX2KmA7Rp6xc2N/Vwns2ke3A85VLLTaQsfP7PKt
 7rFeKRwXQ+j+1HcghWl5q16dbEdQmmjlbmbBrKFb6AcIuqZ2Dov3kYobykBnuPaDx3oY
 7haQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779881121; x=1780485921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y12FDt0B/XoRtZ5eCT5Jo1RyqGvbeGUCpSwH4gZtHGk=;
 b=BYdo7Yzop3eahp4fYHtIA5AkLH59IG8DP+JegWfqLhOVsLhBdQtQTwrx+0+uOjiP1E
 Bgl1T+OCMYUiHfpzTTiJLrcw0oS4Ckt903SQdxw1OQxm5A4/HyDLp4l8Q10g1WyRv7jY
 L4BSkMzU9wNA8Y1QRe9bue448t3Zl9eGJ2N8YtLjq06iftSt/FF5VLiu0dgmU1yl9FvE
 eXv8LY3Vvye6ysAjFqXEVY0pumgftcugIfInWPxEASPyIHUKXTiTu6erQU5W5xACYjLd
 0HZs52Ch5HqgM8tv9mmFuXBaGOLP5mFYMiuN4PCcDBwYSjqMCQEAkEo0fDvys9N1fK7Y
 sKhg==
X-Gm-Message-State: AOJu0YyBUato00RmOoOre+k6oyvoaqFu2dgMN3YKQa6q93d3blTR6B8R
 kLs2XTRzK9aiGXrEOlMvqkb5cAHSWIEQiOiAadv+djUtVFjyHAGWuCHs583Cv7nnQD3yqivAtkM
 x4P/19DEQQQ==
X-Gm-Gg: Acq92OEyHkaXVhtWGpGznoVTpoaNG/Cjhm+iKMTLJL9U59G5NNgN886zWPeBcKkVNIU
 1hWzeSprs7WIZQ1F69da3km+n3b8gDhpzyKNXiB8g6KaJlq49XICUUhEaQnfJZ1ceezfxcoCSEx
 SA48QwpUhA8ckC7IzI+jNoWoA7U/iBb5b3SohSBTFbKHeWg8T00pLiK31pEID7qvnh1tHLKl7GL
 kjcTkC4qRP8ZkP2Z3myQpvNJa60NgbihqXkqUQIsV20Rpcuv32i3Bq6Ad+Dja4ItLc4d20qM1rl
 9hWQpOLf7X275mD7VVzv7id+HcjwZ+sSjXpatYGYaNqThY/PMmNQyAw05l+XQMRkQf+CN69xR7a
 PQ5leauAi27u0Ny9QxNzJcQ2ZswKUrQ7AV8ikOr6IkD8U0hPp1LGXxIGYV+m2EgieTlR+s53L2H
 zuYgyhKgm1qAEv7i2kC4oPjIekOUBTRsi7Wu/CP8dhV/Dycg==
X-Received: by 2002:a05:622a:5c09:b0:517:146d:185b with SMTP id
 d75a77b69052e-517146d224cmr16431421cf.30.1779881121450; 
 Wed, 27 May 2026 04:25:21 -0700 (PDT)
Received: from localhost.localdomain ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc6acc42csm591884366b.63.2026.05.27.04.25.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 04:25:20 -0700 (PDT)
From: Anton Ivanov <anton@binarly.io>
To: u-boot@lists.denx.de,
	sjg@chromium.org
Cc: trini@konsulko.com,
	vr@binarly.io,
	Anton Ivanov <anton@binarly.io>
Subject: [PATCH v3] image-fit: Validate external data offset and size
Date: Wed, 27 May 2026 12:25:18 +0100
Message-ID: <20260527112518.16085-1-anton@binarly.io>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260526105539.50736-1-anton@binarly.io>
References: <20260526105539.50736-1-anton@binarly.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 27 May 2026 14:57:27 +0200
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

fit_image_get_data() uses the data-position, data-offset, and
data-size FIT properties without bounds checking. A crafted FIT
image can specify values that cause out-of-bounds reads during
hash calculation for signature verification.

Validate that the external data offset and size are non-negative,
and that the data region fits within the FIT image bounds.

Signed-off-by: Anton Ivanov <anton@binarly.io>
---
Changes in v3:
- Update From and Signed-off-by to personal email

Changes in v2:
- Rewrite commit message to be concise per maintainer feedback

 boot/image-fit.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index b0fcaf6e17f..4d0e8ffc79f 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1084,8 +1084,24 @@ int fit_image_get_data(const void *fit, int noffset, const void **data,
 
 	if (external_data) {
 		debug("External Data\n");
+		if (offset < 0 || offset > UINTPTR_MAX - (uintptr_t)fit) {
+			printf("Invalid external data offset: %d\n", offset);
+			return -1;
+		}
+
 		ret = fit_image_get_data_size(fit, noffset, &len);
 		if (!ret) {
+			if (len < 0) {
+				printf("Invalid external data size: %d\n", len);
+				return -1;
+			}
+#if CONFIG_IS_ENABLED(FIT_SIGNATURE)
+			if (len > CONFIG_VAL(FIT_SIGNATURE_MAX_SIZE) - offset) {
+				printf("FIT external data is out of bounds (offset=%d, size=%d)\n",
+				       offset, len);
+				return -1;
+			}
+#endif
 			*data = fit + offset;
 			*size = len;
 		}
-- 
2.53.0
