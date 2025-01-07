Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C496BE77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 15:30:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0CCB801E8;
	Tue,  7 Jan 2025 16:30:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DcAjt2u+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 982258036B; Tue,  7 Jan 2025 16:30:21 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7357B801C3
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 16:30:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aa684b6d9c7so2590713966b.2
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 07:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736263817; x=1736868617; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iz/vzqxboccrgnhxDcVIoa/lCpeZUBR3WUmwBXR2uXg=;
 b=DcAjt2u+qS+QT+JdABrbdk7SVLlSqIP3yIbiWEhSJf4rWNnRQ2zFwSs0/ieV85MMR3
 6ev18QsGSUhF0Jn/qlGlSbcXQZQGAd/0aDtXIYK23CtJgdhQ3DQqIcQ26+8Y1p7Du0jl
 chYCp0YaUQfTtrbfURX9qY33FoB+eLeA9WQL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736263817; x=1736868617;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iz/vzqxboccrgnhxDcVIoa/lCpeZUBR3WUmwBXR2uXg=;
 b=NdqZAtNiEXTRAuKh4W0DhiLYmZHoB3c4Zq+iEPQG01UPgI2n7gDFB769zAwcOyFw/l
 EAvvyebyb9bnlYSs8RxdX1VCB/YNAmkI5KpulHQMTAUzR9i+w9/XYybQtiDgm7JM94qm
 PGRw+F9t6BIT0bBiWpJsfRaSghUoHTyNsGzs6kUYrH7sU32w9Jf3AwNjRpMk8MmaRaFs
 lCGVtBmh5k/KxALnKq6KJz+s/7ao1Yt3ofIQ5wwOzgUqzBdt39LHa0WmAmTfgpqIJv34
 MDd6oWyiq7DJYDwSsjG82JHohaPd2ktRxSdJCf5Cheua2SytQJ0NylOoLmOR2XOswqfA
 enkQ==
X-Gm-Message-State: AOJu0YwQx0olvjEpzGAZNHt2XsD1w8PcbPUCSc89PaTO0fGekmo/Ujpy
 geXZZgPxo33YGfiPt4siHnGs1Z/bJ14BWQYxHkMzZubz6VJY3w1AZz+8o8guo7LxA8v0vBzrNaf
 y6/Zoze0vDLoWB+rxuyZcSwLndbuALXBAD5k89hokgAT8rXA=
X-Gm-Gg: ASbGncssmrM4gZofTLzTgERjWeHYUIKEv/h0UfSx5q07cHMslB+QzUWSMSFAp3JY0hw
 c9p8r2uXCpXBh3qsInHfeRL2Nl/wBbVCwIrUzSd0=
X-Google-Smtp-Source: AGHT+IEBVSyk94Z2ApJBFB/RaMcx6RFbg4xLEt3f9Keh6jA0tzf4ljXs0Fn+RHSIqXINPKfsJSIu9vWJN3fnk+gxXPE=
X-Received: by 2002:a17:907:c2a:b0:aa6:79fa:b480 with SMTP id
 a640c23a62f3a-aac2713135bmr5741686866b.10.1736263816805; Tue, 07 Jan 2025
 07:30:16 -0800 (PST)
MIME-Version: 1.0
References: <20250107150258.813289-1-raymond.mao@linaro.org>
In-Reply-To: <20250107150258.813289-1-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Jan 2025 08:30:04 -0700
X-Gm-Features: AbW1kvbaQnUnuMLdsSzgLcRjG8_AXtW9LdUjRC0d1XW_ZRSqZFmuUnVIL47cExM
Message-ID: <CAFLszThCJNknGyFKb0uJZk1fB9ATKOUkrgQEE4Q7aW==KYXhAg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] bloblist: add api to get blob with size
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Levi Yun <yeoreum.yun@arm.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>
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

On Tue, 7 Jan 2025 at 08:03, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> bloblist_find function only returns the pointer of blob data,
> which is fine for those self-describing data like FDT.
> But as a common scenario, an interface is needed to retrieve both
> the pointer and the size of the blob data.
>
> Add a few ut test cases for the new api.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Rename function argument.
> - Add ut tests.
>
>  common/bloblist.c      | 17 +++++++++++++++--
>  include/bloblist.h     | 18 ++++++++++++++++++
>  test/common/bloblist.c |  4 ++++
>  3 files changed, 37 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
