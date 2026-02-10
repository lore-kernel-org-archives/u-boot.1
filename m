Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FBFEB26F3
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 18:15:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 399FD83A5A;
	Tue, 10 Feb 2026 19:15:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GD+0H5iW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E4BD83CB5; Tue, 10 Feb 2026 19:15:15 +0100 (CET)
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com
 [IPv6:2001:4860:4864:20::41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05FAD802C1
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 19:15:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x41.google.com with SMTP id
 586e51a60fabf-4042cd2a336so756904fac.0
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 10:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770747312; x=1771352112; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ShA8AmOCDz3bRaixKWbmo9XkOJ6ehHG1gLrXyLf4OQA=;
 b=GD+0H5iW0Yovlig1ToUG0tSVdHZBiu0pLKY34awgUWTLzFIR880iFwV49T3NOZryuX
 v+v0uqL6N5ErTBYdisJ3Q/fOVhszwAr3tCx6Exft1tqgp1Kh420ajcOBDRYJes5Pkzpg
 uxV0KqAAsyAtiEuDunXKkTw9o6DIQSLjs1/XE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770747312; x=1771352112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ShA8AmOCDz3bRaixKWbmo9XkOJ6ehHG1gLrXyLf4OQA=;
 b=rBqrfY9ZC4w6JR3xv6ZWNYGDKIjm/YuhQ+8zwmXxMYnDTGOaFnyr5l81wpXvgvAsjF
 +v9ozz6qObhaELle/9a/RStbWGH3nwIXLJUUii4OgZEtPz0ljE1WmDxIPRyObNnYSnVE
 mGsH5g52Hzkn2bV5aVnraMycBu3U8hZkFpb8XuWVyk4kHfl3Bqn539Xq/mrkiXuQcwYP
 DBGOofIosSHy5y+30ujCU/MGa/aiknEpbMVgTKl+iu70u4bhg+1rThtR+dW0D14SLfVK
 0Ns1SZ0pCDr8Vg4zUpLqk3Ez0y6pImrf+hpUCTPOnx0nVRkkLNE71Z4QTFeuyG9Lw8Ww
 BWAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWW1UARK5B/e591vJbw9iIfY79nqb3oz5Dk/JC1rPQmgBjK9WxkbEFKUZkzUx+HtcbgvuJ2QRI=@lists.denx.de
X-Gm-Message-State: AOJu0YxrvaxQmixUzX6+VZd6JomRm0lEFyLiYWaQww2NjrjF3i6o92xI
 aC0u0xJLI/BxSt/OnAkykiEmzgMD2DT42B/hNzCtQdE19SUZ6X51smiEFsBuOvNDju4=
X-Gm-Gg: AZuq6aKjdji7tISz1lQzcbEjeq1Zf4F5ft+CIvAFSbClfiIU1lgJZssOyLcgoZWU84P
 2k1HnxZcU9RQIlMedecWJJvYs4MXYfVKmflyG9BRbWGaF0K+7u5ewcdH+7G4UQf+pxCpAbVHFxq
 u+d7JjmuAVdaxigi7sQKdh8gIAj8/5nLgwp2El2OMM1ofxViKUhpdHfXTUzhf+0AJ8jzOFfynI6
 4yrvyK1Age7buXQyPOGSKq31xmntWFOoak6GAfqQz9vhVHfMuduV3L+HHY92JB4z3WYrp2mpj3i
 DlLNG2CPXGiDDuFkLU1KnlLNIb+lZIZj8TkhlP/OHKLL16iArUwdHWep6SKGcjkRrbNbWiIa7no
 KxGdyXnLpQEHRYPZJNI7ltZ55fJiRzk4vIFZ8HofdSxf0R4gZbdbzJ+XJaLD0H99StcTrQRNtMB
 MbA3dLu431zOqYM42wfY1n03ZsUiw6Bb5zaAB9KNXohJmpHFqNRCUw0+ibcdRcm7+n4nKPEpAAF
 bVljYQcJ1PWOguZtbrlugStG//7p2Nl4lv5+o7tNE0tBHZswEs=
X-Received: by 2002:a05:6820:160a:b0:65e:c673:777a with SMTP id
 006d021491bc7-66d0c85599amr7351129eaf.58.1770747311734; 
 Tue, 10 Feb 2026 10:15:11 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6729ac6f901sm2190221eaf.8.2026.02.10.10.15.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 10:15:10 -0800 (PST)
Date: Tue, 10 Feb 2026 12:15:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: vigneshr@ti.com, bb@ti.com, u-boot@lists.denx.de, n-francis@ti.com
Subject: Re: [PATCH 0/5] Update DDR Configurations
Message-ID: <20260210181508.GC2728096@bill-the-cat>
References: <20260203063529.1551907-1-s-k6@ti.com>
 <141c6627-6ceb-4bd7-871c-d2828887e28c@ti.com>
 <20260210180814.GB2728096@bill-the-cat>
 <20a153b5-3691-4517-bd81-b8f1968310e1@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4LY90XRqlIkWdhY0"
Content-Disposition: inline
In-Reply-To: <20a153b5-3691-4517-bd81-b8f1968310e1@ti.com>
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


--4LY90XRqlIkWdhY0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 11:42:34PM +0530, Santhosh Kumar K wrote:
>=20
>=20
> On 10/02/26 23:38, Tom Rini wrote:
> > On Tue, Feb 10, 2026 at 11:35:02PM +0530, Santhosh Kumar K wrote:
> > > Hello Tom,
> > >=20
> > > On 03/02/26 12:05, Santhosh Kumar K wrote:
> > > > This series updates the DDR Configurations according to the SysConf=
ig DDR
> > > > Configuration tool v0.10.32 for the following devices [1]
> > > >    - AM64x EVM
> > > >    - AM62x SK
> > > >    - AM62x LP SK
> > > >    - AM62Ax SK
> > > >    - AM62Px SK
> > > >=20
> > > > Testing:
> > > > memtester - 50% of memory for 10 loops - PASSED
> > > >=20
> > > > [1] https://dev.ti.com/tirex/content/Processor_DDR_Config_0.10.32.0=
000/docs/REVISION_HISTORY.html
> > >=20
> > > Gentle Ping!
> >=20
> > Is this required for v2026.04 or is v2026.07 fine? Thanks.
>=20
> It'll be good if they go in v2026.04 as these are some critical DDR
> fixes.

I'll pick it up soon then, and this is a reminder that detailed cover
letters help. Not just that you updated to the current tool output but
that there's critical fixes or what-have-you with this update.

--=20
Tom

--4LY90XRqlIkWdhY0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYt1rAAKCRAr4qD1Cr/k
CjZKAQCkp+eioAO8Zj1FrC157JbGzlX/ifBnxuoYAaoK2z7pdQEAurXN9NQkgLaL
ZXtd53c++hVmscdkZCC7A3TqS6qxfw0=
=tiZC
-----END PGP SIGNATURE-----

--4LY90XRqlIkWdhY0--
