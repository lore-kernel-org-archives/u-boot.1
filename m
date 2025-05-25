Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF580C54E90
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 10:50:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0172782D06;
	Sun, 25 May 2025 12:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cWtbEoVF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CAF183666; Sun, 25 May 2025 12:48:29 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E43782BF3
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 12:48:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a37a243388so1479433f8f.1
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 03:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748170106; x=1748774906; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eptQtbT7MAKnu7LwM0Nr9afPIDiBUCWwjgdivV5kedE=;
 b=cWtbEoVF/RrK+pkXzURL4g481duuhKdOyue9fOTM7pABIEc33ec1kYLpZI2EYyrSdy
 ngHW4UWcqwEwkdO3067429dWDD4LD/bU+Kc6CZfkboG7Z7upadXosIbrWcVgmXZbC2al
 DCg4zlpdXyDqC2YoGjbPbigJu7MStPGOFlC8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748170106; x=1748774906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eptQtbT7MAKnu7LwM0Nr9afPIDiBUCWwjgdivV5kedE=;
 b=eJegMOpD4f9sf9T10xio7nzm7o/vNjoffzmMcavsEkgvKCnhVItTMoH216ciyXQJOm
 y2EsJZpO1Nn4+3Nw9x1QE6AdblKpNW0A+cCSv0N7uoBI7muKgpd/dENgDHIIyZFNaLiu
 IH/deMbUzthDREMi/yMXG0n5L8Y/jtqMoDPLkDdT104habVRFHXun5awx3jHkB2v04uZ
 MevkIyiLjYlEF6UP6fhHBJVaXr1BiufJyuZMB3SdErZZ63fWdoUY1XM44oL2ksvlpDOT
 M47SzpoWbT/HjY8bLSxsIPzNlVxGKJtK79ht1nxhUOhhpyPipWCb5DXUE/mOnpunyi24
 22ww==
X-Gm-Message-State: AOJu0Yynq/L/nW/K6E7JEt5pY+gv0V2TkMEj33t0S62ihBDTDXYJL7I7
 vTKIeaM/aEQnfN3F6dLfZuTX3c5xdgJRZ97X8UFBtXjXSG2MahZUlLq1chrckQbPfPhgOBrQogB
 2bp+XPFKe
X-Gm-Gg: ASbGncv4kd9WLydD6VYUd4DWoUNpG3pvG2Y/uZok086SujbwYjuLHFtbP2S8XScC8ty
 0B/4GLZh9UOwPj0+qzZe/YTcYpRgQySZasN+/hUVWFlxCoys8CB+z7LLQS+4oPfwETVmOOPj2BH
 tFvD2OLqXWxGXJXz9mAMzUGS9UgfFDUknusRHahgvGNLHQDyNLQ/W3J+sMyLMgTOggz1NzAUpn0
 AbbpNcnrsmeco8vHltPg0HZlwiGxcl1cfYnD7gDAv+fASp6YeN7bnEsTA91WQ8RayC/p2HDHqYi
 nHixtBFSbOTYpZyoHUs2Wdpz3rS39/RfqYyOYqc69mRvwI+ThSn7yMQ/Xu8cJm4kUuO7mxU=
X-Google-Smtp-Source: AGHT+IGkn8ubKJQ2LxXFMahCwuVfNrXJIBsUhvEyQ0lLNNzDAbRuC2PmG9Imvmci9TrisESp5oRRcQ==
X-Received: by 2002:adf:f0cc:0:b0:3a4:d02e:84ac with SMTP id
 ffacd0b85a97d-3a4d02e8731mr2377936f8f.13.1748170106561; 
 Sun, 25 May 2025 03:48:26 -0700 (PDT)
Received: from tasman.. (host-80-43-238-15.as13285.net. [80.43.238.15])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cb450867sm5045047f8f.57.2025.05.25.03.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 03:48:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v4 12/25] rockchip: Update rk3399 bootph-tags for VPL
Date: Sun, 25 May 2025 11:47:48 +0100
Message-Id: <20250525104801.1440260-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250525104801.1440260-1-sjg@chromium.org>
References: <20250525104801.1440260-1-sjg@chromium.org>
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

When VPL is in use, memory init happens in SPL, so there is no need to
include the DMC device before that. Adjust the tags to save space.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Only enable MMC when VPM is in use.

 arch/arm/dts/rk3399-u-boot.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
index 587eef9504e..c0e51a9626c 100644
--- a/arch/arm/dts/rk3399-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-u-boot.dtsi
@@ -46,7 +46,12 @@
 	       0x0 0xffa88800 0x0 0x1800
 	       0x0 0xffa8a000 0x0 0x2000
 	       0x0 0xffa8c000 0x0 0x1000>;
-	bootph-all;
+#ifdef CONFIG_VPL
+		bootph-pre-ram;
+		bootph-some-ram;
+#else
+		bootph-all;
+#endif
 	status = "okay";
 };
 
@@ -93,6 +98,10 @@
 };
 
 &sdmmc {
+#ifdef CONFIG_VPL
+	bootph-pre-sram;
+	bootph-verify;
+#endif
 	bootph-pre-ram;
 	bootph-some-ram;
 
-- 
2.34.1

