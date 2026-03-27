Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED7D10AB830
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 14:25:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E97183C5E;
	Fri, 27 Mar 2026 15:25:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=iki.fi header.i=@iki.fi header.b="Ve+lJUTK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B072483EB3; Fri, 27 Mar 2026 15:25:08 +0100 (CET)
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5911E83C14
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 15:25:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marko.makela@iki.fi
Received: from kehys.lan (dsl-hkibng22-54f98f-8.dhcp.inet.fi [84.249.143.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: msmakela)
 by meesny.iki.fi (Postfix) with ESMTPSA id 4fj2wc6flpzyRf;
 Fri, 27 Mar 2026 16:25:04 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
 t=1774621505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8JIXmnfV6huFcLPLFHJYqfQCAVLBE3aTa/Ys246br1k=;
 b=Ve+lJUTKeTj1IQt4lbsDmxjZwOwshMDmVy/SNb32MUitsjit3xDFl3/W+x/WQOJS1SnBlQ
 7ROWwxGWInIBgxpwrUADLGC2FJwnj44fi7Ifn070Wk4u5/zPY30okKLfAURHdC6+xqXg4q
 3VycvmS7cX97wrq8GXfZ89oCtsZtFZg=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774621505;
 b=JdwQRPuuvZVdHaOxhPf4ufZgYe6+sv7MuykVYyfGuHWUkMoHJLmAeTEX73AWjHbqAWC/nB
 7LEtrcugiyDO92mloY4dTm3cq4CXPV8AxcFC+dM/EdGOQv6ZADaSldwknrooY5R1QdQnxL
 IJgHLitWoWSQoODMkc4MP1IsTvHwzrI=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=msmakela smtp.mailfrom=marko.makela@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
 s=meesny; t=1774621505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8JIXmnfV6huFcLPLFHJYqfQCAVLBE3aTa/Ys246br1k=;
 b=hUMBp5yGeIVQg+L8TpKqU9Rem+KywAq+CwA67rzoKN/3xyH7JuHWW8QWNa8PSJtiLd6XzS
 nv4e+srDY6U3olyDiRAtJoGRU8BjfQmG7SZXNs4BgcETxSIG8g/pgS3OD6kojRoBAURM9M
 N5Vy6OYNRfz+r9t0CKEe93/uQxjTtO8=
Date: Fri, 27 Mar 2026 16:25:03 +0200
From: Marko =?iso-8859-1?B?TeRrZWzk?= <marko.makela@iki.fi>
To: Randolph Sapp <rs@ti.com>
Cc: Robert Nelson <robertcnelson@gmail.com>,
 Erik Welsh <Erik.Welsh@octavosystems.com>,
 Anshul Dalal <anshuld@ti.com>, bb@ti.com, nm@ti.com,
 trini@konsulko.com, afd@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] k3-am62-pocketbeagle2: add initial board support
Message-ID: <acaTPyGbaUQj7hk3@kehys.lan>
References: <20260317223800.776581-1-rs@ti.com>
 <20260317223800.776581-3-rs@ti.com>
 <DH7I5D8U3GQX.1NAV7HTPAAJ8L@ti.com>
 <CAOCHtYhr50ywU_ar6qFPYrwJeUbjE+GQC_OYO_W4Pc5A9iJ5-w@mail.gmail.com>
 <DHAEYEEVEBW7.304SKN4GDBP4B@ti.com>
 <CAOCHtYgan-p8PiuwKCPmDY=xaKvnGc+F1OZXgyDHFGg4F9NJ1Q@mail.gmail.com>
 <DHCAJ6L5XC77.9F2NK2OOEAT5@ti.com>
 <DHD3N5DPHPVI.159WWX3H4U3Q3@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <DHD3N5DPHPVI.159WWX3H4U3Q3@ti.com>
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

Thu, Mar 26, 2026 at 06:23:20PM -0500, Randolph Sapp wrote:
[snip]
>Alright, looking into the allocation helpers it seems that
>EFI_CONVENTIONAL_MEMORY can be remapped in efi_allocate_pages so long as LMB
>agrees that it's free. This aligns with my understanding of the UEFI spec as
>well. I dumped the EFI memory map and noticed there were 2 fragmented sections
>of EFI_CONVENTIONAL_MEMORY that it could still use.
>
>Wired up efi_allocate_pages to go to those regions and attempt to allocate from
>there in the even an LMB_MEM_ALLOC_MAX or LMB_MEM_ALLOC_ANY start failing. Seems
>to have worked, but now I'm seeing the following reported in the kernel:
[snip]

I can't help with that, but I hope that someone can. Because I intend to 
work on improvements related to secure boot and FIT verification, having 
this board working in the current u-boot would be really great. I'm 
looking forward to test a revised patch set.

Coincidentally, I just got a PocketBeagle 2 yesterday. It took a while 
for me to find some useful u-boot source code. I came across 
https://github.com/beagleboard/u-boot/commit/64be5e474943dc5c6e6e01edc124ff6f53f616a4 
which is a few changes ahead of u-boot:

64be5e47494 arm: dts: k3-am62-r5-pocketbeagle2: remove chosen uart override
e1207aad9b0 arm: dts: k3-am62-pocketbeagle2: add boot phase flag to uart6
23f9fc5d6da arm: mach-k3: am62: add &main_uart6 to clock and pwr tree
156a9bb1410 add: k3-am62-pocketbeagle2

On a merge to the current u-boot master, I discarded a change to 
k3_get_a53_max_frequency(void) by 156a9bb1410 because that function has 
been replaced with am62p_map[]. In that array, the clock rates for the 
speed grades S,T,U,V would conflict with patch. I don't expect this to 
be essential, but I thought that I would mention it because there were 
no adjustments to the speed grade in this patch set.

With best regards,

	Marko
