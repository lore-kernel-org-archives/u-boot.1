Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F61C3ABA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 17:00:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AA4E82A8C;
	Tue, 29 Apr 2025 19:00:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QAC22EdZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF31F82A39; Tue, 29 Apr 2025 17:16:37 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F15182958
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 17:16:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7c56a3def84so593960485a.0
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 08:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745939794; x=1746544594; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7JFUwG/W/VB8hScUoe6qwCRqPDeZDhTTKNbTR05IVog=;
 b=QAC22EdZHF7K/0i59aEvc5Xnc5VtCvA71J2BUnT8FNYmS3Qtem9OZj0hkGQ4GVoeow
 30aaEAyVmOjXE/O0axbkOViivEFZOzBTOoUAU/rnR1br2Y07Zhd/0i3V03KOSDc9jhgj
 He+aHc7etK5FoC+QO0bezEp9CdcA+8dKscb8v1RpbUopXtvKaz5f+wzF8yqcQG9Jrja5
 6Kjv6nOhRsnIh7H1eMahfvl02iyfDFOjPvW5RXZ+hO90hk6PNMkeumtx4DPqf3Z1kbxr
 6iwTxBzIavy/C4k/3zFofNCekAWfCsbwTFUIFP9rZ3iF4ObIvNRmpq4ZYAbWdOwqR4qH
 r/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745939794; x=1746544594;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7JFUwG/W/VB8hScUoe6qwCRqPDeZDhTTKNbTR05IVog=;
 b=tySs8tp7IY1ew8q+8L0Qnr9g7t3fEBv4dy7eSSFYeUd7L0jxFOVdDDBmk+YElA08Gy
 kGQgWKbaiJlEtmwshD55JYpPzdyC+A3Fpg0Q6cx2aaU1E/stq0fXgp/tO+0IhwyHGzjg
 ukE1DpU1JI1fWpSC+GiKVVIqsF2KUMYP6nAd3IZZwWdOXeIi874ClNqjemN/fAXPLZKk
 NsAz72j9OeiY43wSfHnJN3qu/A/84S1NyFg4AjuH/1PaE7zckQ4nj0seOlyRjX5jySfg
 9oyDiFihDNEGUPUdML0dsXAhxjmsdAI+nsXiUXiNrYhdkKPgx/2K/Mb0bJv4AMeWdxuB
 6yuA==
X-Gm-Message-State: AOJu0Yxsz1mdNdzYUh3quvUyQDUsYBE9oXg3E80JNEmwpolMVLToCV1b
 zM/2W6bLFm4BBFxNeWFlqIFGz9a2RnG1RvisAU+cesEP+oJB+oM5wN/x3CVPMhSK7FFLPiZyuVX
 OndgAaMeNxDTfcVhZ8wImwKGZBcg=
X-Gm-Gg: ASbGncvmYa+2C9ugqv151+RC+ZEar4ialtBZYCOaA9pSwIEVwEWGmP8exlDIOHZH10T
 c0Fav/YOzJXJPrKXcIYXywKebbBVwifQRTtZzcevjSb5WvH/4YrH5qWjz0pAUMV0bXTBtlfAtGR
 WgHCuQ+1ZPew9XbNn6ZLYcqA==
X-Google-Smtp-Source: AGHT+IG4pLptKyZQAH46iKwTP6B6x7vJCWFQS9AKkOwkvnKQoFvgZEtVDWpPZ98/6KxyjxAWm3Ab21L0DfC4iNplrAQ=
X-Received: by 2002:a05:620a:800e:b0:7c5:444e:3f57 with SMTP id
 af79cd13be357-7cabe6a8032mr543728485a.23.1745939794055; Tue, 29 Apr 2025
 08:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250428060757.125596-1-aristo.chen@canonical.com>
 <20250428172439.GD5495@bill-the-cat>
 <CAJwFiG++7ikLUQBGiz8QXsY=R4WQkWnsWC_ETan5syk-poTu_w@mail.gmail.com>
 <20250429141529.GD1261075@bill-the-cat>
In-Reply-To: <20250429141529.GD1261075@bill-the-cat>
From: Aristo Chen <jj251510319013@gmail.com>
Date: Tue, 29 Apr 2025 23:15:58 +0800
X-Gm-Features: ATxdqUEuwMUQNOfq2fZI3gxmLEm1AWMnEf-Vpn9DqB8ytXJnw-BCy3s9Xfo1t0w
Message-ID: <CAJwFiGJTiDuFn-03vWbMPB2ui9jMTwWC2hcqMfDsgJieRAqqXw@mail.gmail.com>
Subject: Re: [PATCH] bootm: improve error message when gzip decompression
 buffer is too small
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, aristo.chen@canonical.com, sjg@chromium.org, 
 ilias.apalodimas@linaro.org, sughosh.ganu@linaro.org, mkorpershoek@kernel.org, 
 Zone.Niuzh@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 29 Apr 2025 19:00:22 +0200
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
=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8810:15=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Apr 29, 2025 at 06:08:50PM +0800, =E9=99=B3=E5=81=89=E9=8A=98 wro=
te:
> > Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B44=E6=9C=8829=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=881:24=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On Mon, Apr 28, 2025 at 02:07:57PM +0800, Aristo Chen wrote:
> > >
> > > > Currently, when decompressing a gzip-compressed image during bootm,=
 a
> > > > generic error such as "inflate() returned -5" is shown when the buf=
fer is
> > > > too small. However, it is not immediately clear that this is caused=
 by
> > > > CONFIG_SYS_BOOTM_LEN being too small.
> > > >
> > > > This patch improves error handling by:
> > > > - Detecting Z_BUF_ERROR (-5) returned from the inflate() call
> > > > - Suggesting the user to increase CONFIG_SYS_BOOTM_LEN when applica=
ble
> > > > - Preserving the original return code from zunzip() instead of over=
writing
> > > >   it with -1
> > > >
> > > > By providing clearer hints when decompression fails due to insuffic=
ient
> > > > buffer size, this change helps users diagnose and fix boot failures=
 more
> > > > easily.
> > > >
> > > > Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> > >
> > > I like the concept but:
> > >
> > > > @@ -573,12 +574,26 @@ static int handle_decomp_error(int comp_type,=
 size_t uncomp_size,
> > > >                              size_t buf_size, int ret)
> > > >  {
> > > >       const char *name =3D genimg_get_comp_name(comp_type);
> > > > +     bool likely_buf_too_small =3D false;
> > > >
> > > >       /* ENOSYS means unimplemented compression type, don't reset. =
*/
> > > >       if (ret =3D=3D -ENOSYS)
> > > >               return BOOTM_ERR_UNIMPLEMENTED;
> > > >
> > > > +     switch (comp_type) {
> > > > +     case IH_COMP_GZIP:
> > > > +             if (ret =3D=3D Z_BUF_ERROR) /* -5 */
> > > > +                     likely_buf_too_small =3D true;
> > > > +             break;
> > > > +     // Add more if necessary
> > > > +     default:
> > > > +             break;
> > > > +     }
> > > > +
> > > >       if (uncomp_size >=3D buf_size)
> > > > +             likely_buf_too_small =3D true;
> > > > +
> > > > +     if (likely_buf_too_small)
> > > >               printf("Image too large: increase CONFIG_SYS_BOOTM_LE=
N\n");
> > > >       else
> > > >               printf("%s: uncompress error %d\n", name, ret);
> > >
> > > This is a lot of code, why not just:
> > > if (comp_type =3D=3D IH_COMP_GZIP && ret =3D=3D Z_BUF_ERROR)
> > >   printf("Image too large: increase CONFIG_SYS_BOOTM_LEN\n");
> > >
> > Thanks for your suggestion! I am not sure if I get it correctly, do
> > you mean that we should remove the original if condition( if
> > (uncomp_size >=3D buf_size) ) that prints the error message?
>
> Ah sorry for being unclear. I just meant we can handle the new print
> more directly.
No worries, and thanks for your patience.

Just to double confirm, would the following meet your expectation?

if (comp_type =3D=3D IH_COMP_GZIP && ret =3D=3D Z_BUF_ERROR)
    printf("Image too large: increase CONFIG_SYS_BOOTM_LEN\n");
else if (uncomp_size >=3D buf_size)
    printf("Image too large: increase CONFIG_SYS_BOOTM_LEN\n");
else
    printf("%s: uncompress error %d\n", name, ret);

Or would you prefer combining the first two conditions into one?

if ((comp_type =3D=3D IH_COMP_GZIP && ret =3D=3D Z_BUF_ERROR) ||
    uncomp_size >=3D buf_size)
    printf("Image too large: increase CONFIG_SYS_BOOTM_LEN\n");
else
    printf("%s: uncompress error %d\n", name, ret);

Thanks again!


>
> --
> Tom
