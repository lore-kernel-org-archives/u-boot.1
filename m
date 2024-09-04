Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6B5CD4842
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 02:43:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D601E88B49;
	Wed,  4 Sep 2024 04:43:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h/HIh2ju";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F04A88BC0; Wed,  4 Sep 2024 04:43:19 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BE3488AE8
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 04:43:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7c3d8f260easo3348312a12.1
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 19:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725417796; x=1726022596; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZU3dj6/Sf4gvIiiDH43cVWSELadgABw/5xyf28cald4=;
 b=h/HIh2ju3o1wF//dsU1ZyE1BqPOCnLNq87TXL3/VNAppI45VI27LyWJD5ngD8Z02Qj
 9mDmYhVLyYHHIFwYSSPfUDaXoMkA4f893dJOHaeMm17e4fnCEY1N8e3jhE0kXwM2cpiu
 JvAz+1AoUXXDAAtC0PIoFC6zbIeeEwkkJAuJn884vOMtxPJx/TNu76OBm+XpHaBwSVXN
 KDm2FIoJIAyvsQF9Al4t4vUfqD6gS0D1UK2juK1RX9BxEeyq4XlTgnMJ4hbEK2Xdxwz9
 6vuqw0pBfRgWoHXm7ouqGQzBB5+UfuxEKMCS89SqXN/N3qtcf10TS+gDqFeSJV8YB5wq
 mw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725417796; x=1726022596;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZU3dj6/Sf4gvIiiDH43cVWSELadgABw/5xyf28cald4=;
 b=rowuSGF/BZWrCjmzq3Pe+Mk2jhW6Ae/6v3XbD2kRDBDehCOwyAm+x5dPellJTSPM4n
 ngggiAQVd9lPZOFWTsonNSWKtGKlqooWhFVgyDQIE93LbsqkvbaXMRtyZdz9KBdWUDFD
 IizVw2QtH1U9LhcJTmNZMtgUf+d9RxIH+MLqydAOXp+mXy79LMCCBCWPSPAIZVANa2zS
 +KfJJmXGzkzAr2tEpaJ5V0DAIdkEd6gZeSt5apxw1dX/QjYfUH+GrDcbMhQzkcEBGM1w
 3uFAl8YiI8/8r4FnJplhlbiPFNwFcV/N7292nmzkQ34xj/0qo9dJzvDYq+5mMrIyz4DL
 Lcxg==
X-Gm-Message-State: AOJu0Yz4PrPEV8fGnPxl/vcCMx3H+9anw17NE+uxT5sdWzZDXe1evA6D
 f6xCJRKtMPv6DRsaLgwrx7hGC59qcM7a4J+/3J3RIzXJjjVqnsb5YFXaPu5A
X-Google-Smtp-Source: AGHT+IGZ9YdTl+5C1bYZmE+jGnrvxQrSKq4SKtGTlIZ2OVfsy2yki80w3bsaXM2mVtHsmSLMFOQ8eA==
X-Received: by 2002:a05:6a21:1584:b0:1cc:da34:585e with SMTP id
 adf61e73a8af0-1cce10d92c8mr19351301637.46.1725417795722; 
 Tue, 03 Sep 2024 19:43:15 -0700 (PDT)
Received: from cs20-buildserver.. ([180.217.139.107])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2da7ba49b57sm1141829a91.18.2024.09.03.19.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 19:43:15 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com,
	trini@konsulko.com,
	jim.t90615@gmail.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/3] Arm: npcm: modify npcm8xx boot setting
Date: Wed,  4 Sep 2024 10:41:03 +0800
Message-Id: <20240904024106.2030437-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
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

Modify npcm8xx new boot design.
Correct memory setting and set gpio default value.

Jim Liu (2):
  board: arbel: correct the dram bank size
  configs: arbel_evb: change env offset and boot address

Stanley Chu (1):
  pinctrl: npcm8xx: clear all gpio events

 board/nuvoton/arbel_evb/arbel_evb.c       |  8 ++++++--
 configs/arbel_evb_defconfig               |  4 ++--
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c | 18 ++++++++++++++++++
 include/configs/arbel.h                   |  2 +-
 4 files changed, 27 insertions(+), 5 deletions(-)

-- 
2.34.1

