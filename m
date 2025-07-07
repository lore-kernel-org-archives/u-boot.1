Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C9CC83F07
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 11:28:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ED978305C;
	Mon,  7 Jul 2025 13:28:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U2rpr5ry";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7978830E4; Mon,  7 Jul 2025 13:28:11 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5F808304D
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 13:28:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-607ec30df2bso5753935a12.1
 for <u-boot@lists.denx.de>; Mon, 07 Jul 2025 04:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751887689; x=1752492489; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TsfwwszZDwA/K+cQSEAW79BLs23+A9d3d7w7MmaG9Lg=;
 b=U2rpr5ryVDn3nOARXkmFw/j3oL6YCgTC8jNoK7dBKzHK1UdfEK4vaIVSzK0n54oI9m
 GhWd347LDdoHBm0wwaNzak/mRXtSvJBkMenWp0HvlOUhEt2feufsxLpqIITgavX7u7Xa
 o8wo8lJ4bJGUWJjU70NqX+x1e7cMdFSelIQO7ZQkvM7gP6VOWYK018S/6cMNV4sg5E1C
 BFlM0N+xlrFIDplMR8owB3B1GAgYURu8PQRrSZlM/rL6AWNnMrOMa1IPB6E9TtxtTKVr
 XdPYJN3Hjo6vK4sCPsosGu4wu12Gkfq8egZUFFottS9zgs4Jr6Exso0/eC91rdnVH251
 3ZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751887689; x=1752492489;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TsfwwszZDwA/K+cQSEAW79BLs23+A9d3d7w7MmaG9Lg=;
 b=bic0A7VxYWMJbizklD+xXAKGeeVFYdxS/TqF/kh9ZXRWYhSTsoE0WA41PQ55g1eBt+
 SVR/yNcdn7xHAw9uGJUH/FxMXNbuA8bmuNbFla180HZrK2D+J3ZKjwhX6rDFMHFUDqgG
 R8GZBS6tpfY0OxYPW9mArXwflJyjeEaSg2shM03TklpFUpjUriiK5xBUvSYkgisqbL/C
 o9ubYqJ1KGGP1yNH4lAhKlRklTvu+QnBTts7qIgOs+JSuGjkWEHoZpvrzi4GoUobpjWD
 z1pSpj2B1LyE0k4BdIwITBDkXvhOZ86x0WVJ9zOoRSlFvX7iy9v7MZCPuPaZpU1U8rfN
 AMVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0uxegH6R/Ldk23smzFVKZLTDjAyU/tXWfKOfzck7o+V+pyxD/1LKr+bnEh6RxK0jtKN1+wRU=@lists.denx.de
X-Gm-Message-State: AOJu0YzudJo92trpnAYue95aHispOJ13nkDRRc55hTyBvBdaFuHmPHEh
 p5O5LiirlFM9hllkhu4iCt6Tg44/yw1SxVl7s8yvLmRnJHBjHQoKnUJKwgx5mDtL5wI=
X-Gm-Gg: ASbGncvImEy0G3JY2eNs7KIJtnonTfWet85ok8YyDtA5wPC9VWWXxAzbyoJesGRNaav
 E3pXlauI1a/bXDrmNBsldihNxX5RwOciV9EmKit89Juq1qiTw1S6li+onswnfQlVHSHm0ZuxBij
 sYhcGswT6Od2AzybXEAcLuSTlYueN0QD4z4NNqI3N4u4lpZMOW/wc6I5cV4Am6+crzu5MzwgagM
 ngIFKEtiB3hFLL4YJk7vhlmLET6fmGx8Hg7kWBoUuPcMJvhx2/3CeVlAf5MdLexBjLToSQoK0Lq
 7DTyiB7G9EykLhsFzRgGfUXDsUojpmNalFRD3GriCqo9LbgDImaDWAmaDwdUFQ/xZb1AULHj+3n
 D5+sDm/JDx18B/ECrErEC0A==
X-Google-Smtp-Source: AGHT+IELET6I/4e+fcayzV8WaIPyRINQG0dWzxQbFIvcf2nza/mUhRa6A5gdGEcD9X+J1tu+CPgfyA==
X-Received: by 2002:a17:906:f587:b0:ae0:ab07:7bba with SMTP id
 a640c23a62f3a-ae4108e247amr691680066b.45.1751887689221; 
 Mon, 07 Jul 2025 04:28:09 -0700 (PDT)
Received: from hades.. (ppp089210105145.access.hol.gr. [89.210.105.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f6bb53a1sm693661766b.176.2025.07.07.04.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 04:28:08 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Maks Mishin <maks.mishinfz@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH] tools: ublimage: Make ublimage_check_params() static
Date: Mon,  7 Jul 2025 14:28:01 +0300
Message-ID: <20250707112803.103895-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
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

This functions is only used locally and triggers a warning when
compiling with -Wmissing-prototypes. Mark it as static.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 tools/ublimage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/ublimage.c b/tools/ublimage.c
index a1bd807bfa03..8926d5b178b6 100644
--- a/tools/ublimage.c
+++ b/tools/ublimage.c
@@ -219,7 +219,7 @@ static void ublimage_set_header(void *ptr, struct stat *sbuf, int ifd,
 	parse_cfg_file(ublhdr, params->imagename);
 }
 
-int ublimage_check_params(struct image_tool_params *params)
+static int ublimage_check_params(struct image_tool_params *params)
 {
 	if (!params)
 		return CFG_INVALID;
-- 
2.43.0

