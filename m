Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69768C4332F
	for <u-boot@archiver.kernel.org>; Sun,  5 Nov 2023 16:29:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8574286FB8;
	Sun,  5 Nov 2023 17:29:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JO1Xjeth";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C60586F38; Sun,  5 Nov 2023 17:29:41 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B82D786F38
 for <u-boot@lists.denx.de>; Sun,  5 Nov 2023 17:29:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-540c54944c4so7358148a12.1
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 08:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699201774; x=1699806574; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QPlv07iunzTBhRKOzgqBA7J8rsT4/5gF1h3f8J5qWjQ=;
 b=JO1XjethEf1MVNP0d5UHzalWQ/rb3e0LcDpR/TSbsXLVAtKOkVu/81mzh70ZnscJ4n
 PopzpeYyCdAvIXL7dXgpGBVrJews/yxeI6ZwULY6FfavD5SNRHJ/ErLPbxBgjR+m0xiZ
 4bWNXHZAB3W3+xE7IX/X5JMXuCxRKq/4GMClw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699201774; x=1699806574;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QPlv07iunzTBhRKOzgqBA7J8rsT4/5gF1h3f8J5qWjQ=;
 b=RqM4LQ1KTbEJFsmuk/Uv3I3MOlSUbVXezlLRXrkY5FmCsDa1+R2FTW0necfQxggvD+
 se9YY/d8/DdheUr4IeH7Vt1mqtOZUlx2vLG8BLzKJv5fkNBv2gK9BV4CQDdGsQnMVINu
 O05cHjH4E4BEAGD91cGg57YI7uCHmMRXC+Y9CuTaDteMKYsFr2PY7E5dOsgaysXTl5fl
 34CfB3U7EzJQ/a6vPNTmWrA7Hf59ZbUvcSt6mWy1zXI2METiNYIAlZjnTWYJq10pmiq8
 Rx/yr1u920qwdyK4ukuWzwl5H9oog851wOuz4LfnWsnVOjUV1gNJOsghPOfwzK1T/NIg
 OgSA==
X-Gm-Message-State: AOJu0YxGNTALUUa33rvp6rBTD1R6UaMmfKRQqmHCIAp4Njho+4asPuli
 4H8ilrjyF66jfeWEBVdPrJ/N5XtyVyDtymfaUBAH+2MgGdKeCICb+d8=
X-Google-Smtp-Source: AGHT+IGq1PngIvnrdjVCK8P6Zj4tALpi3bF6cMNlhVRBB5iZ743qtfo0rdySSLuqzm8PTK8mgFirEIgE71GgPYZZHxs=
X-Received: by 2002:aa7:d8d5:0:b0:543:5dd9:a72 with SMTP id
 k21-20020aa7d8d5000000b005435dd90a72mr7756356eds.1.1699201774193; Sun, 05 Nov
 2023 08:29:34 -0800 (PST)
MIME-Version: 1.0
References: <20231002011450.462468-1-sjg@chromium.org>
 <20231002011450.462468-5-sjg@chromium.org>
 <CAEUhbmWi9phnvS1U=z1O+8t7kK5mV=JLw8=YJ4A_u3tcrPSXGw@mail.gmail.com>
In-Reply-To: <CAEUhbmWi9phnvS1U=z1O+8t7kK5mV=JLw8=YJ4A_u3tcrPSXGw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 5 Nov 2023 16:29:22 +0000
Message-ID: <CAPnjgZ1CsWJa2Ta8fgbGmXZsvpg_BMFDRJmjqPqu6d+7z-TXxg@mail.gmail.com>
Subject: Re: [PATCH v3 09/12] x86: Enable SSE in 64-bit mode
To: Bin Meng <bmeng.cn@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Bin,

On Sun, 5 Nov 2023 at 14:05, Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Simon,
>
> On Mon, Oct 2, 2023 at 9:15=E2=80=AFAM Simon Glass <sjg@chromium.org> wro=
te:
> >
> > This is needed to support Truetype fonts. In any case, the compiler
> > expects SSE to be available in 64-bit mode. Enable it.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> > ---
> >
> > (no changes since v1)
> >
> >  arch/x86/config.mk        |  1 -
> >  arch/x86/cpu/x86_64/cpu.c | 11 +++++++++++
> >  2 files changed, 11 insertions(+), 1 deletion(-)
> >
>
> I didn't suggest we enable SSE for x86. This is the wrong approach.
>
> We should rewrite the Truetype support codes to avoid using float/double =
types.
>
> This way the Truetype codes can be used on any other architectures
> without the need for the compiler to emit explicit floating
> instructions.

I am not aware of any such library. At present, enabling truetype on
coreboot64 causes a hang.

Regards,
Simon
