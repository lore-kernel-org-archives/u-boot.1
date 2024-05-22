Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49093C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:32:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3718188507;
	Thu, 23 May 2024 01:31:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BIBJZaNS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E0B5884EA; Thu, 23 May 2024 01:31:42 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB4D1884EE
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:31:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3c74b27179dso4093959b6e.1
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420698; x=1717025498; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=udSgRUpFNyiKR51hBGxj2miB/YWXrjw6MgLLrb8ORc8=;
 b=BIBJZaNSuKQSZC69OrVmKmlTZaMwI3QZ2leS4SOmuxyrok8SS5Kz1Gq3Izobzh/ugb
 6kkX3AcAzPFR+3ITkEsRtrb0pxvu7yxVs9Pmn+uW/FXcerVm/k2W3/KVnZi5EHEuydEU
 OINLJ8s6pm2vvcUjfI/KDqQxl5vPOb59wPkUO7LkAMf4xB3zzjp71r3hpFOBhIKDPFAv
 z87RFZ5r3Qqws6fJLm1x0SXCdZz9Ap3e1hWXWqAdTLGwdqyJyBBbgdx3IjFPRHOygyZN
 l6AbnuN4MC6hIE+6t6o396JFt7tNDKU6Ab0rZRveWcJ9COFIFAY0dn6FmXZiB/5tH+Um
 L+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420698; x=1717025498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=udSgRUpFNyiKR51hBGxj2miB/YWXrjw6MgLLrb8ORc8=;
 b=XLMfls9mKMecJJLMCCOFOC0Y0m9dX6IRUr4RRzEfEACZGimWFTzRfNr3tsALaCxVGL
 q6M23fPyK46Xgui8rvCgL52YOnc/fzh+qZUExCRUg8WW1E3GSr4sIsbGTNM5yqR9FVrl
 MSn0S8ZyEjBHkrQnTHhj30zfKnkwkjaACkt6TPAWsJxeDUptEqM2WXdri26OYOW7kAvv
 OG09BEpuqc/oEz9WDthu6NMX25yU9ZnKNHS4wXY7c563XNQ8VCLNhWao2XSiz4hdeXyA
 B9yoUCduQTElz+vkvFOvOsqKnGfXZBoqiBxjd62apbHM7UBIkWxPKP2xARy0MIthZ5AI
 OpGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0ECvRKJEp+DooTj1KoK9+JhsCGoYAxerxhmT7beQj3H4QvAB814z5F7IkpSa+USkCG+Wm+2QODTFB9/3zRST32axMAA==
X-Gm-Message-State: AOJu0YyWPB1nfPVBirQADYyki8ucfbW9Ehg1HFhQq7gpidPHLbxyxIMK
 4uGCD6f30SjcRtTcR0fFqYZqp4mdxuPJYdEyDnM6RAGk+TuLMKAkeLBCN/TxoVA=
X-Google-Smtp-Source: AGHT+IH/++sEgsUf8qMDtTx9xuRzhs0PK3XBMCSs6/HaknUbnmenwPqCir3HhP4deH4IaQ4nVgy1xA==
X-Received: by 2002:a05:6808:171b:b0:3c9:6aea:ee5c with SMTP id
 5614622812f47-3cdb528d264mr4062008b6e.15.1716420698386; 
 Wed, 22 May 2024 16:31:38 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3cab0f3ea47sm1388635b6e.50.2024.05.22.16.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:31:38 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH 03/42] mmc: dw_mmc: Move struct idmac to dw_mmc.c
Date: Wed, 22 May 2024 18:30:56 -0500
Message-Id: <20240522233135.26835-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240522233135.26835-1-semen.protsenko@linaro.org>
References: <20240522233135.26835-1-semen.protsenko@linaro.org>
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
---
 drivers/mmc/dw_mmc.c | 7 +++++++
 include/dwmmc.h      | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index e6107c770fe3..9d668b3d8813 100644
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

