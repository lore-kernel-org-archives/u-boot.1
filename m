Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC376C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 03:18:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 310AF8783C;
	Wed, 13 Dec 2023 04:17:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bB7iWJWd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 086F587227; Wed, 13 Dec 2023 04:17:05 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0741087495
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 04:16:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5910b21896eso1594809eaf.0
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 19:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702437416; x=1703042216; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KguN83/R37lZxGr53hT0/XLXUIkXKsvUyIcqenliK8Y=;
 b=bB7iWJWdMVosu0+GCVIctdpepYwmoXXsPqsmBqN+zH1O8PthbWFy3QKcviCfL5aEcl
 R9Bx0JAjYhJdp7k7odIdE1GEhcpGIFiymFfp88eRHe4TkkfTG9EfWEtHlNJpTTCuecEI
 ZdsjRg4V7nwRIOGAtmmz32CfFYHO6ti/05GWPOa6jgYKOnIR9C6mw+CzTJ/Ewmp6pGBc
 nf82XLdO6xHoS+zeh8Wg5U7K3KNqUI+vGsDq5VLTA5mxh2ji4/vGjBAAUnhRpFgVj35V
 /17HBNmYVdKRE6U21sDLchiC5voyLymFWSxr2uxmL8h96Q9ni8bypGb22BG74PPUPPH2
 kEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702437416; x=1703042216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KguN83/R37lZxGr53hT0/XLXUIkXKsvUyIcqenliK8Y=;
 b=h7STXQ3I25j1VmzNVjppj3S4CRZ2YnA0nD1BLugKpqOk8WoRR3NvGRIL/QnyKB7aRF
 Fj9yKJFQRWxrpFwlutSTHg3Ay/jMtSzi2J9rFnYAfzgO42/foOU6ZzOv3u9Xmi849fPv
 n8yUPG2yRE2bkeWJekOaHB0wkJJZw3+F5LS39KvfhH/bJmumJ2sYeF13NBq52502atjF
 3ZC7eTMls04h4iFvnlT5TBY+11GSD9WXpvwQhKmk9guUSTDavQ23MOxr34ZXtfQbSypd
 R7xSi7MQ8736MZCkLvf7THyEsNW8tTot80VT1jl6JYVySC3UNg3KnYvTwY55uY7OPYkS
 SbEw==
X-Gm-Message-State: AOJu0YwFoufUbuMdvU3K04QbhuuVmeEvyAT/DG56bN3Azu35v7Fuq0bU
 CCS5o6ga8bdVJyHLt5pkm7ggkRobfXrC9yZ70NM=
X-Google-Smtp-Source: AGHT+IGsSNfv8yPBCuLUUQ1Yxfe8uUxgXadvbrHdwi0qT+/wicmqqZJBFTA7Ll/2QjnpE/cgniHYnQ==
X-Received: by 2002:a05:6808:3a09:b0:3b9:f1f4:ab51 with SMTP id
 gr9-20020a0568083a0900b003b9f1f4ab51mr10096248oib.0.1702437416741; 
 Tue, 12 Dec 2023 19:16:56 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 c15-20020aca1c0f000000b003b29c2f50f0sm2723222oic.18.2023.12.12.19.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 19:16:56 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.denx.de
Subject: [PATCH 10/13] serial: s5p: Add Exynos850 compatible
Date: Tue, 12 Dec 2023 21:16:43 -0600
Message-Id: <20231213031646.28828-11-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231213031646.28828-1-semen.protsenko@linaro.org>
References: <20231213031646.28828-1-semen.protsenko@linaro.org>
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

Enable serial support for Exynos850 SoC by adding the corresponding
compatible string. No additional changes needed, the driver works as is
on Exynos850. Related USI and PMU configuration is enabled in separate
drivers. The only other dependencies are clock and pinctrl drivers,
which are already enabled too.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/serial/serial_s5p.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/serial/serial_s5p.c b/drivers/serial/serial_s5p.c
index 7d04dcff54fc..801b7645afa4 100644
--- a/drivers/serial/serial_s5p.c
+++ b/drivers/serial/serial_s5p.c
@@ -257,6 +257,7 @@ static const struct dm_serial_ops s5p_serial_ops = {
 
 static const struct udevice_id s5p_serial_ids[] = {
 	{ .compatible = "samsung,exynos4210-uart",	.data = PORT_S5P },
+	{ .compatible = "samsung,exynos850-uart",	.data = PORT_S5P },
 	{ .compatible = "apple,s5l-uart",		.data = PORT_S5L },
 	{ }
 };
-- 
2.39.2

