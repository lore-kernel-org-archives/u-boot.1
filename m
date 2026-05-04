Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AFBFF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 19:00:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A417846E6;
	Mon,  4 May 2026 20:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wsP90C4B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0B35846E6; Mon,  4 May 2026 20:58:05 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BD9A846E9
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 20:58:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43fe3e22e33so2452205f8f.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 11:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777921081; x=1778525881; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=S/7DcN5oXldjQ2j9sj9vg3PcG/T/e1DxcbxwoH5+uJs=;
 b=wsP90C4BPI2MgmAfcn9ij/iUwYJrpCJXrdIl4BiJYq66B9vrpqGom6Ez23QOHNSHTs
 FIm4czQQM0s/Iby2ijSlqpjPooj3GE+Z+QsohNRueBztYD3/LLwlRgVEVJAfTRQKg0CZ
 U1o8dcnd2EMoXCXHfsXcK0Zz47tY6g9YlyDPkcJK5kIVe95jBjI95AncA8U29Q8ZMerr
 6bM3z01z8Nf+MT05kKxUSG/KLf4qUSq3GN34orOfHN7PT8ffixei0WWquG6yOz6iC6xW
 zIe4TM+N5WhEZoLGvWbe2c9dVt7jVfTBT3q5IrdHMmznql3mzbrP4qnb076prRxtV2Ph
 V1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777921081; x=1778525881;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=S/7DcN5oXldjQ2j9sj9vg3PcG/T/e1DxcbxwoH5+uJs=;
 b=mNeTYQN+hESqMvSvkhjXrFkz9/tq7ymsyn3FmiyJCHC0SklTHfTxPawFGy8k6EGZrU
 MGfL1Qq1UXNAOb/F10wFdiC+rdjFgLGLa7ObDTMulzn+uyYQbDGeQSKsJdNsvVGG3nTl
 wpUDm/bCX+7j4HZwAgISYXuYDCAm4bYkEuXhW2iKi8KGnk0ohBhvNpvhKDTZyQBsBDKr
 +r64vcqCHCm7gGIo+vTeqn8nUKdLEdR2rA6Y4Wln1pvnrhe5veh4zeTv0Jr5NmQXVDpY
 tFhDw4FtRKhCkmBm9eSTeXvFunH07ihbFoMCqezRy3N5mWi48rXR0n0GqvNHYlOyiwip
 er9g==
X-Gm-Message-State: AOJu0Yy+NhnrIOSD8eUE8CiicR759HlNR9hjzPFITwnuo191ay+gxDHA
 ILojlp346zsaouy8+ZnQMnOJYIJR9UlSQoNZW2Gmn068RSPBT6eiGfg9lZ+EZ4GPeRo=
X-Gm-Gg: AeBDieucAHne4y1Y3niokmNb+1echemM7dUDnTWObmkxGyuFpBDIuoHVUsP7HQ+QLri
 Su9QYxPuYBBU5MCGt8CdaO23/3cTWFMURrAmXPb5A9WtsWCs9gjpoGQA+UD+XWEHCppC9ghuUN4
 ZkDl/vyw6Z67g0pmJF85ejUzJuzNcHTgZSF2WBLTBu4myzoseHk8RP2O0PLa/EpSmMKyLBKdzLL
 YI7tEP3LYu0geEbrCNzqooGQuQCAFZJI4daoMdxqrP+Pan9B64vh0Eeo7+8Wcb6P1ffZ+7iBEt6
 hix35jZfSAGtEaBXPOTVpo4PsfKLCSpP9XAYN6wKrwnR0YulqJEEsyyp/iBhyM5l0mHLs7tWzMa
 vCftN1mGgoubCkMz2MKGxEFOCYVxMyUHUwq7vfAo/VNvvwQrPhPQlTX3G1sq744sZpy6hx+9D4p
 6njE5ZPrBu+s8wGm4oIwAPhTyrjqPMKWzsK4NMhx/vSV0RgfJBjHbvfLadsfFpZFKQBeDi2KlkA
 fZbNdg=
X-Received: by 2002:a05:6000:612:b0:43d:7403:4b65 with SMTP id
 ffacd0b85a97d-45003bf2d75mr289855f8f.6.1777921081580; 
 Mon, 04 May 2026 11:58:01 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4500f9c2cd5sm2861f8f.23.2026.05.04.11.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 11:58:01 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 04 May 2026 20:57:43 +0200
Subject: [PATCH v2 15/15] configs: add qcom_sm8650_defconfig and debug fragment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-b4-modernise-smem-v2-15-c01ec2ff3886@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1368;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=nJSqQlQgYIDyVV4sMBRSZ6oNXxk3DOKau1HlGQElwc0=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhswfb+TnBPS8nmiUGOKoJvGT6ddhX4EMl5WWL9n9pZpzI
 uUmvLzUUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACZyOJCRYavRQg6OLbN+7lcx
 /KAfYG14PXLeb5nWrTvMVGM7rh/3f8Twz/4723OnhWfWTXidy3Dr8ptry03XFMV1zvtyR9+Nm/F
 S7y8A
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

