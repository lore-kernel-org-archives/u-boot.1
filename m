Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8F8C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:31:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A0AF87717;
	Mon,  4 Dec 2023 01:30:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V5pdvBcB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EABB87717; Mon,  4 Dec 2023 01:30:00 +0100 (CET)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39D9687655
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:29:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6ce49d9d874so588349b3a.2
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649796; x=1702254596; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AtwmYbrLGrEt2B/WHdaN8bpZRCxePCxwGEDrnT5AUqc=;
 b=V5pdvBcBSMlo6KTNtvaKZHxCXxcwz995BmwAwKn8SusHjM8a5bGgc+Wb29qx0nOFeG
 HkJumBaR4iwS+rex5RefIKBr3djOe7wEDIQ1VCjFpaHNNErRSkjbchAgzLMoL+xhH420
 nyzPp5UGtRSqBn5BOUg3Nz5EbRJ4fYbKBq0so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649796; x=1702254596;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AtwmYbrLGrEt2B/WHdaN8bpZRCxePCxwGEDrnT5AUqc=;
 b=B0VnHS5/AIUW2Izu7LkFg+HEnh7MUR/x24d+smu3/7DBP1PTfGOwiysdyxgyvZilLp
 am0zi43CoRBt1jZPkH4ohur6NUX3fRN/l3RUxkRN9fM6XnTYRM779OGmoCrw3UC/xdts
 tdGjn6jr6nyKnhfWMcCDb16lYm3nmUG8a4qAkQaegHY3eMHs37l48hsitwwZFtm80VFG
 6THck01aZ5ZMVDHS6+ie3hTh5wuNDO8HS2rkbt0tVMJY5AnGwvpjx9d7N3wXljhHlbT4
 5bKo4WMs8wQuSN411z/oMBOz5B3oiGIPSI1RdqtO+riiuhP4tWnBCY+uFJYikHDtY7u8
 aNnQ==
X-Gm-Message-State: AOJu0YzrXswCU+40+DTJsTPFJp9/ExaDAjWzxOUc2xcEatuc6I6pnPpa
 hFwutObWsLswU/sm/C5uZpZKwr6ywyTA+qHNMD0IHg==
X-Google-Smtp-Source: AGHT+IGE9J/ZrCUf8DpC7Ker19p1TueTiCP3Qw8kQdulyEk6jtG1ehQ4OSwe0B2ujTSGF0qTr28/hA==
X-Received: by 2002:a05:6a20:429a:b0:18f:97c:9760 with SMTP id
 o26-20020a056a20429a00b0018f097c9760mr4764119pzj.72.1701649796073; 
 Sun, 03 Dec 2023 16:29:56 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 o24-20020a056a001b5800b006ce3a0b4bfasm2346433pfv.24.2023.12.03.16.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:29:55 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Bin Meng <bmeng.cn@gmail.com>,
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rick Chen <rick@andestech.com>, Roger Knecht <rknecht@pm.me>,
 Sean Edmond <seanedmond@microsoft.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, Zong Li <zong.li@sifive.com>
Subject: [PATCH 00/13] Complete decoupling of zboot logic from commands
Date: Sun,  3 Dec 2023 17:29:25 -0700
Message-ID: <20231204002944.897949-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
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

This series refactors the zboot code to allow it to be used with
CONFIG_COMMAND disabled.

A new zboot_run() function is used to boot a zimage.

This is cmde (part e of CMDLINE refactoring)
It depends on dm/cmdd-working
which depends on dm/bootstda-working
which depends on dm/cmdc-working


Simon Glass (13):
  x86: zboot: Move zimage definitions to the header file
  x86: zboot: Move command code into its own file
  x86: zboot: Create a separate ZBOOT option for zboot logic
  x86: zboot: Avoid iteration in do_zboot_states()
  x86: zboot: Create separate functions for the logic
  x86: zboot: Move environment setting into zboot_load()
  x86: zboot: Drop intermediate zboot_setup() function
  x86: zboot: Drop intermediate zboot_go() function
  x86: zboot: Move argument processing outside zboot_start()
  x86: zboot: Rename zboot_start() to zboot_run()
  x86: zboot: Separate logic functions from commands
  x86: zboot: Use zboot_start() in zboot_run()
  x86: zboot: Tidy up the comment for zboot_run()

 arch/Kconfig                  |   1 -
 arch/x86/Kconfig              |   8 +
 arch/x86/include/asm/zimage.h |  97 ++++++++++++
 arch/x86/lib/Makefile         |   2 +-
 arch/x86/lib/zimage.c         | 267 ++++------------------------------
 boot/bootmeth_cros.c          |   6 +-
 cmd/Kconfig                   |   2 +
 cmd/x86/Makefile              |   1 +
 cmd/x86/zboot.c               | 182 +++++++++++++++++++++++
 include/bootm.h               |  15 +-
 10 files changed, 333 insertions(+), 248 deletions(-)
 create mode 100644 cmd/x86/zboot.c

-- 
2.43.0.rc2.451.g8631bc7472-goog

