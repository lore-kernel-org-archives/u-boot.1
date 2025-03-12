Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EB1C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:08:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF79C81760;
	Wed, 12 Mar 2025 19:08:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IyF0m3yv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E90AB8175D; Wed, 12 Mar 2025 19:08:08 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF29480756
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:08:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ac2b10bea16so30827666b.0
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741802886; x=1742407686; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yxPZdGnuZQFbLB6m8I5lrOHwduPCcn6uq3QxkvRKTYc=;
 b=IyF0m3yvNmSMg+yykWbJNyUNKQggqXiWRGpF39t0stXpdwBipSDCmx6xbBoOurYeSA
 YKw7TkR8d5bOgkpOOWLeAyEILBe8jk7ElzTuD8VRlzxioYphnYO0zvLr9+glfHKDtsuL
 4MARUjmikbz52W69QVxytE+3tLjti4twA89esvoT1gPqw7T7rt1QPGuPEEPUp95xe7At
 QRsiYOBNXTVyicZMqU5rinNPptSLSQi9oOxDCD5s1XDfRxki7kZ2ofldKCQHhURLGXJf
 y/uZmIi0lYVc/GmgGe/IrBuMKdwnqoqGyrPIwYYPTOnfhMz419JyHDhwPAGQ+UxAEZ+Y
 2CuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741802886; x=1742407686;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yxPZdGnuZQFbLB6m8I5lrOHwduPCcn6uq3QxkvRKTYc=;
 b=suhfbqoNvVqVl8EP0ZHNr7DtVRx3RnpFtSEDWrpYDU3EZ2Z34ngXE3kmRPhN/lRMod
 GRynk/NOAcTKq9C7MyPBN6a/+rLG7YmU6/0qoerLlppZ1MTpgJQsac4vsmSLMDlFTYYw
 kcq4rdn/9POHz80hqZzHutmiqo0RM6b7Ds7Kj251uxxM1cE0LJU6C+O3PC9iS1woeCwp
 nXzoxlAsuMkD4a7RmWbR0AnqXX1pLLPC0eptEo54ZyLnP43DXEU3au08NoJXzgjtJYXn
 Yu5XgHOXw/BfbuLqBSw4tsMFaT+yKaX0qNkULUftlY8LqsVG3tJkwIyJxN73OakiADLj
 DBYg==
X-Gm-Message-State: AOJu0Yy9IBUC/JjxaOfr6XzjHVOsqIvWpD719npuKGd1QoFGeUgXgMPR
 0FuB6L6njkoNSCtvzhdO/Ce7CSOzmbRCa1sV0ywjgevUBymU/uQJM2nZ7A==
X-Gm-Gg: ASbGncuyPOXRZOPrjlFF+uQjmf4RNKVWBl1lkRvYInZKRGWhwtRXqZUO46e47JAGkub
 xp39d3MUCH/RDvCCWW8Zy5zq3cbOS8gn7soSWMOkJ1xH/btirj7saCOZlJ7Xvi+cTGKr/mHdvSJ
 7b6W6du/5zMm6zD8ILduqtTnDZQQaXoK4VgRR7cSkXDZ1w8CuL4+P1HdcV+mSt8HLz4KvR3zGq0
 ZGu8Mkqufd5JFD67RzTV52NMD7hpYWHwDyN/fG5Vnstny98K4qlvZrlSteFsirVr8v/Sca5MpPW
 omKSMT35NAAPpltqlJVhvWrJQErd2+uixsay
X-Google-Smtp-Source: AGHT+IEGgDb1c2S9t1wg4/UMnlmDqHxMYvKB8QXfyrWh1gRWE12QFvNZyJpiZSIIZ6efVhueXIqrTA==
X-Received: by 2002:a17:907:6193:b0:ac3:888:ed08 with SMTP id
 a640c23a62f3a-ac30888ed64mr105248866b.44.1741802886292; 
 Wed, 12 Mar 2025 11:08:06 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e5c733fcd2sm9971635a12.2.2025.03.12.11.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 11:08:05 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 00/13] video: bridge: migrations and fixes
Date: Wed, 12 Mar 2025 20:07:41 +0200
Message-ID: <20250312180754.120946-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Migrate dp501, tc358768 and ssd2825 to bridge UCLASS and OF graph.
Fix and improve power supply requests, handling clocks, gpios.
Clean up code a bit.

Svyatoslav Ryhel (13):
  video: bridge: dp501: convert to video bridge UCLASS
  video: bridge: tc358768: convert to video bridge UCLASS
  video: bridge: tc358768: convert to use of_graph
  video: bridge: tc358768: simplify power supplies request
  video: bridge: tc358768: remove need in clock name
  video: bridge: ssd2825: convert to video bridge UCLASS
  video: bridge: ssd2825: convert to use of_graph
  video: bridge: ssd2825: move post configuration from transfer function
  video: bridge: ssd2825: add HS delays configuration
  video: bridge: ssd2825: make pixel format calculation more obvious
  video: bridge: ssd2825: set default minimum tx_clk
  video: bridge: ssd2825: add power supplies
  video: bridge: ssd2825: fix reset gpio direction

 drivers/video/bridge/Kconfig    |   8 +-
 drivers/video/bridge/dp501.c    |  27 +++---
 drivers/video/bridge/ssd2825.c  | 159 +++++++++++++++++++++++---------
 drivers/video/bridge/tc358768.c | 101 +++++++++++---------
 4 files changed, 183 insertions(+), 112 deletions(-)

-- 
2.43.0

