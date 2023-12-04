Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CA0C10F04
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 12:08:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A761D87623;
	Mon,  4 Dec 2023 13:07:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S2Cru77R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B98E87630; Mon,  4 Dec 2023 13:07:23 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 341BE87622
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 13:07:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50bf7bc38c0so952340e87.2
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 04:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701691640; x=1702296440; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LnYpx4HXF0svwPxtFe6zqQqGLbu3MtOtMdMlY/7OJ0c=;
 b=S2Cru77ReItMiGUnRhwW74ltvK45tGIw8vSzpUCpap38FkJEKPBQfyz3ZTW2mWXVNb
 rJJfWqGBNFUlc6E1LHZMjo4dPAcFYVrxZi/2c8GO+AUuXOPCJt7kiu12yNYveG7To/vd
 sJ7RGoCaa+G1vMyuzgMxgI+W6vU8LrScs61PJbbexpxtONFvw0Zn8KFngUHs7UoowpK6
 rIqYNsi24dZdDR1Vp+UEFSy5XC/94g5+OZmDgjPMnvHDiqcWp4kKlqn5qtHdBcPeHSM9
 q7IySkErAh4p/1mWaXI42x7rxMXRsopb2PJR/95vRNAC8am9UlU/CeAXNTwwaV9lwj7O
 P8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701691640; x=1702296440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LnYpx4HXF0svwPxtFe6zqQqGLbu3MtOtMdMlY/7OJ0c=;
 b=sVTGe1lEYw71N6dR9cf4yhY9hKniqoZoSrX5I+I7M4wy9CIGFAGJf7bva2IyVKGi9Z
 s9B7WsfxsZLy83SxQYja5wVgvEFyGaZ225iG0W1ukCusMA6e6JLjhhEqHHbravPwHDYj
 H8x8H2ONdNfro3l5UNWP162nOEhZQNk1wRao5OW9NuirDIjmcPpqTfGaT9XafI5Dt4Pe
 PnRzI8bpNM6YrTFfGJrP/BAhHVlv8PrAy74DVFdpnVMN2k39xqYqQmGs//kvONEMDZ9+
 aS/0UhjAXsNhT2g1iQwb/FmCCdftCaIbl7x0dhZzgBJq7YxgzNYkMUEcBWyzQKrWRPr1
 voWQ==
X-Gm-Message-State: AOJu0Yzj6b73c9iXrW0wnswz55KhOmG4V3Vgb7h6Y/nDecHXITRnIrXr
 bV8hUIAg0Lfm8PrDBoG82IViC+Zg/HRBS18FllR9MQ==
X-Google-Smtp-Source: AGHT+IGRSYGttMMcwIaI7ngz+sp8M4/B4YijbHYV9RL+IkTqCpGgZEf1UmdakhAhLVLZ/tTHnPRn7g==
X-Received: by 2002:ac2:5b5a:0:b0:50b:e5bf:cd08 with SMTP id
 i26-20020ac25b5a000000b0050be5bfcd08mr1499143lfp.0.1701691639850; 
 Mon, 04 Dec 2023 04:07:19 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a0565123ba100b0050befebf0ccsm541675lfv.292.2023.12.04.04.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 04:07:19 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com,
 trini@konsulko.com, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv1 5/9] driver/net/rtl8139: remove debug print
Date: Mon,  4 Dec 2023 18:04:42 +0600
Message-Id: <20231204120446.3277-6-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231204120446.3277-1-maxim.uvarov@linaro.org>
References: <20231204120446.3277-1-maxim.uvarov@linaro.org>
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

debug print delays reset of the driver. Finally I see
bunch of "rx error FFFF" errors in the screen. CI can
not handle many prints. While network works fine there

Reproduced with:
make CROSS_COMPILE=sh2-linux- r2dplus_defconfig all
qemu-system-sh4 -M r2d -nographic -serial null \
-serial mon:stdio -net user,tftp=`pwd` \
-net nic,model=rtl8139 -kernel ./u-boot.bin

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 drivers/net/rtl8139.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/rtl8139.c b/drivers/net/rtl8139.c
index 106bc1c7ae..d8f24ec81a 100644
--- a/drivers/net/rtl8139.c
+++ b/drivers/net/rtl8139.c
@@ -453,7 +453,7 @@ static int rtl8139_recv_common(struct rtl8139_priv *priv, unsigned char *rxdata,
 			  RTL_STS_RXBADALIGN)) ||
 	    (rx_size < ETH_ZLEN) ||
 	    (rx_size > ETH_FRAME_LEN + 4)) {
-		printf("rx error %hX\n", rx_status);
+		debug("rx error %hX\n", rx_status);
 		/* this clears all interrupts still pending */
 		rtl8139_reset(priv);
 		return 0;
-- 
2.30.2

