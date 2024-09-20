Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E63CCF58E0
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:27:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 820F089404;
	Fri, 20 Sep 2024 09:25:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jIjWoN9r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1062C893FE; Fri, 20 Sep 2024 09:25:26 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BDA3893F8
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42cae6bb895so15877555e9.1
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 00:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726817123; x=1727421923; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d29BkdPrvKyzClMPjptVHKsxAbJLRmzXt9pDDl85+4M=;
 b=jIjWoN9reECLHS4vtXETQMfQGlZ21mc+V3Jdd9pXiOBXJrjtjXgcY5X9ERjiuLYpZX
 gbJef33V3xuuytbm1Q/I8zfhyNHVL+3QR0K1rHWF9xv+lVcGR//X7VcmETudMsiwnPG3
 Bd+JafYE+NXjZCzAUzB15NlziVkm5ACpMG/t0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726817123; x=1727421923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d29BkdPrvKyzClMPjptVHKsxAbJLRmzXt9pDDl85+4M=;
 b=jXhhV0O2FNEcv1tAuhNWSgtdw61uC2RSiqhqz9AAQ3tpKY63eI9LiiZ4eSHZgEfXEk
 3m4ctZlCKcWPefBOU7A4cYXEoD0zpgP88ZpNYLlB+h7M8vQwbtfzqBTJXJI0ZlM9Fki1
 Mjtlaqpjx65CAYMLlGepkvMTXhLa02H1C05lK28FlP+IGGFG33a2Wu2ElLwdc/pP5Bo9
 t7Xhzb+qbEDJbeGQLIAbQp8U6kGIRul9sGOA/CMB4a0diZEAaeBYvTMMkc5aGEQvhreN
 qAuH5cmoE95hDr4k7dNDijkfPllxghBjhP9RwAP7/6Bmpo5+tkgkY8C/QwCWWPp+7eCJ
 MuKA==
X-Gm-Message-State: AOJu0YylJ2TZhe86bw8Z1i+bnO/ZBwpBE8ON8KVeZjx2t54AlIs91yPX
 uSzCI/OBz7hzdqJ8vztw5Jc3m8zEEPSPQSmKk17avNYrJrKw+WJ3md6slUlbimXD6uPE6czbEUF
 vEeZO
X-Google-Smtp-Source: AGHT+IEV+Vgcf766VSkRZ4+ksyvgo+QrLaBiE1YGCDrjk5+QV+i/htWsFylE+AtNoYxdEJegiqsC6Q==
X-Received: by 2002:a5d:6251:0:b0:367:8ff5:5858 with SMTP id
 ffacd0b85a97d-37a431be8a3mr777436f8f.56.1726817123234; 
 Fri, 20 Sep 2024 00:25:23 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e7540e32fsm41504535e9.9.2024.09.20.00.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 00:25:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>
Subject: [PATCH v2 18/18] rockchip: Provided SPL control over efuse presence
Date: Fri, 20 Sep 2024 09:24:42 +0200
Message-ID: <20240920072444.134997-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920072444.134997-1-sjg@chromium.org>
References: <20240920072444.134997-1-sjg@chromium.org>
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

This driver should not generally be present in SPL, even if misc devices
are enabled. Update the Makefile rule accordingly.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/misc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e53d52c47b3..ff984d7b191 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -68,7 +68,7 @@ obj-$(CONFIG_QFW_MMIO) += qfw_mmio.o
 obj-$(CONFIG_QFW_SMBIOS) += qfw_smbios.o
 obj-$(CONFIG_SANDBOX) += qfw_sandbox.o
 endif
-obj-$(CONFIG_ROCKCHIP_EFUSE) += rockchip-efuse.o
+obj-$(CONFIG_$(SPL_TPL_)ROCKCHIP_EFUSE) += rockchip-efuse.o
 obj-$(CONFIG_ROCKCHIP_OTP) += rockchip-otp.o
 obj-$(CONFIG_$(SPL_TPL_)ROCKCHIP_IODOMAIN) += rockchip-io-domain.o
 obj-$(CONFIG_SANDBOX) += syscon_sandbox.o misc_sandbox.o
-- 
2.43.0

