Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D28EE7716E
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 15:13:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 020B3896FF;
	Wed,  4 Dec 2024 16:13:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GwHGTik/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5315896EA; Wed,  4 Dec 2024 16:13:40 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C59E189346
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 16:13:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ee786b3277so3672185a91.1
 for <u-boot@lists.denx.de>; Wed, 04 Dec 2024 07:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733325216; x=1733930016; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IcbXiMIwSPc9Gd3gRie3SAJ/yEMaZ44bP7TEQnPgEBA=;
 b=GwHGTik/xSAYZz1l6SinjfPpoeVg7U1ee80cmw9cNLXw+SHD72NjyxWuMdCoGz689b
 PXnF+1AKcznL3XjrjRysyVxbQgzFUFkcaTw7qHNc6P3onuzBAGCBTNoWTkD5esq0aj+Q
 6ikYC/KkLeyGQ2ZvqRDFB44Wtjs8//J2kLG78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733325216; x=1733930016;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IcbXiMIwSPc9Gd3gRie3SAJ/yEMaZ44bP7TEQnPgEBA=;
 b=wJbNdgDMjdRCat2z7YvpsuCycGZRCIFA1D3ZnxazwjaJh9wVEyvSYvntevfLdUS8E8
 BgDjdUxYv9aQe/aStpT+tyoi52UMjgI2Aw+mG1L1q6hQbmHmD8QQX4ckTnFfDKQEZRNw
 IptPFDVGamFo2qywi7cN4Wfyoh6FXD+oLIJMaw7VnWi4hteEg+r8aBtdk/h8SDXm7D0p
 oqfrjTximi7SsM1y4ooHJlnAVfKQ1Z/dNebZaXhsXk3CKgiKjif4ECwpLrGa8A+qY8Uv
 Wh4LRWj4guCbIB+wHqimYsjv/UzUlLkNYZg1nYIWdaWCl8BHpxL2Y8YNEDfu6j9UTweL
 21ZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwEKefmSO/e/XFe8sxXRs2giw6tyTC4H59gyTJSlC7cohrWID7aaHnDEVJA/kzWborn1DywSY=@lists.denx.de
X-Gm-Message-State: AOJu0YzA15e0wWxyd0/QrsDYjXN1lsag5+YwwnsLMIY3Dm1R10ex055v
 dvGED3Z7VEW/7JkHdl60vbwPLOF4ZG0aiMNojB+wZWHNKZn6edq6iepnnH4Kn57+3CpODQzwI2m
 5paBglJ3sZqziGYX/GXO9XTuI9nx6lGlLsv/FKdmDMuwjBOg=
X-Gm-Gg: ASbGncs9As9OcmPzk5YVz2z+EfD2QY9/QAIqufv5k2G9XYt2J8WuVR2t9wzgfyawFzR
 7IDWjfnPcVKEYlop9u5RQYw5S+h80fm9E
X-Google-Smtp-Source: AGHT+IHCq3eFxJ2UPvGLXwHMS/tuQ1QLUAaNTwUajstCzVAs0wn59mZDEMa6CyinjKyCJLvaU4hejtVqzliyEADZnbU=
X-Received: by 2002:a17:90b:4d12:b0:2ef:2d9f:8e55 with SMTP id
 98e67ed59e1d1-2ef2d9f9ecdmr2773139a91.17.1733325216227; Wed, 04 Dec 2024
 07:13:36 -0800 (PST)
MIME-Version: 1.0
References: <20241203232732.2680178-1-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20241203232732.2680178-1-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 4 Dec 2024 08:13:07 -0700
Message-ID: <CAFLszTj8SfbNs3Qn+cdC98JjoDE0St8HuRaXLF8+MxFCC07TXA@mail.gmail.com>
Subject: Re: [PATCH] net: tftpboot: clear timeout_count on every successful
 block
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
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

On Tue, 3 Dec 2024 at 16:27, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> timeout_count is never reset once a tftpboot transfer has started. If for
> whatever reason timeouts occur frequently, but the server keeps replying
> nonetheless, the transfer may be needlessly aborted.
>
> Reset timer_count on every successful block to avoid this situation.
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  net/tftp.c | 2 ++
>  1 file changed, 2 insertions(+)
>

What is the impact of this change?

> diff --git a/net/tftp.c b/net/tftp.c
> index 704b20b4ff8..8f948204a6f 100644
> --- a/net/tftp.c
> +++ b/net/tftp.c
> @@ -498,6 +498,7 @@ static void tftp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
>                                                 tftp_state = STATE_DATA;
>                                                 tftp_remote_port = src;
>                                         }
> +                                       timeout_count = 0;
>                                         tftp_send(); /* Send next data block */
>                                 }
>                         }
> @@ -657,6 +658,7 @@ static void tftp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
>                         net_set_state(NETLOOP_FAIL);
>                         break;
>                 }
> +               timeout_count = 0;
>
>                 if (len < tftp_block_size) {
>                         tftp_send();
> --
> 2.45.2
>

Regards,
Simon
