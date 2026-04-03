Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF33E85379
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 16:31:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4154840B0;
	Fri,  3 Apr 2026 18:31:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TsL3Je4M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9982E84120; Fri,  3 Apr 2026 18:31:32 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A156183CF5
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 18:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-66e6dfb7b1cso323205a12.1
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 09:31:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775233890; cv=none;
 d=google.com; s=arc-20240605;
 b=PvxRSLdM/Daq/mohlRdzs4AX8lvVDPoawr67619rPtr/69i5zIswLk7f16rnOyngew
 GxsN7UZYQbsgvY7UujPNzieun58w37o26fUh+5/uUEcEm+4540y0h1I4QHTnKv9wusBm
 NTl7SPv/SuG9z14J3S+Apysur2WOOfX7iR9+lilVOko0aDdYUDRNVlAjfW0Lm9A95ekp
 1wOzN6czmGtQw6pX25tDR/YnmhRMhRZcyhBxuDF14amXfMnVowRbDc48a79nuvzBQZlB
 SUEvXpQBtrPqDKIz4cRcOmH2w6LPSYNSeTEUHcI+jeiRq/m4rKplOS0HeZUfI0gqAqC7
 WM/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=R51qOL6MN/6qeBkNQ+Th/Ny3FpwkhNHyp/x+x6F59fU=;
 fh=UZ7eT6Z4ohMrZowpVPgvGsEQ70KQegwOkkV2u/oT0YA=;
 b=HuaeeLDPu2yW2t5q+IYlOwRauRMksCa2eptW2LL+Tv3aXhzdQ8k/7QEGJ3Q7Yf/22M
 z2GgtxCAtv+V6QZCBE3aZf/T8tPbANJOWPstHs78o9IbVCit2r/sKYTaS91GCmbvKHl5
 iotndvaGzZV7UTX3bSiHXCYEQV1zNpQgddxtl4GTgqCXbAkIqELVepWQ/dHySdBUUbw8
 omNkQYBfjlbfANXPrHp/xliahkZvCxFj5fLHWDpsERdCSf4lyPaj6ROrVqz2HlATLjJ5
 PvQpqFkLfZ4guzCDeHQxwgrRRudqngndY1/KFOb8NIQu4Mkyofb+CippQSdwoqmMLTEC
 eqVA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775233890; x=1775838690; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R51qOL6MN/6qeBkNQ+Th/Ny3FpwkhNHyp/x+x6F59fU=;
 b=TsL3Je4MdQpaeW1Ak8Ova6ihtHYikQErroXVuCk2JMCQLGgppvihy5/mQ+m5L4XcG3
 AuR0l/PxVsGjKyca9xFgHeXEfrmB3B4y+DsLMNQk880XAdv7vTneFip9Y2tF5tDIJgCF
 jL15KlGxinfkosKjxO+RlfkSGzxXU2mntVV6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775233890; x=1775838690;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R51qOL6MN/6qeBkNQ+Th/Ny3FpwkhNHyp/x+x6F59fU=;
 b=ZBuJSgnLSfM0Zo9YhxAN0TL7B33Ib8l9gq3vnIRTNAmKhaYT/9UGv7Xk/4AkueKU2I
 OwjVrRyy8uBM1s685ARvD1f1sYPPKoat0oSZw7g1rMs65Pn4UPiS/bjw1+isTbCe1L3e
 F8+GTyAgHgzkC+HgADzS6GNKuZXaTO093wSFwv7em+RZBL6emyTEYz8T4SbirqHzJx2H
 0VoveUQH9nfjQVHa1YKL3v+taD2cifkQnOB9cpDJj+tclp/E0bfo4KywLUAw4D7ih8UL
 twau2Z06SJiqo5kHxTl67zouY1zR1GPBPaWoGFs1gzzqi0yV4ZE1wumbxd4wJVoc/Poa
 SV9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU14kSzGoVVZpr0m9RFBrTK8A6jh2WTkSHRJKPXXbHLFK40siA8q9TrKSn5HlKxe6f+vQJtFbs=@lists.denx.de
X-Gm-Message-State: AOJu0YwXkvdmQIaTwo/yfUOxDt/7sj+jmTpRGY7uCfWh+fT0N6PTdwhh
 ugYkDoPZxHKxt2m9Jh+ADPbfjBBl/jHDjljaJbIqOGhX7Darcf+1Ic03iiPal07+CY8RQmEVAQB
 Y3PYcpPdftXiJpnrSbFYB2P3jmO0KWwS7Xxw1F/Y3
X-Gm-Gg: AeBDiesyrsqKqdVWYwgJCHJwX9QtMPFZuFny9CqyHgGlSUJN2P1mz5w3QR55WoSj3uK
 XxignD1nWnoS/VCc8ROttQVlz5UHzRnGDaNgOvBwtnixuXbV3jiWtYTJEnBxXu6EKavOrOTf2Nx
 0B75PGcaUqJzrrN1vTXH3Ax2RbkOD7hs2hg7f4QpjM6SRgh6VlcDHKqPnisFUnsEYo8shk7kP3D
 RRS5xcw16PF1gLaK9KszorgbPewidcrIQlSushpQe42eg8g+ifRZEyGQG6Ux6WtwtpMfOXsUqio
 or5NO22KnZVeoia2
X-Received: by 2002:a17:907:3f90:b0:b9c:4086:a410 with SMTP id
 a640c23a62f3a-b9c679e490emr147814666b.46.1775233890035; Fri, 03 Apr 2026
 09:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260331191853.44549-1-gary@garyguo.net>
 <CAFLszTj-QRQBCZHNCyM6YR7n5M4+myr8ztDo6Xn9CfDb6=ppSA@mail.gmail.com>
 <DHJMTRNSOX3S.2LQPF5ATDP78S@garyguo.net>
In-Reply-To: <DHJMTRNSOX3S.2LQPF5ATDP78S@garyguo.net>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 3 Apr 2026 10:31:14 -0600
X-Gm-Features: AQROBzBoJYouKD5vbYoqrHwBRvoRkSq9NMzuZlvgg9ULOb3mY_xWjFPiSTkGXB0
Message-ID: <CAFLszTiLZamF1ySMhtGOqJdzCrYdTRyUvFKu2s0h+ms+EgOZFg@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: support EFI_OS_INDICATIONS_BOOT_TO_FW_UI
To: Gary Guo <gary@garyguo.net>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 David Zang <davidzangcs@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, 
 Javier Tia <javier.tia@linaro.org>, Martyn Welch <martyn.welch@collabora.com>,
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

Hi Gary,

On Fri, 3 Apr 2026 at 09:41, Gary Guo <gary@garyguo.net> wrote:
>
> On Fri Apr 3, 2026 at 2:22 PM BST, Simon Glass wrote:
> > Hi Gary,
> >
> > On 2026-03-31T19:18:51, Gary Guo <gary@garyguo.net> wrote:
> >> efi_loader: support EFI_OS_INDICATIONS_BOOT_TO_FW_UI
> >>
> >> EFI variable OsIndications have a bit EFI_OS_INDICATIONS_BOOT_TO_FW_UI
> >> indicating that the OS (or next stage bootloader) requests booting into
> >> firmware UI instead of continuing autoboot process.
> >>
> >> Support it by having autoboot.c asking EFI bootmgr if boot should continue,
> >> which checks and clear the bit (so the next boot continue as normal).
> >>
> >> With this change, systemd-boot will show a "Reboot Into Firmware Interface"
> >> option which will be able to drop back to u-boot. This can be useful if
> >> bootdelay is configured to be -2.
> >>
> >> Signed-off-by: Gary Guo <gary@garyguo.net>
> >
> >> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> >> @@ -1290,6 +1290,51 @@ out:
> >> +bool efi_should_abort_autoboot(void)
> >> +{
> >> +     efi_status_t ret;
> >> +     u64 os_indications = 0x0;
> >> +     efi_uintn_t size;
> >> +     efi_status_t r;
> >
> > (I'm leaving the proper review to Ilias & Heinrich, this is just a few
> > nits and a though)
> >
> > Please can you use a single variable name for both efi_status_t variables.
>
> Ah, I think I copied the init part from somewhere else and forget to merge the
> variable names.
>
> I'll adjust the variable name in the next version after receiving more reviews.
>
> >
> >> +     ret = efi_init_obj_list();
> >> +     if (ret != EFI_SUCCESS) {
> >> +             log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
> >> +                     ret & ~EFI_ERROR_MASK);
> >
> > The log message says "r = " but prints ret. The similar message in
> > efi_bootmgr_run() just prints the value without a prefix.
>
> Sorry, what do you mean by "without a prefix"? I think the code is identical to
> the one in `efi_bootmgr_run`?

I mean you don't need r = in the message. You could say (err %lu) perhaps?

>
> >
> > I would also like to see the code which adjusts the variable placed in
> > a function.
>
> You mean the bit clearing part? What benefit does that provide, considering that
> this is just a single function call?

There is reading and write. Being able to control that could end up in
a command at some point. It is a useful feature. Up to you though.

Regards,
Simon
