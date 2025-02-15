Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F96CC021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 15:01:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C021680C6F;
	Sat, 15 Feb 2025 16:01:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YdHqNre+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2323380C83; Sat, 15 Feb 2025 16:01:24 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6271880756
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 16:01:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-221050f3f00so10600475ad.2
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 07:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739631680; x=1740236480; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XYgdxtJeqZvWdwIS9pScmEikpoSfrNmJRjXonCw2aeI=;
 b=YdHqNre+wlAu4kmx1D8U/rrtgLyq/t7Qmob90AR/+zReZhZU8Ix9Mzbkvw+dRJOl05
 +zcnkxoks3HL1x7QizV/CGEOaobclDbRyLkVBpDcWD1C9ohQQu3MdOQSBy/9t5PE0APB
 kiNh09J+wpbCpjQak4PCw8tGajIZEImUaSIaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739631680; x=1740236480;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XYgdxtJeqZvWdwIS9pScmEikpoSfrNmJRjXonCw2aeI=;
 b=TpSTV5Jq5cutLKxvzys4+O8UOoLK8XkFSVIf0DjjGXx/L7n8+BPPlgOYSftiWOZKBo
 +P2cStT+7ElMdLxn6PNJ2cekhqvO/Bx9fgVhQnBWeKnYl+CBMl69jkW1rzED0N3KYlw/
 r1LhgaJfuuN4fL58MJc5eMrS6VfHZMbaj98GVoQPY05kTyVrKuV4FqCAZRFMKToluQ0s
 EKB+Sg65o7Aipzz+JCY7oAzUr6MJ2q4yBCqgWsQQxvzLC+AOlMSVANavcRxcyyNGWRva
 Zm70YofY1DxhKl+t/Or8vimPMhAbsC4aU6F7YJ6Mn1AwAiS7ZiUR5MJGhKaWPNgy2jh/
 rMSA==
X-Gm-Message-State: AOJu0Yz4pJi57qzepRxxb/GHWida5QzOzMcU5wzGlGnnGAykDnE9aXko
 UcZ+bxMwSQV5QAPGKU8jrdEZ2QuQue1L/RFgkcXXx54sZQzWdmwBnICXKxGGb7Q=
X-Gm-Gg: ASbGnctBJuH1Zwen68SpCC7rcl5/17wt9uD34AAYyZUSgItKGebAcN3AAw/rfoloXUJ
 veWK8neXZx7axNhNUHMmfUr9uozrDoBX1x8DYMp9/xMM+sJjeeAg8Qn3CDMOphRPmb2Tx8JN+qz
 cZzoRztqdNz3FoNkF++EePu+7/5hktnW3h9Ivj19qQBku8Xh8Ssw5OfCZE16sZe0GH12EEndRTU
 dARXNnzTmaESyMS4ztWBvRdZxyKysNK8t5f7LyzeqtLz6sBVGjslb0XbBpsLpj6Sjo0e61OQBhB
 87XSXgvyG7bo6w==
X-Google-Smtp-Source: AGHT+IHP/+vs9A9goY67HdJ5jbkd94eEA2JNCt0WSFOFDZ++eOSJLIlS3x411uU2r6B6+VzZYMaY/Q==
X-Received: by 2002:a05:6a00:99a:b0:72d:710d:611c with SMTP id
 d2e1a72fcca58-732618fb538mr5436098b3a.20.1739631679877; 
 Sat, 15 Feb 2025 07:01:19 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324fb3a761sm3385557b3a.178.2025.02.15.07.01.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 07:01:18 -0800 (PST)
Date: Sat, 15 Feb 2025 09:01:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH v2 33/35] RFC: Revert "bloblist: Load the bloblist from
 the previous loader"
Message-ID: <20250215150116.GS1233568@bill-the-cat>
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-34-sjg@chromium.org>
 <20250210143305.GA1233568@bill-the-cat>
 <CAFLszTgc2GsN-O_7aq+pC_0xeJQjh-qa7EAnN1i3djp0ZO5g-w@mail.gmail.com>
 <20250211135944.GZ1233568@bill-the-cat>
 <CAFLszThU+r-F_OUSM2rWVScfvgBTSCjDzxrYi5iBaBh7WNqHKQ@mail.gmail.com>
 <CAFLszThvdHTKoV3aWMSNBEV6zeg_kO=ca=tK2RJe-Rf8_UYivQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+WKSugl9g1TzkN8p"
Content-Disposition: inline
In-Reply-To: <CAFLszThvdHTKoV3aWMSNBEV6zeg_kO=ca=tK2RJe-Rf8_UYivQ@mail.gmail.com>
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


--+WKSugl9g1TzkN8p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 05:11:45AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 15 Feb 2025 at 05:06, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Tom,
> >
> > On Tue, 11 Feb 2025 at 06:59, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Feb 11, 2025 at 06:10:54AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 10 Feb 2025 at 07:33, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sun, Feb 09, 2025 at 02:14:54PM -0700, Simon Glass wrote:
> > > > >
> > > > > > The logic of this has become too confusing.
> > > > > >
> > > > > > The primary issue with the patch is that U-Boot needs to set up=
 a
> > > > > > bloblist in the first phase where BLOBLIST is enabled. Subseque=
nt
> > > > > > phases can then use that bloblist.
> > > > > >
> > > > > > But the first phase of U-Boot cannot assume that one exists.
> > > > > >
> > > > > > Reverting this commit seems like a better starting point for ge=
tting
> > > > > > things working for all use-cases.
> > > > > >
> > > > > > Note: The work to tidy this up is apparently underway. For this=
 series,
> > > > > > a revert is the easiest path.
> > > > > >
> > > > > > This reverts commit 66131310d8ff1ba228f989b41bd8812f43be41c3.
> > > > > >
> > > > > > https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=3Df5ZKXNniOfV_-vF=
ryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com/
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >
> > > > > > (no changes since v1)
> > > > > >
> > > > > >  common/bloblist.c  | 64 ++++++++++++++------------------------=
--------
> > > > > >  include/bloblist.h | 10 --------
> > > > > >  2 files changed, 19 insertions(+), 55 deletions(-)
> > > > >
> > > > > We aren't reverting this change so if you plan to move this serie=
s out of
> > > > > your downstream fork you should start from that and stop posting =
it,
> > > > > that just leads to confusion.
> > > >
> > > > Who is 'we', and start from what?
> > >
> > > We, being the community, in here, the community mainline U-Boot proje=
ct
> > > tree.
> > >
> > > > My goal with this series is to have something that actually boots o=
n a
> > > > real board, so the bloblist changes are needed for that, particular=
ly
> > > > as the 'vbe' board in the lab tests this on the hardware. I
> > > > deliberately put these two patches at the end of the series so you =
can
> > > > ignore them if you'd like.
> > > >
> > > > But for now, as I understand it, there are no users of standard
> > > > passage in tree, so actually it would be fine to apply them.
> > >
> > > And you can ignore all the feedback you like for your downstream fork,
> > > sure.
> > >
> > > Part of the feedback in this series already was "Yes, we can clean th=
is
> > > up a bit more if bloblist will do its own thing instead".
> >
> > So I see that Raymond's patch is a significant rewrite of what is
> > there today, with multiple aims and changes. I would rather add my
> > revert and start from a cleaner place.
>=20
> Also, I forgot to mention that U-Boot doesn't seem to support the
> firmware handoff protocol in SPL? If so, could you point me to the
> code?

Yes, you never implemented handoff between stages in U-Boot via
register. That's not a use case for the platforms that don't use U-Boot
for SPL.

--=20
Tom

--+WKSugl9g1TzkN8p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmewrDwACgkQFHw5/5Y0
tyzt6Qv/TjKks2X502uP5UZ93DM5WiksJfjbSRAdOv7MWeMurLHK0ZwQHlishZBu
mZAUzRTHjO7fNS/6CTpUhSjdH+A9LCy+9hcXn/qo1psq21eJ3XXl/e75dv+67m9U
4vhfnoQIKiO7u3e0hpTEaMTC5BdXiwD1coeaX2kpNtWM8n6POUVW9mU90QN7rhwV
bTjrBRBRdPUcwvFso/d1I9EvIq06Jy/yzJRWYFOGIbQ1iUuik4Pf6G+7v/5Rg5pu
aFKtiWzlFygpB/vF8sZdcz3zJZSgTox/6eXA0lcCD2yRbXTzEImx/ocRPQsVfyZm
7SyDZ5NOKGA15Hgb39RDZGwvnZ5Sncf14NG92YBM3JXQVvJBUdLsdg9ruAfJSoX6
LR9dREmMWXzAQEjmuh92cXqYdM9MkGWAWWHEpkkT9XQ+bFF4SR1IJoJA0CrBHlxU
uuss+GqvFq+cGUDLxw9/YwLofEK9NxA3SeQcL2YH9UtqllZgqAAzFcxqk8bVHIhp
4Vj3mcpp
=MxeQ
-----END PGP SIGNATURE-----

--+WKSugl9g1TzkN8p--
