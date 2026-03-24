Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F353F54AC5
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 14:47:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E65983A1B;
	Tue, 24 Mar 2026 15:47:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="e52X/dBZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F370683A41; Tue, 24 Mar 2026 15:46:58 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5329A80087;
 Tue, 24 Mar 2026 15:46:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fgCY93zx7z9tjn;
 Tue, 24 Mar 2026 15:46:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774363613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kL8QZ4tpksOJNS1iMqZWJntHxxWFuzgNnJ8tRqCVyrs=;
 b=e52X/dBZKhMwpeUWJ/5PhMRk3K583A6oQwctv+sRjxEnMINiWRUrx6tCMXZIpxhu/c26I4
 DtNSv78fBswpYT2w+sd35xPB8vRH5yXD3Tjh8Tjd9sqE7ltg6pni2YHEj4/HdET9jP9aXn
 Ka+GzTzSV08ZJ9p4vrsiUk+mF/jGQLwh9Da/Mdw+92DWwcM0D3aArKbgbY9BFtJrkMREHf
 mS0tIvWVoDdTnENsYxspaw89I//0HGh4RV94D4OgFdQBYsWkLpHE5nQaMQkfUlAorku/zb
 XotkTOIdJgdVsKzyrmD9S/TRboNPBPAafhOIMu+h2x4acQvHhMTpsIL0Xn+BxA==
Message-ID: <479db247-4032-4345-a87f-c4c45f29c800@mailbox.org>
Date: Tue, 24 Mar 2026 15:22:13 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Gary Guo <gary@garyguo.net>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Jonas Karlman <jonas@kwiboo.se>, Mark Kettenis <kettenis@openbsd.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, U-Boot <u-boot-bounces@lists.denx.de>
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <177343529761.1131472.9417054395876652663.b4-ty@konsulko.com>
 <DH9MF45X89KK.1CV4WUVTCTUO5@garyguo.net>
 <1e74f277-dedf-4fa1-810d-63f3d517a8a0@mailbox.org>
 <DH9N233GTVKM.2XIG8EETTUQAY@garyguo.net>
 <9bc9a2d3-c1e8-43d5-b03a-c56850c715f3@mailbox.org>
 <CAC_iWjKae0BbP12KofJJTj9W9gYgf0mS5D2+=289XHKHDhmgYw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAC_iWjKae0BbP12KofJJTj9W9gYgf0mS5D2+=289XHKHDhmgYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ipkqpurgoyjwqy45baji7ymmmnzqpn9r
X-MBO-RS-ID: 6a06da3ac77452c497b
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

On 3/24/26 10:48 AM, Ilias Apalodimas wrote:

Hello Ilias,

>> "
>> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
>> index b77c2f980cc..44eccc0cf35 100644
>> --- a/lib/efi_loader/efi_memory.c
>> +++ b/lib/efi_loader/efi_memory.c
>> @@ -475,8 +475,10 @@ efi_status_t efi_allocate_pages(enum
>> efi_allocate_type type,
>>           flags = LMB_NOOVERWRITE | LMB_NONOTIFY;
>>           switch (type) {
>>           case EFI_ALLOCATE_ANY_PAGES:
>> +               addr = map_to_sysmem((void *)(uintptr_t)0xffff0000);
> 
> This kind of breaks the EFI spec. The description in the spec is
> "Allocation requests of Type AllocateAnyPages allocate any available
> range of pages that satisfies the request. On
> input, the address pointed to by Memory is ignored."
> 
> so in theory *addr should be ignored and in fact it's overwritten by
> lmb_alloc_mem(). The reason it works is becase you change the argument
> from _ANY to _MAX below.

Indeed

> I am noit against deviating a bit from the spec as long as we get
> things working and have a long term plan on fixing it properly.
> I'll go through the entire thread and see if there's an easier way out.
The more I am thinking about this, I think what we need are two things:

1) A way to allocate memory at specific addresses / with specific 
constraints (e.g. below 4 GiB, below 1 GiB for the RPi etc.)

2) A generic bounce buffer which would allocate memory with matching 
constraints per driver instance and either copy or data between HW 
accessible and inaccessible memory or set up IOMMU to avoid the copy.

The 1) would enable implementation of 2) as well as allow removal of 
static ethernet packet buffer that is currently built into U-Boot 
binary. If the ethernet packet buffer would be allocated using 1), it 
would allow us to relocate U-Boot to the end of DRAM (there might be 
more such surprises).

The remaining question is, where does 2) go, whether into drivers or 
whether it should be core code that invokes 2) and then passes valid 
buffers to drivers. What you mentioned already, that drivers should 
describe their constraints, would allow the later.

Thoughts ?
