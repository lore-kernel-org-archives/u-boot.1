Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1300C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 12:15:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA16B88054;
	Tue, 19 Mar 2024 13:14:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="grl/6o7D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4239A87F88; Tue, 19 Mar 2024 13:14:46 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1240187F30
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 13:14:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-513e14b2bd9so3647513e87.2
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 05:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710850480; x=1711455280; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Fcua0COaOyaEXa82vmca6+M6HThzQ4crsNRQ548UZk0=;
 b=grl/6o7DMXHDDWnk3NeQhvWhewjh3fdVTbD1glQaEiIp6eqpnXEykKiOCwpGh8+jLe
 HZDkmF2wfpPGlAKsW71iwGRKgH0Bb8c1QwBVvb5zdUVz4iNmWKf0eqb+SuhL16CvWTqa
 iAM+9TtDqmlds9mPzIRbNwsC2TAgneDwDOOi6vUzwuv+lfRrLInzY9pC6V+bS3J4EvgB
 JYvPN5TQm7fo79zVjl2PLtZmHqoE77dK0PHaYYOZ04MQ2qBdxN51dKA+vP7SLXQ/bso2
 XGvpJrqYIqzNhVDWHCPDfPSeDwW4TbSqiHS7C+ijS2qM69DBaWQykF7Rrbd9JdRipFdq
 f3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710850480; x=1711455280;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fcua0COaOyaEXa82vmca6+M6HThzQ4crsNRQ548UZk0=;
 b=rgjzZZhRDKU7skV18+UUsqMuq0TkQhEpG2r4KVK6K7Vxrp/MmMzOF/24ockckhUFk9
 MzToby6gTnTw/IeP96do4bXW8QNLCQTUgZ8IRSwkH1alEfqZKMPB49Nzald1aKVMBRUA
 3hC1tQmkbEFlWAvgIBS87o2lV0sqO4/ivmmmqOCu7mS1WVDx+HG/XfkT8Sh7iX8uu9d4
 lQQ6sMVsEvxb1icppRzKSschXfoGXC+Zgo8wAq583H8fn7rA0J6bMNs7V/tBw/R2eSdS
 OUR2WuvfWKIAB0yN3Pk4r3lbarU4ff9vPXOFfmQNqUVQrzCTmi6l8ec2+Lqf0CsrsXI3
 srtQ==
X-Gm-Message-State: AOJu0Yzz53sT168bWjNSBprLQIB0FU4omtPOlHC+FLV8HtFrkE5N7tA5
 EXbEtswtpnp0E+u/DPPDQv1nXyAJ69UEVe/KcxIpJk4RSKfoIs4YNxGgQF/1TtTPGXZ2m1RoqAx
 U
X-Google-Smtp-Source: AGHT+IFVVpNevQTaR/35acablpCtpkJ3hsdknbxv27KegAGIsq/CYmBJp6SR7Ixq6VIjj8+8xEoZHw==
X-Received: by 2002:ac2:5f91:0:b0:513:c1a8:2959 with SMTP id
 r17-20020ac25f91000000b00513c1a82959mr10607574lfe.30.1710850480284; 
 Tue, 19 Mar 2024 05:14:40 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 u8-20020a5d4688000000b0033e3c4e600asm12345792wrq.7.2024.03.19.05.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 05:14:39 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v3 0/5] Qualcomm DWC3 USB support
Date: Tue, 19 Mar 2024 12:14:23 +0000
Message-Id: <20240319-b4-qcom-usb-v3-0-09ba1f86d259@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ+B+WUC/23MQQ6CMBCF4auQWVtDp6WgK+9hXNA6wiRKtdVGQ
 7i7hY0hcfle8v0jRApMEfbFCIESR/ZDHmpTgOvboSPB57wBS9SlVFJYLR7O38QrWiF3WlFtEKV
 VkMU90IXfS+14yrvn+PThs8STnN//nSRFKYxWjcUWsanocOWhDX7rQwdzKOEPK1mtMWZcaVOTw
 9pZNCs8TdMX/1fMl+QAAAA=
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1866;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=1RKolWCrR6g++Bz/zflJXslcGJiKFfoy+Gkj6Nxl/v0=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSfjev+sNx7HRsya47hIiNew+ZDLjpq75Q3PeFdv/3W4
 QqGy09YO0pZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBEvvUy/C/fsLL+5m7e+QFv
 09+9spuiblZ5xEzy1RwpM2l9xYuf3CIY/qf92L2L/2y4G6/o3C4+f9WNB7InsudPsc5+aq/2cZH
 0ZnkA
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
Changes in v3:
- Fix ordering of QSCRATCH registers in qcom dwc3 glue.
- Link to v2: https://lore.kernel.org/r/20240315-b4-qcom-usb-v2-0-5467ec27cb26@linaro.org

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

