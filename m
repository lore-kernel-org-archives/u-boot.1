Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3B6C3600C
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:15:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD5F58219D;
	Fri, 28 Mar 2025 14:08:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gNPaPGHg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE02D81ED8; Fri, 28 Mar 2025 14:08:49 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 938A18210A
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:08:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3cfc8772469so7350885ab.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167326; x=1743772126; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CVGc4Uv7gV6eYbqeXyRG/lEjAEqCWRxYvrsAb3aQhg8=;
 b=gNPaPGHg4mXJ9d08dFaDw5Vr6xuvXxHWt88+fVGLPPulTaAOvoT2J/mN6b5gsqFlR4
 xsET4/NlFQp1UVRF7/T1XYoahmynCBKxEbseghrIMwIzNhEud4C1ka2tmCjEZB/kw751
 CVr1H5Jk9NJPU+Dte6DMg6uuP2iCoRIwVkDxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167326; x=1743772126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CVGc4Uv7gV6eYbqeXyRG/lEjAEqCWRxYvrsAb3aQhg8=;
 b=kn7+8FAnSsqSgNCWfS27cbho8MCkEc7t5h8u2IjFjVRkMPmlC9Y24cgt+0ux6rUWXJ
 X8jOjS+8YwMS4vNK8Dx7Lvm8f6RPPux7U4hl8/kObVc1AsC//x3kHvumkv6+uUzweMKB
 FHOxb6Q7ZGhFmnc5DY9jDv/jSrKoJZSkUChdDdYWWRUUlsG89gOSgsvr/0po0nO4sisa
 J0BUPJeh04H+CUUpqjUMbsPoL7ZzdLRo+rjBezKEMt5Mjii5asQKoZuuZpYV0YSHWT9T
 SeimwOJMQ7a+Vr8rZHpLiF7twYGBGflOK0EhLQ00q7ayW8alNGvxO7TMYthktzieqyEZ
 lwzg==
X-Gm-Message-State: AOJu0Yy9GdzE3j4QpeBtKjr0TMNQhcrvD0dbLZnO/Ey+XrUwqcbe5mFS
 1Vw3zmWo4ZaYKwaYGWHSSE/HihYkQIoKk1hF18bLK/c/lJeKRrs5ypx8FT7wSC2s5XWY9oS1iKI
 =
X-Gm-Gg: ASbGncuurxkaz4/4r/CpaKgqRt3zwk5zezmiedHiK7T/PzgLemvKpnkZqT2kpedwAk0
 ITBNCoP6MrTLTwnosFx5Jl3rAJpG+kC2UFZaO4bkKHsHGZrzOYaan7GMZy9isbYcoTDeVcvbTHK
 vpb1XJk1/w0qTg9X5tWQ4tyQDkhDSbfH2j6Uuvt8Y3AJS+kIfX7v88l3rXbdLcbVlsICJ4XCPbG
 P0oNlCrDYAtq16xW3hJzPOKqliDAS9DaaN5vS1FAuGs9yB7b6INfL2dyi52gT4RNhAN7IDDzuCZ
 ejYrS322BkUdQa8pcZA/0Z2hAQ5JJHXHwVbQDVkQs8F2v8SdUjCTjPncI7UAWkgLFZ+/3dqz5Jg
 JDqJJDA==
X-Google-Smtp-Source: AGHT+IHhLcsCxXgXqwvUQWZd01QWpB5bBvOzzHHLLnk86VW/UX0i2fgU/IaqsyYvJ+2ka+5XJh1k2g==
X-Received: by 2002:a05:6e02:188d:b0:3d2:aa73:7b7a with SMTP id
 e9e14a558f8ab-3d5ccdd53b3mr85717475ab.12.1743167325686; 
 Fri, 28 Mar 2025 06:08:45 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:08:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 46/56] expo: Drop the gap between groups of menu items
Date: Fri, 28 Mar 2025 07:06:33 -0600
Message-ID: <20250328130713.2612648-47-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328130713.2612648-1-sjg@chromium.org>
References: <20250328130713.2612648-1-sjg@chromium.org>
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

The gap is intended to separate options which are on different bootdevs,
but most of the time there is only one. So drop this gap.

Keep the code around in case it becomes useful to have it in the style,
or based on some other mechanism.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow_menu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index 986334e95e2..ace89545fa9 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -117,6 +117,9 @@ int bootflow_menu_add(struct expo *exp, struct bootflow *bflow, int seq,
 	}
 
 	add_gap = priv->last_bootdev != bflow->dev;
+
+	/* disable this gap for now, since it looks a little ugly */
+	add_gap = false;
 	priv->last_bootdev = bflow->dev;
 
 	ret = expo_str(exp, "prompt", STR_POINTER, ">");
-- 
2.43.0

