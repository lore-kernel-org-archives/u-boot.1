Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FF1FF8873
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 13:48:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B20D184150;
	Tue, 28 Apr 2026 15:48:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hSq9Kgt3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A378B84255; Tue, 28 Apr 2026 15:48:39 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ACAB84119
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 15:48:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b8d7f22d405so1919248566b.0
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 06:48:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777384116; cv=none;
 d=google.com; s=arc-20240605;
 b=ApAtH9E7jLIG64PmNnMD/M5aBQZqI66ySA8d+aSH1irN1/rH3+01AgKXmb6B/12mwC
 d8XUZ1GoOXsKZBWgfjHXrcJo9x+Zbu9u6q2DmLNUAdXKV3XgyYtyPa6V+XRfgcqKT/m9
 WzgbocDlNg1o7CRIhLT86hpmiPKTWV41HsrygY8yO37ItDK41Qr5VOoSQxxVWulADp/6
 NxhGP8s2dquxsK2YRLyYv4e47s6RQKnRSzS0ckp6wU3MCjjmsOmO/0vImTlxObDXLyq1
 7DLXhNbKifVam1RIdHKeI1OCbgqGZ+DF5dbOe+xVsdbGQxgA2aJwqA7ahqbr34iIZHoF
 SKOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=y2f3GLBu6Gc/J9olw6dOBjHjlvKmJh8qMU2wNcXX8bY=;
 fh=H+ebO4NFBgeu4/lekPSTtnqutYKgG6D0MPDscrp4xec=;
 b=Ea8CmC9LbEspIrjWELDEE91o8xE/4i0nFr8OlVFVo/fdV3TdpE8Y03uPo6YIesjpg6
 x3LbDeBaJkWqzzYQvUHcS/6IyVSUc3bXWJsia/DOVpfBw6ySRiMYTz4kYYY/aZ19kcsw
 EzZftsvajPmzNyJPLwO4PbH91c45E0aSQJRgYEJzJA/zLjz29vVrhoQW6GCEpBMpm7Qa
 seeAR/77Rz+RG/M+Fv9mPqr/T1rt4XEedLZW7MzBvrR+nCMbFvFXQl8EMI+XQKxoi7Tj
 3MhV4pKFcp6qimI71zezmGBh4a/JgcHaraiW1NgqyobkPzbcN3S0N2XSzhK0SXqcDC+4
 yGQQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777384116; x=1777988916; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y2f3GLBu6Gc/J9olw6dOBjHjlvKmJh8qMU2wNcXX8bY=;
 b=hSq9Kgt3nt9GHUiPMTfMJAOOWfG6TlFTsb8k9np9t2p88HbcHAQiejLjBIstME201G
 0iyIaeknEDYOkFtitzicfDD/lYHtwDicHUbTR2A5ASIA9yw1zoInE9WT0r6yvCVBIqDZ
 5XmNtdDGiMXeoetQoPM5KqDj4gj22F/zeK1m4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777384116; x=1777988916;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y2f3GLBu6Gc/J9olw6dOBjHjlvKmJh8qMU2wNcXX8bY=;
 b=ZtC6UeAS0rKZ7VBf2+o2CfAXXIEN8op/VJtopmgBNciuy1xIum2Y85/10UHdioaqw9
 BZ+mehcB8S258kr6ClXzaUHUXUJb45u3j0TwP3y5mQuDtpxJMqQxEmbut2YUqTPAq6gU
 KUYP2RBDda10H8sOBrbZtuHLeGoG8bJxoiWor9/ehe8wgCoji0KREtUl73ZoJW2LqRoC
 nF2NQPr3QOwXRZO77v9AbxZ/s0Cy7MF6bOT2OJFqAvMkH126M/Sz9mW3yNDdTw34s/e+
 X92trZa91k/PKP+ocNgSu/eOupsmQu+mI0LPk13nx+yirPdP3QIJtNq7urqOJa+RH5mv
 ln3g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8KcHSCaqDtBDi8b6NzK5IMLLIwakSHY9wQZ0Z46jcwKqQPksFdQtLfHfRBvc93aNr/rf7SqGY=@lists.denx.de
X-Gm-Message-State: AOJu0YyIQoWD1dlBN5KqahRcVXvFRXgvIQBjQj1Ozir+An3sf5L7ujWw
 p9S/z8l5YKN9rvfiIFVWR7pQB945NXpipcrTy0T/eBJbfXAVSJ/9z1EWVMXmyHDRvHA5jU/XRN1
 nm6EIDTC4i+9efnq7srli5yka7TITkj2KYoCF8RYB
X-Gm-Gg: AeBDietZDYErI/G0AE/Sm1dnlw+VjHAl33Y+vgE3xCpC4cnUuy1X29Mosp31eGTIARa
 64uagdqmySaD7Nagl52qcLFxJNXBrXOyI9VYtQoUVLT3kNJDGZoq0dN1WvrYGlWwRmvFHDuvhfs
 davBRv5SPxs0WyejTs4LPKNWGnAfV+EVgjYSokPgiKAEIeaTR5k+UdxSGNeZuiCEpiNj+yRjxoz
 8itJG722ILj3CLdT0DtVLY1DHykWwOzuYhk1uVloY7wbMDCbXjClInRZOB3tNVC9uVITBGrgo28
 EnKAltYKqR4YPkeY
X-Received: by 2002:a17:907:6a0e:b0:bb9:4b2:339d with SMTP id
 a640c23a62f3a-bb904b2341dmr23230366b.39.1777384116497; Tue, 28 Apr 2026
 06:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260427100832.581887-1-ilias.apalodimas@linaro.org>
 <20260427100832.581887-4-ilias.apalodimas@linaro.org>
In-Reply-To: <20260427100832.581887-4-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 07:48:24 -0600
X-Gm-Features: AVHnY4IgwrWwxz41oEYwwJ4Hl-1Al-NUf7V_aICxLxH3LhRVcSwl2Y8AerX5PGE
Message-ID: <CAFLszTj2wr3DY0cZC6bcCJMt-s7CeOMGk8w0XA-K1TB2UwkD3g@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] treewide: move bi_dram[] from bd to gd
To: ilias.apalodimas@linaro.org
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, 
 anshuld@ti.com, sjg@chromium.org, Michal Simek <michal.simek@amd.com>, 
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Ilias,

On 2026-04-27T10:08:21, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> treewide: move bi_dram[] from bd to gd
>
> Currently, the bi_dram[] information is stored in the board info
> structure (bd). Because bd is only valid after reserve_board(),
> dram_init_banksize() must be called late in the initialization process.
> This limitation is problematic, as it forces us to rely on a variety of
> bespoke functions to determine board RAM, bank memory sizes, and other
> early setup requirements.
>
> By moving bi_dram[] into the global data (gd), we can run it earlier.
> This is particularly convenient since boards define their own
> dram_init_banksize() routines, which do not always rely on parsing
> Device Tree (DT) memory nodes.
>
> Additionally, U-Boot defaults to relocating to the top of the first memory
> bank. While boards currently use custom functions to override this
> behavior, having the DRAM bank information available earlier in gd makes
> relocating to a different bank trivial and standardizes the process.
>
> Reviewed-by: Anshul Dalal <anshuld@ti.com>
> [...]

> diff --git a/include/asm-generic/u-boot.h b/include/asm-generic/u-boot.h
> @@ -59,10 +59,6 @@ struct bd_info {
>  #endif
>       ulong           bi_arch_number; /* unique id for this board */
>       ulong           bi_boot_params; /* where this board expects params */
> -     struct {                        /* RAM configuration */
> -             phys_addr_t start;
> -             phys_size_t size;
> -     } bi_dram[CONFIG_NR_DRAM_BANKS];
>  };

The mediatek boards recently started accessing this field, e.g.
arch/arm/mach-mediatek/mt7987/init.c

> diff --git a/include/init.h b/include/init.h
> @@ -74,7 +74,7 @@ int dram_init(void);
>   * dram_init_banksize() - Set up DRAM bank sizes
>   *
>   * This can be implemented by boards to set up the DRAM bank information in
> - * gd->bd->bi_dram(). It is called just before relocation, after dram_init()
> + * gd->dram(). It is called just before relocation, after dram_init()
>   * is called.

Since you are touching this, please use gd->dram[] - it's an array,
not a function.

Regards,
Simon
