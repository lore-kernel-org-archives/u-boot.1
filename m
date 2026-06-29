Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DDCC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 08:02:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F556841F2;
	Mon, 29 Jun 2026 10:02:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="TnsK2QSl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14D50841F2; Mon, 29 Jun 2026 10:02:47 +0200 (CEST)
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 221D284105
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 10:02:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 20260629080243ea73218f3700020714 for <u-boot@lists.denx.de>;
 Mon, 29 Jun 2026 10:02:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=GX90VZNc8aXsvYWaySsDSH8P8RtDaRz8usiTNbbRbtg=;
 b=TnsK2QSlL0XuUeexuWbwyZEDpCnn8CERYKhOPZrxUnOVeo4hG8lUeDWE6satu4PjkaedOZ
 9XG+F/73xAwmThgJ17kUJYaY5eZfE6asJ2CFroPov3aJfEOrYghXMrt/PGKg7OH0Sc+TZVZu
 nCeWZniXSi6gwscg9C+bfYZzDNM6ld6/qEYQO87+jprT52MxuH0+E7lTBgXoWT6R9Ls3IdmD
 UWMFvRZIbVTKl09VCJKejYtxCjh9PHuy1zU8CGQa6aZWlKSxt83tNGqM71H82rRxrJGgPhkr
 H5IJXDImJZ7c+b8WPn9dlJVUUDi7D+a3iua984nq8A+OiKQNmsjgMBpw==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 David Lechner <dlechner@baylibre.com>, Heiko Schocher <hs@nabladev.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v4 0/6] Improve U-Boot's TPM handling in the non-EFI case
Date: Mon, 29 Jun 2026 10:00:59 +0200
Message-ID: <20260629080241.36311-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
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

With EFI U-Boot always allocates a buffer for the TPM event log. If
a previous bootloader stage started an event log, U-Boot would copy
the entries to that allocated buffer.

Without EFI U-Boot wants to reuse the event log memory from a
previous bootloader stage instead. If U-Boot is first component to
start the event log, e.g. when used in qemu there would be no memory
allocated for the event log.

So allocate memory in tcg2_log_prepare_buffer() if no event log was
found and no buffer was allocated already.
Also copy the address of the event log into the device tree for the
kernel so the event log is accessible from Linux userspace too.

Changes in v4:
- reword commit message
- include Ilias' patches for unifying event logs in the series

Changes in v3:
- fix test failure
- sync description with cover letter

Changes in v2:
- fix return value handling
- imply DEVRES in config TPM
- use fdt_getprop for reading property
- don't wrap #include in #if
- fix memory leak in error case of tcg2_log_prepare_buffer
- handle NULL elog parameter in tcg2_measurement_term
- use CONFIG_TPM2_EVENT_LOG_SIZE
- pass log_size instead of position in dt

Ilias Apalodimas (2):
  tpm: unify the tcg2 eventlog structures
  tpm: unify the eventlog initialization

Ludwig Nussel (4):
  test: include mapmem.h explicitly
  tpm: print all PCRs from pcr_read
  tpm: allocate tpm event log if missing
  Fix tcg2_measurement_init call

 boot/bootm.c               |  18 ++---
 boot/image-fdt.c           |  69 +++++++++++++++++
 cmd/tpm-v2.c               |  69 ++++++++++++-----
 include/tpm-common.h       |   2 +
 include/tpm_tcg2.h         |  44 +++++------
 lib/Kconfig                |   1 +
 lib/efi_loader/efi_tcg2.c  |  97 +++++-------------------
 lib/tpm_tcg2.c             | 151 ++++++++++++++++++++++++++++++-------
 test/boot/measurement.c    |   1 +
 test/py/tests/test_tpm2.py |   9 +--
 10 files changed, 296 insertions(+), 165 deletions(-)

-- 
2.43.0

base-commit: 3cdce049f90d77c3f9221f1eb73922384c8972c3
branch: us-tpm4
