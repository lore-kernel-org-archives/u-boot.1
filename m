Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2A6C46CD2
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 21:31:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 120E6876FC;
	Fri, 22 Dec 2023 22:31:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zAUajI/H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BC498770F; Fri, 22 Dec 2023 22:31:36 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47A4E8753D
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 22:31:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-67f95d69115so6455226d6.1
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703280693; x=1703885493; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=N5DG/lxKK79rem4jXsYoQ3gOZr+AG9ssgrmIr9/tyXA=;
 b=zAUajI/HVcNVP9w8o2NRiIAWW5jRuQ3+bJPW0BB40mDYuZfaLEAnxRyQnZOyL6ECIk
 JNGjYSfTENzawAqyZylFROGnKhUzmQ98IrGt/dQc9RoKWVyBJK23IbDqgmFprWwPo2ih
 bq+2JBsvCLF4D5JyraQq809sdeUMHI39OSYq7XB7wjqJNDn8lDfxY9N4hjrUAk1WuYCx
 yxmDon/lxB6pt9f0V8vM+YYd4HoHnaDhBTFMddxbNd4N/PXfRU0fJxKy3UM0Ky5INHux
 43mSbJ07p7rfqOkQGtkfS4QXt0eE4PqbRr+3kKFSWWsVL38Icl728zC5cFqORflz98WB
 yIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703280693; x=1703885493;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N5DG/lxKK79rem4jXsYoQ3gOZr+AG9ssgrmIr9/tyXA=;
 b=BUAmiTibHG+5jRlovCyGFAF7qeVWqOy2upfFZ32keQurujWi1JZpmISk7rdIKwQvwA
 wwKDwmLY56xArdYqB4FrqfMKuar7VS0MEwYIG8dTmY0hxbW7vl93qVaIg+SDMDSzaXNY
 sw2VM1Om+ZxLfIoDGRXk2waOfjtDRgDPgrzvY8zCfeTFbK2Bg3MwHoDWYuBuflC/xPAq
 3sS4wd0/amLhf5Or3XEJ9l0oZyb2LkY6TyQv/cpD8vn/veXjL2UIEaIpVH+TGoCvwE0C
 35pJEjavstFD8BZIXwS3bQobYUiFAl5TdiYvaYu/Clu+S1/GIPb+QEQSmQYEf0v3aNDl
 bqqg==
X-Gm-Message-State: AOJu0Yxgw1Zc5DhJSRLnD9iG0ZWMoRakMEhzkdNzUPAoK1VKo/4g7scK
 RjEfCsviGyED7GUw/KTzoVVE3ede+8WLLqlIktRT5LWTcac=
X-Google-Smtp-Source: AGHT+IH3WCRNkrBJ088duL4D28yRBsogxUOq1nq3axScwmnKzD96BIoLXzyhuDZCncgaRjehqQQ1VQ==
X-Received: by 2002:a05:6214:226b:b0:67a:e40d:316d with SMTP id
 gs11-20020a056214226b00b0067ae40d316dmr3819412qvb.101.1703280692910; 
 Fri, 22 Dec 2023 13:31:32 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 dm6-20020ad44e26000000b0067f6ec98ae9sm1623096qvb.32.2023.12.22.13.31.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 13:31:32 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, Nikhil M Jain <n-jain1@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@seco.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>, Baruch Siach <baruch@tkos.co.il>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH v3 0/9] Handoff bloblist from previous boot stage
Date: Fri, 22 Dec 2023 13:31:00 -0800
Message-Id: <20231222213110.660402-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
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

This patch set depends on another series:
"[PATCH v3 00/14] Support Firmware Handoff spec via bloblist".

This patch set implements Qemu-Arm platform custom functions to retrieve
the bloblist (aka. Transfer List) from previous loader via boot arguments
when CONFIG_OF_BOARD option is enabled and all boot arguments are compliant
to the register conventions defined in the Firmware Handoff spec v0.9.

Qemu-Arm platform custom function will load the FDT from the bloblist if it
exists.
Otherwise it fallbacks to get the FDT from the specified memory address.

If a platform vendor wish to have different behaviors for loading bloblist
or FDT from the previous boot stage, it is required to implement the custom
functions board_bloblist_from_boot_arg() and board_fdt_blob_setup().

Raymond Mao (9):
  bloblist: add API to check the register conventions
  bloblist: check bloblist with specified buffer size
  bloblist: refactor of bloblist_reloc()
  arm: armv7: save boot arguments
  arm: armv8: save boot arguments
  qemu-arm: Get bloblist from boot arguments
  bloblist: Load the bloblist from the previous loader
  fdt: update the document and Kconfig description
  qemu-arm: get FDT from bloblist

 arch/arm/cpu/armv7/start.S          | 13 ++++++
 arch/arm/cpu/armv8/start.S          | 14 ++++++
 board/emulation/qemu-arm/qemu-arm.c | 42 ++++++++++++++++-
 common/bloblist.c                   | 72 ++++++++++++++++++++---------
 common/board_f.c                    |  8 +---
 configs/qemu_arm64_defconfig        |  3 ++
 doc/develop/devicetree/control.rst  |  6 +--
 dts/Kconfig                         |  7 ++-
 include/bloblist.h                  | 36 +++++++++++++--
 test/bloblist.c                     |  8 ++--
 10 files changed, 166 insertions(+), 43 deletions(-)

-- 
2.25.1

