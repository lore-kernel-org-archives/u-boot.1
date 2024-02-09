Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26936C4828F
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 09:17:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9232B87E53;
	Fri,  9 Feb 2024 10:17:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TFinbt/l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79B1E87E52; Fri,  9 Feb 2024 10:17:38 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62F62876D3
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 10:17:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41059577f26so6713475e9.0
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 01:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707470256; x=1708075056;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FLCHMteTjouk9rFEIaHdg3c/aesVCxKwRz+AItWLGYM=;
 b=TFinbt/lOXDRM6/M6DVZjt7cC4W9k2GHzgzoc2kGELK6WSAVkdhfcBSpD2846ccGr8
 0IKa0o5aUFBA8k/fh0+Q+oNjVCfGUX7JJT/y/pEPjn2lxLK8CftHvKpT7kIrN2hTGncx
 2kHwaEIgM+SsWuAf1FbCgNeaPOZpMfgZnMN+Iz0Pshu9Y6bPJ9bEk5tLZRh89sjQj4XT
 hYtHtu5EIegKt6ezY4I/I8Q7JsGv7nfvLosRnJbPxL0wRJSFJxFfpQo3PCediGpTpxUi
 /j80ZGOaX3tFn+jR02SFiO0ZHj9iaK1iKj+Oo/23r6SQeB4c8HjdhzaW7lwKkPovJWgm
 VKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707470256; x=1708075056;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FLCHMteTjouk9rFEIaHdg3c/aesVCxKwRz+AItWLGYM=;
 b=E45sWzXufLr23x6wPYeAMXkDEOR1m7VAYQU+WlL5UdaGTkcMMzcmHHoCoQB4flAXju
 8tr6ldfAnTImtw08RL73uxYXKeEleCbDm4LKRuSDjX84zvIYSQ+tMhYPcs6C6X3Zn0U4
 Pveq+t0YlIbLEGy/4MO5JHVbUaCUNBP9Bo7kr1m965/HVylcHaqaEkUjy7P7zKy8Xv3l
 DzSJMeYj4DUUqz9j1OQjMbZD/fla4FFhaM8jYNNs6s2eee3h3Sk6WH8z0gZgLje7q9Ox
 vlvGcyA34cey45LpXTIlh2mvxW6bD0r8TPe1mwXmbmLKASJ+D6vphVW0mWsYVF1PDu8b
 ohEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyrhcXsGfNlsVOK0GAmgvdiDtu1UGz0WOYiNPoDeqlsO9dnX0d+hWyjzdZq9sLXp8x60YH9OR/lQFrZKoQsfhnu+3w+g==
X-Gm-Message-State: AOJu0YynU5Mhe9OQP9w8WsiSm/vhrlOUxMq0A8uaJsWeIETyqGjQUTEv
 WYfevsP4ul17cns60NZTaXXjKdHYuzh76GitL0nvid5GRXrA9d2jkrrEdBT61BU=
X-Google-Smtp-Source: AGHT+IHUjYTxnnwYdBPbZojffT2iMSCcy3Xhu+4SLt9fZW+rrqBAhddmrPX+HikCI9v18195Vz3gnQ==
X-Received: by 2002:a05:600c:3c96:b0:410:48dd:c397 with SMTP id
 bg22-20020a05600c3c9600b0041048ddc397mr583045wmb.40.1707470255797; 
 Fri, 09 Feb 2024 01:17:35 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVwosmfHLPVWcSdFjwrSViVfG9uvad2rdlW6o+nvBJZb+8uPIKmfY2ei3rb01WUgd9oC+xzWyibeGMGKDbFzCiRt0prl0eRxGC6eef6fTqvKJiFbBA8D96N
Received: from localhost ([2a01:cb19:95ba:5000:2b24:7f52:e3f6:e4ef])
 by smtp.gmail.com with ESMTPSA id
 fs11-20020a05600c3f8b00b0040ffe1ca25bsm1979674wmb.21.2024.02.09.01.17.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 01:17:35 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@foundries.io>, u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1 6/7] cmd: avb: rework do_avb_verify_part
In-Reply-To: <20240206223153.3060433-7-igor.opaniuk@foundries.io>
References: <20240206223153.3060433-1-igor.opaniuk@foundries.io>
 <20240206223153.3060433-7-igor.opaniuk@foundries.io>
Date: Fri, 09 Feb 2024 10:17:34 +0100
Message-ID: <87zfwa2dzl.fsf@baylibre.com>
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
> Use existing str_avb_slot_error() function for obtaining
> verification fail reason details.
> Take into account device lock state for setting correct
> androidboot.verifiedbootstate kernel cmdline parameter.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Nitpick: the error handling migration could have been part of PATCH 5/7
but it's fine to keep as is.

> ---
>
>  cmd/avb.c | 50 +++++++++++++++++---------------------------------
>  1 file changed, 17 insertions(+), 33 deletions(-)
>
> diff --git a/cmd/avb.c b/cmd/avb.c
> index ae0012c0e79..e5fc202121f 100644
> --- a/cmd/avb.c
> +++ b/cmd/avb.c
> @@ -239,6 +239,7 @@ int do_avb_verify_part(struct cmd_tbl *cmdtp, int fla=
g,
>  	const char * const requested_partitions[] =3D {"boot", NULL};
>  	AvbSlotVerifyResult slot_result;
>  	AvbSlotVerifyData *out_data;
> +	enum avb_boot_state boot_state;
>  	char *cmdline;
>  	char *extra_args;
>  	char *slot_suffix =3D "";
> @@ -273,18 +274,23 @@ int do_avb_verify_part(struct cmd_tbl *cmdtp, int f=
lag,
>  				AVB_HASHTREE_ERROR_MODE_RESTART_AND_INVALIDATE,
>  				&out_data);
>=20=20
> -	switch (slot_result) {
> -	case AVB_SLOT_VERIFY_RESULT_OK:
> -		/* Until we don't have support of changing unlock states, we
> -		 * assume that we are by default in locked state.
> -		 * So in this case we can boot only when verification is
> -		 * successful; we also supply in cmdline GREEN boot state
> -		 */
> +	/*
> +	 * LOCKED devices with custom root of trust setup is not supported (YEL=
LOW)
> +	 */
> +	if (slot_result =3D=3D AVB_SLOT_VERIFY_RESULT_OK) {
>  		printf("Verification passed successfully\n");
>=20=20
> -		/* export additional bootargs to AVB_BOOTARGS env var */
> +		/*
> +		 * ORANGE state indicates that device may be freely modified.
> +		 * Device integrity is left to the user to verify out-of-band.
> +		 */
> +		if (unlocked)
> +			boot_state =3D AVB_ORANGE;
> +		else
> +			boot_state =3D AVB_GREEN;
>=20=20
> -		extra_args =3D avb_set_state(avb_ops, AVB_GREEN);
> +		/* export boot state to AVB_BOOTARGS env var */
> +		extra_args =3D avb_set_state(avb_ops, boot_state);
>  		if (extra_args)
>  			cmdline =3D append_cmd_line(out_data->cmdline,
>  						  extra_args);
> @@ -294,30 +300,8 @@ int do_avb_verify_part(struct cmd_tbl *cmdtp, int fl=
ag,
>  		env_set(AVB_BOOTARGS, cmdline);
>=20=20
>  		res =3D CMD_RET_SUCCESS;
> -		break;
> -	case AVB_SLOT_VERIFY_RESULT_ERROR_VERIFICATION:
> -		printf("Verification failed\n");
> -		break;
> -	case AVB_SLOT_VERIFY_RESULT_ERROR_IO:
> -		printf("I/O error occurred during verification\n");
> -		break;
> -	case AVB_SLOT_VERIFY_RESULT_ERROR_OOM:
> -		printf("OOM error occurred during verification\n");
> -		break;
> -	case AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_METADATA:
> -		printf("Corrupted dm-verity metadata detected\n");
> -		break;
> -	case AVB_SLOT_VERIFY_RESULT_ERROR_UNSUPPORTED_VERSION:
> -		printf("Unsupported version of avbtool was used\n");
> -		break;
> -	case AVB_SLOT_VERIFY_RESULT_ERROR_ROLLBACK_INDEX:
> -		printf("Rollback index check failed\n");
> -		break;
> -	case AVB_SLOT_VERIFY_RESULT_ERROR_PUBLIC_KEY_REJECTED:
> -		printf("Public key was rejected\n");
> -		break;
> -	default:
> -		printf("Unknown error occurred\n");
> +	} else {
> +		printf("Verification failed, reason: %s\n", str_avb_slot_error(slot_re=
sult));
>  	}
>=20=20
>  	if (out_data)
> --=20
> 2.34.1
