Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C1FCF58F4
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 09:16:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0F028943E;
	Fri, 20 Sep 2024 11:15:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="zq+s3aEL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02BF6893C2; Fri, 20 Sep 2024 11:06:20 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC8D9893A6
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 11:06:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dse@thaumatec.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a8d56155f51so198171266b.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 02:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1726823177; x=1727427977;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WS1yCRQJdAzHO3UdJBVN6ySnJfMQxCBEzF9pq3vTXIc=;
 b=zq+s3aELHHXrv+Yjrhc3gvKNfPCbktywMC+7OzZlNjzubypR8WfMuQ2iGHNoNK/95n
 LbSjqPdaveS8i3YFnGVlBCrVbUzPkYUpPKcVZ4zJPScC73h6L1sL46/KURVP/u6QTY6S
 U7fR3jiIr1WWHJGF3vFGGwz8FGfIbVyAganIrlRMqfIN9bZP2Hye5HZFvcpIGBrwWxG8
 RjbmMcF1/GeAE2r6sWDsceRA+y9d6Z3BtnX48BhVr75HDCsQMActprfAZXg5+KHaTFwV
 kD3M2zG6sZ86zk6nbFgwrzciSp7oDYJ3aNL2TfYvDxVNamL4WZrgb4h8cTkdXUMBiF8S
 2B2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726823177; x=1727427977;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WS1yCRQJdAzHO3UdJBVN6ySnJfMQxCBEzF9pq3vTXIc=;
 b=bjE34S0Xq9ogckFug5NRu8fotfOyL9CPX6CDfbb+TdFvqmSexHl/yV/u9DKSJvwNXy
 pboFwqTrKjzaN1n87uncLGAyv/tvza6dVeENGnlREpKkOOYCI2ExzhHrFXIRcwHcBvtU
 duSRInfsQ7uwLCQkxx3neRPabcQYiEvGv+iDKaVcKlc76OggPGntGLZQ2SXn3MGi5wHx
 Z646IB1QMlzmZ/I31qIkUwj4Q7dqNOgAtrfecaPD5HlxPT2dtj8jGG/lCt7CdGJ9UWF7
 X8E9BpuIZ/E2NWFU3/o9KtysECJZVgPz56PdKY1N6bvuF7HkgODmKK1gBHBCOCk2GFWq
 8T6w==
X-Gm-Message-State: AOJu0Yw9yDk2C7aRskVpaOryl643+2a4IYsCzI/78x9kWjUdjMv/Lrgb
 URNhORoxrDQcBpZsyohb/rnBS6YxZ7i/5SbIs8JukAxRjqKs8nbpAkcE+cOrJ+PirU/SryjVQJI
 z
X-Google-Smtp-Source: AGHT+IGzrW8Fh2zQqmTF8MMWochYVtQByXZBkvn8lw9+8eeVtHv3vOn9XfBaU8CYDwE8BP/TlZlbfQ==
X-Received: by 2002:a17:907:868d:b0:a8a:cc5a:7f3c with SMTP id
 a640c23a62f3a-a90d5126c2emr167191266b.58.1726823177334; 
 Fri, 20 Sep 2024 02:06:17 -0700 (PDT)
Received: from fedora.home ([185.186.39.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612b3833sm818977566b.128.2024.09.20.02.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 02:06:17 -0700 (PDT)
From: Daniel Semkowicz <dse@thaumatec.com>
To: u-boot@lists.denx.de
Cc: Daniel Semkowicz <dse@thaumatec.com>, Dragan Simic <dsimic@manjaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] rockchip: rk3399: Weaken dependency on SPL serial
Date: Fri, 20 Sep 2024 11:06:01 +0200
Message-ID: <20240920090613.76154-1-dse@thaumatec.com>
X-Mailer: git-send-email 2.46.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Sep 2024 11:15:35 +0200
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

Allow to disable serial console in SPL. Weak dependency is already used
with TPL serial.

Signed-off-by: Daniel Semkowicz <dse@thaumatec.com>
---

 arch/arm/mach-rockchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index fc1b638ff01..269c219a6f8 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -257,7 +257,6 @@ config ROCKCHIP_RK3399
 	select SPL_SYSCON if SPL
 	select TPL_NEEDS_SEPARATE_STACK if TPL
 	select SPL_SEPARATE_BSS
-	select SPL_SERIAL
 	select CLK
 	select FIT
 	select PINCTRL
@@ -288,6 +287,7 @@ config ROCKCHIP_RK3399
 	imply SPL_DM_SEQ_ALIAS
 	imply SPL_FIT_SIGNATURE
 	imply SPL_ROCKCHIP_COMMON_BOARD
+	imply SPL_SERIAL
 	imply SYS_BOOTCOUNT_SINGLEWORD if BOOTCOUNT_LIMIT
 	imply TPL_CLK
 	imply TPL_DM
-- 
2.46.1


