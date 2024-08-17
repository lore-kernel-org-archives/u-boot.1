Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A352AC52D7D
	for <u-boot@archiver.kernel.org>; Sat, 17 Aug 2024 16:00:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D531488B39;
	Sat, 17 Aug 2024 17:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KnDn91tj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6899B886F9; Sat, 17 Aug 2024 17:58:39 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 426CB8882C
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 17:58:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7a1df0a93eeso186713285a.1
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 08:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723910316; x=1724515116; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uxD+0bVXain0hvhbFLC8S5woSYPruJ20cDB8DJFwP70=;
 b=KnDn91tjc05dQoKjF5O+Hxu3vmJbc32FctTFJV7kDoncGr6nyq31aHui3bOVXmkxe9
 zOkbAEZOWYWgIyxHvKIm1R3ukU0Htbo8hql5eda4Z/zRYD49BPU0OeW4a3PglhVvzmky
 XQtfwjDLJpGWOadOVRrxaVG0xQnwuZLdFVizE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723910316; x=1724515116;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uxD+0bVXain0hvhbFLC8S5woSYPruJ20cDB8DJFwP70=;
 b=UwSZBXH2+UPyGF9Y85LfqzY6DN2VfqIBZbXf3KfYHYlQzyXo0O0jGgt4RYY6Xrf6VV
 9BUCbwfrRK6P8C8cg1cX5klyjWwGW673u6klHhzict17M0l11t3hJMFbJihDTeg9iU+T
 4w1qM1UPTH2XOelM4qg0XWLqq32I50rMWWEVhiWMJmPWftg2FWSdU38DTI8X7khoduSd
 vdU5vB+N53nyHdVkHzi4wlqMP95Zqs29xDEP9BgJVND0pEtC1JAH5LF3KhVJ1JPlHNMg
 NSh9kDapKhVJPqZgKGj6FynG6yFR0OhiyExYyQqgDn+RMAMcZ3OOcji5FMeRp9KRfr1v
 ZxeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUi/wKeF1kzEghqByzNvhjLLiOWvI9QqiT8Ew2I1jht5fKcWM+eCPjKlnz70ALC/3sKdHhe2TQBf9gC8dgdamroF+JV7A==
X-Gm-Message-State: AOJu0YxC5d4F50d3Jgo9Zdd+dww8eAx1e9B09W1Dw1+IVH2JPg+uGJWZ
 CgO82JlTofjnMd3RfGtR72RNAOvOksE7Kmws1SwD4Lps2ncm8srUvLKSJSl5xaPlc7dXiZt46pW
 QeFyJlwPlOqHeQtmspj39LIySwDOOndI5Be1B
X-Google-Smtp-Source: AGHT+IG9kZkEF5laeLxrew46xnxuvfZMrkNR0EdEikZOPjXCUh7/FyEb2+Hd2ozpYe0yBWx4yAMcd56ed2mx+e8BOQk=
X-Received: by 2002:a05:6214:540f:b0:6b5:786e:fd43 with SMTP id
 6a1803df08f44-6bf7cd798b5mr91921736d6.7.1723910316181; Sat, 17 Aug 2024
 08:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240814103145.1347645-1-mikhail.kshevetskiy@iopsys.eu>
 <20240814103145.1347645-8-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240814103145.1347645-8-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 17 Aug 2024 09:58:24 -0600
Message-ID: <CAFLszThroMFX-+G5r0uhkVsWwO9GWtK4qVZPTzx-2fiu+YLd2g@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 7/9] net/tcp: simplify tcp header filling code
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
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  net/tcp.c | 70 +++++++++++++++++++++++++++++--------------------------
>  1 file changed, 37 insertions(+), 33 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

nits below

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

try to avoid comparing with NULL or 0

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

Regards,
Simon
