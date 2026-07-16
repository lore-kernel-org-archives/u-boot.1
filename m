Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DA2C4450E
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 11:55:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0244A84CBC;
	Thu, 16 Jul 2026 13:55:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="yodbcftJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8121584CC4; Thu, 16 Jul 2026 13:55:24 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEE8E84CA3
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 13:55:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a79d=FK=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1784202920;
 bh=xuAZEIozX39CslIC3m+BRG3BQyixodt/+qBst7EE9/Q=;
 b=yodbcftJ7DpBJtNfOcDd/C+V29ZPzTL3A6yg/kmgGwdwd5nWuY3jYRV4/lxP8w5MU4cgH7XMD
 /2t0cT1x25ixZAIMajVI2prU6Bl8brU0W8lk9OMyB/N3te6AqcoNXUOrzN7jrq5fuE1IXdjvHHq
 ylvxg8l5QSTTW6QRJr8lM+GxgJ1BopUl1Q8terq9IvEWAmnqYDhGZ3VEjAnPMcQ3t70fH+k7qO3
 BExPwvwm6igGuHlObS9tsBuNDhuC3vZOiqQ3JHGhutTRT2gfzaihKUmFlJypeqEIt15s7xAb+Qh
 H1fgV9jqHYScSu3Ql8UhLSx2dR/e2arSfrLxRNJOeScQ==
X-Forward-Email-ID: 6a58c6a6e6d4cb6492957b5d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.11.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <d170674c-360e-400c-b263-a35aab640d71@kwiboo.se>
Date: Thu, 16 Jul 2026 13:55:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boot: image-fdt: downgrade -EINVAL reservation failure to
 debug
To: "Joseph Guo (OSS)" <qijian.guo@oss.nxp.com>,
 Joseph Guo <qijian.guo@nxp.com>, Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Randolph Sapp <rs@ti.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260713-downgrade-v1-1-183a2300741b@nxp.com>
 <e1a26574-4f7d-46f0-b757-55f419df326b@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <e1a26574-4f7d-46f0-b757-55f419df326b@gmail.com>
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

Hi Joseph and Emanuele,

On 7/16/2026 10:25 AM, Emanuele Ghidoli wrote:
> 
> 
> On 7/13/26 10:45, Joseph Guo wrote:
>> When boot_fdt_handle_region() attempts to reserve a DTS reserved-memory
>> region via lmb_alloc_mem(), it may receive -EINVAL if the region's
>> physical address falls outside the LMB-managed memory range (i.e.
>> below PHYS_SDRAM on platforms where U-Boot does not manage the lower
>> DRAM window).
>>
>> A typical example is platforms like i.MX95 where PHYS_SDRAM starts at
>> 0x90000000, but remoteproc/rpmsg carveouts (vdev vrings, vdev buffer,
>> resource table) are placed at 0x88xxxxxx by hardware convention. Those
>> addresses are unreachable by U-Boot's allocator anyway, so failing to
>> mark them reserved has no practical consequence -- U-Boot will never
>> accidentally place the initrd or FDT blob there.
>>
>> Printing ERROR for a condition that is harmless and expected on many
>> platforms is misleading. Downgrade the -EINVAL case to debug() to
>> suppress the spurious output while preserving full visibility under
>> DEBUG/log builds.
>>
>> Real failures (e.g. -EEXIST from an overlapping reservation) continue
>> to be reported as ERROR.

I sent a similar patch 2-3 weeks ago [1], and was planning to send a v2
that also change lmb_free() to return -EINVAL to also catch the free
scenario.

[1] https://patch.msgid.link/20260627204851.1151419-1-jonas@kwiboo.se/

Regards,
Jonas

>>
>> Fixes: 623f6c5b6ab7 ("boot: image-fdt: free old dtb reservations")
>> Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
>> ---
>>  boot/image-fdt.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
>> index 9e0e0f93edd34ae9056926883b1a802858e179d9..2175fa338f55110862100fa9f491a0957e85ce56 100644
>> --- a/boot/image-fdt.c
>> +++ b/boot/image-fdt.c
>> @@ -95,6 +95,9 @@ static void boot_fdt_handle_region(u64 addr, u64 size, u32 flags, bool free)
>>  		debug("   %s fdt memory region: addr=%llx size=%llx flags=%x\n",
>>  		      free ? "freed" : "reserved", (unsigned long long)addr,
>>  		      (unsigned long long)size, flags);
>> +	} else if (ret == -EINVAL) {
>> +		debug("   skipping fdt memory region outside LMB range (addr=%llx size=%llx flags=%x)\n",
>> +		      (unsigned long long)addr, (unsigned long long)size, flags);
>>  	} else {
>>  		printf("ERROR: %s fdt memory region failed (addr=%llx size=%llx flags=%x): %ld\n",
>>  		       free ? "freeing" : "reserving", (unsigned long long)addr,
>>
>> ---
>> base-commit: 6741b0dfb41dc82a284ab1cff4c58af6ef2f3f9c
>> change-id: 20260713-downgrade-f8319ab2d75b
>>
>> Best regards,
> 
> Hi Joseph,
> 
> Tested on Toradex Aquila iMX95, which has reserved-memory regions for
> the Cortex-M7 (vrings, vdev buffer, resource table) below PHYS_SDRAM.
> The spurious ERROR messages are gone and boot is unaffected.
> 
> Kind regards,
> Emanuele
> 
> Tested-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

