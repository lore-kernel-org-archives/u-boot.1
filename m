Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06C8C54747
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 01:48:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0180388B27;
	Wed, 28 Aug 2024 03:46:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j2Lz1fxK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D328788B78; Wed, 28 Aug 2024 03:46:03 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B76B488AA8
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 03:46:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-829e856a14eso98087639f.2
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 18:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724809560; x=1725414360; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kmRPVI+5iVZe9anogVsULhhmzW9Eu1K7j9lezTZ+KMo=;
 b=j2Lz1fxK7BpTKun6Iu6pI/V4I6zPxirYn9dcRh8Yt+a5zE+QXPotPGmGHj5ji/tDA0
 T8H9Zyr2g5mSRP9BrVy004lZWQjAFhxcGC4OsVSkyW3gxOQ0SPGzM4OV0adSlUNwxqb4
 OS5hddr2+HfX9VjQTeIXu5Csu59a70oOJJMVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724809560; x=1725414360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kmRPVI+5iVZe9anogVsULhhmzW9Eu1K7j9lezTZ+KMo=;
 b=emBcEusG8b3hxUdhuZ/QRqdVf8iaO4pwupNfRnGLXfQZkhAedlA8tOUFE+VTJnDNAs
 IDyUgnRkP5Ec219gRT48sj6CkvVhQfVVSbAHeE53sJafCXOAnH+Qc1iERDLwo2/9G/G4
 NYP+jTA6z+9pxDCjfpcBHmpRrO1bWPGLz3o3s8NqkO1QVxNaMtvEnvyngDNxXp9Z3wYr
 +ZrgftBy85eZkzoiay0Ras+TQ3qnxAcmp5f7nxmc0ccfot192ZjKXQTK0f3yMz3ahExQ
 xlitmVmCAeh26Oic17d3/QuuTwuhh0slDhxHyVCKN7pCy9092o+UvSzqtgUNaEV5YmCO
 jQGA==
X-Gm-Message-State: AOJu0YyTuG+Kc6Nsizt2RsZTvk9tPlXWlDLy66b6wlUy/7mwxH+NeGTd
 ecxWeORVgs2kUs1RMwgfdM5pM/+7eKApVZFSKl7RyAG/sapXyRK3zqyKpsdU5TMiH/fTRwv/BhQ
 =
X-Google-Smtp-Source: AGHT+IFN1nPw8XSgh2s9eym85lTMtKAOpFo3RvYP9MLnRt+PzEukOyEyh2wAn/TeyiCekH/uGWFgsg==
X-Received: by 2002:a05:6602:6b87:b0:804:2b28:75db with SMTP id
 ca18e2360f4ac-82787329bbemr1427162339f.10.1724809560177; 
 Tue, 27 Aug 2024 18:46:00 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f5ca7csm2898342173.63.2024.08.27.18.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 18:45:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH 15/18] mmc: rockchip: Log some error returns
Date: Tue, 27 Aug 2024 19:45:34 -0600
Message-Id: <20240828014538.3322013-16-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828014538.3322013-1-sjg@chromium.org>
References: <20240828014538.3322013-1-sjg@chromium.org>
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
2.34.1

