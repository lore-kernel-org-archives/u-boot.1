Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB0AC44511
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 16:09:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64B4F84C9A;
	Thu, 16 Jul 2026 18:09:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PpyHwPIb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 422F084C3F; Thu, 16 Jul 2026 15:43:14 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C78D284CEB
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 15:43:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anders.roxell@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c15c1f1be0bso85250466b.1
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784209391; x=1784814191; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uKc16XjzAny6a3EkT7qt9OEssKXWFqkGkBVr8Jd3r/s=;
 b=PpyHwPIbIEwjGbUbaARgeK+kMg8RtFMJMzd4DK2cmsZMMjzGlgciQ4/G8XrRj2NJ4G
 6kIZw0zSpPO+J1IBzAn6SkpoE32HVFTuSm8R8+RfcxwQWr0moCPomV20Mua2+D7yX/tm
 dPl+cldt1t+TO5T9YKBp7ixtTEEuWUqKNOexadcbNHhXozkoRHRXI7MoSXTGyGa2uh/b
 AuHbb02JTcyen8ScTU6mmWE0OdJEbEbfu+xzwS1MPsgik4FBCtYSBd1n/XlvvqXvXaM9
 61Sz9X5HiaUbOqPoC+oRz8Ev0EVc1PiGHmoPS3whJ1RyXKDKXRsNM9EWAAaNi/EkHPtI
 +X6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784209391; x=1784814191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uKc16XjzAny6a3EkT7qt9OEssKXWFqkGkBVr8Jd3r/s=;
 b=YFYT81LOR/BK7xVSxzhB65JwmsUXav8NIe6hFAuAtK4+UplnqU7dabzWhxAvP+NbeK
 F9K+jF2o5ejNmBpc5fxPQ2+bn7bjv0euA2ABSLnuCDbP2tQ923oKeXMKlCsZvjBxm14x
 8UnRktGbXUZ8x4Hi32PED5nr7KX2XBSTD+6lKXUkPA4oBZx6FeEV8aX49yA2UeGbmDHz
 UYxOqHQ7Fv1A+KuKKYOfp5X8wkH+Pt3bNTW3Bq2ZQzGv6Up4aSQCLFFy6d3TB3rOcLb4
 87LxK8jrPbgK/CgdEk66iUxZh6AN6oDMImq8Arc7DzZXSZX2weWML6btBwgjGbABKq6x
 5WSQ==
X-Gm-Message-State: AOJu0Yzipb5yyuFLsBjB9854t9KrW14YUI5ao8WG9S0Jaxv7J/UnTNz2
 4E/vUkEft9cAVjtyohN3TaMQfHl8FXpl61XDyJlBCUEC4oidqrMyZuCrNo3Vlu2bn4u6Zpk6KAd
 C9qv3
X-Gm-Gg: AfdE7clWXx9TBzcJUlU6kvHLu7Y0eAJAH5SVaWKrnMJh+Bnx63Mklbfbl80to9zZ8fE
 JXjNppdLi6z5miAWIpWiOLGuYMqDV9jMHaf+EjN7dsSRigaGpSOP/Zx6KEKGVgEPeQoLhz2upie
 KZXL+2aO9kHSp1X7kZxDE8TQ19YSGVW0yEntuu7edHmd3mYo64iUBgwoNlKaWmgxqMLysp7mS1G
 jHiAW4X6bqxfAEj4orJF7adFhlmLoCq2M2duHdmqKBmGYD6PXD3cJfo0X2p6h4dD5/QL+wK6BdW
 4gORA7+hJ+gqdYEkS1HbzgaQwzKfm5+6QdR78zPKkmePWx3czTKrcHYNRR9RAwmVSN4WZ4KZaBh
 29k7Qe5KMH0zFG9XDMquPUIPctptzdwmxaR6wp4ag9gCCEZnBOha/RemqNHTx2MY7XzXibUu+aR
 K6DkiZEYYT+7wyQf2zGt2FUbjvpfKqP8bQzNracp7OLbOV+xXA
X-Received: by 2002:a17:906:ee85:b0:c15:e0d3:3fd8 with SMTP id
 a640c23a62f3a-c161e99767fmr723422366b.3.1784209391208; 
 Thu, 16 Jul 2026 06:43:11 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c16871264basm217295066b.7.2026.07.16.06.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:43:10 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>, Simon Glass <sjg@chromium.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v5 02/75] usb: dwc3: import from kernel v3.19
Date: Thu, 16 Jul 2026 15:41:32 +0200
Message-ID: <20260716134305.614278-3-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716134305.614278-1-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 Jul 2026 18:09:05 +0200
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

From: Jens Wiklander <jens.wiklander@linaro.org>

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
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
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
2.53.0

