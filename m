Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1C3C4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 14:00:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3718A87E38;
	Thu,  8 Feb 2024 15:00:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="09by4g1y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4319887E42; Thu,  8 Feb 2024 15:00:33 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C27D987CED
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 15:00:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-410383da759so4834695e9.2
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 06:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707400829; x=1708005629;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UFr+GTCgKobjEBjCyFDe8kfhfIm5GLQNNcVS5bjSsHY=;
 b=09by4g1yWlZ4EODqUvJjYuthlNbwq3DHdmi5klMN8rNKhMebfbvGMf3l1t8oiqumsw
 hVSYeg/wq4VAYEURCj5wzV6WrOGnspWcg9Lz5BAxN8vMAmKLbiJ+9zqsd8u5ch0yNZRE
 ACWUqFC8XH0JNeVrYAIWG/sC1nTkxn44furvfH2NJdpsfSv/rmEQ1zkrAUcsXSTiOm5R
 n5L2wtGpKg2vQP0M1xWq8u3nItwx8Y2MIVR2875rk9S7XZbawo/0nEz2luJ7WV6FFkAU
 SwNQUQDDVb9nvzkmOnSmoZQrgPPKzXVWxj2qjf4FbQaNMC3Ahok3xnoXi2nqVbR2nMTH
 miag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707400829; x=1708005629;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UFr+GTCgKobjEBjCyFDe8kfhfIm5GLQNNcVS5bjSsHY=;
 b=enNJ1237I54rXGN980hUeey5RTalEMF81JhToZqNCWBDtnmAu3+VYSXy1AsFaIKDX1
 rCFkrRl1JUQb6Dm66ekfOXHYMDShAHQ0G+LQ5gdYVxuiqcwkBnqlle6efuXNUFA4oB8I
 CMiMeq+1qUgfqKnS6skVhR8sIZq2CoQEhix51X5bUlHp9+lRXWjXzwJmfewXyIso16pw
 +IRIwsH/dIXglmoQ3F14Yk5O7eddf+aVDCzhHBRDdaq9snozPC1mEQMsRf3EWXejIqLp
 Q2DwQDAlbkzFspHRjw69X0Li5xhRHJZSGPTzChrfpEARpAJ4I3A4R6s/xAlneK/0b+bz
 lNbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvYltFkbMgRPhKHrYUvoemYqRwdONkC3LFlqts8r87Y+nH/4z9pSHhUuXF7SxdYeW9gXoi9wgmvy6dQD4fakoc030g2w==
X-Gm-Message-State: AOJu0YzVy24YQLTzLt/lQ3ezNLNz47PaZeewmIWSZNKf3aTt5Us2I+6N
 5S78y+uX/bA7rOTP10CO5qkBc1rX7ya8ChL6Vd/XFbg2TAQFBlI2fJLqJtApN3k=
X-Google-Smtp-Source: AGHT+IFvP9TaxW+Zy/KLqx6yHlx9VOzbe2rv/AfVDo/vLKSjYjoyyePlvwKgRiwLet9Y5EP7vYkepQ==
X-Received: by 2002:a05:600c:444e:b0:40f:e8ad:e29 with SMTP id
 v14-20020a05600c444e00b0040fe8ad0e29mr5474615wmn.0.1707400828970; 
 Thu, 08 Feb 2024 06:00:28 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUSAzLMN3uxpn6RH1wDQmQTWltKx1Vy65NPBWw2RErsWgpKu+4mp6P+7IyXvqpyGncxv8s8cAzX7d1cmY+S0Ioc5/ffy6Yb3uX77PavyobOkM2AdZb7uJtt
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 bv11-20020a0560001f0b00b0033b483d1abcsm1356642wrb.53.2024.02.08.06.00.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 06:00:28 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@foundries.io>, u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1 4/7] cmd: avb: rework prints
In-Reply-To: <20240206223153.3060433-5-igor.opaniuk@foundries.io>
References: <20240206223153.3060433-1-igor.opaniuk@foundries.io>
 <20240206223153.3060433-5-igor.opaniuk@foundries.io>
Date: Thu, 08 Feb 2024 15:00:27 +0100
Message-ID: <875xyzjbt0.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Igor,

Thank you for the patch.

On mar., f=C3=A9vr. 06, 2024 at 23:31, Igor Opaniuk <igor.opaniuk@foundries=
.io> wrote:

> From: Igor Opaniuk <igor.opaniuk@gmail.com>
>
> Introduce AVB_OPS_CHECK macro for checking AvbOps before using
> it to avoid code duplication.
> Simplify and add more context for prints where it's needed.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
> ---
>
>  cmd/avb.c | 156 ++++++++++++++++++++++++++++--------------------------
>  1 file changed, 80 insertions(+), 76 deletions(-)
>
> diff --git a/cmd/avb.c b/cmd/avb.c
> index ce8b63873f2..ae0012c0e79 100644
> --- a/cmd/avb.c
> +++ b/cmd/avb.c
> @@ -11,6 +11,14 @@
>  #include <mmc.h>
>=20=20
>  #define AVB_BOOTARGS	"avb_bootargs"
> +
> +#define AVB_OPS_CHECK(avb_ops) do { \
> +	if (!(avb_ops)) { \
> +		printf("AVB is not initialized, please run 'avb init <id>'\n"); \
> +		return CMD_RET_FAILURE; \
> +	} \
> +} while (false)
> +
checkpatch.pl --u-boot seems to complain about this:
WARNING: Macros with flow control statements should be avoided
#25: FILE: cmd/avb.c:15:

This seems documented in the kernel coding style as well.
https://www.kernel.org/doc/html/latest/process/coding-style.html#macros-enu=
ms-and-rtl

I'd argue that in this case, it's not better or worse in terme of
readability but i'd prefer to stick to the rules in this case.

The error handling (using ret) and the better prints seem fine though.
Could we drop the AVB_OPS_CHECK macro for v2?

>  static struct AvbOps *avb_ops;
>=20=20
>  int do_avb_init(struct cmd_tbl *cmdtp, int flag, int argc, char *const a=
rgv[])
> @@ -28,8 +36,10 @@ int do_avb_init(struct cmd_tbl *cmdtp, int flag, int a=
rgc, char *const argv[])
>  	avb_ops =3D avb_ops_alloc(mmc_dev);
>  	if (avb_ops)
>  		return CMD_RET_SUCCESS;
> +	else
> +		printf("Can't allocate AvbOps");
>=20=20
> -	printf("Failed to initialize avb2\n");
> +	printf("Failed to initialize AVB\n");
>=20=20
>  	return CMD_RET_FAILURE;
>  }
> @@ -41,11 +51,9 @@ int do_avb_read_part(struct cmd_tbl *cmdtp, int flag, =
int argc,
>  	s64 offset;
>  	size_t bytes, bytes_read =3D 0;
>  	void *buffer;
> +	int ret;
>=20=20
> -	if (!avb_ops) {
> -		printf("AVB 2.0 is not initialized, please run 'avb init'\n");
> -		return CMD_RET_USAGE;
> -	}
> +	AVB_OPS_CHECK(avb_ops);
>=20=20
>  	if (argc !=3D 5)
>  		return CMD_RET_USAGE;
> @@ -55,14 +63,15 @@ int do_avb_read_part(struct cmd_tbl *cmdtp, int flag,=
 int argc,
>  	bytes =3D hextoul(argv[3], NULL);
>  	buffer =3D (void *)hextoul(argv[4], NULL);
>=20=20
> -	if (avb_ops->read_from_partition(avb_ops, part, offset, bytes,
> -					 buffer, &bytes_read) =3D=3D
> -					 AVB_IO_RESULT_OK) {
> +	ret =3D avb_ops->read_from_partition(avb_ops, part, offset,
> +					   bytes, buffer, &bytes_read);
> +	if (ret =3D=3D AVB_IO_RESULT_OK) {
>  		printf("Read %zu bytes\n", bytes_read);
>  		return CMD_RET_SUCCESS;
>  	}
>=20=20
> -	printf("Failed to read from partition\n");
> +	printf("Failed to read from partition '%s', err =3D %d\n",
> +	       part, ret);
>=20=20
>  	return CMD_RET_FAILURE;
>  }
> @@ -74,11 +83,9 @@ int do_avb_read_part_hex(struct cmd_tbl *cmdtp, int fl=
ag, int argc,
>  	s64 offset;
>  	size_t bytes, bytes_read =3D 0;
>  	char *buffer;
> +	int ret;
>=20=20
> -	if (!avb_ops) {
> -		printf("AVB 2.0 is not initialized, please run 'avb init'\n");
> -		return CMD_RET_USAGE;
> -	}
> +	AVB_OPS_CHECK(avb_ops);
>=20=20
>  	if (argc !=3D 4)
>  		return CMD_RET_USAGE;
> @@ -94,8 +101,9 @@ int do_avb_read_part_hex(struct cmd_tbl *cmdtp, int fl=
ag, int argc,
>  	}
>  	memset(buffer, 0, bytes);
>=20=20
> -	if (avb_ops->read_from_partition(avb_ops, part, offset, bytes, buffer,
> -					 &bytes_read) =3D=3D AVB_IO_RESULT_OK) {
> +	ret =3D avb_ops->read_from_partition(avb_ops, part, offset,
> +					   bytes, buffer, &bytes_read);
> +	if (ret =3D=3D AVB_IO_RESULT_OK) {
>  		printf("Requested %zu, read %zu bytes\n", bytes, bytes_read);
>  		printf("Data: ");
>  		for (int i =3D 0; i < bytes_read; i++)
> @@ -107,7 +115,8 @@ int do_avb_read_part_hex(struct cmd_tbl *cmdtp, int f=
lag, int argc,
>  		return CMD_RET_SUCCESS;
>  	}
>=20=20
> -	printf("Failed to read from partition\n");
> +	printf("Failed to read from partition '%s', err =3D %d\n",
> +	       part, ret);
>=20=20
>  	free(buffer);
>  	return CMD_RET_FAILURE;
> @@ -120,11 +129,9 @@ int do_avb_write_part(struct cmd_tbl *cmdtp, int fla=
g, int argc,
>  	s64 offset;
>  	size_t bytes;
>  	void *buffer;
> +	int ret;
>=20=20
> -	if (!avb_ops) {
> -		printf("AVB 2.0 is not initialized, run 'avb init' first\n");
> -		return CMD_RET_FAILURE;
> -	}
> +	AVB_OPS_CHECK(avb_ops);
>=20=20
>  	if (argc !=3D 5)
>  		return CMD_RET_USAGE;
> @@ -134,13 +141,15 @@ int do_avb_write_part(struct cmd_tbl *cmdtp, int fl=
ag, int argc,
>  	bytes =3D hextoul(argv[3], NULL);
>  	buffer =3D (void *)hextoul(argv[4], NULL);
>=20=20
> -	if (avb_ops->write_to_partition(avb_ops, part, offset, bytes, buffer) =
=3D=3D
> -	    AVB_IO_RESULT_OK) {
> +	ret =3D avb_ops->write_to_partition(avb_ops, part, offset,
> +					  bytes, buffer);
> +	if (ret =3D=3D AVB_IO_RESULT_OK) {
>  		printf("Wrote %zu bytes\n", bytes);
>  		return CMD_RET_SUCCESS;
>  	}
>=20=20
> -	printf("Failed to write in partition\n");
> +	printf("Failed to write in partition '%s', err =3D %d\n",
> +	       part, ret);
>=20=20
>  	return CMD_RET_FAILURE;
>  }
> @@ -150,24 +159,23 @@ int do_avb_read_rb(struct cmd_tbl *cmdtp, int flag,=
 int argc,
>  {
>  	size_t index;
>  	u64 rb_idx;
> +	int ret;
>=20=20
> -	if (!avb_ops) {
> -		printf("AVB 2.0 is not initialized, run 'avb init' first\n");
> -		return CMD_RET_FAILURE;
> -	}
> +	AVB_OPS_CHECK(avb_ops);
>=20=20
>  	if (argc !=3D 2)
>  		return CMD_RET_USAGE;
>=20=20
>  	index =3D (size_t)hextoul(argv[1], NULL);
>=20=20
> -	if (avb_ops->read_rollback_index(avb_ops, index, &rb_idx) =3D=3D
> -	    AVB_IO_RESULT_OK) {
> +	ret =3D avb_ops->read_rollback_index(avb_ops, index, &rb_idx);
> +	if (ret =3D=3D AVB_IO_RESULT_OK) {
>  		printf("Rollback index: %llx\n", rb_idx);
>  		return CMD_RET_SUCCESS;
>  	}
>=20=20
> -	printf("Failed to read rollback index\n");
> +	printf("Failed to read rollback index id =3D %zu, err =3D %d\n",
> +	       index, ret);
>=20=20
>  	return CMD_RET_FAILURE;
>  }
> @@ -177,11 +185,9 @@ int do_avb_write_rb(struct cmd_tbl *cmdtp, int flag,=
 int argc,
>  {
>  	size_t index;
>  	u64 rb_idx;
> +	int ret;
>=20=20
> -	if (!avb_ops) {
> -		printf("AVB 2.0 is not initialized, run 'avb init' first\n");
> -		return CMD_RET_FAILURE;
> -	}
> +	AVB_OPS_CHECK(avb_ops);
>=20=20
>  	if (argc !=3D 3)
>  		return CMD_RET_USAGE;
> @@ -189,11 +195,12 @@ int do_avb_write_rb(struct cmd_tbl *cmdtp, int flag=
, int argc,
>  	index =3D (size_t)hextoul(argv[1], NULL);
>  	rb_idx =3D hextoul(argv[2], NULL);
>=20=20
> -	if (avb_ops->write_rollback_index(avb_ops, index, rb_idx) =3D=3D
> -	    AVB_IO_RESULT_OK)
> +	ret =3D avb_ops->write_rollback_index(avb_ops, index, rb_idx);
> +	if (ret =3D=3D AVB_IO_RESULT_OK)
>  		return CMD_RET_SUCCESS;
>=20=20
> -	printf("Failed to write rollback index\n");
> +	printf("Failed to write rollback index id =3D %zu, err =3D %d\n",
> +	       index, ret);
>=20=20
>  	return CMD_RET_FAILURE;
>  }
> @@ -203,25 +210,25 @@ int do_avb_get_uuid(struct cmd_tbl *cmdtp, int flag,
>  {
>  	const char *part;
>  	char buffer[UUID_STR_LEN + 1];
> +	int ret;
>=20=20
> -	if (!avb_ops) {
> -		printf("AVB 2.0 is not initialized, run 'avb init' first\n");
> -		return CMD_RET_FAILURE;
> -	}
> +	AVB_OPS_CHECK(avb_ops);
>=20=20
>  	if (argc !=3D 2)
>  		return CMD_RET_USAGE;
>=20=20
>  	part =3D argv[1];
>=20=20
> -	if (avb_ops->get_unique_guid_for_partition(avb_ops, part, buffer,
> -						   UUID_STR_LEN + 1) =3D=3D
> -						   AVB_IO_RESULT_OK) {
> +	ret =3D avb_ops->get_unique_guid_for_partition(avb_ops, part,
> +						     buffer,
> +						     UUID_STR_LEN + 1);
> +	if (ret =3D=3D AVB_IO_RESULT_OK) {
>  		printf("'%s' UUID: %s\n", part, buffer);
>  		return CMD_RET_SUCCESS;
>  	}
>=20=20
> -	printf("Failed to read UUID\n");
> +	printf("Failed to read partition '%s' UUID, err =3D %d\n",
> +	       part, ret);
>=20=20
>  	return CMD_RET_FAILURE;
>  }
> @@ -235,14 +242,12 @@ int do_avb_verify_part(struct cmd_tbl *cmdtp, int f=
lag,
>  	char *cmdline;
>  	char *extra_args;
>  	char *slot_suffix =3D "";
> +	int ret;
>=20=20
>  	bool unlocked =3D false;
>  	int res =3D CMD_RET_FAILURE;
>=20=20
> -	if (!avb_ops) {
> -		printf("AVB 2.0 is not initialized, run 'avb init' first\n");
> -		return CMD_RET_FAILURE;
> -	}
> +	AVB_OPS_CHECK(avb_ops);
>=20=20
>  	if (argc < 1 || argc > 2)
>  		return CMD_RET_USAGE;
> @@ -253,9 +258,10 @@ int do_avb_verify_part(struct cmd_tbl *cmdtp, int fl=
ag,
>  	printf("## Android Verified Boot 2.0 version %s\n",
>  	       avb_version_string());
>=20=20
> -	if (avb_ops->read_is_device_unlocked(avb_ops, &unlocked) !=3D
> -	    AVB_IO_RESULT_OK) {
> -		printf("Can't determine device lock state.\n");
> +	ret =3D avb_ops->read_is_device_unlocked(avb_ops, &unlocked);
> +	if (ret !=3D AVB_IO_RESULT_OK) {
> +		printf("Can't determine device lock state, err =3D %d\n",
> +		       ret);
>  		return CMD_RET_FAILURE;
>  	}
>=20=20
> @@ -302,10 +308,10 @@ int do_avb_verify_part(struct cmd_tbl *cmdtp, int f=
lag,
>  		printf("Corrupted dm-verity metadata detected\n");
>  		break;
>  	case AVB_SLOT_VERIFY_RESULT_ERROR_UNSUPPORTED_VERSION:
> -		printf("Unsupported version avbtool was used\n");
> +		printf("Unsupported version of avbtool was used\n");
>  		break;
>  	case AVB_SLOT_VERIFY_RESULT_ERROR_ROLLBACK_INDEX:
> -		printf("Checking rollback index failed\n");
> +		printf("Rollback index check failed\n");
>  		break;
>  	case AVB_SLOT_VERIFY_RESULT_ERROR_PUBLIC_KEY_REJECTED:
>  		printf("Public key was rejected\n");
> @@ -324,24 +330,23 @@ int do_avb_is_unlocked(struct cmd_tbl *cmdtp, int f=
lag,
>  		       int argc, char *const argv[])
>  {
>  	bool unlock;
> +	int ret;
>=20=20
> -	if (!avb_ops) {
> -		printf("AVB not initialized, run 'avb init' first\n");
> -		return CMD_RET_FAILURE;
> -	}
> +	AVB_OPS_CHECK(avb_ops);
>=20=20
>  	if (argc !=3D 1) {
>  		printf("--%s(-1)\n", __func__);
>  		return CMD_RET_USAGE;
>  	}
>=20=20
> -	if (avb_ops->read_is_device_unlocked(avb_ops, &unlock) =3D=3D
> -	    AVB_IO_RESULT_OK) {
> +	ret =3D avb_ops->read_is_device_unlocked(avb_ops, &unlock);
> +	if (ret =3D=3D AVB_IO_RESULT_OK) {
>  		printf("Unlocked =3D %d\n", unlock);
>  		return CMD_RET_SUCCESS;
>  	}
>=20=20
> -	printf("Can't determine device lock state.\n");
> +	printf("Can't determine device lock state, err =3D %d\n",
> +	       ret);
>=20=20
>  	return CMD_RET_FAILURE;
>  }
> @@ -354,11 +359,9 @@ int do_avb_read_pvalue(struct cmd_tbl *cmdtp, int fl=
ag, int argc,
>  	size_t bytes_read;
>  	void *buffer;
>  	char *endp;
> +	int ret;
>=20=20
> -	if (!avb_ops) {
> -		printf("AVB 2.0 is not initialized, run 'avb init' first\n");
> -		return CMD_RET_FAILURE;
> -	}
> +	AVB_OPS_CHECK(avb_ops);
>=20=20
>  	if (argc !=3D 3)
>  		return CMD_RET_USAGE;
> @@ -372,15 +375,16 @@ int do_avb_read_pvalue(struct cmd_tbl *cmdtp, int f=
lag, int argc,
>  	if (!buffer)
>  		return CMD_RET_FAILURE;
>=20=20
> -	if (avb_ops->read_persistent_value(avb_ops, name, bytes, buffer,
> -					   &bytes_read) =3D=3D AVB_IO_RESULT_OK) {
> +	ret =3D avb_ops->read_persistent_value(avb_ops, name, bytes,
> +					     buffer, &bytes_read);
> +	if (ret =3D=3D AVB_IO_RESULT_OK) {
>  		printf("Read %zu bytes, value =3D %s\n", bytes_read,
>  		       (char *)buffer);
>  		free(buffer);
>  		return CMD_RET_SUCCESS;
>  	}
>=20=20
> -	printf("Failed to read persistent value\n");
> +	printf("Failed to read persistent value, err =3D %d\n", ret);
>=20=20
>  	free(buffer);
>=20=20
> @@ -392,11 +396,9 @@ int do_avb_write_pvalue(struct cmd_tbl *cmdtp, int f=
lag, int argc,
>  {
>  	const char *name;
>  	const char *value;
> +	int ret;
>=20=20
> -	if (!avb_ops) {
> -		printf("AVB 2.0 is not initialized, run 'avb init' first\n");
> -		return CMD_RET_FAILURE;
> -	}
> +	AVB_OPS_CHECK(avb_ops);
>=20=20
>  	if (argc !=3D 3)
>  		return CMD_RET_USAGE;
> @@ -404,14 +406,16 @@ int do_avb_write_pvalue(struct cmd_tbl *cmdtp, int =
flag, int argc,
>  	name =3D argv[1];
>  	value =3D argv[2];
>=20=20
> -	if (avb_ops->write_persistent_value(avb_ops, name, strlen(value) + 1,
> -					    (const uint8_t *)value) =3D=3D
> -	    AVB_IO_RESULT_OK) {
> +	ret =3D avb_ops->write_persistent_value(avb_ops, name,
> +					      strlen(value) + 1,
> +					      (const uint8_t *)value);
> +	if (ret =3D=3D AVB_IO_RESULT_OK) {
>  		printf("Wrote %zu bytes\n", strlen(value) + 1);
>  		return CMD_RET_SUCCESS;
>  	}
>=20=20
> -	printf("Failed to write persistent value\n");
> +	printf("Failed to write persistent value `%s` =3D `%s`, err =3D %d\n",
> +	       name, value, ret);
>=20=20
>  	return CMD_RET_FAILURE;
>  }
> --=20
> 2.34.1
