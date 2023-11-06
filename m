Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D818C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 19:51:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AA1986F42;
	Mon,  6 Nov 2023 20:51:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="csqyogzi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01D7A868AE; Mon,  6 Nov 2023 20:51:03 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7890868AE
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 20:51:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-41cc7379b23so31217291cf.3
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 11:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699300259; x=1699905059; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=be2Cud7RuN/CpVz12imqt3LlqY+apMy70Jgy/MaanEw=;
 b=csqyogziQ0+GaPDZky1VLT92vql9pWx4ktzCr/lpwJ5IYbGPZuZkO69Tw+dDUu0VhI
 /fBe2fbo2RT9/gpBvEGefX+liAjCfJ13sM1CtN2SKSAbCOGq+47SEjOkCmEbA3e66W7n
 Mh0kA8X4HLdQqjFb3av3FWXK7g/gx/wisVhig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699300259; x=1699905059;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=be2Cud7RuN/CpVz12imqt3LlqY+apMy70Jgy/MaanEw=;
 b=tdmdmuAh4r+dau8XgiXpSzCHF8/OZr6xT+lfTfVa5F/0IYj6WE0NYVZ/yDlXQUNd7A
 bh5BDlLFYlZm94q/mfPC6TILO18y+gOJGre5gTfbpZzqFIjLnwGUVL9EOBG7FFRHfCKY
 HByJSl1QM1VHuu0nl52SdAbVWsFx4JK3rL+yz8+DzYm6zyE+O39epIpv9txF1kNfoYVH
 vgoiX/8QS/LiTEdXyWRxFq/j+6niV6qDr07v267jYRunubDZPoNkvdnStiZJKgvVf6c3
 fo/vONaXIVEcbceVagxGS+xwh9Rn5yjxi9ko0jFEsPojxQOiRka+8LNaszoYlOkjLq5G
 HaYg==
X-Gm-Message-State: AOJu0YylGiuiCUfZEgZbrZG5W9u2Zt7RffklG0KLoj1MgDziBoLfduk9
 +h3bOrqPCwAc9RjOn4/MGk3mvg==
X-Google-Smtp-Source: AGHT+IGMSywJNSQRxq3KoCP65LhWzDivw2UFytQEReA+uqiPGPRURZ2KUTQlJ+TWBjPmvb/xtJHt5g==
X-Received: by 2002:ac8:5f88:0:b0:418:1f52:1421 with SMTP id
 j8-20020ac85f88000000b004181f521421mr37403954qta.9.1699300259375; 
 Mon, 06 Nov 2023 11:50:59 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 x3-20020ac87a83000000b004198f248e8dsm3683939qtr.76.2023.11.06.11.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 11:50:58 -0800 (PST)
Date: Mon, 6 Nov 2023 14:50:57 -0500
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: bootstd: Scanning for USB bootflow will remove existing SCSI
 bootflow
Message-ID: <20231106195057.GD496310@bill-the-cat>
References: <CAJaLiFw67ztCo5TY=TPQneYgE5q6RHnj_XbnukQD=qhec3oRdg@mail.gmail.com>
 <CAPnjgZ3T8TOQbQKuy3wwfgb2K3sG5RDQdZ2zOxYT62XgGmVezg@mail.gmail.com>
 <CAJaLiFwx0j6Knthtgdy-wGDxaHYDuYEUws2LAkt05stc3f3ZBw@mail.gmail.com>
 <CAPnjgZ1FAEDs-f01Q-RCAV=sMWq40cD5UDo9O6SbqTRazS9gQA@mail.gmail.com>
 <CAJaLiFzsJP5u5ziHW7U5_0uqeGdr4uxHRG7kso2K-jahqLKBsg@mail.gmail.com>
 <CAJaLiFyqr88c8L1Lg+99XnP4geebwqrdKhSV4_h9uf1Mjr94Qw@mail.gmail.com>
 <CAPnjgZ1vxy+hYpHaCGC=g2sFOK_xPCP4N_QFvxdO4xVb-SP+FA@mail.gmail.com>
 <CAJaLiFzLFOH08CGRt5QY4-keSuO=947_gF1meyRiMWz5H0gcyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JJq7WqGAgpciOb42"
Content-Disposition: inline
In-Reply-To: <CAJaLiFzLFOH08CGRt5QY4-keSuO=947_gF1meyRiMWz5H0gcyg@mail.gmail.com>
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


--JJq7WqGAgpciOb42
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2023 at 11:42:51AM -0800, Tony Dinh wrote:
> Hi Simon,
>=20
> On Mon, Nov 6, 2023 at 9:25=E2=80=AFAM Simon Glass <sjg@chromium.org> wro=
te:
> >
> > Hi Tony,
> >
> > On Wed, 4 Oct 2023 at 21:23, Tony Dinh <mibodhi@gmail.com> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Mon, Oct 2, 2023 at 12:25=E2=80=AFPM Tony Dinh <mibodhi@gmail.com>=
 wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Sun, Oct 1, 2023 at 6:22=E2=80=AFPM Simon Glass <sjg@chromium.or=
g> wrote:
> > > > >
> > > > > Hi Tony,
> > > > >
> > > > > On Tue, 26 Sept 2023 at 13:40, Tony Dinh <mibodhi@gmail.com> wrot=
e:
> > > > > >
> > > > > > Hi Simon,
> > > > > >
> > > > > > On Tue, Sep 26, 2023 at 4:37=E2=80=AFAM Simon Glass <sjg@chromi=
um.org> wrote:
> > > > > > >
> > > > > > > Hi Tony,
> > > > > > >
> > > > > > > On Mon, 25 Sept 2023 at 14:02, Tony Dinh <mibodhi@gmail.com> =
wrote:
> > > > > > > >
> > > > > > > > Hi Simon,
> > > > > > > >
> > > > > > > > Here is an observation during testing the bootflow command.
> > > > > > > >
> > > > > > > > If there is a SCSI bootflow, scanning for USB bootflow will=
 remove that existing
> > > > > > > > SCSI bootflow. To bring it back, I scanned for SCSI bootflo=
w again, and it was
> > > > > > > > back to normal. Perhaps there is some kind of indexing prob=
lem?
> > > > > > >
> > > > > > > Yes that's right. The 'botflow scan' command is not additive.=
 The
> > > > > > > first thing it does is removing existing bootflows.
> > > > > >
> > > > > > Thanks for clarifying that. I assumed it is additive, because t=
he
> > > > > > existing USB bootflow was not removed when I did a "bootflow sc=
an
> > > > > > scsi" immediately after (see the end of the log).
> > > > >
> > > > > Yes, but I'm not sure what is going on there. Perhaps it is a bug?
> > > > > When you scan SCSI it should not also scan USB.
> > > >
> > > > Yes, it looks like a bug. I think I can see the problem and am work=
ing
> > > > on a patch.
> > >
> > > Just to let you know, I'm out of time to work on this topic. I will
> > > revisit it some other time, if you have not already tracked it down.
> >
> > If you are able to use 'bootflow scan -l' in each case, then I might
> > be able to see what it is scanning USB, when you are asking for SCSI.
> > I also wonder if this bug may have been fixed due to other changes?
>=20
> I'm wondering about that, too. I will rerun the test with the master
> branch with debug trace. If we cannot see it, I'll do it again when
> other bootstd patches are merged. Right now I am not sure which of
> your bootstd patches I should apply to the tree for testing, do you
> have a list for that?

Right now the only outstanding bootstd patch I know of is your recent
one, as I was waiting for Simon's review (which he did today) before
merging and applying.

--=20
Tom

--JJq7WqGAgpciOb42
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVJQ6EACgkQFHw5/5Y0
tyzzWAv9EyVefQDh0aWVK9+OGvSZ0WLBOvtUqtupWxjT1IopZFV+5Yj9SsD3atV3
B3BicFf1a8PTUQ0ih4pvcpqt2DGQpiih6zTBDlYkX8to61zHgX6h5f5E2BV3hQRj
bixxeCsJfvS7VwRKVabuQK1fDgZZb1QRkd0or6jhwFRE9WpIaVKgDaiAu1Vd2A/J
MFDlIXQRH4hFZ+3ZSd5bDd4SSYfkeoRGi6vKozW/824ib5oROCZlUoZ53C5xn6KM
72TJsESXKxlYx4UDw/lnn3u9WXLdxRrdyb8qgKCNLYAdBF3eShCkvpL1yF5xDUiA
J7L+3CWZ6As/PUSftO1h8lG4tTaRUhHkw1Zot4qBqZnG0nMMyFNNKPOG0C3rDaxc
nnZVpzsYRurTe8lXWyd3Pt5RUU+pdBDrMlW75t4MN6lw7RC8NH1V3uxxGzZbfrgO
5IZVZG6+Bo9w2KxqJOgQW0VUbrApLdK3Y7EnYm0J/nu0iks/UhJpK+CHUwmm7Sbl
uz6I1ObR
=B3xs
-----END PGP SIGNATURE-----

--JJq7WqGAgpciOb42--
