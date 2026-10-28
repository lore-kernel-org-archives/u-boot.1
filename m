Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653CA606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oY66amsT;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=efo5Zu78
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 11CFB408CC;
	Wed, 28 Oct 2026 14:48:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pnh-JtfMRFds; Wed, 28 Oct 2026 14:48:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F0A614089B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198904;
	b=e2zqK1NIayAnvPR0QjBP85i1/qygJVMA4ERgk3z3wDoG/gcECCCRP+4WPEjDggmeVp+p
	 m2LfqV2DWoUVoOalSZvSKkfJJLxAKmfDhYwsxjPzAyk828KBWGSF+mAbaS6VwxlZCyT5l
	 lGaN6OXpdbzzcB/jaEbHbcEhXk2hiV5rzaxuGtJc//POTnk9rKlRUz+yshl9OLvVrW4yg
	 tSFWOa7f6w1pjG0jIisYrCQWJSWfD+ri0AKRq5RGqDw8cMOs+IR20njl03R14IzDfq1MF
	 YH6sQCnZrLRRuncVMXcsMyVRa+JcWKZAPvoDo+Nxoo+WPbBCkPaLmxmC6oEQiVXJqQg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198904;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=OmtbFglGxLuoS/KV3BeL7tNdBPB+WwSh76NuHbsZqkA=;
	b=j20le9MSicrhWXH0GlPQheJGgB1YUFdJHdOVsRgubM5c1nfYDEKrhJccANGe/vGq/g9m
	 2zVOZrnR5DlWiXQvr/V06bBioI05obsZFq94bbARfYVqLJDM7N9VbpYuohSScIe2eNS0o
	 AWFQ9HjCoucaarXI8e4MQmlQgnig7BDfahoAg1jCFTxs91eWBQshYYaJrIWCl+WXI2BEG
	 Inbt0v3puUx57OvDwnqPA8ZyHZ+83YC24ZavpSN/P11VUMTH6JNbCj7N897iTZrLFDuDA
	 69Ej1AjR6GaraIPg6qBThKwjApxHPkunRwujyezcebfj/qqiOw6JbKhqq2bxlUQ4RQA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198904;
	bh=OmtbFglGxLuoS/KV3BeL7tNdBPB+WwSh76NuHbsZqkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oY66amsTWpmqE1tseptaAOWj+Z5OCUZ5+E+XDJDvPtzimn1xMTgLR+WqTAoThb8fK
	 hpJvb7I5NQLpQACuhjX7/L0Amy+L/cwoJu5rQ/EdqK2GXLbL4br5Sk5L2sRuNODTmz
	 kk9JA5uOtnSePc/Ages5jBIeAPdPTaalCpiFOryk8h1OXGLEY54nXHZ0k+JGyi4QM2
	 6izP4SUgVBd2mOU4HLoiOIDwoRc2SHigxImvCObUboZLB7GOj4lFzeDXzWs+NMkc+z
	 voQmL4xau/yxfrcNrM6P2n7t0p8V+CMCszKBWJd9/yVfqvmL7CsVGV7n3xTpnKjxgQ
	 nWrAFQiF+fRSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F0A614089B;
	Wed, 28 Oct 2026 14:48:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A01F972
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1BBF44009E
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B3gsYYXvNmZC for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:17:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 80B144008A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793197019;
 b=WbSbYLwYUyymeT9OUU4sNBx/L/FzyF3Y/n8fFbcTdKrbXOhjA4zbwAPkb9QFY+5I3y3Q
 g4szstxXCpWtvMluvoXvxnzdVrm65ecvPzOksS/AWR9P40o2dfQYVfSx8nMyIqKc8AX+O
 vJpGP9OJ1YcPQq07hotHOH6feTIdIK0c65wxg3MwGQGRhL+KpBJ/KnP8Hnj8lN8RrTsEy
 3AWI8xTXdTihGRsx+Wkg4OhZjdwc8ZYrSfqQyXPtudq15ju/xXbYRFqt8hDYCYDEsTxwI
 PPTqVhntWw8oVb0j4sgIyvM/xL7ENJz5De7ThTy/iKT3Vb75foZg1jUCWACesoggYHA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793197019;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=OmtbFglGxLuoS/KV3BeL7tNdBPB+WwSh76NuHbsZqkA=;
 b=q22MFJ3hcgLAfc4zHlV8cgI52II4eyL/kZ/Svt82hx7Lhp2NPOfkb3/F6PLd5S759d02
 JTOJ89WJ1L/4WneqVXGfelGviMKS4b88BN0yPeJYB/HjKvgMiBNzhYB0R0IUuRSdGzHBj
 8GaWpbUFXUESHb/8FYSc1S4VFEXZFuEWyrDOiiyv02dFKQAmP39tkcUN9gZAE1V0FqJIv
 V9Sp2iwJKwRCBPYsaF/pc55xISuhvIIoS3dCwBBwqmr5wd+YlvJo3dDWh7CQZNgyuDo6w
 XnDqAY6U0usdIOJ9VxI6IK/l7GKSQ4BEeU9uPpU2INsEpDUboI18krw7suz8nXP5DNQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=efo5Zu78; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::52b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=efo5Zu78
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 80B144008A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:58 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6b4584287adso185566a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793197017; x=1793801817;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OmtbFglGxLuoS/KV3BeL7tNdBPB+WwSh76NuHbsZqkA=;
 b=efo5Zu783qFUlSTQ2FfVJKTZYY8rQEtrVkXKnnjlz/AYiMrMz9C/vNjD4ja94VLngK
 7AxiOw06liVIdnnKqyAmUgyqvw+3SUCEJUn1H9lYzGQcOtBMJPPJMpI0TDojljNqgRa5
 ZdHAGIqPeeygGsp48IU4bmb4BlrBDOAXmQPL5HYew3xhuAB5Y1wo5zZ54/IGEmT+iTTs
 6CobjnLd9ktE3Ltp5F3mx6dJtcMuyzsnDZYSUKlshAztcMnrbWFCo6/Mg0oO/ODKKrkG
 xRq4kwwkFB247347W9pDGdTY/M7FMEXV4o9N5QaMUBa8PxvPGYmV3qVjtnnzzxXcyZKC
 3EVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793197017; x=1793801817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OmtbFglGxLuoS/KV3BeL7tNdBPB+WwSh76NuHbsZqkA=;
 b=ugB1/F36fSZDABCELItvjMirzFzh/VNFGYT3Oc7R25FUR3RlXA6mOCxa7F/nS9ULDM
 mAHSl/k3brHVCzCVo6tplOUzQIK9RWLPyukXidnGZun0chKIPrE8Alpse9Lc1cI/mCn0
 ylExATUZbJgvovGXba6GiXxXxjPHRSoOHeWnAyqcGn+eyFMTDfVYODLBqV2xh+SaJ/je
 w8w0zlceKpM83HLinE8SkmFhV8ZRnwnfkhc330BwrZtMmxJUc3tTvsQZfIweomd4GdHh
 NO5FiElOaRWp2JqWnm/84V6gsoBGP3kDWafZoRX6xR9kFCBO4wk1SPZIBZXVkjihhSvk
 rwLQ==
X-Gm-Message-State: AFq9FYLNqfAjKf5JtEuoURJhK9xjlMy6qJxAG4EIWLMaTFQEIR/+gBQ0
 gP+OB3BOq42srg6i5GrsAyuYXL4QOB3h1Brh70+k900v7qk7AKxems7uef61OZQs8a1gLH+HTJN
 HYS8o
X-Gm-Gg: AYBFou1vrgkxPrSQ0LY6mTYASwYYeZXN0vyxi9CnQmrng3qytzvvzZaFZUvWx+SRNjC
 XiNFxlHWEDExDC0I4ajaV0hzi7/WboVb+/2PNtki8RcXFRO1b0awzT6ccyEJa6Di2VIzSP0C0oR
 B4vCOvl6RXpPG4VN2bXrqeq6XDDWPNNw2xgMTciABsgmHcbWIhDk8IFwWWzk1I0OocbrFARoZzT
 ETzAh/FdlWkoQGp356zrYRmxd5XzUJb4IUSqrFDI8RqwGl29a+DLyPubnIQUPNWTaofhurq9f3z
 7zs7syxR+W2W8gfhXF2PFCXRdn3VVCrYfRFs7MbDMjjGBgkw/0nYsJ1w+Z15coAuIQmFUcj7LLH
 c0qEdm7PLXt3TkoUDA958BDPdBMUPab1SH5y93CRhqdGD3P9HHW/gnAi0QlwOo0rnh4rdZhnxNX
 qoz9gqpexRW0OahI/I9NT6edMcT5kgnQGyRzX3X5PF4CMLqwL9+pTCR/SmSqU82lOneWDvdGBNG
 QKyNHfXSyhW2wHI7Lu2TIYYsE5A6NrhSQGWSiEQTG5JI4StMT9NygpOduxehDsiGI5YaZA9bvrj
 jSs0dbmBVxWIPzxnuLJxQS6YZg25+3nu3Z/qTZbe6qRbpYlw6art8UkQddJ4A/YU+lIwlGv7b+2
 lTXxcf9PexA==
X-Received: by 2002:a17:906:fd0:b0:c40:b180:db3b with SMTP id
 a640c23a62f3a-c49bdf8d67fmr247420566b.3.1793197016926; 
 Wed, 28 Oct 2026 07:16:56 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd524266sm630412866b.38.2026.10.28.07.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:16:56 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v10 15/30] usb: dwc3: make the am62 glue build in U-Boot
Date: Wed, 28 Oct 2026 15:15:39 +0100
Message-ID: <20261028141554.3073545-16-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028141554.3073545-1-anders.roxell@linaro.org>
References: <20261028141554.3073545-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:47 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adapt the TI AM62 DWC3 glue to U-Boot after the resync.

The restore commit deleted dwc3-am62.c, since it was not part of the
v3.19-rc1 import, and the resync brought back the kernel version. That
one has no dwc3_glue_ops, so add ti_am62_ops as static const the way
U-Boot had it before.

dev_remap_addr_index() returns NULL on failure, not an error pointer.
Check for NULL, like commit 83abf9120071 ("usb: dwc3-am62: check
dev_remap_addr_index() for NULL") did before the resync.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/dwc3-am62.c | 424 ++++++-----------------------------
 1 file changed, 67 insertions(+), 357 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index 9db8f3ca493d..57a34d69fbeb 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -1,129 +1,23 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * dwc3-am62.c - TI specific Glue layer for AM62 DWC3 USB Controller
- *
- * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com
+ * TI AM62 specific glue layer for DWC3
  */
 
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/mfd/syscon.h>
-#include <linux/of.h>
-#include <linux/of_platform.h>
-#include <linux/pm_runtime.h>
-#include <linux/clk.h>
-#include <linux/regmap.h>
-#include <linux/pinctrl/consumer.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <regmap.h>
+#include <syscon.h>
+#include <asm/io.h>
 
-#include "core.h"
+#include "dwc3-generic.h"
 
-/* USB WRAPPER register offsets */
-#define USBSS_PID			0x0
-#define USBSS_OVERCURRENT_CTRL		0x4
-#define USBSS_PHY_CONFIG		0x8
-#define USBSS_PHY_TEST			0xc
-#define USBSS_CORE_STAT			0x14
-#define USBSS_HOST_VBUS_CTRL		0x18
 #define USBSS_MODE_CONTROL		0x1c
-#define USBSS_WAKEUP_CONFIG		0x30
-#define USBSS_WAKEUP_STAT		0x34
-#define USBSS_OVERRIDE_CONFIG		0x38
-#define USBSS_IRQ_MISC_STATUS_RAW	0x430
-#define USBSS_IRQ_MISC_STATUS		0x434
-#define USBSS_IRQ_MISC_ENABLE_SET	0x438
-#define USBSS_IRQ_MISC_ENABLE_CLR	0x43c
-#define USBSS_IRQ_MISC_EOI		0x440
-#define USBSS_INTR_TEST			0x490
-#define USBSS_VBUS_FILTER		0x614
-#define USBSS_VBUS_STAT			0x618
-#define USBSS_DEBUG_CFG			0x708
-#define USBSS_DEBUG_DATA		0x70c
-#define USBSS_HOST_HUB_CTRL		0x714
-
-/* PHY CONFIG register bits */
+#define USBSS_PHY_CONFIG		0x8
 #define USBSS_PHY_VBUS_SEL_MASK		GENMASK(2, 1)
 #define USBSS_PHY_VBUS_SEL_SHIFT	1
-#define USBSS_PHY_LANE_REVERSE		BIT(0)
-
-/* CORE STAT register bits */
-#define USBSS_CORE_OPERATIONAL_MODE_MASK	GENMASK(13, 12)
-#define USBSS_CORE_OPERATIONAL_MODE_SHIFT	12
-
-/* MODE CONTROL register bits */
 #define USBSS_MODE_VALID	BIT(0)
-
-/* WAKEUP CONFIG register bits */
-#define USBSS_WAKEUP_CFG_OVERCURRENT_EN	BIT(3)
-#define USBSS_WAKEUP_CFG_LINESTATE_EN	BIT(2)
-#define USBSS_WAKEUP_CFG_SESSVALID_EN	BIT(1)
-#define USBSS_WAKEUP_CFG_VBUSVALID_EN	BIT(0)
-
-#define USBSS_WAKEUP_CFG_ALL	(USBSS_WAKEUP_CFG_VBUSVALID_EN | \
-				 USBSS_WAKEUP_CFG_SESSVALID_EN | \
-				 USBSS_WAKEUP_CFG_LINESTATE_EN | \
-				 USBSS_WAKEUP_CFG_OVERCURRENT_EN)
-
-#define USBSS_WAKEUP_CFG_NONE	0
-
-/* WAKEUP STAT register bits */
-#define USBSS_WAKEUP_STAT_OVERCURRENT	BIT(4)
-#define USBSS_WAKEUP_STAT_LINESTATE	BIT(3)
-#define USBSS_WAKEUP_STAT_SESSVALID	BIT(2)
-#define USBSS_WAKEUP_STAT_VBUSVALID	BIT(1)
-#define USBSS_WAKEUP_STAT_CLR		BIT(0)
-
-/* IRQ_MISC_STATUS_RAW register bits */
-#define USBSS_IRQ_MISC_RAW_VBUSVALID	BIT(22)
-#define USBSS_IRQ_MISC_RAW_SESSVALID	BIT(20)
-
-/* IRQ_MISC_STATUS register bits */
-#define USBSS_IRQ_MISC_VBUSVALID	BIT(22)
-#define USBSS_IRQ_MISC_SESSVALID	BIT(20)
-
-/* IRQ_MISC_ENABLE_SET register bits */
-#define USBSS_IRQ_MISC_ENABLE_SET_VBUSVALID	BIT(22)
-#define USBSS_IRQ_MISC_ENABLE_SET_SESSVALID	BIT(20)
-
-/* IRQ_MISC_ENABLE_CLR register bits */
-#define USBSS_IRQ_MISC_ENABLE_CLR_VBUSVALID	BIT(22)
-#define USBSS_IRQ_MISC_ENABLE_CLR_SESSVALID	BIT(20)
-
-/* IRQ_MISC_EOI register bits */
-#define USBSS_IRQ_MISC_EOI_VECTOR	BIT(0)
-
-/* VBUS_STAT register bits */
-#define USBSS_VBUS_STAT_SESSVALID	BIT(2)
-#define USBSS_VBUS_STAT_VBUSVALID	BIT(0)
-
-/* USB_PHY_CTRL register bits in CTRL_MMR */
-#define PHY_CORE_VOLTAGE_MASK	BIT(31)
 #define PHY_PLL_REFCLK_MASK	GENMASK(3, 0)
-
-/* USB PHY2 register offsets */
-#define	USB_PHY_PLL_REG12		0x130
-#define	USB_PHY_PLL_LDO_REF_EN		BIT(5)
-#define	USB_PHY_PLL_LDO_REF_EN_EN	BIT(4)
-
-#define DWC3_AM62_AUTOSUSPEND_DELAY	100
-
-#define USBSS_DEBUG_CFG_OFF		0x0
-#define USBSS_DEBUG_CFG_DISABLED	0x7
-
-struct dwc3_am62 {
-	struct device *dev;
-	void __iomem *usbss;
-	struct clk *usb2_refclk;
-	int rate_code;
-	struct regmap *syscon;
-	unsigned int offset;
-	unsigned int vbus_divider;
-	u32 wakeup_stat;
-	void __iomem *phy_regs;
-};
-
-static const int dwc3_ti_rate_table[] = {	/* in KHZ */
+static const int dwc3_ti_am62_rate_table[] = {	/* in KHZ */
 	9600,
 	10000,
 	12000,
@@ -139,277 +33,93 @@ static const int dwc3_ti_rate_table[] = {	/* in KHZ */
 	52000,
 };
 
-static inline u32 dwc3_ti_readl(struct dwc3_am62 *am62, u32 offset)
-{
-	return readl((am62->usbss) + offset);
-}
-
-static inline void dwc3_ti_writel(struct dwc3_am62 *am62, u32 offset, u32 value)
+static void dwc3_ti_am62_glue_configure(struct udevice *dev, int index,
+					enum usb_dr_mode mode)
 {
-	writel(value, (am62->usbss) + offset);
-}
-
-static int phy_syscon_pll_refclk(struct dwc3_am62 *am62)
-{
-	struct device *dev = am62->dev;
-	struct device_node *node = dev->of_node;
-	struct regmap *syscon;
-	int ret;
-
-	syscon = syscon_regmap_lookup_by_phandle_args(node, "ti,syscon-phy-pll-refclk",
-						      1, &am62->offset);
-	if (IS_ERR(syscon)) {
-		dev_err(dev, "unable to get ti,syscon-phy-pll-refclk regmap\n");
-		return PTR_ERR(syscon);
-	}
-
-	am62->syscon = syscon;
-
-	/* Core voltage. PHY_CORE_VOLTAGE bit Recommended to be 0 always */
-	ret = regmap_update_bits(am62->syscon, am62->offset, PHY_CORE_VOLTAGE_MASK, 0);
-	if (ret) {
-		dev_err(dev, "failed to set phy core voltage\n");
-		return ret;
-	}
-
-	ret = regmap_update_bits(am62->syscon, am62->offset, PHY_PLL_REFCLK_MASK, am62->rate_code);
-	if (ret) {
-		dev_err(dev, "failed to set phy pll reference clock rate\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static int dwc3_ti_init(struct dwc3_am62 *am62)
-{
-	int ret;
-	u32 reg;
-
-	/* Read the syscon property and set the rate code */
-	ret = phy_syscon_pll_refclk(am62);
-	if (ret)
-		return ret;
-
-	/* Workaround Errata i2409 */
-	if (am62->phy_regs) {
-		reg = readl(am62->phy_regs + USB_PHY_PLL_REG12);
-		reg |= USB_PHY_PLL_LDO_REF_EN | USB_PHY_PLL_LDO_REF_EN_EN;
-		writel(reg, am62->phy_regs + USB_PHY_PLL_REG12);
-	}
-
-	/* VBUS divider select */
-	reg = dwc3_ti_readl(am62, USBSS_PHY_CONFIG);
-	if (am62->vbus_divider)
-		reg |= 1 << USBSS_PHY_VBUS_SEL_SHIFT;
-
-	dwc3_ti_writel(am62, USBSS_PHY_CONFIG, reg);
-
-	clk_prepare_enable(am62->usb2_refclk);
-
-	/* Set mode valid bit to indicate role is valid */
-	reg = dwc3_ti_readl(am62, USBSS_MODE_CONTROL);
-	reg |= USBSS_MODE_VALID;
-	dwc3_ti_writel(am62, USBSS_MODE_CONTROL, reg);
-
-	return 0;
-}
-
-static int dwc3_ti_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *node = pdev->dev.of_node;
-	struct dwc3_am62 *am62;
+	struct clk usb2_refclk;
+	int rate_code, i, ret;
 	unsigned long rate;
-	int i, ret;
-
-	am62 = devm_kzalloc(dev, sizeof(*am62), GFP_KERNEL);
-	if (!am62)
-		return -ENOMEM;
-
-	am62->dev = dev;
-	platform_set_drvdata(pdev, am62);
+	u32 reg;
+	void *usbss;
+	bool vbus_divider;
+	struct regmap *syscon;
+	struct ofnode_phandle_args args;
 
-	am62->usbss = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(am62->usbss)) {
+	usbss = dev_remap_addr_index(dev, 0);
+	if (!usbss) {
 		dev_err(dev, "can't map IOMEM resource\n");
-		return PTR_ERR(am62->usbss);
+		return;
 	}
 
-	am62->usb2_refclk = devm_clk_get(dev, "ref");
-	if (IS_ERR(am62->usb2_refclk)) {
+	ret = clk_get_by_name(dev, "ref", &usb2_refclk);
+	if (ret) {
 		dev_err(dev, "can't get usb2_refclk\n");
-		return PTR_ERR(am62->usb2_refclk);
+		return;
 	}
 
 	/* Calculate the rate code */
-	rate = clk_get_rate(am62->usb2_refclk);
-	rate /= 1000;	// To KHz
-	for (i = 0; i < ARRAY_SIZE(dwc3_ti_rate_table); i++) {
-		if (dwc3_ti_rate_table[i] == rate)
+	rate = clk_get_rate(&usb2_refclk);
+	rate /= 1000;	/* To KHz */
+	for (i = 0; i < ARRAY_SIZE(dwc3_ti_am62_rate_table); i++) {
+		if (dwc3_ti_am62_rate_table[i] == rate)
 			break;
 	}
 
-	if (i == ARRAY_SIZE(dwc3_ti_rate_table)) {
+	if (i == ARRAY_SIZE(dwc3_ti_am62_rate_table)) {
 		dev_err(dev, "unsupported usb2_refclk rate: %lu KHz\n", rate);
-		return -EINVAL;
+		return;
 	}
 
-	am62->rate_code = i;
+	rate_code = i;
 
-	am62->phy_regs = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(am62->phy_regs)) {
-		dev_err(dev, "can't map PHY IOMEM resource. Won't apply i2409 fix.\n");
-		am62->phy_regs = NULL;
+	/* Read the syscon property */
+	syscon = syscon_regmap_lookup_by_phandle(dev, "ti,syscon-phy-pll-refclk");
+	if (IS_ERR(syscon)) {
+		dev_err(dev, "unable to get ti,syscon-phy-pll-refclk regmap\n");
+		return;
 	}
 
-	am62->vbus_divider = device_property_read_bool(dev, "ti,vbus-divider");
-
-	ret = dwc3_ti_init(am62);
+	ret = ofnode_parse_phandle_with_args(dev_ofnode(dev), "ti,syscon-phy-pll-refclk", NULL, 1,
+					     0, &args);
 	if (ret)
-		return ret;
+		return;
 
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
-	/*
-	 * Don't ignore its dependencies with its children
-	 */
-	pm_suspend_ignore_children(dev, false);
-	pm_runtime_get_noresume(dev);
-
-	ret = of_platform_populate(node, NULL, NULL, dev);
+	/* Program PHY PLL refclk by reading syscon property */
+	ret = regmap_update_bits(syscon, args.args[0], PHY_PLL_REFCLK_MASK, rate_code);
 	if (ret) {
-		dev_err(dev, "failed to create dwc3 core: %d\n", ret);
-		goto err_pm_disable;
-	}
-
-	/* Device has capability to wakeup system from sleep */
-	device_set_wakeup_capable(dev, true);
-	ret = device_wakeup_enable(dev);
-	if (ret)
-		dev_err(dev, "couldn't enable device as a wakeup source: %d\n", ret);
-
-	/* Setting up autosuspend */
-	pm_runtime_set_autosuspend_delay(dev, DWC3_AM62_AUTOSUSPEND_DELAY);
-	pm_runtime_use_autosuspend(dev);
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
-	return 0;
-
-err_pm_disable:
-	clk_disable_unprepare(am62->usb2_refclk);
-	pm_runtime_disable(dev);
-	pm_runtime_set_suspended(dev);
-	return ret;
-}
-
-static void dwc3_ti_remove(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct dwc3_am62 *am62 = platform_get_drvdata(pdev);
-	u32 reg;
-
-	pm_runtime_get_sync(dev);
-	device_init_wakeup(dev, false);
-	of_platform_depopulate(dev);
-
-	/* Clear mode valid bit */
-	reg = dwc3_ti_readl(am62, USBSS_MODE_CONTROL);
-	reg &= ~USBSS_MODE_VALID;
-	dwc3_ti_writel(am62, USBSS_MODE_CONTROL, reg);
-
-	pm_runtime_put_sync(dev);
-	pm_runtime_disable(dev);
-	pm_runtime_dont_use_autosuspend(dev);
-	pm_runtime_set_suspended(dev);
-}
-
-#ifdef CONFIG_PM
-static int dwc3_ti_suspend_common(struct device *dev)
-{
-	struct dwc3_am62 *am62 = dev_get_drvdata(dev);
-	u32 reg, current_prtcap_dir;
-
-	if (device_may_wakeup(dev)) {
-		reg = dwc3_ti_readl(am62, USBSS_CORE_STAT);
-		current_prtcap_dir = (reg & USBSS_CORE_OPERATIONAL_MODE_MASK)
-				     >> USBSS_CORE_OPERATIONAL_MODE_SHIFT;
-		/* Set wakeup config enable bits */
-		reg = dwc3_ti_readl(am62, USBSS_WAKEUP_CONFIG);
-		if (current_prtcap_dir == DWC3_GCTL_PRTCAP_HOST) {
-			reg = USBSS_WAKEUP_CFG_LINESTATE_EN | USBSS_WAKEUP_CFG_OVERCURRENT_EN;
-		} else {
-			reg = USBSS_WAKEUP_CFG_VBUSVALID_EN | USBSS_WAKEUP_CFG_SESSVALID_EN;
-			/*
-			 * Enable LINESTATE wake up only if connected to bus
-			 * and in U2/L3 state else it causes spurious wake-up.
-			 */
-		}
-		dwc3_ti_writel(am62, USBSS_WAKEUP_CONFIG, reg);
-		/* clear wakeup status so we know what caused the wake up */
-		dwc3_ti_writel(am62, USBSS_WAKEUP_STAT, USBSS_WAKEUP_STAT_CLR);
-	}
-
-	/* just to track if module resets on suspend */
-	dwc3_ti_writel(am62, USBSS_DEBUG_CFG, USBSS_DEBUG_CFG_DISABLED);
-
-	clk_disable_unprepare(am62->usb2_refclk);
-
-	return 0;
-}
-
-static int dwc3_ti_resume_common(struct device *dev)
-{
-	struct dwc3_am62 *am62 = dev_get_drvdata(dev);
-	u32 reg;
-
-	reg = dwc3_ti_readl(am62, USBSS_DEBUG_CFG);
-	if (reg != USBSS_DEBUG_CFG_DISABLED) {
-		/* lost power/context */
-		dwc3_ti_init(am62);
-	} else {
-		dwc3_ti_writel(am62, USBSS_DEBUG_CFG, USBSS_DEBUG_CFG_OFF);
-		clk_prepare_enable(am62->usb2_refclk);
+		dev_err(dev, "failed to set phy pll reference clock rate\n");
+		return;
 	}
 
-	if (device_may_wakeup(dev)) {
-		/* Clear wakeup config enable bits */
-		dwc3_ti_writel(am62, USBSS_WAKEUP_CONFIG, USBSS_WAKEUP_CFG_NONE);
-	}
+	/* VBUS divider select */
+	reg = readl(usbss + USBSS_PHY_CONFIG);
+	vbus_divider = dev_read_bool(dev, "ti,vbus-divider");
+	if (vbus_divider)
+		reg |= 1 << USBSS_PHY_VBUS_SEL_SHIFT;
 
-	reg = dwc3_ti_readl(am62, USBSS_WAKEUP_STAT);
-	am62->wakeup_stat = reg;
+	writel(reg, usbss + USBSS_PHY_CONFIG);
 
-	return 0;
+	/* Set mode valid */
+	reg = readl(usbss + USBSS_MODE_CONTROL);
+	reg |= USBSS_MODE_VALID;
+	writel(reg, usbss + USBSS_MODE_CONTROL);
 }
 
-static UNIVERSAL_DEV_PM_OPS(dwc3_ti_pm_ops, dwc3_ti_suspend_common,
-			    dwc3_ti_resume_common, NULL);
-
-#define DEV_PM_OPS	(&dwc3_ti_pm_ops)
-#else
-#define DEV_PM_OPS	NULL
-#endif /* CONFIG_PM */
-
-static const struct of_device_id dwc3_ti_of_match[] = {
-	{ .compatible = "ti,am62-usb"},
-	{},
+static const struct dwc3_glue_ops ti_am62_ops = {
+	.glue_configure = dwc3_ti_am62_glue_configure,
 };
-MODULE_DEVICE_TABLE(of, dwc3_ti_of_match);
 
-static struct platform_driver dwc3_ti_driver = {
-	.probe		= dwc3_ti_probe,
-	.remove		= dwc3_ti_remove,
-	.driver		= {
-		.name	= "dwc3-am62",
-		.pm	= DEV_PM_OPS,
-		.of_match_table = dwc3_ti_of_match,
-	},
+static const struct udevice_id dwc3_am62_match[] = {
+	{ .compatible = "ti,am62-usb", .data = (ulong)&ti_am62_ops },
+	{ /* sentinel */ }
 };
 
-module_platform_driver(dwc3_ti_driver);
-
-MODULE_ALIAS("platform:dwc3-am62");
-MODULE_AUTHOR("Aswath Govindraju <a-govindraju@ti.com>");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("DesignWare USB3 TI Glue Layer");
+U_BOOT_DRIVER(dwc3_am62_wrapper) = {
+	.name	= "dwc3-am62",
+	.id	= UCLASS_SIMPLE_BUS,
+	.of_match = dwc3_am62_match,
+	.bind = dwc3_glue_bind,
+	.probe = dwc3_glue_probe,
+	.remove = dwc3_glue_remove,
+	.plat_auto	= sizeof(struct dwc3_glue_data),
+};
-- 
2.53.0

