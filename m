Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19489C3065A
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 15:56:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86F72884D2;
	Mon,  1 Jul 2024 17:56:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b1pnDOwJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C2C0886B3; Mon,  1 Jul 2024 17:56:33 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65A71884CC
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 17:56:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57d1782679fso690590a12.0
 for <u-boot@lists.denx.de>; Mon, 01 Jul 2024 08:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719849391; x=1720454191; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LALBZnaJHYL30sLeOYKnO2OSdBPN37OMWIjdg0ZnOTs=;
 b=b1pnDOwJri4NYQFlMzNRCkXwqOxW5IQ17FgxQFuckJJpTYv4JWjpnMoRXiJ2XZc/jb
 yDxEmeTZ67Z7nyvIlYvzDrJTHJ5ooiA1zaitrkoGWM4JQOgEdKUr+Sam1lQ8OgYNf6Hc
 Tt8N50psNaFbfe3qScc6l6CEtvAqVIhBSMqcaRP3CSO5WKWMtkP7V32NoRldVhUBEXci
 4Ku2wqz6O0cte6O1eQMq6r9yA9R8fbxuQXBG+PwncfglYtYNfSh8USdgjSKWrtEq0tGf
 NVibzjif1iqQdMwNtY42NVwUy+bvEP585q3/kvltDwrSbALD1shkzGTe2hw+cw3zCvHU
 w2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719849391; x=1720454191;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LALBZnaJHYL30sLeOYKnO2OSdBPN37OMWIjdg0ZnOTs=;
 b=SbiC9EmoKDwK0e/rtEWnd+wdc71D1L4JViFxtZGkgBub9dKCQoyqWe5Jcso4gcgRcb
 Z4eW0G6Ejp5jiZj5LyEhlhzy0N+HLl4cNcEB5eoU0mSVNa6J8kEXRxZfPdohzruVbocd
 VywLa525qbxTHHgRaRgB6g2gHS+NWm3ELyL+KDlOoq9ARbsB7WczMuanBG97k2D8CC8f
 tfs6u7409k68R3wfeNV5VayGSK1kgTzaFFU2bCznnf4hi+Lld7qcmvK4HR5hEmWeXWpA
 LaSrbJcCA4cuK/PlKh6Glp3gtgoGaWesHgpdsn1j0hRmMyo0ntAvuBW+DzwO3nTLgK50
 6suw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8cN8rB2AnzIuWhhMSBGzUXpwLM5J79va9bk+PanvpFXK4YpzEY9AAjjctTXUCcNwKUsgPD7byGZ7OPnaaCbeaeijqSA==
X-Gm-Message-State: AOJu0YxkYwQq5/3oXUUMd290hRTO76wDOiQxtKg+5ARlZywzBCoQSt3L
 2CtnlS5Qml+W26oh4TjvSTXXmvWbfqdWw8Hz9sfLVtqDWaFBd/LvTV92iIAuOqK9QjxHrAt22dW
 ZLz1t68RXX/VsngMWj3KG75GY5d4=
X-Google-Smtp-Source: AGHT+IH0cQFnwJZtWmdQ7Yp2XTHXV1A4E/Pw+Rejxn97y4N8hsN1F20SEJnR8Bj6rBfCbCytRecCVgoIsCgcdRJe57Y=
X-Received: by 2002:a05:6402:51d3:b0:57c:947c:f9cf with SMTP id
 4fb4d7f45d1cf-5879eed9408mr3998455a12.11.1719849390442; Mon, 01 Jul 2024
 08:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240627111551.99128-1-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240627111551.99128-1-mikhail.kshevetskiy@iopsys.eu>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 1 Jul 2024 16:56:19 +0100
Message-ID: <CALeDE9O6JxYNN89uT=p509Pvch5DLNwJ4fE-6=-MvJLrFnagZw@mail.gmail.com>
Subject: Re: [PATCH] net/tftp: make tftpput working with servers that do not
 use OACK
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
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

Please don't put the only detail in the subject, please outline the
fix here too, that should allow a more concise subject.

> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  net/tftp.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/net/tftp.c b/net/tftp.c
> index 2e335413492..2534dec1c9f 100644
> --- a/net/tftp.c
> +++ b/net/tftp.c
> @@ -494,8 +494,15 @@ static void tftp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
>                                 tftp_prev_block = tftp_cur_block;
>                                 tftp_cur_block = (unsigned short)(block + 1);
>                                 update_block_number();
> -                               if (ack_ok)
> +                               if (ack_ok) {
> +                                       if (block == 0 &&
> +                                           tftp_state == STATE_SEND_WRQ){
> +                                               /* connection's first ACK */
> +                                               tftp_state = STATE_DATA;
> +                                               tftp_remote_port = src;
> +                                       }
>                                         tftp_send(); /* Send next data block */
> +                               }
>                         }
>                 }
>  #endif
> --
> 2.43.0
>
