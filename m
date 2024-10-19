Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C452D3C920
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 16:52:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA3F888DF8;
	Sat, 19 Oct 2024 18:52:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I0b881L6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD46088E51; Sat, 19 Oct 2024 18:52:33 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA90D88B0B
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 18:52:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6cc03b649f2so21754816d6.3
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 09:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729356750; x=1729961550; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=a3B5sCTOcWtQLn34rlEnNyaDEUxcxZz6umXaYk5AvK4=;
 b=I0b881L6zJPUEGMX825duD0a2PUOrwIKJQm5VwWDkZlxmeeeLZYoqFk4/KIvMmTCtL
 zaQuxOaYnysi+wHf8A/EmG5nBFtqNXHxEgW8f/eOGux56diO3MWsLnEyFPfoRcd5Th4p
 XQg8HQX6d4o787PniV2xIdNC3zUQpBf8dkbec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729356750; x=1729961550;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a3B5sCTOcWtQLn34rlEnNyaDEUxcxZz6umXaYk5AvK4=;
 b=v9WD31YDpSSKoWTEqUXlI78KQhzT7YVzaR1NikTu9sK/yQoAnKS6m6PslsB6nh9pwX
 35sMYZRVq2GlG4VkIFtLp6dH4v0+M0XZ/nmE6xBy1NOsMjT+H0BPddSS8frvevEWv6RJ
 3PekdUM2OpwkaF6j6zXpFWZbP29Q7KSKXhgUF1i2D/s5L0/ssz+jLxufJL8NM0V7bnZy
 AKMc/DGLW5QBmx9PsnsdejSp66EIGiJZntjTSkIImXqVQR9bcxZgpsjlp2oQbVY6hXGO
 lLh5RbHfz0THI4xOurkbRVRbM3rMAUpEgVpfvFSl2d12aC3Yc2qv5UksKbpZ+smcMV3L
 hQPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmvBEMciWm1PdHdLOmn1tK4Pu5eeX9BwkzbEWNiZ/mT9FDPw0IQJRaYULc1ig6GPHB1O8PP2U=@lists.denx.de
X-Gm-Message-State: AOJu0YzOptFvSAseNNYEe2dbf9nP3mS+fCd3+5EvXui0HPPSOQqjecRK
 3nT2xihpaNeJq7cjru7bZ2Lxk+DEyAGP5FNL8GDsj1z5bN+b1p7ONBUWmzBuQNA=
X-Google-Smtp-Source: AGHT+IH9LAritUq/FFpQC9stdqmbth/Q9yTXfKRqHJgJ6W+LMM9zNGTdEq4zMzdmvrf9auGD68xC6w==
X-Received: by 2002:a05:6214:398e:b0:6cb:ce15:dc4e with SMTP id
 6a1803df08f44-6cde14b82e0mr74551616d6.8.1729356750482; 
 Sat, 19 Oct 2024 09:52:30 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cde1364e92sm20384946d6.109.2024.10.19.09.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 09:52:29 -0700 (PDT)
Date: Sat, 19 Oct 2024 10:52:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v3 03/15] efi: memory: use the lmb API's for allocating
 and freeing memory
Message-ID: <20241019165226.GY4959@bill-the-cat>
References: <20241014210453.GU53053@bill-the-cat>
 <CAFLszTgm=t=y1kj7Ju5Ls7nf0ghLCqRppVnY7yorD6v1hoeN1g@mail.gmail.com>
 <20241014212718.GZ53053@bill-the-cat>
 <CAFLszTiW_N-DvivnC_Fq4LWv+H+S2h8A-8o5dXPtGMsii1ToxQ@mail.gmail.com>
 <20241014214841.GD53053@bill-the-cat>
 <CAFLszThxdPd7ty2=X66ZRWopzE0R1ChhdRZzah5tYLS+FvZ-Jg@mail.gmail.com>
 <20241014230725.GH53053@bill-the-cat>
 <CAFLszTj6y-aC=bJ+9c8un+=zG=yGb7bs60wPzDOeMVAKMgVchQ@mail.gmail.com>
 <20241015190513.GR53053@bill-the-cat>
 <CAFLszTi22i661DikXOR=PvqEL=URGRsKC1pmU8QrJyy1GAxnCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yefTqtKxuIfBAdkN"
Content-Disposition: inline
In-Reply-To: <CAFLszTi22i661DikXOR=PvqEL=URGRsKC1pmU8QrJyy1GAxnCg@mail.gmail.com>
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


--yefTqtKxuIfBAdkN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 05:23:08PM -0600, Simon Glass wrote:

> Hi Tom,
>=20
> On Tue, 15 Oct 2024 at 13:05, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Oct 15, 2024 at 07:10:27AM -0600, Simon Glass wrote:
[snip]
> > > Even if efi_init_obj_list(), I don't like treating U-Boot's memory as
> > > a stack to just grow into. But as a first step, I do want to ensure
> > > that non-EFI boot can be more like U-Boot.
> >
> > I think you intended a negation somewhere in that last sentence.
>=20
> It looks right to me.

I cannot understand what you mean by "I do want to ensure that non-EFI
boot can be more like U-Boot." then, sorry.

> > But among the points trying to be made here are that no, we didn't start
> > an EFI app (a previous point of contention you had), even if we used an
> > EFI feature. We may or may not use more.
>=20
> Yes, we have ended up with what I feel is a dog's breakfast. I'd like
> to tidy it up.

Getting back to a point I just made elsewhere, this is further you
talking like the whole of EFI_LOADER is bad.

> >  But saying "I guess now we can
> > live with the EFI pool doing what it needs" is quite silly since we've
> > potentially done almost nothing else.
>=20
> Do you mean that it is inconsistent for me to say that when
> efi_init_obj_list() is called, any memory can be used? Yes it is
> inconsistent. In fact I may as well just say that we should use
> U-Boot's region until we can't, e.g. we exhaust the reserved space. By
> that time, the boot will be well-advanced, I suspect. I'll take a look
> at some Ubuntu boots and see what happens in practice.
>=20
> > And so why did we make this
> > special case anyways?
>=20
> Once an EFI feature is used, we know we are booting EFI, so it might
> start using memory outside the U-Boot region. That's all.

No, we don't. As another of your threads noted, we print a warning
message about not being able to use persistent UEFI variables. At that
point we can further go and see that no, this is not a UEFI-boot capable
image and move on. But we've now crossed your point where you contend
that UEFI is unavoidable.

> > This is why I keep saying various versions of, you
> > need to re-think what you consider "U-Boot memory". If you have concerns
> > about our stack smashing in to things, that's the problem to address (it
> > could just as easily smash an initrd placed high in memory by a non-EFI
> > bootmeth).
>=20
> I am not yet ready to re-think that, because my intuition tells me
> that I have this right. I would like to get some of my ideas in, to
> solve this problem. To do that, we need to be willing to let U-Boot
> allocate memory (on EFI's behalf) as it wishes, within the spec, not
> necessarily based on just what the code does today.

Well, in that I believe Heinrich has suggested some further changes to
how the EFI memory map is handled, now that the lmb refactor is in and
largely (but not entirely, Caleb made some good points on IRC Friday)
done, we'll see what comes of that. But I'm not sure who you have
convinced that we need to make these changes for a conceptual, rather
than functional problem.

All of that very much said, this is one of the times I wish I could
figure out how to introduce a technical steering committee structure of
some sort, and how to have matters voted on in some manner.

--=20
Tom

--yefTqtKxuIfBAdkN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcT48oACgkQFHw5/5Y0
tyzkVQwAr5asE1H3YsmskLooySj2nhrAkO/glP/HC5lSFsARYvuRsmv4AOW0LXX9
AigMs64DPqEbkLJGxGRIKTX65GTGDx8uCTNLJfqA0A3hL+166HJT00//D9lPlVLT
c6mJ8RLSYwLLRknYFpeLAFzUcr7XwOBuZo6r1YJTUM9eWm3FIO6zmTxPAlc5cc4e
ejwYLh7FWvMsmWBwFdiTM7Tga/5Z5wkrRjPmPOke8xL94teg1RVF+YJjeYV5R/3o
ysHq6trFDSyi4RYl+ifp7bbmMKqSjbBNoiMOki8BwwKTFkWyyvnnx5kNeJY4hZCx
X4goDNrnc7ZHxqj5mhC5IYBdw9rhQQ8JJxFo7jVaSErwapcULSqSwfI0gWiT8NvI
UFHmlDqPKDMgQCit6YOKwgsSPNVwkeBEFY7Y76I38DXrusyV8yIT/8M2zlewn/FC
U9kgs05Or7ksLDZMzk3+w/6sVA6sIB1e6J+UCqdrntvKrOWJ6XfmfAA2NN1TMA/B
SPHv3GRD
=o/nR
-----END PGP SIGNATURE-----

--yefTqtKxuIfBAdkN--
