Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A48DD30007
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 13:27:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBCCE88E33;
	Fri, 18 Oct 2024 15:27:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nlXGT4Ou";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44AC988E02; Fri, 18 Oct 2024 15:27:47 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5C8388E33
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 15:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4315abed18aso16493135e9.2
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 06:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729258064; x=1729862864; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7tTpLHx9hkVEejtoFK+BC/tc/7dG+oiFJGd81gtkN0k=;
 b=nlXGT4OuFcDtm7/ntRHO4bV1l5xXuNwe6Iv6skVeC9OxN6ztLm6+Oon37outzI1Dw3
 LDGrNYpiGlmH7dha1sZY97uKbXmQ085DJmYanmkw3H2+8+JCJ45UVjpEtep3kOZcXYXO
 fm8p4xnmo6tCdvEcNoZjwh1Q9q1z5vAYAGOz6UXf0sdZFFnPyyzCoV0368rtbJ739KM6
 wOpCA5t1mnuz+qQZ39GQzsUqF0/0pGnDG+aG9eoDgyFuWwzmuRT4YCeMX428XIMzef/I
 Q6DkXeew157js3s7uTjzbQSHTsZ/9cYqtU4DK2hjdMG3IoeFSfst+bdEv5XqxLMByaar
 DUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729258064; x=1729862864;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7tTpLHx9hkVEejtoFK+BC/tc/7dG+oiFJGd81gtkN0k=;
 b=Zlb7qJjsvJ+OSrWoLow/Wt1RX1F3c47t2cRVjnhAVGlV2sfxIao1p3rV3p23KqK9kW
 l5xcoChfIMIx6+K91s6mnsLE5B9mOYYlqkWo6Zwp3K+xy++yTYD1qa3yJqF8SkKGy0el
 RZkBCxZA9XkVjUdNYzWG2uYIhWezPrritGJYgzI9NLpQpwap/WhEKXPPiSsIcmcP6oC3
 ZZHjUBeNDvrtuVTTiTdBYNwg5Ihna1JSWw4C45KonUUsPOFx3sMSXeNaqwjNlUoWrJMc
 pA6Mc8O9cPriIOIe/eePrvsJwcnE2RdAxg3Qy+aS8bhb2pPyQuOmpetyxBqdGetWzsiC
 i8Zg==
X-Gm-Message-State: AOJu0Ywj1kSknJSdZiwmNEDxZ2pT5AuiwBaws20Zunt5wkjOy2cZdrHx
 vDSBNBBm0DdEPI4PaxkSOjjKGrv42OTS1ZrbWvYsM7oLnV/6+xRY8MD2gSJXiD8=
X-Google-Smtp-Source: AGHT+IFY4ecE/+t52u7xjhs53/fX8Mrjn+VqdiYG5v+Bjjx3XlbEWf8l1pRZjxufGWjnooVeBweDuQ==
X-Received: by 2002:a05:600c:5490:b0:431:5aea:95f with SMTP id
 5b1f17b1804b1-4316165a78cmr20596785e9.16.1729258064299; 
 Fri, 18 Oct 2024 06:27:44 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431606d5910sm27411735e9.43.2024.10.18.06.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 06:27:43 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 18 Oct 2024 15:27:42 +0200
Subject: [PATCH v2] usb: dwc3-generic: use DR_MODE_OTG when dr_mode isn't
 specified
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-topic-usb-dwc3-dr-mode-otg-v2-1-d3e98cf6ba48@linaro.org>
X-B4-Tracking: v=1; b=H4sIAE1iEmcC/43NQQ6CMBCF4auQrh3TFqTIynsYFtgOMIkyZIqoI
 dzdyglcfm/xv1VFFMKo6mxVggtF4jHBHjLlh3bsESgkK6ttYbQpYeaJPDzjDcLL5xAEHhwQeO6
 hqtDn2qE+O61SYBLs6L3Hr03yQHFm+exfi/mtf2UXAwaKLrSnUjvrbH6509gKH1l61Wzb9gX92
 0M0xQAAAA==
X-Change-ID: 20241016-topic-usb-dwc3-dr-mode-otg-88ec307e0970
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2470;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=vhOhHO0Fpm/KRPRF2TAVLNbEwJlbCev6dctlDMxBCQw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnEmJP6F6qTKOThQbzpzccuzc5loHkRAEf/kGf/Fmm
 oXxQTPCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZxJiTwAKCRB33NvayMhJ0d1EEA
 CShrefe3IePyvQJjlD12oJewZP6k9u9wdE0nshQ0T0xaKAMZs3iDYAAaJj1ph/L3f5VngRMb68qbJ+
 ZISno0yM6YB9X2PbqQ3Izp2yBBlfshioJN0xCifobvplIQn9t5ZGBkoL2tpSn9BjDbCb4zvxkAo1hV
 gyrpHcVx5CRIZSjo3g40Wki/PdxYOTxTbxb/2ACmPRhnbAbfXrdTIVWWJUcEwFrcOGMw+LYU35R67r
 dU2r4Ks/vk3KVZ4uVAEGvGWRm/A/Tyjwy3+KngRWKG0qk4CYb+OcD5tJ6of1pxx3FzhdjoEIP19vL8
 nACI2YDJeK6KBqTMg1eJp7VIsDvHgZRQikF7uO/eGsenc72g4mJh/broeNRtYvZdr6srocVrRLBl6W
 kUb0fzCjUKoBqKdtIyrQDebcjIrWnJRlk/210MqrvOPO4T5RxD6EHZGyllcrRaVXXtwvV3Ec3JLLbr
 qd0DZaMwvLcubroffOKc5U9pUmIEBFHRYF8z3mC79L0AJ7LVEke+xartgXdGPnPzTAEw8Zc2lXUlZq
 yQkLSBXLUAqVljo+ghxZ/YTzQZT7fJf4oQ+FYNfL0xvamz8m3SmKAIL/mnfT5KpuwG8DGgP97VeN5L
 dZ3GykRYHTuQpkP2RX05ICrUy7IzGKnDfMuW+15jzQx6wya7y79bgRK5lAfQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

The USB DRD bindingsa at [1] are clear, if not specified the dr_mode
property defaults to otg, and this is how Linux behaves.

A cleanup is ongoing on the Linux Device Trees to remove dr_mode when
set to "otg", so take this in account and do not fail anymore when
dr_mode isn't specified in the glue or dwc3 node.

On the software side, the Linux DWC3 driver behavior defaulting to
DR_MODE_OTG is present since v3.12-rc1 added in commit [2].

[1] https://www.kernel.org/doc/Documentation/devicetree/bindings/usb/usb-drd.yaml
[2] commit a45c82b84c844 ("usb: dwc3: adapt to use dr_mode device tree helper")
    https://github.com/torvalds/linux/commit/a45c82b84c844cd85b2ed1aa32596f1bffa32716

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- add ref to linux behaviour
- Link to v1: https://lore.kernel.org/r/20241016-topic-usb-dwc3-dr-mode-otg-v1-1-4fda56072723@linaro.org
---
 drivers/usb/dwc3/dwc3-generic.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 2ab41cbae45d78ad140d54e602150b6ddd0a3b99..d62d687ece36d70ccb0f7541eb51c6b7550d932d 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -183,10 +183,10 @@ static int dwc3_generic_of_to_plat(struct udevice *dev)
 		/* might be a leaf so check the parent for mode */
 		node = dev_ofnode(dev->parent);
 		plat->dr_mode = usb_get_dr_mode(node);
-		if (plat->dr_mode == USB_DR_MODE_UNKNOWN) {
-			pr_err("Invalid usb mode setup\n");
-			return -ENODEV;
-		}
+
+		/* If none of the nodes have dr_mode, bindings says default is OTG */
+		if (!plat->dr_mode)
+			plat->dr_mode = USB_DR_MODE_OTG;
 	}
 
 	return 0;
@@ -527,6 +527,10 @@ static int dwc3_glue_bind_common(struct udevice *parent, ofnode node)
 	if (!dr_mode)
 		dr_mode = usb_get_dr_mode(node);
 
+	/* If none of the nodes have dr_mode, bindings says default is OTG */
+	if (!dr_mode)
+		dr_mode = USB_DR_MODE_OTG;
+
 	if (CONFIG_IS_ENABLED(DM_USB_GADGET) &&
 	    (dr_mode == USB_DR_MODE_PERIPHERAL || dr_mode == USB_DR_MODE_OTG)) {
 		debug("%s: dr_mode: OTG or Peripheral\n", __func__);

---
base-commit: d5cab0d6adc26ec1bbd45c2fed101184d04454ae
change-id: 20241016-topic-usb-dwc3-dr-mode-otg-88ec307e0970

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

