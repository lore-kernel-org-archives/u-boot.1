Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89257606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 08:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rFOuQ49H;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=QBN1uNvu
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 550F76075D;
	Tue, 20 Oct 2026 08:24:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2SKQbH3Glhfg; Tue, 20 Oct 2026 08:24:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 93E2B60774
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792484696;
	b=H8XhCV1x/CQvL8/X56d0gGQV9tP66viPxt8gS2RhZrcc1IszRX7jLtTOXOs0GMEg+bZH
	 7D3UGyNeX/EUbSojpmx0LdoX1rOvj+2zpVRzkfEyjWK3EL97pv7+fYXEOksBOamRxsGX1
	 yMCvS0i53qAVxPubKCO65oU3Mmoj7QHXZFRHMUp77CXGTM1PggIFhW7RI9udkbzXgCMEA
	 JzvsoPoAfcRTeYNahIdy0ZYvU212FDiKpMX1VSuv8v8DPAwBAkhNFTs1l/ZvJxiw2i9i7
	 /kpfHdb5oSJemZi50YbUs9j3pFZAt8TclUSv1qr42bYKfidQxjz3eW7oAru4U+6bJ3A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792484696;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=pQ4uWaLiTOvnYAwe838gnBZoR6ZgrvM47KSuD4eQ++4=;
	b=TCfoTh1zqObETNkQ+DmFy4Gr5nR4aD1c00DYNzdMV/MTGo6Noj191ezTtEvDZYQa0Ksl
	 3uV2m2+nx06IWAQ3FVaiAegUGQgq5SuOBDzy62OY0mnAYViGJyw8GBNxlPTWCeC549xzm
	 tyw8nt4ImZt5/4KuDHwpc/azY5l2w0Vyu2uQy+3RTlpVsRMi5B5sfhJP9oK+qbgK91+xR
	 qqLl0/5VoF4KQV5XKwYMS1yR++wupbL9alC1+O6yXZ2iKYr8kgao7i0EmiRIakIc+lUIX
	 TsCDcnYd5Z81WlPsRQTWLibKNLI47duPwjLoGlHWzGC1BWAI29nfCREqQgGc/V9ZQxA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792484696;
	bh=pQ4uWaLiTOvnYAwe838gnBZoR6ZgrvM47KSuD4eQ++4=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rFOuQ49HpL1VE64aYk49Z2XtPJzjCeRU4aUyzJtjOo6xkVfRBD+SxQNNJPbcKs2Qu
	 qM7FiCrVcbfI4xImqD8povfWN1pQ/6mg1KSEgJUjkkkvFokD8YUtiW+7dVMTXxV3ii
	 ymzpJhpzXzMEIDzWWmIbUtD0Dq0Xu0ojzvbCo1gLuKAmvab/IJQPEPONmDaO2xk5pc
	 F+bC6reJSSYdqw7S2KpSjmW2lURef0u/dRXjozuxjTiTduA7Lm8ZYUsb2hSMzeLEuS
	 59GguYzDTdxjIku7JJ2eim9NaO7ZlGMChIWOpMCLg6ZngIdpoOJaqMCw6sQ2T0AE41
	 lHoPqNC5GyKvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 93E2B60774;
	Tue, 20 Oct 2026 08:24:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 81C671DE
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:24:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6FAC58107C
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:24:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cF7sEfkQfiDo for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 08:24:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 719A08106A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::533"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792484694;
 b=WS24ShCSoQNXH5j76+Z+2TcWyjqAGNgj4HTfRFN2Jxgmt/Dry5hFifc3XiWYzkmUd1NT
 G5D5fJ9dLZOrwRcReKbPP7Zz9/g6KrqdYb+ZS5k9osskjaXrrsOnrmEYEgqOL7pvyajhI
 fjM7l/zSlU0yaEEWOr51Rxp1C2QEfcVk6DirdSCZqQnDONOPE0suhK1JAuYuGETBUq/MZ
 NP00Sh8ddQK2EEMe6NHw8K0/pyLNvuzKfuCarAUYuF5WnFviYz4RuEcEuw7i84JLmQOXd
 AkK0kXC2EmG3IWYKBJHrUPKK8z4qPENDXB6/1CCyStbYLofXrIxVypLwRZOK3BEum3A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792484694;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=pQ4uWaLiTOvnYAwe838gnBZoR6ZgrvM47KSuD4eQ++4=;
 b=YXKo0Gi0RvaQyFcm4JMFEGPynnEP+gjqsYGQs4NrQZ8DYzXXEtONlI60OnKFu8VbNlYX
 nfSKtiTynDESPPMDAlofqRzf/FXtLv/C+gFD8Wi/0Md2s8VQ/je7BdQO9KUPpqTuGZ15M
 kRDYJvnKJiRmr8vG5PXsrPML+2Ot1IU1HMW3fxhr2yYHDU8/nnmXi1qzqElc4P01iSC/I
 PeiGkVpEe7pw7a6Um6c+aC5zKAG4ntNKSHJ2POLLd3kLIsFPcFpdtU+MLwl+8Y3Yxl3Ik
 r7ZY0A/L4y26S6hTyKon3fwAdWm6ExfXBA5FXaBhziwc+ylM5y7DdwAqCgb1lwa1wdg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=QBN1uNvu; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::533"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=QBN1uNvu
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 719A08106A
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:24:53 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6afa651700eso3960322a12.2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 01:24:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792484692; cv=none;
 d=google.com; s=arc-20260327;
 b=fns980xEGTQ7ZeG82DArlyduxKplWasA43nrGi6iXHGPs3WY41sLKM3Tv5lgx7ZkO+
 pohbydF0sXDusrTbBeMnD17UKHM6ZlrcCaCjBXJR6Ed87Ttjseh6PlQ31sr6+JmHk0m1
 Nk95812K0MvpAT/Eg+BfD8us7mvYC7yzPmK18m/Zn6BVLbi1NzjmQyEhdCPJBjWA6gRP
 lVyudWVDxdF9T0agZBHyAAkOVEcQ0IOziRsAz2gUQW3ws7xKOwJuzl53zKo50cIGKzhu
 9nnDDqg7RiIwNz83Axw+jGivQEsu8gWiTsq367dywuUt6wzVmNz6mAPvDRud5WBpDvRV
 /5zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=pQ4uWaLiTOvnYAwe838gnBZoR6ZgrvM47KSuD4eQ++4=;
 fh=QxYpHIDESgEIuv9TtiRVK/MlO6tGAXFmwyOOv1wuLHY=;
 b=ZcIeZIpKgoHvOFIs9i7ZS6A44rfFbKrFwKd21ulsYEsaF1Py7lg6VOftozaXc9TuV3
 mID01FSL+Vd3nwQGN4pDM9c+PUaFYmc/zzbCjz5LNRJQRVu/bj30aewiR8P7wazZ2UtV
 AmIWu+ILkb/VlxsKo+/Pm8LiFxIUoJ946GPoxIBcbUHHQDaY1fGl3cTapcLKUsxRY7R+
 N4VDciz/w5+lov+jVvMH8yZD4MVao8+61DRjglhumtdOdOuLjBb8JmS6zbw0uENSwu/u
 np1fpv4uM+UXewGV/yX+i93hCvvFUsxe3x9kMgdIvA7L7KxbHJVaHrcnEwospDP5rENo
 2jXQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792484692; x=1793089492;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pQ4uWaLiTOvnYAwe838gnBZoR6ZgrvM47KSuD4eQ++4=;
 b=QBN1uNvuQVpLjFgQK29dq8pnZ8Map6hrIM7lF6+l43EiHQT/rY6bYVLURnZGT80ls7
 afUdsH3FlcN/TeZBJlczfc3+5gHIIGTTvsPkcjzdcCG3j6RlSD9J5yEipSIZMTuY5qqO
 LKqfE4z1qLejq8t+Lpy+6/UtHEBlnlsb8wJ/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792484692; x=1793089492;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pQ4uWaLiTOvnYAwe838gnBZoR6ZgrvM47KSuD4eQ++4=;
 b=gs7+dynlY46Ad3SXlBoS8sbRMTEaqs0wqllO6WZ1tapGms29Fc6ylCcalLMbwjFeHJ
 3Ecd1LbURdkrl7fhxdnfWl2eOMOHSBtQ7pL7YkDaJm7QWZ9HFHxARQJtyrV1t0BNekOj
 TBKx/GYuHD8M6GJTi4rh2sikT0qZ4hoxG20lh/veorQUZqNkxuXVIP5nv4HfGVsggwvM
 M8E7igsPq2YPQlDK1FNxjtdzuCkYiY5mqbEom34u8guAPPrCr101K9XdGVs6nvAizklI
 4hZy1M4poIO1YT9AAy03CKKBtXGrp3Egs0GD/q24T1lJ15eszCa4puY84oilgFM3jJVd
 WRQg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxCkH6lYkDWmNqRkcfsTM8blMHQDsgCBOS7vzulioL00qQQgFAhQbdRQ6Bgyz76nTT7uA2vpf0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJZCjqoVzsN1pL2MrcSSuw0TbeU/qNinUwr0axKxfJDfBa8Ln0o
 DhJf35K3AjtPMEttgirV1vxvjD5Xz6AnFViPZMUEcDYOeBUZVg6lEXYPuy848/PBvY4YrT1BcAl
 O4cjRXlfIy9xOvj+A/KrCuRuz85kq2xp18twTuvNH
X-Gm-Gg: AYBFou0SeslR8ak7OtLKowzNvRFj5LfWHvgSHDdUxIPJs8r1kWUSe/ePNHlYnXp1vmn
 xG8SFcxspAkImeMYK0O6G/7bgRhZe+R38+GM9AJ40/Sj01DoOQfwAyJCaPNUr3XTtAmQX5XA0ZW
 xniUKjaSDR3tAMiOajxSvKw+p1/4mE3eS8A/HTRceHo+A8OGNuJvjnSuhxZi8CS7OFSInIvymTc
 QypfhIAFc5ODNNVOu0EMY2bi3u6NheNGpRLBcyONLlpyWZ3Oh8TIi0gMALG8SA6YuGK+W+Opbcs
 nY/7AG174aVSm61awzdrYdLWsK7pvCf7XbQbFbT636fX9q4rlWzqwyfyxMkiOFCd
X-Received: by 2002:a05:6402:20d6:10b0:6aa:e589:87d7 with SMTP id
 4fb4d7f45d1cf-6b3a8100c06mr4967249a12.6.1792484691758; Tue, 20 Oct 2026
 01:24:51 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 01:24:49 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 01:24:19 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261016-bpp-helpers-v2-1-ca1e6bba2820@gmail.com>
References: <20261016-bpp-helpers-v2-1-ca1e6bba2820@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 20 Oct 2026 01:24:49 -0700
X-Gm-Features: AclHuK9XDeB5A6aRT2gO77-IIU8q1cHzzPkOU3emTSpBMfBQaukQcXWSPb5shi4
Message-ID: <CAFLszTgPjXzeYKt+AjF6HdXsE4TxxsjeyreuqTDGHJ-jbur+xQ@mail.gmail.com>
Subject: Re: [PATCH v2] video: use bpp conversion helpers consistently
To: imkyufie@gmail.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.u-boot-project.org, 
 u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Eugen Hristev <ehristev@kernel.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Andre Przywara <andre.przywara@arm.com>,
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Reza,

On 2026-10-16T06:30:48, Reza Kurniawan <imkyufie@gmail.com> wrote:
> video: use bpp conversion helpers consistently
>
> Many places open-code the conversion between log2 bits-per-pixel and
> the actual number of bits or bytes per pixel, using expressions such as
> "1 << bpix", "(1 << bpix) / 8" and "((1 << bpix) >> 3)". Meanwhile,
> <video.h> already provides VNBITS() and VNBYTES() helpers for exactly
> these conversions. Replace the open-coded expressions with the helpers.
>
> Using the helpers makes the intent of the expression clear, removes
> duplicated bit manipulation, and reduces the reliance on the specially
> crafted VIDEO_BPP* enum values, since callers no longer need to know
> that those values are log2 quantities which is also important for
> future extensions.
>
> Note that VNBYTES() is only correct for 8bpp and above, since it returns
> a whole number of bytes per pixel and cannot represent sub-byte pixel
> sizes. Every site converted to VNBYTES() here uses 16bpp or 32bpp, so
> the result is identical to the original expression.
>
> No functional change is made.
> [...]
>
>  arch/sandbox/cpu/sdl.c                 | 4 ++--
>  boot/fdt_simplefb.c                    | 2 +-
>  cmd/bdinfo.c                           | 2 +-
>  drivers/video/atmel_hlcdfb.c           | 2 +-
>  drivers/video/atmel_lcdfb.c            | 4 ++--
>  drivers/video/imx/mxc_ipuv3_fb.c       | 2 +-
>  drivers/video/meson/meson_vpu.c        | 4 ++--
>  drivers/video/mvebu_lcd.c              | 2 +-
>  drivers/video/rockchip/rk_vop.c        | 4 ++--
>  drivers/video/sunxi/sunxi_de2.c        | 8 ++++----
>  drivers/video/tegra/dc.c               | 4 ++--
>  drivers/video/tegra/tegra124/display.c | 4 ++--
>  drivers/video/ti/tilcdc.c              | 4 ++--
>  drivers/video/tidss/tidss_drv.c        | 4 ++--
>  test/cmd/bdinfo.c                      | 2 +-
>  15 files changed, 26 insertions(+), 26 deletions(-)

Thanks for the respin.

Reviewed-by: Simon Glass <sjg@chromium.org>
