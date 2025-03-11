Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F92FC282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:14:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92839818C7;
	Tue, 11 Mar 2025 14:13:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oq85NIf0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84D1F8186D; Tue, 11 Mar 2025 11:33:15 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6DC680FB9
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 11:33:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aaeec07b705so830131666b.2
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 03:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741689186; x=1742293986;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1aUQGD3F4JC+u5fcG8nKZhXgqEasD0lEiK0bE40ccEY=;
 b=oq85NIf0J9xNJ/yuS2gApiVhhYq34Ad8YE4bnmUFNuh+RMKxIm/ZZujJBxVhZbIG28
 m5EQIVBDCqRa4DTAWauppI8BumUkPwGfYCq0Nz8dq7FmE1IBwbX7tHQBmFg9LH5/lH50
 lkmeBUx/Lp/JwSWXhfbjf6MCApPR3t8pgQ6BfwX21T4NrYPOWmd5UvC3Z4mwgf+GmZJz
 MPYxsdeaokxrilHw6D7YUoM/k/ILyEsSBqg7aBGRkOjdBgB3iBFDFSG2sHEg4w7PZGz1
 CSZnYIW67Qnigm+PWF1fUgH8iRJaIUUNhLrcfE/N1ErG1D3N6oeYePD2S2gInzv2clh7
 nDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741689186; x=1742293986;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1aUQGD3F4JC+u5fcG8nKZhXgqEasD0lEiK0bE40ccEY=;
 b=DNB56EUI5sgtw6zxBZ7b4UsRBMt2OwvF0efkpoHGWkJh7cmLSY79obeWWA74lhLiVM
 6oh3d6QmbfMNawcwz03mGXXUZrJYkz7FHXsX5CwoS0cuEtFj4NtS4Mkt9ey6LZtwHdYs
 06cYxZt4nPWNiO0Oa85kPCgoXVauEirQjgXUki5HX6ZIrMilbN1iEBgj8Vg+lgZlNhX5
 Kp1mCNAwz+xakGpLwlcQoyBgKMM0cOrrfMZwpIa8uFz55ZwZVg/Y6N4F9aMskp5yz1pz
 rT79X+JcNBd0O05FW5eoHizF7jF81ULIxEZaeM2shiEwQRo+WmOHs6jkGEq89jhMLm/9
 XzwQ==
X-Gm-Message-State: AOJu0Yyv2jOkqni9MpSPP13sZMnDuG1UZoyxvG34sX6dFPM1eoOo3TF2
 VqxVeCSnwP8EeWegjZ2sYhxdZS4hYZuONypTPqroF5abdOQFTYcMZ6gw08Nv/lZPUL3XZwsBReG
 n
X-Gm-Gg: ASbGncuQ9GPPvlSPGqTtw2PA3L8eC0EOTI5SPEYxILPd1Rv2l+eIOXrbl+A92MAbgtF
 O+IyCGYo7wvt/pLOQcqbJoDBBgB++hacnbbPGC0pPbPYfvCsaFysf1cN9EZnMV6GfiGKufYu6DP
 7IoGZD8Zn5VfhULlUW4axQUa92tkErUO64YQyCwKOQgwiGNK2bIdRkdu8Woii3tiYCkqcP+ohjt
 +MOtWZ+rdgB9nCOFlbZywc2u5W5dH9hU7zhj430n8G3hHdI8ctfLcGG3NUnbm2v5eCfIlFmsN1S
 7gccVTpd77NuYbbjaoQ73HCQDQ2vXzhFqy0YBeWh
X-Google-Smtp-Source: AGHT+IEQkVJJ/pcWgNfojsXQbBahLwhTqH/vBqHA0PBV7uWpJWqlSI3Spr10fUVWUJtTyYB+KtSQcQ==
X-Received: by 2002:a17:907:158a:b0:ac2:9683:ad25 with SMTP id
 a640c23a62f3a-ac2b9e22499mr311178866b.34.1741689186122; 
 Tue, 11 Mar 2025 03:33:06 -0700 (PDT)
Received: from localhost ([2001:4090:a247:83e0:938:b3cb:2c1b:889c])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-ac2b184a442sm185193066b.103.2025.03.11.03.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 03:33:05 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 11 Mar 2025 11:30:57 +0100
Subject: [PATCH 18/19] configs: am62ax_evm_r5: Enable IODDR resume support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-18-666de9c105cb@baylibre.com>
References: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
In-Reply-To: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=624; i=msp@baylibre.com;
 h=from:subject:message-id; bh=YYK07KrSGF63V9fGDQEEhFTdJY92mwazKGNFBWdQ4So=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNIvCLr8d/Z7weLmfumwW7Zn6vcvUg/1zC4cK5y17/HmN
 9c7auwVO0pZGMQ4GGTFFFnuflj4rk7u+oKIdY8cYeawMoEMYeDiFICJdNUw/Pf5qXahO/2l4qL+
 3C8MzxSz3+Ry2P+eFSdcumR6de+TRcsY/ukUPLHv67mskbWshHk60262yU1fL3XWeU1d9ewC6zq
 FY1wA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 11 Mar 2025 14:13:18 +0100
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

Enable K3_IODDR to enable support to resume from DDR after exiting
IO+DDR.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 configs/am62ax_evm_r5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am62ax_evm_r5_defconfig b/configs/am62ax_evm_r5_defconfig
index 1f7750c4c031a273321df60e3feb39a8f34b0e42..8cccd2dc2fe06ec69ff07389abda6f6fa81ff711 100644
--- a/configs/am62ax_evm_r5_defconfig
+++ b/configs/am62ax_evm_r5_defconfig
@@ -107,3 +107,4 @@ CONFIG_SPL_TIMER=y
 CONFIG_OMAP_TIMER=y
 CONFIG_LIB_RATIONAL=y
 CONFIG_SPL_LIB_RATIONAL=y
+CONFIG_K3_IODDR=y

-- 
2.47.2

