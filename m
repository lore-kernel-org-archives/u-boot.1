Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B323CFD317
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 09:55:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD15583D5D;
	Mon, 24 Nov 2025 10:55:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iha/ghPB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C929C83D8A; Mon, 24 Nov 2025 10:55:10 +0100 (CET)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B352C83D62
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 10:55:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64107188baeso3528774d50.3
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 01:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763978107; x=1764582907; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T17F9NQ+lO1iZgpzADisIwwWnqVl0Tf0B2LEyw+883w=;
 b=iha/ghPB0hqS7O4d2AaUeWze3J1ZO5A5mbKANJwirxaMnZJipaL+6OHIE+GTBqdSBJ
 EBzTY8JE+F5mc8C+gIs5o0yNGFOhqCVUtcYJ7KBbkyINZqfSw/0tVgDnt5qD15hXXqA6
 8JulrDE3s6xzNNSnf3UxGWEsMxyHKDYgYFQHhGcxeJDdQJ+SRz7SP6LfUHh5RNGhFHPV
 1hxKctcCDNIsETwmI1Pc+62gVFkut1z2r6xWnnsJ7iQt53k57b9wvU1lBwQjpS7903+9
 SQtP6sQV6MKSVCEd4jvq6WCBJsq3OvdkXI9WeVqXgw7jjYibFJN56yd7OYvo81AhcIOO
 Gljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763978107; x=1764582907;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T17F9NQ+lO1iZgpzADisIwwWnqVl0Tf0B2LEyw+883w=;
 b=FnOsBFmjhLTyNThSYyKbOvu/8VL/t8qd468PoReSxZv8U5f8BEt49l2MDfX8onG7J/
 i8z591FTjfHNEEer6HVmhAcuHM24sOGNkr6jwBFNNfcgbpBco7lrw92KutUEkamfqYXW
 pQBQdP1hBcyKkSZNtk7X9opRgaPoAyk0FjOu+BeK8P9pRAANmNglW/mnQvDBgaxFScc7
 roez0RKjlZvUI/2IgaPAJ8gHgH4N1UsO7h3nQzHnT9kqzckJgtQiCFB4sr/SrPKw1RDh
 a0paxrqPcejNXqC+vyq46tObwD8nplXE3MZFdPF5/+kylt3efsjTqIm/FnUS4V4zHb0Y
 YOTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJghKKjq7JutR8c5KMHl4ZQGlZ8BzpSBkCKzw/WvdmUDuV1N8lDJlMiQE6VBftlubSIYqxsRk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6lWithD9MX8F5BqM1dbdWa8m1uqT+1yJZhbL1W/EWCwFRytfv
 0BRLkutswOVkDprmrIPRBt85mr4x6hYv7WLnDx9B7X7IMgOlsu9TjBqHPBKA3oHnqcCo4ar3CUx
 Xo8OLXxRhXC+TY/UuHsYKEeFWV9xc0Q6LhUL00y7wYw==
X-Gm-Gg: ASbGnctEvy3AmvpaHJaUfDS9ANlP79teKQnMoGWgFFwrgcPulZC5WPdIK7A6YAKp+mW
 ntZmbLBPY4xVt8Fd9RV5r3EkrQ79o6qBI8gipgw71a1Bylh6Bdd0c7fWvFR/5wWyU/xOnW9rCa2
 fvAXo/dwWqLqSRuBwL4NcmvNmCN29sBpjEdwReYJ5/Qc2TPawnbfZXmNIL4ha98o5S1G8RiaeVC
 Jhlauc0jF1UAlqtxgm+Ju4GDTzTDZIckDGB3sl2uvpLxulHdQ6cZNX2iV2TWn3tgKdFwqDqQLSo
 aSPOMes0c8YzCWOh5N5VC6FrnA85iYjVqC/tebEzQJ+ohMeRnPc=
X-Google-Smtp-Source: AGHT+IG++Jwnhrr/hFURJ087u2WdtNqX/eYioMGVKXudd986PUGPr31jFQvB1gX6PtYMibKywiTkQmJY/3TvvBqJ7xM=
X-Received: by 2002:a53:c043:0:20b0:641:f5bc:6962 with SMTP id
 956f58d0204a3-64302b3f5afmr6693824d50.78.1763978107518; Mon, 24 Nov 2025
 01:55:07 -0800 (PST)
MIME-Version: 1.0
References: <20251123225711.227016-1-heinrich.schuchardt@canonical.com>
 <20251123225711.227016-6-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251123225711.227016-6-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 24 Nov 2025 11:54:31 +0200
X-Gm-Features: AWmQ_bmVq16IwVBoJ5F4UJtX3GWxLod36P6D1jIfznuoVKwnSdynKuQ6X1xutoY
Message-ID: <CAC_iWj+CMsNZnwmUvWNawEcZTOwur-Dfd-eoj-4JyrAystmK=w@mail.gmail.com>
Subject: Re: [PATCH 05/19] test: print_do_hex_dump test depends on HEXDUMP
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Paul Burton <paulburton@kernel.org>, Alexander Graf <agraf@csgraf.de>,
 Bin Meng <bmeng.cn@gmail.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Heiko Schocher <hs@nabladev.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Richard Weinberger <richard@nod.at>, Guillaume La Roque <glaroque@baylibre.com>,
 u-boot@lists.denx.de
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

On Mon, 24 Nov 2025 at 00:58, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Skip the test if CONFIG_HEXDUMP=n
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  test/common/print.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/test/common/print.c b/test/common/print.c
> index a8feb07971d..23109188317 100644
> --- a/test/common/print.c
> +++ b/test/common/print.c
> @@ -271,6 +271,9 @@ static int print_do_hex_dump(struct unit_test_state *uts)
>         int i;
>         ulong addr;
>
> +       if (!CONFIG_IS_ENABLED(HEXDUMP))
> +               return -EAGAIN;
> +
>         buf = calloc(1, BUF_SIZE);
>         ut_assertnonnull(buf);
>         addr = map_to_sysmem(buf);
> --
> 2.51.0
>
