Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEADC47DB3
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 14:57:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81B5287D07;
	Wed, 31 Jan 2024 15:57:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cwJVwG3M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D651087C09; Wed, 31 Jan 2024 15:57:36 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61F1087D1A
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 15:57:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33ae51f8111so2748080f8f.2
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 06:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706713053; x=1707317853; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bGNsezs2u9n1en3GSHy8xckGQLvUavYo9GOoiPo/ivg=;
 b=cwJVwG3M/kyOXcl9i4M4rPBjmUHGleEIGtKZOGnlgZ51yeUnKz+FmCWMaXe/rAnh3Q
 XZ0BvyWnIbE2Z3eCdCgWX5u3/jXu158Gs7M1thTgTaJdyQ4f1gW6HsRMjbcrawni+ikK
 3k+BpxARR+QjB9WkIPSipMXtC/BUIhC7kCeg1cMeQjxhN7HoDvX+0oDkP+bCrL34ZnHz
 YCLiAF6nE1O8CNxJpHkAO0xYQK8kjkIVnrs3QdHgAB+76ZLByjJW/bZBFwLT9Sobu6Kc
 mPjEeH1Ch1T2FsEKwzztkK5+80olMZnZW1Zd9jjTikNZy90yzz2dgQiWagVbDYZwouYh
 1MSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706713053; x=1707317853;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bGNsezs2u9n1en3GSHy8xckGQLvUavYo9GOoiPo/ivg=;
 b=pywoummurss+Y163OrjNexzEsrqigy/wdN+9GnHSvr1w7F2zTNRgZSOGXZTbPaQFff
 0DfDQZUnI146LgbRQbaAKBaC2rMQ2enHrQKKmP7brhqaAGvmI/WdP6lE0nxT1OYYlNfp
 InTbieB3wgogvX+V8+5XfKnqk8tnFl8/sI8UVlWaNBCDKTfx+WJnvlEJ7xWTCrOPmGcS
 Buzrwg6YT5WGtg3pPn3owkIxBfxL75Yjki/PDFq8Vaou7h8QJP2iyVpvSm6nsC/qS4nG
 EtGyWk3p6KH2VpaLQ0uCqdPDC93hvm9E1jCBYf1SpA617KdJvmUd22cePNZBvSOC4E1a
 986A==
X-Gm-Message-State: AOJu0YynGb56rJxqoGhUN04JG3asWvbwCZF7ROBYlXkJPdbLQlAUfEM+
 zWzgmbzsBuAbt0KG8HtUW0qEDk4IRjg0isNXVms/g5J1XUHIzahC9dAwbB8vEO4=
X-Google-Smtp-Source: AGHT+IH9V7oUpKecHccDAEU3GjlBct0ir3PWdWTeAw18V80J9F/IZnWtetHVN4yQthEyLSjdA/tB+w==
X-Received: by 2002:a5d:534e:0:b0:33a:e639:2da1 with SMTP id
 t14-20020a5d534e000000b0033ae6392da1mr1121144wrv.65.1706713052904; 
 Wed, 31 Jan 2024 06:57:32 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 a15-20020a056000100f00b0033aee3bfac5sm7841912wrx.16.2024.01.31.06.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 06:57:32 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 31 Jan 2024 14:57:27 +0000
Subject: [PATCH 2/5] usb: dwc3: select DM_USB_GADGET
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-b4-qcom-usb-v1-2-6438b2a2285e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=698;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=4Pp9MVWKCvGq8lILqjyqGwGLOpWOP7ls67K71LEQ3r8=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRd8bc8/JkkJdZaui+XeFWlxCopV7tUi8nD2uGb6saXv
 xTb7Dd1lLIwCHIwyIopsoifWGbZtPayvcb2BRdg5rAygQxh4OIUgIk4BTL8j12odH+69XM1AZX9
 f8pN7vFPeLrlUdv3wm8TPvTMnPBnGjvD//ScCR03/5jWLODWLqs+VqT+8XjHkvasu29VX834LmM
 SdxAA
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

DWC3 platforms depend on DM_USB_GADGET for gadget drivers to work,
otherwise compilation fails due to no implementation of
dm_usb_gadget_handle_interrupts().

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/usb/dwc3/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index c0c8c16fd9c2..8a70bc682322 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -11,6 +11,7 @@ config USB_DWC3_GADGET
 	bool "USB Gadget support for DWC3"
 	default y
 	depends on USB_GADGET
+	select DM_USB_GADGET
 	select USB_GADGET_DUALSPEED
 
 comment "Platform Glue Driver Support"

-- 
2.43.0

