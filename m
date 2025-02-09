Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6D1C0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 18:05:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06A27809A5;
	Sun,  9 Feb 2025 19:05:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SBx6WMaU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78DC580141; Sun,  9 Feb 2025 19:05:44 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 542D3809A5
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 19:05:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e5b271efc64so3007693276.0
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 10:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739124341; x=1739729141; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XtgrYD4riKEyUY6LWMmcsZJdiSJYTEhXeXIKIQCnTZ0=;
 b=SBx6WMaUC7fGapL3GGz8TeG4ZpQhIE++A+WUi7O674TvvB7jR1DqgVBoJe+5zl9tCG
 COlmesIul2oNJFIepSuYBxkyFla6+kZ+JiixXM99cNAHtodtvymlflWRnbSBF3F88el1
 MYIffdRXasKvoBAME+UetFuz1zWxn7TvHuhjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739124341; x=1739729141;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XtgrYD4riKEyUY6LWMmcsZJdiSJYTEhXeXIKIQCnTZ0=;
 b=fameuCGTRHFW2tioNY/tyxE2QO9yCtQuzwYTJKbB/5wLjyUea57qWNYFSQ7sNJWiUt
 Lfafz9/JDRg/iawnlc5KCs2j7qiDy91ge79btzVp3GiVTyhCHW8e6ZvNhbw0/2zel1Vx
 60fi9w7b3LfQJe8JlGlG5vrkpYcWSvYleNnw7UJ6beVan15TSUrzajqGVKqplyxCtgVx
 16aQgdcnt54kQKpixT4LvaAamaKF9RtKLM/gao0OCJu03W8dAAh270ic+wIfyiC7Gx33
 zkZ9OLZQkzap0l7CTIpgNRpPXY36CscDaWx7hycRxG6Eyjwl/JHIJ4NaEhASCsjGDKCa
 Wx8Q==
X-Gm-Message-State: AOJu0Yze/pdjLilT5vCL5zvX774g2BhXJoeLK5E6teo3rux1vLOyqEtQ
 4LR8cP5xRbfJZT7g92WAd3xVCZTWXzsNGTtOwSUtFyZCfXfKBDCCXudFGS/Zc0o=
X-Gm-Gg: ASbGncucKtRL8nfTT9BwlfyQtW04UWKBShu9n074JVzIRVLycCv1Ipuw8A7MQIw1+2F
 5GwUM17CglnBYscfPhSnb8rz8nYfa4+tnaR37uaIlxf48Ef462K/8TJqrn9DWtXq2wty856smBA
 chpzX2q69PH3ljb6iauvBc3w6J29S9UfC7HTjnkxpU6jOcRcqxvy/c+ZZT0bVxMgZwa0/2axJu0
 UmpkleeX3t6Ja1GJcZ/h5cMnXRIAGn/EHGO4C3+Cj+uMZ7C4kITZ7oEczu2xG9YfT4JN33yhGe9
 fRKKgsZ4V6LxuuM=
X-Google-Smtp-Source: AGHT+IHdCYEJnHAgaR9SM0q1uZeGGR5bowozwwhV7KfuO3dvG3ODriHcxQIqDT/6wKgR7eOitmw5Hw==
X-Received: by 2002:a05:6902:2682:b0:e5a:e8e8:b1c3 with SMTP id
 3f1490d57ef6-e5b4616d3c4mr6990072276.9.1739124341139; 
 Sun, 09 Feb 2025 10:05:41 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e5b3a489b33sm2010879276.52.2025.02.09.10.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 10:05:40 -0800 (PST)
Date: Sun, 9 Feb 2025 12:05:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>,
 Anton Bambura <jenneron@protonmail.com>, Heiko Schocher <hs@denx.de>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH v3 02/29] video: Move vesa_setup_video_priv() into its
 own file
Message-ID: <20250209180537.GS1233568@bill-the-cat>
References: <20250209020136.4108987-1-sjg@chromium.org>
 <20250209020136.4108987-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kk4RVWL4g793urwx"
Content-Disposition: inline
In-Reply-To: <20250209020136.4108987-3-sjg@chromium.org>
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


--kk4RVWL4g793urwx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 08, 2025 at 07:01:01PM -0700, Simon Glass wrote:

> This helper is used by the EFI driver and we would like to use that on
> ARM. Move the helper function into its own file, separate from PCI ROMs,
> which are an x86 thing.
>=20
> Add a forward declaration for struct udevice so that the header can be
> included directly.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--kk4RVWL4g793urwx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeo7nEACgkQFHw5/5Y0
tyx81Av8C2LBwHNe7D2anAMWFIaXrgy4LLLlZd0EbNSh5PScGzf1i7Ztpe1enBdr
ERo0e6PNv+MhJ8BbkYSkylSKEJ0maMDMIUefn980pneAntUwRu+7IlIAb5Od/Ipw
9Qfb93eJCmbG0o52ASRsR0ZHe+hwkU6+RpRfigOYJ5bSWxHpF/7h9lgn3dT9VjmG
QI/0Zu0z51zDcRCYReCuTfwnMbbF7WBU8pT/Pglp3Mn+Q2cBms9mSV+qJp3wZiei
lpPKY4FH7ieIJioRu6wXg7NAvRfUNplBF/DyjeawYEo6QUevf17KZIJxsH8/Oh0c
YQ2spsLdrmNHuJabSoqvBYhQ1eVelVcMQj8BwV/WFqn0d65J/VG92Cs5YPRmQwo7
HSlkXiD1oxrBJzdp2kFtEsqukUSTKhNT6jg7oUvBNbrcrzj/8HdbkmwpxKD+DSrW
LuAbQwF6YRKieJfLuT1OeVDu0azwiwv5tnV9E67Gop5NAUkmk1hAzlRVGhAGYQt3
sgtIxIhr
=BbEs
-----END PGP SIGNATURE-----

--kk4RVWL4g793urwx--
