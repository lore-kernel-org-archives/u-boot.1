Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD430CE7A94
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 10:50:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C64A986BCF;
	Mon, 25 Sep 2023 12:50:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jlphxUHp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F61686BF7; Mon, 25 Sep 2023 12:50:44 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 163BE86BB2
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 12:50:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-32003aae100so4954937f8f.0
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 03:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695639041; x=1696243841; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/kERittDuwKiDsYhfiF3KqfOer67jelut2Yx/OtokLU=;
 b=jlphxUHp4cHoWb4zW3Fyf/XKeNz0pqbr85yUF1tPoHuh3lqkQjo1bhio3KX4jNGj99
 2gUS1aUdAfUgC6GJYXzVWNFehWn1uB1DlyLGa+3FdjaaEmNlHw9z7r4FerqeZAv/SaoC
 TAnxGcVF7LShzg7cai6x0O2FEbjbjJ7bXQNPBiHsOuDEd0MO6MjBnLgF65ixk1eENb9i
 spRCgKx1WKgdEOv2z1r+ZLUS6V771TlNE8eWD7A3JgzHvv/84PGjZQVXLPrEsXpWIAPo
 02ztM8X+hgSq3V4duSz8KPhy0k6TVadY4njoxj5IGnka9GkcLuSqIQx74V2eD9UpW7OQ
 BKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695639041; x=1696243841;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/kERittDuwKiDsYhfiF3KqfOer67jelut2Yx/OtokLU=;
 b=tQ2MC2AMyU7wd1D+GV3Qi2y2JTiMUBQsJtlOXNWUl1EYoU69h1rr/wyHGBytaYgosZ
 u1ueU8BUC07gbU9zLkrdhtJ01Fm35IcW9SP+ZyoopyPGHTVyKUFeL1o6ggY7PCh7g6KI
 2clgI0+8DdyzvkXp522mnLFh2k1IMChbcHrJhc72hDuBeJdro+fRLjv80gVopR7/2kCC
 UF8iBapaKqfAKId8Osfpk5ZIEehXfFICvBILIE9UXelo4La9Q2Ri2uqEGDPT9mlSxImG
 bEUVfQB0jdUxIP1ZuJE/sgnZRkr8XyBKN58YfepZ6nuMNDa1dkIF2xZ+VgPuTQycc0ZT
 HAWA==
X-Gm-Message-State: AOJu0YxIewIFHm7UMaJUPi+Yc/VNMONWoA12xUKE3t8lIlcJLOGfP48f
 BybRwushvu/zvffr5xtqlxIrOA==
X-Google-Smtp-Source: AGHT+IFdOWarSf1+H0zuZae2UIC6z/5ZTu7FItzEB4aNTWEszPe8aHRg0SZpbsKbqustvmiXJ9yWww==
X-Received: by 2002:adf:f3c3:0:b0:319:6997:9432 with SMTP id
 g3-20020adff3c3000000b0031969979432mr5738528wrp.1.1695639041440; 
 Mon, 25 Sep 2023 03:50:41 -0700 (PDT)
Received: from hera (ppp046103219117.access.hol.gr. [46.103.219.117])
 by smtp.gmail.com with ESMTPSA id
 bv19-20020a0560001f1300b0032327b70ef6sm2775688wrb.70.2023.09.25.03.50.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 03:50:41 -0700 (PDT)
Date: Mon, 25 Sep 2023 13:50:38 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: Re: [PATCH v4 1/8] net: wget: prevent overwriting reserved memory
Message-ID: <ZRFl/gKVpazitXrb@hera>
References: <20230922071119.1439482-1-masahisa.kojima@linaro.org>
 <20230922071119.1439482-2-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922071119.1439482-2-masahisa.kojima@linaro.org>
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

On Fri, Sep 22, 2023 at 04:11:12PM +0900, Masahisa Kojima wrote:
> This introduces the valid range check to store the received
> blocks using lmb. The same logic is implemented in tftp.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>  net/wget.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 73 insertions(+), 7 deletions(-)
>
> diff --git a/net/wget.c b/net/wget.c
> index 2dbfeb1a1d..a48a8cb624 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -4,16 +4,20 @@
>   * Copyright Duncan Hare <dh@synoia.com> 2017
>   */
>
> +#include <asm/global_data.h>
>  #include <command.h>
>  #include <common.h>
>  #include <display_options.h>
>  #include <env.h>
>  #include <image.h>
> +#include <lmb.h>
>  #include <mapmem.h>
>  #include <net.h>
>  #include <net/tcp.h>
>  #include <net/wget.h>
>
> +DECLARE_GLOBAL_DATA_PTR;
> +
>  static const char bootfile1[] = "GET ";
>  static const char bootfile3[] = " HTTP/1.0\r\n\r\n";
>  static const char http_eom[] = "\r\n\r\n";
> @@ -55,6 +59,29 @@ static unsigned int retry_tcp_ack_num;	/* TCP retry acknowledge number*/
>  static unsigned int retry_tcp_seq_num;	/* TCP retry sequence number */
>  static int retry_len;			/* TCP retry length */
>
> +static ulong wget_load_size;
> +
> +/**
> + * wget_init_max_size() - initialize maximum load size
> + *
> + * Return:	0 if success, -1 if fails
> + */
> +static int wget_init_load_size(void)
> +{
> +	struct lmb lmb;
> +	phys_size_t max_size;
> +
> +	lmb_init_and_reserve(&lmb, gd->bd, (void *)gd->fdt_blob);
> +
> +	max_size = lmb_get_free_size(&lmb, image_load_addr);
> +	if (!max_size)
> +		return -1;
> +
> +	wget_load_size = max_size;
> +
> +	return 0;
> +}
> +
>  /**
>   * store_block() - store block in memory
>   * @src: source of data
> @@ -63,10 +90,25 @@ static int retry_len;			/* TCP retry length */
>   */
>  static inline int store_block(uchar *src, unsigned int offset, unsigned int len)
>  {
> +	ulong store_addr = image_load_addr + offset;
>  	ulong newsize = offset + len;
>  	uchar *ptr;
>
> -	ptr = map_sysmem(image_load_addr + offset, len);
> +	if (IS_ENABLED(CONFIG_LMB)) {
> +		ulong end_addr = image_load_addr + wget_load_size;
> +
> +		if (!end_addr)
> +			end_addr = ULONG_MAX;
> +
> +		if (store_addr < image_load_addr ||
> +		    store_addr + len > end_addr) {
> +			printf("\nwget error: ");
> +			printf("trying to overwrite reserved memory...\n");
> +			return -1;
> +		}
> +	}
> +
> +	ptr = map_sysmem(store_addr, len);
>  	memcpy(ptr, src, len);
>  	unmap_sysmem(ptr);
>
> @@ -240,25 +282,39 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
>
>  			net_boot_file_size = 0;
>
> -			if (len > hlen)
> -				store_block(pkt + hlen, 0, len - hlen);
> +			if (len > hlen) {
> +				if (store_block(pkt + hlen, 0, len - hlen) != 0) {
> +					wget_loop_state = NETLOOP_FAIL;
> +					wget_fail("wget: store error\n", tcp_seq_num, tcp_ack_num, action);
> +					net_set_state(NETLOOP_FAIL);
> +					return;
> +				}
> +			}
>
>  			debug_cond(DEBUG_WGET,
>  				   "wget: Connected Pkt %p hlen %x\n",
>  				   pkt, hlen);
>
>  			for (i = 0; i < pkt_q_idx; i++) {
> +				int err;
> +
>  				ptr1 = map_sysmem(
>  					(phys_addr_t)(pkt_q[i].pkt),
>  					pkt_q[i].len);
> -				store_block(ptr1,
> -					    pkt_q[i].tcp_seq_num -
> -					    initial_data_seq_num,
> -					    pkt_q[i].len);
> +				err = store_block(ptr1,
> +					  pkt_q[i].tcp_seq_num -
> +					  initial_data_seq_num,
> +					  pkt_q[i].len);
>  				unmap_sysmem(ptr1);
>  				debug_cond(DEBUG_WGET,
>  					   "wget: Connctd pkt Q %p len %x\n",
>  					   pkt_q[i].pkt, pkt_q[i].len);
> +				if (err) {
> +					wget_loop_state = NETLOOP_FAIL;
> +					wget_fail("wget: store error\n", tcp_seq_num, tcp_ack_num, action);
> +					net_set_state(NETLOOP_FAIL);
> +					return;
> +				}
>  			}
>  		}
>  	}
> @@ -330,6 +386,7 @@ static void wget_handler(uchar *pkt, u16 dport,
>  				len) != 0) {
>  			wget_fail("wget: store error\n",
>  				  tcp_seq_num, tcp_ack_num, action);
> +			net_set_state(NETLOOP_FAIL);
>  			return;
>  		}
>
> @@ -420,6 +477,15 @@ void wget_start(void)
>  	debug_cond(DEBUG_WGET,
>  		   "\nwget:Load address: 0x%lx\nLoading: *\b", image_load_addr);
>
> +	if (IS_ENABLED(CONFIG_LMB)) {
> +		if (wget_init_load_size()) {
> +			printf("\nwget error: ");
> +			printf("trying to overwrite reserved memory...\n");
> +			net_set_state(NETLOOP_FAIL);
> +			return;
> +		}
> +	}
> +
>  	net_set_timeout_handler(wget_timeout, wget_timeout_handler);
>  	tcp_set_tcp_handler(wget_handler);
>
> --
> 2.34.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

