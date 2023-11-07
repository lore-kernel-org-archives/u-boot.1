Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E756C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 19:06:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDCFD87584;
	Tue,  7 Nov 2023 20:06:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CBJj3Vr7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAF53875BF; Tue,  7 Nov 2023 20:06:07 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F7CB875BF
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 20:06:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5869914484fso3332145eaf.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 11:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699383964; x=1699988764; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LjFvinfoEp/lieblzIudkNY2qHMs8fgFELz/BB33aNQ=;
 b=CBJj3Vr7foH4nbrfZcin8300dQjm4CFsD/VqfDmAmszs7mGq5b27uJZeUpMHP6olOQ
 ID7U005oKeTKWTMkQqrPaW5YE6pGRHFU0CxTRQtJ4lvtI6JMwSRv0en04nreC12BRSXu
 7HSadGNzSMdUKFnvkyKQks8+4rv8Cy68jOJf2CVpcUm1n6NgEFNDLXjNs/IK+qUCqTu0
 cui91paCcEbjstYI6nV3tYcF8rYXv3OZYhxM01rBYOUBrAWZsygKhxRaegkV1fpZLJ9/
 G+/H8rA6dz9rjPlxg3ScPAnWnxIFQur4lzo8s7Ohg9S+I4hzsp35Lcoez3MdxTC/gw8Q
 8mTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699383964; x=1699988764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LjFvinfoEp/lieblzIudkNY2qHMs8fgFELz/BB33aNQ=;
 b=asfNF5apg28KfUq9n56EUWqmjmwQzlcQ9WEY+9psaqvMM6nDdJFOKr82FwisUrGe7a
 j0swWTcnUlRXbtERKCuFFKpa0dNllqbeZNZTXxKEuOtvbODQetPeG2V1o9pcOcMaW+ji
 iLU6TtPG+j8gubMfZWvMy9TMKhl75CsuyW/eAZCgMVnC3nKJlEeTkt68ewhCJmzQ6lG4
 JK/FE8CTfFe1f3dqw6S8dte3QfY4HsjXWhPEgha1csgi5Z5nUm7lRHS7E7/Go1s7/KJz
 fkBkd5dCkDWNrpmU09bII93JyrzrhVtNH4lGcOAvCPtDk9K8HOEcVindnJhdGUl1qUNE
 3ROQ==
X-Gm-Message-State: AOJu0Yx1CIeqP4ysBvLKxMkVnyRt8jRFtQTzvjtniVBWAFyzrwxO3xPW
 imGVyewsjOQ1rSZxdsXl55mXaFanGZkKOwBQvcOjWA==
X-Google-Smtp-Source: AGHT+IF1Is4kFgsY+AEZU6uQtgvx97Kj7Hsz9g29z6+rDOeOFq/1b8XtDHV+RIzYBpICK/TKHoW3gA==
X-Received: by 2002:a05:6820:211:b0:581:3e7d:12e8 with SMTP id
 bw17-20020a056820021100b005813e7d12e8mr33524767oob.2.1699383963913; 
 Tue, 07 Nov 2023 11:06:03 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 q23-20020a4a3317000000b00589ce21f6bfsm114454ooq.15.2023.11.07.11.06.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 11:06:03 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Cc: Mark Kettenis <kettenis@openbsd.org>,
	u-boot@lists.denx.de
Subject: [PATCH 2/4] serial: s5p: Use livetree API to get "id" property
Date: Tue,  7 Nov 2023 13:05:59 -0600
Message-Id: <20231107190601.17151-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107190601.17151-1-semen.protsenko@linaro.org>
References: <20231107190601.17151-1-semen.protsenko@linaro.org>
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

Use dev_read_u8_default() instead of fdtdec_get_int() to read the "id"
property from device tree, as suggested in [1]. dev_* API is already
used in this driver, so there is no reason to stick to fdtdec_* API.
This also fixes checkpatch warning:

    WARNING: Use the livetree API (dev_read_...)

[1] doc/develop/driver-model/livetree.rst

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/serial/serial_s5p.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/serial/serial_s5p.c b/drivers/serial/serial_s5p.c
index 177215535676..c57bdd059ea6 100644
--- a/drivers/serial/serial_s5p.c
+++ b/drivers/serial/serial_s5p.c
@@ -20,8 +20,6 @@
 #include <serial.h>
 #include <clk.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 enum {
 	PORT_S5P = 0,
 	PORT_S5L
@@ -220,8 +218,7 @@ static int s5p_serial_of_to_plat(struct udevice *dev)
 
 	plat->reg = (struct s5p_uart *)addr;
 	plat->reg_width = dev_read_u32_default(dev, "reg-io-width", 1);
-	plat->port_id = fdtdec_get_int(gd->fdt_blob, dev_of_offset(dev),
-					"id", dev_seq(dev));
+	plat->port_id = dev_read_u8_default(dev, "id", dev_seq(dev));
 
 	if (port_type == PORT_S5L) {
 		plat->rx_fifo_count_shift = S5L_RX_FIFO_COUNT_SHIFT;
-- 
2.39.2

