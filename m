Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E751C48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 13:03:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C57187EFF;
	Mon, 26 Feb 2024 14:03:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DHJuvYlT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9A4E87F02; Mon, 26 Feb 2024 14:03:28 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D642287EF4
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 14:03:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-785bdb57dfaso195177385a.1
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 05:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708952605; x=1709557405; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6ZFx8pz3TiPZJ6JQGo3dx0H9dJOnmWZWn/a9jfgHdQo=;
 b=DHJuvYlT64qeG2HeqscE/XnuCGd6o9rix6ybZEuOshRxRnn/gx43ss0pOalm56bqvs
 k5GXRTdv3ILAF6EkA/NyXO7mUqtGgWLCZl66kR1+7hHEKMiGjP4YFjMxrXVW8q8sUu0c
 x9OGE4v72hXn++DjJlFEcyYNB3Bx0w7qi+CUI68QpCRQWKmD8OdzjOSQlZZLujmbAYCj
 Y91K2QADjY2aXAGvmVjlK9N/A9QFAVjX4EHh2kwcoNzqSnGxFEKgwoB7pRsOTS6/3US8
 aP911KD933Bn5dGcwV1zXsMr9uUXgMnIU6TbiFLrnCJsiDn9rQvhNJiRMrvoOreDHn9f
 9f0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708952605; x=1709557405;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6ZFx8pz3TiPZJ6JQGo3dx0H9dJOnmWZWn/a9jfgHdQo=;
 b=pOgvIdtbb/SaNys6za2nOIMw8pkflTIKxmMmd2SgLBCnsgiU8Ox1a5OTWN78kwJk/w
 utvVN9/3WVMLC+9mWhAuedGJsGqSEnSe5QAGsm+0SjxveIKGbva6T1YaCH7WTFZ6jM1u
 qsoxhuX8N/UQYsgkyQ6asbs4OMx00fpKc6+DV+9pEZzuC1wEDsMFVBa1qrm2YqzJ3ow7
 kF8FnBIKc/Ym0JoJBHNdIxAawqSoZJK96xNtLhLPgfbwqU4e5tB6RAZiKkinm4GqtEgw
 3xeOW+r9WR9r97IxWzPKkVSjt3mnCpumg7vXX5GMcStQ9gKRUjLPeIWdbzEmWh/PaOrG
 Zkfw==
X-Gm-Message-State: AOJu0YxPoi0KmkRoHmdEj+s79W+FP8ffijiIniNCwV1JNLnlCQotHBh/
 bYZCzKXp6mBlrKRvpkWjJqHR2Fo93dBGeCgyLDIQc6ZTYsSHoJm11Vx5y7OvSZmr7MrGDf5XeXC
 SJgnQYmsqJZ4CnRmfglmIDXRw4iJanAyjVOnpJw==
X-Google-Smtp-Source: AGHT+IGBsKTO7B0HSOEPADvYdsqhO4pRyUD7B1EVlVx45m7TAOISt9VtX9oktqsrquR7oJaD+zKCpJHa79PfkIDGNRg=
X-Received: by 2002:a05:620a:bc3:b0:787:b815:247a with SMTP id
 s3-20020a05620a0bc300b00787b815247amr11119174qki.34.1708952605585; Mon, 26
 Feb 2024 05:03:25 -0800 (PST)
MIME-Version: 1.0
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-3-sumit.garg@linaro.org>
 <c8f5815a-bbec-4efe-95d0-77dec441a183@denx.de>
 <CAFA6WYOhyHzn+XOsUwrqs5kajHjSFhDcsHGu6=CAB9dT+VCV8Q@mail.gmail.com>
 <583d9f9d-6f95-464d-a912-aebaa837dd7e@denx.de>
In-Reply-To: <583d9f9d-6f95-464d-a912-aebaa837dd7e@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 26 Feb 2024 18:33:14 +0530
Message-ID: <CAFA6WYNDXmQJ4mPo6HZ8bZnFx0+9qwqHcG20F4vUH3YGRa92aw@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] reset: imx: Add support for i.MX8MP reset
 controller
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, marcel.ziswiler@toradex.com, francesco@dolcini.it, 
 trini@konsulko.com, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, 
 festevam@denx.de, andrejs.cainikovs@toradex.com, sjg@chromium.org, 
 peng.fan@nxp.com, aford173@gmail.com, ilias.apalodimas@linaro.org, 
 sahaj.sarup@linaro.org, fathi.boudra@linaro.org, remi.duraffort@linaro.org, 
 daniel.thompson@linaro.org
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

On Mon, 26 Feb 2024 at 16:26, Marek Vasut <marex@denx.de> wrote:
>
> On 2/26/24 11:43 AM, Sumit Garg wrote:
> > On Mon, 26 Feb 2024 at 14:24, Marek Vasut <marex@denx.de> wrote:
> >>
> >> On 2/26/24 9:04 AM, Sumit Garg wrote:
> >>
> >> [...]
> >>
> >>> +static int imx7_reset_assert_imx8mp(struct reset_ctl *rst)
> >>
> >> Linux calls those imx8mp_reset_set() can co. which is less confusing
> >> than imx7...imx8mp() , use it.
> >>
> >
> > IMO, it would be more confusing if we choose two different naming
> > patterns for the same driver, see existing function names
> > imx7_reset_{deassert/assert}_imx* pattern.
>
> Maybe create a patch which updates the naming scheme ?

I can do that as a preparatory patch.

>
> Using two SoC names in one function name is confusing I think .
>
> >> In fact, why not copy the code from Linux outright ?
> >
> > I suppose the question here is to not convert the driver to use
> > regmap, right? If it is then that should be done as a separate cleanup
> > patch.
>
> If it isn't too hard, please do the clean up first and then add the
> MX8MP bits on top.

The coding part is easy but it is rather the testing part which I am
worried about as I don't have access to all the platforms which rely
on this driver.

-Sumit

>
> [...]
