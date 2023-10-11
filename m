Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96FFBCD6E42
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 08:48:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E400286C0B;
	Wed, 11 Oct 2023 10:48:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F5Lc14Hz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08D7886C4D; Wed, 11 Oct 2023 10:48:15 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 760CC82BBF
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 10:48:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6910ea9cca1so4939748b3a.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 01:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697014085; x=1697618885; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jVv9mD1B4OHRRZq+t5mfmdAOivr+k2tqbj5m4jTRVQY=;
 b=F5Lc14Hz7/UbjGihjmzLyN/huqAoWcdlVrq+MMliPfRGBTKfIhHZ55FekjwDGsWFIx
 ietZbsgqpne8UCkt1Dk9iApWE+QXs+CrCtHdd29ruz6liTfxaM0dzK+Ucu00dxPx7fNN
 Mhi0DZV6/1VC6K1wUZUsnaSBeK1y7lek+qwp+Jqx0vUKNLEiXfuyynNknKiUgq/FZfom
 sSA6uRKHgvcq/YDL80VVjtS19Ypb6ys13Bj9BsAZjMFm8Lrv7vo2MEmKh9HPYnz2QyZq
 i+8NU1lMEAz21TcZArmhzFgdMp9EsGYWzumWqeYCB1oWXmS3FSdyxPLJpMlkQYgJUkjI
 pQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697014085; x=1697618885;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jVv9mD1B4OHRRZq+t5mfmdAOivr+k2tqbj5m4jTRVQY=;
 b=foujDRk0mhRtP7FsopzPRXGWDHOSplOBKVlBTAK6gshgrer+b2+K7pprQx7cpbKGEK
 7qMhLhUThX9mmsSVC/lWixJ13vnaNMCvtwuK5xpIdSWdUrDitMIZKNmoWqGok62sTf5a
 av0yArxzCdhI0AizJdVRPGDdX2f6Z/X0W5Yzko0GNb0h501LTz2pqQVeJNOLeaYwk6y/
 dQ0r6pEbSm7ISScZFzmqB7MT1GlASVoMqRPCwU2djomEISTNsl/ZsMqLl4UqeOtjyKza
 9wdUhQNKJoMXvZVAum9GOowblBSehmrGvqphhu5zOM6881UrHkAZJRd0SURNHmr71nTA
 mGoA==
X-Gm-Message-State: AOJu0YyEbCj3nUyKvEP3N6lkPwBpHW/u6tTfVP0ZGfqvOIa70/gvgGjr
 0zUYKBphIrOJKbxZuTiHXlg=
X-Google-Smtp-Source: AGHT+IEmBNiVy4MWzSNFptiG3elJf1Mg9QjK8ZBUpdx2vRLRHqwDInVryk8IWRfHmIPaZEkwg2N++Q==
X-Received: by 2002:a05:6a20:a121:b0:134:a4e2:4ac8 with SMTP id
 q33-20020a056a20a12100b00134a4e24ac8mr20902967pzk.39.1697014084652; 
 Wed, 11 Oct 2023 01:48:04 -0700 (PDT)
Received: from localhost.localdomain ([1.200.128.112])
 by smtp.gmail.com with ESMTPSA id
 m28-20020a638c1c000000b0059c8fa8f917sm2307940pgd.12.2023.10.11.01.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 01:48:04 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, KWLIU@nuvoton.com,
 YSCHU@nuvoton.com, trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 0/5] fix npcm bmc error
Date: Wed, 11 Oct 2023 16:45:28 +0800
Message-Id: <20231011084533.2325296-1-JJLIU0@nuvoton.com>
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
4. add dts
5. modify configs

Jim Liu (5):
  pinctrl: npcm8xx: add name for gpio function
  configs: npcm: support more uart baud rate
  board: nuvuton: arbel: fix incorrect ram size
  arm: dts: npcm8xx: add watchdog node
  configs: nuvoton: npcm8xx: disable CONFIG_SPI_FLASH_USE_4K_SECTORS

 arch/arm/dts/nuvoton-common-npcm8xx.dtsi  | 24 +++++++++++++++++++++++
 board/nuvoton/arbel_evb/arbel_evb.c       | 17 ++++++++--------
 configs/arbel_evb_defconfig               |  1 +
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c |  1 +
 include/configs/arbel.h                   |  5 ++++-
 include/configs/poleg.h                   |  2 ++
 6 files changed, 41 insertions(+), 9 deletions(-)

-- 
2.34.1

