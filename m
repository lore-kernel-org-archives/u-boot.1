Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D256FCAC5AE
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 10:06:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BD0282AE1;
	Fri, 26 Sep 2025 12:06:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bqf/6Kt7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 480958319C; Fri, 26 Sep 2025 12:06:20 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D9FE8206E
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 12:06:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-36453927ffaso16592131fa.2
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 03:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758881177; x=1759485977; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mu3e0i5GP4e2a+/itpkwrKv7S6sFFoQlrZ7wl3wcwaw=;
 b=Bqf/6Kt7/I6B2e2aW56DHbtf1Pvr7Jqzrma5vzLPdQJoGYq3YE7qEQjwiRQBCSlBGm
 4RG4JVxk783KSCjBnC0xemUOY8n6Gtp0KFxt3uOVbj2uW5xQiLkrckh6MZOq+bmsR4EK
 EoMdSSv02NdqosUVTyoZHLzWnwVfd+SFLWn1N1ZLdwwrvkDSz6/NQ7av97NCW6detCSb
 gsENqdYMVll+U6Hes3FrNHZHewdC5EJqez1Au9OHcEshV/bjSyiCuYriRPqKck1ejvWk
 M1iC/JSrHRNkrzN67GBhLl8jo5hWEDBZqHlHI4pNJMlcsxGQqPi5R2E9K/jZTP9Nvz7Z
 Y+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758881177; x=1759485977;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mu3e0i5GP4e2a+/itpkwrKv7S6sFFoQlrZ7wl3wcwaw=;
 b=savTfkz8PyRIp0F+lLArzka7ErZ/JyJfzqCj//3IAnYayh4L2gS34097ltSg16OSzf
 dNrtb4WhCShy7T4anfNYEQ8/K2iikopyhPwRhNvfyA0SqwnSppnk6adXJdWTRPmVHkH4
 D+sIQlGkkrcU4yUoae2hSrwmYlgmtdU0EW/4vMmEfBuSvjOqj2K6X2cwEso87+tA894X
 2AQnQ7SG6JawXugLKHNuPNIChUJeM5ldhDjPCsO+1KLLai1XRljnWHsqP5jc8ikwJczs
 zC5C14T6kL/3YpvuvoNCmr9v0UCKPJCr7NCcCQ4adO6A9JcgEjew9m+/Bw9ZtAD5MniP
 1Ofw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoHPkV7DCqsROc59M2kSpFovUebdGKix5W5QvApLRxDElhVdvFRsdV/FWmHjAVq2Boii5Qs2E=@lists.denx.de
X-Gm-Message-State: AOJu0YxFZFJdYona/hCL9MqdjCWgOo9EW7GSW5fRyJzCno74OlEBNZ6d
 UvszrrAZuwCI86kK3pay8gVqZQiahSxt94uL07ied26C/Zc3wVKVFJ1V
X-Gm-Gg: ASbGncvGtauWdYNOvo2iF66b9u2f0uvq45nSKpXSN8AKWHeXJeocTIIjsls8/JWPId5
 HcgRalCJqmyQwZkmRI1Vg45l276hPlAyr2xQCMe+1mlOc09uAyglXcAZJhjNCsTyDpQ0TMeJTg7
 bjEwBtYHECSGTXDyVCH9b5vxnBQ7K7opK0/tG8bVM2H0u5YH6JPf6uIN7RLOnZbDPKSMAeh4k2s
 5NVUUJDYkGo6rwJkzr4p7AVib//tx8EfxN+83ghBVimks8Dy70I3sWbJfsI57F/yP9LIpG7wTt+
 Shw0eqM7wIphiyHZ28V5+wwyZMwub1D1xTo8FRm/E8I+eBfLhaAw4w/HmT5SQ/3GCFPhnAXTjo/
 uN4sPYSFQQUgVsameSeFt83NurOBBGE5cgz1EgfSADszPGciKi0LgSZyYGk+Ap/G8uSks
X-Google-Smtp-Source: AGHT+IGGE8R9rnjNwddplDEp6n/HrS7SRVOVzaMPaZ1vDNqpujE3ngqmwKGME+5aEiiyCJQMG9cQYQ==
X-Received: by 2002:a05:651c:b13:b0:336:718f:75ac with SMTP id
 38308e7fff4ca-36f7d5c3d64mr18541691fa.4.1758881177216; 
 Fri, 26 Sep 2025 03:06:17 -0700 (PDT)
Received: from wpc.yadro.com (host-95-152-52-178.dsl.sura.ru. [95.152.52.178])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-36fb4772cb8sm11316381fa.10.2025.09.26.03.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 03:06:16 -0700 (PDT)
From: bigunclemax@gmail.com
To: 
Cc: bigunclemax@gmail.com, Heiko Schocher <hs@nabladev.com>,
 Tom Rini <trini@konsulko.com>,
 Wojciech Szamocki <wojciech.szamocki@nokia.com>,
 Dinh Nguyen <dinguyen@kernel.org>, u-boot@lists.denx.de
Subject: [PATCH v1] i2c: designware_i2c: Don't warn if reset DT property is
 not present
Date: Fri, 26 Sep 2025 13:05:26 +0300
Message-ID: <20250926100530.732938-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.48.1
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

From: Maksim Kiselev <bigunclemax@gmail.com>

If reset property is missing in DT, then we get this warning:
	designware_i2c@0: Can't get reset: -2

Avoid this by checking if reset DT property is present, first.

Fixes: 622597dee4f ("i2c: designware: add reset ctrl to driver")
Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 drivers/i2c/designware_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/designware_i2c.c b/drivers/i2c/designware_i2c.c
index a54976e7889..8ad716f410e 100644
--- a/drivers/i2c/designware_i2c.c
+++ b/drivers/i2c/designware_i2c.c
@@ -764,7 +764,7 @@ int designware_i2c_of_to_plat(struct udevice *bus)
 
 	ret = reset_get_bulk(bus, &priv->resets);
 	if (ret) {
-		if (ret != -ENOTSUPP)
+		if (ret != -ENOTSUPP && ret != -ENOENT)
 			dev_warn(bus, "Can't get reset: %d\n", ret);
 	} else {
 		reset_deassert_bulk(&priv->resets);
-- 
2.48.1

