Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4D5EE0211
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 07:11:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D6A7891C4;
	Wed, 11 Sep 2024 09:11:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="or6zx83L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FCE5891DA; Wed, 11 Sep 2024 09:11:35 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8098A891B4
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 09:11:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a8a6d1766a7so197825566b.3
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 00:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726038692; x=1726643492; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cy0AelE8X6/ImwZyMOvnLyspFv+MmXcjl2xKIRLZjow=;
 b=or6zx83LwwSfqBIAtqQ62KRpd3Yj65aL2pKoLVmLV+ZqfxihXVIa74oBGUGTGCwDng
 gTApGUQuGpMwx+8MeG4mqGyNhPAuq1Owu82++edWmiX126uqIoZZ4a0eAKfu+xh/wAOG
 ztenGlGnGcJ1/EQsMIKntpNSJlhm+AxBZMDEcaQutt6CrZHFFk/1RbiLb2qjsYRYIeYJ
 k18w1rQsz2B46zHm77318Kb0kUaLqeFTU8suwdPDlWAca3v6ITTmmj87GA0oiyn7F1oJ
 SR/gB4Wxa+a3EScXrRr0If10Pij7UhNDWx9m7oFDQyiFhkURnIbB7FBJ1UwiiznhtJVw
 vYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726038692; x=1726643492;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cy0AelE8X6/ImwZyMOvnLyspFv+MmXcjl2xKIRLZjow=;
 b=gk70JzBiS6qvZZJvHHA5JJoMXlyJtHhZSsASaCvuWEiYIwnfRt3PYeMgpKgeR9+eNF
 QD+5IhqG9D2W6DWnLFunW3Zcs92VbFZYuJczPVOsbfV+l8v2QWPXHPzeh+5qe1gjjv8Y
 MA90oHgV51x4msrx01rwiWFXBUpSNvpyk8tnfH7iweE/FFwF275uDlv5WczMw1mPZPy5
 5EE98mccA6y3bUZbDtlnOqFbZaKEPEAvzR0nlUx84fXJktFrEcoQTtQ0P/JLWmv0p4XD
 QuSM1mkDGaQpoTyUzpPQtGsJXxDGC/S0LVee3J1D6AfYYM3YG4dzKCyNHc/iA0E7Sxd2
 nfmw==
X-Gm-Message-State: AOJu0YzUL48g8qJ79bJOz49rbFP4RgkxGLT3u1SV43lMZ9I/l+d+n8Ru
 6Ssb40pb/Dl3CNFpU5fwRCpxu+y5U345jiC5gPaz6Ai1+2IlcinhIgWxU/a2JuQ=
X-Google-Smtp-Source: AGHT+IHh0eiO7wFrgl9XD4fC14+/RUGF1FJdQlt5bv6KDTtkNwAwXFA5kb48bKFBcILLqurtmErUVg==
X-Received: by 2002:a17:907:94c5:b0:a8a:1ffe:70f1 with SMTP id
 a640c23a62f3a-a9004a46f0amr172951366b.50.1726038691781; 
 Wed, 11 Sep 2024 00:11:31 -0700 (PDT)
Received: from lino.lan ([85.235.12.238]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25926ee8sm580523866b.50.2024.09.11.00.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 00:11:31 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 11 Sep 2024 09:11:13 +0200
Subject: [PATCH 2/7] mtd: rawnand: brcmnand: Fix potential false time out
 warning
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-brcmnand-fixes-v1-2-be112a20aaf1@linaro.org>
References: <20240911-brcmnand-fixes-v1-0-be112a20aaf1@linaro.org>
In-Reply-To: <20240911-brcmnand-fixes-v1-0-be112a20aaf1@linaro.org>
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

