Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E605C54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 14:08:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C510A8329B;
	Fri, 23 May 2025 16:08:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k9SmRYzj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48DB18329C; Fri, 23 May 2025 16:08:19 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21A0983285
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 16:08:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-604ad6c4cf1so3246459eaf.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 07:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748009296; x=1748614096; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F1gd81xmZj9MzIN4M8XQUiHlfDtlcLAEvg5WnAfj2bU=;
 b=k9SmRYzjMSWISRhNyrWOi3gAQ3RMChQuybDJ71i34qngyuiNbe4Uw6d7afaqnHUqi5
 xWSOn6k29mYYS2Twgjlys0GAfyCIyWyCu21HtRoSJ1L4tNTvcvFax2GYOAzngWpnzM2s
 TrfAUH9zX+kIsdIIS+mc7mNdlQzVz8PfqFzI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748009296; x=1748614096;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F1gd81xmZj9MzIN4M8XQUiHlfDtlcLAEvg5WnAfj2bU=;
 b=B4X6LJDjuK6aaDx2FoySIoImncDBnUtzOyEGZQdquiWD3l3LQCRWqHXLJQp1MTcSzT
 qUyIaRIdUi+W8CkPTc2hQP1XvhPGXCXxklLwGa9JG0+z1bx+SZfoI4jqMhUv3jSmjMTw
 4yCt67vVjPHXVzNSvMEpDe6AGxM24wgC9inwmOZltVRuq4yuUAGY7XulxrH3P9Znkm8L
 MJSh9XzGTq8oeD3S4xjOAga6nLr9xWf1c2/gCKP78AdCqTuoG8XhyuhKkoD8GsoObrhz
 2vhZ6buLDo3uBNI55mc4KAk1kqxZ9ziemgo5F8qfVvbI2y+rWUj5boSjStqPRgfVilIU
 b9fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjcRRafc4gRL0DDwgjXfT16Yzm06FIEmX+iBNNPPhvfldryOJ5PXhrsMNV9h2q2iynT26GNX0=@lists.denx.de
X-Gm-Message-State: AOJu0Yyq2gLRz5kfvjmNLQLP30ps239yLq/jfi+tACj05D/ccv1Z69q1
 GfMcDQbO+nWzx871GB4xt36/tdOLt18Jsew+cWoXiF3sRFkmyfCaZLE6+VtU5sE8EFubXk5JFCj
 m/7NhwjI=
X-Gm-Gg: ASbGncuyQxw/l+3UkZM5EqIVNhKDVW8ZM8npdTdXYQqpWX3aHqYjyBp5Mz/d/SkqNqD
 6rtbdAIuMsfFTL09lKBsU9XU3acpgCobDHmT/WXQpV/NLB5IV5EslGl3j4FU+cYYJ4p99BKHpUx
 DwcA+CPg+60zp682wNcoNMvYNDXOmXGcaQu5WT7Ee9I89OHHKGVJsKsBiXkoTKj6VeFKiwgngFi
 SZbu7dnFWEexNX8cleC/uEZ4E5fEezzVLLVMA1C52mxDGHe2DP5JLlxKHitulipcZOg5g7Q3Xju
 rEUNz9O5QlNnTbrBnWvdFwo+uZZ44bgmyshrPomaBPJgnurYLtGW+xXJ9rtuFsLD05TRKFBGRo4
 wYY9FT1tQTYPU
X-Google-Smtp-Source: AGHT+IF/N10pKC/UY43Tn65tq8HDkBN8v8lXly0FR6b795mUVZb5DWYS7ZZh4qblajHa9Q1j3kkV3w==
X-Received: by 2002:a05:6830:660e:b0:727:3e60:b44b with SMTP id
 46e09a7af769-734f98aa978mr19790396a34.14.1748009284630; 
 Fri, 23 May 2025 07:08:04 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b5e60esm2868212a34.59.2025.05.23.07.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 07:08:03 -0700 (PDT)
Date: Fri, 23 May 2025 08:08:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Benjamin ROBIN <dev@benjarobin.fr>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] bootm: Fix bmi->images pointer not initialized in
 some cases
Message-ID: <20250523140801.GR100073@bill-the-cat>
References: <20250520203515.25839-1-dev@benjarobin.fr>
 <CAFLszTigMGxSjxPZ44BUx4WoWqVdNY3p6AeQwy3xK3gJ+VccTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="k98rBJ/LrDkthwww"
Content-Disposition: inline
In-Reply-To: <CAFLszTigMGxSjxPZ44BUx4WoWqVdNY3p6AeQwy3xK3gJ+VccTw@mail.gmail.com>
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


--k98rBJ/LrDkthwww
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 02:48:15PM +0100, Simon Glass wrote:
> Hi Benjamin,
>=20
> On Tue, 20 May 2025 at 22:35, Benjamin ROBIN <dev@benjarobin.fr> wrote:
> >
> > When building with only bootz command, without bootm, images pointer
> > inside bootm_info structure is not initialized. And since this structure
> > is stored in stack, the generated error is kind of random, but most of
> > the time this will generate: "ramdisk - allocation error".
> >
> > Also, after analysis, this problem could occur with the command booti,
> > if the command bootm is disabled.
> >
> > Currently bootm_init() is called by: do_bootz(), do_bootm(), do_booti()
> > and by do_stm32prog(). And all of these commands execute bootm_run_stat=
es()
> > which access the images pointer stored into bootm_info structure.
> >
> > So, to fix this issue, just do the assignment unconditionally.
> >
> > Fixes: c2211ff65136 ("bootm: Add more fields to bootm_info")
> > Signed-off-by: Benjamin ROBIN <dev@benjarobin.fr>
> > ---
> >  boot/bootm.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/boot/bootm.c b/boot/bootm.c
> > index f6aa32746b7e..108ca7fb472e 100644
> > --- a/boot/bootm.c
> > +++ b/boot/bootm.c
> > @@ -1169,8 +1169,7 @@ void bootm_init(struct bootm_info *bmi)
> >  {
> >         memset(bmi, '\0', sizeof(struct bootm_info));
> >         bmi->boot_progress =3D true;
> > -       if (IS_ENABLED(CONFIG_CMD_BOOTM))
> > -               bmi->images =3D &images;
> > +       bmi->images =3D &images;
>=20
> In my tree I have:
>=20
> if (IS_ENABLED(CONFIG_CMD_BOOTM) || IS_ENABLED(CONFIG_CMD_BOOTZ) ||
>     IS_ENABLED(CONFIG_CMD_BOOTI) || IS_ENABLED(CONFIG_PXE_UTILS))
>=20
> but it seems that the few boards that didn't include boot/bootm.c have
> been dropped, so your patch is fine.

Yes, looking at the code, we should have always been doing the
assignment as there's a few places where we reference bmi->images and
not the global images, FYI.

--=20
Tom

--k98rBJ/LrDkthwww
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgwgUEACgkQFHw5/5Y0
tyzqwQv/ZTezAQECzInFTtMvjGxSaatJYdbkr1teDB0ZNXCFswR1t2FJXV/iA/sF
teEKdDpT2p4HYjf4+SvGgKeklM8qEF8laDZ19RDf470ROOhq2apbeafQks2XJeGR
tffCq3g2x4tJkw2qdXPWVhe60slNmJ0LvXmjGREgFtAfJAvQXY/wH7CGO73HOqxP
aWbgxWtMc7USrLeKSb+bu+3YjYGFkFrxl65tLkFEvKTt2Xc4Jegc7DrHVFvSa+2a
D95gYOXm8yp4yekpDyO4mQmINkOmnoIJfjyi2HBScnVdTnlwNDYbxk4mdVOc6feR
vWfXp+DfP4WJ8NmcLeT2n1PLbM66Z+h4o8O/v2ohf/DcGuPLqSdfqkQRFKbMBL7j
9qq1wQTiIc9pPvum9be/5uSpro3gRAz5I6iGF7OESsKVBiUBvQ0wqIhgY2/CZ/ix
U8TVMlHexdvdi5dLQ0ttyGNTAUHfxJnJLRrgGXxOCKk9QvMCFtuGh4sIwPtYZJHB
uT8My2xd
=sIPi
-----END PGP SIGNATURE-----

--k98rBJ/LrDkthwww--
