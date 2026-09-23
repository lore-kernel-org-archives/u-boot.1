Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80141C98304
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 21:18:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1535960BE3;
	Wed, 23 Sep 2026 21:18:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H9oyMzOkaZHj; Wed, 23 Sep 2026 21:18:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D65C160B8B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790198298;
	b=PDL3nCEyfsMAgWD9q85zpYVJe/BhbEI9Eq0emB0T8PQLIgvK23D2ryDqWAHj+jTBfJBj
	 Lqc5tm62CoOjUJIczpw7yJjYw2ZSUcXQUJNhAaYda2Nm1fxUNqAeVOaPHnCoocbJIAASv
	 MD96S+oR3pt3qu+by6PJYd86cWSvxTjmBaNwhtBnbksBFpYBSg4Bc/6kZcp220rnT3RWw
	 s1QjuvkS/P5QexavJOQqOp3vg/4DjQhtPyFnFozuy0PuGk9jmZ5P5uz7Ez+O147VUYVfQ
	 d7SCnky1TX57R3tpN79PQQ7kuqS6qi4YmnMuCfPRin+AsGUGJwQvstj+NisqYdZhm3g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790198298;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=h3MRoqslbgWR5UnYX+VWGxe5X/qxlBp4ZnCOOkhV9HA=;
	b=nrYcI7zD21BIJifBkEZeig4FPYkjRJE7QG5YklN0HRp6Dkue+ZE3SvE3dIVBhN7TsyN4
	 cS9IDTYU8oX8v6lEY0QudpHPd5B5Pffw3xr7666NhzScjI1AKtejmuXPgO2T0uIiTMbhl
	 ArTPV08AJ7/RgiC73AojWr0GdkBUCaKVGYcday0ED3nuBL4cGhYR2wBHaNDyA14gOdmFZ
	 pN/aSGByqVScsgrn3FFqobiQUNdb8cL1hNpDebM4gHR7nEu70O4Wwg+azf9WUQKcDBxBn
	 uK677SCsq139F5WKOS0l9/YyWeFM0m+zWvQZNDBXVl227Cgb3ptL5VyN7O0LpEYJBzA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=pbTJ7ZVO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790198298;
	bh=h3MRoqslbgWR5UnYX+VWGxe5X/qxlBp4ZnCOOkhV9HA=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qbEM3BjhK0VbvhYBSW87kwQVtSZUiMsvuvqh17nBLnCNcYq+JiHKCEmErWDJE0ItW
	 +emRwKUIVOkxBZCUDobqc650BaM3YJ5sRkKnqMhfzcCzmSI5sI+3QIAyz4YJ92cnL4
	 NXNORr//UdcgGeuyeFZTblw5izK/8i8QqjxM1L7bft2rXJLZxG7k4aJ1cBd4ChjR9M
	 mKk0fUrY2mPad0n1h/YSLimI90AdkB+tYoNJ9bqvsjOqcmtsZlpovnO0wNuODOb8zJ
	 +sPR7e/3R4b2wy3oG1trhAFvXU7CN+SqSAR03FXu96Z9VLULt9gw4l+VfPYjJ2a/UA
	 v4FcCS6eTxcyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D65C160B8B;
	Wed, 23 Sep 2026 21:18:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0028832F
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:18:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D9C5F60B8B
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:18:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vd8aE5vT8ejf for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 21:18:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4A46F60B85
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790198296;
 b=PraX/fe/OZteX0WHt7bFqpO0RR0cDlBVYHrIZf18vLI97lYK4VyIaBYJNCjNQnYEey8+
 QYtunI/LkxNuV1M2aIH4b/fRl7zraFPgvScn4xJf97f7DaBk431be7Ri/pvHob2gQ2/mL
 QCHenXYNuxTucrIAH5EKuGSmoKljieR6Uh2h484Sa7lx9IgWlEAeP81qBd3dpgLT43cOG
 vu4tYk5PzijDAcHFkfF0rFQ+iqlFlu+s0bG8AY8e986fdaFERTFRx72T798kC7sfW6/v2
 snLSIUT2MivQHOLPA6BgPkhg7q5CA8DyZWfzURY5VygaqfymrMkieVdb4S2dTwq94BA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790198296;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=h3MRoqslbgWR5UnYX+VWGxe5X/qxlBp4ZnCOOkhV9HA=;
 b=SYhWd6DemBEbSYDyQa5Ctu39M9wDSYHOCxaCuuOM/nRAkv5dI7SBAqpDOtuLAcypGJnv
 jvP15nmgy5u3loYSVWPSBo82o9/GANUkJCJvRfhW5culh2o1FuhqVBfrs8aG6XhwdlHGV
 4ZUQxuOJdrV6Lgk7IhJDwgJud2/q52VeSboCMxsQoLutMoVaV7LQaxHB0wCyUd7IwQ8Cv
 AacfEMw10UOuAvbSX5x+n+xprnmsclC1d8pa797iKtFwlQpnktI50IuqqX50Amb3mSpsZ
 ajzIoMmkBigfUWILCDrWThpGhZy1TDI1eJ5XtVI4faJSypaO6jpO9Tw08PQR+txPN9w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=pbTJ7ZVO; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=pbTJ7ZVO
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4A46F60B85
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:18:14 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd5462b69so7914055e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 14:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790198292; x=1790803092;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=h3MRoqslbgWR5UnYX+VWGxe5X/qxlBp4ZnCOOkhV9HA=;
 b=pbTJ7ZVOZZsM/IdX7pTGGckXPpNdRI3ZJo1ojLv0nte8KIp+UxB6pDNcmrLrsqyXpH
 KAkLmpNhN6eOLKLOZ2mBswbHxn3x8rgN37mT5DGD9TUiYmDgqz+wh+5pY7M4SABggidg
 gv8qGayD1XB/NdcvyBnmJe4FjleqDrkJhwGtdWgmCMlVS0/E2p/OVj6O5+OvNYeqql5V
 3DejFVGmZFpseEEfaRBhdzaBhvJErdT9y6b/3Xr0bFCj1i2PaLLtSU4hNaEiXBC+yvRn
 Tl5DKdicT65HVwQDZhTzdlbLXhFfj+Pq3/u7J5Tra2B1j7VQGKLQRFym0R/mxKQShG4Z
 Th0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790198292; x=1790803092;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=h3MRoqslbgWR5UnYX+VWGxe5X/qxlBp4ZnCOOkhV9HA=;
 b=f4ab5CWp9KB4TcvnJf1wcRdwaaLE9zGkW+nGT3yu59JEanjyZzXO0IJ/n1aIkui3Mg
 Im7FqZCmpziBLuJupUvmA26gsqIxmdSRLv/8yBpV/t8hr9uTfBCHAJDwPS+fneELw1Xy
 S2pBBambyhJ3gRp2D9zL4p2HCrRpl0fBY/z2hTquqL1JYNjErF+FTNCLoVkOOmULn2Sj
 eaoOeYiKCZUByRND/X1CXsqIp7ZjYV9Rs7blbM63hIR2poFU8wEzhkis5AVgYAuhu/m5
 aYlzbSfsYvQCLzF+tweZYeK3QgUU1epWoqOZ643Yv77XJfXntQq599sXa+AY9kTU/ASm
 mZ0Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByj8BNq0iImqbL0iJrFIABCFM1U7w5ZYtG0A/ioXgTxxZyHeZRSvD+EVrrLaIl/hzOf7YPGmP8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l3+ZBSI7TDFEDQwbOgrJ/gxQtNBsmljCEJAK6LCcHe/t8dohe0
 PTfWc95mMKHcEqnicrbEf05AQwjQA2Ss73B+XEtVP9tdkFIXv8iVZqEjIVFhl+TMvEo=
X-Gm-Gg: AYBFou2oLrQ/irr5mwvwKE4yfL+LrqLNp2xfdrGdzr0lm46DtvRzkUnwbvjpFaio5kh
 lbHNafoo690QijBCVd0R7RN7S/FQaciBnQ4ahSMxMC68Lm8vdY1r6vQtxtldFbHBA89/J7Jqe01
 Xwe4Q0QU9rdokxD/zjI1O4IiZBOOp85LusU2PJn8tIzgwOsrM4n37zlDdRw99HM8zDawjs9tHus
 zu4kHE3zJ8iuUYhnUtdmyWkDr88CAwTQEYiXIZQ8AmR66SXHRdGlc6PtPWLJSdojVEjOMCEf9By
 zmOS5u+eQaKyxEVYytHmo4WkXL2MwZ+0QbYpgJtrHbq30JIBIbHAfqbnMY4pbmwr0kgWWoDZZTF
 B9YhS3LXEG5cS6ZeW0hPr06vhB2sutDY0bLrVG6ovbv2USKahV0j9oHVeUvNFat9jq6zZyA9Hdl
 Y6NiLlcYj+rdYd7q5yee1ijKVxSqFE46uYRBtJAuWH1afrwi91Vs8aBYWm4/GtH4TXObd9QIboG
 ILDeT/AxPQMlSip2Ru2R+47yIjXk9YYkqngJgM3+AWWNkIaj+TmYMFLkNwUnLU=
X-Received: by 2002:a05:600c:4e14:b0:49f:ce78:3563 with SMTP id
 5b1f17b1804b1-49fe66f1a7bmr6869785e9.20.1790198292227; 
 Wed, 23 Sep 2026 14:18:12 -0700 (PDT)
Received: from [127.0.0.1] (host-95-232-147-181.retail.telecomitalia.it.
 [95.232.147.181]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-488687791cdsm8684345f8f.22.2026.09.23.14.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 14:18:11 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH v2 0/3] Add Genio 510 and 700 BootROM download agents
Date: Wed, 23 Sep 2026 23:17:41 +0200
Message-Id: <20260923-ccaione-upstream-mt8390-da-v2-0-8f264678ac29@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Qy27DIBREf8ViXSoefkBW/Y+qiwtcGqo4OICtR
 pH/vdjOqpW6HGl05mgeJGMKmMmpeZCES8ghXmsQLw2xZ7h+Ig2uZiKY6JnmjFoLtYJ0nnJJCCM
 di5KaUQfUC69a3oMRoEgFTAl9+N7h7x9HzrP5Qls24rOR8DbX1XLUiIGM1MZxDOXUaGRMtG1nH
 XPt4KTuO8mF5wL1AFwhR6eM6+SGGjFn2HWr/SEr/8rm6UI95GJiLHTpafV20oDiMKATbwbul2A
 SvlYDsimfQy4x3fd7Fr4bPuHtf08svJLN0HuNkoGV6hd5XdcfTZ38HHoBAAA=
X-Change-ID: 20260910-ccaione-upstream-mt8390-da-f2f8416ab2a8
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Carlo Caione <ccaione@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>
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

Genio 510 and 700 need a way to provision blank eMMC and recover boards
with unusable boot firmware. Add RAM-based fastboot download agents that
can be loaded through the MediaTek BootROM download protocol without
relying on the installed bootloader.

Fastboot in U-Boot proper is preferred when the complete download agent
fits the platform's BootROM payload limit. It provides U-Boot's shell and
boot facilities as well as flashing. The SPL variant offers a smaller
executable payload when including BL31 and U-Boot proper would exceed
that limit. Both require an external DDR loader and run fastboot from
DRAM after DDR initialization.

The two paths start USB fastboot at different stages:

   Fastboot in SPL                   Fastboot in U-Boot proper
   ---------------                  -------------------------
   BootROM USB download             BootROM USB download
   (host -> SRAM)                   (host -> SRAM)
     |                                |
     v                                v
   DDR loader                       DDR loader
     | Initialize DRAM                | Initialize DRAM
     | Copy SPL to DRAM               | Copy SPL + FIT to DRAM
     v                                v
   SPL                              SPL
     | USB fastboot <-> host           | Load BL31 + U-Boot from RAM
     v                                v
   eMMC provisioning                BL31
                                      |
                                      v
                                    U-Boot proper
                                      | USB fastboot <-> host
                                      v
                                    eMMC provisioning

This series is based on upstream/next plus generic SPL fastboot V6,
now applied to u-boot-dfu-next [1]. Genio SPL support is already in
upstream/next.

[1] https://lore.kernel.org/all/179015047421.246261.8241758059641679018.b4-ty@kernel.org/

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
Changes in v2:
- Rebase onto upstream/next, which now includes Genio SPL support.
- Align shared DA filenames with the mt8370 Genio naming.
- Use fixed USB peripheral mode instead of the private force-vbus DT
  property, with corresponding MTU3 driver support.
- Limit RAM boot to the U-Boot DA and use phase-specific MMC settings.
- Separate shared and per-agent configuration, and make DA and normal
  storage-image configurations mutually exclusive.
- Build the SPL DA entry only in SPL and simplify FIT key handling.
- Keep the SPL allocation limit large enough for sparse image writes.
- Select the eMMC user area when resuming boot with SPL fastboot continue.
- Explain the preferred U-Boot DA and the SPL alternative for tighter
  BootROM payload limits; clarify DT requirements and continue behavior.
- Link to v1: https://patch.msgid.link/20260914-ccaione-upstream-mt8390-da-v1-0-b76f9e30ac38@baylibre.com

To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>
Cc: Julien Masson <jmasson@baylibre.com>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Chris-QJ Chen <chris-qj.chen@mediatek.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Alexey Charkov <alchark@gmail.com>
Cc: Vitor Sato Eschholz <vsatoes@baylibre.com>
Cc: "Pablo Sun (孫毓翔)" <pablo.sun@mediatek.com>
Cc: Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc: Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Carlo Caione <ccaione@baylibre.com>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Michael Srba <Michael.Srba@seznam.cz>

---
Carlo Caione (2):
      arm: mediatek: enable U-Boot fastboot DAs on Genio 510 and 700
      doc: board: mediatek: document Genio download agents

Julien Masson (1):
      arm: mediatek: enable SPL fastboot DAs on Genio 510 and 700

 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi      |   8 ++
 arch/arm/dts/mt8370-genio-da-u-boot.dtsi           |  64 ++++++++++
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi      |   8 ++
 arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi       |  17 +++
 arch/arm/dts/mtk-genio-da-fit-binman-u-boot.dtsi   |  62 ++++++++++
 .../dts/mtk-genio-loader-spl-binman-u-boot.dtsi    |   2 +-
 arch/arm/mach-mediatek/Kconfig                     |  58 +++++++++
 arch/arm/mach-mediatek/Makefile                    |   3 +
 arch/arm/mach-mediatek/spl.c                       |  22 ++--
 arch/arm/mach-mediatek/spl_fastboot.c              |  68 +++++++++++
 board/mediatek/MAINTAINERS                         |   8 ++
 common/spl/Kconfig                                 |   2 +-
 configs/mt8370-genio-da-spl-fastboot.config        |  21 ++++
 configs/mt8370-genio-da-uboot-fastboot.config      |  28 +++++
 configs/mt8370-genio-da.config                     |  12 ++
 configs/mt8370_genio_510_evk_da_spl_defconfig      |   2 +
 configs/mt8370_genio_510_evk_da_uboot_defconfig    |   2 +
 configs/mt8390_genio_700_evk_da_spl_defconfig      |   2 +
 configs/mt8390_genio_700_evk_da_uboot_defconfig    |   2 +
 doc/board/mediatek/mt8188-genio-evk.rst            | 135 +++++++++++++++++++++
 drivers/usb/mtu3/mtu3_core.c                       |   5 +-
 21 files changed, 518 insertions(+), 13 deletions(-)
---
base-commit: 9e002445cd0d47d3965312f12e97a18e1ed8bd53
change-id: 20260910-ccaione-upstream-mt8390-da-f2f8416ab2a8
prerequisite-message-id: 20260913-ccaione-upstream-spl-fastboot-v6-0-dd3ba81a7ed2@baylibre.com
prerequisite-patch-id: ebe0842a87ef1a27c9882d7c45823b37ef84e5a8
prerequisite-patch-id: 7df6bdcd4e7a655d86db0447593b2bf36050b049
prerequisite-patch-id: e98c322def69bb8ecec30dd41c05aa62040b1008
prerequisite-patch-id: 553ddc59d4de9ff9f1949875939979cbeab2eaac
prerequisite-patch-id: 8d8c1917bfcee87fecf6077a117c8a11cc402cdd

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

