Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469C0C25B6E
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 20:42:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8699787748;
	Fri, 27 Oct 2023 22:41:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I0hNu7NB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D65F8763E; Fri, 27 Oct 2023 21:42:58 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F165286DC3
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 21:42:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ngompa13@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-542d3e47fd5so50851a12.0
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 12:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698435775; x=1699040575; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MjCNJUH4XI4ZJeN1+OaSxgenZOZV/PYnVyqlHJ9C/nw=;
 b=I0hNu7NBk1vQnM/MnT3VZ3tqzZVFHRZ75YUT8cD+JDRHkDrwr3BS8FgCNNumrHKxSd
 RRuWUJG0mT3XLi0aRU4iKEbznqvql9Y6ttPl3HlgouSHbLo/qJyMR3Mo3RKGw9pH5VZj
 vtXIkg/gPR4z7+OnM2jrUximNjQaZyx3TkN1Wx/+m1OTKZ3j7qKPkFakoWAU6AxuYGJ5
 E99YIIuImc/UdkbRvodld/x57cgE0eT1rc19GBmre4PwcIAaKAcjf8c9qj1xr2ZGgz4R
 c8CbX1QEW/uvVMCyg3CWSIbk/G6T5QJ66OKP/896H+rjBl7GypZWYzAdQEtd5Ak/as8q
 my9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698435775; x=1699040575;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MjCNJUH4XI4ZJeN1+OaSxgenZOZV/PYnVyqlHJ9C/nw=;
 b=rOvhAGMNlBssffcDI+PUcPbu9X2AAJBzcuf85hwfcxKUDdOpFoBgKXuwJ4MYaj7iAq
 yug7bphE+enK6Z/KAms32UbQm0Sj3vUQJjrAIBOOqwO8BVfBOJkhywrXtCf8qtjbpQlD
 bRUBopZmRFR+5ChJGOx/XGuzMQlW4Al059YmBWj3lAcRxHKsYAFcTddmHAeqjUz5rqEM
 BNyk6f6piJKxEEOB+YOvzkAgSP6n9FA075FYfbUxh3ckqhUwQeWZebGeQthBO8eyFwlM
 72Cv8rp2GurJ1Z9ndsLDq4bB5dI+O297LLf3FhPHB2VB0mwRjIGXC0R+M0HOvGEkmS0G
 QmHg==
X-Gm-Message-State: AOJu0Yzn0mPlPO7yTfhrzTnX12GqcUSkimInpxogaxG6/gfm28rO0BWo
 YhKAl/TsKzjPTGyJqs2J5UH1O+1NpCrqEOWgbVc=
X-Google-Smtp-Source: AGHT+IGAryab5AiuJkZtlFTy+YnT9Zz66ged/cD0vmWVeQ4aLi1S27h6W2XcolXR+5hM0tSIMk8je87rxfha67owFC0=
X-Received: by 2002:a50:aad0:0:b0:53e:8e09:524d with SMTP id
 r16-20020a50aad0000000b0053e8e09524dmr3094815edc.5.1698435775252; Fri, 27 Oct
 2023 12:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231027-usb-fixes-1-v1-0-1c879bbcd928@marcan.st>
 <CAEg-Je-o+xSG-Yxtqt=+HAZds_HO62dtkAZ64kon_a6xG5SaOA@mail.gmail.com>
In-Reply-To: <CAEg-Je-o+xSG-Yxtqt=+HAZds_HO62dtkAZ64kon_a6xG5SaOA@mail.gmail.com>
From: Neal Gompa <ngompa13@gmail.com>
Date: Fri, 27 Oct 2023 15:42:18 -0400
Message-ID: <CAEg-Je_Heanyggk=p2V3x4y1qJ9=eR50RCj-ZZvFnmy0aKbmeA@mail.gmail.com>
Subject: Re: [PATCH 0/8] USB fixes: xHCI error handling
To: Hector Martin <marcan@marcan.st>
Cc: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de,
 asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 27 Oct 2023 22:41:10 +0200
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

On Fri, Oct 27, 2023 at 2:58=E2=80=AFPM Neal Gompa <neal@gompa.dev> wrote:
>
> On Thu, Oct 26, 2023 at 7:26=E2=80=AFPM Hector Martin <marcan@marcan.st> =
wrote:
> >
> > This series is the first of a few bundles of USB fixes we have been
> > carrying downstream on the Asahi U-Boot branch for a few months.
> >
> > Most importantly, this related set of patches makes xHCI error/stall
> > recovery more robust (or work at all in some cases). There are also a
> > couple patches fixing other xHCI bugs and adding better debug logs.
> >
> > I believe this should fix this Fedora bug too:
> >
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D2244305
> >
> > Signed-off-by: Hector Martin <marcan@marcan.st>
> > ---
> > Hector Martin (8):
> >       usb: xhci: Guard all calls to xhci_wait_for_event
> >       usb: xhci: Better error handling in abort_td()
> >       usb: xhci: Allow context state errors when halting an endpoint
> >       usb: xhci: Recover from halted non-control endpoints
> >       usb: xhci: Fail on attempt to queue TRBs to a halted endpoint
> >       usb: xhci: Do not panic on event timeouts
> >       usb: xhci: Fix DMA address calculation in queue_trb
> >       usb: xhci: Add more debugging
> >
> >  drivers/usb/host/xhci-ring.c | 100 +++++++++++++++++++++++++++++++++++=
--------
> >  drivers/usb/host/xhci.c      |   9 ++++
> >  include/usb/xhci.h           |   2 +
> >  3 files changed, 92 insertions(+), 19 deletions(-)
> > ---
> > base-commit: fb428b61819444b9337075f49c72f326f5d12085
> > change-id: 20231027-usb-fixes-1-83bfc7013012
> >
>
> The series looks reasonable and has worked quite well in Fedora Asahi.
>
> Reviewed-by: Neal Gompa <neal@gompa.dev>
>

Resending now that I'm subscribed to the U-Boot mailing list...

Reviewed-by: Neal Gompa <ngompa13@gmail.com>



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
