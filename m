Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EBF606A325
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mvcQw2d+;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=W+oMxHdf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D5A380E4A;
	Sat, 31 Oct 2026 13:59:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZqJAWVQAKgsX; Sat, 31 Oct 2026 13:59:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8DD2080E32
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455164;
	b=bF8sJEYTdE49w4I06Ae+CcaaLzsYHBTZmiqOENBe5HERxrND0iA6FVE9WC+wKa+91tlt
	 DufJ1QvH1KkQClHks2SspgKYh+2t7/ldGASU13ZjZJPzbXhhZyGT5mnwz8Y0gGtX7rF41
	 o2ebGzQ4tbrJhC1pSpS3lm1CqF6ADrHcACGJwfqamzsM2SYQfhirb39el0S3I/VsNiYX2
	 JHMOKj1AVvmYXAlWy2yfKNxdw18Dltdj0d/iy96SvrD5L397ONUjqtVqIXqNryEmdQyzo
	 mA3hMYBOo3gKlBAan5C40QinYoOgFaP82m6il+dmjZMcQCNt+b580a0qjlTLBvJb9/g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793455164;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UILSVJcn9mnyWPkCmh6l3C7KBX0vTTg+Hpwbrg1d4w8=;
	b=sBLHGuVU6oOrYnixgAC3JXjh8pMhdQGzTt3iwIY3JyXasqiSa+RKNZTDvqxyXBcBy8qH
	 KUazTtmI1d/hv3Ef4Oclrgsm3bgtqbhU/aKLxwngt60m1mrQG93eUnItGeXCXsV4Itvyt
	 aPRr4Zfr2gXCw6uW3IaQ6hyt5W2ne3OmrQXmDIA6etA/XhNq3YILYJ2WqgZTh+mdSrWnw
	 mJxNSy3SVgd2IMTvb0ShBZ+M3D/85hIP/PGUrpwdYjO+5bIGyL9qMS9K99+oYmbcSXGmT
	 iX2EjKXP8sQ6/5IluU/UoWLvaet29RwP44NIEX/WHg7dSOA9fV7BLZVEO4ih71nT8Bg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=W+oMxHdf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793455164;
	bh=UILSVJcn9mnyWPkCmh6l3C7KBX0vTTg+Hpwbrg1d4w8=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mvcQw2d+G+MOIT7iCzP0c/IWQQhVCL0Sm2O4o1gySD6UrYcqNSRq2pq+AbYnSWRFb
	 nrxeq8oMpp68MwP+znFuaKCKHkdTckekJLIL61Q+xsqxOwX3MZegAoEUllLY9iVwpY
	 S+k1JGD2EZJ1NWOv3LXCduTBBRVtpgjAg76QhRH5jPAHR7XwdhfCUXUPa/efknSZvR
	 H3WxOX+g0YYq1CrIgwgV7e1tGuH0XT2WbYdqiXqDoWt0SJEcX1fEovt2HUQ4bmsKjO
	 U/0KGKsXtf9z8DSIiH/UHdzKmJfiQNhh/4VnXC9uYq8kqn3VMjoHllGjueNB7BbWLn
	 JX5YVPBk/2rfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8DD2080E32;
	Sat, 31 Oct 2026 13:59:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C0FB362
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 13:59:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1219B80E32
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 13:59:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aBU4cFqzqpPL for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 13:59:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EA28B80E31
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::535"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455162;
 b=rqt1Nb89uo9YoFUrokmVizE+BGIR57MmhSQho3cw6NpJtF86DT2IU7llIt7Ud6S052Q8
 mv+7ZxsVF4NNsDUu5xM2qaMcmCiRxRa/8PesCQVkic7eH/8O6SJP6Jx00/nXZ081xYtHn
 fBDllzpyN48eXSWIaEvMEPuXD0srXy+ugsdWGMamCtE6Q4FEjcDrtYmROEFfWw/0KiY8X
 V+CjyZvZPIs9rZ+klSSftJt3Yx8l8w+cCOaeEArprpSFNfD26uxwihVLD5XF5qjC7mJ69
 MeDsrwlwbA1lR+928QqPIMR7KbqTgzCw4Mdypq/rDDh0DXETkb2c6ydlApFz/RSuNHw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793455162;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=UILSVJcn9mnyWPkCmh6l3C7KBX0vTTg+Hpwbrg1d4w8=;
 b=gANKjfnLcklQtO8punRQT7TuJXFbOCiVYM+hy7pfAQEGAMs9IYRa1saVUm9QMCmngJmh
 NyIUU1GcoQJF/fOXZjTJ1WWfyVwU0j/v747CqLSkBFc2cBAAgj7KbZtgFxMIzKcMBzW3T
 J6FQxm2IXeNWE4x38X0TgsZ3Z8illWW8RLD55tLFx046UvA4CK6NaG6FQrCdvTYR6yn0A
 SXj8qLY6pK8qs4xRNEJlItkShSE9xeaNz2oDkkBW8SlJULtj0JtJ8a7aVaRkTtxUlwzgZ
 /wdSnMgeweYuhmLGvPL0SKM47zW4dGgLkPJYDBiRsnsIZfAlmjyTcj3Yjb7xFW+XkHg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=W+oMxHdf; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::535"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=W+oMxHdf
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EA28B80E31
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 13:59:21 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6b408f2d936so2076160a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 06:59:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793455160; cv=none;
 d=google.com; s=arc-20260327;
 b=aJU+dCRTkRTOdum8K6WwFyyQToeskkvaT3h5lisGgj7079jTp2iU8Ng4VgdWte7/cr
 QfHG2si181VleMM/cr+fIvNgU/UeVZxadO2mbjhiBLNUNStBEjVhIZL2iAE8B97r4WoP
 wr5g05B9IcSRi021m59LsPd90T1orAOTCcNn2wwUrCUy6ZjiT2TOMigI4HPsUqfdmGXX
 MgY3x0SqFupjX53F4PoQaMJtXnxvC7ActMhQXvMyugwWzYwDmg8oI2wOHh4gjAdAROfc
 a6iB//+SEAc/8uWAuPF6gEITChnHjYQGDXH/S9CbfpswmKSUBoP6L+1OjrSAutsDYcY3
 fzGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=UILSVJcn9mnyWPkCmh6l3C7KBX0vTTg+Hpwbrg1d4w8=;
 fh=9bG3WjtsB2jlLTxxUCbx6dxqzVhIeWXYksTa+8RkjW8=;
 b=cIpBIJme4QnzjC196pvp1E3Lu5xhWh/xYXaegxrwPKL4sycCpOxdKxD1e2Ma3emgI1
 G7ZaAZt3N7dPCQVJ01FIis7/R+4MS/71ALIyEm+W/th8vfQ++lZtylnHNKGQvQP/TMxC
 ptHZXn2/544WbkDbZo5sxe18OjugfroAsPvV30CwbHkdFPIDPOVdOwBLjKy+wF8T6b6n
 FNonlF/MFpJdCw/GbEaFCeWqs2gBbm39yL5FH62+jKVhSK4NB9R0Tcj6jof2Us72FSu2
 a6UIRwHNQB8EssAkj0DTchyvZUo9y5hzXjp3p3aXRQKAUhE9//xDh8bBqwhvAXvmEblz
 kw8w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793455160; x=1794059960;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UILSVJcn9mnyWPkCmh6l3C7KBX0vTTg+Hpwbrg1d4w8=;
 b=W+oMxHdf+xWihf0MiJk0o68fsQMMFLzzkKgJmzwsnXGJnbm6SN+4OCzgLKILMR6afb
 gzbXBdoVxF+TOWw5P+oLzp1wCmj8Z3lzwRPCsmFxAwleBsJC4PpUq9HOTHSeS75DQtWe
 /RAJpgpsw+YLJxYc2M7sE8MLoQsknjgFe5YzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793455160; x=1794059960;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UILSVJcn9mnyWPkCmh6l3C7KBX0vTTg+Hpwbrg1d4w8=;
 b=FVDwQTpMzNFVPxLQC0q8FDoJgFFmnJuNFgxmL9bNF8fLMf086srcqtH0tSypkm6Hnu
 dXm5JzZb9pvlAKAoFOH7L73woPu6mEpb7QzNS+brHTj9jKegJfXi8e0wJJj7yozht3oH
 U7CeiEJVE472jRKiMTnPuqGKBJXdnjaZGeZwOZLesLuo1gTBNpPrR4kiK7/18QsjUBzB
 e8xwM6m9D/Df00e4laKhpJ2SftGaA9k0eRGwVDVLPmzIAoKHD4+wk6L4oF05vN9+1cl7
 hWUnW+dfGZC+PdxDewvFtZi3S/jYPwc6fqNZrm/13A+F9mHKf/KIAiMze8d5vqjRHfiq
 p8dA==
X-Gm-Message-State: AFq9FYK9iUiBWTp3I5lXgTC9Tq5Z0mHHCXKFZx6InD5rxSuij/TNPXa0
 hlZ053E8+8FGaZTaytuRWhsc56e5wdJlk7rxxhSoudMSNGCkgbZT8ygRjRZ7UG6xPoPger4I9Qs
 8omjOEAZgjflH2FhmM/hImNeYlyOp7B5r3UdRhBKH
X-Gm-Gg: AYBFou39T1pBjCC6f3cVDEEVUT6LGKh39A7K/UYDQbLgoO7w2izwDeHd8qvPEQTJbqG
 q84U++rVl7n4due6gCGb1QqmNB8jn1+Qe6u74kgm9AX90hZG8+JHEhNJALiQ4AuWajhIZmjjs9O
 HvdiG28AmXWbkXRb0d2eM58ixcJ7BCIDWYylYZE3p9KT7E2fw4IXVMdJrE3idd5IvPGsHacfV4V
 3ekfqctE4uOClkJJdpkEzf/xTrqPfEgsFr0N8LcF94NdCUPehxD25y7pofQFCPSKpo4jRJt+HOI
 cUzRUME/UvJrO1KMZ02icSum/t6qQJ2DBr6Mbnf55M9qLbGZEAGCL35XUD+fIw/1JfdiUbrEIPR
 eEzRnhuX36NG5GrwfqPqL+Caar5+z/kyD92lHv/vp9PJXfz0Fle9Ezb8DkXQ9aVe7Aue7cgqpRn
 R1JPBetM5Om4OwT8Kl
X-Received: by 2002:a05:6402:22d0:b0:6b4:35af:328d with SMTP id
 4fb4d7f45d1cf-6b4d438bdacmr3072378a12.14.1793455159775; Sat, 31 Oct 2026
 06:59:19 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 06:59:18 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 04:16:34 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261028113005.515786-1-nguyenanhgiau1008@gmail.com>
References: <20261028113005.515786-1-nguyenanhgiau1008@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 06:59:18 -0700
X-Gm-Features: AclHuK9Lx-arUZz28FQ75kkTKmAZ1cRz_LL_oisvjdEkxJXmvbL0xO2KBW2RY-g
Message-ID: <CAFLszTjZCFgKzKBTLv-p9YzxeW-0eRoL+S6opcCpZSqbm2sSmw@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: bcm2835: Add new BCM2835/BCM2711 I2C controller
 driver
To: nguyenanhgiau1008@gmail.com
Cc: u-boot@lists.u-boot-project.org, hs@nabladev.com, mbrugger@suse.com, 
 pbrobinson@gmail.com, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Giau,

On 2026-10-28T11:30:05+11:00, Giau Nguyen <nguyenanhgiau1008@gmail.com> wrote:
> i2c: bcm2835: Add new BCM2835/BCM2711 I2C controller driver
>
> Mainline U-Boot currently lacks an I2C controller driver for the
> Broadcom BCM2711 SoC (Raspberry Pi 4).
>
> This commit adds a new DM-compliant I2C driver for Broadcom
> BCM2835/BCM2711 SoCs based on the Linux kernel's i2c-bcm2835.c.
>
> The driver dynamically queries the actual VPU core clock rate from
> the VideoCore firmware via mailbox property messages to calculate
> the CDIV clock divider, ensuring accurate I2C timing and baud rates
> on BCM2711.
>
> Enable CONFIG_SYS_I2C_BCM2835 in rpi_4_defconfig.
>
> Signed-off-by: Giau Nguyen <nguyenanhgiau1008@gmail.com>
>
>  MAINTAINERS                              |   1 +
>  arch/arm/mach-bcm283x/include/mach/msg.h |   9 +
>  arch/arm/mach-bcm283x/msg.c              |  22 ++
>  configs/rpi_4_defconfig                  |   4 +
>  drivers/i2c/Kconfig                      |  10 +
>  drivers/i2c/Makefile                     |   1 +
>  drivers/i2c/i2c-bcm2835.c                | 370 +++++++++++++++++++++++++++++++
>  7 files changed, 417 insertions(+)

> diff --git a/arch/arm/mach-bcm283x/msg.c b/arch/arm/mach-bcm283x/msg.c
> @@ -116,6 +116,28 @@ int bcm2835_get_mmc_clock(u32 clock_id)
> +int bcm2835_get_clock_rate(u32 clock_id, ulong *rate)
> +{
> +	ALLOC_CACHE_ALIGN_BUFFER(struct msg_get_clock_rate, msg_clk, 1);
> +	int ret;
> +
> +	BCM2835_MBOX_INIT_HDR(msg_clk);
> +	BCM2835_MBOX_INIT_TAG(&msg_clk->get_clock_rate, GET_CLOCK_RATE);
> +	msg_clk->get_clock_rate.body.req.clock_id = clock_id;

This duplicates the first half of bcm2835_get_mmc_clock() just above.
Please can you make bcm2835_get_mmc_clock() call this new function, so
there is only one copy?

> diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
> @@ -171,6 +171,16 @@ config SYS_I2C_AT91
> +config SYS_I2C_BCM2835
> +	bool "BCM2835 I2C controller"
> +	depends on DM_I2C

The driver uses asm/arch/mbox.h, asm/arch/msg.h and
bcm2835_get_clock_rate(), so it only builds on bcm283x. Please can you
add 'depends on ARCH_BCM283X' so it cannot be enabled on other boards?

> diff --git a/drivers/i2c/i2c-bcm2835.c b/drivers/i2c/i2c-bcm2835.c
> @@ -0,0 +1,370 @@
> +		if (msgs[i].flags & I2C_M_IGNORE_NAK)
> +			ignore_nak = true;

I don't think this works as intended. If any one message has the flag,
NAKs are ignored for the whole transfer. Also, if the NAK comes before
all the bytes have gone out, the DONE path sets msg_err to
BCM2835_I2C_S_LEN and you return -EIO anyway. The Linux driver doesn't
support I2C_M_IGNORE_NAK and I can't find anything in U-Boot that sets
it for this sort of bus, so I suggest dropping it.

> diff --git a/drivers/i2c/i2c-bcm2835.c b/drivers/i2c/i2c-bcm2835.c
> @@ -0,0 +1,370 @@
> +		if (val & BCM2835_I2C_S_DONE) {
> +			if (!i2c_dev->curr_msg) {
> +				dev_err(dev, "unexpected completion status\n");

In Linux this catches an interrupt that arrives when no transfer is
running. Here we poll inside xfer() with curr_msg always set, so the
check can never trigger and can be removed.

> diff --git a/drivers/i2c/i2c-bcm2835.c b/drivers/i2c/i2c-bcm2835.c
> @@ -0,0 +1,370 @@
> +	priv->regs = dev_read_addr_ptr(bus);
> +	if (!priv->regs) {
> +		printf("bcm2835_i2c: cannot get base address\n");
> +		return -EINVAL;
> +	}

Please use dev_err() here instead of printf(), as you do elsewhere in
the driver.

> diff --git a/drivers/i2c/i2c-bcm2835.c b/drivers/i2c/i2c-bcm2835.c
> @@ -0,0 +1,370 @@
> +	bus_clk_rate = dev_read_u32_default(bus, "clock-frequency",
> +					    I2C_SPEED_STANDARD_RATE);
> +	ret = bcm2835_i2c_set_rate(bus, bus_clk_rate);
> +	if (ret)
> +		return ret;

The uclass already does this: i2c_post_probe() reads 'clock-frequency'
(with the same default) and calls dm_i2c_set_bus_speed(), which calls
your set_bus_speed() op, so the divider is programmed twice. Please
can you drop this and keep only the mailbox query and the FIFO/status
clear in probe?

Regards,
Simon
