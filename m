Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85CF3CD4F21
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 05:04:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93A7B83EF9;
	Sat, 16 May 2026 07:04:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LCwDsrHf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A52383E81; Sat, 16 May 2026 07:04:45 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0748B845E3
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 07:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so4606805e9.2
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 22:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778907881; x=1779512681; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rbO3gcaCP001DrFZ8X4JsqATun2Kc1mGof4HOgLgopU=;
 b=LCwDsrHfauUy7xBjYZQfMoPFfOHrrlyLS/O21dszCS/ZFiZZ4+zkDdYy3A2JOsjy9F
 pePQ/RHlbdODFM6mvJVfsPSn2cRJRgs3Wdn+narUUgo+NK6TsUKe4ZEMMcrrRGR6htIT
 UtJM1Hpj2yprPnvqqAruGp2bHW9sSeLYkalMYXE1h4XBnSjAGobqjZutGE3oMfcj81ce
 cjWTnyrQszIpNc07oFOfGPmD10DYoIcQ4/l+EriSTT3TxVfJQhpwECUKjAEmwQiEUGYW
 HwST7q+s7JeZp54D0SqpIt+iREBQgxvbYRa2pO01BIqGWCkDP3S5RP0xhFQhVLRqDQt8
 z92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778907881; x=1779512681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rbO3gcaCP001DrFZ8X4JsqATun2Kc1mGof4HOgLgopU=;
 b=EyVK2jbqUAirZasRjx5T2D0UJHNpnIdmhgJDsm98uFBUKYRZS6vMWzhd4Jv8qzMoWP
 VyuhPzr1VZx2BKIVUvLhfmfjACzEMDp1odqeNhallYjM0LO/0tD6i8ZCjuC0+AQ8mhcA
 8l6ANZHB7OaWDvCC+y7qP9xN7i6Dkz3pwAEcC+wj5S8N3hG5o1wUztZCHQaHCZ1NE3VC
 Ujk5kG7QjGSNEzSBk3LryBMSLt7f78LNczmurLw0W2iCMOaGGjWEeYdxwMvxEujUzP77
 uClyY73pwAWGI8zUoeNaR569lCNMSK4MyMSkaN/EKOrqrjRz0vgkGB+zo5bXT/JNJTlZ
 aZQA==
X-Gm-Message-State: AOJu0YwusHCfVnN1JAecuGLuTaIU2FefGTYhsEFmce7IbhOywgnjk6mR
 O/wl/swQYqX0MsEd571PUuuzqySl7wjxsWA55p5MF7TTVA7SYKHYdrnzC6yKew==
X-Gm-Gg: Acq92OFL3CFcKzKnW21PaHfx/omh+oidKwEjpgzyPVw6t+zJf7cpQ3X78Cg8ns7J04n
 LeE3VjfJjsyRKWHJp1FIrZXyboPMyaBaf4vSOuoevte5Xk8osfVmC8TppOJfpdUsnAAp1o61rsD
 +a2WyW7LjA0sd3n21Ig9mG2w1VMJTp5dvYl1wsHzWnzrJ3ee8nQ1aOKlADvZ8+EULV3tepGHY0i
 679rR7jTI5sikyIEXsW6bPZZMK8dI6SGihyKDsdMWLfqkFBQaqpAx5D1e4xvu9KSM2Y8jePjtTV
 OHHd3qPIN0eUyvccS943Am+DDiFI2ZIzNwCVyrvRLtaWTpbJjOpwvYc8fCmZlLUA3QxCxmLU6WR
 bwiCay/S7VJamDa9Mn8oYhNfycP2ohxSLcc6zNBIaX8r4rH7iAqtieVuyKHysaNRlhIP0HLZCFd
 DkDsj8TH7iIOgykIIUXb0bGuGbKTUufGMJsEhPqBL8seD+
X-Received: by 2002:a05:600c:4fc9:b0:48e:706b:53e3 with SMTP id
 5b1f17b1804b1-48fe60e51eamr85035075e9.1.1778907881198; 
 Fri, 15 May 2026 22:04:41 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5ab527asm116839375e9.11.2026.05.15.22.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 22:04:40 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Chen-Yu Tsai <wens@kernel.org>,
 Paul Kocialkowski <contact@paulk.fr>, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 2/5] sunxi: spl: spi: Clean up SPI0 pinmux setting
Date: Sat, 16 May 2026 07:04:37 +0200
Message-ID: <BMPMpqHgSfSjFLCZJY9zjg@gmail.com>
In-Reply-To: <20260515234601.15431-3-andre.przywara@arm.com>
References: <20260515234601.15431-1-andre.przywara@arm.com>
 <20260515234601.15431-3-andre.przywara@arm.com>
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

Dne sobota, 16. maj 2026 ob 01:45:58 Srednjeevropski poletni =C4=8Das je An=
dre Przywara napisal(a):
> The function to set the pinmux for the Port C SPI0 pins was looking more
> like a logic puzzle from a magazine than something that readers could
> understand and extend.
>=20
> Replace the convoluted pinmux setup, grouped by pin, with a simple array
> of the four pins involved, and just initialise this array at build time,
> based on the selected SoC.
>=20
> This makes it easy to see which pins are needed, and even easier to exten=
d.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


