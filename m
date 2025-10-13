Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6E9CCD183
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 16:57:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FE1F836F0;
	Mon, 13 Oct 2025 18:57:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JrQwT+Kc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BC3483700; Mon, 13 Oct 2025 18:57:14 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BA43836C8
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 18:57:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7b6ac55cf86so3056608a34.1
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 09:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760374631; x=1760979431; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=L8n4/pCwgLBsQaIxvJyvZcY+3UAMQanB9Cnnu1mW4Ps=;
 b=JrQwT+KcqqxIc6RH+Ot22bCxdmwcXl8Vf8H85+xgAQ0L7Vvd17ZbuUPXwe5lY2d7IQ
 IzxujN+Y3ncmbJYrgmy95DCcEv46gYmWdBkGOpqmxSeYiAwbAHrpsyW9NKC7CZqovwu7
 ljbsnJ5L8K6KaELa7CInh3tnfTVhv8kLAnxSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760374631; x=1760979431;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L8n4/pCwgLBsQaIxvJyvZcY+3UAMQanB9Cnnu1mW4Ps=;
 b=mIOd01oFHQpcq7z2v6dwe/KovbUYQLimFW2uievcFUXX1KlXV6w1KPZsqkvVYfks56
 Y/dVIKz/0/l/C3WDdh3JcPHQhUYbfC/eE0VAaNXQg2ml1XfjWpvJdpZrz5/NCsr3x3gx
 M+nVXiylc6Or90zgAzPgrW1TzcdT3pWL0eeJ7tQUs9nUYJmCrHZw9ujJxEg+oOXbScvE
 jqlVIsu9sVliFd/0kk5SHYY1u3aHGJZZCoOe1ph5ZwY7BaCmNh42Q6KVWyihGES+KrRu
 9PnevT8IBZocCjve9h3QjlKbyyFHZvpOdgDugWJXT81hxVUEwOciDDeULfTvLR3qFz9G
 6E5Q==
X-Gm-Message-State: AOJu0YxdGBuAZb6Yy+ui3iZJt5pGqa6+GhE9WmlTv56jj0ar0fgUgOT6
 T2RIEsRPvvXzDekWBjdh5OJlGgvp4CpuOuv0geRz6Vhk7YjpXNhj7yyQX2+kkrEfVUs=
X-Gm-Gg: ASbGncuipZnXv43PpYZ2BWIKS46xhOX9m3YxB0vczK6w/6Oe9QSkHjoaGrnFf57DpF9
 c6moz53ElQS9+tA8CxYif+bJySFJaU2fzXM5kLDTi0P2G/xjMj9RuzYGFRulJr9O4cWQDGdvucd
 rAGQIkCv32pQNi6jFmV9CXoHhxUEJji9tPR0by27xx+jSOGpVQhVU22Sy01fMLab/uGNcXx96js
 1+Jib9/3fd6lgHFabuIJ1a6uQkLvJgl58mq3SyRlmtLn5Z80Dx5NL4JgavnoR5uxbHvSdOw/dOP
 HPB8nLZDtg7bhKnudQFb7lB8qwTnTAsvvJw0Kd0Bj7wFnfa4wS0wBevLZVipmyVkXDu/8ldRbCl
 R48LvajHzPYpIL2ZxpznTzDzRyRFUlrHR8Lu1o6PuX7VMwRZEdlLadkqvNTzh0afahZ4tyq+bBz
 8YXAl2
X-Google-Smtp-Source: AGHT+IG0QawEruEP5tiiEM7KkHOk5Co/OHovI40YiWrs2ClPDH2hG40HsMTmBkPrTP4WeG+eHnjg3g==
X-Received: by 2002:a05:6830:6507:b0:7ba:8107:d559 with SMTP id
 46e09a7af769-7c0df7be2a6mr10601330a34.26.1760374630688; 
 Mon, 13 Oct 2025 09:57:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0f90687e8sm3651237a34.15.2025.10.13.09.57.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 09:57:09 -0700 (PDT)
Date: Mon, 13 Oct 2025 10:57:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>
Subject: Re: [PATCH v4 3/4] boot: Add more debugging to iter_incr()
Message-ID: <20251013165707.GK6113@bill-the-cat>
References: <20251009092959.260121-1-sjg@chromium.org>
 <20251009092959.260121-4-sjg@chromium.org>
 <20251009173052.GQ298503@bill-the-cat>
 <CAFLszTi2HuZLmebJB+kUsL3_J+aqVdCdP5XFSEoY1Dy5C3E2wA@mail.gmail.com>
 <20251010143528.GZ298503@bill-the-cat>
 <CAFLszTh+K2Yr0OtZ_cNk9YrrGxg3KAv2SEppK=a-g1sw=hncLg@mail.gmail.com>
 <20251013141544.GD6113@bill-the-cat>
 <CAFLszTiOrWfEboYV+=xf0t1wdqeEhbo-SdjAquNCncMRxTur6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5SUsWpnhC5xLtUpO"
Content-Disposition: inline
In-Reply-To: <CAFLszTiOrWfEboYV+=xf0t1wdqeEhbo-SdjAquNCncMRxTur6A@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--5SUsWpnhC5xLtUpO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 04:12:03PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 13 Oct 2025 at 15:15, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Oct 11, 2025 at 08:19:53AM +0100, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 10 Oct 2025 at 15:35, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Oct 10, 2025 at 11:36:10AM +0100, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Thu, 9 Oct 2025 at 18:30, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Thu, Oct 09, 2025 at 03:29:54AM -0600, Simon Glass wrote:
> > > > > >
> > > > > > > This function is the core of the bootstd iteration. Add some =
debugging
> > > > > > > for the decisions it makes along the way, to make it easier t=
o track
> > > > > > > what is going on.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > >
> > > > > > > (no changes since v1)
> > > > > > >
> > > > > > >  boot/bootflow.c | 23 +++++++++++++++++++----
> > > > > > >  1 file changed, 19 insertions(+), 4 deletions(-)
> > > > > > >
> > > > > > > diff --git a/boot/bootflow.c b/boot/bootflow.c
> > > > > > > index 78df09f369d..de69e27bec7 100644
> > > > > > > --- a/boot/bootflow.c
> > > > > > > +++ b/boot/bootflow.c
> > > > > > > @@ -193,8 +193,10 @@ static int iter_incr(struct bootflow_ite=
r *iter)
> > > > > > >       log_debug("entry: err=3D%d\n", iter->err);
> > > > > > >       global =3D iter->doing_global;
> > > > > > >
> > > > > > > -     if (iter->err =3D=3D BF_NO_MORE_DEVICES)
> > > > > > > +     if (iter->err =3D=3D BF_NO_MORE_DEVICES) {
> > > > > > > +             log_debug("-> err: no more devices1\n");
> > > > > > >               return BF_NO_MORE_DEVICES;
> > > > > > > +     }
> > > > > >
> > > > > > Thinking more about what I said in the previous iteration about=
 git
> > > > > > blame history, ones like this should be log_msg_ret (the histor=
y on
> > > > > > "when did the test for =3D=3D BF_NO_MORE_DEVICES come from is u=
nchanged, but
> > > > > > now you can have debug statements when enabled).
> > > > >
> > > > > Yes we can add that as well, but I still want to have the log_deb=
ug()
> > > > > as this doesn't require enabling CONFIG_LOG_ERROR_RETURN. That fe=
ature
> > > > > produces a lot of output even in normal operation since it shows
> > > > > errors dealt with by higher level code. It is really only designe=
d to
> > > > > find the source of a particular error when you are stuck.
> > > > >
> > > > > >
> > > > > > [snip]
> > > > > > > @@ -228,11 +234,15 @@ static int iter_incr(struct bootflow_it=
er *iter)
> > > > > > >
> > > > > > >       if (iter->err !=3D BF_NO_MORE_PARTS) {
> > > > > > >               /* ...select next partition  */
> > > > > > > -             if (++iter->part <=3D iter->max_part)
> > > > > > > +             if (++iter->part <=3D iter->max_part) {
> > > > > > > +                     log_debug("-> next partition %d max %d\=
n", iter->part,
> > > > > > > +                               iter->max_part);
> > > > > > >                       return 0;
> > > > > > > +             }
> > > > > >
> > > > > > Shouldn't this be a debug message instead in the caller?
> > > > >
> > > > > I am trying to log_debug() every exit from this function...so you=
 can
> > > > > see the entry and then which path it took.
> > > > >
> > > > > >
> > > > > > [snip]
> > > > > > > @@ -326,8 +336,13 @@ static int iter_incr(struct bootflow_ite=
r *iter)
> > > > > > >       }
> > > > > > >
> > > > > > >       /* if there are no more bootdevs, give up */
> > > > > > > -     if (ret)
> > > > > > > +     if (ret) {
> > > > > > > +             log_debug("-> no more bootdevs\n");
> > > > > > >               return log_msg_ret("incr", BF_NO_MORE_DEVICES);
> > > > > > > +     }
> > > > > >
> > > > > > Then do we actually need both a log_debug and a log_msg_ret?
> > > > >
> > > > > Please see above.
> > > >
> > > > I guess my question is, but why? Is this something that's going to =
be
> > > > debugged frequently? Why doesn't every function have meaningful text
> > > > string log_debug messages, just in case? And then why bother with
> > > > log_msg_ret at all?
> > >
> > > I have found myself in this function quite a few times, trying to work
> > > out what it is up to, so I decided to add more debugging.
> > >
> > > Anyway, would you like to just drop this patch, or something else?
> >
> > I'd like to fix the underlying problem so that we don't have a similar
> > discussion on your next series. As yes, I think in general all of these
> > patches to add more detailed logging on top of log_msg_ret logging are
> > too much. And I gather you're debugging these problems on real hardware
> > where using some source level debugger with sandbox isn't an option?
>=20
> What is the underlying problem?

Patch and code churn (and so history churn) for no functional changes
and increased reviewer load.

> The debugging was useful with the EFI app where it is sort-of possible
> to use a debugger, but is a bit painful. I ended up comparing logs to
> figure it out. Debuggers are not easy when the function being debugged
> is called dozens of times.
>=20
> I can imagine it being useful when someone reports a problem with the
> iteration...we could just turn on the option and the person could post
> a dump.
>=20
> Anyway, I'm happy to drop this patch.

Thanks.

--=20
Tom

--5SUsWpnhC5xLtUpO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaO0vXwAKCRAr4qD1Cr/k
Cq6BAQDkZCPOiznsD1g+lYyLLwBOU/bPUlwaier659MhcnUNdwD/UQsmG31X7MFb
1DoHJ9ZqoYK1//fofapwGjBLx9tzJwU=
=Em0/
-----END PGP SIGNATURE-----

--5SUsWpnhC5xLtUpO--
