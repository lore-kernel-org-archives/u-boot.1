Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E1CF8FA80
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 14:10:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CD6883BC8;
	Tue, 21 Apr 2026 16:10:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="otl4shEp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F1B283693; Tue, 21 Apr 2026 16:10:21 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28CDE83693
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 16:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-679f6ee3fb0so1567829eaf.2
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 07:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776780618; x=1777385418;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X0tokYcudq54aQSrY1YGEWuv29RbKXo1KAwa/k06Dfc=;
 b=otl4shEp0HTqNR5iY0Vc6gWyL/gzDgAqQN8GbkwtHToiHbxFjYF/FVR9OWnUJDDXv3
 grCC+2i0w+w0AUSGMbc7DP42aziO9vyHd+i+nmkV0JPLKNDaR4HDlI8kLQu4/t4EMaVo
 Vy7KQv6Yu1j3s622MGxZTpypEcQhR1Rkb0m7PjDPSGyixVQh9q3F+d5xgtKRdN/vQ6Qq
 CaE/0uqLggYRasPZ1L38EObFGnf6o1oKluGhC+91Qp9r5TjZ0bI6Rtu3U6o0LqKQvAJH
 bQKAthm9/ENYiw2pNGQ472GfzuNpzna7PerLzL8wbUOBNJJ/aX/zPNiEy56qgJV+okSW
 Ac6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776780618; x=1777385418;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X0tokYcudq54aQSrY1YGEWuv29RbKXo1KAwa/k06Dfc=;
 b=AqxUt0n+e9awWMJ05gfVR0EFQP/BqfD07U81lwJM70bWh3Eev/TlgIaH2eLYMpJBwS
 jvfntzbeurN8hDOC8sBykUI434ySookqCbWcLSUA+6UD+o6yk997gwDjjWQVYAvAIBGn
 16W8tf3ACE8ZW5a0RV5/ZWueOBS1o9fw/SQeofw1QfHo9r4yBpl1+eduNX/gnUh/aku7
 Z9BpnbLsHWO25cCTh3piy3WBnBTCoiuIv4G4cMC0WId8tThTpKnBibvtcpBwl/pIGxIh
 2KVcFOCYo3/ZdzLn5jwy7Bji31Khp1oNTqHFAKu9aGz4vKP89OYVYTZK9aT0K1i8/6pQ
 9ecw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+lag2bPnnJlURVihGOAGPzNzDOXJuJgkBdik3ibrWkyLFmuT8EE1KGEaNGPZ2lKwIoE+5MJvE=@lists.denx.de
X-Gm-Message-State: AOJu0YzkEK9Q1DEW4JSgFexkK6HebuiFMfEcLjv+RUPb2hb7OOtdJhxX
 4oWY00OqevjW6HAy0M6HcgDib32fp8vv8q5PB9j7cN4wWX216G+vKx2gxVXCEY5+Eys=
X-Gm-Gg: AeBDietzgHL1ZW/zssldYbMbkjwSIQKmF4PjRgT7mMTXw38X5Fn0k/j17uNdVEp9NRi
 ihGUEvPwXOlO53gZaKd0ifEkuA+yNLVqYWY1F4bAAmAklqMv18Ebf0U/T3b2NC52sLpU7mRqlbh
 f4Y5AqbCtoD68Jke070+2+wQLddJ4+FVom9EgMlYNkd6txyBd2B0kCSQZnmpZB6G5uB6WDcU50w
 zit3ry5/ROYqxqX4E4UmnyqjFcYhWfsLoiVtyciXBj14STy6gzi1YNDSDvGr9rhTXjr9ersuWP+
 eLwXx+OLtwKosIxorX3wiTcEkjxNlv8RLP1zt4+eM8JsZVTWtThxx4IWYnns7nQy0WHhPTQE5dx
 CmzZEof4AD4iYcYk1sFMd/kH78K4wBHQoKKgWmzS4MFy4EvWnF/a+qJdRYXgTunoa5Pz1qrwrcP
 239HPIchmdjRD+PqC7cxj87xMoywVTZf05lwYh9pE=
X-Received: by 2002:a05:6820:4c14:b0:694:96ff:d4b with SMTP id
 006d021491bc7-69496ff12e6mr1869330eaf.26.1776780617782; 
 Tue, 21 Apr 2026 07:10:17 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:dc5a:64e5:1cd3:94d5])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-694984114f5sm1248515eaf.7.2026.04.21.07.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 07:10:17 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/5] configs: mediatek: remove CONFIG_IDENT_STRING
Date: Tue, 21 Apr 2026 09:09:33 -0500
Message-Id: <20260421-mtk-configs-remove-ident-string-v1-0-66d5fc3d67be@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NQQ6CMBAAv0L2bCOsSghfMRygLnU1bXW3EBPC3
 y3icZLJzAJKwqTQFgsIzawcQ4bqUIC998GR4VtmwBLr8oyV8elpbAwjOzVCPs6bQSEZTcLBGdv
 ghRCxqU8EufISGvnzO1y7nXUaHmTTlv0bQu8pr9OuwdAr5Yn3nNoiCjsOR99rIoFuXb/QDXCkt
 AAAAA==
X-Change-ID: 20260421-mtk-configs-remove-ident-string-c825e222863e
To: Julien Masson <jmasson@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1475; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=5qmfEXF4SF6ry5KUEwVHQ0/phQCxJ/7/0yVCC8FClxs=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp54Ugquw+5lMdoi3h+i/FAw0hgYdoQ+fmZjk0O
 3xD6a7ngEKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaeeFIBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AvtsH/1Cwe88vyXdEmqMxK0xu6SB4rWd+H0F7mVZIdSp
 tBImVWujj5BxI9MGmPW7Zu0vv6RbzvIowfV5eJyYoeeCys31PR2iXinLIGJr6/kL4dKGSQQq0NZ
 8X1zfekrqTxnZOv+49bnzRNHiQ71rnvSMezePhoM1S/f1ebNFf9XU5BGEgYS6JkSgZySVvCfT+Q
 ueeKHjHwjn52QsQUJLzljtTT6o2eJ3vSJNyiENSRmAbgIQ2/N8r8ooaTLvGGsDlwCPBlFRnpoQ1
 wZYfaa6TF6v/BbDzsHAymGaAvPeDOAFN4Zgn1Ukxd9IMpsjrIfXQUVkhmRV/s9p7Fz14IowkpGz
 3MLo=
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

Until recently, MediaTek defconfigs didn't set CONFIG_IDENT_STRING.
mt8365 added this and then it was copied to some recently added
defconfigs.

This is just appending extra text to the version string that gets
printed, so it has no functional impact. To keep things consistent for
all MediaTek defconfigs, let's just remove it from all of them. This
also frees up the CONFIG_IDENT_STRING option for use by downstream users
that may want to add their own custom string to the version output to
help identify their custom builds.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (5):
      configs: mediatek: mt8365_evk: remove CONFIG_IDENT_STRING
      configs: mediatek: mt8370_genio_510_evk: remove CONFIG_IDENT_STRING
      configs: mediatek: mt8390_genio_700_evk: remove CONFIG_IDENT_STRING
      configs: mediatek: mt8395_genio_1200_evk: remove CONFIG_IDENT_STRING
      configs: mediatek: mt8395_genio_1200_evk_ufs: remove CONFIG_IDENT_STRING

 configs/mt8365_evk_defconfig                | 1 -
 configs/mt8370_genio_510_evk_defconfig      | 1 -
 configs/mt8390_genio_700_evk_defconfig      | 1 -
 configs/mt8395_genio_1200_evk_defconfig     | 1 -
 configs/mt8395_genio_1200_evk_ufs_defconfig | 1 -
 5 files changed, 5 deletions(-)
---
base-commit: e3405917a1806971d9e72a94186b299f05581e1a
change-id: 20260421-mtk-configs-remove-ident-string-c825e222863e

Best regards,
--  
David Lechner <dlechner@baylibre.com>

