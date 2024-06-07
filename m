Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9377AC27C55
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 07:55:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11DB28824A;
	Fri,  7 Jun 2024 09:55:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ogmKCTnR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C88438824C; Fri,  7 Jun 2024 09:55:14 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC7658823D
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 09:55:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42159283989so22018635e9.3
 for <u-boot@lists.denx.de>; Fri, 07 Jun 2024 00:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717746912; x=1718351712; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jwoAHS8lqZip14RsW8Wp68dyi940YThTlNWAYOOjPWE=;
 b=ogmKCTnRGs8st6BI0yaZj7whCziJDxNi9GB6dX2xoG7/ifwMBbdEm0UiHeMZfvEkhS
 Xg4pwqE+xOx6kyJsRkPAZevQCyoOXBjkfhEIDYe+dPfur3iGZrt8aITyaymxrowllNKV
 xovzTit2WmecUW+NT2uZZ/4f9UGqTFZBoFEppBN4Wko5ByjA0itWwVH8WRT5/KZ3sX8W
 8QMEUhLoy8iVYZizNsND/2+Rlp782MTCjd6hBcHHwnM0Imbcz/D6+CCVSJV5+nHmoJYA
 FL3bwtHE33uwzjg/+UQJj7NsQxbWukDI3UkwcIy8BSIpDp4jEHKZBiIm1WZEGzAWYhWE
 ZpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717746912; x=1718351712;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jwoAHS8lqZip14RsW8Wp68dyi940YThTlNWAYOOjPWE=;
 b=ONSKNfqEZY6ePWSBBD0FIQsX0Jo3QjrHSgkFnIHWvHpdyx8fIxnstevY343O0tYP4u
 qEaN2COITLE2vcYEFVJyewXTbqXt9RDovrR7jHtv5TbqtqDaOiiUAo0HI6LUIsddnscL
 jjM4i9AnEXGoFB/EHYcpMHd5CLA3nhAM8N2VZ+eCMd0a9Yrp1i9ShEn2fDTnUIxv7nrv
 LjXvOYz/jscGEvjTRhrPCg4HPRdfKMkr3NxBJg2JyadaB0bmTopHDnbtXjcbnd2DmVAq
 jaHgF4GXjYEpdcE7FXOfCXk3Cd/FbHm/cByV782OkAl0b7ks7LytpkDcT++96QXnYgnF
 UjSQ==
X-Gm-Message-State: AOJu0YyGHuG1rXON1HKV1uKstSuYKCj02779PYnq534grC2jNjfgNjob
 6iIZUUA465D35VueGfrOLZkvqWWhQSCmDVtv87TRKz3cRP6ditNAXqeQcAWe2ZI=
X-Google-Smtp-Source: AGHT+IGyQ83hM2whjeml8tOtJRxsvB5iJdh9IFqbAsXcFkv9qHFiN4V/d4HtS/lZhbsNSmXa/Tt9HA==
X-Received: by 2002:a05:600c:154d:b0:421:54d0:5123 with SMTP id
 5b1f17b1804b1-42164a44574mr22383565e9.34.1717746912084; 
 Fri, 07 Jun 2024 00:55:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9?
 ([2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4216ca84edasm8715315e9.45.2024.06.07.00.55.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jun 2024 00:55:11 -0700 (PDT)
Message-ID: <f50ca00a-b68d-4841-8be4-e6f89d5a9c42@linaro.org>
Date: Fri, 7 Jun 2024 09:55:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/12] net-lwip: add ping command
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Michal Simek
 <michal.simek@amd.com>, Francis Laniel
 <francis.laniel@amarulasolutions.com>, Peter Robinson <pbrobinson@gmail.com>
References: <cover.1717680809.git.jerome.forissier@linaro.org>
 <7ae6750ee1319cafa8b5b86f34394d597439b610.1717680809.git.jerome.forissier@linaro.org>
 <CAC_iWjJcnBv_1iVeJGk=G1yc54TFF7Jqooa5m30AMoVGR1FSLw@mail.gmail.com>
 <CAC_iWjLqEVLcys4YDXqgwvSUOpwHvdwOZ0Ms0j8_y_ew4MEBKQ@mail.gmail.com>
 <CAC_iWj+b3wq=7t++3UAtcjDtmN9itgXu2sODD4nqkR82gTbGDg@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWj+b3wq=7t++3UAtcjDtmN9itgXu2sODD4nqkR82gTbGDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 6/6/24 19:45, Ilias Apalodimas wrote:
> On Thu, 6 Jun 2024 at 20:02, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
>>
>> On Thu, 6 Jun 2024 at 19:53, Ilias Apalodimas
>> <ilias.apalodimas@linaro.org> wrote:
>>>
>>> [...]
>>>
>>>> +static int ping_raw_init(void *recv_arg)
>>>> +{
>>>> +       ping_pcb = raw_new(IP_PROTO_ICMP);
>>>> +       if (!ping_pcb)
>>>> +               return -ENOMEM;
>>>> +
>>>> +       raw_recv(ping_pcb, ping_recv, recv_arg);
>>>> +       raw_bind(ping_pcb, IP_ADDR_ANY);
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static void ping_raw_stop(void)
>>>> +{
>>>> +       if (ping_pcb != NULL) {
>>>
>>> nits, but we usually do if (!ping_pcb) for NULL pointers and variables
>>> that have a value of 0.
>>> Please change it in other files as well
>>>
>>>
>>>> +               raw_remove(ping_pcb);
>>>> +               ping_pcb = NULL;
>>>> +       }
>>>> +}
>>>> +
>>>> +static void ping_prepare_echo(struct icmp_echo_hdr *iecho)
>>>> +{
>>>> +       ICMPH_TYPE_SET(iecho, ICMP_ECHO);
>>>> +       ICMPH_CODE_SET(iecho, 0);
>>>> +       iecho->chksum = 0;
>>>> +       iecho->id = PING_ID;
>>>> +       iecho->seqno = lwip_htons(++ping_seq_num);
>>>> +
>>>> +       iecho->chksum = inet_chksum(iecho, sizeof(*iecho));
>>>> +}
>>>> +
>>>> +static void ping_send_icmp(struct raw_pcb *raw, const ip_addr_t *addr)
>>>> +{
>>>> +       struct pbuf *p;
>>>> +       struct icmp_echo_hdr *iecho;
>>>> +       size_t ping_size = sizeof(struct icmp_echo_hdr);
>>>> +
>>>> +       p = pbuf_alloc(PBUF_IP, (u16_t)ping_size, PBUF_RAM);
>>>> +       if (!p)
>>>> +               return;
>>>> +
>>>> +       if ((p->len == p->tot_len) && (p->next == NULL)) {
>>>
>>> && !p->next
>>>
>>>> +               iecho = (struct icmp_echo_hdr *)p->payload;
>>>> +               ping_prepare_echo(iecho);
>>>> +               raw_sendto(raw, p, addr);
>>>> +       }
>>>> +
>>>> +       pbuf_free(p);
>>>> +}
>>>> +
>>>> +static void ping_send(void *arg)
>>>> +{
>>>> +       struct raw_pcb *pcb = (struct raw_pcb *)arg;
>>>> +
>>>> +       ping_send_icmp(pcb, ping_target);
>>>> +       sys_timeout(PING_DELAY_MS, ping_send, ping_pcb);
>>>> +}
>>>> +
>>>> +static int ping_loop(const ip_addr_t* addr)
>>>> +{
>>>> +       bool alive;
>>>> +       ulong start;
>>>> +       int ret;
>>>> +
>>>> +       printf("Using %s device\n", eth_get_name());
>>>> +
>>>> +       ret = ping_raw_init(&alive);
>>>> +       if (ret < 0)
>>>> +               return ret;
>>>> +       ping_target = addr;
>>>> +       ping_seq_num = 0;
>>>> +
>>>> +       start = get_timer(0);
>>>> +       ping_send(ping_pcb);
>>>> +
>>>> +       do {
>>>> +               eth_rx();
>>>> +               if (alive)
>>>> +                       break;
>>>> +               sys_check_timeouts();
>>>> +               if (ctrlc()) {
>>>> +                       printf("\nAbort\n");
>>>> +                       break;
>>>> +               }
>>>> +       } while (get_timer(start) < PING_TIMEOUT_MS);
>>>
>>> I am a bit confused about what happens here.
>>> ping_send() will send the packet, but it will also schedule itself to
>>> rerun after 1 ms and send another ping?
>>>
>>>> +
>>>> +       sys_untimeout(ping_send, ping_pcb);
>>>
>>> So we need the sys_untimeout() because we queued 2 pings? Because
>>> sys_timeout() is supposed to be an one shot.
>>
>> Ah nvm, I misread that. We always reschedule ping_send_icmp(), that's
>> why we have to delete it here
> 
> Ok so looking at it a bit more. Why do we have to schedule contunuous pings?
> We just have to send one packet and wait for the response no?

We could send just one packet as NET does, but if there's packet loss then
the ping command will report the host is unreachable. I think it is safer
to allow for a few retries for better reliability. The code for one packet
would be marginally simpler anyways. What I can do however is use a send
counter rather than a timeout.

Thanks,
-- 
Jerome

