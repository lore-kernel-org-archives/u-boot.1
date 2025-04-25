Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F3BC369D1
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 10:56:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E496281F0D;
	Fri, 25 Apr 2025 12:56:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="aeVOo1bK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C771081F45; Fri, 25 Apr 2025 12:56:41 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B514381F7E
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 12:56:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ac7bd86f637so626887766b.1
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 03:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1745578597; x=1746183397;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TVg3hkUs3JtQxXRvXAx9j04hAVP3Dhlwl4iDWxo2w88=;
 b=aeVOo1bKZqmLLoanC97hjUU+SjUPJ1n/PGAdXdnrHKRaAfjWRBKfin4t/iVwDECwXN
 BPKgiT8/A6JZqEpAINglb3+sw/HtOPPv6CHcylttkvpcziRW5PuAn/Gu3enHsLeo9Pui
 Vn/W2SzCH9lvqNX/QS4bW+tPT80elymdg+bWUuqyL82uAMyO3CSS9tGvTHr7vmeBWayN
 Rd7bnF1rXKQXCvRy1GNcWf+Ak3OfriaD5OZWlN6GRqXOIzEJllO5474HfI3Pgm6nHsdr
 yhPtUuhmBSCB6FL8XbNAvP7q9eEV2CEO4UqMPYsKJQhWGtJY04rPbk5EwciAg+wZUSrs
 N03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745578597; x=1746183397;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TVg3hkUs3JtQxXRvXAx9j04hAVP3Dhlwl4iDWxo2w88=;
 b=KQbefcHSsmUGGcvpsc5loXmsQ3hTfOiy/fq64NNqyE0YgmhhIamjTYL9bMJI6TE0wj
 XM2VWArwVW9IayzLHdypRWQYgKPMC1ihDCprcylDwFl1T0yPeUnizSn0dccSHMTuJNak
 dogwiOrVscWFhb0sv6aLrhnsV8gaclThOEJvVwiX979kmfmQndzbVd8t/aBHpQplI58O
 74OK9fwegWpbXJ1nk3hzJaTlnun+DtFNfQ+uZM+oyN2gu7vDAcdz2zgxs6sAKyXkTj6w
 wDIwYcI56mSx0u0RIQqNk7b8vF8rnKKmCelybbUtMik+w1VkX29qLUtAjqM/XDHSI2gl
 tTjg==
X-Gm-Message-State: AOJu0YzdqQp4ln4vwIK2zMrnc1c9mRqziZShEZBj6sCAFEWHB8tLE0WM
 UKIGstQ5njjF7BIir39+lNmSCWB7dUTjBxLAFfYEgOJQTlw1idtmM7CEV3FvcVXwmHUQoJhmPr8
 F
X-Gm-Gg: ASbGnctGUDDh5knTwWhZ3JSJTImfNrLVKwdE4WBghTPmUOX6haJ07E4ZjO1tqiPFxVV
 7COHowZ2g3S7VdGGhhZL43bmZYTHRhOgvYml5mtQ9aDWA+Tc/WIyBIarrq7odQM6pkWPMlOeWsJ
 9GHDG7YuLQtAV8J3uNKrjmyJ9bFtk8/8/e4XKUuQuKQd8nfsCKrsOpq80no/fO56mc2JBMxsj2Z
 mFxv62ERFj0VMjXbhSunPccVQDPtQCfg77fYy4pB/23Tdj2C7KwmBHeCUfM9r766urmcR6yJoRx
 UgtlPZgvbkmym1rsbBYV5baX6DuiDRGSjWqwyksGEICQFRaAK6NDVSQouphN0Yzc6n6n
X-Google-Smtp-Source: AGHT+IEbKu40fme8x9oIK4fdUiW3aKG1UHXoSjksLU3CgmZecJs2jFy0LHr/86YbRpCCGe/U/waj2A==
X-Received: by 2002:a17:907:3e1d:b0:ac7:b231:9554 with SMTP id
 a640c23a62f3a-ace733d57efmr138180166b.11.1745578597622; 
 Fri, 25 Apr 2025 03:56:37 -0700 (PDT)
Received: from [127.0.1.1] ([185.164.142.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ace6ecf8978sm116839566b.98.2025.04.25.03.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 03:56:36 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Fri, 25 Apr 2025 12:56:32 +0200
Subject: [PATCH 1/4] usb: onboard-hub: Use the ofnode to check if the
 peer-hub was probed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-usb_onboard_hub_cypress_hx3-v1-1-3cc5a06087cf@thaumatec.com>
References: <20250425-usb_onboard_hub_cypress_hx3-v1-0-3cc5a06087cf@thaumatec.com>
In-Reply-To: <20250425-usb_onboard_hub_cypress_hx3-v1-0-3cc5a06087cf@thaumatec.com>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
X-Mailer: b4 0.13.0
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

Currently the check in usb_onboard_hub_bind is relying on specific
compatible string for the Michrochip USB5744. Replace this with
more generic approach that will allow to add new types of devices
to the of_match table. Because the driver only needs to bind one
"half" of the hub, the peer-hub node is used to find out if it
was already done. In case peer-hub was bound, -ENODEV is returned.

Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 common/usb_onboard_hub.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 7fe62b043e6a..9f8c1a304cdf 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -9,6 +9,7 @@
 
 #include <asm/gpio.h>
 #include <dm.h>
+#include <dm/device.h>
 #include <dm/device_compat.h>
 #include <i2c.h>
 #include <linux/delay.h>
@@ -179,8 +180,8 @@ err:
 static int usb_onboard_hub_bind(struct udevice *dev)
 {
 	struct ofnode_phandle_args phandle;
-	const void *fdt = gd->fdt_blob;
-	int ret, off;
+	struct udevice *peerdev;
+	int ret;
 
 	ret = dev_read_phandle_with_args(dev, "peer-hub", NULL, 0, 0, &phandle);
 	if (ret == -ENOENT) {
@@ -193,10 +194,14 @@ static int usb_onboard_hub_bind(struct udevice *dev)
 		return ret;
 	}
 
-	off = ofnode_to_offset(phandle.node);
-	ret = fdt_node_check_compatible(fdt, off, "usb424,5744");
-	if (!ret)
+	ret = device_find_global_by_ofnode(phandle.node, &peerdev);
+	if (ret) {
+		dev_dbg(dev, "binding before peer-hub %s\n",
+			ofnode_get_name(phandle.node));
 		return 0;
+	}
+
+	dev_dbg(dev, "peer-hub %s has been bound\n", peerdev->name);
 
 	return -ENODEV;
 }

-- 
2.43.0

