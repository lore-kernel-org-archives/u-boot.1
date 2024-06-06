Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01ECC27C54
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 17:46:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6E6888009;
	Thu,  6 Jun 2024 19:46:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MgaANj1X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B0068806C; Thu,  6 Jun 2024 19:46:11 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B8C187F64
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 19:46:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-6c9e8c0a15bso956388a12.3
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 10:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717695967; x=1718300767; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LX27vffjMR0jHJi/C3UKCA5ZlFWtQg+SsVC4ba71kvk=;
 b=MgaANj1XDgbYck6HJVvRWfkC9twk/qq87eGb3d1dKU9poOdJsombhK+3c2qkXWnPVY
 BE1U3uPcY7bYQ8AN8Bhy9SAYbaBzmyXu9s7BiD4oub1buse5N7awVD826zt7CTw7WPTk
 B017VNHXKNxzr9NyKYiVyIIb/RLY/hEtLhHUD5KrrZx3q3IB9raEjPCNUjq2ElwpPGO6
 3eO8e0Td2liTuGHDewCYBdjwtpC0ctcB7jTQnqbjwoQg7rMLlIMEd5CK7hKbge8+smuS
 qAXHLnupJECBhlhnk2k5LCvemAtM8kW6EPPU4U1OgUV003WrPbAX7GSD1ZkuFKLxjkgv
 d97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717695967; x=1718300767;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LX27vffjMR0jHJi/C3UKCA5ZlFWtQg+SsVC4ba71kvk=;
 b=cFv2892D4FBO3izLCBb/XzjAcqySFn9yZudVq5Vfmxkvdxkz1+vdH6f72RRw0TovXe
 TeCqtXjehNXE/zfNuEr+AoO6pA9to3KgA/XaxiVxIoWmlBhteiF/GOYshIEsAAgQ9WvM
 nQGTgqLS3mNBxwDju429l7Qv9fcyqWOCTD4sk9OY5C19JueHJkHzl0gRkPDfBlgoq28O
 Iu6flyGEuE68gmhj1RcGhDJlJFdrMrIf+KAuz5w+KG1asyCv3ZVAmpmTd04sH72mkaVE
 SPMRw4uslAkuZdLjQy8aumfRvRbd41S99s11WkfFUol95RLu8/UlVza7IBeczzR4LVzw
 bsEw==
X-Gm-Message-State: AOJu0Yw9uTgZqC4Lv5vQLMheiveC5UXB8YJYZcnDIBs2nMMUUPLUEnws
 afIr3fMcgTwMtHJvSJpNR2zs4DMX5XxVWSNPaR3jkvO1uW4MUMY+nSSqA333LaodbVfAqcePUI5
 tC3aTrSooUmYdcxdIb/2wYFi1E6whjbcWm1Lkdw==
X-Google-Smtp-Source: AGHT+IFEfekHZ6rFFgd49ygatlgeRO6plXZc3592wIeMixWUljygTxQBAzUAiSRvb2CbDlaPBjvdEdcp924iR/JpHhw=
X-Received: by 2002:a17:90a:8402:b0:2c2:5a29:9bb5 with SMTP id
 98e67ed59e1d1-2c2bcacce7cmr229970a91.5.1717695967453; Thu, 06 Jun 2024
 10:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1717680809.git.jerome.forissier@linaro.org>
 <7ae6750ee1319cafa8b5b86f34394d597439b610.1717680809.git.jerome.forissier@linaro.org>
 <CAC_iWjJcnBv_1iVeJGk=G1yc54TFF7Jqooa5m30AMoVGR1FSLw@mail.gmail.com>
 <CAC_iWjLqEVLcys4YDXqgwvSUOpwHvdwOZ0Ms0j8_y_ew4MEBKQ@mail.gmail.com>
In-Reply-To: <CAC_iWjLqEVLcys4YDXqgwvSUOpwHvdwOZ0Ms0j8_y_ew4MEBKQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 6 Jun 2024 20:45:31 +0300
Message-ID: <CAC_iWj+b3wq=7t++3UAtcjDtmN9itgXu2sODD4nqkR82gTbGDg@mail.gmail.com>
Subject: Re: [PATCH v3 05/12] net-lwip: add ping command
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>, 
 Maxim Uvarov <muvarov@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>
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

On Thu, 6 Jun 2024 at 20:02, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Thu, 6 Jun 2024 at 19:53, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > [...]
> >
> > > +static int ping_raw_init(void *recv_arg)
> > > +{
> > > +       ping_pcb = raw_new(IP_PROTO_ICMP);
> > > +       if (!ping_pcb)
> > > +               return -ENOMEM;
> > > +
> > > +       raw_recv(ping_pcb, ping_recv, recv_arg);
> > > +       raw_bind(ping_pcb, IP_ADDR_ANY);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static void ping_raw_stop(void)
> > > +{
> > > +       if (ping_pcb != NULL) {
> >
> > nits, but we usually do if (!ping_pcb) for NULL pointers and variables
> > that have a value of 0.
> > Please change it in other files as well
> >
> >
> > > +               raw_remove(ping_pcb);
> > > +               ping_pcb = NULL;
> > > +       }
> > > +}
> > > +
> > > +static void ping_prepare_echo(struct icmp_echo_hdr *iecho)
> > > +{
> > > +       ICMPH_TYPE_SET(iecho, ICMP_ECHO);
> > > +       ICMPH_CODE_SET(iecho, 0);
> > > +       iecho->chksum = 0;
> > > +       iecho->id = PING_ID;
> > > +       iecho->seqno = lwip_htons(++ping_seq_num);
> > > +
> > > +       iecho->chksum = inet_chksum(iecho, sizeof(*iecho));
> > > +}
> > > +
> > > +static void ping_send_icmp(struct raw_pcb *raw, const ip_addr_t *addr)
> > > +{
> > > +       struct pbuf *p;
> > > +       struct icmp_echo_hdr *iecho;
> > > +       size_t ping_size = sizeof(struct icmp_echo_hdr);
> > > +
> > > +       p = pbuf_alloc(PBUF_IP, (u16_t)ping_size, PBUF_RAM);
> > > +       if (!p)
> > > +               return;
> > > +
> > > +       if ((p->len == p->tot_len) && (p->next == NULL)) {
> >
> > && !p->next
> >
> > > +               iecho = (struct icmp_echo_hdr *)p->payload;
> > > +               ping_prepare_echo(iecho);
> > > +               raw_sendto(raw, p, addr);
> > > +       }
> > > +
> > > +       pbuf_free(p);
> > > +}
> > > +
> > > +static void ping_send(void *arg)
> > > +{
> > > +       struct raw_pcb *pcb = (struct raw_pcb *)arg;
> > > +
> > > +       ping_send_icmp(pcb, ping_target);
> > > +       sys_timeout(PING_DELAY_MS, ping_send, ping_pcb);
> > > +}
> > > +
> > > +static int ping_loop(const ip_addr_t* addr)
> > > +{
> > > +       bool alive;
> > > +       ulong start;
> > > +       int ret;
> > > +
> > > +       printf("Using %s device\n", eth_get_name());
> > > +
> > > +       ret = ping_raw_init(&alive);
> > > +       if (ret < 0)
> > > +               return ret;
> > > +       ping_target = addr;
> > > +       ping_seq_num = 0;
> > > +
> > > +       start = get_timer(0);
> > > +       ping_send(ping_pcb);
> > > +
> > > +       do {
> > > +               eth_rx();
> > > +               if (alive)
> > > +                       break;
> > > +               sys_check_timeouts();
> > > +               if (ctrlc()) {
> > > +                       printf("\nAbort\n");
> > > +                       break;
> > > +               }
> > > +       } while (get_timer(start) < PING_TIMEOUT_MS);
> >
> > I am a bit confused about what happens here.
> > ping_send() will send the packet, but it will also schedule itself to
> > rerun after 1 ms and send another ping?
> >
> > > +
> > > +       sys_untimeout(ping_send, ping_pcb);
> >
> > So we need the sys_untimeout() because we queued 2 pings? Because
> > sys_timeout() is supposed to be an one shot.
>
> Ah nvm, I misread that. We always reschedule ping_send_icmp(), that's
> why we have to delete it here

Ok so looking at it a bit more. Why do we have to schedule contunuous pings?
We just have to send one packet and wait for the response no?

Thanks
/Ilias
>
>
> >
> > Thanks
> > /Ilias
> > > +       ping_raw_stop();
> > > +       ping_target = NULL;
> > > +
> > > +       if (alive) {
> > > +               alive = false;
> > > +               return 0;
> > > +       }
> > > +       printf("ping failed; host %s is not alive\n", ipaddr_ntoa(addr));
> > > +       return -1;
> > > +}
> > > +
> > > +int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> > > +{
> > > +       ip_addr_t addr;
> > > +
> > > +       if (argc < 2)
> > > +               return CMD_RET_USAGE;
> > > +
> > > +       if (!ipaddr_aton(argv[1], &addr))
> > > +               return CMD_RET_USAGE;
> > > +
> > > +       if (ping_loop(&addr) < 0)
> > > +               return CMD_RET_FAILURE;
> > > +
> > > +       return CMD_RET_SUCCESS;
> > > +}
> > > --
> > > 2.40.1
> > >
