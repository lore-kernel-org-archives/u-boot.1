Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084DECA0EEB
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 15:53:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E2A0809A5;
	Tue, 19 Aug 2025 17:53:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WyUYujw4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77D7580FA1; Tue, 19 Aug 2025 17:53:38 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CCD0802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 17:53:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3b9e4106460so4324357f8f.2
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 08:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755618816; x=1756223616; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qFu12/frkuNynUyQ90/Gcao/Tlj5NS47sRtF+lN+Hmc=;
 b=WyUYujw4YnZoPa40WGOvDCUwMFSsPOrIGyWLCZmFV+EpKgvogWbFvWiCcOMGfBSJ5G
 Mulj4K4V2818byBMY8sLLVqrCNsayYEUL9697eEJ4X1SZ1MKT7/BbaKtVXh1SqWqpYTO
 2szMmlLj+tkXU/1EoC+pzb+AK/P9ku4ofacRJ0JEjmJgxXb/KX3UyO1jTRBDz7fuvMNC
 o9NvgAfM56InR3hoI2ulCat6I92t17GORsNqPL5Y6LIwEVGrY/naQVc6VQl2C0oVXKvt
 jMjrsh+ozJAYkbApL5dIwNoBwYoZO6EWRPZQA80SfZ0OF+HKjBCZ1ligY4amj5PfTHvF
 Ideg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755618816; x=1756223616;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qFu12/frkuNynUyQ90/Gcao/Tlj5NS47sRtF+lN+Hmc=;
 b=ITKNErXkoUzKwrhkMHvWhT877pA0tj0DEuruXVtsDuEflI9GmPpPjmA7yp4m5On+2w
 sUjpOuT5KsvgIhuodQ+Ty2AgB07xif2z3R4sz+KfbMFNXav9RyvQy5TIXlXPifaR5YgW
 NZUIbT09JougleHpoiYIYYM1YjbQmBJUQ5dvqk5jlNUk9MVHssQebUERbjawUxpe0XvL
 4UDJorrIpqv7r4g6StuP1l9+d88rOs8xiJlEVD2JQWkJnQwCCBYrkv5tYaRA+p8FwBw7
 3wgJNJMPxESa2cYt4Kf2wT9nhvWdcGagoVow1ckWiKwfxZz/R4cfJHtlsbHVqCddW2x/
 SBbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhO0RUg7E5YVHQOs7ZfdoW7tytT7VEPGvW+6CCrfWQ+4uAToza9FJ4n/O/b9xCvPoXs9G5l+k=@lists.denx.de
X-Gm-Message-State: AOJu0YyeBbv5rR8HC7XcEB9weH1ZVHZ086IbJpD/m5BIOY4Na4rtcvPr
 CL0enYX3prZ2ftKj197nbaK8+DeyEEwdJmzAt7iySWJT5F+AH4/Po71cNvCigCYt/BH1CEfiMNJ
 U11GBJzidaoc5DHF6baUPWU/yx2BmDqbH8A==
X-Gm-Gg: ASbGncs8PetPoXrKbMFL/ymjWMTlcpB1WORLIb7PCYJbl64my1hs7ftRNQha6VGWnhS
 yDF20yAR3X5pZuD6bVoiu9H1lv/yVCQHGuhx5o6Aca8lSXL53yL4XzfEXHA8dLtd8Xq7J6qnKzT
 OUWr3dJOJQTlxm2PRyFCgQNk/6t/8xYOcdvbVlrvV4UZih2XuCnDmv2LrPmMpsLK5wNZ5qVfTXU
 IJzj5u4EIlc4oKUBEI=
X-Google-Smtp-Source: AGHT+IH0LBl0ZoqMxJgX+vIj0dMlZhrhs/JiWJjoJUhwWmcMi7ygPOvThjcS9bHuF6gx3+rTSenlDYVDxEZd9XePdRk=
X-Received: by 2002:a05:6000:2886:b0:3b7:901c:92ee with SMTP id
 ffacd0b85a97d-3c0ed7b9188mr2171582f8f.58.1755618815761; Tue, 19 Aug 2025
 08:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250819154025.604784-1-pbrobinson@gmail.com>
In-Reply-To: <20250819154025.604784-1-pbrobinson@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 19 Aug 2025 18:53:24 +0300
X-Gm-Features: Ac12FXw_sLDbk__Wkn6UgXmvgvo-t1VtI_eYl5zc9V9uxprdkDUuX-_EYEgDI5Q
Message-ID: <CAPVz0n2UiG2exN-mBDLv2jX-5+DVmALRwQ1ry7o5LzVL5zQoOQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] p3450: reduce size of Jetson Nano u-boot.bin
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>, 
 Tom Warren <twarren@nvidia.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

=D0=B2=D1=82, 19 =D1=81=D0=B5=D1=80=D0=BF. 2025=E2=80=AF=D1=80. =D0=BE 18:4=
0 Peter Robinson <pbrobinson@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> The Jetson Nano contains all it's firmware on a 4Mb SPI
> flash, the allocated size in that flash for U-Boot is
> 753664 bytes so we need to ensure the u-boot.bin doesn't
> exceed that else it will fail.
>
> Add a BOARD_SIZE_LIMIT and drop a few large, and somewhat
> esoteric, options to bring us back under that limit.
>
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  configs/p3450-0000_defconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
>

Thank you for your contribution! Both patches LGTM, but I would like
to run a few tests and checks. If all goes well, I will pick them.

Best regards,
Svyatoslav R.
