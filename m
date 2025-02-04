Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF7AC02194
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 12:58:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4183F800B3;
	Tue,  4 Feb 2025 13:58:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uu634+Lu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20C9B801BE; Tue,  4 Feb 2025 13:58:26 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44D3080040
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 13:58:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e549b0f8d57so5228285276.3
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 04:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738673902; x=1739278702; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lywvOEhrg1chFKEp6YyPymeppRQxROz6yWjX9mcECW8=;
 b=uu634+LuYYBCxc/8YpoTb5ClalXzXuYilPPKPhpZb+jqTSvD97bBbYfQZXK+1axQ4J
 4eSuBC9md5Zt0dWWfaj9Z66PTin4JtsGINHjr8fTc0YfKDSM3y3PlqBPbeePrB9yWl9k
 xQjvLiCrCJArtOWKI9ZNNeqAgAwDJW2I+XXPoPGIzoAy7aLQWeSCQ1+tQqzqIegwv3xs
 GgoU4ErGVXFWuRetgGmylQ9kdsvmJ2SbYkMf9eWNObIBc+veSKoYGlEMJTkB0Tei3J0k
 kfvMB9vMAZJrYmh34cFNdRiUAbJDHEBKK2Q+TAxdyEDweWYVZxmF8o1sx/+n3QAEUsB3
 bS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738673902; x=1739278702;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lywvOEhrg1chFKEp6YyPymeppRQxROz6yWjX9mcECW8=;
 b=Zo3jLld6KagqA/x0iNdWxZyS0ibceUT2joeU1HOC/rGbyLWeYmKA/VQVFWpySAOleQ
 iC1h5RWbkiTTCsSbvH9vpC2xJJVmzIETO6SCEBWlHmZL8PhPKtp8ukxZL1sliJtMHENc
 aaiiQXwGfoM+w4jAr5cj4TFDUxHpOOBM6gtyNdWkKHHYOBp61+AV56nSpiwYo+7lP9Fv
 EDKsoChK3dhAf2uiEnEKE92DO0z2QKU6L+U24Z0pP8VaPNguoRZpi4gBZ4Mjv9J2fBt3
 ILIG0QCUsq5h9Nj5cEe0i8wCtjCfx3gGOIVVqN2czm45xvKyyDyvwEC966+HhH7tiW/t
 DSRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYIx9Wd60NIzh/HK/nTZvMvZYKAjPw0YUPe64rUGSzNmDHjZIwYMSJt/ZUgFVi6Cl2EhWyxYg=@lists.denx.de
X-Gm-Message-State: AOJu0YxUOWVEA+uacxEpd4fPDYeGJTQByslh+n+txUkWWe1Z9VnAjLIC
 uIf/ZnXlcm+o+vVGRvZxe1FbKmTW0188fvF8DVb2pzhgF5csZ/c0RRSt3ibYBrWLYjEX2vGx84s
 9DT/YnO3fhevtm75q6pmXIxzPvuBX9FD8jzjJPQ==
X-Gm-Gg: ASbGncstB6nh4aAWfw5uL/ruEFIgcBdfCbexTT829kE0mviGL8tF1PDldKa/1LCFfKd
 osbT4cQpKY7+HqkqJddReGWZ+X3B7Gx+hEwGx+P5R4vv4cbqMBMjsyIF9RWfXIbBOYdunBZDJ
X-Google-Smtp-Source: AGHT+IFOu5qM8S0KOFBIbtXu1joAGmXepRRr73l6Q3g4qJtILr/n0fjYNjWf8XYvn+FXDaOC+Zf4yRmOLAqdgAFyzjc=
X-Received: by 2002:a05:6902:178c:b0:e38:b34d:121f with SMTP id
 3f1490d57ef6-e58a4ad726bmr17905136276.15.1738673901996; Tue, 04 Feb 2025
 04:58:21 -0800 (PST)
MIME-Version: 1.0
References: <20241217204835.3312765-1-j-humphreys@ti.com>
 <87ed25w4xm.fsf@baylibre.com>
 <86frmk4mhd.fsf@udb0321960.dhcp.ti.com> <87tt9z889e.fsf@baylibre.com>
 <CADg8p94zxnHuFH=hJDkxZm=_DOGOtYusM=twRQLRteYUy-CR3Q@mail.gmail.com>
 <86a5bqpgcs.fsf@udb0321960.dhcp.ti.com>
 <CAC_iWj+94Vi1v3XL2HTtJtj56JiGJkC2BN2T3mxOHG+MS586sQ@mail.gmail.com>
 <864j1apv38.fsf@udb0321960.dhcp.ti.com>
In-Reply-To: <864j1apv38.fsf@udb0321960.dhcp.ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 4 Feb 2025 14:57:46 +0200
X-Gm-Features: AWEUYZkgnOY2xKdSLhC-ReWzQgiAYXJaQiL37s9AUAn-ICQ7k_tVks2rO8ux-Ik
Message-ID: <CAC_iWj+3v+WHp-CmAejcB+xq-DTEOw3Ku5qnZoGRjUJz-NJVhA@mail.gmail.com>
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

On Mon, 3 Feb 2025 at 23:38, Jon Humphreys <j-humphreys@ti.com> wrote:
>
> Ilias Apalodimas <ilias.apalodimas@linaro.org> writes:
>
> > Hi Jon,
> >
> > On Fri, 17 Jan 2025 at 00:02, Jon Humphreys <j-humphreys@ti.com> wrote:
> >>
> >> Sughosh Ganu <sughosh.ganu@linaro.org> writes:
> >>
> >> > On Thu, 16 Jan 2025 at 14:07, Mattijs Korpershoek
> >> > <mkorpershoek@baylibre.com> wrote:
> >> >>
> >> >> Hi Jon,
> >> >>
> >> >> Sorry for the (very) late reply. I had some long holidays in betwee=
n and
> >> >> since this is a difficult topic for me, I kept pushing this to the =
end
> >> >> of my backlog.
> >> >>
> >> >> On mer., d=C3=A9c. 18, 2024 at 17:09, Jon Humphreys <j-humphreys@ti=
.com> wrote:
> >> >>
> >> >> > Mattijs Korpershoek <mkorpershoek@baylibre.com> writes:
> >> >> >
> >> >> >> Hi Jonathan,
> >> >> >>
> >> >> >> Thank you for the patch.
> >> >> >>
> >> >> >> On mar., d=C3=A9c. 17, 2024 at 14:48, Jonathan Humphreys <j-hump=
hreys@ti.com> wrote:
> >> >> >>
> >> >> >>> If CONFIG_SET_DFU_ALT_INFO is enabled, the dfu_alt_info environ=
ment
> >> >> >>> variable is dynamically set when initializing the DFU entities,=
 which is
> >> >> >>> done as part of normal flow of a DFU operation.
> >> >> >>>
> >> >> >>> The USB DFU boot support will set it's own specific value for d=
fu_alt_info
> >> >> >>> before performing the DFU operation. This means that if
> >> >> >>> CONFIG_SET_DFU_ALT_INFO is enabled, the dfu_alt_info environmen=
t variable
> >> >> >>> that the USB DFU boot path had set is overwritten, causing USB =
DFU boot to
> >> >> >>> fail.
> >> >> >>>
> >> >> >>> Likewise, if the user sets their own value for dfu_alt_info, sa=
y at the
> >> >> >>> U-Boot prompt, it get's overwritten if CONFIG_SET_DFU_ALT_INFO =
is enabled.
> >> >> >>>
> >> >> >>> This patch will first check that dfu_alt_info isn't already set=
 before
> >> >> >>> calling set_dfu_alt_info(), when CONFIG_SET_DFU_ALT_INFO is ena=
bled.
> >> >> >>
> >> >> >> To me, this is a policy change: before we could override the env=
ironment
> >> >> >> via set_dfu_alt_info(). Now we cannot anymore (if "dfu_alt_info"=
 is already
> >> >> >> set in the environment).
> >> >> >>
> >> >> >> Also, it seems that this change goes against the uefi doc which =
states:
> >> >> >>
> >> >> >> """
> >> >> >> A string is defined which is to be used for populating the
> >> >> >> dfu_alt_info variable. This string is used by the function
> >> >> >> set_dfu_alt_info. Instead of taking the variable from the enviro=
nment,
> >> >> >> the capsule update feature requires that the variable be set thr=
ough
> >> >> >> the function, since that is more robust. Allowing the user to ch=
ange
> >> >> >> the location of the firmware updates is not a very secure
> >> >> >> practice. Getting this information from the firmware itself is m=
ore
> >> >> >> secure, assuming the firmware has been verified by a previous st=
age
> >> >> >> boot loader.
> >> >> >> """
> >> >> >>
> >> >> >> See: https://docs.u-boot.org/en/latest/develop/uefi/uefi.html#pe=
rforming-the-update
> >> >> >>
> >> >> >> Moreover, looking at various boards that implement
> >> >> >> set_dfu_alt_info(), we can see different behaviours:
> >> >> >>
> >> >> >> Boards examples that won't override "dfu_alt_info" via
> >> >> >> set_dfu_alt_info() if "dfu_alt_info" is already set via environm=
ent
> >> >> >>
> >> >> >> * board/xilinx/zynq/board.c
> >> >> >> * board/emulation/common/qemu_dfu.c
> >> >> >>
> >> >> >> Boards examplesthat will always override the "dfu_alt_info" via
> >> >> >> set_dfu_alt_info():
> >> >> >>
> >> >> >> * board/libre-computer/aml-a311d-cc/aml-a311d-cc.c
> >> >> >> * board/ti/am62px/evm.c
> >> >> >>
> >> >> >> Since set_dfu_alt_info() is a board specific callback, why can't=
 this
> >> >> >> logic be implemented for boards that want this behaviour change?
> >> >> >
> >> >> > Because I would then need to duplicate the same logic for every b=
oard that
> >> >> > wanted both USB DFU boot and EFI capsules to work.  And the param=
ters
> >> >> > passed in do not allow the function to know the use case (am I DF=
U booting
> >> >> > or updating EFI capsules?).  See more below.
> >> >>
> >> >> I understand that duplicating logic for every board you maintain is=
 not
> >> >> optimal, however, it gives each vendor the freedom of implementing =
their
> >> >> policy.
> >> >>
> >> >> I've added a couple of folks who I think could help giving their op=
inion on EFI capsules/policy.
> >> >>
> >> >> Heinrich, Ilias, Sugosh, do you have any opinion on this patch?
> >> >>
> >> >> >
> >> >> >>
> >> >> >> Regards,
> >> >> >>
> >> >> >> Mattijs
> >> >> >>
> >> >> >>>
> >> >> >>> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> >> >> >>> ---
> >> >> >>>  drivers/dfu/dfu.c | 7 +++++--
> >> >> >>>  1 file changed, 5 insertions(+), 2 deletions(-)
> >> >> >>>
> >> >> >>> diff --git a/drivers/dfu/dfu.c b/drivers/dfu/dfu.c
> >> >> >>> index 756569217bb..ab8abae1d89 100644
> >> >> >>> --- a/drivers/dfu/dfu.c
> >> >> >>> +++ b/drivers/dfu/dfu.c
> >> >> >>> @@ -169,10 +169,13 @@ int dfu_init_env_entities(char *interface=
, char *devstr)
> >> >> >>>     dfu_reinit_needed =3D false;
> >> >> >>>     dfu_alt_info_changed =3D false;
> >> >> >>>
> >> >> >>> +   str_env =3D env_get("dfu_alt_info");
> >> >> >>>  #ifdef CONFIG_SET_DFU_ALT_INFO
> >> >> >>> -   set_dfu_alt_info(interface, devstr);
> >> >> >>> +   if (!str_env) {
> >> >> >>> +           set_dfu_alt_info(interface, devstr);
> >> >> >>> +           str_env =3D env_get("dfu_alt_info");
> >> >> >>> +   }
> >> >> >>>  #endif
> >> >> >>> -   str_env =3D env_get("dfu_alt_info");
> >> >> >>>     if (!str_env) {
> >> >> >>>             pr_err("\"dfu_alt_info\" env variable not defined!\=
n");
> >> >> >>>             return -EINVAL;
> >> >> >>> --
> >> >> >>> 2.34.1
> >> >> >
> >> >> > Mattijs, thanks for the thorough reply.  I did wrestle a lot with=
 how wide
> >> >> > of a fix to propose for this problem, and in the end, decided on =
the narrow
> >> >> > fix of simply preventing the overwriting of the variable.
> >> >> >
> >> >> > Yes it is a policy change, but the policy is already unclear, inc=
onsistent,
> >> >> > and confusing, IMO.
> >> >> >
> >> >> > For example:
> >> >> > 1) EFI capsule update wants to very strictly control the dfu alt =
values
> >> >> >    by setting it in set_dfu_alt_info(), but then any other DFU us=
e
> >> >> >    case breaks.  USB DFU boot is now broken.
> >> >> > 2) The behavior the user sees wrt the dfu_alt_info env variable i=
s very
> >> >> >    confusing and non-intuitive. Take this example:
> >> >> >
> >> >> > =3D> env set dfu_alt_info "sf 0:0=3Dexe1.bin raw 0 88000;exe2.bin=
 raw 88000 100000"
> >> >> > =3D> env print dfu_alt_info
> >> >> > dfu_alt_info=3Dsf 0:0=3Dexe1.bin raw 0 88000;exe2.bin raw 88000 1=
00000
> >> >> > =3D> dfu 0 list
> >> >> > DFU alt settings list:
> >> >> > dev: SF alt: 0 name: tiboot3.bin layout: RAW_ADDR
> >> >> > dev: SF alt: 1 name: tispl.bin layout: RAW_ADDR
> >> >> > dev: SF alt: 2 name: u-boot.img layout: RAW_ADDR
> >> >> > =3D> env print dfu_alt_info
> >> >> > dfu_alt_info=3Dsf 0:0=3Dtiboot3.bin raw 0 80000;tispl.bin raw 800=
00 200000;u-boot.img raw 280000 400000
> >> >> > =3D>
> >> >> >
> >> >> > As you can see, the user set's the dfu_alt_info variable accordin=
g to their
> >> >> > specific use case, then simply tries to list the DFU alt settings=
, and
> >> >> > because this code goes through the dfu_init_env_entities() path, =
it gets
> >> >> > changed to the EFI capsule settings.
> >> >> >
> >> >> > I was hoping to get a simpler fix in now so we can get USB DFU bo=
ot working
> >> >> > again, and we can visit the overall policy design next.  As you s=
uggest, I
> >> >> > could also push the testing of overwriting into the board specifi=
c
> >> >> > set_dfu_alt_info() function, but then I need to duplicate the cod=
e in 8
> >> >> > different places for the TI boards, and other vendors may still h=
ave the
> >> >> > problem.
> >> >>
> >> >> I agree that the above behaviour is confusing and I'm reconsidering=
 to
> >> >> take up this patch. I'd like some buy-in from either Heinrich, Ilia=
s or
> >> >> Sughosh on this since I'm not 100% confortable with the "policy cha=
nge"
> >> >
> >> > A little context here. The DFU driver already had this policy in pla=
ce
> >> > where, if the CONFIG_SET_DFU_ALT_INFO was set, the dfu_alt_info stri=
ng
> >> > would be set by U-Boot, instead of taking the user provided string. =
It
> >> > was decided to use this for EFI capsule updates, as getting the stri=
ng
> >> > which determines the location of writing the update images from with=
in
> >> > U-Boot is more resilient than taking some user provided string.
> >> >
> >> >
> >> >>
> >> >> >
> >> >> > Looking to the longer term solution, here are my thoughts.
> >> >> > 1) We need to decouple CONFIG_SET_DFU_ALT_INFO from EFI capsules.=
  The only
> >> >> >    reason TI boards are now setting CONFIG_SET_DFU_ALT_INFO is be=
cause EFI
> >> >> >    capsule update is enabled.  Outside of a few legacy uses (I th=
ink - it
> >> >> >    appears they were introduced prior to supporting multi-interfa=
ce dfu alt
> >> >> >    strings), I think this is true for other vendor's boards as we=
ll.
> >> >> > 2) Have EFI capsule support do as USB DFU boot does today, and se=
t the
> >> >> >    dfu alt string it wants used *before* initiating the DFU opera=
tion.  With
> >> >> >    CONFIG_SET_DFU_ALT_INFO no longer enabled, the value it set wi=
ll not get
> >> >> >    overridden.
> >> >> > 3) Have the actual value of the dfu alt string used in the DFU op=
eration be
> >> >> >    passed in, rather than read from the dfu_alt_info environment =
variable.
> >> >> >    The USB DFU and EFI capsule use case will pass in the dfu alt =
string
> >> >> >    they want. The standard 'dfu' command can pass in the value of=
 the
> >> >> >    dfu_alt_info env variable. Note that this effectively decouple=
s the dfu
> >> >> >    command from the alt settings that USB DFU boot and EFI capsul=
es use,
> >> >> >    but I think this is what we want.
> >> >
> >> > I think either of 2) or 3) above can be looked at. Although not sure
> >> > if 2) will be breaking the current DFU policy.
> >> >
> >> > -sughosh
> >> >
> >>
> >> Thanks for the comments.  I have looked into this a bit further and se=
e 2
> >> options we can take for the EFI capsule update use case:
> >>
> >> 1) stick with the more traditional approach and do as DFU BOOT does by
> >>    setting the value of the dfu_alt_info env variable just before
> >>    initiating the DFU operation. As Ilias sugggested, we could also ad=
d a
> >>    save/restore so this is transparent to other DFU users.
> >>
> >> 2) move to a model where we explicitly pass in to the DFU operation th=
e
> >>    value of dfu_alt_info that we want used. In the normal/legacy DFU u=
se
> >>    cases, this would involve calling env_get() for the dfu_alt_info en=
v
> >>    variable and pass that value. I like this approach because it is
> >>    cleaner and more explicit. However, there are many layers of functi=
on
> >>    calls between the driver of the DFU operation (the one that would d=
ecide
> >>    what dfu_alt_info value to use) and dfu_init_env_entities() where i=
t is
> >>    used, and passing this info across the function interfaces would
> >>    involved lots of function interface updates.
> >>
> >> I'm curious if there is apetite for 2) or should we go with the more
> >> traditional approach in 1).
> >>
> >> The above assumes we decouple CONFIG_SET_DFU_ALT_INFO from EFI capsule=
s.
> >> For platforms still setting CONFIG_SET_DFU_ALT_INFO, the presumption i=
s that
> >> if they override the dfu_alt_info env variable, they know what they ar=
e
> >> doing.
> >
> > Decoupling that should be pretty easy. I personally like 2) more since
> > it's much more scalable and doesn't involve saving.restoring values.
> > But I am not sure how big of a task it is
> >
>
> I went with option 1 above.  I started working on option 2 however the
> changes are quite invasive, touching all of the DFU interfaces, and I do =
not
> have the understanding of the different DFU use cases nor access to the
> different hardware using those use cases to test.  I also think that this
> change should be part of a broader DFU cleanup to use only the latest
> dfu_alt_info string format allowing multiple devices, so that we no longe=
r
> need to pass around the interface and devstr parameters.
>
> Please take a look at the patch series titled "EFI Capsule update
> explicitly sets dfu_alt_info" that I will post shortly.

Fair enough. I'll have a look tomorrow

Thanks!
/Ilias
>
> thanks
> Jon
>
> > Cheers
> > /Ilias
> >>
> >> Thanks
> >> Jon
> >>
> >> >> >
> >> >> > This then allows both USB DFU boot and EFI capsule use cases to w=
ork as
> >> >> > intended and allows the dfu command to operate on the user define=
d
> >> >> > dfu_alt_info value.
> >> >> >
> >> >> > I welcome comments from those that have the history and intended =
behavior
> >> >> > background of the DFU support :).
> >> >>
> >> >> I do as well. I have taken over maintaince on this subsystem a year=
 ago
> >> >> and have not had much patches/work done on the subsystem. Therefore=
 I'm
> >> >> not as knowledgeable as I would have liked to be. I'm sorry about t=
hat.
> >> >>
> >> >> >
> >> >> > I also welcome comments on how to proceed for 2025.01. Should we =
live with
> >> >> > USB DFU boot broken until we get the long term fix in, or ok with=
 the patch
> >> >> > posted here. The patch posted here does allow for a user to chang=
e EFI
> >> >> > capsule's dfu alt settings, as Mattijs says, but especially given=
 capsules
> >> >> > can be authenticated, I'm not sure how this would be exploited, a=
nd if that
> >> >> > risk is worse that broken DFU boot.
> >> >> >
> >> >> > thank
> >> >> > Jon
