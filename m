Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F67E6F069
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 15:26:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 918C788E42;
	Fri,  1 Nov 2024 16:26:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P6i0sESk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5B8388E2D; Fri,  1 Nov 2024 16:26:26 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8D62889EB
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 16:26:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9a4031f69fso298934966b.0
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 08:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730474784; x=1731079584; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ajO0kE4L7pLjYAYTWLV7R8mXk5S+6K44+EJo4R+uIc=;
 b=P6i0sESkiPoCTQb3EDx+U62apH5VEq1DB8Z0hvSoH5iBSPBmotMrIJf5TTVmlDtIbX
 fj+InHgq0IsUEA3zwZdSybrYz2ATFiMrAq1tr6xyB+qjFi5rmGNBK4F7KOUDbz4QQ5Ba
 MTm9AoYZUmi7kLLiHU3QdUwO6qcDPOS4nrviU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730474784; x=1731079584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8ajO0kE4L7pLjYAYTWLV7R8mXk5S+6K44+EJo4R+uIc=;
 b=JtaJkkdYv2jP5Xn3ObmmI4LHrT6ZdyPhZUS1nBAQN6GFdupYBA3bYVJ3pz/rLtoo1T
 niJWEI2gVtZxXYLchvks2Q2rRJYNp9N4qx4v9n2q/H3Q/yzunCx7TA44Ku1KPAJXGFUW
 GH5bO6895j+eMtrDHiUhVwtgwlw4kx2hczAORg/tap3iDnxXqN+SaEA0lYJ8pvGDhqI8
 B7O4PLSFT6sPPbX86Wne9KcieHqozZsd6eL9bxA0FC3Qnjnx0Z8pH3ShubxgnQPaLQtN
 qZXEqoLucNiXL/DB/Ywl7aEDWsiEA7Q7bqzeIW+nZW2N2T9MjHHIDu2Txv+FZpmf+sBT
 oEww==
X-Gm-Message-State: AOJu0Yy2IsPiEy1iUwjSCTjR/fOHorsCFeRZix/xygT2I39LMKWEO0to
 D+8EwxzizmwViwl4S80Mrf2Ns3GERV/0m6QyAUhsaC22YacXCL167syvG5YN2ZFyqU8J8GXIh9P
 DJPU7
X-Google-Smtp-Source: AGHT+IFZ3S/P7OUhHrMFNkDyYBZlVJ8QxkNng+eV1iZtAfnFWSXyAwMX2Kb+t+uD5DNCqlGgGvvUFA==
X-Received: by 2002:a17:907:724d:b0:a9a:14fc:44a2 with SMTP id
 a640c23a62f3a-a9de5ee10admr680500766b.30.1730474783738; 
 Fri, 01 Nov 2024 08:26:23 -0700 (PDT)
Received: from chromium.org ([87.215.50.114]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5649454csm190269466b.8.2024.11.01.08.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 08:26:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v9 01/11] test: boot: Update bootflow_iter() for console
 checking
Date: Fri,  1 Nov 2024 16:25:59 +0100
Message-ID: <20241101152614.238747-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101152614.238747-1-sjg@chromium.org>
References: <20241101152614.238747-1-sjg@chromium.org>
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

This test checks console output so should have the UTF_CONSOLE flag. Add
it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/boot/bootflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 0d4e966892e..841729bd1ac 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -370,7 +370,7 @@ static int bootflow_iter(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_iter, UTF_DM | UTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_iter, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
 
 #if defined(CONFIG_SANDBOX) && defined(CONFIG_BOOTMETH_GLOBAL)
 /* Check using the system bootdev */
-- 
2.43.0

