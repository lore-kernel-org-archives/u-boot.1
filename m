Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E40C67861
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 06:44:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E03C82C03;
	Fri,  6 Jun 2025 08:42:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qEuVyp/r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D29082B7C; Fri,  6 Jun 2025 08:42:37 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D74082B27
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 08:42:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a4fea34e07so1002555f8f.1
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 23:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749192154; x=1749796954; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TLRcqehQyeudcAfUgQyUPGb8hXSikCjgmrSVEgvIiSM=;
 b=qEuVyp/rrL726KYiRarLNvi9VXKO2Tt3Z5tR7WY4EMW0zDTQEIwWOSWPRLDnH+4qhR
 L0ZeZm4hAMjVEEVUBnMzLP5fS8a2IHymNILt3wCtGz3Rd4HegvS2wjdgHd6/+TdDkC46
 chHv3MIG/SQKlGzLYsIIGJAaFVO9mhg+6dLQx3oKF9n48utzulSSYJDwfr1p42fjZ5OE
 sZiQ8W7J4IzzUNDVUbUnKYfy3gUiujS+BzUufCz0SNaLTFFXt70abX9GqXEeFNp1Zftx
 o3JG1wG33vVFOJ3gFWRGik2pGc6O1ap3YbzupqLHPrNw5P4XWtmTOLM1imhIK9Rt1XCJ
 S05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749192154; x=1749796954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TLRcqehQyeudcAfUgQyUPGb8hXSikCjgmrSVEgvIiSM=;
 b=AsNkNIZXxRIF/tVMTHdFE8DRzJys3pwHay5ZlDPCnMumYUNR5Uyotvgi8v8nlhblwQ
 IPYM6zsO7QI0y204Rt3c3h0F0sbkwmRhSH2ZPlGgpwvtS0xG2LHxC4Qgzgxn4/yTxFZ/
 5aBfHwB1jTNxr0GPPk6bCi8G4qKV8rzr5bUFAvSSXcltunw9WTCJtrtxQeLjwfp5mYd6
 CBwLANCNJp2chByMjR5TT8p332vJM1klWEpO5nJrj+bdq2FxNG5q2awxWbTQJuQKJ/zE
 KroEb+19d+CoPEKneM18mwvK8jXHlbMowS7IhSEVDuqrAnzHltZ14NxAJIAJk+r8aqHI
 0lTA==
X-Gm-Message-State: AOJu0YyTozLmron40H0Y0PHVEQ6q7WOJYN68dcEBWydZjeACGNuEusDR
 1T5sO6G0Lgb4+iE/FpK+PNNgjZbXptVp0GkeLw8uCItYlmcheTur8hRl7NavK/vHwMCfaexXN6l
 7BTja
X-Gm-Gg: ASbGncu+RBe1RdvycvTX8i2oTdF+FQLihwawzZ0db0zujx1/GOSXksoQiAlneNOJ6Jw
 6fxPLmAOC3sfjgdXJ5RddDHrGrBc+Su2jz0hpO3mk2QK1OIyztDRE0tmrjCQPaIH6zR9fjXVTyS
 Sn8CncNgDEasZuKQqWQWERQthckbMyT/4319apapV49Em39hSdr9hYP+91K5Cg6LFY+N7kfhXlt
 FUR7ZINrbu4YCPuIf5L6djPURygSeYQp716GEzooVF7tHYs5W5m4bERuHL62we9dnqOtGiLfV96
 rk99dM7y4hacb3hjD72VwpzaXe8LBz5MPEMokhULWrk1IfmXKb6V4B5T8euj07oOP/KXtR8=
X-Google-Smtp-Source: AGHT+IG2yFNGZamGxCfwc52pDobGV7hOQRmj2iO1KTepfXkKV6PM725ryfMS3ptBZB36QzbU4x7QrQ==
X-Received: by 2002:a05:6000:4013:b0:3a4:edf5:b942 with SMTP id
 ffacd0b85a97d-3a531cc1aaemr1838455f8f.57.1749192154428; 
 Thu, 05 Jun 2025 23:42:34 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244d10asm994627f8f.67.2025.06.05.23.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 23:42:34 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH v2 13/13] configs: qemu_arm64_lwip_defconfig: enable CMD_SNTP
Date: Fri,  6 Jun 2025 08:41:49 +0200
Message-ID: <20250606064211.3091237-14-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250606064211.3091237-1-jerome.forissier@linaro.org>
References: <20250606064211.3091237-1-jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Enable the sntp command by default in the arm64 QEMU defconfig for lwIP
since this config is meant to have all the features supported by lwIP.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>

---

(no changes since v1)

 configs/qemu_arm64_lwip_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
index 814e98729a3..e8f976efaf7 100644
--- a/configs/qemu_arm64_lwip_defconfig
+++ b/configs/qemu_arm64_lwip_defconfig
@@ -5,6 +5,7 @@ CONFIG_ARCH_QEMU=y
 
 CONFIG_NET_LWIP=y
 CONFIG_CMD_DNS=y
+CONFIG_CMD_SNTP=y
 CONFIG_CMD_WGET=y
 CONFIG_EFI_HTTP_BOOT=y
 CONFIG_WGET_HTTPS=y
-- 
2.43.0

