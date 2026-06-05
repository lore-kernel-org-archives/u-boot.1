Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE2FCD8C85
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 22:08:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5587184956;
	Sat,  6 Jun 2026 00:08:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VBmWd+0H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CECE68497A; Sat,  6 Jun 2026 00:08:31 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C28D0848A1
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 00:08:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-68b90fc6a1dso4408107a12.1
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 15:08:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780697309; cv=none;
 d=google.com; s=arc-20240605;
 b=LDqg8JAvee1Bj0qLH3lLTA1d7JjnNMR4VJZcZK5Dh48bSbXeXApjd/PH0iwAk1YrJZ
 sfGU3dD76ohk20drolZnh9nT9QForNVVvwKWjHIeWY1ue6CY+7mWZnslm/lLRT030d2N
 zLHZV90I0eilK0Gl1PBjuZi5x5o0psLUp7FYwBCXXHyuLuhnxrMA+Pwy4VlOE9aWFSk6
 KcGcbWt/ufWRAJDIJdeJnXq7eCRCt0nf00wp7/vXlIvjNbZCG6wPDBPBz6ZMV8xfjeu/
 b9mZeySfW9++kDSJB1e2uAS2dwuf2JIXXnYmecsAyh3Nt21/BTMb5B9KpbOUYTJm37sc
 AQzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=guQ1bVcgFuVljo7/qDacbIN8uhJM4o1UejHHvAOmb6I=;
 fh=Hlhgev5xB0xlM2njeo0mv1AJniEuivCiBjj7I4NN/4E=;
 b=OXelL3708IGtfe2BhqzmcTi2iqAT+vKuNmO7kVNWxpWlMkjtdVNmyzRNZOqL6s+aly
 +xYRrPPGZbkLj56zGFOg4NcGMY3Mlyz9/MmzMYECPqQ8Yi2txIbq6xk5nYWzlaY6Exo1
 02X2kxavP/7jAAFh+0qCTCCeuHxAcNo98i78vynR+N6A7IHqHyrCl4MMOhivNIWeeyli
 a5JMIJiXO/hcAN7waaT7lTJkbBjQKUZjJ3ekhoPZN6pz4nqzP6vhBzZ3FJD4NSFZMrXy
 bZaB/8bk8YUUzzzxDTfoSZnfpl1/Fb3/BejBM+iaVvhcZO1t1tUjgwuZ4eQ+GxhdJd1b
 g6tg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780697309; x=1781302109; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=guQ1bVcgFuVljo7/qDacbIN8uhJM4o1UejHHvAOmb6I=;
 b=VBmWd+0HcBp3158jVaqWWOialCIg/bHd3QRMoAR4hi2ohiZXqPpDiCPLlpD1KEgUY2
 hbwOkLdfyP7cTGB0BW4bjF7h7OaEKf1N7AppU3Pp5MRvB5o89Zh1SQEm4/kQjp2tlPmy
 JEjmuIRcE+P5fGsX6CUWlIz9y5WGauP4wqGrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780697309; x=1781302109;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=guQ1bVcgFuVljo7/qDacbIN8uhJM4o1UejHHvAOmb6I=;
 b=OFEZnRkVvrHUTyl27I2BXltxREN2AyDanrlpB2W0KDIKhSFq78j7OKuonuCNR000wT
 AN3qK87zeD0KmNdw5o/Hx5runrh3l4q/G4IQen7utxDLQWXDkrlzh6qHGoAToCpfAqwM
 MuGUZv58iUjwiwM0jl8rXipZpiUAoG9JxQ6uhLMPxF6v2H9LPooEPhH3+CSDN8aKD0+k
 MzgjwVPcSgmrJUbDYpZhP5yL+kl98QuqljuPyJrMwUYDL4/AgVgox4vkC0ddImUlMIxj
 KNSEIXDBoSQck3J3BQdE9UCerYHtEdVurfCi2CxXUQQg4Aw33jGja1dn7105DUYD2uJP
 IvbA==
X-Gm-Message-State: AOJu0YxpWVIzmNcUpxilCSSKlNBfS5AW5S+2u3cJKmwlj8S1mezfqhk2
 llvuCa0xytEVwykIHNg6Tct5tFX8ek0ntprX5ZnmvUOVkPglpmft0PjO3yH3jd6lA6SqKfvpgtP
 h8BLYF+264T9nCBJcVP6/61gtn2r44N1WgIUnU61V
X-Gm-Gg: Acq92OHlFgOEWzud1WuZWIs6IyXds1bWX/KwP/HHfy/B8ddEerRrjdfk18i1Z17R6k3
 wpqKO9DHJjbd1YTECaw5fq6tgXcR3PabzCjiaW+HqW3bI0DBZuLqmkL2SxB+Do2uHhcDsivZC70
 ynUxL5Om97qrtuk3JvBtNHJHgWuJJZRTfri8alwV+zjDymqEsWxgmqT3DcEt0Cny/1EhrjH1zsH
 Ok8dNcSusmVU7ASZWIYgyN9eH+8nacWWQHiS0fqtHEx7/THTbfvonas0CUhsl1XoneqmEOfBrAX
 9yN8coWGfvszcOJjTyCPmHnYE9A=
X-Received: by 2002:a05:6402:524f:b0:68d:b17a:543c with SMTP id
 4fb4d7f45d1cf-68ff2186061mr2111888a12.12.1780697309281; Fri, 05 Jun 2026
 15:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260602183052.65247-1-anton@binarly.io>
 <20260604103950.77778-1-anton@binarly.io>
In-Reply-To: <20260604103950.77778-1-anton@binarly.io>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 5 Jun 2026 16:08:15 -0600
X-Gm-Features: AVVi8Cdl8RGdImXt1ImFgr8WUdO9NLsAtkWu895WK4iqEzOk_oNYPzP9A0Dhw-Q
Message-ID: <CAFLszTiUqa3GNQNjDeh-v3x94eEdVswKCf9tU+=Qmd1uk=F0cA@mail.gmail.com>
Subject: Re: [PATCH v5] image-fit: Validate external data offset and size
To: anton@binarly.io
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com, vr@binarly.io
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

On 2026-06-04T10:39:50, Anton Ivanov <anton@binarly.io> wrote:
> image-fit: Validate external data offset and size
>
> fit_image_get_data() uses the data-position, data-offset, and
> data-size FIT properties without bounds checking. A crafted FIT
> image can specify values that cause out-of-bounds read during
> signature verification of an untrusted FIT.
>
> Validate that the external data offset and size are non-negative,
> and that the data region fits within the FIT image bounds.
>
> Signed-off-by: Anton Ivanov <anton@binarly.io>
>
> boot/image-fit.c            |  53 +++++++++++++-
>  test/py/tests/test_vboot.py | 165 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 216 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
