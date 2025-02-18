Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BCEC021A9
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 02:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC4D98001F;
	Tue, 18 Feb 2025 03:51:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="m9OJUcwD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C531807F1; Tue, 18 Feb 2025 03:51:29 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE0DE80017
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 03:51:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2fa7465baceso10003175a91.0
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 18:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739847085; x=1740451885; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xURkIJ91kQ9b4ThpCrOOHR1TLudlM/gLUDDEq1tXFY8=;
 b=m9OJUcwD3tOLVNUTvGgZ43BqngDrBExPB3+LOC5ZsOynUn3uRnspyPatcLdbK06z+0
 BZ/VmuNXJePOY+ynnFjNhTFxTj4dW+4ft81XCLnKUs/Odsgux9lCz/3tD7EeUzdIHhZt
 y89jn0jpHIaZuAYlNdQaAerOwW2TEF+3nVNsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739847085; x=1740451885;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xURkIJ91kQ9b4ThpCrOOHR1TLudlM/gLUDDEq1tXFY8=;
 b=gM+Kok6NcSMixCprn676H261SNJmwptKNMYALjRYjKRpPh/85ybaARv5VU8UQFbMgL
 LLgaUm5ShcLZGIiUSX/P3+vYaOkQgW0SwFvjo0sL9zQalQybHGxpPIhBS6Nc04ld4Jwo
 XgNN2Qoc91oh8IZBLnFCw1jWjrZ78thp7bmlNIjLldrt3pLXZUkqmFEQeBF7nExgedJb
 j22hX22ljtiVeMnIqVoNDNafJnvhfmQ3en+HnVUVUjaYlMkRf2ai7xNjr7qQt27cp7sa
 J4MqGiSxKwHIMJIlrzIiIuHFmwx/zlbCHpRM5Gnk5iSZozHT6VcSlQAKXTRcFp14myxC
 KX7g==
X-Gm-Message-State: AOJu0YyTwpxZsj812MtUAdxblDxWQZoIvJRKL9htvrcZ2Frm5+VqAw7c
 tDcexYY6e+oc7wywHmG3LD04NB6ZUWssbGKOxeumCuTNByJdssxCw2Xbfo7iBfM=
X-Gm-Gg: ASbGncvPENRnAJ6bnrQTQheKYiV6AiWt/cJ7GhhEJU88v0Sxclvz2NfnKsN8NU0DSr/
 VzSmvVflKeGQxBiq17Sge+Q0Y6LVHeH/lEyiQk+v3luL3FcNP9WjGWzlaG1u8/xYb55J1hQV4Ts
 MfceD6JwFLMoFF+WxPzplxshYuBDvUw2hUh8HZBOsgKlBQpd/KcSwKhcxjJgoXRknrCm/tHkVE1
 s7MYPs/ysvCAP4dcrCJcVCCSVZwiqeVHWztdbMIg0+dNtEmf/Y6Sm5/HSdEECqs1vVFx/7IjU00
 vcGLU+XvR93B5w==
X-Google-Smtp-Source: AGHT+IEvWd3Lx2JnOxF6Nm5/L27+C8upCTFdMc+fbA56k0LVBWnlSUy9bA3q/MPaZ1QMcGF/JRJyuQ==
X-Received: by 2002:a17:90b:4a90:b0:2ea:696d:732f with SMTP id
 98e67ed59e1d1-2fc41150747mr19016514a91.29.1739847085504; 
 Mon, 17 Feb 2025 18:51:25 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545c9casm78899535ad.130.2025.02.17.18.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 18:51:24 -0800 (PST)
Date: Mon, 17 Feb 2025 20:51:21 -0600
From: Tom Rini <trini@konsulko.com>
To: "Ng, Boon Khai" <boon.khai.ng@intel.com>
Cc: Uboot Open List <u-boot@lists.denx.de>,
 "Chee, Tien Fong" <tien.fong.chee@intel.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@intel.com>,
 "Maniyam, Dinesh" <dinesh.maniyam@intel.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>,
 "Zamri, Muhammad Hazim Izzat" <muhammad.hazim.izzat.zamri@intel.com>
Subject: Re: [XGMAC dt bindings v1 1/1] dt: net: add DWC XGMAC binding
Message-ID: <20250218025121.GB1233568@bill-the-cat>
References: <20250117031535.19595-1-boon.khai.ng@intel.com>
 <20250117031535.19595-2-boon.khai.ng@intel.com>
 <20250117175638.GV3476@bill-the-cat>
 <DM8PR11MB5751359F31EDC36DABABCF8CC1FB2@DM8PR11MB5751.namprd11.prod.outlook.com>
 <20250217145338.GL1233568@bill-the-cat>
 <DM8PR11MB5751CA4FBF5317B3F871D01AC1FA2@DM8PR11MB5751.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oFokxLvLJXck68+N"
Content-Disposition: inline
In-Reply-To: <DM8PR11MB5751CA4FBF5317B3F871D01AC1FA2@DM8PR11MB5751.namprd11.prod.outlook.com>
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


--oFokxLvLJXck68+N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 01:43:15AM +0000, Ng, Boon Khai wrote:
> > To be clear, it means you should use the same bindings at the linux ker=
nel,
> > which we have in dts/upstream/
>=20
> Hi Tom, okay got it. From Linux perspective we are using both below:
> 1) dts/upstream/Bindings/net/snp,dwmac.yaml
> 2) dts/upstream/Bindings/net/socfpga-dwmac.txt
>=20
> In the case of U-Boot driver is mismatching with Linux binding (which is =
unlikely to happen),
> I will need to submit the changes to linux mainline to update the binding=
s on the changes?
>=20
> In summary, can I say, we will drop this patch, and just follow the dts/u=
pstream binding?

Yes, exactly, thanks!

--=20
Tom

--oFokxLvLJXck68+N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmez9aYACgkQFHw5/5Y0
tyyzjgv+IvZ1zkfjamubzfUsIvrcsz8UEiFnwI8mPWkTQhfF+2qzMm7ZzCbC7sNQ
q4uoQtyme7jjUpQCGvTi0ueHva0lUQlkWMA5n2fU4vK07KPqoiFLkwd0IyfMBBSL
ZCc/v7bvLFS3knbkldmR0Va0JsOV7S8EZZ9Pb5Yhf66iwEc43QLcrdKDx2tAPpGA
nXAY2hx3+RhEMHej8m4pnf714lyo64MfZtl53D8yjh4xDfet4n6myFhFMRNI4MXR
qNK56bisS9SoQOEtYenUTZG3CsqqmWXgETw05iqu9SbRmIE602gSMfNyPIBUbZBi
psP3vh0lD0LeYJDDebvPDTzwE2sqK0ZPCKnoLapF4JcwR04KhTHv5TIDSf3ThnVg
X+8igyBAlN5gut/UnjJEOOkrRQ5KqYp0KzHXLRD9UTF+PMV5mCxdu6AoEh3gYsYv
JxuQa1VNmq3qZYHHKhI01beZKIGqgSP4mS26Et8MVSyPrmStts9rFwNwL5xf2H9E
YcswDnSr
=RImK
-----END PGP SIGNATURE-----

--oFokxLvLJXck68+N--
