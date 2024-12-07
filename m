Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB26E77173
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 00:00:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3016890CE;
	Sat,  7 Dec 2024 01:00:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dnZSr3Ja";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6474C89175; Sat,  7 Dec 2024 01:00:39 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDF5A890CE
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 01:00:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-46686a258c2so24479481cf.2
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 16:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733529635; x=1734134435; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QGoBAO4mZLB3A0tFFulgXCao8oCUXZMZHlfQxIRiuSI=;
 b=dnZSr3JaFJF7kF1oLFeEeZGNslLCaH1+O3D0JwxoRShINfncMEzERBHj7l3ZmJ0jAq
 JAKMYDp8ACXJztE5xeTVz1my65Jbfre5EYIs3PAjbHQ2L6kKpl45BuJpFuph/nLogaFl
 GSa1qAOY0MF0Z/qYSxkKseEJ4NYhm0Yk1d/sM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733529635; x=1734134435;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QGoBAO4mZLB3A0tFFulgXCao8oCUXZMZHlfQxIRiuSI=;
 b=FBe0ORogn9nVg8BGX3RVZ7rH8GBIkrjsfPuEbOcT1gv9pe/n7n0IOT5aJmS37uiDiZ
 N40GkKE5VZLkzGk+mbPAZ+oIb5EPIsC6ViHpTbddmr7stjjfK5hctSA+1EsqPeEBSSC9
 AsOgQn93ZzVjtUb4yvTfDMy50MuzFrP/5Y3VQBnru6ZDNQJbTIgxTAwb9GXix3GYoz83
 7OVx2YfPxaqN69gFBT+uorUsDyTC1Vx2E8lB38sQqN7iODN748JLmfY62XONsDMZZZb1
 6pyi4EEcF5jlbftKxqn7+xsVyB4+AXDVKrZaLuydwoVMg8ngukBhQbaGsS2l/ffYWaRD
 ZO2Q==
X-Gm-Message-State: AOJu0YwerYMpXNslTrjpVnbRkT9PN6ncxrpLaxp238pZlAk/jt8/bDWs
 y8vhaadQStWpKbwpYlunAU/9b73NE2PxnIGoo5WP5sKqCi7i1WUj5TbSNBmBXwA=
X-Gm-Gg: ASbGncsLZv0ytfs2JzzBXLqqLtXbNv3BTFflRlk0YOD4vM0d9pkjLnxUuNzlBE71KqU
 4KfDcCDiNHcBLR1CTci+qRMA5S/KKKhx1ZWQJ5fB1ag8CkU/RI6m96W3Qzke2loesTUSwJOCJIB
 QwO7MKQBVfWpNbDl+jc9kjs7SZ/F2H7VzvwLspt1NNfABvjZemiKoAS9Byg7ASDw+w/4lVRlxmk
 22+29UJ1jzGTC4wv5ZURGG9riTecMBHm+g68m5Z8yeX1UpUj84=
X-Google-Smtp-Source: AGHT+IGmQvLeDeBY5hYROtS22ycWZSCTJH429XA4jeAXHgSH+JWf0Q5NakAnqACk+yDkVTGaxbAhjQ==
X-Received: by 2002:a05:622a:1341:b0:463:788e:7912 with SMTP id
 d75a77b69052e-46734ec714amr99947051cf.56.1733529635341; 
 Fri, 06 Dec 2024 16:00:35 -0800 (PST)
Received: from bill-the-cat ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467297d6c5esm26518621cf.82.2024.12.06.16.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 16:00:34 -0800 (PST)
Date: Fri, 6 Dec 2024 18:00:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>, Francois Berder <fberder@outlook.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Ivan T. Ivanov" <iivanov@suse.de>, Jan Kiszka <jan.kiszka@siemens.com>,
 Jerry Van Baren <vanbaren@cideas.com>,
 Jonas Karlman <jonas@kwiboo.se>, Marek Vasut <marex@denx.de>,
 Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Sumit Garg <sumit.garg@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: Re: [PATCH 0/3] rpi: Tidy up booting
Message-ID: <20241207000029.GC2457179@bill-the-cat>
References: <20241206131113.2865416-1-sjg@chromium.org>
 <20241206140852.GO2457179@bill-the-cat>
 <CAFLszTizXjXnc_P3RHpxbKj5qoEfW_Swrc6V6v6dS7kFUqH9CA@mail.gmail.com>
 <20241206194130.GX2457179@bill-the-cat>
 <CAFLszTjQchtBH+K5rRPdiOGgb1bYq3LFWH8BP7jw+noXEaC0GA@mail.gmail.com>
 <20241206235233.GB2457179@bill-the-cat>
 <CAFLszThCR3KG+AVCN_ZeVVmKXverd6g+qNnKrt5YbdTy6jEayg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="io8FP+JJD4uaBalv"
Content-Disposition: inline
In-Reply-To: <CAFLszThCR3KG+AVCN_ZeVVmKXverd6g+qNnKrt5YbdTy6jEayg@mail.gmail.com>
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


--io8FP+JJD4uaBalv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2024 at 04:56:31PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 6 Dec 2024 at 16:52, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Dec 06, 2024 at 04:41:37PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 6 Dec 2024 at 12:41, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Dec 06, 2024 at 12:17:49PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 6 Dec 2024 at 07:08, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, Dec 06, 2024 at 06:11:10AM -0700, Simon Glass wrote:
> > > > > >
> > > > > > > This series allows rpi to boot a compressed Ubuntu kernel wit=
h ~100MB
> > > > > > > ramdisk, by expanding the available space.
> > > > > > >
> > > > > > > It also tidies up some strange behaviour with the provided FD=
T, where a
> > > > > > > separate pointer is maintained to it, even though U-Boot has =
copied it
> > > > > > > and placed it in its own space. This avoids strange bugs wher=
e it
> > > > > > > accidentally gets overwritten when loading a file into memory.
> > > > > > >
> > > > > > >
> > > > > > > Simon Glass (3):
> > > > > > >   rpi: Update environment to support booti and large initrd
> > > > > > >   fdt: Allow expanding the devicetree during relocation
> > > > > > >   rpi: Use the U-Boot control FDT for fdt_addr
> > > > > > >
> > > > > > >  board/raspberrypi/rpi/rpi.c   | 20 ++++++++------------
> > > > > > >  board/raspberrypi/rpi/rpi.env | 10 ++++++----
> > > > > > >  common/board_f.c              |  6 ++++--
> > > > > > >  dts/Kconfig                   | 11 +++++++++++
> > > > > > >  4 files changed, 29 insertions(+), 18 deletions(-)
> > > > > >
> > > > > > My feedback here is the same feedback I gave the last person th=
at wanted
> > > > > > to update the Pi addresses, and I forget if they came back and =
did that
> > > > > > (and it's in Peter / Matthias' queue) or not. Disabling device =
tree
> > > > > > relocation is a bug and must be removed.
> > > > > >
> > > > > > After that, given the range of memory sizes available on Pi pla=
tforms,
> > > > > > allocating the kernel / initrd / kernel decompression buffer at=
 run
> > > > > > time, ala mach-apple would make life easier in the long run.
> > > > >
> > > > > Yes, of course, but for now, this resolves the problem and I don't
> > > > > believe it creates any other problem.
> > > >
> > > > Yes. I think you missed that:
> > > > https://patchwork.ozlabs.org/project/uboot/patch/20240723193430.305=
0251-1-walter.lozano@collabora.com/
> > > > is also outstanding and should solve the problem.
> > >
> > > No, it doesn't support decompression, although I have to wonder why
> > > that patch was never applied.
> >
> > See Peter's response elsewhere about having a lot of things to do and
> > not a lot of time. I know he's intended to pick up and post a Pi PR for
> > a while.
>=20
> OK, but let's drop that patch since it doesn't support decompression, rig=
ht?

No? No one has done all of the work required (remove fdt_high /
initrd_high) and this also solves the larger kernel issue.

> > > > > The solution should not be board-specific though. Once I have the
> > > > > bootstd files stuff is finished, I believe that bootstd will be a=
ble
> > > > > to do this and I plan to do this. Then the variables will be unus=
ed
> > > > > for rpi and we can just drop them for any bootstd boards.
> > > > >
> > > > > As of now, we have 390 boards using bootstd and 381 using distro
> > > > > scripts, so it is progress!
> > > >
> > > > Yes, it will be interesting to see what the future holds, and any o=
f the
> > > > solutions handle some of the trickier corner cases that lead to the
> > > > current situation. Or perhaps the best outcome is that in current t=
imes,
> > > > those corner cases don't really appear anymore (with 512MiB DDR bei=
ng
> > > > the lower bound for example on all the Pi families).
> > >
> > > Well rpi is a bit unusual...
> >
> > Sure, but not in this case? Lots of examples of multiple models with
> > different memory sizes, and especially with 32bit platforms smaller (by
> > current standards) overall DDR.
>=20
> I mean in the sense that it puts the devicetree in the middle of RAM.

Which and where? Or do you mean it being exacerbated by disabling
relocation (which is why I keep going on and on about removing that from
platforms that do it)? Most platforms will load to the "middle" and
that's why you must not disable relocation because it's only a problem
when, well, relocation is disabled and U-Boot says "Gee, you're going to
break but you told me you want that, so, alright then."

--=20
Tom

--io8FP+JJD4uaBalv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdTkB0ACgkQFHw5/5Y0
tyzpkAwAhGavxVaelsOfknR6TDPOfLZTW6Ge9zYqnybZ6ehcJYM0LgAQRrFRunUD
GDejrb4ZAKAHKUoVgnjfX6Bav81gKiefosNQpZibM8Tr098xJllPuehkijFapuaX
X8b+6N6L2bnCoejR7LZDLFViyaTdnpIVdKZgdpRv/T8oXaoW/WUOrPxlaHVI78TJ
I3eI73J7DnvrENkEvJC3KvqYNkmO/KXMietx+hoD5Sl99bii8jtXzBmehEvQVApu
PRmHwK6xc/XDieNi6MzSMmUXwr7e+q94kl4He8YctTgeNX+lZtt7DehLhLrn4bC5
FuNUruX84VrnDChDGvb4T925nNTQR5SJONADS0XMAQwKoUXR2QLGViu+CdumLFRi
hZY5Hiy5PUAarEKPrSrkH7Ytj44gIENQqI2aTsg5uoYTn0AeLWAEEZy5HBaFs+7t
bF/5PS3vEq6Uk/TkvfYVqqzxq0JwWl9JUIfuSfkobW3o8zjLL66hNc2f5xW4Ffbj
JWeyZIB1
=pQ1P
-----END PGP SIGNATURE-----

--io8FP+JJD4uaBalv--
