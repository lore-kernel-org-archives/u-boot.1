Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4B8C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 15:38:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 541E280FDA;
	Tue,  1 Apr 2025 17:38:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HYgeoGrs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58BA781DE3; Tue,  1 Apr 2025 17:38:26 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DB9D80584
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 17:38:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ac2bdea5a38so934042566b.0
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 08:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743521904; x=1744126704; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tyzHve8j/mmKePSaditg8wwKMGOX/hz6NLJcVYi+SAg=;
 b=HYgeoGrs+qQFcqLZA6M7GvsEUj6JSGqwoaTlqXzE3pcfMZf6Tup+Hx0nAw0sbvwme6
 c/RVfJ+1YTzPk6Kg10x7Fce/XiuJkqwTSG41QyIcRxQuOO/dkhyYlvCHg1UxW+o+Shnn
 H6N5ow/2uOPl3xeS6Yl+3gaPnPDDevkOgkXmcVlwxaj61lbKprQPzvZF0QLebKi+gWsm
 4my2uA95zFk/w5yqhrDkNk0R2FlYXPivsB4NWz8zqQuJlbmKdV4CcVLJ3qMLI5XKRejX
 HmdGYnt42JZ4GGj3VUNZACss3+RLtBU7K1Ulhg8fWh14SVE1SRzgx4vZWlG0/tKAsQGM
 nb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743521904; x=1744126704;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tyzHve8j/mmKePSaditg8wwKMGOX/hz6NLJcVYi+SAg=;
 b=rO9HeO/h/v162ECcVrvhUgPcRyJk6jsE/LM4f8DvrUTk/V2yq4hOgT+qCQjKcUFVpB
 678RYhWguuAWLVX6k0BmXBunkLLZMaURDpgyXr+1AgmWCpNAETe2Ef7FmU1S8ggur3JO
 yMLopv3bp1MmiUGu5znBKERGFj9bw9TVqsvneZDr1o2QYP8IlVcOfVCWSy1Ef2U5W0kb
 UI2qXB455VOYx7aXe63WAaURqfycap5E0hcfKqezr96FiQEhpc1rbk9+S/XZHklkZWcB
 9CZxpkyzUF2G9X2O3o7933qTpv7sMOTZpWESxR8Bl7+YEevcHYnsES7yW2dFTpxQdL99
 3Hmw==
X-Gm-Message-State: AOJu0Yz3GivDXT6dbCr6GIcVlJiaJLyF+Zg1DIlCm0fmHZD3FTUdKoKq
 c3BGGYNcyr/81rCZUn5wrUOMHbAGzaXfud6K+/GacC0jIXnPdjuu
X-Gm-Gg: ASbGncspiXzg4XQUlXogy1emICcgnaQ0glJR8M+Cu9WYp33+xQ1MOyEgb6P6cZI/jkf
 jJvQwF2LmCwXJOEGD2xwYwFIc6NwezFQRtg0c/1lFasiebgkENDTuxp+E3KB6T+6LtQ1QJikLFu
 HpmYV2iBk/RkJu40xtgpM0+XLKFlTJHfBa4B23gT62RvYUHOC2PhADQKE3ldQ9sKOYc4pui6G0o
 vB19txh7Y7s7Z4sl90I7Xe4YDk1l732c35703rpBv30dIF7QHMBD+irUAFvLxclo/ylAV2bM76f
 NYuhSZHE6JIhvKNwitOeTdHOaVoYeeF6r/OO
X-Google-Smtp-Source: AGHT+IH/yAvolAgvqxU09+ThKTzjf6KfmeywhTzYhJSSdxD6TqihNR1vCYwsVxCMiTfGrVgZsuEdeA==
X-Received: by 2002:a17:907:7da7:b0:ac6:ba92:79c9 with SMTP id
 a640c23a62f3a-ac7389d66e1mr1398983166b.18.1743521902541; 
 Tue, 01 Apr 2025 08:38:22 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71f9316a1sm732784866b.82.2025.04.01.08.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 08:38:22 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Kongyang Liu <seashell11234455@gmail.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 0/1] sysreset: add PHASE_ to GPIO reset and poweroff configs
Date: Tue,  1 Apr 2025 18:37:57 +0300
Message-ID: <20250401153758.40088-1-clamor95@gmail.com>
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

GPIO reset and power-off functionality depends on device tree data, which
is often absent in SPL or TPL.

---
Changes in v2:
- added Kconfig option of GPIO reset and poweroff for each phase
- adjust uses of SYSRESET_GPIO and POWEROFF_GPIO in different stages
---

Svyatoslav Ryhel (1):
  sysreset: diverge GPIO reset and poweroff configs per-phase

 board/sifive/unleashed/Kconfig       |  1 +
 board/sifive/unmatched/Kconfig       |  1 +
 configs/ge_b1x5v2_defconfig          |  1 +
 configs/microblaze-generic_defconfig |  1 +
 drivers/sysreset/Kconfig             | 45 ++++++++++++++++++++++++++++
 drivers/sysreset/Makefile            |  4 +--
 6 files changed, 51 insertions(+), 2 deletions(-)

-- 
2.43.0

