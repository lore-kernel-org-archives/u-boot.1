Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2127FCD37AA
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 22:06:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45D2D84BE5;
	Fri,  8 May 2026 00:06:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ivZRsQe3";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CHQBN33H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD72984C0C; Fri,  8 May 2026 00:06:01 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E505C84B86
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 00:05:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gBRCW3B6zz9tmM;
 Fri,  8 May 2026 00:05:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778191559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M+JExzr3cAqfpPxah09nsnaNoydq8snY/OKUigSpCl0=;
 b=ivZRsQe3dNYa9CyrJoYJfUpNtJT/sK29j0/0V/CL2Oe4sKjYyARYsd2eqS973qAS7VnjRA
 Qgo8Iqk8zUbA4XzQRz3v3gzJXO+EHioFYBRC0PesihpewtkRFTwANfpT1ebIouvRkDH6LQ
 zL0wEOY3wwUQihNUAJ0KqCejSU4HlJ96RxFsDBJKVFQenYNxF6vpUqW3C3CBw10h667eoj
 0IrD7WHhN9IxygDCzJrlw+UJsAe93NZnvzXvzZ//m7JP4Ovvxy4gKf03RTSwm54D5WMPuw
 UvYg6JgYx6fyj9opubOJcFrvTbQair9GoBa52pYSdCLwRzSHysFcQqUDf7Kk0Q==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=CHQBN33H;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778191557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M+JExzr3cAqfpPxah09nsnaNoydq8snY/OKUigSpCl0=;
 b=CHQBN33Hcaiv3VyX5EHbdvBfICA2kZ+5QgjAsgs7kgAApf2aAO7ttY/0ZElpI7CD+K9YkW
 aGy/mRg2i3RoL502xKqUCusqOnPlstsF5AUpMgumitjBJAxkgE/S4N9faNpC1ktRf2j4V+
 i1UdCMrziMrr9fgqFlWu9wJbLrw4i4nlc0BAZmg4lSF79HARHRDeqIAF1QutdhuUBLRKrc
 lrhlkgDRZfjRgPbDRUJzZ10TXy3GhrR3F5RzB1QQsjEXi7m7YqGkaBy0+vp98Takt4FAsJ
 MJuAtCk6WKpD2pkr8avFcy2+P5vvIL+yfJBoDCznrlBeO8famlXqn6dhTVx+bw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 David Wronek <david.wronek@mainlining.org>,
 Jens Reidel <adrian@mainlining.org>, Luca Weiss <luca.weiss@fairphone.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io
Subject: [PATCH 2/2] gpio: qcom: Staticize and constify driver ops
Date: Fri,  8 May 2026 00:05:32 +0200
Message-ID: <20260507220549.209113-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507220549.209113-1-marek.vasut+renesas@mailbox.org>
References: <20260507220549.209113-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 8o8zescokd8y4fg77cesh68yiagh3o9e
X-MBO-RS-ID: e902b43615639e26b6e
X-Rspamd-Queue-Id: 4gBRCW3B6zz9tmM
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

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: David Wronek <david.wronek@mainlining.org>
Cc: Jens Reidel <adrian@mainlining.org>
Cc: Luca Weiss <luca.weiss@fairphone.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rui Miguel Silva <rui.silva@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io
Cc: u-boot@lists.denx.de
---
 drivers/gpio/qcom_spmi_gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/qcom_spmi_gpio.c b/drivers/gpio/qcom_spmi_gpio.c
index 77a69140213..ae75a4e151d 100644
--- a/drivers/gpio/qcom_spmi_gpio.c
+++ b/drivers/gpio/qcom_spmi_gpio.c
@@ -1020,7 +1020,7 @@ static int qcom_spmi_pmic_pinctrl_pinmux_set_mux(struct udevice *dev, unsigned i
 	return spmi_pmic_gpio_write(plat, pad, PMIC_GPIO_REG_EN_CTL, val);
 }
 
-struct pinctrl_ops qcom_spmi_pmic_pinctrl_ops = {
+static const struct pinctrl_ops qcom_spmi_pmic_pinctrl_ops = {
 	.get_pins_count = qcom_spmi_pmic_pinctrl_get_pins_count,
 	.get_pin_name = qcom_spmi_pmic_pinctrl_get_pin_name,
 	.set_state = pinctrl_generic_set_state,
-- 
2.53.0

