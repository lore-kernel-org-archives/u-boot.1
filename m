Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76315FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 19:11:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C13D38439F;
	Sat, 25 Apr 2026 21:11:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LQ0UKKsU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50EDA8439F; Sat, 25 Apr 2026 21:11:57 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0044C84372
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 21:11:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7dcd8ef572aso2945747a34.1
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 12:11:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777144314; cv=none;
 d=google.com; s=arc-20240605;
 b=NYypl+6IPI7IK/1qeSk24uymxwgDHifGGo7uZyV3592JPWlVcOe1Daflu1LF1T0yUG
 +5wv9rIZvDgvn28DVKA4YW6K9e2LUTNmAaXVBpO/pFdrkE+fpEk9aox3/hC3F9WnKqhr
 HX3px06G2lpbypX+aGvQ3zZyOBHry8TLgBL/luTFBO6O6B9iCWrHy1IQeg1rar0yTdBx
 a+LZtcn6ZzbjTTunVXjiHsDG5lbx4zyJ2pS70DrU6EzMldODzo0P6EpcSqXuwvmYhX9P
 MNQ/LuI4/Tw2ZJ4d1i5lO1MtxMcmbzVEXdo6XHhzLNSmnq6Pu2ELvVLDh6FGax2qJsX4
 2PYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TZww/rWtgxlamX8htSQgsfVajn/HZkjCwTcIwuiPxvM=;
 fh=O7GFOPQ6WLQUVnvP3Ux0HSkCcmdgEygIxNih4nllT2U=;
 b=bSreVtaAg5ywQGa9g+0zgkBSomyT9QJ3KORVy8LtzdDFOCwc6aA7zU9iuBVuUZCFyG
 sDQSC9tki77v3eOU+k32rhvyDWex/BICKrHZvCwhObumPqwLHL/PKb4zO7M1QyPVfkVM
 1OEXJqwYJHKwHlsosYsKNRy+EFeVEAppmyqyYEmbJuyM2IkNDq5eddWYFbsgnb8xI71V
 q9QL2GXc5VAaVQg3yBq1J4NePgcN/EsCkn8MpyIOackrzFpLQyUnH5b3Du8huNOf98s7
 QAXb/bhX1hJ4IWa0dgvGZ9++bSstmY7aAyb16AW7VF0VJ/veAXo/eyzvRNqJpbA8u8eV
 WUow==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777144314; x=1777749114; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TZww/rWtgxlamX8htSQgsfVajn/HZkjCwTcIwuiPxvM=;
 b=LQ0UKKsUn97sS2vzLKD5xcbW6e2DwFzFcE/nzSBIi/91I+pYRlSy/vSkKnAb0F9fs1
 Ak683eQ+hBYMrG+IL4Dx2/Lfji4iVKlgNC5NJm+f6dWYEypXdNG5Mw8BKZzSx+E+VOuS
 1XBfQ3mu3cISKEF3QtcgIjEOl8DBsd/GJu9GIZDf0VYJUq501a3Dlxj1rdGBMIqji1CR
 y7OiCGK08PAVbfrwg0bdUUziZAnL5EcvDeXCVR/ic2bTB8suVCbbBX8mCZnJRpPSGCQz
 OqbAiFXtlgQREqi0F/x8rAe3G4sxrDzfrPv/2fAcFRoeRYf+/pVtolpZvPQ1BeEL2dpV
 aiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777144314; x=1777749114;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TZww/rWtgxlamX8htSQgsfVajn/HZkjCwTcIwuiPxvM=;
 b=m1FMZLGS4cYm8lYlJ91O4fuupPEbk4e2rzFHTpsus1pz+ojwqBDmqviiTl5pUDiw4P
 aIaUUCz+lDga6op+wBdmHknFl6WHMGRAPZ3T8PctFBcAKTjJklrOpE4HuBqhMkM/GOrz
 eLgvwnFXJoqVqF6CQ4dvShHXaJb83cxlaL8lWmL08wXdpHVkKpi+3aG2zU5noIv2Mdwj
 ZneTfr8Ue43lWqWkHlshfCXhCgZfe6jhT13MhaKNXDNpmDc29c1dLVlAnJbYMmtx/bPq
 eZ/Y57uP8Sq7u9MD5kfT36nn07rnaGVtaiGj7ImAHQYS2ZP3zsTXlqRw8t77ERd0QLag
 qJcw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/lC+EbMxime5NORuxFZdO8hPDSTWW73WFVCFWGxorNn8MSAwSuEvuLOLh6jb/h9VpC4groV3o=@lists.denx.de
X-Gm-Message-State: AOJu0Yw01zy1UfMxkJ5SwZwmsVZ1JZgYiGcxY3T4PlvPwdIyjobvJeRu
 vuis1k/5UDqLH/r+td4+iOqCxkkrNRQBh/tgLty7f2z4UlLZmu3ZGp8X4vQGmk0+JoG6O2QYbIq
 zD+Md8xH41xbEF26HZ9se+AL9FV2kFRUeMS8Kne4bGBmJ
X-Gm-Gg: AeBDietRy7vdaMxaq1IOBtteK/kh0y6Ih7EeDCIJu54nVMhobx4W4ckbfXG/Q4a+RYb
 aZtmYj4fT+fDlWHBXGCL6BAPszPVkAkqu1QuDzIFP4w5I9OsMPO+ltIUDEL/tynF0gw2n+mq06b
 T/LP8jbb+WIxlI2eMyaWQl5tpK4KBJ59y8RVZr6+VdQD+i7rVw4QpX1AFgD0E8VzL+EV9JffeuG
 TRKJfLt1Udz0ZnL1eO/D/XCvA+7x3z6DTK3GUOSDdqXpUjssUH4FzmqhjDkQCHjeZzMlVPKmOil
 Tmht/zwZECTAudCPI94=
X-Received: by 2002:a05:6830:411a:b0:7d7:eab6:fb23 with SMTP id
 46e09a7af769-7dc951fc6admr16233163a34.22.1776913612550; Wed, 22 Apr 2026
 20:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260421004719.73491-1-briansune@gmail.com>
 <CAFLszTjJOfcddrdbN7oMPGAVZJRmj689-1bN5bY2gGiFdc=RGg@mail.gmail.com>
 <CAN7C2SAJYbMFmRorV7w6XphPh24iuTTeobW6q66Dk9_q1s61jg@mail.gmail.com>
 <CAFLszTiafeVeAm-A6KVDoiXbEKLOQAWEyojO2msDB-yMPrBUVQ@mail.gmail.com>
 <CAN7C2SDZhThgON+4r318ka=gKsu3OWrEeZ=OW=Q0xppOj1xYTw@mail.gmail.com>
 <275c4b67-476e-4b15-82fe-e4f1d1c24b25@altera.com>
In-Reply-To: <275c4b67-476e-4b15-82fe-e4f1d1c24b25@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 23 Apr 2026 11:06:40 +0800
X-Gm-Features: AQROBzDcKxTfZZK3YLO5WsE1SzhqH6ILahFlFkOnawbP3CrdLVKexh7_TwGZCC0
Message-ID: <CAN7C2SB_BZUFJjWpsjCJ0HNeU7ZPfMxgsmK5gCQx-WoZqCgTyQ@mail.gmail.com>
Subject: Re: [PATCH v4] Improve handoff prepare on SoCFPGA
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
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

On Thu, Apr 23, 2026 at 10:24=E2=80=AFAM Chee, Tien Fong
<tien.fong.chee@altera.com> wrote:
>
> Hi Brian,
>
>
> On 23/4/2026 6:29 am, Sune Brian wrote:
> > [CAUTION: This email is from outside your organization. Unless you trus=
t the sender, do not click on links or open attachments as it may be a frau=
dulent email attempting to steal your information and/or compromise your co=
mputer.]
> >
> > On Thu, Apr 23, 2026 at 6:10=E2=80=AFAM Simon Glass <sjg@chromium.org> =
wrote:
> >> Hi Brian,
> >>
> >> On Wed, 22 Apr 2026 at 15:13, Sune Brian <briansune@gmail.com> wrote:
> >>> On Wed, Apr 22, 2026 at 10:54=E2=80=AFAM Simon Glass <sjg@chromium.or=
g> wrote:
> >>>> Hi Brian,
> >>>>
> >>>> On 2026-04-21T00:47:19, Sune Brian <briansune@gmail.com> wrote:
> >>>>> Improve handoff prepare on SoCFPGA
> >>>>>
> >>>>> There are some cases that the Python scripts
> >>>>> are run and the qts files are not replaced.
> >>>>>
> >>>>> This patch introduces:
> >>>>> 1) TMP folder for Python script
> >>>>> 2) TMP folder will automatically remove on exit
> >>>>> 3) If PY script fails, the replace will not conduct.
> >>>>> 4) Only when PY script passed the replace with keep
> >>>>> or without keep will be done via NEW HANDOFF_KEEP=3Dxxx
> >>>>> 5) When keep is selected the old files are renamed to
> >>>>> xxx.h.handoff.<timestamp>
> >>>>>
> >>>>> As such this ensure qts folder h files are properly
> >>>>> updated.
> >>>>>
> >>>>> Signed-off-by: Brian Sune <briansune@gmail.com>
> >>>>>
> >>>>> arch/arm/mach-socfpga/config.mk | 27 ++++++++++++++++++++++++---
> >>>>>   1 file changed, 24 insertions(+), 3 deletions(-)
> >>>> Reviewed-by: Simon Glass <sjg@chromium.org>
> >>>>
> >>>> Some thoughts though.
> >>>>
> >>> Hi Simon.
> >>>
> >>>> We try to add a change log for each revision and use imperative
> >>>> present tense (Introduce a temp folder... rather than This patch
> >>>> introduces...). Spell out Python script rather than PY script, and
> >>>> reword as prose or a bullet list instead of 1), 2), ... You could al=
so
> >>>> explain *why* the qts files were sometimes not being replaced - the
> >>> Because it is not fully traceable, git pull sometimes could introduce
> >>> some kind of unknown cases that even run make prepare will not update
> >>> the h files or the python script itself does not fully replace it fro=
m
> >>> first place.
> >>> So the easiest way to play safe in any possible condition is
> >>> [remove and replace] or simply [rename and create].
> >>>
> >>> And I don't even fully confirm the cases, while this patch does impro=
ve
> >>> the previous .mk operation no matter if it is solving the unreplacing=
 issue
> >>> or not.
> >>>
> >>> So the motivation was explained from the title itself.
> >>>
> >>>> motivation paragraph currently just says some cases without saying
> >>>> what goes wrong.
> >>>>
> >>>> The message says kept files are renamed to xxx.h.handoff.<timestamp>
> >>>> but the code uses .h.handoff_backup.<timestamp> - they should match.
> >>> That my mistake on the description, indeed it should be
> >>> .h.handoff_backup.<timestamp>
> >>>
> >>> The idea just follows T.F. previous optional idea so I don't fully pa=
y attention
> >>> to the wordings.
> >>>
> >>>>> diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpg=
a/config.mk
> >>>>> @@ -43,6 +43,27 @@ socfpga_g5_handoff_prepare:
> >>>>> +                     if [ -n '$${HANDOFF_KEEP+x}' ] && [ '$${HANDO=
FF_KEEP:-1}' !=3D '0' ]; then \
> >>>> How about:
> >>>>
> >>> No I don't like this because you ignored my original idea on:
> >>> 1) HANDOFF_KEEP=3D should run keep
> >>> because HANDOFF_KEEP cannot without =3D in .mk usage
> >>> 2) When users use this flag, hence,  it is telling that they want to
> >>> keep the thingy.
> >>> So it makes no sense to =3D1 or =3D0 to further control it from first=
 place.
> >>> This flag is inherently boolean logic.
> >>> But due to your suggestion I further elaborated this boolean flag to
> >>> support =3D0 or =3D1 or =3Dx cases.
> >>>
> >>> Sorry for this part, I will not change.
> >> That's fine...note that you have my review tag, so you can add that to
> >> a new version, if you do one.
> >>
> >>> Cheers,
> >>> Brian
> >>>
> >>>> if [ '$${HANDOFF_KEEP:-0}' !=3D '0' ] ; then \
> > Hi Simon,
> >
> > V5 has been released.
> > Due to T.F. "please to use your check condition"
> >
> > Logically speaking.
> >
> > The check condition now has become:
> >
> > A person has no intention to use the restroom.
> > But that person intentionally walk in front of the restroom door and
> > speak out not going to use the restroom,
> > Then that person simply goes back to where he came from and does
> > not even enter the restroom.
> >
> > What a wonderful world =3D]
>
> Just to clarify my earlier comments, the intent wasn=E2=80=99t to force a
> particular approach,
>
> but to share review suggestions and ensure the commit message and
> behavior are clear for future readers.
>
> On the shell test, I had meant: either your earlier semantics or Simon=E2=
=80=99s

Hi T.F.,

Interesting, "simplified one"  so when users use > make + keep flag
where flag label is self explained still adding extra =3D0 or =3D1 is consi=
dered
as simplified.

No one forced me, while you used "please" so no worries, just pleasure for =
me
to copy and paste w/o further thinking is even easy for me. Love to do so.

Thanks,
Brian

> simplified one was fine, as long as the behavior is clear for reviewers
>
> I appreciate you incorporating the parts you agreed with.
>
>
> Best regards,
>
> Tien Fong
>
>
