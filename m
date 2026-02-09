Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75F4E7E0CD
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 17:38:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E882E805D7;
	Mon,  9 Feb 2026 18:38:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yKHaw6hj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82A0183C61; Mon,  9 Feb 2026 18:27:26 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51E3483BF4
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 18:27:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d1959ba05cso2219152a34.2
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 09:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770658043; x=1771262843;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3nHp7431rnSK6Lp5SBuMZz1Tj0rytsNe7cU8pYzMJH0=;
 b=yKHaw6hjWW2jiEfFjHhRkFNARKpLw18VzkvuWp21T4w6Lsa1RI2GoRRhJ5ohcoHuzM
 UHjfE9i/phAbsX+VGZd+RbE6+ZreeQEAw4ojii3IpfoeB6DdtdErLevczwObLBQM9Iu7
 /r5Margp0RBhZ5FziDyfLWsTBT5EfAuyLsPsRvPNpdLH7xM8A3amffMGx0yJ4x670uyH
 tOvAlM9jUzbG3+XAu2bENW7YHisgbye2Yf1zoOAYduXPgBPIw4/Q22/h8skqPrDXdwdr
 U/eZDB4gXrN1TqcJaVZQicQlPQlDfF7t0XSK5aAIUeHQwXHq7pEfaudVIMpui0Z8u9yW
 Rhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770658043; x=1771262843;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3nHp7431rnSK6Lp5SBuMZz1Tj0rytsNe7cU8pYzMJH0=;
 b=ds3bDRsrrnB+sF1kapHL+GOt2yzMaVTWxJ3unLB+rxRDlwF0RVEkMrW0xd6069txp1
 +mpIdH79+3nm9vYmKkYpnTnoSYSvHiYGSKs5Vo/cXK0Kf9+Idov070bjsHfa8m/ybIX7
 lBpglNvFD04m/LFhAc9f0JU2Bobc85UnZnj68q0Li7ds+xWHTmwzV9Y/1UGd1vHBx7G2
 5I0S3gNWuNuk8jvBd9t3NPTG+aXJuztikKmh6Vb3BrgQnsD9KL9po4/JPzR7FGdEzTwq
 tSIKDMGrh3sEauXbh1XZRNodsOJO4N3DiR+he/oy/7tOvJJhVyyd/wARlZ2a4nNf5JKL
 EeQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyJGKouvW8yOZT5IC9eir/I/JcrYe+0/9gDAXhFZzzngBw0bjUYi9Wpryz4GXYVgvWnA3IFfQ=@lists.denx.de
X-Gm-Message-State: AOJu0Ywy/wJdIZ1DJKB1Z81/kNWRcJ9ulp1Hdx3siBYmObp3u2J0uZ43
 p+zOzh3O27Xu25a4HLfOAPt7EGEdZH3OnEtcO2rfTX1+M68r7GUERBX941Dy91Szems=
X-Gm-Gg: AZuq6aIq4KpamruON/x9S9WFecjrrcrj9b6DhAtjdI/HRKOc/1RdfF2jDNYeKUbn1gr
 pgLiY5mgJ5nOFR+qGV30JcffoLyeAB0XtFVsTjbqbfY1uZuh4jHDDYwnWVBa1fHN/Jxwr4ah0pl
 A1biePCGaZJIvpCvEbyMHbG5VnNfcNc4+9NwlsE5oreC/mX26vjI2cjb3wCvh/I6MhqBDInID1K
 TJ1jLq3940A9CosEcBH6Sqaf0W2LYt6l/LtaizszejeZNNUFjIlVWQe4rbtpSET2u3wDTVX4+tc
 y1jN8KZRO7607FV/z4NoODs++H6ssC/tfCd2IA4eAtGwWT6f1MlrEZaYs9f7sXM3MGTKAmmx84o
 uNTpRuI6Gwi19mznpT5po8GcSMDLGeKZIm9sraF4/k8HuUZSjfwsMhRrXtmJdnOT5gkb9bVkxE4
 jaLqIiJWWHWV22rds=
X-Received: by 2002:a05:6808:4f66:b0:45e:801c:a0ea with SMTP id
 5614622812f47-462fcadab25mr5854880b6e.32.1770658043026; 
 Mon, 09 Feb 2026 09:27:23 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cee0:eb0c:b683:ad1d])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-462fe9de7ecsm6695383b6e.9.2026.02.09.09.27.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 09:27:22 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] arm: dts: mt7622: use generic node names
Date: Mon, 09 Feb 2026 11:26:54 -0600
Message-Id: <20260209-mtk-dtb-fix-spi-bus-bridge-warning-v1-0-84e3e2d8352d@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2N0QqDMAwAf0XyvEAtVNBfGXto16hB1knidFD8d
 4OPB8ddBSVhUhiaCkI7K3+LQfto4D3HMhFyNgbvfOe86/GzLZi3hCP/UVfG9FNMwtnMI0rhMqF
 rfZ9CyCHEESy0Cpl9T56v87wAzCju1XQAAAA=
X-Change-ID: 20260209-mtk-dtb-fix-spi-bus-bridge-warning-0129b55d55af
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=856; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=kKH+ojNKPfx8c9E+Q8Ztq8BpaZWovFqXYxYc5lT1Yrw=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpihjkVS76ZcAn86g1BQ/pBxz2V9thVP+RSMv9Z
 qnBNZ1wm5yJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaYoY5BYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A09YH/3yp2aTiHNlk0KhLkwnMKCiRM7fzdceep5j2Qpf
 3fZTliSuGfVo4WWbWSfXjAbjCS/pa4oq980TUqRpJNBbCq7+gFyN2kNDDS22g2nL5jkhoiPhaeg
 OAwSckn35ThUGUE3o4mEHknicq72lJ6dVRW4v2mfzMzK+0sK/6Jx/s6+9InlDg86vnp/kIc7vqk
 Yd1+ZgxIDnxDNGq43K9vD0Bhe4rSQePc4gCdvVl5ftjvtzswZfujOv/424DOknXA3dxC8rwAThe
 eLO6NmJq8dsFZPRMXnEce8x8ys15iSJttsXoNFz1Yz03tU5SD6lX60xudL7znDXR17s24aInv6Q
 r8Kw=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Mon, 09 Feb 2026 18:38:26 +0100
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

While compile-testing things to make sure I wasn't breaking other
platforms when making mach-wide changes for mediatek, I kept getting
a warning about a a SPI controller node with the wrong name in
mt7622.dtsi. The first patch addresses this. And since we are here,
I added a second patch to generic names in general in that file even
if they aren't causing warnings.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (2):
      arm: dts: mt7622: Fix SPI bus bridge warning
      arm: dts: mt7622: Use generic node names

 arch/arm/dts/mt7622.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)
---
base-commit: 42b3ee7fa5248ad89467aaf2585f4a08aedd4731
change-id: 20260209-mtk-dtb-fix-spi-bus-bridge-warning-0129b55d55af

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

