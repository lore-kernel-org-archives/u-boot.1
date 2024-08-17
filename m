Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55C2C52D7F
	for <u-boot@archiver.kernel.org>; Sat, 17 Aug 2024 15:59:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23CA9888AA;
	Sat, 17 Aug 2024 17:58:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y+jKRz+2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59DDA8882C; Sat, 17 Aug 2024 17:58:32 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4CB588753
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 17:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7a1d436c95fso181378885a.3
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 08:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723910308; x=1724515108; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Aig4ZLUHmGwp3d9Z87YB0eH/ASo2ua1bCWA33x7xV9k=;
 b=Y+jKRz+2ZmsEUB25a4zV130fDoN+hz1v1aShzcy8EQHZ/nxpOorqtIn0vlHM9DYkIC
 VFkRqOvCNbxO8Pkn7hLZVK3rxB9bUDVZPwP99CYBKaB646wfwOpbK21jEfBOwfHUUCQj
 PF5YZJqLg5Nu9jIrSxrTzmewmfpo0ZBHb4zsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723910308; x=1724515108;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Aig4ZLUHmGwp3d9Z87YB0eH/ASo2ua1bCWA33x7xV9k=;
 b=LadMViDHbb7JZJKy370yhMoBQnNhpbIhSsYFSnbNihgHvkRzd7Q/ZwocvdVM0Jwi/f
 8jQ/c+TQN9dJpmmi0adG9iYIWCH0mNiHl4xRQwGItEhzH4NGc4UtQJQpvZVVYyy8dWVu
 RQxN9t/CRGlmGcMHW4Q8S41/BiNfLMcLlB2/QYkQ5zGmnxbWXb9tcwzTRwTsaZNuy/cP
 /QmHxfjmGUCnkocbQrDbBDh//0WCmEoiDP88Sq1pA525Ukr8WPKher+T8pO/dSRKAL1t
 UpbJ8GUmGOJ3ebjPXEF0MuLw0Uyg0dnGBp/h+H/02vh0QQ+TDwdkf3HccAymLIvxFvJY
 AC5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsVCzaoHD9ZrvZgXKR0lj7KMguigTxwd+S/WxgqxbILS/LFq2tkUB1wXIb9Fgd0JQYZiUorjnqTCNvsfrkWw3zsHZTnA==
X-Gm-Message-State: AOJu0Yxt8lKVh30o6Wpv00pwTmSxLwHh/ZpE4XjcZARLusuFOPUCodM6
 f8MKdzZU/mX6LVPYhNOALY46r+BQDczYFpcnJT8TolE1b+MDl1JmglQo6zoYUVGP5ZTsxLKeaIW
 apl/j71ELX5BaixjAXD2gSIyfHiI2CClfF5L/
X-Google-Smtp-Source: AGHT+IGPX30zWYCJG/Lkri3KaUgwsdiRvMKgZgbVO4CiGSJO267wAOOIiHIUu34C6XMYEZYJdhwiMWhJrVNe2mJW02k=
X-Received: by 2002:a05:6214:3992:b0:6bf:8d05:472c with SMTP id
 6a1803df08f44-6bf8d05499dmr18119606d6.1.1723910308465; Sat, 17 Aug 2024
 08:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240814103145.1347645-1-mikhail.kshevetskiy@iopsys.eu>
 <20240814103145.1347645-2-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240814103145.1347645-2-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 17 Aug 2024 09:58:17 -0600
Message-ID: <CAFLszTjUaJ=cEXnLkau3P7puvcE2wvXWimLWyPMcDm9-sP-gTg@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 1/9] net/tcp: fix TCP options processing
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

On Wed, 14 Aug 2024 at 04:32, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> Current TCP code may miss an option if TCP_O_NOP option was used before
> it for proper aligning.
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  net/tcp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/net/tcp.c b/net/tcp.c
> index b0cc8a1fe3e..3e3118de450 100644
> --- a/net/tcp.c
> +++ b/net/tcp.c
> @@ -475,7 +475,7 @@ void tcp_parse_options(uchar *o, int o_len)
>          * NOPs are options with a zero length, and thus are special.
>          * All other options have length fields.
>          */
> -       for (p = o; p < (o + o_len); p = p + p[1]) {
> +       for (p = o; p < (o + o_len); ) {
>                 if (!p[1])
>                         return; /* Finished processing options */
>
> @@ -490,12 +490,14 @@ void tcp_parse_options(uchar *o, int o_len)
>                 case TCP_O_TS:
>                         tsopt = (struct tcp_t_opt *)p;
>                         rmt_timestamp = tsopt->t_snd;
> -                       return;
> +                       break;
>                 }
>
>                 /* Process optional NOPs */
>                 if (p[0] == TCP_O_NOP)
>                         p++;
> +               else
> +                       p += p[1];
>         }
>  }
>
> --
> 2.39.2
>
