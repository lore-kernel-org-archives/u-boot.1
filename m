Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907C2C83F2C
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 16:49:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB46D8698E;
	Mon,  4 Sep 2023 18:49:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="jXke5UjF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF3138698E; Mon,  4 Sep 2023 18:49:47 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 367028643D
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 18:49:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-51a52a7d859so5375102a12.0
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 09:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1693846184; x=1694450984; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iooAQZaIx95VXPaIXEv6JynnnFak4c/k/r2aA82ScXQ=;
 b=jXke5UjF0HMOfyUirLDZyOtWJufuNJZ2V27LWt5NaNxqCPgPqB8D4LYAktsk0pr+ys
 8ckJLNzfymCaTzZSQQMT37UtAnTQzkKjn1ngFB9T1izD8GOEg/L1vXmBc38jNl9WAyf1
 WpdGIUVSLNscSV5ROk92WKvR2OF57IxxPcTWgv2UEn0TAVhrVrNIW/LT6kUbt3m2Gi8Y
 Lk5FpB4C5hC2U3hNurSU3EOzNh97KRUgSm8qRYGeN7yy8B3h6OPKGChH1f7WclRJeqZF
 hx3CwH2DixeUm1WOafFf5FYohJEIj8jtUvj1afDQNFc8bW3fDDXfGfr2QCocS4+fwnvu
 BnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693846184; x=1694450984;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iooAQZaIx95VXPaIXEv6JynnnFak4c/k/r2aA82ScXQ=;
 b=NA1VucVfVl5hhvoqRAE6rZDQYlL92ouBGtVmLcS4R4XEtBVsr5T3n/kC5p5u31S2/+
 2nzoopucRG1mxUWA+h2GA2kJ34vZI0RTVbDIXa1oy4jDAW1IEgkVCVF96exnCLLGiQRi
 Z20lSonOU5Pbh0qbCkTjFxBtPAgxCh/9NZKB1K+oMnAgV+LKfudIva1G7MrSwbXsH8FK
 rThZ+mKgiWHsIsrKc0VIEPnJq36WDZ9+BdEHjULtkNtc7rMsdd7WJ51RvAJD8knryXFH
 s1g0184FEDJ93iTNwBP39EhmCPlSu6SxgiQanMyShsMd6bwn5xyYl9mNJwkxCSJzRqVe
 lrXw==
X-Gm-Message-State: AOJu0YwrU4d0K8FTfZiFUYDwG1F3QQb/LKRdoD3m43qdHqcVAFr8g6Rk
 DDBc93Vg0UPxvBrOZ6eVGJksd8hj/Fc1la5t7VzETA==
X-Google-Smtp-Source: AGHT+IFkh3+hniOWI2aTR/FpOlFf3XfD+o1DDjek6XQLgiN+ffRGUU0Av9sEJq1kD5D3L9yB4LvlSKmLTTwpCL37jcg=
X-Received: by 2002:a05:6402:34d0:b0:51d:b184:efd with SMTP id
 w16-20020a05640234d000b0051db1840efdmr14741257edc.20.1693846184525; Mon, 04
 Sep 2023 09:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230901204143.3617876-1-trini@konsulko.com>
 <20230901204143.3617876-3-trini@konsulko.com>
In-Reply-To: <20230901204143.3617876-3-trini@konsulko.com>
From: Simon Glass <sjg@google.com>
Date: Mon, 4 Sep 2023 10:48:50 -0600
Message-ID: <CAPnjgZ0JTjPaV47XxXoShwgk9yKEdpv7A7NAVC6NsOjgm2cM8A@mail.gmail.com>
Subject: Re: [PATCH 3/3] Azure: Add sandbox64 to CI
To: Tom Rini <trini@konsulko.com>
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

On Fri, 1 Sept 2023 at 14:42, Tom Rini <trini@konsulko.com> wrote:
>
> Now that sandbox64 can run and pass the regular test.py suite, add it
> here as well.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  .azure-pipelines.yml | 5 +++++
>  1 file changed, 5 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
