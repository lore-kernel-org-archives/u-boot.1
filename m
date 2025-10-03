Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6FCCAC5B0
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 19:09:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA0AA83835;
	Fri,  3 Oct 2025 21:09:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.b="Z9f8OIXh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 187088381D; Fri,  3 Oct 2025 21:09:25 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BBF283835
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 21:09:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard@sigma-star.at
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-63963066fb0so241990a12.3
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 12:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1759518562; x=1760123362; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WA1m4crk1afqHvo0eEF/gqy7bLOW+nBkWjDzib/sORY=;
 b=Z9f8OIXhP8rJL5J5VD0QNJh9aImLXcH/4URMvo86X59XAjJrAhfdBHAnb8aHUqTO8Z
 MpX5jxvq/aZWWiOF/C0w/YFAu2sKv2OtTZKbO6mVo+FKEvDEQqA+4u3fhMofY686P9Oe
 DTsUUoqQEGD5pZA+Hmt0m/N+XDUQt2NGZ3oVSqqROq3cLRMXkjbgPZ4GM7cWMfUT4YVd
 vBB4w08NSOu3rK+plz8hmbbf92WGe1XScWDRvwnhWv/v3pJ5T5axC2dS7fzM9XMwxZdZ
 OT3LrZPXAVvTOglYU/1dW5euxhji2R8IjfW3fWbAde77qqaW9mL7wohr5Q1XHJi0RWlH
 JylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759518562; x=1760123362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WA1m4crk1afqHvo0eEF/gqy7bLOW+nBkWjDzib/sORY=;
 b=TjPJ1yTCU+6D8XgAHORyc3gsqOmfwTCvrf+TOxiIlnZNdSA5xOCJRdjt4zvxprEvmK
 9HKiSyL41uOxZCKh14FMaUrQKr1nukFSjdhafUKz1/1OQyPM1fq5vue3mj74cpNfPcI2
 /pgBSzxC4cPV9BaPJiE0Ah0FfGOMXJN6aijWcBt3BJnzuvZmgoWaxEzRnOs69TpUDaTU
 hLCSyWG+WxhUBrlyGmqxbmjiLNjMBgAh/aALNiAp9s3e4JDkXQXpCX83Lz8aCFvE5oKQ
 fWn8noPHgLngwOBO6voHTXDGuijJfPYDHXmu64Q0bxLI6AJkAttZWQWQIQnCsMQ48rFy
 ssRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVARF9ncaSZk1kNjBHDEigpwKgE88iG5yUw8p6NAZeZpPVvn0MtKXlr+2bZ7JuR/CbcgPhfLIQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyXZ7SAKLnJ7qqd2Q3W+Npymg4kCSJ3mWLHCBZT7uI5S6ikHYCv
 0LEkxKqEdocs5zIc0StKN5PWdFTgfQZL3nvF4UMEihdDbn0Jxq9gWzDJJySLOWEJA9U=
X-Gm-Gg: ASbGncvd3mktHYBxpTtmrXQu892s8l3egv2S7ziIoGKLHwCr954usptKZbEOJdUQQE1
 1ouJVTdv2P8/Tv92YreCm7keRj1jR7AABUjXEDXerdXQalEgaPtWkSSHv4DGF2Chvd3qd4VQH4T
 ZiYf13O6kOJEFm1c7fmOynjFtzB3kW0x7ttRaSQJI/JueLoWqcWt5FtLynC1/VBu7m68hGI2k0i
 QOzIafTjYdRS17/tv0XqSpFhD7FoC7Qta8E3NeTQ4rs8hY/SddSy5Yp1m7vk/nHMRrphklD+Ytq
 gXZiveIs9TDvhYYk+TxW17pK3bEmm/HQBpWdnTMA4bLZ4xo8uN86gfdYFjSWeL8ZBltoYt4FEry
 mTnO3pt/QOJiwK1/trexp4QjZBR+n/LMwpDtuAqJOEsP4fokvvDAZgqnPJ3TfA4wuUdOqCUW9xc
 eQ2pmJE3ahGt4=
X-Google-Smtp-Source: AGHT+IFcLXuHVeFjMVDqAVrAB82PMjXL+KeD0KwkehGVgKqtmI+vZRCIcJql+2exCkUFV2BrTRMljg==
X-Received: by 2002:a05:6402:254e:b0:62e:dd2b:b700 with SMTP id
 4fb4d7f45d1cf-639346cf52fmr4069891a12.2.1759518561933; 
 Fri, 03 Oct 2025 12:09:21 -0700 (PDT)
Received: from somecomputer (85-127-105-34.dsl.dynamic.surfer.at.
 [85.127.105.34]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6376b3abcd7sm4566393a12.2.2025.10.03.12.09.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 12:09:21 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Richard Weinberger <richard@nod.at>,
 upstream@sigma-star.at, u-boot@lists.denx.de, ddrokosov@salutedevices.com,
 sjg@chromium.org, tharvey@gateworks.com, ilias.apalodimas@linaro.org,
 kojima.masahisa@socionext.com, upstream+uboot@sigma-star.at
Subject: Re: [RFC, PATCH] fdt: Make sure there is no stale initrd left
Date: Fri, 03 Oct 2025 21:09:20 +0200
Message-ID: <10664479.lqRGMn8q6B@nailgun>
In-Reply-To: <CAPLW+4=gQjdoQA0qy71iDwAJz-fqekfGsUbar00m0Rm65YTHhA@mail.gmail.com>
References: <20250529150213.27149-1-richard@nod.at>
 <CAPLW+4n42ctJC2j5vUnibcWNYr+V1t8jfmD7p1ju95q8R89C-Q@mail.gmail.com>
 <CAPLW+4=gQjdoQA0qy71iDwAJz-fqekfGsUbar00m0Rm65YTHhA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Sam,

On Sonntag, 21. September 2025 01:01 Sam Protsenko wrote:
> Hey Richard,
>=20
> Did you have a chance to look into reworking this patch? I'm still
> carrying a revert locally (to make GBL EFI app work), and would like
> to get rid of it. Please advice if you have a plan on handling this in
> the near future.

Before my vacation I had a look but found no nice solution.
So, let's process with the revert.

My current way to work around the problem is having these commands in
my U-Boot scripts:

fdt addr $fdt_addr
fdt rm /chosen linux,initrd-start
fdt rm /chosen linux,initrd-end

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y


