Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B009C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 11:31:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6910C83678;
	Tue,  5 Aug 2025 13:31:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GKARoWfT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E59BB8367B; Tue,  5 Aug 2025 13:31:33 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17F4482F00
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 13:31:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-55b978c61acso3704813e87.2
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 04:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754393490; x=1754998290; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=r+tH93whXw7KgbTlEskfrEwDU2GBhsYv58ME7SnG7hw=;
 b=GKARoWfTJkl25/SlOZ8xN1HXf78JTeGnEjYIVn3j832Unt+hDnK2+lAGR/y1+nsm2d
 s8kv0A9rxkWYW/9xzhoVJex0LdyFPTn6pv0Pb70xM/gPFs09Epij/GNbDTgEbGhw9YUk
 8PN9pICZW5wiA1JOS10oPjBkhjqdeFWo2O8970WDicqaUBapEJX1l1Z2Oo2IkUNptDlk
 8X+6UFzX628ooaTiccGI2As8EXWjPxnCtFbJXEt5Qj8KpDicHtFZD66WU5NiDiui+UyG
 GO1tDIAyVlCiN42yhfn/0kuuLjivVNi3NXBf8Y89LVgXSqngxizepsxXTh+pT92+acSP
 A7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754393490; x=1754998290;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r+tH93whXw7KgbTlEskfrEwDU2GBhsYv58ME7SnG7hw=;
 b=WELhPmOck3nO9POm/JeqaEXiifR34RqPoWTqJwjwc95+w1TSi7FnD87f7ovZJQKS9x
 cmaWr1Z55LnDwaAa6oWkPmaiD96rwp+8OnLOkh+mDaG545oTkMPc8+SlTje+sIkACuFA
 +f3HHUJ2ju5s/BmFgC6kN6Hhn7udlhqoHeOqQjdIVNMs8QT6HjxHiO5bWbOdXp+kWrei
 OMlaFxKiEIHemeIm9j/3X6bP6bFd7fKvN7jHtl2lMsNCMhaseUbcDYyVq8bdW5Me74BY
 /Hcrgr2unHYWexQJOrreN4UicaS7uNOvi4DFwqu+dCszrbKM4tZWEbr/zK6nbXaoS7np
 JQ1w==
X-Gm-Message-State: AOJu0YzKICif9TBc4KXiYYr8S3pkKImYFX/FtVayQ3PidNwDQkXfPEJe
 3uDvUcW7Qo05baIIIVGdy1Bjrpm6tL/Q81yd2QYx+FhX4QJgglY3M3UQEvEsZgxfon2TYyrUqPb
 YhNZr
X-Gm-Gg: ASbGncuRlTLBb4bPJy4gNCl8o/zOVpxhFrHS9IOkRhbhNentPAoOL8+BnG14yxMIAkk
 yR7Ko82aWjFOKFN9a2t8xOj3v2K7bYyBb/d0xDbxfl7/eJUziBsy5U8uPd5LAXfli5Sx2eTIgQo
 8qtQ399EzMwbBzWJX2K4ZxGJeZTt92PqU5RajzJLKPrwxcCY+6Ilur3OBMDdxMI6esgUGVTHOjz
 5Uh/5Vv74QM0fMfNzLZ6De7PbY7LUjSCukvz2Gow8oARDYHXTiarFqcBZkHvlSxsP0DtynfyBYG
 qlY6xin1S6iZWYk6tYgh4CHeY+vQ2A5RYbdfc2W3PPy5TdXlooagZu1QTK0ramO+hBYgOYwy4O5
 +wgWfLlooX9uHlphkvK2KaCZyXN0BqBr2rlza5aV4mhCDaeXU3qA=
X-Google-Smtp-Source: AGHT+IHVLxljDBBTLAhcJzUbELj/0onskoRTykjM54dg1vGDh9X7z8kjYPcfytANNTCnAldhbDRzMA==
X-Received: by 2002:a05:600c:4f0d:b0:43c:e70d:44f0 with SMTP id
 5b1f17b1804b1-458b6b33065mr93939385e9.19.1754392988332; 
 Tue, 05 Aug 2025 04:23:08 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:60bc:24e3:6dcd:9f35])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589536b3b4sm243483345e9.3.2025.08.05.04.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 04:23:07 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 05 Aug 2025 12:23:06 +0100
Subject: [PATCH v2] net: fec_mxc: Set error code on error exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-fec_mxc-v2-1-3f99e8a722b0@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJnpkWgC/2WNwQqDMBBEf0X23BQTFLWn/keREpONLtRENhIs4
 r83ei1zejPDzA4RmTDCo9iBMVGk4DOoWwFm0n5EQTYzqFLVZVtWwqF5z5sRtW0aZ3QnbSUhtwc
 dUQysvZnO/qzjinwGC6Oj7bp49Zknimvg7/WY5On+jycpstB2Q22dalX7/JDXHO6BR+iP4/gBj
 8VlObgAAAA=
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

In fecmxc_probe if a timeout is detected when resetting the chip no
error code is set before taking the error exit. This could lead to a
silent failure. Instead set an error code.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Changes in v2:
- Use -ETIMEDOUT instead of -ENODEV
- Link to v1: https://lore.kernel.org/r/20250804-fec_mxc-v1-1-1ed9b5df2828@linaro.org
---
 drivers/net/fec_mxc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c
index 54b08482b91..9ac72d25ef6 100644
--- a/drivers/net/fec_mxc.c
+++ b/drivers/net/fec_mxc.c
@@ -1344,6 +1344,7 @@ static int fecmxc_probe(struct udevice *dev)
 	while (readl(&priv->eth->ecntrl) & FEC_ECNTRL_RESET) {
 		if (get_timer(start) > (CONFIG_SYS_HZ * 5)) {
 			printf("FEC MXC: Timeout resetting chip\n");
+			ret = -ETIMEDOUT;
 			goto err_timeout;
 		}
 		udelay(10);

---
base-commit: ae5711f881100f856ead1e76832c32b92dba93c7
change-id: 20250804-fec_mxc-5d77fca91d41

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

