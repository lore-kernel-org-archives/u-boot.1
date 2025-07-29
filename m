Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DD5C87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 05:10:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C249781E13;
	Wed, 30 Jul 2025 07:10:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Auqnvrxd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5BED82BCD; Tue, 29 Jul 2025 14:50:54 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD53782063
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 14:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ae0b2ead33cso166826266b.0
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 05:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753793452; x=1754398252; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t+cF6v5FZJLmspMLrIfHIoNXnCXZUEW5y0Kt9alUaIo=;
 b=AuqnvrxdNSp6F6s7S/t+63bv7WN9PYGZzQXEp1kI0+6lIEUGy/w2eo1+5taQ9D399z
 VIZVkXz0brhMQnF8SfrdpQWNmMirvpspTVyFBWXNIPWLgoRGHfKf0m89ztFrOw4uNiw5
 nykFhADTLGL8Swtj6z/chO5+1Tr+cJm3iK0FNaCyKbjOul6biMC4U31kP2A1xWck/O+0
 WcEk11731VLH+ik5rJY+Eb7UTzZ87pXDHr7B4VWBxX3GmDJFHsKD7Wf+h1h4qFbxUo4T
 91CcGq3SW8jCdBniXh6ti2/7JV150kS6xFDJ1fSNh9/SAp3tWl18LtG4zttsZqPqgb3h
 MN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753793452; x=1754398252;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t+cF6v5FZJLmspMLrIfHIoNXnCXZUEW5y0Kt9alUaIo=;
 b=dkDx3JUJt0F6e7jcRbWezgczA7YFEdqEIjLmlKaEWs/AH1tBo1kj+mKayQylOszrwz
 pPHJrM/opOj2QyEDqWurY70eFqma1BBglM6rLCn+3bTsuAGoafk3WoRpZZKcyuCuMjzW
 envwf1n9mEUSO+o1c2y+RYU+82VnDnt78XugYHCBeBNm73lk2RmVCja9tDUl9qaOSiMp
 hQ3IOTjot16Jg4PAf+yuyC5KDOBi6PTpJSip4S9TIIx+Sd9dZ4DZtsvNOVCxTd9CYWn/
 +kViyRlzaOWKDuZgYnedcPA0LloqQowJkvGluoFVElPvlUb2AV3Qzyv4y4dsLT4aTTNW
 i5qQ==
X-Gm-Message-State: AOJu0Yz3lUb2g2b+gInc0BeVo0yR5jwXXQDq9GE9GrYdlC9RvjA6bBBc
 UYcCB7Sa2kt/eZJXFBcwN2VYIIt5L9PHpi4DvvGec79JbHJBTxWB1Kc2HFCt6Q7Q
X-Gm-Gg: ASbGncsKz9tfdhzs2ksBVZJI33OsNTK128UF/5KsBK1hwaeqrYV6xAL0vWQ+oyGV14n
 ExjzUsxMHJSvKD2ChgnB2CLiO+bcdagYdOHvK3X/LDZEZweK1dNparD9cW1uZaHtF046bPty987
 kaYVVTlxwiJhSOU7bKfjJ0JJUCdIFCx6U49CUlbqUHeHerBlcyrsEdU2shUmglNlwx47eLh6ekZ
 6fbiO7UV36hnuB0cAswlJNblVDzQeR9CqK5IMeTAbqMcsOeNIqW54NHzMthrXvWshLQqIhvd3Xs
 nnRQn+gK5RyKL1fpfXhdZ6Bs453Ksp/+RdPDYktAkSY1w5Ks/DD5tGZlq7PD542nygitmRy+go+
 SrniwRjYFTQzldiLuP7xRQysmVz8E330sVLhCVPDU3fkAF/d+7/GBnZU+tDyScejRoWdmr6o=
X-Google-Smtp-Source: AGHT+IEJxxNdD8CwHILAshtppTak6nxukF/accqMPlnfKLMGDRfNMd64sP/5rJLnGcFypgn7AJ/CHQ==
X-Received: by 2002:a17:907:7fac:b0:ad8:959c:c567 with SMTP id
 a640c23a62f3a-af7bf9ffb01mr397418866b.10.1753793451443; 
 Tue, 29 Jul 2025 05:50:51 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af635acc99esm572223366b.115.2025.07.29.05.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 05:50:50 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 al.kochet@gmail.com, paul.henrys_ext@softathome.com, bb@ti.com,
 y.moog@phytec.de, w.egorov@phytec.de, francesco.dolcini@toradex.com,
 ggiordano@phytec.com, n-francis@ti.com, afd@ti.com, d.schultz@phytec.de,
 d-gole@ti.com, ravi@prevas.dk, carlos.lopezr4096@gmail.com,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 0/5] mkimage: Detect FIT image load address overlaps and
 fix related test/DTS issues
Date: Tue, 29 Jul 2025 12:48:51 +0000
Message-ID: <20250729125022.4220-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 30 Jul 2025 07:10:08 +0200
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

This patch series enhances FIT image robustness. It adds **memory
region overlap detection** to `mkimage` and fixes existing overlaps
in DTS files and `binman` tests.

The primary goal is to prevent runtime memory corruption from
conflicting load addresses in FIT images.

Key Changes:

1.  `mkimage` Overlap Detection: A new validation in
    `tools/fit_image.c` checks for overlapping load addresses
    within FIT configurations. `mkimage` now errors out with 
    detailed info on conflicts. This prevents bad FIT image
    creation.

2.  New Test Case: A Python test verifies the new detection.
    It intentionally creates an overlap (kernel and FDT)
    to confirm correct error handling.

3.  Fixes for Existing Overlaps:
    * Board DTS (k3-am6xx): Adjusted load addresses for TI
        firmware stubs to prevent conflicts. This resolves
        previously undetected overlaps.
    * `binman` Tests: Fixed several tests. U-Boot load
        addresses were shifted to avoid ATF conflicts. A new
        linker script for TEE ELF sections ensures distinct
        memory layouts.

Impact:

This series improves FIT image reliability. Catching overlaps
at build time helps developers resolve issues before runtime
failures.

Aristo Chen (5):
  binman: Fix FIT image overlap issues
  binman: Fix FIT image overlap issues for testFitSplitElf
  arm: dts: k3-am6xx: Fix FIT image memory overlap in binman
    configurations
  tools: mkimage: detect overlapping load regions in FIT configurations
  test: Add test case for FIT image load address overlap detection

 arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 22 +++---
 arch/arm/dts/k3-am625-sk-binman.dtsi          | 16 ++--
 .../dts/k3-am625-verdin-wifi-dev-binman.dtsi  | 16 ++--
 arch/arm/dts/k3-am62a-phycore-som-binman.dtsi | 22 +++---
 arch/arm/dts/k3-am62a-sk-binman.dtsi          | 16 ++--
 arch/arm/dts/k3-am642-phycore-som-binman.dtsi |  6 +-
 test/py/tests/test_fit_mkimage_validate.py    | 65 ++++++++++++++++
 tools/binman/ftest.py                         |  2 +-
 .../test/276_fit_firmware_loadables.dts       |  4 +-
 tools/binman/test/340_fit_signature.dts       |  4 +-
 tools/binman/test/342_fit_signature.dts       |  4 +-
 tools/binman/test/Makefile                    |  6 +-
 tools/binman/test/elf_sections_tee.c          |  1 +
 tools/binman/test/elf_sections_tee.lds        | 31 ++++++++
 tools/fit_image.c                             | 78 +++++++++++++++++++
 tools/mkimage.c                               |  3 +-
 16 files changed, 238 insertions(+), 58 deletions(-)
 create mode 120000 tools/binman/test/elf_sections_tee.c
 create mode 100644 tools/binman/test/elf_sections_tee.lds

-- 
2.43.0

