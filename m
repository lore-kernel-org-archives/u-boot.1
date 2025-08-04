Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613FAC87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 15:32:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A210483F87;
	Mon,  4 Aug 2025 17:32:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oXsz2rJR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59FD083F87; Mon,  4 Aug 2025 17:32:56 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8559583F56
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 17:32:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3b783ea502eso3482856f8f.1
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 08:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754321573; x=1754926373; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aR2tqo79ZN5P1uuAAYmWUiYFrjdPv1i+FrkRW4o5R3g=;
 b=oXsz2rJRnOfEWjpqegH8cBFOSp4ukg14hdpyaOBmHhALqEDam2EtBKkHvPc1prPcDp
 o3+ZukKlQnALT8PSlUPAKk1zbCXyYU2VIvZ5oSOPzlcWJk4duFAGlTpWzO5NBh1FyuaC
 1uvqWra7bH7DjU8DhmOw+q/rvYnmWPBLAey/orodow0ZQ2nU13SZ+uC9lDD0JagOCU5P
 GUduPmHj2g10/H6szRad9dEG7vxPKkHI8B2jv0kUnyma/IJ0PYxZ/NzM/ojaKzf8CvKP
 xgpxGV5AV8WbDSc0Ruw7bedHUmXXCnm9xF+yd4z3bsCo5l57zPdUHs82rcJIm+Oec2rq
 ecjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754321573; x=1754926373;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aR2tqo79ZN5P1uuAAYmWUiYFrjdPv1i+FrkRW4o5R3g=;
 b=jCwantVqAT/IpnmPoObdpLCVaTGkU1JDGH9ZMkzs+hfQULEda71pyWD9CGFRo8UL/I
 ljB8E1tVcYMKK9ZqzK6/Fb/chC7d60PcrTG//XJU3bxxbLFUZB8/RUuX0UDD7ZMxQToT
 2+RUojdbogmR71Ee2sMJjzp+LJ4aQ5fQ2Y+tUqsHKvt9tQkcHdS7gKKOlxBhnmSCuE/d
 /cYUN3qs3EIbRIcwrph8uK5PIcS8zA4+aw5IlxaB123HparhZVIfQovUjS3B37g1FbZj
 FLqA+y2hY0/WaF6iyg9nuwVtbUZrY5fXgVaWhGHzYhuFiRl1VoQyJwjYgkQhGBE7+qkB
 Jk/A==
X-Gm-Message-State: AOJu0YwH9qQaVv2ui2jzD7yWi7OcQZRACLthZinwbt25jEalTkMekAT3
 VixvaEqS4zW1rG94op9aSXmCeKIJJIv+hAN7L9xWwGaeOXZ9NlzGL67JvkPpIw9vlkgjfI5+Olj
 iXfqj
X-Gm-Gg: ASbGncu1ykj7LxSu6G1+th02wWGkfS0OZtqwmAkRA3alMKkXLIFH01exX+u6LVZUPrp
 tcnA8gzmSEBVRx5LI21HJBmql+RYiFGsr0z0qb9zkGNx9niYGzZ5zx6sq5Jvvb7fC9vaWNl7m4I
 86VwmH/kA6s1N1T067eXZnbw2614Sl0qNt+W0/1PUMKzcO4lnMM+61Rskct3QUtc0+2mAs8CgNh
 ycv0MslV9oTSwcX8L+KRS06RJtADJ1N+d+8SWz8on2nmsmCd46IWOx+qFf6U77XP3t+l4jbgJhM
 0Ij/UCobvZNRPC5cgZRFAQ2yvIhBWHcUWDxy8Oot04UTemZM50pnkesAQ0yZXUAG1e+tUVxsKXL
 GwhseqLdEIyL2vH3NLjZ5PXiZELO2F4ZlU2KpOmnqG76WgAYk20U=
X-Google-Smtp-Source: AGHT+IEmSGzIquQqM49SV+87JHB3ckoIITpxyOVDR+nzOgv4jov/hsF6mlEonWd4VbRvmI/vpFngLQ==
X-Received: by 2002:a5d:620f:0:b0:3a5:5130:1c71 with SMTP id
 ffacd0b85a97d-3b8ebc3743cmr39897f8f.0.1754321572790; 
 Mon, 04 Aug 2025 08:32:52 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:1ba5:34a9:feb8:a948])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e04c7407sm6050858f8f.13.2025.08.04.08.32.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 08:32:52 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 04 Aug 2025 16:32:51 +0100
Subject: [PATCH] net: e1000: Free temporary buffer on exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-e1000-v1-1-2b181911e8a4@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKLSkGgC/x2NQQqDMBAAvyJ7NrDRFEK/Ih42uql7aCq7IoXg3
 xt7HGZgKhirsMGzq6B8ismnNPB9B8tG5cVO1sYw4PDAiMGxR0SX0phjXP0YCKG1iYxdUirLdtd
 vsoP1Frtylu9/MM3X9QO6jJ1BcAAAAA==
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In do_e1000_spi_checksum a temporary buffer is allocated but never
freed. Add code to free on exit. Also refactor the code to make the exit
code common.

This issue found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/net/e1000_spi.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/e1000_spi.c b/drivers/net/e1000_spi.c
index 1e830b99f1d..33d38b57824 100644
--- a/drivers/net/e1000_spi.c
+++ b/drivers/net/e1000_spi.c
@@ -472,6 +472,7 @@ static int do_e1000_spi_checksum(struct cmd_tbl *cmdtp, struct e1000_hw *hw,
 	uint16_t i, length, checksum = 0, checksum_reg;
 	uint16_t *buffer;
 	bool upd;
+	int ret = 0;
 
 	if (argc == 0)
 		upd = 0;
@@ -493,14 +494,15 @@ static int do_e1000_spi_checksum(struct cmd_tbl *cmdtp, struct e1000_hw *hw,
 	/* Acquire the EEPROM */
 	if (e1000_acquire_eeprom(hw)) {
 		E1000_ERR(hw, "EEPROM SPI cannot be acquired!\n");
-		return 1;
+		ret = 1;
+		goto free_exit;
 	}
 
 	/* Read the EEPROM */
 	if (e1000_spi_eeprom_dump(hw, buffer, 0, length, true) < 0) {
 		E1000_ERR(hw, "Interrupted!\n");
-		e1000_release_eeprom(hw);
-		return 1;
+		ret = 1;
+		goto release_exit;
 	}
 
 	/* Compute the checksum and read the expected value */
@@ -513,8 +515,8 @@ static int do_e1000_spi_checksum(struct cmd_tbl *cmdtp, struct e1000_hw *hw,
 	if (checksum_reg == checksum) {
 		printf("%s: INFO: EEPROM checksum is correct! (0x%04hx)\n",
 				hw->name, checksum);
-		e1000_release_eeprom(hw);
-		return 0;
+		ret = 0;
+		goto release_exit;
 	}
 
 	/* Hrm, verification failed, print an error */
@@ -524,8 +526,8 @@ static int do_e1000_spi_checksum(struct cmd_tbl *cmdtp, struct e1000_hw *hw,
 
 	/* If they didn't ask us to update it, just return an error */
 	if (!upd) {
-		e1000_release_eeprom(hw);
-		return 1;
+		ret = 1;
+		goto release_exit;
 	}
 
 	/* Ok, correct it! */
@@ -534,12 +536,15 @@ static int do_e1000_spi_checksum(struct cmd_tbl *cmdtp, struct e1000_hw *hw,
 	if (e1000_spi_eeprom_program(hw, &buffer[i], i * sizeof(uint16_t),
 			sizeof(uint16_t), true)) {
 		E1000_ERR(hw, "Interrupted!\n");
-		e1000_release_eeprom(hw);
-		return 1;
+		ret = 1;
+		/* goto release_exit; */
 	}
 
+release_exit:
 	e1000_release_eeprom(hw);
-	return 0;
+free_exit:
+	free(buffer);
+	return ret;
 }
 
 int do_e1000_spi(struct cmd_tbl *cmdtp, struct e1000_hw *hw,

---
base-commit: ae5711f881100f856ead1e76832c32b92dba93c7
change-id: 20250804-e1000-bb3f88d134a0

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

