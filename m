Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C91C54E67
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 15:06:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E40F87FFB;
	Fri, 15 Mar 2024 16:06:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gOxeLDR3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70E6488016; Fri, 15 Mar 2024 16:06:12 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0426487FD2
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 16:06:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-513d3746950so2286677e87.1
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 08:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710515166; x=1711119966; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=A7WqoD1LRNO9pokbdHC2hoq/L6o7EtSXZ/wRfMjSr/Y=;
 b=gOxeLDR3m1qT60Jre50Kj72sqT88hti7Rg/SEppNxenUpR0y26IOYJBaj2yufXFEVq
 Nm9BM/+ducdscbSgadHivSPcc0zguqI0tKSS1IvuURTWUKsEITLLMtbAxsSf7IgT/RLQ
 e0TpXZmqXBSY/6J0H+YKi7eYwofj+CE4cG6mztwySYhskPeO8y4UQRr0JgX8iTq4JO6b
 VOHerUhicldL1YQhpRLnkJVfWL8+Cf8Q3/YeLq4pRZ0K0tW4SG3KkvpImDMbRxaE42AB
 TGDFJS+LE7YFoFGarxKKnqlEdZgjNl3q//yzByULCa4GBJrb6+zuxAwHM2l8FRfEcGh2
 1bKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710515166; x=1711119966;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A7WqoD1LRNO9pokbdHC2hoq/L6o7EtSXZ/wRfMjSr/Y=;
 b=AswLz4iqWOf4Yf+vj7+PjdMtfFZYU0qZd7YZQb9aLKpfx7C6r/fOXus3xPUXVXuMEy
 eOSjWG6n8TWtJvaQ+Wsr+fXMrHgsy9Q7TgEw3hZxkEYp9GLcEgMqegnN9j2OhwqJRF+t
 YeeiuVT2IZH/e/IvlCLbImQTC6KYSkgktWiAN53QEnJRvSCRNYVHWn5CWEOM+QbrKgCb
 8V64yYTJF5Ou/eYUFQNojiMRNyc/fe66B2I/F5HxFI/ELV2ZuhXs4yWC41xmz5+CRGs5
 l6/BxsSukf/va9SLCI5rgY5IcBjlCPw8w/TaBG79NYwivx4VgIwBDlo62leSFgIlEuhC
 mrQQ==
X-Gm-Message-State: AOJu0YxoAAT6UPfPIM6Ktx5AvFZquWzIOTrZRgVYyAb4pjsLdxxRyoCg
 lVL1LzQoXB2k0jz9+wTbPygkiIu5rS1z7gOu24z4qiKiA5Its4LCQiZtRuFmgLI=
X-Google-Smtp-Source: AGHT+IG6r5JiIZnwPcZKAXUbawuiwMCTx+GgywlczKNWs99GmE8pi7OrcjHUDilLTOcJursF3qliUQ==
X-Received: by 2002:a19:2d1d:0:b0:513:9da7:3793 with SMTP id
 k29-20020a192d1d000000b005139da73793mr2661662lfj.16.1710515166188; 
 Fri, 15 Mar 2024 08:06:06 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 jg28-20020a05600ca01c00b0041401fbe446sm1939502wmb.11.2024.03.15.08.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 08:06:05 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v2 0/5] Qualcomm DWC3 USB support
Date: Fri, 15 Mar 2024 15:05:59 +0000
Message-Id: <20240315-b4-qcom-usb-v2-0-5467ec27cb26@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANdj9GUC/23MQQ6CMBCF4auQWTumnVZEV97DsGhxhEm0xVaJh
 nB3K2uX/0veN0PmJJzhWM2QeJIsMZSgTQXd4ELPKJfSQIqs0kajt/jo4h1f2aM+WMP7mkh7A+U
 xJr7Ke9XObelB8jOmz4pP+rf+dyaNCmtrGk+OqNnx6SbBpbiNqYd2WZYvxrQOqKcAAAA=
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1700;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=QcvxIX+4K1T904ZWkZo1pfliNgHnal9W29xzqyh8kG8=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQvyXcyXYM33f43K+rLY7+1meZ8745vnFQm+Opnz4k9r
 l+zP67/2FHKwiDIwSArpsgifmKZZdPay/Ya2xdcgJnDygQyhIGLUwAmErmP4X/xiaL+t7vCd7/2
 +tlSPnuh6qr3RvWXLuQV7y2+lHQ22diQ4X/ZxPNSelPfLFhgd+Tn/YX2utOFJ0uLf108J4O39va
 iyU0bAA==
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

[1]: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/tree/b4/qcom-livetree

---
Changes in v2:
- Drop custom set/clrbits implementation in qcom dwc3 glue.
- Additional minor cleanup based on Marek's comments.
- Link to v1: https://lore.kernel.org/r/20240131-b4-qcom-usb-v1-0-6438b2a2285e@linaro.org

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
 drivers/usb/dwc3/dwc3-generic.c     |  81 ++++++++++++++++++++++++++++-
 drivers/usb/gadget/f_acm.c          |   9 ++++
 drivers/usb/gadget/f_mass_storage.c | 101 ++++++++++++++++++++----------------
 drivers/usb/gadget/storage_common.c |  12 +++--
 include/usb_mass_storage.h          |   1 -
 8 files changed, 156 insertions(+), 55 deletions(-)
---
base-commit: e03a71b2cefd86ba58df166d4ea820a215ebb655

// Caleb (they/them)

