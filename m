Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1039FCF5389
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 13:16:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C8A5892E7;
	Wed, 23 Oct 2024 15:15:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="grDORDsV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9717A89266; Wed, 23 Oct 2024 15:10:21 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE67688DEF
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 15:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martinstolpe@gmail.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-37d808ae924so4731280f8f.0
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 06:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729689019; x=1730293819; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0fPZgd2GPr1XfBH9U8b5syuKlJTe0UO2UmQ3mSK9wh4=;
 b=grDORDsV+6sTDLtlsNcKzx7Q0yAfEMtGl4fy88zpVZYzDKpfOsQefAaN+m3WUEHPi9
 XKpBQciMadbTDzQLm5W9HQN7auUtVqkJP9zURG1IRjYI6nlDeseFiKj7GLwwSspGmTu4
 2s+mUirM86gItYu5xiRDt4RYDIHLdiJBzCd4vb399nywkccLoqb3gbv2bMSxvjBPReM/
 IQ6uny5l6gCS3Il1Qp8iaicQxGyZncUAWK/34x7YIreu0MBqoVXhqazccCwBFa6VFGzh
 JMCCUNczypDaUfyTT2dLLEE6FrUXp8MzWVPOOGdpVKkphLaxi6Obb792apa9X5CKM8gM
 HSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729689019; x=1730293819;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0fPZgd2GPr1XfBH9U8b5syuKlJTe0UO2UmQ3mSK9wh4=;
 b=EEZezpYBi5rqB9ckHUj7JqNGADKZuJttx9AkiG/EgtHu6egR1Dfck4/Gia9YsvzRV1
 kFCmQmAnns1z+dfT9bj+ubE3euQsM5iq+4J68dqSVFrAYrC7STUCJ2PQrKEe3Nx6vurz
 MXAhTYZUkJwK1fFanY1WnTpjeQv5fqlcJybzrmrFXXBOPgjKUf0QQMQEUZ4XJ1xmPskW
 X8l7jfbk0Hm19ueOk0Zi0hxe0kRm5FQhM/bhu28ajdK/qBzd2IQbghP6ihXnZqj/3VXu
 cus8KLYX0+rZFXVP2yuNmHFUur4qZz/adS2OzLHi6QLigfG448in7XNnty4rGaXOTe95
 P5QQ==
X-Gm-Message-State: AOJu0YyTs3H3nVxt+DYMgsTm01JP7AAxwpxZnlr8J81OcyonGO6T3YkM
 +BNDkN6ayJvWqF8IJquY+NPsMIXItNV0VhSClDFKDoHHBkcJrvqOvTKD73sD
X-Google-Smtp-Source: AGHT+IHrfhtE51DbVv1QrV09yz36M1S50eoQyZ7ZeA22BoiiXqMbMwg9MCGd2hSNl6F5Um9DjOGvBg==
X-Received: by 2002:a5d:4845:0:b0:37d:46a8:ad4e with SMTP id
 ffacd0b85a97d-37efcf063bemr1773287f8f.15.1729689018717; 
 Wed, 23 Oct 2024 06:10:18 -0700 (PDT)
Received: from NLOOP11.neuroloop.local ([213.164.76.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0a47b74sm8842742f8f.27.2024.10.23.06.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 06:10:18 -0700 (PDT)
From: Martin Stolpe <martinstolpe@gmail.com>
X-Google-Original-From: Martin Stolpe <martin.stolpe@gmail.com>
To: u-boot@lists.denx.de
Cc: Martin Stolpe <martin.stolpe@gmail.com>,
 Francois Berder <fberder@outlook.fr>, "Ivan T. Ivanov" <iivanov@suse.de>,
 Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 0/1] rpi: Cleanup conditional compilation of framebuffer
Date: Wed, 23 Oct 2024 15:09:19 +0200
Message-ID: <20241023131012.2445564-1-martin.stolpe@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 23 Oct 2024 15:15:20 +0200
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

If CONFIG_FDT_SIMPLEFB is not set fdt_simplefb.c will not be compiled which results in a compilation error if CONFIG_OF_BOARD_SETUP is enabled. This patch will fix this error by not trying to setup a framebuffer node in this case.


Martin Stolpe (1):
  rpi: Only add frame buffer node if CONFIG_FDT_SIMPLEFB is set

 board/raspberrypi/rpi/rpi.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

-- 
2.43.0

