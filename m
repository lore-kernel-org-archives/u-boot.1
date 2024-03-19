Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0EBAC54E60
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 12:15:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37F3D8800F;
	Tue, 19 Mar 2024 13:14:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zHf2M/Qa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E91C287FFA; Tue, 19 Mar 2024 13:14:47 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 288BE87F6F
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 13:14:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33ff53528ceso1791121f8f.0
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 05:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710850483; x=1711455283; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=U6Ao/BrHGxpD1C9cPv4fRTuqD3AMDzioaQtxFwiQPrk=;
 b=zHf2M/QaINfBAmxJHqdrJXbgAuXxplFARvQZSiGk70sZSCHpokFtdghTo0dWaxaWuB
 qkNgpAYYGIXkIitVBSvXKLMDHqSJyE7d+lEjDJQ/GCDyRJ+ZQK+m3OOPEFUcHs0YlXfT
 sIXK5xLBbDrtPDpFeUJkMLtsTnbFuhvCgco5zUeqdQFyUdt9kyOFjdEE/sYhkzF24Pmg
 xqbyLt+IYLOPQw3ovwtupFG7iMJ1c6uZAzMqLcn5SRxC9mU3PlraXjgwn50hMZz5HvaG
 5+dmQL5YxnDw8d+ukkiKgcLs+wfGt0mYd2KMN8Dxu/4PDZrAoZ6TwbqkeWPwGAN5Koze
 Ujyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710850483; x=1711455283;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U6Ao/BrHGxpD1C9cPv4fRTuqD3AMDzioaQtxFwiQPrk=;
 b=X/5SCE+YKJOirNwA3/f09fx9quZW+d6lYGU9TacXX5f8FwqAQT7VQF729Y8CULa+iv
 +k2VOMt6XbKvIJI1Br6UCPoDfs/GRzahk4UPSd7hbzCFyVnn5WSQMvfXcU75gvzjxs+c
 4QqYVKAVzOgRjmCHrpf9nCpCLIZvRiNBV9vYhp+/40sF2Cmv0PyDkOTLrgFbucu0d2FV
 CVr1bwqfSjt3Vx9ecTidOsTNLkK9k6toPKhI+k/I1zvSJJdc0SMpjoxqXrL5EfZFGQPJ
 K5r9oDIxlPUDGmTju8LRp0Ch7KkxhaupRVGE4+ueudWTVCt9Tdp4tWs3nnJrsDvGHh7S
 +MTA==
X-Gm-Message-State: AOJu0Yyt+GUNWA+RqjiEQ0WfFSiEOM2jdmXcofPpWJ8OvjoSDH3MLtTn
 70UMCp6D62QocwAuhll1O6qVX5dcuxUiMjt4i/GQi1GVS6GZ+rT8RuAer1Ovh0E=
X-Google-Smtp-Source: AGHT+IFCF4DBj0KL2wg6nnzPjmSH92GEm6khEZIT08AtG0bKaF5wGD1Pi+nvwVazyXFDsKLiqnYfPA==
X-Received: by 2002:a5d:6582:0:b0:33e:7c9a:9368 with SMTP id
 q2-20020a5d6582000000b0033e7c9a9368mr9591324wru.63.1710850483658; 
 Tue, 19 Mar 2024 05:14:43 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 u8-20020a5d4688000000b0033e3c4e600asm12345792wrq.7.2024.03.19.05.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 05:14:42 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Mar 2024 12:14:26 +0000
Subject: [PATCH v3 3/5] usb: gadget: CDC ACM: call usb_gadget_initialize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-b4-qcom-usb-v3-3-09ba1f86d259@linaro.org>
References: <20240319-b4-qcom-usb-v3-0-09ba1f86d259@linaro.org>
In-Reply-To: <20240319-b4-qcom-usb-v3-0-09ba1f86d259@linaro.org>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1128;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=zOzCrBy5uJTh6xPbLEJbYeWWpo5eW586HYEeAes6w7A=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSfjevPVn+P4tgmbj/nndu20tmxdQmz7wivffJtrjarx
 /xtDSEyHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAi6Z8Y/kf8O3Dwxdr4bbUd
 kl4HBM72v0+dlak0Z8sjniVW6b1LeYIZ/orp/SnjtZh8Q9xlxa2zi1UYl25dXOnw8iD357ktJ2o
 /NqwDAA==
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

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/usb/gadget/f_acm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/gadget/f_acm.c b/drivers/usb/gadget/f_acm.c
index de42e0189e8d..ba216128ab27 100644
--- a/drivers/usb/gadget/f_acm.c
+++ b/drivers/usb/gadget/f_acm.c
@@ -622,14 +622,23 @@ static void acm_stdio_puts(struct stdio_dev *dev, const char *str)
 }
 
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
2.44.0

