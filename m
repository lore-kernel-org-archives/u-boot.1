Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00460C87FCC
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 01:14:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 868EC83013;
	Mon, 28 Jul 2025 03:14:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AXX2BCAM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3BC383045; Mon, 28 Jul 2025 03:14:13 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C758B82F14
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 03:14:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-31c4a546cc2so3132096a91.2
 for <u-boot@lists.denx.de>; Sun, 27 Jul 2025 18:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753665250; x=1754270050; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ttQCb5nIIM5kdNmxD0KgxK2nkXEp3s4dE2YUbq+wHvw=;
 b=AXX2BCAM8SP1XTeVCmHFifAzrAtn0JEKrXy6/cjd8VBxDY9Zg6/QL6haJmLGGOJWTk
 E6YldVy/bfxSpgjfvpvaCKWquemW3Dte9P83PomFH6F3EdslTHOSMvI1voZt+THqV0FX
 p88DssVGGL+f8GIgzyO6EqQvxIF3VJcJScRkKnK9tc0GiCMEm+NEDGmFKqsl/jiZQEdF
 Pfao8ZR1x1TeYPgg4UJDi9o+vJYX4InB0Fc6b28qTBMK6MKSJ5WmZtb4S0VeqlTfUwTW
 ifUus7f6FwROBBTU8OlkLmuXjOBg0pWUbAHFA+kizldJBTGoIFmR0biYtD1dS0u0figE
 61tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753665250; x=1754270050;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ttQCb5nIIM5kdNmxD0KgxK2nkXEp3s4dE2YUbq+wHvw=;
 b=UtxFB12dZqqO6KeVbK/7q1isnGZN2n1SfbtTDGSZRMZZqMTGcsp/QojtkL40MFOTHX
 HRJEFiTgUW3xOYA+IOyP+Ps7qQWjuVZriFD26rldnnGLDk2gg0eAKMQLqlY4hh8+0u7T
 FiTPh1vOBBiPxY9QXE/u73iVbGPgN9TDdQZu5E5rH514Uj18mv7S+SzpsBCoLhWWPbzZ
 AgdZwxcQBE+36RmQUzBlh9A7NaUh8pb4n7KY/bTYrZrFtKS/+bSKME886NvHarhDzrfh
 o9ZZeLLJ/r0ZgbG0SMc8R2h2b9Qcnpa+NNaBIPvWHPUoad390f9TQPhFFBoTn7uJFWgy
 eREA==
X-Gm-Message-State: AOJu0Yxwl4nqOoomv11+G+K24ySPA8tJxzORd3lAsYBy2YNYIA51rLXi
 sbUEZUKBAwfLh+yr0HUwWo5a0rfK0NrfaXPX4y6KJzb807Iy/E/TcK58Z6JssA==
X-Gm-Gg: ASbGncuHpdUmCNBA80WbZpPIKqvVcIxe7Qvba7YzsyTK0d8yGQzFgP2C8L4as1FeTK2
 UYIBSCoiEIpt7pgiEabYG2NxJb542Yi1uaxODnwxDoaXjqyyqxj6Ys0F7W4uUqExQ9w5jP6f5cr
 e++dG+hi0e13Lzd3VAAnJI90906VuzvdlK3SOt9b83bbsF0NQzUF7u2U53IIuHc3II1HzKCNm9+
 G3NVFs10fl2mMB6FHHyWNI+HlfHZK4dBV6ZYq3BCXs2JSoUjJeSumRaS++liFz7WOsCZuz2fJLs
 upAfQh8AaflsavtYwL49fALhU7M0pb4w6HT8fPIlAFyYfLz9803lj2nixzs5Cx2bfKTEF0kDDdb
 O8bvL04Aiglpzrafv+4MYZalx9ouyDB7t5OziiOLVAh3H4c/n3ja19XYw2DYFl0jYJVoVuaYUXX
 HyjfX4+KMCllpoStM=
X-Google-Smtp-Source: AGHT+IHZZGLHSlrj8N5xrOrxJAH41fmINONi/BEFPdUDtuAKEXt3xmHv0KmdsksId+ejkutxqV6OgQ==
X-Received: by 2002:a17:90b:134e:b0:311:9c9a:58ca with SMTP id
 98e67ed59e1d1-31e7788a6aemr14811246a91.8.1753665250101; 
 Sun, 27 Jul 2025 18:14:10 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e8350cc4bsm4329834a91.24.2025.07.27.18.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 18:14:09 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 tudor.ambarus@linaro.org, pratyush@kernel.org, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Hiroyuki Saito <Hiroyuki.Saito2@infineon.com>
Subject: [PATCH] mtd: spi-nor: Fix return value of s25_s28_mdp_ready()
Date: Mon, 28 Jul 2025 10:13:58 +0900
Message-Id: <20250728011358.30034-1-Takahiro.Kuwano@infineon.com>
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

s25_s28_mdp_ready() returns 1 when spansion_sr_ready() returns negative
value (error code). Fix this problem by following Linux implementation.

Fixes: 1c3dd193b5b ("mtd: spi-nor-core: Add fixups for Cypress s25hl-t/s25hs-t")
Reported-by: Hiroyuki Saito <Hiroyuki.Saito2@infineon.com>
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 655bf3aaf81..76c33b24368 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3784,8 +3784,10 @@ static int s25_s28_mdp_ready(struct spi_nor *nor)
 
 	for (addr = 0; addr < nor->mtd.size; addr += SZ_128M) {
 		ret = spansion_sr_ready(nor, addr, nor->rdsr_dummy);
-		if (!ret)
+		if (ret < 0)
 			return ret;
+		else if (ret == 0)
+			return 0;
 	}
 
 	return 1;
-- 
2.34.1

