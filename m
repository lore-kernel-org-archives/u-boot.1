Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A98CF042E
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 02:00:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D57D289167;
	Wed,  9 Oct 2024 03:57:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RDVkYhXk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 570B489175; Wed,  9 Oct 2024 03:57:41 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B5FD890BC
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:57:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6cb2f272f8bso55057616d6.0
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728439058; x=1729043858; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FOaGCcI7w24wZSXxtPTrKVFs4Op+viFBv0kmd14ayTg=;
 b=RDVkYhXkNh/zvJxFKaJzBf9Biw1oWUin8rCH+XvMO9b+TJ8O4/oVhxnphB5Ci74+VP
 td7DBIYoqMBV7do6+scKMsJfovMjQpqo92MGDOUIBzIsQjzYXRPNqLqZEOZsvMCdKG2h
 Dw08tia1lDoILsGuM2waWcnfzZU5G6PMkYm5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728439058; x=1729043858;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FOaGCcI7w24wZSXxtPTrKVFs4Op+viFBv0kmd14ayTg=;
 b=QTo6dBrQ3SDkESBhtYfHr3sYR4ghP7xw1mbseIcnssg3vw8cST2zinjoYpkZn+60u6
 hkPbN1pPb2bPCZ01LgUm3HrBNxkf9eexH0LydY8SdVU9IMz37wkhW/zeFzyN8KGcGgiS
 +IXnMmoDp0pAxpMUP8LeKofhR3cbp8uKbYFNm4UGP5U25aON7nJYiZdYQ2/rVDjtRvhy
 KgM0rGY2Iu0yL4DEKqaNDKpnE6qilJGSf8ZvB8Zwz/bVrISUrQCdZ6GqIGoe20Wkhmca
 EcxLQs7J5/DWvVp/xDU4jaFG8do05b9zzVkZlrZRBtNT6sJsYfg0nHwBK7dEEhaJauSR
 uYNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8j2S03yD2JF/EgbhISj5NNPJXjXTimYXf9f57LfOtojSiRA0DmPZSy+OiQP4mvgZ50aTqvHU=@lists.denx.de
X-Gm-Message-State: AOJu0YzbnL0lXu0iArrKdBQDrEXDq9P3TtSZcuz/IW+ijmNMQU7sQea8
 3nM+Ikdw3cZsDPlWZQyGvB0OU6CmcFvD4kIERGRH+5pjOQCiqBaJ4nHwkaIE2z3bJSnKw0+XV6I
 nqb2m9sBOt5EOQzry2bOjSI0aEyakZ2NiwEtr
X-Google-Smtp-Source: AGHT+IEa0xxVX8uR2FrLDYAVYlz0fxmXFWQHhvFlOL01uU8oKegCSDjuASj0a1+h3GJeGccZLBSXDUgMM+lciukkFfY=
X-Received: by 2002:a05:6214:3f86:b0:6c5:73d3:2316 with SMTP id
 6a1803df08f44-6cbc954c5bfmr19875206d6.36.1728439058194; Tue, 08 Oct 2024
 18:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20241007205543.1632499-1-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20241007205543.1632499-1-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:57:27 -0600
Message-ID: <CAFLszThjoOakb6FgrdkhvjAn1fL00wZeTGRewWUedqSO3E6+dQ@mail.gmail.com>
Subject: Re: [PATCH v10 00/13] net: tcp: improve tcp support
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Baruch Siach <baruch@tkos.co.il>, Anand Moon <linux.amoon@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
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

Hi Mikhail,

On Mon, 7 Oct 2024 at 14:55, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> U-Boot support of LWIP is not ready for a moment, but we already have
> some kind of tcp support. Unfrotunately this support is really bad.

spelling

>
> Some of the known issues:
>  * tcp packet from other connection can break a current one
>  * tcp send sequence always starts from zero
>  * bad tcp options processing
>  * strange assumptions on packet size for selectiv acknowledge

spelling

>  * tcp interface assumes one of the two scenarios:
>      - data downloading from remote host to a board
>      - request-response exchange with a small packets
>    so it's not possible to upload large amount of data from the
>    board to remote host.
>  * wget test generate bad tcp stream, test should fail but it passes instead
>
> This series of patches fixes all of the above issuess.

spelling

>
> The benefits:
>  * A lot of bug was fixed
>  * Better and more reliable TCP state machine
>  * Tcp cliens becomes smaller/simpler

spelling

>  * Data uploading was fixed (now it's possible to transmit a huge amount of
>    data from the board to remote host)
>  * Netcat over tcp was implemented. Netcat supports data downloading/uploading
>    from/to remote host in client/server mode.
>  * An example web-server implementation. This code can be used as a base
>    for web-based firmware uploading used by some vendors.
>
> Modification was verified with
>  * firmware downloading via u-boot wget command
>  * fastboot over tcp
>  * netcat linux client
>  * Firefox/Chrome/Edge using example web-server implementation
>
> Changes v2:
>  * cover letter was added
>  * some patches were removed
>
> Changes v3:
>  * better cover letter
>
> Changes v4:
>  * fix bug in debug output
>  * add more comments
>  * codestyle fixes
>
> Changes v5:
>  * old patches were ocasionally sent with v4
>  * add back web-server patches
>  * fix bug in debug output
>  * add more comments
>  * codestyle fixes
>
> Changes v6:
>  * fix the wget test
>  * improve description of "simplify tcp header filling code" patch
>
> Changes v7:
>  * fix include ordering
>  * improve option descriptions
>  * fix a lot of extra brackets and comparisons against NULL / 0
>  * add empty lines before final returns
>  * fixed a bug with zero size httpd uploads
>
> Changes v8:
>  * [tcp] add function to restart rx inactivity timeout. This may help
>         in the cases where remote peer waits for u-boot data, but u-boot
>         is busy with long executing action
>  * [httpd] add function returning underlying tcp stream from request id.
>         This (with the above change) allows avoid connection break
>         for the long processing post requests.
>
> Changes v9:
>  * rebase all changes on top of origin/next
>  * update test/cmd/wget patch description (bad tcp ack/seq issue was already
>    fixed in origin/next)
>  * tcp: add rx/tx packet counters to a tcp_stream structure
>  * wget: use tcp rx packet counter instead of own one
>  * netcat: use tcp rx/tx packet counters instead of own one
>
> Changes v10:
>  * netcat: fix bug appeared after rx/tx packet counter addition
>  * rebased on top of v2024.10

Is this series ready to go in?

Regards,
SImon
