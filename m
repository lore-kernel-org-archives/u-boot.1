Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F42E7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 11:20:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30EB0806E5;
	Mon, 23 Dec 2024 12:20:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VDztNKxh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97C90806EB; Mon, 23 Dec 2024 12:20:40 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70FCE806D4
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 12:20:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5401c52000dso4644652e87.3
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 03:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734952838; x=1735557638; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fgtGkwMfTT5TzTEmovfRz7OVHFL2EEgy7QhD6Sfzr5k=;
 b=VDztNKxh7j64SXdm4w9dDJVBRN3HwvBHqpQ8xRXhyXs8e+0+8xCN8KrtLd15qvj0fc
 aBTvinrH4pfJQmIpjw/HfrdTtnXh5k9Awoq4AHPABtGhW7GiVyWEHqZDDTWmTtE1agTJ
 hEcYZDwH9L2ap8XuS4vAW0I3cUhrjKOmOidI3BSxwY1sIzsu3eCGcg7kpnoVRSiJedD/
 MG/fC8hbfLSyd7izIbrIXOozSg4WvTAuNWX/vthu+9k5XKwNTELccdJXDkx+Ms9kqKqS
 d23DFdBrTBhLSRfisuK3NQfxFDf62UorTh/XsO+ixdvRToA0ZaEbHkeNbzYLQW4TLRiy
 5d0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734952838; x=1735557638;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fgtGkwMfTT5TzTEmovfRz7OVHFL2EEgy7QhD6Sfzr5k=;
 b=fsQoSjjD4s/4DEmU0CobhW9VPyTbo/jP7VDTgTribyDWqnP+0wYa59EGBFWTIs5TlM
 fRC2+5eqFZLYDs/ZaejhR0HUvl9YuFiA4vsBI0hclbAs9BBWkveZIBMI7y4xCRiqdT+M
 +aFrNQw/twWOrna8ayQxdEAR9x+kqLf9a/gn8PhgI74Oly13/hAyV/u+gSOJ6PFfWzWb
 G1pBvN0pLa6p6f5jdzpyOjGQk/loOBagFafQGaEZajHxrtumMSmiUW982xD4lPyV1FZi
 52keeZHPSSOuLtQuXVrk7DAoBD55uWkfzTfadfFRehwSLnfubASzP0ZLztJrilbBMT8N
 iVbw==
X-Gm-Message-State: AOJu0Yyho9X27atvl+lrqZgv4VV30ya8+N5QAfzo7KmCA8M1aSKpZptJ
 vWzzNHHNkU89oboJDBof9amQH84HtwzVg5k1Jrb9rZYvCr2DkK887KtupOqc+r+fD8rEWyhUhbU
 UVgr1ArpbuCNX59SoBGNVUh3Yonw=
X-Gm-Gg: ASbGncvZvVvaLpLfrB9w9N02lgTGFyrm/zI3kwni6RvKKBo8XK5Pz77UjMwmz7VEP7e
 9p/Ck8UUI/eP8Aurq3mU8DJKgroTuklljfIpEU07pgVlpJmVgKVPYDqsetVyGA82QK3Ns
X-Google-Smtp-Source: AGHT+IHkLelr/xxLp2GVlZHxInvnoUtuHlpFwZqBVvO0uGyAqxyWBI/0Vmtm8FPB+GyUMhNNP6PIK58Ht6LCAh6uU3M=
X-Received: by 2002:a05:6512:ea5:b0:542:28a0:a721 with SMTP id
 2adb3069b0e04-5422956beaamr3797409e87.54.1734952837354; Mon, 23 Dec 2024
 03:20:37 -0800 (PST)
MIME-Version: 1.0
References: <1bd862e53b50825f6030bf9f212127c776fff881.camel@googlemail.com>
In-Reply-To: <1bd862e53b50825f6030bf9f212127c776fff881.camel@googlemail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 23 Dec 2024 08:20:26 -0300
Message-ID: <CAOMZO5Cu0QXH0yznB9-qmTAj4CxoNrsUsmuxG2=CZJPM-yrUfg@mail.gmail.com>
Subject: Re: [PATCH] crypto: fsl_hash: fixup alignment if necessary
To: chf.fritz@googlemail.com, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marex@denx.de>
Cc: u-boot <u-boot@lists.denx.de>, Stefan Roese <sr@denx.de>,
 Gaurav Jain <gaurav.jain@nxp.com>
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

Ye Li, Peng, Marek

Could you please help review this patch?

On Thu, Dec 19, 2024 at 3:33=E2=80=AFPM Christoph Fritz
<chf.fritz@googlemail.com> wrote:
>
> Trying to boot a fitImage on an i.mx7ulp results in alignement issue:
>
>    ## Checking hash(es) for FIT Image at 90000000 ...
>       Hash(es) for Image 0 (kernel-1): sha256
>    CACHE: Misaligned operation at range [90000108, 906d9b08]
>    CACHE: Misaligned operation at range [9f6349f0, 9f634a30]
>    CACHE: Misaligned operation at range [9f6349f0, 9f634a30]
>    CACHE: Misaligned operation at range [9f6349f0, 9f634a30]
>    CACHE: Misaligned operation at range [9f6349f0, 9f634a30]
>     error!
>    Bad hash value for 'hash-1' hash node in 'kernel-1' image node
>    Bad hash in FIT image!
>
> Commit 41b2182af73e ("crypto: fsl_hash: Remove unnecessary alignment
> check in caam_hash()") removed a specific check which is not necessary
> for a Layerscape LX2160A but would have catched this directly in
> caam_hash().
>
> The actual root cause is currently unknown, so fix up input and output
> buffers if not aligned.
>
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> ---
>  drivers/crypto/fsl/fsl_hash.c | 87 +++++++++++++++++++++++++++++++----
>  1 file changed, 78 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/crypto/fsl/fsl_hash.c b/drivers/crypto/fsl/fsl_hash.=
c
> index 79b32e2627c..ad8b5640f6f 100644
> --- a/drivers/crypto/fsl/fsl_hash.c
> +++ b/drivers/crypto/fsl/fsl_hash.c
> @@ -178,17 +178,78 @@ static int caam_hash_finish(void *hash_ctx, void *d=
est_buf,
>         return ret;
>  }
>
> +static int fixup_input_buffer(const unsigned char **ppbuf, unsigned int =
len)
> +{
> +       unsigned int aligned_size =3D ALIGN(len, ARCH_DMA_MINALIGN);
> +       unsigned char *aligned_buf =3D malloc_cache_aligned(aligned_size)=
;
> +
> +       if (!aligned_buf) {
> +               debug("Not enough memory for aligned input buffer\n");
> +               return -ENOMEM;
> +       }
> +
> +       memcpy(aligned_buf, *ppbuf, len);
> +
> +       if (aligned_size > len)
> +               memset(aligned_buf + len, 0, aligned_size - len);
> +
> +       *ppbuf =3D aligned_buf;
> +       return 0;
> +}
> +
> +static int fixup_output_buffer(unsigned char **ppbuf, unsigned int len)
> +{
> +       unsigned int aligned_size =3D ALIGN(len, ARCH_DMA_MINALIGN);
> +       unsigned char *aligned_buf =3D malloc_cache_aligned(aligned_size)=
;
> +
> +       if (!aligned_buf) {
> +               debug("Not enough memory for aligned output buffer\n");
> +               return -ENOMEM;
> +       }
> +
> +       memset(aligned_buf, 0, aligned_size);
> +
> +       *ppbuf =3D aligned_buf;
> +       return 0;
> +}
> +
>  int caam_hash(const unsigned char *pbuf, unsigned int buf_len,
>               unsigned char *pout, enum caam_hash_algos algo)
>  {
> -       int ret =3D 0;
> -       uint32_t *desc;
> +       unsigned int digest_size =3D driver_hash[algo].digestsize;
> +       bool pbuf_fixed =3D false, pout_fixed =3D false;
> +       const unsigned char *orig_pbuf =3D pbuf;
> +       unsigned char *orig_pout =3D pout;
>         unsigned int size;
> +       int ret =3D 0;
> +       u32 *desc;
> +
> +       /* fix up input buffer if needed */
> +       if (!IS_ALIGNED((uintptr_t)pbuf, ARCH_DMA_MINALIGN)) {
> +               debug("Fix up pbuf Address alignment\n");
> +               ret =3D fixup_input_buffer(&pbuf, buf_len);
> +               if (ret)
> +                       return ret;
> +               pbuf_fixed =3D true;
> +       }
> +
> +       /* fix up output buffer if needed */
> +       if (!IS_ALIGNED((uintptr_t)pout, ARCH_DMA_MINALIGN)) {
> +               debug("Fix up pout Address alignment\n");
> +               ret =3D fixup_output_buffer(&pout, digest_size);
> +               if (ret) {
> +                       if (pbuf_fixed)
> +                               free((void *)pbuf);
> +                       return ret;
> +               }
> +               pout_fixed =3D true;
> +       }
>
>         desc =3D malloc_cache_aligned(sizeof(int) * MAX_CAAM_DESCSIZE);
>         if (!desc) {
>                 debug("Not enough memory for descriptor allocation\n");
> -               return -ENOMEM;
> +               ret =3D -ENOMEM;
> +               goto out;
>         }
>
>         size =3D ALIGN(buf_len, ARCH_DMA_MINALIGN);
> @@ -196,21 +257,29 @@ int caam_hash(const unsigned char *pbuf, unsigned i=
nt buf_len,
>
>         inline_cnstr_jobdesc_hash(desc, pbuf, buf_len, pout,
>                                   driver_hash[algo].alg_type,
> -                                 driver_hash[algo].digestsize,
> -                                 0);
> +                                 digest_size, 0);
>
>         size =3D ALIGN(sizeof(int) * MAX_CAAM_DESCSIZE, ARCH_DMA_MINALIGN=
);
>         flush_dcache_range((unsigned long)desc, (unsigned long)desc + siz=
e);
> -       size =3D ALIGN(driver_hash[algo].digestsize, ARCH_DMA_MINALIGN);
> +
> +       size =3D ALIGN(digest_size, ARCH_DMA_MINALIGN);
>         invalidate_dcache_range((unsigned long)pout, (unsigned long)pout =
+ size);
>
>         ret =3D run_descriptor_jr(desc);
>
> -       size =3D ALIGN(driver_hash[algo].digestsize, ARCH_DMA_MINALIGN);
> -       invalidate_dcache_range((unsigned long)pout,
> -                               (unsigned long)pout + size);
> +       invalidate_dcache_range((unsigned long)pout, (unsigned long)pout =
+ size);
> +
> +       if (ret =3D=3D 0 && pout_fixed)
> +               memcpy(orig_pout, pout, digest_size);
>
>         free(desc);
> +
> +out:
> +       if (pbuf_fixed)
> +               free((void *)pbuf);
> +       if (pout_fixed)
> +               free((void *)pout);
> +
>         return ret;
>  }
>
> --
> 2.39.5
>
>
