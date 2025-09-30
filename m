Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E124ACCA468
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 14:37:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42BC681D6A;
	Tue, 30 Sep 2025 16:37:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lspC3mqp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5892D83071; Tue, 30 Sep 2025 16:37:40 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E859802C1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 16:37:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-42594fb2fe9so15100005ab.3
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 07:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759243056; x=1759847856; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UwSb2ENiAK5+8Lybc7cQ7NoUPbzmnnh+cD0b51e8auE=;
 b=lspC3mqpe10/TVM69mWPq1PFrw0bEe3ayiYjOczbISxw+fX3E/dqHSf6mAETu49nqM
 N77QJ2rsYmOA8iuAGAkfqx0izUmR2rgcOPCJDeb7SUJJxwrkOaXynYjTWc0uMhusq9l9
 I1oUeuiXtbA3gUHe0NnqSrDWoubh/67lASVNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759243056; x=1759847856;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UwSb2ENiAK5+8Lybc7cQ7NoUPbzmnnh+cD0b51e8auE=;
 b=FbwAEubte5MY450ocxl+kMExzJp0eGXB+9e23ylR8kNk9ax+Oek3h2JBhbRCqGKRp+
 a9nc5U+hnvmtx2EQW/rujUXiA12u5O75sLcYn5TaE2AmpxvohPmhyUfzT6ALHnNrmquu
 BqQfjRKrcP8S5TRLTxGosoXj43vvrCTLsntKDlpfEV6B3cnZT4qO61YL+NmxEn8T2yaC
 OXi/9g5qpY+U7eWiLuRKWWzd5xIOFQO0BzWERuvKUkgZ1MG2YRX3c6vQKiMFw2L5/kW9
 Zy53AXO0yZQZ41wR6y6s0qRypGN06HwcQUo8a0T/ySZm2pXHNFIx7OfGl6wQ1yrLfw6C
 VEGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKPnmNZk4YH9Mb9ykibmchQC+NS1saYl0x6S7QLJScVMjjkqckMt4CLK8NOMnQjPuLfEdndUk=@lists.denx.de
X-Gm-Message-State: AOJu0Yzo25KbTgA5vTY3KXcNnvqyGe6flSK04jgzS8FnTK+XFWNHRpei
 ADI5YwJ3+TfPu2P/L88ONro1HEuNZRIqySuueoLZg9OZUgrEdke+YmnDNxYd/KHvpsS9WvfgMKv
 3KLXOQec=
X-Gm-Gg: ASbGnctu1ODdP1DQ4SYaSGlhL6Bj4cfmIgvNmU/M9zOaSYHIKvf73owtD4bpn1mswmb
 J4TifnpIP3zydqFPVeeCng4iOMdpoo6g4AEqXF8SzLN+HXP0wdnXRMbf3JBA4GR/awBJpAdibrd
 eU4QDHaWCtALheW3SxV+hbXY/PKEGFbHlOrTUzw2zh3f0NGmAlEkcwi0C5KR/ZTGs3KR92ZVe5v
 CHyZQFSjdys2ME8hHRX33XcMuNUnT+Vmm2Yo6F2LwTDeKJgQDG7HP7JZxlX/pmIdM1YeMS2Z8W0
 s8d9r7452oeVYD0zkD0gX6QJWDmmvEnVYBw+sR0Tc5VrWSjruQ3+37oKzM+hRJY2/S4yVwMnfJl
 pxFPaKbzj4jHCOAlTasbSTB9TiJlz/6ciTAzBbpyCQYww/PH55lRAuPbA+sa0pZo4DnblcAtodZ
 GjYo3zehuDqdvwyA4=
X-Google-Smtp-Source: AGHT+IEl1toifhRlohOWUiuqouAFdJdZCX0z9S+RQke/pCIIWhQ8hC1pEr1IDauFwAKRitf01M0Heg==
X-Received: by 2002:a05:6e02:19c6:b0:424:8b66:fbdc with SMTP id
 e9e14a558f8ab-42d8168039amr1228525ab.28.1759243055782; 
 Tue, 30 Sep 2025 07:37:35 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-56a69a1c5ebsm5914957173.43.2025.09.30.07.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 07:37:35 -0700 (PDT)
Date: Tue, 30 Sep 2025 08:37:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
 uboot-stm32@st-md-mailman.stormreply.com, u-boot@lists.denx.de,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 thomas.petazzoni@bootlin.com,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] Revert "board: st: stm32mp1: Clean env_get_location()"
Message-ID: <20250930143732.GU6093@bill-the-cat>
References: <20250917141736.59732-1-kory.maincent@bootlin.com>
 <55d0805b-dcb2-4277-a4da-f4c26b48a2dd@foss.st.com>
 <20250929170912.3bee3f9d@kmaincent-XPS-13-7390>
 <fd32f45e-a3c9-4170-8886-5a31dda0e4c9@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3K02xqPr25eT/Obv"
Content-Disposition: inline
In-Reply-To: <fd32f45e-a3c9-4170-8886-5a31dda0e4c9@foss.st.com>
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


--3K02xqPr25eT/Obv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 09:45:08AM +0200, Patrice CHOTARD wrote:
>=20
>=20
> On 9/29/25 17:09, Kory Maincent wrote:
> > On Thu, 18 Sep 2025 16:16:35 +0200
> > Patrice CHOTARD <patrice.chotard@foss.st.com> wrote:
> >=20
> >> On 9/17/25 16:17, Kory Maincent wrote:
> >>> This reverts commit d37641c61ba212241c38e3fd22f0335fc0bebc96.
> >>>
> >>> Restore support for environment storage in EXT4 filesystem on eMMC bo=
ot.
> >>> The previous cleanup incorrectly removed this fallback option which is
> >>> needed for boards that store their environment in an EXT4 partition.
> >>>
> >>> This configuration is OS-specific rather than board-dependent and sho=
uld
> >>> remain as it is configurable via menuconfig. Even if it is not descri=
bed
> >>> in ST defconfigs people may have enabled it in their defconfig.
> >>>
> >>> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> >=20
> >> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> >=20
> > Hello,
> >=20
> > Any news from the maintainers? Is there a reason for not being merge?
> >=20
> > Regards,
>=20
> Hi Kory
>=20
> I expect to send a pull request before end of this week for master branch=
 including your patch.

Since the release is Monday, I'd really prefer sooner this week to later
this week if possible, thanks!

--=20
Tom

--3K02xqPr25eT/Obv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNvrKQAKCRAr4qD1Cr/k
Cg5XAP9aSZsmFO2kblqP+8LCAxIjq9pB3lyGI8mEE1mBhZwslAEAzsUusgbYzS6E
XFTWazQcB+pxAyiP2tgzWubUCIzLwgY=
=K278
-----END PGP SIGNATURE-----

--3K02xqPr25eT/Obv--
