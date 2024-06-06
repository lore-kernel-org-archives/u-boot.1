Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B36CC27C52
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 09:10:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E743881B8;
	Thu,  6 Jun 2024 11:10:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aI/WDPtA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7F25881D9; Thu,  6 Jun 2024 11:10:38 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E6ED88103
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 11:10:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a626919d19dso338832766b.0
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 02:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717665036; x=1718269836; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+NQN3VQrEROArDuGiIu+SqcORw/DynAq5lA0flYllPk=;
 b=aI/WDPtAGmCxb0J0kC/OwA2o5UvJQd7NdMvjL6AU4Y6q5RdJG7+g2L7xDQULutOJw+
 EUln0muyf6P8VF0sJS8HdaEcaBBgLVFai9AStJAJ0prihmb/HXgyq0TiTB03dNnYuUBy
 MmrnnodPImqPiPcz8HH57+V4hnJbDifcgb1X3nxpeclnVvqoCww2+/saOSUzuVZDLM7K
 gjYa+JBJoK/tpNou8zmNyiGeBA4WDhD9a0KZzSjf7XWXt4vY0BTaDxeNDt7EEHrD3P9V
 KI5VPyyfAWiqzh8njqlBSanyw/Q80t5fTj6vXFt0lGf+ZDqfYXcQNE3AA0sdq1shyyh/
 VccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717665036; x=1718269836;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+NQN3VQrEROArDuGiIu+SqcORw/DynAq5lA0flYllPk=;
 b=P2vsM4N31yB/0zQcDuAGw+qRkA6z7GQ3lqPXqMg0W3lFU1+JaLxYXJ8hb/FuU7LMbn
 vFHky98NlzeYBvD6OewIw8nGzvsqaQEOtXmlUw6zBJyNKgCT1UVZOo98VP2RbN04YSa8
 0BbeU3v3eqbOwMqy5Zz7P82c4exUajZJQvkPicZ07s7V1E7DD2jeuomsh5pMckZA96d7
 Zh/8JNCH6xPr2yCGBzT5JeDT3Kpe2yH03+4BcbWe1/immJdWih1M+BORxITIhbwAFjSt
 Rdd6qSopiBv3ENHlroUYD4KhIFzT1aoU1BWqcem3t/hBvlnVEeT6GqF6uDCM43W2earF
 wBvg==
X-Gm-Message-State: AOJu0YxFz1Yej+Jv1gpa0Q2Xi4q24v4jFkR2WUJznIRvkrL4iaEQcXrV
 xxhPSZROgOVKc7FiHVflyTV6VMmzIZJJQd5GWqmtcCMJQNhfDX8CBidzPyecAMs=
X-Google-Smtp-Source: AGHT+IE+vnD4kzxDAvLsZYCcu72oCKfYR5rnRfWWya5tmSHnYugFtt2BMJZmvMgoahg0wfajl7lPDw==
X-Received: by 2002:a17:906:459c:b0:a59:be21:3587 with SMTP id
 a640c23a62f3a-a6c75f94214mr171645366b.8.1717665035900; 
 Thu, 06 Jun 2024 02:10:35 -0700 (PDT)
Received: from hera (ppp089210091242.access.hol.gr. [89.210.91.242])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c8058232asm67644366b.6.2024.06.06.02.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 02:10:35 -0700 (PDT)
Date: Thu, 6 Jun 2024 12:10:32 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v2 06/14] net-lwip: add ping command
Message-ID: <ZmF9CBbXSg4kDJLv@hera>
References: <cover.1716566960.git.jerome.forissier@linaro.org>
 <284076d79cd331cf1a4923e0cea32fefc4c14fba.1716566960.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <284076d79cd331cf1a4923e0cea32fefc4c14fba.1716566960.git.jerome.forissier@linaro.org>
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

> +#include <net-lwip.h>
> +#include <time.h>
> +
> +#define PING_DELAY_MS 1000
> +#define PING_TIMEOUT_MS 10000
> +/* Additional data size to include in the packet */
> +#define PING_DATA_SIZE 32
> +/* Ping identifier - must fit on a u16_t */
> +#define PING_ID 0xAFAF
> +
> +static const ip_addr_t *ping_target;
> +static struct raw_pcb *ping_pcb;
> +static u16_t ping_seq_num;

As a general note, u8_t u16_t etc are lwip constructs.
Can we not use them and instead use the original definition?
uint8_t etc. I am not sure introducing another define is what we want. Tom?

> +static bool ping_target_alive;
> +
> +static u8_t ping_recv(void *arg, struct raw_pcb *pcb, struct pbuf *p,
> +		      const ip_addr_t *addr)
> +{
> +	struct icmp_echo_hdr *iecho;
> +
> +	if (addr->addr != ping_target->addr)
> +		return 0;
> +
> +	if ((p->tot_len >= (IP_HLEN + sizeof(struct icmp_echo_hdr))) &&
> +	    pbuf_remove_header(p, IP_HLEN) == 0) {
> +		iecho = (struct icmp_echo_hdr *)p->payload;
> +
> +		if ((iecho->id == PING_ID) &&
> +		    (iecho->seqno == lwip_htons(ping_seq_num))) {
> +			ping_target_alive = true;
> +			printf("host %s is alive\n", ipaddr_ntoa(addr));
> +			pbuf_free(p);
> +			return 1; /* eat the packet */
> +		}
> +		/* not eaten, restore original packet */
> +		pbuf_add_header(p, IP_HLEN);
> +	}
> +
> +	return 0; /* don't eat the packet */
> +}
> +
> +static int ping_raw_init(void)
> +{
> +	ping_pcb = raw_new(IP_PROTO_ICMP);
> +	if (!ping_pcb)
> +		return -ENOMEM;
> +
> +	raw_recv(ping_pcb, ping_recv, NULL);

Instead of defining a global variable ping_target_alive can we instead pass
the ptr of void *recv_arg? We can then fill in that private ptr with the
status

> +	raw_bind(ping_pcb, IP_ADDR_ANY);
> +
> +	return 0;
> +}
> +
> +static void ping_raw_stop(void)
> +{
> +	if (ping_pcb != NULL) {
> +		raw_remove(ping_pcb);
> +		ping_pcb = NULL;
> +	}
> +}
> +
> +static void ping_prepare_echo(struct icmp_echo_hdr *iecho, u16_t len)
> +{
> +	size_t i;
> +	size_t data_len = len - sizeof(struct icmp_echo_hdr);
> +
> +	ICMPH_TYPE_SET(iecho, ICMP_ECHO);
> +	ICMPH_CODE_SET(iecho, 0);
> +	iecho->chksum = 0;
> +	iecho->id = PING_ID;
> +	iecho->seqno = lwip_htons(++ping_seq_num);
> +
> +	/* Fill the additional data buffer with some data */
> +	for(i = 0; i < data_len; i++) {
> +		((char *)iecho)[sizeof(struct icmp_echo_hdr) + i] = (char)i;
> +	}

is this additional data used? And if they are shouldn't we care about
endianess?

> +
> +	iecho->chksum = inet_chksum(iecho, len);
> +}
> +
> +static void ping_send_icmp(struct raw_pcb *raw, const ip_addr_t *addr)
> +{
> +	struct pbuf *p;
> +	struct icmp_echo_hdr *iecho;
> +	size_t ping_size = sizeof(struct icmp_echo_hdr) + PING_DATA_SIZE;
> +
> +	p = pbuf_alloc(PBUF_IP, (u16_t)ping_size, PBUF_RAM);
> +	if (!p)
> +		return;
> +
> +	if ((p->len == p->tot_len) && (p->next == NULL)) {
> +		iecho = (struct icmp_echo_hdr *)p->payload;
> +		ping_prepare_echo(iecho, (u16_t)ping_size);
> +		raw_sendto(raw, p, addr);
> +	}
> +
> +	pbuf_free(p);
> +}
> +
> +static void ping_send(void *arg)
> +{
> +	struct raw_pcb *pcb = (struct raw_pcb *)arg;
> +
> +	ping_send_icmp(pcb, ping_target);
> +	sys_timeout(PING_DELAY_MS, ping_send, ping_pcb);
> +}
> +
> +static int ping_loop(const ip_addr_t* addr)
> +{
> +	ulong start;
> +	int ret;
> +
> +	printf("Using %s device\n", eth_get_name());
> +
> +	ret = ping_raw_init();
> +	if (ret < 0)
> +		return ret;
> +	ping_target = addr;
> +
> +	start = get_timer(0);
> +	ping_send(ping_pcb);
> +
> +	do {
> +		eth_rx();

eth_rx() has a ret value. Don't we have to check it here?

> +		if (ping_target_alive)
> +			break;
> +		sys_check_timeouts();
> +		if (ctrlc()) {
> +			printf("\nAbort\n");
> +			break;
> +		}
> +	} while (get_timer(start) < PING_TIMEOUT_MS);
> +
> +	sys_untimeout(ping_send, ping_pcb);
> +	ping_raw_stop();
> +	ping_target = NULL;
> +
> +	if (ping_target_alive) {
> +		ping_target_alive = false;
> +		return 0;
> +	}
> +	printf("ping failed; host %s is not alive\n", ipaddr_ntoa(addr));
> +	return -1;
> +}
> +
> +int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> +{
> +	ip_addr_t addr;
> +
> +	if (argc < 2)
> +		return CMD_RET_USAGE;
> +
> +	if (!ipaddr_aton(argv[1], &addr))
> +		return CMD_RET_USAGE;
> +
> +	if (ping_loop(&addr) < 0)
> +		return CMD_RET_FAILURE;
> +
> +	return CMD_RET_SUCCESS;
> +}
> --
> 2.40.1
>

Regards
/Ilias
