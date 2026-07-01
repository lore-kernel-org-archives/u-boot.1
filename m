Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD39C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 19:32:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6593484C60;
	Wed,  1 Jul 2026 21:32:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sSnmvGk2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 492B384C63; Wed,  1 Jul 2026 21:32:18 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C4E384C4F
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 21:32:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-69d8f70cb0cso788586eaf.0
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 12:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782934334; x=1783539134; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vyqqXKLSNXNrHHFzdLEiLKFjgLj8a8V8MLdn+bgmCvg=;
 b=sSnmvGk2dCkw0PiGopMi6WIVG8tXG7JixyliNkbiWPrSMt2aTaeos31f5JM/mFeBoP
 xoYNuqxrl4kc17b3FpJYLhEaXarW6Px53famlALY3ZGdiuvp2B7jXVs4cbF22hY6ZbqI
 qzzEzUJM/LNv1Fm66d9L8Sbg9IoYH8PICImcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782934334; x=1783539134;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vyqqXKLSNXNrHHFzdLEiLKFjgLj8a8V8MLdn+bgmCvg=;
 b=dGsYjbEdQBqrgoc3cSAIb6gIx3ex9bzrm8bjGl1GcqJ0j2DNDrdG2HVN2bIDN8XYff
 i38KW3FKaLV1EhDEx5wcpIu4QGpAR4AnRgxt0GmwKGDZ+p6FvKwnzPVaXbvVf2OITEpc
 4aEX/J+/a/E8/cI20H+nh5GXCFBKX8+PYBENOQMzL8iuSbRVgqZ2h+I2SNTIMxO94A75
 +HcLnWktvjDu8xiczIH/J1rgP2aD+HfXBChlP2QRDiiOkh6HtxtcplCZVuHVlC6Cmden
 bEqPKJZz7Z8vLCOOkj5dRJKLbLXR8Bkl8vzEEcNWceo/A9OXmCZKx/41v6wX1xBzUkeE
 FwLg==
X-Gm-Message-State: AOJu0Yy21JxFnRkxjJH8omMAC1zcQZrNVe7Nid3pYyY/zEz3VEsYoPIX
 OB+u2K+QrXlKZAcNcldkPUMSiD9BvXMccmgaYQe+h8/r+oWAnXnkFYnvAdbFQLmb4jg=
X-Gm-Gg: AfdE7cmRojsJ3qoEFNTSe7pdyBv2cRIU5ZDsyXyuxd7+E45ZdLxJ3MCcW108IxcenaV
 cm96MXXtC77s2v9RCsvM+r6VIRbQnxn1/FDUaYFW0sa/cUp7JWdixmEPNPajrP4ZLCe/ZrZeRWL
 9l255c0Bk0G3/qtiWoh9+3R7XdRkEATJdCMEFcbwV9/i7oXWstcD5JdPJjvvcYXeO6whdme7a+6
 EyTZyU8o82l93KxnmnjOvug6bpo5aJVkiXyHZ8X6OcXH+yPe5k6e/Ujtt3fBY+ttzwtIJdsSTQ7
 /opvgZgav0AzCEvcTiBb9H80h5f5WrwguXnE+7eSka4v22b7e2MTUtgzVSkg2qlIthfFjpaG7kF
 lG3fr+fx9kblQlTcGHvyv4/1vrIX0HMK1cugIHQ9QcRnZ7q0DAY5wBKIyZ4iHP3yr61z1YUsN99
 T0rs2xjbyXpOzzmawxXqfwKEY29flFaiVxnILndxXvpKHEQDqybKQRLA57YuAkMjAos/Q5VOCya
 M7Ex2LWVOoteZnSl+YSJ8wAQifapvQiq+OJmOJrIBITnAQ=
X-Received: by 2002:a05:6820:1897:b0:6a1:5b63:2ae2 with SMTP id
 006d021491bc7-6a30d7a3d0dmr1241941eaf.29.1782934334204; 
 Wed, 01 Jul 2026 12:32:14 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cbe84f609sm712763fac.1.2026.07.01.12.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 12:32:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Vincent Jardin <vjardin@free.fr>
Cc: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, 
 Christoph Reiter <christoph.reiter@evk.biz>, 
 David Lechner <dlechner@baylibre.com>, 
 Flaviu Nistor <flaviu.nistor@gmail.com>, Jeffrey Yu <jeyu@issi.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Ssunk <ssunkkan@gmail.com>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, Vignesh R <vigneshr@ti.com>
In-Reply-To: <20260520150032.1904130-1-vjardin@free.fr>
References: <"<20260510222140.603755-1-vjardin@free.fr>">
 <20260520150032.1904130-1-vjardin@free.fr>
Subject: Re: [PATCH v2] mtd: spi-nor: Add gd55lb02gf chips
Message-Id: <178293433277.2600701.12103819306441913833.b4-ty@konsulko.com>
Date: Wed, 01 Jul 2026 13:32:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 20 May 2026 17:00:21 +0200, Vincent Jardin wrote:

> Add the GigaDevice GD55LB02GF (256 Mo) similar to gd55lb02ge with
> the same read path flags.
> 
> SPI_NOR_HAS_LOCK and SPI_NOR_HAS_TB do not match this chip's
> status register layout: the GD55LB02GF uses a 5-bit block protect
> field BP0..BP4 plus a CMP bit in SR2 for direction (see datasheet
> "Status Register Block Protection").
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] mtd: spi-nor: Add gd55lb02gf chips
      commit: e800cc67f5b6cb50a20f37c993ec1cd4063bdbd3
-- 
Tom


