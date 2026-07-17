Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41558C4451C
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 12:33:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E28584E1B;
	Fri, 17 Jul 2026 14:33:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="E9MKGis8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4166384E19; Fri, 17 Jul 2026 14:33:47 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51DC684DF4
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 14:33:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-493b27c7451so10627695e9.0
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 05:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784291625; x=1784896425; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y1czgdexblSJpE3FBPmX/CgrZpz2BdA3W0z93Ni3efo=;
 b=E9MKGis8A1SywKJJOdcBDmyZTEgXyVJVQEM1Bgv+oTVUQ1yMu8lWb5TAlKxE2TpUBq
 0jDVaQL9ulixoqYuumbSss+bfT9Q8gnIpL/Vxlq4oVV+IPffd5NeFpY9g5t9ZXF5fv5R
 sLIKoqB2rr3hAE3SlGOIPwVCarHH7DDk9wa81Ykt6Z9LY+kdiGmt+CAaiHLREuc/CbdH
 Iv2Sq+s7xA3bgZ3YTe771GrctLkAwb0+z/qeYhmxthHXvRfHJNBb1STmdByavHNCTYNA
 Tvk0KfNuGgdywU3ucZ/9waKq0nF/bls4hUUY0ZAo+PR5UUAeYwKNK+BD0zeIwDxD01Xt
 W1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784291625; x=1784896425;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y1czgdexblSJpE3FBPmX/CgrZpz2BdA3W0z93Ni3efo=;
 b=XUk0w3TrjlTgMhUNARzKWx2uiJjYYwyU7pHHhAnmzSqe2RWh/9lKUkwk5hbq+sY9F6
 vmPWs+SLzMHdex990RgyuYdN0gBBmpd4gl0XSEOT8d7ln6XcIMDl+rnlmElwADrx8Gzv
 0LTkr4on+pIKZUIKlX/mSQQnsxBnqwhfnFIZrm3D4GR7mLUCZ3DpP2O6Fi9GDhivYH3f
 F3Sc8FghpfgIpEcV2GS6d3EjZHLDolykEk1FG5aG+IK0kjgDXzhHAtIkasgHxj+ChOFd
 A5DUxofpNF8Xth20AE4UhVvTghTaw9tADvqrkj4SmOzVFkiDcxup4g10y2B9/sLaWSkI
 /coA==
X-Gm-Message-State: AOJu0YyY/HZCw2IpKlW+6+fYi1tYNbeWLaQk9DAnTf3FWOxmrcCBCUWq
 cF96Ba9qCWaGzar9pCOBB7TXHK8sF+d8Juc1A3VUja/mN+7KJqZqPQp3U6EtSY1VRv8=
X-Gm-Gg: AfdE7clNJ4uOHUHp+2Nn6XVYLBTQPygmNiP6gfVeC96dZ4OZoTSpymWC4+GZ0OrwNVQ
 pDYT2Nm0rE/temAzCCn3jXyofsAxr4sRv6wT1oeGLk99b/gHcDiWkxZQPLTqGF0Do5KnCrQh3jg
 +Bk565BD/JOW+kxITgnN6bd3h919gYUcf5p0NB7AmxIrMTmqtvxcHFiwN8jnD1COZCUIutypBn7
 +e+XNciodpl+DZrFxVTQoMyoxTBdzSiTFziTl4GzrU9LsGGz/cIaPESjk/JO+E8WCURGR3gSrLG
 rX6jfTUsu/NAcr8k0ZW3owUyEnA7YxTrijUcKjyK53j82jvko5103C5sVdKMagaIxBD2preCFeG
 ArDKhhHE0tg2GZGh/w66XV2WELeOMa9i34iNiO9w3SKEolkk08f1MPsAyWBXCIRsfZCJNxfsFBc
 jJeUJZN1FnrGx+fmjZAaxLm9K4lgMI5hSS2BCH3WON4fY9bJZDNr2l8Bb4ifBXSUpkVtcv8scpq
 wPCkmnbk+g5oXq/oNUhFA1JsdHIGvhkU6FziDP1yi4I5LDxIR/UIdzup4QwVQCNkC8SkXA=
X-Received: by 2002:a05:600c:1381:b0:493:b698:9247 with SMTP id
 5b1f17b1804b1-4954a33dd74mr30311965e9.14.1784291624505; 
 Fri, 17 Jul 2026 05:33:44 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495499f3f99sm44199595e9.0.2026.07.17.05.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 05:33:44 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 17 Jul 2026 14:33:40 +0200
Subject: [PATCH 1/2] edid: add default EDID_ADDR macro
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-mt8188-add-ddc-i2c-driver-v1-1-e89ccd173567@baylibre.com>
References: <20260717-mt8188-add-ddc-i2c-driver-v1-0-e89ccd173567@baylibre.com>
In-Reply-To: <20260717-mt8188-add-ddc-i2c-driver-v1-0-e89ccd173567@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Heiko Schocher <hs@nabladev.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
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

EDID info is most of the time stored at address 0x50, so define a macro
for it in the common edid.h header.

Also drop the now-duplicate definition from the Rockchip edp_rk3288.h
header and rely on the common one.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 arch/arm/include/asm/arch-rockchip/edp_rk3288.h | 1 -
 include/edid.h                                  | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-rockchip/edp_rk3288.h b/arch/arm/include/asm/arch-rockchip/edp_rk3288.h
index edacf102852..2332ae30953 100644
--- a/arch/arm/include/asm/arch-rockchip/edp_rk3288.h
+++ b/arch/arm/include/asm/arch-rockchip/edp_rk3288.h
@@ -527,7 +527,6 @@ check_member(rk3288_edp, pll_reg_5, 0xa00);
 #define PLL_LOCK_TIMEOUT 10
 #define DP_INIT_TRIES 10
 
-#define EDID_ADDR				0x50
 #define EDID_LENGTH				0x80
 #define EDID_HEADER				0x00
 #define EDID_EXTENSION_FLAG			0x7e
diff --git a/include/edid.h b/include/edid.h
index cee7c4c7637..77a5d258311 100644
--- a/include/edid.h
+++ b/include/edid.h
@@ -14,6 +14,9 @@
 
 #include <linux/types.h>
 
+/* Default EDID address */
+#define EDID_ADDR	0x50
+
 /* Size of the EDID data */
 #define EDID_SIZE	128
 #define EDID_EXT_SIZE	256

-- 
2.54.0

