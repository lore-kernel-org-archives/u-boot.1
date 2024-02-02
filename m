Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F76C4828F
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 20:35:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DB4A87E2E;
	Fri,  2 Feb 2024 21:35:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="d5fo7XxZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AF1987E29; Fri,  2 Feb 2024 21:35:28 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F89B87E2E
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 21:35:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3bb9d54575cso1636953b6e.2
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 12:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1706906124; x=1707510924; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sW8yFV6bkB8+A80z0T3iUUNcL9oGBejWBsi+a6A0JP4=;
 b=d5fo7XxZcJbS8ChPwOR1oxwpxKhX1bH4oATxBk48Z3Hxf56vF0czEHymxkcBVQVc4N
 XVPLmfnqr3z6nZXbA63UvQy7ptuhoKxu5Zw0p0ofI4Ta+z4gCHEFweAwIChR8kRp8aGL
 KfUaO/fNw4bw69pwv4UZAFO8l4cSJO/hjBo2rB0YVWNOTmttZBPUXV7KAlIRJMPDeOYF
 I8TrxnE+b6vtsLkWjqzQAEcSmz8r/cj3UpC887IK3PIL3b1iFBYkSQQJhjlLUkX9E5oq
 M1/vlIzDj8iXLlYYNClPTRMdzvu5JIcE5Z759CG40liVlwK2qxg974240hyqSxjdpwc4
 aXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706906124; x=1707510924;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sW8yFV6bkB8+A80z0T3iUUNcL9oGBejWBsi+a6A0JP4=;
 b=LbUB3Ti1o6J+T/k53PAuXc9y+PNwXnDrUZxU81q9nqExyQm+zBPKh+YnW8j5j5pRum
 938usEWjMAbgbmSCGyWcQLFxcgxNvawZHjoJ3MqOm6D5jz/Lbq5YtwIfRlDWqsXeImoZ
 tOpqqe3I/VHU5xB+pDinpsQvDRhI9eZSBkwe1tTHmuOTlAIZAy7C8G4dVUOV0jpZrzl+
 +7a/IWASjOkLkM734kFqroXTtjjqTdb2sXcJjX13PB5zVY4w/zeVb9nB8FsfdPSHfF3i
 wD+wNRQrDnYvYkQ3Xar8Nn76ucCnYm5omPcDW49KQrFxY+NQTTMycRApMHXc98AEignR
 wzXA==
X-Gm-Message-State: AOJu0Yxd9KtQjNtQoRQJtDEoi8l4bTh+/ZrZwdrv1jmASZapSF26Yeff
 XD3NjMPt00NRjV4rMiZxTv3AHWDrZIhxe98p1skLAgQ9VOB7/cX3gL8cl/LHJCMMTjx3zNZVAMh
 a44rqNwpEmXHOopjM2KwmYuse4kCjyDY1YNGL7w==
X-Google-Smtp-Source: AGHT+IGPheMK1MBVYg3sNmJne9hpk8UzqTOL+UKkcPYEVUvkoKbwRnfUpzLbDKgFJYbzJVuQw/PSTXz5nvrnvGCaJww=
X-Received: by 2002:a05:6871:68b:b0:210:a495:ba1f with SMTP id
 l11-20020a056871068b00b00210a495ba1fmr964025oao.15.1706906124610; Fri, 02 Feb
 2024 12:35:24 -0800 (PST)
MIME-Version: 1.0
References: <20240202160405.4126192-1-festevam@gmail.com>
In-Reply-To: <20240202160405.4126192-1-festevam@gmail.com>
From: Igor Opaniuk <igor.opaniuk@foundries.io>
Date: Fri, 2 Feb 2024 21:34:48 +0100
Message-ID: <CAL6CDMFC0tmQgE1jWP0_s1uKVBpSH_9U9xqs9sPY4Mv2u9R_4Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mx6sabresd: Fix U-Boot corruption after saving the
 environment
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, trini@konsulko.com, uboot-imx@nxp.com, 
 u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
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

On Fri, Feb 2, 2024 at 5:04=E2=80=AFPM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> U-Boot binary has grown in such a way that it goes beyond the reserved
> area for the environment variables.
>
> Running "saveenv" and rebooting the board causes U-Boot to hang because
> of this overlap.
>
> Fix this problem by selecting CONFIG_LTO so that the U-Boot proper
> size can be reduced.
>
> Also, to prevent this same problem to happen in the future, use
> CONFIG_BOARD_SIZE_LIMIT, which can detect the overlap in build-time.
>
> CONFIG_BOARD_SIZE_LIMIT is calculated as follows:
>
> CONFIG_BOARD_SIZE_LIMIT =3D CONFIG_ENV_OFFSET - u-boot-img.dtb offset
> CONFIG_BOARD_SIZE_LIMIT =3D 0xc000 - 69 * 1024
> CONFIG_BOARD_SIZE_LIMIT =3D 715766
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
> Changes since v1:
> - Select LTO. (Tom)
>
>  configs/mx6sabresd_defconfig | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/configs/mx6sabresd_defconfig b/configs/mx6sabresd_defconfig
> index a90efe4a7786..d4fb55622cf1 100644
> --- a/configs/mx6sabresd_defconfig
> +++ b/configs/mx6sabresd_defconfig
> @@ -21,6 +21,9 @@ CONFIG_SPL_SERIAL=3Dy
>  CONFIG_SPL=3Dy
>  CONFIG_SPL_LIBDISK_SUPPORT=3Dy
>  CONFIG_PCI=3Dy
> +CONFIG_LTO=3Dy
> +CONFIG_HAS_BOARD_SIZE_LIMIT=3Dy
> +CONFIG_BOARD_SIZE_LIMIT=3D715766
>  CONFIG_FIT=3Dy
>  CONFIG_SPL_FIT_PRINT=3Dy
>  CONFIG_SPL_LOAD_FIT=3Dy
> --
> 2.34.1
>
Reviewed-by: Igor Opaniuk <igor.opaniuk@foundries.io>

btw, from my experience, the same issue will probably occur again in future=
,
especially when the current U-Boot size is already close to the defined lim=
it
(yes, with this patch it will be reported during compile time, but still).

Have you considered adjusting the boot image layout instead
(moving CONFIG_ENV_OFFSET, so unlikely
U-Boot image will overlap again) to tackle feature problems?

--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk
Senior Software Engineer, Embedded & Security
E: igor.opaniuk@foundries.io
W: www.foundries.io
