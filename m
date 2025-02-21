Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD1BCC021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 09:59:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FAD680FB9;
	Fri, 21 Feb 2025 10:59:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="W4lNZqmT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95A6780F5C; Fri, 21 Feb 2025 10:59:20 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A779780F88
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 10:59:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 204463F735
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 09:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1740131951;
 bh=qSU4DI5j3Q35ybnspk+upZMhKsH6xh1K5KMBLUPeq9w=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=W4lNZqmTYE/SGQXXKW4SYoOEOTua8MUcQgg6cJQgRoTIT7BxtKIWCZjsg5tLduHHR
 byx6r6/bhN1OkLWD51VzccQG+vjIkM8JMrHCzx0ehGuq5k1dJqmeSPbnWnPKKyH1zz
 BViNIsyJPSkaXCw5zYQEqVUNqrypEto6KECRGoN5x3o7bF9mYLYdZ6/yB5DdVSh7pl
 6XqakHszUWt5KZzaJfczG/6zjCKlUvotj0B1aSp2CZI+XuMEbXmvYjV1Ngx2ENTIcp
 mrYtZSoxFIzkPgrJsV3/N7HKjHpfHwgEUnH8HkK+6gaRFxeQb/Ujk55dSFuZ1WwYdh
 lA1RXUrWt2Pbw==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38f44be93a8so989700f8f.1
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 01:59:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740131946; x=1740736746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qSU4DI5j3Q35ybnspk+upZMhKsH6xh1K5KMBLUPeq9w=;
 b=foUaps1bSbvbfLGv/tV/qw/hNJN4ePfSidFn1wif5uu8pAGO1S91RvTA/h6C1lla5u
 mmcqMrVlTbEreUX03cbdNEMJ4I8skaamHdCi/O/Wx2QJWu4NIpoHbAiQ+d8AXVbaMA2b
 5/CJL0lzo/x9zcNRj/hhYg1mpN4j7CbR9jCY+vJhuWhrdxBOl9jfyhloetPPVcD4u2la
 lq2X8b2QytlrrlNb2wtiplOtY/vu6G+C9lJyw8u0IHgmw2NqSy5RUAxnWDDTgx9b7vhS
 vQZG9yWWhfZqtB6ABOOAAWSL1uAC5s1BKOwR9jL3O16LkZ+hMlfEfN+VBPeVKUKy14bW
 Em1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+eCVjgDF/1BqA7puGtetoeON9um3HInp0Lfd0KHByL+bOikvRWz6fak6mkKeDl2apxS6S9fQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yz3Fp4IRZLO+MaZgTCWKLWHpecuuq1O9WagsZFx2KiKT7NEU2rp
 SSeA3sTdA/thMFl8iTIGOKLQdfaLYsjTGkDh3CUg3mR+Qgs/uFhDmeWA/cZYbSUAKAQkDEsqLTV
 ebKKGz18e5AxI5VYEX02lCtzWt2+g/JrHy4AraiRGTZEKbdLw1kEXwhUifxdcnLb50Ys=
X-Gm-Gg: ASbGncshPjaGkqHVoQt+9CaSSamtV2uGUlgFL+vZzlqsow7aYwVHlTuuttdyE/zPIVV
 tNWmGAVa+eM0aaQyWqCx5l2WpHvoCOxHOzBYRO0Hux8f5UsukwHX3LuPWO4u5RwStAcoFIoCYnu
 I1QceHsRl3hPT8ikoxZJaVBndYBzFJbmOfzWmqrTomOWPNP7uebG0teL/q0FlFP450IkEas9FAt
 91F688GFOkpyJzxGF42L4Z+AHL7le80voUhamgTVTf10Adq/L+R3cMz2rrgCkN3HsFEk/M5whfn
 jDt4cieHxtvOvLXTUaluVejwzc/MTo6xwgnOFMD0ZELNeXxIyrU5ha3qFwsVtfOcOBolO3nfeTP
 xKA5hgp8JcUMRWsSI1g==
X-Received: by 2002:a5d:6d0c:0:b0:38f:3b41:c944 with SMTP id
 ffacd0b85a97d-38f6e7548aemr1973034f8f.11.1740131946026; 
 Fri, 21 Feb 2025 01:59:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF34rm3HuhUfViGLK6BYzoAEEEK2M2103pSxkAOG0xi5jqT0iNz8htjeku3ZlDS04LFMThyhA==
X-Received: by 2002:a5d:6d0c:0:b0:38f:3b41:c944 with SMTP id
 ffacd0b85a97d-38f6e7548aemr1973014f8f.11.1740131945699; 
 Fri, 21 Feb 2025 01:59:05 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f69b3ca41sm3287961f8f.27.2025.02.21.01.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 01:59:05 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Simon Glass <sjg@chromium.org>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>, E Shattow <e@freeshell.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 "Leon M . Busch-George" <leon@georgemail.eu>,
 Lukas Funke <lukas.funke@weidmueller.com>, H Bell <dmoo_dv@protonmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 3/4] board: starfive: spl: strip off 'starfive/' prefix
Date: Fri, 21 Feb 2025 10:58:55 +0100
Message-ID: <20250221095856.36530-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250221095856.36530-1-heinrich.schuchardt@canonical.com>
References: <20250221095856.36530-1-heinrich.schuchardt@canonical.com>
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

The configuration descriptions generated by binman contain the vendor
device-tree directory. Instead of adding it to all match strings just strip
it off.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
v3:
	no change
v2:
	no change
---
 board/starfive/visionfive2/spl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 22afd76c6b9..d63eb1abe6a 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -118,6 +118,10 @@ int board_fit_config_name_match(const char *name)
 
 	product_id = get_product_id_from_eeprom();
 
+	/* Strip off prefix */
+	if (strncmp(name, "starfive/", 9))
+		return -EINVAL;
+	name += 9;
 	if (!strncmp(product_id, "VF7110", 6)) {
 		version = get_pcb_revision_from_eeprom();
 		if ((version == 'b' || version == 'B') &&
-- 
2.47.1

