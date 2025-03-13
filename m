Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E2EC282EC
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 16:18:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B00580FF7;
	Thu, 13 Mar 2025 17:18:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kNbuBumP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73F808169D; Thu, 13 Mar 2025 17:18:19 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B78A80F9C
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 17:18:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6e8f7019422so11256786d6.1
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 09:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741882690; x=1742487490; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ATvVo7wnK69X1zMxLPh1oskLNweMwhbZmQsfdT7qWDw=;
 b=kNbuBumPAhBNgjCRrtw3dYUU76Nq1U6jZufafON7RUR4sddwBvy//1I/P3xkR3SGhD
 qH/4kkmjmaj7pC6CGDv5KIA/7KvP0UAvkDxeZsNb8FZ+A8BcBMTiFPqeiqogZhCHU7XN
 rUh3evPW8xNATQv7M1ufuv9kdXQCR58GmUXnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741882690; x=1742487490;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ATvVo7wnK69X1zMxLPh1oskLNweMwhbZmQsfdT7qWDw=;
 b=L+FxmlQDkVVfLKUbvaK18tbtm1pF/+7JmEg+Nhi0Kv46N0YitqtRzNfa9IYu3YNSOp
 zT1ldlQU36O0zroGelcQW+pPFqy3JrGasJ11zZni/OwyRhRNGlD3wJ4thnrh/DRNF6DB
 eVJvb+oKW1/V8quirpLoT/nF2/bsZgfGrpWLyeuBVifYZOC9UoSqoRpos9B6AmWS/Vyg
 DPtZalu+IrOeSA7fwldGA/b/j1OAKmmaC1o8DqU91RUR9+SuScKBrcKSmGedYk1+pBkx
 2vWLFHlposOdW+RlND36rq8YJVEqvDHKVUvQOUGu12JW/eFdhnkYyvC9sjdl2yyf3vHS
 QJLg==
X-Gm-Message-State: AOJu0Yyo76xrWfaQ1Eci23BvhWr+juMQs1AZPpnXOXke/SfrcvjjGU4q
 jsuFOZHd+eVkzow+F9Hdt3jI/kIDh9HA6e4ugNp0vZlj7LD2YHndRaJbFvS6a4k=
X-Gm-Gg: ASbGnctkhWuNG0zTt9rZgtQJepq8m16eA65PTNH8zwBavlYerkFB17PN8ChTElgQcau
 R6Afz1gjqEGBptIyqnySSA6N5bX8NHl5J4iafDklrNa32PQtzfPwRpziEVUkMuBdN0POVwG9yB6
 Ev89UwCrrvNQyxcjA3iWG+loFfszgLkk9v3RJ30e/NQeqyeFbwhuZIDedrZdFeZ1e6mADGnqisK
 7BGsliEChmBlAIKrDsCRF86z+qoukZQNw5CN1dUXwZzfb1DH9oOpGe1M7NigA2qrw9UCovjuqAk
 9UIlG6kXK06jxDwUNtrbCqMy6psnGgNrf5dh/mhQC4smHqZDytRIfCd7
X-Google-Smtp-Source: AGHT+IHjLGt4H/LBUPFUmUXm2okqZtnBqOc12UbTEDvK4mMu/BrClSuTYwbZefRfsrBCWhLOVfBISg==
X-Received: by 2002:a05:6214:c83:b0:6e6:65a6:79a4 with SMTP id
 6a1803df08f44-6eae7b5254fmr3139076d6.44.1741882690447; 
 Thu, 13 Mar 2025 09:18:10 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade209beesm11277486d6.10.2025.03.13.09.18.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 09:18:09 -0700 (PDT)
Date: Thu, 13 Mar 2025 10:18:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Harsha Vardhan V M <h-vm@ti.com>
Cc: u-boot@lists.denx.de
Subject: Re: [RFC PATCH 2/4] cmd: fuse: Add fuse writebuff sub-system command
Message-ID: <20250313161807.GF2640854@bill-the-cat>
References: <20250313115517.1181829-1-h-vm@ti.com>
 <20250313115517.1181829-3-h-vm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oyHuEjOattV/0a1O"
Content-Disposition: inline
In-Reply-To: <20250313115517.1181829-3-h-vm@ti.com>
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


--oyHuEjOattV/0a1O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 05:25:15PM +0530, Harsha Vardhan V M wrote:

> Add CMD_FUSE_WRITEBUFF config option to add and enable fuse writebuff
> sub-system command. Add fuse_writebuff function to be invoked on
> writebuff command.
>=20
> Signed-off-by: Harsha Vardhan V M <h-vm@ti.com>

Pending updates for what I asked in part one,

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--oyHuEjOattV/0a1O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfTBT8ACgkQFHw5/5Y0
tyxVBQv/WY65CvNlmX/0mqKTLLUNkynyTDtP6prl3y4M5mW1mT/yMVCo4anVj86v
lpiyfqR5m4aAnwM1NHqmkcvhaAHVGctL4xUc+2OhEG8zxyIrsYF/yj7cSphYb5an
Z935zv3KfL9Wtvb2dAya2UVEk7t4eedkG9mB5JOM2zqBwoQHsz5bnNp1qDVDF6lt
DQG5XZJY2l1K9Sot+etbwqDRvpJVMBzxNZCTww8to36sNJH718qFTAC+li1ibbHW
tmIkc/xHBRee3cXCtxfl4pEbFyb6k0dYrUBLWhLSARtg+yiUk+B3rz/aqifeOSXn
cY+eFw/K50BDt1sPUQ3EOkRStMYRbK15wutiOA5sUyDpBNeyJRi3XFwuN1ub9W3w
Snlo2p33IVlBWICKRt/NvgXYbz8FWYSmwr4DjWLAiP4vB7YK/jiTo/mGv846s0mg
Iqucp4sR2WUD37jbLKNy3AnK/uCyA7qTZh3f3CH2N138g0tZ3YnMsrh33HhGSto5
5KcakFLu
=tntX
-----END PGP SIGNATURE-----

--oyHuEjOattV/0a1O--
