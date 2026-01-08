Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57187D185F8
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:34:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AACD784180;
	Thu,  8 Jan 2026 14:33:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VWMiTe2H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 626868412A; Thu,  8 Jan 2026 12:17:30 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6E3B84127
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 12:17:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b8427c74ef3so473042566b.2
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 03:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767871047; x=1768475847;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1FOVZ46I4+js7BgM0blW5m9M2wEPmOqbx5CxfuMuSN4=;
 b=VWMiTe2H4bfM4JmUtlKSo1I225XF6yCmgq/2kih0t2hxED80KybjL4mxuWXkyaLoul
 PVucKLzsjrcqDJP/TD7o1nzl7LPm/+CX9hcifgUb5w7ZAnUAbP7XLRZAGSfeb0UxIhTA
 UTT7xRwAIK69Jt+JSIF4UxfqVjw31AN16qeiPmd5sPLkZztByKx17bkboOtFOKiIjYA/
 yyBLUceFdzrtZ1hTJJJ6KZWEbkKOkrsoofBHSMXAQwMPhnNtiZDrWyqFKqMQMpwvyuJD
 HDfsDeBXpOLWBbWz5fiBYSNSqD3F6YVN/fKqHDvCd1PwuYueq5g5Y5p5O5XzcA4KtKQ8
 9QiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767871047; x=1768475847;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1FOVZ46I4+js7BgM0blW5m9M2wEPmOqbx5CxfuMuSN4=;
 b=KvAzqRe26ZQ0rjBISAKuJLQGM86aiCz7CSJovP+FNIfvzNVvQU7QjZhGRzruMOi44Y
 jfKAxJ2pxW1x7jsUJ8VgOaLtjNzIzdssNlpgqHrkoWJjVDpqxhclkXl3jnCCYDyhvcmY
 mh6PVDI8oyfbgsVqxYPTyWt7rTeE+KUGGSwGItlIUoTvHVtUBam93FG2H7Cv4LdIz/JO
 kikaR4ZuIabUGCx8j76w/xFR18YoUVuct/ciIWH/Mz0yz334jWyKacTcubej6whqygeM
 PsqjEfmMt1hF/9Ae16nogaDz5g/w6warv11bFK/SblRmXxnXV3FAWf6wYNLS/xyEsG9m
 4d6A==
X-Gm-Message-State: AOJu0Yw/dT93QUM7owb/IwKyE9U5bJrVlXkB06KynpOMct97wHzqg6FP
 2S8dXaS+MOYaXn1r4wG6QPhBVJGsPYqNVYLQR+GP6XnQ6lRKFKlB8v/mFB5uhqWXIUo=
X-Gm-Gg: AY/fxX6H4pCMfpnwfcwCiRxoKWVfIdDcrYyVW2TxY4imaRqsRyEam2Sf0vdbEhZn9PR
 F7+OXGvwOLFJhvMGwZUlfJ2lRLja/7kJMqdn8wFEJpIBfjqaoFtrDjyc5xyOpLcwX/Mus/bWHCX
 f3L2E8b64DmxpLZ26TsWyIZ1QciHz2jcCDL7BIUxYSa+wpbzAzDAwiwyNsX8bZ5hhNCipt6EHTS
 GV/Gmb6D5Xy3szwwdn6Pl7DGd2dnfE1x4StuUdIzcEwzmyDkwLHA37AsxSD42HJQC5HvPo9MBCw
 UJLozj5H7YWQ0KtvKGpA4eC4X8pb7MvEqhxH5e5CwoRza2XX2xgRZUSESp8BMMMQyaH+S+s6HVm
 JxMofFee7hhaDYJRFZtmmzHilQa8aduuGZ2NHs2BZSyetJZI2VzU2ITAxidkvIMZ7U3XYjjwHNv
 BI5O+TE1C1
X-Google-Smtp-Source: AGHT+IHO35E6RRxC8oj745/6Rc11VOCFyvgam42C8wKWECxkAIWkm0Fc6cRw2FrVKDK7BIaWkpAOZg==
X-Received: by 2002:a17:907:7b99:b0:b7c:e3ad:cd17 with SMTP id
 a640c23a62f3a-b844532ae68mr536337366b.32.1767871046955; 
 Thu, 08 Jan 2026 03:17:26 -0800 (PST)
Received: from localhost ([2001:4090:a244:872b:a354:65f3:92a0:8de7])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507b8c446esm7404235a12.6.2026.01.08.03.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 03:17:26 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 08 Jan 2026 12:16:28 +0100
Subject: [PATCH v2 2/6] dm: core: lists_bind_fdt: Replace found variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-topic-musb-probing-v2026-01-v2-2-2a47c6e0e73a@baylibre.com>
References: <20260108-topic-musb-probing-v2026-01-v2-0-2a47c6e0e73a@baylibre.com>
In-Reply-To: <20260108-topic-musb-probing-v2026-01-v2-0-2a47c6e0e73a@baylibre.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1238; i=msp@baylibre.com;
 h=from:subject:message-id; bh=nVp0FqTWZZDY0ukve1WG/zztU4MLlZGwF2evT+9Q0Lw=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz4SbITJMyWTeFZWBuW+GZKbWz3uoZK1X+uhRNv5n79v
 ZZF9tu+jlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZjIjZMM/xNZW/7qfOd0E5//
 xqHAtq1A3l92Yexvti8JEhlXjHX4rjL8FT1Xc+W44MX4O7pbfzE8nnzTW7K1QPlGgdGRQ9phnNv
 0uAE=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 08 Jan 2026 14:33:16 +0100
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

'found' is only used at the end of the function to print a debug
message. No need to maintain a variable if we can just return 0
immediately when a driver was bound successfully.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/core/lists.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/core/lists.c b/drivers/core/lists.c
index 52ba6c7bfa007b660b854de62c97ad3c1761f1a5..9d1ca38212ee7f53b8894f964f096611c8ec20a5 100644
--- a/drivers/core/lists.c
+++ b/drivers/core/lists.c
@@ -204,7 +204,6 @@ int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
 	const struct udevice_id *id;
 	struct driver *entry;
 	struct udevice *dev;
-	bool found = false;
 	const char *name, *compat_list, *compat;
 	int compat_length, i;
 	int ret = 0;
@@ -275,14 +274,14 @@ int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
 				ret);
 			return log_msg_ret("bind", ret);
 		} else {
-			found = true;
 			if (devp)
 				*devp = dev;
+			return 0;
 		}
 		break;
 	}
 
-	if (!found && ret != -ENODEV)
+	if (ret != -ENODEV)
 		log_debug("No match for node '%s'\n", name);
 
 	return 0;

-- 
2.51.0

