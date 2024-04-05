Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD74CD11C2
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 06:18:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C3B2883EC;
	Fri,  5 Apr 2024 08:18:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NKQrr9dv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA702883EE; Fri,  5 Apr 2024 08:18:46 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D25F883C9
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 08:18:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4162b0e21b0so8647215e9.0
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 23:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712297924; x=1712902724;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tzSFqr8+hBYLqBOcZvf6xQbmq/SAkHhgASLmZ/OiV0U=;
 b=NKQrr9dvbKLZE6wKwfxftrLD7gMibjzSnVpgDtepiKkDOQqkwshq74DNhII0STws+q
 7q0rhrBoK56uaQpaoCV6J4CRXZhGIvvhGaUmqxP4RG1l22JP0XIRZ/FW0wZ0RiuOlsoW
 xVvmj9P3NjU8ktD2vj5Yli+7ybRWiNHZQizsqzAFoAcWivzQy/8eHj1ynD6rvleuu60/
 78WrmGel8yL2Sa2miJYSztc1w9wELRvpUw5Bmg6NjRwhgPIdxiNR8v4A3ba3XZYPEWu8
 tOjEW0Ms4vpsIIa7ReJFjrEvXzWLEY1HwGrXl6jm926tf/fivP1CTtUf5DmUbRZ2EQQs
 CNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712297924; x=1712902724;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tzSFqr8+hBYLqBOcZvf6xQbmq/SAkHhgASLmZ/OiV0U=;
 b=eYyUCLEJwSoskYtB4qaoXoFiLAdVsUuRj9alr6NgEJMfM1O+7fqn8eyz5kcvFhz+Ch
 oNVXvNx7OpJgBOAkgdeyFjO/twEhCRO1uvCFE06/pEBJuGZhi253P4NhJO84AiUVzJgt
 Xyu6FVOBtouwnIzftGDMcO4Dc2M+1u1atOE/s7d9xt3cu2K4d9r8C6+fBfFPElQrcYB0
 hoKm3gmFj4b31SflLDn7HO9noDRNLiMndrCxVBHwnPBCTHUEIeGT3E7QjqCSDAPvRdt6
 jvcWCa23qOkM9ZW5+0MuAwkH+eVM+5vu3Gw5bTtHQP3T1n9qR2+sBSMcU6npE2CzRzCb
 j5VA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYsZfGofpXq98BMs63qEgvYGfvTbpSH2d20ougU584KZPamhJu1jpcr2sVPtcGe7INNWpDkvvFP2g61bPTWh1ZZX4QAw==
X-Gm-Message-State: AOJu0YzxOHwIl/eKHsMy12KXQ8qUcKimicGA7V5X2kMiN9NRfA5h7Ox4
 BVavzuKO1NR+jBfQamI6JcKuehQsHIEHR9mBc++LFuj4/Dod/YJQZ4UaMWB0wMc0Wmx/76EE5r6
 X
X-Google-Smtp-Source: AGHT+IHILQCMIyPfMPQe6WeyPThzKkA6F6F8akmatY8Zd4B2ON0TIeRkE9XZq9DSwmOsC3TKCGYvGA==
X-Received: by 2002:a05:600c:4e06:b0:416:306b:dc91 with SMTP id
 b6-20020a05600c4e0600b00416306bdc91mr227126wmq.41.1712297924423; 
 Thu, 04 Apr 2024 23:18:44 -0700 (PDT)
Received: from [192.168.1.20] ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 q18-20020a05600c46d200b00414659ba8c2sm1687528wmo.37.2024.04.04.23.18.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 23:18:44 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Fri, 05 Apr 2024 08:18:42 +0200
Subject: [PATCH] doc: build: fix gen_compile_commands section level
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-doc-fix-headings-v1-1-455387c85e54@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAMGXD2YC/x2MQQqAMAzAviI9W+icFfQr4mG4qr1ssoEI4t8tH
 kNIHqhSVCpMzQNFLq2ak4FrG1iPkHZBjcbQUddTT4wxr7jpjYeEqGmvODga/cCeOXiw7Cxi/l/
 Oy/t+h34r72IAAAA=
To: Tom Rini <trini@konsulko.com>
Cc: Joao Marcos Costa <jmcosta944@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.13.1-dev-5d32f
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

The 2 subsections of this page ("Compatible IDEs" and "Usage") are using
the same header level as the title (with "===").
Because of this, they always appear in the HTML rendered ToC.

Drop the subsections one level lower by replacing "=" by "-".
This fixes the HTML rendering.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 doc/build/gen_compile_commands.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/build/gen_compile_commands.rst b/doc/build/gen_compile_commands.rst
index 50305cec4a83..d503764f9e3f 100644
--- a/doc/build/gen_compile_commands.rst
+++ b/doc/build/gen_compile_commands.rst
@@ -42,7 +42,7 @@ needed for it to be usable by the LSP, unless you set a name for the database
 other than it's default one (compile_commands.json).
 
 Compatible IDEs
-===============
+---------------
 
 Several popular integrated development environments (IDEs) support the use
 of JSON compilation databases for C/C++ development, making it easier to
@@ -73,7 +73,7 @@ compile_commands.json in the root of the repository should suffice to enable
 code navigation.
 
 Usage
-=====
+-----
 
 For further details on the script's options, please refer to its help message,
 as in the example below.

---
base-commit: cdfcc37428e06f4730ab9a17cc084eeb7676ea1a
change-id: 20240405-doc-fix-headings-6109365355a3

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

