Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FCDC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 21:07:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B361B8767C;
	Thu, 21 Dec 2023 22:06:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aW7UN/vW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20C7C8753A; Thu, 21 Dec 2023 22:06:58 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E10C869B6
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 22:06:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-427a3887483so3178471cf.3
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 13:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703192815; x=1703797615; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=b34TrbO3+ozyhe78GzJbwvNaS4OfvN3mnRwNzxF0iDA=;
 b=aW7UN/vWVthAgKIfdDEeJJMXp52x4UlebGTWZW67mpXKXhe8EZDFQaCReIjvu7tc/N
 fUr4tzl13umWMJBNkV/8kuZQoO7WplvpYcrLQ9pyuNuJgYGxp9uBnF8kOILF8EwnQ9rM
 zo5sSjp3bCEzh/R+v4Mk8fuC9qFjlFxkiCHfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703192815; x=1703797615;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b34TrbO3+ozyhe78GzJbwvNaS4OfvN3mnRwNzxF0iDA=;
 b=klP4JGU3hj787CiunIOvqxhg0HMVuCn2B/yTC89oKLtett1Bpt9U9R2oJ14rMfaPH/
 EUlrgU/CHjaVWaFXqBR69/OsN8AUio4XsPwv2gVTtS3KVGJQKgrfh16lHyCFYrqTnesT
 3f6DAQtSSgxyGfuL5F1leHtOFCI7887nVAQAsPNXXiafBcv6f7OJ8MfD3u5FHJ7Y//si
 TP+2B2X0mCVtQzhj8zyjx7ZFq7km5s4oIggdS+nb+/A6NwlZ4RKEzSrUrzoX0RSa84iH
 PpQUoiiU0w5SuIha5B4l/duGGKY07vnHrY+jshMzs3rm0EDlxHpRKaRmcRQsF/0D8k7Y
 hg0A==
X-Gm-Message-State: AOJu0YxWTd6HLyoh1f1tW5EgT16Zt+BALWSMqrmf2wjw/pmIvyMitwKu
 Bv9bl87waIzMzPgBjk9OE//f2EJuuO+jUw==
X-Google-Smtp-Source: AGHT+IGjSOBCHxacA40WiBPKC5kBi6GSEI7U57xs9l3JwjvQsHMgSGZjr45oib6ScXqVJKj7wn9AuQ==
X-Received: by 2002:a05:622a:64b:b0:41e:2037:72b6 with SMTP id
 a11-20020a05622a064b00b0041e203772b6mr365208qtb.40.1703192814817; 
 Thu, 21 Dec 2023 13:06:54 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-550c-6b1c-99f9-93ae.res6.spectrum.com.
 [2603:6081:7b00:6400:550c:6b1c:99f9:93ae])
 by smtp.gmail.com with ESMTPSA id
 hb4-20020a05622a2b4400b00417fa0cd77esm1154372qtb.80.2023.12.21.13.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 13:06:54 -0800 (PST)
Date: Thu, 21 Dec 2023 16:06:52 -0500
From: Tom Rini <trini@konsulko.com>
To: Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shengyu Qu <wiagn233@outlook.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2] fs: Fix SPL build if FS_LOADER is enabled
Message-ID: <20231221210652.GN2513409@bill-the-cat>
References: <20231116171612.143910-1-mchitale@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dl8JU3gtpdej3VSN"
Content-Disposition: inline
In-Reply-To: <20231116171612.143910-1-mchitale@ventanamicro.com>
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


--dl8JU3gtpdej3VSN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 10:46:12PM +0530, Mayuresh Chitale wrote:

> If FS_LOADER is enabled for the SPL then the build fails with the error:
>=20
> fs/fs.o:(.data.rel.fstypes+0x128):
> undefined reference to `smh_fs_set_blk_dev'
> fs/fs.o:(.data.rel.fstypes+0x140):
> undefined reference to `smh_fs_size'
> fs/fs.o:(.data.rel.fstypes+0x148):
> undefined reference to `smh_fs_read'
> fs/fs.o:(.data.rel.fstypes+0x150):
> undefined reference to `smh_fs_write'
>=20
> Fix the error by populating the semihosting entry in the fs_types array
> only for non-SPL builds.
>=20
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Sean Anderson <seanga2@gmail.com>

Applied to u-boot/next, thanks!

--=20
Tom

--dl8JU3gtpdej3VSN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWEqAEACgkQFHw5/5Y0
tywZewv/ambDdsIcNzVDi5AbqPQQ0lAcTng326XSP+C0mrNuHXszSiXmSJrHkuif
iKdU3zhU4C91DVunYIkB4BGGNOYG4/tr/0ll277CegBurmOKVTkJxEtnUTaayPWE
J36N3oGheB5Nmn35a0WVH205LzlsMWyp94C53a8ApuI7jfv40XgnjFBbeAHvicjT
7Ga8/qZtBquWaqsmHYxb1nFtFDZ24jIcfemeb36Z7R9ezHtki/fomG+ny+iy4Pu0
LpmLgG9Q9ATHWHkarFLsMhZEFaJ8AjM96r2R/nCt2LKYWj4FBftpOa1y6U84hC8w
Y4IhkoZxbH7592ij25cWErqQtEwu08/JV3YsFNFQB0x9na0Kdd6fCACUASn7AJCg
QLl721/XVhjWxSkMO/jDxIqAKFNC4OOvc9+2QMj4Dvp/iqUh/md5LrwpGcg1ngZ8
aQ7LwO9NuXPgFDmVZ6DLm5jTvG+0R5GiGUbUzIK0vIyt+V0fEW3zzVP6SFZNgNNM
Jt+NOOfy
=r1Au
-----END PGP SIGNATURE-----

--dl8JU3gtpdej3VSN--
