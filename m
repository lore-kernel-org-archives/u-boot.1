Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D06E7D26A
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 08:57:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E15F486DC6;
	Tue, 26 Sep 2023 10:57:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D+2LjdQa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB9F186DC6; Tue, 26 Sep 2023 10:57:05 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C949086D93
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 10:57:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-690bf8fdd1aso6364965b3a.2
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 01:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695718622; x=1696323422; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=piYAvzt8j9cXEf4+py1ciQiaAP/Gj+1aCKFp7Uo4Cec=;
 b=D+2LjdQazBoYD4Wnw+PPGGkeFL+16giWRVc3g3iGBY/nPsLoDmfVUNJZcOnsHEfh/y
 Qa+ixunZBfUQ3dTcAr7/uTOhf9eQnd5J31Un18gFx2SSCEQYVdRZyGj4/ykxCTq+5z1K
 YDikZYBNAem+qMLduBjg/0Sgw5vDKBUvV6BXnkV33WafrQwtQz0Q9l51lUucnQQ5Y/sz
 e0yrBZRY1FG1PMQU0F8U+PTCMFvne7WBDDepXU/JWxxHr4otWHZkEEn4uadxICxpA1O9
 kyBEoh1lGmuui+JLfyHynt1ga3NIv58lwuqco0IjEzzulTcsiwuyHxkU+CQkXFr82cZo
 vc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695718622; x=1696323422;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=piYAvzt8j9cXEf4+py1ciQiaAP/Gj+1aCKFp7Uo4Cec=;
 b=ILjI07V0dQ//lt8rd2Q2w30mysDaesSDNWBo7H6UG8KIFBksKETeEIjkuXx0/3kPdj
 ZbrQZg/fp/8ovvxggG74rsqpYZ/lrzearqrUYrfp2d36WjT/x1yoWEzGle30JRaX69IC
 n80I2nHi3IrM7LvpLmaEqPE8ezAvin+ZQXE/Zl8ByrJr4jUqoa6eswH9iOO9LDbXNP74
 88OzJhSweA07jTiL6IQ4ZvDeHSlWxEWJ3l7IzB24CDkTNKibQ9RQrfoKfBYc85Jyae4w
 FL6YuptWNpysoMAsZctHdJSVhMF+8vacdzXulqJ75nw6bZ7Bn8+kvBXGqXLONTvcqTgv
 h1pg==
X-Gm-Message-State: AOJu0YzLPAzy73WszaVs3VCXP+4gPlzFl5vAv4GMJu5BeLfm1EonkFzO
 DI4W2vI9g93BdodYg1u1C7I=
X-Google-Smtp-Source: AGHT+IHTrxv7KH/K4EQ9KSeya/sRcTf7+1xZVHCuSrN1YUbGl/AyMuUJmC9KfJ68xZe0tN0SJZZSDQ==
X-Received: by 2002:a05:6a20:729e:b0:13f:1622:29de with SMTP id
 o30-20020a056a20729e00b0013f162229demr7787012pzk.7.1695718622166; 
 Tue, 26 Sep 2023 01:57:02 -0700 (PDT)
Received: from cs20-buildserver.lan ([2403:c300:c707:b24b:e4c0:3696:f2d7:f673])
 by smtp.gmail.com with ESMTPSA id
 je20-20020a170903265400b001c5fc291f02sm6515863plb.216.2023.09.26.01.57.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 01:57:01 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, jim.t90615@gmail.com,
 trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/3] arm: NPCM: fix npcm bmc error
Date: Tue, 26 Sep 2023 16:56:47 +0800
Message-Id: <20230926085651.395069-1-JJLIU0@nuvoton.com>
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

1. fix incorrect ram size with ecc enabld

2. add name for gpio function

3. add baud rate table

Jim Liu (3):
  pinctrl: npcm8xx: add name for gpio function
  arm: NPCM: modify baud rate table and dram setting
  arm: npcm8xx: support dcache off

 arch/arm/mach-npcm/npcm8xx/Kconfig        |  4 ++++
 arch/arm/mach-npcm/npcm8xx/cpu.c          | 12 +++++++++++-
 board/nuvoton/arbel_evb/arbel_evb.c       | 16 ++++++++--------
 configs/arbel_evb_defconfig               |  1 +
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c |  1 +
 include/configs/arbel.h                   |  4 +++-
 include/configs/poleg.h                   |  1 +
 7 files changed, 29 insertions(+), 10 deletions(-)

-- 
2.25.1

