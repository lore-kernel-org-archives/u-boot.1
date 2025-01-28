Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B99C0218D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 08:44:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 002AC81B4B;
	Tue, 28 Jan 2025 09:44:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="q+StSpLk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35E0381BC0; Tue, 28 Jan 2025 09:44:33 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C384A8197D
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 09:44:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-386329da1d9so2690119f8f.1
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 00:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738053870; x=1738658670;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Xn50cyvDty92qIqiIj3LB889MIO/6FJQCChmhz/+oaI=;
 b=q+StSpLkJPuNgXt+BmMqG9Rq+oHsecJOFRZPAkdF4yEWIpy+wrLo8ixBTtBqG8FUHP
 SlHaU72HZo4M5N8qgd4LiTq/hiUrw+GHysgeHLsZ+BhCCPlhQMEGVoLylzSLy67Gzmn4
 dttBcF78wOquCf2cf8pJHzfFw+UajpPlFT/51I3r6CGlbwcXO4BtSe3AnoiTc/XRW21q
 QWpMmpiWuLj9XqCDY4DBX77QB3HzYsvalo4CfPqFL4I4/bxvQGUzrIbJHOeN65stbVME
 KzpArGVmd1vT3kxvS5ahGzwl8F7Hw0ORM4DuzDHjbtSQJ+A8dlThuCEvM5859L5CFwyz
 e3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738053870; x=1738658670;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:to:from:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Xn50cyvDty92qIqiIj3LB889MIO/6FJQCChmhz/+oaI=;
 b=FiFfb3lujEks6lKrCtEBGs18JeXrQgHA4U/NNVaQVlsJ+UkWIHHmDS/owaUfP4crl4
 tegF67iytmhCf3Mhyw+jTDrq28sn8Lm4r/WopBvuRLfyPK8vCmr8cT16xzdLWGGPgGsG
 g2H+9cMGxWuXh3nKmnt6sZySTupuOQPMc3Zx/SNJHwHTqAeFN/1vz3I5hRDJeUfKq9Vl
 V3vOIPQmwhJMgdGwKeq8xD+DIIkYhc+YyYR4WbcMmEFqgJf1TB1uYQK1CZUIYptfs9OM
 b7N9eKCt88gTW4Od6QfU4kEooJLDOJJULqdKvN6wlcZ2wApQfWqbmVk0HnZcfuHUcXHX
 eT5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3+SXahxcXckcsLqeMyTUAeZ+F28KlPnNPfShxVFMUq/RH6WbW1HO+FETj4qvxwCDe3vu2lJ0=@lists.denx.de
X-Gm-Message-State: AOJu0YxxJx5nlScSlM7onA7ylQYWkMLHJiNudvb+u2epml6c1eh0Y7kx
 I8jyIOivaJdCcQFTL+KCbgjKEd6v/StYkAP0vJ3KDhXg55bRr5IAtTc8T4FV+mWnsloPCj+CEXk
 n
X-Gm-Gg: ASbGncs52uTRqwkzu13mG1koxYcPAY+rv0mQwNGoL26ujF+o9NYoeEVklQmXDacECxP
 BQWvTZnvaJWq83olaegpH6fM86+O4xPhQ1utC6t8DBLyFenV9F3lqY7f60IO4BCogzasdp1Otpz
 RhRCVDlaX5YcobleZXv3iNTOPMMNhGEGpzLP/ptY0g+B97ZZreNa3auP53Y5NLdEqEkSci9q8Jn
 JC6OwgtyAKt+qArOjB7Nm5lBrYmPzLgkbKdIcCzjxu/gPO55NaYkrJU5PPemHzdHCQlHxCc+mfi
 PnW8MHj/fy2dfFjiq9QzumzV
X-Google-Smtp-Source: AGHT+IFE9BgFPHKCwAc5XC+x77Pegrlnhm2xAUPG/1sAksz7ae/0HbmJPwjnvCxvMJZf6x58eHhsvw==
X-Received: by 2002:a05:6000:1863:b0:38a:8d32:274e with SMTP id
 ffacd0b85a97d-38bf56551famr35807465f8f.5.1738053870113; 
 Tue, 28 Jan 2025 00:44:30 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c403asm13687125f8f.93.2025.01.28.00.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 00:44:29 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Federico Fuga <fuga@studiofuga.com>, Tom Rini <trini@konsulko.com>,
 Federico Fuga <fuga@studiofuga.com>, Maxime Ripard <maxime@cerno.tech>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] Fix fastboot handling of partitions when no slots are,
 supported
In-Reply-To: <a70b19e6-4436-4fcf-bebd-b6877b66779e@studiofuga.com>
References: <a70b19e6-4436-4fcf-bebd-b6877b66779e@studiofuga.com>
Date: Tue, 28 Jan 2025 09:44:28 +0100
Message-ID: <874j1js4yb.fsf@baylibre.com>
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

On ven., janv. 24, 2025 at 11:49, Federico Fuga <fuga@studiofuga.com> wrote:

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
>  =C2=A02: kernel =C2=A0=C2=A0 =C2=A0=C2=A0 0x00400000=C2=A0=C2=A0=C2=A0=
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

Unfortunately, I'm unable to apply this. I've tried using b4 and via git am.

$ b4 shazam -s -l --check a70b19e6-4436-4fcf-bebd-b6877b66779e@studiofuga.c=
om

Grabbing thread from lore.kernel.org/all/a70b19e6-4436-4fcf-bebd-b6877b6677=
9e@studiofuga.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 2 messages in the thread
Assuming new revision: v2 ([PATCH] Fix fastboot handling of partitions when=
 no slots are, supported)
Analyzing 0 code-review messages
Will use the latest revision: v2
You can pick other revisions using the -vN flag
Checking attestation on all messages, may take a moment...
---
  [PATCH] Fix fastboot handling of partitions when no slots are, supported
    + Link: https://lore.kernel.org/r/add4f6ac-3dd5-4707-a40c-a41191e62912@=
studiofuga.com
    + Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Traceback (most recent call last):
  File "/mnt/work/upstream/b4/src/b4/command.py", line 435, in <module>
    cmd()
    ~~~^^
  File "/mnt/work/upstream/b4/src/b4/command.py", line 417, in cmd
    cmdargs.func(cmdargs)


Downloading the thread from this patchwork link (clicking on "mbox"):
https://patchwork.ozlabs.org/project/uboot/patch/a70b19e6-4436-4fcf-bebd-b6=
877b66779e@studiofuga.com/

$ git am Fix-fastboot-handling-of-partitions-when-no-slots-are-supported.pa=
tch
Applying: Fix fastboot handling of partitions when no slots are, supported
error: corrupt patch at line 13
error: could not build fake ancestor
Patch failed at 0001 Fix fastboot handling of partitions when no slots are,=
 supported
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort=
".
hint: Disable this message with "git config advice.mergeConflict false"

Can you please confirm that you are able to apply it yourself?
Maybe the email client is misconfigured somehow?

I've also tried to apply the one that has been send yesterday
(https://patchwork.ozlabs.org/project/uboot/patch/add4f6ac-3dd5-4707-a40c-a=
41191e62912@studiofuga.com/)
but I'm encountering the same problem.

> ---
>  =C2=A0drivers/fastboot/fb_getvar.c | 5 ++++-
>  =C2=A0drivers/fastboot/fb_nand.c=C2=A0=C2=A0 | 2 +-
>  =C2=A02 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
> index 93cbd598e0..f5d8b03301 100644
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
> diff --git a/drivers/fastboot/fb_nand.c b/drivers/fastboot/fb_nand.c
> index 5a55144479..3ee0f40ea8 100644
> --- a/drivers/fastboot/fb_nand.c
> +++ b/drivers/fastboot/fb_nand.c
> @@ -141,7 +141,7 @@ static lbaint_t fb_nand_sparse_reserve(struct=20
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
