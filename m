Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19FFC54ED0
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 18:06:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7245F82C0C;
	Sun, 25 May 2025 20:06:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Bae4l5D7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30F6782C15; Sun, 25 May 2025 20:06:07 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0170482C0C
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 20:06:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ad69e4f2100so222051866b.2
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 11:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748196364; x=1748801164; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1eAnJlOO9WABNqgs4c7emw1LFewbNcCmktQzBrw8XGo=;
 b=Bae4l5D74GvYY7aCRyyDPBvIZPb0dLBrCX5pwiTiUTJX0tvvA3D1uLGf273KQLmEKk
 3aedgfVZS8lBYck2Vagvo3kOqT6FgYEFy+x0rDFfmKq72DG+FmN6dz/7MupEod321b1V
 hMWNo7VDFgFNxyLyKdjbBmX7INAYD+JaIT19Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748196364; x=1748801164;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1eAnJlOO9WABNqgs4c7emw1LFewbNcCmktQzBrw8XGo=;
 b=BrGreeikWRIxdOWplMLJ+fCdB0V0qihi5KecbBYpBppnOGAlDXG6WHXjjonXCz0jCi
 HX9b3qBMhU5ThimL3u7piOswUUGwspc7SQ7YF8MpvoMAOZ0gtmLZStITX8CG1YAK0XfN
 LMMWereHCfWYVVjVmpAcShDJ1kaIgCyjiYd/qG8iTgui/IXHmA4x2wZg7snm6LZ4ZDaK
 J3DXBWV11eeP1KhfpGqp11H86zmkChbZD2Ehpo1rt7AXondZQq32BhbiENRWv6TQtiHs
 zaDpksoQxy9WiB+2iFGGBUb1WVl1yxfLeMGOwKoG9Xd2C7+SfnXhtNqElpXDOwmYnWDx
 w0zw==
X-Gm-Message-State: AOJu0Yw9X6eLu0ofe/QXbzx7ngCgW7JBlSRqal5k82aIppdQ6GgKW1yG
 nDpwttpufXvI3vtHppTO+XaIhwiC5uHy1/6OPspqlvauMYZXaGFY7RsqzADkirNgBSQhvZujbWO
 TENWBtBElPa4rn7DqLMixXViFa5rg1T4Lg4yF+YwLtZd0IKMzdtpX8Q==
X-Gm-Gg: ASbGncuB5ocSmF22tejJFKQKxDcfJF8tTfquLbRLzlXkt1h0R1cg6Q3mE7T8AELpuS4
 TdSEf46lUMfn6Mn71YrDjODmDKsS4srBIzZbVadYOku71fqaCGHtsXGUvQCtPZbuazlqueKRGsf
 70QNrU4ESBo44HnSVbHa3v5Qw5SKmr4Tc=
X-Google-Smtp-Source: AGHT+IGzGTBVQf+m7pOwhQ4ZpyyBs/OU/v/w8Km+w6FA/m+rffeSrqDPixAm9SUONV9bASKjRACQRAwoqRCS05hZXYs=
X-Received: by 2002:a17:907:7b99:b0:ad2:39a9:f1b2 with SMTP id
 a640c23a62f3a-ad85b32b957mr527353566b.59.1748196364408; Sun, 25 May 2025
 11:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszThbRhKF1Xwqk+hLu8Y-VXB6+fHVXYfphfVjWMN=dVC1dg@mail.gmail.com>
 <20250525135553.GQ100073@bill-the-cat>
In-Reply-To: <20250525135553.GQ100073@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 25 May 2025 19:05:52 +0100
X-Gm-Features: AX0GCFtJfEZBswgDIDS28RVHvTsYBUtgoFROZtqODptysJQ-MXe6n-b8EfXWRNA
Message-ID: <CAFLszTgPK_TWjoaJPMa6RAH-pugpO_uhkm-VafQLzaNuFZRDLw@mail.gmail.com>
Subject: Re: Broken boards?
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom,

On Sun, 25 May 2025 at 14:55, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, May 25, 2025 at 09:46:03AM +0100, Simon Glass wrote:
>
> > Hi Tom,
> >
> > It seems that some of the boards in my lab are broken in your tree.
> > Have you noticed that?
>
> Your lab has never fully functioned in mainline, so no I've not paid
> attention to it and don't use it. I figure it's part of the lab
> maintainers duties to figure out false failures and
> more-or-less-expected failures.

Oh, that's a shame. I didn't know you had stopped using it.

I use it on nearly every PR. I did once send a patch to disable the
boards that were broken, then another to re-enable them, but I don't
think you took either of them...

Here's a recent run showing a few problems:

https://sjg.u-boot.org/u-boot/u-boot/-/pipelines/794

But x86, RISC-V and some rockchip seem to be broken in your tree.

Regards,
Simon
