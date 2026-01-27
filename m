Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E0CD2D8FA
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 11:04:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30ADD84056;
	Tue, 27 Jan 2026 12:04:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Zsjk8m1x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BBEB84034; Tue, 27 Jan 2026 12:04:26 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AC6E84021
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 12:04:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4806bf03573so902315e9.2
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 03:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769511864; x=1770116664;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BkfbjpLH8Nx4YgXSYQWeRSdUMKGexs7y2wwpJFve7R0=;
 b=Zsjk8m1xwXle/EZeR7xeKWGn7t4mng8VpN3S6cupX1jauNYefwBHn2/5PIgbCjVr9M
 eH0Xv+Na538bR3D2VyzO5YwBcx/0467WC/K0l4m1njKnkdifH9Wqj0UYbNJ7AYude+g6
 /9BXdKxgiklwEJZHS83nprjWSzv5frvk58P+n/zi5PyawZBj1hNq+UZxEgfpjJ8bzvQQ
 vVVVNGMf1CDoWwKCsOo9NpsWjgiczrCrz9hZtqRPlHCvP0XPcDs6kDf8gB+cfn7RK3su
 +RCQKa3n8QoKJtKSVMXI8i78VoJ8eAC69UzSins6P28UFs6bVwaCrv/mHkkNrFpLD5kQ
 I9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769511864; x=1770116664;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BkfbjpLH8Nx4YgXSYQWeRSdUMKGexs7y2wwpJFve7R0=;
 b=bY36WlqvM0+eRWotsfL6c49FsXMjqLtxyRVsaT3VmhRcSTa6uLu6SuJ+TForZiejUx
 0EOh+S5kCTtUoVUv8ZY7vV1CRt2AbCHbep4kBy7LH1Mk2VNk3m46zQj3QEvY1uZrfX8K
 yWV+Ev4uxnapltL+H+rFdgIGGg07uOJ0VHZyh7nZrM8Jk8SJs9WqRFgm6QXtXsjt/Lhq
 i//xs41DSQcDGYEPstNhvpZmAiVMuSJbVkxuJkqPXCJQMK5PQZ2prTRm4qTq+p14ej4L
 B4CAukKNVe/8CB15HCTxZF+oPrF13klpO5QObdZTFAC2FIwR2X9g0S/jNFhVayFQUK15
 pcWw==
X-Gm-Message-State: AOJu0YzvYNzbajuwH1o/9a3X+VL4h55jTCN8ONUJSumdr/3WPsZwhYDl
 lEnesvxdz5asBM+vLdGh57fbl07AWJJ/9+7ofiQeLmRU9WcX/Ff1+WTkg3iGqK8fCvc=
X-Gm-Gg: AZuq6aKyVhb/96r2sxQky9aoV0ZUheUZ5Y56bHuG8NW7A/MTniGr5QNyQr2qM1UhG3N
 gc3wW5u8ULigeCAqmPZ9On5/g34/IBsXIVbryJX4l0XtTWFgBcupKBaV+YtbjkFjyiJoMdXJ6jC
 rgihJtAu62NOQTFLK8vsbCoYoOTwFA7S0LkRcakPsl3qIyRjP6mpMRvljrKhveRScLfHXNom1WC
 YtBXiAg9UTAq/mnPhCwO/0urtHakxM5eoSsRqz4DwJ2rE0gJ8E3aYTG5RSuCXhHh/FoPk3SK+kb
 3O1Tt1V5T1icuY9cZqmnji17kFXse2OoPthcpxg+5E11nzqhqxiyVWdY1CnQg931b/8a6oALGTk
 /txNYMw5i6yrT3XFpdLKSZCiFsR3oFdIbT47My3UaBL//1TEkxaH7CcRdu22ir4F5XTeNftEYez
 g4EBRPOrqA
X-Received: by 2002:a05:600c:3e16:b0:477:9b35:3e49 with SMTP id
 5b1f17b1804b1-48069c2c0bamr16474535e9.3.1769511863878; 
 Tue, 27 Jan 2026 03:04:23 -0800 (PST)
Received: from localhost ([2001:4090:a244:872b:a354:65f3:92a0:8de7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066be7623sm52120615e9.2.2026.01.27.03.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 03:04:23 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Tue, 27 Jan 2026 12:03:38 +0100
Subject: [PATCH v4 4/7] dm: core: lists_bind_fdt: Indent continuation debug
 log message
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-topic-musb-probing-v2026-01-v4-4-ea3201e0f809@baylibre.com>
References: <20260127-topic-musb-probing-v2026-01-v4-0-ea3201e0f809@baylibre.com>
In-Reply-To: <20260127-topic-musb-probing-v2026-01-v4-0-ea3201e0f809@baylibre.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1038; i=msp@baylibre.com;
 h=from:subject:message-id; bh=JKfe6Sx2yWW6R+vVXG3bgQ3+2p5fY5Cgye8AG2CqamE=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsyK2fNuCMe3rv2/Mnubf6zukaun908rTgiRCVt/kn3T1
 VkLfu6V6ihlYRDjYpAVU2TpTAxN+y+/81jyomWbYeawMoEMYeDiFICJqBkw/HeV/RMs98fh8lv7
 ZX4nboQleyt79an1P61XXH9upeymHmlGhh3nYkQ0Pvz4Jea7eN7L8BqbuM3nfLL1hOavnvtxV/8
 Zf24A
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

The loop in lists_bind_fdt uses an indented style for log messages
within the loop and normal messages for errors that lead to the exit of
the function. Due to the change of the previous patch that adds support
for continuation on -ENODEV returned by bind, the log message should be
indented.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 drivers/core/lists.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/core/lists.c b/drivers/core/lists.c
index 813c3de52b23d78528686a7a8d9ecbe8cab62efd..2545dc142f6bc3d01dca1e0618055a64978734f3 100644
--- a/drivers/core/lists.c
+++ b/drivers/core/lists.c
@@ -266,7 +266,7 @@ int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
 							   id ? id->data : 0, node,
 							   &dev);
 			if (!drv && ret == -ENODEV) {
-				log_debug("Driver '%s' refuses to bind\n", entry->name);
+				log_debug("   - Driver '%s' refuses to bind\n", entry->name);
 				continue;
 			}
 			if (ret) {

-- 
2.51.0

