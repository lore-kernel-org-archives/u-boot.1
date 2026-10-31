Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C8C606A31C
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 08:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=w0ftUeyo;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dY0xSQ+z
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B813D40B03;
	Sat, 31 Oct 2026 08:35:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GzV25S795evf; Sat, 31 Oct 2026 08:35:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B6A1D40587
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793435754;
	b=smqJkHGH33MVub+7RURy2NF8Hk0F8SEDizIcur8bEUO/zsXFIpjDhOJwXNAp8Y6RULBs
	 GWU0sUu68SPvJ2YbHFWfcK2EZpc8XmNx7fSyZxr1NpYL7qIIHR2vMHX/tVXMDVTLx2OKK
	 W4WzGFdhobAQoFXE5FA4hYnSjP9JLPCUln+nVqN/3zsw9wm9kl7cAhNQQBN/3a8o1bRyI
	 yQdneTLfJ+Y7fpYv71rBotmUMOwLwElma5z4j2xl0bXbxWSA7c9c6xJBdEHkFhJriutQ/
	 gyNmsoSkxeL4qq/tCJTRmxWFQj69iRd2npVdXAyJKW7JtjCTAUpXCzDnEML2OVRGXUA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793435754;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=v/XvrOIKP3BL/QeE9mWXDu8y1FTYv7a55RsJR+M0+xo=;
	b=pYklr4ZzpCoNE3sqCjLuaqFuDtqsobTd4yJNUpwCm5dguHCpEQ2r7K0gm0chIjFppOvE
	 lhkJGsU+czfiXbTvg6wJ+nogb5SrTCJfwj9h8P/cQWYkIPfYJ8MonZapgHDyIouRgiIhL
	 dBPUrMzkgh+XBrPe3bTrggzcWSoVX4HxxdUgV53y+Ek27HjMEjMv5MISxLDbDA01uy3GM
	 gS50VOY8JmIPOXVtOkapnads+Y323vyrseqPnWoTfp1NlbjAtRID9rEDA8jIxVFafkOIZ
	 bFqyPK+zA024kUsUC2saM0DBGUiIUvNSS4gMPDqq4wXhixJ2rVpStEIyktKyuMUcUGw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dY0xSQ+z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793435754;
	bh=v/XvrOIKP3BL/QeE9mWXDu8y1FTYv7a55RsJR+M0+xo=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w0ftUeyoottBvMw15VGVlPOLXNBcJ/TQHXSko9My0d9+QBgktONPAwG/lNS1Voqy3
	 eCCUqqtIK9xtuxBpxYEFgffBOpeLcpvAeJa/JBtGc4B2ZXupZlZajbfyox2zNP144+
	 6HpXunRuL76xLDztg68eddNbI/30uEfmQXLAKBNNwiRElaaOBOtzMwne0fYeWlLzEx
	 PTfddxGbGEQUMr10L71EPZ06MIDyfW6zvHDx9vN/cVJXgTvQNXFTtqdL4Ill3aAx3a
	 gM+uGAsbhS/oBv1XPGkZMU2a55MQWARD5lVcXGhG9nQt5mLavnI8GgqhELPQ0ucPWl
	 LYAvJSNTMar1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B6A1D40587;
	Sat, 31 Oct 2026 08:35:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 947C2156
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:35:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 91FD340587
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:35:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ys74o4v6ImCZ for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 08:35:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CA45140575
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::535"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793435753;
 b=r1RzYiJZqAHMI0zWRXwn58mV+FbiWdn6VgNjjRlLduy29yKl+W7sKyNRbFG9ehk2Oprs
 woJbPNI9OW1g3qdlk1us75qs12VWksVjAyqOxB2EEJ73LAe4vWoCZFj4gWXhF75ZajebT
 KQ1jtoz2KZ9gSUBl+V2mYTMJGMfBojbo0wirpHaHLklB1+liyjGIDYRFcGhT5umycLIq+
 uptG9V6cEdsqftkfQLCz151qW5y/5LFa/E15lgHwIqDmGRMo2qFqUGA99aR4bwuRksA/e
 UdjmInwOKR9fQds+Pg9gB6/a9d2m0G2xUDxlCaK7MFziAno8yxd47W3I9kA6KF2BGBQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793435753;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=v/XvrOIKP3BL/QeE9mWXDu8y1FTYv7a55RsJR+M0+xo=;
 b=c36PPrBB91m5tDv2jR8BKr2cC0nrfcB1xR3Giljmf+O7BpGswHwY1PuoWbodmnSVDG7b
 bUbapIaWzSRvVkmk3XDU7l2YyBw5FFrygwYKL97oyLoVx1lbE/Pgl5/Dd6F9Lxx+gx9PN
 HDe0SKCQ2ZUhJar/kzm+V+UxOaZ+qGSI9jQpxu2K5AlfJQCX6G5+4fYtb7RiIJJtiSzck
 CyJNU0GX1SOHt3vSStOR/1E2g49WQz7Wt2lsMAvCINxIX5NDpRMhdvLnAYRJ/sF/M6oYn
 qNOuqAQk/L9uoNA+8RqfmZfQo85yrZlrsmSd+2mChP/HOP1UKs2cwUpHEmNWxb/pkPQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=dY0xSQ+z; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::535"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=dY0xSQ+z
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CA45140575
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:35:52 +0000 (UTC)
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-cc4aa18f9afso658505a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 01:35:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793435752; cv=none;
 d=google.com; s=arc-20260327;
 b=C0u4Alc//w76n5hycDbD3v7QyfDFjn/ehzgO15kgjjzN5brrlCIa+pXAskH1CoJ62C
 hbpS1p43EeP7h//DJIa2/5fwRSJ+m+uq2805eNR522hb/iYUEx5d2hX+SD3es5IffBMa
 3+X2+cMx4sHbOmZ8goj14SaROhcVFFkFuP9JDZ0NO2kf2kGeuu0C/j5zqnphnbeb5K6F
 mVJw60OWk6QwwVD0nz0c4/64EPiUBwMZjO2hCpqaCtihWEuk+HCyojFFrTFejywoYiin
 MOQaD8L0yPlY8/C5G+Q7xqnKszVAz1PVz3eQGYV5uJt3qbeWsh4+3XYKGJAdRzpojqVz
 YKmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=v/XvrOIKP3BL/QeE9mWXDu8y1FTYv7a55RsJR+M0+xo=;
 fh=CeUn2ECKBnFEJxpp0CUW9JX1OHYCgQ0cqn9DlXlJVu4=;
 b=oM/w+DxQxf1y8tCWiP3F/kKLT+usN89e44gEgdCbPVV7csq701Ookk06rlYUaTa/um
 1gf5EFLLktkjHIiyjJxRpRQdbJYTNzDeubIWoHLsXWvd0cDWGchNKz6z5Vg0QEnpATNF
 IDhbaiKkqneQM+qn0X0vWkwOxNOeJWKCNhL5QKUaCqLqw659TKDtI0HqNYQ0jXgBka/D
 x1/zV6f2IMvmofg8x5T0T1rRnjFuTUNA4r4oTMi0neLnkgaoJTYbfLYWqhFY9aAkUCcp
 LxJeARraJbKTLKxsjIO2ZNaQbx1/xE4qtEaQrYpSm2d2WiXr3H4SiNf+J+3FDOGO6w8x
 R06w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793435751; x=1794040551;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=v/XvrOIKP3BL/QeE9mWXDu8y1FTYv7a55RsJR+M0+xo=;
 b=dY0xSQ+zuzYu6SgQRftlUTE7diqL0gDhos/pLdQngj5wizt/Yoh8lsjHf5ZrPCRIn5
 42L5vJfTmTV0nSjvIBzdZpt5QxLS8pKn6wX5eSu5AXFzR3grpbLIljit1VWixF4pYItQ
 CUlSJfY7xSbuFpesWN4eih0yBSVAjGVxSRtQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793435751; x=1794040551;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=v/XvrOIKP3BL/QeE9mWXDu8y1FTYv7a55RsJR+M0+xo=;
 b=fPMHfh6mockNKF/J6utJJLHg2eDosL3m65UVzZAN40cxp/76xSwrSiv4Y4f5R1qaew
 G1PXBLjXx1sm/XyrrxEQ4YDpeOD0/eg7OLThb8+B8O4a4kDxdcNU2Xhi5eXYhGJSnMgt
 eaRmyv+T2tvLGaG6aBNlt42GwHIWdX/m/YIpXSdvmNuXgyojG2YglsaiqSebgCScouf/
 +3Oyo1N0tF0PpeVtCachhc6fKglhfwKgYI5aHuDurQXwpwMa8PsBygxYFeJzykZCnNQU
 Skmdxf3uJr9NK2fTFPVpkIC+lH5a2v52Gxpk+V5SeiBGgXTzzZm7LH4vdKH/xaZWMqLH
 EMtg==
X-Forwarded-Encrypted: i=1;
 AKwUvByPW9T9NfsrIzvCRaMpWYRNsOv+ZS1jWb8Fu8dRKWVE74h/UbOpK1HsTRtU3UyPNwJCBScXDis=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIa6fyg3J8JaYyqWryKXiIb4OEDaAYdWmwqGBHGeL6KO1yW9uqO
 wqxbawzsT2KNJvMTjydZ8bqUuQfUUOg30I3Yfh7mQfrfmTCo74DChz8wAK6weoFNk9NhOKRpWmR
 NFIRIW9JGpL1JJHOAuLS7+jxAHuCABIBOt327c0r3
X-Gm-Gg: AYBFou3TLeZvbQBAl3xMYXosP+iXG8UN/+5/3pZRML2npMVySiYs0Q7V/Hw6GLA1w4O
 tO3IgK3Jb/oeGJ4y0jdiCCmr+nbh9xmu2Xp1sKibHvMqjx1jHRiDXWk2yeIiUNl6ggn/sgv/KyM
 Fwp6RcHKy+IdhWVW+4cr054xLZOJrvpAspk09IdtGoq4tTMv+D5vddOGS6LTYS0wMThPDZgK75y
 C09DPD8/4m/1qavjj7gPEJep2adUJABcj1tF0V5hJaWch427gefTzTIh62MAXtQmHQdiKvfg6aL
 MmwyVdUxp1ruqTMUUsXmwv/cKfVtPiFUG47yotUOQhHu8ybeDS4k5ui72lidBXvN7s4yP9dJcNt
 KJYmbuIijOr87XS1dnyZk3d1L66fJ3ysbit+Irk1i2WnmsB/qLJLu54/6jj3LFTLlwDC0bHU=
X-Received: by 2002:a17:90b:1c0d:b0:3ac:adce:60a8 with SMTP id
 98e67ed59e1d1-3ae8957a07fmr4031615a91.5.1793435751651; Sat, 31 Oct 2026
 01:35:51 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:35:48 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 03:24:10 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261027-spi-probe-speed-v3-1-33e056720925@iav.lv>
References: <20261027-spi-probe-speed-v3-1-33e056720925@iav.lv>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 01:35:48 -0700
X-Gm-Features: AclHuK_xuYn3wJpPyOUKz5zHX6IoeWkZnbjrilhWWKz0GmHWW1wQWMZPk_K3OIQ
Message-ID: <CAFLszTjfBDKfwpWUpGnnwwWHFuJY4d0Q+2+qzb1ZABUUCEduhw@mail.gmail.com>
Subject: Re: [PATCH v3] spi: sf: Probe a flash at the requested speed and mode
To: iav@iav.lv
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 u-boot@lists.u-boot-project.org
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-27T17:57:37+11:00, Igor Velkov via B4 Relay
<devnull+iav.iav.lv@kernel.org> wrote:
> spi: sf: Probe a flash at the requested speed and mode
>
> 'sf probe <bus>:<cs> <speed> [<mode>]' ignores the speed and the mode
> for a flash that has a device tree node: the probe, and with it the
> JEDEC ID read, runs at spi-max-frequency and in the device tree mode.
> The requested values reach the controller only after the probe, through
> spi_set_speed_mode(), while slave->max_hz and slave->mode keep the
> device tree values. Without a mode, sf probe passes
> CONFIG_SF_DEFAULT_MODE, so after the probe the controller runs in that
> mode rather than in the device tree one. A mode given once also stays
> in the controller for later probes without one, since the bus still
> caches the device tree mode and the bus claim does not reprogram it.
>
> On ROCK Pi 4A the device tree sets spi-max-frequency = <108000000> and
> the flash does not answer at the resulting clock, at any requested
> speed:
>
>   => sf probe 1:0 1000000
>   jedec_spi_nor flash@0: unrecognized JEDEC id bytes: ff, ff, ff
>
> Add _spi_get_bus_and_cs_at() to the SPI uclass. It probes a slave that
> has platform data with the requested speed and mode and restores the
> platform data right after the probe, so the slave keeps the requested
> values and the platform data stays as the device tree set it. With
> dt_mode it keeps the device tree mode. Add spi_flash_probe_at() on top
> of it and use it in sf probe with an explicit speed; without a mode
> argument the device tree mode stays. A speed above spi-max-frequency is
> honoured, as it already is after the probe. The other callers of
> spi_flash_probe() and _spi_get_bus_and_cs() do not change.
>
> With this change:
>
>   => sf probe 1:0 1000000
>   SF: Detected xt25f32 with page size 256 Bytes, erase size 4 KiB, total 4 MiB
>
> Add a sandbox test for it.
>
> Signed-off-by: Igor Velkov <iav@iav.lv>
>
>  cmd/sf.c                    |  2 +-
>  drivers/mtd/spi/sf-uclass.c | 33 +++++++++++++++++++++++++++++----
>  drivers/spi/spi-uclass.c    | 41 ++++++++++++++++++++++++++++++++++++++---
>  include/spi.h               | 23 +++++++++++++++++++++++
>  include/spi_flash.h         | 18 ++++++++++++++++++
>  test/dm/sf.c                | 42 ++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 151 insertions(+), 8 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
