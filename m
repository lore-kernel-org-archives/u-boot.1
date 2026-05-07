Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CDACD3439
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 14:54:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A039784A7D;
	Thu,  7 May 2026 16:54:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="CqO0fKWA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DFA184AF2; Thu,  7 May 2026 16:54:44 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64CE484A7D
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 16:54:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-694891f8f62so492576eaf.2
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 07:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778165681; x=1778770481;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=etSw/srcm+PjLKNxo5qxhXfRxY76XE8bD6MMaY+N1io=;
 b=CqO0fKWAbDPPHKKKEKmnSrZEBKPnOQn0W9iASWFFxUyI9U4wUnFbrIqpxs9BVPCUq0
 7fibmzmhrlk9OoLi6nY4SSu3de691BrX3heRqkihzfKJQcilsHKPjxE54LhgKyCBKYg7
 avS0zXWq+E5ehz/h5C55g7M1m0qjL6cOp11phDxcJExEwJpgP1f05fgaCiJ2E+iDEJEG
 QRVeu0VGAQbphNNSbupm8RCVAzsWY58v2DUvz83Y/hkQUMOk5VNDtuXx7jWd4ILfSbul
 ozsCqRTX5mTt+4eLLJ97ctIoLYr0gq86eVKJLikvDs86B7xxlON9SeHcqkwhLtw879aS
 9SuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778165681; x=1778770481;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=etSw/srcm+PjLKNxo5qxhXfRxY76XE8bD6MMaY+N1io=;
 b=oU0P2zechLJGS9cUPmnT5KNodJ99ro2FJYyjUNRK7U+kPLgtTB4Hpwi7SCxkN+OlAw
 eOB8miYJEPNYVHVcAzR5k25sbKmPAJAk+9gSLk7nQU0l+BiZZYdu4PkrJUWoc+5qvmNv
 MOGRSp9xbTc1BOwd1TxVX28VEjhInfb5mHBCtHMNIl0YTZMQvX6EuyJnA9TNWoU//Ew6
 OrvAuuvjt1LwcbzVqMsja1Fy29Mm8W/wE8RCByMrw+Sqw9Hqx+pZfHF6bUkN3YkgjhcR
 pyBMS2yB4bE0ZEiFdKvTgbyqMyqXhKuSris/cCN1nODd6GOLWHTmcfVcFkXgwLTyla9k
 3LaA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/LqHm05FOND126k+Rpaf07WnE8oT+1WAlv6tUsw0jDdhjE+XoSdKB825rSCuAG2s5XYXEuE+s=@lists.denx.de
X-Gm-Message-State: AOJu0YyrbQGWukDaxXs/NX8P7qA/zcG5+jXTl1NHGerYUx/ywd7W/vHh
 sqoF3qwZuyQ+zQZBLPgZrmV21BlLbfD2p4FHWXEWGY8SFkhMKFVYRYrxd1XT+k4vugrQDuo9nzk
 RLOCm
X-Gm-Gg: AeBDiev3kJvDDBkDUbExKVU3i+g1xRuY6e5soggNCBC23JOfERTclDBgJKu/7YOQm7w
 X3eKtFfYVASt721Pf/hTj6CK8mWLbrWZTU0n69ZpW6X9XKVJz+XHjCCmTKhpt0wQ7WnDaFgHYdA
 Zswc4gjWgqixenToNjHxIWn31gtygkvEgm4gXZ4DiNI3i4XrtoYHgZ4VU9Tk8VQPtcNwqz15kvM
 KrtXyPwo4xKlmCGlKgtEkmV+p3xBSL6DRGDH2uP9ADJAlZKYxjlphK4EBQLcnWf8UdD+h0mXcC4
 9dbTsd/ZI5IuVgmrnwGkhaAD2s8auMO0Hg5J57UfJhMsKwqMSeHwBinsC2VtA9p6UL3YqJyunHU
 si/MbaeHOEt9CWVc/q3mF2/L8RYZ5MOdTp4CEPeBG3JIUk35iv/zVAOmgv80J9k+BGevAmAy/we
 dq7Mt46zB2RgrxRpkS3CPoMLjDbC9dW0C5CHdeA/4m2PltbTWq1A==
X-Received: by 2002:a05:6820:81c6:b0:696:1e8f:a03a with SMTP id
 006d021491bc7-69998ccdeb6mr4496968eaf.24.1778165681146; 
 Thu, 07 May 2026 07:54:41 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7374:f02e:e8be:88a5])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69689266bacsm12151275eaf.0.2026.05.07.07.54.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 07:54:40 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 07 May 2026 09:54:02 -0500
Subject: [PATCH 1/2] configs/mt8188: enable bootstd, FIT and DT overlays
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-mtk-genio-defconfig-v1-1-5ca5d5c956cb@baylibre.com>
References: <20260507-mtk-genio-defconfig-v1-0-5ca5d5c956cb@baylibre.com>
In-Reply-To: <20260507-mtk-genio-defconfig-v1-0-5ca5d5c956cb@baylibre.com>
To: Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=739; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=z5si8CsMmRFoE/c8o5veir+ORD/xdJh6yKQ0K1KV0pE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp/Keh6InDDnIvei8OA4ef8UKLXe/17mG7+PO4J
 RJABn9dpfiJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCafynoRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A28YH/RQJXbHOoFlfJAzLQ5wyhXEdLXtheEuOtAQuaNJ
 4MJTdin8c3L5/4StAbSxPrAKLXaZcjUvp03JPWOgdFzZj2rQwaUnnHQVYfvTQ81xh2jJ8Ia0W19
 28VY2n0OSffh5nyBZrUQrdFtU33PDYtiTRViFTynk+NLcdQ8L8eWggF7aA87P7uMBfZQ7TvUVAK
 HGjG9iLMFNo0/E6uWpSzWRQYOaE6lxOaP860yUw0SlWoFjr4DoGr4uw2+2phdpg/MxIseu7hF6P
 q+r0U3QhyRnVz0HKrzgFUST7DWuRYpHYnTJDtV36sBLsaQ6YEJ8PpDWj4MthXIA68DfpMTAEqGi
 dJ6s=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Enable options needed by the default board support package for Genio
510/700 EVK boards that use this config.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/mt8188.config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/mt8188.config b/configs/mt8188.config
index 9dfba6bf99f..55ceba44d45 100644
--- a/configs/mt8188.config
+++ b/configs/mt8188.config
@@ -4,8 +4,11 @@ CONFIG_POSITION_INDEPENDENT=y
 CONFIG_ARCH_MEDIATEK=y
 CONFIG_TEXT_BASE=0x4c000000
 CONFIG_NR_DRAM_BANKS=1
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_TARGET_MT8188=y
 CONFIG_SYS_LOAD_ADDR=0x4c000000
+CONFIG_FIT=y
+CONFIG_BOOTSTD_FULL=y
 # CONFIG_BOARD_INIT is not set
 CONFIG_CMD_CLK=y
 CONFIG_CMD_GPT=y

-- 
2.43.0

