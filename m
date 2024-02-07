Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40E6C4828D
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 17:31:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FADF87C00;
	Wed,  7 Feb 2024 18:31:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zib5V8HR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE0A587C8F; Wed,  7 Feb 2024 18:31:20 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8624187B05
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 18:31:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33ad9ec3ec2so186715f8f.1
 for <u-boot@lists.denx.de>; Wed, 07 Feb 2024 09:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707327078; x=1707931878; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6FPWVvQ1HpCxGcapU3HMaitr4gOFgm5KWk1cy2mMF7s=;
 b=Zib5V8HR5JoD+7hc323PmQsqh4BZiPvErjKopfdYse8X7RfoYDaYnW4exrGGw6Z6y1
 5OOYnyaKe1bg0+ISTB/mxmKCqLKmga54T/cr5aW3odoQP4ytFlKdEBRtzURQ2zuB838m
 cornzzF6oq0jQGNWLLhPHxc4hxDMzaoZht0q49s8Z6w+lU1Q8mxjp4oPL0E9jqIlez2b
 p0BVEbFogxbWsfuWv1J7ENRgAEBZUpJeIwvXHTT5nkv4i7cMEsJkfIEqceDXFAdUyuZa
 o7YknBqAJGCBkLSmM6OlRmkjHuoexxElOg0NriESqVJ4ZzmnezDVJdfCiht97wLj4myu
 vCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707327078; x=1707931878;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6FPWVvQ1HpCxGcapU3HMaitr4gOFgm5KWk1cy2mMF7s=;
 b=A7z2PpZE3GtixrYbPRi+gpkWwx3jjTAV5trpANt4MU5YbiMeEOUABvT9tShmckZU85
 Y0iDLz0wseuhYBLVWzKhfIHiIo2wzij8eoMRVsKiZmwfEZllPkECi71GazTV1u8lR3lf
 wpAyZAHntjWAkli4DoAjMfxIG0Q5EStil9gu0fPrYTEMsVA3XBExonKNfcu8c+w4dveD
 MaaJU5Wa3NpD3g+rieMbK1n5vJqlXt9/fvhBeXelfJIxXYcvGbfr/xqT2OMEasssnjzN
 KD/G1A6oOyhMGLnQCuKtcTHVlQ19LbT9P7C3ke2W4PVjNmlP32lDUj0ZlTiEG6njYFGp
 feAA==
X-Gm-Message-State: AOJu0YxgIM9JUz6xYiAovFIDJ3B+oViHSAD70/VIb+LOoW4lkBm1ZG06
 o2JJY99Ikxm+DQW6TPqbjNtaVl9HfjQR2TFWA5+IB+YvP9Px1H2bcd27O0eGd2wPjS6jLFl8epr
 TNUJvNdtqkMKLb+qngD02VwZHmgJJ7sZU4CVnG8vd
X-Google-Smtp-Source: AGHT+IGyEeTqF1EKWv44xLx2xOVtQUERCOcmavDkqB1OEisH3a52RDnhDxi61Avr5EXox4RbNdDA5clJIKE0ErKrcEc=
X-Received: by 2002:a5d:4f02:0:b0:33b:5197:7136 with SMTP id
 c2-20020a5d4f02000000b0033b51977136mr995875wru.2.1707327077539; Wed, 07 Feb
 2024 09:31:17 -0800 (PST)
MIME-Version: 1.0
References: <20240207000132.3116094-1-igor.opaniuk@foundries.io>
In-Reply-To: <20240207000132.3116094-1-igor.opaniuk@foundries.io>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Wed, 7 Feb 2024 18:31:05 +0100
Message-ID: <CAByghJZo9Gu4aeenjR3CLyWG5bLavDGbwm7MhSZwam6aiLJY2Q@mail.gmail.com>
Subject: Re: [PATCH v1] cmd: hash: fix param count check
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

Hi Tom,

On Wed, Feb 7, 2024 at 1:01=E2=80=AFAM Igor Opaniuk <igor.opaniuk@foundries=
.io> wrote:
>
> From: Igor Opaniuk <igor.opaniuk@gmail.com>
>
> Add correct check for parameter count.
>
> This fixes this issue when `hash` cmd is invoked without params:
>
> =3D> hash
> data abort
> pc : [<bf739204>]          lr : [<ba6effa8>]
> reloc pc : [<60019204>]    lr : [<5afcffa8>]
> sp : ba6dd9c8  ip : bf7391f0     fp : bf74ec14
> r10: 00000001  r9 : ba6dfea0     r8 : bf7ea030
> r7 : 00000000  r6 : ba6effa8     r5 : 00000000  r4 : ffffffff
> r3 : bf7c257c  r2 : 00000001     r1 : 00000000  r0 : bf7e6e34
> Flags: nZCv  IRQs off  FIQs on  Mode SVC_32
> Code: e5934004 e1a0e003 e59f3050 e2444001 (e5f4c001)
> Resetting CPU ...
>
> resetting ...
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
> ---
>
>  cmd/hash.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/cmd/hash.c b/cmd/hash.c
> index e163cd67742..5534a735fa7 100644
> --- a/cmd/hash.c
> +++ b/cmd/hash.c
> @@ -14,15 +14,22 @@
>  #include <hash.h>
>  #include <linux/ctype.h>
>
> +#if IS_ENABLED(CONFIG_HASH_VERIFY)
> +#define HARGS 6
> +#else
> +#define HARGS 5
> +#endif
> +
>  static int do_hash(struct cmd_tbl *cmdtp, int flag, int argc,
>                    char *const argv[])
>  {
>         char *s;
>         int flags =3D HASH_FLAG_ENV;
>
> -#ifdef CONFIG_HASH_VERIFY
> -       if (argc < 4)
> +       if (argc < (HARGS - 1))
>                 return CMD_RET_USAGE;
> +
> +#if IS_ENABLED(CONFIG_HASH_VERIFY)
>         if (!strcmp(argv[1], "-v")) {
>                 flags |=3D HASH_FLAG_VERIFY;
>                 argc--;
> @@ -37,18 +44,12 @@ static int do_hash(struct cmd_tbl *cmdtp, int flag, i=
nt argc,
>         return hash_command(*argv, flags, cmdtp, flag, argc - 1, argv + 1=
);
>  }
>
> -#ifdef CONFIG_HASH_VERIFY
> -#define HARGS 6
> -#else
> -#define HARGS 5
> -#endif
> -
>  U_BOOT_CMD(
>         hash,   HARGS,  1,      do_hash,
>         "compute hash message digest",
>         "algorithm address count [[*]hash_dest]\n"
>                 "    - compute message digest [save to env var / *address=
]"
> -#ifdef CONFIG_HASH_VERIFY
> +#if IS_ENABLED(CONFIG_HASH_VERIFY)
>         "\nhash -v algorithm address count [*]hash\n"
>                 "    - verify message digest of memory area to immediate =
value, \n"
>                 "      env var or *address"
> --
> 2.34.1
>

This is a fix, however I haven't added the "Fixes: " tag as I could not fin=
d
the commit which introduces this cmd (it seems it was added before
U-Boot moved to git).

For the next merge window I'll refactor all hash cmds as we discussed
in my previous email [1]

[1] https://lore.kernel.org/u-boot/CALeDE9MDJZjtMDhbg-vfis1E5uVfYn4WwD1hoPg=
YWxRiPfjwGQ@mail.gmail.com/T/#t

--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
http://ua.linkedin.com/in/iopaniuk
