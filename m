Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06FBEE57FB
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:03:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3031188E15;
	Thu, 12 Sep 2024 03:00:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AMIHiu/1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40A0988DAF; Thu, 12 Sep 2024 03:00:34 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 999AE88DF5
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 03:00:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-718e6299191so218156b3a.2
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 18:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102826; x=1726707626; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MfTtR3jCYPBW6kMXyjpF+WR8K7OPj/hXurQpEEsk+W8=;
 b=AMIHiu/1kFgZBW3wTZek51f0897a+bUIR/DUSN+2eQIG7Xk6qwKIDftSHbotSOLiO2
 xjXl/99gQXUpffLP/jWlyXcCw5IU5cIzMpQ4gU1CzEMCCemq2RWhoDqiWk9C3lHs7v0F
 sv0vKc9c02HDoJhe9leMHakWsRXm9zM2eVpqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102826; x=1726707626;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MfTtR3jCYPBW6kMXyjpF+WR8K7OPj/hXurQpEEsk+W8=;
 b=GlfSVG/j1FBPfC/7vx8pCTIuYOCzfI2FpFmcuq2L5rMJVUN6cE8JccIlrbsElmbWJ6
 uTWw6P8fhiKkxyTuDNMIHpEPNymynyanTEZe5DlhxAn1fxQQSPRDP/+9sCSjXa7A0xLp
 sUylewqTmsrukNfs+hF7QwlzhSD9I1UdbICq9IDm0mPNZ/55A3r1/VoFE9o7r3NBvtzz
 C30l/gnlg1/VtAWQZmtlK3KWqB8IsllBW+KY26KC8GQl5hBJ/AH6dAvdHYjKNe6B7jHh
 nxMPzGoKQZocMyLU8cl9t1Hjj0h/a/zxI449YP1eb3xsLJBAyztWeWpd4ydJ4/0FH9yO
 fCZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdDVBk54PumiLzZmL5E6LCbKDK56aRaryfYk0SthpsnI7HcjgLUQGAAzwP6WbDuquBgbfR7d8=@lists.denx.de
X-Gm-Message-State: AOJu0YwgwN0lUmUjGOJcYSD69FEI+UrQrah6cO0n3xZV3+TCttxyxgPQ
 LfIXMnfv8bd4de+EQuc3i144sghQ6Gz7EuqXb9D3O7Zd+ItJRj6nCLgZ1p8ANmO0oSw77fzsRNE
 761nIpq3VE9NdRuYBOJRY5khJhAi7jyAD4/6L
X-Google-Smtp-Source: AGHT+IHi/qmPYPQIcLSzqNMKWZRZ2HVDnit2ObtWe2i0NhNYUSVeLoI5FCIAy8PuX+hgxe3tu4u22eZuB2hUsn3vhIU=
X-Received: by 2002:a05:6a00:1253:b0:714:2482:ab3c with SMTP id
 d2e1a72fcca58-7192606bb00mr1864631b3a.7.1726102825961; Wed, 11 Sep 2024
 18:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240909222720.2563118-1-mikhail.kshevetskiy@iopsys.eu>
 <20240909222720.2563118-7-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240909222720.2563118-7-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 18:59:51 -0600
Message-ID: <CAFLszTi39OU=mZrivEDxE3mTwySDKdCYMT3_DdLnEh6ardwCQQ@mail.gmail.com>
Subject: Re: [PATCH v6 06/12] net/tcp: improve tcp framework,
 use better state machine
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Baruch Siach <baruch@tkos.co.il>, Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Richard Weinberger <richard@nod.at>, u-boot@lists.denx.de
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

On Mon, 9 Sept 2024 at 16:27, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> Changes:
>  * Fix initial send sequence always zero issue
>  * Use state machine close to RFC 9293. This should make TCP
>    transfers more reliable (now we can upload a huge array
>    of data from the board to external server)
>  * Improve TCP framework a lot. This should make tcp client
>    code much more simple.
>  * rewrite wget with new tcp stack
>  * rewrite fastboot_tcp with new tcp stack
>
> It's quite hard to fix the initial send sequence (ISS) issue
> with the separate patch. A naive attempt to fix an issue
> inside the tcp_set_tcp_header() function will break tcp packet
> retransmit logic in wget and other clients.
>
> Example:
>   Wget stores tcp_seq_num value before tcp_set_tcp_header() will
>   be called and (on failure) retransmit the packet with the stored
>   tcp_seq_num value. Thus:
>     * the same ISS must allways be used (current case)
>     * or tcp clients needs to generate a proper ISS when
>       required.
>
> A proper ISS fix will require a big redesing comparable with
> a this one.
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  include/net/tcp.h  | 179 ++++++++--
>  include/net/wget.h |   8 -
>  net/fastboot_tcp.c | 190 +++++-----
>  net/net.c          |   4 +
>  net/tcp.c          | 845 ++++++++++++++++++++++++++++++++++-----------
>  net/wget.c         | 460 +++++++-----------------
>  6 files changed, 1008 insertions(+), 678 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Yes, I understand this cannot really be split up...
