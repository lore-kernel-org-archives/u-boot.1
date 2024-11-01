Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910FCE6B244
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 11:50:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08BB0892CF;
	Fri,  1 Nov 2024 12:50:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S554X/gB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19AB8892CE; Fri,  1 Nov 2024 12:50:36 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA30C8924F
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 12:50:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9a156513a1so313418766b.0
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 04:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730461833; x=1731066633; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z8gFUewTU33Mu/sRojl5mU+Xe7VTfWM/tNk0OLSCGGQ=;
 b=S554X/gBtP+5KXdwzq/beDY1nnkvnxHlajWq/ZHvpYp0rsln/jXNX/5zR2g1VcalV5
 dqCAWqcgX8cuGIB2FtCT+tryj8pPayTUJRl9m/Za3uxUMmxPjTvT5tFpfFASIDZ1wYxQ
 JHydXuxxEpjhgRcD5PyHruFc/POYxVxXWz8e0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730461833; x=1731066633;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z8gFUewTU33Mu/sRojl5mU+Xe7VTfWM/tNk0OLSCGGQ=;
 b=TBP7ZdKdqeZTKLgUEj+cdTHZZexHevjP8LpuusfjuDOQbN13o66vwVXhpwoJFIGKoh
 XrCVgSAO/Hdx+5LLWXC1eq0ZkSCM0Dp/ohobLsRMqLHpeqaVQpSsFXldDLS3Ns1bxnhH
 5/sAcd3lOgrdff/ZCnYtkUOtK8wohvz8qU72rqKEMOAvaGhuCwoZUF3hB04jwhbs9bEN
 4P0LWBsnEBuCLCvvEt1U3BRvmsejOtxyNVW4ZqS1BDz9Pca0YS1LRsGKkluhz2LPLbzK
 KaGgjBZuNF3Q/ewr660JUiOc+bTXrocxn6Un2bE+G7OveR/NacciPvVA/MZRNVTHlkpV
 26Ww==
X-Gm-Message-State: AOJu0Yyv/67/lk5AE51WSu4ugv8N+k2JHrDUrvn5CchpmgJEcUk2upNX
 YOLxVztNI4T5Jvh49ac9PA1JloDjCIvukKu365jJiwyYjVDfA4xzDPVslgOVx+JLTW9cNDWiOLn
 fdw==
X-Google-Smtp-Source: AGHT+IFTMKWPif3OkhvVjHbFEW8dmn7ERe1JVp0+Pi6wOcTz+r5ABvRoCdIW5nyZ7ZP+RR3rX3fe2Q==
X-Received: by 2002:a17:906:f59b:b0:a99:4780:1af with SMTP id
 a640c23a62f3a-a9de5f6e2eemr2275776466b.31.1730461832682; 
 Fri, 01 Nov 2024 04:50:32 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e564cc430sm171616566b.88.2024.11.01.04.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 04:50:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Svyatoslav <clamor95@gmail.com>,
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Pavel Herrmann <morpheus.ibis@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 0/3] Adjust how autoprobe is implemented
Date: Fri,  1 Nov 2024 12:50:23 +0100
Message-ID: <20241101115028.214678-1-sjg@chromium.org>
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

This little series makes a minor change to how autoprobe is
implemeneted, as discussed on the list:

   https://patchwork.ozlabs.org/project/uboot/patch/
      20240626235717.272219-1-marex@denx.de/


Changes in v2:
- Add autoprobe to SPL also
- Leave the function name the same
- Fix 'Prove' typo
- Update cover letter since SPL is now covered also
- Update the documentation too, with a discussion link

Simon Glass (3):
  common: Drop check for DM in initf_dm()
  dm: core: Simplify dm_probe_devices()
  common: Move autoprobe out to board init

 common/board_f.c                    |  9 +++++++--
 common/board_r.c                    |  4 ++++
 common/spl/spl.c                    |  4 ++++
 doc/develop/driver-model/design.rst | 15 +++++++++++++++
 drivers/core/root.c                 | 27 ++++++++++++++++-----------
 include/dm/root.h                   | 10 ++++++++++
 6 files changed, 56 insertions(+), 13 deletions(-)

-- 
2.43.0

