Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD4CEE57FB
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:01:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 850A288DB4;
	Thu, 12 Sep 2024 03:00:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="El4qdLYE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1407E88CFA; Thu, 12 Sep 2024 03:00:16 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A78A288CFA
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 03:00:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7db0fb03df5so338634a12.3
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 18:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102812; x=1726707612; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rE+mI48m6hqbjrq00DL6KkXoNCxOcDIIVmv8Mw4eOoI=;
 b=El4qdLYEa40gSt0ZZuegz2Fd75Bk5b8AUa/91FhGGuFmPFj5d0cCrZctEO08S5J4aK
 TbYNN7OQRMKTuaHR/jxYA0oqXIk1G455l3Xj2KQp2nfSf5wQGovkcUYvWVp/SEkjhWSu
 vyHD3RRBEhowsyMLo1ZPAgCxStKCfeaYA11k4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102812; x=1726707612;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rE+mI48m6hqbjrq00DL6KkXoNCxOcDIIVmv8Mw4eOoI=;
 b=f/bcLEntRs/Q0Eob06FHRHjRPtTM6oT3aqtc9M4aY/pgc297fp+A225YT198h7gVXP
 P1XrA1uUkuxLysqa2ZkeaJBObHKF36f2hNoRpN4zeXbxkY6B3U5UTA/3Mxt0t8MuVaVM
 n//F8+5p4YNUwnv0p3/NRT682IBKd2mf+SmzYM5AotZ/E36dstFwNaZJhkgVJhvCPidL
 2x6sZTWZq7IeejcEdL2S1pNQfkBolbdrT2Im36WmLCPpjp4R/zj8AR7qL3aW7CheBYFd
 vZk3TyX2YmXaef4gLZ5FTySCKyqTcaUrDJM5O4Wzt0hys37Zg2iowsIm8CFERQu5g5eE
 GGIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW39AjYKLg12TXoG+PyW33MPMRg6VRajFiR+Jf7IgKlKuMAVyuHD9RjzXYTjA3O3dlt5aoGTOk=@lists.denx.de
X-Gm-Message-State: AOJu0YwqRCgq8om1WrqlTVa6hnra+Pz0V4sTAfHW3ZRyCemAO+9ByRvE
 XkD4A8DxUDJ6vLMUMbJHuqQhPOgYQdHSx4euEVh4DycOu38+vrJiTmKs6QVE6unVVwOmLU7fSVl
 Gr+tARERXx3qzabXLdRTIsmkH8xkM1H4DrqKH
X-Google-Smtp-Source: AGHT+IHMno9Tlk9bsE3a78p6lmBa8hoCPWfUuQ19GrymNTTmaaNhijgjf/x8IEX1clCFRqKew3vQA47UcBhe+cbZa0Q=
X-Received: by 2002:a05:6a21:4a41:b0:1cc:eb34:b1c0 with SMTP id
 adf61e73a8af0-1cf75f5abd2mr1730553637.25.1726102811035; Wed, 11 Sep 2024
 18:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240909222720.2563118-1-mikhail.kshevetskiy@iopsys.eu>
 <20240909222720.2563118-9-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240909222720.2563118-9-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 18:59:54 -0600
Message-ID: <CAFLszTgLxYbpasWAjTit0yu+fAiQWLKP4rmD_xdP5HhdP9PXZg@mail.gmail.com>
Subject: Re: [PATCH v6 08/12] net/tcp: simplify tcp header filling code
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

Hi Mikhail,

On Mon, 9 Sept 2024 at 16:27, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> This patch:
>  * remove useless code,
>  * use a special function for pretty printing of tcp flags,
>  * simplify the code
>
> The behavior should not be changed.
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  net/tcp.c | 74 ++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 41 insertions(+), 33 deletions(-)
>
> diff --git a/net/tcp.c b/net/tcp.c
> index 37dda6f84f9..0778c153aca 100644
> --- a/net/tcp.c
> +++ b/net/tcp.c
> @@ -535,10 +535,41 @@ void net_set_syn_options(struct tcp_stream *tcp, union tcp_build_pkt *b)
>         b->ip.end = TCP_O_END;
>  }
>
> +const char *tcpflags_to_str(char tcpflags, char *buf, int size)
> +{
> +       int i, len;
> +       char *orig = buf;
> +       const struct {

static

> +               int             bit;
> +               const char      *name;
> +       } desc[] = {{TCP_RST, "RST"}, {TCP_SYN, "SYN"}, {TCP_PUSH, "PSH"},
> +                   {TCP_FIN, "FIN"}, {TCP_ACK, "ACK"}, {0, NULL}};
> +
> +       *orig = '\0';
> +       for (i = 0; desc[i].name; i++) {

You could use ARRAY_SIZE() here and avoid the terminator, if you like

> +               if (!(tcpflags & desc[i].bit))
> +                       continue;
> +
> +               len = strlen(desc[i].name);
> +               if (size <= len + 1)
> +                       break;
> +               if (buf != orig) {
> +                       *buf++ = ',';
> +                       size--;
> +               }
> +
> +               strcpy(buf, desc[i].name);

Or be lazy and just use strlcat() for both the command the name...up to you

> +               buf += len;
> +               size -= len;
> +       }

blank line before final return

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
> @@ -548,55 +579,32 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
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
> 2.45.2
>

Regards,
Simon
