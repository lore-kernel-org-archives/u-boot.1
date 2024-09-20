Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9478ECF58F1
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 09:15:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B70388E91;
	Fri, 20 Sep 2024 11:15:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g30kL8ve";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EE34892FC; Fri, 20 Sep 2024 03:23:34 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16EF9892E9
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 03:23:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lian.yang.cn@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5365b71a6bdso1746975e87.2
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 18:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726795411; x=1727400211; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=G3k9Q3sfBkfENEu/Z4DKQDKJoC0DTXgjNhL3EWrLlQ0=;
 b=g30kL8veagIRFUBCjWtw02JF2zEl2alsFE6ckOXc3GRq+zTTdQvm0pTir79WiAcsFz
 lCP2JBr6It0SzS6FU2IUsNYX1vG0x1V/mVvL2Dp1uf7uJniHtwA89rhcPp+RsF183QC8
 qr+PcDeKNdG7m811Nr3/ZT5peHJs7R7ESmVbyWi9Y8KkS0+sGxZ/C6p8E4MJjSmR+sr0
 HWmzrqS9nmqI6Qn1Z/CG6D0ukm1ph+AXLYgaiNiuKywsXZPxOC9l2cE3gLu/ZGhde0f9
 2VgxsiAqAgGxaCifJe7KejZUpc5W4VkLwL2ejThJ5pbqLfAh1urwH0ZItp6ZaO37kz/L
 MG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726795411; x=1727400211;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G3k9Q3sfBkfENEu/Z4DKQDKJoC0DTXgjNhL3EWrLlQ0=;
 b=RWXS3+PKfZ8sLro8IFN44UkS9d2WZgS3NJfs+1A1TUQF0Aslggu+shguixSeZnJcxx
 N8E3TflhOYJerjge9liiiIOBi6bci98Y3JLW5pIK08c1c1D5qLDguKV3oRhJz6yBRYyY
 HJ5YVhmd4QkLvZqWXLVdCTzLNeafWsMHHAS9p3E39Nvzfe6GS2p4y6SJ/oa5Sn7Izdze
 nRipi/6oRDzw/0+77e8Xm4pMvyUXS6QMlRIF0np0+FPqovO9Tw6uHxeX33y0g4o1/NPC
 8c9jJlw5bnkKIjylBKoX3KitIf3BLUqvJfSdSsG1VnytJKNeWjhTsV2FYgppVXSH490f
 ThiQ==
X-Gm-Message-State: AOJu0YzH0BejN64j9KgYzrji4JDg9qyHYaCX5eYo/XkS8o7qggc/scd+
 amEvcH6FPpoFgp7XymBogI1iTCJCFt8piTuK3MF8OfcmvccF9907zwNM14Hi3fYa3iJ/0Mp7u38
 TvpYga8ya20sYMFrVVCFWAoY72Mxhadzx+egajPFP
X-Google-Smtp-Source: AGHT+IFJl82EzuXPBc6W8b0Qp7EcUeRPfDZF7gNyV4e3LZbY5LURq6ehsCxjbe9MPxEcXo/kROVqNtTmQKY7J8eS8Hg=
X-Received: by 2002:a05:6512:108f:b0:536:7cfb:6998 with SMTP id
 2adb3069b0e04-536ac2f5ba6mr637269e87.35.1726795410846; Thu, 19 Sep 2024
 18:23:30 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?5p2o5buJ?= <lian.yang.cn@gmail.com>
Date: Fri, 20 Sep 2024 09:23:18 +0800
Message-ID: <CAP71nqddA9buVXF4tVHDJv-vDgQsmRDu19DPjiRLnEod2nN2Qg@mail.gmail.com>
Subject: Enable v3s SPI boot
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

From c50287a2ced52be159292d1d31cadf0d41b6ebbe Mon Sep 17 00:00:00 2001
From: Lian Yang <lian.yang.cn@gmail.com>
Date: Fri, 20 Sep 2024 09:15:32 +0800
Subject: [PATCH] enable v3s SPI boot

The sunxi SPI driver code already includes support for the V3S, and
enabling SPI boot for the V3S is straightforward. Based on real
hardware testing, as long as the SPI configuration in the DTS file is
correct, the system can boot normally.
---
 arch/arm/mach-sunxi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 17666814c52e..ca2ff846375e 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -1078,7 +1078,7 @@ config SPL_STACK_R_ADDR

 config SPL_SPI_SUNXI
  bool "Support for SPI Flash on Allwinner SoCs in SPL"
- depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I ||
MACH_SUNXI_H3_H5 || MACH_SUN50I || MACH_SUN8I_R40 || MACH_SUN8I_V3S ||
SUN50I_GEN_H6 || MACH_SUNIV || SUNXI_GEN_NCAT2
+ depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I ||
MACH_SUNXI_H3_H5 || MACH_SUN50I || MACH_SUN8I_R40 || MACH_SUN8I_V3S ||
SUN50I_GEN_H6 || MACH_SUNIV || SUNXI_GEN_NCAT2 || MACH_SUN8I_V3S
  help
   Enable support for SPI Flash. This option allows SPL to read from
   sunxi SPI Flash. It uses the same method as the boot ROM, so does
