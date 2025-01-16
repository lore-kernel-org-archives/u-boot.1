Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B708C02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 09:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E53A80214;
	Thu, 16 Jan 2025 10:39:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VJCWcsVU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45B3980283; Thu, 16 Jan 2025 10:39:54 +0100 (CET)
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com
 [IPv6:2607:f8b0:4864:20::a2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70B56801B0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 10:39:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-5187f0b893dso153084e0c.3
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 01:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737020390; x=1737625190; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ifyO5zrHS/1s6D2+ByZ8SXjWp/HRHRVhATOv66Nw1TU=;
 b=VJCWcsVUEIwhtLwlOY/IoAy6nZzlBRha/v4hD5fyha7ejsgLXmecnzfDJnwP6MQoJ9
 WZbdq2fmDdVlL1sJq8ZxscoglshK84ZqBpWyueiz9v+/baciLu3kJp/K1r/TY86YtNpo
 a4AwLP1i2L0RfaTk04aN1urC4gY/b4P9PweQDA/YLJnuY6vhwdIGKWHZpw+K22S3DyrZ
 V7kpgLl//wIAdPaApksoF+OuYlt6m9J2y1r0hstRwHeEwsQSf+Q8f8C8tXmkjGx1QzGD
 jKbU72Th69iQ9z725NrUtJG0iQUlTqEUJQjFVYhlK7Ds9Vowakvm5z3kS5tnahdV02zl
 Fe+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737020390; x=1737625190;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ifyO5zrHS/1s6D2+ByZ8SXjWp/HRHRVhATOv66Nw1TU=;
 b=ssMK2j997etB73znEZZxcfo6JUjYYhwjeG6SzepPHmQQoFVckRdeNKql4fXN4N7gwr
 igUwWyI4S66RtK+sKoKoO85A8Kj36Pw3CtWr6GbVdqfv3WlDwdv4htdLzynrlS5T6jcn
 OHWePjztxXK7UuPswXH+pfBb5qNuwRQGLQMpFb/vbXayG9PCvlb9vJrkRW655As4MWvW
 MUo5FAotPL86ECJVeRsLGgzG+LFyNn+tDYGEUMgNp6UsKUtmPWttdg+sL6GENhmjWKNC
 GRejBQUkU4UJBYxU/x+WsZJS8Be24cTSOUuaaOPVCikR8l3ydbBP1Ja7HAedUGF4UKjL
 DfCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcYsGRzcxnY7PcnHYUhJd1jYTTo2yEh4xkgoWcQL4BJdvpA59Zl4fFGM6iasIkRwjq0e5jFso=@lists.denx.de
X-Gm-Message-State: AOJu0YwoacPNyaeYW1a6b45DzzC9CP27vw/nShRzQp/Aa+5bpaSF9HTZ
 Qdi3d1L3eORfnSE3tcpBks2cp0RXw8/X+jvXwFXK9+CD7uSS7ylCVMswD4fUwJJ1o1TF/RtdTZG
 +kl6rCUCHBZxcnV3LHJAYYJPkhouZeqpjutCGeA==
X-Gm-Gg: ASbGncum4Z2puX2DGSub/9Ab0ZepGT8LeXlTvWqzu039aNhZC1EEjP+oCDrnApIoT7R
 mf0gcDkGC/qr9wl2V9d5TP7WjsJScNMLRmGvGe0Q=
X-Google-Smtp-Source: AGHT+IFarlhLGnGDG1kVXTxN0DyWyOcv7wDb/fdNe1uIz9XcKQOUMJjvuEbrs3WJnDOSKtKFV1k/OUP7zlqyGKptgCU=
X-Received: by 2002:a05:6122:510:b0:515:daa7:ed07 with SMTP id
 71dfb90a1353d-51c6c1cd3dcmr25212132e0c.0.1737020390176; Thu, 16 Jan 2025
 01:39:50 -0800 (PST)
MIME-Version: 1.0
References: <20241217204835.3312765-1-j-humphreys@ti.com>
 <87ed25w4xm.fsf@baylibre.com>
 <86frmk4mhd.fsf@udb0321960.dhcp.ti.com> <87tt9z889e.fsf@baylibre.com>
In-Reply-To: <87tt9z889e.fsf@baylibre.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 16 Jan 2025 15:09:39 +0530
X-Gm-Features: AbW1kvZPLbmmAX7BN6U4nJb0KIp-yY69gMCsDLSyPTbDcL0hsmlWNIt-3zLXfUs
Message-ID: <CADg8p94zxnHuFH=hJDkxZm=_DOGOtYusM=twRQLRteYUy-CR3Q@mail.gmail.com>
Subject: Re: [PATCH] dfu: Prevent set_dfu_alt_info() from overwriting a
 previous value
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Jon Humphreys <j-humphreys@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, s-vadapalli@ti.com, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
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

On Thu, 16 Jan 2025 at 14:07, Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> Hi Jon,
>
> Sorry for the (very) late reply. I had some long holidays in between and
> since this is a difficult topic for me, I kept pushing this to the end
> of my backlog.
>
> On mer., d=C3=A9c. 18, 2024 at 17:09, Jon Humphreys <j-humphreys@ti.com> =
wrote:
>
> > Mattijs Korpershoek <mkorpershoek@baylibre.com> writes:
> >
> >> Hi Jonathan,
> >>
> >> Thank you for the patch.
> >>
> >> On mar., d=C3=A9c. 17, 2024 at 14:48, Jonathan Humphreys <j-humphreys@=
ti.com> wrote:
> >>
> >>> If CONFIG_SET_DFU_ALT_INFO is enabled, the dfu_alt_info environment
> >>> variable is dynamically set when initializing the DFU entities, which=
 is
> >>> done as part of normal flow of a DFU operation.
> >>>
> >>> The USB DFU boot support will set it's own specific value for dfu_alt=
_info
> >>> before performing the DFU operation. This means that if
> >>> CONFIG_SET_DFU_ALT_INFO is enabled, the dfu_alt_info environment vari=
able
> >>> that the USB DFU boot path had set is overwritten, causing USB DFU bo=
ot to
> >>> fail.
> >>>
> >>> Likewise, if the user sets their own value for dfu_alt_info, say at t=
he
> >>> U-Boot prompt, it get's overwritten if CONFIG_SET_DFU_ALT_INFO is ena=
bled.
> >>>
> >>> This patch will first check that dfu_alt_info isn't already set befor=
e
> >>> calling set_dfu_alt_info(), when CONFIG_SET_DFU_ALT_INFO is enabled.
> >>
> >> To me, this is a policy change: before we could override the environme=
nt
> >> via set_dfu_alt_info(). Now we cannot anymore (if "dfu_alt_info" is al=
ready
> >> set in the environment).
> >>
> >> Also, it seems that this change goes against the uefi doc which states=
:
> >>
> >> """
> >> A string is defined which is to be used for populating the
> >> dfu_alt_info variable. This string is used by the function
> >> set_dfu_alt_info. Instead of taking the variable from the environment,
> >> the capsule update feature requires that the variable be set through
> >> the function, since that is more robust. Allowing the user to change
> >> the location of the firmware updates is not a very secure
> >> practice. Getting this information from the firmware itself is more
> >> secure, assuming the firmware has been verified by a previous stage
> >> boot loader.
> >> """
> >>
> >> See: https://docs.u-boot.org/en/latest/develop/uefi/uefi.html#performi=
ng-the-update
> >>
> >> Moreover, looking at various boards that implement
> >> set_dfu_alt_info(), we can see different behaviours:
> >>
> >> Boards examples that won't override "dfu_alt_info" via
> >> set_dfu_alt_info() if "dfu_alt_info" is already set via environment
> >>
> >> * board/xilinx/zynq/board.c
> >> * board/emulation/common/qemu_dfu.c
> >>
> >> Boards examplesthat will always override the "dfu_alt_info" via
> >> set_dfu_alt_info():
> >>
> >> * board/libre-computer/aml-a311d-cc/aml-a311d-cc.c
> >> * board/ti/am62px/evm.c
> >>
> >> Since set_dfu_alt_info() is a board specific callback, why can't this
> >> logic be implemented for boards that want this behaviour change?
> >
> > Because I would then need to duplicate the same logic for every board t=
hat
> > wanted both USB DFU boot and EFI capsules to work.  And the paramters
> > passed in do not allow the function to know the use case (am I DFU boot=
ing
> > or updating EFI capsules?).  See more below.
>
> I understand that duplicating logic for every board you maintain is not
> optimal, however, it gives each vendor the freedom of implementing their
> policy.
>
> I've added a couple of folks who I think could help giving their opinion =
on EFI capsules/policy.
>
> Heinrich, Ilias, Sugosh, do you have any opinion on this patch?
>
> >
> >>
> >> Regards,
> >>
> >> Mattijs
> >>
> >>>
> >>> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> >>> ---
> >>>  drivers/dfu/dfu.c | 7 +++++--
> >>>  1 file changed, 5 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/dfu/dfu.c b/drivers/dfu/dfu.c
> >>> index 756569217bb..ab8abae1d89 100644
> >>> --- a/drivers/dfu/dfu.c
> >>> +++ b/drivers/dfu/dfu.c
> >>> @@ -169,10 +169,13 @@ int dfu_init_env_entities(char *interface, char=
 *devstr)
> >>>     dfu_reinit_needed =3D false;
> >>>     dfu_alt_info_changed =3D false;
> >>>
> >>> +   str_env =3D env_get("dfu_alt_info");
> >>>  #ifdef CONFIG_SET_DFU_ALT_INFO
> >>> -   set_dfu_alt_info(interface, devstr);
> >>> +   if (!str_env) {
> >>> +           set_dfu_alt_info(interface, devstr);
> >>> +           str_env =3D env_get("dfu_alt_info");
> >>> +   }
> >>>  #endif
> >>> -   str_env =3D env_get("dfu_alt_info");
> >>>     if (!str_env) {
> >>>             pr_err("\"dfu_alt_info\" env variable not defined!\n");
> >>>             return -EINVAL;
> >>> --
> >>> 2.34.1
> >
> > Mattijs, thanks for the thorough reply.  I did wrestle a lot with how w=
ide
> > of a fix to propose for this problem, and in the end, decided on the na=
rrow
> > fix of simply preventing the overwriting of the variable.
> >
> > Yes it is a policy change, but the policy is already unclear, inconsist=
ent,
> > and confusing, IMO.
> >
> > For example:
> > 1) EFI capsule update wants to very strictly control the dfu alt values
> >    by setting it in set_dfu_alt_info(), but then any other DFU use
> >    case breaks.  USB DFU boot is now broken.
> > 2) The behavior the user sees wrt the dfu_alt_info env variable is very
> >    confusing and non-intuitive. Take this example:
> >
> > =3D> env set dfu_alt_info "sf 0:0=3Dexe1.bin raw 0 88000;exe2.bin raw 8=
8000 100000"
> > =3D> env print dfu_alt_info
> > dfu_alt_info=3Dsf 0:0=3Dexe1.bin raw 0 88000;exe2.bin raw 88000 100000
> > =3D> dfu 0 list
> > DFU alt settings list:
> > dev: SF alt: 0 name: tiboot3.bin layout: RAW_ADDR
> > dev: SF alt: 1 name: tispl.bin layout: RAW_ADDR
> > dev: SF alt: 2 name: u-boot.img layout: RAW_ADDR
> > =3D> env print dfu_alt_info
> > dfu_alt_info=3Dsf 0:0=3Dtiboot3.bin raw 0 80000;tispl.bin raw 80000 200=
000;u-boot.img raw 280000 400000
> > =3D>
> >
> > As you can see, the user set's the dfu_alt_info variable according to t=
heir
> > specific use case, then simply tries to list the DFU alt settings, and
> > because this code goes through the dfu_init_env_entities() path, it get=
s
> > changed to the EFI capsule settings.
> >
> > I was hoping to get a simpler fix in now so we can get USB DFU boot wor=
king
> > again, and we can visit the overall policy design next.  As you suggest=
, I
> > could also push the testing of overwriting into the board specific
> > set_dfu_alt_info() function, but then I need to duplicate the code in 8
> > different places for the TI boards, and other vendors may still have th=
e
> > problem.
>
> I agree that the above behaviour is confusing and I'm reconsidering to
> take up this patch. I'd like some buy-in from either Heinrich, Ilias or
> Sughosh on this since I'm not 100% confortable with the "policy change"

A little context here. The DFU driver already had this policy in place
where, if the CONFIG_SET_DFU_ALT_INFO was set, the dfu_alt_info string
would be set by U-Boot, instead of taking the user provided string. It
was decided to use this for EFI capsule updates, as getting the string
which determines the location of writing the update images from within
U-Boot is more resilient than taking some user provided string.


>
> >
> > Looking to the longer term solution, here are my thoughts.
> > 1) We need to decouple CONFIG_SET_DFU_ALT_INFO from EFI capsules.  The =
only
> >    reason TI boards are now setting CONFIG_SET_DFU_ALT_INFO is because =
EFI
> >    capsule update is enabled.  Outside of a few legacy uses (I think - =
it
> >    appears they were introduced prior to supporting multi-interface dfu=
 alt
> >    strings), I think this is true for other vendor's boards as well.
> > 2) Have EFI capsule support do as USB DFU boot does today, and set the
> >    dfu alt string it wants used *before* initiating the DFU operation. =
 With
> >    CONFIG_SET_DFU_ALT_INFO no longer enabled, the value it set will not=
 get
> >    overridden.
> > 3) Have the actual value of the dfu alt string used in the DFU operatio=
n be
> >    passed in, rather than read from the dfu_alt_info environment variab=
le.
> >    The USB DFU and EFI capsule use case will pass in the dfu alt string
> >    they want. The standard 'dfu' command can pass in the value of the
> >    dfu_alt_info env variable. Note that this effectively decouples the =
dfu
> >    command from the alt settings that USB DFU boot and EFI capsules use=
,
> >    but I think this is what we want.

I think either of 2) or 3) above can be looked at. Although not sure
if 2) will be breaking the current DFU policy.

-sughosh

> >
> > This then allows both USB DFU boot and EFI capsule use cases to work as
> > intended and allows the dfu command to operate on the user defined
> > dfu_alt_info value.
> >
> > I welcome comments from those that have the history and intended behavi=
or
> > background of the DFU support :).
>
> I do as well. I have taken over maintaince on this subsystem a year ago
> and have not had much patches/work done on the subsystem. Therefore I'm
> not as knowledgeable as I would have liked to be. I'm sorry about that.
>
> >
> > I also welcome comments on how to proceed for 2025.01. Should we live w=
ith
> > USB DFU boot broken until we get the long term fix in, or ok with the p=
atch
> > posted here. The patch posted here does allow for a user to change EFI
> > capsule's dfu alt settings, as Mattijs says, but especially given capsu=
les
> > can be authenticated, I'm not sure how this would be exploited, and if =
that
> > risk is worse that broken DFU boot.
> >
> > thank
> > Jon
