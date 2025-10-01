Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8B6CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 13:19:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A2D681D6A;
	Wed,  1 Oct 2025 15:18:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S8huNWAP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DDDC835A2; Wed,  1 Oct 2025 15:18:50 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A1C8800B1
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 15:18:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6366d48d8ccso2014493a12.0
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 06:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759324727; x=1759929527; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z+xN4F0kM4dvlKkdW9HDuiRP+Bkc9RM0CgQigcVJ2HI=;
 b=S8huNWAP0FB9GLBeI8c8SmWCrkNWVz77L2bxmdtBe4wql8Q4I4swvorLsIUba4au9o
 606c+NYTufZDCeYR1aTD81NCZ3hV9NHkWVjY0fWLMcOT0HvrJ6TK2UWtLO/w9iOqpJ9n
 faR3uxyfJP5vLiAM2lw/nOvZAvMpALzbRvrSQ+55uqLsZ3zJRIjneHLX9r/9m2lgc5sU
 lxpEK2HYF9HQW8oJX/t2JUCzajQfYWy19jyPQlFk1g5msk6AvZWcOQK5oMK5byvHj2aD
 z/I9YDtz6h6bWxSy7I57qw3CEh/Q9bvFdwpuYGJiVgU+td684pQEou2FwmfwOojxVlhK
 65Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759324727; x=1759929527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z+xN4F0kM4dvlKkdW9HDuiRP+Bkc9RM0CgQigcVJ2HI=;
 b=a/Q02YqawVlXzBUe711lQQ6GndW14hqxCLHM5D/jFZnBvtxA75lU5iOnpwmMo9h6z9
 5WDcqaOgYGfnyMtjd1Xx46SPFvz3g5vlxv7xYJg3EEWyIg+jGjdirO0Lt3fHcARzrVzd
 ZTyPn9nAC0ae5/JmrWg8g0dVbZJwE6m3YKRBn2u+BRi6ZZKTnJv2vSlX3Si5bl5VBNw0
 t5NXiqDAjaXcKgSNLQFvVTUY986c9W09e45ZfQGmrWUqEW8CdZTkgGxwOyVjdkDxbNnj
 8JaoV7EYp6W7pedf7huQMIM4nbpsrNQ+pABohjojBaDmzukfYNRop5YVa7e9q9PgaNsY
 yC3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfzaq7bYDg+Brr1JsUeWvtjMr21yrlFfgVlbPI4d6hWpJsDgFNjSGiysjMPZEbUYBHX7CZPvQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzR8LretvQDSOI7u+r+CetYvpgBDuJB1gJmEJxrvuUAxQDxuldO
 VQPP162U9s3Wh5T6NKtsrQWjouK+GG1P6f0G2gnqVjzAi99oIW6kSgLvufiPJYzI
X-Gm-Gg: ASbGncsRBvm4YJrzBhvLO/9EeO8kEocbWgXId4X1ofr/HutEfTWmiK5MoVz3mnx2EDB
 /PhOAI5DzLNeiQRMQKtrL/K8LDtdbdFDYdJRjCuvr/3ML6WnPgnH6yCY3qDpkD1uHg0Ka9pi5F8
 Wuc048qFonyYbshKBT2YM84nUZbw/SHf36T7zF25FMEd4yQIjacwg63bv2Iw3vkGebWMI7xXbYV
 IUGapxK7NuP86sLCQ4RDE9+r7yfrxzgDYnRUNuu0PDyVlbuvoue3e9bZj79dxorEql8d6fk2WyZ
 u0iINcsD8qF9fOsmPtwhZQq3lBX4mW4bdEjk/Zkbl0MeYSMQcZIqpcginasQkPFUKzoPkceL/ER
 WwSEmGUjU6WHKvz1GQyzXjt9HJ9r5WFd2HcDb8I8tX9heQMq4pMmYC6Ugf1ip9E8zrCblcwR/vy
 wwtI2l1ttY8Y8ebztvfH28KivRM5c/u0ChrWvBGBhkgPoYDmBHKp6ggiRLtBeryw==
X-Google-Smtp-Source: AGHT+IGaR/JNfW115CCa3V3xRCENvAYAcnEDQWSYmSjtIiBv4dEj2H559zz4NvKF+G9xzKKCoocKRA==
X-Received: by 2002:a17:907:7ba1:b0:b3c:4ebc:85dc with SMTP id
 a640c23a62f3a-b46e4b8f008mr460481466b.11.1759324727444; 
 Wed, 01 Oct 2025 06:18:47 -0700 (PDT)
Received: from emanuele-nb.corp.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3d27759835sm757006666b.13.2025.10.01.06.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 06:18:46 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 2/2] configs: verdin-am62p: enable USB Gadget OS
 Descriptors for fastboot
Date: Wed,  1 Oct 2025 15:18:35 +0200
Message-ID: <20251001131839.1488633-3-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001131839.1488633-1-ghidoliemanuele@gmail.com>
References: <20251001131839.1488633-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

USB OS Descriptors are used to install and configure the device without
requiring any user interaction on OS which support them (e.g. Windows).
Enable them in order to improve the user experience when fastboot is used.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 configs/verdin-am62p_a53_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/verdin-am62p_a53_defconfig b/configs/verdin-am62p_a53_defconfig
index c46b883a9c61..6ea675fb83d3 100644
--- a/configs/verdin-am62p_a53_defconfig
+++ b/configs/verdin-am62p_a53_defconfig
@@ -192,6 +192,7 @@ CONFIG_SPL_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="Toradex"
 CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
 CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
+CONFIG_USB_GADGET_OS_DESCRIPTORS=y
 CONFIG_SPL_DFU=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
 CONFIG_HEXDUMP=y
-- 
2.43.0

