Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51777EEB57C
	for <u-boot@archiver.kernel.org>; Sat,  9 Sep 2023 09:33:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F7868620C;
	Sat,  9 Sep 2023 11:33:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SAjXZIFi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DE4D864E6; Sat,  9 Sep 2023 11:33:20 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C5F485DFA
 for <u-boot@lists.denx.de>; Sat,  9 Sep 2023 11:33:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimo.pegorer+oss@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-400a087b0bfso29780195e9.2
 for <u-boot@lists.denx.de>; Sat, 09 Sep 2023 02:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694251997; x=1694856797; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=tjh6M8T7M9/5cZNppq/BbQKOlM0Ct71YjzpIfPNUx3c=;
 b=SAjXZIFid4ajNYzhBW4EIU7FBoJf3I5FmBm33qvXxrOB5/sAP2Srrmbzz9QQFVsfK2
 r51PzlQ4R8BsCcU9R+Pw/uixUcWG0Ail23oER7T1BNSq0VsFex24irVI3C3drtEJ14Ol
 ax8MqWulPC6bkwlldQe0yXBgv619l+4jRON9t+GeYKOppzZb+EOggGpAgSbLz2MSvoRA
 HTOI9lQ05l6ZNqJkJsaAyhrsJ/vvxjFqyT/5PFQPJeCr7J6PH/PaXLlvArzH+z94cNfw
 vBbKbhWhO4YGtauEIZkPt7ySkWxsixM1YYpTdABBWsaZe+aTanZEv/P7rbqA3gLdPkk1
 OLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694251997; x=1694856797;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tjh6M8T7M9/5cZNppq/BbQKOlM0Ct71YjzpIfPNUx3c=;
 b=npov1+Btiq7DzVtKBzYZUbZvNDvk4TSUMhrbX/yBMaIwEYF7Wiubefj3ACVw4sdhEZ
 3aIQirzVGOcr9qAVk0rckvn76BI+mwXokQykB+m5pX4sylXRAQFEHQWfRydZopo8qLP3
 MXLUVFhDEwYq3IIo3IS6ZA2ouQs9a0HDbHJ301PcEjaZJkOMtimYwqVm3bYjzhM7RsEX
 vc9oBSXQcrx0bYZ0f3wzdaA/mDd+5xo/Kcszc11po+BzPYdBXgbujLa96BYL1aBU/Rdt
 Jpuz6NHNo+UbAVF9dl1gxqyc8C429V7IT6GVZIBHuqlG3Ge5kw3+y+ciTBK7K6cGGK0h
 Kl3Q==
X-Gm-Message-State: AOJu0Yy8hFszA3N8xuGVsMz15qwuu4dg77NdYe6YTFxsFRWW6wIcmJA/
 094RkvNB9T5nIiSYe5g6zMalJsGhmY5Ckg==
X-Google-Smtp-Source: AGHT+IEVPOL8PL2Ywf6nyoWYrhG+1oEgBFNIzk89SzS2UeOurt9RwDJiVpzpe2PF+5BC0FSUe36wPg==
X-Received: by 2002:a7b:cb87:0:b0:401:cc0f:f866 with SMTP id
 m7-20020a7bcb87000000b00401cc0ff866mr3991269wmi.12.1694251996655; 
 Sat, 09 Sep 2023 02:33:16 -0700 (PDT)
Received: from pegmas-T15.fritz.box ([151.51.159.106])
 by smtp.gmail.com with ESMTPSA id
 c26-20020a7bc01a000000b003feeb082a9fsm4167174wmb.3.2023.09.09.02.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 02:33:16 -0700 (PDT)
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jagan Teki <jagan@edgeble.ai>, FUKAUMI Naoki <naoki@radxa.com>,
 Johan Jonker <jbx6244@gmail.com>
Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Subject: [PATCH v2 0/2] rockchip: Use an external TPL binary on RK3308
Date: Sat,  9 Sep 2023 11:33:00 +0200
Message-Id: <20230909093300.11933-1-massimo.pegorer+oss@gmail.com>
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

There is no support to initialize DRAM on rk3308 SoC using U-Boot
TPL or SPL, and therefore an external TPL binary must be used to
package a bootable u-boot-rockchip.bin image.

Default ROCKCHIP_EXTERNAL_TPL to yes if ROCKCHIP_RK3308.
Remove useless TPL_SERIAL.
Doc add ROCK Pi S in the list of supported boards.
Doc add info about usage of TF-A and TPL binaries provided by Rockchip.
Doc add build steps for rk3308.

Changes in v2:
- Replace imply with default yes if ROCKCHIP_RK3308
- Redirect outdated README.rockchip to rockchip.rst for rk3308 info
- Improve rockchip.rst document about usage of TF-A and TPL binaries

Massimo Pegorer (2):
  rockchip: Kconfig: Enable external TPL binary for rk3308
  doc: rockchip: Update and improve info on rk3308, TPL and TF-A

 arch/arm/mach-rockchip/Kconfig  |  3 +--
 doc/README.rockchip             | 10 +-------
 doc/board/rockchip/rockchip.rst | 43 +++++++++++++++++++++++++++------
 3 files changed, 37 insertions(+), 19 deletions(-)

-- 
2.34.1

