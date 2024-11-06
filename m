Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DA8D29FA5
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 00:53:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC4B3891EB;
	Thu,  7 Nov 2024 01:52:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="hz2p2Yhq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E1B088CD9; Wed,  6 Nov 2024 22:04:06 +0100 (CET)
Received: from mail-il1-x161.google.com (mail-il1-x161.google.com
 [IPv6:2607:f8b0:4864:20::161])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0763E88E26
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 22:04:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=dregan@broadcom.com
Received: by mail-il1-x161.google.com with SMTP id
 e9e14a558f8ab-3a3ae6ae20dso201335ab.0
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 13:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1730927043; x=1731531843; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=68L/EjcuPoltvTRm9BWcytkRoSvcCfRHwoc8W/vzhW4=;
 b=hz2p2Yhqkpj5iMxNXTTQ4JPCxsAOurPkOyiEvxVhEYB/WoQ76Ylne9ZyGGMB0OJ1i0
 eD3FR8BS/ayl9hsST+rtJ3ZsVJHMUMXrz0x3IVhgRo1djFyYMHL6drhKTrkWTFvn8W0c
 WeZPssjbj5ugHoSYB9mpu3EqLDf5c1GH5SM+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730927043; x=1731531843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=68L/EjcuPoltvTRm9BWcytkRoSvcCfRHwoc8W/vzhW4=;
 b=cF3b4OHyUU3krnMHA7ulb5TD2t8eReb/bm5bAj0pMNAsohMz0G/JjupNthQwjl2gvL
 9eiKSvaCBCNjgdcxkwLCoqzZZzZlkrT9aKC/hGfM1dpMA5Y81p5oOnYrMeMpeZVShYkX
 /W9Hov1QRDAuaD/Wp9FNIMdIfyx10v8VYwrtOlq8dEAfbQ8Q8N26+oVl7jmuq3EUFrmk
 VQqBx3NvcGfhEy50Unnl2v+jB/l627FIdWgBBKUWmvCGCbQZt7HL7w6tawqyuUgJmvf2
 HuJSRwBa+yhAXYB7J9urykiVYOWIe0Rp8Tqxmz6hKy1DKTzD1NlcJaxSbIkatq+thGzT
 zK3w==
X-Gm-Message-State: AOJu0Yw0zQnEN1a+knVRaMSSXnvNUr5EbM3863mYPGp2x8PCovmzUTlM
 cjzQD9+M9KT2jyZdSoDNiQ9cdxTjjR0NjlzMJIl+ZrVsTrNSzg0ttszeXMQBbGU4u94zqiKKBt7
 cXEJ4/QZZ1IuCVoYdt3nzxCUc9n0G8gF2IRVlnhkx/wDJQa1W4knu+0cvwyDRTK5RArefU0EumG
 1salpwqxAdPq+/wybb9ObRQOIGWKm4CM2ZByB5H7GmRLH5j4HwIaeD3C/Pq8tZ10uyu1oB
X-Google-Smtp-Source: AGHT+IHHYhtxb/O4XvP2pCbtETUDdUe+c2BHWjgsNHVaT2yDNe6DdN9ePRJsg6Fmvcd0mSPKCntVgbapCflH
X-Received: by 2002:a05:6e02:152d:b0:39a:f126:9d86 with SMTP id
 e9e14a558f8ab-3a6e83745c1mr3737605ab.0.1730927042754; 
 Wed, 06 Nov 2024 13:04:02 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
 by smtp-relay.gmail.com with ESMTPS id
 e9e14a558f8ab-3a6a9a29b37sm8165005ab.71.2024.11.06.13.04.01
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 Nov 2024 13:04:02 -0800 (PST)
X-Relaying-Domain: broadcom.com
From: david regan <dregan@broadcom.com>
To: u-boot <u-boot@lists.denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>,
 William Zhang <william.zhang@broadcom.com>,
 Kursad Oney <kursad.oney@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>, David Regan <dregan@broadcom.com>,
 David Regan <dregan@mail.com>, Tom Rini <trini@konsulko.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 4/4] mtd: rawnand: brcmnand: update log level messages
Date: Wed,  6 Nov 2024 13:03:48 -0800
Message-Id: <20241106210348.218507-5-dregan@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20241106210348.218507-1-dregan@broadcom.com>
References: <20241106210348.218507-1-dregan@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 07 Nov 2024 01:52:42 +0100
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
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 6eb2fa65cc1e..b33585ecab75 100644
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
@@ -2019,7 +2019,7 @@ try_dmaread:
 				return err;
 		}
 
-		dev_dbg(ctrl->dev, "uncorrectable error at 0x%llx\n",
+		dev_err(ctrl->dev, "uncorrectable error at 0x%llx\n",
 			(unsigned long long)err_addr);
 		mtd->ecc_stats.failed++;
 		/* NAND layer expects zero on ECC errors */
-- 
2.37.3

