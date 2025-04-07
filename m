Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9850C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 17:00:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7C8B82F85;
	Mon,  7 Apr 2025 19:00:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MXB3YXa4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6E3182F6D; Mon,  7 Apr 2025 19:00:00 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DC2682E66
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 18:59:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ac2a9a74d9cso511998766b.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 09:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744045198; x=1744649998; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8Rj1GWinW3jMkEZoSFmYCZIDir+Z2ApzH/1Q8rF/Yro=;
 b=MXB3YXa4eu9bs7++Xk/7LR2Kdu6cL2szr9XJEUuxtKT68oqQ9p4TtO9iXA9EsUgQw9
 fgTBjPh01Qba6tuaV7bccAcHpBF41n/M0fC0/Nwykz1katiTWeXFkSM/JwQa8kS0GAJj
 lEZKc2PxLY+7P4NsBVudM2OBJK2tmVf856vAJkPhoaJ0pnNjwMn48Ry3eR4KLwhQIn/p
 Psgo2CCGmTe+LnY7ZHimuZydENxq6tIi9j6ZBGU8O14vOM8Hwyfu95/i8Z6spCfofOak
 B5puF7GVIgz/f7npOrK4meDsL9fBZ7NkAN8F5exq0fOtoV19pOUvZEwktNzXdLqLw3b3
 jixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744045198; x=1744649998;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Rj1GWinW3jMkEZoSFmYCZIDir+Z2ApzH/1Q8rF/Yro=;
 b=qq+RN176X/Fm2AKujSgInya6cXeZV75/h3tr49qb+TaXhx4saEa1PVa8LKgXLHvHbE
 kZckxFJf5VuxUx6eH8WzjkH3MYCDFVp7iPSqE+EshoNmYahu39O78nZ5Qht/SXdfTMM/
 V7WVRia2b5hv7FQSDT7ImRf/48l0FEeBfgOWaV3ezYLB18djKxhlseiJAPRKZHjmpym8
 E2ls+5H6aArAfMwMmGAc7dIcqYQju9nceAkW5cvO7Af7oqQJA1nIdzIMKbNidqcVG8aU
 TUxtjBguPIXsnLwRD8VIou3aHIbBH4lGnDDYlJG4r56tE0sd0G2Sz0waBmZ4oJTvAMpV
 b94Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNl7MxtzYqigp0U+tpW1zdp3dR2fW+HiUFamO6r4XqQUzDkH9EVbKwaQwVgX5RdN5G/ayAVbA=@lists.denx.de
X-Gm-Message-State: AOJu0YybZ2HJXge24Vfnxb42DZuK1qqgSBbz1NT4ZaiorSKECTeT+8n9
 DzRqee9kDG7tZrR24GDt2tjvslssckCxk2k1i/xvPCMJ8OibMlKRUsZcZEQlE7E=
X-Gm-Gg: ASbGncuR6wEPQS+1V+FuDdk1i7e3ViHP8hpg7keJjoKaOTKducm3vk2DsslEqVcu+wf
 KuEqbP4SXhdPjoHSHF5blgGkL8u950uHRnDVcIEamu/RM1Qm0p01fditthYsIj5oRmgb6a/SfD6
 W/FNUGeZakLsEnRCOWCiNu3T/tMI3xYGOk5Dwejog0M2aWxX3pMbIc/2IR6gPNH0/f7EEFZPX/4
 +0viMJoo4s7aSXY9lWUFTyOgH5/xcpvT+LITPOiFFhf4wIxpLC/gsEKgML+A4/cPTbl+EoPpLiU
 H2xzUTpPq7qNDVcskVAZg2rchHCQVw0IDHWpVtZGt/tZWFtVBmFnfOIVVQ==
X-Google-Smtp-Source: AGHT+IEJVA3jxnSgokwpq3a6P9CqnMG1WDQ/weHhtkZHTC459pRgDOpY+Bd1GuCDRgFVABo/OK6ruA==
X-Received: by 2002:a17:907:7e9a:b0:ac1:f002:d85d with SMTP id
 a640c23a62f3a-ac7d181d967mr1163421666b.6.1744045197931; 
 Mon, 07 Apr 2025 09:59:57 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:b2e5:7ea8:e86c:3f99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfea16aesm773603666b.70.2025.04.07.09.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 09:59:57 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 07 Apr 2025 18:59:24 +0200
Subject: [PATCH 03/13] board: dragonboard410c: Fix BD address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-db410c-fixes-v1-3-524aefbc8bb4@linaro.org>
References: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
In-Reply-To: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.2
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

local-bd-address in the device tree needs to be formatted with the least
significant byte first (i.e. little endian). We're not doing this when
adding it to the DT, which means the MAC address ends up being reversed in
Linux. Fix this by reversing the array before setting it in the DT.

We're also flipping the wrong bit when generating the BD address. Before
reversing the array, the least significant bit is in the last byte.

Fixes: ff06dc240325 ("db410: alter WLAN/BT MAC address fixup")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 board/qualcomm/dragonboard410c/dragonboard410c.c | 27 ++++++++++++++++++------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualcomm/dragonboard410c/dragonboard410c.c
index fcbf2c3fe60f21bae1c6d64b542a4d9867c33826..c33529d31869b17c7a30ec83af1199d01db472f5 100644
--- a/board/qualcomm/dragonboard410c/dragonboard410c.c
+++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
@@ -97,9 +97,9 @@ int qcom_late_init(void)
 	return 0;
 }
 
-/* Fixup of DTB for Linux Kernel
- * 1. Fixup installed DRAM.
- * 2. Fixup WLAN/BT Mac address:
+/*
+ * Fixup of DTB for Linux Kernel
+ * 1. Fixup WLAN/BT Mac address:
  *	First, check if MAC addresses for WLAN/BT exists as environemnt
  *	variables wlanaddr,btaddr. if not, generate a unique address.
  */
@@ -107,6 +107,7 @@ int qcom_late_init(void)
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
 	u8 mac[ARP_HLEN];
+	int i;
 
 	if (!eth_env_get_enetaddr("wlanaddr", mac)) {
 		msm_generate_mac_addr(mac);
@@ -118,12 +119,24 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	if (!eth_env_get_enetaddr("btaddr", mac)) {
 		msm_generate_mac_addr(mac);
 
-/* The BD address is same as WLAN MAC address but with
- * least significant bit flipped.
- */
-		mac[0] ^= 0x01;
+		/*
+		 * The BD address is same as WLAN MAC address but with
+		 * least significant bit flipped.
+		 */
+		mac[ARP_HLEN - 1] ^= 0x01;
 	};
 
+	/*
+	 * Reverse array since local-bd-address is formatted with least
+	 * significant byte first (little endian).
+	 */
+	for (i = 0; i < ARP_HLEN / 2; ++i) {
+		u8 tmp = mac[i];
+
+		mac[i] = mac[ARP_HLEN - 1 - i];
+		mac[ARP_HLEN - 1 - i] = tmp;
+	}
+
 	do_fixup_by_compat(blob, "qcom,wcnss-bt",
 			   "local-bd-address", mac, ARP_HLEN, 1);
 	return 0;

-- 
2.47.2

