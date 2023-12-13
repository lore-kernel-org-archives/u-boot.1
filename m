Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9A9C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 22:22:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B03C2878DB;
	Wed, 13 Dec 2023 23:22:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z3qeI7xL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D31F3878D6; Wed, 13 Dec 2023 23:22:36 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFFA28779D
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 23:22:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a1ca24776c3so4675766b.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 14:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702506154; x=1703110954; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Zu94AiX06RA78kj2vTGxtr9XV1U32wm0UU7TU+/Xqd4=;
 b=Z3qeI7xLOyTIVMaZS9EHPkc+TnrNQflO8f1KL4HDFd+mbrdFz6a7+UBLPKrViNryhF
 CeKqUFLtADKdMckK7z+lpzhWBAw3XqhVcHQ1YFcSpTD99y0uajdHxqHSw/hnTHJqI7jw
 QNQmyx8hXyaXZqddpb/zlLKXQFqVcIUc2voY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702506154; x=1703110954;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zu94AiX06RA78kj2vTGxtr9XV1U32wm0UU7TU+/Xqd4=;
 b=SJ1R1wusc//Gq7rsAWybNRFIFKs2ymqRLuFwGBPRvhdbnxtTAoMKbRdU7g1jN+Tnab
 bk1Dq7X+q14bcXwo6Fx3cu+Z7kd5t2sIwlXZOA+SM8XVGi+WfYIzF9q/LYo2cnL+wuBp
 YrL9FvYL87fyiG3vGX9mPPB/ILDhVQENoPpHYM1ACit30+eDENRbcbOqH41izxlNR8kF
 qGEP1O2KZXadyqS2NDV8DRB3F+UvB0w/nlbHXlwdwwn+vXz0rBpi1Cg99Cr+e1jwzDV9
 HzjEde4S878kjL3clqAxnqg77l3Cdhe9BCh1FZ5YN01aIPY6ZKGmxF3ypJftp3Bvvq1q
 nS+w==
X-Gm-Message-State: AOJu0YygnEr3POlYbaOM7VMTJArenNvBexMRzTupA9Qkj6xk9ch0JF1R
 59oFL+dJa7vDf/h6eObpoCXx8XzLLveqaIB65Vir5sfm1jY5EdR7IKw=
X-Google-Smtp-Source: AGHT+IELNTE2TNYb0/V7DUFeNYgbuzuFYAV0gsnyx1xl3ntEaK8Ax2d4PpI0HKtKqeWfS1DznAXQr5ebIcGvrP/GG/g=
X-Received: by 2002:a17:907:6d05:b0:a1e:63ec:f0c5 with SMTP id
 sa5-20020a1709076d0500b00a1e63ecf0c5mr11381835ejc.40.1702506154170; Wed, 13
 Dec 2023 14:22:34 -0800 (PST)
MIME-Version: 1.0
References: <20231207091850.17776-1-ilias.apalodimas@linaro.org>
 <20231207091850.17776-3-ilias.apalodimas@linaro.org>
 <CAPnjgZ2hMB0uTTd7tKZ2bGHkPiKM8j+Dz47nXKwiXH6vWHF8tQ@mail.gmail.com>
 <CAC_iWj+sxOhz5bLe=3cZ1vPx5KZSEe61Y+8eA5KdJBK=0MvvWw@mail.gmail.com>
In-Reply-To: <CAC_iWj+sxOhz5bLe=3cZ1vPx5KZSEe61Y+8eA5KdJBK=0MvvWw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Dec 2023 15:22:16 -0700
Message-ID: <CAPnjgZ0bXoGXmjxhdYgrCCzs2HTSviJVOGTvmUL8_qy=O4JZAg@mail.gmail.com>
Subject: Re: [PATCH 2/2 v3] smbios: Fallback to the default DT if sysinfo
 nodes are missing
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: trini@konsulko.com, sean.anderson@seco.com, neil.armstrong@linaro.org, 
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl, 
 u-boot@lists.denx.de
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

Hi Ilias,

On Wed, 13 Dec 2023 at 14:43, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> [...]
>
> >
> > Can we add a Kconfig to enable this?
>
> I don't see the point, and I am not the only one.

The information is not curated and isn't accurate. E.g. it can end up
putting the vendor, device and version all into a single field,
instead of using the fields correctly.

>
> > > + * @size: str buffer length
>
> [...]
>
> > > +       int cnt = 0;
> > > +       char *token;
> > > +
> > > +       memset(str, 0, size);
> >
> > *str = '\0' should be enough, assuming size is not 0
>
> I generally prefer initializing all memory, it's not that big of a burden here.

OK, not a big deal, just odd. Also it is a character, so '\0' is better.

>
> [...]
>
> > > -               str = ofnode_read_string(ctx->node, prop);
> > > +               const char *str = NULL;
> > > +               char str_dt[128] = { 0 };
> > > +               /*
> > > +                * If the node is not valid fallback and try the entire DT
> >
> > s/and/then/ ?
> >
>
> Sure
>
> > > +                * so we can at least fill in manufacturer and board type
> > > +                */
> > > +               if (ofnode_valid(ctx->node)) {
> > > +                       str = ofnode_read_string(ctx->node, prop);
> > > +               } else {
> > > +                       const struct map_sysinfo *nprop;
> > > +
> > > +                       nprop = convert_sysinfo_to_dt(prop);
> > > +                       get_str_from_dt(nprop, str_dt, sizeof(str_dt));
> > > +                       str = (const char *)str_dt;
> >
> > can't you drop the case?
>
> What case?

Sorry, I meant 'cast'.

Regards,
Simon
