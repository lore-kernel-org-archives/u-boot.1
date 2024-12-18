Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCEDE77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 12:29:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EEEA8021D;
	Wed, 18 Dec 2024 13:29:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="o2PAsgEd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84C0980243; Wed, 18 Dec 2024 13:28:57 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E92BF80214
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 13:28:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-432d86a3085so42863895e9.2
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 04:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734524934; x=1735129734;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qzF+lK4NkwBTgdY9ZJ766ht16NguQCGs75bYrUCirIE=;
 b=o2PAsgEduzoC0YfF+ONtGT8Oz3g+0M11+L8uHBaySI8LagYngypEdweLBvh7eCdluk
 klEmYLKsQWBdqebI+1LiFS/Dv4FzEt5EWkppGRHCUDvFuE9W09H3fI241SusqGUbokqU
 q7KhWdH5J3ads3bifJ4con1YCnmUya9gKWMyn9BAZMKyb9caOev9Aivr8AI8UanhfD8q
 PHLlPUdl0ID5Y9ZYpFHkmr/SzyYV2EokakHWWIeCa3RBe9c9Fa+h5ROzjsiByH8+NioM
 JarGQpLtn+VbRQisyJJuT+T1I8XIyhmoq/4ThnO6h+G4RrJcMx/Url3DZOjQYSvxByns
 foww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734524934; x=1735129734;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qzF+lK4NkwBTgdY9ZJ766ht16NguQCGs75bYrUCirIE=;
 b=H7qgw9VlI8PLbjIVdL/f3xPybdTfttOL7CdQ9aZKJKCUZqheQmFjjY9/kn5i1G0sKW
 wgadFFldhMJT+B7wqoS+QiV3/DqeN7AzEJ4sSYhtxkD/jjJq5J/GRDCLPzPN+zqHhBEw
 lqk670kPC69SNC+jmdBnU7QsPbTo6O7oBYORhtJvfNWaXxCQRlxMlHD3VkCTq5CwPVhl
 Xl8KZU0AqgIxySgZ78q3STTs/XTg7qSSIviPeBA9wlUY2M+4R8a3/1NK7jGVXiz8Of3K
 HftldCFd95QiqRFjb1jhS6O9JlQ2OzqZB3A8BmHa6cqrmWRKiJ5zNmXwZerOeeRLtvsQ
 vLRA==
X-Gm-Message-State: AOJu0Yxd24FdNCX5js5tTak7tMX2+L45ZTqW87foTsJ6LwVezjBzpKjx
 3VX3V8P5OjnSlsP41RI5VLOBLcXEFGrVsLlFvrxkzoGcYcKYYhrLHs6UIWdLVJo=
X-Gm-Gg: ASbGncvNkxX8lOpCP+nOIpuQjFeO92LqBkFC0agAVCLe2i92uY0/HQ+f4dowiLBkgGw
 JKMs7CMVgO1bSvF7zyrfYjWC+gDgeaDVRPe5+bX9PTfrVlmzHcmMXNwnTpxdZzNeX2cs7WDoPls
 8DrjVQNYD6xNudIUi/Pbh3B1cjjrS7E0KN7eSJrz0UsgN+TxVl2edXc198tm9YDFwrSq52mGinp
 FYQYWtPnwo1E9pwxd08QKhrqQV5CAsKcv5BQffUxG6ijLeS53OdbAZm7ivjqCrTTw==
X-Google-Smtp-Source: AGHT+IFCQcz3zuIlZHiVr9h2vyZzCAW7GgEYJ4U3EOYTqX7WcRH7Swegl6ilc1lZWxo6PwLu/mVFMg==
X-Received: by 2002:a05:600c:4691:b0:431:54d9:da57 with SMTP id
 5b1f17b1804b1-4365540c612mr25090305e9.30.1734524934395; 
 Wed, 18 Dec 2024 04:28:54 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8012029sm13872441f8f.12.2024.12.18.04.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 04:28:54 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Jonathan Humphreys <j-humphreys@ti.com>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Caleb Connolly <caleb.connolly@linaro.org>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 s-vadapalli@ti.com
Cc: u-boot@lists.denx.de, Jonathan Humphreys <j-humphreys@ti.com>
Subject: Re: [PATCH] dfu: Prevent set_dfu_alt_info() from overwriting a
 previous value
In-Reply-To: <20241217204835.3312765-1-j-humphreys@ti.com>
References: <20241217204835.3312765-1-j-humphreys@ti.com>
Date: Wed, 18 Dec 2024 13:28:53 +0100
Message-ID: <87ed25w4xm.fsf@baylibre.com>
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

Hi Jonathan,

Thank you for the patch.

On mar., d=C3=A9c. 17, 2024 at 14:48, Jonathan Humphreys <j-humphreys@ti.co=
m> wrote:

> If CONFIG_SET_DFU_ALT_INFO is enabled, the dfu_alt_info environment
> variable is dynamically set when initializing the DFU entities, which is
> done as part of normal flow of a DFU operation.
>
> The USB DFU boot support will set it's own specific value for dfu_alt_info
> before performing the DFU operation. This means that if
> CONFIG_SET_DFU_ALT_INFO is enabled, the dfu_alt_info environment variable
> that the USB DFU boot path had set is overwritten, causing USB DFU boot to
> fail.
>
> Likewise, if the user sets their own value for dfu_alt_info, say at the
> U-Boot prompt, it get's overwritten if CONFIG_SET_DFU_ALT_INFO is enabled.
>
> This patch will first check that dfu_alt_info isn't already set before
> calling set_dfu_alt_info(), when CONFIG_SET_DFU_ALT_INFO is enabled.

To me, this is a policy change: before we could override the environment
via set_dfu_alt_info(). Now we cannot anymore (if "dfu_alt_info" is already
set in the environment).

Also, it seems that this change goes against the uefi doc which states:

"""
A string is defined which is to be used for populating the
dfu_alt_info variable. This string is used by the function
set_dfu_alt_info. Instead of taking the variable from the environment,
the capsule update feature requires that the variable be set through
the function, since that is more robust. Allowing the user to change
the location of the firmware updates is not a very secure
practice. Getting this information from the firmware itself is more
secure, assuming the firmware has been verified by a previous stage
boot loader.
"""

See: https://docs.u-boot.org/en/latest/develop/uefi/uefi.html#performing-th=
e-update

Moreover, looking at various boards that implement
set_dfu_alt_info(), we can see different behaviours:

Boards examples that won't override "dfu_alt_info" via
set_dfu_alt_info() if "dfu_alt_info" is already set via environment

* board/xilinx/zynq/board.c
* board/emulation/common/qemu_dfu.c

Boards examplesthat will always override the "dfu_alt_info" via
set_dfu_alt_info():

* board/libre-computer/aml-a311d-cc/aml-a311d-cc.c
* board/ti/am62px/evm.c

Since set_dfu_alt_info() is a board specific callback, why can't this
logic be implemented for boards that want this behaviour change?

Regards,

Mattijs

>
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>  drivers/dfu/dfu.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dfu/dfu.c b/drivers/dfu/dfu.c
> index 756569217bb..ab8abae1d89 100644
> --- a/drivers/dfu/dfu.c
> +++ b/drivers/dfu/dfu.c
> @@ -169,10 +169,13 @@ int dfu_init_env_entities(char *interface, char *de=
vstr)
>  	dfu_reinit_needed =3D false;
>  	dfu_alt_info_changed =3D false;
>=20=20
> +	str_env =3D env_get("dfu_alt_info");
>  #ifdef CONFIG_SET_DFU_ALT_INFO
> -	set_dfu_alt_info(interface, devstr);
> +	if (!str_env) {
> +		set_dfu_alt_info(interface, devstr);
> +		str_env =3D env_get("dfu_alt_info");
> +	}
>  #endif
> -	str_env =3D env_get("dfu_alt_info");
>  	if (!str_env) {
>  		pr_err("\"dfu_alt_info\" env variable not defined!\n");
>  		return -EINVAL;
> --=20
> 2.34.1
