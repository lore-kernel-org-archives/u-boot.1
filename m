Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307DEE784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:43:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D10AF874CF;
	Mon,  2 Oct 2023 03:23:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NmEkSrKX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7699874E1; Mon,  2 Oct 2023 03:23:18 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58AAB874CE
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9b281a2aa94so1603152966b.2
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209787; x=1696814587; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IPz2rrMJ8rxAFmGpCIXZQYzOTV87VoONs1Jier4iGGw=;
 b=NmEkSrKXYVSSDwRCfP+CKK1/UyGHVmHoyNQyl4h8uQC0FuHWfZE3dxkgbyIhhP0tWb
 EpCngW/b433I5fgQN1WVP4CKY+TIoAPLGkeEZ/WplTgJLT/jUhvds/nWJlGTZ3aZiwj3
 TdZoEPnGYOwYi2g3W8qEv+MS8I/0kMdhAJbgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209787; x=1696814587;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IPz2rrMJ8rxAFmGpCIXZQYzOTV87VoONs1Jier4iGGw=;
 b=mujfQz+IxO9Fnyz9nvMZRvgAfI1T/TOp5COxz2i88NQ8+78sIVWBiKkG5+3XebA0ye
 oFXiwaK9zfhgAMs4XCueFzVtAQRHP6yRgvG/I0hmNf47gCxTbCH/zuCwPJ4aLgu8D364
 k+zNgejLTW8wCY/G509SU1obur2auSuY77PwNJly+IZA2RJs0908LQ+2bO8Spjh+I3C9
 vJR8CkGAdsSYu6zhTrOOyhvcbxEvf99tX3syECIprNOHatC4UdRyunuBnQjvnX3hLzul
 eYL5MPfLo9Fcp8FjAXowzvnnc+WsTKSw0QrB8vGDWqjjHcxy5OLoSgHE80FnFjDeW52T
 3IgQ==
X-Gm-Message-State: AOJu0YwbCgeLN5IL6M2cgNCo/FtImHLEkdsuzLD90tdAyDxZaltMW8LU
 /egapkVTdwN9IfYqhH6hPzkWBVOXBC7GNqDNzCGNlQ==
X-Google-Smtp-Source: AGHT+IE6MP2pPXHyE/P2s/LecDDhr6PhRX4aG/MMyv9nPZBC3tX169vj3g4bgSZqoIkYU6b533Y2OFQibT6pCL16ZY8=
X-Received: by 2002:a17:906:2d2:b0:9b2:7a4e:69fc with SMTP id
 18-20020a17090602d200b009b27a4e69fcmr6562116ejk.19.1696209787354; Sun, 01 Oct
 2023 18:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
 <20230928080257.2650461-1-rasmus.villemoes@prevas.dk>
In-Reply-To: <20230928080257.2650461-1-rasmus.villemoes@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:17:20 -0600
Message-ID: <CAPnjgZ0MpkjACRuZDkCbc8xGHjFrNRvNEGy+6cN+pvUUAeEgsg@mail.gmail.com>
Subject: Re: [PATCH 5/4] mkimage: update man page and -h output
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Sean Anderson <seanga2@gmail.com>
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

On Thu, 28 Sept 2023 at 02:03, Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> The man page correctly said that -B was ignored without -E, while the
> `mkimage -h` output suggested otherwise. Now that -B can actually be
> used by itself, update the man page.
>
> While at it, also amend the `mkimage -h` line to mention the
> connection with -E.
>
> The FDT header is a fixed 40 bytes, so its size cannot (and is not)
> modified, while its alignment is a property of the address in RAM one
> loads the FIT to, so not something mkimage can affect in any way. (In
> the file itself, the header is of course at offset 0, which has all
> possible alignments already.)
>
> Reported-by: Sean Anderson <seanga2@gmail.com>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  doc/mkimage.1   | 6 ++++--
>  tools/mkimage.c | 2 +-
>  2 files changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Strange that your patch says 5/4
