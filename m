Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87967C02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 15:01:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9DAF801B0;
	Sun, 16 Feb 2025 16:01:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="neJR/em8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60EBA801B0; Sun, 16 Feb 2025 16:01:32 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3D6F80104
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 16:01:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2211acda7f6so10960325ad.3
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 07:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739718087; x=1740322887; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=O9BYHKJD05WV6Q3J+6kIDtZEERhp8u/JdwD/TfJGHPM=;
 b=neJR/em8hnCGuAV6OBpnLvHDsUEX5z2I1zcNSCcEbRvMl/k0eb/YfM4aPACGCfYOxB
 dJwEf1Lv52B2GFnUkzHCQlf33cES+IMXKopLSN6tNaAe7HVgotwgLHoPsBATsa0H6guA
 ELmwcaiCmZ25qewCaT3uE8JZJokM0xCkCZGz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739718087; x=1740322887;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O9BYHKJD05WV6Q3J+6kIDtZEERhp8u/JdwD/TfJGHPM=;
 b=MJZ0ZKaUcJTt6+y2inBKbhTglr6dyETDSz8IVgNERbM6zGfGkJjWc7E3a3eRwnoO2n
 F4RThBPb9rQ/gGtcq48T73KaBQPxxKkZnhW53zrrqCnuJtQ4B9DMviqlBprGt8dgc0Cx
 A3HdP292ie/YIFTOFKcifbGuCZ0uKPdO1TGXMvjXgkViKRMcMunT7F5e+4v6Phgf9VNt
 GhTC1SidkAEoMM88z6u85AkGqp6VNMDoWynTv/e60nzOuhTkaQFUZk+NM5tgDUBAcClW
 c/tkLrDDwZOvMvQslTcexPc4h8BMhip7phVJTEQt0jFFlE4jfsrMeALQoCDUbWsgr8Ao
 Qmfg==
X-Gm-Message-State: AOJu0Yx/R0OyPfFhH6xl8FrCXcy8QQR6Be30z+VXGBmrk5EijukwGmBn
 QsF1tBMi2C9zFLodPmCst7KmuuNUVsFxVmWRCTp3tpr2SxN/dBcErS2sXlA5jVs=
X-Gm-Gg: ASbGncu1ATWNEtLWh8cnwYV2uJb3Nlec3ZwtKxrjCTKO6yQKf+AFwG3UPCZHAirojsR
 fjj9PV0UZ9fmMNXjtVGYqa1utAHRjXEuIra1M47mxCBt0XIR8nSL2aJlU7iDSeb984OFU1yMSNT
 FjQ3R1vI6Y1ktta4v2pLBBfnFOBSdpYJ+chRkjVFAfhAC6OSx0Tyiiq3z9jIuCBxaVfUtwQz8ag
 F2KHr6jJT1du+F/w6eTNaqW6TQc8B9XUX1b71Qx32CgQM4g4j7FjlWXGGVP6Glm8tai0l+H+TX9
 JFpz3pjWKkArDQ==
X-Google-Smtp-Source: AGHT+IHcPAfEGV+i58lZF6wleD3N+oWtIST3Vm2Mhh9vROMXH80znMIUScIk//lAB2ZCczHBqX4RNw==
X-Received: by 2002:a17:903:3d0c:b0:218:a43c:571e with SMTP id
 d9443c01a7336-2210402961fmr110212795ad.28.1739718087291; 
 Sun, 16 Feb 2025 07:01:27 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53499fesm56700085ad.34.2025.02.16.07.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 07:01:26 -0800 (PST)
Date: Sun, 16 Feb 2025 09:01:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH v2 33/35] RFC: Revert "bloblist: Load the bloblist from
 the previous loader"
Message-ID: <20250216150123.GX1233568@bill-the-cat>
References: <20250209211502.2299245-34-sjg@chromium.org>
 <20250210143305.GA1233568@bill-the-cat>
 <CAFLszTgc2GsN-O_7aq+pC_0xeJQjh-qa7EAnN1i3djp0ZO5g-w@mail.gmail.com>
 <20250211135944.GZ1233568@bill-the-cat>
 <CAFLszThU+r-F_OUSM2rWVScfvgBTSCjDzxrYi5iBaBh7WNqHKQ@mail.gmail.com>
 <CAFLszThvdHTKoV3aWMSNBEV6zeg_kO=ca=tK2RJe-Rf8_UYivQ@mail.gmail.com>
 <20250215150116.GS1233568@bill-the-cat>
 <CAFLszThi7DzdheY7Cp3zQSNsV-4a1GBvB=CVQczdyrXjBBuSOA@mail.gmail.com>
 <20250215182847.GW1233568@bill-the-cat>
 <CAFLszThDsf322WQ1GCSFNmj=41yhBhLEZisXEaSTyHYjzG6TmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cgXRweNi5yFvmnDD"
Content-Disposition: inline
In-Reply-To: <CAFLszThDsf322WQ1GCSFNmj=41yhBhLEZisXEaSTyHYjzG6TmQ@mail.gmail.com>
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


--cgXRweNi5yFvmnDD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 07:10:31AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 15 Feb 2025 at 11:28, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Feb 15, 2025 at 10:24:50AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sat, 15 Feb 2025 at 08:01, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, Feb 15, 2025 at 05:11:45AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Sat, 15 Feb 2025 at 05:06, Simon Glass <sjg@chromium.org> wrot=
e:
> > > > > >
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Tue, 11 Feb 2025 at 06:59, Tom Rini <trini@konsulko.com> wro=
te:
> > > > > > >
> > > > > > > On Tue, Feb 11, 2025 at 06:10:54AM -0700, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Mon, 10 Feb 2025 at 07:33, Tom Rini <trini@konsulko.com>=
 wrote:
> > > > > > > > >
> > > > > > > > > On Sun, Feb 09, 2025 at 02:14:54PM -0700, Simon Glass wro=
te:
> > > > > > > > >
> > > > > > > > > > The logic of this has become too confusing.
> > > > > > > > > >
> > > > > > > > > > The primary issue with the patch is that U-Boot needs t=
o set up a
> > > > > > > > > > bloblist in the first phase where BLOBLIST is enabled. =
Subsequent
> > > > > > > > > > phases can then use that bloblist.
> > > > > > > > > >
> > > > > > > > > > But the first phase of U-Boot cannot assume that one ex=
ists.
> > > > > > > > > >
> > > > > > > > > > Reverting this commit seems like a better starting poin=
t for getting
> > > > > > > > > > things working for all use-cases.
> > > > > > > > > >
> > > > > > > > > > Note: The work to tidy this up is apparently underway. =
For this series,
> > > > > > > > > > a revert is the easiest path.
> > > > > > > > > >
> > > > > > > > > > This reverts commit 66131310d8ff1ba228f989b41bd8812f43b=
e41c3.
> > > > > > > > > >
> > > > > > > > > > https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=3Df5ZKXNn=
iOfV_-vFryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com/
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > ---
> > > > > > > > > >
> > > > > > > > > > (no changes since v1)
> > > > > > > > > >
> > > > > > > > > >  common/bloblist.c  | 64 ++++++++++++++----------------=
----------------
> > > > > > > > > >  include/bloblist.h | 10 --------
> > > > > > > > > >  2 files changed, 19 insertions(+), 55 deletions(-)
> > > > > > > > >
> > > > > > > > > We aren't reverting this change so if you plan to move th=
is series out of
> > > > > > > > > your downstream fork you should start from that and stop =
posting it,
> > > > > > > > > that just leads to confusion.
> > > > > > > >
> > > > > > > > Who is 'we', and start from what?
> > > > > > >
> > > > > > > We, being the community, in here, the community mainline U-Bo=
ot project
> > > > > > > tree.
> > > > > > >
> > > > > > > > My goal with this series is to have something that actually=
 boots on a
> > > > > > > > real board, so the bloblist changes are needed for that, pa=
rticularly
> > > > > > > > as the 'vbe' board in the lab tests this on the hardware. I
> > > > > > > > deliberately put these two patches at the end of the series=
 so you can
> > > > > > > > ignore them if you'd like.
> > > > > > > >
> > > > > > > > But for now, as I understand it, there are no users of stan=
dard
> > > > > > > > passage in tree, so actually it would be fine to apply them.
> > > > > > >
> > > > > > > And you can ignore all the feedback you like for your downstr=
eam fork,
> > > > > > > sure.
> > > > > > >
> > > > > > > Part of the feedback in this series already was "Yes, we can =
clean this
> > > > > > > up a bit more if bloblist will do its own thing instead".
> > > > > >
> > > > > > So I see that Raymond's patch is a significant rewrite of what =
is
> > > > > > there today, with multiple aims and changes. I would rather add=
 my
> > > > > > revert and start from a cleaner place.
> > > > >
> > > > > Also, I forgot to mention that U-Boot doesn't seem to support the
> > > > > firmware handoff protocol in SPL? If so, could you point me to the
> > > > > code?
> > > >
> > > > Yes, you never implemented handoff between stages in U-Boot via
> > > > register. That's not a use case for the platforms that don't use U-=
Boot
> > > > for SPL.
> > >
> > > If you let me own bloblist, I'll own it, but for now I am staying awa=
y.
> >
> > Would you be working against mainline again, and not breaking standard
> > passage (as it's been split off) ?
>=20
> Sure. The only reason I have my tree is because (I feel that) parts of
> U-Boot have become no-go for me. So if you'd like me to maintain
> bloblist again, I would be delighted to do so.
>=20
> Steps I see:
> - Get my boards working again

Already done. I'm waiting for Kever to pick up Jonas' small series that
brings back output prior to that statement from DM.

> - Add standard passage from SPL->PPL

By who? PPL (and xPL) already reads standard passage via register.

> - Figure out what to do on x86 to also use standard passage

Standard passage, or bloblist?

> I'm not quite sure that BLOBLIST_FIXED can be removed, as it needs
> more thought. The phase that creates the bloblist initially needs to
> know where to put it.

When a phase is running it already has to know what memory is available
right now or not, and can allocate as much of a list as it needs now.
Later phases can move/grow it.

--=20
Tom

--cgXRweNi5yFvmnDD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmex/b8ACgkQFHw5/5Y0
tyyJAAv/aGYYPFLOB+rxfI8I1ePot8CUhBVsMi4apz2GxSQZJ6YutstT2yaDhWVI
MkqTI6wqgIgLHTUehdGjBc5hSBt36X9ex9EnvDOKHdQiyWU/809D8887YurpJ10+
nzhULKYtg0t+9CXau1uxuvkM4jqEn7YMmgNpnHTTEPqJV0TrwqHrdDCHth8CtLb7
k5+IEDk867YsctQoOvsd6V4N+lyB7iVvXssTNo7ybC3MG0Zk5x4l2i0Bxwiv0ADN
hTeDq7TG39MtdfjfrBbaic93iFe3diDO6MYjg8TIVFghA+swWXv/dLzDte2lwdVM
ZaMzN0r7kV37P6EaK2M3oh1seK522QPrLZys3O5Ke3U856HoPX6o8jw+5IdabZJM
5jEpFQHCtcTk+KFVC2b6CXDMt0PNwhau5r57rPD+IKpzWHIcQ38W1eKZ/FsVd+L4
v+dOZ9W8rxOnYk0+eEOQaXean9/VkR6JIxJO1jWBjnx2W2YVaKe9xCiWGUPDK5UT
DuTwXOnb
=x3LR
-----END PGP SIGNATURE-----

--cgXRweNi5yFvmnDD--
