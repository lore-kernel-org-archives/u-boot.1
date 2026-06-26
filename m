Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF81CDE008
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 00:32:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB2DA8495E;
	Fri, 26 Jun 2026 02:32:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="NUiLj+Pd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F23AB8496E; Fri, 26 Jun 2026 02:32:15 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74CA9847C8
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 02:32:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=6af6=EW=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1782433932;
 bh=y2duzYA6X95VW0hY9Wt47M9U7hMBym+/dH9Sbzao1Lg=;
 b=NUiLj+PdAZEWX1KOCYVbBalsa5F9I4d2xU7lOBatv83E6naFkcGzoVx6mLt4vuUI3xu/B94ij
 h9LlbzEQAN7IQsr+cdndPwbPVr8EH0u9fqQJcRyZu+RF6eD6VsHWhQpep0O2wEgNc/Nns8HiTjV
 yUzntHOy8BKkUtpnI0t/S3rtts+70L/LCM8l6kfDCy1WYm/Ih0OMVEwpgho/hboyuBl0eks0ydH
 Rug/k2Xy8zaHkZYEdqqH83EkX1B0THU0Yy/f+Ubz54z4rMZKPp4D4rFwzrPi6MSeyIM7WbT1QCV
 dEwtTq//96hg/+LF/7hy8mqbcWgThUxl33UGzdTifPnA==
X-Forward-Email-ID: 6a3dc88876bdf7c89988ffe7
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.9.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <a4e4e3c3-0236-4764-abba-cb34e7fd0200@kwiboo.se>
Date: Fri, 26 Jun 2026 02:32:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/7] Relocate U-Boot in the last bank
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: quentin.schulz@cherry.de, marek.vasut+renesas@mailbox.org,
 anshuld@ti.com, sjg@chromium.org, christophe.leroy@csgroup.eu,
 u-boot@lists.denx.de
References: <20260617074846.84362-1-ilias.apalodimas@linaro.org>
 <178240070996.3860609.12716856774955880596.b4-ty@konsulko.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <178240070996.3860609.12716856774955880596.b4-ty@konsulko.com>
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

Hi,

On 6/25/2026 5:18 PM, Tom Rini wrote:
> On Wed, 17 Jun 2026 10:48:18 +0300, Ilias Apalodimas wrote:
> 
>> There was a discussion recently on the mailing lists regarding our
>> management of memory above ram_top [0]. The tl;dr is that we have two problems.
>>
>> The first one is that U-Boot always relocates to the top of the first available
>> bank unless there's special board code to sidestep that. The second is we don't
>> successfully deal with devices that can only do 32-bit DMA.
>>
>> [...]
> 
> Applied to u-boot/next, thanks!
> 
> [1/7] treewide: move bi_dram[] from bd to gd
>       commit: 1174c99ab421168221be372bd83a4143bf5f167d
> [2/7] common: move ram_base calculation to independent INITCALL()
>       commit: 15b35e4289e11f1ab201701dfb6dc0232b30be48
> [3/7] common: Clean up setup_dest_addr()
>       commit: 0943f107ce4adb47d4b01c06e046dce130a1de50
> [4/7] rpi: Add a local get_effective_memsize()
>       commit: d19d9e1c064b6c782959d1da7bddf1e9da1c55d4
> [5/7] common: Add an option to relocate on ram top
>       commit: 55a34217698491cc0bb8d53d630644dc8756629c

Ilias pointed out on IRC that Rockchip boards may have been affected by
this series now being merged, and where correct.

The move of dram_init_banksize() before setup_ram_config() currently
breaks Rockchip boards in next, due to gd->ram_top now being 0 when
Rockchip variant of dram_init_banksize() is called.

DRAM banks on a RK3568 8 GiB board (RK ATAGS not used) using next:

  DRAM bank   = 0x0000000000000000
  -> start    = 0x0000000000200000
  -> size     = 0xffffffffffe00000
  DRAM bank   = 0x0000000000000001
  -> start    = 0x0000000100000000
  -> size     = 0x0000000100000000

expected banks prior to this merge:

  DRAM bank   = 0x0000000000000000
  -> start    = 0x0000000000200000
  -> size     = 0x00000000efe00000
  DRAM bank   = 0x0000000000000001
  -> start    = 0x0000000100000000
  -> size     = 0x0000000100000000

'out of memory' errors are also reported because of the bad bank size:

  Core:  632 devices, 33 uclasses, devicetree: separate
  out of memory
  ERROR: Out of memory
  MMC:   mmc@fe2b0000: 1, mmc@fe310000: 0

I am also seeing following, not sure it is related or a different issue:

  ERROR: reserving fdt memory region failed (addr=10f000 size=100 flags=2): -22

Current logic in dram_init_banksize() require the final gd->ram_top to
fully function, hopefully we can find a workaround or try to rework the
affected code instead of having to do a partial revert.

Regards,
Jonas

> [6/7] configs: Enable RELOC_ADDR_TOP on arm64 QEMU
>       commit: aefd4a769bb6727978c408ff24b93ba9047d535d
> [7/7] doc: Add a warning about using RELOC_ADDR_TOP
>       commit: fb537c85bca0e3d29a62fe119181bf1744b8c91a

