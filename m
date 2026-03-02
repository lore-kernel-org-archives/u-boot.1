Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58603EA4E33
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 16:03:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5372283F54;
	Mon,  2 Mar 2026 17:03:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XgUJzSjN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CE0483F56; Mon,  2 Mar 2026 17:03:53 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37B7F83F0A
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 17:03:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-46398742245so1748230b6e.1
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 08:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772467429; x=1773072229; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0EL84YuIHWgGASusntdVblev3xHLHlmnl3ibr0+GBJE=;
 b=XgUJzSjNmY+JiY5plIyOu20dTO9/+VfjqfAca0FqWhjwpqQMgXBMPVxuzykse/nb5B
 /iEoqJ40YdoWIjRCjBqrtYRpEA+RT2Jcm+G7IX+0Gm8eCh0O6QLdX1IxNK/AeeMWuWx+
 87rquevw6Pzp00fIYZlq1MJ8yKoTDMajpcC5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772467429; x=1773072229;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0EL84YuIHWgGASusntdVblev3xHLHlmnl3ibr0+GBJE=;
 b=vpgTElWf3NTg2kdDF8agVGcKe/XY+ddGnt8cTXJmXJ5DuPuJZTx+YqmP9MqMQAOVF4
 Qy9YhY2GpKLElaWgZVpVKMAcKPLelEJUtIgAc8Ya2xl349rZnBaWPEUdyDi7Sbxp/pFV
 SrS3iqfPyJP0rt2Alg82TnWGBW8xhEyrTxxxHjcwHhU7N4fNObjZI1RgSVezhvNWuEKf
 am8Z3wsTy2nxZifch7O9fy8LXrTxxAcvHueI/ylfOtkt6C4HyPX5bQukRXL/kjuGyRQ/
 UATmu6mKdNxe/5baKHBTtJmNX0AMOPBYCs3UNAt/fWCJaD/wGdVDvM9idtEDpJIkOwbM
 hzUQ==
X-Gm-Message-State: AOJu0YzLAG+IEH0DdwWYD/p8ldeuSG8MahbEjGz3vPhUv3LhTJvV6Dm8
 /W/KRaenFXTFQ78ZY8UUrz2kMkzl52Reqv14biGj+UgvkYevWfEh0T5tl0AReaVkhLk=
X-Gm-Gg: ATEYQzzIn1z2930FVb2JtaGUzpKvEbotiI/1gK+KpnS8+yYcGHXkkm+iEHonhdfyxUx
 iLEGJVNCe7zylxaBRpj6L7Sl5Ufefi7U6Lggz+9Qz4vOigtMF/HwqDKLwwAtTEt54SMgUrkg7Pu
 VjK/nuMT1rn0cm03F/txy8nXFBJVY4Ug6qCOpbTzjjxNSwJFfTv3xaNeSQYxEQ3vHZVbSW0cWVs
 5t3VvXLibqpTGB8eXJsBr70XLcbpVJ6xLC9z5SEoh83GRGutziS+lPJP8dyZU4o1IgPqPlcM5xW
 9+pblrSv8T0IeScjImYay3yfUYtnC7m+L6+ex5QMgtlERgQfTEP/Hy3PrJi99T+Q+704J5nIhWi
 hrwc4raLQTT/O7jdIoekw1BuVt1BiJbKAUo7xtoL0NV9GnALiB9U24leFw65NoZMFboCOXTmhGg
 E5p+rPEhNgzL4p9JETssXqe+eqHfzjqU1MAAHPw/iNg7TL3izmWvVnZSGxrlxehHrCfD7cMFGuO
 40fGdPN0xkOIcnoliDUBszJNQzGiQloN1V+UuzLxPcIS1FdnDXQmV2EWoVQmg==
X-Received: by 2002:a05:6808:1b08:b0:460:fce5:2fc9 with SMTP id
 5614622812f47-464bec52a8emr6216247b6e.42.1772467428636; 
 Mon, 02 Mar 2026 08:03:48 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-464bb60e6absm7875670b6e.19.2026.03.02.08.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 08:03:48 -0800 (PST)
Date: Mon, 2 Mar 2026 10:03:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2 3/7] test: Update comment for fs_helper.setup_image()
Message-ID: <20260302160345.GE1388590@bill-the-cat>
References: <20260228182304.3728735-1-sjg@chromium.org>
 <20260228182304.3728735-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cPtpndmPXDS1448n"
Content-Disposition: inline
In-Reply-To: <20260228182304.3728735-4-sjg@chromium.org>
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


--cPtpndmPXDS1448n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 28, 2026 at 11:22:43AM -0700, Simon Glass wrote:

> From: Simon Glass <simon.glass@canonical.com>
>=20
> This function actually allows creating two partitions now, so update its
> comment to match that.
>=20
> Signed-off-by: Simon Glass <simon.glass@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--cPtpndmPXDS1448n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaW04QAKCRAr4qD1Cr/k
Cn2sAP9xUrZXLU4rY2xGDowY2ozTz2pj1C9QsXhg9uRLEomLKQEAnMX0yPaqOPTQ
JTvMyc46BOEvhr8JKWrvF5sCRYb/PQA=
=GVlG
-----END PGP SIGNATURE-----

--cPtpndmPXDS1448n--
