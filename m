Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0C7C3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 25 Dec 2023 15:41:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CC6486F56;
	Mon, 25 Dec 2023 16:41:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="P7uYAFjJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0134786FCE; Mon, 25 Dec 2023 16:41:44 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E861486E65
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 16:41:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2ccc41e1105so6180911fa.0
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 07:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703518900; x=1704123700; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V1MzR1eu/1kYIO2/YVFQztysHDTXalnCw9Jhayno+9I=;
 b=P7uYAFjJEtp6clHkUL1aNI+Wmj2Ct93dM6g2Uog89XdQImo56S7NBxrErQ1C1MVUWp
 JGfA6PtQoZFBJ2VfRHxytEbdW1uQVRHRr3bLOt6/K2/CWF+Hg6gzLIT18EMVRB78Rg6W
 DnM83CJPHE+aXVkIpuGVa+RuEMLIIIQV6qebK629zc67biJoWR8mSCAaXTiN7vWVZ1K7
 jkBqRei0hcNSQHV7DlH1FY7Pr+7fwWu9A3uk4uYvB+Wuiuas3PRfKObr/gt/RIkhga/L
 BOTlgtEDLriP6aLaAl10LAaB3GBoNqKCW2E6bqANLxkCJNnJkpMgY640wnfCSNwd5KT+
 h1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703518900; x=1704123700;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V1MzR1eu/1kYIO2/YVFQztysHDTXalnCw9Jhayno+9I=;
 b=YGEETxwbXOfitd4OQx0hyzPMz2vhsVzVklpy0yJsll+RtIEWCKafKGfQFBRO1Z/dVk
 OxhVK2C/r55B59lYxJ40t+EgTlByoRT+zQRH2lo0WUjP+mps7DcmSvz60Tcvj9vLMU9W
 l3glv76QyERwg8MiB0n/p6ezXLcGn03Ws0tQlfUn/MW7L5ipFrHrZLOWokK9vozP3IeM
 rOyBCkT9AyU41+86mLVpdN6HjaZWo72Q1z+jXRuKW4OqO258g0c/FnCYb4PGBCrtDq3I
 vOWUCvoy5NGqRhVnWF2L7qPFvXwtA4dSCB9pevhEAs5TEU/mhcIoZ+M9UZcB1ROlFmdm
 H/9g==
X-Gm-Message-State: AOJu0YzIM+KqTNFrmqAMhCPpj4PnuZJAQir0wMFAJQZ9fyMMfk3MSajb
 USsrT4rewVBtS4UY59bH8UlgrnobBCcyaVcHky5n+1sgKwY=
X-Google-Smtp-Source: AGHT+IGHk2rD/a8kh5Xno9dCILf+gknn273BrOWJSqbyuIidjTSwUFVcd18yj8viResIe57i/g+5WA==
X-Received: by 2002:a2e:9d9a:0:b0:2cc:75c0:47bf with SMTP id
 c26-20020a2e9d9a000000b002cc75c047bfmr2019103ljj.37.1703518900375; 
 Mon, 25 Dec 2023 07:41:40 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 a17-20020a2ebe91000000b002cca6eafc44sm1425644ljr.113.2023.12.25.07.41.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Dec 2023 07:41:40 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com,
 trini@konsulko.com, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv2 0/9] net fixes prior lwip
Date: Mon, 25 Dec 2023 21:39:20 +0600
Message-Id: <20231225153929.8284-1-maxim.uvarov@linaro.org>
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

v2: - rebase on the top of master tree with descriptions fixes
      suggested in review comments.

Maxim Uvarov (9):
  test_net: print out net list
  net: sandbox: fix NULL pointer derefences
  net/smc911x: fix return from smc911x_send
  sandbox: eth-raw-os: successful return code is 0
  driver/net/rtl8139: remove debug print
  mach-socfpga: do not overlap defines with lwip
  bcm_ns3: use device specific naming for variables
  omap3: use device specific naming for mem_init
  Makefile: add dtbs to clean

 Makefile                                           | 3 ++-
 arch/arm/include/asm/arch-omap3/mem.h              | 2 +-
 arch/arm/mach-omap2/omap3/board.c                  | 2 +-
 arch/arm/mach-omap2/omap3/emif4.c                  | 4 ++--
 arch/arm/mach-omap2/omap3/sdrc.c                   | 6 +++---
 arch/arm/mach-socfpga/include/mach/handoff_soc64.h | 6 ------
 arch/arm/mach-socfpga/wrap_handoff_soc64.c         | 9 +++++++++
 arch/sandbox/cpu/eth-raw-os.c                      | 2 +-
 drivers/net/rtl8139.c                              | 2 +-
 drivers/net/sandbox.c                              | 3 +++
 drivers/net/smc911x.c                              | 2 +-
 include/configs/bcm_ns3.h                          | 6 +++---
 test/py/tests/test_net.py                          | 2 ++
 13 files changed, 29 insertions(+), 20 deletions(-)

-- 
2.30.2

