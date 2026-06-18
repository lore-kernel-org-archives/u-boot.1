Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8CDCD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 11:58:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B502F849C6;
	Thu, 18 Jun 2026 13:57:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mx7q/b1l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 017F6849ED; Thu, 18 Jun 2026 13:57:20 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F9B38005D
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 13:57:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4627adcf4d6so569681f8f.3
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 04:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781783837; x=1782388637; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gY46pqDjWnx9FtWttSI4m87tjx5SpytLmAfOn+rjQzM=;
 b=mx7q/b1lMr1Mn692NSHCDn2VJXSsNzhhHqIBYkH+16MUTDID6leEYAUEGSd2M4iX9F
 rh5iOYbHZIeNC1MnJiBG/I+TncsJhKsm2y5+gQkVwr2MrS2vEFjMF3/m3anST3T2tQOR
 tE2YzCT553wjcBelnE/PuPBDbGo1+Au+POZHHqDFXZa8QBcwmJPlTuB7oeoCqBBvp6Ea
 yXhYO0r/+4O4u+nDgekeMZhA9PQoFaYF8rcdLGpLIJl9qoK86lFDt9VIDwj6LDkM3xR1
 +lpqEXLzXwn/n6JvKZkG5Dd3JKSKIFa4ZGQRdPKKq944zCV3ADMuXSoYbRjOVBqMTfBL
 2KHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781783837; x=1782388637;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gY46pqDjWnx9FtWttSI4m87tjx5SpytLmAfOn+rjQzM=;
 b=QfsXJM03iJ7gkiw3lg7Ku4k3L2/ifuvUYB1Vp5JwuBrCrG1CE5/BY/K87TWAIG2y6j
 HXxP+bc3BT1r9UdTrNhYEfF0hRRRZZBEXhkgFPLfzQliapdzPMZyk7Y8mZSLdYCDswOg
 v5uORtOa1YTkRQJPEsa9NGFJBhAziDC3daXHOWDUdhr6vyOS5UAW5rqBStTGdIigSWN1
 DRlpmFQB2zPFQssF4mFnL1dpkZPeB67W3YWk9J7CMDqfLFhRTNxGqxDkaZxUPvUk1nsS
 ySAvCXIcK2UBFhJg07itLOUgbWZEbw5lL7C052UavnWPmrGbnaL+oVzC/JU4aIiWA9dI
 nDhA==
X-Gm-Message-State: AOJu0YzBwA3vwYQ4GowSwjTzb2MWxj5S3dP2jzX2yPtOk2subcz4OB/l
 903HLDMeU2CbtUceZr8dwqdtJVUfVc2U7udZNiq7aB834DDIULoD8S5uTSGu+qei4mo=
X-Gm-Gg: AfdE7ck6FBwX25UsiTg6m3NuNSfSrTzJ7sSd3h1AhINcmJ5gl/dui/ATg99H7/t/389
 P9JDntHfUykKPzmbHcfhWU03Kf40FsHy3qvH8nA2w6CUci0sa5smYeWM3t/Q4XAOPyJgiEf3hNB
 qGqYoeDaovGVDS5XDqrgfyFdtlABK1Jf85P0xhD+xGTJh4G1k2jA2lzIU3Q3tlW69btP6sK6ZPW
 ytpk5H9zP7NPdKDPZ1Sjyl529uHx2jDZ9rw1S9SexRTic8i0KkXGQBZVkjd+KTVP14lsnvI17Hv
 7J/jTLV2Bw3riCGNF2F0XxVva5QekN86kgdJli98U8zONCisXUgAZBhRN9NdmM27rqvlfSvTffj
 YwPiBQH1a51/ac3K/Isl2ppAeqK2QMtQYSHmUIIkY8Ti01d3MMlef9AxtkQ/++XLX2z7H1QMzZN
 S0U0OUgbfQh8/wFhhjkI9xNvjgGlXfixEj9B2CDyUYI8c1Fq/RGKJ1zqY=
X-Received: by 2002:a5d:6109:0:b0:460:e00:121c with SMTP id
 ffacd0b85a97d-46237b7179emr9740317f8f.28.1781783837446; 
 Thu, 18 Jun 2026 04:57:17 -0700 (PDT)
Received: from lion.localdomain (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46289c3b3a3sm14448355f8f.30.2026.06.18.04.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 04:57:16 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 18 Jun 2026 13:56:59 +0200
Subject: [PATCH v3 11/15] soc: qcom: smem: add build infra
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-b4-modernise-smem-v3-11-472391477988@linaro.org>
References: <20260618-b4-modernise-smem-v3-0-472391477988@linaro.org>
In-Reply-To: <20260618-b4-modernise-smem-v3-0-472391477988@linaro.org>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Heiko Schocher <hs@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1419;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=xu3QnkwNPzzcBiDULvPowGrlVI8DbdLKUKpuRnO/0Zw=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhizju6xCOzanKfWc+pj8eKHy92KfZRoLJP/mS2z2Vvvw+
 nKuinR1RwkLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjIr5cMP7q8v23YZtf61Mco
 yPio2XXudOaYLSVae3/zLZQR6Ptqy/CHYxm32DWT1w8X/mPudXT9t1mKuUX5wJtelufSTNuPqDX
 WAwA=
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

Build the new SMEM driver port, and select it when ARCH_SNAPDRAGON is
selected, since it will be a hard dependency for Qualcomm platforms.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/soc/qcom/Kconfig  | 8 ++++++++
 drivers/soc/qcom/Makefile | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 8243805e46a3..cdd9e30f43e5 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -24,5 +24,13 @@ config QCOM_RPMH
 	help
 	  Say y here to support the Qualcomm RPMh (resource peripheral manager)
 	  if you need to control regulators on Qualcomm platforms, say y here.
 
+config QCOM_SMEM
+	bool "Qualcomm SMEM support"
+	help
+	  Say y here to support the Qualcomm SMEM (shared memory) client driver.
+	  SMEM is a shared memory region that is used to pass information about
+	  the hardware (e.g. DRAM layout, PMIC configuration, etc) between bootloader
+	  staged and the OS. If in doubt, say y.
+
 endif # SOC_QCOM
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 78fae8bbfa16..f4102f9155a8 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
 obj-$(CONFIG_QCOM_RPMH) += rpmh-rsc.o rpmh.o
+obj-$(CONFIG_QCOM_SMEM) += smem.o

-- 
2.53.0

