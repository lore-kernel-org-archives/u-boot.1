Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17236E77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 19:18:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27D96801B0;
	Thu, 12 Dec 2024 20:18:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YSa2Y6jL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23F1C801ED; Thu, 12 Dec 2024 20:18:12 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFC6F80141
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 20:18:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6d8f99cb0d9so8951306d6.0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 11:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734031089; x=1734635889; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Rby/CTuQtH5peQE4WObj5w7XqfE3APjH3km64DTrDQ=;
 b=YSa2Y6jL2oTuCoVVFTH6jxHqwSFDNHDj0K0PYEsNp8BkiMR0PudtVBMAyc9ZakC4Tn
 qx7YBHrtWFNVYYYmKYE9Nvg0JTduKXjwZKasLjgfVHklhrlJDtMb4baKtSG6U+Umokqv
 poT1J7fICvn3ZKnDa+GxsedKU4H6XMHFm5fE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734031089; x=1734635889;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Rby/CTuQtH5peQE4WObj5w7XqfE3APjH3km64DTrDQ=;
 b=c3vdy5RxjzgKOU1t9tEscFCIf0mp00FqJcJMgHX8L4aTtrHoRVqz4P1uSl4rUmrC8B
 A9UMgRvK6YxsX0UqEpTkkn3fiYDqhyT8HxIOlctq/n6DOnLH1bKtfeQii3Kxcu+ZRhc/
 4lSbzvD+FAN8EKigM3wd7RlkPoAktZJmbjL/IpAWo0kLllxauK9KL+xQ2bWmhljppu4s
 EF4fBY8wFoaqGY0/kYZ8cUuzfDc85XkU097gh0XroaiizmenBVfNWVL2Is3MLlKWkcSO
 awEYWSRWVagaoN6hBWPjkQ2u7SxSYw8F1WJmyCYbMevwvjKesi6grb4FrvjqLeAa6wLT
 /hzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtpPTUm4Wf50wW9X6HINzZbhqNFVO5IHkgRjIwdMqYAtakaBMADGbxM01x9hdPJzla0U5aidc=@lists.denx.de
X-Gm-Message-State: AOJu0YyN4PqF7ozOq4mt5nogqx/f3vs9fT667u2ZA1ICOkZuhVhYOHPX
 pVEFosQxToNacURhYby6G1DJzW4JakFpvQ56uOCdOwCcfSgEVooSC676YwrZsf8=
X-Gm-Gg: ASbGnct7AlLy2A/Vrh4zjmSaQiUKqZCbhWx4HYJHBXtJV828nytukVqx7jC9x0aqSkz
 QxOhlt/HXdSz7SxL/amMcPnIrRwTUB3VrBYlfuhwFdSr27Vef15OJ4YdCZO+afg4/wvIXBF9++F
 3CC116V2H3jC09aMxrXrNoWzFJBttOgAVVNOhgAQNQifp2bDzBuSQAcapnoleMuBgyK/O/xjg4P
 dLJcT0zyLlHyn/dVWn/97qW0k8JQpXCZRZlhqVeJ+10d3WpTJ5nQOU=
X-Google-Smtp-Source: AGHT+IGZ0JS3LduBjB4uOvEvj3N7NZWJOAjlHLMnWtTV22TQbRNzOMknxPrmnrI94NMlTUAfVsdABg==
X-Received: by 2002:a05:6214:2429:b0:6d8:a188:369a with SMTP id
 6a1803df08f44-6db0f8502f1mr17689476d6.48.1734031087283; 
 Thu, 12 Dec 2024 11:18:07 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da6968b1sm84705546d6.39.2024.12.12.11.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 11:18:06 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Martyn Welch <martyn.welch@collabora.com>, 
 Sjoerd Simons <sjoerd@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, marex@denx.de, 
 vigneshr@ti.com, nm@ti.com, j-humphreys@ti.com, 
 Roger Quadros <rogerq@kernel.org>
Cc: s-vadapalli@ti.com, srk@ti.com, u-boot@lists.denx.de
In-Reply-To: <20241203-am62-usb-xhci-v1-1-a791cb914186@kernel.org>
References: <20241203-am62-usb-xhci-v1-1-a791cb914186@kernel.org>
Subject: Re: [PATCH] configs: am62x_evm_*: Fix USB DFU configuration
Message-Id: <173403108506.1608151.8047923336284496635.b4-ty@konsulko.com>
Date: Thu, 12 Dec 2024 13:18:05 -0600
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

On Tue, 03 Dec 2024 22:40:29 +0200, Roger Quadros wrote:

> CONFIG_USB_XHCI_DWC3 is not required for AM62x as the XHCI
> driver is registered through the dwc3-generic driver.
> 
> CONFIG_USB_XHCI_DWC3 causes problems by hijacking the
> USB controller even if it is not set for Host mode in
> device tree.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


