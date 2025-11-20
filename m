Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B739CF884F
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 12:22:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0C31840FB;
	Thu, 20 Nov 2025 13:22:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="v5RUcj0z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63DCC8410B; Thu, 20 Nov 2025 13:22:37 +0100 (CET)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97EC3840F8
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 13:22:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-63fc6115d65so631873d50.0
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 04:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763641353; x=1764246153; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Br4tAzfpgKEJW8GkYByvmOUgv3j0s9FW05mob6ZvzaU=;
 b=v5RUcj0zyw5tHenGT9w01y1LaNWn8eG8tDyayVqvtLyGV55m3nEejgxDcS1c35CecQ
 KM4h0TuOi7rDauLN4QLeDM8JYbSGXpd2aDwwz97mmJwS7KHhROJ6ZY14MKrhGe8IbmaS
 gVFaTYdgeX5mVoCsFWdNspA/CMbMPkUr9bBrMEESLBxkALHXHLpUaA4onScuihCSzIyJ
 qm1yhH+xaKrLzLMNwoQdlJ9OmQT/bXVJkz3UHnfjPmz6kobIub+e7+V+bNkqnpaZftYT
 y85V+tfsHUiyI8tYOlKFO4kl2wvBePuDoMo+sUTRSAeKykpZ09LEI9R2gYDd0DnJDvCn
 7Ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763641353; x=1764246153;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Br4tAzfpgKEJW8GkYByvmOUgv3j0s9FW05mob6ZvzaU=;
 b=b9WK0hA9JTohJwxVX/0rs4wnJCrVABieGA9OGDa0xOwyJ1uLikiuhhyuLQs53o8AXU
 d0iod5/W+aRbkzji/mdL99zM9SpQprxprUdI++asOvlirxsbZ6R//ljguvlATLzHBna1
 pd39n+lHG20FYY3ujIqZk1fmBiJHfR/WttRqW3fNIu1Zn9EgiFLursP5buay9R+Zbtk+
 RIrxugBMKGv81/HJSqG5jK39G8w5LbipvfHmaHWh3I892f8fIw9kdA4ICf7Z98SFQSl9
 ob3cKmlKfWQm9RnMfa5TZlPUvKSwCQUzUvbYZLyfwRGTkowjMlA+DNSWnTJ1I8bWcnJn
 g8wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOzYeZjNCbSoMFJ1itfYaAAjscU230NijuJsNtfyobIeOlH3fJfGmpgfNtd6v33iX0Sao6qVc=@lists.denx.de
X-Gm-Message-State: AOJu0YzKnUuggKOcqwb77fkJkqhLVIXgs8YcOnP1UjXkyVbiQQugrpJD
 L1KM6bFLknTnTevDqAXOJkeAFZuOcYH2tc3a+yu7H/P2hrbS0GEwfREzejfkZBHcyM/0iErJPiG
 tORpfwNTFYVgwRD6r6WOPrFV+Zcbe4iu64P1Br8fFPg==
X-Gm-Gg: ASbGncva2wEpHC7tbwvIF0PxWameakX5uafhPIHtmKThJCVfKXDcWFuv661LbALoQ98
 CR3olBI+j/pR8WddcojBMbQczBVnTKMsRZQdjWUhxc6YED13ebnqoZXIZLLvbVm/um8vmx1P1fK
 jLsgnLJF5h7H+vnCnih2cxCqUV5AXK//dDbKQa7kxeqMlRYzXjmo1YhuD0iavtj4wAO7pN5nwR1
 JG+SppVa4bOSP94DMvN95/vCukzB+ePbiPk4WNBNQv6ujzKegvx5d7wqPkvgQPQyqZ0ykWNwElQ
 Rj0kAz9COf0tEepTgCydO1JLJgj5um4teUU4LuH8bj9TUomADkg=
X-Google-Smtp-Source: AGHT+IFWzPocSZ+5hkUq1nbfQagoiUQ22kkuYh5FV7vpW21ZgnTEoBcYZf0SLb1z7VSGh+E4pkcjVGyxz7s+/wy8rMA=
X-Received: by 2002:a05:690e:245c:b0:63f:c816:1171 with SMTP id
 956f58d0204a3-642f77b7c9bmr1702030d50.13.1763641353313; Thu, 20 Nov 2025
 04:22:33 -0800 (PST)
MIME-Version: 1.0
References: <20251118201733.67297-1-heinrich.schuchardt@canonical.com>
 <20251118201733.67297-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251118201733.67297-5-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 20 Nov 2025 14:21:56 +0200
X-Gm-Features: AWmQ_bkyXgXEfSNTl67wSTge0ZaVnoAHT9eB6ri5-dQ6dQ8wWRamDlGzGaLiGCg
Message-ID: <CAC_iWjL0==pkAaoFsrBdUR6fysGHf+53ifSBi9j=b7YrL2=JHg@mail.gmail.com>
Subject: Re: [PATCH 4/4] doc: describe return values of C tests
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
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

On Tue, 18 Nov 2025 at 22:17, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> * Enumerate return values of C tests
> * Reference assertion macros
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


> ---
>  doc/develop/tests_writing.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/doc/develop/tests_writing.rst b/doc/develop/tests_writing.rst
> index b6972489d4c..1a020caa411 100644
> --- a/doc/develop/tests_writing.rst
> +++ b/doc/develop/tests_writing.rst
> @@ -228,6 +228,14 @@ Note that the MEM_TEST() macros is defined at the top of the file.
>
>  Example commit: 9fe064646d2 ("bloblist: Support relocating to a larger space") [1]
>
> +* A successful test returns 0.
> +* A skipped test returns -EAGAIN.
> +* Any other value signals a failure.
> +
> +Include ``test/ut.h`` defines a number of macros to check values and to return
> +from the test function if the assertion fails. See :doc:`../api/test`
> +for details.
> +
>  [1] https://gitlab.denx.de/u-boot/u-boot/-/commit/9fe064646d2
>
>
> --
> 2.51.0
>
