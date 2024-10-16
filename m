Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF583D1AD2A
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 08:27:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 118D888E8C;
	Wed, 16 Oct 2024 10:27:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IctXp8kP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2BE188E89; Wed, 16 Oct 2024 10:27:01 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1F5688FD8
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 10:26:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-430ee5c9570so74321055e9.3
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 01:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729067213; x=1729672013; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0V+XwMWYv6EHYUzL6XJWwKhzHmfdrdER+r8CtWT7gCo=;
 b=IctXp8kPYPYFyks8DjzLTQSLINuVEbLzWl0TEWO2H2VoYdxIYOEWSJcqEyyKu2HXWs
 onIwvVQaVmpypOHsCvXOH1+Cxl0spTSRLfwDcBpJ/i09t6YGEHuybIjJSlLumbZAtTcG
 F1flwozGFbH9HRd8sVeRVMUjJqcdPxID+cJMud6x9aIf1K/sXqT/NOmlLk1BDG7IsLpa
 h5oN2gEYjCrfBh6FbtQFntEofJV8EtKpWXd9YMWX/+J7eLmJDuNPBdInXyTVaChs8oag
 8ViOiv+KzfuFjvRByFCb7c6ChHt3Z5gCZ5VaMGG6ckv7SKlFPAfgQy5nR58/LEwFdTR8
 e4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729067213; x=1729672013;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0V+XwMWYv6EHYUzL6XJWwKhzHmfdrdER+r8CtWT7gCo=;
 b=MBVCSZQ3dlTv/LELceTgKrhZMnvtpkfIfh8f4Z2Vd59xDuzLTSH6yFXw7vr5aZmcn0
 kB6kUhHaEBlNFmMtyWNDdMilSelmwrAD+nggzVeaxVBh/UFvXamgWxZWeA4nnm9fFKMO
 ohkbuUVQmvYM9Ld2boUoASgd3I108fDRy5ANwsHFY7EfcwuCmTRB+BmqgzThGrlALGJK
 n8+O8ogO2RIXlqXN/xCc0BFqE8h0Eb0LIfupfcjoW4EdGwMNZTa0eRZlAKeHw9yIX7Ta
 1C523MDwRGfdHyib+XbP0aP08T8tRto2uWHhYx/SJNykkbobARm6gg336Tw9pJY5g/ov
 qkNg==
X-Gm-Message-State: AOJu0YxjVzMUSnvTayJWtnTFJjvBS9iDtst/Lk1rzehsgn/DoSmP+B9N
 6bdTn+/x7hLR90c+MabqecQHkvxVXGJTDYmkGAbNrdzI+6q0REXrjvPcFwlytzg=
X-Google-Smtp-Source: AGHT+IHHfJ/Cxv4peSExS3Ju+WCVtHMg/xX6a+LXbWgXtX429H/6aaR5UIYGlEeKyfqXNtysVsIryw==
X-Received: by 2002:a05:600c:4750:b0:42c:a387:6a6f with SMTP id
 5b1f17b1804b1-431255e1fc8mr144064045e9.20.1729067213057; 
 Wed, 16 Oct 2024 01:26:53 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f5698a3sm42513235e9.13.2024.10.16.01.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 01:26:52 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 16 Oct 2024 10:26:49 +0200
Subject: [PATCH] usb: dwc3-generic: use DR_MODE_OTG when dr_mode isn't
 specified
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-topic-usb-dwc3-dr-mode-otg-v1-1-4fda56072723@linaro.org>
X-B4-Tracking: v=1; b=H4sIAMh4D2cC/x3MSw5AMBAA0KvIrE0yRfyuIha0g1lQaeuTiLtrL
 N/mPeDZCXtokwccn+LFbhEqTUAvwzYziomGjLJCkSox2F00Hn5Ec+kcjcPVGkYbZqxr1jlVTE1
 FEIPd8ST3n3f9+37B83wMbAAAAA==
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1899;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=J/6r7+tonmNhhMQifuqRUIu4HSILZginKnzO/Rg/ws8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnD3jLeTFf4UfrviWUSGONuIKIywexwWbAATx3YitG
 4KSbuxiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZw94ywAKCRB33NvayMhJ0U4fD/
 wJmh4SYqRvWxI1nnYrOrwiZFd2AVkHcjqN8EPIaXkpLWRHu2SE0eqBk1hVVx6J6DQ72Gt5ARLRYCKe
 CjdT66pV8/zQYMaloy/qGriaShevZ2zFrt3Zr6IDr2XrT0kGWEk2GIw7xnzylDMwk/edhCayTwpoUS
 /+0375ZAfADbFjbG4EyuZaR/zUECCaR2JZ0SJHLOedrqfHiQhNTx245syuT6FkKw2A4K4tTEE3f8MF
 c7Pvscgn4uDw7UFMgdcyYLyeukqZ/PBhZGdRarUN/7SHnSMznt/hgRHX4DwNkx7/EPsrdH+UvF/3ii
 f41nWf1ug5oSEeCG8tww4XV/bnf3hvEUGpvILw7TVzFM1fZ5s5A9QjVQTLWadjE5doHnueyt/KYtCW
 8GArGPUBcM7fzzJjrS6AOCYpoM42coStu3I2B78gU7paTMJZary4hCPzYa1aCRKnuJjTqjlyovFSHw
 y9n+VJtMWZQR9lmQa27QCzB1ViBqusxMA1FednxmO/3zRuQ7oad1VifVKLL0etWEP4oL+lWQZP3EIv
 niR342SdBXYbcJnsLL1B8dxspuJBFTWLoCCRvfRn7k8Qa3BVUQnihr74WS2c5iXf9XElDDuVEMAPTd
 ZpAC5m1ezFPclDF2bXoP/diPxvIvcBtBp1Nv2uJKIInQp8r4M6rJCXx2jslQ==
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

[1] https://www.kernel.org/doc/Documentation/devicetree/bindings/usb/usb-drd.yaml

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/usb/dwc3/dwc3-generic.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 2ab41cbae45..d62d687ece3 100644
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

