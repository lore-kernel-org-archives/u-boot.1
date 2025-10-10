Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658FFCCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 21:33:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDB2B83F8E;
	Fri, 10 Oct 2025 23:32:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Xy6bdROz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5F9383F91; Fri, 10 Oct 2025 23:32:58 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B54783906
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 23:32:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1760131976; x=1760736776; i=xypron.glpk@gmx.de;
 bh=buM8hUHh5VQrr5P15XyIzKlNINaBdGz/aD9dBXlRxcg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Xy6bdROzhNRRPCrM9iS4gRg9q+HBjOY3IYBwkldznnRZ4iDPkAMa1z6VX0f7iNtT
 HvnkATF0Qw196EalRjKt4e/AC2kLcl9PpdI/PYQALRinGYyp4oLskms5rU/qFYRvY
 FsqzSBVQiUs1/KijEOPQ4IfB+vnm0z/Lh5uG+sBz/qOFaZiT924ajSF2OACY9Vc+3
 bdZQYDITIAimbxuOrNU7qVXMov2FqldsJJ2+ud0hYwJScgFTx4/Xx+IOrN9sszlTR
 j6weRlo+58LWCHRd0DdqF76DpJHE4aMsZ0aIGv1O6tBdByqGvMGHK1esYYSrPmehq
 kzsZ494RfDELiPXLuA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.116] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mj8qj-1udU2104ZB-00kl7r; Fri, 10
 Oct 2025 23:32:56 +0200
Message-ID: <2b7bcd81-0531-4a29-a56f-e6599080d025@gmx.de>
Date: Fri, 10 Oct 2025 23:32:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fs: semihosting: Fixup smh_flen and smh_read against
 overflow
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <sean.anderson@seco.com>,
 u-boot@lists.denx.de
References: <20251003-fs_semihosting-v3-1-5f6de9b7f225@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251003-fs_semihosting-v3-1-5f6de9b7f225@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZYuT6NK7kWpgwcek2Sh+wtynDiuUsb8jlpk42Jt4pV/U2gQFJz+
 stWWfLkhTT0khTaR1Vai3dhT8Udu4noaI9FU1UgBr3CJa22Gt8VcKrUNPfZPkkrvMBWFU6V
 01YhDJFyhGTLvrpIbaADkZE9NuaN732PU/pDtEEfob/ax6jMz1kLlzN/RtRMO1CCQbhstar
 xV/uwAmQW9nkR5QyRGnPQ==
UI-OutboundReport: notjunk:1;M01:P0:wusCXuOE0Kg=;IFq+sxrilCyix1Efv/kTq2ItEwb
 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
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

On 10/3/25 11:03, Andrew Goodbody wrote:
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
> - Link to v2: https://lore.kernel.org/r/20251002-fs_semihosting-v2-1-c17=
83e4188d8@linaro.org
>=20
> Changes in v2:
> - Fixup smh_flen and smh_read to allow for > 2^31 byte files
> - Link to v1: https://lore.kernel.org/r/20251002-fs_semihosting-v1-1-112=
4e6becc51@linaro.org
> ---
>   common/spl/spl_semihosting.c        | 13 +++++++------
>   drivers/serial/serial_semihosting.c |  6 ++++--
>   fs/semihostingfs.c                  | 23 +++++++++++++----------
>   include/semihosting.h               | 13 +++++++------
>   lib/semihosting.c                   | 25 +++++++++++++++++++------
>   5 files changed, 50 insertions(+), 30 deletions(-)
>=20
> diff --git a/common/spl/spl_semihosting.c b/common/spl/spl_semihosting.c
> index f36863fe48d25859ee9af67a67140893b6e9e262..fb578a274d0d937b2ed5bd13=
e505bcefd4491799 100644
> --- a/common/spl/spl_semihosting.c
> +++ b/common/spl/spl_semihosting.c
> @@ -13,13 +13,14 @@ static ulong smh_fit_read(struct spl_load_info *load=
, ulong file_offset,
>   			  ulong size, void *buf)
>   {
>   	long fd =3D *(long *)load->priv;
> -	ulong ret;
> +	long ret;
> +	size_t bytes_read;
>  =20
>   	if (smh_seek(fd, file_offset))
>   		return 0;
>  =20
> -	ret =3D smh_read(fd, buf, size);
> -	return ret < 0 ? 0 : ret;
> +	ret =3D smh_read(fd, buf, size, &bytes_read);
> +	return ret < 0 ? 0 : bytes_read;
>   }
>  =20
>   static int spl_smh_load_image(struct spl_image_info *spl_image,
> @@ -27,7 +28,8 @@ static int spl_smh_load_image(struct spl_image_info *s=
pl_image,
>   {
>   	const char *filename =3D CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
>   	int ret;
> -	long fd, len;
> +	long fd;
> +	size_t len;
>   	struct spl_load_info load;
>  =20
>   	fd =3D smh_open(filename, MODE_READ | MODE_BINARY);
> @@ -36,12 +38,11 @@ static int spl_smh_load_image(struct spl_image_info =
*spl_image,
>   		return fd;
>   	}
>  =20
> -	ret =3D smh_flen(fd);
> +	ret =3D smh_flen(fd, &len);
>   	if (ret < 0) {
>   		log_debug("could not get length of image: %d\n", ret);
>   		goto out;
>   	}
> -	len =3D ret;
>  =20
>   	spl_load_init(&load, smh_fit_read, &fd, 1);
>   	ret =3D spl_load(spl_image, bootdev, &load, len, 0);
> diff --git a/drivers/serial/serial_semihosting.c b/drivers/serial/serial=
_semihosting.c
> index 56a5ec72428afdd97eccad739a46189380ba3e76..017b1f8eda84f5c25e09be7e=
970d0ebfdbf2ace0 100644
> --- a/drivers/serial/serial_semihosting.c
> +++ b/drivers/serial/serial_semihosting.c
> @@ -25,11 +25,12 @@ static int smh_serial_getc(struct udevice *dev)
>   {
>   	char ch =3D 0;
>   	struct smh_serial_priv *priv =3D dev_get_priv(dev);
> +	size_t bytes_read;
>  =20
>   	if (priv->infd < 0)
>   		return smh_getc();
>  =20
> -	smh_read(priv->infd, &ch, sizeof(ch));
> +	smh_read(priv->infd, &ch, sizeof(ch), &bytes_read);
>   	return ch;
>   }
>  =20
> @@ -140,11 +141,12 @@ static void smh_serial_setbrg(void)
>   static int smh_serial_getc(void)
>   {
>   	char ch =3D 0;
> +	size_t bytes_read;
>  =20
>   	if (infd < 0)
>   		return smh_getc();
>  =20
> -	smh_read(infd, &ch, sizeof(ch));
> +	smh_read(infd, &ch, sizeof(ch), &bytes_read);
>   	return ch;
>   }
>  =20
> diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
> index 77e39ca407e4d240a1fd573497c5b6b908816454..6a4d0aaaf2fdaf8da154e596=
77839a5c7a4889e9 100644
> --- a/fs/semihostingfs.c
> +++ b/fs/semihostingfs.c
> @@ -23,7 +23,8 @@ int smh_fs_set_blk_dev(struct blk_desc *rbdd, struct d=
isk_partition *info)
>   static int smh_fs_read_at(const char *filename, loff_t pos, void *buff=
er,
>   			  loff_t maxsize, loff_t *actread)
>   {
> -	long fd, size, ret;
> +	long fd, ret;
> +	size_t size;
>  =20
>   	fd =3D smh_open(filename, MODE_READ | MODE_BINARY);
>   	if (fd < 0)
> @@ -34,19 +35,19 @@ static int smh_fs_read_at(const char *filename, loff=
_t pos, void *buffer,
>   		return ret;
>   	}
>   	if (!maxsize) {
> -		size =3D smh_flen(fd);
> +		ret =3D smh_flen(fd, &size);
>   		if (ret < 0) {
>   			smh_close(fd);
> -			return size;
> +			return ret;
>   		}
>  =20
>   		maxsize =3D size;
>   	}
>  =20
> -	size =3D smh_read(fd, buffer, maxsize);
> +	ret =3D smh_read(fd, buffer, maxsize, &size);
>   	smh_close(fd);
> -	if (size < 0)
> -		return size;
> +	if (ret < 0)
> +		return ret;
>  =20
>   	*actread =3D size;
>   	return 0;
> @@ -78,17 +79,19 @@ static int smh_fs_write_at(const char *filename, lof=
f_t pos, void *buffer,
>  =20
>   int smh_fs_size(const char *filename, loff_t *result)
>   {
> -	long fd, size;
> +	long fd;
> +	size_t size;
> +	int ret;
>  =20
>   	fd =3D smh_open(filename, MODE_READ | MODE_BINARY);
>   	if (fd < 0)
>   		return fd;
>  =20
> -	size =3D smh_flen(fd);
> +	ret =3D smh_flen(fd, &size);
>   	smh_close(fd);
>  =20
> -	if (size < 0)
> -		return size;
> +	if (ret < 0)
> +		return ret;
>  =20
>   	*result =3D size;
>   	return 0;
> diff --git a/include/semihosting.h b/include/semihosting.h
> index 4e844cbad87bb1ae6bb365f87f3e7a8aeea445f4..60535199b9532ce16620aea3=
ca1ea741c5b73766 100644
> --- a/include/semihosting.h
> +++ b/include/semihosting.h
> @@ -95,12 +95,12 @@ long smh_open(const char *fname, enum smh_open_mode =
mode);
>    * @fd: A file descriptor returned from smh_open()
>    * @memp: Pointer to a buffer of memory of at least @len bytes
>    * @len: The number of bytes to read
> + * @read_len: Pointer which will be updated with actual bytes read on s=
uccess,
> + *  with 0 indicating %EOF
>    *
> - * Return:
> - * * The number of bytes read on success, with 0 indicating %EOF
> - * * A negative error on failure
> + * Return: 0 on success or negative error on failure
>    */
> -long smh_read(long fd, void *memp, size_t len);
> +long smh_read(long fd, void *memp, size_t len, size_t *read_len);
>  =20
>   /**
>    * smh_write() - Write data to a file
> @@ -124,10 +124,11 @@ long smh_close(long fd);
>   /**
>    * smh_flen() - Get the length of a file
>    * @fd: A file descriptor returned from smh_open()
> + * @size: Pointer which will be updated with length of file on success
>    *
> - * Return: The length of the file, in bytes, or a negative error on fai=
lure
> + * Return: 0 on success or negative error on failure
>    */
> -long smh_flen(long fd);
> +int smh_flen(long fd, size_t *size);
>  =20
>   /**
>    * smh_seek() - Seek to a position in a file
> diff --git a/lib/semihosting.c b/lib/semihosting.c
> index 9be5bffd30124777c4f8110065e6cca5640312ac..a0f42d41e4a7ad95023c684f=
6824bfc677ad25cd 100644
> --- a/lib/semihosting.c
> +++ b/lib/semihosting.c
> @@ -93,9 +93,9 @@ struct smh_rdwr_s {
>   	size_t len;
>   };
>  =20
> -long smh_read(long fd, void *memp, size_t len)
> +long smh_read(long fd, void *memp, size_t len, size_t *read_len)
>   {
> -	long ret;
> +	size_t ret;
>   	struct smh_rdwr_s read;
>  =20
>   	debug("%s: fd %ld, memp %p, len %zu\n", __func__, fd, memp, len);
> @@ -105,9 +105,20 @@ long smh_read(long fd, void *memp, size_t len)
>   	read.len =3D len;
>  =20
>   	ret =3D smh_trap(SYSREAD, &read);
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
>   		return smh_errno();

The ARM specification says:

"If R0 contains a smaller value than word 3, the call was partially=20
successful. No error is assumed, but the buffer has not been filled."

The description of smh_errno() says that the function should only be=20
called if the previous semihosting call has failed.

Calling smh_errno() here seems not to match this requirement.

For partial reads smh_fs_read_at() should loop until all requested bytes=
=20
are read.

But both is stuff for a future patch series.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> -	return len - ret;
> +	}
> +
>   }
>  =20
>   long smh_write(long fd, const void *memp, size_t len, ulong *written)
> @@ -140,7 +151,7 @@ long smh_close(long fd)
>   	return 0;
>   }
>  =20
> -long smh_flen(long fd)
> +int smh_flen(long fd, size_t *size)
>   {
>   	long ret;
>  =20
> @@ -149,7 +160,9 @@ long smh_flen(long fd)
>   	ret =3D smh_trap(SYSFLEN, &fd);
>   	if (ret =3D=3D -1)
>   		return smh_errno();
> -	return ret;
> +
> +	*size =3D (size_t)ret;
> +	return 0;
>   }
>  =20
>   long smh_seek(long fd, long pos)
>=20
> ---
> base-commit: da47ddebd16a7e1047da8537fbf01558d2a89fcf
> change-id: 20251002-fs_semihosting-85d697fbfcad
>=20
> Best regards,

