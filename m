Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A3ECD6E49
	for <u-boot@archiver.kernel.org>; Sat, 30 May 2026 14:23:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1549F846E6;
	Sat, 30 May 2026 16:23:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Vtf+VImm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D143846E6; Sat, 30 May 2026 16:23:05 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5650846B4;
 Sat, 30 May 2026 16:23:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gSMrk03Gzz9ts1;
 Sat, 30 May 2026 16:23:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780150982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U5iHI4i6K/nngbGoJQdYB0191kjVz/MkInxgJErYauc=;
 b=Vtf+VImmjFsOhLrOTitYABJ+ZyRMECgX6L00xh71fmjpyomoTZWFh4SB2jA64BLNR6UQil
 Ovn/pqU5wkzgDDqNvwRWERkp4qIJUH4XkZgUK5rCMeC1wDyo0tV53lznRUqPZKYDohdbD2
 2ZjyqTwy0OFSipO0p1Xhtvyq8yKUFbNuq4Qc5y1WYMHdd5HBAbkuwsI0U/9rg/KlKaVg4k
 A2C/ZeKPEVeCUbQlAM7URvEqkAemTUJ+iN9OmcMNELphNfqTvdA7bigWhWzvoN9Wf+2TU8
 EtK9sMGdXad5iQul8XboZQJpZEYCkNE3o5tz8h50+jUHnuT1VdUol0BkRrkx2A==
Message-ID: <4829e3fd-7db1-496e-92f3-826728283e57@mailbox.org>
Date: Sat, 30 May 2026 16:22:56 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Gary Guo <gary@garyguo.net>,
 u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
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
 <CALeDE9PARyt0iUvnfbSfz=rSA2RkQ1AcoaJpU=8RgnYivaPNEA@mail.gmail.com>
 <20260529154446.GC627328@bill-the-cat>
 <CALeDE9MAE6r3pFzNRDbwAXkkkWrZo_0gXEMTavmpnGjQBoxrVQ@mail.gmail.com>
 <c9e810ac-6c0e-4a66-bbae-d6557a26197b@mailbox.org>
 <CALeDE9OzEf2RHZSP047hOd4UzikcUpDfTBo0JNFjy8vMZ912Hg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CALeDE9OzEf2RHZSP047hOd4UzikcUpDfTBo0JNFjy8vMZ912Hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 9488bce8e2271d6bcd7
X-MBO-RS-META: 5fisq568xjhimj34t3o558d44f38nes1
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

On 5/30/26 3:44 PM, Peter Robinson wrote:

>> The revert is wrong as that breaks other things , like use of DRAM above
>> 4 GiB boundary, which is exactly why this change was implemented. If RPi
>> has limitations, then those limitations should be imposed on RPi, not
>> globally, so add the LMB reservations on RPi.
> 
> I have no idea how LMB works so please send a patch that does that.

Try this:

// Enable CONFIG_LMB_ARCH_MEM_MAP=y

#include <lmb.h>

void lmb_arch_add_memory(void)
{
	int i;
	phys_addr_t bank_end;
	phys_size_t size;
	u64 ram_top = gd->ram_top;
	struct bd_info *bd = gd->bd;

	/* Assume a 4GB ram_top if not defined */
	if (!ram_top)
		ram_top = 0x100000000ULL;

	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
		size = bd->bi_dram[i].size;
		bank_end = bd->bi_dram[i].start + size;

		if (size) {
			/*
			 * Reserve memory above ram_top as
			 * no-overwrite so that it cannot be
			 * allocated
			 */
			if (bd->bi_dram[i].start >= ram_top)
				lmb_reserve(bd->bi_dram[i].start, size,
					    LMB_NOOVERWRITE);
			else if (bank_end > ram_top)
				lmb_reserve(ram_top, bank_end - ram_top,
					    LMB_NOOVERWRITE);
		}
	}
}
