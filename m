Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CB7FB5164
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 20:37:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8091584120;
	Mon,  6 Apr 2026 22:37:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="C/eMLBwz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B430483EC6; Mon,  6 Apr 2026 22:37:36 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33B4083F98
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 22:37:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-68457156797so880792eaf.1
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 13:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775507853; x=1776112653;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9cU6+9Db93VD2CfNKhp2QpWfRSb14oSEdUw1ySPmDVI=;
 b=C/eMLBwzKLJZ0UjXItHyTJefKO1ZjPKtrnEIk1XYqFy0BMyc3pNHpwKiFr2uqB4IuW
 ZUA2rJBEEfgFB8Jr95CN7GAEkxaQrWX8W8DDrh9B9PO2+62OUDmdTjHvtIU8LJZOVG8Y
 AEo6rv3QV9PBDv2ExZA0pzZbDpxX2qkUlGlro0OO6+cQTwe+Na0hCHp9tVv+BkPF5tDa
 N8pjRhQa/Tw8LCX+koKWe7nSdC1X+UyJQ2oY1KPKqJIfpg1semsEZqTSu3+t5I8l6z3H
 CIGabdxGqAQOtg8B1D26iytwVaARMpQZc3lJzrDjgK0lO5JeZscW6YLtWknTi5fAqJFI
 iIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775507853; x=1776112653;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9cU6+9Db93VD2CfNKhp2QpWfRSb14oSEdUw1ySPmDVI=;
 b=iK2gJTORvXOuCoVg4oQdDiNMvQVjbrSdsnDDwX7/purebyjb5AqjqbkDz5T/dGByDV
 KyvareH7K1wu49BfVsprObySV6pgA4UiX/K5JuNWDsbM3pLV4sFpKBxaPu6P3gXBwlCM
 oXZlukDp/q6SAa1V2ExNGAi2Sp4LWX7O1JcBwzyDRz7Nxou3YGslvBmJIACEFCWZ4EoW
 8ozew3XYX7HwLFa8A3cC66obnMrstdi5fP4u4Vpxf2/Zw6whBlehFVzxPpOg18215+2Y
 RKFqLiGwDAEyQw1R9sw2ikhUXVQuisV1xl9kvHKcd8t1nzTDtBGgIwk3IfVqojTaJC+t
 3USw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW15oKH+IEH87IpRSPpJBrWKYARNuhFEhk1fHdL5JxzlVYW+1VFeCVSI0tMqmu8yqY7S4iBPD8=@lists.denx.de
X-Gm-Message-State: AOJu0Yzs361jjfpjhvN8sfFbnwBSX60X31EOXtJSH9JqYSaBgHgQ+8xB
 7rRS7fOStadynbmI5cuHPStdngVRRPVd6y3uPjxNhzVZW5UgUs9rXMA5DgBYBbHMRhw=
X-Gm-Gg: AeBDietMgCi5gcad+J+DhNWzd5ILvnp05lsyffLxhTPTxOxHd4VoIJuH6UrOPdywdyY
 GxA+0kXIjNIEkiNPKnQo10D5EUXnpVOAQggu3/bOzVD3BU3Og8sMamWoMuJJzNFUmn6Sjm5XThX
 /oINO93l1g9KbWUu8gyAUx1w3WU6ldL8qYm7iRK9y4GMZ2jZtj2s6WgDbcl9kFHUvDa0d58j6uS
 roi0z3qh+lbmUBmEe7knd0DLDNk3EjSF8uNlXsCbgUWADjgOoTRAbOLpENtflMqJEacGkgiOPPM
 8zm9OzcqX6eWpUcCMxbbwkDx4/BF1PRu1f9dB2mTsVbLEUFRFg+mZOsNQFh4U2MC0VHpeh8zLlj
 823FMLvgiI6+ySj7CLHpyA7HsPSfsQZaQ4dFxa5s31IZpuJyYyYCHCdvrYeD9R+QA5+MRfo1V18
 Kwx9Xa0C8yF5ztj6vdJ17MmSa4rkE=
X-Received: by 2002:a05:6820:a02:b0:685:f898:87a2 with SMTP id
 006d021491bc7-685f8988ff4mr2917470eaf.19.1775507852971; 
 Mon, 06 Apr 2026 13:37:32 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:90d7:b13f:c53:8ca3])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-68386edba6bsm5359048eaf.14.2026.04.06.13.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 13:37:32 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 06 Apr 2026 15:37:10 -0500
Subject: [PATCH 2/2] configs: mediatek: add required config for SNOR on
 Genio 520/720 EVK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260406-mtk-genio-720-snor-v1-2-cbfd5fc4e59a@baylibre.com>
References: <20260406-mtk-genio-720-snor-v1-0-cbfd5fc4e59a@baylibre.com>
In-Reply-To: <20260406-mtk-genio-720-snor-v1-0-cbfd5fc4e59a@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=864; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=egSqo6IvgADy2oqNgNPGN/i7UrDpwuDpwr92bHzLD0Q=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp1BmEQaj8c5T8Xu5u4XD4ttqxJZWwVmrYnyqI+
 aTnKj0MiASJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCadQZhBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ATlEH/1JtiaUXR/1dC6NCldYnAkDEjeldA+0dMGSqYKu
 u/PZ9IHEhO9cYilhs6jEFkZL4EyJsOItV6F5b1DDC6VWTwSX7+3Pkn4bW2eVyuPtHzVFx+SCQ8B
 vgFd78tscyA2WQZJamPrysSc8leQEo4oJKO12oTRdbj1x9H42nAa+VoAX8pM2W6/hNk5zyrBiQI
 AvbB68czYV5FU4QoiatzxTFFi17eekB6TFsNKYCMoV5raKKrBtycc+YEd97lQVTjsu+d61VIdTY
 EjKfwv5Zu52ZawOzHaE5NKMbUrzcD44RriK6iXRH19MK/Z10GjEfLLuFVHXWW1YPO9/CmTWX6Xj
 xuv8=
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

Enable options to be able to access the SNOR flash on Genio 520/720 EVK
boards.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/mt8189.config | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configs/mt8189.config b/configs/mt8189.config
index 74edd0169ea..e0a6b022fc0 100644
--- a/configs/mt8189.config
+++ b/configs/mt8189.config
@@ -23,6 +23,9 @@ CONFIG_CLK=y
 # CONFIG_MMC_QUIRKS is not set
 CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_MTK=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_PHY=y
 CONFIG_PHY_MTK_TPHY=y
 CONFIG_PHY_MTK_XSPHY=y
@@ -37,6 +40,9 @@ CONFIG_DM_REGULATOR_MT6359=y
 CONFIG_BAUDRATE=921600
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_MTK_SNOR=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_MTK=y

-- 
2.43.0

