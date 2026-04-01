Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F97010FCAEA
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 21:54:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79AB883F7D;
	Wed,  1 Apr 2026 23:54:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eri29ODg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AEA784011; Wed,  1 Apr 2026 23:54:18 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 292EA80517
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 23:54:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7d9bba96f7dso128081a34.1
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 14:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1775080455; x=1775685255;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=miojPsFUKWNdvGqo4HUqNmLJ0sjKZrA/GnmJl1Sqp5U=;
 b=eri29ODgdWHqJpZUbBhy+LZM9nhR4nFO6Iy7a/Suw/6hACnaZ3BHtATz/34VT96H8t
 k13Wo4+gDYLe+Y039qaCpfQXagWiLh9bYXdgb2LZYVf6xP0lzD0Zns+evCXdiI8S2Lbm
 ZyITiBF5+Iylhvat+HLGlophZ113YyFroP68QJIWH/Y9Bes4bFqZUZ+ly+wlt4r7T/1d
 O4tJ6k/mKZlok1c9ltVIeDBDHXQPzGUV0oetn3P2TGZ7iy4YdY+/2ug8M/AoDmJ78OBc
 Sm7TIuwQLRsUlQdFx9LogU7ZDopsY67PFkmr2mXkmyywB/1loKmj5eRBSlCjA097tXPn
 CjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775080455; x=1775685255;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=miojPsFUKWNdvGqo4HUqNmLJ0sjKZrA/GnmJl1Sqp5U=;
 b=cSscVz8Cu+1ceLe0+q6BKkvILfWzc5XylPkMwSDO3MvzA2KTN+1LBuTmfVX8aoHsWM
 11KAkIz29H0cTactk50LVHfT9yAOwWhiw59Oe+ZpGqB+gsrziEKiDOdwDjN6iUr6ZbLn
 7VlLTeuN1Bzz0jJGJsq3aXNxNjWORorwvuR8YLr5Lbqq0AaYAImjJRP0aDfU8S+oJMeZ
 hyiFOj5WZRNLgdK24O+TSaorQRRHP336h0qKRmXuld90ois0dLGk9GTS27wbquGFR+Ct
 ttSfwBRe+zRX/xrdultFMDjhsV4V7BtI3YjUoS7/TdS8IQm8BGZjxLnKzirhJJk8bTPJ
 +Yrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2eHVqJ5co7SOwTMfKuhk/nLvVqzGLOJ+e1F/YKNhaPc/8kMrZbrB5fRL/xj4IoB2aJHe/Sck=@lists.denx.de
X-Gm-Message-State: AOJu0Yzqe5g+ob13XwU+kNE9rlGIQLtMT587NxU//YILntJUuKg6LiOV
 eKpe7kBhVuqVjArAmMbLOFJ3/oAOKNpyHGWPujGHLdvUPNpB69p124Wry2ND9iOe4r4=
X-Gm-Gg: ATEYQzxjpJ4H9LyQvyVG2DktJNFAjXeCDRoUPVUDz42pbaXQNB3LA+1EXC1Zs8r+eqy
 msca5HppbB8WPC2kLiGNFB9QhDFThCF6WebA+fdp8DfBoDinKGuGB46rz+WKb+2rGVGPCsqPoRG
 8t5/DTxzbl4re7TCm1nbuVQ/WobQKXuHSG31eppanU75einXaqqfF4ad61w4+c4OaTobpswOg71
 U3sJlq/Pv81KP4dSjtBKw+BPgOwIg1VHm3kBE9NfV+IbOicCCu+yn2+pUTaIBh0okkFEtntb5Ih
 qMwEYGTdjJRXgZWY3AU4v1vzXf2AOk6LxRsVNAJdiOnwqqk/A5Qg47vYm4KslstNTYuORJL2UDS
 ymnhvQnGh7eq9L9MxqZ0hL2vEbWH+HethKEZNJKcF9MaBKMzWFTHed9WQ9AEXPEsQwp1NJdSYJ5
 ynAL5c/KLXHnc/PpAz+ignH1CD93z6
X-Received: by 2002:a05:6830:83b9:b0:7d7:c96c:c5d6 with SMTP id
 46e09a7af769-7db992585f2mr3339164a34.1.1775080454843; 
 Wed, 01 Apr 2026 14:54:14 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:57c4:ef89:4ac4:d6d9])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dba7184e14sm743492a34.11.2026.04.01.14.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 14:54:14 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/3] arm: mediatek: mt8189: enable USB support
Date: Wed, 01 Apr 2026 16:53:44 -0500
Message-Id: <20260401-mtk-mt8189-usb-v1-0-a4bf951aa8ad@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwND3dySbCC2MLSw1C0tTtJNMkw1MDZKTjFMMUpRAmoqKEpNy6wAGxg
 dC+EXlyZlpSaXgExRqq0FAHbn5SxyAAAA
X-Change-ID: 20260401-mtk-mt8189-usb-b1e032cd1d2d
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1132; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=BeG24AmotzjpngI4lpOzYMPqMVEZbfZt8huxMLnTZi8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpzZPqwg4zQy7xcOFU8ExS1ncnJdcTZjKyn/V2B
 TO0nxTGSoSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCac2T6hYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AjvMH/3/I5gzFZ4zq3OxMR7jLJ0Y0kyY+8wzJQCbOSaL
 J6bp8Piw7YqAzGXhAVopnalcUWsC1wdO2Lae+3o6w8hmIQ9wQvLwvv1QMJusYMAPGr2QwwORAfc
 rhkZ83yVDDUHezgJJ7V9Ytq6fp1PqpqVaClQYAb8zquDqjjpP3dg7t35AGK4o0WiLslGuzM9GzT
 RVYEu/40VMIgNi1kS6+/4mCwvPDK+etIPnjpmLEoKaWPNSfqTm29+behkv4Jr2HxJoRiAgKwJwK
 SBEKML3YdrtRJkqMGBqyG8VAvaKtSvrwuKlMejjj3ss26qUHv9fAAk6szf4mxvLj0f3E/9gyOD3
 9+jE=
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

This series is adding USB support to for MT8189 and similar SoCs (i.e.
Genio 520/720 EVKs).

USB and T-PHY drivers already exist, but we need to add a new XS-PHY
driver as well.

Then we add the required devicetree nodes and enable everything in the
defconfig. These patches depend on other outstanding patches adding
Genio 520/720 support.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (3):
      phy: mediatek: new XS-PHY driver
      arm: dts: mediatek: add USB/PHY nodes for Genio 520/720
      configs: mediatek: mt8189: enable USB support

 arch/arm/dts/mt8189.dtsi              | 210 ++++++++++++
 arch/arm/dts/mt8371-genio-common.dtsi |  70 ++++
 configs/mt8189.config                 |   8 +
 drivers/phy/Kconfig                   |  11 +
 drivers/phy/Makefile                  |   1 +
 drivers/phy/phy-mtk-xsphy.c           | 600 ++++++++++++++++++++++++++++++++++
 6 files changed, 900 insertions(+)
---
base-commit: 0dc97983546c8646b4dcf20147b7fc884219eebc
change-id: 20260401-mtk-mt8189-usb-b1e032cd1d2d

Best regards,
--  
David Lechner <dlechner@baylibre.com>

