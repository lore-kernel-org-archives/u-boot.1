Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9EBCD98C5
	for <u-boot@archiver.kernel.org>; Sat, 13 Jun 2026 13:06:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0870B8484A;
	Sat, 13 Jun 2026 15:06:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JgLpFoZZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC2AF8484C; Sat, 13 Jun 2026 15:06:22 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 975438466E
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 15:06:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-440f9c48b85so1578090fac.1
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 06:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781355979; x=1781960779; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0ngIQFTX51ROfkIhauMG/vkiQZvwkHNP3J51tPBqOeY=;
 b=JgLpFoZZ6GA7C9zpU7J4llIBIlJb1Nsl3o2Otpy1rI/BMCB0VGSKqSePBRG0RVvvU0
 BtVOq8+mFz9Nt1PfGAB0rk+NQpCF9xpZBBlmj8y4zAY72NoVEvlloph37JVFrs9dB6Jh
 tP52UwI2twJ0HFHheLyUzii8HPLOA/sjuwcvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781355979; x=1781960779;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ngIQFTX51ROfkIhauMG/vkiQZvwkHNP3J51tPBqOeY=;
 b=skBwnj5vueUGthvMrZrGMve9KZfiVxg3k8JoSKoMff2KVpC/IayLm+7aoB36jo4E4F
 dfAvcJ+BfUccN5Hu5rmTNUA0D03rIbMPWglTo00xo5khT2tnJIVtWsVb3K+WvSTJBSkf
 UpyNTHmxjZUE7qGTd89pt3iHk5zbLqUC1FcWksaXbvP73tV9PafdX102/2GzdkG8Z6Tj
 9X9O3Oryrz1udUJyL1y/RQ5zzBedM570x1sJI/r4JnsoZZzuIDsI5cxj2RL3iVl+RHJs
 b5IptoWK4zhYtqBMa6v4tzLuds+hBEe9gFOrMKpVkFmT9X/ZGFMPzT3A0dKaG5ctA559
 M8yA==
X-Gm-Message-State: AOJu0Yyg02ADEp9v6euTfWbT7jvkZ/3//MihwhU+lrDxGLMY5CLuEdqd
 QxMa0eFlvWWos4CrKzyeZBi9LfIhs2DisrxTykK1bPaVXGYn+vjRPlEP2CRvd0XIF6ZKje/aSCG
 LH0Sdeg==
X-Gm-Gg: Acq92OHO/W7RPBo/WMPN4unHgwjr6E4jMigQEai2PqZJjauHov02cS4q6IqvUNZDnlN
 MoBr6uDfz8jGZcgc5+t8/P8qNXpDLmtHa+SJTsQhF/49i3xEGznrBQQcf8Ya/egXvUvm1EowjV2
 Gbq5yRJz+Y3SSn5LSrs/keYojA6Y3zEt+0UvY525FtgI3ct2aScHib8ecz3CAZ5VgD6iW4EBryb
 4Lq4qu9dHhqqC1xkAoMivM4DyCH1hQRER9izoQGcfrVylmG891yqi+eEVx6JDU31G9fsfjA+CXQ
 TDsfOKkVC2N7hKqUlt3Bi7hjC8BB0zwcdKG7S1ADy4udNjDLl0h1MD7WKNNd+O0IEZ/1ez91mbs
 igQjI1YKwRPzg8U4DWiyOcqw343cKnarAnfdm+foOP/ZeOnnZ/kPSw5Nf3ppzfJB01Rsf++7Xvn
 02OEpdInpMkIRBtnZi4w==
X-Received: by 2002:a05:6870:e2cd:b0:424:801:49fe with SMTP id
 586e51a60fabf-4426ebf9643mr2950167fac.8.1781355979324; 
 Sat, 13 Jun 2026 06:06:19 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4426b32624csm4459564fac.16.2026.06.13.06.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jun 2026 06:06:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/2] Repair boards broken by the 6.1 kbuild bump
Date: Sat, 13 Jun 2026 07:05:11 -0600
Message-ID: <20260613130519.1516808-1-sjg@chromium.org>
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

Commit bd3f9ee679b4 added FORCE to several if_changed rules whose
recipes expand $^, so FORCE leaks in as a stray argument and the
command fails. Use $< to restore the Edison and i.MX23/28 images.


Simon Glass (2):
  x86: edison: Avoid passing FORCE to the align command
  arm: mxs: Avoid passing FORCE to commands

 arch/arm/cpu/arm926ejs/mxs/Makefile | 14 +++++++-------
 board/intel/edison/config.mk        |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

---
base-commit: 5ca1a73c7d3064582498a8aa96c29e714402a6d3
branch: align-fix

-- 
2.43.0

