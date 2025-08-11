Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77701C87FDB
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 12:05:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0FAB832AD;
	Mon, 11 Aug 2025 14:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YSX7wqho";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9B73832BC; Mon, 11 Aug 2025 14:05:19 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51ECB830B5
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 14:05:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3b788feab29so2594340f8f.2
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 05:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754913917; x=1755518717; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kjC4GdQ6KVbIlmeAh5RNneNrQyIpqQ34cNbboRK/JzU=;
 b=YSX7wqhoaAVGu+pz0CtvgCxcAjbWCtCLdJ+C/ZEN9cB0sSiUkr6SgXWU0JxFStCgo8
 XMa0G1iK1p6dHaAHvNfEb42FoQdVH0Bstqc2iBky2RnFw/SUejjgmDUYyLkfWodaxEPO
 4jouH/Tm/WjXzRmRT0cx+B5i1lf2dyzT/gsQkUG3hiRhJ+gcgL2v4O/6muI24F/e2ORV
 kr1+tGrjK0ex9geOOxJKnDcWoWRnbyQ0hDjRSVfxDNxj4hCrm2vhrUDabggVTqT5/dPU
 0tJv0gSU8xbMAwvpVYEr8x1eEU6QyLDvaGzR+aaj6p5J+gR3ST+WymdaK6K+4TvJqN+z
 SJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754913917; x=1755518717;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kjC4GdQ6KVbIlmeAh5RNneNrQyIpqQ34cNbboRK/JzU=;
 b=sb6yhybbD0qxG1Gb12woJhg36JgRMo9yifML7R4JFS/3Tz8rvBc44xEi6zyp/urRdS
 O5z7a4SAg3mBusosDqfwesZl+vPeKRBBk34uj3V+7uevxkCgW9i9IvglCsXRrW86aR59
 QXjj2Pv90aYTxbz1/fQxTO2OKOZaAZC3b7Jy4Ms2dAuktSulCrnSw2q6Q4eweqJC1an8
 EK6459RLQkeWeg4O9jYe1GJCdph/jIrjw5duSErktKgr0x7ZaHt/DVMRG3Qlj6LieKnz
 4yQU9xpXz6KPlwn0DxQn8VfpqMVuNyIZca9oQCS7qjHOoAGwNnPFnyFsLKF+DGW2gMe8
 Dd3g==
X-Gm-Message-State: AOJu0Yw17fNhVGZEpZONbAEUrlnTgoQ0QG/ehXQFFQpHGxjwjsJA2nSM
 zu25ejPUtVISOwJnenm57TpkMHdYjqzr1qnSApjZNp5M4fnVMKCwoLek+gO8mjR6QpRnwMILk23
 r+GQ1
X-Gm-Gg: ASbGncsjWYX3rlaIzCCNehqG9UVJyJovXpx0ZofG5xsCB5xvqRXnKJNdFNfq3XvYvil
 rfytZWziejJuNlMIu9LY9/XQsB0s5RxgMYjJy8NWvnsc0ZhNn/ilBH5krYSz79EY2hLmeohi7wW
 r7FtAzTH1PKWdwaJk1SGJSuIdB2gcV1HfL4nAxdch9y9eyFNmnxmDA3v1Nk8l7DYK9V+jzNqKuP
 xLtwUYhpBOtqTngOkRtwE+3P+5cq12Ba4NUx09RP8+f2U+CUCvmlz50IwryC6a0vGEVDYIyEnvQ
 /N4lxTpr1kwcuJdSYbCUC93Lt4MwOr/iAitoAWEUDWtXZMseIt06Wd8HNVZ1SVkwgclhLBzQbMx
 bE5WwwGQ/SR9xHAz9Pud3uttaKeuWqqGgi+iLVuuvBMuW/Dd7WB1icK1oTiTgkQ==
X-Google-Smtp-Source: AGHT+IFF4TkYjyEACb2C/2IvgVzxm7io8DdRdlDL6+u9TR6T0RYiYHIzTQi98+bjA92aO3Sx2L8HnQ==
X-Received: by 2002:a05:6000:22c7:b0:3b7:974d:533f with SMTP id
 ffacd0b85a97d-3b900b502cdmr9229831f8f.34.1754913916347; 
 Mon, 11 Aug 2025 05:05:16 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:3e73:96b1:418e:3053])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c453aeasm41893634f8f.40.2025.08.11.05.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 05:05:15 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 11 Aug 2025 13:05:15 +0100
Subject: [PATCH] efi: serial: Use correct EFI status type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-serial_efi-v1-1-ca6050011a85@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHrcmWgC/x2N2wqDQAwFf0Xy7ELWC1R/RUTimtZAu0oipSD+u
 7t9HM4M5wRjFTboixOUv2KyxQS+LCCsFF/sZEkMFVYtPrx32af3xE9x3CC2dViwqztIwUzGbla
 KYc3Jh+xgzcOuSf/9X4bxum7TLOn6dQAAAA==
To: Tom Rini <trini@konsulko.com>
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

int is not sufficient to hold and test the return from an EFI function
call. Use efi_status_t instead so that the test can work as expected.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/serial/serial_efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/serial/serial_efi.c b/drivers/serial/serial_efi.c
index 5733eaaf9d4..d3cd4de34a2 100644
--- a/drivers/serial/serial_efi.c
+++ b/drivers/serial/serial_efi.c
@@ -33,7 +33,7 @@ int serial_efi_setbrg(struct udevice *dev, int baudrate)
 
 static int serial_efi_get_key(struct serial_efi_priv *priv)
 {
-	int ret;
+	efi_status_t ret;
 
 	if (priv->have_key)
 		return 0;

---
base-commit: 83ce0b483c1680cb39565a9d91c6ef113a309c38
change-id: 20250811-serial_efi-e40053cd0939

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

