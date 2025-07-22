Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF63C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 15:36:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEE56838A5;
	Tue, 22 Jul 2025 17:35:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="q/ZltqPQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E07FC8359F; Tue, 22 Jul 2025 17:35:16 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE5B9833DB
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 17:35:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3b5e6bfb427so3063994f8f.2
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 08:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753198514; x=1753803314; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=p/2XzchXvZNmpkro8kvXmizSps/fF7mffp2BWQGMFzc=;
 b=q/ZltqPQJPMgH7Qd3lM5m7MuKXVlRO2DIS9GjEzKjoZ9+4oh4j7wh/s4RpaUmhSJGM
 tjYE1Pu3lw6fp7384OIl9N2f7v0ybaeHK8xvOwlMktlfScSLQ/HK6Ts7fx7H3wjCNSy8
 oJjRMMO8pfEHozuQ91YnkTRL71cFu22VhfQ0zvxVJB1DDGQXNYxyNomFjc5BA2ReMgAY
 0OddLhpjqLCWfYfnpl5q3BvdiEzszSIaGWHPyg7/EwHrGd6RfON5F3IM1zqtyvgvShX/
 KM7uIsc+xxta+rw9PXXVZ0IanvB9lsuhRNeLCVZyFcOpmJH2JnECxT6bO+s1WyFo6v7z
 F6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753198514; x=1753803314;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p/2XzchXvZNmpkro8kvXmizSps/fF7mffp2BWQGMFzc=;
 b=a1Eh1c8oHq6eZYju9KThf/Gce0m+nAuWNJbuvTdjykeZS3TMBoZ4GE7kLma8c2Ba/x
 0mOxOjuHk7iE0LFYGs+Fb8iuTLp3un/572Ucke2BJjBfoDDENXLCorhDxsiWRXLRZURu
 LCuPZFOCLp8u0bYVccIXTwy9vr4YT3bpSIlvFRoWizckt+1HmNzLFTU6h5/hY1IN/lxq
 KycAlK0Zn0Cr+CiOZP2EKGvdGQPnPKgVxJGlMCT2CPk1mjoftfQKhZPL/sxOtn9OgxVs
 aWuyplMUmJXuuScIt7sJHiGhg7X9XE5hl35uwSj6QSKfHWOMMCxKHL0s/Pr88m6AzDBX
 fk7w==
X-Gm-Message-State: AOJu0YzPQMGqfdPBYvgm0qxCPzFVZl/t1hWtveKmm2jG2ETUDA7j2DNa
 7nJAmEI8lvti2rh2m7zOGYznHf76pUXJeCy2eKPqpb+X/V/3gictjkvSP7XoiGY1dLc=
X-Gm-Gg: ASbGncvvK12KMhYWcniG0M8ulThqsWCYm9tFj7JNUUjgEPCQ536O3WaOEtnuF2j2MQq
 1bk5TCiEWPfKZQvZJRJZIqjKJ3eWg3w/ON1xxnZtUXSCQ2O4PDvcSpnN3ujvgwWaOW8Qc8tEuFK
 ES3AjXHpAL/yWXwtsAAkQlaBdWY/1XwjMA5MZq2iXkvgCQ8LeITxejraZ+RycC05X0qU2MlQIGZ
 6QDHJKneMZoWL/wjecyX+oAx4Yv4IH93WKSSGphzoikJqYzPYt5sWJCKWmwXcTW4905Ak+9meSJ
 pjI250i61FngINGamWjPne1zpB02bWxJrIPjWHEtN7ljt7KuUcG58sqwwPxMJHsgUQNI6hBLGbo
 bIHITFq2ZhVFY1HMwiKsoovJ1d5nh5qZJ3hzCh7r8npq4m55TAU6WEi9X8cLyy74t/HY+J2onM8
 QA
X-Google-Smtp-Source: AGHT+IFEOKLEQW0ROBlf3PcQoMcG4qKK4UlYFCTOh2zAjrrdZpscE94MH28SwtE9Mgj/WVsFaGYWRg==
X-Received: by 2002:a05:6000:5c7:b0:3a5:7944:c9b with SMTP id
 ffacd0b85a97d-3b61b0f0b18mr13224532f8f.16.1753198514304; 
 Tue, 22 Jul 2025 08:35:14 -0700 (PDT)
Received: from lion.localdomain (p549d4bd0.dip0.t-ipconnect.de.
 [84.157.75.208]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e886286sm198716285e9.26.2025.07.22.08.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 08:35:13 -0700 (PDT)
From: Casey Connolly <caleb.connolly@linaro.org>
Date: Tue, 22 Jul 2025 17:34:56 +0200
Subject: [PATCH v5 6/8] configs: qualcomm: use fragments for debug UART
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-b4-qcom-tooling-improvements-v5-6-df143f1247fc@linaro.org>
References: <20250722-b4-qcom-tooling-improvements-v5-0-df143f1247fc@linaro.org>
In-Reply-To: <20250722-b4-qcom-tooling-improvements-v5-0-df143f1247fc@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2434;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=JpUkLI9LMV7S7obvX76v6VTIfRnan1BIe3Wa9HP6qXY=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhoz69Svu/TtZF+x79kpVepvI3lKdow0hRZzhX59OF/qYZ
 hpVJKLWUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACbS946Rof1A/u4H3S4nK/cW
 6gmmL5rC+N2SPa83tVBcTfjX+9T3NQz/E1cdy2HW335qUvmDKe2+m066yF86u5ozVZGLad/fT5s
 37gMA
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

From: Casey Connolly <casey.connolly@linaro.org>

The QCM6490 and QCS9100 targets always enable debug UART, but this is
not really optimal for typical users.

Move these debug UART options to config fragments so that they aren't
enabled by default.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 board/qualcomm/debug-qcm6490.config | 5 +++++
 board/qualcomm/debug-qcs9100.config | 5 +++++
 configs/qcm6490_defconfig           | 6 ------
 configs/qcs9100_defconfig           | 6 ------
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/board/qualcomm/debug-qcm6490.config b/board/qualcomm/debug-qcm6490.config
new file mode 100644
index 000000000000..9ea54758794e
--- /dev/null
+++ b/board/qualcomm/debug-qcm6490.config
@@ -0,0 +1,5 @@
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_BASE=0x994000
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_CLOCK=14745600
diff --git a/board/qualcomm/debug-qcs9100.config b/board/qualcomm/debug-qcs9100.config
new file mode 100644
index 000000000000..8ca042b440d1
--- /dev/null
+++ b/board/qualcomm/debug-qcs9100.config
@@ -0,0 +1,5 @@
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_BASE=0xA8C000
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_CLOCK=14745600
diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
index 5ddc5ab3ef8c..54eb5dedaecb 100644
--- a/configs/qcm6490_defconfig
+++ b/configs/qcm6490_defconfig
@@ -7,14 +7,8 @@
 
 # Otherwise buildman thinks this isn't an ARM platform
 CONFIG_ARM=y
 
-CONFIG_DEBUG_UART=y
-CONFIG_DEBUG_UART_ANNOUNCE=y
-CONFIG_DEBUG_UART_BASE=0x994000
-CONFIG_DEBUG_UART_MSM_GENI=y
-CONFIG_DEBUG_UART_CLOCK=14745600
-
 # Address where U-Boot will be loaded
 CONFIG_TEXT_BASE=0x9fc00000
 CONFIG_REMAKE_ELF=y
 
diff --git a/configs/qcs9100_defconfig b/configs/qcs9100_defconfig
index cd48973599b5..216dfa3211ec 100644
--- a/configs/qcs9100_defconfig
+++ b/configs/qcs9100_defconfig
@@ -4,14 +4,8 @@
 # a dedicated "uefi" partition for edk2/U-Boot)
 
 #include "qcom_defconfig"
 
-CONFIG_DEBUG_UART=y
-CONFIG_DEBUG_UART_ANNOUNCE=y
-CONFIG_DEBUG_UART_BASE=0xA8C000
-CONFIG_DEBUG_UART_MSM_GENI=y
-CONFIG_DEBUG_UART_CLOCK=14745600
-
 # Address where U-Boot will be loaded
 CONFIG_TEXT_BASE=0xaf000000
 CONFIG_REMAKE_ELF=y
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs9100-ride-r3"

-- 
2.50.1

