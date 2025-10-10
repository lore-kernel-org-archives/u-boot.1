Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62C1CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 20:31:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EBBB8403E;
	Fri, 10 Oct 2025 22:31:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HAJ0y52Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9382484042; Fri, 10 Oct 2025 22:31:43 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6216083F8D
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 22:31:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7bdfbc6ba5cso1027680a34.1
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760128298; x=1760733098; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sMpj3B4Bo7Na/Q29DpcSqZPW8nAVYcYJGKgZBGyAuoE=;
 b=HAJ0y52Zk9hM9c0j/lB1t1ZYSSTHwGG5DerdptunXN9S3ceM1G4xyTJbyixey+6dYN
 2DjuVp0ZimSx0ejN8eT4yiIV3gZk/lIIwB5Uac1QDLXzyZsMCV0E/llERt2/Ld9DZ6yY
 O1q73nqaJAlmkc5oEqtMJOntO9mey1zYNO0gE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760128298; x=1760733098;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sMpj3B4Bo7Na/Q29DpcSqZPW8nAVYcYJGKgZBGyAuoE=;
 b=wFlyHEMeAFEcGkoQXo3jEZDagWE/YuwR7efL20i6mi/HUecDssnUbAv9dvFKGzY6SA
 AY+DgYAOV7k57z8hOyHvSLwfHg6QYRL2HBulsJDxjfvejTc4FIIiIYDUk73nSDf248QV
 zMZT8FoUpdkLRN/XKYtRV9icNRAUadbbvlVukIQicBt/gcdAOcRPJhGSW9smQEvBYwrv
 5J3UUwgDq1jCKUxN8eZpN3DQdoCt63+wTZAmOVSvZHfUTolzQfeSc2dujgFKE2wfP7PG
 e2dIUA7u+s72ItKicoWVl0XUVXBLR/tMGTZPTEk0m7+kJqkkI06VGCgfJyrFAhDrHmGj
 KjOg==
X-Gm-Message-State: AOJu0Yzl+w/ufJ73wAJ5jBF6deK4pHQJSvvy4YW83M5kOp+7btZDGJmI
 ekowIxsHPXzrWnBHbneHyX7IH55rgL1idkWH9/ysra/34J7XJMqmz0wRm6bjTNuToto=
X-Gm-Gg: ASbGncv48LzeY2xXl+E9cWC7lM33abCNnKisyCuPOr1uUatvw30ws5EbKMS6jM65U0L
 3y0noD4n6xqn+n0DwQyJIutX86JMMekuSw2A9qIkElsQu2gtA0ZY2vMP0lGkr1src6Sxnh8VvZg
 U9gKYKWUg8GY4KQCEZ9TCNSr+/62HYXYrIjooKnePFIH/nKw/MOf68sris9O9HSmar0YiIcRvwK
 mWcS5RdUFiBNqhOVrWI/EF7sIiRO4wrdyg/gBv0N7P6K6qfCGAOU/XFisFqUqNHts0sCt8f3m49
 ythJViD69pdmsoacjpwvkDKy8XM317lDAhDKQrAqEnuJ4dNG+PujvUs+6JzuML4jsDv+vl3e2kv
 Q7gmIgu67y06EB1KhQQO5Tr9YGCHXgC10vo9Q4S/n3yXnlrzSTaoajhff40ua2BsatSQemA5fRS
 WNLrv1J/UX7o/javU=
X-Google-Smtp-Source: AGHT+IH+ZSzKrVb1nWuJiVQN8Clf+5qkaAWw7+TkfQUXdjpe+mhXPE9Hzv9PjRiBoeE/lkRQiStnHQ==
X-Received: by 2002:a05:6830:2813:b0:7ae:dbc5:4700 with SMTP id
 46e09a7af769-7c0df79b8f1mr8580551a34.19.1760128297966; 
 Fri, 10 Oct 2025 13:31:37 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0f90fb491sm1162008a34.20.2025.10.10.13.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 13:31:36 -0700 (PDT)
Date: Fri, 10 Oct 2025 14:31:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Sean Anderson <sean.anderson@seco.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v3] fs: semihosting: Fixup smh_flen and smh_read against
 overflow
Message-ID: <20251010203134.GA1187059@bill-the-cat>
References: <20251003-fs_semihosting-v3-1-5f6de9b7f225@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EgqXZpLeKJVyDMDF"
Content-Disposition: inline
In-Reply-To: <20251003-fs_semihosting-v3-1-5f6de9b7f225@linaro.org>
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


--EgqXZpLeKJVyDMDF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 03, 2025 at 10:03:57AM +0100, Andrew Goodbody wrote:

> The sys calls SYS_FLEN and SYS_READ were being used in a way that did
> not allow for file sizes > 2^31. Fixing this required changing the
> signatures of the functions smh_flen and smh_read to allow file
> sizes up to 2^32 - 2 and also being able to return errors that could be
> tested for.
>=20
> This issue was found by Smatch.
>=20
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
> Changes in v3:
> - V2 missed fixing up one use of smh_flen, fix it
> - Link to v2: https://lore.kernel.org/r/20251002-fs_semihosting-v2-1-c178=
3e4188d8@linaro.org
>=20
> Changes in v2:
> - Fixup smh_flen and smh_read to allow for > 2^31 byte files
> - Link to v1: https://lore.kernel.org/r/20251002-fs_semihosting-v1-1-1124=
e6becc51@linaro.org
> ---
>  common/spl/spl_semihosting.c        | 13 +++++++------
>  drivers/serial/serial_semihosting.c |  6 ++++--
>  fs/semihostingfs.c                  | 23 +++++++++++++----------
>  include/semihosting.h               | 13 +++++++------
>  lib/semihosting.c                   | 25 +++++++++++++++++++------
>  5 files changed, 50 insertions(+), 30 deletions(-)
>=20
> diff --git a/common/spl/spl_semihosting.c b/common/spl/spl_semihosting.c
> index f36863fe48d25859ee9af67a67140893b6e9e262..fb578a274d0d937b2ed5bd13e=
505bcefd4491799 100644
> --- a/common/spl/spl_semihosting.c
> +++ b/common/spl/spl_semihosting.c
> @@ -13,13 +13,14 @@ static ulong smh_fit_read(struct spl_load_info *load,=
 ulong file_offset,
>  			  ulong size, void *buf)
>  {
>  	long fd =3D *(long *)load->priv;
> -	ulong ret;
> +	long ret;
> +	size_t bytes_read;
> =20
>  	if (smh_seek(fd, file_offset))
>  		return 0;
> =20
> -	ret =3D smh_read(fd, buf, size);
> -	return ret < 0 ? 0 : ret;
> +	ret =3D smh_read(fd, buf, size, &bytes_read);
> +	return ret < 0 ? 0 : bytes_read;
>  }
> =20
>  static int spl_smh_load_image(struct spl_image_info *spl_image,
> @@ -27,7 +28,8 @@ static int spl_smh_load_image(struct spl_image_info *sp=
l_image,
>  {
>  	const char *filename =3D CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
>  	int ret;
> -	long fd, len;
> +	long fd;
> +	size_t len;
>  	struct spl_load_info load;
> =20
>  	fd =3D smh_open(filename, MODE_READ | MODE_BINARY);
> @@ -36,12 +38,11 @@ static int spl_smh_load_image(struct spl_image_info *=
spl_image,
>  		return fd;
>  	}
> =20
> -	ret =3D smh_flen(fd);
> +	ret =3D smh_flen(fd, &len);
>  	if (ret < 0) {
>  		log_debug("could not get length of image: %d\n", ret);
>  		goto out;
>  	}
> -	len =3D ret;
> =20
>  	spl_load_init(&load, smh_fit_read, &fd, 1);
>  	ret =3D spl_load(spl_image, bootdev, &load, len, 0);
> diff --git a/drivers/serial/serial_semihosting.c b/drivers/serial/serial_=
semihosting.c
> index 56a5ec72428afdd97eccad739a46189380ba3e76..017b1f8eda84f5c25e09be7e9=
70d0ebfdbf2ace0 100644
> --- a/drivers/serial/serial_semihosting.c
> +++ b/drivers/serial/serial_semihosting.c
> @@ -25,11 +25,12 @@ static int smh_serial_getc(struct udevice *dev)
>  {
>  	char ch =3D 0;
>  	struct smh_serial_priv *priv =3D dev_get_priv(dev);
> +	size_t bytes_read;
> =20
>  	if (priv->infd < 0)
>  		return smh_getc();
> =20
> -	smh_read(priv->infd, &ch, sizeof(ch));
> +	smh_read(priv->infd, &ch, sizeof(ch), &bytes_read);
>  	return ch;
>  }
> =20
> @@ -140,11 +141,12 @@ static void smh_serial_setbrg(void)
>  static int smh_serial_getc(void)
>  {
>  	char ch =3D 0;
> +	size_t bytes_read;
> =20
>  	if (infd < 0)
>  		return smh_getc();
> =20
> -	smh_read(infd, &ch, sizeof(ch));
> +	smh_read(infd, &ch, sizeof(ch), &bytes_read);
>  	return ch;
>  }
> =20
> diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
> index 77e39ca407e4d240a1fd573497c5b6b908816454..6a4d0aaaf2fdaf8da154e5967=
7839a5c7a4889e9 100644
> --- a/fs/semihostingfs.c
> +++ b/fs/semihostingfs.c
> @@ -23,7 +23,8 @@ int smh_fs_set_blk_dev(struct blk_desc *rbdd, struct di=
sk_partition *info)
>  static int smh_fs_read_at(const char *filename, loff_t pos, void *buffer,
>  			  loff_t maxsize, loff_t *actread)
>  {
> -	long fd, size, ret;
> +	long fd, ret;
> +	size_t size;
> =20
>  	fd =3D smh_open(filename, MODE_READ | MODE_BINARY);
>  	if (fd < 0)
> @@ -34,19 +35,19 @@ static int smh_fs_read_at(const char *filename, loff_=
t pos, void *buffer,
>  		return ret;
>  	}
>  	if (!maxsize) {
> -		size =3D smh_flen(fd);
> +		ret =3D smh_flen(fd, &size);
>  		if (ret < 0) {
>  			smh_close(fd);
> -			return size;
> +			return ret;
>  		}
> =20
>  		maxsize =3D size;
>  	}
> =20
> -	size =3D smh_read(fd, buffer, maxsize);
> +	ret =3D smh_read(fd, buffer, maxsize, &size);
>  	smh_close(fd);
> -	if (size < 0)
> -		return size;
> +	if (ret < 0)
> +		return ret;
> =20
>  	*actread =3D size;
>  	return 0;
> @@ -78,17 +79,19 @@ static int smh_fs_write_at(const char *filename, loff=
_t pos, void *buffer,
> =20
>  int smh_fs_size(const char *filename, loff_t *result)
>  {
> -	long fd, size;
> +	long fd;
> +	size_t size;
> +	int ret;
> =20
>  	fd =3D smh_open(filename, MODE_READ | MODE_BINARY);
>  	if (fd < 0)
>  		return fd;
> =20
> -	size =3D smh_flen(fd);
> +	ret =3D smh_flen(fd, &size);
>  	smh_close(fd);
> =20
> -	if (size < 0)
> -		return size;
> +	if (ret < 0)
> +		return ret;
> =20
>  	*result =3D size;
>  	return 0;
> diff --git a/include/semihosting.h b/include/semihosting.h
> index 4e844cbad87bb1ae6bb365f87f3e7a8aeea445f4..60535199b9532ce16620aea3c=
a1ea741c5b73766 100644
> --- a/include/semihosting.h
> +++ b/include/semihosting.h
> @@ -95,12 +95,12 @@ long smh_open(const char *fname, enum smh_open_mode m=
ode);
>   * @fd: A file descriptor returned from smh_open()
>   * @memp: Pointer to a buffer of memory of at least @len bytes
>   * @len: The number of bytes to read
> + * @read_len: Pointer which will be updated with actual bytes read on su=
ccess,
> + *  with 0 indicating %EOF
>   *
> - * Return:
> - * * The number of bytes read on success, with 0 indicating %EOF
> - * * A negative error on failure
> + * Return: 0 on success or negative error on failure
>   */
> -long smh_read(long fd, void *memp, size_t len);
> +long smh_read(long fd, void *memp, size_t len, size_t *read_len);
> =20
>  /**
>   * smh_write() - Write data to a file
> @@ -124,10 +124,11 @@ long smh_close(long fd);
>  /**
>   * smh_flen() - Get the length of a file
>   * @fd: A file descriptor returned from smh_open()
> + * @size: Pointer which will be updated with length of file on success
>   *
> - * Return: The length of the file, in bytes, or a negative error on fail=
ure
> + * Return: 0 on success or negative error on failure
>   */
> -long smh_flen(long fd);
> +int smh_flen(long fd, size_t *size);
> =20
>  /**
>   * smh_seek() - Seek to a position in a file
> diff --git a/lib/semihosting.c b/lib/semihosting.c
> index 9be5bffd30124777c4f8110065e6cca5640312ac..a0f42d41e4a7ad95023c684f6=
824bfc677ad25cd 100644
> --- a/lib/semihosting.c
> +++ b/lib/semihosting.c
> @@ -93,9 +93,9 @@ struct smh_rdwr_s {
>  	size_t len;
>  };
> =20
> -long smh_read(long fd, void *memp, size_t len)
> +long smh_read(long fd, void *memp, size_t len, size_t *read_len)
>  {
> -	long ret;
> +	size_t ret;
>  	struct smh_rdwr_s read;
> =20
>  	debug("%s: fd %ld, memp %p, len %zu\n", __func__, fd, memp, len);
> @@ -105,9 +105,20 @@ long smh_read(long fd, void *memp, size_t len)
>  	read.len =3D len;
> =20
>  	ret =3D smh_trap(SYSREAD, &read);
> -	if (ret < 0)
> +	if (!ret) {
> +		/* Success */
> +		*read_len =3D len;
> +		return 0;
> +	} else if (ret =3D=3D len) {
> +		/* EOF */
> +		*read_len =3D 0;
> +		return 0;
> +	} else {
> +		/* Partial success */
> +		*read_len =3D len - ret;
>  		return smh_errno();
> -	return len - ret;
> +	}
> +
>  }
> =20
>  long smh_write(long fd, const void *memp, size_t len, ulong *written)
> @@ -140,7 +151,7 @@ long smh_close(long fd)
>  	return 0;
>  }
> =20
> -long smh_flen(long fd)
> +int smh_flen(long fd, size_t *size)
>  {
>  	long ret;
> =20
> @@ -149,7 +160,9 @@ long smh_flen(long fd)
>  	ret =3D smh_trap(SYSFLEN, &fd);
>  	if (ret =3D=3D -1)
>  		return smh_errno();
> -	return ret;
> +
> +	*size =3D (size_t)ret;
> +	return 0;
>  }
> =20
>  long smh_seek(long fd, long pos)
>=20

There was (as good thing!) much review and feedback on v1 and v2. Is
everyone happy now with v3? Thanks!

--=20
Tom

--EgqXZpLeKJVyDMDF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOltIwAKCRAr4qD1Cr/k
CmAvAP9dzNW6S7wxJbIj6v4l7Xl7+6AzikSIH706S+wrn211UwD7B0k5EN8qtQCQ
Z5gBTfPE0rAJYXOMVTKLzgz6zBZnLQw=
=DRO8
-----END PGP SIGNATURE-----

--EgqXZpLeKJVyDMDF--
