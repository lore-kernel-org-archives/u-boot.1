Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12097CA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 11:35:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8338F832DD;
	Tue, 12 Aug 2025 13:34:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xR2rbnr4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDB708334D; Tue, 12 Aug 2025 13:34:43 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13D78832DA
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 13:34:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3b792b0b829so5204873f8f.3
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 04:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754998480; x=1755603280; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OoVoqaPdnZaOql4XHRSkU1Jv5ZbwTtOb84P6MaxwaRA=;
 b=xR2rbnr4lz8npDjgqRRDOm8DIMUfowVpeldS3C3mKX9BqhY9qCRXGGAkHR+um5ujU7
 E16wXhTKtLILzu+ia3axlkIsUBh9qd1PZEQg0DRjZDCdssm/i2SL9KnzGnH64eccryn5
 gTPlSqpTxKShtfuFPb++eNjckM46Mjw1PbOdSlM1c78hHGwXh6wADMPWmZ016Y79vKM/
 bzCW54MIBStp6diI6d8a8Q96vOlkZCkEs3Eaf7cqVC6PdMSx5HO/rWlw7/Qptp6bEnWo
 FIZJIi6DnyM9j1iitr+IS9P4Y8xR6EBn+v5J8F5ByU3e+obP3+XBiZu0K3ALUsUexS2Z
 Z9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754998480; x=1755603280;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OoVoqaPdnZaOql4XHRSkU1Jv5ZbwTtOb84P6MaxwaRA=;
 b=D1VrxLavD0hcCIzAu6S7EQEPCr/xoe+T65dOK+6QMtW+sueaAxl4pfxe5QmiIHXDHv
 xrbN2WLF7RYw000kM5MVbesK7FpXdkb27CVIz5BaIS8YI73YlaJ6/JXWRDiPlIZoyYN1
 I3ntc6oPKKeV+5rTK0ftpPVlClMO0PTKX2bhlydTk8pYc74r6rJMGsUnkIOZTKJW8+Cs
 I/U18kC5ncRJAIsR4eN6o4Q4qyW1rrqFRxYcF8ZI+pzUv8XexVkTDWF8N2H+Ohh7PwZ0
 rPLDbm6n86BjavISRgSAtdR2NXcDl25Uk5cOyYuhvLbt5Sq4/57I4bDdLUd4bSluMYvH
 h+ag==
X-Gm-Message-State: AOJu0YwMBJ2dGlhSCoGRGNiOWldawyHFUoVCM4QWo0+iwnKFrlGUXZnC
 5HdpX+qvaADlBLD3O2JWGhZh/SaTnfjmvSIFFo+trW20nmX/6eoh9HlPlfyfqWXvU1Q=
X-Gm-Gg: ASbGncsNOdrU5YMCd0Tpw+jSfjYhXHJ8h3reW+2C6atbZinu7eHssHB9h7KmB0YgZFh
 WEjJRLG9KLLmE3ughyVdsCR0bP9sZKpGaG9o9U83yCVBuaB1+nFKmzF4d1ARvO7o63SbZW+eSpi
 i1y0ii7Nfp4tLzNBPivoslZHU7xx4vTYwBNRu+MXV+ZUUc7ATXUyHnD9hjxLM9zTm8nSy61+02T
 RTTn3gCr0ygkVU2ODi8JnmpNj7RCqTxLMI3ZOu9Yy+ZSFVjAFgASLE0z6zzFRWbYlkuawNhkcpR
 pgdDxNw0kNtEllVLf2INtzyhxJLevHTiPU19v2+gn1RWli3LgERUCy/IzwCkf5Bk9z7GhuUgmEE
 0FZeEjyj6710p4Y+tU+oQNRINmbjvqy/gR+X77pLy1NgNRyaLaI4=
X-Google-Smtp-Source: AGHT+IGu07YrPoY8VgM0cxdACcUZHQpGw39wouVW3+4wgfUvCwF0cEW80j+B9HwTBlPQEE4RK+xMeA==
X-Received: by 2002:a05:6000:420a:b0:3b7:9617:c9d6 with SMTP id
 ffacd0b85a97d-3b900b7afe2mr13018347f8f.45.1754998480390; 
 Tue, 12 Aug 2025 04:34:40 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:97a2:1bc7:9f2e:6519])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c485444sm44524027f8f.66.2025.08.12.04.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 04:34:39 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 12 Aug 2025 12:34:39 +0100
Subject: [PATCH 2/2] spi: cadence_qspi: Do not return unset error code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-cadence_qspi-v1-2-0d693d810145@linaro.org>
References: <20250812-cadence_qspi-v1-0-0d693d810145@linaro.org>
In-Reply-To: <20250812-cadence_qspi-v1-0-0d693d810145@linaro.org>
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
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

In spi_calibration if the low range fails to calibrate then the code
attempted to return the variable err but this has not been set in this
case. Instead just return -EIO.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/spi/cadence_qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index 9edbfaa821b..d8d9a4056fe 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -142,7 +142,7 @@ static int spi_calibration(struct udevice *bus, uint hz)
 
 	if (range_lo == -1) {
 		puts("SF: Calibration failed (low range)\n");
-		return err;
+		return -EIO;
 	}
 
 	/* Disable QSPI for subsequent initialization */

-- 
2.39.5

