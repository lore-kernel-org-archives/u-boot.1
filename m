Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90671CD4F2F
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 13:30:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAB2383C62;
	Thu, 13 Nov 2025 14:30:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hSnwB6m9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8993583CB1; Thu, 13 Nov 2025 14:30:45 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1854183873
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 14:30:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c68bfe1719so239506a34.3
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 05:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763040642; x=1763645442; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EkeiWDA+U9bV5WCtV0i+ZHJ1yUKdtjAZ68BFzmyYq1o=;
 b=hSnwB6m9dNWvofKV8c8uiIxo5vsAZtKxNRn+N94c3HTRQMUuLfpXmnuQhj1Ce2T1Pv
 xLideYixWAW52FqFeEKakBhG9jCHN1DOiXDMBMIeQt64HE/QpKuwtcOzXRO5qQ0xqoyF
 brN3kpO95fhof9pZ1TCJeTwkKrWGGZABt3Ehs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763040642; x=1763645442;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EkeiWDA+U9bV5WCtV0i+ZHJ1yUKdtjAZ68BFzmyYq1o=;
 b=KpFPvylQncXarjEx/Duno2Okmz2qYpwNRMHUva/yo8EmWkCRlGCBaAFvOaYVF2xjc3
 Cz3I2GKEv6XUZc1Ltz6qUlAx66kp3ZLyxexPtVnrzhx3pDHDRsq5JVFswXX3Stel/MW/
 SnmHHJIhSERcir5PL8y9wY5XPw/D2mSCFqtrTP+zyrbgmT+N2qP7izBox1Hm1Dl+4ind
 ECbp2xco3zgjfSu33cNd4GMCXIzBjljM1dZRcNsFUnsQQG9DidX06N62eryVpBW5Q6Et
 kfIwh33T0xlP8roVG5dj8+XSTP16Td3zvSsjKzqf5OOgzEJ1gkqhcOIHdxCoFRjA+0o+
 Agqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVz9acIdyCX7FYLRETzZqLbiy/1mlJRT0D/7Gc/3T6AjIExPSeq2RQLSi8rwjMMO5XareQTRAI=@lists.denx.de
X-Gm-Message-State: AOJu0YzLdLlDgqN2BZ8Ej0sVbOM92Rw/x/wDxxXVfW4dU9VflFk3dTq3
 sOFcxmNowwYZRZCg5DL4xgxWkaFEQ5HFa0z0yJFD5DEHk0ZA0sIBjDLrCXVlvkQI8ws=
X-Gm-Gg: ASbGncsJ6QC2MW9EXznNcvPUUNu1DG/hKo+/Kavx2Q3Xi2Zm95MrJFCu7TkYeYWjtsm
 BpX1aKJUsmRNp3401rteVuv+PRoygZUdpXgFPSfDK88zOimP/gFIsqu9lOOEsIyVEbX9vZkbSkl
 wjaIkZadC34qoJQYAHXqlY6ytwt4vKFFWvXVZH2z5LOIYtnXkxBfssGoTZ68mXV73pie8ZVdrxW
 V1XOqjKFDlKhGWh4myLnQR35dJok5vLuUmFVu1aFSbCRSW3fHJuA2xrVcpG6csoaz27tbQ490+Y
 y7R5xy+RgsnykUTBRmYqdd3quivMgCX2qMLiblUyIZ5xKPfwSju4xr180ZMlqmWPxTkhakgLw/D
 tUOj5HNe+UaLArVqqjvea066VsgBtHpKb8loX2qSf3bmYBTjAPMyBv7sgYvSNcq0IvPLRuz7N5I
 J5VFHTqoqmUA7xax4+K9ivjElhwedfibGG8XcPzPk=
X-Google-Smtp-Source: AGHT+IHt1b93IycT9vWm55hctaXyWVMJofqoACT6IC7p8f4r916UDS9H8EikCramYUx1oojzJHXAsQ==
X-Received: by 2002:a05:6808:308e:b0:450:1552:371e with SMTP id
 5614622812f47-45074489b17mr3044347b6e.27.1763040641742; 
 Thu, 13 Nov 2025 05:30:41 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65724cbb133sm966333eaf.2.2025.11.13.05.30.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 05:30:40 -0800 (PST)
Date: Thu, 13 Nov 2025 07:30:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <simon.glass@canonical.com>,
 Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/6] fat: Some code improvements
Message-ID: <20251113133038.GF6688@bill-the-cat>
References: <20251113064656.245394-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="93FVI6nVSkwuMwln"
Content-Disposition: inline
In-Reply-To: <20251113064656.245394-1-heinrich.schuchardt@canonical.com>
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


--93FVI6nVSkwuMwln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 07:46:50AM +0100, Heinrich Schuchardt wrote:

> From: Simon Glass <simon.glass@canonical.com>
>=20
> This is an attempt to improve the structure of the FAT code, since it
> doesn't fully follow the U-Boot conventions:
>=20
> - fat_write.c includes fat.c which is odd
> - use of __u32 and its ilk
> - use of typedef
> - old-style struct comments
>=20
> This series resolves these problems, making it easier to take on other
> improvements in future.

We don't have an AI policy for the project at this time. My current
inclination is we should follow:
https://docs.postmarketos.org/policies-and-processes/development/contributi=
ng-and-ai.html

So I'm inclined to defer this until there's some "other improvements in
the future", that are both useful and hopefully only human developed.

--=20
Tom

--93FVI6nVSkwuMwln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRXdegAKCRAr4qD1Cr/k
CgX+AP9JT6/t+eF8fy7j2f8MYAq9yZbQ65uxM3S5P8S0y5DHbwD/WyIbJzwKNF++
Wt1gqVPXG11QmlnKabRfkJ4zioKqTgc=
=97Wo
-----END PGP SIGNATURE-----

--93FVI6nVSkwuMwln--
