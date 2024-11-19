Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2CAD6C2BA
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 00:29:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E64689645;
	Wed, 20 Nov 2024 01:28:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JSmbJoxs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19BB389555; Tue, 19 Nov 2024 23:47:03 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C67089431
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 23:47:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4314c006fa4so5966955e9.0
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732056421; x=1732661221; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=whsMWy87DdN0a+FeuQymygUWgKhoOAh97g3EiwT1pb8=;
 b=JSmbJoxs7VqjNYnCjLu9xdzBCCgfR77dYB1swv7Ka1gUVnpMiHYP7nUV9hV4JLvFLN
 k8/wa9aCSVo4jhj2VGrGoqH+JFvG8wpxCHMtHgji/zrWeLiX9g/jEnqbGxk8dtP+88gI
 FdkWd8cy9svWf6r3BXY2HuaSaz7t3c3LNIMX+QXzg428Q0sTANcWlTBeXNKXn+N33+Pn
 lDrUueokE9UgX7ilglbzEIUPta554svKuK+WHfc+X7SuI5USVInyW9zE7W9dykV5QjM9
 K5pe3QbtY6O6PusfhdbzegmlfpRbZlzFayKiXygYhS6E+FC6YZjnRprFBAhJi9IgX0hE
 DmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732056421; x=1732661221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=whsMWy87DdN0a+FeuQymygUWgKhoOAh97g3EiwT1pb8=;
 b=UPu1G/asCKMxAvm0RPAjneabG+ET0KbLP7qkdHyB2N++T1HDLCxrBDLN5Cu0ugAarE
 OdFNn8/JKzX4oyOzxMQtbs1q41JMDE8key7XTiU4k+zzTLN8R5iPTe66CE227dhzdvJo
 BHB3Gijcgb2cRFOy2ZEpMO96Y7Rd92KPgYibnz8IPlUODKxlkgcIbnsJmPE+BM0DS9Dj
 PoC5BrOlUnm3GBFrRX/3Gp3rKSb5wHCI/S+bxWw6zd43utTgN2PDrYNWmG/GeXeVEkUl
 KLj2tuZrBqGFPr57cd/17QhTTXwqpHcyv/bfBhFu5WaJD+5hk2L0wSBhf4Etm5Iaa/hV
 oTNw==
X-Gm-Message-State: AOJu0YxfAFb0QND97tdC0OwYVLA903qeWg+eHPwi09bmMBpo3rTE9RoX
 auFpLFRH85hmqjUgJPwSGD406PFE/GzkTXbGCav46wMHeqk6b7/GvGtDnEhO
X-Gm-Gg: ASbGncuRzN81X5genHTYNmG7DGviKVYvyXx8tjBODhuz/GVjkb6itPChcx5aZVcA4Ub
 XP2J4Ji1kizR/oTERUPzAOYiGthrSzRqpNLAjPNeUW2J9PpYly9NbTxI/RJHxkSKnyIjFng/BfX
 d0gSzZh3TpslzDov231OV2onaxreLelJo9Q93D+zUOMeJQf66f7HlIA72dL53naClOHOmYNMK4F
 PBsP44L9IQ1+WSbafB1fnjjEZQEN0FzaDjGiYzdjhd9Y3+DZVXcQGf8eXJWYoFiEBz40FpCzSUh
 vsZa5e9xlaY07o1DD06a8cqI+8le
X-Google-Smtp-Source: AGHT+IGGg4i5wwEnSikJ4RTYv7HrhvgNRerzXqEy2a+YR/lXohqDFUdimJpY8lDd0cXBDCGQyVOZJw==
X-Received: by 2002:a05:600c:1d1f:b0:42c:aeee:80b with SMTP id
 5b1f17b1804b1-4334f0230ffmr1945725e9.8.1732056420320; 
 Tue, 19 Nov 2024 14:47:00 -0800 (PST)
Received: from d71e1d1a2016.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da27fc8esm216979795e9.21.2024.11.19.14.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 14:46:59 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sumit.garg@linaro.org
Cc: sjg@chromium.org, xypron.glpk@gmx.de, michal.simek@amd.com,
 jit.loon.lim@intel.com, barnas@google.com, l.rubusch@gmail.com
Subject: [PATCH v4 v5 09/10] ARM: socfpga: update function call to modern API
Date: Tue, 19 Nov 2024 22:46:42 +0000
Message-Id: <20241119224643.27692-10-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241119224643.27692-1-l.rubusch@gmail.com>
References: <20241119224643.27692-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 20 Nov 2024 01:27:55 +0100
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

Remove arguments in the function call. The call's argument list differs
from its definition, which breaks compilation. The removed arguments are
obtained from device-tree declaration.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/mach-socfpga/misc_arria10.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-socfpga/misc_arria10.c b/arch/arm/mach-socfpga/misc_arria10.c
index c442af0288..1e20f77773 100644
--- a/arch/arm/mach-socfpga/misc_arria10.c
+++ b/arch/arm/mach-socfpga/misc_arria10.c
@@ -214,8 +214,6 @@ int qspi_flash_software_reset(void)
 	/* Get the flash info */
 	ret = spi_flash_probe_bus_cs(CONFIG_SF_DEFAULT_BUS,
 				     CONFIG_SF_DEFAULT_CS,
-				     CONFIG_SF_DEFAULT_SPEED,
-				     CONFIG_SF_DEFAULT_MODE,
 				     &flash);
 
 	if (ret) {
-- 
2.39.2

