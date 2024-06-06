Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA4CC25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 12:04:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19FBB88395;
	Thu,  6 Jun 2024 14:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j9rCX610";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AB69883E3; Thu,  6 Jun 2024 14:04:27 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AEB188274
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 14:04:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2eaafda3b5cso10698551fa.3
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 05:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717675464; x=1718280264; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TemLP4xcHNA2VJCdpMfO/9qwSluuBukYKHIefOQLwtA=;
 b=j9rCX610us0wN60mnjNUZCGH/OBHLb3t0asnTK9Ia1eR4lWCwdbpf0hzxkVzB2ySfb
 dRZ1TeQT18tXAmSRQoP4FjiH9Pe6nx1HnpOj2Pk+DA2hiJP1HKdQtDXPloXdpr7O83ak
 kvdT6na+GLoZLTVpz0YwnsNy/wckP/PkDwerA+T+VijrYGs6i51zn1JexZVep3fihLXs
 QPyQuk2wSiNLKFRkPJITYObtyCKfKmnd2Jq76Mo5kqOnXUXDqfY+jVjUtKBU8Pt+mMyw
 9nut+EQoUlggInzZN9r5tXRI7c+W1JcfdMMArTGRrHDGHPAd34hDu5C9WOw5rRhWw3hg
 nf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717675464; x=1718280264;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TemLP4xcHNA2VJCdpMfO/9qwSluuBukYKHIefOQLwtA=;
 b=MEA191kACiVrqxfRd2gXWvXJLsLDvmtOPDBjnZPGPwpEA/a8q0LUlHgZh+Yinek32f
 1Fx8CZS6AmZT1qibHn10O2aciDfXLqUWb7z1N876sStapyo4cwGw2dWWQb5pBYvXBX+u
 ytHwcRJPEQwc7MhpyvT/N0TjpGdS9rqyvhBDsMpJLJBVkRT2XZ3cdpl+E2/gfGavKtAb
 O6mj9v+rQZJnp3CeXV81H7aGborLkeUJw0vqGdmIXwCnhhU/5wjZ2s8qf0YN8z0qBqkm
 CO9JW3ILNN8fsX1vkjoz3Kdhbwft9GeOzkFXhq8C2s9cdSu+M1xwdgri+kxkzdIYkaO3
 SMiA==
X-Gm-Message-State: AOJu0YyvYbUc3logGbZziQlpba6M7OAbEI969smb2f/mmDOp0TlPoNQu
 Y1v9PpAQ8OlitdhoTkKMOGbiT1yVqP4LCMK/fNZY1euqLNqfCz0WKzncXf0qKjg=
X-Google-Smtp-Source: AGHT+IHSHnt+RgpRxE1fapnyvlrzIT7ix4Y12V/wuPagV8kWvWSXHIieNxdTSmd9M3oF6TAFBl9Zmg==
X-Received: by 2002:a2e:9190:0:b0:2e9:8417:ff9d with SMTP id
 38308e7fff4ca-2eac7a6fa87mr27554311fa.52.1717675464204; 
 Thu, 06 Jun 2024 05:04:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:af73:f6a9:3d55:6f07?
 ([2a01:e0a:3cb:7bb0:af73:f6a9:3d55:6f07])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c2c6900sm19477425e9.36.2024.06.06.05.04.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 05:04:23 -0700 (PDT)
Message-ID: <760a5430-7045-423f-aabc-c7b62d30236a@linaro.org>
Date: Thu, 6 Jun 2024 14:04:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] net-lwip: add ping command
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Michal Simek
 <michal.simek@amd.com>, Francis Laniel
 <francis.laniel@amarulasolutions.com>, Peter Robinson <pbrobinson@gmail.com>
References: <cover.1716566960.git.jerome.forissier@linaro.org>
 <284076d79cd331cf1a4923e0cea32fefc4c14fba.1716566960.git.jerome.forissier@linaro.org>
 <ZmF9CBbXSg4kDJLv@hera>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <ZmF9CBbXSg4kDJLv@hera>
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



On 6/6/24 11:10, Ilias Apalodimas wrote:
>> +#include <net-lwip.h>
>> +#include <time.h>
>> +
>> +#define PING_DELAY_MS 1000
>> +#define PING_TIMEOUT_MS 10000
>> +/* Additional data size to include in the packet */
>> +#define PING_DATA_SIZE 32
>> +/* Ping identifier - must fit on a u16_t */
>> +#define PING_ID 0xAFAF
>> +
>> +static const ip_addr_t *ping_target;
>> +static struct raw_pcb *ping_pcb;
>> +static u16_t ping_seq_num;
> 
> As a general note, u8_t u16_t etc are lwip constructs.
> Can we not use them and instead use the original definition?
> uint8_t etc. I am not sure introducing another define is what we want. Tom?

I think it makes sense to use the more standard type (uint16_t etc.) when
defining variables like here. However I'd rather keep the lwIP types in
the function definitions to reflect the function prototype exactly.

>> +static bool ping_target_alive;
>> +
>> +static u8_t ping_recv(void *arg, struct raw_pcb *pcb, struct pbuf *p,
>> +		      const ip_addr_t *addr)
>> +{
>> +	struct icmp_echo_hdr *iecho;
>> +
>> +	if (addr->addr != ping_target->addr)
>> +		return 0;
>> +
>> +	if ((p->tot_len >= (IP_HLEN + sizeof(struct icmp_echo_hdr))) &&
>> +	    pbuf_remove_header(p, IP_HLEN) == 0) {
>> +		iecho = (struct icmp_echo_hdr *)p->payload;
>> +
>> +		if ((iecho->id == PING_ID) &&
>> +		    (iecho->seqno == lwip_htons(ping_seq_num))) {
>> +			ping_target_alive = true;
>> +			printf("host %s is alive\n", ipaddr_ntoa(addr));
>> +			pbuf_free(p);
>> +			return 1; /* eat the packet */
>> +		}
>> +		/* not eaten, restore original packet */
>> +		pbuf_add_header(p, IP_HLEN);
>> +	}
>> +
>> +	return 0; /* don't eat the packet */
>> +}
>> +
>> +static int ping_raw_init(void)
>> +{
>> +	ping_pcb = raw_new(IP_PROTO_ICMP);
>> +	if (!ping_pcb)
>> +		return -ENOMEM;
>> +
>> +	raw_recv(ping_pcb, ping_recv, NULL);
> 
> Instead of defining a global variable ping_target_alive can we instead pass
> the ptr of void *recv_arg? We can then fill in that private ptr with the
> status

Sure. Fixed in v3.
 
>> +	raw_bind(ping_pcb, IP_ADDR_ANY);
>> +
>> +	return 0;
>> +}
>> +
>> +static void ping_raw_stop(void)
>> +{
>> +	if (ping_pcb != NULL) {
>> +		raw_remove(ping_pcb);
>> +		ping_pcb = NULL;
>> +	}
>> +}
>> +
>> +static void ping_prepare_echo(struct icmp_echo_hdr *iecho, u16_t len)
>> +{
>> +	size_t i;
>> +	size_t data_len = len - sizeof(struct icmp_echo_hdr);
>> +
>> +	ICMPH_TYPE_SET(iecho, ICMP_ECHO);
>> +	ICMPH_CODE_SET(iecho, 0);
>> +	iecho->chksum = 0;
>> +	iecho->id = PING_ID;
>> +	iecho->seqno = lwip_htons(++ping_seq_num);
>> +
>> +	/* Fill the additional data buffer with some data */
>> +	for(i = 0; i < data_len; i++) {
>> +		((char *)iecho)[sizeof(struct icmp_echo_hdr) + i] = (char)i;
>> +	}
> 
> is this additional data used? And if they are shouldn't we care about
> endianess?

It's a random payload for the ICMP packet. TBH it's totally useless here,
I will just remove the additional data in v3.

> 
>> +
>> +	iecho->chksum = inet_chksum(iecho, len);
>> +}
>> +
>> +static void ping_send_icmp(struct raw_pcb *raw, const ip_addr_t *addr)
>> +{
>> +	struct pbuf *p;
>> +	struct icmp_echo_hdr *iecho;
>> +	size_t ping_size = sizeof(struct icmp_echo_hdr) + PING_DATA_SIZE;
>> +
>> +	p = pbuf_alloc(PBUF_IP, (u16_t)ping_size, PBUF_RAM);
>> +	if (!p)
>> +		return;
>> +
>> +	if ((p->len == p->tot_len) && (p->next == NULL)) {
>> +		iecho = (struct icmp_echo_hdr *)p->payload;
>> +		ping_prepare_echo(iecho, (u16_t)ping_size);
>> +		raw_sendto(raw, p, addr);
>> +	}
>> +
>> +	pbuf_free(p);
>> +}
>> +
>> +static void ping_send(void *arg)
>> +{
>> +	struct raw_pcb *pcb = (struct raw_pcb *)arg;
>> +
>> +	ping_send_icmp(pcb, ping_target);
>> +	sys_timeout(PING_DELAY_MS, ping_send, ping_pcb);
>> +}
>> +
>> +static int ping_loop(const ip_addr_t* addr)
>> +{
>> +	ulong start;
>> +	int ret;
>> +
>> +	printf("Using %s device\n", eth_get_name());
>> +
>> +	ret = ping_raw_init();
>> +	if (ret < 0)
>> +		return ret;
>> +	ping_target = addr;
>> +
>> +	start = get_timer(0);
>> +	ping_send(ping_pcb);
>> +
>> +	do {
>> +		eth_rx();
> 
> eth_rx() has a ret value. Don't we have to check it here?

We would not do anything different on error because an error
might be transient, we don't want too much complexity. Letting the
loop run until success (which is determined by the proper ICMP
echo reply being received) or timeout or Ctrl-C is good enough.

BTW net_loop() in net/net.c doesn't check the return status,
either.

> 
>> +		if (ping_target_alive)
>> +			break;
>> +		sys_check_timeouts();
>> +		if (ctrlc()) {
>> +			printf("\nAbort\n");
>> +			break;
>> +		}
>> +	} while (get_timer(start) < PING_TIMEOUT_MS);
>> +
>> +	sys_untimeout(ping_send, ping_pcb);
>> +	ping_raw_stop();
>> +	ping_target = NULL;
>> +
>> +	if (ping_target_alive) {
>> +		ping_target_alive = false;
>> +		return 0;
>> +	}
>> +	printf("ping failed; host %s is not alive\n", ipaddr_ntoa(addr));
>> +	return -1;
>> +}
>> +
>> +int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>> +{
>> +	ip_addr_t addr;
>> +
>> +	if (argc < 2)
>> +		return CMD_RET_USAGE;
>> +
>> +	if (!ipaddr_aton(argv[1], &addr))
>> +		return CMD_RET_USAGE;
>> +
>> +	if (ping_loop(&addr) < 0)
>> +		return CMD_RET_FAILURE;
>> +
>> +	return CMD_RET_SUCCESS;
>> +}
>> --
>> 2.40.1
>>
> 
> Regards
> /Ilias
