Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 618E8CD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 15:48:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5118784825;
	Mon,  8 Jun 2026 17:48:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SPAfb+XC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F167A8466E; Mon,  8 Jun 2026 17:48:11 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93B2084841
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 17:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-36bdda53d99so1929589a91.0
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 08:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780933688; x=1781538488; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7CEQKmeneKA1Wv+QpiRH2CuFABBVMmcrOZO4ixqQa08=;
 b=SPAfb+XCzUw26PJX7V7K14KJQ2m0gSkpZZQPg2jqoTCpX2xXRuF6McIWbfdvHwgXR2
 R2xS2EKReZ4es5GEMezuA8GrCKEgf4TXzhPylS7AJDtDoBiLYG/dIOPw6FBX0S6i0MM6
 M+DDc5WZujtKEOTLqYNiWCdl7BNPrYpZWUf978nGWcJbQqgmt7uwnrsEiQ9RgIAAJ7f0
 yuXjnI0ilOXw10LOK2xEonuhDdf93lCUuks0czrrsJfvyUym6FAWAzOHO9gZbaUiYckN
 9kpuDcEZ6CzFXcYFi/m2x0pPoi8DDmSi6XWPAfQF3VGpOpftnz8zwQwulkVRuWoV/ppP
 944g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780933688; x=1781538488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7CEQKmeneKA1Wv+QpiRH2CuFABBVMmcrOZO4ixqQa08=;
 b=BcyJgBvQcN8qxxeYSeXp6WSUE3YRXw5sapdNGW120MnMx1I5n659gQ02gzH6CFuvB5
 ZPBkoh2raC/MH7xAPvuoxy2p/U+ire/JRGJ10ILy3Q43NTpgK8P02BEYrGGXRUIPiRC2
 G90YgSYL5XlogJfBcDpurQilMRe9RntZKsCM9x2rLJCml53NQ+eltMRkNB7UPeAaXn8n
 hmWlaFfq/BVjnhAMdiF82o1jnHox8cf/eCAcQLd1BckwBgeZH9qUqwVUgES304ZIsACA
 sZYTacvLn5jXozIv2K2DFpXEVOjVUe35f9g4yb03jiH1TITtp7MucpmkXwAXHnIpw0KJ
 AZFw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8r1nMhP8rpRvaVVV9Mj6zWgX2Sfh8UWtpfCn4h5alS4RcrFGLxpciTUncHN82hbFzzfNYLtOA=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0P6uz/JNMYISQDj2++GocZlEDvNiXsb5OfpAmjNJVkDhYCYja
 OJI1gw4Jpg/ukGzpzhPXWUIMuCVvX0fnpFiEJRD2TbDZ75HePZLREiXI
X-Gm-Gg: Acq92OHrStRT1y8qtEm/ZYVdhA1a3FFX+XOVzB4kIoFzD+IEUYaCLvC+yLQ8xwxjp2f
 5iyvFK8AeMvvk0QbfNBz/ZMiMwkCIk34B66G4wXi43nKBze6Ezhk2tfXyteeEKLQr0Kc7voupyt
 ViS66s2j0f7M0YsCnvVLeqNLvW+dSkj3bt2dqHakMS94FWR6uP0w9c5AmIxKMQJLF1yjjhNkeq+
 W8RZLDyH1co/ySb+19R4vRGd6ihkl+yeEhsgryVv5d6oML3Nb66HwFLLcon+sfkyuGruhl2QGqF
 TM4Lrbtq8svxO5DZYxbLo/OYeix6uCPVpz4It9aBArOxAe1MVqjusYWssVmGRxm1p6B1cUKJ8Vi
 mL9h9bOwEbKW1vxsgHr3n/y23P1ogxoMx/FXlp9kqq3joEF78XwJJL9Ug3eEZuDSgpG2fiK5oWc
 odxesPAz9yWLDL7MXJSmd69JpNCc5u7XrLMPh4h8xpg6CmWLbw8UebxON0G4RPlR0O7LZYx/0CD
 ZFWK74XbYUW8VASi9aeiHhn9HwsNKOflQ==
X-Received: by 2002:a17:90a:da8c:b0:36a:d6dd:9fee with SMTP id
 98e67ed59e1d1-370ef7cd49emr16715020a91.12.1780933688026; 
 Mon, 08 Jun 2026 08:48:08 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (54.109.81.34.bc.googleusercontent.com. [34.81.109.54])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f6bf827f1sm19778621a91.3.2026.06.08.08.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 08:48:07 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com
Cc: naveen.osdev@gmail.com, u-boot@lists.denx.de, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 2/2] rtc: goldfish: Return error when device address is invalid
Date: Mon,  8 Jun 2026 15:47:49 +0000
Message-ID: <20260608154749.1190658-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260608154749.1190658-1-visitorckw@gmail.com>
References: <20260608154749.1190658-1-visitorckw@gmail.com>
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

goldfish_rtc_of_to_plat() currently returns success even when
dev_read_addr() fails to find a valid address. This leaves plat->reg
unset (or 0) and defers the failure to probe().

Return -EINVAL immediately when the address is FDT_ADDR_T_NONE so the
failure is reported at the of_to_plat stage where it belongs. This
aligns the driver with the recent fix introduced in the goldfish
serial driver by Naveen Kumar Chaudhary. [1]

Link: https://lore.kernel.org/u-boot/vgwnt6mnls3lf3zdm6mz5siztzkvppte4ykszbvifjzukvmksf@maaxe5agqpim/ [1]
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/rtc/goldfish_rtc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/goldfish_rtc.c b/drivers/rtc/goldfish_rtc.c
index 4892a63f8d8..652eec7dd0c 100644
--- a/drivers/rtc/goldfish_rtc.c
+++ b/drivers/rtc/goldfish_rtc.c
@@ -80,9 +80,13 @@ static int goldfish_rtc_of_to_plat(struct udevice *dev)
 	struct goldfish_rtc_plat *plat = dev_get_plat(dev);
 	fdt_addr_t addr;
 
+	plat->reg = 0;
+
 	addr = dev_read_addr(dev);
-	if (addr != FDT_ADDR_T_NONE)
-		plat->reg = addr;
+	if (addr == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	plat->reg = addr;
 
 	return 0;
 }
-- 
2.54.0.1032.g2f8565e1d1-goog

