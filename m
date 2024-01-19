Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51AFC4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 15:28:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0FAD87BA2;
	Fri, 19 Jan 2024 16:28:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JxTLZij6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7742587BB5; Fri, 19 Jan 2024 16:28:01 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F80987645
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 16:27:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-783195e57c7so53477785a.2
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 07:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705678078; x=1706282878; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8rrlaTPzy8RU3E3DjNdHfhP1f+HTNQanDLjSpiC9MQA=;
 b=JxTLZij6fO03PzxuHeQjuT9upQnyZO0MGKzbxQI9X0LRoTBix740tWdUSas+bBtWIX
 vSauxr58UAByw+nG6ajdxn4qEg3LL4HsHnpCHEyhQyXQRmC9udn4KBzZ9uuQouv5cRPi
 AgzkUPXyaDEjHc+Ob3koH3/NoTWoA1wlnfx73UfzEsAi7Zj0qzjz+RkWj8H2dxuc3wOE
 gS1lWdjOe/f5GmvR7ggrJPuW+3smlt70fQLUK+nVP2WL8XITbkPbjkVIJaIaVKpg/gyA
 PIhwYFGJretgOSvrSSzB5w4LfpyNx1MtUe+smFK06iizm+gGGY0vrdUG2M3vGu3uDyRB
 Co8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705678078; x=1706282878;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8rrlaTPzy8RU3E3DjNdHfhP1f+HTNQanDLjSpiC9MQA=;
 b=QXNSmFaj3u0DVJaU6uf1fe5q6AzbtC9TMktcyVeP/MPcGtRyCufqkyLN9wCpQDXF2Z
 Yjie1lrzHqgej2IlSF7yK3ga5Bvh7b6q80JwwURpDa9ajc7ZA/GIlOMo1Xack/+2EoH6
 fUoBCPXsWg8jR48Ro/Usfv3cm0tQU7P9fj803fmpIQgI5uzQ/XvWsuy08PtKVR368BxR
 PNlVn7rXlZlfq/jxjwsquf0rr5CQy0NWZQ+F5ksKtoUWxP2msTFjtXiQ5uf69y9b3nMq
 WgruOwkDOyZ/x4fwotU2AJ9WACDFeGQmaMygxjQEr7fFtOZrDMbltKcbJZJZaZWRP6Ef
 kYTg==
X-Gm-Message-State: AOJu0Yy9V5JAtcRmMR+YJ2WqbsI3Pvbzqy1nvPmbM4OFqOvzLtKNUnvS
 ySjZC7jmV9efGVCD/5b1/aM3Njg4k1lrEdPb1RSMxriFCj5JTRukKxGcZi6HM0PKp/vXhnD+XS9
 a
X-Google-Smtp-Source: AGHT+IEzs0JLSHVAt7Dl/7HIds4+ayETazvzP7DQxG6Fsq3r+LkrB0oam/RIzZ+hUxFF79duO2l1bg==
X-Received: by 2002:a05:620a:1982:b0:783:4e8d:2236 with SMTP id
 bm2-20020a05620a198200b007834e8d2236mr49994qkb.64.1705678077978; 
 Fri, 19 Jan 2024 07:27:57 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 f14-20020a37ad0e000000b00781b8f4c89asm6112726qkm.43.2024.01.19.07.27.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 07:27:57 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>, Nikhil M Jain <n-jain1@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH v7 RESEND 0/8] Handoff bloblist from previous boot stage
Date: Fri, 19 Jan 2024 07:26:54 -0800
Message-Id: <20240119152656.715845-1-raymond.mao@linaro.org>
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

