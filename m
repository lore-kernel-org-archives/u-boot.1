Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58308C88E40
	for <u-boot@archiver.kernel.org>; Sun, 13 Sep 2026 07:29:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D1F080DD1;
	Sun, 13 Sep 2026 07:29:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RoW0SG2NmEPV; Sun, 13 Sep 2026 07:29:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9FACB80E84
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789284551;
	b=Rexml/5XOQDI1vGkYnvlcDZDyPrPWGF/V7o5gwDxg0oBfkDCZnp2RLFekxGeyzCvTtr6
	 O8aji2lOdFib2F/XwSgt83rCVlDT/VwlUtfUa7VDn+BAZ2vOVjOkZqIjhMsGKI1R7C0oG
	 1kX7E5tgdxjTus85ryABQklvfSbwMw6n/Lb0lWdubRu+rOqrmMReORKpyc5ZhuV68pc4b
	 bw9+8pbMvlzPxI+5QB2Q42UHuGYxGFNiL7Rly33AzFbI/w80zjV4kQKICEH6jnQypd/Zf
	 ZGViWsybGHcEXk72v2lgiCK+/GNwagJ5gjPU5iGZbhR/Xq0XIZdIfTyv22ohXfiNLiQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789284551;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=S9PItu3tgXihrxXCux3h0y5cmVgNA0/YNs5/yrxxNUs=;
	b=q9zx5yfXA8xwH1A54kXMV6YLnbrqyCE5rvMrPmM7mIimZrQyIOXCz/rRoYft1rR6Yftc
	 ikQ333RovIwDSy5t18xpkLccJnRs1a6S6NM/ioUdoQ6xqMWe+CErTAM2uX4fk9Qd6iGnC
	 SInzhD7QoRTo/Asy3knLk8EGOif8Up1fT9FmbDNIfOHBcpTHKjBJnENC4P26bnIqTomi5
	 jbTqPSsgAIDVRHdZ2rgm/bzadjSZalDkKg004kx2QXrvA2HDIdVBy0j9hUEmrkynH64XA
	 oE3A78ky/424CPP6tJTJUd2wdzJje6sY/IG/epgg8F/zTntH1SYGsvv69UqynN5RZxA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789284551;
	bh=S9PItu3tgXihrxXCux3h0y5cmVgNA0/YNs5/yrxxNUs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T510j3M7AbKcKh21MzrBkh51ZIIaLPU4gPBA3FlT8unIURi4BOK0kJ9bvjDmTzj5z
	 zqmeXs4Wni7HFq0G3lHvWrms0zlf8WaeoLUB22HBcd7rFh4iNAYaUmqeiVkUICrGoG
	 kppfGyiclQ2KVbaiYEsekRai+5eA0KeDFxCNobjxMOWHkU3I1hDEBph1kZc6gAkNdn
	 +9BTakKp5418OdPbOEjwckiwISrnj6uOt4jBjo8Q56IroDC1sqVJezku1GYiBRPlBg
	 7tUg82WIDlNCRCECLx63UuYvG64hPbMrs4KQsCPE44E+9FFcI4fXa7cBK9LQtVVaT7
	 lQBDt0oA0bJ5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9FACB80E84;
	Sun, 13 Sep 2026 07:29:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 22C54769
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 07:29:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 117694069F
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 07:29:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Mt9Hb1ulo5Q for <u-boot@lists.u-boot-project.org>;
 Sun, 13 Sep 2026 07:29:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 412C640699
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789284548;
 b=Y47yR0HHAAMWVmauEEz5tPQ8H727gFMmLvt46XiYol/5xde0n7d8z8ikSg4n5k92f5WA
 LJAT0zUBfaXpRWIMzbmsJ2qpjCRlBrrMhZprKirAV/18VvACodEvNhG32e+Vd8hjGtje5
 WUS4+jMbQD6pE/6InOhAHSn3YTZJ3hSI7SPU/qASP7qF4ZIFOJMr6tdXxK2WcrJbpwDQX
 prTP+atj4JzRCAayH0xC6SK7MZ3W/SMkIvovI4gE7IcETqUe5/0CkXjXa3rdP5pbWc7CI
 d5UHVS9xJwDmTqFg5ns6eZ1jvXsrcmWbs88Qfcacs50rYhwTA5c4acY5HrBSgHI5ixw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789284548;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=S9PItu3tgXihrxXCux3h0y5cmVgNA0/YNs5/yrxxNUs=;
 b=ApffVCFWG3B0jIq+gNKXI7/q/dWoZ1lPN0uj0H1Ii/OmAna3gvzeZfoLd92dOXS8Y7TD
 Vs7rcFgeFekB96ysMshm9oFpYhsMXDgnZsU5MElcCu8rKrZus1RFA1Z6sHjGxpyXIPXDe
 GAqglxitaWaWT8a/hZ+XIYyACVcWlRvvWHK5K/Q6vSL7NyiMDU/6qCdQKgb7JlwZzwsGj
 2+7D5jznpZjwYYtBEgTc6LqAToa0wPBP4cf6Im7mEuigAJ9rzkr7lpVA9eYnbdS9iZ1Du
 098CZ8pzBaOM/wEGx5FYAMAcGFsITZYK5YOmFdM8J1bvWDEyk8md7+PmwN8K3knuScA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=VLYCgSO1; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=VLYCgSO1
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 412C640699
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 07:29:06 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-49e6deb520eso12408155e9.0
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 00:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789284545; x=1789889345;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S9PItu3tgXihrxXCux3h0y5cmVgNA0/YNs5/yrxxNUs=;
 b=VLYCgSO1enVxgVXYwaFpsNyK/dyFJPSxGwCxHlDQJiAumbf20ddzk4meVvPuhBh0jM
 EjtFHJDKugAncNdumM6mgT9VvPVsu0LsOcVgu9rTnIyn3Ap4b1UxsiMMOqKG2IJi4+5y
 MFGW/HZCwKeYBdj+clzmMFn0zFswvTHzUd3/n2XGFPMNFDuVcB0+jLYbp0Kymih6+hlQ
 7h9ciQ887NPgccP9RoB0VtBai+MCC8KQsydFL+S3Idtvs7exC8D3vR8DgLbkLhGQ5G/s
 1Uf96zhF/T6YMbQaId3jX/L9aMZhZjlwweBSxC+TFrNjT1GBMzCj4sQc/Im+Eaq/lYfo
 oD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789284545; x=1789889345;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S9PItu3tgXihrxXCux3h0y5cmVgNA0/YNs5/yrxxNUs=;
 b=Ee5Qw5Ow0ZBP4j7jIA5PUCIbSeODQDibrK79hjCVeVP26bXHWL1ebmbhPSxxxKhCBn
 uzJAVcRLbLBrzLMSuDxm8SidwvroigFRJV7TLKCERD09nj+IHsrvN0EEeSfntvpJQYC6
 Go570/WMM6gKYvttxax/X/6kgEsK3/HOBN+rLqi2iAOXZtD/TbZIeBeip/lU86MJosW9
 r9mAeCTS4IHVPffU7ziYSiwRuJnGuSsLto9M3klgJjrfyWAHEtT5HkE5eSPrNHhVnZvo
 7DJ2jgF2yxaUzk2I6UHbBQOQ3GnlTYv1CoIVfVK5FCCMV35/paOW70l6Ib5h2bf4K0u4
 hIqA==
X-Gm-Message-State: AFuF++koV4MG8HGMtVLhw1ZmT7H4l1q7nB9D3bg48FhQLkqEvHJ70Y7v
 Q3cvvuRd2uFDM9iN1sVvugAReMXyM689xyweiMw41XTX8/fDu6uEWaDQ5CLPLXAMEYs=
X-Gm-Gg: AYBFou2cM4vIIKyNpMHJqDAfZNpFRU5M+beWPjF0gPYVit9u8Db/xz/NLuvuTIhLsNw
 Eeg7FlzCNJALGMzNpBrkcChA+vSQnklW4SnkykajxoJlG3/evOfSm35G21FOA/BPTEkofr4qkV1
 mVusDJZCDWAxws+a+FG6KPgDN95LVY5rIt3lH9oOO4wUKsf/EPk24p9e1rMBbWEi4svVwtNBIiQ
 H9ImpoPSLqF7pWROb6ZQt137trgJM9wlDklRhwPW17+NeIR3GH4lo8ss8KuCyv2BDdu8ATp51kT
 v3NvKdmgVM21pQJAPlBolxneA8j65vgKp4lo/ikIkvHD2zp08WG4AbtXkx05cl+4spJJD0fmdM1
 ITFrNonOuWojr9I0c7h2Ujb964ZS4nXKo5+zv8DgN63AZMeX8T/ScWTzI/CdS/pb4/m1t4vulEF
 0O+ch8iq5Thg/gv++DwWDw+C91iFrGQuQ37Myq/ubdnS0GXZ8+vyZzFPZQcMe0PQl7nDMVEMzvs
 i4nEOLeASyUA4h+gCrzqBYj7ZzDiCW6FZYIO//fMY/StAgASwntoSsZaYFqSkyCJKQHUz4KmFfR
 vcvZkKG27cYveJI=
X-Received: by 2002:a05:600c:4455:b0:49d:797:83bf with SMTP id
 5b1f17b1804b1-49e619bd1b2mr128602295e9.21.1789284544047; 
 Sun, 13 Sep 2026 00:29:04 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e71e300f3sm100788875e9.7.2026.09.13.00.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 00:29:03 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Sun, 13 Sep 2026 09:28:45 +0200
Subject: [PATCH v6 3/5] fastboot: make shared configuration checks phase-aware
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-ccaione-upstream-spl-fastboot-v6-3-dd3ba81a7ed2@baylibre.com>
References: <20260913-ccaione-upstream-spl-fastboot-v6-0-dd3ba81a7ed2@baylibre.com>
In-Reply-To: <20260913-ccaione-upstream-spl-fastboot-v6-0-dd3ba81a7ed2@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 =?utf-8?q?Macpaul_Lin_=28=E6=9E=97=E6=99=BA=E6=96=8C=29?=
 <Macpaul.Lin@mediatek.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Sam Day <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Carlo Caione <ccaione@baylibre.com>, David Lechner <dlechner@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Fastboot currently builds only for U-Boot proper, so its source and
Makefile rules test CONFIG_FASTBOOT_* directly. The same checks would
select U-Boot-proper options when these files are compiled for another
phase, potentially compiling unavailable backends or using the wrong
configuration values.

Use CONFIG_IS_ENABLED(), CONFIG_VAL() and CONFIG_$(PHASE_) consistently
for code and object selection. The empty phase prefix preserves the
existing U-Boot-proper configuration and behavior while making the
shared implementation safe to reuse from SPL.

This also makes the Android boot-image condition phase-aware. Since SPL
has no SPL_ANDROID_BOOT_IMAGE option, the existing flash:zimage path
remains available only in U-Boot proper.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/Makefile              |  2 +-
 drivers/fastboot/Makefile     | 10 +++++-----
 drivers/fastboot/fb_block.c   | 11 ++++++-----
 drivers/fastboot/fb_command.c | 31 +++++++++++++++++--------------
 drivers/fastboot/fb_common.c  | 21 ++++++++++++---------
 drivers/fastboot/fb_getvar.c  | 14 +++++++-------
 drivers/fastboot/fb_mmc.c     | 36 ++++++++++++++++++------------------
 drivers/fastboot/fb_nand.c    |  2 +-
 drivers/fastboot/fb_usb.c     |  2 +-
 9 files changed, 68 insertions(+), 61 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 4c7ba741acb..19f5c3802a4 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_$(PHASE_)DMA) += dma/
 obj-$(CONFIG_$(PHASE_)DMA_LEGACY) += dma/
 obj-$(CONFIG_$(PHASE_)DFU) += dfu/
 obj-$(CONFIG_$(PHASE_)EXTCON) += extcon/
+obj-$(CONFIG_$(PHASE_)FASTBOOT) += fastboot/
 obj-$(CONFIG_$(PHASE_)GPIO) += gpio/
 obj-$(CONFIG_$(PHASE_)DRIVERS_MISC) += misc/
 obj-$(CONFIG_$(PHASE_)SYSRESET) += sysreset/
@@ -94,7 +95,6 @@ obj-y += block/
 obj-y += cache/
 obj-$(CONFIG_CPU) += cpu/
 obj-y += crypto/
-obj-$(CONFIG_FASTBOOT) += fastboot/
 obj-$(CONFIG_FWU_MDATA) += fwu-mdata/
 obj-y += misc/
 obj-$(CONFIG_MMC) += mmc/
diff --git a/drivers/fastboot/Makefile b/drivers/fastboot/Makefile
index 32e8e072c88..7eb666bdd60 100644
--- a/drivers/fastboot/Makefile
+++ b/drivers/fastboot/Makefile
@@ -3,9 +3,9 @@
 obj-y += fb_common.o
 obj-y += fb_getvar.o
 obj-y += fb_command.o
-obj-$(CONFIG_USB_FUNCTION_FASTBOOT) += fb_usb.o
-obj-$(CONFIG_FASTBOOT_FLASH_BLOCK) += fb_block.o
+obj-$(CONFIG_$(PHASE_)USB_FUNCTION_FASTBOOT) += fb_usb.o
+obj-$(CONFIG_$(PHASE_)FASTBOOT_FLASH_BLOCK) += fb_block.o
 # MMC reuses block implementation
-obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fb_block.o fb_mmc.o
-obj-$(CONFIG_FASTBOOT_FLASH_NAND) += fb_nand.o
-obj-$(CONFIG_FASTBOOT_FLASH_SPI) += fb_spi_flash.o
+obj-$(CONFIG_$(PHASE_)FASTBOOT_FLASH_MMC) += fb_block.o fb_mmc.o
+obj-$(CONFIG_$(PHASE_)FASTBOOT_FLASH_NAND) += fb_nand.o
+obj-$(CONFIG_$(PHASE_)FASTBOOT_FLASH_SPI) += fb_spi_flash.o
diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
index 51d1abb18c7..68593244ab9 100644
--- a/drivers/fastboot/fb_block.c
+++ b/drivers/fastboot/fb_block.c
@@ -130,11 +130,12 @@ int fastboot_block_get_part_info(const char *part_name,
 				 char *response)
 {
 	int ret;
-	const char *interface = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
-						   CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
-						   NULL);
-	const int device = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
-					      CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
+	const char *interface = CONFIG_IS_ENABLED(FASTBOOT_FLASH_BLOCK,
+						  (CONFIG_VAL(FASTBOOT_FLASH_BLOCK_INTERFACE_NAME)),
+						  (NULL));
+	const int device = CONFIG_IS_ENABLED(FASTBOOT_FLASH_BLOCK,
+						     (CONFIG_VAL(FASTBOOT_FLASH_BLOCK_DEVICE_ID)),
+						     (-1));
 
 	if (!part_name || !strcmp(part_name, "")) {
 		fastboot_fail("partition not given", response);
diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index 18d86988f4c..111516fd1b3 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -339,19 +339,19 @@ void fastboot_data_complete(char *response)
  */
 static void __maybe_unused flash(char *cmd_parameter, char *response)
 {
-	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
+	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_BLOCK))
 		fastboot_block_flash_write(cmd_parameter, fastboot_buf_addr,
 					   image_size, response);
 
-	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
+	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_MMC))
 		fastboot_mmc_flash_write(cmd_parameter, fastboot_buf_addr,
 					 image_size, response);
 
-	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_NAND))
+	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_NAND))
 		fastboot_nand_flash_write(cmd_parameter, fastboot_buf_addr,
 					  image_size, response);
 
-	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_SPI))
+	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_SPI))
 		fastboot_spi_flash_write(cmd_parameter, fastboot_buf_addr,
 					 image_size, response);
 }
@@ -367,16 +367,16 @@ static void __maybe_unused flash(char *cmd_parameter, char *response)
  */
 static void __maybe_unused erase(char *cmd_parameter, char *response)
 {
-	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
+	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_BLOCK))
 		fastboot_block_erase(cmd_parameter, response);
 
-	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
+	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_MMC))
 		fastboot_mmc_erase(cmd_parameter, response);
 
-	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_NAND))
+	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_NAND))
 		fastboot_nand_erase(cmd_parameter, response);
 
-	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_SPI))
+	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_SPI))
 		fastboot_spi_flash_erase(cmd_parameter, response);
 }
 
@@ -482,8 +482,9 @@ static void reboot_recovery(char *cmd_parameter, char *response)
 static void __maybe_unused oem_format(char *cmd_parameter, char *response)
 {
 	char cmdbuf[32];
-	const int mmc_dev = config_opt_enabled(CONFIG_FASTBOOT_FLASH_MMC,
-					       CONFIG_FASTBOOT_FLASH_MMC_DEV, -1);
+	const int mmc_dev = CONFIG_IS_ENABLED(FASTBOOT_FLASH_MMC,
+					      (CONFIG_VAL(FASTBOOT_FLASH_MMC_DEV)),
+					      (-1));
 
 	if (!env_get("partitions")) {
 		fastboot_fail("partitions not set", response);
@@ -505,8 +506,9 @@ static void __maybe_unused oem_format(char *cmd_parameter, char *response)
 static void __maybe_unused oem_partconf(char *cmd_parameter, char *response)
 {
 	char cmdbuf[32];
-	const int mmc_dev = config_opt_enabled(CONFIG_FASTBOOT_FLASH_MMC,
-					       CONFIG_FASTBOOT_FLASH_MMC_DEV, -1);
+	const int mmc_dev = CONFIG_IS_ENABLED(FASTBOOT_FLASH_MMC,
+					      (CONFIG_VAL(FASTBOOT_FLASH_MMC_DEV)),
+					      (-1));
 
 	if (!cmd_parameter) {
 		fastboot_fail("Expected command parameter", response);
@@ -531,8 +533,9 @@ static void __maybe_unused oem_partconf(char *cmd_parameter, char *response)
 static void __maybe_unused oem_bootbus(char *cmd_parameter, char *response)
 {
 	char cmdbuf[32];
-	const int mmc_dev = config_opt_enabled(CONFIG_FASTBOOT_FLASH_MMC,
-					       CONFIG_FASTBOOT_FLASH_MMC_DEV, -1);
+	const int mmc_dev = CONFIG_IS_ENABLED(FASTBOOT_FLASH_MMC,
+					      (CONFIG_VAL(FASTBOOT_FLASH_MMC_DEV)),
+					      (-1));
 
 	if (!cmd_parameter) {
 		fastboot_fail("Expected command parameter", response);
diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
index 9c52e004588..db6088653e5 100644
--- a/drivers/fastboot/fb_common.c
+++ b/drivers/fastboot/fb_common.c
@@ -98,15 +98,18 @@ int __weak fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)
 		[FASTBOOT_REBOOT_REASON_RECOVERY] = "boot-recovery"
 	};
 
-	int device = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
-					CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
+	int device = CONFIG_IS_ENABLED(FASTBOOT_FLASH_BLOCK,
+				       (CONFIG_VAL(FASTBOOT_FLASH_BLOCK_DEVICE_ID)),
+				       (-1));
+	const char *bcb_iface = CONFIG_IS_ENABLED(FASTBOOT_FLASH_BLOCK,
+						  (CONFIG_VAL(FASTBOOT_FLASH_BLOCK_INTERFACE_NAME)),
+						  ("mmc"));
+
 	if (device == -1) {
-		device = config_opt_enabled(CONFIG_FASTBOOT_FLASH_MMC,
-					    CONFIG_FASTBOOT_FLASH_MMC_DEV, -1);
+		device = CONFIG_IS_ENABLED(FASTBOOT_FLASH_MMC,
+					   (CONFIG_VAL(FASTBOOT_FLASH_MMC_DEV)),
+					   (-1));
 	}
-	const char *bcb_iface = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
-						   CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
-						   "mmc");
 
 	if (device == -1)
 		return -EINVAL;
@@ -234,8 +237,8 @@ void fastboot_set_progress_callback(void (*progress)(const char *msg))
  */
 void fastboot_init(void *buf_addr, u32 buf_size)
 {
-#if IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK)
-	if (!strcmp(CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME, "mmc"))
+#if CONFIG_IS_ENABLED(FASTBOOT_FLASH_BLOCK)
+	if (!strcmp(CONFIG_VAL(FASTBOOT_FLASH_BLOCK_INTERFACE_NAME), "mmc"))
 		printf("Warning: the fastboot block backend features are limited, consider using the MMC backend\n");
 #endif
 
diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
index e8aa0e09aa6..9e8e8889d08 100644
--- a/drivers/fastboot/fb_getvar.c
+++ b/drivers/fastboot/fb_getvar.c
@@ -70,19 +70,19 @@ static const struct {
 		.variable = "current-slot",
 		.dispatch = getvar_current_slot,
 		.list = true
-#if IS_ENABLED(CONFIG_FASTBOOT_FLASH)
+#if CONFIG_IS_ENABLED(FASTBOOT_FLASH)
 	}, {
 		.variable = "has-slot",
 		.dispatch = getvar_has_slot,
 		.list = false
 #endif
-#if IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC)
+#if CONFIG_IS_ENABLED(FASTBOOT_FLASH_MMC)
 	}, {
 		.variable = "partition-type",
 		.dispatch = getvar_partition_type,
 		.list = false
 #endif
-#if IS_ENABLED(CONFIG_FASTBOOT_FLASH)
+#if CONFIG_IS_ENABLED(FASTBOOT_FLASH)
 	}, {
 		.variable = "partition-size",
 		.dispatch = getvar_partition_size,
@@ -116,21 +116,21 @@ static int getvar_get_part_info(const char *part_name, char *response,
 	struct disk_partition disk_part;
 	struct part_info *part_info;
 
-	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK)) {
+	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_BLOCK)) {
 		r = fastboot_block_get_part_info(part_name, &dev_desc, &disk_part,
 						 response);
 		if (r >= 0 && size)
 			*size = disk_part.size * disk_part.blksz;
-	} else if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC)) {
+	} else if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_MMC)) {
 		r = fastboot_mmc_get_part_info(part_name, &dev_desc, &disk_part,
 					       response);
 		if (r >= 0 && size)
 			*size = disk_part.size * disk_part.blksz;
-	} else if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_NAND)) {
+	} else if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_NAND)) {
 		r = fastboot_nand_get_part_info(part_name, &part_info, response);
 		if (r >= 0 && size)
 			*size = part_info->size;
-	} else if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_SPI)) {
+	} else if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_SPI)) {
 		r = fastboot_spi_flash_get_part_info(part_name, &disk_part,
 						     response);
 		if (r >= 0 && size)
diff --git a/drivers/fastboot/fb_mmc.c b/drivers/fastboot/fb_mmc.c
index 9bc782ccd02..ae33e35365b 100644
--- a/drivers/fastboot/fb_mmc.c
+++ b/drivers/fastboot/fb_mmc.c
@@ -75,7 +75,7 @@ static int do_get_part_info(struct blk_desc **dev_desc, const char *name,
 	int ret;
 
 	/* First try partition names on the default device */
-	*dev_desc = blk_get_dev("mmc", CONFIG_FASTBOOT_FLASH_MMC_DEV);
+	*dev_desc = blk_get_dev("mmc", CONFIG_VAL(FASTBOOT_FLASH_MMC_DEV));
 	if (*dev_desc) {
 		ret = part_get_info_by_name(*dev_desc, name, info);
 		if (ret >= 0)
@@ -111,7 +111,7 @@ static int part_get_info_by_name_or_alias(struct blk_desc **dev_desc,
 	return do_get_part_info(dev_desc, name, info);
 }
 
-#ifdef CONFIG_FASTBOOT_MMC_BOOT_SUPPORT
+#if CONFIG_IS_ENABLED(FASTBOOT_MMC_BOOT_SUPPORT)
 static void fb_mmc_boot_ops(struct blk_desc *dev_desc, void *buffer,
 			    int hwpart, u32 buff_sz, char *response)
 {
@@ -130,7 +130,7 @@ static void fb_mmc_boot_ops(struct blk_desc *dev_desc, void *buffer,
 }
 #endif
 
-#ifdef CONFIG_ANDROID_BOOT_IMAGE
+#if CONFIG_IS_ENABLED(ANDROID_BOOT_IMAGE)
 /**
  * Read Android boot image header from boot partition.
  *
@@ -346,7 +346,7 @@ int fastboot_mmc_get_part_info(const char *part_name,
 static struct blk_desc *fastboot_mmc_get_dev(char *response)
 {
 	struct blk_desc *ret = blk_get_dev("mmc",
-					   CONFIG_FASTBOOT_FLASH_MMC_DEV);
+					   CONFIG_VAL(FASTBOOT_FLASH_MMC_DEV));
 
 	if (!ret || ret->type == DEV_TYPE_UNKNOWN) {
 		pr_err("invalid mmc device\n");
@@ -370,15 +370,15 @@ void fastboot_mmc_flash_write(const char *cmd, void *download_buffer,
 	struct blk_desc *dev_desc;
 	struct disk_partition info = {0};
 
-#ifdef CONFIG_FASTBOOT_MMC_BOOT_SUPPORT
-	if (strcmp(cmd, CONFIG_FASTBOOT_MMC_BOOT1_NAME) == 0) {
+#if CONFIG_IS_ENABLED(FASTBOOT_MMC_BOOT_SUPPORT)
+	if (!strcmp(cmd, CONFIG_VAL(FASTBOOT_MMC_BOOT1_NAME))) {
 		dev_desc = fastboot_mmc_get_dev(response);
 		if (dev_desc)
 			fb_mmc_boot_ops(dev_desc, download_buffer, 1,
 					download_bytes, response);
 		return;
 	}
-	if (strcmp(cmd, CONFIG_FASTBOOT_MMC_BOOT2_NAME) == 0) {
+	if (!strcmp(cmd, CONFIG_VAL(FASTBOOT_MMC_BOOT2_NAME))) {
 		dev_desc = fastboot_mmc_get_dev(response);
 		if (dev_desc)
 			fb_mmc_boot_ops(dev_desc, download_buffer, 2,
@@ -388,7 +388,7 @@ void fastboot_mmc_flash_write(const char *cmd, void *download_buffer,
 #endif
 
 #if CONFIG_IS_ENABLED(EFI_PARTITION)
-	if (strcmp(cmd, CONFIG_FASTBOOT_GPT_NAME) == 0) {
+	if (!strcmp(cmd, CONFIG_VAL(FASTBOOT_GPT_NAME))) {
 		dev_desc = fastboot_mmc_get_dev(response);
 		if (!dev_desc)
 			return;
@@ -415,7 +415,7 @@ void fastboot_mmc_flash_write(const char *cmd, void *download_buffer,
 #endif
 
 #if CONFIG_IS_ENABLED(DOS_PARTITION)
-	if (strcmp(cmd, CONFIG_FASTBOOT_MBR_NAME) == 0) {
+	if (!strcmp(cmd, CONFIG_VAL(FASTBOOT_MBR_NAME))) {
 		dev_desc = fastboot_mmc_get_dev(response);
 		if (!dev_desc)
 			return;
@@ -440,7 +440,7 @@ void fastboot_mmc_flash_write(const char *cmd, void *download_buffer,
 	}
 #endif
 
-#ifdef CONFIG_ANDROID_BOOT_IMAGE
+#if CONFIG_IS_ENABLED(ANDROID_BOOT_IMAGE)
 	if (strncasecmp(cmd, "zimage", 6) == 0) {
 		dev_desc = fastboot_mmc_get_dev(response);
 		if (dev_desc)
@@ -450,8 +450,8 @@ void fastboot_mmc_flash_write(const char *cmd, void *download_buffer,
 	}
 #endif
 
-#if IS_ENABLED(CONFIG_FASTBOOT_MMC_USER_SUPPORT)
-	if (strcmp(cmd, CONFIG_FASTBOOT_MMC_USER_NAME) == 0) {
+#if CONFIG_IS_ENABLED(FASTBOOT_MMC_USER_SUPPORT)
+	if (!strcmp(cmd, CONFIG_VAL(FASTBOOT_MMC_USER_NAME))) {
 		dev_desc = fastboot_mmc_get_dev(response);
 		if (!dev_desc)
 			return;
@@ -485,17 +485,17 @@ void fastboot_mmc_erase(const char *cmd, char *response)
 {
 	struct blk_desc *dev_desc;
 	struct disk_partition info;
-	struct mmc *mmc = find_mmc_device(CONFIG_FASTBOOT_FLASH_MMC_DEV);
+	struct mmc *mmc = find_mmc_device(CONFIG_VAL(FASTBOOT_FLASH_MMC_DEV));
 
-#ifdef CONFIG_FASTBOOT_MMC_BOOT_SUPPORT
-	if (strcmp(cmd, CONFIG_FASTBOOT_MMC_BOOT1_NAME) == 0) {
+#if CONFIG_IS_ENABLED(FASTBOOT_MMC_BOOT_SUPPORT)
+	if (!strcmp(cmd, CONFIG_VAL(FASTBOOT_MMC_BOOT1_NAME))) {
 		/* erase EMMC boot1 */
 		dev_desc = fastboot_mmc_get_dev(response);
 		if (dev_desc)
 			fb_mmc_boot_ops(dev_desc, NULL, 1, 0, response);
 		return;
 	}
-	if (strcmp(cmd, CONFIG_FASTBOOT_MMC_BOOT2_NAME) == 0) {
+	if (!strcmp(cmd, CONFIG_VAL(FASTBOOT_MMC_BOOT2_NAME))) {
 		/* erase EMMC boot2 */
 		dev_desc = fastboot_mmc_get_dev(response);
 		if (dev_desc)
@@ -504,8 +504,8 @@ void fastboot_mmc_erase(const char *cmd, char *response)
 	}
 #endif
 
-#ifdef CONFIG_FASTBOOT_MMC_USER_SUPPORT
-	if (strcmp(cmd, CONFIG_FASTBOOT_MMC_USER_NAME) == 0) {
+#if CONFIG_IS_ENABLED(FASTBOOT_MMC_USER_SUPPORT)
+	if (!strcmp(cmd, CONFIG_VAL(FASTBOOT_MMC_USER_NAME))) {
 		/* erase EMMC userdata */
 		dev_desc = fastboot_mmc_get_dev(response);
 		if (!dev_desc)
diff --git a/drivers/fastboot/fb_nand.c b/drivers/fastboot/fb_nand.c
index 6df3917e129..1d8db1c8b11 100644
--- a/drivers/fastboot/fb_nand.c
+++ b/drivers/fastboot/fb_nand.c
@@ -94,7 +94,7 @@ static int _fb_nand_write(struct mtd_info *mtd, struct part_info *part,
 {
 	int flags = WITH_WR_VERIFY;
 
-#ifdef CONFIG_FASTBOOT_FLASH_NAND_TRIMFFS
+#if CONFIG_IS_ENABLED(FASTBOOT_FLASH_NAND_TRIMFFS)
 	flags |= WITH_DROP_FFS;
 #endif
 
diff --git a/drivers/fastboot/fb_usb.c b/drivers/fastboot/fb_usb.c
index 0e25e43047e..90380d37ef6 100644
--- a/drivers/fastboot/fb_usb.c
+++ b/drivers/fastboot/fb_usb.c
@@ -41,7 +41,7 @@ int fastboot_usb_run(int controller_index, void *buf_addr, u32 buf_size)
 	}
 
 	while (!g_dnl_detach()) {
-		if (IS_ENABLED(CONFIG_CMD_FASTBOOT_ABORT_KEYED)) {
+		if (CONFIG_IS_ENABLED(CMD_FASTBOOT_ABORT_KEYED)) {
 			if (tstc()) {
 				getchar();
 				puts("\rOperation aborted.\n");

-- 
2.55.0

