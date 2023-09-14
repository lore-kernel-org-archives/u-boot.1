Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDB6EEAA7B
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 22:43:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0493C86604;
	Fri, 15 Sep 2023 00:43:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PV/bYmi7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D873586679; Fri, 15 Sep 2023 00:43:37 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07666865D0
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 00:43:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-502f20ace96so452347e87.1
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 15:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694731415; x=1695336215; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=86EcK4l+tGFeyJUW8cVy+IEHvFmc25Oo7/yxlTo6Rv8=;
 b=PV/bYmi7USowTzV1gR6a1h24zROjEHwzyurfuL+BFhBGxCp+ITFcbmlpl9sqLO/UZA
 S+FVmB1ASnjeBFmigoE9SsP0itp+AYT0PWS3tJDEmuRvSl7xMb+fanrQp/0h1bAPIPy0
 GTimSSKoqQxLbmNa2OfnT6mnfJC2NXHbf/X5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694731415; x=1695336215;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=86EcK4l+tGFeyJUW8cVy+IEHvFmc25Oo7/yxlTo6Rv8=;
 b=hcI7iOdjA9ok3FcNLK4AOUT8Y/k6mGS+u4AQ1HPozcbj7Go/IgFab6UamMMRvHBPqd
 4AN7alwwh1lcf4GXLS6BJTh+RrjNff4Du+6jKGLkHEDI2q1XfTFWnRBl+tU6izkFrEGE
 APYuGFHT0yhgUj559/kv4GP1cAg7Kl4ArWSlMWQXCiRC+jPoSkHO+jEeaM1jIKZXBGWr
 KEfAR49kt+x7xxabC9GKLtvCTeWC44sglA/lMw809r8fCbEtE3H2GnNMIMnOEJlMr+mQ
 8ujRnKtExjttfYp+8ceStldpS73Xeg91qJnJe1W3JhnvZ4qBvN5NxfZEhfogxIgBPQJs
 GiFw==
X-Gm-Message-State: AOJu0Yxb7ITQHaHR9R2Mt0N+U8R0X9TO4kzSye7tdfFfJPJMYmvrNIUV
 4u8zSWSScilJTTGlsIzHld1D4rlgwsPmSzDVJVUneQ==
X-Google-Smtp-Source: AGHT+IEpVZkv4zcUJV/eu215ySZ5DQvWCkLQaPhDtcwfmse9yoIt9D4zBPde5hl5D/W0yzFutbqADYWwlp+oqmChJVs=
X-Received: by 2002:a05:6512:3255:b0:500:78ee:4cd7 with SMTP id
 c21-20020a056512325500b0050078ee4cd7mr70887lfr.23.1694731415090; Thu, 14 Sep
 2023 15:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230913161633.999542-1-massimo.pegorer+oss@gmail.com>
In-Reply-To: <20230913161633.999542-1-massimo.pegorer+oss@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 14 Sep 2023 16:43:24 -0600
Message-ID: <CAPnjgZ1V+7CXn90HPxvMSDaC5iihfsvjsJ4yDuOonOeV=2mX4w@mail.gmail.com>
Subject: Re: [PATCH v2] binman: doc: fix reference tag placement for Logging
 section
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Wed, 13 Sept 2023 at 10:16, Massimo Pegorer
<massimo.pegorer+oss@gmail.com> wrote:
>
> Move BinmanLogging reference tag after section "Signing FIT container
> with private key in an image" and just before section "Logging".
> Remove meaningless line with incomplete sentence.
>
> Fixes: 0f40e23fd22 ("binman: add documentation for binman sign option")
> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
> Changes in v2:
> - Removed incomplete sentence (confirmed by Simon)
>
>  tools/binman/binman.rst | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
