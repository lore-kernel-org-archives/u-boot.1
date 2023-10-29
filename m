Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E048EC4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 16:22:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D344877CF;
	Sun, 29 Oct 2023 17:22:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59B068714E; Sun, 29 Oct 2023 17:22:31 +0100 (CET)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2995E8794F
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 17:22:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ngompa13@gmail.com
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-542d3e47fd5so1994700a12.0
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 09:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698596548; x=1699201348;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FvD7bKgk3psseGU2ALLXUinPQYkuYS7HE7cYUNUwUrw=;
 b=nZq4O6Er7OcwTMkWTJ0UK7BhhnAUrtls4tAtPvAkXadmxg6GYNzmyCOXDymalvsGf4
 PmoBb8/lsCj+08a8jztEpuOi2dY6632moG97w3gq64qhq2uRcw93isnJxsHfQwWwF9HZ
 ZH3HS27/EL8RISFnJHK+62QoNJKY4jJliFoRD2j1NkxS6XVRFTTPIVrW/cH5mJsS+vrC
 nvlQCV1u6Ju1hHX1TVA9Tgs98N7NRMHfzvpUniADw1NwaDbFOtoFEd551bwbzeUSTAx7
 jko+AIAoUqvRnNI56x8SjmdWpsYYbN9abqaoxdBq6PRfaBYB60SNcKzk2fDjPIePMT1C
 ep5Q==
X-Gm-Message-State: AOJu0YxIPzuDdrmZChQP6I/lGX1hU0LZhmRfPhBJu1TvYDmuAaaaqG05
 I3mBd5R9MGXkhaZnCZbPS9XV7nnz91xxSA==
X-Google-Smtp-Source: AGHT+IERXhJO7YehKFmyKdzpJaOxlR/MaJso74+Cl9PJr/HYEAoOA4sE9zs6jovImwcOjVL+4oTzhA==
X-Received: by 2002:a17:906:1b4b:b0:9d3:ccf0:7617 with SMTP id
 p11-20020a1709061b4b00b009d3ccf07617mr391968ejg.44.1698596547795; 
 Sun, 29 Oct 2023 09:22:27 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com.
 [209.85.218.50]) by smtp.gmail.com with ESMTPSA id
 g16-20020a1709064e5000b0098951bb4dc3sm4551617ejw.184.2023.10.29.09.22.27
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 09:22:27 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-9d2e6c8b542so81089566b.0
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 09:22:27 -0700 (PDT)
X-Received: by 2002:a17:906:da8b:b0:9be:23a0:68b7 with SMTP id
 xh11-20020a170906da8b00b009be23a068b7mr6126422ejb.73.1698596547130; Sun, 29
 Oct 2023 09:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231029-usb-fixes-1-v2-0-623533f6316e@marcan.st>
In-Reply-To: <20231029-usb-fixes-1-v2-0-623533f6316e@marcan.st>
From: Neal Gompa <neal@gompa.dev>
Date: Sun, 29 Oct 2023 12:21:50 -0400
X-Gmail-Original-Message-ID: <CAEg-Je8+fb=AP9JFA6Z6mV14spCA5bg_1LCzuW+n+Sypqe+z5A@mail.gmail.com>
Message-ID: <CAEg-Je8+fb=AP9JFA6Z6mV14spCA5bg_1LCzuW+n+Sypqe+z5A@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] USB fixes: xHCI error handling
To: Hector Martin <marcan@marcan.st>
Cc: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de,
 asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, Oct 29, 2023 at 2:38=E2=80=AFAM Hector Martin <marcan@marcan.st> wr=
ote:
>
> This series is the first of a few bundles of USB fixes we have been
> carrying downstream on the Asahi U-Boot branch for a few months.
>
> Patches #1-#6 fix a series of related robustness issues. Certain
> conditions related to endpoint stalls revealed a chain of bugs
> throughout the stack that caused U-Boot to completely fail when
> encountering some errors (and errors are a fact of life with USB).
>
> Example scenario:
> - The device stalls a bulk endpoint due to an error
> - The upper layer driver tries to use the endpoint again
> - There is no endpoint stall clear wired up in the API, so for starters
>   this is doomed to fail (fix: #4)
> - xHCI knows the endpoint is halted, but tries to queue the TRB anyway,
>   which can't work (fix: #5)
> - Since the endpoint is halted nothing happens, so the transfer times
>   out.
> - The timeout handling tries to abort the transfer
> - abort_td() tries to stop the endpoint, but since it is already halted,
>   this results in a context state error. As the transfer never started,
>   there is no completion event, so xhci_wait_for_event() is waiting for
>   the wrong event type, and logs an error and returns NULL. (fix: #2)
> - abort_td() crashes due to failing to guard against the NULL event
>   (fix: #1)
> - Even after fixing all that, abort_td() would not handle the context
>   state error properly and BUG() (fix: #3). This also fixes a race
>   condition documented in the xHCI spec that could occur even in the
>   absence of all the other bugs.
>
> Patch #6 addresses a related robustness issue where
> xhci_wait_for_event() panics on event timeouts other than for transfers.
> While this is clearly an unexpected condition and indicates a bug
> elsewhere, it's no reason to outright crash. USB is notoriously
> impossible to get 100% right, and we can't afford to be breaking users'
> systems at any sign of trouble. Error conditions should always be dealt
> with as gracefully as possible (even if that results in a completely
> broken USB controller, that is much preferable to aborting the boot
> process entirely, especially on devices with non-USB storage and
> keyboards where USB support is effectively optional for most users).
> Since after patch #1 we now guard all callers to xhci_wait_for_event()
> with at least trivial NULL checks, it's okay to return and continue in
> case of timeouts.
>
> Patch #7 addresses an unrelated bug I ran into while debugging all this,
> and patch #8 adds extra debug logs to make finding future issues less
> painful.
>
> I believe this should fix this Fedora bug too, which is either an
> instance of the above sequence of events, or (more likely, given the
> difficulty reproducing) the race condition documented in xHCI 4.6.9:
>
> https://bugzilla.redhat.com/show_bug.cgi?id=3D2244305
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
> Changes in v2:
> - Squashed in a trivial fix for patch #1
> - Removed spurious blank line
> - Added a longer description to the cover letter
> - Link to v1: https://lore.kernel.org/r/20231027-usb-fixes-1-v1-0-1c879bb=
cd928@marcan.st
>
> ---
> Hector Martin (8):
>       usb: xhci: Guard all calls to xhci_wait_for_event
>       usb: xhci: Better error handling in abort_td()
>       usb: xhci: Allow context state errors when halting an endpoint
>       usb: xhci: Recover from halted bulk endpoints
>       usb: xhci: Fail on attempt to queue TRBs to a halted endpoint
>       usb: xhci: Do not panic on event timeouts
>       usb: xhci: Fix DMA address calculation in queue_trb
>       usb: xhci: Add more debugging
>
>  drivers/usb/host/xhci-ring.c | 99 ++++++++++++++++++++++++++++++++++++--=
------
>  drivers/usb/host/xhci.c      |  9 ++++
>  include/usb/xhci.h           |  2 +
>  3 files changed, 92 insertions(+), 18 deletions(-)
> ---
> base-commit: 7c0d668103abae3ec14cd96d882ba20134bb4529
> change-id: 20231027-usb-fixes-1-83bfc7013012
>

Series LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
