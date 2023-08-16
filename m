Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4C3C001DF
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 17:05:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15B5F869BF;
	Wed, 16 Aug 2023 19:05:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KWgeUWye";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D680846EE; Wed, 16 Aug 2023 19:05:28 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECCA7869F6
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 19:05:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-977e0fbd742so878563766b.2
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 10:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692205524; x=1692810324;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/35XfXtoOACbtbRjvl/k/BAns0ZXzSCLyISfBDob2HE=;
 b=KWgeUWye1Pb2bGWkyDWJRoffpiv551sIgan/323YRZBKVTlGDedyvFvMO8olBgYxq1
 y0zvqk8K4pqI7veLxoPouhm9NzK62hLgozjQcItR7+Z4vhchFaAARYY1xk29MptCdVUr
 YdqgPuPaK88QyOo+xaHmfBP6iYSEg2jmgfXJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692205524; x=1692810324;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/35XfXtoOACbtbRjvl/k/BAns0ZXzSCLyISfBDob2HE=;
 b=B0inn7P9X5+TxsQsH6D5o53UL5Wf9SfHKQ43QqE4SaEadiCzLQxXScDKkjg8S0aqF0
 9lpBDYPHlV8K+sFTBwRra7MVnpJTO3dFWZSO3sDrCCh9frJW+Nzc39bD1qna7OSpHQPJ
 pg6xr+k9oLSQJrtjb+2p4DjPceEGZYvIKmk0u75+tXg5TqdFpLfejHXfX7+B34Uvm91W
 woCxQU0Vyf8O9IbpaLLOyRY3VpLj3hwiyrlviKrudqRiQJq0D6VHT6vQVZmP9rvVx7OP
 3SB5UDHylgQ7N/FgwjY/fUWFhLOTnLhY7gV9PuUxPmIX+uFwlmruNygAtwtVdRFDBWEG
 LC2w==
X-Gm-Message-State: AOJu0Yzn7x/WL2M2mTkvorCLDnLJIopZE3OMS4BZcMnftjKuF23ZLjrk
 GswcB3xIHJkl9pct00QPYaKovUiNbth9l9qvIaHzfQ==
X-Google-Smtp-Source: AGHT+IHlqQqLPYVy9lmMAngX414ZOfi3ryDPFb88Zt4O81cPXTFg6SKBdsylVLrQ3MsmSraF/3KecEx/vqv6bMC0l8w=
X-Received: by 2002:a17:906:1444:b0:969:7739:2eb7 with SMTP id
 q4-20020a170906144400b0096977392eb7mr1694197ejc.4.1692205524266; Wed, 16 Aug
 2023 10:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230815103259.17476-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ0BB90F4Zpq6AtyTPuME3XiJJYmYUOBhFCG9FujOq4wHw@mail.gmail.com>
 <d359a225-fbda-3bfd-ee5a-6cab8e011568@canonical.com>
In-Reply-To: <d359a225-fbda-3bfd-ee5a-6cab8e011568@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 16 Aug 2023 11:05:12 -0600
Message-ID: <CAPnjgZ3Ssh8=fvdRa+KM5h5BS9LQs1bTjdku=JqtqRA4rqLDFQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] doc: add partition API to HTML documentation
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Joshua Watt <jpewhacker@gmail.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On Tue, 15 Aug 2023 at 09:18, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
>
>
> On 8/15/23 16:44, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Tue, 15 Aug 2023 at 04:32, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> * Convert comments in part.h to Sphinx style.
> >> * Create documentation page for the partition API.
> >> * Add the partition API page to the API index page.
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >>   doc/api/index.rst |   1 +
> >>   doc/api/part.rst  |   6 ++
> >>   include/part.h    | 210 ++++++++++++++++++++++++----------------------
> >>   3 files changed, 119 insertions(+), 98 deletions(-)
> >>   create mode 100644 doc/api/part.rst
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > Q below
> >
> >>
> >> diff --git a/doc/api/index.rst b/doc/api/index.rst
> >> index a9338cfef9..3a80ae0635 100644
> >> --- a/doc/api/index.rst
> >> +++ b/doc/api/index.rst
> >> @@ -15,6 +15,7 @@ U-Boot API documentation
> >>      lmb
> >>      logging
> >>      nvmem
> >> +   part
> >>      pinctrl
> >>      rng
> >>      sandbox
> >> diff --git a/doc/api/part.rst b/doc/api/part.rst
> >> new file mode 100644
> >> index 0000000000..d1df1d8494
> >> --- /dev/null
> >> +++ b/doc/api/part.rst
> >> @@ -0,0 +1,6 @@
> >> +.. SPDX-License-Identifier: GPL-2.0+
> >> +
> >> +Partition API
> >> +=============
> >> +[..]
> >
> >> +/**
> >> + * struct part_driver - partition driver
> >> + */
> >>   struct part_driver {
> >> +       /** @name:      partition name */
> >>          const char *name;
> >> +       /** @part_type: (MBR) partition type */
> >>          int part_type;
> >> -       const int max_entries;  /* maximum number of entries to search */
> >> -
> >> +       /** @max_entries:       maximum number of partition table entries */
> >> +       const int max_entries;
> >>          /**
> >> -        * get_info() - Get information about a partition
> >> +        * @get_info:           Get information about a partition
> >
> > Are we not allowed the () at end? I much prefer brackets as they show
> > it is a function.
>
> Thanks for reviewing.
>
> 'make htmldocs' does not like parentheses here:
>
> Incorrect use of kernel-doc format:
> * @get_info(): Get ...
> Incorrect use of kernel-doc format:
> * @get_info() - Get ...
>
> We are using code from the kernel.org. We would have to change that
> upstream first:
>
> scripts/kernel-doc:2325:
> print STDERR "Incorrect use of kernel-doc format: $_";

OK thank you, I will send an mail about it.

Do you think you could base your part on [1], since I changed the same
file? It is available at u-boot-dm/methb-working

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=368613
