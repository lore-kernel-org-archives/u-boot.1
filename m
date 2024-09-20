Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDBCCF9C59
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 16:04:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45C2188C41;
	Fri, 20 Sep 2024 18:04:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XUO+xxQc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5381888641; Fri, 20 Sep 2024 18:04:04 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22E34889BD
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 18:04:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7198de684a7so1681471b3a.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726848241; x=1727453041; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S359CLMDesKs+m/DolBtc++Z9B1QnSAdtQsSADCFjZk=;
 b=XUO+xxQcwM37mHeyyvV+Sql6YqQzk8HPjKp7uOhL0FonmJVImN9bfGB4qSeCVfo1x/
 dwsjIr9B35pipsGZ5igsuS7U2gX2gRclI5mZd2o0ZNK2A8debpKPjNIyPDtElLvyPR4i
 MvZIGW77g6apFM0LRZ1AOmi08XFUuviBTilis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726848241; x=1727453041;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S359CLMDesKs+m/DolBtc++Z9B1QnSAdtQsSADCFjZk=;
 b=Y28T9TwnmjrUGbwxfeLyIlVDXqZmEqHWiBOPhuIrkBJL6pWWqBkbUKb57Zw0SIizGC
 MPhS5h2IWT8TOYasQlZPW/x5PDyy4BEc9rREPXfKMn8Q2ZBoVj90dobJtrKi74FD4/Sc
 RWmYCd7CzD2LnEnzGdWZPZOb4RlMOLNe9IpINQEvw/8ixC1QiJG77xmPs9SFhxNJCFQM
 1jx+JzlgVX78ioC4I3a8zagkjv1ss2XFGbpIUr6179+20GnuzlJl9HimKXVuzf6hMPk6
 POKCgjEQp+LtDKp+GcgM52uCCoYC6NhHBDpEvi3unUCZo0Trk+PHho2jbyUaaesEpNcw
 iJYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNexmkLz4AZ7HN2pmHT059M5Uv+qIAk7bGdKh1WCla+5if+hVpWp+8q4uKcSHtcLC0KWMQFUw=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0V+hcXduEpNLJEloQBKheblcis8x5PaWzbPp38cnV06bELxk7
 UPjvcILga+LGhBZ9aH5PjUrROQVhnj6fC0V7wpMcpQOH+pZLMlKBG/ZRCCDhaCrZFm2mISRFIh1
 3YdXBgOTXIrkyEyZhCxpUBhGxrIcufi3NooPA
X-Google-Smtp-Source: AGHT+IFr5bQT0AHrpZOSrKQwf/tXn9saimnrUGdmAMaGaUfcmoHt1MwyYxwDeW8Sk+G1lBz7NMt0wU6n8xJFWJYuoFQ=
X-Received: by 2002:a05:6a00:2e07:b0:70d:2a4d:2eeb with SMTP id
 d2e1a72fcca58-7199cd792e4mr3858352b3a.3.1726848240620; Fri, 20 Sep 2024
 09:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240824092716.1042696-1-mikhail.kshevetskiy@iopsys.eu>
 <20240824092716.1042696-7-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240824092716.1042696-7-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 18:03:47 +0200
Message-ID: <CAFLszTjwLE0xZqhmgrOkgf7KXu5UkktP6T1WoYVniNTvqDZufw@mail.gmail.com>
Subject: Re: [PATCH v5 06/11] net/tcp: improve tcp framework,
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

Hi Mikhail,

On Sat, 24 Aug 2024 at 11:27, Mikhail Kshevetskiy
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
>

Reviewed-by: Simon Glass <sjg@chromium.org>

I see quite a lot of extra brackets and comparisons against NULL / 0 / '\0', BTW

Regards,
Simon
