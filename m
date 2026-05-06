Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A3DCD3436
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 12:46:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 550F8849B8;
	Wed,  6 May 2026 14:46:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mKmNXH5Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66A13848A1; Wed,  6 May 2026 13:42:38 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 842368488B
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 13:42:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=antoine.gouby@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488ad135063so59759675e9.0
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 04:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778067756; x=1778672556; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u6hDDbMuwmvbLOg8d0ZEsIAuPgrQL/rIx27hxV3hcUw=;
 b=mKmNXH5Z4k+DV632CuC1iU4wXgXJ3P8ZvGB8kRocOikqviNteQ0niBJdPVjPJqxQfe
 C95RoSex7F48DKydGWv5OFw/7gVvpzzjgaqNoy5YSzWENb6EFSALJYIUnjcvbpokTQO1
 ESQSDgjvEf6o2Eed4hZtjcK67lykUXjgJSn6y9Uxvz9H9o8qqY4FxFVhTxq3UDV019dt
 98Ig2/GVwl32BHnkgQy5V90c7/RfvHJEPtK1P/l0pOEetJ2dvfFLIUT172c5h/6+zQ4W
 qiyHEJKTbFdv8kbDXKPfHWoOZ5w1/orxp5hKX7lTehxY0kd0JGxvkl3hONG9//8P3so/
 FYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778067756; x=1778672556;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=u6hDDbMuwmvbLOg8d0ZEsIAuPgrQL/rIx27hxV3hcUw=;
 b=ps7as38LQGBm56U96puDcFuDA8psiH8IbnCwjDmX8EdIMmjUxTXMicmdZG/9sETnET
 /bgbVIcEsLZ9n3KwryVdSuR1sr75NiHXf5L50ZBNTrsIPn6VAWPVPdokRMMOcUjQf6nJ
 97aTAvAPpeWvbypjJK34AjuDn6eo/rAdJSEuOSpfyqEV/OBn0za6LY/4QmO3ScjEr5t0
 PPxmD9zxI6TapZhBzqocppNDBM768MvETDI79kjnk2JLfmUFBaXAQBp+T7Nt0pWsj0Pq
 jVX+aQoLhcFiC2tlLsIMqtKkdGhVYSjjTMvKhUQWRXbYrB5G8kPHYX/a2kfcx+T+y6n3
 xkeg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9td9eK9I+YzVZb29hQQ7rBxXzLj2PaL/8yIYxAYnkOo9/CXJqt3VvKcNG2XIHUYPVNRRRjDaM=@lists.denx.de
X-Gm-Message-State: AOJu0YwsJioxlcA8M/pYr88IVWPIXkDZh9LwTAr3uHSh2UTk/PYl1ExT
 lpeeUtbq9mvx0e7qURdy94Xt2fd/RnK/h8gZTlzeoNxlFjXsjisE+nX359pOy7W3
X-Gm-Gg: AeBDievud7ifzOU0gqRFsVKHfhuCvucuy5QZ1JwzTwxsVeKdOBjogW5HzDc/313m5UQ
 Ash/R3N0AAq34EbnqN8mMkabynFo/uVFdIDCNRtHOoNH/nBBmqzsfsrl3KzvVuGIzl5CoBlDjXZ
 GYOIcuP/J/C6izQpMY/Welbl6RORgauv26S5GfEx8okUKCDh2Vez4GZZgnHw1+JJeAeqxQVbvt5
 y/Y3aK2OWAIQrSTF6qQ+cBXbvGVwdhILuIrult3+neFdb067/+/eIj6yWbtstLOSAVvYS8oa4sc
 E5uEUoajkc5CkP0FwKEjqOa1cFQ5Edp11Mv1SSU0o8qPvEMjGvQ7Ij1fmX/+3cGB4Gw4fALwECm
 X0QMAhnVBwRjiKFj3NeJ9g82oGKHLo8aBgpYIDzMEzNlxer29G13qbE3ntmch+KwJDHNUGrfsjY
 2S1QtGtCpCbbUPeHRvLbaoU/WQhBdKpS79zeR0lAuHHny4Pe/SfQ29Nzk1uxOD5+ik0Ubdla5q9
 AjiB5SJw4/JzmUpXB0OG92M5fVvYvOMwumVhpNChBh+6WCiJJty2Clmz/l0Sw==
X-Received: by 2002:a05:600c:4996:b0:48a:5821:5ffc with SMTP id
 5b1f17b1804b1-48e51e0bb6dmr32547835e9.2.1778067755585; 
 Wed, 06 May 2026 04:42:35 -0700 (PDT)
Received: from [10.0.1.145]
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53157734sm14458305e9.35.2026.05.06.04.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 04:42:34 -0700 (PDT)
From: Antoine Gouby <antoine.gouby@gmail.com>
Date: Wed, 06 May 2026 13:42:21 +0200
Subject: [PATCH 2/2] board: toradex: verdin-imx95: remove gpio1 reg
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-v1-remove-gpio1-reg-v1-2-d5e09f936d90@toradex.com>
References: <20260506-v1-remove-gpio1-reg-v1-0-d5e09f936d90@toradex.com>
In-Reply-To: <20260506-v1-remove-gpio1-reg-v1-0-d5e09f936d90@toradex.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Antoine Gouby <antoine.gouby@toradex.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1042;
 i=antoine.gouby@toradex.com; h=from:subject:message-id;
 bh=goZVcgsYNaLdC3+HZ7rlNSIxxvlaeIypK4DYTDlnnok=;
 b=owGbwMvMwCWm0rPo7MxLN2YynlZLYsj8rakuHviZq/zWq4cX+H0jYno0y848NpGf5pqqPnm1a
 I6u7iXPjlIWBjEuBlkxRZaMJ6qCfAohsh4czckwc1iZQIYwcHEKwES+LGH4H+P+RvJCUPGysLAz
 rmderT+avdZ4o9nk1b7daf8nBhSoT2RkWH2019aV+WrmHi/TtXfuPT6yf+e1bwK2fhriF0/wTM7
 VZAEA
X-Developer-Key: i=antoine.gouby@toradex.com; a=openpgp;
 fpr=68E425110E20541D48088363248CA2CD99D2D899
X-Mailman-Approved-At: Wed, 06 May 2026 14:46:02 +0200
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

From: Antoine Gouby <antoine.gouby@toradex.com>

The RGPIO2P driver contains legacy handling for compatible combinations
that expose two reg ranges (dual base) for i.MX8ULP and i.MX93.

The i.MX95 GPIO controller exposes a single register range, so the
dual-base handling is unnecessary.

Additionally, the second address of the gpio1 reg property was wrong.
When used, it needs to be offsetted by 0x40 to start at the Port Data
Output register.

Fixes: 60d8255d8dc0 ("board: toradex: add Toradex Verdin iMX95")
Signed-off-by: Antoine Gouby <antoine.gouby@toradex.com>
---
 arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi b/arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi
index 83802156d523..45633765c0f8 100644
--- a/arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi
+++ b/arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi
@@ -26,7 +26,6 @@
 };
 
 &gpio1 {
-	reg = <0 0x47400000 0 0x1000>, <0 0x47400000 0 0x40>;
 	bootph-pre-ram;
 
 	ctrl-sleep-moci-hog {

-- 
2.53.0

