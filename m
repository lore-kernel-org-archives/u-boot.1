Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD5CFF8875
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 12:40:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 353DD84852;
	Wed, 29 Apr 2026 14:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="ET+7lADN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA38884705; Wed, 29 Apr 2026 11:17:27 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C92D84711
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 11:17:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso112745435e9.3
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 02:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777454245; x=1778059045;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vDks7obpZyJiKiMiHdoRgyzLZdypXIIMbIZYpp1RNJo=;
 b=ET+7lADNBvlJ4Pcl2TADtu9tQhtLIfBcyA2DXoDkfQajhglfnmNGBZSD9s5SIxHI7c
 TZUCi9Up3mVWLYKCCb4HH8fCiQGpe4vOJVwdupsoV+iwKsBUtqTwPtGprJYYDmnxpyKL
 kxQANIVVgVNBKAUuw70z365lCp3pAoVI6CbJ38Z93QMp+jn0DWYvFwLyjhYel0HcQFd/
 loR1Juy2o6E0V1G6APbziZyi/JJs5h49KTyjff1W0VXnJMXQwp+ZqVeCawRf3VDdPWvM
 tQrJqjQ3rUA3ck77tnCJ0LdzwkkEWqypUjhVPL0T1ylrw2ES1g8q+KMPsXjCZZmcTMOf
 JmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777454245; x=1778059045;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vDks7obpZyJiKiMiHdoRgyzLZdypXIIMbIZYpp1RNJo=;
 b=SEvtAvWMCw02XZe5Y4heEaLsubv9lJDyjkHK8G50ZuT+9gI8ycBQHpac/bDqIyvB9c
 EFvZSHFn5y0WAexFdQ1HeYwUyMiHaQmhVBRirw6JBQ/wWoEBY7SptdAC6BpHxLd+VlVs
 IE6KGyXKSC1Vw8gE2vaqGi02dfidnRbuhPDrdOX2YM0JGr+ye9e0GBYaDxkWyhR/iB2D
 7mdAbKB5A6JTawMp/a5yGWD+iSc03wdG2QdS2itdqJ2nW5OOAu+db893VABBLc62cqgt
 EgjT9FFS+qA4rO3q29aWDqn0c+q+PE/tWYUkPt99IaG0nx/PRLyZux8f16cDnT9Vhr7P
 rM8Q==
X-Gm-Message-State: AOJu0YwKLrSV4KwhcMYVRiji36iZ/IlIno7rFrRkZkk52C6ir78vg1+x
 tNjwU9FQ6OaIWd8muxz9QAklerklmayAYtLnR60z6WPTA0hhTM7P6gU2MyhGXTvIh8w=
X-Gm-Gg: AeBDievaPXe3hsAbVESmlcw+3kUXMVRt4Sl6M8KP5TRRkLee9qIieS6xrGioHaDotr9
 uYO/0PovNER/fWQxoMl3wYHdg8vDWcwhKqOKz/mj26k4uSlLm0FOCV3Z+QNkYlLIZPRmK4zkYqu
 K9c5IATfjrY75KbnZDzKMM4EZiJwR8LHweiMQvpzGuKVZ9qNpkrPG98Lz7vmVJYwYRMcOcfBSkD
 w7kgE1trAq0o0OiahORhTFHggHNIMrXEbDwkHRFM6DXQEEq/VRs0qwwGATaH/6gpTzZEx56rPop
 NeowDprtCHOEmDW265xCqEdhB109kOoN7LNLTVpY4/+F5mVRL+pNEHGemguZX26nYiBU9Uhuute
 6Nfq/4HAF5tREyPHFzsszPTFzjunb4ec/+y71hCh+RAQJAyUf3KOOav4LY0wygnH8P+h3ztBOPi
 I+Up4eKZ6UANFP10lG8uj5VDT6jAVk18JfimKRLUXWGXuYIcIcEJVHLENqhv34GkDySQHhjwTKa
 MvDJnAzPiX/K4NHttOTiBxGOLPxnG6YRO+hXb0Fv/x+bg1sQ8lS+HRJvuD4vmrYM51LyHRCYn7J
 WLqqRf5usES518VmNTjHHBaPv3k=
X-Received: by 2002:a05:600c:1d0a:b0:48a:5342:36b5 with SMTP id
 5b1f17b1804b1-48a77b1e8b0mr113952555e9.21.1777454244689; 
 Wed, 29 Apr 2026 02:17:24 -0700 (PDT)
Received: from [192.168.1.64]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7b9dee18sm44478375e9.0.2026.04.29.02.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 02:17:24 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 29 Apr 2026 11:17:09 +0200
Subject: [PATCH v3 1/9] MAINTAINERS: remove trailing colons from section titles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-add-ethernet-support-for-genio-520-720-v3-1-1f65e18d4f54@baylibre.com>
References: <20260429-add-ethernet-support-for-genio-520-720-v3-0-1f65e18d4f54@baylibre.com>
In-Reply-To: <20260429-add-ethernet-support-for-genio-520-720-v3-0-1f65e18d4f54@baylibre.com>
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
X-Mailman-Approved-At: Wed, 29 Apr 2026 14:40:47 +0200
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
index 0dcc7243124..ce4e9d58037 100644
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
@@ -1279,7 +1279,7 @@ S:	Maintained
 F:	drivers/timer/goldfish_timer.c
 F:	include/goldfish_timer.h
 
-INTERCONNECT:
+INTERCONNECT
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/u-boot.git

-- 
2.52.0

