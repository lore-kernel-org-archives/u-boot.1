Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F92DC88E6F
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 16:36:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 369C2404A8;
	Mon, 14 Sep 2026 16:36:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ar5o4AFZtVtV; Mon, 14 Sep 2026 16:36:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5406C40589
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789403763;
	b=IIn1oKn4/hugRIrnBL2hYJrk2jXgMMD5B/WKvJ8vXSAS6Jml1QatSDvK7iJnYla7mVis
	 ctP4gbead6wrnpm04Ey2bIM/WE/fnJClwrFqF1DRf7C86Dtn3wU4QL3Q/TUf7/osupGvW
	 xnzzYZ0V0UZIIIdW2pw8qs7NDQgpYpHGGbMFP4yeZKAzDGPpPJNjjpcIBP2nk7ImtiWvC
	 BBLEhVvxY4ms+t/YURKphWTGnkbr3UgL1mr5X+nfCXdh6uYOX1UUgggQqZXw+Fdx9VeRU
	 qZkPiUsNOvQaBd7GhdvNkryJ3e8lcZYIrqggwpTjk6/HZNDBFbGF94essDhFBvmXoIw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789403763;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=LHwM6xZX7Jexw2aq8br6J6CY7zEDlulLQIrLQjB9iYc=;
	b=PwglKh4Doi+Htf1q8+5H7yAa8IbkwM9yIX7bKylodmEqlrEvj2Q/vt/ZeqqvPWA+2rC4
	 CSipN1XVtp0g/XdqhlASjY9n1svW1pFodHoUpHPKZ3pMNjRWNMXQtadQkG5IfZugseJxx
	 3EXkyMgs3Ojm2x+2OGl0qgC7kD19WkQzZFwro9Q8CxR2Bbu64AKkv2KiwuwbISFxeeNO4
	 wjsuv17l5auTFUdwv+uDOqQz1H5icqrOdGgaE/fTxoFnd6cfL4J94Cqr2YjJMNnNn1xJv
	 0I47D7dUuLk2xVWYZKKUlL8yAl67McI2DOEG+tm/T2chPrfdblW/48pFdKo1xxNIUQw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b="dcl/aayV";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789403763;
	bh=LHwM6xZX7Jexw2aq8br6J6CY7zEDlulLQIrLQjB9iYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FGsM1CfPmUJkSZwbZFMXHMe4rytlCWy+rdk3VJQ4D7bqKZmUr6BdrqqnlxOxzoBVj
	 HFRkxxNvXOuSoErGYIEh/PdD8bsAhINe5UCMC4zJIywDDokXVisb6XxxbQ0SbEd2qx
	 Wz9YhmUX52ZVCsXh7sg7awuCxv4R9xqTy34qygYk8ZD3ut/wtdzbPk/EcDdrkFBS6A
	 ERRWQatvgh7yWk82KkMHnqz2lu/3wrKaae5Ws5cMgf3ID80NHC7YqUAh7/DatVDubo
	 c0rmLEiT3ThzWgDKy+B9lSHM9VufW8mcVXEEZ/gcBQDe2XNH1Vj8U/1ESdoJoMzuB8
	 bAw+wTCr7/3OA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5406C40589;
	Mon, 14 Sep 2026 16:36:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CC91E259
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 16:36:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CA2FC40589
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 16:36:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9ELsiGezNjMW for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 16:36:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EEE80404A8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789403762;
 b=LOAvmiDQxUyL/kf8mPW0rc2tDilUJCASBQmm537Px4RH54Whz7jph8LlDOPlBrhwwIjD
 NEFDoI7ci8bV7+IpfATlPtiG3/32MwF881WaNfuXj0CFlzma3Ia855Zh99g8ij2sxOkbl
 ynrq0o9FhflrMXUk3E+x+t3HYK1MY+mHLNuITNc4QoOcbQosATvwL+adC4miZ3tCh2Lm/
 Z2csDcz8Dlzykw1fY388FpseDp+IhU5ILLxJuuzhUwbNzCAt8eut4fV1bcGsS299msD8d
 ns+YJOeFoLZHtLZdI8CUi6DlD39aNmzI2zyxVNNthxsz1mhF/x2jHYpNUYPLy7pfZmw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789403762;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=LHwM6xZX7Jexw2aq8br6J6CY7zEDlulLQIrLQjB9iYc=;
 b=TDS9Ui7n/PkaEVuQ8tuFyINvFZUDWZoSAcg8pNPP2YtsO4xk/w27G17cCw3iEF5A/ksg
 +b/qrY5nty08WDWzbw5ozirqnHGOYuu4DAxSkHS6Kpg3Sqr1T04l5NDIGSWc9T03l1YWI
 QHVAAr+mSHn2d7oVwOyLSaUo3i+X2ghlDR0BKI1khS6qKGVw1S0fUTQ+f5o/Svh9zMaOI
 d6v4TnrM4O0a6w76e0BqL4dy6g+C2n6Yv3jK6WHPk8hu55PqEwj+13Qd9j/o4AkC6+xY5
 hjavYmr/G5qD6u5PiS4lM+6Ab17StaRrnquTPYCc6NC2hfBE704pRb3wAu140xlS9sQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="dcl/aayV"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22f; helo=mail-oi1-x22f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=dcl/aayV
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EEE80404A8
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 16:36:01 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4a46a53abc9so2958301b6e.3
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 09:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789403760; x=1790008560;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LHwM6xZX7Jexw2aq8br6J6CY7zEDlulLQIrLQjB9iYc=;
 b=dcl/aayVSvJWKZPpAyoePdCUr5KI1W37FWJ5bFogAsOH3iXrEECFHr/4IYfUsBr7FE
 5MjF7UHL4svZzYwdiVmH3O1W6Wb8aNx2FXyGl9GuEwxQJTODVd14/kMfPg6Ysi33gWkB
 pkSVHLnFdTW49kNtfM7lSqyxYQ2V27zpJLZMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789403760; x=1790008560;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LHwM6xZX7Jexw2aq8br6J6CY7zEDlulLQIrLQjB9iYc=;
 b=nTHNMTAOMEnZ376SDL7CGyBJmi75qLKU8cYVtv8lwH+vfVv0ozghyqyM/YMC/mxuVr
 Ws7rb5T8BApvu2iiRz/3p1vaDXJ6WF5RbGcw0C+p9v3zhZfW6uZnsUNEq5VMWU+o9DKw
 6qBDPunnSQFVIdBJqX8ky7t5vYJBSMaH1DoVSQmb32lPvojxRabqlkQ9BYL7bknF/lnu
 +OK5MPmsW1Q/7sqjJQAJtjCix/wSRRFWOXq5J3xW1Os3f110PR+iJ8xFwEDuVLIpjxB3
 cwWqT55AGgUNatF33xtPc9JJzFeVYnpq5y85STG97guZZv7S1nO+AViW45VjdqxmsD5G
 CllA==
X-Gm-Message-State: AFuF++mkcCahCF23q9ipmVs2R3Pq60QYkwfnsEvlggrgNqHiGpyskZwO
 myWPhPGAFBNyOfZpVxvgyRXUI/XUUFPLhHWWygLYuuyHgHF41k6mpZr3dBMnw/T+29o=
X-Gm-Gg: AYBFou1ZX2a/t3vPXWi5E+C72NCifjEOCEqCf42A15dWHzQKi/VCm4OwGqDMHVvoGZT
 MP1YFhfSbTYD0G4OxWSEzmpS4KXRVsGesMU4T5HfDrc0Lz+UdVxp84pzO0hDAj9YbiJbO/+0616
 o+rtUjs2eC3OEk2iJzgii0K1yxC5UuEujNaanyY6+SF9CprOXrkhO1p8TIrPuBb3fcKwRAJdaXu
 CsOXm7QaYkq9r71bd9BuMcJdgLC7A8W8rGbxyUf2a8jfMJJskgyQPw8DnzvJpAKgNclv3Lj299u
 5EC1XoH/WIQpb4vVkQ8Tw8MOcFJW3QWTUZ87TlvA3KniBF1QPck6H7SSZM8YpT34ncWomPfeQj6
 wYXgit3qHBw5XryCsB/fXs7GtVyh+/VwP8Zf2h+ujku+pILkwfOTDUVD4CO/NMlBr9v7oTLEfuT
 tRehoLDS1JJHWtxVbXDmLjL/h3SBoD1zzeklqpYVsg7nj7DlHOl6QEjOoO9Afb4W/LG4M3vJws8
 V+BHPp6H9flemObj6e07LPCHuOgM/GJZnqlR08LkxizjjTG2sxaxwDJEyJtP59rCKAJyKDL6tyf
 3Hrn8KrOBz023YBGb6cB
X-Received: by 2002:a05:6808:2203:b0:4b3:80c6:4bd4 with SMTP id
 5614622812f47-4c7b42c9aa4mr1885098b6e.5.1789403760565; 
 Mon, 14 Sep 2026 09:36:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47df8699bc6sm10825105fac.3.2026.09.14.09.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 09:35:59 -0700 (PDT)
Date: Mon, 14 Sep 2026 10:35:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Alexey Charkov <alchark@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 =?iso-8859-1?Q?Jo=E3o?= Marcos Costa <joaomarcos.costa@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 David Lechner <dlechner@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v3 1/2] spl: mmc: select the boot partition after device
 initialization
Message-ID: <20260914163557.GA1764417@bill-the-cat>
References: <20260914-ccaione-upstream-part-dynamic-v3-0-a38c19e74563@baylibre.com>
 <20260914-ccaione-upstream-part-dynamic-v3-1-a38c19e74563@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BSbj/JKm2rPAqZUo"
Content-Disposition: inline
In-Reply-To: <20260914-ccaione-upstream-part-dynamic-v3-1-a38c19e74563@baylibre.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--BSbj/JKm2rPAqZUo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 10:31:37AM +0200, Carlo Caione wrote:

> Boards may need to read boot metadata before choosing the partition
> containing U-Boot. The partition hook currently runs before the MMC
> device is initialized, so it cannot do this reliably.
>=20
> Defer selection until the raw partition load and provide the initialized
> device to the existing hook. Explicit partition loads keep their supplied
> coordinates, and a successful Falcon boot needs no U-Boot selection.
>=20
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
[snip]
> diff --git a/include/spl.h b/include/spl.h
> index 5078d7525ab..08a84536f51 100644
> --- a/include/spl.h
> +++ b/include/spl.h
> @@ -595,18 +595,20 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 bo=
ot_device);
> =20
>  /**
>   * spl_mmc_boot_partition() - MMC partition to load U-Boot from.
> + * @mmc:		Initialized MMC device
>   * @boot_device:	ID of the device which the MMC driver wants to load
>   *			U-Boot from.
>   *
> - * This function should return the partition number which the SPL
> - * should load U-Boot from (on the given boot_device) when
> - * CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION is set.
> + * Called before loading U-Boot in raw partition mode, after any Falcon
> + * attempt. The hook may select the hardware area containing the image;
> + * it must leave that area selected. It may run for each MMC load attemp=
t.
>   *
>   * If not overridden, it is weakly defined in common/spl/spl_mmc.c.
> + *
> + * Return: Partition number to load U-Boot from.
>   */
> -int spl_mmc_boot_partition(const u32 boot_device);
> +int spl_mmc_boot_partition(struct mmc *mmc, const u32 boot_device);
> =20
> -struct mmc;

Have you thrown this through CI? We have that forward declaration
because it's not otherwise defined, and we wanted to avoid pulling in a
big header chain here to declare it. So I worry something is going to
fail to build now.

--=20
Tom

--BSbj/JKm2rPAqZUo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqgiaQAKCRAr4qD1Cr/k
CkACAP95mWI7ITtI1zAe3+N0++IEJFznlCEYshiGM4Uv6QfZnAD+IO1OorCOWDfY
sLaxiOtl/BD83KyKwickYxQ9i7hLYgU=
=vhLA
-----END PGP SIGNATURE-----

--BSbj/JKm2rPAqZUo--
