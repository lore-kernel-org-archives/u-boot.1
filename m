Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65857D29C2E
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 15:31:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96D4F802C1;
	Mon, 19 Jan 2026 16:31:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E1PYRnZ1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 645C880B98; Mon, 19 Jan 2026 16:31:10 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55D888003E
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 16:31:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47ee4539adfso36847255e9.3
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 07:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768836667; x=1769441467; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ns7cOXSE46lfBsQWk849lkgkSIYrG2jMFvsJs1yzrvA=;
 b=E1PYRnZ1vbgU/TfwhLNYvEsEcpUHtyDvlpm1ykzTfphU6h0Y1KlnvShxD2mIZIRVNN
 c2Xymolq2bvRft86oqD8/6sFWrvzYg39GzypOD6bRSn/P5swE0MEDpDiw2pgV6O7+waN
 QvHEncqclOxvhXmq0GWIcJpKVurIda4s7dUol55/bBwwq4OFzPt2KgCsxg7My40o8gJx
 JDbZRz3tZNgQMD9Yg9kMzC6trVnAjKEhVrBcMlcn8rOA6E/IRk4IINaNS1OFgktlu8cg
 ut3y1VX3S3ScwqwC6yAT+2YWAzlEkALzgAABPPbkuY0W/PmRKeGMY9+m8Xs+o1g//V/Y
 7trA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768836667; x=1769441467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ns7cOXSE46lfBsQWk849lkgkSIYrG2jMFvsJs1yzrvA=;
 b=wZrtIt83K4cf6l9Nmu4oDfktDwYX9oXxt7wUO6OBbmP0rv3jtkMm5j7MU7nNIgHRUP
 oKBi3SQrOU/Gqo6vDTaHBvE27Jd/2JLJ4UYlEcrkdtSiiuUksy/5fsOgxervG6qevcH2
 u/7JaLtK6ZuHyS6ZJyvP7ytfcS5yOvPiQuJ84LiscwvrDF2ZXMiwZPKIZYBjFQHmGTBJ
 2mYQLxyZGKMrCy68cmatHdMcJDK4B1s/oBa2u5eoIRiuXsOwI91pomnDh1BGcRmWrBfa
 a1PVxkE6Vrxh52QPDLycxYf0rvfwwlOxD0hOcjc0XzxJHdCRlbaSu3muEvjJ0cW4A8M7
 yzrg==
X-Gm-Message-State: AOJu0Yzm1og/PgvsW6yH5dYOAAsyZELQs/YVRD9cy58TZe+gjZR5Ay29
 89DG9O/8bi9I8GYQNtgf9AKP/h6lBmBCvbeLWuSH8Cy5+atmKNAP9iWasKmF5A==
X-Gm-Gg: AY/fxX6Hncy9B0yDt6jjlRZIT3rvN+M88rbt4lI3BMqlcD+zXeUhhIRgQwnkymWmWT+
 ot/NebVNzBaylxALczRD3Uip6hCDHF6FIwb6GrMfzLhx3Ose5sFCCRhvh2dqnHmjsKbqOetM0pJ
 eAryamTRJzGL/inZuF728C9lrlcpi3yvSkJV6Egn6a03rfDqWjnHqh0GtZEaifCWCRBJjcYov7b
 MwQT8RbmA+KWfZBHMBJfpHJY8suawU+ywg3PT0VBeYM9aaeMzNd7/HqZc5naX4Ug691fLYtDyib
 emR5K5BrEbfkjaeorUBFoCZTxTNITs3slOjkDRbCUvJqWFHtWUKzu6A/zgpB+GKUlxBOMRQ6JML
 0pjAQBpg4EIdbxO6U6HpsErAplawfNU/mGyzKiyECD7p+o2ueL744DghF9mGqaEHjwo1FTI+ymR
 LgmxOSPE3itYV7u2VA8lL2ODvWqzx8jXt7OmPcCEF1nayE6/z17XlY2LA1aCNNZNChtDQzUsfUa
 2KRXw==
X-Received: by 2002:a05:600c:3e14:b0:47a:9560:ec28 with SMTP id
 5b1f17b1804b1-4801e30b8ffmr153826015e9.13.1768836667321; 
 Mon, 19 Jan 2026 07:31:07 -0800 (PST)
Received: from jernej-laptop.localnet (213-161-4-198.dynamic.telemach.net.
 [213.161.4.198]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cefdsm23132480f8f.24.2026.01.19.07.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 07:31:05 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>
Cc: Rudi Horn <dyn-git@rudi-horn.de>, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2] sunxi: dram: detect non-power-of-2 sized DRAM chips
Date: Mon, 19 Jan 2026 16:31:03 +0100
Message-ID: <2813637.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20260118235905.23752-1-andre.przywara@arm.com>
References: <20260118235905.23752-1-andre.przywara@arm.com>
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

Dne ponedeljek, 19. januar 2026 ob 00:59:05 Srednjeevropski standardni =C4=
=8Das je Andre Przywara napisal(a):
> Some boards feature an "odd" DRAM size, where the total RAM is 1.5GB or
> 3GB. Our existing DRAM size detection routines can only detect power-of-2
> sized configuration, and on those boards the DRAM size is overestimated,
> so this typically breaks the boot quite early.
>=20
> There doesn't seem to be an easy explicit way to detect those odd-sized
> chips, but we can test whether the later part of the memory behaves like
> memory, by verifying that a written pattern can be read back.
> Experiments show that there is no aliasing effect here, as all locations
> in the unimplemented range always return some fixed pattern, and cannot
> be changed.
>=20
> Also so far all those boards use a factor of 3 of some lower power-of-2
> number, or 3/4th of some higher number. The size detection routine
> discovers the higher number, so we can check for some memory cells beyond
> 75% of the detected size to be legit.
>=20
> Add a routine the inverts all bits at a given location in memory, and
> reads that back to prove that the new value was stored.
> Then test the memory cell at exactly 3/4th of the detected size, and cap
> the size of the memory to 75% when this test fails. For good measure
> also make sure that memory just below the assumed memory end really
> works.
>=20
> This enables boards which ship with such odd memory sizes.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Hi,
>=20
> v2 just adds the "positive" check, so whether memory just below 3/4th is
> accessible, when the test for above 3/4th failed.
> Please test if you have a board with such "odd"-sized DRAM.
>=20
> Cheers,
> Andre

This looks good to me now!

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>=20
>  arch/arm/include/asm/arch-sunxi/dram.h |  1 +
>  arch/arm/mach-sunxi/dram_dw_helpers.c  | 22 +++++++++++++++++++++-
>  arch/arm/mach-sunxi/dram_helpers.c     | 12 ++++++++++++
>  3 files changed, 34 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/include/asm/arch-sunxi/dram.h b/arch/arm/include/as=
m/arch-sunxi/dram.h
> index 0eccb1e6c28..59e2e980bfa 100644
> --- a/arch/arm/include/asm/arch-sunxi/dram.h
> +++ b/arch/arm/include/asm/arch-sunxi/dram.h
> @@ -45,5 +45,6 @@ unsigned long sunxi_dram_init(void);
>  void mctl_await_completion(u32 *reg, u32 mask, u32 val);
>  bool mctl_mem_matches(u32 offset);
>  bool mctl_mem_matches_base(u32 offset, ulong base);
> +bool mctl_check_memory(phys_addr_t addr);
> =20
>  #endif /* _SUNXI_DRAM_H */
> diff --git a/arch/arm/mach-sunxi/dram_dw_helpers.c b/arch/arm/mach-sunxi/=
dram_dw_helpers.c
> index 24767354935..d2af2d57fde 100644
> --- a/arch/arm/mach-sunxi/dram_dw_helpers.c
> +++ b/arch/arm/mach-sunxi/dram_dw_helpers.c
> @@ -143,8 +143,28 @@ void mctl_auto_detect_dram_size(const struct dram_pa=
ra *para,
> =20
>  unsigned long mctl_calc_size(const struct dram_config *config)
>  {
> +	unsigned long size;
>  	u8 width =3D config->bus_full_width ? 4 : 2;
> =20
>  	/* 8 banks */
> -	return (1ULL << (config->cols + config->rows + 3)) * width * config->ra=
nks;
> +	size =3D (1ULL << (config->cols + config->rows + 3)) * width *
> +		config->ranks;
> +
> +	/*
> +	 * There are boards with non-power-of-2 sized DRAM chips, like 1.5GB
> +	 * or 3GB. They are detected as the larger power-of-2 (2GB and 4GB),
> +	 * so test the last quarter for being able to store values.
> +	 */
> +	if (!mctl_check_memory(CFG_SYS_SDRAM_BASE + size / 4 * 3)) {
> +		if (mctl_check_memory(CFG_SYS_SDRAM_BASE + size / 4 * 3 - 64)) {
> +			size =3D (size / 4) * 3;
> +			debug("capping memory at %ld MB\n", size >> 20);
> +		} else {
> +			printf("DRAM test failure at address 0x%lx\n",
> +			       CFG_SYS_SDRAM_BASE + size / 4 * 3 - 64);
> +			return 0;
> +		}
> +	}
> +
> +	return size;
>  }
> diff --git a/arch/arm/mach-sunxi/dram_helpers.c b/arch/arm/mach-sunxi/dra=
m_helpers.c
> index 83dbe4ca98f..376b7d14f86 100644
> --- a/arch/arm/mach-sunxi/dram_helpers.c
> +++ b/arch/arm/mach-sunxi/dram_helpers.c
> @@ -62,3 +62,15 @@ bool mctl_mem_matches(u32 offset)
>  	return mctl_mem_matches_base(offset, CFG_SYS_SDRAM_BASE);
>  }
>  #endif
> +
> +bool mctl_check_memory(phys_addr_t addr)
> +{
> +	uint32_t orig, val;
> +
> +	orig =3D readl(addr);
> +	writel(~orig, addr);
> +	val =3D readl(addr);
> +	writel(orig, addr);
> +
> +	return ~orig =3D=3D val;
> +}
>=20




