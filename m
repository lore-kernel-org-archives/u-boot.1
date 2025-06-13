Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D01F4C71148
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 17:35:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BC5582D34;
	Fri, 13 Jun 2025 19:35:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ov62l/9u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEC4E82D2E; Fri, 13 Jun 2025 19:35:06 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1072B82D4D
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 19:35:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-72c3b863b8eso1639998a34.2
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 10:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749836103; x=1750440903; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QC/WgFOf6juVUEqjV8oNIochRj212YNoT41WQO6o+SU=;
 b=Ov62l/9u3/ofKNorNil8XiW34dLISiMgyrw2Otwg0KUYy1jebdqiQn9wCVujog0pXG
 eupBL+AWJeocp5d6m1GzTqEDYvWiVOOVAlv2x/rVb44VCyw8UybAQ/KC1UuUD6E1Qd9I
 IMfaJi7xnTxHCnu6FeKU8upVaQvjEu+f/7giE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749836103; x=1750440903;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QC/WgFOf6juVUEqjV8oNIochRj212YNoT41WQO6o+SU=;
 b=plBUlkvwFzfXEN8szUvLLuk2Q31F1Kq6yq0pW751n0Uy3FZJ5WxB+gvFLUileYAtsy
 pNWYXvR3IK9HdB3zpXuvYlSGSBqB8AE4nfL5/dtsnJREBXimcCi3o/9MSfC852yOe5HB
 87BNFaBdfFjUJhbzUJD3KeYHo1WLxQcdMyxSpVwFp8KN7ElbvXuJH4WyxmZuxzZQuYjN
 n5VFlPEmOm+QnX9aA8NlAsvy/p+CZH8giRRqyGMdf+nBWGC//74yu7HwgO/Fod5bVlm+
 WcxsWTT5TbPLojok2/dGSyji+K8/OFZ9bNdu4kkL+okWVjQfk3CrrRvIkX/EXhFoRMYE
 WVww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWg+gyV9ITfPz/zpmX/ZZWe0ldQ2OTU8dNADuq0dGWEMSqLHBQzo0le+rJ1JsP7CMdXU45ZSo=@lists.denx.de
X-Gm-Message-State: AOJu0Yzw2OgccXX9mwQrtpH1pJMS++MNuRCchwGOFzkRWtkFhMGOpNiq
 syGOZdoS1oxt6+bTjDtbTeODC36Jn/ZHeppUNfvuhj2bVLM94B2L0VXi2QEzSLgb3Cg=
X-Gm-Gg: ASbGncuaFyRfMOOLpx+lC3j6KNHYHJ85XKM8twVFN2iIglhoivZvCsitgUJbgu0rslO
 hGbgEfjIpsC627nYcGFEHWVP9fqZj/KStiZXHPTTYffuUs/d3g7gsoo1YuZqZY0kIXk9gq2S/g+
 z4yX70jfDazXyH/ZfymSKiNgw3SH6ROWCWqxN5d/OI0JpVUzOfwDLM96kgaYl8XqWTpZxcpmWo7
 aeFCJpCU2W9N6CxyoAqqsmmQRpYyPFcVhNTRmiP747oEu1TKeGHemhgNI9CvhrBlZyJjHySkylv
 W4jJsPkisR70Are8wMeuwzXllFpR+amDlF3Kfqoz25ekHGeLr3yBk0aecTxuGpwY6PBC8TxI3hq
 5WJbUK60TTnsfEoOGktFKcT4=
X-Google-Smtp-Source: AGHT+IFQTBoXmxPuSRlxhs+g0du1Lhgz8ZJDNi61gEOQhkznyZDFL0bSFvCZpjcARv3UW/mQUAELAg==
X-Received: by 2002:a05:6830:668a:b0:739:fcb4:db17 with SMTP id
 46e09a7af769-73a3631618bmr484980a34.15.1749836102639; 
 Fri, 13 Jun 2025 10:35:02 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a283dc98asm276950a34.11.2025.06.13.10.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 10:35:01 -0700 (PDT)
Date: Fri, 13 Jun 2025 11:34:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 mkorpers@redhat.com, mskrivan@redhat.com, eballetb@redhat.com,
 mripard@redhat.com, alexl@redhat.com,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Maks Mishin <maks.mishinfz@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 3/3] efi_loader: disk: add EFI_PARTITION_INFO_PROTOCOL
 support
Message-ID: <20250613173459.GB1382132@bill-the-cat>
References: <20250613085742.796015-1-javierm@redhat.com>
 <20250613085742.796015-4-javierm@redhat.com>
 <2584944A-D0CF-44E5-ABAE-C3E156ED8539@gmx.de>
 <87ikkzvghz.fsf@minerva.mail-host-address-is-not-set>
 <20250613154922.GY1382132@bill-the-cat>
 <87cyb7vaq2.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Kdch8Q+oSFVx2jwu"
Content-Disposition: inline
In-Reply-To: <87cyb7vaq2.fsf@minerva.mail-host-address-is-not-set>
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


--Kdch8Q+oSFVx2jwu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 06:59:33PM +0200, Javier Martinez Canillas wrote:
> Tom Rini <trini@konsulko.com> writes:
>=20
> Hello Tom,
>=20
> > On Fri, Jun 13, 2025 at 04:54:48PM +0200, Javier Martinez Canillas wrot=
e:
>=20
> [...]
>=20
> >> The project is https://gitlab.com/CentOS/automotive/src/ukiboot and re=
ads
> >> UKI (https://uapi-group.org/specifications/specs/unified_kernel_image)
> >> images from raw data partitions. Just like ABL reads Android Boot imag=
es.
> >>=20
> >> > Are you planning to add it to the EBBR specification?
> >> >
> >>=20
> >> I haven't thought about it before but I also didn't know that u-boot h=
ad
> >> this requirement. Probably it should be documented somewhere to make it
> >> more clear? Maybe I didn't look enough but didn't find a doc in the re=
po.
> >
> > We are not strictly and only EBBR requirements, if there is good reason
>=20
> That's good to know. Heinrich's answer seemed to imply that u-boot was
> limited to EBBR requirements.

It's one of the main users, yes, but it shouldn't be seen as *only* for
that.

> > to add more features (and tests). But Heinrich's follow-up question is
>=20
> Oh, I missed the lib/efi_selftest directory. I'll see to add a test then.

Thanks.

> > quite important. I feel like there's already a half dozen offerings of
> > A/B update that works within UEFI.
> >
>=20
> I just brought the A/B boot protocol used by ukiboot because I was asked
> how I was using the EFI_PARTITION_INFO_PROTOCOL. But I'm not proposing to
> add a new A/B update mechanism for u-boot, just to implement an existing
> EFI protocol...

Yes, this was more a lament for the ecosystem as a whole really. The
concept of A/B(/Golden) with various security features is pretty old at
this point, there's many implementations. I wish there was not "here is
yet another" in the space.

But regardless, we should aim to have U-Boot be able to be used with it.
Otherwise my crystal ball says that a few years down the line it'll be
hard to use Fedora-IoT-distro on common-device with U-Boot.

--=20
Tom

--Kdch8Q+oSFVx2jwu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhMYT8ACgkQFHw5/5Y0
tyxJAQv7BCCDKx4SA3ELXFlVqusP9PONaBdn5I+76VkvTthmyUEKNtMNeDhh+5hU
/Yu43D1sGWN8o4V/G3giTY+9DC24+A0WejvCt7jqVc+1UgN42AoHbtau4b6SY+cj
JIrr8QubfsnRbAqQc44HblHZphIP8oEEXk1Oxf1oSaf221jeN18zsidx7prwY5KC
wFE1+LjZopjv/wjNWhVCwDqaDuldTbbTqeM4yYm57C+SrOKFAbnz2uyazuOy6izP
vA0QhhLZ/pmT4d9bIef2WI+suOiHOlLF+/NBM5jumHWHSM+xOuKpktqZfSXJer0f
xWTdTzY30w+HkHnqLbVyJ+SoJ3S/lmkRxgeJYu9AznENk7mvA/fVg4z8WsyTuxT+
ELhIJS0Ru9kquCdZ0ZagvMehkUpb5UHu+dd5oydpo5MIURqYYIy+MAjhkFtqd5As
k6k8JZGXnm3CVlEbxnYjhz3xmeOz4zpzKneae08Oi+kpFSqsktmFoXRhDIw7CURC
MLQ1c+0e
=GL/h
-----END PGP SIGNATURE-----

--Kdch8Q+oSFVx2jwu--
