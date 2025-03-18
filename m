Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8BDFC282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 12:47:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F177380F4C;
	Tue, 18 Mar 2025 13:47:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PuQogZwK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B11BE810E8; Tue, 18 Mar 2025 09:31:39 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B053980107
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 09:31:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=arturkow2000@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac2aeada833so1042678466b.0
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 01:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742286697; x=1742891497; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=w0uHwtESAZApWdOSHoU3zs742FxEhLtolYoSqVIaHZY=;
 b=PuQogZwKb7O9DlSkaNiZrN2EIqlMbK4rTMYYP7VinGgQzJNWwJle3h25TQU5zPvndp
 MA9/hn+CFBThBQfmWJZkkUAF17OLR0z3z/NE2H3zhMuOf/CNMQdUFBFb8iIcm5d+Ro+d
 2DAr70QzSof/sKViIYRP3MNLQT4LTC9Xu+y+yhYYdPZlqINAc5hkbiqjzO8LLH0hPrCE
 Uwa+L3C8vxkSj27UDjO3snVuKylYwshnjR1Yc9eGM3cnaEksmdMONwEQ42tAx0X9MtnD
 lYH1fjn8Hh5n+ijIf5EzzoupFzDIHBrgHuKTi8teGbjydZcPsseFB2c0T1ujhCDUHVhC
 RgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742286697; x=1742891497;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w0uHwtESAZApWdOSHoU3zs742FxEhLtolYoSqVIaHZY=;
 b=dDx4kY9t706UYF4n5JJ5oc5ivN+idc+eq4pfJj8gk4MZckfQR9NcNz6FW54bLMZara
 65QytNrh3cxMH7ES0BnVplwD+2xqdvjMRZbJfONYczQNEupFzOokBRnhmZ7brJJFGlYA
 skT7AomFTQ5II58df5eHpBuA2sE/9jEtrA08r1EYVFMb9Rg1HNkzvOqhgGE3qTtR8KFv
 ge36mpG+yGVK2e4e6KYez1ac45EMsCryv5x2dbu2RiPRvSkSiZp1wPo85h88WNk4n7CX
 6PLAc00P9POCicAfi1gpG+RVtsVkLMb3vP9mQXDhclypfb9tVTcI9GV7JpmNgmgnWzXV
 5OEg==
X-Gm-Message-State: AOJu0YyJMI/Fw/0Tj3eXgvPueBZEvBkGgtD0mirb2vvlReL9CV1WvWx4
 l8S3aOedhi8DKYNQpUnreqiF6Y0YPW2ZB8XFFw5BfOVXnTqJ/9ydhF9a8Wkq
X-Gm-Gg: ASbGncv6+71lfamH/YWOaRQAI/IUKD7YrOmttSioVQa4MWC8risS64UWg4e2y1U2SFS
 D682sEKYFkDsAogr3+7l4z9zwA66g59tyGd5bBZgf3MW9EKgGVCBQCPZtn5K0fOIL/wqO7RwOnW
 L10TFNAFi7NbsO0XUmX0R8vUdjmRQctrXX3d+gU1XPQUd8vDurNA3GJE/wLDX9ZXbcYhuWzIW6q
 eLuMswtnUFmE3kZh4+MZ92j2BBrF6KeZ0SP4n9tes7NtSz5JpsVf+Hra0U1+J2j0VbdSokQdReJ
 vhnyTqMxfieLg2WUyxRby2KpCNNi6kzRn3wvP3IjjFVeezUSCZum
X-Google-Smtp-Source: AGHT+IHNxkMEAkvH+QjV61YYUAvnwhgOe4SDKjP8d+NyDQybUaQ2KsPBDQpIIbaHmk0USBFv1+3lzQ==
X-Received: by 2002:a17:907:7212:b0:abf:6f25:9881 with SMTP id
 a640c23a62f3a-ac38ffef2abmr186516166b.25.1742286696269; 
 Tue, 18 Mar 2025 01:31:36 -0700 (PDT)
Received: from eta.play.pl ([2a02:a312:c49b:a180:4e11:d045:a94e:c696])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac314a3e0acsm816189366b.142.2025.03.18.01.31.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 01:31:35 -0700 (PDT)
From: Artur Kowalski <arturkow2000@gmail.com>
To: u-boot@lists.denx.de
Cc: Artur Kowalski <arturkow2000@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stephen Warren <swarren@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 Tom Warren <twarren@nvidia.com>
Subject: [PATCH 0/4] Support UART over MicroSD slot on Transformer T20
Date: Tue, 18 Mar 2025 09:30:43 +0100
Message-ID: <20250318083103.63250-1-arturkow2000@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 18 Mar 2025 13:47:17 +0100
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


The first patch in the series brings general pinmux support for exposing
UART over SDB/SDD pins on T20. The following patches bring support
Transformer T20 allowing to enable UART over uSD by setting

CONFIG_TEGRA_ENABLE_UARTA=y
CONFIG_DEVICE_TREE_INCLUDES="tegra20-asus-transformer-uart-usd.dtsi"

Similarily, support for UART over uSD could be brought to Ventana which
has uSD on the same pins as TF101, and other Ventana-based boards.


Artur Kowalski (4):
  tegra: add funcmux for exposing UART over uSD slot on Tegra 20
  tegra: respect CONFIG_TEGRA_ENABLE_UART* options on Transformer T20
  ARM: tegra: expose UART-A over uSD on Transformer T20
  board: asus: transformer: add DTSI file for enabling UART over uSD
    slot

 .../tegra20-asus-transformer-uart-usd.dtsi    | 31 +++++++++++++++++++
 arch/arm/include/asm/arch-tegra20/funcmux.h   |  1 +
 arch/arm/mach-tegra/board.c                   |  4 ++-
 arch/arm/mach-tegra/tegra20/Kconfig           |  4 +++
 drivers/pinctrl/tegra/funcmux-tegra20.c       |  9 +++++-
 include/configs/transformer-t20.h             | 10 ++++++
 6 files changed, 57 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/dts/tegra20-asus-transformer-uart-usd.dtsi

-- 
2.48.1

