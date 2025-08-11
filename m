Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73388CA0ED3
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 15:36:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD53D83096;
	Mon, 11 Aug 2025 17:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bC5tR0DD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DEAA8309E; Mon, 11 Aug 2025 17:36:20 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 678E683093
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 17:36:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3b7910123a0so4164162f8f.1
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 08:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754926575; x=1755531375; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MARdMrj7j95wET+0GfdIjVDG9+tfCI3tCFzuFFdiH+g=;
 b=bC5tR0DDbM1dFd8x3HogldP0lFAtsQGIrPd+1EgHu712hOKJcKmerAkeu19n8E3K8U
 oddzACgBd9bCOMvde5RlTnjdomb7vjleQxo4ZqvMqxeNUrHNohuwLyDu+TlKREe/+0bl
 cVV/MA1nNCd6LqZ8H0daeZ0Bnz1sTR0yrBC2XDXB+G8rvETJ3gCs459/scqgwOvawXUa
 85Aj2axyBy++S/JfTdU8/Hhs7AfK1Lm3eG4e57xjoMGhe1B5lC05D3aUXTEugHjM906Q
 WtxNoTmrR8CzFE6PxcGgRbB2FfUdS3BLDLrPa2XEZysfYFXplfylIOaEjw8qjRx37EeY
 6I1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754926575; x=1755531375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MARdMrj7j95wET+0GfdIjVDG9+tfCI3tCFzuFFdiH+g=;
 b=WrrPCe0cQVAE8ZNLvDUnDNZnFd4jny5rlbcPTGL41s5QRLSaa37Ku8edf7v839zKNN
 sGpVzCoPrCuX3MjsbRcN3D0ZVwFJlQcnpK0kF2BBNDEHx6/q9au0EXIvDsJPEfiyHzgZ
 nyBTzMORDAvSe/lVqEVvM29IvyhkiEnYMTWiqJjUsJnqeIhv0q6uYp1tzzK/TFV1jkL+
 NJlm83FusbK3aFwYq+opUBsKp6ZVWwxzN8jmKMjFjAagoO2MtdqKdQ7D4Q/74K4+O9uL
 1Yruh/ZtHqLPCKlZkIzcG5GclApvci61aCbp0pnNdLQds+56CFjG/vYOjcLgdMKfD/kj
 EBGg==
X-Gm-Message-State: AOJu0Yw2ET7AGjF+po45veoqAmz96cwSR5SwvRJ04aL+Eoa3wNN4OSeM
 iKrnCMZD9haj7l6gzvrNd//q8x0vU+M+qm/be/TNEBK91Pt6GZIkZ+gT9V4ftA==
X-Gm-Gg: ASbGncud732QxfPLOZ0WVMu1r6hjFnZd3JbJ0HKy9tQ96tXSs9I3zPwxs5QK4Y+zgIP
 hCGpDPFUkBz1ULV1U1pAEfv5uufAn+GKIw3H+gpEw7of1SMoCtwsYtaNXixSAPX5Qif3c0h5zv3
 a/8kkwwjOxYzfN/uLQEUFnNxKwc6XsRm94otXhEIKRIZdqjK5EUJHCbZhqPmz19Z5sMfie/OecH
 UU+pgTQivfnLph5h5EarYy6FYeA4ZAy08ojrf/qsL/zw0thqgZ/P3p7KoVzDibOB6UhIr9vXu+8
 Hhg62VIDiRLDokyEw6u6Rsb8gCQfFcjLHLJaFoZ6O3ZvWTN3mBa0J6c/h8+fJ+myAWt/VirofRs
 Vg82IZ95T2t8laNeYYaannXV5CDaHC4TpqNV0cx5ApIY1LiO9OKV/v+OsxUzXMGDInOs+ybzuzO
 7Mx3fLrYty
X-Google-Smtp-Source: AGHT+IHcUY2aaPliOo9PDVkhuEJ3aoGr/a/6EIpAImT58OdOxpU7th0gigMNvkAJrRPT2gYr4jjA9A==
X-Received: by 2002:a05:6000:2482:b0:3b8:d4c5:686f with SMTP id
 ffacd0b85a97d-3b91100ea49mr143019f8f.39.1754926574712; 
 Mon, 11 Aug 2025 08:36:14 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e586a011sm281083275e9.19.2025.08.11.08.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 08:36:14 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Cody Eksal <masterr3c0rd@epochal.quest>,
 Chris Morgan <macromorgan@hotmail.com>, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 1/3] sunxi: a133: dram: fix data type for address variable
Date: Mon, 11 Aug 2025 17:36:13 +0200
Message-ID: <8562188.T7Z3S40VBb@jernej-laptop>
In-Reply-To: <20250801234918.19176-2-andre.przywara@arm.com>
References: <20250801234918.19176-1-andre.przywara@arm.com>
 <20250801234918.19176-2-andre.przywara@arm.com>
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

Dne sobota, 2. avgust 2025 ob 01:49:16 Srednjeevropski poletni =C4=8Das je =
Andre Przywara napisal(a):
> Variables holding addresses are typically using the "long" C type in
> U-Boot, to be easily compatible with both 32-bit and 64-bit builds.
>=20
> The A133 DRAM driver is typically compiled for AArch64, so u64 is the
> same type as unsigned long, but that breaks when compiling the DRAM
> driver in AArch32 (for some experiments).
>=20
> Fix the type to make the code more portable.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  arch/arm/mach-sunxi/dram_sun50i_a133.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-sunxi/dram_sun50i_a133.c b/arch/arm/mach-sunxi=
/dram_sun50i_a133.c
> index 3a231141168..1496f99624d 100644
> --- a/arch/arm/mach-sunxi/dram_sun50i_a133.c
> +++ b/arch/arm/mach-sunxi/dram_sun50i_a133.c
> @@ -416,7 +416,7 @@ static void mctl_com_init(const struct dram_para *par=
a,
>  static void mctl_drive_odt_config(const struct dram_para *para)
>  {
>  	u32 val;
> -	u64 base;
> +	ulong base;
>  	u32 i;
> =20
>  	/* DX drive */
>=20




