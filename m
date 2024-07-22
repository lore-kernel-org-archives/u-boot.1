Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF96AC3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 18:04:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72F7B887E6;
	Mon, 22 Jul 2024 19:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Lu6LSt+5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 483648862C; Mon, 22 Jul 2024 19:58:12 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25B5D8863B
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:58:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3dab336717fso2642696b6e.0
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671089; x=1722275889; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eDECQwEiIbilW7GC5h3kScq/RNkZ6iHasy9TlEMgqp4=;
 b=Lu6LSt+5/uhLRJhZ6hKH1z5jkE8yrBu5Y1+FJzSqaHmkmcxmbre2j63OuTvYD3H602
 b4caaGxw9GrCMqLW1Qho93Vl/6m2u3cvfvZOHwMp4DfNjmjS8w+4Tv6UEk7bpkaqlZ8B
 3v6tGCk5kp05M2Qg3+Y2G6jsTBN/cFs/xdDmvgN50rDumUs/Plu0VH1bcgNgiiJbWoxv
 latPnfSQtXd4sjldFygfjwjaR7SeXimKoAmpty8lo+VRJa866iAWuN29lv8zIzNl9dvM
 dqFaVBj5yBYhuy3CsgFjdLysIxpqwjNNuc4QOoAuLzSC/Nq0RT6OeCwDibFGqZEOSVRS
 wcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671089; x=1722275889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eDECQwEiIbilW7GC5h3kScq/RNkZ6iHasy9TlEMgqp4=;
 b=V26emDRo3J31RI4YvCCkTCD3kiL8kF4X8HzAATSio398E1LZXa56VwCPajOSwrIPK/
 Njom064gOvuyGq8GNXwRFKnSYno8TcSbQVLXHpLSwSAlLfBeNvt2fib7guOu05hQNvXi
 b7XqRfWhWZ0KQPNXbY4a0m11kNr8vHP1iRcHRSZlwQUSokwjmH/dx3O4RHFVgDyEo/dm
 0MpTgXv7s8RkUXN6IYiItl/zHukxaPGcgdkOKVi1qFeIGF9bRRN1IcPHlAKCGVlcDOQM
 Jo/1xZD4yABXWnolx1RTbE6gfzgK30xIefSQzrAxrZ4p0WoXmr4ugoTcvqAeHCC1XQX/
 R4wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdHlDvck0eA4fdam3dwInaix6UWzT+9XtezWI3aTdKPaz4yfFC8+BKe3jlWlCeyox0nW+s2Gok3Eh+bO5fmZZVrcw84A==
X-Gm-Message-State: AOJu0Yx+xRwptGkf9ZFJ4ury/1Hy9MUZblPv6kD84+RQF9uXjxc573wd
 J2qtRkW20G82X1iRv6iqBMf6FFlz0z6n2o18ntORfvrSEkDNwB4rTHD1cwU5288=
X-Google-Smtp-Source: AGHT+IGzHvSg1M61AglIK6+z7aGMEho5S62GnQzxaVw/N0KOFo4N+PHvnoO24/oaP3HGrpLx5o5f3g==
X-Received: by 2002:a05:6808:124a:b0:3d6:838b:8286 with SMTP id
 5614622812f47-3dafd0d18e1mr578986b6e.16.1721671088938; 
 Mon, 22 Jul 2024 10:58:08 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dae0969e73sm1587230b6e.5.2024.07.22.10.58.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:58:08 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>,
	Minkyu Kang <promsoft@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v3 38/38] doc: samsung: Mention enabled eMMC in E850-96 board
 doc
Date: Mon, 22 Jul 2024 12:57:40 -0500
Message-Id: <20240722175740.6985-39-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240722175740.6985-1-semen.protsenko@linaro.org>
References: <20240722175740.6985-1-semen.protsenko@linaro.org>
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

