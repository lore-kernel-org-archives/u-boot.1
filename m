Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666E8CFC500
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 19:28:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAD6D83A8C;
	Fri, 21 Nov 2025 20:28:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aJ0/7NnF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31A4983AA9; Fri, 21 Nov 2025 20:28:00 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0F0783A8A
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 20:27:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c6ce4f65f7so1745286a34.0
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 11:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763753276; x=1764358076; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FsafPr9/WGtR2qI7x1XmaQbfuB11YVJKhkO2pp/JOUI=;
 b=aJ0/7NnFa2nUudyDYRm7h1dIMFYF3Y5oevqEciTOUpZK5BIJgdew0g7XkCCFJjqW70
 30r0XMiS87FtY7qY18x7xBJg08ZVobfgVCRKWrZ0xtJaDoXNulOnZQoYZ3U6r3inVbJt
 HxjwfE7JvnES1e8D7CJ2REog7z4pt3XYRVONE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763753276; x=1764358076;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FsafPr9/WGtR2qI7x1XmaQbfuB11YVJKhkO2pp/JOUI=;
 b=kXUBRvjF14MjiaqNwLeBoqT/QrKRhXXK1NBcMjFTeySfgk/GVHOL7yyNkaVqNKUd8b
 B1JrGavrCUlbaZQOjHg7oujejGklK5IWzhNjmE6kXYtlBkHy8j/cF6via3t2aknBRPn2
 10X/5icxDXxfpOhdOpQCKz7XkJl0p3QKLtqC3u5uTUpL6llILN7KZfbcMNreq231sHD4
 5zM/2/BaqiXe1RDZTQP+Uk1tLX5rrQXvW0laH0OYH5cCP96x39AIhrk7jcCHU/wriu3X
 C7wFPvCdtZUmlatGiCGKmc1cQ6dT0u5ygL+mtwvF8jmKyUdoEv797Ly0jBLTfFujObPp
 yQmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVshy3Wbce9kSGlb/YNhdxA6zCLg6ExzYYOshoWVK+6qcMqEnMkk0mvVk5/HAs2yr4vNfi1iCU=@lists.denx.de
X-Gm-Message-State: AOJu0YzZ+bKmcMb1pnDK/LRT+hufFmg4leLU3dIsu99NOUk1MwhXuSZE
 apuzPAg0QGXHZJ0FIrNAVRH7leTgV17caqJ5g2mpokFqd2QPBeeXE5WTh/zuCIBM3fk=
X-Gm-Gg: ASbGncvx+k9qBpky0R7SqZ8cYCR7El57AagTmiYUyArg1bmlNn+K4Xr47e7smzFFS2r
 X2d36Rwq0iWmnaZanQHvvXhAVKxdPpg15+YLCyrRm4RKh/+QyxNzJMmjBwVbSEnupy9Y7djtIrX
 qDdjoiYTJ9QUNrAdsqjeThNhFOUv0XNX/+q+N7/+3MFm08rGQRZLG6whZ5PoJFb9nQ9ZkNTkrNI
 sUisx6asrtf/Trpb1wyBb1sZ88S+if5hJmaaZlpnCozhT1Be8LA0zbop13ujhrKeK1p9DTO9QJN
 PusOe6kUbJq08SWSxQoxltl0wlte2icVAXG58qRAuZhp4aIQvvS3AtiaIh7qhY2Oa6IC6tox1Nk
 oU0FTngyOvsIjPQ4NvKZ3dIoYK2pkc2HELGvSq4NecILxi1lWuSM3twX4aeaH1Zwikye/TRNZ6O
 sp3si81khqJ2FnjeMjaxIgY/mhxOuE2ppWDY7Pj3lE0X1TV/MZIA==
X-Google-Smtp-Source: AGHT+IFsr39Y42LwUhbAbTxv/HUQt8cRasAN7HtCwLJCejOWw79QhgfGFwuxJ9eJAR38bH7hiaFOIQ==
X-Received: by 2002:a05:6830:6d15:b0:7c7:6043:dd8f with SMTP id
 46e09a7af769-7c798bd022dmr1802235a34.15.1763753276422; 
 Fri, 21 Nov 2025 11:27:56 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c78d302329sm2625308a34.6.2025.11.21.11.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 11:27:55 -0800 (PST)
Date: Fri, 21 Nov 2025 13:27:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH] clk: fixed_rate: Avoid calling dev_read_*() if
 CONFIG_OF_PLATDATA=y
Message-ID: <20251121192753.GD2125796@bill-the-cat>
References: <20251120041439.817233-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTjnGtSPvki-i1fHQEU+bn=6cTqjRFyid3D5zQepNEhzog@mail.gmail.com>
 <c8752825-92d5-43bd-aa28-e229d4cc3fda@mailbox.org>
 <CAFLszThiZ9iWZG8vNSaosNjMMTQZeG2=yO8kGoPDBL0SSp_4Cw@mail.gmail.com>
 <20251121143510.GX2125796@bill-the-cat>
 <CAFLszTiBezzWuBE2qo8iEU8dyyD6ro4x2UrXGnQnfKSYSmTGgg@mail.gmail.com>
 <36b44a71-e98d-4b89-b639-cb1e31f41865@mailbox.org>
 <CAFLszTj_RJuGXriRMpEnf3ZM8Jd4zmSB87KiTdk7umjzfcw4Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lz1mJRcA0TtR4G3O"
Content-Disposition: inline
In-Reply-To: <CAFLszTj_RJuGXriRMpEnf3ZM8Jd4zmSB87KiTdk7umjzfcw4Og@mail.gmail.com>
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


--lz1mJRcA0TtR4G3O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 12:09:31PM -0700, Simon Glass wrote:
> Hi Marek,
>=20
> On Fri, 21 Nov 2025 at 10:53, Marek Vasut <marek.vasut@mailbox.org> wrote:
> >
> > On 11/21/25 6:35 PM, Simon Glass wrote:
> >
> > Hello Simon,
> >
> > >> To be made to clk_fixed_rate_ofdata_to_plat_(...) in
> > >> drivers/clk/clk_fixed_rate.c as it does not currently call
> > >> dev_has_ofnode(dev).
> > >
> > > Ah OK. So the call stack is something like:
> > >
> > > dev_read_u32_default()
> > > dev_ofnode() - returns ofnode_null
> > > ofnode_read_u32_default()
> > > ofnode_read_u32_index
> > > fdt_getprop(NULL, -1, ...)   // guess
> > >
> > > And I see that I put assert() in some of the ofnode_read..() functions
> > > because I don't have tests for passing an invalid ofnode.
> > >
> > > So perhaps fdt_offset_ptr_() should check for NULL and return? I
> > > haven't traced it though.
> >
> > In previous patch
> >
> > [PATCH 3/3] libfdt: Check fdt_offset_ptr() return value unconditionally
> >
> > that approach seems to have been rejected, and these dev_read_*() fixes
> > were implemented as a replacement.
>=20
> I don't think it was rejected...but I think the commit message should
> better explain the problem, e.g. using some of the info above.
>=20
> The only choice is whether to add the check unconditionally (which I
> think is fine for now) or to add a new type of assumption.

Your feedback here does not seem to match up with your feedback in the
patch in question:
https://lore.kernel.org/all/CAFLszTg6dF1dmJJDh8-2ZjUf6i9+ZOFvWNSxNRS_PBQ3CD=
NtHw@mail.gmail.com/#t

--=20
Tom

--lz1mJRcA0TtR4G3O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSC9OQAKCRAr4qD1Cr/k
CpszAQDiaxsTu+mJc+YDaAY1EXPdhw6HMNXR+dYvA/ObAV8MlgD6AqDBPj8eSqkg
gnCk1nbLd+sb6CDZT2u0rPDv8HBCugk=
=OhN1
-----END PGP SIGNATURE-----

--lz1mJRcA0TtR4G3O--
