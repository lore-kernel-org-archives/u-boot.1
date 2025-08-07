Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73406C87FD2
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 05:33:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 468DE84401;
	Thu,  7 Aug 2025 07:32:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TwEOx9iS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94910843F2; Thu,  7 Aug 2025 07:32:52 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67D3F83BD2
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 07:32:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-31ef50d8d57so488869a91.0
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 22:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754544769; x=1755149569; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AmdZWhBvisZ710e7zyHQ48HiVJfUbw1Ibbvradh1ZMk=;
 b=TwEOx9iSUUGaYdQ8YH09303izvTFHHiDUOeGFoTSn4RAU9zOoU3L0oqa7VcWp2OFwf
 OdlisgH7KlaAAu6iIJeyBYb3Q7PNVA+0SpSt+jw3gq60nKcSsAUHalKp4J3gSga9WbBy
 rEOqTzegoJ+IlZ2rOzcFpKYWCT/yoI8WziTkFIOJ7ut9sK51N7zT6aRhyWERBoLMnQzm
 KBPVaNrj0Hw+xZQcXuH58ycH6hNTTGfdpyiV2vvmq5E4JBzX/qrw4dzp7qVbSwHFEV32
 B9ZhGAB156TsG71FY4E1gdf9ZXPX+oqBb7Zqi5iIj40UhjlE7JG5Hc4k0wgJHYfHe4n5
 ERFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754544769; x=1755149569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AmdZWhBvisZ710e7zyHQ48HiVJfUbw1Ibbvradh1ZMk=;
 b=gxW8PqDUbbC1fdy+eyxIx1/a3YOWCiFrEfhtMEMl+YccFtcZagHakVUn+ehX/cO28j
 L2DL0l5Y+Op/mYQfkaGwqGUKkuMbcCuJN8u43k0GW+zSY4iZNAO6Qrzs2yfBE9MRatfG
 061Wv7hWBVJ20DN2ynyunnI/UIcPida92yLLunEo4Ahj091cj6b+Nv1Zgb8hXRSR4ZCQ
 u+6Zoqr0ZHJC5nHH1NW72rPwAdxf+oDKghszkD4b8Xcdue2HEEY2bdIpdF7wJRhAkqGX
 fnynEGot94NL8nYZXx81zEJNOOJxfANYKhK6HRjq4cJ7oAOlDzYLfR5VSxCwywPdZskc
 LxOg==
X-Gm-Message-State: AOJu0YzXCIbbqM0Tzht2xLLGGXdnC2NceaND5PEhJJUA4T/SEN9JC+1n
 gec+hfR23YxCTbwu4JxOSfKwPs2eiefOXQCanzXN8nV/4OZZKXuEXQz1
X-Gm-Gg: ASbGncv/B89Y+mC1xXSKWCEWESK7pJnTH8qEby+rkhBzk0bteOqHs39v7oENY+n7Zi3
 hye5RxSctI4d88jZ2GJVaaTnKalrF3fQY6Fz7dmtWgtPbHifE/3IoVBDT91SGCVIJ+vIjS7pmvb
 d5DaxD0XmY3Un9L+UevAw8hhQf4hiefTJlu3fli7yspxYSmvpcM4iBGe6BUUwtEoHHS9S/xcvJV
 +VZif6HkkwUQEJKSIW+MOW7hdJO+8Ve5JGxURFupSg4rqIYh6AzDy6QrkCoMg/Qadem+DwJbrvs
 /pXoXAd6B4crcG/SqGmmPiEODTsHI9S53EuKo0Pjx0zSl+NMDrwaAOz6fhEUEfThgFtklvCkkqy
 MlSSU3+DS50JamYnWjdeIpkLfT6KPUokDRQ==
X-Google-Smtp-Source: AGHT+IHNn57+kH35sc/kvzctyax2AAJJvmR92/FLxdn3nvMFJ8bBF10VAFmSVR9j4k3SBGW4hBwMhA==
X-Received: by 2002:a17:90b:314e:b0:320:fda8:fabe with SMTP id
 98e67ed59e1d1-3216756c600mr5580550a91.22.1754544768795; 
 Wed, 06 Aug 2025 22:32:48 -0700 (PDT)
Received: from cs20-buildserver.lan ([2402:7500:400:60db:2e0:4cff:fe68:863])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3216126c98fsm4384084a91.21.2025.08.06.22.32.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 22:32:48 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, trini@konsulko.com,
 YSCHU@nuvoton.com
Cc: u-boot@lists.denx.de,
	Stanley Chu <yschu@nuvoton.com>
Subject: [PATCH v2 3/7] i2c: npcm: fix consecutive dm_i2c_read/write error
Date: Thu,  7 Aug 2025 13:32:20 +0800
Message-Id: <20250807053224.2169557-4-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807053224.2169557-1-JJLIU0@nuvoton.com>
References: <20250807053224.2169557-1-JJLIU0@nuvoton.com>
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

From: Stanley Chu <yschu@nuvoton.com>

When doing a dm_i2c_read followed by a dm_i2c_write, the subsequent
transaction may get npcm_i2c_check_sda error because the module is
still busy in STOP condition in previous dm_i2c_read.
Always check and wait for module to be out of busy before starting
an i2c transaction.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 drivers/i2c/npcm_i2c.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/i2c/npcm_i2c.c b/drivers/i2c/npcm_i2c.c
index c64752e1467..bff0d04f1a5 100644
--- a/drivers/i2c/npcm_i2c.c
+++ b/drivers/i2c/npcm_i2c.c
@@ -34,6 +34,7 @@
 #define SMBCTL3_SDA_LVL		BIT(6)
 
 /* SMBCST */
+#define SMBCST_BUSY		BIT(0)
 #define SMBCST_BB		BIT(1)
 #define SMBCST_TGSCL		BIT(5)
 
@@ -479,11 +480,17 @@ static int npcm_i2c_xfer(struct udevice *dev,
 	struct npcm_i2c_bus *bus = dev_get_priv(dev);
 	struct npcm_i2c_regs *reg = bus->reg;
 	int ret = 0, err = 0;
+	u8 val;
 
 	if (nmsgs < 1 || nmsgs > 2) {
 		printf("%s: commands not support\n", __func__);
 		return -EREMOTEIO;
 	}
+
+	/* Wait for module out of busy */
+	if (readb_poll_timeout(&reg->cst, val, !(val & SMBCST_BUSY), 1000))
+		return -EBUSY;
+
 	/* clear ST register */
 	writeb(0xFF, &reg->st);
 
-- 
2.34.1

