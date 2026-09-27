Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A74AC9832F
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 15:40:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C454F80E52;
	Sun, 27 Sep 2026 15:40:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s4iljmWj02KP; Sun, 27 Sep 2026 15:40:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 07FFA80E4C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790523641;
	b=i8nMpw5I/iyp6fW6BEk8zoT5V8oGeNf7e1LeRZgP46X/wiG67fjC3CFnUkUi3txWi+3+
	 vXWp9z+0NxhCETLbmGajJczivMc+RVHuWTC5ZFz0GTl9lugtnoHeMy2yJ2jn6sVj6Ko9y
	 Jw3zjZj/FARCsKAFHiRARYfstHg0ZePiuuQTNT7dTiUktdmdG5Wa4wSrnlMmQkVKzwFTN
	 PKSNR4OdfCAz74cMS8/8Os0xSY+V7hESonOSFRh+/d2I87Yd8h4QihA1J0NFB1kruTYzt
	 AyxQIqV+of6syE8Bs3nNKsJzvfrL5OlYewCTzUoXAAi2XxX8KLa+CnW5k5gGsjQ6Gyg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790523641;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=cMOXAm5NLsQcpHQhtg04fj9B82LchWxH1KxKVInuzuw=;
	b=rttpQcUZDruaqYrFDmMSRZDyosLQ4ob1Pg+kOiS7q2ATmwmBZYqo4JxPzdA2rC4Lktaw
	 CS27f/3NDIAw5hypKdb9DR+aUKy0dpoPckbrsEphWYdofFKh6yQN6aZ4iVP2UPTEo7Ju2
	 Mq+cD+YCgzUCDml6FPhtIhRtedN7mM7WjTqCBYHIjodZ6H65k1zNlfIfJm7L1Qfxw3Kge
	 3pRevPsU2BTD5WefnUt6yGo+J2S7I783eEOL8WiwA84FGvgNA0Q49M80DJ+HxBQkoqGnT
	 SUn/owp9qrz7VwJyuFg4mOcm7Z/QtfWK0Gd+zejgce+d+/FmBQ9uIZ5u89u5/Qp3OWQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="J/WBv4LX";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790523641;
	bh=cMOXAm5NLsQcpHQhtg04fj9B82LchWxH1KxKVInuzuw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R6OFPpqPEJAUPBJfxO25upRtyBC1ENnn3Ngm71Mg8RjKf7rnljuoN5CUw+/T3K1iH
	 rlcjIVMEgsrDq7Uh+PRu14FoYtVpyZWGmrEGwMDCW0QCOzwCB/l9T6ztZF2Dt1MYL/
	 U1Fzz7F6iyX2GGPl2rTQDTiz/A+k7jNI+eUAIsphPh59V7qSowbSfe0XahP1TJmXR/
	 DATlwxeDvv73keLB7AhcwbC/hj7/TLaGZm1Jlx+rBJFGr2uhEuHw4Eyjk+0Q7N4pYZ
	 hK1fSVpu/JBZrX6KQSCWtkGbyx+jkVgDCTjFdazC+olP/qYsNAVucRHnOalsmrie4J
	 0psO3MGI92IBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 07FFA80E4C;
	Sun, 27 Sep 2026 15:40:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CC695334
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:40:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BDC3D80E4C
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:40:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8YhX-5kJb3RB for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 15:40:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BCB4180E46
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790523639;
 b=mnJQA+Z0AEpbnE8xJNCp6GYz/eQJswErXzztSMcIgbFmAIyZoNUZ+BpeBsPodrhuYKyj
 aFOL0iN84jyPy1YjeBkYWpqAsSmreJ9P9hvYMX7th6lXGPD43S2wY17aiKdrl6wQvMKAl
 kwMnFWRR+oF668GeldlS494qSbHc4dYFWq+tHAhUOdJNJHLpgJUGq6Kl8Lqx6/zeut1UY
 RO/qwm0w/KduEUQCs1sXI6Guo9+XfxB/JI9D+OW7Fnr7TGm/QkHcVNGWKCZJsS1yDq6UZ
 TlYAqPcyvPLULKOwMgOdgzMwVQ0WIjGS/xQfWzByZ+XzPq5nMh+utwOZIV4+OC6y1mg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790523639;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=cMOXAm5NLsQcpHQhtg04fj9B82LchWxH1KxKVInuzuw=;
 b=RHL7FLRHsZPJJAj6Zq2+W9m9X+1CVqNaXm2oeinZ8+xhSR223VeHSpMYFk3LdqcrKRgy
 NHmvxWx7c6G3hGgLV5jtUeJIV5ki1dyU3Z1c7xfEU5ooNKm4xlBQPwDKDFpM6eBjVZHbn
 FNzr6pCo5jisOi/OsZ2o+W2nDJGe+DPddytHt8oF9OGA038lEAd79ZUo0Z7KaT562uc26
 W/4LOrTyf5hWjrFGeqfGoApqOaE8vPgoXk0gxAn3FFGozqqp+NySGvHgUa2sntBnfz9O+
 D0u0pW+xHs7EvyF3591nFauYjO6cC8ywToEY4JpHMFOlOvrTU7aNr70gJmido18qiyw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="J/WBv4LX"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=J/WBv4LX
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BCB4180E46
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:40:38 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a8038a9f10so2906941a12.1
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 08:40:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790523636; cv=none;
 d=google.com; s=arc-20260327;
 b=qkUl/UPHJci221EgWoybfM0tywy2dWWszcxoMlzzwVpOe7qZCNL2I3/8d4siR8LFOr
 fRFeaPfGsnFGFGJHnCLEDfnutwV0BFRmsYxjcTQEeTFrCn8NQNhpu+4NvrRdfH7nGZKk
 k0AePQWmREHYgBpKOA0LWXjYJEowt4Zj6QEdVyonghgR6gpP0kjS+F/WXfKV03RRo0wZ
 NLya7JQDl4xE4ZIP13u0jfYHDNDrxAC33MvEjHZH2NvI3jVUChfje1qoLKb1VTtAzT1V
 vcb5RJyfFbWw2lGbm9g/AjvoqEz9HEjPj2nRh+PE9NqwHpKIcVAzlM8d/iSvGHrM31kU
 0zxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cMOXAm5NLsQcpHQhtg04fj9B82LchWxH1KxKVInuzuw=;
 fh=l2Nzj50ZpMuUbF/h4rKKkQ0YfUsd3u9H1bLamDFxY+c=;
 b=crU+wZU0Rv6u+4/D9TLtsm2CO2sw/tILXWEOnVY8Mcl3wkTZlW5eTg6taduvtlVtgS
 Z3q/bA1DUQbkBoSfcsmBifA4F1B8bk96a/m0s+jn3e9s2ilXjiz/bYd8Qen/k0bEUc1X
 I+Eu0va0FJmqSXskB9kLpJcmnnim0BFM+0i8i3+DTvw7qq4qDuvFPI2dbiy30tRhed6v
 CIrdj9fLWPhD2Ny0Qs+IFNkKunb7UqP1c+ehdFRK3uivlqul/nallDQXg1Qw0EjibJsi
 yklYlF002zIfABoY//GCV9jAxhByVC4bHA19T3Ay2C8wnLaH86FEqXy/RQnE/+hjrohL
 Kv8A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790523636; x=1791128436;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cMOXAm5NLsQcpHQhtg04fj9B82LchWxH1KxKVInuzuw=;
 b=J/WBv4LXFcFIkoNDrafkwDbGMcVx4HlIauQOA61UKbv5xBtQnmjcA9e0b/NT62wOmb
 EbbabhBmUbbl5b3IFmhDAsqYb9vQtXIdwwlbZUsHBjLIzwVByctTtXR/Ypfmrt4tomL5
 IOcZp4gh0VqWdJMdu0Bdy4v3SvxZoR/dTlNnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790523636; x=1791128436;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cMOXAm5NLsQcpHQhtg04fj9B82LchWxH1KxKVInuzuw=;
 b=hH4OTswGIxv7FxOcIdycId9JxVZ4dpsKriJYqgasGwM4XrYsIMtNU0e6YjzwhPZuZi
 StEXaGtPMjq8GXuLRrfQLhHBrcy4Cxl0H6nA1u5gB1IsEZEULKIqHfANtTINXFKfIR+0
 L36QLOPe5dqz9XOUHo7Zq+D8gJXoECIK7JbElPkeA0vg3IslvdtjlRv1aGSpszhYhENk
 kAjIOIBEUglW8HvdlSiGwsIJ2SqC9h81mZRpB6rrqhvVzJczoNszUNEbay9UQH4gshHI
 4sbgzvZGxp1tc4VKNRY5dlkXBNeolMFCa7BcaKaoyKRDsh0L6VljbNyVCgI2ktv9mOxs
 pPwg==
X-Forwarded-Encrypted: i=1;
 AKwUvByFjQwJ9ovd0RnjDxZk0MiCZ9ZM9Fg13XQoZcw0YRYuTt4spCyPyhyLFOTqvSzKlYYj8OKZ0SY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJD06diIOJn1qD0+tCGMdlhCkYfQFs7IpWyMJxl5HesfkY2wPwB
 xrXCdumU5Z01SkV01MlUGbfugLmTeCahiQLPmzJYGEY1tHfwCvej7jWZLkB9IhLe1rx0MxL6Jg2
 FWfPWEUabtWX+Wn+UrnPgr+ONg9we97H9rjJZJEvZRrPlpu6yaqc=
X-Gm-Gg: AYBFou1k9vUZV8c7pojPzTXcQs0OWzWgK6wADv+TOeXqyoEWZS9a5A9sT9QC+tD/M95
 dARfjXt9DUKD24ifxuXtv7loZn8Vts4lWO4qc4j0LeXP4pS37IaESwJahuJZ5te6EnBAuelVJRP
 Dv9SnqnM0qe20a9l+neYNto/3zN2CiyaY19F1qxybCE8kP3UAkfBBKFaMJVPNn2kygCQJkN3L79
 iNgoYvKaLNFolvSZEPK5rV6HTDh3Xw/hiRHDmWlTXV87elVIRkeTx+by2+pWxg2t0KNC96NhIjI
 pkIspla45r/5UF9U+VxHLuDcy3piaa2UexbALfxY61giUuUG6ewa/A==
X-Received: by 2002:a05:6402:44db:b0:6ac:77c2:c418 with SMTP id
 4fb4d7f45d1cf-6ac77c2d8f1mr482830a12.1.1790523636316; Sun, 27 Sep 2026
 08:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260923213002.1070404-1-visitorckw@gmail.com>
 <20260923213002.1070404-4-visitorckw@gmail.com>
In-Reply-To: <20260923213002.1070404-4-visitorckw@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 27 Sep 2026 09:40:20 -0600
X-Gm-Features: AclHuK-hgFyOdxVTgRMfZwKH8iImQiRsyaSL1X4cVyo694w3FI0dny54MW3Sc5c
Message-ID: <CAFLszTgdqwvapDRpo0e8NyMd_X=6gezjAFNkEW=BuOu=bvsr=w@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] virtio: 9p: Add 9P transport driver
To: visitorckw@gmail.com
Cc: trini@konsulko.com, tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com, 
 sjg@chromium.org, jerome.forissier@arm.com, jserv@ccns.ncku.edu.tw, 
 eleanor15x@gmail.com, marscheng@google.com, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 2026-09-23T21:29:56, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> virtio: 9p: Add 9P transport driver
>
> Add virtio transport driver for the 9P filesystem.
>
> This driver binds to the virtio-9p device exposed by the hypervisor and
> registers as a DM UCLASS_9P device. It implements the transmit and
> receive routines.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
>
> drivers/virtio/Kconfig         |   7 +++
>  drivers/virtio/Makefile        |   1 +
>  drivers/virtio/virtio-uclass.c |   1 +
>  drivers/virtio/virtio_9p.c     | 120 +++++++++++++++++++++++++++++++++++++++++
>  include/virtio.h               |  12 ++++-
>  5 files changed, 140 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
