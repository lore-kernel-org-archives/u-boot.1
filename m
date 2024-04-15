Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 561F9C00A94
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 11:57:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE6C788137;
	Mon, 15 Apr 2024 13:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="ojYJh2r3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F0CC8814B; Mon, 15 Apr 2024 13:57:34 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51A7F878ED
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 13:57:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-518f8a69f82so590377e87.2
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 04:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1713182251; x=1713787051; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/mHpheqTSNTzoRplCg9ahcCFu7L7Gj+Yqe0yjTQbKrE=;
 b=ojYJh2r34IIIb5cKznGpc1zUpa5C2aETKBHRBla/6pof0kYX+NEs5i60jbKwSpDi9g
 caAR5NMiD/r4cLegY9W2Ua8MFWxzS20vFmN8fbK+RydyDsSQ0dPquwUtnD/15aScHoOJ
 0Va53KI4R7hZ4QEZdHQ4JjE3p4FTpoOHH1LD0xSbnqflMV75J1vWFoAgQnjxLMsLWCWR
 ex7gUmjS/a3HovpKBbhjA870sbTlSpOBeawSVX3l93uWAa8RhlZCCRJPcE1YbNwHbFIc
 2GpPnfF1J+d/1i8nVlvhED3CM6XVtgLzQgh9pjvTFWUmS4I91RkYDabR4hJ8TXOMvbto
 2oTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713182251; x=1713787051;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/mHpheqTSNTzoRplCg9ahcCFu7L7Gj+Yqe0yjTQbKrE=;
 b=XKx6OYiKXcLLhChFeEB4kBIx74xjdn8IDnCgetuDZDEBGe4mOLbzf6yUxttSPu9kU7
 JnIaeYClKA8/1PG/LuwYvKr6LAvWmfJywFHuuuzciw4OX1M5AguLAi/HCTbZNQLf4xW6
 qK4b5N1BGP2hdDByvcvl+oy84+jKaJaKMNAe6A2DnDkcIBKhKYmwTmEP+rESQtghb+l6
 h8ZvoS5cDU94pZLqcqUABEnUDn+5qc2a1qRViSAnffHS80+W9BrHrf1s4k4gqXMZpKei
 e/+MyLdKdFx5SDcNiMcA2P2ol5h3Eb6SMbIjOe/SZiKH8adfpIAhfNOy2TGY9JZE4F3o
 JX5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6cZhkpiYgBULlgiwyN2NqiuCS82hXJkDRIbrjzw20BdcHM2GsTTxhLO2qmbL9F1BybvaPbYzBQBOCjvwxy2yB7GZg3Q==
X-Gm-Message-State: AOJu0YwN9C5e1c+8CMuQz6/kWvCGkFNn1xsXke4OqrxRlRpXE8ZKRYg5
 MbxXNOewLs7Akke/BYzSR29s1mHR8/gnK5CuEYtallaiElnQbPPRvnzlvbprPXvcbr6x7EqDy/Q
 H
X-Google-Smtp-Source: AGHT+IGXSM9CtE++O52rCcl7CoTbyEsLixCjaHbm8zRV90AQ8QD+JsXelLGm9UCaShCDSuF5+fFHoQ==
X-Received: by 2002:a05:6512:158b:b0:516:c763:b4f5 with SMTP id
 bp11-20020a056512158b00b00516c763b4f5mr8264699lfb.3.1713182251467; 
 Mon, 15 Apr 2024 04:57:31 -0700 (PDT)
Received: from fedora.. (cpe-109-60-83-25.zg3.cable.xnet.hr. [109.60.83.25])
 by smtp.googlemail.com with ESMTPSA id
 j1-20020a5d4641000000b00343e3023fbasm11785051wrs.34.2024.04.15.04.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 04:57:31 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: marex@denx.de, trini@konsulko.com, jonas@kwiboo.se,
 kever.yang@rock-chips.com, jagan@amarulasolutions.com,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, sjg@chromium.org,
 peter@korsgaard.com, u-boot@lists.denx.de
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2] usb: dwc3-generic: fix support without DM_REGULATOR
Date: Mon, 15 Apr 2024 13:56:55 +0200
Message-ID: <20240415115728.448176-1-robert.marko@sartura.hr>
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

Recent addition of vbus-supply support has broke platform which dont use
controllable regulators for USB.

Issue is that even withou DM_REGULATOR being enabled regulator related
functions will still build as there is a stub in regulator.h but they will
simply return -ENOSYS which will then make dwc3_generic_host_probe()
return the same error thus breaking probe.

So, check whether return code is -ENOSYS before erroring out.

Fixes: de451d5d5b6f ("usb: dwc3-generic: support external vbus regulator")
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v2:
* Drop #ifdefs and check for -ENOSYS that regulator stub returns

 drivers/usb/dwc3/dwc3-generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 7a00529a2a..df0b0b8c02 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -248,7 +248,7 @@ static int dwc3_generic_host_probe(struct udevice *dev)
 
 	/* Only returns an error if regulator is valid and failed to enable due to a driver issue */
 	rc = regulator_set_enable_if_allowed(priv->vbus_supply, true);
-	if (rc)
+	if (rc && rc != -ENOSYS)
 		return rc;
 
 	hccr = (struct xhci_hccr *)priv->gen_priv.base;
-- 
2.44.0

