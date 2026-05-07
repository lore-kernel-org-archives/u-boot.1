Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 368BECD3427
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 09:29:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB81884A4D;
	Thu,  7 May 2026 11:29:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zEHGuQU0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 331D984A44; Thu,  7 May 2026 11:29:08 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92AC984A29
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 11:28:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5a884ebba7dso604940e87.0
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 02:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778146136; x=1778750936; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nI6gl6T0jB6w89WKndUdglyLA2Kd8Juf03v62DiBf5w=;
 b=zEHGuQU0KBGQZqizUH0ju1MJzoVYov0kpKEeFgOujPuMuDjTwwuprQo3FYb1RtjnWX
 3j78JFhJMT5QJM7O3JYpsgQ5/gt104n/q/8PvIy9bToOTs1b7ZxQinTIkOIKbcIamV39
 J5jPiVyBocn6uU8TZmfrqUsP3sRkfxRuo1C+B8DQDdI+JEH5qJh8l09Qzr5KwGpE4bfQ
 +KwXyFULC5wOm8uxLGTqhgXxj6jujAZsK1BvuP1n8pTHOLliCKsLt5M1ljPZZA36pACy
 BAUgm2PmlphUI8grQy2Gk3g90FJQyRFq0SqawNUN8UahZIgH+tM+cfaJnpsRto8oraYM
 25wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146136; x=1778750936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nI6gl6T0jB6w89WKndUdglyLA2Kd8Juf03v62DiBf5w=;
 b=dkAzZNwKbQV3jWXCaMj1zwktoBzbNO/XP5OKVvZEebyu7uc5+sE08zDj6znmYg114n
 AZbqHarKpyWwXsOw2AU7dcJ8RxPs4l44ojTeTI/2sD9PCAMhz7t+WdU6c+w5KWY+yVfY
 Y0xvSiH/sXFx1faVXdH4jZxiFX7Qwdv0UMp3PB7hO+ngU0ngq7+XDMCbX699FDJxnJCl
 qWpxe9A1V/jdHgErmsU7Cbb+kb8ItWinx+PYgAarGwe0L3Tmt8kmevbBgyeztJ8ZjdHu
 3Fxjlp050Rst48tJNDLZmlxluMWjUzT97a9WpQRtT/bu+L1dC01JfZ+tYfTKARX17Cf1
 vuBg==
X-Gm-Message-State: AOJu0YzY8Pb4NxTO74jACiOAVi6z0OiusN1vHqQ+0dnVf16AY3ObxDJO
 RnTw6L4tRic/XLmpDzV8cPArGghNGLgE+3/hYhPgXa+PZeuBoKTHqkO/6rbpcrj9dSpTuhVFdCr
 rj7+npuUbPQ==
X-Gm-Gg: AeBDietwgUPN4MFCsx5Ft+GX/jVnf6C/MIvAfWODirlH7YZw1w3Bs1Szo9egacY9J7P
 7335jM/hRzmiAQyMfG58tWXCbAf8ASDovSK2ATcR8I4H9SM8FLHQil2ckdyzxsf/FeR8+ZHmSYa
 i9hb+DpUcC/2S0DvEfRYq1bKWjTwQ+4m156rzNLtWZhpHgzFWct3BLY5Pfl8bAA6ctQ65gIXAxc
 HQOEG/4J2rWN2XLfPXPj9jETV4m4eiHATXc6xUMpgtb91bLeTXrIwZvBHryA2sivmJdrCHGCD28
 AIWV9SOTdyJVUKdY9LdTBKLr8qIILvy/ZbioK4eFpKM1JTTuKzVMeTwPT2e2eKbh3pqIyQtInge
 bhzyaq9ckx+36IRZ6kAGD2DKdljgOze0nk027geyzJWQdXIEvwZpehKdYB7Qf4XPamNTy10aR3s
 QCuYKJiRj2ox6kG759ZQLysM2Kr3RnLu6rk0XuCQVftLRIdPsfqR+xw5t4svrLpZlc+BxB4bgtf
 wq/7rUuDOG1VtgC4sNGlz6poseHdJZnvy6xJYvg8g==
X-Received: by 2002:a05:6512:124b:b0:5a4:496:5bac with SMTP id
 2adb3069b0e04-5a887ceb4d8mr3062856e87.36.1778146135974; 
 Thu, 07 May 2026 02:28:55 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8914953d6sm696937e87.73.2026.05.07.02.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:28:55 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: u-boot@lists.denx.de,
	Marek Vasut <marex@denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Ryder Lee <ryder.lee@mediatek.com>,
 Simon Glass <sjg@chromium.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [RFC PATCH v2 02/64] usb: dwc3: import from kernel v3.19
Date: Thu,  7 May 2026 11:27:09 +0200
Message-ID: <20260507092843.358908-3-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507092843.358908-1-jens.wiklander@linaro.org>
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Sync Linux kernel dwc3 changes from v3.19-rc1 to v3.19.

The following files are preserved accross the import:
Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
dwc3-layerscape.c ti_usb_phy.c

Skipping unused files:
debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c

Note that this is a raw import and doesn't build.
A fixup commit at the end of the series fixes that.

List of commits: git log --oneline v3.19-rc1..v3.19
Commits imported:
39e60635a015 usb: dwc3: gadget: Stop TRB preparation after limit is reached
ec512fb8e561 usb: dwc3: gadget: Fix TRB preparation during SG
84a2b61b6eb9 usb: dwc3: pci: add support for Intel Sunrise Point PCH

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/usb/dwc3/gadget.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index f03b136ecfce..8f65ab3a3b92 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -882,8 +882,7 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep, bool starting)
 
 				if (i == (request->num_mapped_sgs - 1) ||
 						sg_is_last(s)) {
-					if (list_is_last(&req->list,
-							&dep->request_list))
+					if (list_empty(&dep->request_list))
 						last_one = true;
 					chain = false;
 				}
@@ -901,6 +900,9 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep, bool starting)
 				if (last_one)
 					break;
 			}
+
+			if (last_one)
+				break;
 		} else {
 			dma = req->request.dma;
 			length = req->request.length;
-- 
2.43.0

