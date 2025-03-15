Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B74C28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 13:58:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AD8F80C93;
	Sat, 15 Mar 2025 14:58:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SdMsG38c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1596980F16; Sat, 15 Mar 2025 14:58:01 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8301809A4
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 14:57:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-476964b2c1dso20587251cf.3
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 06:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742047076; x=1742651876; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CetDGquJ9vowBIgxC5JgUjvLrt/FK701CaePESKC1Ks=;
 b=SdMsG38cyy89SUIsqbu5unqmMDLDorWVgmPb2g4ouKFiXm675nct4FAiS9crx1sCMY
 fW1KrCsWyG1xwVrkqu/n8tg4u6JlDEm5f7WpuWPWkat8M1bcTvYrbtjQ2phE4K7CXvUJ
 aYt4CAbJ+tVDEHZCoChQobrRBoechR5p3fNrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742047076; x=1742651876;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CetDGquJ9vowBIgxC5JgUjvLrt/FK701CaePESKC1Ks=;
 b=UOcvsTqyWRdO1G8mSFSb8Gde5uFxab1C9eATfjoRuEFn0BkX3pdAhsN8eHLg3Hxtel
 G/d1ljkuu3Kp9FNsRVOGGVr9TlUhqWeVHuTOFmVBUdevezuKk5Pewu5qRgF3enqOv4eo
 p81jy3j+RcdrWtflqab2ZzBXpGc0MS0qABlDg5Bx7g/YvmitopGZeWi4qV8lAlQJuYqg
 2PhJHNKKyXkvfky07WfF+nyA2Yhp4rdtzNsQyffpOlbRWRof+w3X2pJC14k9TAbV11A2
 sPuUrv3enVJBc2AYJGJ6k7JdRzkClr9Fe++21t89fsls28hVnJJXrrJEW4dDoWyHdADB
 CYxg==
X-Gm-Message-State: AOJu0YyfbKXVuwlV32CoQQz0btGRMDNf5veutHv9YQKM1l8OmoA5uDb5
 lYC7L0vPpirzodYwPsBI370wWpql1M8R0eOl1+922h8Xun/+JlLZNTW5Jo/9gpc=
X-Gm-Gg: ASbGncvt27+ymcc2bP4PYDHCW+DfxffIXJnxxv/0s1G0KMUq4DgD3tGRwAZL5OsdMH6
 6vlOHB5LHU+TSUUYNewM7ujuIKyI+3211DhIRhPhffMxl1P0iF5kus6AkIfC49jxSyvAEFfMzqv
 0Be3+KY0Yrb10NycBJzR4GsX71xsV+ER/B/Lcjpfg2J1FQF/CETsfqtnJFxY9eYRl+s52+wZzxi
 rsjBRQ5g6iZvlsitw0Nzi9rRojfjZ7fiSQhbsD5PqA92r2+k0nFwhMD1Se/tlCj+IBUTIZCNcU+
 sSvZ6wOfOQ+VD62NyacDVF7B6jTrGMANI+pNYyQl3yFavw==
X-Google-Smtp-Source: AGHT+IEcFfVHis7jcwe28FL8LSbnaqGDNdTJd8NalM/dgedLnqZMfQUDdWPlaZ+1PuC/96ZDIIQTdw==
X-Received: by 2002:a05:622a:438a:b0:476:6a3d:de44 with SMTP id
 d75a77b69052e-476c813f216mr72441371cf.18.1742047075913; 
 Sat, 15 Mar 2025 06:57:55 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb85d68csm34564101cf.81.2025.03.15.06.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 06:57:55 -0700 (PDT)
Date: Sat, 15 Mar 2025 07:57:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Julius Lehmann <lehmanju@devpi.de>, Love Kumar <love.kumar@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Philip Oberfichtner <pro@denx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Weinberger <richard@nod.at>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 00/47] x86: Improve operation under QEMU
Message-ID: <20250315135749.GI2640854@bill-the-cat>
References: <20250306160428.3041057-1-sjg@chromium.org>
 <20250307142255.GL2640854@bill-the-cat>
 <CAFLszTgtYsVQW-kETzUAdvJvAT6fN_53TeoN7o8wu52Ze3u56Q@mail.gmail.com>
 <20250314160652.GS2640854@bill-the-cat>
 <CAFLszTjGV==WftDU6C=S8VB28QJLvFJGS0H3=PKwTCjkZvNibQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jhlRjx2apgIVsQIc"
Content-Disposition: inline
In-Reply-To: <CAFLszTjGV==WftDU6C=S8VB28QJLvFJGS0H3=PKwTCjkZvNibQ@mail.gmail.com>
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


--jhlRjx2apgIVsQIc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 12:54:25PM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 14 Mar 2025 at 16:06, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Mar 14, 2025 at 02:44:35PM +0000, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 7 Mar 2025 at 14:23, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Mar 06, 2025 at 09:03:27AM -0700, Simon Glass wrote:
> > > >
> > > > > U-Boot can start and boot an OS in both qemu-x86 and qemu-x86_64 =
but it
> > > > > is not perfect.
> > > > >
> > > > > With both builds, executing the VESA ROM causes an intermittent h=
ang, at
> > > > > least on some AMD CPUs.
> > > > >
> > > > > With qemu-x86_64 kvm cannot be used since the move to long mode (=
64-bit)
> > > > > is done in a way that works on real hardware but not with QEMU. T=
his
> > > > > means that performance is 4-5x slower than it could be, at least =
on my
> > > > > CPU.
> > > > >
> > > > > We can work around the first problem by using Bochs, which is any=
way a
> > > > > better choice than VESA for QEMU. The second can be addressed by =
using
> > > > > the same descriptor across the jump to long mode.
> > > > >
> > > > > With an MTRR fix this allows booting into Ubuntu on qemu-x86_64
> > > > >
> > > > > In v3 some e820 patches are included to make booting reliable and=
 avoid
> > > > > ACPI tables being dropped. Also, several MTTR problems are addres=
sed, to
> > > > > support memory sizes above 4GB reliably.
> > > >
> > > > Do you plan to rebase the prerequisite series' this requires so tha=
t it
> > > > can be merged?
> > >
> > > Here's my understanding of where things are:
> > >
> > > 1. You rejected the membuf series and my replies to try to resolve
> > > that haven't gone anywhere yet. So your tree doesn't have any tests
> > > for that code and still has the old naming.
> >
> > https://patchwork.ozlabs.org/comment/3473898/ is a well thought out not
> > gratuitous summary of why the series as it stands is a step in the wrong
> > direction. Tests are good. They're not a reason to pull an otherwise bad
> > series. This series should be rebased to not depend on that series. The
> > tests from the other series should be split out.
>=20
> It's not a bad series, unfortunately. I replied with my own comments
> and I stand by them.
>=20
> I don't mind if you want to drop the #ifdef (which shows how a flag
> could be used and the code-size impact). But other than that, I am
> firm on this for now. I've already applied it to my tree and a membuf
> implementation with tests and without a power-of-two limitation is
> important for my current work on distros and expo.

Well, you need to rebase this series without that then as I'm not going
to take something another long time project contributor said was wrong
and offered lots of constructive feedback on.

> > > 2. I sent the first part of the PXE series so you could apply that.
> >
> > Yes, I should be applying that next week.
> >
> > > 3. You rejected the second part of this series because it didn't
> > > include support for lwip without cmdline. I offered to handle that
> > > case later but I'm pretty sure you rejected that too.
> >
> > That's not how I would characterize it, no. I said you should probably
> > focus on sandbox + lwip, since you're the sandbox guru and ask Jerome to
> > do the net_loop-alike thing, since he's one of the network custodians
> > and the lwip person. I was trying to direct you to where your efforts
> > might be most useful but if you insist on instead doing the
> > net_loop-alike part and Jerome ack's it, that's fine.
>=20
> As you know there have been many arguments from the EFI guys about
> sandbox and you have already rejected my sandbox-focussed EFI-memory
> series for your tree. If I were actually a guru, that wouldn't have
> happened.
>=20
> I see that Jerome has created some tests, which is good.
>=20
> So really, you should consider applying the full PXE series so that
> Jerome can build on that and add support for non-CMDLINE PXE in lwip
> in a way that you would like.

I saw that Jerome posted sandbox for lwip as well and was pleased. You
can pickup whatever is left and move forward once both your current
series and his have been merged.

> > > 4. This series is now marked 'changes requested' but the only feedback
> > > I see is in the RFC patch.
> >
> > Yes, rebase to something that can be applied is a change I've requested.
> > Because my feedback was "Do you plan to rebase the prerequisite series'
> > this requires so that it can be merged?". I would have otherwise merged
> > it by now.
>=20
> OK I sent a PR.

Eh? v4 as-is needs to be rebased to mainline. That you didn't make it
against mainline but instead your tree is why this wasn't merged
already.

> > Patchwork reflects mainline status.
>=20
> OK. I am finding it more and more slow and painful. Since we are
> talking about Patchwork, I noticed some patches assigned to me in
> there, so I've assigned them to you. I'll try to look there more
> often.

I guess you missed the email where I told you what was assigned to you
in patchwork and could easily be put in a pull request by you to me to
get to mainline.

--=20
Tom

--jhlRjx2apgIVsQIc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfVh1AACgkQFHw5/5Y0
tyzlDQwApFLVYTfrRgYzcIKhfRQb+us/ZxgFtx/TBQ9y1qk9m74YCITHzo/d+6Y8
R/KJTaOpTj0JEJvO8aoGh/TA/Iib1fNCWL7QJMN8C6zX7yjRTNI7nWQo7PDZESGb
Kxpt1xkNQ3z8R2yQPSqkoWrwxhnmyAJPferpKLz+TTiYdYw5SrzI7TKndCjHAKAk
OAtDFKy9/a4AbCWFM29wMFOz/MTQ32A4ohLcEOt+9ziYexHpzm0kEsTNC8tdHKD1
+/VCmrerbqMzPUooFIx8sq5awC4TddxEhDmKrv2pvcktCxrg4LQRRKLYx8atFwq/
86QeDua80xDr0pjPnDdnhiHlbRJr4JDgXIyQP1MVqNwHU/MUx8npALx9ycGZPFfB
hrzZIYFvPEJXOH55xfCRF/b2Qu4iJgwZl6UhGuxkRPDUdrgFhO01K0Kso4IGyfWa
28hIuGBYJQQOeG/XiAyJnh9lqgo0WFiaAcEHtRUEiRJC026JNes18+foLrEGKrfJ
WoKoduNW
=80gd
-----END PGP SIGNATURE-----

--jhlRjx2apgIVsQIc--
