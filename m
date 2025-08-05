Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E8FC87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 14:25:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D9968383F;
	Tue,  5 Aug 2025 16:25:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="z09Z8oFB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE88B8383F; Tue,  5 Aug 2025 16:25:31 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2323A83045
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 16:25:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-3322aba45ebso55329021fa.2
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 07:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754403926; x=1755008726; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X355D8hQ7Jc42UjCqCzgk/3SkoDMx1DyYGOqZdQ5SUc=;
 b=z09Z8oFBSe9txwFKBCpLwlCZIORWrYrdmzgdJGkpXlfgy+hg0Oryu6X0MIxcGY3Kij
 Y5C7a0zUGEe9iqm6Aeqh0R3mlKhnrFNBK15QQbIdJU4C+5/vPjM2nDXvwY++7jR1DIK+
 O9Ya6FsZGvmvNX39A0dLVeKkqd1MNwFq6tK1u9AzjDK4unO72efhUiGGtwhhBQA/3VRb
 cTsKzq6StvsZlmTPsnEzaubpIpsHLmZMTP8fhYs+HjEcGTM4W6k8SqkkyNLvz9bDXbsV
 p16jwaJVZT7OG/DUV/THEgeVBBv7neIIXNtagyPE4FKc5TD7iflnF35O+Y+8cVMWKmNq
 aU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754403926; x=1755008726;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X355D8hQ7Jc42UjCqCzgk/3SkoDMx1DyYGOqZdQ5SUc=;
 b=ui7TbnAzGDIttJFiLpN/NzcO5ukQ0fjy521iGu70nHS2CDCWepUtODwpTbhCNfg7Ps
 4PP3c0ZpIx8lOQJasrKR6fmCCtL6PyHYUDMaJ3pyjC319wJjdTj9xiYOWuBu0aomcK4Y
 OilIM8Nvx7wEivWnQfuxtID326WFMo4RUFtl9zgz6VkhTKWP+TkNkgA9608lB6EvlolB
 0QgLbYTIYB+mvUwGjvMXaZPXCm/Mpy5Woi0Xsu3E2GnUYNTsmnlx7taCFkrPeWIQL2QP
 NkGXJMhA2ZtDsP8Y0hKimvA+9rGQct42x/kvqN1QRfxv5dT0czCT5bszXcHGN/cV352D
 k4fQ==
X-Gm-Message-State: AOJu0YyZbwgg4i+R3R1eu4NDrpibO+LmuDg0aS83+xLiP+XK/joU8UNR
 VkZH+Zx+AaffxuOytnhkfz6dM7X61b/vLKtWSI/H3MkzTHUpeYdChalZ0LETDAFTTBxqFLi7Jd/
 84P+j
X-Gm-Gg: ASbGncvxyKjiXe8SOaILBpjyCoUdFJrgmQENdW8N2WHrCIK/UksmEiFoWtSI0ZLNHgR
 3z/xFzhWmFcOlhtagM5UlGF3kp7Zkl33B1yE0x7fX6H3uxmg6GC7VAzdhylcXnnu6TtNd4IDfwv
 EgIGB01zVv719pnY44x6pqeUG6T3L0BAzT8mbtPZZZq77NVbrfpwdRrJGKugGt/EjQulDGHl4tV
 GI2SO5E9ykKPvLpMv3LrrWRUJOid7qK6IZ4kYS3tRA4PpLKBDuKf3BRHa+gDAnVaEfvFe/qKWYN
 iXJllaGBxzawmdEip8KaI+OexWClPbWAin3n6GcopoMD7WElBtaggy8tpWsOBDfCLH2FSaLjtNB
 u7K0a9Vz0v6vCUuKD3zTzSDJRlRnDRGqk6caI9p4dmvVy837skS0=
X-Google-Smtp-Source: AGHT+IGlpNwphyXLbPxIEIWx7RKKaOsV8Hykvz59o65/GkZCjWg3qaP7J7eIJTbbqU2TSifQyerDsQ==
X-Received: by 2002:a05:600c:4589:b0:459:df07:6da4 with SMTP id
 5b1f17b1804b1-459df076f1bmr51900995e9.5.1754403498120; 
 Tue, 05 Aug 2025 07:18:18 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:60bc:24e3:6dcd:9f35])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4534b3sm19307801f8f.47.2025.08.05.07.18.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 07:18:17 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 0/4] net: mvpp2: Fix some Smatch reported issues
Date: Tue, 05 Aug 2025 15:18:15 +0100
Message-Id: <20250805-net_mvpp2-v1-0-624ef87cadb9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKcSkmgC/x2N0QqDMBAEf0XuuYEYCbT9lVJKcm7rPZiGOxFB/
 PfGPg47y+xkUIHRvdtJsYrJtzToLx3xlMoHTsbGFHyI/uqjK1he81prcMy3PgYeRgyZmp+TwWV
 NhafzMSdboOdQFW/Z/pHH8zh+d8cVjnQAAAA=
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

Smatch reported some issues with this driver, the use of unsigned
variables and testing for being negative, should return -ENOMEM for a
memory allocation failure.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (4):
      net: mvpp2: Fix impossible test
      net: mvpp2: Return -ENOMEM for failed alloc
      net: mvpp2: Cannot test unsigned variable to be negative
      net: mvpp2: Use field just assigned in error test

 drivers/net/mvpp2.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)
---
base-commit: 007610da2cca405ea7739fc120d90085be4b6ac2
change-id: 20250805-net_mvpp2-cc9152c3de3b

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

