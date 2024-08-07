Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E621C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 06:38:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0687088B02;
	Wed,  7 Aug 2024 08:38:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0KscS/xU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26B3888B58; Wed,  7 Aug 2024 08:38:50 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F098188B02
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 08:38:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42812945633so10421135e9.0
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 23:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723012727; x=1723617527;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SGzV7IxWHy6K85HItBtoYQsNj+A1iamN4kEa+tHQUf4=;
 b=0KscS/xUSfI4j+2hj2RFv0IklC6cZIi29Z17G8RtFlbHYlz6KhSAymEfNEFKA/uLgI
 7HaY2197fE9BzJFmg+tO/A4kf869J/7ge+aKOf084DQiFfGFtf4xr68sSCGDaAvPhLOG
 YajbBhoPSUvZzxcEzwK5O+h1/tc6hAI88B3MJamcID6ovvPE8gqEt6Y0EnYswDMaI6pg
 E9DQ7yJUNXpSYrU0/FNvC/1sbjrTe5vVM+Fz1VWAi2EsiUCuaRr/eoZMwk/d3ZpPjhEB
 0HPcHuEUa/whCVdOWpM7E6makBfK9+V8gPfKDh1UbK1fG5yZ7PMRzz54Rlt919RlwLGT
 5HqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723012727; x=1723617527;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SGzV7IxWHy6K85HItBtoYQsNj+A1iamN4kEa+tHQUf4=;
 b=YVUJtGbtFXG9qBujaogP8XoosGsg81JXl5OJYt6NACChvjWtXmyLOgMrvx72Lp4GK2
 ERVDyZdcPh77EdnCwl3VEA+zIE+KA7S+N0vgzQ3LxfPb3+l2wWD7ur6SN+vnrdCcZEQt
 yXbjlejotaEzDViFWhrJWaMRBTAfOfB6iPzUi4VZj3xHgYuP8ZPRWyxUqo0sH/yllxtS
 pYx/EdZVUzgGeUopYQ6JNhU0pwv7mHfjrNYIorFB9s4leFJDuiNcUlt81GVERzhdhvmx
 zJU97VkKcxIQFcTqEHTZuMSw7Cm5PRSL+vw02M+Tte1yjOeZt2k6BM5egN1sZ3Sh4LFj
 cRCw==
X-Gm-Message-State: AOJu0YyxlkQh7f5+WJYT84nz5tHb9tYjqRJzsrLXBEVCGzIF22RNyB4N
 h8BcDifHgBnrhvlN2Pq58OoHSXhXqF5o/dq0r8CZRA7yEHbPoDJBdTb3q2C2+Fss/8JchrnMnpr
 l
X-Google-Smtp-Source: AGHT+IHqlXTvBj0fYgIwTg81rD4D8JgNQX4M5GcRox4kSy38mZoAcmw3ZL3e3XylYDPrhW+F0Ff/+w==
X-Received: by 2002:a05:600c:a43:b0:428:16a0:1c3f with SMTP id
 5b1f17b1804b1-428e6b83288mr136456575e9.32.1723012726528; 
 Tue, 06 Aug 2024 23:38:46 -0700 (PDT)
Received: from mkorpershoek-xps13.home
 ([2a01:cb19:8f40:f900:f167:cb53:a707:1347])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42905801d37sm13150795e9.31.2024.08.06.23.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 23:38:45 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Zixun LI <admin@hifiphile.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240726083102.380719-1-admin@hifiphile.com>
References: <20240726083102.380719-1-admin@hifiphile.com>
Subject: Re: [PATCH] usb: gadget: ether: Handle gadget driver registration
 in start and stop
Message-Id: <172301272563.244852.18199647448023901472.b4-ty@baylibre.com>
Date: Wed, 07 Aug 2024 08:38:45 +0200
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

On Fri, 26 Jul 2024 10:31:00 +0200, Zixun LI wrote:
> Revert part of 718f1d41 to move
>  usb_gadget_register_driver()/usb_gadget_unregister_driver()
> back to usb_eth_start()/usb_eth_stop().
> 
> usb_gadget_register_driver() will initialize the USB controller which
> enters ready to connect state with pull-up resistor enabled.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] usb: gadget: ether: Handle gadget driver registration in start and stop
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/d94c0ee1de89e2fbd3cc5bea6351dbaa9462c84f

--
Mattijs
