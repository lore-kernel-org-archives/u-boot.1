Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D8CCD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 14:23:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71F6584898;
	Tue, 26 May 2026 16:23:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mJMwLbXV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDC85848A1; Tue, 26 May 2026 16:23:39 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B0DB846E2
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 16:23:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-479ef2b78f3so9671226b6e.2
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 07:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779805416; x=1780410216; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XCNiJ3X4/omD3KxGvhao01CdQW2v9dSols9SeXKfo4k=;
 b=mJMwLbXVXloLGYYQZvB/Du6sycy6D8oFJr0YTukpWIfTU28dmi9kT1iVfYuxzauAfq
 bGVSeNv+Av8jIflwq+xo5GhZ2jzEKy1YuntkZzPQLD18e9cwavQ/pCerBofTKZ4y7AL9
 /6QYMDMqo6H/uVTccoW9eAJg9mWbfuWSeZs1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805416; x=1780410216;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XCNiJ3X4/omD3KxGvhao01CdQW2v9dSols9SeXKfo4k=;
 b=Z38wVBf+DAXDiCGL6t+tR7K7hjjHXmP57UGFtWhokGnW6gD6w5RP1dsyZqMQaIx31q
 9Y4x/PdzrcWpSm5Ynbsq9aK/P6Sfykxqu9W8FzxLp2FlFze/xJQCmRZNesBtCmJ7YfTa
 n09YI73WO4lWdyzH85kJzo/eYXIFDcq+eHjgLPYidWPg247nm731ZWp17JjpEWD0CSfw
 GEFt9qB7pFy+Uj4dWVsYfBuPh6e2mSWRR+JeHaijK5h+H0mszj6aqj+ExpRnrM4T9tzk
 lM95GDJ4KyUeOinsFQmk6lWnOBATDqR/rvByVTKTlf8e5+KU0GAuAvs4MXSQ0DjBTWsJ
 QuUA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8KVGIyAhJL1pVuLXte7FaJf3KjQpCxMkQ6TaMTX1H9oJOeo/nnCOOM7rBbC7jGZANKtHxZyDM=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/wQfutr5Z8vB+pBjY8ZufZIdcmRJjyV1zV8vPmYtAC/KOh1mN
 XCs/XDma3GE0c+zfjO45XoBtwAQ0It7/eb1+JM6G+uCGeMITq608XbgPsMxCFoKuciU=
X-Gm-Gg: Acq92OE6fFWFdw5NRUzJnuXwWaRXdrkCVnbIWqRBan7jG1cztSKy8zhif5iGzkDvO0q
 eIGbiK/xe7mYFt0ejPwrfZX4iNfLdT0nH+2jzMBRG4g6pNmb1iLvKcomB0CkadRw//wCfDIWxpl
 5yNhX0tlGNZzMQVRYIZ/wz+GqR8Nhex72X5EKph/c1C2qhl7xBLzwN8CaCH+RkwveTYWh7rYvXd
 r9ZU/SQFtOBN0H6MorlO+0icQcaKdOod3mSu9DD6wJxWXk3DssA03QX2xZBaYXVS/LTZjGgSQAS
 SnZ9zCb4Yt8Pya8XDJBPog1uhTrQBLBVx4/KABd72b6vlm1TCCkHmKuWBclsEa0PL2Fb2MwVRwu
 D9/0OFne2eDo7ajIjMCWmfhp9sBINqiwoHqsmzM2r4nqoH6HT8xvgt7DNnoyhP5kg1lJ811QJHM
 5MeSqt2/ZSzt08ws2wb/3ylpmVEhgJi2y1EJTsCn6JgiMei9JuU4/9kM9BESq089Lakgnf6rTT+
 bDatltCe+xw7Q3dDnm6Fit1N6DlLAlJpztMwIf3iy9+T6tGO1Jk17A5
X-Received: by 2002:a05:6808:c2d9:b0:479:f370:fac0 with SMTP id
 5614622812f47-48549ec2492mr11639814b6e.18.1779805416287; 
 Tue, 26 May 2026 07:23:36 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-485b23b6721sm304091b6e.15.2026.05.26.07.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:23:35 -0700 (PDT)
Date: Tue, 26 May 2026 08:23:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Javier Viguera <javier.viguera@digi.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/1] libavb: fix avb_replace() OOM handling
Message-ID: <20260526142333.GT1858239@bill-the-cat>
References: <20260521165122.17475-1-josh2@disroot.org>
 <64b5a656-d73d-4c72-95b1-3c843b18c2f1@digi.com>
 <87v7cafha2.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NbjqU/YF5suptdJs"
Content-Disposition: inline
In-Reply-To: <87v7cafha2.fsf@kernel.org>
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


--NbjqU/YF5suptdJs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 03:10:29PM +0200, Mattijs Korpershoek wrote:
> Hi Javier,
>=20
> On Tue, May 26, 2026 at 14:52, Javier Viguera <javier.viguera@digi.com> w=
rote:
>=20
> > On 5/21/26 18:51, Josh Law wrote:
> >> Hi folks,
> >>=20
> >> Since I am a new contributor, I would like to introduce myself first. I
> >> am 15...
> > Wow, we have a "Benjamin Button" case here. I seem to remember he was 19
> > in the kernel mailing list ... :shrug:
>=20
> Thank you for emailing a about this. Your message made me curious so
> i've found:
> https://lore.kernel.org/lkml/cbd0aafa-bd45-4f4d-a2dd-440473657dba@lucifer=
=2Elocal/
>=20
> I'm no longer sure now if I should spend time reviewing this patch or
> not (because of bot suspicion)

Yes, I've moved to Deferred in patchwork as this is an extremely
disappointing thing to have happened.

--=20
Tom

--NbjqU/YF5suptdJs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahWs5QAKCRAr4qD1Cr/k
CuH8AP4yjsAKwTCquMsNhM9O5sbLfwLbcQgsxO5K4WEh+5M7kgEAxR5aRqIGdQE0
fhAePE01GKqHlMKdkpswQ2MuF7aTCgo=
=ZroF
-----END PGP SIGNATURE-----

--NbjqU/YF5suptdJs--
