Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B90AC369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 14:27:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60B0782958;
	Tue, 29 Apr 2025 16:27:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s+5gaw8h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 701E88297E; Tue, 29 Apr 2025 16:27:22 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A35398293C
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 16:27:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-72bd5f25ea6so1576365a34.1
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 07:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745936837; x=1746541637; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yorBtIyUyq9f1q/VDS9irk8bYq1okeVJx34lSyrcM7E=;
 b=s+5gaw8hCRoj9QusA9npkF1JSZyk7/b1dZlAzRU1KYRGZvBzBjsXvrI8ifIxqQVH1T
 NDOIaRiJOdC9D7eLkbWL5OirgBRpJ7tMLUDS4ub8Yhj/asuQw0c2gFii0o8KtE4sbhFU
 CCslBivuYmyLw29SfLd0zx3NeSBMg6kLNriLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745936837; x=1746541637;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yorBtIyUyq9f1q/VDS9irk8bYq1okeVJx34lSyrcM7E=;
 b=eqhLarhPFZv07MbB9mlff6r8F4B7kjRGS59w/GmGJiqZKuW3xjbf09wv+kz2XbpxUV
 Da/rS9HleyzYs7OKcZaGrj9DOKgFpf3LyfIGOA+ey8uAfv9EXvj/g08LC/ANtijFpuIH
 BTIHnn4JmqsWWpIgaJ9+xFwUZnh2jBnlyjnzTMfLJWKFg+D+IK6hsy62Kz9lHFgvsy0K
 KHeUT0KcBEuBrlWlfVB7PISDxitBLXLRJZ7Eu1sk4l33OfjLd8P3aZjPEg9nKCGuFlxw
 aUOWlOuOJ9tVsRfkFn/pY3jblwvsflHZ5SKTlmBjJeRJFyzc2WJaqx8XIJUaLKnZGmlf
 JklQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6GfKsQklfl+q9UXoqY8Sv8F7g6ccGdWHAmtJjkqHpgtY6TD9nSe3ALeBdQ8w0vEEW+oT2TA8=@lists.denx.de
X-Gm-Message-State: AOJu0YyyTpt+sR26sTt9cidxQxgIC/UEyzg9NIIvDVTIE5qF68FHORBt
 HP03pbsSNZ0Ubf7gXZl8/6xx9P0eDj9zi0iiqbw7Wt4AjvViNujWcUp2iOjjKZW07W7jRhc5zQv
 r
X-Gm-Gg: ASbGncuA3azXIF4rrcTMr+r8z/QM5w9PewshOjWrY5EygLkLOv2UMPuOI/0lGpY0AHM
 ylYUq7PLMSW9xNtqKezBfSjDAShRiOm4e5K1aeUXzcEfT1G02dCVAYjxfqrDNW7tjFgb4CUgcaD
 mYKa5LE/P1g/iyLCN0o29TTtUFLSVaMy6SmM9kyb/Y/HIEayvsgYz65HdAUz9TmwF+657G5zVY8
 gN+Eis/6wvXiB9P9me7EzyUHrHR9kdInPPIpqeXprM7cAdBMhmXKGsvRhXORiMKK2H12CR/Bove
 fPr8D0TxZVhE+HKBWSnQSvFs8LPaWweuX6c44wfW7gBhr0rg1jByeLFoU9pg/zJJGu4RmEcNbTc
 tnA==
X-Google-Smtp-Source: AGHT+IGvKIOjHJen8zqAtNWvL/+kQnBq72ONnnQHpxxSKmKQoc/QoLrgV7R00g3+9ZEvnPmNdTWmKg==
X-Received: by 2002:a05:6830:d1a:b0:72b:a020:a2c0 with SMTP id
 46e09a7af769-7306526343amr8163087a34.17.1745936837331; 
 Tue, 29 Apr 2025 07:27:17 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b315147sm298029a34.65.2025.04.29.07.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 07:27:16 -0700 (PDT)
Date: Tue, 29 Apr 2025 08:27:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: Re: [PATCH 2/2] tools: Update the license specifiers
Message-ID: <20250429142714.GF1261075@bill-the-cat>
References: <20250429131515.244061-1-sjg@chromium.org>
 <20250429131515.244061-2-sjg@chromium.org>
 <016f585f-fd30-4604-8676-c7cabd9e40a1@cherry.de>
 <20250429135241.GC1261075@bill-the-cat>
 <290f70ad-bc06-41cc-910f-cecb89bdd6ff@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wo/4MA6PZkvaq+T+"
Content-Disposition: inline
In-Reply-To: <290f70ad-bc06-41cc-910f-cecb89bdd6ff@cherry.de>
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


--wo/4MA6PZkvaq+T+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 04:04:32PM +0200, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 4/29/25 3:52 PM, Tom Rini wrote:
> > On Tue, Apr 29, 2025 at 03:28:35PM +0200, Quentin Schulz wrote:
> > > Hi Simon,
> > >=20
> > > On 4/29/25 3:15 PM, Simon Glass wrote:
> > > > Recent versions of Python complain about the license being in the
> > >=20
> > > I believe this isn't related to Python but rather setuptools.
> > >=20
> > > setuptools 77.0.3 and later support PEP-639 which recommends to ditch=
 the
> > > License :: classifier for a license property.
> > >=20
> > > The issue is that this license property also changed in PEP-639, with
> > > something that isn't compatible with pre-PEP-639.
> > >=20
> > > Therefore we need to bump the minimum requirement for the setuptools
> > > dependency in the various pyproject.toml to 77.0.3 or later.
> > >=20
> > > I'm also wondering if we don't need to add a license-files property (=
also
> > > PEP-639) to comply with the GPL-2.0-or-later which requires to provid=
e a
> > > copy of the license.
> >=20
> > Thanks for digging in to this more. Is there not some way to both meet
> > the PEP and utilize SPDX?
> >=20
>=20
> AFAICT, the license field is for the SPDX identifier.
>=20
> Not all licenses require you to provide the license to comply with it I
> guess? But my reading of GPL-2.0-or-later makes me believe that we need t=
o.
> You would then have the license file(s) included when license-files conta=
ins
> a file that is found at the root of the python project? I believe that the
> default value for license-files is ['LICEN[CS]E*', 'COPYING*', 'NOTICE*',
> 'AUTHORS*'] so it could be automatically included (and thus the
> license-files not be explicit) if the license file(s) is named like that.
>=20
> It isn't necessarily a big deal (IANAL) to not have the license shipped if
> we don't plan on pushing those to pypi or share sdist/wheels through anot=
her
> mean (e.g. GitLab/GitHub releases generated with `python3 -m build`)?
>=20
> I am not sure exactly what you meant by "both meet the PEP and utilize SP=
DX"
> as I believe they aren't related here? I mean, license property is the way
> to define the SPDX identifier in PEP-639, but the missing license-files
> doesn't have anything to do with SPDX I believe? Just that it wouldn't be
> complying (I believe, still haven't become a lawyer in the last few
> paragraphs) with the license itself if the license file isn't shipped.
>=20
> What I meant is that in order to use the license property, we need to bump
> the setuptools version dependency in pyproject.toml so we're sure we're
> building with a recent enough setuptools.
>=20
> Let me know if something isn't clear, I just happened to have had a glance
> at the PEP this morning for another project, so I am as confident as some=
one
> who spent 5min reading a spec :)

Thanks for explaining more. I misunderstood for a moment. Yes, we still
have "Licenses/gpl-2.0.txt" in-tree as the license text itself so we can
point at that I hope.

--=20
Tom

--wo/4MA6PZkvaq+T+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgQ4cIACgkQFHw5/5Y0
tywywwv+Nk3rlSc3+hJ94JaNEt8Y/xk+hzo1t534ei83tCX1Dtb3ots8TdB4sZe/
uP8Q9Gj5WzFNYBJ0eu+EtcGlpSKxrDn99xatMm326JAoBjn/RxqJ52bWtOk9tak3
gixFL2hGd9UBk6eK0H8ENXmsdiKUTksE59TqXpZkwJyoMx8aIrWbx896ugVbmSiB
0XHF3STY9kBbIiya9Np7accVwR6SQOLCoUyXTTmhDcvtGlSo9hWfVV1ZL/Gj7Cs2
WUtVXXSoHC/ans0atBbAWzjeZ4QvW0qrLQnBxfYeYao/ya6asF5cDOqUlKQDqwrH
S/NyyZ9oaSDSjXi6LL3gr4jGjUI8SXh4cSXfzUQqfjrGkFYqSgtV00XH+saajbFj
xHofnl0fWJtqoqCW1B2Y+kOPtzjjHzCn0pmgPl0wYYVD6VANAWEybbzwRf+BgiPA
8xu5yTnHpaOlBCh/5QJ8dO/KGh4zK/gwTdRVdTALgHLL8Cp2hoWYE4NKnfCJQ+D6
5KIgfW5C
=b8tX
-----END PGP SIGNATURE-----

--wo/4MA6PZkvaq+T+--
