Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63753EDE9AC
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 18:37:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3674890C5;
	Tue, 10 Sep 2024 20:37:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=grimler.se header.i=@grimler.se header.b="BrHx+S03";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A1E9890C9; Tue, 10 Sep 2024 20:37:28 +0200 (CEST)
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::ba])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 584F789037
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 20:37:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=grimler.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=henrik@grimler.se
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
 t=1725993445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HB86UobLCP218lu5UHXYxrozTRKSFW8RUGg5kVXfg+c=;
 b=BrHx+S03drCAZKqnX4sYUK6s6A7MuGWyqv6o0fK+dY1p5fi2hZKP/goy68havRNt4TnqdQ
 P8Sj/0TAUYxCAkpo0Ap/R7xD3fyGZDQ240gezAgqQMx9TMoxyWxDaSOj8KPDvYJSd9YqBl
 hHQ86UGn115pM22RSbyvdvUM6wxqF3M=
From: Henrik Grimler <henrik@grimler.se>
Date: Tue, 10 Sep 2024 20:37:18 +0200
Subject: [PATCH] pinctrl: exynos: fix type of count integer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-exynos-pinctrl-v1-1-f220454470ef@grimler.se>
X-B4-Tracking: v=1; b=H4sIAN2R4GYC/x3MQQqAIBBA0avIrBNUCrGrRIvSsQZCRSOM6O5Jy
 7f4/4GCmbDAyB7IeFGhGBpkx8DuS9iQk2sGJVQvjBQc6x1i4YmCPfPBrRbODMppb1ZoUcroqf7
 DaX7fD4clhxBgAAAA
To: Sam Protsenko <semen.protsenko@linaro.org>, 
 Minkyu Kang <mk7.kang@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Henrik Grimler <henrik@grimler.se>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1309; i=henrik@grimler.se;
 h=from:subject:message-id; bh=4WMz7WRdUAwF2Xfk8C+fmFiSNfe7yhJ8Ru6tB8wMQdQ=;
 b=owGbwMvMwMG4gT3Pk7swMZvxtFoSQ9qDiU+ezDxseCRWlOOzx8NUlk0Pftw0KDrDXX+0KohR3
 iFopnFNJ6MxCwMjB4OsmCKLTr3muumd8imSKx+dhRnEygQyhYGLUwAmMiGLg6HVRkZ8Q8f3r3XG
 f54cMl7i1jxPbc11zbdrM+aYZDqsvL1xgsCRSVcaJRUsT+Sv82+tc2KNOl7NwrVN3HLC273MJ0/
 rffrmGf2g+s7EJ6crjlpukvQKa+jrOmF2p8ZYWT02+EN1X26lhG/m5fYNgg1/1yipnL6XZLV7ie
 tCRv/DrVqNR5Xru+42n1yRw8vMadGTOWnG1Y3mAbt2zNX4azt79dq0FVtV/K9Mcffl3ZHEKJTVd
 /yxxcxlmw2PrJl9XtdUcK4G8+nJ8/wdq0tLmK6lZokunKFfMLtZp1JUu/Py0UeZs2uEpN8Z2wRr
 90RLMMdcls2WLdOOjRSV5/q+W3GWQ2jokuqKbonEI2GxAA==
X-Developer-Key: i=henrik@grimler.se; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-Migadu-Flow: FLOW_OUT
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

unsigned int count is used to capture return of dev_read_string_count.
When an error occurs dev_read_string_count returns -ve, which can
hence not be handled correctly. Use int instead of unsigned int so
that errors are detected.

Fixes: 16ca80adc551 ("pinctrl: Add pinctrl driver support for Exynos7420 SoC")

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
 drivers/pinctrl/exynos/pinctrl-exynos.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/exynos/pinctrl-exynos.c b/drivers/pinctrl/exynos/pinctrl-exynos.c
index b393127c64..b37282fa9d 100644
--- a/drivers/pinctrl/exynos/pinctrl-exynos.c
+++ b/drivers/pinctrl/exynos/pinctrl-exynos.c
@@ -114,8 +114,8 @@ static void exynos_pinctrl_set_pincfg(unsigned long reg_base, u32 pin_num,
 int exynos_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 {
 	struct exynos_pinctrl_priv *priv = dev_get_priv(dev);
-	unsigned int count, idx;
-	unsigned int pinvals[PINCFG_TYPE_NUM];
+	int count;
+	unsigned int idx, pinvals[PINCFG_TYPE_NUM];
 
 	/*
 	 * refer to the following document for the pinctrl bindings

---
base-commit: ce1a2630827a1f9ddadb2598ab7936732e6cb723
change-id: 20240910-exynos-pinctrl-c70d952d7f9b

Best regards,
-- 
Henrik Grimler <henrik@grimler.se>

