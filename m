Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D794AF8FA80
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 14:10:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C3FF8412A;
	Tue, 21 Apr 2026 16:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="lvXuqOkM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B9B583E76; Tue, 21 Apr 2026 16:10:22 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED45383A91
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 16:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d4c12ff3d5so3855322a34.2
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 07:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776780618; x=1777385418;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UsVJrdAIAIIfS1IRk6VW6Es0XgzyTiBZRBnW5A95pO8=;
 b=lvXuqOkMQq3mTrII+KrjcL38q1+Faw6FvIUKyiZDD1+wdH/aSEryfQ8QpJkUke4PJc
 ez4xlmFQP2Reix1eh71LonfgyOhi9e44Hr+SbI9txAEbZY5QauaQH7Gk1jmaOK7ITTKi
 4wafTtdlDtm646l0HWgAJ3Pp1SF1L3NhT8rf3RZcNDTJFxUdC46nH8hYF1qYxaWE8s9H
 7Mt6rXylXbY0VI6fpZD2yLK/QHRf4TNu3JU6GVSrO5QBLEMyvMhaSWk3Jbnv5vBLXOWW
 T5yY0E1RCpLgBQ2cIb7WlmIBYcYlQ4+7o2JUSu+Jl5IMCzNhvle7XIH6PewERZPZV16h
 muMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776780618; x=1777385418;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UsVJrdAIAIIfS1IRk6VW6Es0XgzyTiBZRBnW5A95pO8=;
 b=QrXAfb5WQkl/mN1Nb5+JoULWdvKnIWh2qcqvc+qTJQ4MLI7akkKAQTspAmo86PB5Sd
 vxu0+pUEWlXfyXjcvHTjHkrU40U4lTRaWB2bFihtTigkQd/D9AM/xCl7zDUipEvEIaZF
 uutWWSR99lLNELUI2XdpH/sVEpuPqkfjFoFm25L8pI9UaG8nAWgZHl3s4vbD0G83w+C9
 fcSzdKqdrPni6w2Qnlt1Wf4cdBrBsuqwUrgdh0T8Py56g8+zJ4/XtQwR6XwVCK5Vr5L6
 9KLKhgZ5mF4mNGMekj72VZXqVX3ysgR5NZzMf8IxHPRmxVdy4jAZ5pr3L1JVOGokeZ9R
 a9hQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8baKtF+i7xjroOs7U0yRwCT5kQQ/joE2Vao/N2ir3jvVjHvfERiWeKSbMvpfCCgipVa60tO6Y=@lists.denx.de
X-Gm-Message-State: AOJu0Yw43nUevQc/DbYsIyyNwOlVWKogiW2pAKI0jQyTmgkboZqhtR39
 65OWAE9l6uk7fmIJSUJpvEQjK9J9yNuMWT0YvNmEIurhL1GZeYJhkkRm0i4Vtc5AJBU=
X-Gm-Gg: AeBDievJUz5JyNPS10y4rBnuTw/AXPeGDxdhGHyUvYgA4rvsveC6r2HQSOQyBl/DZfo
 2tl6VXeiAmOXGjNG9jh6SsYav0A/6s7eaWzaAAFr8EeC9lIEaSoSrttK88BntsBnUCVw6PbVnxC
 mQxTL7NR2fzCmpNDdOoesFQL5Z8pW39IHsdQiP/suc3NJ+2OOs2Oa61dxQhw3gXme4ZYyKMx4lu
 2aArku7ln5RlFIsyvpeU304JgV4gDN52sFdWhb10ismIFQnj/k2skWVoD6J+E2pj+1OpBY3CqxR
 VvM6SESUgmzm5iVxyREY2K7h6QB0BzW6yfcyLIR3jS9OH8GyXOiQp9IiqHYIID6i0JtKLF6szZw
 Khayhb5nUicHyyZXc1MvH+O7l2FHLE7/3mOU06V+UrieoaB/6jivjXq/qoTNXkQhpLyBKIk0gUQ
 pHQdtBKUp2IOfOpfVnRn4hBbnXsfvqsp6wkElTbbY=
X-Received: by 2002:a05:6820:2d04:b0:694:a02f:75ad with SMTP id
 006d021491bc7-694a02f7af1mr154399eaf.59.1776780618530; 
 Tue, 21 Apr 2026 07:10:18 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:dc5a:64e5:1cd3:94d5])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-694984114f5sm1248515eaf.7.2026.04.21.07.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 07:10:18 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 21 Apr 2026 09:09:34 -0500
Subject: [PATCH 1/5] configs: mediatek: mt8365_evk: remove CONFIG_IDENT_STRING
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-mtk-configs-remove-ident-string-v1-1-66d5fc3d67be@baylibre.com>
References: <20260421-mtk-configs-remove-ident-string-v1-0-66d5fc3d67be@baylibre.com>
In-Reply-To: <20260421-mtk-configs-remove-ident-string-v1-0-66d5fc3d67be@baylibre.com>
To: Julien Masson <jmasson@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=875; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=qipx7FG49Mc9hUQznMKb+64tUaBE+c0q8HzZlUvTuxg=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp54UnEuvfK8lgmpGBBKszSPq9rZiw/66N/FSx5
 r0QUHEG/SGJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaeeFJxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Au2IH/2LAKMEYtjYARvZIeLDZAm8+vj1CkKOi0az8hFB
 DwV7/UndlZprmhyfFwKPCGp+jB2nwMGLrcvQ4odkAnmiTtIQZf7YOS3XYttafV0GhJO9tFkHGwB
 et6gudDX86LwvDE7B9/Krw3oajWCsZORWFKeDyezPLwshsU8U72J+nW1E+RVfJ+fdgP58U6UKud
 2T1YJ5G9o4BB3JvgSX7C948tbJIPQ+UwI8rEPeh/477lXJpsTM28+4iV99VVsogachimcuzoTgz
 F8JGgIO/JCcTXVRnYoSZUObCKBlOn7Ui0g/XsZtPRZYrIVt70DuIkpT5ddBylvhLhODVizvN8nQ
 bCsQ=
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

Remove CONFIG_IDENT_STRING from the mt8365_evk defconfig. This makes it
consistent with other mediatek defconfigs and frees the option for use
by downstream users. This only affects the version string printed by
U-Boot, so it doesn't have any functional impact.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/mt8365_evk_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/mt8365_evk_defconfig b/configs/mt8365_evk_defconfig
index 9b403cd7aab..1a385492547 100644
--- a/configs/mt8365_evk_defconfig
+++ b/configs/mt8365_evk_defconfig
@@ -8,7 +8,6 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8365-evk"
 CONFIG_TARGET_MT8365=y
 CONFIG_SYS_LOAD_ADDR=0x4c000000
-CONFIG_IDENT_STRING=" mt8365-evk"
 CONFIG_DEFAULT_FDT_FILE="mt8365-evk"
 # CONFIG_BOARD_INIT is not set
 CONFIG_CMD_CLK=y

-- 
2.43.0

