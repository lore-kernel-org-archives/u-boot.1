Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB39C47DAF
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 15:10:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13E5687C05;
	Fri, 19 Jan 2024 16:10:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lFBmiwzn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2512087CD9; Fri, 19 Jan 2024 16:10:23 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0598E87CC1
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 16:10:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7831e87ba13so64477585a.0
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 07:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705677019; x=1706281819; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8rrlaTPzy8RU3E3DjNdHfhP1f+HTNQanDLjSpiC9MQA=;
 b=lFBmiwzn1jnoYMnOD2j+qOPkzh+qAXMOsdLH5ZLnXwmUPj3wQLNtNJoW5T/aI41j+K
 5HdFFFIPE0Ww7MRzbWogmMWxAW0NYZKpr4P/BIjdqsatwmMJglaqtdHEhBs0QYRlYQ/e
 /kFHfw292fzh2cBGrCCWp6xnobNkxpIebVWSWRtzUnL8T+wE9NkfxmMdSK5Fj+9pg0qN
 MqABaxyaVe7sgWMUWd8dn4Z5h3ttOusq21hIyf3ErXH06mb9F/5cwYnht5mNRr4IV2z3
 VqH/8z3pnzsLSYVqT2XcaVmFyd+F/r3t4fNOwRXAOB01YfyPhHYMP/HhO6K+y+ytNl7G
 xOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705677019; x=1706281819;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8rrlaTPzy8RU3E3DjNdHfhP1f+HTNQanDLjSpiC9MQA=;
 b=uIa2VgUJAHDLye+6sMOCs2L2hQaygkmjmL9TXZ2pt+2gAdaB3/IGaJV1eDJaNe2H4J
 AoBWsfaTT6sr77+Vzly1S+rXO3yt+KeJehr1Xwo67ACZO8VY7NCXTFEJ/08HT0VU0xvD
 tL7Kb0/by7F3NKSPaJjIoXkpfcpITdq5fP/D5QkFNTM3PVRHMskasHtj4chrrDpUOoCu
 A55LivfQv/mJ+VbBb6aKiOVff1kx+Loj1QxvpAEkP4HcbgXqO2r1zEmVaHy7PdZNQffK
 5LFzBOjtGn22Zq3dwy45OJboluBc7AbHq1BDjvqNPbHx+9rQ2AyLK8w3EZXXXdwlOxgT
 I/Fw==
X-Gm-Message-State: AOJu0Yzf/4YlxVh6cNE96G2lIIIBoLM1VkR1Z/Ip36eUMXnWuP04htdt
 12xwsigsLYxgnnGCb9JtAYSZCkxWYQtfzzZKgvXNvszbOL1bTBUReQ73JtKFCRtqNE45qNxW7FV
 4
X-Google-Smtp-Source: AGHT+IFMx0a1Z8UFHS1Z5LJYUAnkTnWvlG6jEcB8saFnLavdojE9LM1POiJlMnzVPdDiT0lfSqTKQA==
X-Received: by 2002:a05:620a:2104:b0:781:7091:b641 with SMTP id
 l4-20020a05620a210400b007817091b641mr2704qkl.121.1705677019442; 
 Fri, 19 Jan 2024 07:10:19 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 i8-20020a37c208000000b0078322dc4f97sm6142113qkm.26.2024.01.19.07.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 07:10:18 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>, Nikhil M Jain <n-jain1@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Shiji Yang <yangshiji66@outlook.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH v7 0/7] Handoff bloblist from previous boot stage
Date: Fri, 19 Jan 2024 07:09:56 -0800
Message-Id: <20240119151007.715348-1-raymond.mao@linaro.org>
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

This patch set adds/adapts a few bloblist APIs and implements Arm arch
custom function to retrieve the bloblist (aka. Transfer List) from
previous loader via boot arguments when BLOBLIST option is enabled and
all boot arguments are compliant to the register conventions defined
in the Firmware Handoff spec v0.9.

If an arch wishes to have different behaviors for loading bloblist
from the previous boot stage, it is required to implement the custom
function xferlist_from_boot_arg().

V5:
Drop [PATCH v4 8/9] fdt: update the document and Kconfig description.
V6:
Drop [PATCH v5 8/8] fdt: get FDT from bloblist.
V7:
Fixed CI pipeline failures.

Raymond Mao (8):
  bloblist: add API to check the register conventions
  bloblist: check bloblist with specified buffer size
  bloblist: refactor of bloblist_reloc()
  arm: armv7: save boot arguments
  arm: armv8: save boot arguments
  arm: Get bloblist from boot arguments
  bloblist: Load the bloblist from the previous loader
  dts: OF_HAS_PRIOR_STAGE should depend on !BLOBLIST

 arch/arm/cpu/armv7/start.S | 21 ++++++++++
 arch/arm/cpu/armv8/start.S | 16 +++++++
 arch/arm/lib/Makefile      |  2 +
 arch/arm/lib/xferlist.c    | 27 ++++++++++++
 arch/arm/lib/xferlist.h    | 19 +++++++++
 common/bloblist.c          | 85 ++++++++++++++++++++++++++++----------
 common/board_f.c           |  9 ++--
 dts/Kconfig                |  1 +
 include/bloblist.h         | 47 +++++++++++++++++----
 test/bloblist.c            |  8 ++--
 10 files changed, 195 insertions(+), 40 deletions(-)
 create mode 100644 arch/arm/lib/xferlist.c
 create mode 100644 arch/arm/lib/xferlist.h

-- 
2.25.1

