Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C8CEE498A
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 09:59:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4521E89252;
	Wed, 11 Sep 2024 11:58:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aQfqUaNm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9931F89240; Wed, 11 Sep 2024 11:58:54 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B87328923A
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 11:58:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-374b9761eecso1378095f8f.2
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 02:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726048732; x=1726653532; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eyG3QXG+UUiIibtKovBRnK2Z7clawHN81b2WLACzqvU=;
 b=aQfqUaNmNwfile+AsQ7hQTrvuPtdM/lD0Jfot0DdYWNhfqOBdYTdgLQroBjAY29zjs
 rh6tE7osGHaj9tTPmyPhakFn+rvuD7OK1Wb/WrGldWOa5hliYOX6COh3oyQvx4SB+hel
 hj6sPgBxqCR0L/ABLEX69gSjtiMTMHXdNkMb+6Bob8iH5jzQ4iD8D62MpsOT4Pjme4lN
 m18yVWCNqS77fpOGc2cRbNoXJL+NX1+fE7BQk8VZ4y2SwbalH0YxM+3HHsD3ZEOgDqVR
 igksqUIA+Chw3kC1hzswSnEZ4b44+Fw8nD1R+JQS7SImQ7XMx81EwnvJm1VUGyl7CtB5
 6K8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726048732; x=1726653532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eyG3QXG+UUiIibtKovBRnK2Z7clawHN81b2WLACzqvU=;
 b=fMFSGV7BYwQmeagHo0PJbx8jL/+CBvVWGZ+S2Py/FemUAr579mRD1dcYb3Gp+CbctY
 hILo97eWU3eL89C7RoevyM29swpnfS65mjRKO2vxxQBO23zoUe8gCvCv6hgmQCL5aywd
 6x5QCGslPsDQNo3A46jQ+Q6MvyXD4SeEijx7Su9oKp1CuAwWNCwyXi1DRNaQnb7SJG+b
 wxRXAL4k23zDv91H9LUuYD0oWkUgtvSLkiJ3l6Oxht+4jnAQqw23lKTzpFWMTQ6ZhEAB
 0GAcL4Nz0ohefxbBcvrx5zMp2xB/7HlY+5GXGdndyx+uiL/Du4MTnpgV+1A1z/+LqErT
 9zBw==
X-Gm-Message-State: AOJu0YyXWHnddr9i2SWjKh0D2QX6czhvH5HQlxyJ3l9ICpb3VEwuaZ7q
 aooLizlPr6QtYqlIVwCh2DsxaWZoMzuFksdtDI5kReRHG8yBk27g2mpqm1al2locKY3aJFnBYi1
 JeYj19w==
X-Google-Smtp-Source: AGHT+IHmJwfJMlQygx1ALY/5kS+HCKxa5/cAvWSXOct/vRytFh1FlvAt5DX928veDxVKdFUSPkU/sQ==
X-Received: by 2002:adf:ec0d:0:b0:368:64e:a7dd with SMTP id
 ffacd0b85a97d-378b08003bbmr1595779f8f.53.1726048731998; 
 Wed, 11 Sep 2024 02:58:51 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:7d92:535d:cd3d:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895649bafsm11300507f8f.7.2024.09.11.02.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 02:58:51 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 04/15] arm: omap2: add missing #include <netdev.h>
Date: Wed, 11 Sep 2024 11:58:17 +0200
Message-Id: <f1cae14143ef972dd2ad05110443a8267d8746b9.1726048404.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1726048404.git.jerome.forissier@linaro.org>
References: <cover.1726048404.git.jerome.forissier@linaro.org>
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

emac.c implements cpu_eth_init() so it needs to pull the corresponding
header file.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/mach-omap2/omap3/emac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/omap3/emac.c b/arch/arm/mach-omap2/omap3/emac.c
index 7348e92cabd..1e30a06361d 100644
--- a/arch/arm/mach-omap2/omap3/emac.c
+++ b/arch/arm/mach-omap2/omap3/emac.c
@@ -9,6 +9,7 @@
 #include <net.h>
 #include <asm/io.h>
 #include <asm/arch/am35x_def.h>
+#include <netdev.h>
 
 /*
  * Initializes on-chip ethernet controllers.
-- 
2.40.1

