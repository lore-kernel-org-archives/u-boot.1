Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A63CAC5A5
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 12:33:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 401C9834D4;
	Wed, 24 Sep 2025 14:33:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="E4UCjgno";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D512E834D4; Wed, 24 Sep 2025 14:33:00 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90B1880107
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 14:32:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4631=4E=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1758717175;
 bh=PUKrNBBhNaKpITt2dUwC9KxXGXhUF0cl9gLwmE6/UMU=;
 b=E4UCjgnoOKbvh8NhHH9jglo7ZMovuiQp0sPUjvmexAqSrkEj5UVNbnxSKl36g+zOLmQnBoOWU
 K1wKHwTtLQLdXg/vcW2LWpxZIWsej7v4NK9fqQqcF4v8IMrQi/AUuI08DWxyPuxv+OKAew3icsD
 MF3Pdab/qO0z9dMdDSJB5pma+j7GRLaXqbvzP7URNnr/AXg+/+Sg+BcixdMr862/zDHQnXG3rDB
 KBjFgLgz2HfNBAFsosJnCFUhGv8L4xUGjpP+jp+mspGINGldXujYYPKOVryVNORutyMeXjtlz/L
 2a8G8LYG/QXnGuOwpMEN7ohnZua/DPS6cLTCPIOJsr4Q==
X-Forward-Email-ID: 68d3e4f2ec0117678dfc4567
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.2.14
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <cf85516f-3985-4f53-bc61-6481446a5a19@kwiboo.se>
Date: Wed, 24 Sep 2025 14:32:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] doc: binman: Add guidance for determining ELF load
 addresses
To: Aristo Chen <jj251510319013@gmail.com>
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 al.kochet@gmail.com, paul.henrys_ext@softathome.com, bb@ti.com,
 y.moog@phytec.de, w.egorov@phytec.de, francesco.dolcini@toradex.com,
 ggiordano@phytec.com, n-francis@ti.com, afd@ti.com, d.schultz@phytec.de,
 d-gole@ti.com, ravi@prevas.dk, carlos.lopezr4096@gmail.com,
 quentin.schulz@cherry.de, alice.guo@nxp.com,
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.denx.de
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20250914110021.4103-8-aristo.chen@canonical.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250914110021.4103-8-aristo.chen@canonical.com>
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

On 9/14/2025 12:59 PM, Aristo Chen wrote:
> Add documentation to help users understand how to determine where ELF
> files will be loaded when using binman's 'fit,load' property. This
> addresses the common confusion about how load addresses are determined
> from ELF files.
> 
> The documentation explains three methods:
> 1. Using readelf to examine program headers
> 2. Checking the linker script (.lds file)
> 3. Using objdump to see section addresses
> 
> Also includes a specific example from binman tests showing how
> elf_sections.lds sets ATF load address to 0x00000010 and
> elf_sections_tee.lds sets TEE load address to 0x00100010 to avoid
> memory overlap conflicts.
> 
> This helps users debug memory layout conflicts more efficiently when
> working with FIT images containing multiple ELF components.
> 
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> ---
>  tools/binman/entries.rst | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
> index 12a39d070e4..f6a5465ca44 100644
> --- a/tools/binman/entries.rst
> +++ b/tools/binman/entries.rst
> @@ -1050,6 +1050,24 @@ split-elf
>          Generates a `load = <...>` property with the load address of the
>          segment
>  
> +        Note: The load address comes from the ELF file's program header or
> +        linker script. To determine where an ELF file will be loaded, you can:
> +
> +        1. Use readelf to examine the program headers:
> +           ``readelf -l your_elf_file.elf``
> +           Look for the LOAD segments and their VirtAddr (Virtual Address)
> +
> +        2. Check the linker script (.lds file) used to build the ELF:
> +           Look for the `. = <address>;` statements which set the location
> +           counter and determine load addresses for different sections
> +
> +        3. Use objdump to see section addresses:
> +           ``objdump -h your_elf_file.elf``
> +
> +        For example, in binman tests, elf_sections.lds sets ATF load address
> +        to 0x00000010, while elf_sections_tee.lds sets TEE load address to
> +        0x00100010 to avoid memory overlap conflicts.

tools/binman/entries.rst should be generated from a "binman entry-docs"
run as described in the documentation [1].

Please update tools/binman/etype/fit.py or this will be lost next time
someone updates the entries documentation.

[1] https://docs.u-boot.org/en/latest/develop/package/binman.html#entry-documentation

Regards,
Jonas

> +
>      fit,entry
>          Generates a `entry = <...>` property with the entry address of the
>          ELF. This is only produced for the first entry

