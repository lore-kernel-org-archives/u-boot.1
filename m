Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76516C531DC
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 20:47:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02D8188B70;
	Fri, 23 Aug 2024 22:47:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TZ0gSw5Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4931B88B70; Fri, 23 Aug 2024 22:47:37 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2292D88A99
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 22:47:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6bf90d52e79so12465786d6.3
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 13:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724446054; x=1725050854; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VREU0LLJkL+z49ffRDumgd2piYFhLUOwUkuBDi+3Fn0=;
 b=TZ0gSw5ZnUOf+/ptRLFkIt2DnBp0e5aVbdx87R15y46DIGfxWSKluGTWN2FYi4iE2f
 LZ/lgCO1o9IC/YUx74Y0i+xy37UtXgm/3vqgH5ya7PMSDz/nlMqHTzATYFL8W//Bdenk
 da7oLSWuSizj2AalEqTYH8u6nPnuoqcOZv1CE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724446054; x=1725050854;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VREU0LLJkL+z49ffRDumgd2piYFhLUOwUkuBDi+3Fn0=;
 b=f+UV0M/qo5SHmjYFPlWfJ6T6nZUIa4eFH4VLNptaBEBtaI4lJIUEudFQCLP+Hr4D/m
 jdfTXLIHpzoKEM8B4LUEPG1e9ATpvcfLKtUAmE6XCeiVXFUWHgbAIn846LjJ+DcJv/IH
 +ZOzhwVS7drOVXz2F8VOLH7ZFKXlz2tbkdDVz/D6JD1AGFPbGWysaQZUMgRnFJR2BYZv
 fsxjsxfGi6Qo1G7LZ1yFFfRlY2zeOvRcYLntc3I//kDuh8wDxEU+yxCvFNHuALHZug71
 j8JoQatFVsfztvF9QZkLO2Gf4LWsgTwb+/vFa47zWJDE4KzcGScFi4rO3ZqFKQs1Id48
 z84A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0/3lFO77qDN2ywggGXoreImh/DsG5t4KKEIMsyA9M8Fx1+sE9cU+kIBW3sYUT1vKRn4IS6R0=@lists.denx.de
X-Gm-Message-State: AOJu0YwpGnbnmDpigQ2Hl6mNfQNm/c9ViXJw9EmX0QY3bR8y8jKiqiLH
 3KfOs2r19yKqB+RqiB+8iMFjNYU+QZ7RVIpSoukOkrFGmW+BwnQco09tvhi/Fq2I5xBKNOiEJdQ
 NwXZXwnT+nYOQS72nONsMzGPfj16PlCqufePM
X-Google-Smtp-Source: AGHT+IFMZpR4Q/dqXCPV3HVFG/Pg+ZBWMlpRiIPg5d6/Bs7V9rXzmQ/gEd1FNSJmdYwafgnU7t0Rn0U0SRy7rjYDkvA=
X-Received: by 2002:a05:6214:5544:b0:6b5:d0de:8ab5 with SMTP id
 6a1803df08f44-6c16dc8f203mr43097166d6.30.1724446054070; Fri, 23 Aug 2024
 13:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240814103145.1347645-1-mikhail.kshevetskiy@iopsys.eu>
 <20240814103145.1347645-8-mikhail.kshevetskiy@iopsys.eu>
 <CAFLszThroMFX-+G5r0uhkVsWwO9GWtK4qVZPTzx-2fiu+YLd2g@mail.gmail.com>
 <b7c9d535-9295-4a6b-9b8e-a62a123bc1fc@genexis.eu>
In-Reply-To: <b7c9d535-9295-4a6b-9b8e-a62a123bc1fc@genexis.eu>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Aug 2024 14:47:23 -0600
Message-ID: <CAFLszTgFXHoWjdeZ+Ze_vpvRpA4B1C=zpsKzJsMtuLkzH_HFmg@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 7/9] net/tcp: simplify tcp header filling code
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
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

Hi Mikhail,

On Fri, 23 Aug 2024 at 09:12, Mikhail Kshevetskiy
<mikhail.kshevetskiy@genexis.eu> wrote:
>
> By the way, I'd like to know your opinion:
>  * should I add a sample implementation of http/1.1 compatible
> web-server to this patch series?
>
> This can be used as a base for other implementations like firmware
> upgrade web-server used by some vendors.

Do you mean using the sandbox emulator? Yes I think that would be very helpful.

Regards,
Simon


>
> Mikhail Kshevetskiy
>
>
> On 17.08.2024 18:58, Simon Glass wrote:
> > Hi Mikhail,
> >
> > On Wed, 14 Aug 2024 at 04:32, Mikhail Kshevetskiy
> > <mikhail.kshevetskiy@iopsys.eu> wrote:
> >> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> >> ---
> >>  net/tcp.c | 70 +++++++++++++++++++++++++++++--------------------------
> >>  1 file changed, 37 insertions(+), 33 deletions(-)
> >>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > nits below
> >
> >> diff --git a/net/tcp.c b/net/tcp.c
> >> index 2c34556c26d..7014d5b4f43 100644
> >> --- a/net/tcp.c
> >> +++ b/net/tcp.c
> >> @@ -527,10 +527,37 @@ void net_set_syn_options(struct tcp_stream *tcp, union tcp_build_pkt *b)
> >>         b->ip.end = TCP_O_END;
> >>  }
> >>
> >> +const char *tcpflags_to_str(char tcpflags, char *buf, int size)
> >> +{
> >> +       int i = 0, len;
> >> +       char *orig = buf;
> >> +       const struct {
> >> +               int             bit;
> >> +               const char      *name;
> >> +       } desc[] = {{TCP_RST, "RST"}, {TCP_SYN, "SYN"}, {TCP_PUSH, "PSH"},
> >> +                   {TCP_FIN, "FIN"}, {TCP_ACK, "ACK"}, {0, NULL}};
> >> +
> >> +       *orig = '\0';
> >> +       while (desc[i].name != NULL) {
> > try to avoid comparing with NULL or 0
> >
> >> +               len = strlen(desc[i].name);
> >> +               if (size <= len + 1)
> >> +                       break;
> >> +               if (buf != orig) {
> >> +                       *buf++ = ',';
> >> +                       size--;
> >> +               }
> >> +               strcpy(buf, desc[i].name);
> >> +               buf += len;
> >> +               size -= len;
> >> +       }
> >> +       return orig;
> >> +}
> >> +
> >>  int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
> >>                        u8 action, u32 tcp_seq_num, u32 tcp_ack_num)
> >>  {
> >>         union tcp_build_pkt *b = (union tcp_build_pkt *)pkt;
> >> +       char buf[24];
> >>         int pkt_hdr_len;
> >>         int pkt_len;
> >>         int tcp_len;
> >> @@ -540,55 +567,32 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
> >>          *         4 bits reserved options
> >>          */
> >>         b->ip.hdr.tcp_flags = action;
> >> -       pkt_hdr_len = IP_TCP_HDR_SIZE;
> >>         b->ip.hdr.tcp_hlen = SHIFT_TO_TCPHDRLEN_FIELD(LEN_B_TO_DW(TCP_HDR_SIZE));
> >>
> >>         switch (action) {
> >>         case TCP_SYN:
> >>                 debug_cond(DEBUG_DEV_PKT,
> >> -                          "TCP Hdr:SYN (%pI4, %pI4, sq=%u, ak=%u)\n",
> >> -                          &tcp->rhost, &net_ip,
> >> -                          tcp_seq_num, tcp_ack_num);
> >> +                          "TCP Hdr:%s (%pI4, %pI4, s=%u, a=%u)\n",
> >> +                          tcpflags_to_str(action, buf, sizeof(buf)),
> >> +                          &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
> >>                 net_set_syn_options(tcp, b);
> >>                 pkt_hdr_len = IP_TCP_O_SIZE;
> >>                 break;
> >> -       case TCP_SYN | TCP_ACK:
> >> -       case TCP_ACK:
> >> -               pkt_hdr_len = IP_HDR_SIZE + net_set_ack_options(tcp, b);
> >> -               b->ip.hdr.tcp_flags = action;
> >> -               debug_cond(DEBUG_DEV_PKT,
> >> -                          "TCP Hdr:ACK (%pI4, %pI4, s=%u, a=%u, A=%x)\n",
> >> -                          &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num,
> >> -                          action);
> >> -               break;
> >> -       case TCP_FIN:
> >> -               debug_cond(DEBUG_DEV_PKT,
> >> -                          "TCP Hdr:FIN  (%pI4, %pI4, s=%u, a=%u)\n",
> >> -                          &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
> >> -               payload_len = 0;
> >> -               pkt_hdr_len = IP_TCP_HDR_SIZE;
> >> -               break;
> >>         case TCP_RST | TCP_ACK:
> >>         case TCP_RST:
> >>                 debug_cond(DEBUG_DEV_PKT,
> >> -                          "TCP Hdr:RST  (%pI4, %pI4, s=%u, a=%u)\n",
> >> +                          "TCP Hdr:%s (%pI4, %pI4, s=%u, a=%u)\n",
> >> +                          tcpflags_to_str(action, buf, sizeof(buf)),
> >>                            &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
> >> +               pkt_hdr_len = IP_TCP_HDR_SIZE;
> >>                 break;
> >> -       /* Notify connection closing */
> >> -       case (TCP_FIN | TCP_ACK):
> >> -       case (TCP_FIN | TCP_ACK | TCP_PUSH):
> >> -               debug_cond(DEBUG_DEV_PKT,
> >> -                          "TCP Hdr:FIN ACK PSH(%pI4, %pI4, s=%u, a=%u, A=%x)\n",
> >> -                          &tcp->rhost, &net_ip,
> >> -                          tcp_seq_num, tcp_ack_num, action);
> >> -               fallthrough;
> >>         default:
> >>                 pkt_hdr_len = IP_HDR_SIZE + net_set_ack_options(tcp, b);
> >> -               b->ip.hdr.tcp_flags = action | TCP_PUSH | TCP_ACK;
> >>                 debug_cond(DEBUG_DEV_PKT,
> >> -                          "TCP Hdr:dft  (%pI4, %pI4, s=%u, a=%u, A=%x)\n",
> >> -                          &tcp->rhost, &net_ip,
> >> -                          tcp_seq_num, tcp_ack_num, action);
> >> +                          "TCP Hdr:%s (%pI4, %pI4, s=%u, a=%u)\n",
> >> +                          tcpflags_to_str(action, buf, sizeof(buf)),
> >> +                          &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
> >> +               break;
> >>         }
> >>
> >>         pkt_len = pkt_hdr_len + payload_len;
> >> --
> >> 2.39.2
> >>
> > Regards,
> > Simon
