Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 468F9C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 17:57:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1574884BE;
	Mon, 22 Jul 2024 19:57:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pGqZ6AhO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B23387E30; Mon, 22 Jul 2024 19:57:45 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FF4288005
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3d93147ac6bso2630897b6e.0
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671062; x=1722275862; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NSBVy9oWXcI2pI2rEMN0Pvt5bavsExjgOlPx2QiKQJk=;
 b=pGqZ6AhOTNS7JsV3bd08DbT6P805ZVWHYb+b5wJCWk5wGjuP3JBeTGAo/6WGl6ubE9
 j8KnS+LcUr+0g2EP9Pssd2V/JHSBt2A2/6wuq1/1bu55Ttn6V7D+ORu4VLZxpjTQCgQD
 ngFao48FNeHKlY/O3ehPuvCoOmQSTpBx8PZ1/7LtKE0UzeQfsx0KrQZF3umQdTpAOmlC
 rjeHnD5TZwI+MOdlOsl9JL5s/Dei8cfooLFOFrISykT1/mzL/BgNa8OF9HcGzNDeE4dW
 riFKYHn2ghYptC5ZD6a0WhZFkpCko+o4vHjM/A3D0oiZV6LtVLslit83B4rinov/FRrf
 s/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671062; x=1722275862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NSBVy9oWXcI2pI2rEMN0Pvt5bavsExjgOlPx2QiKQJk=;
 b=rx0zIaYs71eAJ62vMApUm5gcf0m/Y6olgC8L6ItwIx4dIvxKMrmu7vj894hq59DqAr
 DfvrHU+21EBnPBhcQiyJ5T6SpIWtZ9VhlumC+apDZDsnYY+SipwWy54OC/x+3RTHl5RT
 QxEko7P/B95aW1ETutPhM1A5SdlnODaPytSUw9xuhsyOjMBQRLjUU5NMg3/hFnqmNrxt
 JJwyFRod7Hcxl8j5YO6xlXJpDnOyYzSOUTwBFEd6AJ2txxp7hkVePb+/EQRChd3A9U2i
 ullb+rHyRTpopvckqwAS/YTYOTPy/p4OEZ1MpP3XP11uv/quUvpAMx9qQ4CH1qfrKwBe
 d5tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuHBCUpIaPXJAuyGgegwIT9ot4qetzv5tlfV6YMiaNo2uFgGkJdoQAX43K5s1rThNJKLzERXJQco8ltE/52ZVW0vzPrw==
X-Gm-Message-State: AOJu0YyOUK3ubV/GXHWuOXRz2+0Cnqw72Gw6PDwnOr584SPaUpwkz4Ke
 j3dYfPXD4dDp008lJCvgDLdOUE1+F1l+xjDdIT8sMBU/D5AMMSvAF4NQfUWlrEI=
X-Google-Smtp-Source: AGHT+IEpVc8kkG6zgJhgXVd3j2emQqx2x2shzBX6MUxuBaHZf8BH+SZ7mIto/qrAWjvpgJnAiPmMgA==
X-Received: by 2002:a05:6808:23d0:b0:3d9:4163:654f with SMTP id
 5614622812f47-3dae97fad21mr9094454b6e.32.1721671061960; 
 Mon, 22 Jul 2024 10:57:41 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dae09cef7asm1614286b6e.42.2024.07.22.10.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:57:41 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>,
	Minkyu Kang <promsoft@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v3 01/38] mmc: dw_mmc: Remove unused version field from struct
 dwmci_host
Date: Mon, 22 Jul 2024 12:57:03 -0500
Message-Id: <20240722175740.6985-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240722175740.6985-1-semen.protsenko@linaro.org>
References: <20240722175740.6985-1-semen.protsenko@linaro.org>
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

Nobody seems to use it, so just remove it.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v3:
  - (none)

Changes in v2:
  - Added R-b tag from Quentin

 include/dwmmc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/dwmmc.h b/include/dwmmc.h
index 136a95b8cdb6..39024fb38aaa 100644
--- a/include/dwmmc.h
+++ b/include/dwmmc.h
@@ -163,7 +163,6 @@ struct dwmci_host {
 	void *ioaddr;
 	unsigned int quirks;
 	unsigned int caps;
-	unsigned int version;
 	unsigned int clock;
 	unsigned int bus_hz;
 	unsigned int div;
-- 
2.39.2

