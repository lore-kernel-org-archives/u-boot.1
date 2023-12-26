Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399D7C46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 15:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EA9886FCE;
	Tue, 26 Dec 2023 16:48:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yEnTuIur";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA8A18758C; Tue, 26 Dec 2023 16:48:33 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A44E086F56
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 16:48:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2ccae380df2so25846811fa.1
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 07:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703605710; x=1704210510; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FfcAiyThz87WqR8wR1kjDx0WteqKDikSsA0ZjALyDW4=;
 b=yEnTuIurenGs7cNKd35n1/z9gKbwy8vRpXD+Mrw0z8vY7iej09/flIsmaQr8bo9rr2
 IJqKu/bNBxff6BPITDBGNXKuO4bFxopvucPV9DcIqXx1M8qERQCpCCQBBTID4/b1JG+Q
 Ss1oat7Nn5z3Twayvrm1s7+7eqLWtgjS7frJdvTx+TW4ks/3NsnyMa13/dSrJcvh90dL
 kEBk8qgWjnODZBLZI9+9kaSpwtcE9g1OZPW5yd1SQ8f7fTcFpVJ2iVySDpwqOD1oZyz2
 6FLTVwsjhux0Pr+r9yQ0LNsrcfeN1bAsLLL/8JAG2D1N1sQjKOhu+r6SuPPaYqV17y50
 n2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703605710; x=1704210510;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FfcAiyThz87WqR8wR1kjDx0WteqKDikSsA0ZjALyDW4=;
 b=BXHYPK7ih/landPUfN2PaOzOg5r489hcuQDzvuS9mMPwMLufx/jHg6K+cpAFwnfaro
 eMeBs+cY0iBHB/ktQnCpE3EBRbS18DNZTuVQNUzflGJMiwDLoX3nZDpKdgHtn0ednub5
 3zmoToECHaTM/ozE20DkKwzNeTRkSXROFnp0rYs0acgwOA6wI4a6DOeutEJXxZ5sTV7q
 sKlQMUf8w62vJMwjPdp0M7IPiYlHrM0GPFKwlqQhBFrBq4DbeknYjdjOYgNO9Syk+BzU
 CoW/rFl2Ax6lG8OsoEZ/SEZCnMau1ZGRByfhS5L0x7dOHoWsQVCfM9pVcORWm4GJnzlJ
 atMg==
X-Gm-Message-State: AOJu0Yz5zk6bFIpzHaF96JSz691mOF1qT87ool8IMBFxctS2UGlevyex
 PH1K2qMXL9IPuiUXWUeu8ExnyhRUACnNIdDPp9wzl7Z7ygY=
X-Google-Smtp-Source: AGHT+IEItHdUfN8biRmcc2ZdYZ13pOHrC7qPQqbfQd80qhwCME6OXzaD/lTPLvPpC5GkJIzqNDc0VA==
X-Received: by 2002:ac2:5d67:0:b0:50e:4d3c:c4dd with SMTP id
 h7-20020ac25d67000000b0050e4d3cc4ddmr2083496lft.105.1703605710208; 
 Tue, 26 Dec 2023 07:48:30 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 d25-20020a0565123d1900b0050e743b0b2csm1089336lfv.34.2023.12.26.07.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 07:48:29 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com,
 trini@konsulko.com, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv3 0/8] net fixes prior lwip
Date: Tue, 26 Dec 2023 21:46:11 +0600
Message-Id: <20231226154619.5071-1-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
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

Add small net fixes prior lwip patches.

v3: - some small review fixes.
v2: - rebase on the top of master tree with descriptions fixes
      suggested in review comments.
Maxim Uvarov (8):
  test_net: print out net list
  net/smc911x: fix return from smc911x_send
  sandbox: eth-raw-os: successful return code is 0
  driver/net/rtl8139: remove debug print
  mach-socfpga: do not overlap defines with lwip
  bcm_ns3: use device specific naming for variables
  omap3: use device specific naming for mem_init
  Makefile: add dtbs to clean

 Makefile                                           | 2 ++
 arch/arm/include/asm/arch-omap3/mem.h              | 2 +-
 arch/arm/mach-omap2/omap3/board.c                  | 2 +-
 arch/arm/mach-omap2/omap3/emif4.c                  | 4 ++--
 arch/arm/mach-omap2/omap3/sdrc.c                   | 6 +++---
 arch/arm/mach-socfpga/include/mach/handoff_soc64.h | 6 ------
 arch/arm/mach-socfpga/wrap_handoff_soc64.c         | 9 +++++++++
 arch/sandbox/cpu/eth-raw-os.c                      | 2 +-
 drivers/net/rtl8139.c                              | 2 +-
 drivers/net/smc911x.c                              | 2 +-
 include/configs/bcm_ns3.h                          | 6 +++---
 test/py/tests/test_net.py                          | 2 ++
 12 files changed, 26 insertions(+), 19 deletions(-)

-- 
2.30.2

