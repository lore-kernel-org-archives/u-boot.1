Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC15C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 22:57:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43633882C5;
	Wed,  8 May 2024 00:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lzNjAsmU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF66B88387; Wed,  8 May 2024 00:57:31 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8238F8802D
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 00:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41ecf80482bso3668575e9.1
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 15:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715122649; x=1715727449; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mgQPpcRmxEgmUQMZ4ifLZjc6r1BC32xA9GU/1rNtT9Y=;
 b=lzNjAsmUknYdE/kHkRBaYUZ58OPtab4LpHgCaZ4dEFgA6cZ51y0kqFfh3RrdtzomMP
 BT5dDwbRfXRGVWKa/x3VGEcVWiykj/F76vHMgh8Ay+rd12lDlk1L6TQJCEhPnRuiYrJw
 uKf4mXgwjOVAPo0D+gNibQRQIZAQ5FgEHgiZV0DX4rCHv/7fr2vjhoZhU5ruueM/SAmF
 0STNM3JQu/di8Ymqc8mFrR5nMFDICEVMfN15h+lPUz3DRwMhbzkxtQk/QkVljUikH60t
 Egu4Pvf67GLi3RlCnhALGzB0cskAbokTTIyE76+cTWjKeVrWDDP8gL60JSDI347IvZXV
 UCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715122649; x=1715727449;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mgQPpcRmxEgmUQMZ4ifLZjc6r1BC32xA9GU/1rNtT9Y=;
 b=T0xDL6E+1pTwA+gPvI1QWuXDskF3LmxHSKZpNhBNu30TTY/b9rhr/irEyab8pbM2KL
 UNn6kIUnUkRN0itzMcnzK29DPxqMt7QNUdo0S5JYhs1SIBJnFBh7O+Z4lTDpMCZqxxpf
 OqzgXxF/7dGoZRlMh5NhQSyJYtqcAnoT+/ai9IDvvuYLwPFc6Ybz9X8YLqRhafrQEHie
 dXZ3vr8M0hZkSF5SDUE9mFUdG2VjE+3dq8eJ9x7VvF/AiP+8vC58vyF3m/j/U2OJjySB
 xzgTMc0QoESJmQ3HgQXIfeVKoIXYb8/SqhjP+jqTwcMXDtbLALzKjkZENp0aLWomCFRK
 6Hww==
X-Gm-Message-State: AOJu0YwMlyggoS92bMFgjFbntIpyyBcKgaGNYmg9C3WVtBWa+ZHzHRe4
 YLyhN7eoOUxbJE7CVppjbeOcQCes3ifKfn+gNh4W7hXCnI0TDoX1gn8EQu7XDw6GzlLeRVEPPpn
 O9b51LNcBw8I7Mcd5RQMNWPsExOk=
X-Google-Smtp-Source: AGHT+IFD6kAVl1ewB0W9CAJg2KRDysRBriKwsw3FQq96OxDjihNDJxqJ1v0HvxD023f5I/AZ0ye/n+RF38FVjNs8mK4=
X-Received: by 2002:adf:ee4f:0:b0:34d:742e:3db8 with SMTP id
 ffacd0b85a97d-34fca052508mr775059f8f.0.1715122648641; Tue, 07 May 2024
 15:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
 <20240507175132.1456512-6-raymond.mao@linaro.org>
In-Reply-To: <20240507175132.1456512-6-raymond.mao@linaro.org>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Wed, 8 May 2024 00:57:17 +0200
Message-ID: <CAByghJYwSZY2G3dWGWkvYSdzJnjRZcfUQSboTFxso3G9+_bq7w@mail.gmail.com>
Subject: Re: [PATCH v2 05/28] image: remove redundant hash includes
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Andrew Davis <afd@ti.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Sumit Garg <sumit.garg@linaro.org>, Jesse Taube <mr.bossman075@gmail.com>, 
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Sergei Antonov <saproj@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Bin Meng <bmeng@tinylab.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Alexander Gendin <agendin@matrox.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
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

On Tue, May 7, 2024 at 7:54=E2=80=AFPM Raymond Mao <raymond.mao@linaro.org>=
 wrote:
>
> Remove the redundant includes of u-boot/md5.h, u-boot/sha1.h,
> u-boot/sha256.h and u-boot/sha512.h
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - None.
>
>  boot/image-fit.c | 4 ----
>  boot/image.c     | 2 --
>  2 files changed, 6 deletions(-)
>
> diff --git a/boot/image-fit.c b/boot/image-fit.c
> index 89e377563ce..1efc39f4408 100644
> --- a/boot/image-fit.c
> +++ b/boot/image-fit.c
> @@ -38,10 +38,6 @@ DECLARE_GLOBAL_DATA_PTR;
>  #include <image.h>
>  #include <bootstage.h>
>  #include <u-boot/crc.h>
> -#include <u-boot/md5.h>
> -#include <u-boot/sha1.h>
> -#include <u-boot/sha256.h>
> -#include <u-boot/sha512.h>
>
>  /***********************************************************************=
******/
>  /* New uImage format routines */
> diff --git a/boot/image.c b/boot/image.c
> index 073931cd7a3..e57d6eae52d 100644
> --- a/boot/image.c
> +++ b/boot/image.c
> @@ -26,8 +26,6 @@
>  #endif
>
>  #include <asm/global_data.h>
> -#include <u-boot/md5.h>
> -#include <u-boot/sha1.h>
>  #include <linux/errno.h>
>  #include <asm/io.h>
>
> --
> 2.25.1
>
Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>

--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
https://www.linkedin.com/in/iopaniuk
