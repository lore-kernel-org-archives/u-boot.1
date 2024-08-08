Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7BEC52D6F
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 03:15:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30E6088A6B;
	Thu,  8 Aug 2024 05:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FItZnmWa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5890088A3D; Thu,  8 Aug 2024 05:14:52 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3925E8873C
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 05:14:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5d5bb2ac2ddso278220eaf.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 20:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723086886; x=1723691686; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hrwQjBQeS/IHACiLnA4C0sWPJ+Ss5JUUFTvp1h8efso=;
 b=FItZnmWacdDeivG/PIE9qJTDbJ0Lk/8yOZ0NwYvJ4ToN6kABIEsDAEwt7cgywDubXq
 1XFwQVWtcYb2Ba3FAdEu2CZ3uTyb7k13tFEiLpfij4DBtdQTxTr8+HOy0fHAOpHX58T1
 k46/+TeartoIp74/adJBjPSXoX3d8Z/7NiTTPUWGpQ3tSrrP320tlpuMIYNNQjUd0FZH
 hQeAqYVO1YkMdSlzSWoeZ3MJ9693RKGqnoDtQLPvA7dEnEyi1RyRCjknal/8iEswvZzX
 jQQIN5LwBfaXh2pZC479WFnoBIZot9tKmsY2fkTRYPF2rT5vwrl5+EdaNkhiZr5zCdNd
 SW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723086886; x=1723691686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hrwQjBQeS/IHACiLnA4C0sWPJ+Ss5JUUFTvp1h8efso=;
 b=EKjNcJYzLxAGOclT4XnLLUq1EaAehnzwbezKyE6pa301sSQwyuTwHDS/kTroefTskz
 uo+xMg5Rv5vG1Tz+Fytpoufh4aTzlwHfp/xo8UIGkk9bvOQkPauMCW4AKfLR3jDQEmTn
 IcJ6U+CuAG1wE4S5tXPfm8AeKBhlfZssVN19VhDJaLnoojqgMmVjPOpwhDWCE8tycmqC
 OreLYX4gMoGLdAtTmlmlLdJCV0InIvhDlRF+b11xpazbHNqpoqKcX/mVeHjKbPMX/kcS
 wPZdsi3QQBjCltZFbAWKwFrcE2d4jzES2i6J3kEI9EQFOSupg1ewc6zEzmNhDDfppwrw
 C7mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBx66/nMkeSQnKunI+iUXe5MAP88cBPOxj+bzrNdiLgKZwLCJ7FSYbuXX+VXfrV5cNoF7N4WEvRvpvJF9Rp1Sut60MFQ==
X-Gm-Message-State: AOJu0YwLVPdBGS5KoAGDaAxmN1S/SNfsUaBOtkPQWpEeId1RJpfSf9JQ
 tOmw+wsIMeBdtMMLumxTcQrSBF6kSE1LSq8dproagjFnfglU1H2MH/G/R2X5Zjc=
X-Google-Smtp-Source: AGHT+IFLMNa+8sIdSS73aoPP7nlo6zOInr2bOpXy98xL99vpBZL8nqTVe681jXE51vbF7CDVRHEHzg==
X-Received: by 2002:a4a:b3ca:0:b0:5d5:d5e9:4e38 with SMTP id
 006d021491bc7-5d85737a6b9mr150750eaf.2.1723086885968; 
 Wed, 07 Aug 2024 20:14:45 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d76205268csm3485055eaf.24.2024.08.07.20.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 20:14:45 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <promsoft@gmail.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>, Henrik Grimler <henrik@grimler.se>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v5 01/38] mmc: dw_mmc: Remove unused version field from struct
 dwmci_host
Date: Wed,  7 Aug 2024 22:14:07 -0500
Message-Id: <20240808031444.9619-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240808031444.9619-1-semen.protsenko@linaro.org>
References: <20240808031444.9619-1-semen.protsenko@linaro.org>
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
Changes in v5:
  - (none)

Changes in v4:
  - (none)

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

