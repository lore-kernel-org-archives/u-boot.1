Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB880C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 06:10:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16980810F4;
	Mon, 17 Mar 2025 07:10:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="V36jYPwf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFE3E81100; Mon, 17 Mar 2025 07:10:10 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 065A980F4C
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 07:10:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-300f92661fcso2194841a91.3
 for <u-boot@lists.denx.de>; Sun, 16 Mar 2025 23:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1742191806; x=1742796606;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Im+SEKkBx0ka4Rb93/n+FPrhbHZgh/rtT60QCwpXH14=;
 b=V36jYPwfK0rbRA93bslb0/FxwUIbp5PrRh3eHf4rdhihY791gLuVxYmLk9crPU1UMB
 LMMAxNWXWr7IXxKU5QJ2jUxpBXcZKthkmRaqjyIOgOFb9oWhjS0aKqyW6prMdA/Lb1yq
 zaLRmZtbfPbk6bFfInkvBXPLQJ7MWI0JPxFog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742191806; x=1742796606;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Im+SEKkBx0ka4Rb93/n+FPrhbHZgh/rtT60QCwpXH14=;
 b=pNs0wZiKt52dP1dSz0e6dv6dF2eR39vSLuFpMKvwZduh5jzT1AoVnaJzykw+y4dUxq
 PB+g4xq1UvxUsDS4UJO0aiOto9hRClr5JLdWjZkIWBb9kupOfYTPhhYRgPcTLi4ZnlQY
 EpFAUou2cRWBGtLoEUYegBkMGWg2OW9xy/05ooz/IamdN6l3tXKdPV6A24oZz7Q3Kdho
 bJwdNZbaGcJjD0DVf5E+pAGiKWbP9zRYKHH7ap8AeU9eK15QbYNUEFlDziHQAaTTH9+8
 sjU6gjSk9D0u31pXR9rb0PY99bOW+Q8D/iaMLvB0lTzGwzJcu/QIST46DTyQPZL9fBNj
 v53A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdfZGGX64/u0BCsdQE7H/ZkZAZLkxrC9BzqW7mcx8DB54I134j9maHFGE6Zubw4xQl1uTzbfE=@lists.denx.de
X-Gm-Message-State: AOJu0Ywe5YZObRqWFUCQKSnwxtF2cxbT4yHq9ltR2+7mpJEuCIbMO/2A
 pHotu63eRktYlJrGWjXZQH52r87do6aKewAU4G8JBIPEpPDd2SUghSb/uRU1Lf1Wgv6YaaWXH0c
 huKGXFyzoUhexLUhIW6Q5iBaT0gIwAidHqHzx8g==
X-Gm-Gg: ASbGncuFyKf0PXf6/5tS3dXAiGNrmbr28gMSRJt91Cc3YNrdlpfH5sv5Mcq0P2bj6f+
 tplfwyI65g6OOqTAuqmAnQ0RHwkADWt7Ar3cGZ0Fr0L1IKxBngiFXhZA3KHnmFkT/cYzUWiCkcz
 MezshrCxpPhHDvnIFYHxwFLo4=
X-Google-Smtp-Source: AGHT+IHkpQqn2hEpVGLNHyxc7AUNlmVvQh6llwp3StzTseehZSMTTR6t/moamhnqdIZWfWvj/W/vmp9tSnHjmJM5/nQ=
X-Received: by 2002:a17:90b:1dc3:b0:2f8:b2c:5ef3 with SMTP id
 98e67ed59e1d1-30151c9a5a3mr16450140a91.14.1742191806228; Sun, 16 Mar 2025
 23:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <d087411f-c2fd-75a8-6041-31623aba53ae@salutedevices.com>
In-Reply-To: <d087411f-c2fd-75a8-6041-31623aba53ae@salutedevices.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 17 Mar 2025 07:09:53 +0100
X-Gm-Features: AQ5f1JrWT1PwikHmpOV9wPTIaeF7k-8UjcDBB-EZiXkzx_fzJ4Sx5-z1EKI3GUg
Message-ID: <CAOf5uwmftbyysOL_Gf1BRgQmP7EyCS_=Jn5ge4KUbA5efbe_Hw@mail.gmail.com>
Subject: Re: [PATCH v1] mtd: rawnand: meson: always use OOB bytes during write
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, kernel@salutedevices.com, 
 oxffffaa@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Arseniy

On Sun, Dec 22, 2024 at 10:23=E2=80=AFPM Arseniy Krasnov <
avkrasnov@salutedevices.com> wrote:

> If 'oob_required' is not set by the caller (for example 'oobbuf' is NULL)=
,
> then driver doesn't copy OOB data from 'oob_poi' to special controller
> structures, so zeroes will be written as OOB. But, generic raw NAND logic
> in 'nand_base.c' already handles case when OOB is not required to write b=
y
> filling 'oob_poi' with 0xFF's. So let's remove 'oob_required' check to
> always read 'oob_poi' data for OOB.
>
> Kernel driver (drivers/mtd/nand/raw/meson_nand.c) works in the same way,
> so need to keep same behaviour here.
>
> Fixes: c2e8c4d09a7a ("mtd: rawnand: Meson NAND controller support")
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>  drivers/mtd/nand/raw/meson_nand.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/meson_nand.c
> b/drivers/mtd/nand/raw/meson_nand.c
> index 81122315f4..82a12ac061 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -607,9 +607,7 @@ static int meson_nfc_write_page_hwecc(struct mtd_info
> *mtd, struct nand_chip *ch
>                 memcpy(meson_chip->data_buf, buf, mtd->writesize);
>
>         memset(meson_chip->info_buf, 0, chip->ecc.steps * PER_INFO_BYTE);
> -
> -       if (oob_required)
> -               meson_nfc_set_user_byte(chip, chip->oob_poi);
> +       meson_nfc_set_user_byte(chip, chip->oob_poi);
>
>         return meson_nfc_write_page_sub(chip, page, false);
>  }
>

Applied and sent already the pull request

Michael


> --
> 2.30.1
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
