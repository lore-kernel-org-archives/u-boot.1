Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28986D68B3D
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 17:04:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9116388E26;
	Thu, 14 Nov 2024 18:04:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s7vfeRju";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFCFF88E2D; Thu, 14 Nov 2024 18:04:10 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F69588DC8
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 18:04:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aa1f1f2d508so124465166b.2
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 09:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731603848; x=1732208648; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YS14o6RFEvEryMVAII/VahLSzplW6LctthQK+jDgtrc=;
 b=s7vfeRjuVlkDfZrS2eJe/mUFmBqLxc2Oq03Z1mItkcFpckhF0e3mbtHY2TC2z7ASoK
 z/c/qPDw4mOGel07s++kCeqhBsb0+Kj5hC/+Tg1wIK9TdpMb2lGcMMFViD/uXL82mMyc
 7kpuGO7ic2iqLKvmEPtAYc6tX1JscDCoOQc7RfKtuWRh4VAopddy0KVJjxxe0FIHAMUu
 KKgV4Ok4UTGT82xZTPw8w+SV4UwRgjDmbzA6/yNuK4QL5QJcnkA6U2D5fn5G5DvWaeT2
 6oJWrHS/8V3hBgFfHC88EsGnEKMyhx9W6gp6o4hWacXRGr8F/3qNY3Q3hTG9Q7CGaR2z
 SZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731603848; x=1732208648;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YS14o6RFEvEryMVAII/VahLSzplW6LctthQK+jDgtrc=;
 b=U1Z4re6CophQFM6OAGZXEcf6zyNTj192zi6x9hSMl2OUYv9rzsI53L/jOMgNq3qD+L
 Ihdu5ZRd7rv4KOSdJ2n6jMdgJImsYrPr778p6xT5zG3cRV/i5l0Eg8rUZ9UBU1mBK87D
 KSmMnUC3PsRaqd6Y4xEohQAVmrtptR61bB3RNMU6vdy01gcXsNmF7yMpVtYnJyRFVDG+
 rmQ6m8GJ+ySU07cNukU2R21b3sPyAuZ1NEUI69NWgL9ZFk5dzT8i3stCKZlOV7SqTQgg
 g4mXmuXACNBYEtAQmL9jFToafYPl0Alg9+nf7Cw7dnZTnqvEVVZbWToN4rfHDmHGV4TJ
 CY+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrMheRyZedRiULDzFphM1yTJCVN+BaSCAlhGP71HP33Fyat2sQQpMXobs0jcZ8/PKktwrqz/w=@lists.denx.de
X-Gm-Message-State: AOJu0YzwxKnwNqTgqMjmRRBlnw4BP/gzcBzXMPKuiewzcvq6UA4nkwjd
 ixAlr/bc1C5L5qM1mTceWjKYYHtPQFuwdV5SNyabsxt8ovntV8QTDV5mMiBY42o=
X-Google-Smtp-Source: AGHT+IHGDrX/idISYTgk9aJMwGT6kCHs7oMXbGMQ+gs86So5TnCgweypNwVUvmw2cAs7a1bvsTNGmQ==
X-Received: by 2002:a17:906:eec3:b0:a99:f71a:4305 with SMTP id
 a640c23a62f3a-a9eeff0da96mr2624088966b.18.1731603842547; 
 Thu, 14 Nov 2024 09:04:02 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20df26809sm84219566b.27.2024.11.14.09.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 09:04:02 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, Neil Armstrong <neil.armstrong@linaro.org>,
 u-boot@lists.denx.de
Subject: [PATCH] u-boot-elf.lds: mark executable
Date: Thu, 14 Nov 2024 18:03:53 +0100
Message-ID: <20241114170356.3248124-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.47.0
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

Some pre-loaders/bootROMs like those on Qualcomm platforms actually
use the ELF format and respect the headers. Mark U-Boot as executable so
we can actually run it on these boards.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/u-boot-elf.lds | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/u-boot-elf.lds b/arch/u-boot-elf.lds
index 1666027e3635..eb84a22dd71b 100644
--- a/arch/u-boot-elf.lds
+++ b/arch/u-boot-elf.lds
@@ -1,5 +1,9 @@
 ENTRY(CONFIG_PLATFORM_ELFENTRY)
+PHDRS
+{
+	data PT_LOAD FLAGS(7);
+}
 SECTIONS
 {
 	. = CONFIG_PLATFORM_ELFENTRY;
 
-- 
2.47.0

