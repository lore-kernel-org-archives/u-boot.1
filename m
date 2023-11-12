Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA485C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 07:43:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 871BB86EF1;
	Sun, 12 Nov 2023 08:43:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vhptH0Kx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C8FA86F1A; Sun, 12 Nov 2023 08:43:53 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EE7E86EE2
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 08:43:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2c742186a3bso41495021fa.1
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 23:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699775030; x=1700379830; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HrWwPqdxQLXtGfh2eLmuWUDL7EK5pVMVif2Z5ODHXUM=;
 b=vhptH0Kxrm6yDYEnikQzqOkYSdGVkVxwA8ajdBUhmZi24zAhW+I3XvfwARzmZBW998
 QeU1opK3353rMuw181RetzBiubDFxaXTDw3vo+kNYc+pfgehGNx+mY6J32/5sl99/Itz
 2EMi8MakRdq3P/9dPsnhWCrKKb0jni0EwcBMUiUWbkZJUiPlwZmMzzWWbzhLVcq4rhpB
 DeECf3p21ISJU1JTravgZOR82VthqadTW7JbyuAIawZLygWMa8IFgIIs6yONR67TJWMV
 R7NhHI7uN7soSsB8sjeOPwXrmjTiGfN6HvSPVVe6YWXZLdyJjCYkZckIkxFU2R1M3VgO
 XFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699775030; x=1700379830;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HrWwPqdxQLXtGfh2eLmuWUDL7EK5pVMVif2Z5ODHXUM=;
 b=cWqWj3eQkYr4jM+T7zdc6+/pYbNZv/Jiz6AAHga4h2j4jD4lAXEcNalBhYP03wdCfL
 tSJHNqP5dABVO99kj4kQc5h71TLidQNnzzX0ZlzUPLXS/gACTFuA6daklwDlSahY7Ccg
 2QyF66C4ouwX1VAh9dFVZMhCJK+6ifWxHmRMQcY4POKevg6uGd6XFM/U1Rzpj49jS4k3
 MnQrU5+gP4ofIbdQyVeNcCJeGnX0RVOT8pObT7XbiP+Br7+aPvPx1E+yVsmyFk7Ktv1a
 3R1eCf1AnyZBzctN1knVr6VV7C+yNdxGVK3aTWLWb1OkSBHjXeXd0XYjHxNF1+Q7a2ef
 a6/A==
X-Gm-Message-State: AOJu0YxTjexxEDWVldIqmD3eUZMlN/ezEdI+7SO8azGEQP0mAlMllnFR
 bsvGwgiHbYs7EP/bMS0cRy2LjEbD29uek6G13eBzDA==
X-Google-Smtp-Source: AGHT+IFcJH8FbYdm0rd5VA6hjFfo6o5t7Co442x4RwEEebhp5R1Ztx0H58vc2Qi9FBaR+/lsdhHH2Wn5JcRWZan41KM=
X-Received: by 2002:a2e:9b9a:0:b0:2c5:1542:57e4 with SMTP id
 z26-20020a2e9b9a000000b002c5154257e4mr2416674lji.31.1699775030263; Sat, 11
 Nov 2023 23:43:50 -0800 (PST)
MIME-Version: 1.0
References: <20231111003530.20369-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ3BKo0RzMVeZbVgVqdST=Odoyi=ZRrQzh11HNZp-Voj=w@mail.gmail.com>
In-Reply-To: <CAPnjgZ3BKo0RzMVeZbVgVqdST=Odoyi=ZRrQzh11HNZp-Voj=w@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 12 Nov 2023 09:43:14 +0200
Message-ID: <CAC_iWjL6SiyhRVQivhfCnKg6wZt3ofm16GA8tTyiPN9tf55Tig@mail.gmail.com>
Subject: Re: [PATCH 1/1] tpm: remove superfluous check in tpm_tis_send()
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
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

On Sun, 12 Nov 2023 at 05:08, Simon Glass <sjg@chromium.org> wrote:
>
> On Fri, 10 Nov 2023 at 17:35, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > Checking if variable chip is NULL after dereferencing it makes no sense.
> > As discribed in [1] it is not expected that the variable can ever be NULL.
> >
> > [1] Re: [PATCH] tpm: avoid NULL pointer dereference in tpm_tis_send()
> >     https://lore.kernel.org/u-boot/YaFwDtKKYRr7qzWc@apalos.home/
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >  drivers/tpm/tpm2_tis_core.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
