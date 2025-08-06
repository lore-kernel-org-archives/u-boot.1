Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF05EC87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 10:57:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B03283A07;
	Wed,  6 Aug 2025 12:57:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tSSzJW+U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94AD483A07; Wed,  6 Aug 2025 12:57:06 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8C85839FD
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 12:57:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3b78d729bb8so4382005f8f.0
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 03:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754477820; x=1755082620; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JrnXB51x5pdFPEYPGBg/oZ/1EhXaGKyBLv1CYjN3CnM=;
 b=tSSzJW+UnEsrhW2fG4OBxRFxUywWW9vRZQBRlLWyXgktKfGMV3/X1iRuqgeLxLZHI/
 4qEtmFAzoxo7DuXihAjQo/GpfLsrYgsM62Kd8GfrtRVXpZF4paQ0mg6SDFV3Jp/0JNS5
 YFwY1zsN6+TY8ualbYOiqcNzbeQbvYMwt6bFkLx5TnGGdNkfMjctDIYjsxPkIFItr74g
 9JiWD+Nuq8BYabOuy6l21Gws+5neHkSYGEtZz+a089mnuGIG/04z/1rNXFk0Kdl8JRRk
 fb8J6MOzNGTJq/D3apyC5shH1za3yK3X9I0VVOMy+ntt3QhP3LI0sjarQ6pHsTi2j7p/
 1g1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754477820; x=1755082620;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JrnXB51x5pdFPEYPGBg/oZ/1EhXaGKyBLv1CYjN3CnM=;
 b=CkBvny+GY5d8Z9T72Pnz4efEIDbjgu2560a0ODwBbZTjv2PZ3ja8RamajyfeqT47cn
 UoIN7WFVzmJ11/bhNsYTAT+KmKg6NXtz1av5Sp6fN4VbNsGHSH4qRPd5nXieVy9O7Ius
 o88tH3WgpVzc/EEI2aIZ+fYdjPuM9V9Yx55zF9+yLGe5KU1HK+Oe3MtKXPzQvd0BgXQs
 mvaqWRAsN5N1+qOFrCSoFteu8BbnMOrt4zMqswnZdfD4bu7Jq9HjE8fsZ9Cq8D1+e17L
 WZUGhH4mYOoZ6gXMpwxdPq4azUZUNyfYvo+2CislDQCLZpRb21sAZQA2t/BmPskotW2l
 1Mnw==
X-Gm-Message-State: AOJu0YzpxsjHL1sId8QIk88r8nbU6QrRZlemjI+rTQIwxSX/Gge69jhI
 3sjt+39466ttahJI8XaV0kgCgYJrqriaUBL4xXcq2ZvVh2+FC5N1oOWdAUZKI0Tnf5X4keVjHir
 Xteen
X-Gm-Gg: ASbGncuiApl6DwkpRwu1i2Lhs+K5iONfUFJsqQQflsgKvA617nLqkGgK+4kDunNrH+X
 sMwOlNChJzB4x8y2JnA/XCUeH30KSaucy5ywL88Ajq+Mzkl4ScDriLVyzxRXVF9YwPQwZqCDHXS
 xLT5PWlf6wyESikRJHV3SpP+ZyLgn8wOrC+jaAthdQeOB9YJBiaFjpeGF1OJBm2CNmd4CDoJzmQ
 CuLgvW8ZhP45pl4kbcRIjTJ5zKPBCQtd7r+Ackz6UXWLVHLSaAwLFDLdV/iyPtnQ8yKcsN3HbZT
 Ojp9Fms47N98oXhvc0Z0S7KrbS/lGIDc3voctKunrrG0NNRWXg3C258kZOYtkcwPrbfMGMBoSiG
 oZ4+xdd9iXqa/EjMXIgdzdygbhu3KOtd6X4qvMfDRW+5c14pSPW55wfdFfSx/vg==
X-Google-Smtp-Source: AGHT+IF9ahhRmueR07cjEkXVkOZlP43Ee8eLOWnOHSTpzOBJPFag5nPAUbXYgyjN8FMs0Aq+gMPqfw==
X-Received: by 2002:a05:6000:26cf:b0:3a5:27ba:47c7 with SMTP id
 ffacd0b85a97d-3b8f493290bmr1427880f8f.48.1754477820284; 
 Wed, 06 Aug 2025 03:57:00 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:6501:9a0d:7129:a02b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c46ee84sm22061506f8f.57.2025.08.06.03.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 03:56:59 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 06 Aug 2025 11:56:58 +0100
Subject: [PATCH] net: ti: icssg: Remove impossible test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-net_ti_icssg-v1-1-860dd0bf1acb@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPk0k2gC/x2NwQqDMBAFf0X23ECMaKW/IkXi9lX30FR2QymI/
 270OAzDbGRQgdGj2kjxE5NvKlDfKuIlphlOXoUp+ND63ncuIY9ZRmGz2eEeauaOG+49lWSKBjd
 pTLyc0Sdahp5iVbzlf32G574fAKMOJHcAAAA=
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

port_id is an unsigned variable so cannot be negative. Remove the test
checking for port_id being less than 0.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/net/ti/icssg_prueth.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ti/icssg_prueth.c b/drivers/net/ti/icssg_prueth.c
index d8df3c9afb0..12a162b9d68 100644
--- a/drivers/net/ti/icssg_prueth.c
+++ b/drivers/net/ti/icssg_prueth.c
@@ -647,8 +647,6 @@ static int prueth_probe(struct udevice *dev)
 			return -EINVAL;
 		}
 
-		if (port_id < 0)
-			continue;
 		if (disabled)
 			continue;
 

---
base-commit: 007610da2cca405ea7739fc120d90085be4b6ac2
change-id: 20250806-net_ti_icssg-e721cc6c3c80

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

