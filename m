Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2B0CCFA13
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 01:41:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55C8383E8A;
	Sun,  9 Nov 2025 02:41:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kyQZcpm1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 479F783EA0; Sun,  9 Nov 2025 00:23:56 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5690383E4C
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 00:23:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cingel.marian@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-64168416cddso96028a12.2
 for <u-boot@lists.denx.de>; Sat, 08 Nov 2025 15:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762644234; x=1763249034; darn=lists.denx.de;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Clc3ux+Ku3pbmeYZ6je5jQ0jIPUtEofU1CftwWnhAg=;
 b=kyQZcpm18nNLfmiRb8W+ZaBvae3LwtpvD+wgNSzjNYXvvAurOmJ9kxYpXyOe61A+v8
 A8OpQwDH+d8DpfzeUP0WCpp0mcgHSiSOcYMfDG+STW/AOJRHziLZ7K6mDyiD3NWyAt7k
 5hjJKwy0JjCm8CAb8dOsBIQrqLFvTmD6rCNGoTDdfMMA2JLoPIaqG4ZSbJCH5++P+BXf
 9ddJY7okUfkqHvABfYNsuPryEOB3gqF+4Deh4BkLPkXe9akkZy2Wa20mNV906v+GAXfd
 JGcWuDPM5CN3TPSIzhDgTWybzc2CrjWbdDJWcsCQqi4i2b+9TcVkhSF6kCd9th4fDCs9
 Porg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762644234; x=1763249034;
 h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/Clc3ux+Ku3pbmeYZ6je5jQ0jIPUtEofU1CftwWnhAg=;
 b=lL3Wt2kD2UimB6qaAXx28PrHxeSI3Xd7TRczllUgZ2L2SOarHLhyQdbZXhtoPD0ij/
 gLKSnTbuLkICt81iCqJEUjYwyccE4vX+6Xxq93PBm6kq0sGYkmyRNDXXWp4HR7cSrAhs
 YqEd6lqEtbLUlGNyGVJccUCUFAwJMvZQPXYRu+Zx3vAZ8189TSiYB1kq2X3rzkyQtySO
 Y7/xEywNYbbWzELaNjCPM3mjPga4vmo2RHwLpGR3/XXdn2Etl3RbTFHC1cKM8+AnzcTt
 hDfJHWtD8dS8FcEjq3SmZFCn3ZVmiHgRYaIvw/8tEaThFstIeDpTFhhXbUAs8878BbzT
 EIkg==
X-Gm-Message-State: AOJu0Yyv1XaBY54mu6a7kT6hZoKJovJm/pUzna3r1mY8+n7uFdy+E1Rc
 UUvdq49QfwJknlzzgFdHVfe8hmvZ/ZNwsKRmqhULCzH6rIUpUHj/8huQVrD6K2m6
X-Gm-Gg: ASbGncvnCWfBWM5fkqm2VaItryVsAI4xZoixdSOzU8AoPzcZFsJUX3jHvXUR738VKs8
 jjKEzTEi4yYiNT0EKPfdFL3Y9E2By3fc5PeRReBDs+ukgkvKFTNzXlTFObR0QOMynM3qa6iyC63
 GFK5nECKrDMW44Rm8XwgVWdaU/zt2zDaVEX0XuT4vtlwYCa8UmMTYk4051hJl91T7sGa0xxuDLf
 4IeRIqT7rpscjoCC9IwMpZXeo8G188tXh9MXXBwUN266aHNlHnFX9pu6zbjn2y5xbZQxPh6sLjE
 ebB00kOBaKV3U4MLpEF2/03mRXwl4SmtZ0+AjjnGHG2t8FT1TArzDyvDjmuzM6PmpKZX1p9kxwT
 wm+FbBon+31Ooid4Zd7JgEkWmoiMTHgg1OUXBnTx7GcBLMQZppRHJVAaJ6wqo7qI12iD+dB1YqM
 DVnD+2u7PczYQfZ/PIuJM=
X-Google-Smtp-Source: AGHT+IGvAeYUQZ9GP/GmZky5MaK9QXqTAfHOTedB0rxddqtOE+LeqKlq3BzVg5gefkvxpDnQO/dFfA==
X-Received: by 2002:a17:907:6d0b:b0:b72:ae08:a4d3 with SMTP id
 a640c23a62f3a-b72e05ec763mr211547466b.9.1762644233650; 
 Sat, 08 Nov 2025 15:23:53 -0800 (PST)
Received: from risotto.lablan ([178.143.191.80])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bdbc9656sm656019166b.7.2025.11.08.15.23.52
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Nov 2025 15:23:53 -0800 (PST)
From: Marian Cingel <cingel.marian@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Marian Cingel <cingel.marian@gmail.com>
Subject: [PATCH] board: ti: CAT24C256WI-GT3 require min. 5ms delay (tWR)
 between write/read
Date: Sat,  8 Nov 2025 23:23:25 +0000
Message-Id: <1762644205-58930-1-git-send-email-cingel.marian@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Mailman-Approved-At: Sun, 09 Nov 2025 02:41:53 +0100
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

 Otherwise the custom-cape eeprom (at adress 57) reports NACK which results into
 "i2c_write: error waiting for data ACK (status=0x116)"
 and terminates further scanning.

Signed-off-by: Marian Cingel <cingel.marian@gmail.com>
---
 board/ti/common/cape_detect.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/board/ti/common/cape_detect.c b/board/ti/common/cape_detect.c
index 0bd4a38..88fa6ae 100644
--- a/board/ti/common/cape_detect.c
+++ b/board/ti/common/cape_detect.c
@@ -9,6 +9,7 @@
 #include <i2c.h>
 #include <extension_board.h>
 #include <vsprintf.h>
+#include <linux/delay.h>
 
 #include "cape_detect.h"
 
@@ -43,6 +44,8 @@ static int ti_extension_board_scan(struct udevice *dev,
 
 		/* Move the read cursor to the beginning of the EEPROM */
 		dm_i2c_write(dev, 0, &cursor, 1);
+		/* Need 5ms (tWR) to complete internal write */
+		mdelay(6);
 		ret = dm_i2c_read(dev, 0, (uint8_t *)&eeprom_header,
 				  sizeof(struct am335x_cape_eeprom_id));
 		if (ret) {
-- 
2.7.4

