Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26AB2C27C53
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:12:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43B7587BCB;
	Mon, 10 Jun 2024 03:12:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gqsmSLpz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BF7988428; Mon, 10 Jun 2024 03:12:32 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF8C08840C
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3d2299e6650so211102b6e.2
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981947; x=1718586747; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o8q62bkylYVzor5PwPh1PEraxGxh3hsP4/6+ww7jBIQ=;
 b=gqsmSLpzAG8LyBgMbZtuRJUisbl9OpkaCU6Gq/+vpGJlqFhiKAlLOEwRZ64pNElTcC
 y5JVI3at2Z2hCouUOvTbBRM6om6mbMQ42b9YrlRoLo3EwQaBhH0/n0LMDlRSNYjKnp/S
 GikaBFOLkcJSKOtjlZCVar0UjANn6R7+X2Q/S/9R1zRCAd7YSenooMg9e+MMTUn1RaTa
 0dkfRz9EtKW5o/WEd6ni/oZ5Merrz1P2VCGG4y8uIHG68wwUGfuZgj/4KZYIBzewqWdJ
 KwoTjrVsQAqidp/2Ki3SSwbXjuY1a2iFddgojzqXQW7InzrjzkgHzf2zbyfqzuhoZcxr
 J/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981947; x=1718586747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o8q62bkylYVzor5PwPh1PEraxGxh3hsP4/6+ww7jBIQ=;
 b=SeE0Maunm9U6SHT3uJdiXlAC30ESM5i1Tz7uvruirgSY7rThd/xiQbeTwLNQDas8LI
 DCjLErdXV/kIVlWlBCOjeXP7wXJuNsW5J7TVqpsoI/nK9Y74QEvBMnmZBpGRLXOrmIcy
 aCNXcKho6FL0NOQN+ox+F77/w5q3Cd5z28cEmLlTCPDsmqc06VYvWatYyURP/CBLkhbr
 +fKUj3OLJKAc1R+l/6C8EdsBHpLU0HmPjHJWBJjGu8i1FTdHZVokeWanRmKVN4uMJmTt
 Jjgl2f0hgRqlsTsgCix0UEULdy/j9dviPUTY7uIRL/tn44evGXyljGjovHONQoEGqV3a
 LIMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkSIZ6W/30rW52C73aCggVcY3xtI5aRr09xv6K6vUncXFzd7qoHI1xp0qIkRWWHVOS5nIHnnNz1eT3R2JU1WsWoXhL/g==
X-Gm-Message-State: AOJu0YzYpDAG2c6vVkNjX2GgUkinWtDtujquLA4HB1AXBxjZfClN9vJs
 9K9xlkQwyOkQ3wGdDDtCh1D/dorsGLuFTfPoYio2oHPsU+l1yN/cAFLGI3wSiDA=
X-Google-Smtp-Source: AGHT+IGCKU5YAqvkmSTponRH0DZxXK8/aoglh/HYb2KGaiIWqey/E30bJ2QtDOq3y6z9D1LyhzJAwQ==
X-Received: by 2002:a05:6808:2008:b0:3d2:28f8:c7ce with SMTP id
 5614622812f47-3d228f8cd32mr1908845b6e.29.1717981947561; 
 Sun, 09 Jun 2024 18:12:27 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d20b66cae2sm1441626b6e.4.2024.06.09.18.12.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 18:12:27 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v2 01/40] mmc: dw_mmc: Remove common.h
Date: Sun,  9 Jun 2024 20:11:47 -0500
Message-Id: <20240610011226.4050-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610011226.4050-1-semen.protsenko@linaro.org>
References: <20240610011226.4050-1-semen.protsenko@linaro.org>
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

common.h header is marked for removal treewide and shouldn't be used.
Remove it from DW MMC driver.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
  - Added R-b tag from Quentin

 drivers/mmc/dw_mmc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index e1036641452a..e6107c770fe3 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -6,7 +6,6 @@
  */
 
 #include <bouncebuf.h>
-#include <common.h>
 #include <cpu_func.h>
 #include <errno.h>
 #include <log.h>
-- 
2.39.2

