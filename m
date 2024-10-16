Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC0FD206A5
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 07:34:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B78D988DD0;
	Wed, 16 Oct 2024 09:34:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="a8ihXwFX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08AFD88DCC; Wed, 16 Oct 2024 09:34:19 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1369488DDE
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 09:34:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c40aea5c40so1255567a12.0
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 00:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729064056; x=1729668856; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q0ScmOQv9MCWF6MJ6nE/gvSd+URXAcCSUFP9z55zfV4=;
 b=a8ihXwFXUIJisVSrCT7SruMFZixJFE/uRq2Ej6/QPwTti3c1BoJYiFHSHQnawA1xym
 u9YQZJEt8r2DQZcq43sWP8S+KH8kE9865QzSDPodcCIxr2d+zEcESnSb90790+BmsG7I
 Z5L1zoVvwp6oFS077xjBdRmy0yEV/CXKLkB1pisuan3FwpBl0J3vnsBi2DWxLQRTPKrE
 jrGpLWpmUL3WWfAYuabHBhyV8+J5WmRAS+1FlLAdfaecbA3chYwz6epQsmjMDP/w23kr
 VyZ3FGQiTcrDUZ7ZIYvcWWEYPXRrhpPAIeLPQQyPLPoZSAGadsBw70zCN7JTbQGLmx9m
 uM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729064056; x=1729668856;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q0ScmOQv9MCWF6MJ6nE/gvSd+URXAcCSUFP9z55zfV4=;
 b=uNtNUBZ83SdVtseOXBTFvO7FNVWmvCZHVu8tCMP2dXmAsiCUBdvzAFrPh5R/pVTZKt
 gbB1X92Px1GWXf+VwuTyT8GLA3WtwzaD63AaFaAs1ztrvUbfGJzV+TSPkL56VcwlhVjg
 HbtjNl1qIeHO8jOXhvo9ElA8PLYltGLCVZBJ2d8GBvz+JJZwrmjBq8+Xw+ptkIfxqBiV
 xYY2RrdY4nJS0UTZoGDAQ9vKs/c2Hkdrkjx8r6g5QdTJT88u3B0tedyRB70GSX22TbgG
 yO+4nmuJHX7vBB7GVbfGbdzlRWR1XdzTmzpN7ijG/SdnK0XvNz2wuSOsTCLNw9dhoaBN
 BHXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkuCjmjcyjIkK5tCMCydRb9o7gVZl37kHBITWuDaf7hZG3P7jGjHMbvAIFnlYTr3q8nXuQ7EU=@lists.denx.de
X-Gm-Message-State: AOJu0YzROaxRHpJumMUtjr9FONOmRtRlEqBlLP2DiSJ+Il0D1/Rf1alt
 o0XLoW5twRbDuVvoaV+fH9rpKDfWXUuGZcppgqDC7TQmLiMlt4gjHyRf6jN0QMbktL1E4C3j0R9
 CbSZxux9DsiqiN49XvnnLDzNJVQDFRpKt709OtOFXj2es3D9E
X-Google-Smtp-Source: AGHT+IEN/tGF20AMXo8iV58q1KFLeyjCmvLVoWwhhVekkbQ6k31j/ZFMoRDUK+eth/3ySmTFYb5ecWiLeS2HiLOuG8k=
X-Received: by 2002:a05:6402:3493:b0:5c5:c444:4e3a with SMTP id
 4fb4d7f45d1cf-5c94719da8fmr15066436a12.0.1729064049996; Wed, 16 Oct 2024
 00:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <CANAwSgRJO1=w40ybTHkq-BD78rPyf13JdWp_yL1qpu=xmO2V8Q@mail.gmail.com>
 <20241015183142.GQ53053@bill-the-cat>
 <CANAwSgT0ng5R73D8jWS9MzeBJBcZT6vjgmade_d5Zoyuoe-C_A@mail.gmail.com>
In-Reply-To: <CANAwSgT0ng5R73D8jWS9MzeBJBcZT6vjgmade_d5Zoyuoe-C_A@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 16 Oct 2024 13:03:58 +0530
Message-ID: <CADg8p97=48JcJKnBZjqEth0RtJbnwQJZ2p3mJT5T-L4x1MSdQw@mail.gmail.com>
Subject: Re: risc-v - efi_free_pool: illegal free
To: Anand Moon <linux.amoon@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>
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

On Wed, 16 Oct 2024 at 10:35, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Tom.
>
> On Wed, 16 Oct 2024 at 00:01, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Oct 16, 2024 at 12:00:01AM +0530, Anand Moon wrote:
> >
> > > Hi All,
> > >
> > > I am trying to create a RISC-V Archlinux image for the StarFive
> > > VisionFive 2 v1.3B SBC.
> > > Everything worked well initially, and I successfully until I upgraded
> > > OpenSBI and U-Boot
> > > to the latest versions.
> >
> > Sorry for the problems, this is known and will be fixed shortly.
> >
> Just wanted to submit a report.
> > --
> > Tom
>
> I have tried to build a u-boot with tag v2024.10, it's a success.

Can you rebase and try with the latest -master. It should work now. Thanks.

-sughosh

>
> Thanks
> -Anand
