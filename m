Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CE4C54FB3
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 12:23:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2D028144A;
	Sun, 25 May 2025 14:23:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="C7IR81fR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77DFA8144A; Sun, 25 May 2025 14:23:34 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F96A82C8B
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 14:23:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6045e69c9a8so981599a12.3
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 05:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1748175811; x=1748780611;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wSfXNrF/FnS52r4fXkfqwqawehnUmRL1K9MGM5gevUs=;
 b=C7IR81fRWdDGNYFggZEZOFg0Gxzrgg1SVdnlmnXRZatTCTQaw/IUL1jAp7qXBmpBiN
 7RDJ0cqFiETcz2471ZRSVQbClzmSdxu5EfIo9L4gR7vXAVkIBj9wCF9jeH78vmLyd8nb
 sVAjNx5fPM53guZl2mktu4ZvNwogVI6mGlaG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748175811; x=1748780611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wSfXNrF/FnS52r4fXkfqwqawehnUmRL1K9MGM5gevUs=;
 b=Z4eYkwHbqEcLJQ9cGZe6duWT90DoU8xx3AS2yGyre4rrAVT6tXcD6GxOMqnGwBaduZ
 cWX5KnyO09oZSXNA2l8o8mwvxZetO+pHhGzXZUQ83Y430M/lk6Mo2pwcc6Gu0dmpMSXS
 7XlcTCRhfzaGlGcpZOg1tR1z1OK5XB1Er1Luphu+HjVTWXkphqReFOqJXaa/SD66CfEJ
 pr89TGpWQp8LstVC70qPz/64K7G2wUiP+rdSKHi5onBH9Hk4mK7i9xDMH8BOH/2GmAGE
 ho1O+KKhD/r1vhjz3bC/yUlZHltUP9SYvEENmURDAWIxBYcwCL7qjdw+OkZZvszKqiPL
 QdHQ==
X-Gm-Message-State: AOJu0YxWH4Zdm5Q+r7mr+vt7HcckjFW0gFV3XSu6D47rj9ouFGvI1gEd
 HdwRFehDAMg6PDHEg3CDoDC5D9FWAdyBYjcgGMk9nnB9+sjn8BIIFOFcaBf2ocWePiHBBOH02wP
 jb7qUjukeGg==
X-Gm-Gg: ASbGncv0SXAcvg65YPwc/MN8U4RJWugCEJzShvvu013rv9hrvoRhsn48gf3C9q8xArm
 uf9p/78BiwJhvyq37rH+5hgBAKVyObkeoysY3pyVfAYG1HsCGzy/U/K81oD5nAebEjOW+JgwhCB
 TyeHnj7sh9KdNMxl0jbArLIth0FqYvz2xzCdtLtNPzAxFxzPE8ahcKUI+D/gGhhLEflCCWg6ucv
 XKaHoexhGi43XGiddz5MIqoSCs2+4oQsWh+LDToVKJtBSlMy9MOnqXnQGj2/mJ8uOTQaYsF1x9h
 G2y45n5E0CwUDdpyXcgvLG9EridrLnJAB4JtkKP4YMXa2DFMhbMHrWnHsHNkntxOs64NLIPLtP/
 sl20LjPm/m5rMgg5da5UUlHbK
X-Google-Smtp-Source: AGHT+IGHsxStqAE3/gGkXVEp1xZoAilGKMaKuxip3EKzDhLhm9yf4YBITHEH3txGsPXYfMnleWQXWw==
X-Received: by 2002:a17:907:c26:b0:ad5:840b:77f0 with SMTP id
 a640c23a62f3a-ad85b11f087mr469611266b.31.1748175811395; 
 Sun, 25 May 2025 05:23:31 -0700 (PDT)
Received: from panicking.amarulasolutions.com
 ([2001:b07:6467:4426:33ec:9e56:eca:2394])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d4383f8sm1517982366b.113.2025.05.25.05.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 05:23:30 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Trimarchi <michael@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/4] configs/imx6ulz_smm_m2_defconfig: Enable clock framework
Date: Sun, 25 May 2025 14:23:12 +0200
Message-ID: <20250525122316.661999-4-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250525122316.661999-1-michael@amarulasolutions.com>
References: <20250525122316.661999-1-michael@amarulasolutions.com>
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

Allow to use clock framework for the m2 platform. This allow
to have better performance to nand controller

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---

 configs/imx6ulz_smm_m2_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/imx6ulz_smm_m2_defconfig b/configs/imx6ulz_smm_m2_defconfig
index 436bfb78cc2..5f0ec452467 100644
--- a/configs/imx6ulz_smm_m2_defconfig
+++ b/configs/imx6ulz_smm_m2_defconfig
@@ -43,6 +43,8 @@ CONFIG_ENV_IS_IN_NAND=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_BOUNCE_BUFFER=y
+CONFIG_CLK_COMPOSITE_CCF=y
+CONFIG_CLK_IMX6UL=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x82000000
 CONFIG_FASTBOOT_FLASH=y
@@ -50,6 +52,7 @@ CONFIG_FASTBOOT_UUU_SUPPORT=y
 CONFIG_SYS_I2C_MXC=y
 # CONFIG_MMC is not set
 CONFIG_MTD=y
+CONFIG_DM_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_NAND_USE_FLASH_BBT=y
 CONFIG_NAND_MXS=y
-- 
2.43.0

base-commit: df2ed552f0b05591090369a7fe7ddc92439dea5c
