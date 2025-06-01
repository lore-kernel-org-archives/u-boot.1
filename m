Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F392C54FB3
	for <u-boot@archiver.kernel.org>; Sun,  1 Jun 2025 12:05:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E11CC82A76;
	Sun,  1 Jun 2025 14:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WyBZ2+zI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 215D682AAF; Sun,  1 Jun 2025 14:05:36 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32CA882A46
 for <u-boot@lists.denx.de>; Sun,  1 Jun 2025 14:05:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6049431b0e9so5543532a12.0
 for <u-boot@lists.denx.de>; Sun, 01 Jun 2025 05:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748779533; x=1749384333; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AbkgBN7w6tGP1fz4IJA97RKPou61+u6ildONUnTp9AI=;
 b=WyBZ2+zI/sB0+TbMOZiSvFn/IiqeyEidI+c/NwZG/kooN4yzMKsdKBIcLtD56XYS/t
 BFbyaTSsf6nOk20/M+2WKbm6YrfvSp1YE6dYxInOyLIhweKKeIvT2+BA561BfykelYRh
 xohmRMKwaQUraDViSrL0mOrdMTew66agH/DIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748779533; x=1749384333;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AbkgBN7w6tGP1fz4IJA97RKPou61+u6ildONUnTp9AI=;
 b=si/FRu/ZVpnkqhGhwARIMh5C6lipzgSxCsQty+5TH0i9jkft3+xAsKCdhKTjLk5S50
 6BWlD7lm5tqgV19zYWG5J77HCkVMkFuLMCopR3WCJJ8NayBay2ut9P0uxZhnWiwq6qwl
 yemf3dqB8dsm3a45hrhBdUm4X/J5JFWxEBKtkgVpApndXyjvTOwMd+HsxkifeZaSBNan
 5kDdRT5pXMdG/88vQUgdviYOBuc+UHQXy3yFd1guxLMW3KmuwgybsuL1oH7Urt0Y9zBs
 PQ6qDYrguSkQAzKguCjzISvbnytPabF8WdLFHP1z6cInzYTjWYBKop5QLaRRqZh59RM5
 KedA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqOWGEjznTcPa5gWddSafFnpbpfca5Wl6bwAnY8ZjtoGxX2mJ2zjeP7iaQNrS7XA0U47tQ380=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5DomYVaOP/Vy+3SM21FO5mNtcHpjzdSv/jyrkFhVXSQ5hsRZq
 UESNw4IVAH8AD5wwRKN2eK+AbKq4ain+gLiQfA6OMCZ5lYvDo4lkO+GeepyNcKOIqkXuQNSmfq8
 sh9dk+jLHbAz4uyicA8OD9kJzXYvDl6/bglDlg6cmrArSg2f7oxhl1IoY
X-Gm-Gg: ASbGncujmNtDpykBppxGerzirSK1aXGMGwRVCy0uuqXnC9k5gHgz6T5Ubv6OY7D2MQy
 8F6J24K5wLixBMIm6Rh88nx9pgiW0oHg3zE4DUjsn32rFXmRm0485wtJVFaL7K5gdSGPGdfDvd4
 3cnGrwPtIxhgJkuaqkrdDo4WE2SeicdeYE
X-Google-Smtp-Source: AGHT+IFvJ75TociUd/f6sKClRVaW4MGZDRac4zC8ACxqiIY1vUnxUyPpg1abcN52cZxnDX27VV77IlBolsANu8VcY10=
X-Received: by 2002:a05:6402:26cc:b0:5ff:abb9:2d63 with SMTP id
 4fb4d7f45d1cf-6057c628312mr7340650a12.23.1748779533652; Sun, 01 Jun 2025
 05:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250601120406.2106-1-sjg@chromium.org>
In-Reply-To: <20250601120406.2106-1-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Jun 2025 13:05:19 +0100
X-Gm-Features: AX0GCFtKeAYjLVZNaHodVMVsDqLh6eTv6gvgxao4uUvaNYg76_-mjBrwTOPkiJ0
Message-ID: <CAFLszTjQ-1PrUiHauQgDGjJ2ShEM5j+scJrQCjncvL+M1KCxwQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] doc: efi_loader: Tidy up the bootefi-command docs
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi,

On Sun, 1 Jun 2025 at 13:04, Simon Glass <sjg@chromium.org> wrote:
>
> There are backslashes in some of the tags which seems to be unnecessary.
> Remove then.
>
> Change the word 'either' to 'any' since there are three options.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  doc/usage/cmd/bootefi.rst | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Sorry, please ignore this; sent by mistake.

Regards,
Simon
