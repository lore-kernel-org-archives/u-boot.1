Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA963C5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 19:57:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37ACA81FEE;
	Fri,  6 Jun 2025 21:57:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K6PZzjAR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09D5E82977; Fri,  6 Jun 2025 21:57:01 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0F2C81F0D
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 21:56:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a51d552de4so1392992f8f.0
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 12:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749239818; x=1749844618; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:subject:cc:to:from:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vY/7HB1YXWIndUBf6dBJWi63zQa44cW1TBXM4yvxV2w=;
 b=K6PZzjARwtj3levQaunOImrtv9GccQYPXY9JaJBWf837fn/Jka+5lSfTuva44uBi9E
 ecgFW9o5Om4LlR4KCpEbug7cgSchYY6qcPQ+sTeNsGbn1E2mblaulJ1/hehJmg2CJLll
 XL76cF+nunkoTeN6XzeMXLJU5UnQKBx82AjWBLQx9uTwRUpxSH12fHi97vdSCI0PB6qq
 Bt0CVrexHPHkow//gCJZw4i7ECAri5C21xn4PH7PayMml+I0MK2wrt6xZfTqXzZdCk19
 x5let0CLHLVHvoXnTForWmUK+9g3shZRwrNQv/1J2JLjbzy8A2kDwOoYJ1sk4b+Clgfc
 vt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749239818; x=1749844618;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:subject:cc:to:from:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vY/7HB1YXWIndUBf6dBJWi63zQa44cW1TBXM4yvxV2w=;
 b=ukPrdQmJY8xfBABcQ3DePrOAJbd8nekoynz5fO8D39ublzdInkL6IF14rMk7y+8dvW
 xeL2DSIcmaQDgsN4D+yQojfRmXfRhkhMs+sJciP9WzknuElkl0kpwtgCghyriCXCSV+E
 Abm6bTBCV+ADNK13eov6RDDn09LoQfZekVaPAistTF7RUKaEwIUnYRFtKsdMur4eI4Ma
 BOZR6TsS28xWAPmVp2PpHnVs9OFj1WMQZ6mRn4tdRW0LwdN6Br5lPGfk/aIQmvXeuOeA
 uJcTesabyKPMJEeV4YW4v5PCzCs7ScADVpXtN8pVoYKd1/N9Qsi2pdGj9+vXqjbcoLEY
 dp8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFboJAsMOXRgF5LXdlwRNWILWbtkFYAToA+DM+IzGY9tnIJ61dqaQlDpPmNOGTUwoTqPVhnrI=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1mPD550A6Js3YWMGIHuIa/NA61Zik878Ptyv+ohy4VbcDg3c1
 05oG7CJqm5Hc0wjjdI6chuJ9/TUNs4yzRAEmyKPckv4esleKzFiwFAffdZcUtQ==
X-Gm-Gg: ASbGnctrcnwPTwoOFHg8zhxbekTHGi+FmzE99uVzRzff1t3NtaWArm257x2MFArsaQj
 lqEK8GJtKA6GrC8FIvsMdi0PHWBadydLlMU9m4A+oG3wz7BYA/RHrzkxDeGUX9rZzyMDxKrkIjH
 MCF268cQcGXu85t9e77x4FuA9Ssyu9BVzKcvRlCv8nRTDcHdpfiaMm5s8TGS4rDS6abgnRpOj1W
 kSOTlyw+Gt55PH4vy0Qzh9k1OMJ1GHSK867qeTM8/vvGSn+LFiLuP5RvGIs/1z42Apy3FyAbund
 HjX929duSG9xS1Uc6Xv3KFu8TAGKwsVK/haKyAfwwJ6Nps2+gpv3Mmfi3YRNNx6CgHyJX77639F
 IMheAYlA=
X-Google-Smtp-Source: AGHT+IFvKEIUn4SrRpBabvck8V+PbLXFIEh3rtL1iZTeNeeznUNulGI1yjD1f9UDTMNOEvEsOO4KKg==
X-Received: by 2002:a05:6000:430a:b0:3a4:dd02:f565 with SMTP id
 ffacd0b85a97d-3a53178497cmr3999855f8f.3.1749239818297; 
 Fri, 06 Jun 2025 12:56:58 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53243664fsm2771865f8f.65.2025.06.06.12.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 12:56:57 -0700 (PDT)
Message-ID: <68434809.050a0220.27a8f6.a476@mx.google.com>
X-Google-Original-Message-ID: <aENIB1r0YYuULd81@Ansuel-XPS.>
Date: Fri, 6 Jun 2025 21:56:55 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 3/3] drivers/net/airoha_eth: fix stalling in package
 receiving
References: <20250606194903.459732-1-mikhail.kshevetskiy@iopsys.eu>
 <20250606194903.459732-4-mikhail.kshevetskiy@iopsys.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250606194903.459732-4-mikhail.kshevetskiy@iopsys.eu>
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

On Fri, Jun 06, 2025 at 10:49:03PM +0300, Mikhail Kshevetskiy wrote:
> ARCH_DMA_MINALIGN is 64 for ARMv7a/ARMv8a architectures, but RX/TX
> descriptors are 32 bytes long. So they may not be aligned on an
> ARCH_DMA_MINALIGN boundary. In case of RX path, this may cause the
> following problem
> 
> 1) Assume that a packet has arrived and the EVEN rx descriptor has been
>    updated with the incoming data. The driver will invalidate and check
>    the corresponding rx descriptor.
> 
> 2) Now suppose the next descriptor (ODD) has not yet completed.
> 
>    Please note that all even descriptors starts on 64-byte boundary,
>    and the odd ones are NOT aligned on 64-byte boundary.
> 
>    Inspecting even descriptor, we will read the entire CPU cache line
>    (64 bytes). So we read and sore in СЗГ cache also the next (odd)
>    descriptor.
> 
> 3) Now suppose the next packet (for the odd rx descriptor) arrived
>    while the first packet was being processed. So we have new data
>    in memory but old data in cache.
> 
> 4) After packet processing (in arht_eth_free_pkt() function) we will
>    cleanup the descriptor and put it back to rx queue.
> 
>    This will call flush_dcache_range() function for the even descriptor,
>    so the odd one will be flushed as well (it is in the same cache line).
>    So the old data will be written to the next rx descriptor.
> 
> 5) We get a freeze. The next descriptor is empty (so the driver is
>    waiting for packets), but the hardware will continue to receive
>    packets on other available descriptors. This will continue until
>    the last available rx descriptor is full. Then the hardware will
>    also freeze.
> 
> The problem will be solved if the previous descriptor will be put back
> to the queue instead of the current one.
> 
> If the current descriptor is even (starts on a 64-byte boundary),
> then putting the previous descriptor to the rx queue will affect
> the previous cache line. To be 100% ok, we must make sure that the
> previous and the one before the previous descriptor cannot be used
> for receiving at this moment.
> 
> If the current descriptor is odd, then the previous descriptor is on
> the same cache line. Both (current and previous) descriptors are not
> currently in use, so issue will not arrise.
> 
> WARNING: The following restrictions on PKTBUFSRX must be held:
>   * PKTBUFSRX is even,
>   * PKTBUFSRX >= 4.
> 
> The bug appears on 32-bit airoha platform, but should be present on
> 64-bit as well.
>

Thanks a lot for bisecting this! I had indded some report of the driver
getting stuck sometime but I had them sorted by making the CPU IDX
handling more dynamic (by reading the register every time, maybe this
was I was indirectly invalidating cache???)

Anyway will test if this works correctly on an7581 and then I will add
my ack tag.

> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/net/airoha_eth.c | 35 ++++++++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
> index e8565be9b3c..d168dda1b62 100644
> --- a/drivers/net/airoha_eth.c
> +++ b/drivers/net/airoha_eth.c
> @@ -392,13 +392,14 @@ static int airoha_fe_init(struct airoha_eth *eth)
>  	return 0;
>  }
>  
> -static void airoha_qdma_reset_rx_desc(struct airoha_queue *q, int index,
> -				      uchar *rx_packet)
> +static void airoha_qdma_reset_rx_desc(struct airoha_queue *q, int index)
>  {
>  	struct airoha_qdma_desc *desc;
> +	uchar *rx_packet;
>  	u32 val;
>  
>  	desc = &q->desc[index];
> +	rx_packet = net_rx_packets[index];
>  	index = (index + 1) % q->ndesc;
>  
>  	dma_map_single(rx_packet, PKTSIZE_ALIGN, DMA_TO_DEVICE);
> @@ -420,7 +421,7 @@ static void airoha_qdma_init_rx_desc(struct airoha_queue *q)
>  	int i;
>  
>  	for (i = 0; i < q->ndesc; i++)
> -		airoha_qdma_reset_rx_desc(q, i, net_rx_packets[i]);
> +		airoha_qdma_reset_rx_desc(q, i);
>  }
>  
>  static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
> @@ -444,10 +445,14 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
>  			RX_RING_SIZE_MASK,
>  			FIELD_PREP(RX_RING_SIZE_MASK, ndesc));
>  
> +	/*
> +	 * See arht_eth_free_pkt() for the reasons used to fill
> +	 * REG_RX_CPU_IDX(qid) register.
> +	 */
>  	airoha_qdma_rmw(qdma, REG_RX_RING_SIZE(qid), RX_RING_THR_MASK,
>  			FIELD_PREP(RX_RING_THR_MASK, 0));
>  	airoha_qdma_rmw(qdma, REG_RX_CPU_IDX(qid), RX_RING_CPU_IDX_MASK,
> -			FIELD_PREP(RX_RING_CPU_IDX_MASK, q->ndesc - 1));
> +			FIELD_PREP(RX_RING_CPU_IDX_MASK, q->ndesc - 3));
>  	airoha_qdma_rmw(qdma, REG_RX_DMA_IDX(qid), RX_RING_DMA_IDX_MASK,
>  			FIELD_PREP(RX_RING_DMA_IDX_MASK, q->head));
>  
> @@ -906,6 +911,7 @@ static int arht_eth_free_pkt(struct udevice *dev, uchar *packet, int length)
>  	struct airoha_qdma *qdma = &eth->qdma[0];
>  	struct airoha_queue *q;
>  	int qid;
> +	u16 prev, pprev;
>  
>  	if (!packet)
>  		return 0;
> @@ -913,13 +919,24 @@ static int arht_eth_free_pkt(struct udevice *dev, uchar *packet, int length)
>  	qid = 0;
>  	q = &qdma->q_rx[qid];
>  
> -	dma_map_single(packet, length, DMA_TO_DEVICE);
> -
> -	airoha_qdma_reset_rx_desc(q, q->head, packet);
> +	/*
> +	 * Due to cpu cache issue the airoha_qdma_reset_rx_desc() function
> +	 * will always touch 2 descriptors:
> +	 *   - if current descriptor is even, then the previous and the one
> +	 *     before previous descriptors will be touched (previous cacheline)
> +	 *   - if current descriptor is odd, then only current and previous
> +	 *     descriptors will be touched (current cacheline)
> +	 *
> +	 * Thus, to prevent possible destroying of rx queue, only (q->ndesc - 2)
> +	 * descriptors might be used for packet receiving.
> +	 */
> +	prev  = (q->head + q->ndesc - 1) % q->ndesc;
> +	pprev = (q->head + q->ndesc - 2) % q->ndesc;
> +	q->head = (q->head + 1) % q->ndesc;
>  
> +	airoha_qdma_reset_rx_desc(q, prev);
>  	airoha_qdma_rmw(qdma, REG_RX_CPU_IDX(qid), RX_RING_CPU_IDX_MASK,
> -			FIELD_PREP(RX_RING_CPU_IDX_MASK, q->head));
> -	q->head = (q->head + 1) % q->ndesc;
> +			FIELD_PREP(RX_RING_CPU_IDX_MASK, pprev));
>  
>  	return 0;
>  }
> -- 
> 2.47.2
> 

-- 
	Ansuel
