Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1695BC47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 14:58:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26CF187D6B;
	Wed, 31 Jan 2024 15:57:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KNRBeLpk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDA3387BE8; Wed, 31 Jan 2024 15:57:38 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58C6D87D5A
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 15:57:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33b0e5d1e89so81776f8f.0
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 06:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706713054; x=1707317854; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2XYp8YcM236D77cbSXRzdYqrbYkWijOkcl9vz2AuRC0=;
 b=KNRBeLpkZ+5NjIxHm64/FD5omNCeC6icYrcAhxpQw6byDblzJiBXVNmpZS2zCRKIYo
 /Dj92puXwcLj66N52paXNfFMtrFk9TsrrMTCLLw9SdqII+sK02Owj6CptzGXy5NGgcVu
 Znqxbkpvf4PhBVMmopRAFLkW6CQfaF0iRdx3pZDDxW3QlxhqKv3C5boAme6aRsT/EmX3
 0i24j2k2WEOwXbhCv4/cowz7WUm+8jkktgxmfwAjQKHsnup8iq6S4LKwabkJk4p0yAOJ
 5jBuRF3quIIHnK3owYvTKoHGx7/38KEFoHFgixWBrilY6VMubcom4MTuW/kYEAdHKGv1
 BHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706713054; x=1707317854;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2XYp8YcM236D77cbSXRzdYqrbYkWijOkcl9vz2AuRC0=;
 b=Z1h1uuhQH60kJHfmaw0x2Pv1b/MKgVb9DTxlSp9lq7m6ETmtl/ed7bzbMasE2o4juC
 o+JSH1RXTtfh7RYj6tP4oHlLhLLRLdL9/8E3SOKWynaCDsonfwMAnKajyPLcwe6lwlPN
 j5CpE3XBzhYDXQbrTud7rT46jpyF/xKycNl9JwFMjCaMi5Ycw4OnYTpHPDlPRXUFwv51
 r5jPV/o/ZgY2xL6TPecjdZIA0bYc91q4OSWN+0qh0MYW0q0hyvgf8NZN0NqyXGyt994t
 TZv4Fl0+HNs5wqHygwuBMiMP91qOrvsOcwDxR2Pt8i7zvRwLHbRguhXwFPZvTujafdDS
 IqGw==
X-Gm-Message-State: AOJu0YzHJgbbR4buXeO399NqkxfRHYPUsDmlMHy0AkaZa7uBKW5javPo
 eKcWAa2YBBKrlLYCsNLooYgwJw+K27Q8oOpJVAlZA2DJtEfTXkKK14csfwsaItU=
X-Google-Smtp-Source: AGHT+IH1noD95DSl4RoEb/3OB9OnaZrSWTC7pU7U3i4OrsaemK8bfL8YisQ+Rfx56N9VvFam4Cz+yQ==
X-Received: by 2002:adf:ef0f:0:b0:33a:ff6f:738b with SMTP id
 e15-20020adfef0f000000b0033aff6f738bmr1549739wro.0.1706713053691; 
 Wed, 31 Jan 2024 06:57:33 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 a15-20020a056000100f00b0033aee3bfac5sm7841912wrx.16.2024.01.31.06.57.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 06:57:33 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 31 Jan 2024 14:57:28 +0000
Subject: [PATCH 3/5] usb: gadget: CDC ACM: call usb_gadget_initialize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-b4-qcom-usb-v1-3-6438b2a2285e@linaro.org>
References: <20240131-b4-qcom-usb-v1-0-6438b2a2285e@linaro.org>
In-Reply-To: <20240131-b4-qcom-usb-v1-0-6438b2a2285e@linaro.org>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=lS+Go8qhhghurSb2Tis7/B7zPWyIt5NhDkSRFTEidn0=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRd8bduLpGdsJWTyfJk7rF1a+1rf58IUY0PtfURE5Rfu
 sdiccyZjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRnFkMfwWn5FgVH2zl3yK2
 9L7z4sOfI4NqlAuUChRq3kzh7mHRyWJkaJie5x+pGSujueqA2cVFShcvLjOf6LJJgv/wVSHOtIZ
 eZQA=
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

To actually use the gadget the peripheral driver must be probed and we
must call g_dnl_clear_detach(). Otherwise acm_stdio_start() will always
fail to find a UDC on DT platforms.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/usb/gadget/f_acm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/gadget/f_acm.c b/drivers/usb/gadget/f_acm.c
index de42e0189e8d..ba216128ab27 100644
--- a/drivers/usb/gadget/f_acm.c
+++ b/drivers/usb/gadget/f_acm.c
@@ -623,12 +623,21 @@ static void acm_stdio_puts(struct stdio_dev *dev, const char *str)
 
 static int acm_stdio_start(struct stdio_dev *dev)
 {
+	struct udevice *udc;
 	int ret;
 
 	if (dev->priv) { /* function already exist */
 		return 0;
 	}
 
+	ret = udc_device_get_by_index(0, &udc);
+	if (ret) {
+		pr_err("USB init failed: %d\n", ret);
+		return ret;
+	}
+
+	g_dnl_clear_detach();
+
 	ret = g_dnl_register("usb_serial_acm");
 	if (ret)
 		return ret;

-- 
2.43.0

