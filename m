Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488DCC52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:55:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2687E885F4;
	Sun, 11 Aug 2024 16:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TDjwMYkT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22CFA889A2; Sun, 11 Aug 2024 16:51:27 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D7D1888F0
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:51:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-81fbbd4775bso127673939f.3
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387883; x=1723992683; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+WQH2O7Z6R2eQVC/I7wzkPsCiI/WVN2tMk03bhE4ifE=;
 b=TDjwMYkTaH2+HwRyTO0g64p4Z8LF/wkqlRH9ujp0lJkPMIH6pKXFjuJ4DiG01YVolH
 a3Qi/DCSq4CDUMQKznvqyIOO5VLF66Gpm0S7PjN1vVwHHgwDccm6K3wOgCCE0wEvZyG+
 1gUSW3SMd8xCnv65e3zPmKqOUrsGGIzbRkAf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387883; x=1723992683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+WQH2O7Z6R2eQVC/I7wzkPsCiI/WVN2tMk03bhE4ifE=;
 b=sDpY/x2lD3kmolX+ML+xo7na29MdVNy32B2TaXRiYSxyneDRMcoNDLYcwRj1HgalSJ
 Mp3evrNChtVTluAYf5htlUTF4jtAZsvrgyuH4yOvJNLcU2slqDzghj3/bO4+xjX8rkiZ
 8chgAQmKBNem1RRGxCheC75Nixkiu/QUBVf4peOgYMtRDH7TazqEetG6Hy9zMJiWaehe
 sV0JqF3yq7lsCsL6iNCjDOiPiRybcuaTcVmm+odP4Y9fhFiFhlcEfQ9299FS6M8H7hZr
 zwcK1j78poE8FzrevcL+m9rB0q1UKRpN7EPhhJe+7GQZ3XiTMx3gKwJYbrHPD3BsVj+G
 JbOA==
X-Gm-Message-State: AOJu0YxL+UGCCRbAx/EE/+QQHQdcgSTrjrx9q+IeP/LjtfOVmxsOiESW
 sXtXDGRh4CshBWX68wRA7hlwOkjCeLiDwca9yw6Gh08AhNacOQct+2AnRbFpG0ABOPaiaHvocwk
 =
X-Google-Smtp-Source: AGHT+IFguxEKWKqq4Wf5SauWzqSKtXYvaPHmAbjiU41lGsKwQL4yhNo+xeMo0m7bqBqHsS1f2HuURw==
X-Received: by 2002:a05:6602:610d:b0:81f:9df7:40d with SMTP id
 ca18e2360f4ac-8225ee54a91mr748700739f.17.1723387883076; 
 Sun, 11 Aug 2024 07:51:23 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ca769fbe17sm1076047173.101.2024.08.11.07.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:51:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 12/18] octeon: Drop OCTEON_I2C_FDT dead code
Date: Sun, 11 Aug 2024 08:50:41 -0600
Message-Id: <20240811145047.4189460-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145047.4189460-1-sjg@chromium.org>
References: <20240811145047.4189460-1-sjg@chromium.org>
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

This option is not defined by any board, so drop the code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/mips/mach-octeon/octeon_fdt.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/mips/mach-octeon/octeon_fdt.c b/arch/mips/mach-octeon/octeon_fdt.c
index c74fe9d9fb8..15ce292be95 100644
--- a/arch/mips/mach-octeon/octeon_fdt.c
+++ b/arch/mips/mach-octeon/octeon_fdt.c
@@ -687,13 +687,6 @@ int octeon_fdt_i2c_get_bus(const void *fdt, int node_offset)
 	while (node_offset > 0 &&
 	       !(found = !fdt_node_check_compatible(fdt, node_offset, compat))) {
 		node_offset = fdt_parent_offset(fdt, node_offset);
-#ifdef CONFIG_OCTEON_I2C_FDT
-		bus = i2c_get_bus_num_fdt(node_offset);
-		if (bus >= 0) {
-			debug("%s: Found bus 0x%x\n", __func__, bus);
-			return bus;
-		}
-#endif
 	}
 	if (!found) {
 		printf("Error: node %d in device tree is not a child of the I2C bus\n",
-- 
2.34.1

