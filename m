Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E3FC369D3
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 11:40:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05B5388B9F;
	Wed, 25 Sep 2024 13:40:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CNYC6NeP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2D1088B9F; Wed, 25 Sep 2024 13:40:39 +0200 (CEST)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C519F88B59
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 13:40:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-49be2ef28aaso2170534137.3
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 04:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727264429; x=1727869229; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uRAoS07zdf4yoX94SbN5uCDHJggIGxQ+h1gDDLMxKxY=;
 b=CNYC6NePfeoKDUOYlcMgX/AN7Vh9LuNdE2ldUnFHaytuyd0ft1FkIf4b5xPhwY0K+w
 cIi/DGBVjX9G2MwnFRJdAYVnArmjVHAqzZk+VunAYhhPJI3SIYHq5Nb/1DX10GC/UvX3
 uqC1bYzfScjVoM731OOUVluyWaLguCjx8eXhG8NO/Xc1n3GoURL4CCOn6045fEGNgtJO
 Tshg64ZN4MOssvbWPLyA0tAfgW3KCB4hTbI8TdPI+D/B56VkJxU6M23YbnSZA6oP7tub
 Kz76P+H1Xgw00HTleoZkxyZVsRp1bDIdzLA8+vu4pC2KuW0olLW3Z7UPP5oBhgJnnT+7
 EZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727264429; x=1727869229;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uRAoS07zdf4yoX94SbN5uCDHJggIGxQ+h1gDDLMxKxY=;
 b=sVZ5U3d7sgIGV5E7DN2o4VtvH+0v3fm34qalfli+djo5jzA25ZgLB8kNcqoyD+AgtM
 Rst/M9rrnaW6oHscsCBEnvL6iDkcqRI+7mXxbN2vpKCkZ+rAzE3HUIT8WbUJuARNMRM/
 tNiSCNdzYNzJIB7aUl5pWrik8L3Ue6eEZsTNeb9NawgvJW1+vfsNchB7LpEXETDDEhYB
 JyaVSiEecsRDQa4JsFnIfLxr8BpHafiht9wAniheQt6nnf9SFeOCDEaXNG7uh5DWYMjj
 eDU3GMkiiF1ei+JF/g3qxCjvKOo2Ha0tPtFsSXEz66SV5b7TdlAH979lR0ZVUpRKuEzu
 14Yw==
X-Gm-Message-State: AOJu0Yxv2k+cwBfJoIVg/hnh77jLNk89nIgk2D2imdYxIwL9EfOg3ajm
 CCCMXFiyyh6KW36M9stn5rk9iEMeKWeua4Bhu5SdOqjLNrC2Xwew
X-Google-Smtp-Source: AGHT+IH9l0v4dtR+PuthMBnCyN0ZzR3rZqhzMdfnIRQ+WFiHIINo25bN54t3an/ofsy6ovXJp4xHnQ==
X-Received: by 2002:a05:6102:2ace:b0:49c:103:62f1 with SMTP id
 ada2fe7eead31-4a15dc94bd7mr1975336137.16.1727264429377; 
 Wed, 25 Sep 2024 04:40:29 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:a504:e27a:e2d0:762b])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-84e73b2631dsm1580029241.16.2024.09.25.04.40.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 04:40:28 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-next-20240925
Date: Wed, 25 Sep 2024 08:40:25 -0300
Message-Id: <20240925114025.307966-1-festevam@gmail.com>
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

Hi Tom,

Please pull from u-boot-imx/next, thanks.

The following changes since commit 0aea8264f668bdcb2f352e6facc8d1cebe873e0a:

  Merge tag 'xilinx-for-v2025.01-rc1' of https://source.denx.de/u-boot/custodians/u-boot-microblaze into next (2024-09-23 08:11:01 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20240925

for you to fetch changes up to 99abeaa648052e8e99682f046b8dfd3739b4e181:

  net: fec_mxc: Skip recv packet process when fec is halted (2024-09-24 16:55:14 -0300)

u-boot-imx-next-20240925
------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/22406

- i.MX93 FEC fixes.
- Always name the generated fitImage u-boot.itb to keep compatibility with
pr-buildman behavior.
----------------------------------------------------------------
Marek Vasut (1):
      arm64: dts: imx8m: Always name the generated fitImage u-boot.itb

Peng Fan (1):
      net: fec_mxc: Fix clk_ref rate on iMX93

Ye Li (1):
      net: fec_mxc: Skip recv packet process when fec is halted

 arch/arm/dts/imx8mm-u-boot.dtsi |  1 +
 arch/arm/dts/imx8mn-u-boot.dtsi |  1 +
 arch/arm/dts/imx8mp-u-boot.dtsi |  1 +
 arch/arm/dts/imx8mq-u-boot.dtsi |  1 +
 drivers/net/fec_mxc.c           | 10 ++++++++--
 5 files changed, 12 insertions(+), 2 deletions(-)
