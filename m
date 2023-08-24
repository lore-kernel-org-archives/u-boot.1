Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A43D4C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 18:54:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C834808E6;
	Thu, 24 Aug 2023 20:54:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e2uSzpzw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3935B86529; Thu, 24 Aug 2023 20:54:37 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC0998082A
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 20:54:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9a1de3417acso259651766b.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 11:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692903274; x=1693508074;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QB6iL7hN8YwkQXEkd/1Y5R8xuUVaSNLzwXThDqki8iA=;
 b=e2uSzpzwi7YjRCtAjynbupo4yBuo0gUxMV5+f4PNK4+v10g9qceyZ0LlFOQDY9kq8e
 nmdX/MqfQf90JAGfKajp5LMU5OkCBtC5urlH3EEA/4/KcftRwou6/KdvFxCafDZXdDkc
 +FxTtX9DKV7gkwNGcrjo0RLfyG8I9n6U3Fvua3Ha1W6ydrCt0mGHsZohNve0AVh2VKow
 itI4rTlWgkFsQ/guSb4HnCYC/3BVn01UOtEPoO17+GItErjg9re+Xh24XZqesRQhXnk3
 7Nt802jO5Yl3LQVZCDEWFJrPMnVHbEprEoGkBc2qqUxUCCt+GdY3G8KgPbNSmI69soSY
 rGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692903274; x=1693508074;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QB6iL7hN8YwkQXEkd/1Y5R8xuUVaSNLzwXThDqki8iA=;
 b=DqRAL6TbcMA+7q9vwfDKa/j6hPYIktaEzPVpsa1MV3sWhux0nlLGrVRf72CbzeV/h5
 P07Bp/UM837E7fFOCy09cqN1m51FO6VotsWwhfw9pg6HxK7yMnn5/HaZltX+E81h18UM
 K/y/kPnq1NcYmber/DdG251zRv1caz8e+3r0ST1rhWGcnHIUDM1A2gCepnZ0DyLlsWQU
 07AEPrH0HCUboT/M9uedGuLLp70woyoa0xAPXOdzph5yJ7dfMA/fbaw7e2S/t+++vrPb
 XOezEOqVI68OGXTUEnWDL9C5JP08tvn2X77SmoYGJnP00GSLYWE9U0eMwQ7Jut8jyasb
 O+jg==
X-Gm-Message-State: AOJu0Ywys9QoGS2pRO0MMOlprPBW6Go2QFjSMNbOrHYQJn0MSVYhOkrX
 s8mBDvFRzhyI0ZpVLdDspWs=
X-Google-Smtp-Source: AGHT+IFq7dJra/IDz/j7c+rpb4ZGvQC6hemuyplA5LzPo+1N71UXT3oQLF0JsyG8RboCzr8Dmnb3qw==
X-Received: by 2002:a17:906:846b:b0:9a1:b528:d0f6 with SMTP id
 hx11-20020a170906846b00b009a1b528d0f6mr10032348ejc.27.1692903273783; 
 Thu, 24 Aug 2023 11:54:33 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 jp23-20020a170906f75700b00989828a42e8sm11166780ejb.154.2023.08.24.11.54.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 11:54:33 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 0/2] tegra_mmc: get tap and trim from dts
Date: Thu, 24 Aug 2023 21:53:30 +0300
Message-Id: <20230824185332.50176-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Default-tap and default-trim values are used for eMMC setup
mostly on T114+ devices. As for now, those values are hardcoded
for T210 and ignored for all other Tegra generations. Fix this
by passing tap and trim values from dts.

---
Changes from v1
- move t210 device tree fix into this series
- switch dev_read_u32_default > dev_read_u32
- if reading of device tree tap/trim values returns error
  store error in entries of driver structure
- apply tap and trim only if they pass error check
---

Svyatoslav Ryhel (2):
  ARM: tegra210: set default-tap and default-trim values in sdhci nodes
  mmc: tegra: get default-tap and default-trim from device tree

 arch/arm/dts/tegra210.dtsi                  |  8 ++++
 arch/arm/include/asm/arch-tegra/tegra_mmc.h | 17 +++----
 drivers/mmc/tegra_mmc.c                     | 52 +++++++++++----------
 3 files changed, 44 insertions(+), 33 deletions(-)

-- 
2.39.2

