Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B874AC47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 14:57:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDE4187C68;
	Wed, 31 Jan 2024 15:57:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ypYnAQ58";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6667187D82; Wed, 31 Jan 2024 15:57:36 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFFEC87BE5
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 15:57:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3392b045e0aso3567549f8f.2
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 06:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706713051; x=1707317851; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IPbDDHYcjJNAcqw6g2J5KQ2TZaMutWhSJMQMsAdfAa4=;
 b=ypYnAQ58bt+OlV23bKoFujklHpH0+ldSCstmtto47DfpEShHic7EYPgsKoWVp0oEjT
 KGqDl7oaBWlVjluGJydbzCSqpeEZ6VAJrVMbs5WbbLriTtgZ+X4+0rrHuwblfMKeS0GN
 0D5ttnEKSJrhSU2RmUF9xSqo51gm7HqghCRg0DGr96M3+N6GP17nYz6PPhTg/NmQO1om
 sg3Tf2rwnlEvuC7f8kyi7qPInu3pX9xDENcjJelpIRHxz8rH0owo06aBhvJAM8ozfBdB
 cwlfZoGt2gJYYwyb/INVSmb8IotShWY/EdZ9p/XbDtocRPMcle5Zwqq57KdaJL45gFay
 pLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706713051; x=1707317851;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IPbDDHYcjJNAcqw6g2J5KQ2TZaMutWhSJMQMsAdfAa4=;
 b=kOAujxsZY5UtQMQzlDp6RaIqDI7OyXLzaMYOeTwf4c3N0jifIne1WqmjnrZVXwuFhx
 wRUsScIKlhzcFHupx2D4/LZu1gZ0KrRkRNppITtZFTvypgl7Zot37h4t4eQ2ZJCWc4D3
 YVWEeE/nOQbctOnB+eeWgnQ6+UhXPBngbHwU3Be+lbHiU5Sy+dI7dpf6HC6z/KzFbbAu
 wafWXn3cqjOSP8j2oyGIIJVFH5tGNeZEOiouBWzcazm4qMprAbRiU50d9DAw6GRw2GOL
 piKqRtRUdl0QKCZ+2PNnyPRaw3oDx23jTvy16acFfwZ7H/3Y5ucrsX02pi8RY6Mgs9zo
 LIZg==
X-Gm-Message-State: AOJu0YxUK72t4ICUS8jJh2KLC6WAlTt4zlZ0g4pj6ImMCGwmIAVsk0Kp
 0AD/sPm7qRdl6pXjzgEQnppJrr81Pni7zFCjgvErtAvTWmQKEtSE9Ibai/IoEAA=
X-Google-Smtp-Source: AGHT+IGDlfLSqKraiUUI4pcPyEsP8bQnK23EVX/ZF3xqWbWjvi0YsnsbYzQafItltwQYUr9Xb9Z00w==
X-Received: by 2002:a5d:6204:0:b0:33a:e72c:c252 with SMTP id
 y4-20020a5d6204000000b0033ae72cc252mr1381739wru.52.1706713051219; 
 Wed, 31 Jan 2024 06:57:31 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 a15-20020a056000100f00b0033aee3bfac5sm7841912wrx.16.2024.01.31.06.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 06:57:30 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 0/5] Qualcomm DWC3 USB support
Date: Wed, 31 Jan 2024 14:57:25 +0000
Message-Id: <20240131-b4-qcom-usb-v1-0-6438b2a2285e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANVfumUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQ2ND3SQT3cLk/Fzd0uIkXUNLE+NUczMjI8MkYyWgjoKi1LTMCrBp0bG
 1tQAt1nqrXQAAAA==
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1472;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=kkglHhfh923cprcpP2VfiJ09wMVH+7WPGrBbY18ROeU=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRd8Td/nlqgOv/tPOYDHxMqFy1Yt2S/kcv6TU/UrGdOM
 jvoZBv1oqOUhUGQg0FWTJFF/MQyy6a1l+01ti+4ADOHlQlkCAMXpwBM5OcNht8sWxdWsCkUrGV9
 z7fyZrHYynwtxneT1jyp4n15ympHmWgkI0NXysZFTZU7kypiN3s61arbRbXvXuC9X4dFqyzUp87
 +mB8A
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

This series enables support for Qualcomm platforms in the DWC3 driver,
adds support for arbitrary sector sizes to the USB mass storage gadget,
and fixes an issue with the CDC ACM driver where it wouldn't initialise
the USB device.

Additionally, it fixes a syntax bug in the Qualcomm SMMU driver, and
makes USB_DWC3_GADGET select DM_USB_GADGET to fix compilation with
gadget mode.

This is part of a larger series enabling DWC3 USB support on Qualcomm
platforms, a feature branch with all patches can be found at [1].

[1]: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/tree/b4/dwc3-qcom

---
Caleb Connolly (5):
      usb: dwc3-generic: implement Qualcomm wrapper
      usb: dwc3: select DM_USB_GADGET
      usb: gadget: CDC ACM: call usb_gadget_initialize
      usb: gadget: UMS: support multiple sector sizes
      iommu: qcom-smmu: fix debugging

 cmd/usb_mass_storage.c              |   4 --
 drivers/iommu/qcom-hyp-smmu.c       |   2 +-
 drivers/usb/dwc3/Kconfig            |   1 +
 drivers/usb/dwc3/dwc3-generic.c     |  99 ++++++++++++++++++++++++++++++++++-
 drivers/usb/gadget/f_acm.c          |   9 ++++
 drivers/usb/gadget/f_mass_storage.c | 101 ++++++++++++++++++++----------------
 drivers/usb/gadget/storage_common.c |  12 +++--
 include/usb_mass_storage.h          |   1 -
 8 files changed, 174 insertions(+), 55 deletions(-)
---
base-commit: 16d331e8f1581de1ac6283365774a57dc1403cbd

// Caleb (they/them)

