Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEBCC282EC
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 15:53:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 065B1811C1;
	Mon, 10 Mar 2025 16:53:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Btgcty3r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93690816AB; Mon, 10 Mar 2025 16:53:43 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5E3A80017
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 16:53:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22409077c06so12648515ad.1
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 08:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741622019; x=1742226819; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NWCNE3uO6PaVM7LGjrhy5wzpbphTjfSM8KguNIQkj2E=;
 b=Btgcty3rqSCeS4L7pfK7LAoTr6Emma651WwmbDVz9mIOVQEFrb3Fd9OZRoTfDLpGGH
 /wYcv6BJQaIMncMvHhtUiKcKt31jQBdoTng3VFrgKZ4WzD8EWBL3jBZghMelvAOH+dfi
 iEFkS8CN4Krm4DQQU97a2dCGU2ZiQu4af7+rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741622019; x=1742226819;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NWCNE3uO6PaVM7LGjrhy5wzpbphTjfSM8KguNIQkj2E=;
 b=aJCSMUy2FydGE7/2VlY/mNcTR9/HMYLHZgoIT5Qdb49vuhwajV9DWZoL7i1Dw2dI76
 n1gI87Pp9Vs0Z2X2Ztj0hMq/SjlGdkKSybKpPuHo71ujyP2xH5QMLyMvH7LzAI1Wt8AO
 w6fw1+RIJocGtwH7kAQj7yVhrx1mMHeKGsn+wRhLJC3KTRjSdnIIBDCNTBhhS9BnGfzd
 YljPUPV+1WDdQsTtM5xv3GZ8v9ie/V7wSCP8V11V34uHE3g34anPrr4LgSdcoEPeiljX
 RB1ktlCLDmB4dOhhzXaTYu4kXWVpsdvhZjyvluHNXduvmlQLsrhMYIPH6hINCe7mFTv3
 0tGg==
X-Gm-Message-State: AOJu0YzyEPjCHvL1rRpGDsrAw8VqlTKlkRsueh1UV6GkZCHfcwQ9f1o2
 VNMUd8bHAyj9msDUi2kuUUBOmJdMFqO5KBYLAkd0U4RKzFBEls3VFhWlRRpNw8M=
X-Gm-Gg: ASbGncul1/3nmo+aetIXKdL9fNFM3BYmHLuDMpEe0pGXe4oZDOr5pJ2CdGI6OjKY547
 TOkeoHAlkjwUKXp1HdXKbr+Sgst4N5h94JWNyZozQAdFCjMIVYSlgD0kMvWYDPrOcLcvDKDd0uV
 ZN9qS83WJaLZKcdLHp+xwn69cbmecMnt7ERtdjqhnM+QIgjY7CnYf1xD9ymy3q+lrokfLvyO8IZ
 eawcMgAxbAUvHOBZ2kOgH1YW3P+IWYErXaJr1vYTflLdwTm/Wi0xH+fMFu7dT3OL8glur2yv5UC
 Aycbz1nfwY+m4VgivchPy2idR0+IBY5rjquGPG4Fbd4ZUg==
X-Google-Smtp-Source: AGHT+IEgSMpueR2c2KZ+oldTxV+HrvzeIqZyX+hHByJP8Ff0S9u74Kav7SsKjJ/WE+HLI/UQ1OmylQ==
X-Received: by 2002:a17:902:cf07:b0:223:58ea:6fdf with SMTP id
 d9443c01a7336-22428a8d325mr284611605ad.28.1741622019341; 
 Mon, 10 Mar 2025 08:53:39 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-224109de260sm79747085ad.16.2025.03.10.08.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 08:53:38 -0700 (PDT)
Date: Mon, 10 Mar 2025 09:53:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: Rate of innovation in the project (Was: Re: Rate of change in
 the project)
Message-ID: <20250310155336.GJ2640854@bill-the-cat>
References: <20250221175320.GN1233568@bill-the-cat>
 <20250221181055.GO1233568@bill-the-cat>
 <CAFLszTgnj+ZFq1vEcSSKCOeYjx0NKesO8Lo3aOJ2Nm-jhuTvig@mail.gmail.com>
 <20250224232303.GJ1233568@bill-the-cat>
 <CAFLszTgtdETGCYYtH3ni7Wv0W6Ckv1SoZRG8djQ-3uKBn1YZWQ@mail.gmail.com>
 <20250304152909.GZ2640854@bill-the-cat>
 <CAFLszTiNQSs51iE=rcM7qQjipmWCKZiPX+gV2ztb+ZAB8m2MBw@mail.gmail.com>
 <20250305162236.GT2640854@bill-the-cat>
 <CAFLszTjv54tYLHkG=RNeXJoZ+f-QHxMH=B_aU2=iOZhaoD7qKg@mail.gmail.com>
 <20250307144631.GN2640854@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TCNy/TQluL6x8a5x"
Content-Disposition: inline
In-Reply-To: <20250307144631.GN2640854@bill-the-cat>
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


--TCNy/TQluL6x8a5x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 07, 2025 at 08:46:31AM -0600, Tom Rini wrote:
> On Thu, Mar 06, 2025 at 09:10:47AM -0700, Simon Glass wrote:
[snip]
> > Again, back to this thread, if you want me to migrate things, consider
> > applying the sunxi patches as I have described above. I will then look
> > at the next target for bootstd. But while you hold this up, I cannot
> > move forward with more bootstd migration. It doesn't seem that much to
> > ask.
>=20
> I will take another look at what's still relevant. But I believe it's
> still blocked on the fact that it changes behavior and breaks users.

In details:

https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-2-s=
jg@chromium.org/

Now that the underlying BLK problem is resolved, this can just be
dropped I believe. Removing the BLK dependency from BOOTSTD can happen
when you're supporting a flow that lacks a BLK device entirely. This
would be another reminder as to why putting unrelated changes in a
series is a problem.

https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-3-s=
jg@chromium.org/

This is fine.

https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-4-s=
jg@chromium.org/

This is not fine. This is also not a sunxi problem. It means that we
should drop bootmgr from rockchip, where the conversion has already
taken place, and would need to drop it from future conversion too.
Neither of which are desirable changes. This patch in particular is
where we have the note:

"Yes, the introduction of boot standard changed the boot order and
specifically deprioritizing scripts is unexpected."

Which should have had more attention than it did.

This is the thread that to me spelled out in details where the
conversions are now blocked. We changed behavior and that in turn breaks
users that have come to rely on ordering.

https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-5-s=
jg@chromium.org/

Is an alternative to the above which then turned in to a discussion that
I would very briefly summarize as "no discussions were had between
stakeholders before integrating efi bootmgr with bootstd".

https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-6-s=
jg@chromium.org/

This is fine, but only relevant once migration happens.

https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-7-s=
jg@chromium.org/

If Andre is fine with this, this is fine.

https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-8-s=
jg@chromium.org/

This is a generic bugfix. I will take this to next today.

https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.1534931-9-s=
jg@chromium.org/

If Andre is fine with this, this is fine.

--=20
Tom

--TCNy/TQluL6x8a5x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfPCvwACgkQFHw5/5Y0
tyyOfgv+L2NTnAfCAw3GMzd6b9URMzVUTP1RH+sEV9qjSy7HRQXK/zK6hXx8fRbV
HkM4EO8yopoo1zFwuS1W1InQEgfZhM2xjpAi6KG42uHmzCn8Uc2nPXUGD5akM+DX
O+NFqSFqpibXZxSfkoxWKu6nmICPlOIMblvDZMR2QPsrXqTdeIBemlqu2+Kv+Kut
TAE3R0Ytw3VIZgYLvnyZ4NfP3eLpjIJbeKH9JGb0lvPsHXpJN0/peMLDALrzQhFr
OTIgj31nKObXTZ02DdXaqLfB+agWOTtXDPhkPQ3b5wwNFns1ZqNN3rCK+n1bzqlS
37cif6tnk4bdoGLqVJ5COwlWyJaXlPp/vuibx3+NiOMcG8jH0d6+fhG78JRZkgTs
qVYrevQwXaUYplFhSPm9Hcn3xiJFlbPUuUaPdmgkJK2/0b+20XjfZ6kVRbSsBGXn
vLd/l0cD8M3Ym6/iLMEL6i2+bDNG93FRinSwtp11GSIMstzmVm/p35hoq3WUPscB
G9IKiT0M
=Lqvu
-----END PGP SIGNATURE-----

--TCNy/TQluL6x8a5x--
