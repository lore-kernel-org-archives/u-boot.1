Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1545C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 12:07:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C56886D37;
	Mon,  4 Dec 2023 13:07:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="I013MKEg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BEAD86DEE; Mon,  4 Dec 2023 13:07:01 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6ECB86501
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 13:06:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50be03cc8a3so3147132e87.1
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 04:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701691617; x=1702296417; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Hm0u+r1/wjMno+XInjke18oJTQv/HcXWOrFJg9jsumA=;
 b=I013MKEgnToE4cUXF+IG5VNlcRDKOxIJ9gApXGUMotmU8PKm8hN4bXNy8BgZMXbMw6
 y6ZYGz/NGo+vERy0XDmiPMim6QnndjTsMn4gKurJV9GDfwKbkgpPc0Do7CjyQv3/U6mQ
 8nhS3iHItO29jE3+eM2CydkbtGJn/KEUBXrkW12tSYPsHGbiGkfX0/JwVFvDfL8umB9p
 VJ/oByiEiKlO8g1lTqWMb/gufRttBeTuan933IuK5kczkeETzBECog6J5p1E+Bub68+z
 VviATcXyI/qsvbpG6oqvQ26f4+Sr7LtZBrQZnpk5o3/uERpfOOPHszAV6Qwbn7Ba2/q2
 PVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701691617; x=1702296417;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hm0u+r1/wjMno+XInjke18oJTQv/HcXWOrFJg9jsumA=;
 b=ljLUKmfCPnABc9J1bgHcX67Qb/bKXe/I59ixPL8atJnG/Vdp9Gj1PiNZfgDyHJ46WK
 Uf4NGdg+bdc9nTGgCkCOiSiPPHN3jEqekOODRvv+zd3r3wGzQq3fDWSiyO9dfpuyWkRy
 vfIccCpm+lBNyLjdlEErBZAtF5bzNjyOjv3JE7v0KR3nOfb/5m+FXHaOC7O2ikzj/CIN
 s6N5r1zh3OQie3JNdrIfBlnd8Eb0QeNTDNKqHMDHSNkUmSf7TCTj38g6t6nXU7A3+Ror
 LjEN7e58xEUEETGk82tFXEBxea76Ef0H73aH2CembRmGcK1Xsz77b5DOgYMPv7k3EVTF
 cp3Q==
X-Gm-Message-State: AOJu0YwV0qIt+GHRr+VVApCLX5wjBSSA8J36ltAfFC42weOX/tV6yLSU
 YRjGbZwpccVigpXWtlag5FKTuovextz3kXVnhkRPeg==
X-Google-Smtp-Source: AGHT+IEN0udMLZCevZic1O02shwRGkdKMm2SvEkD2oV68GC3vTLaHxr9rYglr3tdyR890mh7u0QOyA==
X-Received: by 2002:ac2:4e84:0:b0:50b:f305:867a with SMTP id
 o4-20020ac24e84000000b0050bf305867amr859111lfr.138.1701691617392; 
 Mon, 04 Dec 2023 04:06:57 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a0565123ba100b0050befebf0ccsm541675lfv.292.2023.12.04.04.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 04:06:57 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com,
 trini@konsulko.com, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv1 0/9] net fixes prior lwip
Date: Mon,  4 Dec 2023 18:04:37 +0600
Message-Id: <20231204120446.3277-1-maxim.uvarov@linaro.org>
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

Add small net fixes prior lwip patch.

CI for this patch set:
https://dev.azure.com/u-boot/u-boot/_build/results?buildId=7460&view=results

Maxim Uvarov (9):
  test_net: print out net list
  net: sandbox: fix NULL pointer derefences
  net/smc911x: fix return from smc911x_send
  sandbox: eth-raw-os: successful return code is 0
  driver/net/rtl8139: remove debug print
  mach-socfpga: do not overlap defines with lwip
  bcm_ns3: fix overlap define with lwip
  omap3: rename mem_init
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

