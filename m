Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6887CAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 16:09:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 241FB835A2;
	Thu,  2 Oct 2025 18:09:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="sGMcdjoT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1F12835C6; Thu,  2 Oct 2025 18:09:36 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 543D581D6A
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 18:09:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1759421373; x=1760026173; i=xypron.glpk@gmx.de;
 bh=kq0MCF9bv/q78h+JvjAF+czYws2UNUCnOgXA5j++eCo=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=sGMcdjoT0GsAbouctUJrTw6ZM9nI/HDPmGr2rmZcXHzJ/dLR5MWaXihuIq1uoJO9
 iSDZrIc8/0WDngE9UYXY+4NrZUQuh5F0/yMv8XzvmNyRTT5RMwv3vgN1zNn4rVjl3
 CuBlHuArQedLPH2CbNJ8VfoNkBIX85rUNM6qfjTyL4u2BfwfCxU7saNii1lh7gt6J
 0iEJI8JHckI4m/EE1u6Uzk7vFziR0O5VUGoeGtcd05fPGVv5xbI30E5dBB3+hd30b
 N+lFLr9XS3f+5e3Hr6PLJZ+JqM3fGKciUBcEVIDNhQWbOkqAq7lP3hQALtu2kHtyS
 tfNQdWmbdG7FBydkrQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxDou-1u6ucW3f1E-00yA0I; Thu, 02
 Oct 2025 18:09:33 +0200
Date: Thu, 02 Oct 2025 18:09:30 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Sean Anderson <sean.anderson@seco.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
CC: Tom Rini <trini@konsulko.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_fs=3A_semihosting=3A_Fixup_?=
 =?US-ASCII?Q?smh=5Fflen_and_smh=5Fread_against_overflow?=
User-Agent: Thunderbird for Android
In-Reply-To: <081c49ae-f1ac-4119-8ef4-c4433131b983@seco.com>
References: <20251002-fs_semihosting-v2-1-c1783e4188d8@linaro.org>
 <081c49ae-f1ac-4119-8ef4-c4433131b983@seco.com>
Message-ID: <AD9845A5-0364-405B-AA7C-DE14266CFA43@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yyyBPYA+YxSxsh3Iivjcxyo8WzV6wjp/HfqQq/uDb6nO7lZIMYq
 MR/pixwoBmApbL8G+7uCcBGL73Ft+tarj+kImVpTmyy9TECkp8Ik/H1kMA0zZ8Xp5tAOMbU
 +v4J+kQpZKbqSBYiexfU69aYG4LzzM7zZNjS7h19aqzPW64ogikgOW7g1dx5NjXK+qBGUe1
 eGm1tecXOdcfwTH9TQnNQ==
UI-OutboundReport: notjunk:1;M01:P0:Rfw9q48Lp20=;kxhWoDUbCO9pdAt1Z3Qsn8lRDRd
 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
 84DmypF1Sm6WKzchQ=
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

Am 2=2E Oktober 2025 17:42:32 MESZ schrieb Sean Anderson <sean=2Eanderson@s=
eco=2Ecom>:
>On 10/2/25 10:32, Andrew Goodbody wrote:
>> The sys calls SYS_FLEN and SYS_READ were being used in a way that did
>> not allow for file sizes > 2^31=2E Fixing this required changing the
>> signatures of the functions smh_flen and smh_read to allow file
>> sizes up to 2^32 - 2 and also being able to return errors that could be
>> tested for=2E
>>=20
>> This issue was found by Smatch=2E
>>=20
>> Signed-off-by: Andrew Goodbody <andrew=2Egoodbody@linaro=2Eorg>
>> ---
>> Changes in v2:
>> - Fixup smh_flen and smh_read to allow for > 2^31 byte files
>> - Link to v1: https://cas5-0-urlprotect=2Etrendmicro=2Ecom:443/wis/clic=
ktime/v1/query?url=3Dhttps%3a%2f%2flore=2Ekernel=2Eorg%2fr%2f20251002%2dfs%=
5fsemihosting%2dv1%2d1%2d1124e6becc51%40linaro=2Eorg&umid=3Dee8de4df-2479-4=
8c7-83ae-b302789e6a41&rct=3D1759415558&auth=3Dd807158c60b7d2502abde8a2fc01f=
40662980862-944860761829276b5cf613a133926bf7544353ff
>> ---
>>  common/spl/spl_semihosting=2Ec        | 13 +++++++------
>>  drivers/serial/serial_semihosting=2Ec |  6 ++++--
>>  fs/semihostingfs=2Ec                  | 13 +++++++------
>>  include/semihosting=2Eh               | 13 +++++++------
>>  lib/semihosting=2Ec                   | 25 +++++++++++++++++++------
>>  5 files changed, 44 insertions(+), 26 deletions(-)
>>=20
>> diff --git a/common/spl/spl_semihosting=2Ec b/common/spl/spl_semihostin=
g=2Ec
>> index f36863fe48d25859ee9af67a67140893b6e9e262=2E=2Efb578a274d0d937b2ed=
5bd13e505bcefd4491799 100644
>> --- a/common/spl/spl_semihosting=2Ec
>> +++ b/common/spl/spl_semihosting=2Ec
>> @@ -13,13 +13,14 @@ static ulong smh_fit_read(struct spl_load_info *loa=
d, ulong file_offset,
>>  			  ulong size, void *buf)
>>  {
>>  	long fd =3D *(long *)load->priv;
>> -	ulong ret;
>> +	long ret;
>> +	size_t bytes_read;
>> =20
>>  	if (smh_seek(fd, file_offset))
>>  		return 0;
>> =20
>> -	ret =3D smh_read(fd, buf, size);
>> -	return ret < 0 ? 0 : ret;
>> +	ret =3D smh_read(fd, buf, size, &bytes_read);
>> +	return ret < 0 ? 0 : bytes_read;
>>  }
>> =20
>>  static int spl_smh_load_image(struct spl_image_info *spl_image,
>> @@ -27,7 +28,8 @@ static int spl_smh_load_image(struct spl_image_info *=
spl_image,
>>  {
>>  	const char *filename =3D CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
>>  	int ret;
>> -	long fd, len;
>> +	long fd;
>> +	size_t len;
>>  	struct spl_load_info load;
>> =20
>>  	fd =3D smh_open(filename, MODE_READ | MODE_BINARY);
>> @@ -36,12 +38,11 @@ static int spl_smh_load_image(struct spl_image_info=
 *spl_image,
>>  		return fd;
>>  	}
>> =20
>> -	ret =3D smh_flen(fd);
>> +	ret =3D smh_flen(fd, &len);
>>  	if (ret < 0) {
>>  		log_debug("could not get length of image: %d\n", ret);
>>  		goto out;
>>  	}
>> -	len =3D ret;
>> =20
>>  	spl_load_init(&load, smh_fit_read, &fd, 1);
>>  	ret =3D spl_load(spl_image, bootdev, &load, len, 0);
>> diff --git a/drivers/serial/serial_semihosting=2Ec b/drivers/serial/ser=
ial_semihosting=2Ec
>> index 56a5ec72428afdd97eccad739a46189380ba3e76=2E=2E017b1f8eda84f5c25e0=
9be7e970d0ebfdbf2ace0 100644
>> --- a/drivers/serial/serial_semihosting=2Ec
>> +++ b/drivers/serial/serial_semihosting=2Ec
>> @@ -25,11 +25,12 @@ static int smh_serial_getc(struct udevice *dev)
>>  {
>>  	char ch =3D 0;
>>  	struct smh_serial_priv *priv =3D dev_get_priv(dev);
>> +	size_t bytes_read;
>> =20
>>  	if (priv->infd < 0)
>>  		return smh_getc();
>> =20
>> -	smh_read(priv->infd, &ch, sizeof(ch));
>> +	smh_read(priv->infd, &ch, sizeof(ch), &bytes_read);
>>  	return ch;
>>  }
>> =20
>> @@ -140,11 +141,12 @@ static void smh_serial_setbrg(void)
>>  static int smh_serial_getc(void)
>>  {
>>  	char ch =3D 0;
>> +	size_t bytes_read;
>> =20
>>  	if (infd < 0)
>>  		return smh_getc();
>> =20
>> -	smh_read(infd, &ch, sizeof(ch));
>> +	smh_read(infd, &ch, sizeof(ch), &bytes_read);
>>  	return ch;
>>  }
>> =20
>> diff --git a/fs/semihostingfs=2Ec b/fs/semihostingfs=2Ec
>> index 77e39ca407e4d240a1fd573497c5b6b908816454=2E=2E71b6634b0660e32cc63=
f7fc60ec1af8d3248433a 100644
>> --- a/fs/semihostingfs=2Ec
>> +++ b/fs/semihostingfs=2Ec
>> @@ -23,7 +23,8 @@ int smh_fs_set_blk_dev(struct blk_desc *rbdd, struct =
disk_partition *info)
>>  static int smh_fs_read_at(const char *filename, loff_t pos, void *buff=
er,
>>  			  loff_t maxsize, loff_t *actread)
>>  {
>> -	long fd, size, ret;
>> +	long fd, ret;
>> +	size_t size;
>> =20
>>  	fd =3D smh_open(filename, MODE_READ | MODE_BINARY);
>>  	if (fd < 0)
>> @@ -34,19 +35,19 @@ static int smh_fs_read_at(const char *filename, lof=
f_t pos, void *buffer,
>>  		return ret;
>>  	}
>>  	if (!maxsize) {
>> -		size =3D smh_flen(fd);
>> +		ret =3D smh_flen(fd, &size);
>>  		if (ret < 0) {
>>  			smh_close(fd);
>> -			return size;
>> +			return ret;
>>  		}
>> =20
>>  		maxsize =3D size;
>>  	}
>> =20
>> -	size =3D smh_read(fd, buffer, maxsize);
>> +	ret =3D smh_read(fd, buffer, maxsize, &size);
>>  	smh_close(fd);
>> -	if (size < 0)
>> -		return size;
>> +	if (ret < 0)
>> +		return ret;
>> =20
>>  	*actread =3D size;
>>  	return 0;
>> diff --git a/include/semihosting=2Eh b/include/semihosting=2Eh
>> index 4e844cbad87bb1ae6bb365f87f3e7a8aeea445f4=2E=2E60535199b9532ce1662=
0aea3ca1ea741c5b73766 100644
>> --- a/include/semihosting=2Eh
>> +++ b/include/semihosting=2Eh
>> @@ -95,12 +95,12 @@ long smh_open(const char *fname, enum smh_open_mode=
 mode);
>>   * @fd: A file descriptor returned from smh_open()
>>   * @memp: Pointer to a buffer of memory of at least @len bytes
>>   * @len: The number of bytes to read
>> + * @read_len: Pointer which will be updated with actual bytes read on =
success,
>> + *  with 0 indicating %EOF
>>   *
>> - * Return:
>> - * * The number of bytes read on success, with 0 indicating %EOF
>> - * * A negative error on failure
>> + * Return: 0 on success or negative error on failure
>>   */
>> -long smh_read(long fd, void *memp, size_t len);
>> +long smh_read(long fd, void *memp, size_t len, size_t *read_len);
>> =20
>>  /**
>>   * smh_write() - Write data to a file
>> @@ -124,10 +124,11 @@ long smh_close(long fd);
>>  /**
>>   * smh_flen() - Get the length of a file
>>   * @fd: A file descriptor returned from smh_open()
>> + * @size: Pointer which will be updated with length of file on success
>>   *
>> - * Return: The length of the file, in bytes, or a negative error on fa=
ilure
>> + * Return: 0 on success or negative error on failure
>>   */
>> -long smh_flen(long fd);
>> +int smh_flen(long fd, size_t *size);
>> =20
>>  /**
>>   * smh_seek() - Seek to a position in a file
>> diff --git a/lib/semihosting=2Ec b/lib/semihosting=2Ec
>> index 9be5bffd30124777c4f8110065e6cca5640312ac=2E=2Ea0f42d41e4a7ad95023=
c684f6824bfc677ad25cd 100644
>> --- a/lib/semihosting=2Ec
>> +++ b/lib/semihosting=2Ec
>> @@ -93,9 +93,9 @@ struct smh_rdwr_s {
>>  	size_t len;
>>  };
>> =20
>> -long smh_read(long fd, void *memp, size_t len)
>> +long smh_read(long fd, void *memp, size_t len, size_t *read_len)
>>  {
>> -	long ret;
>> +	size_t ret;
>>  	struct smh_rdwr_s read;
>> =20
>>  	debug("%s: fd %ld, memp %p, len %zu\n", __func__, fd, memp, len);
>> @@ -105,9 +105,20 @@ long smh_read(long fd, void *memp, size_t len)
>>  	read=2Elen =3D len;
>> =20
>>  	ret =3D smh_trap(SYSREAD, &read);
>> -	if (ret < 0)
>> +	if (!ret) {
>> +		/* Success */
>> +		*read_len =3D len;
>> +		return 0;
>> +	} else if (ret =3D=3D len) {
>> +		/* EOF */
>> +		*read_len =3D 0;
>> +		return 0;
>> +	} else {
>> +		/* Partial success */
>> +		*read_len =3D len - ret;
>>  		return smh_errno();
>> -	return len - ret;
>> +	}
>> +
>>  }
>> =20
>>  long smh_write(long fd, const void *memp, size_t len, ulong *written)
>> @@ -140,7 +151,7 @@ long smh_close(long fd)
>>  	return 0;
>>  }
>> =20
>> -long smh_flen(long fd)
>> +int smh_flen(long fd, size_t *size)
>>  {
>>  	long ret;
>> =20
>> @@ -149,7 +160,9 @@ long smh_flen(long fd)
>>  	ret =3D smh_trap(SYSFLEN, &fd);
>>  	if (ret =3D=3D -1)
>>  		return smh_errno();
>> -	return ret;
>> +
>> +	*size =3D (size_t)ret;
>> +	return 0;
>
>This is completely wrong=2E long is 32-bits on 32-bit systems, so you
>cannot get the upper 64 bits just by casting to a size_t=2E
>
>--Sean

size_t has 32 bits on a 32 bit machine=2E The type of the r1 register is u=
nsigned long=2E Using signed long here may be argued about=2E

As far as GCC and LLVM are concerned:
sizeof(long) =3D=3D sizeof(size_t)=2E

Best regards=20

Heinrich


