Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4D6C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 10:54:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECC5E8771E;
	Wed, 27 Dec 2023 11:54:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jUtDIPn/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 557DF87732; Wed, 27 Dec 2023 11:54:05 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 175E387718
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 11:54:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2ccae380df2so32319121fa.1
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 02:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703674442; x=1704279242; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8CdOZglGKScjgVf27d2es8cf5MXko/ZfzneGjlPlQgg=;
 b=jUtDIPn/Nzur1qS4daqdviUByH0F99l/DiESH0Ck6KwXaAj2Qr41cE4MhBLIQu2WE7
 nJhJJElQnEys/Uj+ik+k03lrme40/PmrZ7lIujRj35/pNKIk4bXm9ba31jd+6d+/ZHvH
 DQ6vfDsfDU/psTrjxIjTVkxkoVnST2HeXF+sEzUoA9cb5vcbriz7As8eVKErarquoN8r
 dIlfe3JTsxl6eVV6wJNe7RsLEpi0Y/FBj7kMNOhRXzM6lckHUK2nO8BCsfoC4uOLICxf
 MOlWXCPPNMUsYMN0jlVIM7+hF1ZT5VSfC5a1Uvdx362LCvErYTzTVNiHzbbhs4lwT5Za
 Rfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703674442; x=1704279242;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8CdOZglGKScjgVf27d2es8cf5MXko/ZfzneGjlPlQgg=;
 b=bBUZPujChiU8iB+2frqik//U6cnTXUVHwquJaC+jF/w24zsOoDVv+iSehCSuQaVuza
 Lj7e3+adz+sdzuk3D9CVImI7FUvjM18zM9f/7DmytkhoTL3rMU1gpUAtFYLKMC+Q+uEf
 Ah2KmHhBqMHRasxQ5xzJxLHC9raowBpKhHKK4WlCA0GQBOqgivwjDagKJxhaLAnJKMfB
 1z+dyVc/vtO1CXLezvokAFqkzinXqVYcU5sAyVzgVjsLQoI82/mKwb72NwP3yYwlXy1U
 a+FtS3+kC4Ci+A23AUFAUJhlImTCSwd8A/GoLRSkUeeVTgSM3tNKZgYf/1UjEeULxHTP
 1Omw==
X-Gm-Message-State: AOJu0Yx3sZsaaYz+MxV6HcGu84PIg+HcWR6h/7AjGHN7qa+HWxLtSKl8
 ZYCcl2pcbiFo1NB7Ms3IsrS4YpyJ6ydbqPsv3eqR77KMi4NaeA==
X-Google-Smtp-Source: AGHT+IEv0vTh/2GHTNoEnquEQdv3ZynQO2dUf67hX0/nECZSkJ1XzHf4ZGLAUVCLU7hOOSpN+ZpCvCjpL9256zBat0Q=
X-Received: by 2002:ac2:4ac3:0:b0:50e:44c9:b83e with SMTP id
 m3-20020ac24ac3000000b0050e44c9b83emr2862144lfp.103.1703674440226; Wed, 27
 Dec 2023 02:54:00 -0800 (PST)
MIME-Version: 1.0
References: <20231015024511.3995580-1-sjg@chromium.org>
 <20231015024511.3995580-7-sjg@chromium.org>
 <ceeb1fd4-a469-4bde-b6e2-a49447b2020b@gmx.de>
In-Reply-To: <ceeb1fd4-a469-4bde-b6e2-a49447b2020b@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Dec 2023 12:53:24 +0200
Message-ID: <CAC_iWjJHUjce2ObV3bh3c2h0RYwnRfCE2ZfQAR17SHD0R34oPA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] smbios: Require the caller to align the SMBIOS
 table
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 26 Dec 2023 at 14:46, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 10/15/23 04:45, Simon Glass wrote:
> > All callers handle this alignment, so drop the unnecessary code. This
> > simplifies things a little.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> Reviewed: Heinrich Schuchardt <xypron.glpk@gmx.de>
>
> > ---
> >
> > (no changes since v1)
> >
> >   include/smbios.h | 5 +----
> >   lib/smbios.c     | 2 --
> >   2 files changed, 1 insertion(+), 6 deletions(-)
> >
> > diff --git a/include/smbios.h b/include/smbios.h
> > index ddabb558299e..31d997287588 100644
> > --- a/include/smbios.h
> > +++ b/include/smbios.h
> > @@ -248,12 +248,9 @@ static inline void fill_smbios_header(void *table, int type,
> >    *
> >    * This writes SMBIOS table at a given address.
> >    *
> > - * @addr:    start address to write SMBIOS table. If this is not
> > - *           16-byte-aligned then it will be aligned before the table is
> > - *           written.
> > + * @addr:    start address to write SMBIOS table (must be 16-byte-aligned)
> >    * Return:  end address of SMBIOS table (and start address for next entry)
> >    *          or NULL in case of an error
> > - *
> >    */
> >   ulong write_smbios_table(ulong addr);
> >
> > diff --git a/lib/smbios.c b/lib/smbios.c
> > index 92e98388084f..5c9f108496d6 100644
> > --- a/lib/smbios.c
> > +++ b/lib/smbios.c
> > @@ -483,8 +483,6 @@ ulong write_smbios_table(ulong addr)
> >               ctx.dev = NULL;
> >       }
> >
> > -     /* 16 byte align the table address */
> > -     addr = ALIGN(addr, 16);

I don't think this is fine. Failing to do so would break the SMBIOS
tables. It's fine to require this but in that case, we should have add
a check for the 16b alignment

Thanks
/Ilias
> >       start_addr = addr;
> >
> >       /*
>
