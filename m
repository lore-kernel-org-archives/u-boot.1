Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B113C25B75
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 16:16:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CCAD88302;
	Tue, 14 May 2024 18:15:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IePmyE7s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF1CE88302; Tue, 14 May 2024 18:15:51 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1FC187CF8
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 18:15:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-43e0d564136so17531731cf.0
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 09:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715703349; x=1716308149; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=U2HCTbmVmtSeqhZvI8j7PIDoDmHcLHeZcrUiKmVn0OQ=;
 b=IePmyE7sOLGxtebXq9IWVFBzikR/Vu3wRqcKkgt+T+6IupGBOnQvS/nI+2iMOmTITM
 x/eoq5ZYhc7FZTCd6VXDbgDdj20KrEh8FAAYeqXqIwDpvyk/SGjFy9mnpATGCOYRPgyY
 SwwZ6KlAbOaavcE7vTJJBJnNmWPKuCVMIDxEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715703349; x=1716308149;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U2HCTbmVmtSeqhZvI8j7PIDoDmHcLHeZcrUiKmVn0OQ=;
 b=KYDepVp1PDADIev5aAIBvwjihOwYfIm8XtgWHrOBc7YRXFJhpgnRLWpBvDi6unp3UW
 DEfnIft9DcA39/+yxC5dLS7AH/xoutAIPvuJ13Io34pTCazoWqLpc+2s4zq4c4PObLN+
 LGgL5v8TnJ3Iz6n/d9q2Tr/iXUbVuLdOapo4U1AZbAbXDsZLkuio/poJK8iMPnmxfiHI
 75R/zWnel3SoNE7Bf3uK+m1icELVeI7iKTeJqEx5ipsYDyCFIIeYTMVYVzg7T51L882c
 LQU9BPuZ5xEPTZ7cKKuVMOZHUUxeH3umZlUYn6VegX079tYaDYq6SJc1c6UZHCZ6yraS
 JEOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUltVXsSFGhIwGtZtNLpxvxS421cjXLS/d9J9gaiOSGFjtubDZDyLYcxBwcXlLHo4JE+GTqwm5tdW3bgtFwLIo9rj/dyg==
X-Gm-Message-State: AOJu0YyPJUGWvCqJ6mZLnXRf+mTzBMhVx36fLl64EntCIfC+u2+s6fYl
 62A+AW60m97ESecZgo2GuBgVSHc4TLI9fzarsnUy2iYS4V/uWSJZaomjB0X1rno=
X-Google-Smtp-Source: AGHT+IEsETOX2kcPE+v7tyUJk7HbyxOcBxT3AFnt/GACRxtaDm1hWDtxlOKe9jfNbHfoVoSZxJRgpQ==
X-Received: by 2002:a05:622a:24d:b0:43d:e0ce:951f with SMTP id
 d75a77b69052e-43dfdadf6c5mr155372851cf.25.1715703348737; 
 Tue, 14 May 2024 09:15:48 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43e1c32e8basm23832951cf.36.2024.05.14.09.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 09:15:48 -0700 (PDT)
Date: Tue, 14 May 2024 10:15:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] arm: mach-k3: Move code specific to a SoC into that
 SoC's directory
Message-ID: <20240514161545.GR2568172@bill-the-cat>
References: <20240510202124.794448-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MnrgoP9UCvvKaZPE"
Content-Disposition: inline
In-Reply-To: <20240510202124.794448-1-afd@ti.com>
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


--MnrgoP9UCvvKaZPE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 03:21:24PM -0500, Andrew Davis wrote:

> Each SoC now has a directory in mach-k3, let's move the SoC specific
> files into their respective directories.
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>

Applied to u-boot/next, thanks!

--=20
Tom

--MnrgoP9UCvvKaZPE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZDjjEACgkQFHw5/5Y0
tyzLlwv/aF/CK96MU13CWrQjGWu26CwPEhEYV/MsodJXHPLR0lJ9AtNZoG3d4AUL
rq/pFuI3V2c2uOLzRZXnZIPMDtrY+bnVI+/D/HqYj9lbDzjFTkRQomGV0nVggbEG
02Q0l14drR+SEiFFGnMkEnTclVYsIAkHkndILFIh+dm8FgjMRNiWXLTmLCS8KNRY
88BYfpFa21OotXufM703kNE93e7PbJzbNKsr7ztLFs0gUv3QKy6SgqNCbZ1fF4z3
H4FOn+mISYbZyktBHH3Qf6IWzTj7P4cWr/ua+epJyoLs3Mt/7MaQJZVBU45oalHL
GN0qs4EFFdlplSWHiAUp5qq/D1A6qRMKu7+J3DNblTrv0f/g5yNDksLzMkbSdVur
z/tLpp8t6OjGIENAbYu8RkLkbr8GnFd6UIB0MxFx2XmkxNPirD261VzgUtekvyy/
GN9kZaZkObdrykYxXiYIfm0dsktRuUfo7uELexwjk0lzByVrF1p9n8tSrlBR133S
agvq3OWo
=aC5F
-----END PGP SIGNATURE-----

--MnrgoP9UCvvKaZPE--
