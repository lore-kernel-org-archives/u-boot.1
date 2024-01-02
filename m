Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD52C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 22:12:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 950A887787;
	Tue,  2 Jan 2024 23:12:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QQCzapEW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCBDC878F9; Tue,  2 Jan 2024 23:12:52 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D10198756F
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 23:12:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-42836ebe0a8so112871cf.1
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 14:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704233569; x=1704838369; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V8pCsbXJXFYlRuk9ZiJ48ay2k0aEzORT6/EvreOqUyg=;
 b=QQCzapEWvyA00AZwfgUfBLH53xdBFKLd+jriadfO2Cxh53g7O/z1NOAmBFpEcpjHPo
 +AiIysXVMnarxR0NnJCZKUonBn1wB7kIut5fZ9CxQgl5ics9kYF2dMoFSOC+iNt1fTqP
 PvOlmcENwHx7kXfniI6p9qqLcXB3lIadBt7aOAJn4oua4osQOdf14yR2s5/fmIx4J5Hs
 17xPChuwDXXYwkywbrPcUM4QZW/hYjOQ3EcpR5M/+zQpfOD4LDguSjxFNr7kYCOW5wzv
 nMSTAfdObliw0tNXmBcqt/dEODybC8PPYt9nL7pGweNAmk1Q24esepFzuZxqhq8jh0h4
 0OeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704233569; x=1704838369;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V8pCsbXJXFYlRuk9ZiJ48ay2k0aEzORT6/EvreOqUyg=;
 b=TRfftChZc8W1M9Jloh8d0Nj6lay8XQob8Ov6fbaMsv6ZOgpiDCpTBk4kjFAd1B+Cm2
 VdqQDMCliWbQfd8OdeMWSgThV8GP/KkKNCYFIhApbDriLdNOzjIsUbnIf34Ql9eCG09q
 v47XDbiRkvr+gOxbEqIYFW5TGQKWlbGhGnSKfYyo8xo10bSPKr+2w/DxfktRGYl2pQ0c
 B0GNXQ6i9vUGT9DaaJ7huO5Fm5KFLZsSRSEk/HTtgEDMSS8fvmLQ3mDWkgSCrclJ9x1N
 PKWzJlr3lDzNaJobuAPi/ebNyHwuQT8syeyCL/7/Uwi+XDSp3U7n2LKYwSvC5gG5R0jQ
 SikQ==
X-Gm-Message-State: AOJu0YzD/tSlZUDc6HPPC3VkLuF/c3m87s2JN2EDGoFBzb9/5fBtGAg4
 Pl54TgJGGUy9MumCByw+fN7w5M7E4YYC1R7bGRHcEiSxoWU=
X-Google-Smtp-Source: AGHT+IHfMmDKOt4xdC6ofO+ymuQDvPmp1Le8ONydRO1UxWlwf22KL5yjG/1gtBr6CpiyCIwW/QpoHQ==
X-Received: by 2002:a05:6214:23cc:b0:680:b917:feb2 with SMTP id
 hr12-20020a05621423cc00b00680b917feb2mr3752028qvb.44.1704233569235; 
 Tue, 02 Jan 2024 14:12:49 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 mg14-20020a056214560e00b0067f70cc986asm10431487qvb.92.2024.01.02.14.12.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jan 2024 14:12:48 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>, Nikhil M Jain <n-jain1@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Shiji Yang <yangshiji66@outlook.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Baruch Siach <baruch@tkos.co.il>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v4 0/9] Handoff bloblist from previous boot stage
Date: Tue,  2 Jan 2024 14:12:25 -0800
Message-Id: <20240102221237.1007090-1-raymond.mao@linaro.org>
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
"[PATCH v5 00/11] Support Firmware Handoff spec via bloblist".

This patch set adds/adapts a few bloblist APIs and implements Arm arch
custom function to retrieve the bloblist (aka. Transfer List) from
previous loader via boot arguments when OF_BOARD option is enabled and
all boot arguments are compliant to the register conventions defined
in the Firmware Handoff spec v0.9.

FDT library function will load the FDT from the bloblist if it exists.
Otherwise it fallbacks to get the FDT from the board custom function.

If an arch wishes to have different behaviors for loading bloblist
from the previous boot stage, it is required to implement the custom
function xferlist_from_boot_arg().

Raymond Mao (9):
  bloblist: add API to check the register conventions
  bloblist: check bloblist with specified buffer size
  bloblist: refactor of bloblist_reloc()
  arm: armv7: save boot arguments
  arm: armv8: save boot arguments
  arm: Get bloblist from boot arguments
  bloblist: Load the bloblist from the previous loader
  fdt: update the document and Kconfig description
  fdt: get FDT from bloblist

 arch/arm/cpu/armv7/start.S         | 19 ++++++
 arch/arm/cpu/armv8/start.S         | 14 +++++
 arch/arm/lib/Makefile              |  4 ++
 arch/arm/lib/xferlist.c            | 38 ++++++++++++
 common/bloblist.c                  | 92 +++++++++++++++++++++++-------
 common/board_f.c                   |  9 +--
 configs/qemu_arm64_defconfig       |  3 +
 doc/develop/devicetree/control.rst |  6 +-
 dts/Kconfig                        |  7 ++-
 include/bloblist.h                 | 47 ++++++++++++---
 lib/fdtdec.c                       |  9 ++-
 test/bloblist.c                    |  8 +--
 12 files changed, 210 insertions(+), 46 deletions(-)
 create mode 100644 arch/arm/lib/xferlist.c

-- 
2.25.1

