Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FFDC02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 13:50:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 132268063E;
	Sat, 18 Jan 2025 14:50:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="s521iGmz";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Rrrm4+0j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B73080657; Sat, 18 Jan 2025 14:50:55 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 607FB80312
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 14:50:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YZyg06q6jz9sdR;
 Sat, 18 Jan 2025 14:50:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737208253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JIEtfDs6xE/MkYG3xzLauIIMe/DbJsGRUWTTK+vWUEA=;
 b=s521iGmzdqQN9DaF59hDu7f/guD7wvOBDxzeaH3whcU1rip9LSqTD/CaP5m7T9f1p8q9T8
 hSF7az9bIrQ9dGGQFyEtpv9d8KBipkP9CRTFAf/4xX2YSom2uCl3oc9VUsqEL/Bu0zAQfb
 zJoJIN3ylDsdqNq1knY1PKufU2d+Q55G5SJjfQ4zQEZX02yWLTJ7sYjczzpHJ4vVDA4+Cp
 gUDswzwPVd7+/w7fL2SRBVHWyfp3x05bTNHwo/yj7o/h2kW7fuk72ej5KJPta+EJQN5o89
 wy+ZhX6SKhtl4o0zKNq//Q0SXwc4Svx4MufHan1njTJyhqOGtNEm5RmoKKt6mg==
Message-ID: <689efebe-902c-4dbe-9af4-f2949df5bf5e@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737208251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JIEtfDs6xE/MkYG3xzLauIIMe/DbJsGRUWTTK+vWUEA=;
 b=Rrrm4+0j2aux1H1Dq/TR4d5WgXEZgFv3rtKbVlSs9XnY5ezzUPQZRXTi3exbSSS6WFavpJ
 A8M8TuzPeRPfqpK4asI+gRJFMT0AMo+STVGwHR1QGyQiRL40GHMxjzf9zRgs1phe1IVuS1
 UkAFkAT2SCFsMZ5LgquDkHUBsnZaZq47kVcVkDoMFCP/18Cwfu4C6r0+zKLKDdOI320Squ
 30xwbEZQ5ONaQkoYjWOeIe7TdYITl7g1tCugj+aPoR/5088E7QBxQHI3+agT3ozV6lvI/E
 siy7L87RaASqLnIEQMpvaUXr3Itx+cdbg5M4RvEdcGefk+ZxHamftobCdCuKmA==
Date: Sat, 18 Jan 2025 14:49:06 +0100
MIME-Version: 1.0
From: Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [PATCH 2/3] image: Add support for starting TFA BL31 as fitImage
 loadables
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250112223755.179959-1-marek.vasut+renesas@mailbox.org>
 <20250112223755.179959-2-marek.vasut+renesas@mailbox.org>
 <TY3PR01MB113468B93D55B10C9D38ABFAE861F2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <4dddca99-dcc2-411e-af9a-b27115e60efa@mailbox.org>
 <TY3PR01MB1134659D36AECF2B84B772B05861F2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <920265f4-4fdd-4c8c-a01c-bac9b9aafd9e@cherry.de>
Content-Language: en-US
In-Reply-To: <920265f4-4fdd-4c8c-a01c-bac9b9aafd9e@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 07f52a2d6078d8af3d0
X-MBO-RS-META: 6nh8dqepw9toacyorjdu6duz7jiame8h
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

On 1/15/25 12:51 PM, Quentin Schulz wrote:
> Hi Marek, Biju,

Hi,

[...]

>>> See 3/3 , U-Boot runs in EL3 , before starting kernel it jumps into TFA
>>> BL31 , TFA BL31 does its setup and switches from EL3 to EL2 , TFA 
>>> BL31 returns to U-Boot
>>> armv8_switch_to_el2 which checks if this code is running in EL2 (it 
>>> is) and does the last few steps
>>> before starting kernel, and then finally jumps to the kernel .
>>
>> Thanks for the explanation. I missed the details in 3/3.
>>
>> BL2(Secure)->U-boot(Secure)->BL31(Secure)-->U-boot(Normal)->Linux 
>> Kernel(Normal)
>>
> 
> If the fit image is missing the TF-A loadable property for example (and 
> maybe in other corner case scenario?) the kernel will start in EL3 
> though and fail very early since it needs TF-A BL31 for a few things. 

Not quite, even if the TFA loadable is not present, the kernel will 
still be started through armv8_switch_to_el2() , which will switch the 
core into EL2 and then start the kernel. The kernel will however likely 
fail to boot because it will attempt to access PSCI via SMC and there 
will be nothing there, so it will fail at that point.

There will be a follow up patch for R-Car Gen4, which will extend and 
enable the current minimal R-Car Gen4 PSCI support in U-Boot, so even if 
you do not bundle TFA into the fitImage, the kernel won't fail to boot 
entirely.

With the current R-Car Gen4 PSCI implementation in U-Boot, the kernel 
can boot and run on a single CPU core only, because the CPU core start 
and stop callbacks are not implemented and not advertised to Linux yet.

Any other SoC that would like to move TFA start after U-Boot start would 
also likely have to implement at least minimal PSCI implementation to 
provide a safety net for users who do not bundle the TFA BL31 PSCI 
provider blob into the fitImage for some reason. The current R-Car Gen4 
PSCI implementation is generic enough, that it can act as a template for 
such other future SoC specific PSCI implementations.

> However, part of the kernel code will actually run in EL3 and that could 
> be enough to mess things up with a carefully crafted kernel image.
> 
> Is this actually possible or am I making stuff up? If it is possible, 
> isn't that an issue?
> 
> Currently, this is already possible and has happened a few times already 
> at my company with people forgetting to bundle TF-A in U-Boot and then 
> the kernel would boot but stops early (no console output even IIRC). But 
> the bootloader is not THAT often updated in the field compared to kernel 
> (especially if coming from distros) which would now allow to store the 
> TF-A, so this opens an even bigger can of worms?

See above, I think that answers this question.

> In a way, it allows to 
> update TF-A likely more securely

That is very much the point of this, yes.

Also, safely update as much as possible in lockstep, for example in case 
someone has the idea to extend the TFA PSCI implementation with custom 
SMC call handler(s) and make vendor Linux kernel fork depend on those 
custom SMC calls for something (*). If the next kernel fork depends on a 
different set of custom SMC calls (because stable ABI in such cases may 
not be a guarantee) then updating only the kernel may lead to unbootable 
system. Worse, updating the bootloader and kernel may lead to kernel 
boot failure, AND if (usually seldom updated) recovery system kernel did 
not get updated in lockstep with bootloader, recovery system which 
depends on the old SMC ABI would also fail to boot, leaving the system 
unrecoverable.

If both kernel and the custom TFA implementation are updated and booted 
as part of the same fitImage file, the ABI problem goes away.

Also, it allows for easy experimentation with the TFA, you can keep 
swapping blobs in and out as needed to test them out.

(*) This is not the case with Renesas to my knowledge , whew !

> (which is VERY welcome on Rockchip for 
> example, where we usually start new SoC bringups with a blob from 
> Rockchip and then have upstream TF-A catch up a few years later. Having 
> BL31 part of U-Boot is a huge pain because it is difficult for some 
> devices to do safe updates of U-Boot) but may introduce some bigger 
> security issues?

U-Boot will run in EL3 instead of EL2 in this case, which gives it 
complete unrestricted access to the entire system. It can act as a debug 
tool, the way it was designed to work since the very beginning.

Do you have anything specific in mind here ?

> Finally, another question, what happens if we have a U-Boot with bundled 
> TF-A BL31 AND it tries to boot a fitimage with a TF-A BL31 loadable? 

It very much depends on the SoC specific TFA BL31 start handler 
implementation (see patch 3/3). It is possible to add check in there to 
test whether the system is already running in EL2 for example, and if 
anything responds to PSCI version SMC call, and if so, skip starting the 
TFA again.

I don't think TFA BL31 can be started in EL2 in any case.

> Should we only allow to load tf-a BL31 if running from EL3 (meaning if 
> in EL2, TF-A is expected to be already running)?

That's for the SoC specific handler to decide, see above.

-- 
Best regards,
Marek Vasut
