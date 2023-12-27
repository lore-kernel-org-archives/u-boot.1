Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7892C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 21:29:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39B868776E;
	Wed, 27 Dec 2023 22:29:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Obw8R0i6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5466D87945; Wed, 27 Dec 2023 22:29:08 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70C7C8775F
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 22:29:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrej.skvortzov@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50e81761e43so2048435e87.2
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 13:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703712546; x=1704317346; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EgkbuC1rCjJiVjbS1Hw+higpUVJLJv6ATimS5lY3/Q0=;
 b=Obw8R0i6qitCku8H73l4W+WT6jJwP0d/9AbY7L6jiy2q3KGllu6fdBdT0TVicC/6IY
 GHtLaiLyCnJrGUQgSCf/BqomyFHBfw2RX9wUvxcMhZUC6BYTZjusacD30yCsfRSfkFB5
 k2RZk5V4BjoCsaCBOa/6pAe8rb6n5rZmT9yaBLr0ZwPMQecbKEyOYmrNXmP0mEoNEK6s
 pNhdCnKI7BQ9LsPLzkYf/6LVoV5JSB73r2uaOgdEN6EM/pHFpEsW+ZN9hf5FBZ7YhcVy
 EAmG5LXnvqfjbkKlxXuMRsS2NuA0f+bEgJTyl6I6Xv5nFbXJjgcN06Scxt+DNxFlkIHo
 Fdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703712546; x=1704317346;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EgkbuC1rCjJiVjbS1Hw+higpUVJLJv6ATimS5lY3/Q0=;
 b=qgZT4YmcLYUhN9oU6olp6HAKKDUySJ4oEe8xup97BYulMpN58Yy6j2bWnu8olDmLAC
 SGpUnw6MOm6/zLCzeXEF/c/XPI+q1G9supCNLvS9ye2XHIp9v5JUK052LDpFaKg4MuGq
 VtUqCCgwlHsXXKd8EkQRstyPCp92cjd97FFrbBiK715UjGZJkitOIk4gGgUI5u/hM5qU
 0eb8xPMfsMLXN6HG32B2zGbkkrvKj+B1qXwFImQYbelasU8pdGc+iJFpAIIt/aJ3D/Xu
 gHbzoa9rZH1KPOLmeOA5JXnlLZtoHNHpdL2LRMChJw8ThpDgNNu+oUWtvkygrgiycuI3
 oC1Q==
X-Gm-Message-State: AOJu0Yzfy6DfgqQuau7FeFMaVQRxZDVPolFrs+E8TJ63EaFLCM10ZVPU
 YdQMoXZAqn38s0fbBkd+ZNE=
X-Google-Smtp-Source: AGHT+IGgnIB6Ybbk01oI3gDQlgGoC76p+BUW6bcI1md53BssG1CnILhfzYeLKvItg+WzeHr2+UjZPw==
X-Received: by 2002:a2e:a78e:0:b0:2cc:d442:5dde with SMTP id
 c14-20020a2ea78e000000b002ccd4425ddemr1985998ljf.38.1703712545393; 
 Wed, 27 Dec 2023 13:29:05 -0800 (PST)
Received: from localhost.localdomain
 ([2a05:3580:f312:6c01:1b6d:df4d:cbec:e4a2])
 by smtp.gmail.com with ESMTPSA id
 o8-20020a2e90c8000000b002cc565cc5e3sm2559531ljg.68.2023.12.27.13.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 13:29:04 -0800 (PST)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH v3 0/2] sunxi: restore modified memory
Date: Thu, 28 Dec 2023 00:28:41 +0300
Message-ID: <20231227212843.397349-1-andrej.skvortzov@gmail.com>
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

Changes in v3:
 - reorder patches
 - remove casts
 - change commit message for 'sunxi: restore modified memory' patch

Changes in v2:
 - rename temporary variables
 - fix types for temporary variables

Andrey Skvortsov (2):
  sunxi: reorganize mctl_mem_matches_* functions
  sunxi: restore modified memory

 arch/arm/include/asm/arch-sunxi/dram.h |  1 +
 arch/arm/mach-sunxi/dram_helpers.c     | 32 +++++++++++++++++++++-----
 arch/arm/mach-sunxi/dram_sunxi_dw.c    | 13 -----------
 3 files changed, 27 insertions(+), 19 deletions(-)

-- 
2.42.0

