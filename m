Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A52C83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 14:04:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9A7586583;
	Thu, 31 Aug 2023 16:04:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foundries.io header.i=@foundries.io header.b="OgHZ4Tz+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DD4786558; Thu, 31 Aug 2023 16:04:10 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 898A28658E
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 16:04:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=oleksandr.suvorov@foundries.io
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5007abb15e9so1691750e87.0
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 07:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1693490646; x=1694095446; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NDECu28DKhPP9ghdGAcwFPuOabMR5r6vd3j/Th24qRQ=;
 b=OgHZ4Tz+/feZGnOTQCJX1h0kiDtFMql+3r+mjhZj/407O1XjANXaAAOzZxx9nhg7xr
 muKAh8M7MHREnm3YZE0RrlB12zJg8l2k8hdT4G21k2C0NE898v9btMWWesnne2wpNdeT
 VNmdSqWQFHFFPHPyP38oz71tm7ob+NLM/N++PK2cYPPswo+apTwrcOnJjuNvRBdRDk0n
 iOh1u6lNTLvg3DfScEUF7YgQi/hhJzy8rc6rVLDQbC6vDyzUim8B/k3LkyfxbS2xB+Lh
 PXuUd4iOM0tD+dGkmMGV4JS4QRTuZXqLuGGEg7CJGAM4ta2iFnxBV2wUGD0Pyk4O5Ikr
 mvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693490646; x=1694095446;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NDECu28DKhPP9ghdGAcwFPuOabMR5r6vd3j/Th24qRQ=;
 b=V8Unv3fn2nMMdN/GHbE2BsmaAKEOjOaXXso3tQDiUb94K9tnqHMlkxmm5YsafLxWnu
 GFO7/NKspNY29kiaXEm5zel9GqBNfktOI10s+OFSNE9Zv0/qYmPIbGOVp/LX3kqAfZaC
 TzXB8i+bKUGfaHZiCBiuaPvCwbNQ5bwT2jrlQZx0NcGDu2Wef/piuKmEaOusMeZ/WAz8
 NOpeX8WKy9am1lNY7gGMhxFr/kX6RWa4YIdPPwWNbbXAqdzORcRQ2AkrhhTzX1OztY/Q
 oUCy04+oYbnbi+mYsBC0OlCFIl4ckzqM+oNfXteSNmlXjmG8YxloxJG8HQvhB82V8StL
 pWkA==
X-Gm-Message-State: AOJu0Yya7OdnQ1wvtFyCwUwA7E2jlGB8Yfayq48LJSwayFxR/5mWyL2v
 Art6iWGU00X+Vgw/TRAio3jDdtqTYTF4axK6gog=
X-Google-Smtp-Source: AGHT+IF3kasEL2PZYkjpTTnmvHF+blu4ObXm4mCs2ggOzD3/RLQ7f/0r58db24HN/0q/xFbSrON6Kg==
X-Received: by 2002:ac2:5056:0:b0:4fe:2c6:1d76 with SMTP id
 a22-20020ac25056000000b004fe02c61d76mr3968399lfm.21.1693490646375; 
 Thu, 31 Aug 2023 07:04:06 -0700 (PDT)
Received: from cryobook.. ([93.188.34.55]) by smtp.gmail.com with ESMTPSA id
 u30-20020a056512041e00b005008248b6b9sm271209lfk.197.2023.08.31.07.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 07:04:05 -0700 (PDT)
From: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
To: u-boot@lists.denx.de
Cc: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Fabio Estevam <festevam@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
 Stefan Agner <stefan.agner@toradex.com>, Stefano Babic <sbabic@denx.de>
Subject: [PATCH v2] mach-imx: bootaux: fix building with disabled bootelf
Date: Thu, 31 Aug 2023 17:03:52 +0300
Message-ID: <20230831140402.322536-1-oleksandr.suvorov@foundries.io>
X-Mailer: git-send-email 2.41.0
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

If CMD_ELF disabled and IMX_BOOTAUX enabled, the u-boot building ends
up with a linking error [1]. Select LIB_ELF to fix the building
issue.

[1]
ld: /tmp/ccaF1rpv.ltrans0.ltrans.o: in function `do_bootaux':
arch/arm/mach-imx/imx_bootaux.c:108: undefined reference to `valid_elf_image'

Fixes: c0f037f6a2a ("mach-imx: bootaux: elf firmware support")
Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
---

Changes in v2:
- select LIB_ELF unconditionally

 arch/arm/mach-imx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index d94b5828d0d..fda762426ef 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -32,6 +32,7 @@ config IMX_RDC
 config IMX_BOOTAUX
 	bool "Support boot auxiliary core"
 	depends on ARCH_MX7 || ARCH_MX6 || ARCH_VF610 || ARCH_IMX8 || ARCH_IMX8M
+	select LIB_ELF
 	help
 	  bootaux [addr] to boot auxiliary core.
 
-- 
2.41.0

