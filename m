Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C68B0C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 03:21:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72D9688C4E;
	Thu,  8 Aug 2024 05:15:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ph7uiruL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59AF988C26; Thu,  8 Aug 2024 05:15:22 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C692188C27
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 05:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-260f94067bcso301654fac.3
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 20:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723086913; x=1723691713; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lz6mHLXj+4xDB7VMFsWWY5w7o85P1WrFzOMBrWDtyfI=;
 b=ph7uiruLQdHm/XGlDbVHAfVp0ks3FIS1xWJLYZIj5LFDB1ffeHHHZePZRovodXzZro
 6qT28C+xoE4t7JP3VMpWfpZQC/FsF+JtsQC18yrHa1snWr3NGugFzkHRYfAXt/tUpKZZ
 lPab0UsdyPO5pF02vRSEaR9c05QI6YmfF238acUgYPI5LBIwDmZ40NrwolaaPe3WgGKf
 6kb3ga7yS2lqP736m/owNTk2aN2k/0H9a0iD4qte+1/gRZ30FwpGPTi0h31TznwHsuT6
 nHwO+/pJ9UCOmRLivhCFdHI7XwtKRc2weePn7kSVuXpnJ4h7a2AMoOfnb+uaMbM+noX/
 ahog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723086913; x=1723691713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lz6mHLXj+4xDB7VMFsWWY5w7o85P1WrFzOMBrWDtyfI=;
 b=qHqV642mfwEC3S9gxbC5uF3K52NuHUSMjfMqPbJiP2nvbwy7clxgItWxtJFazEDBMJ
 R9F5EQTrjbLrq3yRYPj+Yicz8g0MQZ9yeoCiM6gwbG+NfrxuDPmcPYbDM1QgHrfUNNHb
 NffwtmKRgQJwwA8hmiCUX9OCAxm/YllYhT9XmQMdEHXj0Y6zxlDGpD5+u7WvrJaN5H8O
 SJagAt8aTouR2OJn8Gu/523xLn1KP36DaQ4I6k2S0TsXnvyXhmRC8IS3Es3tnQoJzMbQ
 /Xr9poiRfkHgAuk9aZ2ih0RSbVoT/DGKHpxzieQi1KHY2X2Pd9YAOH/kRdgB8eA2rE+0
 IFsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURfRby/MQ9yI33gkTvY4KQpiCuU60VJ5N2hh4NP0k3xsGfawyzg5yjXYS1uQdJ22yFBgJvG34L7tJHf84urOUp/8yAKA==
X-Gm-Message-State: AOJu0YxTVSUwFYvWGujvTckvQpLHp0htj8PLNAOw3mVFP27aFxKvAKcX
 zQIwxxgq/d66ecBuDnwIbfbF0CFra8LC0nI9h4DVgraQYM/L4eQjAq+2Rp7VeLk=
X-Google-Smtp-Source: AGHT+IGavAx23CsJAKtZ9piRKXCoDFCFzWF5+2ZceigHwUNadvXFr0t969NAiK3gB3AGByodzlp/Bw==
X-Received: by 2002:a05:6870:d293:b0:261:16da:ded9 with SMTP id
 586e51a60fabf-2692b61a3f5mr811353fac.6.1723086913347; 
 Wed, 07 Aug 2024 20:15:13 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2689a2f2269sm4360057fac.14.2024.08.07.20.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 20:15:13 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <promsoft@gmail.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>, Henrik Grimler <henrik@grimler.se>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v5 38/38] doc: samsung: Mention enabled eMMC in E850-96 board
 doc
Date: Wed,  7 Aug 2024 22:14:44 -0500
Message-Id: <20240808031444.9619-39-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240808031444.9619-1-semen.protsenko@linaro.org>
References: <20240808031444.9619-1-semen.protsenko@linaro.org>
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

eMMC is enabled on E850-96 board now. Mention that in the board
documentation.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v5:
  - (none)

Changes in v4:
  - (none)

Changes in v3:
  - (none)

Changes in v2:
  - (none)

 doc/board/samsung/e850-96.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/doc/board/samsung/e850-96.rst b/doc/board/samsung/e850-96.rst
index 0cb95473e536..0a7b6fc0c9dd 100644
--- a/doc/board/samsung/e850-96.rst
+++ b/doc/board/samsung/e850-96.rst
@@ -47,12 +47,13 @@ Build Procedure
 ---------------
 
 .. warning::
-  At the moment both eMMC and USB features are not enabled in U-Boot. Flashing
+  At the moment USB is not enabled in U-Boot for this board. Although eMMC is
+  enabled, you won't be able to flash images over USB (fastboot). So flashing
   U-Boot binary **WILL** effectively brick your board. The ``dltool`` [8]_ can
   be used then to perform USB boot and flash LittleKernel bootloader binary [7]_
   to unbrick and revive the board. Flashing U-Boot binary might be helpful for
   developers or anybody who want to check current state of U-Boot enablement on
-  E850-96 (which is mostly serial console and related blocks).
+  E850-96 (which is mostly serial console, eMMC and related blocks).
 
 Build U-Boot binary from source code (using AArch64 baremetal GCC toolchain):
 
-- 
2.39.2

