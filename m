Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A83C48BF6
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 19:14:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FDD8880F8;
	Thu, 29 Feb 2024 20:14:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AqzMlpxx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB192880EC; Thu, 29 Feb 2024 20:14:23 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65CBE880F8
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 20:14:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5131e21b966so138237e87.0
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 11:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709234061; x=1709838861; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cMbg+2hWM0IWOJXJxqcK3XvEbcUkDTrsU3c5+TYLA5w=;
 b=AqzMlpxxHytzvK0fZmX6ykeyt/eJxWOirU0/lpaCiK0dwozgz1FeYCNufuWFP0UYVt
 aNjkBDbNZEuAgW9adSy1tBEauNdo1A/raTNd2a954TVLp7O55aGcBNGk1RqUTi3quj3p
 zl6HKvWEvWta0/jkRCW/sTvN6ioahqZ3mrQQDtIysm5R+8faDTck2pDgyMoyuaK3z7In
 WSK2hgYbkNKgp5mQkBA94WwgPxMGfAyoRfmyNLTuQ4jsp3szmoo1kc5vlsY4b2u1Zwf3
 o9tRZwxVy208QCPYrXYGJ4Ae+f3LBquKCKXoK+q8ANvIrTwkA3OsOuUoGusNMoKiqv2p
 lLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709234061; x=1709838861;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cMbg+2hWM0IWOJXJxqcK3XvEbcUkDTrsU3c5+TYLA5w=;
 b=ObRHETFe5ZVC5WxXcundSmnyWJWKbjuQqEFB5XybwoLV5e/sBCV5LLWt65vnHfT2p6
 Q+QdY2FFmhlg+UxZObY6bFn9Mwl+lERbsoGEo5GTT4I5G4L03bn76B3dvrGF/4zyCpRb
 zlxVV3HKFZwxbLiHM+AIX6WTDFcb01s9Qn+lnNK5VdusGa+zBLFbGB7KXnBB53WdOVVg
 rT/m8K4ESK8u5Y1lgy/y18ODPZcLmOuR9r0f/c+fIzflqu2NXcZCtJd3+sJ6ocVhRjiv
 +sB/HvtCELyrY5e6/MKKPsibfuFhFc6LD+Z/MXtHqlteD7tP17r/ro40/WeKSTNFOEHW
 TVAA==
X-Gm-Message-State: AOJu0YxIjiAtaoBq+yvQl47ulj+y/ljDxryKh7mNxMKXjIMwvfHHLNqJ
 /STqG3HUHYdKmbxFr0iyh1ZWVWRQxgCGUVBLvrpziRWIOvdPpw1XU+cLQyo875Ag6L7QX3xe13G
 DFpF+IkXe0rAOI5D10i4TEWJQZrhXMvmp2gU=
X-Google-Smtp-Source: AGHT+IHZhSrIGAX+IM6Co9F1/3NRS45YUv8JGBD1Y+1rR8PhssMSnIHJQeo/Ihn9S6mj58b9Lv/dLv9PmfoNy1tjV1g=
X-Received: by 2002:ac2:4c13:0:b0:512:a95a:98c6 with SMTP id
 t19-20020ac24c13000000b00512a95a98c6mr2368691lfq.5.1709234060327; Thu, 29 Feb
 2024 11:14:20 -0800 (PST)
MIME-Version: 1.0
References: <20240211185616.1041356-1-igor.opaniuk@foundries.io>
In-Reply-To: <20240211185616.1041356-1-igor.opaniuk@foundries.io>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Thu, 29 Feb 2024 20:14:08 +0100
Message-ID: <CAByghJbCGg1eKe5qC9YRfu5ko9FKsMgwbOZ8CK-NaB-f5kfpjA@mail.gmail.com>
Subject: Re: [PATCH v1] cmd: md5sum: use hash_command
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Igor Opaniuk <igor.opaniuk@foundries.io>
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

Hello Tom,

On Sun, Feb 11, 2024 at 7:56=E2=80=AFPM Igor Opaniuk <igor.opaniuk@foundrie=
s.io>
wrote:

> From: Igor Opaniuk <igor.opaniuk@gmail.com>
>
> Drop old implementation and use hash_command() instead, as
> how it's currently done for crc32 and sha1sum cmds.
>
> Test:
> =3D> md5sum 0x60000000 0x200
> md5 for 60000000 ... 600001ff =3D=3D> e6bbbe95f5b41996f4a9b9af7bbd4050
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
> ---
>
>  cmd/md5sum.c | 149 ++++-----------------------------------------------
>  1 file changed, 9 insertions(+), 140 deletions(-)
>
> diff --git a/cmd/md5sum.c b/cmd/md5sum.c
> index 0f0e1d3dd68..618265e8d50 100644
> --- a/cmd/md5sum.c
> +++ b/cmd/md5sum.c
> @@ -7,7 +7,6 @@
>   * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>   */
>
> -#include <common.h>
>  #include <command.h>
>  #include <env.h>
>  #include <image.h>
> @@ -15,158 +14,28 @@
>  #include <u-boot/md5.h>
>  #include <asm/io.h>
>
> -/*
> - * Store the resulting sum to an address or variable
> - */
> -static void store_result(const u8 *sum, const char *dest)
> -{
> -       unsigned int i;
> -
> -       if (*dest =3D=3D '*') {
> -               u8 *ptr;
> -
> -               ptr =3D (u8 *)hextoul(dest + 1, NULL);
> -               for (i =3D 0; i < 16; i++)
> -                       *ptr++ =3D sum[i];
> -       } else {
> -               char str_output[33];
> -               char *str_ptr =3D str_output;
> -
> -               for (i =3D 0; i < 16; i++) {
> -                       sprintf(str_ptr, "%02x", sum[i]);
> -                       str_ptr +=3D 2;
> -               }
> -               env_set(dest, str_output);
> -       }
> -}
> -
> -#ifdef CONFIG_MD5SUM_VERIFY
> -static int parse_verify_sum(char *verify_str, u8 *vsum)
> -{
> -       if (*verify_str =3D=3D '*') {
> -               u8 *ptr;
> -
> -               ptr =3D (u8 *)hextoul(verify_str + 1, NULL);
> -               memcpy(vsum, ptr, 16);
> -       } else {
> -               unsigned int i;
> -               char *vsum_str;
> -
> -               if (strlen(verify_str) =3D=3D 32)
> -                       vsum_str =3D verify_str;
> -               else {
> -                       vsum_str =3D env_get(verify_str);
> -                       if (vsum_str =3D=3D NULL || strlen(vsum_str) !=3D=
 32)
> -                               return 1;
> -               }
> -
> -               for (i =3D 0; i < 16; i++) {
> -                       char *nullp =3D vsum_str + (i + 1) * 2;
> -                       char end =3D *nullp;
> -
> -                       *nullp =3D '\0';
> -                       *(u8 *)(vsum + i) =3D
> -                               hextoul(vsum_str + (i * 2), NULL);
> -                       *nullp =3D end;
> -               }
> -       }
> -       return 0;
> -}
> -
> -int do_md5sum(struct cmd_tbl *cmdtp, int flag, int argc, char *const
> argv[])
> +static int do_md5sum(struct cmd_tbl *cmdtp, int flag, int argc,
> +                    char *const argv[])
>  {
> -       ulong addr, len;
> -       unsigned int i;
> -       u8 output[16];
> -       u8 vsum[16];
> -       int verify =3D 0;
> +       int flags =3D HASH_FLAG_ENV;
>         int ac;
> -       char * const *av;
> -       void *buf;
> +       char *const *av;
>
>         if (argc < 3)
>                 return CMD_RET_USAGE;
>
>         av =3D argv + 1;
>         ac =3D argc - 1;
> -       if (strcmp(*av, "-v") =3D=3D 0) {
> -               verify =3D 1;
> +       if (IS_ENABLED(CONFIG_MD5SUM_VERIFY) && strcmp(*av, "-v") =3D=3D =
0) {
> +               flags |=3D HASH_FLAG_VERIFY;
>                 av++;
>                 ac--;
> -               if (ac < 3)
> -                       return CMD_RET_USAGE;
>         }
>
> -       addr =3D hextoul(*av++, NULL);
> -       len =3D hextoul(*av++, NULL);
> -
> -       buf =3D map_sysmem(addr, len);
> -       md5_wd(buf, len, output, CHUNKSZ_MD5);
> -       unmap_sysmem(buf);
> -
> -       if (!verify) {
> -               printf("md5 for %08lx ... %08lx =3D=3D> ", addr, addr + l=
en -
> 1);
> -               for (i =3D 0; i < 16; i++)
> -                       printf("%02x", output[i]);
> -               printf("\n");
> -
> -               if (ac > 2)
> -                       store_result(output, *av);
> -       } else {
> -               char *verify_str =3D *av++;
> -
> -               if (parse_verify_sum(verify_str, vsum)) {
> -                       printf("ERROR: %s does not contain a valid md5
> sum\n",
> -                               verify_str);
> -                       return 1;
> -               }
> -               if (memcmp(output, vsum, 16) !=3D 0) {
> -                       printf("md5 for %08lx ... %08lx =3D=3D> ", addr,
> -                               addr + len - 1);
> -                       for (i =3D 0; i < 16; i++)
> -                               printf("%02x", output[i]);
> -                       printf(" !=3D ");
> -                       for (i =3D 0; i < 16; i++)
> -                               printf("%02x", vsum[i]);
> -                       printf(" ** ERROR **\n");
> -                       return 1;
> -               }
> -       }
> -
> -       return 0;
> -}
> -#else
> -static int do_md5sum(struct cmd_tbl *cmdtp, int flag, int argc,
> -                    char *const argv[])
> -{
> -       unsigned long addr, len;
> -       unsigned int i;
> -       u8 output[16];
> -       void *buf;
> -
> -       if (argc < 3)
> -               return CMD_RET_USAGE;
> -
> -       addr =3D hextoul(argv[1], NULL);
> -       len =3D hextoul(argv[2], NULL);
> -
> -       buf =3D map_sysmem(addr, len);
> -       md5_wd(buf, len, output, CHUNKSZ_MD5);
> -       unmap_sysmem(buf);
> -
> -       printf("md5 for %08lx ... %08lx =3D=3D> ", addr, addr + len - 1);
> -       for (i =3D 0; i < 16; i++)
> -               printf("%02x", output[i]);
> -       printf("\n");
> -
> -       if (argc > 3)
> -               store_result(output, argv[3]);
> -
> -       return 0;
> +       return hash_command("md5", flags, cmdtp, flag, ac, av);
>  }
> -#endif
>
> -#ifdef CONFIG_MD5SUM_VERIFY
> +#if IS_ENABLED(CONFIG_MD5SUM_VERIFY)
>  U_BOOT_CMD(
>         md5sum, 5,      1,      do_md5sum,
>         "compute MD5 message digest",
> @@ -182,4 +51,4 @@ U_BOOT_CMD(
>         "address count [[*]sum]\n"
>                 "    - compute MD5 message digest [save to sum]"
>  );
> -#endif
> +#endif /* IS_ENABLED(CONFIG_MD5SUM_VERIFY) */
> --
> 2.34.1
>
>
Are there currently any objections that can prevent these cosmetic
cleanup from being applied? If there are any - just let me know, thanks

--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
http://ua.linkedin.com/in/iopaniuk
