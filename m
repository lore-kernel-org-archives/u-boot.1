Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4355EDF15E
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 12:56:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0675A83AA9;
	Fri, 13 Feb 2026 13:56:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UY5XwETM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D71E83AAB; Fri, 13 Feb 2026 13:56:53 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17F3E83015
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 13:56:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48372efa020so4754725e9.2
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 04:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770987410; x=1771592210; darn=lists.denx.de;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E2c5GCJY/L4LF5HjG4ZdtzItmbzH8457/hio2m8Hq/o=;
 b=UY5XwETMV3Qy9ajU37r2/0HHeZi/1w+99VtIdDcGCkyRSzBywg1pKAj/yRBAIorTPt
 jqRoXd4TXAM5MVGFn+rJZRQHheDawftuRl0NZQvM5/qsu+n40Bkx1YOVQxFfHHFCs8pt
 EEz8I1mA+Ic5Dl2Y/zV7IlLev1k5hNZxLLa2XvG5zTO/uU78smhYHg/AmCC3+qK/L7Tr
 7XNHKPshGfuL2K4rDY1VlVKmbsoSuqiwC26Hkj+AIeQJY+qZ6l5QZ0F1JU5Cr1H1FQ6C
 bKx+qA5w5c3E0GVGoNmD1mL51zzVA7afWhtC/EtfWvhK2qYnOmrQn4EVBHYVpvjZUBzk
 DGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770987410; x=1771592210;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E2c5GCJY/L4LF5HjG4ZdtzItmbzH8457/hio2m8Hq/o=;
 b=gqiMnAK11NKMTAPBCcekNarruwxd20HxoUWRk9+OOcUueiR6zRd9nYW036VB9tBr9Z
 vgkXQVE3XB8CxeTafqw2u+CQHNSgiT4A7ism938TjXCXQZ2bYz8ULO658HLzUz2kSRBU
 cawZI/gs8KNkNLYU2WQVBYwxmLad/Hm9mmMZDsBvWEJLsCOfKuUscWJoS4YFOfNA6K0Q
 eh4SIFWjtNcseMNN8Hywf2Mnw7m99A5WnPi30oSwaQpSwrVODL6UePqRUZDuhrdR+GmE
 v+MOzZ+uLy7b5hodQp4ukFeg93fP/GBbFSW9mwQK/NyoerS4dqnwJ6BmwJpSaEBwXDhH
 wStA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbbzlT3IUWY/pQXnFPhEYUvMFToCzHP4ZMB048PHna0eeCjpv/uF7rywvay9qHVHHLg16Oyyo=@lists.denx.de
X-Gm-Message-State: AOJu0YzLJHcfk0RJYTEURWOk4DqO5bjOoEiwtm7XEwUOLPBzFA8fTNvn
 Dznxk6OEtdTXbTyEOpIK1GH/nLQmXARUGFi9WQy1bRk+QxaAAFu23UTkgC5A06O0tW0=
X-Gm-Gg: AZuq6aIqW2Pq4hD4W+YYUUXwgB5c8HNPHVyTeaGvFZbrMqKah01c8Gb1vvKRrxVzJie
 RWj607ORmkVk/psa2LfJCuF3HeFmPKS7Gf4EOOhy4LKaUvV+i32mie+cn/7wpw81B5+8UMLsahG
 2OR9XRWjjxExWEvq41il0TPCWlGperjdumVmTV/kfNvmmE9Wlpk//n6wpDQtAy8UOKHLfij9irn
 /hA5fC5dyu9KtGUGaTNhyx4GE3pvG7Z5bcJTdrFIqKQhd2rPeKIYkhBNo0XqCtNNOpjETJ1j0qy
 84s9eFAr8tFanb/u2lDOc617Cn+Yi9V6vxHOdnPBHwBofU+LZpcdhhGEL5u4OvPxg9vD4zE4EYu
 LOxIMi0TrnpINRuBznqC0hRAv8IvChVNwzIuOMAo1VWu/tbUILyIdyPve4xQJ5PK7TYhzisc/CH
 rL8rlFkn/rJGIoEOy4v6X9BrpMkzSBqPSGBSnaF/YGBPgW0UjjZCz3aKmCOS5eyWod/w5WXm4jR
 oDSSRaFsRFo77gDa7Ro0N5VrmDGt/1YpRRgFYjx7i9YZc5X+rF6RDiIFFPmv0wTHGaSe3LxYgB4
 bJUkUWVrfYPojM7mLYDAW1vrpoes4vn1XFSR4JUlqg/ZOIagUedQZ2xtsHF7j3qpHQ+N2EAUaLG
 +BJCH4xPrQiMS/jJUeMAGn+L3F2gdftsW6Ov1fdOX+UG4mva/pwM8z4cfMnxbKxXt/o+HSiiLpo
 mkI3CgIKbBzQhDFQaBjJLtc767eWQfRRPTCNvUiwx/Fg4C0YOaAEx7snBobmBnQa0wFpM=
X-Received: by 2002:a05:600c:4fc8:b0:47a:814c:ee95 with SMTP id
 5b1f17b1804b1-48373a234fdmr29900015e9.12.1770987410494; 
 Fri, 13 Feb 2026 04:56:50 -0800 (PST)
Received: from localhost ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a6a5e5sm5449572f8f.9.2026.02.13.04.56.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 04:56:49 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Feb 2026 14:56:48 +0200
Message-Id: <DGDUN3ZI09SP.36P8F54DEPVUQ@linaro.org>
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "Wojciech Dubowik" <Wojciech.Dubowik@mt.com>,
 <simon.glass@canonical.com>, <u-boot@lists.denx.de>
Cc: <trini@konsulko.com>, <quentin.schulz@cherry.de>
Subject: Re: [PATCH v5 1/6] tools: mkeficapsule: Add support for pkcs11
X-Mailer: aerc 0.21.0
References: <20260128080515.1275941-1-Wojciech.Dubowik@mt.com>
 <20260128080515.1275941-2-Wojciech.Dubowik@mt.com>
In-Reply-To: <20260128080515.1275941-2-Wojciech.Dubowik@mt.com>
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

Hi Wojciech,

On Wed Jan 28, 2026 at 10:05 AM EET, Wojciech Dubowik wrote:
> With pkcs11 support it's now possible to specify keys
> with URI format. To use this feature the filename must
> begin "pkcs11:.." and have valid URI pointing to certificate
> and private key in HSM.
>
> The environment variable PKCS11_MODULE_PATH must point to the
> right pkcs11 provider i.e. with softhsm:
> export PKCS11_MODULE_PATH=3D<path>/libsofthsm2.so
>
>

[...]

> -	ret =3D read_bin_file(ctx->cert_file, &cert.data, &file_size);
> -	if (ret < 0)
> -		return -1;
> -	if (file_size > UINT_MAX)
> -		return -1;
> -	cert.size =3D file_size;
> +	if (!strncmp(ctx->cert_file, "pkcs11:", 7))

Can we do strlen() instead of 7 ?

> +		pkcs11_cert =3D true;
>
> -	ret =3D read_bin_file(ctx->key_file, &key.data, &file_size);
> -	if (ret < 0)
> -		return -1;
> -	if (file_size > UINT_MAX)
> -		return -1;
> -	key.size =3D file_size;
> +	if (!strncmp(ctx->key_file, "pkcs11:", 7))

Same

> +		pkcs11_key =3D true;
> +
> +	if (pkcs11_cert || pkcs11_key) {

Don't you need both the cert & key to sign the capsule?
I'd simplify the logic here. Instead of having both a pkcs_key and a pkcs_c=
ert,
replace the variables with is_pcks and have that set to true if both the ke=
y
and cert have been found.

Then the if/else cases later will become a bit easier to read since you'll =
have
to load the private key & crt on a single if/else cases depending on is_pkc=
s.

> +		lib =3D getenv("PKCS11_MODULE_PATH");
> +		if (!lib) {

[...]

Thanks
/Ilias
