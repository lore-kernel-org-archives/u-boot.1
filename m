Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C43CD4F21
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 00:26:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E0DF83CD3;
	Wed, 13 May 2026 02:26:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wolfssl-com.20251104.gappssmtp.com header.i=@wolfssl-com.20251104.gappssmtp.com header.b="rg/7Vhog";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54D7A800AE; Wed, 13 May 2026 02:26:28 +0200 (CEST)
Received: from mail-dy1-x1333.google.com (mail-dy1-x1333.google.com
 [IPv6:2607:f8b0:4864:20::1333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C131E800AE
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 02:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aidan@wolfssl.com
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-2f03d6cf77bso6980217eec.0
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 17:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20251104.gappssmtp.com; s=20251104; t=1778631983; x=1779236783;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xiGqcorCSeGA0518Z8g3XVkU8ovmK3m/tvMvvrikD4o=;
 b=rg/7VhogE0u75qSXLkYNU+OYndYuQN7AAUnv37PUTI7LOc0bNvXYfJ7JWLpmuKrL3D
 b0ppccLaSdfWgcb4yFuxJpOouDYWWMx4x8tq6ZaVCRInt89Q0BdChQXR/Ic5XsHVBUqQ
 PTT+G30vS2/UHOU4sq0JrcKF4+9O+wA520MCvoT971HkgfX2waQ17/fkdjYAracP/uO9
 hh/nV1GUUpTXlhNDOlKO9JQDODn8BX2R9k5JKzKX2jPDi2Raa7m9+M1VbJMM/UCS57D4
 x0mj+AXZXaGW2rGYm3X7B0KKQMIupL8DH+J8dXR14cGbSbjYAA59WH0pB0CYRsw26jX+
 jYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778631983; x=1779236783;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xiGqcorCSeGA0518Z8g3XVkU8ovmK3m/tvMvvrikD4o=;
 b=Fjig7aZY2Ywztl8ypJugqMxilCEN9bYr+QiqFU/Uv7d5Mk2ZKiwzHGWMiJrrkurxpi
 iET8JRo7+i9gFgtBa4HLgAPem2r92dZjRG22hKBqrVZM+ztOojXu82mne0+tCUbUV8Ar
 6+xdpgDTLUB1iw6YFw0B1Aogv+7Lepom1NlIj9ijLXyUHh/LMaOjGk39GDoAHImTgC5I
 StTlG4WWcrzqvh+lDK93CqDsLIZYtV8P9s7cC4BM7yuk2h0EOy0vh9pE9LW+PDZkOBVM
 jIWHbGUKq/6fRDxl9devsDK17RoND1WHl1jLmwbIGgzdasurp09QyLkwpefuzSkwk5to
 275g==
X-Gm-Message-State: AOJu0Ywrgn+EiF+ZclBX4OPHB2MtBNkxE6QHdu5Z+87ZVAwRgvG3dCbg
 /IIsTraJ/lytNnl62ZZLz4lj7TAdmFL+y5GhMxDFog/oUbU+QLZkfcVvmPZWS4IxHGvseWxOUdg
 NogEJj7g=
X-Gm-Gg: Acq92OHWv+CKWyniD9YEqRfbisOXgHRqbPHxhvKxdTngjKhLKvp1xRQLmli7evCAv0d
 s8TIHHUcjp0IWqvaeKzz3ks7Xk0WmMaL6B2HdDWDPTqQpN9NoIjAsHuSgXopyC3mkcTOhG86GlF
 ujfg8MkgmcSuczI1C7lEZs9awdfU3l/WLJXdzsOePJBCU2yydjqySn5QOsdsVpH/BUeVkoNN2q9
 PPpk9AzrBcI/64UnDrGSXqSaAlA9Ay4s5CdRe/oCD1Dws7pYGJBFMys4vJBNIru3cIBqxTao0nL
 ag9FY8kC6eUXfZdyWNooPGbaRclF170aYThjSZqsATLZipNoaQIsuCNlyey01MqXISSzkXYiyEj
 V0cSIT32NqWkCRWwt0x8mc2OgqKvmrB+5ngDe00WhnfhtbyK6QI+UirRwQcK+SjwWiBnXxr7oUj
 4wh5IlH74HtCPBHGM6NLNdVSs5l4EP2Rpm8buDAGstuDMB2Qc9rts8et4CD5q7MqOqhgoQtbrw8
 MOL7O2g8fNo0dZR1pOr6hneIhZtTmKAoUKYsgi5Yqk=
X-Received: by 2002:a05:7301:1687:b0:2dd:c066:c02 with SMTP id
 5a478bee46e88-30119874aa8mr715152eec.22.1778631983057; 
 Tue, 12 May 2026 17:26:23 -0700 (PDT)
Received: from localhost.localdomain ([207.231.76.218])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8884752ccsm19547827eec.17.2026.05.12.17.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 17:26:22 -0700 (PDT)
From: Aidan Garske <aidan@wolfssl.com>
To: u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, David Garske <david@wolfssl.com>
Subject: [PATCH v4 00/14] tpm: Add wolfTPM library support for TPM 2.0
Date: Tue, 12 May 2026 17:26:04 -0700
Message-ID: <cover.1778619453.git.aidan@wolfssl.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 May 2026 02:26:49 +0200
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

Hi all,

This is v4 of the wolfTPM TPM 2.0 stack integration for U-Boot.

What this series does
---------------------

wolfTPM (https://github.com/wolfSSL/wolfTPM) is a portable TPM 2.0
library that provides a full TPM 2.0 command set, an SPI/MMIO HAL,
and firmware-update support for Infineon SLB9672/SLB9673 hardware.
This series wires it into U-Boot as an *optional* alternative
backend behind the existing 'tpm2' command, plus the supporting
infrastructure to make it run on QEMU+swtpm, sandbox, and real
Raspberry Pi 4 + Infineon SLB9672 hardware.

Why a second TPM backend
------------------------

U-Boot already has a working TPM 2.0 stack and Peter Robinson asked
in v3 review what value this brings. The honest answer is:

 1. Firmware update support for Infineon SLB9672/SLB9673.  The
    existing U-Boot TPM 2.0 stack has no firmware-update command;
    wolfTPM provides the manifest+image flashing flow used by
    Infineon's recovery / security-patch tooling.  This is the
    primary "why now" reason for boards shipping Infineon TPM HATs
    where the field-updatable firmware is part of the supported
    lifecycle.

 2. Optional native SPI HAL.  The wolfTPM library can talk to a TPM
    via either (a) U-Boot's existing TPM driver model (the
    WOLFTPM_LINUX_DEV path; this is what QEMU+swtpm uses in this
    series) or (b) its own SPI HAL bypassing driver model.  Path (b)
    is what lets the BCM2835/BCM2711 driver in patch 3 talk straight
    to the Infineon HAT on a stock Pi 4 without needing the broader
    TPM uclass machinery.

 3. Backend selection is a Kconfig switch; CONFIG_TPM_WOLF is
    default-off and 'tpm2' continues to dispatch to the existing
    backend unless the user opts in.  No defconfig in tree turns
    this on today except the new rpi_4_wolftpm one this series adds.

Maintenance
-----------

wolfTPM is imported as a git subtree under lib/wolftpm (mirroring
how lib/mbedtls, lib/lwip and dts/upstream are maintained in tree),
and tools/update-subtree.sh knows about it.  Updates flow through
the standard `git subtree pull` path, not as separate patches.

Note on license: github.com/wolfSSL/wolfTPM currently shows GPL-3.0
in its repo badge.  wolfSSL is working on a GPLv2-compatible release
for upstreaming purposes; this series is being sent now to get
review on the integration shape, with the understanding that the
license question is being addressed separately by wolfSSL before
this is appropriate to merge.  I will follow up on the list when
that's resolved.

Changes since v3
----------------

Addressing review from Peter Robinson on v3:

 - SPI driver copyright attribution fixed to credit the original
   Linux kernel authors (Chris Boot, Stephen Warren, Martin Sperl)
   the U-Boot driver is ported from.  The driver is still in this
   series rather than split off, because nothing else in the tree
   uses it yet and decoupling it would just create a "blocked on"
   dependency chain; if reviewers prefer it split, happy to do that
   in v5.
 - rpi_4_defconfig is no longer modified.  v3 added CONFIG_LOG /
   LOGLEVEL=7 / UNIT_TEST / CONSOLE_RECORD / HEXDUMP to it - that
   was wrong, it's not what the average RPi user wants.  Instead,
   v4 adds a *new* rpi_4_wolftpm_defconfig that enables only the
   bits a wolfTPM user actually needs (SPI + TPM + wolfTPM).  No
   debug / unit-test pollution.  Users who don't want wolfTPM
   continue to use rpi_4_defconfig untouched.
 - The TPM device-tree node for the SLB9670/9672 on RPi 4 has been
   moved out of bcm2711-rpi-4-b.dts (which is Linux-derived and
   should match upstream) and into bcm2711-rpi-4-b-u-boot.dtsi
   (which is the U-Boot convention for U-Boot-only DT additions).
   This means SystemReady firmware-provided FDTs and the upstream
   Linux DT are no longer polluted by this series.
 - DT changes are now split into three per-device commits (RPi4,
   QEMU arm64, sandbox) instead of one combined commit.
 - Commit messages rewritten to explain *why* the change is being
   made, not just *what* configs are set.

Branch
------

Full 16-commit history (including the subtree squash + merge that
aren't sent to the list because they're too large / are a merge):
  https://github.com/aidangarske/u-boot wolftpm-v4-patches

Or pull the wolfTPM source straight from
  https://github.com/wolfssl/wolfTPM @ 664db130d57.

Testing
-------

 - QEMU arm64 + swtpm Python test framework
     ./test/py/test.py --bd qemu_arm64 \
         -k "test_wolftpm and not ut_cmd"
   matches v3: 19 passed, 2 skipped.  (The 2 skipped are
   test_wolftpm_change_auth, which requires wolfCrypt, and
   test_wolftpm_get_capability.)
 - rpi_4_defconfig (unmodified vanilla path) still builds clean.
 - rpi_4_wolftpm_defconfig builds clean, TPM node is present in
   the compiled bcm2711-rpi-4-b.dtb at /soc/spi@7e204000/tpm@1
   with compatible "infineon,slb9670", "tcg,tpm_tis-spi".
 - Real Raspberry Pi 4 + Infineon SLB9672 hardware: tpm2 autostart
   / info / get_capability / pcr_read / pcr_extend / caps / clear
   all return expected output; firmware-update path verified.

v3 thread:
  https://lore.kernel.org/u-boot/?q=PATCH+v3+tpm+wolfTPM

Aidan Garske (14):
  tpm: export tpm_show_device, tpm_set_device, and get_tpm
  include/hash: add SHA384 hash wrapper declaration for wolfTPM
  spi: add BCM2835/BCM2711 hardware SPI controller driver
  arm: dts: bcm2711-rpi-4-b: add Infineon SLB9670/9672 TPM in U-Boot dtsi
  arm: dts: qemu-arm64: add TPM TIS MMIO node
  sandbox: dts: add TPM SPI emulator node
  tpm: add wolfTPM build rules and Kconfig
  tpm: add wolfTPM headers and SHA384 glue code
  tpm: add wolfTPM driver helpers and Kconfig options
  cmd: refactor tpm2 command into frontend/backend architecture
  tpm: add sandbox TPM SPI emulator
  test: add wolfTPM C unit tests and Python integration tests
  doc: add wolfTPM documentation
  configs: add rpi_4_wolftpm_defconfig

--
2.47.3
