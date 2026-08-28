Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C24C61DB9
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 08:40:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 22043407D4;
	Fri, 28 Aug 2026 08:40:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TbaSYV3TfFLI; Fri, 28 Aug 2026 08:40:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787906408;
	bh=2ccyJSiuEAV2yp4Qh0ke4Sku0cNmI5psS3cxVoaKRDM=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rbw/9QxD8WJIWSeC+Z4AoE0V30ZoGaQjkFPhuCDVCDL0UoRwmVjLDuBN17CT2P4Z9
	 vZtp5e32MflgjArRkniYcQA8QFFUnnLFcclp7gbGb6VorJnxcBygi2u6pvn/VS1C3h
	 I1XHRXyTPfDH+DNzdcH+c/WpXJmMW/Z6o3eGC2yLyEjarmzsCUYlmwxmd2+UC3X9Xd
	 KuZHFN0eXIB6TIXmEDe04jBE+XSHZz1b2IWzDmFsmfiWhdki0N0Ror/I6BQcWw01XK
	 8geaJForzXJ45NeayMMqsebkuUy5QC6GXHQSQM4iRV6IuNqEdGkcDGcc8jdnXE8i8I
	 25YxqXZxWPzwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1FDC7407D3;
	Fri, 28 Aug 2026 08:40:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DFF25230
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 08:40:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C5E3A80EA4
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 08:40:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lOfvO8s8TSAD for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 08:40:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=o3MimVxw
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E841180E90
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 08:40:03 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-49b0eab380eso6449595e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 01:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787906402; x=1788511202;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2ccyJSiuEAV2yp4Qh0ke4Sku0cNmI5psS3cxVoaKRDM=;
 b=o3MimVxwxPny8ncEMhBq67Q3WJFmR2gtRwzLBEQghyPE17kbICU7x6YVQs7Gn8TsjA
 kxwoBbutvkPrRK6dM5vU5DYay/2vX2cg+86GDgvK0cwcuFmEn7mabaoIGnd8Mzf0Rqb4
 P5lhGiKKZlAQ30VHgNtOGOlELGCt0YFZwP3ppX0H8MB93dIb2arvZOY6CE0H38QzXEAt
 DXh85tj4LdwXN3kiOKknCOfIGX2jECkRb3/O1e5Y43QLRgvq3kF3SkRlkUST4EfEvA1L
 yBMIkqDBk0fjRIizN3gV0WR7hOF20OvTwMDNbLKdmO7zX4jmZgmvS9V255G757l2xqss
 oLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787906402; x=1788511202;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2ccyJSiuEAV2yp4Qh0ke4Sku0cNmI5psS3cxVoaKRDM=;
 b=DQkwq7ET6Ti6pcCqDQq9rSzBaC+IOrRZa8A0bcKPKEinDn7wcV4xYS6QE44hChkfrL
 944VoEPpJQpcLLFr4IN3jrlAM2f2Oh/LYdZfidM8CwZNvnLfvaDRvEnX/Scw7ZqHe/Yw
 hfmjO7qANCE2jiyGWCjgPxnsVMVwgbFmJSkU8ihlPMHdHvfRS2t1KovcZ/hdS+AmnA0J
 8T0nmpRoCLqcubXR/+Obw22X4q3s1zdUl6vq7C+vAeaRSgTdPs0wdGKoEwf4LGVKeGIK
 KLno4bcM3EaOR1fBVNz2bMhfeav3ziSage86RccXjV1riYU5toIIcpbUDfKd7YQex8rq
 dAew==
X-Forwarded-Encrypted: i=1;
 AHgh+RrDCVIh8kg5GOjJoQBME1qBOV1YuV50bXgb6g3MO/o1CtWt3fY1WXqXaXZAcVSTLIeJuWMQSB0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ng46EbmJxr96aqmc5pSVyZEamgKhntN+2bDsXSoASyUSSgC/Jl
 PH+U3cIVJWKdfg1W3lZGKJu0aHR5KvLEyAtRLt0y2gbRJ73OnpMONGMis8+gF7ROBUs=
X-Gm-Gg: AR+sD13nY4So6K4NH61fAlSnEJcvTArHEtpmTZnDjYb6dXVaLgvaBJ0FmfbK8onALtJ
 nllth6vRsbVS9XEVGdsaYeVzbz19bhqj97HpRnfYI8YS+PpxdINZ7M7Rig971QCan1AHLGfPHYH
 q+B82zlSY83LSmMC2SCMsynsWHitBcw7IjCacLVH6AWOgiTaCFS1TiIqv7YlGnpUoakLYvH05PP
 M9E6vxcXTGSC5DecnVReoBi4PGiV+Y1KCJM2+HWO0KHLSCuxCylgXTKmJ1oaTvNqBAhgH+oIXu9
 dVVbpCG87n3KsMXR+sQytJjLo/R/Vqvi3pvm9JEKgvks3/PD8GVVvpjjMUEUUM83daa/T2cq3eQ
 /YPSDVPy/KscXIw/zC8Iyduil4astODMcgAZKngGPEi/Z9vDwouEVoKEvRAYYO5nelcfxd4shsH
 spz3GhEoozpEtXPb+Pn9PdVNCbVU/RJZYKg4ZIDttPfrq1T3RhKP05nFIFOPqEa7Txzkmx1wT27
 tGS91fCBADh3/cpTwbgh2XafJwoto12OE7jlysB04DxmhuD/WrcyOA4RAXtJpAB9pMcy18Jn/vL
 5i4sBZrLWg==
X-Received: by 2002:a05:600c:3104:b0:495:5d6d:9cc1 with SMTP id
 5b1f17b1804b1-49b919ddbbbmr58902115e9.0.1787906401920; 
 Fri, 28 Aug 2026 01:40:01 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-212-171-227-71.pool212171.interbusiness.it. [212.171.227.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b9500c80asm34428435e9.9.2026.08.28.01.40.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 01:40:01 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH 0/3] Add RITY devicetree preparation support
Date: Fri, 28 Aug 2026 10:39:55 +0200
Message-Id: <20260828-ccaione-upstream-mtk-fdt-prepare-v1-0-bf80b489eb0f@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNQQrCQAxFr1KyNtAOtBavIi7SmYxGaR2SqQild
 zfq8j0+729grMIGp2YD5ZeYPBeH7tBAvNFyZZTkDKENQzuGI8ZIPmFci1VlmnGuD8ypYlEupIz
 DmPuO+pwCE3jGfZb37+J8+bOt051j/XZh3z8M6BYyhAAAAA==
X-Change-ID: 20260827-ccaione-upstream-mtk-fdt-prepare-68f51a5fd2ea
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, Carlo Caione <ccaione@baylibre.com>
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

RITY images select a base devicetree and an ordered list of overlays
through the storage, storage_dev, dtb_path, boot_dtb, fdtfile and list_dtbo
environment variables. EFI boot needs the selected tree to be assembled
and published through fdt_addr before the operating system is started.

Add MediaTek support to consume that interface. It locates the selected
source on GPT block partitions or on the RITY UBI/UBIFS NOR layout, loads
the base DTB, applies list_dtbo in order and publishes the completed tree.
Both raw and authenticated DTB and DTBO inputs are supported.

Expose mtk_fdt_prepare for interactive use. Retain the dtbprobe and
fdtprobe command names and positional arguments used by RITY EFI boot
environments. Also provide bootembedded for legacy boot. It locates and
runs the appended RITY boot script through the standard source command,
leaving the legacy policy and authentication to source and bootm.

The implementation uses existing block, MTD, UBI/UBIFS, libfdt overlay,
image verification, source and bootm services.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
Carlo Caione (3):
      arm: mediatek: add RITY devicetree preparation
      arm: mediatek: add RITY devicetree compatibility commands
      arm: mediatek: add bootembedded compatibility command

 arch/arm/mach-mediatek/Kconfig            |  45 +++
 arch/arm/mach-mediatek/Makefile           |   3 +
 arch/arm/mach-mediatek/cmd_bootembedded.c |  59 ++++
 arch/arm/mach-mediatek/cmd_fdt_prepare.c  |  66 ++++
 arch/arm/mach-mediatek/fdt_prepare.c      | 502 ++++++++++++++++++++++++++++++
 arch/arm/mach-mediatek/fdt_prepare.h      |  10 +
 6 files changed, 685 insertions(+)
---
base-commit: 964ad5b5c91b7be56e443e899d7f873e6aa8c9fc
change-id: 20260827-ccaione-upstream-mtk-fdt-prepare-68f51a5fd2ea

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

