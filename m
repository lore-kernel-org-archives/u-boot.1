Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 937F4C46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 15:09:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B900087823;
	Wed, 27 Dec 2023 16:09:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oxboeWI3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 191C48793E; Wed, 27 Dec 2023 16:09:56 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A5BA8775F
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 16:09:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6d9bc8939d0so613129b3a.0
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 07:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703689792; x=1704294592; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pxm/ppg2UtZsTetpBrbQOQbWJTS1gZSYfxGevVdSZfk=;
 b=oxboeWI33s1LKIrM1M+ZfmW9KLnTQH7tI58A0gycH4yLQW4pcz1BYU40008uBfFBXb
 FqVzzwPwkeiNaT9f3sIpLNTk8m3ks/LxofMaL+ATNBbELHGiLlQWAjFhGacDLfRI0rOz
 ambBshrdM/paN6xr19/Q1VT087k44ZhDibwlJ0NlQ06bhmdV03n4ggZbWdPbea7Uaetq
 Wo/wyRjgAhrjH/Dx+skoBNkt0IIO2l5ETzvqHh9KwhWHdkL/AvBuyAUVQOlJCzj/mN9Y
 EbGkTpJEa/lDl3kZyK5ojp1UfULTOAtygfNW1pdX7og/iCYHfGePzJ5IciAu7DW5UT0b
 kZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703689792; x=1704294592;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pxm/ppg2UtZsTetpBrbQOQbWJTS1gZSYfxGevVdSZfk=;
 b=Q2GLlQKzj5jBF/C96QPhgzXaaKCW1unUGW4ojbChETGGI80ePJhtOV7esMZcA/EmL+
 4KY1M6v2ARkIecyILNlpthbf5MoTHN+Aq0lZxp2XYZm4z30SYkwJSFAJ5gRga+FZHKQp
 fj6RZ62ZzD3iXgCJYSGJvk7hhQuuLsGpgKpIe0DL3dqxNnQz6JNhLtFbq93rLQBOjf/+
 szwRepq/8TWLYPyhu0t0iA1ffPaVJeJ74bI5TLlGIBZJeA+fBk4Qj9Cx6Qap1J08Zm1h
 rzyoqPCM/ycGWKeXiQSPkXqFX4TCGdKVl3hGinvgKDhPVKqU6sLiW2PvnluRYDLFTRqT
 kI0g==
X-Gm-Message-State: AOJu0Yw4TWZY0DVoIh2DKXmS0F/rE5XWvlksdsv42+rinEpPLsMQb8kC
 YiNspMlyPWB8XwzauFMvSK3rxO8AwthZFQdD67nNWBivYbpgdA==
X-Google-Smtp-Source: AGHT+IGEo9lf1R/XSYq44UAcSytoitB2RirTZFVRnP4BAf/YaXcAEReg2qNQXnjedYKZodLd1f4HlvJrYg0lbnszK7g=
X-Received: by 2002:a05:6a20:3d0f:b0:195:2008:d758 with SMTP id
 y15-20020a056a203d0f00b001952008d758mr3986202pzi.59.1703689791946; Wed, 27
 Dec 2023 07:09:51 -0800 (PST)
MIME-Version: 1.0
References: <20231218181901.337515-1-raymond.mao@linaro.org>
 <20231218181901.337515-12-raymond.mao@linaro.org> <ZYv5wc_D1VgRcQKw@hera>
 <CAEfUkU+4ePLot_81gx7JH4Fcs=qPxa-jCSEDrEXswwbHA+uyQQ@mail.gmail.com>
 <CAC_iWj+fU6kVZd2Eq6y+mw65Y3mRvq3GUkE=0Ci5WvJMvqUC+w@mail.gmail.com>
In-Reply-To: <CAC_iWj+fU6kVZd2Eq6y+mw65Y3mRvq3GUkE=0Ci5WvJMvqUC+w@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 27 Dec 2023 10:09:41 -0500
Message-ID: <CAEfUkU+EvPnShF4xVowVZnWzP01XmgLFgRbsR56KXwKVho+Mvw@mail.gmail.com>
Subject: Re: [PATCH v3 11/14] bloblist: Adjust the bloblist header
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>
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

On Wed, 27 Dec 2023 at 09:58, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> On Wed, 27 Dec 2023 at 16:50, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Ilias,
> >
> > On Wed, 27 Dec 2023 at 05:17, Ilias Apalodimas <
> ilias.apalodimas@linaro.org> wrote:
> >>
> >>
> >> [...]
> >>
> >> > - * @chksum: checksum for the entire bloblist allocated area. Since
> any of the
> >> > - *   blobs can be altered after being created, this checksum is only
> valid
> >> > - *   when the bloblist is finalised before jumping to the next stage
> of boot.
> >> > - *   This is the value needed to make all checksummed bytes sum to 0
> >> >   */
> >> >  struct bloblist_hdr {
> >> >       u32 magic;
> >> > -     u32 version;
> >> > -     u32 hdr_size;
> >> > -     u32 flags;
> >> > -
> >> > -     u32 size;
> >> > +     u8 chksum;
> >> > +     u8 version;
> >> > +     u8 hdr_size;
> >> > +     u8 align_log2;
> >> >       u32 alloced;
> >> > +     u32 size;
> >> > +     u32 flags;
> >> >       u32 spare;
> >> > -     u32 chksum;
> >> >  };
> >> >
> >>
> >> Aren't fields still missing from the current version?
> >> e.g max_size and reserved?
> >>
> > They are all in. Please see:
> > [PATCH v3 14/14] bloblist: Align bloblist used_size and total_size to
> spec
>
> Ok. But why aren't we squashing this to #14 then?
>
> I can squash other changes with #14 except the ones for `align_log2`.
And `align_log2` with patch #12 due to the dependency.

Regards,
Raymond


> Thanks
> /Ilias
> >
> > [...]
> >
> > Regards,
> > Raymond
>
