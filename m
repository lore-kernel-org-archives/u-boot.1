Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDF9C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 17:00:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47E7D88A02;
	Tue, 16 Jul 2024 19:00:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jwqE/HfI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6900688971; Tue, 16 Jul 2024 19:00:37 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F5AA887E3
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 19:00:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5c6661bca43so7919eaf.0
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 10:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721149232; x=1721754032; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BA2eSeHDgCvPBH+BgeFfZt+8HTUHQiusdcHtSd6pth4=;
 b=jwqE/HfIPMojxyaE+3H5Fb2BHylhgq7yiYKeAMuSKhX+E+G8llkt2dMt0vy5tkGjU3
 54AFtSHbRt6RAof3xB4Qk15tw7TzCnSTE8JNfhpVY/oOt0jELVkovubz0E6q9wXmnVn9
 j0w7O4m8xHJugHjYbGKYFM3OSzGCFPKB0KYc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721149232; x=1721754032;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BA2eSeHDgCvPBH+BgeFfZt+8HTUHQiusdcHtSd6pth4=;
 b=oXWXCkHlwPX31g1hxBXior+1el19Zm0fbjnkgUJ+u1oS59JqqsgkZkNSKMbH77gMdm
 UbNTxxtPd0TC8jPhD//8jQPAwVYrSb6f+wzbJo6V7CJxPeiFSkodNJ4Zb+85hfRnHJa2
 7oBTOTc0UtYJOzJcvQG7vVmMw5N59RAYwAa9BT/Q4Ng1XGsbj07R1QvUGlp5x0IZfJ0P
 v8FfjRdKACei6RsXf5eO0q20wpIWk6+C5b0KAa055Vuk4Flj6svJ1O2qC9PhT1Fl7YVB
 PW3aBHj5azI7f4NLOeAdwnOU2xXLN/X/le3y7G/yUazs0xSWMGUutfa9Nuq8NKZaPlwQ
 qq7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuI3+LsdSIb9R6wuod2uydbB/wN6QAPw4/FBbALUOPFcGYj9i6hAvVe/ImXz3iCoeHnBA6D6ax5yJ31N5WUfGf8W42zQ==
X-Gm-Message-State: AOJu0Yw5aSV8xXHfV4nsQlLcT5k1c6Ic14SQxk7b3biuk8aFgai0Rw+F
 TRAMq2t4d+W0kdZsJo4a/674EzWDIeFG2EBr2pp3tIma2arX0aKVmNkwcDPLBbk=
X-Google-Smtp-Source: AGHT+IGdPrarw70kJD1BZJjBqskGVIoX6a682iQmrx/5YQnZM2pro/DMmUCmQQuOMdu+3Df7b+7TcQ==
X-Received: by 2002:a05:6871:294:b0:259:cdf1:b8af with SMTP id
 586e51a60fabf-260bdffe1efmr2297557fac.46.1721149232253; 
 Tue, 16 Jul 2024 10:00:32 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708c0d01337sm1351563a34.61.2024.07.16.10.00.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 10:00:31 -0700 (PDT)
Date: Tue, 16 Jul 2024 11:00:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
Subject: Re: [RFC PATCH v2 41/48] efi_memory: add an event handler to update
 memory map
Message-ID: <20240716170028.GF561963@bill-the-cat>
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-42-sughosh.ganu@linaro.org>
 <CAFLszTiXtfFh3K8Ft1nTzBizSitk_dyK7n0BsRccNNe6TimFoQ@mail.gmail.com>
 <CADg8p97fwAvebfrANXwWc7At78wU59XXymTFWCvuaFHMGj+9zg@mail.gmail.com>
 <CAFLszTiAHSgkGjV6PWOu2nisKc678rpxBvQKuOZeisqCmeAXSA@mail.gmail.com>
 <20240715190534.GA561963@bill-the-cat>
 <CADg8p972kWS9DY_xmNm2uBAz5-y_LtSy0dq2eRTf5dJMCranCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="A3fheFAfAjVGGJ8N"
Content-Disposition: inline
In-Reply-To: <CADg8p972kWS9DY_xmNm2uBAz5-y_LtSy0dq2eRTf5dJMCranCw@mail.gmail.com>
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


--A3fheFAfAjVGGJ8N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 11:55:10AM +0530, Sughosh Ganu wrote:
> On Tue, 16 Jul 2024 at 00:35, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Jul 15, 2024 at 12:39:32PM +0100, Simon Glass wrote:
> > > Hi Sughosh,
> > >
> > > On Mon, 15 Jul 2024 at 10:39, Sughosh Ganu <sughosh.ganu@linaro.org> =
wrote:
> > > >
> > > > hi Simon,
> > > >
> > > > On Sat, 13 Jul 2024 at 20:46, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Sughosh,
> > > > >
> > > > > On Thu, 4 Jul 2024 at 08:38, Sughosh Ganu <sughosh.ganu@linaro.or=
g> wrote:
> > > > > >
> > > > > > There are events that would be used to notify other interested =
modules
> > > > > > of any changes in available and occupied memory. This would hap=
pen
> > > > > > when a module allocates or reserves memory, or frees up memory.=
 These
> > > > > > changes in memory map should be notified to other interested mo=
dules
> > > > > > so that the allocated memory does not get overwritten. Add an e=
vent
> > > > > > handler in the EFI memory module to update the EFI memory map
> > > > > > accordingly when such changes happen. As a consequence, any sub=
sequent
> > > > > > memory request would honour the updated memory map and only ava=
ilable
> > > > > > memory would be allocated from.
> > > > > >
> > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > ---
> > > > > > Changes since V1:
> > > > > > * Handle the addition of memory to the LMB memory map.
> > > > > > * Pass the overlap_only_ram parameter to the efi_add_memory_map=
_pg()
> > > > > >   based on the type of operation.
> > > > > >
> > > > > >  lib/efi_loader/Kconfig      |  1 +
> > > > > >  lib/efi_loader/efi_memory.c | 34 +++++++++++++++++++++++++++++=
+++++
> > > > > >  2 files changed, 35 insertions(+)
> > > > > >
> > > > >
> > > > > This is getting complicated and I don't believe it is needed.
> > > > >
> > > > > EFI should not be allocating memory 'in free space' until it star=
ts
> > > > > up. For the very few (if any) cases where it does, it can do an l=
mb
> > > > > allocation.
> > > >
> > > > EFI memory module is not allocating memory at all now. This patch is
> > > > adding an event handler for updating the EFI memory map, whenever t=
he
> > > > LMB memory map changes. All the EFI allocations are now being routed
> > > > through the LMB API's.
> > >
> > > OK
> > >
> > > >
> > > > >
> > > > > As to the lmb allocations themselves, EFI can simply call look th=
rough
> > > > > the lmb list and call efi_add_memory_map_pg() for each entry, whe=
n it
> > > > > is ready to boot. There is no need to do it earlier.
> > > >
> > > > So in this case, I believe that rather than adding code in multiple
> > > > places where the EFI memory module would have to get the LMB map and
> > > > then update it's own, I think it is easier to update the EFI memory
> > > > map as and when the LMB map gets updated. Else, we have a scenario
> > > > where the EFI memory map would have to be updated as part of the EFI
> > > > memory map dump function, as well as before the EFI boot. Any new c=
ode
> > > > that would be subsequently introduced that might have a similar
> > > > requirement would then be needed to keep this point in mind(to get =
the
> > > > memory map from LMB).
> > >
> > > That doesn't hold water in my eyes. I actually like the idea of the
> > > EFI memory map being set up before booting. It should be done in a
> > > single function called from one place, just before booting. Well, I
> > > suppose it could be called from the memory-map-dump function too. But
> > > it should be pretty simple...just add some pre-defined things and then
> > > add the lmb records. You can even write a unit test for it.
> > >
> > > >
> > > > This is not an OS file-system kind of an operation where performance
> > > > is critical, nor is this event(LMB memory map update) going to happ=
en
> > > > very frequently. So I believe that it would be better to keep the E=
FI
> > > > memory map updated along with the LMB one.
> > >
> > > I really don't like that idea at all. One table is enough for use by
> > > U-Boot. The EFI one is needed for booting. Keeping them in sync as
> > > U-Boot is running is not necessary, just invites bugs and makes the
> > > whole thing harder to test.
> >
> > Doesn't that ignore the issue of EFI being re-entrant to us? Or no,
> > because you're suggesting we only update the EFI map before entering the
> > EFI loader, not strictly "booting the OS"? In which case, maybe that
> > does end up being both cleaner and smaller? I'm not sure.
>=20
> And that is my concern here about having to update the EFI map at
> multiple call points, instead of keeping it updated -- I feel this is
> more prone to being buggy. And to add to this, there might be code
> paths added subsequently which might need an updated EFI map where
> this gets missed. The only downside to the current design is that it
> might be slower since the EFI map gets updated on every change to the
> LMB map. But I am not sure if the LMB map changes are going to be that
> frequent.

To me the question really is, do we have a single entry point to the EFI
loader that must always be used (and is before EFI loader must know for
sure it has up to date memory reservations) or are there two or more
points? If there's two or more points then yes, your current approach is
best as we don't want to introduce problems down the line. If there's
one (which is what I hope), then we can just make that entry point be
where the resync happens.

--=20
Tom

--A3fheFAfAjVGGJ8N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaWpykACgkQFHw5/5Y0
tyyW1AwAkd/5CbIicw9ZuEa4Ds3CP2N0wZVfMgTnCPT1DmLQgHinmTBim89KEZtg
GMBQWpAFd/byk641HBABqj5hYbz6cL7Yu1PNgbdxbpfyjn26MMfVqmKQ6M/5raTB
PrL2j3jWzfkj49vsTA/VSsOwY4M4raSQFJyMol/3fwhQMJuETwDY3yjRca61hVMZ
prRcv6iq2UeQIjQdoeFMUpJkb6mP5stihdNfbvZlGoJOkfe5XEHmlrmuf/lx2Xlj
fODUW75cNfrSReaMDdq8JJHdBZRAjN7R3DYD0aE3Sht9ZesCQ7+z+qPpb2KAtxm0
EtGvSPXHVURnvcfWX1XLMm5eY4SVHmGv0eAS6I7OwJuV1Td7TawCuNEB0Mb5ZOLL
nMLhfe9zzyhi/3Yh5zu+m51+nY5O7v+ohFcaoG6Tw9Utw9lSAH/paL0gKRB+vNhh
R8s5xYXxDCm+PTC96RL9DddZ//NitrfF0dnGtm19wQ25u4XZ63zq+VWidkiCKkNI
uUr1LSVI
=Ljtm
-----END PGP SIGNATURE-----

--A3fheFAfAjVGGJ8N--
