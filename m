Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C7EC4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 14:03:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D28A87CED;
	Thu,  8 Feb 2024 15:03:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="B272HmhE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5398C87E38; Thu,  8 Feb 2024 15:03:20 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AFED878E9
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 15:03:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4105006bf11so1049795e9.3
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 06:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707400997; x=1708005797;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VjDP3kPuaUXmnUDKNGIm9MJdUlTCoFv/cMYX3QOQib0=;
 b=B272HmhEDoZrSuL6AwhQ/zkPoEShH28AutirDdodRktoEaSmdPSqUkYXWhoEyep7n3
 CBuCxqIqFeKO1fJdW1qyVx+iJt1QVirMwd4H5QVwYRn56FTFAeqfycE002sU167/7P3H
 LQ5W1LTXjGd3YihV67GE0nuvbkRV0wopx8tlPNKtgWEDhtIiaBrvi/v5j2ZNHXv0aPgo
 IsMK0MO11sTYY3HtGYopgpAvY33cL9RfNh1/yTT9rN8u0oeeiQudCzJ1KaowOGrzZr7R
 koY0rDa6oR10SxFFdYE/bXlr6Nh5hO5UHO8TIgWBw3WAe0FCzJhEbg2bluMjww2KZ7f6
 2gsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707400997; x=1708005797;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VjDP3kPuaUXmnUDKNGIm9MJdUlTCoFv/cMYX3QOQib0=;
 b=uVfmTSfUM6wBCd79RFRB6F8cfs2VN1pNkUekfJ3co4LfhKmLxIoi3EAJ2B2adgUiEw
 dFieAhPL8+mqrdMPC7PYLxkdehOIvm3+iHUjATdu08YVKh2Fg3t+WS/0lr+Ck4frWWOd
 5ggHynXfBUZSRdy/9VBG6k5xR6NqWdJ8yLoM9TvNaFpfP8NbtnSzlYJjQ4XFM0DgnSt2
 mKLMHqKqtbTHqz584zFsuu6Vfbpcn2qyL7Tt+W8JMj8OABlb4gsVE1NZpB5OP7m/D5v5
 byWGCzsixG7xMmNkNllQgb1G7ALENVVsK54zEAY7MFXGjrAjnfEaK1i4BzZ2BZEMyD0y
 IR3Q==
X-Gm-Message-State: AOJu0YyJSD+tCZktMjHdRsLoJ+i9Vf9t02//wukT4658s3qXaPxJccFB
 spzVKWuvuC/UgiaSWPUzFpPeeVsWyr6OEwMfb5npf8gtJmecu38G2chMAXKfX4Y=
X-Google-Smtp-Source: AGHT+IGWCTIZbrjukkO1UXuodrlFvmlrpcmcynUsX7ipHVclXaH/UDWodtKGejBF9gqX1D3AR46qlA==
X-Received: by 2002:a05:600c:5029:b0:410:41e5:3a3d with SMTP id
 n41-20020a05600c502900b0041041e53a3dmr1244532wmr.5.1707400996819; 
 Thu, 08 Feb 2024 06:03:16 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWNmFMqu2dHSC+HaG1nv0Z5zRnym//Ear54sw5CsO2z+x+tuPctSOcHiAphgGaY1ZeSMviw7QO1vHoZh3ekt2W7vStbWhmZyEiHvX/J5SWqpETrlgUP4MCFnFOfigP5CZJxaD0PqArK9FGm/PolsW9Oe6xWDGaAiweIxvU22/Y3lz2xpnODrN0vPvlj70rP
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 l9-20020a05600c4f0900b0041004826669sm1709729wmq.42.2024.02.08.06.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 06:03:16 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@foundries.io>, u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, Ivan Khoronzhuk
 <ivan.khoronzhuk@gmail.com>, Jens Wiklander <jens.wiklander@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1 5/7] common: avb_verify: add
 str_avb_io_error/str_avb_slot_error
In-Reply-To: <20240206223153.3060433-6-igor.opaniuk@foundries.io>
References: <20240206223153.3060433-1-igor.opaniuk@foundries.io>
 <20240206223153.3060433-6-igor.opaniuk@foundries.io>
Date: Thu, 08 Feb 2024 15:03:15 +0100
Message-ID: <8734u3jboc.fsf@baylibre.com>
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
> Introduce str_avb_io_error() and str_avb_slot_error() functions,
> that provide a pointer to AVB runtime error message.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
>  common/avb_verify.c  | 49 ++++++++++++++++++++++++++++++++++++++++++++
>  include/avb_verify.h |  3 ++-
>  2 files changed, 51 insertions(+), 1 deletion(-)
>
> diff --git a/common/avb_verify.c b/common/avb_verify.c
> index ed58239cf8a..cff9117d92f 100644
> --- a/common/avb_verify.c
> +++ b/common/avb_verify.c
> @@ -119,6 +119,55 @@ static const unsigned char avb_root_pub[1032] =3D {
>  	0xd8, 0x7e,
>  };
>=20=20
> +const char *str_avb_io_error(AvbIOResult res)
> +{
> +	switch (res) {
> +	case AVB_IO_RESULT_OK:
> +		return "Requested operation was successful";
> +	case AVB_IO_RESULT_ERROR_IO:
> +		return "Underlying hardware encountered an I/O error";
> +	case AVB_IO_RESULT_ERROR_OOM:
> +		return "Unable to allocate memory";
> +	case AVB_IO_RESULT_ERROR_NO_SUCH_PARTITION:
> +		return "Requested partition does not exist";
> +	case AVB_IO_RESULT_ERROR_RANGE_OUTSIDE_PARTITION:
> +		return "Bytes requested is outside the range of partition";
> +	case AVB_IO_RESULT_ERROR_NO_SUCH_VALUE:
> +		return "Named persistent value does not exist";
> +	case AVB_IO_RESULT_ERROR_INVALID_VALUE_SIZE:
> +		return "Named persistent value size is not supported";
> +	case AVB_IO_RESULT_ERROR_INSUFFICIENT_SPACE:
> +		return "Buffer is too small for the requested operation";
> +	default:
> +		return "Unknown AVB error";
> +	}
> +}
> +
> +const char *str_avb_slot_error(AvbSlotVerifyResult res)
> +{
> +	switch (res) {
> +	case AVB_SLOT_VERIFY_RESULT_OK:
> +		return "Verification passed successfully";
> +	case AVB_SLOT_VERIFY_RESULT_ERROR_OOM:
> +		return "Allocation of memory failed";
> +	case AVB_SLOT_VERIFY_RESULT_ERROR_IO:
> +		return "I/O error occurred while trying to load data";
> +	case AVB_SLOT_VERIFY_RESULT_ERROR_VERIFICATION:
> +		return "Digest didn't match or signature checks failed";
> +	case AVB_SLOT_VERIFY_RESULT_ERROR_ROLLBACK_INDEX:
> +		return "Rollback index is less than its stored value";
> +	case AVB_SLOT_VERIFY_RESULT_ERROR_PUBLIC_KEY_REJECTED:
> +		return "Public keys are not accepted";
> +	case AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_METADATA:
> +		return "Metadata is invalid or inconsistent";
> +	case AVB_SLOT_VERIFY_RESULT_ERROR_UNSUPPORTED_VERSION:
> +		return "Metadata requires a newer version of libavb";
> +	case AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_ARGUMENT:
> +		return "Invalid arguments are used";
> +	default:
> +		return "Unknown AVB slot verification error";
> +	}
> +}
>  /**
>   * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>   * Boot states support (GREEN, YELLOW, ORANGE, RED) and dm_verity
> diff --git a/include/avb_verify.h b/include/avb_verify.h
> index 2fb850044d9..5d998b5a302 100644
> --- a/include/avb_verify.h
> +++ b/include/avb_verify.h
> @@ -52,7 +52,8 @@ char *avb_set_enforce_verity(const char *cmdline);
>  char *avb_set_ignore_corruption(const char *cmdline);
>=20=20
>  char *append_cmd_line(char *cmdline_orig, char *cmdline_new);
> -
> +const char *str_avb_io_error(AvbIOResult res);
> +const char *str_avb_slot_error(AvbSlotVerifyResult res);
>  /**
>   * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>   * I/O helper inline functions
> --=20
> 2.34.1
