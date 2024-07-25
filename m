Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F3BC3DA70
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 23:35:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A67DD88701;
	Fri, 26 Jul 2024 01:33:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HXAofjO1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47B2688732; Fri, 26 Jul 2024 01:33:13 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6951D88702
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 01:33:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6b7af49e815so677886d6.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721950389; x=1722555189; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5ivEAEW7LhCgUEzM8Dbke3/KHePnhrKCrH+S2y0+faA=;
 b=HXAofjO12e6Sc3vE0O6l4URAVZYxlpoWOjQfvZzbcttiSCQqeplnmcc18gnzl1zvWy
 b3awvcJ0cKJKfTz81NNixI7QEEzbl2+EmJjXiuGbrJNDuELzYMRK6HwOUWSlwrJvoQhB
 RbaQZ5XDOlfP73zb5ef4+7YeWTnC4NQkISxF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721950389; x=1722555189;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5ivEAEW7LhCgUEzM8Dbke3/KHePnhrKCrH+S2y0+faA=;
 b=DiUTK8711TherCl019eXByjsKzuwD+KNuIokEM/7rbGgUwi198czea01ttAm2CLb1o
 Yd3lFRgi1INYqAOflC++NRohYe4GzUlVdswPSD3Ct7BWlod7XFp5xZcKOx0THKgxUtqq
 RPn0C94wbfmrQ0Ym8PuFJDbxM0cg1mdO+lrCve4OFt7EAmEwiDnQD/KGuUl62GvrXIJQ
 OwlGf/C6R5+Ev4SvHO/mx4g1LotTmq8zaPMZIICmgF7BKYWUBS2OP0VfL0qAJeqMWNuP
 PhsExJ7DRwSdTxY/191zrdoRJrxk8+Zfnt8tT7Mt3NULSHzw11lYf+k3aj3DL/WCK1U8
 vPPQ==
X-Gm-Message-State: AOJu0YzHXfJAz/sQUs/gJrEkI1eJ2DyH78mweh1ezcjoWqKWXb6s7SfE
 Fo+WiUgO6+7gZSy43BXzd0SGR/QjHtnZFKy2SZvXlM83YgNYnkgNZgt0pXTiTVELOlPMvI8PUuQ
 ++T0NU+HeVJpvV3fuZgEh8SZVVP82RpA+fT9lwp89roR1JYY=
X-Google-Smtp-Source: AGHT+IGpTWrRcaUdoKmEkr4pTxYVpKFMEmD2jKT8p71+yY1MYM/cpj2VJVVtBomv+18vs8BIRKDy6Wp+FDOJLypwhPo=
X-Received: by 2002:ad4:5ced:0:b0:6b5:dfe2:9a5c with SMTP id
 6a1803df08f44-6bb408923a0mr44407306d6.55.1721950389318; Thu, 25 Jul 2024
 16:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-41-sughosh.ganu@linaro.org>
In-Reply-To: <20240724060224.3071065-41-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jul 2024 17:32:58 -0600
Message-ID: <CAFLszTgSXD3FqwtYjGEHWyt=gxGVZFYCzMs8DDhTkxOg6eW+Og@mail.gmail.com>
Subject: Re: [PATCH 40/40] lmb: ut: re-enable unit tests
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

Hi Sughosh,

On Wed, 24 Jul 2024 at 00:06, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> All the changes needed for making the LMB memory map persistent and
> global have been made, including making corresponding changes in the
> test code. Re-enable the unit tests on the platforms.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since rfc: New patch
>
>  configs/sandbox64_defconfig        | 4 +++-
>  configs/sandbox_defconfig          | 7 +++----
>  configs/sandbox_flattree_defconfig | 4 +++-
>  configs/sandbox_noinst_defconfig   | 8 ++++----
>  configs/sandbox_spl_defconfig      | 8 ++++----
>  configs/sandbox_vpl_defconfig      | 6 ++++--
>  configs/snow_defconfig             | 2 +-
>  7 files changed, 22 insertions(+), 17 deletions(-)

It would be much better to change the tests as needed, so they keep passing.

Regards,
Simon
