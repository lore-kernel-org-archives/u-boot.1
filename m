Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6FD112584E
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 16:15:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15D038407E;
	Wed, 11 Mar 2026 17:15:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x9zIdI0z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 110D7840A6; Wed, 11 Mar 2026 17:15:23 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C9C38404A
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 17:15:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-798617c0ad5so84530577b3.1
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 09:15:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773245719; cv=none;
 d=google.com; s=arc-20240605;
 b=Gv7ZllRn65W4fXL07rUHrQZ8Yz/4rAG3RsO5V3XqNGnWPV2/BB9beeoxIKb3ukhc+H
 nSViCzcZZY23D8EUAGIHOStPR6l9DFNAQhQ/oATUmxtWwTiqfEwdPG6haIcutc/6x/Jk
 Dae0wQYhbW8Qi6dQrO+yEGuXeXQ3SNiVWFNFRVOCC6dQVpfyIioUYnXNZOCqrud2r8fs
 pQTj2BuN2I2UIkdR2yR3/7dUCvdXOfJxE2taPSRe39WlSffGEvd3tOiJKGRyRJgnNrHk
 HPq4s1p8iRWfq2S3vnS7mLNppGTlH6ERvwIa8b3gLEk0/pFgQikN7FsiNec3K4L7PXRV
 VFeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Rgma7lg82dbTA+llWlXk75nlwshu27uU16U3ca2fIRc=;
 fh=qVPXZENsT8HTjc1yhpZmugGERdHloY1MZQ2O3ZL3iu8=;
 b=M9o4myL0IIuy3/yFz5v+SIoVzK6TxzmtxX1EO7xWXZHfShxxwAuYIeSrAfMycjbs2k
 tftoCi4C1UmCXzefDD20Cmsnw4JdQCESQL1LlX25n5DxwascaBo+lhFyt6dYjaERpqhF
 66OrVsnMeU3cBnVJukLlkBWiRim4DI8xycMXx4kJr+czVrDOPzAUm84WYQsWPKs8wdGl
 52JSEf0a5B9JXR4VTPbslp5GUd6I1F9f/Hclm2iAAu0RRx6f7MDpwXySgvS8ciZv4oTV
 E8cUOec2PiWzvg4cuk8b5b8yS+t1Lwh13XPNVNluWv/7Gowj/NuhzPAPQynmVZVLuyfo
 1Eng==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773245719; x=1773850519; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rgma7lg82dbTA+llWlXk75nlwshu27uU16U3ca2fIRc=;
 b=x9zIdI0zlUCPve+8UxNVbCVgG1HbOglkQOIK6Ctcul1LntnoSyCquWxtjkMI9cuGRP
 u/DqW9Zdvq+7+gdXFyjVgxeVKp5y7/+qhjYuwjsB5+wEPqBR2qC19yxNqznjrQO6/mrD
 1CJtvm5mNRtTDC31iog/vt2r6a6CD/0fDps25uPtlrAewGJdCYpg/55JoLGdkQqOvmM6
 rTJUSzPiC6OL6ABs4qoZZP8l0ComE0kneimOBZOvnKRJ7lWbPSiTWezr9PCvGCTI1zEA
 oFC88ZVA4hu/WWw9oEMvVZj4yNi1YNJWaVnn8UVrlU3sftp59k/yRN58DISeErregCVr
 W8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773245719; x=1773850519;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Rgma7lg82dbTA+llWlXk75nlwshu27uU16U3ca2fIRc=;
 b=RhHHmQFPnDnUnB4puh14Z/1m2PpuduZ/rgxfwWVUOD0y8RcO2NmmhtXMVW6gVXGetn
 NHe5rWoCkZEVyyGzYDxiZxSsHNWxWetBPoyc8yYA78JD+rPBDlH7v9VCYoiv6TabyAJL
 5iOqKTw7lCUMJ8xw2UacNEfSwAD5oQwK0ICpay5EJQbiA89LK2JME5Z35t83JiB7Fg9B
 4h8++qkwCVy6YD9UZNFutnoZwhSA82vasKZ8TH0TMsv6oiRSLzRX46bm/Cx3Njb5zPmN
 wp57h/R3MtLPiHwI8uF7gzvntShwBGuxziBnyY26s7H3GyWjG8wBj1lrz52OmXjJruuy
 9e+A==
X-Gm-Message-State: AOJu0Yzjlr1ulvg00vQrOwkc0x7jFCD/jW37c2wHyreerJZ5dPFHd3ie
 zT+NOlJ2yP8FnOqGcLkK21DAI6fa515rg7/Xc6pndge8TvwgKYs0b3Aj9v8PjuPuoT0qRx4CThW
 Sa4n5q0JMKP382pzG7jCpY0OnJOiS0plMdlgYnA3KQA==
X-Gm-Gg: ATEYQzydk/7SCA4xa2rMX1InjZ6omCPQ7pgEn+qjHwk+g8xFHby+tXeAO01JwBgH02C
 tecHhfYaCQm2ogY3ap9jeijuLHV1WwD4Z6B1PjxU+gRPlik0SGZfEtc7iTKHVbSn/uLnI1CmuG7
 wt4OjiDKY65J2MClu/L7I9sIlS2M1AjyDcPC7/cb1kcfXL7soyAXz2CJebMXXBQVIKC6PQRHW5s
 Hr7nNDIq0AdoRqDTTNS7X+W8ho13RitR56DsU5UeFoE6UsrOPsFcQ66LuOyKS4dnH89AYvci8EV
 17IuJ1ncs4JqKIeNYtFaWxS07W1dQdNX2Zk1VFp7RRkHRgYaItj6Fcj1mm3scCquxZnR2GEHZ5N
 461CFiAZ2rdBaG/de/s07/BYCo0bSFTK6pQfVqScXK/6xwVsk7NHrgJ4XgPs8rRL3P7+pdumCcW
 GQQ+VJawJo0a0buk8yAmbxxIT/o3SOWSh1SDN+m372MRG5OjjK95nM/drdNuJ5Cd3xPJQVOQ02z
 pEr24A1ZqbCuNTUMlUBKZNeQ9uTNFnKbtkBISip7Enu1Xr8AfOfum0VCBf33P7lP13Ngo/FwR9l
 HNJb+vHxQrxalo4GvB30GkTIu3IZFgYOVOEKNN8LQQ==
X-Received: by 2002:a05:690c:7409:b0:798:50ee:5b02 with SMTP id
 00721157ae682-79917f851ffmr28605127b3.42.1773245719056; Wed, 11 Mar 2026
 09:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260305161349.2317130-1-vincent.stehle@arm.com>
 <20260309163638.2340548-1-vincent.stehle@arm.com>
In-Reply-To: <20260309163638.2340548-1-vincent.stehle@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Mar 2026 18:14:42 +0200
X-Gm-Features: AaiRm518NBYiDPdCx8PMuflFxwnfcUYXhHAEQa-aXZtePeEV4EGtSTTeIrG37g4
Message-ID: <CAC_iWjLaUyZ1bitkfEvyb565eTABU1BLH4gQ8KG21btMqGgBtg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] lib: uuid: add EBBR 2.1 conformance profile GUID
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 9 Mar 2026 at 18:36, Vincent Stehl=C3=A9 <vincent.stehle@arm.com> w=
rote:
>
> Add support for printing the EFI_CONFORMANCE_PROFILE_EBBR_2_1_GUID as hum=
an
> readable text.
>
> This is compiled in only when CONFIG_CMD_EFIDEBUG and CONFIG_EFI_EPCT are
> set.
>
> Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> Changes in v2:
> - Gate with CONFIG_EFI_ECPT (suggested by Heinrich)
>
>  lib/uuid.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/lib/uuid.c b/lib/uuid.c
> index 0a166320e07..3a666d0430d 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -254,6 +254,12 @@ static const struct {
>                 NULL, "EFI Conformance Profiles Table",
>                 EFI_CONFORMANCE_PROFILES_TABLE_GUID,
>         },
> +#if CONFIG_IS_ENABLED(EFI_ECPT)
> +       {
> +               NULL, "EFI EBBR 2.1 Conformance Profile",
> +               EFI_CONFORMANCE_PROFILE_EBBR_2_1_GUID,
> +       },
> +#endif
>  #ifdef CONFIG_EFI_RISCV_BOOT_PROTOCOL
>         {
>                 NULL, "RISC-V Boot",
> --
> 2.53.0
>
