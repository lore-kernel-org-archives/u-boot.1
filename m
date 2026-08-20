Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6995C5DF82
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 11:12:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6272580CC5;
	Thu, 20 Aug 2026 11:12:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hUfAtCEYeO3i; Thu, 20 Aug 2026 11:12:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787224328;
	bh=Nd6yCuG7NJBXXXWeg1u+D6fgFaV+RJ88Ts/e5iWXG9I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pNniG7ppMwoB8zPt05DVZKz731CLmf3QSp6h3XR0jLvT+SCR7OLshuGfMt3donxLn
	 Aoe57GSS/suDXlLue+TSx6F0MuJecuCsgVSOj0ZSV3aLRUE68+XyjDSheJHIK3D7rP
	 ait4lcKKjD/kXYX1Fuj5kVEs3Xv4JFcEm3joyvXWV/ANi5dSygyMCL/8SquUnZtUNa
	 bQVvsr0Q7+IQhj84Dchcxx+vRC+TEfB6WPoY4cqcL5iOVhRjNbUq1rlJzSQfvijjY2
	 g6SpK55aH+qfX81d4lVwTE78SjXUaWmDunQu4JsU0BaftQZXd0QzTjXO5C7An/yrKD
	 KmcQlilTgmv4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 603BD80CA2;
	Thu, 20 Aug 2026 11:12:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 76B1729D
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 11:12:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5CEA740292
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 11:12:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ydVpxUDdAmEf for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 11:12:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=YA/XtRjH
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2D53C40082
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 11:12:05 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6a051904222so3002198a12.2
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 04:12:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787224324; cv=none;
 d=google.com; s=arc-20260327;
 b=grKgHF9L0F2u79Qq6KLyGLrC/2eZz+uXw8Z0c2d+BzV2EySG8RWBn2akXzm+Woj2A/
 TI9nQVWu8jy9kIr7a+T+kGbB+t10SIcqN5ALQ7F3ydI2mjy8t/WzhI581F04jHhp6kd4
 rGJiMVNZO4uYFE5sT8+vrfUJSR25J/MxqqziBaIbqz9Ds1VxdOeyPJ1oEnsX0s31Rwpa
 euZp7FKshu0T1SGCwW/nKX2kSlzrJ4ccDdu2HazdVq385ZEf0ROKAaSqhH398c4tmpE9
 3dPqxitBVRATW1f5TGuzWpeH6zicOBI33jWCzIuiVg8mZsuYrBMH4c8pXpETZuvpIx4t
 sPcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Nd6yCuG7NJBXXXWeg1u+D6fgFaV+RJ88Ts/e5iWXG9I=;
 fh=kEYfZBBSRt45rdAyEExcuq1763Pb6qQ6ayanXNU4av4=;
 b=hirNef/dW8VycAUGu7uWXmMmdbROXuc9vIIdm3bYlPzJt2cZl5/3dWDYGgIng3eAWP
 yrdrDLDcqbPdeHcE77HL/IbISUtk1c1xl02L87l3EYzI7+1aVJ1lCBL3IV4Xw5MnxANr
 V4o+S5DIqOfkadAvkY5y3/3h9c0S7LUQFGFjifqATJ2w7A9014Nj5rIDelLeIKgiIpct
 I+4wngL6f3881fhPzoboIsaU5e6TwCGgCaj0LVWsWdaOl0yDQ8xBYErgyg5P43LJ6HJR
 r83PTUnbZlIOoi/384vDE51S5St3sTAcmoaHcQB/YQKTV/wOwXLYqNXHaOG9hsWSGaI9
 TzSw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1787224324; x=1787829124;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Nd6yCuG7NJBXXXWeg1u+D6fgFaV+RJ88Ts/e5iWXG9I=;
 b=YA/XtRjHGOLPZAUB1FhGa6YaN5uGORIuJPm8DLKydho0CYZ5DJSVBW3MIBDp1IRjlz
 FteMOwkGHFrxVVAP9V8Hf7TANmKEY967q8rHRFI+lLJXP8Geepomw2UCe+4NtPwTxsAc
 ax+QrN3aIYEqo/JlkwNdydK998TrpDaOdG3Lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787224324; x=1787829124;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Nd6yCuG7NJBXXXWeg1u+D6fgFaV+RJ88Ts/e5iWXG9I=;
 b=iVN1163NagCKDHSVpCeYda5g42lYTGfvyeLyqSLZbWQ0bJgNtsjX0db8NYgUCwmbCj
 2M384mdsLqk0+2bxpiG9AeC8d3WhiESFtysoX7dMyVGO3vioVu0PSq4zQCacR1eUz3D4
 o6mhfIpuahav7SrINyc8/Teo8UDhLEfJVsNHCpHKkVW0cEVIJpjZhOWSRfK1BwL9/aTV
 1i8HXerMyMr1WA5Zmxjcpec3sUTLSLY4fbnFlQhivAvn6vO9W9ErEKApJl/zQfvuzJv9
 60cvE8M2GxFsuz9DKJSq/fFSydxrv00NB0ZcLm//a1nX4udg5PEU9txJRoTT3LCfiqNG
 YXoQ==
X-Gm-Message-State: AOJu0YyeNkN9sMD5ZHPCagrmrGTjXD51U9WSSE/DLmc4DJtWFCZLaQEn
 LvM4JwO8FJ7opZAiaU3G6ixVry1+1lF/vxbsghE23ZXS7ADO/+GDo5a9BXcSihAHqN4pmiBAflU
 rGXQWbR8xPqamWq3HHjj7kmyMK3h32QIWlOroTfW1
X-Gm-Gg: AR+sD127IpTY1Qq/kWN4pmQoeLT33SKmaYb1JOvvas32bVOakfCyo+cYjIIa5IC+YLC
 2nUL+K+6Edc0FJ8/w6g9BgHAXP03VCPddkUE0ipDLlrVcxTewB+CD3sFOh1a1kLqPI0wI5VkL5X
 W7gWKN2fOmLd7HDkj7NSOZpq1HCaWIMrSCCknbsysiGIsChGuPnkVBEZPOYUZQ/ldnkZAABpDBJ
 USta6WLH0FP5Q4BpsigVPR0ty8yiNfG6ch4VHRzc06kGx5Zh5KK5prCJ5b24x2v6iurQIgX3hNT
 W0dKef+8drEokk+t/D8dx7g+0MBxtsCemub4GWvSPSY=
X-Received: by 2002:a17:907:930e:b0:c16:126b:98b4 with SMTP id
 a640c23a62f3a-c23f935297bmr731589466b.3.1787224323846; Thu, 20 Aug 2026
 04:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260806-improve-logging-on-missing-uclass-v1-0-d477f0054f48@baylibre.com>
 <20260806-improve-logging-on-missing-uclass-v1-1-d477f0054f48@baylibre.com>
 <CAFLszTiW7wZf_TUf-1hjkMGLaEd8GJ1QjUSe4dQugW2aDdOY4Q@mail.gmail.com>
 <CAEHHSvYfBunWje_rJJJkft2guJDod1kFtpsgjuxazQCXcABaag@mail.gmail.com>
 <CAFLszTin8Hx3SMiXJF4Ug7vynUSG_WArqmZA+Hvjh2h1cvq7ww@mail.gmail.com>
 <CAEHHSvbtJbefwWkpng2O_qRFZdB3pSEhh8poozEs_KvwT7h06w@mail.gmail.com>
In-Reply-To: <CAEHHSvbtJbefwWkpng2O_qRFZdB3pSEhh8poozEs_KvwT7h06w@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Aug 2026 05:11:51 -0600
X-Gm-Features: AcwNN1XM_soFXPvkBB7y-vvjY2-ogJx3s3RGuV4NjbAvevCJKzV_I_OHDBLp4Zk
Message-ID: <CAFLszTgH-VyGhdZFEb7TMm=y66J_9QkD1AkcBGC_ZchQxU0rAg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dm: improve logging for missing uclass
To: Julien Stephan <jstephan@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, dlechner@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Julien,

On Mon, 17 Aug 2026 at 01:33, Julien Stephan <jstephan@baylibre.com> wrote:
>
> Le ven. 7 ao=C3=BBt 2026 =C3=A0 21:44, Simon Glass <sjg@chromium.org> a =
=C3=A9crit :
> >
> > Hi Julien,
> >
> > On Fri, 7 Aug 2026 at 09:33, Julien Stephan <jstephan@baylibre.com> wro=
te:
> > >
> > > Le jeu. 6 ao=C3=BBt 2026 =C3=A0 19:01, Simon Glass <sjg@chromium.org>=
 a =C3=A9crit :
> > > >
> > > > Hi Julien,
> > > >
> > > > On 2026-08-06T13:05:19, Julien Stephan <jstephan@baylibre.com> wrot=
e:
> > > > > dm: improve logging for missing uclass
> > > > >
> > > > > When a uclass definition is missing for an enabled driver, the bo=
ard
> > > > > cannot boot, and without any extra debug option enabled the follo=
wing
> > > > > error is displayed:
> > > > >
> > > > >   initcall_run_r(): initcall initr_dm() failed ### ERROR ### Plea=
se
> > > > >   RESET the board ###
> > > > >
> > > > > There is a debug message using dm_warn(), which is not displayed =
by
> > > > > default.  Since this is a fatal error preventing the board from b=
ooting,
> > > > > the log level should be at least ERROR.
> > > > >
> > > > > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > > > >
> > > > > drivers/core/uclass.c | 5 +++--
> > > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > >
> > > > > diff --git a/drivers/core/uclass.c b/drivers/core/uclass.c
> > > > > @@ -60,8 +60,9 @@ static int uclass_add(enum uclass_id id, struct=
 uclass **ucp)
> > > > >       *ucp =3D NULL;
> > > > >       uc_drv =3D lists_uclass_lookup(id);
> > > > >       if (!uc_drv) {
> > > > > -             dm_warn("Cannot find uclass for id %d: please add t=
he UCLASS_DRIVER() declaration for this UCLASS_... id\n",
> > > > > -                     id);
> > > > > +             log(LOGC_DM, LOGL_ERR,
> > > > > +                 "Cannot find uclass for id %d: please add the U=
CLASS_DRIVER() declaration for this UCLASS_... id\n",
> > > > > +                 id);
> > > >
> > > > This file sets LOG_CATEGORY to LOGC_DM at the top, so log_err() wou=
ld
> > > > be cleaner:
> > > >
> > > >     log_err("Cannot find uclass for id %d: please add the
> > > > UCLASS_DRIVER() declaration for this UCLASS_... id\n",
> > > >             id);
> > > >
> > > > The idea with this was that by returning -EPFNOSUPPORT (unused
> > > > elsewhere in U-Boot (he says...)) it would indicate this problem,
> > > > without bloating the code with a large message. This code is used i=
n
> > > > SPL where code size is at a premium. I don't see the error number
> > > > though, which I added here:
> > > >
> > > > 13123276806 initcall: Adjust the failure message and return value
> > > >
> > > > Hmm yes it was dropped in the initcall move back to the header file=
.
> > > >
> > > > We already have DM_WARN to help people with debugging, so perhaps
> > > > instead we should just enable that by default in U-Boot proper?
> > > >
> > >
> > > Hi Simon,
> > >
> > > I didn't think about the impact on SPL. I understand your point, but =
I
> > > do feel a fatal error deserves a proper message.
> > >
> > > So what about reducing this long message to something shorter, using
> > > log_err() as you suggested:
> > >
> > > log_err("uclass %d: no UCLASS_DRIVER()\n", id);
> > >
> > > That keeps a readable, greppable hint while cutting most of the SPL
> > > size overhead.
> > >
> > > I didn't audit all the dm_warn() callers, but enabling DM_WARN by
> > > default feels overkill. I suspect several of them are
> > > genuinely non-fatal warnings.
> > >
> > > Otherwise, we could just drop this patch, since patch 2 now prints th=
e
> > > -EPFNOSUPPORT value on failure.
> > >
> > > What do you think?
> >
> > I tend to agree that a message would be better. But any SPL growth is
> > painful...perhaps we could have a Kconfig to control just this case
> > (default y in TPL/SPL/Proper) so people can turn it off for
> > production?
>
> Hi Simon,
>
> Sorry for my late reply, I was on vacation last week.
>
> I've been thinking about this, and here is my suggestion for you to
> review before I send a v2 (not tested yet): convert DM_WARN into a
> choice with DM_NONE / DM_ERR / DM_WARN to control the verbosity of
> driver model logs. Something like:
>
> drivers/core/Kconfig (same for the SPL/TPL variants):
>
> kconfig
> choice
>       prompt "Driver model log verbosity"
>       depends on DM
>       default DM_ERR
>       help
>         Select which driver model messages are compiled into the binary.
>         Each level includes the levels below it. Lower verbosity saves co=
de
>         size by compiling the message strings out (useful for production
>         builds), while higher verbosity helps with debugging.
>
> config DM_NONE
>       bool "No messages"
>       help
>         Compile out all driver model messages. This gives the smallest co=
de
>         size, but a fatal condition gives no hint about its root cause.
>
> config DM_ERR
>       bool "Errors"
>       help
>         Emit driver model error messages via dm_err(), at ERROR level.
>         These report fatal conditions that typically prevent the board fr=
om
>         booting. Warnings are compiled out.
>
> config DM_WARN
>       bool "Warnings and errors"
>       help
>         Emit driver model warnings via dm_warn() (WARNING level) in addit=
ion
>         to errors. This is the most verbose and uses the most code space.
>
>         Warnings may help with debugging, such as when expected devices d=
o
>         not bind correctly.
>
> endchoice
>
> include/dm/util.h:
>
> -#if CONFIG_IS_ENABLED(DM_WARN)
> +#if CONFIG_IS_ENABLED(DM_WARN)               /* warnings and errors */
>  #define dm_warn(fmt...) log(LOGC_DM, LOGL_WARNING, ##fmt)
> -#else
> +#define dm_err(fmt...) log(LOGC_DM, LOGL_ERR, ##fmt)
> +#elif CONFIG_IS_ENABLED(DM_ERR)              /* errors only */
> +#define dm_warn(fmt...) log(LOGC_DM, LOGL_DEBUG, ##fmt)
> +#define dm_err(fmt...) log(LOGC_DM, LOGL_ERR, ##fmt)
> +#else                                        /* no messages */
>  #define dm_warn(fmt...) log(LOGC_DM, LOGL_DEBUG, ##fmt)
> +#define dm_err(fmt...) log(LOGC_DM, LOGL_DEBUG, ##fmt)
>  #endif
>
> This gives a reusable dm_err() mechanism, and existing dm_warn()
> callers keep working: nothing selects DM_WARN, there is no #ifdef
> CONFIG_DM_WARN in C (only the CONFIG_IS_ENABLED() above), and a choice
> member named DM_WARN is still =3Dy when selected. Only one defconfig
> sets CONFIG_DM_WARN=3Dy today, and it still resolves fine (I can refresh
> it as part of a v2).
>
> One deliberate change: with default DM_ERR, driver model errors are
> now emitted by default, whereas today they are silent unless DM_WARN
> is enabled.
>
> While working on this I also noticed that a DM_DEBUG symbol already
> exists, and it works completely differently: it adds -DDEBUG directly
> in drivers/core/Makefile (proper only), so it's orthogonal to which
> log strings get compiled in. My inclination is to leave DM_DEBUG as-is
> for now and keep this series focused on the NONE/ERR/WARN choice;
> folding it in as a top "debug" tier (and adding a dm_dbg()) could be a
> follow-up, since it would change DM_DEBUG's scope and touch the
> Makefile. Note that DM_DEBUG and DM_WARN also couldn't both be
> selected if it became a choice member.
>
> So, what do you think? Is the DM_NONE / DM_ERR / DM_WARN choice the
> right direction? And does leaving DM_DEBUG out of it for now (as a
> possible follow-up) sound reasonable, or would you rather see it
> unified into the choice from the start?

This seems good to me. You might be able to de-duplicate your code to
just select which LOGL value to use, with your dm_warn/err() macros
then using that.

Regards,
Simon
