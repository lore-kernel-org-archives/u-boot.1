Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13055C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 15:33:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4215486CF4;
	Wed, 20 Dec 2023 16:33:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ypdm8JhR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0514487469; Wed, 20 Dec 2023 16:33:22 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B71F6869B6
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 16:33:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6d3165ac96bso2447534b3a.0
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 07:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703086398; x=1703691198; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dXsJ8LaeyFTUhBYp5Lwaj+4kpnhkSrtBU6xnCPbTP3s=;
 b=Ypdm8JhRO9KjJHmobQqlIoe14IIQRaQNjWrFyEqphyLR0CfJZc1EdjhczmsAtGyhal
 O0Dx/qnQvN+acXin4JaX6gFG0DBZICiv0XAN+cgI7CKXF8Ng91dZ9vouBgMzkKS76IKo
 R4qlWTa+/1/dqPjM9F3V2cBzZdTvf3HHSyevIP5MiuE2B1mH+C0R0cPNtpRQWyarFayh
 ipelhqhgbcFodmxkRG9Kb9J/+dGGP9OPMbQL4eX99titqG6qVXK1ZXf+MI6pcXBH6GFG
 VR536xLdfW680MyGX4jr2pEApL2pBsreWEh9Znu4NaJrnKQ2QVzD0qugf/6JT6Ed6Ppr
 YVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703086398; x=1703691198;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dXsJ8LaeyFTUhBYp5Lwaj+4kpnhkSrtBU6xnCPbTP3s=;
 b=Ph5RbOIQUadXoBkYRES1Z2cCc48Jvd6QHDnBg01luCREALgMhzFyh+k23ZDT5c+DbR
 WA/vNo/nAn1Y8JOUAAUnFevgJ0M2ceEVKsz8hl8GG153K48v7xjHaQxUK36T9wqsZW25
 egfA3XePvSxqkOdsabG38eaBPyRy9nnKqkAIgm9CFVO+gc2Uco1pWuaG28W/RTnAPwKP
 qbEmzMrqceuOqEV/WCTtYjeOx1nPftQHSI1uK+qufhD5ni36OvrPRS5yq+a62sOnbtap
 Tq91AhyQpVk+tT4xK7kouMdjVpszJuM3D6eL6XRKo+LS346ymjjAP9f7IOvJHo7FiPRn
 68Iw==
X-Gm-Message-State: AOJu0YxGr84hyOCZje+W+nsjeidBrrifJgFvEP6Vyo7+glWmIQb9AR2Q
 tT331MaMpfRa487ayIAo2pViM8guA7+bREOLt8NEHg==
X-Google-Smtp-Source: AGHT+IH5Mapjz0ROE+EWiyGbapv4mM5DuhGqiLlj+e4HaVsCLcJkQpANeVeobXrKD7LGTtgL7BfbamBoFQr6VwVIcBE=
X-Received: by 2002:a17:90a:d389:b0:28a:d567:8da2 with SMTP id
 q9-20020a17090ad38900b0028ad5678da2mr6207235pju.2.1703086398078; Wed, 20 Dec
 2023 07:33:18 -0800 (PST)
MIME-Version: 1.0
References: <20231219211114.393193-1-raymond.mao@linaro.org>
 <20231219211114.393193-2-raymond.mao@linaro.org>
 <CAC_iWj+Ld1Tpw4pyZ1P=GS6We_+CfUFvDC7HmDTug4x2fDmMFw@mail.gmail.com>
In-Reply-To: <CAC_iWj+Ld1Tpw4pyZ1P=GS6We_+CfUFvDC7HmDTug4x2fDmMFw@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 20 Dec 2023 10:33:07 -0500
Message-ID: <CAEfUkU+O2EOVSn9BTUR7S4ZU2Lkx0CXe0OPZwSn4gH2audwb=g@mail.gmail.com>
Subject: Re: [PATCH 1/5] bloblist: add API to check the register conventions
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>, 
 Nikhil M Jain <n-jain1@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Baruch Siach <baruch@tkos.co.il>, 
 Michal Simek <michal.simek@amd.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sean Anderson <seanga2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

The rzero refers to the boot argument that must be 0 according to the
register conventions of FW Handoff spec.
Yes, you are right. I should check this at the beginning of the function.

Thanks and regards,
Raymond

On Wed, 20 Dec 2023 at 07:54, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Raymond,
>
> On Tue, 19 Dec 2023 at 23:11, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Add bloblist_check_reg_conv() to check whether the bloblist is compliant
> > to the register conventions defined in Firmware Handoff specification.
> > This API can be used for all Arm platforms.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> >  common/bloblist.c  | 15 +++++++++++++++
> >  include/bloblist.h | 12 ++++++++++++
> >  2 files changed, 27 insertions(+)
> >
> > diff --git a/common/bloblist.c b/common/bloblist.c
> > index 625e480f6b..232ca4c6ce 100644
> > --- a/common/bloblist.c
> > +++ b/common/bloblist.c
> > @@ -542,3 +542,18 @@ int bloblist_maybe_init(void)
> >
> >         return 0;
> >  }
> > +
> > +int bloblist_check_reg_conv(ulong rfdt, ulong rzero)
> > +{
> > +       ulong fdt;
> > +
> > +       if (!IS_ENABLED(CONFIG_OF_BOARD))
> > +               return 0;
> > +
> > +       fdt = (ulong)bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
> > +
> > +       if (rfdt != fdt || rzero != 0)
> > +               return -EIO;
>
> What is rzero supposed to be doing here? If its only valid value is !0
> why arent we checking it earlier?
>
> Thanks
> /Ilias
> > +
> > +       return 0;
> > +}
> > diff --git a/include/bloblist.h b/include/bloblist.h
> > index 84fc943819..b5d0f147f6 100644
> > --- a/include/bloblist.h
> > +++ b/include/bloblist.h
> > @@ -461,4 +461,16 @@ static inline int bloblist_maybe_init(void)
> >  }
> >  #endif /* BLOBLIST */
> >
> > +/**
> > + * bloblist_check_reg_conv() - Check whether the bloblist is compliant
> to
> > + *                            the register conventions according to the
> > + *                            Firmware Handoff spec.
> > + *
> > + * @rfdt:  Register that holds the FDT base address.
> > + * @rzero: Register that must be zero.
> > + * Return: 0 if OK, -EIO if the bloblist is not compliant to the
> register
> > + *        conventions.
> > + */
> > +int bloblist_check_reg_conv(ulong rfdt, ulong rzero);
> > +
> >  #endif /* __BLOBLIST_H */
> > --
> > 2.25.1
> >
>
