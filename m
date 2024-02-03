Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0826C4828D
	for <u-boot@archiver.kernel.org>; Sat,  3 Feb 2024 16:37:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F9EB876F8;
	Sat,  3 Feb 2024 17:37:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f2pcqk7e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ECBD87969; Sat,  3 Feb 2024 17:37:27 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4994E876F8
 for <u-boot@lists.denx.de>; Sat,  3 Feb 2024 17:37:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6818a9fe3d4so16424086d6.0
 for <u-boot@lists.denx.de>; Sat, 03 Feb 2024 08:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706978243; x=1707583043; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s0QUr+vGJT2OVwuGAvGseMwf7F+ou1rQWq+Jocu4wok=;
 b=f2pcqk7eC2pfB1bW9kNYj32SMQ0YFqggAzfNmv0plSddCltBtPq8YZaSZFbHXajHuv
 EFBVqNYTiK41+N/TcBMCZKaLRKpIpFd0w18piEy9lltcEiM9lBVgeJ6MfsJiXkTMAfH8
 2HQlEfIHUMSzPOSoUkbw99DfiIeLUZ04kbXDDNiOCumuR3/VMQKRvlWm9MKJDLeSX7rD
 dEizohCwfxmC465qtWSW78wtDwBTrscJjcEOd0OipF5eArr4AGTS0OyqWgzeeggLiY5a
 LfKrxeZg71thIWyl3Q77b5lZupMf+pKamUR0hqimfyPCIZe8MacYRfUkcbJvhiS7Ey10
 cmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706978243; x=1707583043;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s0QUr+vGJT2OVwuGAvGseMwf7F+ou1rQWq+Jocu4wok=;
 b=Ir4mcrpTdtE3Kfjtv+QeT9cGBgRJflmL60Gdx8CBQbFdHGK29yESf1KFMG7GodvtWV
 MoRIVcS9Y8unpJ1ahaUdfRipSfqhbN43FauF8FjFul8G9TVnN+zjRFUuOwdQF5OvbxIy
 FhbAt8ufKB5nVJHHyV7L5wJKE5o4SBRSbhjR+QWlFOlyPZLA8bNFSzZ2z4wlRygLq6Mq
 WFq7UOuTNwCj3wWtkpcWcuKTYjH/aFY+WBoDdddRgUBrbqlpY8GJ9HZrRjaOlpjPWMlj
 3aJlGrVnfb8myyOLqZzt7Iieiefj9FKcD3x/PJNJSOc6n47s4ubSCXA4hnLbgSXRPXZl
 ZgWQ==
X-Gm-Message-State: AOJu0YwH34dKQi8zOuB9UyytBtNHVpah7hw9EbaEIBvywmbNWRv9bYp9
 w4q+YeRJ2u7xmnCj323/dD+w2VdgXCPEyH0EGVWoU1Lm1kLpa9KbS0X/887FacqLDVQIC2Y3uOT
 t
X-Google-Smtp-Source: AGHT+IHS0DQ/TJyd0C0NnapTrDcHmn345JBem1V/7JYy7xjKg9SZD2aZB1h+RFO93IPP4VqD1ZzJIQ==
X-Received: by 2002:a05:6214:62e:b0:68c:7fed:d1ca with SMTP id
 a14-20020a056214062e00b0068c7fedd1camr1535968qvx.0.1706978243623; 
 Sat, 03 Feb 2024 08:37:23 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVvIA3wf7LH6b85actDNwnRfexBHRDGABOi9Ie1pa7Mom+1Ws3UkvCqxiDHSCG8WLidC05Vo2/K8Mttww6g5DoBzXmRQC/sfwGuKQI8TlEYGGlJZLmXMbb5MJuw37uOA2aQFDsobsSu359AmtAQ3BuCRJAjuKrE+NS4wcJAiCC7nZU9b8ExeYiJvjlGsFJPnDi6ThK3WrQrQMnZ1bar6EIOyU0BT01Mgd0RQMX16CuziL4lXr2NHjFk4+12JN2WLKYYRVk7LWTEeK9q1qUsZ7FH96xcGYO7RjsW9J3TtH6poIladiCZZq8H1G7pqFwINkrfojKIQLQkBM+yRcJuGhowhM24kzwrbn8MFgW6vIzMhmWM3AZPU22CQA7ZnUGu
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 oj16-20020a056214441000b006869d54c818sm1909086qvb.109.2024.02.03.08.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Feb 2024 08:37:23 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nikhil M Jain <n-jain1@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>, Michal Simek <michal.simek@amd.com>,
 Stefan Roese <sr@denx.de>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH v8 0/8] Handoff bloblist from previous boot stage
Date: Sat,  3 Feb 2024 08:36:19 -0800
Message-Id: <20240203163631.177508-1-raymond.mao@linaro.org>
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
V8:
Refine asm code.

Raymond Mao (8):
  bloblist: add API to check the register conventions
  bloblist: check bloblist with specified buffer size
  bloblist: refactor of bloblist_reloc()
  arm: armv7: save boot arguments
  arm: armv8: save boot arguments
  arm: Get bloblist from boot arguments
  bloblist: Load the bloblist from the previous loader
  dts: OF_HAS_PRIOR_STAGE should depend on !BLOBLIST

 arch/arm/cpu/armv7/start.S | 29 +++++++++++++
 arch/arm/cpu/armv8/start.S | 23 +++++++++++
 arch/arm/lib/Makefile      |  2 +
 arch/arm/lib/xferlist.c    | 25 +++++++++++
 arch/arm/lib/xferlist.h    | 19 +++++++++
 common/bloblist.c          | 85 ++++++++++++++++++++++++++++----------
 common/board_f.c           |  9 ++--
 dts/Kconfig                |  1 +
 include/bloblist.h         | 47 +++++++++++++++++----
 test/bloblist.c            |  8 ++--
 10 files changed, 208 insertions(+), 40 deletions(-)
 create mode 100644 arch/arm/lib/xferlist.c
 create mode 100644 arch/arm/lib/xferlist.h

-- 
2.25.1

