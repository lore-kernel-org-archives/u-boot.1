Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB166C5B549
	for <u-boot@archiver.kernel.org>; Sat, 31 May 2025 14:23:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D2BB82B27;
	Sat, 31 May 2025 16:22:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WS0//vFN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABE2182B07; Sat, 31 May 2025 16:22:42 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C5E482103
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 16:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7303d9d5edeso884120a34.1
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 07:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748701359; x=1749306159; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bf/1RT9j49uT7u6bF6mknZuWPz7yvThlgIgUJYhMVRo=;
 b=WS0//vFNXQOpJM2lB3hOGV9OyNJ2AH8Hejc6/H/aCXH7WFoGfdqnJotctcAonTLUkA
 t0jIriZ5rsARIqIxNH67L6NNOFR/tLLY7TBTW7/PGA7Z4ZSIe3e5IdQOfqLIbMnf4pE5
 q1TEze6qo8YV2AlPbiwZSLCVdptB5D6uJdk7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748701359; x=1749306159;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bf/1RT9j49uT7u6bF6mknZuWPz7yvThlgIgUJYhMVRo=;
 b=a6i8KuWgjWGQuAEjQiSTWTEQ83neGMNbhnFD/v4fws6P7sziJODeC05Chf7bpkf/D4
 Vy2WtWYBWBMuCloLL7VlU4Jm1jjteg5w2BFwexyYvER/eVMWtrw1eNK/4Zz7zbrwyYXZ
 vDYcciA2OXuZBq6qu+aOGZ9Jqw8hkGNvRFaoPa9rFgIy7/gmAWeR4wkvh+f7TNASNR1Q
 XKiLgP66nai6+Dey0Eek2eQfTEKu8rgN7Otv3Kihnf6P5u6JMfhTSYT5SMfYF9QF8X+7
 MXJwxnbxQlSrgUdXx9OuL43mAR3NWY52YnL56skuV5ZWlkFUUKHUMQUDcTE5SITOHadR
 7J3Q==
X-Gm-Message-State: AOJu0YwI1O/jsZWwb8akyToWkKne5p3L28x+6ONU08Vr70hBUPnHQcZd
 7AoDeJEwsTyIXZbbJ3/f62IbAtQYC/S80z55bILt/ED36delF2uwRtWNV/DfoqOGKoQ=
X-Gm-Gg: ASbGncttbY5c7jI3GO+VbdF3tXFhTd9qScOqm4IyOgJTPFq2NnKlUZClPfJqSC3Kpy2
 sr6EFKQciCy8oA+xtmf28sYg+Zp5Ub/GiDwcJ1yJ9hC1porcunXb5SLfY1VOjhkVvuJvrzZtT8g
 ABOV9s7qzuKWeQoMTlHlbgtKeV0pJDLkr20BX61rCcwzlM/MavEyNeHLtxRss5ukwRez0104zHX
 aAXtDkPBtLH6FwGB9KIlAleUcXoIICa7oCv7MgeggQIkrRTLtKRfsG7g5I/zJ6oFS7FQOdhX4IQ
 FxuxPlyjRX69H1sod0Cr1VbYtqS7dIOJRpjFPUbXuunxg2gNvMsFBk2xuT3sgTFTfhE3woRSq1F
 bjSTq39cfAx9bOAO6QscgHw==
X-Google-Smtp-Source: AGHT+IG97AMyIfADz+YwoLdEPhDujNDvFcHwwh8a8rc3FL3f2/c+WqAkxU1t193jnVpTPY8TLvfgkQ==
X-Received: by 2002:a05:6830:63cd:b0:72a:10ec:3542 with SMTP id
 46e09a7af769-73670a003d3mr5039565a34.13.1748701359312; 
 Sat, 31 May 2025 07:22:39 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-735af855ce7sm938083a34.21.2025.05.31.07.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 May 2025 07:22:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Eddie Kovsky <ekovsky@redhat.com>
Cc: Enric Balletbo i Serra <eballetbo@redhat.com>, 
 Aaron Kling <webgeek1234@gmail.com>, Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Michael Walle <mwalle@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Nicolas Belin <nbelin@baylibre.com>, 
 Roman Stratiienko <r.stratiienko@gmail.com>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20250521212714.100357-1-ekovsky@redhat.com>
References: <20250521212714.100357-1-ekovsky@redhat.com>
Subject: Re: [PATCH] image: android: fix ramdisk default address
Message-Id: <174870135818.979488.15784125034163341802.b4-ty@konsulko.com>
Date: Sat, 31 May 2025 08:22:38 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Wed, 21 May 2025 15:26:59 -0600, Eddie Kovsky wrote:

> Commit 21e7fa0e3ac5 ("image: android: handle ramdisk default address")
> changed the default behavior for header versions less than or equal to 2.
> 
> The ramdisk address (img_data.ramdisk_ptr) is only assigned to *rd_data
> if the physical load address (img_data.ramdisk_addr) is equal to 0 or
> the Android default ramdisk address.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] image: android: fix ramdisk default address
      commit: b22a276f039f818d5564bec6637071cfc8a7e432
-- 
Tom


