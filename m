Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D21FF885A
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 20:08:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 169378419E;
	Sat, 25 Apr 2026 22:08:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DhdrnEIT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FFAA8420C; Sat, 25 Apr 2026 22:08:16 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E387784178
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 22:08:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48374014a77so116976425e9.3
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 13:08:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777147693; cv=none;
 d=google.com; s=arc-20240605;
 b=Ymy5oDZAmIuEdRaokNXG73w9VxPf9YbzB/33rMkaSiqjFczGQpOEiEtxTeVuXUD/zd
 hI2K6NkPw865uFaD2MwKnWTdMLYhy25JKtbGgYtWpX7GCeh7qqbhTwbMOzAeh1hO63vG
 4q1TMVt0B5sc4+JiCJfj1tSWVzlqF3/Xd9x7nPznoHPJu22o89c37VL1htCkI3KlK23P
 E0x14Z4asX+zA2G3eVd/nzIDn6EyzcOJTysw/3aYLCi4bzdcUL7/tweiMXH1wR58oGgp
 zdndv3YYyfX/Ponq5BRxy0bEzgy5o/x7sJqaqwvCsHKpqIUNHW40SGOrb/M1nD7H25BT
 g/lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=q2wh19CCCQ5JHODDT04EbXBebRoxxlL7efyGkhVuvZc=;
 fh=hEymi4IDFEKte3k2lI6EQ3gTkd/kHtxBaVclzQGgSGw=;
 b=XXdHkZEw2hmWBNhAsF7HLCV1lvyuddUoaPxhK7YyH6wGzuE9qHk4fmb1gRO20YTcS6
 xJFnnX/ZDHADe1NYDAZf3Wc0k+30JUeM/+CEoNnrNTskVeGKI31zkGl66mgaoWVI9TPA
 knrf0HS5qwLbbq+d5bq4jpv+PrNhUhj3poV3OykLGmzsfLccZXgZdMevmDaqCHzhun6h
 yZ3S0fPdldnSwX2LcCtGe4wCid64YzmzfkW/j6PqXfI15iB4jXQza9xggW7Bb6BsLUwv
 hRq4OY/ISnfs9uAgW36d7e8f45WeHIHRs33kNvDTmjqJz6eeI2CrRsDnkM6ctzVIleU8
 h7Kg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777147693; x=1777752493; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q2wh19CCCQ5JHODDT04EbXBebRoxxlL7efyGkhVuvZc=;
 b=DhdrnEITEzMdQO4BGYM4+M/3M8zH1E82NvNYuecwgxgPwSeI3eK732I4W1+1ZKsiPh
 3NlL6l/hY7qnX+HxEgQtbqM96Sd2wWHVwawnk3W1mciT8qsJw8U4RFhKlrzdqOlg9DHv
 DRVM9R5fy97T+l/Ze5vldMX1Q5yZ2BQ1JIncw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777147693; x=1777752493;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q2wh19CCCQ5JHODDT04EbXBebRoxxlL7efyGkhVuvZc=;
 b=OJhSh63ejrotNcW7TWuyVpMLme2r4AkDkQ5KSawgnNHCloZezhG5Od0HtG1ckC6I1N
 7xjz6xfhR5ORD0RrmxZawjaHmAWGI9WtC4cb88bqNK8YhSZjeh7Ja5th7xI251lr3v1r
 +4sMef0LqHtP+rtROKQKZJ4GLbgRFzR/XNCMUhOcuRTR9DS48JRidxS61U+gl0kBZFV5
 o6AR0ELUfXWPu6GsveVdwuOsR3w1jr+fVZ+9EYu8QUWCX1uZgW/JUCTkRrN8hljFs0lF
 Ylnjaofec7RAp/8pP52XHKj8FOR2b86OWdXQiLgXa9So/P/EyznpuaEn/HVhMzkKGPMG
 qw3A==
X-Gm-Message-State: AOJu0YzSwsVVdfESzxp03OCi7YSkdG1tRGqDixvgl8gr3sqKlzCRXUH5
 777pq5TPNThy3pJk6gR/CZTpNYYo0AqUXDqt0nwtwAwtcEohUcL65ycnEdKWDGVXOTMWFPvy7py
 3dHla5g6w/QR5+feaayBdnivp266gWZPeNDsHl7UDgXXfhTC/tJA3bA==
X-Gm-Gg: AeBDietOhW8owuCi4ujg0TK2OG4zljrkNOvSCGgc9xGyoYXZOuRf7FaxZ6hd6THC1Vq
 2dEzjI7TZtNQaWnNN9qkOCKcoUVwq4eWuIN9Qiqc3NWp1YEKJeUwp/7zG/wsv2sHr3Q5umFnDuw
 O0uObMeUReyGP0iORJY9amHnCQahH4Lvf60UxWq2HcqISuw1g87k0BwdKJEwI6SPjYhEqa6BC6S
 Ia2B0jdCbXWf1LrmER6GxKURgYbmTn4+EAV2GFTQ7gvRuC/aL3eGxyhHzeed2zL1x/UdisceVBE
 e3N1GxKe8TbVSuo8lgHU
X-Received: by 2002:a17:907:3d8e:b0:ba9:7898:c0ab with SMTP id
 a640c23a62f3a-ba97898d80amr478251966b.13.1776895821187; Wed, 22 Apr 2026
 15:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260421004719.73491-1-briansune@gmail.com>
 <CAFLszTjJOfcddrdbN7oMPGAVZJRmj689-1bN5bY2gGiFdc=RGg@mail.gmail.com>
 <CAN7C2SAJYbMFmRorV7w6XphPh24iuTTeobW6q66Dk9_q1s61jg@mail.gmail.com>
In-Reply-To: <CAN7C2SAJYbMFmRorV7w6XphPh24iuTTeobW6q66Dk9_q1s61jg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 23 Apr 2026 10:10:08 +1200
X-Gm-Features: AQROBzB732I9OyycwRY1OTpp8xpwNJ2Uvm-P1xOtcf-uqCReAP8hmHuss42vpQI
Message-ID: <CAFLszTiafeVeAm-A6KVDoiXbEKLOQAWEyojO2msDB-yMPrBUVQ@mail.gmail.com>
Subject: Re: [PATCH v4] Improve handoff prepare on SoCFPGA
To: Sune Brian <briansune@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Chee Tien Fong <tien.fong.chee@altera.com>
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

Hi Brian,

On Wed, 22 Apr 2026 at 15:13, Sune Brian <briansune@gmail.com> wrote:
>
> On Wed, Apr 22, 2026 at 10:54=E2=80=AFAM Simon Glass <sjg@chromium.org> w=
rote:
> >
> > Hi Brian,
> >
> > On 2026-04-21T00:47:19, Sune Brian <briansune@gmail.com> wrote:
> > > Improve handoff prepare on SoCFPGA
> > >
> > > There are some cases that the Python scripts
> > > are run and the qts files are not replaced.
> > >
> > > This patch introduces:
> > > 1) TMP folder for Python script
> > > 2) TMP folder will automatically remove on exit
> > > 3) If PY script fails, the replace will not conduct.
> > > 4) Only when PY script passed the replace with keep
> > > or without keep will be done via NEW HANDOFF_KEEP=3Dxxx
> > > 5) When keep is selected the old files are renamed to
> > > xxx.h.handoff.<timestamp>
> > >
> > > As such this ensure qts folder h files are properly
> > > updated.
> > >
> > > Signed-off-by: Brian Sune <briansune@gmail.com>
> > >
> > > arch/arm/mach-socfpga/config.mk | 27 ++++++++++++++++++++++++---
> > >  1 file changed, 24 insertions(+), 3 deletions(-)
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > Some thoughts though.
> >
>
> Hi Simon.
>
> > We try to add a change log for each revision and use imperative
> > present tense (Introduce a temp folder... rather than This patch
> > introduces...). Spell out Python script rather than PY script, and
> > reword as prose or a bullet list instead of 1), 2), ... You could also
> > explain *why* the qts files were sometimes not being replaced - the
>
> Because it is not fully traceable, git pull sometimes could introduce
> some kind of unknown cases that even run make prepare will not update
> the h files or the python script itself does not fully replace it from
> first place.
> So the easiest way to play safe in any possible condition is
> [remove and replace] or simply [rename and create].
>
> And I don't even fully confirm the cases, while this patch does improve
> the previous .mk operation no matter if it is solving the unreplacing iss=
ue
> or not.
>
> So the motivation was explained from the title itself.
>
> > motivation paragraph currently just says some cases without saying
> > what goes wrong.
> >
> > The message says kept files are renamed to xxx.h.handoff.<timestamp>
> > but the code uses .h.handoff_backup.<timestamp> - they should match.
>
> That my mistake on the description, indeed it should be
> .h.handoff_backup.<timestamp>
>
> The idea just follows T.F. previous optional idea so I don't fully pay at=
tention
> to the wordings.
>
> >
> > > diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpga/=
config.mk
> > > @@ -43,6 +43,27 @@ socfpga_g5_handoff_prepare:
> > > +                     if [ -n '$${HANDOFF_KEEP+x}' ] && [ '$${HANDOFF=
_KEEP:-1}' !=3D '0' ]; then \
> >
> > How about:
> >
>
> No I don't like this because you ignored my original idea on:
> 1) HANDOFF_KEEP=3D should run keep
> because HANDOFF_KEEP cannot without =3D in .mk usage
> 2) When users use this flag, hence,  it is telling that they want to
> keep the thingy.
> So it makes no sense to =3D1 or =3D0 to further control it from first pla=
ce.
> This flag is inherently boolean logic.
> But due to your suggestion I further elaborated this boolean flag to
> support =3D0 or =3D1 or =3Dx cases.
>
> Sorry for this part, I will not change.

That's fine...note that you have my review tag, so you can add that to
a new version, if you do one.

>
> Cheers,
> Brian
>
> > if [ '$${HANDOFF_KEEP:-0}' !=3D '0' ] ; then \
Regards,
Simon
