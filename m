Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851B6F3ED4D
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 13:25:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 061BC841D6;
	Sat, 11 Apr 2026 15:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jSSKvpom";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 501928416F; Sat, 11 Apr 2026 15:14:54 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CFCB84118
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 15:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b9c755b2cdeso462383566b.2
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 06:14:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775913291; cv=none;
 d=google.com; s=arc-20240605;
 b=eP1AX4Y27S3fLj/og4crMqN5v5vnitcQwOVymY39tzYy0vWpfiWJAKcvUuQgQM4UeN
 hG0GwYNMA5o84gMZol1yz5Hj4UCaIqZ9JBhhqsIrJIQEnLKDvRefNT2Fmfx/09S64jjB
 MdIiOs+odrOIdnscQPQ+kG+dVTDZdCqea3iYLZT3Tzi5KH//B6JwZwFOHV24V9f8mNsN
 ZidUcD8+Lcs/Y+oOS+vz7wzRz3gc+sDqCeeF2ws7zb6gLxZBcY33ZbnsDQQjqhEXs1Sn
 d4Plvv9OF/g29KY2Rsqkk2Puetw9UrIDy9C197UUdjKkXLJnAdcXfwtQT6hI3YmIDLdv
 tKkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3/HSU6K4bQXug9q/pEX3LhiUf2chMFDQzJsEiF3URG8=;
 fh=LyOMVuuR1pFG3udfQP+1h/tPU885BX42i0U8b8tcbPw=;
 b=lRt/szwVdHCzkMmqdBgPV3CgRSW0+xPGyKDcX7Up0F4Ld72i8RhcDZduov6H4He2R6
 Q1dzd/IVbKDk4HYXqXZz9MjjsDBD/XsVunRqieWgEYxc901RwsLzr8iBggANBm4+AE3+
 EVRp5yXc86WXygF6Rdv7YwIEGFOQhBi64nI+ov6C9xWO9KhwR7Fqd6S6LsoV30bJ6w4D
 jdpVwtyHZmSxpA7NmBv0W9Ea2cNHU+uoWEerJ3wttGdwx5eNJwnTG/br4QXqMiOBcy0H
 +x+G4POQFoygJlOzBh+jkFCRycnJzCLSek8tJK3rLHb1u5M2VGbWsObbVzDwjhd2BNXJ
 SsMw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775913291; x=1776518091; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3/HSU6K4bQXug9q/pEX3LhiUf2chMFDQzJsEiF3URG8=;
 b=jSSKvpom8YIZVdXrBLJ4jZVUYSlLBaDWJu7kv50YxAAU3MhRsJhyoYIwqnSr3ot9jp
 6Nqz5JNC6D90uR4vPiLp6hjq25yS4BnxAfbZ5XwmBE7xYZ2lg9m5wWN0krttxoGGIN6Z
 Nmiqg/Gt20LHvFfiwGc1v0Utw9TaEpSep6WFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775913291; x=1776518091;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3/HSU6K4bQXug9q/pEX3LhiUf2chMFDQzJsEiF3URG8=;
 b=IvPfOCOM4LXDOcrp9o1gKC6QgEM30LdYS1GvSBLM/N7YsmZtvGSjZDhmluIlyWkpOo
 9WQgpltDFL/O9KGjhALIhDZZgRjDhq3OG3R1eucx6HooUMLPftudec1SS6CGcAtIzkRL
 XlqRV/zcvyHusYI+eQHgguSxPBPv6zAZ0i+x0C52CsqBIysxXdyme3xyTIKECnnNP3E8
 7gbki+QK9Y5b8gNk28veokpXqRf6QWJKt3B+lDT9QNosoa4ls1n0SGeN1qsTCe3ZNeg6
 1WWPkxqRA+5ZZh4Or+mh93USLXoL44ZsF4E/Qx4/9+WS0WjhSrQDLZSLpUiUYE3keE5s
 jIHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8VWDWlBPOvhB7Fh57TMaJEARcn8BNdPBL/a+RIhxPmsWTLgAn0/MNRg+LcQX2LseHLdbvoDQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yzqa7aFuMCIFtlGv4eeFto8yVKvscDXvrL7/uqyHQ6+lq3NbiqO
 gKoKHdizU7qSx2ysWe6i8XlHXyoMvRq5UNL928Z/hcyDaJgX3CqmRjZECGMP8yN7j9GqLSHeGju
 BrbnHiMwZjkHn7vTff4vQeN7OhcADJHpQVOh/2C9s
X-Gm-Gg: AeBDieu5qvEN/tnLGk5Lng5dcwDXe5Fpd3GIUoLxh2Ek2+TUEW0KN/57aNJh8i6k+pP
 I2DLBIhTqpqYCBqvHCZdfPED+U4qU0/b6XEl+fDIr+8Ilyhvd105rKYFW6ITnHIo45pZnFqkXVg
 WagAOT81RVVNYdLjxrmLcQ5+hmmgNn4RcEELaoGTMk8q55vwX1NguEuDv+BZMLWE8C2C11gMFZo
 ZPgu2xFgC00N0Bay4sRTJsOqtbKSXt2rYRmJoaGrOgNqARkyPrWVZC95DenXRcHW5ka4It48Cer
 VeR2YQ==
X-Received: by 2002:a17:907:c28f:b0:b9c:69df:4d9d with SMTP id
 a640c23a62f3a-b9d7267ae8emr375272666b.38.1775913291449; Sat, 11 Apr 2026
 06:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260410091154.1001021-9-varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20260410091154.1001021-9-varadarajan.narayanan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 07:14:38 -0600
X-Gm-Features: AQROBzCPHXCp0Z5WLh6_du7IT2Bj2pp1SUULbG8kqOEBC4W1r6LhrjxqPTWdmLc
Message-ID: <CAFLszTgiz=vNv1QMDx2-pNsEKE+FbDN19tyVgXayxi4VfN_vZg@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] mach-snapdragon: Add commands to create wrapper ELF
To: varadarajan.narayanan@oss.qualcomm.com
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com, 
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 peng.fan@nxp.com, jh80.chung@samsung.com, lukma@denx.de, 
 tien.fong.chee@altera.com, anshuld@ti.com, alif.zakuan.yuslaimi@altera.com, 
 tingting.meng@altera.com, alice.guo@nxp.com, quentin.schulz@cherry.de, 
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, mkorpershoek@kernel.org, 
 h-salunke@ti.com, alchark@gmail.com, dario.binacchi@amarulasolutions.com, 
 ye.li@nxp.com, andre.przywara@arm.com, afd@ti.com, dinesh.maniyam@altera.com, 
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com, 
 aswin.murugan@oss.qualcomm.com, luca.weiss@fairphone.com, 
 adrian@mainlining.org, justin@tidylabs.net, n-francis@ti.com, wens@kernel.org, 
 jamie.gibbons@microchip.com, david.wronek@mainlining.org, 
 alexeymin@postmarketos.org, james.hilliard1@gmail.com, 
 michael@amarulasolutions.com, richard.genoud@bootlin.com, 
 philip.molloy@analog.com, sughosh.ganu@arm.com, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 11 Apr 2026 15:25:15 +0200
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

Hi Varadarajan,

On 2026-04-10T09:11:45, Varadarajan Narayanan
<varadarajan.narayanan@oss.qualcomm.com> wrote:
> mach-snapdragon: Add commands to create wrapper ELF
>
> The IPQ5210 boot ROM expects the SPL binary image to be embedded within
> an ELF along with additional binaries. Hence add the relevant commands
> and linker script needed to convert u-boot-spl.bin to the expected
> format.
>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
>
> arch/arm/mach-snapdragon/Kconfig                  |  6 ++++++
>  arch/arm/mach-snapdragon/ipq5210-spl-wrap-elf.lds | 14 ++++++++++++++
>  scripts/Makefile.xpl                              | 21 +++++++++++++++++++++
>  3 files changed, 41 insertions(+)

> diff --git a/arch/arm/mach-snapdragon/ipq5210-spl-wrap-elf.lds b/arch/arm/mach-snapdragon/ipq5210-spl-wrap-elf.lds
> new file mode 100644
> @@ -0,0 +1,14 @@
> +PHDRS {

Please add SPDX licence identifier.

> diff --git a/arch/arm/mach-snapdragon/ipq5210-spl-wrap-elf.lds b/arch/arm/mach-snapdragon/ipq5210-spl-wrap-elf.lds
> @@ -0,0 +1,14 @@
> +SECTIONS {
> +     . = 0x8c24000;

This hardcodes the load address. It would be better to use
CONFIG_SPL_TEXT_BASE here so it stays in sync with the defconfig. You
can pass it via LDPPFLAGS in Makefile.xpl similar to how
IMAGE_TEXT_BASE is passed.

> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> @@ -45,4 +45,10 @@ config SYS_CONFIG_NAME
> +config SPL_WRAPPER_ELF
> +     bool "Create wrapper ELF for applicable platforms"
> +     help
> +       Some platforms embed the U-Boot SPL binary within an ELF as a
> +       segment. Additional tools are used to convert this ELF into a
> +       image that is usable for the boot ROM.

into an image

Since you are adding a new SPL feature you may need to add "depends on
SPL" to make the dependency explicit.

Regards,
Simon
