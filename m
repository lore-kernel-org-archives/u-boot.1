Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C12AE7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 14:53:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 822D080192;
	Fri, 13 Dec 2024 15:53:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eDPRgpIT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47869801BF; Fri, 13 Dec 2024 15:53:50 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5E098007A
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 15:53:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-53e3a5fa6aaso2966826e87.0
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 06:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734101627; x=1734706427; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ykvzGo2uUUaUDHkCAk5H8MczHF8o3l4lLy+OZxl7lRU=;
 b=eDPRgpITzXJfHPG6oWmX5g9T3ThcIdp/W/6EMTOC+kRk+w1PnaiDI75+dElManQJyX
 pCnfZ88RV7r9iafTHHSGPCLiTbaslnnI+gS6gVx0OjIYUhdG+1MTvIdGrwJgWLtW6FF1
 +v51y42p2rmQEqgArFGwkXZu65BFCfRSd5gUU8pF7FA3B0wgPI5bVuc91lU7U5RFfghx
 s9QP5LbdAPNsWFNcueHWmqxdWEcQZBSZk8GZuw1bpL9hde1vygYUeNYL5DD1hBvhwgTX
 k4nFHu3I7DEjWks2vjZi7g8VH47cv6/uLlMxxNf644N5ItPcMp0FJK2Ht4hwvpLgJbVC
 SCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734101627; x=1734706427;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ykvzGo2uUUaUDHkCAk5H8MczHF8o3l4lLy+OZxl7lRU=;
 b=CQumlHCVqOfi4RdaE4AI8dmqzglSKkKnXyJEbE7IyTgZI4+RH+e4p4BNTkBguLF6jV
 NLXH5U3Bdb4U6l03fozpAr5l1SVAAyp5MibT1sDO32Tfb1xEeMZIWEj64LhcexiMGysX
 CttaTH8qfOGAXfas8HwDdSE+OKQPfUrML9sPkdhvJrQJuq7hsP1/fTUfAUssVUeA/gmH
 5A7B4uzkKcMCe9Uj6J0PdZpxhcvuaW1IYfzu13n6C4ctQrhnumklQjgYrb9SOJll0cP0
 3XDLMwnifXQl/+nBIn+H2ym4IPksjp1+abjR4tvTxvBrF0xu6eLAOwqLhlmEk917pEUB
 gG3w==
X-Gm-Message-State: AOJu0Yz6KKKeBTKvKce3TjnKsUQ3rt7cLbiADNgrynIeSZL+htctPQ7l
 ilTWY4S4JQo9K0sLFYG0EhMhvr60+xxwyWctVa7Ploooc2Rtzuch
X-Gm-Gg: ASbGncvaVQAqFN99+ntIBNNISP+mNWaOoaH0tU+4Spn5+i1ozeFyp8OjjNUUDxbx9MT
 6q+6etTzwvD2id8L8BkUv5ilzdE6npdlXMmV5bhRO1gRysJ1fFeJnAEPvhLR2yCkiNeQEr+W0SW
 +jH3WAQcT4L5G7qViCunQZc95YhzE6GVRHvm4GJ9UjfCFDfPuVXu4gp8CKhLm4wcYlc6R915NB+
 uWudYgCg8E9wE8tsXCCppfgdhEGZkDTjkhUv5L+YQKh2wJz
X-Google-Smtp-Source: AGHT+IGBlFUX8UJ3FMsCBLCUbYzmaIu/y0J4Nm3IIWIOi+rOo9vIUzb57fNHnagMjRIGR4eqjqdnFQ==
X-Received: by 2002:a05:6512:159d:b0:540:2d60:d6ce with SMTP id
 2adb3069b0e04-54034276c43mr1690623e87.24.1734101626852; 
 Fri, 13 Dec 2024 06:53:46 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30216eb1013sm18626561fa.34.2024.12.13.06.53.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 06:53:46 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 0/2] Tegra: fix clock init
Date: Fri, 13 Dec 2024 16:53:17 +0200
Message-ID: <20241213145319.10956-1-clamor95@gmail.com>
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

This should fix https://lore.kernel.org/all/20241201164810.GT3600562@bill-the-cat/T/#m2b62b471fd37e4c9725c98547e2a919cf11db5e5

---
Changes from v2
- adjusted periph clk id check
- restored unconditional debug messages on car functions calls

Changes from v1
- added partially support PLL clocks commit
---

Svyatoslav Ryhel (2):
  driver: clk: tegra: partially support PLL clocks
  driver: clk: tegra: init basic clocks on probe

 drivers/clk/tegra/tegra-car-clk.c | 50 +++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 9 deletions(-)

-- 
2.43.0

