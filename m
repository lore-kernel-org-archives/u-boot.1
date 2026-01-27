Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84D7D2F031
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 13:56:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99256840EE;
	Tue, 27 Jan 2026 14:54:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FO9yFf/a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC52B83F50; Tue, 27 Jan 2026 11:14:45 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98AA083F9D
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 11:14:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ernestvanhoecke@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42fb5810d39so3515916f8f.2
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 02:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769508883; x=1770113683; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FRmV80/ofy55OEbMN1+4OoNB+PhkhQtyhwqIGK/1xHo=;
 b=FO9yFf/ab5viXiBrvWdYh8L5Jy/0q7oSjJLgW5+tc7mbvkZS75YlOJ5g69Jr30D8RG
 jbiT/i9HUnkI5qf1RYm9CPOXxNnLrA1Di9qSz9KE4ZptJmAyH1VeU81WM1rm2j51BQMe
 MVrZZhdexQkiuFtCM6se2fUPB8wLrSGG/aQDVUGhdCScX5x0PbWiGcq9rzS0juvQXtmU
 R4XrFRG984hllDlZxQ+NHgXS0DYCvcpB9Bo52jlgqfBaf33RaSH1BknN5NyT9H7/dfTy
 Enks+jjGjD+7Pq3UATvU7v00YqzW0Vnrk+XXA/0Bm3/hhbLyMR/QnqOpASbSdr3VIk5A
 TM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769508883; x=1770113683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FRmV80/ofy55OEbMN1+4OoNB+PhkhQtyhwqIGK/1xHo=;
 b=RBMe3gxRhODnirhedmVel/8BesyndMIawAU2SBG5I9FnLPrfiiqNF6r1hfEs2GNvS9
 LNghrIABjtU4NNTG+qEAq7S4SWpKDyPWveOMsdvbhgTjYEh40ny3BTNJHwsB8uFpN5Zy
 BIwKeOkjDWLWyaPWaOMupgWVFgSeJWFoKQOcQUNo76qzWI4IHh8zepWBH2d+oFZHRElV
 IgwOJcSjmMMeLk/E6qGhkv5L6dq/bXS2y2wolbyIVO+T5bWTMMeqcWFo96RSy5j1yLeS
 qLmGn/1L7GOVX6gWU0/gSKKl6tnrbdSnVo4wQSgQokFeA1oX5hd0r7JcnKmQx+/kDAy9
 IInQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQTlb/odq9gW14rtl0o3DKi9QXeCXQdymVEelDgLg8J0yEXWXQyEiHJOp+Zm4NW49YX4atvVo=@lists.denx.de
X-Gm-Message-State: AOJu0Yzg9gOzQFpnJ5EmDv1TTgVSM6whOME98XGzWPd0Jt0gAufJJQO4
 dxS8So8xlEeWsG8b1gu78rk/qeO6yJu0fcj/XGw8HGIiNjwnKw3qkdIr
X-Gm-Gg: AZuq6aJLsDoJ+2G9QNyYD2g6uyitYn9B+e3mWypmR1Wy5nP+uag7lEomfV44/rElUAQ
 8TOVr+jF/33rAVrtKV6gRjGt3oYmZByqq/4DzC8NiOnZnubVofg3XTIkX61O1XXDtwc9c3G1z3c
 HZBcrFR/r7RNTXNrjg//ffUFG/3PU1PCjtup8Z+BIYc62Dpatg8pHIC6nI8MbrRuhU9AVvA10Vv
 UwKJIs+l88sUvA7QfzLO/yhIHDDJM9FuT+mx0mBnNB48Km40ASC30PvFPOPC+yQuRNPivdVU7jz
 Kgnf/2Vuq0WLeaHwigdnJ0P++a7JUIdVJSwj5L3mlB0TqtKItXjNRN/IVAi+QzXT+scmGbFxa1y
 j4fxIync7xlZIlT5BvTCdqK9yr7CM4D+yBP6I/9OPZDAhvSMIg3CqqEVnWv4SU6qOhBtw2DC61V
 RFDd1vs97aT/5hGrDOyoYcQdOW4zHqsr4vdXgngGR8WX29edS1rQpYd8XwzUcEfcuP0VJS1BMpQ
 FRSoCrL8ZJmLaJfGfMm4Ak=
X-Received: by 2002:a05:6000:25c6:b0:429:b751:7935 with SMTP id
 ffacd0b85a97d-435dd1d7c61mr1442598f8f.56.1769508882906; 
 Tue, 27 Jan 2026 02:14:42 -0800 (PST)
Received: from ernest.corp.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c0179bsm36744525f8f.1.2026.01.27.02.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 02:14:42 -0800 (PST)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Franz Schnyder <franz.schnyder@toradex.com>, u-boot@lists.denx.de
Subject: [PATCH v1 1/2] arm: dts: k3-am69-aquila: Fix SPL USB DFU gadget
 failures
Date: Tue, 27 Jan 2026 11:14:11 +0100
Message-ID: <20260127101413.2812815-2-ernestvanhoecke@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127101413.2812815-1-ernestvanhoecke@gmail.com>
References: <20260127101413.2812815-1-ernestvanhoecke@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 27 Jan 2026 14:54:50 +0100
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

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

Around 1 in 20 times, the current R5 SPL fails to pull up the D+ line to
signal that a new USB device (the USB gadget used for downloading the
next stage) joined the bus.

With these strapping options, this is greatly reduced to 1 in thousands.

Link: https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1587424/am69-u-boot-spl-usb-dfu-cdns3-occasionally-fails-to-pull-up-d-in-cdns3_gadget_config
Fixes: 3f0528882c0d ("board: toradex: add aquila am69 support")
Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
 arch/arm/dts/k3-am69-aquila-dev-u-boot.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/k3-am69-aquila-dev-u-boot.dtsi b/arch/arm/dts/k3-am69-aquila-dev-u-boot.dtsi
index 59948b9d1f4b..5b8b8539da3f 100644
--- a/arch/arm/dts/k3-am69-aquila-dev-u-boot.dtsi
+++ b/arch/arm/dts/k3-am69-aquila-dev-u-boot.dtsi
@@ -144,6 +144,7 @@
 };
 
 &usbss0 {
+	ti,modestrap-peripheral;
 	ti,usb2-only;
 	bootph-pre-ram;
 };
-- 
2.43.0

