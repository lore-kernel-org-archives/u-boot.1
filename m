Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCAE606A32A
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 13:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SngUHZvB;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hOhCEV1K
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF1C74066C;
	Sun, 22 Nov 2026 13:21:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dKA0EnIZpLCv; Sun, 22 Nov 2026 13:21:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0EAF340642
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795353711;
	b=o3g/HPvzLDd62xbkeb7McnxB9CD3LS+dorojhKq34u6Wb4VW5CRpbsdsjkvk2CuZYtbG
	 BQWbBcJj/DBlbcGix4r+V9ZGX/ZwqGr0zQQC1NS7c9Q3mTZfIdviNElxaIw4atHTXfdgr
	 mA8Eo3jwCuidAOw+EzHu6niPUrWyTtlDscgVc0vEYuyjUZrMCQeo2DsuMjzFipJwRyekE
	 XxRXu970QcgPviH7RSDXzkEljyWvFhb+iBfed4CiHMPPCwyCcG0uE+jyADCd8bL+vi5L6
	 djcXCYs/P1/7ghWKh8Mtu88OWGNQuHTktZZ/9VgWIsTerOGncahhqzujAqB73WOF8Rw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795353711;
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
	bh=KtvQ7ppk+q9iwTDW695Mq5yv10RqvEJSk6gKt2SgTXM=;
	b=C7GQJ+un/02BpuOMKUjs7UgNI7Bom35unpK6MXXTiNLkN4Cl+sdXGTYuohoo1Sg5kC3i
	 pVnJaAPBREMt6RFCrvNIJruaMdGt9GljRkR6o5OHHHzStdQhXQfSe6U5j48c3o0yVLky4
	 hYNSz1t6NaLAdaswQ9XOuAF39aLgflHMgHdrChz2+0G6+xKpP0iqC4gVX1HHhS3LdZhUD
	 BUx5C+tiWIVUVvTAXfTUEhttLfPoUZfFOPgEn5Dac2O4N/CNdJ7z6rhHS54cTGHKCMDnC
	 Y10Bf8Qk3oZ+1V+UHrLNkSZABcIcl8pR/yOS55z8D7rf19i1Y2Tt74enT6pexvWNauQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795353711;
	bh=KtvQ7ppk+q9iwTDW695Mq5yv10RqvEJSk6gKt2SgTXM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SngUHZvB/M2tQOQun28vd+sbk+5CSMpUn8gS3p6/Dk6To1Fh+3GUWGCisln6e5xbz
	 umpJrKCVDagDuSF5fgwjOmsMDTIegk35f9UQGgF3Nd+ym8EdkZVkaj8DDAz+dJ9oqf
	 6OI5FcO9t/u6O6IysAVwEPxYitoLMgT5cw+6z3p3u7fx/ku+vQYkhaDunNKmdNVq+R
	 psQficx3Xm+puh4NgeIAxJJfcwLvr3cLZsrHAVtk4rhJ+QwRMOuzNNJhh8gM0r0eV+
	 HxKgfJUG0YkM9srzgRZRXmPIB1rjvGE7R13nYBgjtif0IgKsgguk27OUDQSRUcrl/q
	 OJhMZgxI6mg6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0EAF340642;
	Sun, 22 Nov 2026 13:21:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1410E260
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 06:24:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 04AB460619
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 06:24:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mZDxT7o5y3GH for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 06:24:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 661BC6060E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com;
 envelope-from=sycamoremoon376@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=hOhCEV1K
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com
 [IPv6:2607:f8b0:4864:20::1331])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 661BC6060E
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 06:24:03 +0000 (UTC)
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-385d8a00598so2926981eec.1
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 22:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795328643; x=1795933443;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KtvQ7ppk+q9iwTDW695Mq5yv10RqvEJSk6gKt2SgTXM=;
 b=hOhCEV1KgcHUxTLbJcsfrwvpYS0rV3g07JrPZcK9Vo1oLKoLVgRvNM8CZiASvc8cJL
 7kZ/PfPMToKv3DSEVFtpe3zn5wlLo4QYA2HEknSnh68YbowSEufID49rP/yzAatW1CpM
 HZ1LSXS8j2C0dFhk3dYYaLMI4X9UebzT5JWQp/SUnQeT+AemhJYxjBTcUe1+9O+DNC55
 QlEAawb1jxmNAN/kcJ8j1QaVAoEzMsoR2971kTLZfFpWdhWLIz+HcNq5AMux24fLu2fn
 4WYrRo0eIHe8STj7g6Aze/HVK6l174UKTUjdwrZO56gPAI7OgNxhv5u7JXw5fc+LRA89
 fRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795328643; x=1795933443;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KtvQ7ppk+q9iwTDW695Mq5yv10RqvEJSk6gKt2SgTXM=;
 b=mo0Qz5btj6RZYJa41x4FEhexqV2RgpL2qVa2LAV5WoXjrOEzcrUiKRNUb48b7GZrKt
 UbcK0t+jZ2LBJ5BT/FNGsF9WR0o9Q7de2DBj9NI/LMGpEYPZbImQnZYU9mWhrtAaqPur
 0xg2aCWrH7kvhJkwdaKjtAhE4i0baXbpKlcIXDCmK/aKxg7IhMkzCQBtfJRA0lAkNCPS
 oH3fe2b73/PITT2fT8RTR2bzxtqPG5XVgddVOK7mXDbw4KjRdlUGHydLXDhMsXkjN6jb
 vcUJ+kYbPW794/w3ruwLcScK0YxWQatmDnaKrbYcJK3dClc/TxI1BgrAOxg1VelDOAoq
 TkxQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFnH+a6KxUq5yUb/o7OgkSPYM7cQowu316SySiiXGcwiwKzrfqcs2YyAnpdUEokg0C/io/tPJA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/eEoTkE8h77fs6JQTLzFm8WRDdPSLtD94eS0ez0QeJhrs9r043
 sdEi31S/ANANb17WGXFvhniMD/GE3mZEOBfMr7JX2vX+HKfkWD8JtjN0
X-Gm-Gg: AZFdTZdCQEDZzV8w3gbj0LH6AKRi02Kjdl9zypx73wCfaF2iPxzaMqL2SdE4jarSZxf
 +oJFzrPjbCOUT1WJzw9JtQ3s97yjSRS9RvDyTmKkmxg/PfaqX5PPWqHYSFKW+pbubitPRkaEAqR
 wfyTE6NMvKKTUcAvZAbDxESJA8pcoo0B5aIDVUPu2iAdrU692kHyvPgSO3O/OL4UJrC1hJ/WvK9
 8uGAENPbqAAJM//zRpCInJlVXNXwo3Mq/pMn3EBo4IYLQG8KEZU69gevC9HRXyqsG9d2yMP7qI0
 oPkrAXus8KRbT8vm6oTfvkhksC2rH/TAAWr2TfXWiMRZCrmxDrwlU6Ufh+e49ewbUCIgXf9I0Ps
 N5TWltCVcZMMKNbWX2Q3aKRlLEwB0kdyWMoWoaHvNH3MEZEgcqpdvxluSIlM5Z1eSrh120V4BvJ
 mTnrgs/jdiF0lLHGGIOgUIx9DIgc/3m99zGlMiQPNsECsFSnRrZf32/YpgeNZCeann3+GKPVpLs
 S2MYyH5e+TaYuBygyPFLLP/9OvubfO9WkFhm8bRVa7r105WiBucg5bOrzQVOWD1olwMrhPSatXJ
 8cA5cReSC9HcnH83/dFX8XeJuWqESA==
X-Received: by 2002:a05:7301:e0c9:b0:382:e67:9d4b with SMTP id
 5a478bee46e88-3856f850902mr7346794eec.15.1795328642542; 
 Sat, 21 Nov 2026 22:24:02 -0800 (PST)
Received: from [0.0.0.0] ([20.89.104.82]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566cd46c5sm28080760eec.11.2026.11.21.22.23.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Nov 2026 22:24:02 -0800 (PST)
Message-ID: <724e1af0-d163-412d-8f23-d019fb6f7ced@gmail.com>
Date: Sun, 22 Nov 2026 14:23:56 +0800
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
Content-Language: en-US
From: Zixian Zeng <sycamoremoon376@gmail.com>
In-Reply-To: <awB7rFETr-jVP5_b@pie>
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

Hi, Yao Zi,

Thank you for the detailed review and the follow-up clarifications. I
went through both replies against the RISC-V CMO and RVWMO specifications,
the U-Boot cache/MMIO implementations, and the Linux K1 driver used as the
reference for this port.

On 2026/11/21 00:56, Yao Zi wrote:
> On Fri, Nov 20, 2026 at 02:35:56PM +0800, Zixian Zeng wrote:
>> Add Ethernet MAC driver support for the SpacemiT K1 SoC. The driver
>> supports RGMII and RMII interfaces, synchronous transmission, and exposes
>> the integrated MDIO controller through the MDIO uclass.
>>
>> The register definitions, descriptor layout, MDIO protocol, RGMII delay
>> line handling and hardware initialisation sequences are derived from the
>> mainline Linux commit bfec6d7f2001 (net: spacemit: Add K1 Ethernet MAC).
>>
>> Link: https://lore.kernel.org/all/20250914-net-k1-emac-v12-0-65b31b398f44@iscas.ac.cn/
>> Tested-by: Dave Klotz <DaveWK225@protonmail.com>
>> Tested-by: Yixun Lan <dlan@kernel.org> # MusePi Pro
>> Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
>> ---
>>   drivers/net/Kconfig            |   1 +
>>   drivers/net/Makefile           |   1 +
>>   drivers/net/spacemit/Kconfig   |  14 +
>>   drivers/net/spacemit/Makefile  |   3 +
>>   drivers/net/spacemit/k1_emac.c | 957 +++++++++++++++++++++++++++++++++++++++++
>>   5 files changed, 976 insertions(+)
> 
> ...
> 
>> diff --git a/drivers/net/spacemit/k1_emac.c b/drivers/net/spacemit/k1_emac.c
>> new file mode 100644
>> index 00000000000..67baaade97e
>> --- /dev/null
>> +++ b/drivers/net/spacemit/k1_emac.c
>> @@ -0,0 +1,957 @@
>> +	struct regmap *apmu;
>> +	u32 apmu_offset;
>> +	phy_interface_t interface;
>> +	u32 max_speed;
>> +	u32 tx_delay_code;
>> +	u32 rx_delay_code;
>> +	struct clk clk;
>> +	struct reset_ctl reset;
>> +	struct phy_device *phy;
>> +	struct k1_emac_desc *tx_desc;
>> +	struct k1_emac_desc *rx_desc;
>> +	u8 *tx_buf;
>> +	u8 *rx_buf;
>> +	u32 tx_desc_dma;
>> +	u32 rx_desc_dma;
>> +	u32 tx_buf_dma[K1_TX_DESC_COUNT];
>> +	u32 rx_buf_dma[K1_RX_DESC_COUNT];
>> +	u32 tx_index;
>> +	u32 rx_index;
>> +	char mdio_name[MDIO_NAME_LEN];
>> +	bool rx_pending;
>> +	bool clk_enabled;
>> +	bool reset_deasserted;
>> +};
>> +
>> +static inline struct k1_emac_desc *k1_desc_at(struct k1_emac_desc *ring,
>> +					      unsigned int index)
>> +{
>> +	return &ring[index];
>> +}
> 
> Honestly saying, I don't think this function helps readability much,
> please consider removing it.

Agreed. It's only wraps array indexing, actually a bit stupid. Operation of array
indexing is readable enough, I will change caller functions to direct accesses.

>> +static inline u8 *k1_rx_buf_at(struct k1_emac_priv *priv, unsigned int index)
>> +{
>> +	return priv->rx_buf + index * K1_DMA_BUF_SIZE;
>> +}
>> +
>> +static inline u8 *k1_tx_buf_at(struct k1_emac_priv *priv, unsigned int index)
>> +{
>> +	return priv->tx_buf + index * K1_DMA_BUF_SIZE;
>> +}
>> +
>> +static void k1_desc_flush(struct k1_emac_desc *desc)
>> +{
>> +	ulong start = ALIGN_DOWN((ulong)desc, ARCH_DMA_MINALIGN);
>> +
>> +	flush_dcache_range(start, start + ARCH_DMA_MINALIGN);
>> +	/* Complete the clean before notifying the DMA engine. */
>> +	mb();
> 
> I suspect this barrier is redundant. Per the RISC-V unprivileged
> specification,
> 
>> Additionally, invalidate, clean, and flush operations are classified
>> as W or O (depending on the physical memory attributes for the
>> corresponding physical addresses) for the purposes of predecessor and
>> successor sets in FENCE instructions.
> 
> So cache management operations should be naturally ordered with the
> writel() to DMA_RX/TX_POLL_DEMAND, which carries an __iowmb(), i.e.,
> fence ow, ow.

Agreed for the current call sites. Both callers follow the descriptor
flush with an ordered writel() to the poll-demand register, whose
__iowmb() supplies the required CMO-to-MMIO ordering. I will remove the
additional mb() from the helper.

This relies on the ordering provided by those callers. If the helper
is later used in a path without that ordered MMIO write, the ordering
will need to be checked separately.

>> +}
>> +
>> +static void k1_desc_invalidate(struct k1_emac_desc *desc)
>> +{
>> +	ulong start = ALIGN_DOWN((ulong)desc, ARCH_DMA_MINALIGN);
>> +
>> +	invalidate_dcache_range(start, start + ARCH_DMA_MINALIGN);
>> +	/* Complete the invalidation before inspecting DMA-written fields. */
>> +	mb();
> 
> So is this barrier.

Agreed. The subsequent load of desc->status accesses the cache block
just invalidated. The CMO specification explicitly preserves ordering
between an invalidate and a later overlapping load, so no additional
mb() is needed here.

>> +}
> 
> [...]
> 
>> +static int k1_emac_dma32(struct udevice *dev, void *ptr, size_t size,
>> +			 u32 *address)
>> +{
>> +	dma_addr_t dma = dev_phys_to_bus(dev, virt_to_phys(ptr));
>> +
>> +	/* Both the start and the last byte must fit the 32-bit window. */
>> +	if (upper_32_bits(dma) || upper_32_bits(dma + size - 1)) {
>> +		dev_err(dev, "DMA range %#llx-%#llx is outside the 32-bit window\n",
>> +			(unsigned long long)dma,
>> +			(unsigned long long)(dma + size - 1));
>> +		return -ERANGE;
>> +	}
>> +
>> +	*address = lower_32_bits(dma);
>> +	return 0;
>> +}
> 
> This is technically correct, but I doubt whether we should do such
> carefully validation for each allocation...
> 
> I suggest selecting LMB_LIMIT_DMA_BELOW_RAW_TOP to make the DMA
> capability limitation clear instead, but it depends on you.

Yes, these buffers come from memalign() in U-Boot's malloc heap, which
k1 already places below 2 GiB. The checks are therefore defensive with
the current memory layout.

For this series, I would prefer to retain the local validation of the
translated DMA addresses. The checks only run 4+16 times during probe
and give an explicit diagnostic if the allocation or
mapping assumptions change.

The full-range check was also added following Dave's v2 feedback. I do
agree that it is not necessarily needed to make today's
low-heap allocations work.

> [...]
> 
>> +static int k1_emac_hw_init(struct k1_emac_priv *priv)
>> +{
>> +	u32 config;
>> +	int ret;
>> +
>> +	writel(0, priv->base + K1_MAC_INTERRUPT_ENABLE);
>> +	writel(0, priv->base + K1_DMA_INTERRUPT_ENABLE);
>> +	writel(0, priv->base + K1_MAC_RX_CONTROL);
>> +	writel(0, priv->base + K1_MAC_TX_CONTROL);
>> +	writel(0, priv->base + K1_DMA_CONTROL);
>> +
>> +	ret = regmap_update_bits(priv->apmu,
>> +				 priv->apmu_offset + K1_APMU_EMAC_CTRL,
>> +				 K1_APMU_AXI_SINGLE_ID, K1_APMU_AXI_SINGLE_ID);
>> +	if (ret)
>> +		return ret;
> 
> Since this syscon is backed by MMIO, I don't think there's any need to
> check for errors returned by it. This applies for other places in the
> patch, too.

Indeed, with the APMU mapping and register offsets defined by the
supported device trees, these checks mainly catch configuration errors.
I will drop the return-value checks for the MMIO register updates.

> [...]
> 
>> +static void k1_emac_prepare_rx(struct k1_emac_priv *priv, unsigned int index)
>> +{
>> +	struct k1_emac_desc *desc = k1_desc_at(priv->rx_desc, index);
>> +	u8 *buffer = k1_rx_buf_at(priv, index);
>> +
>> +	k1_buffer_flush(buffer);
> 
> Does flushing the RX buffer really make a difference on the hardware's
> behavior?

The purpose is to prevent dirty CPU cache lines from a previous use from
being written back over a later DMA receive.

The buffer is passed directly to the U-Boot network stack before
free_pkt(). In particular, ping_receive() modifies the received Ethernet,
IP and ICMP headers in place when answering an ICMP echo request, before
copying the reply to a TX buffer. Consequently, an RX buffer can contain
dirty cache lines when it is recycled.

If cache maintenance is omitted before returning the buffer,
the following sequence of events may occur:

1. The CPU modifies an old packet A, leaving the updated content A′ in a "dirty" cache line.
2. The driver hands the buffer over to the DMA, which then writes a new packet B into memory.
3. The CPU’s dirty cache line is subsequently evicted, causing A′ to be written back to the same memory location.
4. Part of the new packet B is overwritten.

The Linux RISC-V DMA implementation at the reference commit also performs
a clean for DMA_FROM_DEVICE before device ownership, followed by an
invalidate when ownership returns to the CPU. The Linux K1 driver's
dma_map_single(..., DMA_FROM_DEVICE) provides that preparation implicitly.

I therefore plan to retain the pre-DMA buffer maintenance and add a short
comment explaining the dirty-line case. The current flush supplies the
required clean as well as invalidation.

>> +	desc->control = FIELD_PREP(K1_RX_DESC_BUFFER_SIZE, K1_DMA_BUF_SIZE);
>> +	if (index == K1_RX_DESC_COUNT - 1)
>> +		desc->control |= K1_RX_DESC_END_RING;
>> +	desc->buffer_addr1 = priv->rx_buf_dma[index];
>> +	desc->buffer_addr2 = 0;
>> +	desc->status = K1_RX_DESC_OWN;
>> +}
>> +
>> +static void k1_emac_advance_rx(struct k1_emac_priv *priv)
>> +{
>> +	unsigned int index = priv->rx_index;
>> +	unsigned int first;
>> +
>> +	/*
>> +	 * Multiple 16-byte descriptors share a cache line. Do not clean that
>> +	 * line while DMA may still be updating another descriptor in it. Return
>> +	 * descriptors to DMA only after the complete cache-line-sized group has
>> +	 * been consumed.
>> +	 */
>> +	if (!((index + 1) % K1_DESCS_PER_CACHELINE)) {
>> +		first = index + 1 - K1_DESCS_PER_CACHELINE;
>> +		for (; first <= index; first++)
>> +			k1_emac_prepare_rx(priv, first);
>> +
>> +		/* Complete descriptor stores before cleaning the cache line. */
>> +		mb();
>> +		k1_desc_flush(k1_desc_at(priv->rx_desc, index));
>> +		writel(1, priv->base + K1_DMA_RX_POLL_DEMAND);
>> +	}
>> +
>> +	priv->rx_index = (index + 1) % K1_RX_DESC_COUNT;
>> +}
>> +
>> +static void k1_emac_init_rings(struct k1_emac_priv *priv)
>> +{
>> +	struct k1_emac_desc *desc;
>> +	unsigned int i;
>> +
>> +	memset(priv->tx_desc, 0, K1_TX_DESC_ALLOC_SIZE);
>> +	memset(priv->rx_desc, 0, K1_RX_DESC_ALLOC_SIZE);
>> +	memset(priv->tx_buf, 0, K1_TX_DESC_COUNT * K1_DMA_BUF_SIZE);
>> +	memset(priv->rx_buf, 0, K1_RX_DESC_COUNT * K1_DMA_BUF_SIZE);
>> +	flush_dcache_range((ulong)priv->tx_buf,
>> +			   (ulong)priv->tx_buf +
>> +			   K1_TX_DESC_COUNT * K1_DMA_BUF_SIZE);
>> +	flush_dcache_range((ulong)priv->rx_buf,
>> +			   (ulong)priv->rx_buf + K1_RX_DESC_COUNT * K1_DMA_BUF_SIZE);
> 
> Like k1_emac_prepare_rx()'s case, are these two memset() and flushes
> really useful? Does the initial buffer content visible to the NIC really
> affect its behavior?

Not useful indeed, but the reasons might be a bit different from yours:
Dropping memset() has no controversy, hardware doesn't care about value
in rx_buf and cpu doesn't care about value in tx_buf. But I think reason
of dropping flush_dcache_range() is that we already did
in k1_emac_prepare_rx() for every buffers:

> +	for (i = 0; i < K1_RX_DESC_COUNT; i++)
> +		k1_emac_prepare_rx(priv, i);

>> +	for (i = 0; i < K1_TX_DESC_COUNT; i++) {
>> +		desc = k1_desc_at(priv->tx_desc, i);
>> +		if (i == K1_TX_DESC_COUNT - 1)
>> +			desc->control = K1_TX_DESC_END_RING;
>> +		desc->buffer_addr1 = priv->tx_buf_dma[i];
>> +	}
>> +	flush_dcache_range((ulong)priv->tx_desc,
>> +			   (ulong)priv->tx_desc + K1_TX_DESC_ALLOC_SIZE);
>> +
>> +	for (i = 0; i < K1_RX_DESC_COUNT; i++)
>> +		k1_emac_prepare_rx(priv, i);
>> +	/* Complete all descriptor stores before handing the ring to DMA. */
>> +	mb();
>> +
>> +	flush_dcache_range((ulong)priv->rx_desc,
>> +			   (ulong)priv->rx_desc + K1_RX_DESC_ALLOC_SIZE);
>> +	/* Complete the clean before programming the DMA descriptor base. */
>> +	mb();
> 
> Are these two barriers() really necessary? At the point
> where k1_emac_init_rings() is called from k1_emac_start(), we haven't
> even set the ring addresses to the DMA engine. And setting so with
> writel() implies a fence wo, wo barrier, so it's impossible for the
> engine to observe the ring address before writes to the ring.

Not necessary, just as mentioned in the previous discussion regarding mb(),
the they are ordered by the overlapping address rules and writel() operations.

>> +	priv->tx_index = 0;
>> +	priv->rx_index = 0;
>> +	priv->rx_pending = false;
>> +}
> 
> [...]
> 
>> +static int k1_emac_send(struct udevice *dev, void *packet, int length)
>> +{
>> +	struct k1_emac_priv *priv = dev_get_priv(dev);
>> +	unsigned int index = priv->tx_index;
>> +	struct k1_emac_desc *desc = k1_desc_at(priv->tx_desc, index);
>> +	u8 *buffer = k1_tx_buf_at(priv, index);
>> +	ulong start;
>> +
>> +	if (length <= 0 || length > K1_DMA_BUF_SIZE)
>> +		return -EMSGSIZE;
>> +
>> +	k1_desc_invalidate(desc);
>> +	if (desc->status & K1_TX_DESC_OWN)
>> +		return -EBUSY;
>> +
>> +	memcpy(buffer, packet, length);
>> +	flush_dcache_range((ulong)buffer,
>> +			   ALIGN((ulong)buffer + length, ARCH_DMA_MINALIGN));
>> +
>> +	/* Clear stale state before handing the descriptor to DMA. */
>> +	writel(K1_DMA_STATUS_TX_DESC_UNAVAILABLE, priv->base + K1_DMA_STATUS);
>> +	/* Complete the W1C write before asking the DMA engine to resume. */
>> +	readl(priv->base + K1_DMA_STATUS);
>> +
>> +	desc->buffer_addr1 = priv->tx_buf_dma[index];
>> +	desc->buffer_addr2 = 0;
>> +	desc->control = FIELD_PREP(K1_TX_DESC_BUFFER_SIZE, length) |
>> +			K1_TX_DESC_FIRST | K1_TX_DESC_LAST;
>> +	if (index == K1_TX_DESC_COUNT - 1)
>> +		desc->control |= K1_TX_DESC_END_RING;
>> +	desc->status = K1_TX_DESC_OWN;
>> +	/* Complete descriptor stores before cleaning its cache line. */
>> +	mb();
> 
> Probably redundant barrier since RISC-V guarantees order between
> overlapping stores...

Thank you for supplying the precise PPO rule in your follow-up. I agree
that the descriptor stores and their overlapping flush do not themselves
require an intervening barrier.

But after I checked linux k1-emac source code and documents,
I noticed another similar thing which has different purpose:
Links:
https://docs.kernel.org/core-api/dma-api-howto.html#types-of-dma-mappings
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/spacemit/k1_emac.c?h=v7.4-rc3#n917

Be a bit more conservative, I prepare move it before the OWN store
to order the other descriptor fields before publishing ownership to DMA.
just as what drivers/net/dwc_eth_qos.c +1121 did

>> +	k1_desc_flush(desc);
>> +	writel(1, priv->base + K1_DMA_TX_POLL_DEMAND);
>> +
>> +	start = get_timer(0);
>> +	do {
> 
> The could would be simpler if you use a loop simply bounded by retry
> counts.

A retry-bounded loop would work if the intended limit is a number of
attempts. However, I prefer to retain an elapsed-time timeout here, thanks.

>> +		k1_desc_invalidate(desc);
>> +		/*
>> +		 * OWN is cleared before transmission finishes. Descriptor
>> +		 * unavailable is raised after DMA completes the packet and moves
>> +		 * to the next CPU-owned descriptor.
>> +		 */
>> +		if (!(desc->status & K1_TX_DESC_OWN) &&
>> +		    (readl(priv->base + K1_DMA_STATUS) &
>> +		     K1_DMA_STATUS_TX_DESC_UNAVAILABLE)) {
>> +			priv->tx_index = (index + 1) % K1_TX_DESC_COUNT;
>> +			return 0;
>> +		}
>> +		udelay(10);
>> +	} while (get_timer(start) <= K1_TX_TIMEOUT_MS);
> 
> [...]
> 
>> +static int k1_emac_recv(struct udevice *dev, int flags, uchar **packetp)
>> +{
>> +	struct k1_emac_priv *priv = dev_get_priv(dev);
>> +	struct k1_emac_desc *desc;
>> +	u32 status, length;
>> +	u8 *buffer;
>> +	unsigned int checked = 0;
>> +
>> +	if (priv->rx_pending)
>> +		return -EBUSY;
>> +
>> +	while (checked++ < K1_RX_DESC_COUNT) {
>> +		desc = k1_desc_at(priv->rx_desc, priv->rx_index);
>> +		k1_desc_invalidate(desc);
>> +		status = desc->status;
>> +		if (status & K1_RX_DESC_OWN)
>> +			return -EAGAIN;
>> +
>> +		length = FIELD_GET(K1_RX_DESC_FRAME_LEN, status);
>> +		if ((status & (K1_RX_DESC_FIRST | K1_RX_DESC_LAST)) ==
>> +		    (K1_RX_DESC_FIRST | K1_RX_DESC_LAST) &&
>> +		    !(status & K1_RX_DESC_ERRORS) && length > ETH_FCS_LEN &&
>> +		    length <= K1_DMA_BUF_SIZE) {
>> +			buffer = k1_rx_buf_at(priv, priv->rx_index);
>> +			k1_buffer_invalidate(buffer);
>> +			/* Complete invalidation before exposing the received frame. */
>> +			mb();
> 
> RISC-V guarantees that cache management operations couldn't be reordered
> with later stores,
> 
>> Specifically, if a precedes b in program order, then a will precede b
>> in the global memory order if:
>> 	a is an invalidate, clean, or flush, b is a load, and a and b
>> 	access overlapping memory addresses
> 
> Thus this mb() is redundant. Any access to buffer must be ordered after
> this invalidation.

Agreed, including the loads correction in your follow-up. The subsequent
packet loads overlap the invalidated blocks and are covered by the CMO
PPO rule. Thinks for your explanation, I will remove the mb().

> [...]
> 
>> +static void k1_emac_stop(struct udevice *dev)
>> +{
>> +	struct k1_emac_priv *priv = dev_get_priv(dev);
>> +
>> +	writel(0, priv->base + K1_MAC_INTERRUPT_ENABLE);
>> +	writel(0, priv->base + K1_DMA_INTERRUPT_ENABLE);
> 
> What's the point of resetting interrupt enable bits here? They have been
> cleared in k1_emac_hw_init(), and I don't think there's anything turning
> it back on automatically.

You're right, nice catching.

>> +	writel(0, priv->base + K1_DMA_CONTROL);
>> +	writel(0, priv->base + K1_MAC_RX_CONTROL);
>> +	writel(0, priv->base + K1_MAC_TX_CONTROL);
>> +	priv->rx_pending = false;
>> +	phy_shutdown(priv->phy);
>> +}
> 
> [...]
> 
>> +static int k1_emac_of_to_plat(struct udevice *dev)
>> +{
>> +	struct eth_pdata *pdata = dev_get_plat(dev);
>> +	struct k1_emac_priv *priv = dev_get_priv(dev);
>> +	ofnode node;
>> +	bool mdio_bound = false;
>> +	int ret;
>> +
>> +	pdata->iobase = dev_read_addr(dev);
>> +	if (pdata->iobase == FDT_ADDR_T_NONE)
>> +		return -EINVAL;
>> +
>> +	pdata->phy_interface = dev_read_phy_mode(dev);
>> +	switch (pdata->phy_interface) {
>> +	case PHY_INTERFACE_MODE_RMII:
>> +	case PHY_INTERFACE_MODE_RGMII:
>> +	case PHY_INTERFACE_MODE_RGMII_ID:
>> +	case PHY_INTERFACE_MODE_RGMII_RXID:
>> +	case PHY_INTERFACE_MODE_RGMII_TXID:
>> +		break;
>> +	default:
>> +		return -EINVAL;
> 
> Or -EOPNOTSUPP? I think this is more appropriate.

Agreed for a valid mode that this driver does not support. There is a
small distinction worth preserving: dev_read_phy_mode() also returns
PHY_INTERFACE_MODE_NA for a missing property or an unrecognized string.
I will keep -EINVAL for that case and use -EOPNOTSUPP for recognized but
unsupported interface modes.

Thanks again for taking the time to give such a thorough review!

Best regards,
Zixian
