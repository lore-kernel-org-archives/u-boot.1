Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA42C36010
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 14:05:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3494829A0;
	Fri,  4 Apr 2025 16:05:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IXf8g7i5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7176829B8; Fri,  4 Apr 2025 16:05:50 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81AB782991
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 16:05:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6e91d323346so21327506d6.1
 for <u-boot@lists.denx.de>; Fri, 04 Apr 2025 07:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743775547; x=1744380347; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=k79RqYK3dF/P5SVQ5dKpVY18CIUunVemgIJ6kEoGSDQ=;
 b=IXf8g7i5taAR4Ua4B8xtIN+XqvCVraegI9hwqaCay5FPYDUBtG4+J3I7sLKG+Y/lRL
 rTzW9k/c/wD5xQpW6ZSIVgRwgzzKY9UcRmF+ghoKB5iFRQfN+Nc/RhKIC3W5K75FXZfh
 2rysjKyTlZ8gXZVTjCDk+3ART8/4g1W9KAM7Jol/8uNz/hn0e73YTszW599pMhy3JW0M
 0iwqISIU9AVftuOnexAcWzVvNjCISrHnctEnaBajKQyggou6m3x0h14cgqhqeyYOx8+M
 QHcsTIX0NZCod3dtRQXBconR0XLsiADyAypeK5pmBnEOIpDoYzxUfbZJ4M2IQfD3QMBO
 8BLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743775547; x=1744380347;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k79RqYK3dF/P5SVQ5dKpVY18CIUunVemgIJ6kEoGSDQ=;
 b=LbqCXXAZrOpnfcOez8pigPvsYRlQoth+mg7lF+vheDasB3HmNqOj6tBIpOh9ChvLcp
 hZmclcF2jev/MY1X96C5rDu2jJiH7rEJkfQBPT6Yec3XZDcbJjmNDY1ZN+dAbmWavlJc
 l73+GaDG7n09gsYkTXzktQlT51TfVAQP1ylJNcCI2tg77b9OfKvwPZGY2PTO3UU8KgK6
 t2keXR7vodKHWyLp3pelmUKCJ1a0S4cNCZjcjrQDWhuK0Ll1Ast+iuY5k9C/RDjhw0g8
 pAs9Go6RvywU8mz3d0B3ZPi8UrqRu2HmM6sQIpNBhIXNf+ynwkAnJREJbG325hdE3QSY
 aqKg==
X-Gm-Message-State: AOJu0YxzfDlafRv8AiK9K0TdoLIUMKRIonZdNpzUkIUpUTyNG9VZUnPe
 oLe8CZ4hVXvb7hiKx4exiXB6kcPDGDKof6UdVZVM7gQ1xo3/Lj7/JzEf8L9hQLOW0gnl/VpcFiA
 u
X-Gm-Gg: ASbGncv+mIf9B3fnJGni/3qNfP/iudJ48Cd68gdw26cM9wyDhvHK7kvEt56gYuBFzVo
 xVqv+uPsj0A/m6219NDdi7BeFzUyZ2GYS4oMz0nTwLaPatcb9rURlchN4RVmeYa7ou7qdMJmvUw
 602swGEt4f/RQ60WJWs1sDqljYccZv14Ll1vyM57EWnr60T+ThUKGAfaLYnfIyqAkA0QM+Zt79O
 HmOZRJpumPvpFdI+KS1Ec6GELOqX4Rgj+KtMbNnal1HLQIX0QKyn3m76sjrce3oFq3Pubigc+Bs
 Xez4KiuEMQojQJk+XpqyZPAYoisskAZ1CufyFU15Kz/aHKsNhxwbpNaFhyTqG6RhVIsC2a54umC
 fcQn4/OPIWZzcUa7voCTFkYFfpvYrOQ==
X-Google-Smtp-Source: AGHT+IF9sqrXmIs+tdJaHPL2iWQXajRgH7TLwN7Y2kITjnMSam7fRd5WOeBtOgjLqgCwIX+uXO78sw==
X-Received: by 2002:a05:6214:d4f:b0:6eb:1c23:63c3 with SMTP id
 6a1803df08f44-6ef0bca6f25mr117267796d6.0.1743775546968; 
 Fri, 04 Apr 2025 07:05:46 -0700 (PDT)
Received: from ubuntu.localdomain (172-97-139-107.cpe.distributel.net.
 [172.97.139.107]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c76e734fc8sm222173785a.5.2025.04.04.07.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 07:05:46 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Ravi Minnikanti <rminnikanti@marvell.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH] mbedtls: remove incorrect attribute type checker
Date: Fri,  4 Apr 2025 07:05:25 -0700
Message-Id: <20250404140530.2874921-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
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

S/MIME Capabilities (OID: 1.2.840.113549.1.9.15) attributes are
expected to be algorithms but neither data nor MS Inderect Data,
thus the checker for data type is incorrect.

This patch fixes a capsule authentication failure with PKCS#7
message that contains S/MIME capabilities, which formed by the EDK2
GenerateCapsule tool.

S/MIME Capabilities are not common attributes in an EFI capsule,
thus this failure cannot be reproduced with the capsules generated
via mkeficapsule.

Fixes: 7de0d155cce7 ("mbedtls: add PKCS7 parser porting layer")
Reported-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 lib/mbedtls/pkcs7_parser.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/mbedtls/pkcs7_parser.c b/lib/mbedtls/pkcs7_parser.c
index ecfcc46edfa..bf8ee17b5b8 100644
--- a/lib/mbedtls/pkcs7_parser.c
+++ b/lib/mbedtls/pkcs7_parser.c
@@ -189,10 +189,6 @@ static int authattrs_parse(struct pkcs7_message *msg, void *aa, size_t aa_len,
 						len)) {
 			if (__test_and_set_bit(sinfo_has_smime_caps, &sinfo->aa_set))
 				return -EINVAL;
-
-			if (msg->data_type != OID_msIndirectData &&
-			    msg->data_type != OID_data)
-				return -EINVAL;
 		} else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_MICROSOFT_SPOPUSINFO, inner_p,
 						len)) {
 			if (__test_and_set_bit(sinfo_has_ms_opus_info, &sinfo->aa_set))
-- 
2.25.1

