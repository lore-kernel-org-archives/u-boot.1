Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA1A2F8FA83
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 14:10:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 071FA8426E;
	Tue, 21 Apr 2026 16:10:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="CkHAdqCc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C791B84258; Tue, 21 Apr 2026 16:10:23 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0C9F83693
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 16:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7dcd17e19b6so840748a34.1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 07:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776780620; x=1777385420;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ADQL16T9Ri3EmNL0AQCP5R+BIjNGeh4fAmfbbobwTKc=;
 b=CkHAdqCcQ77ML4mn1vjlOQD7LN1brB094biHv/c/DNNsltxM59q51/G6S8h3qo4szv
 CsKPR7dZx9BSWpvmunr/kPsYFK40mZv7SzDCPDzef8V+nKdaGQ0gvIEz4eAixekN4wEX
 3h61b7PqJkYcfHvNdQz/6jvUx2IHoRGoS1qrpCCkXoEmFMMIE+jhxIzwP75gXkjrGroJ
 p0WJgNkES62D6HjTifR8U9M8XIrRkl/tzTUtromBzmaj9PK/RTsZZBOrSu9oyjo699YT
 Dx1V+6zLZNaaxTO9DtYF+7yt3fwoACjp9fzaa4L2ukENZTjVmiDLceL9sMh9K2+rwmA2
 h8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776780620; x=1777385420;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ADQL16T9Ri3EmNL0AQCP5R+BIjNGeh4fAmfbbobwTKc=;
 b=GXLKfgx6niyVCRoiQVoZRQRx1GLbLeDPz28xU64cz/E44TBtTBsYt0kbFXVgkt35kU
 6mzqfzvcgkQQke+ytRESm7NjFRgHITJ1UCLhEyCFnbj0z0WKvALL1yiJszjEG57nS2kS
 WOb1eA0WRR8Vp0HCJQgyYVyy7+9Eq8tpu8nWDR99Cv0rHNIkbNhSTMlgCJgzTECxqaiP
 Z+HiI4mVRHDXDyls+t+wyWCOKjOgSn9DowPzu2hbGUHJFislNg6uF5AP6ZA3DVaUp7oJ
 aSZN1jaAJNGRDZrfXEWrDo1kg3FHvJWTmbRzAJD9IyGxPTnPJl7G4EAa2C9uyETdpI3o
 aMBQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ//bxS8ciQVgnajzuluPp0KONaxZWWVgKbCJzwkM3dQZvCCWQeRygcQmKEa11qst4NQdZCfA3c=@lists.denx.de
X-Gm-Message-State: AOJu0YwtgaZwssAmFbKlWEzQNmOROU5TFSH86KQvOfYw0Rq18iocHcBC
 mVMMpvjL22t50lTf+0rpb+v+97UiuE/Mdyfd7DqM4Y9kYtMSyiJ5InzUwbSFAkg4cbLmDgIvUkp
 PSXeQ
X-Gm-Gg: AeBDievnfpz7Yq6aAWsyO1U3SOdrTPqzLnkz6lXV2G9crZP7hiqKWHjczk1ujzL37U9
 S20/LLeruz9Y+ZR2kheYKelCCH50kdzl6XopBPXdBXezqD71CCib9rM24OnAtNJJSkfjVRnwRL4
 CiHjokH1AERFXFwK3hFSnjUf0Zwg8IwpJk6Wj2yv3wMGKf65EHBG2WHgqiGQEU9qt7ldL09fQEX
 mllNxgQrZ37sBpjIm6RwCXt0XE7y9M4tn+kfb604FgcIYTgGlMgmDztwtHinotieQjfv6RjAdbg
 CfDhQsO3HjyGY5qqGWR04JqR0pPGzYqPHbvDXgriuLtSNq2FNypx2ZVgQ/YAsGXMtlloIk2f+Sw
 KTrHtpZ2U60eSc/49ZDgOKFkCD4YgukoGJ7cmb3Dz/msqCbFtR7MwZ6IFZbuFBqWpQWPIVaNoKM
 kvqh+PViRniIklbp2Fcb9KnGwbUVuulhMZ4cvae10=
X-Received: by 2002:a05:6820:1f05:b0:68e:b81b:d81b with SMTP id
 006d021491bc7-69462ee703dmr9398192eaf.31.1776780620301; 
 Tue, 21 Apr 2026 07:10:20 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:dc5a:64e5:1cd3:94d5])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-694984114f5sm1248515eaf.7.2026.04.21.07.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 07:10:19 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 21 Apr 2026 09:09:36 -0500
Subject: [PATCH 3/5] configs: mediatek: mt8390_genio_700_evk: remove
 CONFIG_IDENT_STRING
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-mtk-configs-remove-ident-string-v1-3-66d5fc3d67be@baylibre.com>
References: <20260421-mtk-configs-remove-ident-string-v1-0-66d5fc3d67be@baylibre.com>
In-Reply-To: <20260421-mtk-configs-remove-ident-string-v1-0-66d5fc3d67be@baylibre.com>
To: Julien Masson <jmasson@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=819; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=XJo+jc9R9iRD8TBBpW/wuAduGtwMa+eh3Py7FaBkm7o=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp54U0KBjEf6yOlspwsaWgaaTKWQHTghKlHKz84
 YETtD5JpdyJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaeeFNBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AmPkH/0OyYf1orflRi34P0AUq6Km3rx+dDt2eksx56ql
 ghdXuWaNg+zSahlOGgk9GrGgxt5EcWS2rc3BnOhUtgHo+CPcE9rclnhNJn8aClyuyenXvpBrf/A
 pu+ngKEqTrz8KEG+eO8AyHA9aXAF2TH3P/Ni1paGuHCOtwnDrwk/AUZAz6H8YxEhUbAtPku1WGB
 QnuTumU8vs3RA+G418Mo0veUzDQfRuNVqmczZKO6uEXMtcHhMwwDb7ncNFTmop1ywBvym2QpEdg
 eypsDjERRo6MzvPZnM9gO2vp6R+4SsolBCcKPtZjAx/QlFiUx+AoYLrib9YSO+TmuA+o9kLhJgN
 2dNI=
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

Remove CONFIG_IDENT_STRING from the mt8390_genio_700_evk defconfig. This
makes it consistent with other mediatek defconfigs and frees the option
for use by downstream users. This only affects the version string
printed by U-Boot, so it doesn't have any functional impact.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/mt8390_genio_700_evk_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/mt8390_genio_700_evk_defconfig b/configs/mt8390_genio_700_evk_defconfig
index 0b07e3be2c4..fe4f6ad9016 100644
--- a/configs/mt8390_genio_700_evk_defconfig
+++ b/configs/mt8390_genio_700_evk_defconfig
@@ -1,4 +1,3 @@
 #include <configs/mt8188.config>
 
 CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8390-genio-700-evk"
-CONFIG_IDENT_STRING="mt8390-genio-700-evk"

-- 
2.43.0

