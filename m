Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CF1C43602
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:23:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4397E84AA4;
	Tue,  7 Jul 2026 17:23:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="xArjGDKJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0D2284AB9; Tue,  7 Jul 2026 17:23:05 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BD1E84AC0
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:23:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c8b49639fbaso2963091a12.0
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1783437782; x=1784042582;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=N7rM7tY29BFoexOmI9GVSzh2fJvGAgr2Cg8lLp5a/Jk=;
 b=xArjGDKJyIxXGIK9NTJxP0ZVN2f+aQUpN4K4EEtpWjSkt/EY3e1XZM4BFPyoGdJDAI
 0NOEZVbvu7vW33ORBoUPg/heClD6qUYX+OfybSVPUMxx8h6Vp97ZEq79aUWnaG99rIaD
 e4NiHekGakEZ2mVuB4C+vBlDeJYXeHauMXbyi3WX6/CcQVrgESDUuqZSmH309lznIPgf
 BhPgDHe0j5bMgN6wYKCiRujhTV7ljMot53Mw+FmSYeTuLKGOe5l0T6oDYYGtctlA/zL9
 MH92H2hKB+0vkG4tddVq9YMBQqwvCx8kOBhPA4Nn+sYFoICkXJLEGSjKy8T/mdib3MUg
 29EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437782; x=1784042582;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=N7rM7tY29BFoexOmI9GVSzh2fJvGAgr2Cg8lLp5a/Jk=;
 b=Mk67bAv4DPLRy3IIAJezBQvEz4STpGVCBFp0GlKDA0lvcCUPRAmeGm9bppMtKbl53g
 UwlkEHlTrzYTK5NMH5zyxthyYm05RyC4gDydhih4Om9CDNgV6rQqEwGqusG2XZ2bJpp8
 0dbR4Fgs/Mihqp5jO7augIPLJpYngERHXeMOlBxC+IFB232hbIG1DXGfQAFemel+xPsZ
 2N6/ke0zWa2UABrmhtYSO4xRUeL7bWvZaBwGj88TN7CNRuS51G5mzXeemqejKdap/bEa
 nRciXC15inMH+uGP9T25/f8sYBmOJI+gBUKzEOzwZjEuc4otEcFGXbHd/WcIv/zJFBa6
 T0/Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrMypEq/DVQnVoWeom3n36CMi7QqWGgPNbGTFKkKt9CnuILpuqImsgwsChzPdDY4SKmFPllCoE=@lists.denx.de
X-Gm-Message-State: AOJu0Yxz87z3/CstUmbPeppr/IzP0w3FzqVeyIjvPOxhbO3jJxP3AlL2
 YfVMnvdFtCbkEw8PDUdcDF6Fd3lghac6q/afniqMn6+2piatAVPcKT9B6E74DoRZRIA=
X-Gm-Gg: AfdE7cl1EdtJYCgfAe7+p2SeIOvpmq+kT18x0VW7js26+z9r8L+o/A+1rXAPhMU4t23
 DrPLOug0YN8kq54u2tUTz7I9GrPBhJNpyAYtNNy+AQLJ1m3MNQlskt1qqh/WgkzO5zszCeErbYW
 Kc/6wUdiAlbzJHsUFRYrqfJZpHepgSMJWn33k4LTQQOLLIUZq4v2qnZb99r5eclAO/4M3EcSFBk
 yAxS7wzwyap3rDailNxQrp9KCzuLFWkIqr5k9/pVjalrpLvTcUuyZZ+yUOo5oQCpiM+QSELbh7L
 wn/RO4Od0b+IVV0dbSDA+GLI2OxssdAPIlftAuSehuepdFc0t38SUwjUHgzZTlGwpzVYb9E3BL4
 XWANHr4jhQxE9fdwBxrlOYe+hLCPFFNdM9ubZj5LEEGWzqkHAEDv8KVrfmIc7wZBUDeTVSrV3s5
 iGciIM94AHsm1ls3hIh1IQI2Ik8KdGguATWv5I1swg9csL6BmRb9oj6H6JhOgvtyNy4SeQLCcSS
 nPCxU+YBRsCZXMwFGXBxKmCxi5OQbK5SXfAt+qkyxYOjwou1iCIlg==
X-Received: by 2002:a05:6a21:481:b0:3aa:c93b:625b with SMTP id
 adf61e73a8af0-3c08ed71933mr6513490637.3.1783437781767; 
 Tue, 07 Jul 2026 08:23:01 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3117483ddd1sm9594997eec.9.2026.07.07.08.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:23:01 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Tue, 07 Jul 2026 23:21:50 +0800
Subject: [PATCH v4 09/10] config: k1: enable ENV support for eMMC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-m4-v4-9-dbd01185f911@riscstar.com>
References: <20260707-m4-v4-0-dbd01185f911@riscstar.com>
In-Reply-To: <20260707-m4-v4-0-dbd01185f911@riscstar.com>
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

