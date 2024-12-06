Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36A3E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 13:11:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53E6589576;
	Fri,  6 Dec 2024 14:11:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T9AuzRzf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7B388907B; Fri,  6 Dec 2024 14:11:22 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A72FC895D7
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 14:11:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-84198252db1so68707939f.0
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 05:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733490679; x=1734095479; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rKVIVQDu9wtBXrtcZqoiGQaFKlIjDFp1m4cxORzQb2c=;
 b=T9AuzRzfGgM/5MPBrPLtofnscFweplnqIAs9lR5MjPJkf3iCTv2KJ+ntlUipsTOUY4
 5PfmkQAip+od9nvzJC5RJGlV4Mvlg+afx6bxWliCZLljdJPVlUOXHxKlEh4oCHVNEvhp
 /UbGz9x8qvjY1QmAfMbrTD6M1900czq7aiplk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733490679; x=1734095479;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rKVIVQDu9wtBXrtcZqoiGQaFKlIjDFp1m4cxORzQb2c=;
 b=DK/6BpLglfcfaM7V/gBZKRPc2xuVVnHNIVUDyo+ktoQkheRnBSpm+B4JfW6c/yCWP4
 UZYLJJAIOwxsrsKPzA84I8bVFgwcIq75DA/ujQY7mmqJuhPIN6b1+e6p15N3I82Uc4DE
 kJuwFVHvmnj/J1wUL5dAeQY0KhMUyTBek2nbCI7GzWXAINV6H2P8Kzi65X2KhEWbEsjf
 kTgH0Ltqn9jl5Iot6z/9XOOY0+dc079lP9OAX/3/kWVSLhj8aX7Igw3tW+NQfmlQzIgB
 Sv+d/hMyS2w6ENjcBVP666x7HsiN21W87WNyugMAjBXiLbGz0ucn4FEopVvydJ9mHpkx
 p9vQ==
X-Gm-Message-State: AOJu0YxPVa/dIAtfAkXJ304rfldImBjonq5z4L5Z9K+3r+/V0KKavlFu
 Kmu+kuWA+tA4+Oiw14n3jcvXMsjRe/xe9dpaOOasgdDj9JV3IRTIKHF+r3aIERYSMdx/4xvlgAM
 =
X-Gm-Gg: ASbGncsr4TpPWrJgHj+KQqqZYt+q5L5bg0kD645XLMXBVvlTI6Rvb+pCt6aueSKzuU9
 HB6m+Jl1iSHEW34oesVIiCYjR8MXjsKF3P9JjNfP8NLcEDWOdMwlDqXwric/31SABtLC/HyLlu3
 adqUuOg2aIBoCaQ2Fxuj7z9ETR0HBCeJLAuzdKT7NxMDDKKtBvy7blF6WvnspLTI/I2uLVQ4Ds8
 g+IEHOfsTNZ8KYx6gpnrtbcBY/nettNG/kXEgJDJEX0qg792JEnMooOswirzDUBCgdybdjR0vdC
 /Gy0+SmKzSA=
X-Google-Smtp-Source: AGHT+IHWlk2KGyZPId4sdMGPawFvW+o1MC+RBm/phBKyFR7YDf2EDnNFWeJkwqDmJ4XhLGZY+AxZeQ==
X-Received: by 2002:a05:6602:27c9:b0:841:8345:5eed with SMTP id
 ca18e2360f4ac-8447de2d901mr309193039f.0.1733490678829; 
 Fri, 06 Dec 2024 05:11:18 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84473a5b3b9sm97382639f.35.2024.12.06.05.11.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 05:11:17 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>, Francois Berder <fberder@outlook.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Ivan T. Ivanov" <iivanov@suse.de>, Jan Kiszka <jan.kiszka@siemens.com>,
 Jerry Van Baren <vanbaren@cideas.com>, Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marex@denx.de>, Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Sumit Garg <sumit.garg@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/3] rpi: Tidy up booting
Date: Fri,  6 Dec 2024 06:11:10 -0700
Message-Id: <20241206131113.2865416-1-sjg@chromium.org>
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

This series allows rpi to boot a compressed Ubuntu kernel with ~100MB
ramdisk, by expanding the available space.

It also tidies up some strange behaviour with the provided FDT, where a
separate pointer is maintained to it, even though U-Boot has copied it
and placed it in its own space. This avoids strange bugs where it
accidentally gets overwritten when loading a file into memory.


Simon Glass (3):
  rpi: Update environment to support booti and large initrd
  fdt: Allow expanding the devicetree during relocation
  rpi: Use the U-Boot control FDT for fdt_addr

 board/raspberrypi/rpi/rpi.c   | 20 ++++++++------------
 board/raspberrypi/rpi/rpi.env | 10 ++++++----
 common/board_f.c              |  6 ++++--
 dts/Kconfig                   | 11 +++++++++++
 4 files changed, 29 insertions(+), 18 deletions(-)

-- 
2.34.1

