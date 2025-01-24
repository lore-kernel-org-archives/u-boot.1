Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2420AC02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 16:09:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EB5880AE2;
	Fri, 24 Jan 2025 17:09:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7FFE80A46; Fri, 24 Jan 2025 16:18:32 +0100 (CET)
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A42AF809D2
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 16:18:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=duje.mihanovic@skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
 by mx.skole.hr (mx.skole.hr) with ESMTP id 28B0A831D2;
 Fri, 24 Jan 2025 16:18:30 +0100 (CET)
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje.mihanovic@skole.hr>
To: Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>
Cc: Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/3] arm: mmp: add initial support for PXA1908 SoC
Date: Fri, 24 Jan 2025 16:17:51 +0100
Message-ID: <2765541.mvXUDI8C0e@radijator>
In-Reply-To: <7e92df3b-d37e-4ab3-b76b-b53391e593c1@denx.de>
References: <20241231-coreprimevelte-v2-0-6a5445d92d11@skole.hr>
 <20241231-coreprimevelte-v2-2-6a5445d92d11@skole.hr>
 <7e92df3b-d37e-4ab3-b76b-b53391e593c1@denx.de>
MIME-Version: 1.0
Autocrypt: addr=duje.mihanovic@skole.hr; keydata=
 mDMEZokhzhYJKwYBBAHaRw8BAQdAWJZ0hsI/ytTqHGFV8x6tzd5sB596cTeeDB4CQsTf+wC0KER
 1amUgTWloYW5vdmnEhyA8ZHVqZUBkdWplbWloYW5vdmljLnh5ej6ImQQTFgoAQRYhBG3/QdYN8x
 S1t2umMK0xk1JFj60DBQJmiSHOAhsDBQkJZgGABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAA
 AoJEK0xk1JFj60D1GABAJVSorZdMOlrp/oQtCSH/G53NE56x/JHA8VX+ZQBd/H3AP4/EcUf6eef
 DUxVMh2bdkmuQKsVZGgOGiXpMksrVntWBrQpRHVqZSBNaWhhbm92acSHIDxkdWplLm1paGFub3Z
 pY0Bza29sZS5ocj6ImQQTFgoAQRYhBG3/QdYN8xS1t2umMK0xk1JFj60DBQJmiSH/AhsDBQkJZg
 GABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJEK0xk1JFj60Dlw8A/i4lPOL7NaYoYePDq
 l8MaJaR9qoUi+D+HtD3t0Koi7ztAQCdizXbuqP3AVNxy5Gpb1ozgp9Xqh2MRcNmJCHA1YhWAbg4
 BGaJIc4SCisGAQQBl1UBBQEBB0DEc9JeA55OlZfWKgvmRgw6a/EpBQ8mDl6nQTBmnd1XHAMBCAe
 IfgQYFgoAJhYhBG3/QdYN8xS1t2umMK0xk1JFj60DBQJmiSHOAhsMBQkJZgGAAAoJEK0xk1JFj6
 0DG5MA/iuo4l2GDEZ1Zf+XaS//8FwdXDO9nHkfbV2MHjF4NZXwAQDroMzBdMcqVvc8GABFlTTgG
 j7KrRDz2HwWNyF8ZeprAQ==
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Mailman-Approved-At: Fri, 24 Jan 2025 17:09:55 +0100
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

On Thursday 23 January 2025 13:25:11 Central European Standard Time Stefan 
Roese wrote:
> While building applied on top of latest version,
> I get this error:
> 
> arch/arm/mach-mmp/board.c:55:7: error: conflicting types for
> 'board_fdt_blob_setup'; have 'void *(int *)'
>     55 | void *board_fdt_blob_setup(int *err)
> 
>        |       ^~~~~~~~~~~~~~~~~~~~
> 
> In file included from include/asm-generic/global_data.h:25,
>                   from ./arch/arm/include/asm/global_data.h:113,
>                   from include/init.h:24,
>                   from arch/arm/mach-mmp/board.c:6:
> include/fdtdec.h:1189:5: note: previous declaration of
> 'board_fdt_blob_setup' with type 'int(void **)'
>   1189 | int board_fdt_blob_setup(void **fdtp);
> 
>        |     ^~~~~~~~~~~~~~~~~~~~
> 
> make[1]: *** [scripts/Makefile.build:257: arch/arm/mach-mmp/board.o] Error 1
> make: *** [Makefile:1918: arch/arm/mach-mmp] Error 2
> 
> Could you please have a look and resubmit a fixed version?

Yes, of course. I'll send v3 shortly.

Regards,
--
Duje



