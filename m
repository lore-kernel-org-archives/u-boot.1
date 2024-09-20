Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77227CF58E3
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:27:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFEDE893F0;
	Fri, 20 Sep 2024 09:25:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aYJyBwue";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F28A893DA; Fri, 20 Sep 2024 09:25:21 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B556893E6
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:25:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42cacabd2e0so14223485e9.3
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 00:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726817119; x=1727421919; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=26a2u3uu2HaPtW1vw7xeUgajLlltcWbmx20ZLsqvECI=;
 b=aYJyBwuejo21nO0x+OcrjrI9yfoMLhUuHzjmG7+qW+4Uzalfpj5j7pW+f08XZHvNa0
 k+OU5FPmOEXUCvtj67XsY1LJOV26bsETvX06y5Lgk674kxdZZIXqSX/B4H3zHsLiZwSG
 +s0QUmXYQnYHIeBqzTI7+uZ2633c8CnjfMAs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726817119; x=1727421919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=26a2u3uu2HaPtW1vw7xeUgajLlltcWbmx20ZLsqvECI=;
 b=Gv2MsgLbJHcYQiQgYZ8iMg/oYlm9vJPhLdqUlrbb2XzqCApIQUonUxMMPsEWHXurjw
 3QE5Ny/Aky9tYsbCrsQ5pnrvw19EtGqbeJgImbza02iGCrOMbVn3gzKje4KR9K0rI8Ig
 uAYaXVpaP+rndNffmsh3JFRT17KpYX+FRkoXL9idETwWpkcJ6XAfEulWmIj+BfUEvVIg
 zk+1J9JGyelsr1pbuAVP3WLvX5kBQXdkph2B4twksgUOEBLPaPU6c7tP6gXb7ZvLfDfi
 WEecDBDqzH+hTRQTscOSeZS1a0ude+a7j6d4MzHe9W1Q0kr6FsmGm9XiF334CGquViay
 WBNA==
X-Gm-Message-State: AOJu0YyvtaQ+PGCauJHK86cUkOd4tYJTY7xTJctrwEh4GltjB2NIVZ0f
 u0yysPpVqTiJFfFOUqk6Tzjv60SrqOxn/7HKsI68VSJQB604utSVXZ82zJeFckGPfC8U4CpGOqj
 0ib0O
X-Google-Smtp-Source: AGHT+IHGFCHzXUoTiCI0HWj7d7Az74zO7jcCebJCY3tHDQy9Ayj6Z5qhi6nKqc4FHWPjshRok3GasA==
X-Received: by 2002:a05:600c:5127:b0:42c:b961:c902 with SMTP id
 5b1f17b1804b1-42e7abe83a4mr9232215e9.12.1726817118676; 
 Fri, 20 Sep 2024 00:25:18 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e7540e32fsm41504535e9.9.2024.09.20.00.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 00:25:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 15/18] mmc: rockchip: Log some error returns
Date: Fri, 20 Sep 2024 09:24:39 +0200
Message-ID: <20240920072444.134997-16-sjg@chromium.org>
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

Add a little logging to some places in this driver, to aid debugging
when something goes wrong.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/mmc/rockchip_dw_mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/rockchip_dw_mmc.c b/drivers/mmc/rockchip_dw_mmc.c
index fb77b049834..7e341665aa3 100644
--- a/drivers/mmc/rockchip_dw_mmc.c
+++ b/drivers/mmc/rockchip_dw_mmc.c
@@ -80,7 +80,7 @@ static int rockchip_dwmmc_of_to_plat(struct udevice *dev)
 	priv->fifo_depth = dev_read_u32_default(dev, "fifo-depth", 0);
 
 	if (priv->fifo_depth < 0)
-		return -EINVAL;
+		return log_msg_ret("rkp", -EINVAL);
 	priv->fifo_mode = dev_read_bool(dev, "fifo-mode");
 
 #ifdef CONFIG_SPL_BUILD
@@ -96,7 +96,7 @@ static int rockchip_dwmmc_of_to_plat(struct udevice *dev)
 		int val = dev_read_u32_default(dev, "max-frequency", -EINVAL);
 
 		if (val < 0)
-			return val;
+			return log_msg_ret("rkc", val);
 
 		priv->minmax[0] = 400000;  /* 400 kHz */
 		priv->minmax[1] = val;
-- 
2.43.0

