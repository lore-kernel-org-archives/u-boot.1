Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B4EC52D73
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 06:22:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42771889D5;
	Thu,  8 Aug 2024 08:22:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DIYqyD6k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2CB98890F; Thu,  8 Aug 2024 08:22:37 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D57DA8890F
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 08:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5b3fff87e6bso586939a12.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 23:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723098155; x=1723702955; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pb0Z1Zsk6+ktwfV0cRza7lJXA5/XHgm+H/LZomS0DME=;
 b=DIYqyD6krR5uowoWVmIRPEP9z0XQKt513eFbgEeJOIhbod/ZfU5lLY6NUEaKeBqBkh
 UQvIby+ANlKpqaI5RO0oyfmJB90mzigvCxRzvhX+P+lHIBjzqVe5nCwH2nD3N5zkurd1
 0ltTVF8O5nQD4HXD+aUv02fVWRha5WN2krqq8YIr2SVNK1DQ/AjLuGKmz1YOK8wIU1Bu
 C0q8HzIQKjezF+sQJrpSl4t5KulM7tdGGHsmT7Y6uyR6R/6V272o0BPvZkSJ2wYA5aTX
 ojjOLmDz91die7apFxvcH2Cwon/LGjzyP9ZMhlXtrbELs3M2IumtcM+o5s2FdM3TM31X
 2S1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723098155; x=1723702955;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pb0Z1Zsk6+ktwfV0cRza7lJXA5/XHgm+H/LZomS0DME=;
 b=g8irOXt/yDhsRwWcwGUnQJaxn00J1ncuXhS/gHhVLu/cCNVsxaJAdicFC/TNk/kvLR
 kBdXFB9MG3Aej8lrJdunslG3uGlJsAxCIc3p3tSkuPNS7W6MWOIgEn9gqXtvsKPTlYGg
 7g6ER6g0SyKM76EW+Zb+xclX5D8xGZTFFy55XMpUoxYIDo6BAve4HY7qpGqQ9sRS6lsX
 tXjc+DIAmqTec2P3urltljNVs/j/GkP2bmBHeLQe5bY0oX1n5IF0orVD9yRfjhNEvlHv
 I9NPpeeuCdRs8kg2gKsGlgjtbMvdqsODsDc9BRrASDDEQZsUwhxfajydHUqUQRT8Cmeq
 8Snw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB+qnK+JwwhKZKDfiWVrT4AhwIbZm3XVEhUa/uYqIP8XicUUKZoAzrLH3/7DL7BOP/C5lUNq9CQTlOgBCF+0Gj4R4FOQ==
X-Gm-Message-State: AOJu0YzaBjBO9bw+M4mz/MAk9Xj1QC/uC0af8q6by4eyhmsuPIzWoUYm
 prrZUxYAUrrAJE7iQ537r2qQ53VCDJxTWUSdfTRBhb8TYLZdTEWnI+tcnYEbJnqy2GmTvtOeZzG
 PbQmTIUs1Pecd7NufXVzwFt5NNrVGlsMBbJC/VA==
X-Google-Smtp-Source: AGHT+IGmw7IbzhuRlpDQR0UML7M9x3wEyZFWVL9v8nj7QfHPDAplQwe2TtaMnNa3DXkiWZBzh3STpWh8UbUU2euZaXI=
X-Received: by 2002:a05:6402:11cc:b0:5bb:9b09:8c7e with SMTP id
 4fb4d7f45d1cf-5bbb233e786mr707874a12.26.1723098155049; Wed, 07 Aug 2024
 23:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240806120659.686073-1-prasad.kummari@amd.com>
 <20240807211221.GK1626301@bill-the-cat>
 <e62e3c69-e9c4-4a0a-bf65-c21082ce7e27@amd.com>
In-Reply-To: <e62e3c69-e9c4-4a0a-bf65-c21082ce7e27@amd.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 8 Aug 2024 11:52:23 +0530
Message-ID: <CADg8p95DQvRAXdon_Hx+mYst-u9HTfprQ=6jwgSQThWX=GDSZg@mail.gmail.com>
Subject: Re: [PATCH] cmd: sf: prevent overwriting the reserved memory
To: Michal Simek <michal.simek@amd.com>
Cc: Tom Rini <trini@konsulko.com>, Prasad Kummari <prasad.kummari@amd.com>,
 u-boot@lists.denx.de, 
 git@amd.com, venkatesh.abbarapu@amd.com, git@xilinx.com, 
 jagan@amarulasolutions.com, n-francis@ti.com, d-gole@ti.com, 
 Simon Glass <sjg@chromium.org>
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

On Thu, 8 Aug 2024 at 11:05, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 8/7/24 23:12, Tom Rini wrote:
> > On Tue, Aug 06, 2024 at 05:37:00PM +0530, Prasad Kummari wrote:
> >
> >> Added LMB API to prevent SF command from overwriting reserved
> >> memory areas. The current SPI code does not use LMB APIs for
> >> loading data into memory addresses. To resolve this, LMB APIs
> >> were added to check the load address of an SF command and ensure it
> >> does not overwrite reserved memory addresses. Similar checks are
> >> used in TFTP, serial load, and boot code to prevent overwriting
> >> reserved memory.
> >>
> >> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
> >
> > This is a much more generic issue that should be looked in to with the
> > LMB rewrite that Sughosh is working on.
>
> yes. And is it going to be the part of his series?
> I expect that if he accepts this will be done on the top of it and there is
> likely no reason to wait.

This change would be needed, but in a different form. The patch, since
based on the current master branch, is assuming a local lmb memory
map. My series is doing away with that, and so we will no longer have
the lmb_init_and_reserve() API, for example. I would suggest that the
patch be put out either on top of my patches, or ideally, once the lmb
patches get merged.


> We find the issue out on system which has more dynamic behavior that spi pytest
> read the whole memory and rewrite TF-A.
>
> And currently we are in situation where some commands are checking reserved
> location and some of them not.

Like you mention in another email, there are instances where we have
commands which are loading images to memory, but are not considering
the lmb reservations. These should be fixed, similar to what this
patch is attempting. Maybe we need a common function where the load
address gets checked with the lmb module, similar to
fs_read_lmb_check(), and then have this called from the various
commands?

-sughosh

>
> Thanks,
> Michal
