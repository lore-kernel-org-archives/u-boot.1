Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA23CD4938
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:07:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 481C886D27;
	Thu, 21 Sep 2023 03:06:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="2ny0J+nF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3001B86D21; Thu, 21 Sep 2023 03:06:08 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 214D186D33
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:05:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-59c2ca01f27so5241027b3.2
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695258357; x=1695863157; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HbCnK6iZMxK22jZTr34YxQICBAYgpGszNyWExNDA7WI=;
 b=2ny0J+nFqqup+0I5ZTT6Jern5hR1ci31QAcloAZK/1LyrtY6mriBImHWXlabidTCYk
 rGwMcnP2GrYXAPgEDvr30wNXK0T6P9Je/+LJF6nRktgk1S3tLKP5ck2yzxjoZbpLr3CS
 0/5wmTUw+0Dnrif44O5Y6UUKZV2NixIUJzHTTtHaEowYi8zpr7Fd/mUGb0UeL69UYpG4
 VvGgTEuawYj8SomD+7nRk4Bh9d9RRu17LCQJp0a7hkJiewdDdn5LjZRhF0pc7GAKA3DQ
 ypnhAqLWCP7Iv//AsULOM7Zz7xKFdj/CJPGSFuRAuAXnHpakdpVfNngptCB/rypZfrVf
 mcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258357; x=1695863157;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HbCnK6iZMxK22jZTr34YxQICBAYgpGszNyWExNDA7WI=;
 b=toIlC1Xg14HxJmkE3V46b5tY0LJEfimGB36f9T7S/SNJCETC41dYEXQ6b1o/ty6PBw
 fFBWkPRW2duI8CySbRyn8702dLS6c1YumxLDvpcIaioR8fLbEMtDIJn1vXv0i92m5vqB
 xZK1eYGhJ9gPzjkfbXzC6Ol3ng4ZF7wQhaudR43wjj4bafoUqHy6i8bwjhr/BhtRTtTk
 ciGvk15bYCVS3YuxdhwFPVtGwOAiofseS3g2S4xiU59G6B+BkPG2b++fFv/jT41t25M8
 V/IhGyV00KFeLm0PqcE53a9EpGI86aKLddMfbUjDRGARH0ACYtT06tA78l11VhCTWWed
 1g4A==
X-Gm-Message-State: AOJu0YyXgnIPcAP2+nlxLDCferlu9Hb0rdJtahUVROJtZ5obMfpNvyv3
 UT70PrNJjMD/ntSTmKRSDqlZzAko6R9VXuleuakcRg==
X-Google-Smtp-Source: AGHT+IHY1/eAWj/UlyDD6PVBiNZBtIK8uiE1Cc+RTV++sY9GYUg7yeMXqUym896on595vZ5mEunUpA2lp0I5VHSDG9A=
X-Received: by 2002:a81:5e05:0:b0:589:8b55:fe09 with SMTP id
 s5-20020a815e05000000b005898b55fe09mr3595973ywb.50.1695258357392; Wed, 20 Sep
 2023 18:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230911163536.20735-1-avromanov@salutedevices.com>
 <20230911163536.20735-3-avromanov@salutedevices.com>
In-Reply-To: <20230911163536.20735-3-avromanov@salutedevices.com>
From: Simon Glass <sjg@google.com>
Date: Wed, 20 Sep 2023 19:03:17 -0600
Message-ID: <CAPnjgZ3C5c21jpRF8ao8gRB0qsOsnhXH05aYRac8jT8Ef3CWNw@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] sandbox: add sandobx sm uclass driver
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: neil.armstrong@linaro.org, narmstrong@baylibre.com, 
 takahiro.akashi@linaro.org, ilias.apalodimas@linaro.org, post@lespocky.de, 
 marex@denx.de, msuchanek@suse.de, sughosh.ganu@linaro.org, 
 jh80.chung@samsung.com, paul.barker@sancloud.com, u-boot-amlogic@groups.io, 
 u-boot@lists.denx.de, kernel@sberdevices.ru
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

Hi Alexey,

On Mon, 11 Sept 2023 at 10:35, Alexey Romanov
<avromanov@salutedevices.com> wrote:
>
> This patch adds sandbox secure monitor driver.

Please fix typo in subject

>
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  drivers/sm/Makefile     |  1 +
>  drivers/sm/sandbox-sm.c | 76 +++++++++++++++++++++++++++++++++++++++++
>  include/sandbox-sm.h    | 18 ++++++++++
>  3 files changed, 95 insertions(+)
>  create mode 100644 drivers/sm/sandbox-sm.c
>  create mode 100644 include/sandbox-sm.h
>

Reviewed-by: Simon Glass <sjg@chromium.org>
