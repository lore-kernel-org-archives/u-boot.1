Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B265D1A639
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 15:03:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 934888432F;
	Fri,  9 Jan 2026 16:03:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HUdw4K3y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A25884358; Fri,  9 Jan 2026 16:03:27 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 398CB84248
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 16:03:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-3f11ad6e76fso3602180fac.1
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 07:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767971004; x=1768575804; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Bt635VS3Pc9WB17KFLlWP6qJHC3j/H+4fLYR2OSS79A=;
 b=HUdw4K3y8N2I/kVpu503AKgrYLYXF8WwKnYqT7eKMT7zJ9cej4CPw0f3x+jeFscf4w
 oizof6vghvyBCcwo+ztZvYgfm6RJ4UzC8Oee16fsABw3YHYf+oNCIKykTC4VICECRrsc
 hLeDLA79G0UdMTbvZPOB8HXAbY2humsGl1iFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767971004; x=1768575804;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bt635VS3Pc9WB17KFLlWP6qJHC3j/H+4fLYR2OSS79A=;
 b=W8dRn2ciASW5YVy8brNiYBr2K84Q3Sd0UtPW1jGSGaGe8KyroMsH7WuaQFlroLBJhK
 SeK56KaICUBX7SMAH13b/+5DbT7b+vsHI942JMyNq+E/4ds9d3tIN3LubNz2KhWXITP3
 DbG0sx//svZ6Sgx+czlKv+x0zJFvUx5UOH6Ty3szKd0OuZyebFBwMhK0+zYuWYownxsN
 h6GtkZY9yhjwgnpgg+VD63FoCLKevWNXGKQjBYU/FD3ipEYDg6pcqa7C4p5t425WV2+9
 c42sgQfzFkSrD6yVylVpiJ/gL2lAtxCwk3iabvqkCJcmC1XuDUML59Pbs2RqxYKIxfF/
 vKhw==
X-Gm-Message-State: AOJu0Yxm+t1y+9HEXWXZNVQip05Pzn7l2x+0N5sYOsPumTpVRPZkMG6R
 noHRwaL56peNZ5Wu6aqZGLT6kmCJxyrYEhC4T3L959CDYCwwMOXjY1TRDa0nzCFinjw=
X-Gm-Gg: AY/fxX75kImy+WOx4GMWX51yEOn1PcQEJjfRdl8mvmgLfWXND76l+ZJkR5+Up00TNw8
 0H0seDEVTdsa28fEiUjxltfNKGtSUtQCn6hklZ2vkhB/iIAcLfo1KKpOFmK0xyrXx3GVSvhopH/
 NiG7l74zALSCwog2LgGrNBwlxVqFiYEgV67jHKO4AbUPBRbUwJuM34OpSQob4glb/Uh71TgNov6
 9J8Kk5QxgdCXgU/RgzvdhZ1ioshpHlwPYvWh9/ap8Z3zO+cEFnuTkoNtk0KAPeP68XlYp2fWQhq
 pOC+o6PwxsbKciTMbneHaP+ZBe8MGJSvmditJmlyJcLXcwk4df85iZZMPs0/BtE6wD6WF2JrhiV
 BJhSjkMkVSsUYbEKWhZ+1cuaUItdn+2oDeR/ZkkDmXSms4YcVIaPdgico+R3bCv+Y0EJplH5ULa
 LTA1tUQrNRN9wajJAPz3k/GQ+CIc4lRujrzT22OmYiNw0cxKFrw5ZVuR4y1guajg9CfJe0fRLhn
 +o9V/8p6INmPvUsydP15geKsHsQP/nnHKwqibI=
X-Google-Smtp-Source: AGHT+IFSQwXQGkrYMIRKtAYmePV+txOz+WEIIUd3z8aRhrWv3TDXpaneR2qqLVNzMYy34K8dwpYUvA==
X-Received: by 2002:a05:6871:ea07:b0:3c1:68a1:6b10 with SMTP id
 586e51a60fabf-3ffc09193e4mr5738705fac.6.1767971003812; 
 Fri, 09 Jan 2026 07:03:23 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa515f4dasm7217868fac.21.2026.01.09.07.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 07:03:23 -0800 (PST)
Date: Fri, 9 Jan 2026 09:03:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Timo tp =?iso-8859-1?Q?Prei=DFl?= <t.preissl@proton.me>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>
Subject: Re: [PATCH v3 1/4] fs: prevent integer overflow in fs.c do_mv
Message-ID: <20260109150321.GZ3416603@bill-the-cat>
References: <20260109112428.262793-1-t.preissl@proton.me>
 <20260109112428.262793-2-t.preissl@proton.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZTU2dT6uY7H3G9AW"
Content-Disposition: inline
In-Reply-To: <20260109112428.262793-2-t.preissl@proton.me>
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


--ZTU2dT6uY7H3G9AW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 09, 2026 at 11:24:45AM +0000, Timo tp Prei=DFl wrote:

> An integer overflow in size calculations could lead to
> under-allocation and potential heap buffer overflow.
>=20
> Signed-off-by: Timo tp Prei=DFl <t.preissl@proton.me>
> Reviewed-by: Simon Glass <simon.glass@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--ZTU2dT6uY7H3G9AW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWEYtQAKCRAr4qD1Cr/k
CqNcAQCsFRyzT5hg8N9LCXReR0DI9VLn0OHlfLSvS8S6beNKugEAwLSNOr0HqR4w
cFlg6QzOkfd46olw5n/6LTUwdZ6KfgQ=
=6id5
-----END PGP SIGNATURE-----

--ZTU2dT6uY7H3G9AW--
