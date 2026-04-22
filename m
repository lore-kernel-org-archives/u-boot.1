Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA131F9EDE8
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 14:33:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D937384383;
	Wed, 22 Apr 2026 16:32:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G37vI3OP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E6DA84324; Wed, 22 Apr 2026 16:32:05 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAE0584353
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 16:32:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-50d87c138e1so57417121cf.1
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 07:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776868322; x=1777473122; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DkfmryHwdGQ5l1KIWxsJNe7YCml+CLUslMHSJ5U5BSM=;
 b=G37vI3OPquBqJOla/Dc0zn26eSrQBdmF4fGRTxTXD7chRD5LN+4UILjN8d2MYySmSx
 6hLv+z/iPDA1ibCFz3v/vL+t/0UAhM/nr+PR3od1m9xOkya15QyfkK+6UdeokA37GvMn
 kMLq6K3530DX12cRu2CTnTFMlJGhaaUuC+WwodbQe8ye/y26MM1T5AHYWIEV67aY5sg5
 /1nMTU5lpkXbSnWTYAnnfCKEEsgiqCrCZ1j+9LUVT89OnRP8IBwzgvs6jb6qVQGUEwA2
 wLvfgBISz2VOXTotaG+s+ECalyUTYY5YySJmwCNqB+SVy624/EICrT/+OrXR/10kmlKm
 84Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776868322; x=1777473122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DkfmryHwdGQ5l1KIWxsJNe7YCml+CLUslMHSJ5U5BSM=;
 b=Ep6hT0Id2jswASgUWgLuGY4Uj+sDSiW5cOQpSSYjQBnSl1kXIb6INq/awckO8PnbS/
 uRy8vc9c6cEmcqu7c0u0A0BwvkeCeoQ+nxX4vTdZw/z8K8AC/M1izRXXa7BhoGd9k3LL
 EEsY86sUeCfZS538jlyZVTcVVop/Rrn8/38HJHBf7POd8nTh7lMFuP1b98KOkkXfD0MD
 wzuDeukl1F0EBvxMXL02J2sVFbv0TIYk6LBgBgVaBEX7zG56FeCnsWrZ7GwnKTCqy7TX
 sZRbbXtCbIuJdCKERv9PUzZ7yGEKADj76LjLwxVj9lYj1BeHW29t4yPgEYS4tRdbquZM
 LwXQ==
X-Gm-Message-State: AOJu0YyyFi6LqpuO1saM2VuBolb9+3fQoUprNL1TFO/OQHUDHxy5WJES
 2gx5osVCpwar7hYRPNR2fR36Eqgc29pGt8bWBuG4LFoqLffIdbalGhLVypFGw3VqTSc=
X-Gm-Gg: AeBDiesnq/C8PhJ92R3FhjiCE5OEx8ZArQuTL69KB9ZmCtijVQiBeRcrNVgyPyLqgBM
 QaMF8qrasInyehHXvxodmrrRl/JTY8tGYrqInKhK4cjQ0M2Lja5YBhxDIuFVY2sSiVwTE3nQpCj
 JctJsz3GGY2+Bu4/4FQP/Ymbk6F1BQby+n623HpAsKnW+lmWAmRaauWLcWe0Z/8HzoJ69VvtQml
 eU484P3StE9QR01b8wZcefpgfq9HIBt9mdMSHQjfO8MK0CWbxm7yHRUSip9mNMz5K0tDMNUiqAV
 u236MP7yRzh8FfwhOEum3FZlm+omfCsRxmk1tii8z6VUTQza4n5wSgTCX9QEE4ucaCXmm5nILxn
 aCHD5Nkx4Zufs2WF+UVLfJJxzSKJmCfuKv1xLMAPmFcNYWsPgDFPa6A+QSUhqeyR48TmAXXFdbN
 0fBmdzjkX3t/kBwdei9n4x53LNDpXYN99USGAuXDi/SwFi6KE8rUv7mKNLPO4XuugV2NUzyYHFL
 RA/tpjAIkUX5MEx68tcuQ==
X-Received: by 2002:ac8:7f90:0:b0:50d:5a11:1b5 with SMTP id
 d75a77b69052e-50e3694a5a4mr352088681cf.17.1776868321541; 
 Wed, 22 Apr 2026 07:32:01 -0700 (PDT)
Received: from ubuntu.localdomain (172-97-209-197.cpe.distributel.net.
 [172.97.209.197]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e394903dfsm138772501cf.26.2026.04.22.07.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 07:32:01 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH 12/16] riscv: binman: Always set default configuration in FIT
 image
Date: Wed, 22 Apr 2026 10:31:08 -0400
Message-Id: <20260422143112.1329478-13-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260422143112.1329478-1-raymondmaoca@gmail.com>
References: <20260422143112.1329478-1-raymondmaoca@gmail.com>
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

From: Raymond Mao <raymond.mao@riscstar.com>

When CONFIG_MULTI_DTB_FIT is enabled, the FIT image contains multiple
device tree configurations for different boards. The default
configuration must be explicitly set to ensure the FIT framework
traverses all available configurations instead of falling back to
CONFIG_DEFAULT_DEVICE_TREE.

Without this default property, fit_find_config_node() will use
CONFIG_DEFAULT_DEVICE_TREE as the configuration name to match.
This prevents the SPL from correctly selecting the appropriate
DTB based on runtime board detection (e.g., from EEPROM).

Remove the conditional guard so that "default = conf-1" is always
present in the FIT image, regardless of CONFIG_MULTI_DTB_FIT.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 arch/riscv/dts/binman.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/dts/binman.dtsi b/arch/riscv/dts/binman.dtsi
index b518560bb94..84c261c6849 100644
--- a/arch/riscv/dts/binman.dtsi
+++ b/arch/riscv/dts/binman.dtsi
@@ -93,9 +93,7 @@
 
 			configurations {
 
-#ifndef CONFIG_MULTI_DTB_FIT
 				default = "conf-1";
-#endif
 
 #if !defined(CONFIG_OF_BOARD) || defined(CONFIG_MULTI_DTB_FIT)
 				@conf-SEQ {
-- 
2.25.1

