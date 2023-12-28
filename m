Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429A2C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 07:38:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3572387946;
	Thu, 28 Dec 2023 08:38:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WJHQqAH9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31C43879A3; Thu, 28 Dec 2023 08:38:33 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58B6C874E0
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 08:38:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50e835800adso1870706e87.0
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 23:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703749109; x=1704353909; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DHiiGJW0vhZH1hnw+bl/bJUakZvx2+bNS9R0u3JcMQ0=;
 b=WJHQqAH9lqwPdSSNRus6dlkUfCfOhOeJ3KmFHa/9gSrR2YxFernxcLBDPt/gnWHhxz
 l/QVWO9roUTuOrw72JRv14eYfrGfrXsPaqv2R148kLnvbbfmKRKglk/sVdZwQ8JeUAhz
 z+uh1WOGpG9cJuWIRnuk8oOQfWY+0E7Eq9WpadchXOMBJmuSfTV5h1H4+cnjj9BBwFdE
 GOy3rUGpP0vjuerINP+GMtDQEa2WKWoXKj6LBz33lRP4CfLUkbLu/blXIPMXDmwFlz6S
 On6PNzStfEKFMGzISlDUwND33sbqV4cBdvF+gEkDx5m7oh/+v3NAtx1wwucFrM0trYgC
 EXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703749109; x=1704353909;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DHiiGJW0vhZH1hnw+bl/bJUakZvx2+bNS9R0u3JcMQ0=;
 b=XJ9M/th2X29isS5oow6qAiVMAftu6cLJ+b2NaeVBnjTtniLDP715Tv01uJSS5DR4mc
 aDE1u7NYhnEDc2Upeg8MzE3dn53OldlZYFF/cE0wVBgQ3ffeMEPIWDdaqAn7zoSy4jNc
 UnZrJmbcQTuNzi0PC+wf/ASUMMOmomiCbZisnC06/SjVqv1Um8cK2jeWjtEyRHJc7QAu
 aLStkllIsQK93JRA2o2XNhxd5rzeIhNiPmYzliqjcXTF4NC7RGeDqI23hJI78wHhVGHa
 3ZDY2JrHj/U3hRSYkpWqmyqayI4fWllJjdCagCdeciAPiEP/yXinxtbGNWE8BdMzyUa4
 aFYw==
X-Gm-Message-State: AOJu0YwTMA/rCuOswMRkh4/U4Sz0e8q3j8ibW3N7qvqt2KvtzDwgs4oL
 xpg2FYL6ldgGU6ngZowcQ3nMKa7jCCFqna0g2I1dA66QL4OGow==
X-Google-Smtp-Source: AGHT+IEnlazxffhI8MK4xQCCZ5KWkc1jXe2rJ1UqH6i3GOCSDu1ZSK6jTZ9oLxoS4fLexChsTslGKLNH3a7ux3ayO+o=
X-Received: by 2002:a05:6512:419:b0:50b:f87a:66a6 with SMTP id
 u25-20020a056512041900b0050bf87a66a6mr2468287lfk.88.1703749109640; Wed, 27
 Dec 2023 23:38:29 -0800 (PST)
MIME-Version: 1.0
References: <20231218181901.337515-1-raymond.mao@linaro.org>
 <20231218181901.337515-10-raymond.mao@linaro.org>
 <CAC_iWj+a=kTUm5Kp+tgtea6tG1XgkDC+V2JeZ3zjqTS-9T6-uw@mail.gmail.com>
 <CAFLszTj6JtV=ragFvNpoCKXY+PemM+7s=DaRpgH21Rhpj2PeaQ@mail.gmail.com>
In-Reply-To: <CAFLszTj6JtV=ragFvNpoCKXY+PemM+7s=DaRpgH21Rhpj2PeaQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 28 Dec 2023 09:37:53 +0200
Message-ID: <CAC_iWj+eEqirprC8zvAR9m6hEFxXSUC01VeD8wXOUHDLePvDfQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/14] bloblist: Handle alignment with a void entry
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 jwerner@chromium.org, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>
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

On Wed, 27 Dec 2023 at 19:49, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Wed, Dec 27, 2023 at 9:58=E2=80=AFAM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Mon, 18 Dec 2023 at 20:20, Raymond Mao <raymond.mao@linaro.org> wrot=
e:
> > >
> > > From: Simon Glass <sjg@chromium.org>
> > >
> > > Rather than setting the alignment using the header size, add an entir=
ely
> > > new entry to cover the gap left by the alignment.
> >
> > Hmm, why? Does it make out life easier somehow if new entries get added=
?
>

Ah thanks. I did indeed miss that change on the spec

Thanks
/Ilias
> This was one of the spec changes. Not one that I agreed with, but there i=
t is.
>
> Regards,
> Simon
