Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F92C021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 23:31:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABE3180C8F;
	Wed, 19 Feb 2025 00:31:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="r/zjDzqI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3328280EC0; Wed, 19 Feb 2025 00:31:03 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7987080BAE
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 00:31:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-220f048c038so78464805ad.2
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 15:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739921459; x=1740526259; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WPhspwsKzxQxyliqvSvVrQUJp0CAezLZJGZq/vM9U8w=;
 b=r/zjDzqI6sNqm8S2b8y8UVbdZJlWEFrdTT0DSz1kCdgxFVjCYn3C0/cxfSQVuBNB9w
 7D3A6cowY29VO/H9O1h06n+yrT7b4XqPFJWbZ5noNpguq4JPlRfRuE1anGB/s9ibxibY
 F69XsKCQOaw3kImIgAQaVmU9LYRjvmfTkPMNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739921459; x=1740526259;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WPhspwsKzxQxyliqvSvVrQUJp0CAezLZJGZq/vM9U8w=;
 b=LTBX1jpxqMnnT/Fn95Y5d4l01mPzN2x/6XoNwM7LH1vMD+8f8hK4UvIiBEPQpr4I+9
 vgl/KsCLnqGAbJiPjoNRKfLXxU2g7uKtTWHN6kQX8K7bH5sWr39iU0Bjedov84X+2kUA
 pxcqIRp0yKI+whjoL2TlQEDhutIw7JhPB3glcFL2pq0ZMAOc3GLJU/3JC7IbuxfltQmv
 vPwBzzXE1chaTn3GVR2v07ftIbmcxH3zWKkUPUtAWYDOCTWi3k1UyzIQigIrzgZ6ULH+
 6BlfpJvuG5UHY/pnukj5wpaU+ME4gjEuFEYwQq3weoFZdAAKW2FPMjrc9whiITdwMW0P
 Cf8w==
X-Gm-Message-State: AOJu0YzjO1o/WmJ5g6x7OY5h5eTjOjg84tzIgqX2SM7uCdHQc3YP7K7q
 6fFm7kRx3HsSTf9PSDfOeiDN49vPYDhs0wV/uGcvLqUgGA8wXEZa13zWA988guE=
X-Gm-Gg: ASbGncu+2DO/M6RMDxchAa9o5BL0Mx0bjk5QcNrOmc0nzzeA74gqyx+I0s29II465O+
 lZVn92i3J/kOCul4i3juVn8lrwU+kOu5UJlCw/I4nsiay1Aug5+9QISnADmNaacL6DuWFK0VSAE
 Q6Ve9uTude2QPDXSP81oqvJf/JUKTpoPDaROuOR0SYNvJBsu0wVgO9eqkfDvNPr7cgZMFI8ZTFN
 fobu3ecnkMiUJjOv0lBTKzmf8ToYEaHYJlB5HagEpPtjmWEqXXlYpGNs/8U8rcFxRn1DQKmldLM
 gDpTJpziy3wGow==
X-Google-Smtp-Source: AGHT+IHNt95oG1yVvkU7qQaPH8y6pOFVzehCfsBBXvgd+F04xG1BZKHr5hisa5l8PEYZhW8MV6JRVw==
X-Received: by 2002:a17:902:ce06:b0:21d:3bee:990c with SMTP id
 d9443c01a7336-221040a99cemr250492695ad.42.1739921458893; 
 Tue, 18 Feb 2025 15:30:58 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220e21d2453sm88280255ad.184.2025.02.18.15.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 15:30:58 -0800 (PST)
Date: Tue, 18 Feb 2025 17:30:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonathan Bar Or <jonathanbaror@gmail.com>,
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: u-boot@lists.denx.de, Gao Xiang <hsiangkao@linux.alibaba.com>,
 linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH v2] fs/erofs: fix an integer overflow in symlink resolution
Message-ID: <20250218233055.GN1233568@bill-the-cat>
References: <20250213112847.1848317-1-hsiangkao@linux.alibaba.com>
 <173990731183.1542939.8486402584511743095.b4-ty@konsulko.com>
 <CABMsoEF3xcbpFXMAYW-ZzQUfZp3zVf8FsKmtxQ7wfVxu3zjOcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="294FnAg8Qefqg6nM"
Content-Disposition: inline
In-Reply-To: <CABMsoEF3xcbpFXMAYW-ZzQUfZp3zVf8FsKmtxQ7wfVxu3zjOcA@mail.gmail.com>
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


--294FnAg8Qefqg6nM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 03:24:08PM -0800, Jonathan Bar Or wrote:
> That's great! Thank you for your work!
>=20
> Any expected fixes on the other issues I raised Tom?
> I'm asking specifically because GRUB2 maintainers are working on
> solving very similar issues in their repository for SquashFS (being
> rolled out right now).
> It'd be best to solve ASAP as people might realize the similarities
> between GRUB2 and U-boot in that module.

Adding back in the squashfs maintainers.

>=20
> Best regards,
>            Jonathan
>=20
> On Tue, Feb 18, 2025 at 11:35=E2=80=AFAM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > On Thu, 13 Feb 2025 19:28:47 +0800, Gao Xiang wrote:
> >
> > > See the original report [1], otherwise len + 1 will be overflowed.
> > >
> > > Note that EROFS archive can record arbitary symlink sizes in principl=
e,
> > > so we don't assume a short number like 4096.
> > >
> > > [1] https://lore.kernel.org/r/20250210164151.GN1233568@bill-the-cat
> > >
> > > [...]
> >
> > Applied to u-boot/master, thanks!
> >
> > --
> > Tom
> >
> >

--=20
Tom

--294FnAg8Qefqg6nM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme1GCsACgkQFHw5/5Y0
tyyBRgwAqMaHU2UGacIzn3exB9KF56+eL303p1iRmZa/Ovn/uQ8hU0lvLGRgZZI2
p5Jv1e5lTh8pNZIsZPdfhwBKXyD9o3yMepGD4CnR400/KXiKGL/1hk3kG0rMDWhN
vedBD4ATrbebbOVYX7cmrVppMyc2tjdGJ1qhNB+0211JzSExpPyVs5dcVpCAlPKx
oe5+SnJx9VO0u5aoLm1K3JsKvlHZ1ldPt/bCQPMWOrZMY3XXEB4cFJfx/Ua71OO6
ROSYp77j1d0tlx40OiXxWaT70qlNu61/ptvnM3M6sKm8k6sZ/m66ibu9dKF0S1Fn
8WiQcdm89Hx7QLFd/wFRPtsxPH6sOjY6yidASWEkGKIBXTkf/04tt1irVL6PZNa8
VuLDyRO9YFsvLsScp9zzvqosvEDNqLa4LJU2sww0HOPMljymxoTjB1wrb5abZBge
zBLBc65ADUulE1QGmWi3hzjVGKp4r9n1lm9YzMVZqhVCK8cfxuLFLRSLYO6QsjzQ
ZgdIG5ym
=opwn
-----END PGP SIGNATURE-----

--294FnAg8Qefqg6nM--
