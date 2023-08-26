Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A938EC83F11
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 13:24:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E88C48071F;
	Sat, 26 Aug 2023 15:24:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foundries.io header.i=@foundries.io header.b="deWMBlrH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 723EA805C8; Sat, 26 Aug 2023 15:24:18 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB06880842
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 15:24:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=oleksandr.suvorov@foundries.io
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-500913779f5so2806153e87.2
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 06:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1693056255; x=1693661055;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/q8VNa7jq0g7NJ1lD9eqYZYI+qsSF+A0grZYtfx0NnA=;
 b=deWMBlrHkAm5Erri/pV5vu4z0PXc+sJDPEQ4Z+AQ5rr29j2saxRm0qQyuQp/X+1MCz
 GXRKLUvEVaZrmr5C0cGLAI709WBC5iRD9m/BxVuH+WWQ2XnMgUB2Nj1dCSbij873wU13
 RB/rCe/Z7PsQGSCX3KL4HCW/4kofrF43Za+kqyTykifNyrMOSgDhd9jKzAKgcurnVW9Q
 z1lRMp9n9x21Dv04z5Ns2bfpx11GAMctnGGVr8fMtdKu+1C+VlIpyLK/gP7hzpPmLSkR
 RgGQkFcOcce8lg/c9qmhWa3s9gY5Edv4YVWF+P9OHzryFpSyxBkzhDFZxqASS+hhH2IX
 mGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693056255; x=1693661055;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/q8VNa7jq0g7NJ1lD9eqYZYI+qsSF+A0grZYtfx0NnA=;
 b=aYjaMpMwYB5jmo2Eq9qYoALcJqS5PZP5ZYYM2SfrIoJ1Z28upPxK2e1LxxXkKzG8sg
 27vDvF0fw+Ra18r3gz1MJN5b8ahIqmcEADz+z2yTKcz3lFQOaU3SKKB7B2m87LMNWXnh
 IGvPLINTctaQ7JY0O6NEp/rLSNzYarrRxtnBP9Q/Exz0ZLg+4bLE13es+RD2Nj6S5FbF
 gt3HzCDL859FZNdu+4OjVexsmWD8WxBgN1S9TcNI8ZCv9FplfGmKk9rQjzSS4sTyCEiA
 pW/XUPqWr8yjCpyYgwOGC6cSHs8kJFUqOqa0j1DpHYX2nVgSJPn1t6N2E3cpY+n5twHT
 u4Dw==
X-Gm-Message-State: AOJu0Yw/eMIIQU1BEL6+7mzhs1sQzv/TJJ+qGZwSYx7FwmYPKbE9ozNZ
 AgD38ly7+EyfUgs2WvVmyMKB0TZQbBqXOpWrOqc=
X-Google-Smtp-Source: AGHT+IFz609J3+3ENHjdhbSw8BgQCjKO0PxjNzgUBRlv2apmPusX17u3tPzwRVbwTRDzChX+t/X1zQ==
X-Received: by 2002:ac2:48bb:0:b0:4ff:887c:4729 with SMTP id
 u27-20020ac248bb000000b004ff887c4729mr13119636lfg.46.1693056254244; 
 Sat, 26 Aug 2023 06:24:14 -0700 (PDT)
Received: from cryobook.. ([93.188.34.55]) by smtp.gmail.com with ESMTPSA id
 j8-20020ac253a8000000b004fb7359ab83sm714836lfh.80.2023.08.26.06.24.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Aug 2023 06:24:13 -0700 (PDT)
From: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
To: u-boot@lists.denx.de
Cc: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Fabio Estevam <festevam@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
 Stefan Agner <stefan.agner@toradex.com>, Stefano Babic <sbabic@denx.de>
Subject: [PATCH] mach-imx: bootaux: fix building with disabled bootelf
Date: Sat, 26 Aug 2023 16:24:00 +0300
Message-ID: <20230826132410.378846-1-oleksandr.suvorov@foundries.io>
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
up with a linking error [1]. Select LIB_ELF for all cases when
valid_elf_image() is used in the imx_bootaux module.

[1]
ld: /tmp/ccaF1rpv.ltrans0.ltrans.o: in function `do_bootaux':
arch/arm/mach-imx/imx_bootaux.c:108: undefined reference to `valid_elf_image'

Fixes: c0f037f6a2a ("mach-imx: bootaux: elf firmware support")
Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
---

 arch/arm/mach-imx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index d94b5828d0d..cbe62d6b8f9 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -32,6 +32,7 @@ config IMX_RDC
 config IMX_BOOTAUX
 	bool "Support boot auxiliary core"
 	depends on ARCH_MX7 || ARCH_MX6 || ARCH_VF610 || ARCH_IMX8 || ARCH_IMX8M
+	select LIB_ELF if !ARCH_IMX8 || IMX8QXP
 	help
 	  bootaux [addr] to boot auxiliary core.
 
-- 
2.41.0

