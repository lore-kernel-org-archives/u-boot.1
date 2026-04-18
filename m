Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236B8F99C63
	for <u-boot@archiver.kernel.org>; Sat, 18 Apr 2026 00:47:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 199F1841C2;
	Sat, 18 Apr 2026 02:47:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dGb27lug";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 284C48405A; Sat, 18 Apr 2026 02:47:38 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6CFA839D9
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 02:47:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b9825ba7f9dso344114866b.0
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 17:47:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776473254; cv=none;
 d=google.com; s=arc-20240605;
 b=H4AQ51gr8u6vfP7UXJj6/mVywDFYD2W9dlHfU52uZxzX0aNBhEtNXEmnatp+J9xYw4
 tWycT29mHa40Mo8iOm7DX/uWyYyMWOWuhVtRZTEAD1OttaeBiTl4Dl5QlLeOhq+nrIcU
 /iHtufQzkZ0tLRTcXgTPlKwDZoUX/Cy+YoAIQ9nSusiz8Xc7NESwGC57AMIdgH2ew21C
 iZsQxZmUdfzymxO1NQFHDCvEaRziLDea4J6zJfkaBz12x8rXVTDdbTOrNhyaDSil3RWk
 OfuPfHgnh4rXXHGy2HRZliwhvdfuU6/RGSrZba0lz6dt/x5THlVu9VJwAChNpNlNY/s5
 60CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=H3RBr22v1p0d4OmqYaNWv/xkwL1sWWPdvZbXWrWCTR8=;
 fh=fJAGB8LvxCJalDRE+ziaXIW21+gD5jSCb0B1QEwHsvE=;
 b=iEUKGvxgjOjiDFpXRgJk/3p7c21dFFG4uMBdMszH0rQnXBjc3HqgrHkns67yk8w9k5
 RZKWdou1osBbr1lZnf2+sNrltBpR/8vCXqhIaV7yARqLpd98kzkEcrYEq31fERWKg1ba
 GwRRKsYRCv00QfA2wEeFkxL8/lxFF0SGTSadD9lFB/GlrMbE5XoWfDcL6iIIGZzOOhfQ
 pSu893sXae7kMIbR+JmOI4JJ4wt7DHy0erwZn+PjYsBaqpL+KUxmKIqR7DpxsGK5wcmV
 t5enSPtduPlIDHFuMsx+kJT0ozi7GBfJdsblddQy1WNkqNMm8UwbEiqUXchT2FvcHOxs
 RcQQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776473254; x=1777078054; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H3RBr22v1p0d4OmqYaNWv/xkwL1sWWPdvZbXWrWCTR8=;
 b=dGb27lugWDHtuP3LYEi2+9b0jgwBadb2wZyfc/oCuES0ZxHgoO+UP8/H1lOKQAZ/7L
 LtDtwyT/aTwe7QMtJruOC1IyvSIsSQtk8vG/xvTbsggfyuimuiYVSkyRMjyarX5qbXrC
 LvR4b5Fjyz77HAWhR59IJQp6uH7BOuV51mLl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776473254; x=1777078054;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H3RBr22v1p0d4OmqYaNWv/xkwL1sWWPdvZbXWrWCTR8=;
 b=oh8R91Ssv5fpZ2qfvEEAAGyJko3LnblEAeb3AhbwmQ34980psmk1p7gvUadaIw+Vjn
 o/3K2t8ePmMxg0fhM4P/4G4bVWL+yrze6ROHIsvsjzPvYgqv4P9sw4Z62x0TKnuHAp20
 ufIuYM4dm7KJscjNqe77n/cwbtn1k0K32IvAHbrhxmP5TrakRVx4MEd6jNzZGhXzAfhd
 38XHzwmwPRV48TUnBX/2TGdGKsIRft/hgAR7Gf0zfyvhGSd2C3DLGbE8LgdhOJeAaC0m
 MbH3AnNx7NVPLHlm6gOEB17cNmOjoGzQXZBkV4mteIHM+zs+cLvqomahUeUCSMGdHVjj
 cZ/w==
X-Gm-Message-State: AOJu0YzucJY1WOPslHJg20YxO7iP3Y2f/uAC+R8AAjfjZueKh5ZhELQS
 c7LTuy6GbV8H7lkoUZmNvHz6hLJu5zR9rYiimGmatzMZRcYAehCEd+MuItnmnJzP17zC2tp3kyw
 rksBxk5DZS85C1+/yhY5mAbIKQWSHvTVE6uM03eMB
X-Gm-Gg: AeBDietx+AyBQVnUjV+YJHRWvE4lmJnlGdF6Iep76HWwW4BVqaxOq/n9UPL19vz7Ssy
 ZRBEXr1fo8kkJ5i8ao/b1h0+WyDQEwR+CKopQ5cXi9W66suBw2xeZ/5+pMh6jicXbjpf+xFZv1n
 SrVEgDQ8ieQTJqJjC+8lcqTGs9wllXwdt+ReGiIQHfmj/WHR+bk6nys/1bkUqpd1k8UIjt8rd9R
 DQ70xzZ8M4rqsJ0K/odMF89Q2RXjgT1PQGjbtDc8jd5Zv9Xr/wtTcBfkY+eTZ7BW1PhZ7d97WYB
 AIAtkEts/KZfOl/H2USc
X-Received: by 2002:a17:907:d8f:b0:ba3:5e81:7a88 with SMTP id
 a640c23a62f3a-ba42063bcdfmr252104566b.11.1776473254036; Fri, 17 Apr 2026
 17:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776392312.git.weijie.gao@mediatek.com>
 <f0024175a615b0217cb3f2181d7957a9f59b9ec8.1776392312.git.weijie.gao@mediatek.com>
In-Reply-To: <f0024175a615b0217cb3f2181d7957a9f59b9ec8.1776392312.git.weijie.gao@mediatek.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Apr 2026 12:47:18 +1200
X-Gm-Features: AQROBzAZlcrO1UY0VdsnxgC-Z_4CpwYpGVkak65UBGvkmBprjpzu9X87kkoyCVo
Message-ID: <CAFLszTiVYt0ShOO83nT7UqZSW4Z0ZpP3goooOkeNOTwYGq60nw@mail.gmail.com>
Subject: Re: [PATCH 1/3] cmd: ubi: expose more APIs to public
To: weijie.gao@mediatek.com
Cc: u-boot@lists.denx.de
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

Hi Weijie,

On 2026-04-17T02:35:14, Weijie Gao <weijie.gao@mediatek.com> wrote:
> cmd: ubi: expose more APIs to public
>
> Export ubi_detach/ubi_create_vol/ubi_find_volume/ubi_remove_vol to
> public for better ubi manipulation used by other modules.
>
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
>
> cmd/ubi.c           | 10 +++++-----
>  include/ubi_uboot.h |  5 +++++
>  2 files changed, 10 insertions(+), 5 deletions(-)

> diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
> @@ -47,9 +47,14 @@
> +extern int ubi_create_vol(char *volume, int64_t size, int dynamic, int vol_id,
> +                       bool skipcheck);
> +extern struct ubi_volume *ubi_find_volume(char *volume);
> +extern int ubi_remove_vol(char *volume);

The volume parameter should be const char * since these functions do
not modify the string. In patch 3/3, env_ubi_volume_create() receives
a const char * and has to cast away const when calling these
functions. Please can you fix the signatures in both cmd/ubi.c and
ubi_uboot.h to take const char *volume.

Regards,
Simon
