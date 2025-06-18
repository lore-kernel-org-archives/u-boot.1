Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B23C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 14:45:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DFF682BCD;
	Wed, 18 Jun 2025 16:45:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="VFNL6x+o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EFEC82D4A; Wed, 18 Jun 2025 16:25:32 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BD1882B20
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 16:25:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ade750971f2so922008966b.2
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 07:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1750256729; x=1750861529; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AJXXeWIHFN1gvP2SMC76O3SjIKt/EIEFQ/OrhiNr7BM=;
 b=VFNL6x+ok9A0ibm5bxUj5U3b4gvFUKKk5PhFpNY328tyanP2qXd3++jj22+dsImOIL
 D/T1koilm1AnkRVjqcyfMHuydBbiYsyNXPFJ6mQfGnxmtSWMDuIgSIL0STBeqy2/IRbX
 L1RysUWm/N9ZMqDDDagALzWruORSGZh9Fvn0vIJl02uELlvRZzkTRAV2HVFTBPR5HsfM
 AiA3Sc9BWERxfP/znfmdnmpFgcWXEou3ejw9ommqg1FZxagPUTzQnxTIycXtu4iY7eNR
 CNQz83viYXOeb/lW/VAPwYU0wAazJ851+fbm5gMkekBWHNgGBgJmy3gUUu7V+fPy3eZx
 2jjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750256729; x=1750861529;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AJXXeWIHFN1gvP2SMC76O3SjIKt/EIEFQ/OrhiNr7BM=;
 b=bZ237DUYZGVXPPcxUmozYZ8/WcSliTiJ84SQ6qq+nWLsIVrgs53lKIX5Y1OevmfHNN
 Auhnfulihnh57xDrYtqSsWl5eABZ/9J6nD+QcVDtyxf1Lh0AXjmjwVWUo/1GAcIS009q
 izIc8vPJ7lUSWIA7vNZlYEcl48COvuIbw3yXgQ5MM7E+x6jSlGnmch2xWftn7HFt+p4e
 +FWkkUTRi2Ac+b+8q1zoWUiRjyRXeW6saN6/SEg800QL7u93GrkO4ZWU2cXjNSLGwiRU
 PpH5OCpHwCMqfTYuy11VvZNkOzz+OD/endWWbK3IqOFgfF7Pxqz16oPBLkk++MOn83sN
 DFDQ==
X-Gm-Message-State: AOJu0Ywu1L3kXXR1rieLJuSXuBgZ0yKkitVpvm0hL6uGK2VdYRZbXFcb
 c43TGOvsAFPv42qSl72zlOs9oxVJ448gw1Z8kW5KAe7qqtavVMncfI2TpvnIs1bGqmI=
X-Gm-Gg: ASbGncsF7QtvNpxPgz9MAtF0szSVc+O49oxhtwDE31cic0Bz7Qwhz8Ip+uGLHzVPFqX
 saKKsMSV+CmgVOSv65ZhDK+rms3CiPeLSI3ndo9MZj01V5HfcF+wPE3qtX1fFlzW20mD/A3bW18
 oJif3kgT7KezXDe0sIFHKynwHbrzDExZlJ/fYT091W3+O0RD0mqQ8S5IZkDR7P3iZ95/QotAaUU
 O7vafHOeD1f0StMbHBY+pC9sJygYoH1tRO8hlyzzxVqZ9rc9lhOQrm246NpblSNVGVwUFF4cQlE
 Kn3aH6IvF7Ml2x6gFPVngb6X6xbCFhDxUt90YetqhxjW/pUdttDZrnVfhQ0s5SQsu4Lo/WOaePx
 gD5IagV29zOudKPhPq/tmWjphx4V1gYIn
X-Google-Smtp-Source: AGHT+IHDjzmIcf+jcauPYE07wns6m7BTnSecwNWfT4jTDKvi8rxkUl0xKQRdLRT9tcCYHJalnbXTiA==
X-Received: by 2002:a17:906:f587:b0:adb:45eb:7d0b with SMTP id
 a640c23a62f3a-adfad320f5amr1652220366b.15.1750256728899; 
 Wed, 18 Jun 2025 07:25:28 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adec8159e19sm1056733866b.4.2025.06.18.07.25.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 07:25:28 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/8] U-Boot Bringup of SM6350 SoC
Date: Wed, 18 Jun 2025 16:25:16 +0200
Message-Id: <20250618-sm6350-bringup-v1-0-3cc22aab7a7a@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEzMUmgC/x3MQQqAIBBA0avErBNGS5GuEi2yRptFJkoRRHdPW
 r7F/w8UykwFhuaBTBcXPmKFbBtYtjkGErxWg0Kl0Ugrym46jcJljuFMAi2pntBb5xTUKGXyfP/
 DcXrfD3mjfz1gAAAA
X-Change-ID: 20250618-sm6350-bringup-08e24e0f8bb2
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750256728; l=1742;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=ND7Io4cb/S+nQoiglKnnYvyzCi3W9tZxnbtFu/VhaMk=;
 b=HSpvcJUmg3dmmUuyHJdS6dPdKza7VKIT4Vx5f5QxUswJ+DT+L6UgX5ryDswpeeXq32NSjoW8r
 QcAayNelbmPAMGPhE6/rgcUjJkZIuHJ4vJyUGGosEefQD+Ao6qiV0VE
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 18 Jun 2025 16:45:31 +0200
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

Add a clock driver, pinctrl driver for SM6350, and enable support for
this SoC in the SMMU and UFS driver. Add a debug kconfig fragment which
configures the debug UART address.

Finally add support for the PM6150L regulators which is used to get
power on for the SD card.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (8):
      clk/qcom: Add SM6350 clock driver
      clk/stub: add sm6350-rpmh clock
      drivers: pinctrl: Add Qualcomm SM6350 TLMM driver
      iommu: qcom-smmu: Add qcom,sm6350-smmu-500 compatible
      phy: qcom: Add SM6350 to QMP UFS PHY driver
      regulator: qcom-rpmh-regulator: add support for pm6150l regulators
      qcom_defconfig: Enable SM6350 clock and pinctrl drivers
      board/qualcomm: add debug config fragment for SM6350

 board/qualcomm/debug-sm6350.config            |   5 +
 configs/qcom_defconfig                        |   2 +
 drivers/clk/clk-stub.c                        |   1 +
 drivers/clk/qcom/Kconfig                      |   8 ++
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/clock-sm6350.c               | 194 ++++++++++++++++++++++++++
 drivers/iommu/qcom-hyp-smmu.c                 |   3 +-
 drivers/phy/qcom/phy-qcom-qmp-ufs.c           |   1 +
 drivers/pinctrl/qcom/Kconfig                  |   7 +
 drivers/pinctrl/qcom/Makefile                 |   1 +
 drivers/pinctrl/qcom/pinctrl-sm6350.c         | 104 ++++++++++++++
 drivers/power/regulator/qcom-rpmh-regulator.c |  31 ++++
 12 files changed, 357 insertions(+), 1 deletion(-)
---
base-commit: 71ca798b9e9c8c58284cbc7a5af83c709e7a879f
change-id: 20250618-sm6350-bringup-08e24e0f8bb2

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

