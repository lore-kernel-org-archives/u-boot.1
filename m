Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8C4CAC5B8
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 22:33:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 569798361E;
	Sat, 27 Sep 2025 00:33:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fCcVT937";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23CE2836A3; Sat, 27 Sep 2025 00:33:08 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FDBE8319C
 for <u-boot@lists.denx.de>; Sat, 27 Sep 2025 00:33:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-8ca2e53c0d3so122990039f.1
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 15:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758925984; x=1759530784; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sbPSd+qG0cLmVhfJa/vR5X2OIMA0AskAMXVp62aedk4=;
 b=fCcVT937CSgvb+RUes0fxl3M1pJXoBDfjs6aAcFlmk7TBkGxt3IJu/r2AOVNEiqUMY
 DTjmdCoXs4pVj8d7gn/SL2HfLfon8NbeuJA4KXG5GdTIZtgIb+9I6Y/doVCNDAU/Wif+
 gAU+uFFvtB8NQEYkmt2gmLNzxSxJotytH3nOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758925984; x=1759530784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sbPSd+qG0cLmVhfJa/vR5X2OIMA0AskAMXVp62aedk4=;
 b=Woku7k7vdZySWRYUB2hotVBUeAiNGSj2SWcBkTP7Du2YMm/Ivf+ImAmFqBEikFoScV
 Up9Sb25DsIGM7F/q9KTNnT/uIaS1EI49U3VViDJintqWxpeRaa2DTYj0z1wt/6vk9l+z
 HCjLgBqWQmTwA9bf7QFmuAV/teMAiqa6/qrPA43g97SKb2yO0MdwcuCZ8RYWzMz1lUwY
 bQUfuZgUnRALYWsOOw30yIwd4m8lI/AhsyZ2SiuJ3OrPmfgt+OMwJjAIHaOosAzKs2sm
 zobL8qHehf8HgrQFY7n/oaBEy8RDJyu9D1+AfYw9Z3BMJmlK6FO9H2g2sIOp6oWAxT1t
 haKA==
X-Gm-Message-State: AOJu0YxGuN/L/WnKdE/RQdglcMrcWBc3+cau7MgX+V4C2Y/gsXsMz98W
 XFHPGz8zeyny66fy746BDFGQkWk+DBAVfVdCD/cGbf4p0hBUDyAm59sYVKInVl+3/S/X9jXHR5V
 HwZXZlb4=
X-Gm-Gg: ASbGnctlwHYQC9rvOshfKraBOJ9IVjtdlxQByIZYdjzKUH5QmVAbus58tFoiyHHKnJv
 iQZGtNZwL7Jlam1ulJrbjFwXh/P5w+rZ6eQYpyUri6Iz2vl+sRQcLve2obOYziebqThXtPuqWt8
 c3d+ovMKmXr026C+Ef6C2bEcX8hVOJJjaV6/LsEYruVxiFMqpQEG+FVh4h0Xm2/s8spOpDHZoGk
 ASm4gPzRN5T8XJBple9O3wCbDf7JwTWjMhyzT6r+DRCBN/deIiAM5l0TrfyRSVB9IWUNlgM7K9/
 A/k7ljEmsH8skXBzVZAmoR3tAg1nxahuhM2M699UQxoTmyw9BHnt3G6tG9N6Lc5co2AOY5P/ZzU
 px/EFFuZrx/6foShXlpfaSNnMWNzMEOJay0lWgEk1s2v0+/CkCMCKVJLrncLzri+aCaqPfQ==
X-Google-Smtp-Source: AGHT+IEFq2W9TPK6k7tVZB6WweIXuxo3fip6tIW2LydjQPquO+WrRzf0Hn/fUoF/VqjlqstHagscbg==
X-Received: by 2002:a05:6e02:1aae:b0:424:7ef5:aeb with SMTP id
 e9e14a558f8ab-4259563befbmr124933425ab.17.1758925984264; 
 Fri, 26 Sep 2025 15:33:04 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-425bc68e3dbsm27354935ab.15.2025.09.26.15.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 15:33:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: Re: [PATCH 0/9] exports overhaul
Date: Fri, 26 Sep 2025 16:33:01 -0600
Message-ID: <175892323904.3793125.11379082267045828474.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919101002.568488-1-ravi@prevas.dk>
References: <20250919101002.568488-1-ravi@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Fri, 19 Sep 2025 12:09:53 +0200, Rasmus Villemoes wrote:

> This all started from me wondering "why does this standalone app end
> up being so huge"? Oh, it essentially links in its own standard C
> library to get strlen() and snprintf(). Which then led to asking "why
> don't we export all those standard C functions when we have them
> anyway?".
> 
> CI has chewed on these and seem happy - it was CI which told me about
> the necessity of [1/9]: https://github.com/u-boot/u-boot/pull/813
> 
> [...]

Now, it's important to note that this does increase the size of the API option
because it adds more functionality there. Some size constrained platforms may
wish to disable API support altogther and gain more space savings.

Applied to u-boot/next, thanks!

[1/9] malloc.h: be a bit more consistent with macro definitions
      commit: e54bf98c3afc6dc6e6ce9496c217cb1c660aac4d
[2/9] _exports.h: drop creating dummy i2c entries and fixup config dependency
      commit: 0933358163a3c0ef13577853194769504cfb39ea
[3/9] _exports.h: simplify condition for including spi functions
      commit: 475a72f6471194633fd85a813547bebe846611e0
[4/9] _exports.h: drop the last dummy entries
      commit: eb178c849c25024225941db79c1c3b9681a46a80
[5/9] exports.c: drop unused dummy function
      commit: a78941bc7ff72ab3b67197d53216306429e6a831
[6/9] exports.h: make sure declarations are in sync with the actual exports
      commit: bdbaaee65c69eebe1ee47296fa2fb12a4677697c
[7/9] _exports.h: reorganize a bit
      commit: 2ef6c17f7f46a908e99e24de53d2c153dc1972ab
[8/9] _exports.h: export standard memory/string handling functions
      commit: d95706158203db0b2281e134e8dfbad87e3d668c
[9/9] exports.h: bump XF_VERSION
      commit: 07588f4ad9b80e73726fd7ecb8e17e21785322a0
-- 
Tom

