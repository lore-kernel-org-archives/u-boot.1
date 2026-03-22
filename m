Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6AED58CAA
	for <u-boot@archiver.kernel.org>; Sun, 22 Mar 2026 22:00:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4749283BE1;
	Sun, 22 Mar 2026 23:00:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Wu3qyS8C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7AC383D71; Sun, 22 Mar 2026 23:00:02 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 865EC8366F;
 Sun, 22 Mar 2026 22:59:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ff9Fp38LFz9sqc;
 Sun, 22 Mar 2026 22:59:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774216798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wv5IsaGRVR1I/n4O6iErxrnmKGKBVQjI4eEZ2k7OD+8=;
 b=Wu3qyS8CSjt6oHduq5w2NgtKsZeJ6PaaTDXcDk0f88VoCpheQG0v6Dgkr4kkCgsh0p1hi5
 N8syDeSZvM/osrztcR4UsyPBfYdTl/G/a2bO37cyHNxOa1TrMgc/zGlTY2kAkEHOoG/xpB
 t3qAyrGp6+C1kr8x/9ugwduVU/6SGoLClB6kvapZs3ly5719jDaJ42/6op8A2ZTPiDT/zL
 gHKsq49I0oYDW3GRjx9yhmdrATt8Gg/cM1XC6D/Nf9DQR2QpEqHDQhAk+syjMo5Pr4vpLo
 sN2c+ibTzLsZ3KhfSeAXCxojuwknEQxsaQ4e++0zH2YQ+aFuwkEJZKKeXJj32g==
Message-ID: <9bc9a2d3-c1e8-43d5-b03a-c56850c715f3@mailbox.org>
Date: Sun, 22 Mar 2026 22:59:53 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
To: Gary Guo <gary@garyguo.net>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Mark Kettenis <kettenis@openbsd.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, U-Boot <u-boot-bounces@lists.denx.de>
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <177343529761.1131472.9417054395876652663.b4-ty@konsulko.com>
 <DH9MF45X89KK.1CV4WUVTCTUO5@garyguo.net>
 <1e74f277-dedf-4fa1-810d-63f3d517a8a0@mailbox.org>
 <DH9N233GTVKM.2XIG8EETTUQAY@garyguo.net>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <DH9N233GTVKM.2XIG8EETTUQAY@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: t9u1d1dot9zymhytzzy3ncwsykk73z9y
X-MBO-RS-ID: a792dec53ef6bab9ca9
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

On 3/22/26 10:45 PM, Gary Guo wrote:

[...]

>> Is your malloc area by any chance above the 4 GiB boundary ? Or how come
>> does EFI allocate pages from above 4 GiB range? It should not be doing
>> that and that is what should be fixed, at least until the DMA32
>> allocator is in place.
>>
>> Please keep in mind, that revering this patch breaks other use cases,
>> like loading into the DRAM above 4 GiB.
> 
> Code in lib/efi_loader uses efi_allocate_pool (in lib/efi_loader/efi_memory.c)
> whenever it allocates, which calls efi_allocate_pages, which calls into
> lmb_alloc_mem. There's no malloc here.
Does something like this make the issue go away ?

"
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index b77c2f980cc..44eccc0cf35 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -475,8 +475,10 @@ efi_status_t efi_allocate_pages(enum 
efi_allocate_type type,
         flags = LMB_NOOVERWRITE | LMB_NONOTIFY;
         switch (type) {
         case EFI_ALLOCATE_ANY_PAGES:
+               addr = map_to_sysmem((void *)(uintptr_t)0xffff0000);
+
                 /* Any page */
-               err = lmb_alloc_mem(LMB_MEM_ALLOC_ANY, EFI_PAGE_SIZE, &addr,
+               err = lmb_alloc_mem(LMB_MEM_ALLOC_MAX, EFI_PAGE_SIZE, &addr,
                                     len, flags);
                 if (err)
                         return EFI_OUT_OF_RESOURCES;
"

If so, then maybe we need a temporary config option which limits the 
EFI_ALLOCATE_ANY_PAGES below 4 GiB on hardware that has DMA limitations.
