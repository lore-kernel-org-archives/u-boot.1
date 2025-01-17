Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D6CC02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 10:48:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40F3E8036F;
	Fri, 17 Jan 2025 11:48:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Gy+N3+Cy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73826806D8; Fri, 17 Jan 2025 11:48:06 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82FDE80312
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 11:48:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e3983426f80so3036118276.1
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 02:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737110882; x=1737715682; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qx0P9NC/kphNC1LadexqnQ/dV1oRr5dEslG6JljMDBI=;
 b=Gy+N3+CyrdG9OlojcK5rkEzjic+v2X1ItsTlZQOMEJCFreo2Lv/Af4lBrf6EKOkeqk
 LClv4JhidobO/eS/3TeQ8LdDnn2pQxcBwF7N9Kv0mrHjRbc2nK7Hhyy89WXc5sO/th7w
 wlz/94k1UBc2GEz/lOAVWxhVYkFNj9qJ2fPg5cbZUHeifBSCYmbufTBhO0KpOiLD5+WO
 HqwotT4qUCy5LrKKn9ixuKAUQ5sh3vkKojQbJnDfk5E9/IPQqI+oXm9g/9MK5+U/+tb1
 0I2maCrstKOdJNIsqZBIMhUZP9H3kKrX9b61gT5NZkxB5S41pJ/Vo+sXuzTlDhp++QaF
 Ax3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737110882; x=1737715682;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qx0P9NC/kphNC1LadexqnQ/dV1oRr5dEslG6JljMDBI=;
 b=ARMJvB3igSVJmHCc6N14/T/B2YsmocOYzPpGdqR38XJKc0Ya1fEVh7BlTkokAIISF5
 Pl7rvEXjkE+Y1AsO/kg/MgKHwZBWprp7rOdd3W4kmY5juG4AAWMCLCVceCsXBp71aI+D
 ZBMCt6UOd/8emnH5iW6fiNBR+dfN0sM+1sSj8TXn7jLimDDRdykmyYPtrmqWqSYeGkkU
 5zenyQHzUKR+0OAgNPBxQQei/fxEp3EKFaHZsf1+bMT2JR70ie3+uy1876eEwPoTYT0z
 S/txlzDXRcxn08ZZVftIgilyNxfszqyZnWCMvyeTrjj/tlixtd9cmFyF8UOLiz60ZUiQ
 itaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVhvoideJcSXb2FZze/+yxoTFrtkyIsZTYyoBjJfmIjbwumD0xHCWF2oO+Sj8txyAklHiQ+VU=@lists.denx.de
X-Gm-Message-State: AOJu0YxNMFUEAFchbBia7avaNN6gRkvH+UiGZWzPO0F3BK0ETHUpG7Ew
 Wtcb/7C/AFT3CJgxeO5f/IszVdUt8Y49tAXf/+idDZxvemrP6e+9BalBP8t7DdSbYqG+WatLzKG
 KXTELiNNGWBM/nvztgDy5+pzlX8EOATnTSwmcFQ==
X-Gm-Gg: ASbGncsEaV6uiyxRekmhXzVTWswnonmxrHIvHSg4e+5h2L7QrI2EqPgEwKbAwEybdzs
 wFhkiY5s2P4M2lAfZNSjuQSDugiBNCpUA5gepig==
X-Google-Smtp-Source: AGHT+IHfPm2lQ68665WuWTi6K59vNjzuL6z/pgR8kDQn3BaVX+VXoyftO52V5tGPD9jDMgkO+3vrJcAuyRA6SWxKwb4=
X-Received: by 2002:a05:690c:3683:b0:6f6:c9c6:9537 with SMTP id
 00721157ae682-6f6eb9379efmr13906137b3.33.1737110882265; Fri, 17 Jan 2025
 02:48:02 -0800 (PST)
MIME-Version: 1.0
References: <20241217204835.3312765-1-j-humphreys@ti.com>
 <87ed25w4xm.fsf@baylibre.com>
 <86frmk4mhd.fsf@udb0321960.dhcp.ti.com> <87tt9z889e.fsf@baylibre.com>
 <CADg8p94zxnHuFH=hJDkxZm=_DOGOtYusM=twRQLRteYUy-CR3Q@mail.gmail.com>
 <86a5bqpgcs.fsf@udb0321960.dhcp.ti.com>
In-Reply-To: <86a5bqpgcs.fsf@udb0321960.dhcp.ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 17 Jan 2025 12:47:26 +0200
X-Gm-Features: AbW1kvYw3GK7IHxkk8O0L3jnyjB4uT9lliJy2rVw57i5jhQ2CxL8P4IKXhhlW9c
Message-ID: <CAC_iWj+94Vi1v3XL2HTtJtj56JiGJkC2BN2T3mxOHG+MS586sQ@mail.gmail.com>
Subject: Re: [PATCH] dfu: Prevent set_dfu_alt_info() from overwriting a
 previous value
To: Jon Humphreys <j-humphreys@ti.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, s-vadapalli@ti.com, 
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

Hi Jon,

On Fri, 17 Jan 2025 at 00:02, Jon Humphreys <j-humphreys@ti.com> wrote:
>
> Sughosh Ganu <sughosh.ganu@linaro.org> writes:
>
> > On Thu, 16 Jan 2025 at 14:07, Mattijs Korpershoek
> > <mkorpershoek@baylibre.com> wrote:
> >>
> >> Hi Jon,
> >>
> >> Sorry for the (very) late reply. I had some long holidays in between a=
nd
> >> since this is a difficult topic for me, I kept pushing this to the end
> >> of my backlog.
> >>
> >> On mer., d=C3=A9c. 18, 2024 at 17:09, Jon Humphreys <j-humphreys@ti.co=
m> wrote:
> >>
> >> > Mattijs Korpershoek <mkorpershoek@baylibre.com> writes:
> >> >
> >> >> Hi Jonathan,
> >> >>
> >> >> Thank you for the patch.
> >> >>
> >> >> On mar., d=C3=A9c. 17, 2024 at 14:48, Jonathan Humphreys <j-humphre=
ys@ti.com> wrote:
> >> >>
> >> >>> If CONFIG_SET_DFU_ALT_INFO is enabled, the dfu_alt_info environmen=
t
> >> >>> variable is dynamically set when initializing the DFU entities, wh=
ich is
> >> >>> done as part of normal flow of a DFU operation.
> >> >>>
> >> >>> The USB DFU boot support will set it's own specific value for dfu_=
alt_info
> >> >>> before performing the DFU operation. This means that if
> >> >>> CONFIG_SET_DFU_ALT_INFO is enabled, the dfu_alt_info environment v=
ariable
> >> >>> that the USB DFU boot path had set is overwritten, causing USB DFU=
 boot to
> >> >>> fail.
> >> >>>
> >> >>> Likewise, if the user sets their own value for dfu_alt_info, say a=
t the
> >> >>> U-Boot prompt, it get's overwritten if CONFIG_SET_DFU_ALT_INFO is =
enabled.
> >> >>>
> >> >>> This patch will first check that dfu_alt_info isn't already set be=
fore
> >> >>> calling set_dfu_alt_info(), when CONFIG_SET_DFU_ALT_INFO is enable=
d.
> >> >>
> >> >> To me, this is a policy change: before we could override the enviro=
nment
> >> >> via set_dfu_alt_info(). Now we cannot anymore (if "dfu_alt_info" is=
 already
> >> >> set in the environment).
> >> >>
> >> >> Also, it seems that this change goes against the uefi doc which sta=
tes:
> >> >>
> >> >> """
> >> >> A string is defined which is to be used for populating the
> >> >> dfu_alt_info variable. This string is used by the function
> >> >> set_dfu_alt_info. Instead of taking the variable from the environme=
nt,
> >> >> the capsule update feature requires that the variable be set throug=
h
> >> >> the function, since that is more robust. Allowing the user to chang=
e
> >> >> the location of the firmware updates is not a very secure
> >> >> practice. Getting this information from the firmware itself is more
> >> >> secure, assuming the firmware has been verified by a previous stage
> >> >> boot loader.
> >> >> """
> >> >>
> >> >> See: https://docs.u-boot.org/en/latest/develop/uefi/uefi.html#perfo=
rming-the-update
> >> >>
> >> >> Moreover, looking at various boards that implement
> >> >> set_dfu_alt_info(), we can see different behaviours:
> >> >>
> >> >> Boards examples that won't override "dfu_alt_info" via
> >> >> set_dfu_alt_info() if "dfu_alt_info" is already set via environment
> >> >>
> >> >> * board/xilinx/zynq/board.c
> >> >> * board/emulation/common/qemu_dfu.c
> >> >>
> >> >> Boards examplesthat will always override the "dfu_alt_info" via
> >> >> set_dfu_alt_info():
> >> >>
> >> >> * board/libre-computer/aml-a311d-cc/aml-a311d-cc.c
> >> >> * board/ti/am62px/evm.c
> >> >>
> >> >> Since set_dfu_alt_info() is a board specific callback, why can't th=
is
> >> >> logic be implemented for boards that want this behaviour change?
> >> >
> >> > Because I would then need to duplicate the same logic for every boar=
d that
> >> > wanted both USB DFU boot and EFI capsules to work.  And the paramter=
s
> >> > passed in do not allow the function to know the use case (am I DFU b=
ooting
> >> > or updating EFI capsules?).  See more below.
> >>
> >> I understand that duplicating logic for every board you maintain is no=
t
> >> optimal, however, it gives each vendor the freedom of implementing the=
ir
> >> policy.
> >>
> >> I've added a couple of folks who I think could help giving their opini=
on on EFI capsules/policy.
> >>
> >> Heinrich, Ilias, Sugosh, do you have any opinion on this patch?
> >>
> >> >
> >> >>
> >> >> Regards,
> >> >>
> >> >> Mattijs
> >> >>
> >> >>>
> >> >>> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> >> >>> ---
> >> >>>  drivers/dfu/dfu.c | 7 +++++--
> >> >>>  1 file changed, 5 insertions(+), 2 deletions(-)
> >> >>>
> >> >>> diff --git a/drivers/dfu/dfu.c b/drivers/dfu/dfu.c
> >> >>> index 756569217bb..ab8abae1d89 100644
> >> >>> --- a/drivers/dfu/dfu.c
> >> >>> +++ b/drivers/dfu/dfu.c
> >> >>> @@ -169,10 +169,13 @@ int dfu_init_env_entities(char *interface, c=
har *devstr)
> >> >>>     dfu_reinit_needed =3D false;
> >> >>>     dfu_alt_info_changed =3D false;
> >> >>>
> >> >>> +   str_env =3D env_get("dfu_alt_info");
> >> >>>  #ifdef CONFIG_SET_DFU_ALT_INFO
> >> >>> -   set_dfu_alt_info(interface, devstr);
> >> >>> +   if (!str_env) {
> >> >>> +           set_dfu_alt_info(interface, devstr);
> >> >>> +           str_env =3D env_get("dfu_alt_info");
> >> >>> +   }
> >> >>>  #endif
> >> >>> -   str_env =3D env_get("dfu_alt_info");
> >> >>>     if (!str_env) {
> >> >>>             pr_err("\"dfu_alt_info\" env variable not defined!\n")=
;
> >> >>>             return -EINVAL;
> >> >>> --
> >> >>> 2.34.1
> >> >
> >> > Mattijs, thanks for the thorough reply.  I did wrestle a lot with ho=
w wide
> >> > of a fix to propose for this problem, and in the end, decided on the=
 narrow
> >> > fix of simply preventing the overwriting of the variable.
> >> >
> >> > Yes it is a policy change, but the policy is already unclear, incons=
istent,
> >> > and confusing, IMO.
> >> >
> >> > For example:
> >> > 1) EFI capsule update wants to very strictly control the dfu alt val=
ues
> >> >    by setting it in set_dfu_alt_info(), but then any other DFU use
> >> >    case breaks.  USB DFU boot is now broken.
> >> > 2) The behavior the user sees wrt the dfu_alt_info env variable is v=
ery
> >> >    confusing and non-intuitive. Take this example:
> >> >
> >> > =3D> env set dfu_alt_info "sf 0:0=3Dexe1.bin raw 0 88000;exe2.bin ra=
w 88000 100000"
> >> > =3D> env print dfu_alt_info
> >> > dfu_alt_info=3Dsf 0:0=3Dexe1.bin raw 0 88000;exe2.bin raw 88000 1000=
00
> >> > =3D> dfu 0 list
> >> > DFU alt settings list:
> >> > dev: SF alt: 0 name: tiboot3.bin layout: RAW_ADDR
> >> > dev: SF alt: 1 name: tispl.bin layout: RAW_ADDR
> >> > dev: SF alt: 2 name: u-boot.img layout: RAW_ADDR
> >> > =3D> env print dfu_alt_info
> >> > dfu_alt_info=3Dsf 0:0=3Dtiboot3.bin raw 0 80000;tispl.bin raw 80000 =
200000;u-boot.img raw 280000 400000
> >> > =3D>
> >> >
> >> > As you can see, the user set's the dfu_alt_info variable according t=
o their
> >> > specific use case, then simply tries to list the DFU alt settings, a=
nd
> >> > because this code goes through the dfu_init_env_entities() path, it =
gets
> >> > changed to the EFI capsule settings.
> >> >
> >> > I was hoping to get a simpler fix in now so we can get USB DFU boot =
working
> >> > again, and we can visit the overall policy design next.  As you sugg=
est, I
> >> > could also push the testing of overwriting into the board specific
> >> > set_dfu_alt_info() function, but then I need to duplicate the code i=
n 8
> >> > different places for the TI boards, and other vendors may still have=
 the
> >> > problem.
> >>
> >> I agree that the above behaviour is confusing and I'm reconsidering to
> >> take up this patch. I'd like some buy-in from either Heinrich, Ilias o=
r
> >> Sughosh on this since I'm not 100% confortable with the "policy change=
"
> >
> > A little context here. The DFU driver already had this policy in place
> > where, if the CONFIG_SET_DFU_ALT_INFO was set, the dfu_alt_info string
> > would be set by U-Boot, instead of taking the user provided string. It
> > was decided to use this for EFI capsule updates, as getting the string
> > which determines the location of writing the update images from within
> > U-Boot is more resilient than taking some user provided string.
> >
> >
> >>
> >> >
> >> > Looking to the longer term solution, here are my thoughts.
> >> > 1) We need to decouple CONFIG_SET_DFU_ALT_INFO from EFI capsules.  T=
he only
> >> >    reason TI boards are now setting CONFIG_SET_DFU_ALT_INFO is becau=
se EFI
> >> >    capsule update is enabled.  Outside of a few legacy uses (I think=
 - it
> >> >    appears they were introduced prior to supporting multi-interface =
dfu alt
> >> >    strings), I think this is true for other vendor's boards as well.
> >> > 2) Have EFI capsule support do as USB DFU boot does today, and set t=
he
> >> >    dfu alt string it wants used *before* initiating the DFU operatio=
n.  With
> >> >    CONFIG_SET_DFU_ALT_INFO no longer enabled, the value it set will =
not get
> >> >    overridden.
> >> > 3) Have the actual value of the dfu alt string used in the DFU opera=
tion be
> >> >    passed in, rather than read from the dfu_alt_info environment var=
iable.
> >> >    The USB DFU and EFI capsule use case will pass in the dfu alt str=
ing
> >> >    they want. The standard 'dfu' command can pass in the value of th=
e
> >> >    dfu_alt_info env variable. Note that this effectively decouples t=
he dfu
> >> >    command from the alt settings that USB DFU boot and EFI capsules =
use,
> >> >    but I think this is what we want.
> >
> > I think either of 2) or 3) above can be looked at. Although not sure
> > if 2) will be breaking the current DFU policy.
> >
> > -sughosh
> >
>
> Thanks for the comments.  I have looked into this a bit further and see 2
> options we can take for the EFI capsule update use case:
>
> 1) stick with the more traditional approach and do as DFU BOOT does by
>    setting the value of the dfu_alt_info env variable just before
>    initiating the DFU operation. As Ilias sugggested, we could also add a
>    save/restore so this is transparent to other DFU users.
>
> 2) move to a model where we explicitly pass in to the DFU operation the
>    value of dfu_alt_info that we want used. In the normal/legacy DFU use
>    cases, this would involve calling env_get() for the dfu_alt_info env
>    variable and pass that value. I like this approach because it is
>    cleaner and more explicit. However, there are many layers of function
>    calls between the driver of the DFU operation (the one that would deci=
de
>    what dfu_alt_info value to use) and dfu_init_env_entities() where it i=
s
>    used, and passing this info across the function interfaces would
>    involved lots of function interface updates.
>
> I'm curious if there is apetite for 2) or should we go with the more
> traditional approach in 1).
>
> The above assumes we decouple CONFIG_SET_DFU_ALT_INFO from EFI capsules.
> For platforms still setting CONFIG_SET_DFU_ALT_INFO, the presumption is t=
hat
> if they override the dfu_alt_info env variable, they know what they are
> doing.

Decoupling that should be pretty easy. I personally like 2) more since
it's much more scalable and doesn't involve saving.restoring values.
But I am not sure how big of a task it is

Cheers
/Ilias
>
> Thanks
> Jon
>
> >> >
> >> > This then allows both USB DFU boot and EFI capsule use cases to work=
 as
> >> > intended and allows the dfu command to operate on the user defined
> >> > dfu_alt_info value.
> >> >
> >> > I welcome comments from those that have the history and intended beh=
avior
> >> > background of the DFU support :).
> >>
> >> I do as well. I have taken over maintaince on this subsystem a year ag=
o
> >> and have not had much patches/work done on the subsystem. Therefore I'=
m
> >> not as knowledgeable as I would have liked to be. I'm sorry about that=
.
> >>
> >> >
> >> > I also welcome comments on how to proceed for 2025.01. Should we liv=
e with
> >> > USB DFU boot broken until we get the long term fix in, or ok with th=
e patch
> >> > posted here. The patch posted here does allow for a user to change E=
FI
> >> > capsule's dfu alt settings, as Mattijs says, but especially given ca=
psules
> >> > can be authenticated, I'm not sure how this would be exploited, and =
if that
> >> > risk is worse that broken DFU boot.
> >> >
> >> > thank
> >> > Jon
