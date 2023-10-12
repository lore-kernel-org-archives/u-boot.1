Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511F8CDB47E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 06:56:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66E7B86DE7;
	Thu, 12 Oct 2023 08:56:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N2tFRjl0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2DE386DE7; Thu, 12 Oct 2023 08:56:12 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8FDA86CE8
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 08:56:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c0ecb9a075so5499515ad.2
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 23:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697093767; x=1697698567; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2Dd8R0ulBME9x/682OVzv59SSI8i2CmNe9yzlpj+Q0s=;
 b=N2tFRjl0a3ewCMcFN+yjVhe+7hxJX8L3ZKtwL8mejpGXccMOVN21bH4DDyYRbtnU69
 USveTu1BdZXSbhdKMrflQ08yuJ909hdRuhqPd8gTpN2hRmA3Y6df2K9pMPDTEKoOLsIE
 TTvE4wZqa0XgB9lTNIFB+m+bKMtnaU4CvVtpWlrFHGKwIIJq+m/QCkn9/fODleXnmLFR
 dy1hGLRskHJi9hEcBZs3NGXUQKBI55wpCeIxtbPXrljb0VOE/3gdWBdZ/Bza6CqKiXNw
 q46xfGuIg8dhyHjMPGqJI/mm+Yi+0AKdvx2FuPo3wSX5TIFDIlP0eZDbm5+rNWz01KyT
 624Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697093767; x=1697698567;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2Dd8R0ulBME9x/682OVzv59SSI8i2CmNe9yzlpj+Q0s=;
 b=Io5kx3B+qhKWnuery+nmMIlxAffc+lFs98tWCYmhq7+VHOBRek8UDEjXx+/XvwoLSx
 tMtea39Qg0Q1CIIYCUru6kt5LhVQvwy6EZSd/2HjLXl2elLy9tJJ6T2TBuDH6L2QMOdh
 kM6leLdtXvpf75/sR+zaUixan9w3WG56O7Xhaaxv7VgbMl4CxYX1r2xTINif8v7JGe0I
 RVft3Ruh8s1766b1shV5BxcrHN03DFk7wY8WoknnhKNRrZV/Mh4UMwEikpXFmMtQ/c61
 mWckcrbKaQjuwmQ1cjxxofGvugwgOiEA4+zLCd7QUdPCrmcksdE+6xI1Wg2GDA74Nk4Q
 QTjQ==
X-Gm-Message-State: AOJu0YzlcWVyxbvFrXZaqWIIzlidqKAw+av40gl3j1gS1Wn6OZZRCKlr
 JyKZ7nSAYE4R+Z+S1pKQnE6gxgtoR6k=
X-Google-Smtp-Source: AGHT+IHNWpDIvQTMqS1AGSwDlXLkTN8qqsAFQRTvzd3K7a0M9N8jRMgXNyxll1G/vvVZUKUEebENGg==
X-Received: by 2002:a17:902:cecb:b0:1c8:7d41:5b87 with SMTP id
 d11-20020a170902cecb00b001c87d415b87mr21467112plg.50.1697093767255; 
 Wed, 11 Oct 2023 23:56:07 -0700 (PDT)
Received: from cs20-buildserver.lan ([1.200.128.112])
 by smtp.gmail.com with ESMTPSA id
 s19-20020a170902c65300b001bc68602e54sm1096977pls.142.2023.10.11.23.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 23:56:06 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, YSCHU@nuvoton.com, KWLIU@nuvoton.com,
 trini@konsulko.com, jim.t90615@gmail.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 0/4] fix npcm bmc error
Date: Thu, 12 Oct 2023 14:53:19 +0800
Message-Id: <20231012065323.2709121-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
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

1. add name for gpio pinctrl function
2. add baud rate table
3. fix ecc ram size
4. modify configs

Jim Liu (4):
  pinctrl: npcm8xx: add name for gpio function
  configs: npcm: support more uart baud rate
  board: nuvuton: arbel: fix incorrect ram size
  configs: nuvoton: npcm8xx: disable CONFIG_SPI_FLASH_USE_4K_SECTORS

 board/nuvoton/arbel_evb/arbel_evb.c       | 17 +++++++++--------
 configs/arbel_evb_defconfig               |  1 +
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c |  1 +
 include/configs/arbel.h                   |  5 ++++-
 include/configs/poleg.h                   |  2 ++
 5 files changed, 17 insertions(+), 9 deletions(-)

-- 
2.34.1

