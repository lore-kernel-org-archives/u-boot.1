Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8094BCDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 23:26:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D882C868AE;
	Sat, 14 Oct 2023 01:26:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZXXuVxmC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A793186F69; Sat, 14 Oct 2023 00:07:03 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F7E186F2B
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 00:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9ad8a822508so412774666b.0
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 15:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697234440; x=1697839240; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X1Z2faXdi93wvQM5olKjUOWQGTHyIw5v7E7omPdS1n8=;
 b=ZXXuVxmCkcKiUY6GM/b+fmsu6XmWilPvbEPKPPoQ/s8gOz65EiwVLKOYOxzNfb4lXr
 JmhIPHTqLjaUIMaMukBOTVFB9j7sESorb4cQeFScaRlio3DhPhHtekfCqJEb6d2qQyFE
 ndetKOfetxigAUKCnWuZb4DBn8XB6um1K43zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697234440; x=1697839240;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X1Z2faXdi93wvQM5olKjUOWQGTHyIw5v7E7omPdS1n8=;
 b=OKXsuePEv+fAFFVKIT0E02AfKBBFrGbI2SF+uBSzoNrJfqPk84SKQaYM/2PP6TXdxs
 31rSK6j4B/Egcys3Of45gr4i+xhP3EueURlp19y4q3/lHayKI0G7/X2khYWicJm8Lj/F
 NoCBhLAdqoFcA2dDWC0cFLEykWfwF8qN8f+UxHkBlhRgvGbPBMbaZiXDkZ5zgfEG+ojA
 oQSoJgM4tYFmrkVg763wnYJyaEN1ake37VZoOohGuOoZOWJAuiqifkrUrk+qAeL8lXo3
 x53qifL7oflCV2In5oP0Tx13NGl20c1dACzWOadqvfaPwGZbHQpf2dJ67xEc9p/Tcta9
 Ws1g==
X-Gm-Message-State: AOJu0YwSRl/WdB0ImnKgXD1PEV5cu4pvxb9GYZlKj7Tf5YRaaTTZVqxp
 Foojr70PD5CFFQrb8pLfgKVbd4uohYNvCbzWbYcUGw==
X-Google-Smtp-Source: AGHT+IFa6G5gLlEV5EWNwAfw8kKJFzit4IbDptZAHgox8IrJUDEuR/VYFDc2CdkcjraGENS/1DoMrlRke5PSIMS+isM=
X-Received: by 2002:a17:907:2cf6:b0:9ba:1d08:ad4a with SMTP id
 hz22-20020a1709072cf600b009ba1d08ad4amr12970305ejc.29.1697234440267; Fri, 13
 Oct 2023 15:00:40 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Oct 2023 15:00:34 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ3T5uwJv_S8Z_6-ZcwtbHC8T25N7NNhBkBybJZBtFpjuQ@mail.gmail.com>
References: <CAPnjgZ3T5uwJv_S8Z_6-ZcwtbHC8T25N7NNhBkBybJZBtFpjuQ@mail.gmail.com>
 <20231010091059.375036-1-sughosh.ganu@linaro.org>
 <20231010091059.375036-4-sughosh.ganu@linaro.org>
Date: Fri, 13 Oct 2023 15:00:34 -0700
X-Google-Sender-Auth: AKWCgq1B2lQTs9e3muZOsMHCKww
Message-ID: <CAPnjgZ3BCWf9mYvcsR5QCKTUVKQmwbbuWTnqUaHosb53_guZuA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] binman: capsule: Remove superfluous
 [address,size]-cells properties
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Tue, 10 Oct 2023 at 02:12, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The #address-cells and #size-cells are not needed for running the
> capsule generation binman tests. Remove the superfluous properties.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1:
> * New patch based on review comment from Simon.
>
>  tools/binman/test/311_capsule.dts               | 3 ---
>  tools/binman/test/312_capsule_signed.dts        | 3 ---
>  tools/binman/test/313_capsule_version.dts       | 3 ---
>  tools/binman/test/314_capsule_signed_ver.dts    | 3 ---
>  tools/binman/test/315_capsule_oemflags.dts      | 3 ---
>  tools/binman/test/316_capsule_missing_key.dts   | 3 ---
>  tools/binman/test/317_capsule_missing_index.dts | 3 ---
>  tools/binman/test/318_capsule_missing_guid.dts  | 3 ---
>  8 files changed, 24 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm, thanks!
