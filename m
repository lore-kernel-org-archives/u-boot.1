Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2286606A320
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 16:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YQEwPBEi;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=o1HXbB1f
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8BB028122A;
	Wed, 18 Nov 2026 16:37:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oRJm4YLcOBGm; Wed, 18 Nov 2026 16:37:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ABFAE8110A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795019861;
	b=JjqBKRwQiYCTH43ASAAxQRZPVBY0cfXOMl3byw2Z19VpeZegPtpxhor8PSpBL6+LCaNx
	 uUBtX51irpSSFqd0i0u0n0doP/hhzBTliK/X3x4lCK/M/2IQWsEIHSskxL7QtmLo9wDx/
	 PlF46EM8eTP0jr15WmWjnYrcO1Ah5IBaJBNyRe+Fo+QKvcZPJmekswt5SlJbfAO4Mo9IV
	 pxxBkZBBi6eLKCRl/DU33QXvWTbiDg2HgL4JYpkomr0SX6hZNERmpOX4TSgdv7aA5evN6
	 QFpgm3YDF1PZxDQiw8+XZnFU4gAE0v5RAD6nmiBXfHIvKoFtl01Y8dTqMPSsR9AVPtg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795019861;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=55WRykGkeIRoZceQm3j2zo141I9boOl2NBxXC93z4QI=;
	b=FoSVFDoWo1mJ5PtJRs6QSZj+lwHQaykNCrkMoEBci+Y4gkeGCDnqRZKMHhbnXMVtO8x9
	 d+mBIkVnx7cZGPaA1WedUYwMoho5dc/F8S9JJ0gyRhkPTsthXAliCUZ2TBwnZbzIsSpeA
	 ZTpOwTRUynyVQBAIEzlgwDAPg169hecalNHElYGZY02CWZnXjvuvnQXWt2Z1/B0BB9/hP
	 bWESyGEvRTiE1QCLPr3stmC2p2bwzcCjVsRYxDZev2qYA7cZzxknJbLrHLGyn2Lm2bhsz
	 REfMEcNXp2Vq6FjRHpE0T9iKzNzgELLtF8n/D9JVq13Pe0rUz4pbiGuHihtnnIHo6aQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795019861;
	bh=55WRykGkeIRoZceQm3j2zo141I9boOl2NBxXC93z4QI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YQEwPBEidzijQqnpMwU9Hcj956EjbOKUH81kxZsdnSV55/R+GGHOEM9Uc1ItGg7p8
	 MOw+VZKZkm8U1FH2GgayBAXoRXfxFq0HVRnHeYK3wUbQPGSxBkdXZSmalB90wLjshY
	 r1kr3xFGPcXljmAlW0vYLfF5yq0yzK7nXQnzfsxBUGPSm91qU1rroas6Y2XyQ0zNVK
	 Cg9yvXZk75qssksEcWrB5yXRCc1U67QAOasDpzZ23iw27e579x8XJPTXaCUorD2CQg
	 HAn8zUgxVzjrYmAq9CJUJf02xKsMoL7YFrppueOKpbejeGxvup3ZdawGO+nnFVGb9M
	 wfJT1S2Y7s1jg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ABFAE8110A;
	Wed, 18 Nov 2026 16:37:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F018513C
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 16:37:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E146C4099C
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 16:37:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b1j2La6h-SUc for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 16:37:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CE15B4071F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=o1HXbB1f
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CE15B4071F
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 16:37:38 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso11668565e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 08:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795019856; x=1795624656;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=55WRykGkeIRoZceQm3j2zo141I9boOl2NBxXC93z4QI=;
 b=o1HXbB1fKD/XsoOSckevQwveWrv1ZzDXSq+MeAdzHJ4Ck4wOh4Vt6m0WywKKMr9Cxb
 m9f+dOA3xn7oVejn7gs79ZK2AcdB69WpCQ7n+KQh7mPxFwPOTBP4I6kQAFBUVxU7R7wM
 XiQGOpfy+mlYnZYwKOX98GDfU0Mq1iJgwyICB3/QUr04xBL0z1NJKU0TYfvoSLP+orMq
 m7+WdPTqK94YI51dZzinEiKNq4tLHVfwXRyOvztHPlIzrFFOVCF+mHRNh4uuJYdSZP7e
 7hldskcQHYcduY22gTFLMZGvbEfOqwFWEPC1xV8FHwfRKpRrg73j+lRD+aEQiYY4/HDA
 PWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795019856; x=1795624656;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=55WRykGkeIRoZceQm3j2zo141I9boOl2NBxXC93z4QI=;
 b=KG6rDMXZVGiXbnTMheXWE9UlH1PE89Y64ovoFUPRDXlT5Q+9xLB5cj21E34TaWlXOc
 wPQZjMpO4rJAdrCgPi+WUtdPSGwS8LkiXzB066LEwWFV5xEUZCcbrvXWxQZG7YTwDTqe
 +LCI61Oc+vRatHBIv5nsLRJNRfEK2tAYrQILFaOipRsavR33/K7WxXKKj8DGfFH0i38C
 k9sr0+phe/k+TId2BsFaCnN/JV2+WWfDaMvPd9mwkYgPi4Xkx5cFMGnU0b9WaR9QS/4f
 ktWyjZN/1SeoYdQyVNqtIzJDBFzcAF/LSF5FY1eCVvSxOW02XbVvdTnYqSieUsrzZiuE
 6WJQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFuS+nR6Qt6xdLHmpKv84kjJAsg7Ic1ZLiJkg3jCXXN41Qv7NQbvtVi3aTbUOSizY8tECrf9As=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9aL7vnGGal59WxSZloTZJw5l8fS2Gp+zPMTBPdrK3kDoqIiBBv
 M3Fiumv0evSKq/cjCA54BkYmnHVtZ6PFeGjbgJSIsD8NNq2t9XewXTV3WranBm2lqPU=
X-Gm-Gg: AYBFou1M1Q0Hxt017X1WvthwUuE+yfo7yfS5ZkrDVae6OsyHqU15hdIkgWnA4RWjBcp
 15yp8OVhAp9lfhXSG8HqQDQqJfQnspJ8uqDZk7bhksEwK/TOpp42beIU+rlWA7KjMVlQ/KBmwmw
 po3Ue5GUvxoxovZbomYrPTOlDei8jImz6Pdu4+5iFug0g+TYRtBuPxizrXyT0riBO/iRnL5d6cf
 FqgJKpsyzLh6hnyuWcFi+oA2keAh6/bVsX+slVZ735Xe3uLoMee6UMugu//9b6ugX4DFcrPQgWP
 5kqv8Ag3iWrEKMVs1JlTXj7sLTGYrkW01oJBpDPs1xM5kyR3p5NrG9TVmQrXtkI5QMoK6X8TV9N
 h51dBEAIqnZ96xqgZ27WjFsd/e7lFeBnZckr8/Fni/Fo6kwpSFzT+btIRL2Cx1v0N227XPORaxw
 Ks079TH77NnFDgAOOVaJ02BKQm4HSdajWFfJqbq0FiqCDUGgk2/GzHTfjl6MiTLst0rp3JikilP
 /YQ56pDRPrUjGJZWb5f7jdzOAlqjDDGlRWnI6XIsU+bVa103Z3+LCNfX61iGP4DYeyPps/jMfOV
 98XVKFMOEQAVxjjPrNGsRUTvyENOMGZeCha/JqZ6cx5jY4LEZPA7GG5uVw/3Iw0XEveBbtS3/SQ
 xTXAiRqs=
X-Received: by 2002:a05:600c:4e87:b0:4a5:75d2:c104 with SMTP id
 5b1f17b1804b1-4bb7da2db77mr64790265e9.22.1795019856256; 
 Wed, 18 Nov 2026 08:37:36 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e50:3860::642d:5bda?
 ([2a01:e0a:e50:3860::642d:5bda]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb784231basm152585475e9.11.2026.11.18.08.37.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 08:37:35 -0800 (PST)
Message-ID: <e724725f-0fef-4c97-8bd7-6dfeec457ad7@baylibre.com>
Date: Wed, 18 Nov 2026 17:37:35 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: fastboot_tcp: enforce rxbuf and stream offset bounds
To: George Kola <georgekola@google.com>,
 Dmitrii Merkurev <dimorinny@google.com>, Simon Glass <sjg@chromium.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 u-boot@lists.u-boot-project.org
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
References: <CAOTQ16LH4V_A86PAoa6C+s4WODCqhW+1aTfTm=kMsYi+Pe6mvQ@mail.gmail.com>
Content-Language: fr
From: Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <CAOTQ16LH4V_A86PAoa6C+s4WODCqhW+1aTfTm=kMsYi+Pe6mvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

i'm not able to apply your patch with b4, git or patch comand, it's 
malformed please resend it properly.
except that :

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

Regards
Guillaume

Le 15/11/2026 à 18:12, George Kola a écrit :
> tcp_stream_rx() copies incoming TCP payload bytes into the static
> 74-byte rxbuf without validating rx_offs or len, enabling a single TCP
> segment larger than rxbuf to overwrite adjacent globals. In addition,
> tcp_stream_on_rcv_nxt_update() treats cumulative rx_bytes as unread
> buffer bytes without subtracting data_read (causing fragmented reads to
> parse stale bytes and multi-command memmove() calls to overflow rxbuf)
> and does not bound cmd_size against FASTBOOT_COMMAND_LEN, while
> tcp_stream_tx() does not clamp copies to maxlen or guard tx_offs <
> tx_last_offs.
>
> Handle overlapping TCP retransmits in tcp_stream_rx() and return -1
> when offset + len exceeds sizeof(rxbuf) so tcp_rx_user_data() aborts
> with TCP_RST. Derive unread = rx_bytes - data_read in
> tcp_stream_on_rcv_nxt_update(), reset the stream if unread exceeds
> sizeof(rxbuf), reject cmd_size > FASTBOOT_COMMAND_LEN, ensure txbuf is
> NUL-terminated, and clamp tcp_stream_tx() copies to maxlen.
>
> Fixes: 443d319180a6 ("net: add fastboot TCP support")
> Fixes: bf962de97c37 ("net/tcp: improve tcp framework, use better state machine")
> Signed-off-by: George Kola <georgekola@google.com>
> ---
>   net/fastboot_tcp.c | 68 ++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 54 insertions(+), 14 deletions(-)
>
> diff --git a/net/fastboot_tcp.c b/net/fastboot_tcp.c
> index b9b4f707b1..aa2dcb1443 100644
> --- a/net/fastboot_tcp.c
> +++ b/net/fastboot_tcp.c
> @@ -25,8 +25,19 @@ static void tcp_stream_on_rcv_nxt_update(struct
> tcp_stream *tcp, u32 rx_bytes)
>   	__be64	len_be;
>   	char	saved;
>   	int	fastboot_command_id, len;
> +	u32	unread;
>
> -	if (!data_read && rx_bytes >= handshake_length) {
> +	if (rx_bytes <= data_read)
> +		return;
> +	unread = rx_bytes - data_read;
> +	if (unread > sizeof(rxbuf)) {
> +		tcp_stream_reset(tcp);
> +		return;
> +	}
> +
> +	if (!data_read) {
> +		if (unread < handshake_length)
> +			return;
>   		if (memcmp(rxbuf, handshake, handshake_length)) {
>   			printf("fastboot: bad handshake\n");
>   			tcp_stream_close(tcp);
> @@ -38,18 +49,22 @@ static void tcp_stream_on_rcv_nxt_update(struct
> tcp_stream *tcp, u32 rx_bytes)
>   		memcpy(txbuf, handshake, handshake_length);
>
>   		data_read += handshake_length;
> -		rx_bytes -= handshake_length;
> -		if (rx_bytes > 0)
> -			memmove(rxbuf, rxbuf + handshake_length, rx_bytes);
> +		unread -= handshake_length;
> +		if (unread > 0)
> +			memmove(rxbuf, rxbuf + handshake_length, unread);
>   		return;
>   	}
>
> -	if (rx_bytes < sizeof(u64))
> +	if (unread < sizeof(u64))
>   		return;
>
>   	memcpy(&cmd_size, rxbuf, sizeof(u64));
>   	cmd_size = __be64_to_cpu(cmd_size);
> -	if (rx_bytes < sizeof(u64) + cmd_size)
> +	if (cmd_size > FASTBOOT_COMMAND_LEN) {
> +		tcp_stream_close(tcp);
> +		return;
> +	}
> +	if (unread < sizeof(u64) + cmd_size)
>   		return;
>
>   	saved = rxbuf[sizeof(u64) + cmd_size];
> @@ -60,6 +75,7 @@ static void tcp_stream_on_rcv_nxt_update(struct
> tcp_stream *tcp, u32 rx_bytes)
>   			     strncmp("OKAY", txbuf + sizeof(u64), 4) == 0);
>   	rxbuf[sizeof(u64) + cmd_size] = saved;
>
> +	txbuf[sizeof(txbuf) - 1] = '\0';
>   	len = strlen(txbuf + sizeof(u64));
>   	len_be = __cpu_to_be64(len);
>   	memcpy(txbuf, &len_be, sizeof(u64));
> @@ -68,25 +84,49 @@ static void tcp_stream_on_rcv_nxt_update(struct
> tcp_stream *tcp, u32 rx_bytes)
>   	tx_last_len = len + sizeof(u64);
>
>   	data_read += sizeof(u64) + cmd_size;
> -	rx_bytes -= sizeof(u64) + cmd_size;
> -	if (rx_bytes > 0)
> -		memmove(rxbuf, rxbuf + sizeof(u64) + cmd_size, rx_bytes);
> +	unread -= sizeof(u64) + cmd_size;
> +	if (unread > 0)
> +		memmove(rxbuf, rxbuf + sizeof(u64) + cmd_size, unread);
>   }
>
>   static int tcp_stream_rx(struct tcp_stream *tcp, u32 rx_offs, void
> *buf, int len)
>   {
> -	memcpy(rxbuf + rx_offs - data_read, buf, len);
> +	int orig_len = len;
> +	u32 offset;
> +
> +	if (len < 0)
> +		return -1;
> +	if (rx_offs < data_read) {
> +		u32 skip = data_read - rx_offs;
> +
> +		if ((u32)len <= skip)
> +			return orig_len;
> +		buf = (char *)buf + skip;
> +		len -= skip;
> +		rx_offs = data_read;
> +	}
> +
> +	offset = rx_offs - data_read;
> +	if (offset > sizeof(rxbuf) ||
> +	    (size_t)len > sizeof(rxbuf) - offset)
> +		return -1;
>
> -	return len;
> +	memcpy(rxbuf + offset, buf, len);
> +
> +	return orig_len;
>   }
>
>   static int tcp_stream_tx(struct tcp_stream *tcp, u32 tx_offs, void
> *buf, int maxlen)
>   {
> -	/* by design: tx_offs >= tx_last_offs */
> -	if (tx_offs >= tx_last_offs + tx_last_len)
> +	u32 avail;
> +
> +	if (maxlen <= 0 || tx_offs < tx_last_offs ||
> +	    tx_offs - tx_last_offs >= tx_last_len)
>   		return 0;
>
> -	maxlen = tx_last_offs + tx_last_len - tx_offs;
> +	avail = tx_last_len - (tx_offs - tx_last_offs);
> +	if ((u32)maxlen > avail)
> +		maxlen = avail;
>   	memcpy(buf, txbuf + (tx_offs - tx_last_offs), maxlen);
>
>   	return maxlen;


