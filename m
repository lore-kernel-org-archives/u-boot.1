Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742F9C28B2F
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 13:01:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D381E8169D;
	Wed, 12 Mar 2025 14:01:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="J1WabHpt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB021807D9; Wed, 12 Mar 2025 10:01:46 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9149F805D7
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 10:01:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=naresh.solanki@9elements.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-390f5f48eafso3128890f8f.0
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 02:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1741770098; x=1742374898; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=qkqJSMySaujq2gcwsKSGj+367itR5uaCHs+qUNEmwKg=;
 b=J1WabHptdzLvEencKYAb3ohZ/zXO0YWZqv0SihSP7JTTYBUgsDlM3+v3A4v/mu1Q6o
 hm0807jECXYpBqQ0gkfXXsM2OFVW+enmv9H6YMW2oiAi1C5uMbUd0NsPW42qnYJNlwK4
 VHerK31xXrpeFb3GLE3F81hfHMZqXiFd8Ej1wAkGDJtu66+Bu5KR26RzEltNQ3HPTqLo
 hQnB0vjnFMqiKsB7/vOf92UBYPRNT8LHLo+w9J2fB2yTnv5swFe8mEQP1kmTK1mDNzXW
 5qGmEKdYz1WczGEsJvPJns+USsiALjoNTyXMwGAyIoUUG4/XpucqXLGXGxvjmxoxLI8h
 2gww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741770098; x=1742374898;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qkqJSMySaujq2gcwsKSGj+367itR5uaCHs+qUNEmwKg=;
 b=S4fYdTJOP7PPbAqSkiSCwM0XG0uSIykb2wk/6t8/vdLotf12AYpauIMSGd41GNloaQ
 9SMbWqu5c+nuufZ5SGnoSFvTp3o+lcXIETkHQ3xIxCgwLhPJcbnOseuUs9deUL+gPZBD
 VON9q1u2uYMok76md/B+M58ranbXrbmwIhUA4oGI53OuBgJ8RxTQE8QDVzwE9U0E2PW+
 C96O4BSP3tMmk0isVQzQKZg8V6RGLKe4Hovym/I7HmtbKUgKRSGXphQB7Jw6Q7rWbtFy
 wqR5GKvrh5wATWrgVKP5elO5PzKcbRFi3acJYPfueicJhgQvCDq4rBK7f5qR7vwiJrdD
 7/tA==
X-Gm-Message-State: AOJu0YxHqbk9WbL/D89iHETbR7cieKGgOo8iU60s3ErUAs5C9CtQDM7a
 GdMKM4WUoz52H/LQDR7lvaJHZ0o58lZDS3wyRoOVxz5z277C3dg2AqEmihFAONkik+bWp3exKIq
 w+2g=
X-Gm-Gg: ASbGnctxWrdEtclbMM4CW0rSRfq5Lc/uley3t+V71qN+Y8phvEbtBSKWpp2g3mqdOP+
 tlJPE8f02tPaTDB/LInBkG7HPZR4O+xUUWIIzrOKfLCbPr6w0zvDIVQvPUhagJc+3Aw52VDhgbA
 +x3miinayZOckt/dWCn54m1HRKvlg5LIp5AQfguCcUr+vlKAKPRy29yrEgOBm6u5zCqMyiTUqgP
 9Io1DLmpEa+smz8i3PEPu4B8X+xzBKAFKoc59hWJ+/9ygYwhJE6k4+mbR6HA9f1Y+/wDy+Oo/8T
 IBuaYWa5IujfifoP9q7YK6CglJlbabqfHKYL7ZaFPXujj6XyN59na2DDKLhRQjuRD5BcE+shEY5
 pQ0MndVPh9T/ZTb6k3Rwd4NwIGivdLUKXoVPZNikc
X-Google-Smtp-Source: AGHT+IEBZ5qD0UQlLIXDTq1ppMgNBQ3nSGB3DqxsSN4ChTDUhwMEVbJjSGlawDe8IUphwYu6GJzNvw==
X-Received: by 2002:a05:6000:1541:b0:391:bed:ec9e with SMTP id
 ffacd0b85a97d-39132b654eamr17228265f8f.0.1741770098507; 
 Wed, 12 Mar 2025 02:01:38 -0700 (PDT)
Received: from stroh80.lab.9e.network
 (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e3099sm21037032f8f.69.2025.03.12.02.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 02:01:38 -0700 (PDT)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Naresh Solanki <naresh.solanki@9elements.com>
Subject: [PATCH] x86: spl: Add support for NVMe boot device
Date: Wed, 12 Mar 2025 14:31:15 +0530
Message-ID: <20250312090130.2951848-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 12 Mar 2025 14:01:40 +0100
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

This change adds `BOOT_DEVICE_NVME` to the `enum` list in
`arch/x86/include/asm/spl.h`,
enabling NVMe as a recognized boot device for SPL (Secondary Program
Loader).

Tested x86 hardware with Coreboot + uboot payload.
Verified successful boot to NVMe drive.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---

 arch/x86/include/asm/spl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/spl.h b/arch/x86/include/asm/spl.h
index 483cf702cb..1fb995098d 100644
--- a/arch/x86/include/asm/spl.h
+++ b/arch/x86/include/asm/spl.h
@@ -11,6 +11,7 @@ enum {
 	BOOT_DEVICE_SPI_MMAP	= 10,
 	BOOT_DEVICE_FAST_SPI,
 	BOOT_DEVICE_CROS_VBOOT,
+	BOOT_DEVICE_NVME,
 };
 
 void jump_to_spl(ulong entry);
-- 
2.42.0

