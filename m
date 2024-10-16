Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE67D1AD3E
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 10:07:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABCF189067;
	Wed, 16 Oct 2024 12:05:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Wf6ygkLJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7965C89059; Wed, 16 Oct 2024 12:05:19 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85DA288D1B
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 12:05:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-539f4d8ef84so3970004e87.0
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 03:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729073115; x=1729677915; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4h6VcNLv4Vpk88+08IBqjyDjb7puX0F1+ZOc2WycMgI=;
 b=Wf6ygkLJByIPCKgetisk6M6v1r8TcV8fHWSBHMOtNZPEgSpihy1qZlbilLGx+Ai8Jg
 Ing9WcFh07N0+YfGA0Qm1fHMij4wsbt0QhByVX2KUD3TfiReAUSlopTS1hZJ8AK8Cpz7
 +58oQn0gy+7SoFqxdwMStDMi41thFIrJRqVUIgoo7Ne03dmDjtz+KBazw8d5bp8x6HBv
 vT2uDLd0GHFS0wE0lGsqBfjqAGKZap2bBTbYXs3YU1XUMPp8+md1HEw29cPLDpPt7Cpa
 /LlKigXjm9vr1NlnGWvNOifk+BRNRUS4PqR2z+kt0INXusT77lekxcQYt1DmyrSK9ux5
 rFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729073115; x=1729677915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4h6VcNLv4Vpk88+08IBqjyDjb7puX0F1+ZOc2WycMgI=;
 b=bkwhOOGLiOxNhbDrsod9/+B9dlxsKgzXclujvERPzXe1mj6gx11QZsQouj/fGmytkF
 wHQv1oi/XUJITru1ruRyRuyFWPhF0ejmAJfJGNmO1urh5qaoeXuPEbY9NgLcHrcx4x07
 Y2bipcNwZy1YsmtrVqmKiubLRzcdHolhzQs4ds4NlPKGs5zktVHWf33+syRQdAtDXmzQ
 JEZtOvv+cUsrKE+g++/pMEd9T99ezXOGcZ/jwQBLx7NrE2OzKVcAIAzcN6wwIlcoh8h6
 u6IV+VhaVuAu7r6mVgZajm3/kSuKOTTfHn8xrYd+wajrY57QIpUJhd2dV8POBTlhklLb
 sEnA==
X-Gm-Message-State: AOJu0Yznvbn8pyGqlI3ndpUz9t/YucEJT5O35/E2oiJj0x0kdv35bjf3
 D4TH7pHFT97l+c5Rsypsz+6yZF/TTK7N/cp4aUbNLvRw+twa8TZ3HI6kOu/tIJ6OKxAnwM9MpDg
 4zVmOltbP
X-Google-Smtp-Source: AGHT+IFsLYds4NZD9/2ckiO9rgP/H1d+lWunA19+dV/okZeDk5r6MjifkRv1lESeWNbRlb/Y7jc/jQ==
X-Received: by 2002:a05:6512:401d:b0:539:f953:2da7 with SMTP id
 2adb3069b0e04-539f953300cmr4593355e87.50.1729073114673; 
 Wed, 16 Oct 2024 03:05:14 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f56f241sm44634515e9.22.2024.10.16.03.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 03:05:14 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v13 21/21] MAINTAINERS: net: lwip: add myself as a maintainer
Date: Wed, 16 Oct 2024 12:04:15 +0200
Message-Id: <466ecc59448cff7f6479a47fb8ccf26a4674705d.1729070678.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1729070678.git.jerome.forissier@linaro.org>
References: <cover.1729070678.git.jerome.forissier@linaro.org>
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

Add myself as a maintainer for the lwIP network stack integration code
and network commands as well as the sandbox ethernet driver for lwIP.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 09298e6bc86..7c6c368285e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1359,6 +1359,17 @@ F:	drivers/net/
 F:	include/net.h
 F:	net/
 
+NETWORK (LWIP)
+M:	Jerome Forissier <jerome.forissier@linaro.org>
+S:	Maintained
+F:	cmd/net-lwip.c
+F:	configs/qemu_arm64_lwip_defconfig
+F:	drivers/net/sandbox-lwip.c
+F:	include/net-lwip.h
+F:	lib/lwip/Makefile
+F:	lib/lwip/u-boot/
+F:	net/lwip/
+
 NIOS
 M:	Thomas Chou <thomas@wytron.com.tw>
 S:	Maintained
-- 
2.40.1

