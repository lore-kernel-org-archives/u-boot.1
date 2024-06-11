Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366B3C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 16:07:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8616F886F5;
	Tue, 11 Jun 2024 18:07:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LW4Nl/1+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60B09886F7; Tue, 11 Jun 2024 18:07:37 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C93C886F1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 18:07:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3d22802674cso692501b6e.2
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 09:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718122054; x=1718726854; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pyJcS2lGA4A5cdMdUa6isNPZ3evsRKoYUIuQDlXQElg=;
 b=LW4Nl/1+Kvy8HWrCnskdboH13vtRRquMrylJzVj9B7IMyWZ49qA/+SJjuoImrCKEKx
 BgecKmkfl02njMv7iR+cxmS7thSFH9dhLY1PnfN7Q5YbneP2ppqBiPVZwxf3ls5vYzvG
 mR4qcsZVuFWQr9O/ZB42fvnLhxxQCzVUxpDC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718122054; x=1718726854;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pyJcS2lGA4A5cdMdUa6isNPZ3evsRKoYUIuQDlXQElg=;
 b=F6OOCehPzSzhTXSfYtQTYlFOufI+RncHgNI/OFaY9qQYQeWtW3fU4kvDpVdwirBHrh
 /isbEiQ7LBA9E+DD0zreesmxF7YXfQjDnn85WimxPs0dCOs0QmxduSfh0e+/hJyjbY39
 nltraZtzgOvYvzkxuvZfbDWoPlL4drshpXSXxhX55XHEafsI+DKMAAtt1VdhJ+AZ1aMY
 E5jeI9hp9PjFZDfytBjB8sMKG91NQR+AWbsE1mVPhmCd8kLUUeox/Mu50GNanz4oCAdg
 zv1jbOiMtQ/KPSlIr6T2T6i+HwL90xBaZl+eDUBRAPqun0cDShJUeaMz5TwOQGudZU5a
 DXkg==
X-Gm-Message-State: AOJu0YxB7ul+7gB7JJexewiJVqJN9y9PnH+j9UGar4R3AQYTbh8eK+9z
 +zv0DsLzp99DjGxo8idNaWoGVyzfvvWgC4cuLX4t6G2TAU3O+cI5rPSN7haSRjCkZWveLOM3Xq7
 qIjI=
X-Google-Smtp-Source: AGHT+IGDdvMzoXeMUy43vqfgjVV9BcoY1Leboospe51UtN1wxi0DKw5r6JmUDpatHIwxmo+IgGzSIg==
X-Received: by 2002:a05:6808:159f:b0:3d2:1f5f:abeb with SMTP id
 5614622812f47-3d21f5ff2bemr9935328b6e.10.1718122053678; 
 Tue, 11 Jun 2024 09:07:33 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d22c04c820sm655792b6e.29.2024.06.11.09.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 09:07:33 -0700 (PDT)
Date: Tue, 11 Jun 2024 10:07:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [u-boot-test-hooks PATCH 1/2] Create a common file for test
 scripts
Message-ID: <20240611160730.GJ68077@bill-the-cat>
References: <20240610222743.255386-1-sjg@chromium.org>
 <20240610222743.255386-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="V8lDezr8Ygapbp6Q"
Content-Disposition: inline
In-Reply-To: <20240610222743.255386-2-sjg@chromium.org>
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


--V8lDezr8Ygapbp6Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 04:27:42PM -0600, Simon Glass wrote:

> The top part of each of the u-boot-test-* files is common. Put it in
> a common script file to avoid duplication and to allow it to be
> replaced for the Labgrid integration.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
[snip]
> +++ b/bin/u-boot-test-common
[snip]
> +bin_dir=3D"`dirname $0`"

So we always set bin_dir here...

> +board_type=3D"$1"
> +board_ident=3D"$2"
> +hostname=3D"`hostname`"
> +
> +. "${bin_dir}/${hostname}/conf.${board_type}_${board_ident}"
> diff --git a/bin/u-boot-test-console b/bin/u-boot-test-console
> index 0b6b4ac..ad90040 100755
> --- a/bin/u-boot-test-console
> +++ b/bin/u-boot-test-console
> @@ -20,12 +20,7 @@
>  # FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
>  # DEALINGS IN THE SOFTWARE.
> =20
> -set -e
> -
>  bin_dir=3D"`dirname $0`"

But never remove it from the other files.

--=20
Tom

--V8lDezr8Ygapbp6Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZodkIACgkQFHw5/5Y0
tyxBkwv/Uq8zGwnNIYAp5p0BdDDFsTKcHmdM8r0zTcJmqk8m62uOQwrYVBjiiucB
l4bfdMYq84JiEXnAmwDMlkUgUcsRJIqvhcBT7h1JCX9Mhx32si4FUPKgeuEqDdOm
f8BL98i3SMaTa4pSiXRsKjRuAz6jehHD+ZtexBgCmmecsaWblL9IwgKfqj+LAJgK
XKILdQ1FYiYRhVciI/tWtKNLbeRja+hrx14MmRIiPtkl84KwVrRWjiZef1uF99K3
OlL2Y5Snel/9qWJA2YD6k6UyLgfXj0vXLc5Q8JsbtB8MDiVIDtl4dtx4pu+ATJuj
PtjuHM+EbIErbq7u7fzvKcqIOI1QF+tH/N+VK8Z2lU+97PYcT4NuKmHyYhXZCfiC
4viNXJXQj/i5y7psEJgPMwgXxPGHiHuOak4Mz5qzPUKD3cgKUaaMO22VqZDjK9EX
zz1qcfNw1eZ8aBy+aM2spyhxVlHcGtDNkHcdxIOYfXR8dqexNMS6IjPwU1LWSxKM
t5kWTq8M
=SQiA
-----END PGP SIGNATURE-----

--V8lDezr8Ygapbp6Q--
