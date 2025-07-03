Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E963C83F03
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 16:01:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8EE982063;
	Thu,  3 Jul 2025 18:01:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q0wVIjs5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61D6B8206E; Thu,  3 Jul 2025 18:01:55 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 315B480E9A
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 18:01:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2f75f1c7206so52788fac.0
 for <u-boot@lists.denx.de>; Thu, 03 Jul 2025 09:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751558512; x=1752163312; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R3iRVNlMLS6uNAv4AIsW2p0kH0FxIdREaLVi432e/qU=;
 b=Q0wVIjs5zQJ6MaJn/iFsDRW0WC+HeOaSnFXosAMhJEf8/Uc2vdp/nghro6f3xHZfW2
 yiywSv2quUpuPMK6iv+VAXCSGRjQb37Tn/TTCG2Wcm1R+2mf2I0vadVK6pX1SLoWh8DS
 q4cIVSq9BtOk40UBKDm5S/6Vxg1ed2esjN0V/7QBco5qgeIc0NEFghwrcfHoX412Z+Oj
 7RgHQx6IU9Qd1iAALRGB2Vo/43xw5eu9T8JV+X1zgCFlsK4mNmOfZqA8L22P7T55Hdu3
 5kOF7Cbptam1ST6WdjURglnIcFxrAuXu4L1iaZoSLBke9qXQVhu/d33pfYSz//8Vgj5P
 xjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751558512; x=1752163312;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R3iRVNlMLS6uNAv4AIsW2p0kH0FxIdREaLVi432e/qU=;
 b=FO2/2K+qnqSNyZasVrOifDUY5xFoqw6bN5VfgrRGDK57EqbVOkOjjF2/o9tucTp8ku
 VF9iCQD9qW2R8t4CnxPkt19C85Ral8/9ErNBuVxG/W0kJmQHPgGIkYHrdnXNRGGvAOzZ
 qa/d1LxXxY9q2G5TDcl7HPAQkoGFaRt4hqYhnqTuJLr+w9WyINZ3SwkBzY/d9iu9fGDj
 9FNI/2FfytyqJYEbAIxBcOcyShugrAt/e4sdhy3CkixGGaEty7pMje73t+KtHITAdj7F
 5/uOd3gY+Bdm4kmud5lMS1aYFW6uTuxllDTzF+fHuvfTr6HvVb67UUakyMxQqHjIAp8u
 SO3g==
X-Gm-Message-State: AOJu0YwWtEBDrSyldYABPve/m5YwOupj9Vw32BTo9dziLKWgQICn7PvF
 tqvIyNprZfLY9i3A8PQtdr3f3ipNNg6VfBiNTt2madCSkihaWPr08ywQLxFi8tWYBD0762/45G4
 HujXij1OiyKBwgu2KrG6fe9d9k3SIX4pTtKeAmZn+Hg==
X-Gm-Gg: ASbGncuOTCKtgNR73BkAlzqtDjHAVg7+GKbM2TAEdZiM4In2Y2KuBDTUPKMBfn8RaOS
 rDV8FqPgMRC+1bOFQ7xLlSUCQKF2sulHfFY52tCMjgtXogXwI2z++ARxNhZRJ2RAvHmfoScBur2
 Gx2t9rpGLyh6bAM+Qq37SeJBBua0UfxNf5/8s4dhSqi40bLtE/dvSr3A==
X-Google-Smtp-Source: AGHT+IHerYZ+epBiUA/JvtuGuns7kSwmpQ23QxgDIbUqy9vNH4xjiadYnoczaJ87bflPxJxeO/p6Og9ISCHZc2R/3ZU=
X-Received: by 2002:a05:6870:6241:b0:29e:503a:7ea3 with SMTP id
 586e51a60fabf-2f76ca7daf2mr2785852fac.36.1751558505903; Thu, 03 Jul 2025
 09:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250702010603.19354-1-trini@konsulko.com>
 <20250702010603.19354-2-trini@konsulko.com>
In-Reply-To: <20250702010603.19354-2-trini@konsulko.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 3 Jul 2025 11:01:34 -0500
X-Gm-Features: Ac12FXzKRpQAF11deelthTs1rKL6FKA2RhRrAmiTvvx4XSre1SdkKSbPNrbRyko
Message-ID: <CAPLW+4npaTz1pVK4ECd62VVVhFTMdvwxTsR=bBsx_B8L2tXbJw@mail.gmail.com>
Subject: Re: [PATCH 2/2] common/avb_verify.c: Make use of LBAF for printing
 lbaint_t
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>
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

On Tue, Jul 1, 2025 at 8:06=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> When printing the contents of an lbaint_t variable we need to use LBAF
> to print it in order to get the correct format type depending on 32 or
> 64bit-ness.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Igor Opaniuk <igor.opaniuk@gmail.com>
> Cc: Sam Protsenko <semen.protsenko@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  common/avb_verify.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/common/avb_verify.c b/common/avb_verify.c
> index cff9117d92f1..29a3272579cf 100644
> --- a/common/avb_verify.c
> +++ b/common/avb_verify.c
> @@ -320,7 +320,7 @@ static unsigned long mmc_read_and_flush(struct mmc_pa=
rt *part,
>         }
>         if ((start + sectors) > (part->info.start + part->info.size)) {
>                 sectors =3D part->info.start + part->info.size - start;
> -               printf("%s: read sector aligned to partition bounds (%ld)=
\n",
> +               printf("%s: read sector aligned to partition bounds (" LB=
AF ")\n",
>                        __func__, sectors);
>         }
>
> @@ -363,7 +363,7 @@ static unsigned long mmc_write(struct mmc_part *part,=
 lbaint_t start,
>         }
>         if ((start + sectors) > (part->info.start + part->info.size)) {
>                 sectors =3D part->info.start + part->info.size - start;
> -               printf("%s: sector aligned to partition bounds (%ld)\n",
> +               printf("%s: sector aligned to partition bounds (" LBAF ")=
\n",
>                        __func__, sectors);
>         }
>         if (unaligned) {
> --
> 2.43.0
>
