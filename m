Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A875ACCD1BB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 15:48:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB91D80422;
	Wed, 22 Oct 2025 17:48:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mVHTXvCR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4733B81E13; Wed, 22 Oct 2025 17:48:32 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B5698003E
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 17:48:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3ee12807d97so6506188f8f.0
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 08:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761148110; x=1761752910; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UUhnfyAoo5ilFrAqmyIWfhfovaY9inNRMwx+n1ZoeVs=;
 b=mVHTXvCROmKUSeQS3PeMcvosYnwJstWmfAp8/iuy5HCAEhBLepsGebXdD5rx5ZXIAm
 gGbF4BGDesMgm/XXU3XgOH6VUAi9ek1beZsXaMdvy7psedPBQej7xDmZTtFlLWoGVELB
 lJe6Zli6oksltB0f5+pi8SpmFSeoOTPMNVUr5oZN3pmvLxAJH3tgZcjQdB9EGV0L33pw
 VNTiYXCq2NlmznqJWHOjQ1IZkQFcA6po8Oj/cYK5Lqz2MBXgo3p/iR/vbJbUw6SLkW26
 55QCy0FxrFJ1FWi7YFa/Y4Hu4Bq4XIwLk8zpk1yg9w5IJU9iPp+oBfM1Ceo4y0ekhtnN
 x7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761148110; x=1761752910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UUhnfyAoo5ilFrAqmyIWfhfovaY9inNRMwx+n1ZoeVs=;
 b=DZzhnFyDAREYPSGShTp6/eSzS8kOhEiDj9yVI8VzUC8MVH8CXcsM1szhFpX396zXBS
 djduua7abmiNmscw6FOqI8c/p0GpUyKpa6pIMzeVqh4zoKbiu0UIEn8brXw0JjNiudCq
 VtEyJxH65m/aT3mNlhmaw/jR1tyQe83L1xwC16h9jy4Ygo96JQ09COtOfZzIf/aafPud
 8NgvNWsdCA+O8gnxIZYQGxJ9VeyUVFfwJEvz5+3g/tsDwh3ggyfF6qeoAxWSWFm9yFBd
 bsR7xokYy1oo/7CwKlMrc69EbrzLTq/2H9uCC61xHao2MpPaKMUp6G4Xwv2WbZUjj0Vm
 Obmg==
X-Gm-Message-State: AOJu0Yy7tiPs6RXg8sHggr4i1+7lzrrmUdoScwoA2lwGrQLCFdpMEX7K
 ELRqp43FvZQduFQkH5Tsd7Wlr9/MBMoDVXBrF33MR7tjcgVv0TiOPXSPl6kdzw==
X-Gm-Gg: ASbGncv3XQW9jyg5rR7xL+IyHDk+HdyO5L4UMtjQiz/qi5H/tDI2xFe8+KC8VaWUgQD
 iwW4bZKz96mMA6GUjqdpZUPqij/2IF003TCzZSFyNdqo8Zxtj+2RKx7v6EPT3bzmG/8YhYjPrOA
 yOUI6LRx15tGdT1KNObeE/QPzaWBzirvIEToEDwHDx2b8lFi5RpSCxuhibIuNB8izC6TOu7/5Or
 JHLkkeH9kM+2I8AxVZQS3w2IMtv87wrApGZ6SvWnDiL6vaFlwSRfOYhEyX+q38KRd8B+YpSFpZC
 N28ILXuw52HHBDsqSVqoneN0QNNUikw5UIbe1x5TfEEU4gvDaYnaRCpteNRyAusg6NJq49eFV2h
 ETLuwb8qboqSgPYlmt6gDk9yYOPyQs83nSLR6tDsJfAtrETC6JzdklJfH6GTiloOBX6GWqe2+0X
 rrLGBAVdhRLQGUPg6A0XWFlrNGXM3u3VHkQDZyrVuHozFgYYPtgE+TLHMLccLU4Fd8lFvUeFlof
 5JZeg==
X-Google-Smtp-Source: AGHT+IGceNZC+hsDU5iNf4hy7oHNmkb8i7YV/yTP5Anzziu3s6OU669Yv3tn9CnVwmUwCH6ADfRs+g==
X-Received: by 2002:a05:6000:22c6:b0:427:23a:c339 with SMTP id
 ffacd0b85a97d-42704d6c507mr15006637f8f.14.1761148109425; 
 Wed, 22 Oct 2025 08:48:29 -0700 (PDT)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net.
 [178.79.73.218]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f009a993sm25826848f8f.24.2025.10.22.08.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 08:48:29 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>
Cc: Rudi Horn <dyn-git@rudi-horn.de>, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] sunxi: dram: detect non-power-of-2 sized DRAM chips
Date: Wed, 22 Oct 2025 17:48:27 +0200
Message-ID: <12763423.O9o76ZdvQC@jernej-laptop>
In-Reply-To: <20251021235334.7557-1-andre.przywara@arm.com>
References: <20251021235334.7557-1-andre.przywara@arm.com>
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

Dne sreda, 22. oktober 2025 ob 01:53:34 Srednjeevropski poletni =C4=8Das je=
 Andre Przywara napisal(a):
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
> the size of the memory to 75% when this test fails.
>=20
> This enables boards which ship with such odd memory sizes.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Hi,
>=20
> I don't really have a board with such an odd size to test that, though the
> function worked on a 12GB A733 board. But that's not supporting the SPL
> or any kind of DRAM init yet, so was tested out of context.
> I would be grateful if anyone with a 1.5GB or 3GB board could test this.
>=20
> Thanks,
> Andre
>=20
>  arch/arm/include/asm/arch-sunxi/dram.h |  1 +
>  arch/arm/mach-sunxi/dram_dw_helpers.c  | 16 +++++++++++++++-
>  arch/arm/mach-sunxi/dram_helpers.c     | 12 ++++++++++++
>  3 files changed, 28 insertions(+), 1 deletion(-)
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
> index 24767354935..14f6b24c30f 100644
> --- a/arch/arm/mach-sunxi/dram_dw_helpers.c
> +++ b/arch/arm/mach-sunxi/dram_dw_helpers.c
> @@ -143,8 +143,22 @@ void mctl_auto_detect_dram_size(const struct dram_pa=
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
> +		size =3D (size / 4) * 3;
> +		debug("capping memory at %ld MB\n", size >> 20);

As I already commented in first version of this change, wouldn't it be good=
 to
add additional check here, just to be sure there is no misconfiguration? In=
 such
case it would be better to panic than continue with unstable system.

Best regards,
Jernej

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




