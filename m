Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353C2D0EE3F
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 21:11:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 562AE893D3;
	Fri, 11 Oct 2024 23:11:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rLGAhkp2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 790C789291; Fri, 11 Oct 2024 19:36:04 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BD0E893BA
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 19:35:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6cbc845e12eso14525796d6.2
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 10:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728668158; x=1729272958; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UqLRGfvA1vqsWHIW5/gs9s/71de+DcfM71nCIDSVm7M=;
 b=rLGAhkp2ih5U04KfwYjZqk1XHyWG4eEUDxpyhSrkhkHszxYOZf3Ez0WReEIKcNXibg
 MvhgJScf1m0PrNTNLeVkdYhfMAZREOJ6Afg3WOM6GSupq1TjdKFBMTHrgyO6h9ZXcn+I
 /qsPI7ETuH4KMtIIiYilp8Xde0jI0pyfAzr24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728668158; x=1729272958;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UqLRGfvA1vqsWHIW5/gs9s/71de+DcfM71nCIDSVm7M=;
 b=WD0nLn/r9NKvpHoNU4Tof6xh4Gt6W3mziiM7/Tmkec56Pkp2ocrrtWqCrmmmb6eF96
 jTXbpx6xIpH7PlE5tIFqqqU9NhjoeoylxmSJV+vviVauVkm1WGDs+b+Uwlg94Y7h5BbC
 YHKoTimQzb28ZpB5SkIN3Y5X68sGGKSlIOKv9PIef8cucGMIOYRJSzj8hOJ2M6dtyhC+
 6TZG7Agw+wXJzlEFjwYr30HoNo8uQdlUJUZ/BnrvP0w454tNVn5RRYoiNMWkA2vLjYK+
 T4GkbSQDJk5f2xZxXD0umQCnXEssUQsWf6w2BoFfk/tcdAK7F/8crcNaFzgNRX/lGKVm
 vMZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDjJb6dg/vp6DJNloWwNNiySj9xSDRXBuBrcTY1v3rfwq6vQPdUiscWErUHprLyPraRPYzM84=@lists.denx.de
X-Gm-Message-State: AOJu0YxvfZdYpVZnJSYIe2Q1k+qIiMUWqtnF5EVGN4p34tFIbd7xWvBP
 1z56iVSPOl0kl4SNu24WyKh5VIfw8IoLiRhoHUBbFVU6dILONE/ER/Fg8cf9TcY=
X-Google-Smtp-Source: AGHT+IFkAutn8eENkzR6uv27xOXsQ/NU1slsref1DHQrAVbsRJSfBcPldReKuQLLR7DiH18keNIUgg==
X-Received: by 2002:a05:6214:5b87:b0:6cb:5273:7265 with SMTP id
 6a1803df08f44-6cbeffc1edcmr48081686d6.20.1728668158236; 
 Fri, 11 Oct 2024 10:35:58 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe863596fsm17429906d6.123.2024.10.11.10.35.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 10:35:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Etienne Carriere <etienne.carriere@foss.st.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>, 
 Sean Anderson <seanga2@gmail.com>, Eddie James <eajames@linux.ibm.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Alexander Gendin <agendin@matrox.com>, 
 Yang Xiwen <forbidden405@outlook.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Martin Kurbanov <mmkurbanov@salutedevices.com>, 
 Alexey Romanov <avromanov@salutedevices.com>, 
 Artur Rojek <artur@conclusive.pl>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Vasileios Amoiridis <vassilisamir@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, 
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>, 
 u-boot@lists.denx.de, John Crispin <john@phrozen.org>, 
 Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20241001122511.8832-1-ansuelsmth@gmail.com>
References: <20241001122511.8832-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH v5 00/11] led: introduce LED boot and activity function
Message-Id: <172866815454.527446.4622364913211320386.b4-ty@konsulko.com>
Date: Fri, 11 Oct 2024 11:35:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Mailman-Approved-At: Fri, 11 Oct 2024 23:11:27 +0200
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

On Tue, 01 Oct 2024 14:24:33 +0200, Christian Marangi wrote:

> This series is a reworked version of the previous seried:
> misc: introduce STATUS LED activity function
> 
> This series port and expand the legacy concept of LED boot from
> the legacy Status LED API to new LED API.
> 
> One thing that many device need is a way to communicate to the
> user that the device is actually doing something.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


