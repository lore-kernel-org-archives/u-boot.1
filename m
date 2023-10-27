Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D36AC25B48
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 01:04:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94C9687622;
	Fri, 27 Oct 2023 03:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ek3CaUyq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CB4387622; Fri, 27 Oct 2023 03:04:34 +0200 (CEST)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EE408763B
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 03:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-41cd4446cf5so10308211cf.3
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 18:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698368671; x=1698973471; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sKgTWQ15YmKvKdzLTXXu3McjFTUTsZtjvehflCE6pd4=;
 b=ek3CaUyq99ktbs4SKYWWsvom4yrgXnrVDOAE+1M9YLSH4T4yimNK1ucRCFL6DsGrwL
 4l+7gR9PBIri1xdjq0V2L1scshjFvK6kMs++N1AF/zJVD3vBaSCc3ZFEoaJe1cfDr6st
 k1Kx+Hp7vY9CKr71me+hdaZvw9YcJp2zLqZA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698368671; x=1698973471;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sKgTWQ15YmKvKdzLTXXu3McjFTUTsZtjvehflCE6pd4=;
 b=gnLWpwqKMxikF+SbZNPK/VZKAkOmlAL3vagk608dHwM6e3cxio+3KVKFxPUbcNytoI
 XIrzSEJS2/sVRxYXd1jAOqCnMQWN/S7ZdPxOZZN6lDU/Z0sbQRr70tuqIzsn1Citu+Pu
 cayPxKnk5YHUBnMpBSxNtMZ/93IeCfw4g6g/TtLnf3m3efUP4uhgNbZO7hQHw+IyVW/W
 b/jwdL1639Xenb6MHX5BdY8qXyLE+x+dlZbuw0UiHKLKG/wNFTC16RsyCRTAJ0ml8Ux7
 hi7YUjRiAlSABkoqpMIurXzY8fXQvOLZMawUBy3au/Hp0rWlD6xxCda7qbM0jmmJW4b3
 i4ZA==
X-Gm-Message-State: AOJu0YxLXXsQrU1auFEnvDuJWEnaSUoSL2WcFFEPhjkd3uV4tCZ4YeWy
 elnHsbUW7JvABq6Y0c2EOb5HaA==
X-Google-Smtp-Source: AGHT+IFTb/pITJsmwcGUcU3c/wbqRC860bQmx7D7iZBpXQyI2Hnbldvkpkq/0bWOjL0u7p51DKmVtA==
X-Received: by 2002:ac8:7d0e:0:b0:410:90c7:518d with SMTP id
 g14-20020ac87d0e000000b0041090c7518dmr1494483qtb.11.1698368670835; 
 Thu, 26 Oct 2023 18:04:30 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6a0e-a72f-3fdd-31b7.res6.spectrum.com.
 [2603:6081:7b00:6400:6a0e:a72f:3fdd:31b7])
 by smtp.gmail.com with ESMTPSA id
 v8-20020ac873c8000000b0041abcc69050sm184591qtp.95.2023.10.26.18.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 18:04:28 -0700 (PDT)
Date: Thu, 26 Oct 2023 21:04:27 -0400
From: Tom Rini <trini@konsulko.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, sjg@chromium.org,
 ilias.apalodimas@linaro.org, jbx6244@gmail.com, u-boot@lists.denx.de
Subject: Re: [RFC 11/13] fs: remove explicit efi configuration dependency
Message-ID: <20231027010427.GS496310@bill-the-cat>
References: <20231026053052.622453-1-takahiro.akashi@linaro.org>
 <20231026053052.622453-12-takahiro.akashi@linaro.org>
 <1276E605-F0B0-47A3-A80C-F17C6F8A7F3F@gmx.de>
 <ZTon3nThWP/XmkGd@octopus> <20231026124752.GF496310@bill-the-cat>
 <ZTsLVnXoP5SBvFlz@octopus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IBHXmLL0JTw4+qX2"
Content-Disposition: inline
In-Reply-To: <ZTsLVnXoP5SBvFlz@octopus>
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


--IBHXmLL0JTw4+qX2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 09:59:02AM +0900, AKASHI Takahiro wrote:
> On Thu, Oct 26, 2023 at 08:47:52AM -0400, Tom Rini wrote:
> > On Thu, Oct 26, 2023 at 05:48:30PM +0900, AKASHI Takahiro wrote:
> > > On Thu, Oct 26, 2023 at 09:58:53AM +0200, Heinrich Schuchardt wrote:
> > > >=20
> > > >=20
> > > > Am 26. Oktober 2023 07:30:50 MESZ schrieb AKASHI Takahiro <takahiro=
=2Eakashi@linaro.org>:
> > > > >Now it is clear that the feature actually depends on efi interface=
s,
> > > > >not "bootefi" command. efi_set_bootdev() will automatically be nul=
lified
> > > > >if necessary efi component is disabled.
> > > > >
> > > > >Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > > >---
> > > > > fs/fs.c | 7 +++----
> > > > > 1 file changed, 3 insertions(+), 4 deletions(-)
> > > > >
> > > > >diff --git a/fs/fs.c b/fs/fs.c
> > > > >index 4cb4310c9cc2..70cdb594c4c8 100644
> > > > >--- a/fs/fs.c
> > > > >+++ b/fs/fs.c
> > > > >@@ -791,10 +791,9 @@ int do_load(struct cmd_tbl *cmdtp, int flag, =
int argc, char *const argv[],
> > > > > 		return 1;
> > > > > 	}
> > > > >=20
> > > > >-	if (IS_ENABLED(CONFIG_CMD_BOOTEFI))
> > > > >-		efi_set_bootdev(argv[1], (argc > 2) ? argv[2] : "",
> > > > >-				(argc > 4) ? argv[4] : "", map_sysmem(addr, 0),
> > > > >-				len_read);
> > > > >+	efi_set_bootdev(argv[1], (argc > 2) ? argv[2] : "",
> > > >=20
> > > > This function should not exist for CONFIG_EFI_LOADER=3Dn. There are=
 other places where the function is invoked. Please, review all of them.
> > >=20
> > > Please go through the whole patch set, especially patch#8
> > > "efi_loader: split unrelated code from efi_bootmgr.c".
> > >=20
> > > efi_[set|clear]_bootdev() will be nullified if not necessary.
> >=20
> > In this case I think what we have here today is more readable / clearer.
> > We don't need empty functions as we can either do like this section of
> > the code does today or the linker will discard things correctly as it's
> > a case of funcB() calls funcA() and nothing calls funcB() so it will be
> > discarded. I don't know without digging through the series more what the
> > correct IS_ENABLED() guard should be here (and then also in patch #10).
>=20
> If I correctly understand your question, it is my point in this commit.
>=20
> I believe that a caller should not be bothered by thinking of what efi CO=
NFIG
> be used for the guard. All that should be done is to just put a right hook
> (efi_set_bootdev() in this case) at a right place as a caller (do_load()
> in this case) is apparently irrelevant to UEFI subsystem.
> Hereafter, whatever rework may be done on UEFI side (like my refactoring
> here), other code won't need to be modified.
>=20
> If you want to rely on an intelligent linker behavior, I would suggest
> another approach, modifying efi_set_bootdev() as follows;
>=20
> efi_set_bootdev(...)
> {
>     if (!IS_ENABLED(EFI_BINARY_EXEC))
>         return;
>     ...
> }
>=20
> I hope it would also work.

Looking at all of the ways to solve this particular case again, OK, I
think we can go with #8, #10 and #11 as they are in this series, thanks
again.

--=20
Tom

--IBHXmLL0JTw4+qX2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU7DJsACgkQFHw5/5Y0
tyzBIQwAmil0j9jCPh3q9TLr9YXQhtbxFeLIV53SCFsfKKC2GO8mE8QbT+T5wUaX
L+7bI2rpZIYh8EvmpCEG6VZ7VCtoLeUALS+VJLfz8xsaTBG30t5QCzcnXe9/a9x8
ORE0DIUJ2XOmEvOIty8jbJMhnuBzmC8MfuPxBHonTXQZZkiN1fYKL5WtqVNMhKt/
1kHYpaNR8/tVBii048X2JM/voV7vlG4ApbjkY+91SgK2URp6fKKly9mSFPxauwaN
NNq/JW8Q3BpugqFeNciaUWtnPlLcGNW+IIqgIA0I0YzlY43IbUtX5CgA/kT+H+DX
g7/QQcgs9N+GgZ76AXiwwLEJegT43vCTFEAKNfsb1KGmtKLutNupAqMlTfZXstMs
TR+uDuQkGJKgS3Vyk0WiDdKpr37/2hFZsL8rp0NrbMVES5rK9cU4aLZFQ2gYLvso
BbR2BS0dndBPiEcYW22pj1e7J63W2q7ujmjRU1QZzGBdb+cUfmFRH5Tv9QMbSqGv
zgl15lZK
=v0YC
-----END PGP SIGNATURE-----

--IBHXmLL0JTw4+qX2--
