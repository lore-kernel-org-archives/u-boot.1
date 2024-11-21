Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2942D78764
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 14:25:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 369AC89752;
	Thu, 21 Nov 2024 15:25:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="uj2lkao+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 905E8896E0; Thu, 21 Nov 2024 15:25:37 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 804EB896BB
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 15:25:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CECFB3F6BB
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 14:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732199134;
 bh=npcCkTVWlL+dh8rYBtaab5At2+Nh6El7FSG6VX+DJfA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=uj2lkao+Ia5s0xHz1lQKJ8V6qT7dzxF91dGn8V4wTL8Y5XTMaAr5TcONKWFxx+j0N
 0pCmxtjO/H5tD03LVUHJhG21FVghCa2xH2TYLWvSR+VIo4v+dinoYizVwyMdO4zRGB
 JflzZ9Bv/PaD73v+XvpV2qBvEmoY/AY2MK2HZ4ahJTceOt+oqn1720gdHsOu5iWmZ/
 GHzy+Ubt1YEojA1ahsPE18ce26LRGN92p0Qw7BYldj6VkCfHQLsKbIdt2+XytJjisp
 7VCBdLuo5Gmm9NvXujVWtnlO6QgEWBfOu6GlwwFf0h8LZ3LQRdoQtXpQ5S2qk8cVNO
 WrhZsGPCCA4oQ==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4314c6ca114so6384055e9.1
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 06:25:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732199134; x=1732803934;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=npcCkTVWlL+dh8rYBtaab5At2+Nh6El7FSG6VX+DJfA=;
 b=gJzdqGfTNnkcyc6ZFJ5AEJ2SdARCUyP8panGYP5WNwNrkHuugAHJjeO1o4koKcrmuP
 6VJyFu/UzXiNdKQMlss3IhEkPzx3JkvkR2mMatDKGZ0LLKEjf9/gRd6DjtJKg5QRzQgh
 XcCZkCa8fTtE4cmKADMwuWvCj3J+YqekSMSdlZ7dpjBOkOKEv5MQTtt1NQFozo6W1EAv
 f+XPXnipvB2pTfNdt69h7WwYPN/93CJDyC21SOOCxgbUZepIVxWMN/0e/sy6LWb5TUYK
 +lh/SF42OLq5nXRo9K7wmcoLZjl852aNEb2vPZN41D1rb4Hm04N3ZmJdqez+eas6okDN
 yWhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwHbJF56cmi/E5vfPZqhj8TK4tyETxwfex6uN6vTeq+CeAJH6q1PeuYGgdMgA50IGA78eQuRY=@lists.denx.de
X-Gm-Message-State: AOJu0YwKjB0Vopjldab3tUJhFxrQbVt6IVGaJz1HKIWsRTI0XuoLpgZo
 GmFiSRr7oqnhi1LghN4g5ChmT78XOVBt+ngTqHwyJKAegWn6pju++r8JiTJKCcIiBR4L74Sa5DA
 CjQAZf6Angf8L+SemvvdDmnEn7g1HTuzarANVZDcGMdzfeW0OtaAi6NrWQ7riKXqcBp8=
X-Gm-Gg: ASbGncs0knEKwAn5N7rBqqkexeoiaNdsj2KtKsdxm1PRmFhLNyp3HElxgjMYJ+rbJc9
 kk74cG4p49EZ31cH6CzOmLrjcsPBcZCCjwIWbrMktYI9YxQaBQLzOn69LXz5mhlulZf5grh7w1U
 asDfDwdnOMKGGRakFIFdu99s9TptpyEv0LCsx4F3Wt4XaxZGBfZPbKQsTnPItkzvivQfsJWDYBo
 0U9pG/rNC1ajWQwvF4Xos/8jveWdVRnc3EubnldxzoWWWha2L/8BVHRfhFCOEg1K2o1m//yE7sX
 xUoXdGYJZ5gziYveMbwEUYGMBNe7J9j4SfFjM6a3axgRXmeBHx4e
X-Received: by 2002:a05:600c:4f91:b0:432:9fdb:1490 with SMTP id
 5b1f17b1804b1-43348986a74mr60374655e9.7.1732199134484; 
 Thu, 21 Nov 2024 06:25:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5Hp0hSiFo3T6HkWYA9wrzMW0H3e51TFoypm7vVMdrGn753KAYID6Ch4P3pu2ykLe/6Vx0lg==
X-Received: by 2002:a05:600c:4f91:b0:432:9fdb:1490 with SMTP id
 5b1f17b1804b1-43348986a74mr60374435e9.7.1732199134103; 
 Thu, 21 Nov 2024 06:25:34 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b4616843sm57238085e9.20.2024.11.21.06.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 06:25:33 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Rick Chen <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Nam Cao <namcao@linutronix.de>,
 Andreas Schwab <schwab@suse.de>, Jaehoon Chung <jh80.chung@samsung.com>,
 E Shattow <lucent@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/2] configs: JH7110: enable EFI_LOADER_BOUNCE_BUFFER
Date: Thu, 21 Nov 2024 15:25:20 +0100
Message-ID: <20241121142522.59059-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

Our MMC driver for JH7110 boards only supports reading to the low 4 GiB of
memory. Booting boards with more memory requires EFI_LOADER_BOUNCE_BUFFER.

As a prerequisite we must allow CONFIG_EFI_LOADER_BOUNCE_BUFFER on RISC-V.

Heinrich Schuchardt (2):
  efi_loader: allow EFI_LOADER_BOUNCE_BUFFER on all architectures
  configs: JH7110: enable EFI_LOADER_BOUNCE_BUFFER

 configs/starfive_visionfive2_defconfig | 1 +
 lib/efi_loader/Kconfig                 | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

-- 
2.45.2

