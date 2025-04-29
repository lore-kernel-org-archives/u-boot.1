Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41ACC3ABA9
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 12:26:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2DF8825A6;
	Tue, 29 Apr 2025 14:26:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NQZwaVQT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12C6E80F03; Tue, 29 Apr 2025 12:09:30 +0200 (CEST)
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com
 [IPv6:2607:f8b0:4864:20::a2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6B82809A5
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 12:09:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-525da75d902so2273882e0c.3
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 03:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745921367; x=1746526167; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WjoGMTG9ueviZhHp/3+X0KNHqRm8pQ4QTMT1Zt0yTHo=;
 b=NQZwaVQTiqJ2Cqa/FI1MDpHG1oF8HD/YbvMCD6idGm/+uAZiyfkYLW1aeQVQW0kJgO
 rxvvq7V39TVG7laZF90Qcbnx1AqRileYEaZADKX852mLurlUXzFDro//inmxMfkhNTSg
 uCF0tHDfbKlCj0zttA4HVqHEXKUfUlF0EIul/XkVkDUzVqN5tIL6YgBy2Ls3xBS3tiBy
 bKDa4nzZat7PddPa76G9a11bNKVvjgDt+tYzL9Craq185OhnXpk5eQ8IZMLm+ZLafMRj
 nACGJyAIqET+v9FliDQp+PqEp6y7KzchpHgwqWHx+J0czBRdbRbWWKUfkt+EjOgqjCWB
 zJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745921367; x=1746526167;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WjoGMTG9ueviZhHp/3+X0KNHqRm8pQ4QTMT1Zt0yTHo=;
 b=xPfvJ0l74ori1qEXRHzafX8XL6FfFv27F38fd5a/8Yk/rb1SI1xy0C9+Lu+lB7KPcr
 cJmKnczR3KXM2vV178P4vw3hIzkclhLE6RUrS95evPXJvTf1FQxXiKAPeZt1VEDtL2B9
 oGcuolWNyPAOoSMCc4dEllfFwHJhMpHI2hDm1PfLI+Brqn6Vk/kknufPL0AB5MQzdhLK
 qK/LDGnk7B3gHKRt2Eg5Xs9LBbnG88ClMEb4WTFLAKjPo58h+lESAEoWZu7Puvo+pSjo
 hTRApZ/5nkvbdFPfIyyzw6g+4GUnQEqtKYgzfusi7JwX76y/GqBlH51XDFjfFpjBkruL
 xBBA==
X-Gm-Message-State: AOJu0YyZXYR4dsMijkFEn31A8zi014OIrcyAYEWs1AxqLyIa7dc1rWd/
 0dnswgmqSd7bs+PzNi9gA0aD9mSSiGdZ7QbxEdrhFTpVmXml+tQCuQ1GslQBJO307BREMPN9OpB
 lUstuaS6qhhbhajDC+tDzf9oHvGo=
X-Gm-Gg: ASbGncse4ViQ74JY3pwiQwGvZjL+eKeOJ5ROc4EiART6eKMUr6Af9NC0O90LCqu4uki
 ++tWlPjz1rvxgdtVIfh4sbQeqv6AR4keG2aoWyNNHNtEhFb3eqymys0ott8GRVGSPwBmuErfY8h
 gKEe9B0A4y3++SuSrb3mot2Xg=
X-Google-Smtp-Source: AGHT+IGtCRFSpH9HmhUFLiETnBL+lhJL2jizOUSCNLzEKaiNZJCVBbsNFin/kgOZYLJEYVK5LSr21GJcHbO3xn8aBac=
X-Received: by 2002:a05:6102:2acd:b0:4d5:cbbf:456f with SMTP id
 ada2fe7eead31-4daa8d59d15mr1174493137.10.1745921366514; Tue, 29 Apr 2025
 03:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250428060757.125596-1-aristo.chen@canonical.com>
 <20250428172439.GD5495@bill-the-cat>
In-Reply-To: <20250428172439.GD5495@bill-the-cat>
From: =?UTF-8?B?6Zmz5YGJ6YqY?= <jj251510319013@gmail.com>
Date: Tue, 29 Apr 2025 18:08:50 +0800
X-Gm-Features: ATxdqUEM8A3fRF5sKc8ZJ1jt0NWb0dvay2v_OKPO9DEbIRh_9AUntVBePuryyCM
Message-ID: <CAJwFiG++7ikLUQBGiz8QXsY=R4WQkWnsWC_ETan5syk-poTu_w@mail.gmail.com>
Subject: Re: [PATCH] bootm: improve error message when gzip decompression
 buffer is too small
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, aristo.chen@canonical.com, sjg@chromium.org, 
 ilias.apalodimas@linaro.org, sughosh.ganu@linaro.org, mkorpershoek@kernel.org, 
 Zone.Niuzh@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 29 Apr 2025 14:26:17 +0200
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

Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B44=E6=9C=8829=E6=97=A5 =
=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=881:24=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, Apr 28, 2025 at 02:07:57PM +0800, Aristo Chen wrote:
>
> > Currently, when decompressing a gzip-compressed image during bootm, a
> > generic error such as "inflate() returned -5" is shown when the buffer =
is
> > too small. However, it is not immediately clear that this is caused by
> > CONFIG_SYS_BOOTM_LEN being too small.
> >
> > This patch improves error handling by:
> > - Detecting Z_BUF_ERROR (-5) returned from the inflate() call
> > - Suggesting the user to increase CONFIG_SYS_BOOTM_LEN when applicable
> > - Preserving the original return code from zunzip() instead of overwrit=
ing
> >   it with -1
> >
> > By providing clearer hints when decompression fails due to insufficient
> > buffer size, this change helps users diagnose and fix boot failures mor=
e
> > easily.
> >
> > Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> I like the concept but:
>
> > @@ -573,12 +574,26 @@ static int handle_decomp_error(int comp_type, siz=
e_t uncomp_size,
> >                              size_t buf_size, int ret)
> >  {
> >       const char *name =3D genimg_get_comp_name(comp_type);
> > +     bool likely_buf_too_small =3D false;
> >
> >       /* ENOSYS means unimplemented compression type, don't reset. */
> >       if (ret =3D=3D -ENOSYS)
> >               return BOOTM_ERR_UNIMPLEMENTED;
> >
> > +     switch (comp_type) {
> > +     case IH_COMP_GZIP:
> > +             if (ret =3D=3D Z_BUF_ERROR) /* -5 */
> > +                     likely_buf_too_small =3D true;
> > +             break;
> > +     // Add more if necessary
> > +     default:
> > +             break;
> > +     }
> > +
> >       if (uncomp_size >=3D buf_size)
> > +             likely_buf_too_small =3D true;
> > +
> > +     if (likely_buf_too_small)
> >               printf("Image too large: increase CONFIG_SYS_BOOTM_LEN\n"=
);
> >       else
> >               printf("%s: uncompress error %d\n", name, ret);
>
> This is a lot of code, why not just:
> if (comp_type =3D=3D IH_COMP_GZIP && ret =3D=3D Z_BUF_ERROR)
>   printf("Image too large: increase CONFIG_SYS_BOOTM_LEN\n");
>
Thanks for your suggestion! I am not sure if I get it correctly, do
you mean that we should remove the original if condition( if
(uncomp_size >=3D buf_size) ) that prints the error message?

> And we can expand the tests for other algorithms either later or in
> follow-up. Thanks!
>
> --
> Tom
