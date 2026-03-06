Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE6FBFCC07D
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 22:23:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 722B883F98;
	Fri,  6 Mar 2026 23:23:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qHfTM27B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D69A983F9B; Fri,  6 Mar 2026 23:23:08 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 472EE83F98
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 23:23:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7d4c12ff3d5so9600402a34.2
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 14:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772835781; x=1773440581; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Vzx5WOuLTdhAoyi3Uh2p+9a5kKUsPq3yssKaTg8Q6F8=;
 b=qHfTM27B4TE6KG6iB+HvdI02aj5euthYzORlUz18+sXnIIqaQNTNhbXMyeJXmu4Raz
 qnM5ZRnaOK0QrrfdZzm8O2CFcgeb83c2eX1CEq05QxbgeYbVN3VEauXPgvF6B3gQdqw7
 5Vi+qRfRZfXf+a0BgflWptF3v1DNqzmvAkD1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772835781; x=1773440581;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vzx5WOuLTdhAoyi3Uh2p+9a5kKUsPq3yssKaTg8Q6F8=;
 b=waW9n8vObanAvFvILiBkCO7BZjOuhWw0ifUjLf5NaLAFLubYA7LLW/H6gWPdfvD3zb
 OpLkED1U34GJBhN72OIDldJ0oyTBkt0BVotpOZtQmbkN+4nf8r1L3gGq9Lg+S3TLbBGW
 kInDzV4Pyo8/3pa9tQ3qKygiZA7PuSivSP3ywY6hKbT2oHqEbjRkERc13JHZ1KDpoOfX
 AHKWB/xHwtXFrtvA/TTNGvJVxXp0YoekRHPeC/1rdP7/9bz9wrsh160GxSQOIqf4UySS
 9jtEzg3vBa1xY5csTM3qftATNJp+MTvz7GRTCJXOiNYoC27r1ZlAbGI5y2EqpByz15aE
 u2ZA==
X-Gm-Message-State: AOJu0YxvypZRkfAxDQiNPIEcEUVWdDSQq4GHtsgAqwUsjYPqPYmKmSOL
 XBYg+3wc0i4KPaQiandnYeneGNSYKIzavgAFyBSxQxEB8uPq7SSTXe9ZDbX4ogWmZnY=
X-Gm-Gg: ATEYQzyJjlOf4KNq4Iu/McjYzBfObHV4GPM2A0BE1SW1J1RSPToWDMySVNovb/phL3a
 NyTZD+kA8OlZ0cFALrIhfDXxt48IcnUhfufSoADhRKzUgyMammrhbY72TdbgvwY42Ji5ytvxEIS
 5LgUNfcftZHgVb2wXGKJeq48PHBGKDop6TuvUqt1vn+XahEAb1Rhk/Aud6yTIheTbo5SuUL40ZG
 ZjbD9c7Rez+k0Z/23r0W+dQUTNTRT1cNPTPuXvaPQVv/QrcHFsprdwTvPizbLlf4Of5Hr0qqpgD
 n5BuooijCx0IQ4CFiE5G7FKclDqk93QEUd6LR+3WpQrayPx1NBymvJKJJB0JByLzrcskFoJT6CI
 tLAAY/2wPQfc1IGADV+RuTmR07HwcYEshCN3B+2XCWKBHLPo7tGmO1quZZlJFm4TI+5MD4hJn3b
 yF3Ca5olr8XwoZFRF+HD+o+gdLH/xegptwTZ4JD+VTtTTlmq1GJ7TNj3kWGqq3dfdJiuELnMnNR
 Xdej5kzMCED/X2TnqaQXxINDnC2q/GYtQIpdE2ukVZ1/fc+6z0=
X-Received: by 2002:a05:6830:6ae6:b0:7cf:e57f:def6 with SMTP id
 46e09a7af769-7d726f1d9c0mr2535404a34.6.1772835781463; 
 Fri, 06 Mar 2026 14:23:01 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d728c744b9sm1731059a34.8.2026.03.06.14.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 14:23:00 -0800 (PST)
Date: Fri, 6 Mar 2026 16:22:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v3 5/7] test: Convert fs_helper to use a class
Message-ID: <20260306222258.GT1388590@bill-the-cat>
References: <20260306190818.3586749-1-sjg@chromium.org>
 <20260306190818.3586749-6-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RvliqkPSpts1VDWm"
Content-Disposition: inline
In-Reply-To: <20260306190818.3586749-6-sjg@chromium.org>
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


--RvliqkPSpts1VDWm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2026 at 12:08:11PM -0700, Simon Glass wrote:
> From: Simon Glass <simon.glass@canonical.com>
>=20
> Create a class around mk_fs() (and later setup_image()) to handle the
> common tasks of image creation. Many callers of fs_helper.mk_fs()
> create their own scratch directories while users of
> fs_helper.setup_image() rely on one being returned. Unify this by
> adding 'srcdir' as a field while converting to a class.
>=20
> The class delegates to the existing mk_fs() function for the actual
> filesystem creation, adding lifecycle management for scratch
> directories and the image file.
>=20
> Signed-off-by: Simon Glass <simon.glass@canonical.com>
> ---
>=20
> Changes in v3:
> - Rewrite the commit message as suggested by Tom Rini

Thanks.

> - Make the class a thin wrapper that delegates to mk_fs()

Oh, this does make it much easier to review, thanks!

[snip]
> +        Args:
> +            config (u_boot_config): U-Boot configuration
> +            fs_type (str): File system type: one of ext2, ext3, ext4, vf=
at,
> +                fat12, fat16, fat32, exfat, fs_generic (which means vfat)
> +            size_mb (int): Size of file system in MB
> +            prefix (str): Prefix string of volume's file name
> +        """
> +        if ('fat' not in fs_type and 'ext' not in fs_type and
> +             fs_type not in ['exfat', 'fs_generic']):
> +            raise ValueError(f"Unsupported filesystem type '{fs_type}'")

I don't think this works as expected. The first thing that caught my eye
is that shouldn't '"fat' not in fs_type" see exfat as valid? But we now
also pass along a bunch of nonsense like ext5 or fat128 or fatnotreal to
mkfs.notreal to fail on. We did zero sanity checks before, which is bad.
But maybe we should just add this as an explicit:
if (fs_type not in ['fat12', 'fat16', ...]):
  raise ...
?

Otherwise looks good.

--=20
Tom

--RvliqkPSpts1VDWm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaatTwQAKCRAr4qD1Cr/k
Cnk8AP9NYtESDZzro+NpKOnB+PqxLH7OJsiv1G6s/A9ooGeplwD/Y4xCHf7XE3gH
0IpTN6JDQ9BIjqrJSQSCK6iHnKhi7Aw=
=WVC7
-----END PGP SIGNATURE-----

--RvliqkPSpts1VDWm--
