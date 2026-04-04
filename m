Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABF5D73094
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 15:27:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C8CB84020;
	Sat,  4 Apr 2026 17:26:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YZ5hy6Vc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 176B6807C0; Sat,  4 Apr 2026 17:26:57 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87B88807C0
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 17:26:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43cfbd17589so2118373f8f.0
 for <u-boot@lists.denx.de>; Sat, 04 Apr 2026 08:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1775316413; x=1775921213;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IY0IgVlmnddhQ9ALEN+0fIKmuZ2Q12FXzs7AS6INRAw=;
 b=YZ5hy6VcJQ73eLrt2skV0CVl9zpM71AEXFLQ8sG8gz3n73GwWh1d20+K5572dPpgfq
 bXl0EONd2RBdM7ocOYu0ax9z6kFNN/p8FP64MrhC8UeWIEbAvJUALY56i5PiZltd/Zvc
 nImdVUvuqWnA59Nj8ksBHu71vCFZYUeoqsvaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775316413; x=1775921213;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IY0IgVlmnddhQ9ALEN+0fIKmuZ2Q12FXzs7AS6INRAw=;
 b=LOo2uAsylJYD0HP44ua5CPEbaAOx09Jqk/GEuuRVy4cJ0P/iYG04DOc9rSJ29Uc0AE
 pYXg9qyIfNBk9iyhhX9NeGjid+kuDHc7IVFYCQ5g4DKsDljn5AKg/HzG/mdA4Rwcv61S
 GTivCdu5oMgwsMmhvZ53wjjSdWMOoxG+iprn42PG5Fm48mAqGZ1Y2R/2quf0ucs2W1o9
 73XW/rYfWC/tBaPZ+CICeEh7Yvm/a8Z1AM893urgrqf+WNkDbdzMSqzbYwZKn8Y8Irg3
 snEVjxS25HgTdXDwaEfn6Xbm2CxEXeT6sXiHyQnBNcmstLTf01u6ClECclRUQb2lXBcs
 d1cw==
X-Gm-Message-State: AOJu0YwORjwZP8X0KPOs5xGjTl1ngAuBVGmjzawZsTwUolLt4qxqsXmT
 nxxOcIXQjaHaoGVLLo//Zvht93LGaiVTSVcSTv7fPj9YGCIcGWqW1fYZBj1yf8FekQSdUFMbyna
 fVxHi
X-Gm-Gg: AeBDieuCs1P8wtzHH/OZXS0oQXvpPgJhTGnb713p8MFW9m9JF7k4hoLMqkEN8go5zeA
 rKp9iJtWfvO2PONc+GqYZfTqIvyGKRO4TSMQWRAW1AVGxXcTK+r4vAIKYF3XMZ1WCEJ5IlK80bI
 lJsLMeV7bQ/jIXWKraCh+udTS1Fj/i2AchbOn0fTq4XTVs6Mqf5FDkAUNzEyJv08vljVOkzlGhM
 /aPcyFn9Q2/MajgOfD7s+jv3f+e3w5j9WaWhKV1jRQ5DYt1mphz3GDbgenEDYvC2NGNNYKP2NMo
 bFkpPj2CBiq94dtcOxB9Grde9WMwXfwN8bfjtHnVSGUU+ROYZqOjhuJzLZ4VJLYg1OUAjwiOqJY
 1sH2Z8/9tkkXWvEeSDvrIPQKgpz9Qw/Fj9ururkMk6kpWq5BbossLDOCrOJsP5lEawapGtcLPMX
 DH49yAU3jLdYLP2hAjpr2X8aRsm+5p8q+Lr5l2qP+0ynhv0RhnqbX8muxWiMITfEdbeu9WlUQkL
 zZXuLMN71s0mMhx2rSXHiee3f9xR0EBOc3TCPoZcN2HeupWQYGH+inImwCCxJ/gWLHLLc4vYjYb
 aEnvui7Wby+9NPwB3UmmlWdGgHkkIM8evXU=
X-Received: by 2002:a05:6000:40ca:b0:43b:8f38:3b88 with SMTP id
 ffacd0b85a97d-43d292e7101mr10522763f8f.25.1775316412511; 
 Sat, 04 Apr 2026 08:26:52 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-87-9-100-184.retail.telecomitalia.it. [87.9.100.184])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4f1a99sm28059462f8f.32.2026.04.04.08.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 08:26:51 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
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
Subject: [PATCH v2 0/7] Support metadata-driven A/B boot for STM32MP25
Date: Sat,  4 Apr 2026 17:23:27 +0200
Message-ID: <20260404152640.3297713-1-dario.binacchi@amarulasolutions.com>
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

Dario Binacchi (7):
  lib: uuid: add partition type GUID for extended bootloader
  test: dm: part: add test for part_get_info_by_uuid
  test: cmd: add unit tests for part command
  cmd: part: support lookup by UUID
  test: cmd: part: add UUID lookup tests
  fwu: add helper to get image GUID by type and bank index
  board: st: stm32mp25: support dynamic A/B bank bootup

 board/st/stm32mp2/stm32mp2.c          |  25 ++++
 cmd/part.c                            |  12 +-
 doc/README.gpt                        |   2 +
 include/configs/stm32mp25_st_common.h |  15 ++
 include/fwu.h                         |   3 +
 include/part_efi.h                    |   3 +
 lib/fwu_updates/fwu.c                 |  33 +++++
 lib/uuid.c                            |   1 +
 test/cmd/Makefile                     |   1 +
 test/cmd/part.c                       | 204 ++++++++++++++++++++++++++
 test/dm/part.c                        |  53 +++++++
 11 files changed, 348 insertions(+), 4 deletions(-)
 create mode 100644 test/cmd/part.c

-- 
2.43.0

base-commit: 4dc4080805fac1b1ed7606ce3bc8fb44a6d59d5e
branch: fwupdate-ab
