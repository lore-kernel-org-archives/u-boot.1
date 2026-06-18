Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54280CD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 11:59:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A85078056B;
	Thu, 18 Jun 2026 13:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LknHlegD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE0608005D; Thu, 18 Jun 2026 13:57:29 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C887184A02
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 13:57:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4631679f204so844216f8f.0
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 04:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781783847; x=1782388647; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=S/7DcN5oXldjQ2j9sj9vg3PcG/T/e1DxcbxwoH5+uJs=;
 b=LknHlegDZt6utMmSZcPQmij+f37TU1EBs7mbN/MCmHLV/SH/4ckgz/yKl5uj3kCsyU
 hFZttO+/mCQHvKDAxOI49gvbOEC7uQto2qn4L5iNP/73oxLHr4WptAU30LBlwJsjW3Hf
 3WpDi6CSRADqVkAOBfg7DF/l3+6oj9n5Wk1hQvnWgSlaqrGC1wTp9iKNF5o8BIF5EgRQ
 zcqhLhL1cuiAUHb2ByYBwW/OdoKUWSTTm+Gi6484H/iwAIXxYWvvUWT0t1iV4qHqQzvL
 8e08XOC0CLq0hX5P8R/HDp2ontbVEFpeJOh7MleSsBpb1bAkKgfBlaasJevz1K3Y1OYU
 coHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781783847; x=1782388647;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=S/7DcN5oXldjQ2j9sj9vg3PcG/T/e1DxcbxwoH5+uJs=;
 b=r63lDwY2me1JQ9JnmDWpauJdLFs5FoCAP1NjhHTC0JconSy2ZNgGolwTA0Z/7573un
 vfV4VbUfkxa/YN6USMsMn7Rhkvdnj8cXJvGTtOCK9EUjxPXAQjWkCU9OVfZCynXG9CkS
 Y31uXq/tYK9mWas7b9qaYVIUC83hXXo712Hz2NhB6ESAE/h8PaJe696NWG5bd90jg8BL
 buWybURtg2BGURXMvfjwfjHWh4/gkHd5gdkmUrndFpG8nDNY431RADnSJ88em+ljo6K0
 AwQoFk0PacH8or4QeDW01rcRpz3DVp5MxptP6hxntvTVt2Pw85LC1po8g7z542nqVSeK
 qJ8w==
X-Gm-Message-State: AOJu0YylSqrHJASJTyVp+KuM5NdzR5l/0aIePdqsXc3ecwLFO0TTFwAO
 FrL+O6/WsNfXe1iYalw/Zswghdks1VWNeBBqk7xTVBaU2FE6FGQ5McEglly8DNyU0ag=
X-Gm-Gg: AfdE7cnyvlhiyiGLDmatv6jxDtWZB/o1rXt+i221BeRc1mrDaEfHM58dmXf7m9HkvV3
 xmGM+JXk2+pDXTGQm8Rl9JRRvWOVSdvQNp7glb1j5visalHKrlvL20qbQhADpRhaN1tgljLmv3o
 /GNpGSFGqrcbL/5DYFkJO6k1FuGk0fz7pl/l5WD57CshO4CXD3gU2O2DstOHViT2XA1xj55PKl4
 t2JxEas8lK6O2g8dcT6pjq1vc7rz5Z8CHF/laZu8LhwCv5wIFF1tDn8wVo5UNUEFwlH17o5QIWK
 7+FPSm/lnCxhqnULOdUcDutO+kVm8SjIUwd2LQjSrw5fF5EGalwvAOBAd5Vyg8wy1flASYdCgdT
 0/Gjt8yfHMVUETDjdtyg7cVFWaT5fHEX9jpieDqxfENFqeu7fPHlFc17PwnboL0XX+MvywsM83J
 O2XKt33KE04aZ5Z7OwKdsc2HWXbgmiPjVSmzx2dNOXFe9mCM0HGM0TCBg=
X-Received: by 2002:a05:6000:2387:b0:460:6a3d:a114 with SMTP id
 ffacd0b85a97d-463992b0983mr5872402f8f.30.1781783847312; 
 Thu, 18 Jun 2026 04:57:27 -0700 (PDT)
Received: from lion.localdomain (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46289c3b3a3sm14448355f8f.30.2026.06.18.04.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 04:57:25 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 18 Jun 2026 13:57:03 +0200
Subject: [PATCH v3 15/15] configs: add qcom_sm8650_defconfig and debug fragment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-b4-modernise-smem-v3-15-472391477988@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1368;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=nJSqQlQgYIDyVV4sMBRSZ6oNXxk3DOKau1HlGQElwc0=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhizju6wPfn98rpM4b5+S6pL6hK4rz1bO2qyc+Hbmr+Ckm
 T/NBKpEOkpZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBEFCMY/srynshevfRXw43Z
 5qcrVvZsfnwr9nD/8vOBRSvTOVvmsIgzMuxZd8R3oe/U+LPKYVx3tt3gEqlvWN54lbmx+f6yMxd
 Z58sAAA==
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

Add a defconfig for running on sm8650 as the first stage bootloader and
associated debug config fragment.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 board/qualcomm/debug-sm8650.config |  5 +++++
 configs/qcom_sm8650_defconfig      | 16 ++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/board/qualcomm/debug-sm8650.config b/board/qualcomm/debug-sm8650.config
new file mode 100644
index 000000000000..8323bf25e9c1
--- /dev/null
+++ b/board/qualcomm/debug-sm8650.config
@@ -0,0 +1,5 @@
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_BASE=0x89c000
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_CLOCK=14745600
diff --git a/configs/qcom_sm8650_defconfig b/configs/qcom_sm8650_defconfig
new file mode 100644
index 000000000000..e0a82c460337
--- /dev/null
+++ b/configs/qcom_sm8650_defconfig
@@ -0,0 +1,16 @@
+# Configuration for building U-Boot to be flashed
+# to the uefi partition of QCM6490 dev boards with
+# the "Linux Embedded" partition layout (which have
+# a dedicated "uefi" partition for edk2/U-Boot)
+
+#include "qcom_defconfig"
+
+# Otherwise buildman thinks this isn't an ARM platform
+CONFIG_ARM=y
+
+# Address where U-Boot will be loaded
+CONFIG_TEXT_BASE=0xa7000000
+CONFIG_REMAKE_ELF=y
+
+CONFIG_DEFAULT_DEVICE_TREE="qcom/sm8650-hdk"
+

-- 
2.53.0

