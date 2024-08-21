Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB025C52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 13:41:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 328AB88D8B;
	Wed, 21 Aug 2024 15:41:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RafnNt2s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7954B88BF6; Wed, 21 Aug 2024 15:41:56 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FC4988AC0
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 15:41:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a8679f534c3so67607666b.0
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 06:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724247713; x=1724852513; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=km+WfVmYGOfWEHaQO9biOtrz59e9xI7iGtIw00g6wMU=;
 b=RafnNt2sRUKcwC/+tlP3p1ycppkto3F3amuNq5T45NmE/6ioUg5bnzxaRkqissguv6
 cQVsQYQKie21HpJpEv0wmfJGX5fqFtUMaQT1ODN430GDJ2XWrX9Wk99RUsnjJmJmoQUW
 WQvRnxpcVGJLsXE9jCm98092PRF5G4cY+SCjXIullUntcAbQbZkPvubYrCQUmnl25Pi0
 MTs/9PZoq0s8hJWxcAmrRt5vpMRdix1yVMdS9P26S3UdX1pcup7sHqhPAcgfHR5XcZBJ
 MP3+7CHElKuuLhi13lN586uahmI2e09PH8jbvqIqSjOyTMK/0NAnyE/rJwRb+J8FPn3F
 sBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724247713; x=1724852513;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=km+WfVmYGOfWEHaQO9biOtrz59e9xI7iGtIw00g6wMU=;
 b=c0doKNwAu4MTWcSvU7rDu/y/eKw2t/IFI8L+j/PDT2QE3H2DwlBaK2JtNmrBG6dtGv
 +nKPcVUshUTNH7u77gVLftG5op0egkIzzvR6if3ALsSlEsqcenEvjS439PoiT1oD4NWe
 jXMT6cRC7+LSTXTKnsmFO/TRmC162pDZcYczn8k/6UAny9t/vxiivkQ16hk2D3rKw3h0
 3gd23z764q/PTXZw9EjaW81WRLNzXcfQy7bpoS5hIj5OXuBur+FqAwK1+7I6v023s7wL
 xddedbFVMj4iAgYEoUzwz8f/uOFBbujASJiGSD5nN0cHrMvkcNHS5j9BOOR+Pb1+AbeM
 5Y9w==
X-Gm-Message-State: AOJu0YxZo2ydcXXAWpGH31vfAJYHFzuMeE48q6X69vJgyoHLUzgBN2QG
 2zItKTzJFYJ+RvAju2espVeOluyt6Joeazy5qc/jdilf775uc2/p+hF0YrCeNL8=
X-Google-Smtp-Source: AGHT+IF54i3itRcE+gUaWuga4d3LJ/Hbr2xrERmqsc7D+gk9K3dHZff/lXT+0Osumcq0bqyUt1+U4Q==
X-Received: by 2002:a17:906:6a20:b0:a77:d85c:86fa with SMTP id
 a640c23a62f3a-a866f107b1emr160816666b.13.1724247713272; 
 Wed, 21 Aug 2024 06:41:53 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::676e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83839342f6sm904164066b.137.2024.08.21.06.41.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 06:41:51 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v2 0/7] Qualcomm: add support for SC7280 and the RB3 Gen 2
Date: Wed, 21 Aug 2024 15:41:45 +0200
Message-Id: <20240821-b4-rb3gen2-v2-0-49b07633f3a8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJnuxWYC/23MQQ7CIBCF4as0sxZDoRZ05T1MF1CmdBIDzWAaT
 dO7i127/F/yvg0KMmGBW7MB40qFcqqhTg2Ms0sRBYXaoKTqpJVX4TvBXkdMSljjg+175wO2UA8
 L40TvA3sMtWcqr8yfw17b3/qXWVshhRmNnlBevDbu/qTkOJ8zRxj2ff8CZ29pHKUAAAA=
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1994;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=+bdCZz5ltUgx97guWTWwN7eH9EfzO2fhWAUblayrF0E=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmxe6cwcDSnPRjDjnazhlUs3o3BTzzu/XLiDY/n
 rqfWQg5IFSJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZsXunAAKCRAFgzErGV9k
 tm9qEACBNBBEqsVzR58aDYXP2ErX+OVKusIk5JTDAROtDdsHH8qRvDS04Gr0zaq58DxSft1M4Rw
 Pnb1Q650Hjuo6WD07Lr6JBfH6JRCNfiqDp481m/s6PauA4l9NWDLMHl2TwjPQFWxs8NdioJ0HF0
 Uo6TDvWn+MHGuRWVNnfcjBQC7Es/4rJaEpsJTFntCYwSChlPtKb6fVZp5cVEg1XgSkzo9tsSt4p
 WnsKMjtOT0NNs28sMgF/JbxAyEG8bABnveLYtrxYJlj2Jz9JItJBn7X/ixzhvNSt2B52o7xweet
 SDojuRH4hiZl6r8d+r6CxzrXtA11ojAG5sw5/Or0wFIss5WTtxwIS5yXbPfgwkiMTllyLgDoLgH
 n4Wx1wRbPQYxRGp+k+bkf8g1YSDInlLjKsIx3hjHDH3wNFobVHl5zdwnj4xvACUaLF76Zq/fnkp
 TtdagK7NketKMFJotYvQZzp7YW59X8wi6TDeIYcc8/RfXlKYZtwoEghkWWwTGKvEN10FZMMbMUn
 cc4CJkDl1fjAgmiIOv1szgqjN023by41azyPpPo1/xctgf4kQcrKASZRrm+qWAJQajB9p6tFKKU
 N0a7CafNgXiXmaj2aG/6GyAgTkP3FSnMzbO+o5Dwiy3Ugpu3j9XV9wI5CdY5/Nfc5Znq2poYX1O
 Jv04VMOoz/mhAWA==
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

Introduce support for the SC7280 platform and specifically the RB3 Gen 2
development board.

The RB3 Gen 2 is the latest robotics board from Qualcomm, featuring a
QCM6490 SoC (the same SoC found in the Fairphone 5), 6GB of RAM, and
128GB of UFS storage, as well as a whole lot of I/O.

Most of the I/O is attached via a custom PCIe bridge chip, and as such
is not yet supported. However it is possible to boot from USB via the
Type-C port, which is hardcoded to host mode for this initial support.

USB support additionally requires this patch:
  https://lore.kernel.org/u-boot/20240423141551.2410199-1-caleb.connolly@linaro.org/

---
Changes in v2:
- Add rb3gen2 docs to index
- Add qcm6490_defconfig to MAINTAINERS
- Link to v1: https://lore.kernel.org/r/20240809-b4-rb3gen2-v1-0-7c73fe05b37a@linaro.org

---
Caleb Connolly (7):
      clk/qcom: add initial clock driver for sc7280
      dts: qcs6490-rb3gen2-u-boot: add override dtsi
      dts: qcs6490-rb3gen2-u-boot: USB host mode
      iommu: qcom-smmu: add sc7280-smmu-500 compatible
      qcom_defconfig: enable SC7280 clocks
      configs: add qcm6490_defconfig
      doc: board/qualcomm: document rb3gen2 building/flashing

 MAINTAINERS                              |   1 +
 arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi |  28 +++++++
 configs/qcm6490_defconfig                |  18 +++++
 configs/qcom_defconfig                   |   1 +
 doc/board/qualcomm/index.rst             |   1 +
 doc/board/qualcomm/rb3gen2.rst           |  53 +++++++++++++
 drivers/clk/qcom/Kconfig                 |   8 ++
 drivers/clk/qcom/Makefile                |   1 +
 drivers/clk/qcom/clock-qcom.h            |   1 +
 drivers/clk/qcom/clock-sc7280.c          | 132 +++++++++++++++++++++++++++++++
 drivers/iommu/qcom-hyp-smmu.c            |   1 +
 11 files changed, 245 insertions(+)
---
change-id: 20240809-b4-rb3gen2-87bd866abde1
base-commit: c6222132b64faf0ab083330f208b1400ee47ccc9

// Caleb (they/them)

