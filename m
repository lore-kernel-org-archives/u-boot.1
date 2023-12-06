Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9962C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 19:06:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E63286EE0;
	Wed,  6 Dec 2023 20:06:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m2TsyaRT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D0C987663; Wed,  6 Dec 2023 20:06:48 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F276686CF7
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 20:06:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrej.skvortzov@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50bdec453c8so129984e87.3
 for <u-boot@lists.denx.de>; Wed, 06 Dec 2023 11:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701889605; x=1702494405; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Esv8IFXjqJtP/zpr/ForiP8lzdI10rh4rUfw3jmxJpM=;
 b=m2TsyaRTnEZBgOV3ocqw/4kqJNy2xT9ijfxskjPZntom23F0oi8kYOHS1vHRKOtkRu
 BWrmKqKJUBGXYVucpjVm+7SCFLpQ+zfvScUd6wyZjulW73l6zhola6qXHS5GMDSFbCWr
 LCATDm5tzvl71udDrvxqfTC9Y7Lct9rI4W1K7hQ6zX/8BroJdAZ1VXpZQPc6aTeCw23T
 bzWCXsLlF+iTHMAGowU6E0C6hFly5dLZZcG8eweUCetCAcH1/pOKNkl57A+j7STbjDSo
 VaovDzFYSftKS0ijZcPr/L+S3Vk1fBLphH61+Ycoz2c12h93cv9hDtrqLam+SqedGpMq
 Iw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701889605; x=1702494405;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Esv8IFXjqJtP/zpr/ForiP8lzdI10rh4rUfw3jmxJpM=;
 b=woCqVWnZf29W8dTQq4gYxSDR5scuHYaPm7YLvRj9m7FiOy1FxpZBqCeaE5D4d1Y/go
 gqXTemXnod5YzFuxwazSoU0Qwttum8lYOLbhTlbTlmpMWx9i0+YM0Koq9Ioa1PfwsOGL
 AB6RIL+3Ba89alrt3V5UkDo6XJWZ+ryVfjgV2uXuLDibWZU1ND3AH0JzSx0FAhgsZMlT
 e7Itlzjj1vkv4GoloULkaS8winL+8XahClk0JPAQqrr/qKeFfg72Sg2Yl77T9LaVfyTF
 0Rj3PCuKm2BKH+pwQlBHci0rbIMP+gJorO2oK9MfdzZK+U1Yrhn7BGeeFf3VRj/eG9D1
 G3iQ==
X-Gm-Message-State: AOJu0Yx9drJuYYPIboqwvTpdCJNCrolMpImc0rDU+QvBGR7iiRpHoDYs
 vJMTafkS+Ya3GN3EuaeeJqM=
X-Google-Smtp-Source: AGHT+IEm4YsAlUwb7htXrbIva0PmgsZZbH0G4c79VgZkUwb1um9KxF/VpScTxiA20OgZnPO+G5EQow==
X-Received: by 2002:a05:6512:3292:b0:50b:f776:1d57 with SMTP id
 p18-20020a056512329200b0050bf7761d57mr859014lfe.28.1701889604898; 
 Wed, 06 Dec 2023 11:06:44 -0800 (PST)
Received: from localhost.localdomain
 ([2a05:3580:f312:6c00:826c:ae47:61a7:8af8])
 by smtp.gmail.com with ESMTPSA id
 q9-20020ac24a69000000b0050befd41477sm1230370lfp.273.2023.12.06.11.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Dec 2023 11:06:44 -0800 (PST)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH v2 0/2] sunxi: restore modified memory
Date: Wed,  6 Dec 2023 22:06:31 +0300
Message-ID: <20231206190633.131346-1-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.42.0
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

Changes in v2:
 - rename temporary variables
 - fix types for temporary variables

Andrey Skvortsov (2):
  sunxi: restore modified memory
  sunxi: reorganize mctl_mem_matches_* functions

 arch/arm/include/asm/arch-sunxi/dram.h |  1 +
 arch/arm/mach-sunxi/dram_helpers.c     | 32 +++++++++++++++++++++-----
 arch/arm/mach-sunxi/dram_sunxi_dw.c    | 13 -----------
 3 files changed, 27 insertions(+), 19 deletions(-)

-- 
2.42.0

