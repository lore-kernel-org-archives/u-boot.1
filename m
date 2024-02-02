Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31130C47DB3
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 13:53:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 906CB8784B;
	Fri,  2 Feb 2024 14:53:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gTLU0RF+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C138187968; Fri,  2 Feb 2024 14:53:50 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7742B877BB
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 14:53:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-296424aaa95so448984a91.3
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 05:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706882027; x=1707486827; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ROAdJXM+Sgvkrra5Mam+ok7i2m2NneVY7QgMYnUvKbs=;
 b=gTLU0RF+oqXX1M3NiHOkDGMifb91RGKlY9LHDQ+Ot/TlasmZyOlIrDq0DuRcVfgPlt
 GI8U8H//PluSWjgIotX9z2huhvMMk52LDtjSc3hOKZ95hdaIrir4sEacCFEL9A5Z54ss
 dAJCDkXWs2vvr8CwsCdpNJJMtTFDCtccMlOF9wFtPUriD6MLqYye/6eRtcW6tpvwZttF
 fv3CYO9c7/aSzEXDSko0wh61PdCxxlu3M/TYDvQ3WiCGCJlVLAAL/YJJTrFAeiPxrr34
 x2V8v8Bc5mpvj6egY3+Zs+5OHSGGFpy1VjbTOINiCcEwxggnFSAt2IvD7Uf7Eqwzesdx
 a2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706882027; x=1707486827;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ROAdJXM+Sgvkrra5Mam+ok7i2m2NneVY7QgMYnUvKbs=;
 b=j8ypmH9ghA9wyL5t2rxM4xqtbnQYQNhy2w+8Df7+TEYvsSvNXTPv1gBwkaz58s1sNl
 38HB+Zix0PNRN92gFg0n7cE6AM8zD0pEOE2Rguh8PWx3rHAP8Xeek6Eud67FiWCDUReU
 YHoYtEIQpC8duGvGXpFKJVzZhW+l/ejW4lHg6kxsXQkQEKRovqmaJcVW07/TM6LAXSw6
 y3QuhMQN9mr95yWZt3lV/y9TzwFXQv1qPjXm+7npqRQOHnjGcergBAflPfa2n6pr3kIp
 3ilx/lRoJlNytDi8s6WPIz3TqxpVBQTWgHEMEPpmTLXLgP7bHYeMPC+91xo5AcIifQLG
 Ed9w==
X-Gm-Message-State: AOJu0YwvjhMDD0+qgSC+uM22q91qJnG5xLCliETqakciDfyTV7xsthMP
 ZX6FCP+D7BGXp+QBX2bf9olsZmykigr/cUm3jWJS9l41FlDZY1yejRXZAu4uY5JN8uiQtFx/RQ7
 VPBvtKTwFEUfbi7/6zs3DdVw3Gb0=
X-Google-Smtp-Source: AGHT+IGw6aDXYDiJtRSdSHQvU9qoU4x042gA4wOJmtiVOuMhC644LAy1Nd/uTRgkhQNjmSDq4SX9YOM2pjtjjWyhJVU=
X-Received: by 2002:a17:90a:b117:b0:296:1ac3:c573 with SMTP id
 z23-20020a17090ab11700b002961ac3c573mr4410264pjq.15.1706882026591; Fri, 02
 Feb 2024 05:53:46 -0800 (PST)
MIME-Version: 1.0
References: <1705043234-39185-1-git-send-email-ye.li@nxp.com>
In-Reply-To: <1705043234-39185-1-git-send-email-ye.li@nxp.com>
From: Adam Ford <aford173@gmail.com>
Date: Fri, 2 Feb 2024 07:53:35 -0600
Message-ID: <CAHCN7xLCyitv+WF2kjcvsnmTjBVQO-RgfSYVre9fS6YTEgfxZw@mail.gmail.com>
Subject: Re: [PATCH] arm: imx: imx8m: Enable the SError exception
To: Ye Li <ye.li@nxp.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, peng.fan@nxp.com, uboot-imx@nxp.com, 
 thomas.schaefer@kontron.com
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

On Fri, Jan 12, 2024 at 1:07=E2=80=AFAM Ye Li <ye.li@nxp.com> wrote:
>
> To work with commit 2f3c920(imx8m: workaround ROM serror),
> we need to enable the SError exception and install vector in SPL.
>
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm/mach-imx/imx8m/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kc=
onfig
> index 67da198..88ef732 100644
> --- a/arch/arm/mach-imx/imx8m/Kconfig
> +++ b/arch/arm/mach-imx/imx8m/Kconfig
> @@ -11,14 +11,17 @@ config IMX8MQ
>         bool
>         select IMX8M
>         select CLK_IMX8MQ
> +       select ARMV8_SPL_EXCEPTION_VECTORS
>
>  config IMX8MM
>         bool
>         select IMX8M
> +       select ARMV8_SPL_EXCEPTION_VECTORS
>
>  config IMX8MN
>         bool
>         select IMX8M
> +       select ARMV8_SPL_EXCEPTION_VECTORS
>
>  config IMX8MP
>         bool
> --
> 2.7.4
>

Would this not also work for 8MP?  If that's the case, should the
section of ARMV8_SPL_EXCEPTION_VECTORS fall under "config IMX8M" for
simplicity?

adam
