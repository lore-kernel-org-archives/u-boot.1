Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E226C3DA6E
	for <u-boot@archiver.kernel.org>; Sat, 23 Dec 2023 16:45:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69A3F877B0;
	Sat, 23 Dec 2023 17:45:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c3O8UgsT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D39248778A; Sat, 23 Dec 2023 17:45:52 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07FE4876BA
 for <u-boot@lists.denx.de>; Sat, 23 Dec 2023 17:45:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a2358a75b69so484126066b.1
 for <u-boot@lists.denx.de>; Sat, 23 Dec 2023 08:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703349950; x=1703954750; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=J8aZ7sxYDaD6bOngRCQJuhBk3wu2EAIiKS8uJgJkRec=;
 b=c3O8UgsT56yutEph6sdinprjFbyWMmF/fSaPqowj9GGtn2DYPwR2/Et6nXSo/orQmy
 L8BEHXtOQ3kuGxxJTKzeNt3cfiXgHk2ssU2Zke0dXT+5DY/zfQqwvpuJAkP0fmyhhCAQ
 lalV+Ir8AtTuCGoFhunYjVValOmKwJheDTas90tFsS15+QA9nNuyppe9WKAEVAhg9iTQ
 yLFBK4Pi6I1E9Jh0pIp/VHjpkoLSnCOmbfP1ls/4+2F4sGXvW+hm3M2ANa60uDu2AIsB
 BOYf6QovGJv78sxbs3Z33Lvb4Tsep7dgWVaNlEsHDimNrHlxmmOsfatTB88LqbX4phWP
 0IDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703349950; x=1703954750;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J8aZ7sxYDaD6bOngRCQJuhBk3wu2EAIiKS8uJgJkRec=;
 b=PY3aFtDUd49bds/b/inBcQGAdUIr3k2CnPsT+mlAMLxR1uCqWQRcvrvEX5yrwKVoLx
 nDxJOj3sjFnspN7J1s7Y6KRKV9BC6J4If33A0tJXoY/QPaUXrFxKkUnZlcNfhNfRP4s8
 0EWrkBfI2dxHyTw7WR3yF5fqep4F+UE9lb9MXS6nqVe1Q9cUOMraFnbzmtaU12VCXv8z
 g3CeQcTqp0/llwmHzJHP44YI1nCpNXtqVJmSFpSCiQdKEW22NnZZz9o2eguf578CXOEL
 b0qad+iYFusnrVOTKd/I9a9ptSDlOUKuHGSzS8Jh9QRQYyXfZHGx/EMyn7fFpw5QtHjX
 LTCQ==
X-Gm-Message-State: AOJu0YyqC8YB0xMR7xUo9p5v/a8TBfpwNyU9ksR0YcsiKb8kNd/Sm1cF
 JkZWaFemjfkfXb0TSNpWI/M=
X-Google-Smtp-Source: AGHT+IGSXL4hK+1Bd7GC8DgzFheNGBfKdkpj097hHjtfD8SlitiUxP3koorAKR+8MteKv9kTTOKDsA==
X-Received: by 2002:a17:906:21c:b0:a1c:d8c6:c21 with SMTP id
 28-20020a170906021c00b00a1cd8c60c21mr2517099ejd.67.1703349950105; 
 Sat, 23 Dec 2023 08:45:50 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 h1-20020a17090791c100b00a235e5139d5sm3221139ejz.110.2023.12.23.08.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Dec 2023 08:45:49 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Sean Anderson <seanga2@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/3] Revive TEGRA_SUPPORT_NON_SECURE
Date: Sat, 23 Dec 2023 18:45:22 +0200
Message-Id: <20231223164525.3660-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Revive TEGRA_SUPPORT_NON_SECURE used for T124 and adapt it to
be used on T114 as well.

Nonsecure state detection used on T124 works on T114 as well,
tested by me personally on tegratab.

Svyatoslav Ryhel (3):
  ARM: tegra124: convert TEGRA_SUPPORT_NON_SECURE into Kconfig
  ARM: tegra114: expand MC register map
  ARM: tegra114: support nonsecure state detection

 README                                  |  7 ------
 arch/arm/include/asm/arch-tegra114/mc.h | 29 +++++++++++++++++++++++--
 arch/arm/mach-tegra/Kconfig             |  7 ++++++
 arch/arm/mach-tegra/board.c             |  3 ---
 4 files changed, 34 insertions(+), 12 deletions(-)

-- 
2.40.1

