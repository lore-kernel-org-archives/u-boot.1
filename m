Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93CA1C48260
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 08:21:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB1B487D23;
	Tue, 13 Feb 2024 09:21:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Yj9z9n6X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCABE87D02; Tue, 13 Feb 2024 09:21:12 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1438887D29
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 09:20:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-411a6ada28dso4145815e9.3
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 00:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707812453; x=1708417253;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BS/DwgvVtRMPnk//XXakzSrH1FUDKamJI2fW4Jd2g8k=;
 b=Yj9z9n6X2LqzF4hVp2YfmAC1KuCdZEcj7lCZNCeKYjlN4BfZuGgup3fZqJu8EHBuaV
 k6dhybsnnRYgbyX+ODaF/hNlPERIep4sHO1zRkDl2j3mk+N6J5qsH3Ddygp4Jpdotek3
 HoKsT6UbtDnw7DRxHCTKIqNS8b3oTSdrOn6KUc226p04k0EQotHzqrth5Ngsgkzm0xId
 cf4f11pPe1aRIL73rSsCAPrPGwUxsDcmNq8CdMkjeRyZjk3cHjtzhG2XBaQ45hYf4a4Y
 ww/4ifQk+n40Rytm2+S+jrWdedWJvAXKEPiXMQDe09F37LS3KvSYLa1R5hkw6pv6dMlp
 YurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707812453; x=1708417253;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BS/DwgvVtRMPnk//XXakzSrH1FUDKamJI2fW4Jd2g8k=;
 b=Ma09hdLTt9fpCNEVe0YT0iQsCIYkm0vcfW3M5rVr6Jjm/wA9jQPnYL78bmhFlpjAn3
 nTwX9S+vKf00cejf8qtb5GxT3vqwvZZWYkZUPtfgjwN/gb/JTViOf/tWkvDLKf3bH+m6
 nmuFs1A2lge4OYse4B2LJ/ZPRGEl8KysNyZK6aTh20fCCjbtSLbwf+8EAyZveSgHwWpf
 7KN7XjvbRZOyzQpP/tP3xsAGbsJTWk5R+ET2f9fh8YusFHUedq5HgXJDIa9DrkUIs6Yp
 ceefssJDP/d60eUgFMhE1pR3FOt4b0s8b+1Pu8Tl5Rytgn4FPTv0IB96TRzecXo9lPy8
 bwvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkvGqYSxloL8GEBvbwSGTyUidAgdzQfsdiLHVhDc0CP16WYkq/5W/WemUAeT5oTkYOXB9Msh6kpg1um5ojvr/zeUX2pg==
X-Gm-Message-State: AOJu0Yz1tI6ID/axcePAL6HclXm8RwO2S/VncJAz/0n9tHliovNj9Fkn
 SUXPkKA5YzFULPT6cUiLdirPQvAnI3EeyrthCaNkdNS+NfCa32eNC9jSKMXwLJU=
X-Google-Smtp-Source: AGHT+IGdyhHY7OUbSkxqoK4sxzHvSkBqm+PkkgWgZaB3IdqpbYtpMXkG8N4s42BVFgOmIdU0pfLW4Q==
X-Received: by 2002:a05:600c:1c89:b0:410:cc74:cb9c with SMTP id
 k9-20020a05600c1c8900b00410cc74cb9cmr3439936wms.25.1707812453362; 
 Tue, 13 Feb 2024 00:20:53 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXdm6MjsQg+bfXOYxGHcYW5jBCB2kOvTVcHzXKdAsHHFpzMqM9NCatP+rsapOj/SdEPbVobXihG/F8OP/J7Dk1/FOb4v0Hg/7Gv04B+Y1rshvpk+WLFfc/z
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 p7-20020a05600c358700b004107219c664sm11037435wmq.32.2024.02.13.00.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 00:20:53 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@foundries.io>, u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 4/7] cmd: avb: rework prints
In-Reply-To: <20240209192045.3961832-5-igor.opaniuk@foundries.io>
References: <20240209192045.3961832-1-igor.opaniuk@foundries.io>
 <20240209192045.3961832-5-igor.opaniuk@foundries.io>
Date: Tue, 13 Feb 2024 09:20:52 +0100
Message-ID: <87eddgg4gr.fsf@baylibre.com>
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

On ven., f=C3=A9vr. 09, 2024 at 20:20, Igor Opaniuk <igor.opaniuk@foundries=
.io> wrote:

> From: Igor Opaniuk <igor.opaniuk@gmail.com>
>
> Simplify and add more context for prints where it's needed.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
> Changes in v2:
> - Drop AVB_OPS_CHECK macro and leave previous check
>
>  cmd/avb.c | 123 +++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 75 insertions(+), 48 deletions(-)
>
> diff --git a/cmd/avb.c b/cmd/avb.c
> index ce8b63873f2..62a3ee18e7f 100644
> --- a/cmd/avb.c
> +++ b/cmd/avb.c
> @@ -11,6 +11,7 @@
>  #include <mmc.h>
>=20=20
>  #define AVB_BOOTARGS	"avb_bootargs"
> +
>  static struct AvbOps *avb_ops;
>=20=20
>  int do_avb_init(struct cmd_tbl *cmdtp, int flag, int argc, char *const a=
rgv[])
> @@ -28,8 +29,10 @@ int do_avb_init(struct cmd_tbl *cmdtp, int flag, int a=
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
> @@ -41,10 +44,11 @@ int do_avb_read_part(struct cmd_tbl *cmdtp, int flag,=
 int argc,
>  	s64 offset;
>  	size_t bytes, bytes_read =3D 0;
>  	void *buffer;
> +	int ret;
>=20=20
>  	if (!avb_ops) {
> -		printf("AVB 2.0 is not initialized, please run 'avb init'\n");
> -		return CMD_RET_USAGE;
> +		printf("AVB is not initialized, please run 'avb init <id>'\n");
> +		return CMD_RET_FAILURE;
>  	}
>=20=20
>  	if (argc !=3D 5)
> @@ -55,14 +59,15 @@ int do_avb_read_part(struct cmd_tbl *cmdtp, int flag,=
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
> @@ -74,10 +79,11 @@ int do_avb_read_part_hex(struct cmd_tbl *cmdtp, int f=
lag, int argc,
>  	s64 offset;
>  	size_t bytes, bytes_read =3D 0;
>  	char *buffer;
> +	int ret;
>=20=20
>  	if (!avb_ops) {
> -		printf("AVB 2.0 is not initialized, please run 'avb init'\n");
> -		return CMD_RET_USAGE;
> +		printf("AVB is not initialized, please run 'avb init <id>'\n");
> +		return CMD_RET_FAILURE;
>  	}
>=20=20
>  	if (argc !=3D 4)
> @@ -94,8 +100,9 @@ int do_avb_read_part_hex(struct cmd_tbl *cmdtp, int fl=
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
> @@ -107,7 +114,8 @@ int do_avb_read_part_hex(struct cmd_tbl *cmdtp, int f=
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
> @@ -120,9 +128,10 @@ int do_avb_write_part(struct cmd_tbl *cmdtp, int fla=
g, int argc,
>  	s64 offset;
>  	size_t bytes;
>  	void *buffer;
> +	int ret;
>=20=20
>  	if (!avb_ops) {
> -		printf("AVB 2.0 is not initialized, run 'avb init' first\n");
> +		printf("AVB is not initialized, please run 'avb init <id>'\n");
>  		return CMD_RET_FAILURE;
>  	}
>=20=20
> @@ -134,13 +143,15 @@ int do_avb_write_part(struct cmd_tbl *cmdtp, int fl=
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
> @@ -150,9 +161,10 @@ int do_avb_read_rb(struct cmd_tbl *cmdtp, int flag, =
int argc,
>  {
>  	size_t index;
>  	u64 rb_idx;
> +	int ret;
>=20=20
>  	if (!avb_ops) {
> -		printf("AVB 2.0 is not initialized, run 'avb init' first\n");
> +		printf("AVB is not initialized, please run 'avb init <id>'\n");
>  		return CMD_RET_FAILURE;
>  	}
>=20=20
> @@ -161,13 +173,14 @@ int do_avb_read_rb(struct cmd_tbl *cmdtp, int flag,=
 int argc,
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
> @@ -177,9 +190,10 @@ int do_avb_write_rb(struct cmd_tbl *cmdtp, int flag,=
 int argc,
>  {
>  	size_t index;
>  	u64 rb_idx;
> +	int ret;
>=20=20
>  	if (!avb_ops) {
> -		printf("AVB 2.0 is not initialized, run 'avb init' first\n");
> +		printf("AVB is not initialized, please run 'avb init <id>'\n");
>  		return CMD_RET_FAILURE;
>  	}
>=20=20
> @@ -189,11 +203,12 @@ int do_avb_write_rb(struct cmd_tbl *cmdtp, int flag=
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
> @@ -203,9 +218,10 @@ int do_avb_get_uuid(struct cmd_tbl *cmdtp, int flag,
>  {
>  	const char *part;
>  	char buffer[UUID_STR_LEN + 1];
> +	int ret;
>=20=20
>  	if (!avb_ops) {
> -		printf("AVB 2.0 is not initialized, run 'avb init' first\n");
> +		printf("AVB is not initialized, please run 'avb init <id>'\n");
>  		return CMD_RET_FAILURE;
>  	}
>=20=20
> @@ -214,14 +230,16 @@ int do_avb_get_uuid(struct cmd_tbl *cmdtp, int flag,
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
> @@ -235,12 +253,13 @@ int do_avb_verify_part(struct cmd_tbl *cmdtp, int f=
lag,
>  	char *cmdline;
>  	char *extra_args;
>  	char *slot_suffix =3D "";
> +	int ret;
>=20=20
>  	bool unlocked =3D false;
>  	int res =3D CMD_RET_FAILURE;
>=20=20
>  	if (!avb_ops) {
> -		printf("AVB 2.0 is not initialized, run 'avb init' first\n");
> +		printf("AVB is not initialized, please run 'avb init <id>'\n");
>  		return CMD_RET_FAILURE;
>  	}
>=20=20
> @@ -253,9 +272,10 @@ int do_avb_verify_part(struct cmd_tbl *cmdtp, int fl=
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
> @@ -302,10 +322,10 @@ int do_avb_verify_part(struct cmd_tbl *cmdtp, int f=
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
> @@ -324,9 +344,10 @@ int do_avb_is_unlocked(struct cmd_tbl *cmdtp, int fl=
ag,
>  		       int argc, char *const argv[])
>  {
>  	bool unlock;
> +	int ret;
>=20=20
>  	if (!avb_ops) {
> -		printf("AVB not initialized, run 'avb init' first\n");
> +		printf("AVB is not initialized, please run 'avb init <id>'\n");
>  		return CMD_RET_FAILURE;
>  	}
>=20=20
> @@ -335,13 +356,14 @@ int do_avb_is_unlocked(struct cmd_tbl *cmdtp, int f=
lag,
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
> @@ -354,9 +376,10 @@ int do_avb_read_pvalue(struct cmd_tbl *cmdtp, int fl=
ag, int argc,
>  	size_t bytes_read;
>  	void *buffer;
>  	char *endp;
> +	int ret;
>=20=20
>  	if (!avb_ops) {
> -		printf("AVB 2.0 is not initialized, run 'avb init' first\n");
> +		printf("AVB is not initialized, please run 'avb init <id>'\n");
>  		return CMD_RET_FAILURE;
>  	}
>=20=20
> @@ -372,15 +395,16 @@ int do_avb_read_pvalue(struct cmd_tbl *cmdtp, int f=
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
> @@ -392,9 +416,10 @@ int do_avb_write_pvalue(struct cmd_tbl *cmdtp, int f=
lag, int argc,
>  {
>  	const char *name;
>  	const char *value;
> +	int ret;
>=20=20
>  	if (!avb_ops) {
> -		printf("AVB 2.0 is not initialized, run 'avb init' first\n");
> +		printf("AVB is not initialized, please run 'avb init <id>'\n");
>  		return CMD_RET_FAILURE;
>  	}
>=20=20
> @@ -404,14 +429,16 @@ int do_avb_write_pvalue(struct cmd_tbl *cmdtp, int =
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
