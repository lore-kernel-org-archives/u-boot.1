Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E7BD41C3F
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 13:01:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 787A78959A;
	Wed, 13 Nov 2024 14:00:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="Fq0FDf5Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59A3E88FE5; Wed, 13 Nov 2024 07:27:30 +0100 (CET)
Received: from mail-io1-xd61.google.com (mail-io1-xd61.google.com
 [IPv6:2607:f8b0:4864:20::d61])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE54889515
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 07:27:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=dregan@broadcom.com
Received: by mail-io1-xd61.google.com with SMTP id
 ca18e2360f4ac-83b4e8f3bd0so6093839f.1
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 22:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1731479246; x=1732084046; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7C8051b4GCiCwVu2edon8opBeEMn+vN4K9nbYm24qSA=;
 b=Fq0FDf5Qv29Yud5pMZmQ/KfWqwZH7eQJQ6PQuGu3Z07abWL1YiA1hh1ZKGoRijPUup
 7zxjHejIPYMT20ESn7Do4ZR68WO0txvFLtHNNjNRhRBxzbM9JUyM7NtOSFGDYh89fYks
 ctkOwKyQpzGY8tbUWP4BiKD9YH3DNA39RJHfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731479246; x=1732084046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7C8051b4GCiCwVu2edon8opBeEMn+vN4K9nbYm24qSA=;
 b=uquBDv9neZuI+AVEM96Gii9mITYScvKz4VKMJkyaCihZA3SQ3J1vsSJWYDraYk5tdC
 X7mlwHzqYflYqDHQyjNb21keAWBSklV/FBnPidQ38P4HUJtBkVCx5k6Vlg00U6Ky/3bo
 e2XOM1jASCSSKpegpSaY7Jh/9PAMXkrWHrY74ledB8K4BoN9QLlyr3i2TddLZ3apxKkf
 2nmyWIAJoC0aTw3RBUlUFdd1mkXGSfOZVWTq4e9AC3q8iVZtylRkjCssyq4TPvZHuUJj
 6ybc3BEHQ/ahzOgd7yc32KxJH0DyPqPZ1qGTVLHophFJhJLyXp/k6dVw6MXGJp9rn7/m
 KvGg==
X-Gm-Message-State: AOJu0YxUvkWStulNYrk+iAhNf5JKIkLQuZWhkuLvq9XXwP1hRHX976lU
 a0xDDoKnLxM3uoej1X8JSS3hMaO/IR2rQyGUazTicSuc/3xwvoN0YaZbDGT/UchwISudpSMy20/
 gMaDXgLl7YFxoiKeAU+Dm1vzbCEF17xBkJ9WBhYUBwO0gd03WOvmGmKu8iPcQKWuk3id2WWWZFG
 m3m3lnsnBKMkiUmi7h6TRJilB5ntXo4TyOvMxfqlssuEF6rQjSKjXpwj6Wjfq3gC3cw2PY
X-Google-Smtp-Source: AGHT+IEr/UTRj4rL8/uevT/kFjKOul3EtBIXux3P9p5qcrqhj0JytDf/otyqSKMQ6Wrg2V0Dn9em2P8FABBw
X-Received: by 2002:a05:6602:3fd0:b0:83b:7a7d:5cbb with SMTP id
 ca18e2360f4ac-83e032911fcmr627326139f.1.1731479246506; 
 Tue, 12 Nov 2024 22:27:26 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
 by smtp-relay.gmail.com with ESMTPS id
 ca18e2360f4ac-83e13584b67sm87580139f.31.2024.11.12.22.27.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Nov 2024 22:27:26 -0800 (PST)
X-Relaying-Domain: broadcom.com
From: david regan <dregan@broadcom.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>,
 William Zhang <william.zhang@broadcom.com>,
 Kursad Oney <kursad.oney@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>, Tom Rini <trini@konsulko.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, dregan@mail.com, dregan@broadcom.com
Subject: [PATCH v2 4/4] mtd: rawnand: brcmnand: update log level messages
Date: Tue, 12 Nov 2024 22:27:15 -0800
Message-Id: <20241113062715.2872-5-dregan@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20241113062715.2872-1-dregan@broadcom.com>
References: <20241113062715.2872-1-dregan@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 Nov 2024 14:00:05 +0100
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

Update log level messages so that more critical messages can be logged
to console and help the troubleshooting with field devices.

This is a port of the upstream Linux patch to U-Boot.

https://lore.kernel.org/linux-mtd/20240223034758.13753-4-william.zhang@broadcom.com/

Signed-off-by: david regan <dregan@broadcom.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: Anand Gore <anand.gore@broadcom.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 7fd9e1855d1e..ef492e6db320 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -1071,8 +1071,8 @@ static int bcmnand_ctrl_poll_status(struct brcmnand_controller *ctrl,
 	if ((val & mask) == expected_val)
 		return 0;
 
-	dev_warn(ctrl->dev, "timeout on status poll (expected %x got %x)\n",
-		 expected_val, val & mask);
+	dev_err(ctrl->dev, "timeout on status poll (expected %x got %x)\n",
+		expected_val, val & mask);
 
 	return -ETIMEDOUT;
 }
@@ -2032,7 +2032,7 @@ try_dmaread:
 				return err;
 		}
 
-		dev_dbg(ctrl->dev, "uncorrectable error at 0x%llx\n",
+		dev_err(ctrl->dev, "uncorrectable error at 0x%llx\n",
 			(unsigned long long)err_addr);
 		mtd->ecc_stats.failed++;
 		/* NAND layer expects zero on ECC errors */
-- 
2.37.3

