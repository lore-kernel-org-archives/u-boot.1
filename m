Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91FDCD1283
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 16:35:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 257C888195;
	Thu, 28 Mar 2024 17:35:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="l9NXWtS/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD018881A7; Thu, 28 Mar 2024 17:35:36 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0CE088176
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 17:35:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d46dd8b0b8so12908111fa.2
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 09:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711643734; x=1712248534; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a25a3W0TJLGMi2sBrCHLWZv242o4TjcNPVZLXwedHXg=;
 b=l9NXWtS/Zswv/N8paOHBaGzVBmZRzAk2WdcwJC7mVByESMs2yDp0xk2IAkUqdGHgtJ
 NUBcfBqUwwTNk8t+QWlT/L8pdv3+G3cpHbl1MwTnpww1of/uvAjbwXLkzwB4a3RQqsF+
 w+EuTOBidGKJHq37i2u4htjRpSw1a0ZWP03OQZ7Pak9XUhQXHzFx1xJzRol6tRSPbIug
 JuSGW/MI4P9pROEfd4O5i+oqXSsBwT3/rROx5l7VS9TN/DLVfEDO/RxgsGmbyfLOvxyb
 1rXeahiR6C3vpPZts7A+o/+UaAt9X36rJpkCAjgnr0w3EBOZj4H9JxZOZf/K6cN1Fdu5
 5MYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711643734; x=1712248534;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a25a3W0TJLGMi2sBrCHLWZv242o4TjcNPVZLXwedHXg=;
 b=eaPjKfd2UJjODYSdDC8+j+hhLnokEmcEK0Wa4EXfJKV4BMiE3WRRriZOcsYXyGFaXq
 +rnTGaeB7tMDhTyJjAdUqIYIKPloxoBK1uicpnfH5rOxEesD7MqMeMdyFK86mAz67aZu
 HxgPJgAYx9+M+0deQ1FDMEH+CC8D5da2Ld+ada3tnmY0F2WsICe4tvxqqMVpNvkXrqje
 5RMronJ9JbKbYfa50rJWrmHEth5z3iCSjlymGNs4ak9ZjMvqUC0EPaaOEk0ebLbZzAYk
 ZsbgHv7TjlAKz/ktNEBwCJmOcubykvy9Rn6fd9X4BoYsnaVntlYqy45+uW6R/oSzfepC
 iXYQ==
X-Gm-Message-State: AOJu0YxdsjqrDv7Qqm7zUdxR1hoD+Ltk9iOkISL8zAGTUQidUPU2uV48
 NcMCt2umKrNEXa0fRWiRfb2ZcR6MpE81LxmHs4ugKNPhGQ6u4EnDLmC6OPttK7T2jTIwJPSbSN6
 Nv6+Y1z08AxIUsoW7thvQQihKrMovG/0s4vacJ9wKBj5xuhku
X-Google-Smtp-Source: AGHT+IGm5LnbweCGYosMlDo1p2Pv3g83K97nM//Jjl+r/adGfqjjcmPGHydO5GGxUCrBDAlO2tHZN4wBnssfkfgW6I4=
X-Received: by 2002:a2e:7a12:0:b0:2d6:ee46:96d with SMTP id
 v18-20020a2e7a12000000b002d6ee46096dmr2354572ljc.31.1711643734015; Thu, 28
 Mar 2024 09:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240327223704.1883824-1-tharvey@gateworks.com>
 <CAC_iWjL+oK9FQGGc-ZOGK8Ai0nZTeVWEz0HWa8Wsa2=_gpkuhQ@mail.gmail.com>
 <CAJ+vNU1-WPNzy35GGPJHBt0P13GKMCRLrhCjP+JVwr=-zcSV5A@mail.gmail.com>
In-Reply-To: <CAJ+vNU1-WPNzy35GGPJHBt0P13GKMCRLrhCjP+JVwr=-zcSV5A@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 28 Mar 2024 18:34:57 +0200
Message-ID: <CAC_iWj+Y8jjEtwU6+QxT=R-sUt_x3iuOqyhXLpatpP1sKe17JA@mail.gmail.com>
Subject: Re: [PATCH] tpm-v2: allow algo name to be conigured for pcr_read and
 pcr_extend
To: Tim Harvey <tharvey@gateworks.com>
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

On Thu, 28 Mar 2024 at 17:33, Tim Harvey <tharvey@gateworks.com> wrote:
>
> On Thu, Mar 28, 2024 at 12:37=E2=80=AFAM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Tim,
> >
> > [...]
> >
> > >
> > > +/**
> > > + * tpm2_algo_len() - Return an algo value and length given a algorit=
hm name
> > > + *
> > > + * @name: algorithm name
> > > + * @rwlen: pointer to integer to populate with algorithm length if n=
on-null
> > > + * Return: algorithm value
> > > + */
> > > +int tpm2_algo_len(const char *name, int *rwlen);
> > > +
> > > +/**
> > > + * tpm2_algo_len() - Return an algoithm name string
> > > + *
> > > + * @algo: algorithm value
> > > + * Return: algorithm string
> > > + */
> > > +const char *tpm2_algo_name(int algo);
> > > +
> > >  #endif /* __TPM_V2_H */
> > > diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> > > index 68eaaa639f89..6a090ce5810c 100644
> > > --- a/lib/tpm-v2.c
> > > +++ b/lib/tpm-v2.c
> > > @@ -1555,3 +1555,49 @@ u32 tpm2_enable_nvcommits(struct udevice *dev,=
 uint vendor_cmd,
> > >
> > >         return 0;
> > >  }
> > > +
> > > +int tpm2_algo_len(const char *name, int *rwlen)
> > > +{
> > > +       int algo =3D -EINVAL;
> > > +       int len =3D 0;
> > > +
> > > +       if (!strcasecmp("sha1", name)) {
> > > +               algo =3D TPM2_ALG_SHA1;
> > > +               len =3D TPM2_SHA1_DIGEST_SIZE;
> > > +       } else if (!strcasecmp("sha256", name)) {
> > > +               algo =3D TPM2_ALG_SHA256;
> > > +               len =3D TPM2_SHA256_DIGEST_SIZE;
> > > +       } else if (!strcasecmp("sha384", name)) {
> > > +               algo =3D TPM2_ALG_SHA384;
> > > +               len =3D TPM2_SHA384_DIGEST_SIZE;
> > > +       } else if (!strcasecmp("sha512", name)) {
> > > +               algo =3D TPM2_ALG_SHA512;
> > > +               len =3D TPM2_SHA512_DIGEST_SIZE;
> > > +       } else if (!strcasecmp("sm3_256", name)) {
> > > +               algo =3D TPM2_ALG_SM3_256;
> > > +               len =3D TPM2_SM3_256_DIGEST_SIZE;
> > > +       }
> > > +
> > > +       if (*rwlen)
> > > +               *rwlen =3D len;
> > > +
> > > +       return algo;
> > > +}
> > > +
> >
> > We already have tpm2_algorithm_to_len(). Instead of defining a new
> > function, can we convert strings to 'enum tpm2_algorithms'? We can
> > then reuse the existing function.
> >
>
> Hi Ilias,
>
> Thanks - I didn't see tpm2_algorithm_to_len. Yes, I can use it but I
> still need to add a new function to turn the name into an algo.

Yep, that's fine,
> I also
> didn't see tpm2_supported_algorithms; should I only support
> name-to-algorithm and algorithm-to-name for that subset?
>

Yea, that would be good, we can at least have a reference of what we
currently support.

Cheers
/Ilias

> Best Regards,
>
> Tim
>
> > > +const char *tpm2_algo_name(int algo)
> > > +{
> > > +       switch (algo) {
> > > +       case TPM2_ALG_SHA1:
> > > +               return "sha1";
> > > +       case TPM2_ALG_SHA256:
> > > +               return "sha256";
> > > +       case TPM2_ALG_SHA384:
> > > +               return "sha384";
> > > +       case TPM2_ALG_SHA512:
> > > +               return "sha512";
> > > +       case TPM2_ALG_SM3_256:
> > > +               return "sm3_256";
> > > +       }
> > > +
> > > +       return "";
> > > +}
> > > --
> > > 2.25.1
> > >
> >
> > Thanks
> > /Ilias
