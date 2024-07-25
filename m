Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40D8C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:45:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E74C58842C;
	Thu, 25 Jul 2024 22:45:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="W3gS8CO+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD63288365; Thu, 25 Jul 2024 22:45:26 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21CE888370
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5d5af7ae388so130898eaf.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940323; x=1722545123; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=epxP9uFws1EL9nsnErzdeDit6llhPxNdDYaSskV6G/g=;
 b=W3gS8CO+wg9EnnOqnowry7yN+XRcj2YOND6Uk23K9fxu0mg0lNT4WMDcWWSMkDBGa1
 58e5p5gy/wn524CqQeNZ9e6Q0APrgTIymW8WFs6Kc3BMN1oF8TTJmAl9RP1phc3wV9c2
 ldoNSpiDKXivgQZpns3PAUQBsZ60gXee02tDqjBYv/yFjwk2zwuH6g+IBknEhIR3/ibW
 fcJnJdNUzxIc4Mk7h6P6HB8wWP0kdL0g5hKwIhSYKZhX/ZVKYHzn2DuzNRIpLhdL87V/
 c0tISG+czwyhnzFbTTSPa+AYaZw2jJo1E8JhYBwQSRkGiSW8sm3cVGwXLdEzxGLOGX0a
 Z14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940323; x=1722545123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=epxP9uFws1EL9nsnErzdeDit6llhPxNdDYaSskV6G/g=;
 b=ZP9uY0bd9K7kTkGRg0EMfD9pQLt2l6kmKoboGAza+NGiezT0XXN1qo/bCaoTgnVCH9
 aoWYrHJdI9ssCzQ1G1L168sMtB6sLSBGU079iChbeVwEnDtB56qgmoORAQWAmtFIcgpF
 h/4JdDMVBrNK0ajY2gx5t7ZuyYPdWYcS1xLfu1qaWYu2+bCEJbduKHNJr9iVhDwbU0yP
 /jJXycLcDV8GgIdjYuWR6ptQQEb4I09ofmWukr8yzMiufTr8ilai/BNPhwWknuQ5xz/C
 W9+98pxMbKaNC3PRJlhRPO9WfV/lY+z9Fu7qMGCAnD7GQgoaXByMsEmV/7BeReH2dfWg
 +wsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8yWuLidkgULsq3BeNT/mvTfHgH8RZtutUyVKWckx1vyFq66oXYjEqA2VAtmOxvBaXPIoDyPs2Cq6lXD50jULUc/uTTA==
X-Gm-Message-State: AOJu0YwnzYoqWnMrglojcKM0faYWOIJYxerzBhKNekJCzFaICKU1iTMY
 6vuzZleab1ZSJMHSGDjSuIEFRYkDCLhWqqN+5Xt52rd3VRgFbs4QxGFJOr4LkeU=
X-Google-Smtp-Source: AGHT+IFoeC7zQYTlg1eHVXN1CKKBmCFgtc7JSgyrNq2ShqkP7XWvbsX+5HLMj8BUdcJnIAogcnaaWA==
X-Received: by 2002:a05:6870:289b:b0:25e:ba6f:a93f with SMTP id
 586e51a60fabf-2648e8d17a1mr3563888fac.13.1721940322841; 
 Thu, 25 Jul 2024 13:45:22 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70930795a43sm457531a34.80.2024.07.25.13.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:22 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Minkyu Kang <promsoft@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v4 02/38] mmc: dw_mmc: Move struct idmac to dw_mmc.c
Date: Thu, 25 Jul 2024 15:44:44 -0500
Message-Id: <20240725204520.18134-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240725204520.18134-1-semen.protsenko@linaro.org>
References: <20240725204520.18134-1-semen.protsenko@linaro.org>
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

struct idmac is only used in dw_mmc.c, so move it there from dwmmc.h to
avoid cluttering the interface in the header.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v4:
  - (none)

Changes in v3:
  - (none)

Changes in v2:
  - Added R-b tag from Quentin

 drivers/mmc/dw_mmc.c | 7 +++++++
 include/dwmmc.h      | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index f4ecd7422cef..45665e517068 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -20,6 +20,13 @@
 
 #define PAGE_SIZE 4096
 
+struct dwmci_idmac {
+	u32 flags;
+	u32 cnt;
+	u32 addr;
+	u32 next_addr;
+} __aligned(ARCH_DMA_MINALIGN);
+
 static int dwmci_wait_reset(struct dwmci_host *host, u32 value)
 {
 	unsigned long timeout = 1000;
diff --git a/include/dwmmc.h b/include/dwmmc.h
index 39024fb38aaa..7e4acf096dce 100644
--- a/include/dwmmc.h
+++ b/include/dwmmc.h
@@ -198,13 +198,6 @@ struct dwmci_host {
 	bool fifo_mode;
 };
 
-struct dwmci_idmac {
-	u32 flags;
-	u32 cnt;
-	u32 addr;
-	u32 next_addr;
-} __aligned(ARCH_DMA_MINALIGN);
-
 static inline void dwmci_writel(struct dwmci_host *host, int reg, u32 val)
 {
 	writel(val, host->ioaddr + reg);
-- 
2.39.2

