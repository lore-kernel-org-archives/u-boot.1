Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC43AC0218A
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 09:53:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D0AA81B4B;
	Tue, 28 Jan 2025 10:53:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zWHBL7U0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DAD381BC0; Tue, 28 Jan 2025 10:53:04 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AFF3819B1
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 10:53:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-385de9f789cso4257893f8f.2
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 01:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738057981; x=1738662781;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qdmTJ/cK9SkGVnW3V6ePPwPYoFfIsQEe3ht3NPm/ZI4=;
 b=zWHBL7U0e7Iw5OI2zPXUokpwALVn4xA7TBOgI8jMoC+j0z/bWuUDPaVSb4plU4nwCn
 y09eWxc0IScTr3zJi4ZWAbX8wgTBjxvTckx2s1nfSOEnCUE3kfd1pYEj0mivR9bwNLYL
 8i7MXN5LopKZIBS1RW7TDHc1m2+v6WbPZfG+N1F8t8S+desJ0/yL+ROQmcWjg6b785Mv
 arjn/MO4AyQ+6GIkRZ2I13bbTblGIimNAQAH/GHfFvcoaRmeTf+/rrCnjIcbmtA8XsLb
 Xh6TjfbnUP/fXKvKtTq1pJ6XdwPh4tBJ9JBOAZRT4A4CHqqUEQE/QfOx6Lmu9Z98Ns77
 eg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738057981; x=1738662781;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:to:from:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qdmTJ/cK9SkGVnW3V6ePPwPYoFfIsQEe3ht3NPm/ZI4=;
 b=pBf4Ew2XPhSiU0/eD5sl8y9Svy/atq+KF7BYg+l6WAalJeH8ax2Z8AHZ9oGaR/YCy0
 eFiDuqtFqsqNR6TRB+ngJXeztCwrcRua/eOp/OnpIfVtjFQ7i7dX4Azk6y4Z3PmKfOYX
 9I13l9u4DA8bEt5FSnvrFo8SbCMfll0hp3AZvDOs+/jGEZZWEogqLcTayxjnJ52Ychvi
 0/cywEoG2b3Sr5DlXFxlFhJcIV/YCyLKHi7Ub+Oy3sFCuVJ9hdsXJguV2JmubjApgdnC
 eLZkc11iV7k5tjOOwDM+yMGq2y9FuF83w/uZ1f1QTtIJssZaBkaKfJarDwrxwQ4pfvOf
 6LOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcoiSgMAPZT9Yx4uKyp5kp2S9cp0IfVvSSx2e4jTltSwIr/Dkzy+7PkpBXCjiZrU7VfUrqlPw=@lists.denx.de
X-Gm-Message-State: AOJu0Yxg6tJZeDDKKUKynnx7Bp+0MldB5qzrlOJPKNuaTr/1p45kqTOO
 b6EOHv7WwjtUXG+rk/3Z1jEtmEAE/g2t5Qt/j5lLji2dqrJBci6P1Efn0vogOccXZt1taTsba5w
 c
X-Gm-Gg: ASbGncuCN8urANKPE/514yVZqPEm0loq4RwFePu7choCXk6PEvdo4pn8JVcjpXpXS/I
 RM48LWCnDTXZf32PLI2W3YiizzL2IRnHz0pLuVBe541cwj/d8HCvVPxA+Ng+RsjxQzyD69Mikgv
 /0O+zMycF0XOBA5Rk0LLi6cVLcxnsWnapq0ecDRZCJGR1JLbod1+DKjXDT6vz/ApBVlMXi8zyxI
 9o3ORvoY5EPDsp0ss+q25IUgLYSE6U22yWCMihi1Icp5fpMaUEJRBGPTWWCpvI8z7p2gw190xs8
 NrvUQg+ojjE279QblgYwXHzq
X-Google-Smtp-Source: AGHT+IFlLmEOP4b3bZUXqoN7IeEghxUFPz4sa07qeyLNknJo9BHdFgL8DBkwTGqlcn0CNGInIz0jdg==
X-Received: by 2002:a5d:6d83:0:b0:385:efc7:932d with SMTP id
 ffacd0b85a97d-38bf57d2a39mr40186061f8f.46.1738057980808; 
 Tue, 28 Jan 2025 01:53:00 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1bbd93sm13674604f8f.76.2025.01.28.01.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 01:53:00 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Federico Fuga <fuga@studiofuga.com>, u-boot@lists.denx.de
Subject: Re: [PATCH][V2] Fix fastboot handling of partitions when no slots
 are supported
In-Reply-To: <906b4d88-39c6-4e85-b9b1-62527a87d640@studiofuga.com>
References: <906b4d88-39c6-4e85-b9b1-62527a87d640@studiofuga.com>
Date: Tue, 28 Jan 2025 10:52:59 +0100
Message-ID: <87lduvqn7o.fsf@baylibre.com>
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

Hi Federico,

Thank you for the patch.

This patch has incorrect recipients. This has only been send to the
U-Boot.

However, when running:

$ ./scripts/get_maintainer.pl -f drivers/fastboot

Mattijs Korpershoek <mkorpershoek@baylibre.com> (maintainer:FASTBOOT,commit=
_signer:7/10=3D70%)
Tom Rini <trini@konsulko.com> (maintainer:THE REST,authored:5/10=3D50%)
Simon Glass <sjg@chromium.org> (commit_signer:2/10=3D20%,authored:2/10=3D20=
%)
Caleb Connolly <caleb.connolly@linaro.org> (commit_signer:1/10=3D10%,author=
ed:1/10=3D10%)
Ilias Apalodimas <ilias.apalodimas@linaro.org> (commit_signer:1/10=3D10%)
Quentin Schulz <quentin.schulz@cherry.de> (commit_signer:1/10=3D10%)
Jerome Forissier <jerome.forissier@linaro.org> (authored:1/10=3D10%)
Alexey Romanov <avromanov@salutedevices.com> (authored:1/10=3D10%)
u-boot@lists.denx.de (open list)

We see that I should have been copied as well (since I'm the fastboot maint=
ainer)

Please make sure you run ./scripts/get_maintainer when submitting
changes. If patches are not addressed to the right people, they might
get lost and have no answer to them.
This will probably discourage further contributions, which is a shame!

Consider using tools like b4 which help automating such things for you:
https://people.kernel.org/monsieuricon/sending-a-kernel-patch-with-b4-part-1
https://b4.docs.kernel.org/en/latest/contributor/overview.html

b4 is aimed at kernel developers first, but works great for U-Boot
submissions as well.

Please see some more remarks below.

On mar., janv. 28, 2025 at 10:27, Federico Fuga <fuga@studiofuga.com> wrote:

> The fastboot module has a bug that prevents some command to work
> properly on devices that haven't an Android-like partition scheme, that
> is, just one spl and one kernel partition, instead of the redundant
> scheme with _a and _b slots.
>
> This is the schema of our NAND storage (board is based on an AllWinner
> A33 sunxi chip):
>
> =3D> mtdparts
>
> device nand0 <1c03000.nand>, # parts =3D 4
>  =C2=A0#: name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net size=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset mask_flags
>  =C2=A00: spl=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x000=
20000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x00020000=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x00000000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>  =C2=A01: uboot=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x00100000=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x00100000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0002=
0000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>  =C2=A02: kernel_a=C2=A0=C2=A0=C2=A0=C2=A0 0x00400000=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0x00400000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x00120000=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0
>  =C2=A03: ubi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x07a=
e0000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x079e0000 (!)=C2=A0 0x00520000=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 0
>
> active partition: nand0,0 - (spl) 0x00020000 @ 0x00000000
>
> This happens when we try to erase the spl partition using fastboot:
>
> $ fastboot erase spl
> Erasing 'spl_a'=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 FAILED (remote: 'invalid NAND device')
> fastboot: error: Command failed
>
> The error occurs because getvars fails to handle the error returned by
> nand layer when a partition cannot be found.
>
> Indeed, getvar_get_part_info returns what is returned by
> fastboot_nand_get_part_info (0 on success, 1 on failure) but it should
> return -ENODEV or -EINVAL instead. Since the cause of failure is not
> returned by the nand function, I decided to return -EINVAL to make it
> simple.
>
> Signed-off-by: Federico Fuga <fuga@studiofuga.com>

The patch is still not applicable for me.
I see:
$ b4 shazam -s -l --check 906b4d88-39c6-4e85-b9b1-62527a87d640@studiofuga.c=
om
Grabbing thread from lore.kernel.org/all/906b4d88-39c6-4e85-b9b1-62527a87d6=
40@studiofuga.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 3 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
Analyzing 2 code-review messages
Checking attestation on all messages, may take a moment...
---
  [PATCH v2] Fix fastboot handling of partitions when no slots are supported
    + Link: https://lore.kernel.org/r/906b4d88-39c6-4e85-b9b1-62527a87d640@=
studiofuga.com
    + Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
    =E2=97=8F checkpatch.pl: 116: WARNING: Possible unwrapped commit descri=
ption (prefer a maximum 75 chars per line)
    =E2=97=8F checkpatch.pl: 150: ERROR: patch seems to be corrupt (line wr=
apped?)
    =E2=97=8F checkpatch.pl: 155: WARNING: suspect code indent for conditio=
nal statements (0, 0)
    =E2=97=8F checkpatch.pl: 157: WARNING: suspect code indent for conditio=
nal statements (0, 0)

If we look below:

> ---
>  =C2=A0drivers/fastboot/fb_getvar.c | 5 ++++-
>  =C2=A0drivers/fastboot/fb_nand.c=C2=A0=C2=A0 | 2 +-
>  =C2=A02 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
> index 9c2ce65a4e..816ed8a621 100644
> --- a/drivers/fastboot/fb_getvar.c
> +++ b/drivers/fastboot/fb_getvar.c
> @@ -121,8 +121,11 @@ static int getvar_get_part_info(const char=20
> *part_name, char *response,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 *size =3D disk_part.size * disk_part.blksz;
>  =C2=A0=C2=A0=C2=A0=C2=A0 } else if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_NAN=
D)) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r =3D fastboot_nand_get=
_part_info(part_name, &part_info, response);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (r >=3D 0 && size)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (r =3D=3D 0 && size) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 *size =3D part_info->size;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r =3D=
 -EINVAL;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>  =C2=A0=C2=A0=C2=A0=C2=A0 } else {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fastboot_fail("this sto=
rage is not supported in bootloader",=20
> response);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r =3D -ENODEV;

Here, for example, I see some strange characters "=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0"

Are you sure that this patch has been properly formatted using
git-format patch?

Can you try to download it from patchwork and apply yourself?
https://patchwork.ozlabs.org/project/uboot/patch/906b4d88-39c6-4e85-b9b1-62=
527a87d640@studiofuga.com/

> diff --git a/drivers/fastboot/fb_nand.c b/drivers/fastboot/fb_nand.c
> index afc64fd528..9e2f7c0189 100644
> --- a/drivers/fastboot/fb_nand.c
> +++ b/drivers/fastboot/fb_nand.c
> @@ -151,7 +151,7 @@ static lbaint_t fb_nand_sparse_reserve(struct=20
> sparse_storage *info,
>  =C2=A0 *
>  =C2=A0 * @part_name: Named device to lookup
>  =C2=A0 * @part_info: Pointer to returned part_info pointer
> - * @response: Pointer to fastboot response buffer
> + * @response: 0 on success, 1 otherwise
>  =C2=A0 */
>  =C2=A0int fastboot_nand_get_part_info(const char *part_name,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 struct part_info **part_info, char *response)
> --=20
> 2.48.1
