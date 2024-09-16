Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4BCC3ABA2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 09:59:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D5F388EC4;
	Mon, 16 Sep 2024 11:58:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gfxXizCd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA84888EEB; Mon, 16 Sep 2024 11:58:52 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9244F8899C
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 11:58:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a8d6ac24a3bso772172966b.1
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 02:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726480730; x=1727085530; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cy0AelE8X6/ImwZyMOvnLyspFv+MmXcjl2xKIRLZjow=;
 b=gfxXizCdUnIT1RtnVQANWiWdHBZBVu9owU/8mB0NInBemf9bxJLq1x4KU3mV84+GrD
 oI4+CeIkQ3P4rp62C6SUJQzsW5Uzp8C7Bsn2ZNKJku8SMEkYGf7RZyAfZNlkMHmaEnRv
 TlcZgDpLLHLxtGT5gJiHqdpNPHggwbE6cRkxXb4lSzyPDBfg1K/EL35EJyZJcJ581Yoz
 t6I9W/l40JE4tfnVkWzBLgO3zlC6gLZhXhLin5EQlI4HIZRUswKFqHR7uqKkL2rPgLr9
 Xqc3vBAoT/LgTfMP4tAxmdk0GIXekgvwQqTJkSY8VE83r9K9u287JqlbqAl2Xy/poH55
 qzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726480730; x=1727085530;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cy0AelE8X6/ImwZyMOvnLyspFv+MmXcjl2xKIRLZjow=;
 b=byfyrc4kayu+nWhIVm99yHW+vmYtAkrx+DHPjGSbOIbS+1J/30ZI5pl+CSnMGMoyQU
 vlXXDgeZAtNb8d3Bo0VAbiSP2Qn3YSJDaYg8Enr6YKczKl42WidQ7FcnoUcqK6wJuWuo
 uzbGviLg7KZk99xtjnJh9BC/3s82XghzUvmNLf3T5N7fEMCDeMIdSjIKR331wSfhQHJH
 FoE8nVdyNNQYgEEX+ElkoBt4O8PNFVwok/gJunLRRvy9xraU+xAteW5a6YOgvk90SMjb
 VVIHFOKj+bOLRd3qfai15unuwzTZRL/q9Zol0Mp29uclL9D3/J8FK8RLWylbG0+dyZXj
 tw+g==
X-Gm-Message-State: AOJu0YxBwnAq4cx8PcQQQqSZiLq1M004V/tGxN7C8i85Gfy678fxd9+f
 lww9oYfS/dNzBn96OH1wZpU9IMPd8ui9ZFn8jNBcUD+EFwTdJOd46+fyHeFyRJQ=
X-Google-Smtp-Source: AGHT+IEoGg7wHslqMsEwXWFvqafC3VFQIgCrvDu1FCptKqL/WqIdf+MwEqvNjnOJKY/EK7RoiLYMOA==
X-Received: by 2002:a17:907:2da3:b0:a8d:63b5:e795 with SMTP id
 a640c23a62f3a-a8ffaadad47mr2175007666b.3.1726480729350; 
 Mon, 16 Sep 2024 02:58:49 -0700 (PDT)
Received: from lino.lan ([85.235.12.238]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a906109662fsm292862966b.38.2024.09.16.02.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 02:58:49 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 16 Sep 2024 11:58:44 +0200
Subject: [PATCH v2 2/7] mtd: rawnand: brcmnand: Fix potential false time
 out warning
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240916-brcmnand-fixes-v2-2-08632f64c8ec@linaro.org>
References: <20240916-brcmnand-fixes-v2-0-08632f64c8ec@linaro.org>
In-Reply-To: <20240916-brcmnand-fixes-v2-0-08632f64c8ec@linaro.org>
To: u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Anand Gore <anand.gore@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.0
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

From: William Zhang <william.zhang@broadcom.com>

Backport from the Linux kernel:
commit 9cc0a598b944816f2968baf2631757f22721b996
"mtd: rawnand: brcmnand: Fix potential false time out warning"

If system is busy during the command status polling function, the driver
may not get the chance to poll the status register till the end of time
out and return the premature status.  Do a final check after time out
happens to ensure reading the correct status.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20230706182909.79151-3-william.zhang@broadcom.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 700d1122639f..46a4107a83a9 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -1011,6 +1011,14 @@ static int bcmnand_ctrl_poll_status(struct brcmnand_controller *ctrl,
 	} while (get_timer(base) < limit);
 #endif /* __UBOOT__ */
 
+	/*
+	 * do a final check after time out in case the CPU was busy and the driver
+	 * did not get enough time to perform the polling to avoid false alarms
+	 */
+	val = brcmnand_read_reg(ctrl, BRCMNAND_INTFC_STATUS);
+	if ((val & mask) == expected_val)
+		return 0;
+
 	dev_warn(ctrl->dev, "timeout on status poll (expected %x got %x)\n",
 		 expected_val, val & mask);
 

-- 
2.46.0

