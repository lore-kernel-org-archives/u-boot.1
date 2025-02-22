Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA4EC021B3
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 00:08:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0176A80F5C;
	Sat, 22 Feb 2025 01:08:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XVIsmjzI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB33D80F67; Sat, 22 Feb 2025 01:08:26 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B8DB806FE
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 01:08:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2210d92292eso82048825ad.1
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 16:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740182902; x=1740787702; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=081dyMZE6//nmsKnI/HBGS26R+jeZaTHIxId/2LDu9U=;
 b=XVIsmjzItt9GhAS/xkR5TeyePyOIVUUfAPqKQ6N9yV8g0f9MTXWA0Xj/ecrDff/wNR
 VkoRcfwWmhugm42JBfWc/eOxdnmHp+iWmeBZgQeWyFbmMjIXfAJHZ04M9BSUJskIHDU9
 nbURIRKgJhDaQwHsEZ0wCO+oU0tuGNa03agYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740182902; x=1740787702;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=081dyMZE6//nmsKnI/HBGS26R+jeZaTHIxId/2LDu9U=;
 b=p17znVrhDcI72kc01RufxSh9YKJOpPi//vXSaHeL5M6X1Dslz8K2s0LEs+paSQ4ZlW
 1R4Ti+B9xjzZ8x2axRZ8l/W5RPpE0rhHCs0AEdYIseNvFZ1elJJGRU7lGWQVsjUcxF0O
 wAMaDz9q23vV2ffzbIPHQdfXDSiWpNgUS0RKDtcQAlegvjaruSj7uY/MzbidtvphQJZp
 UApuTEn8lYYQjyNkU9NTL7L3XtsY2tJ9lTa5U8sGRsQgQRvoeLHb2G2hSRpjCBuvlRMe
 oAfzx3qzipaW617DrLBPKnorLgWwQmJBJyi3Hcq8Tlz2np5YUP4PD3Z51KWIR1O+i/WP
 Kl2Q==
X-Gm-Message-State: AOJu0YxcCGMJdzr8c7bAeIZ1e0HDVDW4A1SeOdVz3yHIY0TRgTvU9pyc
 KIidhO3D7jUH35tKeV3TOPHaew72R1U3cTCG5aqtv+M3HldpCSUaxzanwmrNFFc=
X-Gm-Gg: ASbGnctZTfpF0INaJKZNX+CNIDkxgKkzCD1q4p21TMiexDm7hlYLDgO10pDxsafoVFU
 cRU8CvscMOW0k6XzqQQQct6Q3cI7yd0pM7qmvqFnPK0fkWL5EaV++UvZRI4Uxg0IFJG3Hn1ffKN
 N7q6b7IdtW4HntHr/OZw4hhzWRKVDg97FP6k1uUoJTJqdWdPbnP7f9vlsEjEV1JsFDtgWK02+7w
 e+8XkpauuIlH+Dg+FAc0sJD00jhJ8yFhmZtfSKdDhwrCbSPNtgIZNIC4PpcWHn0zbDi1Kjv5VyB
 SbK/3wki1burj9PXsxnJgTER
X-Google-Smtp-Source: AGHT+IHVuTYVCm4Xfpy3LuUARVnf+RkUvW9fsoaU6upYKBR6Yd3Upa0K+xR8EqK0Wu7eHlSJ0T1KfA==
X-Received: by 2002:a05:6a21:62c1:b0:1ee:ced0:f09f with SMTP id
 adf61e73a8af0-1eef3d9200cmr11141982637.30.1740182902556; 
 Fri, 21 Feb 2025 16:08:22 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-addfbb144b1sm11723057a12.15.2025.02.21.16.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 16:08:21 -0800 (PST)
Date: Fri, 21 Feb 2025 18:08:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 1/2] CI: Move default image under global defaults
Message-ID: <20250222000819.GX1233568@bill-the-cat>
References: <20250215144147.GM1233568@bill-the-cat>
 <CAFLszTi3D4g5LadMvaxEAn3uUu2V5L1wKCEBLu8=dzicb0Rbww@mail.gmail.com>
 <20250215181227.GT1233568@bill-the-cat>
 <CAFLszThJ11Ph-8zaNV_D0u7-UD18XtULm0kwhgQmMAj5xFgHtA@mail.gmail.com>
 <20250216160744.GA1233568@bill-the-cat>
 <CAFLszTiihyuqFBcdacu+2wfd3ivDzjf4nVqfU0BgKUc0u1s6=Q@mail.gmail.com>
 <20250216215230.GE1233568@bill-the-cat>
 <CAFLszTiydBJ8BseNHNJO+tf21QwPSJ-Od1Jnp6QWUTsPOmgFdg@mail.gmail.com>
 <20250217141409.GJ1233568@bill-the-cat>
 <CAFLszTij+suCqQ+c0bmTEsHEu6+xUWWCMEG-gJ5DYbjhv0oJGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mgKImhwjtvWInT+v"
Content-Disposition: inline
In-Reply-To: <CAFLszTij+suCqQ+c0bmTEsHEu6+xUWWCMEG-gJ5DYbjhv0oJGg@mail.gmail.com>
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


--mgKImhwjtvWInT+v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 04:42:09PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 17 Feb 2025 at 07:14, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Feb 17, 2025 at 06:14:06AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sun, 16 Feb 2025 at 14:52, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sun, Feb 16, 2025 at 12:39:34PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Sun, 16 Feb 2025 at 09:07, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Sun, Feb 16, 2025 at 07:10:12AM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Sat, 15 Feb 2025 at 11:12, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Sat, Feb 15, 2025 at 10:21:16AM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Sat, 15 Feb 2025 at 07:41, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Sat, Feb 15, 2025 at 04:59:40AM -0700, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Mon, 10 Feb 2025 at 09:25, Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Thu, Feb 06, 2025 at 03:38:55PM -0700, Simon Gla=
ss wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > > This is a global default, so put it under 'defaul=
t' like the tags.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > > Suggested-by: Tom Rini <trini@konsulko.com>
> > > > > > > > > > > > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > > > > > > > > > >
> > > > > > > > > > > > Please make v4 include the way you redid the second=
 patch and be on top
> > > > > > > > > > > > of mainline, thanks.
> > > > > > > > > > >
> > > > > > > > > > > That's enough versions for me, so I'll let you do tha=
t, if you'd like.
> > > > > > > > > > > It probably doesn't affect your tree as not as much i=
s done in
> > > > > > > > > > > parallel.
> > > > > > > > > >
> > > > > > > > > > I am disappointed.
> > > > > > > > >
> > > > > > > > > I'm sorry to disappoint you.
> > > > > > > > >
> > > > > > > > > The background is that I looked at the difference between=
 our trees
> > > > > > > > > and the gitlab files are quite different. My CI runs take=
 about 35
> > > > > > > > > mins and it seems that yours is around 90 mins. I would l=
ike to reduce
> > > > > > > > > / remove the delta (for time and patch diff), but I'm not=
 sure how.
> > > > > > > > >
> > > > > > > > > My goal is to get CI runs to below 20 minutes, best case.
> > > > > > > >
> > > > > > > > I'm sure CI could be quicker still with a number of faster =
runners. But
> > > > > > > > if you can't be bothered to make changes against mainline, =
what is the
> > > > > > > > point?
> > > > > > >
> > > > > > > If you recall, I was working with your tree and had various i=
deas to
> > > > > > > speed things up, but you didn't like it. So I've had to do it=
 in my
> > > > > > > tree. This is not about more runners (although I might have a=
nother
> > > > > > > one soon). It is about running jobs in parallel.
> > > > > >
> > > > > > And I wasn't sure more runners in parallel would help (as it wo=
uld slow
> > > > > > down the fast runner which is what keeps the long jobs from bei=
ng even
> > > > > > longer) as much as adding more regular runners would (which we'=
ve done)
> > > > > > and noted that in the end it's a configuration on the runner si=
de so to
> > > > > > go ahead. And I reviewed and ack'd the patches here which expos=
ed the
> > > > > > issues your path revealed. I just can't apply them because they=
 need to
> > > > > > be rebased (and squashed).
> > > > >
> > > > > You have already added tags for things, but (IIUC) they are aroun=
d the
> > > > > other way from what I have added.
> > > > >
> > > > > I have a tag called 'single' which means that the machine is only
> > > > > allowed to one of those jobs. The world-build jobs are marked with
> > > > > 'single'.
> > > > >
> > > > > For other jobs, I allow the runners to pick up some in parallel
> > > > > depending on their performance (for moa and tui that is 10).
> > > > >
> > > > > So at most, there is a 'world build' and 10 test.py jobs running =
on
> > > > > the same machine. It seems to work fine in practice, although I w=
ould
> > > > > rather be able to make these two types of jobs mutually exclusive=
, so
> > > > > that a runner is either running 10 parallel jobs or 1 'single' jo=
b,
> > > > > but not both. I'm not sure how to do that.
> > > >
> > > > So unless I'm missing something, in both cases the bottleneck is th=
at
> > > > for world build jobs you don't want anything else going on with the
> > > > underlying build host. You could register 10 "all" runners and 1 "f=
ast
> > > > amd64" runner (and something similar but smaller for alexandra). If=
 you
> > > > update the registrations on source.denx.de can you then shut down y=
our
> > > > gitlab instance?
> > >
> > > I've put a tag of 'single' on things that should run on the single-job
> > > runner. Everything else can run concurrently, e.g. up to 10 jobs. So I
> > > have two runners on the same host. E.g. tui-single has 'limit =3D 1',
> > > but 'tui' has no limit and is just governed by the 'concurrent =3D 10'
> > > at the top of the file.
> >
> > Yes. And you could move those runners to the mainline gitlab. There is
> > no "single" tag, that would be the "all" tag. And "tui-single" would be
> > "fast amd64".
>=20
> They are still attached to the Denx gitlab. Nothing has changed on my
> side. I'm not sure that your new tags are working though. I have a
> feeling something broke along the way when you made all your tag
> changes. One of my servers makes a bit of noise and I haven't heard it
> in quite a while.

There's a few of your runners that are "stale" and haven't contacted
gitlab in a long time. I'll double check the tags tho.
=20
> If Denx would like to give me access to their gitlab instances, I'd be
> happy to play around and figure out how to get it going as fast as my
> tree does, and send a patch.

I'm not sure what you mean by that? The instance itself?

> I also have another runner to add.

I'll contact you off-list with the token.

> > > From my side, I have found it helpful and refreshing to have a gitlab
> > > instance which I can control, e.g. it runs in half the time and if my
> > > patches are completely blocked by Linaro, etc., I have an escape
> > > valve.
> >
> > Yes, and I have no idea what any of that has to do with anything other
> > than leading to confusion about what tree is or is not mainline. Since
> > you own u-boot.org and ci.u-boot.org is your gitlab and
> > https://ci.u-boot.org/u-boot/u-boot/ is your personal tree.
>=20
> For now I am working with my tree, so that I am not blocked by Linaro,
> etc. but as you have seen I can rebase series for your tree as needed.

And you're not addressing my point about using the project domain for
your personal tree. That's my big huge "are you forking the project or
what" problem.

--=20
Tom

--mgKImhwjtvWInT+v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme5FXMACgkQFHw5/5Y0
tyzbawv9GfQmmvlgXlEis3ApBrosRAao4aN37iTRMrNxSYqi40C3+2NIEZEHnTjJ
ps/e0ghzlSYAqLyd7u6UDnpa+pU9fciTC+nCWsfVeGKrXiLfvLuQPPYnr01kXUWd
do1Oep11w+HRNozB7BC05qt/xdxatC0w8+ARwWMn0Pvi4fwnbjXBJdjiD6jeCjn2
0Y5Hc7cfxPEbxpoPtHV7+yLKD9xIqf1NztBe+t0z8pf92PziumObcfq/zlf0v2Xu
HNG7CWy/FvVAhZA6dZIdBNJCbamwzRxVk7k2HjjSsjGKMSbsAfCeK8WIkjO0SgG6
Q4mFPdaU69Cn7wbpPZQ+L1neCDAhpJgQrfKFgW2uTuEzj8fCuJvGXdowLA7F5v76
JuOVbz5dPm8xxB7s+ue8BQXdwFX9+C26O4E1gMwqfLj00EYl20gBc1tTA9PaKo+0
mEacX0Mld9BfMeVHP5hi0aZpB4lLToDSX4gfftI06MbJ/7HYYl5u7PaQOcxfrnSv
TpXeCvBR
=Ff9w
-----END PGP SIGNATURE-----

--mgKImhwjtvWInT+v--
