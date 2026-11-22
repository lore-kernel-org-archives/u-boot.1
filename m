Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F239606A32A
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 13:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JhN8DuTm;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FGo2skkL
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D3AD14068C;
	Sun, 22 Nov 2026 13:21:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EU12BZtzdfj7; Sun, 22 Nov 2026 13:21:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B001740663
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795353712;
	b=ijq875CS6e2KPAWfRWGNh9ChiR4vuty2GOWGiKXnxxuyOlnIVRHitORur/42fA7NGncD
	 rUBBjxdW6aSd62iDNNerLX46UT2scCqgEKAyP+ueF46c2pKVev8CEITWqzbTlCZr6H9gw
	 0KuPUyvekXUtHEq0cqou59bpIac3LlSwWA73SUk5skkMolEbYCv3wHVn3eUWFgkrsdsXX
	 RLyIsoNdAJBJ7NlTE6HpFwFnWgc8IxgYLuJC1YKmeT5VFToLBUNHCcNziwRHIA6rBgwUw
	 1DgQh7x3Kr5Z1xXEJX/WnMZ6BsHwGA2SfV3QCApf5qXq6MrIVpaA1F9lO90M8Jwnqvg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795353712;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vJam0VPIGKQEtg1RiH94Px3ULzVQHIRE+BKsF73jWQM=;
	b=OLtmIUxFGWWXyWRSlUyYtRXG2VqyQLlRZ9gOV6O7WjPKreiGifMDFgzRRdC2vqDhrS9O
	 3qR6YPpncGBKigMg3ThIL3jsySs3zIQGiugprDYvS/QwFkl3Uw0FdQK4HJqS7SfzCkEhe
	 GFBUMjYQRR66omMEbTDA/KB6v1kDsQc2vursBndq56KRL2/FfoseRP+UHrkERjCyopsed
	 4ZBtCJfD1KF8gBQJocs0jhQj0WuK5Kf1fF5Sj9ob1K549HVxy6oq0DZqWSWl/jMsDFTTe
	 eWsun+GMKI59nwHMiy9fJfcSWPORsGh2mfz/1tOOMN74x1lsc4oh9vPX68/dLvShcUw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795353712;
	bh=vJam0VPIGKQEtg1RiH94Px3ULzVQHIRE+BKsF73jWQM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JhN8DuTmaiERyXu2GgevcyrXhrFT3eQXMQapCiqKGsnVARAc64ET4xe8DJ2t8JngX
	 oM9mSc1RUAZPJkfqjSgh3mooCUEUY4LC/4v6nWNSIcdvLaAY+j/wqyQXYVJp++aPIs
	 xCcGZ0imD+j7R0XD6tyQbcN9xvRWrhsVWH06iYh/ndsedpzBxXfRTbnD0j73N1TFlS
	 KhoCik8WS9RzGuC6oZdaPfLrIMMTlUMXtACY4l3p+0Kr5fco+C45Wu3yuqe5asmsq+
	 8tXc5Igda0yvMurQGI4tAcMARL05pmIC+SJulNYOwQjlA+NuJ6uf67seu3ODC++fbg
	 +LnzXzbM0heeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B001740663;
	Sun, 22 Nov 2026 13:21:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B511C499
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 12:37:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9BFB060619
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 12:37:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vlzGmoPxNf-i for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 12:37:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 65E1060615
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::436"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com;
 envelope-from=sycamoremoon376@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=FGo2skkL
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 65E1060615
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 12:37:37 +0000 (UTC)
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-89d6bd67045so1060290b3a.0
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 04:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795351056; x=1795955856;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vJam0VPIGKQEtg1RiH94Px3ULzVQHIRE+BKsF73jWQM=;
 b=FGo2skkLzFUy5nSNeu4WSceT0OkHwIQEbmhjSO4jimPVfnOsZIwaz7xT92rmeq00ii
 2oFVsIQaT8BceA445foHZCivpzQ7TVhP5ZiO0LYMUMN+3qaKaLjQftF5nsAEAVEW/nwl
 sEoPPcGjQoHPo3Xnedr8lpx+3g0S+aYWRrhaVyDRovBtLCkhxE9XDbSdzRIVdqrfn0vJ
 xxafD5ug8l6kV+w+CCOqsBESVGYK4HCemAxXjD78I17cw4FubtSUrEOZnoH4SxFRjTL8
 rUIZxIwJWnHGEgO0moLWbweyzWUYF7Li8cdqlVwG5bnWHUPoo+3DoESY5hTNBv4rCzjg
 QraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795351056; x=1795955856;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vJam0VPIGKQEtg1RiH94Px3ULzVQHIRE+BKsF73jWQM=;
 b=wc5CRoVoBrorNqUhOos523TnrPil2eBiWpjWFflHa0crvmvDXGyhzNsRe0/wAsJTWX
 UhxnGB3L4SHkkgbqeGrt+eSuahpsuZKTzboYLBmA8XuYICVJ6EKlAZ6NswXb7SkiLak0
 1AH+o3MehJnBRRSL1FYD75xm1qFt8RkvnX3u0mEBKhgHQCWmOB3P588gGezQ2RxM+lcN
 LOMlMBIlyumf9zamgqKw8jw4kPsH2LgF2dQwDVQbEqXtuASY+bgLz7Xic0NpOg+cqL+O
 rYp1d7wnasoE/ncPKvobQfgBiarFYz63ga4Wajjgjj827ZfCMY5NPLE1Rr6lB9Ne4cLm
 HbWA==
X-Forwarded-Encrypted: i=1;
 AL+hErGxZC1YhhAZFKuvqRAdRAEQFLpfUNOrioJA2Rb6zDKBBp5Y8bap5HrzIaatXckdPKYs8tMRYl8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/k4JAASMf4YAvXMnCHlJCs71IKl//35Z0qdb6ejg1rO6VTe8Ju
 QTKbUZXuNTbClfgk/0i2v0NkdZeDw4QE72kqsqMPXJSGt4fgUY9fLBbv
X-Gm-Gg: AZFdTZfmvQXbrVNY+5q1lAqMuzZ7mNjEqecP6G2qukoBwAiA4EW+vfF56eFo4F7gppK
 dOvtY2puRUuPAejKgGtgVjysKFrHOdMFmF86PB2itRhdEbAK3yzrj4zpDrivDd0plRDh1uSeeLm
 S2YxP69iOdS7WqMWUev5Etz2NuJ7QA+aqwbZnlD8a7MO7S4mpPgqkJg71Vlwq4rvuFilSd0aFCi
 6o2dXtRHF7/DTs1kHhzeKY6BJaZpXtG4YTwEfgij0GggD1nn+y5G7LeiELrYvATbHEi5Qa4QK7w
 eViDWWHGWbk1NC6Og+oUMO0iPG5i83/ewdZGvhsP8tPf8BMl84Z7M4ZvKM9ENWULDRcsjk+j6e9
 YVIw9iuuQN/jy9Heza+b/BK2zVJIcUJDLkQuslPugvXj/B9O865ft0Zf6cYxhsTsqxZcXCqyUg7
 HeO7ErvMA5BvsClLzRPfghKQCfybVQTZ4MiRbGWl/wrXPy2Ttvl6y/CyQZ7AsaadzMC3DhSC2Oe
 Fi6M6bTnmfjqwQkyqk7Gn2/ng15VgqKwpZqY0FPVPVJsIgUFROof4hNx/XNwvNK9eMS4VHkw3IX
 IZA1DQ+VgW8wcRlMuiok/SVrKNzCAVI=
X-Received: by 2002:a05:6a00:39a3:b0:8a0:22e0:a3ce with SMTP id
 d2e1a72fcca58-8c7db1eeaaamr6657853b3a.4.1795351056291; 
 Sun, 22 Nov 2026 04:37:36 -0800 (PST)
Received: from [0.0.0.0] ([20.89.104.82]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c873c1d71dsm3988415b3a.53.2026.11.22.04.37.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Nov 2026 04:37:35 -0800 (PST)
Message-ID: <3e0188b3-6191-4ebc-924e-e76807a11241@gmail.com>
Date: Sun, 22 Nov 2026 20:37:30 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] net: spacemit: k1: add Ethernet MAC driver
To: Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org,
 u-boot-spacemit@groups.io
Cc: Tom Rini <trini@konsulko.com>, Jerome Forissier
 <jerome.forissier@arm.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Guodong Xu <guodong.xu@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Julien Stephan <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 David Lechner <dlechner@baylibre.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Eric Chung <eric.chung@riscstar.com>,
 Yixun Lan <dlan@kernel.org>, James Hilliard <james.hilliard1@gmail.com>,
 Guodong Xu <guodong@riscstar.com>, E Shattow <e@freeshell.de>,
 Dave Klotz <DaveWK225@protonmail.com>
References: <20261120-b4-k1-emac-v3-0-120679f97b45@gmail.com>
 <20261120-b4-k1-emac-v3-1-120679f97b45@gmail.com> <awB7rFETr-jVP5_b@pie>
 <724e1af0-d163-412d-8f23-d019fb6f7ced@gmail.com> <awKjZ70AfaHI0-ky@pie>
Content-Language: en-US
From: Zixian Zeng <sycamoremoon376@gmail.com>
In-Reply-To: <awKjZ70AfaHI0-ky@pie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 22 Nov 2026 13:21:49 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Yao Zi,

On 2026/11/22 16:10, Yao Zi wrote:
> On Sun, Nov 22, 2026 at 02:23:56PM +0800, Zixian Zeng wrote:
>> Hi, Yao Zi,
>>
>> Thank you for the detailed review and the follow-up clarifications. I
>> went through both replies against the RISC-V CMO and RVWMO specifications,
>> the U-Boot cache/MMIO implementations, and the Linux K1 driver used as the
>> reference for this port.
>>
>> On 2026/11/21 00:56, Yao Zi wrote:
>>> On Fri, Nov 20, 2026 at 02:35:56PM +0800, Zixian Zeng wrote:
>>>> Add Ethernet MAC driver support for the SpacemiT K1 SoC. The driver
>>>> supports RGMII and RMII interfaces, synchronous transmission, and exposes
>>>> the integrated MDIO controller through the MDIO uclass.
>>>>
>>>> The register definitions, descriptor layout, MDIO protocol, RGMII delay
>>>> line handling and hardware initialisation sequences are derived from the
>>>> mainline Linux commit bfec6d7f2001 (net: spacemit: Add K1 Ethernet MAC).
>>>>
>>>> Link: https://lore.kernel.org/all/20250914-net-k1-emac-v12-0-65b31b398f44@iscas.ac.cn/
>>>> Tested-by: Dave Klotz <DaveWK225@protonmail.com>
>>>> Tested-by: Yixun Lan <dlan@kernel.org> # MusePi Pro
>>>> Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
>>>> ---
>>>>    drivers/net/Kconfig            |   1 +
>>>>    drivers/net/Makefile           |   1 +
>>>>    drivers/net/spacemit/Kconfig   |  14 +
>>>>    drivers/net/spacemit/Makefile  |   3 +
>>>>    drivers/net/spacemit/k1_emac.c | 957 +++++++++++++++++++++++++++++++++++++++++
>>>>    5 files changed, 976 insertions(+)
> 
> [...]
> 
>>>> +static void k1_emac_prepare_rx(struct k1_emac_priv *priv, unsigned int index)
>>>> +{
>>>> +	struct k1_emac_desc *desc = k1_desc_at(priv->rx_desc, index);
>>>> +	u8 *buffer = k1_rx_buf_at(priv, index);
>>>> +
>>>> +	k1_buffer_flush(buffer);
>>>
>>> Does flushing the RX buffer really make a difference on the hardware's
>>> behavior?
>>
>> The purpose is to prevent dirty CPU cache lines from a previous use from
>> being written back over a later DMA receive.
>>
>> The buffer is passed directly to the U-Boot network stack before
>> free_pkt(). In particular, ping_receive() modifies the received Ethernet,
>> IP and ICMP headers in place when answering an ICMP echo request, before
>> copying the reply to a TX buffer. Consequently, an RX buffer can contain
>> dirty cache lines when it is recycled.
>>
>> If cache maintenance is omitted before returning the buffer,
>> the following sequence of events may occur:
>>
>> 1. The CPU modifies an old packet A, leaving the updated content A′ in a "dirty" cache line.
>> 2. The driver hands the buffer over to the DMA, which then writes a new packet B into memory.
>> 3. The CPU’s dirty cache line is subsequently evicted, causing A′ to be written back to the same memory location.
>> 4. Part of the new packet B is overwritten.
> 
> Oh, this makes sense. Please replace flush with a clean though.

OK, do you mean using a clean-only cache operation here, or just renaming
the helper from k1_buffer_flush() to k1_buffer_flush() to reflect its purpose?
The current RISC-V implementation does not expose a public range clean API.

>> The Linux RISC-V DMA implementation at the reference commit also performs
>> a clean for DMA_FROM_DEVICE before device ownership, followed by an
>> invalidate when ownership returns to the CPU. The Linux K1 driver's
>> dma_map_single(..., DMA_FROM_DEVICE) provides that preparation implicitly.
>>
>> I therefore plan to retain the pre-DMA buffer maintenance and add a short
>> comment explaining the dirty-line case. The current flush supplies the
>> required clean as well as invalidation.
>>
>>>> +	desc->control = FIELD_PREP(K1_RX_DESC_BUFFER_SIZE, K1_DMA_BUF_SIZE);
>>>> +	if (index == K1_RX_DESC_COUNT - 1)
>>>> +		desc->control |= K1_RX_DESC_END_RING;
>>>> +	desc->buffer_addr1 = priv->rx_buf_dma[index];
>>>> +	desc->buffer_addr2 = 0;
>>>> +	desc->status = K1_RX_DESC_OWN;
>>>> +}
>>>> +
>>>> +static void k1_emac_advance_rx(struct k1_emac_priv *priv)
>>>> +{
>>>> +	unsigned int index = priv->rx_index;
>>>> +	unsigned int first;
>>>> +
>>>> +	/*
>>>> +	 * Multiple 16-byte descriptors share a cache line. Do not clean that
>>>> +	 * line while DMA may still be updating another descriptor in it. Return
>>>> +	 * descriptors to DMA only after the complete cache-line-sized group has
>>>> +	 * been consumed.
>>>> +	 */
>>>> +	if (!((index + 1) % K1_DESCS_PER_CACHELINE)) {
>>>> +		first = index + 1 - K1_DESCS_PER_CACHELINE;
>>>> +		for (; first <= index; first++)
>>>> +			k1_emac_prepare_rx(priv, first);
>>>> +
>>>> +		/* Complete descriptor stores before cleaning the cache line. */
>>>> +		mb();
>>>> +		k1_desc_flush(k1_desc_at(priv->rx_desc, index));
>>>> +		writel(1, priv->base + K1_DMA_RX_POLL_DEMAND);
>>>> +	}
>>>> +
>>>> +	priv->rx_index = (index + 1) % K1_RX_DESC_COUNT;
>>>> +}
> 
> [...]
> 
>>>> +static int k1_emac_send(struct udevice *dev, void *packet, int length)
>>>> +{
>>>> +	struct k1_emac_priv *priv = dev_get_priv(dev);
>>>> +	unsigned int index = priv->tx_index;
>>>> +	struct k1_emac_desc *desc = k1_desc_at(priv->tx_desc, index);
>>>> +	u8 *buffer = k1_tx_buf_at(priv, index);
>>>> +	ulong start;
>>>> +
>>>> +	if (length <= 0 || length > K1_DMA_BUF_SIZE)
>>>> +		return -EMSGSIZE;
>>>> +
>>>> +	k1_desc_invalidate(desc);
>>>> +	if (desc->status & K1_TX_DESC_OWN)
>>>> +		return -EBUSY;
>>>> +
>>>> +	memcpy(buffer, packet, length);
>>>> +	flush_dcache_range((ulong)buffer,
>>>> +			   ALIGN((ulong)buffer + length, ARCH_DMA_MINALIGN));
>>>> +
>>>> +	/* Clear stale state before handing the descriptor to DMA. */
>>>> +	writel(K1_DMA_STATUS_TX_DESC_UNAVAILABLE, priv->base + K1_DMA_STATUS);
>>>> +	/* Complete the W1C write before asking the DMA engine to resume. */
>>>> +	readl(priv->base + K1_DMA_STATUS);
>>>> +
>>>> +	desc->buffer_addr1 = priv->tx_buf_dma[index];
>>>> +	desc->buffer_addr2 = 0;
>>>> +	desc->control = FIELD_PREP(K1_TX_DESC_BUFFER_SIZE, length) |
>>>> +			K1_TX_DESC_FIRST | K1_TX_DESC_LAST;
>>>> +	if (index == K1_TX_DESC_COUNT - 1)
>>>> +		desc->control |= K1_TX_DESC_END_RING;
>>>> +	desc->status = K1_TX_DESC_OWN;
>>>> +	/* Complete descriptor stores before cleaning its cache line. */
>>>> +	mb();
>>>
>>> Probably redundant barrier since RISC-V guarantees order between
>>> overlapping stores...
>>
>> Thank you for supplying the precise PPO rule in your follow-up. I agree
>> that the descriptor stores and their overlapping flush do not themselves
>> require an intervening barrier.
>>
>> But after I checked linux k1-emac source code and documents,
>> I noticed another similar thing which has different purpose:
>> Links:
>> https://docs.kernel.org/core-api/dma-api-howto.html#types-of-dma-mappings
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/spacemit/k1_emac.c?h=v7.4-rc3#n917
> 
> Did you quote the wrong line? This link points to emac_change_mtu().
> I assume you're referring to the dma_wmb() at line 790.

Yes, exactly. I quoted the wrong line.

> The dma_wmb() in the Linux driver serves for different purpose. On Linux
> side, a new packet could be queued at any time, even the DMA engine is
> still working and probably accessing the ring, so it's importatnt to
> ensure TX_DESC_OWN could only be observed by the engine after other
> fields in the descriptor has been set up.
> 
> But for U-Boot, the situation seems different. Packet are transmitted
> strictly one by one, and since you disable the AUTOPOLL feature and
> poll for the DMA engine to stop (K1_DMA_STATUS_TX_DESC_UNAVAILABLE) when
> transmitting, the engine is always stopped, never polling the descriptor
> ring during setup of the descriptor, until a write to
> K1_DMA_TX_POLL_DEMAND wakes it up.
> 
> Since K1_DMA_TX_POLL_DEMAND is written with writel(), which ensures
> the descriptor setup (including K1_TX_DESC_OWN bit) becomes visible to
> the EMAC before waking the engine up, this shouldn't cause any problems.
> 
>> Be a bit more conservative, I prepare move it before the OWN store
>> to order the other descriptor fields before publishing ownership to DMA.
>> just as what drivers/net/dwc_eth_qos.c +1121 did
> 
> The case in K1's EMAC and dwc_eth_qos.c are different. It seems
> dwc_eth_qos' DMA engine keeps polling the ring when no descriptor is
> available, while in which case K1's stops.

Understood, my previous understanding was incomplete.
Thanks for the explanation, I will remove this mb() only.

>>>> +	k1_desc_flush(desc);
>>>> +	writel(1, priv->base + K1_DMA_TX_POLL_DEMAND);
>>>> +
>>>> +	start = get_timer(0);
>>>> +	do {
>>>
>>> The could would be simpler if you use a loop simply bounded by retry
>>> counts.
>>
>> A retry-bounded loop would work if the intended limit is a number of
>> attempts. However, I prefer to retain an elapsed-time timeout here, thanks.
> 
> Why? The code would look simpler with the change, like
> 
> 	for (; retry < K1_TX_TIMEOUT_MS / 10; retry++) {
> 		/* ... */
> 		udelay(10);
> 	}

Just a preference :-) I will switch to a retry-bounded loop in next revision.
With udelay(10), I will calculate the retry limit as K1_TX_TIMEOUT_MS * 1000 / 10,
which converting ms to us.

>>>> +		k1_desc_invalidate(desc);
>>>> +		/*
>>>> +		 * OWN is cleared before transmission finishes. Descriptor
>>>> +		 * unavailable is raised after DMA completes the packet and moves
>>>> +		 * to the next CPU-owned descriptor.
>>>> +		 */
>>>> +		if (!(desc->status & K1_TX_DESC_OWN) &&
>>>> +		    (readl(priv->base + K1_DMA_STATUS) &
>>>> +		     K1_DMA_STATUS_TX_DESC_UNAVAILABLE)) {
>>>> +			priv->tx_index = (index + 1) % K1_TX_DESC_COUNT;
>>>> +			return 0;
>>>> +		}
>>>> +		udelay(10);
>>>> +	} while (get_timer(start) <= K1_TX_TIMEOUT_MS);
> 
> [...]
> 

Best regards,
Zixian

