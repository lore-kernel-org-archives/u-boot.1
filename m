Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE500FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 15:00:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 648FF8426E;
	Tue, 28 Apr 2026 17:00:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="fEy8prWn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55AD684255; Tue, 28 Apr 2026 15:17:21 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E821284119
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 15:17:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so138525045e9.0
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 06:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777382238; x=1777987038;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jkctqVdA6nEAuGRoPYxhlry1u5Dr+3ZhtxI7qo1mEOs=;
 b=fEy8prWnWGPVKT41HFsixm81/jrKQfBcQsAMrFd74W9DH3S2yw/Si9789FKCYIak4a
 U9sg6+CXHJArhydG44y0MBzf1bK2sqZWrzwolXTvGYHiAFKteIfEkMakomxpjhzLzxV9
 XS7sv4GkkL5SNZXSep4SMF/t/y/Rj47aWsJVzeSyDPVB8BE7gLBlxLxaIUFHA4s2cTJj
 sOpzNa1PWfaIQMUkmsekSquDto0dbp7a58lv3uaSirhQ35gmg4OChAOt4lmhXDiKzCXb
 pKHYgBsRURMCfjaP2QZCTRSHKyI5zG5ohYoKhQHFmFfvEHQAgMp5u2EJ2HHMAgZ6/9m8
 GSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777382238; x=1777987038;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jkctqVdA6nEAuGRoPYxhlry1u5Dr+3ZhtxI7qo1mEOs=;
 b=cG9rfbWhGWU5wfOZOUWzG7om6m5FoT9ePUBzX9IfSP/Yz4XRk3g11/Ug3tNIl/IBut
 oLY3oG/zITIbxrp7QDmZt2/yxmeWPMkZXeN8AofhbVmGnULBJnQpQbG+q/5Jq2pgTYn9
 dMYknX4aQo2s4GMDOlhV9HOIwfcKY1jIBkUCYFze2vD6s3xGyIcbGovXq7mzGSUOREuW
 Ji7Dyb40FaLihC9D+sznAgOtP9wVX4UyUvVg32rPouLLZRotIjr8u8eZeUQ1pT7rnYEH
 g9Doi+nR/0CE1oo3Q5OSbhWeCTyHPDtOJvMX0cntQu4Uypbx/YIbKq97v9obLdk9b2iy
 oRLw==
X-Gm-Message-State: AOJu0YxlBNAhEYGalz/tdKbyooEsJ3pe+81rKZyF/u5Rvx4l3upAPhiO
 08FHfzOi/ShlbYM5CBPOtJfjxNQeH4YXV42YL8i4HQdsdzH2SaEfTTKGQnNlxfI+q1U=
X-Gm-Gg: AeBDievVBMw3LmLQpOdYf0Kn2iCMBFfJ0HoJrWVljXkGoJWHQFESKoGfy3tScFuuUdJ
 TkdjOzD9fWzzfUdk+BR0goIVJ3aDpnqlzpwN5p46heotLr+n3wenWktz+JGzrAZ+eviX12ojA4r
 0J6agaVbgGA/lRKmk+zLwRxVBqfA0kxBgAtGEsUGAFuSf39bGssBcnZFXp6terru5Av9bqr3n3B
 kKsG59SrhAr7JKenp8h4tv3MZN801NE13GM1PPgaeRfvgMRpomRlg6uGHSdSeibhA7CofzhYWPh
 f0wxV1qy4YX8lyY8xYXaGSn4UcjyENSo8VzH/lNsoPkd5OZ35J5/5+zV01A2icHjdFyJvQae6BQ
 C9+tlsLb++i8b+VzT845OpfLHHE1ObOujdn+6W/x/i2D7DdBkKrWHfQ/AVBHKs+mpj6i3h987Rb
 4VEANEt8v/R2x3hQ6QFZt5+ztvW9i4Lozdg3qNAkfXlhgzNjr73kQ6lbTUNUoginBl96T7KB20q
 Xnm7jzs50mPKWbm5kP638M6yzKczhdJBZQsBcxdevhKvTfeKAPaZnDcr+lzN0mP5Aup+Zfv02Am
 zvdNHDZVbDF2uwdNmg==
X-Received: by 2002:a05:600d:19:b0:488:9ed3:1492 with SMTP id
 5b1f17b1804b1-48a77ae0202mr38461405e9.10.1777382238127; 
 Tue, 28 Apr 2026 06:17:18 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-1bf9-06eb-939c-90d1.rev.sfr.net.
 [2a02:842a:d52e:6101:1bf9:6eb:939c:90d1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463d5ee9ecsm7139599f8f.16.2026.04.28.06.17.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 06:17:17 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 28 Apr 2026 15:17:08 +0200
Subject: [PATCH v2 1/9] MAINTAINERS: remove trailing colons from section titles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-add-ethernet-support-for-genio-520-720-v2-1-9cf2f0884bd8@baylibre.com>
References: <20260428-add-ethernet-support-for-genio-520-720-v2-0-9cf2f0884bd8@baylibre.com>
In-Reply-To: <20260428-add-ethernet-support-for-genio-520-720-v2-0-9cf2f0884bd8@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Robert Marko <robert.marko@sartura.hr>, Simon Glass <sjg@chromium.org>, 
 Yao Zi <me@ziyao.cc>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Yanqing Wang <ot_yanqing.wang@mediatek.com>, Beiyan Yun <root@infi.wang>, 
 Ryder Lee <ryder.lee@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 fanyi zhang <fanyi.zhang@mediatek.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Christophe Roullier <christophe.roullier@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Sky Huang <SkyLake.Huang@mediatek.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Tommy Shih <tommy.shih@airoha.com>, 
 Kevin-KW Huang <kevin-kw.huang@airoha.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Tue, 28 Apr 2026 17:00:38 +0200
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

For consistency, remove trailing colons for the three following
sections: ACPI, ALIST, and INTERCONNECT.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 056902f6ef2..9d68e8e3bb7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -50,7 +50,7 @@ so much easier [Ed]
 Maintainers List (try to look for most precise areas first)
 
 		-----------------------------------
-ACPI:
+ACPI
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
 F:	board/emulation/configs/acpi.config
@@ -58,7 +58,7 @@ F:	cmd/acpi.c
 F:	include/acpi/
 F:	lib/acpi/
 
-ALIST:
+ALIST
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
 F:	include/alist.h
@@ -1273,7 +1273,7 @@ S:	Maintained
 F:	drivers/timer/goldfish_timer.c
 F:	include/goldfish_timer.h
 
-INTERCONNECT:
+INTERCONNECT
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/u-boot.git

-- 
2.52.0

