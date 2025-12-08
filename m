Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78747D3B7E2
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 12:52:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE8C58397A;
	Mon,  8 Dec 2025 13:52:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NzUxd7wc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7878F83B4A; Mon,  8 Dec 2025 13:52:12 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0058E838E6
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 13:52:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so41137785e9.2
 for <u-boot@lists.denx.de>; Mon, 08 Dec 2025 04:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765198329; x=1765803129; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tQT50zeKFQoeW9Rr2i1wc3Rlyb+dymIaVF+Tns3b2Ws=;
 b=NzUxd7wc2QrGeQGqXUZVTQPgPNGPrPnDHbGi0O6pr79zJYtHm7xEPk459pBAeOP6pZ
 JBwyHiw4oU0TwKGzcJmozbC6Mjgdj5pFnHqzjzAvmlgypPGw1/bPpNEUie26U5yY3xI2
 KOvtEkzT0sOl9B2tSkYoWeyebRH1pEN1pfLHZ89nqf+CpT1ljgCma6JLruvvkoICeFSJ
 7Ps/tb5+GKGpPnXPPvu0cH/J5GXk5D5ZP9IV+0CttG7ZgTgP24ZE3Gc+dKnWHHtn24d5
 Rsr2mjWASmxn87Dzbwql0j6eneywX6UQKVySoi2/iFRcQtPQ12MTXrAZ8hL1m3BpAljL
 WKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765198329; x=1765803129;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tQT50zeKFQoeW9Rr2i1wc3Rlyb+dymIaVF+Tns3b2Ws=;
 b=CLyfAeXkbNceDjnMNDhG4ugFeyAgEgxE76wCeaHF++7uw4w7aNCmrUcla1CEaI7rp6
 kcUnY0aI+VEORQJBUfdHCTSJ/34e/gvoH6z+fUNFaAyuwl/F8OBKlbMZsYXrhlb6wcLd
 VVX+z/r1x24N1+ihlhPwOKPvOnNuGt/Q8M1j4UnuaWE4kcCgGSO+O6Wj2k6WVvPqpVlg
 FVZg/lJ7tKA9RXqpcYUa8cEp697iBerZx646KZQ4U7+kerbCqlbZvnmW9XAWBYDTvZd/
 V9a4z3urMhRK6I0RPDv1D6AEXUX3/CKxsW4+Cl8O9yK8sXHpQmxJU8ub6LNrztvgQKsY
 elIg==
X-Gm-Message-State: AOJu0Yzf7FlVh/riuhkm3u6LO1tC8j0a85rYqIsMd216fyS9xK1/BwIh
 bHsZbDx7n6xir8AceVKvrpQnXSGeNnjmCns1OFPfls2MKX8/9Ev/sNAT9dyD6+Ytu+w=
X-Gm-Gg: ASbGncs6Z/pIo39jxQlnbIwmlz5hsVeJqW0xUMxUEUrj/OTlu0Q2PvrFoNsbRanGE27
 MJKiV6eQCA0bg8mPts5Ehbbfe8Hn4f9dopWSbAIho6n6ujMZJFdRXuMB7yG2XEMpVOxWDAA104E
 y7J3mExzK7RwpDvu+QhUjsEox38S2Zd6badaj2eZUf3/UlqN+ZRPWzXzQk4F13bKm3yvPXMHE+h
 /Pb9KDAsFbeRy5OZ1mfU5Gyiy1/NfirhV2K42YSHireGJ0rG6XvCyRfgcHubbw0RLka6+HXmYpt
 bF+Qn3XEyYbd+OTDognC5gEAKQP6jxFqA6IrjcmEP8HkFWABy85SZsRAHj7+LCm8yH2B0tsQsUR
 /pUGdT60lJt2+yo6C8fJuKRHCYHFXiKptMfTDJ6NF+jS+Ob9/d9TQd+y/0UHWm8Wc7/VYv9xwHa
 xnwdT8ErGoJMrFaO4OPSmEkXZIY3LvizD2cLo9E+4=
X-Google-Smtp-Source: AGHT+IG+OQVo+IW0ocg/qXk3E1lCqzokCAlS13kKoa+yhVz7vk7rqqmKahvY0+mX8LWYh22xxDs+EA==
X-Received: by 2002:a05:600c:1912:b0:477:acb7:7141 with SMTP id
 5b1f17b1804b1-47939df69dcmr65231695e9.3.1765198329381; 
 Mon, 08 Dec 2025 04:52:09 -0800 (PST)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f7b:b001:fd05:11bc:5c24:a865])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47930920b6dsm260113645e9.1.2025.12.08.04.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 04:52:08 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 0/5] net: Port NFS to LWIP
Date: Mon, 08 Dec 2025 12:52:06 +0000
Message-Id: <20251208-lwip_nfs-v1-0-1f5d31e15d00@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPbJNmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyNL3ZzyzIL4vLRiXVNjC9PUtOREc8OkZCWg8oKi1LTMCrBR0bG1tQD
 VrUCCWgAAAA==
X-Change-ID: 20251029-lwip_nfs-5385efca71bc
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Benjamin Hahn <B.Hahn@phytec.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Adriano Cordova <adrianox@gmail.com>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Andre Przywara <andre.przywara@arm.com>, Tim Harvey <tharvey@gateworks.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

This series ports the existing NFS code so that it can be used with both
the legacy network code and also with LWIP.
Firstly some legacy network code, mostly variables, is moved into common
files so that it is accessible to LWIP.
Secondly the NFS code is refactored so that the parts that are not
specific to the network code can be shared with both network
implementations.
Finally the LWIP specific parts needed to interface the NFS shared code
to that network stack are added and enabled.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (5):
      net: move net_state to net-common
      net: Move some variables to net-common files
      net: nfs: Add licence header
      net: nfs: Move most NFS code to common files
      net: lwip: nfs: Port the NFS code to work with LWIP

 cmd/Kconfig          |  28 +-
 cmd/lwip/Makefile    |   1 +
 cmd/lwip/nfs.c       |  11 +
 include/net-common.h |  38 ++-
 include/net-legacy.h |  26 --
 include/net-lwip.h   |   1 +
 net/Makefile         |   1 +
 net/lwip/Makefile    |   1 +
 net/lwip/net-lwip.c  |   5 -
 net/lwip/nfs.c       | 282 +++++++++++++++++
 net/net-common.c     |  21 ++
 net/net.c            |  23 --
 net/nfs-common.c     | 863 +++++++++++++++++++++++++++++++++++++++++++++++++++
 net/nfs-common.h     | 123 ++++++++
 net/nfs.c            | 849 +-------------------------------------------------
 net/nfs.h            |  59 ----
 16 files changed, 1368 insertions(+), 964 deletions(-)
---
base-commit: 59f9fcc1f514762674ac07c13c2a85f7aace7250
change-id: 20251029-lwip_nfs-5385efca71bc

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

