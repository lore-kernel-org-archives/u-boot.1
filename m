Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2138C47DDB
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 17:53:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BF9887C13;
	Mon, 29 Jan 2024 18:53:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=edgeble-ai.20230601.gappssmtp.com header.i=@edgeble-ai.20230601.gappssmtp.com header.b="KjKbiptp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A106487C13; Mon, 29 Jan 2024 18:53:36 +0100 (CET)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1132B87BDF
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 18:53:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jagan@edgeble.ai
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6de2e24ea87so660399b3a.3
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 09:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=edgeble-ai.20230601.gappssmtp.com; s=20230601; t=1706550812; x=1707155612;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xl+KgigAI7mivVPuZIZxxwpi2VZD9et+jJ1bBxDREAc=;
 b=KjKbiptpTmzfcgkytWEs/P0HM0twcIqRdq9HwM5R8Z8ohCeGhg5tNCdKYg/Ut0/buM
 d5k8Mg1HIGrcOCTNHDmyF0d3rAWr2QpWj/BTB757KR9h3dmp0pQeUiv/MxM2PL5Wlijt
 /ejSi/DkfKFyLW/iSGEr5QDF2nKGjfcbRc4ANFcwhYB251wVgF8KKzvuzdbPgMW9X7H6
 dIi6c+VPUHy4ZfHqDRa7SXEl7sVKUYN9akVNculoOlAEb35NI5tBA8LeuP86LAkbGcKU
 qHrCfX/YIrMKDBVqSIqDYtAnXQj9nZcvB2zY/3LGy+ZQ/aY6myEbAexLcWR3Q3RPs/f9
 pS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706550812; x=1707155612;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xl+KgigAI7mivVPuZIZxxwpi2VZD9et+jJ1bBxDREAc=;
 b=i3QnMW+MYSAV+bJuqCgkBH/Aw4najekCOs/buH8benv9oLeq99CjGrXgcHhjLHKSfw
 qJt5U3YyVda+VUC+B8bO2EBHGYgrStnowKZz3biJGx4mGWnX4VPN2FxT9EqPYV5vim7p
 jGkhXFtMnzvNv9Dp9oQRsQl+mH+h4l3M3oHrvLhKqMByt4n6PEBBrijv9QoqprOS/YNa
 dJZdOFVNAgHInvz0/ZJOgr5R+aY7RVPs0X87NbRDTDH1ebcte1O7tXJRFC5cC3/Nxstp
 hWv3/4rf+iXqBL0VuaFWeF7HbxMcr5ikppdVXkYemxdhUA081DVra8RkYDQsSfvRGBvN
 9KbQ==
X-Gm-Message-State: AOJu0YyJ0JX7RH809u5aX/aMBFXyL3IqSINoYaxPp4N5C4+X6fyJPD+V
 dByww8/gaklpON40X7PEiSyICi94T7GYgbYijeWhUnxSg9qrwu2N8PLhFbyLIlY=
X-Google-Smtp-Source: AGHT+IGij3ga+u8sM5OogthBZfYDX8tNgRgGdDu1k6CfCTwTzmN2oUEjPDTpgJfM8aduS5KErQ5tFQ==
X-Received: by 2002:a05:6a00:1805:b0:6db:cf34:8a96 with SMTP id
 y5-20020a056a00180500b006dbcf348a96mr5511128pfa.26.1706550812302; 
 Mon, 29 Jan 2024 09:53:32 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c00a:a208:826d:69af:676d:87bf])
 by smtp.gmail.com with ESMTPSA id
 o123-20020a62cd81000000b006ddc133f1d3sm6419041pfg.194.2024.01.29.09.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 09:53:30 -0800 (PST)
From: Jagan Teki <jagan@edgeble.ai>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Pull request: u-boot-spi/master
Date: Mon, 29 Jan 2024 23:23:25 +0530
Message-ID: <20240129175325.5175-1-jagan@edgeble.ai>
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

Hi Tom,

Please pull this PR.

Summary:
- Support Infineon S28HS02GT (Takahiro)

CI:
- https://source.denx.de/u-boot/custodians/u-boot-spi/-/pipelines/19467

thanks,
Jagan. 

The following changes since commit 526a865fe4fea59fb2638726c26e39557eb97fdd:

  Merge branch 'master-cleanup' of https://source.denx.de/u-boot/custodians/u-boot-sh (2024-01-27 20:43:20 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-spi master

for you to fetch changes up to 16dd10951015183f87b8202b8d4c8617da4f6d44:

  mtd: spi-nor-ids: Add Infineon(Cypress) s28hs02gt ID (2024-01-29 19:34:17 +0530)

----------------------------------------------------------------
Maksim Kiselev (1):
      spi: dw: add check for Rx FIFO overflow

Ssunk (1):
      mtd: spi: spi-nor-ids: Add more XM25Q series chips

Takahiro Kuwano (9):
      mtd: spi-nor-core: Clean up macros for Infineon(Cypress) S25 and S28
      mtd: spi-nor-core: Consolidate non-uniform erase helpers for S25 and S28
      mtd: spi-nor-core: Rework spansion_read_any_reg() to support Octal DTR mode
      mtd: spi-nor-core: Use CLPEF(0x82) as alternative to CLSR(0x30) for S25 and S28
      mtd: spi-nor-core: Rework s25_mdp_ready() to support Octal DTR mode
      mtd: spi-nor-core: Consolidate setup() hook for Infineon(Cypress) S25 and S28
      mtd: spi-nor-core: Consolidate post_bfpt_fixup() for Infineon(Cypress) S25 and S28
      mtd: spi-nor-core: Rework spi_nor_cypress_octal_dtr_enable()
      mtd: spi-nor-ids: Add Infineon(Cypress) s28hs02gt ID

Tejas Bhumkar (2):
      mtd: spi-nor-ids: Add is25lx512 chip
      spi: cadence_qspi: Address the comparison failure for 0-8 bytes of data

 drivers/mtd/spi/spi-nor-core.c    | 224 +++++++++++++++-----------------------
 drivers/mtd/spi/spi-nor-ids.c     |   7 ++
 drivers/spi/cadence_ospi_versal.c |   3 -
 drivers/spi/cadence_qspi.h        |   4 +
 drivers/spi/cadence_qspi_apb.c    |   3 +
 drivers/spi/designware_spi.c      |  18 ++-
 include/linux/mtd/spi-nor.h       |  14 +--
 7 files changed, 119 insertions(+), 154 deletions(-)
