Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C537BCAC5B5
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 14:10:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4894D83071;
	Mon, 29 Sep 2025 16:10:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UDohRe2+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13E8C8329F; Mon, 29 Sep 2025 16:10:24 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFF7082A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 16:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-79d36a6298dso2009968a34.0
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 07:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759155020; x=1759759820; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZqgxObub3NNh0Rs2OWtaffJ7xm6xVSJVZAN5gusrRvE=;
 b=UDohRe2+vz9BrjFw0tt+MYnSOEdfzD57R/grlJcHJspRu2UEp6fO5YJVgs+zdZC/K7
 PBKlo5T08pSNmuea8f1C0C+cLqQRWSekmXzPbxcgLJY0qm/yH/tZQ63fXYr9JNS8iSJE
 xhl040ZE59FTwk8exIIEz9aoFpwxkLxsFd/HQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759155020; x=1759759820;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZqgxObub3NNh0Rs2OWtaffJ7xm6xVSJVZAN5gusrRvE=;
 b=Ykc6mnPSG3ILXzYK2M95jimeoqvAlpuQzazmzWUlFUhObitBJjs/Qo4dhHtzQsuaWa
 +XXcjAInOx4sC7FNLCfIRMk4sGkiHY1tzlLbQBW/59ugsL10iyNxXURrx7aImr1gi5GG
 odkJ4D+Wj6vrrlEhO3MZJSfQSLlerCFff1Vi6ILrrztcjgYcEt7cp9Iw2sOdo5kMP3bd
 428KYBxRj8bOKObN9UmqV6W8qu7NWLS1EkHriKwTPUYS49Rva5cLG8tLCed1pzPsOXgL
 AM5O4eXbm+xkfvgolhpaBGEt0nopKNwpENrXNH3AuWMVxMT21TbpoLBR7bPFMf2oI6wW
 9glQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFqXC5r/h6NKGARMj1bAg+AC14txrM8d8xhHSMNp+aDEPNaOhDeVR1pIRLfkwRewq7Z1m/uxs=@lists.denx.de
X-Gm-Message-State: AOJu0YzMGqLHQYW9XYiSllimFR477Gg09VvpPCQcbnkFiMUKUb0lueeT
 AqVRXanmph9qtONl7396s0ksUH0w3TqlrP6Y+0Avz9kiyPt6felLH7wkgDba6AeMfQA=
X-Gm-Gg: ASbGncszEmLFOWXSScPdlOLIPnRYS573mVUUYGOQ1IQvxXXWU4OZ+kfCrMOgwwWZGhR
 rw8uD6iCVl9NNqv/mIRIcy28igs0xVUr+gjN1iYBXIdOZeUiftG5OPAictgT+D3vCgxFPXFkJ19
 syBN/37JPhJdMQPPHyHeQwfnKl5vdIZ9A1rbluIVTtAA3h60vNpXJ/mNtO+kuowrtY2co7ZGWfz
 T0uwvVoIBEv4FfUZJjbiDEyFTP/Y/4P50aLmumNdq2OB225QLm+aK9bkAUutCB9WxkIX7XyGdOv
 Z/Lhc9+qg+h6kN0Ozyk+hoCVrBPhW81jMwSvWgU55hqn53wEjcRYTLD75xMJ4MS6H1cdz4Ukm9g
 HbtPZFaCYWxYSopGumr/kh0sVEgcuC7UXzESgghCvRCcebVfOFG6hwuku
X-Google-Smtp-Source: AGHT+IFl5bqyMpycmSSINCLNFp/PVHkyExDfvQEj415FPft/PZXZlKhqjkUvuwBBM5NwtOU3APW3NA==
X-Received: by 2002:a05:6830:2816:b0:78f:4791:5aec with SMTP id
 46e09a7af769-7a04a207786mr11084312a34.21.1759155020535; 
 Mon, 29 Sep 2025 07:10:20 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-63b1edd2f88sm1236486eaf.5.2025.09.29.07.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 07:10:19 -0700 (PDT)
Date: Mon, 29 Sep 2025 08:10:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Anshul Dalal <anshuld@ti.com>
Subject: Re: [PATCH RESEND] usb: dwc3: Remove redundant test
Message-ID: <20250929141017.GD6093@bill-the-cat>
References: <20250929-dwc3_ep0-v1-1-1d5c58933bde@linaro.org>
 <c65b682c-5520-4814-a6e3-42a8d39e2060@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vgAZNA1zhEe/JT2q"
Content-Disposition: inline
In-Reply-To: <c65b682c-5520-4814-a6e3-42a8d39e2060@mailbox.org>
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


--vgAZNA1zhEe/JT2q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 03:27:19PM +0200, Marek Vasut wrote:
> On 9/29/25 11:11 AM, Andrew Goodbody wrote:
> > In dwc3_ep0_complete_data there is a test for 'r' being null and the
> > code will return at that point if so. After that point 'r' is guaranteed
> > to not be null and testing for that is redundant. Remove the test for
> > 'r' being non-null.
>=20
> If you really want to make this obvious, use git send-email -U20 or some
> such, this will add more context into the diff and include the relevant
> part:
>=20
>  793         r =3D next_request(&ep0->request_list);
>  794         if (!r)
>  795                 return;
>              ^^^^^^^^^^^^^^^
>  796
>  797         dwc3_flush_cache((uintptr_t)trb, sizeof(*trb));
>  798
>  799         status =3D DWC3_TRB_SIZE_TRBSTS(trb->size);
>  800         if (status =3D=3D DWC3_TRBSTS_SETUP_PENDING) {
>  801                 dev_dbg(dwc->dev, "Setup Pending received");
>  802
>  803                 if (r)
>  804                         dwc3_gadget_giveback(ep0, r, -ECONNRESET);
>=20
> Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>

FWIW, to me updating the amount of context in a sent patch is a style
choice. Yes, just a few more lines in this case would make it clear but
in lots of other cases to review you need to look at the whole function
anyhow (and sometimes catch other issues / places to refactor things for
clarity, ie the pfuze100 patch thread).

--=20
Tom

--vgAZNA1zhEe/JT2q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNqTSQAKCRAr4qD1Cr/k
CnshAP0f9wjcl4cgkU4XWEPZV20Y0FppYTKkxJft5ammSykt6gD/WUuCyMFhVLUJ
JTCY978fgrgFDhkXfhVsROZW8DmEuws=
=88lL
-----END PGP SIGNATURE-----

--vgAZNA1zhEe/JT2q--
