Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B6EEE645D
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 08:01:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0339688EE5;
	Thu, 12 Sep 2024 10:01:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GMNOxQzJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79EC688E8C; Thu, 12 Sep 2024 10:01:47 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AED288EE5
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 10:01:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-718816be6cbso498719b3a.1
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 01:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726128098; x=1726732898; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W673a31e4nb22R1tTmcE82O7Ma5qqHtZKqr3LVHnpg8=;
 b=GMNOxQzJXtpJ168HXcPrgbjpzOV9R0XcBcYFJ7CHWe82OtQe1us19IHF8KvM5XNw0+
 AYOxVQnAsTixryVVfbZ1FlXrqaeqjIb+hZi3DzqVAcnSpmisToo/3hsntAe41wajg8HR
 015mTki1yNjmx+VYVTojCVCVrElZ7zttBMiHbFQzdLfEsljo8yG186p7s5CsBkvQNAz8
 G372MzNtHQJQP1PHOpLTN/pCVDp1l8+QBLiZuZZGX3QlFJQHVVooa6vmm3XkT/fxYYep
 /NA7/MppTEuJLe6POj/+x2pFaE8UnvlChaPY9z3JHRMeNRNAziqZjssVO5XsKtqDkr8+
 JrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726128098; x=1726732898;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W673a31e4nb22R1tTmcE82O7Ma5qqHtZKqr3LVHnpg8=;
 b=L1CazEwxyz+mJTfZBSPlKT+bb677buyGFRIQU3QggsAtnYfTngwKTjFVKzEAIjGlFL
 d9uimkk0g7QbDb882TE4ZiyajdKJJ0A3T4amZ365UDfUDzJIVJhr+9pHlGr0ycYp41YQ
 0tJgfElQgnT3FB+sHbq47MNBOnQzk1GMaZqsaKurKECThpWJfKEAwkwkDKbAIb9qK37R
 oYaWdMmrZtQxPFEF0TsGxQc0TCFPE1FSGm7u/Qgo9ni0VJSJ1BgGd0HBZPzZY/j53hAF
 UfZj6PAztQjug6b5JuoNiA3cYhOixh3Tnh9YkYlMzcSqB/hc9kdhJyLNwBpCNXVrKuA9
 BbiQ==
X-Gm-Message-State: AOJu0Yzv6PscLCQB46aqxPNvNyFBabrwPVDsCb7DXBjP6YA6Ea/fBQ5W
 3xXppVmFKeNUdxFvTUuEgG4g4Ejnq4uJ+JdSxgrK3C7630I4AIQd7nDqiw==
X-Google-Smtp-Source: AGHT+IHNSyP0g3aocJRmjRQJ4OWuJt4k8pD1TWSDm043seogwNCHiTg8X6thDeMvuxhMFpjp4YlxCw==
X-Received: by 2002:a05:6a00:2352:b0:714:3831:ec91 with SMTP id
 d2e1a72fcca58-71926213e47mr2565945b3a.25.1726128097926; 
 Thu, 12 Sep 2024 01:01:37 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-719090ad8bfsm4241790b3a.145.2024.09.12.01.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 01:01:37 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, prasad.kummari@amd.com, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v2 0/2] mtd: spi-nor-ids: Add NO_CHIP_ERASE flag to Infineon
 2Gb parts
Date: Thu, 12 Sep 2024 17:01:28 +0900
Message-Id: <cover.1726127619.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
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

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

S25HS02GT, S25HL02GT, and S28HS02GT are dual-die package parts and do
not support chip erase.

In v2, split the patch and add fixes tag.

Takahiro Kuwano (2):
  mtd: spi-nor-ids: Add NO_CHIP_ERASE flag to Infineon s25hl02Gt and
    s25hs02gt
  mtd: spi-nor-ids: Add NO_CHIP_ERASE flag to Infineon s28hs02gt

 drivers/mtd/spi/spi-nor-ids.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.34.1

