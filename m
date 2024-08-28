Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9204C54E90
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 10:05:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E87CB8873C;
	Wed, 28 Aug 2024 12:05:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J6252PU0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E34E886AF; Wed, 28 Aug 2024 12:05:10 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B0958873C
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 12:05:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5bf0261f162so7688956a12.0
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 03:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724839508; x=1725444308; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=svr6C3VUPOR+ZrEz8NpxMz2IEdRaU2tv8HNouB0sKoc=;
 b=J6252PU0I7cNvoQ1jXJ7Qw4NuZYRYllP1uTQKXlBZwRBKT1aNhJltK4HjnJHYJskiR
 pB8Cg9aDVXxH/abtLYVBlU7ths1A4KI4AA9c1u5C7WjghRlqwEyfAmN1yNB4hfKaJG6b
 +ZS7486iJuzY29enF/o4U4sBf5/SjGD5ZKuiWz2hBfhe+x6yNg2A5S3Z6fMkFe4wEcHk
 tLS6GkJz5MfStSbVDPSDJ0QIY2iaUpXhIIT/GKD76pEo7tZkfIhoo8qFdUFKYotgW6kF
 7gQOj2+LEvlHMGiitXzGBzUu/GAn9XYHBzXJ0jU+fwGIoKude9qUORsmSkY3S0+l7pnl
 vYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724839508; x=1725444308;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=svr6C3VUPOR+ZrEz8NpxMz2IEdRaU2tv8HNouB0sKoc=;
 b=GzFRkvh+Zor9Y1SiiYTjJSNju+dud18npGG+6j+vkTpf86rUvLcG2zBA8st0iHo+7/
 ijVVlUCABTpMtpjXe/VbsRNsS5PsWib1178epA1lndb0StnxjLZuFr6WC0+1Dla7jtQp
 AMXhT8buAEXLggPmCFGmf7EFjcZTfw1GmyxHygNHqG/mPSlAwDEM4mqNN2Wv2r6L7Xzy
 RSO1SGHDBnpyw2Wka/YIpqk6bU+AZqB1s87nMo56qcHqH1sKHpdfUYhuKMxxQXixf0+r
 XVQUm4VXqB935DhRg7VIzD/tB60w4t8V/avpyvh24qfdhDqa6H4q4buPyJkocMETIYv7
 6IsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbD7ufJKdeGsYiPRhsarC+2xerrAyS9u+cm5dVS62tAUJq+aJSHS2Ys/LgWDDJr1auapM/yS8=@lists.denx.de
X-Gm-Message-State: AOJu0YzVWC3yDUGSkg+ExGv/zFvTliomgwBWFik+SCZ/NXNfUeV/VwIx
 FMse7vVrZ8T5v7e3ratSiaQy/smGu+woPyNXzFcBWCex8oxS8X3xMex2U0BGvLIc+4ltNU1PwFk
 1yMAJ2qjsGiNBWdSAiK4mStViN84=
X-Google-Smtp-Source: AGHT+IGWkVMV/fRykD2fhs5J3Hkukp4IMIForHAkjd4ACJCw+ujtATAp2InpdnYfJ1XF6J8DOgDdk1UnFX+y/SpiX7M=
X-Received: by 2002:a05:6402:430a:b0:5bf:a2c:4f35 with SMTP id
 4fb4d7f45d1cf-5c0891663fbmr12287938a12.10.1724839506848; Wed, 28 Aug 2024
 03:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240814103145.1347645-1-mikhail.kshevetskiy@iopsys.eu>
 <20240814103145.1347645-8-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240814103145.1347645-8-mikhail.kshevetskiy@iopsys.eu>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 28 Aug 2024 11:04:55 +0100
Message-ID: <CALeDE9PiqED4JqDCaBLfaVgntwR+_EXi8ay45SyYHXOq7UBo2A@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 7/9] net/tcp: simplify tcp header filling code
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>, 
 Marek Vasut <marex@denx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
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

This needs an actual description, please add details what and why for
this 70 line patch.

> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  net/tcp.c | 70 +++++++++++++++++++++++++++++--------------------------
>  1 file changed, 37 insertions(+), 33 deletions(-)
>
> diff --git a/net/tcp.c b/net/tcp.c
> index 2c34556c26d..7014d5b4f43 100644
> --- a/net/tcp.c
> +++ b/net/tcp.c
> @@ -527,10 +527,37 @@ void net_set_syn_options(struct tcp_stream *tcp, union tcp_build_pkt *b)
>         b->ip.end = TCP_O_END;
>  }
>
> +const char *tcpflags_to_str(char tcpflags, char *buf, int size)
> +{
> +       int i = 0, len;
> +       char *orig = buf;
> +       const struct {
> +               int             bit;
> +               const char      *name;
> +       } desc[] = {{TCP_RST, "RST"}, {TCP_SYN, "SYN"}, {TCP_PUSH, "PSH"},
> +                   {TCP_FIN, "FIN"}, {TCP_ACK, "ACK"}, {0, NULL}};
> +
> +       *orig = '\0';
> +       while (desc[i].name != NULL) {
> +               len = strlen(desc[i].name);
> +               if (size <= len + 1)
> +                       break;
> +               if (buf != orig) {
> +                       *buf++ = ',';
> +                       size--;
> +               }
> +               strcpy(buf, desc[i].name);
> +               buf += len;
> +               size -= len;
> +       }
> +       return orig;
> +}
> +
>  int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
>                        u8 action, u32 tcp_seq_num, u32 tcp_ack_num)
>  {
>         union tcp_build_pkt *b = (union tcp_build_pkt *)pkt;
> +       char buf[24];
>         int pkt_hdr_len;
>         int pkt_len;
>         int tcp_len;
> @@ -540,55 +567,32 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
>          *         4 bits reserved options
>          */
>         b->ip.hdr.tcp_flags = action;
> -       pkt_hdr_len = IP_TCP_HDR_SIZE;
>         b->ip.hdr.tcp_hlen = SHIFT_TO_TCPHDRLEN_FIELD(LEN_B_TO_DW(TCP_HDR_SIZE));
>
>         switch (action) {
>         case TCP_SYN:
>                 debug_cond(DEBUG_DEV_PKT,
> -                          "TCP Hdr:SYN (%pI4, %pI4, sq=%u, ak=%u)\n",
> -                          &tcp->rhost, &net_ip,
> -                          tcp_seq_num, tcp_ack_num);
> +                          "TCP Hdr:%s (%pI4, %pI4, s=%u, a=%u)\n",
> +                          tcpflags_to_str(action, buf, sizeof(buf)),
> +                          &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
>                 net_set_syn_options(tcp, b);
>                 pkt_hdr_len = IP_TCP_O_SIZE;
>                 break;
> -       case TCP_SYN | TCP_ACK:
> -       case TCP_ACK:
> -               pkt_hdr_len = IP_HDR_SIZE + net_set_ack_options(tcp, b);
> -               b->ip.hdr.tcp_flags = action;
> -               debug_cond(DEBUG_DEV_PKT,
> -                          "TCP Hdr:ACK (%pI4, %pI4, s=%u, a=%u, A=%x)\n",
> -                          &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num,
> -                          action);
> -               break;
> -       case TCP_FIN:
> -               debug_cond(DEBUG_DEV_PKT,
> -                          "TCP Hdr:FIN  (%pI4, %pI4, s=%u, a=%u)\n",
> -                          &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
> -               payload_len = 0;
> -               pkt_hdr_len = IP_TCP_HDR_SIZE;
> -               break;
>         case TCP_RST | TCP_ACK:
>         case TCP_RST:
>                 debug_cond(DEBUG_DEV_PKT,
> -                          "TCP Hdr:RST  (%pI4, %pI4, s=%u, a=%u)\n",
> +                          "TCP Hdr:%s (%pI4, %pI4, s=%u, a=%u)\n",
> +                          tcpflags_to_str(action, buf, sizeof(buf)),
>                            &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
> +               pkt_hdr_len = IP_TCP_HDR_SIZE;
>                 break;
> -       /* Notify connection closing */
> -       case (TCP_FIN | TCP_ACK):
> -       case (TCP_FIN | TCP_ACK | TCP_PUSH):
> -               debug_cond(DEBUG_DEV_PKT,
> -                          "TCP Hdr:FIN ACK PSH(%pI4, %pI4, s=%u, a=%u, A=%x)\n",
> -                          &tcp->rhost, &net_ip,
> -                          tcp_seq_num, tcp_ack_num, action);
> -               fallthrough;
>         default:
>                 pkt_hdr_len = IP_HDR_SIZE + net_set_ack_options(tcp, b);
> -               b->ip.hdr.tcp_flags = action | TCP_PUSH | TCP_ACK;
>                 debug_cond(DEBUG_DEV_PKT,
> -                          "TCP Hdr:dft  (%pI4, %pI4, s=%u, a=%u, A=%x)\n",
> -                          &tcp->rhost, &net_ip,
> -                          tcp_seq_num, tcp_ack_num, action);
> +                          "TCP Hdr:%s (%pI4, %pI4, s=%u, a=%u)\n",
> +                          tcpflags_to_str(action, buf, sizeof(buf)),
> +                          &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
> +               break;
>         }
>
>         pkt_len = pkt_hdr_len + payload_len;
> --
> 2.39.2
>
