Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D63C52D7F
	for <u-boot@archiver.kernel.org>; Sat, 17 Aug 2024 16:00:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72BFB88916;
	Sat, 17 Aug 2024 17:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ImvROD0S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42023887BB; Sat, 17 Aug 2024 17:58:37 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 285BF8882C
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 17:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7093472356dso1592608a34.0
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 08:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723910314; x=1724515114; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PFMxV91ykgs4P0iudgdbjOji0fXPMMYSba0lkc5OeAA=;
 b=ImvROD0SJR5yQc95d6uP3b9MqNsOgF7/kuydbh8+8nmrMposZp9TP6Ilw1ySXp/SEx
 UMrq0+UlYNCMXftngA2xXsseC3ijGr+3qsSfRh9RIA6Xd3NhGf0W849aQC873YrvBjvX
 zaAcGXheYH8BFQxdUuIB0x3O7oODP8neGIC24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723910314; x=1724515114;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PFMxV91ykgs4P0iudgdbjOji0fXPMMYSba0lkc5OeAA=;
 b=TyniC4tID7hj/mLIEp+LwV/ZlZypHSlsef/5dMTtUj/t/vqLTJj4W5lcySv35zSrGm
 M0PSPNk1Nd2PXSI/8NW/8Z5Op4y9OiAUpqf39VilJwt6YveJPef+AWkub3fs9lxTRx+D
 lQEQtkE9kACPBNudCYZ26jpy9P6qhnAg6k3zWt0rj8Iq5vXuK+vVKpPnOgUxdqeB68Ol
 kz4uEjNg6chgPHd4dR8IdcnmucVBib5f0aWVtuhp8hUgb6COOPYo6IwWpCPd1BzDW7VZ
 qJ5KcFRiovGqVlCddbQk31OQuZw4lL5saESurhUBSXoqjKqyNXTtVNsLrx9tgCObfxvS
 quzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhmb1LYL/KW+2QI8sr0KIzyunknUh3wjQjcADVNHAnTehZrI1B1II8lBwF6J95ncpyHIpwZIym2fvZfBoW/onzoi9opQ==
X-Gm-Message-State: AOJu0YwTD9qZf+Azl7ADClKPzLOV1WwzBl7o2JAP6Io+U23k+XfHM61P
 XeC6ZuVYEC7GSja5rPdao5JLRVDvbBjvW98Aa99df9XNiBsqsPRdgC8Esls/OcGoItfLCr30b7a
 RauIcv0fwBdPxd5r/k1oDhtoxcnILguwsA/ID
X-Google-Smtp-Source: AGHT+IFvg7v5ovBn2PAy35cwmoo8Q4PH7hcy/s5hVjr2l+ttM221vJX1fy+g+cT4XKD84kQKKN2ajGSh/VJ0J20u0GA=
X-Received: by 2002:a05:6830:6a87:b0:709:4266:988f with SMTP id
 46e09a7af769-70cac897f9dmr8030351a34.25.1723910313918; Sat, 17 Aug 2024
 08:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240814103145.1347645-1-mikhail.kshevetskiy@iopsys.eu>
 <20240814103145.1347645-7-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240814103145.1347645-7-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 17 Aug 2024 09:58:23 -0600
Message-ID: <CAFLszTiVnw4P=-OaoStaLHHwKrkZhfJ4rEn-r9S2JtWuytVS9g@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 6/9] net/tcp: improve tcp framework, use better
 state machine
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
 Siddharth Vadapalli <s-vadapalli@ti.com>,
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

On Wed, 14 Aug 2024 at 04:32, Mikhail Kshevetskiy
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
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  include/net/tcp.h  | 171 +++++++--
>  include/net/wget.h |   8 -
>  net/fastboot_tcp.c | 190 +++++-----
>  net/net.c          |   4 +
>  net/tcp.c          | 837 ++++++++++++++++++++++++++++++++++-----------
>  net/wget.c         | 460 +++++++------------------
>  6 files changed, 992 insertions(+), 678 deletions(-)

Is it possible to split this patch up a bit?

Regards,
Simon
