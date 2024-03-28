Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AACCC54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 15:33:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 910A68817C;
	Thu, 28 Mar 2024 16:33:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="NonFFJfV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 075C488172; Thu, 28 Mar 2024 16:33:52 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 835BA8818F
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 16:33:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-51588f70d2dso1179689e87.3
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 08:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1711640029; x=1712244829; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QIM3G2enVj7MiiH6J64Xfh7HnI6aDTRFfxqn8C8FIbw=;
 b=NonFFJfVLsct39voPXSHcnL4rLpTBLqlFUFrRUuHL6VPQa1nsfxKfxDA+y9lhraAse
 OVphi+pzUsQB46fudfyg7S92+stINy87HNu/hWMTIJbLgs+fM6BARGbzwzUvceOlPwXS
 eJuMZC4B/WasWV8GR/MK5Vnf6isslcJSkXuLXqYO53OgDAh7d9qFvVGCcq0O74ZQRedA
 z4LSMugGpccn6qLm2hgn+UYqRySlkxDKI5fQw8TtR0YOKbfcJB7zKB20qKWeUchtdzoM
 YJugWKWGsiyF+mO2CrNYlJ1G//VWfJRwxMuDrSLdo2uRCJCz9BcIxtLiU0IYko7+KVJe
 e02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711640029; x=1712244829;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QIM3G2enVj7MiiH6J64Xfh7HnI6aDTRFfxqn8C8FIbw=;
 b=qwFqTsD7RlT5ZYCQCxLh1YTy4rW8Cg1E452HvjR7h8MYVXXk07SnnX/QnnTAF3iMEb
 fRjhUK9lhU5RkzzlEMDWqK6PWlxLO23GWXvIHdjfb+ThcH2rJhtBtNsRm7E8EoDVT+0n
 adyVmXw5GCxp3DJ6PCr72nWZqdfAnNvCplZtCEHpwMSegQ1c6uZE0yd+jxjMi5+DwP35
 4cKyHExb/NDSSpeEsu8XcSEgcJa/8cx5Jf9Okpa8yzfgTleFz2IHVa5hXSYVt8EKxtnA
 vW5ioF3chj1MTd3xBI8GKbIXjV6PUPU+XDfQNMTNqaHRDd/gZ+LloyYa37kxLDanaiqV
 bTlQ==
X-Gm-Message-State: AOJu0Yw+2Q+Ds+SDcRM5wsoCD/vvQA2bU/yOyVTNLlXtykcjkB1E4YVM
 6WLf0eT43VPjddpI1GePcgpx6/iqVtbegbpBk/frzELgqWMju0iNj8y+Hw8U0yBGu8DfWIAHRBq
 rgie6i6+UcsG0ZDXw75qP8BUcnLuc+Afpz7kxOg==
X-Google-Smtp-Source: AGHT+IGZeHwbpiqBkBAS6x2ZIW5T8GNxsB2gejQI/Wrq4rZFyfNAhs9Ws12EBqPlKLsCmjI9yd1F2gIJFDNI/TQgiz0=
X-Received: by 2002:a05:6512:40b:b0:515:c770:a7bf with SMTP id
 u11-20020a056512040b00b00515c770a7bfmr1568579lfk.63.1711640028624; Thu, 28
 Mar 2024 08:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240327223704.1883824-1-tharvey@gateworks.com>
 <CAC_iWjL+oK9FQGGc-ZOGK8Ai0nZTeVWEz0HWa8Wsa2=_gpkuhQ@mail.gmail.com>
In-Reply-To: <CAC_iWjL+oK9FQGGc-ZOGK8Ai0nZTeVWEz0HWa8Wsa2=_gpkuhQ@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 28 Mar 2024 08:33:36 -0700
Message-ID: <CAJ+vNU1-WPNzy35GGPJHBt0P13GKMCRLrhCjP+JVwr=-zcSV5A@mail.gmail.com>
Subject: Re: [PATCH] tpm-v2: allow algo name to be conigured for pcr_read and
 pcr_extend
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Eddie James <eajames@linux.ibm.com>
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

On Thu, Mar 28, 2024 at 12:37=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Tim,
>
> [...]
>
> >
> > +/**
> > + * tpm2_algo_len() - Return an algo value and length given a algorithm=
 name
> > + *
> > + * @name: algorithm name
> > + * @rwlen: pointer to integer to populate with algorithm length if non=
-null
> > + * Return: algorithm value
> > + */
> > +int tpm2_algo_len(const char *name, int *rwlen);
> > +
> > +/**
> > + * tpm2_algo_len() - Return an algoithm name string
> > + *
> > + * @algo: algorithm value
> > + * Return: algorithm string
> > + */
> > +const char *tpm2_algo_name(int algo);
> > +
> >  #endif /* __TPM_V2_H */
> > diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> > index 68eaaa639f89..6a090ce5810c 100644
> > --- a/lib/tpm-v2.c
> > +++ b/lib/tpm-v2.c
> > @@ -1555,3 +1555,49 @@ u32 tpm2_enable_nvcommits(struct udevice *dev, u=
int vendor_cmd,
> >
> >         return 0;
> >  }
> > +
> > +int tpm2_algo_len(const char *name, int *rwlen)
> > +{
> > +       int algo =3D -EINVAL;
> > +       int len =3D 0;
> > +
> > +       if (!strcasecmp("sha1", name)) {
> > +               algo =3D TPM2_ALG_SHA1;
> > +               len =3D TPM2_SHA1_DIGEST_SIZE;
> > +       } else if (!strcasecmp("sha256", name)) {
> > +               algo =3D TPM2_ALG_SHA256;
> > +               len =3D TPM2_SHA256_DIGEST_SIZE;
> > +       } else if (!strcasecmp("sha384", name)) {
> > +               algo =3D TPM2_ALG_SHA384;
> > +               len =3D TPM2_SHA384_DIGEST_SIZE;
> > +       } else if (!strcasecmp("sha512", name)) {
> > +               algo =3D TPM2_ALG_SHA512;
> > +               len =3D TPM2_SHA512_DIGEST_SIZE;
> > +       } else if (!strcasecmp("sm3_256", name)) {
> > +               algo =3D TPM2_ALG_SM3_256;
> > +               len =3D TPM2_SM3_256_DIGEST_SIZE;
> > +       }
> > +
> > +       if (*rwlen)
> > +               *rwlen =3D len;
> > +
> > +       return algo;
> > +}
> > +
>
> We already have tpm2_algorithm_to_len(). Instead of defining a new
> function, can we convert strings to 'enum tpm2_algorithms'? We can
> then reuse the existing function.
>

Hi Ilias,

Thanks - I didn't see tpm2_algorithm_to_len. Yes, I can use it but I
still need to add a new function to turn the name into an algo. I also
didn't see tpm2_supported_algorithms; should I only support
name-to-algorithm and algorithm-to-name for that subset?

Best Regards,

Tim

> > +const char *tpm2_algo_name(int algo)
> > +{
> > +       switch (algo) {
> > +       case TPM2_ALG_SHA1:
> > +               return "sha1";
> > +       case TPM2_ALG_SHA256:
> > +               return "sha256";
> > +       case TPM2_ALG_SHA384:
> > +               return "sha384";
> > +       case TPM2_ALG_SHA512:
> > +               return "sha512";
> > +       case TPM2_ALG_SM3_256:
> > +               return "sm3_256";
> > +       }
> > +
> > +       return "";
> > +}
> > --
> > 2.25.1
> >
>
> Thanks
> /Ilias
