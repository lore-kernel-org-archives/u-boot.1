Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6EDECF34C0
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 14:51:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 364268397D;
	Wed, 19 Nov 2025 15:50:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RAdJe5JA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E4EE8397D; Wed, 19 Nov 2025 15:50:42 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E4DA83F85
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:50:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-65749fe614bso667494eaf.1
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763563838; x=1764168638; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/96cRVC0/HXUi54C/AIVtF8ikDsSiXiKSCcZnOFBP3E=;
 b=RAdJe5JAVwPQ57yTxcbD1B+T80BEoYQYu7503+EaZ7CeqxMRhgiQR6zNbdbAG8X/FO
 3ZRNmPceqBmtDksCSAUjYf5+SyDY2LWVa9iw9Qd4KMGVBVYCYK02N0irogasFHcfz6nG
 JN/gvEuC/nLuy0BW2W4wnv1S/YEy17Aclae9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763563838; x=1764168638;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/96cRVC0/HXUi54C/AIVtF8ikDsSiXiKSCcZnOFBP3E=;
 b=v4AXyFuuUV1sgQElCRDzX5DvZWFj9kztxUgwQhtpH5sp20JcXKb8UqsblZD/1aI/vp
 2CUl502CeMz6EgeI6ps0OEqiAxtSekGjKAb62zKXo8qAKiHu6ugQfVwVeqS8On2WoALg
 giuVL1P35hFPCSBAAzIl1wTfcV/aM2K+9dZCSLEk8uHVqSZeGStQ1xnpVFT5+7M6yD4x
 Saz4YpA6T5FoDDBYuXaxHrYs+LKanwIZfko8sgkFxNwUldtGexY4c9mkK5evKDENhtEK
 Ymg9KJqum44BOvq2R4w78zFLAmuucm0CX0eikOdIo5/gu/x/FHTL/tbarwT/XtMpn4YA
 8new==
X-Gm-Message-State: AOJu0YyhgFujjii7kexKmn1njmGqBZLsDrXiEuX3hNz0tslYVrI1vogZ
 lSlnrQMS0/3jE9PAIH53hsEW+ahWG4+MGqAsfW4s/d1kpvPVbi0OAZm1uTpGMlkyJJeaTuzXiie
 O1ZdU4gP0bQ==
X-Gm-Gg: ASbGnct7ZS6KdQG4SA2azfE7xM9vVS8B9PovbuHINTnhFgOAbNlkdm0a1WK0PSAKlgB
 oU/x9uwpqTj7oZeN4mAdaFuQAAj7zMSpc7O23IZFiEKbMPnqFSk0WNggv65i76tA7wSXFqZobBm
 hWy5koXEAYmOOtZzuGA4qoyOXpd5cYUWypKB9/4phitTW9zmaE42Yc1TiehMfKliciNS5FK6zWd
 we6W35VqpivggLVe/PVeshqHTXVKfTDLBCo4641wgHWozggLvcszBvDKJwFJB19HUT047U9DJTO
 abUPvCwGnsOf1D05Glxf7VAQTRGq5obUbYbrM6/KK34Qztx4nZGaSnOmIJg0pjaxZ7xTxnR3SDq
 Z/PXVN9rPYAnVWzhHExG7FVTWlUpOpU/xqJxOZcYxAGatBRp8EMWDVpvnQy5gWSbAXyMOg1oHX2
 dydm7JN5MUOVb+N2krgekUuaaCv2rNHjC3awNTi+EPeqoWcvTB8q0P
X-Google-Smtp-Source: AGHT+IEskazIxwxE+m+/oozoMju0XsAVhfnRjHUCpzdLFfSrAYULhL6n3LwrYhOoQLchRG5yqKT0xg==
X-Received: by 2002:a05:6870:18a:b0:3ec:3845:f229 with SMTP id
 586e51a60fabf-3ec38464db4mr5818138fac.46.1763563838306; 
 Wed, 19 Nov 2025 06:50:38 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e898f03754sm4525115fac.21.2025.11.19.06.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 06:50:38 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>
Subject: [PATCH] pico-imx8mq: Stop disabling device tree relocation
Date: Wed, 19 Nov 2025 08:50:37 -0600
Message-ID: <20251119145037.842213-1-trini@konsulko.com>
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

Remove setting of fdt_high to ~0, which disables device tree relocation,
from the default environment. Doing so prevents U-Boot from correcting
problems such as having an unaligned device tree and leads to various
failure modes in the OS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
If there is some window of memory that must be used for where the device
tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
or bootm_mapsize are the correct way do this. Please see
doc/usage/environment.rst for more details.

Cc: Marek Vasut <marek.vasut@mailbox.org>
---
 include/configs/pico-imx8mq.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/pico-imx8mq.h b/include/configs/pico-imx8mq.h
index f80773f2bc11..a0d587860d5b 100644
--- a/include/configs/pico-imx8mq.h
+++ b/include/configs/pico-imx8mq.h
@@ -29,7 +29,6 @@
 	"image=Image\0"							\
 	"console=ttymxc0,115200\0"					\
 	"fdt_addr=0x43000000\0"						\
-	"fdt_high=0xffffffffffffffff\0"					\
 	"fdt_file=imx8mq-pico-pi.dtb\0"					\
 	"initrd_addr=0x43800000\0"					\
 	"initrd_high=0xffffffffffffffff\0"				\
-- 
2.43.0

