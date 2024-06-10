Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB34C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 16:22:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82A428862C;
	Mon, 10 Jun 2024 18:22:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B0UOozAM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E9318863B; Mon, 10 Jun 2024 18:22:44 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3D2B885FB
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 18:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4218e647d62so481435e9.3
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 09:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718036561; x=1718641361; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mqcdeTPMFOI1ODRTjneJbpAdNiTTAPd9Dh4TRhZbl00=;
 b=B0UOozAM23GW3nq/jGALOwVbX3UmjDxYh0zTTyhqZHHgqRG506WnfptPRpwFVrED4k
 5KFixznAlYTsQziO9zzOd3kBScSckcT+o9GGGMYmejzpEORjN+ly7b+SERAc081TnZtb
 jXEp0rSEv9Cx7v5YggEdAUxYtvABn+4OAEk9X01LY3SIzRs5FyzSnaad9G2vs6x51cQg
 fBnfPdOBRfz3zQ1k0oJgudFXG0Ju9sT4vvTP3PebfFsnvADpQ0CbpSWSiMkCxUQVch0M
 2yn79K5YK66AneefiYUXhC8hNKzPT7MfK8/CDUPHkBq8Lh+FGtLoFcZm2/ZlrTV+vsOa
 x2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718036561; x=1718641361;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mqcdeTPMFOI1ODRTjneJbpAdNiTTAPd9Dh4TRhZbl00=;
 b=uxMcHwSVIhku7msoIdbOV33lDZ8l5MIbucWOZgAgJU/soOwXRveTDdSwPk0EhY5+9Z
 vLp/c+aSxfCboDEZfnUcLRTr9vkJ5OtoFyAfw8J2NDdaN6yMKYEKyqGFPcmdI10vRoys
 3e39w32bVBOrUy1I81LUWslRMNfSigmRu6Oj/2jka1fsDHFNmOGfB7q2kwS/xLaSwVSF
 vTtkc0XF5G1DrPgLvcfQjQztUTuBY2Aux6wKAVBNhyNrr+8C27hjnyFWoMG5erDAIR0X
 3PxLSyaRWAgyzZKlmn3IS8t/ov8CiBuYN6I5QfDJfNwmiDFDghSowVFqeGldI3/XpI+1
 9ONw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa/YA9m2tSkBzY+Ofon3+BlmRnq3y3syVmmJ+wZLghsPVH3m+1WM6bHVrxedhi72qI5AObowwsAl1h+7sheqdl3sCHVQ==
X-Gm-Message-State: AOJu0Yy+WkqO84L0IwGIotZ1eB/ZsUS73xzRmYzCVhCv6QWUKnvwigyx
 CM5KnMk7Ct5xRGapsSy4mcUIL1lgqGTcWSCJgePed648Rj7TmFS3lHLuPVLodYOVnO9VPgy4wJK
 lINKUC1fHSAHyaK0gdioI2D9Targ=
X-Google-Smtp-Source: AGHT+IG0S5iwWisIT+tFzb8icC+vH/RfFi4TbUq5R/mVLoFkFcp9yLW9VUWyUSmzexftjXwnL7napEqQea/kkbizc7I=
X-Received: by 2002:a05:600c:17c3:b0:421:7dc3:99ff with SMTP id
 5b1f17b1804b1-4217dc39e3emr41996945e9.3.1718036561214; Mon, 10 Jun 2024
 09:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240519191856.2582174-1-r.stratiienko@gmail.com>
 <20240519191856.2582174-3-r.stratiienko@gmail.com>
In-Reply-To: <20240519191856.2582174-3-r.stratiienko@gmail.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Mon, 10 Jun 2024 18:22:30 +0200
Message-ID: <CAByghJa+ZzkzdzCi8CnaHcZc8ZqkHCYt-isEK6C-1o7M91g+jQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] avb: Implement get_preloaded_partition callback
To: Roman Stratiienko <r.stratiienko@gmail.com>
Cc: mkorpershoek@baylibre.com, dsimic@manjaro.org, sjg@chromium.org, 
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, eajames@linux.ibm.com, 
 marek.vasut+renesas@mailbox.org, paulerwan.rio@gmail.com, 
 u-boot@lists.denx.de
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

Hi Roman,

On Sun, May 19, 2024 at 9:19=E2=80=AFPM Roman Stratiienko
<r.stratiienko@gmail.com> wrote:
>
> AVB can reuse already loaded images instead of loading them
> from the disk.
>
> The get_preloaded_partition now looks for the env. variables
> set by the 'abootimg load' to find the correct partition in RAM.
>
> Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> ---
>  common/avb_verify.c | 53 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/common/avb_verify.c b/common/avb_verify.c
> index cff9117d92..d2626e8844 100644
> --- a/common/avb_verify.c
> +++ b/common/avb_verify.c
> @@ -6,6 +6,7 @@
>  #include <avb_verify.h>
>  #include <blk.h>
>  #include <cpu_func.h>
> +#include <env.h>
>  #include <image.h>
>  #include <malloc.h>
>  #include <part.h>
> @@ -595,6 +596,55 @@ static AvbIOResult read_from_partition(AvbOps *ops,
>                            num_bytes, buffer, out_num_read, IO_READ);
>  }
>
> +#ifdef CONFIG_ANDROID_BOOT_IMAGE
Please use CONFIG_IS_ENABLED() macro
> +/**
> + * get_preloaded_partition() - Gets the starting pointer of a partition =
that
> + * is pre-loaded in memory, and save it to |out_pointer|.
> + *
> + * If the partition is not pre-loaded in memory, the out_pointer shall n=
ot be
> + * modified.
> + *
> + * @ops: contains AVB ops handlers
> + * @partition: partition name, NUL-terminated UTF-8 string
> + * @num_bytes: amount of bytes to read
> + * @out_pointer: pointer to the starting address of the partition
> + * @out_num_bytes_preloaded: amount of bytes pre-loaded in memory
> + *
> + * @return:
Please follow [1]. I know that the whole file has this type of issues,
I plan to fix it in the near future.

[1] https://www.kernel.org/doc/html/next/doc-guide/kernel-doc.html.

Should be "Return: AVB_IO_RESULT_OK, if partition was found or was not foun=
d"
> + *      AVB_IO_RESULT_OK, if partition was found or was not found
> + *
> + */
> +static AvbIOResult get_preloaded_partition(AvbOps *ops, const char *part=
ition, size_t num_bytes,
> +                                          uint8_t **out_pointer, size_t =
*out_num_bytes_preloaded)
> +{
> +       size_t partition_start =3D 0;
> +       size_t partition_size =3D 0;
> +       char env_name[64];
> +
> +       sprintf(env_name, "abootimg_%s_ptr", partition);
Please use more secure version snprintf()
> +       partition_start =3D env_get_hex(env_name, 0);
> +
> +       sprintf(env_name, "abootimg_%s_size", partition);
> +       partition_size =3D env_get_hex(env_name, 0);
> +
> +       if (partition_start =3D=3D 0 || partition_size =3D=3D 0)
> +               return AVB_IO_RESULT_OK;
> +
> +       if (partition_size < num_bytes) {
> +               printf("AVB: Preloaded partition %s size %zu is smaller t=
han requested %zu\n",
> +                      partition, partition_size, num_bytes);
> +               return AVB_IO_RESULT_ERROR_IO;
> +       }
> +
> +       *out_pointer =3D (uint8_t *)partition_start;
> +       *out_num_bytes_preloaded =3D partition_size;
> +
> +       printf("AVB: Using preloaded partition %s at %p\n", partition, *o=
ut_pointer);
> +
> +       return AVB_IO_RESULT_OK;
> +}
> +#endif
> +
>  /**
>   * write_to_partition() - writes N bytes to a partition identified by a =
string
>   * name
> @@ -1043,6 +1093,9 @@ AvbOps *avb_ops_alloc(int boot_device)
>         ops_data->ops.user_data =3D ops_data;
>
>         ops_data->ops.read_from_partition =3D read_from_partition;
> +#ifdef CONFIG_ANDROID_BOOT_IMAGE
Please use CONFIG_IS_ENABLED() macro
> +       ops_data->ops.get_preloaded_partition =3D get_preloaded_partition=
;
> +#endif
>         ops_data->ops.write_to_partition =3D write_to_partition;
>         ops_data->ops.validate_vbmeta_public_key =3D validate_vbmeta_publ=
ic_key;
>         ops_data->ops.read_rollback_index =3D read_rollback_index;
> --
> 2.40.1
>


--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
https://www.linkedin.com/in/iopaniuk
