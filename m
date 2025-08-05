Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE569C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 11:14:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C17C80548;
	Tue,  5 Aug 2025 13:14:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OFNzpTAH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7095580B9B; Tue,  5 Aug 2025 13:14:24 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7429801BE
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 13:14:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-458b2d9dba5so22780505e9.1
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 04:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754392456; x=1754997256; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3ZgwR9kTJB/daxtGoiEFKPvQujfBqKoxDcFHexAKzyM=;
 b=OFNzpTAHOYsvYQUbwY8PpUnGLcQiDwb6oXpxWFq/fF5ZW1ZQuZyZBxDpcJCOPo0aiw
 E4qnk+fgiws8AAd9Dc55YdqC84ePke83NM2OwyydhaIHoXA4ae0oaL9lpWXv7o3JNxE4
 ECanXCuEe+uCq+5u33N6qAzA4cioMH5SaXi3NMyR+T88eYTCfEpa0HLc292pgK0yZAsW
 LSpALEg0VDruaYRjnl8W0TPQuoGPlkgFf129MsFdMbMyV1ZobhbPcLgFg7F3Y4VqBQsP
 EHhanOMuRvTOpRZqMB8LMpgyS8KQMRqM6Lx5Z8c3PfJqDJX6bGRH27Rw3qXkOY5Dpyee
 yFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754392456; x=1754997256;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3ZgwR9kTJB/daxtGoiEFKPvQujfBqKoxDcFHexAKzyM=;
 b=XvMTDrFRpZ4gXlF04QsxR+QhT3caEwEgk5ylGaiZ/ZtLghHCktAp0Z0SVWmWxyD1ax
 DDw2XHTqt9toesLeKGVM45HEo+U6k6rNFwczZXaCtmuFJ/7FdtJoTVoNPSsF8Al8x4gm
 mkkq1v0MHxZcIJ3ArsNAFlGRVKVVLxz2rWMy5LtBpBJKDrT7zBpBVzpwyX0ucyF1xGU/
 1moCJ0urKJ6C/9h3RycqqrqJdP6JtcIGwlnVr+zpHqMxkUVVACeDBxnQAN9NQDnUDjb3
 ELr3Wu2wG/olLOxAkrx7Xcu6UkusF+BbFB+lQAYJOZ+C/LErViIoh+to0lmbXJSnYgft
 0K+w==
X-Gm-Message-State: AOJu0YzlV3sofpYEjp9J4TeYCcliCmvO/wd/+cVLxv54qoZETcg9uznb
 pzwF0aPI1aVLqwZI6GCS7ONELujOmImBXqg1gwqXIBtIXuofKDS0VIZvqLunSwY1cGzwknAXve7
 D9iR9
X-Gm-Gg: ASbGnctpHybAUrfglIkt861u1TMkGhEwH1txID7pG+N+cc0wa4OKiUTmGQl24FkWbCi
 Mv+a6iVX1fNPOQMww4IrIuOKU+hPzn7pYIqaIjStgzsDzBr+HJQwVIEUEoZtzUh2c59RohjVIhU
 FMCCFlCUQRiEd8bYXW9VfVOtjQIPNxP6jTl0QDNJI1nHj4ZY1o8ALW1nKb28mHA/0I1nM+ISgVS
 8frrDIRTwCREI8B9w7KMX/+4BcSYFb5EFAbX+Z+Gn5Q5jSpvQPMcQb3B81hh9Ua3uQMcdnWCcOu
 uBByXLR9FhYqiwEGj/e2keMQJo8NlzCscVPzyxKNCqgYW05uH7iBu92PeV+yuF0OlJfKexDN9nv
 SZAbMTydRng5YH8zXukN4Qfu+XQWMYlfTTa5ozJGEJsWbX+WHUQFln6UQPe3jLQ==
X-Google-Smtp-Source: AGHT+IEojifZpgyXDhBz0N4+6rkLuEcHy26JWcA8VOEnytyMBOW4pQwP2iyNiP3ovzsDkcAzSYV2kw==
X-Received: by 2002:a05:600c:1d0c:b0:456:1bae:5470 with SMTP id
 5b1f17b1804b1-458b69dddedmr99833235e9.8.1754392456250; 
 Tue, 05 Aug 2025 04:14:16 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:60bc:24e3:6dcd:9f35])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458bc1f62e7sm129462935e9.2.2025.08.05.04.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 04:14:15 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 05 Aug 2025 12:14:14 +0100
Subject: [PATCH] net: mv88e6xxx: Fix logical operator instead of bitwise
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-mv88e6xxx-v1-1-9e345d0d48b2@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIXnkWgC/x2NSwqEMBAFryK9NhDFT/QqMoskdrQXRukeJCDe3
 eiyePWoCwSZUGAsLmA8SWiPGaqyAL/auKCiOTPUum610a3aTmOwSympUAUzzH5o+s5B9p0VVI5
 t9Ov72Kz8kd/hYAyUvsj0u+8HJP6Y4XQAAAA=
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

In mv88e6xxx_port_enable when attempting to mask out the previous
settings of two bits a logical operator was used instead of a bitwise
operator. Fix this.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/net/mv88e6xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mv88e6xxx.c b/drivers/net/mv88e6xxx.c
index 557b6b2c8f6..f06c73c20f8 100644
--- a/drivers/net/mv88e6xxx.c
+++ b/drivers/net/mv88e6xxx.c
@@ -631,7 +631,7 @@ static int mv88e6xxx_port_enable(struct udevice *dev, int port, struct phy_devic
 			dev_dbg(dev, "configure internal RGMII delays\n");
 
 			/* RGMII delays */
-			val &= ~(PORT_REG_PHYS_CTRL_RGMII_DELAY_RXCLK ||
+			val &= ~(PORT_REG_PHYS_CTRL_RGMII_DELAY_RXCLK |
 				 PORT_REG_PHYS_CTRL_RGMII_DELAY_TXCLK);
 			if (phy->interface == PHY_INTERFACE_MODE_RGMII_ID ||
 			    phy->interface == PHY_INTERFACE_MODE_RGMII_RXID)

---
base-commit: 007610da2cca405ea7739fc120d90085be4b6ac2
change-id: 20250805-mv88e6xxx-f1f89dc9476b

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

