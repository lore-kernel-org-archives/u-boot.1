Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03AE2C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 17 Dec 2023 16:37:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D141E87CB7;
	Sun, 17 Dec 2023 17:36:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OsuaKEtl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0FD687CA1; Sun, 17 Dec 2023 17:36:42 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1476887C96
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 17:36:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7b712c0fddeso94734939f.3
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 08:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702830997; x=1703435797; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FyN+CCALzM97LVpap0P1DTEpXMA1KXjvqQ1cTjYEngU=;
 b=OsuaKEtlQMTZ7HMzXpxJlqbMVjcGJIn8hMlWohwgqnZ0hbo2ZVqr+alEQdSPYXtuMP
 KWc3KGWe0C9Gp4OFfYOxbQo8BNBQv/qO5K80M0lJMfa9gr/eG5yQlI99G6sZ5N6wwUol
 P9GkYibK96IvAvjB4dtiphLMNTl/K6DfeA/sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702830997; x=1703435797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FyN+CCALzM97LVpap0P1DTEpXMA1KXjvqQ1cTjYEngU=;
 b=camxeXlB4Xhu8156eoghq2Buz38W9rXMnkqD27LeMLhMMFQS5UdD9qFEkSnAOtplKs
 VNMTnxfXn3kr6QN06w1Fy0Zi5el3vM4dZFhabN2Y6yfT1OQvsrZN3xSQa/WaQ4jdbcMh
 mEMP0G/JUl9oMDd9MnCaadXRbhhh4h5epLzKb4nTz7gC5yUChoJJLHSA2bvWEVuJzYor
 LpBgZkA9JuDuoktOazDL+HBqt1Mu2DQ4ARB4bvTuflzlVTi0BUKS1I2oP5KlhZAf12n/
 lM0pAx5g050YqYw4PRImwHcz00ztHmQnydFK8/4AOjjas6OmXNuiOAtHbNXp6Pebgh6J
 PqMA==
X-Gm-Message-State: AOJu0YzgkoBrGN9l/4NTieZSLN39CC63wcwa5JA0i7abZN7y/d9Be0hx
 AyUIqMTrIU3VfPlDjwge3YoLVS2lnM0e9c/w1fKgaQ==
X-Google-Smtp-Source: AGHT+IHZtegRgKFNcqgHfV2gZp/vPPgcl+VHr8wWw0hSTkKBStxptntvbdc/AuGcBWSLlaeJaTXiqg==
X-Received: by 2002:a6b:c891:0:b0:7b7:29:bfb2 with SMTP id
 y139-20020a6bc891000000b007b70029bfb2mr16973603iof.10.1702830997619; 
 Sun, 17 Dec 2023 08:36:37 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 ei10-20020a05663829aa00b00466917fbfc4sm4925770jab.71.2023.12.17.08.36.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 08:36:36 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 04/10] fdtgrep: Correct references to fdt_find_regions()
Date: Sun, 17 Dec 2023 09:36:17 -0700
Message-ID: <20231217163627.2339802-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231217163627.2339802-1-sjg@chromium.org>
References: <20231217163627.2339802-1-sjg@chromium.org>
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

The function name is actually fdtgrep_find_regions() so update the name
in comments accordinging.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/fdtgrep.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/fdtgrep.c b/tools/fdtgrep.c
index 41d8b41252dd..b56d2fe21c9a 100644
--- a/tools/fdtgrep.c
+++ b/tools/fdtgrep.c
@@ -576,10 +576,10 @@ static int check_type_include(void *priv, int type, const char *data, int size)
 }
 
 /**
- * h_include() - Include handler function for fdt_find_regions()
+ * h_include() - Include handler function for fdtgrep_find_regions()
  *
  * This function decides whether to include or exclude a node, property or
- * compatible string. The function is defined by fdt_find_regions().
+ * compatible string. The function is defined by fdtgrep_find_regions().
  *
  * The algorithm is documented in the code - disp->invert is 0 for normal
  * operation, and 1 to invert the sense of all matches.
@@ -822,7 +822,7 @@ static int do_fdtgrep(struct display_info *disp, const char *filename)
 				region, max_regions, path, sizeof(path),
 				disp->flags);
 		if (count < 0) {
-			report_error("fdt_find_regions", count);
+			report_error("fdtgrep_find_regions", count);
 			free(region);
 			return -1;
 		}
-- 
2.43.0.472.g3155946c3a-goog

