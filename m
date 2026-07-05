Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FD8C43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 06:09:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 408F98496E;
	Sun,  5 Jul 2026 08:09:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="FfC7rJ/r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79EC683314; Sun,  5 Jul 2026 08:09:16 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A250A849BA
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 08:09:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3804e42ad5fso2298443a91.2
 for <u-boot@lists.denx.de>; Sat, 04 Jul 2026 23:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1783231750; x=1783836550;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=N7rM7tY29BFoexOmI9GVSzh2fJvGAgr2Cg8lLp5a/Jk=;
 b=FfC7rJ/rc+LLI4lIkHsM/8iqpA69NNJ9l4zhBMitS9Mhg2bx3bDI0IYG0R4L0UAMuQ
 yI/6faLljJI5szyCu/ah4W2XxUb8wQVDv04sGKfFOygZuvWcmMI0HH52Fovia0/bc2Mo
 a1JWp2FuXAqPLzn3mrvKrKJmtl9b3cbStb+59AyEbrwPrlELU4UTuNX62yBIYczcqv95
 lyC4pjV0U5uMOxSe0APUBtAlfJ1t++h+OhRbL3cA2pZ5SkANpg/wmuY9s+ivs064vlkb
 s5Oamu0lKsxtJDxTTWGlk/7x3h6yo5I21bXk8b7/ejVGFhj6SfMnKYr+SCEacQEXfgub
 9wcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783231750; x=1783836550;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=N7rM7tY29BFoexOmI9GVSzh2fJvGAgr2Cg8lLp5a/Jk=;
 b=O1X4pgn2CQW+kYJX9LQyzefYV3oNgBcvXWpIVsH70vP7fNFWuHl5kClGKuJfipLFko
 XeJFfuC0ot9PMzF7P7F4txXAY27phRU5/w2KUd0ITDwoxU/gS6kSfXEbxaV5je9UlO+H
 KHxVjfevWnifUkW2amgIbPRhB6BZZWgi+ek7387qijZmCKIB4ip+zv/2QOefXLWn/lep
 Oveh85kPQ2Bw8bZhiwAhvJZA/+WkJuEMXTJ0d4+CfvdM4seG19gVv4EKRUX3tUh9R5S6
 qGjb9W6g0uP8Q3uJbwc9E4ImXJhOkpzDX0Dn83gimxHCJzJ3ITB0oS1SwoMMNf6JbUNa
 GfbA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqoHW5PFzmE5hdPUdUH9nW+s5R+H3/Nk6GyXSUOMJ4qb9aJSaSKAhoTtVKhsucTGJf084zAYjQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwycTOfYfMovmkD+3w74vC9wuSoR9/g0YbIp5375wHiOPjm38tP
 fNXtANFhNwf+P5YN5sTR6RzpknWhTY6Nrx2ZvokJ+w22OaIqGxtATU2ybvutlSlp3bA=
X-Gm-Gg: AfdE7cmLbbdAXosxKHdgRjnrpSdbJuB43PEnkIUz+G1ORKMdkTjxa+YFIr9LeUC3G8N
 Wi5rShTfNgubLbWrm5dWLwxMNRiQOY5wZrh5+LziVqp/OEAM+qpPaKIQwY8XS++TE8BV4fihQlj
 SJGIZie1tUIkWdvTVmFpZZ2oFx7O4/IAcfQjuPTjaXDKDDwL4XoUkHgxb/qHMIKPjORDFPSiDZW
 YygxChNhAkvWIcXdIAJJoVht6asfTMkWzZuHydIb8LohRSJIGYqjnHoO5PlJDs9zWkUE5Ttir5X
 KDKLTMgbZkt2PrjpgX8BNCwXPOMCQl9u0TGOrm4pjH9k4YOATcO3YHmVXnDPLHmNUUiBVdEWA7W
 ZJ6Xd15lSFdlU+lLCQNsCxb8NdtWeh6Cjpcy0cNi7RaW39C8XTedR+1vP8GgKCwHUl76de+utvE
 V25sA45RxlmU0TSM3cx4e+hLzl3JHWqcuGUOyo9yrvHVRxDmU0YKV5L2pfQhnmQySCy/Lze26OA
 MLrKQg0OEDsvb04JzGSSO8Ek61lqukrfGIS2vO2QS1bb1iX2dVX2A==
X-Received: by 2002:a17:90b:1d04:b0:381:abcc:c8e9 with SMTP id
 98e67ed59e1d1-382803b43b1mr5914285a91.7.1783231750578; 
 Sat, 04 Jul 2026 23:09:10 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f38ee1333sm22291719eec.24.2026.07.04.23.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 23:09:10 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sun, 05 Jul 2026 14:07:59 +0800
Subject: [PATCH v3 8/9] config: k1: enable ENV support for eMMC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-m4-v3-8-5a9bc7f25fc5@riscstar.com>
References: <20260705-m4-v3-0-5a9bc7f25fc5@riscstar.com>
In-Reply-To: <20260705-m4-v3-0-5a9bc7f25fc5@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong.xu@riscstar.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
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

Enable environment variable support on the eMMC storage device for
both SPL and U-Boot stages.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>
---
 configs/spacemit_k1_defconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 886679367a9..1c92c4082a7 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -14,7 +14,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x400
 CONFIG_SPL_STACK_R=y
 CONFIG_SPL_STACK_R_ADDR=0xc00000
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x100000
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x400000
 CONFIG_SYS_BOOTM_LEN=0xa000000
 CONFIG_SYS_LOAD_ADDR=0x200000
 CONFIG_SPL_SIZE_LIMIT=0x31000
@@ -48,6 +48,10 @@ CONFIG_CMD_TLV_EEPROM=y
 CONFIG_SPL_CMD_TLV_EEPROM=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x60000
+CONFIG_ENV_SECT_SIZE=0x10000
+CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_SPL_SYSCON=y
@@ -111,5 +115,6 @@ CONFIG_SPL_SPI_LOAD=y
 CONFIG_SPL_SPI_FLASH_TINY=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SYS_MMCSD_RAW_MODE=y

-- 
2.51.0

