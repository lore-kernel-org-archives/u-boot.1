Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C297DC43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 20:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4CB5849F0;
	Fri,  3 Jul 2026 22:32:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NxbirMmw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A12084A5B; Fri,  3 Jul 2026 22:32:06 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BF31849E5
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 22:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-448479e0eb6so586527fac.2
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 13:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783110723; x=1783715523; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RGVZQkZAOZwZJq4tD9vv2rwC0aT0lQPKtecJoXuksQU=;
 b=NxbirMmwSQ+TVPNREUiejUho+5BVuJ0r7WiLbz/0SVuYGBDSCQdRqMkZdUVX+Nw/LI
 CZvMmg0lZ5Fht0cGlbdJcNtYCXEP6uPe9sozAQ5ysSjwy4badIk+yVZcL0sBwjV/s6E0
 lcD3J4OOkLYNZ3GllQwgl3KsACjKSGkloomHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783110723; x=1783715523;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RGVZQkZAOZwZJq4tD9vv2rwC0aT0lQPKtecJoXuksQU=;
 b=MlKwFzYkeKKEmJD6f0/gk/fBK2MpECamXvkHSGPeG26c5byrVMEsMNYMQIVTuSItcb
 ptYl5W4rfKVTj+IRRk0rVYq2JWFMrsLJnT7RZPTNTGE1zsszzyQmVzxKiDiU0insPfeb
 XgIW0c+zrd8li4qQ7AAytx2OM9rUukgMaQ3VpGk4QyQKXjxWcuGurPOK+wXnGL5r92ov
 3kU+vNgwN5eXAt8UH8xmLZYuam11x0EdyO0mnfQ5uwSiKC1RcJMLLGX0UKd/WX+xysb6
 db6GJ2fHkE6+ZHmwrkhoSB/i0UUUcJy2F6bAUVzxEhnrS0HV711IlVZKfcHW0dIOkvcH
 iM5A==
X-Gm-Message-State: AOJu0YzYbm13FFXhfJTO7lAZEk8JNn6FGayRyG1QgAkyMsBBlgqXbeuP
 XCIJ5lHxUVsPY6BdsmGS/T74jhxX4du95ze/Wp/q/5cTUtnhFXqwCz7CfkDhENWXfAzRkA/1zTG
 hXb69JlM=
X-Gm-Gg: AfdE7cmYslLnk3QUhJ0oO3loctqCipTyFT7kaH1n/dsXdzkcBNig3NAsWhzKKWa3xg6
 fu79OFZpeR1XSokGR84oCAJCRzq7W5/naomFg1Xpgh7++G1FrGjWhUccLrcJlwprcm47QE7RPPe
 1c82GPjXcBljJ4RZdFeAnX/6PzVnO5SteUEiT2ih5+Kei8uvtCbrMBY0cZwHGewp/zLLY5aMA5D
 1/PAvYTzX/nS0+gEaIRgzCpkXf24fegrJ+x5LmHfH+n7aDRFTFnlmsuRkpGzE0SXTwQBRcRZlDy
 w1Bb6+teNSBP94fSRrJhx0lzBud6NH0BKZP8nVvdHQyyPjtHXj9fpz8jYWRjX4y0/1jJ04mGpoz
 XG2JPHF9P8XA4iYBe4LFKf+4HQyIHgj8MbHdvtslO8EL6vtWOgt5EOj/RHexhvGV9V4PFEllwum
 Pg7EJ5toMoEhE+slcOdrpfT6I+m29/4T4gUNoaygxKsMvEL39tZusmZ7wtrwtdQCcLek7rhedU4
 xLuiiJ8xJixMJvHLyDU5PlwD6EzCXoocTW1
X-Received: by 2002:a05:6870:b2cf:b0:448:558e:84ec with SMTP id
 586e51a60fabf-44d184dddf7mr549319fac.38.1783110722866; 
 Fri, 03 Jul 2026 13:32:02 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb1bb17fsm2917874fac.5.2026.07.03.13.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 13:32:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Bryan Brattlof <bb@ti.com>, 
 Vishal Mahaveer <vishalm@ti.com>
Cc: Anshul Dalal <anshuld@ti.com>
In-Reply-To: <20260605193829.395161-1-vishalm@ti.com>
References: <20260605193829.395161-1-vishalm@ti.com>
Subject: Re: [PATCH 0/2] TI: AM64-EVM/SK: Enable MAIN UART1 for SYSFW tracing
Message-Id: <178311072202.3138827.15538957876162646310.b4-ty@konsulko.com>
Date: Fri, 03 Jul 2026 14:32:02 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 05 Jun 2026 14:38:27 -0500, Vishal Mahaveer wrote:

> Collecting SYSFW traces from DMSC firmware is broken on the current
> codebase. These changes enables MAIN_UART1 for collecting SYSFW traces
> when the trace option is enabled in the boardcfg.
> 
> Vishal Mahaveer (2):
>   arm: mach-k3: am642: Update MAIN UART1 serial alias from 3 to 1
>   arm: dts: k3-am642-evm/sk: enable MAIN UART1 for SYSFW logs
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] arm: mach-k3: am642: Update MAIN UART1 serial alias from 3 to 1
      commit: c8a3552f7d9e6bd4554730e3dec10ff6c661f07c
[2/2] arm: dts: k3-am642-evm/sk: enable MAIN UART1 for SYSFW logs
      commit: 48b7c05d272747ec4d8f8f7eb53119ef149dcc7a
-- 
Tom


