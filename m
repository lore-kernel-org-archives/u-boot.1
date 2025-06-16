Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB9EC71136
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 09:45:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0EE982CB6;
	Mon, 16 Jun 2025 11:44:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i80FRJXI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D2DF82C8D; Mon, 16 Jun 2025 11:44:57 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25CC880C93
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 11:44:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-450cfb790f7so34245685e9.0
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 02:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750067094; x=1750671894; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4/ChcbGDY2c0IGn7C4U/oe3atwht945xOB+uopiC8Q8=;
 b=i80FRJXI7pZg4XVcodIGnhw7O1Lk0JRO42DjIZkYNY4rQqI0EjmLyfX3ZUaoXJWhOV
 jUtQxeInAnbLVDcWl7Nj+2GcFF3gxBPqTBW8R4fqExLvzaqN585ELZz3cs0/qQ51C0Iv
 YXovhTwYb3zwJ9PyZqZB0aGWbx5HFwpmAZ1Nsdu5ddP0EQzRpvM9oAcOowWhfLCMt1yo
 BjNZP87jUF0lOPz15ot0t+3AcLYeMB9B743jG+EkMmIFI5mbO2lQNIy+jtw79xku3h0z
 0jahVdCvDD2Tk9FDR17z8iTu/gS/XeMbQuYg8xQIflZuU9kFUtMlCbQDwJbktWl2kl7O
 +Xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750067094; x=1750671894;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4/ChcbGDY2c0IGn7C4U/oe3atwht945xOB+uopiC8Q8=;
 b=KfCAc8QuPxQA+3adumEe4S2czR/BXdEWtNfoFInuIm88yNQM01GxpXMXQ2Vp3x521/
 zIxcv8NHvb4bFaRx5DqYAl1FvBWRE2NAiMVCznt/dKjVmTAduaUMQQzsKNH6fcmIVe5X
 jt+eOjVjuVosQU+AHvQWilVEHnj6FnT8CBj0nmIEsuNMozdhwduWXVg6YJMajuS4kWDY
 cja2bq0KlrhvboWSq/WkyJrtZM2sO6Kyu0Y+kxIcLJQJPWVDe6N2RstNYzh1uYCK+sNq
 dnZDkI9k9oBGes9F8oBiPBo4WJ5m41m7H6RVrfevCSNJabM+BE0LHE8KQdrFM4DMwCYF
 nVGQ==
X-Gm-Message-State: AOJu0YwvukWp1XRi3lSPmzO7N4CymBm85mfx31ONzIpQQcg0F6F//oKB
 kSBtL2lx+iT6+rzjmsj0pLzD5LDB0KkxPUZRVVzH8oGhhCz3XHUh0tjI40Akw+yTOw0=
X-Gm-Gg: ASbGncsgBxS7BTxPjKckkQamE72MRphy4poZtcDJaH8uVdFnle7ohdy8SXGzUdAIVph
 vhbF+Q8zD3khmkIub+pZZsFtkS2XvkFgfiRO9uKaua3QajDwX963x+OQghTMVKDAhzYFb8mjdGW
 qqVjY5c6icACmMOjdKz/qVJVvGPaBOTkRVPLFzVnOBxvvzlVSJ6+SdYA5a53ikqXTM9z6gV/ISM
 pppizfLXcLgTnaXmCM2FrdFc6up8XTcF+MwLPjGen5/3smZyVFKTQ55HIu254G9zvtQnTNZwPcS
 15JqxanjKyZFYgrv9XAzyZBPXv/imk35jucgmWWa3/lhLEJlXWw0zcvxjbrsqANx88ForLDBDDV
 AN0jh
X-Google-Smtp-Source: AGHT+IEun86EAG5tnxLHRrmGa9Ld9896hSCLxATxTaZUxGpewgV2zjYql36CsLKbTvjdlCZG1RBHLQ==
X-Received: by 2002:a05:600c:3e18:b0:450:cfa7:5ea1 with SMTP id
 5b1f17b1804b1-4533caa629amr81678785e9.16.1750067094486; 
 Mon, 16 Jun 2025 02:44:54 -0700 (PDT)
Received: from toyger.localdomain ([213.240.182.76])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532de8c229sm139308105e9.6.2025.06.16.02.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 02:44:53 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 16 Jun 2025 11:44:46 +0200
Subject: [PATCH v4 4/9] i2c: geni: load firmware if required
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-geni-load-fw-v4-4-e7df44205505@linaro.org>
References: <20250616-geni-load-fw-v4-0-e7df44205505@linaro.org>
In-Reply-To: <20250616-geni-load-fw-v4-0-e7df44205505@linaro.org>
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1287;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=C9cV1XlqKOFnv1pfqDdwPR7Q+zPvojzlL4zUYBp01dw=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoT+eONolPQnkvkKBP1+BjJFSyJoL2Wgw76kjur
 O4vbPIfJvaJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaE/njgAKCRAFgzErGV9k
 tqg8D/9Vjg6MeV8qIGH9qdFnjeZrVYCPgGPJg50Xm1dGzUMIt0Ah5XgOwrc8Mm0pc62EKzyGeDk
 7uAUOcQk9N/WSDqG8OgHS3iDwDtFhcCqd1oa1DdWm1+7HhaDZjmYcJNzXO05gDYJwAJEXufgusn
 l8v4jH9CVdhsoszQSWXaEBVi2eyV/6hg4sNByM4m/+LJqILGxRbzByd+FP/zxpD8pM2L+HxvXp8
 qqD3u+3wd1UzfJi79EDtwm2vu+9e1ka92OKbDP0XH+ZIgZzLdnpaXF4YPtsvrshzX3UtizQdWNw
 CP+U+XQiK3oZOTHwTHxMoeaW7oHPaNN/u2N8NsMb8m6dnm6nkTMOax8cFF6uTcBM4KbgdbMsqMw
 XBvL6DRMHxg1aahdW8eiIoqh0StgzLU3Cyx9UW0f9tXfle1EANP6erG2kvi92M2GSs6lqxz/a0Z
 RjyZjjISYlKTj4ePgwV+iIKaZ3HDlXBWKwxDakGZcBywylN3JSI5yoiYtlhtTcBQkKnWpIpyRA7
 riQY5kemIvCWnWdgMDVO38V8NF2I7omcu3fte6aKhPLgjsYafNuKI21aGsj8XaEkfCZdCLHQ+jb
 SCpxOXAkjAJwlv/uF9GXJHGsDTt6pVB31PrjfbS0jqecT03vLuqnbIRLjCiwF+s6b6OKbDv/o3d
 DdbSoH9RLDT6nfw==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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

Load firmware for the peripheral if necessary.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/i2c/geni_i2c.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i2c/geni_i2c.c b/drivers/i2c/geni_i2c.c
index 4eb41ba852f7790ca646c8ba38f29fdb727fa804..d29e00fdf41df1d7a95d8d9b3b98f784f5b2a3e1 100644
--- a/drivers/i2c/geni_i2c.c
+++ b/drivers/i2c/geni_i2c.c
@@ -21,8 +21,9 @@
 #include <clk.h>
 #include <reset.h>
 #include <time.h>
 #include <soc/qcom/geni-se.h>
+#include <soc/qcom/qup-fw-load.h>
 
 #define SE_I2C_TX_TRANS_LEN		0x26c
 #define SE_I2C_RX_TRANS_LEN		0x270
 #define SE_I2C_SCL_COUNTERS		0x278
@@ -498,8 +499,15 @@ static int geni_i2c_probe(struct udevice *dev)
 	proto = readl(geni->base + GENI_FW_REVISION_RO);
 	proto &= FW_REV_PROTOCOL_MSK;
 	proto >>= FW_REV_PROTOCOL_SHFT;
 
+	if (proto == GENI_SE_INVALID_PROTO) {
+		qcom_geni_load_firmware(geni->base, dev);
+		proto = readl(geni->base + GENI_FW_REVISION_RO);
+		proto &= FW_REV_PROTOCOL_MSK;
+		proto >>= FW_REV_PROTOCOL_SHFT;
+	}
+
 	if (proto != GENI_SE_I2C) {
 		dev_err(dev, "Invalid proto %d\n", proto);
 		geni_i2c_disable_clocks(dev, geni);
 		return -ENXIO;

-- 
2.49.0

