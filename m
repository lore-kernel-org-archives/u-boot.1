Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4812CD37BE
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 02:27:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17E4386E61;
	Wed,  4 Sep 2024 04:27:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QR34VLX0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F995886A7; Wed,  4 Sep 2024 04:27:00 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E71B78657F
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 04:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2d89dbb60bdso226367a91.1
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 19:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725416816; x=1726021616; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZU3dj6/Sf4gvIiiDH43cVWSELadgABw/5xyf28cald4=;
 b=QR34VLX0QCIkkWtE9Ol5FN2V+03hwNoCEtzXW4FUGMsoaHv/6gU+AstlHSDfdL+Ogb
 Eo8Cyz4kKFdyFmu1ULlgf+iJGXeHtAy7UD0ZbhxM7saocmtiFF4Omh53YPEoBXvfah6s
 v7gmxK8Lf2qiWVjPRspzh9Muqhcnpe0J8cXGxyKqZKNsW23zRGgF6h05UDblNLZJBhBJ
 StNB1VQdmr8HC5acsAfVPHDKTAmwQTHd3IYp0CC+xd0T/UrSYj1kgvpP2nOm6JE72dty
 5m+PxN6DNsLqCGv+VJe09weMq9g/mBAoaioHHP4bCaUx6K7qSCPvtu2rYDQLKK/5TKna
 S3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725416816; x=1726021616;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZU3dj6/Sf4gvIiiDH43cVWSELadgABw/5xyf28cald4=;
 b=E7ghhflECilJTytZHQS1tbRS3GqGXfwLd4iqCM4F+J2inX4GJy7WJ6a3hLZYWdnbBR
 9957tvK7EeePOb+JZYyTMr/vW32d/ykIa7l6lb6KBuEReGqxlEE53O5cq3pOWIoUjMXO
 wSop+Wv2sZmQKyJ1nxmK5O7pm90wnqaVWqChn742d74/r0sLdwtZz6JO4mliabc5tR2E
 NR76BWvU0vGtj9ZSusDkHNXNI7EUvfVkP2DFksvjnGnLykBbSYWbxvZIpQ5zj1Hhi25S
 qdaNFDiYNJjxTycaEUBU9pfQnMTUz3XrzHowAzdSqDwfGkHe1lFKQ99nRQ/gtzNjBumf
 zjKw==
X-Gm-Message-State: AOJu0YyrKFDeVQ85uWX/xMyFCtxtWh2VjqVHTMXqFIC9A5fpdWYZa0de
 J0XVrzdVtpq2XyYnK6x4FAcRIAmoagME1crUvP6FTCN+5OOKUT3uwylxbmwR
X-Google-Smtp-Source: AGHT+IFfLLmS2//VcVAcSVQbFoKVzgDv1pO9/sbj4k3JpmI+7jp6Nzi9rlI/CtoSOqRIgb+q3hxHDw==
X-Received: by 2002:a17:90b:3b88:b0:2d8:adea:9940 with SMTP id
 98e67ed59e1d1-2d8adea9aeamr11897103a91.16.1725416816414; 
 Tue, 03 Sep 2024 19:26:56 -0700 (PDT)
Received: from cs20-buildserver.. ([180.217.139.107])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2da8497d5e6sm542148a91.52.2024.09.03.19.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 19:26:56 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com,
	trini@konsulko.com,
	jim.t90615@gmail.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/3] Arm: npcm: modify npcm8xx boot setting
Date: Wed,  4 Sep 2024 10:24:01 +0800
Message-Id: <20240904022404.2019365-1-JJLIU0@nuvoton.com>
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

