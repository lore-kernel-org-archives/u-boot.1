Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C42E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 17:38:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53883803D2;
	Fri, 20 Dec 2024 18:38:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lZhsB/sq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E5BE80381; Fri, 20 Dec 2024 18:37:59 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90B18803D2
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 18:37:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aa662795ca3so626892066b.1
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 09:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734716276; x=1735321076; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6dG0S+bRenC+7ucMqXg0HugVpjWRlYzE8RJfnOvkowM=;
 b=lZhsB/sqZ4qbwWUieU16cGvqoB2qu1wUt7bSWGGPCDQhNFeMES8Pw9BRqQk6BGcrTa
 +HIHlSrZxB/i0ngdqlkzWrBCm0w+7LfkOwfPmGX96wve2yjy+egzKNXI8NQf5FrORD9l
 3Iwosj7OxUdB9HNHU1YQ217qeT8baef+JMhyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734716276; x=1735321076;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6dG0S+bRenC+7ucMqXg0HugVpjWRlYzE8RJfnOvkowM=;
 b=sSsDT2KDloVds0C1S86f6Mv0vbP9rqdAPJaq1AQ3vJXg1H8juLviagDJhuL9JVnyqI
 vuBP6NowXehequ9wfrmqV9GC+GRImLBigcNSjwUXuWpcFFbKnqwtBQUNKkiKrfFd9muM
 +Ih0nq52o1sroT/88BWQNIjxgBljKVf2ynEvvm1yBIrMxz4hTAwosVTIPbYQME57ee1I
 /8vfUDm94fk83m4uq3JRWSSA+4QstnbpnEU30fPpKDglvNgBLESQ8829+YDGHEjjdAlv
 5K6WXJva7MD6TBTYi3DQsKd0fZ+pCHeOaJaZf73aiRROT37z0kfUEDXmZ61yzLrnkIwm
 hcjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6yrr+NrdHfgYQ9EIG502yeQmpR2Ny31oGKkn7LAcjlbv1Hh4q8of5UM+FiY9Q654Z3Qas1xg=@lists.denx.de
X-Gm-Message-State: AOJu0YwQqSfmtdUtybUtVpiBsZIFPpwgEB6+nms6X+CCS6xGuL9xfiql
 5/4qGSdCrQUdGYWj1Kbl9QxR4+ZzVHaHGmHVxpHV53q4/Wjy/wsuG1RcRSd3Rh0vh1Hu37sp9ey
 U3pFMNgdYod/Bwh5+SpQSi9WlBhLMOw0NQDBh
X-Gm-Gg: ASbGncs3HXLV76h/OQE5Dy9tymX2xsKj5Pw+QJrHQgOef23uHjHf/CdJFX2PQ8yr5pk
 Xap4JGYrCU4HhMp1Hu4s7zwOJEpWieiFIdqLzjTs=
X-Google-Smtp-Source: AGHT+IE3nlmBn94T/MPfFkCRJpJS/0WvDaE2Qa/rTtntdDBjO+ikaoEkj+Uv5YYzaMkLMCOEYZZhxvRj+p7baaqGuI0=
X-Received: by 2002:a17:907:3da4:b0:aa6:89b9:e9bd with SMTP id
 a640c23a62f3a-aac346970e7mr300635466b.24.1734716276026; Fri, 20 Dec 2024
 09:37:56 -0800 (PST)
MIME-Version: 1.0
References: <20241220002156.87780-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241220002156.87780-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Dec 2024 10:37:43 -0700
Message-ID: <CAFLszThVGVL05j-WQVjZ2RjJ9DsX+GJqoHpBxU1gSy-c+Q7knw@mail.gmail.com>
Subject: Re: [PATCH 1/1] buildman: allow specifying configuration fragments
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, u-boot@lists.denx.de
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

On Thu, 19 Dec 2024 at 17:22, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Currently we are no able to build with configuration fragments in our CI.
> With this patch buildman gets a new argument --fragments for passing a
> comma separated list of configuration fragments to add to the board
> defconfigs.
>
>     tools/buildman/buildman \
>     -o build \
>     -k qemu-riscv64_smode \
>     --fragments acpi.config
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  tools/buildman/builder.py       |  3 ++-
>  tools/buildman/builderthread.py | 18 +++++++++++-------
>  tools/buildman/cmdline.py       |  2 ++
>  tools/buildman/control.py       |  2 +-
>  4 files changed, 16 insertions(+), 9 deletions(-)

As per irc, please add docs and a test (you should be able to follow
the tests that do similar things).

Regards,
Simon
