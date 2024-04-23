Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26036C10F1A
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 14:16:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57F4888340;
	Tue, 23 Apr 2024 16:16:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VAzMHXVj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1CD388349; Tue, 23 Apr 2024 16:16:15 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D5BD88343
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 16:16:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2dd6c14d000so30614621fa.0
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 07:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713881771; x=1714486571; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LvRCGQEa9BDUvOSsZjW4mGOmFskJT5oXXUrF1mJaGmI=;
 b=VAzMHXVjTPF0WO91eKiLiOPPdyf22Dh0mVii3XoAmpv9pEh0ZCors3ab8Os5jVciaf
 57H3yWJCAekMcE2DNbXN5n0tM0bhI+cCPDIh47T7fbVHG0If02wowrR+hmrACr8bQmhM
 910sNsIvGhKdCyO9ZioHTj3jn5+RU5J8BrJzDZs9GHBAa417+s/OX4qrNgPmV9uLR2Nz
 Zdx0jnMTBru6rcP+Ie/o2DsmLV1lPzGNXPJ8N1fq59WPil9jFDmvrxSZcla5ZVNOtKPi
 Zc0+lwrhNxmmHhK6YJfdN7agbKYoh2hxbtEDXbG7u5i0QFcKtSeG/t1zRPDejGRSM9pu
 XvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713881771; x=1714486571;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LvRCGQEa9BDUvOSsZjW4mGOmFskJT5oXXUrF1mJaGmI=;
 b=hB0zzaw9zOSd6vKew0fjRxrJ12B3DvW0nr4y1vjjQo6N/eCcpfnFEOnH7DorRPllR+
 5wUhQWwydaoyq+C46E579Tp9pH8Sw04gp2l3XtW22wj+ApPN3JI5yQzSjstX/lYJ7jcf
 cP1VYIMghweLEtJg+tbhsxKAgy40q73GowM3tpkZO85tZnGrvyGfnJ2SYnThErAYl+fp
 Se0x1YqxthDTbT8sQUKngWnaOp555/jZm6t9VFtUGkdabFtxMapsud3p7fe3KRZU2VsY
 g0fYbDM5vcFe+PJMoHVr/cVahb4uW3bcyZrrgcHpmep3fDjJpoaj5Uv9GF18TigSCTBM
 aPMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFcm7OgdYVHpdSxetZOFRabzlAqVscm9f79uM/jhLZ3+uaO+lyZ7Ep1/hq7UhS214QgqSOiYu67vHMsSnOmo2XHoo3LA==
X-Gm-Message-State: AOJu0YylZc+RANtOgSh5OAcqQAPwW59g0QXxYnZQlCR6KdwqeYqQT6om
 DJ7VSV8++UmcM2XRq2w1EquEOfT1hzs1/FhzXFyBZK7QzYfIKYg6YKeYu5eXYDc=
X-Google-Smtp-Source: AGHT+IF4DJTWIPMQU6k1DPyOYiVC2FoocQr01EFEEvu7hMWyffoUOtKmsC+MnJnv4P3JUSTQgZEFdQ==
X-Received: by 2002:a05:651c:a12:b0:2de:2fc0:245a with SMTP id
 k18-20020a05651c0a1200b002de2fc0245amr1420647ljq.40.1713881771491; 
 Tue, 23 Apr 2024 07:16:11 -0700 (PDT)
Received: from cymric.caleb.rex.connolly.tech ([2a02:8109:aa0d:be00::1795])
 by smtp.gmail.com with ESMTPSA id
 p19-20020a05640210d300b00572033ec969sm2862261edu.60.2024.04.23.07.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 07:16:10 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Igor Prusov <ivprusov@salutedevices.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nishanth Menon <nm@ti.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Stefan Bosch <stefan_b@posteo.net>, Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: [PATCH v2] usb: dwc3: support USB 3.1 controllers
Date: Tue, 23 Apr 2024 16:15:06 +0200
Message-ID: <20240423141551.2410199-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.44.0
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

The revision is different for these, add the additional check as in
xhci-dwc3 core_init code.

Equivalent upstream Linux patch:
690fb3718a70 ("usb: dwc3: Support Synopsys USB 3.1 IP")

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Reviewed-by: Marek Vasut <marex@denx.de>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
Changes since v1:
* Reference Linux patch
* V1: https://lore.kernel.org/u-boot/20240411160527.835767-1-caleb.connolly@linaro.org
---
 drivers/usb/dwc3/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 96e850b7170f..db045f5822d4 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -594,9 +594,10 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	int			ret;
 
 	reg = dwc3_readl(dwc->regs, DWC3_GSNPSID);
 	/* This should read as U3 followed by revision number */
-	if ((reg & DWC3_GSNPSID_MASK) != 0x55330000) {
+	if ((reg & DWC3_GSNPSID_MASK) != 0x55330000 &&
+	    (reg & DWC3_GSNPSID_MASK) != 0x33310000) {
 		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
 		ret = -ENODEV;
 		goto err0;
 	}
-- 
2.44.0

