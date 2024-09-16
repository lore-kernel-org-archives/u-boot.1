Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89234C3ABA2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 09:58:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C50A188ED1;
	Mon, 16 Sep 2024 11:58:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="v9vsFZq6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33A6288EC4; Mon, 16 Sep 2024 11:58:50 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1A378899C
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 11:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2f761461150so38974421fa.0
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 02:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726480727; x=1727085527; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dkUKt3UdwEitX0O61G7N5qJz6iQqsTpeb/1nStpbrCw=;
 b=v9vsFZq6fqy5vrkpJopt0aHVU5AdHA+tlzMdnM+wiVgJWm6t9/f5QKqBladCtPXWoP
 hc1S2iLsG6WU6BNTDY+/PoSGF4fRZFLjqkWsuoPq8BWqdqtlpxcbEOuT6KRWnpzCTwiZ
 XE5FiLUM17prBFpckxXCkgANZOz5AlgLA77z8TE9Akw0uLYFZsHvUVD/cdKBiSCGWFC5
 C32t2snZMCR0w1zVjXNPJaXM1SSTaxAMZpS6mbAa4iSfI5NYoamEjB0SkEL+wwifoY2J
 im9uAUb7YoSDU3Q5o84a6ZvS5pgpt96H7U0ClmHjiECtjydi6Drg50FCnVP7m4tMLbnn
 Rc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726480727; x=1727085527;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dkUKt3UdwEitX0O61G7N5qJz6iQqsTpeb/1nStpbrCw=;
 b=JHza9AmIS39t/41T4piz/VF0+jsQyjPYtE3Lldo2mAeSrYpPAqsTZL9o0ufbXjfy30
 Tj2eS41knWMKekQCfi/2+tNtPV6/yzMEf17awDSg/QIG0otcHTzvWYz1AotBz685Yi36
 tIQAsMF64ZBwdZl8VTYjhiQdSIgoFFn2jv4PREjdgSbX58w6A5kZebUM7i5HidTfSjAY
 Q4n/AtZi0AWWsDU1ltsc6EoW8oAsZuKW4vodfxGPHkgNp+AzCMFBKusrgNEDz4DxFfJV
 o4PTN/j52yJomILlNdnmBO2SVoeetCMSFvIFhLRS6B9LZxX8zlBrb8RJ6lwfPkIIyEBn
 ytnA==
X-Gm-Message-State: AOJu0Yw0bwIUo6ZhPLDUYT6zKg66ZMhfiLg/zF7BourIvEkQ2xFi/wKp
 AIQvO1JvOjH6EYzIRl7SVNWAuXTyTni0K3ACcD2UBdA5zDEtF49j6uLtW0tIedE=
X-Google-Smtp-Source: AGHT+IFc5wutDEqLQVRyyPSzxnqVtuBmkubR2hZBIOnCtazuqL5RRyMQ+SXU/Qv6OoZwQqBGg71Euw==
X-Received: by 2002:a2e:84a:0:b0:2f7:5777:cf14 with SMTP id
 38308e7fff4ca-2f7935c342bmr44304471fa.35.1726480726654; 
 Mon, 16 Sep 2024 02:58:46 -0700 (PDT)
Received: from lino.lan ([85.235.12.238]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a906109662fsm292862966b.38.2024.09.16.02.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 02:58:46 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 0/7] mtd: nand: brcmnand: Backported fixes from Linux
Date: Mon, 16 Sep 2024 11:58:42 +0200
Message-Id: <20240916-brcmnand-fixes-v2-0-08632f64c8ec@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFMB6GYC/3WMSw7CMAwFr1J5TVCc8hGsuAfqwmnc1hIklYMqU
 JW7E7pnOe9pZoXMKpzh2qygvEiWFCu4XQP9RHFkI6EyOOsO9oJovPbPSDGYQd6cTSAfzkfXWjq
 1UKVZeTuqc+8qT5JfST9bf8Hf+je1oLHGM6IjZ4kGvD0kkqZ90hG6UsoXJTDSs60AAAA=
To: u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Anand Gore <anand.gore@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Kamal Dasu <kamal.dasu@broadcom.com>, David Regan <dregan@broadcom.com>
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

These are a number of assorted upstream Linux fixes to the
BRCMNAND driver that I have backported in an attempt to get
BRCMBCA working with U-Boot (still not there).

This patch set lowers the hamming distance between the Linux
and U-Boot drivers a bit as well, while we deviate quite
a bit it is still possible to bring fixes over thanks to
exercises like this.

On top of this I have a BCMBCA driver which works fine
albeit with some complaints about ONFI:

NAND:  Could not find valid ONFI parameter page; aborting
256 MiB
(...)
=> nand info

Device 0: nand0, sector size 128 KiB
  Page size         2048 b
  OOB size            64 b
  Erase size      131072 b
  ecc strength         4 bits
  ecc step size      512 b
  subpagesize       2048 b
  options       0x00104200
  bbt options   0x00060000

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Augment the write protect handling to also support the bool
  "write-protect" property in legacy DTS files.
- Fix a mistake in the use_strap DTS property parsing.
- Tested successfully with BCMBCA driver (will be submitted
  once this is merged).
- Link to v1: https://patchwork.ozlabs.org/project/uboot/list/?series=423357

---
Linus Walleij (1):
      mtd: rawnand: brcmnand: Add read data bus interface

William Zhang (6):
      mtd: rawnand: brcmnand: Fix ECC level field setting for v7.2 controller
      mtd: rawnand: brcmnand: Fix potential false time out warning
      mtd: rawnand: brcmnand: Fix potential out-of-bounds access in oob write
      mtd: rawnand: brcmnand: Fix mtd oobsize
      mtd: rawnand: brcmnand: Support write protection setting from dts
      mtd: rawnand: brcmnand: Add support for getting ecc setting from strap

 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 209 ++++++++++++++++++++++++-------
 drivers/mtd/nand/raw/brcmnand/brcmnand.h |   2 +
 2 files changed, 166 insertions(+), 45 deletions(-)
---
base-commit: a7b83ade98e0f567c82d168022e12d3ebef1f318
change-id: 20240911-brcmnand-fixes-dabd75230a63

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

