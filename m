Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AF6CE8E96
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 17:03:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F154988EE0;
	Thu, 24 Oct 2024 19:02:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ufi0rpK+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A70B88F47; Thu, 24 Oct 2024 19:02:58 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B2FB88E63
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 19:02:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a99f1fd20c4so158275766b.0
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 10:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729789368; x=1730394168; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bbbkFTW3UY69V4d8ylKDll0sjf8v/diSpWtmnFS0q2s=;
 b=Ufi0rpK+Yn3uJ/e8XxwaRT9+LfegVa4nJDHdVurQtl09rBGIDHawsPUnMrRFl+eDtd
 EA1+ABsWoa5vAdubntXAxhCQOQ18KbYm8zD7gVCrpFU88wydLuAhvdsSIVtYy+fXBFVL
 pkcxaL9SWrVzGA7IOSb0jbehMISKYbKEVVuv5N2mhpodjKY5KTXfErLk5NQPOiNnroBr
 R4VdN9o7LuIG66sZdcLp2ff/zXDHWjshWHUj1IpFAGGw0FxUG8MuA2ogsS8LkQXOByvC
 OhzKZaNyWckw9OAS5Xr4MZ2T1DVd2iZUooUOAwlZ6Zp53F0ayXXnHjIvbb5v3NLd/B6t
 buYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729789368; x=1730394168;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bbbkFTW3UY69V4d8ylKDll0sjf8v/diSpWtmnFS0q2s=;
 b=BqtuHnAhOlc2wk7QakQEM7eULLD9ko05SS2l60AD1SrCto3LdXtk5E3enFHqtO+WlA
 sEXYBFzltIvs/LkVQScuD2AJ7SgJx4PRHSGi+iEYaS39V2PadrNqXJyz/qu+LnVgTb9P
 lnJ92fqLtQdOW3AFuRY7qXKyIe+hi99/u43MKRiV2E1Td3qcULqdQKNya7JMm1WWIuNt
 9Vhp/uf3NdH94I8vQS0JRQItg/eDZN2hZz6s1o3V++42thS17OBTsM2UUyMg7FmqNEmF
 mdDELG2/ZnIOdFnSyTau87D5uL/60xIxbFwQLY2BDnEFscdRX3DBO4e4Nlj+QxiQzEBJ
 0mTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVjeWgJPOAVY4H7qXBKInC28WCbnxmgDr9T5uvqsRY1lzwBuLqyl0GhNCGsmhAmsH55BTKHBM=@lists.denx.de
X-Gm-Message-State: AOJu0YxWit/TQnal0ffQQRJ9ULWj5aR3Q6LYcqnWDza6OsbvLRpn9Vdl
 mpbxMg+zwsabjGVyrj2GRAlZz1fvh5d9VI9etINqAzq5XU7cGA2GHmlhwWrWjno=
X-Google-Smtp-Source: AGHT+IHSOyGtk1q3MUiwkusOhjK6IVizpuYPQ5QhXL7f+uIgVG6oEenKEBIwZrOBtquRkv5qiuYZeA==
X-Received: by 2002:a17:907:2ce6:b0:a9a:522a:eddd with SMTP id
 a640c23a62f3a-a9abf845e75mr740360066b.11.1729789366947; 
 Thu, 24 Oct 2024 10:02:46 -0700 (PDT)
Received: from hera (ppp176092143132.access.hol.gr. [176.92.143.132])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912d636csm640477966b.36.2024.10.24.10.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 10:02:46 -0700 (PDT)
Date: Thu, 24 Oct 2024 20:02:43 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: jerome.forissier@linaro.org, raymond.mao@linaro.org, xypron.glpk@gmx.de,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 4/6] net: lwip: Enable https:// support for wget
Message-ID: <Zxp9s_tc_rQRqUHX@hera>
References: <20241018142235.715571-1-ilias.apalodimas@linaro.org>
 <20241018142235.715571-5-ilias.apalodimas@linaro.org>
 <CAFLszTj-f9BwFd3oO8uZGS=D_8wDtUcKQD9-9mU1rVUZin9f-Q@mail.gmail.com>
 <CAC_iWjJrUtTnymNK-GpNOp+Qjd2H2z+pPP8caK7KW4DzCVpP5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_iWjJrUtTnymNK-GpNOp+Qjd2H2z+pPP8caK7KW4DzCVpP5Q@mail.gmail.com>
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

Hi Simon,

[...]

> > >         memset(&conn, 0, sizeof(conn));
> > > +#if defined CONFIG_WGET_HTTPS
> >
> > if (IS_ENABLED(CONFIG_WGET_HTTPS))
> >
>
> Unfortunately, I don't think we can use that here. If
> CONFIG_WGET_HTTPS is not enabled LWIP_ALTCP will not be defined, and
> the altcp_allocator_t field will be missing from the struct leading to
> a compilation error

I forgot to update this in v2 [0].
I'll send a v3 regardless and will change this to
#if IS_ENABLED(CONFIG_MBEDTLS_LIB_TLS)

which is a better fit anyway

[...]

Cheers
/Ilias
