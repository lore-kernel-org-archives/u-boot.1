Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D405C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 12:54:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 664AC84B59;
	Tue, 30 Jun 2026 14:50:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dMRNEpAQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8540F8490A; Tue, 30 Jun 2026 14:39:57 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 638F08490A
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 14:39:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=shofiqtest@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-39b22d0e488so5136981fa.3
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 05:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782823194; x=1783427994; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jxGBiIimqY7wcohMRu60HPIB8EFdje+DIGypd58Fn7Q=;
 b=dMRNEpAQZsKMpWqXb713NeEsARSccFjsTJjsSbIBrjHLfraXuVNncv0IDatL+IwTKS
 9BRE9iNik7GbaOpFSUWKtP/SucAByr4asSsWnuhFtsfL7A/giXnWTOImRMWr89OisbW+
 nvj4OpAF02odXiwgSNeC4Ui64mGr3T7nsTJlY3Pz4KbNlt9q2SCv3Ow7/jg7DnW1CYrF
 aS0riNPEcb/S06ba6AcOdrU3V/XK4IRnukSNuZbefoUOvldneZKfJOyBlffnQpYttOx4
 0MiX9F/RbYxOTFfvdtl2KYae67Vw8FECjU9fVtnBw1t7OcpI1xx+IZnWIqVrkxhgPJE6
 pUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782823194; x=1783427994;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jxGBiIimqY7wcohMRu60HPIB8EFdje+DIGypd58Fn7Q=;
 b=KT7qqM3xiMNVM1OrutLFC5t65seltUcoX+pLfgjldpxM41AEXvu3WDQaOevvxcEK2f
 pga1TB2f7vumYOu34rgbR10Hle998qUspHa4X2Tn5YkIMG6iTejtrc9P+DF9kQHGBPQk
 aZVOGrnQcaAkZ0Cya9ZX2zkzFW2RK81gV406eAoZ4f677mMsVHZQp1gvBTnjJ17zrjG5
 aTUgsQEWdAdAdC6zfi0nd92OGpIJJJuBoiMykB8J7Y/QObyCv40dQAU7k4T7qfxakLzb
 rSgaFoDjM7DZ+rgDBy8p0Psp+Mm9jl66iTer1HxUxlAYBSIeQJr14LUXBdQvHChoZoHT
 PEJQ==
X-Gm-Message-State: AOJu0YxJ/h7y6b3+Am4LmgF8Dy7SOSL+awQgSgwuEKOqnUG2xOVDOuzF
 wkaprLEQbhNalmdk5Qn1rGWqXsljo7XOpPNhbutiy8sYWsU0c1d2te6S96VTbuXWgS2ARw==
X-Gm-Gg: AfdE7cmC3scK9pzX183rjzfnpE0xjarGFE1nLsTWqt8LKfDlrMbGruurz/ULdQo9Fg8
 X5ubmf0JCrZjYW+VaDpOmqHZrGbpznRgTE2+YwKoC/QF5vyLomeVLpbRz3pWd52EjF/w9tHbkMC
 yJsPV1ySAZeF45xwn9yFv+JVGFv1KInTplXkTQpXTlO7eTnFxTat4UmumFJGdSM+KpK/CRnGANU
 2cLyV4P1xJM48G/VWzCUlL67oFfrPj3isWLHlMgRMNeQdgbm3ZX2Z9PeyxbkSvnPaRcvZVgmhJm
 DdNmG6S1bHmZqqks8ZA6DdXA3cPTT+lnhJ0PY7Iqu9ajXi3fO6hK7V4pxd/9+2/RFuegHPzDf2z
 skNtguXz4DL++MSLP1kQSYvSl8Hggw2Z7FolOOST3G3EVGVIyhpZ2xwR5mPn2KxRKZx4jzT828f
 WJM6f+yCbAXf4/phf1XXt9Cd1RlOY3RSFRKVVFSvIuQssmDw==
X-Received: by 2002:ac2:54ac:0:b0:5ae:b97b:9b47 with SMTP id
 2adb3069b0e04-5aec10ceceamr130790e87.62.1782823194183; 
 Tue, 30 Jun 2026 05:39:54 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39b1da4ca90sm4905721fa.31.2026.06.30.05.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 05:39:53 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: u-boot@lists.denx.de
Cc: ian.ray@gehealthcare.com, HuanWang@gehealthcare.com,
 brian.ruley@gehealthcare.com, martyn.welch@collabora.com, hs@nabladev.com,
 lukma@denx.de, sbabic@nabladev.com, festevam@gmail.com,
 Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v2 0/2] imx6: fix LDB clock guard and clk0/clk1 swap
Date: Tue, 30 Jun 2026 15:39:49 +0300
Message-ID: <20260630123951.13385-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 30 Jun 2026 14:50:53 +0200
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

This v2 series fixes two issues with LDB display clock initialisation on
NXP i.MX6Q boards.

Changes since v1:
- Squashed original patches 1 and 3 into a single patch. Patch 3 was a
  correction to patch 1 based on Brian Ruley's review feedback
  (CONFIG_SPL_BUILD is too broad; CONFIG_SPL_VIDEO is the correct guard).
  Folding them together makes the intent clearer.
- Fixed Fixes: SHA to meet the 12-character minimum.

Regarding checkpatch IS_ENABLED() warnings in patch 1/2:
The guards in drivers/clk/imx/clk-imx6q.c wrap a static function
definition and its call site. IS_ENABLED() cannot be used for function
definitions, so #if is the only option there. The board-file guards
follow the same established pattern in adjacent code.

Md Shofiqul Islam (2):
  clk: imx6q: guard LDB clock init with appropriate video config
  imx6: clock: fix clk0/clk1 swap in select_ldb_di_clock_source()

 arch/arm/mach-imx/mx6/clock.c     |  4 ++--
 board/aristainetos/aristainetos.c  |  2 ++
 board/ge/b1x5v2/b1x5v2.c          |  3 ++-
 drivers/clk/imx/clk-imx6q.c       |  6 +++---
 4 files changed, 9 insertions(+), 6 deletions(-)
