Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6282ACD3427
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 18:59:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 699F8846D2;
	Mon,  4 May 2026 20:57:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B8tlTr+z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62E50846E1; Mon,  4 May 2026 20:57:58 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC1128467F
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 20:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43fe62837baso2355444f8f.3
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 11:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777921075; x=1778525875; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gY46pqDjWnx9FtWttSI4m87tjx5SpytLmAfOn+rjQzM=;
 b=B8tlTr+zYBM93knGLNDc7LOexXYuPj93NA0apWLlXYF57/U0ZrVsC9MBrCxtx3PfK7
 tc+NeaRPKexN+lr1wPeR3O4Agiat3SCkpiSUmHtEV4HMYkyYm7S6PTqiZuHVVxhsg450
 xP9V0cOy3hWadyIRW5TEcnk0+a0vwVMfGmCtnrj8ewtKTgEpodca7tMA9S6xoieanmqj
 6kUMHgItwRRmf3rLygcPMY1xv9LiSdxKI0KlDKsXqV25lYOOi1KG7/f1se62RwDiILrb
 ZLBFb1Z/RKrBx3iGlojCnC5QarEogbg6cQpQ1zzLSNfeXFoOpVhYLYm+7hFbcEpcZu/x
 x9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777921075; x=1778525875;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gY46pqDjWnx9FtWttSI4m87tjx5SpytLmAfOn+rjQzM=;
 b=kRLtZ4902TOrwzZzlmdfrUmEf+/zTYJQhEl6M2cEfvKxzKOETcDFYPNalXy8FsW1VH
 A0/VKU9u2/BqgmS/oOYmqU59xkKsTBs447CqXTj5xvsK9DVCxiUm/8gHmnOWLO2ATGpN
 C5ZDTl3Kdack4XElm6cXC7c8T93WTdnfQD5xpe3P+5865WKYa4OQVfPr8V0QCpXRQsYt
 8ZXs9jKSsmJzVEdsZmvz165qJKEM8SgTjY77+e7ZuyOBel2kq9qrQB8d92HoVlyvOFr/
 RTB2lP7JqtXK62/uql8sdbto9sJ3/FfJysDOH5NDJDwZ0BL5WY1/E0rCl8jMFkp+lWfq
 r/ow==
X-Gm-Message-State: AOJu0Yzt9Rj2lx/W7Z7+KbhmmoQD7FYiyXXVx+Ue+QoOgUsAiCP/EHmu
 cfZnXAvfpDtuxXl+KPEmADHu5rktk5kJ/vwMvStuV3vkGajbiIKBjWBAtNS8POFMi+Q=
X-Gm-Gg: AeBDies4iRpG2zHlLrHF3NLrdxgxA/wVwQu7fLgRBQyl1xisRIomCxcYNf5p8Lm/jGH
 iewgzQKHlpe5LZPUCG/4lStO7Eu23WPTNt//tXmiKgXXQ1kb/ig2KzXdszMWmB/q8mvpRBOcfkn
 xyn1+tzyDag1w3qrxFbRbR3VFE5kLfexORX+p+FXi5SSRLmtNH+D2V+kUy8MxIocktuG/H4RejY
 5CHQMsPVDQQHouDPGw3HzvDBD+8TsBe8YNUcYRaerTe/3zFbqQwNd+Uy/fY4ZnzjMmGkZ6HlLYh
 P+vxQCFZxxJiZyB2RbRT1F4oloRs7m0UWAla1v4hYFE/FEpwYgfSbGrbCFv0WZ1Wzbrrx5rNRQW
 XNAUxgPfYCyCZbRQ9EY62LuW4rrMxQxhlM2wbrpU5q9wcDlZGXVOigTiDZy3ncpyQfBn5VNjy1u
 QjHLd3XwOXVc8KKLpwpMVbsAO6F/UHeVhYEYmly8bcQZJJy8kbcA9OkfQzPCFIEZ/jEwDUwX89y
 h/Faes=
X-Received: by 2002:a05:6000:1789:b0:43d:70de:1c71 with SMTP id
 ffacd0b85a97d-45003fc66aemr275573f8f.11.1777921075291; 
 Mon, 04 May 2026 11:57:55 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4500f9c2cd5sm2861f8f.23.2026.05.04.11.57.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 11:57:54 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 04 May 2026 20:57:39 +0200
Subject: [PATCH v2 11/15] soc: qcom: smem: add build infra
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-b4-modernise-smem-v2-11-c01ec2ff3886@linaro.org>
References: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
In-Reply-To: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
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
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhswfb+Q/N705cfVdQZbjNOOzXlxmWbKv77pz9HyX/7/k7
 aId7UkPOkpZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBELJ4w/A9N9zEzad/rcLmJ
 yVgs/KHc9bRsrufKtXrvvdbXNl7292P4KzXvUW1/lT8H6+sNO7Pnqfn8OdMeVHZr5/uoGR+O7WG
 6VQcA
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

