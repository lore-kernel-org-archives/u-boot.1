Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B4ACD98C7
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 20:46:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 233ED84963;
	Wed, 10 Jun 2026 22:46:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="ZXkInmpE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F401C84971; Wed, 10 Jun 2026 22:46:20 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCB6984957
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 22:46:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-486560db81cso5788579b6e.0
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 13:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781124377; x=1781729177; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+VOgisk2h/g+NDLVQO4bS3j3xxUZG0sYwZDwLM9u/TY=;
 b=ZXkInmpExxSE5ouIzBukGrNXJO+f4ynTooy6SzfajNtVOlB9peKypkj9L6idU6ADR+
 RrYVpeFd1aAbJ9DWyUOM+6HNesxn2620ixzSAqea4MwzYHVqxZolSigeIionfQGI1ReF
 z1zFvP0ctOqDvI79SEjR20amstwmVio2IAI6yOqHDgxK3KfrpGrd8LBXSrnhL+soqtte
 pdICNY3ZR0bbwj3LCsVQuJV9lLvXYdNEyKo+yDufM4SuKYgnUqu6z+3cmn0IOH/i4sQR
 2UvW8vrbJMfK8YEMXb3OZGn71V3PLRdOpjB3Cnq49VF+8LwxGTHjUWeRuVFL25dJP48Q
 PneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781124377; x=1781729177;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+VOgisk2h/g+NDLVQO4bS3j3xxUZG0sYwZDwLM9u/TY=;
 b=gUra9Ku0TJWcDSRZTO7baP6FyMoRtFOHU8zJJzmxvc1t+uppSbal/c+vUbZgQJutqw
 LukHQ2ERyPF43hFcuAMmOTr9iAwTnbQTqtknjUfcHgEpzR4bOmkp4GeA6Jf+9+wdRIXb
 ZY/biR0/buNXRysEHPmhuxJ6kwJQLp5Ovcj7EjllLhfi3ppFXSMcd2QzytR97fpLVjzs
 02WW2/ijtyaoCRXVYRqIaSX6aQc5c0DX8vP/9W4viR8xtrGbO9qASMVjYU18P22pbdB0
 W+eA50e1h2pnZAKloCzemF9PLRzHQvfFSnSW/3xN/lzaATp265gsErzPuLkZAhLfn0uN
 ImrA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Q9K6CNmmx+adG0w58vO34/6x9Xe5moqS6GCa/FcI/ARhR2braQBr4XSUn1A1aFiG6ooHRcKg=@lists.denx.de
X-Gm-Message-State: AOJu0YxkBYkxG5m7CeveJeabJJIZtamaZ9+lsjE2+gsssA1bUTTJvQQT
 xBDqkC47ZuFuPlnKjnd7p822bltLqtXv8RGoFHSbhqJZZbfExJ9tl5w/oqI5UfG10Eg=
X-Gm-Gg: Acq92OFh7XlVXXc5LbBQroE/syzuN7fLOdSQDW7HlDf84KEd6ED1Iv8kTOmrKJMRClF
 YzE2nvSTz5Tna9pPpkmso8mBz8iZx2TGIYHyq2ezS+F/Y2ejh7YdbLTgKPTeLA25WWBIom/f67e
 JZ2gRNOe7Um/HBBsBe/Qf64B6PK8dpl+xGqm9IVzCZSGLxhs2vRjdzLb7Va65hO4rEHeDSPP7K3
 e1A8ROHuZtHvPrwFAdUJk0ofrWpk3+v8oQUXgIY+C+N4qo7ugPHFqyHd68lKIs7FYboY4VXZeCP
 IhhgpZLeHauwhfRG2Ml+Klh04EM6dlG/uqxU7LwF4r46mN7DOtF+38ANKvjnFeTJvo25kvAsMPP
 Qoejqm4XQo+B6FCvNb2//MQkAzesw0xzpMTbeh4fZS5UtOqYYUlqsFogOTQYlHy01Dzw6zP/vPg
 WcAaIyRZ7ghUlWeb2Mr5+iu4XyZOJrpaP3YV8Btg==
X-Received: by 2002:a05:6808:508d:b0:485:467f:a30a with SMTP id
 5614622812f47-486f02936d7mr6805611b6e.43.1781124377596; 
 Wed, 10 Jun 2026 13:46:17 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d338:698:e403:61a2])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b5a53bcsm19425518b6e.3.2026.06.10.13.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 13:46:17 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Julien Masson <jmasson@baylibre.com>, David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260512-mtk-genio-defconfig-v2-0-bf4c30ef7f14@baylibre.com>
References: <20260512-mtk-genio-defconfig-v2-0-bf4c30ef7f14@baylibre.com>
Subject: Re: [PATCH v2 0/3] configs: mediatek: genio: enable common options
Message-Id: <178112436646.406439.17865680134421754917.b4-ty@b4>
Date: Wed, 10 Jun 2026 15:46:06 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=854; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=hqRJ46J1bK2+VjVAhfznLMR7AQplZ5O4OCrH9mHdyGQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqKc0Sqw6t4eV3IdnRybF+7ysFDyl3Bg/RvIFic
 Bymt4bUa+KJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCainNEhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AH14H/RP8V2Afpcbta+mwUG40DDABKSDX4Lu4Amvz67W
 637qSzHza/x2fOwyvraFFPWgOLTnrWgbzyJMKW/cCsKJMnmYe9tajahrAyZb0IBqAT9h8/dnu0W
 oD4PprVA41YJU/psz78iLfJL94CazCUf1dSzV5KwwXbV8AOMg92DpK4sTrRj86UMoGDy6RdLjob
 5TA9M45avK42vEbH4sVacfNXjAqrzA8xD6WReIpcwCBJe+VeABjBphZp2mUyztAHSsbwHRSJBEP
 Rthl+ui+XDMay/0ib4leBBko3cAwz4T3fVdeRD/JBxpUFg5NcgS3dZWb0BXBv92/SCz4WTlXoCQ
 g3LQ=
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

On Tue, 12 May 2026 17:31:50 -0500, David Lechner wrote:
> configs: mediatek: genio: enable common options
> 
> This enables some common options used by the default board support
> package for the MediaTek Genio EVK boards. These options are already
> enabled in mt8189.config for Genio 520/720 EVK boards. The patches in
> this series make the other recently added boards match that.
> 
> [...]

Applied to mediatek-for-next, thanks!

[1/3] configs/mt8188: enable bootstd, FIT and DT overlays
      commit: b016f0bb46e168f6a5b7f1101e2f64aabe887ac5
[2/3] configs/mt8195: enable bootstd, FIT and DT overlays
      commit: 10ae95703b878aad9de5b2c68f2289edf9bdafba
[3/3] configs/mt8365: enable bootstd, FIT and DT overlays
      commit: f30d2dbedb6ea14b9b43a2c83ae229778be6979c

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

