Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF58EEDEC50
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 13:19:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E1BD869B6;
	Wed, 13 Sep 2023 15:19:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=feathertop.org header.i=@feathertop.org header.b="h50+eWyg";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="kitAzTR2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15DF486CED; Wed, 13 Sep 2023 14:16:08 +0200 (CEST)
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com
 [64.147.123.26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D249B86983
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 14:16:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=feathertop.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tim@feathertop.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailnew.west.internal (Postfix) with ESMTP id 4BF1C2B000F5
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 08:16:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Wed, 13 Sep 2023 08:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
 h=cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm1; t=1694607360; x=1694614560; bh=Jj
 JgqsAx7FfZIPcTxwYsMDPhqcKZcRbbK5Dq7LLUuwc=; b=h50+eWygvf3SXpzltZ
 oK0bkP9csAnVcd7YpGjHIIyIB/MmKALqzmD7wgc3t4rXvn0sdhTY7xYLu+FCuQgY
 Gml8Q6PjBLIVM0Oe6lg55ctbDf6/YpBVTrb+BuFxljw+p2RNPICZW8xppRg4ReCC
 7cXqp60GLttgi8BLhaqK2xUmTCBJquJKCveGWEf0G8em2DCI42wXuVDaiKEj9CNy
 8+pycvnCIo180Kt0PsQrl7hs15nj4DIPgIt1+dzZ8BPl5/9OahMlF+DQfhr1CKkG
 rRqdcM/goNPexr/X//FT9ZggWB/KcOLB70sDFzpDB2A3oipderJAy8TJuJkawi3Y
 jqig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; t=1694607360; x=1694614560; bh=JjJgqsAx7FfZI
 PcTxwYsMDPhqcKZcRbbK5Dq7LLUuwc=; b=kitAzTR2b9ifFXIgwKp0WCLwYvfKk
 MqkKKLlFFQ5Qk81hsELGtaB99jcvkxcBmELpKM48sqEgwmeBzjld4VvYhFUAngJE
 JmZR7Ci0K9k+lwV1BbH0VTMg355nUn5lHdCkiWqzrrO9287R9B9f0H0CzbFSKctq
 MLkqxxCy2cqAppev/0xKbwHt0a2z2K4E64MBSWoPbkZpF5WNb6VhgrhGBgDpPAmc
 zB79/QsyllbbAHno3Tquc1fzscIVYANbuuX/AH/y/1xx9z3wSQrM4GSrenpzw69Q
 oUfr6xYPwZWwMSlOwWuEpbaeUOAxVL8VJmhBUSPdxR/GkL2LAWSUw1d3w==
X-ME-Sender: <xms:AKgBZVzpyQyZX_lt092_eSA5hqqkxw1yOWC46eA7csZnmtbsQq0ecg>
 <xme:AKgBZVQgZwqHhhNIbd8m8vAl7CXK0rfrRCvFFWgJjeZpIV2CXjO4NDIiQu2z7GNPR
 _8EHBVebg>
X-ME-Received: <xmr:AKgBZfWTxLHbMVaaGdpabZ8abDOhD-xePgVrVsytHVuK5V1-383tX9B-jQ9e48Z1K_cgbVcVIlwktpOO80ynq32qPGLkg-HjnRZinQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeikedghedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpegtkfffgggfhffuvfhfjgesrgdtre
 ertdefjeenucfhrhhomhepvfhimhcunfhunhhnuceothhimhesfhgvrghthhgvrhhtohhp
 rdhorhhgqeenucggtffrrghtthgvrhhnpedtueeijeeludeiteeivefhfedvhefgieffhe
 dtgeegffelfeegtdeuvdeghfefueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
 mhepmhgrihhlfhhrohhmpehtihhmsehfvggrthhhvghrthhophdrohhrgh
X-ME-Proxy: <xmx:AKgBZXiJYG6F3kRbJFmwfPLKwnYPn_VoSNXUqRdZ5viGNZTHSP6HFw>
 <xmx:AKgBZXAcgMHjShICgMWk4BWXmfoByTlFKGgWaW9u-LvcOdsSP0IzwQ>
 <xmx:AKgBZQJYP1UpFhYScsrASs4vkAmVp8kbuIFpJkt-gM-HDqdxRJMQWg>
 <xmx:AKgBZa-JR6w6ZHYtDeovFlkStK6XKSbSBNrk-VKqI-5XBlNWiDLc578QVzA>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <u-boot@lists.denx.de>; Wed, 13 Sep 2023 08:15:59 -0400 (EDT)
Message-ID: <2bd4dc8c-f8c0-97c5-f0ad-2a859c96fe5b@feathertop.org>
Date: Wed, 13 Sep 2023 22:15:57 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
From: Tim Lunn <tim@feathertop.org>
Subject: Re: PSCI: prefetch abort with Mainline linux (even with rockchip
 u-boot)
To: u-boot@lists.denx.de
References: <CA+VMnFzdObAg63NU-1iVb-oyPZi0e1wLbsQppdbYmXmisuQQZg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CA+VMnFzdObAg63NU-1iVb-oyPZi0e1wLbsQppdbYmXmisuQQZg@mail.gmail.com>
X-Mailman-Approved-At: Wed, 13 Sep 2023 15:19:35 +0200
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Jagan,

On 10/23/22 01:35, Jagan Teki wrote:
> Hi Kever and Heiko,
>
> Rockchip 32-bit SoC, like rv1126 seems to depend on PSCI to bring SMP in linux.
>
> With rockchip u-boot and Mainline U-Boot the psci in linux-next
> triggers the abort. (note that I have added rockchip_smcc and enabled
> PSCI in u-boot)
Did you ever find a solution to this? I am hitting the same issue 
building 6.1 kernel for rv1126.
> [    0.000000] Booting Linux on physical CPU 0xf00
> [    0.000000] Linux version 6.1.0-rc1-00029-gb09e57e6064a
> (j@j-ThinkPad-E14-Gen-2) (arm-linux-gnueabihf-gcc (GCC) 11.0.1
> 20210310 (experimental) [master revision
> 5987d8a79cda1069c774e5c302d5597310270026], GNU ld
>   (Linaro_Binutils-2021.03) 2.36.50.20210310) #12 SMP Sat Oct 22
> 19:44:56 IST 2022
> [    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
> [    0.000000] CPU: div instructions available: patching division code
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
> instruction cache
> [    0.000000] OF: fdt: Machine model: Edgeble Neu2 IO Board
> [    0.000000] earlycon: uart8250 at MMIO32 0xff570000 (options '')
> [    0.000000] printk: bootconsole [uart8250] enabled
> [    0.000000] Memory policy: Data cache writealloc
> [    0.000000] efi: UEFI not found.
> [    0.000000] cma: Reserved 64 MiB at 0x7c000000
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000000000000-0x000000002fffffff]
> [    0.000000]   Normal   empty
> [    0.000000]   HighMem  [mem 0x0000000030000000-0x000000007fffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000000000-0x000000007fffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000007fffffff]
> [    0.000000] psci: probing for conduit method from DT.
> [    0.000000] Bad mode in prefetch abort handler detected
> [    0.000000] Internal error: Oops - bad mode: 0 [#1] SMP ARM
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
> 6.1.0-rc1-00029-gb09e57e6064a #12
> [    0.000000] Hardware name: Generic DT based system
> [    0.000000] PC is at 0x133fd468
> [    0.000000] LR is at __invoke_psci_fn_smc+0x38/0x58
> [    0.000000] pc : [<133fd468>]    lr : [<c0eb20f0>]    psr: 600001d6
> [    0.000000] sp : c1e01e68  ip : c1e01ec0  fp : 80000200
> [    0.000000] r10: c1e01f58  r9 : 7fffffff  r8 : c1e09410
> [    0.000000] r7 : 00000000  r6 : 00000000  r5 : 00000000  r4 : 00000000
> [    0.000000] r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : 84000000
> [    0.000000] Flags: nZCv  IRQs off  FIQs off  Mode MON_32  ISA ARM
> Segment none
> [    0.000000] Control: 10c5387d  Table: 0020406a  DAC: c1e09980
> [    0.000000] Register r0 information: non-paged memory
> [    0.000000] Register r1 information: NULL pointer
> [    0.000000] Register r2 information: NULL pointer
> [    0.000000] Register r3 information: NULL pointer
> [    0.000000] Register r4 information: NULL pointer
> [    0.000000] Register r5 information: NULL pointer
> [    0.000000] Register r6 information: NULL pointer
> [    0.000000] Register r7 information: NULL pointer
> [    0.000000] Register r8 information: non-slab/vmalloc memory
> [    0.000000] Register r9 information: non-paged memory
> [    0.000000] Register r10 information: non-slab/vmalloc memory
> [    0.000000] Register r11 information: non-paged memory
> [    0.000000] Register r12 information: non-slab/vmalloc memory
> [    0.000000] Process swapper (pid: 0, stack limit = 0x(ptrval))
> [    0.000000] Stack: (0xc1e01e68 to 0xc1e02000)
> [    0.000000] 1e60:                   84000000 00000000 00000000
> 00000000 00000000 00000000
> [    0.000000] 1e80: 00000000 00000000 c1e09410 7fffffff c1e01f58
> 80000200 c1e01ec0 c1e01e68
> [    0.000000] 1ea0: c0eb20f0 133fd468 600001d6 ffffffff c1e09980
> 00000000 c20891c0 c1b1c168
> [    0.000000] 1ec0: 00000000 00000000 00000000 00000000 c1e01edc
> 00000000 c20891c0 c1245ac8
> [    0.000000] 1ee0: ff8005a8 00000000 c1d2fca0 00000000 eefea2fc
> c1c93594 eefea2fc c1e09980
> [    0.000000] 1f00: c20891c0 c1b1c168 c1e09410 c1c93a10 eefea2fc
> c1c939d8 c1d2fbdc 00000000
> [    0.000000] 1f20: 7fffffff c1caf854 c1e0afa0 c1c04c44 00000000
> c1e01f4c c1e01f50 00000000
> [    0.000000] 1f40: c1e09980 c198cfec c1e01f9c 00000000 80000000
> c1e09980 ffffffff ffffffff
> [    0.000000] 1f60: c2089064 08300000 410fc075 10c5387d 00000000
> c039de88 c1e01f9c 00000000
> [    0.000000] 1f80: c1e09980 c1c00420 c1e04ec0 c1e09980 c2089064
> 08300000 410fc075 10c5387d
> [    0.000000] 1fa0: 00000000 c1c00b08 00000000 00000000 00000000
> 00000000 00000000 00000000
> [    0.000000] 1fc0: 00000000 c1cc8a6c 00000000 00000000 00000000
> c1c00420 00000051 10c0387d
> [    0.000000] 1fe0: 00000000 08300000 410fc075 10c5387d 00000000
> 00000000 00000000 00000000
> [    0.000000]  __invoke_psci_fn_smc from 0xc1e01e68
> [    0.000000] Code: bad PC value
>
> Any comments?
>
> Thanks,
> Jagan.
>
