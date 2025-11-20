Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436E5CFA459
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 23:41:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7DF18415E;
	Fri, 21 Nov 2025 00:41:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XTPRoFjn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F069E84148; Fri, 21 Nov 2025 00:41:09 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0DF38405F
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 00:41:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-341988c720aso1150321a91.3
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 15:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763682066; x=1764286866; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f40Xt6Fk0qTOsNYXYMzTZA/6HMFNLbPS6wwHLnpaqCY=;
 b=XTPRoFjn7BguTnE3EovhRQu8A+RXbnK1AtP1+e0yom7r2Z0EHIVDDsoONMk13HPoXu
 Nk6CSq5XbyKuWMn9K1LANWYIStH1/ed90xpT96EiTH+P5AGtdBOguybmwO65c1bfhKx+
 qCduBvDhXr/mbx4LvE6rkVTwRK47nn27bgJLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763682066; x=1764286866;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f40Xt6Fk0qTOsNYXYMzTZA/6HMFNLbPS6wwHLnpaqCY=;
 b=c99eRIH5qqHRxoxCSAZQOJ14QQFj7n5XSm0vGDPQAMR/p01rmlvm3puasU/VvQAq9/
 G1672+PBIzjwEXxFsNCwG+3EI8mkloHPgHTEKLZlW7lArNV9wmpBwsHa+0ZQtwrbXpR9
 sXH/VroRtwXxan15TCxU2OcD6L1xO1RDSPnwcM9wpo2fKAkf/2TRhegSu3G4Rb34lukN
 +X/A0FGJQq76VD47I05LkHDA2aR6sugjEc3rzYm/CzE+DW8Cx6kBqpUmrbJ453vwOfVQ
 3al6X1hZ00+rtX7/w8NyM4J6fVBwXQRQari1YRs94ZsUAKMK1qrXGnpNxdrMvSRh10Rz
 n2rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX63PU60YLYFx6kEV82cyNrNHZkeelDE5dpFVRP4fmjCMLEHg6hjubP5IxE5tX8GbLiv7orhfc=@lists.denx.de
X-Gm-Message-State: AOJu0YzgBgB7G5s7w4ymd5+tYm3pArmK8h4sb6QU9mCGxCmqcZD4FNTy
 4WKWrQBQDYNOmzxOqHWMQMAo9ACWaXL1BvhYCqs0L028QJlJpdEjnOQ2L3XckMuzbxAGK0gWj25
 jcikd22bda6ApW7Z/FnlpgIQgkxphuj5u9Qi0ria+
X-Gm-Gg: ASbGncvIzNxdiW7dyNhrC1+3SU/KhFBX3ROhzUkB4onIuKd8R9mka/pcD+ZBx9Z6HeS
 UJavMJSkTelU/F34rIroiY28ikMWLTntpWriged8LPeh21+zowlxbQMVVxDzRFMVNAibW/YpqyE
 rtrPbzgBTwCKOT10YDyY75c7COEd/Yl/PrQ7BVc3/o0B+je26dG0jFXmdVrmdDmBUUI1gwl1uck
 cHxesm2GQtrYNYEMhsKhazOal0OBWWMM3YoCpSYHRiarSR/EsNwv5fW5lTL/M2ZyzVqJg==
X-Google-Smtp-Source: AGHT+IGU7mk5UgKRVx0BY6WtaIuzejxEVGce5fx5KZioRBiEtBuBoCrYYOPmskLx4Rl9K9CzcpEwFrG6AAcpgq0wl+U=
X-Received: by 2002:a17:90b:50ce:b0:340:f7c4:7c78 with SMTP id
 98e67ed59e1d1-34733e6b390mr237218a91.3.1763682065839; Thu, 20 Nov 2025
 15:41:05 -0800 (PST)
MIME-Version: 1.0
References: <20251120193448.310274-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251120193448.310274-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Nov 2025 16:40:34 -0700
X-Gm-Features: AWmQ_bmfPS9nX20Oc0-WvmQ5i1MCHopYjZGkYe-alAxcYK0EWWLdoAJkgUWcPO4
Message-ID: <CAFLszTipwat6M1t0qgmmtWGRq-LO5tJ0RZjRT2oiSyVG_oGMnA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] video: add DejaVu Mono font
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, u-boot@lists.denx.de
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

On Thu, 20 Nov 2025 at 12:34, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> A TrueType font for U-Boot should fulfill the following requirements:
>
> * mono spaced
> * support full code page 437
> * easily readable
>
> Unfortunately none of the fonts provided with U-Boot fulfills all of these
> requirements.
>
> Let's add the DejaVu Mono font. To reduce the code size the characters are
> limited to code page 437.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v3:
>         Don't change the default TrueType font
>         Add all special code page 437 characters in the range 0x01-0x1F
> v2:
>         add two symbols used by GRUB
>         add the FontForge script used to generate the reduce font
> ---
>  drivers/video/console_truetype.c    |   4 +
>  drivers/video/fonts/437.ff          | 291 ++++++++++++++++++++++++++++
>  drivers/video/fonts/Kconfig         |   8 +
>  drivers/video/fonts/Makefile        |   1 +
>  drivers/video/fonts/dejavu_mono.ttf | Bin 0 -> 44508 bytes
>  5 files changed, 304 insertions(+)
>  create mode 100755 drivers/video/fonts/437.ff
>  create mode 100644 drivers/video/fonts/dejavu_mono.ttf
>

Reviewed-by: Simon Glass <sjg@chromium.org>
