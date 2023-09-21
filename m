Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD70DCD4939
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:03:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FF9586CB8;
	Thu, 21 Sep 2023 03:02:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DandkJBz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 405FD86CC4; Thu, 21 Sep 2023 03:02:51 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55F3086CAF
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:02:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-53339349956so216302a12.3
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695258168; x=1695862968; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yVnFA4Wrv2HmJpQK8tXW9qmrkP1U0cC4h0LffsNEFjE=;
 b=DandkJBzIK6jkKNh1VbBn3w8U7mFq99B8VFk8N6eiKchbKSIdseIzlNNHJ+kUjhLvx
 oSYWhT2c+gsd8RimxRKx8mqFAeyn0VtjdyNTU2iQ/gTggc17eUjmnoDdMS2Xv4mLTAdQ
 fDqOfTufqzoSKlJW2ghb++43lfG6a45VXGkAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258168; x=1695862968;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yVnFA4Wrv2HmJpQK8tXW9qmrkP1U0cC4h0LffsNEFjE=;
 b=RLxMJ4KMMOz7dF8RSKjDJW/RgSshusUVJLEwymn+YxiFe6P4bW1k//7qZM5z0kOE+I
 Ott7w31oNCbob2jkO9f78oGVT3gyOnLMrWqIUzqqy5rRhsYGMAuwZyPZWP72cBxYIIji
 lAKBUvcanu9D5CJnQGXopLmonBkYK/UCKh4eLlmsH4qfJ4oEOf2oLiCEQgTOVBemCNk/
 AzXPJMhnFredvXFDG9VqGIZExQ7gaO/zcvCYAyTpPn0x7apeLeEfgy4fq8bbCJ1AWOL4
 BIs8G1p86NY794G2pobLgLN/q2HQvvCrnOQz9Z7oODWUdGCBEaskFqPw7qCVNAd7AtE3
 S5pA==
X-Gm-Message-State: AOJu0Yw0UjFneD4kGXi32m2DeH8XNJ4EXiEjQCW5dOwwsZnaPcBpt5ns
 +Xe4Uv6JskyGJKbh/loo3oqeLrrgyHtzTpkL7nbpbkJqtkFj/H53M8I=
X-Google-Smtp-Source: AGHT+IHWEvOAwT55MyAb4a+lNAKgUd90bIiovQ2B/6ytBxPY6a5WbwaNODC3+VoCZa5uuhF1UPPfLG7A0B0ICCWNeKY=
X-Received: by 2002:aa7:cb06:0:b0:525:6c74:5e58 with SMTP id
 s6-20020aa7cb06000000b005256c745e58mr3568121edt.23.1695258167820; Wed, 20 Sep
 2023 18:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230912213504.65513-1-seanedmond@linux.microsoft.com>
 <20230912213504.65513-2-seanedmond@linux.microsoft.com>
In-Reply-To: <20230912213504.65513-2-seanedmond@linux.microsoft.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Sep 2023 19:02:29 -0600
Message-ID: <CAPnjgZ0jEjRhr0UhcZxhMYxswKomfvt=zxWxyOdvK+ZvA-w7Dw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] fdt: common API to populate kaslr seed
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, dphadke@linux.microsoft.com, 
 ilias.apalodimas@linaro.org
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

On Tue, 12 Sept 2023 at 15:35, <seanedmond@linux.microsoft.com> wrote:
>
> From: Dhananjay Phadke <dphadke@linux.microsoft.com>
>
> fdt_fixup_kaslr_seed() will update given ofnode with random seed value.
> Source for random seed can be TPM or RNG driver in u-boot or sec
> firmware (ARM).
>
> Signed-off-by: Dhananjay Phadke <dphadke@linux.microsoft.com>
> Signed-off-by: Sean Edmond <senaedmond@microsoft.com>
> ---
>  arch/arm/cpu/armv8/sec_firmware.c | 39 +++++++++++--------------------
>  common/fdt_support.c              | 19 +++++++++++++++
>  drivers/core/ofnode.c             | 17 ++++++++++++++
>  include/dm/ofnode.h               | 12 ++++++++++
>  include/fdt_support.h             |  9 +++++++
>  5 files changed, 71 insertions(+), 25 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
