Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD6FCCA470
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 05:31:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 336088349B;
	Fri,  3 Oct 2025 07:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="g04bNE5g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DCFA834D4; Fri,  3 Oct 2025 07:31:56 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B484D833F6
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 07:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1759469510; x=1760074310; i=xypron.glpk@gmx.de;
 bh=oT03EVaAv3f6ZMKPEdj4MM8b5G06GVSrNeAOHraSdpM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=g04bNE5gqQccZZBWgxKr/XFHJpLccXKjn49b+SFc4Vx2IiaKQKzuKfDLGjkEUDuG
 t9trBov+7T5P34yCAZk+mlfllnJnCIcDnLA4KTWy3mUR5cNrt5E7WH6uTWdRisLQj
 T9gnY81yuev/REJ/LBSxucyy6x09kScc3TCJrFv5Mh5BxQ2vutAZl0T2kM7eF1qWp
 vUO4xQeTYlBjHv1kcvjSu+f9KLUckJsd0j/3665beqIRNNyuwjcMw4b0lrri87Q+O
 8ogpm1yiqTda4WbUAlypN9LX+eefKa/NsGzW5H9muB0trNbinlZ0qhxffwTsuEacU
 rNeZF+s6XNjhyBEwog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqb1W-1uZuUA28Ey-00ijp0; Fri, 03
 Oct 2025 07:31:50 +0200
Message-ID: <d089398e-cf6f-486c-907f-c685a0876e47@gmx.de>
Date: Fri, 3 Oct 2025 07:31:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs: semihosting: Fixup smh_flen and smh_read against
 overflow
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <sean.anderson@seco.com>,
 u-boot@lists.denx.de
References: <20251002-fs_semihosting-v2-1-c1783e4188d8@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251002-fs_semihosting-v2-1-c1783e4188d8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NjEkiT9MVGOHy/eMHXLiqhH9DpOpzUaF+DQIXtQI4T+l/msHy/f
 ZhZ0pgh3zKD5kMbwFacne01eAEauZduluP8xwlkBw5GGLZCWsE+g8XQEhUdtm8MH0j+MCXo
 wz/pge/EDj8ZRJ0nQx6eKEYkam772e1Cnt9HVmIeHSBCb1+y4ERf1oFtUmz4Y9Cun69BWoG
 89QrBxy+lrSW2dkJLdLdQ==
UI-OutboundReport: notjunk:1;M01:P0:MjEAbSPjme4=;8kcBoFz64O/DTIfX8QcmEE5+/1p
 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
 /73FcGMqIyUnqE9dc=
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

On 10/2/25 16:32, Andrew Goodbody wrote:
> The sys calls SYS_FLEN and SYS_READ were being used in a way that did
> not allow for file sizes > 2^31. Fixing this required changing the
> signatures of the functions smh_flen and smh_read to allow file
> sizes up to 2^32 - 2 and also being able to return errors that could be
> tested for.
>=20
> This issue was found by Smatch.
>=20
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

I applied this patch to origin/master and build qemu_arm_defconfig with=20
CONFIG_SEMIHOSTING=3Dy. It seems you missed one occurence of smh_flen.

fs/semihostingfs.c: In function =E2=80=98smh_fs_size=E2=80=99:
fs/semihostingfs.c:88:16: error: too few arguments to function=20
=E2=80=98smh_flen=E2=80=99; expected 2, have 1
    88 |         size =3D smh_flen(fd);
       |                ^~~~~~~~
In file included from fs/semihostingfs.c:11:
include/semihosting.h:131:5: note: declared here
   131 | int smh_flen(long fd, size_t *size);
       |     ^~~~~~~~

To fix the issue I applied this diff on top of your patch:

diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
index 71b6634b066..d2f065782d6 100644
=2D-- a/fs/semihostingfs.c
+++ b/fs/semihostingfs.c
@@ -79,17 +79,19 @@ static int smh_fs_write_at(const char *filename,=20
loff_t pos, void *buffer,

  int smh_fs_size(const char *filename, loff_t *result)
  {
-       long fd, size;
+       long fd;
+       size_t size;
+       int ret;

         fd =3D smh_open(filename, MODE_READ | MODE_BINARY);
         if (fd < 0)
                 return fd;

-       size =3D smh_flen(fd);
+       ret =3D smh_flen(fd, &size);
         smh_close(fd);

-       if (size < 0)
-               return size;
+       if (ret)
+               return ret;

         *result =3D size;
         return 0;

With that correction the size command gives me these results for files=20
with size 3 GiB and 5 GiB on 32bit ARM:

=3D> size hostfs - 3G ; echo $filesize
c0000000
=3D> size hostfs - 5G ; echo $filesize
40000000

The incorrect result for 5G needs to be corrected in QEMU. QEMU should=20
return an error for files exceeding 0xfffffffe length on 32 bit systems.

On 64bit ARM everything is fine:

=3D> size hostfs - 3 ; echo $filesize
c0000000
=3D> size hostfs - 5 ; echo $filesize
140000000

For a missing file the error is correctly reported:
=3D> size hostfs - 2; echo $?
1

For a file without access writes $? is also set to $1 because opening=20
already fails:

$ ls r
-r-------- 1 root root 10 Okt  3 07:25 r

=3D> size hostfs - r; echo $?
1

Please, resubmit the patch.

Best regards

Heinrich

> ---
> Changes in v2:
> - Fixup smh_flen and smh_read to allow for > 2^31 byte files
> - Link to v1: https://lore.kernel.org/r/20251002-fs_semihosting-v1-1-112=
4e6becc51@linaro.org
> ---
>   common/spl/spl_semihosting.c        | 13 +++++++------
>   drivers/serial/serial_semihosting.c |  6 ++++--
>   fs/semihostingfs.c                  | 13 +++++++------
>   include/semihosting.h               | 13 +++++++------
>   lib/semihosting.c                   | 25 +++++++++++++++++++------
>   5 files changed, 44 insertions(+), 26 deletions(-)
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
> index 77e39ca407e4d240a1fd573497c5b6b908816454..71b6634b0660e32cc63f7fc6=
0ec1af8d3248433a 100644
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

