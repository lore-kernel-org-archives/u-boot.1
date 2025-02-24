Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B357BC021B6
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:12:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07F8E8141E;
	Tue, 25 Feb 2025 00:08:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H+durq64";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3198380F91; Tue, 25 Feb 2025 00:08:21 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0E6780F56
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3d2a8c2467eso17499655ab.3
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438497; x=1741043297; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nktMKvaRNleBzvmV67CJbGRT7HuaiS6cbJLn1DP15HI=;
 b=H+durq64IoJYgeVLeDoynQgDi2tSGkduTbT2HTvJw6xolXL9WHwzH3gk8HvrD36w7V
 tiE40il6fVlKdpPzBfCk58ggpzo+FA5HqtYXj2MgKzPQyU/LzPZ2wtNNaGVRxNI2GCrC
 cCVg0/sGCEzF0ZAh52dBOdxvBTXTDg6qO2dKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438497; x=1741043297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nktMKvaRNleBzvmV67CJbGRT7HuaiS6cbJLn1DP15HI=;
 b=P7fUvgdivYnC+yVkpR6SW203tVlyzgFUroCUmvTRa60Ibofmkkpu+/8vFZisL8QRrn
 7T4WIpGiArun2OgVShwD+lqf77q5jOzxueDLh/sEPyJCkVS5ibyzwjlPog7ShRobNuPf
 9e4G5zo4kamjnS15PGSOaX9zvLjcTvmdO3IQEgW9ySpWuLI7w8/7YXqy9UFlMARkc6oP
 W2MBslHuvVx4Wx3afDX6ikEZvvIFA8Fw0sNy0Ih0OjAlNtMl5njwbfxLTMdJ//B5EIi7
 ukR14dEIqP37fUdnFkJ4ai4vqZvXCHoJwwF8qtz86PLcBCbNRmx+ePtYFFBTsmXUK1YA
 nhWg==
X-Gm-Message-State: AOJu0YyN3kID9HjCjfU5dqW8lBYq5aeQXCbXeGqgxIFmSSOLZ0kSirBq
 8Bks5My992IsukQbg6/9aOJMIXztK7W+lSnPDAw9u+AUksUsQ6jSAzymiQ2fqq1zDbCC9EKz8fA
 =
X-Gm-Gg: ASbGncsXR3BGDPvW/8muGU9AvlcQWlFNB4y4C/F0hgShjlQMJElKkRsDon1PV9CqaIP
 yjWP7O21hKU0fK8vvgf/dnbTtXKIUDsOZOddTAC3Xxs/uc5VrVx+YZrDoEZeGyc9H1FnFbNMkjM
 xwDiw0Eok0bJItRSJ9KEhZgawloS+FZh6Pr2lfMJihoNgfTJTy4hTHbuoRmpG47NpBkuIO4Wv+q
 cujG6ffHil9QMIlFZE27AI0g1hIk53jeC9Y3rc9316fhYMUqCcmM0niFF98P77PbrGlU4Pu9j8S
 HnzaDOGrnRL9ziAeReVQ+v7aUWOxbWvWijdC6mqQ6bZjyFrm9faEY4s2wXKee8Q=
X-Google-Smtp-Source: AGHT+IGB3ZTXnPav3X4M3J60WNnClrxxXzf7nuJCTh6hXVrDygyy1UpCCC0z8aFGdBykJEURFi+Yyw==
X-Received: by 2002:a92:c56f:0:b0:3d2:b766:dd9a with SMTP id
 e9e14a558f8ab-3d2fa6671a9mr15635105ab.0.1740438497150; 
 Mon, 24 Feb 2025 15:08:17 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:08:16 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>, Nam Cao <namcao@linutronix.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 38/44] boot: Support IO UARTs for earlycon and console
Date: Mon, 24 Feb 2025 16:06:27 -0700
Message-ID: <20250224230640.2665206-39-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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

Update the string to take account of UARTs which are connected on I/O
ports, as on x86.

Fix a typo in an error message in the same command, while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to support IO UARTs for earlycon and console

 boot/bootflow.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 58a1afa7a75..4054a966af8 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -942,8 +942,9 @@ int bootflow_cmdline_auto(struct bootflow *bflow, const char *arg)
 	*buf = '\0';
 	if (!strcmp("earlycon", arg) && info.type == SERIAL_CHIP_16550_COMPATIBLE) {
 		snprintf(buf, sizeof(buf),
-			 "uart8250,mmio32,%#lx,%dn8", info.addr,
-			 info.baudrate);
+			 "uart8250,%s,%#lx,%dn8",
+			 info.addr_space == SERIAL_ADDRESS_SPACE_IO ? "io" :
+			 "mmio", info.addr, info.baudrate);
 	} else if (!strcmp("earlycon", arg) && info.type == SERIAL_CHIP_PL01X) {
 		snprintf(buf, sizeof(buf),
 			 "pl011,mmio32,%#lx,%dn8", info.addr,
@@ -954,7 +955,7 @@ int bootflow_cmdline_auto(struct bootflow *bflow, const char *arg)
 	}
 
 	if (!*buf) {
-		printf("Unknown param '%s\n", arg);
+		printf("Unknown param '%s'\n", arg);
 		return -ENOENT;
 	}
 
-- 
2.43.0

