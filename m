Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DB2FF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 08:06:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67817845C8;
	Thu, 30 Apr 2026 10:06:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gqgvE7Sb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2EC28460C; Thu, 30 Apr 2026 10:06:38 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 852E884198
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 10:06:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so7910685e9.0
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 01:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1777536396; x=1778141196;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/QV82wuNp4nweUt0s7vcjJ2bxGHNpCyc6rgkz0B9U9w=;
 b=gqgvE7Sb+2ZEWWR8qu7ELv2RMTLHZM/BuBRelCZjsNDSXEUoxiASMY906LkEQ6KZzj
 WtuRf+yUqdRcEA0W0SM1qn23e8n99jPuG1njU4AQGaPeE38ivjYruUe8Ye0UHvr8oeNy
 J+LXNox2tnCpofIrTH0HiTTKeXdgcchLH0xZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777536396; x=1778141196;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/QV82wuNp4nweUt0s7vcjJ2bxGHNpCyc6rgkz0B9U9w=;
 b=lirXsugiRVhVPC/0SKvacDKv9Iq/ajXfYTnDvFesRmZ+VmtQPSB1UCjDD/QHv+rZKD
 gWdfkNE5fk+a/7wWmB+AJRIhTmVSHGN7kFLQp3CGjO9DokRNCuYWGifc2g3UUJSdw8t2
 wBZhwCps6ZbgxvEjjHXkFkX9PhE90R/P/kkpg8GtyV/Rlqr8TsU+pu9N0s+iFRPMYHAy
 WpI/BTCShSdd5AYkisMWy4mPe7O+spnF0cUQz3vin3oZvqCOiQ1//HIE3tsgKWtmOQO0
 kwhmRemcflL1LaUkCjLDSc1ZUrziJkwlrUXVSfAusEVfqt7ScPTIyE/7d2JhHZtDV0A0
 Y5mA==
X-Gm-Message-State: AOJu0YyfN7oM9QiK4YMpA4HtC3PgGnXUzMZhgcX3mNooGWkz8dGr4Z7n
 kOoXIbZAMvyhLrTIu2ABqkWImeEa+L+JDi6zEnZpalthHW+o5oplNGm7bSQQhWAAWxVbTGISg0U
 l6pyk
X-Gm-Gg: AeBDieskL8uhfD4ufXCyDUBbfYURS9cjvmU2a3+KxYci5PkzAcNkR55oin0p1cXGsrB
 uMySQ7sWesdK7jLIW611O8gSSu0XWCsG5LGJmSLbRU/gBisx2dYU+cwgFaWJGP4T2hSanb1s76b
 WXejdLMc7RC4kXHQiw9seF6bqEkDJc2odCWrdLUY5w4gYXc1c4RAo0z7lSJi311XMZnqEb6A7fw
 dqKNfkzN7hHKeYBb+9AmpDuFnbKVBfaemYbeJzJQUmjJj+44Coj/nbRxROzH1ZIqX76QhjRs2F5
 mufM3zGVM3ed9INNd69pC+Ubupwudaog2VjKmKOt4fHUVXDFvnk8lap1++YUSluR/pQWurOKHgs
 s/zFyKk/z8LnNJ0O3Cq+I4IvUi0p1nfdKCeQ0j8GvcZ+qPBerjy5AfkGYNyrou9iREC/sDBvc1J
 5eEkP/n3PCn4bAVH9ZQ11LaXLUgKxMDdac0Zww12eAv9sYJyDUkjtFKVSEysmhqynaRZ80I9e9H
 1Rtz5Kwhd2VpOevDp/qfCquPl/xi96Cycsnq5FxogoxKyR32zd8ce5ALajkuu3RGBPCwXb3nZLm
 bDNIPCxRcJGcX8QojiyGjO+pwGQTrCxw9kIWtai3FW8TSQ==
X-Received: by 2002:a05:600c:c170:b0:489:1a63:509c with SMTP id
 5b1f17b1804b1-48a83d06bc3mr27641745e9.0.1777536395535; 
 Thu, 30 Apr 2026 01:06:35 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-82-56-22-134.retail.telecomitalia.it. [82.56.22.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-449c576d0a2sm668071f8f.31.2026.04.30.01.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 01:06:34 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 John Toomey <john.toomey@amd.com>, Jonathan GUILLOT <jonathan@joggee.fr>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v8 0/8] Support metadata-driven A/B boot for STM32MP25
Date: Thu, 30 Apr 2026 10:06:01 +0200
Message-ID: <20260430080627.849636-1-dario.binacchi@amarulasolutions.com>
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

This series, the mainline version of [1], provides the necessary changes
in U-Boot to support the metadata-driven A/B update flow for STM32MP25
boards. It implements the logic required to dynamically select the boot
bank based on FWU metadata.

These changes are designed to be backward compatible while providing
the necessary infrastructure for the A/B scheme.

The series has been tested on the STM32MP257F-EV1 board.

Additionally, some patches in the series propose changes with
general-purpose utility:

 1/7 lib: uuid: add partition type GUID for extended bootloader
 4/7 cmd: part: support lookup by UUID in 'part number'
 6/7 fwu: add helper to get image GUID by type and bank index

[1] https://github.com/STMicroelectronics/u-boot/pull/6

Changes in v8:
- Skip the test in case the CONFIG_MCC is not enabled or the mmc
  device is not found.
- Add Reviewed-by of Patrice Chotard
- Skip cmd_test_part tests for configurations where MMC is not enabled
  or the device is missing

Changes in v7:
- Add Reviewed-by of Simon Glass for patc 7/8 of "test: dm:
fwu_mdata: add test for fwu_mdata_get_image_guid"

Changes in v6:
- Add Reviewed-by of Simon Glass to patch 3/8 "test: cmd: add unit
  tests for part command"

Changes in v5:
- Update doc/usage/cmd/part.rst to reflect the changes related to the
  part command.
- Add Acked-by of Ilias Apalodimas to patch 6/8 "fwu: add helper to get
  image GUID by type and bank index"

Changes in v4:
- Place the part command tests in the cmd suite rather than the dm
  suite.
- Order the include files according the U-Boot coding style.
- Add patch 7/8 test: dm: fwu_mdata: add test for fwu_mdata_get_image_guid

Changes in v3:
- Wrap lines exceeding 80 columns in test/cmd/part.c file.
- Combine run_command() and ut_asserteq() -> ut_asserteq(1, run_command(
- Add kerneldoc comment for fwu_mdata_get_image_guid() above its declaration
  in fwu.h.
- Add log_warning() messages to fwu_platform_hook() to catch inconsistent
  FWU metadata (boot GUID found but root GUID missing or viceversa), as
  suggested by Simon Glass.

Changes in v2:
- Add links to the XBOOTLDR specification in the commit message of patch
   1/7 lib: uuid: add partition type GUID for extended bootloader.
- Update help for 'part start', 'part size' to mention UUID.
- Add kerneldoc comment for fwu_mdata_get_image_guid().
- Pass efi_guid_t by pointer in fwu_mdata_get_image_guid().
- Add patches:
   5/7 test: cmd: part: add UUID lookup tests
   3/7 test: cmd: add unit tests for part command
   2/7 test: dm: part: add test for part_get_info_by_uuid

Dario Binacchi (8):
  lib: uuid: add partition type GUID for extended bootloader
  test: dm: part: add test for part_get_info_by_uuid
  test: cmd: add unit tests for part command
  cmd: part: support lookup by UUID
  test: cmd: part: add UUID lookup tests
  fwu: add helper to get image GUID by type and bank index
  test: dm: fwu_mdata: add test for fwu_mdata_get_image_guid
  board: st: stm32mp25: support dynamic A/B bank bootup

 board/st/stm32mp2/stm32mp2.c          |  32 ++++
 cmd/part.c                            |  12 +-
 doc/README.gpt                        |   2 +
 doc/usage/cmd/part.rst                |   6 +-
 include/configs/stm32mp25_st_common.h |  15 ++
 include/fwu.h                         |  11 ++
 include/part_efi.h                    |   3 +
 lib/fwu_updates/fwu.c                 |  33 ++++
 lib/uuid.c                            |   1 +
 test/cmd/Makefile                     |   1 +
 test/cmd/part.c                       | 227 ++++++++++++++++++++++++++
 test/dm/fwu_mdata.c                   |  48 ++++++
 test/dm/part.c                        |  53 ++++++
 13 files changed, 437 insertions(+), 7 deletions(-)
 create mode 100644 test/cmd/part.c

-- 
2.43.0

base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
branch: fwupdate-ab
