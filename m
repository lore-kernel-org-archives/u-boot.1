Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEF5C54746
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 01:48:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCBEA88C21;
	Wed, 28 Aug 2024 03:46:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YQQ9jpzq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96F3588C13; Wed, 28 Aug 2024 03:46:05 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 856D388AAA
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 03:46:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-81fb419f77bso342513939f.2
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 18:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724809562; x=1725414362; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y3/xInJECHE35Tf90dn0X5pXrNQbb6gt8KTkpwzNjcw=;
 b=YQQ9jpzqUHIfvFNyPm6Ga7yPaDdHIPbhoHbBG1P9jIfSbl6CeoSLLxvimIpzKVXjbn
 XzESDrUKi1F5lDKYcdOi8IG/0Bhmw/0DzzGCdiAVhCkWkf/a9oXaoigOrKTIjfd2lume
 5v2ltjrzhrklt34ATm4PiDUnoPpofnpiQpJYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724809562; x=1725414362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y3/xInJECHE35Tf90dn0X5pXrNQbb6gt8KTkpwzNjcw=;
 b=W1ysNN045VB5slBRA7yF1yOQAYZXeLEfkqbAdZ2coIddyg9kmXA3J5b/9nezSoxIo7
 u0MZltGA3VJm2U7QO6BySLZTN/aSS04m3YvekTGRT4mYQTsZKGJiEwDf5hV3vnbIbGtS
 YIPFaQ0R36cHxzzHBcAGtbR04lo+qBTGrmNENTAGqCDDgJ+lvkGF4sIBe5uYgwHyhv7r
 KDOsYS/IC/OmEhDhoNfBIpJy3tCnDQKxJjbJXrYadif6fShZ/s5qcQzNGA/ekxJOSN0c
 JR4l/HwmjNdPKlQTYJmDALU+qvxsLPH+5saFS7W/K5kO4J8qEUxpEHeUFdy3TJxpcgV4
 UeDw==
X-Gm-Message-State: AOJu0YzIgE9hgMsPEeDerhZa8z/FP/cAsaTzPLhsn8qnO5NkvTCh2U/u
 JyXVjCyS0lL/6DGD1/Yxd1nn192plbrNyQF23+K5HZZshVJP6I5iejeAhW85Wh8IhwAE6B8Zt3A
 =
X-Google-Smtp-Source: AGHT+IGvdgJ9yE8EYOPwW5fhL1RnkDWuuYPQ6OWQiB3Gx84TPBEhNA5+XkePblocHYbVH2gH6fx+dg==
X-Received: by 2002:a05:6602:621a:b0:81f:c044:8f6e with SMTP id
 ca18e2360f4ac-8278731cf6emr1633974639f.8.1724809562093; 
 Tue, 27 Aug 2024 18:46:02 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f5ca7csm2898342173.63.2024.08.27.18.46.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 18:46:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Dragan Simic <dsimic@manjaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Peng Fan <peng.fan@nxp.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH 17/18] rockchip: mmc: Fix a missing colon
Date: Tue, 27 Aug 2024 19:45:36 -0600
Message-Id: <20240828014538.3322013-18-sjg@chromium.org>
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

Add a missing colon in rk3399_emmc_get_phy().

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/mmc/rockchip_sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/rockchip_sdhci.c b/drivers/mmc/rockchip_sdhci.c
index 15b4a39770a..6c5c8781c3e 100644
--- a/drivers/mmc/rockchip_sdhci.c
+++ b/drivers/mmc/rockchip_sdhci.c
@@ -230,7 +230,7 @@ static int rk3399_emmc_get_phy(struct udevice *dev)
 
 	grf_base = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
 	if (IS_ERR_OR_NULL(grf_base)) {
-		printf("%s Get syscon grf failed", __func__);
+		printf("%s Get syscon grf failed\n", __func__);
 		return -ENODEV;
 	}
 	grf_phy_offset = ofnode_read_u32_default(phy_node, "reg", 0);
-- 
2.34.1

