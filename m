Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F066C6FD1F
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 14:31:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B56138809D;
	Wed, 20 Mar 2024 15:31:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="v63VpZdm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E7D4880AC; Wed, 20 Mar 2024 15:31:34 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11F138808A
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 15:31:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33ec8f13c62so5005140f8f.0
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 07:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710945086; x=1711549886; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V660sAidEfB+8JaG2JnVeXQKzFud7du4SAPBobcaRak=;
 b=v63VpZdmQ1i+mFFMtQ4AtmPi9lJCKdf10rlqGyKbmWiLvHOev/inm1OFV+zFzPZIJh
 CbnMBr9pHFLvO/TA9w+/ZEFKfrPbCzm1Vi4ytm/seE9su6HpwW9pVokBA8yQxFu9nVVE
 ILrWnG1qf5o5xEHqIN3nVxgY3NDJA34BBhQSQNH4IwtzsnBe3dpr4PmOJOxpVIEqRJSY
 Zgb0+mx7rfRELgndnrdJ9jnCxLPwrtroYW/K+eE0NnoDMoQFUynAv7guJAIaxx0teAyT
 W096oH2YHS7iZ5v4LAF2CEXNfU69n9zrnZMeCQ2Vj0vthq1rM37Eb/4JbDWNt+U7UFkk
 ecNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710945086; x=1711549886;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V660sAidEfB+8JaG2JnVeXQKzFud7du4SAPBobcaRak=;
 b=rFUujSsPW36PLjQT+rIyyMcITEj8Cvv3DeYZslIfFyXZS2ZSoo8cOhimd2YQbENi1o
 kilJmNzjqTE9ZcwcRhd55i2fx2A+dsRod6sUXl/wGN/ObaZn4If+3fzbhXTvBvCJDJwr
 Rz0eeh3peu1FfQFqP191MxK8ogneV4nxruBZC2kdKzx8PcJTLV8dMLurZpO6OX5tkvp7
 a4H+bGod7BN8Ka8a7ACo6Tr05MjRCE6h47U2ubQcAevtnqe0ol4PNXFXQsvCdBdEbuEn
 MzMtNwEsUdXIo+hOm/cPPTjaHpTeJQBus/9lKQwUzjNGIzVGeN7nbSv7rYWX0xFxq/4p
 ucDA==
X-Gm-Message-State: AOJu0YzKF+J6mQmDRONjffT746ZjvKBsqEWCNqExyk6U4b+zFbPRp38o
 YCfgqECU56lCdROsJVnY8683de45KPQkAQL9WECA8M8BZQYU2E6WepdWAE2ymPA=
X-Google-Smtp-Source: AGHT+IEqc1XrrY9OQlaiqaOoQf/qCGM8tOYEPsd+PAHGy1OIT29OqDu9ZRFiwXPqQoEAsb4/nt8xOA==
X-Received: by 2002:adf:f985:0:b0:33d:5fa6:79bf with SMTP id
 f5-20020adff985000000b0033d5fa679bfmr10522542wrr.71.1710945086485; 
 Wed, 20 Mar 2024 07:31:26 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 az1-20020adfe181000000b0033ed7181fd1sm12036571wrb.62.2024.03.20.07.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 07:31:25 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v4 0/5] Qualcomm DWC3 USB support
Date: Wed, 20 Mar 2024 14:30:46 +0000
Message-Id: <20240320-b4-qcom-usb-v4-0-41be480172e1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABbz+mUC/23MTQ7CIBhF0a0YxmLg46fFkfswDoDSlkSLghJN0
 71LO9FGh+8l544ouehdQvvNiKLLPvkwlMG3G2R7PXQO+6ZsBAQ4oYxiw/HNhgt+JIOp4sxVEoA
 ahoq4Rtf651I7nsrufbqH+Frimc7v/06mmGDJWW1AA9TCHc5+0DHsQuzQHMrwwYyKNYaCBZeVs
 1BZA/IHs2+s1pgVTJTRtK1lA0Kt8DRNb2PEwIEhAQAA
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2044;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=5YXVuloWFUpZWUtzJSJHLcwFYHCA2hau6PP7tixFSu8=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRfn23OXT+9Y+fzZ2wtk0yNt+zP/Jx/WtjhD//1tza7Y
 4SFNZ7O7ShlYRDkYJAVU2QRP7HMsmntZXuN7QsuwMxhZQIZwsDFKQATWZ3JyLDbi8dpv/ek63Xh
 k/pvrZqpkOHJLr2EaUv8SvYVIV8WZHQw/OEqdrkaZnn705Vl81Z9LNa3Ea25lHXex2vDtLs/okw
 vN6UDAA==
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
Changes in v4:
- Use map_physmem() instead of casting fdt_addr_t directly to void*
- Link to v3: https://lore.kernel.org/r/20240319-b4-qcom-usb-v3-0-09ba1f86d259@linaro.org

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
base-commit: a288571aff7b27eb9f593dbfd8269e1fbdbbfe18

// Caleb (they/them)

