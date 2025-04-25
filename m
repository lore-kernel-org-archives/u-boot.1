Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9820C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 10:58:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3737D81F0D;
	Fri, 25 Apr 2025 12:58:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1144F81F54; Fri, 25 Apr 2025 12:58:25 +0200 (CEST)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A517481F0B
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 12:58:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=pengutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=a.fatoum@pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=[127.0.0.1])
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <a.fatoum@pengutronix.de>)
 id 1u8Gl8-0000lx-MF; Fri, 25 Apr 2025 12:58:18 +0200
Message-ID: <842f0cba-b43e-4514-8a15-9b4c87a08104@pengutronix.de>
Date: Fri, 25 Apr 2025 12:58:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Expected behavior of the go command
To: "Kumar, Udit" <u-kumar1@ti.com>, Simon Glass <sjg@chromium.org>,
 Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, rick@andestech.com,
 mporter@konsulko.com, Neha Malcom Francis <n-francis@ti.com>
References: <D9DXL95MTQ8I.3EUY0C6M2L4NE@ti.com>
 <CAFLszTg72Ai2V-L3MKvqDx8ROk97jiW4bvAbvFtZEAFBBp6qfQ@mail.gmail.com>
 <ad4a911f-681a-4fea-b79c-8489b47d7360@pengutronix.de>
 <5934ae86-16e8-4c97-afd6-d812fc0c5f7f@ti.com>
 <5f87ac88-5552-4c5c-ae56-01c7ef9165dd@pengutronix.de>
 <d95b1919-ea47-4d58-8349-82e0f33fed5a@ti.com>
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Content-Language: en-US, de-DE, de-BE
In-Reply-To: <d95b1919-ea47-4d58-8349-82e0f33fed5a@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Udit,

On 4/25/25 12:35, Kumar, Udit wrote:
> On 4/25/2025 11:09 AM, Ahmad Fatoum wrote:
>> Thinking about it, I am wondering whether U-Boot go is inherently broken,
>> even for the jump-table use case, if caches are enabled:
> 
> Correct, this is what I think . Before jumping to new program go command
> should make sure
> 
> things are in correct order by cache flush. Kind of below
> 
> diff --git a/cmd/boot.c b/cmd/boot.c
> index 23496cafdf5..e6bb1d94a1c 100644
> --- a/cmd/boot.c
> +++ b/cmd/boot.c
> @@ -18,6 +18,7 @@ __attribute__((weak))
>  unsigned long do_go_exec(ulong (*entry)(int, char * const []), int argc,
>                                  char *const argv[])
>  {
> +       flush_cache(...)

yes, even with MMU left enabled, it looks like there should be an
I-Cache invalidate and D-Cache flush/clean here[1].

> I see even ARM64, few board choose to over-ride default option (board/
> xilinx/versal/board.c)
> 
> do_go_exec does dcache_disable()

I think __weak is a fundamental mistake and upstream boards abusing it
to not have to fix things generally shows that.

> Sorry I was not clear in previous message,
> 
> Here OS take care of caching , irrespective of how boot is done through fit

Yes, but with the assumption that MMU was disabled at start.

> or kind of efi or other method.

Interestingly, with EFI MMU should be left enabled. Linux even
warns about the case that MMU was disabled when entering the stub.

Cheers,
Ahmad

-- 
Pengutronix e.K.                  |                             |
Steuerwalder Str. 21              | http://www.pengutronix.de/  |
31137 Hildesheim, Germany         | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686  | Fax:   +49-5121-206917-5555 |

