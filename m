Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84631CCF9EB
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 01:36:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B22188B13;
	Thu, 26 Sep 2024 03:36:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727314612;
	bh=Bd8OqEq4u7UNT3y4ARQUC4yyV4F04Ga/2/FhYansASU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ox1H1oBMBrliMUfUdvJnCzAI8J1/ZBaMvrMDv6nBKc26PbKIzDKVF7/g97qsyIwUc
	 NqgzhjWFfsjbYhnqnn35mlxCRztATU74NpQbW/n+D0+AQnvgiYdbn/3CujSA2Xm2LP
	 l66m38Ff0Vy1W7/GwIQr9ZSoB9GfeIrymtTMLki22N9GcH+wrbdhJ7X75zSSo3xRcL
	 P1bIqFdMXesA+k+ZJMM+ZUNdJ7nbFXzLHxRJN5JlzfFhgeqARWFBlKeSHNzY138zpu
	 xXM8hIySTSUchozi9yeeug9sUEDMvIPHSxAKIo4qQwb4180na0FGs5tGy+X1GT3lbR
	 BexBPvqo+dXrQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D8F2488B89;
 Thu, 26 Sep 2024 03:36:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727314611;
 bh=Bd8OqEq4u7UNT3y4ARQUC4yyV4F04Ga/2/FhYansASU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SjCpNbaV3/4xj9oL7/e0wgBnIi0pnREZzI1tQkMLe37uUX8I0X1yLHaYRc+L54WJl
 rY+37DdalFFVJVMEUYT78sxrhBBu1HybW/dZ+ARf0E0xpsq3IWKCynygFTP3JchntR
 nK/zU3WbjvxZCo+nETwqqe5bEWdBzgqvnM0zOcuyir2uszbl0kJECiC872D2KMj10P
 6WqFobOr7kM/GRpZJhQ/wE5ZKlYnuiA1KbttHMyNUKdjLLdUkBmsZyFgQazxmZqnlP
 ianZK7O4SIsQVW2gNgHxcnu+qyUZJG2NGa0chyGQVmrIVKVkFEydEzIovB+WwUozdK
 f2vhEKqYo1Lyw==
Message-ID: <e294ce74-9b77-4de0-b7fc-0d8db9f1226f@denx.de>
Date: Thu, 26 Sep 2024 03:33:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] ARM: dts: socfpga: add Enclustra Intel AA1
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com
References: <20240912060649.190-1-l.rubusch@gmail.com>
 <20240912060649.190-3-l.rubusch@gmail.com>
 <bf99c2bd-f43c-4041-907f-f60b42163cce@denx.de>
 <CAFXKEHbOpv4g5LZ4dkUpwo1OBrRQ7YKZf10=S-2HqMtSK_OE9g@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFXKEHbOpv4g5LZ4dkUpwo1OBrRQ7YKZf10=S-2HqMtSK_OE9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 9/26/24 12:49 AM, Lothar Rubusch wrote:

Hi,

> First of all a huge thank you for the time you spend in reviewing the
> patches so far. This is highly appreciate!!
> 
> 
> On Fri, Sep 13, 2024 at 1:11 AM Marek Vasut <marex@denx.de> wrote:
> [...]
>> Is there any chance to upstream these DTs to Linux first , and then let
>> them all trickle into U-Boot through dts/upstream/ ?
> 
> Preparing the DTS patches for Linux kernel, I noticed I will need the
> handoff setup for u-boot. AFAIK there is currently no single handoff.h
> or handoff.dtsi file in the kernel repo.
> 
> Shall I add the files to my DTS patches and ask for upstreaming of the
> handoff files into the kernel?

Are the handoff files really used by Linux for anything , or do they 
contain various clock/pinmux/DRAM settings only used by U-Boot ? If the 
later, place them into U-Boot and include them from -u-boot.dtsi file.

> Example:
> In specific for u-boot I need a .dts setup like this. Those files are
> currently not in the kernel:
>      #include "socfpga_arria10_mercury_aa1_handoff.h"
>      #include "socfpga_arria10-handoff.dtsi"
>      #include "socfpga_arria10_handoff_u-boot.dtsi"
>      ...
> 
> Since this seems to be common for all socfpga setups (arria10 and
> cyclone5), I guess the situation is already known by a common
> approach. How to deal with this situation in u-boot dts/upstream?
