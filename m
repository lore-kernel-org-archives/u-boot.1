Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B05C83F1B
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 13:13:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 520C583020;
	Mon, 14 Jul 2025 15:13:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LaO3RENH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86C0083046; Mon, 14 Jul 2025 15:13:19 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C7AE82E52
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 15:13:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a6e2d85705so2492113f8f.0
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 06:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752498796; x=1753103596; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z8RrESuZ92mcN66v5OMMIn/syaxhoHMYM2TzMCK5uj8=;
 b=LaO3RENH1sjJKV/dB5hV9MvHoDVmSoZCSs8CQpIt+Sdu3pQzpggHQLcSOi62tSInAH
 +DeXCbG2IYTfR2Mw4EGUxXy1uqx4IvuPk0tXnjsRymwBfxmsbKgcr/0EbFtNlueDM0a4
 vHFykoHROI+enQH4rGFQaACLFsWV6IfVeB1yFY8R8o3TafCpQxK2rDXJpwNCY78EZOeH
 +7cWZ6Aezt4xsP1BzDnnhyu6e01pvtdKLVCM5zO0o3ZfyKiBIP4+FoUi1rMheC+5ihN2
 ffWc07AtMFh4/qBuN58DcrwyntprGprnNsWgDvpb9JKTCc00fIt1PxIVYj+/8+fCGgH2
 j3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752498796; x=1753103596;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z8RrESuZ92mcN66v5OMMIn/syaxhoHMYM2TzMCK5uj8=;
 b=HjOQBBWtEgmAEgVZLkuULsxAu/ToN1d9PtbA7jS/JwfMxZBcRBfOnTZrGUpYjrsbKe
 U9Dvupfoat7yxv79BtsZWzOebhxVBFTUnmJ/U1ySlsbiyAr1mdBth6sislYiWoIjuQk7
 eI66yyDppkXfmhVO70deu+/edtjzNC3Macu03QY5zxnT+bTOz0zWR2K+2zsvRqGU3LiQ
 kybC4z70T5+TZCBy6z1DK+twmeFuwD0HTH6bJ1rC/pTMSRDqkxbwpr/TYUwkoSjeBPbr
 U2n/w69stzqRJi9CrmZAUBWCC/CHRsGc7hvCn67RriVASuNmwhXPJJx5BMg4HXj7sogw
 24wg==
X-Gm-Message-State: AOJu0YysrDBWKUHCWs5SLoc+ISsu/E/5nOTRrdLGG/gt6fDG7ETDAb6y
 nYMyvxNB1Dx/k1mPd7q6800vXHvKE6ns1tJDOkdIj24QFtkBybPjAzrIE9f1OdGRTns=
X-Gm-Gg: ASbGnctxs2DE++c6SWp/5DUvBqtEUFLSAEOewpLZbUvnCJxXMx+Ap5oBiVDqeS7gRws
 0suZRq8rt70CNHyW1QPrj6/OGM2AAo0pcg1nBdlJsN90tW33XV4WU6Ks5BRuAyuCFIel+gj04T/
 qtVQz1U4wTGAYFKr0n/5hsZiVFV/rllMuILu9S7+m54v3KUrtGjrXFIk450gLHh2DGlwdj1ztZA
 cer0mrJu3qFzM/uWirRz0cRFN9hfwCsHhLr8LdbH4xjGwDNNmVdleQPws7Dc+dnVAbH8QtUESr0
 B0+Hnzc1dmoxz5qFw1zpO9YYWp4+UBuK9hQ9HKmSDvaJ22IMvlslc0JAyhtJDHSLkdAHgbf79aJ
 SsAKlUtaSN9qbwzRcROYrECPWDDplxazGWCXfyH9mWIwlEUjO5VSnL+k/A01od5XaQYyO/g==
X-Google-Smtp-Source: AGHT+IHp+qA1sCX96C2E7lHV3Jgu1r6TQs5eD7TOsHlj7TbsVbL3vqgUWANG5kgeh/ZGaZKReNRu5g==
X-Received: by 2002:a05:6000:25c1:b0:3a4:e4ee:4ca9 with SMTP id
 ffacd0b85a97d-3b5f35416b9mr8532831f8f.23.1752498796487; 
 Mon, 14 Jul 2025 06:13:16 -0700 (PDT)
Received: from toyger.localdomain (p549d4699.dip0.t-ipconnect.de.
 [84.157.70.153]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc9298sm12361010f8f.44.2025.07.14.06.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 06:13:15 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v5 0/8] Qualcomm: implement support for GENI firmware loading
Date: Mon, 14 Jul 2025 15:13:11 +0200
Message-Id: <20250714-geni-load-fw-v5-0-5abbc0d29838@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGcCdWgC/23Qy07DMBAF0F+JvMbIz9iNKsR/IBZ+jFOLJAY7B
 FCVf8dNJSgty7F87tXMERXIEQrqmiPKsMQS01QHedcgdzBTDzj6OiNGmCScCtzDFPGQjMfhAxN
 wRnAWhN45VMlrhhA/t7in5/Oc4e29ps7nRzRCKWZL7Zr9T2hximmCx5QBuyG5l4IXigkG46UQW
 jmu4XGIk8npPuX+4dRlTamf0zjGuWt2mkjOqA8eLDo1H2KZU/7a9lroVv3/CluP1CowGZimLFz
 0bEkL+9UtJVeaVa2c8a11VHtLbjS/1PxK86otKKUtt5RQe6PFpW6vtDhdSPkgBCNSEvlHr+v6D
 d9bUWTdAQAA
X-Change-ID: 20250314-geni-load-fw-0eca432f489c
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Stephen Boyd <swboyd@chromium.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3790;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=ktDAemWXFd2eTUCnqkOlG7qC4Uf+rpSTKZvP7/0kBpI=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBodQJqgMnm4VCUOHxIrpu1V1CliKclCWFf67+Ce
 nMHLNh+gC+JAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaHUCagAKCRAFgzErGV9k
 tn11EACY1NpfXRYvb+td3QzSiLaY6exQ+pDHgW+sZ61JmZGNmVF14OjG/jRctQpeSzPd4Y+zjcR
 vU9dlbncPR0GrLUX3GtnCUmtpU873U/I9cScXsDRyf4/q61+fER/2WczXOcwkz6vf179HgrYPCW
 r85KIxS9KHl4lPVbFEPRFbs/qw8pbtiExWgGkONk74lIJWG7J8FJMyWmEd36VRLV5awZS5z5bfG
 qJBVTWoorkqVk2/wrA4HeuNib4Zor/Li+ebkvnEOlk1eIHELqnlwllDoNWi6StWuQzY2ZMMigrU
 3FQPC3gkrK3jliWWINUU+nGQ5yBh97H1Uea007ObTHGDPwas9Glk7FNT++Cpd7r1GQtBKsKQfOJ
 5PQMjJi3YCX2vo77NY1Zce3krhJkkQqH/AMEfLmRbidcEqt2yeAfR5GmtfkXV/Os5NJoUJJyPhL
 i+0wCqtWwyZ799FWqirq2X6dFMpx+g6B9Cz8i+W6XgJzpjl7qtgWERW7MULvZV/qtEfWma/b6Ye
 ho6BASwoKUQnCk2MI+8L6HiHoEX6U000xUXIVPNIpFtUJ4t6UHLUYjfcIV+oKu26uXGQ85fAUGd
 I4VPbqJdkHK+NqBs6SXX4sM/djp9h0J8arII+D0XNFLymLm9eNyUrrX24f4+jGzb57+fAcHIsdg
 PM4w9l8ZAaNgRtQ==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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

The GENI block on Qualcomm platforms contains many Serial Engines (SEs),
these are general purpose hardware blocks capable of implementing any
low speed protocol (UART, SPI, I2C, etc).

The protocol implementation is provided in the form of firmware which is
programmed in to the peripheral, typically by the EDK2 bootloader. Up
until now we have primarily been chainloading U-Boot, and therefore
haven't had to deal with this problem.

However, when running U-Boot as the primary bootloader it is necessary
to handle loading and writing the firmware.

Support for doing this in Linux is also in progress [1], this series is
largely based on that one, however the Linux patches expect the firmware
to be provided in /lib/firmware, and will only exist on newer kernels.

Since we may want to use peripheral (e.g. EEPROM) inside U-Boot it is
still useful to implement firmware loading in U-Boot.

The approach taken here is to bind all peripheral devices which don't
need firmware loading (e.g. the serial port), then wait until
EVT_LAST_STAGE_INIT to handle loading the firmware from storage and
probing the remaining peripherals. We forcefully probe them so that they
will trigger firmware loading and will be available to Linux.

For testing on the RB3 Gen 2 [2] is needed so that the i2c peripherals
can be probed.

[1]: https://lore.kernel.org/linux-arm-msm/20250303124349.3474185-1-quic_vdadhani@quicinc.com/
[2]: https://lore.kernel.org/u-boot/20250314-sc7280-more-clocks-v1-0-ead54487c38e@linaro.org/

---
Changes in v5:
- fixed devices getting probed multiple times
- pick Stephens patch to properly enable serial clocks
- Link to v4: https://lore.kernel.org/r/20250616-geni-load-fw-v4-0-e7df44205505@linaro.org

Changes in v4:
- Regenerate qcom_ipq5424_mmc_defconfig
- Adjust Kconfig so that peripheral drivers express their dependency on QCOM_GENI for firmware loading and update the defconfig
- Add fw loading for UART (e.g. bluetooth) and SPI
- Link to v3: https://lore.kernel.org/r/20250613-geni-load-fw-v3-0-be778b3b101b@linaro.org

Changes in v3:
- Replace printf() with pr_XXX() in geni SE driver
- Add firmware loading for UART as well
- Link to v2: https://lore.kernel.org/r/20250610-geni-load-fw-v2-0-7cad6bc18db0@linaro.org

Changes in v2:
- Use GENI_SE_INVALID_PROTO in geni_i2c instead of 0xff
- Fix typo
- Link to v1: https://lore.kernel.org/r/20250314-geni-load-fw-v1-0-587f25f2812f@linaro.org

---
Casey Connolly (7):
      configs: run savedefconfig on qcom_ipq5424_mmc_defconfig
      i2c: geni: fix error message wording in clk_disable
      misc: introduce Qcom GENI wrapper
      i2c: geni: load firmware if required
      clk/qcom: sc7280: add uart5 and uart7 clocks
      serial: msm-geni: implement firmware loading
      configs: qcom_*: enable QCOM_GENI where needed

Stephen Boyd (1):
      serial: msm-geni: Enable SE clk in probe

 configs/qcom_defconfig             |   1 +
 configs/qcom_ipq5424_mmc_defconfig |  69 ++---
 configs/qcom_ipq9574_mmc_defconfig |   2 +
 drivers/clk/qcom/clock-sc7280.c    |  28 ++
 drivers/i2c/Kconfig                |   2 +-
 drivers/i2c/geni_i2c.c             |  14 +-
 drivers/misc/Kconfig               |   9 +
 drivers/misc/Makefile              |   1 +
 drivers/misc/qcom_geni.c           | 580 +++++++++++++++++++++++++++++++++++++
 drivers/serial/Kconfig             |   1 +
 drivers/serial/serial_msm_geni.c   | 107 +++----
 include/soc/qcom/geni-se.h         |  36 +++
 include/soc/qcom/qup-fw-load.h     | 178 ++++++++++++
 13 files changed, 912 insertions(+), 116 deletions(-)
---
base-commit: 9805321dfdeb5225fe5c5e0721abf49c0875637e
change-id: 20250314-geni-load-fw-0eca432f489c

Casey Connolly <casey.connolly@linaro.org>

