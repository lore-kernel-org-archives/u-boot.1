Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D53C2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 07:17:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3CA8883C3;
	Tue,  9 Jul 2024 09:17:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QE5AtmMh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42FDB884DB; Tue,  9 Jul 2024 09:17:05 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0C6187CFE
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 09:17:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3678aa359b7so3591777f8f.1
 for <u-boot@lists.denx.de>; Tue, 09 Jul 2024 00:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720509422; x=1721114222;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SoyKVETrX5Pq/tIMOU/NJiOc4r/hkEnxsZsD6n49jsE=;
 b=QE5AtmMhIZCPNeD8FHMEAxt6RmwyYilvzeOtXShEsSUQVv36CRV0sLBsYLg0BEDEcz
 2ZBpGAU1GCzfIoZAZ+AA9tigWQdNfvVCYruVU22EVzDZEt9df3Khha3MgEE0x01TQD/B
 lZYOyVk8k8GHU2rUVpX0DRW4A6275Cmh5DGGs5UxOwiVU5ISjFOPz0lc6gJeKdFlU2D/
 f63m4sv/fSayt1mIuu+cfvjn3C3E3mCoZRZ3J3F7roMT9kkaXaCALe8amZrxwqePVpym
 PX3qBO9EUTW9IkFshVc9bPaD5ZysNH4NVnpbkTn6viIPc+Gx6kDDKWXpcYomwM9lQBE6
 uDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720509422; x=1721114222;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SoyKVETrX5Pq/tIMOU/NJiOc4r/hkEnxsZsD6n49jsE=;
 b=sp+Ta3oNrbHBbvr6WsNzNTcaYkbDqr8vbevWMwK+3bPfMCkiSFy6tgThXKD6NEjCdP
 oAVGUFJX7qBg6XdCp1bzdj+cheQFltreL8utIn43ECYImBXSdpEHN12vCjAHV7+o5/cv
 PGXY8DKsJE23H2L3g98evyQK4skU/P1h4hb6A7Tty99sHnebvxmOTDz7kqRBlCicl1+6
 /ULQjatzLq5kqm21QUAe+lNItmadzTnshDdssB/itIKUKAt1F1MVb4GR4jhbeBFt+iVg
 ZIUum9hr0tpwrqBX95wvhS7FVjsqHZV5nB4zEcLP9XX8Ynf5qYmcm8Nd9UKBjrdEackd
 myYg==
X-Gm-Message-State: AOJu0Yym55XPXC9Y7deDu38vBnXLGjrBXbn+RXoAEujK1qyUOOmraQuZ
 yJV2vThKBFv+yE0PydZPR+Dj+AN0ZDw2wvRRd5O6Upzzmoz9+llwIrnkSVTzlEvMbHA0VWUjxdn
 r
X-Google-Smtp-Source: AGHT+IHqyVUJLmCWp8GsZgbrp7fxVYRSGuBgEwioP261DlCp1JTPxYsP7yxrgKFo/lfzWZbnojuqIg==
X-Received: by 2002:adf:9bcf:0:b0:35f:fd7:6102 with SMTP id
 ffacd0b85a97d-367d2d60bf5mr709911f8f.35.1720509422035; 
 Tue, 09 Jul 2024 00:17:02 -0700 (PDT)
Received: from mkorpershoek-xps13.carmes.etincelle-coworking.com
 ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde84720sm1658849f8f.31.2024.07.09.00.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 00:17:01 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Alexey Romanov <avromanov@salutedevices.com>, 
 Ion Agorria <ion@agorria.com>, Simon Glass <sjg@chromium.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240621015135.1570605-1-caleb.connolly@linaro.org>
References: <20240621015135.1570605-1-caleb.connolly@linaro.org>
Subject: Re: [PATCH] include/fastboot.h: add missing types.h include
Message-Id: <172050942137.12866.3736886577544839128.b4-ty@baylibre.com>
Date: Tue, 09 Jul 2024 09:17:01 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
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

Hi,

On Fri, 21 Jun 2024 03:51:02 +0200, Caleb Connolly wrote:
> Fixes a compile error when building with only the TCP fastboot implementation.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] include/fastboot.h: add missing types.h include
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/b091d3872833a4b8d088ee41348a2d4ff48067cc

--
Mattijs
