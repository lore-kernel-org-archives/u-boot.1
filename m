Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17DEC27C55
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 16:54:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31BB1846D1;
	Thu,  6 Jun 2024 18:54:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fxzNHCGQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 089008826B; Thu,  6 Jun 2024 18:54:06 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB27483333
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 18:54:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1f63642ab8aso11186265ad.3
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 09:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717692841; x=1718297641; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M/krrwsZMgUA5bRU7ShJxeZeyvQF5ILuCR3m3yXCcu4=;
 b=fxzNHCGQNA3kGy5iNcAGmc5thno7xsyg8YfZzzRiwm7k31B7kxrX+Ij1Na+cAE0jVe
 u5KpEknkWPCSql5P94xGyAUvb4mRhKaU4SXXaouYag9g7ha+bRbsnjm6hc8O1muHje45
 gUoGSlV3uFeM8G6WR5UIIFGXfoUwk/1KVHdNEdALbHB+7HwE8rX4Y6swRROwlF41yFhl
 LNvJMWE2TVWqmDzkJhuBPf2ZQ+W19nbAEl7cK3E+J3vQFT/ccociSvSAJ1O+Pb4u760F
 S0LEqu83dBG1gvAmCM3AWaPcY1gikyLaxsLFYxIAC4GPX2eB50GO2hlr00Siob7p0lqn
 hiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717692841; x=1718297641;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M/krrwsZMgUA5bRU7ShJxeZeyvQF5ILuCR3m3yXCcu4=;
 b=nJMSBMkbsckTIqKfClFkfI9jNUpXBJ8mOw8KyTVt97lrp5WUNiKKaYg++cTbHOFGfg
 nm7V24S6vjpAzXfflsQ3HP4UY87QN2HtxxeeYlJArrunRnoCLtwPCU7a4C+wRaALoiVd
 WNu2UJB8BlyOH9FOkGonvoqJnMLqHbg+I5aQkC1NC0A4gBBG4UAL1NJUzYyeka5gGjBP
 Qsgb/CVlCGBkz0OI151IVytBDGqg0FYQhHSl5ENmKu53AKzhnwee08exf5fQeFvXa3g4
 IvYG325f9cVTQZnQcAHDIpuT96rSsfArvvy2ZVEn12dyfY++6OHEMtKaPxrWnCD59kV4
 hxOA==
X-Gm-Message-State: AOJu0Yy0MdVknSLApBC4IX7v8GLgB1w9IPXzmfE9sr9JrqjXdX2tNix3
 8lyDMtd2NBujv47dAMG0nCGvTSh0O01T/hlxvGBv9/io5q+Hxn4HzrakONzv5SiFhGWpmTfzHLt
 LOsaF22IBi2Io8qv+48aLVTQsS1cK6Dd4frrKlQ==
X-Google-Smtp-Source: AGHT+IGfr9nZTtHFBI2qQqzp/6T1RYoaq3OnZIz3GYuAPRSPOp0NcEC1h0GIV6G3Rr//5kNqpEsHa4ZFqg6RuNG1o6M=
X-Received: by 2002:a17:903:41ca:b0:1f6:7f45:4d37 with SMTP id
 d9443c01a7336-1f6d03f5337mr1520115ad.66.1717692841378; Thu, 06 Jun 2024
 09:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1717680809.git.jerome.forissier@linaro.org>
 <7ae6750ee1319cafa8b5b86f34394d597439b610.1717680809.git.jerome.forissier@linaro.org>
In-Reply-To: <7ae6750ee1319cafa8b5b86f34394d597439b610.1717680809.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 6 Jun 2024 19:53:24 +0300
Message-ID: <CAC_iWjJcnBv_1iVeJGk=G1yc54TFF7Jqooa5m30AMoVGR1FSLw@mail.gmail.com>
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

[...]

> +static int ping_raw_init(void *recv_arg)
> +{
> +       ping_pcb = raw_new(IP_PROTO_ICMP);
> +       if (!ping_pcb)
> +               return -ENOMEM;
> +
> +       raw_recv(ping_pcb, ping_recv, recv_arg);
> +       raw_bind(ping_pcb, IP_ADDR_ANY);
> +
> +       return 0;
> +}
> +
> +static void ping_raw_stop(void)
> +{
> +       if (ping_pcb != NULL) {

nits, but we usually do if (!ping_pcb) for NULL pointers and variables
that have a value of 0.
Please change it in other files as well


> +               raw_remove(ping_pcb);
> +               ping_pcb = NULL;
> +       }
> +}
> +
> +static void ping_prepare_echo(struct icmp_echo_hdr *iecho)
> +{
> +       ICMPH_TYPE_SET(iecho, ICMP_ECHO);
> +       ICMPH_CODE_SET(iecho, 0);
> +       iecho->chksum = 0;
> +       iecho->id = PING_ID;
> +       iecho->seqno = lwip_htons(++ping_seq_num);
> +
> +       iecho->chksum = inet_chksum(iecho, sizeof(*iecho));
> +}
> +
> +static void ping_send_icmp(struct raw_pcb *raw, const ip_addr_t *addr)
> +{
> +       struct pbuf *p;
> +       struct icmp_echo_hdr *iecho;
> +       size_t ping_size = sizeof(struct icmp_echo_hdr);
> +
> +       p = pbuf_alloc(PBUF_IP, (u16_t)ping_size, PBUF_RAM);
> +       if (!p)
> +               return;
> +
> +       if ((p->len == p->tot_len) && (p->next == NULL)) {

&& !p->next

> +               iecho = (struct icmp_echo_hdr *)p->payload;
> +               ping_prepare_echo(iecho);
> +               raw_sendto(raw, p, addr);
> +       }
> +
> +       pbuf_free(p);
> +}
> +
> +static void ping_send(void *arg)
> +{
> +       struct raw_pcb *pcb = (struct raw_pcb *)arg;
> +
> +       ping_send_icmp(pcb, ping_target);
> +       sys_timeout(PING_DELAY_MS, ping_send, ping_pcb);
> +}
> +
> +static int ping_loop(const ip_addr_t* addr)
> +{
> +       bool alive;
> +       ulong start;
> +       int ret;
> +
> +       printf("Using %s device\n", eth_get_name());
> +
> +       ret = ping_raw_init(&alive);
> +       if (ret < 0)
> +               return ret;
> +       ping_target = addr;
> +       ping_seq_num = 0;
> +
> +       start = get_timer(0);
> +       ping_send(ping_pcb);
> +
> +       do {
> +               eth_rx();
> +               if (alive)
> +                       break;
> +               sys_check_timeouts();
> +               if (ctrlc()) {
> +                       printf("\nAbort\n");
> +                       break;
> +               }
> +       } while (get_timer(start) < PING_TIMEOUT_MS);

I am a bit confused about what happens here.
ping_send() will send the packet, but it will also schedule itself to
rerun after 1 ms and send another ping?

> +
> +       sys_untimeout(ping_send, ping_pcb);

So we need the sys_untimeout() because we queued 2 pings? Because
sys_timeout() is supposed to be an one shot.

Thanks
/Ilias
> +       ping_raw_stop();
> +       ping_target = NULL;
> +
> +       if (alive) {
> +               alive = false;
> +               return 0;
> +       }
> +       printf("ping failed; host %s is not alive\n", ipaddr_ntoa(addr));
> +       return -1;
> +}
> +
> +int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> +{
> +       ip_addr_t addr;
> +
> +       if (argc < 2)
> +               return CMD_RET_USAGE;
> +
> +       if (!ipaddr_aton(argv[1], &addr))
> +               return CMD_RET_USAGE;
> +
> +       if (ping_loop(&addr) < 0)
> +               return CMD_RET_FAILURE;
> +
> +       return CMD_RET_SUCCESS;
> +}
> --
> 2.40.1
>
