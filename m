Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBD7C369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 14:23:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D94B80944;
	Wed, 23 Apr 2025 16:22:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0833880F9C; Wed, 23 Apr 2025 16:22:58 +0200 (CEST)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A03E8803DF
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 16:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=pengutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=a.fatoum@pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=[127.0.0.1])
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <a.fatoum@pengutronix.de>)
 id 1u7b02-0006ap-IU; Wed, 23 Apr 2025 16:22:54 +0200
Message-ID: <ad4a911f-681a-4fea-b79c-8489b47d7360@pengutronix.de>
Date: Wed, 23 Apr 2025 16:22:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Expected behavior of the go command
To: Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, rick@andestech.com,
 mporter@konsulko.com
References: <D9DXL95MTQ8I.3EUY0C6M2L4NE@ti.com>
 <CAFLszTg72Ai2V-L3MKvqDx8ROk97jiW4bvAbvFtZEAFBBp6qfQ@mail.gmail.com>
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Content-Language: en-US, de-DE, de-BE
In-Reply-To: <CAFLszTg72Ai2V-L3MKvqDx8ROk97jiW4bvAbvFtZEAFBBp6qfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: u-boot@lists.denx.de
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

On 4/23/25 14:28, Simon Glass wrote:
> Hi Anshul,
> 
> On Wed, 23 Apr 2025 at 04:04, Anshul Dalal <anshuld@ti.com> wrote:
>>
>> Hi all,
>>
>> I was trying to understand how the go command is expected to work when
>> used to load custom OSes. My use case requires getting a proprietary OS
>> to boot using the go command on a TI K3 platform. The OS expects caches
>> to be flushed and the mmu to be disabled before we jump to it.
>>
>> The go command (do_go func in cmd/boot.c) calls the do_go_exec function
>> underneath which does not seem to have a consistent implementation
>> across various architectures.
>>
>> In RISC-V the implementation (arch/riscv/lib/boot.c:10) calls
>> cleanup_before_linux before jumping to the loaded binary. This behaviour
>> would enable the direct use of the go command for booting a custom OS
>> (like in my use case). Though no such generic implementation exists for
>> ARM64.
>>
>> I was wondering why we have the call to cleanup_before_linux for RISCV
>> and not ARM64?
>>
>> Also, is booting a custom OS using the go command a supported use-case?
>> If yes, it might be better to rename the function to be more generic
>> like cleanup_before_os from *_linux and call it for each invocation of
>> the go command.
> 
> Yes it is supposed to do what you say. You could rationalise the code
> a bit, so that all archs do a similar thing, or perhaps just RISC-V
> and ARM for now.

I ran into issues with go too trying to start barebox and I always
assumed that go is rather meant to start programs that call back into
U-Boot using the jump table mechanism. In that case, you likely don't
want to turn off caches.

What I settled on is having the barebox build generate a FIT image that
can be used from U-Boot, barebox, coreboot ...etc.

Maybe the same would be also suitable for you? Alternatively, you could
compile your custom OS as an ELF image and boot that properly as if it
were a kernel. Both ways would also allow you to specify a load address
if your OS is not relocatable and pass along arguments.

I went with the FIT route for barebox, because we can now ship device
trees for all enabled boards in the same FIT image alongside one generic
second stage barebox with DT support. If you want to support different
boards with your OS image that might be of interest to you as well.

Cheers,
Ahmad

> 
> Regards,
> Simon
> 

-- 
Pengutronix e.K.                  |                             |
Steuerwalder Str. 21              | http://www.pengutronix.de/  |
31137 Hildesheim, Germany         | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686  | Fax:   +49-5121-206917-5555 |

