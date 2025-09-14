Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15467CAC587
	for <u-boot@archiver.kernel.org>; Sun, 14 Sep 2025 13:14:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40A558350A;
	Sun, 14 Sep 2025 15:13:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b66lBsi5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6AB282A9E; Sun, 14 Sep 2025 13:00:50 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2050480B9B
 for <u-boot@lists.denx.de>; Sun, 14 Sep 2025 13:00:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-30ccea8f43cso2747167fac.1
 for <u-boot@lists.denx.de>; Sun, 14 Sep 2025 04:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757847646; x=1758452446; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rb2heW5SNDvanoZZN1hY8qbU1Do4c14QweFsivfJiq4=;
 b=b66lBsi5RX+dGlGdNpDj41iXL1uNa34nNiVWtokNT/qhKiO4WEtkczwTO71Mo+XbKb
 EH1IejNBmxna2J7RdqYAtVpcCCYHpDV7BTlWDxZnCxUe7ofL9Fcg3pFYB8xTaU5pJTek
 /uRLw9n7Zzhx9ERuVRhADrx6L+gJ4lKJ7f318XVHqXz7WHKQ9wAirQ3p1/7eWoCvJHvF
 M1cEGLLQF3kDoI7aUyx1VXIeb0ud6C1xCF2Z16SXUTOQhgdG5+ZvT9BYKRxmMHL9x33W
 efzFJq2nZ3haWyJfSXkkIqxrTewVvSZWq1E8QRL7neAm2YqomaK4n8bp+xbkjrPUXLvV
 vLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757847646; x=1758452446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rb2heW5SNDvanoZZN1hY8qbU1Do4c14QweFsivfJiq4=;
 b=AuC5XzwqGrH7h7CIGvM5ODn72O9tpYI2kNg507zcajUCCLjlNPuM4pR9cHdgvLProq
 NJCK29C3rJnmndZb+lgbI6GpxRXkbkcGeboGYw4JczVYtFW3HFOOMqlMpCUlb7ijHQPp
 X7Zj1UcSwEF7ds1BWctFI1EfPCiGTYoEPncTgqChN63Q8r44bK06ZYZJHgCtVIEy/pzD
 uu6sQXjJmL9Hb8DE90ftTAdJlqL+uP6TZDbg7PbMaYzv9miMTPLnSr7uxUNcLmyZ6tLW
 y+bNTpFFeiVWDdIHDdtvXC878QMkopb9vgYGKO3bUgfYO+e6ZvG5Pd6bG/IFVUepyrtS
 ZMag==
X-Gm-Message-State: AOJu0YzFdQPz7dZkz9u3HbP9p2YD0ZTCSJwIt4hXBqRQT/BVbJBhvO/w
 WgejujctoDitOpdiBumezaZ92cMsCHecVzMRmaBkgyvB+iY05DETeclRtHuGMh/D
X-Gm-Gg: ASbGncuY1RMD5s+LCi6j323dzzG58JiM8gaRZ1EhaC/trgi4jRf5Ht0+SiW90PJh9kI
 dwR57YAC5wSPg5wqNwKq38CpLolmM1Wh84hFWOXsWJoLrfABskkWaQSMUgoj6rrQ9qLyQGQpRbh
 iLynwqkRNQksdHYxzq2pLOaZzx299gg/myIE7OjJW56LE6+XT1n37LKZ+Qit6tQmrHn/M7Irfrb
 bEEPsM4TDlvE86t/UoWljbzBZtFv0mFhnn1a+OMtlq/hLN/Kv70xw5/xabmZl78Mkw+rr8DY7/u
 eNHnkvGFWQxQE9izDTpZvDXjJn7x54ch0w0nfsPxXaM6MJERxMSnJ/ahI6kjBUnhXAdrkw33ULk
 OrjzLeY4Cv3bUHWrudnCAMwq0yPmKVL62ika2UQjHkgjGjtvJzkVCG0cHrefG8NJFM6MxGCL/6v
 xLn9f3CQ==
X-Google-Smtp-Source: AGHT+IF1w2kuAl+TKzRNEzYAoKDXJfvxIoOPjXbXJQqyqkpMKCv2+Ja8klp+BODEIRL5POePf/8YhQ==
X-Received: by 2002:a05:6870:5d8d:b0:315:3453:5a1a with SMTP id
 586e51a60fabf-32e4c96eca4mr5597119fac.14.1757847646364; 
 Sun, 14 Sep 2025 04:00:46 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-32d32d56557sm2612720fac.1.2025.09.14.04.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Sep 2025 04:00:45 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 al.kochet@gmail.com, paul.henrys_ext@softathome.com, bb@ti.com,
 y.moog@phytec.de, w.egorov@phytec.de, francesco.dolcini@toradex.com,
 ggiordano@phytec.com, n-francis@ti.com, afd@ti.com, d.schultz@phytec.de,
 d-gole@ti.com, ravi@prevas.dk, carlos.lopezr4096@gmail.com,
 quentin.schulz@cherry.de, alice.guo@nxp.com,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 0/7] mkimage: Detect FIT image load address overlaps and
 fix related test/DTS issues
Date: Sun, 14 Sep 2025 10:59:25 +0000
Message-ID: <20250914110021.4103-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: 20250729125022.4220-1-aristo.chen@canonical.com
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 14 Sep 2025 15:13:36 +0200
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

This patch series enhances FIT image robustness by adding **memory
region overlap detection** to `mkimage` and fixing existing overlaps
in DTS files and `binman` tests.

The primary goal is to prevent runtime memory corruption from
conflicting load addresses in FIT images.

Key Changes:

1.  `mkimage` Overlap Detection: A new validation in
    `tools/fit_image.c` checks for overlapping load addresses
    within FIT configurations. `mkimage` now errors out with 
    detailed info on conflicts, preventing bad FIT image creation.

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

4.  Documentation: Added guidance for developers on how to
    determine ELF load addresses using readelf, linker scripts,
    and objdump when working with binman FIT images.

Impact:

This series improves FIT image reliability by catching overlaps
at build time, helping developers resolve issues before runtime
failures.

### Changes in v2:
- Fixed typo in test case name (testFitSignNoSignatureNodes)
- Added fixes for additional k3-am642 DTS files
- Added comprehensive documentation for ELF load address determination
- Enhanced copyright notice in elf_sections_tee.lds

Aristo Chen (7):
  binman: Fix typo for the test case name
  binman: Fix FIT image overlap issues
  binman: Fix FIT image overlap issues for testFitSplitElf
  arm: dts: k3-am6xx: Fix FIT image memory overlap in binman
    configurations
  tools: mkimage: detect overlapping load regions in FIT configurations
  test: Add test case for FIT image load address overlap detection
  doc: binman: Add guidance for determining ELF load addresses

 arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 22 ++---
 arch/arm/dts/k3-am625-sk-binman.dtsi          | 16 ++--
 .../dts/k3-am625-verdin-wifi-dev-binman.dtsi  | 16 ++--
 arch/arm/dts/k3-am62a-phycore-som-binman.dtsi | 10 +--
 arch/arm/dts/k3-am62a-sk-binman.dtsi          |  4 +-
 arch/arm/dts/k3-am642-phycore-som-binman.dtsi |  6 +-
 test/py/tests/test_fit_mkimage_validate.py    | 65 ++++++++++++++
 tools/binman/entries.rst                      | 18 ++++
 tools/binman/ftest.py                         |  4 +-
 .../test/276_fit_firmware_loadables.dts       |  4 +-
 tools/binman/test/340_fit_signature.dts       |  4 +-
 tools/binman/test/342_fit_signature.dts       |  4 +-
 tools/binman/test/Makefile                    |  6 +-
 tools/binman/test/elf_sections_tee.c          |  1 +
 tools/binman/test/elf_sections_tee.lds        | 32 +++++++
 tools/fit_image.c                             | 90 ++++++++++++++++++-
 tools/mkimage.c                               |  3 +-
 17 files changed, 257 insertions(+), 48 deletions(-)
 create mode 120000 tools/binman/test/elf_sections_tee.c
 create mode 100644 tools/binman/test/elf_sections_tee.lds

-- 
2.43.0

